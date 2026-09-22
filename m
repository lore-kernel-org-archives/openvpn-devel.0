Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE27C982F1
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jmPYxok32WtoyNHAAULlF/4VBi7hLVJI+aOsURDV8MQ=; b=iwhvHni28f6wBunCiqPfazDfX5
	rDPeXSXxnid3TEb0LPzSrjuz/v6cXtmRTg/mIQMCMerHhNUxIusdM0ll1o02A7xcNuDFLr11syAZd
	pgw6luM7yvrNNvqZpiy9h11DsAT6HbNzdSeGDtlZZUxjNIIIlo6EMFpcDX1L5O6RgVeU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8wsI-00059Y-QN;
	Tue, 22 Sep 2026 09:33:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8wsH-00059P-6I
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 09:33:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wLAfokWnNFYkTchKZgf6JLPPK3gqaPa3Owz+HAnISPQ=; b=NGZOpSJlwb17tfV3CGxj1kx5vo
 7Rv1J0zn/IA5qqAzy1cxGzziJZ8gm6pZ6Oj94vIZQN0GJ9eO68im9bA9LyjwyQUkQafW48EkjiMoQ
 B5U/1p87xa9jFznVd2Vf4/+HgMvlThJOSzwiAY/KBXEcHMa1xRbk+wiJveJXtccLcwys=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wLAfokWnNFYkTchKZgf6JLPPK3gqaPa3Owz+HAnISPQ=; b=Q
 UaF7P0iRC4eMZH0TnRZr+kdW8ruJtjUMZb1BkTp/1F3Ppl8M0q60C+6TI21L9TdTVnF5kQfHbS5qC
 5iwRj0ZKpH/Ih1Tu1hp8rilMaTdMDx2EaugeS1mxBSunZMlMWxIQ1lyeDKnkyJzSRonduHl9Y7r8Z
 NhxVnNFNCbApPLqU=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8wsF-0004XK-5G for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 09:33:16 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so20179245e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 02:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790069588; x=1790674388; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wLAfokWnNFYkTchKZgf6JLPPK3gqaPa3Owz+HAnISPQ=;
 b=X78gTUd39LEiU5diordNFHobFgTRIZX2yp2F3ZSmytvWpkVGi3nJ4b5Qwgr+9o8nhH
 cG8W7Xo6Xc06Zpzb1iL3HDpKW9R1RZuHQTIdFxTa81MZSkGB45FJ92UfHqAkOxTb86cV
 eRVs8aab7oom2TA1wQfE+liZVKYYV5PTIGWpFrunNLjeN2Ba4Cl5AT9pe7nX9r4x8ZQU
 0omdJoRQY+ZckFul0sC0ODbHmmKftUMpJ8B9griO2Rx3vdakz/GipIAjDPV88/MgYs/E
 VK5fMYgwXo3rNW0O2wacBdoguA54sbGelNKjY1U5mYmPU3tm/z3JAP+1P10HrohqO8aZ
 szvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790069588; x=1790674388;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wLAfokWnNFYkTchKZgf6JLPPK3gqaPa3Owz+HAnISPQ=;
 b=ontag8CqpxSz97MRpSC1lPnQvGvA68vSQ4CoNJLm4zF1bZR9k/gGXXxO66zFDPJAMO
 TtQO8EQEDA/HMYMImLhLaN1CcHTpYL/p8oiBxUfarPRBoiP1UjJXPX9L+3AtUOQieTpA
 srVcJeKZEx8tpdrkHEY35r/3FAqaaCsLaIZoWS3M1n186YhFHgyRG5muxwnynUdjNjSv
 WlYlrwcPlB7+Ra9uz4+rNzOzdSj3OTQa2xwRAU02AUhNOf8mwZRwgf2vg0f1BcLT2Cc9
 QnAWq8nftaTkJdegJYmjgXFXpNd7W9ezeaZT/EMb8FIDC5p9T/CinYfN0s5Y5Yoijdh6
 LRTg==
X-Gm-Message-State: AFuF++nXUV2ExROvCsnotdN3msRcrKDWF+9Z9fQRNlVjla4KBqvjoZNt
 h2aJjoxc/v/AnD8b7LMaIxfVXlfytmZH4Qnt2NiMSTNCOfP/ng6r0X9e50r2TdJHzvAgukOQ0cH
 X+wblTcJBanXwJ1pXOgHtHOtkag2vqRjkJEVQxvn09mUqEuDhbU4BNf3e9A1LWtR4hgak
X-Gm-Gg: AYBFou3L10WSnjM6Z/WJq9BcZ2w1FB8laAmCwTnKt2ZmfaCEneqSgEhO0Pf0FV7d9Ph
 Wt6S8U4lZ47KjX14WBYOzSIdWvFwOpVg0ZN1bxzYK55YW2PzFlAAg5BUOo5QppnO8t1H9UknUjG
 zO2sdDaEmUHLWE3Tx42VOXmlTkL6l9rsaX4m9IZ/sFyk+AFYrw9itj+mF1AMmmAmVwGCc+tJ6sS
 EjmTBuYbs6gz+gfdSJdacjLetOcEgPjoL4tMY+yWnrI3VvGt72JkbxGy1W1WdCPklUMnG2qQiQO
 ynHuawP7MpiwA2dKSsQJMWSfTOXsuWY+aQnJ8sGaIEyQs7NRr1V+sFtZqR1EZpL5EdSYDbLliH0
 1lxgpuRTzAFRyiGss9cpT1ZJhWPVkIx37ytdCuVEGZcAQ7udbuhvFQDP/JsPyltpElSmHdUS56X
 Fa5WjEzN3nlaC+q5LIEDQWsZO3L2D62wZlZO+qjF6D7hwiYbRaM7x6eac8WR0ZErd+m7ryYo0vV
 5r6BaOWvPpiKibnwE5hW2u1+2sD4H8SUdqqP2TB2UKbIw3/Ecg8sFUjryCX+s904r10kDO5teHm
 AqbqdLzpJO2AmxIMUd8pQfPRAzuJceSHrgvUcBIzHRZIjvxs22N5a/w0BT3WCg==
X-Received: by 2002:a05:600c:1552:b0:49c:fc6e:a3df with SMTP id
 5b1f17b1804b1-49fcc2b2785mr173017885e9.30.1790069588247; 
 Tue, 22 Sep 2026 02:33:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8cd5214sm68453585e9.9.2026.09.22.02.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 02:33:07 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 09:33:06 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
X-Gerrit-Change-Number: 1922
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1922?usp=email>
X-Gerrit-Commit: c3d12d0f16b96d12ebc4935c4d933a95d3d6e99e
In-Reply-To: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
References: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDA2MzgxMDAwLkk5ODNkNjdlMWM5MGJlYTQ2MGY1MzFmMTFkNGM1OGQzM2EzNTFkODFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4593c5f8e59f1b27b60d363bb1407dc8db4140b9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x8wsF-0004XK-5G
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
Content-Type: multipart/mixed; boundary="===============4955811145940222307=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4955811145940222307==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cklTrKypFaI="; charset=UTF-8

--cklTrKypFaI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

Hello plaistho=
s, 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail

to look at the new patch set=
 (#3)=2E


Change subject: GHA: Maintenance update September 2026
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Maintenance updat=
e September 2026

Contains the following renovate updates:
- chore(deps): u=
pdate vcpkg digest to 5f96cd1
- Update dependency ubuntu to v26
- chore(dep=
s): update dependency aws/aws-lc to v5=2E9=2E0
- chore(deps): update github=
 actions
- Update github actions (major)

Change-Id: I983d67e1c90bea460f531=
f11d4c58d33a351d81b
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
---
M =2Egithub/workflows/build=2Eyaml
M =2Egithub/workflows/coverity-s=
can=2Eyml
M =2Egithub/workflows/doxygen=2Eyml
M =2Egithub/workflows/test-ss=
llib=2Eyml
4 files changed, 34 insertions(+), 34 deletions(-)


  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/22/1922/3

diff --g=
it a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml
in=
dex d67c215=2E=2E27f08df 100644
--- a/=2Egithub/workflows/build=2Eyaml
+++ =
b/=2Egithub/workflows/build=2Eyaml
@@ -7,14 +7,14 @@
 jobs:
   clang-format=
:
     name: Check code style with clang-format
-    runs-on: ubuntu-24=2E0=
4
+    runs-on: ubuntu-26=2E04
     steps:
       - name: Install dependenc=
ies
         run: |
           sudo apt update && sudo apt install -y pytho=
n3-pip
           pip3 install pre-commit
       - name: Checkout OpenVPN
-=
        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v=
6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c18127=
3ba90b1 # v7=2E0=2E1
       - name: Run clang-format
         run: pre-comm=
it run -a --show-diff-on-failure || true
       - name: Check for changes
@=
@ -34,7 +34,7 @@
         include:
           - abi: arm64-v8a
            =
 vcpkg_triplet: arm64-android
-    runs-on: ubuntu-24=2E04
+    runs-on: ub=
untu-26=2E04
     name: "Android - ${{ matrix=2Eabi }}"
     # Github image=
s already setup NDK with ANDROID_NDK_ROOT pointing to the root
     # of th=
e SDK
@@ -43,17 +43,17 @@
       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpk=
g
       VCPKG_INSTALLED_DIR: ${{ github=2Eworkspace }}/vcpkg/installed
   =
    VCPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_I=
D: 75672db6bd812b060482b0f00b5a16b18a0c0f07
+      VCPKG_GIT_COMMIT_ID: 5f9=
6cd15fd745122cf27e0524606d6c1efc5fd07
     steps:
       - name: Checkout O=
penVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec=
0e10 # v6=2E0=2E3
-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36=
172462abb3a42e # v4=2E3=2E3
+        uses: actions/checkout@3d3c42e5aac5ba8=
05825da76410c181273ba90b1 # v7=2E0=2E1
+      - uses: lukka/get-cmake@fffaa=
afeea488556c2c12dad60690008bc1caacb # v4=2E4=2E2
       - name: Setup vcpkg=

         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # =
v11=2E6
         with:
           vcpkgGitCommitId: ${{ env=2EVCPKG_GIT_COM=
MIT_ID }}
       - name: Set up vcpkg binary cache
-        uses: actions/c=
ache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+        uses: a=
ctions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
        =
 with:
           path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}
           =
key: android-${{ matrix=2Eabi }}-vcpkg-binary-cache-${{ env=2EVCPKG_GIT_COM=
MIT_ID }}
@@ -82,18 +82,18 @@
         build: [Release, Debug]
 
     name:=
 "gcc-mingw - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL"
-    run=
s-on: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E04
     env:
       VCPKG_RO=
OT: ${{ github=2Eworkspace }}/vcpkg
       VCPKG_BINARY_SOURCES: clear;defa=
ult,readwrite
-      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18=
a0c0f07
+      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd0=
7
     steps:
       - name: Install dependencies
         run: sudo apt up=
date && sudo apt install -y mingw-w64 unzip build-essential wget python3-do=
cutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions=
/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        us=
es: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
=
 
-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e #=
 v4=2E3=2E3
+      - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008=
bc1caacb # v4=2E4=2E2
       - name: Setup vcpkg
         uses: lukka/run-v=
cpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
         with:
@@ -=
101,7 +101,7 @@
           vcpkgJsonGlob: '**/mingw/vcpkg=2Ejson'
 
       =
- name: Set up vcpkg binary cache
-        uses: actions/cache@27d5ce7f107f=
e9357f9df03efb73ab90386fccae # v5=2E0=2E5
+        uses: actions/cache@55cc=
8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
         with:
          =
 path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}
           key: mingw-${{ ma=
trix=2Earch }}-vcpkg-binary-cache-${{ hashFiles('**/mingw/vcpkg=2Ejson') }}=
-${{ env=2EVCPKG_GIT_COMMIT_ID }}
@@ -144,7 +144,7 @@
     name: "mingw uni=
ttest ${{ matrix=2Etest }} - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} -=
 OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/c=
heckout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses=
: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
  =
     - name: Retrieve mingw unittest
         uses: actions/download-artifa=
ct@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8=2E0=2E1
         with:
@@ =
-185,7 +185,7 @@
       - name: Install dependencies
         run: sudo apt=
 update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-n=
g-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docuti=
ls libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout=
 OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172c=
ec0e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805825da7=
6410c181273ba90b1 # v7=2E0=2E1
       - name: autoconf
         run: autore=
conf -fvi
       - name: configure
@@ -215,7 +215,7 @@
       - name: Insta=
ll dependencies
         run: sudo apt update && sudo apt install -y liblzo=
2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev=
 man2html clang libcmocka-dev python3-docutils libtool automake autoconf
  =
     - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e18=
74edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/checkout@3d=
3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
       - name: autoconf=

         run: autoreconf -fvi
       - name: configure
@@ -255,7 +255,7 @@=

       - name: Install dependencies
         run: brew install ${{matrix=
=2Essllib}} lzo lz4 man2html cmocka libtool automake autoconf
       - name=
: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b431=
1f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5b=
a805825da76410c181273ba90b1 # v7=2E0=2E1
       - name: Set environment
   =
      run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -285,12 +285,12 @@
    =
   env:
         BUILD_CONFIGURATION: Release
         VCPKG_BINARY_SOURCES=
: clear;default,readwrite
-        VCPKG_GIT_COMMIT_ID: 75672db6bd812b06048=
2b0f00b5a16b18a0c0f07
+        VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e05=
24606d6c1efc5fd07
 
       runs-on: windows-2025-vs2026
       steps:
-    =
  - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E=
0=2E3
-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a4=
2e # v4=2E3=2E3
+      - uses: actions/checkout@3d3c42e5aac5ba805825da76410=
c181273ba90b1 # v7=2E0=2E1
+      - uses: lukka/get-cmake@fffaaafeea488556c=
2c12dad60690008bc1caacb # v4=2E4=2E2
 
       - name: Install rst2html
    =
     run: python -m pip install --upgrade pip docutils
@@ -302,7 +302,7 @@
=
           vcpkgJsonGlob: '**/windows/vcpkg=2Ejson'
 
       - name: Set up=
 vcpkg binary cache
-        uses: actions/cache@27d5ce7f107fe9357f9df03efb=
73ab90386fccae # v5=2E0=2E5
+        uses: actions/cache@55cc8345863c7cc4c6=
6a329aec7e433d2d1c52a9 # v6=2E1=2E0
         with:
           path: ${{ env=
=2EVCPKG_DEFAULT_BINARY_CACHE }}
           key: msvc-${{ matrix=2Earch }}-=
vcpkg-binary-cache-${{ hashFiles('**/windows/vcpkg=2Ejson') }}-${{ env=2EVC=
PKG_GIT_COMMIT_ID }}
@@ -380,7 +380,7 @@
       ovpnlibdesc: AWS-LC
       =
# versioning=3Dsemver-coerced
       ghrepo: aws/aws-lc
-      gitref: v5=
=2E0=2E0
+      gitref: v5=2E9=2E0
       libconfigure: cmake -B build -GNi=
nja -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D"$LIBPREFIX" -DBU=
ILD_SHARED_LIBS=3D1
       libmake: cmake --build build
-      libinstall: =
sudo cmake --install build
\ No newline at end of file
+      libinstall: s=
udo cmake --install build
diff --git a/=2Egithub/workflows/coverity-scan=2E=
yml b/=2Egithub/workflows/coverity-scan=2Eyml
index 105f23e=2E=2Ee103aec 10=
0644
--- a/=2Egithub/workflows/coverity-scan=2Eyml
+++ b/=2Egithub/workflow=
s/coverity-scan=2Eyml
@@ -9,11 +9,11 @@
     # Running coverity requires th=
e secrets=2ECOVERITY_SCAN_TOKEN token
     # which is only available on the=
 main repository
     if: github=2Erepository_owner =3D=3D 'OpenVPN'
-    r=
uns-on: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E04
     steps:
       - na=
me: Check submission cache
         id: check_submit
-        uses: actions=
/cache/restore@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+     =
   uses: actions/cache/restore@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v=
6=2E1=2E0
         with:
           path: |
             cov-int
@@ -25,7 +=
25,7 @@
 
       - name: Checkout OpenVPN
         if: steps=2Echeck_submit=
=2Eoutputs=2Ecache-hit !=3D 'true'
-        uses: actions/checkout@df4cb1c0=
69e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/checko=
ut@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
 
       - name: D=
ownload Coverity Build Tool
         if: steps=2Echeck_submit=2Eoutputs=2Ec=
ache-hit !=3D 'true'
@@ -65,7 +65,7 @@
 
       - name: Cache submission
  =
       if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'true'
-        =
uses: actions/cache/save@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=
=2E5
+        uses: actions/cache/save@55cc8345863c7cc4c66a329aec7e433d2d1c=
52a9 # v6=2E1=2E0
         with:
           path: |
             cov-int
di=
ff --git a/=2Egithub/workflows/doxygen=2Eyml b/=2Egithub/workflows/doxygen=
=2Eyml
index 3755b92=2E=2E784f81e 100644
--- a/=2Egithub/workflows/doxygen=
=2Eyml
+++ b/=2Egithub/workflows/doxygen=2Eyml
@@ -8,10 +8,10 @@
   cancel-=
in-progress: false
 jobs:
   build:
-    runs-on: ubuntu-24=2E04
+    runs-=
on: ubuntu-26=2E04
     if: ${{ github=2Erepository_owner =3D=3D 'openvpn' =
|| github=2Eevent_name =3D=3D 'workflow_dispatch' }}
     steps:
-      - u=
ses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3=

+      - uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 #=
 v7=2E0=2E1
         with:
           path: openvpn
 
@@ -35,7 +35,7 @@
   =
        touch doc/doxygen/html/=2Enojekyll
       - name: Upload static fil=
es as artifact
         id: deployment
-        uses: actions/upload-pages-=
artifact@fc324d3547104276b827a68afc52ff2a11cc49c9 # v5
+        uses: actio=
ns/upload-pages-artifact@fc324d3547104276b827a68afc52ff2a11cc49c9 # v5=2E0=
=2E0
         with:
           path: doxygen/doc/doxygen/html/
 
@@ -47,8 +=
47,8 @@
     environment:
       name: github-pages
       url: ${{ steps=
=2Edeployment=2Eoutputs=2Epage_url }}
-    runs-on: ubuntu-24=2E04
+    run=
s-on: ubuntu-26=2E04
     steps:
       - name: Deploy to GitHub Pages
    =
     id: deployment
-        uses: actions/deploy-pages@cd2ce8fcbc39b97be8c=
a5fce6e763baed58fa128 # v5
+        uses: actions/deploy-pages@368f82528645=
a54fb793d4d04e342629a3f51346 # v5=2E0=2E1
diff --git a/=2Egithub/workflows/=
test-ssllib=2Eyml b/=2Egithub/workflows/test-ssllib=2Eyml
index d8178a7=2E=
=2E64607cf 100644
--- a/=2Egithub/workflows/test-ssllib=2Eyml
+++ b/=2Egith=
ub/workflows/test-ssllib=2Eyml
@@ -70,14 +70,14 @@
       - name: Install d=
ependencies
         run: sudo apt update && sudo apt install -y liblzo2-de=
v libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev pytho=
n3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3=
-dev
       - name: Restore ${{inputs=2Elibname}} from cache
-        uses:=
 actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+     =
   uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E=
0
         id: ssllib-cache
         with:
           path: ${{env=2ELIBPRE=
FIX}}
           key: ${{matrix=2Eos}}-${{inputs=2Elibname}}-${{matrix=2Ebu=
ild }}-${{inputs=2Egitref}}
       - name: "${{inputs=2Elibname}}: checkout=
"
         if: steps=2Essllib-cache=2Eoutputs=2Ecache-hit !=3D 'true'
-    =
    uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E=
0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba9=
0b1 # v7=2E0=2E1
         with:
           submodules: recursive
          =
 path: ${{inputs=2Elibname}}
@@ -98,7 +98,7 @@
       - name: Run ldconfig
=
         run: sudo ldconfig
       - name: "OpenVPN: checkout"
-        use=
s: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+=
        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v=
7=2E0=2E1
       - name: "OpenVPN: autoreconf"
         run: autoreconf -fv=
i
       - name: "OpenVPN: configure"

-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1922?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
Gerrit-Chang=
e-Number: 1922
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razv=
anc <razvanc@mailbox=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eor=
g>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--cklTrKypFaI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld <strong>up=
loaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">GHA: Maintenance update September 2026<br><br>Contains the following=
 renovate updates:<br>- chore(deps): update vcpkg digest to 5f96cd1<br>- Up=
date dependency ubuntu to v26<br>- chore(deps): update dependency aws/aws-l=
c to v5=2E9=2E0<br>- chore(deps): update github actions<br>- Update github =
actions (major)<br><br>Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---=
<br>M =2Egithub/workflows/build=2Eyaml<br>M =2Egithub/workflows/coverity-sc=
an=2Eyml<br>M =2Egithub/workflows/doxygen=2Eyml<br>M =2Egithub/workflows/te=
st-ssllib=2Eyml<br>4 files changed, 34 insertions(+), 34 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/22/1922/3</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/=2Egithub/workflows/build=2Eyaml=
 b/=2Egithub/workflows/build=2Eyaml</span><br><span>index d67c215=2E=2E27f0=
8df 100644</span><br><span>--- a/=2Egithub/workflows/build=2Eyaml</span><br=
><span>+++ b/=2Egithub/workflows/build=2Eyaml</span><br><span>@@ -7,14 +7,1=
4 @@</span><br><span> jobs:</span><br><span>   clang-format:</span><br><spa=
n>     name: Check code style with clang-format</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=2E04</span><br><span style=
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
0, 100%, 40%);">-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae3617=
2462abb3a42e # v4=2E3=2E3</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90=
b1 # v7=2E0=2E1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4=2E4=
=2E2</span><br><span>       - name: Setup vcpkg</span><br><span>         us=
es: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6</spa=
n><br><span>         with:</span><br><span>           vcpkgGitCommitId: ${{=
 env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>       - name: Set up vcpkg b=
inary cache</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        us=
es: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/c=
ache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>=
         with:</span><br><span>           path: ${{ env=2EVCPKG_DEFAULT_BIN=
ARY_CACHE }}</span><br><span>           key: android-${{ matrix=2Eabi }}-vc=
pkg-binary-cache-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>@@ -82,18=
 +82,18 @@</span><br><span>         build: [Release, Debug]</span><br><span=
> </span><br><span>     name: &quot;gcc-mingw - ${{ matrix=2Earch }} - ${{ =
matrix=2Ebuild }} - OSSL&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    runs-on: ubuntu-24=2E04</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    runs-on: ubuntu-26=2E04</span><br><span>     env:</spa=
n><br><span>       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg</span><br><s=
pan>       VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-      VCPKG_GIT_COMMIT_ID: 75672db6bd812=
b060482b0f00b5a16b18a0c0f07</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07=
</span><br><span>     steps:</span><br><span>       - name: Install depende=
ncies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt ins=
tall -y mingw-w64 unzip build-essential wget python3-docutils man2html-base=
</span><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874ed=
d31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410=
c181273ba90b1 # v7=2E0=2E1</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@591817e96fcad43505fb4e=
ae36172462abb3a42e # v4=2E3=2E3</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008b=
c1caacb # v4=2E4=2E2</span><br><span>       - name: Setup vcpkg</span><br><=
span>         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a=
2 # v11=2E6</span><br><span>         with:</span><br><span>@@ -101,7 +101,7=
 @@</span><br><span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg=2Ejson&#3=
9;</span><br><span> </span><br><span>       - name: Set up vcpkg binary cac=
he</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actio=
ns/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache@55cc=
8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         =
with:</span><br><span>           path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE=
 }}</span><br><span>           key: mingw-${{ matrix=2Earch }}-vcpkg-binary=
-cache-${{ hashFiles(&#39;**/mingw/vcpkg=2Ejson&#39;) }}-${{ env=2EVCPKG_GI=
T_COMMIT_ID }}</span><br><span>@@ -144,7 +144,7 @@</span><br><span>     nam=
e: &quot;mingw unittest ${{ matrix=2Etest }} - ${{ matrix=2Earch }} - ${{ m=
atrix=2Ebuild }} - OSSL&quot;</span><br><span>     steps:</span><br><span> =
      - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172ce=
c0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=
=2E0=2E1</span><br><span>       - name: Retrieve mingw unittest</span><br><=
span>         uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e=
0b5a5461e7c # v8=2E0=2E1</span><br><span>         with:</span><br><span>@@ =
-185,7 +185,7 @@</span><br><span>       - name: Install dependencies</span>=
<br><span>         run: sudo apt update &amp;&amp; sudo apt install -y libl=
zo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-d=
ev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLP=
KG} ${PKCS11PKG}</span><br><span>       - name: Checkout OpenVPN</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@d=
f4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aa=
c5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>       - name: =
autoconf</span><br><span>         run: autoreconf -fvi</span><br><span>    =
   - name: configure</span><br><span>@@ -215,7 +215,7 @@</span><br><span>  =
     - name: Install dependencies</span><br><span>         run: sudo apt up=
date &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev lib=
cap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev pyt=
hon3-docutils libtool automake autoconf</span><br><span>       - name: Chec=
kout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u=
ses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br=
><span>       - name: autoconf</span><br><span>         run: autoreconf -fv=
i</span><br><span>       - name: configure</span><br><span>@@ -255,7 +255,7=
 @@</span><br><span>       - name: Install dependencies</span><br><span>   =
      run: brew install ${{matrix=2Essllib}} lzo lz4 man2html cmocka libtoo=
l automake autoconf</span><br><span>       - name: Checkout OpenVPN</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkou=
t@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5=
aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>       - name=
: Set environment</span><br><span>         run: |</span><br><span>         =
  cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span>@@ -285,12 +285,12 @=
@</span><br><span>       env:</span><br><span>         BUILD_CONFIGURATION:=
 Release</span><br><span>         VCPKG_BINARY_SOURCES: clear;default,readw=
rite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        VCPKG_GIT=
_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VCPKG_GIT_COMMIT_ID: 5f96cd15fd74=
5122cf27e0524606d6c1efc5fd07</span><br><span> </span><br><span>       runs-=
on: windows-2025-vs2026</span><br><span>       steps:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/checkout@df4cb1c069e1=
874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae3=
6172462abb3a42e # v4=2E3=2E3</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      - uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273b=
a90b1 # v7=2E0=2E1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4=
=2E4=2E2</span><br><span> </span><br><span>       - name: Install rst2html<=
/span><br><span>         run: python -m pip install --upgrade pip docutils<=
/span><br><span>@@ -302,7 +302,7 @@</span><br><span>           vcpkgJsonGlo=
b: &#39;**/windows/vcpkg=2Ejson&#39;</span><br><span> </span><br><span>    =
   - name: Set up vcpkg binary cache</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90=
386fccae # v5=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=
=2E1=2E0</span><br><span>         with:</span><br><span>           path: ${=
{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}</span><br><span>           key: msvc-=
${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles(&#39;**/windows/vcpkg=
=2Ejson&#39;) }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>@@ -380,7=
 +380,7 @@</span><br><span>       ovpnlibdesc: AWS-LC</span><br><span>     =
  # versioning=3Dsemver-coerced</span><br><span>       ghrepo: aws/aws-lc</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      gitref: v5=2E0=2E=
0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      gitref: v5=
=2E9=2E0</span><br><span>       libconfigure: cmake -B build -GNinja -DCMAK=
E_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D&quot;$LIBPREFIX&quot; -DBU=
ILD_SHARED_LIBS=3D1</span><br><span>       libmake: cmake --build build</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-      libinstall: sudo cm=
ake --install build</span><br><span>\ No newline at end of file</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      libinstall: sudo cmake --=
install build</span><br><span>diff --git a/=2Egithub/workflows/coverity-sca=
n=2Eyml b/=2Egithub/workflows/coverity-scan=2Eyml</span><br><span>index 105=
f23e=2E=2Ee103aec 100644</span><br><span>--- a/=2Egithub/workflows/coverity=
-scan=2Eyml</span><br><span>+++ b/=2Egithub/workflows/coverity-scan=2Eyml</=
span><br><span>@@ -9,11 +9,11 @@</span><br><span>     # Running coverity re=
quires the secrets=2ECOVERITY_SCAN_TOKEN token</span><br><span>     # which=
 is only available on the main repository</span><br><span>     if: github=
=2Erepository_owner =3D=3D &#39;OpenVPN&#39;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=2E04</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-26=2E04</span><br><span>=
     steps:</span><br><span>       - name: Check submission cache</span><br=
><span>         id: check_submit</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        uses: actions/cache/restore@27d5ce7f107fe9357f9df03efb73=
ab90386fccae # v5=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uses: actions/cache/restore@55cc8345863c7cc4c66a329aec7e433d2=
d1c52a9 # v6=2E1=2E0</span><br><span>         with:</span><br><span>       =
    path: |</span><br><span>             cov-int</span><br><span>@@ -25,7 +=
25,7 @@</span><br><span> </span><br><span>       - name: Checkout OpenVPN</=
span><br><span>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D=
 &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=
=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: a=
ctions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span=
><br><span> </span><br><span>       - name: Download Coverity Build Tool</s=
pan><br><span>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D =
&#39;true&#39;</span><br><span>@@ -65,7 +65,7 @@</span><br><span> </span><b=
r><span>       - name: Cache submission</span><br><span>         if: steps=
=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/save@27d5ce=
7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: actions/cache/save@55cc8345863c7c=
c4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         with:</spa=
n><br><span>           path: |</span><br><span>             cov-int</span><=
br><span>diff --git a/=2Egithub/workflows/doxygen=2Eyml b/=2Egithub/workflo=
ws/doxygen=2Eyml</span><br><span>index 3755b92=2E=2E784f81e 100644</span><b=
r><span>--- a/=2Egithub/workflows/doxygen=2Eyml</span><br><span>+++ b/=2Egi=
thub/workflows/doxygen=2Eyml</span><br><span>@@ -8,10 +8,10 @@</span><br><s=
pan>   cancel-in-progress: false</span><br><span> jobs:</span><br><span>   =
build:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: ub=
untu-24=2E04</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run=
s-on: ubuntu-26=2E04</span><br><span>     if: ${{ github=2Erepository_owner=
 =3D=3D &#39;openvpn&#39; || github=2Eevent_name =3D=3D &#39;workflow_dispa=
tch&#39; }}</span><br><span>     steps:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      - uses: actions/checkout@df4cb1c069e1874edd31b4311f=
1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      - uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba=
90b1 # v7=2E0=2E1</span><br><span>         with:</span><br><span>          =
 path: openvpn</span><br><span> </span><br><span>@@ -35,7 +35,7 @@</span><b=
r><span>           touch doc/doxygen/html/=2Enojekyll</span><br><span>     =
  - name: Upload static files as artifact</span><br><span>         id: depl=
oyment</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: a=
ctions/upload-pages-artifact@fc324d3547104276b827a68afc52ff2a11cc49c9 # v5<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: action=
s/upload-pages-artifact@fc324d3547104276b827a68afc52ff2a11cc49c9 # v5=2E0=
=2E0</span><br><span>         with:</span><br><span>           path: doxyge=
n/doc/doxygen/html/</span><br><span> </span><br><span>@@ -47,8 +47,8 @@</sp=
an><br><span>     environment:</span><br><span>       name: github-pages</s=
pan><br><span>       url: ${{ steps=2Edeployment=2Eoutputs=2Epage_url }}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=
=2E04</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: u=
buntu-26=2E04</span><br><span>     steps:</span><br><span>       - name: De=
ploy to GitHub Pages</span><br><span>         id: deployment</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/deploy-pages@c=
d2ce8fcbc39b97be8ca5fce6e763baed58fa128 # v5</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: actions/deploy-pages@368f82528645a54=
fb793d4d04e342629a3f51346 # v5=2E0=2E1</span><br><span>diff --git a/=2Egith=
ub/workflows/test-ssllib=2Eyml b/=2Egithub/workflows/test-ssllib=2Eyml</spa=
n><br><span>index d8178a7=2E=2E64607cf 100644</span><br><span>--- a/=2Egith=
ub/workflows/test-ssllib=2Eyml</span><br><span>+++ b/=2Egithub/workflows/te=
st-ssllib=2Eyml</span><br><span>@@ -70,14 +70,14 @@</span><br><span>       =
- name: Install dependencies</span><br><span>         run: sudo apt update =
&amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-li=
bc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoc=
onf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><span>       - name=
: Restore ${{inputs=2Elibname}} from cache</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        uses: actions/cache@27d5ce7f107fe9357f9df03efb=
73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a=
9 # v6=2E1=2E0</span><br><span>         id: ssllib-cache</span><br><span>  =
       with:</span><br><span>           path: ${{env=2ELIBPREFIX}}</span><b=
r><span>           key: ${{matrix=2Eos}}-${{inputs=2Elibname}}-${{matrix=2E=
build }}-${{inputs=2Egitref}}</span><br><span>       - name: &quot;${{input=
s=2Elibname}}: checkout&quot;</span><br><span>         if: steps=2Essllib-c=
ache=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874edd3=
1b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c1=
81273ba90b1 # v7=2E0=2E1</span><br><span>         with:</span><br><span>   =
        submodules: recursive</span><br><span>           path: ${{inputs=2E=
libname}}</span><br><span>@@ -98,7 +98,7 @@</span><br><span>       - name: =
Run ldconfig</span><br><span>         run: sudo ldconfig</span><br><span>  =
     - name: &quot;OpenVPN: checkout&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874edd31b43=
11f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c18127=
3ba90b1 # v7=2E0=2E1</span><br><span>       - name: &quot;OpenVPN: autoreco=
nf&quot;</span><br><span>         run: autoreconf -fvi</span><br><span>    =
   - name: &quot;OpenVPN: configure&quot;</span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail">cha=
nge 1922</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1922 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>

</body></html>
--cklTrKypFaI=--


--===============4955811145940222307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4955811145940222307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4955811145940222307==--

