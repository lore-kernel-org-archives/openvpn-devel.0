Message-ID: <4F72CE7E.90704@...1114...>
Date: Wed, 28 Mar 2012 10:40:30 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
	<1332797200-9295-7-git-send-email-alon.barlev@...277...>
In-Reply-To: <1332797200-9295-7-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 6/6] cleanup: ~0 is too large for 32bit
 ipv4 address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/03/12 23:26, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- 
> src/openvpn/route.c |    2 +- 1 files changed, 1 insertions(+), 1
> deletions(-)
> 
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c index
> bf7af63..608403b 100644 --- a/src/openvpn/route.c +++
> b/src/openvpn/route.c @@ -268,7 +268,7 @@ init_route (struct route
> *r, const struct route_option *ro, const struct route_list *rl) { -
> const in_addr_t default_netmask = ~0; +  const in_addr_t
> default_netmask = 0xffffffff;

Please can you explain more in detail why this change is needed?  In my
perspective, using ~0 is safer as it will always set all bits - no matter
the size of default_netmask.

And there are many more places in in source code where ~0 is used to
provide that netmask.  I would like to see some consistency, rather to
just fix warnings which appears on some platform(s).

In general, if you can provide a more verbose description why the patch
is written in the commit messages, it will also help the review process.
 Most of us are not that skilled in reading others mind ;-)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9yznwACgkQDC186MBRfrrt9ACfbubdsMWzvKQnav6pQxyOXYwM
8XoAn1jCoLOQO6PS4TfBE+1YiNGeCm+U
=ABwa
-----END PGP SIGNATURE-----

