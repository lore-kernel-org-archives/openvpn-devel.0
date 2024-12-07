Message-ID: <8de5660b-d917-4092-8871-250495d8c7a4@...68...>
Date: Sun, 8 Dec 2024 00:17:05 +0100
MIME-Version: 1.0
Content-Language: de-CH
From: corubba <corubba@...68...>
Subject: [Openvpn-devel] [PATCH 1/2] Fix IPv6 in port-share journal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

getpeername() and getsockname() will truncate the result if it is
larger than the passed-in length. Because here always the size of the
`sa` IPv4 union member was passed in, all larger (aka IPv6) results
were truncated. Instead use the size of the `addr` union, which is the
maximum size of all union members.

The bug was introduced in 0b6450c9.

Fixes https://community.openvpn.net/openvpn/ticket/1358

Signed-off-by: corubba <corubba@...68...>
---
 src/openvpn/ps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 4ca3a129..06bf91a8 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -344,8 +344,8 @@ journal_add(const char *journal_dir, struct proxy_conne=
ction *pc, struct proxy_c
     char *jfn;
     int fd;

-    slen =3D sizeof(from.addr.sa);
-    dlen =3D sizeof(to.addr.sa);
+    slen =3D sizeof(from.addr);
+    dlen =3D sizeof(to.addr);
     if (!getpeername(pc->sd, (struct sockaddr *) &from.addr.sa, &slen)
         && !getsockname(cp->sd, (struct sockaddr *) &to.addr.sa, &dlen))
     {
--
2.47.1

