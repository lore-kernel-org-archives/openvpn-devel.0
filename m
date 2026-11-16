Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BB606A334
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ib7rDtEO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Wo3R2qeM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NHaT9lJq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Cd46SCqg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TfGOKL0EkW63HVjdVubpOugHxiyWXadoVCrqBULHa14=; b=Ib7rDtEORnsGsN1fVx68LVR0eI
	gfOKMJJlQZ1bJ4L+fa9zVpJA+Q7ejtk5HhQbgZisyan9Lji6sSb7YcWX0gCy4K14WJaEbG+vOIRT6
	oQ0Xl9/IGdw+VYx3CUV7EVdZsO9okomR+Jud3siBJj3mwsReZ6+vyQ8feU4YVXUR589I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSyEW-0000000017h-3K6X;
	Mon, 16 Nov 2026 15:03:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSyEV-0000000017Z-2dRD
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z9oq/liardTCbXoK8hoewt3B3b5TfD3DDhsRyq9bR84=; b=Wo3R2qeMW1FZl/CTrwUmbLatu1
 KW0lfO4x1b58On03TbyNkal702NmZNIj+7wq9SwPfC31uNSJPwRBgwTtOrQnopeJCMdBQLbdHcKXH
 fblnF+6DKiTghRDOS8mng+FDs2pBq5B5lUWqUGhAxJU4by+c+NXAXn/+2/ExwQ0DPJag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z9oq/liardTCbXoK8hoewt3B3b5TfD3DDhsRyq9bR84=; b=NHaT9lJq5o0cDIuWQztm+7ueaR
 MHr5ET5Xwm5HbpQOciOuzVXmwo1Mzbl/u/K9ZyyjfkRMolp+0fdy63982cxGBu6/opucn/bq7PkMc
 lK+nsiEBnxdciXedhy+9dI3psMnvsnkDoe4ERAdz/PdZySK4VKEjct/QW7L2ypjmp64I=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSyES-000000006rM-2myU for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:02:59 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso2959468f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 07:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794841370; x=1795446170; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z9oq/liardTCbXoK8hoewt3B3b5TfD3DDhsRyq9bR84=;
 b=Cd46SCqgGKwLnv3OjFTHAlC30y5NNUdNuMuvhOCzanfURF5XIwQHpxFIq6dbHPBaZr
 k9RZcMxAv93HoMH/JPAMm00KW6CIAC4Tt4Qs19QLUP0p/OcT4UgH4MFeJX87WvLL+Ikx
 o/FSEvrqNwipgTY8AnWG5Blw900xzd4Ifvs+aTp9gKpg2+/zMDSFTS94r3AW03QnNbEV
 Sm7JVczCbV9aDD/dZDweqrPep78LJ1QWiRjnZ1EA9qZ9eE+DUTelzhOdAMsG2JyI1Zb8
 InMZ5NyzYxgSqkjTuZvC1m6aNmzqPimNTeOfAlLiBfNPW+ktbSUunHzsowMvrAyh44Wy
 O0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841370; x=1795446170;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z9oq/liardTCbXoK8hoewt3B3b5TfD3DDhsRyq9bR84=;
 b=R6YtK1T21wlkYX+ryIKzp/Bb5Z3kR0AXE46F3gDvDGDq64iV2Px/VHmsew8QnULcPo
 EM5lKIcuQHjnB1ZUmePkgHNLPb1TgGv23VVwqKVXnpgT9fqxBzYvrfAFBQRItBL9hxbu
 CnHwwwHe1Ad22rFt+m/vFn6qCzQDf9WeDAnyAjArbneiJMINODQRWJPpR/gTaoHb5Xub
 59FElmQdmQMlAtWh/dvPmAT4mNBfT0sL7dDLTMKtVqEA4VWpi1ZXetBXpPvtrQfo4NDr
 Hlcln3xXlUM7I6C1jVVzA71jDzMfC2un6gJdLhRrs9gzmY+BcDAuljYMTMfGb8Hn0O/Q
 VABg==
X-Forwarded-Encrypted: i=1;
 AL+hErGLsxUAij0FAJWMg7ikTo14UisY8Zc9pE9T0AgOO0ffAflIBmcnTtos0IeK4jmSwYwyi8x+ePdeHnEC5Tux@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+p+Km0AGmdpd76l4zArdEsUvhoDmosk9R4o/G/PbgpDgVZm6Am
 dEeA6Tq2csOcoEZ013rLy23/9JGV65x9se+S1QCzSiGBDh32AxbNZp/PEYoLm2oakzjucJ1kDJa
 K/fhnxJKmi32SELPvRjCff8MGkZntrtYDdvp2rjM1g4KKnm9lMIHBJDZMe48wS2VULns6
X-Gm-Gg: AYBFou0Wf/HZZ6P5tAKu0MXrBVN3pykp/i9ljvLqxl0W0URr9prCO7aeGfOItPEprCL
 RLYKmQ+czlIwcxaLNH8pc8u8Sf5W9PAGz8fkMMmaj8NZfp0LyUnTg3AgW+tEP7WiyRr+brFsWHA
 aoBJ+8Rc6qF29SbK/1ev2gqzR4CInRypJKy5SjM2pzLl+ZgPMw7J5/wrqZX89XHJoSMkD6vN4YN
 rbMZQzXdY2FKzfx32JEjb2ParAtkyWImIxIX9QImrEzJkqVRZvCEiM1yryrajWlpm02H4Lf5tyw
 3pkgG1E3yPPyy/vL1NxjisrnDGmabZPxflAYPfhcrDo4MoybLfb/a97xtPVuNA8pZVHsQ6a5THb
 fTHsJh6JtPHkyUOENmUgG9WNTp6VxMdZEDWBrNwguOvHEFBVILqSMzAouSqU/QlSt6L9j84mun0
 JybwBAwRzcohF8t9/70Nv7mJTtKhKZeS3z/X38OOCNhs/f5LlK+ebaqTnSA53ExVR582NO89DIu
 aTPjSYTVsCo+Ry7UdmZXqfxPYWIR93JsLPzfIlaSHqxHw4bKHFdIjNneQE9KJcoROXQd1Fw6awo
 9XDGzouzOBOmhklPmB3rrlTP9QjFkppeBirvuDHO4k3B9bO3qewWK6vorkdeo0Fi/1OufCtxInj
 dpqDYPhJ4aHwz2MlbGJkdO0n0VB37HWu9kcD4f1vKn7vjuCCLDLRMOprryUKYKFm3xSXTF2D1DJ
 LXkRNHk0uLXnGvePg=
X-Received: by 2002:a05:600c:5852:b0:4a0:1fb9:2f51 with SMTP id
 5b1f17b1804b1-4bb55a832d4mr157260515e9.14.1794841369760; 
 Mon, 16 Nov 2026 07:02:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb56689bc2sm178263895e9.2.2026.11.16.07.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:02:49 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 15:02:48 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91
X-Gerrit-Change-Number: 2194
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2194?usp=email>
X-Gerrit-Commit: 296e167250b2320b73e405d605da0f523e17383c
In-Reply-To: <gerrit.1794832910000.Ib2849dc2c0a451b26fad985faf757ff22a852e91@gerrit.openvpn.net>
References: <gerrit.1794832910000.Ib2849dc2c0a451b26fad985faf757ff22a852e91@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMyOTEwMDAwLkliMjg0OWRjMmMwYTQ1MWIyNmZhZDk4NWZhZjc1N2ZmMjJhODUyZTkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <51161e6db2e53b485fe5be97d46df3d997049790-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSyES-000000006rM-2myU
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8078415865232801383=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8078415865232801383==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JfXOhsltdCQ="; charset=UTF-8

--JfXOhsltdCQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2194?usp=3Demail )

Change subject: GHA: Use latest NDK
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Use latest NDK=


Stay in sync with what buildbot uses=2E The images still use
NDK r27 whic=
h is quite old by now=2E

While here, update vcpkg reference to latest mast=
er=2E

Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91
Signed-off-by: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
194
Message-Id: <20261116145616=2E8110-1-gert@greenie=2Emuc=2Ede>
URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg414=
57=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =2Egi=
thub/workflows/build=2Eyaml
1 file changed, 7 insertions(+), 5 deletions(-)=





diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/bu=
ild=2Eyaml
index d50b7ff=2E=2E19c78e9 100644
--- a/=2Egithub/workflows/buil=
d=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -36,14 +36,12 @@
       =
      vcpkg_triplet: arm64-android
     runs-on: ubuntu-26=2E04
     name: =
"Android - ${{ matrix=2Eabi }}"
-    # Github images already setup NDK with=
 ANDROID_NDK_ROOT pointing to the root
-    # of the SDK
     env:
       V=
CPKG_DEFAULT_TRIPLET: ${{ matrix=2Evcpkg_triplet }}
       VCPKG_ROOT: ${{ =
github=2Eworkspace }}/vcpkg
       VCPKG_INSTALLED_DIR: ${{ github=2Eworksp=
ace }}/vcpkg/installed
       VCPKG_BINARY_SOURCES: clear;default,readwrite=

-      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
+    =
  VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c8
     steps:=

       - name: Checkout OpenVPN
         uses: actions/checkout@3d3c42e5aa=
c5ba805825da76410c181273ba90b1 # v7=2E0=2E1
@@ -59,6 +57,10 @@
           k=
ey: android-${{ matrix=2Eabi }}-vcpkg-binary-cache-${{ env=2EVCPKG_GIT_COMM=
IT_ID }}
           restore-keys: |
             android-${{ matrix=2Eabi }=
}-vcpkg-binary-cache-
+      - name: Configure NDK version
+        run: |
=
+          echo "ANDROID_NDK_HOME=3D$ANDROID_NDK_LATEST_HOME" >>$GITHUB_ENV=

+          echo "ANDROID_NDK_ROOT=3D$ANDROID_NDK_LATEST_HOME" >>$GITHUB_EN=
V
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg ins=
tall openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -90,=
7 +92,7 @@
     env:
       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg
   =
    VCPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_I=
D: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
+      VCPKG_GIT_COMMIT_ID: 8f3=
63bdc11359ede4bc51e5eb32a2617538049c8
     steps:
       - name: Install de=
pendencies
         run: sudo apt update && sudo apt install -y mingw-w64 u=
nzip build-essential wget python3-docutils man2html-base
@@ -290,7 +292,7 @=
@
       env:
         BUILD_CONFIGURATION: Release
         VCPKG_BINARY_S=
OURCES: clear;default,readwrite
-        VCPKG_GIT_COMMIT_ID: 5f96cd15fd745=
122cf27e0524606d6c1efc5fd07
+        VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4=
bc51e5eb32a2617538049c8
 
       runs-on: windows-2025-vs2026
       steps:=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2194?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib2849dc2c0a451b26f=
ad985faf757ff22a852e91
Gerrit-Change-Number: 2194
Gerrit-PatchSet: 3
Gerrit=
-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--JfXOhsltdCQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2194?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">GHA: Use latest NDK<br><br>Stay in=
 sync with what buildbot uses=2E The images still use<br>NDK r27 which is q=
uite old by now=2E<br><br>While here, update vcpkg reference to latest mast=
er=2E<br><br>Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Raz=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2194<br>Message-Id: &lt;20261116145616=2E8110-1-g=
ert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg41457=2Ehtml<br>Signed-off-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =2Egithub/workflows/build=
=2Eyaml<br>1 file changed, 7 insertions(+), 5 deletions(-)<br><br></pre>
<p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=
=2Eyaml</span><br><span>index d50b7ff=2E=2E19c78e9 100644</span><br><span>-=
-- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub/workf=
lows/build=2Eyaml</span><br><span>@@ -36,14 +36,12 @@</span><br><span>     =
        vcpkg_triplet: arm64-android</span><br><span>     runs-on: ubuntu-2=
6=2E04</span><br><span>     name: &quot;Android - ${{ matrix=2Eabi }}&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # Github images a=
lready setup NDK with ANDROID_NDK_ROOT pointing to the root</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    # of the SDK</span><br><span>    =
 env:</span><br><span>       VCPKG_DEFAULT_TRIPLET: ${{ matrix=2Evcpkg_trip=
let }}</span><br><span>       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg</=
span><br><span>       VCPKG_INSTALLED_DIR: ${{ github=2Eworkspace }}/vcpkg/=
installed</span><br><span>       VCPKG_BINARY_SOURCES: clear;default,readwr=
ite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      VCPKG_GIT_CO=
MMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4b=
c51e5eb32a2617538049c8</span><br><span>     steps:</span><br><span>       -=
 name: Checkout OpenVPN</span><br><span>         uses: actions/checkout@3d3=
c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br><span>@@ -59,6=
 +57,10 @@</span><br><span>           key: android-${{ matrix=2Eabi }}-vcpk=
g-binary-cache-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>           =
restore-keys: |</span><br><span>             android-${{ matrix=2Eabi }}-vc=
pkg-binary-cache-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    - name: Configure NDK version</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        run: |</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+          echo &quot;ANDROID_NDK_HOME=3D$ANDROID_NDK_LATEST_HOME&q=
uot; &gt;&gt;$GITHUB_ENV</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+          echo &quot;ANDROID_NDK_ROOT=3D$ANDROID_NDK_LATEST_HOME&quot;=
 &gt;&gt;$GITHUB_ENV</span><br><span>       - name: Install dependencies</s=
pan><br><span>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka<=
/span><br><span>       - name: configure OpenVPN with cmake</span><br><span=
>@@ -90,7 +92,7 @@</span><br><span>     env:</span><br><span>       VCPKG_R=
OOT: ${{ github=2Eworkspace }}/vcpkg</span><br><span>       VCPKG_BINARY_SO=
URCES: clear;default,readwrite</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd0=
7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_CO=
MMIT_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c8</span><br><span>     step=
s:</span><br><span>       - name: Install dependencies</span><br><span>    =
     run: sudo apt update &amp;&amp; sudo apt install -y mingw-w64 unzip bu=
ild-essential wget python3-docutils man2html-base</span><br><span>@@ -290,7=
 +292,7 @@</span><br><span>       env:</span><br><span>         BUILD_CONFI=
GURATION: Release</span><br><span>         VCPKG_BINARY_SOURCES: clear;defa=
ult,readwrite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        VCPKG_GIT_COMMIT_ID: 8f36=
3bdc11359ede4bc51e5eb32a2617538049c8</span><br><span> </span><br><span>    =
   runs-on: windows-2025-vs2026</span><br><span>       steps:</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2194?usp=3Demail">change 2194</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2194?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merg=
ed </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2194 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--JfXOhsltdCQ=--


--===============8078415865232801383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8078415865232801383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8078415865232801383==--

