From: Gert Doering <gert@...1296...>
Date: Mon, 29 Jan 2024 15:57:56 +0100
Message-ID: <20240129145756.769-1-gert@...1296...>
In-Reply-To: <gerrit.1706525147000.Id7b4bda38adfbb446bdac635ac5d5207ef3f2f40@...2715...>
References: <gerrit.1706525147000.Id7b4bda38adfbb446bdac635ac5d5207ef3f2f40@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] gerrit-send-mail: Make output consistent
 across systems
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

When writing the file specify encoding and newline, so that
the local settings (like locale) do not change the output.

Change-Id: Id7b4bda38adfbb446bdac635ac5d5207ef3f2f40
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/508
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
index 5429aef..67a2cf1 100755
--- a/dev-tools/gerrit-send-mail.py
+++ b/dev-tools/gerrit-send-mail.py
@@ -109,7 +109,7 @@
     )
     filename = f"gerrit-{args.changeid}-{details['revision']}.patch"
     patch_text_final = patch_text_mod.replace("Subject: [PATCH v1]", f"Subject: [PATCH v{details['revision']}]")
-    with open(filename, "w") as patch_file:
+    with open(filename, "w", encoding="utf-8", newline="\n") as patch_file:
         patch_file.write(patch_text_final)
     print("send with:")
     print(f"git send-email --in-reply-to {details['msg_id']} {filename}")

