From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:39 +0200
Message-Id: <1330546342-17794-10-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 09/52] cleanup: memcmp.c: remove unused
	source
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |    3 ---
 memcmp.c     |   43 -------------------------------------------
 2 files changed, 0 insertions(+), 46 deletions(-)
 delete mode 100644 memcmp.c

diff --git a/configure.ac b/configure.ac
index 25dcc37..1c4d66c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -564,9 +564,6 @@ else
 
 fi
 
-dnl Required library functions
-AC_FUNC_MEMCMP
-
 dnl
 dnl Check for res_init
 dnl
diff --git a/memcmp.c b/memcmp.c
deleted file mode 100644
index d921aac..0000000
--- a/memcmp.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include "syshead.h"
-
-#include "memdbg.h"
-
-int
-memcmp (const void *s1, const void *s2, size_t n)
-{
-  unsigned const char *p1 = s1, *p2 = s2;
-  int d;
-
-  if (n)
-    while (n-- > 0)
-      {
-	d = *p1++ - *p2++;
-	if (d != 0)
-	  return d;
-      }
-  return 0;
-}
-- 
1.7.3.4


