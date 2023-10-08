From: Frank Lichtenheld <frank@...2641...>
Date: Sun,  8 Oct 2023 12:37:42 +0200
Message-Id: <20231008103742.20019-1-frank@...2641...>
In-Reply-To: <gerrit.1689088618000.Icc86334b26ba1fcc20f4cd03644018d1d16796e3@...2715...>
References: <gerrit.1689088618000.Icc86334b26ba1fcc20f4cd03644018d1d16796e3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] generate_auth_token: simplify code
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

The previous code went through some hoops
to avoid compiler warnings. But there is
a much easier way by just telling it
exactly what you want to do.

Also fix typo in variable name while I'm
here.

Change-Id: Icc86334b26ba1fcc20f4cd03644018d1d16796e3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/310
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 6787ea7..28b58b0 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -182,24 +182,18 @@
         char *initial_token_copy = string_alloc(multi->auth_token_initial, &gc);
 
         char *old_sessid = initial_token_copy + strlen(SESSION_ID_PREFIX);
-        char *old_tsamp_initial = old_sessid + AUTH_TOKEN_SESSION_ID_LEN*8/6;
+        char *old_tstamp_initial = old_sessid + AUTH_TOKEN_SESSION_ID_LEN*8/6;
 
         /*
          * We null terminate the old token just after the session ID to let
          * our base64 decode function only decode the session ID
          */
-        old_tsamp_initial[12] = '\0';
-        ASSERT(openvpn_base64_decode(old_tsamp_initial, old_tstamp_decode, 9) == 9);
+        old_tstamp_initial[12] = '\0';
+        ASSERT(openvpn_base64_decode(old_tstamp_initial, old_tstamp_decode, 9) == 9);
 
-        /*
-         * Avoid old gcc (4.8.x) complaining about strict aliasing
-         * by using a temporary variable instead of doing it in one
-         * line
-         */
-        uint64_t *tstamp_ptr = (uint64_t *) old_tstamp_decode;
-        initial_timestamp = *tstamp_ptr;
+        memcpy(&initial_timestamp, &old_tstamp_decode, sizeof(initial_timestamp));
 
-        old_tsamp_initial[0] = '\0';
+        old_tstamp_initial[0] = '\0';
         ASSERT(openvpn_base64_decode(old_sessid, sessid, AUTH_TOKEN_SESSION_ID_LEN) == AUTH_TOKEN_SESSION_ID_LEN);
     }
     else if (!rand_bytes(sessid, AUTH_TOKEN_SESSION_ID_LEN))

