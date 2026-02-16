From: Gert Doering <gert@...1296...>
Date: Mon, 16 Feb 2026 13:30:20 +0100
Message-ID: <20260216123026.3310-1-gert@...1296...>
In-Reply-To: <gerrit.1771244685000.Idb1e96a4d0a618089db4290c5980d192985b5d29@...2715...>
References: <gerrit.1771244685000.Idb1e96a4d0a618089db4290c5980d192985b5d29@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] clang-format: Add missing InsertBraces:
 true
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

This takes care to add missing braces in
case of one-line if-statements or loops.

Apparently we never tested this specific error
and we had no existing cases in the code when
we did the reformat. Noticed this during a code
review.

Change-Id: Idb1e96a4d0a618089db4290c5980d192985b5d29
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1529
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1529
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.clang-format b/.clang-format
index 1cce4c3..cbec0a4 100644
--- a/.clang-format
+++ b/.clang-format
@@ -31,6 +31,7 @@
 IndentGotoLabels: false
 IndentWidth: '4'
 IndentWrappedFunctionNames: false
+InsertBraces: true
 KeepEmptyLinesAtTheStartOfBlocks: false
 MaxEmptyLinesToKeep: '2'
 PointerAlignment: Right

