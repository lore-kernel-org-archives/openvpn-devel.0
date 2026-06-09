Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAF0CD8CAA
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=wllBShLwwpgbcs8sKuui13t5DUCqMLWMYe2LLMGl/fg=; b=SLYA4TkJ+TebQ3
	Mibuc4CXLijeKw6rqJqIlXun0+LppJ/3P3Jur6CWieM8UaYIZotfVd5+ZNCoJzYlW5SJpUtk3NEi6
	CpTHcWPCONAvNXRS05x9bPFqB+KV9YdXTr7M7yeByELBUz3Pl1reF09BKxYAeJu86kviOCiDEICCE
	WwQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxv1-0000nf-5b;
	Tue, 09 Jun 2026 14:59:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxux-0000mT-JJ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:59:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5aJ+/FHiXxDp6Wjo+0VyxMerztP6CkGTZqteDZQY5cY=; b=lefZmlJAGSTtJP9r2+O8AfwbBn
 suOjQexa630wc3zualW9E4b0uiIJ8wK4pjAWxHjUCbZoc9VyoNdigX69B2GepmdMniYqWMGDn344U
 ye0El15bey70lCgxujJWfsAD/Xeqq06K0ti3Auotl8OzT9htkRfdnRknuHTf0vjX9xOU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5aJ+/FHiXxDp6Wjo+0VyxMerztP6CkGTZqteDZQY5cY=; b=S
 tkTYJ4eZk3x1oukfWZuzYDv8hPDzG9Tjal93vYXMHstYm5bOjDCNOe6Hhk/2sK7FQ1fFafd2YE44q
 Xf2ZxRXtqtHz//A3TLjTdYQNPfoQ6sVba9CMRKAPobDBgsml1Aqs+N+/ZjIsYKrCiihXccGKwSgej
 /nALLUkpf6vmgFaw=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxuv-00006q-BJ for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:59:04 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso40143775e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781017130; x=1781621930; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5aJ+/FHiXxDp6Wjo+0VyxMerztP6CkGTZqteDZQY5cY=;
 b=SXw6m2MlLmqfgMwGadVLZaB9uQY1FLbGcwqqvM1Pxsom4Qst4FyHDUn+zio356DOKq
 9b3ajC5N91+DKy/CWBquwyp6knx9mbDjmvP+mJXse+Vgw/ZFc+gmO8qLaA3fLMsRs+W0
 a4wS19LtEH9e7rCO2WbKC6RcJRQmBKFTZMHpVhMvg2UhjZcURwwhsE68U3W2DA5RlYao
 qM/mJD0mtcqIklBUZJ8JySEETNorixgStK+ngk5WDALtUGFCuyyqtaYHaCZLu4x3OOsQ
 S7CqxCpn6C1ZIMCjaEmj1nT7+O4as1YQgl0Cd7RcDKTeF5KxC75XjVnLREVKJSJ83U78
 q1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017130; x=1781621930;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5aJ+/FHiXxDp6Wjo+0VyxMerztP6CkGTZqteDZQY5cY=;
 b=l7pN8r8caeGLMVNjncIAo6PhPHQ6BvKcYKQSqYGFqRxZO3wowcQ+hvPHcMQl07z0EP
 +aQ03601QQUbK7Q+LsDIOxpJ29H2BM8or6M13tJo5vYmhwkqcjV+P7H2EDbMK5RwexCs
 s/prSaXlTtIo2jLe+3oJyO/peoFOBnc0FS5daWaI+JYt0qmBUFCjDCVCZjgIprnq+Joy
 SE2UPtzBo0LmE+P4MgkK26eyRzWSvMbq38/PPX3jcZqqSz0+CIQ9RlIUPCaNtHuZCovj
 oE6unDL0ecsJzE506/SxlaSdf9kzXT5NjvpPW9uQK8teoBJsmXBzr1q26VbKzYEylSEI
 /bnQ==
X-Gm-Message-State: AOJu0Yw/uqcMgWQU5hTu1/oGVmllisfanCJddBmWbM1JeDByH5YFY3K5
 I2ty5/ZFAL1ebx0zPyHiga1U5S76yFnDX1jK1kgz2lIaP7wtCnV3TaZ6N0kNQkpQuSmK5nyGpB4
 /Wf9fw1kC6CcL74hEKfRkg2ZOhO4VpAxAmn2zdrhdfJsVzSz7IpsGddiaVK5LinobwAXQVnjysZ
 vqxZeFrw==
X-Gm-Gg: Acq92OGi+JThMIgnYRrlGMLfJD+yjvTS86TrrRKkm/dEk5OAPp1xP5lXIr8a7awyRQ2
 ujAQKhhHwLqh/rRK+LRgpHb70Cdnrq6FQ4D4lN42wfQ+WpV7t5KANrjIgBFAxPogoQe/Gev4ca5
 C6ikoxidbpX9mI3lnOy9OAjIvhIHD/F6IAPMAfjMAFAHHIr9e/fuNCqGnv0YaYHgnByWKqXOfpQ
 7rUrngxZO+FBRdADub9YjzOfsZ5QkrQsyn5UVJOiCcNpuLV98z4DBS7xn7my+cYrlEfdt0Y1gX/
 c6hwge2nFRcASe537Vz16UbeByvGCK3XrPM4zafvU0QLsF4WfVj4BCAkYJjQOWBpdXsX/iMU0Lz
 /IMvyn00ALBQQ7KWPVfcw4UUKmizepJar1t4wSzAZYsqXaXgfy79319j2/joc6UexSDorJXYB39
 SemRa6cgLumdIoQHNelLduWQLilvEuGfwNKN6ZUPv1DKlbzN81ptOr/cdYbXmF6mz7jq6ORetIl
 MTj7sqkT5bg1OyqednwCOWzSRie8Hucl8Gd6dV2RiFxKf447V10CWmpuAT+xHP41PNQDTW2ojq+
 jJgUSLYGdMZKtngzwsFvkLCE
X-Received: by 2002:a05:600c:4ec7:b0:490:b8ee:d6a5 with SMTP id
 5b1f17b1804b1-490c2589927mr339414715e9.6.1781017129664; 
 Tue, 09 Jun 2026 07:58:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d2d11asm434101365e9.1.2026.06.09.07.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:58:49 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 14:58:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I11fc104878ba244c5be04ce8019695b6892c4457
X-Gerrit-Change-Number: 1710
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1710?usp=email>
X-Gerrit-Commit: b258a4b89cf75de129ae1c7a59869aae5414ed62
References: <gerrit.1781017122000.I11fc104878ba244c5be04ce8019695b6892c4457@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxMDE3MTIyMDAwLkkxMWZjMTA0ODc4YmEyNDRjNWJlMDRjZTgwMTk2OTViNjg5MmM0NDU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <79e63d15d54aa34b92a3f2b5e609037799e1a933-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxuv-00006q-BJ
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8363698926440948263=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8363698926440948263==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H0TsT1lP7Tc="; charset=UTF-8

--H0TsT1lP7Tc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1710?usp=3Demail

to review the following change=2E


Chang=
e subject: GHA: Maintenance update June 2026
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Maintenance update June 2026

Contains=
 the following renovate updates:
- chore(deps): update github actions
- cho=
re(deps): update vcpkg digest to 75672db
- chore(deps): update dependency a=
ws/aws-lc to v5
- chore(deps): update dependency libressl/portable to v4=2E=
3=2E2

Change-Id: I11fc104878ba244c5be04ce8019695b6892c4457
Signed-off-by: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M =2Egithub/workflows/build=
=2Eyaml
M =2Egithub/workflows/coverity-scan=2Eyml
M =2Egithub/workflows/dox=
ygen=2Eyml
M =2Egithub/workflows/test-ssllib=2Eyml
4 files changed, 20 inse=
rtions(+), 20 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/10/1710/1

diff --git a/=2Egithub/workflows/build=2Ey=
aml b/=2Egithub/workflows/build=2Eyaml
index b530fcc=2E=2E323645a 100644
--=
- a/=2Egithub/workflows/build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml=

@@ -14,7 +14,7 @@
           sudo apt update && sudo apt install -y python=
3-pip
           pip3 install pre-commit
       - name: Checkout OpenVPN
- =
       uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=
=2E0=2E2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172c=
ec0e10 # v6=2E0=2E3
       - name: Run clang-format
         run: pre-commi=
t run -a --show-diff-on-failure || true
       - name: Check for changes
@@=
 -43,11 +43,11 @@
       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg
      =
 VCPKG_INSTALLED_DIR: ${{ github=2Eworkspace }}/vcpkg/installed
       VCPK=
G_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 031f4=
afe03be385aee354f15be6e6b1fe57497c7
+      VCPKG_GIT_COMMIT_ID: 75672db6bd8=
12b060482b0f00b5a16b18a0c0f07
     steps:
       - name: Checkout OpenVPN
-=
        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v=
6=2E0=2E2
-      - uses: lukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e2=
22be3c # v4=2E3=2E2
+        uses: actions/checkout@df4cb1c069e1874edd31b43=
11f1884172cec0e10 # v6=2E0=2E3
+      - uses: lukka/get-cmake@591817e96fcad=
43505fb4eae36172462abb3a42e # v4=2E3=2E3
       - name: Setup vcpkg
       =
  uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
=
         with:
@@ -84,14 +84,14 @@
     env:
       VCPKG_ROOT: ${{ github=
=2Eworkspace }}/vcpkg
       VCPKG_BINARY_SOURCES: clear;default,readwrite
=
-      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7
+     =
 VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
     steps:
=
       - name: Install dependencies
         run: sudo apt update && sudo a=
pt install -y mingw-w64 unzip build-essential wget python3-docutils man2htm=
l-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@de0f=
ac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        uses: actions/ch=
eckout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
 
-      - use=
s: lukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v4=2E3=2E2
+ =
     - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=
=2E3=2E3
       - name: Setup vcpkg
         uses: lukka/run-vcpkg@b1a0dd25=
2f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
         with:
@@ -142,7 +142,7 =
@@
     name: "mingw unittest ${{ matrix=2Etest }} - ${{ matrix=2Earch }} -=
 ${{ matrix=2Ebuild }} - OSSL"
     steps:
       - name: Checkout OpenVPN
=
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # =
v6=2E0=2E2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f188417=
2cec0e10 # v6=2E0=2E3
       - name: Retrieve mingw unittest
         uses:=
 actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8=2E=
0=2E1
         with:
@@ -183,7 +183,7 @@
       - name: Install dependencie=
s
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g=
-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libc=
mocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}=

       - name: Checkout OpenVPN
-        uses: actions/checkout@de0fac2e45=
00dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        uses: actions/checkout=
@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
       - name: autoc=
onf
         run: autoreconf -fvi
       - name: configure
@@ -213,7 +213,7=
 @@
       - name: Install dependencies
         run: sudo apt update && su=
do apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-g=
enl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libt=
ool automake autoconf
       - name: Checkout OpenVPN
-        uses: action=
s/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        u=
ses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3=

       - name: autoconf
         run: autoreconf -fvi
       - name: confi=
gure
@@ -253,7 +253,7 @@
       - name: Install dependencies
         run: =
brew install ${{matrix=2Essllib}} lzo lz4 man2html cmocka libtool automake =
autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@de=
0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        uses: actions/=
checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
       - nam=
e: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -=
283,12 +283,12 @@
       env:
         BUILD_CONFIGURATION: Release
       =
  VCPKG_BINARY_SOURCES: clear;default,readwrite
-        VCPKG_GIT_COMMIT_I=
D: 031f4afe03be385aee354f15be6e6b1fe57497c7
+        VCPKG_GIT_COMMIT_ID: 7=
5672db6bd812b060482b0f00b5a16b18a0c0f07
 
       runs-on: windows-2025
    =
   steps:
-      - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f544=
7ce83dd # v6=2E0=2E2
-      - uses: lukka/get-cmake@7bfc9baacbbdcb5e37957ad=
05c3546b3e222be3c # v4=2E3=2E2
+      - uses: actions/checkout@df4cb1c069e1=
874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+      - uses: lukka/get-cmake@59=
1817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3
 
       - name: Instal=
l rst2html
         run: python -m pip install --upgrade pip docutils
@@ -3=
42,7 +342,7 @@
       ovpnlibdesc: LibreSSL
       # versioning=3Dsemver-co=
erced
       ghrepo: libressl/portable
-      gitref: v4=2E2=2E1
+      git=
ref: v4=2E3=2E2
       libconfigure: "LIBRESSL_GIT_OPTIONS=3D--no-single-br=
anch =2E/autogen=2Esh && =2E/configure --prefix=3D$LIBPREFIX"
 
   openssl4=
:
@@ -376,7 +376,7 @@
       ovpnlibdesc: AWS-LC
       # versioning=3Dsemv=
er-coerced
       ghrepo: aws/aws-lc
-      gitref: v1=2E70=2E0
+      gitr=
ef: v5=2E0=2E0
       libconfigure: cmake -B build -GNinja -DCMAKE_BUILD_TY=
PE=3DRelease -DCMAKE_INSTALL_PREFIX=3D"$LIBPREFIX" -DBUILD_SHARED_LIBS=3D1
=
       libmake: cmake --build build
       libinstall: sudo cmake --install=
 build
diff --git a/=2Egithub/workflows/coverity-scan=2Eyml b/=2Egithub/wor=
kflows/coverity-scan=2Eyml
index 1eec1ed=2E=2E105f23e 100644
--- a/=2Egithu=
b/workflows/coverity-scan=2Eyml
+++ b/=2Egithub/workflows/coverity-scan=2Ey=
ml
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenVPN
         if: steps=
=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'true'
-        uses: actions/ch=
eckout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        uses:=
 actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
 
 =
      - name: Download Coverity Build Tool
         if: steps=2Echeck_submi=
t=2Eoutputs=2Ecache-hit !=3D 'true'
diff --git a/=2Egithub/workflows/doxyge=
n=2Eyml b/=2Egithub/workflows/doxygen=2Eyml
index 30988b5=2E=2E3755b92 1006=
44
--- a/=2Egithub/workflows/doxygen=2Eyml
+++ b/=2Egithub/workflows/doxyge=
n=2Eyml
@@ -11,7 +11,7 @@
     runs-on: ubuntu-24=2E04
     if: ${{ github=
=2Erepository_owner =3D=3D 'openvpn' || github=2Eevent_name =3D=3D 'workflo=
w_dispatch' }}
     steps:
-      - uses: actions/checkout@de0fac2e4500dabe=
0009e67214ff5f5447ce83dd # v6=2E0=2E2
+      - uses: actions/checkout@df4cb=
1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
         with:
           =
path: openvpn
 
diff --git a/=2Egithub/workflows/test-ssllib=2Eyml b/=2Egit=
hub/workflows/test-ssllib=2Eyml
index c6a2e44=2E=2Ed8178a7 100644
--- a/=2E=
github/workflows/test-ssllib=2Eyml
+++ b/=2Egithub/workflows/test-ssllib=2E=
yml
@@ -77,7 +77,7 @@
           key: ${{matrix=2Eos}}-${{inputs=2Elibname}=
}-${{matrix=2Ebuild }}-${{inputs=2Egitref}}
       - name: "${{inputs=2Elib=
name}}: checkout"
         if: steps=2Essllib-cache=2Eoutputs=2Ecache-hit !=
=3D 'true'
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f54=
47ce83dd # v6=2E0=2E2
+        uses: actions/checkout@df4cb1c069e1874edd31b=
4311f1884172cec0e10 # v6=2E0=2E3
         with:
           submodules: recu=
rsive
           path: ${{inputs=2Elibname}}
@@ -98,7 +98,7 @@
       - nam=
e: Run ldconfig
         run: sudo ldconfig
       - name: "OpenVPN: checko=
ut"
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83d=
d # v6=2E0=2E2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f18=
84172cec0e10 # v6=2E0=2E3
       - name: "OpenVPN: autoreconf"
         run=
: autoreconf -fvi
       - name: "OpenVPN: configure"

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1710?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I11fc104878ba244c5be04ce8019695b6892c445=
7
Gerrit-Change-Number: 1710
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--H0TsT1lP7Tc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1710?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">GHA: Maintenance update June 2026<br><br>Contains the following renova=
te updates:<br>- chore(deps): update github actions<br>- chore(deps): updat=
e vcpkg digest to 75672db<br>- chore(deps): update dependency aws/aws-lc to=
 v5<br>- chore(deps): update dependency libressl/portable to v4=2E3=2E2<br>=
<br>Change-Id: I11fc104878ba244c5be04ce8019695b6892c4457<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M =2Egithub/wor=
kflows/build=2Eyaml<br>M =2Egithub/workflows/coverity-scan=2Eyml<br>M =2Egi=
thub/workflows/doxygen=2Eyml<br>M =2Egithub/workflows/test-ssllib=2Eyml<br>=
4 files changed, 20 insertions(+), 20 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/171=
0/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workf=
lows/build=2Eyaml</span><br><span>index b530fcc=2E=2E323645a 100644</span><=
br><span>--- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egi=
thub/workflows/build=2Eyaml</span><br><span>@@ -14,7 +14,7 @@</span><br><sp=
an>           sudo apt update &amp;&amp; sudo apt install -y python3-pip</s=
pan><br><span>           pip3 install pre-commit</span><br><span>       - n=
ame: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v=
6=2E0=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3<=
/span><br><span>       - name: Run clang-format</span><br><span>         ru=
n: pre-commit run -a --show-diff-on-failure || true</span><br><span>       =
- name: Check for changes</span><br><span>@@ -43,11 +43,11 @@</span><br><sp=
an>       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg</span><br><span>     =
  VCPKG_INSTALLED_DIR: ${{ github=2Eworkspace }}/vcpkg/installed</span><br>=
<span>       VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      VCPKG_GIT_COMMIT_ID: 031f4afe03b=
e385aee354f15be6e6b1fe57497c7</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f=
07</span><br><span>     steps:</span><br><span>       - name: Checkout Open=
VPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: acti=
ons/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@=
7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v4=2E3=2E2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c069=
e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@591817e96fcad43505fb4=
eae36172462abb3a42e # v4=2E3=2E3</span><br><span>       - name: Setup vcpkg=
</span><br><span>         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a0=
3bd7a427fb6a2 # v11=2E6</span><br><span>         with:</span><br><span>@@ -=
84,14 +84,14 @@</span><br><span>     env:</span><br><span>       VCPKG_ROOT=
: ${{ github=2Eworkspace }}/vcpkg</span><br><span>       VCPKG_BINARY_SOURC=
ES: clear;default,readwrite</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_COMMI=
T_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07</span><br><span>     steps:<=
/span><br><span>       - name: Install dependencies</span><br><span>       =
  run: sudo apt update &amp;&amp; sudo apt install -y mingw-w64 unzip build=
-essential wget python3-docutils man2html-base</span><br><span>       - nam=
e: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=
=2E0=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        use=
s: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
 - uses: lukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v4=2E3=
=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: l=
ukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3</span>=
<br><span>       - name: Setup vcpkg</span><br><span>         uses: lukka/r=
un-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6</span><br><span=
>         with:</span><br><span>@@ -142,7 +142,7 @@</span><br><span>     na=
me: &quot;mingw unittest ${{ matrix=2Etest }} - ${{ matrix=2Earch }} - ${{ =
matrix=2Ebuild }} - OSSL&quot;</span><br><span>     steps:</span><br><span>=
       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447=
ce83dd # v6=2E0=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v=
6=2E0=2E3</span><br><span>       - name: Retrieve mingw unittest</span><br>=
<span>         uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8=
e0b5a5461e7c # v8=2E0=2E1</span><br><span>         with:</span><br><span>@@=
 -183,7 +183,7 @@</span><br><span>       - name: Install dependencies</span=
><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y lib=
lzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-=
dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSL=
PKG} ${PKCS11PKG}</span><br><span>       - name: Checkout OpenVPN</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@=
de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c069=
e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>       - name: =
autoconf</span><br><span>         run: autoreconf -fvi</span><br><span>    =
   - name: configure</span><br><span>@@ -213,7 +213,7 @@</span><br><span>  =
     - name: Install dependencies</span><br><span>         run: sudo apt up=
date &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev lib=
cap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev pyt=
hon3-docutils libtool automake autoconf</span><br><span>       - name: Chec=
kout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u=
ses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br=
><span>       - name: autoconf</span><br><span>         run: autoreconf -fv=
i</span><br><span>       - name: configure</span><br><span>@@ -253,7 +253,7=
 @@</span><br><span>       - name: Install dependencies</span><br><span>   =
      run: brew install ${{matrix=2Essllib}} lzo lz4 man2html cmocka libtoo=
l automake autoconf</span><br><span>       - name: Checkout OpenVPN</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkou=
t@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c0=
69e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>       - name=
: Set environment</span><br><span>         run: |</span><br><span>         =
  cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span>@@ -283,12 +283,12 @=
@</span><br><span>       env:</span><br><span>         BUILD_CONFIGURATION:=
 Release</span><br><span>         VCPKG_BINARY_SOURCES: clear;default,readw=
rite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        VCPKG_GIT=
_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VCPKG_GIT_COMMIT_ID: 75672db6bd81=
2b060482b0f00b5a16b18a0c0f07</span><br><span> </span><br><span>       runs-=
on: windows-2025</span><br><span>       steps:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      - uses: actions/checkout@de0fac2e4500dabe000=
9e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      - uses: lukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3=
e222be3c # v4=2E3=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 #=
 v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - =
uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3=
</span><br><span> </span><br><span>       - name: Install rst2html</span><b=
r><span>         run: python -m pip install --upgrade pip docutils</span><b=
r><span>@@ -342,7 +342,7 @@</span><br><span>       ovpnlibdesc: LibreSSL</s=
pan><br><span>       # versioning=3Dsemver-coerced</span><br><span>       g=
hrepo: libressl/portable</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-      gitref: v4=2E2=2E1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      gitref: v4=2E3=2E2</span><br><span>       libconfigure: &quot=
;LIBRESSL_GIT_OPTIONS=3D--no-single-branch =2E/autogen=2Esh &amp;&amp; =2E/=
configure --prefix=3D$LIBPREFIX&quot;</span><br><span> </span><br><span>   =
openssl4:</span><br><span>@@ -376,7 +376,7 @@</span><br><span>       ovpnli=
bdesc: AWS-LC</span><br><span>       # versioning=3Dsemver-coerced</span><b=
r><span>       ghrepo: aws/aws-lc</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      gitref: v1=2E70=2E0</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      gitref: v5=2E0=2E0</span><br><span>       libconfig=
ure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PR=
EFIX=3D&quot;$LIBPREFIX&quot; -DBUILD_SHARED_LIBS=3D1</span><br><span>     =
  libmake: cmake --build build</span><br><span>       libinstall: sudo cmak=
e --install build</span><br><span>diff --git a/=2Egithub/workflows/coverity=
-scan=2Eyml b/=2Egithub/workflows/coverity-scan=2Eyml</span><br><span>index=
 1eec1ed=2E=2E105f23e 100644</span><br><span>--- a/=2Egithub/workflows/cove=
rity-scan=2Eyml</span><br><span>+++ b/=2Egithub/workflows/coverity-scan=2Ey=
ml</span><br><span>@@ -25,7 +25,7 @@</span><br><span> </span><br><span>    =
   - name: Checkout OpenVPN</span><br><span>         if: steps=2Echeck_subm=
it=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        uses: actions/checkout@de0fac2e4500dabe0009e=
67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uses: actions/checkout@df4cb1c069e1874edd31b4311f18841=
72cec0e10 # v6=2E0=2E3</span><br><span> </span><br><span>       - name: Dow=
nload Coverity Build Tool</span><br><span>         if: steps=2Echeck_submit=
=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span>diff --git a/=2E=
github/workflows/doxygen=2Eyml b/=2Egithub/workflows/doxygen=2Eyml</span><b=
r><span>index 30988b5=2E=2E3755b92 100644</span><br><span>--- a/=2Egithub/w=
orkflows/doxygen=2Eyml</span><br><span>+++ b/=2Egithub/workflows/doxygen=2E=
yml</span><br><span>@@ -11,7 +11,7 @@</span><br><span>     runs-on: ubuntu-=
24=2E04</span><br><span>     if: ${{ github=2Erepository_owner =3D=3D &#39;=
openvpn&#39; || github=2Eevent_name =3D=3D &#39;workflow_dispatch&#39; }}</=
span><br><span>     steps:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-      - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83d=
d # v6=2E0=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=
=2E3</span><br><span>         with:</span><br><span>           path: openvp=
n</span><br><span> </span><br><span>diff --git a/=2Egithub/workflows/test-s=
sllib=2Eyml b/=2Egithub/workflows/test-ssllib=2Eyml</span><br><span>index c=
6a2e44=2E=2Ed8178a7 100644</span><br><span>--- a/=2Egithub/workflows/test-s=
sllib=2Eyml</span><br><span>+++ b/=2Egithub/workflows/test-ssllib=2Eyml</sp=
an><br><span>@@ -77,7 +77,7 @@</span><br><span>           key: ${{matrix=2E=
os}}-${{inputs=2Elibname}}-${{matrix=2Ebuild }}-${{inputs=2Egitref}}</span>=
<br><span>       - name: &quot;${{inputs=2Elibname}}: checkout&quot;</span>=
<br><span>         if: steps=2Essllib-cache=2Eoutputs=2Ecache-hit !=3D &#39=
;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        use=
s: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions=
/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><=
span>         with:</span><br><span>           submodules: recursive</span>=
<br><span>           path: ${{inputs=2Elibname}}</span><br><span>@@ -98,7 +=
98,7 @@</span><br><span>       - name: Run ldconfig</span><br><span>       =
  run: sudo ldconfig</span><br><span>       - name: &quot;OpenVPN: checkout=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: a=
ctions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/che=
ckout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span=
>       - name: &quot;OpenVPN: autoreconf&quot;</span><br><span>         ru=
n: autoreconf -fvi</span><br><span>       - name: &quot;OpenVPN: configure&=
quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1710?usp=3Demail">change 1710</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1710?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I11fc104878ba2=
44c5be04ce8019695b6892c4457 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1710 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>

</body></html>
--H0TsT1lP7Tc=--


--===============8363698926440948263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8363698926440948263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8363698926440948263==--

