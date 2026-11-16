Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6B606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bX3bjBzK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j9vY29cp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RG3GDUK8;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GEUjLWYT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=NNwpoOxEzUUMKu6kxJn4VYOS+GzUTzb6uzas6MrNxzE=; b=bX3bjBzKBigUD5i824FAf66BtP
	1NNybkDEacOobbqKyg3oQB6ZGJDJkUlmgM4+OI4qHvo/MKg0m14TLT0Dgl0ozjCZv4DFBw9qx+8Px
	8QkR2Hz+DspWLzGVXoT4Ly2pKFT+UI0VMSCXNox7i+tkTkgD4cTNNsqc3qfNtvXlXFRo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSw2A-000000007pr-1r8f;
	Mon, 16 Nov 2026 12:42:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSw29-000000007pl-17KF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:42:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kjXNAxSrFD5ZG0UP7sLERlIr9PeMzKgqeBvHRLmatwQ=; b=j9vY29cpbgs2G3AD6yFgnx+meo
 nUxmYgL0z/WVn4Eqg3kR3uZb1pz3Gr7aRRrdtivPkEdvzOalOFh3h8j/q4NqX43nKTNVuFCtOIWdO
 1d3e1OlnZq6toqUwQEh22805R4kViARL1g9iHDLZtG2q6noy1jvgU4+W5fJaooysYgpM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kjXNAxSrFD5ZG0UP7sLERlIr9PeMzKgqeBvHRLmatwQ=; b=RG3GDUK8tJgXzQicsD9Ry5v19i
 1vlPzCeu5LxkT666ifHIDheKwZfiYTqQfFtub5QSVRTkgjrGSBNZ7WiuAhMhd9QxE/BygZ3lobruL
 j9mwUyy+0zlNJTA9RyRz5ULEMZf/CJFirWljkKqaj3UQVp8ue/rIAB2BtwZ8SH8K2uFA=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSw25-000000006KP-1pPQ for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:42:05 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c50a4a2132cso421202766b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 04:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794832915; x=1795437715; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kjXNAxSrFD5ZG0UP7sLERlIr9PeMzKgqeBvHRLmatwQ=;
 b=GEUjLWYTIfKOgGskCHjIf1PAzW1Ausodnddp2LacbiRUvtag2zj4DQnRJnsbdFM/RV
 abLyFi1d94wgd3HO5i9ZUEZzdPY1RPfo17+gBjq0uDDW3S+UkPj2xje0fvOzPzYhUT6Z
 1FuLXgNecurklo/tbbPLgjo58XXUmKu+ZCQwWY7uFUuMCJlisD6f7fKCu0uiat0krCK6
 whBylssppOCv2lyBxBtw3+4EXZbuRe27vyqcs8Dlo8ZM12iNdGCp19fhxyMEvBuqE2Na
 VTtYTEhZbVYo3hPTXQdEK3Dfpxi3uLDoXeyFlqyEmofp4qK/m+zezFV/KxsGMdWZOKA/
 oKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794832915; x=1795437715;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kjXNAxSrFD5ZG0UP7sLERlIr9PeMzKgqeBvHRLmatwQ=;
 b=SLNHKzss+ZbXG6d7TwV4WZVOHODeGlhVKjGaigsX65nd3qMNolNL6vtjRyNgkpf86e
 bAYhcAHg/HUhEdh3Zgy7PhhadTA7+WJS1JXMyNK9dQY2EOm7l9kv6SA5M0j4Nb7He+6d
 lXiBwJ6UVnJH8dyH9yOeNnLQcs2B44b3QqnZmqmtNyKAkVoepzFQYLFujKiualsmYrTm
 Qw9MNaDE6AV0GMJYhze4B0J0nHwKG7GLatN81kcFslP3Qf3ydB2oURNWT4sHm2I+4gZB
 NwWS0TXFL9/nDnJNby5fJ8ShqswRUyoDO8XewP0AUGCN+1xMpVVlWAKVYXRqmF0WYJmK
 SOig==
X-Gm-Message-State: APuU4Z/CZQMYUBeqH7H44IlF3d/+Ui9hvJ+rEpIkNNVCqZIXVT4kGBg+
 ow4Wswy/oTe32BaLmJEGi6C4QrolHTwDa3MSKMtSJsKGkp2We3Tm8cx1J8aa11HfuiNRJkoMIWc
 RETJiAo2DUFXCf5sk38AvHwL7p/uHkRPWT3BbEMicxZLtvLulDKKP7c6k9vB4zrBLl5sRvNGqbq
 6uTt1/mg==
X-Gm-Gg: AYBFou1pA+aiAcQAmag8jRYxP45V6x6RezPnsc4a+De8Kux0/gCQVWspse0ZoOIetuy
 Tia/TG7VbX4x2nuI50i9ZZ5vSObGNQIpoPzK+zaH0pMZN2rxvdXEcV8RUWJc0HLOW4bN1DY20ou
 06eDS14a/XhhmJuf1std1SHSzP2ZYGGgNFYESqmyESW+MSb+Tj8yVsxgukXuTqR4285vmIMNEKR
 ZX3qDPTwTuI6qBOnjFsJTZvvus193vQjo9Ra9gNfS+pPQ7uqGuGsAqDxwseRRCHBbbbqIIPZfp0
 HSTxmGU5IqcHPKrepcIQsZd8ltT6qXoMVWIa/nCOdai6rMP2IMqjWHEvEIVi8WVeIzvRG499ZzP
 nqEIuxdttsPt8p9EUeZDlqGgr9U9DpdsMRB1TCenBuUy8YhPIEaLkedYyZs5qjGkZWqrwUSFnMm
 gM7jX6m6dBiQRpJpZhQQUuualGvsO1dVGrR1L9vCn3gzP7X1T5L7M93VmCfVHqiBlNrqDKeJRIN
 LuxVFXgaktPgrc1BgPR0KHpr25nwgGnpq4285/+11XmOjlq0vzgXQDSxcn1ZfnvlHTXzzv/fWgK
 AywV2CYcz33Rf1mtNgU73sfMGPp3xA5x+yR9lj5XH2CAd7AsmHmXtB8ZYFabt5l/sTEmzmRf+Zm
 +8FZFM9IGROINPPjawsfeLvzqAqX6VlIAB5Ys5Y2PwjSfTW3dT3KlU8ynKDZO7sNlaY/WzDG93s
 ry3bGSVWQrZ6eFb84=
X-Received: by 2002:a17:907:930a:b0:c40:19dc:a24d with SMTP id
 a640c23a62f3a-c5096344fa5mr792530866b.9.1794832914304; 
 Mon, 16 Nov 2026 04:41:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b58ec6sm406272966b.52.2026.11.16.04.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:41:54 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 12:41:53 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91
X-Gerrit-Change-Number: 2194
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2194?usp=email>
X-Gerrit-Commit: 37d94a16141f5849b2e545ab9f96aa5b47490478
References: <gerrit.1794832910000.Ib2849dc2c0a451b26fad985faf757ff22a852e91@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMyOTEwMDAwLkliMjg0OWRjMmMwYTQ1MWIyNmZhZDk4NWZhZjc1N2ZmMjJhODUyZTkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2e96a4c62b944c79b389e3c3443e1c4b5ea7bcd5-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSw25-000000006KP-1pPQ
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
Content-Type: multipart/mixed; boundary="===============2123608141314805650=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2123608141314805650==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TBjk5F5Hg7Y="; charset=UTF-8

--TBjk5F5Hg7Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2194?usp=3Demail

to review the following change=2E
=


Change subject: GHA: Use latest NDK
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Use latest NDK

Stay in sync with what build=
bot uses=2E The images still use
NDK r27 which is quite old by now=2E

Whil=
e here, update vcpkg reference to latest master=2E

Change-Id: Ib2849dc2c0a=
451b26fad985faf757ff22a852e91
Signed-off-by: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
---
M =2Egithub/workflows/build=2Eyaml
1 file changed, 6 inse=
rtions(+), 4 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/94/2194/1

diff --git a/=2Egithub/workflows/build=2Eya=
ml b/=2Egithub/workflows/build=2Eyaml
index d50b7ff=2E=2Ecbe5a1b 100644
---=
 a/=2Egithub/workflows/build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
=
@@ -36,14 +36,12 @@
             vcpkg_triplet: arm64-android
     runs-on:=
 ubuntu-26=2E04
     name: "Android - ${{ matrix=2Eabi }}"
-    # Github im=
ages already setup NDK with ANDROID_NDK_ROOT pointing to the root
-    # of=
 the SDK
     env:
       VCPKG_DEFAULT_TRIPLET: ${{ matrix=2Evcpkg_triplet=
 }}
       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg
       VCPKG_INSTALL=
ED_DIR: ${{ github=2Eworkspace }}/vcpkg/installed
       VCPKG_BINARY_SOURC=
ES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf2=
7e0524606d6c1efc5fd07
+      VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4bc51e5eb=
32a2617538049c8
     steps:
       - name: Checkout OpenVPN
         uses: =
actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
@@ -=
59,6 +57,10 @@
           key: android-${{ matrix=2Eabi }}-vcpkg-binary-cac=
he-${{ env=2EVCPKG_GIT_COMMIT_ID }}
           restore-keys: |
            =
 android-${{ matrix=2Eabi }}-vcpkg-binary-cache-
+      - name: Configure N=
DK version
+        run: |
+          echo "ANDROID_NDK_HOME=3D$ANDROID_NDK=
_LATEST_HOME" >>$GITHUB_ENV
+          echo "ANDROID_NDK_ROOT=3D$ANDROID_ND=
K_LATEST_HOME" >>$GITHUB_ENV
       - name: Install dependencies
         r=
un: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure=
 OpenVPN with cmake
@@ -90,7 +92,7 @@
     env:
       VCPKG_ROOT: ${{ gith=
ub=2Eworkspace }}/vcpkg
       VCPKG_BINARY_SOURCES: clear;default,readwrit=
e
-      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
+   =
   VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c8
     steps=
:
       - name: Install dependencies
         run: sudo apt update && sudo=
 apt install -y mingw-w64 unzip build-essential wget python3-docutils man2h=
tml-base

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/219=
4?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchan=
ge
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib2849dc=
2c0a451b26fad985faf757ff22a852e91
Gerrit-Change-Number: 2194
Gerrit-PatchSe=
t: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>

--TBjk5F5Hg7Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2194?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">GHA: Use latest NDK<br><br>Stay in sync with what buildbot=
 uses=2E The images still use<br>NDK r27 which is quite old by now=2E<br><b=
r>While here, update vcpkg reference to latest master=2E<br><br>Change-Id: =
Ib2849dc2c0a451b26fad985faf757ff22a852e91<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M =2Egithub/workflows/build=2E=
yaml<br>1 file changed, 6 insertions(+), 4 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/94=
/2194/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/w=
orkflows/build=2Eyaml</span><br><span>index d50b7ff=2E=2Ecbe5a1b 100644</sp=
an><br><span>--- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=
=2Egithub/workflows/build=2Eyaml</span><br><span>@@ -36,14 +36,12 @@</span>=
<br><span>             vcpkg_triplet: arm64-android</span><br><span>     ru=
ns-on: ubuntu-26=2E04</span><br><span>     name: &quot;Android - ${{ matrix=
=2Eabi }}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # =
Github images already setup NDK with ANDROID_NDK_ROOT pointing to the root<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # of the SDK</span=
><br><span>     env:</span><br><span>       VCPKG_DEFAULT_TRIPLET: ${{ matr=
ix=2Evcpkg_triplet }}</span><br><span>       VCPKG_ROOT: ${{ github=2Eworks=
pace }}/vcpkg</span><br><span>       VCPKG_INSTALLED_DIR: ${{ github=2Ework=
space }}/vcpkg/installed</span><br><span>       VCPKG_BINARY_SOURCES: clear=
;default,readwrite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 8f3=
63bdc11359ede4bc51e5eb32a2617538049c8</span><br><span>     steps:</span><br=
><span>       - name: Checkout OpenVPN</span><br><span>         uses: actio=
ns/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1</span><br=
><span>@@ -59,6 +57,10 @@</span><br><span>           key: android-${{ matri=
x=2Eabi }}-vcpkg-binary-cache-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><s=
pan>           restore-keys: |</span><br><span>             android-${{ mat=
rix=2Eabi }}-vcpkg-binary-cache-</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      - name: Configure NDK version</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        run: |</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+          echo &quot;ANDROID_NDK_HOME=3D$ANDROID_ND=
K_LATEST_HOME&quot; &gt;&gt;$GITHUB_ENV</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+          echo &quot;ANDROID_NDK_ROOT=3D$ANDROID_NDK_LA=
TEST_HOME&quot; &gt;&gt;$GITHUB_ENV</span><br><span>       - name: Install =
dependencies</span><br><span>         run: ${VCPKG_ROOT}/vcpkg install open=
ssl lz4 cmocka</span><br><span>       - name: configure OpenVPN with cmake<=
/span><br><span>@@ -90,7 +92,7 @@</span><br><span>     env:</span><br><span=
>       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg</span><br><span>       =
VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e052=
4606d6c1efc5fd07</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c8</span><br>=
<span>     steps:</span><br><span>       - name: Install dependencies</span=
><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y min=
gw-w64 unzip build-essential wget python3-docutils man2html-base</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2194?usp=3Demail">change 2194</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2194?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2194 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>

</body></html>
--TBjk5F5Hg7Y=--


--===============2123608141314805650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2123608141314805650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2123608141314805650==--

