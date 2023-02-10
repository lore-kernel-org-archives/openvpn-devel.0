From: Arne Schwabe <arne@...1227...>
Date: Fri, 10 Feb 2023 15:27:09 +0100
Message-Id: <20230210142712.572303-6-arne@...1227...>
In-Reply-To: <20230210142712.572303-1-arne@...1227...>
References: <20230210142712.572303-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/4] Update the last sections in the man
 page to a be a bit less outdated
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/openvpn.8.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/doc/openvpn.8.rst b/doc/openvpn.8.rst
index 995467478..415f210ce 100644
--- a/doc/openvpn.8.rst
+++ b/doc/openvpn.8.rst
@@ -97,6 +97,8 @@ https://community.openvpn.net/openvpn/wiki/FAQ
 
 HOWTO
 =====
+The manual ``openvpn-examples``\(5) give some examples, especially for
+small setups.
 
 For a more comprehensive guide to setting up OpenVPN in a production
 setting, see the OpenVPN HOWTO at
@@ -107,18 +109,17 @@ https://openvpn.net/community-resources/how-to/
 PROTOCOL
 ========
 
-For a description of OpenVPN's underlying protocol, see
-https://openvpn.net/community-resources/openvpn-protocol/
-
+An ongoing effort to document the OpenVPN protocol can be found under
+https://github.com/openvpn/openvpn-rfc
 
 
 WEB
 ===
 
-OpenVPN's web site is at https://openvpn.net/
+OpenVPN's web site is at https://community.openvpn.net/
 
 Go here to download the latest version of OpenVPN, subscribe to the
-mailing lists, read the mailing list archives, or browse the SVN
+mailing lists, read the mailing list archives, or browse the Git
 repository.
 
 
-- 
2.37.1 (Apple Git-137.1)


