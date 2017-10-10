From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:19 +0200
Message-Id: <20171010231130.6832-2-simon@...2293...>
In-Reply-To: <20171010231130.6832-1-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH 02/13] Mixing wide and regular strings in
 concatenations is not allowed in MSVC.
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

From: Simon Rozman <simon@...2293...>

---
 src/openvpnserv/interactive.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 9d473e4..4b08086 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -370,12 +370,12 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
     BOOL ret = FALSE;
     int i;
     const WCHAR *msg1 = L"You have specified a config file location (%s relative to %s)"
-                        " that requires admin approval. This error may be avoided"
-                        " by adding your account to the \"%s\" group";
+                        L" that requires admin approval. This error may be avoided"
+                        L" by adding your account to the \"%s\" group";
 
     const WCHAR *msg2 = L"You have specified an option (%s) that may be used"
-                        " only with admin approval. This error may be avoided"
-                        " by adding your account to the \"%s\" group";
+                        L" only with admin approval. This error may be avoided"
+                        L" by adding your account to the \"%s\" group";
 
     argv = CommandLineToArgvW(options, &argc);
 
-- 
2.9.0.windows.1


