From: Gert Doering <gert@...1296...>
Date: Tue, 24 Sep 2024 14:43:28 +0200
Message-ID: <20240924124328.3037-1-gert@...1296...>
In-Reply-To: <gerrit.1726491830000.I5987ebb7c38ab176eed7efc004ea54f606a77a12@...2715...>
References: <gerrit.1726491830000.I5987ebb7c38ab176eed7efc004ea54f606a77a12@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v11] Change dev null to be a driver type
 instead of a special mode of tun/tap
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Arne Schwabe <arne@...1227...>

Change-Id: I5987ebb7c38ab176eed7efc004ea54f606a77a12
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/748
This mail reflects revision 11 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index ecef455..7864db3 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -306,6 +306,13 @@
         return false;
     }
 
+    if (is_dev_type(o->dev,  o->dev_type, "null"))
+    {
+        msg(msglevel, "Note: null tun type selected, disabling data channel "
+            "offload");
+        return false;
+    }
+
     if (o->connection_list)
     {
         const struct connection_list *l = o->connection_list;
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1a14e19..fbf2c5b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1764,6 +1764,10 @@
         /* Using AF_UNIX trumps using DCO */
         c->c1.tuntap->backend_driver = DRIVER_AFUNIX;
     }
+    else if (is_dev_type(c->options.dev,  c->options.dev_type, "null"))
+    {
+        c->c1.tuntap->backend_driver = DRIVER_NULL;
+    }
 #ifdef _WIN32
     else
     {
@@ -1858,7 +1862,12 @@
 open_tun_backend(struct context *c)
 {
     struct tuntap *tt = c->c1.tuntap;
-    if (tt->backend_driver == DRIVER_AFUNIX)
+
+    if (tt->backend_driver == DRIVER_NULL)
+    {
+        open_tun_null(c->c1.tuntap);
+    }
+    else if (tt->backend_driver == DRIVER_AFUNIX)
     {
         open_tun_afunix(&c->options, c->c2.frame.tun_mtu, tt, c->c2.es);
     }
@@ -2059,6 +2068,11 @@
         {
             close_tun_afunix(c->c1.tuntap);
         }
+        else if (c->c1.tuntap->backend_driver == DRIVER_NULL)
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
+    if (is_dev_type(dev, dev_type, "tun") || is_dev_type(dev, dev_type, "null"))
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
     bool tun_p2p = false;
 
     if (tt->type == DEV_TYPE_TAP
-        || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
-        || tt->type == DEV_TYPE_NULL)
+        || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET))
     {
         tun_p2p = false;
     }
@@ -780,7 +777,6 @@
     else
     {
         msg(M_FATAL, "Error: problem with tun vs. tap setting"); /* JYFIXME -- needs to be caught earlier, in init_tun? */
-
     }
     return tun_p2p;
 }
@@ -1748,7 +1744,7 @@
 void
 undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
-    if (tt->type != DEV_TYPE_NULL)
+    if (tt->backend_driver != DRIVER_NULL)
     {
         if (tt->did_ifconfig_setup)
         {
@@ -1779,13 +1775,6 @@
 #endif
 }
 
-static void
-open_null(struct tuntap *tt)
-{
-    tt->actual_name = string_alloc("null", NULL);
-}
-
-
 #if defined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) && HAVE_NET_IF_UTUN_H)
 
 /*
@@ -1901,78 +1890,72 @@
     char dynamic_name[256];
     bool dynamic_opened = false;
 
-    if (tt->type == DEV_TYPE_NULL)
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
+         * where n = [0, 255].
          */
-        if (dev_node)
+
+        if (!tun_name_is_fixed(dev))
         {
-            snprintf(tunname, sizeof(tunname), "%s", dev_node);
+            for (int i = 0; i < 256; ++i)
+            {
+                snprintf(tunname, sizeof(tunname),
+                         "/dev/%s%d", dev, i);
+                snprintf(dynamic_name, sizeof(dynamic_name),
+                         "%s%d", dev, i);
+                if ((tt->fd = open(tunname, O_RDWR)) > 0)
+                {
+                    dynamic_opened = true;
+                    break;
+                }
+                msg(D_READ_WRITE | M_ERRNO, "Tried opening %s (failed)", tunname);
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
-             * where n = [0, 255].
-             */
-
-            if (!tun_name_is_fixed(dev))
-            {
-                for (int i = 0; i < 256; ++i)
-                {
-                    snprintf(tunname, sizeof(tunname),
-                             "/dev/%s%d", dev, i);
-                    snprintf(dynamic_name, sizeof(dynamic_name),
-                             "%s%d", dev, i);
-                    if ((tt->fd = open(tunname, O_RDWR)) > 0)
-                    {
-                        dynamic_opened = true;
-                        break;
-                    }
-                    msg(D_READ_WRITE | M_ERRNO, "Tried opening %s (failed)", tunname);
-                }
-                if (!dynamic_opened)
-                {
-                    msg(M_FATAL, "Cannot allocate TUN/TAP dev dynamically");
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
-            /* has named device existed before? if so, don't destroy at end */
-            if (if_nametoindex( dev ) > 0)
-            {
-                msg(M_INFO, "TUN/TAP device %s exists previously, keep at program end", dev );
-                tt->persistent_if = true;
-            }
-
-            if ((tt->fd = open(tunname, O_RDWR)) < 0)
-            {
-                msg(M_ERR, "Cannot open TUN/TAP dev %s", tunname);
-            }
-        }
-
-        set_nonblock(tt->fd);
-        set_cloexec(tt->fd); /* don't pass fd to scripts */
-        msg(M_INFO, "TUN/TAP device %s opened", tunname);
-
-        /* tt->actual_name is passed to up and down scripts and used as the ifconfig dev name */
-        tt->actual_name = string_alloc(dynamic_opened ? dynamic_name : dev, NULL);
     }
+
+    if (!dynamic_opened)
+    {
+        /* has named device existed before? if so, don't destroy at end */
+        if (if_nametoindex( dev ) > 0)
+        {
+            msg(M_INFO, "TUN/TAP device %s exists previously, keep at program end", dev );
+            tt->persistent_if = true;
+        }
+
+        if ((tt->fd = open(tunname, O_RDWR)) < 0)
+        {
+            msg(M_ERR, "Cannot open TUN/TAP dev %s", tunname);
+        }
+    }
+
+    set_nonblock(tt->fd);
+    set_cloexec(tt->fd); /* don't pass fd to scripts */
+    msg(M_INFO, "TUN/TAP device %s opened", tunname);
+
+    /* tt->actual_name is passed to up and down scripts and used as the ifconfig dev name */
+    tt->actual_name = string_alloc(dynamic_opened ? dynamic_name : dev, NULL);
+
 }
 #endif /* !_WIN32 && !TARGET_LINUX && !TARGET_FREEBSD*/
 
@@ -1984,12 +1967,6 @@
     char dynamic_name[256];
     bool dynamic_opened = false;
 
-    if (tt->type == DEV_TYPE_NULL)
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
-    if (tt->type == DEV_TYPE_NULL)
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
 
-    if (tt->type == DEV_TYPE_NULL)
-    {
-        open_null(tt);
-        return;
-    }
-
     if (tt->type == DEV_TYPE_TUN)
     {
         ip_node = "/dev/udp";
@@ -3488,12 +3452,6 @@
     char dynamic_name[20];
     const char *p;
 
-    if (tt->type == DEV_TYPE_NULL)
-    {
-        open_null(tt);
-        return;
-    }
-
     if (tt->type == DEV_TYPE_TUN)
     {
         msg(M_FATAL, "no support for 'tun' devices on AIX" );
@@ -6835,12 +6793,7 @@
 
     msg( M_INFO, "open_tun");
 
-    if (tt->type == DEV_TYPE_NULL)
-    {
-        open_null(tt);
-        return;
-    }
-    else if (tt->type != DEV_TYPE_TAP && tt->type != DEV_TYPE_TUN)
+    if (tt->type != DEV_TYPE_TAP && tt->type != DEV_TYPE_TUN)
     {
         msg(M_FATAL|M_NOPREFIX, "Unknown virtual device type: '%s'", dev);
     }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index a38aef0..b2c1b01 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -51,6 +51,7 @@
      *  This is always defined. We error out if a user tries to open this type
      *  of backend on unsupported platforms. */
     DRIVER_AFUNIX,
+    DRIVER_NULL,
     DRIVER_DCO,
     /** macOS internal tun driver */
     DRIVER_UTUN
@@ -784,4 +785,10 @@
 {
     return tt && tt->type != DEV_TYPE_UNDEF;
 }
+
+static inline void
+open_tun_null(struct tuntap *tt)
+{
+    tt->actual_name = string_alloc("null", NULL);
+}
 #endif /* TUN_H */

