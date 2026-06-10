Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5041CD8C90
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3j77058jonqDFlN4thmkRdo2FfgIHkDcwSmHSazfTtU=; b=Ayd7nwzMysswHbHe67l0AvLxjB
	vkgjYp8IYgDj4fdJp1pEZXl11Y3V/XkK4G/k2O0OBELsy/EpqKFMBZNG7ijp3dusrQSwsYLwwfeuv
	33gHr8BAdVqo/gy7yBli29FNo4UonGLTQbtRhMUH0TQDCr090vlEL2gYvdmGRRXJRB6E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXMWV-0003cD-HE;
	Wed, 10 Jun 2026 17:15:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXMWU-0003c6-50
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:15:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=e2Y9wkNElZePQNochNIl/o8d2RS5w0rbTiabKR0t/kc=; b=Nuj6X0dRNOGuLuO0YaGf+nYQho
 woYAdd6+nrsfH90UZJdJENXe5P2bjSuD1xLwyXy3YLeBYiJQyoceBxeOZAF6NtzhUbGXeMSKIJ/ln
 mkIi77Mh9CDwq0g6WwDB0aDau1Zvo/SvC67Xfm2j4SwMrPeZoB8JTMqXc+Bcpff0AVFA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=e2Y9wkNElZePQNochNIl/o8d2RS5w0rbTiabKR0t/kc=; b=A
 Ms276fp6C8OShGpdrhV8B0bvnSgDZPSyAVEQ/d56hzMAlwZHfKhAshSKUMhdZcmw6fqgN3f5Fxgaq
 qrIvSTL8pm9kJFZ3tUfjpap6za5eZlwbbSW8h93bAaxhuBChDs9Y7Md/X/ARumPCZC3A+/CtPk29Z
 EZqZS9t8jXAa71+Y=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXMWR-0007s9-5Z for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:15:26 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490b43e2b95so58222665e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781111712; x=1781716512; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e2Y9wkNElZePQNochNIl/o8d2RS5w0rbTiabKR0t/kc=;
 b=dQJvb/voNFt8F5cs+QjzSy7lqupJDEy438ji6sLlhAuYc+KtiHzPFjdcVmV1K8kpJ/
 j/8JOP79e+uMa2Vxfp+uqfC3y8v4MRw4GTYef+FDhszh7rF42biqQ4HNDoChjGmWaVrL
 U1C7H/AdJgxOht+xtWWeQ9txxxriW9t6II82/HuVxmqzine1NSrBFGKoJmgUiUMkJLUF
 h5MDdqa+vcg69fBf4S0zss0BBI+0gAhCeYLTAUyOzqbRaH8wIGeeVCiQnnNqQoMKz/YP
 TTgObd/r4xKR7IZ45IqbL2e+cBALyMvz/LFfTVcGWuY2g5P8qW7tN0oOhq8PH8sUo6rd
 Y14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111712; x=1781716512;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e2Y9wkNElZePQNochNIl/o8d2RS5w0rbTiabKR0t/kc=;
 b=VTXfMRqs/+jL4j5j9aYzuOgq26Bcb3aPtVxdl2rOGqoERNnEfAm2v4agdU8H5jhbJj
 yqT407/diDm9d7Mjd7wkz9ZtBVKLURxE0IwFAdc1h42dnvWb2gBjvPItMAggHz+1qdKu
 79CmrRdUc7QvqdhlCrfJZhAGPEY0PL4lTVHrOZO9Ln9aSxK59iZ7nyny6/mpuTNaPxNe
 1x/oqdyTvoy4cEvQoBvVpLz0Zqnqv3eSZGcR7dZG1t9p2vefYZ/f6vvfq0u3pTV7o3AC
 XNaHZ8PD0Ab5fdJVZ0H54ZWh1gAXl8NFvdQ72/kFSPPhVuwtu1mrr3uWxzCnf4enEI6q
 kkDA==
X-Gm-Message-State: AOJu0YzYrD5C9O/COQr4OWlrLCSGaCNsDN8/HzbneEIOhZ7qgQMhYTrd
 SLycWfoqAGp6rSKYdEsno1fDPonaN/+8LcRbAEETp9hKpQkcgRqWpx9USVTMTx9OAITsOW6JOlP
 gXpe0t335pr2jXjD5DSBAneWcoJ+p3UxmBV8tE3Xcjp4Q+0gNw4vr8YzT4V+9Qz6xEs6zCQyq+Y
 auceYMEA==
X-Gm-Gg: Acq92OFxc0ZOhRNA9Yr2abp/Po3t83248eoef5j0oWnkVPHfvc2jxsIxt5qZlV3n3cj
 1EoqK+QJk99pUUH10MFiqs585n28GYcBJz+Kzfrwu1k5ZyuALo5tbuf8AiVgT9rtdDpJI1/LpJv
 3E8uWDRt+XabYcbJ3YvcwymtRBJ+4ZyXiqWC+TvuI8mPgwMrYX7MSRGccAZBBwI/Es5+SPZqX3W
 pGPc+OUU0AiPVtqm6jPwO0VFcxm00v+YOeZxdD4iE/y6tneDk7RJszwOnWJ6cgJUhHHBB9zy8ks
 UroMctiAOIHFzpNbfvxTY3cRdehNQhaiP8nE2n5iy8WSwhUmT38abXAd1d+rOEczFrJAPSnLrdS
 k1scInl6D6pRNu/cUOw+tBsv5kqAyteaXgP2LryLYkT8yL0Hq5LYzj/Cy610gKdfTlWaBWoReTh
 Nl/YKwvIlDbrOCsogZQygk+hSpC9tqM0ET8UYN/3EFAgYB/FcX1wuQp4JMkY3c+nV01AEPN5ubE
 L8JOZLedCdhfdw1RMkmIhCudIXbDycli6JC1inNJo7s4qAp5MwXNKInPn15B0r8QfGEEsJg3mno
 B60oGo3zyc24HtuZDPBy2lXkbAIGPwAVTEQ=
X-Received: by 2002:a05:600c:83c3:b0:490:b355:9c70 with SMTP id
 5b1f17b1804b1-490c25a5970mr444445625e9.11.1781111711854; 
 Wed, 10 Jun 2026 10:15:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e28416desm3344635e9.1.2026.06.10.10.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:15:11 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 17:15:10 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I11fc104878ba244c5be04ce8019695b6892c4457
X-Gerrit-Change-Number: 1710
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1710?usp=email>
X-Gerrit-Commit: f9e6d5d724851a938a0c064307db513df469eb62
In-Reply-To: <gerrit.1781017122000.I11fc104878ba244c5be04ce8019695b6892c4457@gerrit.openvpn.net>
References: <gerrit.1781017122000.I11fc104878ba244c5be04ce8019695b6892c4457@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxMDE3MTIyMDAwLkkxMWZjMTA0ODc4YmEyNDRjNWJlMDRjZTgwMTk2OTViNjg5MmM0NDU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6cb70341d0968b24b3f4262f86650350961bac79-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXMWR-0007s9-5Z
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7409911492765245051=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7409911492765245051==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uCBMrClGE/E="; charset=UTF-8

--uCBMrClGE/E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1710?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: GHA: Maintenance update June 2026
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Maintenance updat=
e June 2026

Contains the following renovate updates:
- chore(deps): update=
 github actions
- chore(deps): update vcpkg digest to 75672db
- chore(deps)=
: update dependency aws/aws-lc to v5
- chore(deps): update dependency libre=
ssl/portable to v4=2E3=2E2

Change-Id: I11fc104878ba244c5be04ce8019695b6892=
c4457
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1710
Message-Id: <20260609152103=2E27418-1-gert@green=
ie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg37138=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M =2Egithub/workflows/build=2Eyaml
M =2Egithub/workflows/c=
overity-scan=2Eyml
M =2Egithub/workflows/doxygen=2Eyml
M =2Egithub/workflow=
s/test-ssllib=2Eyml
4 files changed, 20 insertions(+), 20 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/1710/2
=

diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=
=2Eyaml
index b530fcc=2E=2E323645a 100644
--- a/=2Egithub/workflows/build=
=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -14,7 +14,7 @@
          =
 sudo apt update && sudo apt install -y python3-pip
           pip3 install=
 pre-commit
       - name: Checkout OpenVPN
-        uses: actions/checkout=
@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        uses: actio=
ns/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
       - =
name: Run clang-format
         run: pre-commit run -a --show-diff-on-failu=
re || true
       - name: Check for changes
@@ -43,11 +43,11 @@
       VCPK=
G_ROOT: ${{ github=2Eworkspace }}/vcpkg
       VCPKG_INSTALLED_DIR: ${{ git=
hub=2Eworkspace }}/vcpkg/installed
       VCPKG_BINARY_SOURCES: clear;defau=
lt,readwrite
-      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe5=
7497c7
+      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07=

     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkou=
t@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
-      - uses: lukk=
a/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v4=2E3=2E2
+        =
uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E=
3
+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e #=
 v4=2E3=2E3
       - name: Setup vcpkg
         uses: lukka/run-vcpkg@b1a0d=
d252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
         with:
@@ -84,14 +84,=
14 @@
     env:
       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg
       V=
CPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 03=
1f4afe03be385aee354f15be6e6b1fe57497c7
+      VCPKG_GIT_COMMIT_ID: 75672db6=
bd812b060482b0f00b5a16b18a0c0f07
     steps:
       - name: Install depende=
ncies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip =
build-essential wget python3-docutils man2html-base
       - name: Checkout=
 OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447=
ce83dd # v6=2E0=2E2
+        uses: actions/checkout@df4cb1c069e1874edd31b43=
11f1884172cec0e10 # v6=2E0=2E3
 
-      - uses: lukka/get-cmake@7bfc9baacbb=
dcb5e37957ad05c3546b3e222be3c # v4=2E3=2E2
+      - uses: lukka/get-cmake@5=
91817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3
       - name: Setup v=
cpkg
         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a=
2 # v11=2E6
         with:
@@ -142,7 +142,7 @@
     name: "mingw unittest $=
{{ matrix=2Etest }} - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL"
=
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout=
@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        uses: actio=
ns/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
       - =
name: Retrieve mingw unittest
         uses: actions/download-artifact@3e5f=
45b2cfb9172054b4087a40e8e0b5a5461e7c # v8=2E0=2E1
         with:
@@ -183,7 =
+183,7 @@
       - name: Install dependencies
         run: sudo apt update=
 && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev l=
ibnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libt=
ool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVP=
N
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd =
# v6=2E0=2E2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884=
172cec0e10 # v6=2E0=2E3
       - name: autoconf
         run: autoreconf -f=
vi
       - name: configure
@@ -213,7 +213,7 @@
       - name: Install depe=
ndencies
         run: sudo apt update && sudo apt install -y liblzo2-dev l=
ibpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2ht=
ml clang libcmocka-dev python3-docutils libtool automake autoconf
       - =
name: Checkout OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009=
e67214ff5f5447ce83dd # v6=2E0=2E2
+        uses: actions/checkout@df4cb1c06=
9e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
       - name: autoconf
      =
   run: autoreconf -fvi
       - name: configure
@@ -253,7 +253,7 @@
      =
 - name: Install dependencies
         run: brew install ${{matrix=2Essllib=
}} lzo lz4 man2html cmocka libtool automake autoconf
       - name: Checkou=
t OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f544=
7ce83dd # v6=2E0=2E2
+        uses: actions/checkout@df4cb1c069e1874edd31b4=
311f1884172cec0e10 # v6=2E0=2E3
       - name: Set environment
         run=
: |
           cat >>$GITHUB_ENV <<EOF;
@@ -283,12 +283,12 @@
       env:
 =
        BUILD_CONFIGURATION: Release
         VCPKG_BINARY_SOURCES: clear;d=
efault,readwrite
-        VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e=
6b1fe57497c7
+        VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b1=
8a0c0f07
 
       runs-on: windows-2025
       steps:
-      - uses: action=
s/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
-      - u=
ses: lukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v4=2E3=2E2
=
+      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # =
v6=2E0=2E3
+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462a=
bb3a42e # v4=2E3=2E3
 
       - name: Install rst2html
         run: python=
 -m pip install --upgrade pip docutils
@@ -342,7 +342,7 @@
       ovpnlibde=
sc: LibreSSL
       # versioning=3Dsemver-coerced
       ghrepo: libressl/p=
ortable
-      gitref: v4=2E2=2E1
+      gitref: v4=2E3=2E2
       libconfi=
gure: "LIBRESSL_GIT_OPTIONS=3D--no-single-branch =2E/autogen=2Esh && =2E/co=
nfigure --prefix=3D$LIBPREFIX"
 
   openssl4:
@@ -376,7 +376,7 @@
       ov=
pnlibdesc: AWS-LC
       # versioning=3Dsemver-coerced
       ghrepo: aws/a=
ws-lc
-      gitref: v1=2E70=2E0
+      gitref: v5=2E0=2E0
       libconfig=
ure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PR=
EFIX=3D"$LIBPREFIX" -DBUILD_SHARED_LIBS=3D1
       libmake: cmake --build b=
uild
       libinstall: sudo cmake --install build
diff --git a/=2Egithub/w=
orkflows/coverity-scan=2Eyml b/=2Egithub/workflows/coverity-scan=2Eyml
inde=
x 1eec1ed=2E=2E105f23e 100644
--- a/=2Egithub/workflows/coverity-scan=2Eyml=

+++ b/=2Egithub/workflows/coverity-scan=2Eyml
@@ -25,7 +25,7 @@
 
       -=
 name: Checkout OpenVPN
         if: steps=2Echeck_submit=2Eoutputs=2Ecache=
-hit !=3D 'true'
-        uses: actions/checkout@de0fac2e4500dabe0009e67214=
ff5f5447ce83dd # v6=2E0=2E2
+        uses: actions/checkout@df4cb1c069e1874=
edd31b4311f1884172cec0e10 # v6=2E0=2E3
 
       - name: Download Coverity B=
uild Tool
         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'tru=
e'
diff --git a/=2Egithub/workflows/doxygen=2Eyml b/=2Egithub/workflows/dox=
ygen=2Eyml
index 30988b5=2E=2E3755b92 100644
--- a/=2Egithub/workflows/doxy=
gen=2Eyml
+++ b/=2Egithub/workflows/doxygen=2Eyml
@@ -11,7 +11,7 @@
     ru=
ns-on: ubuntu-24=2E04
     if: ${{ github=2Erepository_owner =3D=3D 'openvp=
n' || github=2Eevent_name =3D=3D 'workflow_dispatch' }}
     steps:
-      =
- uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=
=2E2
+      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e=
10 # v6=2E0=2E3
         with:
           path: openvpn
 
diff --git a/=2Eg=
ithub/workflows/test-ssllib=2Eyml b/=2Egithub/workflows/test-ssllib=2Eyml
i=
ndex c6a2e44=2E=2Ed8178a7 100644
--- a/=2Egithub/workflows/test-ssllib=2Eym=
l
+++ b/=2Egithub/workflows/test-ssllib=2Eyml
@@ -77,7 +77,7 @@
           =
key: ${{matrix=2Eos}}-${{inputs=2Elibname}}-${{matrix=2Ebuild }}-${{inputs=
=2Egitref}}
       - name: "${{inputs=2Elibname}}: checkout"
         if: s=
teps=2Essllib-cache=2Eoutputs=2Ecache-hit !=3D 'true'
-        uses: action=
s/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        u=
ses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3=

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
out@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
+        uses: ac=
tions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
      =
 - name: "OpenVPN: autoreconf"
         run: autoreconf -fvi
       - name:=
 "OpenVPN: configure"

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1710?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I11fc104878ba244c5be04ce8019695b6892c4457
Gerrit-Change-Number: 1710
G=
errit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>

--uCBMrClGE/E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1710?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">GHA: Maintenance updat=
e June 2026<br><br>Contains the following renovate updates:<br>- chore(deps=
): update github actions<br>- chore(deps): update vcpkg digest to 75672db<b=
r>- chore(deps): update dependency aws/aws-lc to v5<br>- chore(deps): updat=
e dependency libressl/portable to v4=2E3=2E2<br><br>Change-Id: I11fc104878b=
a244c5be04ce8019695b6892c4457<br>Signed-off-by: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1710<b=
r>Message-Id: &lt;20260609152103=2E27418-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg37138=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M =2Egithub/workflows/build=2Eyaml<br>M =2Egithub/workflows=
/coverity-scan=2Eyml<br>M =2Egithub/workflows/doxygen=2Eyml<br>M =2Egithub/=
workflows/test-ssllib=2Eyml<br>4 files changed, 20 insertions(+), 20 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/10/1710/2</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/=2Egithub/workflows/=
build=2Eyaml b/=2Egithub/workflows/build=2Eyaml</span><br><span>index b530f=
cc=2E=2E323645a 100644</span><br><span>--- a/=2Egithub/workflows/build=2Eya=
ml</span><br><span>+++ b/=2Egithub/workflows/build=2Eyaml</span><br><span>@=
@ -14,7 +14,7 @@</span><br><span>           sudo apt update &amp;&amp; sudo=
 apt install -y python3-pip</span><br><span>           pip3 install pre-com=
mit</span><br><span>       - name: Checkout OpenVPN</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@de0fac2e4500=
dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874edd31b4=
311f1884172cec0e10 # v6=2E0=2E3</span><br><span>       - name: Run clang-fo=
rmat</span><br><span>         run: pre-commit run -a --show-diff-on-failure=
 || true</span><br><span>       - name: Check for changes</span><br><span>@=
@ -43,11 +43,11 @@</span><br><span>       VCPKG_ROOT: ${{ github=2Eworkspac=
e }}/vcpkg</span><br><span>       VCPKG_INSTALLED_DIR: ${{ github=2Eworkspa=
ce }}/vcpkg/installed</span><br><span>       VCPKG_BINARY_SOURCES: clear;de=
fault,readwrite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 75672d=
b6bd812b060482b0f00b5a16b18a0c0f07</span><br><span>     steps:</span><br><s=
pan>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f=
5447ce83dd # v6=2E0=2E2</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-      - uses: lukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # =
v4=2E3=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
ses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka=
/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3</span><br>=
<span>       - name: Setup vcpkg</span><br><span>         uses: lukka/run-v=
cpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6</span><br><span>   =
      with:</span><br><span>@@ -84,14 +84,14 @@</span><br><span>     env:</=
span><br><span>       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg</span><br=
><span>       VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      VCPKG_GIT_COMMIT_ID: 031f4afe03=
be385aee354f15be6e6b1fe57497c7</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0=
f07</span><br><span>     steps:</span><br><span>       - name: Install depe=
ndencies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt =
install -y mingw-w64 unzip build-essential wget python3-docutils man2html-b=
ase</span><br><span>       - name: Checkout OpenVPN</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@de0fac2e4500=
dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874edd31b4=
311f1884172cec0e10 # v6=2E0=2E3</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@7bfc9baacbbdcb5e3=
7957ad05c3546b3e222be3c # v4=2E3=2E2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae3617=
2462abb3a42e # v4=2E3=2E3</span><br><span>       - name: Setup vcpkg</span>=
<br><span>         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a42=
7fb6a2 # v11=2E6</span><br><span>         with:</span><br><span>@@ -142,7 +=
142,7 @@</span><br><span>     name: &quot;mingw unittest ${{ matrix=2Etest =
}} - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL&quot;</span><br><s=
pan>     steps:</span><br><span>       - name: Checkout OpenVPN</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@de=
0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c069=
e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>       - name: =
Retrieve mingw unittest</span><br><span>         uses: actions/download-art=
ifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8=2E0=2E1</span><br><span=
>         with:</span><br><span>@@ -183,7 +183,7 @@</span><br><span>       =
- name: Install dependencies</span><br><span>         run: sudo apt update =
&amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-n=
g-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docuti=
ls libtool automake autoconf ${SSLPKG} ${PKCS11PKG}</span><br><span>       =
- name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd =
# v6=2E0=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=
=2E3</span><br><span>       - name: autoconf</span><br><span>         run: =
autoreconf -fvi</span><br><span>       - name: configure</span><br><span>@@=
 -213,7 +213,7 @@</span><br><span>       - name: Install dependencies</span=
><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y lib=
lzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-=
dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf=
</span><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        uses: actions/checkout@de0fac2e4500dabe0=
009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1=
884172cec0e10 # v6=2E0=2E3</span><br><span>       - name: autoconf</span><b=
r><span>         run: autoreconf -fvi</span><br><span>       - name: config=
ure</span><br><span>@@ -253,7 +253,7 @@</span><br><span>       - name: Inst=
all dependencies</span><br><span>         run: brew install ${{matrix=2Essl=
lib}} lzo lz4 man2html cmocka libtool automake autoconf</span><br><span>   =
    - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce8=
3dd # v6=2E0=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=
=2E0=2E3</span><br><span>       - name: Set environment</span><br><span>   =
      run: |</span><br><span>           cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF=
;</span><br><span>@@ -283,12 +283,12 @@</span><br><span>       env:</span><=
br><span>         BUILD_CONFIGURATION: Release</span><br><span>         VCP=
KG_BINARY_SOURCES: clear;default,readwrite</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15b=
e6e6b1fe57497c7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07</span><br=
><span> </span><br><span>       runs-on: windows-2025</span><br><span>     =
  steps:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses:=
 actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-c=
make@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v4=2E3=2E2</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/checkout@df4cb=
1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@591817e96fcad435=
05fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><span> </span><br><span>   =
    - name: Install rst2html</span><br><span>         run: python -m pip in=
stall --upgrade pip docutils</span><br><span>@@ -342,7 +342,7 @@</span><br>=
<span>       ovpnlibdesc: LibreSSL</span><br><span>       # versioning=3Dse=
mver-coerced</span><br><span>       ghrepo: libressl/portable</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-      gitref: v4=2E2=2E1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+      gitref: v4=2E3=2E2</span=
><br><span>       libconfigure: &quot;LIBRESSL_GIT_OPTIONS=3D--no-single-br=
anch =2E/autogen=2Esh &amp;&amp; =2E/configure --prefix=3D$LIBPREFIX&quot;<=
/span><br><span> </span><br><span>   openssl4:</span><br><span>@@ -376,7 +3=
76,7 @@</span><br><span>       ovpnlibdesc: AWS-LC</span><br><span>       #=
 versioning=3Dsemver-coerced</span><br><span>       ghrepo: aws/aws-lc</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      gitref: v1=2E70=2E0<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      gitref: v5=2E0=
=2E0</span><br><span>       libconfigure: cmake -B build -GNinja -DCMAKE_BU=
ILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D&quot;$LIBPREFIX&quot; -DBUILD_=
SHARED_LIBS=3D1</span><br><span>       libmake: cmake --build build</span><=
br><span>       libinstall: sudo cmake --install build</span><br><span>diff=
 --git a/=2Egithub/workflows/coverity-scan=2Eyml b/=2Egithub/workflows/cove=
rity-scan=2Eyml</span><br><span>index 1eec1ed=2E=2E105f23e 100644</span><br=
><span>--- a/=2Egithub/workflows/coverity-scan=2Eyml</span><br><span>+++ b/=
=2Egithub/workflows/coverity-scan=2Eyml</span><br><span>@@ -25,7 +25,7 @@</=
span><br><span> </span><br><span>       - name: Checkout OpenVPN</span><br>=
<span>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D &#39;tru=
e&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: a=
ctions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/che=
ckout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span=
> </span><br><span>       - name: Download Coverity Build Tool</span><br><s=
pan>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D &#39;true&=
#39;</span><br><span>diff --git a/=2Egithub/workflows/doxygen=2Eyml b/=2Egi=
thub/workflows/doxygen=2Eyml</span><br><span>index 30988b5=2E=2E3755b92 100=
644</span><br><span>--- a/=2Egithub/workflows/doxygen=2Eyml</span><br><span=
>+++ b/=2Egithub/workflows/doxygen=2Eyml</span><br><span>@@ -11,7 +11,7 @@<=
/span><br><span>     runs-on: ubuntu-24=2E04</span><br><span>     if: ${{ g=
ithub=2Erepository_owner =3D=3D &#39;openvpn&#39; || github=2Eevent_name =
=3D=3D &#39;workflow_dispatch&#39; }}</span><br><span>     steps:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/checkout@=
de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/checkout@df4cb1c069=
e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>         with:<=
/span><br><span>           path: openvpn</span><br><span> </span><br><span>=
diff --git a/=2Egithub/workflows/test-ssllib=2Eyml b/=2Egithub/workflows/te=
st-ssllib=2Eyml</span><br><span>index c6a2e44=2E=2Ed8178a7 100644</span><br=
><span>--- a/=2Egithub/workflows/test-ssllib=2Eyml</span><br><span>+++ b/=
=2Egithub/workflows/test-ssllib=2Eyml</span><br><span>@@ -77,7 +77,7 @@</sp=
an><br><span>           key: ${{matrix=2Eos}}-${{inputs=2Elibname}}-${{matr=
ix=2Ebuild }}-${{inputs=2Egitref}}</span><br><span>       - name: &quot;${{=
inputs=2Elibname}}: checkout&quot;</span><br><span>         if: steps=2Essl=
lib-cache=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@de0fac2e4500=
dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874edd31b4=
311f1884172cec0e10 # v6=2E0=2E3</span><br><span>         with:</span><br><s=
pan>           submodules: recursive</span><br><span>           path: ${{in=
puts=2Elibname}}</span><br><span>@@ -98,7 +98,7 @@</span><br><span>       -=
 name: Run ldconfig</span><br><span>         run: sudo ldconfig</span><br><=
span>       - name: &quot;OpenVPN: checkout&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        uses: actions/checkout@de0fac2e4500dabe=
0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874edd31b4311f=
1884172cec0e10 # v6=2E0=2E3</span><br><span>       - name: &quot;OpenVPN: a=
utoreconf&quot;</span><br><span>         run: autoreconf -fvi</span><br><sp=
an>       - name: &quot;OpenVPN: configure&quot;</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1710?usp=3Demail">change 1710</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1710?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I11fc104878ba244c5be04ce8019695b6892c4457=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1710 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--uCBMrClGE/E=--


--===============7409911492765245051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7409911492765245051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7409911492765245051==--

