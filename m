Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A5EC44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EyPKspM//qFKNKa/PhVIaByab/enaccscDtD6DehdYw=; b=du1S57/4XBKoTY/bF7uYyrIV/f
	7g1UKJSx8Nooxxyql9drIAWuOuSNkWrxzwvcw47MSSpM/v9HrPPSK7iObFFQHdErKwu0H2ehSlcbr
	2DYLvOFl9X+0rgpciUVYwrq4woNyb+HbdI11e7/cfc8uTM6CDVQhgfYglPculS7puNSw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmYha-0001mh-EC;
	Wed, 22 Jul 2026 15:17:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmYhX-0001mY-Mw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 15:17:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JNj6CfXgHnOctrDz1KPZbtZKj7JWySm+swdPrDMtTrY=; b=XgfgFVaJ7jLyYHw3ZfzWZjrV4/
 AhZjTfhg8+PP6G7MBf9IWyKcYEqQxOidspg/fB4Sub/6EvQUJyET/RbiuHbiiUkxYuEL93mEtdTJt
 bwBneinEGuA9ZWX38EfqLi6gRZgLhuYIeA4DSDlmubz5XSj04SX0d/ejTYEsXKxCJZOk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JNj6CfXgHnOctrDz1KPZbtZKj7JWySm+swdPrDMtTrY=; b=T
 bvoVX+LTuvfvpOZDkIphM5kJ1/5uAdzAOiUB6rmVDwV1csod2oAqsvrJgLU8L14E1Kc4xrM4XVdJS
 lkkHuohPKPmewXV5xiMIGs1kF/4xf4lz5Jx0B8Lfyoi9Jut+oHD52YBY6XgFsM3dSy1N1bW+0PqPU
 WPnkbEtNb/L7drt8=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmYhQ-0004WW-8g for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 15:17:37 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso22412965e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784733441; x=1785338241; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JNj6CfXgHnOctrDz1KPZbtZKj7JWySm+swdPrDMtTrY=;
 b=FxnmtV4YwDMAkj0L6TL3a+VJFWQB64/xrZ74ZUrckA72vj9/2al63t8toK0YLBp+Yw
 wr2Zswu2S2vd5RhEF/UUeaxkAUXa2nDpuzadMTtkV+SmqZR8tkLG7oNLAjRBQKZEDa0P
 ErUsUjAt8d5hGdsJCArWqGRq2jfJHANpJ8a5FXlRE2jsSNOBHSYBqPyf2x9EY2V9NYSo
 g48Yu/QFtifl1/9W9jY17NbDPo3dU92BrbKufCUD7/MJPJAwt3r2cs85pENzlx3dfQNZ
 8COP03HtkeoLFtqPUPKHGR7Y8d/lmU4gLF0SjJ5RI0YZBPL87ftxD+oMfOXGu9aetKW2
 65VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784733441; x=1785338241;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JNj6CfXgHnOctrDz1KPZbtZKj7JWySm+swdPrDMtTrY=;
 b=kO3i6rpz/NPn0Mi85KU8QcoNETAYk1fI/8vCryKOPvOwBAau+/KfYWe7xjW3dmMuw6
 E5wjKWGIY+VKN78lGfE+rMBLNiJ5YBSO+WtvQJ2M4nly+DnxyRLG6djMtS/fk/Qf5Fs9
 1eMpy7Y2b4O1v4CtdyfLiAy1b4lOpqYKsNYP6r3etIM6BUDZ7RYxKW7nxmMB+sg/Xp4N
 k/NUrryn1Xr8VU5CPDK+cgxxgd2HjJe0Vq7taKNaOZdyYlnM7RtfhAQcvayJ0N52ARGF
 ewO+vgg9GwxgGpFu8gXAgeiAPkwdz4bfPQqzY1+w6Qmvh6sayH81UfDufUF4nOfBEXTq
 cwlQ==
X-Gm-Message-State: AOJu0YyZsXnjXCYtBOxqmJh/u+qzoqTx5BMGPkSiNFRC4o3YRT3GcxaT
 DUYtht4hv0NXYLuW5n4ziamt+zyc2hkqH8Buf6VmvivtDo8O3sp7dNcfXVIyJ1FlB6IUUhGS/bJ
 Klu8XntSfkjJnp2r/OQc6WQsNAj8j6ZZVn9wOowLAyQijw17RsTtsVMcaPjNuoy5QebSz
X-Gm-Gg: AR+sD12udvvf7jlBwLf5mkhhqpC5bd00SL8uXxB8ns7PJRWdRiqWB4oodPxrKlY++9h
 eg/jvg3nraszRa6sMe0//ByZZt1rnZkzTJQ2JdKnD8Op8dJqaQ8G1jTsIiOi30yJncjPWTrkejd
 JgucFMfCGyqsFrPmAyFl+XO1WBgj385/Xzkm5woYh0ltj9XksTpPKsrSFlcACeK19fWRb31OiNc
 KAVSEfWQaaS9Yqr49k3M3PIM0SSWGI3djUA2j/77qyqrW9odojnBaQouEvXo2+6xktlgIQdkAzv
 UaflS97XMk49oFCHd5r2WVsGteM2n2rkWw5mxw0TbpHsBu9vJioO6YlFvVBUX5QzIsdLxlVrcLF
 qIm+A/B+rPx28ZA8JCN+LqFHhNhCI6MGRO8blZZHC4+o+ZUBa49yKv85OvITHfz7znbqJ8t7KM9
 JTV18pyuRPd47RiqKRlyYpOlAIkgBy4NTx/f/4gkuNggOjrq2NfOCkCCwtV2ZLbPk7Llo6NFqfz
 ZZouM4kbKLkXmh1rtfXaI3wFhHOCw6NMlYWRB2acl2oSidEdXOxzXInno+pkXcLiYQ1v00LRDta
 w6I=
X-Received: by 2002:a05:600d:8449:b0:495:6022:5a23 with SMTP id
 5b1f17b1804b1-4956a51d5c4mr60728095e9.19.1784733440379; 
 Wed, 22 Jul 2026 08:17:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bfabesm172958915e9.10.2026.07.22.08.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:17:19 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 15:17:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
X-Gerrit-Change-Number: 1801
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1801?usp=email>
X-Gerrit-Commit: e00d04feda433cd8d84584c85ab90f6f0cc6518a
In-Reply-To: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
References: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzI0NzcyMDAwLkljMTgzZjFmMWY5MDU2MTQ1NGI3YjExMjhjOTUyNTUzNjg0MjdjYzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <32c7f22205f173e02750f3eba36e8cbb8cf5d649-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmYhQ-0004WW-8g
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4732225364741204436=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4732225364741204436==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HTVASI7/HaM="; charset=UTF-8

--HTVASI7/HaM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, plaisthos=2E

Hel=
lo flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please =
visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demail

to l=
ook at the new patch set (#3)=2E

The following approvals got outdated and =
were removed:
Code-Review-1 by flichtenheld


Change subject: Make --x509-u=
sername-field work with Mbed TLS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Make --x509-username-field work with Mbed TLS

In pre-2=
=2E7 versions, this option was not available in the Mbed TLS
build=2E This =
was changed in 2=2E7, but the option did not do anything when
Mbed TLS was =
selected as the crypto library=2E Regardless of the field
chosen with --x50=
9-username-field, OpenVPN would always extract the CN
as username=2E

This =
could lead to a situation where an unintended certificate gets
accepted by =
OpenVPN: If we run with "--x509-username-field serialNumber"
and "--verify-=
x509-name 0x05 name", OpenVPN would accept a certificate
with CN=3D0x05 and=
 an incorrect serial number, while a certificate with
the correct serial nu=
mber would be rejected=2E (Though note that to
exploit this, an attacker ne=
eds to make the CA sign a certificate
with a hexadecimal number in the CN=
=2E)

This commit adds code to backend_x509_get_username to extract the
cor=
rect field values from X509 certificates=2E It also changes the
behavior of=
 the function to match the OpenSSL version when the output
buffer is too sm=
all=2E (With Mbed TLS, the function would silently
truncate the output and =
return SUCCESS=2E)

It also adds unit tests for extracting the values of di=
fferent fields=2E

Despite this commit fixing a CVE, we have decided not to=
 keep it under
embargo until the release of the next version because it is =
unlikely to
be exploitable in practice: Someone has to run OpenVPN 2=2E7 wi=
th Mbed
TLS, use the --x509-username-field option even though it didn't exi=
st in
Mbed TLS builds of earlier versions, not notice that the intended
cer=
tificate is *not* accepted, and then an attacker has to get the CA to
sign =
a certificate with a weird common name=2E

CVE: 2026-63650
Github: openvpn/=
openvpn-private-issues#144
Reported-By: Hcamael
Reported-By: =E7=AB=A0=E9=
=B1=BC=E5=93=A5 (www=2Eaipyaipy=2Ecom)
Change-Id: Ic183f1f1f90561454b7b1128=
c95255368427cc4a
Signed-off-by: Max Fillinger <maximilian=2Efillinger@senty=
ron=2Ecom>
---
M src/openvpn/ssl_verify_mbedtls=2Ec
M tests/unit_tests/open=
vpn/test_ssl=2Ec
2 files changed, 199 insertions(+), 29 deletions(-)


  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/1801/3

d=
iff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbe=
dtls=2Ec
index ad5479c=2E=2E2a09e86 100644
--- a/src/openvpn/ssl_verify_mbe=
dtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -137,19 +137,133 @@
  =
   return false;
 }
 
+static const char *
+fieldname_to_oid(const char *fi=
eldname)
+{
+    if (strcmp(fieldname, "C") =3D=3D 0)
+    {
+        retur=
n MBEDTLS_OID_AT_COUNTRY;
+    }
+    else if (strcmp(fieldname, "ST") =3D=
=3D 0)
+    {
+        return MBEDTLS_OID_AT_STATE;
+    }
+    else if (st=
rcmp(fieldname, "LOCALITY") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT=
_LOCALITY;
+    }
+    else if (strcmp(fieldname, "O") =3D=3D 0)
+    {
+  =
      return MBEDTLS_OID_AT_ORGANIZATION;
+    }
+    else if (strcmp(field=
name, "OU") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_ORG_UNIT;
+    =
}
+    else if (strcmp(fieldname, "CN") =3D=3D 0)
+    {
+        return MB=
EDTLS_OID_AT_CN;
+    }
+    else if (strcmp(fieldname, "GN") =3D=3D 0)
+  =
  {
+        return MBEDTLS_OID_AT_GIVEN_NAME;
+    }
+    else if (strcmp(=
fieldname, "SN") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_SUR_NAME;
=
+    }
+    else if (strcmp(fieldname, "initials") =3D=3D 0)
+    {
+      =
  return MBEDTLS_OID_AT_INITIALS;
+    }
+    else if (strcmp(fieldname, "p=
seudonym") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_PSEUDONYM;
+    =
}
+    else if (strcmp(fieldname, "title") =3D=3D 0)
+    {
+        return=
 MBEDTLS_OID_AT_TITLE;
+    }
+    else if (strcmp(fieldname, "generationQu=
alifier") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_GENERATION_QUALIF=
IER;
+    }
+    else if (strcmp(fieldname, "postalAddress") =3D=3D 0)
+   =
 {
+        return MBEDTLS_OID_AT_POSTAL_ADDRESS;
+    }
+    else if (strc=
mp(fieldname, "postalCode") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT=
_POSTAL_CODE;
+    }
+    else if (strcmp(fieldname, "emailAddress") =3D=3D=
 0)
+    {
+        return MBEDTLS_OID_PKCS9_EMAIL;
+    }
+    else if (st=
rcmp(fieldname, "uid") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_UNIQ=
UE_IDENTIFIER;
+    }
+    else if (strcmp(fieldname, "dnQualifier") =3D=3D=
 0)
+    {
+        return MBEDTLS_OID_AT_DN_QUALIFIER;
+    }
+    else
+ =
   {
+        return NULL;
+    }
+}
+
 result_t
 backend_x509_get_username=
(char *cn, size_t cn_len, char *x509_username_field, mbedtls_x509_crt *cert=
)
 {
-    mbedtls_x509_name *name;
+    ASSERT(cn !=3D NULL && cn_len > 0 &=
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
+            if (cn_index > cn_len - 3)
+            {
+=
                goto fail;
+            }
+            snprintf(&cn[cn_inde=
x], cn_len - cn_index, "%02X", serial_byte);
+            cn_index +=3D 2;
=
+        }
+        return SUCCESS;
+    }
 
-    /* Find common name */
+ =
   const char *field_oid =3D fieldname_to_oid(x509_username_field);
+    if=
 (field_oid =3D=3D NULL)
+    {
+        goto fail;
+    }
+
+    /* Find f=
ield_oid in the subject name=2E */
+    mbedtls_x509_name *name =3D &cert->=
subject;
     while (name !=3D NULL)
     {
-        if (0 =3D=3D memcmp(na=
me->oid=2Ep, MBEDTLS_OID_AT_CN, MBEDTLS_OID_SIZE(MBEDTLS_OID_AT_CN)))
+    =
    if (strlen(field_oid) =3D=3D name->oid=2Elen
+            && 0 =3D=3D m=
emcmp(name->oid=2Ep, field_oid, name->oid=2Elen))
         {
             b=
reak;
         }
@@ -160,22 +274,23 @@
     /* Not found, return an error i=
f this is the peer's certificate */
     if (name =3D=3D NULL)
     {
-    =
    return FAILURE;
+        goto fail;
     }
 
-    /* Found, extract CN =
*/
-    if (cn_len > name->val=2Elen)
+    /* Check that we have room in th=
e buffer, including the terminating '/0' byte=2E */
+    if (cn_len <=3D na=
me->val=2Elen)
     {
-        memcpy(cn, name->val=2Ep, name->val=2Elen);
=
-        cn[name->val=2Elen] =3D '\0';
+        goto fail;
     }
-    else=

-    {
-        memcpy(cn, name->val=2Ep, cn_len);
-        cn[cn_len - 1]=
 =3D '\0';
-    }
+
+    memcpy(cn, name->val=2Ep, name->val=2Elen);
+    c=
n[name->val=2Elen] =3D '\0';
 
     return SUCCESS;
+
+fail:
+    cn[0] =3D=
 '\0';
+    return FAILURE;
 }
 
 #if MBEDTLS_VERSION_NUMBER >=3D 0x0400000=
0
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/ope=
nvpn/test_ssl=2Ec
index 0e9cecf=2E=2Ed473d67 100644
--- a/tests/unit_tests/=
openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -775,7 =
+775,7 @@
 static openvpn_x509_cert_t *
 get_certificate(const char *cert_s=
tr)
 {
-    BIO *in =3D BIO_new_mem_buf((char *)cert1, -1);
+    BIO *in =
=3D BIO_new_mem_buf((char *)cert_str, -1);
     assert_non_null(in);
     X=
509 *cert =3D PEM_read_bio_X509(in, NULL, NULL, NULL);
     assert_non_null=
(cert);
@@ -790,10 +790,37 @@
 }
 #endif
 
+/* Generated with:
+ * openssl =
req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - -noenc =
-sha256 -days 3650 \
+ * -subj '/CN=3Dovpn-test-secp384r1/O=3DOpenVPN Unit =
Test Example Corp=2E/OU=3DCert Details Dept=2E'
+ * -addext 'subjectAltName=
=3DDNS:unittest=2Eexample=2Ecom' -addext 'extendedKeyUsage=3DclientAuth' */=

+static const char *cert_details_test_cert =3D
+    "-----BEGIN CERTIFICAT=
E-----\n"
+    "MIICkzCCAhqgAwIBAgIUKDsZM+PApGdaD2QF9iYaxoFJAkowCgYIKoZIzj0=
EAwIw\n"
+    "ZTEcMBoGA1UEAwwTb3Zwbi10ZXN0LXNlY3AzODRyMTEoMCYGA1UECgwfT3Bl=
blZQ\n"
+    "TiBVbml0IFRlc3QgRXhhbXBsZSBDb3JwLjEbMBkGA1UECwwSQ2VydCBEZXRha=
Wxz\n"
+    "IERlcHQuMB4XDTI2MDcwNzEwNTIxNloXDTM2MDcwNDEwNTIxNlowZTEcMBoGA1=
UE\n"
+    "AwwTb3Zwbi10ZXN0LXNlY3AzODRyMTEoMCYGA1UECgwfT3BlblZQTiBVbml0IFR=
l\n"
+    "c3QgRXhhbXBsZSBDb3JwLjEbMBkGA1UECwwSQ2VydCBEZXRhaWxzIERlcHQuMHYw=
\n"
+    "EAYHKoZIzj0CAQYFK4EEACIDYgAEOlKoQVk+wbBD6V/6kg+/oHfqF0Dq08LlCL+B\=
n"
+    "om4RhutG99QDrow251Ps+Ds/7LQYYRA8+hHyEFrmGM+j2o6KhS5K2uA6dIZL4zLK\n=
"
+    "vl0NeF2M61Z8tt/IjrFZd+CrEANco4GKMIGHMB0GA1UdDgQWBBSEyG6m+QdWazeg\n"=

+    "0CHN7q0edJlqMjAfBgNVHSMEGDAWgBSEyG6m+QdWazeg0CHN7q0edJlqMjAPBgNV\n"
=
+    "HRMBAf8EBTADAQH/MB8GA1UdEQQYMBaCFHVuaXR0ZXN0LmV4YW1wbGUuY29tMBMG\n"
+=
    "A1UdJQQMMAoGCCsGAQUFBwMCMAoGCCqGSM49BAMCA2cAMGQCMCyK7aQcyKGW8BWQ\n"
+ =
   "UOYqbJUJZJcviP6ACgJRzK6pgkqt9gY0E0Tb00Qh6D5dBV5i3wIwCMhSgpVJxDrc\n"
+  =
  "pRfligoK8bmv4HEgnV6BDeoDYd41WVMpE9u1issQDHY0SnWC7d9q\n"
+    "-----END C=
ERTIFICATE-----\n";
+const char *const cert_details_cname =3D "ovpn-test-se=
cp384r1";
+const char *const cert_details_org =3D "OpenVPN Unit Test Exampl=
e Corp=2E";
+const char *const cert_details_org_unit =3D "Cert Details Dept=
=2E";
+const char *const cert_details_serial_number =3D "229677570263950905=
252266749734450551528150860362";
+const char *const cert_details_serial_num=
ber_hex =3D "0x283B1933E3C0A4675A0F6405F6261AC68149024A";
+
 void
 crypto_t=
est_print_cert_details(void **state)
 {
-    openvpn_x509_cert_t *cert =3D =
get_certificate(cert1);
+    openvpn_x509_cert_t *cert =3D get_certificate(=
cert_details_test_cert);
     struct gc_arena gc =3D gc_new();
 
     const=
 char *fp =3D backend_x509_get_serial_hex(cert, &gc);
@@ -801,29 +828,57 @@=

     /* we messed this up between TLS libraries=2E But let's at least noti=
ce in
      * the future =2E=2E=2E*/
 #if defined(ENABLE_CRYPTO_MBEDTLS)
- =
   assert_string_equal(fp, "82:6B:DD:CC:BD:E5:5E:B7:08:F1:2D:68:00:3C:24:DE=
");
+    assert_string_equal(fp, "28:3B:19:33:E3:C0:A4:67:5A:0F:64:05:F6:26=
:1A:C6:81:49:02:4A");
 #else
-    assert_string_equal(fp, "82:6b:dd:cc:bd:e=
5:5e:b7:08:f1:2d:68:00:3c:24:de");
+    assert_string_equal(fp, "28:3b:19:3=
3:e3:c0:a4:67:5a:0f:64:05:f6:26:1a:c6:81:49:02:4a");
 #endif
 
     const c=
har *sn =3D backend_x509_get_serial(cert, &gc);
-    assert_string_equal(sn=
, "173359713849739808110610111821055272158");
+    assert_string_equal(sn, =
cert_details_serial_number);
 
     char username[TLS_USERNAME_LEN + 1] =3D=
 { 0 }; /* null-terminated */
 
-    int ret =3D backend_x509_get_username(=
username, sizeof(username), "CN",
-                                        =
cert);
+    int ret =3D backend_x509_get_username(username, sizeof(username=
), "CN", cert);
 
-    assert_string_equal(username, "ovpn-test-ec1");
+   =
 assert_string_equal(username, cert_details_cname);
     assert_int_equal(r=
et, SUCCESS);
 
-#ifndef ENABLE_CRYPTO_MBEDTLS
-    /* mbed TLS does not im=
plement this */
-    ret =3D backend_x509_get_username(username, sizeof(use=
rname), "serialNumber",
-                                    cert);
+    re=
t =3D backend_x509_get_username(username, sizeof(username), "serialNumber",=
 cert);
     assert_int_equal(ret, SUCCESS);
-    assert_string_equal(usern=
ame, "0x826BDDCCBDE55EB708F12D68003C24DE");
-#endif
+    assert_string_equa=
l(username, cert_details_serial_number_hex);
+
+    ret =3D backend_x509_ge=
t_username(username, sizeof(username), "O", cert);
+
+    assert_string_equ=
al(username, cert_details_org);
+    assert_int_equal(ret, SUCCESS);
+
+   =
 ret =3D backend_x509_get_username(username, sizeof(username), "OU", cert);=

+
+    assert_string_equal(username, cert_details_org_unit);
+    assert_i=
nt_equal(ret, SUCCESS);
+
+    /* Check that FAILURE is returned if a field=
 does not exist=2E */
+    ret =3D backend_x509_get_username(username, size=
of(username), "SN", cert);
+    assert_int_equal(ret, FAILURE);
+
+    /* C=
heck that FAILURE is returned for invalid field names=2E */
+    ret =3D ba=
ckend_x509_get_username(username, sizeof(username), "invalidField", cert);
=
+    assert_int_equal(ret, FAILURE);
+
+    /* Check that FAILURE is return=
ed if the output buffer is too small=2E Do this separately
+     * for a su=
bject field and for the serial number, because these are different code pat=
hs=2E
+     *
+     * First case: Can't fit all characters=2E */
+    ret =
=3D backend_x509_get_username(username, strlen(cert_details_cname) / 2, "CN=
", cert);
+    assert_int_equal(ret, FAILURE);
+    ret =3D backend_x509_ge=
t_username(username, strlen(cert_details_serial_number_hex) / 2, "serialNum=
ber", cert);
+    assert_int_equal(ret, FAILURE);
+
+    /* Second case: Ca=
n fit the characters but not the terminating '\0'=2E */
+    ret =3D backen=
d_x509_get_username(username, strlen(cert_details_cname), "CN", cert);
+   =
 assert_int_equal(ret, FAILURE);
+    ret =3D backend_x509_get_username(use=
rname, strlen(cert_details_serial_number_hex), "serialNumber", cert);
+    =
assert_int_equal(ret, FAILURE);
 
     gc_free(&gc);
     free_certificate(=
cert);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic183f1f1f=
90561454b7b1128c95255368427cc4a
Gerrit-Change-Number: 1801
Gerrit-PatchSet:=
 3
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: MaxF <max@max-fi=
llinger=2Enet>

--HTVASI7/HaM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, flichtenheld, plaisthos=2E </p>
<p>MaxF <strong=
>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review-1 by flic=
htenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">Make --x509-username-field work with Mbed TLS<br>=
<br>In pre-2=2E7 versions, this option was not available in the Mbed TLS<br=
>build=2E This was changed in 2=2E7, but the option did not do anything whe=
n<br>Mbed TLS was selected as the crypto library=2E Regardless of the field=
<br>chosen with --x509-username-field, OpenVPN would always extract the CN<=
br>as username=2E<br><br>This could lead to a situation where an unintended=
 certificate gets<br>accepted by OpenVPN: If we run with &quot;--x509-usern=
ame-field serialNumber&quot;<br>and &quot;--verify-x509-name 0x05 name&quot=
;, OpenVPN would accept a certificate<br>with CN=3D0x05 and an incorrect se=
rial number, while a certificate with<br>the correct serial number would be=
 rejected=2E (Though note that to<br>exploit this, an attacker needs to mak=
e the CA sign a certificate<br>with a hexadecimal number in the CN=2E)<br><=
br>This commit adds code to backend_x509_get_username to extract the<br>cor=
rect field values from X509 certificates=2E It also changes the<br>behavior=
 of the function to match the OpenSSL version when the output<br>buffer is =
too small=2E (With Mbed TLS, the function would silently<br>truncate the ou=
tput and return SUCCESS=2E)<br><br>It also adds unit tests for extracting t=
he values of different fields=2E<br><br>Despite this commit fixing a CVE, w=
e have decided not to keep it under<br>embargo until the release of the nex=
t version because it is unlikely to<br>be exploitable in practice: Someone =
has to run OpenVPN 2=2E7 with Mbed<br>TLS, use the --x509-username-field op=
tion even though it didn&#39;t exist in<br>Mbed TLS builds of earlier versi=
ons, not notice that the intended<br>certificate is *not* accepted, and the=
n an attacker has to get the CA to<br>sign a certificate with a weird commo=
n name=2E<br><br>CVE: 2026-63650<br>Github: openvpn/openvpn-private-issues#=
144<br>Reported-By: Hcamael<br>Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (ww=
w=2Eaipyaipy=2Ecom)<br>Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a=
<br>Signed-off-by: Max Fillinger &lt;maximilian=2Efillinger@sentyron=2Ecom&=
gt;<br>---<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M tests/unit_tests/op=
envpn/test_ssl=2Ec<br>2 files changed, 199 insertions(+), 29 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/01/1801/3</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify_mbedt=
ls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>index ad5479c=
=2E=2E2a09e86 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><sp=
an>@@ -137,19 +137,133 @@</span><br><span>     return false;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+fieldname_to_oid(const char *fieldname)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (strcmp(fieldname, &quot;C&quot;) =3D=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_COUNTRY;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;ST&quot;) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_O=
ID_AT_STATE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(f=
ieldname, &quot;LOCALITY&quot;) =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return MBEDTLS_OID_AT_LOCALITY;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (strcmp(fieldname, &quot;O&quot;) =3D=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_ORGANIZAT=
ION;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname=
, &quot;OU&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return MBEDTLS_OID_AT_ORG_UNIT;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else if (strcmp(fieldname, &quot;CN&quot;) =3D=3D 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_CN;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;GN&quot;) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_=
AT_GIVEN_NAME;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp=
(fieldname, &quot;SN&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return MBEDTLS_OID_AT_SUR_NAME;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (strcmp(fieldname, &quot;initials&quot;) =3D=3D 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_INITIA=
LS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname,=
 &quot;pseudonym&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return MBEDTLS_OID_AT_PSEUDONYM;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else if (strcmp(fieldname, &quot;title&quot;) =3D=3D 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_TITLE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;g=
enerationQualifier&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return MBEDTLS_OID_AT_GENERATION_QUALIFIER;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;postalAddress&quot=
;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTL=
S_OID_AT_POSTAL_ADDRESS;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (strcmp(fieldname, &quot;postalCode&quot;) =3D=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_POSTAL_CODE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;emailAd=
dress&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn MBEDTLS_OID_PKCS9_EMAIL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse if (strcmp(fieldname, &quot;uid&quot;) =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return MBEDTLS_OID_AT_UNIQUE_IDENTIFIER;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;dnQ=
ualifier&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return MBEDTLS_OID_AT_DN_QUALIFIER;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> result_t</span><br><span> backend_x5=
09_get_username(char *cn, size_t cn_len, char *x509_username_field, mbedtls=
_x509_crt *cert)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    mbedtls_x509_name *name;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ASSERT(cn !=3D NULL &amp;&amp; cn_len &gt; 0 &am=
p;&amp; cert !=3D NULL);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    ASSERT(cn !=3D NULL);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (x509_username_field =3D=3D NULL)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto fail;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    name =3D &amp;cert-&gt;subject;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(x509_use=
rname_field, &quot;serialNumber&quot;) =3D=3D 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (cn_len &lt; 2)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            goto fail;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cn[0] =3D &#39;0&#39;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cn[1] =3D &#39;x&#39;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        size_t cn_index =3D 2;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        bool leading_zeros =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (size_t =
i =3D 0; i &lt; cert-&gt;serial=2Elen; i++)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            uint8_t serial_byte =3D cert-&gt;serial=2Ep[i];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (leadi=
ng_zeros &amp;&amp; serial_byte =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                continue;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            leading_zeros =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (cn_index &gt; cn_len - 3)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                goto fail=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            snprintf(&am=
p;cn[cn_index], cn_len - cn_index, &quot;%02X&quot;, serial_byte);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            cn_index +=3D 2;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return SUCCESS;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Find common name=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
field_oid =3D fieldname_to_oid(x509_username_field);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (field_oid =3D=3D NULL)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        goto fail;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Find field_oid in the subject name=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    mbedtls_x509_name *name =3D &amp;cert-&gt;subj=
ect;</span><br><span>     while (name !=3D NULL)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (0 =3D=3D memc=
mp(name-&gt;oid=2Ep, MBEDTLS_OID_AT_CN, MBEDTLS_OID_SIZE(MBEDTLS_OID_AT_CN)=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strle=
n(field_oid) =3D=3D name-&gt;oid=2Elen</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            &amp;&amp; 0 =3D=3D memcmp(name-&gt;oid=2Ep,=
 field_oid, name-&gt;oid=2Elen))</span><br><span>         {</span><br><span=
>             break;</span><br><span>         }</span><br><span>@@ -160,22 =
+274,23 @@</span><br><span>     /* Not found, return an error if this is th=
e peer&#39;s certificate */</span><br><span>     if (name =3D=3D NULL)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        goto fail;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* Found, extract CN */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (cn_len &gt; name-&gt;v=
al=2Elen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Che=
ck that we have room in the buffer, including the terminating &#39;/0&#39; =
byte=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c=
n_len &lt;=3D name-&gt;val=2Elen)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        memcpy(cn, name-&gt;val=2Ep, nam=
e-&gt;val=2Elen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    cn[name-&gt;val=2Elen] =3D &#39;\0&#39;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        goto fail;</span><br><span>     }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        memcpy(cn, name-&gt;val=2Ep, cn_len);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        cn[cn_len - 1] =3D &#39;\0&=
#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    memcpy(cn, name-&gt;val=2Ep, name-&gt;val=2El=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cn[name-&gt=
;val=2Elen] =3D &#39;\0&#39;;</span><br><span> </span><br><span>     return=
 SUCCESS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+fail:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cn[0] =3D &#39;\0&#39;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return FAILURE;</span><br><sp=
an> }</span><br><span> </span><br><span> #if MBEDTLS_VERSION_NUMBER &gt;=3D=
 0x04000000</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=
=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index 0e9cecf=
=2E=2Ed473d67 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ss=
l=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br=
><span>@@ -775,7 +775,7 @@</span><br><span> static openvpn_x509_cert_t *</s=
pan><br><span> get_certificate(const char *cert_str)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    BIO *in =3D BIO_new_m=
em_buf((char *)cert1, -1);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    BIO *in =3D BIO_new_mem_buf((char *)cert_str, -1);</span><br><sp=
an>     assert_non_null(in);</span><br><span>     X509 *cert =3D PEM_read_b=
io_X509(in, NULL, NULL, NULL);</span><br><span>     assert_non_null(cert);<=
/span><br><span>@@ -790,10 +790,37 @@</span><br><span> }</span><br><span> #=
endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* Generated with:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -ke=
yout - -noenc -sha256 -days 3650 \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * -subj &#39;/CN=3Dovpn-test-secp384r1/O=3DOpenVPN Unit Tes=
t Example Corp=2E/OU=3DCert Details Dept=2E&#39;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * -addext &#39;subjectAltName=3DDNS:unittest=
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
span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *const cer=
t_details_serial_number =3D &quot;22967757026395090525226674973445055152815=
0860362&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const=
 char *const cert_details_serial_number_hex =3D &quot;0x283B1933E3C0A4675A0=
F6405F6261AC68149024A&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> void</span><br><span> crypto_test_print_cert_det=
ails(void **state)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    openvpn_x509_cert_t *cert =3D get_certificate(cert1);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_x509_cert=
_t *cert =3D get_certificate(cert_details_test_cert);</span><br><span>     =
struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>     con=
st char *fp =3D backend_x509_get_serial_hex(cert, &amp;gc);</span><br><span=
>@@ -801,29 +828,57 @@</span><br><span>     /* we messed this up between TL=
S libraries=2E But let&#39;s at least notice in</span><br><span>      * the=
 future =2E=2E=2E*/</span><br><span> #if defined(ENABLE_CRYPTO_MBEDTLS)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_string_equal(f=
p, &quot;82:6B:DD:CC:BD:E5:5E:B7:08:F1:2D:68:00:3C:24:DE&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(fp, &q=
uot;28:3B:19:33:E3:C0:A4:67:5A:0F:64:05:F6:26:1A:C6:81:49:02:4A&quot;);</sp=
an><br><span> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  assert_string_equal(fp, &quot;82:6b:dd:cc:bd:e5:5e:b7:08:f1:2d:68:00:3c:2=
4:de&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_string_equal(fp, &quot;28:3b:19:33:e3:c0:a4:67:5a:0f:64:05:f6:26:1a:c6:=
81:49:02:4a&quot;);</span><br><span> #endif</span><br><span> </span><br><sp=
an>     const char *sn =3D backend_x509_get_serial(cert, &amp;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_string_equal(sn, &q=
uot;173359713849739808110610111821055272158&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(sn, cert_details_=
serial_number);</span><br><span> </span><br><span>     char username[TLS_US=
ERNAME_LEN + 1] =3D { 0 }; /* null-terminated */</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D backend_x509_g=
et_username(username, sizeof(username), &quot;CN&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                        c=
ert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
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
  assert_string_equal(username, cert_details_serial_number_hex);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ret =3D backend_x509_get_username(username, s=
izeof(username), &quot;O&quot;, cert);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_string_equal(username, cert_details_org);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ret, SUCCESS);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ret =3D backend_x509_get_username(userna=
me, sizeof(username), &quot;OU&quot;, cert);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(username, cert_details_org_unit);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ret, SUCCE=
SS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* Check that FAILURE is retur=
ned if a field does not exist=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ret =3D backend_x509_get_username(username, sizeof(user=
name), &quot;SN&quot;, cert);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(ret, FAILURE);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Check that FAILURE is returned for invalid field names=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D backend_=
x509_get_username(username, sizeof(username), &quot;invalidField&quot;, cer=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(ret, FAILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Check that F=
AILURE is returned if the output buffer is too small=2E Do this separately<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * for a subject=
 field and for the serial number, because these are different code paths=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * First case: Can&#39;t fit=
 all characters=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ret =3D backend_x509_get_username(username, strlen(cert_details_cname=
) / 2, &quot;CN&quot;, cert);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(ret, FAILURE);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ret =3D backend_x509_get_username(username, s=
trlen(cert_details_serial_number_hex) / 2, &quot;serialNumber&quot;, cert);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(ret, FAILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Second case: Ca=
n fit the characters but not the terminating &#39;\0&#39;=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D backend_x509_get_us=
ername(username, strlen(cert_details_cname), &quot;CN&quot;, cert);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ret, F=
AILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D=
 backend_x509_get_username(username, strlen(cert_details_serial_number_hex)=
, &quot;serialNumber&quot;, cert);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(ret, FAILURE);</span><br><span> </span>=
<br><span>     gc_free(&amp;gc);</span><br><span>     free_certificate(cert=
);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demail">change 1801</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic183f1f1f9056=
1454b7b1128c95255368427cc4a </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1801 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt=
; </div>

</body></html>
--HTVASI7/HaM=--


--===============4732225364741204436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4732225364741204436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4732225364741204436==--

