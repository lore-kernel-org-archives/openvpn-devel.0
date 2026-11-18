Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BE3606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=luPv8gsZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BtJcbHvz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OaKscLsV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RCX+R4lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DHgmb9Xz1ptm+7YQZsDych+GbqtKSrb2T/nTjUwf/y4=; b=luPv8gsZjualmw6jEIGc6hHEYS
	ZFY4SGkZOjpg1edfuejhkXK/JGqajChvJModERQgqSZPXe1bSzCaKH1f+Uv+th2kqK76oBPCikMkK
	Fx1isa/hYaYW4iZrsy/GVfvoz6tAFgJEL60XQX3xlZqZa50ZUSQH68+P7tcxF0ThQnBA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTgiY-0000000071T-1UIS;
	Wed, 18 Nov 2026 14:32:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTgiW-0000000071H-3iJ9
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:32:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s1hi/iwmV+wCjexRVzk7Em0MkzqU6Qg4pmi5zKR3jEY=; b=BtJcbHvzhd5+/An+igHOtsbv8P
 9Q5DGVssdXADBYbxwq+zwddtQMrTIeiAcndY3uLXvB8mgX96eYarzxv6d1+E/y6hGV3yN8Hm5cb9z
 g3kpbaMjFGov2QKuaX+O9nzdJ48btwnqh9gyaQ2vIAhImA1bEb+RSrvgwiFxCFQTHvPE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s1hi/iwmV+wCjexRVzk7Em0MkzqU6Qg4pmi5zKR3jEY=; b=OaKscLsVb4HGL4+p7z8rrNBhhf
 6RDS8eS4Qbj/I/OBe82a4ve7cm1IvMu5yyfMsyiu6ZVYqwLO++u3Or+9c9ZGOxjxSyE7EmWp4uGC5
 QTTeE8IXAU0luCu/XBN6uelITesdWh1Mi7qtGKMid+JrU/vgrfw/3TiknHZ0CvXTNV0o=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTgiT-000000002uG-1eh6 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:32:56 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so11185465e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795012367; x=1795617167; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=s1hi/iwmV+wCjexRVzk7Em0MkzqU6Qg4pmi5zKR3jEY=;
 b=RCX+R4lt813AkRMrmcaDN2tAWf9VfNBRPsjcgQJf4DZx7dxY6DCesHY5jXJJnPdXKw
 pffjs5EuTv370VbquL9YYSv/Nf7D49buk0SCL21cwX6ZSghDgW0rfDQPVSlRIGfhZKIm
 Q37klOMvHYODMjsiB+Y0D8Uuf1nCgG/oaH2GpdneUdVRUzUaxBjA42yRIZoxLiZRwOlI
 HVG2MdKHTYaNcRCCVRpwEEK7y1Qnbb6eFvCihevgAhbLBSm+1tTu4kHcddh4MhZsD9dB
 1sxpTkMY9LPnpHhQ6LuHpHOgk4eLgqSGzDiqyfY8MmwT8l1XQrl0XyMwApiLnM2SjccD
 8jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795012367; x=1795617167;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=s1hi/iwmV+wCjexRVzk7Em0MkzqU6Qg4pmi5zKR3jEY=;
 b=1Delmne+aYvLgl3QxYgYzePb0ymLSrXNKbJLcjqwIv0zsqddRXOBSO6Nm735yc1bSJ
 7ftOT6L+r7XL/utym52lySrrG9NMKTK9lxokwnYtJsKEJxr1WN5xNJBQXbeh/raw/afN
 fPDsSRfClsovtxbyWbx/U+IEtWj2iU8nPnOBloI0XrnPvmZDNPF4hZ8fvUsoNd5P24Yd
 /6yycVm5Yg5ifO4iWmKlp+lSuW0VmzmyRe6aUUjfz2JP8jAsgi32R0bMPHMZVGeH6I0J
 igcn2yMN0muwpo2ToBGU+WnlyRiBIX+9vsLlu87VWlXgNygQQ1CVZavljxiYkWdro4o8
 970g==
X-Forwarded-Encrypted: i=1;
 AL+hErH98u9omuY/hTHnyJlJR+VGbL2IiN6PL3FIzrzslTzs9zEy14mmXOOUQVl4Vg2zSanhLmKIHDgFwgnwCTkP@lists.sourceforge.net
X-Gm-Message-State: APuU4Z83SVgSmMTDhyZWBi05LeZnhu3duKvvSQ8Q6/3kWdZayYs+9Xtu
 c5CkEcSmtWaSNBftzg0CvWh855sIyRI+YWMIQ5nfiToRe4jD69lDypbAsKeYyw9yIZdv6JthXdI
 q+tnHELagElH2SuqpKY6zei0SPRVWRO6813cdbmPU29wUUKWqCuk6PxWZU+XOIGmkj1ko
X-Gm-Gg: AYBFou1S0DF6mYe1gn4SAvv+zk1ozQ1NcQMC5jNq39XimIRBSy4NaA9yYLjF86V6nkb
 jDmX/oq5Kpr1mIcqd7VD2S4uJUqmPMJx4zfIiJKRMARs0hxV8ZGuQy4ffcPb5PlLHFjIfPruFuV
 GGUoUHKb042fnYtibsBsSAiS3/unlLSSKzUKjGoQdQlCn6Hsb75Nl4qpq+erUL/mUcAbcyH/CuS
 wumD60Ztc9+e7NAYDXKYt1DBKs9Kh+GB9wUMhtURKD1Zyyek29ZkZAAqMvP9pXC+FVZsv/HpH3v
 Ilp8lwdREX+e1IH5aYRojO+i9dLoD14nbv0LhkvPVnRoNjVnFH7EdAoP5rHibnHiVJR6RM4U54e
 zKFBJ7e+FlZ4vrCtEIC0iRR7K5Dq4vxcLLRXzS1ucp1VU5WZJrsBQ21iY06MU19R5g5OlHaA+P0
 ECPOgBKakXZDCxhkqb7oEMaDcYxUJapKECCzXcgVc5tf+9EZgccXEoUPOAUAx64v2mlRt/f6Yif
 uczVgHuVD8VqhjKCqs6bWUJOR2cMppxgUCEPSvCjdqqSdMn7E/lvYi1xfC/CVhXEMPaSiHpmXUX
 Hh4DhAjQFO3V3fNwJYbOsONFqIJgPqOl4SMQJaTZ7QYvja33CWPrpblsWSiiaB4U/Q11AskwiBr
 SUDhaVwEDzuzEj5iejbBXQlK849SuCvhJK5KdUKLEQL0zf6xMaFeNgvaC1bFiS1eO+rxkS8lItO
 Lz6PADDnmZ7cd/tO11YhsA1+IHR5UNkqAhj4hl
X-Received: by 2002:a05:600c:3ba1:b0:4bb:5f3b:25a9 with SMTP id
 5b1f17b1804b1-4bb7da445a0mr59181025e9.30.1795012366418; 
 Wed, 18 Nov 2026 06:32:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e57664esm31064345e9.1.2026.11.18.06.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:32:46 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 14:32:45 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
X-Gerrit-Change-Number: 2121
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2121?usp=email>
X-Gerrit-Commit: a293b646c569ebcece8ba56d001c01af18b09bde
In-Reply-To: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
References: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc3OTI2MDAwLklhOWYzMjhiMWMwZWEyOWFkZjgxMWE5MzNkMWZkMjJjYjMyZTM1ZTZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <756f7d364fadb9e17c6f533ae813753f57579e57-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTgiT-000000002uG-1eh6
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5941298892480755900=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5941298892480755900==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H2InRSdiq/g="; charset=UTF-8

--H2InRSdiq/g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2121?usp=3Demail )

Change subject: pkcs11: bound certificate s=
ize in pkcs11_management_id_get()
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




diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs1=
1=2Ec
index b4bed12=2E=2E3610224 100644
--- a/src/openvpn/pkcs11=2Ec
+++ b/=
src/openvpn/pkcs11=2Ec
@@ -509,6 +509,13 @@
         goto cleanup;
     }
 =

+    if (certificate_blob_size > PKCS11_MAX_CERT_SIZE)
+    {
+        msg=
(M_WARN, "PKCS#11: Certificate too large: %zu bytes, maximum is %zu",
+    =
        certificate_blob_size, PKCS11_MAX_CERT_SIZE);
+        goto cleanup=
;
+    }
+
     if ((certificate_blob =3D (unsigned char *)malloc(certifica=
te_blob_size)) =3D=3D NULL)
     {
         msg(M_FATAL, "PKCS#11: Cannot a=
llocate memory");
diff --git a/src/openvpn/pkcs11_backend=2Eh b/src/openvpn=
/pkcs11_backend=2Eh
index b8b0eb0=2E=2E972c3a2 100644
--- a/src/openvpn/pkc=
s11_backend=2Eh
+++ b/src/openvpn/pkcs11_backend=2Eh
@@ -37,6 +37,20 @@
 
 =
#include <pkcs11-helper-1=2E0/pkcs11h-certificate=2Eh>
 
+/*
+ * Maximum si=
ze of a certificate retrieved from a PKCS #11 provider, so that
+ * the pro=
vider cannot crash OpenVPN by making it try to allocate 2^64 bytes=2E
+ * T=
he maximum of 100=2E000 bytes is picked as a round number that easily
+ * a=
ccomodates the currently standardized quantum-safe signature algorithms=2E
=
+ * It is twice the size of a SLH-DSA (aka SPHINCS+) signature plus public =
key=2E
+ *
+ * However, there are additional digital signature schemes curr=
ently on the
+ * NIST on-ramp (e=2Eg=2E, some parameter settings for LESS) =
that have even larger
+ * public keys or signatures, so if those ever see u=
se on smartcards, we will
+ * need to increase this number=2E
+ */
+#define=
 PKCS11_MAX_CERT_SIZE ((size_t)100000)
+
 /**
  * Retrieve PKCS #11 Certifi=
cate's DN in a printable format=2E
  *
diff --git a/src/openvpn/pkcs11_mbed=
tls=2Ec b/src/openvpn/pkcs11_mbedtls=2Ec
index 2183217=2E=2E3ee3837 100644
=
--- a/src/openvpn/pkcs11_mbedtls=2Ec
+++ b/src/openvpn/pkcs11_mbedtls=2Ec
@=
@ -42,16 +42,6 @@
 static bool
 pkcs11_get_x509_cert(pkcs11h_certificate_t =
pkcs11_cert, mbedtls_x509_crt *cert)
 {
-    /* We set a maximum size for c=
ertificates so that the PKCS provider cannot crash OpenVPN by
-     * makin=
g it try to allocate 2^64 bytes=2E The maximum of 100=2E000 bytes is picked=
 as a round
-     * number that easily accomodates the currently standardiz=
ed quantum-safe signature algorithms=2E
-     * It is twice the size of a S=
LH-DSA (aka SPHINCS+) signature plus public key=2E
-     *
-     * However,=
 there are additional digital signature schemes currently on the NIST on-ra=
mp
-     * (e=2Eg=2E, some parameter settings for LESS) that have even larg=
er public keys or signatures, so
-     * if those ever see use on smartcard=
s, we will need to increase this number=2E */
-    const size_t max_cert_si=
ze =3D 100000;
-
     unsigned char *cert_blob =3D NULL;
     size_t cert_b=
lob_size =3D 0;
     bool ret =3D false;
@@ -62,9 +52,10 @@
         goto c=
leanup;
     }
 
-    if (cert_blob_size > max_cert_size)
+    if (cert_blo=
b_size > PKCS11_MAX_CERT_SIZE)
     {
-        msg(M_WARN, "PKCS#11: Certif=
icate too large: %zu bytes, maximum is %zu", cert_blob_size, max_cert_size)=
;
+        msg(M_WARN, "PKCS#11: Certificate too large: %zu bytes, maximum =
is %zu", cert_blob_size,
+            PKCS11_MAX_CERT_SIZE);
         goto =
cleanup;
     }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2121?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia=
9f328b1c0ea29adf811a933d1fd22cb32e35e6d
Gerrit-Change-Number: 2121
Gerrit-P=
atchSet: 4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

--H2InRSdiq/g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2121?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">pkcs11: bound certificate size in =
pkcs11_management_id_get()<br><br>0a8e80aa (&quot;Avoid unbounded allocatio=
ns in pkcs11_mbedtls=2Ec&quot;) capped<br>the certificate blob size reporte=
d by the PKCS#11 provider only in the<br>mbedTLS backend=2E pkcs11_manageme=
nt_id_get() still allocated whatever<br>size the provider returned=2E Move =
the limit to pkcs11_backend=2Eh as<br>PKCS11_MAX_CERT_SIZE and check it the=
re too=2E<br><br>Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d<br>Si=
gned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2121<br>Message-Id: &lt;20261117183203=2E18936-1-g=
ert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg41583=2Ehtml<br>Signed-off-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/pkcs11=2Ec<br>=
M src/openvpn/pkcs11_backend=2Eh<br>M src/openvpn/pkcs11_mbedtls=2Ec<br>3 f=
iles changed, 24 insertions(+), 12 deletions(-)<br><br></pre>
<pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</span><br><span>index b4=
bed12=2E=2E3610224 100644</span><br><span>--- a/src/openvpn/pkcs11=2Ec</spa=
n><br><span>+++ b/src/openvpn/pkcs11=2Ec</span><br><span>@@ -509,6 +509,13 =
@@</span><br><span>         goto cleanup;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cert=
ificate_blob_size &gt; PKCS11_MAX_CERT_SIZE)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        msg(M_WARN, &quot;PKCS#11: Certificate too large: %zu by=
tes, maximum is %zu&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            certificate_blob_size, PKCS11_MAX_CERT_SIZE);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        goto cleanup;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if ((certificate_bl=
ob =3D (unsigned char *)malloc(certificate_blob_size)) =3D=3D NULL)</span><=
br><span>     {</span><br><span>         msg(M_FATAL, &quot;PKCS#11: Cannot=
 allocate memory&quot;);</span><br><span>diff --git a/src/openvpn/pkcs11_ba=
ckend=2Eh b/src/openvpn/pkcs11_backend=2Eh</span><br><span>index b8b0eb0=2E=
=2E972c3a2 100644</span><br><span>--- a/src/openvpn/pkcs11_backend=2Eh</spa=
n><br><span>+++ b/src/openvpn/pkcs11_backend=2Eh</span><br><span>@@ -37,6 +=
37,20 @@</span><br><span> </span><br><span> #include &lt;pkcs11-helper-1=2E=
0/pkcs11h-certificate=2Eh&gt;</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Maximum size of a certificate retrieved from a PKCS #11 provi=
der, so that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the =
provider cannot crash OpenVPN by making it try to allocate 2^64 bytes=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The maximum of 100=
=2E000 bytes is picked as a round number that easily</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * accomodates the currently standardized=
 quantum-safe signature algorithms=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * It is twice the size of a SLH-DSA (aka SPHINCS+) signa=
ture plus public key=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * However, t=
here are additional digital signature schemes currently on the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * NIST on-ramp (e=2Eg=2E, some =
parameter settings for LESS) that have even larger</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * public keys or signatures, so if those ev=
er see use on smartcards, we will</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * need to increase this number=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define PKCS11_MAX_CERT_SIZE ((size_t)100000)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><spa=
n>  * Retrieve PKCS #11 Certificate&#39;s DN in a printable format=2E</span=
><br><span>  *</span><br><span>diff --git a/src/openvpn/pkcs11_mbedtls=2Ec =
b/src/openvpn/pkcs11_mbedtls=2Ec</span><br><span>index 2183217=2E=2E3ee3837=
 100644</span><br><span>--- a/src/openvpn/pkcs11_mbedtls=2Ec</span><br><spa=
n>+++ b/src/openvpn/pkcs11_mbedtls=2Ec</span><br><span>@@ -42,16 +42,6 @@</=
span><br><span> static bool</span><br><span> pkcs11_get_x509_cert(pkcs11h_c=
ertificate_t pkcs11_cert, mbedtls_x509_crt *cert)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* We set a maximum size=
 for certificates so that the PKCS provider cannot crash OpenVPN by</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-     * making it try to alloc=
ate 2^64 bytes=2E The maximum of 100=2E000 bytes is picked as a round</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-     * number that easily a=
ccomodates the currently standardized quantum-safe signature algorithms=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * It is twice the=
 size of a SLH-DSA (aka SPHINCS+) signature plus public key=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     * However, there are additional digital sign=
ature schemes currently on the NIST on-ramp</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     * (e=2Eg=2E, some parameter settings for LESS) t=
hat have even larger public keys or signatures, so</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     * if those ever see use on smartcards, we=
 will need to increase this number=2E */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const size_t max_cert_size =3D 100000;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     unsigned char=
 *cert_blob =3D NULL;</span><br><span>     size_t cert_blob_size =3D 0;</sp=
an><br><span>     bool ret =3D false;</span><br><span>@@ -62,9 +52,10 @@</s=
pan><br><span>         goto cleanup;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (cert_blob_s=
ize &gt; max_cert_size)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (cert_blob_size &gt; PKCS11_MAX_CERT_SIZE)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, =
&quot;PKCS#11: Certificate too large: %zu bytes, maximum is %zu&quot;, cert=
_blob_size, max_cert_size);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_WARN, &quot;PKCS#11: Certificate too large: %zu bytes=
, maximum is %zu&quot;, cert_blob_size,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            PKCS11_MAX_CERT_SIZE);</span><br><span>    =
     goto cleanup;</span><br><span>     }</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail">ch=
ange 2121</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 2121 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--H2InRSdiq/g=--


--===============5941298892480755900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5941298892480755900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5941298892480755900==--

