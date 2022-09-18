Content-Type: multipart/alternative;
 boundary="------------60HzNyvEJdvjFa3dqEfG0N0I"
Message-ID: <ad48914b-d0a9-5267-1b27-b6120c3f4d07@...1227...>
Date: Sun, 18 Sep 2022 12:51:14 +0200
MIME-Version: 1.0
References: <CAJXQW9Vzf_ypQGSez8X96imiy2Hat0buoY2fp3gmsYs1EXdcpg@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAJXQW9Vzf_ypQGSez8X96imiy2Hat0buoY2fp3gmsYs1EXdcpg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Allow DNS autoconf by passing hostname
 by IV variables when using push-peer-info
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ricardo Manriquez <ricardo.manriquez@...277...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------60HzNyvEJdvjFa3dqEfG0N0I
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit


Am 18.09.2022 um 03:23 schrieb Ricardo Manriquez:
> Author: Ricardo Manríquez <ricardo.manriquez@...277...>
>
> To enable the possibility of DNS autoconfiguration the IP address and 
> hostname of the client are needed to register at the DNS level, this 
> patch adds this information when using push-peer-info.
>
> The motivation is that the domain name is as intrusive as the MAC 
> address and DNS autoconfiguration is helpful to be able to communicate 
> back to the clients, this generates a problem when the client connects 
> to the network directly and then uses the VPN connection, now the DNS 
> records do not match and when using remote assistance or remote 
> management tools the benefits of DNS are negated.

Could you expain why this needs to be in OpenVPN itself and cannot be 
done with something like starting openvpn with an additional parameter 
like --setenv UV_HOSTNAME "$(hostname)" or derived from another 
parameter/variable from the client like CN, username etc? Space in the 
packet carrying IV_/UV_ variables is already limited and I am not sure 
if spending another 64 for the hostname is a good thing.


> ---
>   src/openvpn/ssl.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 80e0d5acb4..3031566585 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2321,6 +2321,11 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
>               {
>                   buf_printf(&out, "IV_HWADDR=%s\n", format_hex_ex(rgi.hwaddr, 6, 0, 1, ":", &gc));
>               }
> +
> +            char hostname[64];
> +            gethostname(hostname, 63);
> +            buf_printf(&out, "IV_HOSTNAME=%s\n", hostname );
Isn't there a MAX_HOSTNAME define or similar instead of hardcoding 64 here?

The handling of the string of hostname is not very well here. The man 
page of the function (gethostname(2) - Linux manual page (man7.org) 
<https://man7.org/linux/man-pages/man2/sethostname.2.html>) says null 
termination is not guaranteed for long hostnames.


> +
>               buf_printf(&out, "IV_SSL=%s\n", get_ssl_library_version() );
>   #if defined(_WIN32)
>               buf_printf(&out, "IV_PLAT_VER=%s\n", win32_version_string(&gc, false));
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
--------------60HzNyvEJdvjFa3dqEfG0N0I
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Am 18.09.2022 um 03:23 schrieb Ricardo
      Manriquez:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJXQW9Vzf_ypQGSez8X96imiy2Hat0buoY2fp3gmsYs1EXdcpg@...278...">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>Author: Ricardo Manríquez &lt;<a
            href="mailto:ricardo.manriquez@...277..."
            moz-do-not-send="true" class="moz-txt-link-freetext">ricardo.manriquez@...277...</a>&gt;
        </div>
        <div><br>
        </div>
        <div>To enable the possibility of DNS autoconfiguration the IP
          address and hostname of the client are needed to register at
          the DNS level, this patch adds this information when using
          push-peer-info.</div>
        <div><br>
        </div>
        <div>The motivation is that the domain name is as intrusive as
          the MAC address and DNS autoconfiguration is helpful to be
          able to communicate back to the clients, this generates a
          problem when the client connects to the network directly and
          then uses the VPN connection, now the DNS records do not match
          and when using remote assistance or remote management tools
          the benefits of DNS are negated.<br>
        </div>
      </div>
    </blockquote>
    <p>Could you expain why this needs to be in OpenVPN itself and
      cannot be done with something like starting openvpn with an
      additional parameter like --setenv UV_HOSTNAME "$(hostname)" or
      derived from another parameter/variable from the client like CN,
      username etc? Space in the packet carrying IV_/UV_ variables is
      already limited and I am not sure if spending another 64 for the
      hostname is a good thing.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAJXQW9Vzf_ypQGSez8X96imiy2Hat0buoY2fp3gmsYs1EXdcpg@...278...">
      <div dir="ltr">
        <div>
          <pre>---
 src/openvpn/ssl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 80e0d5acb4..3031566585 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2321,6 +2321,11 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
             {
                 buf_printf(&amp;out, "IV_HWADDR=%s\n", format_hex_ex(rgi.hwaddr, 6, 0, 1, ":", &amp;gc));
             }
+
+            char hostname[64];
+            gethostname(hostname, 63);
+            buf_printf(&amp;out, "IV_HOSTNAME=%s\n", hostname );</pre>
        </div>
      </div>
    </blockquote>
    Isn't there a MAX_HOSTNAME define or similar instead of hardcoding
    64 here?<br>
    <p>The handling of the string of hostname is not very well here. The
      man page of the function (<a
        href="https://man7.org/linux/man-pages/man2/sethostname.2.html">gethostname(2)
        - Linux manual page (man7.org)</a>) says null termination is not
      guaranteed for long hostnames.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAJXQW9Vzf_ypQGSez8X96imiy2Hat0buoY2fp3gmsYs1EXdcpg@...278...">
      <div dir="ltr">
        <div>
          <pre>
+
             buf_printf(&amp;out, "IV_SSL=%s\n", get_ssl_library_version() );
 #if defined(_WIN32)
             buf_printf(&amp;out, "IV_PLAT_VER=%s\n", win32_version_string(&amp;gc, false));</pre>
        </div>
      </div>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
    </blockquote>
  </body>
</html>

--------------60HzNyvEJdvjFa3dqEfG0N0I--

