From: Frans Klaver <fransklaver@...277...>
Date: Thu,  1 Dec 2022 08:50:13 +0100
Message-Id: <20221201075013.30946-1-fransklaver@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH openvpn3-linux] tests: platforminfo: skip
 DBus test if hostname service isn't available
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
To: fransklaver@...277..., openvpn-devel@lists.sourceforge.net

The dbus test is dependent on the org.freedesktop.hostname1 service
being present. If that isn't there, we really can't determine whether or
not the PlatformInfo code does what it's supposed to do.

So try to determine whether or not it makes sense to execute this test
in the first place.

Signed-off-by: Frans Klaver <fransklaver@...277...>
---
 src/tests/unit/platforminfo.cpp | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/tests/unit/platforminfo.cpp b/src/tests/unit/platforminfo.cpp
index 453de63..1460367 100644
--- a/src/tests/unit/platforminfo.cpp
+++ b/src/tests/unit/platforminfo.cpp
@@ -45,6 +45,20 @@ TEST(PlatformInfo, DBus)
     }
 
     PlatformInfo plinfo(dbc.GetConnection());
+
+    try
+    {
+        plinfo.GetStringProperty("OperatingSystemCPEName");
+    }
+    catch (const DBusException& e)
+    {
+        const std::string what{e.what()};
+        if (what.find("was not provided by any") != std::string::npos)
+        {
+            GTEST_SKIP() << "A required service isn't available ## " + what;
+        }
+    }
+
     std::string s{plinfo.str()};
     ASSERT_TRUE(s.find("generic:") == std::string::npos)
         << "PlatformInfo D-Bus call failed";
-- 
2.38.1


