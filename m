Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39558C44532
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4nh/QBSeKBKsHjDaI+zm9iea5/+GOJcL+PSLBVewUFs=; b=S0YgjdAsLarILhAZG6gEOqFLDR
	1Faq6Mg6t/YbmIADOKCtNOE4ADVjOW57obDqcREo2+YfqNLA91rfiGx3NRQNPL1OWD0XXZ4qq/QZ/
	5uORgPTcFxeXAPpXGNzeXIvatZtqJ4bTArHefb7Vjx4hoCFhvrWzAZHBs+6GK4vFi/c0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmZfT-0005RK-49;
	Wed, 22 Jul 2026 16:19:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmZfR-0005R8-So
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 16:19:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=l8+OeARHYQrDsVHUr5QMpZrY1lQ6Atr2COgysxhqpdo=; b=MpOYo2+lCkf//hUCwcdFDwNP01
 NsPyU4y7PUJ9B+O8xTarC/O+/wrWwkrDxAViUol2GEHYOsJ/wV2vl2NY9S1brwyyDeLGn65+zbbKB
 6Pgo5RUuX83xhQ04xu8+BV9LqSn5SR06boGw1/JVGPoxvA43tr6qspIj3ABjr3IzGcII=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l8+OeARHYQrDsVHUr5QMpZrY1lQ6Atr2COgysxhqpdo=; b=n
 A++ZE44Dw2sbd7Cd35aIBrlnTyeQnbqjx1uuMzIPY43hoRzNgeOriy7Zj8SZvK5nJb11nmL4drApZ
 X6s0ZTx6bGTUCGncRpyboFgagEcuT2UKXKP0qjh/XyfT3gEyn7d7zoqruJ9iK1wv9b20P2dI355oI
 aZIuggwQNl3X7jXo=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmZfO-0000JQ-MF for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 16:19:34 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so27191025e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784737159; x=1785341959; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l8+OeARHYQrDsVHUr5QMpZrY1lQ6Atr2COgysxhqpdo=;
 b=DJnmFnmlnAB6geGkVHX+pCxerD/6YmP4HzR/IvC+htlJUQF4/0x6Pvp8pMWaHNmu+E
 Woi5sUp/3fTEQtz0ayVkkLAAr4L3upPvaltHVIrGPjbcfqQtV/XLWO0kFNYnDkmigMR4
 YK6a9O50/BifphEtJBkBuZ4llc8TbZPBCUqdBlOtHgq3MAMzUG89dd85pwg+xk/u+z5Z
 O3NqBORkXoWv0u58Yye3ILGvgcCO6lnlsQAy2UNgNnbImRS0z9I4M8z3FZvkAYwbzqtg
 O5ILN0I4mvbFQ4ZgQ7XfJnWjq8EiT9vCGTSMwrd+tXMOZdu5fLMlsRaQQll6AUo6Nz+1
 6sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784737159; x=1785341959;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l8+OeARHYQrDsVHUr5QMpZrY1lQ6Atr2COgysxhqpdo=;
 b=rvE7goomCOuCngIWrjkvi09Luj5X4J9tlhf4Rh9xcXzcZDpzw/aND007XmXn+E5w5R
 fR5BtqawiCP2jxGChosIWqBfqPO9DQ0xnyYS/n9hSUdY9fyEDJUChy0xdSVLC3GYL/Lk
 D9w1/yUjhYPhCEAi+8CrOQxlCstsapMK8dO/KYNJBWnxrx20RzRoO2oXMaNvzBqaOe8+
 API/oyZV66cI4ak8RE7Oz0ft7hnZSs2/Y0py5pCLKaviTnfiHXuYw5lZVo0mvcrSN8gn
 Nr6fGBdmT7a7x3ItTsZURzgY7MKyCWxVwOCCQg834Bqz1/lBqAwNpTdI052WHqvh/Ot2
 xaNw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCF3vnODJy/GTt9MSclD1vwdpEa8gcyhNv97wN5AnvaBvuhxeWHwsOTqPfn5VXSoTLyPm553hVMoIAffUC@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy6jxyeEMffj6JuUEVb98YaKqFqH7xtYwCLrx1/l6DDvyS6IEn0
 cVl44ufoj9TXE+GdCAQujt204vrSX3BFxnhPyxnH1488dF1CUsqizxUMg93TUHHkoQ5sEN884Cc
 f7nq9zULrAZLdYqfu4cmQbVKO0/XMjapf5uLhSB5OJmuiEj7xGltjtxxFQSjeeI7FDKDaj3t4gU
 LyTFRZ/w==
X-Gm-Gg: AR+sD10CPOWkS60Du8yWjWiN+5Z/YNMeCBLKH3ePPDHWEGqXt1KGxVAy7O4Q86ET98A
 LgVDx+M3uMR+oaZOFyQrrqrWOogaH71agojOcJm0LYciJUU4URVfoue4Z98R66RE0CrVINLt9X+
 8CCbjY1mxxxo9fH3APWbJM5ZVjH7IIJ/Xr4c36rIG8te7GJcXGIpC5osO0B7ZFuDM6ze8FMd/kS
 2+1SDq2Vvu9JJXk5Q4wzDr/xOtivM88iQGgK9O6xygZfPTY2Un6+JUH4sXZEl1Pl3dBp4AUeIKg
 VPsiPg2nDy2iFHq0oMnSOA+BPH3xWUUNTop8duN7ep0OSWH4JyUlQrdx+MK5AgOLlh1WjMNWVRl
 8D8Ru+Qs25OV4EKrHkHtYrxEVIt5DxttAeBA54nMh7wTKVdx+yvPn5sULxFp54t1hmtGj2tD0PG
 pfkRFQ2aDwYf5eb/upzBP46hZes2MBXonDlhQLpnf6SihP0ZY9Cq3ZXx2QCWpEHrPMuUJouMPKp
 qM6g2AuEqYiucGcOeAQABmocsg/mESokB9gJhHM+KJuAYR6/Nobl2VPowt4X5ILKFURT6siMdt+
 2Nw=
X-Received: by 2002:a05:600c:138f:b0:493:b243:8ffc with SMTP id
 5b1f17b1804b1-4954a50d685mr306959775e9.35.1784737158745; 
 Wed, 22 Jul 2026 09:19:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4f24bcsm96351225e9.1.2026.07.22.09.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:19:18 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 16:19:18 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
X-Gerrit-Change-Number: 1801
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1801?usp=email>
X-Gerrit-Commit: 124ec07732bccc1fced2d8d37c71b761daf75f4f
In-Reply-To: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
References: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzI0NzcyMDAwLkljMTgzZjFmMWY5MDU2MTQ1NGI3YjExMjhjOTUyNTUzNjg0MjdjYzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1453e89886678dd6bcc62252e4a0476baa1b4a64-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmZfO-0000JQ-MF
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8439151159551964051=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8439151159551964051==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FnhYZq07Pe0="; charset=UTF-8

--FnhYZq07Pe0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1801?usp=3Demail )

Change subject: Make --x509-username-field work wit=
h Mbed TLS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

M=
ake --x509-username-field work with Mbed TLS

In pre-2=2E7 versions, this o=
ption was not available in the Mbed TLS
build=2E This was changed in 2=2E7,=
 but the option did not do anything when
Mbed TLS was selected as the crypt=
o library=2E Regardless of the field
chosen with --x509-username-field, Ope=
nVPN would always extract the CN
as username=2E

This could lead to a situa=
tion where an unintended certificate gets
accepted by OpenVPN: If we run wi=
th "--x509-username-field serialNumber"
and "--verify-x509-name 0x05 name",=
 OpenVPN would accept a certificate
with CN=3D0x05 and an incorrect serial =
number, while a certificate with
the correct serial number would be rejecte=
d=2E (Though note that to
exploit this, an attacker needs to make the CA si=
gn a certificate
with a hexadecimal number in the CN=2E)

This commit adds =
code to backend_x509_get_username to extract the
correct field values from =
X509 certificates=2E It also changes the
behavior of the function to match =
the OpenSSL version when the output
buffer is too small=2E (With Mbed TLS, =
the function would silently
truncate the output and return SUCCESS=2E)

It =
also adds unit tests for extracting the values of different fields=2E

Desp=
ite this commit fixing a CVE, we have decided not to keep it under
embargo =
until the release of the next version because it is unlikely to
be exploita=
ble in practice: Someone has to run OpenVPN 2=2E7 with Mbed
TLS, use the --=
x509-username-field option even though it didn't exist in
Mbed TLS builds o=
f earlier versions, not notice that the intended
certificate is *not* accep=
ted, and then an attacker has to get the CA to
sign a certificate with a we=
ird common name=2E

CVE: 2026-63650
Github: openvpn/openvpn-private-issues#=
144
Reported-By: Hcamael
Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (www=2Eai=
pyaipy=2Ecom)
Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
Signed-o=
ff-by: Max Fillinger <maximilian=2Efillinger@sentyron=2Ecom>
Acked-by: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1801
Message-Id: <20260722152521=2E22272-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg37773=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/ssl_verify_mbedtls=2Ec
M tests/unit_tests/op=
envpn/test_ssl=2Ec
2 files changed, 199 insertions(+), 29 deletions(-)




=
diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mb=
edtls=2Ec
index ad5479c=2E=2E2a09e86 100644
--- a/src/openvpn/ssl_verify_mb=
edtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -137,19 +137,133 @@
 =
    return false;
 }
 
+static const char *
+fieldname_to_oid(const char *f=
ieldname)
+{
+    if (strcmp(fieldname, "C") =3D=3D 0)
+    {
+        retu=
rn MBEDTLS_OID_AT_COUNTRY;
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

Gerrit-MessageType: merged
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic183f1f1f90561=
454b7b1128c95255368427cc4a
Gerrit-Change-Number: 1801
Gerrit-PatchSet: 4
Ge=
rrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--FnhYZq07Pe0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1801?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Make --x509-username-field work with Mbed =
TLS<br><br>In pre-2=2E7 versions, this option was not available in the Mbed=
 TLS<br>build=2E This was changed in 2=2E7, but the option did not do anyth=
ing when<br>Mbed TLS was selected as the crypto library=2E Regardless of th=
e field<br>chosen with --x509-username-field, OpenVPN would always extract =
the CN<br>as username=2E<br><br>This could lead to a situation where an uni=
ntended certificate gets<br>accepted by OpenVPN: If we run with &quot;--x50=
9-username-field serialNumber&quot;<br>and &quot;--verify-x509-name 0x05 na=
me&quot;, OpenVPN would accept a certificate<br>with CN=3D0x05 and an incor=
rect serial number, while a certificate with<br>the correct serial number w=
ould be rejected=2E (Though note that to<br>exploit this, an attacker needs=
 to make the CA sign a certificate<br>with a hexadecimal number in the CN=
=2E)<br><br>This commit adds code to backend_x509_get_username to extract t=
he<br>correct field values from X509 certificates=2E It also changes the<br=
>behavior of the function to match the OpenSSL version when the output<br>b=
uffer is too small=2E (With Mbed TLS, the function would silently<br>trunca=
te the output and return SUCCESS=2E)<br><br>It also adds unit tests for ext=
racting the values of different fields=2E<br><br>Despite this commit fixing=
 a CVE, we have decided not to keep it under<br>embargo until the release o=
f the next version because it is unlikely to<br>be exploitable in practice:=
 Someone has to run OpenVPN 2=2E7 with Mbed<br>TLS, use the --x509-username=
-field option even though it didn&#39;t exist in<br>Mbed TLS builds of earl=
ier versions, not notice that the intended<br>certificate is *not* accepted=
, and then an attacker has to get the CA to<br>sign a certificate with a we=
ird common name=2E<br><br>CVE: 2026-63650<br>Github: openvpn/openvpn-privat=
e-issues#144<br>Reported-By: Hcamael<br>Reported-By: =E7=AB=A0=E9=B1=BC=E5=
=93=A5 (www=2Eaipyaipy=2Ecom)<br>Change-Id: Ic183f1f1f90561454b7b1128c95255=
368427cc4a<br>Signed-off-by: Max Fillinger &lt;maximilian=2Efillinger@senty=
ron=2Ecom&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801<br>Message=
-Id: &lt;20260722152521=2E22272-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3777=
3=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M tests/unit_tests/openvpn/t=
est_ssl=2Ec<br>2 files changed, 199 insertions(+), 29 deletions(-)<br><br><=
/pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_=
verify_mbedtls=2Ec</span><br><span>index ad5479c=2E=2E2a09e86 100644</span>=
<br><span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/sr=
c/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -137,19 +137,133 @@</sp=
an><br><span>     return false;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+fieldname_to_oid(const cha=
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
RT(cn !=3D NULL &amp;&amp; cn_len &gt; 0 &amp;&amp; cert !=3D NULL);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT=
(cn !=3D NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (x509_username_field =3D=3D NULL)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        goto fail;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    name =3D &amp;cert-&gt;subject;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (strcmp(x509_username_field, &quot;serialNumber&=
quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (cn_le=
n &lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto fai=
l;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cn[0] =3D &#39;0&#3=
9;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cn[1] =
=3D &#39;x&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     size_t cn_index =3D 2;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        bool leading_zeros =3D true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        for (size_t i =3D 0; i &lt; cert-&gt;seria=
l=2Elen; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            uint=
8_t serial_byte =3D cert-&gt;serial=2Ep[i];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (leading_zeros &amp;&amp; serial_byt=
e =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            le=
ading_zeros =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (cn_index &gt; cn_len - 3)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                goto fail;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            snprintf(&amp;cn[cn_index], cn_len - cn_ind=
ex, &quot;%02X&quot;, serial_byte);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            cn_index +=3D 2;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return SUCCESS;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* Find common name */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const char *field_oid =3D fieldname_to_oid(=
x509_username_field);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (field_oid =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       goto fail;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Find field_oid in the subjec=
t name=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbe=
dtls_x509_name *name =3D &amp;cert-&gt;subject;</span><br><span>     while =
(name !=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (0 =3D=3D memcmp(name-&gt;oid=2Ep, MBEDTLS_OID=
_AT_CN, MBEDTLS_OID_SIZE(MBEDTLS_OID_AT_CN)))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (strlen(field_oid) =3D=3D name-&gt;oid=
=2Elen</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &=
amp;&amp; 0 =3D=3D memcmp(name-&gt;oid=2Ep, field_oid, name-&gt;oid=2Elen))=
</span><br><span>         {</span><br><span>             break;</span><br><=
span>         }</span><br><span>@@ -160,22 +274,23 @@</span><br><span>     =
/* Not found, return an error if this is the peer&#39;s certificate */</spa=
n><br><span>     if (name =3D=3D NULL)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        goto fail;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* Found, extract CN */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (cn_len &gt; name-&gt;val=2Elen)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Check that we have room in the buf=
fer, including the terminating &#39;/0&#39; byte=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (cn_len &lt;=3D name-&gt;val=2Ele=
n)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        memcpy(cn, name-&gt;val=2Ep, name-&gt;val=2Elen);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        cn[name-&gt;val=2Elen] =3D =
&#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  goto fail;</span><br><span>     }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        memcpy(=
cn, name-&gt;val=2Ep, cn_len);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        cn[cn_len - 1] =3D &#39;\0&#39;;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
emcpy(cn, name-&gt;val=2Ep, name-&gt;val=2Elen);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    cn[name-&gt;val=2Elen] =3D &#39;\0&#39;;</=
span><br><span> </span><br><span>     return SUCCESS;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+fail:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    cn[0] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return FAILURE;</span><br><span> }</span><br><span> </span><br=
><span> #if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span>diff =
--git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/te=
st_ssl=2Ec</span><br><span>index 0e9cecf=2E=2Ed473d67 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -775,7 +775,7 @@</span><b=
r><span> static openvpn_x509_cert_t *</span><br><span> get_certificate(cons=
t char *cert_str)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    BIO *in =3D BIO_new_mem_buf((char *)cert1, -1);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    BIO *in =3D BIO_new_mem_=
buf((char *)cert_str, -1);</span><br><span>     assert_non_null(in);</span>=
<br><span>     X509 *cert =3D PEM_read_bio_X509(in, NULL, NULL, NULL);</spa=
n><br><span>     assert_non_null(cert);</span><br><span>@@ -790,10 +790,37 =
@@</span><br><span> }</span><br><span> #endif</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Generated with:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * openssl req -x509 -newkey ec =
-pkeyopt ec_paramgen_curve:secp384r1 -keyout - -noenc -sha256 -days 3650 \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * -subj &#39;/CN=3D=
ovpn-test-secp384r1/O=3DOpenVPN Unit Test Example Corp=2E/OU=3DCert Details=
 Dept=2E&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * -ad=
dext &#39;subjectAltName=3DDNS:unittest=2Eexample=2Ecom&#39; -addext &#39;e=
xtendedKeyUsage=3DclientAuth&#39; */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static const char *cert_details_test_cert =3D</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN CERTIFICATE=
-----\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &q=
uot;MIICkzCCAhqgAwIBAgIUKDsZM+PApGdaD2QF9iYaxoFJAkowCgYIKoZIzj0EAwIw\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;ZTEcMBoG=
A1UEAwwTb3Zwbi10ZXN0LXNlY3AzODRyMTEoMCYGA1UECgwfT3BlblZQ\n&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;TiBVbml0IFRlc3QgRXhh=
bXBsZSBDb3JwLjEbMBkGA1UECwwSQ2VydCBEZXRhaWxz\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;IERlcHQuMB4XDTI2MDcwNzEwNTIxNlo=
XDTM2MDcwNDEwNTIxNlowZTEcMBoGA1UE\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;AwwTb3Zwbi10ZXN0LXNlY3AzODRyMTEoMCYGA1UECgw=
fT3BlblZQTiBVbml0IFRl\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;c3QgRXhhbXBsZSBDb3JwLjEbMBkGA1UECwwSQ2VydCBEZXRhaWxzIER=
lcHQuMHYw\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;EAYHKoZIzj0CAQYFK4EEACIDYgAEOlKoQVk+wbBD6V/6kg+/oHfqF0Dq08LlCL+B\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;om4R=
hutG99QDrow251Ps+Ds/7LQYYRA8+hHyEFrmGM+j2o6KhS5K2uA6dIZL4zLK\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;vl0NeF2M61Z8tt/I=
jrFZd+CrEANco4GKMIGHMB0GA1UdDgQWBBSEyG6m+QdWazeg\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;0CHN7q0edJlqMjAfBgNVHSMEGDAW=
gBSEyG6m+QdWazeg0CHN7q0edJlqMjAPBgNV\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;HRMBAf8EBTADAQH/MB8GA1UdEQQYMBaCFHVuaXR0=
ZXN0LmV4YW1wbGUuY29tMBMG\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;A1UdJQQMMAoGCCsGAQUFBwMCMAoGCCqGSM49BAMCA2cAMGQCMCyK=
7aQcyKGW8BWQ\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;UOYqbJUJZJcviP6ACgJRzK6pgkqt9gY0E0Tb00Qh6D5dBV5i3wIwCMhSgpVJxDrc=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;p=
RfligoK8bmv4HEgnV6BDeoDYd41WVMpE9u1issQDHY0SnWC7d9q\n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----END CERTIFICATE-----=
\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char=
 *const cert_details_cname =3D &quot;ovpn-test-secp384r1&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+const char *const cert_details_=
org =3D &quot;OpenVPN Unit Test Example Corp=2E&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+const char *const cert_details_org_unit =
=3D &quot;Cert Details Dept=2E&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+const char *const cert_details_serial_number =3D &quot;22=
9677570263950905252266749734450551528150860362&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+const char *const cert_details_serial_num=
ber_hex =3D &quot;0x283B1933E3C0A4675A0F6405F6261AC68149024A&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</spa=
n><br><span> crypto_test_print_cert_details(void **state)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_x509_cer=
t_t *cert =3D get_certificate(cert1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    openvpn_x509_cert_t *cert =3D get_certificate(cert_de=
tails_test_cert);</span><br><span>     struct gc_arena gc =3D gc_new();</sp=
an><br><span> </span><br><span>     const char *fp =3D backend_x509_get_ser=
ial_hex(cert, &amp;gc);</span><br><span>@@ -801,29 +828,57 @@</span><br><sp=
an>     /* we messed this up between TLS libraries=2E But let&#39;s at leas=
t notice in</span><br><span>      * the future =2E=2E=2E*/</span><br><span>=
 #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    assert_string_equal(fp, &quot;82:6B:DD:CC:BD:E5:5E:B7:08:=
F1:2D:68:00:3C:24:DE&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_string_equal(fp, &quot;28:3B:19:33:E3:C0:A4:67:5A:0F:64=
:05:F6:26:1A:C6:81:49:02:4A&quot;);</span><br><span> #else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    assert_string_equal(fp, &quot;82:6=
b:dd:cc:bd:e5:5e:b7:08:f1:2d:68:00:3c:24:de&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(fp, &quot;28:3b:1=
9:33:e3:c0:a4:67:5a:0f:64:05:f6:26:1a:c6:81:49:02:4a&quot;);</span><br><spa=
n> #endif</span><br><span> </span><br><span>     const char *sn =3D backend=
_x509_get_serial(cert, &amp;gc);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    assert_string_equal(sn, &quot;173359713849739808110610111821=
055272158&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(sn, cert_details_serial_number);</span><br><span> </s=
pan><br><span>     char username[TLS_USERNAME_LEN + 1] =3D { 0 }; /* null-t=
erminated */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int ret =3D backend_x509_get_username(username, sizeof(usernam=
e), &quot;CN&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                      cert);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int ret =3D backend_x509_get_username(username=
, sizeof(username), &quot;CN&quot;, cert);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    assert_string_equal(username, &q=
uot;ovpn-test-ec1&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(username, cert_details_cname);</span><br><spa=
n>     assert_int_equal(ret, SUCCESS);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_CRYPTO_MBEDTLS</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* mbed TLS does not impleme=
nt this */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D=
 backend_x509_get_username(username, sizeof(username), &quot;serialNumber&q=
uot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                    cert);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ret =3D backend_x509_get_username(username, sizeof(username), &q=
uot;serialNumber&quot;, cert);</span><br><span>     assert_int_equal(ret, S=
UCCESS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_st=
ring_equal(username, &quot;0x826BDDCCBDE55EB708F12D68003C24DE&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(username, cert_d=
etails_serial_number_hex);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D =
backend_x509_get_username(username, sizeof(username), &quot;O&quot;, cert);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(username, cert=
_details_org);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(ret, SUCCESS);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D backend_x509_get_username(username, sizeof(username), &quot;OU&quot;, c=
ert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(username,=
 cert_details_org_unit);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(ret, SUCCESS);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Check that FAILURE is returned if a field does not exist=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D backend_x50=
9_get_username(username, sizeof(username), &quot;SN&quot;, cert);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ret, FAI=
LURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Check that FAILURE is ret=
urned for invalid field names=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ret =3D backend_x509_get_username(username, sizeof(user=
name), &quot;invalidField&quot;, cert);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(ret, FAILURE);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Check that FAILURE is returned if the output buffer=
 is too small=2E Do this separately</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * for a subject field and for the serial number, becau=
se these are different code paths=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * First case: Can&#39;t fit all characters=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ret =3D backend_x509_get_username=
(username, strlen(cert_details_cname) / 2, &quot;CN&quot;, cert);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ret, FAI=
LURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D b=
ackend_x509_get_username(username, strlen(cert_details_serial_number_hex) /=
 2, &quot;serialNumber&quot;, cert);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(ret, FAILURE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Second case: Can fit the characters but not the termi=
nating &#39;\0&#39;=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ret =3D backend_x509_get_username(username, strlen(cert_details_c=
name), &quot;CN&quot;, cert);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(ret, FAILURE);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ret =3D backend_x509_get_username(username, s=
trlen(cert_details_serial_number_hex), &quot;serialNumber&quot;, cert);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(re=
t, FAILURE);</span><br><span> </span><br><span>     gc_free(&amp;gc);</span=
><br><span>     free_certificate(cert);</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?u=
sp=3Demail">change 1801</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1801?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1801 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner=
: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--FnhYZq07Pe0=--


--===============8439151159551964051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8439151159551964051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8439151159551964051==--

