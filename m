MIME-Version: 1.0
From: Merten Fermont <merten.fermont@...277...>
Date: Thu, 27 Jul 2023 10:52:33 +0200
Message-ID: <CAEeEfvzkhp_FQ8cnOZcASiVbDN8=+Gw_2sV5SNonL5x7OYb1jA@...278...>
Subject: [Openvpn-devel] [PATCH OpenVPN3] Add 'pull' to ignored options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Fixes error that --pull is an unknown option in client config.
---
openvpn/client/cliopt.hpp | 1 +
1 file changed, 1 insertion(+)

diff --git a/openvpn/client/cliopt.hpp b/openvpn/client/cliopt.hpp
index f7be44a8..431791f3 100644
--- a/openvpn/client/cliopt.hpp
+++ b/openvpn/client/cliopt.hpp
@@ -797,6 +797,7 @@ class ClientOptions : public RC<thread_unsafe_refcount>
        "mute-replay-warnings",
        "nobind", /* only behaviour in v3 client anyway */
        "prng",
+        "pull", /* option is implied by 'client' */
        "rcvbuf",         /* present in many configs */
        "replay-persist", /* Makes little sense in TLS mode */
        "script-security",
--
2.41.0

