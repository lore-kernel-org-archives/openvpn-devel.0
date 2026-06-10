Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630FCCD98C6
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CbxwRNzJU9RARnEWfdQpZeSjjBCTMzbwBtxCaQvqsA8=; b=cvpcaTJscxfzo5uwjX861cDk5f
	ZzfHq2f9KyzERT58ImqscLnFI5/S/oPeFOBNd0gzIsCZSXcflAe0hnBkO/0o+zkN+XGvkgLXZg395
	jKDJVH7jTVwfX3IO4poEVE0g713gU6wToH8eovWwjn72YolOwNu0At6Nspddetw88Q08=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXMWV-0000aX-46;
	Wed, 10 Jun 2026 17:15:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXMWT-0000aH-8c
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:15:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6gasMBQrXMWGur9jLpTT9zrAhnoXHnZdoxHODZXe30w=; b=WGkLxY+yHg6IFJhhQXc3tLieOb
 Mu6hhg6EtssROjIe0pDcUOtWoLqeIS+OcFKXps5cEOYbeIvdbCZR16asW6fu7ZDukTGPQMtaxX2Oj
 PM/NbBpEima59YhAk38smIBEHKC7Xafxj0Z8T0F7Y602iPhuKW0+8WQWbzmLLsBW3ki0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6gasMBQrXMWGur9jLpTT9zrAhnoXHnZdoxHODZXe30w=; b=H
 vsYcN0JBr48e7bnO154A7WwfAP7SZC2dnWhV3xZqqzzjxsVIVq7tNvr8Poe1GpRuFTfiyqu1N5hE0
 AYMUM3y0d+RbmyfP+kSB0Z9Ko8QF9a4IL0uUJHoi3JCJFfLUJc3bCcASecnvqJUilRPWjNqTc+PrK
 wzcfmE3b30U+g5NU=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXMWN-0007s0-32 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:15:25 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso80707115e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781111713; x=1781716513; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6gasMBQrXMWGur9jLpTT9zrAhnoXHnZdoxHODZXe30w=;
 b=bnttxeQUMKkgDJ01rBRPBVPNlPvW/J4MIb/GR1zORbUAkFD7VNrgYxxnnV9W1bQ6Q9
 PxR+FTQScg5vXiUPqnpUKe0+hFJaCm4dunaOve3ABTvi1UqAGtsHAoQl6Z8jvA+qIJiw
 sS5rRInUIRw7FJFYWEscyTV/eZL/CePgLM1LKgH4fCAhRf7WV1bpSiSBvUiuA4jub6Dn
 QwWqvmMjJnSYnmd8eHZtPilqC0xJjCDU2M/8yUbZlz35rUtPrT/iz23+0XkMzQSaagxo
 6bqDmqDinp+mDC0WgePAA/HwAwE+pPOXkQ7fxWgPUjBIgDvbJdxpykeATgjxhHts56Hp
 aD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111713; x=1781716513;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6gasMBQrXMWGur9jLpTT9zrAhnoXHnZdoxHODZXe30w=;
 b=jxcwOuDRvMc/lJbTVfmt17j+810svCk3ALCIea1RC05K8i6G0A6eia/Vl83sWuRCM4
 1z7Gp/howEbeQ3vqNV9kLkGHho58u7exENBEZtixRcS4N+YoEpsfBpokfHU28g96UXrU
 iRhhHoeR6nvk2Fs5l1ML5rx7H4H0WCZ2XJekKahMQHk2iEbJiifdlr3bbKzBHkyI+nO0
 5Gvdz4sn4J6bful3Zdyd7WvST54eG3q8bXzTiNGizDNTPljaa+5ttt8Xvn1B7pbL5Ly9
 PWKI6pBecQK4asy9Tk3IOlJChDLClpupFlKvHkgUyhHpFcVXKuYneucL79wqkqgncuTx
 MvTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BA95nX9SpVNjtpbpONfH/6yR8Vwto9QTRdwNUwu+ww2cZECr1ka9rMD91cB2+eexwhdY2LjCVWQ9BaM1+@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz6ZvAcYonCUepS5nDvFqHoL46lF4dsDrLrMGyW4gz/3tBo0bII
 hqy+XWH77L5KtRfj1YYiFylmnR8jkzl+O5ooKJNefKD4WlmoZbIvFO8aVyPbHzxDREZJjXJHsvd
 hlGgrcNDe8ec/jyNI5khch1ZJuoCpM31KXajAZB4E6rVSOcvakFsM5nDzFrmOyvanQXtm
X-Gm-Gg: Acq92OHP4vkHS+WUU8ciKWfleui8ILk7krfwq+WOAbbyPwpPgnxuzHvQiORCUgJmY7w
 u7M1wbxy86WfbgEAofWllLeJuaS1MOB5SsvYM2ivVMSF/PtwAqTOn2PM2uDKxLHXjghJFhPze+1
 AYU2ts9s4S7GLOYwWNTvo0IdbPEylwZNwkB0yY339DXTYXq1cg86hV7XkbTV7S5RlO0aPpmcXW+
 gefKboVEZ3kD72djDVGZWO7AhcBd1LxBYnzFclW/4H+2c/SQWNTJQs6g5fN+u4oI1eMQKwu9kfo
 egXe2jI9GoibvFvzp7l1zFEvf/rpRGM7T083MSm8y6CPjT3BtoV5hnXvv6IE7hZ5mVt5xF70dLu
 5vnyoclVQQfbusaFXmo7xrJs8666DfHQgCEDGt1mfyylQEZIA6zTPY8ARluMdCF9gC34Vnn3AUs
 1np3STcwXQtY/6PAwiNAmiaW6dYlrxy2v7Rzw6Yuz/VZARF0iH1nh2r33lycS13yzGV96TVIQy3
 Vl0L6eY+8OywYYegV/U736mVsn9HauRDCRDQa/cMsxQrqONpqZ/gBADv3jKQMaFX4u/Bld+ld//
 iaBwF0vltcN7B+vTmr9mRnNi/bCkZduRPzw=
X-Received: by 2002:a05:600c:4ec6:b0:490:b780:13f7 with SMTP id
 5b1f17b1804b1-490c2631c40mr414209065e9.23.1781111712671; 
 Wed, 10 Jun 2026 10:15:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2b2bbdbsm1600135e9.14.2026.06.10.10.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:15:12 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 17:15:11 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I11fc104878ba244c5be04ce8019695b6892c4457
X-Gerrit-Change-Number: 1710
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1710?usp=email>
X-Gerrit-Commit: f9e6d5d724851a938a0c064307db513df469eb62
In-Reply-To: <gerrit.1781017122000.I11fc104878ba244c5be04ce8019695b6892c4457@gerrit.openvpn.net>
References: <gerrit.1781017122000.I11fc104878ba244c5be04ce8019695b6892c4457@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxMDE3MTIyMDAwLkkxMWZjMTA0ODc4YmEyNDRjNWJlMDRjZTgwMTk2OTViNjg5MmM0NDU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6cb70341d0968b24b3f4262f86650350961bac79-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXMWN-0007s0-32
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Maintenance
 update June 2026
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6844244403632738726=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6844244403632738726==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m9c5y9roTRk="; charset=UTF-8

--m9c5y9roTRk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1710?usp=3Demail )

Change subject: GHA: Maintenance update June 2026
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Maintena=
nce update June 2026

Contains the following renovate updates:
- chore(deps=
): update github actions
- chore(deps): update vcpkg digest to 75672db
- ch=
ore(deps): update dependency aws/aws-lc to v5
- chore(deps): update depende=
ncy libressl/portable to v4=2E3=2E2

Change-Id: I11fc104878ba244c5be04ce801=
9695b6892c4457
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
A=
cked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1710
Message-Id: <20260609152103=2E27418-1-g=
ert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg37138=2Ehtml
Signed-off-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
---
M =2Egithub/workflows/build=2Eyaml
M =2Egithub/wo=
rkflows/coverity-scan=2Eyml
M =2Egithub/workflows/doxygen=2Eyml
M =2Egithub=
/workflows/test-ssllib=2Eyml
4 files changed, 20 insertions(+), 20 deletion=
s(-)




diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflow=
s/build=2Eyaml
index b530fcc=2E=2E323645a 100644
--- a/=2Egithub/workflows/=
build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -14,7 +14,7 @@
     =
      sudo apt update && sudo apt install -y python3-pip
           pip3 in=
stall pre-commit
       - name: Checkout OpenVPN
-        uses: actions/che=
ckout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        uses: =
actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
    =
   - name: Run clang-format
         run: pre-commit run -a --show-diff-on-=
failure || true
       - name: Check for changes
@@ -43,11 +43,11 @@
      =
 VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg
       VCPKG_INSTALLED_DIR: ${=
{ github=2Eworkspace }}/vcpkg/installed
       VCPKG_BINARY_SOURCES: clear;=
default,readwrite
-      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6=
b1fe57497c7
+      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0=
c0f07
     steps:
       - name: Checkout OpenVPN
-        uses: actions/ch=
eckout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
-      - uses:=
 lukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v4=2E3=2E2
+   =
     uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=
=2E0=2E3
+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb=
3a42e # v4=2E3=2E3
       - name: Setup vcpkg
         uses: lukka/run-vcpk=
g@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
         with:
@@ -84,=
14 +84,14 @@
     env:
       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg
 =
      VCPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT=
_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7
+      VCPKG_GIT_COMMIT_ID: 7=
5672db6bd812b060482b0f00b5a16b18a0c0f07
     steps:
       - name: Install =
dependencies
         run: sudo apt update && sudo apt install -y mingw-w64=
 unzip build-essential wget python3-docutils man2html-base
       - name: C=
heckout OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009e67214f=
f5f5447ce83dd # v6=2E0=2E2
+        uses: actions/checkout@df4cb1c069e1874e=
dd31b4311f1884172cec0e10 # v6=2E0=2E3
 
-      - uses: lukka/get-cmake@7bfc=
9baacbbdcb5e37957ad05c3546b3e222be3c # v4=2E3=2E2
+      - uses: lukka/get-=
cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3
       - name: =
Setup vcpkg
         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a=
427fb6a2 # v11=2E6
         with:
@@ -142,7 +142,7 @@
     name: "mingw uni=
ttest ${{ matrix=2Etest }} - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} -=
 OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/c=
heckout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        uses=
: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
  =
     - name: Retrieve mingw unittest
         uses: actions/download-artifa=
ct@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8=2E0=2E1
         with:
@@ =
-183,7 +183,7 @@
       - name: Install dependencies
         run: sudo apt=
 update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-n=
g-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docuti=
ls libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout=
 OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447=
ce83dd # v6=2E0=2E2
+        uses: actions/checkout@df4cb1c069e1874edd31b43=
11f1884172cec0e10 # v6=2E0=2E3
       - name: autoconf
         run: autore=
conf -fvi
       - name: configure
@@ -213,7 +213,7 @@
       - name: Insta=
ll dependencies
         run: sudo apt update && sudo apt install -y liblzo=
2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev=
 man2html clang libcmocka-dev python3-docutils libtool automake autoconf
  =
     - name: Checkout OpenVPN
-        uses: actions/checkout@de0fac2e4500d=
abe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        uses: actions/checkout@df=
4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
       - name: autoconf=

         run: autoreconf -fvi
       - name: configure
@@ -253,7 +253,7 @@=

       - name: Install dependencies
         run: brew install ${{matrix=
=2Essllib}} lzo lz4 man2html cmocka libtool automake autoconf
       - name=
: Checkout OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009e672=
14ff5f5447ce83dd # v6=2E0=2E2
+        uses: actions/checkout@df4cb1c069e18=
74edd31b4311f1884172cec0e10 # v6=2E0=2E3
       - name: Set environment
   =
      run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -283,12 +283,12 @@
    =
   env:
         BUILD_CONFIGURATION: Release
         VCPKG_BINARY_SOURCES=
: clear;default,readwrite
-        VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee3=
54f15be6e6b1fe57497c7
+        VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f=
00b5a16b18a0c0f07
 
       runs-on: windows-2025
       steps:
-      - use=
s: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
-=
      - uses: lukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v4=
=2E3=2E2
+      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172c=
ec0e10 # v6=2E0=2E3
+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae=
36172462abb3a42e # v4=2E3=2E3
 
       - name: Install rst2html
         ru=
n: python -m pip install --upgrade pip docutils
@@ -342,7 +342,7 @@
       =
ovpnlibdesc: LibreSSL
       # versioning=3Dsemver-coerced
       ghrepo: l=
ibressl/portable
-      gitref: v4=2E2=2E1
+      gitref: v4=2E3=2E2
      =
 libconfigure: "LIBRESSL_GIT_OPTIONS=3D--no-single-branch =2E/autogen=2Esh =
&& =2E/configure --prefix=3D$LIBPREFIX"
 
   openssl4:
@@ -376,7 +376,7 @@
=
       ovpnlibdesc: AWS-LC
       # versioning=3Dsemver-coerced
       ghre=
po: aws/aws-lc
-      gitref: v1=2E70=2E0
+      gitref: v5=2E0=2E0
       =
libconfigure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_I=
NSTALL_PREFIX=3D"$LIBPREFIX" -DBUILD_SHARED_LIBS=3D1
       libmake: cmake =
--build build
       libinstall: sudo cmake --install build
diff --git a/=
=2Egithub/workflows/coverity-scan=2Eyml b/=2Egithub/workflows/coverity-scan=
=2Eyml
index 1eec1ed=2E=2E105f23e 100644
--- a/=2Egithub/workflows/coverity=
-scan=2Eyml
+++ b/=2Egithub/workflows/coverity-scan=2Eyml
@@ -25,7 +25,7 @@=

 
       - name: Checkout OpenVPN
         if: steps=2Echeck_submit=2Eoutp=
uts=2Ecache-hit !=3D 'true'
-        uses: actions/checkout@de0fac2e4500dab=
e0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        uses: actions/checkout@df4c=
b1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
 
       - name: Download=
 Coverity Build Tool
         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hi=
t !=3D 'true'
diff --git a/=2Egithub/workflows/doxygen=2Eyml b/=2Egithub/wo=
rkflows/doxygen=2Eyml
index 30988b5=2E=2E3755b92 100644
--- a/=2Egithub/wor=
kflows/doxygen=2Eyml
+++ b/=2Egithub/workflows/doxygen=2Eyml
@@ -11,7 +11,7=
 @@
     runs-on: ubuntu-24=2E04
     if: ${{ github=2Erepository_owner =3D=
=3D 'openvpn' || github=2Eevent_name =3D=3D 'workflow_dispatch' }}
     ste=
ps:
-      - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83d=
d # v6=2E0=2E2
+      - uses: actions/checkout@df4cb1c069e1874edd31b4311f18=
84172cec0e10 # v6=2E0=2E3
         with:
           path: openvpn
 
diff --=
git a/=2Egithub/workflows/test-ssllib=2Eyml b/=2Egithub/workflows/test-ssll=
ib=2Eyml
index c6a2e44=2E=2Ed8178a7 100644
--- a/=2Egithub/workflows/test-s=
sllib=2Eyml
+++ b/=2Egithub/workflows/test-ssllib=2Eyml
@@ -77,7 +77,7 @@
 =
          key: ${{matrix=2Eos}}-${{inputs=2Elibname}}-${{matrix=2Ebuild }}-=
${{inputs=2Egitref}}
       - name: "${{inputs=2Elibname}}: checkout"
     =
    if: steps=2Essllib-cache=2Eoutputs=2Ecache-hit !=3D 'true'
-        use=
s: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+=
        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v=
6=2E0=2E3
         with:
           submodules: recursive
           path: =
${{inputs=2Elibname}}
@@ -98,7 +98,7 @@
       - name: Run ldconfig
       =
  run: sudo ldconfig
       - name: "OpenVPN: checkout"
-        uses: acti=
ons/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+       =
 uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=
=2E3
       - name: "OpenVPN: autoreconf"
         run: autoreconf -fvi
   =
    - name: "OpenVPN: configure"

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1710?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I11fc104878ba244c5be04ce8019695b6892c4457
Gerrit-Change-Number: =
1710
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--m9c5y9roTRk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1710?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">GHA: Maintenance update June 2026<br><br>C=
ontains the following renovate updates:<br>- chore(deps): update github act=
ions<br>- chore(deps): update vcpkg digest to 75672db<br>- chore(deps): upd=
ate dependency aws/aws-lc to v5<br>- chore(deps): update dependency libress=
l/portable to v4=2E3=2E2<br><br>Change-Id: I11fc104878ba244c5be04ce8019695b=
6892c4457<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1710<br>Message-Id: &lt;2026=
0609152103=2E27418-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37138=2Ehtml<br>S=
igned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =2Eg=
ithub/workflows/build=2Eyaml<br>M =2Egithub/workflows/coverity-scan=2Eyml<b=
r>M =2Egithub/workflows/doxygen=2Eyml<br>M =2Egithub/workflows/test-ssllib=
=2Eyml<br>4 files changed, 20 insertions(+), 20 deletions(-)<br><br></pre>
=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/buil=
d=2Eyaml</span><br><span>index b530fcc=2E=2E323645a 100644</span><br><span>=
--- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub/work=
flows/build=2Eyaml</span><br><span>@@ -14,7 +14,7 @@</span><br><span>      =
     sudo apt update &amp;&amp; sudo apt install -y python3-pip</span><br><=
span>           pip3 install pre-commit</span><br><span>       - name: Chec=
kout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u=
ses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br=
><span>       - name: Run clang-format</span><br><span>         run: pre-co=
mmit run -a --show-diff-on-failure || true</span><br><span>       - name: C=
heck for changes</span><br><span>@@ -43,11 +43,11 @@</span><br><span>      =
 VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg</span><br><span>       VCPKG_I=
NSTALLED_DIR: ${{ github=2Eworkspace }}/vcpkg/installed</span><br><span>   =
    VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee35=
4f15be6e6b1fe57497c7</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07</span>=
<br><span>     steps:</span><br><span>       - name: Checkout OpenVPN</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/check=
out@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@7bfc9baac=
bbdcb5e37957ad05c3546b3e222be3c # v4=2E3=2E2</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874edd3=
1b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae361724=
62abb3a42e # v4=2E3=2E3</span><br><span>       - name: Setup vcpkg</span><b=
r><span>         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427f=
b6a2 # v11=2E6</span><br><span>         with:</span><br><span>@@ -84,14 +84=
,14 @@</span><br><span>     env:</span><br><span>       VCPKG_ROOT: ${{ git=
hub=2Eworkspace }}/vcpkg</span><br><span>       VCPKG_BINARY_SOURCES: clear=
;default,readwrite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 756=
72db6bd812b060482b0f00b5a16b18a0c0f07</span><br><span>     steps:</span><br=
><span>       - name: Install dependencies</span><br><span>         run: su=
do apt update &amp;&amp; sudo apt install -y mingw-w64 unzip build-essentia=
l wget python3-docutils man2html-base</span><br><span>       - name: Checko=
ut OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        use=
s: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions=
/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: l=
ukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v4=2E3=2E2</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cm=
ake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><span> =
      - name: Setup vcpkg</span><br><span>         uses: lukka/run-vcpkg@b1=
a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6</span><br><span>         w=
ith:</span><br><span>@@ -142,7 +142,7 @@</span><br><span>     name: &quot;m=
ingw unittest ${{ matrix=2Etest }} - ${{ matrix=2Earch }} - ${{ matrix=2Ebu=
ild }} - OSSL&quot;</span><br><span>     steps:</span><br><span>       - na=
me: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=
=2E0=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        use=
s: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</=
span><br><span>       - name: Retrieve mingw unittest</span><br><span>     =
    uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7=
c # v8=2E0=2E1</span><br><span>         with:</span><br><span>@@ -183,7 +18=
3,7 @@</span><br><span>       - name: Install dependencies</span><br><span>=
         run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev li=
bpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2htm=
l libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS=
11PKG}</span><br><span>       - name: Checkout OpenVPN</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@de0fac2e450=
0dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874edd31b=
4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>       - name: autoconf</s=
pan><br><span>         run: autoreconf -fvi</span><br><span>       - name: =
configure</span><br><span>@@ -213,7 +213,7 @@</span><br><span>       - name=
: Install dependencies</span><br><span>         run: sudo apt update &amp;&=
amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev =
libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docuti=
ls libtool automake autoconf</span><br><span>       - name: Checkout OpenVP=
N</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: action=
s/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout=
@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>    =
   - name: autoconf</span><br><span>         run: autoreconf -fvi</span><br=
><span>       - name: configure</span><br><span>@@ -253,7 +253,7 @@</span><=
br><span>       - name: Install dependencies</span><br><span>         run: =
brew install ${{matrix=2Essllib}} lzo lz4 man2html cmocka libtool automake =
autoconf</span><br><span>       - name: Checkout OpenVPN</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@de0fac2e4=
500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874edd3=
1b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>       - name: Set envir=
onment</span><br><span>         run: |</span><br><span>           cat &gt;&=
gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span>@@ -283,12 +283,12 @@</span><br=
><span>       env:</span><br><span>         BUILD_CONFIGURATION: Release</s=
pan><br><span>         VCPKG_BINARY_SOURCES: clear;default,readwrite</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        VCPKG_GIT_COMMIT_ID:=
 031f4afe03be385aee354f15be6e6b1fe57497c7</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f0=
0b5a16b18a0c0f07</span><br><span> </span><br><span>       runs-on: windows-=
2025</span><br><span>       steps:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5=
447ce83dd # v6=2E0=2E2</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      - uses: lukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v=
4=2E3=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - us=
es: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/=
get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><=
span> </span><br><span>       - name: Install rst2html</span><br><span>    =
     run: python -m pip install --upgrade pip docutils</span><br><span>@@ -=
342,7 +342,7 @@</span><br><span>       ovpnlibdesc: LibreSSL</span><br><spa=
n>       # versioning=3Dsemver-coerced</span><br><span>       ghrepo: libre=
ssl/portable</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      git=
ref: v4=2E2=2E1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  gitref: v4=2E3=2E2</span><br><span>       libconfigure: &quot;LIBRESSL_GI=
T_OPTIONS=3D--no-single-branch =2E/autogen=2Esh &amp;&amp; =2E/configure --=
prefix=3D$LIBPREFIX&quot;</span><br><span> </span><br><span>   openssl4:</s=
pan><br><span>@@ -376,7 +376,7 @@</span><br><span>       ovpnlibdesc: AWS-L=
C</span><br><span>       # versioning=3Dsemver-coerced</span><br><span>    =
   ghrepo: aws/aws-lc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
      gitref: v1=2E70=2E0</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      gitref: v5=2E0=2E0</span><br><span>       libconfigure: cmake -=
B build -GNinja -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D&quot=
;$LIBPREFIX&quot; -DBUILD_SHARED_LIBS=3D1</span><br><span>       libmake: c=
make --build build</span><br><span>       libinstall: sudo cmake --install =
build</span><br><span>diff --git a/=2Egithub/workflows/coverity-scan=2Eyml =
b/=2Egithub/workflows/coverity-scan=2Eyml</span><br><span>index 1eec1ed=2E=
=2E105f23e 100644</span><br><span>--- a/=2Egithub/workflows/coverity-scan=
=2Eyml</span><br><span>+++ b/=2Egithub/workflows/coverity-scan=2Eyml</span>=
<br><span>@@ -25,7 +25,7 @@</span><br><span> </span><br><span>       - name=
: Checkout OpenVPN</span><br><span>         if: steps=2Echeck_submit=2Eoutp=
uts=2Ecache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f=
5447ce83dd # v6=2E0=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10=
 # v6=2E0=2E3</span><br><span> </span><br><span>       - name: Download Cov=
erity Build Tool</span><br><span>         if: steps=2Echeck_submit=2Eoutput=
s=2Ecache-hit !=3D &#39;true&#39;</span><br><span>diff --git a/=2Egithub/wo=
rkflows/doxygen=2Eyml b/=2Egithub/workflows/doxygen=2Eyml</span><br><span>i=
ndex 30988b5=2E=2E3755b92 100644</span><br><span>--- a/=2Egithub/workflows/=
doxygen=2Eyml</span><br><span>+++ b/=2Egithub/workflows/doxygen=2Eyml</span=
><br><span>@@ -11,7 +11,7 @@</span><br><span>     runs-on: ubuntu-24=2E04</=
span><br><span>     if: ${{ github=2Erepository_owner =3D=3D &#39;openvpn&#=
39; || github=2Eevent_name =3D=3D &#39;workflow_dispatch&#39; }}</span><br>=
<span>     steps:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E=
0=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: =
actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</spa=
n><br><span>         with:</span><br><span>           path: openvpn</span><=
br><span> </span><br><span>diff --git a/=2Egithub/workflows/test-ssllib=2Ey=
ml b/=2Egithub/workflows/test-ssllib=2Eyml</span><br><span>index c6a2e44=2E=
=2Ed8178a7 100644</span><br><span>--- a/=2Egithub/workflows/test-ssllib=2Ey=
ml</span><br><span>+++ b/=2Egithub/workflows/test-ssllib=2Eyml</span><br><s=
pan>@@ -77,7 +77,7 @@</span><br><span>           key: ${{matrix=2Eos}}-${{i=
nputs=2Elibname}}-${{matrix=2Ebuild }}-${{inputs=2Egitref}}</span><br><span=
>       - name: &quot;${{inputs=2Elibname}}: checkout&quot;</span><br><span=
>         if: steps=2Essllib-cache=2Eoutputs=2Ecache-hit !=3D &#39;true&#39=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: action=
s/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout=
@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>    =
     with:</span><br><span>           submodules: recursive</span><br><span=
>           path: ${{inputs=2Elibname}}</span><br><span>@@ -98,7 +98,7 @@</=
span><br><span>       - name: Run ldconfig</span><br><span>         run: su=
do ldconfig</span><br><span>       - name: &quot;OpenVPN: checkout&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/ch=
eckout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@df4=
cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>       -=
 name: &quot;OpenVPN: autoreconf&quot;</span><br><span>         run: autore=
conf -fvi</span><br><span>       - name: &quot;OpenVPN: configure&quot;</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1710?usp=3Demail">change 1710</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1710?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I11fc104878ba244c5be04c=
e8019695b6892c4457 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1710 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</b=
ody></html>
--m9c5y9roTRk=--


--===============6844244403632738726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6844244403632738726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6844244403632738726==--

