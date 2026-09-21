Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146E9C982ED
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=nY9MVEnBIBj90jvycWUm4AqZ1VTxic/iZCZFASxdjcE=; b=Lrqay2evkWBOXk
	ZJWdo0hhg+YJhohmHqwt99J1/KosXCeZagZvXAvIgBJ2oa8ECs9WY0F4JubOJusedzJZidLuxudbN
	xWE31tRgNhqpnIP704sJSzuZzB9R7hceaUf7v7NneHbPxcuNlDXxS3qyxm/SZlXMJISU8y3y8dNQ5
	ekU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8gR0-00017E-5C;
	Mon, 21 Sep 2026 16:00:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8gQv-000168-NX
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 15:59:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kRbTvbyyzOOxGfXOhrylvYYimy3ycIo4o4STZ9v/Mx4=; b=F6mxZE/Tk95AaGTfTUWpQVe56a
 4ElKE5mahRqd49IIY2TSiMdAjby0GiLTvti2GyxewqtPXoASUqDrg7Pp6whJHiR6posHZ1U4FPSL8
 97SNR9uMCjdrlghmzPHG1oG8ebc+1GRegqlVOGai7uYTvbfutHCpAJ54ZTlWuCRgvZUA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kRbTvbyyzOOxGfXOhrylvYYimy3ycIo4o4STZ9v/Mx4=; b=i
 ZQxI4KrukBWJq6yV6SR7kgKqSbtmQzmHR96Z3BZ6pt/ZeyMAfBJ5qhpXGWJJgxcAk59Y7hJsk+8Tj
 vfHcZj0EwYauRmcGIIVOrYV8n56o5QxyGTRZvh9B/uHhltF/kHInjsV8qbKUaEMxDcNpzXFGCNeBS
 CMAFjH/cO7aUPvTI=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8gQt-0006hL-3i for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 15:59:58 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485984ebf5cso2523529f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790006388; x=1790611188; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kRbTvbyyzOOxGfXOhrylvYYimy3ycIo4o4STZ9v/Mx4=;
 b=eK4Mqspdt9gx2qtcBdtX80FVPZZsM8H9A275Mh2CAa3ptt2x7MZug7s1X5xWPEeakP
 +dpjiczEjhSSHy1JTBuZWGVZhxoScn+0V1ON56BjfPU1YdQAinyqwoOZfeLaEFmm0g3B
 JHAauOoGdhkXMvQ1rs6H7AVCGI2boYv19/dvLD1TD6IXzwgOfl3RWw2ZhKmSSnK2Gd0Y
 XTvOSH93Kz8SK825TtMKmrPilanIN7YKNbGj0DAv6lbtApn9n47GzkhoCumctZXw6FLq
 +0kMQIZV361ssTgP7c80BSPRUhmIwo8D6D4jTrYlUmlLD5s3NPKJNdWDFXeI++KfrhJo
 zKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006388; x=1790611188;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kRbTvbyyzOOxGfXOhrylvYYimy3ycIo4o4STZ9v/Mx4=;
 b=TD0oJiFQM+VqxEsLniNLkmVK0xHjm6b7d1mg9j0+yBJ/QE+oRZzD3IsKlfgwxtrGA7
 E8xmdr1CeqpWEU001oTXsorKiEyV1yybHiXnubVFckSp1dsgePLzT/9EO+e9G9vdXSMT
 mbprMRNi2jvC9zM2KHF68XWzoadXMslKNSWvlpsfXKct/b0HPU/Mj1LolXQImKibZ33V
 JSzCVFWXW2rCGcZh9QY6WkDTCn8FzwyP3TSPtvzenMrxjuQQGJ9oFRE6zkWkCpvr6N2t
 37Yz7oGdrj20la3Z3jyuxeCex0nfblJ7pNUoR5yGUOx2mcDYjw98Dv9u/7S9m0/aTQul
 a3RA==
X-Gm-Message-State: AFuF++ldO5guH1bhRcKnZot9yVnwPOdqxUfkMjZPe7LWa9nisPifvNNM
 +YoGbnD+i26Gle4uuGzbfWuvKVRjx3UP1ru1QGSm/T+1+a2Y7kAAQ8VtpaHlsh8OQ2EPetrT7dV
 Vn8/aeCJcIgfg4QnH1gFZOTIqL3t9/40+eZVlHW7N4o5qq8SEcKHY3y7zZrJBuEQ1u4pq0e3TU9
 dISPZVEw==
X-Gm-Gg: AYBFou27fRpJqqZiHxBQo6wRxRt4MF1DzZj+B5JhzLbZEaoMkW/kcSIZOcZjecsaP/t
 Dws98+ozJsJ8Gxd6bXBpxYrPUCFkwTMdYe0qJ2E44BVZVbMQLwXPMvApUGeIsr9gLV55Hfc4JA0
 mOFRS9v/xWc7+MRN5jkwgv9XZnvwIJwAEs11av77S9pSosHtm+bgrMfrlAzYUzAPAxhhUIzCou2
 nrb4DYvfF/JE7mlocHx/KkH7B36/tL3qJO+5j2Nu/AO+LHLq8i4LP4zrUNoD/O1QQ5SDOWo5hFl
 T9ZLvwUiqdoOEJXCXr1zcZVURm6jKcns1xGJ2+xWo4NDf287/Y9nhShHmoCvMIquS6bxUlOd97r
 ticbVAk8umeaXndJC0lWndwT7rrhaceBtrFyVNlh1U5yu6U/Epmxgk6PZlcbLiOZ30J+BNw+81t
 1Hd8gKne35qobT+0rcfR3eqDq2UYdMzY3NydJmyjZH9bY+gVpxZ4q/MMA10ivtprdJNxhy+YciU
 xaefvhRC1TDfGiv+atvsoiqS5IL0Xo8z2wE0wesP+EjPEb14ODFr/OfT4EA2PTEi6ZFXmGTffFG
 6NBur/R3bLcKDAvSs/mjLagDETeak1kprkGaXKWkFddKyJCHew03ScZtmNVu
X-Received: by 2002:a05:6000:2409:b0:487:6ef:86b8 with SMTP id
 ffacd0b85a97d-4871e3b6afbmr19452635f8f.49.1790006388242; 
 Mon, 21 Sep 2026 08:59:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724460767sm23435819f8f.13.2026.09.21.08.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:59:47 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 15:59:46 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
X-Gerrit-Change-Number: 1922
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1922?usp=email>
X-Gerrit-Commit: 078b58f0e0242b2d05125c12db4ed8592b14ae8e
References: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDA2MzgxMDAwLkk5ODNkNjdlMWM5MGJlYTQ2MGY1MzFmMTFkNGM1OGQzM2EzNTFkODFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bb5108304200cc6347fcbf975741f8ced0eda09d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8gQt-0006hL-3i
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Maintenance
 update September 2026
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
Content-Type: multipart/mixed; boundary="===============1904145364228204673=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1904145364228204673==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MD9WjErLn3w="; charset=UTF-8

--MD9WjErLn3w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1922?usp=3Demail

to review the following change=2E


Chang=
e subject: GHA: Maintenance update September 2026
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Maintenance update September 202=
6

Contains the following renovate updates:
- chore(deps): update vcpkg dig=
est to 5f96cd1
- Update dependency ubuntu to v26
- chore(deps): update depe=
ndency aws/aws-lc to v5=2E9=2E0
- chore(deps): update github actions
- Upda=
te github actions (major)

Change-Id: I983d67e1c90bea460f531f11d4c58d33a351=
d81b
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M =2Egi=
thub/workflows/build=2Eyaml
M =2Egithub/workflows/coverity-scan=2Eyml
M =2E=
github/workflows/doxygen=2Eyml
M =2Egithub/workflows/test-ssllib=2Eyml
4 fi=
les changed, 30 insertions(+), 30 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/22/1922/1

diff --git a/=2Egith=
ub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml
index d67c215=
=2E=2Ef568a11 100644
--- a/=2Egithub/workflows/build=2Eyaml
+++ b/=2Egithub=
/workflows/build=2Eyaml
@@ -7,14 +7,14 @@
 jobs:
   clang-format:
     name=
: Check code style with clang-format
-    runs-on: ubuntu-24=2E04
+    runs=
-on: ubuntu-26=2E04
     steps:
       - name: Install dependencies
       =
  run: |
           sudo apt update && sudo apt install -y python3-pip
    =
       pip3 install pre-commit
       - name: Checkout OpenVPN
-        use=
s: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+=
        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v=
7=2E0=2E1
       - name: Run clang-format
         run: pre-commit run -a -=
-show-diff-on-failure || true
       - name: Check for changes
@@ -34,7 +34=
,7 @@
         include:
           - abi: arm64-v8a
             vcpkg_trip=
let: arm64-android
-    runs-on: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E0=
4
     name: "Android - ${{ matrix=2Eabi }}"
     # Github images already s=
etup NDK with ANDROID_NDK_ROOT pointing to the root
     # of the SDK
@@ -4=
3,17 +43,17 @@
       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg
       VC=
PKG_INSTALLED_DIR: ${{ github=2Eworkspace }}/vcpkg/installed
       VCPKG_B=
INARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 75672db6=
bd812b060482b0f00b5a16b18a0c0f07
+      VCPKG_GIT_COMMIT_ID: 5f96cd15fd7451=
22cf27e0524606d6c1efc5fd07
     steps:
       - name: Checkout OpenVPN
-   =
     uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=
=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273=
ba90b1 # v7=2E0=2E1
       - uses: lukka/get-cmake@591817e96fcad43505fb4eae=
36172462abb3a42e # v4=2E3=2E3
       - name: Setup vcpkg
         uses: luk=
ka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
         wi=
th:
           vcpkgGitCommitId: ${{ env=2EVCPKG_GIT_COMMIT_ID }}
       - =
name: Set up vcpkg binary cache
-        uses: actions/cache@27d5ce7f107fe9=
357f9df03efb73ab90386fccae # v5=2E0=2E5
+        uses: actions/cache@55cc83=
45863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
         with:
           p=
ath: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}
           key: android-${{ ma=
trix=2Eabi }}-vcpkg-binary-cache-${{ env=2EVCPKG_GIT_COMMIT_ID }}
@@ -82,18=
 +82,18 @@
         build: [Release, Debug]
 
     name: "gcc-mingw - ${{ m=
atrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL"
-    runs-on: ubuntu-24=2E0=
4
+    runs-on: ubuntu-26=2E04
     env:
       VCPKG_ROOT: ${{ github=2Ewo=
rkspace }}/vcpkg
       VCPKG_BINARY_SOURCES: clear;default,readwrite
-    =
  VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
+      VCPK=
G_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
     steps:
     =
  - name: Install dependencies
         run: sudo apt update && sudo apt in=
stall -y mingw-w64 unzip build-essential wget python3-docutils man2html-bas=
e
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c06=
9e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/checkou=
t@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
 
-      - uses: lu=
kka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3
+      =
- uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4=2E4=
=2E2
       - name: Setup vcpkg
         uses: lukka/run-vcpkg@b1a0dd252f06=
b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
         with:
@@ -101,7 +101,7 @@
 =
          vcpkgJsonGlob: '**/mingw/vcpkg=2Ejson'
 
       - name: Set up vc=
pkg binary cache
-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73a=
b90386fccae # v5=2E0=2E5
+        uses: actions/cache@55cc8345863c7cc4c66a3=
29aec7e433d2d1c52a9 # v6=2E1=2E0
         with:
           path: ${{ env=2E=
VCPKG_DEFAULT_BINARY_CACHE }}
           key: mingw-${{ matrix=2Earch }}-vc=
pkg-binary-cache-${{ hashFiles('**/mingw/vcpkg=2Ejson') }}-${{ env=2EVCPKG_=
GIT_COMMIT_ID }}
@@ -144,7 +144,7 @@
     name: "mingw unittest ${{ matrix=
=2Etest }} - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL"
     step=
s:
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c0=
69e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/checko=
ut@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
       - name: Ret=
rieve mingw unittest
         uses: actions/download-artifact@3e5f45b2cfb91=
72054b4087a40e8e0b5a5461e7c # v8=2E0=2E1
         with:
@@ -185,7 +185,7 @@=

       - name: Install dependencies
         run: sudo apt update && sudo =
apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl=
-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool autom=
ake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-      =
  uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=
=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90=
b1 # v7=2E0=2E1
       - name: autoconf
         run: autoreconf -fvi
     =
  - name: configure
@@ -215,7 +215,7 @@
       - name: Install dependencies=

         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-=
dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang=
 libcmocka-dev python3-docutils libtool automake autoconf
       - name: Ch=
eckout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f18=
84172cec0e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805=
825da76410c181273ba90b1 # v7=2E0=2E1
       - name: autoconf
         run: =
autoreconf -fvi
       - name: configure
@@ -255,7 +255,7 @@
       - name:=
 Install dependencies
         run: brew install ${{matrix=2Essllib}} lzo l=
z4 man2html cmocka libtool automake autoconf
       - name: Checkout OpenVP=
N
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 =
# v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c18=
1273ba90b1 # v7=2E0=2E1
       - name: Set environment
         run: |
    =
       cat >>$GITHUB_ENV <<EOF;
@@ -285,11 +285,11 @@
       env:
         =
BUILD_CONFIGURATION: Release
         VCPKG_BINARY_SOURCES: clear;default,r=
eadwrite
-        VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c=
0f07
+        VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07=

 
       runs-on: windows-2025-vs2026
       steps:
-      - uses: actions=
/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+      - us=
es: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
=
       - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v=
4=2E3=2E3
 
       - name: Install rst2html
@@ -302,7 +302,7 @@
           =
vcpkgJsonGlob: '**/windows/vcpkg=2Ejson'
 
       - name: Set up vcpkg bina=
ry cache
-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fc=
cae # v5=2E0=2E5
+        uses: actions/cache@55cc8345863c7cc4c66a329aec7e4=
33d2d1c52a9 # v6=2E1=2E0
         with:
           path: ${{ env=2EVCPKG_DE=
FAULT_BINARY_CACHE }}
           key: msvc-${{ matrix=2Earch }}-vcpkg-binar=
y-cache-${{ hashFiles('**/windows/vcpkg=2Ejson') }}-${{ env=2EVCPKG_GIT_COM=
MIT_ID }}
@@ -380,7 +380,7 @@
       ovpnlibdesc: AWS-LC
       # versionin=
g=3Dsemver-coerced
       ghrepo: aws/aws-lc
-      gitref: v5=2E0=2E0
+   =
   gitref: v5=2E9=2E0
       libconfigure: cmake -B build -GNinja -DCMAKE_B=
UILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D"$LIBPREFIX" -DBUILD_SHARED_LI=
BS=3D1
       libmake: cmake --build build
       libinstall: sudo cmake --=
install build
\ No newline at end of file
diff --git a/=2Egithub/workflows/=
coverity-scan=2Eyml b/=2Egithub/workflows/coverity-scan=2Eyml
index 105f23e=
=2E=2Ee103aec 100644
--- a/=2Egithub/workflows/coverity-scan=2Eyml
+++ b/=
=2Egithub/workflows/coverity-scan=2Eyml
@@ -9,11 +9,11 @@
     # Running co=
verity requires the secrets=2ECOVERITY_SCAN_TOKEN token
     # which is onl=
y available on the main repository
     if: github=2Erepository_owner =3D=
=3D 'OpenVPN'
-    runs-on: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E04
   =
  steps:
       - name: Check submission cache
         id: check_submit
- =
       uses: actions/cache/restore@27d5ce7f107fe9357f9df03efb73ab90386fccae=
 # v5=2E0=2E5
+        uses: actions/cache/restore@55cc8345863c7cc4c66a329a=
ec7e433d2d1c52a9 # v6=2E1=2E0
         with:
           path: |
           =
  cov-int
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenVPN
         if: =
steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'true'
-        uses: actio=
ns/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        =
uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E=
1
 
       - name: Download Coverity Build Tool
         if: steps=2Echeck_=
submit=2Eoutputs=2Ecache-hit !=3D 'true'
@@ -65,7 +65,7 @@
 
       - name:=
 Cache submission
         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=
=3D 'true'
-        uses: actions/cache/save@27d5ce7f107fe9357f9df03efb73ab=
90386fccae # v5=2E0=2E5
+        uses: actions/cache/save@55cc8345863c7cc4c=
66a329aec7e433d2d1c52a9 # v6=2E1=2E0
         with:
           path: |
    =
         cov-int
diff --git a/=2Egithub/workflows/doxygen=2Eyml b/=2Egithub=
/workflows/doxygen=2Eyml
index 3755b92=2E=2E379b21c 100644
--- a/=2Egithub/=
workflows/doxygen=2Eyml
+++ b/=2Egithub/workflows/doxygen=2Eyml
@@ -8,10 +8=
,10 @@
   cancel-in-progress: false
 jobs:
   build:
-    runs-on: ubuntu-2=
4=2E04
+    runs-on: ubuntu-26=2E04
     if: ${{ github=2Erepository_owner =
=3D=3D 'openvpn' || github=2Eevent_name =3D=3D 'workflow_dispatch' }}
     =
steps:
-      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec=
0e10 # v6=2E0=2E3
+      - uses: actions/checkout@3d3c42e5aac5ba805825da764=
10c181273ba90b1 # v7=2E0=2E1
         with:
           path: openvpn
 
@@ -=
47,8 +47,8 @@
     environment:
       name: github-pages
       url: ${{ s=
teps=2Edeployment=2Eoutputs=2Epage_url }}
-    runs-on: ubuntu-24=2E04
+   =
 runs-on: ubuntu-26=2E04
     steps:
       - name: Deploy to GitHub Pages
=
         id: deployment
-        uses: actions/deploy-pages@cd2ce8fcbc39b97=
be8ca5fce6e763baed58fa128 # v5
+        uses: actions/deploy-pages@368f8252=
8645a54fb793d4d04e342629a3f51346 # v5
diff --git a/=2Egithub/workflows/test=
-ssllib=2Eyml b/=2Egithub/workflows/test-ssllib=2Eyml
index d8178a7=2E=2E64=
607cf 100644
--- a/=2Egithub/workflows/test-ssllib=2Eyml
+++ b/=2Egithub/wo=
rkflows/test-ssllib=2Eyml
@@ -70,14 +70,14 @@
       - name: Install depend=
encies
         run: sudo apt update && sudo apt install -y liblzo2-dev lib=
pam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-do=
cutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
=
       - name: Restore ${{inputs=2Elibname}} from cache
-        uses: acti=
ons/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+        us=
es: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
   =
      id: ssllib-cache
         with:
           path: ${{env=2ELIBPREFIX}}=

           key: ${{matrix=2Eos}}-${{inputs=2Elibname}}-${{matrix=2Ebuild }=
}-${{inputs=2Egitref}}
       - name: "${{inputs=2Elibname}}: checkout"
   =
      if: steps=2Essllib-cache=2Eoutputs=2Ecache-hit !=3D 'true'
-        u=
ses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3=

+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 #=
 v7=2E0=2E1
         with:
           submodules: recursive
           path=
: ${{inputs=2Elibname}}
@@ -98,7 +98,7 @@
       - name: Run ldconfig
     =
    run: sudo ldconfig
       - name: "OpenVPN: checkout"
-        uses: ac=
tions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+     =
   uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=
=2E1
       - name: "OpenVPN: autoreconf"
         run: autoreconf -fvi
   =
    - name: "OpenVPN: configure"

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1922?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
Gerrit-Change-Numbe=
r: 1922
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>

--MD9WjErLn3w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">GHA: Maintenance update September 2026<br><br>Contains the following r=
enovate updates:<br>- chore(deps): update vcpkg digest to 5f96cd1<br>- Upda=
te dependency ubuntu to v26<br>- chore(deps): update dependency aws/aws-lc =
to v5=2E9=2E0<br>- chore(deps): update github actions<br>- Update github ac=
tions (major)<br><br>Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<b=
r>M =2Egithub/workflows/build=2Eyaml<br>M =2Egithub/workflows/coverity-scan=
=2Eyml<br>M =2Egithub/workflows/doxygen=2Eyml<br>M =2Egithub/workflows/test=
-ssllib=2Eyml<br>4 files changed, 30 insertions(+), 30 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/22/1922/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/=2Egithub/workflows/build=2Eyaml b=
/=2Egithub/workflows/build=2Eyaml</span><br><span>index d67c215=2E=2Ef568a1=
1 100644</span><br><span>--- a/=2Egithub/workflows/build=2Eyaml</span><br><=
span>+++ b/=2Egithub/workflows/build=2Eyaml</span><br><span>@@ -7,14 +7,14 =
@@</span><br><span> jobs:</span><br><span>   clang-format:</span><br><span>=
     name: Check code style with clang-format</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=2E04</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-26=2E04</span><br><sp=
an>     steps:</span><br><span>       - name: Install dependencies</span><b=
r><span>         run: |</span><br><span>           sudo apt update &amp;&am=
p; sudo apt install -y python3-pip</span><br><span>           pip3 install =
pre-commit</span><br><span>       - name: Checkout OpenVPN</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c=
069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805=
825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>       - name: Run cla=
ng-format</span><br><span>         run: pre-commit run -a --show-diff-on-fa=
ilure || true</span><br><span>       - name: Check for changes</span><br><s=
pan>@@ -34,7 +34,7 @@</span><br><span>         include:</span><br><span>   =
        - abi: arm64-v8a</span><br><span>             vcpkg_triplet: arm64-=
android</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: u=
buntu-24=2E04</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ru=
ns-on: ubuntu-26=2E04</span><br><span>     name: &quot;Android - ${{ matrix=
=2Eabi }}&quot;</span><br><span>     # Github images already setup NDK with=
 ANDROID_NDK_ROOT pointing to the root</span><br><span>     # of the SDK</s=
pan><br><span>@@ -43,17 +43,17 @@</span><br><span>       VCPKG_ROOT: ${{ gi=
thub=2Eworkspace }}/vcpkg</span><br><span>       VCPKG_INSTALLED_DIR: ${{ g=
ithub=2Eworkspace }}/vcpkg/installed</span><br><span>       VCPKG_BINARY_SO=
URCES: clear;default,readwrite</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f0=
7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_CO=
MMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07</span><br><span>     step=
s:</span><br><span>       - name: Checkout OpenVPN</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874=
edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da764=
10c181273ba90b1 # v7=2E0=2E1</span><br><span>       - uses: lukka/get-cmake=
@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><span>    =
   - name: Setup vcpkg</span><br><span>         uses: lukka/run-vcpkg@b1a0d=
d252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6</span><br><span>         with=
:</span><br><span>           vcpkgGitCommitId: ${{ env=2EVCPKG_GIT_COMMIT_I=
D }}</span><br><span>       - name: Set up vcpkg binary cache</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache@27d5ce7=
f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        uses: actions/cache@55cc8345863c7cc4c66a=
329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         with:</span><br>=
<span>           path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}</span><br><s=
pan>           key: android-${{ matrix=2Eabi }}-vcpkg-binary-cache-${{ env=
=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>@@ -82,18 +82,18 @@</span><br><sp=
an>         build: [Release, Debug]</span><br><span> </span><br><span>     =
name: &quot;gcc-mingw - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: ub=
untu-24=2E04</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run=
s-on: ubuntu-26=2E04</span><br><span>     env:</span><br><span>       VCPKG=
_ROOT: ${{ github=2Eworkspace }}/vcpkg</span><br><span>       VCPKG_BINARY_=
SOURCES: clear;default,readwrite</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0=
f07</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_=
COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07</span><br><span>     st=
eps:</span><br><span>       - name: Install dependencies</span><br><span>  =
       run: sudo apt update &amp;&amp; sudo apt install -y mingw-w64 unzip =
build-essential wget python3-docutils man2html-base</span><br><span>       =
- name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 =
# v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=
=2E1</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v=
4=2E3=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - us=
es: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4=2E4=2E2</=
span><br><span>       - name: Setup vcpkg</span><br><span>         uses: lu=
kka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6</span><br>=
<span>         with:</span><br><span>@@ -101,7 +101,7 @@</span><br><span>  =
         vcpkgJsonGlob: &#39;**/mingw/vcpkg=2Ejson&#39;</span><br><span> </=
span><br><span>       - name: Set up vcpkg binary cache</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache@27d5ce7f107fe=
9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        uses: actions/cache@55cc8345863c7cc4c66a329aec=
7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         with:</span><br><span>=
           path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}</span><br><span>  =
         key: mingw-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles(&=
#39;**/mingw/vcpkg=2Ejson&#39;) }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><=
br><span>@@ -144,7 +144,7 @@</span><br><span>     name: &quot;mingw unittes=
t ${{ matrix=2Etest }} - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSS=
L&quot;</span><br><span>     steps:</span><br><span>       - name: Checkout=
 OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses:=
 actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/c=
heckout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><sp=
an>       - name: Retrieve mingw unittest</span><br><span>         uses: ac=
tions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8=2E0=
=2E1</span><br><span>         with:</span><br><span>@@ -185,7 +185,7 @@</sp=
an><br><span>       - name: Install dependencies</span><br><span>         r=
un: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev=
 liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmock=
a-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}</sp=
an><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874edd31b=
4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181=
273ba90b1 # v7=2E0=2E1</span><br><span>       - name: autoconf</span><br><s=
pan>         run: autoreconf -fvi</span><br><span>       - name: configure<=
/span><br><span>@@ -215,7 +215,7 @@</span><br><span>       - name: Install =
dependencies</span><br><span>         run: sudo apt update &amp;&amp; sudo =
apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl=
-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool=
 automake autoconf</span><br><span>       - name: Checkout OpenVPN</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout=
@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5a=
ac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>       - name:=
 autoconf</span><br><span>         run: autoreconf -fvi</span><br><span>   =
    - name: configure</span><br><span>@@ -255,7 +255,7 @@</span><br><span> =
      - name: Install dependencies</span><br><span>         run: brew insta=
ll ${{matrix=2Essllib}} lzo lz4 man2html cmocka libtool automake autoconf</=
span><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874edd3=
1b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c1=
81273ba90b1 # v7=2E0=2E1</span><br><span>       - name: Set environment</sp=
an><br><span>         run: |</span><br><span>           cat &gt;&gt;$GITHUB=
_ENV &lt;&lt;EOF;</span><br><span>@@ -285,11 +285,11 @@</span><br><span>   =
    env:</span><br><span>         BUILD_CONFIGURATION: Release</span><br><s=
pan>         VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        VCPKG_GIT_COMMIT_ID: 75672db6b=
d812b060482b0f00b5a16b18a0c0f07</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1ef=
c5fd07</span><br><span> </span><br><span>       runs-on: windows-2025-vs202=
6</span><br><span>       steps:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172c=
ec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      - uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v=
7=2E0=2E1</span><br><span>       - uses: lukka/get-cmake@591817e96fcad43505=
fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><span> </span><br><span>     =
  - name: Install rst2html</span><br><span>@@ -302,7 +302,7 @@</span><br><s=
pan>           vcpkgJsonGlob: &#39;**/windows/vcpkg=2Ejson&#39;</span><br><=
span> </span><br><span>       - name: Set up vcpkg binary cache</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache@27d5c=
e7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        uses: actions/cache@55cc8345863c7cc4c6=
6a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         with:</span><b=
r><span>           path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}</span><br>=
<span>           key: msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hash=
Files(&#39;**/windows/vcpkg=2Ejson&#39;) }}-${{ env=2EVCPKG_GIT_COMMIT_ID }=
}</span><br><span>@@ -380,7 +380,7 @@</span><br><span>       ovpnlibdesc: A=
WS-LC</span><br><span>       # versioning=3Dsemver-coerced</span><br><span>=
       ghrepo: aws/aws-lc</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-      gitref: v5=2E0=2E0</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      gitref: v5=2E9=2E0</span><br><span>       libconfigure: cmak=
e -B build -GNinja -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D&q=
uot;$LIBPREFIX&quot; -DBUILD_SHARED_LIBS=3D1</span><br><span>       libmake=
: cmake --build build</span><br><span>       libinstall: sudo cmake --insta=
ll build</span><br><span>\ No newline at end of file</span><br><span>diff -=
-git a/=2Egithub/workflows/coverity-scan=2Eyml b/=2Egithub/workflows/coveri=
ty-scan=2Eyml</span><br><span>index 105f23e=2E=2Ee103aec 100644</span><br><=
span>--- a/=2Egithub/workflows/coverity-scan=2Eyml</span><br><span>+++ b/=
=2Egithub/workflows/coverity-scan=2Eyml</span><br><span>@@ -9,11 +9,11 @@</=
span><br><span>     # Running coverity requires the secrets=2ECOVERITY_SCAN=
_TOKEN token</span><br><span>     # which is only available on the main rep=
ository</span><br><span>     if: github=2Erepository_owner =3D=3D &#39;Open=
VPN&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: =
ubuntu-24=2E04</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
uns-on: ubuntu-26=2E04</span><br><span>     steps:</span><br><span>       -=
 name: Check submission cache</span><br><span>         id: check_submit</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cac=
he/restore@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache/re=
store@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span=
>         with:</span><br><span>           path: |</span><br><span>        =
     cov-int</span><br><span>@@ -25,7 +25,7 @@</span><br><span> </span><br>=
<span>       - name: Checkout OpenVPN</span><br><span>         if: steps=2E=
check_submit=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e=
1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805825d=
a76410c181273ba90b1 # v7=2E0=2E1</span><br><span> </span><br><span>       -=
 name: Download Coverity Build Tool</span><br><span>         if: steps=2Ech=
eck_submit=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span>@@ -65=
,7 +65,7 @@</span><br><span> </span><br><span>       - name: Cache submissi=
on</span><br><span>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit =
!=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      uses: actions/cache/save@27d5ce7f107fe9357f9df03efb73ab90386fccae # v=
5=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/cache/save@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E=
0</span><br><span>         with:</span><br><span>           path: |</span><=
br><span>             cov-int</span><br><span>diff --git a/=2Egithub/workfl=
ows/doxygen=2Eyml b/=2Egithub/workflows/doxygen=2Eyml</span><br><span>index=
 3755b92=2E=2E379b21c 100644</span><br><span>--- a/=2Egithub/workflows/doxy=
gen=2Eyml</span><br><span>+++ b/=2Egithub/workflows/doxygen=2Eyml</span><br=
><span>@@ -8,10 +8,10 @@</span><br><span>   cancel-in-progress: false</span=
><br><span> jobs:</span><br><span>   build:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=2E04</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-26=2E04</span><br><span> =
    if: ${{ github=2Erepository_owner =3D=3D &#39;openvpn&#39; || github=2E=
event_name =3D=3D &#39;workflow_dispatch&#39; }}</span><br><span>     steps=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: action=
s/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/checkout=
@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>    =
     with:</span><br><span>           path: openvpn</span><br><span> </span=
><br><span>@@ -47,8 +47,8 @@</span><br><span>     environment:</span><br><s=
pan>       name: github-pages</span><br><span>       url: ${{ steps=2Edeplo=
yment=2Eoutputs=2Epage_url }}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    runs-on: ubuntu-24=2E04</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    runs-on: ubuntu-26=2E04</span><br><span>     steps:</sp=
an><br><span>       - name: Deploy to GitHub Pages</span><br><span>        =
 id: deployment</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  uses: actions/deploy-pages@cd2ce8fcbc39b97be8ca5fce6e763baed58fa128 # v5<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: action=
s/deploy-pages@368f82528645a54fb793d4d04e342629a3f51346 # v5</span><br><spa=
n>diff --git a/=2Egithub/workflows/test-ssllib=2Eyml b/=2Egithub/workflows/=
test-ssllib=2Eyml</span><br><span>index d8178a7=2E=2E64607cf 100644</span><=
br><span>--- a/=2Egithub/workflows/test-ssllib=2Eyml</span><br><span>+++ b/=
=2Egithub/workflows/test-ssllib=2Eyml</span><br><span>@@ -70,14 +70,14 @@</=
span><br><span>       - name: Install dependencies</span><br><span>        =
 run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><=
br><span>       - name: Restore ${{inputs=2Elibname}} from cache</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache@27d5=
ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        uses: actions/cache@55cc8345863c7cc4c=
66a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         id: ssllib-ca=
che</span><br><span>         with:</span><br><span>           path: ${{env=
=2ELIBPREFIX}}</span><br><span>           key: ${{matrix=2Eos}}-${{inputs=
=2Elibname}}-${{matrix=2Ebuild }}-${{inputs=2Egitref}}</span><br><span>    =
   - name: &quot;${{inputs=2Elibname}}: checkout&quot;</span><br><span>    =
     if: steps=2Essllib-cache=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/che=
ckout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c=
42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>         =
with:</span><br><span>           submodules: recursive</span><br><span>    =
       path: ${{inputs=2Elibname}}</span><br><span>@@ -98,7 +98,7 @@</span>=
<br><span>       - name: Run ldconfig</span><br><span>         run: sudo ld=
config</span><br><span>       - name: &quot;OpenVPN: checkout&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkou=
t@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5=
aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>       - name=
: &quot;OpenVPN: autoreconf&quot;</span><br><span>         run: autoreconf =
-fvi</span><br><span>       - name: &quot;OpenVPN: configure&quot;</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1922?usp=3Demail">change 1922</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I983d67e1c90bea460f531f11d=
4c58d33a351d81b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
922 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--MD9WjErLn3w=--


--===============1904145364228204673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1904145364228204673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1904145364228204673==--

