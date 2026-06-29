Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29FBC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Jd1zyQx6domk/qfTOx74WMw3KrmjCioU6sQLXgQEL9s=; b=dThb437rrv0viJ
	Z8lJ1pXiHIIGh5cSgw+Z9D5QoCAJ0uB4ZAuFRf+B2zAG8aEbd15E8o00l30wCpQ3OIm59QAPExEDE
	TS+s2AWJGvq9suWb0C3O31YajChhgaijvqFHVGIhaGSG7n2AilBUX5NPcP52D0M7NGemrWVUqCGBN
	TRA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weDNx-0003W0-D3;
	Mon, 29 Jun 2026 14:54:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weDNw-0003Vt-0H
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 14:54:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x/EF4jqJNqj5aaJajdsGyqKWFQYaQQ7p3ECsSif5jpM=; b=dqEywGO8fbtbxHJccLEZw8uiFK
 Gsl3aWW9eiFtrJAHXEl68qnluDLD6ruezqrD0jlG1BhSgQzACfR4lu4v5pTjS/17VmgLhCMdBNHTF
 yi5u5RS1K/nuU83rf0Wc2REvZCTrrMA2ZrBZMMmjXK7+ll+5HuGCoRZBoNBMkv7r6V2U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=x/EF4jqJNqj5aaJajdsGyqKWFQYaQQ7p3ECsSif5jpM=; b=N
 p8GWpgyBMRb+P96x4lH/tM9scJM1RtWgIzOhKkpg7TXQQkDhOPes5lEkzvVFKhgST6ogtJpOqcspL
 yT/VNuvTBE/fu8n8XQ21Xt7fdI40qIS9QF1HwLfZrMNQwJPlCL/03eGYeMg/cY6DbJl1odW7f2jVG
 1hR5T7hQM1On2TeI=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weDNq-00060f-2I for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 14:54:53 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493b1710405so5587805e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782744879; x=1783349679; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/EF4jqJNqj5aaJajdsGyqKWFQYaQQ7p3ECsSif5jpM=;
 b=ddV9lJwq/fWxDsYPZR3qOrcClLtH/fmqRK1XzcHECNzC8O/S7lvXyWjndkqM6cdQv5
 vbRBpzPlMgDh4KQIYJNljXpFnAW4v7B3LpeQOEJ1xAMyk3bHamdpZpbSgg1V/pZjh2eU
 cU+D6VlsFVudmsEyQXt6NFfQknycYEemqjD0GbILzvbP+wCA4/yf1uyn97l3fEolb1Pa
 UOxwviUr5CazhN2j706DYWneYNNvv8lGxwNDr7y4R80OsDZDo5g7iK3m2Hrjwk6evv8g
 Ie0n830eS40zdFsCjozT3q3SgUniHz+cANYEbnN+XqrnGCKUxydKZWvSeEuxoszpvsq0
 3EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744879; x=1783349679;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x/EF4jqJNqj5aaJajdsGyqKWFQYaQQ7p3ECsSif5jpM=;
 b=BhkavTtjCFnRO527pXOAAdARVwmJO5dMX75tC9unttWHUAFRoQ1Megrx78jWYpQKJv
 VfOniK8j4kmBAtLNnvcdFRCh9T3diN6UDwuxy2nAqwiL2/caOMPDgnJDgRH2JsHMKt/H
 3YGoUIzGaMDmj6g/aAzgLUUvaSvWeDzsxfHU+pkCNfe4oQHy5ss10PbHEk2rJOVaa3US
 OJL6qkIGtCZTvr0Sx/LNEUgvRPizs6B+n4AI142fkAARwn3/fBgexQuOueRY4FUTuwTi
 URz9SEkaifcEfTmLZPYsRIlgG7jrZDHuaNgN+YBNFZm6oACgrpdn7c71Vz1kKsWPiYa5
 uHUw==
X-Gm-Message-State: AOJu0YyhlpMj/BVK+1+SL6AZbyj1Lj1J8PvEteHx+eMMbj5+0+9K9WWv
 NFgWIomAxi6OZaJiZnj7JWT2U4ZA3Kfd81FK1ZzQ71Tv1RSFnO0UCDcau/PsMje94Bw71AMrVtP
 XYSbAgoai6EHzgeRU6qMx3aBsaiuM7uQeDyyEGHk/ooAAJrz3tsvRUTtBbiM5/RZozvHtT4j6qz
 QMruRVXg==
X-Gm-Gg: AfdE7ckbYpzV0FhrQ8hxZQzmBTk7W67t2vh6epWbuvAI10GU86FhEfsVyDmagZJJcbe
 sMHVxgTWkTgvjos/gah34df+gJEw+IPhArtQMh591+OVqQXhPariRyYv6NfqT8jaqC1cp6n636d
 iN1fsvVSkVSLPPOIpW5ZZG1JhByCxZQJT4u0L79jo9DVMtL4rwLhlI+qq/3hf8c17cW5bXiJqQj
 sqreTrpXnORIOJIyHQPxa1dqXn7UGLhJjHTNJ47UYA5LwYBUZhH+l3sjLbutN4+9EcK5Daz4hVz
 ylppdl9IQn6m2K+OqXIMywyBWHJeL0KGtWNgN7BxBpAetgU7XELATJvjFn+zWCUTHWsIU7CKOSl
 09b5pRTcEvb7Gebln2SWxokfBaYNmEVLKF0ny91McVybArBVUfXwZkZOvUFUwPtEsJoRHYW5q0O
 rixatCUgZduKTp8BdYakHJ7f7PdhTVlW/w8IY/cQ9u4/zL9FeRx5m9iQxKJRZqpJlz4z2t5VBrT
 hKGXXQQx2AxcJDsTpgePw3dpVy7S5eeTRK3KVb73kF2BDi9Nso1dIIKHWLFQ1FYeCS881e6sR1P
 Bdk=
X-Received: by 2002:a05:600c:4e8b:b0:493:aa28:38ad with SMTP id
 5b1f17b1804b1-493b82861b2mr634385e9.10.1782744877023; 
 Mon, 29 Jun 2026 07:54:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4927038578bsm262124605e9.4.2026.06.29.07.54.36
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:54:36 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 14:54:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b
X-Gerrit-Change-Number: 1757
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1757?usp=email>
X-Gerrit-Commit: f966e962a3ca3fa07dcde8f4b0a04d83de5f6698
References: <gerrit.1782744874000.I08281cb511dacb2a69ff4a9607c5daf09157337b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQ0ODc0MDAwLkkwODI4MWNiNTExZGFjYjJhNjlmZjRhOTYwN2M1ZGFmMDkxNTczMzdiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <086b45985e8c64914d3ec57e91e81fe26888ad29-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weDNq-00060f-2I
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3715364009641871707=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3715364009641871707==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BZq6vplhqDU="; charset=UTF-8

--BZq6vplhqDU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1757?usp=3Demail )


Change subject: Fix compiling with =
mbed TLS 3 and cmake
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Fix compiling with mbed TLS 3 and cmake

The crypto_mbedtls_legacy=
=2Ec has been added to the Makefile=2Eam files
but was forgotten in the Cma=
ke build system=2E

Change-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b
Si=
gned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
1 fil=
e changed, 9 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/57/1757/1

diff --git a/CMakeLists=2E=
txt b/CMakeLists=2Etxt
index 4779d69=2E=2E3f38ab9 100644
--- a/CMakeLists=
=2Etxt
+++ b/CMakeLists=2Etxt
@@ -443,6 +443,8 @@
     src/openvpn/crypto_o=
penssl=2Eh
     src/openvpn/crypto_mbedtls=2Ec
     src/openvpn/crypto_mbed=
tls=2Eh
+    src/openvpn/crypto_mbedtls_legacy=2Ec
+    src/openvpn/crypto_=
mbedtls_legacy=2Eh
     src/openvpn/cryptoapi=2Ec
     src/openvpn/cryptoap=
i=2Eh
     src/openvpn/dco=2Ec
@@ -761,6 +763,7 @@
         src/openvpn/bas=
e64=2Ec
         src/openvpn/crypto_epoch=2Ec
         src/openvpn/crypto_m=
bedtls=2Ec
+        src/openvpn/crypto_mbedtls_legacy=2Ec
         src/open=
vpn/crypto_openssl=2Ec
         src/openvpn/crypto=2Ec
         src/openvpn=
/otime=2Ec
@@ -773,6 +776,7 @@
 
     target_sources(test_crypto PRIVATE
  =
       src/openvpn/crypto_mbedtls=2Ec
+        src/openvpn/crypto_mbedtls_l=
egacy=2Ec
         src/openvpn/crypto_openssl=2Ec
         src/openvpn/cryp=
to_epoch=2Ec
         src/openvpn/crypto=2Ec
@@ -790,6 +794,7 @@
          =
   src/openvpn/base64=2Ec
             src/openvpn/crypto_epoch=2Ec
       =
      src/openvpn/crypto_mbedtls=2Ec
+            src/openvpn/crypto_mbedtl=
s_legacy=2Ec
             src/openvpn/crypto_openssl=2Ec
             src/o=
penvpn/crypto=2Ec
             src/openvpn/cryptoapi=2Ec
@@ -825,6 +830,7 @=
@
     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch=2E=
c
         src/openvpn/crypto_mbedtls=2Ec
+        src/openvpn/crypto_mbedt=
ls_legacy=2Ec
         src/openvpn/crypto_openssl=2Ec
         src/openvpn/=
crypto=2Ec
         src/openvpn/otime=2Ec
@@ -853,6 +859,7 @@
         src/=
openvpn/base64=2Ec
         src/openvpn/crypto_epoch=2Ec
         src/openv=
pn/crypto_mbedtls=2Ec
+        src/openvpn/crypto_mbedtls_legacy=2Ec
      =
   src/openvpn/crypto_openssl=2Ec
         src/openvpn/crypto=2Ec
         =
src/openvpn/env_set=2Ec
@@ -927,6 +934,7 @@
             src/openvpn/networ=
king_sitnl=2Ec
             src/openvpn/crypto_epoch=2Ec
             src/o=
penvpn/crypto_mbedtls=2Ec
+            src/openvpn/crypto_mbedtls_legacy=2E=
c
             src/openvpn/crypto_openssl=2Ec
             src/openvpn/cryp=
to=2Ec
             src/openvpn/crypto_epoch=2Ec
@@ -948,6 +956,7 @@
      =
       src/openvpn/base64=2Ec
             src/openvpn/crypto_epoch=2Ec
   =
          src/openvpn/crypto_mbedtls=2Ec
+            src/openvpn/crypto_mb=
edtls_legacy=2Ec
             src/openvpn/crypto_openssl=2Ec
             s=
rc/openvpn/crypto=2Ec
             src/openvpn/env_set=2Ec

-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1757?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I08281cb511dacb2a69ff4a9607c5daf091=
57337b
Gerrit-Change-Number: 1757
Gerrit-PatchSet: 1
Gerrit-Owner: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>

--BZq6vplhqDU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1757?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Fix compiling with mbed TLS 3 and cmake<br><br>The crypto_mbedtls_=
legacy=2Ec has been added to the Makefile=2Eam files<br>but was forgotten i=
n the Cmake build system=2E<br><br>Change-Id: I08281cb511dacb2a69ff4a9607c5=
daf09157337b<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>-=
--<br>M CMakeLists=2Etxt<br>1 file changed, 9 insertions(+), 0 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/57/1757/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLi=
sts=2Etxt</span><br><span>index 4779d69=2E=2E3f38ab9 100644</span><br><span=
>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><s=
pan>@@ -443,6 +443,8 @@</span><br><span>     src/openvpn/crypto_openssl=2Eh=
</span><br><span>     src/openvpn/crypto_mbedtls=2Ec</span><br><span>     s=
rc/openvpn/crypto_mbedtls=2Eh</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/crypto_mbedtls_legacy=2Eh=
</span><br><span>     src/openvpn/cryptoapi=2Ec</span><br><span>     src/op=
envpn/cryptoapi=2Eh</span><br><span>     src/openvpn/dco=2Ec</span><br><spa=
n>@@ -761,6 +763,7 @@</span><br><span>         src/openvpn/base64=2Ec</span=
><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>         s=
rc/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>   =
      src/openvpn/crypto_openssl=2Ec</span><br><span>         src/openvpn/c=
rypto=2Ec</span><br><span>         src/openvpn/otime=2Ec</span><br><span>@@=
 -773,6 +776,7 @@</span><br><span> </span><br><span>     target_sources(tes=
t_crypto PRIVATE</span><br><span>         src/openvpn/crypto_mbedtls=2Ec</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/cr=
ypto_mbedtls_legacy=2Ec</span><br><span>         src/openvpn/crypto_openssl=
=2Ec</span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>=
         src/openvpn/crypto=2Ec</span><br><span>@@ -790,6 +794,7 @@</span><=
br><span>             src/openvpn/base64=2Ec</span><br><span>             s=
rc/openvpn/crypto_epoch=2Ec</span><br><span>             src/openvpn/crypto=
_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>             src=
/openvpn/crypto_openssl=2Ec</span><br><span>             src/openvpn/crypto=
=2Ec</span><br><span>             src/openvpn/cryptoapi=2Ec</span><br><span=
>@@ -825,6 +830,7 @@</span><br><span>     target_sources(test_ncp PRIVATE</=
span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>      =
   src/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span=
>         src/openvpn/crypto_openssl=2Ec</span><br><span>         src/openv=
pn/crypto=2Ec</span><br><span>         src/openvpn/otime=2Ec</span><br><spa=
n>@@ -853,6 +859,7 @@</span><br><span>         src/openvpn/base64=2Ec</span=
><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>         s=
rc/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>   =
      src/openvpn/crypto_openssl=2Ec</span><br><span>         src/openvpn/c=
rypto=2Ec</span><br><span>         src/openvpn/env_set=2Ec</span><br><span>=
@@ -927,6 +934,7 @@</span><br><span>             src/openvpn/networking_sit=
nl=2Ec</span><br><span>             src/openvpn/crypto_epoch=2Ec</span><br>=
<span>             src/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            src/openvpn/crypto_mbedtls_legacy=
=2Ec</span><br><span>             src/openvpn/crypto_openssl=2Ec</span><br>=
<span>             src/openvpn/crypto=2Ec</span><br><span>             src/=
openvpn/crypto_epoch=2Ec</span><br><span>@@ -948,6 +956,7 @@</span><br><spa=
n>             src/openvpn/base64=2Ec</span><br><span>             src/open=
vpn/crypto_epoch=2Ec</span><br><span>             src/openvpn/crypto_mbedtl=
s=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sr=
c/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>             src/openvp=
n/crypto_openssl=2Ec</span><br><span>             src/openvpn/crypto=2Ec</s=
pan><br><span>             src/openvpn/env_set=2Ec</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1757?usp=3Demail">change 1757</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1757?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1757 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--BZq6vplhqDU=--


--===============3715364009641871707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3715364009641871707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3715364009641871707==--

