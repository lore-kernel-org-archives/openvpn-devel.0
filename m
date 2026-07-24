Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B37C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bgIJewkbTrPxDnV9/8nzhE8n5E7OYxBNFf+NaqVoYJs=; b=DTJngWTB/vp45/IbOUloX9Csgl
	JtZ1R7kQoggadrzKPeQaKb6O92c8AZq2AeC/rw0JbR8uUXG0aBH9aGtZ1F9EsCLSPtXQmxgU9cDWK
	T05A9ENXYzkEicSUQDrJ9yOQd9L/PsLeiSA/HEUA3RDDwijAzX5euE/dAr0yGIoPaOGg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnIKr-0003YQ-6O;
	Fri, 24 Jul 2026 16:01:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnIKg-0003Xu-OF
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:01:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1f5M15xtaDNXWW+0vJICTCm1LUbpCSlwoVmiuB4TY7M=; b=IJpuqiyu0CYPUh9S2xMQ+JFob7
 YXeLzBQclZZyVKXri+glPYctNNSs9eB7MUIrcNgGWwm/WQ0n1UXhV8A0xav/ENb1xGdVnM6QABZY5
 jdFnw9GPRAU81NFX5VB8qU5Lf1qN6xor6au2IN9KCY/1wyWWHmHoSN1b2yQ17X4kHdWQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1f5M15xtaDNXWW+0vJICTCm1LUbpCSlwoVmiuB4TY7M=; b=C
 g+JWE5qxAk5blnA9GhgfabtH/2REa2segCd1yH/2pss4umc3j3QZQTD8CnFGGfJoj/CeU8oVfpUUb
 LSFk1h5jXwmsTZtM6oxWbip17REafvQcauWezELOsMbTdmKpBfOCH5TT835EqsMWumHJpTqtf+PHo
 SHvsagsmzHbNQB68=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIKj-0005aK-Gp for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:01:07 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so1085598f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784908859; x=1785513659; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1f5M15xtaDNXWW+0vJICTCm1LUbpCSlwoVmiuB4TY7M=;
 b=CehBYRh2icussk9jJ5HY/ZkGnChbTT72jqObu5kv/8lWOXG1ari+BBLKWSY1SWf7tH
 sMeOR9ppfp3GdIlfReChSyiJoYnT8OP+kmCshg5OEMCM7ulbASMoKFGIve93OLFEIgSO
 nlwWwwDgFyO8VktEilscO3/r7o6fW5vAH4ZStD9nC48tILoC9y0rwEw+6jrqcbQn1RIL
 ZJ6zBFsNNKD0QN0ifWCTeuBvjtwjPiBAVWAFfCYMBDHVQiio1HJSgJDwULel3fC6133A
 rRjCFP8qQEJrhM8Udxr5dRtcCCL7eIblahk89WnfIV0ogAjYxUZbezj+DINaeYFxfIM6
 MqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784908859; x=1785513659;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1f5M15xtaDNXWW+0vJICTCm1LUbpCSlwoVmiuB4TY7M=;
 b=csNFARZE0ktsPv+WPOgocCecg+4aFDF9/Dk2qNF6m8/xRvTR1apwKIa4jzAEgvNkP7
 Jna91hIqJDoI+/KYvMHfohEFxCeu57uXYk+6pZ3WBwaVPFUOo7nuTTx2Tgm36LLXqKz2
 sbdy6AneyXqP7K1LtYWvqBh4mG8l6kQDl9qlVbSACqAr7JTmpnfC/CIuRVJ5vHxe0U+p
 BRwibQrReBGboLqK0Cm1xrPrkXjj6hLhbPepUvs4N8gJOd2M72ju8gM8KPDqNEon5fs+
 TgmGlU2kAt5Xmgs9ti/wVoUf3ad0+QlKdM93vIA3K16LuTdW8wO5ABtmPLnIl+lTYj0w
 SaFw==
X-Gm-Message-State: AOJu0YwuhOe+pZ9Bc6FNpNoO2mjvldCOG9GGWLMnGulbAynpg4unl78d
 j/0ZdqqomhOj6cpvR7ZnakJh0o50GOt+jHHoyi2fKhkeI91PEmlkmffHZPIlEXjyXx4i/LVSMvF
 6Y2NGN08IecAJjdl3Nx8QnJUlpkx3bNRsYNzco0jROXg1h4oRIHCkAM3vTBKFrDaJGR/TmSbaTN
 Y6reYZgQ==
X-Gm-Gg: AR+sD11q+KpKfAEhDulquZ1Sg2GfxOz89eo/NGrukzVlNey+Zz8c/nkhY3zYzyN5eOy
 wgX+3SShfP8QVfNmNsilC5DMNtpX5So5x/MPisPCZzxc33pTzYStK+VwCK6mO5tjRQINsPQcotP
 dZFi2wVc1+MmAOLH2w9/aEr8xO1wR1goHlUhlp3ryESusB0fEoysOVwdJDMc0EFSJKIo3zjIPqL
 307YeByNWJ5oVUZAr0L1sUzMpXgNzsN58uS55oLGTMYs9Qia2YBe8ybS1o/LiKQ8grtvbjwVmRp
 t0Ief1m7q4tvH8CRg2jMdeMo+81q2nyeKaplb+hOefjxNyftdTONBVN69HHVTJfWi6B55u05Ex1
 qKaRK6vPiMDAwj6LIaK9gzZAIbrH0p71nwukLs7FIl2bPW4ikI/dLgepOoGkvVLjX/sIWPuugyi
 jo4H1SL9kpGO6IvgLu8DrahXzciEAu6NoXmq8D6H70DYCvmLVu1Fm1PO12vEh1r1a3eea99hIWV
 Qb/h2nXR7D5/AFiiNILDmKPVlJNL6/NhSXBUQSPLgsHGeWuEOb6HCHz9/pccV0lez717/d3Si1B
 Iyk=
X-Received: by 2002:a05:6000:288b:b0:47f:8a21:b760 with SMTP id
 ffacd0b85a97d-47f9d08e1e4mr1314616f8f.4.1784908859280; 
 Fri, 24 Jul 2026 09:00:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f864305f5sm24485139f8f.17.2026.07.24.09.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:00:58 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:00:47 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: 588c3bbb7960d703110c7dcb511bd58fa2cb8d27
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dc5013709b116957f6e06765b99c8ac502c9f030-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnIKj-0005aK-Gp
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
Content-Type: multipart/mixed; boundary="===============4608513236083910199=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4608513236083910199==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2kP88cR2E28="; charset=UTF-8

--2kP88cR2E28=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail

to look at the new pa=
tch set (#13)=2E

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
M src/openvpn/siphash=2Eh
1 =
file changed, 30 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/72/1572/13

diff --git a/src/openvp=
n/siphash=2Eh b/src/openvpn/siphash=2Eh
index bddddc3=2E=2E7ced09f 100644
-=
-- a/src/openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -33,11 +33,40=
 @@
                   uint8_t *out, size_t outlen);
 
 
+#if defined(OPENS=
SL_IS_AWSLC)
+#define USE_CRYPOTOLIB_SIPHASH
+#include <openssl/siphash=2Eh=
>
+#include <string=2Eh>
+#include "error=2Eh"
+/**
+ *  Computes a SipHash=
 value
+ * @param   in: pointer to input data (read-only)
+ * @param   inle=
n: input data length in bytes (any size_t value)
+ * @param   k: pointer to=
 the key data (read-only), must be 16 bytes
+ * @param   out: pointer to ou=
tput data (write-only), outlen bytes must be allocated
+ * @param   outlen:=
 length of the output in bytes, must be 8
+ */
+int
+siphash_cryptolib(cons=
t void *in, const size_t inlen,
+                  const void *k, uint8_t *=
out, const size_t outlen)
+{
+    ASSERT(outlen =3D=3D sizeof(uint64_t));
+=
    uint64_t sipout =3D SIPHASH_24(k, in, inlen);
+
+    memcpy(out, &sipou=
t, sizeof(uint64_t));
+    return 0;
+}
+#endif
+
 static inline int
 sipha=
sh(const void *in, size_t inlen, const void *k,
         uint8_t *out, size=
_t outlen)
 {
+#if defined(USE_CRYPOTOLIB_SIPHASH)
+    return siphash_cryp=
tolib(in, inlen, k, out, outlen);
+#else
     return siphash_reference(in, =
inlen, k, out, outlen);
+#endif
 }
 
-#endif /* ifndef SIPHASH_H */
\ No ne=
wline at end of file
+#endif /* ifndef SIPHASH_H */

-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af=
6
Gerrit-Change-Number: 1572
Gerrit-PatchSet: 13
Gerrit-Owner: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
flichtenheld <frank@lichtenheld=2Ecom>

--2kP88cR2E28=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #13</strong> to this change=2E</p><p><a href=3D"http://g=
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
chwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/siphash=2Eh<br>1 =
file changed, 30 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/72/1572/13</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh</span=
><br><span>index bddddc3=2E=2E7ced09f 100644</span><br><span>--- a/src/open=
vpn/siphash=2Eh</span><br><span>+++ b/src/openvpn/siphash=2Eh</span><br><sp=
an>@@ -33,11 +33,40 @@</span><br><span>                   uint8_t *out, siz=
e_t outlen);</span><br><span> </span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(OPENSSL_IS_AWSLC)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define USE_CRYPOTOLIB_SIPHASH</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/siph=
ash=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  C=
omputes a SipHash value</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param   in: pointer to input data (read-only)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param   inlen: input data length in b=
ytes (any size_t value)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param   k: pointer to the key data (read-only), must be 16 bytes</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param   out: point=
er to output data (write-only), outlen bytes must be allocated</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param   outlen: length of th=
e output in bytes, must be 8</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib(const=
 void *in, const size_t inlen,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                  const void *k, uint8_t *out, const size_t outl=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(outlen =3D=3D sizeof(ui=
nt64_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64=
_t sipout =3D SIPHASH_24(k, in, inlen);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    memcpy(out, &amp;sipout, sizeof(uint64_t));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> static inline int</span><br><span> siphash(const void *in, size_t=
 inlen, const void *k,</span><br><span>         uint8_t *out, size_t outlen=
)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(USE_CRYPOTOLIB_SIPHASH)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return siphash_cryptolib(in, inlen, k, out, outlen);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span=
>     return siphash_reference(in, inlen, k, out, outlen);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifnd=
ef SIPHASH_H */</span><br><span>\ No newline at end of file</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef SIPHASH_H */</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1572?usp=3Demail">change 1572</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I05e20f8c82494e4abf96fe=
1e3a73e1c7b9101af6 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1572 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--2kP88cR2E28=--


--===============4608513236083910199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4608513236083910199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4608513236083910199==--

