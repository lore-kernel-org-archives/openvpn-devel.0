Date: Sun, 14 Oct 2007 23:07:29 +0200
From: Maximilian Wilhelm <max@...1047...>
Message-ID: <20071014210725.GA9554@...1058...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
Subject: [Openvpn-devel] [2nd Try] WTMP support for OpenVPN 2.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: jbglaw@...1059...

--LpQ9ahxlCli8rRTG
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

This is my second try to get comments for my WTMP support for OpenVPN 2.1.

Description:

  If compiled in and activated in the configuration, OpenVPN will put a
  wtmp entry into the logfile for each connection include the username,
  it's VPN ip, the real IP the client connected from and the times the
  session was opened and closed.

  It is possible to let multiple instances of OpenVPN on the same host
  use the same wtmp file.

  You will be able to distinguish between vpn servers in a commonly use
  file by specifying different "server ids" (two digit integer value),
  which will be used in the wtmp line string.
=20
  This provides an OpenVPN admin with a simple database of all connections
  to his VPN servers and the ability to easily track down when, who was
  logged in and from where.


One thing which is not perfect is that, the uid/gid for the wtmp file
are looked up manually in wtmp_init() as context->c0 struct is not yet
available.
Maybe wtmp_init() could be called a bit later at a usefull place to
avoid this doulbe lookup.

I would very much like to get the WTMP logging support included in
OpenVPN 2.1 as it will help people to get an overview about the usage
of their VPNs and prepares abuse-people with relevant information if
problems occur.

Some time ago, this feature was requested, btw.

Ciao
Max
--=20
	Follow the white penguin.

--2oS5YaxWCcQjTEyO
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="01_Add__wtmp_line_field_to__struct_context1.patch"
Content-Transfer-Encoding: quoted-printable

Added field 'wtmp_line' to 'struct context_1' to store unique wtmp_line id.
--
 openvpn.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
diff --git a/openvpn.h b/openvpn.h
index 0cdab62..70d2f28 100644
--- a/openvpn.h
+++ b/openvpn.h
@@ -195,6 +195,10 @@ struct context_1
   /* save user/pass for authentication */
   struct user_pass *auth_user_pass;
 #endif
+
+#ifdef ENABLE_WTMP
+  unsigned long int wtmp_line;
+#endif
 };
=20
 /*

--2oS5YaxWCcQjTEyO
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="02_Add_entire_wtmp_support.patch"

The entire wtmp support for OpenVPN.
--
 wtmp.c |  397 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wtmp.h |   20 ++++
 2 files changed, 417 insertions(+), 0 deletions(-)
diff --git a/wtmp.c b/wtmp.c
new file mode 100644
index 0000000..1c1a0af
--- /dev/null
+++ b/wtmp.c
@@ -0,0 +1,397 @@
+/*
+ * OpenVPN wtmp support
+ *
+ * (C) 2007 Maximilian Wilhelm <max@...1047...>
+ * (C) 2007 Jan-Benedict Glaw <jbglaw@...1059...>
+ *
+ */
+
+#include "config.h"
+#include "syshead.h"
+
+#ifdef ENABLE_WTMP
+
+#define _GNU_SOURCE
+
+#include <assert.h>	/* assert() */
+#include <dirent.h>	/* opendir() */
+#include <libgen.h>	/* dirname() */
+#include <pwd.h>	/* struct passwd */
+#include <stdio.h>	/* fopen() */
+#include <stdlib.h>	/* *alloc(), free() */
+#include <string.h>	/* strncpy(), strlen() */
+#include <sys/stat.h>	/* stat() */
+#include <sys/time.h>	/* struct timeval, gettimeofday() */
+#include <sys/types.h>	/* opendir() chown()  */
+#include <time.h>	/* gettimeofday() */
+#include <unistd.h>	/* chown() */
+#include <utmp.h>	/* utmp stuff */
+
+#include "openvpn.h"	/* struct context* */
+#include "forward.h"
+#include "forward-inline.h"
+#include "multi.h"	/* struct multi_instance */
+#include "buffer.h"	/* struct buffer */
+
+#include "wtmp.h"
+
+
+int wtmp_initialized = 0;
+
+// #define OVPN_WTMP_DEBUG 1
+
+/* static function declarations */
+static void set_utmp_hostname (const struct multi_instance *mi, struct utmp *entry);
+static void set_utmp_id (const struct multi_instance *mi, struct utmp *entry);
+static void set_utmp_line (const struct multi_instance *mi, struct utmp *entry);
+static void set_utmp_username (const struct multi_instance *mi, struct utmp *entry);
+static void set_utmp_time (struct utmp *ut);
+
+
+/*
+ * Initialize wtmp subsystem
+ */
+int
+wtmp_init (const struct options *vpn_options)
+{
+	struct stat wtmp_stat;
+	struct passwd *pw;
+	struct group *grp;
+	int do_chmod = 1;
+	uid_t uid = -1;
+	gid_t gid = -1;
+	char *wtmp_file_path;
+	char *wtmp_file_dirname;
+	char *wtmp_file_path_copy;
+	int fd;
+
+	assert (vpn_options);
+
+#ifdef OVPN_WTMP_DEBUG
+	fprintf (stderr, "%s() called.\n", __FUNCTION__);
+#endif
+
+	/* Only initialize once */
+	if (wtmp_initialized)
+		return 1;
+
+	wtmp_file_path = vpn_options->wtmp_file;
+
+#ifdef OVPN_WTMP_DEBUG
+	fprintf (stderr, "wtmp_file_path = %s\n", wtmp_file_path);
+#endif
+
+	wtmp_file_path_copy = strdup (wtmp_file_path);
+	if (! wtmp_file_path_copy) {
+		fprintf (stderr, "%s: strdup() failed.\n", __FUNCTION__);
+		wtmp_initialized = 0;
+		goto out;
+
+	}
+
+	wtmp_file_dirname = dirname (wtmp_file_path_copy);
+	if (! wtmp_file_dirname) {
+		fprintf (stderr, "%s: Could not get dirname of wtmp_file_path %s.\n",
+			 __FUNCTION__);
+		wtmp_initialized = 0;
+		goto out;
+	}
+
+	/* Get UID and GID of the configured user and group */
+	if (vpn_options->username) {
+		pw = getpwnam (vpn_options->username);
+		if (pw)
+			uid = pw->pw_uid;
+		else
+			do_chmod = 0;
+	}
+
+	if (vpn_options->groupname) {
+		grp = getgrnam (vpn_options->groupname);
+		if (grp)
+			gid = grp->gr_gid;
+		else
+			do_chmod = 0;
+
+	}
+
+	/* If the wtmp directory does not exist, create it. Also create the
+	 * wtmp file if neccessary, but pay attention that a regular user
+	 * cannot symlink-attack an already-present root-owned system file.  */
+	(void) mkdir (wtmp_file_dirname, S_IRWXU);
+	fd = open (wtmp_file_path, O_CREAT | O_EXCL, S_IRUSR | S_IWUSR | S_IRGRP);
+	if (fd >= 0)
+		close (fd);
+
+	if (do_chmod && uid != -1 && gid != -1) {
+		if (lchown (wtmp_file_path, uid, gid)) {
+			fprintf (stderr, "%s: Could not set owner/group of wtmp file %s.\n",
+				__FUNCTION__, wtmp_file_path);
+				wtmp_initialized = 0;
+				goto out;
+		}
+	}
+
+	/* OK wtmp_file is (now) there, use it */
+	utmpname (wtmp_file_path);
+
+	/* Everything is fine */
+	wtmp_initialized = 1;
+
+out:
+	free (wtmp_file_path_copy);
+
+	return wtmp_initialized;
+}
+
+
+void
+wtmp_start (const struct multi_instance *mi)
+{
+#ifdef OVPN_WTMP_DEBUG
+	fprintf (stderr, "%s() called.\n", __FUNCTION__);
+#endif
+
+	struct utmp entry;
+	struct sockaddr_in *remote_addr;
+
+	char *temp;
+
+	assert (mi);
+
+	if (! wtmp_initialized)
+		return;
+
+	/* Get IP address of this connection
+	 * FIXME: IPv6?!
+	 */
+	remote_addr = get_remote_sockaddr_from_multi_instance (mi);
+	if (! remote_addr) {
+		fprintf (stderr, "%s: get_remote_sockaddr_from_multi_instance (mi) failed.\n",
+			__FUNCTION__);
+	}
+
+	/* Clear entry */
+	memset(&entry, '\0', sizeof (entry));
+
+	/* This entry is a user process */
+	entry.ut_type = USER_PROCESS;
+
+	/* The connection started now, so set epoch time */
+	set_utmp_time (&entry);
+
+	/* Set the user name */
+	set_utmp_username (mi, &entry);
+
+	/* Set the line */
+	set_utmp_line (mi, &entry);
+
+	/* Store the IP we gave this client as the hostname */
+	set_utmp_hostname (mi, &entry);
+
+	/* Use the first 4 chars of the session ID as id */
+	set_utmp_id (mi, &entry);
+
+	/* Store the remote client IP(v4), if available */
+	entry.ut_addr = remote_addr->sin_addr.s_addr;
+
+#ifdef OVPN_WTMP_DEBUG
+fprintf (stderr, "%s: entry.ut_line = \"%s\"\n", __FUNCTION__, entry.ut_line);
+fprintf (stderr, "%s: entry.ut_id = \"%s\"\n",   __FUNCTION__, entry.ut_id);
+fprintf (stderr, "%s: entry.ut_user = \"%s\"\n", __FUNCTION__, entry.ut_user);
+fprintf (stderr, "%s: entry.ut_host = \"%s\"\n", __FUNCTION__, entry.ut_host);
+
+unsigned int ip = ntohl (entry.ut_addr);
+fprintf (stderr, "%s: entry.ut_addr = %d.%d.%d.%d\n", __FUNCTION__,  ip >> 24, (ip >> 16) & 0xff, (ip >> 8) & 0xff, (ip >> 0) & 0xff);
+#endif
+
+	updwtmp (mi->context.options.wtmp_file, &entry);
+}
+
+
+void
+wtmp_stop (const struct multi_instance *mi)
+{
+#ifdef OVPN_WTMP_DEBUG
+	fprintf (stderr, "%s() called.\n", __FUNCTION__);
+#endif
+
+	struct utmp entry;
+
+	assert (mi);
+
+	if (! wtmp_initialized)
+		return;
+
+	/* Clear entry */
+	memset (&entry, '\0', sizeof (entry));
+
+	/* The connection stopped now, so set epoch time */
+	set_utmp_time (&entry);
+
+	/* He's dead jim */
+	entry.ut_type = DEAD_PROCESS;
+
+	/* Set current epoch time */
+	set_utmp_time (&entry);
+
+	/* Set the line */
+	set_utmp_line (mi, &entry);
+
+	/* Use the first 4 chars of the session ID as id */
+	set_utmp_id (mi, &entry);
+
+	entry.ut_host[0] = 0;
+
+#ifdef OVPN_WTMP_DEBUG
+fprintf (stderr, "%s: entry.ut_line = %s\n", __FUNCTION__, entry.ut_line);
+fprintf (stderr, "%s: entry.ut_id = %s\n", __FUNCTION__, entry.ut_id);
+#endif
+
+	updwtmp (mi->context.options.wtmp_file, &entry);
+}
+
+
+
+/* Build up and store an utmp line */
+static void
+set_utmp_line (const struct multi_instance *mi, struct utmp *entry)
+{
+	unsigned int server_id;
+	char * line;
+
+	server_id = mi->context.options.wtmp_server_id % 100;
+	line = format_wtmp_line (mi->context.c1.wtmp_line);
+
+	snprintf (entry->ut_line, UT_LINESIZE, "ovpn%02d-%s", server_id, line);
+}
+
+
+/* Store the first 4 chars of the session_id as the utmp id */
+static void
+set_utmp_id (const struct multi_instance *mi, struct utmp *entry)
+{
+	char *line;
+
+	line = format_wtmp_line (mi->context.c1.wtmp_line);
+
+	snprintf (entry->ut_id, 4, "%s", line);
+}
+
+
+/* Store a human readable format of the VPN ip address we gave to the client as utmp hostname */
+static void
+set_utmp_hostname (const struct multi_instance *mi, struct utmp *entry)
+{
+	unsigned int ip;
+
+	memset (entry->ut_host, '\0', UT_HOSTSIZE);
+
+	ip =  mi->context.c2.push_ifconfig_local;
+	snprintf (entry->ut_host, UT_HOSTSIZE, "%d.%d.%d.%d", ip >> 24, (ip >> 16) & 0xff, (ip >> 8) & 0xff, (ip >> 0) & 0xff);
+}
+
+
+/* Store the username of the current session in the utmp entry */
+static void
+set_utmp_username (const struct multi_instance *mi, struct utmp *entry)
+{
+	const char *username;
+
+	username = tls_common_name (mi->context.c2.tls_multi, false);
+	if (username) {
+		snprintf (entry->ut_user, UT_NAMESIZE, "%s", username);
+	} else {
+		snprintf (entry->ut_user, UT_NAMESIZE, "unknown");
+	}
+}
+
+
+/* Get a sockaddr_in struct containing the real IP of the remote host */
+static struct sockaddr_in *
+get_remote_sockaddr_from_multi_instance (const struct multi_instance *mi)
+{
+	struct buffer buf ;
+	struct link_socket_actual *lsa;
+
+	lsa = calloc (1, sizeof (struct link_socket_actual));
+	if (! lsa)
+		return NULL;
+
+	link_socket_get_outgoing_addr (&buf, get_link_socket_info (&mi->context), &lsa);
+
+	return &lsa->dest.sa;
+}
+
+
+/*
+ * wtmp line generation
+ */
+
+unsigned long int
+gen_wtmp_line ()
+{
+	struct timeval timeval;
+
+	/* Get random seed */
+	gettimeofday (&timeval, NULL);
+	srandom ((unsigned) timeval.tv_sec ^ timeval.tv_usec);
+
+	return random();
+}
+
+#define MAP_BASE 32
+
+char *
+format_wtmp_line (const unsigned long int n)
+{
+	unsigned long int a, b, i;
+
+	char *string;
+	char digit[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
+		         'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
+		         'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
+		         'l', 'k' };
+
+	if (sizeof (digit) / sizeof ((digit)[0]) < MAP_BASE) {
+		fprintf (stderr, "%s: Not enough digits in 'digit' map.\n");
+		return NULL;
+	}
+
+	/* Allocat string space */
+	string = calloc (1, sizeof (n) * 8 + 2);
+	if (! string) {
+		return NULL;
+	}
+
+	/* Beware: This will print the number in base_32 in the wrong direction.
+	 * As this is not relevant here, I won't fix it */
+	a = n;
+	for (i = 0; a != 0; i++) {
+		b = a % MAP_BASE;
+		a = a / MAP_BASE;
+
+		string[i] = digit[b];
+	}
+
+	return string;
+}
+
+
+/*
+ * Some helper functions, partly stolen from OpenSSH/loginrec.c
+ */
+
+
+/* Store the current time in utmp struct */
+static void
+set_utmp_time (struct utmp *ut)
+{
+	struct timeval tv;
+
+	gettimeofday(&ut->ut_tv, NULL);
+
+	ut->ut_time = ut->ut_tv.tv_sec;
+}
+
+#endif /* ENABLE_WTMP */
diff --git a/wtmp.h b/wtmp.h
new file mode 100644
index 0000000..f0fb66e
--- /dev/null
+++ b/wtmp.h
@@ -0,0 +1,20 @@
+#ifndef _OPENVPN_WTMP_H
+#define _OPENVPN_WTMP_H
+
+#include <utmp.h>
+
+#include "multi.h"
+
+enum local_remote { LOCAL, REMOTE };
+
+int wtmp_init (const struct options *vpn_options);
+
+void wtmp_start (const struct multi_instance *mi);
+void wtmp_stop (const struct multi_instance *mi);
+
+
+static struct sockaddr_in * get_remote_sockaddr_from_multi_instance (const struct multi_instance *mi);
+extern unsigned long int gen_wtmp_line ();
+extern char * format_wtmp_line (unsigned long int n);
+
+#endif /* _OPENVPN_WTMP_H */

--2oS5YaxWCcQjTEyO
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="03_Add_wtmp_logging_configuration_option.patch"
Content-Transfer-Encoding: quoted-printable

--log-wtmp server_id [file] : Enable logging to wtmp file using the two dig=
it
server_id a prefix for the utmp line. Optionally you can write
to an own wtmp file. (Default is /var/log/openvpn/wtmp)
--
 options.c |   32 ++++++++++++++++++++++++++++++++
 options.h |    6 ++++++
 2 files changed, 38 insertions(+), 0 deletions(-)
diff --git a/options.c b/options.c
index 46aad6d..e8567f7 100644
--- a/options.c
+++ b/options.c
@@ -266,6 +266,11 @@ static const char usage_message[] =3D
   "--suppress-timestamps : Don't log timestamps to stdout/stderr.\n"
   "--writepid file : Write main process ID to file.\n"
   "--nice n        : Change process priority (>0 =3D lower, <0 =3D higher)=
=2E\n"
+#ifdef ENABLE_WTMP
+  "--log-wtmp server_id [file] : Enable logging to wtmp file using the two=
 digit\n"
+  "                  server_id a prefix for the utmp line. Optionally you =
can write\n"
+  "                  to an own wtmp file. (Default is /var/log/openvpn/wtm=
p)\n"
+#endif
 #if 0
 #ifdef USE_PTHREAD
   "--nice-work n   : Change thread priority of work thread.  The work\n"
@@ -697,6 +702,12 @@ init_options (struct options *o)
 #ifdef ENABLE_PKCS11
   o->pkcs11_pin_cache_period =3D -1;
 #endif			/* ENABLE_PKCS11 */
+
+#ifdef ENABLE_WTMP
+  o->log_wtmp =3D 0;
+  o->wtmp_server_id =3D 1;
+  o->wtmp_file =3D "/var/log/openvpn/wtmp";
+#endif
 }
=20
 void
@@ -3473,6 +3484,26 @@ add_option (struct options *options,
       options->log =3D true;
       redirect_stdout_stderr (p[1], false);
     }
+
+#ifdef ENABLE_WTMP
+  else if (streq (p[0], "log-wtmp") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+
+      /* Activate WTMP logging */
+      options->log_wtmp =3D 1;
+
+      /* Use server_id if set */
+      if (p[1])
+        options->wtmp_server_id =3D atoi (p[1]);
+
+      /* User specified wtmp file if set */
+      if (p[2])
+        options->wtmp_file =3D p[2];
+
+    }
+#endif
+
   else if (streq (p[0], "suppress-timestamps"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -3773,6 +3804,7 @@ add_option (struct options *options,
       openvpn_exit (OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
 #endif /* GENERAL_PROXY_SUPPORT */
+
 #ifdef ENABLE_HTTP_PROXY
   else if (streq (p[0], "http-proxy") && p[1])
     {
diff --git a/options.h b/options.h
index 21d131e..e7a49b9 100644
--- a/options.h
+++ b/options.h
@@ -214,6 +214,12 @@ struct options
   /* inetd modes defined in socket.h */
   int inetd;
=20
+#ifdef ENABLE_WTMP
+  int log_wtmp;
+  int wtmp_server_id;
+  char *wtmp_file;
+#endif
+
   bool log;
   bool suppress_timestamps;
   int nice;

--2oS5YaxWCcQjTEyO
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="04_Call_wtmp_logging_functions_if_configured.patch"
Content-Transfer-Encoding: quoted-printable

If WTMP support was enabled at compile time and activated in configuration
call wtmp_*() functions at startup and connection startup/end.
--
 multi.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)
diff --git a/multi.c b/multi.c
index fa924f1..2977029 100644
--- a/multi.c
+++ b/multi.c
@@ -42,6 +42,10 @@
=20
 #include "forward-inline.h"
=20
+#ifdef ENABLE_WTMP
+#include "wtmp.h"
+#endif
+
 /*#define MULTI_DEBUG_EVENT_LOOP*/
=20
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@ -457,6 +461,11 @@ multi_close_instance (struct multi_context *m,
=20
   dmsg (D_MULTI_DEBUG, "MULTI: multi_close_instance called");
=20
+#ifdef ENABLE_WTMP
+  if (m->top.options.log_wtmp)
+    wtmp_stop (mi);
+#endif
+
   /* prevent dangling pointers */
   if (m->pending =3D=3D mi)
     multi_set_pending (m, NULL);
@@ -1444,6 +1453,14 @@ multi_connection_established (struct multi_context *=
m, struct multi_instance *mi
 	}
 #endif
=20
+#ifdef ENABLE_WTMP
+      if (m->top.options.log_wtmp)
+	{
+	  mi->context.c1.wtmp_line =3D gen_wtmp_line ();
+	  wtmp_start (mi);
+	}
+#endif
+
       /*
        * Run --client-connect script.
        */
@@ -2289,6 +2306,11 @@ tunnel_server (struct context *top)
 {
   ASSERT (top->options.mode =3D=3D MODE_SERVER);
=20
+#ifdef ENABLE_WTMP
+  if (top->options.log_wtmp)
+    wtmp_init (&top->options);
+#endif
+
   switch (top->options.proto) {
   case PROTO_UDPv4:
     tunnel_server_udp (top);

--2oS5YaxWCcQjTEyO
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="05_Add_configure_option_for_wtmp.patch"
Content-Transfer-Encoding: quoted-printable

Add '--enable-wtmp' option to configure script to let users easily enable W=
TMP
log support.

If '--enable-wtmp' was given, check if 'utmp.h' is available on the system =
and
bail out if header file could not be found.
--
 configure.ac |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)
diff --git a/configure.ac b/configure.ac
index af57577..3706eb4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -137,6 +137,12 @@ AC_ARG_ENABLE(iproute2,
    AC_DEFINE(CONFIG_FEATURE_IPROUTE, 1, [enable iproute2 support])  =20
 )
=20
+AC_ARG_ENABLE(wtmp,
+   [  --enable-wtmp           Enable WTMP support (--log-wtmp)],
+   [LOG_WTMP=3D"$enableval"],
+   [LOG_WTMP=3D"no"]
+)
+
 AC_ARG_ENABLE(strict,
    [  --enable-strict         Enable strict compiler warnings (debugging o=
ption)],
    [STRICT=3D"$enableval"],
@@ -705,4 +711,13 @@ if test "$PASSWORD_SAVE" =3D "yes"; then
    AC_DEFINE(ENABLE_PASSWORD_SAVE, 1, [Allow --askpass and --auth-user-pas=
s passwords to be read from a file])
 fi
=20
+dnl enable wtmp logging
+if test "$LOG_WTMP" =3D "yes"; then
+
+  AC_CHECK_HEADER(utmp.h,
+  	[AC_DEFINE(ENABLE_WTMP, 1, [Enable wtmp logging support])],
+ 	[AC_MSG_ERROR([WTMP headers not found])]
+  )
+fi
+
 AC_OUTPUT(Makefile openvpn.spec)

--2oS5YaxWCcQjTEyO
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="06_Add_wtmp_stuff_to_Makefile.patch"
Content-Transfer-Encoding: quoted-printable

Updated Makefile.am to build wtmp object file.
--
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)
diff --git a/Makefile.am b/Makefile.am
index 36e2cf9..5f1489b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -94,7 +94,8 @@ openvpn_SOURCES =3D \
 	status.c status.h \
 	syshead.h \
 	thread.c thread.h \
-	tun.c tun.h
+	tun.c tun.h \
+	wtmp.c wtmp.h
=20
 LDADD =3D @LIBOBJS@
=20

--2oS5YaxWCcQjTEyO
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="07_Update__get_link_socket_info__to_accecp_const_value.patch"
Content-Transfer-Encoding: quoted-printable

Updated 'get_link_socket_info' function to use argument 'struct context *'
as a const value as it is not modified in this function.

This silences a gcc warning in wtmp.c.
--
 forward-inline.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
diff --git a/forward-inline.h b/forward-inline.h
index 09b9809..c3f60af 100644
--- a/forward-inline.h
+++ b/forward-inline.h
@@ -215,7 +215,7 @@ context_reschedule_sec (struct context *c, int sec)
 }
=20
 static inline struct link_socket_info *
-get_link_socket_info (struct context *c)
+get_link_socket_info (const struct context *c)
 {
   if (c->c2.link_socket_info)
     return c->c2.link_socket_info;

--2oS5YaxWCcQjTEyO--

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHEoUNKN2w/RnJtroRArKYAJ96CUbh4rcNdxNCFDONKweR1hLfCwCgxSCC
im+Ug6iptOJTSI12+BA4c74=
=3tlg
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--

