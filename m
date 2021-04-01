From: Tony He <huangya90@...277...>
Date: Thu,  1 Apr 2021 14:44:31 +0800
Message-Id: <20210401064431.20229-1-huangya90@...277...>
Subject: [Openvpn-devel] [PATCH] ovpn-dco: ovpn-cli: properly set socket
 options
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
To: a@...2181...
Cc: openvpn-devel@lists.sourceforge.net, Tony He <huangya90@...277...>

Actully We can not set two options at the same time.
Old code:

setsockopt(s, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt))

If you use strace to trace sys call, you will find only SO_REUSEPORT is
set:
>setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0

This is because SD_REUSEADDR is 2(0x0010) and SR_REUSEPORT is 15(0x1111) defined in
/usr/include/asm-generic/socket.h in X86-64 platform.

We need to set them one by one. In other platforms, if you set mutli
options at the same time, you may encounter error "setsockopt: Protocol
not available". Refer to
https://stackoverflow.com/questions/58599070/socket-programming-setsockopt-protocol-not-available

Signed-off-by: Tony He <huangya90@...277...>
---
 tests/ovpn-cli.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/ovpn-cli.c b/tests/ovpn-cli.c
index c1cf3b4..68d28b4 100644
--- a/tests/ovpn-cli.c
+++ b/tests/ovpn-cli.c
@@ -426,9 +426,14 @@ static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
 	}
 
 	int opt = 1;
-	ret = setsockopt(s, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt));
+	ret = setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
 	if (ret < 0) {
-		perror("setsockopt");
+		perror("setsockopt for SO_REUSEADDR");
+		return ret;
+	}
+	ret = setsockopt(s, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
+	if (ret < 0) {
+		perror("setsockopt for SO_REUSEPORT");
 		return ret;
 	}
 
-- 
2.17.1


