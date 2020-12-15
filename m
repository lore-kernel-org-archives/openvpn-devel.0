From: Domagoj Pensa <domagoj@...2540...>
Message-ID: <20201215173950.26596-1-domagoj@...2540...>
Date: Tue, 15 Dec 2020 18:39:50 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove 1 second delay before running netsh
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

When running various netsh commands before each 1 second sleep is added.
As more netsh commands are run, especially for Wintun adapters, that can
add to a noticable delayed connecting time.

This should be safe. No problems were found in tests and all netsh
commands executed properly with delay removed. Also, no delays are used
in a similar code in interactive service and netsh command executions
are guarded with a semaphore.

Signed-off-by: Domagoj Pensa <domagoj@...2540...>
---
 src/openvpn/tun.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 400a50ca..e9f1aadb 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5207,7 +5207,6 @@ netsh_command(const struct argv *a, int n, int msglev=
el)
     for (i =3D 0; i < n; ++i)
     {
         bool status;
-        management_sleep(1);
         netcmd_semaphore_lock();
         argv_msg_prefix(M_INFO, a, "NETSH");
         status =3D openvpn_execve_check(a, NULL, 0, "ERROR: netsh command =
failed");
--=20
2.29.2



