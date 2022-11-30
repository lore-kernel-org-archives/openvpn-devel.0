From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 30 Nov 2022 14:31:53 +0100
Message-Id: <20221130133154.39454-3-frank@...2641...>
In-Reply-To: <20221130133154.39454-1-frank@...2641...>
References: <20221130133154.39454-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] GitHub Issues: add new links to INSTALL
 and README
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

But keep the old links around as well for now since
the GitHub issues aren't useful, yet.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 INSTALL | 4 +++-
 README  | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index db24e98c..a63bab6a 100644
--- a/INSTALL
+++ b/INSTALL
@@ -276,6 +276,8 @@ TUN/TAP Driver References:
 
 CAVEATS & BUGS:
 
-* see the bug tracker on https://community.openvpn.net/openvpn/report
+* See the bug tracker on https://github.com/OpenVPN/openvpn/issues
   and the wiki on https://community.openvpn.net/wiki for more detailed
   caveats on operating systems, and for open and resolved bug reports.
+* Note: We only recently switched to GitHub for reporting new issues,
+  old issues can be found at https://community.openvpn.net/openvpn/report
diff --git a/README b/README
index 523abb70..04eb16ff 100644
--- a/README
+++ b/README
@@ -30,7 +30,10 @@ For a sample VPN configuration, see
   http://openvpn.net/howto.html
 
 To report an issue, see
-  https://community.openvpn.net/openvpn/newticket
+  https://github.com/OpenVPN/openvpn/issues/new
+  (Note: We recently switched to GitHub for reporting new issues,
+   old issues can be found at:
+   https://community.openvpn.net/openvpn/report)
 
 For a description of OpenVPN's underlying protocol,
   see the file ssl.h included in the source distribution.
-- 
2.34.1


