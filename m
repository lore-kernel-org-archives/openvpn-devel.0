Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF79606A329
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y81U5E8j;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NhntJ6+I;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ct9Mis2i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0HUdFB5mvmIFvfiaTgJVAkrfBvSqd7vfh3d9UcCMY8A=; b=Y81U5E8jjmlgPe
	URtyMe72lU5FvtULNDzRfEH8mece2P499oKISdSsKoHCWHLoamiyXZfRbuKtuSlB0H8+et+/8xuNA
	f2+TUQO9vANiyNmrg/YLtBZpdCU8V8NZ6haowNWEsgBgkgZJB7rasl7dabTT4NqZ/Crfu/+fZP7yL
	OFc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSFzp-000000003su-3eJk;
	Sat, 14 Nov 2026 15:48:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSFzo-000000003so-0a5q for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:48:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qOanMyf0lpktdutAb6sPDo30tL5KrrUcWoz10GOUxQg=; b=NhntJ6+IcqlC02c09XncidUqvV
 JDRj3RqifooyrSTL2xXwwybAlUPlxAoTYyIqcE905QtgQq0JBkxFVSHqU36qo+Nap88dbwmQxC3am
 YuYyYw2YqsOGxqs75inYjq39+aD5Ox8LFBhFa7tn4GsH2o1SVCt//JQuuv/agqCDTWRU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qOanMyf0lpktdutAb6sPDo30tL5KrrUcWoz10GOUxQg=; b=ct9Mis2i0LGkjtnJK9MJ79MQiG
 J5scWzmfnChxEK7ZOS9tCrqpcoJlXvSf01coawU/fBi5KOSP8U4R/Qf13QGR3EObqDXqHDq/7/3nh
 DELIDLxtlhiICYSc+j3HA36oPwHByUK64eIOvrFdoYtIlG0D2XiQi9uttWNc86oABWgs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSFzm-000000000Wn-45Zp for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:48:52 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AEFmieN001753
 for <openvpn-devel@lists.sourceforge.net>; Sat, 14 Nov 2026 16:48:44 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEFmiO7001752
 for openvpn-devel@lists.sourceforge.net; Sat, 14 Nov 2026 16:48:44 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 14 Nov 2026 16:48:37 +0100
Message-ID: <20261114154843.1738-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793686929000.I5099b109d43664d5b83adfded6adfaf5ae9d608f@gerrit.openvpn.net>
References: <gerrit.1793686929000.I5099b109d43664d5b83adfded6adfaf5ae9d608f@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSFzm-000000000Wn-45Zp
Subject: [Openvpn-devel] [PATCH v1] ssl_mbedtls: wipe private key password
 buffer after use
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

tls_ctx_load_priv_file() left the private key password on the stack.
Clear passbuf with secure_memzero() once the key has been parsed.

Change-Id: I5099b109d43664d5b83adfded6adfaf5ae9d608f
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2099
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2099
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 8aaca96..9561abb 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -481,6 +481,7 @@
             status = mbedtls_pk_parse_key(
                 ctx->priv_key, (const unsigned char *)priv_key_file, strlen(priv_key_file) + 1,
                 (unsigned char *)passbuf, strlen(passbuf));
+            secure_memzero(passbuf, sizeof(passbuf));
         }
     }
     else
@@ -491,6 +492,7 @@
             char passbuf[512] = { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
             status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
+            secure_memzero(passbuf, sizeof(passbuf));
         }
     }
     if (!mbed_ok(status))


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
