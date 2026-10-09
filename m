Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B75ACA601D
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ppl0QPism6a70a5BTzbFqZcpqmEe2O7G++yDwOZgsJU=; b=IPevQLQUgzMlIg
	xsKoPHqmqwXd/73tIkiOJncrhj9uzsVTkVr+XTjRliKsU10s9pmzk0OphndlhifhZWleybAlPLtHI
	5M+FcCMKE9Hq74zWsRHo7DvGGiXvwBlqbqRqOXXVLvn5V0jrf2JbPmWxjnlo8hxNq1Ixo97cumRNH
	xVc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFCtE-0001BQ-F0;
	Fri, 09 Oct 2026 15:52:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xFCtD-0001BC-2j
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 15:52:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BVmdtLY9kqZHbdj87VUZjFTgrfUcFLKbVFTUPHNvkxU=; b=eC3rtZueRnIYhKJ1RaFF/5Ltro
 HFO9YidbXU7iVQeNLNpYwTJ+zQV/DlCHZE5Jnm4776X8A3KFX6aTJHLeITL0eLTS4oz3n1KzQJGlf
 XCjVebH3Im56tuhjLrBKXtV2odW4Whlo81Aa6+1tYXtgnIZiIp7HM668dVf+TzIX8Puk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BVmdtLY9kqZHbdj87VUZjFTgrfUcFLKbVFTUPHNvkxU=; b=f
 26m9LKqKj9HPxB/5KrRcea9T5IPDrMgcCfr1pjQybwsSZXIYImdTLg/5tRZQTeYsVNcCOtGWP4vZy
 JepLw5nZ0Z1stTTVMC3TgU2s6McJNkG42HMpTuFoLrVnWvqgV/S+UWugWKP22uvt+yrfL6FIjm+iF
 EygEB7uqLh8v8S1k=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFCtC-0004VA-7E for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 15:52:07 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49fbb2acc90so39572075e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791561120; x=1792165920; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BVmdtLY9kqZHbdj87VUZjFTgrfUcFLKbVFTUPHNvkxU=;
 b=dzWMXq+fOzBKZcdKx3t1gkNgscCWFe//CubFspBqhgJUvmi4qs3PKGE3S2tg6cHQQZ
 C3kXtshlZLt8Hl3si/i1hVrck4p48c6nCVuJsySGRF/O67bnHsY5lyS+IE1Alj9176ly
 XPzbXxMm3QlLftAEatv4fd55CV/Xpo8YDAh70FeEg6eS8S4Mh7WNf5Cnvgp49Pp4ISsX
 QkLIlHmkEgrNth3xxIbmJbuRMDKEWBHEVA/BWiwd3AvRlwev8W9/dQmOmoJAnyz3yids
 +AVEFJobkKV+UyPu+Ochj0soyDGPb1uvFc71qb+GKeAa/Akql4GNTU9LJBBJikaPpOtF
 R7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791561120; x=1792165920;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BVmdtLY9kqZHbdj87VUZjFTgrfUcFLKbVFTUPHNvkxU=;
 b=tZFqt1w/PmrMwA9dwTLxkOJT0l1EzY5S4+8Eeph/0j6hfAg18G4Y+b+4eLjkR8Z6iq
 moNfGF/XfOIYN3tf/tTQeHdWl6ro+IWgLLn3JA7CgKRNKN4BJ4ZUx1myK391zwIJk68r
 9c3gz75WXQLhjXhwcH9r8MhEjypiOmyDHIS88nLOTgnfxFjfZsoy4Vcf7aS3OGqMCumX
 LzMBi8UURsmSXvwK9nNln7wKATWXqmTx2Jxs2W5mRjKajb08Xl3tAvgYJiurwjQhr8dj
 n4MErIsZ+HWMg750xy4AuZsrXn3wxY4mmpoAw40cSyOF4V6vxU5Lz/En/AfsG6+9zlno
 ZazA==
X-Gm-Message-State: AFuF++kvDK3HGeyAGU+oGj1k60OyLNQtKxftzhm9t5ekyv+MkZLrE4d0
 DvOlKu7I77TXwr9V3g6N5Iq0XIjt0G+GYWpCH9TQEX3hGcwTSJ53u8wrzzb4YLvEuEaveC79S6p
 26jCtSlkRK8R57HWI6NAgNnkfq5ijoypvTcbfL59gZBmCcNhY7FgN8ce4DGXiCe0fO5U77BlT+/
 b871kA8w==
X-Gm-Gg: AYBFou2c9h1yYrAhYzx8mvwvm1lURoOWZlXEfJvFjf+zeVSoXBJLQ5wpEBdvP41p8nw
 PhTquKksfq1S4tORvjAHG7nHOCfAz4foVgTAg3ocw6h4XsK07OO0iSM6Us4CBTyE77yOl53+l7B
 FXuKQWRDL3lQgVNpNohItRM4XxyLUIehRq+wMonvYWH5p3ct3IhtEGx1Yb1KxwfXZJlXR1RiNv6
 pS/eudKia74Te7KQCeMturBBqIWhMiyc2fPZ23V5epyhq5OdKTiRBla4T2cUM3nikreEidDP0+B
 7wUoV0CGeRt2excc0oxWjOsink0XWPReb+yqSYeO5Hb/7n6LJxkUHCHVQS4Bcxs1dZtciRdKEgc
 jOsPYbvWwPoW+rVbNuKWLrM3hAWlM3zliAvogPjhzdLRbVDEJSAzok/N7dLA+G3maU1Ur443JIw
 tMmQMnhpfUU00HebDteRCH9E/+3SdYSYFPW75M9rElkkpzqiyxVcJxsWZJtSUeCsZ8Zn9H+Xfja
 ARMhN/CIHiH1l0Qi1QEcpEurzI7YYU2ZtGqkdLOw8W2QzkeNfXzqoQvz1fV2LSPJUtmXDWp8wYn
 bjIDmH03VTezkpvyN6A1n/ihrkMrboj6SW8XvpybpA5Dow7wORWcYnq/CdEp
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id
 5b1f17b1804b1-4a18e4f56bcmr48902945e9.33.1791561119474; 
 Fri, 09 Oct 2026 08:51:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9462ebcsm5033931f8f.8.2026.10.09.08.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 08:51:59 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 9 Oct 2026 15:51:58 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56
X-Gerrit-Change-Number: 1989
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1989?usp=email>
X-Gerrit-Commit: c873828664592e5e10d10de9982336e8492acadc
References: <gerrit.1791561117000.I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNTYxMTE3MDAwLkkyZDVjZDQxYWQyZTQyNDUzMGM3M2E0NDYxYmRkNGE4ZjUyOWI4YjU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d89fbf2c2e24770455b59ad2fe05221f8f3daa67-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xFCtC-0004VA-7E
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8644979456816898404=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8644979456816898404==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8AMQuOjMMfk="; charset=UTF-8

--8AMQuOjMMfk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1989?usp=3Demail

to review the following change=2E
=


Change subject: Remove support for pkcs11-helper < 1=2E28
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove support for pkcs11-he=
lper < 1=2E28

1=2E27 is in distros like Debian 11 (which is EOL) and
RHEL =
9 (which has a version we can't build against due
to missing RSA support)=
=2E

Simplify code and require 1=2E28=2E

Change-Id: I2d5cd41ad2e424530c73a=
4461bdd4a8f529b8b56
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
---
M CMakeLists=2Etxt
M configure=2Eac
M src/openvpn/pkcs11=2Ec
M src/=
openvpn/pkcs11_openssl=2Ec
4 files changed, 2 insertions(+), 39 deletions(-=
)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/=
1989/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 2d9b546=2E=
=2E51b97d7 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -305,7 +=
305,7 @@
 endif ()
 
 if (${ENABLE_PKCS11})
-    pkg_search_module(pkcs11-h=
elper libpkcs11-helper-1 REQUIRED IMPORTED_TARGET)
+    pkg_search_module(p=
kcs11-helper libpkcs11-helper-1>=3D1=2E28 REQUIRED IMPORTED_TARGET)
 endif =
()
 
 function(check_mbed_configuration)
diff --git a/configure=2Eac b/conf=
igure=2Eac
index 56109af=2E=2E7d1edb2 100644
--- a/configure=2Eac
+++ b/con=
figure=2Eac
@@ -1181,7 +1181,7 @@
 if test "${enable_pkcs11}" =3D "yes"; th=
en
 	PKG_CHECK_MODULES(
 		[PKCS11_HELPER],
-		[libpkcs11-helper-1 >=3D 1=
=2E11],
+		[libpkcs11-helper-1 >=3D 1=2E28],
 		[have_pkcs11_helper=3D"yes"=
],
 		[AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missing])]
 	)
=
diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec
index d7dee97=
=2E=2Eb2173a8 100644
--- a/src/openvpn/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=
=2Ec
@@ -329,7 +329,6 @@
 
     msg(M_INFO, "PKCS#11: Adding PKCS#11 provid=
er '%s'", provider);
 
-#if PKCS11H_VERSION >=3D ((1 << 16) | (28 << 8) | (=
0 << 0))
     if ((rv =3D pkcs11h_registerProvider(provider)) !=3D CKR_OK)
=
     {
         msg(M_WARN, "PKCS#11: Cannot register provider '%s' %ld-'%s=
'", provider, rv,
@@ -376,15 +375,6 @@
             pkcs11h_removeProvider(=
provider);
         }
     }
-#else  /* if PKCS11H_VERSION >=3D ((1<<16) | =
(28<<8) | (0<<0)) */
-    if ((rv =3D pkcs11h_addProvider(provider, provide=
r, protected_auth, private_mode,
-                                  PKCS11H=
_SLOTEVENT_METHOD_AUTO, 0, cert_private))
-        !=3D CKR_OK)
-    {
-   =
     msg(M_WARN, "PKCS#11: Cannot initialize provider '%s' %ld-'%s'", provi=
der, rv,
-            pkcs11h_getMessage(rv));
-    }
-#endif /* if PKCS11H=
_VERSION >=3D ((1<<16) | (28<<8) | (0<<0)) */
 
     dmsg(D_PKCS11_DEBUG, "=
PKCS#11: pkcs11_addProvider - return rv=3D%ld-'%s'", rv,
          pkcs11h_=
getMessage(rv));
diff --git a/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/=
pkcs11_openssl=2Ec
index 24dce84=2E=2E8abd60a 100644
--- a/src/openvpn/pkcs=
11_openssl=2Ec
+++ b/src/openvpn/pkcs11_openssl=2Ec
@@ -43,8 +43,6 @@
 #ifd=
ef HAVE_XKEY_PROVIDER
 static XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;
 
-#=
if PKCS11H_VERSION > ((1 << 16) | (27 << 8)) /* version > 1=2E27 */
-
 /* T=
able linking OpenSSL digest NID with CKM and CKG constants in PKCS#11 */
 #=
define MD_TYPE(n) { NID_sha##n, CKM_SHA##n, CKG_MGF1_SHA##n }
 static const=
 struct
@@ -132,31 +130,6 @@
     return ret;
 }
 
-#else  /* if PKCS11H_VE=
RSION > ((1<<16) | (27<<8)) */
-
-/* Make set_pss_params a no-op that alway=
s succeeds */
-#define set_pss_params(=2E=2E=2E) (1)
-
-/* Use a wrapper fo=
r pkcs11h_certificate_signAny_ex() for versions < 1=2E28
- * where its not =
available=2E
- * We just call pkcs11h_certificate_signAny() unless the padd=
ing
- * is PSS in which case we return an error=2E
- */
-static CK_RV
-pkcs=
11h_certificate_signAny_ex(const pkcs11h_certificate_t cert, const CK_MECHA=
NISM *mech,
-                               const unsigned char *tbs, size_=
t tbslen, unsigned char *sig,
-                               size_t *sigle=
n)
-{
-    if (mech->mechanism =3D=3D CKM_RSA_PKCS_PSS)
-    {
-        msg=
(M_NONFATAL, "PKCS#11: Error: PSS padding is not supported by "
-          =
              "this version of pkcs11-helper library=2E");
-        return =
CKR_MECHANISM_INVALID;
-    }
-    return pkcs11h_certificate_signAny(cert,=
 mech->mechanism, tbs, tbslen, sig, siglen);
-}
-#endif /* PKCS11H_VERSION =
> 1=2E27 */
-
 /**
  * Sign op called from xkey provider
  *

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I2d5cd41ad2e424530c73a4461bdd4a=
8f529b8b56
Gerrit-Change-Number: 1989
Gerrit-PatchSet: 1
Gerrit-Owner: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=


--8AMQuOjMMfk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">Remove support for pkcs11-helper &lt; 1=2E28<br><br>1=2E27=
 is in distros like Debian 11 (which is EOL) and<br>RHEL 9 (which has a ver=
sion we can&#39;t build against due<br>to missing RSA support)=2E<br><br>Si=
mplify code and require 1=2E28=2E<br><br>Change-Id: I2d5cd41ad2e424530c73a4=
461bdd4a8f529b8b56<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M configure=2Eac<br>M src/openv=
pn/pkcs11=2Ec<br>M src/openvpn/pkcs11_openssl=2Ec<br>4 files changed, 2 ins=
ertions(+), 39 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/1989/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 2d9b546=2E=2E51b=
97d7 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CM=
akeLists=2Etxt</span><br><span>@@ -305,7 +305,7 @@</span><br><span> endif (=
)</span><br><span> </span><br><span> if (${ENABLE_PKCS11})</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    pkg_search_module(pkcs11-helper li=
bpkcs11-helper-1 REQUIRED IMPORTED_TARGET)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    pkg_search_module(pkcs11-helper libpkcs11-helper=
-1&gt;=3D1=2E28 REQUIRED IMPORTED_TARGET)</span><br><span> endif ()</span><=
br><span> </span><br><span> function(check_mbed_configuration)</span><br><s=
pan>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 5610=
9af=2E=2E7d1edb2 100644</span><br><span>--- a/configure=2Eac</span><br><spa=
n>+++ b/configure=2Eac</span><br><span>@@ -1181,7 +1181,7 @@</span><br><spa=
n> if test &quot;${enable_pkcs11}&quot; =3D &quot;yes&quot;; then</span><br=
><span> 	PKG_CHECK_MODULES(</span><br><span> 		[PKCS11_HELPER],</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-		[libpkcs11-helper-1 &gt;=3D 1=
=2E11],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[libpkcs11=
-helper-1 &gt;=3D 1=2E28],</span><br><span> 		[have_pkcs11_helper=3D&quot;y=
es&quot;],</span><br><span> 		[AC_MSG_ERROR([PKCS11 enabled but libpkcs11-h=
elper is missing])]</span><br><span> 	)</span><br><span>diff --git a/src/op=
envpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</span><br><span>index d7dee97=2E=
=2Eb2173a8 100644</span><br><span>--- a/src/openvpn/pkcs11=2Ec</span><br><s=
pan>+++ b/src/openvpn/pkcs11=2Ec</span><br><span>@@ -329,7 +329,6 @@</span>=
<br><span> </span><br><span>     msg(M_INFO, &quot;PKCS#11: Adding PKCS#11 =
provider &#39;%s&#39;&quot;, provider);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if PKCS11H_VERSION &gt;=3D ((1 &lt;&lt=
; 16) | (28 &lt;&lt; 8) | (0 &lt;&lt; 0))</span><br><span>     if ((rv =3D =
pkcs11h_registerProvider(provider)) !=3D CKR_OK)</span><br><span>     {</sp=
an><br><span>         msg(M_WARN, &quot;PKCS#11: Cannot register provider &=
#39;%s&#39; %ld-&#39;%s&#39;&quot;, provider, rv,</span><br><span>@@ -376,1=
5 +375,6 @@</span><br><span>             pkcs11h_removeProvider(provider);<=
/span><br><span>         }</span><br><span>     }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#else  /* if PKCS11H_VERSION &gt;=3D ((1&lt;&lt=
;16) | (28&lt;&lt;8) | (0&lt;&lt;0)) */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if ((rv =3D pkcs11h_addProvider(provider, provider, p=
rotected_auth, private_mode,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                  PKCS11H_SLOTEVENT_METHOD_AUTO, 0, =
cert_private))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 !=3D CKR_OK)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quo=
t;PKCS#11: Cannot initialize provider &#39;%s&#39; %ld-&#39;%s&#39;&quot;, =
provider, rv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    pkcs11h_getMessage(rv));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /*=
 if PKCS11H_VERSION &gt;=3D ((1&lt;&lt;16) | (28&lt;&lt;8) | (0&lt;&lt;0)) =
*/</span><br><span> </span><br><span>     dmsg(D_PKCS11_DEBUG, &quot;PKCS#1=
1: pkcs11_addProvider - return rv=3D%ld-&#39;%s&#39;&quot;, rv,</span><br><=
span>          pkcs11h_getMessage(rv));</span><br><span>diff --git a/src/op=
envpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec</span><br><span>i=
ndex 24dce84=2E=2E8abd60a 100644</span><br><span>--- a/src/openvpn/pkcs11_o=
penssl=2Ec</span><br><span>+++ b/src/openvpn/pkcs11_openssl=2Ec</span><br><=
span>@@ -43,8 +43,6 @@</span><br><span> #ifdef HAVE_XKEY_PROVIDER</span><br=
><span> static XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if PKCS11H_VERSION &gt=
; ((1 &lt;&lt; 16) | (27 &lt;&lt; 8)) /* version &gt; 1=2E27 */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Table linkin=
g OpenSSL digest NID with CKM and CKG constants in PKCS#11 */</span><br><sp=
an> #define MD_TYPE(n) { NID_sha##n, CKM_SHA##n, CKG_MGF1_SHA##n }</span><b=
r><span> static const struct</span><br><span>@@ -132,31 +130,6 @@</span><br=
><span>     return ret;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#else  /* if PKCS11H_VERSION &gt; ((=
1&lt;&lt;16) | (27&lt;&lt;8)) */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Make se=
t_pss_params a no-op that always succeeds */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define set_pss_params(=2E=2E=2E) (1)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/* Use a wrapper for pkcs11h_certificate_signAny_ex() for=
 versions &lt; 1=2E28</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * where its not available=2E</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * We just call pkcs11h_certificate_signAny() unless the padding</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * is PSS in which case =
we return an error=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static CK_RV</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-pkcs11h_certificate_signAny=
_ex(const pkcs11h_certificate_t cert, const CK_MECHANISM *mech,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                               co=
nst unsigned char *tbs, size_t tbslen, unsigned char *sig,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                               size_t =
*siglen)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (mech-&gt;mechanism =3D=3D=
 CKM_RSA_PKCS_PSS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NONFA=
TAL, &quot;PKCS#11: Error: PSS padding is not supported by &quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        &quot;t=
his version of pkcs11-helper library=2E&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return CKR_MECHANISM_INVALID;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return pkcs11h_certificate_signAny(cert, mech=
-&gt;mechanism, tbs, tbslen, sig, siglen);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif /* PKCS11H_VERSION &gt; 1=2E27 */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Sign op calle=
d from xkey provider</span><br><span>  *</span><br></pre><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989?usp=3Demail">cha=
nge 1989</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1989 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></ht=
ml>
--8AMQuOjMMfk=--


--===============8644979456816898404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8644979456816898404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8644979456816898404==--

