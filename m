Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB021606A31D
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NspvwOMD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=b3j+R/Be;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W3mtIJkW;
	dkim=neutral header.d=linuxkids-com.20260707.gappssmtp.com header.i=@linuxkids-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jmFIQXPF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bRzQ9HnRPDdVVcRR2SLuLcdfYLBY2F3OhBS2i6AEz0I=; b=NspvwOMDxSnsJ7
	zqOp6TurnUKmwO7x7ohv/wFVHT3NEGLvc2/aSdUcab1SzIjm4WJ3w5CP8u/0s3vecI9RarjsyQKh0
	g+F09Q3Nz13iwMN8hBjKglLYltqlSltntXxWYKmVZXmA3ImMOykwnadx9JhoAys2j1Hea+G4ITY9p
	FzI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMVWm-000000004eO-2wdR;
	Thu, 29 Oct 2026 19:11:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <drew@linuxkids.com>) id 1xMVWc-000000004e4-43if
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 19:10:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PKLYw0g4T+emSSDfUI64EWCYmKuxWx9uwK+9SujcXq8=; b=b3j+R/Be6mY1mNVF/j4PFaG4Sd
 15umgWlmf8OPYY1VZHsJSfnMShiGNCpULT3d3gfr7PZghKfVSqS75T36gdEg+GzJtPblF35I3E6Zg
 YFNN+nMqfF/HT1G56u8oohvdEAbiM7YSEYbj4U0I0syLKohbC/kd8X7q5/OwD1wFN7qo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PKLYw0g4T+emSSDfUI64EWCYmKuxWx9uwK+9SujcXq8=; b=W3mtIJkWmm/hEzIAX5ZOlohK9t
 NRb/GCUD+joWYi6vcK6aoonYAkdGAAQapzRpv5xdUqaiNFtB+dt4XjE/9K8IAxb5afbHjY32/hUBh
 e5MBx218qwdZ0JFNTZlsmL6BrkhqwKbqXjeg4DMD3SQ1Ncwp8axlmhlavSCj3SdvxyNQ=;
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMVWa-000000001F1-1D9b for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 19:10:58 +0000
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8a064fac8cbso1882106b3a.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxkids-com.20260707.gappssmtp.com; s=20260707; t=1793301050; x=1793905850;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PKLYw0g4T+emSSDfUI64EWCYmKuxWx9uwK+9SujcXq8=;
 b=jmFIQXPFZ1nMEA4s4c74kMWdl1ebXa9pDgYw1aJkdALNYUpQWFH2vNq1CNhIqRei2Z
 PjC7GK77J+B5xqb6T114hhFZ3SMPoulWHB0yXb2sdLJcGpJXwKsZXyD4pq8hwoff38pJ
 rXAWw9CX9Fkr29pbZHSpEk4fZcAd0HZ7tfUaAeMNr0BdMveJ1pAl/sB7ERDmBeIEsFPL
 GnK5vsgDIcdrH+pM8QUBTvacLY3zoOmSqoObAaSzFGrifIbuCggVFLXqXtPqZh5h9csk
 xwPI3OHyhHi/kLVKSMLPnk0NOme6lAOhwA07YEQ/kVonPJ0VVcfQ25asyPgfoNPh3dwu
 udTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793301050; x=1793905850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PKLYw0g4T+emSSDfUI64EWCYmKuxWx9uwK+9SujcXq8=;
 b=XXl65Bekrt5mEehlyWtA2kj+f+dUinHltbb6Cx/aOR3dRE9RBzNNC+T2glad/jo0tO
 jEAuEaCaBvTqFDKNvdBlnde9GM0nyg5us+uY+vGcYAou7G+CSpdw4u6EebWnDV9DmKkt
 Z5y7+8eWMdp4FiT2HJTZgFWfJ9KEISEUNWwdGqsIk+5MU10Z/3H7UucnuSPb6dahqnze
 7bpcq7PQhFgqT9GdjqqA+j6cU8tERrnKw14AtqPo7pg4NDNLGz1YkuMd6RWcG3C2R+8p
 +UMS/fI/qgtsxR1LixvjUMLAaKwA53aiTESggk7ehl1OHaXA3/yunzEpy2Di44qpLACV
 yQ0Q==
X-Gm-Message-State: AFq9FYIarsn9Lx22LrnwSaI/XoT5v0JpDNOTHBPi8MWOzGxiQ5GsDdXD
 C8PDM7Lx1Lb9/sKVKXRChhCdkcG5jyQ0QXCDLxudaCTWH37prAqGMxlVVdwOxEaQ0dyBxGv2DwD
 Zg9oyjqpc
X-Gm-Gg: AYBFou2+dRq5M17wzyT8rTf36lW0XR5Ch7WEhKipa0Ojmip5hkXg6NPOzhj/q7r2v8+
 XqhKG6I0YXvJ8MN8aBMtmkH7Ynx32tU29AuA2qCRbTtYCGkaXGHaLzzzny+xUt4pzRywgHIxGg5
 tIuwB2iYQIZ8tH0ZgCBnH2fUxxQtjBggdV63nN+gHzwAMQ24PjZ/s3mn5bPe2/j4eGpVOB/x5sz
 eAf2B11rsdEOjzSxJRAcvAE3CwFeRtkSfeWBCmyIaFX6s08rU4qhr8ndX/Zns1W6TD7h3cSQX7P
 rgMv5WQko257HZ5Cdlf3V0hpwlLaxxNxpkMNnutKQ3Nj5+OItOKJMtuImYuLEORUUlFlG6TreNG
 hWLcx10Wts7SOoDnZvhsPU08oWJB6TCld4hlUoECpZvY4Z53N/yCtnJ2RolR82Sn0kA0DILqaa/
 cXnuG516WhM5azOlULp3ajjByguV82AGCy8ZJNslgqSNK4YdLkJkAFFCWZK9Q4HsZb4hKsz/ErM
 cwpV1ViCWvxn3i4V9GHZE2sXF0/Ni5IMvGY21GUl3IAO+LsZ8yzIpi0F4WoVF+rltkBPBRHZHI4
 2TvYVvnKETDG1kxiL48gw7vcaKNgdimUIA0Fo/rGPoCX+IP6k6nTx+Li39aMKW5QRIrJM22ohmK
 v+c5vguHhlYUyU5SLzg==
X-Received: by 2002:a05:690c:d91:b0:8ab:44a4:6362 with SMTP id
 00721157ae682-8b1b5a51650mr41293747b3.4.1793299327520; 
 Thu, 29 Oct 2026 11:42:07 -0700 (PDT)
Received: from MN-277C755CCA3B.localdomain (71-208-239-209.ftmy.qwest.net.
 [71.208.239.209]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b4ad5c17sm315667b3.16.2026.10.29.11.42.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 11:42:07 -0700 (PDT)
From: Drew Blokzyl <drew@linuxkids.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 29 Oct 2026 14:42:05 -0400
Message-ID: <20261029184205.76422-1-drew@linuxkids.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922140520.71500-1-drew@linuxkids.com>
References: <20260922140520.71500-1-drew@linuxkids.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xMVWa-000000001F1-1D9b
Subject: [Openvpn-devel] [PATCH v4] Do not look up the "none" cipher in
 OpenSSL
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
and OCC calculations, and tls_ctx_reload_crl() runs right after. Before
commit 15a1465f ("Make CRL reload EOF detection independent of stale
error queue entries") that stale entry made the first handshake after a
CRL change log "CRL: cannot read CRL from file" for a CRL it loaded fine
(GitHub #1103); since then the reload reports it at D_LOW as "CRL:
OpenSSL error queue not empty on CRL load" and clears it.

Return NULL for "none" before touching OpenSSL, as cipher_kt_name()
already does. Real cipher names behave as before, and
cipher_valid_reason() still finds the OpenSSL reason on the queue when
it reports an unknown cipher.

Left alone on purpose: cipher_kt_block_size()'s probe for the CBC
sibling of an AEAD cipher (CHACHA20-POLY1305 -> "CHACHA20-CBC") and
md_valid() leave the same kind of entry, but neither runs between
client instance creation and the CRL reload.

With this change the queue is empty when the CRL reload runs for UDP
and TCP clients, and CRL replacements give clean reloads with no
"error queue not empty" report (current master: one per replacement).

Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
Signed-off-by: Drew Blokzyl <drew@linuxkids.com>
---
v4: drop the md_get() guard (Razvan, Gerrit 1950 PS2). No caller can
    reach md_get() with "none", so it protected nothing and only changed
    how md_get() reports a failure. Arne asked for it in v3; I agree with
    Razvan that it does not belong here. Subject and commit message
    amended to match. Patch 2/2 of v3 is in master as 15a1465f, so the
    message now refers to it instead of "the next commit".

    Retested on master 54a66f35 + this patch, OpenSSL 3, UDP and TCP
    clients, CRL replaced before each connect: master logs the stale
    "unsupported" entry and "CRL: OpenSSL error queue not empty on CRL
    load" on every reload; with this patch only "CRL: loaded 1 CRLs".
    make check: 23 pass, 0 fail.
 src/openvpn/crypto_openssl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index e6abd8f7..6ba9526b 100644
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
