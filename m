Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455AAC4453C
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPx52ITZA9de+S3PypakB0as9H1CefGbTNM+VsornvM=; b=be5tbrSkF3IWSu2yQeqbcyTJYO
	QNwLoVI6wuLJaYtYsu2c2Emu8ZKTcq9d8RKZmzxpTzD5C3etHioozvNuBhczPaPn+ChoGJG2ntAm7
	5+DFzhlJRuKn9qgk/KksfkkE3EdfQ/24UfpWO3/szgTjC6Dq6dCwrPgJhKORWwqNXHG0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmZfN-0003Ui-NH;
	Wed, 22 Jul 2026 16:19:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmZfM-0003Ua-9S
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 16:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=k1er0uMN8lGpt9S+C3GF334+Sd4Sc4+wSggS5zfnYLY=; b=jbNXRKcyIIl7RhP0hnRvrXFIHo
 53L3Yo/x0wn4BNfQnBuMTsPK2gx+rvVThVbhSAQ17YiO7J7eobmMGU2ChkDeSRk8aRMiJ0Nhe/I/m
 pXs2tm+9aNz3bSnrYmJ8BPbfm6/zWfH/QZuDG8evUz3wiT7iv4BDKYULkNGsq0OUquAY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k1er0uMN8lGpt9S+C3GF334+Sd4Sc4+wSggS5zfnYLY=; b=B
 hT3Axr2Eo7tTucycD7zI3kecRD2ZAo4L3VOXxX4iHZhaVoBI1RoiIvRlF4b+ZUC6ZkMABE6zc/RN1
 5OCCMBH6GEvl7KJD4Bt5jPlSGGI1Ge5bDs3VVyfWIZLgNsrA8dBoZ/fPCSavXxdRbVruHLjbafGI8
 hui6D6rbps6z9ApA=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmZfI-0000Ix-QD for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 16:19:28 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4954d383e64so31221515e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784737158; x=1785341958; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k1er0uMN8lGpt9S+C3GF334+Sd4Sc4+wSggS5zfnYLY=;
 b=Y0RK/G+aMY1Cs/XdoNbBJJXKlY5Pb8z76/zu3jFb2TDF24/D+QCyqmymCvwsI4f7sM
 tI3muzoskglsLlonrdxW9VvowQ6kW0S882BrXcRXzPtv6UGnO5mfaXJ/f6hrP8GZjDAs
 KHfxa6ZT+sYvqHEAASGI/K5yYP2vCQN99AR4v1IfBj7rZQkYqHh1Cyl6YAayApTq6rxC
 wO1tB+VRHfHlHVPPl6eKiPoBJ8ZlW/4UqZhBU011oDVbzNqlSwedKG19iJMcXkeEZFRn
 TeCt+14ocp/nEpDEcw5l1DaeeqfHlAZzxyTf8BMM+IOCEdXuDIzdpswe2AOzRnQ+pmck
 LmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784737158; x=1785341958;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k1er0uMN8lGpt9S+C3GF334+Sd4Sc4+wSggS5zfnYLY=;
 b=rNEE7QzTrbSK2bvzAvwWWKxPb8Ma+0Ww504owWSqJo3sbDPhML7fc9YzocCKdVxEfW
 VW/qd/M+b4GS5Lr+EJf5rAXYuZ0Mu8Q7BH78gXDFTQ+YxQF6LqaXwORIAxjrOq+GLtPq
 1P8JJrtPnlxrGQRs7zeYNxIXnUqJgzlbBeeX2g/TNBV5FFMpxKhWO3JkamAsZvrzjDhS
 2wGjW97D995gA1g/jjkYL8Scb22yuF7NHHmm+3Jkbt9Y6J8kZ9cMj0RgFqINM06oO6AJ
 nnwYw6k/VVA0ybKPzoM6vDHgMiER4gpi1/EDO5A0Iw2/4/K2i9dxebRS0UL4lJj20RR8
 BJZw==
X-Gm-Message-State: AOJu0YxTDYb5nYNYgoC8YYTDKUjw1nm7xduT4v5W5gLihyLAZfX9ILQE
 dqrPPh5EVwthQtR7fd/gpTZN9V/3Fn/McK5zgjsAfc7wxxqWSKifSIBQ6DVwBFMxGCTWbG11zaD
 g0emRPEknoym4Ury5gri81a30vHcpH76923bEbDwF5EWfFSj5nWeJte9cjxzkzyYeUeLd
X-Gm-Gg: AR+sD13p8c68KHgLYTjbCyNSBrMXBCHkF7Gq8tREP7qL+gKGbz4s2rtF+RCywHGuvIM
 OiaHZNaxheE9GzRXW7Y/Ea98sdvTO7GssuEcLxM7ZxqomWtzDzYctLu/j2XlJfpduR64KjLXr75
 f0FMqh607+t3qS58Xh/WvP8MORUlWKjsktdioUJDaKejxvJ9SqfSvzMuJCSqProa+kHSlNBzjVr
 es96PerpxSqj87SMYCvVPjhske0UCqHsK3pSp8WGS9auuJtqkSOr/jZ+qZMNhrDz2MUYYNPPXg6
 abqZQeeXwEJIrR7RSAW7sKxs3qMMD0SKcYVfvC4mxWagIzNs32vODfxXVKH7vS/meUuXHwsx/EL
 tnfzEMYAOx9SS2STIv7sDhwc3TsWwjfo5SGW/wdjP8R1ZkQvZf9MQJgrVXYaHBAdlYI981Zze3w
 hxJJEWs4mTWCrTejj3byMWmpf0aQ4lOUEQLodubICRbz5sEQRTp/pkZYLAYcFqwTGN9ahHhy9cX
 EMNFJONpPj6TWmT0ZBkiEnFw1LLJdt+ZgufL5ZvsPKwBUbAfYPmK740p20IBkm4TL6V
X-Received: by 2002:a7b:c055:0:b0:492:6f6f:fa42 with SMTP id
 5b1f17b1804b1-4954a516ae6mr174847625e9.37.1784737157870; 
 Wed, 22 Jul 2026 09:19:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm162500065e9.3.2026.07.22.09.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:19:17 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 16:19:16 +0000
To: MaxF <max@max-fillinger.net>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
X-Gerrit-Change-Number: 1801
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1801?usp=email>
X-Gerrit-Commit: 124ec07732bccc1fced2d8d37c71b761daf75f4f
In-Reply-To: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
References: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzI0NzcyMDAwLkljMTgzZjFmMWY5MDU2MTQ1NGI3YjExMjhjOTUyNTUzNjg0MjdjYzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1453e89886678dd6bcc62252e4a0476baa1b4a64-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmZfI-0000Ix-QD
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2005029669582589320=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2005029669582589320==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CkMQEql0SNY="; charset=UTF-8

--CkMQEql0SNY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demail )

Th=
e following approvals got outdated and were removed:
Code-Review+2 by flich=
tenheld


Change subject: Make --x509-username-field work with Mbed TLS
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make --x509-user=
name-field work with Mbed TLS

In pre-2=2E7 versions, this option was not a=
vailable in the Mbed TLS
build=2E This was changed in 2=2E7, but the option=
 did not do anything when
Mbed TLS was selected as the crypto library=2E Re=
gardless of the field
chosen with --x509-username-field, OpenVPN would alwa=
ys extract the CN
as username=2E

This could lead to a situation where an u=
nintended certificate gets
accepted by OpenVPN: If we run with "--x509-user=
name-field serialNumber"
and "--verify-x509-name 0x05 name", OpenVPN would =
accept a certificate
with CN=3D0x05 and an incorrect serial number, while a=
 certificate with
the correct serial number would be rejected=2E (Though no=
te that to
exploit this, an attacker needs to make the CA sign a certificat=
e
with a hexadecimal number in the CN=2E)

This commit adds code to backend=
_x509_get_username to extract the
correct field values from X509 certificat=
es=2E It also changes the
behavior of the function to match the OpenSSL ver=
sion when the output
buffer is too small=2E (With Mbed TLS, the function wo=
uld silently
truncate the output and return SUCCESS=2E)

It also adds unit =
tests for extracting the values of different fields=2E

Despite this commit=
 fixing a CVE, we have decided not to keep it under
embargo until the relea=
se of the next version because it is unlikely to
be exploitable in practice=
: Someone has to run OpenVPN 2=2E7 with Mbed
TLS, use the --x509-username-f=
ield option even though it didn't exist in
Mbed TLS builds of earlier versi=
ons, not notice that the intended
certificate is *not* accepted, and then a=
n attacker has to get the CA to
sign a certificate with a weird common name=
=2E

CVE: 2026-63650
Github: openvpn/openvpn-private-issues#144
Reported-By=
: Hcamael
Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (www=2Eaipyaipy=2Ecom)
C=
hange-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
Signed-off-by: Max Fill=
inger <maximilian=2Efillinger@sentyron=2Ecom>
Acked-by: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1801
Message-Id: <20260722152521=2E22272-1-gert@greenie=2Emuc=2Ede>
UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg37773=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
=
M src/openvpn/ssl_verify_mbedtls=2Ec
M tests/unit_tests/openvpn/test_ssl=2E=
c
2 files changed, 199 insertions(+), 29 deletions(-)


  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/1801/4

diff --git a/src=
/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index =
ad5479c=2E=2E2a09e86 100644
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/=
src/openvpn/ssl_verify_mbedtls=2Ec
@@ -137,19 +137,133 @@
     return false=
;
 }
 
+static const char *
+fieldname_to_oid(const char *fieldname)
+{
+  =
  if (strcmp(fieldname, "C") =3D=3D 0)
+    {
+        return MBEDTLS_OID_A=
T_COUNTRY;
+    }
+    else if (strcmp(fieldname, "ST") =3D=3D 0)
+    {
+ =
       return MBEDTLS_OID_AT_STATE;
+    }
+    else if (strcmp(fieldname, =
"LOCALITY") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_LOCALITY;
+    =
}
+    else if (strcmp(fieldname, "O") =3D=3D 0)
+    {
+        return MBE=
DTLS_OID_AT_ORGANIZATION;
+    }
+    else if (strcmp(fieldname, "OU") =3D=
=3D 0)
+    {
+        return MBEDTLS_OID_AT_ORG_UNIT;
+    }
+    else if =
(strcmp(fieldname, "CN") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_CN=
;
+    }
+    else if (strcmp(fieldname, "GN") =3D=3D 0)
+    {
+        re=
turn MBEDTLS_OID_AT_GIVEN_NAME;
+    }
+    else if (strcmp(fieldname, "SN"=
) =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_SUR_NAME;
+    }
+    els=
e if (strcmp(fieldname, "initials") =3D=3D 0)
+    {
+        return MBEDTL=
S_OID_AT_INITIALS;
+    }
+    else if (strcmp(fieldname, "pseudonym") =3D=
=3D 0)
+    {
+        return MBEDTLS_OID_AT_PSEUDONYM;
+    }
+    else if=
 (strcmp(fieldname, "title") =3D=3D 0)
+    {
+        return MBEDTLS_OID_A=
T_TITLE;
+    }
+    else if (strcmp(fieldname, "generationQualifier") =3D=
=3D 0)
+    {
+        return MBEDTLS_OID_AT_GENERATION_QUALIFIER;
+    }
+=
    else if (strcmp(fieldname, "postalAddress") =3D=3D 0)
+    {
+        r=
eturn MBEDTLS_OID_AT_POSTAL_ADDRESS;
+    }
+    else if (strcmp(fieldname,=
 "postalCode") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_POSTAL_CODE;=

+    }
+    else if (strcmp(fieldname, "emailAddress") =3D=3D 0)
+    {
+ =
       return MBEDTLS_OID_PKCS9_EMAIL;
+    }
+    else if (strcmp(fieldnam=
e, "uid") =3D=3D 0)
+    {
+        return MBEDTLS_OID_AT_UNIQUE_IDENTIFIER=
;
+    }
+    else if (strcmp(fieldname, "dnQualifier") =3D=3D 0)
+    {
+ =
       return MBEDTLS_OID_AT_DN_QUALIFIER;
+    }
+    else
+    {
+       =
 return NULL;
+    }
+}
+
 result_t
 backend_x509_get_username(char *cn, si=
ze_t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)
 {
-    mbe=
dtls_x509_name *name;
+    ASSERT(cn !=3D NULL && cn_len > 0 && cert !=3D N=
ULL);
 
-    ASSERT(cn !=3D NULL);
+    if (x509_username_field =3D=3D NULL=
)
+    {
+        goto fail;
+    }
 
-    name =3D &cert->subject;
+    if=
 (strcmp(x509_username_field, "serialNumber") =3D=3D 0)
+    {
+        if =
(cn_len < 2)
+        {
+            goto fail;
+        }
+        cn[0] =
=3D '0';
+        cn[1] =3D 'x';
+        size_t cn_index =3D 2;
+        b=
ool leading_zeros =3D true;
+        for (size_t i =3D 0; i < cert->serial=
=2Elen; i++)
+        {
+            uint8_t serial_byte =3D cert->serial=
=2Ep[i];
+            if (leading_zeros && serial_byte =3D=3D 0)
+         =
   {
+                continue;
+            }
+            leading_zeros =
=3D false;
+            if (cn_index > cn_len - 3)
+            {
+        =
        goto fail;
+            }
+            snprintf(&cn[cn_index], cn_l=
en - cn_index, "%02X", serial_byte);
+            cn_index +=3D 2;
+       =
 }
+        return SUCCESS;
+    }
 
-    /* Find common name */
+    const=
 char *field_oid =3D fieldname_to_oid(x509_username_field);
+    if (field_=
oid =3D=3D NULL)
+    {
+        goto fail;
+    }
+
+    /* Find field_oid=
 in the subject name=2E */
+    mbedtls_x509_name *name =3D &cert->subject;=

     while (name !=3D NULL)
     {
-        if (0 =3D=3D memcmp(name->oid=
=2Ep, MBEDTLS_OID_AT_CN, MBEDTLS_OID_SIZE(MBEDTLS_OID_AT_CN)))
+        if =
(strlen(field_oid) =3D=3D name->oid=2Elen
+            && 0 =3D=3D memcmp(n=
ame->oid=2Ep, field_oid, name->oid=2Elen))
         {
             break;
 =
        }
@@ -160,22 +274,23 @@
     /* Not found, return an error if this =
is the peer's certificate */
     if (name =3D=3D NULL)
     {
-        ret=
urn FAILURE;
+        goto fail;
     }
 
-    /* Found, extract CN */
-   =
 if (cn_len > name->val=2Elen)
+    /* Check that we have room in the buffe=
r, including the terminating '/0' byte=2E */
+    if (cn_len <=3D name->val=
=2Elen)
     {
-        memcpy(cn, name->val=2Ep, name->val=2Elen);
-      =
  cn[name->val=2Elen] =3D '\0';
+        goto fail;
     }
-    else
-    {=

-        memcpy(cn, name->val=2Ep, cn_len);
-        cn[cn_len - 1] =3D '\=
0';
-    }
+
+    memcpy(cn, name->val=2Ep, name->val=2Elen);
+    cn[name-=
>val=2Elen] =3D '\0';
 
     return SUCCESS;
+
+fail:
+    cn[0] =3D '\0';
=
+    return FAILURE;
 }
 
 #if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
diff =
--git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/te=
st_ssl=2Ec
index 0e9cecf=2E=2Ed473d67 100644
--- a/tests/unit_tests/openvpn=
/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -775,7 +775,7 =
@@
 static openvpn_x509_cert_t *
 get_certificate(const char *cert_str)
 {
=
-    BIO *in =3D BIO_new_mem_buf((char *)cert1, -1);
+    BIO *in =3D BIO_n=
ew_mem_buf((char *)cert_str, -1);
     assert_non_null(in);
     X509 *cert=
 =3D PEM_read_bio_X509(in, NULL, NULL, NULL);
     assert_non_null(cert);
@=
@ -790,10 +790,37 @@
 }
 #endif
 
+/* Generated with:
+ * openssl req -x509=
 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - -noenc -sha256 -=
days 3650 \
+ * -subj '/CN=3Dovpn-test-secp384r1/O=3DOpenVPN Unit Test Exam=
ple Corp=2E/OU=3DCert Details Dept=2E'
+ * -addext 'subjectAltName=3DDNS:un=
ittest=2Eexample=2Ecom' -addext 'extendedKeyUsage=3DclientAuth' */
+static =
const char *cert_details_test_cert =3D
+    "-----BEGIN CERTIFICATE-----\n"=

+    "MIICkzCCAhqgAwIBAgIUKDsZM+PApGdaD2QF9iYaxoFJAkowCgYIKoZIzj0EAwIw\n"
=
+    "ZTEcMBoGA1UEAwwTb3Zwbi10ZXN0LXNlY3AzODRyMTEoMCYGA1UECgwfT3BlblZQ\n"
+=
    "TiBVbml0IFRlc3QgRXhhbXBsZSBDb3JwLjEbMBkGA1UECwwSQ2VydCBEZXRhaWxz\n"
+ =
   "IERlcHQuMB4XDTI2MDcwNzEwNTIxNloXDTM2MDcwNDEwNTIxNlowZTEcMBoGA1UE\n"
+  =
  "AwwTb3Zwbi10ZXN0LXNlY3AzODRyMTEoMCYGA1UECgwfT3BlblZQTiBVbml0IFRl\n"
+   =
 "c3QgRXhhbXBsZSBDb3JwLjEbMBkGA1UECwwSQ2VydCBEZXRhaWxzIERlcHQuMHYw\n"
+    =
"EAYHKoZIzj0CAQYFK4EEACIDYgAEOlKoQVk+wbBD6V/6kg+/oHfqF0Dq08LlCL+B\n"
+    "=
om4RhutG99QDrow251Ps+Ds/7LQYYRA8+hHyEFrmGM+j2o6KhS5K2uA6dIZL4zLK\n"
+    "v=
l0NeF2M61Z8tt/IjrFZd+CrEANco4GKMIGHMB0GA1UdDgQWBBSEyG6m+QdWazeg\n"
+    "0C=
HN7q0edJlqMjAfBgNVHSMEGDAWgBSEyG6m+QdWazeg0CHN7q0edJlqMjAPBgNV\n"
+    "HRM=
BAf8EBTADAQH/MB8GA1UdEQQYMBaCFHVuaXR0ZXN0LmV4YW1wbGUuY29tMBMG\n"
+    "A1Ud=
JQQMMAoGCCsGAQUFBwMCMAoGCCqGSM49BAMCA2cAMGQCMCyK7aQcyKGW8BWQ\n"
+    "UOYqb=
JUJZJcviP6ACgJRzK6pgkqt9gY0E0Tb00Qh6D5dBV5i3wIwCMhSgpVJxDrc\n"
+    "pRflig=
oK8bmv4HEgnV6BDeoDYd41WVMpE9u1issQDHY0SnWC7d9q\n"
+    "-----END CERTIFICAT=
E-----\n";
+const char *const cert_details_cname =3D "ovpn-test-secp384r1";=

+const char *const cert_details_org =3D "OpenVPN Unit Test Example Corp=2E=
";
+const char *const cert_details_org_unit =3D "Cert Details Dept=2E";
+co=
nst char *const cert_details_serial_number =3D "229677570263950905252266749=
734450551528150860362";
+const char *const cert_details_serial_number_hex =
=3D "0x283B1933E3C0A4675A0F6405F6261AC68149024A";
+
 void
 crypto_test_prin=
t_cert_details(void **state)
 {
-    openvpn_x509_cert_t *cert =3D get_cert=
ificate(cert1);
+    openvpn_x509_cert_t *cert =3D get_certificate(cert_det=
ails_test_cert);
     struct gc_arena gc =3D gc_new();
 
     const char *f=
p =3D backend_x509_get_serial_hex(cert, &gc);
@@ -801,29 +828,57 @@
     /*=
 we messed this up between TLS libraries=2E But let's at least notice in
  =
    * the future =2E=2E=2E*/
 #if defined(ENABLE_CRYPTO_MBEDTLS)
-    asser=
t_string_equal(fp, "82:6B:DD:CC:BD:E5:5E:B7:08:F1:2D:68:00:3C:24:DE");
+   =
 assert_string_equal(fp, "28:3B:19:33:E3:C0:A4:67:5A:0F:64:05:F6:26:1A:C6:8=
1:49:02:4A");
 #else
-    assert_string_equal(fp, "82:6b:dd:cc:bd:e5:5e:b7:=
08:f1:2d:68:00:3c:24:de");
+    assert_string_equal(fp, "28:3b:19:33:e3:c0:=
a4:67:5a:0f:64:05:f6:26:1a:c6:81:49:02:4a");
 #endif
 
     const char *sn =
=3D backend_x509_get_serial(cert, &gc);
-    assert_string_equal(sn, "17335=
9713849739808110610111821055272158");
+    assert_string_equal(sn, cert_det=
ails_serial_number);
 
     char username[TLS_USERNAME_LEN + 1] =3D { 0 }; =
/* null-terminated */
 
-    int ret =3D backend_x509_get_username(username=
, sizeof(username), "CN",
-                                        cert);
+=
    int ret =3D backend_x509_get_username(username, sizeof(username), "CN",=
 cert);
 
-    assert_string_equal(username, "ovpn-test-ec1");
+    assert_=
string_equal(username, cert_details_cname);
     assert_int_equal(ret, SUCC=
ESS);
 
-#ifndef ENABLE_CRYPTO_MBEDTLS
-    /* mbed TLS does not implement =
this */
-    ret =3D backend_x509_get_username(username, sizeof(username), =
"serialNumber",
-                                    cert);
+    ret =3D ba=
ckend_x509_get_username(username, sizeof(username), "serialNumber", cert);
=
     assert_int_equal(ret, SUCCESS);
-    assert_string_equal(username, "0x=
826BDDCCBDE55EB708F12D68003C24DE");
-#endif
+    assert_string_equal(userna=
me, cert_details_serial_number_hex);
+
+    ret =3D backend_x509_get_userna=
me(username, sizeof(username), "O", cert);
+
+    assert_string_equal(usern=
ame, cert_details_org);
+    assert_int_equal(ret, SUCCESS);
+
+    ret =3D=
 backend_x509_get_username(username, sizeof(username), "OU", cert);
+
+    =
assert_string_equal(username, cert_details_org_unit);
+    assert_int_equal=
(ret, SUCCESS);
+
+    /* Check that FAILURE is returned if a field does no=
t exist=2E */
+    ret =3D backend_x509_get_username(username, sizeof(usern=
ame), "SN", cert);
+    assert_int_equal(ret, FAILURE);
+
+    /* Check tha=
t FAILURE is returned for invalid field names=2E */
+    ret =3D backend_x5=
09_get_username(username, sizeof(username), "invalidField", cert);
+    ass=
ert_int_equal(ret, FAILURE);
+
+    /* Check that FAILURE is returned if th=
e output buffer is too small=2E Do this separately
+     * for a subject fi=
eld and for the serial number, because these are different code paths=2E
+ =
    *
+     * First case: Can't fit all characters=2E */
+    ret =3D backe=
nd_x509_get_username(username, strlen(cert_details_cname) / 2, "CN", cert);=

+    assert_int_equal(ret, FAILURE);
+    ret =3D backend_x509_get_usernam=
e(username, strlen(cert_details_serial_number_hex) / 2, "serialNumber", cer=
t);
+    assert_int_equal(ret, FAILURE);
+
+    /* Second case: Can fit the=
 characters but not the terminating '\0'=2E */
+    ret =3D backend_x509_ge=
t_username(username, strlen(cert_details_cname), "CN", cert);
+    assert_i=
nt_equal(ret, FAILURE);
+    ret =3D backend_x509_get_username(username, st=
rlen(cert_details_serial_number_hex), "serialNumber", cert);
+    assert_in=
t_equal(ret, FAILURE);
 
     gc_free(&gc);
     free_certificate(cert);

-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic183f1f1f90561454b=
7b1128c95255368427cc4a
Gerrit-Change-Number: 1801
Gerrit-PatchSet: 4
Gerrit=
-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--CkMQEql0SNY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by MaxF=2E</p>=
<p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demail">V=
iew Change</a></p><p>The following approvals got outdated and were removed:=

Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">Make --x509-username-field =
work with Mbed TLS<br><br>In pre-2=2E7 versions, this option was not availa=
ble in the Mbed TLS<br>build=2E This was changed in 2=2E7, but the option d=
id not do anything when<br>Mbed TLS was selected as the crypto library=2E R=
egardless of the field<br>chosen with --x509-username-field, OpenVPN would =
always extract the CN<br>as username=2E<br><br>This could lead to a situati=
on where an unintended certificate gets<br>accepted by OpenVPN: If we run w=
ith &quot;--x509-username-field serialNumber&quot;<br>and &quot;--verify-x5=
09-name 0x05 name&quot;, OpenVPN would accept a certificate<br>with CN=3D0x=
05 and an incorrect serial number, while a certificate with<br>the correct =
serial number would be rejected=2E (Though note that to<br>exploit this, an=
 attacker needs to make the CA sign a certificate<br>with a hexadecimal num=
ber in the CN=2E)<br><br>This commit adds code to backend_x509_get_username=
 to extract the<br>correct field values from X509 certificates=2E It also c=
hanges the<br>behavior of the function to match the OpenSSL version when th=
e output<br>buffer is too small=2E (With Mbed TLS, the function would silen=
tly<br>truncate the output and return SUCCESS=2E)<br><br>It also adds unit =
tests for extracting the values of different fields=2E<br><br>Despite this =
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
linger@sentyron=2Ecom&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/180=
1<br>Message-Id: &lt;20260722152521=2E22272-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg37773=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M tests/unit_t=
ests/openvpn/test_ssl=2Ec<br>2 files changed, 199 insertions(+), 29 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/01/1801/4</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verif=
y_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>index ad=
5479c=2E=2E2a09e86 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbed=
tls=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br>=
<span>@@ -137,19 +137,133 @@</span><br><span>     return false;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static const char *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+fieldname_to_oid(const char *fieldname)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (strcmp(fieldname, &quot;C&quot;) =3D=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_COUNTRY;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;ST&quot;=
) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS=
_OID_AT_STATE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp=
(fieldname, &quot;LOCALITY&quot;) =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return MBEDTLS_OID_AT_LOCALITY;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (strcmp(fieldname, &quot;O&quot;) =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_ORGANIZ=
ATION;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(fieldna=
me, &quot;OU&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return MBEDTLS_OID_AT_ORG_UNIT;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else if (strcmp(fieldname, &quot;CN&quot;) =3D=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return MBEDTLS_OID_AT_CN;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else if (strcmp(fieldname, &quot;GN&quot;) =3D=
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
<div style=3D"display:none"> Gerrit-PatchSet: 4 </di=
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

</body></html>
--CkMQEql0SNY=--


--===============2005029669582589320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2005029669582589320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2005029669582589320==--

