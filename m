From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 30 Nov 2022 14:31:52 +0100
Message-Id: <20221130133154.39454-2-frank@...2641...>
In-Reply-To: <20221130133154.39454-1-frank@...2641...>
References: <20221130133154.39454-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] GitHub Issues: Create first issue
 template (Bug)
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

If we want people to use GH issues, we should
probably offer some issue templates to give
guidance on what to include.

Based on GH's standard bug template.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .github/ISSUE_TEMPLATE/bug_report.md | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 .github/ISSUE_TEMPLATE/bug_report.md

diff --git a/.github/ISSUE_TEMPLATE/bug_report.md b/.github/ISSUE_TEMPLATE/bug_report.md
new file mode 100644
index 00000000..6cbd3ba4
--- /dev/null
+++ b/.github/ISSUE_TEMPLATE/bug_report.md
@@ -0,0 +1,25 @@
+---
+name: Bug report
+about: Create a report to help us improve
+title: ''
+labels: ''
+assignees: ''
+
+---
+
+**Describe the bug**
+A clear and concise description of what the bug is.
+
+**To Reproduce**
+Steps to reproduce the behavior. Please make sure to not post any secrets like keys and passwords.
+
+**Expected behavior**
+A clear and concise description of what you expected to happen.
+
+**Version information (please complete the following information):**
+ - OS: [e.g. Ubuntu 22.04]
+ - OpenVPN version: [e.g. 2.5.8]
+ - Repeat for peer if relevant
+
+**Additional context**
+Add any other context about the problem here.
-- 
2.34.1


