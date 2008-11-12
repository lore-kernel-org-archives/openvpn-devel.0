Date: Wed, 12 Nov 2008 14:36:57 +0100
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20081112133657.GA15988@...33...>
References: <200810271301.m9RD1BKT006709@...1141...>
	<200811121224.mACCOmfd077621@...1141...>
MIME-Version: 1.0
In-Reply-To: <200811121224.mACCOmfd077621@...1141...>
Subject: Re: [Openvpn-devel] [patch] enhance compatibility with
	HTTP/1.1	proxies
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, 12 Nov 2008, Frank Behrens wrote:

> James Yonan <jim@...41...> wrote on 4 Nov 2008 12:16:
> > Shouldn't you check p->options.http_version and make sure it's >= 1.1 
> > before sending the Host header?

> Here is a revised patch, that works for me and implements your 
> suggestion:

Sorry Frank,

I have to object. It does not implement James's suggestion as you claim,
but random guesswork - inadequate for security software and prone to
breaking at later updates.

> --- proxy.c.orig	2008-10-06 09:22:20.000000000 +0200
> +++ proxy.c	2008-11-06 20:49:55.000000000 +0100
> @@ -348,6 +348,14 @@ establish_http_proxy_passthru (struct ht
>    if (!send_line_crlf (sd, buf))
>      goto error;
>  
> +  /* send Host: header for HTTP version above 1.0 */
> +  if (strcmp(p->options.http_version, "1.0") != 0) {

This doesn't check for ">= 1.1", but "!= 1.0".
What if I use 0.9, or garbage, or nothing?
Oops, you lose -- in either case.

Even if it's a user option and it's their own fault for misconfiguring.

At the very very least, it'll go along these lines (untested and without
reading how http_version is obtained and if additional checks are
sensible!). Note this may fail with HTTP/2.X or newer, since new major
versions are free to interpret existing headers in a different way, but
since that's neither existent nor implement, let's not care today, but
let's not throw obstacles for later use...


    int rc,
    unsigned int major, minor;

    rc = sscanf(p->options.http_version, "%u.%u", &major, &minor);
    if (rc == 2) {
      switch (major) {
        case 1:
          if (minor >= 1) {
              /* HTTP/1.1 or newer, use Host: header */
          } else {
              /* HTTP/1.0 or HTTP/0.9 */
          }
          break;
        default:
          /* unsupported, complain and terminate */
      }
    }

You may want to accept only 1.0 and 1.1 rather than 1.0 and 1.n for n >= 1
- but there should only ever be A SINGLE PLACE to enforce that.

Else you'll have a hell of work once you start implementing HTTP/1.2
later on...

-- 
Matthias Andree

