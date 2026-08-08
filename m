Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305F9C55174
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 06:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dMf9P62sdr3leDd8qe6Bec1/xz05VD0OVjD63CEAHoE=; b=JB0Nr8PpE9ugpdtltbiTdbSjoz
	xsyldBwkfpAnw3sndNPEsgtQaNfKP/MolV93o3ZvaBzQYe/Ov/oEk4hIz2SWtDbcvpCaVLa/blO5c
	f/NLKSkZ6UwB0srGfxz80Rx5XqQ56K3o/UURNgRu9rHjCRtsop95KU5mhhWuA1r8MuCY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsb1B-0004ZR-LG;
	Sat, 08 Aug 2026 06:58:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsb19-0004ZG-8H
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 06:58:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ta3QWpovGbwVJ7EkkRqEXauLY3EOpexCV7lYyKU7ibg=; b=bPunscaxevQRfiiSS2Jc3a8Fn9
 xidsxiLc0hjYF7dbicgqrJCpjS8dhh7+EV8t9UidOG74el6dR0Ph7CcsNkdgV1yNXqnXeLa5k8KMK
 muwwYS0I8xi6cK9Q7Igfi+ZUhvpZS3MscqIIXwoZIt6WzzQIUj2jnjhBUwZEtatzY4Go=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ta3QWpovGbwVJ7EkkRqEXauLY3EOpexCV7lYyKU7ibg=; b=l
 ZdByK69qWc5jUaESseKUjr3LqUEPzsWaLyeopQOm0QpMMhFd2GtRjUjelHjlVYazbaGJRRp3l7V/x
 +LW/6GoFW8k7zqDKjMcZCIAm95IWKBbAnVCDK1pmdM5KyGASLh63jyxhR/OqmlGSkO8uIY7Rwmk2K
 ql+D6fhstPGMk0gI=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsb17-0008G4-HS for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 06:58:51 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4956869750eso1507935e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786172323; x=1786777123; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ta3QWpovGbwVJ7EkkRqEXauLY3EOpexCV7lYyKU7ibg=;
 b=Oo5h/qAJQ/zHy3RPeAjyLR6XoHCpTow0lPs+luFjxjX2LT4kU+2LMld2+u1F1nn6vX
 1HMsVJFtg5f2bdgOnBhhBS31E4fqw+oN/jz43DptW5un0/T9wSRYT2cRbKX3kT+EWpCp
 50PhEI2/DboLdmrXqvZCCg70rPci+Fs82/fZ2VLsoY0FY3UdXdgTbZ+dtioubteIEaha
 PXeIhsRHtR8S4C0BZA3/bUEUum+BVdo/fr9hPSWvMpceU3ZdHyX2CfwedaV2ttIyXjcq
 y08fcMpDW/GbiuGq7GXOdI0lYofWE4p7HFNigr6ZDqPslrQtvaLf/V9RJCW/w9M3m7DM
 4wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786172323; x=1786777123;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ta3QWpovGbwVJ7EkkRqEXauLY3EOpexCV7lYyKU7ibg=;
 b=nH2qryru8scDoH8Fzf3vjFOrimzmkNNudSRAtBHPE6HLqk1sVf1dfswcLGxZ/n05C8
 csSSvTwPalyHtkD3ihBSTMaSc0jeexQB/UEnRHdyhSFIW28oxrGeI5v9CCHLncBvtvCL
 X7p4nO+6IO3YKfiGyVb6pETsQhdxVgRE7fqr3/1qkx6E/zINSJ7TfquwicAVngjUci42
 3Xvgp/DWmj9Pf9mgOZGcqBn4GYlqg0Aa8RoeKudvPpf/TbFib9HndIFkbp/37LhOebtw
 wQnfNXvbl4Yy0VaiuCxJnVJTMHmeUCOhs63c2dXZKTyaCJYaLdb5Ze+h53BZbhnFLfWZ
 bkSg==
X-Gm-Message-State: AOJu0YxmGuyYeZWkbdcriZHpY2FVkYlDt29WnkO8Ys7NU1HD8Y+5vLP4
 X8iyGe0NNf818oXJTLags+4qCSLq7/Bhl1C1mk7+xyPFG5q24ZnioeUkHBdht1sD/YYWVUMEpRo
 vdGt1IMh46ZK+JX98zv9MYnWQWvhAB8oHFAWK4dk6UAijBRoPWNOWj3CJxfPQO5auGm2/
X-Gm-Gg: AR+sD11uX4+mGIgLUIVTvVTS1sA0EWWVG+zRHwobGKRFjJ+k1tlXv1QU0SrAtqJb5nL
 2qoozPaD3SD2hzMGCFTRcXX+LlgmtaRbXt3aErm70MZy/dkq5qbe2X8ac2kzRnepfIsHVK4taQS
 iVBchbMYu/wcRcfIsgv3Nw94bcy/fTBvjwNyIkmehnOKMx/SHMM9fpc8IEthGZuKoutC80tpQFc
 aq206Bc1N9A1jqbaZDEJM4g/8eyTQhQWDIawXUBv1axNaSNoWqYvSolde6j46/Sycz5Ot2tHpqz
 PwQQ7tOZvh6+8Bs4dviaI1n1H+0yptrtOkw3xJ9ssHhxmapXV1T0U33AzgVobppdhxJUw3HSa99
 20R6vruUYszPlEKncebf/YRE79QPNVM1Re7m8mNIocQiqlu3Co3apWt0B+QWIYZ4nXF6iuE2tUl
 wm54aHexZuYQILGKGYiBI0wRsD33fAMFSspuYozCD4hoD1UMSb2iBareCP2k/329RnTB6hzJsUp
 ce4QgCtOyEwjam4oojOnkeoLW07KMerHy5460FUUphNIGLUIZ1UHHLhI4H/gUpyaPPAVY5uBjiD
 Qe0Y2mcFE9ZajPCDyhtdo0dfA02WXUsrMOHwBDb3/qsHIVeQxiU=
X-Received: by 2002:a05:600c:4ba2:b0:493:b6ee:fcb7 with SMTP id
 5b1f17b1804b1-4994e7d3434mr246471895e9.14.1786172322065; 
 Fri, 07 Aug 2026 23:58:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f9182sm12696752f8f.28.2026.08.07.23.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 23:58:41 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 06:58:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: a194bb5633388956ecad9e0f2b57f1c2d5384065
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <126f5b090c9190bdcc2d47b98c62a5496d2de720-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsb17-0008G4-HS
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8566339464428396151=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8566339464428396151==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IeaFI7cmxY4="; charset=UTF-8

--IeaFI7cmxY4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#25) to the change originally created b=
y plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail=
 )

The following approvals got outdated and were removed:
Code-Review+2 by=
 flichtenheld


Change subject: Add aws-lc siphash implementation
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add aws-lc siphash imp=
lementation

AWS-LC has a siphash implementation that is just a simple func=
tion call
that also performs the same/better than the reference implementat=
ion that
it looks to be based on=2E AWS-lc variant seems to have come from =
boringssl
according to the Google copyright=2E

The return type of the siph=
ash related function has been also removed as
neither the reference nor the=
 aws-lc implementation can fail=2E Only the
OpenSSL based implementation ne=
eded a return type=2E

Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6=

Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1572
Message-Id: <20260806153251=2E66170-1-frank@lichtenheld=2Ecom=
>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38181=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/siphash=2Eh
M src/openvpn/siphash_reference=2Ec
2 files=
 changed, 43 insertions(+), 8 deletions(-)


  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/72/1572/25

diff --git a/src/openvpn/s=
iphash=2Eh b/src/openvpn/siphash=2Eh
index bddddc3=2E=2Eade7762 100644
--- =
a/src/openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -18,26 +18,63 @@=

 #ifndef SIPHASH_H
 #define SIPHASH_H
 
+#ifdef HAVE_CONFIG_H
+#include "c=
onfig=2Eh"
+#endif
+
 #include <stdint=2Eh>
 #include <stdio=2Eh>
 #include=
 <stdbool=2Eh>
 
+/* We need to include this to check for the OPENSSL_IS_AW=
SLC macro */
+#ifdef ENABLE_CRYPTO_OPENSSL
+#include <openssl/opensslv=2Eh>=

+#endif
+
 /* siphash always uses 128-bit keys */
 #define SIPHASH_KEY_SIZ=
E 16
 
 /**
  * Calculates SIPHASH using the reference implementation
  */
=
-int
+void
 siphash_reference(const void *in, size_t inlen, const void *k,
=
                   uint8_t *out, size_t outlen);
 
 
-static inline int
+#i=
f defined(OPENSSL_IS_AWSLC)
+#define USE_CRYPOTOLIB_SIPHASH
+#include <open=
ssl/siphash=2Eh>
+#include <string=2Eh>
+#include "error=2Eh"
+/**
+ *  Com=
putes a SipHash value
+ * @param   in      pointer to input data (read-only=
)
+ * @param   inlen   input data length in bytes (any size_t value)
+ * @p=
aram   k       pointer to the key data (read-only), must be 16 bytes
+ * @p=
aram   out     pointer to output data (write-only), outlen bytes must be al=
located
+ * @param   outlen  length of the output in bytes, must be 8
+ */
=
+static inline void
+siphash_cryptolib(const void *in, const size_t inlen,
=
+                  const void *k, uint8_t *out, const size_t outlen)
+{
+  =
  ASSERT(outlen =3D=3D sizeof(uint64_t));
+    uint64_t sipout =3D SIPHASH_=
24(k, in, inlen);
+
+    memcpy(out, &sipout, sizeof(uint64_t));
+}
+#endif=

+
+static inline void
 siphash(const void *in, size_t inlen, const void *k=
,
         uint8_t *out, size_t outlen)
 {
-    return siphash_reference(in=
, inlen, k, out, outlen);
+#if defined(USE_CRYPOTOLIB_SIPHASH)
+    siphash=
_cryptolib(in, inlen, k, out, outlen);
+#else
+    siphash_reference(in, in=
len, k, out, outlen);
+#endif
 }
 
-#endif /* ifndef SIPHASH_H */
\ No newl=
ine at end of file
+#endif /* ifndef SIPHASH_H */
diff --git a/src/openvpn/=
siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec
index ad19a51=2E=
=2E5f0adb9 100644
--- a/src/openvpn/siphash_reference=2Ec
+++ b/src/openvpn=
/siphash_reference=2Ec
@@ -99,7 +99,7 @@
  * out: pointer to output data (w=
rite-only), outlen bytes must be allocated
  *  outlen: length of the outpu=
t in bytes, must be 8 or 16
  */
-int
+void
 siphash_reference(const void *=
in, const size_t inlen, const void *k, uint8_t *out,
                   con=
st size_t outlen)
 {
@@ -206,7 +206,7 @@
 
     if (outlen =3D=3D 8)
     {=

-        return 0;
+        return;
     }
 
     v1 ^=3D 0xdd;
@@ -219,6 =
+219,4 @@
 
     b =3D v0 ^ v1 ^ v2 ^ v3;
     U64TO8_LE(out + 8, b);
-
-  =
  return 0;
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1572?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0=
5e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Gerrit-Change-Number: 1572
Gerrit-P=
atchSet: 25
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--IeaFI7cmxY4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #25</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Add aws-lc siphash i=
mplementation<br><br>AWS-LC has a siphash implementation that is just a sim=
ple function call<br>that also performs the same/better than the reference =
implementation that<br>it looks to be based on=2E AWS-lc variant seems to h=
ave come from boringssl<br>according to the Google copyright=2E<br><br>The =
return type of the siphash related function has been also removed as<br>nei=
ther the reference nor the aws-lc implementation can fail=2E Only the<br>Op=
enSSL based implementation needed a return type=2E<br><br>Change-Id: I05e20=
f8c82494e4abf96fe1e3a73e1c7b9101af6<br>Signed-off-by: Arne Schwabe &lt;arne=
@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572<br>Me=
ssage-Id: &lt;20260806153251=2E66170-1-frank@lichtenheld=2Ecom&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g38181=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M src/openvpn/siphash=2Eh<br>M src/openvpn/siphash_reference=2E=
c<br>2 files changed, 43 insertions(+), 8 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/72/=
1572/25</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=
=2Eh</span><br><span>index bddddc3=2E=2Eade7762 100644</span><br><span>--- =
a/src/openvpn/siphash=2Eh</span><br><span>+++ b/src/openvpn/siphash=2Eh</sp=
an><br><span>@@ -18,26 +18,63 @@</span><br><span> #ifndef SIPHASH_H</span><=
br><span> #define SIPHASH_H</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> #include &lt;stdint=2Eh&gt;</sp=
an><br><span> #include &lt;stdio=2Eh&gt;</span><br><span> #include &lt;stdb=
ool=2Eh&gt;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* We need to include this to check for the OPENSSL_IS_AWSLC macr=
o */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_C=
RYPTO_OPENSSL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &lt;openssl/opensslv=2Eh&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /* siphash always uses 128-bit keys */</span><br><span> #d=
efine SIPHASH_KEY_SIZE 16</span><br><span> </span><br><span> /**</span><br>=
<span>  * Calculates SIPHASH using the reference implementation</span><br><=
span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> siphas=
h_reference(const void *in, size_t inlen, const void *k,</span><br><span>  =
                 uint8_t *out, size_t outlen);</span><br><span> </span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline =
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(OPEN=
SSL_IS_AWSLC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e USE_CRYPOTOLIB_SIPHASH</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;openssl/siphash=2Eh&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  Computes a SipHash value</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param   in      pointer to input data=
 (read-only)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am   inlen   input data length in bytes (any size_t value)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param   k       pointer to the k=
ey data (read-only), must be 16 bytes</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param   out     pointer to output data (write-only), =
outlen bytes must be allocated</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param   outlen  length of the output in bytes, must be 8</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib(const void *in, const =
size_t inlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
            const void *k, uint8_t *out, const size_t outlen)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ASSERT(outlen =3D=3D sizeof(uint64_t));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t sipout =3D SIP=
HASH_24(k, in, inlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(out, =
&amp;sipout, sizeof(uint64_t));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><span> si=
phash(const void *in, size_t inlen, const void *k,</span><br><span>        =
 uint8_t *out, size_t outlen)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return siphash_reference(in, inlen, k, out, =
outlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(USE_CRYPOTOLIB_SIPHASH)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    siphash_cryptolib(in, inlen, k, out, outlen);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    siphash_reference(in, inlen, k, out, outlen);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif /* ifndef SIPHASH_H */</span><br><span>\ No newline at end of file</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef SIPHAS=
H_H */</span><br><span>diff --git a/src/openvpn/siphash_reference=2Ec b/src=
/openvpn/siphash_reference=2Ec</span><br><span>index ad19a51=2E=2E5f0adb9 1=
00644</span><br><span>--- a/src/openvpn/siphash_reference=2Ec</span><br><sp=
an>+++ b/src/openvpn/siphash_reference=2Ec</span><br><span>@@ -99,7 +99,7 @=
@</span><br><span>  * out: pointer to output data (write-only), outlen byte=
s must be allocated</span><br><span>  *  outlen: length of the output in by=
tes, must be 8 or 16</span><br><span>  */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span> siphash_reference(const void *in, const size_t in=
len, const void *k, uint8_t *out,</span><br><span>                   const =
size_t outlen)</span><br><span> {</span><br><span>@@ -206,7 +206,7 @@</span=
><br><span> </span><br><span>     if (outlen =3D=3D 8)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span=
><br><span>     }</span><br><span> </span><br><span>     v1 ^=3D 0xdd;</spa=
n><br><span>@@ -219,6 +219,4 @@</span><br><span> </span><br><span>     b =
=3D v0 ^ v1 ^ v2 ^ v3;</span><br><span>     U64TO8_LE(out + 8, b);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return 0;</span><br><span> }</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1572?usp=3Demail">change 1572</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1572?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9=
101af6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1572 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 25 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--IeaFI7cmxY4=--


--===============8566339464428396151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8566339464428396151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8566339464428396151==--

