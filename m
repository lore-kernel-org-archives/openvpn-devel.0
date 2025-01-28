From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 28 Jan 2025 13:40:26 +0100
Message-Id: <20250128124026.108992-1-frank@...2641...>
In-Reply-To: <gerrit.1738029022000.I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d@...2715...>
References: <gerrit.1738029022000.I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Haiku: Fix short interface path length
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

* Haiku uses full paths for interface names, 16 characters
  isn't enough.

Change-Id: I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d
Signed-off-by: Alexander von Gluck <alex@...2837...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/689
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 421e7d2..69b06b8 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -155,6 +155,8 @@
     /* gateway interface */
 #ifdef _WIN32
     DWORD adapter_index; /* interface or ~0 if undefined */
+#elif defined(TARGET_HAIKU)
+    char iface[PATH_MAX]; /* iface names are full /dev path with driver name */
 #else
     char iface[16]; /* interface name (null terminated), may be empty */
 #endif
@@ -186,8 +188,13 @@
 #else
     /* non linux platform don't have this constant defined */
 #ifndef IFNAMSIZ
+#if defined(TARGET_HAIKU)
+/* iface names are full /dev path with driver name */
+#define IFNAMSIZ PATH_MAX
+#else
 #define IFNAMSIZ 16
 #endif
+#endif
     char iface[IFNAMSIZ]; /* interface name (null terminated), may be empty */
 #endif
 

