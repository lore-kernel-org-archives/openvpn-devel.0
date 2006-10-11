From: Roy Marples <uberlord@...594...>
Date: Wed, 11 Oct 2006 13:19:43 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fFOLFcxscqXf+VU"
Message-Id: <200610111319.43536.uberlord@...594...>
Subject: [Openvpn-devel] [PATCH] Use PAM correctly
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_fFOLFcxscqXf+VU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi List!

openvpn pam plugin does not use PAM correctly. Namely it requires a private 
LinuxPAM header and links using -ldl which is Linux only.

Attached is a trivial patch that removes this private header and links 
using -lpam.

This enables openvpn pam plugin to compile correctly on default LinuxPAM and 
OpenPAM installs.

Thanks

-- 
Roy Marples <uberlord@...594...>
Gentoo/Linux Developer (baselayout, networking)

--Boundary-00=_fFOLFcxscqXf+VU
Content-Type: text/x-diff; charset="us-ascii"; name="openvpn-2.0.7-pam.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openvpn-2.0.7-pam.patch"

We should use pam property - this works on both LinuxPAM and OpenPAM

diff -ur openvpn-2.0.7.orig/plugin/auth-pam/Makefile openvpn-2.0.7/plugin/auth-pam/Makefile
--- openvpn-2.0.7.orig/plugin/auth-pam/Makefile	2005-11-02 18:02:49 +0000
+++ openvpn-2.0.7/plugin/auth-pam/Makefile	2006-10-11 12:05:55 +0100
@@ -4,7 +4,7 @@
 
 # If PAM modules are not linked against libpam.so, set DLOPEN_PAM to 1. This
 # must be done on SUSE 9.1, at least.
-DLOPEN_PAM=1
+DLOPEN_PAM=0
 
 ifeq ($(DLOPEN_PAM),1)
 	LIBPAM=-ldl
diff -ur openvpn-2.0.7.orig/plugin/auth-pam/pamdl.c openvpn-2.0.7/plugin/auth-pam/pamdl.c
--- openvpn-2.0.7.orig/plugin/auth-pam/pamdl.c	2005-11-02 18:02:49 +0000
+++ openvpn-2.0.7/plugin/auth-pam/pamdl.c	2006-10-11 12:04:48 +0100
@@ -10,7 +10,6 @@
 #include <stdio.h>
 #include <dlfcn.h>
 #include <security/pam_appl.h>
-#include <security/_pam_macros.h>
 
 #include "pamdl.h"
 
@@ -74,7 +73,7 @@
     return real_pam_set_item(pamh, item_type, item);
 }
 
-int pam_get_item(const pam_handle_t *pamh, int item_type, const void **item)
+int pam_get_item(pam_handle_t *pamh, int item_type, const void **item)
 {
     int (*real_pam_get_item)(const pam_handle_t *, int, const void **);
     RESOLVE_PAM_FUNCTION(pam_get_item, int,

--Boundary-00=_fFOLFcxscqXf+VU--

