Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC7606BA34
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nMlXhAGV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cFGtY7qH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FAQod8hJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XRUfg1JW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nD4F3tkWjcC77Ot5k3MQOiOvGRHXaJh+WBaXz/0GryY=; b=nMlXhAGVU6n3VZuWLHOWY8Kg7+
	s0lF62eWTpKf2CZGq4G2mQkoljtMJ3tZJiqZMl53Eeu7ajVXIJr0H+vCqYDiWx9xCduTF4wL/4aqg
	uxFaeegCexVj8sjLjND31EuEw2BRTDbD2IAgChIhPEV6iZ4m7wdVa4zvKDvcnn4LcPD8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOG9l-000000005QH-13mo;
	Tue, 03 Nov 2026 15:10:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOG9k-000000005QA-17mf
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5F+zAu80M+yhQ0i44Xf3ccgoiOsvcooU7ih3Oaw8MZA=; b=cFGtY7qHcWocnLju7HwT93tsTH
 vuyM9BcNYoqYTWQrODbowN6hNvSdBn99UtOoxuizE84wS9RIixPb9Ok+Q50oh/yvzxu8yGSR+xg8x
 1E6mHs2Sdz3MPd5OczkrzA7BnKsmzcsklP2sSO3e2BgokiTVgt781fCVbKa3aHZQs3hU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5F+zAu80M+yhQ0i44Xf3ccgoiOsvcooU7ih3Oaw8MZA=; b=FAQod8hJMzfIu+sjbybu6MtKRT
 zvVWb2gbBQsFzJyDwXBATKd9RnXREQ3AEsaTcKEHtT1Qo+/n/TtkW9LL5foVIOCE9I54A1z1OQYz2
 /4z1Xjn1tPZtwPTDq2+gGFLrgd1bkv5HcxrPJzbpwoUh+I8/Iu6lVs6pWlrWBMIuCy2s=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOG9h-000000005r2-1xWj for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:10:36 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so27418135e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 07:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793718627; x=1794323427; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5F+zAu80M+yhQ0i44Xf3ccgoiOsvcooU7ih3Oaw8MZA=;
 b=XRUfg1JWR3iVp1n6nmOr3te5fb1ed39mhbxZBvffvooenTfFyRdzyPotvhcO5dgChe
 ZCbprBiYAwxNh5E/oB47hKFYNze0y/8zj2gCUgTmWB1SKyBNTxVYgtYaFbmaj4QJ82gV
 giT4Lwmb+xaQgV4REXyhQqhdhg0/HA7akWJr9JQHht1N9krWUbToS6UwH81PbdcrJ7NF
 iP4ER0qWeuKxsEKD7nkukjflS37cUp4EuXgnjLsjbqHPn0DDq4REPQ25cLgggC2anUy3
 JEe0rHi6DSAOj5EfrQTYdcwKhKshZaGzEbU283lg6ZMkBQOCk/bJat/RjJKSonrjnMsB
 aYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793718627; x=1794323427;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5F+zAu80M+yhQ0i44Xf3ccgoiOsvcooU7ih3Oaw8MZA=;
 b=IKuAA7maStgbOKNSuvtqD86Fb/NVMEOrHw4WosAN1wgJttqcDhVx9EtMza2V/GCsQv
 yp8zqCrz649HU+sAQaip02CGQU5UPlJk47S+Rc3P8218K2uHT0t+wEXxuaFmccoz2ZdK
 HrN0foleBGcgIkJSiDoq6WUKYQ/G8YieK0c/3rhOYUckSaWv1KVG9m+2q8cwdXhqGKCr
 FEFnEO6ciyiGBsCoi+3J6pTp+MRPhys30guNt9Or3eyCh521cSWA6KSwsyb14vwBvm+1
 HdXTGfq4r0yYPfILwF2S884CS29tNS9a5v/CnMDh5ntyDswfKWWq/atYXHMdN6HB3fUZ
 jwwQ==
X-Gm-Message-State: APuU4Z/xzJ9whH4J7f7DP0rz9M4KZ1XGP+gsSVB5RV0Altco7sIkyrSv
 EAMvXcmUIdppEbpSRjpXoaLqLjKCHA+K5moXkPNy/OR5Pldasj2kvXPWb2gbrGQkOrRuNIg+CaK
 ZQikhk5X2KpHPBIaf9iF0/mgqP5f2CDV31s9TQonLy8hwFQ7SuStWioPakOl8bmazn4LSaReCgj
 HKwuHK7g==
X-Gm-Gg: AYBFou0k94rgXCTPkZKBhs4fi/J3o6Hfhzugyb23Ms0sYuOwzA014vuw972iJiNC3aR
 xF4t+5AUqziAEN4BJYOWIDAlMNWJrPtINWmfN+28t6F2QG6okFMHkD0yTRfp3UTO4wmeDlZv2jz
 zgFmsuQ1o9GMEeK0dZUNGltdle9kK5QXM0kEEzU5NBvQ1229UOM7miRonnOo/bGqBtO/r2l6ZDO
 u8TzU9jJzZ+o8am+n41uiuDzoqhErAJZa5P+vdmn5oMjwMcMAQRU2LUord8woXrKVhUQXPWz1cl
 D6DUPwJCS8Nkiieu6VmY8VbjNbNWYLaFpB/HMzR6FT64/VM68tAExkRW+Otpxodl5dhKBECflAt
 X111RPszMLJwWfav4xZZLNVFM/HJfSdQ2EUsP2m8mxDfwXzgl52Z53CScC2qzeF14ljlMicG/W4
 syYn3ZXzkKZR0rKwz/37as8K6lJL5qZ1bpWND+X3ZjQZXSwzfPlSyepRQO+Ej73IfR+UEmLdukb
 iLkCKEAIno4l/OaFdgC02l+P9X1/a21YntZ7hABI3Xj5XntiOaCN+uNkv1lLmu5M7DrT2EhORH7
 t3aOVSPEyTl5Rge1o9vd5QZ1Y9LPsbdF+2SREReV+Ic3Z7NO8pY+TVyc0YANZEkrTNb+G0Jl4hy
 EktG/383RarTLndD9q5mcU30FlQAYVH9QS7jlneDBheBZgR2gdyCKFdkDPziI/ij5MEsVsQXIPT
 V8yPuizDGSO2RjOIHUUW0Bq6jGvnBuOZxxKZo=
X-Received: by 2002:a05:600c:470d:b0:4a2:191f:7cb8 with SMTP id
 5b1f17b1804b1-4ac1899378bmr295698085e9.17.1793718626700; 
 Tue, 03 Nov 2026 07:10:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a98e8f9fsm70744315e9.13.2026.11.03.07.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:10:25 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 15:10:23 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
X-Gerrit-Change-Number: 1950
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1950?usp=email>
X-Gerrit-Commit: 0a02cbf3958351561dd611c2db807ec9b16215bc
In-Reply-To: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
References: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzI5ODkxMDAwLkk0NDBjNGM3Mzg2NWZkYmQ4MGYyYzYwN2U4M2M1MGUzNDVhMGUyNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <097a3fab6bb85f0885cf5bca397305307f079b6a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOG9h-000000005r2-1xWj
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not look up the
 "none" cipher in OpenSSL
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0784851553371203276=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0784851553371203276==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="W11Fh7ull7Q="; charset=UTF-8

--W11Fh7ull7Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello R=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Pleas=
e visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail

t=
o look at the new patch set (#3)=2E

The following approvals got outdated a=
nd were removed:
Code-Review-1 by R=C4=83zvan Cojocaru


Change subject: Do=
 not look up the "none" cipher in OpenSSL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Do not look up the "none" cipher in OpenSSL

c=
ipher_get() hands EVP_CIPHER_fetch() whatever name it is given, and the
cal=
lers that only ask whether a cipher exists or which mode it has
(cipher_kt_=
mode_cbc/ofb_cfb/aead(), cipher_kt_block_size(),
cipher_kt_insecure()) trea=
t NULL as "not that"=2E For the "none" cipher
that is the expected answer, =
but under OpenSSL 3 the failed fetch also
pushes EVP_R_UNSUPPORTED ("digita=
l envelope routines::unsupported,
Algorithm (none : 0)") onto the thread's =
error queue, and nothing pops
it=2E

"none" is what every server without --=
cipher carries in its
pre-negotiation key_type: the legacy BF-CBC default i=
s not in
--data-ciphers, so do_init_crypto_tls() initialises the key_type w=
ith
cipher "none"=2E Each new client instance walks it in init_instance() -=
>
do_init_crypto_tls() -> cipher_kt_mode_ofb_cfb("none") and in the frame
a=
nd OCC calculations, and tls_ctx_reload_crl() runs right after=2E Before
co=
mmit 15a1465f ("Make CRL reload EOF detection independent of stale
error qu=
eue entries") that stale entry made the first handshake after a
CRL change =
log "CRL: cannot read CRL from file" for a CRL it loaded fine
(GitHub #1103=
); since then the reload reports it at D_LOW as "CRL:
OpenSSL error queue n=
ot empty on CRL load" and clears it=2E

Return NULL for "none" before touch=
ing OpenSSL, as cipher_kt_name()
already does=2E Real cipher names behave a=
s before, and
cipher_valid_reason() still finds the OpenSSL reason on the q=
ueue when
it reports an unknown cipher=2E

Left alone on purpose: cipher_kt=
_block_size()'s probe for the CBC
sibling of an AEAD cipher (CHACHA20-POLY1=
305 -> "CHACHA20-CBC") and
md_valid() leave the same kind of entry, but nei=
ther runs between
client instance creation and the CRL reload=2E

With this=
 change the queue is empty when the CRL reload runs for UDP
and TCP clients=
, and CRL replacements give clean reloads with no
"error queue not empty" r=
eport (current master: one per replacement)=2E

Change-Id: I440c4c73865fdbd=
80f2c607e83c50e345a0e2438
Signed-off-by: Drew Blokzyl <drew@linuxkids=2Ecom=
>
---
M src/openvpn/crypto_openssl=2Ec
1 file changed, 9 insertions(+), 0 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/50/1950/3

diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/=
crypto_openssl=2Ec
index 3c708c2=2E=2Eb7f2ef3 100644
--- a/src/openvpn/cryp=
to_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -569,6 +569,15 @@
 {=

     ASSERT(ciphername);
 
+    /* "none" is a valid OpenVPN cipher name t=
hat OpenSSL does not know=2E
+     * Return NULL without asking OpenSSL: a =
failed EVP_CIPHER_fetch() would
+     * leave an "unsupported" entry on the=
 error queue that the cipher_kt_*()
+     * callers never clear=2E */
+    =
if (strcmp("none", ciphername) =3D=3D 0)
+    {
+        return NULL;
+    =
}
+
     ciphername =3D translate_cipher_name_from_openvpn(ciphername);
   =
  return EVP_CIPHER_fetch(NULL, ciphername, NULL);
 }

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0=
e2438
Gerrit-Change-Number: 1950
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--W11Fh7ull7Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Arne Sc=
hwabe <strong>uploaded patch set #3</strong> to this change=2E</p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">Do not look up the &quot;no=
ne&quot; cipher in OpenSSL<br><br>cipher_get() hands EVP_CIPHER_fetch() wha=
tever name it is given, and the<br>callers that only ask whether a cipher e=
xists or which mode it has<br>(cipher_kt_mode_cbc/ofb_cfb/aead(), cipher_kt=
_block_size(),<br>cipher_kt_insecure()) treat NULL as &quot;not that&quot;=
=2E For the &quot;none&quot; cipher<br>that is the expected answer, but und=
er OpenSSL 3 the failed fetch also<br>pushes EVP_R_UNSUPPORTED (&quot;digit=
al envelope routines::unsupported,<br>Algorithm (none : 0)&quot;) onto the =
thread&#39;s error queue, and nothing pops<br>it=2E<br><br>&quot;none&quot;=
 is what every server without --cipher carries in its<br>pre-negotiation ke=
y_type: the legacy BF-CBC default is not in<br>--data-ciphers, so do_init_c=
rypto_tls() initialises the key_type with<br>cipher &quot;none&quot;=2E Eac=
h new client instance walks it in init_instance() -&gt;<br>do_init_crypto_t=
ls() -&gt; cipher_kt_mode_ofb_cfb(&quot;none&quot;) and in the frame<br>and=
 OCC calculations, and tls_ctx_reload_crl() runs right after=2E Before<br>c=
ommit 15a1465f (&quot;Make CRL reload EOF detection independent of stale<br=
>error queue entries&quot;) that stale entry made the first handshake after=
 a<br>CRL change log &quot;CRL: cannot read CRL from file&quot; for a CRL i=
t loaded fine<br>(GitHub #1103); since then the reload reports it at D_LOW =
as &quot;CRL:<br>OpenSSL error queue not empty on CRL load&quot; and clears=
 it=2E<br><br>Return NULL for &quot;none&quot; before touching OpenSSL, as =
cipher_kt_name()<br>already does=2E Real cipher names behave as before, and=
<br>cipher_valid_reason() still finds the OpenSSL reason on the queue when<=
br>it reports an unknown cipher=2E<br><br>Left alone on purpose: cipher_kt_=
block_size()&#39;s probe for the CBC<br>sibling of an AEAD cipher (CHACHA20=
-POLY1305 -&gt; &quot;CHACHA20-CBC&quot;) and<br>md_valid() leave the same =
kind of entry, but neither runs between<br>client instance creation and the=
 CRL reload=2E<br><br>With this change the queue is empty when the CRL relo=
ad runs for UDP<br>and TCP clients, and CRL replacements give clean reloads=
 with no<br>&quot;error queue not empty&quot; report (current master: one p=
er replacement)=2E<br><br>Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2=
438<br>Signed-off-by: Drew Blokzyl &lt;drew@linuxkids=2Ecom&gt;<br>---<br>M=
 src/openvpn/crypto_openssl=2Ec<br>1 file changed, 9 insertions(+), 0 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/50/1950/3</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_=
openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>index 3c708c2=
=2E=2Eb7f2ef3 100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</=
span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -569=
,6 +569,15 @@</span><br><span> {</span><br><span>     ASSERT(ciphername);</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* &quot;none&quot; is a valid OpenVPN cipher name that OpenSSL does not k=
now=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Return=
 NULL without asking OpenSSL: a failed EVP_CIPHER_fetch() would</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * leave an &quot;unsupport=
ed&quot; entry on the error queue that the cipher_kt_*()</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * callers never clear=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(&quot;none=
&quot;, ciphername) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
     ciphername =3D translate_cipher_name_from_openvpn(ciphername);</span><=
br><span>     return EVP_CIPHER_fetch(NULL, ciphername, NULL);</span><br><s=
pan> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1950?usp=3Demail">change 1950</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I440c4c73865fdbd80f2c60=
7e83c50e345a0e2438 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1950 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></ht=
ml>
--W11Fh7ull7Q=--


--===============0784851553371203276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0784851553371203276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0784851553371203276==--

