From: Matthias Andree <matthias.andree@...68...>
Date: Fri, 27 Jan 2023 21:32:08 +0100
Message-Id: <20230127203208.305638-1-matthias.andree@...68...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] make dist: Ship ovpn_dco_freebsd.h, too
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
Cc: Matthias Andree <matthias.andree@...68...>

This file was missing from src/openvpn/Makefile.am.
---
 src/openvpn/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 3ed73fa4..a8e44528 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -78,6 +78,7 @@ openvpn_SOURCES =3D \
 	mbuf.c mbuf.h \
 	memdbg.h \
 	misc.c misc.h \
+	ovpn_dco_freebsd.h \
 	ovpn_dco_linux.h \
 	ovpn_dco_win.h \
 	platform.c platform.h \
--
2.39.1


