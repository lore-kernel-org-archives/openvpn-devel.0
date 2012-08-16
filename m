From: Gert Doering <gert@...1296...>
Date: Thu, 16 Aug 2012 20:31:23 +0200
Message-Id: <1345141883-9889-3-git-send-email-gert@...1296...>
In-Reply-To: <1345141883-9889-1-git-send-email-gert@...1296...>
References: <1345141883-9889-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 2/2] Reduce --version string detail about
	IPv6 to just "[IPv6]".
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

For 2.3 release, we do not need to have more details, as there is no
separate patch set anymore, and both IPv6 transport and IPv6 payload
(PF_INET6) have been fully integrated.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 19690e1..d25bbea 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -106,8 +106,7 @@ const char title_string[] =
 #if ENABLE_IP_PKTINFO
   " [MH]"
 #endif
-  " [PF_INET6]"
-  " [IPv6 payload 20110522-1 (2.2.0)]"
+  " [IPv6]"
   " built on " __DATE__
 ;
 
-- 
1.7.3.5


