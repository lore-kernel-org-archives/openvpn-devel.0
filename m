From: Simon Perreault <nomis80@...401...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...>
In-Reply-To: <200506141234.50171.nomis80@...401...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OCxrCsjJ1t7bO4E"
Message-Id: <200506141314.54183.nomis80@...401...>
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
Date: Tue Jun 14 10:17:06 2005
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_OCxrCsjJ1t7bO4E
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 14 June 2005 12:34, Simon Perreault wrote:
> I am wondering why the PAM library is dlopened by the auth-pam plugin. Why
> can't it simply be linked with it?

More specifically, why can't the attached patch be applied?

--Boundary-00=_OCxrCsjJ1t7bO4E
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="openvpn-plugin-pam-link-with-pam.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openvpn-plugin-pam-link-with-pam.diff"

Index: Makefile
===================================================================
RCS file: /cvsroot/openvpn/openvpn/plugin/auth-pam/Makefile,v
retrieving revision 1.1
diff -u -p -r1.1 Makefile
--- Makefile	28 Nov 2004 19:22:09 -0000	1.1
+++ Makefile	14 Jun 2005 17:10:05 -0000
@@ -7,14 +7,11 @@ INCLUDE=-I../..
 
 CC_FLAGS=-O2 -Wall
 
-openvpn-auth-pam.so : auth-pam.o pamdl.o
-	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so auth-pam.o pamdl.o -lc
+openvpn-auth-pam.so : auth-pam.o
+	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so auth-pam.o -lc -lpam
 
-auth-pam.o : auth-pam.c pamdl.h
+auth-pam.o : auth-pam.c
 	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} auth-pam.c
 
-pamdl.o : pamdl.c pamdl.h
-	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} pamdl.c
-
 clean :
 	rm -f *.o *.so
Index: auth-pam.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/plugin/auth-pam/auth-pam.c,v
retrieving revision 1.6
diff -u -p -r1.6 auth-pam.c
--- auth-pam.c	12 Jun 2005 08:01:24 -0000	1.6
+++ auth-pam.c	14 Jun 2005 17:10:05 -0000
@@ -27,6 +27,8 @@
  * privilege model.
  */
 
+#include <security/pam_appl.h>
+
 #include <stdio.h>
 #include <string.h>
 #include <ctype.h>
@@ -37,11 +39,9 @@
 #include <sys/wait.h>
 #include <fcntl.h>
 #include <signal.h>
-#include <dlfcn.h>
 #include <syslog.h>
 
 #include "openvpn-plugin.h"
-#include "pamdl.h"
 
 #define DEBUG(verb) ((verb) >= 4) // JYFIXME (should be 7)
 
@@ -646,7 +646,6 @@ pam_server (int fd, const char *service,
 {
   struct user_pass up;
   int command;
-  static const char pam_so[] = "libpam.so";
 
   /*
    * Do initialization
@@ -655,16 +654,6 @@ pam_server (int fd, const char *service,
     fprintf (stderr, "AUTH-PAM: BACKGROUND: INIT service='%s'\n", service);
 
   /*
-   * Load PAM shared object
-   */
-  if (!dlopen_pam (pam_so))
-    {
-      fprintf (stderr, "AUTH-PAM: BACKGROUND: could not load PAM lib %s: %s\n", pam_so, dlerror());
-      send_control (fd, RESPONSE_INIT_FAILED);
-      goto done;
-    }
-
-  /*
    * Tell foreground that we initialized successfully
    */
   if (send_control (fd, RESPONSE_INIT_SUCCEEDED) == -1)
@@ -736,7 +725,6 @@ pam_server (int fd, const char *service,
     }
  done:
 
-  dlclose_pam ();
   if (DEBUG (verb))
     fprintf (stderr, "AUTH-PAM: BACKGROUND: EXIT\n");
 

--Boundary-00=_OCxrCsjJ1t7bO4E--

