MIME-Version: 1.0
From: Rafael Gava <gava100@...277...>
Date: Wed, 26 Feb 2025 14:52:44 -0300
Message-ID: <CAAWBBYM4L5sg-XJHjvFn+C4BHLB+DHO=AyYC3ey4A3rNUHyFFw@...278...>
Content-Type: multipart/alternative; boundary="000000000000450a6d062f0f3e82"
Subject: [Openvpn-devel] [PATCH] [master] Add 'assigned-ip' token to
 client-nat network option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000450a6d062f0f3e82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I=E2=80=99m resubmitting the client-nat network option patch with the chang=
es
suggested by the community. The main updates include:

- Replaced the network token from "localhost" to "assigned-ip". Example:

client-nat snat assigned-ip 255.255.255.255 172.19.80.17

- Formatted the code according to the uncrustify.conf syntax.

- Updated client-options.rst to reflect the changes in client-nat
parameters. The examples were also corrected as they were syntactically
incorrect.

The code was successfully built on GitHub without warnings, including
passing the Check code style verification.

Additionally, based on Arne=E2=80=99s comments, the patch was successfully =
tested
using a P2P configuration (openvpn-examples man page - Example 2: A tunnel
with self-signed certificates and fingerprint). Below is the configuration
used to validate the patch. Some parameters were added to test the
client-nat scenario:

Server-side:

The server has an additional NIC with IP address set to: 10.0.2.15.

openvpn --ifconfig 10.4.0.1 10.4.0.2 --tls-server --dev tun --dh none \
--cert ../../../bob.pem --key ../../../bob.pem --cipher AES-256-GCM \
--peer-fingerprint
"C8:07:53:8C:42:80:11:85:C5:F0:E2:23:CD:EF:26:2A:26:13:28:23:FB:FD:00:FF:2F=
:22:88:E4:B4:96:47:67"
\
--push "route 10.0.2.0 255.255.255.0 10.4.0.1" --route 10.0.2.16
255.255.255.255 10.4.0.1

Client-side:

openvpn --remote 192.168.58.115 --tls-client --dev tun --ifconfig 10.4.0.2
10.4.0.1 \
--cipher AES-256-GCM --cert alice.pem --key alice.pem \
--peer-fingerprint
"51:FC:7B:96:74:57:0E:EF:0E:A7:C4:DD:72:B4:C7:13:2E:2B:72:8E:BE:77:15:C8:7E=
:D1:64:44:DA:C7:7C:6C"
\
--client-nat snat assigned-ip 255.255.255.255 10.0.2.16 --client

The client was able to ping both server IPs, 10.4.0.1 and 10.0.2.15, as it
was source NATing to 10.0.2.16.


Please let me know if you have any questions.

Best regards,
Rafael

--------------------

From 4005dce58440e44bbade4da6cce93da56d12e9ed Mon Sep 17 00:00:00 2001
From: Rafael Gava <gava100@...277...>
Date: Mon, 24 Feb 2025 20:24:20 +0000
Subject: [PATCH] Added the assigned-ip token to the client-nat network
option,
 enabling the application to dynamically use the client IP provided by the
 server.

Signed-off-by: Rafael Gava <gava100@...277...>
---
 doc/man-sections/client-options.rst | 18 +++++++----
 src/openvpn/clinat.c                | 50 ++++++++++++++++++++++++++---
 src/openvpn/clinat.h                |  2 ++
 src/openvpn/init.c                  |  2 ++
 src/openvpn/options.c               |  1 +
 5 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/doc/man-sections/client-options.rst
b/doc/man-sections/client-options.rst
index 0aee9e24..cb951640 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -135,17 +135,21 @@ configuration.
   Examples:
   ::

-      client-nat snat 192.168.0.0/255.255.0.0
-      client-nat dnat 10.64.0.0/255.255.0.0
-
-  ``network/netmask`` (for example :code:`192.168.0.0/255.255.0.0`) defines
-  the local view of a resource from the client perspective, while
-  ``alias/netmask`` (for example :code:`10.64.0.0/255.255.0.0`) defines the
-  remote view from the server perspective.
+      client-nat snat assigned-ip 255.255.255.255 172.17.80.17
+      client-nat snat 192.168.100.102 255.255.255.255 172.17.80.18
+      client-nat dnat 10.64.0.0 255.255.0.0 192.168.0.0

   Use :code:`snat` (source NAT) for resources owned by the client and
   :code:`dnat` (destination NAT) for remote resources.

+  ``network`` defines the local view of a resource from the client
perspective.
+  Use :code:`assigned-ip` to instruct openvpn to use the assigned ip
address
+  received from the server.
+
+  ``netmask`` specifies the local mask.
+
+  ``alias`` defines the remote view from the server perspective.
+
   Set ``--verb 6`` for debugging info showing the transformation of
   src/dest addresses in packets.

diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 2d3b359f..d377f0a0 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -127,12 +127,21 @@ add_client_nat_to_option_list(struct
client_nat_option_list *dest,
         return;
     }

-    e.network =3D getaddr(0, network, 0, &ok, NULL);
-    if (!ok)
+    if (network && !strcmp(network, "assigned-ip"))
     {
-        msg(msglevel, "client-nat: bad network: %s", network);
-        return;
+        msg(M_INFO, "*** client-nat assigned-ip detected...");
+        e.network =3D 0xFFFFFFFF;
+    }
+    else
+    {
+        e.network =3D getaddr(0, network, 0, &ok, NULL);
+        if (!ok)
+        {
+            msg(msglevel, "client-nat: bad network: %s", network);
+            return;
+        }
     }
+
     e.netmask =3D getaddr(0, netmask, 0, &ok, NULL);
     if (!ok)
     {
@@ -274,3 +283,36 @@ client_nat_transform(const struct
client_nat_option_list *list,
         }
     }
 }
+
+/*
+ * Replaces the assigned-ip token with the IP received from OpenVPN
+ */
+bool
+update_assignedip_nat(struct client_nat_option_list *dest, in_addr_t
local_ip)
+{
+    int i;
+    bool ret =3D false;
+
+    if (!dest)
+    {
+        return ret;
+    }
+
+    for (i =3D 0; i <=3D dest->n; i++)
+    {
+        struct client_nat_entry *nat_entry =3D &dest->entries[i];
+        if (nat_entry && nat_entry->network =3D=3D 0xFFFFFFFF)
+        {
+            struct in_addr addr;
+
+            nat_entry->network =3D ntohl(local_ip);
+            addr.s_addr =3D nat_entry->network;
+            char *dot_ip =3D inet_ntoa(addr);
+
+            msg(M_INFO, "CNAT - Updating NAT table from assigned-ip to:
%s", dot_ip);
+            ret =3D true;
+        }
+    }
+
+    return ret;
+}
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index 94141f51..24663a7c 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -64,4 +64,6 @@ void client_nat_transform(const struct
client_nat_option_list *list,
                           struct buffer *ipbuf,
                           const int direction);

+bool update_assignedip_nat(struct client_nat_option_list *dest, in_addr_t
local_ip);
+
 #endif /* if !defined(CLINAT_H) */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b57e5f8a..c6547c76 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2052,6 +2052,8 @@ do_open_tun(struct context *c, int *error_flags)
             *error_flags |=3D (status ? 0 : ISC_ROUTE_ERRORS);
         }

+        update_assignedip_nat(c->options.client_nat, c->c1.tuntap->local);
+
         ret =3D true;
         static_context =3D c;
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6b2dfa58..6c401f6b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -254,6 +254,7 @@ static const char usage_message[] =3D
     "                   (Server) Instead of forwarding IPv6 packets send\n"
     "                   ICMPv6 host unreachable packets to the client.\n"
     "--client-nat snat|dnat network netmask alias : on client add 1-to-1
NAT rule.\n"
+    "                  set the network to 'assigned-ip' to use the client
ip received from the server.\n"
     "--push-peer-info : (client only) push client info to server.\n"
     "--setenv name value : Set a custom environmental variable to pass to
script.\n"
     "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to
allow\n"
--=20
2.39.5

--000000000000450a6d062f0f3e82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello everyone,<br><br>I=E2=80=99m resubmitting the client=
-nat network option patch with the changes suggested by the community. The =
main updates include:<br><br>	- Replaced the network token from &quot;local=
host&quot; to &quot;assigned-ip&quot;. Example:<br><br>		client-nat snat as=
signed-ip 255.255.255.255 172.19.80.17 =C2=A0<br><br>	- Formatted the code =
according to the uncrustify.conf syntax.<br><br>	- Updated client-options.r=
st to reflect the changes in client-nat parameters. The examples were also =
corrected as they were syntactically incorrect.<br><br>The code was success=
fully built on GitHub without warnings, including passing the Check code st=
yle verification.<br><br>Additionally, based on Arne=E2=80=99s comments, th=
e patch was successfully tested using a P2P configuration (openvpn-examples=
 man page - Example 2: A tunnel with self-signed certificates and fingerpri=
nt). Below is the configuration used to validate the patch. Some parameters=
 were added to test the client-nat scenario:<br><br>Server-side:<br><br>	Th=
e server has an additional NIC with IP address set to: 10.0.2.15.<br><br>	o=
penvpn --ifconfig 10.4.0.1 10.4.0.2 --tls-server --dev tun --dh none \ =C2=
=A0<br>	--cert ../../../bob.pem --key ../../../bob.pem --cipher AES-256-GCM=
 \ =C2=A0<br>	--peer-fingerprint &quot;C8:07:53:8C:42:80:11:85:C5:F0:E2:23:=
CD:EF:26:2A:26:13:28:23:FB:FD:00:FF:2F:22:88:E4:B4:96:47:67&quot; \ =C2=A0<=
br>	--push &quot;route 10.0.2.0 255.255.255.0 10.4.0.1&quot; --route 10.0.2=
.16 255.255.255.255 10.4.0.1 =C2=A0<br><br>Client-side:<br><br>	openvpn --r=
emote 192.168.58.115 --tls-client --dev tun --ifconfig 10.4.0.2 10.4.0.1 \ =
=C2=A0<br>	--cipher AES-256-GCM --cert alice.pem --key alice.pem \ =C2=A0<b=
r>	--peer-fingerprint &quot;51:FC:7B:96:74:57:0E:EF:0E:A7:C4:DD:72:B4:C7:13=
:2E:2B:72:8E:BE:77:15:C8:7E:D1:64:44:DA:C7:7C:6C&quot; \ =C2=A0<br>	--clien=
t-nat snat assigned-ip 255.255.255.255 10.0.2.16 --client =C2=A0<br><br>	Th=
e client was able to ping both server IPs, 10.4.0.1 and 10.0.2.15, as it wa=
s source NATing to 10.0.2.16.<br><br><br>Please let me know if you have any=
 questions.<br><br>Best regards,<br><div>Rafael</div><div><br></div><div>--=
------------------</div><div><br></div><div>From 4005dce58440e44bbade4da6cc=
e93da56d12e9ed Mon Sep 17 00:00:00 2001<br>From: Rafael Gava &lt;<a href=3D=
"mailto:gava100@...277...">gava100@...277...</a>&gt;<br>Date: Mon, 24 Feb 2=
025 20:24:20 +0000<br>Subject: [PATCH] Added the assigned-ip token to the c=
lient-nat network option,<br>=C2=A0enabling the application to dynamically =
use the client IP provided by the<br>=C2=A0server.<br><br>Signed-off-by: Ra=
fael Gava &lt;<a href=3D"mailto:gava100@...277...">gava100@...277...</a>&gt=
;<br>---<br>=C2=A0doc/man-sections/client-options.rst | 18 +++++++----<br>=
=C2=A0src/openvpn/clinat.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 50 ++++++++++++++++++++++++++---<br>=C2=A0src/openvpn/clinat.h =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A02 ++<br>=C2=A0s=
rc/openvpn/init.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A02 ++<br>=C2=A0src/openvpn/options.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A01 +<br>=C2=A05 files changed, 62 insertion=
s(+), 11 deletions(-)<br><br>diff --git a/doc/man-sections/client-options.r=
st b/doc/man-sections/client-options.rst<br>index 0aee9e24..cb951640 100644=
<br>--- a/doc/man-sections/client-options.rst<br>+++ b/doc/man-sections/cli=
ent-options.rst<br>@@ -135,17 +135,21 @@ configuration.<br>=C2=A0 =C2=A0Exa=
mples:<br>=C2=A0 =C2=A0::<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0client-nat sna=
t <a href=3D"http://192.168.0.0/255.255.0.0">192.168.0.0/255.255.0.0</a><br=
>- =C2=A0 =C2=A0 =C2=A0client-nat dnat <a href=3D"http://10.64.0.0/255.255.=
0.0">10.64.0.0/255.255.0.0</a><br>-<br>- =C2=A0``network/netmask`` (for exa=
mple :code:`<a href=3D"http://192.168.0.0/255.255.0.0`">192.168.0.0/255.255=
.0.0`</a>) defines<br>- =C2=A0the local view of a resource from the client =
perspective, while<br>- =C2=A0``alias/netmask`` (for example :code:`<a href=
=3D"http://10.64.0.0/255.255.0.0`">10.64.0.0/255.255.0.0`</a>) defines the<=
br>- =C2=A0remote view from the server perspective.<br>+ =C2=A0 =C2=A0 =C2=
=A0client-nat snat assigned-ip 255.255.255.255 172.17.80.17<br>+ =C2=A0 =C2=
=A0 =C2=A0client-nat snat 192.168.100.102 255.255.255.255 172.17.80.18<br>+=
 =C2=A0 =C2=A0 =C2=A0client-nat dnat 10.64.0.0 255.255.0.0 192.168.0.0<br>=
=C2=A0<br>=C2=A0 =C2=A0Use :code:`snat` (source NAT) for resources owned by=
 the client and<br>=C2=A0 =C2=A0:code:`dnat` (destination NAT) for remote r=
esources.<br>=C2=A0<br>+ =C2=A0``network`` defines the local view of a reso=
urce from the client perspective. <br>+ =C2=A0Use :code:`assigned-ip` to in=
struct openvpn to use the assigned ip address <br>+ =C2=A0received from the=
 server.<br>+ =C2=A0<br>+ =C2=A0``netmask`` specifies the local mask.<br>+<=
br>+ =C2=A0``alias`` defines the remote view from the server perspective.<b=
r>+<br>=C2=A0 =C2=A0Set ``--verb 6`` for debugging info showing the transfo=
rmation of<br>=C2=A0 =C2=A0src/dest addresses in packets.<br>=C2=A0<br>diff=
 --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c<br>index 2d3b359f..d37=
7f0a0 100644<br>--- a/src/openvpn/clinat.c<br>+++ b/src/openvpn/clinat.c<br=
>@@ -127,12 +127,21 @@ add_client_nat_to_option_list(struct client_nat_opti=
on_list *dest,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0 =C2=
=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0e.network =3D getaddr(0, network, 0=
, &amp;ok, NULL);<br>- =C2=A0 =C2=A0if (!ok)<br>+ =C2=A0 =C2=A0if (network =
&amp;&amp; !strcmp(network, &quot;assigned-ip&quot;))<br>=C2=A0 =C2=A0 =C2=
=A0{<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot;client-nat: bad ne=
twork: %s&quot;, network);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0msg(M_INFO, &quot;*** client-nat assigned-ip detect=
ed...&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0e.network =3D 0xFFFFFFFF;<br>=
+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0e.network =3D getaddr(0, network, 0, &amp;ok, NULL);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ok)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot;client-nat: ba=
d network: %s&quot;, network);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>+<=
br>=C2=A0 =C2=A0 =C2=A0e.netmask =3D getaddr(0, netmask, 0, &amp;ok, NULL);=
<br>=C2=A0 =C2=A0 =C2=A0if (!ok)<br>=C2=A0 =C2=A0 =C2=A0{<br>@@ -274,3 +283=
,36 @@ client_nat_transform(const struct client_nat_option_list *list,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br>=
+<br>+/*<br>+ * Replaces the assigned-ip token with the IP received from Op=
enVPN<br>+ */<br>+bool<br>+update_assignedip_nat(struct client_nat_option_l=
ist *dest, in_addr_t local_ip)<br>+{<br>+ =C2=A0 =C2=A0int i;<br>+ =C2=A0 =
=C2=A0bool ret =3D false;<br>+<br>+ =C2=A0 =C2=A0if (!dest)<br>+ =C2=A0 =C2=
=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>+ =C2=A0 =C2=A0}<br>+<b=
r>+ =C2=A0 =C2=A0for (i =3D 0; i &lt;=3D dest-&gt;n; i++)<br>+ =C2=A0 =C2=
=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0struct client_nat_entry *nat_entry =3D=
 &amp;dest-&gt;entries[i];<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nat_entry &a=
mp;&amp; nat_entry-&gt;network =3D=3D 0xFFFFFFFF)<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct in_addr addr;=
<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nat_entry-&gt;network =
=3D ntohl(local_ip);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr.s_a=
ddr =3D nat_entry-&gt;network;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0char *dot_ip =3D inet_ntoa(addr);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0msg(M_INFO, &quot;CNAT - Updating NAT table from assigned-ip t=
o: %s&quot;, dot_ip);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D=
 true;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=
=A0 =C2=A0return ret;<br>+}<br>diff --git a/src/openvpn/clinat.h b/src/open=
vpn/clinat.h<br>index 94141f51..24663a7c 100644<br>--- a/src/openvpn/clinat=
.h<br>+++ b/src/openvpn/clinat.h<br>@@ -64,4 +64,6 @@ void client_nat_trans=
form(const struct client_nat_option_list *list,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct buffer *ipbuf,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int direction);<br>=C2=
=A0<br>+bool update_assignedip_nat(struct client_nat_option_list *dest, in_=
addr_t local_ip);<br>+<br>=C2=A0#endif /* if !defined(CLINAT_H) */<br>diff =
--git a/src/openvpn/init.c b/src/openvpn/init.c<br>index b57e5f8a..c6547c76=
 100644<br>--- a/src/openvpn/init.c<br>+++ b/src/openvpn/init.c<br>@@ -2052=
,6 +2052,8 @@ do_open_tun(struct context *c, int *error_flags)<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*error_flags |=3D (status ? 0 : IS=
C_ROUTE_ERRORS);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0update_assignedip_nat(c-&gt;options.client_nat, c-&=
gt;c1.tuntap-&gt;local);<br>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D =
true;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static_context =3D c;<br>=C2=A0 =
=C2=A0 =C2=A0}<br>diff --git a/src/openvpn/options.c b/src/openvpn/options.=
c<br>index 6b2dfa58..6c401f6b 100644<br>--- a/src/openvpn/options.c<br>+++ =
b/src/openvpn/options.c<br>@@ -254,6 +254,7 @@ static const char usage_mess=
age[] =3D<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (Server) Instead of forwarding IPv6 packets sen=
d\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ICMPv6 host unreachable packets to the client.\=
n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot;--client-nat snat|dnat network netmask=
 alias : on client add 1-to-1 NAT rule.\n&quot;<br>+ =C2=A0 =C2=A0&quot; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set the netwo=
rk to &#39;assigned-ip&#39; to use the client ip received from the server.\=
n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot;--push-peer-info : (client only) push =
client info to server.\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot;--setenv name v=
alue : Set a custom environmental variable to pass to script.\n&quot;<br>=
=C2=A0 =C2=A0 =C2=A0&quot;--setenv FORWARD_COMPATIBLE 1 : Relax config file=
 syntax checking to allow\n&quot;<br>-- <br>2.39.5<br><br><br></div></div>

--000000000000450a6d062f0f3e82--

