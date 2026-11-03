Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C850606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jt5UWo5i;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z1+FNIAn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Hwaq3VW/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KVo/u/Qi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=y65kPSx2RkBBbr5MX1WbUr8lE0ixk6sMC6LHHu2/IGw=; b=jt5UWo5iiflf3Fx+kmI3jPH6jQ
	ezF/d3gjJ2G1Gx1NA9rBeQVlyyNOg16qVclbiLRdYJ/WZQHTB5ahaxMhawOs7w3nOtQCBJLcOlEW4
	OMsntz0T1DgQlSPSrCykA3Sv669HpJAqbumBhPGJbpbwGgTnHmCrP+nygNHRNNz0AQQs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKLV-000000004oM-3rhy;
	Tue, 03 Nov 2026 19:39:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOKLV-000000004o0-0IY1
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:39:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w83aYKok5uLYx2N6itw79nxWy3Y+jLTqq2HSYFvnwU8=; b=Z1+FNIAnm3Uk7NiLOghJIjx4nE
 25DF2YWe/MRNT616ISX/sQrwP5m/G+z+E7sF/uWNCLaCn+KpNmHxjG+fGVOQ2nD07HUE9EG3aZZEt
 4dbER5mhfwaMgVn7y0UvJfZqIZf0dMxG3kgTgmozRp4gIW7R26uKK7GlFSaIJ48Dcxrs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w83aYKok5uLYx2N6itw79nxWy3Y+jLTqq2HSYFvnwU8=; b=Hwaq3VW/fBNfCLtZbYzRAJZkO4
 ToL/JIjjIvhxQyWTQ44pm/ZiTUPuSdkg0rvUHS3C5WIEKDK4v3c/IIJ9Qn565gFoYk9aXE2fXAiNP
 2bY4WlE7ApqT0rsHm3JEVlTRkG/uHUcpqikJVWmsHBLyBL1GjvGY1sbx4pn4c1cdvP7k=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOKLT-000000004dj-2FLv for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:39:00 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so2642918f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 11:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793734733; x=1794339533; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w83aYKok5uLYx2N6itw79nxWy3Y+jLTqq2HSYFvnwU8=;
 b=KVo/u/QisNaJU8y4CQrhohJRjG2Je2vMkL0JcjDQ+U1jYCDWVs/ou9EuhJgAfe3wHN
 LYxIfX+YtX+H7pmv/nOs2PSIl59OlQTAhWpFh5c/WlesbNHwptiOCcpP1hPzuJ53wCYR
 kjrq/Ut1OyQ+/uQJdPzI3EqzKEE0x8HffBLoZurXn1ESrZgFujVFG8L5Zd/Heun6t8Mp
 irfphLDUWo3y1U7BRAMaqoI+vJwaaheFvU9duAi48RQe8e/yjrPesZU54nn7ZYu6sVlV
 IMpKr0cWd2qrgWovfQsoL5BmTMpeVibC8J/agNy8UX9mYj5DkLnQDiZasZ7suAv/26tr
 adiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793734733; x=1794339533;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w83aYKok5uLYx2N6itw79nxWy3Y+jLTqq2HSYFvnwU8=;
 b=IIR82PZMTGCIpD02yxXauFnfwttD7p3OgUmGBrcIJMQYPAcuHY4tJGaTgaUWRm53rh
 zm6G2jdYhXhN9Spj/5oGzFV4VGs7S6QTRbciZVMcG0/qhyveN9zbLrWh1D3GtQPy5+XC
 PHeJ2bNywGRmOJdhkk0NVrxe4ax52jgJ7tFsbSo7EbnCOVuWyXEhc8swDcMj4L/Wj8dF
 68YFq8USb6RknoQLkKkAtT8OpnWxWqESjSszWT1m2jLDYAv8a/Wshj0X/VBfI8v+TpD5
 7fiC95YB1LCtfjaHGphV46hcYHJRiUe4fySGVG3k3Ju7lirOqxTo0Fkmp2+6saGG7GT2
 5G2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+t7g6aoVygPdKTIykEdxlfvXdpGJYcQzf7B9evgLkvuXEUHiehMQt0B1TAQnxhM3QJBOdFmaBqbKTffhy@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9jXDj4VrrYXfgV7/HgAoULTQepxTmNnRIBfYNfG/RJjZHOipO7
 1hRxTxq8eqd+CZj041EiGmCV15o/KqEqda4I/DZaOsQj/nynsnK4cZ4x+Dg/FL5C1cpjYTIzVbU
 XN/6mEfDLUJVIOQo1qZioxmTn8ibDMx3tdtupUlfieN8dEVfnTl7T2zC4k9wASN5O2OH0WFFQjt
 vpWDUOGQ==
X-Gm-Gg: AYBFou1Ck5wdUapEAbcNDXRt6QW6JsNKiFmfUHDyBEJR0OdWyQNON5UoqnDOjK2NcQ5
 F3DCXgc5PUtQGmR6pLhrds9galRNNzk2V6SMjqtLUrbQRYVoBPf1g8qwl2ryccrDZyvV93/bZkT
 +9kzZxYoEQgQorSQKFSLDB+/7dkPcnEFilIFHrDwbCOTOpq8XHNblbSEKdVKe1m10VWUoRXRTmW
 t4YIcDmMuWtP79qpWqL0dCi6Ez6jbi4t8EKPbv/kG3qM9Aa3Q9IjoHPLeSnerKLWxmBS2Ivw1mx
 DVaB9I6EYLweg+UVussOjXfG9HGdbDPyD5XbDe7yRXmdQgPBFzzZCM7KNTV9hxETMrncApmvSr/
 N8Ne/RNEofKNeQUdtSJicEIf8ODpu3vyHzPAvLjMv7PsLBzTJABgG6D5Jc+l/inFq7td2Md1Er/
 fNPlxwtkkuTR9i49+nJYV4L3d+cGXejzytj3uWNiSXq+QEf7VYrJBs8f84P2Xx2w34XU4rH3eLN
 gUMOVemgKx9lLUxTz+UOtmFyhMJUCVtIVffdge+srOgS7Hajh6hmqtLqpXeKPuFNJLcMm8XZ9+h
 5FsvG88+kaTwN2Ql5Z6DwNIZ2IQwu66K8bAIFZFf6EamkGLoBiVdR9MMTNQUzDAd9Vu84N899wO
 qBFALGsq36Y3YaWoJvNGcjINNTwIvPhqdDYvSTyEJfr0WXrVBN12TzTRdVDB5y8nHYlHTuR71/Y
 /y2url8DGaxHLIww==
X-Received: by 2002:a05:6000:4211:b0:48e:d88:55f5 with SMTP id
 ffacd0b85a97d-48e6e3054bcmr32392111f8f.30.1793734732757; 
 Tue, 03 Nov 2026 11:38:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fcc0e4592sm282298f8f.9.2026.11.03.11.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:38:52 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 19:38:51 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
X-Gerrit-Change-Number: 1950
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1950?usp=email>
X-Gerrit-Commit: d42fbb1f40fdc9ef20dbe524db108e4920e388ac
In-Reply-To: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
References: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzI5ODkxMDAwLkk0NDBjNGM3Mzg2NWZkYmQ4MGYyYzYwN2U4M2M1MGUzNDVhMGUyNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <055e1f89f0c556e397b96ea8024c70319b14556a-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOKLT-000000004dj-2FLv
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3286399168904050593=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3286399168904050593==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bm8uWs6+Uvc="; charset=UTF-8

--bm8uWs6+Uvc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1950?usp=3Demail )

Change subject: Do not look up the "none" c=
ipher in OpenSSL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Do not look up the "none" cipher in OpenSSL

cipher_get() hands EVP_CI=
PHER_fetch() whatever name it is given, and the
callers that only ask wheth=
er a cipher exists or which mode it has
(cipher_kt_mode_cbc/ofb_cfb/aead(),=
 cipher_kt_block_size(),
cipher_kt_insecure()) treat NULL as "not that"=2E =
For the "none" cipher
that is the expected answer, but under OpenSSL 3 the =
failed fetch also
pushes EVP_R_UNSUPPORTED ("digital envelope routines::uns=
upported,
Algorithm (none : 0)") onto the thread's error queue, and nothing=
 pops
it=2E

"none" is what every server without --cipher carries in its
pr=
e-negotiation key_type: the legacy BF-CBC default is not in
--data-ciphers,=
 so do_init_crypto_tls() initialises the key_type with
cipher "none"=2E Eac=
h new client instance walks it in init_instance() ->
do_init_crypto_tls() -=
> cipher_kt_mode_ofb_cfb("none") and in the frame
and OCC calculations, and=
 tls_ctx_reload_crl() runs right after=2E Before
commit 15a1465f ("Make CRL=
 reload EOF detection independent of stale
error queue entries") that stale=
 entry made the first handshake after a
CRL change log "CRL: cannot read CR=
L from file" for a CRL it loaded fine
(GitHub #1103); since then the reload=
 reports it at D_LOW as "CRL:
OpenSSL error queue not empty on CRL load" an=
d clears it=2E

Return NULL for "none" before touching OpenSSL, as cipher_k=
t_name()
already does=2E Real cipher names behave as before, and
cipher_val=
id_reason() still finds the OpenSSL reason on the queue when
it reports an =
unknown cipher=2E

Left alone on purpose: cipher_kt_block_size()'s probe fo=
r the CBC
sibling of an AEAD cipher (CHACHA20-POLY1305 -> "CHACHA20-CBC") a=
nd
md_valid() leave the same kind of entry, but neither runs between
client=
 instance creation and the CRL reload=2E

With this change the queue is emp=
ty when the CRL reload runs for UDP
and TCP clients, and CRL replacements g=
ive clean reloads with no
"error queue not empty" report (current master: o=
ne per replacement)=2E

Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e243=
8
Signed-off-by: Drew Blokzyl <drew@linuxkids=2Ecom>
Acked-by: Razvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1950
Message-Id: <20261103192732=2E13656-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg40626=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpn/crypto_openssl=2Ec
1 file changed, 9 insertions(+), 0 dele=
tions(-)




diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/cryp=
to_openssl=2Ec
index 3c708c2=2E=2Eb7f2ef3 100644
--- a/src/openvpn/crypto_o=
penssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -569,6 +569,15 @@
 {
   =
  ASSERT(ciphername);
 
+    /* "none" is a valid OpenVPN cipher name that =
OpenSSL does not know=2E
+     * Return NULL without asking OpenSSL: a fail=
ed EVP_CIPHER_fetch() would
+     * leave an "unsupported" entry on the err=
or queue that the cipher_kt_*()
+     * callers never clear=2E */
+    if (=
strcmp("none", ciphername) =3D=3D 0)
+    {
+        return NULL;
+    }
+
=
     ciphername =3D translate_cipher_name_from_openvpn(ciphername);
     re=
turn EVP_CIPHER_fetch(NULL, ciphername, NULL);
 }

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
Ger=
rit-Change-Number: 1950
Gerrit-PatchSet: 4
Gerrit-Owner: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--bm8uWs6+Uvc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1950?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Do not look up the &quot;none&quot=
; cipher in OpenSSL<br><br>cipher_get() hands EVP_CIPHER_fetch() whatever n=
ame it is given, and the<br>callers that only ask whether a cipher exists o=
r which mode it has<br>(cipher_kt_mode_cbc/ofb_cfb/aead(), cipher_kt_block_=
size(),<br>cipher_kt_insecure()) treat NULL as &quot;not that&quot;=2E For =
the &quot;none&quot; cipher<br>that is the expected answer, but under OpenS=
SL 3 the failed fetch also<br>pushes EVP_R_UNSUPPORTED (&quot;digital envel=
ope routines::unsupported,<br>Algorithm (none : 0)&quot;) onto the thread&#=
39;s error queue, and nothing pops<br>it=2E<br><br>&quot;none&quot; is what=
 every server without --cipher carries in its<br>pre-negotiation key_type: =
the legacy BF-CBC default is not in<br>--data-ciphers, so do_init_crypto_tl=
s() initialises the key_type with<br>cipher &quot;none&quot;=2E Each new cl=
ient instance walks it in init_instance() -&gt;<br>do_init_crypto_tls() -&g=
t; cipher_kt_mode_ofb_cfb(&quot;none&quot;) and in the frame<br>and OCC cal=
culations, and tls_ctx_reload_crl() runs right after=2E Before<br>commit 15=
a1465f (&quot;Make CRL reload EOF detection independent of stale<br>error q=
ueue entries&quot;) that stale entry made the first handshake after a<br>CR=
L change log &quot;CRL: cannot read CRL from file&quot; for a CRL it loaded=
 fine<br>(GitHub #1103); since then the reload reports it at D_LOW as &quot=
;CRL:<br>OpenSSL error queue not empty on CRL load&quot; and clears it=2E<b=
r><br>Return NULL for &quot;none&quot; before touching OpenSSL, as cipher_k=
t_name()<br>already does=2E Real cipher names behave as before, and<br>ciph=
er_valid_reason() still finds the OpenSSL reason on the queue when<br>it re=
ports an unknown cipher=2E<br><br>Left alone on purpose: cipher_kt_block_si=
ze()&#39;s probe for the CBC<br>sibling of an AEAD cipher (CHACHA20-POLY130=
5 -&gt; &quot;CHACHA20-CBC&quot;) and<br>md_valid() leave the same kind of =
entry, but neither runs between<br>client instance creation and the CRL rel=
oad=2E<br><br>With this change the queue is empty when the CRL reload runs =
for UDP<br>and TCP clients, and CRL replacements give clean reloads with no=
<br>&quot;error queue not empty&quot; report (current master: one per repla=
cement)=2E<br><br>Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438<br>S=
igned-off-by: Drew Blokzyl &lt;drew@linuxkids=2Ecom&gt;<br>Acked-by: Razvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1950<br>Message-Id: &lt;20261103192732=2E13656-1-ger=
t@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg40626=2Ehtml<br>Signed-off-by: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/crypto_openssl=
=2Ec<br>1 file changed, 9 insertions(+), 0 deletions(-)<br><br></pre>
<pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec<=
/span><br><span>index 3c708c2=2E=2Eb7f2ef3 100644</span><br><span>--- a/src=
/openvpn/crypto_openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openss=
l=2Ec</span><br><span>@@ -569,6 +569,15 @@</span><br><span> {</span><br><sp=
an>     ASSERT(ciphername);</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* &quot;none&quot; is a valid OpenVPN cipher=
 name that OpenSSL does not know=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * Return NULL without asking OpenSSL: a failed EVP_CIP=
HER_fetch() would</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * leave an &quot;unsupported&quot; entry on the error queue that the cip=
her_kt_*()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ca=
llers never clear=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (strcmp(&quot;none&quot;, ciphername) =3D=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     ciphername =3D translate_cipher_name_from=
_openvpn(ciphername);</span><br><span>     return EVP_CIPHER_fetch(NULL, ci=
phername, NULL);</span><br><span> }</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail">change 1=
950</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I440c4c73865fdbd80f2c607e83c50e345a0e2438 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1950 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--bm8uWs6+Uvc=--


--===============3286399168904050593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3286399168904050593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3286399168904050593==--

