From: Gert Doering <gert@...1296...>
Date: Thu, 28 Nov 2024 11:15:38 +0100
Message-ID: <20241128101538.12810-1-gert@...1296...>
In-Reply-To: <gerrit.1732634928000.I9a278374f492a538f0c174ced1746c3b1f82b8c9@...2715...>
References: <gerrit.1732634928000.I9a278374f492a538f0c174ced1746c3b1f82b8c9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Haiku: Introduce basic platform / tun
 support
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

From: Alexander von Gluck <alex@...2837...>

* Special thanks to Sean Brady's hard work in GSoC 2023 towards creating
  a TUN/TAP driver for Haiku!
* More kudos to Augustin Cavalier for making it functional :-)

Signed-off-by: Alexander von Gluck <alex@...2837...>
Acked-by: Gert Doering <gert@...1296...>
Change-Id: I9a278374f492a538f0c174ced1746c3b1f82b8c9
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/687
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/INSTALL b/INSTALL
index 6007338..9739272 100644
--- a/INSTALL
+++ b/INSTALL
@@ -263,6 +263,16 @@
 
     http://www.whiteboard.ne.jp/~admin2/tuntap/
 
+* Haiku:
+
+   Haiku can't yet dynamically create TUN/TAP devices, so you need to manually
+   create one before running openvpn:
+
+     # ifconfig tun/0 up
+
+   A standard reference the dev as "tun" in your config is all that's needed
+   to use the tunnel device.
+
 * Windows
 
   OpenVPN on Windows needs a TUN/TAP kernel driver to work. OpenVPN installers
diff --git a/configure.ac b/configure.ac
index 0876a6a..7f6e43d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -368,6 +368,11 @@
 		have_tap_header="yes"
 		ac_cv_header_net_if_h="no"	# exists, but breaks things
 		;;
+	*-*-haiku*)
+		AC_DEFINE([TARGET_HAIKU], [1], [Are we running Haiku?])
+		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["H"], [Target prefix])
+		LIBS="${LIBS} -lnetwork"
+		;;
 	*)
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["X"], [Target prefix])
 		have_tap_header="yes"
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 85fe01a..3355508 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1631,6 +1631,15 @@
     {
         windows_set_mtu(tt->adapter_index, AF_INET, tun_mtu);
     }
+#elif defined(TARGET_HAIKU)
+    {
+        /* example: ifconfig tun/0 inet 1.1.1.1 255.255.255.0 mtu 1450 up */
+        argv_printf(&argv, "%s %s inet %s %s mtu %d up", IFCONFIG_PATH,
+            ifname, ifconfig_local, ifconfig_remote_netmask, tun_mtu);
+
+        argv_msg(M_INFO, &argv);
+        openvpn_execve_check(&argv, es, S_FATAL, "Haiku ifconfig failed");
+    }
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif /* if defined(TARGET_LINUX) */
@@ -1909,10 +1918,15 @@
         {
             for (int i = 0; i < 256; ++i)
             {
+                /* some platforms have a dedicated directory per driver */
+                char* sep = "";
+#if defined(TARGET_HAIKU)
+                sep = "/";
+#endif
                 snprintf(tunname, sizeof(tunname),
-                         "/dev/%s%d", dev, i);
+                         "/dev/%s%s%d", dev, sep, i);
                 snprintf(dynamic_name, sizeof(dynamic_name),
-                         "%s%d", dev, i);
+                         "%s%s%d", dev, sep, i);
                 if ((tt->fd = open(tunname, O_RDWR)) > 0)
                 {
                     dynamic_opened = true;

