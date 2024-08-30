From: selva.nair@...277...
Date: Fri, 30 Aug 2024 10:18:24 -0400
Message-Id: <20240830141824.108599-1-selva.nair@...277...>
In-Reply-To: <gerrit.1718418288000.I41f6c1f7acb58f30fc4db0e32505018f64fcad28@...2715...>
References: <gerrit.1718418288000.I41f6c1f7acb58f30fc4db0e32505018f64fcad28@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Add test for static-challenge
 concatenation option
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

Change-Id: I41f6c1f7acb58f30fc4db0e32505018f64fcad28
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/I41f6c1f7acb58f30fc4db0e32505018f64fcad28
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>
Frank Lichtenheld <frank@...2641...>

        
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index b43e655..35fe60d 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -311,7 +311,25 @@
 
     reset_user_pass(&up);
 
-    flags |= GET_USER_PASS_INLINE_CREDS;
+    flags |= GET_USER_PASS_STATIC_CHALLENGE_CONCAT;
+
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT Username:");
+    will_return(query_user_exec_builtin, "c1user");
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT Password:");
+    will_return(query_user_exec_builtin, "c1password");
+    will_return(query_user_exec_builtin, true);
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "CHALLENGE: Please enter token PIN");
+    will_return(query_user_exec_builtin, "0123456");
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, NULL, "UT", flags, challenge));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "c1user");
+    /* password and response concatenated */
+    assert_string_equal(up.password, "c1password0123456");
+
+    reset_user_pass(&up);
+
+    flags = GET_USER_PASS_STATIC_CHALLENGE|GET_USER_PASS_INLINE_CREDS;
 
     /*FIXME: query_user_exec() called even though nothing queued */
     will_return(query_user_exec_builtin, true);

