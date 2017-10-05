From: David Sommerseth <davids@...515...>
Date: Thu,  5 Oct 2017 23:22:23 +0200
Message-Id: <20171005212223.24694-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Remove references to keychain-mcd in
 Changes.rst
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

In commit 59e7e9fce8de6ea90d13baeaede83adc0b594e22 the contrib/keychain-mcd
code was completely removed.  But it was not removed from Changes.rst.

Signed-off-by: David Sommerseth <davids@...515...>
---
 Changes.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 53a14438..db9b18b9 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -133,10 +133,6 @@ keying-material-exporter
     Keying Material Exporter [RFC-5705] allow additional keying material to be
     derived from existing TLS channel.
 
-Mac OS X Keychain management client
-    Added contrib/keychain-mcd which allows to use Mac OS X keychain
-    certificates with OpenVPN.
-
 Android platform support
     Support for running on Android using Android's VPNService API has been added.
     See doc/android.txt for more details. This support is primarily used in
-- 
2.13.5


