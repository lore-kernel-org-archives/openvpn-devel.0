Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65005606A31B
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IMLKqZJc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kZCzaQci;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GnQDLWpv;
	dkim=neutral header.d=lichtenheld.com header.i=@lichtenheld.com header.a=rsa-sha256 header.s=MBO0001 header.b=SqQWadTV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=T2MJjYCGhWj95VDBGH+RkAECoAiBl+LeD8+JMEgSk/o=; b=IMLKqZJc+fi7nEF8It8BztHcr3
	iDR9DT5NUyt7ogXrmvc5ciE3vDcXC2P9lccUgX2GaEBrXSNH9GrvcoAoIqI+vVyhRdM0GI/uv5L2c
	zUTqrywla5nrvV5KF/jW5eF6MBpzN9yGML7GsIenSx2caVA6qColWnFNP4uMgUPUUecQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLIT5-000000004aD-3Mgi;
	Mon, 26 Oct 2026 11:02:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <frank@lichtenheld.com>) id 1xLIT3-000000004Zq-1UX3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 11:02:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6kdVORpk+DF9j7JRp8NSX6CS98rMtuOGjnOZDK1cjYI=; b=kZCzaQci+p2wjv7xnvvmH5x61S
 +MotvkiwANpNQl2YOpwIXvnwPSsN3SamAqs95jznIeSNmZtosU+CE2Z6zTc0k5n3vOUQTTFgNCoQv
 Bv92UE0w2Ez47uroUesXJLtDuA6SZJBhqoBDsq3GH/5z9m0hwBgsv2eeAd73q++SYFlY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6kdVORpk+DF9j7JRp8NSX6CS98rMtuOGjnOZDK1cjYI=; b=GnQDLWpv0Pr7hU9oOv4sIXQtpr
 mD9WeBRyTz+6eJaa1q7mKaTTYi6bQfs9W/Gip/S2iEYkCUoBz/F+qT+AqFvdldzYPZE3ky1GsNl/C
 lb7FAg9ZalpF53ee8x9AjXu+yRi1JCiRnSV3EGz3csgPGoyXSnY5Mc0ZJ6cw8Ls1Vbzc=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLIT1-000000006bg-2Ew8 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 11:02:17 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jCrL700xTzMlJy;
 Mon, 26 Oct 2026 12:02:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1793012527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6kdVORpk+DF9j7JRp8NSX6CS98rMtuOGjnOZDK1cjYI=;
 b=SqQWadTVZqPwX6FFWr5b0Iy1iP5Kxs0bEfm0Ke9XOH9QxqJFnI77VW+L6367TcJ0kDwt0K
 aQhP++5zr4tzERxkGwq24Qlbwwgf1OLtvvzvg39BgUq5I1zcOstHpb3YEGxHQAWmhI/r9Z
 yuwDnnRNAUi/At0Win16Rlvp+wuqxRDHcFtYR9NW0KDtZNKvdnI4LRdF/cDlakMCUPS2+C
 VQPzjdUDphKXWNO7odXHULAV2/WpUB0Jb8f6IIjueDCvN0GsMYEKt2nMhe7nxuBgJN1w/d
 waUG2d9p5PyYnl+0A3dgcaX11v2J3Zf5cgHbOCj3cV5hBJFmIPRa7ItjvK0OLQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 26 Oct 2026 12:02:05 +0100
Message-ID: <20261026110205.55077-1-frank@lichtenheld.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <gerrit.1792963979000.I136d57b7487f228e37894fa710b1ccc2c4606eb5@gerrit.openvpn.net>
References: <gerrit.1792963979000.I136d57b7487f228e37894fa710b1ccc2c4606eb5@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jCrL700xTzMlJy
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLIT1-000000006bg-2Ew8
Subject: [Openvpn-devel] [PATCH v1] Fix typo of nprocs instead of nproc in
 run-cppcheck.sh
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Antonio Quartulli <antonio@mandelbit.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arne Schwabe <arne@rfc2549.org>

Commit ccd058e75 accidentally used nprocs instead nproc, making the
script fail on Linux.

Change-Id: I136d57b7487f228e37894fa710b1ccc2c4606eb5
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2031
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2031
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index 58609b2..a9c4643 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -22,7 +22,7 @@
     num_procs=$(sysctl -n hw.ncpu)
 else
     SCRIPT_DIR=$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
-    num_procs=$(nprocs)
+    num_procs=$(nproc)
 fi
 : ${SOURCE_DIR:=$SCRIPT_DIR/..}
 : ${BUILD_DIR:=$PWD}


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
