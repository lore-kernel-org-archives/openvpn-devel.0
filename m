Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26562CC6B3A
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hp68xVLzrDYP/j5XyRkqK12za/PIYmhlct0tfEqWdfM=; b=hyzb932tM09M+S1uW7M/aXvgNB
	hGOd7T3COJhFOS6/FPOUHni/CBoFjekBFt5aBP3NgcKceZWhYDzfk3+qC8XjbM/aD1lCn8OmKD93y
	cFDgnF8Kztlj0FSfIb0LIU49e5pJMtbWGU7XD7YyD2XjvuZXwvS7mM0BzOetWL+vTHws=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHJM8-0007Ll-Rj;
	Thu, 15 Oct 2026 11:10:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xHJM7-0007LZ-3G
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:10:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1n6xPmworAJKeGFTLru6Rn6R9yuXLI7Bmmii6hYLiYQ=; b=NOQCvhPZQVOIXdnKotntPBUOoS
 tNv3K+aOrjTYGHoklLgQ86NoTG+pfu9zwJeUIrlj5Ea6y3JrioyILA/7D15oAp2/UOEamtKJ8ngEX
 GPqsBxJar3LR8rtuLyd8V1hNrtP93/ffx/j4EA0oXF1/jkZs7Qsi+wgHuGVj++D2iUpc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1n6xPmworAJKeGFTLru6Rn6R9yuXLI7Bmmii6hYLiYQ=; b=kRr0Jk4cpDx529NV0tqoJ/4MFQ
 ZIwWACNHwbOaGkAXmMma/HDT7OSJzXg3TeezrOGkvqwAM051qYNiACSJO90jFMDe2qcTKXxLPGC87
 p8bWjb/jPuI+SZUHttTUpZvuMYybuaIzqUGFW3FBOLxYiL9x1pSMtCZtIL8s4R1k5Qy0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHJM6-0004S0-My for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:10:39 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69FBAV3T022585
 for <openvpn-devel@lists.sourceforge.net>; Thu, 15 Oct 2026 13:10:31 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69FBAVFY022584
 for openvpn-devel@lists.sourceforge.net; Thu, 15 Oct 2026 13:10:31 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 15 Oct 2026 13:10:24 +0200
Message-ID: <20261015111030.22570-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792062421000.I6294665e39ddf012f0a3943d0e356576f4fe02e1@gerrit.openvpn.net>
References: <gerrit.1792062421000.I6294665e39ddf012f0a3943d0e356576f4fe02e1@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xHJM6-0004S0-My
Subject: [Openvpn-devel] [PATCH v1] clang-format: Enable InsertNewlineAtEOF
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

We had some patches recently that committed files
without newline at EOF. Enforce consistency.

Change-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1999
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1999
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/.clang-format b/.clang-format
index 0823739..23d224b 100644
--- a/.clang-format
+++ b/.clang-format
@@ -32,6 +32,7 @@
 IndentWidth: '4'
 IndentWrappedFunctionNames: false
 InsertBraces: true
+InsertNewlineAtEOF: true
 KeepEmptyLines:
   AtEndOfFile: false
   AtStartOfBlock: false
diff --git a/src/compat/compat-strtok_r.c b/src/compat/compat-strtok_r.c
index debcdd3..4240458 100644
--- a/src/compat/compat-strtok_r.c
+++ b/src/compat/compat-strtok_r.c
@@ -98,4 +98,4 @@
     }
     /* NOTREACHED */
 }
-#endif
\ No newline at end of file
+#endif
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index 6c60dc2..ff243dc 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -389,4 +389,4 @@
 {
     s->earliest_wakeup = NULL; /* invalidate cache */
     schedule_remove_node(s, e);
-}
\ No newline at end of file
+}
diff --git a/src/openvpn/siphash.c b/src/openvpn/siphash.c
index e31b708..b9fc5e3 100644
--- a/src/openvpn/siphash.c
+++ b/src/openvpn/siphash.c
@@ -46,4 +46,4 @@
     } ret;
     siphash(k, length, hash_key, ret.out, sizeof(ret.out));
     return ret.hash;
-}
\ No newline at end of file
+}
diff --git a/tests/unit_tests/openvpn/siphash_openssl.h b/tests/unit_tests/openvpn/siphash_openssl.h
index 0f1d329..49c6a9d 100644
--- a/tests/unit_tests/openvpn/siphash_openssl.h
+++ b/tests/unit_tests/openvpn/siphash_openssl.h
@@ -61,4 +61,4 @@
  */
 bool
 siphash_openssl_available(void *sip_context);
-#endif /* ifndef SIPHASH_OPENSSL_H */
\ No newline at end of file
+#endif /* ifndef SIPHASH_OPENSSL_H */
diff --git a/tests/unit_tests/openvpn/test_schedule.h b/tests/unit_tests/openvpn/test_schedule.h
index 55dc591..3705af9 100644
--- a/tests/unit_tests/openvpn/test_schedule.h
+++ b/tests/unit_tests/openvpn/test_schedule.h
@@ -24,4 +24,4 @@
 /** Runs the schedule test */
 void
 schedule_test(void **state);
-#endif
\ No newline at end of file
+#endif


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
