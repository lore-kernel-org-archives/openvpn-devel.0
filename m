From: Arne Schwabe <arne@...1227...>
Date: Sat,  2 Jun 2012 15:03:36 +0200
Message-Id: <1338642223-20324-2-git-send-email-arne@...1227...>
In-Reply-To: <1338642223-20324-1-git-send-email-arne@...1227...>
References: <1338642223-20324-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/8] Silence Port is now 1194 IANA warning
	if remote option with port is used
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


Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 08f9cb2..8e5d3b9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4506,6 +4506,7 @@ add_option (struct options *options,
 	      goto err;
 	    }
 	  re.remote_port = port;
+      options->ce.port_option_used = true;
 	  if (p[3])
 	    {
 	      const int proto = ascii2proto (p[3]);
-- 
1.7.7.5 (Apple Git-26)


