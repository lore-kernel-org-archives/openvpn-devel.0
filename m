From: Gert Doering <gert@...1296...>
Date: Wed, 17 Sep 2025 14:07:15 +0200
Message-ID: <20250917120720.30738-1-gert@...1296...>
In-Reply-To: <gerrit.1758101669000.Idb137ecbade4b0584a4d74aee34978062e247bc5@...2715...>
References: <gerrit.1758101669000.Idb137ecbade4b0584a4d74aee34978062e247bc5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dev-tools/gerrit-send-mail.py: include
 Gerrit URL into the commit message
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
Cc: Gert Doering <gert@...1296...>, Frank Lichtenheld <frank@...2641...>

We used to reference to one of the mailing list archives as the formal
reference for the patch and the review discussions.  With the problematic
reliability of the archives, I've started to manually add the URLs in
the OpenVPN Gerrit to the commits because they give a better reference
and (usually) all the feedback is there in a useful format.

So, enhance this dev-tool script to do this automatically.

Change-Id: Idb137ecbade4b0584a4d74aee34978062e247bc5
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1196
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1196
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
index 0b49ae9..450e920 100755
--- a/dev-tools/gerrit-send-mail.py
+++ b/dev-tools/gerrit-send-mail.py
@@ -99,6 +99,7 @@
     assert comment_start > signed_off_end
     acked_by_text = ""
     acked_by_names = ""
+    gerrit_url = f"{args.url}/c/{details['project']}/+/{args.changeid}"
     for ack in details["acked_by"]:
         acked_by_text += f"Acked-by: {ack}\n"
         acked_by_names += f"{ack}\n"
@@ -106,12 +107,13 @@
         patch_text[:signed_off_end]
         + signed_off_text
         + acked_by_text
+        + f"Gerrit URL: {gerrit_url}\n"
         + patch_text[signed_off_end:comment_start]
         + f"""
 This change was reviewed on Gerrit and approved by at least one
 developer. I request to merge it to {details["target"]}.
 
-Gerrit URL: {args.url}/c/{details["project"]}/+/{args.changeid}
+Gerrit URL: {gerrit_url}
 This mail reflects revision {details["revision"]} of this Change.
 {signed_off_comment}
 Acked-by according to Gerrit (reflected above):

