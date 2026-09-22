Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEC9C98302
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HGvQB935tk4ShIqvMB2/cN0hfdiBNV88iivYAGWrDH4=; b=FzSXUiWDd3v6zLFKJ6f2kCJc80
	8t3mpnpUolWZukskxZ1wBOF7Hi2MdWl9PdbbCXiDceDUqByKMU2DfQYF280IYoSS1XPIOFhgpdZYU
	g1qGjf200bvZjEt8iWp3t+LdvRhw3xYTPLGmHblI1ROqyrHsX9RdBfVsxQp5M+k+TZYc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x93pI-0001Ex-5m;
	Tue, 22 Sep 2026 16:58:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x93pD-0001Ek-PL
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 16:58:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PN5ei38z53rUAk3qGc9glj4H+MUyseVtIUhR1z366Lc=; b=aN+4brsZSp3NPNJ9eortPxsNw5
 TDdASpWcO541pGnq62gz1G2apMRDWgRH+4bG3wXOt5T/Yq2G+FnL3EbhpNFMbCOmFZjjK5zdh85TG
 slKy9yxfX+hWsbCybC4PTPf5lgh6Wd1KA3CRtGunABSi/nry749zBPV72A9iqQ8WZ/8Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PN5ei38z53rUAk3qGc9glj4H+MUyseVtIUhR1z366Lc=; b=E
 VoE7IG2wDyS+WeguM3bDUYE7JpgzZId6Zvj+t+2GYhrp9Q6KfHwb0dPdzzjJ3CDGW2qlmjGFm8s5r
 XeqiJqO/hvTjmLSTmFGxkN5EsClJ3t92KPC7TJx5fWi2gDubQ2Hvw5io1jSJhVMzSkX2OUZJ4sfbf
 Jb0sKN9CYiKV5aFE=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x93p0-0000Yw-Ea for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 16:58:24 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so43385e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790096296; x=1790701096; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PN5ei38z53rUAk3qGc9glj4H+MUyseVtIUhR1z366Lc=;
 b=b27mKsnVxplq7TeiFdq7poD1IwGsdZ1kz5UCO5pYuXEPe+B4EO+BHCog+jKXYs+zR+
 D8D4q09+a69cmLrilCHKGa/2Hp/+yhCyiTZsC+KzlOvgVJNC2KcCVSkrnbVA5wjQi9l5
 3pVmYgtbSJrdLWQI6XaMLzmXHwU5mlu7tNJDeAnb8dh4VEE0sxOrJi92GVFLJWwtpTBe
 +kO4niU72AULmFFRPrOuglfqBdVDOrJTkgYhKf7cI9rCOCKzkdw4fj7B6HdlR8CNCG7h
 G7ZbZrI4Dgc2Xa/wxUTtTceEoYHwoQNuZ1jPGOxR+VLgGXLhb8plHU1VzCMd9i0bYq4Z
 eb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790096296; x=1790701096;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PN5ei38z53rUAk3qGc9glj4H+MUyseVtIUhR1z366Lc=;
 b=XlFjx1SuD7918oLh6i2h27qJ85HyVzfti68fLpVdkdRswo5QjHmCPj3SX321Vp2qjk
 vfOrEIUz9uW+Zg64APXotiEq27g1pXiiqVc19ZbzH5GNFvV6ymglOoKcBdwdpb9KaZnu
 Pf0Ln+/feRXSGaONxxvzFIa+Fnb6ZsR6fjbc7Z4fObFHuQId31gq5w2H4GVduQHUss0s
 +SG4LeLiJxuGRmREE2Y7SX1iQT2XIgJcwsd/4K/UOwnOODqoAoeMtF7fAcocjcENimFE
 RFD29uxWwCnujjybDcyqEbjMkO0f8LKXRjeIaZoj0Dyff+cyScieBvU6q0sH3bdPJJut
 lm+A==
X-Gm-Message-State: AFuF++lF8O71e6rOcL9rIPB9lh+EabL/8FHFppIRulJoXPNez+PdLh95
 OpcvQZMLSrn4PRgrzywxpEPvW6R3HUr0VRUz1LYNM2hWWHRNY8vPiLm/3qGTxI13M9ywElgH9gh
 +K4BgwbUte57UWmW7Bc0Nr5+ddhlrb/iX5ciK6J6/pyr2P45IRnKdnGccfQ8CGwm89ekO
X-Gm-Gg: AYBFou0up3Rghi4qwhzjwSRRUOe/2f3g1W7HSrHYZAOLEu0Wt+m6CiC8Sv13Ka3B8eJ
 KCQe1aTbaRQyyKgBQLIhy5tPUJRsRp9kVZVgw6xxfL2iGM+1R1wNyX+k4cX59xAvjOYmw84XnTe
 XeHizoPLmpVLqjgPJ5+8jsAcqz4oQoo39UQYqd/ee3L+qyhI+NmrtLETgq5/pimrjFQM/LM3uQI
 BvIx2O4j6ITu9MD2qQ/5jHunQkCcyVXHr3Gv/Nr0LbuV7L8Ulir2LLPfBUEZaHBimR6DBtrpGLv
 XC/ZB1TsGYZ4beNlB02S/qkPzXzyM3UlYe7HHlRaMHPnbfCIPiohgiJl8MxemWsbbdCK+0wgehs
 tZ5liidbHB81BhEXuOluRfrkTLUGK/PQ06BZwaNbdeBg0cHCfN5APeevJKDyVjoqmQC6TpPT7wg
 DUeiyV6/SPXkoUwzpa6nq/KXSS5XJRJ2ILUYEZy7zm3iELZF1HVPO7GRyIPB+FdRfwOPiCLZuy7
 /w2bqmcYnNbVw/8FYB+Qvt+EAq8n/Q0ahuEqcCa1IEZBwMD9UaX7PFcfAvYH0F+iNk/dmLeRSYa
 twGztHvLQJYZHaO22EGcMGitUE4bZVVx+ggrCIar+dRLM2hZpRO0oSLPaIqj
X-Received: by 2002:a05:600c:314a:b0:49f:ce73:7aa with SMTP id
 5b1f17b1804b1-49fce730865mr153381425e9.35.1790096295633; 
 Tue, 22 Sep 2026 09:58:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1c159esm4337615e9.4.2026.09.22.09.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 09:58:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 16:58:13 +0000
To: flichtenheld <frank@lichtenheld.com>, razvanc <razvanc@mailbox.org>,
 plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
X-Gerrit-Change-Number: 1922
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1922?usp=email>
X-Gerrit-Commit: 0cc99b10b4464bdeaa8c254f8388aeb241e8e8b6
In-Reply-To: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
References: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDA2MzgxMDAwLkk5ODNkNjdlMWM5MGJlYTQ2MGY1MzFmMTFkNGM1OGQzM2EzNTFkODFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bdf3ec8e03dee47b6777ff658f84516cb402859a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x93p0-0000Yw-Ea
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4707361034338284481=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4707361034338284481==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wjmShrqOmzY="; charset=UTF-8

--wjmShrqOmzY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: GHA: Maintenance update September 2026
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Maintenance up=
date September 2026

Contains the following renovate updates:
- chore(deps)=
: update vcpkg digest to 5f96cd1
- Update dependency ubuntu to v26
- chore(=
deps): update dependency aws/aws-lc to v5=2E9=2E0
- chore(deps): update git=
hub actions
- Update github actions (major)

Change-Id: I983d67e1c90bea460f=
531f11d4c58d33a351d81b
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922
Message-Id: <20260922120433=2E29=
303-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg39391=2Ehtml
Signed-off-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
---
M =2Egithub/workflows/build=2Eyaml
M =2Egi=
thub/workflows/coverity-scan=2Eyml
M =2Egithub/workflows/doxygen=2Eyml
M =
=2Egithub/workflows/test-ssllib=2Eyml
4 files changed, 34 insertions(+), 34=
 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/22/1922/4

diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithu=
b/workflows/build=2Eyaml
index d67c215=2E=2E27f08df 100644
--- a/=2Egithub/=
workflows/build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -7,14 +7,1=
4 @@
 jobs:
   clang-format:
     name: Check code style with clang-format
=
-    runs-on: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E04
     steps:
     =
  - name: Install dependencies
         run: |
           sudo apt update &=
& sudo apt install -y python3-pip
           pip3 install pre-commit
      =
 - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874ed=
d31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42=
e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
       - name: Run clang-fo=
rmat
         run: pre-commit run -a --show-diff-on-failure || true
       =
- name: Check for changes
@@ -34,7 +34,7 @@
         include:
           - =
abi: arm64-v8a
             vcpkg_triplet: arm64-android
-    runs-on: ubun=
tu-24=2E04
+    runs-on: ubuntu-26=2E04
     name: "Android - ${{ matrix=2E=
abi }}"
     # Github images already setup NDK with ANDROID_NDK_ROOT pointi=
ng to the root
     # of the SDK
@@ -43,17 +43,17 @@
       VCPKG_ROOT: ${{=
 github=2Eworkspace }}/vcpkg
       VCPKG_INSTALLED_DIR: ${{ github=2Eworks=
pace }}/vcpkg/installed
       VCPKG_BINARY_SOURCES: clear;default,readwrit=
e
-      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
+   =
   VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
     steps=
:
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c06=
9e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
-      - uses: lukka/get-cmake=
@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3
+        uses: actio=
ns/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
+      - =
uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4=2E4=2E2=

       - name: Setup vcpkg
         uses: lukka/run-vcpkg@b1a0dd252f06b9e2=
5b3c022a9a03bd7a427fb6a2 # v11=2E6
         with:
           vcpkgGitCommit=
Id: ${{ env=2EVCPKG_GIT_COMMIT_ID }}
       - name: Set up vcpkg binary cac=
he
-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # =
v5=2E0=2E5
+        uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1=
c52a9 # v6=2E1=2E0
         with:
           path: ${{ env=2EVCPKG_DEFAULT_=
BINARY_CACHE }}
           key: android-${{ matrix=2Eabi }}-vcpkg-binary-ca=
che-${{ env=2EVCPKG_GIT_COMMIT_ID }}
@@ -82,18 +82,18 @@
         build: [R=
elease, Debug]
 
     name: "gcc-mingw - ${{ matrix=2Earch }} - ${{ matrix=
=2Ebuild }} - OSSL"
-    runs-on: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E=
04
     env:
       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg
       VCPK=
G_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 75672=
db6bd812b060482b0f00b5a16b18a0c0f07
+      VCPKG_GIT_COMMIT_ID: 5f96cd15fd7=
45122cf27e0524606d6c1efc5fd07
     steps:
       - name: Install dependenci=
es
         run: sudo apt update && sudo apt install -y mingw-w64 unzip bui=
ld-essential wget python3-docutils man2html-base
       - name: Checkout Op=
enVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0=
e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805825da7641=
0c181273ba90b1 # v7=2E0=2E1
 
-      - uses: lukka/get-cmake@591817e96fcad4=
3505fb4eae36172462abb3a42e # v4=2E3=2E3
+      - uses: lukka/get-cmake@fffa=
aafeea488556c2c12dad60690008bc1caacb # v4=2E4=2E2
       - name: Setup vcpk=
g
         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 #=
 v11=2E6
         with:
@@ -101,7 +101,7 @@
           vcpkgJsonGlob: '**/m=
ingw/vcpkg=2Ejson'
 
       - name: Set up vcpkg binary cache
-        uses=
: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+    =
    uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=
=2E0
         with:
           path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }=
}
           key: mingw-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFil=
es('**/mingw/vcpkg=2Ejson') }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}
@@ -144,7 +=
144,7 @@
     name: "mingw unittest ${{ matrix=2Etest }} - ${{ matrix=2Earc=
h }} - ${{ matrix=2Ebuild }} - OSSL"
     steps:
       - name: Checkout Op=
enVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0=
e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805825da7641=
0c181273ba90b1 # v7=2E0=2E1
       - name: Retrieve mingw unittest
        =
 uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c #=
 v8=2E0=2E1
         with:
@@ -185,7 +185,7 @@
       - name: Install depen=
dencies
         run: sudo apt update && sudo apt install -y liblzo2-dev li=
bpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2htm=
l libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS=
11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4c=
b1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/ch=
eckout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
       - name:=
 autoconf
         run: autoreconf -fvi
       - name: configure
@@ -215,7 =
+215,7 @@
       - name: Install dependencies
         run: sudo apt update=
 && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev l=
ibnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutil=
s libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: =
actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+   =
     uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=
=2E0=2E1
       - name: autoconf
         run: autoreconf -fvi
       - nam=
e: configure
@@ -255,7 +255,7 @@
       - name: Install dependencies
      =
   run: brew install ${{matrix=2Essllib}} lzo lz4 man2html cmocka libtool a=
utomake autoconf
       - name: Checkout OpenVPN
-        uses: actions/che=
ckout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+        uses: =
actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
    =
   - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<E=
OF;
@@ -285,12 +285,12 @@
       env:
         BUILD_CONFIGURATION: Release=

         VCPKG_BINARY_SOURCES: clear;default,readwrite
-        VCPKG_GIT_=
COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
+        VCPKG_GIT_COMM=
IT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
 
       runs-on: windows-2=
025-vs2026
       steps:
-      - uses: actions/checkout@df4cb1c069e1874edd=
31b4311f1884172cec0e10 # v6=2E0=2E3
-      - uses: lukka/get-cmake@591817e9=
6fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3
+      - uses: actions/checko=
ut@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
+      - uses: luk=
ka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4=2E4=2E2
 
      =
 - name: Install rst2html
         run: python -m pip install --upgrade pip=
 docutils
@@ -302,7 +302,7 @@
           vcpkgJsonGlob: '**/windows/vcpkg=
=2Ejson'
 
       - name: Set up vcpkg binary cache
-        uses: actions/=
cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+        uses: =
actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
       =
  with:
           path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}
          =
 key: msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles('**/window=
s/vcpkg=2Ejson') }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}
@@ -380,7 +380,7 @@
  =
     ovpnlibdesc: AWS-LC
       # versioning=3Dsemver-coerced
       ghrepo=
: aws/aws-lc
-      gitref: v5=2E0=2E0
+      gitref: v5=2E9=2E0
       lib=
configure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INST=
ALL_PREFIX=3D"$LIBPREFIX" -DBUILD_SHARED_LIBS=3D1
       libmake: cmake --b=
uild build
-      libinstall: sudo cmake --install build
\ No newline at en=
d of file
+      libinstall: sudo cmake --install build
diff --git a/=2Egit=
hub/workflows/coverity-scan=2Eyml b/=2Egithub/workflows/coverity-scan=2Eyml=

index 105f23e=2E=2Ee103aec 100644
--- a/=2Egithub/workflows/coverity-scan=
=2Eyml
+++ b/=2Egithub/workflows/coverity-scan=2Eyml
@@ -9,11 +9,11 @@
    =
 # Running coverity requires the secrets=2ECOVERITY_SCAN_TOKEN token
     #=
 which is only available on the main repository
     if: github=2Erepositor=
y_owner =3D=3D 'OpenVPN'
-    runs-on: ubuntu-24=2E04
+    runs-on: ubuntu-=
26=2E04
     steps:
       - name: Check submission cache
         id: chec=
k_submit
-        uses: actions/cache/restore@27d5ce7f107fe9357f9df03efb73a=
b90386fccae # v5=2E0=2E5
+        uses: actions/cache/restore@55cc8345863c7=
cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
         with:
           path: |
=
             cov-int
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenVPN
  =
       if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'true'
-        =
uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E=
3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 =
# v7=2E0=2E1
 
       - name: Download Coverity Build Tool
         if: ste=
ps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'true'
@@ -65,7 +65,7 @@
 
   =
    - name: Cache submission
         if: steps=2Echeck_submit=2Eoutputs=2E=
cache-hit !=3D 'true'
-        uses: actions/cache/save@27d5ce7f107fe9357f9=
df03efb73ab90386fccae # v5=2E0=2E5
+        uses: actions/cache/save@55cc83=
45863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0
         with:
           p=
ath: |
             cov-int
diff --git a/=2Egithub/workflows/doxygen=2Eyml =
b/=2Egithub/workflows/doxygen=2Eyml
index 3755b92=2E=2E784f81e 100644
--- a=
/=2Egithub/workflows/doxygen=2Eyml
+++ b/=2Egithub/workflows/doxygen=2Eyml
=
@@ -8,10 +8,10 @@
   cancel-in-progress: false
 jobs:
   build:
-    runs-o=
n: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E04
     if: ${{ github=2Ereposi=
tory_owner =3D=3D 'openvpn' || github=2Eevent_name =3D=3D 'workflow_dispatc=
h' }}
     steps:
-      - uses: actions/checkout@df4cb1c069e1874edd31b4311=
f1884172cec0e10 # v6=2E0=2E3
+      - uses: actions/checkout@3d3c42e5aac5ba=
805825da76410c181273ba90b1 # v7=2E0=2E1
         with:
           path: ope=
nvpn
 
@@ -35,7 +35,7 @@
           touch doc/doxygen/html/=2Enojekyll
    =
   - name: Upload static files as artifact
         id: deployment
-       =
 uses: actions/upload-pages-artifact@fc324d3547104276b827a68afc52ff2a11cc49=
c9 # v5
+        uses: actions/upload-pages-artifact@fc324d3547104276b827a6=
8afc52ff2a11cc49c9 # v5=2E0=2E0
         with:
           path: doxygen/doc=
/doxygen/html/
 
@@ -47,8 +47,8 @@
     environment:
       name: github-pa=
ges
       url: ${{ steps=2Edeployment=2Eoutputs=2Epage_url }}
-    runs-on=
: ubuntu-24=2E04
+    runs-on: ubuntu-26=2E04
     steps:
       - name: De=
ploy to GitHub Pages
         id: deployment
-        uses: actions/deploy-=
pages@cd2ce8fcbc39b97be8ca5fce6e763baed58fa128 # v5
+        uses: actions/=
deploy-pages@368f82528645a54fb793d4d04e342629a3f51346 # v5=2E0=2E1
diff --g=
it a/=2Egithub/workflows/test-ssllib=2Eyml b/=2Egithub/workflows/test-sslli=
b=2Eyml
index d8178a7=2E=2E64607cf 100644
--- a/=2Egithub/workflows/test-ss=
llib=2Eyml
+++ b/=2Egithub/workflows/test-ssllib=2Eyml
@@ -70,14 +70,14 @@
=
       - name: Install dependencies
         run: sudo apt update && sudo a=
pt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html c=
lang libcmocka-dev python3-docutils libtool automake autoconf pkg-config li=
bcap-ng-dev libnl-genl-3-dev
       - name: Restore ${{inputs=2Elibname}} f=
rom cache
-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386f=
ccae # v5=2E0=2E5
+        uses: actions/cache@55cc8345863c7cc4c66a329aec7e=
433d2d1c52a9 # v6=2E1=2E0
         id: ssllib-cache
         with:
        =
   path: ${{env=2ELIBPREFIX}}
           key: ${{matrix=2Eos}}-${{inputs=2E=
libname}}-${{matrix=2Ebuild }}-${{inputs=2Egitref}}
       - name: "${{inpu=
ts=2Elibname}}: checkout"
         if: steps=2Essllib-cache=2Eoutputs=2Ecac=
he-hit !=3D 'true'
-        uses: actions/checkout@df4cb1c069e1874edd31b431=
1f1884172cec0e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5b=
a805825da76410c181273ba90b1 # v7=2E0=2E1
         with:
           submodul=
es: recursive
           path: ${{inputs=2Elibname}}
@@ -98,7 +98,7 @@
    =
   - name: Run ldconfig
         run: sudo ldconfig
       - name: "OpenVPN=
: checkout"
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f18841=
72cec0e10 # v6=2E0=2E3
+        uses: actions/checkout@3d3c42e5aac5ba805825=
da76410c181273ba90b1 # v7=2E0=2E1
       - name: "OpenVPN: autoreconf"
    =
     run: autoreconf -fvi
       - name: "OpenVPN: configure"

-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58=
d33a351d81b
Gerrit-Change-Number: 1922
Gerrit-PatchSet: 4
Gerrit-Owner: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--wjmShrqOmzY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">GHA: Maintenance update =
September 2026<br><br>Contains the following renovate updates:<br>- chore(d=
eps): update vcpkg digest to 5f96cd1<br>- Update dependency ubuntu to v26<b=
r>- chore(deps): update dependency aws/aws-lc to v5=2E9=2E0<br>- chore(deps=
): update github actions<br>- Update github actions (major)<br><br>Change-I=
d: I983d67e1c90bea460f531f11d4c58d33a351d81b<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1922<br>Message-Id: &lt;20260922120433=2E29303-1-gert@greenie=2Emuc=2E=
de&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourc=
eforge=2Enet/msg39391=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>---<br>M =2Egithub/workflows/build=2Eyaml<br>M =2Egithu=
b/workflows/coverity-scan=2Eyml<br>M =2Egithub/workflows/doxygen=2Eyml<br>M=
 =2Egithub/workflows/test-ssllib=2Eyml<br>4 files changed, 34 insertions(+)=
, 34 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/22/1922/4</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=2Egithub=
/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml</span><br><span>=
index d67c215=2E=2E27f08df 100644</span><br><span>--- a/=2Egithub/workflows=
/build=2Eyaml</span><br><span>+++ b/=2Egithub/workflows/build=2Eyaml</span>=
<br><span>@@ -7,14 +7,14 @@</span><br><span> jobs:</span><br><span>   clang=
-format:</span><br><span>     name: Check code style with clang-format</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=2E0=
4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubunt=
u-26=2E04</span><br><span>     steps:</span><br><span>       - name: Instal=
l dependencies</span><br><span>         run: |</span><br><span>           s=
udo apt update &amp;&amp; sudo apt install -y python3-pip</span><br><span> =
          pip3 install pre-commit</span><br><span>       - name: Checkout O=
penVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: a=
ctions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/che=
ckout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span=
>       - name: Run clang-format</span><br><span>         run: pre-commit r=
un -a --show-diff-on-failure || true</span><br><span>       - name: Check f=
or changes</span><br><span>@@ -34,7 +34,7 @@</span><br><span>         inclu=
de:</span><br><span>           - abi: arm64-v8a</span><br><span>           =
  vcpkg_triplet: arm64-android</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    runs-on: ubuntu-24=2E04</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    runs-on: ubuntu-26=2E04</span><br><span>     name: &qu=
ot;Android - ${{ matrix=2Eabi }}&quot;</span><br><span>     # Github images=
 already setup NDK with ANDROID_NDK_ROOT pointing to the root</span><br><sp=
an>     # of the SDK</span><br><span>@@ -43,17 +43,17 @@</span><br><span>  =
     VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg</span><br><span>       VCP=
KG_INSTALLED_DIR: ${{ github=2Eworkspace }}/vcpkg/installed</span><br><span=
>       VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      VCPKG_GIT_COMMIT_ID: 75672db6bd812b06=
0482b0f00b5a16b18a0c0f07</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07</s=
pan><br><span>     steps:</span><br><span>       - name: Checkout OpenVPN</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/c=
heckout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@59181=
7e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba8=
05825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60=
690008bc1caacb # v4=2E4=2E2</span><br><span>       - name: Setup vcpkg</spa=
n><br><span>         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a=
427fb6a2 # v11=2E6</span><br><span>         with:</span><br><span>         =
  vcpkgGitCommitId: ${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>      =
 - name: Set up vcpkg binary cache</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab9038=
6fccae # v5=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=
=2E1=2E0</span><br><span>         with:</span><br><span>           path: ${=
{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}</span><br><span>           key: andro=
id-${{ matrix=2Eabi }}-vcpkg-binary-cache-${{ env=2EVCPKG_GIT_COMMIT_ID }}<=
/span><br><span>@@ -82,18 +82,18 @@</span><br><span>         build: [Releas=
e, Debug]</span><br><span> </span><br><span>     name: &quot;gcc-mingw - ${=
{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=2E04</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-26=2E04</span=
><br><span>     env:</span><br><span>       VCPKG_ROOT: ${{ github=2Eworksp=
ace }}/vcpkg</span><br><span>       VCPKG_BINARY_SOURCES: clear;default,rea=
dwrite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      VCPKG_GIT=
_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 5f96cd15fd7451=
22cf27e0524606d6c1efc5fd07</span><br><span>     steps:</span><br><span>    =
   - name: Install dependencies</span><br><span>         run: sudo apt upda=
te &amp;&amp; sudo apt install -y mingw-w64 unzip build-essential wget pyth=
on3-docutils man2html-base</span><br><span>       - name: Checkout OpenVPN<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/=
checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@3=
d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cm=
ake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@fffaaaf=
eea488556c2c12dad60690008bc1caacb # v4=2E4=2E2</span><br><span>       - nam=
e: Setup vcpkg</span><br><span>         uses: lukka/run-vcpkg@b1a0dd252f06b=
9e25b3c022a9a03bd7a427fb6a2 # v11=2E6</span><br><span>         with:</span>=
<br><span>@@ -101,7 +101,7 @@</span><br><span>           vcpkgJsonGlob: &#3=
9;**/mingw/vcpkg=2Ejson&#39;</span><br><span> </span><br><span>       - nam=
e: Set up vcpkg binary cache</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae=
 # v5=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0=
</span><br><span>         with:</span><br><span>           path: ${{ env=2E=
VCPKG_DEFAULT_BINARY_CACHE }}</span><br><span>           key: mingw-${{ mat=
rix=2Earch }}-vcpkg-binary-cache-${{ hashFiles(&#39;**/mingw/vcpkg=2Ejson&#=
39;) }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>@@ -144,7 +144,7 @=
@</span><br><span>     name: &quot;mingw unittest ${{ matrix=2Etest }} - ${=
{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL&quot;</span><br><span>   =
  steps:</span><br><span>       - name: Checkout OpenVPN</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c06=
9e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba80582=
5da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>       - name: Retrieve =
mingw unittest</span><br><span>         uses: actions/download-artifact@3e5=
f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8=2E0=2E1</span><br><span>        =
 with:</span><br><span>@@ -185,7 +185,7 @@</span><br><span>       - name: I=
nstall dependencies</span><br><span>         run: sudo apt update &amp;&amp=
; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev lib=
nl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtoo=
l automake autoconf ${SSLPKG} ${PKCS11PKG}</span><br><span>       - name: C=
heckout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=
=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: a=
ctions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span=
><br><span>       - name: autoconf</span><br><span>         run: autoreconf=
 -fvi</span><br><span>       - name: configure</span><br><span>@@ -215,7 +2=
15,7 @@</span><br><span>       - name: Install dependencies</span><br><span=
>         run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev l=
ibpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2ht=
ml clang libcmocka-dev python3-docutils libtool automake autoconf</span><br=
><span>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1=
884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba9=
0b1 # v7=2E0=2E1</span><br><span>       - name: autoconf</span><br><span>  =
       run: autoreconf -fvi</span><br><span>       - name: configure</span>=
<br><span>@@ -255,7 +255,7 @@</span><br><span>       - name: Install depend=
encies</span><br><span>         run: brew install ${{matrix=2Essllib}} lzo =
lz4 man2html cmocka libtool automake autoconf</span><br><span>       - name=
: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=
=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        use=
s: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</=
span><br><span>       - name: Set environment</span><br><span>         run:=
 |</span><br><span>           cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF;</span><b=
r><span>@@ -285,12 +285,12 @@</span><br><span>       env:</span><br><span> =
        BUILD_CONFIGURATION: Release</span><br><span>         VCPKG_BINARY_=
SOURCES: clear;default,readwrite</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0=
c0f07</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VCPKG_=
GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07</span><br><span> </=
span><br><span>       runs-on: windows-2025-vs2026</span><br><span>       s=
teps:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: ac=
tions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmak=
e@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/checkout@3d3c42e5=
aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@fffaaafeea488556c2c=
12dad60690008bc1caacb # v4=2E4=2E2</span><br><span> </span><br><span>      =
 - name: Install rst2html</span><br><span>         run: python -m pip insta=
ll --upgrade pip docutils</span><br><span>@@ -302,7 +302,7 @@</span><br><sp=
an>           vcpkgJsonGlob: &#39;**/windows/vcpkg=2Ejson&#39;</span><br><s=
pan> </span><br><span>       - name: Set up vcpkg binary cache</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache@27d5ce=
7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: actions/cache@55cc8345863c7cc4c66=
a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         with:</span><br=
><span>           path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}</span><br><=
span>           key: msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashF=
iles(&#39;**/windows/vcpkg=2Ejson&#39;) }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}=
</span><br><span>@@ -380,7 +380,7 @@</span><br><span>       ovpnlibdesc: AW=
S-LC</span><br><span>       # versioning=3Dsemver-coerced</span><br><span> =
      ghrepo: aws/aws-lc</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-      gitref: v5=2E0=2E0</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      gitref: v5=2E9=2E0</span><br><span>       libconfigure: cmake=
 -B build -GNinja -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D&qu=
ot;$LIBPREFIX&quot; -DBUILD_SHARED_LIBS=3D1</span><br><span>       libmake:=
 cmake --build build</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
     libinstall: sudo cmake --install build</span><br><span>\ No newline at=
 end of file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      l=
ibinstall: sudo cmake --install build</span><br><span>diff --git a/=2Egithu=
b/workflows/coverity-scan=2Eyml b/=2Egithub/workflows/coverity-scan=2Eyml</=
span><br><span>index 105f23e=2E=2Ee103aec 100644</span><br><span>--- a/=2Eg=
ithub/workflows/coverity-scan=2Eyml</span><br><span>+++ b/=2Egithub/workflo=
ws/coverity-scan=2Eyml</span><br><span>@@ -9,11 +9,11 @@</span><br><span>  =
   # Running coverity requires the secrets=2ECOVERITY_SCAN_TOKEN token</spa=
n><br><span>     # which is only available on the main repository</span><br=
><span>     if: github=2Erepository_owner =3D=3D &#39;OpenVPN&#39;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-24=2E04</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-26=
=2E04</span><br><span>     steps:</span><br><span>       - name: Check subm=
ission cache</span><br><span>         id: check_submit</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/restore@27d5ce=
7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: actions/cache/restore@55cc8345863=
c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         with:</=
span><br><span>           path: |</span><br><span>             cov-int</spa=
n><br><span>@@ -25,7 +25,7 @@</span><br><span> </span><br><span>       - na=
me: Checkout OpenVPN</span><br><span>         if: steps=2Echeck_submit=2Eou=
tputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: actions/checkout@df4cb1c069e1874edd31b4311f18=
84172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90=
b1 # v7=2E0=2E1</span><br><span> </span><br><span>       - name: Download C=
overity Build Tool</span><br><span>         if: steps=2Echeck_submit=2Eoutp=
uts=2Ecache-hit !=3D &#39;true&#39;</span><br><span>@@ -65,7 +65,7 @@</span=
><br><span> </span><br><span>       - name: Cache submission</span><br><spa=
n>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D &#39;true&#3=
9;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actio=
ns/cache/save@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache=
/save@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span=
>         with:</span><br><span>           path: |</span><br><span>        =
     cov-int</span><br><span>diff --git a/=2Egithub/workflows/doxygen=2Eyml=
 b/=2Egithub/workflows/doxygen=2Eyml</span><br><span>index 3755b92=2E=2E784=
f81e 100644</span><br><span>--- a/=2Egithub/workflows/doxygen=2Eyml</span><=
br><span>+++ b/=2Egithub/workflows/doxygen=2Eyml</span><br><span>@@ -8,10 +=
8,10 @@</span><br><span>   cancel-in-progress: false</span><br><span> jobs:=
</span><br><span>   build:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    runs-on: ubuntu-24=2E04</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    runs-on: ubuntu-26=2E04</span><br><span>     if: ${{ githu=
b=2Erepository_owner =3D=3D &#39;openvpn&#39; || github=2Eevent_name =3D=3D=
 &#39;workflow_dispatch&#39; }}</span><br><span>     steps:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/checkout@df4cb1=
c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      - uses: actions/checkout@3d3c42e5aac5ba80=
5825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>         with:</span>=
<br><span>           path: openvpn</span><br><span> </span><br><span>@@ -35=
,7 +35,7 @@</span><br><span>           touch doc/doxygen/html/=2Enojekyll</=
span><br><span>       - name: Upload static files as artifact</span><br><sp=
an>         id: deployment</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        uses: actions/upload-pages-artifact@fc324d3547104276b827a68afc=
52ff2a11cc49c9 # v5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uses: actions/upload-pages-artifact@fc324d3547104276b827a68afc52ff2=
a11cc49c9 # v5=2E0=2E0</span><br><span>         with:</span><br><span>     =
      path: doxygen/doc/doxygen/html/</span><br><span> </span><br><span>@@ =
-47,8 +47,8 @@</span><br><span>     environment:</span><br><span>       nam=
e: github-pages</span><br><span>       url: ${{ steps=2Edeployment=2Eoutput=
s=2Epage_url }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ru=
ns-on: ubuntu-24=2E04</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    runs-on: ubuntu-26=2E04</span><br><span>     steps:</span><br><span> =
      - name: Deploy to GitHub Pages</span><br><span>         id: deploymen=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: action=
s/deploy-pages@cd2ce8fcbc39b97be8ca5fce6e763baed58fa128 # v5</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/deploy-pages=
@368f82528645a54fb793d4d04e342629a3f51346 # v5=2E0=2E1</span><br><span>diff=
 --git a/=2Egithub/workflows/test-ssllib=2Eyml b/=2Egithub/workflows/test-s=
sllib=2Eyml</span><br><span>index d8178a7=2E=2E64607cf 100644</span><br><sp=
an>--- a/=2Egithub/workflows/test-ssllib=2Eyml</span><br><span>+++ b/=2Egit=
hub/workflows/test-ssllib=2Eyml</span><br><span>@@ -70,14 +70,14 @@</span><=
br><span>       - name: Install dependencies</span><br><span>         run: =
sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev lib=
lz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtoo=
l automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><sp=
an>       - name: Restore ${{inputs=2Elibname}} from cache</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache@27d5ce7f10=
7fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        uses: actions/cache@55cc8345863c7cc4c66a329=
aec7e433d2d1c52a9 # v6=2E1=2E0</span><br><span>         id: ssllib-cache</s=
pan><br><span>         with:</span><br><span>           path: ${{env=2ELIBP=
REFIX}}</span><br><span>           key: ${{matrix=2Eos}}-${{inputs=2Elibnam=
e}}-${{matrix=2Ebuild }}-${{inputs=2Egitref}}</span><br><span>       - name=
: &quot;${{inputs=2Elibname}}: checkout&quot;</span><br><span>         if: =
steps=2Essllib-cache=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4=
cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5b=
a805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>         with:</sp=
an><br><span>           submodules: recursive</span><br><span>           pa=
th: ${{inputs=2Elibname}}</span><br><span>@@ -98,7 +98,7 @@</span><br><span=
>       - name: Run ldconfig</span><br><span>         run: sudo ldconfig</s=
pan><br><span>       - name: &quot;OpenVPN: checkout&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@df4cb1c=
069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        uses: actions/checkout@3d3c42e5aac5ba805=
825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>       - name: &quot;O=
penVPN: autoreconf&quot;</span><br><span>         run: autoreconf -fvi</spa=
n><br><span>       - name: &quot;OpenVPN: configure&quot;</span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?=
usp=3Demail">change 1922</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1922?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1922 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit=
-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--wjmShrqOmzY=--


--===============4707361034338284481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4707361034338284481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4707361034338284481==--

