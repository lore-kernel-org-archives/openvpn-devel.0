MIME-Version: 1.0
From: Ricardo Manriquez <ricardo.manriquez@...277...>
Date: Sun, 18 Sep 2022 10:23:14 +0900
Message-ID: <CAJXQW9Vzf_ypQGSez8X96imiy2Hat0buoY2fp3gmsYs1EXdcpg@...278...>
Content-Type: multipart/alternative; boundary="0000000000001155eb05e8e97156"
Subject: [Openvpn-devel] [PATCH] Allow DNS autoconf by passing hostname by
 IV variables when using push-peer-info
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000001155eb05e8e97156
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Author: Ricardo Manr=C3=ADquez <ricardo.manriquez@...277...>

To enable the possibility of DNS autoconfiguration the IP address and
hostname of the client are needed to register at the DNS level, this patch
adds this information when using push-peer-info.

The motivation is that the domain name is as intrusive as the MAC address
and DNS autoconfiguration is helpful to be able to communicate back to the
clients, this generates a problem when the client connects to the network
directly and then uses the VPN connection, now the DNS records do not match
and when using remote assistance or remote management tools the benefits of
DNS are negated.

Signed-off-by: Ricardo Manr=C3=ADquez <ricardo.manriquez@...277...>

---
 src/openvpn/ssl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 80e0d5acb4..3031566585 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2321,6 +2321,11 @@ push_peer_info(struct buffer *buf, struct
tls_session *session)
             {
                 buf_printf(&out, "IV_HWADDR=3D%s\n",
format_hex_ex(rgi.hwaddr, 6, 0, 1, ":", &gc));
             }
+
+            char hostname[64];
+            gethostname(hostname, 63);
+            buf_printf(&out, "IV_HOSTNAME=3D%s\n", hostname );
+
             buf_printf(&out, "IV_SSL=3D%s\n", get_ssl_library_version() );
 #if defined(_WIN32)
             buf_printf(&out, "IV_PLAT_VER=3D%s\n",
win32_version_string(&gc, false));

--0000000000001155eb05e8e97156
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Author: Ricardo Manr=C3=ADquez
 &lt;<a href=3D"mailto:ricardo.manriquez@...277...">ricardo.manriquez@...1664...=
7...</a>&gt;

</div><div><br></div><div>To enable the possibility of DNS autoconfiguratio=
n the IP address and hostname of the client are needed to register at the D=
NS level, this patch adds this information when using push-peer-info.</div>=
<div><br></div><div>The motivation is that the domain name is as intrusive =
as the MAC address and DNS autoconfiguration is helpful to be able to commu=
nicate back to the clients, this generates a problem when the client connec=
ts to the network directly and then uses the VPN connection, now the DNS re=
cords do not match and when using remote assistance or remote management to=
ols the benefits of DNS are negated.<br></div><div><br></div><div>Signed-of=
f-by: Ricardo Manr=C3=ADquez &lt;<a href=3D"mailto:ricardo.manriquez@...1482...=
...">ricardo.manriquez@...277...</a>&gt;<br></div><div>
<pre>---
 src/openvpn/ssl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 80e0d5acb4..3031566585 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2321,6 +2321,11 @@ push_peer_info(struct buffer *buf, struct tls_sessio=
n *session)
             {
                 buf_printf(&amp;out, &quot;IV_HWADDR=3D%s\n&quot;, format_=
hex_ex(rgi.hwaddr, 6, 0, 1, &quot;:&quot;, &amp;gc));
             }
+
+            char hostname[64];
+            gethostname(hostname, 63);
+            buf_printf(&amp;out, &quot;IV_HOSTNAME=3D%s\n&quot;, hostname =
);
+
             buf_printf(&amp;out, &quot;IV_SSL=3D%s\n&quot;, get_ssl_librar=
y_version() );
 #if defined(_WIN32)
             buf_printf(&amp;out, &quot;IV_PLAT_VER=3D%s\n&quot;, win32_ver=
sion_string(&amp;gc, false));</pre>

</div></div>

--0000000000001155eb05e8e97156--

