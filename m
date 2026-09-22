Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320C6C98302
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MOHCnENBi5b/0/AQX4kO6q1+P/Z/cb8sXyoPAd4Y4rw=; b=SXZwoI5zMA/nKMjJ4oRgcjLn3B
	wK8e5oQRVz6mj710n7QR0ZEdecXhJJBYWUhqadjF+nGXsnWgi+Gumgn/HZNeD7MgEsUFB0XMuxZ9a
	ziU8M8H10ZQ95YL3sqECpYek5kNoP+H9DQmmvqfHJJtfkxup65ycm5vY4/rmpVUcDAng=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x91W2-0006BJ-BD;
	Tue, 22 Sep 2026 14:30:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <drew@linuxkids.com>) id 1x91W0-0006BD-Qs
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:30:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R2YE17U0FQKslV0yZr3KOBZEq6PvSGhL9OXcvkwoygo=; b=MCsbQxVNLrOJG+Dzp30logm4P0
 f/Z8kwZ450jmQJ5v8ZLv+ekEeP2P5mvw6RqSGauxRE3WWiBZct0YlsjjKIso6lMO+ih2vyAlx1WGS
 gQWtHdDWNTiEdiRSXL9lKKZ40Y55GZEwvCZ+ILtfAMwId824jFumZ3vj6KfoBj/yAlLk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R2YE17U0FQKslV0yZr3KOBZEq6PvSGhL9OXcvkwoygo=; b=YveeAS3zJn0hexRtLekYxDWDFH
 dn7YqGHwkRmaplNDg3h2PZWO4jcdUlktcAL+lsuvqfmN7X6tQMYFzOp8ofcohCff8uITLyaU9RO8V
 Gvr+Z2ZEu5WMm4sUg/W8dc/qoeZZsXvUROCuQLY7rzj8i3hwuVKq+db+5NB4sI33S+9Q=;
Received: from mail-oo2-f41.google.com ([74.125.231.169])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x91Vw-0005h9-Vy for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:30:34 +0000
Received: by mail-oo2-f41.google.com with SMTP id
 006d021491bc7-6bc475ffcbfso1395606eaf.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxkids-com.20251104.gappssmtp.com; s=20251104; t=1790087427; x=1790692227;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R2YE17U0FQKslV0yZr3KOBZEq6PvSGhL9OXcvkwoygo=;
 b=U0M8qZ/lIcgUQWC20Cf4nRLsCWHVDlHkHH61GX7KLHIFKAyXFKuwvB1qfBvPopbvRB
 eAH3NT9zlq01/UxK+AicrBFBsHYJDfKXTur446W0wlCOdSTZslGFSs5CKyNBef6V5ryj
 hVK+W5aAiAXn8vdnGtX8X2SkyxT7l6xnW0haYOSJXPacSRGmkN1cY8JtBhDIGKL4/DJe
 aq4mbLknlsjYYdzayTe0l7fojjJ8p8oZ4ekR8+nkZw6VZJDGdeSc5A5MjAV5Z7W1DpBW
 dbH91PmFl1lmmKEY7r/VV62YljgJDVqRGdBqU28H95OvY3jzn3XQ1UiaKmZ4CrgvhIlO
 b2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790087427; x=1790692227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R2YE17U0FQKslV0yZr3KOBZEq6PvSGhL9OXcvkwoygo=;
 b=gIRiBQnDqG/jtphsBAOonir01KXHhWx7ZubbvihhHZhYysYPGPMHjTWXk57ouY7g6l
 JN1yZWznTiE/SKuYDuWRwq1LR0wFLzr5rLMc/j0GeiwXQzCWAX6Bnr5miGpqkYL52D/D
 00PAN6eAlTVIKj2VeNPm+xvURcLX0yIw13vdGJyg2NQayTyPr/y+z6m+JCBs8o+YGyiA
 TE809iWP3TuqpwFf4Lt6BDKgeIfYmanM9rFRgHZotliRqPSFvHnUoB8NtGvbIuJSbXSv
 gw9SW8keGlUIS6eJUGITetw5sVGHCeXvljYB8LqEprNqXRsfcVbz9+M89crbxCAHCdcV
 u0oA==
X-Gm-Message-State: AFuF++lBwAoVqgqW0f0fMstFIfM+RSN1qp/Ao7YJOEvFgDuPBhDlU9RX
 Z5YbwhSOk6WF0C8Q/ARm3u8v7CZANTvGCqlwhms8QcJ/4az+Lf0Dxw0bjDk0ND2Vb70fmN+4b8y
 h7XEL3F19
X-Gm-Gg: AYBFou1s4GtCAuT1zEDfnvwn9vqJ4h26V/pG5WHi0r6KKW5W9qYnMvdT2knJuyL+c6Z
 YxLwDyKTPuDBmkxpJ7whCpiNDwliS2+Cb+ekjVjVfRv8WNr+MTqWCR3U982yXROPA6A5AOlXPNL
 vzDe4nYE/wCAM0KLD628nUkvrhjyAJlQV7mXIWCXsqHm8NyZMyr8O6i5gk2cGdFAdx1la/Df5M9
 Jl04g04yE/6Vhh8a77ElEmJPYY20TeMay0xr5tNSMSJngZYj7Cm5DexeBapO8ZBbf96PocEnbM0
 97t/+R3+UoLZPsszUD6//dFQnKGQCcddlBevH7KQEYQda6p/wrOcQJU9Z0I7BOkuvpLiT5nj8/N
 8G5lvBfg4ErpsvSr+lkMR9pSLYCk/XlAN3J0DksajwtTNWNMKIsslm33MNyWsnrl+QjNq03wNl4
 9hnVTursJosuiUGWAyH9Qd5OEGZDzmIhxPS0q2qI09lLTDpxmTFoNLqfmpcR4SaFWqRdQgN/n2X
 YAuG5JQF0pZpqW9lkk5PJ9q5/ygsmG1lPRqZgT06R/eMsfYTAWe1tOAgf4cYB0=
X-Received: by 2002:a05:690e:1511:b0:66c:ea12:95d9 with SMTP id
 956f58d0204a3-6717fcaa502mr4295285d50.22.1790085925678; 
 Tue, 22 Sep 2026 07:05:25 -0700 (PDT)
Received: from MN-277C755CCA3B.localdomain (71-208-239-209.ftmy.qwest.net.
 [71.208.239.209]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d166300asm230404d50.3.2026.09.22.07.05.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 07:05:25 -0700 (PDT)
From: Drew Blokzyl <drew@linuxkids.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 22 Sep 2026 10:05:20 -0400
Message-ID: <20260922140520.71500-3-drew@linuxkids.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922140520.71500-1-drew@linuxkids.com>
References: <20260922140520.71500-1-drew@linuxkids.com>
MIME-Version: 1.0
X-Headers-End: 1x91Vw-0005h9-Vy
Subject: [Openvpn-devel] [PATCH 2/2] Make CRL reload EOF detection
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
