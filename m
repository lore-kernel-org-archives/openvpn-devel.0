Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A03606AB3D
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z2PHzRMV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Nf4mjoxA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f9jLS4Lt;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rOUU53Jy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6i/M8UnyA/nIY/3R0Klqjp0PT+3TaXCzGZ4xfYOi2Sw=; b=Z2PHzRMViArCGm
	2GWrVHdCd+hTbq8FWAzjrSLG0KjA+49w0NAEGq6WVtk+Gpepnk1FpUutXNZQGbTpgt1pX2hvVKaB7
	nfLZBlkSFrqDxAIkgGPHvL1WfM69xr81AwxuET20I1zvBZ6Ih4CgS+EtkvdJDxsrdZjcjLx3KzXst
	TMc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOjV0-000000005cS-0s5g;
	Wed, 04 Nov 2026 22:30:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <selva.nair@gmail.com>) id 1xOjUz-000000005cM-2z7Y
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:30:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lel0F3Y/a4PW89cNI83OeG4cHVJ/YMPT/f4hSLr3HcA=; b=Nf4mjoxAHZw08wpSocFIIQiBSM
 WRHe8cw1OsJpWdtHdVv4pkgB4rCUykqzQzyykBM8qGRC+cEjZWYe69ZAnYdB7DZ3tv2yKD7eo5oD/
 nd444uw81cp45M+2LkZGjWWWIqDSVXGVmS4lRUrpyuWujfXARip+okRRXTbLiRX09VVg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lel0F3Y/a4PW89cNI83OeG4cHVJ/YMPT/f4hSLr3HcA=; b=f9jLS4LtnJKJK9kMs/RYPljaH5
 6VSGmSwXmHv07p+1nfJPKyx5yxGzmmNb5KiSrzrdr5LUs9A1oYrhWb5JcEyCOtEujEG4YpE+80E/L
 vHvXUeLtrBldxKy2iYxlcSTgac36H7CXPxFOpf+YCsbuUrdxKEhGSCL3hucVUftEjRO0=;
Received: from mail-ua1-f51.google.com ([209.85.222.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOjUz-000000000As-0Fkv for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:30:29 +0000
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-99a5710ec0dso22077241.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 14:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793831423; x=1794436223; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lel0F3Y/a4PW89cNI83OeG4cHVJ/YMPT/f4hSLr3HcA=;
 b=rOUU53JytIFKwtrWcG8YyCSAIHxBjPWs2uOkVeUgA5WQVOD3fMH+gjUsolYGecHf+o
 M3UqIZYPbGaYGkgTevVPHLHU4PEdVQ2k6Qr3XTlUXZ+iDosVgU0r+UyELdsWDx2Ud8k/
 kMDlbEZnI4KlzLI4+3ZosV5DkpuSOpoCVIUPrwQFY2v4DdfdtW5VQxwcbinTgthZzluH
 drA3A2eAJahnfgxnBsucvqISf8b+J7wwAtv2xWrbfP5SXNNICv1nDHpBDD7gplVOrrKf
 82qclL6H0OyBwkPYErPgA0HLIbQxScLtR2sw7t35fyWUuVd6tOHxKAikmUHD0VlJDaeG
 OYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793831423; x=1794436223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lel0F3Y/a4PW89cNI83OeG4cHVJ/YMPT/f4hSLr3HcA=;
 b=CfXe4pDkEeS0u3ogMdiymb2aUHtpWfBCwy44kTDWKS1196aRhyTp2hvWM7b87m13kO
 JbJdvjcvTUENIge+DqV8PBBQMxtg/CkPxYT/nX5HjTy5GVBL82EpDTT04zapeCSOC3k8
 SATAqwjT2vRfXVmmSHzH5KYxZw8EAFx2T+7Uo8SsGcSXfMP3fG6xgVfqRoC7yCOI2uyD
 14BxiyHyKvYayRUq5XctLu1wO7TKZfB7HqHosdwmK5LKI2525ykoQ18ay18UhFv0znRr
 Em+MzINFRQVtLlPSln158sVYP8aA+8JSyCJ024IWNW76dcwBO6ddRfp79KwKZ9xv1kac
 ty3w==
X-Gm-Message-State: APuU4Z/MinIkpWX3mhGLjurdt1RwYFoLIfZDYHcKnSPxBypRXmwHkxCF
 ZnN+bqQi2m68Ww/mSOC02ZUASfO2B3/IjKTae9t/ZczeXFuwfuElzzf2NP6BXg==
X-Gm-Gg: AYBFou0alv+ckJYX1LCOL2HOxfU81yPCSS3lu9WvwNSI3UEcrJC1SBW0YJbd0hxfja/
 eUZYY97UzjDDlS0Djbm+XCVKgIsfNV83Uwfu5q5puR7Nabfl0FjjYMaPHqzZpno4iAq+JHPOR39
 VU+guLWu5qFjdBe6gOf7qtrRtjteDYNqbyR0RRIoQvhJovO3J1uV76HWIlTn2eEv3m5YZS6Enjg
 rKsHV7tF4FsrdisFpQtIzTK7ZsrVHhK/LC5UbPR1/C0O+UsBxUMNrnPkMT7VrqkjFZpKjksCRLo
 DnrAq8ezXteWaKzEuHufWzcGpPeR0kw/or1yS0+UjyUc7EIq+OWKVSMeGL+u+ggxBYObCOHM3Zp
 OlxOyFoUSxfNhEdC5rRlSIlaFFsixRIQy4zmojj7XHSdnmX1VJqXRw2TMmLH3qbETftUPO8BPmC
 ZbjxODfYJ0pqSXPapgBla3ER8TcOnFyXq8W8lbpxESIjFCa3gFQ/hGVy77x6feGeCwHhOr07g24
 NirzNGPGpH9ac6E8rlPgl63qzeToE5udW9qgu/CwV7GH2qMb+9Qng6g5cUvMjuBlyVCaec+pPzB
 HbCKQqNvSnJiZjlbGVs3X/EXIWtl
X-Received: by 2002:a67:e70e:0:b0:7cc:285d:4df8 with SMTP id
 ada2fe7eead31-7d072baa5b6mr6946242137.12.1793831422942; 
 Wed, 04 Nov 2026 14:30:22 -0800 (PST)
Received: from neptune.lan ([174.93.27.195]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d28a073cbesm309763137.4.2026.11.04.14.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:30:22 -0800 (PST)
From: selva.nair@gmail.com
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 17:29:56 -0500
Message-ID: <20261104222956.882475-1-selva.nair@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <202611042206.6A4M6owt010298@chekov.greenie.muc.de>
References: <202611042206.6A4M6owt010298@chekov.greenie.muc.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOjUz-000000000As-0Fkv
Subject: [Openvpn-devel] [PATCH for 2.7] misc: Fix username overflow
 spilling into password
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
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

For release/2.7, adapt the test temporary-directory lookup because
platform_get_tmp_dir() is only available on master.

Github: OpenVPN/openvpn#1140
Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9
Signed-off-by: Selva Nair <selva.nair@gmail.com>
---
 src/openvpn/misc.c                        | 12 +++++
 tests/unit_tests/openvpn/test_user_pass.c | 63 +++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 1a23e13b..a4280cb9 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -255,6 +255,10 @@ get_user_pass_cr(struct user_pass *up, const char *auth_file, const char *prefix
                 if (!(flags & GET_USER_PASS_PASSWORD_ONLY))
                 {
                     buf_parse(&buf, '\n', up->username, USER_PASS_LEN);
+                    /* The password starts on the next line, even if the username was truncated. */
+                    const char *password = strchr(auth_file, '\n');
+                    password = password ? password + 1 : "";
+                    buf_set_read(&buf, (uint8_t *)password, strlen(password) + 1);
                 }
                 buf_parse(&buf, '\n', up->password, USER_PASS_LEN);
 
@@ -288,6 +292,14 @@ get_user_pass_cr(struct user_pass *up, const char *auth_file, const char *prefix
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
index 5ad4730b..a0206296 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -366,6 +366,68 @@ test_get_user_pass_authfile_file(void **state)
     assert_string_equal(up.password, "fuser");
 }
 
+static void
+test_get_user_pass_long_username(void **state)
+{
+    struct gc_arena gc = gc_new();
+#ifdef _WIN32
+    const char *tmpdir = win_get_tempdir();
+#else
+    const char *tmpdir = getenv("TMPDIR");
+    if (!tmpdir)
+    {
+        tmpdir = "/tmp";
+    }
+#endif
+    assert_non_null(tmpdir);
+    const char *authfile = platform_create_temp_file(tmpdir, "user_pass", &gc);
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
@@ -474,6 +536,7 @@ const struct CMUnitTest user_pass_tests[] = {
     cmocka_unit_test(test_get_user_pass_inline_creds),
     cmocka_unit_test(test_get_user_pass_authfile_stdin),
     cmocka_unit_test(test_get_user_pass_authfile_file),
+    cmocka_unit_test(test_get_user_pass_long_username),
 #ifdef ENABLE_MANAGEMENT
     cmocka_unit_test(test_get_user_pass_dynamic_challenge),
     cmocka_unit_test(test_get_user_pass_static_challenge),
-- 
2.48.1



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
