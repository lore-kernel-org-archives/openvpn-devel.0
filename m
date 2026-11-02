Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD8D606A338
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M40hDNGe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZmKOtN7/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bqTG2MwC;
	dkim=neutral header.d=lichtenheld.com header.i=@lichtenheld.com header.a=rsa-sha256 header.s=MBO0001 header.b=EHzs3y6H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Y00fywgM9sAFQtUSYiMh+ieBU0YKxs5yL8b7CcjuTDQ=; b=M40hDNGe8brpqq
	2ZW+U2ZMN9zWIJU0btmda26Y9o1vP6rSrtPk4ZCisI0a3OUpZi9OJIQwc0S42lwaFwo7hVnd55mAC
	ESy4GKCdQ+ib+3Qs6W77Cw4Bu3vwnMOAL0+6He94L67Naj5/jGc9+ggXdsQ9RgXoGtafc4KbMlD/Q
	qPU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNvOu-000000002oR-3vRq;
	Mon, 02 Nov 2026 17:00:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <frank@lichtenheld.com>) id 1xNvOu-000000002oK-1o6q
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:00:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZyoXMDq1TD2JsqePzGiS0gFzO7cUfijUrXD6Dz7k+uM=; b=ZmKOtN7/nb2izmq2gXzslFxZlB
 B/Glz0AJUL11xDzlfSVR5gLQ7vzeSY1f0ClbxdybUONSW6dgZQNx9VToGRL2xN0+g2TdJXfUmCcHy
 fr/FkN7cmsStQ/izHbqNElCXLSPNTZ3h+G3e5RlS1QwycZNgQMk+M3WGt04zyZ7FTzUw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZyoXMDq1TD2JsqePzGiS0gFzO7cUfijUrXD6Dz7k+uM=; b=bqTG2MwCwL+wZ3JN3V6a3grtU0
 HmhBvKs764iVtCb23KMpXolNhn3Ld47iAJx54mb1PcngWJ8YnVD99V2xOWPykUAqKA69hbJFXhkq6
 E2lyolb2M1ycdP2HYHIUSqiRtZ9db357bCvz1Qwuf0rWKqB7JIN8kk8jl8bijg1CCl20=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNvOs-000000005xj-39kw for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:00:52 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jJHyf27nhz8v9C
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 18:00:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1793638842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyoXMDq1TD2JsqePzGiS0gFzO7cUfijUrXD6Dz7k+uM=;
 b=EHzs3y6HBxoE6NYkDQR8AMs0i0zHTb7ZH8BOOKlRfAHMsqXQpjKk1mD9SH7QA8r4NucIfB
 h+DbcqFMgJL1IdXF3iRkjaQNQSudVS5EMblwUZskDhvLDI8h+muY9sWJxj8E7em8P6unuL
 l+x6xQLNuYk2QDxITqW3G5sr23FVDuzOB+UpCayGsSvCsGgxHUM7WfYDYgkVv7gQ68gUYn
 0gRqrvjlUczUzcSI2laAd6u5FPi7qpcckoKILkSU2lQLosRR/H6zAUHh0LcWqIIwV0oMNQ
 4wDC3GEA1UrxO49cUiymvc9vlES9t5MuaO2pOmulah5XuJu9qcBe8vTYTRuluw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 18:00:41 +0100
Message-ID: <20261102170041.110861-1-frank@lichtenheld.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <gerrit.1793637321000.Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b@gerrit.openvpn.net>
References: <gerrit.1793637321000.Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jJHyf27nhz8v9C
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNvOs-000000005xj-39kw
Subject: [Openvpn-devel] [PATCH v1] manage: use man argument in
 management_query_cert()
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

From: Razvan Cojocaru <razvanc@mailbox.org>

It passed the global management to
management_query_multiline_flatten_newline() while using its man
argument for the state and input buffers. No functional change, the
only caller passes the global.

Change-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2094
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2094
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 16864c8..d391559 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3937,8 +3937,8 @@
 
     char *result;
     result = management_query_multiline_flatten_newline(
-        management, NULL, (char *)buf_bptr(&buf_prompt), "certificate",
-        &man->connection.ext_cert_state, &man->connection.ext_cert_input);
+        man, NULL, (char *)buf_bptr(&buf_prompt), "certificate", &man->connection.ext_cert_state,
+        &man->connection.ext_cert_input);
     free_buf(&buf_prompt);
     return result;
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
