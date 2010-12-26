Message-ID: <4D177C14.4040300@...1030...>
Date: Sun, 26 Dec 2010 17:32:04 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070805040003050205040709"
Subject: [Openvpn-devel] [OpenVPN 2.1.4 BUG]: hard-coded values in Makefiles
 for down-root and auth-pam plugins prevent cross compilation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070805040003050205040709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Due to the fact that I have spent the last two and a half hours trying 
to find a place where to submit a bug report via the Trac system 
(https://community.openvpn.net/openvpn) - and failing, miserably so - I 
am submitting it here!

In this version of OpenVPN, the Makefiles for the above plugins contain 
hard-coded compile/link parameters, which prevent cross compilation.

For example, during building openvpn-down-root.so the value of the c/c++ 
compiler is assumed to be gcc, along with various other settings (CLFAGS 
being set as "-O2 and -Wall" and LDFLAGS as "-shared -Wl,-soname"), 
disregarding the rest, therefore ruining any possibility of cross 
compilation as the file produced will have the same attributes as the 
build system!

If I build OpenVPN on x86_64-based machine to be executed on i686 the 
two Makefiles will produce code for x86_64, despite the openvpn 
executable being produced, correctly, for the i686 host system. Thus, 
the produced 'package' will introduce at least 2 additional - and highly 
undesired - dependencies, namely: glibc (x86_64) and libpam (x86_64).

To prevent that I am enclosing a patch, which although fixes this 
problem I am of the opinion that it could be optimised further to 
co-exist with the rest of the build system and be auto-generated, though 
I will leave that with the developers to decide what is the best way to 
proceed and fix this bug.



--------------070805040003050205040709
Content-Type: text/plain;
 name="openvpn-2.1.4-plugins.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-2.1.4-plugins.patch"

diff -NurBb openvpn-2.1.4/plugin/auth-pam/Makefile a/plugin/auth-pam/Makefile
--- openvpn-2.1.4/plugin/auth-pam/Makefile	2010-10-21 18:37:51.000000000 +0100
+++ a/plugin/auth-pam/Makefile	2010-12-26 01:57:45.345754000 +0000
@@ -15,16 +15,14 @@
 # This directory is where we will look for openvpn-plugin.h
 INCLUDE=-I../..
 
-CC_FLAGS=-O2 -Wall -DDLOPEN_PAM=$(DLOPEN_PAM)
-
 openvpn-auth-pam.so : auth-pam.o pamdl.o
-	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so auth-pam.o pamdl.o -lc $(LIBPAM)
+	${CC} -DDLOPEN_PAM=$(DLOPEN_PAM) -fPIC -shared ${LDFLAGS} -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so auth-pam.o pamdl.o -lc $(LIBPAM)
 
 auth-pam.o : auth-pam.c pamdl.h
-	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} auth-pam.c
+	${CC} ${CFLAGS} -DDLOPEN_PAM=$(DLOPEN_PAM) -fPIC -c ${INCLUDE} auth-pam.c
 
 pamdl.o : pamdl.c pamdl.h
-	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} pamdl.c
+	${CC} ${CFLAGS} -DDLOPEN_PAM=$(DLOPEN_PAM) -fPIC -c ${INCLUDE} pamdl.c
 
 clean :
 	rm -f *.o *.so
diff -NurBb openvpn-2.1.4/plugin/down-root/Makefile a/plugin/down-root/Makefile
--- openvpn-2.1.4/plugin/down-root/Makefile	2010-10-21 18:37:51.000000000 +0100
+++ a/plugin/down-root/Makefile	2010-12-26 01:58:07.976755000 +0000
@@ -5,13 +5,11 @@
 # This directory is where we will look for openvpn-plugin.h
 INCLUDE=-I../..
 
-CC_FLAGS=-O2 -Wall
-
 down-root.so : down-root.o
-	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-down-root.so -o openvpn-down-root.so down-root.o -lc
+	${CC} -fPIC -shared ${LDFLAGS} -Wl,-soname,openvpn-down-root.so -o openvpn-down-root.so down-root.o -lc
 
 down-root.o : down-root.c
-	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} down-root.c
+	${CC} ${CFLAGS} -fPIC -c ${INCLUDE} down-root.c
 
 clean :
 	rm -f *.o *.so

--------------070805040003050205040709--

