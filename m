Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B35C2A09B
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CVhLVA0ebLwSP/5mMsbeN+S5DbzO3t8SUPexWorKSqc=; b=SfIYBL+ZF9KwL5D45xR37lpL9e
	Btq/UB/zjNK3qMB1nN7ibPqboG9e1Yp3HEjSRY8RQnwt+bFk8kRHoejUJN7biNYdTG+Xb3kyUWSTM
	duK7xMrmaSEc6fP2sfOid8BXEQhqmSqwaOnI1xTUeXfqvdPbMP9kzANnp4pA3OsVF0Ms=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsMfe-0002in-FX;
	Fri, 07 Aug 2026 15:39:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wsMfb-0002iW-OC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:39:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3EwopZtBWJoy1ytVr8RlhAnc0jD2vWYxXnyPCMbImjQ=; b=UwfAcJLRIyLoVt0CQFn0hSlpY7
 ihbsfahD60dBFnvS4WPGCrp3YUrzy7zlxvFQb5lE8R9RoXwQ5lUCtvfJ02hSvVbqjTfElLqxmygCT
 Wdq7kdg1nyXM4r3ouEiv0C+G6c/RPZhdOQQmwly+FJVCDSGsSH7NkxkGeMxawze9sNyM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3EwopZtBWJoy1ytVr8RlhAnc0jD2vWYxXnyPCMbImjQ=; b=RYeCLU1G1ZUew3HCvbmMywXrpa
 12xBTWZsl6SEKpRJN9tr1ii4iacKpvW8g6zV6+DG4UFPFEuFTphbjxaTvPtV6ZAGklVb8Sn8fNwcU
 5Rdd/1OhPOUrfnyEmYDojtR+YKj5/y45n23sN0SUB/0Yzg4pBTxvRLRu56wWTiQ/h4J4=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsMfb-0004LG-Bi for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:39:37 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hGl2d2D9ZzMlC4;
 Fri, 07 Aug 2026 15:13:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1786108409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EwopZtBWJoy1ytVr8RlhAnc0jD2vWYxXnyPCMbImjQ=;
 b=I3EMRmmsgODs6DB0WmnFEaXttz1oVziJ8TTK8TD/XvZCeVN131ROeR+35XZlZi0mQ94ZPj
 SDJDtEbWD2TjajMw/lPyPgzdYNfSyuoNWEO40CCvSZxMrK7xq7wptGB8LU9MHi0vnOKw15
 boO8NZtF3nh8n+3+ZpRJ/8GhHoyrPQ6JNSwAFLGuES5GhL0EbWv1kd/7CAsuXz816EyVv+
 IMobE/HZxp+br9Z9xQ7/2+/jWnDiSi1Q7V9yF88AvNV8tOGU8GzEPmAXV8hP9egT+K0t1b
 y1+yOrbTBRnashDUcuM8LY3XDyc5b2kv5Aej+aGrxJiisSoc0Mv8OcAwBreQ1A==
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  7 Aug 2026 15:13:27 +0200
Message-ID: <20260807131327.52748-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1784290573000.Ib6956c3a8b332866a59b41c186cce4e0bc5f078f@gerrit.openvpn.net>
References: <gerrit.1784290573000.Ib6956c3a8b332866a59b41c186cce4e0bc5f078f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wsMfb-0004LG-Bi
Subject: [Openvpn-devel] [PATCH v2] t_client.rc-sample: Add missing
 documentation for FPING_ARGS_x
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
Cc: Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Also include some smaller misc documentation fixes.

Change-Id: Ib6956c3a8b332866a59b41c186cce4e0bc5f078f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1791
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1791
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index d07c376..defa4aa 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -8,9 +8,13 @@
 # define these - if empty, no tests will run
 #
 top_srcdir="${top_srcdir:-..}"
+
+# PKI args
 CA_CERT="${top_srcdir}/sample/sample-keys/ca.crt"
 CLIENT_KEY="${top_srcdir}/sample/sample-keys/client.key"
 CLIENT_CERT="${top_srcdir}/sample/sample-keys/client.crt"
+
+# Customize ping tests
 #FPING_EXTRA_ARGS="-t 1000"
 
 # Load EXPECT_IFCONFIG* parameters from cache
@@ -63,8 +67,8 @@
 
 #
 #
-# now define the individual tests - all variables suffixed with _1, _2 etc
-# will be used in test run "1", "2", etc.
+# now define the individual tests - all variables suffixed with _1, _2, _2n etc
+# will be used in test run "1", "2", "2n" etc.
 #
 # if something is not defined here, the corresponding test is not run
 #
@@ -86,6 +90,7 @@
 #
 # hook test options:
 #
+# FPING_ARGS_x      = "arguments to append to the fping command line"
 # CHECK_SKIP_x      = "commands to execute before openvpn, skip test on failure"
 # PREPARE_x         = "commands to execute before openvpn"
 # POSTINIT_CMD_x    = "commands to execute after openvpn but before ping"


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
