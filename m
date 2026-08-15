Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0BBC5DF67
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gzSPO6zN8CnR+Zld8ZnpVzaPQFD7kTt2rJcfkEgiN9c=; b=BDdy8KKCbrtH9xu4q5UzV/f66Q
	gQPoxemVQma1hKomfF5AJxvidCgxYe2nXWUDpFHUA+SCmwPlb2iU+9av4otpeJApua/AgbiEzWl0H
	wp093ChkCUvJ8ijhvsaCRsDMmfNBLJ/6gcNHeVytDTEzY2/wZGXKPtMhoi325BIf3iSM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvKlQ-0005o0-Hl;
	Sat, 15 Aug 2026 20:13:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvKlP-0005nt-OZ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 20:13:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ONhnC+K0fYr2bJxx9p+ngDW0LQqsZ8N3w9LYrjcKZv0=; b=iY5SFj3++KDkL7qRMjxZ0NZ75j
 vTXe5bjjWK1fmbOV7JLEYoF4kOF/s+cNR9omUhMC8gDk+SQH0Tni7xmofr2i/1rzYfalr4Trn6oBW
 zRh7gMZ9c761UCtBsKdEON8+fmO4Qo8bJwB4v+w+YuRgEFaC9gZ1GE4OA/HIU0G7nFws=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ONhnC+K0fYr2bJxx9p+ngDW0LQqsZ8N3w9LYrjcKZv0=; b=l
 Nr1gniiT4kabatcl6RGiQE5iZaiuYCVY7b2IQqZundspZ0fE70EBUschEG+11UJSzDkWopffBUkRh
 dEFjXCDbK2rbZZ9fKZxt6TYmQPm8CQ70WulRKp7MpZYCIbccnw+wwQvgFVf0c/wmzQ8u3IEveH0S2
 gDLoUrHEjgrmgs8s=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvKlS-0003Ij-5O for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 20:13:55 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so23013515e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 15 Aug 2026 13:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786824828; x=1787429628; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ONhnC+K0fYr2bJxx9p+ngDW0LQqsZ8N3w9LYrjcKZv0=;
 b=dOAzcF45u7KGNwM5I9eT5W4FtkiimlcX+lzGOetx6a02o/GeW/TBrPKLeNOwy1Y8cM
 xiOg8ofkQkDFhmatf/XvfRUp8cOjmtWGe6QyW5AUvxTD81q/Z/8LmY/w0D+RDZoWLYrU
 LvX+elX0fDaih/vEmrJ0d6XPCsGbVGUrd05ZEC2jSffLlZbLjk0bVHCaP11sllrwoy7q
 4YdUvJPNw2cksO4X/7K52sqbNDS8j6OWSXAbh8yYhyp6L6z2SyrhYSvho2SHEWKunGh4
 qxtlX8hw/s1jILFHuMA3TIf2CJOQQouTF8ydr8zOLOQd9acbQKVRqdcfeHOo7kRDLFl4
 Tgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786824828; x=1787429628;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ONhnC+K0fYr2bJxx9p+ngDW0LQqsZ8N3w9LYrjcKZv0=;
 b=p0YaCdL/e9nVoyeF+PNXoF+ookNFSRh6oy4KHhfG78ajy6F9ucTh3KvF1PeAQ68AYb
 Q0ujUyXwBF9e9IAojnvM4IeugjavgPMzCUng8Efww6OxBoB+YcQmri28eYI5+fpFrmge
 ZX1PNHUEDfmpRh+rDH/msHa22Nvkig5fHPyyDQzu12X3s9hsZkE+XuWIfd8H+WNpR+vs
 C9Os8FabbCo4eMQFQ9R2PfAm8Hc8xk8grJe2RKmidQ+X8YpzLdnW4XTrwusUfgUrn2Do
 pv76OymrIMQSJ2GUNLAG4+cfTM6jAzVa0iQQPeSkUsT2TNwSw9SX5t6h5h9ROfnQ6RNZ
 /Hcg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7Dnw0uS1xHQFNHl0gbfit6pBZCS3tynshWrAMhUQJ1laIfIXa63WcTvXuqw8qOLaPJkadkrqW4JbUSKSE@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw3LMIm+miShkCPKoIk1JCZIRbSkF4k9skFEEvSnZqP0+q53vop
 iaFSHkzfMN6kAXeM88PVsFL8DI8624w2ToHUwQ4LnUHe68qXnvrW0ck9//0YkKqNZNX0gUvKXGF
 MAs6jj2snGhvReUQCbprhdq5D1gPwvw6x0E6hrWP++rc4mF42t6//ZYd4CrUEflShs+p6
X-Gm-Gg: AR+sD100VQ0wAa7+0mNhuYIpuaAAKlneMTj5OxtneIWCWyfsL9/m7tsr8+M7NLHZOeM
 GsKjr+iprpg6GEh88M2StRLfT6AEjBHWQ0Dr4La5sOub0F/Vij42R9Rtibrmdd8T10I8m7Jy164
 atIxluAJmt2p77ph4hatEamFMC8OfbdLPe04eoaAHYqJeApf4jb3bkrcZZy2qwzGS6qPSAry0oe
 fFU8A5C9wSgs14Jzy6bH/O4iwnfqMyxnXmdnjEz6iat0NU6K4YW1e53Bd4XyLjPXdVYZp/XP/sP
 tCMfCmSAuMxjMmaOVojJ1++g1rqDzAGQI4Agx7yQ289yFoahK8uoLbe5Opgz+acxa5Kslibuuud
 O9hTnQFvuerUbbYCVWbQPoXkeqctKbbhJCZxcWMnosgCBh5bk3xVyOadfgC9W1IxXoTkd30dsnk
 1/q8CG7yN8tlzojc207v3kvsJ9Ef6lAS15N5BS90dhScJaIoYkenFDPNPHk6GD7QP83nFTc60MD
 w7gT1WV82/wm/T4HFNGpbyKaRB2G5mgDNx7Qiv+0g9BK7qXEP4tnL6x9vCTzze0KDc1W3Hg4Pym
 LNWT9HzWrG5EDluKlQw0qzPiZyADB2pXQxsVd4Ny3h/8tHNZNGM=
X-Received: by 2002:a05:600c:848d:b0:499:48bb:417e with SMTP id
 5b1f17b1804b1-4998933fd6emr197996285e9.2.1786824828039; 
 Sat, 15 Aug 2026 13:13:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49989af26eesm151680545e9.15.2026.08.15.13.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:13:47 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 15 Aug 2026 20:13:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b
X-Gerrit-Change-Number: 1757
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1757?usp=email>
X-Gerrit-Commit: 4acebd72c1c6bc0a4a2ee2b4288c18214fead278
In-Reply-To: <gerrit.1782744874000.I08281cb511dacb2a69ff4a9607c5daf09157337b@gerrit.openvpn.net>
References: <gerrit.1782744874000.I08281cb511dacb2a69ff4a9607c5daf09157337b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQ0ODc0MDAwLkkwODI4MWNiNTExZGFjYjJhNjlmZjRhOTYwN2M1ZGFmMDkxNTczMzdiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e165a2899e3e8dc098647cab66d05c28a35fa14a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvKlS-0003Ij-5O
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix compiling with
 mbed TLS 3 and cmake
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
Content-Type: multipart/mixed; boundary="===============7773060894527398445=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7773060894527398445==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rhhGd4x0YAA="; charset=UTF-8

--rhhGd4x0YAA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1757?usp=3Demail )

Change subject: Fix compiling with mbed TLS 3 and c=
make
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix com=
piling with mbed TLS 3 and cmake

The crypto_mbedtls_legacy=2Ec has been ad=
ded to the Makefile=2Eam files
but was forgotten in the Cmake build system=
=2E

Change-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1757
Mess=
age-Id: <20260815130008=2E19708-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38406=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=
=2Etxt
1 file changed, 9 insertions(+), 0 deletions(-)




diff --git a/CMa=
keLists=2Etxt b/CMakeLists=2Etxt
index ad7de6e=2E=2Eaae264e 100644
--- a/CM=
akeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -452,6 +452,8 @@
     src/openvpn/=
crypto_openssl=2Eh
     src/openvpn/crypto_mbedtls=2Ec
     src/openvpn/cry=
pto_mbedtls=2Eh
+    src/openvpn/crypto_mbedtls_legacy=2Ec
+    src/openvpn=
/crypto_mbedtls_legacy=2Eh
     src/openvpn/cryptoapi=2Ec
     src/openvpn/=
cryptoapi=2Eh
     src/openvpn/dco=2Ec
@@ -774,6 +776,7 @@
         src/ope=
nvpn/base64=2Ec
         src/openvpn/crypto_epoch=2Ec
         src/openvpn/=
crypto_mbedtls=2Ec
+        src/openvpn/crypto_mbedtls_legacy=2Ec
         =
src/openvpn/crypto_openssl=2Ec
         src/openvpn/crypto=2Ec
         src=
/openvpn/otime=2Ec
@@ -787,6 +790,7 @@
     target_sources(test_crypto PRIV=
ATE
         tests/unit_tests/openvpn/siphash_openssl=2Ec
         src/open=
vpn/crypto_mbedtls=2Ec
+        src/openvpn/crypto_mbedtls_legacy=2Ec
     =
    src/openvpn/crypto_openssl=2Ec
         src/openvpn/crypto_epoch=2Ec
  =
       src/openvpn/crypto=2Ec
@@ -805,6 +809,7 @@
             src/openvpn/=
base64=2Ec
             src/openvpn/crypto_epoch=2Ec
             src/openv=
pn/crypto_mbedtls=2Ec
+            src/openvpn/crypto_mbedtls_legacy=2Ec
  =
           src/openvpn/crypto_openssl=2Ec
             src/openvpn/crypto=
=2Ec
             src/openvpn/cryptoapi=2Ec
@@ -843,6 +848,7 @@
     target=
_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch=2Ec
         sr=
c/openvpn/crypto_mbedtls=2Ec
+        src/openvpn/crypto_mbedtls_legacy=2Ec=

         src/openvpn/crypto_openssl=2Ec
         src/openvpn/crypto=2Ec
  =
       src/openvpn/otime=2Ec
@@ -871,6 +877,7 @@
         src/openvpn/base6=
4=2Ec
         src/openvpn/crypto_epoch=2Ec
         src/openvpn/crypto_mbe=
dtls=2Ec
+        src/openvpn/crypto_mbedtls_legacy=2Ec
         src/openvp=
n/crypto_openssl=2Ec
         src/openvpn/crypto=2Ec
         src/openvpn/e=
nv_set=2Ec
@@ -947,6 +954,7 @@
             src/openvpn/networking_sitnl=2E=
c
             src/openvpn/crypto_epoch=2Ec
             src/openvpn/crypto=
_mbedtls=2Ec
+            src/openvpn/crypto_mbedtls_legacy=2Ec
           =
  src/openvpn/crypto_openssl=2Ec
             src/openvpn/crypto=2Ec
      =
       src/openvpn/crypto_epoch=2Ec
@@ -968,6 +976,7 @@
             src/op=
envpn/base64=2Ec
             src/openvpn/crypto_epoch=2Ec
             src=
/openvpn/crypto_mbedtls=2Ec
+            src/openvpn/crypto_mbedtls_legacy=
=2Ec
             src/openvpn/crypto_openssl=2Ec
             src/openvpn/c=
rypto=2Ec
             src/openvpn/env_set=2Ec

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1757?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b
Gerrit-=
Change-Number: 1757
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--rhhGd4x0YAA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1757?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Fix compiling with mbed TLS 3 and cmake<br=
><br>The crypto_mbedtls_legacy=2Ec has been added to the Makefile=2Eam file=
s<br>but was forgotten in the Cmake build system=2E<br><br>Change-Id: I0828=
1cb511dacb2a69ff4a9607c5daf09157337b<br>Signed-off-by: Arne Schwabe &lt;arn=
e@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1757<br>M=
essage-Id: &lt;20260815130008=2E19708-1-gert@greenie=2Emuc=2Ede&gt;<br>URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg38406=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M CMakeLists=2Etxt<br>1 file changed, 9 insertions(+), 0 delet=
ions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</=
span><br><span>index ad7de6e=2E=2Eaae264e 100644</span><br><span>--- a/CMak=
eLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -452=
,6 +452,8 @@</span><br><span>     src/openvpn/crypto_openssl=2Eh</span><br>=
<span>     src/openvpn/crypto_mbedtls=2Ec</span><br><span>     src/openvpn/=
crypto_mbedtls=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    src/openvpn/crypto_mbedtls_legacy=2Eh</span><br><s=
pan>     src/openvpn/cryptoapi=2Ec</span><br><span>     src/openvpn/cryptoa=
pi=2Eh</span><br><span>     src/openvpn/dco=2Ec</span><br><span>@@ -774,6 +=
776,7 @@</span><br><span>         src/openvpn/base64=2Ec</span><br><span>  =
       src/openvpn/crypto_epoch=2Ec</span><br><span>         src/openvpn/cr=
ypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>         src/ope=
nvpn/crypto_openssl=2Ec</span><br><span>         src/openvpn/crypto=2Ec</sp=
an><br><span>         src/openvpn/otime=2Ec</span><br><span>@@ -787,6 +790,=
7 @@</span><br><span>     target_sources(test_crypto PRIVATE</span><br><spa=
n>         tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>   =
      src/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><s=
pan>         src/openvpn/crypto_openssl=2Ec</span><br><span>         src/op=
envpn/crypto_epoch=2Ec</span><br><span>         src/openvpn/crypto=2Ec</spa=
n><br><span>@@ -805,6 +809,7 @@</span><br><span>             src/openvpn/ba=
se64=2Ec</span><br><span>             src/openvpn/crypto_epoch=2Ec</span><b=
r><span>             src/openvpn/crypto_mbedtls=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/crypto_mbedtls_le=
gacy=2Ec</span><br><span>             src/openvpn/crypto_openssl=2Ec</span>=
<br><span>             src/openvpn/crypto=2Ec</span><br><span>             =
src/openvpn/cryptoapi=2Ec</span><br><span>@@ -843,6 +848,7 @@</span><br><sp=
an>     target_sources(test_ncp PRIVATE</span><br><span>         src/openvp=
n/crypto_epoch=2Ec</span><br><span>         src/openvpn/crypto_mbedtls=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/=
crypto_mbedtls_legacy=2Ec</span><br><span>         src/openvpn/crypto_opens=
sl=2Ec</span><br><span>         src/openvpn/crypto=2Ec</span><br><span>    =
     src/openvpn/otime=2Ec</span><br><span>@@ -871,6 +877,7 @@</span><br><s=
pan>         src/openvpn/base64=2Ec</span><br><span>         src/openvpn/cr=
ypto_epoch=2Ec</span><br><span>         src/openvpn/crypto_mbedtls=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/cryp=
to_mbedtls_legacy=2Ec</span><br><span>         src/openvpn/crypto_openssl=
=2Ec</span><br><span>         src/openvpn/crypto=2Ec</span><br><span>      =
   src/openvpn/env_set=2Ec</span><br><span>@@ -947,6 +954,7 @@</span><br><s=
pan>             src/openvpn/networking_sitnl=2Ec</span><br><span>         =
    src/openvpn/crypto_epoch=2Ec</span><br><span>             src/openvpn/c=
rypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>           =
  src/openvpn/crypto_openssl=2Ec</span><br><span>             src/openvpn/c=
rypto=2Ec</span><br><span>             src/openvpn/crypto_epoch=2Ec</span><=
br><span>@@ -968,6 +976,7 @@</span><br><span>             src/openvpn/base6=
4=2Ec</span><br><span>             src/openvpn/crypto_epoch=2Ec</span><br><=
span>             src/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            src/openvpn/crypto_mbedtls_legacy=
=2Ec</span><br><span>             src/openvpn/crypto_openssl=2Ec</span><br>=
<span>             src/openvpn/crypto=2Ec</span><br><span>             src/=
openvpn/env_set=2Ec</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1757?usp=3Demail">change 1=
757</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1757?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0=
8281cb511dacb2a69ff4a9607c5daf09157337b </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1757 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--rhhGd4x0YAA=--


--===============7773060894527398445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7773060894527398445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7773060894527398445==--

