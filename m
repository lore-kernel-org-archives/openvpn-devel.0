Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3317DCA5FA5
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MOHCnENBi5b/0/AQX4kO6q1+P/Z/cb8sXyoPAd4Y4rw=; b=knpujXwCvhwg+Td2hx3l8vMe51
	tIN6nnfzqGhe9WboswD4rnDOE7b4Isdv+/kQrDCGvjH9cTt07ml24nefIAfylstUhCGQ1OkYoEfaL
	K7SZaGGvjUJeylGsIjSRDm/Dd5t8Ku9P2sQotml0A4m3iZd0MZCrbSD7QFCCjLe6kKno=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBCt8-0002nJ-LA;
	Mon, 28 Sep 2026 15:03:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <drew@linuxkids.com>) id 1xBCt6-0002nD-LK
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:03:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R2YE17U0FQKslV0yZr3KOBZEq6PvSGhL9OXcvkwoygo=; b=dvs2euDpUXjJa0HrkmKVlW4+zY
 9i5qSC7IpZv1CBPmI4XO0in2VOG9ctpwZTtXMW4f66+QrsVWNiYuCSHCVU1yK5F4v1Rc/n57CSTS2
 6HhcnbjvMDzoz6OdVbdKP3adVEgddHrkjWw6+aryvUxewNOuLeFtwwDQ2az9+JJmUen4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R2YE17U0FQKslV0yZr3KOBZEq6PvSGhL9OXcvkwoygo=; b=Z17HBAvya1TdGDJW7h9s+4ii1A
 UfGJZaNWUPwjxr5ZAjuli+RJlrrOW+idOzutImGhdFHMdtQRNknYKp6yLQXpBH//b6c/Au+UC4bVh
 2xWrK828WiEyFBbNKmtZzX67ufNC6E/sAx4BqgehavOyz3gRJlPacAausBNV2tz7KeeA=;
Received: from mail-vs2-f15.google.com ([74.125.227.15])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBCt2-00050e-Ld for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:03:26 +0000
Received: by mail-vs2-f15.google.com with SMTP id
 71dfb90a1353d-5c981b0d59cso2196453e0c.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxkids-com.20251104.gappssmtp.com; s=20251104; t=1790607799; x=1791212599;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R2YE17U0FQKslV0yZr3KOBZEq6PvSGhL9OXcvkwoygo=;
 b=n3p7+KI9SMeihwGiq9l7ovOIgCJyfvwOkNufywriwGehCg2/jOao1im1u1Tmyrqnsy
 pCE4hy7aAhx5gwEaNS7Zn9A/WjIuNyEapbKgoYxhfIy81AqXc/OeDHXX5Yv+GB6TH+8j
 Eh48G2HIuUVVtBhbZTsBKrAU3xttKqwaXYU2fsxLTtRtpeqq+YHLj/nrlwG56c4fixWx
 /s8SDNLzGYbrJ+DDWg8EnBdTOzanGCHvfcMdDKFYeaU3YuiGubmjqli13m1JlTLWrfMS
 Bz2JjCSfA+SBxu2t8ibOdvmdq4ttMHHSd50oMErGQVzRp+WuGc2cmZK0EvEi6O8K0fIi
 eH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790607799; x=1791212599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R2YE17U0FQKslV0yZr3KOBZEq6PvSGhL9OXcvkwoygo=;
 b=C723HzOrnR3Ts5qAOqA7GK7CNBPwVS6MI/bPyV7SDwlMRK4Uo6CTaR2jNStc+p40O7
 p6EtUC7LLwWwojayF78hIJXkmYEehhF2enEwLfFju7ncqxCjiwzQu9sfngyGnqkANEnR
 DmSKfUenJ6ZfPnnJys5qnCRI+OkC/tLJ8Ya3nXSc8MJ9TkE9yh+UBfkCGVUSJ0Tr9cWH
 fHcIfS8KaABJCZFKlhcjEMFKOSIPQsq+V4VHLwJj6EtJDWmoYV/mgzDBpkrK0dtQ1nhR
 TLDzd5yYdgFPhiRBBcDp3lEAp80wxsiX4qRNVWUPHbownOfzDdK4qo3veSBtefY2pCzz
 0EUQ==
X-Gm-Message-State: AFq9FYKvQNTA0k00dcAFluuS4K7+4MKDw7dLj5+FfO/D3wj1ageMFtWI
 d4OWPjLgT/USL2N+IDAuWkja1adoV0wWJpz8PjjXL0xHjrQ+u4tBmDhKHABfzs78p2XIsevP5JG
 6HJYfcMYx
X-Gm-Gg: AYBFou0ChjDJ14mB7Igwp9ht+s6h4atVhol96J2rirrHqLC2XXkm7nqHZPtpQfy1jB0
 eS7/pBB3IEwPCqV6dqIkk6AJ3EOCP/o494qDPcEBU4NCpYm+6gdGD+9bRV7NGiiEZDrElLJQgVE
 cHS5xgPIgEv87cv3b3aAFIMUaBiAUxs7N0WkjLlWZwhFF+oD1qqReavMgjYR8hVnco9iYa5prGf
 A89htpKx54P5NRLMap4/az6X8K/Y/eSektT0+gJMewmDYsyMc5VuvAUwdH01B8amZJfSANzlhXW
 9B3L3OGitkewYPTEm+cHmI5iBl3NbKQj6umz3J76WclmW/SYu+jJWcDFSeXQkhXo91eW6nBuxo7
 PDnE7TNhxXoflD77B+65Mb4d4vmOZCVMBYfz2NpGIdeNVdgXQ5L5c8+Bi2fRGj8FUI3rmGb92hc
 JPnk0qJE2ymyQ3cwjThXxaNsFQwxqH7zaOUQa3pEcO5HDjyMspRVSc+oZewjusbqH14D0Li1wD+
 CmA03uoLwBuziW0GXRHD7HjfswwVDwOog0y+HHyOvFHeLxCTIXxuHUk+2PYT9w=
X-Received: by 2002:a05:690c:dc5:b0:882:1d1e:d73a with SMTP id
 00721157ae682-8a64bb00575mr56471247b3.4.1790606255711; 
 Mon, 28 Sep 2026 07:37:35 -0700 (PDT)
Received: from MN-277C755CCA3B.localdomain (71-208-239-209.ftmy.qwest.net.
 [71.208.239.209]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860e5e9besm45668487b3.11.2026.09.28.07.37.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 07:37:34 -0700 (PDT)
From: Drew Blokzyl <drew@linuxkids.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 28 Sep 2026 10:37:30 -0400
Message-ID: <20260928143730.47047-3-drew@linuxkids.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260928143730.47047-1-drew@linuxkids.com>
References: <20260922140520.71500-1-drew@linuxkids.com>
 <20260928143730.47047-1-drew@linuxkids.com>
MIME-Version: 1.0
X-Headers-End: 1xBCt2-00050e-Ld
Subject: [Openvpn-devel] [PATCH v2 2/2] Make CRL reload EOF detection
 independent of stale error queue entries
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

backend_tls_ctx_reload_crl() treats a NULL from PEM_read_bio_X509_CRL()
as EOF when ERR_peek_error() shows PEM_R_NO_START_LINE. ERR_peek_error()
returns the OLDEST queued error, so any entry left behind earlier in the
thread turns a clean EOF into a "CRL: cannot read CRL from file" warning,
prints the unrelated errors as if they came from the CRL file, and still
installs the CRLs already parsed. The previous commit removes the
leftover that triggered this in practice; this one stops the loop from
depending on the queue being clean at all.

Start the loop from an empty queue so only errors raised by
PEM_read_bio_X509_CRL() are visible, test the error it raised last rather
than the oldest one, and clear the queue on the EOF path instead of
popping a single entry.

Signed-off-by: Drew Blokzyl <drew@linuxkids.com>
---
 src/openvpn/ssl_openssl.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 7cfe9f4a..da3e07fe 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1360,6 +1360,13 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file, b
     }
 
     int num_crls_loaded = 0;
+    /*
+     * Start from an empty error queue so the EOF test below only sees errors
+     * raised by PEM_read_bio_X509_CRL(). A stale error left by an earlier
+     * operation in this thread would otherwise be what ERR_peek_error()
+     * returns, and a clean EOF gets reported as "cannot read CRL".
+     */
+    ERR_clear_error();
     while (true)
     {
         X509_CRL *crl = PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
@@ -1367,13 +1374,15 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file, b
         {
             /*
              * PEM_R_NO_START_LINE can be considered equivalent to EOF.
+             * ERR_peek_last_error() is the error PEM_read_bio_X509_CRL()
+             * raised last; ERR_peek_error() would be the oldest queued one.
              */
-            bool eof = ERR_GET_REASON(ERR_peek_error()) == PEM_R_NO_START_LINE;
+            bool eof = ERR_GET_REASON(ERR_peek_last_error()) == PEM_R_NO_START_LINE;
             /* but warn if no CRLs have been loaded */
             if (num_crls_loaded > 0 && eof)
             {
                 /* remove that error from error stack */
-                (void)ERR_get_error();
+                ERR_clear_error();
                 break;
             }
 
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
