From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 9 Sep 2024 09:33:47 +0000
In-Reply-To: <gerrit.1699291967000.Ice8b95f953c3f7e71657a78ea12b02a08c60aa67@...2715...>
References: <gerrit.1699291967000.Ice8b95f953c3f7e71657a78ea12b02a08c60aa67@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <44d1adacf89cf16e94cd806e7772980101179e30-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PCywEWw3VqE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PCywEWw3VqE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/380?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240906162514.78671-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
091.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun.c
1 file changed, 48 insertions(+), 72 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/380/9

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index ce3d882..739e008 100644
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
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--PCywEWw3VqE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #9</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/380?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tun: use is_tun_p2p more consistently<br><br>Usi=
ng &quot;tun&quot; as the variable name for the return of<br>is_tun_p2p is =
probably a historical accident. But<br>it has actual consequences in that t=
he other code<br>often seems to assume that it does less checks<br>than it =
actually does.<br><br>Use &quot;tun_p2p&quot; as the variable name and remo=
ve checks<br>that are not required. Also use is_tun_p2p in more<br>places.<=
br><br>Change-Id: Ice8b95f953c3f7e71657a78ea12b02a08c60aa67<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt=
;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20240906162514.78671-1-fran=
k@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg29091.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M src/openvpn/tun.c<br>1 file changed, 48 insertions(+),=
 72 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/80/380/9</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun.c b/src/openvpn/=
tun.c</span><br><span>index ce3d882..739e008 100644</span><br><span>--- a/s=
rc/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@=
 -499,31 +499,31 @@</span><br><span> static const char ifconfig_warn_how_to=
_silence[] =3D &quot;(silence this warning with --ifconfig-nowarn)&quot;;</=
span><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * If !tun, make sure ifconfig_remote_netmask looks</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * If !tun_p2p, make sure if=
config_remote_netmask looks</span><br><span>  *  like a netmask.</span><br>=
<span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If tun, m=
ake sure ifconfig_remote_netmask looks</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * If tun_p2p, make sure ifconfig_remote_netmask looks</=
span><br><span>  *  like an IPv4 address.</span><br><span>  */</span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifcon=
fig_sanity_check(bool tun, in_addr_t addr, int topology)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ifconfig_sanity_check(bool tun_p2p, in=
_addr_t addr)</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     const bool looks_like_netmask =3D ((addr=
 &amp; 0xFF000000) =3D=3D 0xFF000000);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (tun)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (tun_p2p)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (looks_like_netmask &amp;&amp; (topo=
logy =3D=3D TOP_NET30 || topology =3D=3D TOP_P2P))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (looks_like_netmask)</span><br><s=
pan>         {</span><br><span>             msg(M_WARN, &quot;WARNING: Sinc=
e you are using --dev tun with a point-to-point topology, the second argume=
nt to --ifconfig must be an IP address.  You are using something (%s) that =
looks more like a netmask. %s&quot;,</span><br><span>                 print=
_in_addr_t(addr, 0, &amp;gc),</span><br><span>                 ifconfig_war=
n_how_to_silence);</span><br><span>         }</span><br><span>     }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    else /* tap */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span>    =
 {</span><br><span>         if (!looks_like_netmask)</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M=
_WARN, &quot;WARNING: Since you are using --dev tap, the second argument to=
 --ifconfig must be a netmask, for example something like 255.255.255.0. %s=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(M_WARN, &quot;WARNING: Since you are using subnet topology, the second =
argument to --ifconfig must be a netmask, for example something like 255.25=
5.255.0. %s&quot;,</span><br><span>                 ifconfig_warn_how_to_si=
lence);</span><br><span>         }</span><br><span>     }</span><br><span>@=
@ -667,13 +667,13 @@</span><br><span>     struct buffer out =3D alloc_buf_g=
c(256, gc);</span><br><span>     if (tt-&gt;did_ifconfig_setup &amp;&amp; !=
disable)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (tt-&gt;type =3D=3D DEV_TYPE_TAP || (tt-&gt;type =3D=
=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!is_tun_p2p(tt))</s=
pan><br><span>         {</span><br><span>             buf_printf(&amp;out, =
&quot;%s %s&quot;,</span><br><span>                        print_in_addr_t(=
tt-&gt;local &amp; tt-&gt;remote_netmask, 0, gc),</span><br><span>         =
               print_in_addr_t(tt-&gt;remote_netmask, 0, gc));</span><br><s=
pan>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        else if (tt-&gt;type =3D=3D DEV_TYPE_TUN) /*=
 tun p2p topology */</span><br><span>         {</span><br><span>           =
  const char *l, *r;</span><br><span>             if (remote)</span><br><sp=
an>@@ -737,24 +737,24 @@</span><br><span> bool</span><br><span> is_tun_p2p(=
const struct tuntap *tt)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    bool tun =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool tun_p2p =3D false;</span><br><span> </sp=
an><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span>     =
    || (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D T=
OP_SUBNET)</span><br><span>         || tt-&gt;type =3D=3D DEV_TYPE_NULL)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       tun =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        tun_p2p =3D false;</span><br><span>     }</span><br><span>     el=
se if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        tun =3D true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        tun_p2p =3D true;</span>=
<br><span>     }</span><br><span>     else</span><br><span>     {</span><br=
><span>         msg(M_FATAL, &quot;Error: problem with tun vs. tap setting&=
quot;); /* JYFIXME -- needs to be caught earlier, in init_tun? */</span><br=
><span> </span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    return tun;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return tun_p2p;</span><br><span> }</span><br><span> </span><br><s=
pan> /*</span><br><span>@@ -831,12 +831,10 @@</span><br><span> </span><br><=
span>     if (ifconfig_local_parm &amp;&amp; ifconfig_remote_netmask_parm)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        bool tun =3D false;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>         /*</span><br><span>          * We only han=
dle TUN/TAP devices here, not --dev null devices.</span><br><span>         =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tun =3D is=
_tun_p2p(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  bool tun_p2p =3D is_tun_p2p(tt);</span><br><span> </span><br><span>      =
   /*</span><br><span>          * Convert arguments to binary IPv4 addresse=
s.</span><br><span>@@ -853,7 +851,7 @@</span><br><span>             NULL);<=
/span><br><span> </span><br><span>         tt-&gt;remote_netmask =3D getadd=
r(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            (tun ? =
GETADDR_RESOLVE : 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            (tun_p2p ? GETADDR_RESOLVE : 0)</span><br><span>             |=
 GETADDR_HOST_ORDER</span><br><span>             | GETADDR_FATAL_ON_SIGNAL<=
/span><br><span>             | GETADDR_FATAL,</span><br><span>@@ -868,7 +86=
6,7 @@</span><br><span>         if (strict_warn)</span><br><span>         {=
</span><br><span>             struct addrinfo *curele;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            ifconfig_sanity_check(tt-&gt;t=
ype =3D=3D DEV_TYPE_TUN, tt-&gt;remote_netmask, tt-&gt;topology);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            ifconfig_sanity_c=
heck(tun_p2p, tt-&gt;remote_netmask);</span><br><span> </span><br><span>   =
          /*</span><br><span>              * If local_public or remote_publ=
ic addresses are defined,</span><br><span>@@ -899,11 +897,11 @@</span><br><=
span>                 }</span><br><span>             }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (tt-&gt;t=
ype =3D=3D DEV_TYPE_TAP || (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&=
gt;topology =3D=3D TOP_SUBNET))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (!tun_p2p)</span><br><span>             {</span>=
<br><span>                 check_subnet_conflict(tt-&gt;local, tt-&gt;remot=
e_netmask, &quot;TUN/TAP adapter&quot;);</span><br><span>             }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (tt-&=
gt;type =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            else</span><br><span>             {</span><br><span>  =
               check_subnet_conflict(tt-&gt;local, IPV4_NETMASK_HOST, &quot=
;TUN/TAP adapter&quot;);</span><br><span>             }</span><br><span>@@ =
-914,7 +912,7 @@</span><br><span>          * Make sure that both ifconfig a=
ddresses are part of the</span><br><span>          * same .252 subnet.</spa=
n><br><span>          */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (tun)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (tun_p2p)</span><br><span>         {</span><br><span>           =
  verify_255_255_255_252(tt-&gt;local, tt-&gt;remote_netmask);</span><br><s=
pan>             tt-&gt;adapter_netmask =3D ~3;</span><br><span>@@ -1297,7 =
+1295,7 @@</span><br><span>     /*</span><br><span>      * We only handle T=
UN/TAP devices here, not --dev null devices.</span><br><span>      */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool tun =3D is_tun_p2p=
(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool tun_p=
2p =3D is_tun_p2p(tt);</span><br><span> #endif</span><br><span> </span><br>=
<span> #if !defined(TARGET_LINUX)</span><br><span>@@ -1324,7 +1322,7 @@</sp=
an><br><span>         msg(M_FATAL, &quot;Linux can&#39;t bring %s up&quot;,=
 ifname);</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (tun)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (tun_p2p)</span><br><span>     {</span><br><sp=
an>         if (net_addr_ptp_v4_add(ctx, ifname, &amp;tt-&gt;local,</span><=
br><span>                                 &amp;tt-&gt;remote_netmask) &lt; =
0)</span><br><span>@@ -1343,27 +1341,8 @@</span><br><span> #elif defined(TA=
RGET_ANDROID)</span><br><span>     char out[64];</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    char *top;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    switch (tt-&gt;topology)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        case TOP_NET30:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            top =3D &quot;net30&quot;;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        case TOP_P2P:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            top =3D &quot;p2p&quot;;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case TOP_SUBNET:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            top =3D &quot;subnet&quot;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            top =3D &quot;undef&quot;;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span>     snprintf(out, sizeof(out), &quot;%s %s %d %s=
&quot;, ifconfig_local,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-             ifconfig_remote_netmask, tun_mtu, top);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+             ifconfig_remote_netmask, tu=
n_mtu, print_topology(tt-&gt;topology));</span><br><span>     management_an=
droid_control(management, &quot;IFCONFIG&quot;, out);</span><br><span> </sp=
an><br><span> #elif defined(TARGET_SOLARIS)</span><br><span>@@ -1372,7 +135=
1,7 @@</span><br><span>      *    ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 =
up</span><br><span>      *    ifconfig tun2 netmask 255.255.255.255</span><=
br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (tun)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tun=
_p2p)</span><br><span>     {</span><br><span>         argv_printf(&amp;argv=
, &quot;%s %s %s %s mtu %d up&quot;, IFCONFIG_PATH, ifname,</span><br><span=
>                     ifconfig_local, ifconfig_remote_netmask, tun_mtu);</s=
pan><br><span>@@ -1386,13 +1365,13 @@</span><br><span>         argv_printf(=
&amp;argv, &quot;%s %s netmask 255.255.255.255&quot;, IFCONFIG_PATH,</span>=
<br><span>                     ifname);</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else if (tt-&gt;type =3D=3D DE=
V_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else if (tt-&gt;type =3D=3D DEV_TY=
PE_TUN)</span><br><span>     {</span><br><span>         argv_printf(&amp;ar=
gv, &quot;%s %s %s %s netmask %s mtu %d up&quot;, IFCONFIG_PATH,</span><br>=
<span>                     ifname, ifconfig_local, ifconfig_local,</span><b=
r><span>                     ifconfig_remote_netmask, tun_mtu);</span><br><=
span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else /* tap */</s=
pan><br><span>     {</span><br><span>         argv_printf(&amp;argv, &quot;=
%s %s %s netmask %s up&quot;,</span><br><span>                     IFCONFIG=
_PATH, ifname, ifconfig_local,</span><br><span>@@ -1405,7 +1384,7 @@</span>=
<br><span>         solaris_error_close(tt, es, ifname, false);</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (!tun &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; t=
t-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!tun_p2p &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN)<=
/span><br><span>     {</span><br><span>         /* Add a network route for =
the local tun interface */</span><br><span>         struct route_ipv4 r;</s=
pan><br><span>@@ -1429,14 +1408,14 @@</span><br><span>      */</span><br><s=
pan> </span><br><span>     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu =
1450 netmask 255.255.255.255 up */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (tun)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (tun_p2p)</span><br><span>     {</span><br><span>         argv=
_printf(&amp;argv,</span><br><span>                     &quot;%s %s %s %s m=
tu %d netmask 255.255.255.255 up -link0&quot;,</span><br><span>            =
         IFCONFIG_PATH, ifname, ifconfig_local,</span><br><span>           =
          ifconfig_remote_netmask, tun_mtu);</span><br><span>     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (tt-&gt;type =3D=
=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else if (tt-&gt;type =3D=3D =
DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         remote_end =
=3D create_arbitrary_remote( tt );</span><br><span>         argv_printf(&am=
p;argv, &quot;%s %s %s %s mtu %d netmask %s up -link0&quot;,</span><br><spa=
n>@@ -1444,7 +1423,7 @@</span><br><span>                     print_in_addr_=
t(remote_end, 0, &amp;gc), tun_mtu,</span><br><span>                     if=
config_remote_netmask);</span><br><span>     }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else /* tap */</span><br><span>     {</span><br><span>   =
      argv_printf(&amp;argv, &quot;%s %s %s netmask %s mtu %d link0&quot;,<=
/span><br><span>                     IFCONFIG_PATH, ifname, ifconfig_local,=
</span><br><span>@@ -1454,7 +1433,7 @@</span><br><span>     openvpn_execve_=
check(&amp;argv, es, S_FATAL, &quot;OpenBSD ifconfig failed&quot;);</span><=
br><span> </span><br><span>     /* Add a network route for the local tun in=
terface */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tu=
n &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=
=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!tun_p2p &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>  =
   {</span><br><span>         struct route_ipv4 r;</span><br><span>        =
 CLEAR(r);</span><br><span>@@ -1468,20 +1447,20 @@</span><br><span> #elif d=
efined(TARGET_NETBSD)</span><br><span>     in_addr_t remote_end =3D INADDR_=
ANY;  /* for &quot;virtual&quot; subnet topology */</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tun)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)</span><br><span> =
    {</span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s mtu=
 %d netmask 255.255.255.255 up&quot;,</span><br><span>                     =
IFCONFIG_PATH, ifname, ifconfig_local,</span><br><span>                    =
 ifconfig_remote_netmask, tun_mtu);</span><br><span>     }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    else if (tt-&gt;type =3D=3D DEV_TY=
PE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (tt-&gt;type =3D=3D DEV_TYPE_=
TUN)</span><br><span>     {</span><br><span>         remote_end =3D create_=
arbitrary_remote(tt);</span><br><span>         argv_printf(&amp;argv, &quot=
;%s %s %s %s mtu %d netmask %s up&quot;, IFCONFIG_PATH,</span><br><span>   =
                  ifname, ifconfig_local, print_in_addr_t(remote_end, 0, &a=
mp;gc),</span><br><span>                     tun_mtu, ifconfig_remote_netma=
sk);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse /* tap */</span><br><span>     {</span><br><span>         /*</span><br>=
<span>          * NetBSD has distinct tun and tap devices</span><br><span>@=
@ -1496,7 +1475,7 @@</span><br><span>     openvpn_execve_check(&amp;argv, e=
s, S_FATAL, &quot;NetBSD ifconfig failed&quot;);</span><br><span> </span><b=
r><span>     /* Add a network route for the local tun interface */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tun &amp;&amp; tt-&gt=
;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tun_p2p &amp;&=
amp; tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><spa=
n>         struct route_ipv4 r;</span><br><span>         CLEAR(r);</span><b=
r><span>@@ -1520,33 +1499,30 @@</span><br><span> </span><br><span> </span><=
br><span>     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask =
255.255.255.255 up */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (tun)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(tun_p2p)</span><br><span>     {</span><br><span>         argv_printf(&amp;=
argv, &quot;%s %s %s %s mtu %d netmask 255.255.255.255 up&quot;,</span><br>=
<span>                     IFCONFIG_PATH, ifname, ifconfig_local,</span><br=
><span>                     ifconfig_remote_netmask, tun_mtu);</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (tt-&gt;ty=
pe =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&=
amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            argv_printf(&amp;argv, &quot;%s %s %s %s netmask %s mtu %=
d up&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              IFCONFIG_PATH, ifname, ifconfig_local, ifconfig_local,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        ifco=
nfig_remote_netmask, tun_mtu);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            argv_printf(=
&amp;argv, &quot;%s %s %s netmask %s mtu %d up&quot;, IFCONFIG_PATH,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        ifna=
me, ifconfig_local, ifconfig_remote_netmask,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        tun_mtu);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s %s %s %s n=
etmask %s mtu %d up&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    IFCONFIG_PATH, ifname, ifconfig_local, ifconfig_=
local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       ifconfig_remote_netmask, tun_mtu);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    else /* tap */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 argv_printf(&amp;argv, &quot;%s %s %s netmask %s mtu %d up&quot;, IFCONFIG=
_PATH,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       ifname, ifconfig_local, ifconfig_remote_netmask,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    tun_mtu);</span><br=
><span>     }</span><br><span> </span><br><span>     argv_msg(M_INFO, &amp;=
argv);</span><br><span>     openvpn_execve_check(&amp;argv, es, S_FATAL, &q=
uot;Mac OS X ifconfig failed&quot;);</span><br><span> </span><br><span>    =
 /* Add a network route for the local tun interface */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (!tun &amp;&amp; tt-&gt;type =3D=3D=
 DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!tun_p2p &amp;&amp; tt-&gt;=
type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         s=
truct route_ipv4 r;</span><br><span>         CLEAR(r);</span><br><span>@@ -=
1560,7 +1536,7 @@</span><br><span> #elif defined(TARGET_FREEBSD) || defined=
(TARGET_DRAGONFLY)</span><br><span> </span><br><span>     /* example: ifcon=
fig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (tun)       /* point-to-=
point tun */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(tun_p2p)    /* point-to-point tun */</span><br><span>     {</span><br><spa=
n>         argv_printf(&amp;argv, &quot;%s %s %s %s mtu %d netmask 255.255.=
255.255 up&quot;,</span><br><span>                     IFCONFIG_PATH, ifnam=
e, ifconfig_local,</span><br><span>@@ -1582,7 +1558,7 @@</span><br><span>  =
       struct env_set *aix_es =3D env_set_create(NULL);</span><br><span>   =
      env_set_add( aix_es, &quot;ODMDIR=3D/etc/objrepos&quot; );</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (tu=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tt-&g=
t;type =3D=3D DEV_TYPE_TUN)</span><br><span>         {</span><br><span>    =
         msg(M_FATAL, &quot;no tun support on AIX (canthappen)&quot;);</spa=
n><br><span>         }</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/380?usp=3Demail">change 380=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/380?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ice8b95f953c3f7e71657a78ea12=
b02a08c60aa67 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 380 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--PCywEWw3VqE=--

