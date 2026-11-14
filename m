Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E31606A336
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hcGUgZJm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Wch+4A6T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QbvY9OBN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LADkz7NF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cn6fneLdSLSR1xZ5NTQZssGT1Z3iJ77cHTbRservwVQ=; b=hcGUgZJmH5AZbn3zFE8mt0oFwn
	mAIalr/ZbLm9xD6lGUwiXGPWOXo/xurur3uGEqwqZP2WjfsSOH7V4NBPLJ1PEsC/Aha4WS0+nniJJ
	1QirniCiOfBzrclY+HMYNqXpWYwcRbIHgHCbvk5mLtp9do6bNBJkA4Xga7/UBimlLpDg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGJi-000000006RW-1Jqx;
	Sat, 14 Nov 2026 16:09:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGJh-000000006RQ-1sGy
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:09:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LCPO6dxsInzXEzmb4pqM31ZV8xUzwkkfFQ6VnqiVXGE=; b=Wch+4A6TpEnmrzCoveTzG0ixo3
 6443tnKsvW8KwbyW02VKFfK5Ofs6DPa7zza4ybGNfX3g0lR4op4kOn3P/4C5TdBh6I5ioN2MEFFZt
 rslzwRadqNUI8ldYMu/polY26j3uvTWBrGPSTXslHfwgQ89sxYvqIIxfH0gCUjGyrzTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LCPO6dxsInzXEzmb4pqM31ZV8xUzwkkfFQ6VnqiVXGE=; b=QbvY9OBNxFLu9kAOXtx2dMCJFM
 WtjK4JtU+PIemf+v4VJ6mMofXpjbPsdUcORpriZNGyW/QY2Af7uUtJJY1JGHMae/DfjJYJRcjTiQ7
 g3/7s1YmDXpTM07nBcxhrj5HrMMwnFNaG/CLRKdJ7iEXzlHBTvv9YedzFU+GlVJNGLqY=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGJg-000000001Wf-0rMy for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:09:25 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so905277f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794672558; x=1795277358; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LCPO6dxsInzXEzmb4pqM31ZV8xUzwkkfFQ6VnqiVXGE=;
 b=LADkz7NFEjGyBNQeNHHFKMgmVQTFR06mwf2JmfBL8dVRRHbKZhsVtHlDvur4uJYE7H
 lru3hsn9GAbynsR4szUJiOaVhwpol9E0vboQ7WkUaODaDIQDHM/s1aLZ/iiUbwRjmLy+
 9JLL5dNAmxxT4HNy+FkGfppTqaHVPlkzkrK8dBTNaTdw+C6onVUdTws72GNEs0NPFU3m
 tFZiyWkafpCXYf9mL3aV4o/Z70TBzROiGQtscl+GktICSRfNtXQCZa4O8ozgysqw4Xix
 og1GT6UsWKQOdnsCXvctD00z0dn/DXzycFDRhlhJuDvRX4sOJ/gQBNTXeJakofRJj7Ra
 9DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672558; x=1795277358;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LCPO6dxsInzXEzmb4pqM31ZV8xUzwkkfFQ6VnqiVXGE=;
 b=MHFHRBeDIsqajTqpMhlKvXB2GmzWGFuSScDLf/VZdppBUuDxX8XjgwPjUD0b0Mi5nB
 bBFMJHqR+v4mGrHD6OvcyY8giCwnj2seqXQfO0ixmAA7y1ydJfADaabdSgHYKp3KeSpN
 /JShpgBoY6fyi4zRcWzORSggfz7Rd1SLfrhb/qvkxovUjiZRCC62IhqYYfovkcflI6Ov
 MacmiHgw0tClt8LF+I1/TpiTrrjPec3cJ3H73SlrCaI+aA9IL1ezQbm3odOlGaQR1b2t
 feK2hABJhWkeiqP6o+zsvB/9r8pYS4GoD9HrCa+mWOJspipMwSK9m7ksPsSHLJVCvzdJ
 klkA==
X-Gm-Message-State: APuU4Z+iI1dScwt7TfYtaD/ow+25CG1OwPvtmxQIzkNvejVxA6N+hpgi
 0mcoo8LJR8tGSN617v1v1NuNdYwE/ek8+1rEcAhOr5lJAOSyRBoCSlh9KwpyKEYN4gDxnz2fFPa
 w2P1wK8LmRXs00N572fRu4x7PdWl5Tj76TFm86lT3dBSf1Wh/75O+73Ou11dUCLMEhgmY0INkDN
 UKEQrfkg==
X-Gm-Gg: AYBFou0fOj2/6PwXkB1w3oFkeUViqmo9zDcvVbGhfs45Dp5zPmiWmhHQqHqWQpUZneX
 Mq4EN6A4N6xvggW0glK75vO/YASG5pd6GRl9NPn6V1lTLVgiJGOwG8lyfQDw4TC/0sxRBvMeMmh
 BpM95+LuwUQmsCDR4C9FrmuF/954IJJtmYSc5oTJNqaeDXpBrjHjeKzs9qPjHenXvaVDfbDamIP
 omomfIycMJeAFnpMQUqQk+W/HHDheasBD0cmeL0pIHufL3Tkk97I9AihsBNBetASVAj4wsAo4Uw
 WoGeL8tXezFj6GkJz6x/sOmexuqG3m9TVAzEyO/2h3lSHf3UKv8e8JU1dxVQ9NgRNhntGQ2W2kc
 E/mqABjz6E6XMmYSxX+0NkpbKTem0suHbr2jOmtWhn/pKYBkXDOnCt0mNdNhwXmYgg4GddlpKAW
 BV8HC6r7KqC8F0ep+V5awtn73Sp4mbXSc+26FbkGlSnxg3VEGGgJZrg8eyNINPe6B2IStji4CjG
 pl13Jl3eJhAxs0v+daxSywAQwG/0v2/AkZQ2hS/223zXba1cnWrSCWNLw9B03dELeYmuTVk9ynZ
 BA2+19HcQkn59l8EJEslKCcXxioWp1I7x+i96QQc+VJAYXxCvLCOkUDAqLvCrc4L60w6gsR7gM+
 IWQPJ6vfrogRrJJcMHmSf5Jx6lUjxrqirruxLjp/zRsmBzRJA1M+kV0UuyOGSwFjjpi4xS9++Sk
 VbmH5/eqMHe7av6K8=
X-Received: by 2002:a05:6000:2dc3:b0:48b:1a0:5630 with SMTP id
 ffacd0b85a97d-49c72f7b8d7mr13704080f8f.41.1794672557289; 
 Sat, 14 Nov 2026 08:09:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm19414305f8f.7.2026.11.14.08.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:09:16 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:09:16 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
X-Gerrit-Change-Number: 2121
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2121?usp=email>
X-Gerrit-Commit: 51a2f1b027d5170a340b82d232ad9561dbdb9adb
In-Reply-To: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
References: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc3OTI2MDAwLklhOWYzMjhiMWMwZWEyOWFkZjgxMWE5MzNkMWZkMjJjYjMyZTM1ZTZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <144b64cf9ccfe0f01b879358f67854798d703013-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGJg-000000001Wf-0rMy
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0882213074021187675=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0882213074021187675==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SJgZaGxzJ2M="; charset=UTF-8

--SJgZaGxzJ2M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, R=C4=83zv=
an Cojocaru=2E

Hello Arne Schwabe, Gert Doering, 

I'd like you to reexami=
ne a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2121?usp=3Demail

to look at the new patch set (#2)=2E

The following appr=
ovals got outdated and were removed:
Code-Review-1 by Gert Doering


Change=
 subject: pkcs11: bound certificate size in pkcs11_management_id_get()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

pkcs11: bound ce=
rtificate size in pkcs11_management_id_get()

0a8e80aa ("Avoid unbounded al=
locations in pkcs11_mbedtls=2Ec") capped
the certificate blob size reported=
 by the PKCS#11 provider only in the
mbedTLS backend=2E pkcs11_management_i=
d_get() still allocated whatever
size the provider returned=2E Move the lim=
it to pkcs11_backend=2Eh as
PKCS11_MAX_CERT_SIZE and check it there too=2E
=

Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
Signed-off-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/pkcs11=2Ec
M src/openvp=
n/pkcs11_backend=2Eh
M src/openvpn/pkcs11_mbedtls=2Ec
3 files changed, 24 i=
nsertions(+), 12 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/21/2121/2

diff --git a/src/openvpn/pkcs11=2Ec b/sr=
c/openvpn/pkcs11=2Ec
index f00ba9b=2E=2E52658c2 100644
--- a/src/openvpn/pk=
cs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -504,6 +504,13 @@
         goto cl=
eanup;
     }
 
+    if (certificate_blob_size > PKCS11_MAX_CERT_SIZE)
+   =
 {
+        msg(M_WARN, "PKCS#11: Certificate too large: %zu bytes, maximum=
 is %zu",
+            certificate_blob_size, PKCS11_MAX_CERT_SIZE);
+     =
   goto cleanup;
+    }
+
     if ((certificate_blob =3D (unsigned char *)m=
alloc(certificate_blob_size)) =3D=3D NULL)
     {
         msg(M_FATAL, "PK=
CS#11: Cannot allocate memory");
diff --git a/src/openvpn/pkcs11_backend=2E=
h b/src/openvpn/pkcs11_backend=2Eh
index b8b0eb0=2E=2E972c3a2 100644
--- a/=
src/openvpn/pkcs11_backend=2Eh
+++ b/src/openvpn/pkcs11_backend=2Eh
@@ -37,=
6 +37,20 @@
 
 #include <pkcs11-helper-1=2E0/pkcs11h-certificate=2Eh>
 
+/*=

+ * Maximum size of a certificate retrieved from a PKCS #11 provider, so t=
hat
+ * the provider cannot crash OpenVPN by making it try to allocate 2^64=
 bytes=2E
+ * The maximum of 100=2E000 bytes is picked as a round number th=
at easily
+ * accomodates the currently standardized quantum-safe signature=
 algorithms=2E
+ * It is twice the size of a SLH-DSA (aka SPHINCS+) signatu=
re plus public key=2E
+ *
+ * However, there are additional digital signatu=
re schemes currently on the
+ * NIST on-ramp (e=2Eg=2E, some parameter sett=
ings for LESS) that have even larger
+ * public keys or signatures, so if t=
hose ever see use on smartcards, we will
+ * need to increase this number=
=2E
+ */
+#define PKCS11_MAX_CERT_SIZE ((size_t)100000)
+
 /**
  * Retrieve=
 PKCS #11 Certificate's DN in a printable format=2E
  *
diff --git a/src/op=
envpn/pkcs11_mbedtls=2Ec b/src/openvpn/pkcs11_mbedtls=2Ec
index 2183217=2E=
=2E3ee3837 100644
--- a/src/openvpn/pkcs11_mbedtls=2Ec
+++ b/src/openvpn/pk=
cs11_mbedtls=2Ec
@@ -42,16 +42,6 @@
 static bool
 pkcs11_get_x509_cert(pkcs=
11h_certificate_t pkcs11_cert, mbedtls_x509_crt *cert)
 {
-    /* We set a =
maximum size for certificates so that the PKCS provider cannot crash OpenVP=
N by
-     * making it try to allocate 2^64 bytes=2E The maximum of 100=2E0=
00 bytes is picked as a round
-     * number that easily accomodates the cu=
rrently standardized quantum-safe signature algorithms=2E
-     * It is twi=
ce the size of a SLH-DSA (aka SPHINCS+) signature plus public key=2E
-     =
*
-     * However, there are additional digital signature schemes currently=
 on the NIST on-ramp
-     * (e=2Eg=2E, some parameter settings for LESS) t=
hat have even larger public keys or signatures, so
-     * if those ever se=
e use on smartcards, we will need to increase this number=2E */
-    const =
size_t max_cert_size =3D 100000;
-
     unsigned char *cert_blob =3D NULL;
=
     size_t cert_blob_size =3D 0;
     bool ret =3D false;
@@ -62,9 +52,10 =
@@
         goto cleanup;
     }
 
-    if (cert_blob_size > max_cert_size)=

+    if (cert_blob_size > PKCS11_MAX_CERT_SIZE)
     {
-        msg(M_WARN=
, "PKCS#11: Certificate too large: %zu bytes, maximum is %zu", cert_blob_si=
ze, max_cert_size);
+        msg(M_WARN, "PKCS#11: Certificate too large: %=
zu bytes, maximum is %zu", cert_blob_size,
+            PKCS11_MAX_CERT_SIZ=
E);
         goto cleanup;
     }
 

-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2121?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
Gerrit-Chang=
e-Number: 2121
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=
=2Ede>

--SJgZaGxzJ2M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, R=C4=83zvan Cojocaru=2E <=
/p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #2</strong> to this =
change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review-1 by Gert Doering</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">pkcs11: bound=
 certificate size in pkcs11_management_id_get()<br><br>0a8e80aa (&quot;Avoi=
d unbounded allocations in pkcs11_mbedtls=2Ec&quot;) capped<br>the certific=
ate blob size reported by the PKCS#11 provider only in the<br>mbedTLS backe=
nd=2E pkcs11_management_id_get() still allocated whatever<br>size the provi=
der returned=2E Move the limit to pkcs11_backend=2Eh as<br>PKCS11_MAX_CERT_=
SIZE and check it there too=2E<br><br>Change-Id: Ia9f328b1c0ea29adf811a933d=
1fd22cb32e35e6d<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt;<br>---<br>M src/openvpn/pkcs11=2Ec<br>M src/openvpn/pkcs11_backend=2Eh=
<br>M src/openvpn/pkcs11_mbedtls=2Ec<br>3 files changed, 24 insertions(+), =
12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/21/2121/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</span><br><span>index f00ba9b=2E=2E52=
658c2 100644</span><br><span>--- a/src/openvpn/pkcs11=2Ec</span><br><span>+=
++ b/src/openvpn/pkcs11=2Ec</span><br><span>@@ -504,6 +504,13 @@</span><br>=
<span>         goto cleanup;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (certificate_blob_=
size &gt; PKCS11_MAX_CERT_SIZE)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(M_WARN, &quot;PKCS#11: Certificate too large: %zu bytes, maximum =
is %zu&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      certificate_blob_size, PKCS11_MAX_CERT_SIZE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto cleanup;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     if ((certificate_blob =3D (unsi=
gned char *)malloc(certificate_blob_size)) =3D=3D NULL)</span><br><span>   =
  {</span><br><span>         msg(M_FATAL, &quot;PKCS#11: Cannot allocate me=
mory&quot;);</span><br><span>diff --git a/src/openvpn/pkcs11_backend=2Eh b/=
src/openvpn/pkcs11_backend=2Eh</span><br><span>index b8b0eb0=2E=2E972c3a2 1=
00644</span><br><span>--- a/src/openvpn/pkcs11_backend=2Eh</span><br><span>=
+++ b/src/openvpn/pkcs11_backend=2Eh</span><br><span>@@ -37,6 +37,20 @@</sp=
an><br><span> </span><br><span> #include &lt;pkcs11-helper-1=2E0/pkcs11h-ce=
rtificate=2Eh&gt;</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Maximum size of a certificate retrieved from a PKCS #11 provider, so that=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the provider can=
not crash OpenVPN by making it try to allocate 2^64 bytes=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * The maximum of 100=2E000 bytes =
is picked as a round number that easily</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * accomodates the currently standardized quantum-safe =
signature algorithms=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * It is twice the size of a SLH-DSA (aka SPHINCS+) signature plus publ=
ic key=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * However, there are addit=
ional digital signature schemes currently on the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * NIST on-ramp (e=2Eg=2E, some parameter sett=
ings for LESS) that have even larger</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * public keys or signatures, so if those ever see use on =
smartcards, we will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * need to increase this number=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define PKCS11_MAX_CERT_SIZE ((size_t)100000)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Retrieve=
 PKCS #11 Certificate&#39;s DN in a printable format=2E</span><br><span>  *=
</span><br><span>diff --git a/src/openvpn/pkcs11_mbedtls=2Ec b/src/openvpn/=
pkcs11_mbedtls=2Ec</span><br><span>index 2183217=2E=2E3ee3837 100644</span>=
<br><span>--- a/src/openvpn/pkcs11_mbedtls=2Ec</span><br><span>+++ b/src/op=
envpn/pkcs11_mbedtls=2Ec</span><br><span>@@ -42,16 +42,6 @@</span><br><span=
> static bool</span><br><span> pkcs11_get_x509_cert(pkcs11h_certificate_t p=
kcs11_cert, mbedtls_x509_crt *cert)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* We set a maximum size for certifica=
tes so that the PKCS provider cannot crash OpenVPN by</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * making it try to allocate 2^64 bytes=
=2E The maximum of 100=2E000 bytes is picked as a round</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * number that easily accomodates the=
 currently standardized quantum-safe signature algorithms=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-     * It is twice the size of a SLH=
-DSA (aka SPHINCS+) signature plus public key=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     *</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     * However, there are additional digital signature schemes =
currently on the NIST on-ramp</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     * (e=2Eg=2E, some parameter settings for LESS) that have even =
larger public keys or signatures, so</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * if those ever see use on smartcards, we will need to =
increase this number=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const size_t max_cert_size =3D 100000;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     unsigned char *cert_blob =
=3D NULL;</span><br><span>     size_t cert_blob_size =3D 0;</span><br><span=
>     bool ret =3D false;</span><br><span>@@ -62,9 +52,10 @@</span><br><spa=
n>         goto cleanup;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (cert_blob_size &gt; max=
_cert_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
cert_blob_size &gt; PKCS11_MAX_CERT_SIZE)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;PKCS#1=
1: Certificate too large: %zu bytes, maximum is %zu&quot;, cert_blob_size, =
max_cert_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_WARN, &quot;PKCS#11: Certificate too large: %zu bytes, maximum is=
 %zu&quot;, cert_blob_size,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            PKCS11_MAX_CERT_SIZE);</span><br><span>         goto cl=
eanup;</span><br><span>     }</span><br></pre><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail">change 2121</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2121 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;=
openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--SJgZaGxzJ2M=--


--===============0882213074021187675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0882213074021187675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0882213074021187675==--

