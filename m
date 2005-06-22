From: Simon Perreault <nomis80@...401...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...> <200506211059.31506.nomis80@...401...> <Pine.LNX.4.58.0506212216440.10675@...41...>
In-Reply-To: <Pine.LNX.4.58.0506212216440.10675@...41...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ltVuCS3XgLudUDU"
Message-Id: <200506220836.53588.nomis80@...401...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Jun 22 05:38:12 2005
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_ltVuCS3XgLudUDU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 22 June 2005 00:22, James Yonan wrote:
> Thanks for the analysis.  Because of the PAM bug, I think that
> openvpn-auth-pam will need to support the dlopen workaround for some time
> to come.

Yes, I have been thinking the same.

> Maybe the solution would be to set up an alternative Makefile 
> target that builds according to your patch, but leave the default for now
> as is.

Great idea. You'll find a new patch attached that does just this. A variable 
in the Makefile, DLOPEN_PAM, controls whether libpam.so is dlopened or linked 
in directly. I've set it to zero by default, and I suggest that you leave it 
that way. This makes the default Makefile work with newer, not broken PAM. 
The rationale is that you should have more work to do when you want to use a 
broken PAM than when you use a fixed one. And because broken PAM will be less 
often encountered as they are obsoleted by newer distro releases, this is the 
natural thing to do.

A good day to you!

--Boundary-00=_ltVuCS3XgLudUDU
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="openvpn-plugin-pam-link-with-pam-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openvpn-plugin-pam-link-with-pam-2.diff"

Index: plugin/auth-pam/Makefile
===================================================================
RCS file: /cvsroot/openvpn/openvpn/plugin/auth-pam/Makefile,v
retrieving revision 1.1
diff -u -p -r1.1 Makefile
--- plugin/auth-pam/Makefile	28 Nov 2004 19:22:09 -0000	1.1
+++ plugin/auth-pam/Makefile	22 Jun 2005 12:29:52 -0000
@@ -2,13 +2,23 @@
 # Build the OpenVPN auth-pam plugin module.
 #
 
+# If PAM modules are not linked against libpam.so, set DLOPEN_PAM to 1. This
+# must be done on SUSE 9.1, at least.
+DLOPEN_PAM=0
+
+ifeq ($(DLOPEN_PAM),1)
+	LIBPAM=-ldl
+else
+	LIBPAM=-lpam
+endif
+
 # This directory is where we will look for openvpn-plugin.h
 INCLUDE=-I../..
 
-CC_FLAGS=-O2 -Wall
+CC_FLAGS=-O2 -Wall -DDLOPEN_PAM=$(DLOPEN_PAM)
 
 openvpn-auth-pam.so : auth-pam.o pamdl.o
-	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so auth-pam.o pamdl.o -lc
+	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so auth-pam.o pamdl.o -lc $(LIBPAM)
 
 auth-pam.o : auth-pam.c pamdl.h
 	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} auth-pam.c
Index: plugin/auth-pam/auth-pam.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/plugin/auth-pam/auth-pam.c,v
retrieving revision 1.7
diff -u -p -r1.7 auth-pam.c
--- plugin/auth-pam/auth-pam.c	15 Jun 2005 16:54:55 -0000	1.7
+++ plugin/auth-pam/auth-pam.c	22 Jun 2005 12:29:52 -0000
@@ -27,6 +27,13 @@
  * privilege model.
  */
 
+#if DLOPEN_PAM
+#include <dlfcn.h>
+#include "pamdl.h"
+#else
+#include <security/pam_appl.h>
+#endif
+
 #include <stdio.h>
 #include <string.h>
 #include <ctype.h>
@@ -37,11 +44,9 @@
 #include <sys/wait.h>
 #include <fcntl.h>
 #include <signal.h>
-#include <dlfcn.h>
 #include <syslog.h>
 
 #include "openvpn-plugin.h"
-#include "pamdl.h"
 
 #define DEBUG(verb) ((verb) >= 7)
 
@@ -646,7 +651,9 @@ pam_server (int fd, const char *service,
 {
   struct user_pass up;
   int command;
+#if DLOPEN_PAM
   static const char pam_so[] = "libpam.so";
+#endif
 
   /*
    * Do initialization
@@ -654,6 +661,7 @@ pam_server (int fd, const char *service,
   if (DEBUG (verb))
     fprintf (stderr, "AUTH-PAM: BACKGROUND: INIT service='%s'\n", service);
 
+#if DLOPEN_PAM
   /*
    * Load PAM shared object
    */
@@ -663,6 +671,7 @@ pam_server (int fd, const char *service,
       send_control (fd, RESPONSE_INIT_FAILED);
       goto done;
     }
+#endif
 
   /*
    * Tell foreground that we initialized successfully
@@ -736,7 +745,9 @@ pam_server (int fd, const char *service,
     }
  done:
 
+#if DLOPEN_PAM
   dlclose_pam ();
+#endif
   if (DEBUG (verb))
     fprintf (stderr, "AUTH-PAM: BACKGROUND: EXIT\n");
 
Index: plugin/auth-pam/pamdl.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/plugin/auth-pam/pamdl.c,v
retrieving revision 1.2
diff -u -p -r1.2 pamdl.c
--- plugin/auth-pam/pamdl.c	3 Dec 2004 05:25:21 -0000	1.2
+++ plugin/auth-pam/pamdl.c	22 Jun 2005 12:29:52 -0000
@@ -1,3 +1,4 @@
+#if DLOPEN_PAM
 /*
  * If you want to dynamically load libpam using dlopen() or something,
  * then dlopen( ' this shared object ' ); It takes care of exporting
@@ -177,3 +178,4 @@ int pam_chauthtok(pam_handle_t *pamh, in
     RESOLVE_PAM_FUNCTION(pam_chauthtok, int, (pam_handle_t *, int), PAM_ABORT);
     return real_pam_chauthtok(pamh, flags);
 }
+#endif
Index: plugin/auth-pam/pamdl.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/plugin/auth-pam/pamdl.h,v
retrieving revision 1.1
diff -u -p -r1.1 pamdl.h
--- plugin/auth-pam/pamdl.h	28 Nov 2004 19:22:09 -0000	1.1
+++ plugin/auth-pam/pamdl.h	22 Jun 2005 12:29:52 -0000
@@ -1,5 +1,7 @@
+#if DLOPEN_PAM
 #include <security/pam_appl.h>
 
 /* Dynamically load and unload the PAM library */
 int dlopen_pam (const char *so);
 void dlclose_pam (void);
+#endif

--Boundary-00=_ltVuCS3XgLudUDU--

