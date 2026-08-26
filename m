Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAA0C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=++H2cIBl7ym5/TLGajKjixqZAnDrQF4mDOiSNDtmXHw=; b=V1gz9ItR1E3nnG0LIHFd3liF1B
	qGF5Jb1WCslQuw2bbAdsRd7xb7a1TTtWLFcTf/usLcV4SZZr1JNHQ31XwcYjKhaVE1FAlqrSIQ9H8
	W0hhjxtXueEJJfnlnvKaJ0Jdwc5G3qc9B+p3NxeqCjSq4OTsbQZ/TP64XQ3Sp77MltUE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz79m-00074I-QX;
	Wed, 26 Aug 2026 06:30:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz79l-000740-2U
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gsL1NoEvLEQ4Gy8oIJ6yTCeYCxOgSlueNcZyrCOl+R0=; b=gnpV7axxTtOGPOho95C8vM8AQO
 NpJPh6a6rUfs1hP9ptRDV3tW4O+29kuwjXutwTJbGrFd9ebSOmsfcpZvJbhv09vYhVjsjV6Av5n4H
 jGQkcBnDJWBCI0XowAVVzlKE7A98YzhT0ioFF42Hi10fbp/EPXoUhG5iGv0zV56OnyG0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gsL1NoEvLEQ4Gy8oIJ6yTCeYCxOgSlueNcZyrCOl+R0=; b=m
 mHcgkn1rCaUHNHiZlc8is4cLxHuRULiSab4Y0ZNjuEoo+5pEMIXB/QMDOQnPAZr75d+Zewe4b4Hqm
 QysrF+pcUNlnJe1JRFdBTiQRmxDwvCCP9Wjf6N8SQVsWxA6xxHtr7Cel2sgfqX8EQEm1V+HoO1IyZ
 PBw2QohRuIhKiYwQ=;
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz79i-0007B8-Ir for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:30:41 +0000
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c15c42a45adso247863866b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787725832; x=1788330632; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gsL1NoEvLEQ4Gy8oIJ6yTCeYCxOgSlueNcZyrCOl+R0=;
 b=DZADZZXhL+PjkXU49/OXUq9uFtsTNzA0bm1kWl1EwBGQCnJF80Zq70k2B8zE4h0VTb
 0OIlHeyAYuLMIx4KNEbWJvNPkxLr+fKLK6H9zQdlltKKhaUBGKxh6F92WNMFlXqQDA9j
 +fTry8ostM+Jiin68qz5cwY7WMgUgDKkdqVhQjh3Lgedoz3t9bMcTNgf06XQSSiUXO/8
 j9SWNRpldcy5eIhBBaJE5uBiKRm+ggQz0kUepvSMQLGhn78rjhMC13bA1jbBk5MuTczG
 B2Ewx/tEsXEE7eZQXUgpFkl7mgA5amiQMHMVori+yCmGIMAaee3GKqWQPai51fDneVjr
 KhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787725832; x=1788330632;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gsL1NoEvLEQ4Gy8oIJ6yTCeYCxOgSlueNcZyrCOl+R0=;
 b=f+TSm5M1YL+0JLB8yoHz9Q42OcTvzvk+sdqjfapp+86CfYl+PBO6fkq5P0TbrRxt2G
 fb/uwww5rSB6rBSDfhT+RA1JyW4BKKa0lSlSYSadkER1pmjsYdbwu7321RG+zxxXlMlT
 TO48BVX/E3ui2LZMNW5Rk/beLWrRe2aZd9GwvjGbzSe5Bd/1vWKNxSk/1QPTx4AbOk9q
 81dJMaTxjz0z9E4493wsPbuad7kbrT8B6qLsStcLq2nE0nNy+ctARGRaPcgKLanTRDBA
 rXl5CzPWaNJHDt77744mbhFsaRf1G/oWtVg1SythUze0zwUT6wl2jvBUug2tyYzrP9nJ
 f5Fw==
X-Gm-Message-State: AFuF++k8ncPCTFTVvAZnpkhhH2RSPJhOxDEZKkFodKRBoDAvws719iwo
 OfuFx5SS1yl/mtu3ZVp29zXK5v9IcBIiRWpYMCyGS/KZo2sIG0D6Zh8nGehBLtmTDJKmtGQwj/O
 CbIbsfolzYbzOn1d+wNhY/wFOYKVHofyzleDxJhWzr58jqGF4n3KONMMzrAbJXM/Ggm+B
X-Gm-Gg: AR+sD11qU8keKUGahq8hYdvvHRVKD1CoLRZWcI1wJV4+j0TD0kcuUcIOfCN+PpfkgFF
 RTRDgWMAqOElZk+zwpfmLuxfiIaeMGd9jVnRoGQP2DuQJfC0JeTy2P/QXu+eAI036Pp3N0CixH3
 tigHOPBg7yuC9+AEnwdwCRt3oRoztSllfksiDCnYY54BtgkC5cT+pn0K6tR2NbmM/JaWCx7WVGI
 GdX0qo79rSL39ABRmNMSzEe08M0A2FPikKltES3AdEanGZU6uBsuOnIFEYMUBlH8NXF6BrDQnb7
 COnpz/2jxHLUNFITDvWvm40mPHyFQkL+H3Zvs1y3TE72Ng52epwxJBrGcnxMj2Po+PnMP+2H6DM
 IEuTwa++Hgw+463N3/3qEt4q91aWXt+btlNDhyrDG5YlpKp4XoZvARzcMO8PtLQ6wvkTJC0mT/O
 CpxQA0JzxMLfVbNR2ZtPPBs18e4F6Mw1GxVTb1RW8Dmr7qSpEubfI1qc63HPkmguAvtgtcm1fTs
 V+oeSceEomklYFL/pymJdgkgaweCOyn/r+BY5MPnWW4KS0yWE8BhIXvuTuNtVXX4B2LIhaI91z9
 ZQzyk4Og2TkOWJId5845tHZ3im756hvgutzFGKccBjTc/Kcu50xC
X-Received: by 2002:a17:907:9d1a:b0:c20:367d:f8b8 with SMTP id
 a640c23a62f3a-c24e2ae5e0emr1376792866b.4.1787725831471; 
 Tue, 25 Aug 2026 23:30:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9ef4d2sm247381066b.59.2026.08.25.23.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 23:30:31 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 06:30:29 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id56fbfa4767346995eaa05ac95c7a20fbba99b2d
X-Gerrit-Change-Number: 1869
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1869?usp=email>
X-Gerrit-Commit: 172b15c2cf526c2c901739ab5f1f4271b27adbe6
In-Reply-To: <gerrit.1787672720000.Id56fbfa4767346995eaa05ac95c7a20fbba99b2d@gerrit.openvpn.net>
References: <gerrit.1787672720000.Id56fbfa4767346995eaa05ac95c7a20fbba99b2d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLklkNTZmYmZhNDc2NzM0Njk5NWVhYTA1YWM5NWM3YTIwZmJiYTk5YjJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ed6f7811fc08a621400142b35af6243fef689148-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz79i-0007B8-Ir
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make cppcheck run
 pass on top of current master
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
Content-Type: multipart/mixed; boundary="===============5358216733743087746=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5358216733743087746==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kEMctwP6bzA="; charset=UTF-8

--kEMctwP6bzA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: Make cppcheck run pass on top of current master
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make cppcheck=
 run pass on top of current master

* Update cppcheck-suppressions to be in=
 sync with
  current code
* Suppress some additional findings that we have
=
  patches for in the queue but which are not merged,
  yet
* Add some addit=
ional fixes for categories we had
  fixed but for which new occurences crep=
t in

The goal is to have one commit that allows us to
enable a cppcheck ru=
n in buildbot to keep it
up to date going forward=2E

Change-Id: Id56fbfa47=
67346995eaa05ac95c7a20fbba99b2d
Signed-off-by: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1869
Message-Id: <202608251549=
32=2E4586-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg38677=2Ehtml
Signed-off-by: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppression
M s=
rc/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi_io=2Ec
M sr=
c/openvpn/openvpn=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M tests/unit_tests/open=
vpn/test_pkt=2Ec
7 files changed, 42 insertions(+), 23 deletions(-)


  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/1869/2

di=
ff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
=
index 900e03c=2E=2Ea585513 100644
--- a/dev-tools/cppcheck-suppression
+++ =
b/dev-tools/cppcheck-suppression
@@ -5,6 +5,10 @@
 constParameterPointer
 i=
nvalidPrintfArgType_sint
 invalidPrintfArgType_uint
+redundantAssignment
+r=
edundantInitialization
+unreadVariable
+unusedFunction
 usleepCalled
 varia=
bleScope
 # We have a lot of library includes, not all of them are really r=
equired,
@@ -24,15 +28,21 @@
 localtimeCalled
 strtokCalled
 # FP: posix=2E=
cfg claims suseconds_t is unsigned for some reason
-unsignedLessThanZero:sr=
c/openvpn/otime=2Eh:235
+unsignedLessThanZero:src/openvpn/otime=2Eh:148
 # =
IGN: multi code does weird things with pointers to local variables=2E=2E=2E=

-autoVariables:src/openvpn/multi=2Ec:4177
-autoVariables:src/openvpn/multi=
_io=2Ec:280
+autoVariables:src/openvpn/multi=2Ec:4232
+autoVariables:src/op=
envpn/multi_io=2Ec:324
 # IGN: the code header =3D 0 | (OPCODE << P_OPCODE_=
SHIFT) is used intentionally
 badBitmaskCheck:src/openvpn/mudp=2Ec
 badBitm=
askCheck:tests/unit_tests/openvpn/test_pkt=2Ec
 # IGN: we store integers in=
 pointers
 CastAddressToIntegerAtReturn:src/openvpn/multi=2Ec
+# IGN: Windo=
ws specific (unsigned long =3D=3D unsigned int)
+compareValueOutOfTypeRange=
Error:src/openvpn/ssl_verify=2Ec:928
+# FP: cppcheck seems to have wrong si=
gnature of DeviceIoControl()
+constVariablePointer:src/openvpn/dco_win=2Ec
=
+# IGN: test_networking code would break with iproute2 but that is prevente=
d
+ctunullpointer:src/openvpn/networking_iproute2=2Ec
 # IGN: event code us=
es a pointer to store integers
 intToPointerCast:src/openvpn/forward=2Ec
 i=
ntToPointerCast:src/openvpn/multi_io=2Ec
@@ -40,7 +50,7 @@
 # FP: constant =
but differs between platforms
 knownConditionTrueFalse:src/openvpn/error=2E=
h:380
 knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:80
-knownConditionTru=
eFalse:src/openvpn/lladdr=2Ec:65
+knownConditionTrueFalse:src/openvpn/lladd=
r=2Ec:64
 knownConditionTrueFalse:src/openvpn/platform=2Ec
 # FP: code need=
s to accomodate many different defines
 knownConditionTrueFalse:src/openvpn=
/event=2Ec:1139
@@ -48,13 +58,13 @@
 # FP: dco_win support has "false" stub=
s
 knownConditionTrueFalse:src/openvpn/forward=2Ec
 knownConditionTrueFalse=
:src/openvpn/init=2Ec
-knownConditionTrueFalse:src/openvpn/multi_io=2Ec:163=

+knownConditionTrueFalse:src/openvpn/multi_io=2Ec:197
 # FP: cppcheck thin=
ks that some functions always return true, but they don't
 knownConditionTr=
ueFalse:src/openvpn/misc=2Ec:97
 knownConditionTrueFalse:src/openvpn/sig=2E=
h:116
 # FP: cert_uri_supported is a wrapper around defines, so it's
 # alw=
ays constant but differs depending on OpenSSL version
-knownConditionTrueFa=
lse:src/openvpn/ssl_openssl=2Ec:1332
+knownConditionTrueFalse:src/openvpn/s=
sl_openssl=2Ec:1260
 # FP: cppcheck doesn't understand that the function ch=
anges szErrMessage
 knownConditionTrueFalse:src/tapctl/main=2Ec:704
 knownC=
onditionTrueFalse:src/openvpnmsica/dllmain=2Ec:164
@@ -65,12 +75,18 @@
 # F=
P: eventmsg=2Eh is not built on Unix
 missingInclude:src/openvpnserv/common=
=2Ec:25
 # IGN: strlen(NULL) is not nice code, but seems to work
-nullPoint=
erRedundantCheck:src/openvpn/init=2Ec:299
+nullPointerRedundantCheck:src/op=
envpn/init=2Ec:301
 # FP: cppcheck doesn't understand ZeroMemory
 redundant=
Assignment:src/openvpnserv/interactive=2Ec:203
+# FP: cppcheck doesn't know=
 the NLA macros
+redundantInitialization:src/openvpn/dco_linux=2Ec
 # IGN: =
We reuse the same variable name due to macro usage
-shadowVariable:src/open=
vpn/options=2Ec:2580
-shadowVariable:src/openvpn/options=2Ec:2598
+shadowVa=
riable:src/openvpn/options=2Ec:1948
+shadowVariable:src/openvpn/options=2Ec=
:1966
+# IGN: sure this is theoretically undefined, but works
+shiftNegativ=
eLHS:tests/unit_tests/openvpn/test_schedule=2Ec:183
+# FP: fun:tls_crypt_v2=
_wrap_unwrap_invalid: cppcheck is confused
+syntaxError:tests/unit_tests/op=
envpn/test_tls_crypt=2Ec:684
 # FP: this file is never compiled on _WIN32
 =
umaskCalled:tests/unit_tests/openvpn/test_pkcs11=2Ec
 # FP: yes, t_prev is =
unitialized, but t_prev_len is 0, so that's handled
@@ -78,13 +94,13 @@
 # =
FP: yes, parm is unitialized, but parm_len is 0, so that's handled
 uninitv=
ar:src/openvpn/options_parse=2Ec:148
 # FP: uninit is fine when it is a ret=
urn parameter
-ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:698
-unin=
itvar:src/openvpnserv/interactive=2Ec:1935
+ctuuninitvar:src/openvpn/crypto=
_mbedtls_legacy=2Ec:690
+uninitvar:src/openvpnserv/interactive=2Ec:2775
 un=
initvar:src/tapctl/main=2Ec:566
 # FP: we added a check but cppcheck is not=
 convinced
 uninitvar:src/openvpnserv/interactive=2Ec:2667
 # FP: weird par=
se error, the macro is fine in the rest of the file
-unknownMacro:src/openv=
pnserv/interactive=2Ec:3488
+unknownMacro:src/openvpnserv/interactive=2Ec:3=
596
 # FP: cppcheck doesn't account for short-circuiting
 unreadVariable:sr=
c/openvpn/manage=2Ec:682
 unusedFunction:src/openvpn/siphash_reference=2Ec
=
@@ -101,8 +117,10 @@
 # FP: doesn't account for --wrap
 unusedFunction:test=
s/unit_tests/openvpn/test_tls_crypt=2Ec
 unusedFunction:/usr/include/*
+# F=
P: cppcheck doesn't know the NLA macros
+unusedLabel:src/openvpn/dco_linux=
=2Ec
 # IGN: old code that is difficult to test (MSG_ERRQUEUE), ignore for =
now
-unusedStructMember:src/openvpn/mtu=2Ec:281
+unusedStructMember:src/ope=
nvpn/mtu=2Ec:289
 # FP: used implictly by NL macros
 unusedStructMember:src=
/openvpn/networking_sitnl=2Ec
 # IGN: keep explanatory fields in test data
=
@@ -111,3 +129,5 @@
 variableScope:src/openvpn/networking_sitnl=2Ec:1390
 #=
 IGN: nicer to keep the "variable" earlier
 variableScope:src/openvpnserv/i=
nteractive=2Ec:2687
+# FP: fun:platform_create_temp_file: cppcheck is confu=
sed
+wrongPrintfScanfArgNum:src/openvpn/platform=2Ec:553
diff --git a/src/o=
penvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 6d9c181=2E=2Ede3d467 100644
--=
- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -324,7 +324,7 @@
 {
=
     struct multi_instance *mi =3D NULL;
 
-    uint8_t *ptr =3D BPTR(&m->t=
op=2Ec2=2Ebuf);
+    const uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
     =
uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
     bool v2 =3D (op =3D=3D P_DATA=
_V2) && (m->top=2Ec2=2Ebuf=2Elen >=3D (1 + 3));
     bool peer_id_disabled =
=3D false;
@@ -376,7 +376,7 @@
         return NULL;
     }
 
-    uint8_t =
*ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+    const uint8_t *ptr =3D BPTR(&m->top=
=2Ec2=2Ebuf);
     uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
 
     struct m=
route_addr real =3D { 0 };
diff --git a/src/openvpn/multi=2Ec b/src/openvpn=
/multi=2Ec
index 60a5148=2E=2E74939bf 100644
--- a/src/openvpn/multi=2Ec
++=
+ b/src/openvpn/multi=2Ec
@@ -3095,8 +3095,8 @@
 
     struct multi_instanc=
e *ex_mi =3D he->value;
 
-    struct tls_multi *m1 =3D mi->context=2Ec2=2E=
tls_multi;
-    struct tls_multi *m2 =3D ex_mi->context=2Ec2=2Etls_multi;
+=
    const struct tls_multi *m1 =3D mi->context=2Ec2=2Etls_multi;
+    const=
 struct tls_multi *m2 =3D ex_mi->context=2Ec2=2Etls_multi;
 
     struct gc=
_arena gc =3D gc_new();
     int ret =3D false;
diff --git a/src/openvpn/mu=
lti_io=2Ec b/src/openvpn/multi_io=2Ec
index d8cc708=2E=2E3604684 100644
---=
 a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -191,12 +191,=
12 @@
 int
 multi_io_wait(struct multi_context *m)
 {
-    int status, i;
+=
    int status;
     unsigned int *persistent =3D &m->multi_io->tun_rwflags=
;
 
     if (!tuntap_is_dco_win(m->top=2Ec1=2Etuntap))
     {
-        for =
(i =3D 0; i < m->top=2Ec1=2Elink_sockets_num; i++)
+        for (int i =3D =
0; i < m->top=2Ec1=2Elink_sockets_num; i++)
         {
             socket_=
set_listen_persistent(m->top=2Ec2=2Elink_sockets[i], m->multi_io->es,
     =
                                     &m->top=2Ec2=2Elink_sockets[i]->ev_arg=
);
diff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec
index 7d3=
5195=2E=2E24d6bb6 100644
--- a/src/openvpn/openvpn=2Ec
+++ b/src/openvpn/op=
envpn=2Ec
@@ -32,7 +32,6 @@
 #include "win32=2Eh"
 #include "options_show=
=2Eh"
 #include "platform=2Eh"
-#include "string=2Eh"
 
 #include "memdbg=
=2Eh"
 
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=
=2Ec
index faf5a27=2E=2Ec92c423 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
++=
+ b/src/openvpn/ssl_mbedtls=2Ec
@@ -286,7 +286,7 @@
 void
 tls_ctx_restrict=
_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
-    char *tmp_c=
iphers, *tmp_ciphers_orig, *token;
+    char *tmp_ciphers, *tmp_ciphers_ori=
g;
 
     if (NULL =3D=3D ciphers)
     {
@@ -306,7 +306,7 @@
     char *la=
sts =3D NULL;
     tmp_ciphers_orig =3D tmp_ciphers =3D string_alloc(cipher=
s, NULL);
 
-    token =3D strtok_r(tmp_ciphers, ":", &lasts);
+    const c=
har *token =3D strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
     =
{
         ctx->allowed_ciphers[i] =3D mbedtls_ssl_get_ciphersuite_id(tls_t=
ranslate_cipher_name(token));
diff --git a/tests/unit_tests/openvpn/test_pk=
t=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index 5ec6781=2E=2Ea732c2b 10=
0644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/ope=
nvpn/test_pkt=2Ec
@@ -562,7 +562,7 @@
 static void
 test_calc_session_id_hm=
ac_static(void **ut_state)
 {
-    uint8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2=
, 3, 0 };
+    const uint8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, 0 };
    =
 static const int handwindow =3D 100;
 
     struct openvpn_sockaddr addr =
=3D { 0 };

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
69?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id56fb=
fa4767346995eaa05ac95c7a20fbba99b2d
Gerrit-Change-Number: 1869
Gerrit-Patch=
Set: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer=
: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--kEMctwP6bzA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">Make cppcheck run pass on =
top of current master<br><br>* Update cppcheck-suppressions to be in sync w=
ith<br>  current code<br>* Suppress some additional findings that we have<b=
r>  patches for in the queue but which are not merged,<br>  yet<br>* Add so=
me additional fixes for categories we had<br>  fixed but for which new occu=
rences crept in<br><br>The goal is to have one commit that allows us to<br>=
enable a cppcheck run in buildbot to keep it<br>up to date going forward=2E=
<br><br>Change-Id: Id56fbfa4767346995eaa05ac95c7a20fbba99b2d<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1869<br>Message-Id: &lt;20260825154932=2E4586-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg38677=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cppcheck-suppression<b=
r>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi_=
io=2Ec<br>M src/openvpn/openvpn=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M t=
ests/unit_tests/openvpn/test_pkt=2Ec<br>7 files changed, 42 insertions(+), =
23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/69/1869/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/=
cppcheck-suppression b/dev-tools/cppcheck-suppression</span><br><span>index=
 900e03c=2E=2Ea585513 100644</span><br><span>--- a/dev-tools/cppcheck-suppr=
ession</span><br><span>+++ b/dev-tools/cppcheck-suppression</span><br><span=
>@@ -5,6 +5,10 @@</span><br><span> constParameterPointer</span><br><span> i=
nvalidPrintfArgType_sint</span><br><span> invalidPrintfArgType_uint</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+redundantAssignment</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+redundantInitialization</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+unreadVariable</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+unusedFunction</span><br><sp=
an> usleepCalled</span><br><span> variableScope</span><br><span> # We have =
a lot of library includes, not all of them are really required,</span><br><=
span>@@ -24,15 +28,21 @@</span><br><span> localtimeCalled</span><br><span> =
strtokCalled</span><br><span> # FP: posix=2Ecfg claims suseconds_t is unsig=
ned for some reason</span><br><span style=3D"color: hsl(0, 100%, 40%);">-un=
signedLessThanZero:src/openvpn/otime=2Eh:235</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+unsignedLessThanZero:src/openvpn/otime=2Eh:148</sp=
an><br><span> # IGN: multi code does weird things with pointers to local va=
riables=2E=2E=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-autoV=
ariables:src/openvpn/multi=2Ec:4177</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-autoVariables:src/openvpn/multi_io=2Ec:280</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+autoVariables:src/openvpn/multi=2Ec:42=
32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+autoVariables:src=
/openvpn/multi_io=2Ec:324</span><br><span> # IGN: the code header =3D 0 | (=
OPCODE &lt;&lt; P_OPCODE_SHIFT) is used intentionally</span><br><span> badB=
itmaskCheck:src/openvpn/mudp=2Ec</span><br><span> badBitmaskCheck:tests/uni=
t_tests/openvpn/test_pkt=2Ec</span><br><span> # IGN: we store integers in p=
ointers</span><br><span> CastAddressToIntegerAtReturn:src/openvpn/multi=2Ec=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: Windows spec=
ific (unsigned long =3D=3D unsigned int)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+compareValueOutOfTypeRangeError:src/openvpn/ssl_verify=
=2Ec:928</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: cppch=
eck seems to have wrong signature of DeviceIoControl()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+constVariablePointer:src/openvpn/dco_win=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: test_net=
working code would break with iproute2 but that is prevented</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ctunullpointer:src/openvpn/network=
ing_iproute2=2Ec</span><br><span> # IGN: event code uses a pointer to store=
 integers</span><br><span> intToPointerCast:src/openvpn/forward=2Ec</span><=
br><span> intToPointerCast:src/openvpn/multi_io=2Ec</span><br><span>@@ -40,=
7 +50,7 @@</span><br><span> # FP: constant but differs between platforms</s=
pan><br><span> knownConditionTrueFalse:src/openvpn/error=2Eh:380</span><br>=
<span> knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:80</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/llad=
dr=2Ec:65</span><br><span style=3D"color: hsl(120, 100%, 40%);">+knownCondi=
tionTrueFalse:src/openvpn/lladdr=2Ec:64</span><br><span> knownConditionTrue=
False:src/openvpn/platform=2Ec</span><br><span> # FP: code needs to accomod=
ate many different defines</span><br><span> knownConditionTrueFalse:src/ope=
nvpn/event=2Ec:1139</span><br><span>@@ -48,13 +58,13 @@</span><br><span> # =
FP: dco_win support has &quot;false&quot; stubs</span><br><span> knownCondi=
tionTrueFalse:src/openvpn/forward=2Ec</span><br><span> knownConditionTrueFa=
lse:src/openvpn/init=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-knownConditionTrueFalse:src/openvpn/multi_io=2Ec:163</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/mul=
ti_io=2Ec:197</span><br><span> # FP: cppcheck thinks that some functions al=
ways return true, but they don&#39;t</span><br><span> knownConditionTrueFal=
se:src/openvpn/misc=2Ec:97</span><br><span> knownConditionTrueFalse:src/ope=
nvpn/sig=2Eh:116</span><br><span> # FP: cert_uri_supported is a wrapper aro=
und defines, so it&#39;s</span><br><span> # always constant but differs dep=
ending on OpenSSL version</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-knownConditionTrueFalse:src/openvpn/ssl_openssl=2Ec:1332</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvp=
n/ssl_openssl=2Ec:1260</span><br><span> # FP: cppcheck doesn&#39;t understa=
nd that the function changes szErrMessage</span><br><span> knownConditionTr=
ueFalse:src/tapctl/main=2Ec:704</span><br><span> knownConditionTrueFalse:sr=
c/openvpnmsica/dllmain=2Ec:164</span><br><span>@@ -65,12 +75,18 @@</span><b=
r><span> # FP: eventmsg=2Eh is not built on Unix</span><br><span> missingIn=
clude:src/openvpnserv/common=2Ec:25</span><br><span> # IGN: strlen(NULL) is=
 not nice code, but seems to work</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-nullPointerRedundantCheck:src/openvpn/init=2Ec:299</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+nullPointerRedundantCheck:src/op=
envpn/init=2Ec:301</span><br><span> # FP: cppcheck doesn&#39;t understand Z=
eroMemory</span><br><span> redundantAssignment:src/openvpnserv/interactive=
=2Ec:203</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: cppch=
eck doesn&#39;t know the NLA macros</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+redundantInitialization:src/openvpn/dco_linux=2Ec</span><br=
><span> # IGN: We reuse the same variable name due to macro usage</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-shadowVariable:src/openvpn/opti=
ons=2Ec:2580</span><br><span style=3D"color: hsl(0, 100%, 40%);">-shadowVar=
iable:src/openvpn/options=2Ec:2598</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+shadowVariable:src/openvpn/options=2Ec:1948</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+shadowVariable:src/openvpn/options=
=2Ec:1966</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: sur=
e this is theoretically undefined, but works</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+shiftNegativeLHS:tests/unit_tests/openvpn/test_sch=
edule=2Ec:183</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: =
fun:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is confused</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+syntaxError:tests/unit_tests/openvpn=
/test_tls_crypt=2Ec:684</span><br><span> # FP: this file is never compiled =
on _WIN32</span><br><span> umaskCalled:tests/unit_tests/openvpn/test_pkcs11=
=2Ec</span><br><span> # FP: yes, t_prev is unitialized, but t_prev_len is 0=
, so that&#39;s handled</span><br><span>@@ -78,13 +94,13 @@</span><br><span=
> # FP: yes, parm is unitialized, but parm_len is 0, so that&#39;s handled<=
/span><br><span> uninitvar:src/openvpn/options_parse=2Ec:148</span><br><spa=
n> # FP: uninit is fine when it is a return parameter</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ctuuninitvar:src/openvpn/crypto_mbedtls_leg=
acy=2Ec:698</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uninitvar:=
src/openvpnserv/interactive=2Ec:1935</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:690</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+uninitvar:src/openvpnse=
rv/interactive=2Ec:2775</span><br><span> uninitvar:src/tapctl/main=2Ec:566<=
/span><br><span> # FP: we added a check but cppcheck is not convinced</span=
><br><span> uninitvar:src/openvpnserv/interactive=2Ec:2667</span><br><span>=
 # FP: weird parse error, the macro is fine in the rest of the file</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-unknownMacro:src/openvpnserv/=
interactive=2Ec:3488</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+unknownMacro:src/openvpnserv/interactive=2Ec:3596</span><br><span> # FP: c=
ppcheck doesn&#39;t account for short-circuiting</span><br><span> unreadVar=
iable:src/openvpn/manage=2Ec:682</span><br><span> unusedFunction:src/openvp=
n/siphash_reference=2Ec</span><br><span>@@ -101,8 +117,10 @@</span><br><spa=
n> # FP: doesn&#39;t account for --wrap</span><br><span> unusedFunction:tes=
ts/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span> unusedFunction:/u=
sr/include/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: c=
ppcheck doesn&#39;t know the NLA macros</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+unusedLabel:src/openvpn/dco_linux=2Ec</span><br><span> =
# IGN: old code that is difficult to test (MSG_ERRQUEUE), ignore for now</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedStructMember:src/o=
penvpn/mtu=2Ec:281</span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
nusedStructMember:src/openvpn/mtu=2Ec:289</span><br><span> # FP: used impli=
ctly by NL macros</span><br><span> unusedStructMember:src/openvpn/networkin=
g_sitnl=2Ec</span><br><span> # IGN: keep explanatory fields in test data</s=
pan><br><span>@@ -111,3 +129,5 @@</span><br><span> variableScope:src/openvp=
n/networking_sitnl=2Ec:1390</span><br><span> # IGN: nicer to keep the &quot=
;variable&quot; earlier</span><br><span> variableScope:src/openvpnserv/inte=
ractive=2Ec:2687</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# F=
P: fun:platform_create_temp_file: cppcheck is confused</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+wrongPrintfScanfArgNum:src/openvpn/platf=
orm=2Ec:553</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn=
/mudp=2Ec</span><br><span>index 6d9c181=2E=2Ede3d467 100644</span><br><span=
>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</spa=
n><br><span>@@ -324,7 +324,7 @@</span><br><span> {</span><br><span>     str=
uct multi_instance *mi =3D NULL;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=
=2Ebuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
int8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>     uint8=
_t op =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span>     bool v2 =3D =
(op =3D=3D P_DATA_V2) &amp;&amp; (m-&gt;top=2Ec2=2Ebuf=2Elen &gt;=3D (1 + 3=
));</span><br><span>     bool peer_id_disabled =3D false;</span><br><span>@=
@ -376,7 +376,7 @@</span><br><span>         return NULL;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *ptr =3D BPTR(&amp;m-&=
gt;top=2Ec2=2Ebuf);</span><br><span>     uint8_t op =3D ptr[0] &gt;&gt; P_O=
PCODE_SHIFT;</span><br><span> </span><br><span>     struct mroute_addr real=
 =3D { 0 };</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvp=
n/multi=2Ec</span><br><span>index 60a5148=2E=2E74939bf 100644</span><br><sp=
an>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec<=
/span><br><span>@@ -3095,8 +3095,8 @@</span><br><span> </span><br><span>   =
  struct multi_instance *ex_mi =3D he-&gt;value;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_multi *m1 =3D m=
i-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    struct tls_multi *m2 =3D ex_mi-&gt;context=2Ec2=2Etls_multi;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct tls=
_multi *m1 =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const struct tls_multi *m2 =3D ex_mi-&gt;co=
ntext=2Ec2=2Etls_multi;</span><br><span> </span><br><span>     struct gc_ar=
ena gc =3D gc_new();</span><br><span>     int ret =3D false;</span><br><spa=
n>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><b=
r><span>index d8cc708=2E=2E3604684 100644</span><br><span>--- a/src/openvpn=
/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><spa=
n>@@ -191,12 +191,12 @@</span><br><span> int</span><br><span> multi_io_wait=
(struct multi_context *m)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    int status, i;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int status;</span><br><span>     unsigned int *pe=
rsistent =3D &amp;m-&gt;multi_io-&gt;tun_rwflags;</span><br><span> </span><=
br><span>     if (!tuntap_is_dco_win(m-&gt;top=2Ec1=2Etuntap))</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for=
 (i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; m-&g=
t;top=2Ec1=2Elink_sockets_num; i++)</span><br><span>         {</span><br><s=
pan>             socket_set_listen_persistent(m-&gt;top=2Ec2=2Elink_sockets=
[i], m-&gt;multi_io-&gt;es,</span><br><span>                               =
           &amp;m-&gt;top=2Ec2=2Elink_sockets[i]-&gt;ev_arg);</span><br><sp=
an>diff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec</span><br=
><span>index 7d35195=2E=2E24d6bb6 100644</span><br><span>--- a/src/openvpn/=
openvpn=2Ec</span><br><span>+++ b/src/openvpn/openvpn=2Ec</span><br><span>@=
@ -32,7 +32,6 @@</span><br><span> #include &quot;win32=2Eh&quot;</span><br>=
<span> #include &quot;options_show=2Eh&quot;</span><br><span> #include &quo=
t;platform=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
include &quot;string=2Eh&quot;</span><br><span> </span><br><span> #include =
&quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index =
faf5a27=2E=2Ec92c423 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -=
286,7 +286,7 @@</span><br><span> void</span><br><span> tls_ctx_restrict_cip=
hers(struct tls_root_ctx *ctx, const char *ciphers)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *tmp_ciphers, *tm=
p_ciphers_orig, *token;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    char *tmp_ciphers, *tmp_ciphers_orig;</span><br><span> </span><br><=
span>     if (NULL =3D=3D ciphers)</span><br><span>     {</span><br><span>@=
@ -306,7 +306,7 @@</span><br><span>     char *lasts =3D NULL;</span><br><sp=
an>     tmp_ciphers_orig =3D tmp_ciphers =3D string_alloc(ciphers, NULL);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    t=
oken =3D strtok_r(tmp_ciphers, &quot;:&quot;, &amp;lasts);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(t=
mp_ciphers, &quot;:&quot;, &amp;lasts);</span><br><span>     while (token)<=
/span><br><span>     {</span><br><span>         ctx-&gt;allowed_ciphers[i] =
=3D mbedtls_ssl_get_ciphersuite_id(tls_translate_cipher_name(token));</span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_=
tests/openvpn/test_pkt=2Ec</span><br><span>index 5ec6781=2E=2Ea732c2b 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -562,7 +5=
62,7 @@</span><br><span> static void</span><br><span> test_calc_session_id_=
hmac_static(void **ut_state)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    uint8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8=
_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, 0 };</span><br><span>     static co=
nst int handwindow =3D 100;</span><br><span> </span><br><span>     struct o=
penvpn_sockaddr addr =3D { 0 };</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3Dema=
il">change 1869</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
869?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Id56fbfa4767346995eaa05ac95c7a20fbba99b2d </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1869 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--kEMctwP6bzA=--


--===============5358216733743087746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5358216733743087746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5358216733743087746==--

