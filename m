Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955B2C982F1
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GIPqo8d8AsTHvktk1tgpGWdrYKiWrauu4g8+7sA50yQ=; b=MocqqB7VyGemYhLBxYXmXZZchr
	pyfcFfQo/qEJufyD0Ahw+MRlPR8iJPLUBFE5FmHzNHsRbaab/jPq0ahrEb2f/Gh+WCEhQENKRq7La
	PmAeiqpHXgtG9MRQq4wfkfpY2sZsWMRShzQyHVHE83l2VY1aMVnvw7GckqmiZMcOivQk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8wmV-0007TY-Mf;
	Tue, 22 Sep 2026 09:27:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8wmU-0007TS-0L
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 09:27:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6bhrhptstQbp+gvoVB3TGPIF/ZqRhp8xFDC7NJZbN7I=; b=Xjvoqy8Eo36Ez3pjMoYKAhKfE7
 7P7ND7r6vRvOX6SGWCmgnFGr6GsqEQIknFcUMK7Os8Feshj51JnXwxdgrMAbxkXrOkY4haZjUGDcO
 zsigQ4xnaL1NhRUoMssjllqTgFutv4f9hOioi67e2Cem4lLDKp/lNsUnB3/Fmse83308=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6bhrhptstQbp+gvoVB3TGPIF/ZqRhp8xFDC7NJZbN7I=; b=S
 xcrC0IYUNa+Zui+3UmIC3OI6Br5zB/BcmU2OLBynoU7vK/M05bv1SOWYhkm6S5h+9DAaixoIwYje7
 n0lGc9RYeHD03pE/3sbxT/tF9KMMwU/rZXjs9gbXgnNbKGqj5o9cDoULSRGaRNvdM41TgZbWCLoRP
 joVdBZl8HNRxzpu0=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8wmR-0008B3-BJ for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 09:27:18 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so22341635e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790069229; x=1790674029; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6bhrhptstQbp+gvoVB3TGPIF/ZqRhp8xFDC7NJZbN7I=;
 b=aAL+R/q0aZBCkP8Cxn7sVyg2LDNeTMFKF8KvR4xt9yc1LD77n235PsiAvVhq5+5Z0+
 0SJv3MzYca/mWjLD5yG+DyAKdNCN+GqeByRkIXciGArxOWi+Kq+jnrWqrwybnsE/cf17
 kNW05rnifFLH+GKmOGqZcLwHgfpbslnfzZ2fWFPdjZwRU5bQP9j0Qu1h5cAv3BdffDku
 mSlcAWggPvIhANvDzUMJIxPSIggoMYR0jKJggp2vdN29B65bk2tmlKaTnhuqACmYHYa/
 +Ao1RupERM3DyY7qOl+dXe5OCK4Z2eARiAHtowX2y0ymtIWcZeuvzLyuY0Ow5qoSCnvN
 CDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790069229; x=1790674029;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6bhrhptstQbp+gvoVB3TGPIF/ZqRhp8xFDC7NJZbN7I=;
 b=FcThbl95YOgtgHeUwdvzvi/L6L/jPQrt721v6z4eOws3vmMSiUwPKe1eW/mhdY/lPZ
 m4E5khzRzLnB/8mAiElkWyQNu4nvmaFelFTTy1afon9TF9Si5gab3DXAHfk25W29dFzY
 h9QYXRlV9GsoL4Jtw8XwW6IdT/YHvNhSDrT+awlKHMwQjpkt8ofxBUwlL2g7Uk6BmHqi
 mEZHOJve6Jh6WBd1HtxY9rroTmzcz1PVFzvIr0qUPmxkaJrBqVmvhitY0hLXfbQPaXqp
 UvrWBTxr4gC3m0FRHwqjSWk2TD/ZwgvdAzbATq1zQK9Dr+pvMby/16dU7MfG1JYoMgTw
 lpFA==
X-Gm-Message-State: AFuF++ld5HE0+Czx6YizLPt4//yGffrmM8DUhHlpBpSHDgPWBugSF2FW
 R4m09KcZ8K+sfImKNbF4xwbmgZ5i1MeJpq8VQgrwaPw5bFAB64mgPFY/GTU6Sq4YkGBaOiANFfB
 ta1CeTJ9FEmjRI0LDnfHpeumybB2rYCJz+wTnT2BHgFp/Azvf6cyRJcycwxCyl486UaOh
X-Gm-Gg: AYBFou0YHzbtZhcTxCjMDxHQLJSB19Ou597gVBJfXjw9JawhrgK7GwkRHusrFNIm2e1
 rwxvxh9mdcElGVp7UsHTLWSbmRhHn4yTC42MLM0dMlhxRyLiv3pNqJZDDJh5+iZkGBfRdaOnXgw
 lWB8T2L/vFG0/ifMJExEyOefNUtw+MNq4YoiqfQFYhTOI+qRlw92jjxJeMuHOt0Q7J/f3Dfm5AR
 rT8iFsubhpsovqy9aoPjuAqSNNmS4zDtOP0kS7TOysJSgUAR/H/yJJoNv2tXdUDv105nqWV+OQO
 t+D1jBgDsOifLYXNLGcqkjB3ZK0S/horWy0MCZBPXmWb07438tlgn1vKv0vZ/o1k8udoJr3l3Kk
 qJkHlJpSJKLJRHoobNQx/OMBUT6u4t9qyY2QYfR6l90jgLJWQpeqDOiazGqZ6cd7xQgRfKUC6tA
 IA1fsCCIXPiMMRyqnwSWAnycj02ej599xbtQ4FtktUMgq+2HMCdM5ikNcHaDTiaGOrthnFOi1fX
 afnMicKzrBVwzADDsnHUhU4jc6TPmq2FNQhXWuyXDfi+XOQ61OtsYnN+a13EeyjaI45SqkuYANv
 inlXI4VvgUayexEfGkkVGtAY5LCYcY2AeDGSMpq8UxDlVombpKVxMzeDoFogLTgKpc3tm0N5
X-Received: by 2002:a05:600c:8584:b0:49f:cbf1:e76d with SMTP id
 5b1f17b1804b1-49fcbf1e9a5mr121079225e9.0.1790069228417; 
 Tue, 22 Sep 2026 02:27:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdad3669fsm41029235e9.8.2026.09.22.02.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 02:27:07 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 09:27:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
X-Gerrit-Change-Number: 1922
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1922?usp=email>
X-Gerrit-Commit: 8ae8cf42f776f9988efc51209d66efba08eac01f
In-Reply-To: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
References: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDA2MzgxMDAwLkk5ODNkNjdlMWM5MGJlYTQ2MGY1MzFmMTFkNGM1OGQzM2EzNTFkODFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <647e2901a84b464b7df12b4481c2109a3cb7df36-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x8wmR-0008B3-BJ
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
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8912047298095932565=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8912047298095932565==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+1tPruyuWtA="; charset=UTF-8

--+1tPruyuWtA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail

to look at the new patch=
 set (#2)=2E


Change subject: GHA: Maintenance update September 2026
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Maintenance=
 update September 2026

Contains the following renovate updates:
- chore(de=
ps): update vcpkg digest to 5f96cd1
- Update dependency ubuntu to v26
- cho=
re(deps): update dependency aws/aws-lc to v5=2E9=2E0
- chore(deps): update =
github actions
- Update github actions (major)

Change-Id: I983d67e1c90bea4=
60f531f11d4c58d33a351d81b
Signed-off-by: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>
---
M =2Egithub/workflows/build=2Eyaml
M =2Egithub/workflows/cove=
rity-scan=2Eyml
M =2Egithub/workflows/doxygen=2Eyml
M =2Egithub/workflows/t=
est-ssllib=2Eyml
4 files changed, 33 insertions(+), 33 deletions(-)


  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/22/1922/2

di=
ff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Ey=
aml
index d67c215=2E=2E27f08df 100644
--- a/=2Egithub/workflows/build=2Eyam=
l
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -7,14 +7,14 @@
 jobs:
   clang-=
format:
     name: Check code style with clang-format
-    runs-on: ubuntu-=
24=2E04
+    runs-on: ubuntu-26=2E04
     steps:
       - name: Install dep=
endencies
         run: |
           sudo apt update && sudo apt install -y=
 python3-pip
           pip3 install pre-commit
       - name: Checkout Ope=
nVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e=
10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410=
c181273ba90b1 # v7=2E0=2E1
       - name: Run clang-format
         run: pr=
e-commit run -a --show-diff-on-failure || true
       - name: Check for cha=
nges
@@ -34,7 +34,7 @@
         include:
           - abi: arm64-v8a
      =
       vcpkg_triplet: arm64-android
-    runs-on: ubuntu-24=2E04
+    runs-=
on: ubuntu-26=2E04
     name: "Android - ${{ matrix=2Eabi }}"
     # Github=
 images already setup NDK with ANDROID_NDK_ROOT pointing to the root
     #=
 of the SDK
@@ -43,17 +43,17 @@
       VCPKG_ROOT: ${{ github=2Eworkspace }=
}/vcpkg
       VCPKG_INSTALLED_DIR: ${{ github=2Eworkspace }}/vcpkg/install=
ed
       VCPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_CO=
MMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
+      VCPKG_GIT_COMMIT_I=
D: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
     steps:
       - name: Chec=
kout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884=
172cec0e10 # v6=2E0=2E3
-      - uses: lukka/get-cmake@591817e96fcad43505fb=
4eae36172462abb3a42e # v4=2E3=2E3
+        uses: actions/checkout@3d3c42e5a=
ac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
+      - uses: lukka/get-cmake=
@fffaaafeea488556c2c12dad60690008bc1caacb # v4=2E4=2E2
       - name: Setup=
 vcpkg
         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb=
6a2 # v11=2E6
         with:
           vcpkgGitCommitId: ${{ env=2EVCPKG_G=
IT_COMMIT_ID }}
       - name: Set up vcpkg binary cache
-        uses: act=
ions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+        u=
ses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
  =
       with:
           path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}
     =
      key: android-${{ matrix=2Eabi }}-vcpkg-binary-cache-${{ env=2EVCPKG_G=
IT_COMMIT_ID }}
@@ -82,18 +82,18 @@
         build: [Release, Debug]
 
    =
 name: "gcc-mingw - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL"
- =
   runs-on: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E04
     env:
       VC=
PKG_ROOT: ${{ github=2Eworkspace }}/vcpkg
       VCPKG_BINARY_SOURCES: clea=
r;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5=
a16b18a0c0f07
+      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1e=
fc5fd07
     steps:
       - name: Install dependencies
         run: sudo =
apt update && sudo apt install -y mingw-w64 unzip build-essential wget pyth=
on3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: a=
ctions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+    =
    uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E=
0=2E1
 
-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3=
a42e # v4=2E3=2E3
+      - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60=
690008bc1caacb # v4=2E4=2E2
       - name: Setup vcpkg
         uses: lukka=
/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
         with=
:
@@ -101,7 +101,7 @@
           vcpkgJsonGlob: '**/mingw/vcpkg=2Ejson'
 
 =
      - name: Set up vcpkg binary cache
-        uses: actions/cache@27d5ce=
7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+        uses: actions/cach=
e@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
         with:
    =
       path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}
           key: mingw-=
${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles('**/mingw/vcpkg=2Ejso=
n') }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}
@@ -144,7 +144,7 @@
     name: "min=
gw unittest ${{ matrix=2Etest }} - ${{ matrix=2Earch }} - ${{ matrix=2Ebuil=
d }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: act=
ions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+      =
  uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=
=2E1
       - name: Retrieve mingw unittest
         uses: actions/download=
-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8=2E0=2E1
         wi=
th:
@@ -185,7 +185,7 @@
       - name: Install dependencies
         run: s=
udo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev l=
ibcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3=
-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: C=
heckout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1=
884172cec0e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba80=
5825da76410c181273ba90b1 # v7=2E0=2E1
       - name: autoconf
         run:=
 autoreconf -fvi
       - name: configure
@@ -215,7 +215,7 @@
       - name=
: Install dependencies
         run: sudo apt update && sudo apt install -y=
 liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-l=
ibc-dev man2html clang libcmocka-dev python3-docutils libtool automake auto=
conf
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1=
c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/chec=
kout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
       - name: a=
utoconf
         run: autoreconf -fvi
       - name: configure
@@ -255,7 +2=
55,7 @@
       - name: Install dependencies
         run: brew install ${{m=
atrix=2Essllib}} lzo lz4 man2html cmocka libtool automake autoconf
       -=
 name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd3=
1b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5=
aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
       - name: Set environmen=
t
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -285,12 +285,12 @@=

       env:
         BUILD_CONFIGURATION: Release
         VCPKG_BINARY_SO=
URCES: clear;default,readwrite
-        VCPKG_GIT_COMMIT_ID: 75672db6bd812b=
060482b0f00b5a16b18a0c0f07
+        VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf=
27e0524606d6c1efc5fd07
 
       runs-on: windows-2025-vs2026
       steps:
=
-      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # =
v6=2E0=2E3
-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462a=
bb3a42e # v4=2E3=2E3
+      - uses: actions/checkout@3d3c42e5aac5ba805825da=
76410c181273ba90b1 # v7=2E0=2E1
+      - uses: lukka/get-cmake@fffaaafeea48=
8556c2c12dad60690008bc1caacb # v4=2E4=2E2
 
       - name: Install rst2html=

         run: python -m pip install --upgrade pip docutils
@@ -302,7 +302,=
7 @@
           vcpkgJsonGlob: '**/windows/vcpkg=2Ejson'
 
       - name: S=
et up vcpkg binary cache
-        uses: actions/cache@27d5ce7f107fe9357f9df=
03efb73ab90386fccae # v5=2E0=2E5
+        uses: actions/cache@55cc8345863c7=
cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
         with:
           path: ${=
{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}
           key: msvc-${{ matrix=2Earc=
h }}-vcpkg-binary-cache-${{ hashFiles('**/windows/vcpkg=2Ejson') }}-${{ env=
=2EVCPKG_GIT_COMMIT_ID }}
@@ -380,7 +380,7 @@
       ovpnlibdesc: AWS-LC
  =
     # versioning=3Dsemver-coerced
       ghrepo: aws/aws-lc
-      gitref:=
 v5=2E0=2E0
+      gitref: v5=2E9=2E0
       libconfigure: cmake -B build -=
GNinja -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D"$LIBPREFIX" -=
DBUILD_SHARED_LIBS=3D1
       libmake: cmake --build build
-      libinstal=
l: sudo cmake --install build
\ No newline at end of file
+      libinstall=
: sudo cmake --install build
diff --git a/=2Egithub/workflows/coverity-scan=
=2Eyml b/=2Egithub/workflows/coverity-scan=2Eyml
index 105f23e=2E=2Ee103aec=
 100644
--- a/=2Egithub/workflows/coverity-scan=2Eyml
+++ b/=2Egithub/workf=
lows/coverity-scan=2Eyml
@@ -9,11 +9,11 @@
     # Running coverity requires=
 the secrets=2ECOVERITY_SCAN_TOKEN token
     # which is only available on =
the main repository
     if: github=2Erepository_owner =3D=3D 'OpenVPN'
-  =
  runs-on: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E04
     steps:
       -=
 name: Check submission cache
         id: check_submit
-        uses: acti=
ons/cache/restore@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+  =
      uses: actions/cache/restore@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 =
# v6=2E1=2E0
         with:
           path: |
             cov-int
@@ -25,=
7 +25,7 @@
 
       - name: Checkout OpenVPN
         if: steps=2Echeck_sub=
mit=2Eoutputs=2Ecache-hit !=3D 'true'
-        uses: actions/checkout@df4cb=
1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/che=
ckout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
 
       - name=
: Download Coverity Build Tool
         if: steps=2Echeck_submit=2Eoutputs=
=2Ecache-hit !=3D 'true'
@@ -65,7 +65,7 @@
 
       - name: Cache submissio=
n
         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'true'
-    =
    uses: actions/cache/save@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=
=2E0=2E5
+        uses: actions/cache/save@55cc8345863c7cc4c66a329aec7e433d=
2d1c52a9 # v6=2E1=2E0
         with:
           path: |
             cov-in=
t
diff --git a/=2Egithub/workflows/doxygen=2Eyml b/=2Egithub/workflows/doxy=
gen=2Eyml
index 3755b92=2E=2E379b21c 100644
--- a/=2Egithub/workflows/doxyg=
en=2Eyml
+++ b/=2Egithub/workflows/doxygen=2Eyml
@@ -8,10 +8,10 @@
   cance=
l-in-progress: false
 jobs:
   build:
-    runs-on: ubuntu-24=2E04
+    run=
s-on: ubuntu-26=2E04
     if: ${{ github=2Erepository_owner =3D=3D 'openvpn=
' || github=2Eevent_name =3D=3D 'workflow_dispatch' }}
     steps:
-      -=
 uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=
=2E3
+      - uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90=
b1 # v7=2E0=2E1
         with:
           path: openvpn
 
@@ -47,8 +47,8 @@=

     environment:
       name: github-pages
       url: ${{ steps=2Edeploy=
ment=2Eoutputs=2Epage_url }}
-    runs-on: ubuntu-24=2E04
+    runs-on: ubu=
ntu-26=2E04
     steps:
       - name: Deploy to GitHub Pages
         id: =
deployment
-        uses: actions/deploy-pages@cd2ce8fcbc39b97be8ca5fce6e76=
3baed58fa128 # v5
+        uses: actions/deploy-pages@368f82528645a54fb793d=
4d04e342629a3f51346 # v5
diff --git a/=2Egithub/workflows/test-ssllib=2Eyml=
 b/=2Egithub/workflows/test-ssllib=2Eyml
index d8178a7=2E=2E64607cf 100644
=
--- a/=2Egithub/workflows/test-ssllib=2Eyml
+++ b/=2Egithub/workflows/test-=
ssllib=2Eyml
@@ -70,14 +70,14 @@
       - name: Install dependencies
      =
   run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev lib=
lz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtoo=
l automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name=
: Restore ${{inputs=2Elibname}} from cache
-        uses: actions/cache@27d=
5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+        uses: actions/c=
ache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
         id: ssl=
lib-cache
         with:
           path: ${{env=2ELIBPREFIX}}
           k=
ey: ${{matrix=2Eos}}-${{inputs=2Elibname}}-${{matrix=2Ebuild }}-${{inputs=
=2Egitref}}
       - name: "${{inputs=2Elibname}}: checkout"
         if: s=
teps=2Essllib-cache=2Eoutputs=2Ecache-hit !=3D 'true'
-        uses: action=
s/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        u=
ses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1=

         with:
           submodules: recursive
           path: ${{inputs=
=2Elibname}}
@@ -98,7 +98,7 @@
       - name: Run ldconfig
         run: su=
do ldconfig
       - name: "OpenVPN: checkout"
-        uses: actions/check=
out@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: ac=
tions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
      =
 - name: "OpenVPN: autoreconf"
         run: autoreconf -fvi
       - name:=
 "OpenVPN: configure"

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1922?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
Gerrit-Change-Number: 1922
G=
errit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mai=
lbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--+1tPruyuWtA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">GHA: Maintenance update September 2026<br><br>Contains the foll=
owing renovate updates:<br>- chore(deps): update vcpkg digest to 5f96cd1<br=
>- Update dependency ubuntu to v26<br>- chore(deps): update dependency aws/=
aws-lc to v5=2E9=2E0<br>- chore(deps): update github actions<br>- Update gi=
thub actions (major)<br><br>Change-Id: I983d67e1c90bea460f531f11d4c58d33a35=
1d81b<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<b=
r>---<br>M =2Egithub/workflows/build=2Eyaml<br>M =2Egithub/workflows/coveri=
ty-scan=2Eyml<br>M =2Egithub/workflows/doxygen=2Eyml<br>M =2Egithub/workflo=
ws/test-ssllib=2Eyml<br>4 files changed, 33 insertions(+), 33 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/22/1922/2</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/=2Egithub/workflows/build=
=2Eyaml b/=2Egithub/workflows/build=2Eyaml</span><br><span>index d67c215=2E=
=2E27f08df 100644</span><br><span>--- a/=2Egithub/workflows/build=2Eyaml</s=
pan><br><span>+++ b/=2Egithub/workflows/build=2Eyaml</span><br><span>@@ -7,=
14 +7,14 @@</span><br><span> jobs:</span><br><span>   clang-format:</span><=
br><span>     name: Check code style with clang-format</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=2E04</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-26=2E04</span>=
<br><span>     steps:</span><br><span>       - name: Install dependencies</=
span><br><span>         run: |</span><br><span>           sudo apt update &=
amp;&amp; sudo apt install -y python3-pip</span><br><span>           pip3 i=
nstall pre-commit</span><br><span>       - name: Checkout OpenVPN</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@=
df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aa=
c5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>       - name: =
Run clang-format</span><br><span>         run: pre-commit run -a --show-dif=
f-on-failure || true</span><br><span>       - name: Check for changes</span=
><br><span>@@ -34,7 +34,7 @@</span><br><span>         include:</span><br><s=
pan>           - abi: arm64-v8a</span><br><span>             vcpkg_triplet:=
 arm64-android</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    run=
s-on: ubuntu-24=2E04</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    runs-on: ubuntu-26=2E04</span><br><span>     name: &quot;Android - ${{=
 matrix=2Eabi }}&quot;</span><br><span>     # Github images already setup N=
DK with ANDROID_NDK_ROOT pointing to the root</span><br><span>     # of the=
 SDK</span><br><span>@@ -43,17 +43,17 @@</span><br><span>       VCPKG_ROOT:=
 ${{ github=2Eworkspace }}/vcpkg</span><br><span>       VCPKG_INSTALLED_DIR=
: ${{ github=2Eworkspace }}/vcpkg/installed</span><br><span>       VCPKG_BI=
NARY_SOURCES: clear;default,readwrite</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b1=
8a0c0f07</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG=
_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07</span><br><span>  =
   steps:</span><br><span>       - name: Checkout OpenVPN</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c0=
69e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@591817e96fcad43505fb4=
eae36172462abb3a42e # v4=2E3=2E3</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181=
273ba90b1 # v7=2E0=2E1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb #=
 v4=2E4=2E2</span><br><span>       - name: Setup vcpkg</span><br><span>    =
     uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=
=2E6</span><br><span>         with:</span><br><span>           vcpkgGitComm=
itId: ${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>       - name: Set u=
p vcpkg binary cache</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E=
0=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: =
actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><=
br><span>         with:</span><br><span>           path: ${{ env=2EVCPKG_DE=
FAULT_BINARY_CACHE }}</span><br><span>           key: android-${{ matrix=2E=
abi }}-vcpkg-binary-cache-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>=
@@ -82,18 +82,18 @@</span><br><span>         build: [Release, Debug]</span>=
<br><span> </span><br><span>     name: &quot;gcc-mingw - ${{ matrix=2Earch =
}} - ${{ matrix=2Ebuild }} - OSSL&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    runs-on: ubuntu-24=2E04</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    runs-on: ubuntu-26=2E04</span><br><span>     =
env:</span><br><span>       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg</sp=
an><br><span>       VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-      VCPKG_GIT_COMMIT_ID: 7567=
2db6bd812b060482b0f00b5a16b18a0c0f07</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c=
1efc5fd07</span><br><span>     steps:</span><br><span>       - name: Instal=
l dependencies</span><br><span>         run: sudo apt update &amp;&amp; sud=
o apt install -y mingw-w64 unzip build-essential wget python3-docutils man2=
html-base</span><br><span>       - name: Checkout OpenVPN</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c0=
69e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba8058=
25da76410c181273ba90b1 # v7=2E0=2E1</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@591817e96fcad=
43505fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      - uses: lukka/get-cmake@fffaaafeea488556c2c12dad=
60690008bc1caacb # v4=2E4=2E2</span><br><span>       - name: Setup vcpkg</s=
pan><br><span>         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd=
7a427fb6a2 # v11=2E6</span><br><span>         with:</span><br><span>@@ -101=
,7 +101,7 @@</span><br><span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg=
=2Ejson&#39;</span><br><span> </span><br><span>       - name: Set up vcpkg =
binary cache</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u=
ses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/=
cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span=
>         with:</span><br><span>           path: ${{ env=2EVCPKG_DEFAULT_BI=
NARY_CACHE }}</span><br><span>           key: mingw-${{ matrix=2Earch }}-vc=
pkg-binary-cache-${{ hashFiles(&#39;**/mingw/vcpkg=2Ejson&#39;) }}-${{ env=
=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>@@ -144,7 +144,7 @@</span><br><sp=
an>     name: &quot;mingw unittest ${{ matrix=2Etest }} - ${{ matrix=2Earch=
 }} - ${{ matrix=2Ebuild }} - OSSL&quot;</span><br><span>     steps:</span>=
<br><span>       - name: Checkout OpenVPN</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874edd31b431=
1f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273=
ba90b1 # v7=2E0=2E1</span><br><span>       - name: Retrieve mingw unittest<=
/span><br><span>         uses: actions/download-artifact@3e5f45b2cfb9172054=
b4087a40e8e0b5a5461e7c # v8=2E0=2E1</span><br><span>         with:</span><b=
r><span>@@ -185,7 +185,7 @@</span><br><span>       - name: Install dependen=
cies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt inst=
all -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev l=
inux-libc-dev man2html libcmocka-dev python3-docutils libtool automake auto=
conf ${SSLPKG} ${PKCS11PKG}</span><br><span>       - name: Checkout OpenVPN=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions=
/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@=
3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>     =
  - name: autoconf</span><br><span>         run: autoreconf -fvi</span><br>=
<span>       - name: configure</span><br><span>@@ -215,7 +215,7 @@</span><b=
r><span>       - name: Install dependencies</span><br><span>         run: s=
udo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev libl=
z4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmoc=
ka-dev python3-docutils libtool automake autoconf</span><br><span>       - =
name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # =
v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
ses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1=
</span><br><span>       - name: autoconf</span><br><span>         run: auto=
reconf -fvi</span><br><span>       - name: configure</span><br><span>@@ -25=
5,7 +255,7 @@</span><br><span>       - name: Install dependencies</span><br=
><span>         run: brew install ${{matrix=2Essllib}} lzo lz4 man2html cmo=
cka libtool automake autoconf</span><br><span>       - name: Checkout OpenV=
PN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actio=
ns/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkou=
t@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>   =
    - name: Set environment</span><br><span>         run: |</span><br><span=
>           cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span>@@ -285,12=
 +285,12 @@</span><br><span>       env:</span><br><span>         BUILD_CONF=
IGURATION: Release</span><br><span>         VCPKG_BINARY_SOURCES: clear;def=
ault,readwrite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        VCPKG_GIT_COMMIT_ID: 5f9=
6cd15fd745122cf27e0524606d6c1efc5fd07</span><br><span> </span><br><span>   =
    runs-on: windows-2025-vs2026</span><br><span>       steps:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/checkout@df4=
cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@591817e96fcad435=
05fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      - uses: actions/checkout@3d3c42e5aac5ba805825da7641=
0c181273ba90b1 # v7=2E0=2E1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1ca=
acb # v4=2E4=2E2</span><br><span> </span><br><span>       - name: Install r=
st2html</span><br><span>         run: python -m pip install --upgrade pip d=
ocutils</span><br><span>@@ -302,7 +302,7 @@</span><br><span>           vcpk=
gJsonGlob: &#39;**/windows/vcpkg=2Ejson&#39;</span><br><span> </span><br><s=
pan>       - name: Set up vcpkg binary cache</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        uses: actions/cache@27d5ce7f107fe9357f9df03e=
fb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c5=
2a9 # v6=2E1=2E0</span><br><span>         with:</span><br><span>           =
path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}</span><br><span>           ke=
y: msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles(&#39;**/windo=
ws/vcpkg=2Ejson&#39;) }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>@=
@ -380,7 +380,7 @@</span><br><span>       ovpnlibdesc: AWS-LC</span><br><sp=
an>       # versioning=3Dsemver-coerced</span><br><span>       ghrepo: aws/=
aws-lc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      gitref: v=
5=2E0=2E0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      gitr=
ef: v5=2E9=2E0</span><br><span>       libconfigure: cmake -B build -GNinja =
-DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D&quot;$LIBPREFIX&quot=
; -DBUILD_SHARED_LIBS=3D1</span><br><span>       libmake: cmake --build bui=
ld</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      libinstall: s=
udo cmake --install build</span><br><span>\ No newline at end of file</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      libinstall: sudo cm=
ake --install build</span><br><span>diff --git a/=2Egithub/workflows/coveri=
ty-scan=2Eyml b/=2Egithub/workflows/coverity-scan=2Eyml</span><br><span>ind=
ex 105f23e=2E=2Ee103aec 100644</span><br><span>--- a/=2Egithub/workflows/co=
verity-scan=2Eyml</span><br><span>+++ b/=2Egithub/workflows/coverity-scan=
=2Eyml</span><br><span>@@ -9,11 +9,11 @@</span><br><span>     # Running cov=
erity requires the secrets=2ECOVERITY_SCAN_TOKEN token</span><br><span>    =
 # which is only available on the main repository</span><br><span>     if: =
github=2Erepository_owner =3D=3D &#39;OpenVPN&#39;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=2E04</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-26=2E04</span><br>=
<span>     steps:</span><br><span>       - name: Check submission cache</sp=
an><br><span>         id: check_submit</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        uses: actions/cache/restore@27d5ce7f107fe9357f9df0=
3efb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        uses: actions/cache/restore@55cc8345863c7cc4c66a329aec7=
e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         with:</span><br><span> =
          path: |</span><br><span>             cov-int</span><br><span>@@ -=
25,7 +25,7 @@</span><br><span> </span><br><span>       - name: Checkout Ope=
nVPN</span><br><span>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hi=
t !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v=
6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1<=
/span><br><span> </span><br><span>       - name: Download Coverity Build To=
ol</span><br><span>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit =
!=3D &#39;true&#39;</span><br><span>@@ -65,7 +65,7 @@</span><br><span> </sp=
an><br><span>       - name: Cache submission</span><br><span>         if: s=
teps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/save@27=
d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache/save@55cc8345=
863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         with=
:</span><br><span>           path: |</span><br><span>             cov-int</=
span><br><span>diff --git a/=2Egithub/workflows/doxygen=2Eyml b/=2Egithub/w=
orkflows/doxygen=2Eyml</span><br><span>index 3755b92=2E=2E379b21c 100644</s=
pan><br><span>--- a/=2Egithub/workflows/doxygen=2Eyml</span><br><span>+++ b=
/=2Egithub/workflows/doxygen=2Eyml</span><br><span>@@ -8,10 +8,10 @@</span>=
<br><span>   cancel-in-progress: false</span><br><span> jobs:</span><br><sp=
an>   build:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-=
on: ubuntu-24=2E04</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   runs-on: ubuntu-26=2E04</span><br><span>     if: ${{ github=2Erepository=
_owner =3D=3D &#39;openvpn&#39; || github=2Eevent_name =3D=3D &#39;workflow=
_dispatch&#39; }}</span><br><span>     steps:</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      - uses: actions/checkout@df4cb1c069e1874edd31=
b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      - uses: actions/checkout@3d3c42e5aac5ba805825da76410c18=
1273ba90b1 # v7=2E0=2E1</span><br><span>         with:</span><br><span>    =
       path: openvpn</span><br><span> </span><br><span>@@ -47,8 +47,8 @@</s=
pan><br><span>     environment:</span><br><span>       name: github-pages</=
span><br><span>       url: ${{ steps=2Edeployment=2Eoutputs=2Epage_url }}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=
=2E04</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: u=
buntu-26=2E04</span><br><span>     steps:</span><br><span>       - name: De=
ploy to GitHub Pages</span><br><span>         id: deployment</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/deploy-pages@c=
d2ce8fcbc39b97be8ca5fce6e763baed58fa128 # v5</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: actions/deploy-pages@368f82528645a54=
fb793d4d04e342629a3f51346 # v5</span><br><span>diff --git a/=2Egithub/workf=
lows/test-ssllib=2Eyml b/=2Egithub/workflows/test-ssllib=2Eyml</span><br><s=
pan>index d8178a7=2E=2E64607cf 100644</span><br><span>--- a/=2Egithub/workf=
lows/test-ssllib=2Eyml</span><br><span>+++ b/=2Egithub/workflows/test-sslli=
b=2Eyml</span><br><span>@@ -70,14 +70,14 @@</span><br><span>       - name: =
Install dependencies</span><br><span>         run: sudo apt update &amp;&am=
p; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev m=
an2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-=
config libcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: Restor=
e ${{inputs=2Elibname}} from cache</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab9038=
6fccae # v5=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=
=2E1=2E0</span><br><span>         id: ssllib-cache</span><br><span>        =
 with:</span><br><span>           path: ${{env=2ELIBPREFIX}}</span><br><spa=
n>           key: ${{matrix=2Eos}}-${{inputs=2Elibname}}-${{matrix=2Ebuild =
}}-${{inputs=2Egitref}}</span><br><span>       - name: &quot;${{inputs=2Eli=
bname}}: checkout&quot;</span><br><span>         if: steps=2Essllib-cache=
=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874edd31b43=
11f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c18127=
3ba90b1 # v7=2E0=2E1</span><br><span>         with:</span><br><span>       =
    submodules: recursive</span><br><span>           path: ${{inputs=2Elibn=
ame}}</span><br><span>@@ -98,7 +98,7 @@</span><br><span>       - name: Run =
ldconfig</span><br><span>         run: sudo ldconfig</span><br><span>      =
 - name: &quot;OpenVPN: checkout&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1=
884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba9=
0b1 # v7=2E0=2E1</span><br><span>       - name: &quot;OpenVPN: autoreconf&q=
uot;</span><br><span>         run: autoreconf -fvi</span><br><span>       -=
 name: &quot;OpenVPN: configure&quot;</span><br></pre><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail">change =
1922</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1922 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>

</body></html>
--+1tPruyuWtA=--


--===============8912047298095932565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8912047298095932565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8912047298095932565==--

