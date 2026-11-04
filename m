Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EFF606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VULACKtm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W+3WQFVY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aC8dLcrV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=T5SmZtQ/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=t5ECWq5SMZT9rSQGybK3UwkkM2Mlb23e4hDtP+PRciA=; b=VULACKtmxb+qOCkmzEQN4yl7lg
	YT2KraGvjZ5tohtnVNjYbXjMlNBuZQintNkMtSdEVy7RHs/zXb6T49iMej4KLAmDb1rqtqqAMp2s3
	Pzz8SLW1Kb+Juh3Hnqs3RBWBbisTyL+VLOb2/jRAGZPQ7SmHRz1eEt5wI5VE/+pCJE70=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOVuI-000000003GY-2FSr;
	Wed, 04 Nov 2026 07:59:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOVuH-000000003GS-19NS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:59:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k29xhNeq9w8B1nkIjyRahBgMRWpUES6UQYxj0WmrZEQ=; b=W+3WQFVY2oj0d1HBXb/CpSEc2U
 LQvCN7WJi+F3VLN9jzxJStsLw+CLQW0ab9Y/LuhULbUOlt+q/GEfbj+G5LmXaVTwfMF+Oborh843+
 AIi6R1lkmUabTBkmusp1XCzvUhBE5DftCtPARsb4QQ/SVmgfL3GWPbpVXK0Quj7UsBM0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k29xhNeq9w8B1nkIjyRahBgMRWpUES6UQYxj0WmrZEQ=; b=aC8dLcrVWJVihSsTv+56foMe8U
 G/ty+f1kgstLc67KReKMnorRU28zFjXvjs58KrKpheaYZ8oKVZHxFMkN7tmduMRNZPLKiuf++8Lp0
 jtU+apz2P8VobtQKEtJXiFfNroXFxQ+xB7iYlA6dUNdsG1sfcLjjrEiOmTsmfWf3Fh7A=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOVuF-000000000c8-1o4Q for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:59:41 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso104609f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 23:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793779173; x=1794383973; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k29xhNeq9w8B1nkIjyRahBgMRWpUES6UQYxj0WmrZEQ=;
 b=T5SmZtQ/huEqEUIpmSgIv95ro3oVay1fFPaMRIX6S3ZFQE0ak58tHhfax5KFVrdyBG
 roNWQk9Bnbp8VEHPnCZthq/pM8qx3tFBsSiS9MhS6aOH8/hylLmToW13LIuZpBg52Dp8
 +AxdN5y1vRzr6GesYzcgdC12u6d/FmxJPaAD6+N/F2BZCZuiE+PsveuLkxPasg1/4qEd
 wjcNemqctid0Fmc7+p50gXejWyEKvm18GIJwgKBkEr3yc42bjKN2KsAVwjwzAmJT9xWi
 wyvVexzWLjxftlhGH6w+mtWtuviH3ZQgARg3NoZipY1iJmSHIm69ZYyz5I7RtvLBHuJr
 5PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793779173; x=1794383973;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k29xhNeq9w8B1nkIjyRahBgMRWpUES6UQYxj0WmrZEQ=;
 b=QhyhMeKt9w5EQs+3kpO47CDelNhq2PLxpRx9ChrclO5shlKqbKjOOZ5HZdwJsQGjDi
 W3YM0BY0Keex/QMK5DLnsMn/NeyOFP6aUm/I+vDdxh1JZymyMcdi+OtwkBsLomzPL26b
 goW9fubuPzHcHLlP6/sR+IrAy/gHXOlMb/B0mp/Pj2t6TF9TcArFTguBXsMoI9yCorhi
 1qzt1DUm7Ox+d2Mr4UUGfZE06RGm/ud5GrSqOXayNC3ExKa44sWVY1Np3pCmKn48WeEz
 2jEFoe6GcapCfGs3i2PZi4LgGbkJP4orHIZMW4HeAtR8aNSn69l44ffK/HCmgUVbcEy1
 jq7A==
X-Gm-Message-State: APuU4Z/6yoNeF7/RoMdWO4Q4Bd5j/DsvYHxPbhtgrTNv7sgpvTtIcwQD
 DSyNACB62ElWufUj4puaPirijPUtoaq7+H2QXAdrOPXZ6JcuQbZW6gmZurFAqgTStYYwiI2ousn
 BdjFPRUvglDt4n6FwIdslRFBvtEI2eirPNPzRhDIMMYpdl1/vceC1mWGPnfowNgzxBMQxA0FKY8
 FnSc5bFA==
X-Gm-Gg: AYBFou1DqkMFbDlNU3czvUg2N0J31prESKuhohs4FBI7x7dqIpbxvusAdOMliBlE3MX
 MFxCwg/RNHCLorLZuJkcnkNg3ssh4q9ERkhBDiZbkrz4dUjw28EEJw6uUr+c7lqRHr0EKzm7uLx
 ktHi3vrCXyqh4wSai4cDm+YGOHxr+qDWDODTxM+3lg2KEQsuDu2a0o0XVsWA96ALPd3l8CakkcT
 ZXmsout/bmNGQ0+le2CXLbuE1XMWqz7X6J8Lv0X5LM6RLsJn0hqdbY30eFjEj+NkHTfqqWpUhxD
 yEKsKM4pzc3n+292IncpBi2HrBe98xeU8SyiPk/iO23tR7v4CSZWIvuvj7ndozn7QSgfC4KP2Ts
 5QMxSRc2WVwIj5iYot7705GO1aZa92nu6cuKRFw/qF1PGliyxmvbiRltlGZ+PHNFH33meGbUYsP
 dka7FoS0Jn/xdnX0FBYGqrphjcljWh1R4aEYnMtAf/wbia+KYH+Y1X+J6J0PUI6RyQsljYE3vuC
 ZFKuxjzh0wFMjUmEAbVgVhyojXF63m3mdtscIGKWu3MEuQohUTj/e7kou/uuMsMPyp2xGKnANK/
 5582D0aVEUi7RHF7XYOxv4wXIZ+ukcNIp966vcicNxjS5UXJp6wqF4dnpRHuT1sK//QSOtleguT
 z/9/ykSTlvURR5F9cCRRe3xF9oTBnKYbam5YW98q0dvXvD6iL4qaNVqwakvna5ZyPWdvj5Rns+w
 8JfbvMX9Pdwwa/brpUx0p8/GalhvPBeYCO9Is=
X-Received: by 2002:a05:6000:4711:b0:48b:123e:2f5c with SMTP id
 ffacd0b85a97d-48e6e5018cfmr34807344f8f.29.1793779172672; 
 Tue, 03 Nov 2026 23:59:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea180e7csm2415806f8f.5.2026.11.03.23.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:59:32 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 07:59:31 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I23c6480967d4785beada3879667d50d60d7d8df4
X-Gerrit-Change-Number: 2122
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2122?usp=email>
X-Gerrit-Commit: 71e9f3278cd0b16c9e4862ce99087eeefa2a051f
References: <gerrit.1793779170000.I23c6480967d4785beada3879667d50d60d7d8df4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5MTcwMDAwLkkyM2M2NDgwOTY3ZDQ3ODViZWFkYTM4Nzk2NjdkNTBkNjBkN2Q4ZGY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38b4ee6447f489229b3d3795243fb00cd6201d75-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOVuF-000000000c8-1o4Q
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_mbedtls: remove
 empty tls_ctx_personalise_random()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1846986428776295642=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1846986428776295642==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L8hcOZ8gtEE="; charset=UTF-8

--L8hcOZ8gtEE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2122?usp=3Demail

to review the following change=2E
=


Change subject: ssl_mbedtls: remove empty tls_ctx_personalise_random()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_mbedtls: =
remove empty tls_ctx_personalise_random()

Mbed TLS 4 has no application-ow=
ned CTR_DRBG to personalise, so
494fb718 ("Add support for Mbed TLS 4") lim=
ited the function body to
older versions, and 77a04d48 ("Remove Mbed TLS 3 =
compatibility")
removed that body but kept the empty function and its call=
=2E

Change-Id: I23c6480967d4785beada3879667d50d60d7d8df4
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/ssl=2Ec
M src/openv=
pn/ssl_backend=2Eh
M src/openvpn/ssl_mbedtls=2Ec
3 files changed, 0 inserti=
ons(+), 24 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/22/2122/1

diff --git a/src/openvpn/ssl=2Ec b/src/openvp=
n/ssl=2Ec
index 12b6119=2E=2Eb701c0a 100644
--- a/src/openvpn/ssl=2Ec
+++ b=
/src/openvpn/ssl=2Ec
@@ -672,11 +672,6 @@
         tls_ctx_load_ecdh_params=
(new_ctx, options->ecdh_curve);
     }
 
-#ifdef ENABLE_CRYPTO_MBEDTLS
-   =
 /* Personalise the random by mixing in the certificate */
-    tls_ctx_per=
sonalise_random(new_ctx);
-#endif
-
     tls_clear_error();
     return new=
_ctx;
 
diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=
=2Eh
index 2150d81=2E=2Eb4604ea 100644
--- a/src/openvpn/ssl_backend=2Eh
++=
+ b/src/openvpn/ssl_backend=2Eh
@@ -327,17 +327,6 @@
 void tls_ctx_load_ext=
ra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
          =
                     bool extra_certs_file_inline);
 
-#ifdef ENABLE_CRYPTO=
_MBEDTLS
-/**
- * Add a personalisation string to the mbed TLS RNG, based o=
n the certificate
- * loaded into the given context=2E
- *
- * @param ctx  =
                 TLS context to use
- */
-void tls_ctx_personalise_random(s=
truct tls_root_ctx *ctx);
-
-#endif
-
 /* *********************************=
*****
  *
  * Key-state specific functions
diff --git a/src/openvpn/ssl_mbe=
dtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 8aaca96=2E=2E45d7715 100644
--=
- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -767,1=
4 +767,6 @@
     msg(my_loglevel, "mbed TLS msg (%s:%d): %s", file, line, s=
tr);
 }
 
-/*
- * Further personalise the RNG using a hash of the public ke=
y
- */
-void
-tls_ctx_personalise_random(struct tls_root_ctx *ctx)
-{
-}
-
=
 int
 tls_version_max(void)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2122?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I23c6480967d4785beada3879667d50d60d7d8df4
Gerrit-Change-Numbe=
r: 2122
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--L8hcOZ8gtEE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2122?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl_mbedtls: remove empty tls_ctx_personalise_random()<=
br><br>Mbed TLS 4 has no application-owned CTR_DRBG to personalise, so<br>4=
94fb718 (&quot;Add support for Mbed TLS 4&quot;) limited the function body =
to<br>older versions, and 77a04d48 (&quot;Remove Mbed TLS 3 compatibility&q=
uot;)<br>removed that body but kept the empty function and its call=2E<br><=
br>Change-Id: I23c6480967d4785beada3879667d50d60d7d8df4<br>Signed-off-by: R=
azvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/ssl=2E=
c<br>M src/openvpn/ssl_backend=2Eh<br>M src/openvpn/ssl_mbedtls=2Ec<br>3 fi=
les changed, 0 insertions(+), 24 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/22/2122/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><spa=
n>index 12b6119=2E=2Eb701c0a 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -672,11 +=
672,6 @@</span><br><span>         tls_ctx_load_ecdh_params(new_ctx, options=
-&gt;ecdh_curve);</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTO_MBEDTLS</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* Personalise the random b=
y mixing in the certificate */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    tls_ctx_personalise_random(new_ctx);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span>     tls_clear_error();</span><br><span>     =
return new_ctx;</span><br><span> </span><br><span>diff --git a/src/openvpn/=
ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh</span><br><span>index 2150d81=
=2E=2Eb4604ea 100644</span><br><span>--- a/src/openvpn/ssl_backend=2Eh</spa=
n><br><span>+++ b/src/openvpn/ssl_backend=2Eh</span><br><span>@@ -327,17 +3=
27,6 @@</span><br><span> void tls_ctx_load_extra_certs(struct tls_root_ctx =
*ctx, const char *extra_certs_file,</span><br><span>                       =
        bool extra_certs_file_inline);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTO_MBEDTLS</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Add a personalisation string to the mbed TLS RNG=
, based on the certificate</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * loaded into the given context=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param ctx                   TLS context to use</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void tls_ctx_personalise_random(struct tls_root_ctx *ctx);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> /* **************************************</sp=
an><br><span>  *</span><br><span>  * Key-state specific functions</span><br=
><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>index 8aaca96=2E=2E45d7715 100644</span><br><span>--- =
a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>@@ -767,14 +767,6 @@</span><br><span>     msg(my_logle=
vel, &quot;mbed TLS msg (%s:%d): %s&quot;, file, line, str);</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Further persona=
lise the RNG using a hash of the public key</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_perso=
nalise_random(struct tls_root_ctx *ctx)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int<=
/span><br><span> tls_version_max(void)</span><br><span> {</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2122=
?usp=3Demail">change 2122</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2122?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchang=
e </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I23c6480967d4785beada3879667d50d60d7d8df4 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2122 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--L8hcOZ8gtEE=--


--===============1846986428776295642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1846986428776295642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1846986428776295642==--

