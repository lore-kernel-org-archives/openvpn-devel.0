Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621FCCCF2D3
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/cpl6BsuaxAS70z4HUb3Zv+mzFKfqDDeRp474RocumE=; b=kaFKyXGadMb55S52xT0T3p13L8
	vEsA9gyyi0u644saXOttLmxQYk4oX5Ccf7jKW0oF7ciW93XVkVaUX3Su0kZj11/a3ocA+k8JSf/aH
	LrzIs7bKdiMp/GIbn4nI+F/VlzPxedqW5UfJ1jHGgFkqg9bs+QnxYqRCj3X2ASPKBEDs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xITK5-0005bg-5a;
	Sun, 18 Oct 2026 16:01:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xITJr-0005bQ-7G
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 16:01:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nPQzbE/br5lVPZ/+6/aQb+IF4bc54qRbdKPwtVx88FY=; b=khWvX3QNrWdjGeYVJtGGmxgYkr
 917f5gQ19ZWCm5XefU1m/4MggxoqdyivGn4MY/bc+BqLem7JLWaHXlZ3f7Q84XHcjQFIIYQtMnrFE
 bcIDfU7lnfDzWwXasMTY+xH7+7NEc1rjvsAxGTMwn4kE8vijKGSNAzPrd2Cd+0NjFT0k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nPQzbE/br5lVPZ/+6/aQb+IF4bc54qRbdKPwtVx88FY=; b=H
 zUARkz0J6TYYhGtGasSLm0jbjj4zBnqZ+oZlSaJTUkb3xMJ8LZe0WjrFVO/KA3igUD+KLeRwx9ZKY
 vTUnM3qQxeTJ0Nd2FHjpmlSqxc1K8uku4JaO0O9j70rO3l8v7YjpFDYEMSpUqm6NMJAnfB4nBeb+Y
 B/lv+O7suX1Ztzuc=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xITJq-0002Ay-P2 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 16:01:07 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso1097841f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792339260; x=1792944060; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nPQzbE/br5lVPZ/+6/aQb+IF4bc54qRbdKPwtVx88FY=;
 b=P/O1FggIDGZl+QT/AO2j9avsB8IW1z3C4KHxA1dHLS+6/gVD6Q3aX046OpxkF1n38N
 I3IGghTzBoA2Rjfo++VQGswNSGEQ9q39dbsimd5RbM2GJ+M8VqqK+F7RPA1Q0WMYT9oI
 srsFvkrvc0w2tKN6grZ5TmEBCieqofoy82K/ca39ADjvV25xWxH+5WQyTuMLzCex5UaP
 OzUD/pSKS9s2lZtGfYeoI+rxu25M9gzyZg81+bFS2Yw/6giKpydDvq4b7NVw1c3aceeZ
 gigvZI2lcWU892QdbM6++RVn227NY7vij32X9ZDrkC65P895xUrd2SirRoS47+d96H8L
 9MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792339260; x=1792944060;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nPQzbE/br5lVPZ/+6/aQb+IF4bc54qRbdKPwtVx88FY=;
 b=LmZ63m/b9lnL0zXIXrkwUPmlzF6ii1KjC+IZSUi2Xz+q5KhMogbFvf7WXeGe4IlIyL
 JwIoTShNGTjXZd/TWIPkzVqJ0veKMo2mDDKHMhb5PCOOORxt/ZL+Dpg4vhA/Q73ExTQs
 lBWflco9ZeOsOfdSRPeqHaeVxNsD3SbC9Zdo8WR220CO974xApZGNp/ObTUj34q9Vk37
 H2TWhGTNHPcK+L3dSNCWGz9gfxKLZVUOlzFpEXjaTifEtHkIaai7z4howDoLbh9aPtuy
 qI7aygJiCjoJlny45kid+xtTRAet90Euuho9YkVYZYRLuwK/c9KrjkFRPf8XEP/BUoBG
 yCCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/dvzrIUT5Ff3sMv7KjUWiNOPchCht4ERY0+vCLjS3Ntw/TFMM6VK7m1YkMUzI3fZ2Kf4/xj0d7PX28GHm@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIX8dReL69eBZTJgDRg9hFCOF45sus6LAjIHyZPOskMlI11lQwB
 owpowC0oXuDdm/qXEy1760bj/k6KafAeqZc2gjWGt6LQrgaf3bu3LcNd9c4hlVP9NJfiXTdf158
 yAKqz7gGrsIueH5qCzOT2Ivr1Gj0oT3C0BTlQ9h54LbQhanqUUHY4IubkUcnh34dVocMV
X-Gm-Gg: AYBFou2vvWJJQwuX/4shVzCASQnxesXUKx7AnV4Q5IoBVVzkbMhi44UvJykEAKmNLu0
 Q0aYJr+3TKgENhoZEKaXpu5fpMCOt5IQhpbgifDSGVshB6xwUqDqA2Hc58u3GhdNcZBwqzSozv2
 RcAl7z6qMZe5BMrgKwdPFjv8VfCM2BY/tRJ55Ce9BiO8Gfh3TjcKy3ORtv9oIDNbK2ijAyY9pxz
 huXKf5FZHWNY5kxNwpnD8F6QAVetu1Cg+idPj4pJCxbWtKwGLOSuLRGGhGR4GrAmnLnuHYZTDOW
 IzQebmFPPHehsqKmhZaNYoCM5huU3a3vwF3sQuskcsvhQ2s9Xm+1VTrB1Y2LyfAK7Rm5mrI2ZUj
 nyyOOV51s9QIygWuJFHtifFM82AQsyzuKKMMsmaEKkm6JVlcikwH6g0k87pgdELjUTPEc/NUrVT
 1ucCRRFdLMQ2Y1yy0gnG3zpkH627RLizhdE6BRsZfi45Ns25mpSFxMx3Bf2kN3pACjSceifSqiE
 95tvuwd/dE45S1N6TQy/SYTXsg8h9wa5Wjcn3z2x5ezmGZKU4ZvfDu8fwZsvvD2Lu3EGBm5Pmps
 ReJBZ1eyMhUrwyttBFBZaDHcEsuGX0BejOjE+SVI7rTAudW8U5NvuVcGYWLfvQ==
X-Received: by 2002:a5d:64cd:0:b0:48b:f92:1f75 with SMTP id
 ffacd0b85a97d-48e07fb9321mr9630875f8f.48.1792339259996; 
 Sun, 18 Oct 2026 09:00:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c5942sm25441240f8f.16.2026.10.18.09.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 09:00:59 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 16:00:59 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56
X-Gerrit-Change-Number: 1989
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1989?usp=email>
X-Gerrit-Commit: 84cdfa106d3217526f73782e992a55297a1966c0
In-Reply-To: <gerrit.1791561117000.I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56@gerrit.openvpn.net>
References: <gerrit.1791561117000.I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNTYxMTE3MDAwLkkyZDVjZDQxYWQyZTQyNDUzMGM3M2E0NDYxYmRkNGE4ZjUyOWI4YjU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c74502e227d1f53b6b45a83367b0157adff57131-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xITJq-0002Ay-P2
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove support for
 pkcs11-helper < 1.28
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0851913839704191938=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0851913839704191938==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uCoD0G9UHHk="; charset=UTF-8

--uCoD0G9UHHk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1989?usp=3Demail )

Change subject: Remove support for pkcs11-h=
elper < 1=2E28
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Remove support for pkcs11-helper < 1=2E28

1=2E27 is in distros like Debi=
an 11 (which is EOL) and
RHEL 9 (which has a version we can't build against=
 due
to missing RSA support)=2E

Simplify code and require 1=2E28=2E

Chang=
e-Id: I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56
Signed-off-by: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989
Message=
-Id: <20261017203108=2E32063-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39957=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etx=
t
M configure=2Eac
M src/openvpn/pkcs11=2Ec
M src/openvpn/pkcs11_openssl=2E=
c
4 files changed, 2 insertions(+), 39 deletions(-)




diff --git a/CMakeL=
ists=2Etxt b/CMakeLists=2Etxt
index b286ee2=2E=2Eb85e461 100644
--- a/CMake=
Lists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -306,7 +306,7 @@
 endif ()
 
 if (${E=
NABLE_PKCS11})
-    pkg_search_module(pkcs11-helper libpkcs11-helper-1 REQU=
IRED IMPORTED_TARGET)
+    pkg_search_module(pkcs11-helper libpkcs11-helper=
-1>=3D1=2E28 REQUIRED IMPORTED_TARGET)
 endif ()
 
 function(check_mbed_con=
figuration)
diff --git a/configure=2Eac b/configure=2Eac
index 6617c8d=2E=
=2Ee83aba7 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -1183,7 +118=
3,7 @@
 if test "${enable_pkcs11}" =3D "yes"; then
 	PKG_CHECK_MODULES(
 		=
[PKCS11_HELPER],
-		[libpkcs11-helper-1 >=3D 1=2E11],
+		[libpkcs11-helper-=
1 >=3D 1=2E28],
 		[have_pkcs11_helper=3D"yes"],
 		[AC_MSG_ERROR([PKCS11 e=
nabled but libpkcs11-helper is missing])]
 	)
diff --git a/src/openvpn/pkcs=
11=2Ec b/src/openvpn/pkcs11=2Ec
index 09c8996=2E=2Ef00ba9b 100644
--- a/src=
/openvpn/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -329,7 +329,6 @@
 
    =
 msg(M_INFO, "PKCS#11: Adding PKCS#11 provider '%s'", provider);
 
-#if PKC=
S11H_VERSION >=3D ((1 << 16) | (28 << 8) | (0 << 0))
     if ((rv =3D pkcs1=
1h_registerProvider(provider)) !=3D CKR_OK)
     {
         msg(M_WARN, "PK=
CS#11: Cannot register provider '%s' %ld-'%s'", provider, rv,
@@ -376,15 +3=
75,6 @@
             pkcs11h_removeProvider(provider);
         }
     }
-#=
else  /* if PKCS11H_VERSION >=3D ((1<<16) | (28<<8) | (0<<0)) */
-    if ((=
rv =3D pkcs11h_addProvider(provider, provider, protected_auth, private_mode=
,
-                                  PKCS11H_SLOTEVENT_METHOD_AUTO, 0, cert=
_private))
-        !=3D CKR_OK)
-    {
-        msg(M_WARN, "PKCS#11: Cann=
ot initialize provider '%s' %ld-'%s'", provider, rv,
-            pkcs11h_g=
etMessage(rv));
-    }
-#endif /* if PKCS11H_VERSION >=3D ((1<<16) | (28<<8=
) | (0<<0)) */
 
     dmsg(D_PKCS11_DEBUG, "PKCS#11: pkcs11_addProvider - r=
eturn rv=3D%ld-'%s'", rv,
          pkcs11h_getMessage(rv));
diff --git a/s=
rc/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec
index 24dce8=
4=2E=2E8abd60a 100644
--- a/src/openvpn/pkcs11_openssl=2Ec
+++ b/src/openvp=
n/pkcs11_openssl=2Ec
@@ -43,8 +43,6 @@
 #ifdef HAVE_XKEY_PROVIDER
 static X=
KEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;
 
-#if PKCS11H_VERSION > ((1 << 16)=
 | (27 << 8)) /* version > 1=2E27 */
-
 /* Table linking OpenSSL digest NID=
 with CKM and CKG constants in PKCS#11 */
 #define MD_TYPE(n) { NID_sha##n,=
 CKM_SHA##n, CKG_MGF1_SHA##n }
 static const struct
@@ -132,31 +130,6 @@
  =
   return ret;
 }
 
-#else  /* if PKCS11H_VERSION > ((1<<16) | (27<<8)) */
=
-
-/* Make set_pss_params a no-op that always succeeds */
-#define set_pss_=
params(=2E=2E=2E) (1)
-
-/* Use a wrapper for pkcs11h_certificate_signAny_e=
x() for versions < 1=2E28
- * where its not available=2E
- * We just call p=
kcs11h_certificate_signAny() unless the padding
- * is PSS in which case we=
 return an error=2E
- */
-static CK_RV
-pkcs11h_certificate_signAny_ex(cons=
t pkcs11h_certificate_t cert, const CK_MECHANISM *mech,
-                  =
             const unsigned char *tbs, size_t tbslen, unsigned char *sig,
-=
                               size_t *siglen)
-{
-    if (mech->mechanism =
=3D=3D CKM_RSA_PKCS_PSS)
-    {
-        msg(M_NONFATAL, "PKCS#11: Error: P=
SS padding is not supported by "
-                        "this version of =
pkcs11-helper library=2E");
-        return CKR_MECHANISM_INVALID;
-    }
-=
    return pkcs11h_certificate_signAny(cert, mech->mechanism, tbs, tbslen, =
sig, siglen);
-}
-#endif /* PKCS11H_VERSION > 1=2E27 */
-
 /**
  * Sign op =
called from xkey provider
  *

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1989?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56
Gerrit-Change-Number: =
1989
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>

--uCoD0G9UHHk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1989?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Remove support for pkcs11-helper &=
lt; 1=2E28<br><br>1=2E27 is in distros like Debian 11 (which is EOL) and<br=
>RHEL 9 (which has a version we can&#39;t build against due<br>to missing R=
SA support)=2E<br><br>Simplify code and require 1=2E28=2E<br><br>Change-Id:=
 I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56<br>Signed-off-by: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1989<br>Message-Id: &lt;20261017203108=2E32063-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg39957=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M configure=2Eac<br>M src/o=
penvpn/pkcs11=2Ec<br>M src/openvpn/pkcs11_openssl=2Ec<br>4 files changed, 2=
 insertions(+), 39 deletions(-)<br><br></pre>
<pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2E=
txt b/CMakeLists=2Etxt</span><br><span>index b286ee2=2E=2Eb85e461 100644</s=
pan><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt=
</span><br><span>@@ -306,7 +306,7 @@</span><br><span> endif ()</span><br><s=
pan> </span><br><span> if (${ENABLE_PKCS11})</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    pkg_search_module(pkcs11-helper libpkcs11-helper=
-1 REQUIRED IMPORTED_TARGET)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    pkg_search_module(pkcs11-helper libpkcs11-helper-1&gt;=3D1=2E2=
8 REQUIRED IMPORTED_TARGET)</span><br><span> endif ()</span><br><span> </sp=
an><br><span> function(check_mbed_configuration)</span><br><span>diff --git=
 a/configure=2Eac b/configure=2Eac</span><br><span>index 6617c8d=2E=2Ee83ab=
a7 100644</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/config=
ure=2Eac</span><br><span>@@ -1183,7 +1183,7 @@</span><br><span> if test &qu=
ot;${enable_pkcs11}&quot; =3D &quot;yes&quot;; then</span><br><span> 	PKG_C=
HECK_MODULES(</span><br><span> 		[PKCS11_HELPER],</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-		[libpkcs11-helper-1 &gt;=3D 1=2E11],</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+		[libpkcs11-helper-1 &gt;=
=3D 1=2E28],</span><br><span> 		[have_pkcs11_helper=3D&quot;yes&quot;],</sp=
an><br><span> 		[AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missi=
ng])]</span><br><span> 	)</span><br><span>diff --git a/src/openvpn/pkcs11=
=2Ec b/src/openvpn/pkcs11=2Ec</span><br><span>index 09c8996=2E=2Ef00ba9b 10=
0644</span><br><span>--- a/src/openvpn/pkcs11=2Ec</span><br><span>+++ b/src=
/openvpn/pkcs11=2Ec</span><br><span>@@ -329,7 +329,6 @@</span><br><span> </=
span><br><span>     msg(M_INFO, &quot;PKCS#11: Adding PKCS#11 provider &#39=
;%s&#39;&quot;, provider);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if PKCS11H_VERSION &gt;=3D ((1 &lt;&lt; 16) | (28 &=
lt;&lt; 8) | (0 &lt;&lt; 0))</span><br><span>     if ((rv =3D pkcs11h_regis=
terProvider(provider)) !=3D CKR_OK)</span><br><span>     {</span><br><span>=
         msg(M_WARN, &quot;PKCS#11: Cannot register provider &#39;%s&#39; %=
ld-&#39;%s&#39;&quot;, provider, rv,</span><br><span>@@ -376,15 +375,6 @@</=
span><br><span>             pkcs11h_removeProvider(provider);</span><br><sp=
an>         }</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#else  /* if PKCS11H_VERSION &gt;=3D ((1&lt;&lt;16) | (28&lt=
;&lt;8) | (0&lt;&lt;0)) */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if ((rv =3D pkcs11h_addProvider(provider, provider, protected_auth=
, private_mode,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                            PKCS11H_SLOTEVENT_METHOD_AUTO, 0, cert_private)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        !=3D CKR_OK)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;PKCS#11: Ca=
nnot initialize provider &#39;%s&#39; %ld-&#39;%s&#39;&quot;, provider, rv,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pkcs11h_g=
etMessage(rv));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if PKCS11H_V=
ERSION &gt;=3D ((1&lt;&lt;16) | (28&lt;&lt;8) | (0&lt;&lt;0)) */</span><br>=
<span> </span><br><span>     dmsg(D_PKCS11_DEBUG, &quot;PKCS#11: pkcs11_add=
Provider - return rv=3D%ld-&#39;%s&#39;&quot;, rv,</span><br><span>        =
  pkcs11h_getMessage(rv));</span><br><span>diff --git a/src/openvpn/pkcs11_=
openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec</span><br><span>index 24dce84=
=2E=2E8abd60a 100644</span><br><span>--- a/src/openvpn/pkcs11_openssl=2Ec</=
span><br><span>+++ b/src/openvpn/pkcs11_openssl=2Ec</span><br><span>@@ -43,=
8 +43,6 @@</span><br><span> #ifdef HAVE_XKEY_PROVIDER</span><br><span> stat=
ic XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if PKCS11H_VERSION &gt; ((1 &lt;&l=
t; 16) | (27 &lt;&lt; 8)) /* version &gt; 1=2E27 */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Table linking OpenSSL =
digest NID with CKM and CKG constants in PKCS#11 */</span><br><span> #defin=
e MD_TYPE(n) { NID_sha##n, CKM_SHA##n, CKG_MGF1_SHA##n }</span><br><span> s=
tatic const struct</span><br><span>@@ -132,31 +130,6 @@</span><br><span>   =
  return ret;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#else  /* if PKCS11H_VERSION &gt; ((1&lt;&lt;1=
6) | (27&lt;&lt;8)) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Make set_pss_para=
ms a no-op that always succeeds */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define set_pss_params(=2E=2E=2E) (1)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/* Use a wrapper for pkcs11h_certificate_signAny_ex() for versions =
&lt; 1=2E28</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * where i=
ts not available=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 We just call pkcs11h_certificate_signAny() unless the padding</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * is PSS in which case we return =
an error=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static CK_RV</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-pkcs11h_certificate_signAny_ex(const =
pkcs11h_certificate_t cert, const CK_MECHANISM *mech,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                               const unsign=
ed char *tbs, size_t tbslen, unsigned char *sig,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                               size_t *siglen)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (mech-&gt;mechanism =3D=3D CKM_RSA_P=
KCS_PSS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NONFATAL, &quot=
;PKCS#11: Error: PSS padding is not supported by &quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                        &quot;this versio=
n of pkcs11-helper library=2E&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return CKR_MECHANISM_INVALID;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return pkcs11h_certificate_signAny(cert, mech-&gt;mecha=
nism, tbs, tbslen, sig, siglen);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /*=
 PKCS11H_VERSION &gt; 1=2E27 */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> /**</span><br><span>  * Sign op called from xke=
y provider</span><br><span>  *</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989?usp=3Demail">change 1989</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2d5c=
d41ad2e424530c73a4461bdd4a8f529b8b56 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1989 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--uCoD0G9UHHk=--


--===============0851913839704191938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0851913839704191938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0851913839704191938==--

