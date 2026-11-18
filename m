Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAC0606A325
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DUJkvHc1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dgyYGyao;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D/qs1P3O;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cnlYcTt3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4Kj3sjjkcRMpRJg3GKTuRzFM4OjJiZ2he5U4vs0kRHk=; b=DUJkvHc1fLMyvXJcAUrJIpwwmv
	7JZB8RTsIByEv7pIFXBwTSsVmje0mJStiwGrttaImLuZiofjx+1p41LhrciLuwqFXfvjs7w77EGvZ
	wzPArmzgPvWTDG4jONMsilIMEQd8JIc961sIJJ0v6algxdkcPlU0LiBsN1Os8RqYjz5A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTgiV-000000003nn-2ozH;
	Wed, 18 Nov 2026 14:32:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTgiU-000000003ng-1aZx
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:32:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZjKMC5UdwrfjqhvCSra55F8nhWlya3Qv0XA8Xutufkw=; b=dgyYGyao5bIk4a1MVN3vp9NmsS
 f2GlaGwaUr/X6PGBNOnVvCrDP8ahpOxI0FYkb7nKWfrKWufaox6iGk4To1cbx+1d2s3d+zCo1dgIv
 4ZcqcYmGFW9SDBpwygiM2PIGp/ADEXClSk6QMXi2rJmVcEUsW1wWhmmt0Sy/2I8MfMzs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZjKMC5UdwrfjqhvCSra55F8nhWlya3Qv0XA8Xutufkw=; b=D/qs1P3O6zLis7B6eUNliu2c5b
 UaM2sRrUjAmnnOVVKjjSqGxXwV2ykjFWFABCP7wF1dfNOJDr7G+u829bj80vcLSuc7TjngbxIHDWa
 XjG4fXVjauCqLyKfMpDPIqyH9HZAnXeWa99UXVSSL6rXmfLHd+agFuRTRrhOoeWipaJc=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTgiS-000000000s6-1iDl for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:32:54 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so617858f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 06:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795012366; x=1795617166; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZjKMC5UdwrfjqhvCSra55F8nhWlya3Qv0XA8Xutufkw=;
 b=cnlYcTt3SmoFv9s+lE0IuO4iQ0EIjf1QIWj0G6diKcEgre1frXDCmv0lnZ07diBEmN
 C6rg3zNm+YO/5ltx5b3U3UnkI8xg6XpplDcC/nmFvzo4Y/EjhPTa/uUAS6n3+ErBYl1h
 9oejQKiOU/8++96vFtBKFiaKqQnRqx1cq/gm5G4HUG6Kt7QYD68XjavGI/DBtc7n4Qb8
 nGTXZkdY6y2Uu7QkR1EUZnMhx+td7TEznRTS0nFjoWLvY6mZ3KrVybb/riog+5CczLb2
 +6AXEdWB0tnEs58CyrWIcUUX7pY9iF9DgHaMetwdeIbYmFYNrCzB3emqKpBGnLOlj615
 aG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795012366; x=1795617166;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZjKMC5UdwrfjqhvCSra55F8nhWlya3Qv0XA8Xutufkw=;
 b=rikAYuf2NP1wOusRV7rT6KVTaaNpkbfaBDD1BVo/oBRnqFZ9iurl4fKoo7n+DpjWpx
 pG3F4BcBLcnwTEa3fQsRMNNTejDm9vtISNwdLXpVmsxEaxw3k8U5L3HPv0+NFfGlwtzQ
 LNKCmcZtQXijvbq0Y6CfTkLKntG47Ta4Xwz9YOit0TRWVl/QVw/e+JgPDv2SLyRW9JQh
 mSJEO6lOCoQ9UDtGhyCWsTy3f6D+9Xuz0VJlwoO2ZDeArt/j1WCS5Jh19vYPYZ6vhG9U
 /Wm0REHWmXMx0JDrWcQ+AupQIIbU7P6p+RrPSPkB+Y068422fKl6TuKQN4WFAwkGdJJ+
 LSuw==
X-Gm-Message-State: APuU4Z8dGUX5Sc4xzK6HnhOtR2OXjKuaWRoYf9Q4xcuep5xXVrtPtdVw
 EojIFe1yN+XurUQkv2hg2gJrc+SalKMidFteoxEaa2x9ND/qxh7DO7whi/b2pAAKF0I6LQUoDUp
 KpSeuIvrhEkGq08D8pa2b6XpqmEpw3OncFxvWKgtlSZzzXLSHSe5BW8dIRquqRD4iIzMICNTY9H
 IxjomlfA==
X-Gm-Gg: AZFdTZd5LMESraJYJUXoufX3AUquxU7/dt75cFYLMgGbo7GWVFjaKXm78XI76Zzh27q
 53fi/zHP9GTjTI60ZXXwPeI30efo3sk/kynhXbXdl9RisiXZLIBEua7y3K3B2tNgXfQguoCIZnC
 hXUTo1Sr9p3yt9DxeTAEZG7Ws0Ex5das2pC1Eti/0uESBnOMw6sTJfOWDA7A/q7WlzCbbyBxrHE
 mfEy60cwUQ5a9Oij9lmwY8L7CDT0R5e/7azwsNArmmrJAxBYbqTN8P0Fde+84um2jsGG8Ri3MHP
 k/xsIfI/VZ68cqisFmp5Jlenas2bGHceUCX/JFvWHPFGQOUw9Jj1wwMc7Zh2Pq+CysR5PVi6OsV
 GxpRyLnli2yfRFK6yvWuAeWRIEBi64ThlsNBIX7Pk9b7mPsblPZz1xTIt0c+YKxvLBLT3NnMKA0
 OWIaWqLQHESoH6bZZQiglzKHsRx8NJJja188SNmK6w3utr/mUrilBYtXe8g9QXuWtTI3caiA82w
 ftTYaEeIM/mu5K+PNAjaqiE6GTKLHUye2FkFnnqWTtAeDyfV/3lr7B/0BALXsfn8eUr5HqaNxHZ
 cdVwq8St8N7dlQH4t0losPP9luZ9zNTEoWtgeDA0p4LmWk7HSep8nG+hWEQFiguWf/NsH+QVkm1
 qVD6BD0SAd1ZdK7gmjrlYFgBCtOir4zY7WA2zQ+dsfmFnj45kX0tcfJfXj0652YPY/Tjn7p5TXg
 lhuUWQrBrpz5TlMLU=
X-Received: by 2002:a05:6000:2286:b0:4a6:bc53:246c with SMTP id
 ffacd0b85a97d-4a6bc626a8cmr4292431f8f.42.1795012365559; 
 Wed, 18 Nov 2026 06:32:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a656c11643sm4924158f8f.49.2026.11.18.06.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:32:45 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 14:32:44 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
X-Gerrit-Change-Number: 2121
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2121?usp=email>
X-Gerrit-Commit: a293b646c569ebcece8ba56d001c01af18b09bde
In-Reply-To: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
References: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc3OTI2MDAwLklhOWYzMjhiMWMwZWEyOWFkZjgxMWE5MzNkMWZkMjJjYjMyZTM1ZTZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <756f7d364fadb9e17c6f533ae813753f57579e57-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTgiS-000000000s6-1iDl
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1689238273713113117=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1689238273713113117==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x4qqKgRY054="; charset=UTF-8

--x4qqKgRY054=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2121?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: pkcs11: bound certificate=
 size in pkcs11_management_id_get()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

pkcs11: bound certificate size in pkcs11_management_=
id_get()

0a8e80aa ("Avoid unbounded allocations in pkcs11_mbedtls=2Ec") ca=
pped
the certificate blob size reported by the PKCS#11 provider only in the=

mbedTLS backend=2E pkcs11_management_id_get() still allocated whatever
siz=
e the provider returned=2E Move the limit to pkcs11_backend=2Eh as
PKCS11_M=
AX_CERT_SIZE and check it there too=2E

Change-Id: Ia9f328b1c0ea29adf811a93=
3d1fd22cb32e35e6d
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Ac=
ked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2121
Message-Id: <20261117183203=2E18936-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg41583=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/pkcs11=2Ec
M src/openvpn/pkcs11_backe=
nd=2Eh
M src/openvpn/pkcs11_mbedtls=2Ec
3 files changed, 24 insertions(+), =
12 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/21/2121/4

diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs=
11=2Ec
index b4bed12=2E=2E3610224 100644
--- a/src/openvpn/pkcs11=2Ec
+++ b=
/src/openvpn/pkcs11=2Ec
@@ -509,6 +509,13 @@
         goto cleanup;
     }
=
 
+    if (certificate_blob_size > PKCS11_MAX_CERT_SIZE)
+    {
+        ms=
g(M_WARN, "PKCS#11: Certificate too large: %zu bytes, maximum is %zu",
+   =
         certificate_blob_size, PKCS11_MAX_CERT_SIZE);
+        goto cleanu=
p;
+    }
+
     if ((certificate_blob =3D (unsigned char *)malloc(certific=
ate_blob_size)) =3D=3D NULL)
     {
         msg(M_FATAL, "PKCS#11: Cannot =
allocate memory");
diff --git a/src/openvpn/pkcs11_backend=2Eh b/src/openvp=
n/pkcs11_backend=2Eh
index b8b0eb0=2E=2E972c3a2 100644
--- a/src/openvpn/pk=
cs11_backend=2Eh
+++ b/src/openvpn/pkcs11_backend=2Eh
@@ -37,6 +37,20 @@
 
=
 #include <pkcs11-helper-1=2E0/pkcs11h-certificate=2Eh>
 
+/*
+ * Maximum s=
ize of a certificate retrieved from a PKCS #11 provider, so that
+ * the pr=
ovider cannot crash OpenVPN by making it try to allocate 2^64 bytes=2E
+ * =
The maximum of 100=2E000 bytes is picked as a round number that easily
+ * =
accomodates the currently standardized quantum-safe signature algorithms=2E=

+ * It is twice the size of a SLH-DSA (aka SPHINCS+) signature plus public=
 key=2E
+ *
+ * However, there are additional digital signature schemes cur=
rently on the
+ * NIST on-ramp (e=2Eg=2E, some parameter settings for LESS)=
 that have even larger
+ * public keys or signatures, so if those ever see =
use on smartcards, we will
+ * need to increase this number=2E
+ */
+#defin=
e PKCS11_MAX_CERT_SIZE ((size_t)100000)
+
 /**
  * Retrieve PKCS #11 Certif=
icate's DN in a printable format=2E
  *
diff --git a/src/openvpn/pkcs11_mbe=
dtls=2Ec b/src/openvpn/pkcs11_mbedtls=2Ec
index 2183217=2E=2E3ee3837 100644=

--- a/src/openvpn/pkcs11_mbedtls=2Ec
+++ b/src/openvpn/pkcs11_mbedtls=2Ec
=
@@ -42,16 +42,6 @@
 static bool
 pkcs11_get_x509_cert(pkcs11h_certificate_t=
 pkcs11_cert, mbedtls_x509_crt *cert)
 {
-    /* We set a maximum size for =
certificates so that the PKCS provider cannot crash OpenVPN by
-     * maki=
ng it try to allocate 2^64 bytes=2E The maximum of 100=2E000 bytes is picke=
d as a round
-     * number that easily accomodates the currently standardi=
zed quantum-safe signature algorithms=2E
-     * It is twice the size of a =
SLH-DSA (aka SPHINCS+) signature plus public key=2E
-     *
-     * However=
, there are additional digital signature schemes currently on the NIST on-r=
amp
-     * (e=2Eg=2E, some parameter settings for LESS) that have even lar=
ger public keys or signatures, so
-     * if those ever see use on smartcar=
ds, we will need to increase this number=2E */
-    const size_t max_cert_s=
ize =3D 100000;
-
     unsigned char *cert_blob =3D NULL;
     size_t cert_=
blob_size =3D 0;
     bool ret =3D false;
@@ -62,9 +52,10 @@
         goto =
cleanup;
     }
 
-    if (cert_blob_size > max_cert_size)
+    if (cert_bl=
ob_size > PKCS11_MAX_CERT_SIZE)
     {
-        msg(M_WARN, "PKCS#11: Certi=
ficate too large: %zu bytes, maximum is %zu", cert_blob_size, max_cert_size=
);
+        msg(M_WARN, "PKCS#11: Certificate too large: %zu bytes, maximum=
 is %zu", cert_blob_size,
+            PKCS11_MAX_CERT_SIZE);
         goto=
 cleanup;
     }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2121?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
Gerrit-Change-Number: 2121
Ge=
rrit-PatchSet: 4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--x4qqKgRY054=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2121?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">pkc=
s11: bound certificate size in pkcs11_management_id_get()<br><br>0a8e80aa (=
&quot;Avoid unbounded allocations in pkcs11_mbedtls=2Ec&quot;) capped<br>th=
e certificate blob size reported by the PKCS#11 provider only in the<br>mbe=
dTLS backend=2E pkcs11_management_id_get() still allocated whatever<br>size=
 the provider returned=2E Move the limit to pkcs11_backend=2Eh as<br>PKCS11=
_MAX_CERT_SIZE and check it there too=2E<br><br>Change-Id: Ia9f328b1c0ea29a=
df811a933d1fd22cb32e35e6d<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121<br>Message-Id:=
 &lt;20261117183203=2E18936-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41583=2E=
html<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<=
br>M src/openvpn/pkcs11=2Ec<br>M src/openvpn/pkcs11_backend=2Eh<br>M src/op=
envpn/pkcs11_mbedtls=2Ec<br>3 files changed, 24 insertions(+), 12 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/21/2121/4</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/pkcs11=2Ec =
b/src/openvpn/pkcs11=2Ec</span><br><span>index b4bed12=2E=2E3610224 100644<=
/span><br><span>--- a/src/openvpn/pkcs11=2Ec</span><br><span>+++ b/src/open=
vpn/pkcs11=2Ec</span><br><span>@@ -509,6 +509,13 @@</span><br><span>       =
  goto cleanup;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (certificate_blob_size &gt; PKC=
S11_MAX_CERT_SIZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_W=
ARN, &quot;PKCS#11: Certificate too large: %zu bytes, maximum is %zu&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            certifi=
cate_blob_size, PKCS11_MAX_CERT_SIZE);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        goto cleanup;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     if ((certificate_blob =3D (unsigned char *)mal=
loc(certificate_blob_size)) =3D=3D NULL)</span><br><span>     {</span><br><=
span>         msg(M_FATAL, &quot;PKCS#11: Cannot allocate memory&quot;);</s=
pan><br><span>diff --git a/src/openvpn/pkcs11_backend=2Eh b/src/openvpn/pkc=
s11_backend=2Eh</span><br><span>index b8b0eb0=2E=2E972c3a2 100644</span><br=
><span>--- a/src/openvpn/pkcs11_backend=2Eh</span><br><span>+++ b/src/openv=
pn/pkcs11_backend=2Eh</span><br><span>@@ -37,6 +37,20 @@</span><br><span> <=
/span><br><span> #include &lt;pkcs11-helper-1=2E0/pkcs11h-certificate=2Eh&g=
t;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Maximum size =
of a certificate retrieved from a PKCS #11 provider, so that</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * the provider cannot crash OpenV=
PN by making it try to allocate 2^64 bytes=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * The maximum of 100=2E000 bytes is picked as a =
round number that easily</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * accomodates the currently standardized quantum-safe signature algor=
ithms=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * It is tw=
ice the size of a SLH-DSA (aka SPHINCS+) signature plus public key=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * However, there are additional digital =
signature schemes currently on the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * NIST on-ramp (e=2Eg=2E, some parameter settings for LESS)=
 that have even larger</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * public keys or signatures, so if those ever see use on smartcards, we=
 will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * need to inc=
rease this number=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PKCS11_=
MAX_CERT_SIZE ((size_t)100000)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> /**</span><br><span>  * Retrieve PKCS #11 Cert=
ificate&#39;s DN in a printable format=2E</span><br><span>  *</span><br><sp=
an>diff --git a/src/openvpn/pkcs11_mbedtls=2Ec b/src/openvpn/pkcs11_mbedtls=
=2Ec</span><br><span>index 2183217=2E=2E3ee3837 100644</span><br><span>--- =
a/src/openvpn/pkcs11_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/pkcs11_m=
bedtls=2Ec</span><br><span>@@ -42,16 +42,6 @@</span><br><span> static bool<=
/span><br><span> pkcs11_get_x509_cert(pkcs11h_certificate_t pkcs11_cert, mb=
edtls_x509_crt *cert)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /* We set a maximum size for certificates so that th=
e PKCS provider cannot crash OpenVPN by</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * making it try to allocate 2^64 bytes=2E The maximu=
m of 100=2E000 bytes is picked as a round</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     * number that easily accomodates the currently sta=
ndardized quantum-safe signature algorithms=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-     * It is twice the size of a SLH-DSA (aka SPHI=
NCS+) signature plus public key=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-     *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * However, there are additional digital signature schemes currently on t=
he NIST on-ramp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
 (e=2Eg=2E, some parameter settings for LESS) that have even larger public =
keys or signatures, so</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     * if those ever see use on smartcards, we will need to increase this =
number=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 size_t max_cert_size =3D 100000;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>     unsigned char *cert_blob =3D NULL;</span>=
<br><span>     size_t cert_blob_size =3D 0;</span><br><span>     bool ret =
=3D false;</span><br><span>@@ -62,9 +52,10 @@</span><br><span>         goto=
 cleanup;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (cert_blob_size &gt; max_cert_size)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cert_blob_size =
&gt; PKCS11_MAX_CERT_SIZE)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;PKCS#11: Certificate =
too large: %zu bytes, maximum is %zu&quot;, cert_blob_size, max_cert_size);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN,=
 &quot;PKCS#11: Certificate too large: %zu bytes, maximum is %zu&quot;, cer=
t_blob_size,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     PKCS11_MAX_CERT_SIZE);</span><br><span>         goto cleanup;</span><b=
r><span>     }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail">change 2121</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia9f328b1c0ea29a=
df811a933d1fd22cb32e35e6d </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2121 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>=

<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--x4qqKgRY054=--


--===============1689238273713113117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1689238273713113117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1689238273713113117==--

