From: Gert Doering <gert@...1296...>
Date: Fri,  8 Mar 2024 13:05:57 +0100
Message-ID: <20240308120557.9065-1-gert@...1296...>
In-Reply-To: <gerrit.1709557301000.If9cb7d66f079fe1c87fcb5b4e59bc887533d77fa@...2715...>
References: <gerrit.1709557301000.If9cb7d66f079fe1c87fcb5b4e59bc887533d77fa@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] gerrit-send-mail: add missing
 Signed-off-by
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

From: Frank Lichtenheld <frank@...2641...>

Our development documentation says we add this
automatically when it is missing. So let's do that
here as well.

Change-Id: If9cb7d66f079fe1c87fcb5b4e59bc887533d77fa
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/530
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
index 67a2cf1..10305e2 100755
--- a/dev-tools/gerrit-send-mail.py
+++ b/dev-tools/gerrit-send-mail.py
@@ -50,6 +50,12 @@
                 ack = f"{reviewer_name} <{reviewer_mail}>"
                 print(f"Acked-by: {ack}")
                 acked_by.append(ack)
+    # construct Signed-off-by in case it is missing
+    owner = json_data["owner"]
+    owner_name = owner.get("display_name", owner["name"])
+    owner_mail = owner.get("email", owner["name"])
+    sign_off = f"{owner_name} <{owner_mail}>"
+    print(f"Signed-off-by: {sign_off}")
     change_id = json_data["change_id"]
     # assumes that the created date in Gerrit is in UTC
     utc_stamp = (
@@ -67,6 +73,7 @@
         "target": json_data["branch"],
         "msg_id": msg_id,
         "acked_by": acked_by,
+        "sign_off": sign_off,
     }
 
 
@@ -81,10 +88,14 @@
 
 def apply_patch_mods(patch_text, details, args):
     comment_start = patch_text.index("\n---\n") + len("\n---\n")
+    signed_off_text = ""
+    signed_off_comment = ""
     try:
         signed_off_start = patch_text.rindex("\nSigned-off-by: ")
         signed_off_end = patch_text.index("\n", signed_off_start + 1) + 1
     except ValueError:  # Signed-off missing
+        signed_off_text = f"Signed-off-by: {details['sign_off']}\n"
+        signed_off_comment = "\nSigned-off-by line for the author was added as per our policy.\n"
         signed_off_end = patch_text.index("\n---\n") + 1
     assert comment_start > signed_off_end
     acked_by_text = ""
@@ -94,6 +105,7 @@
         acked_by_names += f"{ack}\n"
     patch_text_mod = (
         patch_text[:signed_off_end]
+        + signed_off_text
         + acked_by_text
         + patch_text[signed_off_end:comment_start]
         + f"""
@@ -102,6 +114,7 @@
 
 Gerrit URL: {args.url}/c/{details["project"]}/+/{args.changeid}
 This mail reflects revision {details["revision"]} of this Change.
+{signed_off_comment}
 Acked-by according to Gerrit (reflected above):
 {acked_by_names}
         """

