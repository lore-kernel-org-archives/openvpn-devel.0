MIME-Version: 1.0
From: Rafael Gava <gava100@...277...>
Date: Tue, 5 Jul 2016 10:13:28 -0300
Message-ID: <CAAWBBYOc5H=0X7b=i_gizvTZUDv2RwxQUEOY85P6c3z-y_U8og@...278...>
Content-Type: multipart/alternative; boundary=001a113d81ca1292f00536e3382d
Subject: Re: [Openvpn-devel] [PATCH] Added client-ip option to NAT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne-openvpn@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113d81ca1292f00536e3382d
Content-Type: text/plain; charset=UTF-8

Hi Arne, sorry for replying so late.

Below is the NAT client-ip patch fixing the messed up whitespaces.
The only difference from the previous patch, besides the whitespaces, is
that I'm considering both strings 'client-ip' and 'localhost' as valid
options.

Please, whatever problem let me know.

BR

Rafael

--------

From cf9cf767df84ec5beb8c127d66bde4cd2d278b34 Mon Sep 17 00:00:00 2001
From: vntraol <Rafael.Oliveira@...2056...>
Date: Mon, 4 Jul 2016 17:20:38 -0300
Subject: [PATCH] Allow the user to use the string 'client-ip' on the
 client-nat network configuration as a convenient way to use
 the leased IP address received from the OpenVPN server.

Usage example:

client-nat snat client-ip 255.255.255.255 172.20.1.15 # replaces the
'client-ip' string with the leased IP address received from the OpenVPN
server

Signed-off-by: vntraol <Rafael.Oliveira@...2056...>
---
 src/openvpn/clinat.c  |   49
+++++++++++++++++++++++++++++++++++++++++++++----
 src/openvpn/clinat.h  |   10 ++++++++++
 src/openvpn/init.c    |    2 ++
 src/openvpn/options.c |    2 ++
 4 files changed, 59 insertions(+), 4 deletions(-)
 mode change 100644 => 100755 src/openvpn/clinat.c
 mode change 100644 => 100755 src/openvpn/clinat.h
 mode change 100644 => 100755 src/openvpn/init.c
 mode change 100644 => 100755 src/openvpn/options.c

diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
old mode 100644
new mode 100755
index ddefe12..713c821
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -124,12 +124,21 @@ add_client_nat_to_option_list (struct
client_nat_option_list *dest,
       return;
     }

-  e.network = getaddr(0, network, 0, &ok, NULL);
-  if (!ok)
+  if (network && (!strcmp(network, "client-ip") || !strcmp(network,
"localhost")) )
     {
-      msg(msglevel, "client-nat: bad network: %s", network);
-      return;
+      // To be replaced later on with the leased IP Address received from
Openvpn Server.
+      e.network = CLIENT_IP_MARKER;
+ }
+  else
+    {
+      e.network = getaddr(0, network, 0, &ok, NULL);
+      if (!ok)
+        {
+          msg(msglevel, "client-nat: bad network: %s", network);
+          return;
+        }
     }
+
   e.netmask = getaddr(0, netmask, 0, &ok, NULL);
   if (!ok)
     {
@@ -263,3 +272,35 @@ client_nat_transform (const struct
client_nat_option_list *list,
  }
     }
 }
+
+/*
+* Replaces the CLIENT_IP_MARKER with the leased IP address received from
OpenVPN Server.
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
+      if (nat_entry && nat_entry->network == CLIENT_IP_MARKER)
+        {
+          struct in_addr addr;
+
+          nat_entry->network = ntohl(local_ip);
+          addr.s_addr = nat_entry->network;
+          char *dot_ip = inet_ntoa(addr);
+
+          msg (D_CLIENT_NAT, "CNAT - Updating NAT table from
client-ip/localhost to: %s", dot_ip);
+          ret = true;
+        }
+    }
+
+  return ret;
+}
+
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
old mode 100644
new mode 100755
index a5779e1..bcd3fee
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -32,6 +32,11 @@
 #define CN_OUTGOING 0
 #define CN_INCOMING 1

+/*
+* Used as a marker to be replaced with the leased IP address received from
OpenVPN server.
+*/
+#define CLIENT_IP_MARKER 0xFFFFFFFF
+
 struct client_nat_entry {
 # define CN_SNAT 0
 # define CN_DNAT 1
@@ -62,4 +67,9 @@ void client_nat_transform (const struct
client_nat_option_list *list,
    struct buffer *ipbuf,
    const int direction);

+/*
+* Replaces the CLIENT_IP_MARKER with the leased IP address received from
OpenVPN Server.
+*/
+bool update_client_ip_nat(struct client_nat_option_list *dest, in_addr_t
local_ip);
+
 #endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
old mode 100644
new mode 100755
index 498d36f..e03d839
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1532,6 +1532,8 @@ do_open_tun (struct context *c)
        c->c1.tuntap->post_open_mtu,
        SET_MTU_TUN | SET_MTU_UPPER_BOUND);

+      update_client_ip_nat(c->options.client_nat, c->c1.tuntap->local);
+
       ret = true;
       static_context = c;
 #ifndef TARGET_ANDROID
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
old mode 100644
new mode 100755
index cf971a6..1c53c5f
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1,3 +1,4 @@
+
 /*
  *  OpenVPN -- An application to securely tunnel IP networks
  *             over a single UDP port, with support for SSL/TLS-based
@@ -220,6 +221,7 @@ static const char usage_message[] =
   "--redirect-private [flags]: Like --redirect-gateway, but omit actually
changing\n"
   "                  the default gateway.  Useful when pushing private
subnets.\n"
   "--client-nat snat|dnat network netmask alias : on client add 1-to-1 NAT
rule.\n"
+  "                  Set the network parameter to 'client-ip' or to
'localhost' to use the received ip from OpenVPN Server.\n"
 #ifdef ENABLE_PUSH_PEER_INFO
   "--push-peer-info : (client only) push client info to server.\n"
 #endif
-- 
1.7.9.5



On Thu, May 19, 2016 at 6:07 AM, Arne Schwabe <arne-openvpn@...1227...>
wrote:

>
>
> Am 04.05.16 um 19:40 schrieb Rafael Gava:
> > Reapplying client-ip NAT patch fixing the following issues raised by
> > Arne Schwabe:
> >
> >     - Fixing TABs and whitespaces;
> It is now more messed up :( There are a lot of changes to whitespace in
> the new patch.
>
> Arne
>

--001a113d81ca1292f00536e3382d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Arne, sorry for replying so late.=C2=A0<div><br></div><=
div>Below is the NAT client-ip patch fixing the messed up whitespaces.</div=
><div>The only difference from the previous patch, besides the whitespaces,=
 is that I&#39;m considering both strings &#39;client-ip&#39; and &#39;loca=
lhost&#39; as valid options.</div><div><br></div><div>Please, whatever prob=
lem let me know.</div><div><br></div><div>BR</div><div><br></div><div>Rafae=
l</div><div><div><br></div><div>--------</div><div><br></div><div><div>From=
 cf9cf767df84ec5beb8c127d66bde4cd2d278b34 Mon Sep 17 00:00:00 2001</div><di=
v>From: vntraol &lt;<a href=3D"mailto:Rafael.Oliveira@...2056...">Rafael.Ol=
iveira@...2056...</a>&gt;</div><div>Date: Mon, 4 Jul 2016 17:20:38 -0300</d=
iv><div>Subject: [PATCH] Allow the user to use the string &#39;client-ip&#3=
9; on the</div><div>=C2=A0client-nat network configuration as a convenient =
way to use</div><div>=C2=A0the leased IP address received from the OpenVPN =
server.</div><div><br></div><div>Usage example:</div><div><br></div><div>cl=
ient-nat snat client-ip 255.255.255.255 172.20.1.15 # replaces the &#39;cli=
ent-ip&#39; string with the leased IP address received from the OpenVPN ser=
ver</div><div><br></div><div>Signed-off-by: vntraol &lt;<a href=3D"mailto:R=
afael.Oliveira@...2056...">Rafael.Oliveira@...2056...</a>&gt;</div><div>---=
</div><div>=C2=A0src/openvpn/clinat.c =C2=A0| =C2=A0 49 +++++++++++++++++++=
++++++++++++++++++++++++++----</div><div>=C2=A0src/openvpn/clinat.h =C2=A0|=
 =C2=A0 10 ++++++++++</div><div>=C2=A0src/openvpn/init.c =C2=A0 =C2=A0| =C2=
=A0 =C2=A02 ++</div><div>=C2=A0src/openvpn/options.c | =C2=A0 =C2=A02 ++</d=
iv><div>=C2=A04 files changed, 59 insertions(+), 4 deletions(-)</div><div>=
=C2=A0mode change 100644 =3D&gt; 100755 src/openvpn/clinat.c</div><div>=C2=
=A0mode change 100644 =3D&gt; 100755 src/openvpn/clinat.h</div><div>=C2=A0m=
ode change 100644 =3D&gt; 100755 src/openvpn/init.c</div><div>=C2=A0mode ch=
ange 100644 =3D&gt; 100755 src/openvpn/options.c</div><div><br></div><div>d=
iff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c</div><div>old mode =
100644</div><div>new mode 100755</div><div>index ddefe12..713c821</div><div=
>--- a/src/openvpn/clinat.c</div><div>+++ b/src/openvpn/clinat.c</div><div>=
@@ -124,12 +124,21 @@ add_client_nat_to_option_list (struct client_nat_opti=
on_list *dest,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0return;</div><div>=C2=
=A0 =C2=A0 =C2=A0}</div><div>=C2=A0</div><div>- =C2=A0e.network =3D getaddr=
(0, network, 0, &amp;ok, NULL);</div><div>- =C2=A0if (!ok)</div><div>+ =C2=
=A0if (network &amp;&amp; (!strcmp(network, &quot;client-ip&quot;) || !strc=
mp(network, &quot;localhost&quot;)) )</div><div>=C2=A0 =C2=A0 =C2=A0{</div>=
<div>- =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot;client-nat: bad network: %s&=
quot;, network);</div><div>- =C2=A0 =C2=A0 =C2=A0return;</div><div>+ =C2=A0=
 =C2=A0 =C2=A0// To be replaced later on with the leased IP Address receive=
d from Openvpn Server.</div><div>+ =C2=A0 =C2=A0 =C2=A0e.network =3D CLIENT=
_IP_MARKER;</div><div>+<span class=3D"" style=3D"white-space:pre">	</span>}=
</div><div>+ =C2=A0else</div><div>+ =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=
=A0 =C2=A0e.network =3D getaddr(0, network, 0, &amp;ok, NULL);</div><div>+ =
=C2=A0 =C2=A0 =C2=A0if (!ok)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div>=
<div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot;client-nat: ba=
d network: %s&quot;, network);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0=
 =C2=A0}</div><div>+</div><div>=C2=A0 =C2=A0e.netmask =3D getaddr(0, netmas=
k, 0, &amp;ok, NULL);</div><div>=C2=A0 =C2=A0if (!ok)</div><div>=C2=A0 =C2=
=A0 =C2=A0{</div><div>@@ -263,3 +272,35 @@ client_nat_transform (const stru=
ct client_nat_option_list *list,</div><div>=C2=A0<span class=3D"" style=3D"=
white-space:pre">	</span>}</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0=
}</div><div>+</div><div>+/*</div><div>+* Replaces the CLIENT_IP_MARKER with=
 the leased IP address received from OpenVPN Server.</div><div>+*/</div><di=
v>+bool</div><div>+update_client_ip_nat(struct client_nat_option_list *dest=
, in_addr_t local_ip)</div><div>+{</div><div>+ =C2=A0int i;</div><div>+ =C2=
=A0bool ret =3D false;</div><div>+</div><div>+ =C2=A0if (!dest)</div><div>+=
 =C2=A0 =C2=A0return ret;</div><div>+</div><div>+ =C2=A0for (i=3D0; i &lt;=
=3D dest-&gt;n; i++)</div><div>+ =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =
=C2=A0struct client_nat_entry *nat_entry =3D &amp;dest-&gt;entries[i];</div=
><div>+ =C2=A0 =C2=A0 =C2=A0if (nat_entry &amp;&amp; nat_entry-&gt;network =
=3D=3D CLIENT_IP_MARKER)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct in_addr addr;</div><div>+</div>=
<div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nat_entry-&gt;network =3D ntohl(lo=
cal_ip);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr.s_addr =3D nat_=
entry-&gt;network;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *dot_=
ip =3D inet_ntoa(addr);</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0msg (D_CLIENT_NAT, &quot;CNAT - Updating NAT table from client-ip/lo=
calhost to: %s&quot;, dot_ip);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ret =3D true;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=
=A0 =C2=A0}</div><div>+</div><div>+ =C2=A0return ret;</div><div>+}</div><di=
v>+</div><div>diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h</div=
><div>old mode 100644</div><div>new mode 100755</div><div>index a5779e1..bc=
d3fee</div><div>--- a/src/openvpn/clinat.h</div><div>+++ b/src/openvpn/clin=
at.h</div><div>@@ -32,6 +32,11 @@</div><div>=C2=A0#define CN_OUTGOING 0</di=
v><div>=C2=A0#define CN_INCOMING 1</div><div>=C2=A0</div><div>+/*</div><div=
>+* Used as a marker to be replaced with the leased IP address received fro=
m OpenVPN server.</div><div>+*/</div><div>+#define CLIENT_IP_MARKER 0xFFFFF=
FFF</div><div>+</div><div>=C2=A0struct client_nat_entry {</div><div>=C2=A0#=
 define CN_SNAT 0</div><div>=C2=A0# define CN_DNAT 1</div><div>@@ -62,4 +67=
,9 @@ void client_nat_transform (const struct client_nat_option_list *list,=
</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">			</span> =C2=
=A0 struct buffer *ipbuf,</div><div>=C2=A0<span class=3D"" style=3D"white-s=
pace:pre">			</span> =C2=A0 const int direction);</div><div>=C2=A0</div><di=
v>+/*</div><div>+* Replaces the CLIENT_IP_MARKER with the leased IP address=
 received from OpenVPN Server.</div><div>+*/</div><div>+bool update_client_=
ip_nat(struct client_nat_option_list *dest, in_addr_t local_ip);</div><div>=
+</div><div>=C2=A0#endif</div><div>diff --git a/src/openvpn/init.c b/src/op=
envpn/init.c</div><div>old mode 100644</div><div>new mode 100755</div><div>=
index 498d36f..e03d839</div><div>--- a/src/openvpn/init.c</div><div>+++ b/s=
rc/openvpn/init.c</div><div>@@ -1532,6 +1532,8 @@ do_open_tun (struct conte=
xt *c)</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">			</span=
> =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap-&gt;post_open_mtu,</div><div>=C2=A0<=
span class=3D"" style=3D"white-space:pre">			</span> =C2=A0 =C2=A0 =C2=A0 S=
ET_MTU_TUN | SET_MTU_UPPER_BOUND);</div><div>=C2=A0</div><div>+ =C2=A0 =C2=
=A0 =C2=A0update_client_ip_nat(c-&gt;options.client_nat, c-&gt;c1.tuntap-&g=
t;local);</div><div>+</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D true;</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0static_context =3D c;</div><div>=C2=A0#i=
fndef TARGET_ANDROID</div><div>diff --git a/src/openvpn/options.c b/src/ope=
nvpn/options.c</div><div>old mode 100644</div><div>new mode 100755</div><di=
v>index cf971a6..1c53c5f</div><div>--- a/src/openvpn/options.c</div><div>++=
+ b/src/openvpn/options.c</div><div>@@ -1,3 +1,4 @@</div><div>+</div><div>=
=C2=A0/*</div><div>=C2=A0 * =C2=A0OpenVPN -- An application to securely tun=
nel IP networks</div><div>=C2=A0 * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 over a single UDP port, with support for SSL/TLS-based</div><div>@@ -22=
0,6 +221,7 @@ static const char usage_message[] =3D</div><div>=C2=A0 =C2=A0=
&quot;--redirect-private [flags]: Like --redirect-gateway, but omit actuall=
y changing\n&quot;</div><div>=C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the default gateway.=C2=A0 Useful whe=
n pushing private subnets.\n&quot;</div><div>=C2=A0 =C2=A0&quot;--client-na=
t snat|dnat network netmask alias : on client add 1-to-1 NAT rule.\n&quot;<=
/div><div>+ =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Set the network parameter to &#39;client-ip&#39; or to &#39;lo=
calhost&#39; to use the received ip from OpenVPN Server.\n&quot;</div><div>=
=C2=A0#ifdef ENABLE_PUSH_PEER_INFO</div><div>=C2=A0 =C2=A0&quot;--push-peer=
-info : (client only) push client info to server.\n&quot;</div><div>=C2=A0#=
endif</div><div>--=C2=A0</div><div>1.7.9.5</div><div><br></div></div><div><=
br></div><div><br></div><div><div class=3D"gmail_extra"><div class=3D"gmail=
_quote">On Thu, May 19, 2016 at 6:07 AM, Arne Schwabe <span dir=3D"ltr">&lt=
;<a href=3D"mailto:arne-openvpn@...1227..." target=3D"_blank">arne-openvpn@=
...1227...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex"><br>
<br>
Am 04.05.16 um 19:40 schrieb Rafael Gava:<br>
<span class=3D"">&gt; Reapplying client-ip NAT patch fixing the following i=
ssues raised by<br>
&gt; Arne Schwabe:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Fixing TABs and whitespaces;<br>
</span>It is now more messed up :( There are a lot of changes to whitespace=
 in<br>
the new patch.<br>
<span class=3D""><font color=3D"#888888"><br>
Arne<br>
</font></span></blockquote></div><br></div></div></div></div>

--001a113d81ca1292f00536e3382d--

