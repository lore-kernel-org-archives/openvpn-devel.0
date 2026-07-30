Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA9CC55165
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GETgv/jDkDgd76rbvI8NObUNJWYQSUFgp9pJf6bb7pc=; b=hl0q5sAtqU8hwEFGyyvjklofjJ
	WGhlXx+LOEmCamNc3X9VPwbB4+5JrB6vgh2A5MeWXUfiKIgNiu4kxEo4Mdu6dbLPLRpn/pzGsfN36
	tLXRd6KMfk0AGPUC1RuQ7fc88eAoDW1RnQUVyhq/yJBxf1nuqtlKXd9G5i0YDgbacLJQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpPbo-0001hc-V5;
	Thu, 30 Jul 2026 12:11:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpPbn-0001hW-Ok
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:11:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qRMLXx/uBsf5rMU2PdTFiFJt+Rr5j0YXCv4dvtvZc4Y=; b=YPr85mppblYjAFNtsa0uJDeJb8
 04YytCIiXDdqHzU1h+EMgPcEkfLwSJ/jz6ozOHYGLzM9f6TPj0+5PiaPkmO2X5kw7QJ3m65jzv5fE
 v/8UaYZubVbtm9+4QitNEdQeGwQbgQ4tfH+Jyi7x8wOIIQe3zpa2QRvHG+czHuEDyY+4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qRMLXx/uBsf5rMU2PdTFiFJt+Rr5j0YXCv4dvtvZc4Y=; b=S
 mW6AMggJxIzOS8DojVqP0m9MPYWaxFA29hVDETpl3EZFqtJ296M9bi9d9JyKn7HZ8NlbMG3yeczwG
 UnMDlnA2lX9JdVooDLbCj+9v0deg9UW+YQ2MUjg5V9LMiFVXLMMDe9HcPlcq3YpUJOSB40cCyw9Ol
 6FLFEqFcX93xSQQ4=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpPbo-0006aB-GE for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:11:31 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso14521165e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785413482; x=1786018282; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qRMLXx/uBsf5rMU2PdTFiFJt+Rr5j0YXCv4dvtvZc4Y=;
 b=a2zZYL0tXaFIwElnuUOaLV6zYEQ1voqUZXmJXq4xqTLi4CqNiAHOv+potsK6ur3tq0
 reA7lidL3yG2FU1YolhUYxDuIJaX+LwgTbx1RoLMjXxkn65hGvtYKNlGV77kJ+/nINzU
 PZp9MtfuySULZ1jhfORfBi6DL/Y9cu5lrOogqDnjyPhFsaj7F6dGh53Iqb1DfQgqmfkV
 AVEKB1mJzxDsqFsACv4f130IygglW15mkn9q+s/cEgNh6FJKCh1Zhe9KS1Sgg0U/j9UE
 nKR1JuusCbIJzUEXydr0JKBh7royjN7jjM2pc+6NULZlw3tHNHSNHztldhurl4toM6DP
 tFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785413482; x=1786018282;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qRMLXx/uBsf5rMU2PdTFiFJt+Rr5j0YXCv4dvtvZc4Y=;
 b=GsYIaUK7PH7nwTtDnwR1pmT03MdQ6JVsYlGpCuzZsBZLe+EpTYw5skuw0K8rnGhYiG
 hkYbSEyZsE0Q1e28X1HzDoq4vKVpxEtJ3QdDzvd+RCKigPBbBSg4LEN72VorL4cr5F+d
 ycU6g4xuYuoRlHnZFxuB1KE9ySlVvbP13sqZYbYoa51WwErWWcLCvup9dCaWXbYZlXaH
 gnKNB13WfjwFOYNRyBJI3w22twPJl1FryMuZHfbDAtUWrGf9P+LAYHmjru6BHJeCOkpt
 ozUq9z1fhIj3PLycJUjGt7gVSa+8QZ6zb5Wx1j0au2teMGZMifWCbCf2YImNE8/BaCLq
 Mt6w==
X-Gm-Message-State: AOJu0YxgEoOLAdT3dG7zi7IVGF8+GMLcGT/DWRVvCqJ4/2AhRHztqEjC
 Xf3cbwYyPPHM5sJ1MlKl5ItemWw22HgdWQfMjnJdTJBifIDSu4JDp/05ULLHlf+7+UBOEwOZJjL
 RWs2Hjoxx0FqF0msfdBSfz9xibK2HYmKGiYsqpWoHUxaggmC4GyiH+PfkoAVJhd9IvhvSU6Ex/h
 bgk0oGzA==
X-Gm-Gg: AR+sD13COpcq/m1lCsGarZ5YvUr++ZESg7vz+unnlERNYWCoJkKogWW1XsBNk9L+9M5
 +qMWzzUQJ75GTsxom3lK/H/Gsrz/tFipV/HVdEKJQFPCRCKuJNwEYpRbcEedyijIoJRvfFhlMMG
 IxGJRleYZH+z4vad1HQJdawOIkC4NnYYMQtKs70SEssFTOpCs/xfjkMPXou4e0LTN6ROtJ/A7ZA
 JA7Y2QpatYFbZ4rn+1qApSXFqSIFgwD6hapjWvb6UwY6CnYTQ6j1DMTFgSW51O/RVT7dZYeX1ma
 kZ/3PYqqUIjgifzXGwTVIxNORZTjlzadKHD7arngvglF/pgtq4rgIelVVrL0cnX00BTT7SkKZ5/
 8hHEDygjawjWX1py2X7cWRfYan+PpStQVJWOXDszBTkpWXhhv1NDgPPRAKc9Yc8RBytlrJ/DvAC
 7ypuvOxPmrlN+buTdHkKmGbw0085Gx7zn+1QlovC6sGEWrn5IDLVVpzaUhhsk+LqhGxsq+cN16m
 NvnJSOlZSzYqY/BYWC01xwbfqneGA2FL6VNi4I0sjMEsWVRbD9BxRP8oCv0NrRxOuLssII6ZKQ8
 9N9eidYfoALgvQrSNiGviMQePR0fUxXCoYfFAcXumSIPOFTr4ik=
X-Received: by 2002:a05:600c:6298:b0:495:7990:a1d0 with SMTP id
 5b1f17b1804b1-49800ea0feemr31644715e9.19.1785413482112; 
 Thu, 30 Jul 2026 05:11:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011f341fsm46626065e9.5.2026.07.30.05.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:11:20 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 12:11:18 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: 57b231726eea6ea2ab9a539faa4010abc6b697fb
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <00b4373ccfdd4ef728a49e2d80663959f3e80c89-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpPbo-0006aB-GE
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add aws-lc siphash
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
Content-Type: multipart/mixed; boundary="===============2271156238221633128=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2271156238221633128==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nN1E11M24zE="; charset=UTF-8

--nN1E11M24zE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1572?usp=3Demail

to look at the new patch set (#2=
3)=2E


Change subject: Add aws-lc siphash implementation
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add aws-lc siphash implement=
ation

AWS-LC has a siphash implementation that is just a simple function c=
all
that also performs the same/better than the reference implementation th=
at
it looks to be based on=2E AWS-lc variant seems to have come from boring=
ssl
according to the Google copyright=2E

The return type of the siphash re=
lated function has been also removed as
neither the reference nor the aws-l=
c implementation can fail=2E Only the
OpenSSL based implementation needed a=
 return type=2E

Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Signe=
d-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/siphash=2Eh
M=
 src/openvpn/siphash_reference=2Ec
2 files changed, 43 insertions(+), 8 del=
etions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/72/1572/23

diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=
=2Eh
index bddddc3=2E=2Eade7762 100644
--- a/src/openvpn/siphash=2Eh
+++ b/=
src/openvpn/siphash=2Eh
@@ -18,26 +18,63 @@
 #ifndef SIPHASH_H
 #define SIP=
HASH_H
 
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
 #include <=
stdint=2Eh>
 #include <stdio=2Eh>
 #include <stdbool=2Eh>
 
+/* We need to =
include this to check for the OPENSSL_IS_AWSLC macro */
+#ifdef ENABLE_CRYP=
TO_OPENSSL
+#include <openssl/opensslv=2Eh>
+#endif
+
 /* siphash always us=
es 128-bit keys */
 #define SIPHASH_KEY_SIZE 16
 
 /**
  * Calculates SIPHA=
SH using the reference implementation
  */
-int
+void
 siphash_reference(co=
nst void *in, size_t inlen, const void *k,
                   uint8_t *out,=
 size_t outlen);
 
 
-static inline int
+#if defined(OPENSSL_IS_AWSLC)
+#de=
fine USE_CRYPOTOLIB_SIPHASH
+#include <openssl/siphash=2Eh>
+#include <stri=
ng=2Eh>
+#include "error=2Eh"
+/**
+ *  Computes a SipHash value
+ * @param=
   in      pointer to input data (read-only)
+ * @param   inlen   input dat=
a length in bytes (any size_t value)
+ * @param   k       pointer to the ke=
y data (read-only), must be 16 bytes
+ * @param   out     pointer to output=
 data (write-only), outlen bytes must be allocated
+ * @param   outlen  len=
gth of the output in bytes, must be 8
+ */
+static inline void
+siphash_cry=
ptolib(const void *in, const size_t inlen,
+                  const void *k=
, uint8_t *out, const size_t outlen)
+{
+    ASSERT(outlen =3D=3D sizeof(ui=
nt64_t));
+    uint64_t sipout =3D SIPHASH_24(k, in, inlen);
+
+    memcpy(=
out, &sipout, sizeof(uint64_t));
+}
+#endif
+
+static inline void
 siphash(=
const void *in, size_t inlen, const void *k,
         uint8_t *out, size_t =
outlen)
 {
-    return siphash_reference(in, inlen, k, out, outlen);
+#if d=
efined(USE_CRYPOTOLIB_SIPHASH)
+    siphash_cryptolib(in, inlen, k, out, ou=
tlen);
+#else
+    siphash_reference(in, inlen, k, out, outlen);
+#endif
 }=

 
-#endif /* ifndef SIPHASH_H */
\ No newline at end of file
+#endif /* if=
ndef SIPHASH_H */
diff --git a/src/openvpn/siphash_reference=2Ec b/src/open=
vpn/siphash_reference=2Ec
index ad19a51=2E=2E5f0adb9 100644
--- a/src/openv=
pn/siphash_reference=2Ec
+++ b/src/openvpn/siphash_reference=2Ec
@@ -99,7 +=
99,7 @@
  * out: pointer to output data (write-only), outlen bytes must be =
allocated
  *  outlen: length of the output in bytes, must be 8 or 16
  */
=
-int
+void
 siphash_reference(const void *in, const size_t inlen, const voi=
d *k, uint8_t *out,
                   const size_t outlen)
 {
@@ -206,7 +2=
06,7 @@
 
     if (outlen =3D=3D 8)
     {
-        return 0;
+        retu=
rn;
     }
 
     v1 ^=3D 0xdd;
@@ -219,6 +219,4 @@
 
     b =3D v0 ^ v1 ^ =
v2 ^ v3;
     U64TO8_LE(out + 8, b);
-
-    return 0;
 }

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9=
101af6
Gerrit-Change-Number: 1572
Gerrit-PatchSet: 23
Gerrit-Owner: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--nN1E11M24zE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #23</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1572?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">A=
dd aws-lc siphash implementation<br><br>AWS-LC has a siphash implementation=
 that is just a simple function call<br>that also performs the same/better =
than the reference implementation that<br>it looks to be based on=2E AWS-lc=
 variant seems to have come from boringssl<br>according to the Google copyr=
ight=2E<br><br>The return type of the siphash related function has been als=
o removed as<br>neither the reference nor the aws-lc implementation can fai=
l=2E Only the<br>OpenSSL based implementation needed a return type=2E<br><b=
r>Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/siphash=2Eh<b=
r>M src/openvpn/siphash_reference=2Ec<br>2 files changed, 43 insertions(+),=
 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/72/1572/23</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index bddddc3=2E=
=2Eade7762 100644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><br><=
span>+++ b/src/openvpn/siphash=2Eh</span><br><span>@@ -18,26 +18,63 @@</spa=
n><br><span> #ifndef SIPHASH_H</span><br><span> #define SIPHASH_H</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE=
_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> #include &lt;stdint=2Eh&gt;</span><br><span> #include &lt;stdio=2Eh&=
gt;</span><br><span> #include &lt;stdbool=2Eh&gt;</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* We need to include this =
to check for the OPENSSL_IS_AWSLC macro */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTO_OPENSSL</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/opensslv=2Eh&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* siphash always =
uses 128-bit keys */</span><br><span> #define SIPHASH_KEY_SIZE 16</span><br=
><span> </span><br><span> /**</span><br><span>  * Calculates SIPHASH using =
the reference implementation</span><br><span>  */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void</span><br><span> siphash_reference(const void *in, size_t =
inlen, const void *k,</span><br><span>                   uint8_t *out, size=
_t outlen);</span><br><span> </span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(OPENSSL_IS_AWSLC)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define USE_CRYPOTOLIB_SIPHASH</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/siphash=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Comp=
utes a SipHash value</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param   in      pointer to input data (read-only)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param   inlen   input data length in=
 bytes (any size_t value)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param   k       pointer to the key data (read-only), must be 16 b=
ytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param   out=
     pointer to output data (write-only), outlen bytes must be allocated</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param   outlen  le=
ngth of the output in bytes, must be 8</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static inline void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+siphash_cryptolib(const void *in, const size_t inlen,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                  const void *k, uint8_=
t *out, const size_t outlen)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSER=
T(outlen =3D=3D sizeof(uint64_t));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint64_t sipout =3D SIPHASH_24(k, in, inlen);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    memcpy(out, &amp;sipout, sizeof(uint64_t));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static inline void</span><br><span> siphash(const void *in, size_t inle=
n, const void *k,</span><br><span>         uint8_t *out, size_t outlen)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn siphash_reference(in, inlen, k, out, outlen);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(USE_CRYPOTOLIB_SIPHASH)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    siphash_cryptolib(in, in=
len, k, out, outlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siphash_=
reference(in, inlen, k, out, outlen);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef SIPHASH_H */</span=
><br><span>\ No newline at end of file</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif /* ifndef SIPHASH_H */</span><br><span>diff --git=
 a/src/openvpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec</s=
pan><br><span>index ad19a51=2E=2E5f0adb9 100644</span><br><span>--- a/src/o=
penvpn/siphash_reference=2Ec</span><br><span>+++ b/src/openvpn/siphash_refe=
rence=2Ec</span><br><span>@@ -99,7 +99,7 @@</span><br><span>  * out: pointe=
r to output data (write-only), outlen bytes must be allocated</span><br><sp=
an>  *  outlen: length of the output in bytes, must be 8 or 16</span><br><s=
pan>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> siphash=
_reference(const void *in, const size_t inlen, const void *k, uint8_t *out,=
</span><br><span>                   const size_t outlen)</span><br><span> {=
</span><br><span>@@ -206,7 +206,7 @@</span><br><span> </span><br><span>    =
 if (outlen =3D=3D 8)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return;</span><br><span>     }</span><br><span=
> </span><br><span>     v1 ^=3D 0xdd;</span><br><span>@@ -219,6 +219,4 @@</=
span><br><span> </span><br><span>     b =3D v0 ^ v1 ^ v2 ^ v3;</span><br><s=
pan>     U64TO8_LE(out + 8, b);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
0;</span><br><span> }</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail">change=
 1572</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1572 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 23 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--nN1E11M24zE=--


--===============2271156238221633128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2271156238221633128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2271156238221633128==--

