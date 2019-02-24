From: Simon Rozman <simon@...2293...>
Date: Sun, 24 Feb 2019 19:55:00 +0100
Message-Id: <20190224185500.45300-1-simon@...2293...>
In-Reply-To: <201901181957.x0IJvlQ2003900@...2054...>
References: <201901181957.x0IJvlQ2003900@...2054...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add developer notes URL for openvpnmsica.dll
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

This patch follows Gert's recommendations from [openvpn-devel].

Signed-off-by: Simon Rozman <simon@...2293...>
Message-ID: <201901181957.x0IJvlQ2003900@...2054...>
---
 src/openvpnmsica/dllmain.c      | 1 +
 src/openvpnmsica/msica_op.c     | 1 +
 src/openvpnmsica/msica_op.h     | 1 +
 src/openvpnmsica/msiex.c        | 1 +
 src/openvpnmsica/msiex.h        | 1 +
 src/openvpnmsica/openvpnmsica.c | 1 +
 src/openvpnmsica/openvpnmsica.h | 1 +
 7 files changed, 7 insertions(+)

diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index 5e29f44c..201fd9af 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -1,5 +1,6 @@
 /*
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
  *
diff --git a/src/openvpnmsica/msica_op.c b/src/openvpnmsica/msica_op.c
index 8912e92a..3b9878dc 100644
--- a/src/openvpnmsica/msica_op.c
+++ b/src/openvpnmsica/msica_op.c
@@ -1,5 +1,6 @@
 /*
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
  *
diff --git a/src/openvpnmsica/msica_op.h b/src/openvpnmsica/msica_op.h
index 7ce80519..eaf7596c 100644
--- a/src/openvpnmsica/msica_op.h
+++ b/src/openvpnmsica/msica_op.h
@@ -1,5 +1,6 @@
 /*
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
  *
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index 7e2bed3e..00265d04 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -1,5 +1,6 @@
 /*
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
  *
diff --git a/src/openvpnmsica/msiex.h b/src/openvpnmsica/msiex.h
index e9f98377..d819b875 100644
--- a/src/openvpnmsica/msiex.h
+++ b/src/openvpnmsica/msiex.h
@@ -1,5 +1,6 @@
 /*
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
  *
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index b134bc9b..f5ad2295 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -1,5 +1,6 @@
 /*
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
  *
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index d6a09127..1486c043 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -1,5 +1,6 @@
 /*
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
  *
-- 
2.19.0.windows.1


