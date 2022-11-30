From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 30 Nov 2022 14:31:51 +0100
Message-Id: <20221130133154.39454-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/3] GitHub Issues Usage
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

At the Hackathon in Delft we decided to switch to GitHub
Issues since the old Trac system will need to be replaced.

GitHub issues have the main advantage that many other projects
are also on GitHub. So apart from being familiar to
users we also have the ability to link to other projects
or move issues over to them if applicable.

This patch series adds a first issue template for our use
and does various documentation updates.

Frank Lichtenheld (3):
  GitHub Issues: Create first issue template (Bug)
  GitHub Issues: add new links to INSTALL and README
  GitHub Issues: add note to Changes as well

 .github/ISSUE_TEMPLATE/bug_report.md | 25 +++++++++++++++++++++++++
 Changes.rst                          |  6 ++++++
 INSTALL                              |  4 +++-
 README                               |  5 ++++-
 4 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 .github/ISSUE_TEMPLATE/bug_report.md

-- 
2.34.1


