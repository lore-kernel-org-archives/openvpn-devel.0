From: selva.nair@...277...
Date: Wed, 19 Feb 2020 19:49:37 -0500
Message-Id: <1582159777-2437-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix possibly uninitialized return value in
 GetOpenvpnSettings()
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

From: Selva Nair <selva.nair@...277...>

Compile time warning for openvpnserv.exe
common.c:90:11: warning: ‘error’ may be used uninitialized in this
function [-Wmaybe-uninitialized];

Uninitialized value gets returned if install-path is not found
in the registry. Fix by setting it to the return value of
GetRegString().

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Behaviour change: previously, on not finding the install_path
in registry, the service logged an error and often continued
as the uninitialized value of error could be zero. With
this change it will consistently exit with error.

 src/openvpnserv/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index fd51776..958643d 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -118,8 +118,10 @@ GetOpenvpnSettings(settings_t *s)
     }
 
     /* The default value of REG_KEY is the install path */
-    if (GetRegString(key, NULL, install_path, sizeof(install_path), NULL) != ERROR_SUCCESS)
+    status = GetRegString(key, NULL, install_path, sizeof(install_path), NULL);
+    if (status != ERROR_SUCCESS)
     {
+        error = status;
         goto out;
     }
 
-- 
2.1.4


