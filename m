From: Alexey Slokva <Alesha72003@...1780...>
Date: Fri,  3 Apr 2026 01:09:49 +0300
Message-ID: <20260402221251.16811-2-Alesha72003@...1780...>
In-Reply-To: <20260402221251.16811-1-Alesha72003@...1780...>
References: <20260402221251.16811-1-Alesha72003@...1780...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] netcfg-dco: fix ignoring return value of
 ParseFromString key_config
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

Recent protobuf versions mark ParseFromString() as [[nodiscard]], which makes ignoring its return value fail the build with stricter warning settings.

Check the return value when decoding key_config and raise NetCfgException if parsing fails.

Signed-off-by: Alexey Slokva <Alesha72003@...1780...>
---
 src/netcfg/netcfg-dco.cpp | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/netcfg/netcfg-dco.cpp b/src/netcfg/netcfg-dco.cpp
index 290c12a8..c39c741f 100644
--- a/src/netcfg/netcfg-dco.cpp
+++ b/src/netcfg/netcfg-dco.cpp
@@ -265,7 +265,10 @@ void NetCfgDCO::method_new_key(GVariant *params)
     std::string key_config = glib2::Value::Extract<std::string>(params, 1);
 
     DcoKeyConfig dco_kc;
-    dco_kc.ParseFromString(base64->decode(key_config));
+    if (!dco_kc.ParseFromString(base64->decode(key_config)))
+    {
+        throw NetCfgException("ParseFromString for key_config failed");
+    }
 
     auto copyKeyDirection = [](const DcoKeyConfig_KeyDirection &src, KoRekey::KeyDirection &dst)
     {
-- 
2.53.0


