From: Gert Doering <gert@...1296...>
Date: Tue,  5 Aug 2025 17:04:57 +0200
Message-ID: <20250805150503.11391-1-gert@...1296...>
In-Reply-To: <gerrit.1754396906000.I729ee240e107a629ada5fab6b2ed2399e864cbd0@...2715...>
References: <gerrit.1754396906000.I729ee240e107a629ada5fab6b2ed2399e864cbd0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add clang-format reformat commit to
 .git-blame-ignore-revs
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

Change-Id: I729ee240e107a629ada5fab6b2ed2399e864cbd0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1130
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.git-blame-ignore-revs b/.git-blame-ignore-revs
index 1fafaac..290e4c3 100644
--- a/.git-blame-ignore-revs
+++ b/.git-blame-ignore-revs
@@ -48,3 +48,8 @@
 
 # Reformat for sp_after_comma=add
 e51d9a73693ee742b36e19fb1718e5e27167831d
+
+# The Great Reformatting of 2025, switching to clang-format
+3cca3367e6e0ffeccb8e39cb2c739d1dcb086701
+# Switching to ColumnLimit 0 for clang-format
+21f7d6e1ad65b1f7db673bc98764dc7325858e0b

