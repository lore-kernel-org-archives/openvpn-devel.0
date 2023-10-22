From: Gert Doering <gert@...1296...>
Date: Sun, 22 Oct 2023 12:59:19 +0200
Message-ID: <20231022105919.21779-1-gert@...1296...>
In-Reply-To: <gerrit.1695213156000.If4e9c2e58441efb3fd00872cd62d1cc6c607f160@...2715...>
References: <gerrit.1695213156000.If4e9c2e58441efb3fd00872cd62d1cc6c607f160@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] dev-tools/gerrit-send-mail.py: tool to
 send Gerrit patchsets to Patchwork
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

Since we're trying to use Gerrit for patch reviews, but the actual
merge process is still implemented against the ML and Patchwork,
I wrote a script that attempts to bridge the gap.

It extracts all relevant information about a patch from Gerrit
and converts it into a mail compatible to git-am. Mostly this
work is done by Gerrit already, since we can get the original
patch in git format-patch format. But we add Acked-by information
according to the approvals in Gerrit and some other metadata.

This should allow the merge to happen based on this one mail
alone.

v3:
 - handle missing display_name and email fields for reviewers
   gracefully
 - handle missing Signed-off-by line gracefully
v4:
 - use formatted string consistently

Change-Id: If4e9c2e58441efb3fd00872cd62d1cc6c607f160
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/361
This mail reflects revision 5 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
new file mode 100755
index 0000000..851a20a
--- /dev/null
+++ b/dev-tools/gerrit-send-mail.py
@@ -0,0 +1,132 @@
+#!/usr/bin/env python3
+
+#  Copyright (C) 2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2023 Frank Lichtenheld <frank.lichtenheld@...515...>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2
+#  as published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License along
+#  with this program; if not, write to the Free Software Foundation, Inc.,
+#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+# Extract a patch from Gerrit and transform it in a file suitable as input
+# for git send-email.
+
+import argparse
+import base64
+from datetime import timezone
+import json
+import sys
+from urllib.parse import urlparse
+
+import dateutil.parser
+import requests
+
+
+def get_details(args):
+    params = {"o": ["CURRENT_REVISION", "LABELS", "DETAILED_ACCOUNTS"]}
+    r = requests.get(f"{args.url}/changes/{args.changeid}", params=params)
+    print(r.url)
+    json_txt = r.text.removeprefix(")]}'\n")
+    json_data = json.loads(json_txt)
+    assert len(json_data["revisions"]) == 1  # CURRENT_REVISION works as expected
+    revision = json_data["revisions"].popitem()[1]["_number"]
+    assert "Code-Review" in json_data["labels"]
+    acked_by = []
+    for reviewer in json_data["labels"]["Code-Review"]["all"]:
+        if "value" in reviewer:
+            assert reviewer["value"] >= 0  # no NACK
+            if reviewer["value"] == 2:
+                # fall back to user name if optional fields are not set
+                reviewer_name = reviewer.get("display_name", reviewer["name"])
+                reviewer_mail = reviewer.get("email", reviewer["name"])
+                ack = f"{reviewer_name} <{reviewer_mail}>"
+                print(f"Acked-by: {ack}")
+                acked_by.append(ack)
+    change_id = json_data["change_id"]
+    # assumes that the created date in Gerrit is in UTC
+    utc_stamp = (
+        dateutil.parser.parse(json_data["created"])
+        .replace(tzinfo=timezone.utc)
+        .timestamp()
+    )
+    # convert to milliseconds as used in message id
+    created_stamp = int(utc_stamp * 1000)
+    hostname = urlparse(args.url).hostname
+    msg_id = f"gerrit.{created_stamp}.{change_id}@{hostname}"
+    return {
+        "revision": revision,
+        "project": json_data["project"],
+        "target": json_data["branch"],
+        "msg_id": msg_id,
+        "acked_by": acked_by,
+    }
+
+
+def get_patch(details, args):
+    r = requests.get(
+        f"{args.url}/changes/{args.changeid}/revisions/{details['revision']}/patch?download"
+    )
+    print(r.url)
+    patch_text = base64.b64decode(r.text).decode()
+    return patch_text
+
+
+def apply_patch_mods(patch_text, details, args):
+    comment_start = patch_text.index("\n---\n") + len("\n---\n")
+    try:
+        signed_off_start = patch_text.rindex("\nSigned-off-by: ")
+        signed_off_end = patch_text.index("\n", signed_off_start + 1) + 1
+    except ValueError:  # Signed-off missing
+        signed_off_end = patch_text.index("\n---\n") + 1
+    assert comment_start > signed_off_end
+    acked_by_text = ""
+    acked_by_names = ""
+    for ack in details["acked_by"]:
+        acked_by_text += f"Acked-by: {ack}\n"
+        acked_by_names += f"{ack}\n"
+    patch_text_mod = (
+        patch_text[:signed_off_end]
+        + acked_by_text
+        + patch_text[signed_off_end:comment_start]
+        + f"""
+This change was reviewed on Gerrit and approved by at least one
+developer. I request to merge it to {details["target"]}.
+
+Gerrit URL: {args.url}/c/{details["project"]}/+/{args.changeid}
+This mail reflects revision {details["revision"]} of this Change.
+Acked-by according to Gerrit (reflected above):
+{acked_by_names}
+        """
+        + patch_text[comment_start:]
+    )
+    filename = f"gerrit-{args.changeid}-{details['revision']}.patch"
+    with open(filename, "w") as patch_file:
+        patch_file.write(patch_text_mod)
+    print("send with:")
+    print(f"git send-email --in-reply-to {details['msg_id']} {filename}")
+
+
+def main():
+    parser = argparse.ArgumentParser(
+        prog="gerrit-send-mail",
+        description="Send patchset from Gerrit to mailing list",
+    )
+    parser.add_argument("changeid")
+    parser.add_argument("-u", "--url", default="https://gerrit.openvpn.net")
+    args = parser.parse_args()
+
+    details = get_details(args)
+    patch = get_patch(details, args)
+    apply_patch_mods(patch, details, args)
+
+
+if __name__ == "__main__":
+    sys.exit(main())

