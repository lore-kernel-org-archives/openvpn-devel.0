Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BE1606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CTiNO1hg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HYUl3AlM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fOucoD35
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mGaqXL7u8Rf6DzEfDA43+M0ffrvn1N4J6MrfE129rDI=; b=CTiNO1hgOn4Wug
	VpeRY+un0bwOcID7GBH6iiFx0btIwKoRR00BAFB+3vP6QVstr1VWYtxgXxFc48RKIlNYXUT/q6RHx
	sEzU/VtJaH/RMhg+v2JM0I8pytcbuMuWqetnfkud4nZjPd60v9ZvqWq2n27UT/aq3MyXVz5aY1StW
	XzM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO9eg-000000005n8-3aq7;
	Tue, 03 Nov 2026 08:14:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xO9eg-000000005my-04Jf for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:14:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6zUTbYO3/+4rchEd1q9c9MA019vkTVh8yj3iw5K+CyA=; b=HYUl3AlMy1ODTHKbcj+pQB3ANP
 0Dh9mrlcxDvZy6yuXBF3X3i7qdTewAGXz1ANXNJRKALPqm92APRWYeHXRGvRyCOuTIsJD+1tKIvsR
 qulwR01adEsrYNXgQzsD8Q69Jpy0+OLzxJ0i7xRHSoLgWgRCDPReNHvpxGnuDWrDpKR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6zUTbYO3/+4rchEd1q9c9MA019vkTVh8yj3iw5K+CyA=; b=fOucoD35kFQ3mPqcuF/1W383OV
 knGQog2eQLOGBhJcrsJvne84havjVAuigHf66c1r0oQ6N9vP6FqoS8MERod8LP2ni80sVAvhP6Cms
 lNuWVTGKmpOj6y5U3wk7VOoDJnIlnAEH1SGmwfLFyBN6roecU5hFBk0eT+M7p9Lk8MXY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xO9ee-000000003aE-2pmD for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:14:05 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A38Dwrv008599
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 09:13:58 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A38Dw4g008598
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 09:13:58 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 09:13:52 +0100
Message-ID: <20261103081357.8587-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793666730000.I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9@gerrit.openvpn.net>
References: <gerrit.1793666730000.I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xO9ee-000000003aE-2pmD
Subject: [Openvpn-devel] [PATCH v2] misc: Fix username overflow spilling
 into password
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Selva Nair <selva.nair@gmail.com>

Consume the complete username line before reading the password
from an auth file or inline credentials. This also fixes an
exactly full username buffer leaving its newline to be read as
an empty password in auth files.

Existing credential truncation behaviour is unchanged.

Tests: Add regression coverage for long and boundary-length
usernames with missing, blank, or supplied passwords in both
inlined and external file inputs.

Github: OpenVPN/openvpn#1140
Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9
Signed-off-by: Selva Nair <selva.nair@gmail.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2096
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2096
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 304a87e..8c9ad08 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -250,6 +250,10 @@
                 if (!(flags & GET_USER_PASS_PASSWORD_ONLY))
                 {
                     buf_parse(&buf, '\n', up->username, USER_PASS_LEN);
+                    /* The password starts on the next line, even if the username was truncated. */
+                    const char *password = strchr(auth_file, '\n');
+                    password = password ? password + 1 : "";
+                    buf_set_read(&buf, (uint8_t *)password, strlen(password) + 1);
                 }
                 buf_parse(&buf, '\n', up->password, USER_PASS_LEN);
 
@@ -283,6 +287,14 @@
                         msg(M_FATAL, "Error reading username from %s authfile: %s", prefix,
                             auth_file);
                     }
+                    if (!strchr(up->username, '\n'))
+                    {
+                        /* Consume the rest of the username line before reading the password. */
+                        int c;
+                        while ((c = fgetc(fp)) != '\n' && c != EOF)
+                        {
+                        }
+                    }
                 }
                 chomp(up->username);
 
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index adcf74a..776a86a 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -366,6 +366,58 @@
     assert_string_equal(up.password, "fuser");
 }
 
+static void
+test_get_user_pass_long_username(void **state)
+{
+    struct gc_arena gc = gc_new();
+    const char *authfile = platform_create_temp_file(platform_get_tmp_dir(), "user_pass", &gc);
+    assert_non_null(authfile);
+    const size_t lengths[] = { USER_PASS_LEN - 2, USER_PASS_LEN - 1, USER_PASS_LEN + 10 };
+    const char *endings[] = { "", "\n", "\n\n", "\nfpassword\n", "\r\nfpassword\r\n" };
+
+    const bool inline_mode[] = { false, true };
+    for (size_t mode = 0; mode < SIZE(inline_mode); mode++)
+    {
+        const bool use_inline_creds = inline_mode[mode];
+        for (size_t i = 0; i < SIZE(lengths); i++)
+        {
+            for (size_t j = 0; j < SIZE(endings); j++)
+            {
+                struct user_pass up = { 0 };
+                char creds[USER_PASS_LEN + 64];
+                memset(creds, 'u', lengths[i]);
+                strcpy(creds + lengths[i], endings[j]);
+                if (!use_inline_creds)
+                {
+                    FILE *fp = platform_fopen(authfile, "w");
+                    assert_non_null(fp);
+                    assert_true(fputs(creds, fp) >= 0);
+                    assert_int_equal(fclose(fp), 0);
+                }
+
+                const bool missing_password = j < 3;
+                if (missing_password)
+                {
+                    expect_string(query_user_exec_builtin, query_user[i].prompt,
+                                  "Enter UT Password:");
+                    will_return(query_user_exec_builtin, "cpassword");
+                }
+                will_return(query_user_exec_builtin, true);
+                assert_true(get_user_pass_cr(&up, use_inline_creds ? creds : authfile, "UT",
+                                             use_inline_creds ? GET_USER_PASS_INLINE_CREDS : 0, NULL));
+                /* Truncation must not change where the password line starts. */
+                creds[lengths[i] < USER_PASS_LEN ? lengths[i] : USER_PASS_LEN - 1] = '\0';
+                assert_true(up.defined);
+                assert_string_equal(up.username, creds);
+                assert_string_equal(up.password,
+                                    missing_password ? "cpassword" : "fpassword");
+            }
+        }
+    }
+    assert_true(platform_unlink(authfile));
+    gc_free(&gc);
+}
+
 #ifdef ENABLE_MANAGEMENT
 static void
 test_get_user_pass_dynamic_challenge(void **state)
@@ -474,6 +526,7 @@
     cmocka_unit_test(test_get_user_pass_inline_creds),
     cmocka_unit_test(test_get_user_pass_authfile_stdin),
     cmocka_unit_test(test_get_user_pass_authfile_file),
+    cmocka_unit_test(test_get_user_pass_long_username),
 #ifdef ENABLE_MANAGEMENT
     cmocka_unit_test(test_get_user_pass_dynamic_challenge),
     cmocka_unit_test(test_get_user_pass_static_challenge),


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
