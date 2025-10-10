From: Gert Doering <gert@...1296...>
Date: Fri, 10 Oct 2025 11:47:44 +0200
Message-ID: <20251010094753.2825-1-gert@...1296...>
In-Reply-To: <gerrit.1758731785000.I04542e678f81d5d4a853b4370d9b8adc4dac1212@...2715...>
References: <gerrit.1758731785000.I04542e678f81d5d4a853b4370d9b8adc4dac1212@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] console: Simplify query_user_add
 interface
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

From: Frank Lichtenheld <frank@...2641...>

- Removes unused field prompt_len
- Change field reponse_len to int since that
  is what the code actually expects. Most callers
  user a constant either way.

Change-Id: I04542e678f81d5d4a853b4370d9b8adc4dac1212
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1216
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1216
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index bdceaf2..3cb23b3 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -53,14 +53,14 @@
 
 
 void
-query_user_add(char *prompt, size_t prompt_len, char *resp, size_t resp_len, bool echo)
+query_user_add(char *prompt, char *resp, int resp_len, bool echo)
 {
     int i;
 
     /* Ensure input is sane.  All these must be present otherwise it is
      * a programming error.
      */
-    ASSERT(prompt_len > 0 && prompt != NULL && resp_len > 0 && resp != NULL);
+    ASSERT(prompt != NULL && resp_len > 0 && resp != NULL);
 
     /* Seek to the last unused slot */
     for (i = 0; i < QUERY_USER_NUMSLOTS; i++)
@@ -74,7 +74,6 @@
 
     /* Save the information needed for the user interaction */
     query_user[i].prompt = prompt;
-    query_user[i].prompt_len = prompt_len;
     query_user[i].response = resp;
     query_user[i].response_len = resp_len;
     query_user[i].echo = echo;
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 14b6116..fba2a09 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -32,11 +32,10 @@
  */
 struct _query_user
 {
-    char *prompt;        /**< Prompt to present to the user */
-    size_t prompt_len;   /**< Length of the prompt string */
-    char *response;      /**< The user's response */
-    size_t response_len; /**< Length the of the user response */
-    bool echo;           /**< True: The user should see what is being typed, otherwise mask it */
+    char *prompt;     /**< Prompt to present to the user */
+    char *response;   /**< The user's response */
+    int response_len; /**< Length the of the user response */
+    bool echo;        /**< True: The user should see what is being typed, otherwise mask it */
 };
 
 #define QUERY_USER_NUMSLOTS 10
@@ -53,13 +52,12 @@
  * Adds an item to ask the user for
  *
  * @param prompt     Prompt to display to the user
- * @param prompt_len Length of the prompt string
  * @param resp       String containing the user response
  * @param resp_len   Length of the response string
  * @param echo       Should the user input be echoed to the user?  If False, input will be masked
  *
  */
-void query_user_add(char *prompt, size_t prompt_len, char *resp, size_t resp_len, bool echo);
+void query_user_add(char *prompt, char *resp, int resp_len, bool echo);
 
 
 /**
@@ -117,10 +115,10 @@
  *
  */
 static inline bool
-query_user_SINGLE(char *prompt, size_t prompt_len, char *resp, size_t resp_len, bool echo)
+query_user_SINGLE(char *prompt, char *resp, int resp_len, bool echo)
 {
     query_user_clear();
-    query_user_add(prompt, prompt_len, resp, resp_len, echo);
+    query_user_add(prompt, resp, resp_len, echo);
     return query_user_exec();
 }
 
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 71c0025..2a925d6 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -45,11 +45,6 @@
 
 #include "win32.h"
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * Get input from a Windows console.
  *
@@ -73,7 +68,7 @@
     HANDLE in = GetStdHandle(STD_INPUT_HANDLE);
     int orig_stderr = get_orig_stderr(); /* guaranteed to be always valid */
     if ((in == INVALID_HANDLE_VALUE) || win32_service_interrupt(&win32_signal)
-        || (_write(orig_stderr, prompt, strlen(prompt)) == -1))
+        || (_write(orig_stderr, prompt, (unsigned int)strlen(prompt)) == -1))
     {
         msg(M_WARN | M_ERRNO, "get_console_input_win32(): unexpected error");
         return false;
@@ -139,10 +134,6 @@
     return false;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* _WIN32 */
 
 
@@ -273,11 +264,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * @copydoc query_user_exec()
  *
@@ -309,7 +295,3 @@
 
     return ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index caf4725..188f44e 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -239,8 +239,7 @@
                 struct buffer user_prompt = alloc_buf_gc(128, &gc);
 
                 buf_printf(&user_prompt, "NEED-OK|%s|%s:", prefix, up->username);
-                if (!query_user_SINGLE(BSTR(&user_prompt), BLEN(&user_prompt), up->password,
-                                       USER_PASS_LEN, false))
+                if (!query_user_SINGLE(BSTR(&user_prompt), up->password, USER_PASS_LEN, false))
                 {
                     msg(M_FATAL, "ERROR: could not read %s ok-confirmation from stdin", prefix);
                 }
@@ -362,7 +361,7 @@
                     buf_printf(&challenge, "CHALLENGE: %s", ac->challenge_text);
                     buf_set_write(&packed_resp, (uint8_t *)up->password, USER_PASS_LEN);
 
-                    if (!query_user_SINGLE(BSTR(&challenge), BLEN(&challenge), response,
+                    if (!query_user_SINGLE(BSTR(&challenge), response,
                                            USER_PASS_LEN, BOOL_CAST(ac->flags & CR_ECHO)))
                     {
                         msg(M_FATAL, "ERROR: could not read challenge response from stdin");
@@ -387,14 +386,12 @@
 
                 if (username_from_stdin && !(flags & GET_USER_PASS_PASSWORD_ONLY))
                 {
-                    query_user_add(BSTR(&user_prompt), BLEN(&user_prompt), up->username,
-                                   USER_PASS_LEN, true);
+                    query_user_add(BSTR(&user_prompt), up->username, USER_PASS_LEN, true);
                 }
 
                 if (password_from_stdin)
                 {
-                    query_user_add(BSTR(&pass_prompt), BLEN(&pass_prompt), up->password,
-                                   USER_PASS_LEN, false);
+                    query_user_add(BSTR(&pass_prompt), up->password, USER_PASS_LEN, false);
                 }
 
                 if (!query_user_exec())
@@ -421,8 +418,7 @@
                     challenge = alloc_buf_gc(14 + strlen(auth_challenge), &gc);
                     buf_printf(&challenge, "CHALLENGE: %s", auth_challenge);
 
-                    if (!query_user_SINGLE(BSTR(&challenge), BLEN(&challenge), response,
-                                           USER_PASS_LEN,
+                    if (!query_user_SINGLE(BSTR(&challenge), response, USER_PASS_LEN,
                                            BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO)))
                     {
                         msg(M_FATAL, "ERROR: could not retrieve static challenge response");
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 16149ca..ce64135 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -671,7 +671,7 @@
     ASSERT(token != NULL);
 
     buf_printf(&pass_prompt, "Please enter '%s' token PIN or 'cancel': ", token->display);
-    if (!query_user_SINGLE(BSTR(&pass_prompt), BLEN(&pass_prompt), pin, pin_max, false))
+    if (!query_user_SINGLE(BSTR(&pass_prompt), pin, (int)pin_max, false))
     {
         msg(M_FATAL, "Could not retrieve the PIN");
     }

