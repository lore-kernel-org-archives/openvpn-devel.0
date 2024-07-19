From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 19 Jul 2024 15:14:07 +0200
Message-Id: <20240719131407.75746-1-frank@...2641...>
In-Reply-To: <gerrit.1718418288000.I59a90446bfe73d8856516025a58a6f62cc98ab0d@...2715...>
References: <gerrit.1718418288000.I59a90446bfe73d8856516025a58a6f62cc98ab0d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Static-challenge concatenation option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Selva Nair <selva.nair@...277...>

Extend "--static-challenge" option to take a third
argument (= scrv1 or concat) to specify that the password and
response should be concatenated instead of using the
SCRV1 protocol. If unspecified, it defaults to "scrv1"
meaning that the SCRV1 protocol should be used.

v2: use scrv1|concat instead of 0|1 as option argument
    fix typos
v3: improve and correct documentation in management-notes.txt

Change-Id: I59a90446bfe73d8856516025a58a6f62cc98ab0d
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/665
This mail reflects revision 3 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index b75fe5b..a06948e 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -541,12 +541,15 @@
   Valid syntax:
   ::
 
-     static-challenge text echo
+     static-challenge text echo [format]
 
   The ``text`` challenge text is presented to the user which describes what
   information is requested.  The ``echo`` flag indicates if the user's
   input should be echoed on the screen.  Valid ``echo`` values are
-  :code:`0` or :code:`1`.
+  :code:`0` or :code:`1`. The optional ``format`` indicates whether
+  the password and response should be combined using the SCRV1 protocol
+  (``format`` = :code:`scrv1`) or simply concatenated (``format`` = :code:`concat`).
+  :code:`scrv1` is the default.
 
   See management-notes.txt in the OpenVPN distribution for a description of
   the OpenVPN challenge/response protocol.
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index b9947fa..b55135a 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -1320,14 +1320,20 @@
 
 OpenVPN's --static-challenge option is used to provide the
 challenge text to OpenVPN and indicate whether or not the response
-should be echoed.
+should be echoed and how the response should be combined with the
+password.
 
 When credentials are needed and the --static-challenge option is
 used, the management interface will send:
 
-  >PASSWORD:Need 'Auth' username/password SC:<ECHO>,<TEXT>
+  >PASSWORD:Need 'Auth' username/password SC:<flag>,<TEXT>
 
-  ECHO: "1" if response should be echoed, "0" to not echo
+  flag: an integer whose least significant bit is the ECHO flag and
+        the next significant bit is the FORMAT flag.
+        ECHO = (flag & 0x1) is 1 if response should be echoed, 0 to not echo
+        FORMAT = (flag & 0x2) is 1 if response should be concatenated with
+        password as plain text, 0 if response and password should be encoded
+        as described below. Thus flag could take values 0, 1, 2, or 3.
   TEXT: challenge text that should be shown to the user to
       facilitate their response
 
@@ -1342,8 +1348,9 @@
 
 The management interface client in this case should add the static
 challenge text to the auth dialog followed by a field for the user to
-enter a response.  Then the management interface client should pack the
-password and response together into an encoded password and send:
+enter a response. If flag = 0 or 1 (i.e., FORMAT=0), the management
+interface client should pack the password and response together into
+an encoded password and send:
 
   username "Auth" <username>
   password "Auth" "SCRV1:<password_base64>:<response_base64>"
@@ -1354,6 +1361,12 @@
 the user. The <password_base64> and/or the <response_base64> can be
 empty strings.
 
+If flag = 2 or 3 (i.e., FORMAT=1), the client should simply concatenate
+password and response with no separator and send:
+
+  username "Auth" <username>
+  password "Auth" "<password><response>"
+
 (As in all username/password responses described in the "COMMAND --
 password and username" section above, the username can be in quotes,
 and special characters such as double quotes or backslashes must be
@@ -1361,10 +1374,15 @@
 
 For example, if user "foo" entered "bar" as the password and 8675309
 as the PIN, the following management interface commands should be
-issued:
+issued if flag = 0 or 1 (i.e., FORMAT = 0):
 
   username "Auth" foo
   password "Auth" "SCRV1:YmFy:ODY3NTMwOQ=="
 
   ("YmFy" is the base 64 encoding of "bar" and "ODY3NTMwOQ==" is the
    base 64 encoding of "8675309".)
+
+or, if flag = 2 or 3 (i.e., FORMAT = 1):
+
+  username "Auth" foo
+  password "Auth" "bar8675309"
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 24f3121..05b5a1a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3544,7 +3544,8 @@
         if (sc)
         {
             buf_printf(&alert_msg, " SC:%d,%s",
-                       BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO),
+                       BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO)
+                       |(BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_CONCAT) << 1),
                        sc);
         }
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 598fbae..516b1ed 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -438,17 +438,28 @@
                     {
                         msg(M_FATAL, "ERROR: could not retrieve static challenge response");
                     }
-                    if (openvpn_base64_encode(up->password, strlen(up->password), &pw64) == -1
-                        || openvpn_base64_encode(response, strlen(response), &resp64) == -1)
+                    if (!(flags & GET_USER_PASS_STATIC_CHALLENGE_CONCAT))
                     {
-                        msg(M_FATAL, "ERROR: could not base64-encode password/static_response");
+                        if (openvpn_base64_encode(up->password, strlen(up->password), &pw64) == -1
+                            || openvpn_base64_encode(response, strlen(response), &resp64) == -1)
+                        {
+                            msg(M_FATAL, "ERROR: could not base64-encode password/static_response");
+                        }
+                        buf_set_write(&packed_resp, (uint8_t *)up->password, USER_PASS_LEN);
+                        buf_printf(&packed_resp, "SCRV1:%s:%s", pw64, resp64);
+                        string_clear(pw64);
+                        free(pw64);
+                        string_clear(resp64);
+                        free(resp64);
                     }
-                    buf_set_write(&packed_resp, (uint8_t *)up->password, USER_PASS_LEN);
-                    buf_printf(&packed_resp, "SCRV1:%s:%s", pw64, resp64);
-                    string_clear(pw64);
-                    free(pw64);
-                    string_clear(resp64);
-                    free(resp64);
+                    else
+                    {
+                        if (strlen(up->password) + strlen(response) >= USER_PASS_LEN)
+                        {
+                            msg(M_FATAL, "ERROR: could not concatenate password/static_response: string too long");
+                        }
+                        strncat(up->password, response, USER_PASS_LEN - strlen(up->password) - 1);
+                    }
                 }
 #endif /* ifdef ENABLE_MANAGEMENT */
             }
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 963f3e6..f3b824e 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -91,6 +91,7 @@
  */
 struct static_challenge_info {
 #define SC_ECHO     (1<<0)  /* echo response when typed by user */
+#define SC_CONCAT   (1<<1)  /* concatenate password and response and do not base64 encode */
     unsigned int flags;
 
     const char *challenge_text;
@@ -117,6 +118,7 @@
 #define GET_USER_PASS_STATIC_CHALLENGE_ECHO  (1<<9) /* SCRV1 protocol -- echo response */
 
 #define GET_USER_PASS_INLINE_CREDS (1<<10)  /* indicates that auth_file is actually inline creds */
+#define GET_USER_PASS_STATIC_CHALLENGE_CONCAT (1<<11)  /* indicates password and response should be concatenated */
 
 /**
  * Retrieves the user credentials from various sources depending on the flags.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 64e67aa..295ed3d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -518,8 +518,10 @@
     "                  Add domains to DNS domain search list\n"
     "--auth-retry t  : How to handle auth failures.  Set t to\n"
     "                  none (default), interact, or nointeract.\n"
-    "--static-challenge t e : Enable static challenge/response protocol using\n"
+    "--static-challenge t e [<scrv1|concat>]: Enable static challenge/response protocol using\n"
     "                  challenge text t, with e indicating echo flag (0|1)\n"
+    "                  and optional argument scrv1 or concat to use SCRV1 protocol or"
+    "                  concatenate response with password. Default is scrv1.\n"
     "--connect-timeout n : when polling possible remote servers to connect to\n"
     "                  in a round-robin fashion, spend no more than n seconds\n"
     "                  waiting for a response before trying the next server.\n"
@@ -7932,7 +7934,7 @@
         auth_retry_set(msglevel, p[1]);
     }
 #ifdef ENABLE_MANAGEMENT
-    else if (streq(p[0], "static-challenge") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], "static-challenge") && p[1] && p[2] && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sc_info.challenge_text = p[1];
@@ -7940,6 +7942,15 @@
         {
             options->sc_info.flags |= SC_ECHO;
         }
+        if (p[3] && streq(p[3], "concat"))
+        {
+            options->sc_info.flags |= SC_CONCAT;
+        }
+        else if (p[3] && !streq(p[3], "scrv1"))
+        {
+            msg(msglevel, "--static-challenge: unknown format indicator '%s'", p[3]);
+            goto err;
+        }
     }
 #endif
     else if (streq(p[0], "msg-channel") && p[1])
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e0e9591..25c6ccf 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -312,6 +312,10 @@
             {
                 flags |= GET_USER_PASS_STATIC_CHALLENGE_ECHO;
             }
+            if (sci->flags & SC_CONCAT)
+            {
+                flags |= GET_USER_PASS_STATIC_CHALLENGE_CONCAT;
+            }
             get_user_pass_cr(&auth_user_pass,
                              auth_file,
                              UP_TYPE_AUTH,

