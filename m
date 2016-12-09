From: Herve Codina <herve.CODINA@...2209...>
Message-ID: <e599e797-24db-f09f-caf9-1e969359abea@...2209...>
Date: Fri, 9 Dec 2016 14:04:18 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/1] Handle SIGHUP during initialisation
	phase
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Without this commit, if remote host cannot be reached, we get stuck in loop trying to
connect and we cannot reload a new configuration using SIGHUP.
In this case, the only way to reload the configuration is to kill and relaunch the daemon.

With this commit, following use case can be done:
- Set a good config file
- Launch vpn client daemon -> Connect OK
- Change config file (configure a wrong remote host)
- SIGHUP
- client daemon reload conf -> Connect failed and loop retrying connection
- Change config file (configure a good remote host)
- SIGHUP
- client daemon reload conf -> Connect OK

Signed-off-by: Herve Codina <Herve.CODINA@...2209...>
---
 src/openvpn/sig.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index b3ae645..073a285 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -226,7 +226,7 @@ pre_init_signal_catch (void)
   signal_mode = SM_PRE_INIT;
   signal (SIGINT, signal_handler);
   signal (SIGTERM, signal_handler);
-  signal (SIGHUP, SIG_IGN);
+  signal (SIGHUP, signal_handler);
   signal (SIGUSR1, SIG_IGN);
   signal (SIGUSR2, SIG_IGN);
   signal (SIGPIPE, SIG_IGN);
-- 
1.7.9.5


