MIME-Version: 1.0
Date: Mon, 26 Oct 2015 21:38:53 -0200
Message-ID: <CAAWBBYMWbgCy74zU6OWT+T9eopRNbBF-K7HeD27KRGwGXOkAeg@...278...>
From: Rafael Gava <gava100@...277...>
Content-Type: multipart/alternative; boundary=047d7bb03a6ec8b43105230a7666
Subject: [Openvpn-devel] [PATCH] Added client-ip option to NAT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--047d7bb03a6ec8b43105230a7666
Content-Type: text/plain; charset=UTF-8

Allow the user to use the string 'client-ip' on the client-nat network
configuration as a convenient way to use  the leased IP address received
from OpenVPN server. Usage  Example:

client-nat snat client-ip 255.255.255.255 172.20.1.15 # replaces the
'client-ip' string with the leased IP address received from OpenVPN server


---

From 2774d25c4c2947be7d1516f01cd520856e683db2 Mon Sep 17 00:00:00 2001
From: Rafael Gava <rafael.oliveira@...2056...>
Date: Mon, 26 Oct 2015 18:31:12 -0200
Subject: [PATCH] Allow the user to use the string 'client-ip' on the
 client-nat network configuration as a convenient way to use
 the leased IP address received from OpenVPN server. Usage
 Example:

client-nat snat client-ip 255.255.255.255 172.20.1.15 # replaces the
'client-ip' string with the leased IP address received from OpenVPN server

Signed-off-by: Rafael Gava <rafael.oliveira@...2056...>
---
 src/openvpn/clinat.c  |   38 ++++++++++++++++++++++++++++++++++++++
 src/openvpn/clinat.h  |    2 ++
 src/openvpn/init.c    |    2 ++
 src/openvpn/options.c |    1 +
 4 files changed, 43 insertions(+)
 mode change 100644 => 100755 src/openvpn/clinat.c
 mode change 100644 => 100755 src/openvpn/clinat.h
 mode change 100644 => 100755 src/openvpn/init.c
 mode change 100644 => 100755 src/openvpn/options.c

diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
old mode 100644
new mode 100755
index ddefe12..2ff4166
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -124,12 +124,19 @@ add_client_nat_to_option_list (struct
client_nat_option_list *dest,
       return;
     }

+  if (network && !strcmp(network, "client-ip"))
+    {
+      msg (M_INFO, "*** client-nat client-ip detected...");
+      e.network = 0xFFFFFFFF;
+    } else {
   e.network = getaddr(0, network, 0, &ok, NULL);
   if (!ok)
     {
       msg(msglevel, "client-nat: bad network: %s", network);
       return;
     }
+    }
+
   e.netmask = getaddr(0, netmask, 0, &ok, NULL);
   if (!ok)
     {
@@ -263,3 +270,34 @@ client_nat_transform (const struct
client_nat_option_list *list,
  }
     }
 }
+
+/*
+* Replaces the client_ip token with the IP received from OpenVPN
+*/
+bool
+update_client_ip_nat(struct client_nat_option_list *dest, in_addr_t
local_ip)
+{
+  int i;
+  bool ret = false;
+
+  if (!dest)
+    return ret;
+
+  for (i=0; i <= dest->n; i++)
+    {
+      struct client_nat_entry *nat_entry = &dest->entries[i];
+      if (nat_entry && nat_entry->network == 0xFFFFFFFF)
+        {
+          struct in_addr addr;
+
+          nat_entry->network = ntohl(local_ip);
+          addr.s_addr = nat_entry->network;
+          char *dot_ip = inet_ntoa(addr);
+
+          msg (M_INFO, "CNAT - Updating NAT table from client-ip to: %s",
dot_ip);
+          ret = true;
+        }
+    }
+
+  return ret;
+}
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
old mode 100644
new mode 100755
index a5779e1..156e84c
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -62,4 +62,6 @@ void client_nat_transform (const struct
client_nat_option_list *list,
    struct buffer *ipbuf,
    const int direction);

+bool update_client_ip_nat(struct client_nat_option_list *dest, in_addr_t
local_ip);
+
 #endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
old mode 100644
new mode 100755
index c5c0ab6..f54bc14
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1481,6 +1481,8 @@ do_open_tun (struct context *c)
        c->c1.tuntap->post_open_mtu,
        SET_MTU_TUN | SET_MTU_UPPER_BOUND);

+ update_client_ip_nat(c->options.client_nat, c->c1.tuntap->local);
+
       ret = true;
       static_context = c;
 #ifndef TARGET_ANDROID
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
old mode 100644
new mode 100755
index 2f8915d..c08e775
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -223,6 +223,7 @@ static const char usage_message[] =
   "--redirect-private [flags]: Like --redirect-gateway, but omit actually
changing\n"
   "                  the default gateway.  Useful when pushing private
subnets.\n"
   "--client-nat snat|dnat network netmask alias : on client add 1-to-1 NAT
rule.\n"
+  "                  Set the network parameter to 'client-ip' to use the
received ip from OpenVPN Server.\n"
 #ifdef ENABLE_PUSH_PEER_INFO
   "--push-peer-info : (client only) push client info to server.\n"
 #endif
-- 
1.7.9.5

--047d7bb03a6ec8b43105230a7666
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Allow the user to use the string &#39;client-ip&=
#39; on the client-nat network configuration as a convenient way to use =C2=
=A0the leased IP address received from OpenVPN server. Usage =C2=A0Example:=
</div><div><br></div><div>client-nat snat client-ip 255.255.255.255 172.20.=
1.15 # replaces the &#39;client-ip&#39; string with the leased IP address r=
eceived from OpenVPN server</div></div><div><br></div><div><br></div><div>-=
--</div><div><br></div><div>From 2774d25c4c2947be7d1516f01cd520856e683db2 M=
on Sep 17 00:00:00 2001</div><div>From: Rafael Gava &lt;<a href=3D"mailto:r=
afael.oliveira@...2056...">rafael.oliveira@...2056...</a>&gt;</div><div>Dat=
e: Mon, 26 Oct 2015 18:31:12 -0200</div><div>Subject: [PATCH] Allow the use=
r to use the string &#39;client-ip&#39; on the</div><div>=C2=A0client-nat n=
etwork configuration as a convenient way to use</div><div>=C2=A0the leased =
IP address received from OpenVPN server. Usage</div><div>=C2=A0Example:</di=
v><div><br></div><div>client-nat snat client-ip 255.255.255.255 172.20.1.15=
 # replaces the &#39;client-ip&#39; string with the leased IP address recei=
ved from OpenVPN server</div><div><br></div><div>Signed-off-by: Rafael Gava=
 &lt;<a href=3D"mailto:rafael.oliveira@...2056...">rafael.oliveira@...2059...=
..</a>&gt;</div><div>---</div><div>=C2=A0src/openvpn/clinat.c =C2=A0| =C2=
=A0 38 ++++++++++++++++++++++++++++++++++++++</div><div>=C2=A0src/openvpn/c=
linat.h =C2=A0| =C2=A0 =C2=A02 ++</div><div>=C2=A0src/openvpn/init.c =C2=A0=
 =C2=A0| =C2=A0 =C2=A02 ++</div><div>=C2=A0src/openvpn/options.c | =C2=A0 =
=C2=A01 +</div><div>=C2=A04 files changed, 43 insertions(+)</div><div>=C2=
=A0mode change 100644 =3D&gt; 100755 src/openvpn/clinat.c</div><div>=C2=A0m=
ode change 100644 =3D&gt; 100755 src/openvpn/clinat.h</div><div>=C2=A0mode =
change 100644 =3D&gt; 100755 src/openvpn/init.c</div><div>=C2=A0mode change=
 100644 =3D&gt; 100755 src/openvpn/options.c</div><div><br></div><div>diff =
--git a/src/openvpn/clinat.c b/src/openvpn/clinat.c</div><div>old mode 1006=
44</div><div>new mode 100755</div><div>index ddefe12..2ff4166</div><div>---=
 a/src/openvpn/clinat.c</div><div>+++ b/src/openvpn/clinat.c</div><div>@@ -=
124,12 +124,19 @@ add_client_nat_to_option_list (struct client_nat_option_l=
ist *dest,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0return;</div><div>=C2=A0 =
=C2=A0 =C2=A0}</div><div>=C2=A0</div><div>+ =C2=A0if (network &amp;&amp; !s=
trcmp(network, &quot;client-ip&quot;))</div><div>+ =C2=A0 =C2=A0{</div><div=
>+ =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;*** client-nat client-ip detected=
...&quot;);</div><div>+ =C2=A0 =C2=A0 =C2=A0e.network =3D 0xFFFFFFFF;</div>=
<div>+ =C2=A0 =C2=A0} else {</div><div>=C2=A0 =C2=A0e.network =3D getaddr(0=
, network, 0, &amp;ok, NULL);</div><div>=C2=A0 =C2=A0if (!ok)</div><div>=C2=
=A0 =C2=A0 =C2=A0{</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot=
;client-nat: bad network: %s&quot;, network);</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0return;</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0=
}</div><div>+ =C2=A0 =C2=A0</div><div>=C2=A0 =C2=A0e.netmask =3D getaddr(0,=
 netmask, 0, &amp;ok, NULL);</div><div>=C2=A0 =C2=A0if (!ok)</div><div>=C2=
=A0 =C2=A0 =C2=A0{</div><div>@@ -263,3 +270,34 @@ client_nat_transform (con=
st struct client_nat_option_list *list,</div><div>=C2=A0<span class=3D"" st=
yle=3D"white-space:pre">	</span>}</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div=
>=C2=A0}</div><div>+</div><div>+/*</div><div>+* Replaces the client_ip toke=
n with the IP received from OpenVPN</div><div>+*/</div><div>+bool=C2=A0</di=
v><div>+update_client_ip_nat(struct client_nat_option_list *dest, in_addr_t=
 local_ip)</div><div>+{</div><div>+ =C2=A0int i;</div><div>+ =C2=A0bool ret=
 =3D false;</div><div>+</div><div>+ =C2=A0if (!dest)</div><div>+ =C2=A0 =C2=
=A0return ret;</div><div>+</div><div>+ =C2=A0for (i=3D0; i &lt;=3D dest-&gt=
;n; i++)=C2=A0</div><div>+ =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0s=
truct client_nat_entry *nat_entry =3D &amp;dest-&gt;entries[i];</div><div>+=
 =C2=A0 =C2=A0 =C2=A0if (nat_entry &amp;&amp; nat_entry-&gt;network =3D=3D =
0xFFFFFFFF)=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct in_addr addr;</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nat_=
entry-&gt;network =3D ntohl(local_ip);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0addr.s_addr =3D nat_entry-&gt;network;</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0char *dot_ip =3D inet_ntoa(addr);</div><div>+</div><div=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;CNAT - Updating NAT=
 table from client-ip to: %s&quot;, dot_ip);=C2=A0</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ret =3D true;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}</div><div>+ =C2=A0 =C2=A0}</div><div>+</div><div>+ =C2=A0return ret;</=
div><div>+}</div><div>diff --git a/src/openvpn/clinat.h b/src/openvpn/clina=
t.h</div><div>old mode 100644</div><div>new mode 100755</div><div>index a57=
79e1..156e84c</div><div>--- a/src/openvpn/clinat.h</div><div>+++ b/src/open=
vpn/clinat.h</div><div>@@ -62,4 +62,6 @@ void client_nat_transform (const s=
truct client_nat_option_list *list,</div><div>=C2=A0<span class=3D"" style=
=3D"white-space:pre">			</span> =C2=A0 struct buffer *ipbuf,</div><div>=C2=
=A0<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0 const int d=
irection);</div><div>=C2=A0</div><div>+bool update_client_ip_nat(struct cli=
ent_nat_option_list *dest, in_addr_t local_ip);</div><div>+</div><div>=C2=
=A0#endif</div><div>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</d=
iv><div>old mode 100644</div><div>new mode 100755</div><div>index c5c0ab6..=
f54bc14</div><div>--- a/src/openvpn/init.c</div><div>+++ b/src/openvpn/init=
.c</div><div>@@ -1481,6 +1481,8 @@ do_open_tun (struct context *c)</div><di=
v>=C2=A0<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0 =C2=A0=
 =C2=A0 c-&gt;c1.tuntap-&gt;post_open_mtu,</div><div>=C2=A0<span class=3D""=
 style=3D"white-space:pre">			</span> =C2=A0 =C2=A0 =C2=A0 SET_MTU_TUN | SE=
T_MTU_UPPER_BOUND);</div><div>=C2=A0</div><div>+<span class=3D"" style=3D"w=
hite-space:pre">	</span>update_client_ip_nat(c-&gt;options.client_nat, c-&g=
t;c1.tuntap-&gt;local);</div><div>+</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0re=
t =3D true;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0static_context =3D c;</div=
><div>=C2=A0#ifndef TARGET_ANDROID</div><div>diff --git a/src/openvpn/optio=
ns.c b/src/openvpn/options.c</div><div>old mode 100644</div><div>new mode 1=
00755</div><div>index 2f8915d..c08e775</div><div>--- a/src/openvpn/options.=
c</div><div>+++ b/src/openvpn/options.c</div><div>@@ -223,6 +223,7 @@ stati=
c const char usage_message[] =3D</div><div>=C2=A0 =C2=A0&quot;--redirect-pr=
ivate [flags]: Like --redirect-gateway, but omit actually changing\n&quot;<=
/div><div>=C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0the default gateway.=C2=A0 Useful when pushing private sub=
nets.\n&quot;</div><div>=C2=A0 =C2=A0&quot;--client-nat snat|dnat network n=
etmask alias : on client add 1-to-1 NAT rule.\n&quot;</div><div>+ =C2=A0&qu=
ot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Set the n=
etwork parameter to &#39;client-ip&#39; to use the received ip from OpenVPN=
 Server.\n&quot;</div><div>=C2=A0#ifdef ENABLE_PUSH_PEER_INFO</div><div>=C2=
=A0 =C2=A0&quot;--push-peer-info : (client only) push client info to server=
.\n&quot;</div><div>=C2=A0#endif</div><div>--=C2=A0</div><div>1.7.9.5</div>=
<div><br></div></div>

--047d7bb03a6ec8b43105230a7666--

