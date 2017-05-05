From: David Sommerseth <davids@...515...>
Date: Fri,  5 May 2017 17:21:22 +0200
Message-Id: <20170505152122.24169-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] plugins: Replace defer/simple with an
	improved replacement
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

The defer-w-pf plug-in is a complete rewrite of the simple.c, which
moves the plug-in over to the newer Plug-in v3 API.  In addition, it
improves the example by adding a lot more comments and code
documentation.  And it avoids using system() and rather more realistic
approaches by using POSIX threads and also fork().

Also replaced the ./build script with a Makefile for the *nix family
of users.  Mostly as Makefiles are far more common to build projects
than some script.  It is _not_ tied into the autotools fold, though,
as this plug-in may be packaged into development packages in OS
distributions - which will not carry the rest of the OpenVPN code base.

Signed-off-by: David Sommerseth <davids@...515...>

---
v2 - Fixed doxygen syntax errors
   - Added even more doxygen comments on undocumented parts
   - Replaced atoi_null0() with str2uint() using strtol() with
     some results checking and logging parsing errors
   - Changed returns to breaks in a switch()
   - Rescoped FILE *authres
   - Use proper FSF address in the copyright
---
 sample/sample-plugins/defer/Makefile               |   14 +
 sample/sample-plugins/defer/README                 |   56 +-
 sample/sample-plugins/defer/build                  |   15 -
 sample/sample-plugins/defer/defer-w-pf.c           | 1062 ++++++++++++++++=
++++
 .../defer/{simple.def =3D> defer-w-pf.def}           |    0
 sample/sample-plugins/defer/simple.c               |  340 -------
 6 files changed, 1122 insertions(+), 365 deletions(-)
 create mode 100644 sample/sample-plugins/defer/Makefile
 delete mode 100755 sample/sample-plugins/defer/build
 create mode 100644 sample/sample-plugins/defer/defer-w-pf.c
 rename sample/sample-plugins/defer/{simple.def =3D> defer-w-pf.def} (100%)
 delete mode 100644 sample/sample-plugins/defer/simple.c

diff --git a/sample/sample-plugins/defer/Makefile b/sample/sample-plugins/d=
efer/Makefile
new file mode 100644
index 00000000..abb315a7
--- /dev/null
+++ b/sample/sample-plugins/defer/Makefile
@@ -0,0 +1,14 @@
+
+CFLAGS =3D -I../../../include -O2 -Wall -g -std=3Dc99 -pthread -fPIC
+LDFLAGS =3D -fPIC -pthread
+
+all : defer-w-pf.so
+
+defer-w-pf.so : defer-w-pf.o
+	$(CC) -shared $(LDFLAGS) -o $@ $^
+
+.c.o :
+	$(CC) -c $(CFLAGS) $<
+
+clean :
+	rm -f *.o *.so
diff --git a/sample/sample-plugins/defer/README b/sample/sample-plugins/def=
er/README
index d8990f8b..69038740 100644
--- a/sample/sample-plugins/defer/README
+++ b/sample/sample-plugins/defer/README
@@ -1,16 +1,52 @@
-OpenVPN plugin examples.
+OpenVPN plugin examples
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Examples provided:
+defer-w-pf.c
+------------
=20
-simple.c -- using the --auth-user-pass-verify callback,
-            test deferred authentication.
+A (stupid and) simple plug-in which authenticates a password only.  In
+addition it supports enabling the Packet Filter (PF) in OpenVPN, by making
+use of the username for selecting the PF profile to load for the session.
=20
-To build:
+To test this plugin, add the following lines to an OpenVPN configuration f=
ile:
=20
-  ./build simple (Linux/BSD/etc.)
-  ./winbuild simple (MinGW on Windows)
+   setenv test_deferred_auth 20
+   setenv test_packet_filter 10
+   plugin defer-w-pw.so
+
+This will enable deferred authentication to occur 20 seconds after the nor=
mal
+TLS authentication process.  To disable testing deferred authentication, r=
emove
+the first setenv line.
+
+NOTICE: The password authentication is EXTREMELY na=C4=A9ve, and is hard c=
oded
+to be 'foobar' (without the quotes).  Any username will be accepted.  This
+is by design, as this is an example plug-in NOT meant for production.
+
+The second setenv line will enable a packet filter file to be generated
+10 seconds after the initial TLS negotiation, using {username}.pf as the
+source.  To disable the PF feature, remove the second setenv line.
+
+OpenVPN should respond to other connected clients without much added laten=
cy,
+as both the authentication and PF generation features should run in a para=
llel
+thread and not block the main OpenVPN thread.
+
+* Sample packet filter configuration:
+
+    [CLIENTS DROP]
+    +otherclient
+    [SUBNETS DROP]
+    +10.0.0.0/8
+    -10.10.0.8
+    [END]
+
+* Building the plug-in
+
+On Linux/BSD:
+
+   $ make defer-w-pf.so
+
+Building for Windows using mingw:
+
+   $ ./winbuild defer-w-pf
=20
-To use in OpenVPN, add to config file:
=20
-  plugin simple.so (Linux/BSD/etc.)
-  plugin simple.dll (MinGW on Windows)
diff --git a/sample/sample-plugins/defer/build b/sample/sample-plugins/defe=
r/build
deleted file mode 100755
index ba41a39f..00000000
--- a/sample/sample-plugins/defer/build
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/bin/sh
-
-#
-# Build an OpenVPN plugin module on *nix.  The argument should
-# be the base name of the C source file (without the .c).
-#
-
-# This directory is where we will look for openvpn-plugin.h
-CPPFLAGS=3D"${CPPFLAGS:--I../../../include}"
-
-CC=3D"${CC:-gcc}"
-CFLAGS=3D"${CFLAGS:--O2 -Wall -g}"
-
-$CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
-$CC $CFLAGS -fPIC -shared ${LDFLAGS} -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/sample/sample-plugins/defer/defer-w-pf.c b/sample/sample-plugi=
ns/defer/defer-w-pf.c
new file mode 100644
index 00000000..1a1a12e5
--- /dev/null
+++ b/sample/sample-plugins/defer/defer-w-pf.c
@@ -0,0 +1,1062 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *                     2017 David Sommerseth <davids@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/*
+ * This file implements a simple OpenVPN plugin module which
+ * will test deferred authentication and packet filtering.
+ *
+ * This plug-in is a complete rewrite of the older simple.c plug-in,
+ * making use of the newe Plugin v3 API.
+ *
+ * For more information, see the README file
+ *
+ */
+
+#define PLUGIN_NAME "defer/defer-w-pf.c"  /**< The name of this plug-in */
+
+#define _POSIX_C_SOURCE 200809L   /**< Needed to enable strdup() in C99 mo=
de */
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <limits.h>
+#include <pthread.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include "openvpn-plugin.h"
+
+/**
+ * Global context for this plug-in
+ */
+struct plugin_context {
+    int test_deferred_auth;  /**< If > 0, deferred auth is tested */
+    int test_packet_filter;  /**< If > 0, PF integration is tested */
+};
+
+/**
+ * Context used per connected session
+ */
+struct plugin_per_client_context {
+    bool pf_running;         /**< Is the PF thread running? */
+    pthread_t pfthread;      /**< pthread object of running PF thread */
+    int pf_delay;            /**< PF thread sleep delay before acting */
+    char *pf_file;           /**< Destination file of the PF filter profil=
e */
+    bool generated_pf_file;  /**< Have the PF file been generated? */
+
+    bool auth_running;       /**< Is the auth thread running? */
+    pthread_t auththread;    /**< pthread object of the running auth threa=
d */
+    int  auth_delay;         /**< Auth thread sleep delay before acting */
+    char *auth_control_file; /**< File name where to write auth status */
+    char *auth_uname;        /**< User name to use for authentication */
+    char *auth_passw;        /**< Password to use for authentication */
+};
+
+
+/* plug-in v3 API log functions */
+plugin_log_t ovpn_log =3D NULL;     /**< Pointer to the OpenVPN log functi=
on.  See plugin_log() */
+plugin_vlog_t ovpn_vlog =3D NULL;   /**< Pointer to the OpenVPN vlog funct=
ion. See plugin_vlog() */
+
+/**
+ *  Modules in this plug-in
+ */
+typedef enum {
+    MOD_AUTH,  /**< Authentication module */
+    MOD_PF     /**< Packet Filter (PF) module */
+} module_type;
+
+/**
+ * Search the environment pointer for a specific env var name
+ *
+ * PLEASE NOTE! The result is not valid outside the local
+ * scope of the calling function.  Once the calling function
+ * returns, any returned pointers are invalid.
+ *
+ * @param name  String containing the env.var name to search for
+ * @param envp  String array pointer to the environment variable
+ *
+ * @return Returns a pointer to the value in the environment variable
+ *         table on successful match.  Otherwise NULL is returned
+ *
+ */
+static const char *
+get_env(const char *name, const char *envp[])
+{
+    if (envp)
+    {
+        int i;
+        const int namelen =3D strlen(name);
+        for (i =3D 0; envp[i]; ++i)
+        {
+            if (!strncmp(envp[i], name, namelen))
+            {
+                const char *cp =3D envp[i] + namelen;
+                if (*cp =3D=3D '=3D')
+                {
+                    return cp + 1;
+                }
+            }
+        }
+    }
+    return NULL;
+}
+
+/**
+ * Simple function ensuring callers of np() won't be hit by a NULL
+ * pointer on strings pointers.
+ *
+ * @param str  String to control
+ *
+ * @return Returns the pointer to str if str is not NULL.  Otherwise
+ *         it will point at the static string "[NULL]".
+ */
+static const char *
+np(const char *str)
+{
+    return (str !=3D NULL ? str : "[NULL]");
+}
+
+/**
+ * Safe processing of string to unsigned int conversion.
+ *
+ * @param str  Pointer to the string buffer containing the value to
+ *             be converted
+ *
+ * @return Returns an unsigned int.  In case of critical errors, the result
+ *         will be 0. Otherwise the value will always be between 0 and
+ *         UINT_MAX.
+ */
+static unsigned int
+str2uint(const char *str)
+{
+    if (str)
+    {
+        char *eptr =3D NULL;
+        long int ret =3D strtol(str, &eptr, 10);
+
+        if (str =3D=3D eptr)
+        {
+            ovpn_log(PLOG_WARN, PLUGIN_NAME,
+                     "Failed to extract a number out of '%s'. "
+                     "Result will be 0.",
+                     str);
+            ret =3D 0;
+        }
+        else if (*eptr !=3D 0)
+        {
+            ovpn_log(PLOG_WARN, PLUGIN_NAME,
+                     "The string '%s' contains more than a number. "
+                     "Using  %ld for further processing.",
+                     str, ret);
+        }
+
+        /* Restrict the value range from 0 to UINT_MAX.
+         *
+         * It might in some cases make sense to check errno !=3D ERANGE,
+         * but in this case, our scope is much smaller.  Plus we don't
+         * do any really special error handling than printing some
+         * warnings to the log
+         *
+         */
+        if (ret >=3D UINT_MAX)
+        {
+            ovpn_log(PLOG_WARN, PLUGIN_NAME,
+                     "The string '%s' is a number higher than the maximum "
+                     "value %u.  Capping to maximum value.",
+                     str, UINT_MAX);
+            ret =3D UINT_MAX;
+        }
+        else if (ret < 0)
+        {
+            ovpn_log(PLOG_WARN, PLUGIN_NAME,
+                     "The string '%s' is a number lower than 0. "
+                     "Result will be 0.",
+                     str);
+            ret =3D 0;
+        }
+
+        return (unsigned int) ret;
+    }
+
+    /* If input string is NULL ... */
+    return 0;
+}
+
+/**
+ * Cancel a running authentication or pf thread
+ *
+ * @param module   Thread module type to cancel, MOD_AUTH or MOD_PF
+ * @param pcc      Pointer to the client specific context, with information
+ *                 about the thread to cancel
+ *
+ * @return Returns OPENVPN_PLUGIN_FUNC_SUCCESS on success, otherwise
+ *         OPENVPN_PLUGIN_FUNC_ERROR
+ */
+static int
+cancel_thread(module_type module, struct plugin_per_client_context *pcc)
+{
+    int s;
+    pthread_t modthread =3D NULL;
+    char *module_str =3D NULL;
+    bool *running =3D NULL;
+
+    switch (module)
+    {
+    case MOD_AUTH:
+        modthread =3D pcc->auththread;
+        running =3D &pcc->auth_running;
+        module_str =3D "authentication";
+        break;
+
+    case MOD_PF:
+        modthread =3D pcc->pfthread;
+        running =3D &pcc->pf_running;
+        module_str =3D "pf";
+        break;
+    }
+
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME,
+             "Another %s thread is detected. "
+             "Cancelling that thread and waiting until it "
+             "has stopped", module_str);
+
+    s =3D pthread_cancel(modthread);
+    if (s)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "** ERROR ** Failed to cancel other "
+                 "%s thread: %s",
+                 module_str, strerror(s));
+
+        /* Bailing out, to avoid more problems */
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    s =3D pthread_join(modthread, NULL);
+    if (s)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "** ERROR ** Failed to wait for other "
+                 "%s thread to complete: %s",
+                 module_str, strerror(s));
+    }
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME,
+             "The other %s thread have "
+             "been cancelled",
+             module_str);
+    *running =3D false;
+
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+}
+
+
+/**
+ * Free memory used in the client specific context for the authentication =
or pf
+ * processing threads
+ *
+ * @param module   Thread module type to release memory for, MOD_AUTH or M=
OD_PF
+ * @param pcc      Pointer to the client specific context to use for this
+ *                 operation
+ *
+ */
+static void
+free_thread_data(module_type module, struct plugin_per_client_context *pcc)
+{
+    if (!pcc) {
+        return;
+    }
+
+    switch (module)
+    {
+    case MOD_AUTH:
+        if (pcc->auth_control_file)
+        {
+            free(pcc->auth_control_file);
+            pcc->auth_control_file =3D NULL;
+        }
+        if (pcc->auth_uname)
+        {
+            free(pcc->auth_uname);
+            pcc->auth_uname =3D NULL;
+        }
+        if (pcc->auth_passw)
+        {
+            free(pcc->auth_passw);
+            pcc->auth_uname =3D NULL;
+        }
+        break;
+
+    case MOD_PF:
+        if (pcc->pf_file)
+        {
+            free(pcc->pf_file);
+            pcc->pf_file =3D NULL;
+        }
+        if (pcc->auth_uname)
+        {
+            free(pcc->auth_uname);
+            pcc->auth_uname =3D NULL;
+        }
+        break;
+    }
+}
+
+/**
+ * Main worker thread for Password authentication
+ *
+ * @param thread_data  Pointer to the client specific context with informa=
tion for the
+ *                     authentication process
+ *
+ * @return This thread does not return any information, and always exits b=
y calling
+ *         pthread_exit(NULL);
+ */
+static void *
+authentication_thread(void *thread_data)
+{
+    struct plugin_per_client_context *pcc =3D (struct plugin_per_client_co=
ntext *) thread_data;
+    int s;
+
+    if (!pcc || !pcc->auth_control_file || !pcc->auth_passw || !pcc->auth_=
uname)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[child:Auth] ** ERROR **  No proper client context buffe=
r received (Authentication)");
+        pthread_exit(NULL);
+    }
+
+    /* Make it possible to cancel this thread, if another authentication
+     * process is attempted in the same context.  This can happen if the
+     * initial authentication request is aborted by the user and then
+     * starting a new one before this thread have completed.
+     */
+    s =3D pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
+    if (s)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[child:Auth] ** ERROR ** Failed to set thread cancel sta=
te: %s",
+                 strerror(s));
+        /* For this demonstration plug-in, we ignore this error */
+    }
+    s =3D pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+    if (s)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[child:Auth] ** ERROR ** Failed to set thread cancel typ=
e: %s",
+                 strerror(s));
+        /* For this demonstration plug-in, we ignore this error */
+    }
+
+    /*
+     * Start the authentication phase
+     */
+
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "[child:Auth] Sleeping %i seconds",
+             pcc->auth_delay);
+    pcc->auth_running =3D true;
+    sleep(pcc->auth_delay);
+
+    /* This file needs to be created by the plug-in, to report back
+     * the authentication result
+     */
+    FILE *authres =3D fopen(pcc->auth_control_file, "w");
+    if (!authres)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[child:Auth] ** ERROR ** Failed to open auth control fil=
e (%s)",
+                 pcc->auth_control_file);
+        pthread_exit(NULL);
+    }
+
+    /* WARNING: Extremely simple and stupid user authentication.
+     *
+     * This password check only checks if the password is 'foobar' or not.
+     *
+     * The reason we here don't check the username, is so the
+     * PF thread can be tested too, which will use the username when
+     * installing a PF filter.  This makes it easier to test a variety
+     * of PF configurations without adding several hard coded usernames
+     * and passwords.
+     *
+     */
+    int res =3D (pcc->auth_passw !=3D NULL && 0 =3D=3D strcmp(pcc->auth_pa=
ssw, "foobar") ? 1 : 0);
+
+    /* Report authentication result back to OpenVPN.
+     * Successful authentication =3D=3D 1, failed =3D=3D 0
+     */
+    fprintf(authres, "%i\n", res);
+    fclose(authres);
+
+    /* WARNING: The line below LOGS PASSWORDS
+     * This is just for demonstration/debug purpose.
+     *
+     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+     * !!  DO NOT DO THIS IN A REAL AUTHENTICATION PLUGIN !!
+     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+     *
+     */
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME,
+             "[child:Auth]: AUTH completed - %s u: '%s'  p: '%s' [%i]",
+             pcc->auth_control_file, pcc->auth_uname, pcc->auth_passw, res=
);
+
+
+    /* Wipe the password from memory
+     *
+     *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+     *  !! DO NOT be tempted to use memset() for this, many compilers !!
+     *  !! may remove that call when optimizing the code result.      !!
+     *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+     *
+     * WARNING:  This apprach here is SIMPLISTIC.  See secure_memzero()
+     *           in the OpenVPN source code (src/openvpn/buffer.h) for an
+     *           even better implementation.
+     *
+     */
+    if (pcc->auth_passw)
+    {
+        for (char *p =3D pcc->auth_passw + strlen(pcc->auth_passw);
+             p >=3D pcc->auth_passw; p-- )
+        {
+            *p =3D 0;
+        }
+        free(pcc->auth_passw);
+        pcc->auth_passw =3D NULL;
+    }
+
+    pcc->auth_running =3D false;
+    pthread_exit(NULL);
+}
+
+
+/**
+ * Main function for deferred password authentication
+ *
+ * @param context   Pointer to the plug-in global context
+ * @param pcc       Pointer from OpenVPN pointing at a client session
+ *                  specific context
+ * @param argv      Pointer to the argument vectors for the plug-in
+ *                  configuration
+ * @param envp      Pointer to the environment variable vectors prepared
+ *                  by OpenVPN.  Contains session and configuration specif=
ic
+ *                  details.
+ *
+ * @return Returns OPENVPN_PLUGIN_FUNC_SUCCESS if the password authenticat=
ion
+ *                 have not been configured (test_deferred_auth < 1)
+ *         Returns OPENVPN_PLUGIN_FUNC_DEFERRED if a authentication thread
+ *                 have been successfully started.  This thread will
+ *                 asynchronously return the authentication result directly
+ *                 to OpenVPN
+ *         Otherwise OPENVPN_PLUGIN_FUNC_ERROR is returned in error situat=
ions.
+ */
+static int
+auth_user_pass_verify(struct plugin_context *context,
+                      struct plugin_per_client_context *pcc,
+                      const char *argv[], const char *envp[])
+{
+    if (context->test_deferred_auth < 1)
+    {
+        /* No authentication thread was requested.
+         *
+         * This is requested by adding --setenv test_deferred_auth $sec
+         * in the OpenVPN configuration, where $sec is number of seconds t=
he
+         * authentication should be delayed
+         *
+         * In this case we must return with success, otherwise the client
+         * connection will be rejected.
+         */
+        return OPENVPN_PLUGIN_FUNC_SUCCESS;
+    }
+
+    /* get username/password/auth_control_file from envp string array */
+    const char *username =3D get_env("username", envp);
+    const char *password =3D get_env("password", envp);
+    const char *auth_control_file =3D get_env("auth_control_file", envp);
+
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "DEFER u=3D'%s' p=3D'%s' acf=3D'%s'",
+             np(username),
+             np(password),
+             np(auth_control_file));
+
+    /* Ensure we have the needed information */
+    if (!username || !password || !auth_control_file)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[parent:Auth] Missing username, password or auth_control=
_file "
+                 "information needed for the authentication");
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+
+    /* To avoid back-clash between multiple auth-treads on the same client
+     * context, don't start a new one
+     *
+     */
+    if (pcc->auth_running)
+    {
+        /* Cleaning up memory used by the other thread */
+        free_thread_data(MOD_AUTH, pcc);
+
+        if (cancel_thread(MOD_AUTH, pcc) =3D=3D OPENVPN_PLUGIN_FUNC_ERROR)
+        {
+            return OPENVPN_PLUGIN_FUNC_ERROR;
+        }
+    }
+
+    /* Information the authentication thread wil need.  It is important th=
at
+     * the memory buffers are created for each call, as once this function
+     * exits the environment variable pointers are no longer valid
+     */
+    pcc->auth_delay =3D context->test_deferred_auth;
+    pcc->auth_control_file =3D strdup(auth_control_file);
+    pcc->auth_running =3D false;
+    pcc->auth_uname =3D strdup(username);
+    pcc->auth_passw =3D strdup(password);
+
+    /*
+     * Start the authentication thread, which will be delayed
+     * test_deferred_auth seconds.
+     *
+     * WARNING:
+     * This implementation does not care how the authentication thread exi=
sts.
+     * A more proper and solid implementation would track this and report
+     * issues with these threads, outside of the authenticaion thread itse=
lf.
+     * This implementation _may_ result in a little memory leak due to thi=
s.
+     */
+    if (pthread_create(&pcc->auththread, NULL, authentication_thread, pcc))
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[parent:Auth] Failed to create authentication thread");
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    /* Signalize to OpenVPN that the authentication result is not yet read=
y */
+    return OPENVPN_PLUGIN_FUNC_DEFERRED;
+}
+
+
+/**
+ * Main worker thread for PF initialization
+ *
+ * @param thread_data  Pointer to the client specific context with informa=
tion for the
+ *                     pf init process
+ *
+ * @return This thread does not return any information, and always exits b=
y calling
+ *         pthread_exit(NULL);
+ */
+static void *
+pf_thread(void *thread_data)
+{
+    struct plugin_per_client_context *pcc =3D (struct plugin_per_client_co=
ntext *) thread_data;
+    int s;
+
+    if (!pcc || !pcc->pf_file || !pcc->auth_uname)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[child:PF] ** ERROR **  No proper client context buffer =
received");
+        pthread_exit(NULL);
+    }
+
+    /* Make it possible to cancel this thread, if another authentication
+     * process is attempted in the same context.  This can happen if the
+     * initial authentication request is aborted by the user and then
+     * starting a new one before this thread have completed.
+     */
+    s =3D pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
+    if (s)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[child:PF] ** ERROR ** Failed to set thread cancel state=
: %s",
+                 strerror(s));
+        /* For this demonstration plug-in, we ignore this error */
+    }
+    s =3D pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+    if (s)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[chilld:PF] ** ERROR ** Failed to set thread cancel type=
: %s",
+                 strerror(s));
+        /* For this demonstration plug-in, we ignore this error */
+    }
+
+    /*
+     * Start the authentication phase
+     */
+
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "[child:PF] Sleeping %i seconds",
+             pcc->pf_delay);
+    pcc->pf_running =3D true;
+    sleep(pcc->pf_delay);
+
+    /* Put together the PF source file name */
+    char srcf[130];
+    snprintf(srcf, 128, "%s.pf", pcc->auth_uname);
+
+    if (access(srcf, R_OK) !=3D 0)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[child:PF] ** ERROR ** Cannot read the PF profile '%s'",
+                 srcf);
+        pcc->pf_running =3D false;
+        pthread_exit(NULL);
+    }
+
+    /* Copy the PF profile to to the file OpenVPN have indicated it will
+     * read it from
+     */
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME,
+             "[child:PF] Copying %s to %s", srcf, pcc->pf_file);
+
+    /* We need to fork out a child process, which will do the execve() cal=
l */
+    pid_t pid =3D fork();
+    if (pid =3D=3D 0)
+    {
+        /* Child process */
+        char *prg_args[] =3D { "/bin/cp", srcf, pcc->pf_file, NULL };
+        execve(prg_args[0], prg_args, NULL);
+        exit(1);
+    }
+    else  if (pid > 0)
+    {
+        /* parent process */
+        int ret;
+        int s =3D waitpid(pid, &ret, 0);
+        if (s !=3D pid)
+        {
+            pcc->generated_pf_file =3D false; /* /bin/cp could not be run =
*/
+            ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                     "[chilld:PF] Failed to copy file.  Could not execute =
/bin/cp");
+        }
+
+        if (ret !=3D 0)
+        {
+            /* Exit code was _not_ 0, presume failure */
+            pcc->generated_pf_file =3D false;
+            ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                     "[chilld:PF] Failed to copy file.  Unkown reason.");
+        }
+        else
+        {
+            /* Exit code was 0, presume success */
+            pcc->generated_pf_file =3D true;
+        }
+    }
+    else
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[chilld:PF] Failed to fork file copy process");
+        pcc->generated_pf_file =3D false;
+    }
+
+    /* Exit the worker thread */
+    pcc->pf_running =3D false;
+    pthread_exit(NULL);
+}
+
+
+/**
+ * Main function for adding a PF profile to a client session
+ *
+ * @param context   Pointer to the plug-in global context
+ * @param pcc       Pointer from OpenVPN pointing at a client session
+ *                  specific context
+ * @param argv      Pointer to the argument vectors for the plug-in
+ *                  configuration
+ * @param envp      Pointer to the environment variable vectors prepared
+ *                  by OpenVPN.  Contains session and configuration specif=
ic
+ *                  details.
+ *
+ * @return Returns OPENVPN_PLUGIN_FUNC_SUCCESS if the worker thread was st=
arted
+ *                 successfully.  This is also returned if the PF test is =
disabled
+ *                 (test_packet_filter < 1)
+ *
+ *         Otherwise OPENVPN_PLUGIN_FUNC_ERROR is returned in error situat=
ions.
+ */
+static int
+tls_final(struct plugin_context *context,
+          struct plugin_per_client_context *pcc,
+          const char *argv[],
+          const char *envp[])
+{
+
+    /* If PF is not enabled, consider this phase completed successfully */
+    if (!context->test_packet_filter)
+    {
+        return OPENVPN_PLUGIN_FUNC_SUCCESS;
+    }
+
+    /* If the PF file have already been copied to OpenVPN's import file */
+    if (pcc->generated_pf_file)
+    {
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    /* Get pf_file and username from envp string array */
+    const char *pff =3D get_env("pf_file", envp);
+    const char *username =3D get_env("username", envp);
+    if (!pff || !username)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[parent:PF] Missing pf_file or username information need=
ed for "
+                 "the pf initialization.");
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    /* To avoid back-clash between multiple PF treads on the same client
+     * context, don't start a new one
+     */
+    if (pcc->pf_running)
+    {
+        /* Cleaning up memory used by the other thread */
+        free_thread_data(MOD_PF, pcc);
+
+        if (cancel_thread(MOD_PF, pcc) =3D=3D OPENVPN_PLUGIN_FUNC_ERROR)
+        {
+            return OPENVPN_PLUGIN_FUNC_ERROR;
+        }
+    }
+
+    /* Information the pf thread wil need.  It is important that
+     * the memory buffers are created for each call, as once this function
+     * exits the environment variable pointers are no longer valid
+     */
+    pcc->pf_delay =3D context->test_packet_filter;
+    pcc->pf_file =3D strdup(pff);
+    pcc->pf_running =3D false;
+    pcc->generated_pf_file =3D false;
+    pcc->auth_uname =3D strdup(username);
+
+    /*
+     * Start the pf worker thread
+     *
+     * WARNING:
+     * This implementation does not care how the authentication thread exi=
sts.
+     * A more proper and solid implementation would track this and report
+     * issues with these threads, outside of the authenticaion thread itse=
lf.
+     * This implementation _may_ result in a little memory leak due to thi=
s.
+     */
+    if (pthread_create(&pcc->pfthread, NULL, pf_thread, pcc))
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "[parent:PF] Failed to create pf thread");
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    /* Signalize to OpenVPN that the pf init phase is done */
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+}
+
+
+/**
+ * This function is called when OpenVPN loads the plug-in.
+ * The purpose is to initialize the plug-in and tell OpenVPN
+ * which plug-in hooks this plug-in wants to be involved in
+ *
+ * For the arguments, see the include/openvpn-plugin.h file
+ * for details on the function parameters
+ *
+ * @param v3structver  An integer containing the API version of
+ *                     the plug-in structs OpenVPN uses
+ * @param args         A pointer to the argument struct for
+ *                     information and features provided by
+ *                     OpenVPN to the plug-in
+ * @param ret          A pointer to the struct OpenVPN uses to
+ *                     receive information back from the plug-in
+ *
+ * @return Must return OPENVPN_PLUGIN_FUNC_SUCCESS when everything
+ *         completed successfully.  Otherwise it must be returned
+ *         OPENVPN_PLUGIN_FUNC_ERROR, which will stop OpenVPN
+ *         from running
+ *
+ */
+OPENVPN_EXPORT int
+openvpn_plugin_open_v3(const int v3structver,
+                       struct openvpn_plugin_args_open_in const *args,
+                       struct openvpn_plugin_args_open_return *ret)
+{
+    struct plugin_context *context;
+
+    /* Sanity check, to avoid issues when accessing plug-in API structs.
+     * This check is very strict, and requires an identical match.
+     * For some implementations, ensuring
+     *
+     *     v3structver >=3D OPENVPN_PLUGINv3_STRUCTVER
+     *
+     * might be enough.  But that depends on what kind of structs
+     * which are used by the plug-in
+     */
+    if (v3structver !=3D OPENVPN_PLUGINv3_STRUCTVER)
+    {
+        printf("defer/simple.c:  ** ERROR ** Incompatible plug-in interfac=
e"
+               "between this plug-in and the OpenVPN plug-in API\n");
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    /* Hook into the log functions for plug-ins */
+    ovpn_log =3D args->callbacks->plugin_log;
+    ovpn_vlog =3D args->callbacks->plugin_vlog;
+
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "FUNC: openvpn_plugin_open_v3");
+
+    /* Allocate our context and extract a few settings */
+    context =3D (struct plugin_context *) calloc(1, sizeof(struct plugin_c=
ontext));
+
+    /* The test_deferred_auth env variable defines if we will
+     * test password authentication
+     */
+    context->test_deferred_auth =3D str2uint(get_env("test_deferred_auth",=
 args->envp));
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "TEST_DEFERRED_AUTH %d", context->tes=
t_deferred_auth);
+
+    /* The test_packet_filter env variable defines if we will
+     * test the OpenVPN packet filter (PF) feature
+     */
+    context->test_packet_filter =3D str2uint(get_env("test_packet_filter",=
 args->envp));
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "TEST_PACKET_FILTER %d", context->tes=
t_packet_filter);
+
+    ret->handle =3D (void *) context;
+
+    /* Which callbacks this plug-in will handle */
+    ret->type_mask =3D OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_UP)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_DOWN)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ROUTE_UP)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_IPCHANGE)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_LEARN_ADDRESS)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ENABLE_PF);
+
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+}
+
+
+/**
+ * This function is called by OpenVPN each time the OpenVPN reaches
+ * a point where plug-in calls should happen.  It only happens for those
+ * plug-in hooks enabled in openvpn_plugin_open_v3().
+ *
+ * For the arguments, see the include/openvpn-plugin.h file
+ * for details on the function parameters
+ *
+ * @param args        Pointer to a struct with details about the plug-in
+ *                    call from the main OpenVPN process.
+ * @param returndata  Pointer to a struct where the plug-in can provide
+ *                    information back to OpenVPN to be processed
+ *
+ * @returns Must return OPENVPN_PLUGIN_FUNC_SUCCESS or
+ *          OPENVPN_PLUGIN_FUNC_DEFERRED on success.  Otherwise it
+ *          should return OPENVPN_FUNC_ERROR, which will stop and reject
+ *          the client session from progressing.
+ *
+ */
+OPENVPN_EXPORT int
+openvpn_plugin_func_v3(const int apiversion,
+                       struct openvpn_plugin_args_func_in const *args,
+                       struct openvpn_plugin_args_func_return *returndata)
+{
+    struct plugin_context *context =3D (struct plugin_context *) args->han=
dle;
+    struct plugin_per_client_context *pcc =3D (struct plugin_per_client_co=
ntext *) args->per_client_context;
+
+    /* This plug-in uses both the generic plug-in context for the plug-in
+     * itself and a context per client session.  So ensure these are not
+     * NULL.  If your plug-in does not need this, those pointers can be
+     * ignored.
+     *
+     * These pointers are normally NULL and the needed buffers must be
+     * managed and maintained by the plug-in exclusively.  OpenVPN itself
+     * does not touch these buffers at all.  The per_client_context buffer
+     * must be allocated in the openvpn_plugin_client_constructor_v1()
+     * function and free()d in openvpn_plugin_client_destructor_v1().
+     *
+     */
+    if (!context || !pcc)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME, "Needed context buffers are not av=
ailable. Aborting.");
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    /* Dispatch the various plug-in hooks to the appropriate handler.
+     * You only need to add a handler for those hooks you've enabled in
+     * openvpn_plugin_open_v3()
+     */
+    switch (args->type)
+    {
+        case OPENVPN_PLUGIN_UP:
+            ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OPENVPN_PLUGIN_UP");
+            return OPENVPN_PLUGIN_FUNC_SUCCESS;
+
+        case OPENVPN_PLUGIN_DOWN:
+            ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OPENVPN_PLUGIN_DOWN");
+            return OPENVPN_PLUGIN_FUNC_SUCCESS;
+
+        case OPENVPN_PLUGIN_ROUTE_UP:
+            ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OPENVPN_PLUGIN_ROUTE_UP");
+            return OPENVPN_PLUGIN_FUNC_SUCCESS;
+
+        case OPENVPN_PLUGIN_IPCHANGE:
+            ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OPENVPN_PLUGIN_IPCHANGE");
+            return OPENVPN_PLUGIN_FUNC_SUCCESS;
+
+        case OPENVPN_PLUGIN_TLS_VERIFY:
+            ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OPENVPN_PLUGIN_TLS_VERIFY");
+            return OPENVPN_PLUGIN_FUNC_SUCCESS;
+
+        case OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY:
+            ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OPENVPN_PLUGIN_AUTH_USER_PAS=
S_VERIFY");
+
+            /* Handle password authentication in its own function */
+            return auth_user_pass_verify(context, pcc, args->argv, args->e=
nvp);
+
+        case OPENVPN_PLUGIN_CLIENT_CONNECT_V2:
+            ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OPENVPN_PLUGIN_CLIENT_CONNEC=
T_V2");
+            return OPENVPN_PLUGIN_FUNC_SUCCESS;
+
+        case OPENVPN_PLUGIN_CLIENT_DISCONNECT:
+            ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OPENVPN_PLUGIN_CLIENT_DISCON=
NECT");
+            return OPENVPN_PLUGIN_FUNC_SUCCESS;
+
+        case OPENVPN_PLUGIN_LEARN_ADDRESS:
+            ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OPENVPN_PLUGIN_LEARN_ADDRESS=
");
+            return OPENVPN_PLUGIN_FUNC_SUCCESS;
+
+        case OPENVPN_PLUGIN_TLS_FINAL:
+            ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OPENVPN_PLUGIN_TLS_FINAL");
+
+            /* This function prepares the Packet Filter (PF) in OpenVPN */
+            return tls_final(context, pcc, args->argv, args->envp);
+
+        case OPENVPN_PLUGIN_ENABLE_PF:
+            ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OPENVPN_PLUGIN_ENABLE_PF");
+
+            /* Indicate if OpenVPN should enable PF for this session */
+            if (context->test_packet_filter)
+            {
+                ovpn_log(PLOG_NOTE, PLUGIN_NAME,
+                         "PF enabled");
+                return OPENVPN_PLUGIN_FUNC_SUCCESS;
+            }
+            else
+            {
+                ovpn_log(PLOG_NOTE, PLUGIN_NAME,
+                         "PF disabled");
+                return OPENVPN_PLUGIN_FUNC_ERROR;
+            }
+
+        default:
+            ovpn_log(PLOG_NOTE, PLUGIN_NAME,
+                     "** ERROR ** Unknown OpenVPN plug-in function call (%=
i)",
+                     args->type);
+            return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+}
+
+/**
+ * This function's main responsibility is to allocate memory for the
+ * client session context, which is unique per client session.
+ *
+ * @param handle  Pointer to a plug-in global context buffer
+ *
+ * @return Returns a pointer to the newly allocated client session context
+ */
+OPENVPN_EXPORT void *
+openvpn_plugin_client_constructor_v1(openvpn_plugin_handle_t handle)
+{
+    struct plugin_per_client_context *pcc;
+
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "FUNC: openvpn_plugin_client_construc=
tor_v1");
+    pcc =3D calloc(1, sizeof(struct plugin_per_client_context));
+    if (!pcc)
+    {
+        ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                 "** ERROR ** Failed to allocate memory a the client conte=
xt");
+    }
+    return pcc;
+}
+
+
+/**
+ * This function is responsible for releasing memory buffers used by
+ * the client session context and ensure all related running jobs have
+ * completed before this function cleans up and returns.
+ *
+ * @param handle  Pointer to a plug-in global context buffer
+ * @param ppcp    Pointer to the client session context buffer to be relea=
sed
+ *
+ */
+OPENVPN_EXPORT void
+openvpn_plugin_client_destructor_v1(openvpn_plugin_handle_t handle, void *=
ppcp)
+{
+    struct plugin_per_client_context *pcc =3D (struct plugin_per_client_co=
ntext *) ppcp;
+
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "FUNC: openvpn_plugin_client_destruct=
or_v1");
+
+    if (pcc->auth_running)
+    {
+        ovpn_log(PLOG_WARN, PLUGIN_NAME,
+                 "** WARNING ** An authentication thread is still running,=
 "
+                 "waiting for it to complete");
+        int s =3D pthread_join(pcc->auththread, NULL);
+        if (s)
+        {
+            ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                     "** ERROR ** Failed to wait for the authentication "
+                     "thread to complete: %s",
+                     strerror(s));
+        }
+    }
+
+    if (pcc->pf_running)
+    {
+        ovpn_log(PLOG_WARN, PLUGIN_NAME,
+                 "** WARNING ** A PF thread is still running, "
+                 "waiting for it to complete");
+        int s =3D pthread_join(pcc->pfthread, NULL);
+        if (s)
+        {
+            ovpn_log(PLOG_ERR, PLUGIN_NAME,
+                     "** ERROR ** Failed to wait for the PF thread "
+                     "to complete: %s",
+                     strerror(s));
+        }
+    }
+
+    free_thread_data(MOD_AUTH, pcc);
+    free_thread_data(MOD_PF, pcc);
+    free(pcc);
+}
+
+
+/**
+ * This cleans up the last part of the plug-in, allows it to
+ * shut down cleanly and release the plug-in global context buffer
+ *
+ * @param handle   Pointer to the plug-in global context buffer, which
+ *                 need to be released by this function
+ */
+OPENVPN_EXPORT void
+openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
+{
+    struct plugin_context *context =3D (struct plugin_context *) handle;
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "FUNC: openvpn_plugin_close_v1");
+    free(context);
+}
diff --git a/sample/sample-plugins/defer/simple.def b/sample/sample-plugins=
/defer/defer-w-pf.def
similarity index 100%
rename from sample/sample-plugins/defer/simple.def
rename to sample/sample-plugins/defer/defer-w-pf.def
diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/d=
efer/simple.c
deleted file mode 100644
index ad1bbb0f..00000000
--- a/sample/sample-plugins/defer/simple.c
+++ /dev/null
@@ -1,340 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
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
-/*
- * This file implements a simple OpenVPN plugin module which
- * will test deferred authentication and packet filtering.
- *
- * Will run on Windows or *nix.
- *
- * Sample usage:
- *
- * setenv test_deferred_auth 20
- * setenv test_packet_filter 10
- * plugin plugin/defer/simple.so
- *
- * This will enable deferred authentication to occur 20
- * seconds after the normal TLS authentication process,
- * and will cause a packet filter file to be generated 10
- * seconds after the initial TLS negotiation, using
- * {common-name}.pf as the source.
- *
- * Sample packet filter configuration:
- *
- * [CLIENTS DROP]
- * +otherclient
- * [SUBNETS DROP]
- * +10.0.0.0/8
- * -10.10.0.8
- * [END]
- *
- * See the README file for build instructions.
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-
-#include "openvpn-plugin.h"
-
-/* bool definitions */
-#define bool int
-#define true 1
-#define false 0
-
-/*
- * Our context, where we keep our state.
- */
-
-struct plugin_context {
-    int test_deferred_auth;
-    int test_packet_filter;
-};
-
-struct plugin_per_client_context {
-    int n_calls;
-    bool generated_pf_file;
-};
-
-/*
- * Given an environmental variable name, search
- * the envp array for its value, returning it
- * if found or NULL otherwise.
- */
-static const char *
-get_env(const char *name, const char *envp[])
-{
-    if (envp)
-    {
-        int i;
-        const int namelen =3D strlen(name);
-        for (i =3D 0; envp[i]; ++i)
-        {
-            if (!strncmp(envp[i], name, namelen))
-            {
-                const char *cp =3D envp[i] + namelen;
-                if (*cp =3D=3D '=3D')
-                {
-                    return cp + 1;
-                }
-            }
-        }
-    }
-    return NULL;
-}
-
-/* used for safe printf of possible NULL strings */
-static const char *
-np(const char *str)
-{
-    if (str)
-    {
-        return str;
-    }
-    else
-    {
-        return "[NULL]";
-    }
-}
-
-static int
-atoi_null0(const char *str)
-{
-    if (str)
-    {
-        return atoi(str);
-    }
-    else
-    {
-        return 0;
-    }
-}
-
-OPENVPN_EXPORT openvpn_plugin_handle_t
-openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const =
char *envp[])
-{
-    struct plugin_context *context;
-
-    printf("FUNC: openvpn_plugin_open_v1\n");
-
-    /*
-     * Allocate our context
-     */
-    context =3D (struct plugin_context *) calloc(1, sizeof(struct plugin_c=
ontext));
-
-    context->test_deferred_auth =3D atoi_null0(get_env("test_deferred_auth=
", envp));
-    printf("TEST_DEFERRED_AUTH %d\n", context->test_deferred_auth);
-
-    context->test_packet_filter =3D atoi_null0(get_env("test_packet_filter=
", envp));
-    printf("TEST_PACKET_FILTER %d\n", context->test_packet_filter);
-
-    /*
-     * Which callbacks to intercept.
-     */
-    *type_mask =3D
-        OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_UP)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_DOWN)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ROUTE_UP)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_IPCHANGE)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_LEARN_ADDRESS)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ENABLE_PF);
-
-    return (openvpn_plugin_handle_t) context;
-}
-
-static int
-auth_user_pass_verify(struct plugin_context *context, struct plugin_per_cl=
ient_context *pcc, const char *argv[], const char *envp[])
-{
-    if (context->test_deferred_auth)
-    {
-        /* get username/password from envp string array */
-        const char *username =3D get_env("username", envp);
-        const char *password =3D get_env("password", envp);
-
-        /* get auth_control_file filename from envp string array*/
-        const char *auth_control_file =3D get_env("auth_control_file", env=
p);
-
-        printf("DEFER u=3D'%s' p=3D'%s' acf=3D'%s'\n",
-               np(username),
-               np(password),
-               np(auth_control_file));
-
-        /* Authenticate asynchronously in n seconds */
-        if (auth_control_file)
-        {
-            char buf[256];
-            int auth =3D 2;
-            sscanf(username, "%d", &auth);
-            snprintf(buf, sizeof(buf), "( sleep %d ; echo AUTH %s %d ; ech=
o %d >%s ) &",
-                     context->test_deferred_auth,
-                     auth_control_file,
-                     auth,
-                     pcc->n_calls < auth,
-                     auth_control_file);
-            printf("%s\n", buf);
-            system(buf);
-            pcc->n_calls++;
-            return OPENVPN_PLUGIN_FUNC_DEFERRED;
-        }
-        else
-        {
-            return OPENVPN_PLUGIN_FUNC_ERROR;
-        }
-    }
-    else
-    {
-        return OPENVPN_PLUGIN_FUNC_SUCCESS;
-    }
-}
-
-static int
-tls_final(struct plugin_context *context, struct plugin_per_client_context=
 *pcc, const char *argv[], const char *envp[])
-{
-    if (context->test_packet_filter)
-    {
-        if (!pcc->generated_pf_file)
-        {
-            const char *pff =3D get_env("pf_file", envp);
-            const char *cn =3D get_env("username", envp);
-            if (pff && cn)
-            {
-                char buf[256];
-                snprintf(buf, sizeof(buf), "( sleep %d ; echo PF %s/%s ; c=
p \"%s.pf\" \"%s\" ) &",
-                         context->test_packet_filter, cn, pff, cn, pff);
-                printf("%s\n", buf);
-                system(buf);
-                pcc->generated_pf_file =3D true;
-                return OPENVPN_PLUGIN_FUNC_SUCCESS;
-            }
-            else
-            {
-                return OPENVPN_PLUGIN_FUNC_ERROR;
-            }
-        }
-        else
-        {
-            return OPENVPN_PLUGIN_FUNC_ERROR;
-        }
-    }
-    else
-    {
-        return OPENVPN_PLUGIN_FUNC_SUCCESS;
-    }
-}
-
-OPENVPN_EXPORT int
-openvpn_plugin_func_v2(openvpn_plugin_handle_t handle,
-                       const int type,
-                       const char *argv[],
-                       const char *envp[],
-                       void *per_client_context,
-                       struct openvpn_plugin_string_list **return_list)
-{
-    struct plugin_context *context =3D (struct plugin_context *) handle;
-    struct plugin_per_client_context *pcc =3D (struct plugin_per_client_co=
ntext *) per_client_context;
-    switch (type)
-    {
-        case OPENVPN_PLUGIN_UP:
-            printf("OPENVPN_PLUGIN_UP\n");
-            return OPENVPN_PLUGIN_FUNC_SUCCESS;
-
-        case OPENVPN_PLUGIN_DOWN:
-            printf("OPENVPN_PLUGIN_DOWN\n");
-            return OPENVPN_PLUGIN_FUNC_SUCCESS;
-
-        case OPENVPN_PLUGIN_ROUTE_UP:
-            printf("OPENVPN_PLUGIN_ROUTE_UP\n");
-            return OPENVPN_PLUGIN_FUNC_SUCCESS;
-
-        case OPENVPN_PLUGIN_IPCHANGE:
-            printf("OPENVPN_PLUGIN_IPCHANGE\n");
-            return OPENVPN_PLUGIN_FUNC_SUCCESS;
-
-        case OPENVPN_PLUGIN_TLS_VERIFY:
-            printf("OPENVPN_PLUGIN_TLS_VERIFY\n");
-            return OPENVPN_PLUGIN_FUNC_SUCCESS;
-
-        case OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY:
-            printf("OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY\n");
-            return auth_user_pass_verify(context, pcc, argv, envp);
-
-        case OPENVPN_PLUGIN_CLIENT_CONNECT_V2:
-            printf("OPENVPN_PLUGIN_CLIENT_CONNECT_V2\n");
-            return OPENVPN_PLUGIN_FUNC_SUCCESS;
-
-        case OPENVPN_PLUGIN_CLIENT_DISCONNECT:
-            printf("OPENVPN_PLUGIN_CLIENT_DISCONNECT\n");
-            return OPENVPN_PLUGIN_FUNC_SUCCESS;
-
-        case OPENVPN_PLUGIN_LEARN_ADDRESS:
-            printf("OPENVPN_PLUGIN_LEARN_ADDRESS\n");
-            return OPENVPN_PLUGIN_FUNC_SUCCESS;
-
-        case OPENVPN_PLUGIN_TLS_FINAL:
-            printf("OPENVPN_PLUGIN_TLS_FINAL\n");
-            return tls_final(context, pcc, argv, envp);
-
-        case OPENVPN_PLUGIN_ENABLE_PF:
-            printf("OPENVPN_PLUGIN_ENABLE_PF\n");
-            if (context->test_packet_filter)
-            {
-                return OPENVPN_PLUGIN_FUNC_SUCCESS;
-            }
-            else
-            {
-                return OPENVPN_PLUGIN_FUNC_ERROR;
-            }
-
-        default:
-            printf("OPENVPN_PLUGIN_?\n");
-            return OPENVPN_PLUGIN_FUNC_ERROR;
-    }
-}
-
-OPENVPN_EXPORT void *
-openvpn_plugin_client_constructor_v1(openvpn_plugin_handle_t handle)
-{
-    printf("FUNC: openvpn_plugin_client_constructor_v1\n");
-    return calloc(1, sizeof(struct plugin_per_client_context));
-}
-
-OPENVPN_EXPORT void
-openvpn_plugin_client_destructor_v1(openvpn_plugin_handle_t handle, void *=
per_client_context)
-{
-    printf("FUNC: openvpn_plugin_client_destructor_v1\n");
-    free(per_client_context);
-}
-
-OPENVPN_EXPORT void
-openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
-{
-    struct plugin_context *context =3D (struct plugin_context *) handle;
-    printf("FUNC: openvpn_plugin_close_v1\n");
-    free(context);
-}
--=20
2.11.0


