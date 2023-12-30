From: Gert Doering <gert@...1296...>
Date: Sat, 30 Dec 2023 15:32:48 +0100
Message-ID: <20231230143248.1625-1-gert@...1296...>
In-Reply-To: <gerrit.1702052980000.I0abeec9f862aea1f6a8fdf350fa0008cf2e5d613@...2715...>
References: <gerrit.1702052980000.I0abeec9f862aea1f6a8fdf350fa0008cf2e5d613@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] misc: make get_auth_challenge static
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

Not used outside of misc.c.

Rename to parse_auth_challenge since it really just parses
the string that you put in into the struct.

Add doxygen documentation.

v2:
 - change if(auth_challenge) to ASSERT(auth_challenge)

Change-Id: I0abeec9f862aea1f6a8fdf350fa0008cf2e5d613
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/476
This mail reflects revision 5 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index bce63ed..08f274d 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -124,6 +124,83 @@
     }
     return true;
 }
+
+/**
+ * Parses an authentication challenge string and returns an auth_challenge_info structure.
+ * The authentication challenge string should follow the dynamic challenge/response protocol.
+ *
+ * See doc/management-notes.txt for more info on the the dynamic challenge/response protocol
+ * implemented here.
+ *
+ * @param auth_challenge The authentication challenge string to parse. Can't be NULL.
+ * @param gc             The gc_arena structure for memory allocation.
+ *
+ * @return               A pointer to the parsed auth_challenge_info structure, or NULL if parsing fails.
+ */
+static struct auth_challenge_info *
+parse_auth_challenge(const char *auth_challenge, struct gc_arena *gc)
+{
+    ASSERT(auth_challenge);
+
+    struct auth_challenge_info *ac;
+    const int len = strlen(auth_challenge);
+    char *work = (char *) gc_malloc(len+1, false, gc);
+    char *cp;
+
+    struct buffer b;
+    buf_set_read(&b, (const uint8_t *)auth_challenge, len);
+
+    ALLOC_OBJ_CLEAR_GC(ac, struct auth_challenge_info, gc);
+
+    /* parse prefix */
+    if (!buf_parse(&b, ':', work, len))
+    {
+        return NULL;
+    }
+    if (strcmp(work, "CRV1"))
+    {
+        return NULL;
+    }
+
+    /* parse flags */
+    if (!buf_parse(&b, ':', work, len))
+    {
+        return NULL;
+    }
+    for (cp = work; *cp != '\0'; ++cp)
+    {
+        const char c = *cp;
+        if (c == 'E')
+        {
+            ac->flags |= CR_ECHO;
+        }
+        else if (c == 'R')
+        {
+            ac->flags |= CR_RESPONSE;
+        }
+    }
+
+    /* parse state ID */
+    if (!buf_parse(&b, ':', work, len))
+    {
+        return NULL;
+    }
+    ac->state_id = string_alloc(work, gc);
+
+    /* parse user name */
+    if (!buf_parse(&b, ':', work, len))
+    {
+        return NULL;
+    }
+    ac->user = (char *) gc_malloc(strlen(work)+1, true, gc);
+    openvpn_base64_decode(work, (void *)ac->user, -1);
+
+    /* parse challenge text */
+    ac->challenge_text = string_alloc(BSTR(&b), gc);
+
+    return ac;
+}
+
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /*
@@ -287,7 +364,7 @@
 #ifdef ENABLE_MANAGEMENT
             if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE) && response_from_stdin)
             {
-                struct auth_challenge_info *ac = get_auth_challenge(auth_challenge, &gc);
+                struct auth_challenge_info *ac = parse_auth_challenge(auth_challenge, &gc);
                 if (ac)
                 {
                     char *response = (char *) gc_malloc(USER_PASS_LEN, false, &gc);
@@ -392,83 +469,6 @@
     return true;
 }
 
-#ifdef ENABLE_MANAGEMENT
-
-/*
- * See management/management-notes.txt for more info on the
- * the dynamic challenge/response protocol implemented here.
- */
-struct auth_challenge_info *
-get_auth_challenge(const char *auth_challenge, struct gc_arena *gc)
-{
-    if (auth_challenge)
-    {
-        struct auth_challenge_info *ac;
-        const int len = strlen(auth_challenge);
-        char *work = (char *) gc_malloc(len+1, false, gc);
-        char *cp;
-
-        struct buffer b;
-        buf_set_read(&b, (const uint8_t *)auth_challenge, len);
-
-        ALLOC_OBJ_CLEAR_GC(ac, struct auth_challenge_info, gc);
-
-        /* parse prefix */
-        if (!buf_parse(&b, ':', work, len))
-        {
-            return NULL;
-        }
-        if (strcmp(work, "CRV1"))
-        {
-            return NULL;
-        }
-
-        /* parse flags */
-        if (!buf_parse(&b, ':', work, len))
-        {
-            return NULL;
-        }
-        for (cp = work; *cp != '\0'; ++cp)
-        {
-            const char c = *cp;
-            if (c == 'E')
-            {
-                ac->flags |= CR_ECHO;
-            }
-            else if (c == 'R')
-            {
-                ac->flags |= CR_RESPONSE;
-            }
-        }
-
-        /* parse state ID */
-        if (!buf_parse(&b, ':', work, len))
-        {
-            return NULL;
-        }
-        ac->state_id = string_alloc(work, gc);
-
-        /* parse user name */
-        if (!buf_parse(&b, ':', work, len))
-        {
-            return NULL;
-        }
-        ac->user = (char *) gc_malloc(strlen(work)+1, true, gc);
-        openvpn_base64_decode(work, (void *)ac->user, -1);
-
-        /* parse challenge text */
-        ac->challenge_text = string_alloc(BSTR(&b), gc);
-
-        return ac;
-    }
-    else
-    {
-        return NULL;
-    }
-}
-
-#endif /* ifdef ENABLE_MANAGEMENT */
-
 void
 purge_user_pass(struct user_pass *up, const bool force)
 {
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 70a24dd..5ae61b5 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -86,8 +86,6 @@
     const char *challenge_text;
 };
 
-struct auth_challenge_info *get_auth_challenge(const char *auth_challenge, struct gc_arena *gc);
-
 /*
  * Challenge response info on client as pushed by server.
  */
@@ -120,12 +118,31 @@
 
 #define GET_USER_PASS_INLINE_CREDS (1<<10)  /* indicates that auth_file is actually inline creds */
 
+/**
+ * Retrieves the user credentials from various sources depending on the flags.
+ *
+ * @param up The user_pass structure to store the retrieved credentials.
+ * @param auth_file The path to the authentication file. Might be NULL.
+ * @param prefix The prefix to prepend to user prompts.
+ * @param flags Additional flags to control the behavior of the function.
+ * @param auth_challenge The authentication challenge string.
+ * @return true if the user credentials were successfully retrieved, false otherwise.
+ */
 bool get_user_pass_cr(struct user_pass *up,
                       const char *auth_file,
                       const char *prefix,
                       const unsigned int flags,
                       const char *auth_challenge);
 
+/**
+ * Retrieves the user credentials from various sources depending on the flags.
+ *
+ * @param up The user_pass structure to store the retrieved credentials.
+ * @param auth_file The path to the authentication file. Might be NULL.
+ * @param prefix The prefix to prepend to user prompts.
+ * @param flags Additional flags to control the behavior of the function.
+ * @return true if the user credentials were successfully retrieved, false otherwise.
+ */
 static inline bool
 get_user_pass(struct user_pass *up,
               const char *auth_file,
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 6ba6ff8..71b99db 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -410,11 +410,7 @@
 bool ssl_clean_auth_token(void);
 
 #ifdef ENABLE_MANAGEMENT
-/*
- * ssl_get_auth_challenge will parse the server-pushed auth-failed
- * reason string and return a dynamically allocated
- * auth_challenge_info struct.
- */
+
 void ssl_purge_auth_challenge(void);
 
 void ssl_put_auth_challenge(const char *cr_str);

