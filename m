Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927A3CA5FAC
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R7wudGp5WGyOyhnwOR/5ZLBdLkt5q+0BFAfhfIpjqXg=; b=GJ7ESK3MB2L8v1d19Woql77Hgq
	qpSFQiSmVWXxrwv4Tpl8NsPmpG3oAz9rI6W8YVpx7h1+sS9zE0fTihYwwPJ8PAQwK1S1s86kSYesh
	N7jdIJAVoUBn2pX75QhH90qubAi2HT+WUs0s2u9eFzKy7f5TI/GRnKP1BoCIRYddROpY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBuTM-0008S7-05;
	Wed, 30 Sep 2026 13:35:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <drew@linuxkids.com>) id 1xBuTD-0008Rw-3j
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:35:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QnqTcy2r76nsYbwmco1+y8FAUQ2KjXCh5RLVao63fY0=; b=ao4/iDMPueykFrCxxSqAL9m74V
 vx6rRr+rAKzmN7clafNldxVeQngtPe3+38XQq+tveWoAWuKWZBTxVFCN6fzGDtt2WnyEuYsQUe8a6
 fy3Wk8UfeOheunK5dokln/XZCLLEpTy25rYlc5qXdC5bgm8ZBMaNqe1sBTZEVjpFpbc0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QnqTcy2r76nsYbwmco1+y8FAUQ2KjXCh5RLVao63fY0=; b=cG2yNuvkE1LE0CHoAK4bB7mcis
 behZcyvj29Kjw9JWsqztAldEXbMdcvYFJWv7mRiWMkL4NVQUxAZGJ2VXC7aj8OraHTx6XIm3uxXyD
 30rMS8qIHayM2XPPclZS4Fv/KVXFAtCLFcGEP7CbJcxkc2AvTe5StlBN7ctstAi9wnNo=;
Received: from mail-vs2-f41.google.com ([74.125.227.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBuTC-0005u4-I2 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:35:39 +0000
Received: by mail-vs2-f41.google.com with SMTP id
 71dfb90a1353d-5c981b0d59cso3719083e0c.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 06:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxkids-com.20251104.gappssmtp.com; s=20251104; t=1790775332; x=1791380132;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QnqTcy2r76nsYbwmco1+y8FAUQ2KjXCh5RLVao63fY0=;
 b=gMAToRefn3vMPuUnOXNnTLKiIq6dmtzcq1dH1BItUBoJIiNtgsXQCnSkKrtTBabvyL
 43XOau3MMlpnhg7ZN/cyAP6GSGft704Xuyj+j1rjekm+u2lwisV9vco1NsX/Dyon6TSc
 9jPraTSrtlo8ZcCzZs/amKXD99aKNvYhuRfgYfFb5olnLo8n/pzRg//6yyFs/I0G0/JV
 HKztKX0mcczwwL2Ldm4O0dMc4qwU8JGQm+nOchC597rLIRQX1ir4xOlyjszjAcHZQPzR
 deiYvBy/eSuduu6LXF4KG22+qAzTOBxy0McbaWCP3j1yJ8lu0LoF0ZXrPKkynxc2RUD9
 Ar7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775332; x=1791380132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QnqTcy2r76nsYbwmco1+y8FAUQ2KjXCh5RLVao63fY0=;
 b=tprBI/Jxt3dL8M7zj8a1Peonz7vU0M61jTUM3TUeEXiWNLl+CELtKEFH5RNSpqHj6m
 +6W/x8MLtSWQEh0sIEvIT/cOyUKXwIBwqUw/MoQ2ogA7CUYStU7GrmdaN3a3LOOK3ftP
 Vu+KUpAH4xdR8raR6lf6Lj64e2fubsq6oODQtB0obWM9Z/9b4ig4Kl5NdhYsq5/BcG7m
 4BrtWf8tPY9KGAtPoWwr3Ogjlgn5dcYPa1ifOBqxINPznVJBIc0Y+zvXa0iedYiZ4jyP
 VKhz9DOnjXzSubktBB3vHfY6xKSc/lUHhxvPF7ib5bbIkc5ZmTevZXYYfCdIQFiw8E4a
 FHgQ==
X-Gm-Message-State: AFq9FYKbE68/0muf1Ispq0ZuBVKbPT8mpSpyUkJef/qIFL8Be/BfbEph
 QAWvWu1M2f7TkHC+F8mcS5awICCVIgQ4FnZAvBNFLvKHtJPj42V8zO1Ax0ix1XChiZ1XiDtaaJV
 j8ZcmgA==
X-Gm-Gg: AYBFou1UPTHn6gZj2XG1gGXah5bgtYn1P4Xq6bQnMeWLxEmt7MWRw9xoTmG89isapvd
 lUMPPivFy4GNL5WwHc4DIfLM4zR+6XwYLcqvXIqnEzsN+YolOozsduYagSdF3M912h2UgECFwDB
 6luOotH0FyBL1UGyJ3ny8rfUEv7lfA0x6y06qKsoefT1FuQve+OllhRgR6itFEc2iWW+M9OY4Wr
 eI/atu9Fj3DgRWpiY0Gi92ZhdbMI0VQzoLAOJBwuvrd3vm9efwtIGUE40N78tzPnCzqW6kZDy1k
 WMrq9QmlaCvAPrpjTb0UoX6WepBN11ZPM7e27QcyQi68vHJnAG/RMM9zjXfVy914p1vQFZ7aIs1
 9vm2QJ/DDkHQ2zy7KDR/sKoQW7A2yWEkr1RRpJsY/L0UGXYowNsBZM/dQnOUnMwv0mQjCUO/tqV
 xEkD012WcXJfHg4Y90E6gPNg13ls1TV6rAV005GytNV21IFIjNo0eMcIlWO6J3N2ZqTbpHZtF3i
 wYyRcxPEWAUPiAPpgEseYhpqoeVZSjlDMeUywJb/uqGL4lAi9EadjiCMxluYqo=
X-Received: by 2002:a05:690e:1382:b0:66e:57d8:6a52 with SMTP id
 956f58d0204a3-676833245d0mr564266d50.7.1790774831771; 
 Wed, 30 Sep 2026 06:27:11 -0700 (PDT)
Received: from MN-277C755CCA3B.localdomain (71-208-239-209.ftmy.qwest.net.
 [71.208.239.209]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67680ac3521sm704189d50.1.2026.09.30.06.27.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 06:27:10 -0700 (PDT)
From: Drew Blokzyl <drew@linuxkids.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 30 Sep 2026 09:27:06 -0400
Message-ID: <20260930132707.51452-2-drew@linuxkids.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930132707.51452-1-drew@linuxkids.com>
References: <20260922140520.71500-1-drew@linuxkids.com>
 <20260930132707.51452-1-drew@linuxkids.com>
MIME-Version: 1.0
X-Headers-End: 1xBuTC-0005u4-I2
Subject: [Openvpn-devel] [PATCH v3 1/2] Do not look up the "none" cipher or
 digest in OpenSSL
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

cipher_get() hands EVP_CIPHER_fetch() whatever name it is given, and the
callers that only ask whether a cipher exists or which mode it has
(cipher_kt_mode_cbc/ofb_cfb/aead(), cipher_kt_block_size(),
cipher_kt_insecure()) treat NULL as "not that". For the "none" cipher
that is the expected answer, but under OpenSSL 3 the failed fetch also
pushes EVP_R_UNSUPPORTED ("digital envelope routines::unsupported,
Algorithm (none : 0)") onto the thread's error queue, and nothing pops
it.

"none" is what every server without --cipher carries in its
pre-negotiation key_type: the legacy BF-CBC default is not in
--data-ciphers, so do_init_crypto_tls() initialises the key_type with
cipher "none". Each new client instance walks it in init_instance() ->
do_init_crypto_tls() -> cipher_kt_mode_ofb_cfb("none") and in the frame
and OCC calculations, and tls_ctx_reload_crl() runs right after. Its
EOF test reads ERR_peek_error(), the OLDEST queued entry, so on the
first handshake after the CRL file changed it finds the stale
"unsupported" error and logs "CRL: cannot read CRL from file" for a CRL
it loaded fine (GitHub #1103). Traced with gdb on 2.7.0 and master
against OpenSSL 3.5.5.

Return NULL for "none" before touching OpenSSL, as cipher_kt_name()
already does. Real cipher names behave as before, and
cipher_valid_reason() still finds the OpenSSL reason on the queue when
it reports an unknown cipher. md_get() gets the same guard: no caller
passes "none" today (md_kt_name(), md_kt_size() and md_defined() check
first), but it has the same shape and would leave the same entry.

Left alone on purpose: cipher_kt_block_size()'s probe for the CBC
sibling of an AEAD cipher (CHACHA20-POLY1305 -> "CHACHA20-CBC") and
md_valid() leave the same kind of entry, but neither runs between
client instance creation and the CRL reload. The next commit makes that
reload robust against any leftover and reports one when it sees it.

With this change the queue is empty at multi_create_instance() and at
backend_tls_ctx_reload_crl() entry for UDP, TCP and CHACHA20-POLY1305
clients; CRL replacements give clean reloads (unpatched: a warning
every time).

Signed-off-by: Drew Blokzyl <drew@linuxkids.com>
---
 src/openvpn/crypto_openssl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 29c5fa68..b44d0797 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -568,6 +568,15 @@ cipher_get(const char *ciphername)
 {
     ASSERT(ciphername);
 
+    /* "none" is a valid OpenVPN cipher name that OpenSSL does not know.
+     * Return NULL without asking OpenSSL: a failed EVP_CIPHER_fetch() would
+     * leave an "unsupported" entry on the error queue that the cipher_kt_*()
+     * callers never clear. */
+    if (strcmp("none", ciphername) == 0)
+    {
+        return NULL;
+    }
+
     ciphername = translate_cipher_name_from_openvpn(ciphername);
     return EVP_CIPHER_fetch(NULL, ciphername, NULL);
 }
@@ -981,6 +990,14 @@ md_get(const char *digest)
 {
     evp_md_type *md = NULL;
     ASSERT(digest);
+
+    /* "none" is a valid OpenVPN digest name that OpenSSL does not know.
+     * Return NULL without asking OpenSSL, see cipher_get(). */
+    if (strcmp("none", digest) == 0)
+    {
+        return NULL;
+    }
+
     md = EVP_MD_fetch(NULL, digest, NULL);
     if (!md)
     {
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
