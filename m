Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E7BC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=87jK5UbThBhWkBvayjyarfr5M1L+a9O0Lyx/QDoiGcM=; b=eAwf8MF2AQGU/eTQuXvi5c+0Xe
	PIRzHM7q3zQSmzEv09Lven2oYp4hERwKdfJTJmWWjS5gTtkaLiSC/HUqt0BL38wZVGgTAvL66oZ5g
	tlGpBKNtWWsNAXYBGMTSABBL97scLTPxBC3Vcr3SetMiz4cRRKGMMfRs2soIOUtkagWM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfC9P-0000vu-3O;
	Thu, 02 Jul 2026 07:47:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wfC9N-0000vo-8X
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 07:47:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tpY8kAKcHzIAcKCE2vHMRJREm6lpcKfrLwOtKZI+cFE=; b=K2WCmAhe3C2zjpFaB1bHqPYOf7
 Aq37zrSsHbyymxWEIT4S3NdWqr31nIFz2+xYmdD2j6nroDMdTLLs31MjtgSgy6UjVBQMpsu/kicbT
 qpx83LIGKQG7EJwhEBGBg0s86zvknwGFpJJAy/zGtYE016QFq25YVrUzMQD9nAoIjY2c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tpY8kAKcHzIAcKCE2vHMRJREm6lpcKfrLwOtKZI+cFE=; b=lZ+R/S9JuaewnZ4ocehRvG6pBa
 uChZ/uuFFFngJwRLCT15tBVeKuwPwGW7XJHUoHHw6ZF61v/DYfTVE+siMgM0BRyFHy9nu3e5UgQI9
 ZKOZuiOKETH7zG0oOdJE9mjzKOIwq9zTozxR3oLLDrqb9mJh/xHzzbzt0YUSAWMxTuHQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfC9J-00055c-Vd for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 07:47:57 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6627llZS003152
 for <openvpn-devel@lists.sourceforge.net>; Thu, 2 Jul 2026 09:47:47 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6627llfI003151
 for openvpn-devel@lists.sourceforge.net; Thu, 2 Jul 2026 09:47:47 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  2 Jul 2026 09:47:40 +0200
Message-ID: <20260702074746.3129-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782921496000.Iba577d662b389de539b81034735e437199cb495d@gerrit.openvpn.net>
References: <gerrit.1782921496000.Iba577d662b389de539b81034735e437199cb495d@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wfC9J-00055c-Vd
Subject: [Openvpn-devel] [PATCH v1] test_tls_crypt: Fix issue with temp file
 name on big endian systems
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

Encountered by Fedora s390x build instances.

Change-Id: Iba577d662b389de539b81034735e437199cb495d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1761
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1761
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 82b1dc8..1d8ac25 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -722,8 +722,13 @@
 
     tls_options.tmp_dir = "/tmp";
 
-    /* Since we override rand_bytes the tmpfile name is non-random as well */
-    const char *non_random_tmpfile = "/tmp/openvpn_tls_crypt_v2_metadata__706050403020100706050403020100.tmp";
+    /* Since we override rand_bytes the tmpfile name is non-random as well.
+     * Build the expected name via the same code path as
+     * platform_create_temp_file() */
+    char non_random_tmpfile[128];
+    snprintf(non_random_tmpfile, sizeof(non_random_tmpfile),
+             "%s/" PACKAGE "_tls_crypt_v2_metadata__%08" PRIx64 "%08" PRIx64 ".tmp",
+             tls_options.tmp_dir, get_random(), get_random());
     unlink(non_random_tmpfile);
 
     expect_string(__wrap_buffer_write_file, filename, non_random_tmpfile);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
