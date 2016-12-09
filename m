From: =?iso-8859-1?Q?Herv=E9_CODINA?= <Herve.CODINA@...2209...>
Date: Fri, 9 Dec 2016 14:15:55 +0100
Message-ID: <1481289355-4617-1-git-send-email-Herve.CODINA@...2209...>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: =?iso-8859-1?Q?Herv=E9_CODINA?= <Herve.CODINA@...2209...>

Without this commit, if remote host cannot be reached, we get stuck in loop=
 trying to
connect and we cannot reload a new configuration using SIGHUP.
In this case, the only way to reload the configuration is to kill and relau=
nch the daemon.

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
   signal_mode =3D SM_PRE_INIT;
   signal (SIGINT, signal_handler);
   signal (SIGTERM, signal_handler);
-  signal (SIGHUP, SIG_IGN);
+  signal (SIGHUP, signal_handler);
   signal (SIGUSR1, SIG_IGN);
   signal (SIGUSR2, SIG_IGN);
   signal (SIGPIPE, SIG_IGN);
--=20
1.7.9.5

