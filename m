MIME-Version: 1.0
Date: Wed, 4 May 2016 14:40:10 -0300
Message-ID: <CAAWBBYM2fvyqsK5yK6QBs2yztrs_S6=uugVgRCcVyyseUgG0tw@...278...>
From: Rafael Gava <gava100@...277...>
Content-Type: multipart/alternative; boundary=001a113c68c4a2d68f053207b7d8
Subject: [Openvpn-devel] [PATCH] Added client-ip option to NAT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113c68c4a2d68f053207b7d8
Content-Type: text/plain; charset=UTF-8

Reapplying client-ip NAT patch fixing the following issues raised by Arne
Schwabe:

    - Fixing TABs and whitespaces;
    - Added comments to the Client IP Marker.

Thanks

Rafael

--------

From 6bc85f6ef89f27771c48e1e6d837302d5dad0910 Mon Sep 17 00:00:00 2001
From: vntraol <Rafael.Oliveira@...2056...>
Date: Wed, 4 May 2016 13:48:36 -0300
Subject: [PATCH] Allow the user to use the string 'client-ip' on the
 client-nat network configuration as a convenient way to use
 the leased IP address received from the OpenVPN server.

Usage example:

client-nat snat client-ip 255.255.255.255 172.20.1.15 # replaces the
'client-ip' string with the leased IP address received from the OpenVPN
server

Signed-off-by: vntraol <Rafael.Oliveira@...2056...>
---
 src/openvpn/clinat.c  |  168
++++++++++++++++++++++++++++++-------------------
 src/openvpn/clinat.h  |   24 ++++---
 src/openvpn/init.c    |    2 +
 src/openvpn/options.c |    1 +
 4 files changed, 124 insertions(+), 71 deletions(-)
 mode change 100644 => 100755 src/openvpn/clinat.c
 mode change 100644 => 100755 src/openvpn/clinat.h
 mode change 100644 => 100755 src/openvpn/init.c
 mode change 100644 => 100755 src/openvpn/options.c

diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
old mode 100644
new mode 100755
index ddefe12..b03dbf6
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -37,7 +37,7 @@

 static bool
 add_entry(struct client_nat_option_list *dest,
-  const struct client_nat_entry *e)
+    const struct client_nat_entry *e)
 {
   if (dest->n >= MAX_CLIENT_NAT)
     {
@@ -61,15 +61,15 @@ print_client_nat_list(const struct
client_nat_option_list *list, int msglevel)
   if (list)
     {
       for (i = 0; i < list->n; ++i)
- {
-  const struct client_nat_entry *e = &list->entries[i];
-  msg (msglevel, "  CNAT[%d] t=%d %s/%s/%s",
-       i,
-       e->type,
-       print_in_addr_t (e->network, IA_NET_ORDER, &gc),
-       print_in_addr_t (e->netmask, IA_NET_ORDER, &gc),
-       print_in_addr_t (e->foreign_network, IA_NET_ORDER, &gc));
- }
+        {
+          const struct client_nat_entry *e = &list->entries[i];
+          msg (msglevel, "  CNAT[%d] t=%d %s/%s/%s",
+          i,
+          e->type,
+          print_in_addr_t (e->network, IA_NET_ORDER, &gc),
+          print_in_addr_t (e->netmask, IA_NET_ORDER, &gc),
+          print_in_addr_t (e->foreign_network, IA_NET_ORDER, &gc));
+        }
     }
   gc_free (&gc);
 }
@@ -93,23 +93,23 @@ clone_client_nat_option_list (const struct
client_nat_option_list *src, struct g

 void
 copy_client_nat_option_list (struct client_nat_option_list *dest,
-     const struct client_nat_option_list *src)
+                 const struct client_nat_option_list *src)
 {
   int i;
   for (i = 0; i < src->n; ++i)
     {
       if (!add_entry(dest, &src->entries[i]))
- break;
+        break;
     }
 }

 void
 add_client_nat_to_option_list (struct client_nat_option_list *dest,
-      const char *type,
-      const char *network,
-      const char *netmask,
-      const char *foreign_network,
-      int msglevel)
+                  const char *type,
+                  const char *network,
+                  const char *netmask,
+                  const char *foreign_network,
+                  int msglevel)
 {
   struct client_nat_entry e;
   bool ok;
@@ -124,12 +124,21 @@ add_client_nat_to_option_list (struct
client_nat_option_list *dest,
       return;
     }

-  e.network = getaddr(0, network, 0, &ok, NULL);
-  if (!ok)
+  if (network && !strcmp(network, "client-ip"))
     {
-      msg(msglevel, "client-nat: bad network: %s", network);
-      return;
+      // To be replaced later on with the leased IP Address received from
Openvpn Server.
+      e.network = CLIENT_IP_MARKER;
+    }
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
@@ -184,8 +193,8 @@ print_pkt (struct openvpn_iphdr *iph, const char
*prefix, const int direction, c

 void
 client_nat_transform (const struct client_nat_option_list *list,
-      struct buffer *ipbuf,
-      const int direction)
+                  struct buffer *ipbuf,
+                  const int direction)
 {
   struct ip_tcp_udp_hdr *h = (struct ip_tcp_udp_hdr *) BPTR (ipbuf);
   int i;
@@ -202,64 +211,95 @@ client_nat_transform (const struct
client_nat_option_list *list,
     {
       const struct client_nat_entry *e = &list->entries[i]; /* current NAT
rule */
       if (e->type ^ direction)
- {
-  addr = *(addr_ptr = &h->ip.daddr);
-  amask = 2;
- }
+        {
+          addr = *(addr_ptr = &h->ip.daddr);
+          amask = 2;
+        }
       else
- {
-  addr = *(addr_ptr = &h->ip.saddr);
-  amask = 1;
- }
+        {
+          addr = *(addr_ptr = &h->ip.saddr);
+          amask = 1;
+        }
       if (direction)
- {
-  from = &e->foreign_network;
-  to = &e->network;
- }
+        {
+          from = &e->foreign_network;
+          to = &e->network;
+        }
       else
- {
-  from = &e->network;
-  to = &e->foreign_network;
- }
+        {
+          from = &e->network;
+          to = &e->foreign_network;
+        }

       if (((addr & e->netmask) == *from) && !(amask & alog))
- {
-  /* pre-adjust IP checksum */
-  ADD_CHECKSUM_32(accumulate, addr);
+        {
+          /* pre-adjust IP checksum */
+          ADD_CHECKSUM_32(accumulate, addr);

-  /* do NAT transform */
-  addr = (addr & ~e->netmask) | *to;
+          /* do NAT transform */
+          addr = (addr & ~e->netmask) | *to;

-  /* post-adjust IP checksum */
-  SUB_CHECKSUM_32(accumulate, addr);
+          /* post-adjust IP checksum */
+          SUB_CHECKSUM_32(accumulate, addr);

-  /* write the modified address to packet */
-  *addr_ptr = addr;
+          /* write the modified address to packet */
+          *addr_ptr = addr;

-  /* mark as modified */
-  alog |= amask;
- }
+          /* mark as modified */
+          alog |= amask;
+        }
     }
   if (alog)
     {
       if (check_debug_level (D_CLIENT_NAT))
- print_pkt (&h->ip, "AFTER", direction, D_CLIENT_NAT);
+        print_pkt (&h->ip, "AFTER", direction, D_CLIENT_NAT);

       ADJUST_CHECKSUM(accumulate, h->ip.check);

       if (h->ip.protocol == OPENVPN_IPPROTO_TCP)
- {
-  if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct
openvpn_tcphdr))
-    {
-      ADJUST_CHECKSUM(accumulate, h->u.tcp.check);
-    }
- }
+        {
+          if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct
openvpn_tcphdr))
+            {
+              ADJUST_CHECKSUM(accumulate, h->u.tcp.check);
+            }
+        }
       else if (h->ip.protocol == OPENVPN_IPPROTO_UDP)
- {
-  if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct
openvpn_udphdr))
-    {
-      ADJUST_CHECKSUM(accumulate, h->u.udp.check);
-    }
- }
+        {
+          if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct
openvpn_udphdr))
+            {
+              ADJUST_CHECKSUM(accumulate, h->u.udp.check);
+            }
+        }
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
index a5779e1..8c84005
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -32,6 +32,11 @@
 #define CN_OUTGOING 0
 #define CN_INCOMING 1

+/*
+  Used as a marker to replace with the leased IP address received from
OpenVPN server.
+*/
+#define CLIENT_IP_MARKER 0xFFFFFFFF
+
 struct client_nat_entry {
 # define CN_SNAT 0
 # define CN_DNAT 1
@@ -52,14 +57,19 @@ void copy_client_nat_option_list (struct
client_nat_option_list *dest, const str
 void print_client_nat_list(const struct client_nat_option_list *list, int
msglevel);

 void add_client_nat_to_option_list (struct client_nat_option_list *dest,
-    const char *type,
-    const char *network,
-    const char *netmask,
-    const char *foreign_network,
-    int msglevel);
+            const char *type,
+            const char *network,
+            const char *netmask,
+            const char *foreign_network,
+            int msglevel);

 void client_nat_transform (const struct client_nat_option_list *list,
-   struct buffer *ipbuf,
-   const int direction);
+        struct buffer *ipbuf,
+        const int direction);
+
+/*
+* Replaces the CLIENT_IP_MARKER with the leased IP address received from
OpenVPN Server.
+*/
+bool update_client_ip_nat(struct client_nat_option_list *dest, in_addr_t
local_ip);

 #endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
old mode 100644
new mode 100755
index 42baf97..8359b29
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1526,6 +1526,8 @@ do_open_tun (struct context *c)
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
index 764ca74..e81d525
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



On Thu, Apr 28, 2016 at 1:20 PM, Arne Schwabe <arne@...1227...> wrote:

> Am 28.04.16 um 04:01 schrieb Rafael Gava:
> > Hi Arne,
> >
> > what a surprise I thought that the NAT patch had been dropped. :-)
>
> More or less forgotten. IIrc the active FTP part was controversal. This
> part is okay.
>
> > So, please, should I change the code based on your comments and resend
> > the patch?
>
> Yes, please.
>
> Arne
>

--001a113c68c4a2d68f053207b7d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reapplying client-ip NAT patch fixing the following i=
ssues raised by Arne Schwabe:</div><div><br></div><div>=C2=A0 =C2=A0 - Fixi=
ng TABs and whitespaces;</div><div>=C2=A0 =C2=A0 - Added comments to the Cl=
ient IP Marker.</div><div><br></div><div>Thanks=C2=A0</div><div><br></div><=
div>Rafael</div><div><br></div><div>--------</div><div><br></div><div><div>=
From 6bc85f6ef89f27771c48e1e6d837302d5dad0910 Mon Sep 17 00:00:00 2001</di=
v><div>From: vntraol &lt;<a href=3D"mailto:Rafael.Oliveira@...2056...">Rafa=
el.Oliveira@...2056...</a>&gt;</div><div>Date: Wed, 4 May 2016 13:48:36 -03=
00</div><div>Subject: [PATCH] Allow the user to use the string &#39;client-=
ip&#39; on the</div><div>=C2=A0client-nat network configuration as a conven=
ient way to use</div><div>=C2=A0the leased IP address received from the Ope=
nVPN server.</div><div><br></div><div>Usage example:</div><div><br></div><d=
iv>client-nat snat client-ip 255.255.255.255 172.20.1.15 # replaces the &#3=
9;client-ip&#39; string with the leased IP address received from the OpenVP=
N server</div><div><br></div><div>Signed-off-by: vntraol &lt;<a href=3D"mai=
lto:Rafael.Oliveira@...2056...">Rafael.Oliveira@...2056...</a>&gt;</div><di=
v>---</div><div>=C2=A0src/openvpn/clinat.c =C2=A0| =C2=A0168 ++++++++++++++=
++++++++++++++++-------------------</div><div>=C2=A0src/openvpn/clinat.h =
=C2=A0| =C2=A0 24 ++++---</div><div>=C2=A0src/openvpn/init.c =C2=A0 =C2=A0|=
 =C2=A0 =C2=A02 +</div><div>=C2=A0src/openvpn/options.c | =C2=A0 =C2=A01 +<=
/div><div>=C2=A04 files changed, 124 insertions(+), 71 deletions(-)</div><d=
iv>=C2=A0mode change 100644 =3D&gt; 100755 src/openvpn/clinat.c</div><div>=
=C2=A0mode change 100644 =3D&gt; 100755 src/openvpn/clinat.h</div><div>=C2=
=A0mode change 100644 =3D&gt; 100755 src/openvpn/init.c</div><div>=C2=A0mod=
e change 100644 =3D&gt; 100755 src/openvpn/options.c</div><div><br></div><d=
iv>diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c</div><div>old m=
ode 100644</div><div>new mode 100755</div><div>index ddefe12..b03dbf6</div>=
<div>--- a/src/openvpn/clinat.c</div><div>+++ b/src/openvpn/clinat.c</div><=
div>@@ -37,7 +37,7 @@</div><div>=C2=A0</div><div>=C2=A0static bool</div><di=
v>=C2=A0add_entry(struct client_nat_option_list *dest,</div><div>-<span cla=
ss=3D"" style=3D"white-space:pre">	</span> =C2=A0const struct client_nat_en=
try *e)</div><div>+ =C2=A0 =C2=A0const struct client_nat_entry *e)</div><di=
v>=C2=A0{</div><div>=C2=A0 =C2=A0if (dest-&gt;n &gt;=3D MAX_CLIENT_NAT)</di=
v><div>=C2=A0 =C2=A0 =C2=A0{</div><div>@@ -61,15 +61,15 @@ print_client_nat=
_list(const struct client_nat_option_list *list, int msglevel)</div><div>=
=C2=A0 =C2=A0if (list)</div><div>=C2=A0 =C2=A0 =C2=A0{</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; list-&gt;n; ++i)</div><div>-<span cla=
ss=3D"" style=3D"white-space:pre">	</span>{</div><div>-<span class=3D"" sty=
le=3D"white-space:pre">	</span> =C2=A0const struct client_nat_entry *e =3D =
&amp;list-&gt;entries[i];</div><div>-<span class=3D"" style=3D"white-space:=
pre">	</span> =C2=A0msg (msglevel, &quot; =C2=A0CNAT[%d] t=3D%d %s/%s/%s&qu=
ot;,</div><div>-<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 =
=C2=A0 =C2=A0 i,</div><div>-<span class=3D"" style=3D"white-space:pre">	</s=
pan> =C2=A0 =C2=A0 =C2=A0 e-&gt;type,</div><div>-<span class=3D"" style=3D"=
white-space:pre">	</span> =C2=A0 =C2=A0 =C2=A0 print_in_addr_t (e-&gt;netwo=
rk, IA_NET_ORDER, &amp;gc),</div><div>-<span class=3D"" style=3D"white-spac=
e:pre">	</span> =C2=A0 =C2=A0 =C2=A0 print_in_addr_t (e-&gt;netmask, IA_NET=
_ORDER, &amp;gc),</div><div>-<span class=3D"" style=3D"white-space:pre">	</=
span> =C2=A0 =C2=A0 =C2=A0 print_in_addr_t (e-&gt;foreign_network, IA_NET_O=
RDER, &amp;gc));</div><div>-<span class=3D"" style=3D"white-space:pre">	</s=
pan>}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0const struct client_nat_entry *e =3D &amp;list-&gt;entr=
ies[i];</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (msglevel, &quot;=
 =C2=A0CNAT[%d] t=3D%d %s/%s/%s&quot;,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0i,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e-&gt;type,</div=
><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_in_addr_t (e-&gt;network, I=
A_NET_ORDER, &amp;gc),</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_=
in_addr_t (e-&gt;netmask, IA_NET_ORDER, &amp;gc),</div><div>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0print_in_addr_t (e-&gt;foreign_network, IA_NET_ORDER, =
&amp;gc));</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0=
 =C2=A0}</div><div>=C2=A0 =C2=A0gc_free (&amp;gc);</div><div>=C2=A0}</div><=
div>@@ -93,23 +93,23 @@ clone_client_nat_option_list (const struct client_n=
at_option_list *src, struct g</div><div>=C2=A0</div><div>=C2=A0void</div><d=
iv>=C2=A0copy_client_nat_option_list (struct client_nat_option_list *dest,<=
/div><div>-<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0 =C2=
=A0 const struct client_nat_option_list *src)</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct client_nat_option_list =
*src)</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0int i;</div><div>=C2=A0 =C2=
=A0for (i =3D 0; i &lt; src-&gt;n; ++i)</div><div>=C2=A0 =C2=A0 =C2=A0{</di=
v><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!add_entry(dest, &amp;src-&gt;entries=
[i]))</div><div>-<span class=3D"" style=3D"white-space:pre">	</span>break;<=
/div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0break;</div><div>=C2=A0 =C2=A0 =C2=
=A0}</div><div>=C2=A0}</div><div>=C2=A0</div><div>=C2=A0void</div><div>=C2=
=A0add_client_nat_to_option_list (struct client_nat_option_list *dest,</div=
><div>-<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0 =C2=A0 =
=C2=A0const char *type,</div><div>-<span class=3D"" style=3D"white-space:pr=
e">			</span> =C2=A0 =C2=A0 =C2=A0const char *network,</div><div>-<span cla=
ss=3D"" style=3D"white-space:pre">			</span> =C2=A0 =C2=A0 =C2=A0const char=
 *netmask,</div><div>-<span class=3D"" style=3D"white-space:pre">			</span>=
 =C2=A0 =C2=A0 =C2=A0const char *foreign_network,</div><div>-<span class=3D=
"" style=3D"white-space:pre">			</span> =C2=A0 =C2=A0 =C2=A0int msglevel)</=
div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0co=
nst char *type,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *network,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *netmask,</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *fore=
ign_network,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0int msglevel)</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0struct =
client_nat_entry e;</div><div>=C2=A0 =C2=A0bool ok;</div><div>@@ -124,12 +1=
24,21 @@ add_client_nat_to_option_list (struct client_nat_option_list *dest=
,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0return;</div><div>=C2=A0 =C2=A0 =C2=
=A0}</div><div>=C2=A0</div><div>- =C2=A0e.network =3D getaddr(0, network, 0=
, &amp;ok, NULL);</div><div>- =C2=A0if (!ok)</div><div>+ =C2=A0if (network =
&amp;&amp; !strcmp(network, &quot;client-ip&quot;))</div><div>=C2=A0 =C2=A0=
 =C2=A0{</div><div>- =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot;client-nat: ba=
d network: %s&quot;, network);</div><div>- =C2=A0 =C2=A0 =C2=A0return;</div=
><div>+ =C2=A0 =C2=A0 =C2=A0// To be replaced later on with the leased IP A=
ddress received from Openvpn Server.</div><div>+ =C2=A0 =C2=A0 =C2=A0e.netw=
ork =3D CLIENT_IP_MARKER;</div><div>+ =C2=A0 =C2=A0}=C2=A0</div><div>+ =C2=
=A0else=C2=A0</div><div>+ =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0e.=
network =3D getaddr(0, network, 0, &amp;ok, NULL);</div><div>+ =C2=A0 =C2=
=A0 =C2=A0if (!ok)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot;client-nat: bad network:=
 %s&quot;, network);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<=
/div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0}</d=
iv><div>+ =C2=A0 =C2=A0</div><div>=C2=A0 =C2=A0e.netmask =3D getaddr(0, net=
mask, 0, &amp;ok, NULL);</div><div>=C2=A0 =C2=A0if (!ok)</div><div>=C2=A0 =
=C2=A0 =C2=A0{</div><div>@@ -184,8 +193,8 @@ print_pkt (struct openvpn_iphd=
r *iph, const char *prefix, const int direction, c</div><div>=C2=A0</div><d=
iv>=C2=A0void</div><div>=C2=A0client_nat_transform (const struct client_nat=
_option_list *list,</div><div>-<span class=3D"" style=3D"white-space:pre">	=
	</span> =C2=A0 =C2=A0 =C2=A0struct buffer *ipbuf,</div><div>-<span class=
=3D"" style=3D"white-space:pre">		</span> =C2=A0 =C2=A0 =C2=A0const int dir=
ection)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0struct buffer *ipbuf,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int direction)</div><div>=C2=A0{</div><di=
v>=C2=A0 =C2=A0struct ip_tcp_udp_hdr *h =3D (struct ip_tcp_udp_hdr *) BPTR =
(ipbuf);</div><div>=C2=A0 =C2=A0int i;</div><div>@@ -202,64 +211,95 @@ clie=
nt_nat_transform (const struct client_nat_option_list *list,</div><div>=C2=
=A0 =C2=A0 =C2=A0{</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct client=
_nat_entry *e =3D &amp;list-&gt;entries[i]; /* current NAT rule */</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (e-&gt;type ^ direction)</div><div>-<span c=
lass=3D"" style=3D"white-space:pre">	</span>{</div><div>-<span class=3D"" s=
tyle=3D"white-space:pre">	</span> =C2=A0addr =3D *(addr_ptr =3D &amp;h-&gt;=
ip.daddr);</div><div>-<span class=3D"" style=3D"white-space:pre">	</span> =
=C2=A0amask =3D 2;</div><div>-<span class=3D"" style=3D"white-space:pre">	<=
/span>}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0addr =3D *(addr_ptr =3D &amp;h-&gt;ip.daddr);</div><div=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amask =3D 2;</div><div>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0else</div><div>-<span =
class=3D"" style=3D"white-space:pre">	</span>{</div><div>-<span class=3D"" =
style=3D"white-space:pre">	</span> =C2=A0addr =3D *(addr_ptr =3D &amp;h-&gt=
;ip.saddr);</div><div>-<span class=3D"" style=3D"white-space:pre">	</span> =
=C2=A0amask =3D 1;</div><div>-<span class=3D"" style=3D"white-space:pre">	<=
/span>}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0addr =3D *(addr_ptr =3D &amp;h-&gt;ip.saddr);</div><div=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amask =3D 1;</div><div>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (direction)</div><d=
iv>-<span class=3D"" style=3D"white-space:pre">	</span>{</div><div>-<span c=
lass=3D"" style=3D"white-space:pre">	</span> =C2=A0from =3D &amp;e-&gt;fore=
ign_network;</div><div>-<span class=3D"" style=3D"white-space:pre">	</span>=
 =C2=A0to =3D &amp;e-&gt;network;</div><div>-<span class=3D"" style=3D"whit=
e-space:pre">	</span>}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =3D &amp;e-&gt;foreign_network;</di=
v><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to =3D &amp;e-&gt;network;</div>=
<div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0el=
se</div><div>-<span class=3D"" style=3D"white-space:pre">	</span>{</div><di=
v>-<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0from =3D &amp;=
e-&gt;network;</div><div>-<span class=3D"" style=3D"white-space:pre">	</spa=
n> =C2=A0to =3D &amp;e-&gt;foreign_network;</div><div>-<span class=3D"" sty=
le=3D"white-space:pre">	</span>}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</=
div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =3D &amp;e-&gt;network;</=
div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to =3D &amp;e-&gt;foreign_netw=
ork;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (((addr &amp; e-&gt;netmask) =3D=3D *from) &a=
mp;&amp; !(amask &amp; alog))</div><div>-<span class=3D"" style=3D"white-sp=
ace:pre">	</span>{</div><div>-<span class=3D"" style=3D"white-space:pre">	<=
/span> =C2=A0/* pre-adjust IP checksum */</div><div>-<span class=3D"" style=
=3D"white-space:pre">	</span> =C2=A0ADD_CHECKSUM_32(accumulate, addr);</div=
><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* pre-adjust IP checksum */</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ADD_CHECKSUM_32(accumulate, addr);</div><div>=C2=A0</div><div>-<s=
pan class=3D"" style=3D"white-space:pre">	</span> =C2=A0/* do NAT transform=
 */</div><div>-<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0ad=
dr =3D (addr &amp; ~e-&gt;netmask) | *to;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* do NAT transform */</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0addr =3D (addr &amp; ~e-&gt;netmask) | *to;</div><div>=C2=A0</div><d=
iv>-<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0/* post-adjus=
t IP checksum */</div><div>-<span class=3D"" style=3D"white-space:pre">	</s=
pan> =C2=A0SUB_CHECKSUM_32(accumulate, addr);</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* post-adjust IP checksum */</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0SUB_CHECKSUM_32(accumulate, addr);</div><div>=C2=A0</di=
v><div>-<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0/* write =
the modified address to packet */</div><div>-<span class=3D"" style=3D"whit=
e-space:pre">	</span> =C2=A0*addr_ptr =3D addr;</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* write the modified address to packet */</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*addr_ptr =3D addr;</div><div>=C2=A0</div=
><div>-<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0/* mark as=
 modified */</div><div>-<span class=3D"" style=3D"white-space:pre">	</span>=
 =C2=A0alog |=3D amask;</div><div>-<span class=3D"" style=3D"white-space:pr=
e">	</span>}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* mark as modif=
ied */</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0alog |=3D amask;</div>=
<div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0}</div><d=
iv>=C2=A0 =C2=A0if (alog)</div><div>=C2=A0 =C2=A0 =C2=A0{</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (check_debug_level (D_CLIENT_NAT))</div><div>-<span =
class=3D"" style=3D"white-space:pre">	</span>print_pkt (&amp;h-&gt;ip, &quo=
t;AFTER&quot;, direction, D_CLIENT_NAT);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0print_pkt (&amp;h-&gt;ip, &quot;AFTER&quot;, direction, D_CLIENT_NAT)=
;</div><div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0ADJUST_CHECKSUM(acc=
umulate, h-&gt;ip.check);</div><div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (h-&gt;ip.protocol =3D=3D OPENVPN_IPPROTO_TCP)</div><div>-<span cl=
ass=3D"" style=3D"white-space:pre">	</span>{</div><div>-<span class=3D"" st=
yle=3D"white-space:pre">	</span> =C2=A0if (BLEN(ipbuf) &gt;=3D sizeof(struc=
t openvpn_iphdr) + sizeof(struct openvpn_tcphdr))</div><div>-<span class=3D=
"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0{</div><div>-<span class=
=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0 =C2=A0ADJUST_CHECKSU=
M(accumulate, h-&gt;u.tcp.check);</div><div>-<span class=3D"" style=3D"whit=
e-space:pre">	</span> =C2=A0 =C2=A0}</div><div>-<span class=3D"" style=3D"w=
hite-space:pre">	</span>}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><di=
v>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (BLEN(ipbuf) &gt;=3D sizeof(struct=
 openvpn_iphdr) + sizeof(struct openvpn_tcphdr))</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ADJUST_CHECKSUM(accumulate, h-&gt;u.tcp.check);</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0else if (h-&gt;ip.protocol =
=3D=3D OPENVPN_IPPROTO_UDP)</div><div>-<span class=3D"" style=3D"white-spac=
e:pre">	</span>{</div><div>-<span class=3D"" style=3D"white-space:pre">	</s=
pan> =C2=A0if (BLEN(ipbuf) &gt;=3D sizeof(struct openvpn_iphdr) + sizeof(st=
ruct openvpn_udphdr))</div><div>-<span class=3D"" style=3D"white-space:pre"=
>	</span> =C2=A0 =C2=A0{</div><div>-<span class=3D"" style=3D"white-space:p=
re">	</span> =C2=A0 =C2=A0 =C2=A0ADJUST_CHECKSUM(accumulate, h-&gt;u.udp.ch=
eck);</div><div>-<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0=
 =C2=A0}</div><div>-<span class=3D"" style=3D"white-space:pre">	</span>}</d=
iv><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (BLEN(ipbuf) &gt;=3D sizeof(struct openvpn_iphdr) + sizeof(str=
uct openvpn_udphdr))</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{=
</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADJUST_CHECKSU=
M(accumulate, h-&gt;u.udp.check);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =
=C2=A0 =C2=A0}</div><div>=C2=A0}</div><div>+</div><div>+/*</div><div>+* Rep=
laces the CLIENT_IP_MARKER with the leased IP address received from OpenVPN=
 Server.</div><div>+*/</div><div>+bool=C2=A0</div><div>+update_client_ip_na=
t(struct client_nat_option_list *dest, in_addr_t local_ip)</div><div>+{</di=
v><div>+ =C2=A0int i;</div><div>+ =C2=A0bool ret =3D false;</div><div>+</di=
v><div>+ =C2=A0if (!dest)</div><div>+ =C2=A0 =C2=A0return ret;</div><div>+<=
/div><div>+ =C2=A0for (i=3D0; i &lt;=3D dest-&gt;n; i++)=C2=A0</div><div>+ =
=C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0struct client_nat_entry *nat=
_entry =3D &amp;dest-&gt;entries[i];</div><div>+ =C2=A0 =C2=A0 =C2=A0if (na=
t_entry &amp;&amp; nat_entry-&gt;network =3D=3D CLIENT_IP_MARKER)=C2=A0</di=
v><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct in_addr addr;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nat_entry-&gt;network =3D=
 ntohl(local_ip);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr.s_addr=
 =3D nat_entry-&gt;network;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
har *dot_ip =3D inet_ntoa(addr);</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;CNAT - Updating NAT table from client-i=
p to: %s&quot;, dot_ip);=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ret =3D true;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=
=A0 =C2=A0}</div><div>+</div><div>+ =C2=A0return ret;</div><div>+}</div><di=
v>diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h</div><div>old mo=
de 100644</div><div>new mode 100755</div><div>index a5779e1..8c84005</div><=
div>--- a/src/openvpn/clinat.h</div><div>+++ b/src/openvpn/clinat.h</div><d=
iv>@@ -32,6 +32,11 @@</div><div>=C2=A0#define CN_OUTGOING 0</div><div>=C2=
=A0#define CN_INCOMING 1</div><div>=C2=A0</div><div>+/*</div><div>+ =C2=A0U=
sed as a marker to replace with the leased IP address received from OpenVPN=
 server.</div><div>+*/</div><div>+#define CLIENT_IP_MARKER 0xFFFFFFFF</div>=
<div>+</div><div>=C2=A0struct client_nat_entry {</div><div>=C2=A0# define C=
N_SNAT 0</div><div>=C2=A0# define CN_DNAT 1</div><div>@@ -52,14 +57,19 @@ v=
oid copy_client_nat_option_list (struct client_nat_option_list *dest, const=
 str</div><div>=C2=A0void print_client_nat_list(const struct client_nat_opt=
ion_list *list, int msglevel);</div><div>=C2=A0</div><div>=C2=A0void add_cl=
ient_nat_to_option_list (struct client_nat_option_list *dest,</div><div>-<s=
pan class=3D"" style=3D"white-space:pre">				</span> =C2=A0 =C2=A0const cha=
r *type,</div><div>-<span class=3D"" style=3D"white-space:pre">				</span> =
=C2=A0 =C2=A0const char *network,</div><div>-<span class=3D"" style=3D"whit=
e-space:pre">				</span> =C2=A0 =C2=A0const char *netmask,</div><div>-<span=
 class=3D"" style=3D"white-space:pre">				</span> =C2=A0 =C2=A0const char *=
foreign_network,</div><div>-<span class=3D"" style=3D"white-space:pre">				=
</span> =C2=A0 =C2=A0int msglevel);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0const char *type,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const char *network,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const char *netmask,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const char *foreign_network,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int msglevel);</div><div>=C2=A0</div><div>=C2=A0void clien=
t_nat_transform (const struct client_nat_option_list *list,</div><div>-<spa=
n class=3D"" style=3D"white-space:pre">			</span> =C2=A0 struct buffer *ipb=
uf,</div><div>-<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0=
 const int direction);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0struct buffer=
 *ipbuf,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0const int direction);</div>=
<div>+</div><div>+/*</div><div>+* Replaces the CLIENT_IP_MARKER with the le=
ased IP address received from OpenVPN Server.</div><div>+*/</div><div>+bool=
 update_client_ip_nat(struct client_nat_option_list *dest, in_addr_t local_=
ip);</div><div>=C2=A0</div><div>=C2=A0#endif</div><div>diff --git a/src/ope=
nvpn/init.c b/src/openvpn/init.c</div><div>old mode 100644</div><div>new mo=
de 100755</div><div>index 42baf97..8359b29</div><div>--- a/src/openvpn/init=
.c</div><div>+++ b/src/openvpn/init.c</div><div>@@ -1526,6 +1526,8 @@ do_op=
en_tun (struct context *c)</div><div>=C2=A0<span class=3D"" style=3D"white-=
space:pre">			</span> =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap-&gt;post_open_mt=
u,</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">			</span> =
=C2=A0 =C2=A0 =C2=A0 SET_MTU_TUN | SET_MTU_UPPER_BOUND);</div><div>=C2=A0</=
div><div>+<span class=3D"" style=3D"white-space:pre">	</span>update_client_=
ip_nat(c-&gt;options.client_nat, c-&gt;c1.tuntap-&gt;local);</div><div>+</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D true;</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0static_context =3D c;</div><div>=C2=A0#ifndef TARGET_ANDROID</=
div><div>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</div><d=
iv>old mode 100644</div><div>new mode 100755</div><div>index 764ca74..e81d5=
25</div><div>--- a/src/openvpn/options.c</div><div>+++ b/src/openvpn/option=
s.c</div><div>@@ -223,6 +223,7 @@ static const char usage_message[] =3D</di=
v><div>=C2=A0 =C2=A0&quot;--redirect-private [flags]: Like --redirect-gatew=
ay, but omit actually changing\n&quot;</div><div>=C2=A0 =C2=A0&quot; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the default gateway=
.=C2=A0 Useful when pushing private subnets.\n&quot;</div><div>=C2=A0 =C2=
=A0&quot;--client-nat snat|dnat network netmask alias : on client add 1-to-=
1 NAT rule.\n&quot;</div><div>+ =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Set the network parameter to &#39;client-=
ip&#39; to use the received ip from OpenVPN Server.\n&quot;</div><div>=C2=
=A0#ifdef ENABLE_PUSH_PEER_INFO</div><div>=C2=A0 =C2=A0&quot;--push-peer-in=
fo : (client only) push client info to server.\n&quot;</div><div>=C2=A0#end=
if</div><div>--=C2=A0</div><div>1.7.9.5</div><div><br></div></div><br><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Apr 28, 2016 a=
t 1:20 PM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@...2068...=
7..." target=3D"_blank">arne@...1227...</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-lef=
t:1ex">Am 28.04.16 um 04:01 schrieb Rafael Gava:<br>
<span class=3D"">&gt; Hi Arne,<br>
&gt;<br>
&gt; what a surprise I thought that the NAT patch had been dropped. :-)<br>
<br>
</span>More or less forgotten. IIrc the active FTP part was controversal. T=
his<br>
part is okay.<br>
<span class=3D""><br>
&gt; So, please, should I change the code based on your comments and resend=
<br>
&gt; the patch?<br>
<br>
</span>Yes, please.<br>
<span class=3D""><font color=3D"#888888"><br>
Arne<br>
</font></span></blockquote></div><br></div></div>

--001a113c68c4a2d68f053207b7d8--

