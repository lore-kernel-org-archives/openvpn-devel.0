Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF72C5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Ip4RKqYguWmkSMr9Xq9uBrAjQxZe6oF16QdZm89/jL4=; b=SJh34IyNykNSTp
	M2pC9bf1mTh7B6LAx5HjtRrpo/aO42Mu2rPXsT8xVvcFL2MXZ1YBvuceH/SisV608I0Ggd60VhXzk
	tEwAv7k0232fs2uRB9w8RQnQJbjgJpHIfM6sLcAAacXKzYsW5YVr1cJXk4NAJpca2ckHvDoXNJUIA
	hwY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwhsc-0005JW-Jb;
	Wed, 19 Aug 2026 15:07:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwhsb-0005JQ-FV
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:07:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0eLkPEN+u7bBZywGkUC9AfuvLbEnQGS1Pc2pAC4zB5M=; b=eH/2XSoO2fDCz2OVGUbFWt8kSo
 HF36C9WFBkpnBrObT+Ahzs2agEyNKsb6iaD3sWWxcvISmGccKm4v2rMXdGIxM5MNquYoZFee8GbIV
 MDKOP4DVRUmoHBMdYw4dnpduf6FqFlRaT+QcZKdgRPYl2TUhRayi1xBfGoiXXzFBt3e0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0eLkPEN+u7bBZywGkUC9AfuvLbEnQGS1Pc2pAC4zB5M=; b=i
 yL+eQoTWJO4S2YydvhOKrHpYQrW0NZgpYx4BgFI6LuzJM8GWBNCB3MLX2x011tVTaDBNED17NAiw+
 5VekH07intmrC4hEQo2LuTtfY7q4o+vYmiM6UAmyQxkV3vomZqAOLRK60H/HeAcym/GZ9Wi2wROcp
 cwIDOyQZybolK3xo=;
Received: from mail-lf1-f49.google.com ([209.85.167.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwhsa-0005wd-Hx for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:07:02 +0000
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5b021916bd3so1720785e87.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787152014; x=1787756814; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0eLkPEN+u7bBZywGkUC9AfuvLbEnQGS1Pc2pAC4zB5M=;
 b=DS84hHvLixro39CKGc4tvwczNfTv6WybLtit3tTVp81feC2JCZHD4e8RfCrY+6VHn7
 V+rLpMZBFrwBfAoLPYm+5tZevM8kbD8VE/CXoyiZmOZCLYqGpRwWYuBQSBSERZs+pIcY
 XmZA604Qya2vCB35VZOTJnSdSJZQkSre1jocLUHslIy+ItKFAd6eOLk6QoQHcof3JKkK
 xAKKrOREi+ZnMTdKz7CtvnwxLsNSscs9IN3vCjX2sSXJ3HCO1cZMf93M+ew9ad5HPHP0
 G4MCPq3I7+XCY1nimxqZfNGGmvT9uY8XOfCDM+PNGd8u6pMVYFmOoFhv0q06qJY97jrt
 zJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787152014; x=1787756814;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0eLkPEN+u7bBZywGkUC9AfuvLbEnQGS1Pc2pAC4zB5M=;
 b=AS+Xn+zyoxNky4NWvrFEOv6gySIwMQAUj5rTO0O695k/MNa4fW40U1dOGOxnFHZTsh
 EDl7kbHdf4YCwUXKhvX3KpBqzCPqYulhMS9lTszGxi1vKkj2yQc9KXTiU+hGU4kr+zXT
 3kT3rqDcMnzq5BvPxNl+S4ApGMAntszyCmAO3Hwx5CaQoB4oTuHlJF0J9v1KSoX1annD
 12ZGl0oAbvOTYhLZtnef73BPrH+V5S1t/niW6qtngOnp7g+2WD1lHpJddCRnR75F50U/
 EsKlM+7kPR18uBRS83aw2hWKmfz8TVxvEoxWsXSmtP7y0Iq9wId0o/mbjQCsHIlIptBr
 pkIw==
X-Gm-Message-State: AOJu0YxEz0i0vug8qnhCRqDmaDfNMqx1ejf5fT0VvEg6eOvsbsdv6Xh3
 SfiObpsWCldlV8J1dgUMFbkCC8/G4AXR4zkpvpOEzuZOaJBrDI7lvIkYZIO+AnaunYCdH277bL/
 JD0dBnBp7Flr/bB82VsbhxIYhFfzlDiWUp5NobN74E4YkJ9Gw3q+YmzKKrQl9XD1jRDSbe+08ZA
 Vg0aXfzg==
X-Gm-Gg: AR+sD13A2Wi2UgEZPCSUOt5r82rsCRFXwT7ClKLaolCKUIjI3/7zJlQpJt3UoDQi3DA
 qIIWYtzz5EsZHkgYWzhN/Cbhf8rZ43KTRZYdBYVPPYRilnglzuUae6QlEAJDWQbgye2Np/zerQm
 O6ENgSLoFjjNjn6vGWvLLUmXf/WpDeA5MkuVL4XWCqWRURJn+r3/bSXW+6BCoZJHUMKdrN7Uloo
 mO83DB2i1fN18pk+EhzigxGtxkXgDPgEFNM0WcH7Vq//WXQwOqkArDl2XLeOAjRaiT4UGxpPhfu
 qopJ6MI4XTWB7nJnGvxuPupj1wP1y7ZWnqc8g14e2eKeMB84XS9frn4Uz1toVT6eNB86Lf88dKs
 GoMlzq7hVIrUsGREofm6B3Z7P+zoLNnNYo6pbHGXY6NKaeVMNcf8+g0Qh1ipRrCvYEq8J0I5/X6
 sWFSlP+5/3jSaW5q8C2iV6SgyUtVup7zdu7kvxZcbsNBHkBQYy+l8GtKvY+E/FWDVT08i9fR7j2
 tNpyx0u470xjh5/urT+3nIhnwmWhPIHUKPyOKTcVNRVSmqC4dObPAdzSf6ty/XQdX3V6ZNcuAbt
 k38Tl24x3pO+/KIy/EFdOaR2ZBmdLPTMov7eVN/vyQhQGhMEXHO/fLjs0/9Vyg==
X-Received: by 2002:a05:600c:6211:b0:499:a760:722f with SMTP id
 5b1f17b1804b1-499aa1ba0b7mr101911375e9.13.1787150250612; 
 Wed, 19 Aug 2026 07:37:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9dff4c1sm45929285e9.3.2026.08.19.07.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 07:37:30 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 14:37:29 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
X-Gerrit-Change-Number: 1849
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1849?usp=email>
X-Gerrit-Commit: 63603d64043f4ffc0761d964988ccddc36772709
References: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTUwMjQ4MDAwLkk2OTQ0MTA2MTU5NThhZmJiNDIyZDllYWQ3MWYwNGMxYTYwZWRjNjQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <12a5dc04530e58d3f3680413144470a5e30c2e87-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwhsa-0005wd-Hx
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbedtls: Work-around
 bug in mbedtls 4.1.0 and 4.2.0
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8650388615611159544=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8650388615611159544==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KtMv41LMAlA="; charset=UTF-8

--KtMv41LMAlA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1849?usp=3Demail

to review the following change=2E


Chang=
e subject: mbedtls: Work-around bug in mbedtls 4=2E1=2E0 and 4=2E2=2E0
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mbedtls: Work-ar=
ound bug in mbedtls 4=2E1=2E0 and 4=2E2=2E0

Since the first distros have s=
tarted to pick up these
versions before a fix is released, let's make our t=
ests
pass on these versions=2E

A fix is merged, so it might be fixed in 4=
=2E3=2E0=2E But I
didn't want to add that to the version check until we
hav=
e verified that=2E

Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
Si=
gned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M =2Egithub/wo=
rkflows/build=2Eyaml
M src/openvpn/mbedtls_compat=2Eh
2 files changed, 13 i=
nsertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/49/1849/1

diff --git a/=2Egithub/workflows/build=2E=
yaml b/=2Egithub/workflows/build=2Eyaml
index 29e8be2a=2E=2E56dd3ed 100644
=
--- a/=2Egithub/workflows/build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eya=
ml
@@ -365,7 +365,7 @@
       ovpnlibdesc: mbed TLS 4=2E
       # versionin=
g=3Dsemver-coerced
       ghrepo: Mbed-TLS/mbedtls
-      gitref: v4=2E0=2E=
0
+      gitref: v4=2E2=2E0
       libconfigure: cmake -B build -DCMAKE_INS=
TALL_PREFIX=3D$LIBPREFIX
       libmake: cmake --build build
       libinst=
all: sudo cmake --install build
diff --git a/src/openvpn/mbedtls_compat=2Eh=
 b/src/openvpn/mbedtls_compat=2Eh
index 50739b6=2E=2E7149487 100644
--- a/s=
rc/openvpn/mbedtls_compat=2Eh
+++ b/src/openvpn/mbedtls_compat=2Eh
@@ -43,6=
 +43,7 @@
 #include "crypto_mbedtls_legacy=2Eh"
 #else
 #include <mbedtls/o=
id=2Eh>
+#include "crypto_mbedtls=2Eh"
 #endif /* MBEDTLS_VERSION_NUMBER < =
0x04000000 */
 
 #ifdef HAVE_PSA_CRYPTO_H
@@ -228,6 +229,17 @@
 mbedtls_com=
pat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_pk_context *=
prv)
 {
 #if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
+    /* work around bug=
 in mbedtls 4=2E1=2E0 by adding missing public key information in prv
+    =
 * cf=2E https://github=2Ecom/Mbed-TLS/TF-PSA-Crypto/issues/807 */
+#if MBE=
DTLS_VERSION_NUMBER >=3D 0x04010000
+    if (prv->MBEDTLS_PRIVATE(pub_raw_l=
en) =3D=3D 0)
+    {
+        ASSERT(mbed_ok(psa_export_public_key(prv->MBE=
DTLS_PRIVATE(priv_id),
+                                             (uint8=
_t *)prv->MBEDTLS_PRIVATE(pub_raw),
+                                      =
       sizeof(prv->MBEDTLS_PRIVATE(pub_raw)),
+                            =
                 (size_t *)&prv->MBEDTLS_PRIVATE(pub_raw_len))));
+    }
+#=
endif
     return mbedtls_pk_check_pair(pub, prv);
 #else
     return mbedt=
ls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_random, rand_ctx_get());

-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I694410615958afbb422d9ead=
71f04c1a60edc640
Gerrit-Change-Number: 1849
Gerrit-PatchSet: 1
Gerrit-Owner=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--KtMv41LMAlA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">mbedtls: Work-around bug in mbedtls 4=2E1=2E0 and 4=2E2=2E0<br><br>Sin=
ce the first distros have started to pick up these<br>versions before a fix=
 is released, let&#39;s make our tests<br>pass on these versions=2E<br><br>=
A fix is merged, so it might be fixed in 4=2E3=2E0=2E But I<br>didn&#39;t w=
ant to add that to the version check until we<br>have verified that=2E<br><=
br>Change-Id: I694410615958afbb422d9ead71f04c1a60edc640<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M =2Egithub/work=
flows/build=2Eyaml<br>M src/openvpn/mbedtls_compat=2Eh<br>2 files changed, =
13 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/1849/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml</=
span><br><span>index 29e8be2a=2E=2E56dd3ed 100644</span><br><span>--- a/=2E=
github/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub/workflows/bui=
ld=2Eyaml</span><br><span>@@ -365,7 +365,7 @@</span><br><span>       ovpnli=
bdesc: mbed TLS 4=2E</span><br><span>       # versioning=3Dsemver-coerced</=
span><br><span>       ghrepo: Mbed-TLS/mbedtls</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      gitref: v4=2E0=2E0</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      gitref: v4=2E2=2E0</span><br><span>    =
   libconfigure: cmake -B build -DCMAKE_INSTALL_PREFIX=3D$LIBPREFIX</span><=
br><span>       libmake: cmake --build build</span><br><span>       libinst=
all: sudo cmake --install build</span><br><span>diff --git a/src/openvpn/mb=
edtls_compat=2Eh b/src/openvpn/mbedtls_compat=2Eh</span><br><span>index 507=
39b6=2E=2E7149487 100644</span><br><span>--- a/src/openvpn/mbedtls_compat=
=2Eh</span><br><span>+++ b/src/openvpn/mbedtls_compat=2Eh</span><br><span>@=
@ -43,6 +43,7 @@</span><br><span> #include &quot;crypto_mbedtls_legacy=2Eh&=
quot;</span><br><span> #else</span><br><span> #include &lt;mbedtls/oid=2Eh&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;c=
rypto_mbedtls=2Eh&quot;</span><br><span> #endif /* MBEDTLS_VERSION_NUMBER &=
lt; 0x04000000 */</span><br><span> </span><br><span> #ifdef HAVE_PSA_CRYPTO=
_H</span><br><span>@@ -228,6 +229,17 @@</span><br><span> mbedtls_compat_pk_=
check_pair(const mbedtls_pk_context *pub, const mbedtls_pk_context *prv)</s=
pan><br><span> {</span><br><span> #if MBEDTLS_VERSION_NUMBER &gt;=3D 0x0400=
0000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* work aro=
und bug in mbedtls 4=2E1=2E0 by adding missing public key information in pr=
v</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * cf=2E https=
://github=2Ecom/Mbed-TLS/TF-PSA-Crypto/issues/807 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x0401=
0000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (prv-&gt=
;MBEDTLS_PRIVATE(pub_raw_len) =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        ASSERT(mbed_ok(psa_export_public_key(prv-&gt;MBEDTLS_PRIVATE(=
priv_id),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                   (uint8_t *)prv-&gt;MBEDTLS_PRIVATE(pub_r=
aw),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                              sizeof(prv-&gt;MBEDTLS_PRIVATE(pub_raw)),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                      (size_t *)&amp;prv-&gt;MBEDTLS_PRIVATE(pub_raw_len)))=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     ret=
urn mbedtls_pk_check_pair(pub, prv);</span><br><span> #else</span><br><span=
>     return mbedtls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_random, rand_=
ctx_get());</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">change 1849</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I694410=
615958afbb422d9ead71f04c1a60edc640 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1849 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--KtMv41LMAlA=--


--===============8650388615611159544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8650388615611159544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8650388615611159544==--

