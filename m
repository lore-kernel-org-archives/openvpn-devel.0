From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 16 Sep 2024 13:04:06 +0000
References: <gerrit.1726491830000.I5987ebb7c38ab176eed7efc004ea54f606a77a12@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ef9af0c3673c2e2168f9a02def5a6f28915dbaf6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="40mD3uWADoE="; charset=UTF-8
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

--40mD3uWADoE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/748?usp=3Demail

to review the following change.


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
4 files changed, 78 insertions(+), 111 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/748/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 35ee0fc..30ebf28 100644
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
index 3f5f450..8f30c41 100644
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
@@ -476,10 +479,6 @@
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
@@ -497,9 +496,6 @@
         case DEV_TYPE_TAP:
             return "tap";

-        case DEV_TYPE_NULL:
-            return "null";
-
         default:
             return "[unknown-dev-type]";
     }
@@ -773,8 +769,7 @@
     bool tun_p2p =3D false;

     if (tt->type =3D=3D DEV_TYPE_TAP
-        || (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNET)
-        || tt->type =3D=3D DEV_TYPE_NULL)
+        || (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNET=
))
     {
         tun_p2p =3D false;
     }
@@ -1751,7 +1746,7 @@
 void
 undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
-    if (tt->type !=3D DEV_TYPE_NULL)
+    if (tt->backend_driver !=3D DRIVER_AFUNIX && tt->backend_driver !=3D D=
RIVER_NULL)
     {
         if (tt->did_ifconfig_setup)
         {
@@ -1782,13 +1777,6 @@
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
@@ -1904,78 +1892,72 @@
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

@@ -1987,12 +1969,6 @@
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
@@ -2175,14 +2151,7 @@
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
@@ -2407,12 +2376,6 @@
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
@@ -3491,12 +3454,6 @@
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
@@ -6838,12 +6795,7 @@

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--40mD3uWADoE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/748?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Change dev null to be a driver type instead of a special mode=
 of tun/tap<br><br>Change-Id: I5987ebb7c38ab176eed7efc004ea54f606a77a12<br>=
Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn=
/init.c<br>M src/openvpn/proto.h<br>M src/openvpn/tun.c<br>M src/openvpn/tu=
n.h<br>4 files changed, 78 insertions(+), 111 deletions(-)<br><br></pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/748/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 35e=
e0fc..30ebf28 100644</span><br><span>--- a/src/openvpn/init.c</span><br><sp=
an>+++ b/src/openvpn/init.c</span><br><span>@@ -1764,6 +1764,10 @@</span><b=
r><span>         /* Using AF_UNIX trumps using DCO */</span><br><span>     =
    c-&gt;c1.tuntap-&gt;backend_driver =3D DRIVER_AFUNIX;</span><br><span> =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (i=
s_dev_type(c-&gt;options.dev,  c-&gt;options.dev_type, &quot;null&quot;))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c1.tuntap-&gt;backend=
_driver =3D DRIVER_NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span> #ifdef _WIN32</span><br><span>     else</span><=
br><span>     {</span><br><span>@@ -1858,7 +1862,12 @@</span><br><span> ope=
n_tun_backend(struct context *c)</span><br><span> {</span><br><span>     st=
ruct tuntap *tt =3D c-&gt;c1.tuntap;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (tt-&gt;backend_driver =3D=3D DRIVER_NUL=
L)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        open_tun_null(c-&gt;c1.=
tuntap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (tt-&gt;backe=
nd_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>    =
     open_tun_afunix(&amp;c-&gt;options, c-&gt;c2.frame.tun_mtu, tt, c-&gt;=
c2.es);</span><br><span>     }</span><br><span>diff --git a/src/openvpn/pro=
to.h b/src/openvpn/proto.h</span><br><span>index 4b6d6d6..a160fb6 100644</s=
pan><br><span>--- a/src/openvpn/proto.h</span><br><span>+++ b/src/openvpn/p=
roto.h</span><br><span>@@ -33,7 +33,6 @@</span><br><span>  * Tunnel types</=
span><br><span>  */</span><br><span> #define DEV_TYPE_UNDEF 0</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define DEV_TYPE_NULL  1</span><br>=
<span> #define DEV_TYPE_TUN   2    /* point-to-point IP tunnel */</span><br=
><span> #define DEV_TYPE_TAP   3    /* ethernet (802.3) tunnel */</span><br=
><span> </span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c=
</span><br><span>index 3f5f450..8f30c41 100644</span><br><span>--- a/src/op=
envpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -78,=
6 +78,9 @@</span><br><span>         case DRIVER_AFUNIX:</span><br><span>   =
          return &quot;unix&quot;;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case DRIVER_NULL:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return &quot;null&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
#ifdef HAVE_NET_IF_UTUN_H</span><br><span>         case DRIVER_UTUN:</span>=
<br><span>             return &quot;utun&quot;;</span><br><span>@@ -476,10 =
+479,6 @@</span><br><span>     {</span><br><span>         return DEV_TYPE_T=
AP;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    else if (is_dev_type(dev, dev_type, &quot;null&quot;))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return DEV_TYPE_NULL;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     else</span><br=
><span>     {</span><br><span>         return DEV_TYPE_UNDEF;</span><br><sp=
an>@@ -497,9 +496,6 @@</span><br><span>         case DEV_TYPE_TAP:</span><b=
r><span>             return &quot;tap&quot;;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        case DEV_TYPE_NULL:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            return &quot;nul=
l&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan>         default:</span><br><span>             return &quot;[unknown-de=
v-type]&quot;;</span><br><span>     }</span><br><span>@@ -773,8 +769,7 @@</=
span><br><span>     bool tun_p2p =3D false;</span><br><span> </span><br><sp=
an>     if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        || (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp=
; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        || tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        || (tt-&gt;type =3D=3D DEV_=
TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET))</span><br><span>   =
  {</span><br><span>         tun_p2p =3D false;</span><br><span>     }</spa=
n><br><span>@@ -1751,7 +1746,7 @@</span><br><span> void</span><br><span> un=
do_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type !=
=3D DEV_TYPE_NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (tt-&gt;backend_driver !=3D DRIVER_AFUNIX &amp;&amp; tt-&gt;backend_d=
river !=3D DRIVER_NULL)</span><br><span>     {</span><br><span>         if =
(tt-&gt;did_ifconfig_setup)</span><br><span>         {</span><br><span>@@ -=
1782,13 +1777,6 @@</span><br><span> #endif</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-open_null(struct tuntap *tt=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    tt-&gt;actual_name =3D string_alloc(=
&quot;null&quot;, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #if defined (TARGET_=
OPENBSD) || (defined(TARGET_DARWIN) &amp;&amp; HAVE_NET_IF_UTUN_H)</span><b=
r><span> </span><br><span> /*</span><br><span>@@ -1904,78 +1892,72 @@</span=
><br><span>     char dynamic_name[256];</span><br><span>     bool dynamic_o=
pened =3D false;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * --dev-node specified, so open an explicit devi=
ce node</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dev_node)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   open_null(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      snprintf(tunname, sizeof(tunname), &quot;%s&quot;, dev_node);</span><=
br><span>     }</span><br><span>     else</span><br><span>     {</span><br>=
<span>         /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
     * --dev-node specified, so open an explicit device node</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * dynamic open is indicat=
ed by --dev specified without</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         * explicit unit number.  Try opening /dev/[dev]n</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         * where n =3D [0, =
255].</span><br><span>          */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (dev_node)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (!tun_name_is_fixed(dev))</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            snprintf(tunname, sizeof(=
tunname), &quot;%s&quot;, dev_node);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            for (int i =3D 0; i &lt; 256; ++i)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                snprintf(tunname, siz=
eof(tunname),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                   &quot;/dev/%s%d&quot;, dev, i);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                snprintf(dynamic_name, sizeo=
f(dynamic_name),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                      &quot;%s%d&quot;, dev, i);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                if ((tt-&gt;fd =3D open(tunnam=
e, O_RDWR)) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  dynamic_opened =3D true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    break;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(D_READ_WRITE | M_ERRNO, &qu=
ot;Tried opening %s (failed)&quot;, tunname);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (!dynamic_opened)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(M_FATAL, &quot;Cannot alloc=
ate TUN/TAP dev dynamically&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span>         }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * explicit unit number specified</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><sp=
an>         else</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            /*</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-             * dynamic open is indicated by --dev specified =
without</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             *=
 explicit unit number.  Try opening /dev/[dev]n</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-             * where n =3D [0, 255].</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-             */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            if (!tun_name_is_fixed(dev))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                for (int i =3D 0; i &lt; 256; ++i)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    snpri=
ntf(tunname, sizeof(tunname),</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                             &quot;/dev/%s%d&quot;, dev, i);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    snprintf=
(dynamic_name, sizeof(dynamic_name),</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                             &quot;%s%d&quot;, dev, i);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    if ((t=
t-&gt;fd =3D open(tunname, O_RDWR)) &gt; 0)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                        dynamic_opened =3D true;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        br=
eak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   msg(D_READ_WRITE | M_ERRNO, &quot;Tried opening %s (failed)&quot;, tunna=
me);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (!=
dynamic_opened)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          msg(M_FATAL, &quot;Cannot allocate TUN/TAP dev dynamically&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            /*</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-             * explicit unit number spe=
cified</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                snprintf(tunname, =
sizeof(tunname), &quot;/dev/%s&quot;, dev);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            snprintf(tunname, sizeof(tunname), &quot;/dev/%=
s&quot;, dev);</span><br><span>         }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (!dynamic_opened)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      /* has named device existed before? if so, don&#39;t destroy at end *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (if_n=
ametoindex( dev ) &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            msg(M_INFO, &quot;TUN/TAP device %s exists previously, keep at =
program end&quot;, dev );</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                tt-&gt;persistent_if =3D true;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if ((tt-&gt;fd =3D open(tunname, O_RDWR)) &lt; 0)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(M_ERR, &quot;Cannot ope=
n TUN/TAP dev %s&quot;, tunname);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        set_nonblock(tt-&gt;f=
d);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        set_cloexe=
c(tt-&gt;fd); /* don&#39;t pass fd to scripts */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;TUN/TAP device %s open=
ed&quot;, tunname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* tt-&gt;actua=
l_name is passed to up and down scripts and used as the ifconfig dev name *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;actua=
l_name =3D string_alloc(dynamic_opened ? dynamic_name : dev, NULL);</span><=
br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dynamic_opened=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* has named device exis=
ted before? if so, don&#39;t destroy at end */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (if_nametoindex( dev ) &gt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO, &quot;TUN/TA=
P device %s exists previously, keep at program end&quot;, dev );</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            tt-&gt;persistent_=
if =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if ((tt-&gt;fd =3D open(tunn=
ame, O_RDWR)) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_ERR, &quot;Cannot open TUN/TAP dev %s&quot;, tunname);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    set_nonblock(tt-&gt;fd);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    set_cloexec(tt-&gt;fd); /* don&#39;t pass fd to scripts */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot=
;TUN/TAP device %s opened&quot;, tunname);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* tt-&gt;actual_name is passed to up and down scripts and used as =
the ifconfig dev name */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    tt-&gt;actual_name =3D string_alloc(dynamic_opened ? dynamic_name =
: dev, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> }</span><br><span> #endif /* !_WIN32 &amp;&amp; !TARGET_LINUX &=
amp;&amp; !TARGET_FREEBSD*/</span><br><span> </span><br><span>@@ -1987,12 +=
1969,6 @@</span><br><span>     char dynamic_name[256];</span><br><span>    =
 bool dynamic_opened =3D false;</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_NULL)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        open_null(tt);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span>     /*</span><br><span>      * unlike &quot;op=
en_tun_generic()&quot;, DCO on Linux and FreeBSD follows</span><br><span>  =
    * the device naming model of &quot;non-DCO linux&quot;, that is:</span>=
<br><span>@@ -2175,14 +2151,7 @@</span><br><span> {</span><br><span>     st=
ruct ifreq ifr;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * We handle --dev null specially, we do not open /dev/null for this.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_NULL=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        open_null(tt);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else if (tun_dco_enabled(tt))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (tun_dco_enabled(tt))</span><b=
r><span>     {</span><br><span>         open_tun_dco_generic(dev, dev_type,=
 tt, ctx);</span><br><span>     }</span><br><span>@@ -2407,12 +2376,6 @@</s=
pan><br><span>      */</span><br><span>     CLEAR(ifr);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=
=3D DEV_TYPE_NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        open_null(t=
t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (tt-&gt;type =
=3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         ip_nod=
e =3D &quot;/dev/udp&quot;;</span><br><span>@@ -3491,12 +3454,6 @@</span><b=
r><span>     char dynamic_name[20];</span><br><span>     const char *p;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     open_null(tt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if=
 (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span> =
        msg(M_FATAL, &quot;no support for &#39;tun&#39; devices on AIX&quot=
; );</span><br><span>@@ -6838,12 +6795,7 @@</span><br><span> </span><br><sp=
an>     msg( M_INFO, &quot;open_tun&quot;);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE=
_NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        open_null(tt);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    else if (tt-&gt;type !=3D DEV_TYPE_TAP &amp;&amp=
; tt-&gt;type !=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (tt-&gt;type !=3D DEV_TYPE_TAP &amp;&amp; tt-&gt;type !=
=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         msg(M_FAT=
AL|M_NOPREFIX, &quot;Unknown virtual device type: &#39;%s&#39;&quot;, dev);=
</span><br><span>     }</span><br><span>diff --git a/src/openvpn/tun.h b/sr=
c/openvpn/tun.h</span><br><span>index 75a4218..5287e0c 100644</span><br><sp=
an>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</span><b=
r><span>@@ -54,6 +54,7 @@</span><br><span>      *  this is always defined. =
We error out if a user tries to open this type</span><br><span>      *  on =
unsupported platforms*/</span><br><span>     DRIVER_AFUNIX,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    DRIVER_NULL,</span><br><span>  =
   DRIVER_DCO,</span><br><span> #ifdef HAVE_NET_IF_UTUN_H</span><br><span> =
    DRIVER_UTUN</span><br><span>@@ -790,4 +791,10 @@</span><br><span> {</sp=
an><br><span>     return tt &amp;&amp; tt-&gt;type !=3D DEV_TYPE_UNDEF;</sp=
an><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+open_tun_null(struct tun=
tap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;actual_name =3D st=
ring_alloc(&quot;null&quot;, NULL);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span> #endif /* TUN_H */</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/748?usp=3Demail">change 748</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/748?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5987ebb7c38ab176eed7efc004e=
a54f606a77a12 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 748 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--40mD3uWADoE=--

