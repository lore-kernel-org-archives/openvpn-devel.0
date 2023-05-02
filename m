From: Frank Lichtenheld <frank@...2641...>
Date: Tue,  2 May 2023 14:02:27 +0200
Message-Id: <20230502120227.30592-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH openvpn3-linux] openvpn3-config-manage: Fix
 description in man page
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

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 docs/man/openvpn3-config-manage.1.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/docs/man/openvpn3-config-manage.1.rst b/docs/man/openvpn3-config-manage.1.rst
index 56c0704..a919990 100644
--- a/docs/man/openvpn3-config-manage.1.rst
+++ b/docs/man/openvpn3-config-manage.1.rst
@@ -17,13 +17,15 @@ SYNOPSIS
 
 DESCRIPTION
 ===========
-This will delete an imported configuration profile from the configuration
-manager.
+Manage settings for an imported configuration profile.  This allows to override parts
+of the original config profile.  Note that this will not be reflected in the output
+of ``openvpn3 config-dump``.  Use ``openvpn3 config-manage --show`` to see the existing
+overrides.
 
 OPTIONS
 =======
 
--h, --help              Print  usage and help details to the terminal
+-h, --help              Print usage and help details to the terminal
 
 -o DBUS-PATH, --path DBUS-PATH
                         D-Bus configuration path to the
-- 
2.34.1


