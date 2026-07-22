Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D22C44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hBxomL+rdN5v0hnPZT5DIFQHqkRglcU7RE+Ls+VrrMY=; b=ENo/P0TOdMNrzjBkfYYJjkKz9Q
	emk5uBbWk7pIv2uO8yqM/2ZH5MPRXWLbm7xlzbpaP2BaQGz/q8SVm+jeXWw4h3Tve2dPvhQfoYPlz
	SrfnphpY+Fn5SX4piadEY9EXFgpQP2LPYtU3rLbVayg52nYOI3ph3rMXaMgrICHYmWbQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmUFC-0004bM-U8;
	Wed, 22 Jul 2026 10:32:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmUFB-0004bE-7h
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Od3pSAq1ZeCb1gQ3+iGJok4ro/czyP5bpONinjW7mWw=; b=PNC4ecdJ3xRMa7SZTg6eSLfBC2
 /4W4qmQEj5/yemY4+4NLFNyX2sWKz0cu1im0/wQPdetoLJvrqexIQ8FQSF1l9G9ADH1jZOJL7ozxJ
 qbg/gZMQlnKaDHMfGXGDqPEzkUTGV4FGzkqOokiFwVTSj+olNlQ4wDixhUSFyo/NvCHg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Od3pSAq1ZeCb1gQ3+iGJok4ro/czyP5bpONinjW7mWw=; b=X
 smS6Ok/2Emx6d+Amg9crtD01hd3aJVgL3VSz6ysBYucOMZpp/eRTawJqZaPWnu3AWkdV9Ko2PP1ir
 z7Zu0+A5WgLkE1KuOBIuEkmvimtPSGRSQ1QdTm/rOsVzbMeDl1+Zw21fqbO48+7gEKwjc+d8KLIec
 aW6Z1pDOuImR8Ol0=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmUF9-0007ui-Fv for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:32:05 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47640541585so6518321f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 03:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784716312; x=1785321112; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Od3pSAq1ZeCb1gQ3+iGJok4ro/czyP5bpONinjW7mWw=;
 b=eP/RERoyVZp5bkVPJuReVl9l6/wOEJu3t63ZiTTiHbHwA0Hhh8SKavQtEt50EyJTPF
 /IKqdXVHPpO61/dFsiKhQzlfRHuIOZ9JO4lYqmwaKu+7ZHl43TA3AzVlMkvKFy6I34Kl
 AZi7+pn7MMwf+o/eBIAVBH6qjF1CRTwfWZPPmIHtBVZxXNhvQtip2tpmSco494DzjK/t
 +TK2zodkcm61SBzLZew06UgP9iAAU79s+N0PB3g+BCC1Uz9ENCpER+QnPmKnhaXvHzPt
 13FuuifzLQsCUdOQWcpoIk3Spua4JgILzQDKYoc/cdInfbN4zyZcd2XdsPExO1nKAWnB
 TCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784716312; x=1785321112;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Od3pSAq1ZeCb1gQ3+iGJok4ro/czyP5bpONinjW7mWw=;
 b=J+YJCfMYsqLNnRut6ks9Qf6ZGtUxSmSM66gGFBzrwlu5rufXB8EeCZfXW7B5RFm+a5
 +d71gOPGWVA2QVMeimHCW/9OILgSHDTfLAy0XliwfWP9L1LzyUzQYfSGvtGPmf4VM3pL
 7ez6cV4Wd2Ii5P8KHlPKTIDRMf3J7CEFlnhoDe6ibyHHeUbSD39hF5caNwk4GWbzPTxx
 sm8rvHf4ueuZi+HWo0vlkumZDoxLYqcy90ZXeDe7fieQ/HYgU8OiKSkT0JtUXZCg6nR3
 rkdrmUUDTPqrKl+F4leZkT8edFylpkLu/NxY+6u8+qwIEMiztuU/u5CGEtFHxsTrqbeL
 66aA==
X-Gm-Message-State: AOJu0Yy2YqJQZyrMzXNTbKcaWNEY1alZQJnbLFGk2ozFxUvbbgsbTVAF
 BVECe8wgUVEaTMMp3KF6qrqPzDm07LLjfJQ6DRJaFi6yEsHJ/pSW169iQYl9OQQS1UvKPGa1vFv
 PuvOYHmjHGRq/9H0ZQe/zRWUEZys+1jTDgnBaW0LZC788r5swmOuduhEQIllbzWUPp0BxwPJx8G
 rkCgatpg==
X-Gm-Gg: AR+sD13Imn8Itu4qIy2vxXAzOgPfoUFSLa/3FuxijHKrZ1SaV/WvE9lb/hdBo/DSh/D
 AruezYn8q4Vk3hTuWa4NBH92gk/7I75f0k9eIL8SUL+Xjljtuki2ey/yBYzV3Y+JgFcu/QjQ/Gc
 jJoeWGdxByaAs7y4Wt38qgTSOidQzzeFRoQCPDQrVoS5UqzS1LQOvkbD7pQCuF+kNtCX+IFjv2Z
 r2lF5daVoWJvKTsdS1dgZGGo/IkJyI/f3oi2TSfXE5Y//htFueQ6+wT+j8YBroJQx33JfTqvUhT
 oTdly0FTY3cVgEAhQsq9G7CQPhBGrk8lN98pqLxeVku53AcLYBHALlJF1KLEpCXppl/a/WrZLyS
 CVCbUi/LrR7tyPsb3qZiqiznJjaKRYOLrGSntxIKt/EkZTNOVVR1X/YPHeSYDBHv+TsR3HTRTUK
 R6t+acfwuqRIXakE79TjH0KUhrVlEnhlyFEOZZi/RwK5/RFBXrDFmb8NTdG87a5ZHyztpbOxF2V
 cKeImPMZomLihbMCfpzHHcgy56+YpeQ9oAZ0BlUd5S8EAb89oUH2vgLQbz2Uno4NR3b
X-Received: by 2002:a05:6000:2083:b0:472:3090:d878 with SMTP id
 ffacd0b85a97d-47f623075abmr24647051f8f.4.1784716311730; 
 Wed, 22 Jul 2026 03:31:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb5a46sm5027472f8f.9.2026.07.22.03.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:31:51 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 10:31:48 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: 9d0ee07b20b50dc7d63643cd521f4ddb0a8005df
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <80a81576cc9d45e45a9006b5d366d2b93d5514ac-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmUF9-0007ui-Fv
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add aws-lc siphash
 implementation
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0578356742843978524=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0578356742843978524==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zeNyHVpaOW4="; charset=UTF-8

--zeNyHVpaOW4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail

to look at the new pa=
tch set (#10)=2E

The following approvals got outdated and were removed:
Co=
de-Review+2 by flichtenheld

The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now=2E


Change subject: Add=
 aws-lc siphash implementation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Add aws-lc siphash implementation

AWS-LC has a siphash=
 implementation that is just a simple function call
that also performs the =
same/better than the reference implementation that
it looks to be based on=
=2E AWS-lc variant seems to have come from boringssl
according to the Googl=
e copyright=2E

Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Signed=
-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/siphash_openss=
l=2Ec
1 file changed, 42 insertions(+), 2 deletions(-)


  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/72/1572/10

diff --git a/s=
rc/openvpn/siphash_openssl=2Ec b/src/openvpn/siphash_openssl=2Ec
index 214b=
3f4=2E=2E8bf8bd3 100644
--- a/src/openvpn/siphash_openssl=2Ec
+++ b/src/ope=
nvpn/siphash_openssl=2Ec
@@ -113,7 +113,49 @@
     EVP_MAC_free(sip->mac);
=
     free(sip_context);
 }
+#elif defined(OPENSSL_IS_AWSLC)
+#include <open=
ssl/siphash=2Eh>
+#include <string=2Eh>
+#include "error=2Eh"
+/*
+ *  Comp=
utes a SipHash value
+ * in: pointer to input data (read-only)
+ *  inlen: =
input data length in bytes (any size_t value)
+ * k: pointer to the key dat=
a (read-only), must be 16 bytes
+ * out: pointer to output data (write-only=
), outlen bytes must be allocated
+ *  outlen: length of the output in byte=
s, must be 8 or 16
+ */
+int
+siphash_cryptolib(void *sip_context, const vo=
id *in, const size_t inlen,
+                  const void *k, uint8_t *out,=
 const size_t outlen)
+{
+    ASSERT(outlen =3D=3D sizeof(uint64_t));
+    =
uint64_t sipout =3D SIPHASH_24(k, in, inlen);
 
+    memcpy(out, &sipout, s=
izeof(uint64_t));
+    return 0;
+}
+
+void *
+siphash_cryptolib_init(size_=
t hash_size)
+{
+    /* This library only supports 64 bit */
+    ASSERT(ha=
sh_size =3D=3D sizeof(uint64_t));
+    /* AWS LC does not need a context */=

+    return NULL;
+}
+
+bool
+siphash_cryptolib_available(void *sip_contex=
t)
+{
+    return true;
+}
+
+void
+siphash_cryptolib_uninit(void *sip_cont=
ext)
+{
+    /* The context is already NULL */
+}
 #else
 /* for now, we on=
ly have one implementation of SIPHASH in a libray, so put the
  * dummy fun=
ctions also here */
@@ -140,6 +182,4 @@
 siphash_cryptolib_uninit(void *sip=
_context)
 {
 }
-
-
 #endif /* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL=
_VERSION_NUMBER >=3D 0x30000000L */

-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1572?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Gerrit-Change-=
Number: 1572
Gerrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <fr=
ank@lichtenheld=2Ecom>

--zeNyHVpaOW4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #10</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+2 by flic=
htenheld</p><p>The change is no longer submittable: Code-Review and checks~=
ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">Add aws-lc siphash=
 implementation<br><br>AWS-LC has a siphash implementation that is just a s=
imple function call<br>that also performs the same/better than the referenc=
e implementation that<br>it looks to be based on=2E AWS-lc variant seems to=
 have come from boringssl<br>according to the Google copyright=2E<br><br>Ch=
ange-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6<br>Signed-off-by: Arne S=
chwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/siphash_openssl=
=2Ec<br>1 file changed, 42 insertions(+), 2 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/7=
2/1572/10</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/siphash_openssl=2Ec b/src/openvp=
n/siphash_openssl=2Ec</span><br><span>index 214b3f4=2E=2E8bf8bd3 100644</sp=
an><br><span>--- a/src/openvpn/siphash_openssl=2Ec</span><br><span>+++ b/sr=
c/openvpn/siphash_openssl=2Ec</span><br><span>@@ -113,7 +113,49 @@</span><b=
r><span>     EVP_MAC_free(sip-&gt;mac);</span><br><span>     free(sip_conte=
xt);</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#elif defined(OPENSSL_IS_AWSLC)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &lt;openssl/siphash=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Computes a SipHash value</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * in: pointer to input data (=
read-only)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  inlen=
: input data length in bytes (any size_t value)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * k: pointer to the key data (read-only), must=
 be 16 bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * out:=
 pointer to output data (write-only), outlen bytes must be allocated</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  outlen: length of the =
output in bytes, must be 8 or 16</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib(v=
oid *sip_context, const void *in, const size_t inlen,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  const void *k, uint8_t =
*out, const size_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
outlen =3D=3D sizeof(uint64_t));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    uint64_t sipout =3D SIPHASH_24(k, in, inlen);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(out=
, &amp;sipout, sizeof(uint64_t));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_init(size_t hash_size)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* This library only supports 64 b=
it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(has=
h_size =3D=3D sizeof(uint64_t));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* AWS LC does not need a context */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_ava=
ilable(void *sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+siphash_cryptolib_uninit(void *sip_context)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* The context is already NULL */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #else</span><br><span>=
 /* for now, we only have one implementation of SIPHASH in a libray, so put=
 the</span><br><span>  * dummy functions also here */</span><br><span>@@ -1=
40,6 +182,4 @@</span><br><span> siphash_cryptolib_uninit(void *sip_context)=
</span><br><span> {</span><br><span> }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> #endif /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSS=
L_VERSION_NUMBER &gt;=3D 0x30000000L */</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?u=
sp=3Demail">change 1572</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1572?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1572 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit=
-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>

</body></html>
--zeNyHVpaOW4=--


--===============0578356742843978524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0578356742843978524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0578356742843978524==--

