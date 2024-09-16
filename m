From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 16 Sep 2024 22:42:33 +0000
In-Reply-To: <gerrit.1726491830000.I5987ebb7c38ab176eed7efc004ea54f606a77a12@...2715...>
References: <gerrit.1726491830000.I5987ebb7c38ab176eed7efc004ea54f606a77a12@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <9ac38cda0c7320cb344a659a2850edfbaaf38366-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4mxJKwFgRA4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4mxJKwFgRA4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/748?usp=3Demail

to look at the new patch set (#3).


Change subject: Change dev null to be a driver type instead of a special mo=
de of tun/tap
......................................................................

Change dev null to be a driver type instead of a special mode of tun/tap

Change-Id: I5987ebb7c38ab176eed7efc004ea54f606a77a12
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/init.c
M src/openvpn/proto.h
M src/openvpn/tun.c
M src/openvpn/tun.h
4 files changed, 86 insertions(+), 113 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/748/3

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b516608..378dd48 100644
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
             tun_afunix_close(c->c1.tuntap);
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
index 3f5f450..c6f14c3 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -78,6 +78,9 @@
         case DRIVER_AFUNIX:
             return "unix";

+        case DRIVER_NULL:
+            return "null";
+
 #ifdef HAVE_NET_IF_UTUN_H
         case DRIVER_UTUN:
             return "utun";
@@ -468,7 +471,9 @@
 int
 dev_type_enum(const char *dev, const char *dev_type)
 {
-    if (is_dev_type(dev, dev_type, "tun"))
+    /* We pretend that the null device is also a tun device but it does not
+     * really matter as it will discard evertything anyway */
+    if (is_dev_type(dev, dev_type, "tun") || is_dev_type(dev, dev_type, "n=
ull"))
     {
         return DEV_TYPE_TUN;
     }
@@ -476,10 +481,6 @@
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
@@ -497,9 +498,6 @@
         case DEV_TYPE_TAP:
             return "tap";

-        case DEV_TYPE_NULL:
-            return "null";
-
         default:
             return "[unknown-dev-type]";
     }
@@ -773,8 +771,7 @@
     bool tun_p2p =3D false;

     if (tt->type =3D=3D DEV_TYPE_TAP
-        || (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNET)
-        || tt->type =3D=3D DEV_TYPE_NULL)
+        || (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNET=
))
     {
         tun_p2p =3D false;
     }
@@ -785,7 +782,6 @@
     else
     {
         msg(M_FATAL, "Error: problem with tun vs. tap setting"); /* JYFIXM=
E -- needs to be caught earlier, in init_tun? */
-
     }
     return tun_p2p;
 }
@@ -1751,7 +1747,7 @@
 void
 undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
-    if (tt->type !=3D DEV_TYPE_NULL)
+    if (tt->backend_driver !=3D DRIVER_AFUNIX && tt->backend_driver !=3D D=
RIVER_NULL)
     {
         if (tt->did_ifconfig_setup)
         {
@@ -1782,13 +1778,6 @@
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
@@ -1904,78 +1893,72 @@
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

@@ -1987,12 +1970,6 @@
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
@@ -2175,14 +2152,7 @@
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
@@ -2407,12 +2377,6 @@
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
@@ -3491,12 +3455,6 @@
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
@@ -6838,12 +6796,7 @@

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
index 75a4218..5287e0c 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -54,6 +54,7 @@
      *  this is always defined. We error out if a user tries to open this =
type
      *  on unsupported platforms*/
     DRIVER_AFUNIX,
+    DRIVER_NULL,
     DRIVER_DCO,
 #ifdef HAVE_NET_IF_UTUN_H
     DRIVER_UTUN
@@ -790,4 +791,10 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--4mxJKwFgRA4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/748?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Change dev null to be a driver type instead of a special mode of tun/=
tap<br><br>Change-Id: I5987ebb7c38ab176eed7efc004ea54f606a77a12<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/init.c<=
br>M src/openvpn/proto.h<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>4=
 files changed, 86 insertions(+), 113 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/48/748/3</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index b516608..3=
78dd48 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ =
b/src/openvpn/init.c</span><br><span>@@ -1764,6 +1764,10 @@</span><br><span=
>         /* Using AF_UNIX trumps using DCO */</span><br><span>         c-&=
gt;c1.tuntap-&gt;backend_driver =3D DRIVER_AFUNIX;</span><br><span>     }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (is_dev_t=
ype(c-&gt;options.dev,  c-&gt;options.dev_type, &quot;null&quot;))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c1.tuntap-&gt;backend_drive=
r =3D DRIVER_NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span> #ifdef _WIN32</span><br><span>     else</span><br><sp=
an>     {</span><br><span>@@ -1858,7 +1862,12 @@</span><br><span> open_tun_=
backend(struct context *c)</span><br><span> {</span><br><span>     struct t=
untap *tt =3D c-&gt;c1.tuntap;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (tt-&gt;backend_driver =3D=3D DRIVER_NULL)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        open_tun_null(c-&gt;c1.tuntap=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else if (tt-&gt;backend_dri=
ver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>         o=
pen_tun_afunix(&amp;c-&gt;options, c-&gt;c2.frame.tun_mtu, tt, c-&gt;c2.es)=
;</span><br><span>     }</span><br><span>@@ -2059,6 +2068,11 @@</span><br><=
span>         {</span><br><span>             tun_afunix_close(c-&gt;c1.tunt=
ap);</span><br><span>         }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else if (c-&gt;c1.tuntap-&gt;backend_driver =3D=3D DRIV=
ER_NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            free(c-&g=
t;c1.tuntap-&gt;actual_name);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            free(c-&gt;c1.tuntap);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span>         else</span><br>=
<span>         {</span><br><span>             close_tun(c-&gt;c1.tuntap, &a=
mp;c-&gt;net_ctx);</span><br><span>diff --git a/src/openvpn/proto.h b/src/o=
penvpn/proto.h</span><br><span>index 4b6d6d6..a160fb6 100644</span><br><spa=
n>--- a/src/openvpn/proto.h</span><br><span>+++ b/src/openvpn/proto.h</span=
><br><span>@@ -33,7 +33,6 @@</span><br><span>  * Tunnel types</span><br><sp=
an>  */</span><br><span> #define DEV_TYPE_UNDEF 0</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define DEV_TYPE_NULL  1</span><br><span> #defi=
ne DEV_TYPE_TUN   2    /* point-to-point IP tunnel */</span><br><span> #def=
ine DEV_TYPE_TAP   3    /* ethernet (802.3) tunnel */</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><=
span>index 3f5f450..c6f14c3 100644</span><br><span>--- a/src/openvpn/tun.c<=
/span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -78,6 +78,9 @@</=
span><br><span>         case DRIVER_AFUNIX:</span><br><span>             re=
turn &quot;unix&quot;;</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        case DRIVER_NULL:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return &quot;null&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef HAVE_N=
ET_IF_UTUN_H</span><br><span>         case DRIVER_UTUN:</span><br><span>   =
          return &quot;utun&quot;;</span><br><span>@@ -468,7 +471,9 @@</spa=
n><br><span> int</span><br><span> dev_type_enum(const char *dev, const char=
 *dev_type)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (is_dev_type(dev, dev_type, &quot;tun&quot;))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* We pretend that the null d=
evice is also a tun device but it does not</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * really matter as it will discard evertything =
anyway */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is=
_dev_type(dev, dev_type, &quot;tun&quot;) || is_dev_type(dev, dev_type, &qu=
ot;null&quot;))</span><br><span>     {</span><br><span>         return DEV_=
TYPE_TUN;</span><br><span>     }</span><br><span>@@ -476,10 +481,6 @@</span=
><br><span>     {</span><br><span>         return DEV_TYPE_TAP;</span><br><=
span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else i=
f (is_dev_type(dev, dev_type, &quot;null&quot;))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        return DEV_TYPE_NULL;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span>     else</span><br><span>     {</=
span><br><span>         return DEV_TYPE_UNDEF;</span><br><span>@@ -497,9 +4=
98,6 @@</span><br><span>         case DEV_TYPE_TAP:</span><br><span>       =
      return &quot;tap&quot;;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        case DEV_TYPE_NULL:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return &quot;null&quot;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         de=
fault:</span><br><span>             return &quot;[unknown-dev-type]&quot;;<=
/span><br><span>     }</span><br><span>@@ -773,8 +771,7 @@</span><br><span>=
     bool tun_p2p =3D false;</span><br><span> </span><br><span>     if (tt-=
&gt;type =3D=3D DEV_TYPE_TAP</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        || (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topolo=
gy =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        || tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        || (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&=
amp; tt-&gt;topology =3D=3D TOP_SUBNET))</span><br><span>     {</span><br><=
span>         tun_p2p =3D false;</span><br><span>     }</span><br><span>@@ =
-785,7 +782,6 @@</span><br><span>     else</span><br><span>     {</span><br=
><span>         msg(M_FATAL, &quot;Error: problem with tun vs. tap setting&=
quot;); /* JYFIXME -- needs to be caught earlier, in init_tun? */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     }</span><=
br><span>     return tun_p2p;</span><br><span> }</span><br><span>@@ -1751,7=
 +1747,7 @@</span><br><span> void</span><br><span> undo_ifconfig(struct tun=
tap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type !=3D DEV_TYPE_NULL)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;backend_=
driver !=3D DRIVER_AFUNIX &amp;&amp; tt-&gt;backend_driver !=3D DRIVER_NULL=
)</span><br><span>     {</span><br><span>         if (tt-&gt;did_ifconfig_s=
etup)</span><br><span>         {</span><br><span>@@ -1782,13 +1778,6 @@</sp=
an><br><span> #endif</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-open_null(struct tuntap *tt)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    tt-&gt;actual_name =3D string_alloc(&quot;null&quot;, NULL=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> #if defined (TARGET_OPENBSD) || (defined(T=
ARGET_DARWIN) &amp;&amp; HAVE_NET_IF_UTUN_H)</span><br><span> </span><br><s=
pan> /*</span><br><span>@@ -1904,78 +1893,72 @@</span><br><span>     char d=
ynamic_name[256];</span><br><span>     bool dynamic_opened =3D false;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (t=
t-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * --dev-node specified, so open an explicit device node</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (dev_node)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        open_null(tt);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tunname=
, sizeof(tunname), &quot;%s&quot;, dev_node);</span><br><span>     }</span>=
<br><span>     else</span><br><span>     {</span><br><span>         /*</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-         * --dev-node spec=
ified, so open an explicit device node</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * dynamic open is indicated by --dev specified =
without</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * e=
xplicit unit number.  Try opening /dev/[dev]n</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * where n =3D [0, 255].</span><br><span>=
          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (dev_node)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!tun_name_is_f=
ixed(dev))</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            snprintf(tunname, sizeof(tunname), &quot;%s&quo=
t;, dev_node);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       for (int i =3D 0; i &lt; 256; ++i)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                snprintf(tunname, sizeof(tunname),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                         &qu=
ot;/dev/%s%d&quot;, dev, i);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                snprintf(dynamic_name, sizeof(dynamic_name),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
&quot;%s%d&quot;, dev, i);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                if ((tt-&gt;fd =3D open(tunname, O_RDWR)) &gt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    dyna=
mic_opened =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                msg(D_READ_WRITE | M_ERRNO, &quot;Tried opening %s (f=
ailed)&quot;, tunname);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (!dynamic_opened)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                msg(M_FATAL, &quot;Cannot allocate TUN/TAP dev dynamic=
ally&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span>         }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /*</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * explicit unit number specified</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         */</span><br><span>         else</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
     * dynamic open is indicated by --dev specified without</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-             * explicit unit number. =
 Try opening /dev/[dev]n</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-             * where n =3D [0, 255].</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-             */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (!tun_name_is_fixed(dev))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                for (int i =3D 0; i &lt; 256; ++i)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    snprintf(tunname, sizeof(tu=
nname),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
               &quot;/dev/%s%d&quot;, dev, i);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    snprintf(dynamic_name, sizeof(=
dynamic_name),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                      &quot;%s%d&quot;, dev, i);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    if ((tt-&gt;fd =3D open(tunn=
ame, O_RDWR)) &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        dynamic_opened =3D true;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        break;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    msg(D_READ_WRITE | =
M_ERRNO, &quot;Tried opening %s (failed)&quot;, tunname);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                if (!dynamic_opened)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    msg(M_FATAL,=
 &quot;Cannot allocate TUN/TAP dev dynamically&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            /*</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-             * explicit unit number specified</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-             */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                snprintf(tunname, sizeof(tunname), &quot=
;/dev/%s&quot;, dev);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      snprintf(tunname, sizeof(tunname), &quot;/dev/%s&quot;, dev);</span><=
br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!dynamic_op=
ened)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            /* has named dev=
ice existed before? if so, don&#39;t destroy at end */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (if_nametoindex( dev ) &gt;=
 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_INFO=
, &quot;TUN/TAP device %s exists previously, keep at program end&quot;, dev=
 );</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                tt=
-&gt;persistent_if =3D true;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if ((tt-&g=
t;fd =3D open(tunname, O_RDWR)) &lt; 0)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                msg(M_ERR, &quot;Cannot open TUN/TAP dev %s&quot;=
, tunname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        set_nonblock(tt-&gt;fd);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        set_cloexec(tt-&gt;fd); /* don&#=
39;t pass fd to scripts */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        msg(M_INFO, &quot;TUN/TAP device %s opened&quot;, tunname);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* tt-&gt;actual_name is passed to =
up and down scripts and used as the ifconfig dev name */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;actual_name =3D string_al=
loc(dynamic_opened ? dynamic_name : dev, NULL);</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!dynamic_opened)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* has named device existed before? if so,=
 don&#39;t destroy at end */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (if_nametoindex( dev ) &gt; 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(M_INFO, &quot;TUN/TAP device %s exists=
 previously, keep at program end&quot;, dev );</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            tt-&gt;persistent_if =3D true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if ((tt-&gt;fd =3D open(tunname, O_RDWR)) &lt;=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &qu=
ot;Cannot open TUN/TAP dev %s&quot;, tunname);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_nonblock=
(tt-&gt;fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set=
_cloexec(tt-&gt;fd); /* don&#39;t pass fd to scripts */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;TUN/TAP device %s=
 opened&quot;, tunname);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* tt-&gt;=
actual_name is passed to up and down scripts and used as the ifconfig dev n=
ame */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;ac=
tual_name =3D string_alloc(dynamic_opened ? dynamic_name : dev, NULL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> }</spa=
n><br><span> #endif /* !_WIN32 &amp;&amp; !TARGET_LINUX &amp;&amp; !TARGET_=
FREEBSD*/</span><br><span> </span><br><span>@@ -1987,12 +1970,6 @@</span><b=
r><span>     char dynamic_name[256];</span><br><span>     bool dynamic_open=
ed =3D false;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        open_null(tt);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>     /*</span><br><span>      * unlike &quot;open_tun_generic()=
&quot;, DCO on Linux and FreeBSD follows</span><br><span>      * the device=
 naming model of &quot;non-DCO linux&quot;, that is:</span><br><span>@@ -21=
75,14 +2152,7 @@</span><br><span> {</span><br><span>     struct ifreq ifr;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * We handle --=
dev null specially, we do not open /dev/null for this.</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        open_null(tt);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    else if (tun_dco_enabled(tt))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (tun_dco_enabled(tt))</span><br><span>     {</=
span><br><span>         open_tun_dco_generic(dev, dev_type, tt, ctx);</span=
><br><span>     }</span><br><span>@@ -2407,12 +2377,6 @@</span><br><span>  =
    */</span><br><span>     CLEAR(ifr);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_NUL=
L)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        open_null(tt);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TU=
N)</span><br><span>     {</span><br><span>         ip_node =3D &quot;/dev/u=
dp&quot;;</span><br><span>@@ -3491,12 +3455,6 @@</span><br><span>     char =
dynamic_name[20];</span><br><span>     const char *p;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=
=3D DEV_TYPE_NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        open_null(t=
t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (tt-&gt;type =
=3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         msg(M_=
FATAL, &quot;no support for &#39;tun&#39; devices on AIX&quot; );</span><br=
><span>@@ -6838,12 +6796,7 @@</span><br><span> </span><br><span>     msg( M=
_INFO, &quot;open_tun&quot;);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        open_null(tt);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    else if (tt-&gt;type !=3D DEV_TYPE_TAP &amp;&amp; tt-&gt;typ=
e !=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (tt-&gt;type !=3D DEV_TYPE_TAP &amp;&amp; tt-&gt;type !=3D DEV_TYPE=
_TUN)</span><br><span>     {</span><br><span>         msg(M_FATAL|M_NOPREFI=
X, &quot;Unknown virtual device type: &#39;%s&#39;&quot;, dev);</span><br><=
span>     }</span><br><span>diff --git a/src/openvpn/tun.h b/src/openvpn/tu=
n.h</span><br><span>index 75a4218..5287e0c 100644</span><br><span>--- a/src=
/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</span><br><span>@@ -=
54,6 +54,7 @@</span><br><span>      *  this is always defined. We error out=
 if a user tries to open this type</span><br><span>      *  on unsupported =
platforms*/</span><br><span>     DRIVER_AFUNIX,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    DRIVER_NULL,</span><br><span>     DRIVER_DC=
O,</span><br><span> #ifdef HAVE_NET_IF_UTUN_H</span><br><span>     DRIVER_U=
TUN</span><br><span>@@ -790,4 +791,10 @@</span><br><span> {</span><br><span=
>     return tt &amp;&amp; tt-&gt;type !=3D DEV_TYPE_UNDEF;</span><br><span=
> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+open_tun_null(struct tuntap *tt)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;actual_name =3D string_alloc(&=
quot;null&quot;, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span> #endif /* TUN_H */</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/748?usp=
=3Demail">change 748</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/748?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5987ebb7c38ab176eed7efc004e=
a54f606a77a12 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 748 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--4mxJKwFgRA4=--

