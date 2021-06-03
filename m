From: Matthias Andree <matthias.andree@...68...>
Date: Thu,  3 Jun 2021 14:30:19 +0200
Message-Id: <20210603123019.422644-1-matthias.andree@...68...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix SIGSEGV (NULL deref) receiving push
 "echo"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Matthias Andree <matthias.andree@...68...>, peo@...2618...

A server pushing "echo" without arguments can crash the client.
In such a situation, the code in question receives p[1] =3D=3D NULL
(which was CLEAR(p)'ed above), hands it strncmp, which then
dereferences the null pointer.

Original report and analysis here:
https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D256331

Fixes: Trac #1409
Reported-by: peo@...2618... (to FreeBSD)
Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8d417206..a54bc562 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5365,7 +5365,7 @@ add_option(struct options *options,
         {
             /* only message-related ECHO are logged, since other ECHOs
              * can potentially include security-sensitive strings */
-            if (strncmp(p[1], "msg", 3) =3D=3D 0)
+            if (p[1] && strncmp(p[1], "msg", 3) =3D=3D 0)
             {
                 msg(M_INFO, "%s:%s",
                     pull_mode ? "ECHO-PULL" : "ECHO",
--
2.31.1


