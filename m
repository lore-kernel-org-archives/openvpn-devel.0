From: Richard Bonhomme <tincanteksup@...277...>
Date: Wed, 17 Mar 2021 22:34:48 +0000
Message-Id: <20210317223448.1278818-1-tincanteksup@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Do not print Diffy Hellman parameters file
 to log file
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

Suppress printing the complete Diffy Hellman parameters file
to the log file when it has been configured as an inline file.

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0eb049d8..3a2c7a10 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1695,7 +1695,7 @@ show_settings(const struct options *o)
     SHOW_BOOL(tls_client);
     SHOW_STR_INLINE(ca_file);
     SHOW_STR(ca_path);
-    SHOW_STR(dh_file);
+    SHOW_STR_INLINE(dh_file);
 #ifdef ENABLE_MANAGEMENT
     if ((o->management_flags & MF_EXTERNAL_CERT))
     {
-- 
2.25.1


