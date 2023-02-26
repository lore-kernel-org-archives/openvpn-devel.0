From: Antonio Quartulli <a@...2181...>
Date: Sun, 26 Feb 2023 22:34:20 +0100
Message-Id: <20230226213420.21201-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update issue templates
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
Cc: Antonio Quartulli <a@...2181...>

With this change we extend the text exposed to people opening a bug in
the OpenVPN project.

Hopefully they will read and immediately understand that GH is not the
right place to report ossues about commercial products.

Change-Id: Idd039612698a6b08f9544450885d1a5f77fd95c6
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 .github/ISSUE_TEMPLATE/bug_report.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.github/ISSUE_TEMPLATE/bug_report.md b/.github/ISSUE_TEMPLATE/bug_report.md
index 6cbd3ba4..3bf6f233 100644
--- a/.github/ISSUE_TEMPLATE/bug_report.md
+++ b/.github/ISSUE_TEMPLATE/bug_report.md
@@ -7,6 +7,9 @@ assignees: ''
 
 ---
 
+**IMPORTANT NOTE**
+Bugs about OpenVPN Access Server, OpenVPN Connect or any other product by OpenVPN Inc. should be directly reported to OpenVPN Inc. at https://support.openvpn.net
+
 **Describe the bug**
 A clear and concise description of what the bug is.
 
-- 
2.39.2


