MIME-Version: 1.0
From: Rafael Gava <gava100@...277...>
Date: Thu, 20 Feb 2025 16:48:27 -0300
Message-ID: <CAAWBBYOr-ZKmr3754DqzkssCr04C=n75C4bOihN04nx-4-xVvw@...278...>
Content-Type: multipart/alternative; boundary="000000000000ed029f062e9828c7"
Subject: [Openvpn-devel] [PATCH] Add 'localhost' token to client-nat network
 option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ed029f062e9828c7
Content-Type: text/plain; charset="UTF-8"

Dear OpenVPN Community,

I am submitting this patch to introduce a 'localhost' token to the
`client-nat` network option, allowing OpenVPN clients to dynamically use
the IP address provided by the server. This enhancement is particularly
useful in scenarios where OpenVPN is deployed as a VPN gateway bridging a
local network and a VPN tunnel.

Currently, the `client-nat` option requires a static client IP, which
limits its flexibility when dealing with dynamically assigned IP addresses.
By introducing a 'localhost' token, OpenVPN can automatically substitute it
with the current client-assigned IP address, streamlining network
configurations in dynamic environments.

Example:

client-nat snat localhost 255.255.255.255 172.19.80.17

I believe this feature will be beneficial for many OpenVPN users, improving
automation and simplifying VPN gateway configurations. Please find the
patch inline for review and feedback.

Best regards,

Rafael Gava

----
From fbc7045d652b5f11e2aa043aa2af9ca14f36b604 Mon Sep 17 00:00:00 2001
From: Rafael Gava <gava100@...277...>
Date: Thu, 20 Feb 2025 19:19:39 +0000
Subject: [PATCH] Added the localhost token to the client-nat network option,
 enabling the application to dynamically use the client IP provided by the
 server.

Signed-off-by: Rafael Gava <gava100@...277...>
---
 src/openvpn/clinat.c  | 47 +++++++++++++++++++++++++++++++++++++++----
 src/openvpn/clinat.h  |  3 +++
 src/openvpn/init.c    |  2 ++
 src/openvpn/options.c |  1 +
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 2d3b359f..1c79b20d 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -127,12 +127,19 @@ add_client_nat_to_option_list(struct
client_nat_option_list *dest,
         return;
     }

-    e.network = getaddr(0, network, 0, &ok, NULL);
-    if (!ok)
+    if (network && !strcmp(network, "localhost"))
     {
-        msg(msglevel, "client-nat: bad network: %s", network);
-        return;
+        msg (M_INFO, "*** client-nat localhost detected...");
+        e.network = 0xFFFFFFFF;
+    } else {
+        e.network = getaddr(0, network, 0, &ok, NULL);
+        if (!ok)
+        {
+            msg(msglevel, "client-nat: bad network: %s", network);
+            return;
+        }
     }
+
     e.netmask = getaddr(0, netmask, 0, &ok, NULL);
     if (!ok)
     {
@@ -274,3 +281,35 @@ client_nat_transform(const struct
client_nat_option_list *list,
         }
     }
 }
+
+/*
+* Replaces the localhost token with the IP received from OpenVPN
+*/
+bool
+update_localhost_nat(struct client_nat_option_list *dest, in_addr_t
local_ip)
+{
+    int i;
+    bool ret = false;
+
+    if (!dest) {
+        return ret;
+    }
+
+    for (i=0; i <= dest->n; i++)
+    {
+        struct client_nat_entry *nat_entry = &dest->entries[i];
+        if (nat_entry && nat_entry->network == 0xFFFFFFFF)
+        {
+            struct in_addr addr;
+
+            nat_entry->network = ntohl(local_ip);
+            addr.s_addr = nat_entry->network;
+            char *dot_ip = inet_ntoa(addr);
+
+            msg (M_INFO, "CNAT - Updating NAT table from localhost to:
%s", dot_ip);
+            ret = true;
+        }
+    }
+
+    return ret;
+}
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index 94141f51..06afa3b4 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -64,4 +64,7 @@ void client_nat_transform(const struct
client_nat_option_list *list,
                           struct buffer *ipbuf,
                           const int direction);

+bool update_localhost_nat(struct client_nat_option_list *dest, in_addr_t
local_ip);
+
+
 #endif /* if !defined(CLINAT_H) */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b57e5f8a..dadc10dc 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2052,6 +2052,8 @@ do_open_tun(struct context *c, int *error_flags)
             *error_flags |= (status ? 0 : ISC_ROUTE_ERRORS);
         }

+        update_localhost_nat(c->options.client_nat, c->c1.tuntap->local);
+
         ret = true;
         static_context = c;
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6b2dfa58..f7161931 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -254,6 +254,7 @@ static const char usage_message[] =
     "                   (Server) Instead of forwarding IPv6 packets send\n"
     "                   ICMPv6 host unreachable packets to the client.\n"
     "--client-nat snat|dnat network netmask alias : on client add 1-to-1
NAT rule.\n"
+    "                  set the network to 'localhost' to use the client ip
received from the server.\n"
     "--push-peer-info : (client only) push client info to server.\n"
     "--setenv name value : Set a custom environmental variable to pass to
script.\n"
     "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to
allow\n"
-- 
2.39.5

--000000000000ed029f062e9828c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear OpenVPN Community,<br><br>I am submitting this patch =
to introduce a &#39;localhost&#39; token to the `client-nat` network option=
, allowing OpenVPN clients to dynamically use the IP address provided by th=
e server. This enhancement is particularly useful in scenarios where OpenVP=
N is deployed as a VPN gateway bridging a local network and a VPN tunnel.<b=
r><br>Currently, the `client-nat` option requires a static client IP, which=
 limits its flexibility when dealing with dynamically assigned IP addresses=
. By introducing a &#39;localhost&#39; token, OpenVPN can automatically sub=
stitute it with the current client-assigned IP address, streamlining networ=
k configurations in dynamic environments.<br><div><br></div><div>Example:</=
div><div><br></div>client-nat snat localhost 255.255.255.255 172.19.80.17<b=
r><br>I believe this feature will be beneficial for many OpenVPN users, imp=
roving automation and simplifying VPN gateway configurations. Please find t=
he patch inline for review and feedback.<br><br>Best regards, =C2=A0<br><br=
><div>Rafael Gava</div><div><br></div><div>----</div><div>From fbc7045d652b=
5f11e2aa043aa2af9ca14f36b604 Mon Sep 17 00:00:00 2001<br>From: Rafael Gava =
&lt;<a href=3D"mailto:gava100@...277...">gava100@...277...</a>&gt;<br>Date:=
 Thu, 20 Feb 2025 19:19:39 +0000<br>Subject: [PATCH] Added the localhost to=
ken to the client-nat network option,<br>=C2=A0enabling the application to =
dynamically use the client IP provided by the<br>=C2=A0server.<br><br>Signe=
d-off-by: Rafael Gava &lt;<a href=3D"mailto:gava100@...277...">gava100@...1665...=
77...</a>&gt;<br>---<br>=C2=A0src/openvpn/clinat.c =C2=A0| 47 +++++++++++++=
++++++++++++++++++++++++++----<br>=C2=A0src/openvpn/clinat.h =C2=A0| =C2=A0=
3 +++<br>=C2=A0src/openvpn/init.c =C2=A0 =C2=A0| =C2=A02 ++<br>=C2=A0src/op=
envpn/options.c | =C2=A01 +<br>=C2=A04 files changed, 49 insertions(+), 4 d=
eletions(-)<br><br>diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c=
<br>index 2d3b359f..1c79b20d 100644<br>--- a/src/openvpn/clinat.c<br>+++ b/=
src/openvpn/clinat.c<br>@@ -127,12 +127,19 @@ add_client_nat_to_option_list=
(struct client_nat_option_list *dest,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0e.network =3D =
getaddr(0, network, 0, &amp;ok, NULL);<br>- =C2=A0 =C2=A0if (!ok)<br>+ =C2=
=A0 =C2=A0if (network &amp;&amp; !strcmp(network, &quot;localhost&quot;))<b=
r>=C2=A0 =C2=A0 =C2=A0{<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot=
;client-nat: bad network: %s&quot;, network);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;*** client-na=
t localhost detected...&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0e.network =
=3D 0xFFFFFFFF;<br>+ =C2=A0 =C2=A0} else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
e.network =3D getaddr(0, network, 0, &amp;ok, NULL);<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!ok)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot;client-nat: bad network: %s&quo=
t;, network);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>+<br>=C2=A0 =C2=A0=
 =C2=A0e.netmask =3D getaddr(0, netmask, 0, &amp;ok, NULL);<br>=C2=A0 =C2=
=A0 =C2=A0if (!ok)<br>=C2=A0 =C2=A0 =C2=A0{<br>@@ -274,3 +281,35 @@ client_=
nat_transform(const struct client_nat_option_list *list,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br>+<br>+/*<br>+*=
 Replaces the localhost token with the IP received from OpenVPN<br>+*/<br>+=
bool <br>+update_localhost_nat(struct client_nat_option_list *dest, in_addr=
_t local_ip)<br>+{<br>+ =C2=A0 =C2=A0int i;<br>+ =C2=A0 =C2=A0bool ret =3D =
false;<br>+<br>+ =C2=A0 =C2=A0if (!dest) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return ret;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0for (i=3D0; i &lt;=
=3D dest-&gt;n; i++) <br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
truct client_nat_entry *nat_entry =3D &amp;dest-&gt;entries[i];<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if (nat_entry &amp;&amp; nat_entry-&gt;network =3D=3D =
0xFFFFFFFF) <br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0struct in_addr addr;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nat_entry-&gt;network =
=3D ntohl(local_ip);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr.s_a=
ddr =3D nat_entry-&gt;network;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0char *dot_ip =3D inet_ntoa(addr);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0msg (M_INFO, &quot;CNAT - Updating NAT table from localhost to=
: %s&quot;, dot_ip); <br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D=
 true;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=
=A0 =C2=A0return ret;<br>+}<br>diff --git a/src/openvpn/clinat.h b/src/open=
vpn/clinat.h<br>index 94141f51..06afa3b4 100644<br>--- a/src/openvpn/clinat=
.h<br>+++ b/src/openvpn/clinat.h<br>@@ -64,4 +64,7 @@ void client_nat_trans=
form(const struct client_nat_option_list *list,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct buffer *ipbuf,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int direction);<br>=C2=
=A0<br>+bool update_localhost_nat(struct client_nat_option_list *dest, in_a=
ddr_t local_ip);<br>+<br>+<br>=C2=A0#endif /* if !defined(CLINAT_H) */<br>d=
iff --git a/src/openvpn/init.c b/src/openvpn/init.c<br>index b57e5f8a..dadc=
10dc 100644<br>--- a/src/openvpn/init.c<br>+++ b/src/openvpn/init.c<br>@@ -=
2052,6 +2052,8 @@ do_open_tun(struct context *c, int *error_flags)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*error_flags |=3D (status ? 0 =
: ISC_ROUTE_ERRORS);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0update_localhost_nat(c-&gt;options.client_nat, c=
-&gt;c1.tuntap-&gt;local);<br>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =
=3D true;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static_context =3D c;<br>=C2=
=A0 =C2=A0 =C2=A0}<br>diff --git a/src/openvpn/options.c b/src/openvpn/opti=
ons.c<br>index 6b2dfa58..f7161931 100644<br>--- a/src/openvpn/options.c<br>=
+++ b/src/openvpn/options.c<br>@@ -254,6 +254,7 @@ static const char usage_=
message[] =3D<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Server) Instead of forwarding IPv6 packets=
 send\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ICMPv6 host unreachable packets to the clie=
nt.\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot;--client-nat snat|dnat network net=
mask alias : on client add 1-to-1 NAT rule.\n&quot;<br>+ =C2=A0 =C2=A0&quot=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set the net=
work to &#39;localhost&#39; to use the client ip received from the server.\=
n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot;--push-peer-info : (client only) push =
client info to server.\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot;--setenv name v=
alue : Set a custom environmental variable to pass to script.\n&quot;<br>=
=C2=A0 =C2=A0 =C2=A0&quot;--setenv FORWARD_COMPATIBLE 1 : Relax config file=
 syntax checking to allow\n&quot;<br>-- <br>2.39.5<br><br><br></div></div>

--000000000000ed029f062e9828c7--

