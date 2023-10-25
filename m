From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 25 Oct 2023 14:20:39 +0200
Message-Id: <20231025122039.1031284-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] gerrit-send-mail.py: Add patch version to
 subject
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

Change-Id: I75403dfbebeeb4d667c7dd6b8276c6a4f2ae4842
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 dev-tools/gerrit-send-mail.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
index 851a20a0..5429aef6 100755
--- a/dev-tools/gerrit-send-mail.py
+++ b/dev-tools/gerrit-send-mail.py
@@ -108,8 +108,9 @@ Acked-by according to Gerrit (reflected above):
         + patch_text[comment_start:]
     )
     filename = f"gerrit-{args.changeid}-{details['revision']}.patch"
+    patch_text_final = patch_text_mod.replace("Subject: [PATCH]", f"Subject: [PATCH v{details['revision']}]")
     with open(filename, "w") as patch_file:
-        patch_file.write(patch_text_mod)
+        patch_file.write(patch_text_final)
     print("send with:")
     print(f"git send-email --in-reply-to {details['msg_id']} {filename}")
 
-- 
2.34.1


