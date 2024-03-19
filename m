From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 19 Mar 2024 15:56:51 +0200
Message-ID: <20240319135701.1301-2-lev@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] interactive.c: disable remote access to the
 service pipe
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
Cc: Lev Stipakov <lev@...515...>, Vladimir Tokarev <vtokarev@...2393...>, Heiko Hund <heiko@...515...>

Remote access to the service pipe is not needed and might
be a potential attack vector.

For example, if an attacker manages to get credentials for
a user which is the member of "OpenVPN Administrators" group
on a victim machine, an attacker might be able to communicate
with the privileged interactive service on a victim machine
and start openvpn processes remotely.

Reported-by: Vladimir Tokarev <vtokarev@...2393...>
Change-Id: I8739c5f127e9ca0683fcdbd099dba9896ae46277
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Heiko Hund <heiko@...515...>
---
 src/openvpnserv/interactive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 24e3f341..6a977b68 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2175,7 +2175,7 @@ CreateClientPipeInstance(VOID)
 
     openvpn_swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service"), service_instance);
     pipe = CreateNamedPipe(pipe_name, flags,
-                           PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE,
+                           PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,
                            PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, NULL);
     if (pipe == INVALID_HANDLE_VALUE)
     {
-- 
2.42.0.windows.2


