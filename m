Message-ID: <84a29b8afab02733064c2cf715ae0b8c.squirrel@...2257...>
Date: Wed, 22 Nov 2017 17:58:22 +0100
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20171122175822_97632"
Subject: [Openvpn-devel] Add --up-pre with the same functionality as
 --down-pre
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

------=_20171122175822_97632
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

In our situation we have the requirement to run scripts before tun/tap is
opened, not after. While this could be hacked into the init script, the
proper way seems to add it to openvpn as --up-pre option. That's
independent from any init scripts / systemd service file and works the
same way as --down-pre, only for the up status.

My initial feature wish, posted 5 years ago, was turned down as won't fix:
https://community.openvpn.net/openvpn/ticket/284

But there are people who wish it and they have good reasons to wish it.
Just yesterday someone asked again:
https://community.openvpn.net/openvpn/ticket/284#comment:10

Without going into much details just one thing why --up + --up-pre is
better than hacking around outside of openvpn: the command called with
--up also gets additional run time information from openvpn by parameters
and environmental variables. You don't get all those information when
calling anything from outside of openvpn before openvpn actually starts.

If you feel there are good reasons to still refuse this patch, please let
me know.

Regards,
Simon
------=_20171122175822_97632
Content-Type: text/x-patch; name="openvpn-2.4.0-up-pre.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="openvpn-2.4.0-up-pre.patch"

diff -Naur openvpn-2.4.0.orig/doc/openvpn.8 openvpn-2.4.0/doc/openvpn.8
--- openvpn-2.4.0.orig/doc/openvpn.8	2016-12-26 14:01:34.000000000 +0100
+++ openvpn-2.4.0/doc/openvpn.8	2016-12-30 11:45:16.000000000 +0100
@@ -1845,6 +1845,12 @@
 .B route add \-net 10.0.0.0 netmask 255.255.255.0 gw $5
 .\"*********************************************************
 .TP
+.B \-\-up\-pre
+Call
+.B \-\-up
+cmd/script before, rather than after, TUN/TAP open.
+.\"*********************************************************
+.TP
 .B \-\-up\-delay
 Delay TUN/TAP open and possible
 .B \-\-up
diff -Naur openvpn-2.4.0.orig/src/openvpn/init.c openvpn-2.4.0/src/openvpn/init.c
--- openvpn-2.4.0.orig/src/openvpn/init.c	2016-12-26 12:51:00.000000000 +0100
+++ openvpn-2.4.0/src/openvpn/init.c	2016-12-30 12:05:15.000000000 +0100
@@ -1573,6 +1573,27 @@
     }
 #endif
 
+    /* actually run the up script based on --up-pre flag */
+    if (c->options.up_pre)
+    {
+        run_up_down (c->options.up_script,
+                     c->plugins,
+                     OPENVPN_PLUGIN_UP,
+                     "[unknown-dev]",
+#ifdef _WIN32
+                     TUN_ADAPTER_INDEX_INVALID,
+#endif
+                     dev_type_string (c->options.dev, c->options.dev_type),
+                     TUN_MTU_SIZE (&c->c2.frame),
+                     EXPANDED_SIZE (&c->c2.frame),
+                     NULL,
+                     NULL,
+                     "init",
+                     NULL,
+                     "up",
+                     c->c2.es);
+    }
+
     /* initialize (but do not open) tun/tap object */
     do_init_tun(c);
 
@@ -1639,23 +1660,26 @@
         do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name, TUN_MTU_SIZE(&c->c2.frame), c->c2.es);
     }
 
-    /* run the up script */
-    run_up_down(c->options.up_script,
-                c->plugins,
-                OPENVPN_PLUGIN_UP,
-                c->c1.tuntap->actual_name,
+    /* actually run the up script based on --up-pre flag */
+    if (!c->options.up_pre)
+    {
+        run_up_down(c->options.up_script,
+                    c->plugins,
+                    OPENVPN_PLUGIN_UP,
+                    c->c1.tuntap->actual_name,
 #ifdef _WIN32
-                c->c1.tuntap->adapter_index,
+                    c->c1.tuntap->adapter_index,
 #endif
-                dev_type_string(c->options.dev, c->options.dev_type),
-                TUN_MTU_SIZE(&c->c2.frame),
-                EXPANDED_SIZE(&c->c2.frame),
-                print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
-                print_in_addr_t(c->c1.tuntap->remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
-                "init",
-                NULL,
-                "up",
-                c->c2.es);
+                    dev_type_string(c->options.dev, c->options.dev_type),
+                    TUN_MTU_SIZE(&c->c2.frame),
+                    EXPANDED_SIZE(&c->c2.frame),
+                    print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
+                    print_in_addr_t(c->c1.tuntap->remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
+                    "init",
+                    NULL,
+                    "up",
+                    c->c2.es);
+    }
 
 #if defined(_WIN32)
     if (c->options.block_outside_dns)
diff -Naur openvpn-2.4.0.orig/src/openvpn/options.c openvpn-2.4.0/src/openvpn/options.c
--- openvpn-2.4.0.orig/src/openvpn/options.c	2016-12-26 12:51:00.000000000 +0100
+++ openvpn-2.4.0/src/openvpn/options.c	2016-12-30 12:09:19.000000000 +0100
@@ -301,6 +301,7 @@
     "                  Execute as: cmd tun/tap-dev tun-mtu link-mtu \\\n"
     "                              ifconfig-local-ip ifconfig-remote-ip\n"
     "                  (pre --user or --group UID/GID change)\n"
+    "--up-pre        : Run --up command before TUN/TAP open.\n"
     "--up-delay      : Delay tun/tap open and possible --up script execution\n"
     "                  until after TCP/UDP connection establishment with peer.\n"
     "--down cmd      : Run command cmd after tun device close.\n"
@@ -1623,6 +1624,7 @@
     SHOW_STR(up_script);
     SHOW_STR(down_script);
     SHOW_BOOL(down_pre);
+    SHOW_BOOL(up_pre);
     SHOW_BOOL(up_restart);
     SHOW_BOOL(up_delay);
     SHOW_BOOL(daemon);
@@ -5530,6 +5532,11 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->down_pre = true;
     }
+    else if (streq(p[0], "up-pre") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->up_pre = true;
+    }
     else if (streq(p[0], "up-delay") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff -Naur openvpn-2.4.0.orig/src/openvpn/options.h openvpn-2.4.0/src/openvpn/options.h
--- openvpn-2.4.0.orig/src/openvpn/options.h	2016-12-26 12:51:00.000000000 +0100
+++ openvpn-2.4.0/src/openvpn/options.h	2016-12-30 12:09:47.000000000 +0100
@@ -285,6 +285,7 @@
     const char *down_script;
     bool user_script_used;
     bool down_pre;
+    bool up_pre;
     bool up_delay;
     bool up_restart;
     bool daemon;
------=_20171122175822_97632--



