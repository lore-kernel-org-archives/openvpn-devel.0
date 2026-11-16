Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6EE606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fHREB9ER;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bstKTJjw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DBzVcO+3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PZ7rf42B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8P9ayLRGjXPKrj5tzbLnLFkpChiZ2iB3fHomGib/3Rc=; b=fHREB9ERuEX2GutTW6bHTqOK1p
	8/+zRPBWP2ZrkSGxg1OIweQQlROEUN2HSx1umOD+eR+OhRHNpsQ1Pam/a1s0HklVKZSXHT2qTMAAR
	A3WUYNwPfRWB/J+LkNi2coJd1bpBB94MMMTuqNOo+CVvDLysMEw/zhD7o9DEPrDBJXl4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxqD-0000000023G-1g6n;
	Mon, 16 Nov 2026 14:37:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxqB-0000000023A-2sOd
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:37:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vYyYjUy60iqWQP0fvhw+QgkbyXM2j9amGInenL0uIEI=; b=bstKTJjw2mg0ixGF8dmBVKYKXG
 +GOXXCNf+hW7Q6iqkkuHVdYQEeVKylsz71ObmcwDndaHe6mvYH14GnyROs6EPCMYD5SWODniG3nm6
 4+NVXch2e0Yp/x14+CO6We6pBYL7gdQvnabJMu9kwj1wMZLIlSif2CFBg5+Qfu1dOV2s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vYyYjUy60iqWQP0fvhw+QgkbyXM2j9amGInenL0uIEI=; b=DBzVcO+3o3A6tf/HYWNtn3krH7
 W7o8E6P+cHgjTZS628tlZ41qtSJEFr6/jqwcCjrtMqrVakCgZOgJucIMQrjZWva0rBLPu9Ag+nMSb
 DP/aVFo9xRtPFgpSX3hm6SICrXoaZXm+LVqLMPjhxnpc7FS+0pAHScp7UY3NvPmPg7/E=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxqA-00000000694-0WVR for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:37:51 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so15918275e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794839863; x=1795444663; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vYyYjUy60iqWQP0fvhw+QgkbyXM2j9amGInenL0uIEI=;
 b=PZ7rf42BNS5SVatQn7rOL+qFvjqmdxogOlZU8zI6pZSPFUrUhnNDKVQRq8G58ZJSzy
 3bVVa/lOEEJ0QNohn0eZL+F+wn2/tQgarOZtrWlf7vSkFPDtYwAmM1VrHP0OdfxXISNE
 EN8rJOsJ2ZX6B0V+riNyAkOMFoVBgM7DxfVAeso0xjYF5K4QpbkC2UpIiTre/lLyjOJx
 nIA4IyWuU3okLahhYLy8b1kLAi/NThA19XupdSqzl2yXi16GT6bHkIjkOerNeAIJXYkL
 LiPujuoCC77TCghN/rdz52kLWdvtoNE0s+tsSUIoeSCRQvZHww4iuMKe9WHURs4ZehMQ
 IKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794839863; x=1795444663;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vYyYjUy60iqWQP0fvhw+QgkbyXM2j9amGInenL0uIEI=;
 b=BZl6OBsGgyKe2SZv7+ij3sGDqbiaoLWWvbPsPZVCE+TGM2oTUoUanmZU5yziWVpHpF
 WV4M8DT5r+ExRFpG6KMQ+TpzM92QlSpqdbCwDLLQL1a5Vog2LdGWT0f9xdO6yHbgaHLx
 fyTiUEaSK3ee5JB4F3Z+vF4FFpPV4XEGh/w6ZuPzPlZPsdKUMIb1e8TAyf0WWhrjLIk3
 5JF3ucHLMyopvv4twY7df35xH516pfip83X7WfK6WaQ0uLjO9Epe7iVQlwrqAaSWV3wK
 6cwY5H8tUQaT34LKNL7g7HW6ayJPGFIiik5dSagFdA/P0OkCn2Gb0AktEOEAGD8NZuQL
 awvg==
X-Gm-Message-State: APuU4Z8eUjzVE8q0+LJEWwOxW2oU3/m5JvTxPYAkSasKi2e20AXr2HaQ
 JJ8zK8zD/AR9fbYP9FaVt5LHOQMVaKbvuCmiCuAA1zZXLMcxXZUTrsyi0arqeDnewIkR2QMWN1y
 xmB0vDhe4RT5twtyzaJYM8eCVLyKE3T13KOps5l7bGuesMegcJemMCxcAbVvz5Zg3jolsFI93I9
 hrpItIJw==
X-Gm-Gg: AYBFou2U90D+wqs5Cj1dv9zZORmV5SzCD5AMLwDA5LwsPjaTvi8nQCQVYhwIW+sx5d3
 1iuthssk4JsGuw6IvrmBfk1LSadcX9xIxmM2HF/QTl0/4eFaPJY4Kn+zibo0jPBBPQJvg/TusG8
 lK3nRN4YW/r43ZX0ymgHvtUsF7573TDC4tbPrWhQXBH/HJzhk7NL3yNWWn+Dx6th3q6ULYKu30P
 hz6DlxEI1Uc+htMRGKNzHweEUBPweLT04RV0GU/vVbGirSNVrazwIbuGL3Yz3msIvZOAFWTvY75
 FyQtLLbR/PKge3ydFYa1kRq3EFuuGZDaM2y/qSxFksmZ7ChISFbFVKlKl8tscd9JVzhK833y4mB
 EsFiuR3gV1f1ahbRUnk7WFrAXHlpEvgZ/PHQu3zFFszHVchctA550CZbVzB6RQwdhoyQHuoaVr9
 xJPXpALgnuyI4PYVigMn+XWC8UmBJWYm2aXlqi3V07QdmuY0LiJjmRykFP5BX4uSuhNq6VuQs8J
 ifPDQJkbivp8y2nC88bGsKVaA/2WJIEeJYVqdf1bZrrX7LsY17nKlJpKLIWmWtZrcmMSbuE5FJe
 YurTa16lUbR640H/LjIRwqooNaNuE2z7qYz6dAHHXFcTaW5LmkaaaITjjE6+cwJWKt0Sa0Z7C6P
 NGOaSGAOPqY4Fg+//Y7NOw6lKCK9yZ2obaOLKdTRhhro5hXh+i54XPvL0tQWCKcbPph+FjezB3c
 nGUsnawdFUWTD1RQ8=
X-Received: by 2002:a05:600c:588b:b0:4bb:643e:3b8a with SMTP id
 5b1f17b1804b1-4bb643e3bd6mr140084565e9.17.1794839863334; 
 Mon, 16 Nov 2026 06:37:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c603f4d29sm22229148f8f.35.2026.11.16.06.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:37:42 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:37:35 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91
X-Gerrit-Change-Number: 2194
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2194?usp=email>
X-Gerrit-Commit: 6f1b0274bb5d9af332b749d54716084834a95101
In-Reply-To: <gerrit.1794832910000.Ib2849dc2c0a451b26fad985faf757ff22a852e91@gerrit.openvpn.net>
References: <gerrit.1794832910000.Ib2849dc2c0a451b26fad985faf757ff22a852e91@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMyOTEwMDAwLkliMjg0OWRjMmMwYTQ1MWIyNmZhZDk4NWZhZjc1N2ZmMjJhODUyZTkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d38f7a84e50da04169238a84872c47a0050bb27d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSxqA-00000000694-0WVR
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Use latest NDK
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6497357376772049298=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6497357376772049298==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LxrN/itk+fg="; charset=UTF-8

--LxrN/itk+fg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2194?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: GHA: Use latest NDK
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Use latest NDK

Stay in sync with what=
 buildbot uses=2E The images still use
NDK r27 which is quite old by now=2E=


While here, update vcpkg reference to latest master=2E

Change-Id: Ib2849=
dc2c0a451b26fad985faf757ff22a852e91
Signed-off-by: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
---
M =2Egithub/workflows/build=2Eyaml
1 file changed, =
7 insertions(+), 5 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/94/2194/2

diff --git a/=2Egithub/workflows/build=
=2Eyaml b/=2Egithub/workflows/build=2Eyaml
index d50b7ff=2E=2E19c78e9 10064=
4
--- a/=2Egithub/workflows/build=2Eyaml
+++ b/=2Egithub/workflows/build=2E=
yaml
@@ -36,14 +36,12 @@
             vcpkg_triplet: arm64-android
     run=
s-on: ubuntu-26=2E04
     name: "Android - ${{ matrix=2Eabi }}"
-    # Gith=
ub images already setup NDK with ANDROID_NDK_ROOT pointing to the root
-   =
 # of the SDK
     env:
       VCPKG_DEFAULT_TRIPLET: ${{ matrix=2Evcpkg_tr=
iplet }}
       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg
       VCPKG_IN=
STALLED_DIR: ${{ github=2Eworkspace }}/vcpkg/installed
       VCPKG_BINARY_=
SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 5f96cd15fd7451=
22cf27e0524606d6c1efc5fd07
+      VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4bc5=
1e5eb32a2617538049c8
     steps:
       - name: Checkout OpenVPN
         u=
ses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1=

@@ -59,6 +57,10 @@
           key: android-${{ matrix=2Eabi }}-vcpkg-binar=
y-cache-${{ env=2EVCPKG_GIT_COMMIT_ID }}
           restore-keys: |
       =
      android-${{ matrix=2Eabi }}-vcpkg-binary-cache-
+      - name: Config=
ure NDK version
+        run: |
+          echo "ANDROID_NDK_HOME=3D$ANDROI=
D_NDK_LATEST_HOME" >>$GITHUB_ENV
+          echo "ANDROID_NDK_ROOT=3D$ANDRO=
ID_NDK_LATEST_HOME" >>$GITHUB_ENV
       - name: Install dependencies
     =
    run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: conf=
igure OpenVPN with cmake
@@ -90,7 +92,7 @@
     env:
       VCPKG_ROOT: ${{=
 github=2Eworkspace }}/vcpkg
       VCPKG_BINARY_SOURCES: clear;default,rea=
dwrite
-      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07=

+      VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c8
     =
steps:
       - name: Install dependencies
         run: sudo apt update &&=
 sudo apt install -y mingw-w64 unzip build-essential wget python3-docutils =
man2html-base
@@ -290,7 +292,7 @@
       env:
         BUILD_CONFIGURATION:=
 Release
         VCPKG_BINARY_SOURCES: clear;default,readwrite
-        VC=
PKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
+        VCPKG_=
GIT_COMMIT_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c8
 
       runs-on: w=
indows-2025-vs2026
       steps:

-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2194?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91
Gerrit-Change-N=
umber: 2194
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--LxrN/itk+fg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2194?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">GHA: Use latest NDK<br><br>Stay in sync with what buildbot uses=2E T=
he images still use<br>NDK r27 which is quite old by now=2E<br><br>While he=
re, update vcpkg reference to latest master=2E<br><br>Change-Id: Ib2849dc2c=
0a451b26fad985faf757ff22a852e91<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt;<br>---<br>M =2Egithub/workflows/build=2Eyaml<br>1 =
file changed, 7 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/94/2194/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/b=
uild=2Eyaml</span><br><span>index d50b7ff=2E=2E19c78e9 100644</span><br><sp=
an>--- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub/w=
orkflows/build=2Eyaml</span><br><span>@@ -36,14 +36,12 @@</span><br><span> =
            vcpkg_triplet: arm64-android</span><br><span>     runs-on: ubun=
tu-26=2E04</span><br><span>     name: &quot;Android - ${{ matrix=2Eabi }}&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # Github imag=
es already setup NDK with ANDROID_NDK_ROOT pointing to the root</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    # of the SDK</span><br><span>=
     env:</span><br><span>       VCPKG_DEFAULT_TRIPLET: ${{ matrix=2Evcpkg_=
triplet }}</span><br><span>       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcp=
kg</span><br><span>       VCPKG_INSTALLED_DIR: ${{ github=2Eworkspace }}/vc=
pkg/installed</span><br><span>       VCPKG_BINARY_SOURCES: clear;default,re=
adwrite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      VCPKG_GI=
T_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 8f363bdc11359e=
de4bc51e5eb32a2617538049c8</span><br><span>     steps:</span><br><span>    =
   - name: Checkout OpenVPN</span><br><span>         uses: actions/checkout=
@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>@@ -=
59,6 +57,10 @@</span><br><span>           key: android-${{ matrix=2Eabi }}-=
vcpkg-binary-cache-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>       =
    restore-keys: |</span><br><span>             android-${{ matrix=2Eabi }=
}-vcpkg-binary-cache-</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      - name: Configure NDK version</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        run: |</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+          echo &quot;ANDROID_NDK_HOME=3D$ANDROID_NDK_LATEST_HO=
ME&quot; &gt;&gt;$GITHUB_ENV</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+          echo &quot;ANDROID_NDK_ROOT=3D$ANDROID_NDK_LATEST_HOME&q=
uot; &gt;&gt;$GITHUB_ENV</span><br><span>       - name: Install dependencie=
s</span><br><span>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmo=
cka</span><br><span>       - name: configure OpenVPN with cmake</span><br><=
span>@@ -90,7 +92,7 @@</span><br><span>     env:</span><br><span>       VCP=
KG_ROOT: ${{ github=2Eworkspace }}/vcpkg</span><br><span>       VCPKG_BINAR=
Y_SOURCES: clear;default,readwrite</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc=
5fd07</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GI=
T_COMMIT_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c8</span><br><span>     =
steps:</span><br><span>       - name: Install dependencies</span><br><span>=
         run: sudo apt update &amp;&amp; sudo apt install -y mingw-w64 unzi=
p build-essential wget python3-docutils man2html-base</span><br><span>@@ -2=
90,7 +292,7 @@</span><br><span>       env:</span><br><span>         BUILD_C=
ONFIGURATION: Release</span><br><span>         VCPKG_BINARY_SOURCES: clear;=
default,readwrite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        VCPKG_GIT_COMMIT_ID: =
8f363bdc11359ede4bc51e5eb32a2617538049c8</span><br><span> </span><br><span>=
       runs-on: windows-2025-vs2026</span><br><span>       steps:</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2194?usp=3Demail">change 2194</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2194?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2194 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>

</body></html>
--LxrN/itk+fg=--


--===============6497357376772049298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6497357376772049298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6497357376772049298==--

