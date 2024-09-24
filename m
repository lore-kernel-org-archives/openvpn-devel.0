From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 24 Sep 2024 12:59:19 +0000
In-Reply-To: <gerrit.1726491830000.I5987ebb7c38ab176eed7efc004ea54f606a77a12@...2715...>
References: <gerrit.1726491830000.I5987ebb7c38ab176eed7efc004ea54f606a77a12@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b1da5fc685f00abf7a43ed9685fd840eeec9d9b7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BmhMxubk4sk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change dev null to
 be a driver type instead of a special mode of tun/tap
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BmhMxubk4sk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/74=
8?usp=3Demail )

Change subject: Change dev null to be a driver type instead of a special mo=
de of tun/tap
......................................................................

Change dev null to be a driver type instead of a special mode of tun/tap

Change-Id: I5987ebb7c38ab176eed7efc004ea54f606a77a12
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240924124328.3037-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
384.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
M src/openvpn/init.c
M src/openvpn/proto.h
M src/openvpn/tun.c
M src/openvpn/tun.h
5 files changed, 92 insertions(+), 113 deletions(-)




diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 161126b..38f934a 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -305,6 +305,12 @@
         return false;
     }

+    if (is_dev_type(o->dev, o->dev_type, "null"))
+    {
+        msg(msglevel, "Note: null tun type selected, disabling data channe=
l offload");
+        return false;
+    }
+
     if (o->connection_list)
     {
         const struct connection_list *l =3D o->connection_list;
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1a14e19..fbf2c5b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1764,6 +1764,10 @@
         /* Using AF_UNIX trumps using DCO */
         c->c1.tuntap->backend_driver =3D DRIVER_AFUNIX;
     }
+    else if (is_dev_type(c->options.dev,  c->options.dev_type, "null"))
+    {
+        c->c1.tuntap->backend_driver =3D DRIVER_NULL;
+    }
 #ifdef _WIN32
     else
     {
@@ -1858,7 +1862,12 @@
 open_tun_backend(struct context *c)
 {
     struct tuntap *tt =3D c->c1.tuntap;
-    if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
+
+    if (tt->backend_driver =3D=3D DRIVER_NULL)
+    {
+        open_tun_null(c->c1.tuntap);
+    }
+    else if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
         open_tun_afunix(&c->options, c->c2.frame.tun_mtu, tt, c->c2.es);
     }
@@ -2059,6 +2068,11 @@
         {
             close_tun_afunix(c->c1.tuntap);
         }
+        else if (c->c1.tuntap->backend_driver =3D=3D DRIVER_NULL)
+        {
+            free(c->c1.tuntap->actual_name);
+            free(c->c1.tuntap);
+        }
         else
         {
             close_tun(c->c1.tuntap, &c->net_ctx);
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 4b6d6d6..a160fb6 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -33,7 +33,6 @@
  * Tunnel types
  */
 #define DEV_TYPE_UNDEF 0
-#define DEV_TYPE_NULL  1
 #define DEV_TYPE_TUN   2    /* point-to-point IP tunnel */
 #define DEV_TYPE_TAP   3    /* ethernet (802.3) tunnel */

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b305b64..770e806 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -75,6 +75,9 @@
         case DRIVER_AFUNIX:
             return "unix";

+        case DRIVER_NULL:
+            return "null";
+
         case DRIVER_UTUN:
             return "utun";

@@ -463,7 +466,9 @@
 int
 dev_type_enum(const char *dev, const char *dev_type)
 {
-    if (is_dev_type(dev, dev_type, "tun"))
+    /* We pretend that the null device is also a tun device but it does not
+     * really matter as it will discard everything anyway */
+    if (is_dev_type(dev, dev_type, "tun") || is_dev_type(dev, dev_type, "n=
ull"))
     {
         return DEV_TYPE_TUN;
     }
@@ -471,10 +476,6 @@
     {
         return DEV_TYPE_TAP;
     }
-    else if (is_dev_type(dev, dev_type, "null"))
-    {
-        return DEV_TYPE_NULL;
-    }
     else
     {
         return DEV_TYPE_UNDEF;
@@ -492,9 +493,6 @@
         case DEV_TYPE_TAP:
             return "tap";

-        case DEV_TYPE_NULL:
-            return "null";
-
         default:
             return "[unknown-dev-type]";
     }
@@ -768,8 +766,7 @@
     bool tun_p2p =3D false;

     if (tt->type =3D=3D DEV_TYPE_TAP
-        || (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNET)
-        || tt->type =3D=3D DEV_TYPE_NULL)
+        || (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNET=
))
     {
         tun_p2p =3D false;
     }
@@ -780,7 +777,6 @@
     else
     {
         msg(M_FATAL, "Error: problem with tun vs. tap setting"); /* JYFIXM=
E -- needs to be caught earlier, in init_tun? */
-
     }
     return tun_p2p;
 }
@@ -1748,7 +1744,7 @@
 void
 undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
-    if (tt->type !=3D DEV_TYPE_NULL)
+    if (tt->backend_driver !=3D DRIVER_NULL)
     {
         if (tt->did_ifconfig_setup)
         {
@@ -1779,13 +1775,6 @@
 #endif
 }

-static void
-open_null(struct tuntap *tt)
-{
-    tt->actual_name =3D string_alloc("null", NULL);
-}
-
-
 #if defined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) && HAVE_NET_IF_UTU=
N_H)

 /*
@@ -1901,78 +1890,72 @@
     char dynamic_name[256];
     bool dynamic_opened =3D false;

-    if (tt->type =3D=3D DEV_TYPE_NULL)
+    /*
+     * --dev-node specified, so open an explicit device node
+     */
+    if (dev_node)
     {
-        open_null(tt);
+        snprintf(tunname, sizeof(tunname), "%s", dev_node);
     }
     else
     {
         /*
-         * --dev-node specified, so open an explicit device node
+         * dynamic open is indicated by --dev specified without
+         * explicit unit number.  Try opening /dev/[dev]n
+         * where n =3D [0, 255].
          */
-        if (dev_node)
+
+        if (!tun_name_is_fixed(dev))
         {
-            snprintf(tunname, sizeof(tunname), "%s", dev_node);
+            for (int i =3D 0; i < 256; ++i)
+            {
+                snprintf(tunname, sizeof(tunname),
+                         "/dev/%s%d", dev, i);
+                snprintf(dynamic_name, sizeof(dynamic_name),
+                         "%s%d", dev, i);
+                if ((tt->fd =3D open(tunname, O_RDWR)) > 0)
+                {
+                    dynamic_opened =3D true;
+                    break;
+                }
+                msg(D_READ_WRITE | M_ERRNO, "Tried opening %s (failed)", t=
unname);
+            }
+            if (!dynamic_opened)
+            {
+                msg(M_FATAL, "Cannot allocate TUN/TAP dev dynamically");
+            }
         }
+        /*
+         * explicit unit number specified
+         */
         else
         {
-            /*
-             * dynamic open is indicated by --dev specified without
-             * explicit unit number.  Try opening /dev/[dev]n
-             * where n =3D [0, 255].
-             */
-
-            if (!tun_name_is_fixed(dev))
-            {
-                for (int i =3D 0; i < 256; ++i)
-                {
-                    snprintf(tunname, sizeof(tunname),
-                             "/dev/%s%d", dev, i);
-                    snprintf(dynamic_name, sizeof(dynamic_name),
-                             "%s%d", dev, i);
-                    if ((tt->fd =3D open(tunname, O_RDWR)) > 0)
-                    {
-                        dynamic_opened =3D true;
-                        break;
-                    }
-                    msg(D_READ_WRITE | M_ERRNO, "Tried opening %s (failed)=
", tunname);
-                }
-                if (!dynamic_opened)
-                {
-                    msg(M_FATAL, "Cannot allocate TUN/TAP dev dynamically"=
);
-                }
-            }
-            /*
-             * explicit unit number specified
-             */
-            else
-            {
-                snprintf(tunname, sizeof(tunname), "/dev/%s", dev);
-            }
+            snprintf(tunname, sizeof(tunname), "/dev/%s", dev);
         }
-
-        if (!dynamic_opened)
-        {
-            /* has named device existed before? if so, don't destroy at en=
d */
-            if (if_nametoindex( dev ) > 0)
-            {
-                msg(M_INFO, "TUN/TAP device %s exists previously, keep at =
program end", dev );
-                tt->persistent_if =3D true;
-            }
-
-            if ((tt->fd =3D open(tunname, O_RDWR)) < 0)
-            {
-                msg(M_ERR, "Cannot open TUN/TAP dev %s", tunname);
-            }
-        }
-
-        set_nonblock(tt->fd);
-        set_cloexec(tt->fd); /* don't pass fd to scripts */
-        msg(M_INFO, "TUN/TAP device %s opened", tunname);
-
-        /* tt->actual_name is passed to up and down scripts and used as th=
e ifconfig dev name */
-        tt->actual_name =3D string_alloc(dynamic_opened ? dynamic_name : d=
ev, NULL);
     }
+
+    if (!dynamic_opened)
+    {
+        /* has named device existed before? if so, don't destroy at end */
+        if (if_nametoindex( dev ) > 0)
+        {
+            msg(M_INFO, "TUN/TAP device %s exists previously, keep at prog=
ram end", dev );
+            tt->persistent_if =3D true;
+        }
+
+        if ((tt->fd =3D open(tunname, O_RDWR)) < 0)
+        {
+            msg(M_ERR, "Cannot open TUN/TAP dev %s", tunname);
+        }
+    }
+
+    set_nonblock(tt->fd);
+    set_cloexec(tt->fd); /* don't pass fd to scripts */
+    msg(M_INFO, "TUN/TAP device %s opened", tunname);
+
+    /* tt->actual_name is passed to up and down scripts and used as the if=
config dev name */
+    tt->actual_name =3D string_alloc(dynamic_opened ? dynamic_name : dev, =
NULL);
+
 }
 #endif /* !_WIN32 && !TARGET_LINUX && !TARGET_FREEBSD*/

@@ -1984,12 +1967,6 @@
     char dynamic_name[256];
     bool dynamic_opened =3D false;

-    if (tt->type =3D=3D DEV_TYPE_NULL)
-    {
-        open_null(tt);
-        return;
-    }
-
     /*
      * unlike "open_tun_generic()", DCO on Linux and FreeBSD follows
      * the device naming model of "non-DCO linux", that is:
@@ -2172,14 +2149,7 @@
 {
     struct ifreq ifr;

-    /*
-     * We handle --dev null specially, we do not open /dev/null for this.
-     */
-    if (tt->type =3D=3D DEV_TYPE_NULL)
-    {
-        open_null(tt);
-    }
-    else if (tun_dco_enabled(tt))
+    if (tun_dco_enabled(tt))
     {
         open_tun_dco_generic(dev, dev_type, tt, ctx);
     }
@@ -2404,12 +2374,6 @@
      */
     CLEAR(ifr);

-    if (tt->type =3D=3D DEV_TYPE_NULL)
-    {
-        open_null(tt);
-        return;
-    }
-
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
         ip_node =3D "/dev/udp";
@@ -3488,12 +3452,6 @@
     char dynamic_name[20];
     const char *p;

-    if (tt->type =3D=3D DEV_TYPE_NULL)
-    {
-        open_null(tt);
-        return;
-    }
-
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
         msg(M_FATAL, "no support for 'tun' devices on AIX" );
@@ -6835,12 +6793,7 @@

     msg( M_INFO, "open_tun");

-    if (tt->type =3D=3D DEV_TYPE_NULL)
-    {
-        open_null(tt);
-        return;
-    }
-    else if (tt->type !=3D DEV_TYPE_TAP && tt->type !=3D DEV_TYPE_TUN)
+    if (tt->type !=3D DEV_TYPE_TAP && tt->type !=3D DEV_TYPE_TUN)
     {
         msg(M_FATAL|M_NOPREFIX, "Unknown virtual device type: '%s'", dev);
     }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index a38aef0..b2c1b01 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -51,6 +51,7 @@
      *  This is always defined. We error out if a user tries to open this =
type
      *  of backend on unsupported platforms. */
     DRIVER_AFUNIX,
+    DRIVER_NULL,
     DRIVER_DCO,
     /** macOS internal tun driver */
     DRIVER_UTUN
@@ -784,4 +785,10 @@
 {
     return tt && tt->type !=3D DEV_TYPE_UNDEF;
 }
+
+static inline void
+open_tun_null(struct tuntap *tt)
+{
+    tt->actual_name =3D string_alloc("null", NULL);
+}
 #endif /* TUN_H */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/748?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5987ebb7c38ab176eed7efc004ea54f606a77a12
Gerrit-Change-Number: 748
Gerrit-PatchSet: 12
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--BmhMxubk4sk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/748?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Change dev null to be a driver type instead of=
 a special mode of tun/tap<br><br>Change-Id: I5987ebb7c38ab176eed7efc004ea5=
4f606a77a12<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked=
-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20240924124328=
.3037-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg29384.html<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M src/openvpn/dco.c<br>M src/openvpn/init.c<b=
r>M src/openvpn/proto.h<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>5 =
files changed, 92 insertions(+), 113 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index=
 161126b..38f934a 100644</span><br><span>--- a/src/openvpn/dco.c</span><br>=
<span>+++ b/src/openvpn/dco.c</span><br><span>@@ -305,6 +305,12 @@</span><b=
r><span>         return false;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_dev_type(o-&=
gt;dev, o-&gt;dev_type, &quot;null&quot;))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(msglevel, &quot;Note: null tun type selected, disablin=
g data channel offload&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>     if (o-&gt;connection_list)</span><br><span>     {</spa=
n><br><span>         const struct connection_list *l =3D o-&gt;connection_l=
ist;</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</=
span><br><span>index 1a14e19..fbf2c5b 100644</span><br><span>--- a/src/open=
vpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -176=
4,6 +1764,10 @@</span><br><span>         /* Using AF_UNIX trumps using DCO =
*/</span><br><span>         c-&gt;c1.tuntap-&gt;backend_driver =3D DRIVER_A=
FUNIX;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (is_dev_type(c-&gt;options.dev,  c-&gt;options.dev_ty=
pe, &quot;null&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&=
gt;c1.tuntap-&gt;backend_driver =3D DRIVER_NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span> #ifdef _WIN32</span><br=
><span>     else</span><br><span>     {</span><br><span>@@ -1858,7 +1862,12=
 @@</span><br><span> open_tun_backend(struct context *c)</span><br><span> {=
</span><br><span>     struct tuntap *tt =3D c-&gt;c1.tuntap;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;backend_driver =3D=3D=
 DRIVER_AFUNIX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;backend_=
driver =3D=3D DRIVER_NULL)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 open_tun_null(c-&gt;c1.tuntap);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>   =
  {</span><br><span>         open_tun_afunix(&amp;c-&gt;options, c-&gt;c2.f=
rame.tun_mtu, tt, c-&gt;c2.es);</span><br><span>     }</span><br><span>@@ -=
2059,6 +2068,11 @@</span><br><span>         {</span><br><span>             =
close_tun_afunix(c-&gt;c1.tuntap);</span><br><span>         }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        else if (c-&gt;c1.tuntap-=
&gt;backend_driver =3D=3D DRIVER_NULL)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            free(c-&gt;c1.tuntap-&gt;actual_name);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            free(c-&gt;c1.tuntap);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span>         else</span><br><span>         {</span><br><span>            =
 close_tun(c-&gt;c1.tuntap, &amp;c-&gt;net_ctx);</span><br><span>diff --git=
 a/src/openvpn/proto.h b/src/openvpn/proto.h</span><br><span>index 4b6d6d6.=
.a160fb6 100644</span><br><span>--- a/src/openvpn/proto.h</span><br><span>+=
++ b/src/openvpn/proto.h</span><br><span>@@ -33,7 +33,6 @@</span><br><span>=
  * Tunnel types</span><br><span>  */</span><br><span> #define DEV_TYPE_UND=
EF 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define DEV_TYPE_=
NULL  1</span><br><span> #define DEV_TYPE_TUN   2    /* point-to-point IP t=
unnel */</span><br><span> #define DEV_TYPE_TAP   3    /* ethernet (802.3) t=
unnel */</span><br><span> </span><br><span>diff --git a/src/openvpn/tun.c b=
/src/openvpn/tun.c</span><br><span>index b305b64..770e806 100644</span><br>=
<span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span=
><br><span>@@ -75,6 +75,9 @@</span><br><span>         case DRIVER_AFUNIX:</=
span><br><span>             return &quot;unix&quot;;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        case DRIVER_NULL=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 &quot;null&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>         case DRIVER_UTUN:</span><br><span>             ret=
urn &quot;utun&quot;;</span><br><span> </span><br><span>@@ -463,7 +466,9 @@=
</span><br><span> int</span><br><span> dev_type_enum(const char *dev, const=
 char *dev_type)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (is_dev_type(dev, dev_type, &quot;tun&quot;))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* We pretend that the n=
ull device is also a tun device but it does not</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * really matter as it will discard everyth=
ing anyway */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (is_dev_type(dev, dev_type, &quot;tun&quot;) || is_dev_type(dev, dev_type,=
 &quot;null&quot;))</span><br><span>     {</span><br><span>         return =
DEV_TYPE_TUN;</span><br><span>     }</span><br><span>@@ -471,10 +476,6 @@</=
span><br><span>     {</span><br><span>         return DEV_TYPE_TAP;</span><=
br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    el=
se if (is_dev_type(dev, dev_type, &quot;null&quot;))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return DEV_TYPE_NULL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span>     else</span><br><span>   =
  {</span><br><span>         return DEV_TYPE_UNDEF;</span><br><span>@@ -492=
,9 +493,6 @@</span><br><span>         case DEV_TYPE_TAP:</span><br><span>  =
           return &quot;tap&quot;;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case DEV_TYPE_NULL:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            return &quot;null&quot;;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
    default:</span><br><span>             return &quot;[unknown-dev-type]&q=
uot;;</span><br><span>     }</span><br><span>@@ -768,8 +766,7 @@</span><br>=
<span>     bool tun_p2p =3D false;</span><br><span> </span><br><span>     i=
f (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        || (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;=
topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        || tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        || (tt-&gt;type =3D=3D DEV_TYPE_TUN =
&amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET))</span><br><span>     {</span=
><br><span>         tun_p2p =3D false;</span><br><span>     }</span><br><sp=
an>@@ -780,7 +777,6 @@</span><br><span>     else</span><br><span>     {</sp=
an><br><span>         msg(M_FATAL, &quot;Error: problem with tun vs. tap se=
tting&quot;); /* JYFIXME -- needs to be caught earlier, in init_tun? */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     }</=
span><br><span>     return tun_p2p;</span><br><span> }</span><br><span>@@ -=
1748,7 +1744,7 @@</span><br><span> void</span><br><span> undo_ifconfig(stru=
ct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type !=3D DEV_TYPE_NULL)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;back=
end_driver !=3D DRIVER_NULL)</span><br><span>     {</span><br><span>       =
  if (tt-&gt;did_ifconfig_setup)</span><br><span>         {</span><br><span=
>@@ -1779,13 +1775,6 @@</span><br><span> #endif</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-open_null(struct tunta=
p *tt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    tt-&gt;actual_name =3D string_a=
lloc(&quot;null&quot;, NULL);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #if defined (TA=
RGET_OPENBSD) || (defined(TARGET_DARWIN) &amp;&amp; HAVE_NET_IF_UTUN_H)</sp=
an><br><span> </span><br><span> /*</span><br><span>@@ -1901,78 +1890,72 @@<=
/span><br><span>     char dynamic_name[256];</span><br><span>     bool dyna=
mic_opened =3D false;</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * --dev-node specified, so open an explicit=
 device node</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dev_node)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        open_null(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        snprintf(tunname, sizeof(tunname), &quot;%s&quot;, dev_node);</s=
pan><br><span>     }</span><br><span>     else</span><br><span>     {</span=
><br><span>         /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-         * --dev-node specified, so open an explicit device node</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * dynamic open is in=
dicated by --dev specified without</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * explicit unit number.  Try opening /dev/[dev]n</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * where n =3D=
 [0, 255].</span><br><span>          */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (dev_node)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!tun_name_is_fixed(dev))</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            snprintf(tunname, si=
zeof(tunname), &quot;%s&quot;, dev_node);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            for (int i =3D 0; i &lt; 256; ++i)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                snprintf(tunname=
, sizeof(tunname),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                        &quot;/dev/%s%d&quot;, dev, i);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                snprintf(dynamic_name, =
sizeof(dynamic_name),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                         &quot;%s%d&quot;, dev, i);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                if ((tt-&gt;fd =3D open(t=
unname, O_RDWR)) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    dynamic_opened =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    break;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(D_READ_WRITE | M_ERRN=
O, &quot;Tried opening %s (failed)&quot;, tunname);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (!dynamic_opened)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                msg(M_FATAL, &quot;Canno=
t allocate TUN/TAP dev dynamically&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span>         }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * explicit unit number specifie=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span>=
<br><span>         else</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            /*</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-             * dynamic open is indicated by --dev spe=
cified without</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
      * explicit unit number.  Try opening /dev/[dev]n</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-             * where n =3D [0, 255].</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-             */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            if (!tun_name_is_fixed(dev))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                for (int i =3D 0; i &lt; 25=
6; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  snprintf(tunname, sizeof(tunname),</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                             &quot;/dev/%s%d&quot;, dev, i);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    s=
nprintf(dynamic_name, sizeof(dynamic_name),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                             &quot;%s%d&quot;, dev, i=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 if ((tt-&gt;fd =3D open(tunname, O_RDWR)) &gt; 0)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                        dynamic_opened =3D tru=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          msg(D_READ_WRITE | M_ERRNO, &quot;Tried opening %s (failed)&quot;=
, tunname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  if (!dynamic_opened)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 msg(M_FATAL, &quot;Cannot allocate TUN/TAP dev dynamically=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-             * explicit unit num=
ber specified</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                snprintf(tu=
nname, sizeof(tunname), &quot;/dev/%s&quot;, dev);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            snprintf(tunname, sizeof(tunname), &quot=
;/dev/%s&quot;, dev);</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (!dynamic_opened)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            /* has named device existed before? if so, don&#39;t destroy a=
t end */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
f (if_nametoindex( dev ) &gt; 0)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                msg(M_INFO, &quot;TUN/TAP device %s exists previously, k=
eep at program end&quot;, dev );</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                tt-&gt;persistent_if =3D true;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            if ((tt-&gt;fd =3D open(tunname, O_RDWR)) &lt; 0)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                msg(M_ERR, &quot;Can=
not open TUN/TAP dev %s&quot;, tunname);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        set_nonblock(t=
t-&gt;fd);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        set=
_cloexec(tt-&gt;fd); /* don&#39;t pass fd to scripts */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;TUN/TAP device =
%s opened&quot;, tunname);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* tt-&g=
t;actual_name is passed to up and down scripts and used as the ifconfig dev=
 name */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tt-&g=
t;actual_name =3D string_alloc(dynamic_opened ? dynamic_name : dev, NULL);<=
/span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dynamic=
_opened)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* has named devi=
ce existed before? if so, don&#39;t destroy at end */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (if_nametoindex( dev ) &gt; 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO, &quot=
;TUN/TAP device %s exists previously, keep at program end&quot;, dev );</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            tt-&gt;pers=
istent_if =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if ((tt-&gt;fd =3D op=
en(tunname, O_RDWR)) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(M_ERR, &quot;Cannot open TUN/TAP dev %s&quot;, tunname);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    set_nonblock(tt-&gt;fd);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    set_cloexec(tt-&gt;fd); /* don&#39;t pass fd to scrip=
ts */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO=
, &quot;TUN/TAP device %s opened&quot;, tunname);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* tt-&gt;actual_name is passed to up and down scripts and u=
sed as the ifconfig dev name */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    tt-&gt;actual_name =3D string_alloc(dynamic_opened ? dynami=
c_name : dev, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> }</span><br><span> #endif /* !_WIN32 &amp;&amp; !TARGET_=
LINUX &amp;&amp; !TARGET_FREEBSD*/</span><br><span> </span><br><span>@@ -19=
84,12 +1967,6 @@</span><br><span>     char dynamic_name[256];</span><br><sp=
an>     bool dynamic_opened =3D false;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_NULL=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        open_null(tt);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span>     /*</span><br><span>      * unlike &=
quot;open_tun_generic()&quot;, DCO on Linux and FreeBSD follows</span><br><=
span>      * the device naming model of &quot;non-DCO linux&quot;, that is:=
</span><br><span>@@ -2172,14 +2149,7 @@</span><br><span> {</span><br><span>=
     struct ifreq ifr;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * We handle --dev null specially, we do not open /dev/null for thi=
s.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TY=
PE_NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        open_null(tt);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (tun_dco_enabled(tt))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (tun_dco_enabled(tt))<=
/span><br><span>     {</span><br><span>         open_tun_dco_generic(dev, d=
ev_type, tt, ctx);</span><br><span>     }</span><br><span>@@ -2404,12 +2374=
,6 @@</span><br><span>      */</span><br><span>     CLEAR(ifr);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;=
type =3D=3D DEV_TYPE_NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ope=
n_null(tt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (tt-&gt=
;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         =
ip_node =3D &quot;/dev/udp&quot;;</span><br><span>@@ -3488,12 +3452,6 @@</s=
pan><br><span>     char dynamic_name[20];</span><br><span>     const char *=
p;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        open_null(tt);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
    if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><=
span>         msg(M_FATAL, &quot;no support for &#39;tun&#39; devices on AI=
X&quot; );</span><br><span>@@ -6835,12 +6793,7 @@</span><br><span> </span><=
br><span>     msg( M_INFO, &quot;open_tun&quot;);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DE=
V_TYPE_NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        open_null(tt);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    else if (tt-&gt;type !=3D DEV_TYPE_TAP &am=
p;&amp; tt-&gt;type !=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (tt-&gt;type !=3D DEV_TYPE_TAP &amp;&amp; tt-&gt;=
type !=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         msg=
(M_FATAL|M_NOPREFIX, &quot;Unknown virtual device type: &#39;%s&#39;&quot;,=
 dev);</span><br><span>     }</span><br><span>diff --git a/src/openvpn/tun.=
h b/src/openvpn/tun.h</span><br><span>index a38aef0..b2c1b01 100644</span><=
br><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</s=
pan><br><span>@@ -51,6 +51,7 @@</span><br><span>      *  This is always def=
ined. We error out if a user tries to open this type</span><br><span>      =
*  of backend on unsupported platforms. */</span><br><span>     DRIVER_AFUN=
IX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DRIVER_NULL,=
</span><br><span>     DRIVER_DCO,</span><br><span>     /** macOS internal t=
un driver */</span><br><span>     DRIVER_UTUN</span><br><span>@@ -784,4 +78=
5,10 @@</span><br><span> {</span><br><span>     return tt &amp;&amp; tt-&gt=
;type !=3D DEV_TYPE_UNDEF;</span><br><span> }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static inline void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+open_tun_null(struct tuntap *tt)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    tt-&gt;actual_name =3D string_alloc(&quot;null&quot;, NULL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #endif /* =
TUN_H */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/748?usp=3Demail">change 748</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/748?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5987ebb7c38ab176eed7efc004e=
a54f606a77a12 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 748 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--BmhMxubk4sk=--

