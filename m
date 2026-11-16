Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E6606A881
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Vl6Wxkta;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G5aTG7LT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Q9o7nZiI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DeAWS1tb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3bVpzQup7sr907mgrM3TjNwld6b7Im0aKkKKLFDX74U=; b=Vl6WxktaSDZHri5oMN0f67cviA
	2P1Ol6sT5dZJGdg12jil0DOH6fwIoFrM64FzY1+7zYM1K35bBxSEb+c+aQR7EFdq0EuoB6tmv6hl1
	Ct36czM6+WJLC/vYolIX1/Qb/mapt9VYhdwfTx7jCttE3xwg7lnyc+Mn/e0styeewR0s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSyEU-0000000053E-2uX2;
	Mon, 16 Nov 2026 15:02:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSyET-00000000538-0Rl9
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:02:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FK8Gzl4wEOvD6exhhtUdTv+m5d7oc+Xy6n7tgAbHX5M=; b=G5aTG7LT+GPjzrvPvxdJKwemVC
 PXH4N7c8cAuwChxvkyopvMnioZKFAtKyV1aZV64vHoDinrPCAz+4E5867D611Lw4lTzb2hGOPT0OK
 Hfw2KqSVjbrozPcCFWr9c1DV/JiRktoRzk6bNGaKV2/WE7uz72+oT0DKfFYj8tHbC+SY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FK8Gzl4wEOvD6exhhtUdTv+m5d7oc+Xy6n7tgAbHX5M=; b=Q9o7nZiI8Di7FCUWQx2wDP3MW0
 1qjrirQg1GS5lJJBiSnZtiRVnmEm4Y2FWKCXXblBtlIB+22EinApWdtswePHdPHt7M1AE7Vi1YvlS
 uM022C62gdNIXneIml24y3+oOmEWu9UtyNF/VjpysUuIIBj8oTFBpYTXBeIehj9/OmSo=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSyER-000000006rJ-2RSm for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:02:57 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so19625825e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 07:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794841369; x=1795446169; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FK8Gzl4wEOvD6exhhtUdTv+m5d7oc+Xy6n7tgAbHX5M=;
 b=DeAWS1tb9jJvrWFTmZxqr5IsI/ggjpoVoQU1u1Uw5e07gyhqkIQ/5kZ7z+grwuxLf7
 D6ItlFK9mxVUNUAiSbwiHxvaBlX0sOUjPHIu3GUaZPe+qQW/ZpncpuNeVSQJkYxqXqbt
 xR/k/tDWc3ZIV2wzk3Av41YoNM/VSWNg8izKhqLEw7AJZflKl/to1u+9bTttr7qw3erT
 6rA/D9kEBurhdmkX3F47ml3rn4mRkhyJdcA7bnLILSEZ9BKK24qz2YqCGkQcjCs3UANi
 LAYD5vs4YtjA5c+ftP0m5sxfm4ILfRCZfxKNCaSGxDWMKZQy1irMO9JrfNNmeUIueML/
 VEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841369; x=1795446169;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FK8Gzl4wEOvD6exhhtUdTv+m5d7oc+Xy6n7tgAbHX5M=;
 b=av8tjNWXBxHd7tIE1AwjA8zg8vMEXlHL8MDOwv5SKSkDC47+rEF3oMG3kdN0/DLyhT
 27PVHG0gtHvv+lGjb2nWLW1LWwihNlLca6h0WONGKBJeSB7A0lwV3KN8VgcxjqpoeMaA
 f86rX1DkJjfFGYLukOyLo11ogFLZb/BtCOiG1XQrHu2to+1UnOHQRLTfoOsXD3jPi8lr
 9rV5sUTlaWJheuBaOa7qNOO27dH+x3p5In4D3U+tNmh9otaSTIglNhPT42yrimlMhZ8Q
 py0nUa7bts+PIuhr43bq6dJvym4pxTn7GZ6gROUbRpPNlbfa9DNLKMFPlRkm2yEI/YZM
 dk7A==
X-Gm-Message-State: APuU4Z9tb6gjzTXJUiqtMXFa9+3Qq+LLyc7NQtVrYUZgRfkbX2Dt/cuv
 idflDzhC4qLWAuxF5zDWVlf38Ti7A0ZUEhSONH+VNwln5udiOwy0GxyNdgHiHsLuKg18osIOnIK
 GtMa+IA/qiUv+WDJKxPkzdkTkwFyJO/Gwy1dXYU58T2RdzUUa72+QR8XVcbWQgIwLKrun
X-Gm-Gg: AYBFou3kiLlQwf3fSDIB+603YCWNAR7apRCYBb5IbitAHm4WCnmQMK6Ec18PniIKvvE
 wVyZi4unlqCl6uD86Pwpve7PBX84lGaR9EqiDIVPNjeikcaLmVWZOEnZ9pUK6eyzPQ1u0jcrMhv
 HjEBgAw8gz+QPe5KP7fkgABpc6Q3Qwt0T/S0Zb+kRoe87wZ0ctgNOYuv9HsKGPsAQqBRWQPxmcZ
 jCbh4qjNBY9MaKRC30h1fH9zs7qoXhDe0Hzo5GKpDzPi5ANp9cGnCh6U1fw6aP6qEeXaBtANyKw
 rCuAel6sFGU5Y4LujUvMSyGziQBMONeH1ElKO0hKI9JMJgiJVdmTlHTHcJ2REmE7lP6swAriS+5
 3B/5K/8s2+UQEOS6XEGqF3pAQgU5Gukc2HfMWr791L6waz7AJix0PcbU96yVsvPw1Yd7oJhfxkn
 NZghGXa10JvM9i0XHmzHd5ifoAHmzEmXe9Cxs9eIDDo4GRvsceSlzPb5BXdH4YMnaD2RQlQw+DV
 mg6USHX4ixQt58L/r1YaK3XV4Oj3+oDsEAcZ3sTVkkEj4z6GfLRHq5mBEvx+D01C3pJkDLXaWok
 XXs0VuGlk1X+qeYXoH1m9HpHT3uqSOsS8T5rIAOD/5YUM9YHKntjI0Xu3ZPXnxLazWQPoMxXiOq
 s0aaYTSybZQ4fzwDO4hucNekJAgwkERdC3TOEMdngw1gRf9APe1lhYFcH/6304l9HF5NI7sAe30
 E2Ok80H95pNvK9SKxEIH+VRomq9/0ahzgIrDtk
X-Received: by 2002:a05:600c:8709:b0:4bb:73ad:c1f0 with SMTP id
 5b1f17b1804b1-4bb73ade318mr52848355e9.23.1794841368747; 
 Mon, 16 Nov 2026 07:02:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb77a463cfsm8054345e9.1.2026.11.16.07.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:02:47 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 15:02:46 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91
X-Gerrit-Change-Number: 2194
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2194?usp=email>
X-Gerrit-Commit: 296e167250b2320b73e405d605da0f523e17383c
In-Reply-To: <gerrit.1794832910000.Ib2849dc2c0a451b26fad985faf757ff22a852e91@gerrit.openvpn.net>
References: <gerrit.1794832910000.Ib2849dc2c0a451b26fad985faf757ff22a852e91@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMyOTEwMDAwLkliMjg0OWRjMmMwYTQ1MWIyNmZhZDk4NWZhZjc1N2ZmMjJhODUyZTkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <51161e6db2e53b485fe5be97d46df3d997049790-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSyER-000000006rJ-2RSm
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1663288426342573237=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1663288426342573237==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WmR6psZfbH4="; charset=UTF-8

--WmR6psZfbH4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
194?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: GHA: Use latest NDK
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Use late=
st NDK

Stay in sync with what buildbot uses=2E The images still use
NDK r2=
7 which is quite old by now=2E

While here, update vcpkg reference to lates=
t master=2E

Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91
Signed-of=
f-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2194
Message-Id: <20261116145616=2E8110-1-gert@greenie=2Emuc=2Ede>
URL=
: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/=
msg41457=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M=
 =2Egithub/workflows/build=2Eyaml
1 file changed, 7 insertions(+), 5 deleti=
ons(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/94/2194/3

diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workf=
lows/build=2Eyaml
index d50b7ff=2E=2E19c78e9 100644
--- a/=2Egithub/workflo=
ws/build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -36,14 +36,12 @@
=
             vcpkg_triplet: arm64-android
     runs-on: ubuntu-26=2E04
    =
 name: "Android - ${{ matrix=2Eabi }}"
-    # Github images already setup N=
DK with ANDROID_NDK_ROOT pointing to the root
-    # of the SDK
     env:
 =
      VCPKG_DEFAULT_TRIPLET: ${{ matrix=2Evcpkg_triplet }}
       VCPKG_ROO=
T: ${{ github=2Eworkspace }}/vcpkg
       VCPKG_INSTALLED_DIR: ${{ github=
=2Eworkspace }}/vcpkg/installed
       VCPKG_BINARY_SOURCES: clear;default,=
readwrite
-      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5f=
d07
+      VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c8
  =
   steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@3=
d3c42e5aac5ba805825da76410c181273ba90b1 # v7=2E0=2E1
@@ -59,6 +57,10 @@
   =
        key: android-${{ matrix=2Eabi }}-vcpkg-binary-cache-${{ env=2EVCPKG=
_GIT_COMMIT_ID }}
           restore-keys: |
             android-${{ matri=
x=2Eabi }}-vcpkg-binary-cache-
+      - name: Configure NDK version
+      =
  run: |
+          echo "ANDROID_NDK_HOME=3D$ANDROID_NDK_LATEST_HOME" >>$G=
ITHUB_ENV
+          echo "ANDROID_NDK_ROOT=3D$ANDROID_NDK_LATEST_HOME" >>$=
GITHUB_ENV
       - name: Install dependencies
         run: ${VCPKG_ROOT}/=
vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmak=
e
@@ -90,7 +92,7 @@
     env:
       VCPKG_ROOT: ${{ github=2Eworkspace }}/=
vcpkg
       VCPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT=
_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
+      VCPKG_GIT_COMMI=
T_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c8
     steps:
       - name: I=
nstall dependencies
         run: sudo apt update && sudo apt install -y mi=
ngw-w64 unzip build-essential wget python3-docutils man2html-base
@@ -290,7=
 +292,7 @@
       env:
         BUILD_CONFIGURATION: Release
         VCPKG=
_BINARY_SOURCES: clear;default,readwrite
-        VCPKG_GIT_COMMIT_ID: 5f96=
cd15fd745122cf27e0524606d6c1efc5fd07
+        VCPKG_GIT_COMMIT_ID: 8f363bdc=
11359ede4bc51e5eb32a2617538049c8
 
       runs-on: windows-2025-vs2026
    =
   steps:

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
94?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib284=
9dc2c0a451b26fad985faf757ff22a852e91
Gerrit-Change-Number: 2194
Gerrit-Patc=
hSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--WmR6psZfbH4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2194?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">GHA: Use latest NDK<br><br>Stay in sync with what buildbot uses=2E The =
images still use<br>NDK r27 which is quite old by now=2E<br><br>While here,=
 update vcpkg reference to latest master=2E<br><br>Change-Id: Ib2849dc2c0a4=
51b26fad985faf757ff22a852e91<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2194<br>Mes=
sage-Id: &lt;20261116145616=2E8110-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4=
1457=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M =2Egithub/workflows/build=2Eyaml<br>1 file changed, 7 insertion=
s(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/94/2194/3</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=2Egit=
hub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml</span><br><sp=
an>index d50b7ff=2E=2E19c78e9 100644</span><br><span>--- a/=2Egithub/workfl=
ows/build=2Eyaml</span><br><span>+++ b/=2Egithub/workflows/build=2Eyaml</sp=
an><br><span>@@ -36,14 +36,12 @@</span><br><span>             vcpkg_triplet=
: arm64-android</span><br><span>     runs-on: ubuntu-26=2E04</span><br><spa=
n>     name: &quot;Android - ${{ matrix=2Eabi }}&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    # Github images already setup NDK with=
 ANDROID_NDK_ROOT pointing to the root</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    # of the SDK</span><br><span>     env:</span><br><span=
>       VCPKG_DEFAULT_TRIPLET: ${{ matrix=2Evcpkg_triplet }}</span><br><spa=
n>       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg</span><br><span>      =
 VCPKG_INSTALLED_DIR: ${{ github=2Eworkspace }}/vcpkg/installed</span><br><=
span>       VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      VCPKG_GIT_COMMIT_ID: 5f96cd15fd74=
5122cf27e0524606d6c1efc5fd07</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c=
8</span><br><span>     steps:</span><br><span>       - name: Checkout OpenV=
PN</span><br><span>         uses: actions/checkout@3d3c42e5aac5ba805825da76=
410c181273ba90b1 # v7=2E0=2E1</span><br><span>@@ -59,6 +57,10 @@</span><br>=
<span>           key: android-${{ matrix=2Eabi }}-vcpkg-binary-cache-${{ en=
v=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>           restore-keys: |</span=
><br><span>             android-${{ matrix=2Eabi }}-vcpkg-binary-cache-</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Configure=
 NDK version</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 run: |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ec=
ho &quot;ANDROID_NDK_HOME=3D$ANDROID_NDK_LATEST_HOME&quot; &gt;&gt;$GITHUB_=
ENV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          echo &=
quot;ANDROID_NDK_ROOT=3D$ANDROID_NDK_LATEST_HOME&quot; &gt;&gt;$GITHUB_ENV<=
/span><br><span>       - name: Install dependencies</span><br><span>       =
  run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</span><br><span>     =
  - name: configure OpenVPN with cmake</span><br><span>@@ -90,7 +92,7 @@</s=
pan><br><span>     env:</span><br><span>       VCPKG_ROOT: ${{ github=2Ewor=
kspace }}/vcpkg</span><br><span>       VCPKG_BINARY_SOURCES: clear;default,=
readwrite</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      VCPKG_=
GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 8f363bdc1135=
9ede4bc51e5eb32a2617538049c8</span><br><span>     steps:</span><br><span>  =
     - name: Install dependencies</span><br><span>         run: sudo apt up=
date &amp;&amp; sudo apt install -y mingw-w64 unzip build-essential wget py=
thon3-docutils man2html-base</span><br><span>@@ -290,7 +292,7 @@</span><br>=
<span>       env:</span><br><span>         BUILD_CONFIGURATION: Release</sp=
an><br><span>         VCPKG_BINARY_SOURCES: clear;default,readwrite</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        VCPKG_GIT_COMMIT_ID: =
5f96cd15fd745122cf27e0524606d6c1efc5fd07</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4bc51e5eb=
32a2617538049c8</span><br><span> </span><br><span>       runs-on: windows-2=
025-vs2026</span><br><span>       steps:</span><br></pre><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2194?usp=3Demail">cha=
nge 2194</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2194=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2194 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--WmR6psZfbH4=--


--===============1663288426342573237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1663288426342573237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1663288426342573237==--

