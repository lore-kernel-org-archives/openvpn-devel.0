Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E71CCA5FA5
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ubwv8sQCBtUxlVe6TEIWvSv/wo6vepSkvl6b2/OQGGw=; b=BrQT+sRmKANTVghK1RBpUTak3g
	CJb8V4lhEkjEKUrn7H9V2R2nl2asgO09SrKyz8+TGzuxYNgYWZcfe6DA1mL3hG6C5lgUBOBY2Yfew
	M79EsaKim46Qt1i5xnpT4VNjKCsjokXCs/yEoOPUr7WbWZBdEq4T3PKMdHw8dcmiC2R0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBCcF-00045H-Qp;
	Mon, 28 Sep 2026 14:46:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <drew@linuxkids.com>) id 1xBCcE-00045A-Py
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:46:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dszHu+a80WD1wZlGP3DaK3girbMHUPD0OAOLqbjzBSs=; b=BfqxoDsy/pT0ZmXJrnONXvxsT5
 MnJKmq26H2+i5eCDT7Q+YwyKeVY8O/iINtHvmjLefQZI4zgt6CR8DUU++OKutbChNvb616qmSFoD+
 m+/tcB77bHEmRypH9vG6Mht2OduaynJfm6qS+DLarkVWAwBZJdhUUev2m5WKvryI429Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dszHu+a80WD1wZlGP3DaK3girbMHUPD0OAOLqbjzBSs=; b=A3C6YBmDb+tY+WEfL9hMXqrmFD
 YfE2YRSSCb+1eoOYqtLZIzi6IIXznq2Ypwhh2HUvlLladjJfhIPukzy3uAWc8rLTnI38TQESY9fMN
 gwfG1B/iP4w8lm5nbJEyry5BCMi86uMYKKfghLgQzSw9UdxOA+muY13CX//PgXJA87TU=;
Received: from mail-oo2-f38.google.com ([74.125.231.166])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBCcE-00079o-Q4 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:46:03 +0000
Received: by mail-oo2-f38.google.com with SMTP id
 46e09a7af769-81bea216172so813397a34.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxkids-com.20251104.gappssmtp.com; s=20251104; t=1790606757; x=1791211557;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dszHu+a80WD1wZlGP3DaK3girbMHUPD0OAOLqbjzBSs=;
 b=Aa35q63lKQqKi3G0UO//hHDjZPqGLag3OQpWwc8M0/uXQFaKbLvfOGWivJvnWtryEz
 uUikaNVTsl6ub7dOpMcaBb6On4NX48DxZS+bdWCG/P95IqKEyco4KiMY8tEsZxXUeM6n
 jIw6v2r23kPg453a+KI1MavoEJYBnvD7lHX9qzIr1wXffzrsszLx8Y196+jPOHKGqmcp
 dMOgOoIbmVBELaLlOPxaakDg2qhLgaF2sWclgLGtEuU2/nZARC3RjftnLiKX837n/cQ3
 HwQEdkyDirf57eKtVZepkE9Zss/Q2udYlExGuZ2jr8qkE4CAhxE9DIqN1Ta5rzyapGDC
 Ou8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790606757; x=1791211557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dszHu+a80WD1wZlGP3DaK3girbMHUPD0OAOLqbjzBSs=;
 b=WL1U/AQVdoM2hS0/46zm+TlTnDmMX3NOFGOy4jjmJ/BD/0nvaxx4eol7HqayB1pIoI
 fm1ozTgj+GCVV8QznrLb28JIaSTvn4vpePd80EDRdwprRJ5Yp/PuzjnK+wE+UxB8E6tw
 t3qmDWbz7Jz9hVdud5ox2mcA4CojAesavgi9ZrqfDEkrgH+bWDwVkyYwa0sSKZQOT2tX
 jGto3lbUrhzyqSNT30Ta6oXptIoTdUWKgcYWqIMuAtL33HyI8VrmC8mumjEcIY6FIQIi
 xMqomWccB/nG9ZzirB947nbIzndR8Iez7lx3trEJKJ/LTIa/SCGxrgMmcK37xH1MkTz9
 +twQ==
X-Gm-Message-State: AFuF++nrCfxFx1sBsDsitNrl/hLoN9uXP9HodLI4BD18D9bFdL5G6BOw
 +SnKBF+8aJZgBtcmMSUZZ5wvBS/p2b9bgK3soObqFODdvFxHn3xsNvHTf2rriV8bvMlZSHTwcJT
 QAPI/uheJ
X-Gm-Gg: AYBFou2OIzRQXiEd3INy2bxy/CWNBecun9/QMcnoOtkxqMD0eBM/vymaOwpAVEQha+K
 eFSDKPCwDOXT9OTdxV+TeiBtHtyBMd75Jdz2OYNL7VLDTau7261apjML+N+o8MlU05VmUJKvGyK
 g3QZGPpRtwdU5cgXkbfg1bP+usRyTkEt3l4UDaxuHaJT9sWlaox8rRHPiHioquX7pN6fW5237RC
 TG5TvLV2xVyfa5jbFlVRlDw3ECcCEIr1KwfkgHdhO3RlVwpgxfmIrDMnauQZlFdqaYin9p74lSH
 BfJTPnIVMV1jK7IeYkwWUF59ZlilIKPKd+eYamvak2j0/d+xVjdTQ2i+31epb8GvSSHiDbnD9W3
 3x/afikDWsDDUWYJ6nlC8XMYjsbsly8DJbAylyjwI+eCrswo+UyT82LmYNBBJAB2tyZNg64AmdN
 nU+zIUa0DqVlprPITg6yayK0n3GzathpYP1DYLYTkrDp52Y3qjwDX9bp+T/5wd9tXPQKFNmgF29
 GcFxVx2VrAxOR6ozha6AHX7J+WtzdvzWiu/3A+k8PysQ2sb9U9HIubxR9UCXKw=
X-Received: by 2002:a05:690c:a6db:b0:8a8:6c5f:5b32 with SMTP id
 00721157ae682-8a86c5f6ee6mr25425217b3.52.1790606254436; 
 Mon, 28 Sep 2026 07:37:34 -0700 (PDT)
Received: from MN-277C755CCA3B.localdomain (71-208-239-209.ftmy.qwest.net.
 [71.208.239.209]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860e5e9besm45668487b3.11.2026.09.28.07.37.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 07:37:33 -0700 (PDT)
From: Drew Blokzyl <drew@linuxkids.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 28 Sep 2026 10:37:29 -0400
Message-ID: <20260928143730.47047-2-drew@linuxkids.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260928143730.47047-1-drew@linuxkids.com>
References: <20260922140520.71500-1-drew@linuxkids.com>
 <20260928143730.47047-1-drew@linuxkids.com>
MIME-Version: 1.0
X-Headers-End: 1xBCcE-00079o-Q4
Subject: [Openvpn-devel] [PATCH v2 1/2] Do not look up the "none" cipher in
 OpenSSL
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
it reports an unknown cipher.

Left alone on purpose: cipher_kt_block_size()'s probe for the CBC
sibling of an AEAD cipher (CHACHA20-POLY1305 -> "CHACHA20-CBC") and
md_valid() leave the same kind of entry, but neither runs between
client instance creation and the CRL reload. The next commit makes that
reload robust against any leftover.

With this change the queue is empty at multi_create_instance() and at
backend_tls_ctx_reload_crl() entry for UDP, TCP and CHACHA20-POLY1305
clients; three CRL replacements give three clean reloads (unpatched:
three warnings).

Signed-off-by: Drew Blokzyl <drew@linuxkids.com>
---
 src/openvpn/crypto_openssl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 29c5fa68..367a68a9 100644
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
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
