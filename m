From: Gert Doering <gert@...1296...>
Date: Wed, 17 Nov 2021 07:44:42 +0100
Message-Id: <20211117064442.15899-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Include --push-remove in the output of
 --help.
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

"push-remove" has been in OpenVPN since 2.4, but managed to stay hidden
from the "--help" output.  Add.

Reported-by: mike tancsa <mike@...1800...>

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a167a08a..cc3d9fa0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -409,6 +409,8 @@ static const char usage_message[] =
     "                  execution.  Peer must specify --pull in its config file.\n"
     "--push-reset    : Don't inherit global push list for specific\n"
     "                  client instance.\n"
+    "--push-remove opt : Remove options matching 'opt' from the push list for\n"
+    "                  a specific client instance.\n"
     "--ifconfig-pool start-IP end-IP [netmask] : Set aside a pool of subnets\n"
     "                  to be dynamically allocated to connecting clients.\n"
     "--ifconfig-pool-persist file [seconds] : Persist/unpersist ifconfig-pool\n"
-- 
2.26.3


