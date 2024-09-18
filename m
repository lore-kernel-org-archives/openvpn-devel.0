From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Sep 2024 16:10:12 +0000
In-Reply-To: <gerrit.1726491830000.I5987ebb7c38ab176eed7efc004ea54f606a77a12@...2715...>
References: <gerrit.1726491830000.I5987ebb7c38ab176eed7efc004ea54f606a77a12@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d058e771fb5c64a5ee1f8a465ccef7c0bc7b9873-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T3vxXmQUCNU="; charset=UTF-8
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

--T3vxXmQUCNU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/748?usp=3Demail

to look at the new patch set (#8).


Change subject: Change dev null to be a driver type instead of a special mo=
de of tun/tap
......................................................................

Change dev null to be a driver type instead of a special mode of tun/tap

Change-Id: I5987ebb7c38ab176eed7efc004ea54f606a77a12
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/dco.c
M src/openvpn/init.c
M src/openvpn/proto.h
M src/openvpn/tun.c
M src/openvpn/tun.h
5 files changed, 93 insertions(+), 113 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/748/8

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index ecef455..2f33973 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -306,6 +306,13 @@
         return false;
     }

+    if (is_dev_type(o->dev,  o->dev_type, "null"))
+    {
+        msg(msglevel, "Note: null tun type selected, disabling data channe=
l"
+            "offload");
+        return false;
+    }
+
     if (o->connection_list)
     {
         const struct connection_list *l =3D o->connection_list;
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
index b305b64..2bea70d 100644
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
+     * really matter as it will discard evertything anyway */
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
index 8e6c627..8d88b4c 100644
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
@@ -788,4 +789,10 @@
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
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--T3vxXmQUCNU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #8</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/748?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Change dev null to be a driver type instead of a special mode of tun/=
tap<br><br>Change-Id: I5987ebb7c38ab176eed7efc004ea54f606a77a12<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/dco.c<b=
r>M src/openvpn/init.c<br>M src/openvpn/proto.h<br>M src/openvpn/tun.c<br>M=
 src/openvpn/tun.h<br>5 files changed, 93 insertions(+), 113 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/74=
8/8</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><s=
pan>index ecef455..2f33973 100644</span><br><span>--- a/src/openvpn/dco.c</=
span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -306,6 +306,13 @@=
</span><br><span>         return false;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_dev=
_type(o-&gt;dev,  o-&gt;dev_type, &quot;null&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(msglevel, &quot;Note: null tun type selecte=
d, disabling data channel&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &quot;offload&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     if (o-&gt;connection_list)</span><br><s=
pan>     {</span><br><span>         const struct connection_list *l =3D o-&=
gt;connection_list;</span><br><span>diff --git a/src/openvpn/init.c b/src/o=
penvpn/init.c</span><br><span>index b516608..378dd48 100644</span><br><span=
>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><b=
r><span>@@ -1764,6 +1764,10 @@</span><br><span>         /* Using AF_UNIX tr=
umps using DCO */</span><br><span>         c-&gt;c1.tuntap-&gt;backend_driv=
er =3D DRIVER_AFUNIX;</span><br><span>     }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else if (is_dev_type(c-&gt;options.dev,  c-&gt=
;options.dev_type, &quot;null&quot;))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        c-&gt;c1.tuntap-&gt;backend_driver =3D DRIVER_NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #ifdef _=
WIN32</span><br><span>     else</span><br><span>     {</span><br><span>@@ -=
1858,7 +1862,12 @@</span><br><span> open_tun_backend(struct context *c)</sp=
an><br><span> {</span><br><span>     struct tuntap *tt =3D c-&gt;c1.tuntap;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;backen=
d_driver =3D=3D DRIVER_AFUNIX)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
tt-&gt;backend_driver =3D=3D DRIVER_NULL)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        open_tun_null(c-&gt;c1.tuntap);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</spa=
n><br><span>     {</span><br><span>         open_tun_afunix(&amp;c-&gt;opti=
ons, c-&gt;c2.frame.tun_mtu, tt, c-&gt;c2.es);</span><br><span>     }</span=
><br><span>@@ -2059,6 +2068,11 @@</span><br><span>         {</span><br><spa=
n>             tun_afunix_close(c-&gt;c1.tuntap);</span><br><span>         =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (c=
-&gt;c1.tuntap-&gt;backend_driver =3D=3D DRIVER_NULL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            free(c-&gt;c1.tuntap-&gt;actual_name);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            free(c-&=
gt;c1.tuntap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span>         else</span><br><span>         {</span><br><sp=
an>             close_tun(c-&gt;c1.tuntap, &amp;c-&gt;net_ctx);</span><br><=
span>diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h</span><br><span=
>index 4b6d6d6..a160fb6 100644</span><br><span>--- a/src/openvpn/proto.h</s=
pan><br><span>+++ b/src/openvpn/proto.h</span><br><span>@@ -33,7 +33,6 @@</=
span><br><span>  * Tunnel types</span><br><span>  */</span><br><span> #defi=
ne DEV_TYPE_UNDEF 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine DEV_TYPE_NULL  1</span><br><span> #define DEV_TYPE_TUN   2    /* poin=
t-to-point IP tunnel */</span><br><span> #define DEV_TYPE_TAP   3    /* eth=
ernet (802.3) tunnel */</span><br><span> </span><br><span>diff --git a/src/=
openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index b305b64..2bea70d 10=
0644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/open=
vpn/tun.c</span><br><span>@@ -75,6 +75,9 @@</span><br><span>         case D=
RIVER_AFUNIX:</span><br><span>             return &quot;unix&quot;;</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
ase DRIVER_NULL:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return &quot;null&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>         case DRIVER_UTUN:</span><br><span> =
            return &quot;utun&quot;;</span><br><span> </span><br><span>@@ -=
463,7 +466,9 @@</span><br><span> int</span><br><span> dev_type_enum(const c=
har *dev, const char *dev_type)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (is_dev_type(dev, dev_type, &quot;tun&q=
uot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We pre=
tend that the null device is also a tun device but it does not</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * really matter as it will =
discard evertything anyway */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (is_dev_type(dev, dev_type, &quot;tun&quot;) || is_dev_typ=
e(dev, dev_type, &quot;null&quot;))</span><br><span>     {</span><br><span>=
         return DEV_TYPE_TUN;</span><br><span>     }</span><br><span>@@ -47=
1,10 +476,6 @@</span><br><span>     {</span><br><span>         return DEV_T=
YPE_TAP;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    else if (is_dev_type(dev, dev_type, &quot;null&quot;))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return DEV_TYPE_NULL;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     else</sp=
an><br><span>     {</span><br><span>         return DEV_TYPE_UNDEF;</span><=
br><span>@@ -492,9 +493,6 @@</span><br><span>         case DEV_TYPE_TAP:</s=
pan><br><span>             return &quot;tap&quot;;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        case DEV_TYPE_NULL:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return &qu=
ot;null&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span>         default:</span><br><span>             return &quot;[unkn=
own-dev-type]&quot;;</span><br><span>     }</span><br><span>@@ -768,8 +766,=
7 @@</span><br><span>     bool tun_p2p =3D false;</span><br><span> </span><=
br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        || (tt-&gt;type =3D=3D DEV_TYPE_TUN &am=
p;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        || tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        || (tt-&gt;type =3D=
=3D DEV_TYPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET))</span><br><=
span>     {</span><br><span>         tun_p2p =3D false;</span><br><span>   =
  }</span><br><span>@@ -780,7 +777,6 @@</span><br><span>     else</span><br=
><span>     {</span><br><span>         msg(M_FATAL, &quot;Error: problem wi=
th tun vs. tap setting&quot;); /* JYFIXME -- needs to be caught earlier, in=
 init_tun? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     }</span><br><span>     return tun_p2p;</span><br><span> }</sp=
an><br><span>@@ -1748,7 +1744,7 @@</span><br><span> void</span><br><span> u=
ndo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type !=
=3D DEV_TYPE_NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (tt-&gt;backend_driver !=3D DRIVER_NULL)</span><br><span>     {</span=
><br><span>         if (tt-&gt;did_ifconfig_setup)</span><br><span>        =
 {</span><br><span>@@ -1779,13 +1775,6 @@</span><br><span> #endif</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-open=
_null(struct tuntap *tt)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tt-&gt;actual=
_name =3D string_alloc(&quot;null&quot;, NULL);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> #if defined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) &amp;&amp; HAVE_=
NET_IF_UTUN_H)</span><br><span> </span><br><span> /*</span><br><span>@@ -19=
01,78 +1890,72 @@</span><br><span>     char dynamic_name[256];</span><br><s=
pan>     bool dynamic_opened =3D false;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_NUL=
L)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * --dev-node specified, s=
o open an explicit device node</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (dev_node)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        open_null(tt);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        snprintf(tunname, sizeof(tunname), &quot;%s&qu=
ot;, dev_node);</span><br><span>     }</span><br><span>     else</span><br>=
<span>     {</span><br><span>         /*</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-         * --dev-node specified, so open an explicit dev=
ice node</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
dynamic open is indicated by --dev specified without</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * explicit unit number.  Try ope=
ning /dev/[dev]n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * where n =3D [0, 255].</span><br><span>          */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (dev_node)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!tun_name_is_fixed(dev))</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            s=
nprintf(tunname, sizeof(tunname), &quot;%s&quot;, dev_node);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            for (int i =3D 0; i &l=
t; 256; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   snprintf(tunname, sizeof(tunname),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                         &quot;/dev/%s%d&quot;, dev, i);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                snpr=
intf(dynamic_name, sizeof(dynamic_name),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                         &quot;%s%d&quot;, dev, i);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                if ((t=
t-&gt;fd =3D open(tunname, O_RDWR)) &gt; 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    dynamic_opened =3D true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    break;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_R=
EAD_WRITE | M_ERRNO, &quot;Tried opening %s (failed)&quot;, tunname);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (!dynamic_opened=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_FA=
TAL, &quot;Cannot allocate TUN/TAP dev dynamically&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>      =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         * explicit unit=
 number specified</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       */</span><br><span>         else</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            /*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-             * dynamic open is indica=
ted by --dev specified without</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-             * explicit unit number.  Try opening /dev/[dev]n</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-             * where n =3D=
 [0, 255].</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (!tun_name_is_fixed(dev=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                for (int i =
=3D 0; i &lt; 256; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  snprintf(tunname, sizeof(tunname),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                             &quot;/dev/%s%=
d&quot;, dev, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                snprintf(dynamic_name, sizeof(dynamic_name),</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                             &quot;%=
s%d&quot;, dev, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  if ((tt-&gt;fd =3D open(tunname, O_RDWR)) &gt; 0)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        dynam=
ic_opened =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                      break;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    msg(D_READ_WRITE | M_ERRNO, &quot;Tried opening =
%s (failed)&quot;, tunname);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                if (!dynamic_opened)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    msg(M_FATAL, &quot;Cannot allocate TUN/TA=
P dev dynamically&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * =
explicit unit number specified</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-             */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      snprintf(tunname, sizeof(tunname), &quot;/dev/%s&quot;, dev);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            snprintf(tunname, sizeo=
f(tunname), &quot;/dev/%s&quot;, dev);</span><br><span>         }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (!dynamic_opened)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            /* has named device existed before? if so, =
don&#39;t destroy at end */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (if_nametoindex( dev ) &gt; 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                msg(M_INFO, &quot;TUN/TAP device %s=
 exists previously, keep at program end&quot;, dev );</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                tt-&gt;persistent_if =3D tr=
ue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            if ((tt-&gt;fd =3D open(tunname, O_=
RDWR)) &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 msg(M_ERR, &quot;Cannot open TUN/TAP dev %s&quot;, tunname);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       set_nonblock(tt-&gt;fd);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        set_cloexec(tt-&gt;fd); /* don&#39;t pass fd to scripts *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, =
&quot;TUN/TAP device %s opened&quot;, tunname);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        /* tt-&gt;actual_name is passed to up and down scripts and use=
d as the ifconfig dev name */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        tt-&gt;actual_name =3D string_alloc(dynamic_opened ? dynami=
c_name : dev, NULL);</span><br><span>     }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!dynamic_opened)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* has named device existed before? if so, don&#39;t destroy at end */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (if_namet=
oindex( dev ) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_INFO, &quot;TUN/TAP device %s exists previously, keep at program =
end&quot;, dev );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          tt-&gt;persistent_if =3D true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if ((tt-&gt;fd =3D open(tunname, O_RDWR)) &lt; 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(M_ERR, &quot;Cannot open TUN/TAP dev %s=
&quot;, tunname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    set_nonblock(tt-&gt;fd);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    set_cloexec(tt-&gt;fd); /* don&#=
39;t pass fd to scripts */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    msg(M_INFO, &quot;TUN/TAP device %s opened&quot;, tunname);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* tt-&gt;actual_name is passed to up=
 and down scripts and used as the ifconfig dev name */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;actual_name =3D string_alloc(=
dynamic_opened ? dynamic_name : dev, NULL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> }</span><br><span> #endif /* !_WI=
N32 &amp;&amp; !TARGET_LINUX &amp;&amp; !TARGET_FREEBSD*/</span><br><span> =
</span><br><span>@@ -1984,12 +1967,6 @@</span><br><span>     char dynamic_n=
ame[256];</span><br><span>     bool dynamic_opened =3D false;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;ty=
pe =3D=3D DEV_TYPE_NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        open_=
null(tt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*</span><br=
><span>      * unlike &quot;open_tun_generic()&quot;, DCO on Linux and Free=
BSD follows</span><br><span>      * the device naming model of &quot;non-DC=
O linux&quot;, that is:</span><br><span>@@ -2172,14 +2149,7 @@</span><br><s=
pan> {</span><br><span>     struct ifreq ifr;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * We handle --dev null specially, we do not=
 open /dev/null for this.</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt=
-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  open_null(tt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (tun_dco_=
enabled(tt))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(tun_dco_enabled(tt))</span><br><span>     {</span><br><span>         open_=
tun_dco_generic(dev, dev_type, tt, ctx);</span><br><span>     }</span><br><=
span>@@ -2404,12 +2374,6 @@</span><br><span>      */</span><br><span>     C=
LEAR(ifr);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        open_null(tt);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</sp=
an><br><span>         ip_node =3D &quot;/dev/udp&quot;;</span><br><span>@@ =
-3488,12 +3452,6 @@</span><br><span>     char dynamic_name[20];</span><br><=
span>     const char *p;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        open_null(tt);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><s=
pan>     {</span><br><span>         msg(M_FATAL, &quot;no support for &#39;=
tun&#39; devices on AIX&quot; );</span><br><span>@@ -6835,12 +6793,7 @@</sp=
an><br><span> </span><br><span>     msg( M_INFO, &quot;open_tun&quot;);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(tt-&gt;type =3D=3D DEV_TYPE_NULL)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     open_null(tt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (tt-&gt;type=
 !=3D DEV_TYPE_TAP &amp;&amp; tt-&gt;type !=3D DEV_TYPE_TUN)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;type !=3D DEV_TYPE_=
TAP &amp;&amp; tt-&gt;type !=3D DEV_TYPE_TUN)</span><br><span>     {</span>=
<br><span>         msg(M_FATAL|M_NOPREFIX, &quot;Unknown virtual device typ=
e: &#39;%s&#39;&quot;, dev);</span><br><span>     }</span><br><span>diff --=
git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index 8e6c627..=
8d88b4c 100644</span><br><span>--- a/src/openvpn/tun.h</span><br><span>+++ =
b/src/openvpn/tun.h</span><br><span>@@ -51,6 +51,7 @@</span><br><span>     =
 *  This is always defined. We error out if a user tries to open this type<=
/span><br><span>      *  of backend on unsupported platforms. */</span><br>=
<span>     DRIVER_AFUNIX,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    DRIVER_NULL,</span><br><span>     DRIVER_DCO,</span><br><span>   =
  /** macOS internal tun driver */</span><br><span>     DRIVER_UTUN</span><=
br><span>@@ -788,4 +789,10 @@</span><br><span> {</span><br><span>     retur=
n tt &amp;&amp; tt-&gt;type !=3D DEV_TYPE_UNDEF;</span><br><span> }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static inline void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+open_tun_null(struct tuntap *tt)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    tt-&gt;actual_name =3D string_alloc(&quot;null&q=
uot;, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span> #endif /* TUN_H */</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/748?usp=3Demail">ch=
ange 748</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/748?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5987ebb7c38ab176eed7efc004e=
a54f606a77a12 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 748 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--T3vxXmQUCNU=--

