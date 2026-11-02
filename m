Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B8606AEB2
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aYRVvUMt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cVXQDfve;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UBVyQqG2;
	dkim=neutral header.d=lichtenheld.com header.i=@lichtenheld.com header.a=rsa-sha256 header.s=MBO0001 header.b=ksX9NQ07
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=u4U0lzxYgO8tFwgs6EbmnuKi4KVsaY8aRqKg0UOXJVQ=; b=aYRVvUMtSnILe8MScaMTminLef
	pQJljNKvWGdQUUYvSPTcXCXOCa113MYPa47mrYp0+woVb5PiMxmPsC2Xkau0Mre5maPMnvqK9loN1
	1df29DYwZaWPnIk6VFPNIjwt3BDDP04cYtknj6WPdkm/TrS1WNaWTKJ0P3X0HLCCjNGE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNvb6-000000001dS-2pEJ;
	Mon, 02 Nov 2026 17:13:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <frank@lichtenheld.com>) id 1xNvb5-000000001dK-0JEg
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:13:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I93AYKdvgCmNyNGA2Q4rRYH84nnUYO1A7Qf/ZNYSb8Q=; b=cVXQDfvekFWojqyK00DEARwwuJ
 DRmdsqXgXpVuTElRXWRrOuCQATfuEI2moIakUvMJLCq8KTzOl5qIVRBrgfbvDPB9mld8cD33vuPud
 nB+MVb0qCb3/Q/qcU5dQa9+ndkuApoCBTOVIO5Fl+o5xfLUlIZTDrGVFATDhgQ4dcPpI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I93AYKdvgCmNyNGA2Q4rRYH84nnUYO1A7Qf/ZNYSb8Q=; b=UBVyQqG2q6SACUbTXINR/8UyPW
 swIHK1QDsW8REMA2XcvGydT25g35ixX1NFNA4b7fREeitx/NW3dQ5ZXpuFGr4o57H40I6gCYHTeWl
 Fo0x4msd2IF0lZe8v5NuX6AwQ+VSqy+e0AhnDRxVgQsNM7cxMD82LGsCvG3bzmbXl0Cg=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNvb3-000000006GY-2zaB for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:13:26 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jJJF973sGzMlGl;
 Mon, 02 Nov 2026 18:13:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1793639598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I93AYKdvgCmNyNGA2Q4rRYH84nnUYO1A7Qf/ZNYSb8Q=;
 b=ksX9NQ07EPDjHXE0zo12wztRx79ZIR8/HgWAGqMfoimaMycn4txa4qGv3TydB6psiY/EKj
 CDn1McSkiM2ZXjvm8zbovU6TUww+FKqsc4fHBFnPp3xdQx7gnRZ6Q/Pw6m1EXotrD+wWuX
 DiFX4fSSe6+1ncXXP9o8HeoXlBCm8LTnLPs/tuMIuTWg6Z1QvITV+ftcph4he0LeEp1VWc
 J7oEo2wzj5/fwWBOFaRaBzjyhWthT1xqHbRnQdkP+Nm+wsKAriFGUnpG4/VwcJW6JzslXx
 egPUZFtnvXvSnEiCjhTVhr9YDRr9S8uPmflqGhc2NOt5JL7JpbPChqzDazlE1w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 18:13:17 +0100
Message-ID: <20261102171317.113895-1-frank@lichtenheld.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <gerrit.1793618479000.Ie0f902ae5aa8e549f76f2cf32facda43eac18915@gerrit.openvpn.net>
References: <gerrit.1793618479000.Ie0f902ae5aa8e549f76f2cf32facda43eac18915@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jJJF973sGzMlGl
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNvb3-000000006GY-2zaB
Subject: [Openvpn-devel] [PATCH v2] tls_crypt: append cipher final output at
 buffer end
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

tls_crypt_wrap() and tls_crypt_unwrap() passed BPTR(dst) to
cipher_ctx_final(), which would overwrite the start of dst if final
produced output. Use BEND(dst), as the tls-crypt-v2 code does.
No functional change with AES-256-CTR, whose final produces 0 bytes.

Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2083
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2083
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 23c7975..d015004 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -191,7 +191,7 @@
         int outlen = 0;
         ASSERT(cipher_ctx_update(ctx->cipher, BEND(dst), &outlen, CBPTR(src), BLEN(src)));
         ASSERT(buf_inc_len(dst, outlen));
-        ASSERT(cipher_ctx_final(ctx->cipher, BPTR(dst), &outlen));
+        ASSERT(cipher_ctx_final(ctx->cipher, BEND(dst), &outlen));
         ASSERT(buf_inc_len(dst, outlen));
     }
 
@@ -247,7 +247,7 @@
             CRYPT_ERROR("cipher update failed");
         }
         ASSERT(buf_inc_len(dst, outlen));
-        if (!cipher_ctx_final(ctx->cipher, BPTR(dst), &outlen))
+        if (!cipher_ctx_final(ctx->cipher, BEND(dst), &outlen))
         {
             CRYPT_ERROR("cipher final failed");
         }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
