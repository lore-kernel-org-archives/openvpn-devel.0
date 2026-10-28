Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E27606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DqXyHr4I;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HHs8igja;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dMVv5zEU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AGHbtACb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=ZGit9C1AvJtmrpsSaDgxjJDQ2OPsuJozFLRvo5okSyc=; b=DqXyHr4I1Wycr9N+4Ql9UX8dls
	tfzFSJtMmaYvXl5yqTiF7KzqYqV+gsfbUH1zcGKM4kE7T5EfWPr71KNj9aSJDCHzjzypZ7xcOwg8Y
	Gg0JGSgRyMpSaH4wPfdIxcJFx1NzJkHpUPZ4aHGv7/QRasURfT+fboZ4xkLMvx3uuq4M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM6wC-000000004PV-2cGV;
	Wed, 28 Oct 2026 16:55:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM6vg-000000004Ni-3KYu
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:55:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ws18/ayXwBpuPCe45RuifWmKYiWZIt2EKxfT4U1KewE=; b=HHs8igjaIgFbX74P4lEhBRiH2V
 6jZ4Hgv6ST8rrWHns6ftncM5RuQaM8Th5g/sPQkapoSJAL/wtoA5NqUhx6W8WAcY+NSzC629M2vxM
 aElmhL+ZgYNDIwHPrh4ZwDJcFnSOWVUt3gzjXg+LEHOmDACUgupiiRp7oUnHbWOM5M1U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ws18/ayXwBpuPCe45RuifWmKYiWZIt2EKxfT4U1KewE=; b=dMVv5zEUHqIDvSWDoIyJs5/Zpr
 0Lcxgb7SDK3UrrFLl71LaFNyFv8s89e1/SknaW7Sb6YpjtOeEyBfwtLrBNGAhrdyngxDRfG/NoePO
 yJ5YKY36Yp8UucwSVdXWzsVOJKxWdujOP6AXQjsOd21sPVvfoutmtwEe4teNEyXnI1YQ=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM6vf-000000005tr-2rAr for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:55:12 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so1016854f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793206505; x=1793811305; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ws18/ayXwBpuPCe45RuifWmKYiWZIt2EKxfT4U1KewE=;
 b=AGHbtACbqIO885Cg9O+E3tp7WbDWTOyvBQjVYItzlgLEgw5Vu5pnxfWQ+DdyGWKLTY
 GM5id9LJA+ELdtygUX5zIuOZ46uhCnWaMqhtUgliR8tI7Hypj2FMDj9icBXbor1Aw2qC
 6rD/mlMpap+gH0xkp9m9JWyYu+bL7JocL1VkgtdRlKtKqhcutdD5vkUHBZkqF4O7O6HW
 GfxHnbAYgUSEygUePqZSCRoXI3bmWi+/5a3wU+gzvXYjhCht95XxYOunWf6MetqL5TrN
 NM6ZXCTc8MFazmaB1dKhKrlX35IIqUk12hjFryg0KhoZuIypzNkZzA3llqK/D1XNaCH4
 hpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793206505; x=1793811305;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ws18/ayXwBpuPCe45RuifWmKYiWZIt2EKxfT4U1KewE=;
 b=PUTeOqfH/DWYl1Pf3hXbt6y9FEF0OmSlUhHMACqYFzd7aLNUFde2+IUBsTjC7t4Qg3
 Gu8Sc6uwc9zVC50/2HMrsYQsTvAPCTvnXcn4C5iKlsefT6eqAYbugMUOLJwkbbPImkkp
 GNiyESeFEn8/OXdBxm7XUoXIhgC6PX29Ea9gJ84Z+fsg2xyaUIz831hSP62o4kW3S0YD
 gsSrwC/aS4Vejv2jkNa59rZpGFF+oacbgKnwEOIj1SdlDu6O8RUUaSzhWZH/lKdBJ33E
 vCh/doGSs5BVOsvXZNXmqoS4vNwyzodEo5Tm6kY5hk8S1tTCrWs3T3/e9eMjzx+2itQJ
 0cZw==
X-Gm-Message-State: AFq9FYL6XYifECaHVGA+/3nFshCVrv/6NQV2OizMF1LibREqJyt5YZKL
 RBMiHKI9eCtJGDyzQHcq/9MZsihsqfBLykuefR0GS9+PdaNHaZRD1Cflp/f1NV6uYufI1aByvwX
 l7MGqK23ukJJd+3oCenHk0wP+osbidu7d7uQriFiEHQA1XGHUNPM/BS+WF3bZrVcMmiuIoo95z/
 NBo3hhAQ==
X-Gm-Gg: AYBFou3fROAcuNx42Dpm2Ytk4XHNjgoZsChUjoclGSj0SZOn4AcmH00oV7DVgbGkoUF
 if3TRJ4mSfTlc8qN9EDoYPWjNBiZckwV1Ud+pIsl+TKTJUGpKVncymHCBL/ZS+TYErh66KTdJjl
 E4XxCCIAw0m+LuAIimFjvYtrjHXQjhFaj9pU9jc/oNDFif9v+XPnBawlXbdncEbNzWfvaGqNtO/
 lVqos4a2deGZIx/0QKDZAfxhX9rjiWrtSlNUMcbLGFbvgeNTvjeqav24Lp74TpRasN/lTBbXv+4
 2mC/TQtDnSc/R7YLBRaKgF/sWzzL5pE+B7pYw4FWtDuomxBA2uiwkE+pB9gt04+3gmxGzd1phdX
 QlXNQ/YSv99BRZ/GOrr0OUXnOfVRBc5WrCmNtmV9sgErkjhBhaj7u/2Z6motWpB/LgkMxLmkWZQ
 ND0Yn42Ec2Lxjji2qFmRYscN5wGWCqLyzUbk39MsJ1WdeSWmg104UUlH3yQAV0AExd7a4YyrPy+
 N1wJeJ3wQYwFq9ZzqY93BlDbI6Mu6n8sT1/z0/INFwi/ri5y+DBmnk5SW85xC9blwkhfwTeR4CO
 2arrTslSe0nxCw7ME73lyIfRQ9u6+BAQC5XHZQkkA6/p9OreaQfLynLXzokNP8a9Hg0T3nnWe13
 B4wW9IFxZwOFB5vzy4EzU7h656V5ulhHeKi2di6S1R1ksVmvTeeaq3LFtREFg5zxMBEiULC/ccg
 Pte/JpE16M5gHMR0w=
X-Received: by 2002:a05:6000:490c:b0:48d:fdc0:65be with SMTP id
 ffacd0b85a97d-48e5d4680f6mr7372250f8f.38.1793206504805; 
 Wed, 28 Oct 2026 09:55:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3932sm30762707f8f.18.2026.10.28.09.55.04
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:55:04 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 16:55:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3878195ceedd75a1a4ba6adcbffd1adbfda66e66
X-Gerrit-Change-Number: 2066
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2066?usp=email>
X-Gerrit-Commit: c45fa1ff6788c201810b57782bc4ba55003410f8
References: <gerrit.1793206499000.I3878195ceedd75a1a4ba6adcbffd1adbfda66e66@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA2NDk5MDAwLkkzODc4MTk1Y2VlZGQ3NWExYTRiYTZhZGNiZmZkMWFkYmZkYTY2ZTY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <20fcc9dc2eb1655df5ffddf4fc7795d9c6cd5b81-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM6vf-000000005tr-2rAr
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Avoid polluting
 OpenSSL error stack for "none" cipher/digest
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2357422317926327957=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2357422317926327957==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zkvoD+b5bzI="; charset=UTF-8

--zkvoD+b5bzI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2066?usp=3Demail )


Change subject: Avoid polluting =
OpenSSL error stack for "none" cipher/digest
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Avoid polluting OpenSSL error stack for "no=
ne" cipher/digest

There is certain parts in OpenVPN where we check cipher_=
kt_mode_cbc
for the cipher and also=2E This especially causes some cipher/d=
igest
not found when querying the "none" cipher or digest=2E Especially
sin=
ce AEAD ciphers use "none" internally as the HMAC algorithm=2E

Change-Id: =
I3878195ceedd75a1a4ba6adcbffd1adbfda66e66
Signed-off-by: Arne Schwabe <arne=
@rfc2549=2Eorg>
---
M src/openvpn/crypto_openssl=2Ec
1 file changed, 12 ins=
ertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/66/2066/1

diff --git a/src/openvpn/crypto_openssl=2E=
c b/src/openvpn/crypto_openssl=2Ec
index e6abd8f=2E=2E714e6c7 100644
--- a/=
src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -568=
,6 +568,13 @@
 {
     ASSERT(ciphername);
 
+    /* For the "none" cipher w=
e just immediately return NULL here to avoid
+     * putting errors on the =
OpenSSL error stack */
+    if (!strcmp("none", ciphername))
+    {
+      =
  return NULL;
+    }
+
     ciphername =3D translate_cipher_name_from_open=
vpn(ciphername);
     return EVP_CIPHER_fetch(NULL, ciphername, NULL);
 }
@=
@ -979,6 +986,11 @@
 static evp_md_type *
 md_get(const char *digest)
 {
+ =
   /* Avoid pollution the OpenSSL error stack for the "none" dummy digest *=
/
+    if (!strcmp("none", digest))
+    {
+        return NULL;
+    }
   =
  evp_md_type *md =3D NULL;
     ASSERT(digest);
     md =3D EVP_MD_fetch(N=
ULL, digest, NULL);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2066?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I3878195ceedd75a1a4ba6adcbffd1adbfda66e66
Gerrit-Change-Number: 2066
Ger=
rit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--zkvoD+b5bzI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2066?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Avoid polluting OpenSSL error stack for &quot;none&quot; ciphe=
r/digest<br><br>There is certain parts in OpenVPN where we check cipher_kt_=
mode_cbc<br>for the cipher and also=2E This especially causes some cipher/d=
igest<br>not found when querying the &quot;none&quot; cipher or digest=2E E=
specially<br>since AEAD ciphers use &quot;none&quot; internally as the HMAC=
 algorithm=2E<br><br>Change-Id: I3878195ceedd75a1a4ba6adcbffd1adbfda66e66<b=
r>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/op=
envpn/crypto_openssl=2Ec<br>1 file changed, 12 insertions(+), 0 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/66/2066/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_openss=
l=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>index e6abd8f=2E=2E7=
14e6c7 100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</span><b=
r><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -568,6 +568=
,13 @@</span><br><span> {</span><br><span>     ASSERT(ciphername);</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* For=
 the &quot;none&quot; cipher we just immediately return NULL here to avoid<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * putting error=
s on the OpenSSL error stack */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!strcmp(&quot;none&quot;, ciphername))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     ciphername =3D translate_cipher_name_from=
_openvpn(ciphername);</span><br><span>     return EVP_CIPHER_fetch(NULL, ci=
phername, NULL);</span><br><span> }</span><br><span>@@ -979,6 +986,11 @@</s=
pan><br><span> static evp_md_type *</span><br><span> md_get(const char *dig=
est)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Avoid pollution the OpenSSL error stack for the &quot;none&quot;=
 dummy digest */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!strcmp(&quot;none&quot;, digest))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span>     evp_md_type *md =3D NULL;</span><br><span=
>     ASSERT(digest);</span><br><span>     md =3D EVP_MD_fetch(NULL, digest=
, NULL);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2066?usp=3Demail">change 2066</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2066?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I3878195ceedd75a1a4ba6adc=
bffd1adbfda66e66 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2066 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--zkvoD+b5bzI=--


--===============2357422317926327957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2357422317926327957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2357422317926327957==--

