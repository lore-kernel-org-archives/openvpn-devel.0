From: Domagoj Pensa <domagoj@...2540...>
Message-ID: <20201215171600.25534-1-domagoj@...2540...>
Date: Tue, 15 Dec 2020 18:16:00 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix too early argv freeing when registering
 DNS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Domagoj Pensa <domagoj@...2540...>

When registering DNS on Windows, argv is freed after being used in first
ipconfig command (/flushdns).

Then same argv is used uninitialized in next ipconfig command (/registerdns)
causing heap exception and subprocess crash.

As a consequence second command is never executed and locked netcmd
semaphore is not cleanly released.

Removing argv freeing between ipconfig calls solves the problem.

This issue was introduced in commit 870e240 (argv: do fewer memory
re-allocations). After a quick glance at commit no similar problem was
spotted in rest of the argv related changes.

Signed-off-by: Domagoj Pensa <domagoj@...2540...>
---
 src/openvpn/tun.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 400a50ca..2b227bb6 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5235,7 +5235,6 @@ ipconfig_register_dns(const struct env_set *es)
                 WIN_IPCONFIG_PATH_SUFFIX);
     argv_msg(D_TUNTAP_INFO, &argv);
     openvpn_execve_check(&argv, es, 0, err);
-    argv_free(&argv);
=20
     argv_printf(&argv, "%s%s /registerdns",
                 get_win_sys_path(),
--=20
2.29.2



