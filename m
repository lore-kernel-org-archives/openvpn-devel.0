Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1042C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nD8HruM/9aI9CaSFfF+ztH591O3FszEqlZjqvgrAhPs=; b=Gmq2tlrF26lWM6Z5DhXQIv63nE
	F14ydZG/3sdM0f7xvrrD9flSkVLe5nLH9FGJVsv1NQQFAC1UYOslUjyxxOJjJBb7dMb6lNuaBqBmm
	1RvtQc4nc4BjIzwzW1WbH4KV5pMI2kFfnRVxDp9w2cPOpVZz1kx9nkwt3Qzv6DrGxTrk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjc0M-0008Qc-02;
	Tue, 14 Jul 2026 12:12:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wjc0J-0008QV-SG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:12:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Smul2+WjnshbMrx9nZhhJxcFmRx29HYM9SNbXKJ87ec=; b=dSpKjasnsl0QWco5o/xXXBv0tq
 O2leSgeuSndLAN6WYLaQcK5FnznrkrBpZxbR7EaPSR062ire1sMdi8CdJudfFCke7ybx2+uplPuvD
 waDIbPytJqCwOMj0S5IXYzJRoPC4e9sOE8+uReaHWcFWPDpRcgbDzCzwSbQu75FVOXFk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Smul2+WjnshbMrx9nZhhJxcFmRx29HYM9SNbXKJ87ec=; b=h3hsBbEWWrmu65iYJKqQ8biA4j
 iL84uGPyTsalXDh+5Yi2yHACNizd10m9kvIB1Nsw41nR2tzHJs7AnVEfGdhJXpQULyafV1U+/OLMH
 65WaEagw4UPVWuUNoNqgKXWjMxeKTrZbKenvHEIZKRc53hPuSKmOJOekUG9cLRRCVwEM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjc0I-0007v3-GR for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:12:51 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66ECCc46013972
 for <openvpn-devel@lists.sourceforge.net>; Tue, 14 Jul 2026 14:12:38 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66ECCcsL013971
 for openvpn-devel@lists.sourceforge.net; Tue, 14 Jul 2026 14:12:38 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 14 Jul 2026 14:12:29 +0200
Message-ID: <20260714121238.13936-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1783961511000.I45ddc8e350d3948b3197ae725df102d8ce73fa77@gerrit.openvpn.net>
References: <gerrit.1783961511000.I45ddc8e350d3948b3197ae725df102d8ce73fa77@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wjc0I-0007v3-GR
Subject: [Openvpn-devel] [PATCH v1] test_tls_crypt: Fix test failure on
 Windows
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

- Exclude tests that use verify_script on Windows.
  We currently do not have openvpn_execve available
  for Windows tests. It would also need more work
  to replace the hardcoded paths.
- Use platform_gen_path instead of hard-coding /
  Do to the previous change that is not strictly
  necessary, but it also doesn't hurt and it fixes
  at least one issue if anyone ever decides to port
  this to Windows).

Change-Id: I45ddc8e350d3948b3197ae725df102d8ce73fa77
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1781
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1781
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 4779d69..b2da69b 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -811,7 +811,6 @@
 
     target_sources(test_mbuf PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
-        src/openvpn/buffer.c
         src/openvpn/mbuf.c
         )
 
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index a2987c6..db03437 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -710,7 +710,7 @@
     assert_true(tls_crypt_v2_extract_client_key(&tmp, &wrap_ctx, &tls_options));
     tls_wrap_free(&wrap_ctx);
 
-
+#ifndef _WIN32
     /* Use /bin/true as verify script */
     script_security_set(2);
     tls_options.tls_crypt_v2_verify_script = "/usr/bin/true";
@@ -727,11 +727,12 @@
      * platform_create_temp_file() */
     char non_random_tmpfile[128];
     snprintf(non_random_tmpfile, sizeof(non_random_tmpfile),
-             "%s/" PACKAGE "_tls_crypt_v2_metadata__%08" PRIx64 "%08" PRIx64 ".tmp",
-             tls_options.tmp_dir, get_random(), get_random());
-    unlink(non_random_tmpfile);
+             PACKAGE "_tls_crypt_v2_metadata__%08" PRIx64 "%08" PRIx64 ".tmp",
+             get_random(), get_random());
+    const char *tmpfile_path = platform_gen_path(tls_options.tmp_dir, non_random_tmpfile, &ctx->gc);
+    unlink(tmpfile_path);
 
-    expect_string(__wrap_buffer_write_file, filename, non_random_tmpfile);
+    expect_string(__wrap_buffer_write_file, filename, tmpfile_path);
 
     /* We do not write the first byte (type) to the file but rather to a
      * metadata_type environment variable */
@@ -752,7 +753,7 @@
         tls_options.tls_crypt_v2_verify_script = "/bin/false";
     }
 
-    expect_string(__wrap_buffer_write_file, filename, non_random_tmpfile);
+    expect_string(__wrap_buffer_write_file, filename, tmpfile_path);
     expect_memory(__wrap_buffer_write_file, pem, buf_bptr(&expected_metadata), buf_len(&expected_metadata));
     will_return(__wrap_buffer_write_file, true);
 
@@ -760,8 +761,8 @@
     assert_false(tls_crypt_v2_extract_client_key(&tmp, &wrap_ctx, &tls_options));
     tls_wrap_free(&wrap_ctx);
 
-
     tls_options.tls_crypt_v2_verify_script = NULL;
+#endif
 
     /* An outdated time should fail */
     tmp = create_client_key_input(ctx, 31);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
