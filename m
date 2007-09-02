From: Maximilian Wilhelm <max@...1047...>
Date: Mon,  3 Sep 2007 01:13:59 +0200
Message-Id: <11887748434033-git-send-email-max@...1047...>
In-Reply-To: <11887748431930-git-send-email-max@...1047...>
References: <11887748431930-git-send-email-max@...1047...>
Subject: [Openvpn-devel] [PATCH] Added WTMP support for OpenVPN
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
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Maximilian Wilhelm <max@...1047...>
---
 wtmp.c |  333 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wtmp.h |   27 +++++
 2 files changed, 360 insertions(+), 0 deletions(-)
 create mode 100644 wtmp.c
 create mode 100644 wtmp.h

diff --git a/wtmp.c b/wtmp.c
new file mode 100644
index 0000000..39822df
--- /dev/null
+++ b/wtmp.c
@@ -0,0 +1,333 @@
+/*
+ * OpenVPN wtmp support
+ *
+ * Copyright: 2007 Maximilian Wilhelm <max@...1047...>
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
+#include <assert.h>
+#include <dirent.h>	/* opendir() */
+#include <stdio.h>	/* fopen() */
+#include <stdlib.h>	/* *alloc(), free() */
+#include <string.h>	/* strncpy(), strlen() */
+#include <sys/stat.h>	/* stat() */
+#include <sys/time.h>	/* struct timeval */
+#include <sys/types.h>	/* opendir() */
+#include <utmp.h>	/* utmp foo */
+
+#include "openvpn.h"	/* struct context* */
+#include "forward.h"
+#include "forward-inline.h"
+#include "multi.h"	/* struct multi_instance */
+#include "buffer.h"	/* struct buffer */
+
+#include "wtmp.h"
+
+int wtmp_active = 0;
+
+#define HAVE_ENDUTENT 1
+
+#define OVPN_WTMP_DEBUG 1
+
+/*
+ * Initialize wtmp subsystem
+ */
+int
+wtmp_init (unsigned int server_id, const char *wtmp_file_path)
+{
+#ifdef OVPN_WTMP_DEBUG
+	fprintf (stderr, "%s() called.\n", __FUNCTION__);
+#endif
+
+	struct stat wtmp_stat;
+	char *wtmp_file_dirname;
+	char *wtmp_file_path_copy;
+
+	/* Only initialize once */
+	if (wtmp_active == 1)
+		return 1;
+
+#ifdef OVPN_WTMP_DEBUG
+	fprintf (stderr, "wtmp_file_path = %s\n", wtmp_file_path);
+#endif
+
+	wtmp_file_path_copy = strdup (wtmp_file_path);
+	wtmp_file_dirname = dirname (wtmp_file_path_copy);
+
+	/* Check if WTMP_DIR exists and try to create it if not */
+	if (! opendir (wtmp_file_dirname)) {
+		fprintf (stderr, "%s: wtmp_file_dirname %s does not exist. Trying to create it.\n",
+			__FUNCTION__, wtmp_file_dirname);
+
+		if (mkdir (wtmp_file_dirname, 0700)) {
+			fprintf (stderr, "%s: Could not create directory %s\n",
+				__FUNCTION__, wtmp_file_dirname);
+			wtmp_active = 0;
+			goto out;
+		}
+
+		fprintf (stderr, "%s: Successfully created wtmp_file_dirname %s.\n",
+			__FUNCTION__, wtmp_file_dirname);
+	}
+
+	/* Check if wtmp_file_path exists and try to create it if not */
+	if (stat (wtmp_file_path, &wtmp_stat)) {
+		fprintf (stderr, "%s: wtmp_file %s does not exist or is not accessable. Trying to create it.\n",
+			__FUNCTION__, wtmp_file_path);
+
+		/* Touch wtmp_file */
+		if (! fopen (wtmp_file_path, "a")) {
+			fprintf (stderr, "%s: Could not create file %s.\n",
+				__FUNCTION__, wtmp_file_path);
+				wtmp_active = 0;
+				goto out;
+		}
+
+		fprintf (stderr, "%s: Successfully created wtmp_file %s.\n",
+			__FUNCTION__, wtmp_file_path);
+	} /* [ ! -f wtmp_file ] */
+
+	/* OK wtmp_file is (now) there, use it */
+	utmpname (wtmp_file_path);
+
+	/* Everything is fine */
+	wtmp_active = 1;
+
+out:
+	free (wtmp_file_path_copy);
+
+	return wtmp_active;
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
+        struct sockaddr_in *remote_addr;
+
+	char *temp;
+
+	if (wtmp_active == 0)
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
+	if (wtmp_active == 0)
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
+
+
+/* Build up and store an utmp line */
+void
+set_utmp_line (const struct multi_instance *mi, struct utmp *entry)
+{
+	struct gc_arena gc = gc_new ();
+	char *temp;
+
+	char line[UT_LINESIZE];
+
+	/* Should be config option */
+	unsigned int server_num = 1;
+
+	assert (mi);
+	assert (entry);
+
+	temp = format_hex_ex (mi->context.c2.tls_multi->session[TM_ACTIVE].session_id.id, SID_SIZE, 0, 4, "", &gc);
+
+	if (temp) {
+		snprintf (entry->ut_line, UT_LINESIZE, "ovpn%02d-%s", server_num, temp);
+	} else {
+		snprintf (entry->ut_line, UT_LINESIZE, "ovpn%02d", server_num);
+	}
+}
+
+
+/* Store the first 4 chars of the session_id as the utmp id */
+void
+set_utmp_id (const struct multi_instance *mi, struct utmp *entry)
+{
+	struct gc_arena gc = gc_new ();
+	char *temp;
+
+	assert (mi);
+	assert (entry);
+
+	temp = format_hex_ex (mi->context.c2.tls_multi->session[TM_ACTIVE].session_id.id, SID_SIZE, 0, 4, " ", &gc);
+	if (temp) {
+		snprintf (entry->ut_id, 4, "%s", temp);
+	}
+}
+
+
+/* Store a human readable format of the VPN ip address we gave to the client as utmp hostname */
+void
+set_utmp_hostname (const struct multi_instance *mi, struct utmp *entry)
+{
+	unsigned int ip;
+
+	assert (mi);
+	assert (entry);
+
+	memset (entry->ut_host, '\0', UT_HOSTSIZE);
+
+	ip =  mi->context.c2.push_ifconfig_local;
+	snprintf (entry->ut_host, UT_HOSTSIZE, "%d.%d.%d.%d", ip >> 24, (ip >> 16) & 0xff, (ip >> 8) & 0xff, (ip >> 0) & 0xff);
+}
+
+
+/* Store the username of the current session in the utmp entry */
+void
+set_utmp_username (const struct multi_instance *mi, struct utmp *entry)
+{
+	const char *username;
+
+	assert (mi);
+	assert (entry);
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
+	assert (mi);
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
+ * Some helper functions, partly stolen from OpenSSH/loginrec.c
+ *
+ */
+
+
+/* Store the current time in utmp struct */
+static void
+set_utmp_time (struct utmp *ut)
+{
+	struct timeval tv;
+
+	assert (ut);
+
+	gettimeofday(&tv, NULL);
+	ut->ut_tv.tv_sec = tv.tv_sec;
+	ut->ut_tv.tv_usec = tv.tv_usec;
+
+	ut->ut_time = tv.tv_sec;
+}
+#endif /* ENABLE_WTMP */
+
+
diff --git a/wtmp.h b/wtmp.h
new file mode 100644
index 0000000..c43b472
--- /dev/null
+++ b/wtmp.h
@@ -0,0 +1,27 @@
+#ifndef _OPENVPN_WTMP_H
+#define _OPENVPN_WTMP_H
+
+#include <utmp.h>
+
+#include "multi.h"
+
+#define OVPN_WTMP_DIR  "/tmp"
+#define OVPN_WTMP_FILENAME "ovpnwtmp"
+
+enum local_remote { LOCAL, REMOTE };
+
+int wtmp_init ();
+
+void wtmp_start (const struct multi_instance *mi);
+void wtmp_stop (const struct multi_instance *mi);
+
+static void set_utmp_time (struct utmp *ut);
+
+void set_utmp_hostname (const struct multi_instance *mi, struct utmp *entry);
+void set_utmp_id (const struct multi_instance *mi, struct utmp *entry);
+void set_utmp_line (const struct multi_instance *mi, struct utmp *entry);
+void set_utmp_username (const struct multi_instance *mi, struct utmp *entry);
+
+static struct sockaddr_in * get_remote_sockaddr_from_multi_instance (const struct multi_instance *mi);
+
+#endif /* _OPENVPN_WTMP_H */
-- 
1.5.2.4


