From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:45 +0200
Message-Id: <1330546342-17794-16-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 15/52] build: plugins: properly use CC,
	CFLAGS and LDFLAGS
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
 plugins/auth-pam/Makefile  |   14 ++++++++------
 plugins/defer/build        |    9 +++++----
 plugins/down-root/Makefile |   11 ++++++-----
 plugins/examples/build     |    9 +++++----
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/plugins/auth-pam/Makefile b/plugins/auth-pam/Makefile
index e69fe3f..d45a203 100755
--- a/plugins/auth-pam/Makefile
+++ b/plugins/auth-pam/Makefile
@@ -13,18 +13,20 @@ else
 endif
 
 # This directory is where we will look for openvpn-plugin.h
-INCLUDE=-I../..
+CPPFLAGS=-I../..
 
-CC_FLAGS=-O2 -Wall -DDLOPEN_PAM=$(DLOPEN_PAM)
+CC=gcc
+CFLAGS=-O2 -Wall
+DEFS = -DDLOPEN_PAM=$(DLOPEN_PAM)
 
 openvpn-auth-pam.so : auth-pam.o pamdl.o
-	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so auth-pam.o pamdl.o -lc $(LIBPAM)
+	$(CC) $(CFLAGS) -fPIC -shared $(LDFLAGS) -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so auth-pam.o pamdl.o -lc $(LIBPAM)
 
 auth-pam.o : auth-pam.c pamdl.h
-	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} auth-pam.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEFS) -fPIC -c auth-pam.c
 
 pamdl.o : pamdl.c pamdl.h
-	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} pamdl.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEFS) -fPIC -c pamdl.c
 
 clean :
-	rm -f *.o *.so
+	-rm -f *.o *.so
diff --git a/plugins/defer/build b/plugins/defer/build
index 5907afa..9629c11 100755
--- a/plugins/defer/build
+++ b/plugins/defer/build
@@ -6,9 +6,10 @@
 #
 
 # This directory is where we will look for openvpn-plugin.h
-INCLUDE="-I../.."
+CPPFLAGS="${CPPFLAGS:--I../..}"
 
-CC_FLAGS="-O2 -Wall -g"
+CC="${CC:-gcc}"
+CFLAGS="${CFLAGS:--O2 -Wall -g}"
 
-gcc $CC_FLAGS -fPIC -c $INCLUDE $1.c && \
-gcc $CC_FLAGS -fPIC -shared -Wl,-soname,$1.so -o $1.so $1.o -lc
+$CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
+$CC $CFLAGS -fPIC -shared $LDFLAGS -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/plugins/down-root/Makefile b/plugins/down-root/Makefile
index 5ce4ffb..9659b7f 100755
--- a/plugins/down-root/Makefile
+++ b/plugins/down-root/Makefile
@@ -3,15 +3,16 @@
 #
 
 # This directory is where we will look for openvpn-plugin.h
-INCLUDE=-I../..
+CPPFLAGS=-I../..
 
-CC_FLAGS=-O2 -Wall
+CC=gcc
+CFLAGS=-O2 -Wall
 
 down-root.so : down-root.o
-	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-down-root.so -o openvpn-down-root.so down-root.o -lc
+	$(CC) $(CFLAGS) -fPIC -shared $(LDFLAGS) -Wl,-soname,openvpn-down-root.so -o openvpn-down-root.so down-root.o -lc
 
 down-root.o : down-root.c
-	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} down-root.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c down-root.c
 
 clean :
-	rm -f *.o *.so
+	-rm -f *.o *.so
diff --git a/plugins/examples/build b/plugins/examples/build
index 5907afa..7605595 100755
--- a/plugins/examples/build
+++ b/plugins/examples/build
@@ -6,9 +6,10 @@
 #
 
 # This directory is where we will look for openvpn-plugin.h
-INCLUDE="-I../.."
+CPPFLAGS="${CPPFLAGS:--I../..}"
 
-CC_FLAGS="-O2 -Wall -g"
+CC="${CC:-gcc}"
+CFLAGS="${CFLAGS:--O2 -Wall -g}"
 
-gcc $CC_FLAGS -fPIC -c $INCLUDE $1.c && \
-gcc $CC_FLAGS -fPIC -shared -Wl,-soname,$1.so -o $1.so $1.o -lc
+$CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
+$CC $CFLAGS -fPIC -shared ${LDFLAS} -Wl,-soname,$1.so -o $1.so $1.o -lc
-- 
1.7.3.4


