From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 13 May 2024 11:42:18 +0000
In-Reply-To: <gerrit.1699291967000.Ice8b95f953c3f7e71657a78ea12b02a08c60aa67@...2715...>
References: <gerrit.1699291967000.Ice8b95f953c3f7e71657a78ea12b02a08c60aa67@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1d3361550376d8c0994141eb24bcaba9f211c7c1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0hexGUsmPCU="; charset=UTF-8
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

--0hexGUsmPCU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/380?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/380/4

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index d01515d..12c0ba9 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -499,31 +499,31 @@
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
@@ -667,13 +667,13 @@
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
@@ -737,24 +737,24 @@
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
@@ -831,12 +831,10 @@

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
@@ -853,7 +851,7 @@
             NULL);

         tt->remote_netmask =3D getaddr(
-            (tun ? GETADDR_RESOLVE : 0)
+            (tun_p2p ? GETADDR_RESOLVE : 0)
             | GETADDR_HOST_ORDER
             | GETADDR_FATAL_ON_SIGNAL
             | GETADDR_FATAL,
@@ -868,7 +866,7 @@
         if (strict_warn)
         {
             struct addrinfo *curele;
-            ifconfig_sanity_check(tt->type =3D=3D DEV_TYPE_TUN, tt->remote=
_netmask, tt->topology);
+            ifconfig_sanity_check(tun_p2p, tt->remote_netmask);

             /*
              * If local_public or remote_public addresses are defined,
@@ -899,11 +897,11 @@
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
@@ -914,7 +912,7 @@
          * Make sure that both ifconfig addresses are part of the
          * same .252 subnet.
          */
-        if (tun)
+        if (tun_p2p)
         {
             verify_255_255_255_252(tt->local, tt->remote_netmask);
             tt->adapter_netmask =3D ~3;
@@ -1297,7 +1295,7 @@
     /*
      * We only handle TUN/TAP devices here, not --dev null devices.
      */
-    bool tun =3D is_tun_p2p(tt);
+    bool tun_p2p =3D is_tun_p2p(tt);
 #endif

 #if !defined(TARGET_LINUX)
@@ -1324,7 +1322,7 @@
         msg(M_FATAL, "Linux can't bring %s up", ifname);
     }

-    if (tun)
+    if (tun_p2p)
     {
         if (net_addr_ptp_v4_add(ctx, ifname, &tt->local,
                                 &tt->remote_netmask) < 0)
@@ -1343,27 +1341,8 @@
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
     snprintf(out, sizeof(out), "%s %s %d %s", ifconfig_local,
-             ifconfig_remote_netmask, tun_mtu, top);
+             ifconfig_remote_netmask, tun_mtu, print_topology(tt->topology=
));
     management_android_control(management, "IFCONFIG", out);

 #elif defined(TARGET_SOLARIS)
@@ -1372,7 +1351,7 @@
      *    ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 up
      *    ifconfig tun2 netmask 255.255.255.255
      */
-    if (tun)
+    if (tun_p2p)
     {
         argv_printf(&argv, "%s %s %s %s mtu %d up", IFCONFIG_PATH, ifname,
                     ifconfig_local, ifconfig_remote_netmask, tun_mtu);
@@ -1386,13 +1365,13 @@
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
@@ -1405,7 +1384,7 @@
         solaris_error_close(tt, es, ifname, false);
     }

-    if (!tun && tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SU=
BNET)
+    if (!tun_p2p && tt->type =3D=3D DEV_TYPE_TUN)
     {
         /* Add a network route for the local tun interface */
         struct route_ipv4 r;
@@ -1429,14 +1408,14 @@
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
@@ -1444,7 +1423,7 @@
                     print_in_addr_t(remote_end, 0, &gc), tun_mtu,
                     ifconfig_remote_netmask);
     }
-    else
+    else /* tap */
     {
         argv_printf(&argv, "%s %s %s netmask %s mtu %d link0",
                     IFCONFIG_PATH, ifname, ifconfig_local,
@@ -1454,7 +1433,7 @@
     openvpn_execve_check(&argv, es, S_FATAL, "OpenBSD ifconfig failed");

     /* Add a network route for the local tun interface */
-    if (!tun && tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SU=
BNET)
+    if (!tun_p2p && tt->type =3D=3D DEV_TYPE_TUN)
     {
         struct route_ipv4 r;
         CLEAR(r);
@@ -1468,20 +1447,20 @@
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
@@ -1496,7 +1475,7 @@
     openvpn_execve_check(&argv, es, S_FATAL, "NetBSD ifconfig failed");
=20
     /* Add a network route for the local tun interface */
-    if (!tun && tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SU=
BNET)
+    if (!tun_p2p && tt->type =3D=3D DEV_TYPE_TUN)
     {
         struct route_ipv4 r;
         CLEAR(r);
@@ -1520,33 +1499,30 @@


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
@@ -1560,7 +1536,7 @@
 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)

     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.2=
55.255 up */
-    if (tun)       /* point-to-point tun */
+    if (tun_p2p)    /* point-to-point tun */
     {
         argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
@@ -1582,7 +1558,7 @@
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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--0hexGUsmPCU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/380?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><p>The change is no longer submittable: Code-=
Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">tun: use is_tun_p2p=
 more consistently<br><br>Using &quot;tun&quot; as the variable name for th=
e return of<br>is_tun_p2p is probably a historical accident. But<br>it has =
actual consequences in that the other code<br>often seems to assume that it=
 does less checks<br>than it actually does.<br><br>Use &quot;tun_p2p&quot; =
as the variable name and remove checks<br>that are not required. Also use i=
s_tun_p2p in more<br>places.<br><br>Change-Id: Ice8b95f953c3f7e71657a78ea12=
b02a08c60aa67<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<=
br>---<br>M src/openvpn/tun.c<br>1 file changed, 48 insertions(+), 72 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/80/380/4</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</sp=
an><br><span>index d01515d..12c0ba9 100644</span><br><span>--- a/src/openvp=
n/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -499,31 =
+499,31 @@</span><br><span> static const char ifconfig_warn_how_to_silence[=
] =3D &quot;(silence this warning with --ifconfig-nowarn)&quot;;</span><br>=
<span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * If !tun, make sure ifconfig_remote_netmask looks</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * If !tun_p2p, make sure ifconfig_re=
mote_netmask looks</span><br><span>  *  like a netmask.</span><br><span>  *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If tun, make sure =
ifconfig_remote_netmask looks</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * If tun_p2p, make sure ifconfig_remote_netmask looks</span><br>=
<span>  *  like an IPv4 address.</span><br><span>  */</span><br><span> stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_sanit=
y_check(bool tun, in_addr_t addr, int topology)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ifconfig_sanity_check(bool tun_p2p, in_addr_t a=
ddr)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new(=
);</span><br><span>     const bool looks_like_netmask =3D ((addr &amp; 0xFF=
000000) =3D=3D 0xFF000000);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (tun)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (tun_p2p)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (looks_like_netmask &amp;&amp; (topology =3D=3D=
 TOP_NET30 || topology =3D=3D TOP_P2P))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (looks_like_netmask)</span><br><span>       =
  {</span><br><span>             msg(M_WARN, &quot;WARNING: Since you are u=
sing --dev tun with a point-to-point topology, the second argument to --ifc=
onfig must be an IP address.  You are using something (%s) that looks more =
like a netmask. %s&quot;,</span><br><span>                 print_in_addr_t(=
addr, 0, &amp;gc),</span><br><span>                 ifconfig_warn_how_to_si=
lence);</span><br><span>         }</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    else /* tap */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span>     {</span><b=
r><span>         if (!looks_like_netmask)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quo=
t;WARNING: Since you are using --dev tap, the second argument to --ifconfig=
 must be a netmask, for example something like 255.255.255.0. %s&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN,=
 &quot;WARNING: Since you are using subnet topology, the second argument to=
 --ifconfig must be a netmask, for example something like 255.255.255.0. %s=
&quot;,</span><br><span>                 ifconfig_warn_how_to_silence);</sp=
an><br><span>         }</span><br><span>     }</span><br><span>@@ -667,13 +=
667,13 @@</span><br><span>     struct buffer out =3D alloc_buf_gc(256, gc);=
</span><br><span>     if (tt-&gt;did_ifconfig_setup &amp;&amp; !disable)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (tt-&gt;type =3D=3D DEV_TYPE_TAP || (tt-&gt;type =3D=3D DEV_TYPE_=
TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!is_tun_p2p(tt))</span><br><span=
>         {</span><br><span>             buf_printf(&amp;out, &quot;%s %s&q=
uot;,</span><br><span>                        print_in_addr_t(tt-&gt;local =
&amp; tt-&gt;remote_netmask, 0, gc),</span><br><span>                      =
  print_in_addr_t(tt-&gt;remote_netmask, 0, gc));</span><br><span>         =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (tt-=
&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        else if (tt-&gt;type =3D=3D DEV_TYPE_TUN) /* tun p2p topo=
logy */</span><br><span>         {</span><br><span>             const char =
*l, *r;</span><br><span>             if (remote)</span><br><span>@@ -737,24=
 +737,24 @@</span><br><span> bool</span><br><span> is_tun_p2p(const struct =
tuntap *tt)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    bool tun =3D false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool tun_p2p =3D false;</span><br><span> </span><br><span>=
     if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span>         || (tt-&g=
t;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</s=
pan><br><span>         || tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tun =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
un_p2p =3D false;</span><br><span>     }</span><br><span>     else if (tt-&=
gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        tun =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tun_p2p =3D true;</span><br><span=
>     }</span><br><span>     else</span><br><span>     {</span><br><span>  =
       msg(M_FATAL, &quot;Error: problem with tun vs. tap setting&quot;); /=
* JYFIXME -- needs to be caught earlier, in init_tun? */</span><br><span> <=
/span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return tun;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return tun_p2p;</span><br><span> }</span><br><span> </span><br><span> /*</=
span><br><span>@@ -831,12 +831,10 @@</span><br><span> </span><br><span>    =
 if (ifconfig_local_parm &amp;&amp; ifconfig_remote_netmask_parm)</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
bool tun =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span>         /*</span><br><span>          * We only handle TUN/T=
AP devices here, not --dev null devices.</span><br><span>          */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        tun =3D is_tun_p2p(=
tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool tu=
n_p2p =3D is_tun_p2p(tt);</span><br><span> </span><br><span>         /*</sp=
an><br><span>          * Convert arguments to binary IPv4 addresses.</span>=
<br><span>@@ -853,7 +851,7 @@</span><br><span>             NULL);</span><br=
><span> </span><br><span>         tt-&gt;remote_netmask =3D getaddr(</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            (tun ? GETADDR_R=
ESOLVE : 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    (tun_p2p ? GETADDR_RESOLVE : 0)</span><br><span>             | GETADDR_=
HOST_ORDER</span><br><span>             | GETADDR_FATAL_ON_SIGNAL</span><br=
><span>             | GETADDR_FATAL,</span><br><span>@@ -868,7 +866,7 @@</s=
pan><br><span>         if (strict_warn)</span><br><span>         {</span><b=
r><span>             struct addrinfo *curele;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            ifconfig_sanity_check(tt-&gt;type =3D=
=3D DEV_TYPE_TUN, tt-&gt;remote_netmask, tt-&gt;topology);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            ifconfig_sanity_check(tu=
n_p2p, tt-&gt;remote_netmask);</span><br><span> </span><br><span>          =
   /*</span><br><span>              * If local_public or remote_public addr=
esses are defined,</span><br><span>@@ -899,11 +897,11 @@</span><br><span>  =
               }</span><br><span>             }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            if (tt-&gt;type =3D=
=3D DEV_TYPE_TAP || (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topo=
logy =3D=3D TOP_SUBNET))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if (!tun_p2p)</span><br><span>             {</span><br><sp=
an>                 check_subnet_conflict(tt-&gt;local, tt-&gt;remote_netma=
sk, &quot;TUN/TAP adapter&quot;);</span><br><span>             }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            else if (tt-&gt;type=
 =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            else</span><br><span>             {</span><br><span>         =
        check_subnet_conflict(tt-&gt;local, IPV4_NETMASK_HOST, &quot;TUN/TA=
P adapter&quot;);</span><br><span>             }</span><br><span>@@ -914,7 =
+912,7 @@</span><br><span>          * Make sure that both ifconfig addresse=
s are part of the</span><br><span>          * same .252 subnet.</span><br><=
span>          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (tun)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (tun_p2p)</span><br><span>         {</span><br><span>             verif=
y_255_255_255_252(tt-&gt;local, tt-&gt;remote_netmask);</span><br><span>   =
          tt-&gt;adapter_netmask =3D ~3;</span><br><span>@@ -1297,7 +1295,7=
 @@</span><br><span>     /*</span><br><span>      * We only handle TUN/TAP =
devices here, not --dev null devices.</span><br><span>      */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    bool tun =3D is_tun_p2p(tt);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool tun_p2p =3D =
is_tun_p2p(tt);</span><br><span> #endif</span><br><span> </span><br><span> =
#if !defined(TARGET_LINUX)</span><br><span>@@ -1324,7 +1322,7 @@</span><br>=
<span>         msg(M_FATAL, &quot;Linux can&#39;t bring %s up&quot;, ifname=
);</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (tun)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (tun_p2p)</span><br><span>     {</span><br><span>    =
     if (net_addr_ptp_v4_add(ctx, ifname, &amp;tt-&gt;local,</span><br><spa=
n>                                 &amp;tt-&gt;remote_netmask) &lt; 0)</spa=
n><br><span>@@ -1343,27 +1341,8 @@</span><br><span> #elif defined(TARGET_AN=
DROID)</span><br><span>     char out[64];</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    char *top;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    switch (tt-&gt;topology)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        case TOP_NET30:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            top =3D &quot;net30&quot;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        case TOP_P2P:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            top =3D &quot;p2p&quot;;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        case TOP_SUBNET:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            top =3D &quot;subnet&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        default:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            top =3D &quot;undef&quot;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span>     snprintf(out, sizeof(out), &quot;%s %s %d %s&quot=
;, ifconfig_local,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
          ifconfig_remote_netmask, tun_mtu, top);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+             ifconfig_remote_netmask, tun_mtu=
, print_topology(tt-&gt;topology));</span><br><span>     management_android=
_control(management, &quot;IFCONFIG&quot;, out);</span><br><span> </span><b=
r><span> #elif defined(TARGET_SOLARIS)</span><br><span>@@ -1372,7 +1351,7 @=
@</span><br><span>      *    ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 up</s=
pan><br><span>      *    ifconfig tun2 netmask 255.255.255.255</span><br><s=
pan>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (t=
un)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)=
</span><br><span>     {</span><br><span>         argv_printf(&amp;argv, &qu=
ot;%s %s %s %s mtu %d up&quot;, IFCONFIG_PATH, ifname,</span><br><span>    =
                 ifconfig_local, ifconfig_remote_netmask, tun_mtu);</span><=
br><span>@@ -1386,13 +1365,13 @@</span><br><span>         argv_printf(&amp;=
argv, &quot;%s %s netmask 255.255.255.255&quot;, IFCONFIG_PATH,</span><br><=
span>                     ifname);</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    else if (tt-&gt;type =3D=3D DEV_TYP=
E_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (tt-&gt;type =3D=3D DEV_TYPE_=
TUN)</span><br><span>     {</span><br><span>         argv_printf(&amp;argv,=
 &quot;%s %s %s %s netmask %s mtu %d up&quot;, IFCONFIG_PATH,</span><br><sp=
an>                     ifname, ifconfig_local, ifconfig_local,</span><br><=
span>                     ifconfig_remote_netmask, tun_mtu);</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else /* tap */</span=
><br><span>     {</span><br><span>         argv_printf(&amp;argv, &quot;%s =
%s %s netmask %s up&quot;,</span><br><span>                     IFCONFIG_PA=
TH, ifname, ifconfig_local,</span><br><span>@@ -1405,7 +1384,7 @@</span><br=
><span>         solaris_error_close(tt, es, ifname, false);</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (!tun &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&=
gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!tun_p2p &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN)</sp=
an><br><span>     {</span><br><span>         /* Add a network route for the=
 local tun interface */</span><br><span>         struct route_ipv4 r;</span=
><br><span>@@ -1429,14 +1408,14 @@</span><br><span>      */</span><br><span=
> </span><br><span>     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 145=
0 netmask 255.255.255.255 up */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (tun)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (tun_p2p)</span><br><span>     {</span><br><span>         argv_pr=
intf(&amp;argv,</span><br><span>                     &quot;%s %s %s %s mtu =
%d netmask 255.255.255.255 up -link0&quot;,</span><br><span>               =
      IFCONFIG_PATH, ifname, ifconfig_local,</span><br><span>              =
       ifconfig_remote_netmask, tun_mtu);</span><br><span>     }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    else if (tt-&gt;type =3D=3D =
DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else if (tt-&gt;type =3D=3D DEV_=
TYPE_TUN)</span><br><span>     {</span><br><span>         remote_end =3D cr=
eate_arbitrary_remote( tt );</span><br><span>         argv_printf(&amp;argv=
, &quot;%s %s %s %s mtu %d netmask %s up -link0&quot;,</span><br><span>@@ -=
1444,7 +1423,7 @@</span><br><span>                     print_in_addr_t(remo=
te_end, 0, &amp;gc), tun_mtu,</span><br><span>                     ifconfig=
_remote_netmask);</span><br><span>     }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    else /* tap */</span><br><span>     {</span><br><span>         =
argv_printf(&amp;argv, &quot;%s %s %s netmask %s mtu %d link0&quot;,</span>=
<br><span>                     IFCONFIG_PATH, ifname, ifconfig_local,</span=
><br><span>@@ -1454,7 +1433,7 @@</span><br><span>     openvpn_execve_check(=
&amp;argv, es, S_FATAL, &quot;OpenBSD ifconfig failed&quot;);</span><br><sp=
an> </span><br><span>     /* Add a network route for the local tun interfac=
e */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tun &amp=
;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TO=
P_SUBNET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!t=
un_p2p &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</=
span><br><span>         struct route_ipv4 r;</span><br><span>         CLEAR=
(r);</span><br><span>@@ -1468,20 +1447,20 @@</span><br><span> #elif defined=
(TARGET_NETBSD)</span><br><span>     in_addr_t remote_end =3D INADDR_ANY;  =
/* for &quot;virtual&quot; subnet topology */</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (tun)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)</span><br><span>     {<=
/span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s mtu %d ne=
tmask 255.255.255.255 up&quot;,</span><br><span>                     IFCONF=
IG_PATH, ifname, ifconfig_local,</span><br><span>                     ifcon=
fig_remote_netmask, tun_mtu);</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (tt-&gt;type =3D=3D DEV_TYPE_TU=
N &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</=
span><br><span>     {</span><br><span>         remote_end =3D create_arbitr=
ary_remote(tt);</span><br><span>         argv_printf(&amp;argv, &quot;%s %s=
 %s %s mtu %d netmask %s up&quot;, IFCONFIG_PATH,</span><br><span>         =
            ifname, ifconfig_local, print_in_addr_t(remote_end, 0, &amp;gc)=
,</span><br><span>                     tun_mtu, ifconfig_remote_netmask);</=
span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else /*=
 tap */</span><br><span>     {</span><br><span>         /*</span><br><span>=
          * NetBSD has distinct tun and tap devices</span><br><span>@@ -149=
6,7 +1475,7 @@</span><br><span>     openvpn_execve_check(&amp;argv, es, S_F=
ATAL, &quot;NetBSD ifconfig failed&quot;);</span><br><span> </span><br><spa=
n>     /* Add a network route for the local tun interface */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (!tun &amp;&amp; tt-&gt;type =
=3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tun_p2p &amp;&amp; t=
t-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>    =
     struct route_ipv4 r;</span><br><span>         CLEAR(r);</span><br><spa=
n>@@ -1520,33 +1499,30 @@</span><br><span> </span><br><span> </span><br><sp=
an>     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.25=
5.255.255 up */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (tun)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tun_p=
2p)</span><br><span>     {</span><br><span>         argv_printf(&amp;argv, =
&quot;%s %s %s %s mtu %d netmask 255.255.255.255 up&quot;,</span><br><span>=
                     IFCONFIG_PATH, ifname, ifconfig_local,</span><br><span=
>                     ifconfig_remote_netmask, tun_mtu);</span><br><span>  =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else if (tt-&gt;type =3D=
=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; t=
t-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            argv_printf(&amp;argv, &quot;%s %s %s %s netmask %s mtu %d up&q=
uot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
        IFCONFIG_PATH, ifname, ifconfig_local, ifconfig_local,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        ifconfig_r=
emote_netmask, tun_mtu);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            argv_printf(&amp;a=
rgv, &quot;%s %s %s netmask %s mtu %d up&quot;, IFCONFIG_PATH,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        ifname, if=
config_local, ifconfig_remote_netmask,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                        tun_mtu);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s %s %s %s netmask=
 %s mtu %d up&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    IFCONFIG_PATH, ifname, ifconfig_local, ifconfig_local,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 ifconfig_remote_netmask, tun_mtu);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else /* tap */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_=
printf(&amp;argv, &quot;%s %s %s netmask %s mtu %d up&quot;, IFCONFIG_PATH,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 ifname, ifconfig_local, ifconfig_remote_netmask,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    tun_mtu);</span><br><span=
>     }</span><br><span> </span><br><span>     argv_msg(M_INFO, &amp;argv);=
</span><br><span>     openvpn_execve_check(&amp;argv, es, S_FATAL, &quot;Ma=
c OS X ifconfig failed&quot;);</span><br><span> </span><br><span>     /* Ad=
d a network route for the local tun interface */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!tun &amp;&amp; tt-&gt;type =3D=3D DEV_T=
YPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!tun_p2p &amp;&amp; tt-&gt;type =
=3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         struct=
 route_ipv4 r;</span><br><span>         CLEAR(r);</span><br><span>@@ -1560,=
7 +1536,7 @@</span><br><span> #elif defined(TARGET_FREEBSD) || defined(TARG=
ET_DRAGONFLY)</span><br><span> </span><br><span>     /* example: ifconfig t=
un2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (tun)       /* point-to-point=
 tun */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tun_=
p2p)    /* point-to-point tun */</span><br><span>     {</span><br><span>   =
      argv_printf(&amp;argv, &quot;%s %s %s %s mtu %d netmask 255.255.255.2=
55 up&quot;,</span><br><span>                     IFCONFIG_PATH, ifname, if=
config_local,</span><br><span>@@ -1582,7 +1558,7 @@</span><br><span>       =
  struct env_set *aix_es =3D env_set_create(NULL);</span><br><span>        =
 env_set_add( aix_es, &quot;ODMDIR=3D/etc/objrepos&quot; );</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (tun)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tt-&gt;typ=
e =3D=3D DEV_TYPE_TUN)</span><br><span>         {</span><br><span>         =
    msg(M_FATAL, &quot;no tun support on AIX (canthappen)&quot;);</span><br=
><span>         }</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/380?usp=3Demail">change 380</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/380?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ice8b95f953c3f7e71657a78ea12=
b02a08c60aa67 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 380 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--0hexGUsmPCU=--

