From: William Preston <openvpn@...275...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1OZ2A5IUG1YOR6KRT00M"
Message-Id: <200409151352.49215.openvpn@...275...>
Subject: [Openvpn-devel] proxy ntlm support
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
Date: Wed Sep 15 04:54:06 2004
To: openvpn-devel@lists.sourceforge.net

--------------Boundary-00=_1OZ2A5IUG1YOR6KRT00M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


hello list,

here's a patch to add basic ntlm support to openvpn 1.6.0
i've tested it with i386 linux & win32 against MS ISA proxy.

it includes base64 code from heimdal...

- hope it's useful to somebody.

William=

--------------Boundary-00=_1OZ2A5IUG1YOR6KRT00M
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ntlm3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ntlm3.patch"

--- openvpn/base64.c=09Thu Sep  2 17:00:25 2004
+++ openvpn-1.6.0/base64.c=09Thu Sep  2 17:06:36 2004
@@ -0,0 +1,135 @@
+/*
+ * Copyright (c) 1995-2001 Kungliga Tekniska H=F6gskolan
+ * (Royal Institute of Technology, Stockholm, Sweden).
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ *
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in th=
e
+ *    documentation and/or other materials provided with the distributio=
n.
+ *
+ * 3. Neither the name of the Institute nor the names of its contributor=
s
+ *    may be used to endorse or promote products derived from this softw=
are
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE INSTITUTE AND CONTRIBUTORS ``AS IS''=
 AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE INSTITUTE OR CONTRIBUTORS BE L=
IABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUE=
NTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOO=
DS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, S=
TRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
+ * SUCH DAMAGE.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+#include <stdlib.h>
+#include <string.h>
+#include "base64.h"
+
+static char base64_chars[] =3D=20
+    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
+
+static int=20
+pos(char c)
+{
+    char *p;
+    for (p =3D base64_chars; *p; p++)
+=09if (*p =3D=3D c)
+=09    return p - base64_chars;
+    return -1;
+}
+
+int=20
+base64_encode(const void *data, int size, char **str)
+{
+    char *s, *p;
+    int i;
+    int c;
+    const unsigned char *q;
+
+    p =3D s =3D (char *) malloc(size * 4 / 3 + 4);
+    if (p =3D=3D NULL)
+=09return -1;
+    q =3D (const unsigned char *) data;
+    i =3D 0;
+    for (i =3D 0; i < size;) {
+=09c =3D q[i++];
+=09c *=3D 256;
+=09if (i < size)
+=09    c +=3D q[i];
+=09i++;
+=09c *=3D 256;
+=09if (i < size)
+=09    c +=3D q[i];
+=09i++;
+=09p[0] =3D base64_chars[(c & 0x00fc0000) >> 18];
+=09p[1] =3D base64_chars[(c & 0x0003f000) >> 12];
+=09p[2] =3D base64_chars[(c & 0x00000fc0) >> 6];
+=09p[3] =3D base64_chars[(c & 0x0000003f) >> 0];
+=09if (i > size)
+=09    p[3] =3D '=3D';
+=09if (i > size + 1)
+=09    p[2] =3D '=3D';
+=09p +=3D 4;
+    }
+    *p =3D 0;
+    *str =3D s;
+    return strlen(s);
+}
+
+#define DECODE_ERROR 0xffffffff
+
+static unsigned int
+token_decode(const char *token)
+{
+    int i;
+    unsigned int val =3D 0;
+    int marker =3D 0;
+    if (strlen(token) < 4)
+=09return DECODE_ERROR;
+    for (i =3D 0; i < 4; i++) {
+=09val *=3D 64;
+=09if (token[i] =3D=3D '=3D')
+=09    marker++;
+=09else if (marker > 0)
+=09    return DECODE_ERROR;
+=09else
+=09    val +=3D pos(token[i]);
+    }
+    if (marker > 2)
+=09return DECODE_ERROR;
+    return (marker << 24) | val;
+}
+
+int
+base64_decode(const char *str, void *data)
+{
+    const char *p;
+    unsigned char *q;
+
+    q =3D data;
+    for (p =3D str; *p && (*p =3D=3D '=3D' || strchr(base64_chars, *p));=
 p +=3D 4) {
+=09unsigned int val =3D token_decode(p);
+=09unsigned int marker =3D (val >> 24) & 0xff;
+=09if (val =3D=3D DECODE_ERROR)
+=09    return -1;
+=09*q++ =3D (val >> 16) & 0xff;
+=09if (marker < 2)
+=09    *q++ =3D (val >> 8) & 0xff;
+=09if (marker < 1)
+=09    *q++ =3D val & 0xff;
+    }
+    return q - (unsigned char *) data;
+}
--- openvpn/base64.h=09Thu Sep  2 17:00:26 2004
+++ openvpn-1.6.0/base64.h=09Thu Sep  2 17:06:38 2004
@@ -0,0 +1,42 @@
+/*
+ * Copyright (c) 1995, 1996, 1997 Kungliga Tekniska H=F6gskolan
+ * (Royal Institute of Technology, Stockholm, Sweden).
+ * All rights reserved.
+ *=20
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *=20
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ *=20
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in th=
e
+ *    documentation and/or other materials provided with the distributio=
n.
+ *=20
+ * 3. Neither the name of the Institute nor the names of its contributor=
s
+ *    may be used to endorse or promote products derived from this softw=
are
+ *    without specific prior written permission.
+ *=20
+ * THIS SOFTWARE IS PROVIDED BY THE INSTITUTE AND CONTRIBUTORS ``AS IS''=
 AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE INSTITUTE OR CONTRIBUTORS BE L=
IABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUE=
NTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOO=
DS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, S=
TRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
+ * SUCH DAMAGE.
+ */
+
+/* $KTH: base64.h,v 1.2 1999/12/02 16:58:45 joda Exp $ */
+
+#ifndef _BASE64_H_
+#define _BASE64_H_
+
+int base64_encode(const void *data, int size, char **str);
+int base64_decode(const char *str, void *data);
+
+#endif
--- openvpn/ntlm.c=09Thu Sep  2 17:00:33 2004
+++ openvpn-1.6.0/ntlm.c=09Thu Sep  2 17:06:43 2004
@@ -0,0 +1,188 @@
+/*
+ *  ntlm proxy support for OpenVPN
+ *
+ *  Copyright (C) 2004 William Preston
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
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
+#ifdef WIN32
+#include "config-win32.h"
+#else
+#include "config.h"
+#endif
+
+#include <openssl/des.h>
+#include <openssl/md4.h>
+#include "syshead.h"
+
+#include "common.h"
+#include "buffer.h"
+#include "misc.h"
+#include "io.h"
+#include "socket.h"
+#include "fdmisc.h"
+#include "proxy.h"
+#include "ntlm.h"
+#include "base64.h"
+#include "memdbg.h"
+
+
+static void create_des_keys(const unsigned char *hash, unsigned char *ke=
y)
+{
+        int i;
+
+        key[0] =3D hash[0];
+        key[1] =3D ((hash[0]&1)<<7)|(hash[1]>>1);
+        key[2] =3D ((hash[1]&3)<<6)|(hash[2]>>2);
+        key[3] =3D ((hash[2]&7)<<5)|(hash[3]>>3);
+        key[4] =3D ((hash[3]&15)<<4)|(hash[4]>>4);
+        key[5] =3D ((hash[4]&31)<<3)|(hash[5]>>5);
+        key[6] =3D ((hash[5]&63)<<2)|(hash[6]>>6);
+        key[7] =3D ((hash[6]&127)<<1);
+        des_set_odd_parity((des_cblock *)key);
+}
+
+
+static void gen_md4_hash (const char* data, int data_len, char *result)
+{
+  // result is 16 byte md4 hash
+
+  MD4_CTX c;
+  char md[16];
+
+  MD4_Init (&c);
+  MD4_Update (&c, data, data_len);
+  MD4_Final (md, &c);
+
+  memcpy (result, md, 16);
+}
+
+static int unicodize (char *dst, const char *src)
+{
+  // not really unicode...
+  int i =3D 0;
+  do
+    {
+      dst[i++] =3D *src;
+      dst[i++] =3D 0;
+    }
+  while (*src++);
+
+  return i;
+}
+
+const char *
+ntlm_phase_1 (const struct http_proxy_info *p)
+{
+  struct buffer out =3D alloc_buf_gc (96);
+  /* try a minimal NTLM handshake
+   *
+   * http://davenport.sourceforge.net/ntlm.html
+   *
+   * This message contains only the NTLMSSP signature,
+   * the NTLM message type,
+   * and the minimal set of flags (Negotiate NTLM and Negotiate OEM).
+   *
+   */
+  buf_printf (&out, "%s", "TlRMTVNTUAABAAAAAgIAAA=3D=3D");
+  return (BSTR (&out));
+}
+
+const char *
+ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2)
+{
+  char pwbuf[sizeof (p->password) * 2]; // for unicode password
+  char buf2[128]; // decoded reply from proxy
+  char phase3[146];
+
+  char md4_hash[21];
+  char challenge[8], response[24];
+  int i, ret_val, buflen;
+  uint8_t *b64;
+  des_cblock key1, key2, key3;
+  des_key_schedule sched1, sched2, sched3;
+
+  /* try a minimal NTLM handshake
+   *
+   * http://davenport.sourceforge.net/ntlm.html
+   *
+   */
+  ASSERT (strlen (p->username) > 0);
+  ASSERT (strlen (p->password) > 0);
+
+  // fill 1st 16 bytes with md4 hash, disregard terminating null
+  gen_md4_hash (pwbuf, unicodize (pwbuf, p->password) - 2, md4_hash);
+
+  //pad to 21 bytes
+  memset (md4_hash + 16, 0, 5);
+
+  ret_val =3D base64_decode( phase_2, (void *)buf2);
+  /* we can be sure that phase_2 is less than 128
+   * therefore buf2 needs to be (3/4 * 128) */
+
+  // extract the challenge from bytes 24-31
+  for (i=3D0; i<8; i++)
+  {
+    challenge[i] =3D buf2[i+24];
+  }
+
+ =20
+  create_des_keys (md4_hash, key1);
+  des_set_key_unchecked ((des_cblock *)key1, sched1);
+  des_ecb_encrypt ((des_cblock *)challenge, (des_cblock *)response, sche=
d1, DES_ENCRYPT);
+
+  create_des_keys (&(md4_hash[7]), key2);
+  des_set_key_unchecked ((des_cblock *)key2, sched2);
+  des_ecb_encrypt ((des_cblock *)challenge, (des_cblock *)&(response[8])=
, sched2, DES_ENCRYPT);
+
+  create_des_keys (&(md4_hash[14]), key3);
+  des_set_key_unchecked ((des_cblock *)key3, sched3);
+  des_ecb_encrypt ((des_cblock *)challenge, (des_cblock *)&(response[16]=
), sched3, DES_ENCRYPT);
+
+  //clear reply
+  memset (phase3, 0, sizeof (phase3));
+
+  strcpy (phase3, "NTLMSSP\0");
+  phase3[8] =3D 3; // type 3
+
+  buflen =3D 0x58 + strlen (p->username);
+  if (buflen > sizeof (phase3))
+    buflen =3D sizeof (phase3);
+
+  phase3[0x10] =3D buflen; // lm not used
+  phase3[0x20] =3D buflen; // default domain (i.e. proxy's domain)
+  phase3[0x30] =3D buflen; // no workstation name supplied
+  phase3[0x38] =3D buflen; // no session key
+
+  phase3[0x14] =3D 24; // ntlm response is 24 bytes long
+  phase3[0x16] =3D phase3[0x14];
+  phase3[0x18] =3D 0x40; // ntlm offset
+  memcpy (&(phase3[0x40]), response, 24);
+
+
+  phase3[0x24] =3D strlen (p->username); // username in ascii
+  phase3[0x26] =3D phase3[0x24];
+  phase3[0x28] =3D 0x58;
+  strncpy (&(phase3[0x58]), p->username, sizeof (phase3) - 0x58);
+
+  phase3[0x3c] =3D 0x02; // negotiate oem
+  phase3[0x3d] =3D 0x02; // negotiate ntlm
+
+ =20
+  return (make_base64_string2 (phase3, buflen));
+ =20
+}
--- openvpn/ntlm.h=09Thu Sep  2 17:00:35 2004
+++ openvpn-1.6.0/ntlm.h=09Thu Sep  2 17:06:45 2004
@@ -0,0 +1,7 @@
+#ifndef NTLM_H
+#define NTLM_H
+
+const char * ntlm_phase_1 (const struct http_proxy_info *p);
+const char * ntlm_phase_3 (const struct http_proxy_info *p, const char *=
phase_2);
+
+#endif
--- openvpn/options.c=09Thu Mar  4 09:50:32 2004
+++ openvpn-1.6.0/options.c=09Tue Aug  3 17:21:28 2004
@@ -86,9 +86,10 @@
   "                  p =3D udp (default), tcp-server, or tcp-client\n"
   "--connect-retry n : For --proto tcp-client, number of seconds to wait=
\n"
   "                  between connection retries (default=3D%d).\n"
-  "--http-proxy s p [up]: Connect to remote host through an HTTP proxy a=
t address\n"
+  "--http-proxy s p [up] [auth]: Connect to remote host through an HTTP =
proxy at address\n"
   "                  s and port p.  If proxy authentication is required,=
 up is a\n"
-  "                  file containing username/password on 2 lines.\n"
+  "                  file containing username/password on 2 lines.  Add =
ntlm if\n"
+  "                  the proxy requires NTLM authentication\n"
   "--http-proxy-retry : Retry indefinitely on HTTP proxy errors.\n"
   "--socks-proxy s [p]: Connect to remote host through a Socks5 proxy at=
 address\n"
   "                  s and port p (default port =3D 1080).\n"
@@ -1481,6 +1482,12 @@
 =09  ++i;
 =09  options->http_proxy_auth_method =3D "basic";
 =09  options->http_proxy_auth_file =3D p[3];
+
+=09  if (p[4])
+=09  {
+=09    options->http_proxy_auth_method =3D p[4];
+=09  }
+
 =09}
       else
 =09{
--- openvpn/proxy.c=09Mon Feb 23 04:58:45 2004
+++ openvpn-1.6.0/proxy.c=09Thu Sep  2 17:32:30 2004
@@ -38,6 +38,7 @@
 #include "socket.h"
 #include "fdmisc.h"
 #include "proxy.h"
+#include "ntlm.h"
=20
 #include "memdbg.h"
=20
@@ -185,8 +186,8 @@
   return send_line_crlf (sd, "");
 }
=20
-static uint8_t *
-make_base64_string (const uint8_t *str)
+uint8_t *
+make_base64_string2 (const uint8_t *str, int src_len)
 {
   static const char base64_table[] =3D
     "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
@@ -194,10 +195,9 @@
   uint8_t *buf;
   const uint8_t *src;
   uint8_t *dst;
-  int bits, data, src_len, dst_len;
+  int bits, data, dst_len;
=20
   /* make base64 string */
-  src_len =3D strlen (str);
   dst_len =3D (src_len + 2) / 3 * 4;
   buf =3D gc_malloc (dst_len + 1);
   bits =3D data =3D 0;
@@ -209,8 +209,7 @@
 =09{
 =09  data =3D (data << 8) | *src;
 =09  bits +=3D 8;
-=09  if (*src !=3D 0)
-=09    src++;
+=09  src++;
 =09}
       *dst++ =3D base64_table[0x3F & (data >> (bits - 6))];
       bits -=3D 6;
@@ -228,6 +227,12 @@
   return buf;
 }
=20
+uint8_t *
+make_base64_string (const uint8_t *str)
+{
+  return make_base64_string2 (str, strlen (str));
+}
+
 static const char *
 username_password_as_base64 (const struct http_proxy_info *p)
 {
@@ -261,20 +266,21 @@
 =09p->auth_method =3D HTTP_AUTH_NONE;
       else if (!strcmp (auth_method, "basic"))
 =09p->auth_method =3D HTTP_AUTH_BASIC;
+      else if (!strcmp (auth_method, "ntlm"))
+=09p->auth_method =3D HTTP_AUTH_NTLM;
       else
-=09msg (M_FATAL, "ERROR: unknown HTTP authentication method: '%s' -- onl=
y the 'none' or 'basic' methods are currently supported",
+=09msg (M_FATAL, "ERROR: unknown HTTP authentication method: '%s' -- onl=
y the 'none', 'basic', or 'ntlm' methods are currently supported",
 =09     auth_method);
     }
=20
   /* only basic authentication supported so far */
-  if (p->auth_method =3D=3D HTTP_AUTH_BASIC)
+  if (p->auth_method =3D=3D HTTP_AUTH_BASIC || p->auth_method =3D=3D HTT=
P_AUTH_NTLM)
     {
       FILE *fp;
      =20
       if (!auth_file)
 =09msg (M_FATAL, "ERROR: http proxy authentication requires a username/p=
assword file");
=20
-      p->auth_method =3D HTTP_AUTH_BASIC;
       warn_if_group_others_accessible (auth_file);
       fp =3D fopen (auth_file, "r");
       if (!fp)
@@ -304,7 +310,9 @@
 =09=09=09       struct buffer *lookahead,
 =09=09=09       volatile int *signal_received)
 {
-  char buf[128];
+  char buf[256];
+  char buf2[128];
+  char get[80];
   int status;
   int nparms;
=20
@@ -316,6 +324,13 @@
   if (!send_line_crlf (sd, buf))
     goto error;
=20
+  /* send HOST etc, */
+  sleep (1);
+  openvpn_snprintf (buf, sizeof(buf), "Host: %s", host);
+  msg (D_PROXY, "Send to HTTP proxy: '%s'", buf);
+  if (!send_line_crlf (sd, buf))
+    goto error;
+
   /* auth specified? */
   switch (p->auth_method)
     {
@@ -332,6 +347,16 @@
 =09goto error;
       break;
=20
+    case HTTP_AUTH_NTLM:
+      openvpn_snprintf (buf, sizeof(buf), "Proxy-Authorization: NTLM %s"=
,
+=09=09=09ntlm_phase_1 (p));
+      msg (D_PROXY, "Attempting NTLM Proxy-Authorization phase 1");
+      msg (D_SHOW_KEYS, "Send to HTTP proxy: '%s'", buf);
+      sleep (1);
+      if (!send_line_crlf (sd, buf))
+=09goto error;
+      break;
+
     default:
       ASSERT (0);
     }
@@ -353,11 +378,94 @@
   /* parse return string */
   nparms =3D sscanf (buf, "%*s %d", &status);
=20
+  /* check for a "407 Proxy Authentication Required" response */
+  if (nparms >=3D 1 && status =3D=3D 407)
+    {
+      msg (D_PROXY, "Proxy requires authentication");
+
+      // check for NTLM
+      if (p->auth_method =3D=3D HTTP_AUTH_NTLM)
+        {
+          // look for the phase 2 response
+
+          while (true)
+            {
+              if (!recv_line (sd, buf, sizeof(buf), 5, true, NULL, signa=
l_received))
+                goto error;
+              chomp (buf);
+              msg (D_PROXY, "HTTP proxy returned: '%s'", buf);
+
+              snprintf (get, sizeof get, "%%*s NTLM %%%ds", sizeof (buf2=
) - 1);
+              nparms =3D sscanf (buf, get, buf2);
+              buf2[127] =3D 0; // we only need the beginning - ensure it=
's null terminated.
+
+              // check for "Proxy-Authenticate: NTLM TlRM..."
+              if (nparms =3D=3D 1)
+                {
+                  // parse buf2
+                  msg (D_PROXY, "auth string: '%s'", buf2);
+                  break;
+                }
+            }
+          // if we are here then auth string was got
+          msg (D_PROXY, "Received NTLM Proxy-Authorization phase 2 respo=
nse");
+
+          /* receive and discard everything else */
+          while (recv_line (sd, NULL, 0, 5, true, NULL, signal_received)=
)
+            ;
+
+          /* now send the phase 3 reply */
+
+          /* format HTTP CONNECT message */
+          openvpn_snprintf (buf, sizeof(buf), "CONNECT %s:%d HTTP/1.0", =
host, port);
+          msg (D_PROXY, "Send to HTTP proxy: '%s'", buf);
+
+          /* send HTTP CONNECT message to proxy */
+          if (!send_line_crlf (sd, buf))
+            goto error;
+
+          /* send HOST etc, */
+          sleep (1);
+          openvpn_snprintf (buf, sizeof(buf), "Host: %s", host);
+          msg (D_PROXY, "Send to HTTP proxy: '%s'", buf);
+          if (!send_line_crlf (sd, buf))
+            goto error;
+
+          openvpn_snprintf (buf, sizeof(buf), "Proxy-Authorization: NTLM=
 %s",
+=09=09=09ntlm_phase_3 (p, buf2));
+          msg (D_PROXY, "Attempting NTLM Proxy-Authorization phase 3");
+          msg (D_PROXY, "Send to HTTP proxy: '%s'", buf);
+          sleep (1);
+          if (!send_line_crlf (sd, buf))
+        =09goto error;
+          // ok so far...
+          /* send empty CR, LF */
+          sleep (1);
+          if (!send_crlf (sd))
+            goto error;
+
+          /* receive reply from proxy */
+          if (!recv_line (sd, buf, sizeof(buf), 5, true, NULL, signal_re=
ceived))
+            goto error;
+
+          /* remove trailing CR, LF */
+          chomp (buf);
+
+          msg (D_PROXY, "HTTP proxy returned: '%s'", buf);
+
+          /* parse return string */
+          nparms =3D sscanf (buf, "%*s %d", &status);
+
+          }
+      else goto error;
+    }
+
+
   /* check return code, success =3D 200 */
-  if (nparms !=3D 1 || status !=3D 200)
+  if (nparms < 1 || status !=3D 200)
     {
       msg (D_LINK_ERRORS, "HTTP proxy returned bad status");
-#if 0
+#if 0=20
       /* DEBUGGING -- show a multi-line HTTP error response */
       while (true)
 =09{
--- openvpn/proxy.h=09Thu Jan 15 08:23:26 2004
+++ openvpn-1.6.0/proxy.h=09Thu Sep  2 17:32:31 2004
@@ -30,6 +30,7 @@
 #define HTTP_AUTH_NONE  0
 #define HTTP_AUTH_BASIC 1
 #define HTTP_AUTH_N     2
+#define HTTP_AUTH_NTLM  3
=20
 struct http_proxy_info {
   bool defined;
@@ -57,4 +58,7 @@
 =09=09=09=09    struct buffer *lookahead,
 =09=09=09=09    volatile int *signal_received);
=20
+uint8_t * make_base64_string2 (const uint8_t *str, int str_len);
+uint8_t * make_base64_string (const uint8_t *str);
+
 #endif

--------------Boundary-00=_1OZ2A5IUG1YOR6KRT00M--

