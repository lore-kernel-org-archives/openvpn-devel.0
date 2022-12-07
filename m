From: Frank Lichtenheld <frank@...2641...>
Date: Wed,  7 Dec 2022 11:35:30 +0100
Message-Id: <20221207103530.18198-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2.6] ChangeLog: Fix encoding
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

Convert to UTF-8.
Also collapse entries "Richard Bonhomme" and "Richard T Bonhomme".

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 ChangeLog | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index d1a47dec..64ec4bff 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -398,7 +398,7 @@ Arne Schwabe (289):
       Signal USR1 when connection initialising fails
       Allow reconnecting in p2p mode work under FreeBSD
 
-Camille Gu�rin (1):
+Camille Guérin (1):
       Removed error message for an option flag not supported with --server-ipv6
 
 David Korczynski (1):
@@ -683,12 +683,10 @@ Michael Baentsch (1):
 Paolo Cerrito (1):
       Insert client connection data into PAM environment
 
-Richard Bonhomme (3):
+Richard Bonhomme (6):
       Improve error msg when all TAP adapters are in use 'or disabled'
       Man page sections corrections
       Do not print Diffie Hellman parameters file to log file
-
-Richard T Bonhomme (3):
       Log messages: Replace NCP with --data-ciphers (NFC)
       doc link-options.rst: Use free open-source dynamic-DNS provider URL
       doc/protocol-options.rst: Correct default for --allow-compression
@@ -794,10 +792,10 @@ Todd Zullinger (2):
       Update IRC information in CONTRIBUTING.rst
       doc/man (vpn-network-options): fix foreign_option_{n} typo
 
-T�ivo Leedj�rv (1):
+Tõivo Leedjärv (1):
       Stop using deprecated getpass()
 
-Ville Skytt� (1):
+Ville Skyttä (1):
       README.down-root: Fix plugin module name
 
 Vladislav Grishenko (8):
-- 
2.34.1


