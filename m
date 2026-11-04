Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C11606A332
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hexBZv3e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JoYoRxLZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YilqKWxn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=A2siuAKW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=SMxVqOR6+iULdGP/KPIlQfcsxe84wGnIUa64ug8UJew=; b=hexBZv3eGhRDk6RyCxeTzoEgwK
	Rjsff+n9b6P8Q8Fva6nqNK3+3Ot/nRcOL0l6EQxXSDs339e+V+ETJUGDjsH1GvXmDOSV5IP181U0B
	D9DLoYnhSDsF4f8Ze6eZG4lUxBpTt0S3MJsajs0NoG3qpdlwolTM3ufpp9r6gD2ATTXw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOVaD-000000002rl-31wE;
	Wed, 04 Nov 2026 07:38:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOVaC-000000002rb-3EHx
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:38:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=54vlT7AT8LvuCnsSo0W+xNYH3jVEc5Kmm7Nw/bHilP8=; b=JoYoRxLZ/Bgi9RL2aLZWBuDReY
 BeVYelcfmYCxDMPssWDYTn5A24r5QvR81R9PAIv0u76jmjYlZUR1YAVfF+7+KcOUQq73pIY30spfw
 j2VvbAHVcq+n+2FIfLMHeZa8pCtHBGwxie6X92MFTBqzJS3j9sifTbgwZPcHoUOyZ1EY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=54vlT7AT8LvuCnsSo0W+xNYH3jVEc5Kmm7Nw/bHilP8=; b=YilqKWxnT836ZHG6A4tJb3USCa
 BgUY/zNY5ITRAij5p+nB++Bpc6bciWJAGcYVgmEKI2/OVTUnWcXYGHEai9EWX64zYPA5nV7crfcog
 0OmKMagx2WWcbzQnY81DW0pJ4ZaZktva75t6srZS3WdCz7XnZyb0Cjk4hwt6haaXuGuo=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOVaB-00000000079-0lw4 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:38:56 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso91041f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 23:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793777928; x=1794382728; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=54vlT7AT8LvuCnsSo0W+xNYH3jVEc5Kmm7Nw/bHilP8=;
 b=A2siuAKWNd8kon0NGURxV5+3am8j4slRtBr/5UYl9Yt0qtM6GIrYTmCryD501ZoeL+
 DNljn0qjOS5L71B6P+33/gT2O/iVPZePp1Wcc24/YQ1kKGmTU5Jjz8StIWghf446dbdo
 E+zkWFPGD5B/XMe/g7zjDiafD7mOKwHBvhS3boGYh7eQOb7bxBdFbZSJjxOQAXnGnP9E
 qoaxMA7Mm3WN9IzTWkNisKPGBg2KfwKwWId2zAdIsH8XU0pBn8sRIp+7Usfre1YFr7l2
 yNI/5GsfALD5CJiN7v6aYtu7lzKJe+ujnkwDBKAba71ny3isg5O4yl3StTHzoaQCdh8Y
 DB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793777928; x=1794382728;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=54vlT7AT8LvuCnsSo0W+xNYH3jVEc5Kmm7Nw/bHilP8=;
 b=GJPkk1n201mB4gdhe1gz7fVz7igztU9h8kwqEe6TxjRuWYvDuEb9pQIO1TVldTiBPT
 +ezijLNEGP/81cFh+bgowOmhKj3wl78mF2GoPnpvhMu9lX4TMrsmEZ1Jhn/XQ6GolOr0
 /oAtiaUgQ3CtArUTGoA/Ia9f3Vj9KjzZ7JzPY41UBMw1Uk+PnQ+j+t1x1Y82cecn03Xw
 8sQYAH9j0Hiip0+Lq9AP/CT22znoadpiJwshYyNmSdSYtZjh2xkNKktPscLsX6iTsT4e
 4ienR7CctwLMGGlP3jl+RuEoLu20HXlIO8MrFc2uUoPd8H4eZ5W+zUIEIEsN9vAfnMDC
 +thw==
X-Gm-Message-State: APuU4Z99vf/9+sUbl/6nlmviAs7S8cdP7IxXIxFnCMsRSvYJnMRduSZU
 Z1DvyOWlhMuAcPIRkx9jI1Ie1ai39FxSWhwY8ebzKAYnVW/0xcB4HM48OV7pAUhpSlBBgm4a11e
 AqNIA9GJNcuplPpaxKMCkZmPXBqj0slNFhQxm6RcxnO4JZsPfVDX/hvllC9wYd0Eun24RVIrXXC
 AjvGcqbw==
X-Gm-Gg: AYBFou38In2xNmLQ7s6tnTksw7eLLtYRebevZg/0lEv1i1uo722zakUoumoHrNSyPL6
 2UfGQGQgu6+fVq85RTwZNFGCU5TnkL7NF4Zi4qwMtxZA8uV2uO6bYSTle7sZHP7PpPzGdvoPHM6
 F9VG1VPvz11ZNQENfN/TFcEeIgYGGi53kmW+Fu8HirLPKcfZY6WzBxE2UDPV0i0TuHf3daySCyr
 85fj/lYATg4eFSESultZPhsn+5h5FTMBSSDmUW5oVge1rkHjpjzqHHg137EpFFP+NSw7wLJKUDh
 2d0UqGR2AkmNrxHUIJQtEsnsxNyg/d0U50q9O2KUSbwa8WuKBabZ1Nv3xhzx9lGl1axlLWNiLe6
 pjRoNENg84Ro+ZhJIsqGgmSriCemyiTrSmniCKOiMpQXag9t0aT7Ye5JKa/9jsdmYKb/s0p48Ir
 a1Kxo+imNs4uPiGX2RKRVm83qFzATm4lxJDFERUgnFceIiImCUitAwDNGOpPQJAjBg3qCYvLLTa
 L57V2eRfTcncYOBDKpkLX5Ao6Q/OA0jBHVA+jo4W/fuS58JbJj1a07wbwYmnIhFuFfQrpyYofIF
 dd++wHTmWnvt+kU7FB1IZ5NutbGlp6j56PV9EinDqj7GogrYxL02yvumymJiM80FU0IuU7F/mHf
 IGo9/GEKYafu0hwLWs73IF3HA2G4FQLYrF+jf8oyFq+NiNbbfK92RFzQY2Fv01R2W2mCAa6q5BJ
 kMr2qdmEGxPpi0kQ==
X-Received: by 2002:a05:6000:4810:b0:48b:2a2:31dc with SMTP id
 ffacd0b85a97d-48e6e5267c4mr35534115f8f.49.1793777928303; 
 Tue, 03 Nov 2026 23:38:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea180eaesm2676273f8f.2.2026.11.03.23.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:38:48 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 07:38:47 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
X-Gerrit-Change-Number: 2121
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2121?usp=email>
X-Gerrit-Commit: 74227ff93033712f8613053e29e1442a1a49bb9a
References: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc3OTI2MDAwLklhOWYzMjhiMWMwZWEyOWFkZjgxMWE5MzNkMWZkMjJjYjMyZTM1ZTZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ffb95b5061054246eef4d2cca7f6b868687fa17a-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOVaB-00000000079-0lw4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: pkcs11: bound
 certificate size in pkcs11_management_id_get()
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
Content-Type: multipart/mixed; boundary="===============5272780589207334773=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5272780589207334773==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ut5M96geGAc="; charset=UTF-8

--Ut5M96geGAc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2121?usp=3Demail

to review the following change=2E
=


Change subject: pkcs11: bound certificate size in pkcs11_management_id_ge=
t()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

pkcs11:=
 bound certificate size in pkcs11_management_id_get()

0a8e80aa ("Avoid unb=
ounded allocations in pkcs11_mbedtls=2Ec") capped
the certificate blob size=
 reported by the PKCS#11 provider only in the
mbedTLS backend=2E pkcs11_man=
agement_id_get() still allocated whatever
size the provider returned=2E Mov=
e the limit to pkcs11_backend=2Eh as
PKCS11_MAX_CERT_SIZE and check it ther=
e too=2E

Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
Signed-off-b=
y: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/pkcs11=2Ec
M s=
rc/openvpn/pkcs11_backend=2Eh
M src/openvpn/pkcs11_mbedtls=2Ec
3 files chan=
ged, 22 insertions(+), 12 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/21/2121/1

diff --git a/src/openvpn/pkcs1=
1=2Ec b/src/openvpn/pkcs11=2Ec
index f00ba9b=2E=2E52658c2 100644
--- a/src/=
openvpn/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -504,6 +504,13 @@
      =
   goto cleanup;
     }
 
+    if (certificate_blob_size > PKCS11_MAX_CERT_=
SIZE)
+    {
+        msg(M_WARN, "PKCS#11: Certificate too large: %zu byte=
s, maximum is %zu",
+            certificate_blob_size, PKCS11_MAX_CERT_SIZ=
E);
+        goto cleanup;
+    }
+
     if ((certificate_blob =3D (unsigne=
d char *)malloc(certificate_blob_size)) =3D=3D NULL)
     {
         msg(M_=
FATAL, "PKCS#11: Cannot allocate memory");
diff --git a/src/openvpn/pkcs11_=
backend=2Eh b/src/openvpn/pkcs11_backend=2Eh
index b8b0eb0=2E=2E11e8498 100=
644
--- a/src/openvpn/pkcs11_backend=2Eh
+++ b/src/openvpn/pkcs11_backend=
=2Eh
@@ -37,6 +37,18 @@
 
 #include <pkcs11-helper-1=2E0/pkcs11h-certificat=
e=2Eh>
 
+/*
+ * Maximum size of a certificate retrieved from a PKCS #11 pr=
ovider, so that the provider cannot
+ * crash OpenVPN by making it try to a=
llocate 2^64 bytes=2E The maximum of 100=2E000 bytes is picked
+ * as a rou=
nd number that easily accomodates the currently standardized quantum-safe s=
ignature
+ * algorithms=2E It is twice the size of a SLH-DSA (aka SPHINCS+)=
 signature plus public key=2E
+ *
+ * However, there are additional digital=
 signature schemes currently on the NIST on-ramp
+ * (e=2Eg=2E, some parame=
ter settings for LESS) that have even larger public keys or signatures, so
=
+ * if those ever see use on smartcards, we will need to increase this numb=
er=2E
+ */
+#define PKCS11_MAX_CERT_SIZE ((size_t)100000)
+
 /**
  * Retrie=
ve PKCS #11 Certificate's DN in a printable format=2E
  *
diff --git a/src/=
openvpn/pkcs11_mbedtls=2Ec b/src/openvpn/pkcs11_mbedtls=2Ec
index 2183217=
=2E=2E3ee3837 100644
--- a/src/openvpn/pkcs11_mbedtls=2Ec
+++ b/src/openvpn=
/pkcs11_mbedtls=2Ec
@@ -42,16 +42,6 @@
 static bool
 pkcs11_get_x509_cert(p=
kcs11h_certificate_t pkcs11_cert, mbedtls_x509_crt *cert)
 {
-    /* We set=
 a maximum size for certificates so that the PKCS provider cannot crash Ope=
nVPN by
-     * making it try to allocate 2^64 bytes=2E The maximum of 100=
=2E000 bytes is picked as a round
-     * number that easily accomodates th=
e currently standardized quantum-safe signature algorithms=2E
-     * It is=
 twice the size of a SLH-DSA (aka SPHINCS+) signature plus public key=2E
- =
    *
-     * However, there are additional digital signature schemes curre=
ntly on the NIST on-ramp
-     * (e=2Eg=2E, some parameter settings for LES=
S) that have even larger public keys or signatures, so
-     * if those eve=
r see use on smartcards, we will need to increase this number=2E */
-    co=
nst size_t max_cert_size =3D 100000;
-
     unsigned char *cert_blob =3D NU=
LL;
     size_t cert_blob_size =3D 0;
     bool ret =3D false;
@@ -62,9 +52=
,10 @@
         goto cleanup;
     }
 
-    if (cert_blob_size > max_cert_s=
ize)
+    if (cert_blob_size > PKCS11_MAX_CERT_SIZE)
     {
-        msg(M_=
WARN, "PKCS#11: Certificate too large: %zu bytes, maximum is %zu", cert_blo=
b_size, max_cert_size);
+        msg(M_WARN, "PKCS#11: Certificate too larg=
e: %zu bytes, maximum is %zu", cert_blob_size,
+            PKCS11_MAX_CERT=
_SIZE);
         goto cleanup;
     }
 

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
Gerrit-Ch=
ange-Number: 2121
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--Ut5M96geGAc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">pkcs11: bound certificate size in pkcs11_management_id_=
get()<br><br>0a8e80aa (&quot;Avoid unbounded allocations in pkcs11_mbedtls=
=2Ec&quot;) capped<br>the certificate blob size reported by the PKCS#11 pro=
vider only in the<br>mbedTLS backend=2E pkcs11_management_id_get() still al=
located whatever<br>size the provider returned=2E Move the limit to pkcs11_=
backend=2Eh as<br>PKCS11_MAX_CERT_SIZE and check it there too=2E<br><br>Cha=
nge-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d<br>Signed-off-by: Razvan =
Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/pkcs11=2Ec<b=
r>M src/openvpn/pkcs11_backend=2Eh<br>M src/openvpn/pkcs11_mbedtls=2Ec<br>3=
 files changed, 22 insertions(+), 12 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/21/212=
1/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</s=
pan><br><span>index f00ba9b=2E=2E52658c2 100644</span><br><span>--- a/src/o=
penvpn/pkcs11=2Ec</span><br><span>+++ b/src/openvpn/pkcs11=2Ec</span><br><s=
pan>@@ -504,6 +504,13 @@</span><br><span>         goto cleanup;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (certificate_blob_size &gt; PKCS11_MAX_CERT_SIZE)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;PKCS#11: Certif=
icate too large: %zu bytes, maximum is %zu&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            certificate_blob_size, PKCS11_MAX=
_CERT_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 goto cleanup;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   if ((certificate_blob =3D (unsigned char *)malloc(certificate_blob_size)=
) =3D=3D NULL)</span><br><span>     {</span><br><span>         msg(M_FATAL,=
 &quot;PKCS#11: Cannot allocate memory&quot;);</span><br><span>diff --git a=
/src/openvpn/pkcs11_backend=2Eh b/src/openvpn/pkcs11_backend=2Eh</span><br>=
<span>index b8b0eb0=2E=2E11e8498 100644</span><br><span>--- a/src/openvpn/p=
kcs11_backend=2Eh</span><br><span>+++ b/src/openvpn/pkcs11_backend=2Eh</spa=
n><br><span>@@ -37,6 +37,18 @@</span><br><span> </span><br><span> #include =
&lt;pkcs11-helper-1=2E0/pkcs11h-certificate=2Eh&gt;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Maximum size of a certificate retrieve=
d from a PKCS #11 provider, so that the provider cannot</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * crash OpenVPN by making it try to al=
locate 2^64 bytes=2E The maximum of 100=2E000 bytes is picked</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * as a round number that easily =
accomodates the currently standardized quantum-safe signature</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * algorithms=2E It is twice the =
size of a SLH-DSA (aka SPHINCS+) signature plus public key=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * However, there are additional digital signature=
 schemes currently on the NIST on-ramp</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * (e=2Eg=2E, some parameter settings for LESS) that hav=
e even larger public keys or signatures, so</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * if those ever see use on smartcards, we will nee=
d to increase this number=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 PKCS11_MAX_CERT_SIZE ((size_t)100000)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Retrieve PKCS =
#11 Certificate&#39;s DN in a printable format=2E</span><br><span>  *</span=
><br><span>diff --git a/src/openvpn/pkcs11_mbedtls=2Ec b/src/openvpn/pkcs11=
_mbedtls=2Ec</span><br><span>index 2183217=2E=2E3ee3837 100644</span><br><s=
pan>--- a/src/openvpn/pkcs11_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/=
pkcs11_mbedtls=2Ec</span><br><span>@@ -42,16 +42,6 @@</span><br><span> stat=
ic bool</span><br><span> pkcs11_get_x509_cert(pkcs11h_certificate_t pkcs11_=
cert, mbedtls_x509_crt *cert)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* We set a maximum size for certificates so=
 that the PKCS provider cannot crash OpenVPN by</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     * making it try to allocate 2^64 bytes=2E Th=
e maximum of 100=2E000 bytes is picked as a round</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     * number that easily accomodates the curre=
ntly standardized quantum-safe signature algorithms=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     * It is twice the size of a SLH-DSA (=
aka SPHINCS+) signature plus public key=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-     * However, there are additional digital signature schemes curren=
tly on the NIST on-ramp</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     * (e=2Eg=2E, some parameter settings for LESS) that have even larger=
 public keys or signatures, so</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-     * if those ever see use on smartcards, we will need to increa=
se this number=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   const size_t max_cert_size =3D 100000;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span>     unsigned char *cert_blob =3D NULL=
;</span><br><span>     size_t cert_blob_size =3D 0;</span><br><span>     bo=
ol ret =3D false;</span><br><span>@@ -62,9 +52,10 @@</span><br><span>      =
   goto cleanup;</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (cert_blob_size &gt; max_cert_si=
ze)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cert_blo=
b_size &gt; PKCS11_MAX_CERT_SIZE)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;PKCS#11: Certi=
ficate too large: %zu bytes, maximum is %zu&quot;, cert_blob_size, max_cert=
_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_WARN, &quot;PKCS#11: Certificate too large: %zu bytes, maximum is %zu&quo=
t;, cert_blob_size,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            PKCS11_MAX_CERT_SIZE);</span><br><span>         goto cleanup;</=
span><br><span>     }</span><br></pre><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail">change 2121</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia9f328b1c0e=
a29adf811a933d1fd22cb32e35e6d </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2121 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </=
div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Ut5M96geGAc=--


--===============5272780589207334773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5272780589207334773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5272780589207334773==--

