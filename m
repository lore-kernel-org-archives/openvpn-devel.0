From: Gert Doering <gert@...1296...>
Date: Mon, 29 Jan 2024 11:53:57 +0100
Message-ID: <20240129105358.11161-1-gert@...1296...>
In-Reply-To: <gerrit.1702052980000.Ie8d2d5f6f58679baaf5eb817a7e2ca1afcb8c4db@...2715...>
References: <gerrit.1702052980000.Ie8d2d5f6f58679baaf5eb817a7e2ca1afcb8c4db@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] test_user_pass: Add UTs for character
 filtering
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

For simplicity I implemented them only with the
inline method, but they actually apply to all methods.

Change-Id: Ie8d2d5f6f58679baaf5eb817a7e2ca1afcb8c4db
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/473
This mail reflects revision 6 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>
Gert Doering <gert@...1296...>

        
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index ab4dfe4..277cb1d 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -141,6 +141,29 @@
 
     reset_user_pass(&up);
 
+    /* Test various valid characters */
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    /* FIXME? content after first two lines just ignored */
+    assert_true(get_user_pass_cr(&up, "#iuser and 커뮤니티\n//ipasswörd!\nsome other content\nnot relevant", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "#iuser and 커뮤니티");
+    assert_string_equal(up.password, "//ipasswörd!");
+
+    reset_user_pass(&up);
+
+    /* Test various invalid characters */
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    /*FIXME? allows arbitrary crap if c > 127 */
+    /*FIXME? silently removes control characters */
+    assert_true(get_user_pass_cr(&up, "\tiuser\r\nipass\xffwo\x1erd", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "iuser");
+    assert_string_equal(up.password, "ipass\xffword");
+
+    reset_user_pass(&up);
+
     expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT Password:");
     will_return(query_user_exec_builtin, "cpassword");
     will_return(query_user_exec_builtin, true);

