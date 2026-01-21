From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 21 Jan 2026 13:18:30 +0100
Message-ID: <20260121121830.27244-1-frank@...2641...>
In-Reply-To: <gerrit.1760441635000.I54b11a5540fb236580a3b80c6d1e8678b24bd852@...2715...>
References: <gerrit.1760441635000.I54b11a5540fb236580a3b80c6d1e8678b24bd852@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Silence compiler truncation warning by
 checking snprintf return value
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

On the more recent mingw compilers (homebrew mingw 13.0.0, GCC 15.2.0) the
compiler complains about a potential truncation in these two places.

  src/openvpn/tun.c:3806:57:
  error: '%s' directive output may be truncated writing up
  to 255 bytes into a region of size 178
  [-Werror=format-truncation=]

This not very helpful but checking the snprintf return value
will make the compiler not warn about this.

Change-Id: I54b11a5540fb236580a3b80c6d1e8678b24bd852
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1272
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1272
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 0399b4a..e38df3e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3558,7 +3558,13 @@
             msg(M_FATAL, "Error enumerating registry subkeys of key: %s", ADAPTER_KEY);
         }
 
-        snprintf(unit_string, sizeof(unit_string), "%s\\%s", ADAPTER_KEY, enum_name);
+        int ret = snprintf(unit_string, sizeof(unit_string), "%s\\%s", ADAPTER_KEY, enum_name);
+
+        if (ret < 0 || ret >= sizeof(unit_string))
+        {
+            msg(M_WARN, "Error constructing unit string for %s", enum_name);
+            continue;
+        }
 
         status = RegOpenKeyEx(HKEY_LOCAL_MACHINE, unit_string, 0, KEY_READ, &unit_key);
 
@@ -3667,8 +3673,15 @@
             msg(M_FATAL, "Error enumerating registry subkeys of key: %s", NETWORK_CONNECTIONS_KEY);
         }
 
-        snprintf(connection_string, sizeof(connection_string), "%s\\%s\\Connection",
-                 NETWORK_CONNECTIONS_KEY, enum_name);
+        int ret = snprintf(connection_string, sizeof(connection_string), "%s\\%s\\Connection",
+                           NETWORK_CONNECTIONS_KEY, enum_name);
+
+        if (ret < 0 || ret >= sizeof(connection_string))
+        {
+            msg(M_WARN, "Error constructing connection string for %s", enum_name);
+            continue;
+        }
+
 
         status = RegOpenKeyEx(HKEY_LOCAL_MACHINE, connection_string, 0, KEY_READ, &connection_key);
 

