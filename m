From: Ilya Shipitsin <chipitsine@...277...>
Date: Wed, 29 Mar 2017 18:43:02 +0500
Message-Id: <1490794982-4550-1-git-send-email-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] v3: resolve format string warnings
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

[src/openvpn/options.c:1163]: (warning) %x in format string (no. 1) requires 'unsigned int *' but the argument type is 'signed int *'.
[src/openvpn/route.c:3187]: (warning) %d in format string (no. 5) requires 'int *' but the argument type is 'unsigned int *'.

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
v2: use "uint8_t" in options.c, thanks to Gert Doering

v3: switch back to "unsigned int", thanks to David Sommerseth

 src/openvpn/options.c | 2 +-
 src/openvpn/route.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index dcb6ecf..2bc7e62 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1147,7 +1147,7 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
     const char *cp = str;
     uint8_t *ret = (uint8_t *) gc_malloc(nbytes, true, gc);
     char term = 1;
-    int byte;
+    unsigned int byte;
     char bs[3];
 
     for (i = 0; i < nbytes; ++i)
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 08998d5..ecfa60f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3184,7 +3184,7 @@ get_default_gateway(struct route_gateway_info *rgi)
                     unsigned int flags = 0;
                     char name[16];
                     name[0] = 0;
-                    const int np = sscanf(line, "%15s\t%x\t%x\t%x\t%*s\t%*s\t%d\t%x",
+                    const int np = sscanf(line, "%15s\t%x\t%x\t%x\t%*s\t%*s\t%u\t%x",
                                           name,
                                           &net_x,
                                           &gw_x,
-- 
2.5.5


