From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 6 Nov 2023 17:32:51 +0000
References: <gerrit.1699291967000.Ice8b95f953c3f7e71657a78ea12b02a08c60aa67@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7c3726a795f0379b5b9c8617e6411a9b6636d3fe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ni+yr0k2Sfw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tun: use is_tun_p2p
 more consistently
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Ni+yr0k2Sfw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/380?usp=3Demail

to review the following change.


Change subject: tun: use is_tun_p2p more consistently
......................................................................

tun: use is_tun_p2p more consistently

Using "tun" as the variable name for the return of
is_tun_p2p is probably a historical accident. But
it has actual consequences in that the other code
often seems to assume that it does less checks
than it actually does.

Use "tun_p2p" as the variable name and remove checks
that are not required. Also use is_tun_p2p in more
places.

Change-Id: Ice8b95f953c3f7e71657a78ea12b02a08c60aa67
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/tun.c
1 file changed, 48 insertions(+), 72 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/380/1

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f857ed1..45559fc 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -507,31 +507,31 @@
 static const char ifconfig_warn_how_to_silence[] =3D "(silence this warnin=
g with --ifconfig-nowarn)";

 /*
- * If !tun, make sure ifconfig_remote_netmask looks
+ * If !tun_p2p, make sure ifconfig_remote_netmask looks
  *  like a netmask.
  *
- * If tun, make sure ifconfig_remote_netmask looks
+ * If tun_p2p, make sure ifconfig_remote_netmask looks
  *  like an IPv4 address.
  */
 static void
-ifconfig_sanity_check(bool tun, in_addr_t addr, int topology)
+ifconfig_sanity_check(bool tun_p2p, in_addr_t addr)
 {
     struct gc_arena gc =3D gc_new();
     const bool looks_like_netmask =3D ((addr & 0xFF000000) =3D=3D 0xFF0000=
00);
-    if (tun)
+    if (tun_p2p)
     {
-        if (looks_like_netmask && (topology =3D=3D TOP_NET30 || topology =
=3D=3D TOP_P2P))
+        if (looks_like_netmask)
         {
             msg(M_WARN, "WARNING: Since you are using --dev tun with a poi=
nt-to-point topology, the second argument to --ifconfig must be an IP addre=
ss.  You are using something (%s) that looks more like a netmask. %s",
                 print_in_addr_t(addr, 0, &gc),
                 ifconfig_warn_how_to_silence);
         }
     }
-    else /* tap */
+    else
     {
         if (!looks_like_netmask)
         {
-            msg(M_WARN, "WARNING: Since you are using --dev tap, the secon=
d argument to --ifconfig must be a netmask, for example something like 255.=
255.255.0. %s",
+            msg(M_WARN, "WARNING: Since you are using subnet topology, the=
 second argument to --ifconfig must be a netmask, for example something lik=
e 255.255.255.0. %s",
                 ifconfig_warn_how_to_silence);
         }
     }
@@ -675,13 +675,13 @@
     struct buffer out =3D alloc_buf_gc(256, gc);
     if (tt->did_ifconfig_setup && !disable)
     {
-        if (tt->type =3D=3D DEV_TYPE_TAP || (tt->type =3D=3D DEV_TYPE_TUN =
&& tt->topology =3D=3D TOP_SUBNET))
+        if (!is_tun_p2p(tt))
         {
             buf_printf(&out, "%s %s",
                        print_in_addr_t(tt->local & tt->remote_netmask, 0, =
gc),
                        print_in_addr_t(tt->remote_netmask, 0, gc));
         }
-        else if (tt->type =3D=3D DEV_TYPE_TUN)
+        else if (tt->type =3D=3D DEV_TYPE_TUN) /* tun p2p topology */
         {
             const char *l, *r;
             if (remote)
@@ -745,24 +745,24 @@
 bool
 is_tun_p2p(const struct tuntap *tt)
 {
-    bool tun =3D false;
+    bool tun_p2p =3D false;

     if (tt->type =3D=3D DEV_TYPE_TAP
         || (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNET)
         || tt->type =3D=3D DEV_TYPE_NULL)
     {
-        tun =3D false;
+        tun_p2p =3D false;
     }
     else if (tt->type =3D=3D DEV_TYPE_TUN)
     {
-        tun =3D true;
+        tun_p2p =3D true;
     }
     else
     {
         msg(M_FATAL, "Error: problem with tun vs. tap setting"); /* JYFIXM=
E -- needs to be caught earlier, in init_tun? */

     }
-    return tun;
+    return tun_p2p;
 }

 /*
@@ -839,12 +839,10 @@

     if (ifconfig_local_parm && ifconfig_remote_netmask_parm)
     {
-        bool tun =3D false;
-
         /*
          * We only handle TUN/TAP devices here, not --dev null devices.
          */
-        tun =3D is_tun_p2p(tt);
+        bool tun_p2p =3D is_tun_p2p(tt);

         /*
          * Convert arguments to binary IPv4 addresses.
@@ -861,7 +859,7 @@
             NULL);

         tt->remote_netmask =3D getaddr(
-            (tun ? GETADDR_RESOLVE : 0)
+            (tun_p2p ? GETADDR_RESOLVE : 0)
             | GETADDR_HOST_ORDER
             | GETADDR_FATAL_ON_SIGNAL
             | GETADDR_FATAL,
@@ -876,7 +874,7 @@
         if (strict_warn)
         {
             struct addrinfo *curele;
-            ifconfig_sanity_check(tt->type =3D=3D DEV_TYPE_TUN, tt->remote=
_netmask, tt->topology);
+            ifconfig_sanity_check(tun_p2p, tt->remote_netmask);

             /*
              * If local_public or remote_public addresses are defined,
@@ -907,11 +905,11 @@
                 }
             }

-            if (tt->type =3D=3D DEV_TYPE_TAP || (tt->type =3D=3D DEV_TYPE_=
TUN && tt->topology =3D=3D TOP_SUBNET))
+            if (!tun_p2p)
             {
                 check_subnet_conflict(tt->local, tt->remote_netmask, "TUN/=
TAP adapter");
             }
-            else if (tt->type =3D=3D DEV_TYPE_TUN)
+            else
             {
                 check_subnet_conflict(tt->local, IPV4_NETMASK_HOST, "TUN/T=
AP adapter");
             }
@@ -922,7 +920,7 @@
          * Make sure that both ifconfig addresses are part of the
          * same .252 subnet.
          */
-        if (tun)
+        if (tun_p2p)
         {
             verify_255_255_255_252(tt->local, tt->remote_netmask);
             tt->adapter_netmask =3D ~3;
@@ -1305,7 +1303,7 @@
     /*
      * We only handle TUN/TAP devices here, not --dev null devices.
      */
-    bool tun =3D is_tun_p2p(tt);
+    bool tun_p2p =3D is_tun_p2p(tt);
 #endif

 #if !defined(TARGET_LINUX)
@@ -1332,7 +1330,7 @@
         msg(M_FATAL, "Linux can't bring %s up", ifname);
     }

-    if (tun)
+    if (tun_p2p)
     {
         if (net_addr_ptp_v4_add(ctx, ifname, &tt->local,
                                 &tt->remote_netmask) < 0)
@@ -1351,27 +1349,8 @@
 #elif defined(TARGET_ANDROID)
     char out[64];

-    char *top;
-    switch (tt->topology)
-    {
-        case TOP_NET30:
-            top =3D "net30";
-            break;
-
-        case TOP_P2P:
-            top =3D "p2p";
-            break;
-
-        case TOP_SUBNET:
-            top =3D "subnet";
-            break;
-
-        default:
-            top =3D "undef";
-    }
-
     openvpn_snprintf(out, sizeof(out), "%s %s %d %s", ifconfig_local,
-                     ifconfig_remote_netmask, tun_mtu, top);
+                     ifconfig_remote_netmask, tun_mtu, print_topology(tt->=
topology));
     management_android_control(management, "IFCONFIG", out);

 #elif defined(TARGET_SOLARIS)
@@ -1380,7 +1359,7 @@
      *    ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 up
      *    ifconfig tun2 netmask 255.255.255.255
      */
-    if (tun)
+    if (tun_p2p)
     {
         argv_printf(&argv, "%s %s %s %s mtu %d up", IFCONFIG_PATH, ifname,
                     ifconfig_local, ifconfig_remote_netmask, tun_mtu);
@@ -1394,13 +1373,13 @@
         argv_printf(&argv, "%s %s netmask 255.255.255.255", IFCONFIG_PATH,
                     ifname);
     }
-    else if (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNE=
T)
+    else if (tt->type =3D=3D DEV_TYPE_TUN)
     {
         argv_printf(&argv, "%s %s %s %s netmask %s mtu %d up", IFCONFIG_PA=
TH,
                     ifname, ifconfig_local, ifconfig_local,
                     ifconfig_remote_netmask, tun_mtu);
     }
-    else
+    else /* tap */
     {
         argv_printf(&argv, "%s %s %s netmask %s up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
@@ -1413,7 +1392,7 @@
         solaris_error_close(tt, es, ifname, false);
     }

-    if (!tun && tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SU=
BNET)
+    if (!tun_p2p && tt->type =3D=3D DEV_TYPE_TUN)
     {
         /* Add a network route for the local tun interface */
         struct route_ipv4 r;
@@ -1437,14 +1416,14 @@
      */

     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.2=
55.255 up */
-    if (tun)
+    if (tun_p2p)
     {
         argv_printf(&argv,
                     "%s %s %s %s mtu %d netmask 255.255.255.255 up -link0",
                     IFCONFIG_PATH, ifname, ifconfig_local,
                     ifconfig_remote_netmask, tun_mtu);
     }
-    else if (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNE=
T)
+    else if (tt->type =3D=3D DEV_TYPE_TUN)
     {
         remote_end =3D create_arbitrary_remote( tt );
         argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up -link0",
@@ -1452,7 +1431,7 @@
                     print_in_addr_t(remote_end, 0, &gc), tun_mtu,
                     ifconfig_remote_netmask);
     }
-    else
+    else /* tap */
     {
         argv_printf(&argv, "%s %s %s netmask %s mtu %d link0",
                     IFCONFIG_PATH, ifname, ifconfig_local,
@@ -1462,7 +1441,7 @@
     openvpn_execve_check(&argv, es, S_FATAL, "OpenBSD ifconfig failed");

     /* Add a network route for the local tun interface */
-    if (!tun && tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SU=
BNET)
+    if (!tun_p2p && tt->type =3D=3D DEV_TYPE_TUN)
     {
         struct route_ipv4 r;
         CLEAR(r);
@@ -1476,20 +1455,20 @@
 #elif defined(TARGET_NETBSD)
     in_addr_t remote_end =3D INADDR_ANY;  /* for "virtual" subnet topology=
 */

-    if (tun)
+    if (tun_p2p)
     {
         argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
                     ifconfig_remote_netmask, tun_mtu);
     }
-    else if (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNE=
T)
+    else if (tt->type =3D=3D DEV_TYPE_TUN)
     {
         remote_end =3D create_arbitrary_remote(tt);
         argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up", IFCONFIG_PA=
TH,
                     ifname, ifconfig_local, print_in_addr_t(remote_end, 0,=
 &gc),
                     tun_mtu, ifconfig_remote_netmask);
     }
-    else
+    else /* tap */
     {
         /*
          * NetBSD has distinct tun and tap devices
@@ -1504,7 +1483,7 @@
     openvpn_execve_check(&argv, es, S_FATAL, "NetBSD ifconfig failed");

     /* Add a network route for the local tun interface */
-    if (!tun && tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SU=
BNET)
+    if (!tun_p2p && tt->type =3D=3D DEV_TYPE_TUN)
     {
         struct route_ipv4 r;
         CLEAR(r);
@@ -1528,33 +1507,30 @@


     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.2=
55.255 up */
-    if (tun)
+    if (tun_p2p)
     {
         argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
                     ifconfig_remote_netmask, tun_mtu);
     }
-    else
+    else if (tt->type =3D=3D DEV_TYPE_TUN)
     {
-        if (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNET)
-        {
-            argv_printf(&argv, "%s %s %s %s netmask %s mtu %d up",
-                        IFCONFIG_PATH, ifname, ifconfig_local, ifconfig_lo=
cal,
-                        ifconfig_remote_netmask, tun_mtu);
-        }
-        else
-        {
-            argv_printf(&argv, "%s %s %s netmask %s mtu %d up", IFCONFIG_P=
ATH,
-                        ifname, ifconfig_local, ifconfig_remote_netmask,
-                        tun_mtu);
-        }
+        argv_printf(&argv, "%s %s %s %s netmask %s mtu %d up",
+                    IFCONFIG_PATH, ifname, ifconfig_local, ifconfig_local,
+                    ifconfig_remote_netmask, tun_mtu);
+    }
+    else /* tap */
+    {
+        argv_printf(&argv, "%s %s %s netmask %s mtu %d up", IFCONFIG_PATH,
+                    ifname, ifconfig_local, ifconfig_remote_netmask,
+                    tun_mtu);
     }

     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, S_FATAL, "Mac OS X ifconfig failed");

     /* Add a network route for the local tun interface */
-    if (!tun && tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SU=
BNET)
+    if (!tun_p2p && tt->type =3D=3D DEV_TYPE_TUN)
     {
         struct route_ipv4 r;
         CLEAR(r);
@@ -1568,7 +1544,7 @@
 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)

     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.2=
55.255 up */
-    if (tun)       /* point-to-point tun */
+    if (tun_p2p)    /* point-to-point tun */
     {
         argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
@@ -1590,7 +1566,7 @@
         struct env_set *aix_es =3D env_set_create(NULL);
         env_set_add( aix_es, "ODMDIR=3D/etc/objrepos" );

-        if (tun)
+        if (tt->type =3D=3D DEV_TYPE_TUN)
         {
             msg(M_FATAL, "no tun support on AIX (canthappen)");
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/380?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ice8b95f953c3f7e71657a78ea12b02a08c60aa67
Gerrit-Change-Number: 380
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Ni+yr0k2Sfw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/380?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">tun: use is_tun_p2p more consistently<br><br>Using &quot;tun&=
quot; as the variable name for the return of<br>is_tun_p2p is probably a hi=
storical accident. But<br>it has actual consequences in that the other code=
<br>often seems to assume that it does less checks<br>than it actually does=
.<br><br>Use &quot;tun_p2p&quot; as the variable name and remove checks<br>=
that are not required. Also use is_tun_p2p in more<br>places.<br><br>Change=
-Id: Ice8b95f953c3f7e71657a78ea12b02a08c60aa67<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/tun.c<br>1 file ch=
anged, 48 insertions(+), 72 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/80/380/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/tun.c b/src/openvpn/tun.c</span><br><span>index f857ed1..45559fc 100644=
</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/=
tun.c</span><br><span>@@ -507,31 +507,31 @@</span><br><span> static const c=
har ifconfig_warn_how_to_silence[] =3D &quot;(silence this warning with --i=
fconfig-nowarn)&quot;;</span><br><span> </span><br><span> /*</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * If !tun, make sure ifconfig_remot=
e_netmask looks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * I=
f !tun_p2p, make sure ifconfig_remote_netmask looks</span><br><span>  *  li=
ke a netmask.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * If tun, make sure ifconfig_remote_netmask looks</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * If tun_p2p, make sure ifconfi=
g_remote_netmask looks</span><br><span>  *  like an IPv4 address.</span><br=
><span>  */</span><br><span> static void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-ifconfig_sanity_check(bool tun, in_addr_t addr, int topo=
logy)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_sanit=
y_check(bool tun_p2p, in_addr_t addr)</span><br><span> {</span><br><span>  =
   struct gc_arena gc =3D gc_new();</span><br><span>     const bool looks_l=
ike_netmask =3D ((addr &amp; 0xFF000000) =3D=3D 0xFF000000);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (tun)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (looks_like_=
netmask &amp;&amp; (topology =3D=3D TOP_NET30 || topology =3D=3D TOP_P2P))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (looks_li=
ke_netmask)</span><br><span>         {</span><br><span>             msg(M_W=
ARN, &quot;WARNING: Since you are using --dev tun with a point-to-point top=
ology, the second argument to --ifconfig must be an IP address.  You are us=
ing something (%s) that looks more like a netmask. %s&quot;,</span><br><spa=
n>                 print_in_addr_t(addr, 0, &amp;gc),</span><br><span>     =
            ifconfig_warn_how_to_silence);</span><br><span>         }</span=
><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
else /* tap */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse</span><br><span>     {</span><br><span>         if (!looks_like_netmask=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(M_WARN, &quot;WARNING: Since you are using --dev tap=
, the second argument to --ifconfig must be a netmask, for example somethin=
g like 255.255.255.0. %s&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(M_WARN, &quot;WARNING: Since you are using subn=
et topology, the second argument to --ifconfig must be a netmask, for examp=
le something like 255.255.255.0. %s&quot;,</span><br><span>                =
 ifconfig_warn_how_to_silence);</span><br><span>         }</span><br><span>=
     }</span><br><span>@@ -675,13 +675,13 @@</span><br><span>     struct bu=
ffer out =3D alloc_buf_gc(256, gc);</span><br><span>     if (tt-&gt;did_ifc=
onfig_setup &amp;&amp; !disable)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (tt-&gt;type =3D=3D DEV_TYPE_T=
AP || (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TO=
P_SUBNET))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (!is_tun_p2p(tt))</span><br><span>         {</span><br><span>            =
 buf_printf(&amp;out, &quot;%s %s&quot;,</span><br><span>                  =
      print_in_addr_t(tt-&gt;local &amp; tt-&gt;remote_netmask, 0, gc),</sp=
an><br><span>                        print_in_addr_t(tt-&gt;remote_netmask,=
 0, gc));</span><br><span>         }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        else if (tt-&gt;type =
=3D=3D DEV_TYPE_TUN) /* tun p2p topology */</span><br><span>         {</spa=
n><br><span>             const char *l, *r;</span><br><span>             if=
 (remote)</span><br><span>@@ -745,24 +745,24 @@</span><br><span> bool</span=
><br><span> is_tun_p2p(const struct tuntap *tt)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    bool tun =3D false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    bool tun_p2p =3D false=
;</span><br><span> </span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TA=
P</span><br><span>         || (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; t=
t-&gt;topology =3D=3D TOP_SUBNET)</span><br><span>         || tt-&gt;type =
=3D=3D DEV_TYPE_NULL)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        tun =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        tun_p2p =3D false;</span><br><span>     }=
</span><br><span>     else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tu=
n =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
tun_p2p =3D true;</span><br><span>     }</span><br><span>     else</span><b=
r><span>     {</span><br><span>         msg(M_FATAL, &quot;Error: problem w=
ith tun vs. tap setting&quot;); /* JYFIXME -- needs to be caught earlier, i=
n init_tun? */</span><br><span> </span><br><span>     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return tun;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return tun_p2p;</span><br><span> }</span>=
<br><span> </span><br><span> /*</span><br><span>@@ -839,12 +839,10 @@</span=
><br><span> </span><br><span>     if (ifconfig_local_parm &amp;&amp; ifconf=
ig_remote_netmask_parm)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        bool tun =3D false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /*</span><br><spa=
n>          * We only handle TUN/TAP devices here, not --dev null devices.<=
/span><br><span>          */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        tun =3D is_tun_p2p(tt);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        bool tun_p2p =3D is_tun_p2p(tt);</span><br><span=
> </span><br><span>         /*</span><br><span>          * Convert argument=
s to binary IPv4 addresses.</span><br><span>@@ -861,7 +859,7 @@</span><br><=
span>             NULL);</span><br><span> </span><br><span>         tt-&gt;=
remote_netmask =3D getaddr(</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            (tun ? GETADDR_RESOLVE : 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            (tun_p2p ? GETADDR_RESOLVE : 0)</span=
><br><span>             | GETADDR_HOST_ORDER</span><br><span>             |=
 GETADDR_FATAL_ON_SIGNAL</span><br><span>             | GETADDR_FATAL,</spa=
n><br><span>@@ -876,7 +874,7 @@</span><br><span>         if (strict_warn)</=
span><br><span>         {</span><br><span>             struct addrinfo *cur=
ele;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ifcon=
fig_sanity_check(tt-&gt;type =3D=3D DEV_TYPE_TUN, tt-&gt;remote_netmask, tt=
-&gt;topology);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        ifconfig_sanity_check(tun_p2p, tt-&gt;remote_netmask);</span><br><s=
pan> </span><br><span>             /*</span><br><span>              * If lo=
cal_public or remote_public addresses are defined,</span><br><span>@@ -907,=
11 +905,11 @@</span><br><span>                 }</span><br><span>          =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            if (tt-&gt;type =3D=3D DEV_TYPE_TAP || (tt-&gt;type =3D=3D DEV=
_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (!tun_p2p)</span><br><s=
pan>             {</span><br><span>                 check_subnet_conflict(t=
t-&gt;local, tt-&gt;remote_netmask, &quot;TUN/TAP adapter&quot;);</span><br=
><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span>        =
     {</span><br><span>                 check_subnet_conflict(tt-&gt;local,=
 IPV4_NETMASK_HOST, &quot;TUN/TAP adapter&quot;);</span><br><span>         =
    }</span><br><span>@@ -922,7 +920,7 @@</span><br><span>          * Make =
sure that both ifconfig addresses are part of the</span><br><span>         =
 * same .252 subnet.</span><br><span>          */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (tun)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (tun_p2p)</span><br><span>         {</s=
pan><br><span>             verify_255_255_255_252(tt-&gt;local, tt-&gt;remo=
te_netmask);</span><br><span>             tt-&gt;adapter_netmask =3D ~3;</s=
pan><br><span>@@ -1305,7 +1303,7 @@</span><br><span>     /*</span><br><span=
>      * We only handle TUN/TAP devices here, not --dev null devices.</span=
><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  bool tun =3D is_tun_p2p(tt);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bool tun_p2p =3D is_tun_p2p(tt);</span><br><span> #endif</sp=
an><br><span> </span><br><span> #if !defined(TARGET_LINUX)</span><br><span>=
@@ -1332,7 +1330,7 @@</span><br><span>         msg(M_FATAL, &quot;Linux can=
&#39;t bring %s up&quot;, ifname);</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tun)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)</span><br><=
span>     {</span><br><span>         if (net_addr_ptp_v4_add(ctx, ifname, &=
amp;tt-&gt;local,</span><br><span>                                 &amp;tt-=
&gt;remote_netmask) &lt; 0)</span><br><span>@@ -1351,27 +1349,8 @@</span><b=
r><span> #elif defined(TARGET_ANDROID)</span><br><span>     char out[64];</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
har *top;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (=
tt-&gt;topology)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TOP_NET3=
0:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            top =3D=
 &quot;net30&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TOP_P2P:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            top =3D &quot;=
p2p&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        case TOP_SUBNET:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            top =3D &quot;subnet=
&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            br=
eak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            top =3D &quot;undef&quot;;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     openvpn_snprintf(out=
, sizeof(out), &quot;%s %s %d %s&quot;, ifconfig_local,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                     ifconfig_remote_netm=
ask, tun_mtu, top);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                     ifconfig_remote_netmask, tun_mtu, print_topology(tt-&g=
t;topology));</span><br><span>     management_android_control(management, &=
quot;IFCONFIG&quot;, out);</span><br><span> </span><br><span> #elif defined=
(TARGET_SOLARIS)</span><br><span>@@ -1380,7 +1359,7 @@</span><br><span>    =
  *    ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 up</span><br><span>      * =
   ifconfig tun2 netmask 255.255.255.255</span><br><span>      */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (tun)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)</span><br><span>     =
{</span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s mtu %d =
up&quot;, IFCONFIG_PATH, ifname,</span><br><span>                     ifcon=
fig_local, ifconfig_remote_netmask, tun_mtu);</span><br><span>@@ -1394,13 +=
1373,13 @@</span><br><span>         argv_printf(&amp;argv, &quot;%s %s netm=
ask 255.255.255.255&quot;, IFCONFIG_PATH,</span><br><span>                 =
    ifname);</span><br><span>     }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&g=
t;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>   =
  {</span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s netma=
sk %s mtu %d up&quot;, IFCONFIG_PATH,</span><br><span>                     =
ifname, ifconfig_local, ifconfig_local,</span><br><span>                   =
  ifconfig_remote_netmask, tun_mtu);</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else /* tap */</span><br><span>     {</span>=
<br><span>         argv_printf(&amp;argv, &quot;%s %s %s netmask %s up&quot=
;,</span><br><span>                     IFCONFIG_PATH, ifname, ifconfig_loc=
al,</span><br><span>@@ -1413,7 +1392,7 @@</span><br><span>         solaris_=
error_close(tt, es, ifname, false);</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tun &amp;&a=
mp; tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_S=
UBNET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tun_=
p2p &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</spa=
n><br><span>         /* Add a network route for the local tun interface */<=
/span><br><span>         struct route_ipv4 r;</span><br><span>@@ -1437,14 +=
1416,14 @@</span><br><span>      */</span><br><span> </span><br><span>     =
/* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.25=
5 up */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tun)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)</spa=
n><br><span>     {</span><br><span>         argv_printf(&amp;argv,</span><b=
r><span>                     &quot;%s %s %s %s mtu %d netmask 255.255.255.2=
55 up -link0&quot;,</span><br><span>                     IFCONFIG_PATH, ifn=
ame, ifconfig_local,</span><br><span>                     ifconfig_remote_n=
etmask, tun_mtu);</span><br><span>     }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; =
tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><spa=
n>     {</span><br><span>         remote_end =3D create_arbitrary_remote( t=
t );</span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s mtu =
%d netmask %s up -link0&quot;,</span><br><span>@@ -1452,7 +1431,7 @@</span>=
<br><span>                     print_in_addr_t(remote_end, 0, &amp;gc), tun=
_mtu,</span><br><span>                     ifconfig_remote_netmask);</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else /* tap =
*/</span><br><span>     {</span><br><span>         argv_printf(&amp;argv, &=
quot;%s %s %s netmask %s mtu %d link0&quot;,</span><br><span>              =
       IFCONFIG_PATH, ifname, ifconfig_local,</span><br><span>@@ -1462,7 +1=
441,7 @@</span><br><span>     openvpn_execve_check(&amp;argv, es, S_FATAL, =
&quot;OpenBSD ifconfig failed&quot;);</span><br><span> </span><br><span>   =
  /* Add a network route for the local tun interface */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (!tun &amp;&amp; tt-&gt;type =3D=
=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!tun_p2p &amp;&amp; tt-&=
gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>       =
  struct route_ipv4 r;</span><br><span>         CLEAR(r);</span><br><span>@=
@ -1476,20 +1455,20 @@</span><br><span> #elif defined(TARGET_NETBSD)</span>=
<br><span>     in_addr_t remote_end =3D INADDR_ANY;  /* for &quot;virtual&q=
uot; subnet topology */</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (tun)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (tun_p2p)</span><br><span>     {</span><br><span>      =
   argv_printf(&amp;argv, &quot;%s %s %s %s mtu %d netmask 255.255.255.255 =
up&quot;,</span><br><span>                     IFCONFIG_PATH, ifname, ifcon=
fig_local,</span><br><span>                     ifconfig_remote_netmask, tu=
n_mtu);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;top=
ology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</=
span><br><span>         remote_end =3D create_arbitrary_remote(tt);</span><=
br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s mtu %d netmask %=
s up&quot;, IFCONFIG_PATH,</span><br><span>                     ifname, ifc=
onfig_local, print_in_addr_t(remote_end, 0, &amp;gc),</span><br><span>     =
                tun_mtu, ifconfig_remote_netmask);</span><br><span>     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else /* tap */</span><br><span=
>     {</span><br><span>         /*</span><br><span>          * NetBSD has =
distinct tun and tap devices</span><br><span>@@ -1504,7 +1483,7 @@</span><b=
r><span>     openvpn_execve_check(&amp;argv, es, S_FATAL, &quot;NetBSD ifco=
nfig failed&quot;);</span><br><span> </span><br><span>     /* Add a network=
 route for the local tun interface */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (!tun &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN &am=
p;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!tun_p2p &amp;&amp; tt-&gt;type =3D=3D DEV_T=
YPE_TUN)</span><br><span>     {</span><br><span>         struct route_ipv4 =
r;</span><br><span>         CLEAR(r);</span><br><span>@@ -1528,33 +1507,30 =
@@</span><br><span> </span><br><span> </span><br><span>     /* example: ifc=
onfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tun)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)</span><br><span>   =
  {</span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s mtu %=
d netmask 255.255.255.255 up&quot;,</span><br><span>                     IF=
CONFIG_PATH, ifname, ifconfig_local,</span><br><span>                     i=
fconfig_remote_netmask, tun_mtu);</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D T=
OP_SUBNET)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            argv_printf=
(&amp;argv, &quot;%s %s %s %s netmask %s mtu %d up&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                        IFCONFIG_PATH, =
ifname, ifconfig_local, ifconfig_local,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        ifconfig_remote_netmask, tun_mtu)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            argv_printf(&amp;argv, &quot;%s %s %s net=
mask %s mtu %d up&quot;, IFCONFIG_PATH,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        ifname, ifconfig_local, ifconfig_=
remote_netmask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  tun_mtu);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    argv_printf(&amp;argv, &quot;%s %s %s %s netmask %s mtu %d up&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    IF=
CONFIG_PATH, ifname, ifconfig_local, ifconfig_local,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    ifconfig_remote_netma=
sk, tun_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else /* tap */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quo=
t;%s %s %s netmask %s mtu %d up&quot;, IFCONFIG_PATH,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    ifname, ifconfig_loca=
l, ifconfig_remote_netmask,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    tun_mtu);</span><br><span>     }</span><br><spa=
n> </span><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><span>     =
openvpn_execve_check(&amp;argv, es, S_FATAL, &quot;Mac OS X ifconfig failed=
&quot;);</span><br><span> </span><br><span>     /* Add a network route for =
the local tun interface */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!tun &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-=
&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!tun_p2p &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN)</s=
pan><br><span>     {</span><br><span>         struct route_ipv4 r;</span><b=
r><span>         CLEAR(r);</span><br><span>@@ -1568,7 +1544,7 @@</span><br>=
<span> #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br=
><span> </span><br><span>     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 m=
tu 1450 netmask 255.255.255.255 up */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (tun)       /* point-to-point tun */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)    /* point-to-poi=
nt tun */</span><br><span>     {</span><br><span>         argv_printf(&amp;=
argv, &quot;%s %s %s %s mtu %d netmask 255.255.255.255 up&quot;,</span><br>=
<span>                     IFCONFIG_PATH, ifname, ifconfig_local,</span><br=
><span>@@ -1590,7 +1566,7 @@</span><br><span>         struct env_set *aix_e=
s =3D env_set_create(NULL);</span><br><span>         env_set_add( aix_es, &=
quot;ODMDIR=3D/etc/objrepos&quot; );</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (tun)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (tt-&gt;type =3D=3D DEV_TYPE_TUN)<=
/span><br><span>         {</span><br><span>             msg(M_FATAL, &quot;=
no tun support on AIX (canthappen)&quot;);</span><br><span>         }</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/380?usp=3Demail">change 380</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/380?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ice8b95f953c3f7e71657a78ea12=
b02a08c60aa67 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 380 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Ni+yr0k2Sfw=--

