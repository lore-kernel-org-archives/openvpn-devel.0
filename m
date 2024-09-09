From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 9 Sep 2024 09:33:49 +0000
In-Reply-To: <gerrit.1699291967000.Ice8b95f953c3f7e71657a78ea12b02a08c60aa67@...2715...>
References: <gerrit.1699291967000.Ice8b95f953c3f7e71657a78ea12b02a08c60aa67@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <44d1adacf89cf16e94cd806e7772980101179e30-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sALzgQLRKoY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sALzgQLRKoY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/38=
0?usp=3Demail )

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
=20
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
Gerrit-MessageType: merged

--sALzgQLRKoY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/380?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">tun: use is_tun_p2p more consistently<br><br>U=
sing &quot;tun&quot; as the variable name for the return of<br>is_tun_p2p i=
s probably a historical accident. But<br>it has actual consequences in that=
 the other code<br>often seems to assume that it does less checks<br>than i=
t actually does.<br><br>Use &quot;tun_p2p&quot; as the variable name and re=
move checks<br>that are not required. Also use is_tun_p2p in more<br>places=
.<br><br>Change-Id: Ice8b95f953c3f7e71657a78ea12b02a08c60aa67<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &=
lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20240906162514.78671-1-fr=
ank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg29091.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpn/tun.c<br>1 file changed, 48 insertions(+=
), 72 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index=
 ce3d882..739e008 100644</span><br><span>--- a/src/openvpn/tun.c</span><br>=
<span>+++ b/src/openvpn/tun.c</span><br><span>@@ -499,31 +499,31 @@</span><=
br><span> static const char ifconfig_warn_how_to_silence[] =3D &quot;(silen=
ce this warning with --ifconfig-nowarn)&quot;;</span><br><span> </span><br>=
<span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If !tun, =
make sure ifconfig_remote_netmask looks</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * If !tun_p2p, make sure ifconfig_remote_netmask looks=
</span><br><span>  *  like a netmask.</span><br><span>  *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * If tun, make sure ifconfig_remote_ne=
tmask looks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If tu=
n_p2p, make sure ifconfig_remote_netmask looks</span><br><span>  *  like an=
 IPv4 address.</span><br><span>  */</span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_sanity_check(bool tun, =
in_addr_t addr, int topology)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ifconfig_sanity_check(bool tun_p2p, in_addr_t addr)</span><br><sp=
an> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
>     const bool looks_like_netmask =3D ((addr &amp; 0xFF000000) =3D=3D 0xF=
F000000);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tun)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (looks_like_netmask &amp;&amp; (topology =3D=3D TOP_NET30 || topo=
logy =3D=3D TOP_P2P))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (looks_like_netmask)</span><br><span>         {</span><br><spa=
n>             msg(M_WARN, &quot;WARNING: Since you are using --dev tun wit=
h a point-to-point topology, the second argument to --ifconfig must be an I=
P address.  You are using something (%s) that looks more like a netmask. %s=
&quot;,</span><br><span>                 print_in_addr_t(addr, 0, &amp;gc),=
</span><br><span>                 ifconfig_warn_how_to_silence);</span><br>=
<span>         }</span><br><span>     }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    else /* tap */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else</span><br><span>     {</span><br><span>         i=
f (!looks_like_netmask)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WARNING: Since y=
ou are using --dev tap, the second argument to --ifconfig must be a netmask=
, for example something like 255.255.255.0. %s&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;WARNING: Si=
nce you are using subnet topology, the second argument to --ifconfig must b=
e a netmask, for example something like 255.255.255.0. %s&quot;,</span><br>=
<span>                 ifconfig_warn_how_to_silence);</span><br><span>     =
    }</span><br><span>     }</span><br><span>@@ -667,13 +667,13 @@</span><b=
r><span>     struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span> =
    if (tt-&gt;did_ifconfig_setup &amp;&amp; !disable)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (tt-&gt;=
type =3D=3D DEV_TYPE_TAP || (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-=
&gt;topology =3D=3D TOP_SUBNET))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (!is_tun_p2p(tt))</span><br><span>         {</span>=
<br><span>             buf_printf(&amp;out, &quot;%s %s&quot;,</span><br><s=
pan>                        print_in_addr_t(tt-&gt;local &amp; tt-&gt;remot=
e_netmask, 0, gc),</span><br><span>                        print_in_addr_t(=
tt-&gt;remote_netmask, 0, gc));</span><br><span>         }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        else if (tt-&gt;type =3D=3D DE=
V_TYPE_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
else if (tt-&gt;type =3D=3D DEV_TYPE_TUN) /* tun p2p topology */</span><br>=
<span>         {</span><br><span>             const char *l, *r;</span><br>=
<span>             if (remote)</span><br><span>@@ -737,24 +737,24 @@</span>=
<br><span> bool</span><br><span> is_tun_p2p(const struct tuntap *tt)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool =
tun =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
ool tun_p2p =3D false;</span><br><span> </span><br><span>     if (tt-&gt;ty=
pe =3D=3D DEV_TYPE_TAP</span><br><span>         || (tt-&gt;type =3D=3D DEV_=
TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span>    =
     || tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        tun =3D false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        tun_p2p =3D false;</s=
pan><br><span>     }</span><br><span>     else if (tt-&gt;type =3D=3D DEV_T=
YPE_TUN)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        tun =3D true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        tun_p2p =3D true;</span><br><span>     }</span><br><spa=
n>     else</span><br><span>     {</span><br><span>         msg(M_FATAL, &q=
uot;Error: problem with tun vs. tap setting&quot;); /* JYFIXME -- needs to =
be caught earlier, in init_tun? */</span><br><span> </span><br><span>     }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return tun;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tun_p2p;</span=
><br><span> }</span><br><span> </span><br><span> /*</span><br><span>@@ -831=
,12 +831,10 @@</span><br><span> </span><br><span>     if (ifconfig_local_pa=
rm &amp;&amp; ifconfig_remote_netmask_parm)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        bool tun =3D false;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>       =
  /*</span><br><span>          * We only handle TUN/TAP devices here, not -=
-dev null devices.</span><br><span>          */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        tun =3D is_tun_p2p(tt);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        bool tun_p2p =3D is_tun_p2p(t=
t);</span><br><span> </span><br><span>         /*</span><br><span>         =
 * Convert arguments to binary IPv4 addresses.</span><br><span>@@ -853,7 +8=
51,7 @@</span><br><span>             NULL);</span><br><span> </span><br><sp=
an>         tt-&gt;remote_netmask =3D getaddr(</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            (tun ? GETADDR_RESOLVE : 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            (tun_p2p ? GETADDR=
_RESOLVE : 0)</span><br><span>             | GETADDR_HOST_ORDER</span><br><=
span>             | GETADDR_FATAL_ON_SIGNAL</span><br><span>             | =
GETADDR_FATAL,</span><br><span>@@ -868,7 +866,7 @@</span><br><span>        =
 if (strict_warn)</span><br><span>         {</span><br><span>             s=
truct addrinfo *curele;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            ifconfig_sanity_check(tt-&gt;type =3D=3D DEV_TYPE_TUN, tt-&gt=
;remote_netmask, tt-&gt;topology);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            ifconfig_sanity_check(tun_p2p, tt-&gt;remote_net=
mask);</span><br><span> </span><br><span>             /*</span><br><span>  =
            * If local_public or remote_public addresses are defined,</span=
><br><span>@@ -899,11 +897,11 @@</span><br><span>                 }</span><=
br><span>             }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (tt-&gt;type =3D=3D DEV_TYPE_TAP || (tt-=
&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!tu=
n_p2p)</span><br><span>             {</span><br><span>                 chec=
k_subnet_conflict(tt-&gt;local, tt-&gt;remote_netmask, &quot;TUN/TAP adapte=
r&quot;);</span><br><span>             }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span=
><br><span>             {</span><br><span>                 check_subnet_con=
flict(tt-&gt;local, IPV4_NETMASK_HOST, &quot;TUN/TAP adapter&quot;);</span>=
<br><span>             }</span><br><span>@@ -914,7 +912,7 @@</span><br><spa=
n>          * Make sure that both ifconfig addresses are part of the</span>=
<br><span>          * same .252 subnet.</span><br><span>          */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (tun)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (tun_p2p)</span><br>=
<span>         {</span><br><span>             verify_255_255_255_252(tt-&gt=
;local, tt-&gt;remote_netmask);</span><br><span>             tt-&gt;adapter=
_netmask =3D ~3;</span><br><span>@@ -1297,7 +1295,7 @@</span><br><span>    =
 /*</span><br><span>      * We only handle TUN/TAP devices here, not --dev =
null devices.</span><br><span>      */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    bool tun =3D is_tun_p2p(tt);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    bool tun_p2p =3D is_tun_p2p(tt);</span><b=
r><span> #endif</span><br><span> </span><br><span> #if !defined(TARGET_LINU=
X)</span><br><span>@@ -1324,7 +1322,7 @@</span><br><span>         msg(M_FAT=
AL, &quot;Linux can&#39;t bring %s up&quot;, ifname);</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (tun)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (t=
un_p2p)</span><br><span>     {</span><br><span>         if (net_addr_ptp_v4=
_add(ctx, ifname, &amp;tt-&gt;local,</span><br><span>                      =
           &amp;tt-&gt;remote_netmask) &lt; 0)</span><br><span>@@ -1343,27 =
+1341,8 @@</span><br><span> #elif defined(TARGET_ANDROID)</span><br><span> =
    char out[64];</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    char *top;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    switch (tt-&gt;topology)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      case TOP_NET30:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            top =3D &quot;net30&quot;;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 case TOP_P2P:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     top =3D &quot;p2p&quot;;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TOP=
_SUBNET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            t=
op =3D &quot;subnet&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        default:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            top =3D &quo=
t;undef&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     s=
nprintf(out, sizeof(out), &quot;%s %s %d %s&quot;, ifconfig_local,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-             ifconfig_remote_n=
etmask, tun_mtu, top);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+             ifconfig_remote_netmask, tun_mtu, print_topology(tt-&gt;top=
ology));</span><br><span>     management_android_control(management, &quot;=
IFCONFIG&quot;, out);</span><br><span> </span><br><span> #elif defined(TARG=
ET_SOLARIS)</span><br><span>@@ -1372,7 +1351,7 @@</span><br><span>      *  =
  ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 up</span><br><span>      *    if=
config tun2 netmask 255.255.255.255</span><br><span>      */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (tun)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)</span><br><span>     {</=
span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s mtu %d up&=
quot;, IFCONFIG_PATH, ifname,</span><br><span>                     ifconfig=
_local, ifconfig_remote_netmask, tun_mtu);</span><br><span>@@ -1386,13 +136=
5,13 @@</span><br><span>         argv_printf(&amp;argv, &quot;%s %s netmask=
 255.255.255.255&quot;, IFCONFIG_PATH,</span><br><span>                    =
 ifname);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;t=
opology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {=
</span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s netmask =
%s mtu %d up&quot;, IFCONFIG_PATH,</span><br><span>                     ifn=
ame, ifconfig_local, ifconfig_local,</span><br><span>                     i=
fconfig_remote_netmask, tun_mtu);</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else /* tap */</span><br><span>     {</span><br=
><span>         argv_printf(&amp;argv, &quot;%s %s %s netmask %s up&quot;,<=
/span><br><span>                     IFCONFIG_PATH, ifname, ifconfig_local,=
</span><br><span>@@ -1405,7 +1384,7 @@</span><br><span>         solaris_err=
or_close(tt, es, ifname, false);</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tun &amp;&amp;=
 tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBN=
ET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tun_p2p=
 &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><=
br><span>         /* Add a network route for the local tun interface */</sp=
an><br><span>         struct route_ipv4 r;</span><br><span>@@ -1429,14 +140=
8,14 @@</span><br><span>      */</span><br><span> </span><br><span>     /* =
example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 u=
p */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tun)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)</span><=
br><span>     {</span><br><span>         argv_printf(&amp;argv,</span><br><=
span>                     &quot;%s %s %s %s mtu %d netmask 255.255.255.255 =
up -link0&quot;,</span><br><span>                     IFCONFIG_PATH, ifname=
, ifconfig_local,</span><br><span>                     ifconfig_remote_netm=
ask, tun_mtu);</span><br><span>     }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-=
&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span> =
    {</span><br><span>         remote_end =3D create_arbitrary_remote( tt )=
;</span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s mtu %d =
netmask %s up -link0&quot;,</span><br><span>@@ -1444,7 +1423,7 @@</span><br=
><span>                     print_in_addr_t(remote_end, 0, &amp;gc), tun_mt=
u,</span><br><span>                     ifconfig_remote_netmask);</span><br=
><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else /* tap */<=
/span><br><span>     {</span><br><span>         argv_printf(&amp;argv, &quo=
t;%s %s %s netmask %s mtu %d link0&quot;,</span><br><span>                 =
    IFCONFIG_PATH, ifname, ifconfig_local,</span><br><span>@@ -1454,7 +1433=
,7 @@</span><br><span>     openvpn_execve_check(&amp;argv, es, S_FATAL, &qu=
ot;OpenBSD ifconfig failed&quot;);</span><br><span> </span><br><span>     /=
* Add a network route for the local tun interface */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!tun &amp;&amp; tt-&gt;type =3D=3D =
DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!tun_p2p &amp;&amp; tt-&gt;t=
ype =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         st=
ruct route_ipv4 r;</span><br><span>         CLEAR(r);</span><br><span>@@ -1=
468,20 +1447,20 @@</span><br><span> #elif defined(TARGET_NETBSD)</span><br>=
<span>     in_addr_t remote_end =3D INADDR_ANY;  /* for &quot;virtual&quot;=
 subnet topology */</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (tun)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (tun_p2p)</span><br><span>     {</span><br><span>         a=
rgv_printf(&amp;argv, &quot;%s %s %s %s mtu %d netmask 255.255.255.255 up&q=
uot;,</span><br><span>                     IFCONFIG_PATH, ifname, ifconfig_=
local,</span><br><span>                     ifconfig_remote_netmask, tun_mt=
u);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topolog=
y =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span=
><br><span>         remote_end =3D create_arbitrary_remote(tt);</span><br><=
span>         argv_printf(&amp;argv, &quot;%s %s %s %s mtu %d netmask %s up=
&quot;, IFCONFIG_PATH,</span><br><span>                     ifname, ifconfi=
g_local, print_in_addr_t(remote_end, 0, &amp;gc),</span><br><span>         =
            tun_mtu, ifconfig_remote_netmask);</span><br><span>     }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else /* tap */</span><br><span>   =
  {</span><br><span>         /*</span><br><span>          * NetBSD has dist=
inct tun and tap devices</span><br><span>@@ -1496,7 +1475,7 @@</span><br><s=
pan>     openvpn_execve_check(&amp;argv, es, S_FATAL, &quot;NetBSD ifconfig=
 failed&quot;);</span><br><span> </span><br><span>     /* Add a network rou=
te for the local tun interface */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!tun &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&a=
mp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!tun_p2p &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_=
TUN)</span><br><span>     {</span><br><span>         struct route_ipv4 r;</=
span><br><span>         CLEAR(r);</span><br><span>@@ -1520,33 +1499,30 @@</=
span><br><span> </span><br><span> </span><br><span>     /* example: ifconfi=
g tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (tun)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)</span><br><span>     {<=
/span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s mtu %d ne=
tmask 255.255.255.255 up&quot;,</span><br><span>                     IFCONF=
IG_PATH, ifname, ifconfig_local,</span><br><span>                     ifcon=
fig_remote_netmask, tun_mtu);</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_=
SUBNET)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            argv_printf(&a=
mp;argv, &quot;%s %s %s %s netmask %s mtu %d up&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                        IFCONFIG_PATH, ifn=
ame, ifconfig_local, ifconfig_local,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                        ifconfig_remote_netmask, tun_mtu);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            argv_printf(&amp;argv, &quot;%s %s %s netma=
sk %s mtu %d up&quot;, IFCONFIG_PATH,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        ifname, ifconfig_local, ifconfig_re=
mote_netmask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                tun_mtu);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  argv_printf(&amp;argv, &quot;%s %s %s %s netmask %s mtu %d up&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    IFCO=
NFIG_PATH, ifname, ifconfig_local, ifconfig_local,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    ifconfig_remote_netmask,=
 tun_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else /* tap */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%=
s %s %s netmask %s mtu %d up&quot;, IFCONFIG_PATH,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    ifname, ifconfig_local, =
ifconfig_remote_netmask,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    tun_mtu);</span><br><span>     }</span><br><span> =
</span><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><span>     ope=
nvpn_execve_check(&amp;argv, es, S_FATAL, &quot;Mac OS X ifconfig failed&qu=
ot;);</span><br><span> </span><br><span>     /* Add a network route for the=
 local tun interface */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (!tun &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt=
;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!tun_p2p &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN)</span=
><br><span>     {</span><br><span>         struct route_ipv4 r;</span><br><=
span>         CLEAR(r);</span><br><span>@@ -1560,7 +1536,7 @@</span><br><sp=
an> #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><s=
pan> </span><br><span>     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu =
1450 netmask 255.255.255.255 up */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (tun)       /* point-to-point tun */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)    /* point-to-point =
tun */</span><br><span>     {</span><br><span>         argv_printf(&amp;arg=
v, &quot;%s %s %s %s mtu %d netmask 255.255.255.255 up&quot;,</span><br><sp=
an>                     IFCONFIG_PATH, ifname, ifconfig_local,</span><br><s=
pan>@@ -1582,7 +1558,7 @@</span><br><span>         struct env_set *aix_es =
=3D env_set_create(NULL);</span><br><span>         env_set_add( aix_es, &qu=
ot;ODMDIR=3D/etc/objrepos&quot; );</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (tun)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</=
span><br><span>         {</span><br><span>             msg(M_FATAL, &quot;n=
o tun support on AIX (canthappen)&quot;);</span><br><span>         }</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/380?usp=3Demail">change 380</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/380?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--sALzgQLRKoY=--

