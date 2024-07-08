From: Ilia Shipitsin <chipitsine@...277...>
Date: Mon,  8 Jul 2024 23:08:18 +0200
Message-ID: <20240708210912.566-2-chipitsine@...277...>
In-Reply-To: <20240708210912.566-1-chipitsine@...277...>
References: <20240708210912.566-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/5] src/openvpn/init.c: handle strdup
 failures
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

Signed-off-by: Ilia Shipitsin <chipitsine@...277...>
---
 src/openvpn/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a49e5639..59205ba6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4967,6 +4967,10 @@ write_pid_file(const char *filename, const char *chroot_dir)
         if (!chroot_dir)
         {
             saved_pid_file_name = strdup(filename);
+            if (!saved_pid_file_name)
+            {
+                msg( M_FATAL, "Failed allocate memory saved_pid_file_name");
+            }
         }
     }
 }
-- 
2.43.0.windows.1


