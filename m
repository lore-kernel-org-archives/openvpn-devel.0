Message-ID: <4CDD63D3.2000902@...515...>
Date: Fri, 12 Nov 2010 17:57:07 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070702000902070105050702"
Subject: [Openvpn-devel] [PATCH] Added check for variable CONFIGURE_DEFINES
	into options.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070702000902070105050702
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit



--------------070702000902070105050702
Content-Type: text/x-patch;
	name="0001-Added-check-for-variable-CONFIGURE_DEFINES-into-opti.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0001-Added-check-for-variable-CONFIGURE_DEFINES-into-opti.pa";
	filename*1="tch"

From 327d6c66fff6962a96f86110dc91b1dad07ca224 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 12 Nov 2010 17:30:07 +0200
Subject: [PATCH] Added check for variable CONFIGURE_DEFINES into options.c

The file containing CONFIGURE_DEFINES variable, configure.h, is not present if
openvpn is built using the Python + Visual C -based buildsystem. This causes the
build to fail. This patch adds a check to see if variable exists before trying
to use it.
---
 options.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/options.c b/options.c
index 717c5d7..29243f6 100644
--- a/options.c
+++ b/options.c
@@ -2929,8 +2929,10 @@ usage_version (void)
 #ifdef CONFIGURE_CALL
   msg (M_INFO|M_NOPREFIX, "\n%s\n", CONFIGURE_CALL);
 #endif
+#ifdef CONFIGURE_DEFINES
   msg (M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
 #endif
+#endif
   openvpn_exit (OPENVPN_EXIT_STATUS_USAGE); /* exit point */
 }
 
-- 
1.6.3.3


--------------070702000902070105050702--

