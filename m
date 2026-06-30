Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0B1C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3w7i4xSz5yqNgaJgH1pQ1h5tiGN/NKqcEDFabl5mfnE=; b=YRQn60QiEl/IQragRl+sBh+cXc
	inxFBtuBH5i5PfRFcCzNPvdydrFdgU4By3/LEcq+iGVNNcRBKOXQEvghaFIaA0gSuabJWBiWBthcn
	9JyYCUxXg+06Tqw9V9vdzsMlnnQTl2/WaHip6xiNDzNQqHG/Yw3cnYnwlSYgUFPDFskU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weSPD-0003Z1-0Z;
	Tue, 30 Jun 2026 06:57:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weSPB-0003Ys-6w
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 06:57:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PIn+h0JZ7uCu2kwHcZorpDgsDB9yyaeBlYJDaPN/yqo=; b=EeZIvQ8267JdL622xNa4p4uHPN
 kCPL06KSj13S7yCl7sxnwqHrlUTATNNwO4hJWXJlQ2uk5li+6EiqGgXUAbcBZLMpCUWDHOmayeK90
 5wXKDjf40x8GnhVX2kUlnlXPOgSF5EZtwAwuPHIyYAdYFcjEryl5A9Fa+FC/mgc0xQfs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PIn+h0JZ7uCu2kwHcZorpDgsDB9yyaeBlYJDaPN/yqo=; b=N
 Zo2zy1gwVs7Jlwx11QdglvUfRTb0yBWCunbbYN2+o6LA4UaAa0bGwL0YZdx/GXOUq4ngFSPIkyt8P
 BxQ5sQSfqVOwMUVY0gd2ZxutMxlFzd/krkthabDWb1ECW0R3bmvqfNi3541q+V4PICWZ8SdvIO1Sk
 vNXdnBK0xvEkEBdU=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weSP8-0003BK-87 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 06:57:12 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493b5d61302so1511365e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 23:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782802624; x=1783407424; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PIn+h0JZ7uCu2kwHcZorpDgsDB9yyaeBlYJDaPN/yqo=;
 b=KavVYQhyE/qvhzj86pwek9lzGLAqlwVFEDUeMIZNbuKEFCINNXgoYZiO67kL+S4kUH
 uHMG74qsBrNm1tBJf0jMbqx+N5V1u4OhZYgleQ5MTir6Q5qtkDDxuePG70ZVEDsXZz9B
 FbAijrBYw5BWfsUmu76eJHcJJBbUARlCk1rYq88oQiS2DpQbwCG0b7eedPHBJbZEUSG0
 LDDKjZLnpuLonEI9nAIEKA2tTkus6CtOE0c8q1EQwpL6Rr8VP++nFefDJ4ErlEM1S4qi
 Kc1iKB+mAcqoZBnuA7rSG6IbeWhuGGuZvOni7engSvFHAi28nPHnFw/ZCuO0VoX0VT4h
 TcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782802624; x=1783407424;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PIn+h0JZ7uCu2kwHcZorpDgsDB9yyaeBlYJDaPN/yqo=;
 b=QtLRG732od5NGyjRfgrPThQAtFHNFP+gLbkpIIIjReGFPbe67giYOOFZAOIccsyp0Q
 3yNzxRaiKzxYDOaiMvtIgKYM1xdMSZK00t2Sduh08xbBAmCIucbVmPdJFy4weDucH4Wy
 AzmldomFywJyC8vmRgon3czerZqM/KOIN1P9c58D9334fWSmojMWIdx9zWbJJnptN2fG
 tIHiPahmTUEr9Id++HtOta+9EWWJXHFTRF1MHGUI5pDknFEflAaXlPivIk/hgPhb9I3F
 pK/3XA+gntncqzggr1rAXvyHI2sQIp85bqVAV0FvAhsHQj9htt1vYpBE1YVCQ6g6N9vB
 bgSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Iynxokbmml3eSKFH1u/rgE+nwvRPwu2lOYpRcHg0B1yehd5Hg0ny6XvQ7gX5ownsVPSEU2b7TRD1TBkrc@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwuHZySgvrjF8AVnncjt+6PV5p0uInPGvY9CEzxwvVdJDU0iARl
 gAJzVYKchVNiW+tdB1pPg9zov+PyUOBdcVdhwIQhBEVSKnnHqzktouuBrn3StsC/Z1CxfKD5rTp
 xDqL+ueNBfiVpQL+jenwGfw2pvVoe+sbUXvvsV8yVWsvf4IF6/xjqUqgzX8kFZRSD0qxw
X-Gm-Gg: AfdE7cnNfXt6r4Yqyh6/wD2SPNj/N4m2a/UlIjNUxZZZfVpGh1KDy2y3cc/C4zE0MZr
 LAqNJR9Y/wlbI325vt0WYr7f3Vv5fh9kYl5VDBYHJ5QKBY0TzEhhsEzKpyGVtLcgEIXX8EKp9tq
 tHufRLbbuUqHBgy0f7Y6HCFrctkFyp0wLfzzXnqIp7Jj1AvRhZOTweYlMU23u4Hzw/luTlLTsjM
 LQvV1N/toFq8wPlrRvST70BATBktm3cWZnaC43LC8YNsQGyAS+ZcDBAH75AdQv6rZkdhxEUyizQ
 1tlEllZmWwnm+6+hgo1hwycK5mZpGHZcMv/fr4W+zf+TczUWXcO2lTb2C2PR/Nuf+bFH7aZw1fU
 WySeX6iQnn7qCtHhJcxUG9v+E+rn8EuZtQcHWptK017Un7/JLwnsRobVgsgnQ0M9RQocDxGKvi5
 Bsm6/3OrJh1uzAC7+FkKZbqcWg8xKd3NWtBlEQg0+4zTvMnQDGpdvmVxOu2C+KBxBz5Vzp9DZqH
 Cei1IcriTC3g0jNppaT6NuGa5zPoHd0cGFCQ5VswORUi0K7oGSIwCru0zejRakHwmX20ecNzqw3
 r8M=
X-Received: by 2002:a05:600c:638d:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-493bc75299cmr4978695e9.16.1782802623922; 
 Mon, 29 Jun 2026 23:57:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8d0496csm40549665e9.10.2026.06.29.23.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 23:57:03 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 30 Jun 2026 06:57:03 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
X-Gerrit-Change-Number: 1754
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1754?usp=email>
X-Gerrit-Commit: 4967193d0c494f147833c6d0de47165a6286296b
In-Reply-To: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
References: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQwMzE3MDAwLkljYmNmNGM3OWQ1NzdkOWNmMDg5YTkyMzc4YmU5MjUzYjFlOTQ4MjVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c96333cf9504af602244c59cd93a0594749d1e06-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weSP8-0003BK-87
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: GHA:
 Cherry-pick changes from master to keep working
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
Content-Type: multipart/mixed; boundary="===============3715407471157120353=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3715407471157120353==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4g90FvC+ET8="; charset=UTF-8

--4g90FvC+ET8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1754?usp=3Demail )

Change subject: GHA: Cherry-pick changes from maste=
r to keep working
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

GHA: Cherry-pick changes from master to keep working

Cherry-pick appl=
icable changes from the following commits:

- GHA: Switch to using VS 2026
=
(cherry picked from commit 90499e51237cd11f813206371b7ba5176d8eb5ef)
- GHA:=
 Add caching for vcpkg builds
(cherry picked from commit 157087736427059316=
ecff7dd21e16b54077221a)
- GHA: Maintenance Update April 2026
  - Updates GH=
A actions
  - Switch uncrustify job to archive: false
  - Drop macos-14 bui=
lds
(cherry picked from commit cc2926fd5d09fd501b51520ed5a0b69399db85da)
GH=
A: Maintenance update June 2026
  - chore(deps): update github actions
  - =
chore(deps): update vcpkg digest to 75672db
(cherry picked from commit f9e6=
d5d724851a938a0c064307db513df469eb62)

Further changes:
  - Drop macos-13 b=
uilds
  - Add macos-26 builds
  - Drop openssl@1=2E1 from macOS, not availa=
ble in all versions anymore

Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e=
94825d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1754
Message-Id: <20260629181505=2E20031-1-gert@gree=
nie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg37398=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M =2Egithub/workflows/build=2Eyaml
M =2Egithub/workflow=
s/coverity-scan=2Eyml
2 files changed, 57 insertions(+), 32 deletions(-)


=


diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=
=2Eyaml
index 1abc178=2E=2E883e2dc 100644
--- a/=2Egithub/workflows/build=
=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -13,7 +13,7 @@
       - n=
ame: Install dependencies
         run: sudo apt update && sudo apt install=
 -y uncrustify
       - name: Checkout OpenVPN
-        uses: actions/check=
out@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2
+        uses: ac=
tions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
      =
   with:
           path: openvpn
       - name: Show uncrustify version
@@=
 -27,9 +27,9 @@
       - name: Show changes on standard output
         run=
: git diff
         working-directory: openvpn
-      - uses: actions/uploa=
d-artifact@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4=2E6=2E2
+      - u=
ses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=
=2E0=2E1
         with:
-          name: uncrustify-changes=2Epatch
+      =
    archive: false
           path: 'openvpn/uncrustify-changes=2Epatch'
  =
     - name: Set job status
         run: test ! -s uncrustify-changes=2Epa=
tch
@@ -45,27 +45,38 @@
     runs-on: ubuntu-24=2E04
     env:
       VCPKG=
_ROOT: ${{ github=2Eworkspace }}/vcpkg
+      VCPKG_BINARY_SOURCES: clear;d=
efault,readwrite
+      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16=
b18a0c0f07
     steps:
       - name: Install dependencies
         run: su=
do apt update && sudo apt install -y mingw-w64 unzip build-essential wget p=
ython3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses=
: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2
+ =
       uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=
=2E0=2E3
 
-      - uses: lukka/get-cmake@6b3e96a9bc9976b8b546346fdd102effe=
dae0ca8 # v4=2E0=2E3
-      - name: Restore from cache and install vcpkg
- =
       uses: lukka/run-vcpkg@5e0cab206a5ea620130caf672fce3e4a6b5666a1 # v11=
=2E5
+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42=
e # v4=2E3=2E3
+      - name: Setup vcpkg
+        uses: lukka/run-vcpkg@b1=
a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
         with:
-          =
vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
+          vcpkg=
GitCommitId: ${{ env=2EVCPKG_GIT_COMMIT_ID }}
           vcpkgJsonGlob: '**=
/mingw/vcpkg=2Ejson'
 
+      - name: Set up vcpkg binary cache
+        us=
es: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+  =
      with:
+          path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}
+     =
     key: mingw-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles('**/m=
ingw/vcpkg=2Ejson') }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}
+          restore-=
keys: |
+            mingw-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hash=
Files('**/mingw/vcpkg=2Ejson') }}-
+            mingw-${{ matrix=2Earch }}-=
vcpkg-binary-cache-
+
       - name: Run CMake with vcpkg=2Ejson manifest
-=
        uses: lukka/run-cmake@af1be47fd7c933593f687731bc6fdbee024d3ff4 # v1=
0=2E8
+        uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a9=
56 # v10=2E9
         with:
           configurePreset: mingw-${{ matrix=2E=
arch }}
           buildPreset: mingw-${{ matrix=2Earch }}
           build=
PresetAdditionalArgs: "['--config Debug']"
 
-      - uses: actions/upload-=
artifact@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4=2E6=2E2
+      - use=
s: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E=
0=2E1
         with:
           name: openvpn-mingw-${{ matrix=2Earch }}
  =
         path: |
@@ -73,7 +84,7 @@
             ${{ github=2Eworkspace }}/o=
ut/build/mingw/${{ matrix=2Earch }}/**/Debug/*=2Edll
             !${{ gith=
ub=2Eworkspace }}/out/build/mingw/${{ matrix=2Earch }}/Debug/test_*=2Eexe
 =

-      - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f4360=
7fa02 # v4=2E6=2E2
+      - uses: actions/upload-artifact@043fb46d1a93c77aa=
e656e7c1c64a875d1fc6a0a # v7=2E0=2E1
         with:
           name: openvp=
n-mingw-${{ matrix=2Earch }}-tests
           path: |
@@ -88,11 +99,11 @@
 =
        arch: [x86, x64]
         test: [argv, auth_token, buffer, cryptoap=
i, crypto, misc, ncp, packet_id, pkt, provider, tls_crypt]
 
-    runs-on: =
windows-latest
+    runs-on: windows-2025-vs2026
     name: "mingw unittest=
 ${{ matrix=2Etest }} - ${{ matrix=2Earch }} - OSSL"
     steps:
       - n=
ame: Retrieve mingw unittest
-        uses: actions/download-artifact@d3f86=
a106a0bac45b974a628896c90dbdf5c8093 # v4=2E3=2E0
+        uses: actions/dow=
nload-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8=2E0=2E1
      =
   with:
           name: openvpn-mingw-${{ matrix=2Earch }}-tests
        =
   path: unittests
@@ -131,7 +142,7 @@
       - name: Install dependencies
=
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmo=
cka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
 =
      - name: Checkout OpenVPN
-        uses: actions/checkout@11bd71901bbe=
5b1630ceea73d27597364c9af683 # v4=2E2=2E2
+        uses: actions/checkout@d=
f4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
       - name: autocon=
f
         run: autoreconf -fvi
       - name: configure
@@ -158,7 +169,7 @=
@
       - name: Install dependencies
         run: sudo apt update && sudo=
 apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-gen=
l-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtoo=
l automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-       =
 uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=
=2E2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e=
10 # v6=2E0=2E3
       - name: autoconf
         run: autoreconf -fvi
     =
  - name: configure
@@ -172,9 +183,9 @@
     strategy:
       fail-fast: fa=
lse
       matrix:
-        ssllib: [openssl@1=2E1, openssl@3, libressl]
+ =
       ssllib: [openssl@3, libressl]
         build: [normal, asan]
-      =
  os: [macos-13, macos-14, macos-15]
+        os: [macos-15, macos-26]
    =
     include:
           - build: asan
             cflags: "-fsanitize=3Da=
ddress,undefined -fno-sanitize-recover=3Dall -fno-optimize-sibling-calls -f=
sanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
@@ -196,7 =
+207,7 @@
       - name: Install dependencies
         run: brew install ${=
{matrix=2Essllib}} lzo lz4 man2html cmocka libtool automake autoconf
      =
 - name: Checkout OpenVPN
-        uses: actions/checkout@11bd71901bbe5b163=
0ceea73d27597364c9af683 # v4=2E2=2E2
+        uses: actions/checkout@df4cb1=
c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
       - name: Set environm=
ent
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -223,38 +234,52 =
@@
       name: "msbuild - ${{ matrix=2Earch }} - openssl"
       env:
    =
     BUILD_CONFIGURATION: Release
+        VCPKG_BINARY_SOURCES: clear;defa=
ult,readwrite
+        VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b=
18a0c0f07
 
-      runs-on: windows-latest
+      runs-on: windows-2025-vs2=
026
       steps:
-      - uses: actions/checkout@11bd71901bbe5b1630ceea73d=
27597364c9af683 # v4=2E2=2E2
-      - uses: lukka/get-cmake@6b3e96a9bc9976b=
8b546346fdd102effedae0ca8 # v4=2E0=2E3
+      - uses: actions/checkout@df4c=
b1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
+      - uses: lukka/get-=
cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3
 
       - name=
: Install rst2html
         run: python -m pip install --upgrade pip docuti=
ls
 
-      - name: Restore artifacts, or setup vcpkg (do not install any p=
ackage)
-        uses: lukka/run-vcpkg@5e0cab206a5ea620130caf672fce3e4a6b56=
66a1 # v11=2E5
+      - name: Setup vcpkg (do not install any package)
+   =
     uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=
=2E6
         with:
-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da16=
67c1458e6d7abf
+          vcpkgGitCommitId: ${{ env=2EVCPKG_GIT_COMMIT_ID }=
}
           vcpkgJsonGlob: '**/windows/vcpkg=2Ejson'
 
+      - name: Set =
up vcpkg binary cache
+        uses: actions/cache@27d5ce7f107fe9357f9df03e=
fb73ab90386fccae # v5=2E0=2E5
+        with:
+          path: ${{ env=2EVCP=
KG_DEFAULT_BINARY_CACHE }}
+          key: msvc-${{ matrix=2Earch }}-vcpkg-=
binary-cache-${{ hashFiles('**/windows/vcpkg=2Ejson') }}-${{ env=2EVCPKG_GI=
T_COMMIT_ID }}
+          restore-keys: |
+            msvc-${{ matrix=2Ear=
ch }}-vcpkg-binary-cache-${{ hashFiles('**/windows/vcpkg=2Ejson') }}-
+    =
        msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-
+
+
       - name: Ru=
n CMake with vcpkg=2Ejson manifest (NO TESTS)
-        uses: lukka/run-cmak=
e@af1be47fd7c933593f687731bc6fdbee024d3ff4 # v10=2E8
+        uses: lukka/r=
un-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10=2E9
         if: ${=
{ matrix=2Earch =3D=3D 'arm64' }}
         with:
           configurePreset=
: win-${{ matrix=2Earch }}-release
           buildPreset: win-${{ matrix=
=2Earch }}-release
+          configurePresetAdditionalArgs: "['-GVisual St=
udio 18 2026']"
 
       - name: Run CMake with vcpkg=2Ejson manifest
-    =
    uses: lukka/run-cmake@af1be47fd7c933593f687731bc6fdbee024d3ff4 # v10=2E=
8
+        uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 #=
 v10=2E9
         if: ${{ matrix=2Earch !=3D 'arm64' }}
         with:
    =
       configurePreset: win-${{ matrix=2Earch }}-release
           buildPr=
eset: win-${{ matrix=2Earch }}-release
           testPreset: win-${{ matri=
x=2Earch }}-release
+          configurePresetAdditionalArgs: "['-GVisual S=
tudio 18 2026']"
           testPresetAdditionalArgs: "['--output-on-failur=
e']"
 
-      - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b488=
6f43607fa02 # v4=2E6=2E2
+      - uses: actions/upload-artifact@043fb46d1a9=
3c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1
         with:
           name: =
openvpn-msvc-${{ matrix=2Earch }}
           path: |
@@ -294,7 +319,7 @@
  =
     - name: Install dependencies
         run: sudo apt update && sudo apt=
 install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html cla=
ng libcmocka-dev python3-docutils libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        use=
s: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2
+=
        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v=
6=2E0=2E2
         with:
           path: libressl
           repository: l=
ibressl/portable
@@ -316,7 +341,7 @@
       - name: "ldconfig"
         run=
: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/chec=
kout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2
+        uses: a=
ctions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
     =
  - name: autoconf
         run: autoreconf -fvi
       - name: configure
d=
iff --git a/=2Egithub/workflows/coverity-scan=2Eyml b/=2Egithub/workflows/c=
overity-scan=2Eyml
index 1a9e5a3=2E=2E105f23e 100644
--- a/=2Egithub/workfl=
ows/coverity-scan=2Eyml
+++ b/=2Egithub/workflows/coverity-scan=2Eyml
@@ -1=
3,7 +13,7 @@
     steps:
       - name: Check submission cache
         id:=
 check_submit
-        uses: actions/cache/restore@5a3ec84eff668545956fd180=
22155c47e93e2684 # v4=2E2=2E3
+        uses: actions/cache/restore@27d5ce7f=
107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
         with:
           pat=
h: |
             cov-int
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenV=
PN
         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'true'
-   =
     uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4
+=
        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v=
6=2E0=2E3
 
       - name: Download Coverity Build Tool
         if: steps=
=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'true'
@@ -65,7 +65,7 @@
 
     =
  - name: Cache submission
         if: steps=2Echeck_submit=2Eoutputs=2Eca=
che-hit !=3D 'true'
-        uses: actions/cache/save@5a3ec84eff668545956fd=
18022155c47e93e2684 # v4=2E2=2E3
+        uses: actions/cache/save@27d5ce7f=
107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
         with:
           pat=
h: |
             cov-int

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1754?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-=
Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
Gerrit-Change-Number: =
1754
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--4g90FvC+ET8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1754?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">GHA: Cherry-pick changes from master to ke=
ep working<br><br>Cherry-pick applicable changes from the following commits=
:<br><br>- GHA: Switch to using VS 2026<br>(cherry picked from commit 90499=
e51237cd11f813206371b7ba5176d8eb5ef)<br>- GHA: Add caching for vcpkg builds=
<br>(cherry picked from commit 157087736427059316ecff7dd21e16b54077221a)<br=
>- GHA: Maintenance Update April 2026<br>  - Updates GHA actions<br>  - Swi=
tch uncrustify job to archive: false<br>  - Drop macos-14 builds<br>(cherry=
 picked from commit cc2926fd5d09fd501b51520ed5a0b69399db85da)<br>GHA: Maint=
enance update June 2026<br>  - chore(deps): update github actions<br>  - ch=
ore(deps): update vcpkg digest to 75672db<br>(cherry picked from commit f9e=
6d5d724851a938a0c064307db513df469eb62)<br><br>Further changes:<br>  - Drop =
macos-13 builds<br>  - Add macos-26 builds<br>  - Drop openssl@1=2E1 from m=
acOS, not available in all versions anymore<br><br>Change-Id: Icbcf4c79d577=
d9cf089a92378be9253b1e94825d<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2E=
org&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754<br>M=
essage-Id: &lt;20260629181505=2E20031-1-gert@greenie=2Emuc=2Ede&gt;<br>URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg37398=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M =2Egithub/workflows/build=2Eyaml<br>M =2Egithub/workflows/co=
verity-scan=2Eyml<br>2 files changed, 57 insertions(+), 32 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/wor=
kflows/build=2Eyaml</span><br><span>index 1abc178=2E=2E883e2dc 100644</span=
><br><span>--- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2E=
github/workflows/build=2Eyaml</span><br><span>@@ -13,7 +13,7 @@</span><br><=
span>       - name: Install dependencies</span><br><span>         run: sudo=
 apt update &amp;&amp; sudo apt install -y uncrustify</span><br><span>     =
  - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af68=
3 # v4=2E2=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=
=2E2</span><br><span>         with:</span><br><span>           path: openvp=
n</span><br><span>       - name: Show uncrustify version</span><br><span>@@=
 -27,9 +27,9 @@</span><br><span>       - name: Show changes on standard out=
put</span><br><span>         run: git diff</span><br><span>         working=
-directory: openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
    - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa0=
2 # v4=2E6=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a #=
 v7=2E0=2E1</span><br><span>         with:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-          name: uncrustify-changes=2Epatch</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+          archive: false</span>=
<br><span>           path: &#39;openvpn/uncrustify-changes=2Epatch&#39;</sp=
an><br><span>       - name: Set job status</span><br><span>         run: te=
st ! -s uncrustify-changes=2Epatch</span><br><span>@@ -45,27 +45,38 @@</spa=
n><br><span>     runs-on: ubuntu-24=2E04</span><br><span>     env:</span><b=
r><span>       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_BINARY_SOURCES: clear;de=
fault,readwrite</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07</span><br><=
span>     steps:</span><br><span>       - name: Install dependencies</span>=
<br><span>         run: sudo apt update &amp;&amp; sudo apt install -y ming=
w-w64 unzip build-essential wget python3-docutils man2html-base</span><br><=
span>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        uses: actions/checkout@11bd71901bbe5b1630ceea73d2759=
7364c9af683 # v4=2E2=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e1=
0 # v6=2E0=2E3</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      - uses: lukka/get-cmake@6b3e96a9bc9976b8b546346fdd102effed=
ae0ca8 # v4=2E0=2E3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
    - name: Restore from cache and install vcpkg</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        uses: lukka/run-vcpkg@5e0cab206a5ea62013=
0caf672fce3e4a6b5666a1 # v11=2E5</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462=
abb3a42e # v4=2E3=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      - name: Setup vcpkg</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb=
6a2 # v11=2E6</span><br><span>         with:</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da=
1667c1458e6d7abf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
       vcpkgGitCommitId: ${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span> =
          vcpkgJsonGlob: &#39;**/mingw/vcpkg=2Ejson&#39;</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Set up=
 vcpkg binary cache</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=
=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wit=
h:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          path: $=
{{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+          key: mingw-${{ matrix=2Earch }}-vcpkg-binary-c=
ache-${{ hashFiles(&#39;**/mingw/vcpkg=2Ejson&#39;) }}-${{ env=2EVCPKG_GIT_=
COMMIT_ID }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
   restore-keys: |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           mingw-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles(&#39=
;**/mingw/vcpkg=2Ejson&#39;) }}-</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            mingw-${{ matrix=2Earch }}-vcpkg-binary-cache-</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>      =
 - name: Run CMake with vcpkg=2Ejson manifest</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        uses: lukka/run-cmake@af1be47fd7c933593f687=
731bc6fdbee024d3ff4 # v10=2E8</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e0=
3a956 # v10=2E9</span><br><span>         with:</span><br><span>           c=
onfigurePreset: mingw-${{ matrix=2Earch }}</span><br><span>           build=
Preset: mingw-${{ matrix=2Earch }}</span><br><span>           buildPresetAd=
ditionalArgs: &quot;[&#39;--config Debug&#39;]&quot;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/uplo=
ad-artifact@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4=2E6=2E2</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-=
artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1</span><br><s=
pan>         with:</span><br><span>           name: openvpn-mingw-${{ matri=
x=2Earch }}</span><br><span>           path: |</span><br><span>@@ -73,7 +84=
,7 @@</span><br><span>             ${{ github=2Eworkspace }}/out/build/ming=
w/${{ matrix=2Earch }}/**/Debug/*=2Edll</span><br><span>             !${{ g=
ithub=2Eworkspace }}/out/build/mingw/${{ matrix=2Earch }}/Debug/test_*=2Eex=
e</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
    - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa0=
2 # v4=2E6=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a #=
 v7=2E0=2E1</span><br><span>         with:</span><br><span>           name:=
 openvpn-mingw-${{ matrix=2Earch }}-tests</span><br><span>           path: =
|</span><br><span>@@ -88,11 +99,11 @@</span><br><span>         arch: [x86, =
x64]</span><br><span>         test: [argv, auth_token, buffer, cryptoapi, c=
rypto, misc, ncp, packet_id, pkt, provider, tls_crypt]</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: windows-lat=
est</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: win=
dows-2025-vs2026</span><br><span>     name: &quot;mingw unittest ${{ matrix=
=2Etest }} - ${{ matrix=2Earch }} - OSSL&quot;</span><br><span>     steps:<=
/span><br><span>       - name: Retrieve mingw unittest</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: actions/download-artifact@d3=
f86a106a0bac45b974a628896c90dbdf5c8093 # v4=2E3=2E0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/download-artifact@3=
e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8=2E0=2E1</span><br><span>      =
   with:</span><br><span>           name: openvpn-mingw-${{ matrix=2Earch }=
}-tests</span><br><span>           path: unittests</span><br><span>@@ -131,=
7 +142,7 @@</span><br><span>       - name: Install dependencies</span><br><=
span>         run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-d=
ev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev ma=
n2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} $=
{PKCS11PKG}</span><br><span>       - name: Checkout OpenVPN</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@11bd71=
901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874e=
dd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>       - name: autoco=
nf</span><br><span>         run: autoreconf -fvi</span><br><span>       - n=
ame: configure</span><br><span>@@ -158,7 +169,7 @@</span><br><span>       -=
 name: Install dependencies</span><br><span>         run: sudo apt update &=
amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng=
-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-d=
ocutils libtool automake autoconf libmbedtls-dev</span><br><span>       - n=
ame: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v=
4=2E2=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3<=
/span><br><span>       - name: autoconf</span><br><span>         run: autor=
econf -fvi</span><br><span>       - name: configure</span><br><span>@@ -172=
,9 +183,9 @@</span><br><span>     strategy:</span><br><span>       fail-fas=
t: false</span><br><span>       matrix:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        ssllib: [openssl@1=2E1, openssl@3, libressl]</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        ssllib: [openssl=
@3, libressl]</span><br><span>         build: [normal, asan]</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        os: [macos-13, macos-14, mac=
os-15]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        os: [=
macos-15, macos-26]</span><br><span>         include:</span><br><span>     =
      - build: asan</span><br><span>             cflags: &quot;-fsanitize=
=3Daddress,undefined -fno-sanitize-recover=3Dall -fno-optimize-sibling-call=
s -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</=
span><br><span>@@ -196,7 +207,7 @@</span><br><span>       - name: Install d=
ependencies</span><br><span>         run: brew install ${{matrix=2Essllib}}=
 lzo lz4 man2html cmocka libtool automake autoconf</span><br><span>       -=
 name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 #=
 v4=2E2=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E=
3</span><br><span>       - name: Set environment</span><br><span>         r=
un: |</span><br><span>           cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF;</span=
><br><span>@@ -223,38 +234,52 @@</span><br><span>       name: &quot;msbuild=
 - ${{ matrix=2Earch }} - openssl&quot;</span><br><span>       env:</span><=
br><span>         BUILD_CONFIGURATION: Release</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        VCPKG_BINARY_SOURCES: clear;default,read=
write</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VCPKG_=
GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      runs-on: windows-=
latest</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      runs-on=
: windows-2025-vs2026</span><br><span>       steps:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/checkout@11bd71901bbe=
5b1630ceea73d27597364c9af683 # v4=2E2=2E2</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-      - uses: lukka/get-cmake@6b3e96a9bc9976b8b546346fd=
d102effedae0ca8 # v4=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172ce=
c0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=
=2E3=2E3</span><br><span> </span><br><span>       - name: Install rst2html<=
/span><br><span>         run: python -m pip install --upgrade pip docutils<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  - name: Restore artifacts, or setup vcpkg (do not install any package)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-=
vcpkg@5e0cab206a5ea620130caf672fce3e4a6b5666a1 # v11=2E5</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      - name: Setup vcpkg (do not inst=
all any package)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=
=2E6</span><br><span>         with:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458=
e6d7abf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          vc=
pkgGitCommitId: ${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>          =
 vcpkgJsonGlob: &#39;**/windows/vcpkg=2Ejson&#39;</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Set up vcpkg =
binary cache</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        with:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+          path: ${{ env=2E=
VCPKG_DEFAULT_BINARY_CACHE }}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+          key: msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ h=
ashFiles(&#39;**/windows/vcpkg=2Ejson&#39;) }}-${{ env=2EVCPKG_GIT_COMMIT_I=
D }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          resto=
re-keys: |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles(&#39;**/windo=
ws/vcpkg=2Ejson&#39;) }}-</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>       - name: Run CMake with vcp=
kg=2Ejson manifest (NO TESTS)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        uses: lukka/run-cmake@af1be47fd7c933593f687731bc6fdbee024d3=
ff4 # v10=2E8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10=2E9<=
/span><br><span>         if: ${{ matrix=2Earch =3D=3D &#39;arm64&#39; }}</s=
pan><br><span>         with:</span><br><span>           configurePreset: wi=
n-${{ matrix=2Earch }}-release</span><br><span>           buildPreset: win-=
${{ matrix=2Earch }}-release</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+          configurePresetAdditionalArgs: &quot;[&#39;-GVisual Stud=
io 18 2026&#39;]&quot;</span><br><span> </span><br><span>       - name: Run=
 CMake with vcpkg=2Ejson manifest</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        uses: lukka/run-cmake@af1be47fd7c933593f687731bc6fdbee0=
24d3ff4 # v10=2E8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10=
=2E9</span><br><span>         if: ${{ matrix=2Earch !=3D &#39;arm64&#39; }}=
</span><br><span>         with:</span><br><span>           configurePreset:=
 win-${{ matrix=2Earch }}-release</span><br><span>           buildPreset: w=
in-${{ matrix=2Earch }}-release</span><br><span>           testPreset: win-=
${{ matrix=2Earch }}-release</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+          configurePresetAdditionalArgs: &quot;[&#39;-GVisual Stud=
io 18 2026&#39;]&quot;</span><br><span>           testPresetAdditionalArgs:=
 &quot;[&#39;--output-on-failure&#39;]&quot;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artif=
act@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4=2E6=2E2</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact=
@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1</span><br><span>    =
     with:</span><br><span>           name: openvpn-msvc-${{ matrix=2Earch =
}}</span><br><span>           path: |</span><br><span>@@ -294,7 +319,7 @@</=
span><br><span>       - name: Install dependencies</span><br><span>        =
 run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><=
br><span>       - name: &quot;libressl: checkout&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@11bd71901bb=
e5b1630ceea73d27597364c9af683 # v4=2E2=2E2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        uses: actions/checkout@de0fac2e4500dabe0009e=
67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span>         with:</span><br><=
span>           path: libressl</span><br><span>           repository: libre=
ssl/portable</span><br><span>@@ -316,7 +341,7 @@</span><br><span>       - n=
ame: &quot;ldconfig&quot;</span><br><span>         run: sudo ldconfig</span=
><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        uses: actions/checkout@11bd71901bbe5b1630ceea7=
3d27597364c9af683 # v4=2E2=2E2</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f544=
7ce83dd # v6=2E0=2E2</span><br><span>       - name: autoconf</span><br><spa=
n>         run: autoreconf -fvi</span><br><span>       - name: configure</s=
pan><br><span>diff --git a/=2Egithub/workflows/coverity-scan=2Eyml b/=2Egit=
hub/workflows/coverity-scan=2Eyml</span><br><span>index 1a9e5a3=2E=2E105f23=
e 100644</span><br><span>--- a/=2Egithub/workflows/coverity-scan=2Eyml</spa=
n><br><span>+++ b/=2Egithub/workflows/coverity-scan=2Eyml</span><br><span>@=
@ -13,7 +13,7 @@</span><br><span>     steps:</span><br><span>       - name:=
 Check submission cache</span><br><span>         id: check_submit</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/res=
tore@5a3ec84eff668545956fd18022155c47e93e2684 # v4=2E2=2E3</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache/restore@=
27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span>     =
    with:</span><br><span>           path: |</span><br><span>             c=
ov-int</span><br><span>@@ -25,7 +25,7 @@</span><br><span> </span><br><span>=
       - name: Checkout OpenVPN</span><br><span>         if: steps=2Echeck_=
submit=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        uses: actions/checkout@11bd71901bbe5b163=
0ceea73d27597364c9af683 # v4</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172ce=
c0e10 # v6=2E0=2E3</span><br><span> </span><br><span>       - name: Downloa=
d Coverity Build Tool</span><br><span>         if: steps=2Echeck_submit=2Eo=
utputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span>@@ -65,7 +65,7 @@</s=
pan><br><span> </span><br><span>       - name: Cache submission</span><br><=
span>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D &#39;true=
&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: ac=
tions/cache/save@5a3ec84eff668545956fd18022155c47e93e2684 # v4=2E2=2E3</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/ca=
che/save@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><s=
pan>         with:</span><br><span>           path: |</span><br><span>     =
        cov-int</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail">change 1754=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id:=
 Icbcf4c79d577d9cf089a92378be9253b1e94825d </div>
<div style=3D"display:non=
e"> Gerrit-Change-Number: 1754 </div>
<div style=3D"display:none"> Gerrit-P=
atchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>

</body></html>
--4g90FvC+ET8=--


--===============3715407471157120353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3715407471157120353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3715407471157120353==--

