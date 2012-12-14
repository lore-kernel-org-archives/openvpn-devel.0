From: Joachim Schipper <joachim.schipper@...1435...>
Date: Fri, 14 Dec 2012 15:54:10 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B901329E4C312@...1436...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add a basic --management-external-key
	client to contrib/
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

A very simple client for --management-external-key based on an on-disk keyf=
ile.
Useful for testing.

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
---
 .gitignore                                         |    1 +
 contrib/management-external-key-client/Makefile    |   12 +
 contrib/management-external-key-client/README      |   12 +
 .../management_external_key.c                      |  349 ++++++++++++++++=
++++
 4 files changed, 374 insertions(+)
 create mode 100644 contrib/management-external-key-client/Makefile
 create mode 100644 contrib/management-external-key-client/README
 create mode 100644 contrib/management-external-key-client/management_exter=
nal_key.c

diff --git a/.gitignore b/.gitignore
index a04afff..a8fb8a6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -48,6 +48,7 @@ version.sh
 msvc-env-local.bat
 config-msvc-local.h
 config-msvc-version.h
+contrib/management-external-key-client/management_external_key
 doc/openvpn.8.html
 distro/rpm/openvpn.spec
 tests/t_client.sh
diff --git a/contrib/management-external-key-client/Makefile b/contrib/mana=
gement-external-key-client/Makefile
new file mode 100644
index 0000000..bad83b0
--- /dev/null
+++ b/contrib/management-external-key-client/Makefile
@@ -0,0 +1,12 @@
+.PHONY: clean
+
+#POLARSSL_INCLUDES?=3D-I/usr/local/include
+#POLARSSL_LDFLAGS?=3D-L/usr/local/lib -static
+CFLAGS=3D-O2 -g -W -Wall -Wextra -Wdeclaration-after-statement ${POLARSSL_=
INCLUDES}
+LDFLAGS=3D${POLARSSL_LDFLAGS}
+
+management_external_key: management_external_key.c
+	${CC} ${CFLAGS} ${LDFLAGS} -o management_external_key management_external=
_key.c -lpolarssl
+
+clean:
+	rm -f management_external_key
diff --git a/contrib/management-external-key-client/README b/contrib/manage=
ment-external-key-client/README
new file mode 100644
index 0000000..78df077
--- /dev/null
+++ b/contrib/management-external-key-client/README
@@ -0,0 +1,12 @@
+When given the --management-external-key option, OpenVPN does not use a pr=
ivate
+key to sign SSL handshakes, but instead requests a signature over the
+management interface.
+
+This is a simple client for the management interface that uses a private k=
ey
+stored in a PEM file to create the signatures.
+
+You'll need PolarSSL to compile this code. Run management_external_key for
+instructions.
+
+Note that this is not production-ready code. It may, however, be useful for
+testing purposes.
diff --git a/contrib/management-external-key-client/management_external_key=
.c b/contrib/management-external-key-client/management_external_key.c
new file mode 100644
index 0000000..f57a084
--- /dev/null
+++ b/contrib/management-external-key-client/management_external_key.c
@@ -0,0 +1,349 @@
+/*
+ *  A simple client for openvpn --management-external-key.
+ *
+ *  Copyright (C) 2012 Fox Crypto B.V. <openvpn@...1435...>
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * This code depends only on PolarSSL.
+ */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netdb.h>
+
+#include <assert.h>
+#include <err.h>
+#include <errno.h>
+#include <getopt.h>
+#include <limits.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <polarssl/base64.h>
+#include <polarssl/error.h>
+#include <polarssl/rsa.h>
+#include <polarssl/x509.h>
+
+#define USAGE ("Usage: %s [-l] [-H host] port key\n" \
+    "Client for openvpn --management-external-key\n" \
+    "\n" \
+    "  -H host  connect to host instead of localhost\n" \
+    "  -l       request OpenVPN logs\n" \
+    "  port     port of the OpenVPN management interface\n" \
+    "  key      keyfile (in PEM format) to use\n")
+
+/* Management interface requesting a signature */
+#define RSA_PROMPT_PREFIX ">RSA_SIGN:"
+#define RSA_RESP_PREFIX "rsa-sig\r\n"
+#define RSA_RESP_SUFFIX "\r\nEND\r\n"
+
+#ifndef __GNUC__
+#define __attribute__(x) /* gcc only */
+#endif
+
+int main(int argc, char **argv);
+/* Connect to management interface; returns socket or terminates program */
+static inline int open_sock(const char *host, const char *port);
+/* Communicate with OpenVPN */
+static inline void management_client(int management_sock, const char *keyf=
ile,
+    int request_logs) __attribute__((noreturn));
+/*
+ * Write some initial commands requesting logs etc. Returns 0 on success, =
or
+ * nonzero and sets errno.
+ */
+static inline int write_initial_commands(int management_sock,
+    int request_logs);
+/*
+ * Handle a line of line_len characters; if partial, line is an incomplete=
 last
+ * line.
+ *
+ * Returns a pointer to a statically allocated string containing a respons=
e, or
+ * NULL on error.
+ */
+static inline const char *handle_line(const char *line, size_t line_len,
+    int partial, rsa_context *rsa);
+/* Called by handle_line() to handle RSA_SIGN requests */
+static inline const char *rsa_resp(const char *line, size_t line_len,
+    rsa_context *rsa);
+static char handle_line_resp[1024];
+/* Repeated write: like write(), but continue writing on signals etc. */
+static inline ssize_t rwrite(int fd, const void *buf, size_t count);
+
+int
+main(int argc, char **argv)
+{
+	const char	*port, *host, *progname, *keyfile;
+	int		 sock, opt, request_logs;
+
+	/*
+	 * Parse arguments
+	 */
+	progname =3D argv[0];
+
+	request_logs =3D 0;
+	host =3D "localhost";
+
+	while ((opt =3D getopt(argc, argv, "lH:")) !=3D -1) {
+		switch (opt) {
+		case 'l':
+			request_logs =3D 1;
+			break;
+		case 'H':
+			host =3D optarg;
+			break;
+		default:
+			errx(127, USAGE, progname);
+		}
+	}
+	argc -=3D optind;
+	argv +=3D optind;
+
+	if (argc !=3D 2)
+		errx(127, USAGE, progname);
+
+	port =3D argv[0];
+	keyfile =3D argv[1];
+
+	/* XXX Management protocol password? */
+
+	sock =3D open_sock(host, port);
+
+	management_client(sock, keyfile, request_logs);
+	/* NOTREACHED */
+}
+
+static inline int
+open_sock(const char *host, const char *port)
+{
+	struct addrinfo		*addrs, hints;
+	int			 rv, sock;
+
+	bzero(&hints, sizeof(hints));
+	hints.ai_family =3D AF_UNSPEC;
+	hints.ai_socktype =3D SOCK_STREAM;
+	if ((rv =3D getaddrinfo(host, port, NULL, &addrs)) !=3D 0)
+		errx(1, "Failed to resolve %s port %s: %s", host, port,
+		    gai_strerror(rv));
+
+	if ((sock =3D socket(AF_INET, SOCK_STREAM, 0)) =3D=3D -1)
+		err(1, "Failed to create socket");
+
+	/* Connect to first address; good enough. */
+	if (connect(sock, addrs[0].ai_addr, addrs[0].ai_addrlen) !=3D 0)
+		err(1, "Failed to connect to %s port %s", host, port);
+
+	return sock;
+}
+
+static inline void
+management_client(int management_sock, const char *keyfile, int request_lo=
gs)
+{
+	char		 buf[4096];
+	const char	*resp;
+	size_t		 buf_len, i, eol;
+	ssize_t		 bytes_read;
+	int		 rv;
+	rsa_context	 rsa;
+
+	if ((rv =3D x509parse_keyfile(&rsa, keyfile, NULL)) !=3D 0) {
+		error_strerror(rv, buf, sizeof(buf));
+		errx(1, "Failed to load %s: %s", keyfile, buf);
+	}
+
+	if (write_initial_commands(management_sock, request_logs) !=3D 0)
+		err(1, "Failed to write initial commands\n");
+
+	buf_len =3D 0;
+	while (1) {
+		/*
+		 * Read from management interface
+		 */
+		if (sizeof(buf) - buf_len =3D=3D 0)
+			err(1, "Line longer than buffer");
+
+		bytes_read =3D read(management_sock, &buf[buf_len],
+		    sizeof(buf) - buf_len);
+		if (bytes_read =3D=3D -1) {
+			if (errno =3D=3D EAGAIN || errno =3D=3D EINTR)
+				continue;
+			err(1, "Failed to read()");
+		}
+
+		if (bytes_read =3D=3D 0) {
+			(void) handle_line(buf, buf_len, 1, &rsa);
+			fprintf(stderr, "Management connection terminated.\n");
+			exit(0);
+		}
+
+		buf_len +=3D bytes_read;
+
+		i =3D 0;
+		while (1) {
+			/*
+			 * Find whole line in buf[i..eol] and parse it.
+			 */
+			for (eol =3D i;
+			    eol < buf_len && buf[eol] !=3D '\n';
+			    eol++);
+			if (eol =3D=3D buf_len)
+				break;
+
+			assert(buf[eol] =3D=3D '\n');
+
+			if ((resp =3D handle_line(&buf[i], eol + 1 - i, 0, &rsa))
+			    =3D=3D NULL)
+				errx(1, "Failed to handle line");
+			errno =3D EINVAL;
+			if (strlen(resp) > SSIZE_MAX ||
+			    rwrite(management_sock, resp, strlen(resp)) !=3D
+			    (ssize_t) strlen(resp))
+				err(1, "Failed to write response (\"%s\")",
+				    resp);
+
+			i =3D eol + 1;
+		}
+
+		/* Copy unparsed data to front (fast enough) */
+		bcopy(&buf[i], buf, buf_len - i);
+		buf_len -=3D i;
+	}
+	/* NOTREACHED */
+}
+
+static inline int
+write_initial_commands(int management_sock, int request_logs)
+{
+	const char *initial_commands;
+
+	if (request_logs)
+		initial_commands =3D "log on all\necho on all\nbytecount 10\n";
+	else
+		initial_commands =3D "echo on all\nbytecount 10\n";
+
+	if (rwrite(management_sock, initial_commands,
+		    strlen(initial_commands)) !=3D
+	    (ssize_t) strlen(initial_commands))
+		return -1;
+
+	return 0;
+}
+
+static inline const char *
+handle_line(const char *line, size_t line_len, int partial_line,
+    rsa_context *rsa)
+{
+	size_t			 i;
+
+	/* Print line */
+	for (i =3D 0; i < line_len; i++)
+		putchar(line[i]);
+	if (partial_line)
+		putchar('\n');
+
+	if (!partial_line && line_len >=3D sizeof(RSA_PROMPT_PREFIX) &&
+	    strncmp(line, RSA_PROMPT_PREFIX, sizeof(RSA_PROMPT_PREFIX) - 1)
+	    =3D=3D 0)
+		return rsa_resp(line, line_len, rsa);
+	else {
+		/* Not an RSA_SIGN request, stop processing */
+		handle_line_resp[0] =3D '\0';
+		return handle_line_resp;
+	}
+}
+
+static inline const char *
+rsa_resp(const char *line, size_t line_len, rsa_context *rsa)
+{
+	unsigned char		 raw_data[1024], sig[1024];
+	size_t			 raw_data_len, out_len;
+
+	/* Base64-decode the relevant part of the line into raw_data */
+	assert(line_len >=3D sizeof(RSA_PROMPT_PREFIX) - 1);
+	assert(strncmp(line, RSA_PROMPT_PREFIX, sizeof(RSA_PROMPT_PREFIX) - 1)
+	    =3D=3D 0);
+	assert(line[line_len - 2] =3D=3D '\r');
+	assert(line[line_len - 1] =3D=3D '\n');
+
+	raw_data_len =3D sizeof(raw_data);
+	if (base64_decode(raw_data, &raw_data_len,
+		    (const unsigned char *)
+		    &line[sizeof(RSA_PROMPT_PREFIX) - 1],
+		    line_len - (sizeof(RSA_PROMPT_PREFIX) - 1) - 2) !=3D 0)
+		goto err;
+
+	/*
+	 * Sign raw_data.
+	 *
+	 * Note that we need no PRNG (f_prng =3D NULL) for PKCS1.5 encoding
+	 */
+	if (sizeof(sig) < rsa->len ||
+	    rsa_pkcs1_sign(rsa, NULL, NULL, RSA_PRIVATE, SIG_RSA_RAW,
+		    raw_data_len, raw_data, sig) !=3D 0)
+		goto err;
+
+	/* Base64-encode signature */
+	memcpy(handle_line_resp, RSA_RESP_PREFIX, sizeof(RSA_RESP_PREFIX) - 1);
+
+	out_len =3D sizeof(handle_line_resp) - (sizeof(RSA_RESP_PREFIX) - 1) -
+	    (sizeof(RSA_RESP_SUFFIX) - 1) + 1;
+	if (base64_encode((unsigned char *)
+		    &handle_line_resp[sizeof(RSA_RESP_PREFIX) - 1], &out_len,
+		    sig, rsa->len) !=3D 0)
+		goto err;
+	out_len +=3D sizeof(RSA_RESP_PREFIX) - 1;
+
+	memcpy(&handle_line_resp[out_len], RSA_RESP_SUFFIX,
+	    sizeof(RSA_RESP_SUFFIX) - 1);
+
+	return handle_line_resp;
+
+err:
+	return NULL;
+}
+
+static inline ssize_t
+rwrite(int fd, const void *vbuf, size_t count)
+{
+	const char * const
+	    		 buf =3D vbuf;
+	size_t		 i;
+	ssize_t		 bytes_written;
+	int		 old_errno;
+
+	old_errno =3D errno;
+
+	i =3D 0;
+	do {
+		bytes_written =3D write(fd, &buf[i], count - i);
+		if (bytes_written =3D=3D -1) {
+			if (errno =3D=3D EINTR || errno =3D=3D EAGAIN)
+				continue;
+			return bytes_written;
+		}
+		if (bytes_written =3D=3D 0)
+			goto done;
+
+		i +=3D bytes_written;
+	} while (i < count);
+
+done:
+	errno =3D old_errno;
+	return i;
+}
--=20
1.7.9.5


