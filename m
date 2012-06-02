From: Arne Schwabe <arne@...1227...>
Date: Sat,  2 Jun 2012 15:03:39 +0200
Message-Id: <1338642223-20324-5-git-send-email-arne@...1227...>
In-Reply-To: <1338642223-20324-1-git-send-email-arne@...1227...>
References: <1338642223-20324-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/8] Explain that route-nopull also causes
	the client to ignore dhcp options.
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
 doc/openvpn.8         |    3 ++-
 src/openvpn/options.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 24b1a2c..f420d58 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1087,7 +1087,8 @@ When used with
 .B \-\-client
 or
 .B \-\-pull,
-accept options pushed by server EXCEPT for routes.
+accept options pushed by server EXCEPT for routes and dhcp options
+like DNS servers.
 
 When used on the client, this option effectively bars the
 server from adding routes to the client's routing table,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 71d43b7..1d5a75b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -231,7 +231,7 @@ static const char usage_message[] =
   "--route-noexec  : Don't add routes automatically.  Instead pass routes to\n"
   "                  --route-up script using environmental variables.\n"
   "--route-nopull  : When used with --client or --pull, accept options pushed\n"
-  "                  by server EXCEPT for routes.\n"
+  "                  by server EXCEPT for routes and dhcp options.\n"
   "--allow-pull-fqdn : Allow client to pull DNS names from server for\n"
   "                    --ifconfig, --route, and --route-gateway.\n"
   "--redirect-gateway [flags]: Automatically execute routing\n"
-- 
1.7.7.5 (Apple Git-26)


