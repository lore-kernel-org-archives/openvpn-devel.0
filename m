Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEAAC44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b+kGEEzKC5J15179nzpuN0dEUyJ4urSdUaQ/QgK5CXU=; b=Gp/+2JiPQcd6OLskP2OuIuMmpl
	2Qi9lBQGxq7h5dKj/sy/kcXUwOfqOpzqBUMGW/noT7NRWmMykA+oijLK2ZOArnIO7bx3XucSivolb
	RvVMQ/De4BvUtaIdtmBYCVz/mYcoBbr8HL7YdnlxDxZ8JWz29Y+YyfVKxY77UtRlDsU8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmWny-00034k-AA;
	Wed, 22 Jul 2026 13:16:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmWnw-00034b-CS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:16:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fcGLXXOu78WA9q/2jLMWrEMefdWx2u3/wIbvbmJSPTs=; b=ZRLrmHTIRNW74lF1XZknsmktQ2
 mixC3M5syamVaAUbQGlFxQPUr/opbXdKLWSS+O3nWnGbAi8JoS3GLwSRP0SEPXQQv7N3o9JspJOpK
 tWMQFtLJ9lVdNOprNJjMfKn/oL2U2w21gLJ5RCX/cOV3lB1rgWD9DZDwOp0FQ2sLs0PM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fcGLXXOu78WA9q/2jLMWrEMefdWx2u3/wIbvbmJSPTs=; b=G
 kA+jUuFYgl6i8Vi3lGcEO8pglklQKDJvCKJrpCzGXQPuIjuc0PRTs4ZwFG9Vn2MjQRPDipFvat8dH
 pdeQcvTu6t1ahPaS8EIIoSVnP7sFIvUY+6YuSkRwQWtXCJh/TscVzd9+K3e8Df3QT1ZFmbF5GVXyg
 8oFvg27a+Z3nYlsI=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmWnt-0006pV-GJ for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:16:09 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f84023916so1106505f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784726154; x=1785330954; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fcGLXXOu78WA9q/2jLMWrEMefdWx2u3/wIbvbmJSPTs=;
 b=UZ+iTvtvYadKHAC3hrncMU8Q9jMuGeX9j3IRLfEDc1vVAaxU2CjS38vwQgG99bWzsR
 8+83E9v1vr3BKE2+sYFQ3zFPAM7lng1vHsnPeiolIK/2F9A5H7rDY6mcobzvQLuX0WVe
 m+ZuuDldjsKV1cokTGE2AblgrQwVqMtHYECNQOoqAi9MABGg3LIVEIoiqPEEjnCITaKl
 AALgKTzON7bSW4t0D+tbSRXkLCDGNgH18rw+CwTv16bWR69HDbggskaG4zNWRT63do8v
 HrzyPSJFY7mQpGSpUEAnoq4Yohz9qqMwWOH1jC34TEKHkgAh+DUAgn1dUIKViJGy2pOo
 l4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784726154; x=1785330954;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fcGLXXOu78WA9q/2jLMWrEMefdWx2u3/wIbvbmJSPTs=;
 b=hZAiVLqrnMJXPguhkm/OUHKUNl/FBauyMjJR3zG8rwZ0EIW7cGypHGpEmSRxXLjN3m
 YlQpGMPmjpgPoVqt3+5mI7wb2utrjhkzIJ0V1IMHY2lPx2o/OWoW0W37UBxelH2bWJmA
 SLXxj0yYf1ruRzikBiNcgEDSaavrzZw+yX6ZDcrqZEwv7+q1dkjIK2dX7MzrnUzHU2bn
 HK7UmbFNePoCQWq2T49ogLvZucPm06F27gylrEbUMhCduiQPlXnNsvEz+15hN4VkKNAS
 CIuUmf7WDSzV+PRJRsSrrNBEhjkW3jZybtyjgDXOG2F+xV1/u5pfAUHJGA8LX0H8y2XT
 5sqA==
X-Gm-Message-State: AOJu0YxzPtn5NVZVRfO1KpPo2C77xdeZwhmh/P3JqG6seGTlX7TK44hx
 hBuVX44+fwzj+/M0885TnWbxEahytTIZqBV6s6ZbpoEdfPyIWJmj5Ry1SQ1UIB6QnMYbEc+D2hw
 LT+4NvnDa6od+C0Vmt2M3pVYzg1+DdF2q9QoeSeIXnNGztKyrVI1Eu2NHYRJ+F/A/rUQIdW4+6d
 aPE8ySYg==
X-Gm-Gg: AR+sD11y+bmS8OF27ed0xonab3W4A7VuGN8YafYCD6pZe+P/hN81J6KtDtHYVRNFOJN
 4CzCe9wjaHMxIA5Dn8wLo5kXwx01yNZnYgJeTJSSS2WvEEqvkTINHmjD1JsJNB6l4sMuhYPSsw7
 WJ1iBu8Ln84+s1zo3jmzabJAh716JYDusapReYszdMxpx2emKhVDiLSzpjVsehV6I5mhDdyclv4
 QCJsuVDDwh9bx86vSWQWlWwkBHwLWLzSdbUoPjOv4xyQzJyhDAVFl/0+OZ5g1LN4tQJr2JBqtwN
 iq7SwuXTwO5wy0LLXyyZyC/+lu1/+xLPOdX5g4anwcsdfaG0ouOtVvQH/4mPZYzsB6qTcajvjQB
 DZH3003gTNPoefCOCOuCANkLuTrQBL8WcP0Y+jdDzQUZfjtHMvjbc05XSxFRS0Z56d5fKp6G4Mo
 4kwfXUSr6b8afhC/Zp1eB5k5qI4bDsHDJJvLU/nJxP2e7+R5/bQt7cvF8u8yZtnle69ayAx8Bm+
 zZ6jnPVgB8PULMl1sXSz75MxiNo+mrak30gzE+PtCFUVpJmu1+PlXU9c0IsmGhYnKQn
X-Received: by 2002:a05:6000:3108:b0:47f:7b11:5c26 with SMTP id
 ffacd0b85a97d-47f7b1166d2mr14125239f8f.8.1784726153670; 
 Wed, 22 Jul 2026 06:15:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c631fdsm6018405f8f.28.2026.07.22.06.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:15:53 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 13:15:52 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
X-Gerrit-Change-Number: 1801
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1801?usp=email>
X-Gerrit-Commit: c2377404b5dc4a9c545ab38800bb5af606130c82
In-Reply-To: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
References: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzI0NzcyMDAwLkljMTgzZjFmMWY5MDU2MTQ1NGI3YjExMjhjOTUyNTUzNjg0MjdjYzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <44b7aea13ca8dbd447dd002a161778fe0b05bab4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmWnt-0006pV-GJ
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
Content-Type: multipart/mixed; boundary="===============6445198058453954100=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6445198058453954100==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4vDLsGx/oxA="; charset=UTF-8

--4vDLsGx/oxA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1801?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: Make --x509-username-field work with Mbed TLS
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make --x509-username-fiel=
d work with Mbed TLS

In pre-2=2E7 versions, this option was not available =
in the Mbed TLS
build=2E This was changed in 2=2E7, but the option did not =
do anything when
Mbed TLS was selected as the crypto library=2E Regardless =
of the field
chosen with --x509-username-field, OpenVPN would always extrac=
t the CN
as username=2E

This could lead to a situation where an unintended=
 certificate gets
accepted by OpenVPN: If we run with "--x509-username-fiel=
d serialNumber"
and "--verify-x509-name 0x05 name", OpenVPN would accept a =
certificate
with CN=3D0x05 and an incorrect serial number, while a certific=
ate with
the correct serial number would be rejected=2E (Though note that t=
o
exploit this, an attacker needs to make the CA sign a certificate
with a =
hexadecimal number in the CN=2E)

This commit adds code to extract the corr=
ect field values from X509
certificates=2E It also adds unit tests for extr=
acting the values of
different fields=2E

Despite this commit fixing a CVE,=
 we have decided not to keep it under
embargo until the release of the next=
 version because it is unlikely to
be exploitable in practice: Someone has =
to run OpenVPN 2=2E7 with Mbed
TLS, use the --x509-username-field option ev=
en though it didn't exist in
Mbed TLS builds of earlier versions, not notic=
e that the intended
certificate is *not* accepted, and then an attacker has=
 to get the CA to
sign a certificate with a weird common name=2E

CVE: 2026=
-63650
Github: openvpn/openvpn-private-issues#144
Reported-By: Hcamael
Repo=
rted-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (www=2Eaipyaipy=2Ecom)
Change-Id: Ic18=
3f1f1f90561454b7b1128c95255368427cc4a
Signed-off-by: Max Fillinger <maximil=
ian=2Efillinger@sentyron=2Ecom>
---
M src/openvpn/ssl_verify_mbedtls=2Ec
M =
tests/unit_tests/openvpn/test_ssl=2Ec
2 files changed, 181 insertions(+), 2=
2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/01/1801/2

diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/o=
penvpn/ssl_verify_mbedtls=2Ec
index ad5479c=2E=2Eeb96796 100644
--- a/src/o=
penvpn/ssl_verify_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -=
137,19 +137,133 @@
     return false;
 }
 
+static const char *
+fieldname_=
to_oid(const char *fieldname)
+{
+    if (strcmp(fieldname, "C") =3D=3D 0)
=
+    {
+        return MBEDTLS_OID_AT_COUNTRY;
+    }
+    else if (strcmp(=
fieldname, "ST") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_STATE;
+  =
  }
+    else if (strcmp(fieldname, "LOCALITY") =3D=3D 0)
+    {
+        r=
eturn MBEDTLS_OID_AT_LOCALITY;
+    }
+    else if (strcmp(fieldname, "O") =
=3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_ORGANIZATION;
+    }
+    e=
lse if (strcmp(fieldname, "OU") =3D=3D 0)
+    {
+        return MBEDTLS_OI=
D_AT_ORG_UNIT;
+    }
+    else if (strcmp(fieldname, "CN") =3D=3D 0)
+    =
{
+        return MBEDTLS_OID_AT_CN;
+    }
+    else if (strcmp(fieldname,=
 "GN") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_GIVEN_NAME;
+    }
+=
    else if (strcmp(fieldname, "SN") =3D=3D 0)
+    {
+        return MBEDT=
LS_OID_AT_SUR_NAME;
+    }
+    else if (strcmp(fieldname, "initials") =3D=
=3D 0)
+    {
+        return MBEDTLS_OID_AT_INITIALS;
+    }
+    else if =
(strcmp(fieldname, "pseudonym") =3D=3D 0)
+    {
+        return MBEDTLS_OI=
D_AT_PSEUDONYM;
+    }
+    else if (strcmp(fieldname, "title") =3D=3D 0)
+=
    {
+        return MBEDTLS_OID_AT_TITLE;
+    }
+    else if (strcmp(fie=
ldname, "generationQualifier") =3D=3D 0)
+    {
+        return MBEDTLS_OID=
_AT_GENERATION_QUALIFIER;
+    }
+    else if (strcmp(fieldname, "postalAdd=
ress") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_POSTAL_ADDRESS;
+   =
 }
+    else if (strcmp(fieldname, "postalCode") =3D=3D 0)
+    {
+        =
return MBEDTLS_OID_AT_POSTAL_CODE;
+    }
+    else if (strcmp(fieldname, "=
emailAddress") =3D=3D 0)
+    {
+        return MBEDTLS_OID_PKCS9_EMAIL;
+ =
   }
+    else if (strcmp(fieldname, "uid") =3D=3D 0)
+    {
+        retur=
n MBEDTLS_OID_AT_UNIQUE_IDENTIFIER;
+    }
+    else if (strcmp(fieldname, =
"dnQualifier") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_DN_QUALIFIER=
;
+    }
+    else
+    {
+        return NULL;
+    }
+}
+
 result_t
 back=
end_x509_get_username(char *cn, size_t cn_len, char *x509_username_field, m=
bedtls_x509_crt *cert)
 {
-    mbedtls_x509_name *name;
+    ASSERT(cn !=3D=
 NULL && cert !=3D NULL);
 
-    ASSERT(cn !=3D NULL);
+    if (x509_userna=
me_field =3D=3D NULL)
+    {
+        goto fail;
+    }
 
-    name =3D &ce=
rt->subject;
+    if (strcmp(x509_username_field, "serialNumber") =3D=3D 0)=

+    {
+        if (cn_len < 2)
+        {
+            goto fail;
+      =
  }
+        cn[0] =3D '0';
+        cn[1] =3D 'x';
+        size_t cn_inde=
x =3D 2;
+        bool leading_zeros =3D true;
+        for (size_t i =3D 0=
; i < cert->serial=2Elen; i++)
+        {
+            uint8_t serial_byte =
=3D cert->serial=2Ep[i];
+            if (leading_zeros && serial_byte =3D=
=3D 0)
+            {
+                continue;
+            }
+          =
  leading_zeros =3D false;
+            if (cn_index >=3D cn_len)
+        =
    {
+                goto fail;
+            }
+            snprintf(&cn[=
cn_index], cn_len - cn_index, "%02X", serial_byte);
+            cn_index +=
=3D 2;
+        }
+        return SUCCESS;
+    }
 
-    /* Find common nam=
e */
+    const char *field_oid =3D fieldname_to_oid(x509_username_field);
=
+    if (field_oid =3D=3D NULL)
+    {
+        goto fail;
+    }
+
+    /*=
 Find field_oid in the subject name=2E */
+    mbedtls_x509_name *name =3D =
&cert->subject;
     while (name !=3D NULL)
     {
-        if (0 =3D=3D me=
mcmp(name->oid=2Ep, MBEDTLS_OID_AT_CN, MBEDTLS_OID_SIZE(MBEDTLS_OID_AT_CN))=
)
+        if (strlen(field_oid) =3D=3D name->oid=2Elen
+            && 0 =
=3D=3D memcmp(name->oid=2Ep, field_oid, name->oid=2Elen))
         {
      =
       break;
         }
@@ -160,10 +274,10 @@
     /* Not found, return an=
 error if this is the peer's certificate */
     if (name =3D=3D NULL)
    =
 {
-        return FAILURE;
+        goto fail;
     }
 
-    /* Found, ext=
ract CN */
+    /* Found, extract the value */
     if (cn_len > name->val=
=2Elen)
     {
         memcpy(cn, name->val=2Ep, name->val=2Elen);
@@ -171=
,11 +285,18 @@
     }
     else
     {
-        memcpy(cn, name->val=2Ep, c=
n_len);
+        memcpy(cn, name->val=2Ep, cn_len - 1);
         cn[cn_len =
- 1] =3D '\0';
     }
 
     return SUCCESS;
+
+fail:
+    if (cn_len > 0)
=
+    {
+        cn[0] =3D '\0';
+    }
+    return FAILURE;
 }
 
 #if MBEDT=
LS_VERSION_NUMBER >=3D 0x04000000
diff --git a/tests/unit_tests/openvpn/tes=
t_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 0e9cecf=2E=2E4ab6ee=
7 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests=
/openvpn/test_ssl=2Ec
@@ -775,7 +775,7 @@
 static openvpn_x509_cert_t *
 ge=
t_certificate(const char *cert_str)
 {
-    BIO *in =3D BIO_new_mem_buf((ch=
ar *)cert1, -1);
+    BIO *in =3D BIO_new_mem_buf((char *)cert_str, -1);
  =
   assert_non_null(in);
     X509 *cert =3D PEM_read_bio_X509(in, NULL, NUL=
L, NULL);
     assert_non_null(cert);
@@ -790,10 +790,35 @@
 }
 #endif
 
+/=
* Generated with:
+ * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_cur=
ve:secp384r1 -keyout - -noenc -sha256 -days 3650 \
+ * -subj '/CN=3Dovpn-te=
st-secp384r1/O=3DOpenVPN Unit Test Example Corp=2E/OU=3DCert Details Dept=
=2E'
+ * -addext 'subjectAltName=3DDNS:unittest=2Eexample=2Ecom' -addext 'e=
xtendedKeyUsage=3DclientAuth' */
+static const char *cert_details_test_cert=
 =3D
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIICkzCCAhqgAwIBAgIUKDsZM+P=
ApGdaD2QF9iYaxoFJAkowCgYIKoZIzj0EAwIw\n"
+    "ZTEcMBoGA1UEAwwTb3Zwbi10ZXN0=
LXNlY3AzODRyMTEoMCYGA1UECgwfT3BlblZQ\n"
+    "TiBVbml0IFRlc3QgRXhhbXBsZSBDb=
3JwLjEbMBkGA1UECwwSQ2VydCBEZXRhaWxz\n"
+    "IERlcHQuMB4XDTI2MDcwNzEwNTIxNl=
oXDTM2MDcwNDEwNTIxNlowZTEcMBoGA1UE\n"
+    "AwwTb3Zwbi10ZXN0LXNlY3AzODRyMTE=
oMCYGA1UECgwfT3BlblZQTiBVbml0IFRl\n"
+    "c3QgRXhhbXBsZSBDb3JwLjEbMBkGA1UE=
CwwSQ2VydCBEZXRhaWxzIERlcHQuMHYw\n"
+    "EAYHKoZIzj0CAQYFK4EEACIDYgAEOlKoQ=
Vk+wbBD6V/6kg+/oHfqF0Dq08LlCL+B\n"
+    "om4RhutG99QDrow251Ps+Ds/7LQYYRA8+h=
HyEFrmGM+j2o6KhS5K2uA6dIZL4zLK\n"
+    "vl0NeF2M61Z8tt/IjrFZd+CrEANco4GKMIG=
HMB0GA1UdDgQWBBSEyG6m+QdWazeg\n"
+    "0CHN7q0edJlqMjAfBgNVHSMEGDAWgBSEyG6m=
+QdWazeg0CHN7q0edJlqMjAPBgNV\n"
+    "HRMBAf8EBTADAQH/MB8GA1UdEQQYMBaCFHVua=
XR0ZXN0LmV4YW1wbGUuY29tMBMG\n"
+    "A1UdJQQMMAoGCCsGAQUFBwMCMAoGCCqGSM49BA=
MCA2cAMGQCMCyK7aQcyKGW8BWQ\n"
+    "UOYqbJUJZJcviP6ACgJRzK6pgkqt9gY0E0Tb00Q=
h6D5dBV5i3wIwCMhSgpVJxDrc\n"
+    "pRfligoK8bmv4HEgnV6BDeoDYd41WVMpE9u1issQ=
DHY0SnWC7d9q\n"
+    "-----END CERTIFICATE-----\n";
+const char *const cert=
_details_cname =3D "ovpn-test-secp384r1";
+const char *const cert_details_o=
rg =3D "OpenVPN Unit Test Example Corp=2E";
+const char *const cert_details=
_org_unit =3D "Cert Details Dept=2E";
+
 void
 crypto_test_print_cert_detai=
ls(void **state)
 {
-    openvpn_x509_cert_t *cert =3D get_certificate(cert=
1);
+    openvpn_x509_cert_t *cert =3D get_certificate(cert_details_test_ce=
rt);
     struct gc_arena gc =3D gc_new();
 
     const char *fp =3D backen=
d_x509_get_serial_hex(cert, &gc);
@@ -801,29 +826,42 @@
     /* we messed t=
his up between TLS libraries=2E But let's at least notice in
      * the fu=
ture =2E=2E=2E*/
 #if defined(ENABLE_CRYPTO_MBEDTLS)
-    assert_string_equ=
al(fp, "82:6B:DD:CC:BD:E5:5E:B7:08:F1:2D:68:00:3C:24:DE");
+    assert_stri=
ng_equal(fp, "28:3B:19:33:E3:C0:A4:67:5A:0F:64:05:F6:26:1A:C6:81:49:02:4A")=
;
 #else
-    assert_string_equal(fp, "82:6b:dd:cc:bd:e5:5e:b7:08:f1:2d:68:=
00:3c:24:de");
+    assert_string_equal(fp, "28:3b:19:33:e3:c0:a4:67:5a:0f:=
64:05:f6:26:1a:c6:81:49:02:4a");
 #endif
 
     const char *sn =3D backend_=
x509_get_serial(cert, &gc);
-    assert_string_equal(sn, "17335971384973980=
8110610111821055272158");
+    assert_string_equal(sn, "2296775702639509052=
52266749734450551528150860362");
 
     char username[TLS_USERNAME_LEN + 1]=
 =3D { 0 }; /* null-terminated */
 
-    int ret =3D backend_x509_get_usern=
ame(username, sizeof(username), "CN",
-                                    =
    cert);
+    int ret =3D backend_x509_get_username(username, sizeof(user=
name), "CN", cert);
 
-    assert_string_equal(username, "ovpn-test-ec1");
=
+    assert_string_equal(username, cert_details_cname);
     assert_int_equ=
al(ret, SUCCESS);
 
-#ifndef ENABLE_CRYPTO_MBEDTLS
-    /* mbed TLS does no=
t implement this */
-    ret =3D backend_x509_get_username(username, sizeof=
(username), "serialNumber",
-                                    cert);
+  =
  ret =3D backend_x509_get_username(username, sizeof(username), "serialNumb=
er", cert);
     assert_int_equal(ret, SUCCESS);
-    assert_string_equal(u=
sername, "0x826BDDCCBDE55EB708F12D68003C24DE");
-#endif
+    assert_string_=
equal(username, "0x283B1933E3C0A4675A0F6405F6261AC68149024A");
+
+    ret =
=3D backend_x509_get_username(username, sizeof(username), "O", cert);
+
+  =
  assert_string_equal(username, cert_details_org);
+    assert_int_equal(re=
t, SUCCESS);
+
+    ret =3D backend_x509_get_username(username, sizeof(user=
name), "OU", cert);
+
+    assert_string_equal(username, cert_details_org_u=
nit);
+    assert_int_equal(ret, SUCCESS);
+
+    /* Check that FAILURE is =
returned if a field does not exist=2E */
+    ret =3D backend_x509_get_user=
name(username, sizeof(username), "SN", cert);
+    assert_int_equal(ret, FA=
ILURE);
+
+    /* Check that FAILURE is returned for invalid field names=2E=
 */
+    ret =3D backend_x509_get_username(username, sizeof(username), "inv=
alidField", cert);
+    assert_int_equal(ret, FAILURE);
 
     gc_free(&gc)=
;
     free_certificate(cert);

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1801?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
Gerrit-Change-Numb=
er: 1801
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>

--4vDLsGx/oxA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>MaxF <strong>uploaded patch set =
#2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1801?usp=3Demail">View Change</a></p><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">Make --x50=
9-username-field work with Mbed TLS<br><br>In pre-2=2E7 versions, this opti=
on was not available in the Mbed TLS<br>build=2E This was changed in 2=2E7,=
 but the option did not do anything when<br>Mbed TLS was selected as the cr=
ypto library=2E Regardless of the field<br>chosen with --x509-username-fiel=
d, OpenVPN would always extract the CN<br>as username=2E<br><br>This could =
lead to a situation where an unintended certificate gets<br>accepted by Ope=
nVPN: If we run with &quot;--x509-username-field serialNumber&quot;<br>and =
&quot;--verify-x509-name 0x05 name&quot;, OpenVPN would accept a certificat=
e<br>with CN=3D0x05 and an incorrect serial number, while a certificate wit=
h<br>the correct serial number would be rejected=2E (Though note that to<br=
>exploit this, an attacker needs to make the CA sign a certificate<br>with =
a hexadecimal number in the CN=2E)<br><br>This commit adds code to extract =
the correct field values from X509<br>certificates=2E It also adds unit tes=
ts for extracting the values of<br>different fields=2E<br><br>Despite this =
commit fixing a CVE, we have decided not to keep it under<br>embargo until =
the release of the next version because it is unlikely to<br>be exploitable=
 in practice: Someone has to run OpenVPN 2=2E7 with Mbed<br>TLS, use the --=
x509-username-field option even though it didn&#39;t exist in<br>Mbed TLS b=
uilds of earlier versions, not notice that the intended<br>certificate is *=
not* accepted, and then an attacker has to get the CA to<br>sign a certific=
ate with a weird common name=2E<br><br>CVE: 2026-63650<br>Github: openvpn/o=
penvpn-private-issues#144<br>Reported-By: Hcamael<br>Reported-By: =E7=AB=A0=
=E9=B1=BC=E5=93=A5 (www=2Eaipyaipy=2Ecom)<br>Change-Id: Ic183f1f1f90561454b=
7b1128c95255368427cc4a<br>Signed-off-by: Max Fillinger &lt;maximilian=2Efil=
linger@sentyron=2Ecom&gt;<br>---<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br=
>M tests/unit_tests/openvpn/test_ssl=2Ec<br>2 files changed, 181 insertions=
(+), 22 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/01/1801/2</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br=
><span>index ad5479c=2E=2Eeb96796 100644</span><br><span>--- a/src/openvpn/=
ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=
=2Ec</span><br><span>@@ -137,19 +137,133 @@</span><br><span>     return fal=
se;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static const char *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+fieldname_to_oid(const char *fieldname)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (strcmp(fieldname, &quot;C&quot;) =3D=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_COUNT=
RY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname,=
 &quot;ST&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return MBEDTLS_OID_AT_STATE;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (strcmp(fieldname, &quot;LOCALITY&quot;) =3D=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_LOCALITY;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;O&quot;=
) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS=
_OID_AT_ORGANIZATION;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(strcmp(fieldname, &quot;OU&quot;) =3D=3D 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return MBEDTLS_OID_AT_ORG_UNIT;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (strcmp(fieldname, &quot;CN&quot;) =3D=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_CN;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quo=
t;GN&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn MBEDTLS_OID_AT_GIVEN_NAME;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (strcmp(fieldname, &quot;SN&quot;) =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return MBEDTLS_OID_AT_SUR_NAME;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;initials&quo=
t;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return MBEDT=
LS_OID_AT_INITIALS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
trcmp(fieldname, &quot;pseudonym&quot;) =3D=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return MBEDTLS_OID_AT_PSEUDONYM;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;title&quot;) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_O=
ID_AT_TITLE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(f=
ieldname, &quot;generationQualifier&quot;) =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return MBEDTLS_OID_AT_GENERATION_QUALIFIER;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;=
postalAddress&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return MBEDTLS_OID_AT_POSTAL_ADDRESS;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else if (strcmp(fieldname, &quot;postalCode&quot;) =3D=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_POSTA=
L_CODE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldn=
ame, &quot;emailAddress&quot;) =3D=3D 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return MBEDTLS_OID_PKCS9_EMAIL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else if (strcmp(fieldname, &quot;uid&quot;) =3D=3D 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_UNIQUE_I=
DENTIFIER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fie=
ldname, &quot;dnQualifier&quot;) =3D=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return MBEDTLS_OID_AT_DN_QUALIFIER;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> result_t</span><br=
><span> backend_x509_get_username(char *cn, size_t cn_len, char *x509_usern=
ame_field, mbedtls_x509_crt *cert)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mbedtls_x509_name *name;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(cn !=3D NULL &amp;&amp;=
 cert !=3D NULL);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ASSERT(cn !=3D NULL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (x509_username_field =3D=3D NULL)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        goto fail;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    name =3D &amp;cert-&gt;subject;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(x509_username_fi=
eld, &quot;serialNumber&quot;) =3D=3D 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (cn_len &lt; 2)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            goto fail;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     cn[0] =3D &#39;0&#39;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cn[1] =3D &#39;x&#39;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        size_t cn_index =3D 2;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        bool leading_zeros =3D true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        for (size_t i =3D 0;=
 i &lt; cert-&gt;serial=2Elen; i++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            uint8_t serial_byte =3D cert-&gt;serial=2Ep[i];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (leading_zeros=
 &amp;&amp; serial_byte =3D=3D 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                continue;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            leading_zeros =3D false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (cn_index &gt;=3D cn_len)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                goto fail;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            snprintf(&amp;cn[cn_in=
dex], cn_len - cn_index, &quot;%02X&quot;, serial_byte);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            cn_index +=3D 2;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return SUCCESS;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* Find common name */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *field_oid =
=3D fieldname_to_oid(x509_username_field);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (field_oid =3D=3D NULL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        goto fail;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Find fi=
eld_oid in the subject name=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    mbedtls_x509_name *name =3D &amp;cert-&gt;subject;</span>=
<br><span>     while (name !=3D NULL)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (0 =3D=3D memcmp(name-&gt=
;oid=2Ep, MBEDTLS_OID_AT_CN, MBEDTLS_OID_SIZE(MBEDTLS_OID_AT_CN)))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (strlen(field_oid=
) =3D=3D name-&gt;oid=2Elen</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            &amp;&amp; 0 =3D=3D memcmp(name-&gt;oid=2Ep, field_oid,=
 name-&gt;oid=2Elen))</span><br><span>         {</span><br><span>          =
   break;</span><br><span>         }</span><br><span>@@ -160,10 +274,10 @@<=
/span><br><span>     /* Not found, return an error if this is the peer&#39;=
s certificate */</span><br><span>     if (name =3D=3D NULL)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return=
 FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        go=
to fail;</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* Found, extract CN */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Found, extract the value */</spa=
n><br><span>     if (cn_len &gt; name-&gt;val=2Elen)</span><br><span>     {=
</span><br><span>         memcpy(cn, name-&gt;val=2Ep, name-&gt;val=2Elen);=
</span><br><span>@@ -171,11 +285,18 @@</span><br><span>     }</span><br><sp=
an>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        memcpy(cn, name-&gt;val=2Ep, cn_len);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        memcpy(cn, name-&gt;val=2Ep=
, cn_len - 1);</span><br><span>         cn[cn_len - 1] =3D &#39;\0&#39;;</s=
pan><br><span>     }</span><br><span> </span><br><span>     return SUCCESS;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+fail:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (cn_len &gt; 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cn[0] =3D &#39;\0&#39;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return FAILURE;</span><br><span> }</span><br><span> </span><b=
r><span> #if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/t=
est_ssl=2Ec</span><br><span>index 0e9cecf=2E=2E4ab6ee7 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -775,7 +775,7 @@</span><=
br><span> static openvpn_x509_cert_t *</span><br><span> get_certificate(con=
st char *cert_str)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    BIO *in =3D BIO_new_mem_buf((char *)cert1, -1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    BIO *in =3D BIO_new_mem=
_buf((char *)cert_str, -1);</span><br><span>     assert_non_null(in);</span=
><br><span>     X509 *cert =3D PEM_read_bio_X509(in, NULL, NULL, NULL);</sp=
an><br><span>     assert_non_null(cert);</span><br><span>@@ -790,10 +790,35=
 @@</span><br><span> }</span><br><span> #endif</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Generated with:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * openssl req -x509 -newkey ec=
 -pkeyopt ec_paramgen_curve:secp384r1 -keyout - -noenc -sha256 -days 3650 \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * -subj &#39;/CN=
=3Dovpn-test-secp384r1/O=3DOpenVPN Unit Test Example Corp=2E/OU=3DCert Deta=
ils Dept=2E&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
-addext &#39;subjectAltName=3DDNS:unittest=2Eexample=2Ecom&#39; -addext &#3=
9;extendedKeyUsage=3DclientAuth&#39; */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static const char *cert_details_test_cert =3D</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN CERTIFIC=
ATE-----\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &quot;MIICkzCCAhqgAwIBAgIUKDsZM+PApGdaD2QF9iYaxoFJAkowCgYIKoZIzj0EAwIw\n&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;ZTEcM=
BoGA1UEAwwTb3Zwbi10ZXN0LXNlY3AzODRyMTEoMCYGA1UECgwfT3BlblZQ\n&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;TiBVbml0IFRlc3QgR=
XhhbXBsZSBDb3JwLjEbMBkGA1UECwwSQ2VydCBEZXRhaWxz\n&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &quot;IERlcHQuMB4XDTI2MDcwNzEwNTIxN=
loXDTM2MDcwNDEwNTIxNlowZTEcMBoGA1UE\n&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    &quot;AwwTb3Zwbi10ZXN0LXNlY3AzODRyMTEoMCYGA1UEC=
gwfT3BlblZQTiBVbml0IFRl\n&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    &quot;c3QgRXhhbXBsZSBDb3JwLjEbMBkGA1UECwwSQ2VydCBEZXRhaWxzI=
ERlcHQuMHYw\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &quot;EAYHKoZIzj0CAQYFK4EEACIDYgAEOlKoQVk+wbBD6V/6kg+/oHfqF0Dq08LlCL+B\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;om=
4RhutG99QDrow251Ps+Ds/7LQYYRA8+hHyEFrmGM+j2o6KhS5K2uA6dIZL4zLK\n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;vl0NeF2M61Z8tt=
/IjrFZd+CrEANco4GKMIGHMB0GA1UdDgQWBBSEyG6m+QdWazeg\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;0CHN7q0edJlqMjAfBgNVHSMEGD=
AWgBSEyG6m+QdWazeg0CHN7q0edJlqMjAPBgNV\n&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;HRMBAf8EBTADAQH/MB8GA1UdEQQYMBaCFHVuaX=
R0ZXN0LmV4YW1wbGUuY29tMBMG\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;A1UdJQQMMAoGCCsGAQUFBwMCMAoGCCqGSM49BAMCA2cAMGQCMC=
yK7aQcyKGW8BWQ\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &quot;UOYqbJUJZJcviP6ACgJRzK6pgkqt9gY0E0Tb00Qh6D5dBV5i3wIwCMhSgpVJxD=
rc\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot=
;pRfligoK8bmv4HEgnV6BDeoDYd41WVMpE9u1issQDHY0SnWC7d9q\n&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----END CERTIFICATE---=
--\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const ch=
ar *const cert_details_cname =3D &quot;ovpn-test-secp384r1&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+const char *const cert_detail=
s_org =3D &quot;OpenVPN Unit Test Example Corp=2E&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+const char *const cert_details_org_uni=
t =3D &quot;Cert Details Dept=2E&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> void</span><br><span> crypto_test_pri=
nt_cert_details(void **state)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    openvpn_x509_cert_t *cert =3D get_certificat=
e(cert1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvp=
n_x509_cert_t *cert =3D get_certificate(cert_details_test_cert);</span><br>=
<span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><sp=
an>     const char *fp =3D backend_x509_get_serial_hex(cert, &amp;gc);</spa=
n><br><span>@@ -801,29 +826,42 @@</span><br><span>     /* we messed this up=
 between TLS libraries=2E But let&#39;s at least notice in</span><br><span>=
      * the future =2E=2E=2E*/</span><br><span> #if defined(ENABLE_CRYPTO_M=
BEDTLS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_str=
ing_equal(fp, &quot;82:6B:DD:CC:BD:E5:5E:B7:08:F1:2D:68:00:3C:24:DE&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(fp, &quot;28:3B:19:33:E3:C0:A4:67:5A:0F:64:05:F6:26:1A:C6:81:49:02:4A&=
quot;);</span><br><span> #else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_string_equal(fp, &quot;82:6b:dd:cc:bd:e5:5e:b7:08:f1:2d=
:68:00:3c:24:de&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_string_equal(fp, &quot;28:3b:19:33:e3:c0:a4:67:5a:0f:64:05:f=
6:26:1a:c6:81:49:02:4a&quot;);</span><br><span> #endif</span><br><span> </s=
pan><br><span>     const char *sn =3D backend_x509_get_serial(cert, &amp;gc=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_string_e=
qual(sn, &quot;173359713849739808110610111821055272158&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(sn, &quo=
t;229677570263950905252266749734450551528150860362&quot;);</span><br><span>=
 </span><br><span>     char username[TLS_USERNAME_LEN + 1] =3D { 0 }; /* nu=
ll-terminated */</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int ret =3D backend_x509_get_username(username, sizeof(use=
rname), &quot;CN&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                        cert);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int ret =3D backend_x509_get_username(user=
name, sizeof(username), &quot;CN&quot;, cert);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    assert_string_equal(username=
, &quot;ovpn-test-ec1&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_string_equal(username, cert_details_cname);</span><br>=
<span>     assert_int_equal(ret, SUCCESS);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_CRYPTO_MBEDTLS</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* mbed TLS does not imp=
lement this */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
 =3D backend_x509_get_username(username, sizeof(username), &quot;serialNumb=
er&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                        cert);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ret =3D backend_x509_get_username(username, sizeof(username)=
, &quot;serialNumber&quot;, cert);</span><br><span>     assert_int_equal(re=
t, SUCCESS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asser=
t_string_equal(username, &quot;0x826BDDCCBDE55EB708F12D68003C24DE&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(username, &q=
uot;0x283B1933E3C0A4675A0F6405F6261AC68149024A&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ret =3D backend_x509_get_username(username, sizeof(user=
name), &quot;O&quot;, cert);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_string_equal(username, cert_details_org);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(ret, SUCCESS);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ret =3D backend_x509_get_username(username, sizeof(=
username), &quot;OU&quot;, cert);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_string_equal(username, cert_details_org_unit);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ret, SUCCESS);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Check that FAILURE is returned if a f=
ield does not exist=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ret =3D backend_x509_get_username(username, sizeof(username), &qu=
ot;SN&quot;, cert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(ret, FAILURE);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Check that FAILURE is returned for invalid field names=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D backend_x509_get_u=
sername(username, sizeof(username), &quot;invalidField&quot;, cert);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ret, =
FAILURE);</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><b=
r><span>     free_certificate(cert);</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=
=3Demail">change 1801</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1801?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1801 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--4vDLsGx/oxA=--


--===============6445198058453954100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6445198058453954100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6445198058453954100==--

