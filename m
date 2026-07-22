Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F86C44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=QX25wj872Gan6wwskoIIoiAnKiX2NIth79S+2U+RapY=; b=M0udSThYna8r+K
	Ro44uDnUSEDMkDQCUg+p5CKTavB07rBnAf2+8+cb0QU2I2QvvSdhPdCaAdwQjCn4BqvkBLIoVaXhz
	qBjJT29f7wfUZ98iQjwlRBMq1z2T+7OBqL1Q3ZwY5v7xnGhK7QA4wM+p6fwqPs2Z5jolU8BAXuaw9
	JpE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmWRh-0001c8-0Q;
	Wed, 22 Jul 2026 12:53:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmWRf-0001c2-Dc
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 12:53:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7fZK9//xY580irca23haVYnd82ZkkGxtEQtH0kIuRdg=; b=bu9P2UguplEBlZy7+8o+mJSzig
 hgZbgBdfvQgfDMuVlP1m7BX69UW0axbTivhGFZYzEEG3RnMFDG0XPzbjw86jGDlKHF2v2cybyJ1b8
 6wDz5YatDUtoR6V2uv8eXd6m8soKfZ6oCJVz8INvCziKRLAqA9gIS1cXphZ63WnK80RY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7fZK9//xY580irca23haVYnd82ZkkGxtEQtH0kIuRdg=; b=d
 J8H7iKnN/+z/4sJQ3DxQlFNuMl1wzt2ShyQEIKLgeZDfIWpI+q4V6aO5fQzro2nZYZjtHlAhRVa/o
 0v0ekp86zcSH1c3+UTkDa7lgf//Y2WOIFCsbiXAi0yU1w6lNR3Kw16uAEW7u0/pDLz6Eylnm68ZOO
 rk1MCJPSFMWdxCyg=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmWRa-0005q7-0w for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 12:53:04 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so3437224f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784724775; x=1785329575; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7fZK9//xY580irca23haVYnd82ZkkGxtEQtH0kIuRdg=;
 b=Wub987VeJkBAttxDxF68L9EX1az5FH2qkG6HLZzSgxU/FXBPMsJxVfpulGMlFVow/a
 wuXWJGkFhDkHGmr5HO4FMQCb6Av8mGkAzxHIJH65/diwjBIKKOcXQBSrYvNIugk0ngSO
 KXBAbIDkfrKtaPIqActZ9b5ix6SXOE1cne3GLew6bDJNKJqslcUrWS7GDk9j1F9S+kCR
 C3/4hf2z+67Im7ib/sCOykAwqTJtoYAbKRJMmNg/O1/0se5aEAf+Lg9fek/dbr/3eu+u
 MI9Nzl1YJrvsQusmwIp67Wt0TyLwDcb+qxwq1eQWstF7ZJA7oN2Y1YJU/w9m4JO1yXjo
 uicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784724775; x=1785329575;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7fZK9//xY580irca23haVYnd82ZkkGxtEQtH0kIuRdg=;
 b=sM5TKQJhkew/qcqDtzYqPrZVrJ4jVKXrHJaLvkWszVy9SKwOuzvKUSuM3HsI3gTvSs
 QG+AVGqWAXgh5Obz4ly+98jhwZZpfMZuJCaGbgQkU0YzucHac6KWyjJe2UPx2PW49Qm+
 v9vv0raP9347O0laxKhjrJ+VESgUukCpWT1pKWO8mf5hTce5vCu6A7QK48d/es3lmmQT
 gcpA14qGNxe5DnDwOr1Siypuh08cNzcAkqEDsVll6CwVju8lpIrmFXFVj+mxCOJeoO7n
 QdyejEBrB1UAWy7VbHbPy3cSwqVsXUkXNCnqWi7SPGOZ7KtT9wAxAp9qPodQxKQ0nLnP
 qWvA==
X-Gm-Message-State: AOJu0YxrKjwDQflwbDObgwg2SUgjmLKoOG/vGT2cZTJajaln8Ebipfi4
 0A33f32jjGaOIghm+ZEs3ZzlTGqGnqw7i5wWtumoY619emkSKUkoM39sF0Tlm2DI53eEui+HmhO
 TsyWM3LUknyh5yQZLSBtQwWqAbgmlmbt7suXP0a0EVfAJ42XV/W3J4zSU1/5xU2Y4thzp0978TA
 aoKyqChg==
X-Gm-Gg: AR+sD12uYBmVU4PyVociN7aLfYQ7FYFiTr0B1gMaHDAkAzseNrww/4OofyPJTzWQ+TC
 DYH9cT2io55C1fi7NgSJXw4XiDjGxPaFsq/T5vSG2Dqc8U+I0giQInAD/vu4CO4GeJlktLbqTem
 utpxt/bhL5UDnW7ICGiCKHn0RzkkfoXg6wxYCfJs+I4d5dllfujI2uoVb2fRXY7IJXNs/ZfU6t4
 2hvME8Hl0mFHb5R3i+XS+YUKT0QtB0HXGV2kqDUlrg52m5twVW9L5CDyCejWZ9n2d/dS7x9y4Wx
 TCnVtb3q8s5jVH7gXtDR/Z2vJ9Ic3AWkl1HHeIom9dx+fKDWfYwKqS5fcwH+T9Zhir+rE1cqELZ
 wGSgQpSIyzCFOJPedPfkawldnrk7d6P5IT1QkB6jB7BAV3KJrKbFwAsen/PnRKRScaqlT2fNiIz
 wzegXAHyd4Iy/T2sbKrPmjAxnHDnUQ90bp6tlbKpFxU54F+zxJSllwm35CYV8IYxEx17zUmtSq3
 Z0z9hB9j0HceCNby1Q+6A7vFv1CPSJLvDODYN1074SkkEA+SxnAUMxqmwDXm3e7WrX2
X-Received: by 2002:a05:600c:4f52:b0:495:3c6f:7c18 with SMTP id
 5b1f17b1804b1-4956a4e5a97mr39798185e9.3.1784724775001; 
 Wed, 22 Jul 2026 05:52:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653698bcsm131114165e9.2.2026.07.22.05.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:52:54 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 12:52:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
X-Gerrit-Change-Number: 1801
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1801?usp=email>
X-Gerrit-Commit: e38dfb687235974d7a42c635e60282191267ab27
References: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzI0NzcyMDAwLkljMTgzZjFmMWY5MDU2MTQ1NGI3YjExMjhjOTUyNTUzNjg0MjdjYzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d90f42d7527a8fe6b476c25637e0b8743f8d4f7d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmWRa-0005q7-0w
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make
 --x509-username-field work with Mbed TLS
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4465495437467652469=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4465495437467652469==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="asr0DGMFKR8="; charset=UTF-8

--asr0DGMFKR8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1801?usp=3Demail

to review the following change=2E


Chang=
e subject: Make --x509-username-field work with Mbed TLS
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make --x509-username-field work=
 with Mbed TLS

In pre-2=2E7 versions, this option was not available in the=
 Mbed TLS
build=2E This was changed in 2=2E7, but the option did not do any=
thing when
Mbed TLS was selected as the crypto library=2E Regardless of the=
 field
chosen with --x509-username-field, OpenVPN would always extract the =
CN
as username=2E

This could lead to a situation where an unintended certi=
ficate gets
accepted by OpenVPN: If we run with "--x509-username-field seri=
alNumber"
and "--verify-x509-name 0x05 name", OpenVPN would accept a certif=
icate
with CN=3D0x05 and an incorrect serial number, while a certificate wi=
th
the correct serial number would be rejected=2E (Though note that to
expl=
oit this, an attacker needs to make the CA sign a certificate
with a hexade=
cimal number in the CN=2E)

This commit adds code to extract the correct fi=
eld values from X509
certificates=2E It also adds unit tests for extracting=
 the values of
different fields=2E

Despite this commit fixing a CVE, we ha=
ve decided not to keep it under
embargo until the release of the next versi=
on because it is unlikely to
be exploitable in practice: Someone has to run=
 OpenVPN 2=2E7 with Mbed
TLS, use the --x509-username-field option even tho=
ugh it didn't exist in
Mbed TLS builds of earlier versions, not notice that=
 the intended
certificate is *not* accepted, and then an attacker has to ge=
t the CA to
sign a certificate with a weird common name=2E

CVE: 2026-63650=

Github: openvpn/openvpn-private-issues#144
Reported-By: Hcamael
Reported-B=
y: =E7=AB=A0=E9=B1=BC=E5=93=A5 (www=2Eaipyaipy=2Ecom)
Change-Id: Ic183f1f1f=
90561454b7b1128c95255368427cc4a
Signed-off-by: Max Fillinger <maximilian=2E=
fillinger@sentyron=2Ecom>
---
M src/openvpn/ssl_verify_mbedtls=2Ec
M tests/=
unit_tests/openvpn/test_ssl=2Ec
2 files changed, 180 insertions(+), 22 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/01/1801/1

diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvp=
n/ssl_verify_mbedtls=2Ec
index ad5479c=2E=2E7cd35ee 100644
--- a/src/openvp=
n/ssl_verify_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -137,1=
9 +137,132 @@
     return false;
 }
 
+static const char *fieldname_to_oid(=
const char *fieldname)
+{
+    if (strcmp(fieldname, "C") =3D=3D 0)
+    {
=
+        return MBEDTLS_OID_AT_COUNTRY;
+    }
+    else if (strcmp(fieldna=
me, "ST") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_STATE;
+    }
+  =
  else if (strcmp(fieldname, "LOCALITY") =3D=3D 0)
+    {
+        return M=
BEDTLS_OID_AT_LOCALITY;
+    }
+    else if (strcmp(fieldname, "O") =3D=3D =
0)
+    {
+        return MBEDTLS_OID_AT_ORGANIZATION;
+    }
+    else if =
(strcmp(fieldname, "OU") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_OR=
G_UNIT;
+    }
+    else if (strcmp(fieldname, "CN") =3D=3D 0)
+    {
+    =
    return MBEDTLS_OID_AT_CN;
+    }
+    else if (strcmp(fieldname, "GN") =
=3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_GIVEN_NAME;
+    }
+    els=
e if (strcmp(fieldname, "SN") =3D=3D 0)
+    {
+        return MBEDTLS_OID_=
AT_SUR_NAME;
+    }
+    else if (strcmp(fieldname, "initials") =3D=3D 0)
+=
    {
+        return MBEDTLS_OID_AT_INITIALS;
+    }
+    else if (strcmp(=
fieldname, "pseudonym") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_PSE=
UDONYM;
+    }
+    else if (strcmp(fieldname, "title") =3D=3D 0)
+    {
+ =
       return MBEDTLS_OID_AT_TITLE;
+    }
+    else if (strcmp(fieldname, =
"generationQualifier") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_GENE=
RATION_QUALIFIER;
+    }
+    else if (strcmp(fieldname, "postalAddress") =
=3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_POSTAL_ADDRESS;
+    }
+   =
 else if (strcmp(fieldname, "postalCode") =3D=3D 0)
+    {
+        return =
MBEDTLS_OID_AT_POSTAL_CODE;
+    }
+    else if (strcmp(fieldname, "emailAd=
dress") =3D=3D 0)
+    {
+        return MBEDTLS_OID_PKCS9_EMAIL;
+    }
+ =
   else if (strcmp(fieldname, "uid") =3D=3D 0)
+    {
+        return MBEDT=
LS_OID_AT_UNIQUE_IDENTIFIER;
+    }
+    else if (strcmp(fieldname, "dnQual=
ifier") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_DN_QUALIFIER;
+    =
}
+    else
+    {
+        return NULL;
+    }
+}
+
 result_t
 backend_x50=
9_get_username(char *cn, size_t cn_len, char *x509_username_field, mbedtls_=
x509_crt *cert)
 {
-    mbedtls_x509_name *name;
+    ASSERT(cn !=3D NULL &=
& cert !=3D NULL);
 
-    ASSERT(cn !=3D NULL);
+    if (x509_username_fiel=
d =3D=3D NULL)
+    {
+        goto fail;
+    }
 
-    name =3D &cert->sub=
ject;
+    if (strcmp(x509_username_field, "serialNumber") =3D=3D 0)
+    {=

+        if (cn_len < 2)
+        {
+            goto fail;
+        }
+  =
      cn[0] =3D '0';
+        cn[1] =3D 'x';
+        size_t cn_index =3D 2=
;
+        bool leading_zeros =3D true;
+        for (size_t i =3D 0; i < c=
ert->serial=2Elen; i++)
+        {
+            uint8_t serial_byte =3D cer=
t->serial=2Ep[i];
+            if (leading_zeros && serial_byte =3D=3D 0)
+=
            {
+                continue;
+            }
+            leadin=
g_zeros =3D false;
+            if (cn_index >=3D cn_len)
+            {
+ =
               goto fail;
+            }
+            snprintf(&cn[cn_index=
], cn_len - cn_index, "%02X", serial_byte);
+            cn_index +=3D 2;
+=
        }
+        return SUCCESS;
+    }
 
-    /* Find common name */
+  =
  const char *field_oid =3D fieldname_to_oid(x509_username_field);
+    if =
(field_oid =3D=3D NULL)
+    {
+        goto fail;
+    }
+
+    /* Find fi=
eld_oid in the subject name=2E */
+    mbedtls_x509_name *name =3D &cert->s=
ubject;
     while (name !=3D NULL)
     {
-        if (0 =3D=3D memcmp(nam=
e->oid=2Ep, MBEDTLS_OID_AT_CN, MBEDTLS_OID_SIZE(MBEDTLS_OID_AT_CN)))
+     =
   if (strlen(field_oid) =3D=3D name->oid=2Elen
+            && 0 =3D=3D me=
mcmp(name->oid=2Ep, field_oid, name->oid=2Elen))
         {
             br=
eak;
         }
@@ -160,10 +273,10 @@
     /* Not found, return an error if=
 this is the peer's certificate */
     if (name =3D=3D NULL)
     {
-     =
   return FAILURE;
+        goto fail;
     }
 
-    /* Found, extract CN *=
/
+    /* Found, extract the value */
     if (cn_len > name->val=2Elen)
  =
   {
         memcpy(cn, name->val=2Ep, name->val=2Elen);
@@ -171,11 +284,1=
8 @@
     }
     else
     {
-        memcpy(cn, name->val=2Ep, cn_len);
+ =
       memcpy(cn, name->val=2Ep, cn_len - 1);
         cn[cn_len - 1] =3D '=
\0';
     }
 
     return SUCCESS;
+
+fail:
+    if (cn_len > 0)
+    {
+  =
      cn[0] =3D '\0';
+    }
+    return FAILURE;
 }
 
 #if MBEDTLS_VERSION=
_NUMBER >=3D 0x04000000
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec =
b/tests/unit_tests/openvpn/test_ssl=2Ec
index 0e9cecf=2E=2E4ab6ee7 100644
-=
-- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/t=
est_ssl=2Ec
@@ -775,7 +775,7 @@
 static openvpn_x509_cert_t *
 get_certific=
ate(const char *cert_str)
 {
-    BIO *in =3D BIO_new_mem_buf((char *)cert1=
, -1);
+    BIO *in =3D BIO_new_mem_buf((char *)cert_str, -1);
     assert_=
non_null(in);
     X509 *cert =3D PEM_read_bio_X509(in, NULL, NULL, NULL);
=
     assert_non_null(cert);
@@ -790,10 +790,35 @@
 }
 #endif
 
+/* Generate=
d with:
+ * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384=
r1 -keyout - -noenc -sha256 -days 3650 \
+ * -subj '/CN=3Dovpn-test-secp384=
r1/O=3DOpenVPN Unit Test Example Corp=2E/OU=3DCert Details Dept=2E'
+ * -ad=
dext 'subjectAltName=3DDNS:unittest=2Eexample=2Ecom' -addext 'extendedKeyUs=
age=3DclientAuth' */
+static const char *cert_details_test_cert =3D
+    "-=
----BEGIN CERTIFICATE-----\n"
+    "MIICkzCCAhqgAwIBAgIUKDsZM+PApGdaD2QF9iY=
axoFJAkowCgYIKoZIzj0EAwIw\n"
+    "ZTEcMBoGA1UEAwwTb3Zwbi10ZXN0LXNlY3AzODRy=
MTEoMCYGA1UECgwfT3BlblZQ\n"
+    "TiBVbml0IFRlc3QgRXhhbXBsZSBDb3JwLjEbMBkGA=
1UECwwSQ2VydCBEZXRhaWxz\n"
+    "IERlcHQuMB4XDTI2MDcwNzEwNTIxNloXDTM2MDcwND=
EwNTIxNlowZTEcMBoGA1UE\n"
+    "AwwTb3Zwbi10ZXN0LXNlY3AzODRyMTEoMCYGA1UECgw=
fT3BlblZQTiBVbml0IFRl\n"
+    "c3QgRXhhbXBsZSBDb3JwLjEbMBkGA1UECwwSQ2VydCBE=
ZXRhaWxzIERlcHQuMHYw\n"
+    "EAYHKoZIzj0CAQYFK4EEACIDYgAEOlKoQVk+wbBD6V/6k=
g+/oHfqF0Dq08LlCL+B\n"
+    "om4RhutG99QDrow251Ps+Ds/7LQYYRA8+hHyEFrmGM+j2o=
6KhS5K2uA6dIZL4zLK\n"
+    "vl0NeF2M61Z8tt/IjrFZd+CrEANco4GKMIGHMB0GA1UdDgQ=
WBBSEyG6m+QdWazeg\n"
+    "0CHN7q0edJlqMjAfBgNVHSMEGDAWgBSEyG6m+QdWazeg0CHN=
7q0edJlqMjAPBgNV\n"
+    "HRMBAf8EBTADAQH/MB8GA1UdEQQYMBaCFHVuaXR0ZXN0LmV4Y=
W1wbGUuY29tMBMG\n"
+    "A1UdJQQMMAoGCCsGAQUFBwMCMAoGCCqGSM49BAMCA2cAMGQCMC=
yK7aQcyKGW8BWQ\n"
+    "UOYqbJUJZJcviP6ACgJRzK6pgkqt9gY0E0Tb00Qh6D5dBV5i3wI=
wCMhSgpVJxDrc\n"
+    "pRfligoK8bmv4HEgnV6BDeoDYd41WVMpE9u1issQDHY0SnWC7d9q=
\n"
+    "-----END CERTIFICATE-----\n";
+const char *const cert_details_cna=
me =3D "ovpn-test-secp384r1";
+const char *const cert_details_org =3D "Open=
VPN Unit Test Example Corp=2E";
+const char *const cert_details_org_unit =
=3D "Cert Details Dept=2E";
+
 void
 crypto_test_print_cert_details(void **=
state)
 {
-    openvpn_x509_cert_t *cert =3D get_certificate(cert1);
+    o=
penvpn_x509_cert_t *cert =3D get_certificate(cert_details_test_cert);
     =
struct gc_arena gc =3D gc_new();
 
     const char *fp =3D backend_x509_get=
_serial_hex(cert, &gc);
@@ -801,29 +826,42 @@
     /* we messed this up bet=
ween TLS libraries=2E But let's at least notice in
      * the future =2E=
=2E=2E*/
 #if defined(ENABLE_CRYPTO_MBEDTLS)
-    assert_string_equal(fp, "=
82:6B:DD:CC:BD:E5:5E:B7:08:F1:2D:68:00:3C:24:DE");
+    assert_string_equal=
(fp, "28:3B:19:33:E3:C0:A4:67:5A:0F:64:05:F6:26:1A:C6:81:49:02:4A");
 #else=

-    assert_string_equal(fp, "82:6b:dd:cc:bd:e5:5e:b7:08:f1:2d:68:00:3c:24=
:de");
+    assert_string_equal(fp, "28:3b:19:33:e3:c0:a4:67:5a:0f:64:05:f6=
:26:1a:c6:81:49:02:4a");
 #endif
 
     const char *sn =3D backend_x509_get=
_serial(cert, &gc);
-    assert_string_equal(sn, "1733597138497398081106101=
11821055272158");
+    assert_string_equal(sn, "229677570263950905252266749=
734450551528150860362");
 
     char username[TLS_USERNAME_LEN + 1] =3D { 0=
 }; /* null-terminated */
 
-    int ret =3D backend_x509_get_username(user=
name, sizeof(username), "CN",
-                                        cert=
);
+    int ret =3D backend_x509_get_username(username, sizeof(username), "=
CN", cert);
 
-    assert_string_equal(username, "ovpn-test-ec1");
+    ass=
ert_string_equal(username, cert_details_cname);
     assert_int_equal(ret, =
SUCCESS);
 
-#ifndef ENABLE_CRYPTO_MBEDTLS
-    /* mbed TLS does not implem=
ent this */
-    ret =3D backend_x509_get_username(username, sizeof(usernam=
e), "serialNumber",
-                                    cert);
+    ret =
=3D backend_x509_get_username(username, sizeof(username), "serialNumber", c=
ert);
     assert_int_equal(ret, SUCCESS);
-    assert_string_equal(usernam=
e, "0x826BDDCCBDE55EB708F12D68003C24DE");
-#endif
+    assert_string_equal(=
username, "0x283B1933E3C0A4675A0F6405F6261AC68149024A");
+
+    ret =3D bac=
kend_x509_get_username(username, sizeof(username), "O", cert);
+
+    asser=
t_string_equal(username, cert_details_org);
+    assert_int_equal(ret, SUCC=
ESS);
+
+    ret =3D backend_x509_get_username(username, sizeof(username), =
"OU", cert);
+
+    assert_string_equal(username, cert_details_org_unit);
+=
    assert_int_equal(ret, SUCCESS);
+
+    /* Check that FAILURE is returne=
d if a field does not exist=2E */
+    ret =3D backend_x509_get_username(us=
ername, sizeof(username), "SN", cert);
+    assert_int_equal(ret, FAILURE);=

+
+    /* Check that FAILURE is returned for invalid field names=2E */
+  =
  ret =3D backend_x509_get_username(username, sizeof(username), "invalidFie=
ld", cert);
+    assert_int_equal(ret, FAILURE);
 
     gc_free(&gc);
     =
free_certificate(cert);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1801?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
Gerrit-Change-Number: 1801
G=
errit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>

--asr0DGMFKR8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>MaxF would like plaisthos to <st=
rong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1801?usp=3Demail">View Change</a></p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Mak=
e --x509-username-field work with Mbed TLS<br><br>In pre-2=2E7 versions, th=
is option was not available in the Mbed TLS<br>build=2E This was changed in=
 2=2E7, but the option did not do anything when<br>Mbed TLS was selected as=
 the crypto library=2E Regardless of the field<br>chosen with --x509-userna=
me-field, OpenVPN would always extract the CN<br>as username=2E<br><br>This=
 could lead to a situation where an unintended certificate gets<br>accepted=
 by OpenVPN: If we run with &quot;--x509-username-field serialNumber&quot;<=
br>and &quot;--verify-x509-name 0x05 name&quot;, OpenVPN would accept a cer=
tificate<br>with CN=3D0x05 and an incorrect serial number, while a certific=
ate with<br>the correct serial number would be rejected=2E (Though note tha=
t to<br>exploit this, an attacker needs to make the CA sign a certificate<b=
r>with a hexadecimal number in the CN=2E)<br><br>This commit adds code to e=
xtract the correct field values from X509<br>certificates=2E It also adds u=
nit tests for extracting the values of<br>different fields=2E<br><br>Despit=
e this commit fixing a CVE, we have decided not to keep it under<br>embargo=
 until the release of the next version because it is unlikely to<br>be expl=
oitable in practice: Someone has to run OpenVPN 2=2E7 with Mbed<br>TLS, use=
 the --x509-username-field option even though it didn&#39;t exist in<br>Mbe=
d TLS builds of earlier versions, not notice that the intended<br>certifica=
te is *not* accepted, and then an attacker has to get the CA to<br>sign a c=
ertificate with a weird common name=2E<br><br>CVE: 2026-63650<br>Github: op=
envpn/openvpn-private-issues#144<br>Reported-By: Hcamael<br>Reported-By: =
=E7=AB=A0=E9=B1=BC=E5=93=A5 (www=2Eaipyaipy=2Ecom)<br>Change-Id: Ic183f1f1f=
90561454b7b1128c95255368427cc4a<br>Signed-off-by: Max Fillinger &lt;maximil=
ian=2Efillinger@sentyron=2Ecom&gt;<br>---<br>M src/openvpn/ssl_verify_mbedt=
ls=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>2 files changed, 180 i=
nsertions(+), 22 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/1801/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec<=
/span><br><span>index ad5479c=2E=2E7cd35ee 100644</span><br><span>--- a/src=
/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_verif=
y_mbedtls=2Ec</span><br><span>@@ -137,19 +137,132 @@</span><br><span>     r=
eturn false;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static const char *fieldname_to_oid(const cha=
r *fieldname)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(fieldname=
, &quot;C&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return MBEDTLS_OID_AT_COUNTRY;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else if (strcmp(fieldname, &quot;ST&quot;) =3D=3D 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return MBEDTLS_OID_AT_STATE;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;LOCALITY&quot;=
) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS=
_OID_AT_LOCALITY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (str=
cmp(fieldname, &quot;O&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return MBEDTLS_OID_AT_ORGANIZATION;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (strcmp(fieldname, &quot;OU&quot;) =3D=3D 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_ORG_UN=
IT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname,=
 &quot;CN&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return MBEDTLS_OID_AT_CN;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e if (strcmp(fieldname, &quot;GN&quot;) =3D=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return MBEDTLS_OID_AT_GIVEN_NAME;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;SN&quot;) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_=
AT_SUR_NAME;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(f=
ieldname, &quot;initials&quot;) =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return MBEDTLS_OID_AT_INITIALS;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (strcmp(fieldname, &quot;pseudonym&quot;) =3D=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_P=
SEUDONYM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fiel=
dname, &quot;title&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return MBEDTLS_OID_AT_TITLE;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (strcmp(fieldname, &quot;generationQualifier&quot;) =3D=3D=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_=
GENERATION_QUALIFIER;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(strcmp(fieldname, &quot;postalAddress&quot;) =3D=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_POSTAL_ADDRESS;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;post=
alCode&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn MBEDTLS_OID_AT_POSTAL_CODE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else if (strcmp(fieldname, &quot;emailAddress&quot;) =3D=3D 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_PKCS9_EMAIL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quo=
t;uid&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn MBEDTLS_OID_AT_UNIQUE_IDENTIFIER;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else if (strcmp(fieldname, &quot;dnQualifier&quot;) =3D=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_DN_QUALIF=
IER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> result_t</span><br><span> backend_x509_get_username(char *cn, size_=
t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_x509_=
name *name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSE=
RT(cn !=3D NULL &amp;&amp; cert !=3D NULL);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cn !=3D NULL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (x509_username_field =
=3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto fail;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    name =3D &amp;ce=
rt-&gt;subject;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (strcmp(x509_username_field, &quot;serialNumber&quot;) =3D=3D 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (cn_len &lt; 2)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            goto fail;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cn[0] =3D &#39;0&#39;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cn[1] =3D &#39;x&#39;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        size_t cn_index =3D 2=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool leadi=
ng_zeros =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       for (size_t i =3D 0; i &lt; cert-&gt;serial=2Elen; i++)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            uint8_t serial_byte =3D cert-=
&gt;serial=2Ep[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (leading_zeros &amp;&amp; serial_byte =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                continue;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            leading_zeros =3D false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (cn_ind=
ex &gt;=3D cn_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         goto fail;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      snprintf(&amp;cn[cn_index], cn_len - cn_index, &quot;%02X&quot;, seri=
al_byte);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  cn_index +=3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn SUCCESS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* Find common name */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *field_oid =3D fieldname_to_oid(x509_username_field);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (field_oid =3D=3D=
 NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        goto fail;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Find field_oid in the subject name=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_x509_name *name =3D =
&amp;cert-&gt;subject;</span><br><span>     while (name !=3D NULL)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (0 =3D=3D memcmp(name-&gt;oid=2Ep, MBEDTLS_OID_AT_CN, MBEDTLS_OID_SIZE(=
MBEDTLS_OID_AT_CN)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (strlen(field_oid) =3D=3D name-&gt;oid=2Elen</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; 0 =3D=3D memcmp=
(name-&gt;oid=2Ep, field_oid, name-&gt;oid=2Elen))</span><br><span>        =
 {</span><br><span>             break;</span><br><span>         }</span><br=
><span>@@ -160,10 +273,10 @@</span><br><span>     /* Not found, return an e=
rror if this is the peer&#39;s certificate */</span><br><span>     if (name=
 =3D=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        return FAILURE;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        goto fail;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Found, extr=
act CN */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Fou=
nd, extract the value */</span><br><span>     if (cn_len &gt; name-&gt;val=
=2Elen)</span><br><span>     {</span><br><span>         memcpy(cn, name-&gt=
;val=2Ep, name-&gt;val=2Elen);</span><br><span>@@ -171,11 +284,18 @@</span>=
<br><span>     }</span><br><span>     else</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        memcpy(cn, name-&gt;val=
=2Ep, cn_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   memcpy(cn, name-&gt;val=2Ep, cn_len - 1);</span><br><span>         cn[cn=
_len - 1] =3D &#39;\0&#39;;</span><br><span>     }</span><br><span> </span>=
<br><span>     return SUCCESS;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fail:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cn_len &gt; 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cn[0] =3D &#39;\0&#39;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return FAILURE;</span><br><span=
> }</span><br><span> </span><br><span> #if MBEDTLS_VERSION_NUMBER &gt;=3D 0=
x04000000</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2E=
c b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index 0e9cecf=2E=
=2E4ab6ee7 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br>=
<span>@@ -775,7 +775,7 @@</span><br><span> static openvpn_x509_cert_t *</sp=
an><br><span> get_certificate(const char *cert_str)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    BIO *in =3D BIO_new_me=
m_buf((char *)cert1, -1);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    BIO *in =3D BIO_new_mem_buf((char *)cert_str, -1);</span><br><spa=
n>     assert_non_null(in);</span><br><span>     X509 *cert =3D PEM_read_bi=
o_X509(in, NULL, NULL, NULL);</span><br><span>     assert_non_null(cert);</=
span><br><span>@@ -790,10 +790,35 @@</span><br><span> }</span><br><span> #e=
ndif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Generated with:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -key=
out - -noenc -sha256 -days 3650 \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * -subj &#39;/CN=3Dovpn-test-secp384r1/O=3DOpenVPN Unit Test=
 Example Corp=2E/OU=3DCert Details Dept=2E&#39;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * -addext &#39;subjectAltName=3DDNS:unittest=
=2Eexample=2Ecom&#39; -addext &#39;extendedKeyUsage=3DclientAuth&#39; */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *cer=
t_details_test_cert =3D</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;-----BEGIN CERTIFICATE-----\n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;MIICkzCCAhqgAwIBAgIUKDsZM+PApGdaD2Q=
F9iYaxoFJAkowCgYIKoZIzj0EAwIw\n&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;ZTEcMBoGA1UEAwwTb3Zwbi10ZXN0LXNlY3AzODRyMTEoMCY=
GA1UECgwfT3BlblZQ\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    &quot;TiBVbml0IFRlc3QgRXhhbXBsZSBDb3JwLjEbMBkGA1UECwwSQ2VydCBEZXR=
haWxz\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &q=
uot;IERlcHQuMB4XDTI2MDcwNzEwNTIxNloXDTM2MDcwNDEwNTIxNlowZTEcMBoGA1UE\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;AwwTb3Zw=
bi10ZXN0LXNlY3AzODRyMTEoMCYGA1UECgwfT3BlblZQTiBVbml0IFRl\n&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;c3QgRXhhbXBsZSBDb3Jw=
LjEbMBkGA1UECwwSQ2VydCBEZXRhaWxzIERlcHQuMHYw\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;EAYHKoZIzj0CAQYFK4EEACIDYgAEOlK=
oQVk+wbBD6V/6kg+/oHfqF0Dq08LlCL+B\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;om4RhutG99QDrow251Ps+Ds/7LQYYRA8+hHyEFrmGM+=
j2o6KhS5K2uA6dIZL4zLK\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;vl0NeF2M61Z8tt/IjrFZd+CrEANco4GKMIGHMB0GA1UdDgQWBBSEyG6=
m+QdWazeg\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;0CHN7q0edJlqMjAfBgNVHSMEGDAWgBSEyG6m+QdWazeg0CHN7q0edJlqMjAPBgNV\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;HRMB=
Af8EBTADAQH/MB8GA1UdEQQYMBaCFHVuaXR0ZXN0LmV4YW1wbGUuY29tMBMG\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;A1UdJQQMMAoGCCsG=
AQUFBwMCMAoGCCqGSM49BAMCA2cAMGQCMCyK7aQcyKGW8BWQ\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;UOYqbJUJZJcviP6ACgJRzK6pgkqt=
9gY0E0Tb00Qh6D5dBV5i3wIwCMhSgpVJxDrc\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;pRfligoK8bmv4HEgnV6BDeoDYd41WVMpE9u1issQ=
DHY0SnWC7d9q\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;-----END CERTIFICATE-----\n&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+const char *const cert_details_cname =3D &quot;ov=
pn-test-secp384r1&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+const char *const cert_details_org =3D &quot;OpenVPN Unit Test Example=
 Corp=2E&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cons=
t char *const cert_details_org_unit =3D &quot;Cert Details Dept=2E&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> voi=
d</span><br><span> crypto_test_print_cert_details(void **state)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_x5=
09_cert_t *cert =3D get_certificate(cert1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    openvpn_x509_cert_t *cert =3D get_certificate(c=
ert_details_test_cert);</span><br><span>     struct gc_arena gc =3D gc_new(=
);</span><br><span> </span><br><span>     const char *fp =3D backend_x509_g=
et_serial_hex(cert, &amp;gc);</span><br><span>@@ -801,29 +826,42 @@</span><=
br><span>     /* we messed this up between TLS libraries=2E But let&#39;s a=
t least notice in</span><br><span>      * the future =2E=2E=2E*/</span><br>=
<span> #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    assert_string_equal(fp, &quot;82:6B:DD:CC:BD:E5:5E:=
B7:08:F1:2D:68:00:3C:24:DE&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_string_equal(fp, &quot;28:3B:19:33:E3:C0:A4:67:5A=
:0F:64:05:F6:26:1A:C6:81:49:02:4A&quot;);</span><br><span> #else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    assert_string_equal(fp, &quo=
t;82:6b:dd:cc:bd:e5:5e:b7:08:f1:2d:68:00:3c:24:de&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(fp, &quot;28:=
3b:19:33:e3:c0:a4:67:5a:0f:64:05:f6:26:1a:c6:81:49:02:4a&quot;);</span><br>=
<span> #endif</span><br><span> </span><br><span>     const char *sn =3D bac=
kend_x509_get_serial(cert, &amp;gc);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    assert_string_equal(sn, &quot;17335971384973980811061011=
1821055272158&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_string_equal(sn, &quot;229677570263950905252266749734450551528=
150860362&quot;);</span><br><span> </span><br><span>     char username[TLS_=
USERNAME_LEN + 1] =3D { 0 }; /* null-terminated */</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D backend_x509=
_get_username(username, sizeof(username), &quot;CN&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                       =
 cert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D backend_x509_get_username(username, sizeof(username), &quot;CN&quot;, c=
ert);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    assert_string_equal(username, &quot;ovpn-test-ec1&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(usernam=
e, cert_details_cname);</span><br><span>     assert_int_equal(ret, SUCCESS)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fndef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* mbed TLS does not implement this */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ret =3D backend_x509_get_username(username, =
sizeof(username), &quot;serialNumber&quot;,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                    cert);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D backend_x509_get_u=
sername(username, sizeof(username), &quot;serialNumber&quot;, cert);</span>=
<br><span>     assert_int_equal(ret, SUCCESS);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    assert_string_equal(username, &quot;0x826BDDCC=
BDE55EB708F12D68003C24DE&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(username, &quot;0x283B1933E3C0A4675A0F6405F6261AC6814=
9024A&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D backend_x509_=
get_username(username, sizeof(username), &quot;O&quot;, cert);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(username, cert_details_org)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(ret, SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D backend_x=
509_get_username(username, sizeof(username), &quot;OU&quot;, cert);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(username, cert_details=
_org_unit);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(ret, SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Chec=
k that FAILURE is returned if a field does not exist=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ret =3D backend_x509_get_usernam=
e(username, sizeof(username), &quot;SN&quot;, cert);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ret, FAILURE);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Check that FAILURE is returned for in=
valid field names=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ret =3D backend_x509_get_username(username, sizeof(username), &quot=
;invalidField&quot;, cert);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(ret, FAILURE);</span><br><span> </span><br><sp=
an>     gc_free(&amp;gc);</span><br><span>     free_certificate(cert);</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1801?usp=3Demail">change 1801</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic183f1f1f90561454b7=
b1128c95255368427cc4a </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1801 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>

</body></html>
--asr0DGMFKR8=--


--===============4465495437467652469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4465495437467652469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4465495437467652469==--

