MIME-Version: 1.0
From: Rafael Gava <gava100@...277...>
Date: Sun, 13 Sep 2020 22:23:16 -0300
Message-ID: <CAAWBBYMu6mT+H3atWxx1Stqt63kvTj-MGpUiM_2uDnAjbqNb=w@...278...>
Content-Type: multipart/alternative; boundary="000000000000ad9c2405af3be176"
Subject: [Openvpn-devel]  NAT client-ip
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ad9c2405af3be176
Content-Type: text/plain; charset="UTF-8"

Hello guys,

A couple years ago I submitted this patch which allows the user to set the
'client-ip' as a convenient way to use the leased IP address received from
OpenVPN server in NAT configuration. For example:

client-nat snat client-ip 255.255.255.255 172.20.1.15

, where 'client-ip' string is replaced with the leased IP address received
from OpenVPN server.

At that time, it was NACKED due to the fact that I was using both client-ip
and localhost strings. So, it's changed now and I'd like to re-submit it
again for appreciation.

Thanks

Gava

-------------------------------------

From e273b13bc10da8f917a981957cf2c43ba6bd1e10 Mon Sep 17 00:00:00 2001
From: Rafael Gava de Oliveira <Rafael.Oliveira@...2056...>
Date: Sat, 12 Sep 2020 19:27:25 -0300
Subject: [PATCH] Allows the usage of the string 'client-ip' in the
client-nat
 network configuration in a way that is not necessary to inform the IP
address
 beforehand. Openvpn will dynamically set the received IP from DHCP.

Example:

client-nat snat client-ip 255.255.255.255 172.20.1.15

Replaces the 'client-ip' string with the DHCP address received from
the openvpn server.
---
 src/openvpn/clinat.c  | 45 ++++++++++++++++++++++++++++++++++++++++-----
 src/openvpn/clinat.h  |  2 ++
 src/openvpn/init.c    |  2 ++
 src/openvpn/options.c |  2 +-
 4 files changed, 45 insertions(+), 6 deletions(-)
 mode change 100644 => 100755 src/openvpn/clinat.c

diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
old mode 100644
new mode 100755
index b08fd54..865b0e2
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -128,12 +128,16 @@ add_client_nat_to_option_list(struct
client_nat_option_list *dest,
         msg(msglevel, "client-nat: type must be 'snat' or 'dnat'");
         return;
     }
-
-    e.network = getaddr(0, network, 0, &ok, NULL);
-    if (!ok)
+    if (network && !strcmp(network, "client-ip"))
     {
-        msg(msglevel, "client-nat: bad network: %s", network);
-        return;
+        e.network = 0xFFFFFFFF;
+    } else {
+        e.network = getaddr(0, network, 0, &ok, NULL);
+        if (!ok)
+        {
+            msg(msglevel, "client-nat: bad network: %s", network);
+            return;
+        }
     }
     e.netmask = getaddr(0, netmask, 0, &ok, NULL);
     if (!ok)
@@ -276,3 +280,34 @@ client_nat_transform(const struct
client_nat_option_list *list,
         }
     }
 }
+
+/*
+* Replaces the client-ip token with the IP received from OpenVPN Server
+*/
+bool
+update_client_ip_nat(struct client_nat_option_list *dest, in_addr_t
local_ip)
+{
+    int i;
+    bool ret = false;
+
+    if (!dest)
+        return ret;
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
+            msg (M_INFO, "Updating NAT table client-ip to: %s", dot_ip);
+            ret = true;
+        }
+    }
+
+    return ret;
+}
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index eec7a03..c2941b9 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -64,4 +64,6 @@ void client_nat_transform(const struct
client_nat_option_list *list,
                           struct buffer *ipbuf,
                           const int direction);

+bool update_client_ip_nat(struct client_nat_option_list *dest, in_addr_t
local_ip);
+
 #endif /* if !defined(CLINAT_H) */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a785934..8d6f9a8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1920,6 +1920,8 @@ do_open_tun(struct context *c)
                               SET_MTU_TUN | SET_MTU_UPPER_BOUND);
     }

+    update_client_ip_nat(c->options.client_nat, c->c1.tuntap->local);
+
     ret = true;
     static_context = c;
 #ifndef TARGET_ANDROID
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8bf82c5..26f11fa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -231,7 +231,7 @@ static const char usage_message[] =
     "                   ICMPv6 host unreachable messages on the client.\n"
     "                   (Server) Instead of forwarding IPv6 packets send\n"
     "                   ICMPv6 host unreachable packets to the client.\n"
-    "--client-nat snat|dnat network netmask alias : on client add 1-to-1
NAT rule.\n"
+    "--client-nat snat|dnat network|'client-ip' netmask alias : on client
add 1-to-1 NAT rule.\n"
     "--push-peer-info : (client only) push client info to server.\n"
     "--setenv name value : Set a custom environmental variable to pass to
script.\n"
     "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to
allow\n"
-- 
2.7.4

--000000000000ad9c2405af3be176
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello guys,<br><br>A couple years ago I submitted this pat=
ch which allows the user to set the &#39;client-ip&#39; as a convenient way=
 to use the leased IP address received from OpenVPN server in NAT configura=
tion. For example:<br><br>client-nat snat client-ip 255.255.255.255 172.20.=
1.15 <br><br>, where &#39;client-ip&#39; string is replaced with the leased=
 IP address received from OpenVPN server. <br><br>At that time, it was NACK=
ED due to the fact that I was using both client-ip and localhost strings. S=
o, it&#39;s changed now and I&#39;d like to re-submit it again for apprecia=
tion.<br><br>Thanks<br><br>Gava<br><div><br></div><div>--------------------=
-----------------</div><div><br></div><div>From e273b13bc10da8f917a981957cf=
2c43ba6bd1e10 Mon Sep 17 00:00:00 2001<br>From: Rafael Gava de Oliveira &lt=
;<a href=3D"mailto:Rafael.Oliveira@...2056...">Rafael.Oliveira@...2056...</=
a>&gt;<br>Date: Sat, 12 Sep 2020 19:27:25 -0300<br>Subject: [PATCH] Allows =
the usage of the string &#39;client-ip&#39; in the client-nat<br>=C2=A0netw=
ork configuration in a way that is not necessary to inform the IP address<b=
r>=C2=A0beforehand. Openvpn will dynamically set the received IP from DHCP.=
<br><br>Example:<br><br>	client-nat snat client-ip 255.255.255.255 172.20.1=
.15<br><br>Replaces the &#39;client-ip&#39; string with the DHCP address re=
ceived from<br>the openvpn server.<br>---<br>=C2=A0src/openvpn/clinat.c =C2=
=A0| 45 ++++++++++++++++++++++++++++++++++++++++-----<br>=C2=A0src/openvpn/=
clinat.h =C2=A0| =C2=A02 ++<br>=C2=A0src/openvpn/init.c =C2=A0 =C2=A0| =C2=
=A02 ++<br>=C2=A0src/openvpn/options.c | =C2=A02 +-<br>=C2=A04 files change=
d, 45 insertions(+), 6 deletions(-)<br>=C2=A0mode change 100644 =3D&gt; 100=
755 src/openvpn/clinat.c<br><br>diff --git a/src/openvpn/clinat.c b/src/ope=
nvpn/clinat.c<br>old mode 100644<br>new mode 100755<br>index b08fd54..865b0=
e2<br>--- a/src/openvpn/clinat.c<br>+++ b/src/openvpn/clinat.c<br>@@ -128,1=
2 +128,16 @@ add_client_nat_to_option_list(struct client_nat_option_list *d=
est,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot;client-nat: t=
ype must be &#39;snat&#39; or &#39;dnat&#39;&quot;);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return;<br>=C2=A0 =C2=A0 =C2=A0}<br>-<br>- =C2=A0 =C2=A0e.=
network =3D getaddr(0, network, 0, &amp;ok, NULL);<br>- =C2=A0 =C2=A0if (!o=
k)<br>+ =C2=A0 =C2=A0if (network &amp;&amp; !strcmp(network, &quot;client-i=
p&quot;))<br>=C2=A0 =C2=A0 =C2=A0{<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msgl=
evel, &quot;client-nat: bad network: %s&quot;, network);<br>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0e.network =3D 0xFFFFF=
FFF;<br>+ =C2=A0 =C2=A0} else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0e.network =
=3D getaddr(0, network, 0, &amp;ok, NULL);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if (!ok)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0msg(msglevel, &quot;client-nat: bad network: %s&quot;, networ=
k);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0e.netmas=
k =3D getaddr(0, netmask, 0, &amp;ok, NULL);<br>=C2=A0 =C2=A0 =C2=A0if (!ok=
)<br>@@ -276,3 +280,34 @@ client_nat_transform(const struct client_nat_opti=
on_list *list,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0}<br>+<br>+/*<br>+* Replaces the client-ip token with the IP =
received from OpenVPN Server<br>+*/<br>+bool <br>+update_client_ip_nat(stru=
ct client_nat_option_list *dest, in_addr_t local_ip)<br>+{<br>+ =C2=A0 =C2=
=A0int i;<br>+ =C2=A0 =C2=A0bool ret =3D false;<br>+<br>+ =C2=A0 =C2=A0if (=
!dest)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>+<br>+ =C2=A0 =C2=A0f=
or (i=3D0; i &lt;=3D dest-&gt;n; i++) <br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct client_nat_entry *nat_entry =3D &amp;dest-&gt;entri=
es[i];<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nat_entry &amp;&amp; nat_entry-&=
gt;network =3D=3D 0xFFFFFFFF) <br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct in_addr addr;<br>+<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nat_entry-&gt;network =3D ntohl(local_ip=
);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr.s_addr =3D nat_entry-=
&gt;network;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *dot_ip =3D=
 inet_ntoa(addr);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M=
_INFO, &quot;Updating NAT table client-ip to: %s&quot;, dot_ip); <br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D true;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0return ret;<br>+}<br=
>diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h<br>index eec7a03.=
.c2941b9 100644<br>--- a/src/openvpn/clinat.h<br>+++ b/src/openvpn/clinat.h=
<br>@@ -64,4 +64,6 @@ void client_nat_transform(const struct client_nat_opt=
ion_list *list,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct buffer *ipbuf,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const int direction);<br>=C2=A0<br>+bool update_client_ip_=
nat(struct client_nat_option_list *dest, in_addr_t local_ip);<br>+<br>=C2=
=A0#endif /* if !defined(CLINAT_H) */<br>diff --git a/src/openvpn/init.c b/=
src/openvpn/init.c<br>index a785934..8d6f9a8 100644<br>--- a/src/openvpn/in=
it.c<br>+++ b/src/openvpn/init.c<br>@@ -1920,6 +1920,8 @@ do_open_tun(struc=
t context *c)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SET_MTU_TUN | SET_MT=
U_UPPER_BOUND);<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>+ =C2=A0 =C2=A0update=
_client_ip_nat(c-&gt;options.client_nat, c-&gt;c1.tuntap-&gt;local);<br>+<b=
r>=C2=A0 =C2=A0 =C2=A0ret =3D true;<br>=C2=A0 =C2=A0 =C2=A0static_context =
=3D c;<br>=C2=A0#ifndef TARGET_ANDROID<br>diff --git a/src/openvpn/options.=
c b/src/openvpn/options.c<br>index 8bf82c5..26f11fa 100644<br>--- a/src/ope=
nvpn/options.c<br>+++ b/src/openvpn/options.c<br>@@ -231,7 +231,7 @@ static=
 const char usage_message[] =3D<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ICMPv6 host unreachable m=
essages on the client.\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Server) Instead of forwar=
ding IPv6 packets send\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ICMPv6 host unreachable pa=
ckets to the client.\n&quot;<br>- =C2=A0 =C2=A0&quot;--client-nat snat|dnat=
 network netmask alias : on client add 1-to-1 NAT rule.\n&quot;<br>+ =C2=A0=
 =C2=A0&quot;--client-nat snat|dnat network|&#39;client-ip&#39; netmask ali=
as : on client add 1-to-1 NAT rule.\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot;--=
push-peer-info : (client only) push client info to server.\n&quot;<br>=C2=
=A0 =C2=A0 =C2=A0&quot;--setenv name value : Set a custom environmental var=
iable to pass to script.\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot;--setenv FORW=
ARD_COMPATIBLE 1 : Relax config file syntax checking to allow\n&quot;<br>--=
 <br>2.7.4<br><br></div></div>

--000000000000ad9c2405af3be176--

