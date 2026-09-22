Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A894C98307
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wYBHUnY954StRG6gG7Wnd/GaiN6oBkuWJTnF0cmZlG4=; b=i9oo+kGQ5d6mobXxy3DA8M17j8
	W9njFIgIxxDHl1oP0Ttj5kV5QSqjZM6oGyzS33N84GuJDR3ePi/iQfoX2IGYOUy+wLIPrZZffBJD1
	t+di8xTP3tA7aat0CwVixvrNEwRZQtIR3bGXQUXmQ/YiaWUiNGYZTriglijXqJrcM/T0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x93pE-0002iU-MR;
	Tue, 22 Sep 2026 16:58:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x93pA-0002hq-Gw
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 16:58:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wMOfURnfZw1TIHM66A+QcyVtwP1QSyidykAg7biKHpc=; b=Cu6ZGucoIAFVtA8psh0HSy5ZsJ
 9guDwOLE/4LE+ee4qyYh1y1Ma529d5weqbqistfqoa4vJ2neRmpkvbTggtQbq/rb7vMqrEyMSQhNg
 f5UdASkP1S7dyJv9Bj57YCqWDR7vEEfA+NTTXzO8a1b6tH0aN2Vvw1+Em9q3eYCuivhM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wMOfURnfZw1TIHM66A+QcyVtwP1QSyidykAg7biKHpc=; b=E
 1L/gMJVaUVGH9JzUv2gfmt9E2aAYrctn6AfuRDwQiGSclGw1WE2A0bIcKyXFuLNR4ryB8EjTRbai8
 ig4VEEasNB4NEwJvzQvRcvVeA6l054b+HjUFMKGZuXNVpc5VfxyCJ/zU//u11HGyP9lNMChDm1/lH
 wQfZbNA+38vThoNQ=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x93p2-0000Z2-R8 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 16:58:26 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so127641f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790096298; x=1790701098; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wMOfURnfZw1TIHM66A+QcyVtwP1QSyidykAg7biKHpc=;
 b=bC7bNnOQgcP0jdsxySqiK/iYTxom51fdGwTdxRC7XQPk1qbSKyTPVTWxsrCq34xNKR
 4Flb5HuBcgjXx2PBD2Is9vxemr8l2TT8qHi7aDLDfrSWTA8oPS59Z/w75i04KFZCge8R
 q4ncRItqnve5iCYhvRwJ2yccPlDQDNAUTS/QLLlG0gREunMFo1LNZHJkO5vUrtZuHay3
 v9dB/lXUjsYmA/Kalxggl368eF80XdJmZDxXUdVWbSgDpTx6VwM0mWQISO5Ep65r+PUx
 YC1vbx97nqj4UjBnB9Xkiuo3WDz27UkjERmUHuCPEo0VYxz89+GzQ3YoSfrWqWel4rdX
 E7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790096298; x=1790701098;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wMOfURnfZw1TIHM66A+QcyVtwP1QSyidykAg7biKHpc=;
 b=1k0KOxejdYv5EN0Qgy7SKpNoBLhNh25Tg8rjBc9zbOho/jE7uVhIQYv7f6bZ+g9J7t
 fw5AH1EwjO4PqhDbje+x2eZ5gESXd1oEX6edINcQdU50Ik6pxOV2NE7FjZiPiVgKcdou
 FHIahDT2bPEXlU8GvNoiT8x7lnhWBKduTi25UYFkYr7MsTv0J29Kyb6BW8hC9BneddWx
 S31D2ABmEMJxWyTeCd2FVQcNT/BQb/0MAAOD6NBU6qSdSNV5LPuJpdPLA9KxnoWYbHOy
 VuXMPtWQrD0QhYrMh25gpk4j4DH/lH3sNM0IyBxWuFAc50xm7JW679oQ1PEWgSYIp/lW
 366A==
X-Forwarded-Encrypted: i=1;
 AKwUvByCp9DPTj5n3Olr4WLvPvm8gRfHfoU9K0QxPH+N9mEdMccA+Aa8KNDQIcGFJc7X63hAxwkc3kdlALB8cOY6@lists.sourceforge.net
X-Gm-Message-State: AFuF++mXCPhCKXRqBrJJUw14lnUoS88o4/FoKDmoBPPxl47+AfTpugBj
 aWbuXq7oJo6d7odcQeUTJfHsk6yop9XA4Zce87+RgsjTubZ+gvU7Xt6T96Tv9GKiTK7HvU8I3ID
 LkLetKsmmzqH85ioI5a8AxSH7DrOCSGlP6j49/siQtjRJV6zGULugO63tvfBwV4XmEuayiiW2Rl
 KIv+tVZw==
X-Gm-Gg: AYBFou29Ys2+67JtUut9i6Ahy6BpIrolwPHQvG5uOrpc+PFhbUE8NHHurvLZaJR7NhQ
 Qf/9oHOH6AX2PwnHWjmjx6IckA3LSJ54bfw227LdF+JLMWvSHTbHalQT+GIXCT1X2l0XyeU8mYz
 d+oJgzaSHsenqY4HbFXwMRLabA0tdW+gr1MVOzP12LeHACINm+lg2kyM/4UH/XGoUEbab+MwQTL
 cFskVsKiENp1YcQmZXSsTVxOgvi/Ml/XIiL9ATZeuB+IYml8yoZO2VEfYLRJR7Wv/zpNFFzGGSn
 uSSZR9KsIIKJlHcJMpwRcknK//+hAg8Tph5K4qfi1a56dvxfn4Rb34WDFcWfnnnHZvUbem7RXna
 tkRmPGeSqKajUalu8N+/N92jdIkGWChmna+x91OyPIj6h05KT63ZKM59wwX/8PsSFYxBakdHODJ
 s5PMlGwWNHXWBNtcnJrCSxX1dHvjR/IHkqJMw45KUlZhRTR3WBtS5SWp5NYOd7xOYFck/QoLDhd
 PF+BaRrrgdM30oio08IEW+gevfOxG0bNUjYZV6FoD9sVMdEUUyFGwHknA7y7XJQtTTkLmVSE3kj
 Pp+JeamYMPFLUGd24LI0o9KzZTVcW6/INSnt6s+JNNLBiKO/f48bAMs2z8jr
X-Received: by 2002:a05:6000:4b04:b0:487:27f9:839 with SMTP id
 ffacd0b85a97d-48867098400mr288898f8f.46.1790096298004; 
 Tue, 22 Sep 2026 09:58:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886277e185sm6554130f8f.16.2026.09.22.09.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 09:58:17 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 16:58:15 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
X-Gerrit-Change-Number: 1922
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1922?usp=email>
X-Gerrit-Commit: 0cc99b10b4464bdeaa8c254f8388aeb241e8e8b6
In-Reply-To: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
References: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDA2MzgxMDAwLkk5ODNkNjdlMWM5MGJlYTQ2MGY1MzFmMTFkNGM1OGQzM2EzNTFkODFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bdf3ec8e03dee47b6777ff658f84516cb402859a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x93p2-0000Z2-R8
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5026884303453178299=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5026884303453178299==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cDO1iwo7NLs="; charset=UTF-8

--cDO1iwo7NLs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1922?usp=3Demail )

Change subject: GHA: Maintenance update September 2=
026
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Ma=
intenance update September 2026

Contains the following renovate updates:
-=
 chore(deps): update vcpkg digest to 5f96cd1
- Update dependency ubuntu to =
v26
- chore(deps): update dependency aws/aws-lc to v5=2E9=2E0
- chore(deps)=
: update github actions
- Update github actions (major)

Change-Id: I983d67=
e1c90bea460f531f11d4c58d33a351d81b
Signed-off-by: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922
Message-Id: <20260922=
120433=2E29303-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39391=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =2Egithub/workflows/build=
=2Eyaml
M =2Egithub/workflows/coverity-scan=2Eyml
M =2Egithub/workflows/dox=
ygen=2Eyml
M =2Egithub/workflows/test-ssllib=2Eyml
4 files changed, 34 inse=
rtions(+), 34 deletions(-)




diff --git a/=2Egithub/workflows/build=2Eyam=
l b/=2Egithub/workflows/build=2Eyaml
index d67c215=2E=2E27f08df 100644
--- =
a/=2Egithub/workflows/build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@=
@ -7,14 +7,14 @@
 jobs:
   clang-format:
     name: Check code style with c=
lang-format
-    runs-on: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E04
     =
steps:
       - name: Install dependencies
         run: |
           sudo =
apt update && sudo apt install -y python3-pip
           pip3 install pre-c=
ommit
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb=
1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/che=
ckout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
       - name: =
Run clang-format
         run: pre-commit run -a --show-diff-on-failure || =
true
       - name: Check for changes
@@ -34,7 +34,7 @@
         include:
 =
          - abi: arm64-v8a
             vcpkg_triplet: arm64-android
-    r=
uns-on: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E04
     name: "Android - $=
{{ matrix=2Eabi }}"
     # Github images already setup NDK with ANDROID_NDK=
_ROOT pointing to the root
     # of the SDK
@@ -43,17 +43,17 @@
       VCP=
KG_ROOT: ${{ github=2Eworkspace }}/vcpkg
       VCPKG_INSTALLED_DIR: ${{ gi=
thub=2Eworkspace }}/vcpkg/installed
       VCPKG_BINARY_SOURCES: clear;defa=
ult,readwrite
-      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18=
a0c0f07
+      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd0=
7
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checko=
ut@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
-      - uses: luk=
ka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3
+       =
 uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=
=2E1
+      - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caac=
b # v4=2E4=2E2
       - name: Setup vcpkg
         uses: lukka/run-vcpkg@b1=
a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
         with:
           =
vcpkgGitCommitId: ${{ env=2EVCPKG_GIT_COMMIT_ID }}
       - name: Set up vc=
pkg binary cache
-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73a=
b90386fccae # v5=2E0=2E5
+        uses: actions/cache@55cc8345863c7cc4c66a3=
29aec7e433d2d1c52a9 # v6=2E1=2E0
         with:
           path: ${{ env=2E=
VCPKG_DEFAULT_BINARY_CACHE }}
           key: android-${{ matrix=2Eabi }}-v=
cpkg-binary-cache-${{ env=2EVCPKG_GIT_COMMIT_ID }}
@@ -82,18 +82,18 @@
    =
     build: [Release, Debug]
 
     name: "gcc-mingw - ${{ matrix=2Earch }}=
 - ${{ matrix=2Ebuild }} - OSSL"
-    runs-on: ubuntu-24=2E04
+    runs-on:=
 ubuntu-26=2E04
     env:
       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpk=
g
       VCPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COM=
MIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
+      VCPKG_GIT_COMMIT_ID=
: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
     steps:
       - name: Insta=
ll dependencies
         run: sudo apt update && sudo apt install -y mingw-=
w64 unzip build-essential wget python3-docutils man2html-base
       - name=
: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b431=
1f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5b=
a805825da76410c181273ba90b1 # v7=2E0=2E1
 
-      - uses: lukka/get-cmake@5=
91817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3
+      - uses: lukka/g=
et-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4=2E4=2E2
       - nam=
e: Setup vcpkg
         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03b=
d7a427fb6a2 # v11=2E6
         with:
@@ -101,7 +101,7 @@
           vcpkgJs=
onGlob: '**/mingw/vcpkg=2Ejson'
 
       - name: Set up vcpkg binary cache
=
-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=
=2E0=2E5
+        uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c5=
2a9 # v6=2E1=2E0
         with:
           path: ${{ env=2EVCPKG_DEFAULT_BI=
NARY_CACHE }}
           key: mingw-${{ matrix=2Earch }}-vcpkg-binary-cache=
-${{ hashFiles('**/mingw/vcpkg=2Ejson') }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}=

@@ -144,7 +144,7 @@
     name: "mingw unittest ${{ matrix=2Etest }} - ${{ =
matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL"
     steps:
       - name:=
 Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311=
f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba=
805825da76410c181273ba90b1 # v7=2E0=2E1
       - name: Retrieve mingw unitt=
est
         uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0=
b5a5461e7c # v8=2E0=2E1
         with:
@@ -185,7 +185,7 @@
       - name: I=
nstall dependencies
         run: sudo apt update && sudo apt install -y li=
blzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc=
-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SS=
LPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/c=
heckout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses=
: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
  =
     - name: autoconf
         run: autoreconf -fvi
       - name: configur=
e
@@ -215,7 +215,7 @@
       - name: Install dependencies
         run: sud=
o apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev lib=
cap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev pyt=
hon3-docutils libtool automake autoconf
       - name: Checkout OpenVPN
-  =
      uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=
=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273=
ba90b1 # v7=2E0=2E1
       - name: autoconf
         run: autoreconf -fvi
 =
      - name: configure
@@ -255,7 +255,7 @@
       - name: Install dependen=
cies
         run: brew install ${{matrix=2Essllib}} lzo lz4 man2html cmock=
a libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: =
actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+   =
     uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=
=2E0=2E1
       - name: Set environment
         run: |
           cat >>$G=
ITHUB_ENV <<EOF;
@@ -285,12 +285,12 @@
       env:
         BUILD_CONFIGURA=
TION: Release
         VCPKG_BINARY_SOURCES: clear;default,readwrite
-     =
   VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
+        V=
CPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
 
       runs-=
on: windows-2025-vs2026
       steps:
-      - uses: actions/checkout@df4cb=
1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
-      - uses: lukka/get-c=
make@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3
+      - uses: a=
ctions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
+    =
  - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4=2E4=
=2E2
 
       - name: Install rst2html
         run: python -m pip install =
--upgrade pip docutils
@@ -302,7 +302,7 @@
           vcpkgJsonGlob: '**/wi=
ndows/vcpkg=2Ejson'
 
       - name: Set up vcpkg binary cache
-        use=
s: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+   =
     uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=
=2E0
         with:
           path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }=
}
           key: msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFile=
s('**/windows/vcpkg=2Ejson') }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}
@@ -380,7 =
+380,7 @@
       ovpnlibdesc: AWS-LC
       # versioning=3Dsemver-coerced
 =
      ghrepo: aws/aws-lc
-      gitref: v5=2E0=2E0
+      gitref: v5=2E9=2E=
0
       libconfigure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=3DRelease =
-DCMAKE_INSTALL_PREFIX=3D"$LIBPREFIX" -DBUILD_SHARED_LIBS=3D1
       libmak=
e: cmake --build build
-      libinstall: sudo cmake --install build
\ No n=
ewline at end of file
+      libinstall: sudo cmake --install build
diff --=
git a/=2Egithub/workflows/coverity-scan=2Eyml b/=2Egithub/workflows/coverit=
y-scan=2Eyml
index 105f23e=2E=2Ee103aec 100644
--- a/=2Egithub/workflows/co=
verity-scan=2Eyml
+++ b/=2Egithub/workflows/coverity-scan=2Eyml
@@ -9,11 +9=
,11 @@
     # Running coverity requires the secrets=2ECOVERITY_SCAN_TOKEN t=
oken
     # which is only available on the main repository
     if: github=
=2Erepository_owner =3D=3D 'OpenVPN'
-    runs-on: ubuntu-24=2E04
+    runs=
-on: ubuntu-26=2E04
     steps:
       - name: Check submission cache
     =
    id: check_submit
-        uses: actions/cache/restore@27d5ce7f107fe9357=
f9df03efb73ab90386fccae # v5=2E0=2E5
+        uses: actions/cache/restore@5=
5cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
         with:
       =
    path: |
             cov-int
@@ -25,7 +25,7 @@
 
       - name: Checkou=
t OpenVPN
         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'tru=
e'
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10=
 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c1=
81273ba90b1 # v7=2E0=2E1
 
       - name: Download Coverity Build Tool
    =
     if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'true'
@@ -65,7 +6=
5,7 @@
 
       - name: Cache submission
         if: steps=2Echeck_submit=
=2Eoutputs=2Ecache-hit !=3D 'true'
-        uses: actions/cache/save@27d5ce=
7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+        uses: actions/cach=
e/save@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
         with:=

           path: |
             cov-int
diff --git a/=2Egithub/workflows/d=
oxygen=2Eyml b/=2Egithub/workflows/doxygen=2Eyml
index 3755b92=2E=2E784f81e=
 100644
--- a/=2Egithub/workflows/doxygen=2Eyml
+++ b/=2Egithub/workflows/d=
oxygen=2Eyml
@@ -8,10 +8,10 @@
   cancel-in-progress: false
 jobs:
   build=
:
-    runs-on: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E04
     if: ${{ gi=
thub=2Erepository_owner =3D=3D 'openvpn' || github=2Eevent_name =3D=3D 'wor=
kflow_dispatch' }}
     steps:
-      - uses: actions/checkout@df4cb1c069e1=
874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+      - uses: actions/checkout@3=
d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
         with:
       =
    path: openvpn
 
@@ -35,7 +35,7 @@
           touch doc/doxygen/html/=2E=
nojekyll
       - name: Upload static files as artifact
         id: deploy=
ment
-        uses: actions/upload-pages-artifact@fc324d3547104276b827a68af=
c52ff2a11cc49c9 # v5
+        uses: actions/upload-pages-artifact@fc324d354=
7104276b827a68afc52ff2a11cc49c9 # v5=2E0=2E0
         with:
           path=
: doxygen/doc/doxygen/html/
 
@@ -47,8 +47,8 @@
     environment:
       na=
me: github-pages
       url: ${{ steps=2Edeployment=2Eoutputs=2Epage_url }}=

-    runs-on: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E04
     steps:
    =
   - name: Deploy to GitHub Pages
         id: deployment
-        uses: ac=
tions/deploy-pages@cd2ce8fcbc39b97be8ca5fce6e763baed58fa128 # v5
+        u=
ses: actions/deploy-pages@368f82528645a54fb793d4d04e342629a3f51346 # v5=2E0=
=2E1
diff --git a/=2Egithub/workflows/test-ssllib=2Eyml b/=2Egithub/workflo=
ws/test-ssllib=2Eyml
index d8178a7=2E=2E64607cf 100644
--- a/=2Egithub/work=
flows/test-ssllib=2Eyml
+++ b/=2Egithub/workflows/test-ssllib=2Eyml
@@ -70,=
14 +70,14 @@
       - name: Install dependencies
         run: sudo apt upd=
ate && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-d=
ev man2html clang libcmocka-dev python3-docutils libtool automake autoconf =
pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: Restore ${{inputs=
=2Elibname}} from cache
-        uses: actions/cache@27d5ce7f107fe9357f9df0=
3efb73ab90386fccae # v5=2E0=2E5
+        uses: actions/cache@55cc8345863c7c=
c4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
         id: ssllib-cache
         =
with:
           path: ${{env=2ELIBPREFIX}}
           key: ${{matrix=2Eos}=
}-${{inputs=2Elibname}}-${{matrix=2Ebuild }}-${{inputs=2Egitref}}
       - =
name: "${{inputs=2Elibname}}: checkout"
         if: steps=2Essllib-cache=
=2Eoutputs=2Ecache-hit !=3D 'true'
-        uses: actions/checkout@df4cb1c0=
69e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/checko=
ut@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
         with:
   =
        submodules: recursive
           path: ${{inputs=2Elibname}}
@@ -98=
,7 +98,7 @@
       - name: Run ldconfig
         run: sudo ldconfig
       =
- name: "OpenVPN: checkout"
-        uses: actions/checkout@df4cb1c069e1874=
edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c=
42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
       - name: "OpenVPN: =
autoreconf"
         run: autoreconf -fvi
       - name: "OpenVPN: configur=
e"

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I983d67e1c90bea46=
0f531f11d4c58d33a351d81b
Gerrit-Change-Number: 1922
Gerrit-PatchSet: 4
Gerr=
it-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--cDO1iwo7NLs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1922?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">GHA: Maintenance update September 2026<br>=
<br>Contains the following renovate updates:<br>- chore(deps): update vcpkg=
 digest to 5f96cd1<br>- Update dependency ubuntu to v26<br>- chore(deps): u=
pdate dependency aws/aws-lc to v5=2E9=2E0<br>- chore(deps): update github a=
ctions<br>- Update github actions (major)<br><br>Change-Id: I983d67e1c90bea=
460f531f11d4c58d33a351d81b<br>Signed-off-by: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922<br>Messa=
ge-Id: &lt;20260922120433=2E29303-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39=
391=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<b=
r>---<br>M =2Egithub/workflows/build=2Eyaml<br>M =2Egithub/workflows/coveri=
ty-scan=2Eyml<br>M =2Egithub/workflows/doxygen=2Eyml<br>M =2Egithub/workflo=
ws/test-ssllib=2Eyml<br>4 files changed, 34 insertions(+), 34 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/=
workflows/build=2Eyaml</span><br><span>index d67c215=2E=2E27f08df 100644</s=
pan><br><span>--- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=
=2Egithub/workflows/build=2Eyaml</span><br><span>@@ -7,14 +7,14 @@</span><b=
r><span> jobs:</span><br><span>   clang-format:</span><br><span>     name: =
Check code style with clang-format</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    runs-on: ubuntu-24=2E04</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    runs-on: ubuntu-26=2E04</span><br><span>     steps=
:</span><br><span>       - name: Install dependencies</span><br><span>     =
    run: |</span><br><span>           sudo apt update &amp;&amp; sudo apt i=
nstall -y python3-pip</span><br><span>           pip3 install pre-commit</s=
pan><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874edd31=
b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c18=
1273ba90b1 # v7=2E0=2E1</span><br><span>       - name: Run clang-format</sp=
an><br><span>         run: pre-commit run -a --show-diff-on-failure || true=
</span><br><span>       - name: Check for changes</span><br><span>@@ -34,7 =
+34,7 @@</span><br><span>         include:</span><br><span>           - abi=
: arm64-v8a</span><br><span>             vcpkg_triplet: arm64-android</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=2E04=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu=
-26=2E04</span><br><span>     name: &quot;Android - ${{ matrix=2Eabi }}&quo=
t;</span><br><span>     # Github images already setup NDK with ANDROID_NDK_=
ROOT pointing to the root</span><br><span>     # of the SDK</span><br><span=
>@@ -43,17 +43,17 @@</span><br><span>       VCPKG_ROOT: ${{ github=2Eworksp=
ace }}/vcpkg</span><br><span>       VCPKG_INSTALLED_DIR: ${{ github=2Eworks=
pace }}/vcpkg/installed</span><br><span>       VCPKG_BINARY_SOURCES: clear;=
default,readwrite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 5f96=
cd15fd745122cf27e0524606d6c1efc5fd07</span><br><span>     steps:</span><br>=
<span>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874edd31b4311f18=
84172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e =
# v4=2E3=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=
=2E1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: l=
ukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4=2E4=2E2</span>=
<br><span>       - name: Setup vcpkg</span><br><span>         uses: lukka/r=
un-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6</span><br><span=
>         with:</span><br><span>           vcpkgGitCommitId: ${{ env=2EVCPK=
G_GIT_COMMIT_ID }}</span><br><span>       - name: Set up vcpkg binary cache=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions=
/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache@55cc83=
45863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         wi=
th:</span><br><span>           path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }=
}</span><br><span>           key: android-${{ matrix=2Eabi }}-vcpkg-binary-=
cache-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>@@ -82,18 +82,18 @@<=
/span><br><span>         build: [Release, Debug]</span><br><span> </span><b=
r><span>     name: &quot;gcc-mingw - ${{ matrix=2Earch }} - ${{ matrix=2Ebu=
ild }} - OSSL&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  runs-on: ubuntu-24=2E04</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    runs-on: ubuntu-26=2E04</span><br><span>     env:</span><br><span=
>       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg</span><br><span>       =
VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f0=
0b5a16b18a0c0f07</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07</span><br>=
<span>     steps:</span><br><span>       - name: Install dependencies</span=
><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y min=
gw-w64 unzip build-essential wget python3-docutils man2html-base</span><br>=
<span>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874edd31b4311f18=
84172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90=
b1 # v7=2E0=2E1</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462a=
bb3a42e # v4=2E3=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v=
4=2E4=2E2</span><br><span>       - name: Setup vcpkg</span><br><span>      =
   uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6=
</span><br><span>         with:</span><br><span>@@ -101,7 +101,7 @@</span><=
br><span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg=2Ejson&#39;</span><b=
r><span> </span><br><span>       - name: Set up vcpkg binary cache</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache@27=
d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache@55cc8345863c7=
cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         with:</sp=
an><br><span>           path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}</span=
><br><span>           key: mingw-${{ matrix=2Earch }}-vcpkg-binary-cache-${=
{ hashFiles(&#39;**/mingw/vcpkg=2Ejson&#39;) }}-${{ env=2EVCPKG_GIT_COMMIT_=
ID }}</span><br><span>@@ -144,7 +144,7 @@</span><br><span>     name: &quot;=
mingw unittest ${{ matrix=2Etest }} - ${{ matrix=2Earch }} - ${{ matrix=2Eb=
uild }} - OSSL&quot;</span><br><span>     steps:</span><br><span>       - n=
ame: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v=
6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1<=
/span><br><span>       - name: Retrieve mingw unittest</span><br><span>    =
     uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e=
7c # v8=2E0=2E1</span><br><span>         with:</span><br><span>@@ -185,7 +1=
85,7 @@</span><br><span>       - name: Install dependencies</span><br><span=
>         run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev l=
ibpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2ht=
ml libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKC=
S11PKG}</span><br><span>       - name: Checkout OpenVPN</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069=
e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805825=
da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>       - name: autoconf</=
span><br><span>         run: autoreconf -fvi</span><br><span>       - name:=
 configure</span><br><span>@@ -215,7 +215,7 @@</span><br><span>       - nam=
e: Install dependencies</span><br><span>         run: sudo apt update &amp;=
&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev=
 libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docut=
ils libtool automake autoconf</span><br><span>       - name: Checkout OpenV=
PN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actio=
ns/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkou=
t@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>   =
    - name: autoconf</span><br><span>         run: autoreconf -fvi</span><b=
r><span>       - name: configure</span><br><span>@@ -255,7 +255,7 @@</span>=
<br><span>       - name: Install dependencies</span><br><span>         run:=
 brew install ${{matrix=2Essllib}} lzo lz4 man2html cmocka libtool automake=
 autoconf</span><br><span>       - name: Checkout OpenVPN</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c0=
69e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba8058=
25da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>       - name: Set envi=
ronment</span><br><span>         run: |</span><br><span>           cat &gt;=
&gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span>@@ -285,12 +285,12 @@</span><b=
r><span>       env:</span><br><span>         BUILD_CONFIGURATION: Release</=
span><br><span>         VCPKG_BINARY_SOURCES: clear;default,readwrite</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        VCPKG_GIT_COMMIT_ID=
: 75672db6bd812b060482b0f00b5a16b18a0c0f07</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e05=
24606d6c1efc5fd07</span><br><span> </span><br><span>       runs-on: windows=
-2025-vs2026</span><br><span>       steps:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      - uses: actions/checkout@df4cb1c069e1874edd31b43=
11f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3=
a42e # v4=2E3=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    - uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=
=2E0=2E1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - use=
s: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4=2E4=2E2</s=
pan><br><span> </span><br><span>       - name: Install rst2html</span><br><=
span>         run: python -m pip install --upgrade pip docutils</span><br><=
span>@@ -302,7 +302,7 @@</span><br><span>           vcpkgJsonGlob: &#39;**/=
windows/vcpkg=2Ejson&#39;</span><br><span> </span><br><span>       - name: =
Set up vcpkg binary cache</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # =
v5=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
ses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</s=
pan><br><span>         with:</span><br><span>           path: ${{ env=2EVCP=
KG_DEFAULT_BINARY_CACHE }}</span><br><span>           key: msvc-${{ matrix=
=2Earch }}-vcpkg-binary-cache-${{ hashFiles(&#39;**/windows/vcpkg=2Ejson&#3=
9;) }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>@@ -380,7 +380,7 @@=
</span><br><span>       ovpnlibdesc: AWS-LC</span><br><span>       # versio=
ning=3Dsemver-coerced</span><br><span>       ghrepo: aws/aws-lc</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-      gitref: v5=2E0=2E0</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      gitref: v5=2E9=2E0</sp=
an><br><span>       libconfigure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=
=3DRelease -DCMAKE_INSTALL_PREFIX=3D&quot;$LIBPREFIX&quot; -DBUILD_SHARED_L=
IBS=3D1</span><br><span>       libmake: cmake --build build</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      libinstall: sudo cmake --instal=
l build</span><br><span>\ No newline at end of file</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      libinstall: sudo cmake --install bu=
ild</span><br><span>diff --git a/=2Egithub/workflows/coverity-scan=2Eyml b/=
=2Egithub/workflows/coverity-scan=2Eyml</span><br><span>index 105f23e=2E=2E=
e103aec 100644</span><br><span>--- a/=2Egithub/workflows/coverity-scan=2Eym=
l</span><br><span>+++ b/=2Egithub/workflows/coverity-scan=2Eyml</span><br><=
span>@@ -9,11 +9,11 @@</span><br><span>     # Running coverity requires the=
 secrets=2ECOVERITY_SCAN_TOKEN token</span><br><span>     # which is only a=
vailable on the main repository</span><br><span>     if: github=2Erepositor=
y_owner =3D=3D &#39;OpenVPN&#39;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    runs-on: ubuntu-24=2E04</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    runs-on: ubuntu-26=2E04</span><br><span>     steps:<=
/span><br><span>       - name: Check submission cache</span><br><span>     =
    id: check_submit</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       uses: actions/cache/restore@27d5ce7f107fe9357f9df03efb73ab90386fccae=
 # v5=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  uses: actions/cache/restore@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=
=2E1=2E0</span><br><span>         with:</span><br><span>           path: |<=
/span><br><span>             cov-int</span><br><span>@@ -25,7 +25,7 @@</spa=
n><br><span> </span><br><span>       - name: Checkout OpenVPN</span><br><sp=
an>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D &#39;true&#=
39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: acti=
ons/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checko=
ut@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span> <=
/span><br><span>       - name: Download Coverity Build Tool</span><br><span=
>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D &#39;true&#39=
;</span><br><span>@@ -65,7 +65,7 @@</span><br><span> </span><br><span>     =
  - name: Cache submission</span><br><span>         if: steps=2Echeck_submi=
t=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        uses: actions/cache/save@27d5ce7f107fe9357f9d=
f03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        uses: actions/cache/save@55cc8345863c7cc4c66a329aec7e=
433d2d1c52a9 # v6=2E1=2E0</span><br><span>         with:</span><br><span>  =
         path: |</span><br><span>             cov-int</span><br><span>diff =
--git a/=2Egithub/workflows/doxygen=2Eyml b/=2Egithub/workflows/doxygen=2Ey=
ml</span><br><span>index 3755b92=2E=2E784f81e 100644</span><br><span>--- a/=
=2Egithub/workflows/doxygen=2Eyml</span><br><span>+++ b/=2Egithub/workflows=
/doxygen=2Eyml</span><br><span>@@ -8,10 +8,10 @@</span><br><span>   cancel-=
in-progress: false</span><br><span> jobs:</span><br><span>   build:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=2E04</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-2=
6=2E04</span><br><span>     if: ${{ github=2Erepository_owner =3D=3D &#39;o=
penvpn&#39; || github=2Eevent_name =3D=3D &#39;workflow_dispatch&#39; }}</s=
pan><br><span>     steps:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10=
 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
- uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=
=2E1</span><br><span>         with:</span><br><span>           path: openvp=
n</span><br><span> </span><br><span>@@ -35,7 +35,7 @@</span><br><span>     =
      touch doc/doxygen/html/=2Enojekyll</span><br><span>       - name: Upl=
oad static files as artifact</span><br><span>         id: deployment</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/upload=
-pages-artifact@fc324d3547104276b827a68afc52ff2a11cc49c9 # v5</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/upload-page=
s-artifact@fc324d3547104276b827a68afc52ff2a11cc49c9 # v5=2E0=2E0</span><br>=
<span>         with:</span><br><span>           path: doxygen/doc/doxygen/h=
tml/</span><br><span> </span><br><span>@@ -47,8 +47,8 @@</span><br><span>  =
   environment:</span><br><span>       name: github-pages</span><br><span> =
      url: ${{ steps=2Edeployment=2Eoutputs=2Epage_url }}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=2E04</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-26=2E04</sp=
an><br><span>     steps:</span><br><span>       - name: Deploy to GitHub Pa=
ges</span><br><span>         id: deployment</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        uses: actions/deploy-pages@cd2ce8fcbc39b97be8=
ca5fce6e763baed58fa128 # v5</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        uses: actions/deploy-pages@368f82528645a54fb793d4d04e342629=
a3f51346 # v5=2E0=2E1</span><br><span>diff --git a/=2Egithub/workflows/test=
-ssllib=2Eyml b/=2Egithub/workflows/test-ssllib=2Eyml</span><br><span>index=
 d8178a7=2E=2E64607cf 100644</span><br><span>--- a/=2Egithub/workflows/test=
-ssllib=2Eyml</span><br><span>+++ b/=2Egithub/workflows/test-ssllib=2Eyml</=
span><br><span>@@ -70,14 +70,14 @@</span><br><span>       - name: Install d=
ependencies</span><br><span>         run: sudo apt update &amp;&amp; sudo a=
pt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html c=
lang libcmocka-dev python3-docutils libtool automake autoconf pkg-config li=
bcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: Restore ${{inpu=
ts=2Elibname}} from cache</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # =
v5=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
ses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</s=
pan><br><span>         id: ssllib-cache</span><br><span>         with:</spa=
n><br><span>           path: ${{env=2ELIBPREFIX}}</span><br><span>         =
  key: ${{matrix=2Eos}}-${{inputs=2Elibname}}-${{matrix=2Ebuild }}-${{input=
s=2Egitref}}</span><br><span>       - name: &quot;${{inputs=2Elibname}}: ch=
eckout&quot;</span><br><span>         if: steps=2Essllib-cache=2Eoutputs=2E=
cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec=
0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=
=2E0=2E1</span><br><span>         with:</span><br><span>           submodul=
es: recursive</span><br><span>           path: ${{inputs=2Elibname}}</span>=
<br><span>@@ -98,7 +98,7 @@</span><br><span>       - name: Run ldconfig</sp=
an><br><span>         run: sudo ldconfig</span><br><span>       - name: &qu=
ot;OpenVPN: checkout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e1=
0 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=
=2E1</span><br><span>       - name: &quot;OpenVPN: autoreconf&quot;</span><=
br><span>         run: autoreconf -fvi</span><br><span>       - name: &quot=
;OpenVPN: configure&quot;</span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail">change 1922</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I983d67e1c90be=
a460f531f11d4c58d33a351d81b </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1922 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--cDO1iwo7NLs=--


--===============5026884303453178299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5026884303453178299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5026884303453178299==--

