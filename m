From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 19 Dec 2025 14:47:06 +0100
Message-ID: <20251219134706.164040-1-frank@...2641...>
In-Reply-To: <gerrit.1739460301000.I33d1d04b59c62e87ab61d768a7201124ccdabd07@...2715...>
References: <gerrit.1739460301000.I33d1d04b59c62e87ab61d768a7201124ccdabd07@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Fix warnings on Android about unused
 variables/methods
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

Add the things we do not use to the print message to
avoid ifdefs around the otherwise unused variables.

Change-Id: I33d1d04b59c62e87ab61d768a7201124ccdabd07
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/894
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/894
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index ce730f6..11c2d65 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -58,7 +58,7 @@
             -DCMAKE_SYSTEM_NAME=Android -DCMAKE_SYSTEM_VERSION=28 \
             -DCMAKE_ANDROID_ARCH_ABI=${{ matrix.abi }} \
             -DOPENSSL_ROOT_DIR=${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_triplet }} \
-            -DENABLE_PKCS11=false -DBUILD_TESTING=true -DENABLE_LZO=false -DUSE_WERROR=no
+            -DENABLE_PKCS11=false -DBUILD_TESTING=true -DENABLE_LZO=false
       - name: Build OpenVPN Android binary with cmake
         run: cmake --build openvpn-build
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 770300a..222a0fa 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -102,6 +102,7 @@
 #define RTA_SUCCESS 1 /* route addition succeeded */
 #define RTA_EEXIST  2 /* route not added as it already exists */
 
+#ifndef TARGET_ANDROID
 static bool
 add_bypass_address(struct route_bypass *rb, const in_addr_t a)
 {
@@ -123,6 +124,7 @@
         return false;
     }
 }
+#endif
 
 struct route_option_list *
 new_route_option_list(struct gc_arena *a)
@@ -2035,9 +2037,7 @@
 #if !defined(TARGET_AIX)
     const char *netmask;
 #endif
-#if !defined(TARGET_ANDROID)
     const char *gateway;
-#endif
 #else /* if !defined(TARGET_LINUX) */
     int metric;
 #endif
@@ -2056,10 +2056,8 @@
 #if !defined(TARGET_AIX)
     netmask = print_in_addr_t(r->netmask, 0, &gc);
 #endif
-#if !defined(TARGET_ANDROID)
     gateway = print_in_addr_t(r->gateway, 0, &gc);
 #endif
-#endif
 
     is_local_route = local_route(r->network, r->netmask, r->gateway, rgi);
     if (is_local_route == LR_ERROR)
@@ -2165,9 +2163,13 @@
     openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete command failed");
 
 #elif defined(TARGET_ANDROID)
+    /* Avoids the unused variables warnings that all other platforms use
+     * by adding them to the error message. */
     msg(D_ROUTE_DEBUG, "Deleting routes on Android is not possible/not "
                        "needed. The VpnService API allows routes to be set "
-                       "on connect only and will clean up automatically.");
+                       "on connect only and will clean up automatically. "
+                       "Tried to delete route %s netmask %s gateway %s",
+        network, netmask, gateway);
 #elif defined(TARGET_AIX)
 
     {
@@ -2349,7 +2351,10 @@
 #elif defined(TARGET_ANDROID)
     msg(D_ROUTE_DEBUG, "Deleting routes on Android is not possible/not "
                        "needed. The VpnService API allows routes to be set "
-                       "on connect only and will clean up automatically.");
+                       "on connect only and will clean up automatically. "
+                       "Tried to delete %s gateway %s",
+        network,
+        gateway_needed ? gateway : "(not needed)");
 #elif defined(TARGET_HAIKU)
 
     /* ex: route delete /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixlen 64 */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 409cecb..263c965 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1806,7 +1806,7 @@
 #endif
 
 
-#if !(defined(_WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS))
+#if !(defined(_WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS) || defined(TARGET_ANDROID))
 static void
 open_tun_generic(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
 {
@@ -1973,7 +1973,6 @@
          openvpn_net_ctx_t *ctx)
 {
 #define ANDROID_TUNNAME "vpnservice-tun"
-    struct user_pass up;
     struct gc_arena gc = gc_new();
     bool opentun;
 

