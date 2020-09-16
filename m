From: Rafael Gava de Oliveira <Rafael.Oliveira@...2056...>
Date: Wed, 16 Sep 2020 16:56:17 +0000
Message-ID: <CP2P152MB16680322F42D28AABF8A15EFA8210@...2580...>
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_CP2P152MB16680322F42D28AABF8A15EFA8210CP2P152MB1668LAMP_"
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Added client-ip to NAT config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_000_CP2P152MB16680322F42D28AABF8A15EFA8210CP2P152MB1668LAMP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello guys,

A couple years ago I submitted this patch which allows the user to set the =
'client-ip' as a convenient way to use the leased IP address received from =
OpenVPN server in NAT configuration. For example:

client-nat snat client-ip 255.255.255.255 172.20.1.15

, where 'client-ip' string is replaced with the leased IP address received =
from OpenVPN server.

At that time, it was NACKED due to the fact that I was using both client-ip=
 and localhost strings. So, it's changed now and I'd like to re-submit it a=
gain for appreciation.

Thanks

Gava

---------------------------------------------------------------------------=
-----------------------------------------------------------

From cb56f9bd4acaf28a2af256eead009310d8ba063f Mon Sep 17 00:00:00 2001
From: Rafael Gava de Oliveira <Rafael.Oliveira@...2056...>
Date: Sat, 12 Sep 2020 19:27:25 -0300
Subject: [PATCH] Allows the usage of the string 'client-ip' in the client-n=
at
network configuration in a way that is not necessary to inform the IP addre=
ss
beforehand. Openvpn will set dynamically the received IP from DHCP.

Example:

                client-nat snat client-ip 255.255.255.255 172.20.1.15

Replaces the 'client-ip' string with the DHCP address received from
the openvpn server.

Signed-off-by: Rafael Gava de Oliveira <Rafael.Oliveira@...2056...>
---
src/openvpn/clinat.c  | 45 ++++++++++++++++++++++++++++++++++++++++-----
src/openvpn/clinat.h  |  2 ++
src/openvpn/init.c    |  2 ++
src/openvpn/options.c |  2 +-
4 files changed, 45 insertions(+), 6 deletions(-)
mode change 100644 =3D> 100755 src/openvpn/clinat.c

diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
old mode 100644
new mode 100755
index b08fd54..865b0e2
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -128,12 +128,16 @@ add_client_nat_to_option_list(struct client_nat_optio=
n_list *dest,
         msg(msglevel, "client-nat: type must be 'snat' or 'dnat'");
         return;
     }
-
-    e.network =3D getaddr(0, network, 0, &ok, NULL);
-    if (!ok)
+    if (network && !strcmp(network, "client-ip"))
     {
-        msg(msglevel, "client-nat: bad network: %s", network);
-        return;
+        e.network =3D 0xFFFFFFFF;
+    } else {
+        e.network =3D getaddr(0, network, 0, &ok, NULL);
+        if (!ok)
+        {
+            msg(msglevel, "client-nat: bad network: %s", network);
+            return;
+        }
     }
     e.netmask =3D getaddr(0, netmask, 0, &ok, NULL);
     if (!ok)
@@ -276,3 +280,34 @@ client_nat_transform(const struct client_nat_option_li=
st *list,
         }
     }
}
+
+/*
+* Replaces the client-ip token with the IP received from OpenVPN Server
+*/
+bool
+update_client_ip_nat(struct client_nat_option_list *dest, in_addr_t local_=
ip)
+{
+    int i;
+    bool ret =3D false;
+
+    if (!dest)
+        return ret;
+
+    for (i=3D0; i <=3D dest->n; i++)
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
+            msg (M_INFO, "Updating NAT table client-ip to: %s", dot_ip);
+            ret =3D true;
+        }
+    }
+
+    return ret;
+}
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index eec7a03..c2941b9 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -64,4 +64,6 @@ void client_nat_transform(const struct client_nat_option_=
list *list,
                           struct buffer *ipbuf,
                           const int direction);
+bool update_client_ip_nat(struct client_nat_option_list *dest, in_addr_t l=
ocal_ip);
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
     ret =3D true;
     static_context =3D c;
#ifndef TARGET_ANDROID
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8bf82c5..26f11fa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -231,7 +231,7 @@ static const char usage_message[] =3D
     "                   ICMPv6 host unreachable messages on the client.\n"
     "                   (Server) Instead of forwarding IPv6 packets send\n"
     "                   ICMPv6 host unreachable packets to the client.\n"
-    "--client-nat snat|dnat network netmask alias : on client add 1-to-1 N=
AT rule.\n"
+    "--client-nat snat|dnat network|'client-ip' netmask alias : on client =
add 1-to-1 NAT rule.\n"
     "--push-peer-info : (client only) push client info to server.\n"
     "--setenv name value : Set a custom environmental variable to pass to =
script.\n"
     "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to =
allow\n"
--
2.7.4


--_000_CP2P152MB16680322F42D28AABF8A15EFA8210CP2P152MB1668LAMP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:70.85pt 85.05pt 70.85pt 85.05pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"PT-BR" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Aria=
l&quot;,sans-serif;color:#222222;background:white">Hello guys,</span><span =
lang=3D"EN-US" style=3D"font-family:&quot;Arial&quot;,sans-serif;color:#222=
222"><br>
<br>
<span style=3D"background:white">A couple years ago I submitted this patch =
which allows the user to set the 'client-ip' as a convenient way to use the=
 leased IP address received from OpenVPN server in NAT configuration. For e=
xample:</span><br>
<br>
<span style=3D"background:white">client-nat snat client-ip 255.255.255.255 =
172.20.1.15</span><br>
<br>
<span style=3D"background:white">, where 'client-ip' string is replaced wit=
h the leased IP address received from OpenVPN server.</span><br>
<br>
<span style=3D"background:white">At that time, it was NACKED due to the fac=
t that I was using both client-ip and localhost strings. So, it's changed n=
ow and I'd like to re-submit it again for appreciation.</span><br>
<br>
</span><span style=3D"font-family:&quot;Arial&quot;,sans-serif;color:#22222=
2;background:white">Thanks</span><span style=3D"font-family:&quot;Arial&quo=
t;,sans-serif;color:#222222"><br>
<br>
<span style=3D"background:white">Gava</span></span><span lang=3D"EN-US"><o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:#222222;background:white">---------------------------------------=
---------------------------------------------------------------------------=
--------------------</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">From cb56f9bd4acaf28a2af256eead=
009310d8ba063f Mon Sep 17 00:00:00 2001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">From: Rafael Gava de Oliveira &=
lt;Rafael.Oliveira@...2056...&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Date: Sat, 12 Sep 2020 19:27:25=
 -0300<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Subject: [PATCH] Allows the usa=
ge of the string 'client-ip' in the client-nat<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">network configuration in a way =
that is not necessary to inform the IP address<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">beforehand. Openvpn will set dy=
namically the received IP from DHCP.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Example:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client-nat snat=
 client-ip 255.255.255.255 172.20.1.15<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Replaces the 'client-ip' string=
 with the DHCP address received from<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">the openvpn server.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: Rafael Gava de O=
liveira &lt;Rafael.Oliveira@...2056...&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">src/openvpn/clinat.c&nbsp; | 45=
 ++++++++++++++++++++++++++++++++++++++++-----<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">src/openvpn/clinat.h&nbsp; |&nb=
sp; 2 ++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">src/openvpn/init.c&nbsp;&nbsp;&=
nbsp; |&nbsp; 2 ++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">src/openvpn/options.c |&nbsp; 2=
 +-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">4 files changed, 45 insertions(=
+), 6 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">mode change 100644 =3D&gt; 1007=
55 src/openvpn/clinat.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/src/openvpn/clinat=
.c b/src/openvpn/clinat.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">old mode 100644<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">new mode 100755<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index b08fd54..865b0e2<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/src/openvpn/clinat.c<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/src/openvpn/clinat.c<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -128,12 +128,16 @@ add_clien=
t_nat_to_option_list(struct client_nat_option_list *dest,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; msg(msglevel, &quot;client-nat: type must be 'snat' or 'd=
nat'&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp; e.network =
=3D getaddr(0, network, 0, &amp;ok, NULL);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp; if (!ok)<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; if (network=
 &amp;&amp; !strcmp(network, &quot;client-ip&quot;))<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; {<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; msg(msglevel, &quot;client-nat: bad network: %s&quot;, network=
);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; e.network =3D 0xFFFFFFFF;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; } else {<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; e.network =3D getaddr(0, network, 0, &amp;ok, NULL);<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (!ok)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg(msglevel, &quot;client-nat: bad ne=
twork: %s&quot;, network);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; e.netm=
ask =3D getaddr(0, netmask, 0, &amp;ok, NULL);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; if (!o=
k)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -276,3 +280,34 @@ client_nat=
_transform(const struct client_nat_option_list *list,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+* Replaces the client-ip token=
 with the IP received from OpenVPN Server<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+bool <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+update_client_ip_nat(struct cl=
ient_nat_option_list *dest, in_addr_t local_ip)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+{<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; int i;<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; bool ret =
=3D false;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; if (!dest)<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return ret;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; for (i=3D0;=
 i &lt;=3D dest-&gt;n; i++) <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; {<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; struct client_nat_entry *nat_entry =3D &amp;dest-&gt;entries[i=
];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (nat_entry &amp;&amp; nat_entry-&gt;network =3D=3D 0xFFFFFF=
FF)
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct in_addr addr;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nat_entry-&gt;network =3D ntohl(local_=
ip);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr.s_addr =3D nat_entry-&gt;network;=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *dot_ip =3D inet_ntoa(addr);<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg (M_INFO, &quot;Updating NAT table =
client-ip to: %s&quot;, dot_ip);
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D true;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; return ret;=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/src/openvpn/clinat=
.h b/src/openvpn/clinat.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index eec7a03..c2941b9 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/src/openvpn/clinat.h<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/src/openvpn/clinat.h<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -64,4 +64,6 @@ void client_n=
at_transform(const struct client_nat_option_list *list,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct buffer *ipbuf,<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const int direction);<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+bool update_client_ip_nat(stru=
ct client_nat_option_list *dest, in_addr_t local_ip);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#endif /* if !defined(CLINAT_H)=
 */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/src/openvpn/init.c=
 b/src/openvpn/init.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index a785934..8d6f9a8 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/src/openvpn/init.c<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/src/openvpn/init.c<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1920,6 +1920,8 @@ do_open_t=
un(struct context *c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SET_MTU_TUN | SET_MTU_UPPER_BOUND);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; </span=
>}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; update_clie=
nt_ip_nat(c-&gt;options.client_nat, c-&gt;c1.tuntap-&gt;local);<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D true;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; static=
_context =3D c;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#ifndef TARGET_ANDROID<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/src/openvpn/option=
s.c b/src/openvpn/options.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 8bf82c5..26f11fa 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/src/openvpn/options.c<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/src/openvpn/options.c<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -231,7 +231,7 @@ static cons=
t char usage_message[] =3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; &quot;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICMPv6 host unreachable messages on the c=
lient.\n&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; &quot;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Server) Instead of forwarding IPv6 packe=
ts send\n&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; &quot;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICMPv6 host unreachable packets to the cl=
ient.\n&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp; &quot;--cli=
ent-nat snat|dnat network netmask alias : on client add 1-to-1 NAT rule.\n&=
quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp; &quot;--cli=
ent-nat snat|dnat network|'client-ip' netmask alias : on client add 1-to-1 =
NAT rule.\n&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; &quot;=
--push-peer-info : (client only) push client info to server.\n&quot;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; &quot;=
--setenv name value : Set a custom environmental variable to pass to script=
.\n&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; &quot;=
--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to allow\=
n&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.7.4<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_CP2P152MB16680322F42D28AABF8A15EFA8210CP2P152MB1668LAMP_--

