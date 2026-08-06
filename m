Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AB0C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aTpZq3YsYDKhHyg+nKEf/xAu8MBzyO46kapBdNDg6j0=; b=gm1Q/PAn0JWEqq9DD5zdl/sV+5
	cajuUa+XPTyNrTNZ25C5d7F2luQcInhdnST5S6IPNdYl+2k5c2+3G1Q+r5aXeGHO9vAwVUnB4ovsX
	vg0IdJTS4Wlaprgnj24wRfEQ6UuEkkcYNyv5HKbg4TQwOnnL1J70gCtlDm5pH05TZCMQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrxHX-0003jg-Hc;
	Thu, 06 Aug 2026 12:33:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrxHW-0003ja-Ha
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:33:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=397MpJivIZSsKq+cABrDvtyYaSgBg2hz+6jVYEycxgE=; b=P6yZcEKv90B/CdQAGbYmU3oZdW
 wn7g995pqotJ3nnb352yYLMocvfpY9NHV+w6UK5ocwbnrGEzQnQFgOcjIb8JqK/gOh/oCoQ+2FFb/
 3DKKdT8Xb6MbmrtPuKGLM1WIM9OhT8Bz8TLA9UpM9tvmudATArISjr4NvCOc9oLonSmk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=397MpJivIZSsKq+cABrDvtyYaSgBg2hz+6jVYEycxgE=; b=S
 SC3/g1BkonPf8v1mfxzfRkQeEuiPK7sKEKH5GLnr38bgi/JekAmDNdG3gtKtjzPoEi2E76P64ROup
 aij2SLeg59VEjZZrLaNVy8arTvVCngo2dNoyIsQEWlB8VUjg2xBR2zgZYRKXUxryIxQR6bO7fw6eH
 DwhIVUaUAk1zurfo=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrxHU-0004KW-42 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:33:07 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so1383349f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786019574; x=1786624374; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=397MpJivIZSsKq+cABrDvtyYaSgBg2hz+6jVYEycxgE=;
 b=FEz3VtU79f77DmfYXtjkG0Gd1Lz5jek5aPLYY7W1fVhdCN8O+gVtctCOf9/Qm9YIKg
 EB/QKSy+qDPhKuwgmAh4wWBdtiJ78tdIJpSSSiji1cMIQ+tm+4JXTFk7sPYLPzzFCxO4
 rp4qOO71d6LjL+Nu9E7uNLJMX6sMtJ6wlCAaEikWzk+wFFwwtsgVHGQhkDjyQTF82a+y
 8fG4ULyBCY/mkteotPdMbbUn0Hf6MSuFJ523NaadgiksKshFj4VQq8mPQ9ardSDHgqMQ
 JeCvRKG0lhDxSEwCE6IKus+sW5F2c1Rhyip7OM0Vedmct4NahhKNjdTZrTmgncutjo98
 dGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786019574; x=1786624374;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=397MpJivIZSsKq+cABrDvtyYaSgBg2hz+6jVYEycxgE=;
 b=VDgY2SthmsNScyjXePrx83wvToGotJ3hu0k5xpmqH818uz05FWN5rlUcz1feYn4psy
 9UeZV0A2UsThqx4kXlc+BUH3owofdVjtOpVm0fzmSHQqfFzAXZgLo0CDDwe2JRSNt8er
 CfgR1e6uWCZt5LHS1bPnv+ZgKv6BHDhRGbALlDleRgDmuSvp1dqw4wJlEmmbwBK6X8gc
 REJlOxwEK6LPeZS7imK8Dy2bTNyhrJGC6UVHhxGjl/v9RpGHxnXJqLEJy5aCNpKVBhUG
 dgusyHOlcP2WKV9Semu7dzh5djG9qFRBz+PzCA/UCx+6uqUl9EKTgJVZCZLt1LQSUTxj
 HB7g==
X-Gm-Message-State: AOJu0Yzn5UknOyWMaR8PyJHor6Ex0iPR+DK3Y3GyCl9Kwxo1QtVbQse1
 yZ78zfgGyoKg8zb1TdXJ4g3j/G6j2om5ZDLaOi5h5VpmVIctBgaAZm2+FT45M9p1IESQD8MCyTH
 M8vaiGuMuItRawkawsxvEweJnc3mQxHzuQkTslhelnbXgM6fwxJsXWdfNhMZrCYlKBrUFQC55t4
 tyvvMesQ==
X-Gm-Gg: AR+sD10vKdjeAcrXKkntIHmXrX27bLO5yT8gsYQUE2DT823HfTX/F5mUde6pDrHpiZJ
 iWtRNUBI4IASmTUB6CmZk9mBe2RZCXa3KyS40G44YXp1M1fICXN/K50cra9/O9yb7N1uTTggbvY
 n92KG72RN5uxSL7koeyAG5j6CYLPjejSEdNzC9fMMjC8Prkwgcs9g5mk+uovuU4uZUspK1HoOKK
 hluO594rHUON+Mf/E8Fd48ixXH9Bat0twXbSFW9GNBUwpFAxmzhW072q9ueMrlUYDlfaiKq4FUZ
 yaaeVoMXjnW3WQ6YltOtMohSnZu9+PGmPAQ13+mxAQETANnBDauJys7H+3Epx3Dj4XCeKdHnX3J
 ZGDjYrSpC0N3Q965ocs1/NQPAvKXDQZ0QspznQr8OuEGsubTM1p2geSm8ycV3ouW+y4JnyFQtfO
 aWzNo/gxfCxfrkIz+3SxBGyeGViQpXvj0sp73t7b316kezc+bLmtjXqxnN9eddliX1m9nhicYxR
 rrejGm+Gvz23Iky5emtK/iy5El6i3vgn5EVbmiVsyvHId//NkonFSohpw9r1xP3P1Mh40qDrdAZ
 zb9iqJBqcyZ1RyrwPWkDmAqqp3I6pDvhmpt6y67q8SX7Jg4ccFA=
X-Received: by 2002:a05:6000:2212:b0:47f:b622:fcd2 with SMTP id
 ffacd0b85a97d-47fec630debmr20199709f8f.25.1786019570823; 
 Thu, 06 Aug 2026 05:32:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b1809csm5565541f8f.18.2026.08.06.05.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 05:32:50 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 12:32:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 841708b1fe6a2cec697286b636050e97f02a1085
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f661e93fe56fe9ce80ab3c9008ee46ff07e5f47d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrxHU-0004KW-42
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1650974314612895514=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1650974314612895514==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gkw6zbq8oMk="; charset=UTF-8

--gkw6zbq8oMk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1663?usp=3Demail

to look at the new patch set (#11)=2E
=


Change subject: Remove instances of constParameterPointer cppcheck warnin=
gs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove ins=
tances of constParameterPointer cppcheck warnings

This requires a few supp=
ressions since cppcheck
doesn't quite understand the different code-paths
i=
mplemented by preprocessor defines=2E

Change-Id: I56248cf6d199c2da770774b8=
fd1e5daf2b116f58
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

---
M dev-tools/cppcheck-suppression
M sample/sample-plugins/client-connec=
t/sample-client-connect=2Ec
M sample/sample-plugins/defer/multi-auth=2Ec
M =
sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=
=2Ec
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/clinat=
=2Ec
M src/openvpn/clinat=2Eh
M src/openvpn/comp=2Ec
M src/openvpn/comp=2Eh=

M src/openvpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/dco=2Ec
M =
src/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/dco_interna=
l=2Eh
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
M src/openvpn/d=
hcp=2Ec
M src/openvpn/dhcp=2Eh
M src/openvpn/event=2Eh
M src/openvpn/forwar=
d=2Ec
M src/openvpn/forward=2Eh
M src/openvpn/init=2Ec
M src/openvpn/init=
=2Eh
M src/openvpn/interval=2Eh
M src/openvpn/list=2Ec
M src/openvpn/list=
=2Eh
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/mbuf=
=2Ec
M src/openvpn/mbuf=2Eh
M src/openvpn/mss=2Ec
M src/openvpn/mss=2Eh
M s=
rc/openvpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/openvpn/mudp=2Ec
M src/ope=
nvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/networking=2Eh
M src/o=
penvpn/networking_iproute2=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/ope=
nvpn/occ=2Eh
M src/openvpn/openssl_compat=2Eh
M src/openvpn/options=2Ec
M s=
rc/openvpn/options_parse=2Ec
M src/openvpn/otime=2Ec
M src/openvpn/otime=2E=
h
M src/openvpn/proto=2Eh
M src/openvpn/proxy=2Ec
M src/openvpn/proxy=2Eh
M=
 src/openvpn/ps=2Ec
M src/openvpn/ps=2Eh
M src/openvpn/push=2Ec
M src/openv=
pn/push=2Eh
M src/openvpn/push_util=2Ec
M src/openvpn/reliable=2Ec
M src/op=
envpn/reliable=2Eh
M src/openvpn/route=2Ec
M src/openvpn/schedule=2Ec
M src=
/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M src/openvpn/socket_util=2Eh
=
M src/openvpn/socks=2Ec
M src/openvpn/socks=2Eh
M src/openvpn/ssl=2Ec
M src=
/openvpn/ssl=2Eh
M src/openvpn/ssl_backend=2Eh
M src/openvpn/ssl_mbedtls=2E=
c
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl=
_pkt=2Eh
M src/openvpn/ssl_verify=2Ec
M src/openvpn/ssl_verify=2Eh
M src/op=
envpn/status=2Ec
M src/openvpn/status=2Eh
M src/openvpn/tun=2Ec
M src/openv=
pn/tun=2Eh
M src/openvpn/tun_afunix=2Ec
M src/openvpn/tun_afunix=2Eh
M src/=
openvpn/vlan=2Ec
M src/openvpn/vlan=2Eh
M src/openvpn/win32=2Eh
M src/openv=
pnmsica/openvpnmsica=2Ec
M src/openvpnserv/interactive=2Ec
M tests/unit_tes=
ts/openvpn/mock_management=2Ec
M tests/unit_tests/openvpn/test_misc=2Ec
M t=
ests/unit_tests/openvpn/test_user_pass=2Ec
88 files changed, 333 insertions=
(+), 289 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/63/1663/11

diff --git a/dev-tools/cppcheck-suppression b/d=
ev-tools/cppcheck-suppression
index 900e03c=2E=2E5bc4b24 100644
--- a/dev-t=
ools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -2,7 +2,6=
 @@
 # occurences right now=2E They still should be fixed at some point
 co=
nstParameter
 constParameterCallback
-constParameterPointer
 invalidPrintfA=
rgType_sint
 invalidPrintfArgType_uint
 usleepCalled
@@ -33,6 +32,39 @@
 ba=
dBitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec
 # IGN: we store intege=
rs in pointers
 CastAddressToIntegerAtReturn:src/openvpn/multi=2Ec
+constPa=
rameterPointer:/usr/include/*
+# IGN: test files provide mocks/stubs that m=
atch prototypes from headers exactly
+constParameterPointer:tests/unit_test=
s/openvpn/mock_*
+constParameterPointer:tests/unit_tests/openvpn/test_*
+co=
nstParameterPointer:tests/unit_tests/openvpnserv/test_*
+# FP: different cr=
ypto implementations but same API
+constParameterPointer:src/openvpn/crypto=
_mbedtls_legacy=2Ec:85
+constParameterPointer:src/openvpn/crypto_openssl=2E=
c:172
+constParameterPointer:src/openvpn/crypto_openssl=2Ec:1456
+constPara=
meterPointer:src/openvpn/cryptoapi=2Ec:58
+constParameterPointer:src/openvp=
n/ssl_mbedtls=2Ec
+constParameterPointer:src/openvpn/ssl_openssl=2Ec
+const=
ParameterPointer:src/openvpn/ssl_verify_mbedtls=2Ec
+# IGN: too many differ=
ent implementations, not worth it
+constParameterPointer:src/openvpn/dco*
+=
constParameterPointer:src/openvpn/socket=2E*
+# FP: parameters are modified=
 on some platform only
+constParameterPointer:src/openvpn/dns=2Ec:859
+cons=
tParameterPointer:src/openvpn/error=2Ec:223
+constParameterPointer:src/open=
vpn/forward=2Ec:1247
+constParameterPointer:src/openvpn/manage=2Ec:344
+con=
stParameterPointer:src/openvpn/manage=2Ec:3332
+constParameterPointer:src/o=
penvpn/misc=2Ec:792
+constParameterPointer:src/openvpn/misc=2Ec:812
+constP=
arameterPointer:src/openvpn/options=2Ec:3205
+constParameterPointer:src/ope=
nvpn/route=2Ec:3947
+constParameterPointer:src/openvpn/tun=2Ec:560
+constPa=
rameterPointer:src/openvpn/tun=2Ec:2188
+constParameterPointer:src/openvpn/=
tun_afunix=2Ec
+# IGN: not a FP but the documentation for the FP_ISSET clai=
ms this is not const=2E=2E=2E
+constParameterPointer:src/openvpn/event=2Ec:=
1015
+# IGN: MinGW Debug build doesn't like this, causes -Wmaybe-uninitiali=
zed
+constParameterPointer:src/openvpn/buffer=2Eh:1105
 # IGN: event code u=
ses a pointer to store integers
 intToPointerCast:src/openvpn/forward=2Ec
 =
intToPointerCast:src/openvpn/multi_io=2Ec
diff --git a/sample/sample-plugin=
s/client-connect/sample-client-connect=2Ec b/sample/sample-plugins/client-c=
onnect/sample-client-connect=2Ec
index 420de61=2E=2Ecbd98e8 100644
--- a/sa=
mple/sample-plugins/client-connect/sample-client-connect=2Ec
+++ b/sample/s=
ample-plugins/client-connect/sample-client-connect=2Ec
@@ -344,7 +344,7 @@
=
 }
 
 int
-openvpn_plugin_client_connect(struct plugin_context *context, co=
nst char **argv, const char **envp)
+openvpn_plugin_client_connect(const st=
ruct plugin_context *context, const char **argv, const char **envp)
 {
    =
 /* log environment variables handed to us by OpenVPN, but
      * only if =
"setenv verb" is 3 or higher (arbitrary number)
@@ -465,7 +465,7 @@
 
 int
=
 openvpn_plugin_client_connect_defer_v2(struct plugin_context *context,
-  =
                                     struct plugin_per_client_context *pcc,=

+                                       const struct plugin_per_client_con=
text *pcc,
                                        struct openvpn_plugin_st=
ring_list **return_list)
 {
     time_t time_left =3D pcc->sleep_until - ti=
me(NULL);
diff --git a/sample/sample-plugins/defer/multi-auth=2Ec b/sample/=
sample-plugins/defer/multi-auth=2Ec
index bacf557=2E=2Ecdd616f 100644
--- a=
/sample/sample-plugins/defer/multi-auth=2Ec
+++ b/sample/sample-plugins/def=
er/multi-auth=2Ec
@@ -255,7 +255,7 @@
 }
 
 static bool
-do_auth_user_pass(=
struct plugin_context *context, const char *username, const char *password)=

+do_auth_user_pass(const struct plugin_context *context, const char *usern=
ame, const char *password)
 {
     plog(context, PLOG_NOTE, "expect_user=3D=
%s, received_user=3D%s, expect_passw=3D%s, received_passw=3D%s",
          =
np(context->test_valid_user), np(username), np(context->test_valid_pass), n=
p(password));
@@ -279,7 +279,7 @@
 
 
 static int
-auth_user_pass_verify(st=
ruct plugin_context *context, struct plugin_per_client_context *pcc,
+auth_=
user_pass_verify(const struct plugin_context *context, struct plugin_per_cl=
ient_context *pcc,
                       const char *argv[], const char *e=
nvp[])
 {
     /* get username/password from envp string array */
diff --gi=
t a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexpor=
ter=2Ec b/sample/sample-plugins/keying-material-exporter-demo/keyingmateria=
lexporter=2Ec
index 25c9ff5=2E=2E512861a 100644
--- a/sample/sample-plugins=
/keying-material-exporter-demo/keyingmaterialexporter=2Ec
+++ b/sample/samp=
le-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec
@@ -186=
,7 +186,7 @@
 }
 
 static void
-file_store(char *file, char *content)
+file=
_store(const char *file, const char *content)
 {
     FILE *f;
     if (!(f=
 =3D fopen(file, "w+")))
@@ -202,7 +202,7 @@
 server_store(struct openvpn_p=
lugin_args_func_in const *args)
 {
     struct plugin *plugin =3D (struct p=
lugin *)args->handle;
-    struct session *sess =3D (struct session *)args-=
>per_client_context;
+    const struct session *sess =3D (struct session *)=
args->per_client_context;
 
     char file[MAXPATH];
     snprintf(file, si=
zeof(file) - 1, "/tmp/openvpn_sso_%s", sess->key);
@@ -214,7 +214,7 @@
 cli=
ent_store(struct openvpn_plugin_args_func_in const *args)
 {
     struct pl=
ugin *plugin =3D (struct plugin *)args->handle;
-    struct session *sess =
=3D (struct session *)args->per_client_context;
+    const struct session *=
sess =3D (struct session *)args->per_client_context;
 
     char *file =3D =
"/tmp/openvpn_sso_user";
     ovpn_note("app session file: %s", file);
diff=
 --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index f57c8c2=2E=
=2E2f4d037 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec=

@@ -290,7 +290,7 @@
  * truncated by buf_printf
  */
 void
-buf_catrunc(st=
ruct buffer *buf, const char *str)
+buf_catrunc(const struct buffer *buf, c=
onst char *str)
 {
     if (buf_forward_capacity(buf) <=3D 1)
     {
@@ -10=
91,7 +1091,7 @@
 }
 
 bool
-string_check_buf(struct buffer *buf, const unsi=
gned int inclusive, const unsigned int exclusive)
+string_check_buf(const s=
truct buffer *buf, const unsigned int inclusive, const unsigned int exclusi=
ve)
 {
     ASSERT(buf);
 
diff --git a/src/openvpn/buffer=2Eh b/src/openvp=
n/buffer=2Eh
index 93aa786=2E=2Ea425737 100644
--- a/src/openvpn/buffer=2Eh=

+++ b/src/openvpn/buffer=2Eh
@@ -488,7 +488,7 @@
  * write a string to the=
 end of a buffer that was
  * truncated by buf_printf
  */
-void buf_catrun=
c(struct buffer *buf, const char *str);
+void buf_catrunc(const struct buff=
er *buf, const char *str);
 
 /*
  * Parse a string based on a given delimi=
ter char
@@ -782,7 +782,7 @@
 }
 
 static inline int
-buf_peek_u8(struct bu=
ffer *buf)
+buf_peek_u8(const struct buffer *buf)
 {
     int ret;
     if =
(BLEN(buf) < 1)
@@ -955,7 +955,7 @@
  * @param exclusive Character classes =
that are not allowed even if they are also in inclusive=2E
  * @return True=
 if the string consists only of allowed characters, false otherwise=2E
  */=

-bool string_check_buf(struct buffer *buf, const unsigned int inclusive,
+=
bool string_check_buf(const struct buffer *buf, const unsigned int inclusiv=
e,
                       const unsigned int exclusive);
 
 /**
diff --git =
a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec
index 32c1325=2E=2Eb46595=
0 100644
--- a/src/openvpn/clinat=2Ec
+++ b/src/openvpn/clinat=2Ec
@@ -159,=
7 +159,7 @@
 #endif
 
 static void
-print_pkt(struct openvpn_iphdr *iph, co=
nst char *prefix, const int direction, const msglvl_t msglevel)
+print_pkt(=
const struct openvpn_iphdr *iph, const char *prefix, const int direction, c=
onst msglvl_t msglevel)
 {
     struct gc_arena gc =3D gc_new();
 
@@ -181,=
7 +181,7 @@
 }
 
 void
-client_nat_transform(const struct client_nat_option=
_list *list, struct buffer *ipbuf,
+client_nat_transform(const struct clien=
t_nat_option_list *list, const struct buffer *ipbuf,
                      =
const int direction)
 {
     struct ip_tcp_udp_hdr *h =3D (struct ip_tcp_ud=
p_hdr *)BPTR(ipbuf);
diff --git a/src/openvpn/clinat=2Eh b/src/openvpn/clin=
at=2Eh
index 1e8ceb3=2E=2Ebc56037 100644
--- a/src/openvpn/clinat=2Eh
+++ b=
/src/openvpn/clinat=2Eh
@@ -60,7 +60,7 @@
                                 =
   const char *network, const char *netmask,
                              =
      const char *foreign_network, msglvl_t msglevel);
 
-void client_nat_t=
ransform(const struct client_nat_option_list *list, struct buffer *ipbuf,
+=
void client_nat_transform(const struct client_nat_option_list *list, const =
struct buffer *ipbuf,
                           const int direction);
 
 #=
endif /* if !defined(CLINAT_H) */
diff --git a/src/openvpn/comp=2Ec b/src/o=
penvpn/comp=2Ec
index b88b79f=2E=2E387a7c4 100644
--- a/src/openvpn/comp=2E=
c
+++ b/src/openvpn/comp=2Ec
@@ -159,7 +159,7 @@
 #endif /* USE_COMP */
 
 =
bool
-check_compression_settings_valid(struct compress_options *info, msglv=
l_t msglevel)
+check_compression_settings_valid(const struct compress_optio=
ns *info, msglvl_t msglevel)
 {
     /*
      * We also allow comp-stub-v2 =
here as it technically allows escaping of
diff --git a/src/openvpn/comp=2Eh=
 b/src/openvpn/comp=2Eh
index 29a90a2=2E=2Ead80243 100644
--- a/src/openvpn=
/comp=2Eh
+++ b/src/openvpn/comp=2Eh
@@ -91,7 +91,7 @@
  * flags of allow-c=
ompression and also the whether algorithms are compiled
  * in
  */
-bool c=
heck_compression_settings_valid(struct compress_options *info, msglvl_t msg=
level);
+bool check_compression_settings_valid(const struct compress_option=
s *info, msglvl_t msglevel);
 
 #ifdef USE_COMP
 #include "buffer=2Eh"
diff=
 --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index 67ff0d3=2E=
=2E5753e4f 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec=

@@ -1105,7 +1105,7 @@
 }
 
 static bool
-key_is_zero(struct key *key, cons=
t struct key_type *kt)
+key_is_zero(const struct key *key, const struct key=
_type *kt)
 {
     size_t cipher_length =3D cipher_kt_key_size(kt->cipher);=

     for (size_t i =3D 0; i < cipher_length; ++i)
@@ -1123,7 +1123,7 @@
  =
* Make sure that cipher key is a valid key for current key_type=2E
  */
 bo=
ol
-check_key(struct key *key, const struct key_type *kt)
+check_key(const =
struct key *key, const struct key_type *kt)
 {
     if (cipher_defined(kt->=
cipher))
     {
@@ -1196,7 +1196,7 @@
 }
 
 void
-test_crypto(struct crypto=
_options *co, struct frame *frame)
+test_crypto(struct crypto_options *co, =
const struct frame *frame)
 {
     int i, j;
     struct gc_arena gc =3D gc=
_new();
diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index =
ee5b50f=2E=2Ee3c1c6a 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/=
crypto=2Eh
@@ -414,7 +414,7 @@
  */
 int write_key_file(const int nkeys, co=
nst char *filename);
 
-bool check_key(struct key *key, const struct key_ty=
pe *kt);
+bool check_key(const struct key *key, const struct key_type *kt);=

 
 /**
  * Initialize a key_type structure with=2E
@@ -614,7 +614,7 @@
 /*=
* Print a cipher list entry */
 void print_cipher(const char *cipher);
 
-v=
oid test_crypto(struct crypto_options *co, struct frame *f);
+void test_cry=
pto(struct crypto_options *co, const struct frame *f);
 
 
 /* key directio=
n functions */
diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index=
 f5d409d=2E=2Efd56787 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dc=
o=2Ec
@@ -572,7 +572,7 @@
 }
 
 static bool
-dco_multi_get_localaddr(struct=
 multi_context *m, struct multi_instance *mi,
+dco_multi_get_localaddr(cons=
t struct multi_context *m, const struct multi_instance *mi,
               =
          struct sockaddr_storage *local)
 {
 #if ENABLE_IP_PKTINFO
@@ -584=
,7 +584,7 @@
         return false;
     }
 
-    struct link_socket_actual=
 *actual =3D &c->c2=2Elink_socket_infos[0]->lsa->actual;
+    const struct =
link_socket_actual *actual =3D &c->c2=2Elink_socket_infos[0]->lsa->actual;
=
 
     switch (actual->dest=2Eaddr=2Esa=2Esa_family)
     {
@@ -622,7 +622,=
7 @@
 }
 
 int
-dco_multi_add_new_peer(struct multi_context *m, struct mult=
i_instance *mi)
+dco_multi_add_new_peer(const struct multi_context *m, stru=
ct multi_instance *mi)
 {
     const struct context *c =3D &mi->context;
 
=
@@ -676,7 +676,7 @@
 }
 
 void
-dco_install_iroute(struct multi_context *m,=
 struct multi_instance *mi, struct mroute_addr *addr)
+dco_install_iroute(s=
truct multi_context *m, struct multi_instance *mi, const struct mroute_addr=
 *addr)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined=
(_WIN32)
     if (!dco_enabled(&m->top=2Eoptions))
@@ -795,7 +795,7 @@
    =
     /* Checked if we added a host route as the assigned client IP address =
was
          * outside the --ifconfig-ipv6 tun interface config */
 #if !d=
efined(_WIN32)
-        struct in6_addr *dest =3D &mi->context=2Ec2=2Epush_=
ifconfig_ipv6_local;
+        const struct in6_addr *dest =3D &mi->context=
=2Ec2=2Epush_ifconfig_ipv6_local;
         if (multi_check_push_ifconfig_ip=
v6_extra_route(mi, dest))
         {
             /* On windows we do not i=
nstall these routes, so we also do not need to delete them */
diff --git a/=
src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index 4e5aad5=2E=2E694875c 100644=

--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -204,7 +204,7 @@
  =
* @param mi        the client instance
  * @return          0 on success or=
 a negative error code otherwise
  */
-int dco_multi_add_new_peer(struct mu=
lti_context *m, struct multi_instance *mi);
+int dco_multi_add_new_peer(con=
st struct multi_context *m, struct multi_instance *mi);
 
 /**
  * Install =
an iroute in DCO, which means adding a route to the system routing
@@ -215,=
7 +215,7 @@
  * @param addr      the route to add
  */
 void dco_install_ir=
oute(struct multi_context *m, struct multi_instance *mi,
-                 =
       struct mroute_addr *addr);
+                        const struct mro=
ute_addr *addr);
 
 /**
  * Remove all routes added through the specified c=
lient
@@ -253,7 +253,7 @@
  * a 64 bit packet counter and AEAD tag at the e=
nd=2E
  */
 bool
-dco_supports_epoch_data(struct context *c);
+dco_supports=
_epoch_data(const struct context *c);
 #else  /* if defined(ENABLE_DCO) */
=
 
 typedef void *dco_context_t;
@@ -350,7 +350,7 @@
 }
 
 static inline int=

-dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi=
)
+dco_multi_add_new_peer(const struct multi_context *m, struct multi_insta=
nce *mi)
 {
     return 0;
 }
@@ -384,7 +384,7 @@
 }
 
 static inline bool
=
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(const =
struct context *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_fr=
eebsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index d933aaf=2E=2E7346903 100644
-=
-- a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -930,=
7 +930,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_sup=
ports_epoch_data(const struct context *c)
 {
     return false;
 }
diff --g=
it a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh
index fcf8=
aca=2E=2E1022e66 100644
--- a/src/openvpn/dco_internal=2Eh
+++ b/src/openvp=
n/dco_internal=2Eh
@@ -59,8 +59,9 @@
  * They are implemented by dco_linux=
=2Ec
  */
 
-int dco_new_peer(dco_context_t *dco, unsigned int peerid, sock=
et_descriptor_t sd, struct sockaddr *localaddr,
-                 struct so=
ckaddr *remoteaddr, const struct in_addr *vpn_ipv4, const struct in6_addr *=
vpn_ipv6);
+int dco_new_peer(dco_context_t *dco, unsigned int peerid, socke=
t_descriptor_t sd,
+                 struct sockaddr *localaddr, struct soc=
kaddr *remoteaddr,
+                 const struct in_addr *vpn_ipv4, const =
struct in6_addr *vpn_ipv6);
 
 int dco_del_peer(dco_context_t *dco, unsigne=
d int peerid);
 
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_l=
inux=2Ec
index 56f6259=2E=2E31bbe87 100644
--- a/src/openvpn/dco_linux=2Ec
=
+++ b/src/openvpn/dco_linux=2Ec
@@ -114,7 +114,7 @@
 }
 
 static struct nl_=
msg *
-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)
+ovpn_dco_nlm=
sg_create(const dco_context_t *dco, uint8_t cmd)
 {
     struct nl_msg *nl_=
msg =3D nlmsg_alloc();
     if (!nl_msg)
@@ -804,7 +804,7 @@
 
 /* libnl < =
3=2E11=2E0 does not implement nla_get_uint() */
 static uint64_t
-ovpn_nla_=
get_uint(struct nlattr *attr)
+ovpn_nla_get_uint(const struct nlattr *attr)=

 {
     if (nla_len(attr) =3D=3D sizeof(uint32_t))
     {
@@ -916,7 +916,7=
 @@
 }
 
 static bool
-ovpn_iface_check(dco_context_t *dco, struct nlattr *=
attrs[])
+ovpn_iface_check(const dco_context_t *dco, struct nlattr *attrs[]=
)
 {
     /* we must know which interface this message is referring to in o=
rder to
      * avoid mixing messages for other instances
@@ -1340,7 +1340,=
7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_e=
poch_data(const struct context *c)
 {
     return false;
 }
diff --git a/sr=
c/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index b3268bc=2E=2E8deb9d8 =
100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -1100=
,7 +1100,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_s=
upports_epoch_data(const struct context *c)
 {
     OVPN_VERSION ver =3D { =
0 };
     return dco_get_version(&ver) && ((ver=2EMajor =3D=3D 2 && ver=2EM=
inor >=3D 8) || (ver=2EMajor > 2));
diff --git a/src/openvpn/dhcp=2Ec b/src=
/openvpn/dhcp=2Ec
index a54ab3f=2E=2E68173e6 100644
--- a/src/openvpn/dhcp=
=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -145,7 +145,7 @@
 }
 
 in_addr_t
-dhcp_e=
xtract_router_msg(struct buffer *ipbuf)
+dhcp_extract_router_msg(const stru=
ct buffer *ipbuf)
 {
     struct dhcp_full *df =3D (struct dhcp_full *)BPTR=
(ipbuf);
     const int optlen =3D
diff --git a/src/openvpn/dhcp=2Eh b/src/=
openvpn/dhcp=2Eh
index 38ebf8d=2E=2Eed8a0c9 100644
--- a/src/openvpn/dhcp=
=2Eh
+++ b/src/openvpn/dhcp=2Eh
@@ -91,7 +91,7 @@
 
 #pragma pack()
 
-in_a=
ddr_t dhcp_extract_router_msg(struct buffer *ipbuf);
+in_addr_t dhcp_extrac=
t_router_msg(const struct buffer *ipbuf);
 
 #if defined(_WIN32) || defined=
(DHCP_UNIT_TEST)
 #include "tun=2Eh"
diff --git a/src/openvpn/event=2Eh b/s=
rc/openvpn/event=2Eh
index b784dfe=2E=2E0940a1d 100644
--- a/src/openvpn/ev=
ent=2Eh
+++ b/src/openvpn/event=2Eh
@@ -204,7 +204,7 @@
 #else /* ifdef _WI=
N32 */
 
 static inline void
-wait_signal(struct event_set *es, void *arg)
=
+wait_signal(const struct event_set *es, const void *arg)
 {
 }
 
diff --gi=
t a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 6581998=2E=2E4d=
dac11 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@=
 -231,7 +231,7 @@
 }
 
 static void
-parse_incoming_control_channel_command=
(struct context *c, struct buffer *buf)
+parse_incoming_control_channel_com=
mand(struct context *c, const struct buffer *buf)
 {
     if (buf_string_ma=
tch_head_str(buf, "AUTH_FAILED"))
     {
@@ -501,7 +501,7 @@
 }
 
 int
-get=
_server_poll_remaining_time(struct event_timeout *server_poll_timeout)
+get=
_server_poll_remaining_time(const struct event_timeout *server_poll_timeout=
)
 {
     update_time();
     int remaining =3D event_timeout_remaining(ser=
ver_poll_timeout);
@@ -598,7 +598,7 @@
  * Buffer reallocation, for use wit=
h null encryption=2E
  */
 static inline void
-buffer_turnover(const uint8_=
t *orig_buf, struct buffer *dest_stub, struct buffer *src_stub,
+buffer_tur=
nover(const uint8_t *orig_buf, struct buffer *dest_stub, const struct buffe=
r *src_stub,
                 struct buffer *storage)
 {
     if (orig_buf =
=3D=3D src_stub->data && src_stub->data !=3D storage->data)
@@ -885,7 +885,=
7 @@
  */
 
 static inline void
-socks_postprocess_incoming_link(struct con=
text *c, struct link_socket *sock)
+socks_postprocess_incoming_link(struct =
context *c, const struct link_socket *sock)
 {
     if (sock->socks_proxy &=
& sock->info=2Eproto =3D=3D PROTO_UDP)
     {
@@ -982,7 +982,7 @@
 }
 
 boo=
l
-process_incoming_link_part1(struct context *c, struct link_socket_info *=
lsi, bool floated)
+process_incoming_link_part1(struct context *c, const st=
ruct link_socket_info *lsi, bool floated)
 {
     struct gc_arena gc =3D gc=
_new();
     bool decrypt_status =3D false;
@@ -1532,7 +1532,7 @@
  * @para=
m client    Determines whether to the send packet back via tun or link
  */=

 void
-ipv6_send_icmp_unreachable(struct context *c, struct buffer *buf, b=
ool client)
+ipv6_send_icmp_unreachable(struct context *c, const struct buf=
fer *buf, bool client)
 {
 #define MAX_ICMPV6LEN 1280
     struct openvpn_i=
cmp6hdr icmp6out;
diff --git a/src/openvpn/forward=2Eh b/src/openvpn/forwar=
d=2Eh
index 324c0b4=2E=2Eee7d2e2 100644
--- a/src/openvpn/forward=2Eh
+++ b=
/src/openvpn/forward=2Eh
@@ -127,7 +127,7 @@
  */
 void encrypt_sign(struct=
 context *c, bool comp_frag);
 
-int get_server_poll_remaining_time(struct =
event_timeout *server_poll_timeout);
+int get_server_poll_remaining_time(co=
nst struct event_timeout *server_poll_timeout);
 
 /***********************=
***********************************************/
 /**
@@ -178,7 +178,7 @@
 =
 *
  * @return true if packet is authenticated, false otherwise=2E
  */
-bo=
ol process_incoming_link_part1(struct context *c, struct link_socket_info *=
lsi, bool floated);
+bool process_incoming_link_part1(struct context *c, co=
nst struct link_socket_info *lsi, bool floated);
 
 /**
  * Continues proce=
ssing a packet read from the external network interface=2E
diff --git a/src=
/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 218a663=2E=2E11042f0 100644
=
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -818,7 +818,7 @@
 =
}
 
 static void
-init_port_share(struct context *c)
+init_port_share(const=
 struct context *c)
 {
     if (!port_share && (c->options=2Eport_share_hos=
t && c->options=2Eport_share_port))
     {
@@ -1265,7 +1265,7 @@
  * prepen=
ding to msg() output=2E
  */
 const char *
-format_common_name(struct conte=
xt *c, struct gc_arena *gc)
+format_common_name(const struct context *c, st=
ruct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
   =
  if (c->c2=2Etls_multi)
@@ -1751,7 +1751,7 @@
 
 
 static bool
-can_preser=
ve_tun(struct tuntap *tt)
+can_preserve_tun(const struct tuntap *tt)
 {
   =
  if (tt && tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -1773,7 +177=
3,7 @@
  * @param c pointer to the connection context
  */
 static void
-ad=
d_wfp_block(struct context *c)
+add_wfp_block(const struct context *c)
 {
 =
#if defined(_WIN32)
     /* Fortify 'redirect-gateway block-local' with fir=
ewall rules? */
@@ -1799,7 +1799,7 @@
  * @param adapter_index the VPN adap=
ter index
  */
 static void
-del_wfp_block(struct context *c, unsigned long=
 adapter_index)
+del_wfp_block(const struct context *c, unsigned long adapt=
er_index)
 {
 #if defined(_WIN32)
     if (c->options=2Eblock_outside_dns |=
| block_local_needed(c->c1=2Eroute_list))
diff --git a/src/openvpn/init=2Eh=
 b/src/openvpn/init=2Eh
index 9d5050d=2E=2Eaf4393c 100644
--- a/src/openvpn=
/init=2Eh
+++ b/src/openvpn/init=2Eh
@@ -91,7 +91,7 @@
 
 unsigned int pull=
_permission_mask(const struct context *c);
 
-const char *format_common_nam=
e(struct context *c, struct gc_arena *gc);
+const char *format_common_name(=
const struct context *c, struct gc_arena *gc);
 
 void reset_coarse_timers(=
struct context *c);
 
diff --git a/src/openvpn/interval=2Eh b/src/openvpn/i=
nterval=2Eh
index 59051bd=2E=2E0cfe202 100644
--- a/src/openvpn/interval=2E=
h
+++ b/src/openvpn/interval=2Eh
@@ -89,7 +89,7 @@
 }
 
 static inline void=

-interval_schedule_wakeup(struct interval *top, interval_t *wakeup)
+inter=
val_schedule_wakeup(const struct interval *top, interval_t *wakeup)
 {
    =
 const time_t local_now =3D now;
     interval_earliest_wakeup(wakeup, top-=
>last_test_true + top->refresh, local_now);
@@ -214,7 +214,7 @@
  * This fu=
nction does not check if the timeout is actually valid=2E
  */
 static inli=
ne interval_t
-event_timeout_remaining(struct event_timeout *et)
+event_tim=
eout_remaining(const struct event_timeout *et)
 {
     return (interval_t)(=
(et->last + et->n) - now);
 }
diff --git a/src/openvpn/list=2Ec b/src/openv=
pn/list=2Ec
index 2553579=2E=2E45b4f54 100644
--- a/src/openvpn/list=2Ec
++=
+ b/src/openvpn/list=2Ec
@@ -167,7 +167,7 @@
 }
 
 void
-hash_remove_by_val=
ue(struct hash *hash, void *value)
+hash_remove_by_value(struct hash *hash,=
 const void *value)
 {
     struct hash_iterator hi;
     const struct hash=
_element *he;
diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
inde=
x cbf1abf=2E=2E07df3c14 100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn=
/list=2Eh
@@ -78,7 +78,7 @@
 
 bool hash_remove_fast(struct hash *hash, str=
uct hash_bucket *bucket, const void *key, uint64_t hv);
 
-void hash_remove=
_by_value(struct hash *hash, void *value);
+void hash_remove_by_value(struc=
t hash *hash, const void *value);
 
 struct hash_iterator
 {
diff --git a/s=
rc/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 604bbcd=2E=2E17abfd8 1=
00644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -330,7 +=
330,7 @@
 }
 
 static void
-man_delete_unix_socket(struct management *man)
=
+man_delete_unix_socket(const struct management *man)
 {
 #if UNIX_SOCK_SUP=
PORT
     if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT=
)) =3D=3D MF_UNIX_SOCK)
@@ -675,7 +675,7 @@
  * for the log and echo comman=
ds=2E
  */
 static void
-man_history(struct management *man, const char *pa=
rm, const char *type, struct log_history *log,
+man_history(struct manageme=
nt *man, const char *parm, const char *type, const struct log_history *log,=

             bool *realtime, const unsigned int lep_flags)
 {
     struct =
gc_arena gc =3D gc_new();
@@ -843,7 +843,7 @@
 }
 
 static void
-man_forget=
_passwords(struct management *man)
+man_forget_passwords(const struct manag=
ement *man)
 {
     ssl_purge_auth(false);
     (void)ssl_clean_auth_token(=
);
@@ -851,7 +851,7 @@
 }
 
 static void
-man_net(struct management *man)
+=
man_net(const struct management *man)
 {
     if (man->persist=2Ecallback=
=2Eshow_net)
     {
@@ -887,7 +887,7 @@
 #ifdef ENABLE_PKCS11
 
 static voi=
d
-man_pkcs11_id_count(struct management *man)
+man_pkcs11_id_count(const s=
truct management *man)
 {
     msg(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_m=
anagement_id_count());
 }
@@ -1350,7 +1350,7 @@
  * @return          Return=
 whether p has n (or at least n) parameters
  */
 static bool
-man_need(str=
uct management *man, const char **p, const int n, unsigned int flags)
+man_=
need(const struct management *man, const char **p, const int n, unsigned in=
t flags)
 {
     int i;
     ASSERT(p[0]);
@@ -2365,7 +2365,7 @@
  * the ro=
ute/ifconfig/open tun command=2E   See doc/android=2Etxt for details=2E
  *=
/
 bool
-management_android_control(struct management *man, const char *com=
mand, const char *msg)
+management_android_control(const struct management =
*man, const char *command, const char *msg)
 {
     if (!man)
     {
@@ -30=
13,7 +3013,7 @@
 }
 
 void
-management_up_down(struct management *man, cons=
t char *updown, const struct env_set *es)
+management_up_down(const struct =
management *man, const char *updown, const struct env_set *es)
 {
     if (=
man->settings=2Eflags & MF_UP_DOWN)
     {
@@ -3023,13 +3023,13 @@
 }
 
 vo=
id
-management_notify(struct management *man, const char *severity, const c=
har *type, const char *text)
+management_notify(const struct management *ma=
n, const char *severity, const char *type, const char *text)
 {
     msg(M_=
CLIENT, ">NOTIFY:%s,%s,%s", severity, type, text);
 }
 
 void
-management_n=
otify_generic(struct management *man, const char *str)
+management_notify_g=
eneric(const struct management *man, const char *str)
 {
     msg(M_CLIENT,=
 "%s", str);
 }
@@ -3115,7 +3115,8 @@
 }
 
 void
-management_notify_client_=
close(struct management *management, struct man_def_auth_context *mdac,
+ma=
nagement_notify_client_close(const struct management *management,
+        =
                       struct man_def_auth_context *mdac,
                 =
               const struct env_set *es)
 {
     if ((mdac->flags & DAF_INI=
TIAL_AUTH) && !(mdac->flags & DAF_CONNECTION_CLOSED))
@@ -3206,7 +3207,7 @@=

 }
 
 void
-management_auth_failure(struct management *man, const char *ty=
pe, const char *reason)
+management_auth_failure(const struct management *m=
an, const char *type, const char *reason)
 {
     if (reason)
     {
@@ -32=
19,7 +3220,7 @@
 }
 
 void
-management_auth_token(struct management *man, c=
onst char *token)
+management_auth_token(const struct management *man, cons=
t char *token)
 {
     msg(M_CLIENT, ">PASSWORD:Auth-Token:%s", token);
 }
=
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 1be3549=
=2E=2E71680a6 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=
=2Eh
@@ -362,7 +362,7 @@
                                 const unsigned in=
t flags, const char *static_challenge);
 
 #ifdef TARGET_ANDROID
-bool mana=
gement_android_control(struct management *man, const char *command, const c=
har *msg);
+bool management_android_control(const struct management *man, c=
onst char *command, const char *msg);
 
 #define ANDROID_KEEP_OLD_TUN      =
1
 #define ANDROID_OPEN_BEFORE_CLOSE 2
@@ -376,12 +376,12 @@
 
 void manage=
ment_event_loop_n_seconds(struct management *man, int sec);
 
-void managem=
ent_up_down(struct management *man, const char *updown, const struct env_se=
t *es);
+void management_up_down(const struct management *man, const char *=
updown, const struct env_set *es);
 
-void management_notify(struct managem=
ent *man, const char *severity, const char *type,
+void management_notify(c=
onst struct management *man, const char *severity, const char *type,
      =
                  const char *text);
 
-void management_notify_generic(stru=
ct management *man, const char *str);
+void management_notify_generic(const=
 struct management *man, const char *str);
 
 void management_notify_client=
_needing_auth(struct management *management,
                              =
              const unsigned int auth_id,
@@ -391,7 +391,7 @@
 void managem=
ent_connection_established(struct management *management,
                 =
                       struct man_def_auth_context *mdac, const struct env_=
set *es);
 
-void management_notify_client_close(struct management *managem=
ent,
+void management_notify_client_close(const struct management *manageme=
nt,
                                     struct man_def_auth_context *mdac,=
 const struct env_set *es);
 
 void management_learn_addr(struct management=
 *management, struct man_def_auth_context *mdac,
@@ -476,12 +476,12 @@
  * =
OpenVPN calls here to indicate a password failure
  */
 
-void management_a=
uth_failure(struct management *man, const char *type, const char *reason);
=
+void management_auth_failure(const struct management *man, const char *typ=
e, const char *reason);
 
 /*
  * Echo an authentication token to managemen=
t interface
  */
-void management_auth_token(struct management *man, const =
char *token);
+void management_auth_token(const struct management *man, con=
st char *token);
 
 /*
  * These functions drive the bytecount in/out count=
ers=2E
diff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec
index 7b790=
ed=2E=2E9a37e30 100644
--- a/src/openvpn/mbuf=2Ec
+++ b/src/openvpn/mbuf=2E=
c
@@ -149,7 +149,7 @@
 }
 
 void
-mbuf_dereference_instance(struct mbuf_set=
 *ms, struct multi_instance *mi)
+mbuf_dereference_instance(struct mbuf_set=
 *ms, const struct multi_instance *mi)
 {
     if (ms)
     {
diff --git a/=
src/openvpn/mbuf=2Eh b/src/openvpn/mbuf=2Eh
index cfe698c=2E=2Ee368054 1006=
44
--- a/src/openvpn/mbuf=2Eh
+++ b/src/openvpn/mbuf=2Eh
@@ -75,7 +75,7 @@
=
 
 bool mbuf_extract_item(struct mbuf_set *ms, struct mbuf_item *item);
 
-=
void mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance *=
mi);
+void mbuf_dereference_instance(struct mbuf_set *ms, const struct mult=
i_instance *mi);
 
 static inline bool
 mbuf_defined(const struct mbuf_set =
*ms)
diff --git a/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec
index 36bbb43=
=2E=2Ea7242a8 100644
--- a/src/openvpn/mss=2Ec
+++ b/src/openvpn/mss=2Ec
@@=
 -43,7 +43,7 @@
  *              if yes, hand to mss_fixup_dowork()
  */
 v=
oid
-mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss)
+mss_fixup_ipv4(co=
nst struct buffer *buf, uint16_t maxmss)
 {
     const struct openvpn_iphdr=
 *pip;
     int hlen;
@@ -80,7 +80,7 @@
  *              (IPv6 header struc=
ture is sufficiently different from IPv4=2E=2E=2E)
  */
 void
-mss_fixup_ip=
v6(struct buffer *buf, uint16_t maxmss)
+mss_fixup_ipv6(const struct buffer=
 *buf, uint16_t maxmss)
 {
     const struct openvpn_ipv6hdr *pip6;
     st=
ruct buffer newbuf;
@@ -136,7 +136,7 @@
  */
 
 void
-mss_fixup_dowork(stru=
ct buffer *buf, uint16_t maxmss)
+mss_fixup_dowork(const struct buffer *buf=
, uint16_t maxmss)
 {
     int olen, optlen;
     uint8_t *opt;
@@ -239,8 +=
239,8 @@
 }
 
 static void
-frame_calculate_fragment(struct frame *frame, s=
truct key_type *kt, const struct options *options,
-                       =
  struct link_socket_info *lsi)
+frame_calculate_fragment(struct frame *fra=
me, const struct key_type *kt, const struct options *options,
+            =
             const struct link_socket_info *lsi)
 {
 #if defined(ENABLE_FRA=
GMENT)
     size_t overhead;
@@ -269,8 +269,8 @@
 }
 
 static void
-frame_c=
alculate_mssfix(struct frame *frame, struct key_type *kt, const struct opti=
ons *options,
-                       struct link_socket_info *lsi)
+frame_=
calculate_mssfix(struct frame *frame, const struct key_type *kt, const stru=
ct options *options,
+                       const struct link_socket_info =
*lsi)
 {
     if (options->ce=2Emssfix_fixed)
     {
@@ -314,8 +314,8 @@
 }=

 
 void
-frame_calculate_dynamic(struct frame *frame, struct key_type *kt,=
 const struct options *options,
-                        struct link_socket=
_info *lsi)
+frame_calculate_dynamic(struct frame *frame, const struct key_=
type *kt, const struct options *options,
+                        const str=
uct link_socket_info *lsi)
 {
     if (options->ce=2Efragment > 0)
     {
d=
iff --git a/src/openvpn/mss=2Eh b/src/openvpn/mss=2Eh
index 1d092bb=2E=2E6b=
832a2 100644
--- a/src/openvpn/mss=2Eh
+++ b/src/openvpn/mss=2Eh
@@ -29,15 =
+29,15 @@
 #include "socket=2Eh"
 #include "ssl_common=2Eh"
 
-void mss_fix=
up_ipv4(struct buffer *buf, uint16_t maxmss);
+void mss_fixup_ipv4(const st=
ruct buffer *buf, uint16_t maxmss);
 
-void mss_fixup_ipv6(struct buffer *b=
uf, uint16_t maxmss);
+void mss_fixup_ipv6(const struct buffer *buf, uint16=
_t maxmss);
 
-void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);
=
+void mss_fixup_dowork(const struct buffer *buf, uint16_t maxmss);
 
 /** S=
et the --mssfix option=2E */
-void frame_calculate_dynamic(struct frame *fr=
ame, struct key_type *kt,
-                             const struct option=
s *options, struct link_socket_info *lsi);
+void frame_calculate_dynamic(st=
ruct frame *frame, const struct key_type *kt,
+                            =
 const struct options *options, const struct link_socket_info *lsi);
 
 /**=

  * Checks and adjusts the fragment and mssfix value according to the
diff=
 --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 5d88f8a=2E=2E922=
db3f 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -91,7 =
+91,7 @@
 }
 
 bool
-multi_tcp_instance_specific_init(struct multi_context =
*m, struct multi_instance *mi)
+multi_tcp_instance_specific_init(const stru=
ct multi_context *m, struct multi_instance *mi)
 {
     /* buffer for queue=
d TCP socket output packets */
     mi->tcp_link_out_deferred =3D mbuf_init=
(m->top=2Eoptions=2En_bcast_buf);
diff --git a/src/openvpn/mtcp=2Eh b/src/o=
penvpn/mtcp=2Eh
index 9b7d1d2=2E=2Ebb117fa 100644
--- a/src/openvpn/mtcp=2E=
h
+++ b/src/openvpn/mtcp=2Eh
@@ -35,7 +35,7 @@
 
 void multi_tcp_dereferenc=
e_instance(struct multi_io *multi_io, struct multi_instance *mi);
 
-bool m=
ulti_tcp_instance_specific_init(struct multi_context *m, struct multi_insta=
nce *mi);
+bool multi_tcp_instance_specific_init(const struct multi_context=
 *m, struct multi_instance *mi);
 
 void multi_tcp_instance_specific_free(s=
truct multi_instance *mi);
 
diff --git a/src/openvpn/mudp=2Ec b/src/openvp=
n/mudp=2Ec
index def4769=2E=2E02f111d 100644
--- a/src/openvpn/mudp=2Ec
+++=
 b/src/openvpn/mudp=2Ec
@@ -74,7 +74,7 @@
 
 static void
 send_hmac_reset_p=
acket(struct multi_context *m, struct tls_pre_decrypt_state *state,
-      =
                 struct tls_auth_standalone *tas, struct session_id *sid,
+=
                       const struct tls_auth_standalone *tas, const struct =
session_id *sid,
                        bool request_resend_wkc, struct li=
nk_socket *sock)
 {
     reset_packet_id_send(&state->tls_wrap_tmp=2Eopt=2E=
packet_id=2Esend);
@@ -97,7 +97,7 @@
 
     enum first_packet_verdict verdi=
ct;
 
-    struct tls_auth_standalone *tas =3D m->top=2Ec2=2Etls_auth_stand=
alone;
+    const struct tls_auth_standalone *tas =3D m->top=2Ec2=2Etls_aut=
h_standalone;
 
     verdict =3D tls_pre_decrypt_lite(tas, state, &m->top=
=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
diff --git a/src/openvpn/multi=2Ec b/s=
rc/openvpn/multi=2Ec
index 862d5da=2E=2Efae3d5f 100644
--- a/src/openvpn/mu=
lti=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -57,7 +57,7 @@
 
 #ifdef MULTI_DEBUG=
_EVENT_LOOP
 static const char *
-id(struct multi_instance *mi)
+id(const s=
truct multi_instance *mi)
 {
     if (mi)
     {
@@ -1315,7 +1315,7 @@
  * =
same common name=2E
  */
 static void
-multi_delete_dup(struct multi_contex=
t *m, struct multi_instance *new_mi)
+multi_delete_dup(struct multi_context=
 *m, const struct multi_instance *new_mi)
 {
     if (new_mi)
     {
@@ -22=
60,7 +2260,7 @@
 }
 
 static bool
-multi_client_setup_dco_initial(struct mu=
lti_context *m, struct multi_instance *mi,
+multi_client_setup_dco_initial(=
const struct multi_context *m, struct multi_instance *mi,
                 =
               struct gc_arena *gc)
 {
     if (!dco_enabled(&mi->context=
=2Eoptions))
@@ -3195,7 +3195,7 @@
 
 #if defined(ENABLE_DCO)
 static void
=
-process_incoming_del_peer(struct multi_context *m, struct multi_instance *=
mi, dco_context_t *dco)
+process_incoming_del_peer(struct multi_context *m,=
 struct multi_instance *mi, const dco_context_t *dco)
 {
     const char *r=
eason =3D "ovpn-dco: unknown reason";
     switch (dco->dco_del_peer_reason=
)
@@ -4239,7 +4239,7 @@
 
 /* Searches for the address and deletes it if it=
 is owned by the multi_instance */
 static void
-multi_unlearn_addr(struct =
multi_context *m, struct multi_instance *mi, const struct mroute_addr *addr=
)
+multi_unlearn_addr(struct multi_context *m, const struct multi_instance =
*mi, const struct mroute_addr *addr)
 {
     struct hash_element *he;
     =
const uint64_t hv =3D hash_value(m->vhash, addr);
@@ -4274,7 +4274,7 @@
  *=
 @param a     The new IPv4 address in network byte order
  */
 static void
=
-multi_unlearn_in_addr_t(struct multi_context *m, struct multi_instance *mi=
, in_addr_t a)
+multi_unlearn_in_addr_t(struct multi_context *m, const stru=
ct multi_instance *mi, in_addr_t a)
 {
     struct mroute_addr addr;
     C=
LEAR(addr);
@@ -4292,7 +4292,7 @@
  * @param a6    The new IPv6 address
  *=
/
 static void
-multi_unlearn_in6_addr(struct multi_context *m, struct mult=
i_instance *mi, struct in6_addr a6)
+multi_unlearn_in6_addr(struct multi_co=
ntext *m, const struct multi_instance *mi, struct in6_addr a6)
 {
     stru=
ct mroute_addr addr;
     CLEAR(addr);
@@ -4408,7 +4408,7 @@
 
 bool
 multi=
_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
-         =
                                  struct in6_addr *dest)
+                 =
                          const struct in6_addr *dest)
 {
     const struct=
 options *o =3D &mi->context=2Eoptions;
 
diff --git a/src/openvpn/multi=2E=
h b/src/openvpn/multi=2Eh
index 8b837fa=2E=2Ec285fc3 100644
--- a/src/openv=
pn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -516,7 +516,7 @@
  */
 
 static=
 inline void
-set_prefix(struct multi_instance *mi)
+set_prefix(const struc=
t multi_instance *mi)
 {
 #ifdef MULTI_DEBUG_EVENT_LOOP
     if (mi->msg_pr=
efix[0])
@@ -690,7 +690,7 @@
  */
 bool
 multi_check_push_ifconfig_ipv6_ext=
ra_route(struct multi_instance *mi,
-                                      =
     struct in6_addr *dest);
+                                           co=
nst struct in6_addr *dest);
 
 /*
  * Check for signals=2E
diff --git a/src=
/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
index bce0c19=2E=2E252=
33c8 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networking=
=2Eh
@@ -44,7 +44,7 @@
  */
 #if !defined(ENABLE_IPROUTE)
 static inline in=
t
-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+net_ctx_init(co=
nst struct context *c, openvpn_net_ctx_t *ctx)
 {
     (void)c;
     (void)=
ctx;
@@ -75,7 +75,7 @@
  *
  * @return          0 on success, a negative er=
ror code otherwise
  */
-int net_ctx_init(struct context *c, openvpn_net_ct=
x_t *ctx);
+int net_ctx_init(const struct context *c, openvpn_net_ctx_t *ct=
x);
 
 /**
  * Release resources allocated by the internal garbage collecto=
r
@@ -102,7 +102,7 @@
  * @return          0 on success, negative error cod=
e on error
  */
 int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_ne=
t_iface_t *iface, const char *type,
-                  void *arg);
+       =
           const void *arg);
 
 /**
  * Retrieve the interface type
diff --=
git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=
=2Ec
index a1f3525=2E=2Ef091fb3 100644
--- a/src/openvpn/networking_iproute=
2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -36,7 +36,7 @@
 #include=
 <netinet/in=2Eh>
 
 int
-net_ctx_init(struct context *c, openvpn_net_ctx_t=
 *ctx)
+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)
 {
  =
   ctx->es =3D NULL;
     if (c)
@@ -61,7 +61,7 @@
 }
 
 int
-net_iface_new=
(openvpn_net_ctx_t *ctx, const char *iface, const char *type, void *arg)
+n=
et_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, c=
onst void *arg)
 {
     struct argv argv =3D argv_new();
 
diff --git a/src=
/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index e6e7=
2d0=2E=2Ea1d220f 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/op=
envpn/networking_sitnl=2Ec
@@ -987,7 +987,7 @@
 }
 
 static int
-sitnl_addr=
_del(sa_family_t af_family, const char *iface, inet_address_t *addr, int pr=
efixlen)
+sitnl_addr_del(sa_family_t af_family, const char *iface, const in=
et_address_t *addr, int prefixlen)
 {
     int ifindex;
 
@@ -1230,8 +1230,=
8 @@
 }
 
 static int
-sitnl_route_del(const char *iface, sa_family_t af_fa=
mily, inet_address_t *dst, int prefixlen,
-                inet_address_t *=
gw, uint32_t table, int metric)
+sitnl_route_del(const char *iface, sa_fami=
ly_t af_family, const inet_address_t *dst, int prefixlen,
+                =
const inet_address_t *gw, uint32_t table, int metric)
 {
     int ifindex =
=3D 0;
 
@@ -1308,7 +1308,7 @@
 
 
 int
-net_iface_new(openvpn_net_ctx_t *c=
tx, const char *iface, const char *type, void *arg)
+net_iface_new(openvpn_=
net_ctx_t *ctx, const char *iface, const char *type, const void *arg)
 {
  =
   struct sitnl_link_req req =3D {};
     int ret =3D -1;
diff --git a/src/=
openvpn/occ=2Eh b/src/openvpn/occ=2Eh
index bda4f18=2E=2E49def4d 100644
---=
 a/src/openvpn/occ=2Eh
+++ b/src/openvpn/occ=2Eh
@@ -156,7 +156,7 @@
  * vi=
a control channel=2E
  * @return control channel exit message should be use=
d */
 static inline bool
-cc_exit_notify_enabled(struct context *c)
+cc_exi=
t_notify_enabled(const struct context *c)
 {
     /* Check if we have TLS a=
ctive at all */
     if (!c->c2=2Etls_multi)
diff --git a/src/openvpn/opens=
sl_compat=2Eh b/src/openvpn/openssl_compat=2Eh
index 098bdd5=2E=2E1a934db 1=
00644
--- a/src/openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=
=2Eh
@@ -127,7 +127,7 @@
 /* Mimics the functions but only when the default=
 context without
  * options is chosen */
 static inline const EVP_CIPHER *=

-EVP_CIPHER_fetch(void *ctx, const char *algorithm, const char *properties=
)
+EVP_CIPHER_fetch(const void *ctx, const char *algorithm, const char *pro=
perties)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
@@ -135,7 +135,7 @=
@
 }
 
 static inline const EVP_MD *
-EVP_MD_fetch(void *ctx, const char *a=
lgorithm, const char *properties)
+EVP_MD_fetch(const void *ctx, const char=
 *algorithm, const char *properties)
 {
     ASSERT(!ctx);
     ASSERT(!pro=
perties);
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
in=
dex 5451f86=2E=2E5e74a41 100644
--- a/src/openvpn/options=2Ec
+++ b/src/ope=
nvpn/options=2Ec
@@ -3076,7 +3076,7 @@
 }
 
 static void
-options_postproce=
ss_mutate_le(struct connection_entry *ce, struct local_entry *le, int mode)=

+options_postprocess_mutate_le(const struct connection_entry *ce, struct l=
ocal_entry *le, int mode)
 {
     /* use the global port if none is specifi=
ed */
     if (!le->port)
@@ -5006,7 +5006,7 @@
 static bool
 verify_permis=
sion(const char *name, const char *file, int line, const uint64_t type,
   =
                const uint64_t allowed, uint64_t *found, const msglvl_t msg=
level,
-                  struct options *options, bool is_inline)
+       =
           const struct options *options, bool is_inline)
 {
     if (!(typ=
e & allowed))
     {
@@ -5573,7 +5573,7 @@
 }
 
 static void
-show_compress=
ion_warning(struct compress_options *info)
+show_compression_warning(const =
struct compress_options *info)
 {
     if (comp_non_stub_enabled(info))
   =
  {
diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_parse=
=2Ec
index 88ab4d2=2E=2E0e94522 100644
--- a/src/openvpn/options_parse=2Ec
=
+++ b/src/openvpn/options_parse=2Ec
@@ -258,7 +258,7 @@
 }
 
 static char *=

-read_inline_file(struct in_src *is, const char *close_tag, int *num_lines=
, struct gc_arena *gc)
+read_inline_file(const struct in_src *is, const cha=
r *close_tag, int *num_lines, struct gc_arena *gc)
 {
     char line[OPTION=
_LINE_SIZE];
     struct buffer buf =3D alloc_buf(8 * OPTION_LINE_SIZE);
@@=
 -302,7 +302,7 @@
 }
 
 static int
-check_inline_file(struct in_src *is, ch=
ar *p[], struct gc_arena *gc)
+check_inline_file(const struct in_src *is, c=
har *p[], struct gc_arena *gc)
 {
     int num_inline_lines =3D 0;
 
diff -=
-git a/src/openvpn/otime=2Ec b/src/openvpn/otime=2Ec
index 1608458=2E=2E5d3=
633c 100644
--- a/src/openvpn/otime=2Ec
+++ b/src/openvpn/otime=2Ec
@@ -66,=
7 +66,7 @@
 }
 
 void
-update_now_usec(struct timeval *tv)
+update_now_usec=
(const struct timeval *tv)
 {
     const time_t last =3D now;
     update_n=
ow(tv->tv_sec);
diff --git a/src/openvpn/otime=2Eh b/src/openvpn/otime=2Eh
=
index f02cc31=2E=2Ecc92bf7 100644
--- a/src/openvpn/otime=2Eh
+++ b/src/ope=
nvpn/otime=2Eh
@@ -65,7 +65,7 @@
 void update_now(const time_t system_time)=
;
 
 extern time_t now_usec;
-void update_now_usec(struct timeval *tv);
+vo=
id update_now_usec(const struct timeval *tv);
 
 static inline int
 openvpn=
_gettimeofday(struct timeval *tv, void *tz)
diff --git a/src/openvpn/proto=
=2Eh b/src/openvpn/proto=2Eh
index 3570582=2E=2E33bf4ea 100644
--- a/src/op=
envpn/proto=2Eh
+++ b/src/openvpn/proto=2Eh
@@ -248,7 +248,7 @@
  * and off=
set of IP header (via parameter)=2E
  */
 static inline int
-get_tun_ip_ver=
(int tunnel_type, struct buffer *buf, int *ip_hdr_offset)
+get_tun_ip_ver(i=
nt tunnel_type, const struct buffer *buf, int *ip_hdr_offset)
 {
     int i=
p_ver =3D -1;
 
diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
=
index 4de7615=2E=2Ed4e0a8b 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/ope=
nvpn/proxy=2Ec
@@ -527,8 +527,9 @@
 }
 
 static bool
-add_proxy_headers(str=
uct http_proxy_info *p, socket_descriptor_t sd, /* already open to proxy */=

-                  const char *host                                   /* o=
penvpn server remote */
+add_proxy_headers(const struct http_proxy_info *p,=

+                  socket_descriptor_t sd, /* already open to proxy */
+  =
                const char *host        /* openvpn server remote */
 )
 {
 =
    char buf[512];
@@ -597,8 +598,8 @@
                               socke=
t_descriptor_t sd, /* already open to proxy */
                            =
   const char *host,       /* openvpn server remote */
                    =
           const char *port,       /* openvpn server port */
-             =
                 struct event_timeout *server_poll_timeout, struct buffer *=
lookahead,
-                              struct signal_info *sig_info)
+  =
                            const struct event_timeout *server_poll_timeout=
,
+                              struct buffer *lookahead, struct signal_in=
fo *sig_info)
 {
     struct gc_arena gc =3D gc_new();
     char buf[512];
=
diff --git a/src/openvpn/proxy=2Eh b/src/openvpn/proxy=2Eh
index e662e7d=2E=
=2Ea2f4e47 100644
--- a/src/openvpn/proxy=2Eh
+++ b/src/openvpn/proxy=2Eh
@=
@ -89,7 +89,7 @@
                                    socket_descriptor_t sd=
, /* already open to proxy */
                                    const cha=
r *host,       /* openvpn server remote */
                                =
    const char *port,       /* openvpn server port */
-                    =
               struct event_timeout *server_poll_timeout,
+                =
                   const struct event_timeout *server_poll_timeout,
       =
                             struct buffer *lookahead, struct signal_info *=
sig_info);
 
 uint8_t *make_base64_string2(const uint8_t *str, int str_len,=
 struct gc_arena *gc);
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec=

index 57afacd=2E=2E0e581e5 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openv=
pn/ps=2Ec
@@ -332,7 +332,7 @@
  * the proxy can determine true client origi=
n=2E
  */
 static void
-journal_add(const char *journal_dir, struct proxy_c=
onnection *pc, struct proxy_connection *cp)
+journal_add(const char *journa=
l_dir, const struct proxy_connection *pc, struct proxy_connection *cp)
 {
 =
    struct openvpn_sockaddr from, to;
 
@@ -410,7 +410,7 @@
 static bool
 p=
roxy_entry_new(struct proxy_connection **list, struct event_set *es,
      =
           const struct openvpn_sockaddr server_addr, const socket_descript=
or_t sd_client,
-                struct buffer *initial_data, const char *j=
ournal_dir)
+                const struct buffer *initial_data, const char =
*journal_dir)
 {
     socket_descriptor_t sd_server;
     int status;
@@ -1=
013,7 +1013,7 @@
  * call=2E
  */
 void
-port_share_redirect(struct port_sh=
are *ps, const struct buffer *head, socket_descriptor_t sd)
+port_share_red=
irect(const struct port_share *ps, const struct buffer *head, socket_descri=
ptor_t sd)
 {
     if (ps)
     {
diff --git a/src/openvpn/ps=2Eh b/src/ope=
nvpn/ps=2Eh
index 557ecf5=2E=2E918ceb6 100644
--- a/src/openvpn/ps=2Eh
+++ =
b/src/openvpn/ps=2Eh
@@ -49,7 +49,7 @@
 
 bool is_openvpn_protocol(const st=
ruct buffer *buf);
 
-void port_share_redirect(struct port_share *ps, const=
 struct buffer *head, socket_descriptor_t sd);
+void port_share_redirect(co=
nst struct port_share *ps, const struct buffer *head, socket_descriptor_t s=
d);
 
 #endif /* if PORT_SHARE */
 #endif /* ifndef PS_H */
diff --git a/sr=
c/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 79f20e1=2E=2E2daee77 100644=

--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -430,7 +430,7 @@
=
 }
 
 bool
-send_auth_pending_messages(struct tls_multi *tls_multi, struct =
tls_session *session,
+send_auth_pending_messages(const struct tls_multi *t=
ls_multi, struct tls_session *session,
                            const ch=
ar *extra, unsigned int timeout)
 {
     struct key_state *ks =3D &session-=
>key[KS_PRIMARY];
diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
=
index dff945f=2E=2E39302f6 100644
--- a/src/openvpn/push=2Eh
+++ b/src/open=
vpn/push=2Eh
@@ -117,7 +117,7 @@
  * doc/management-notes=2Etxt under clien=
t-pending-auth for
  * more details on message format
  */
-bool send_auth_=
pending_messages(struct tls_multi *tls_multi, struct tls_session *session,
=
+bool send_auth_pending_messages(const struct tls_multi *tls_multi, struct =
tls_session *session,
                                 const char *extra, u=
nsigned int timeout);
 
 void send_restart(struct context *c, const char *k=
ill_msg);
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2E=
c
index af22af5=2E=2E008d45f 100644
--- a/src/openvpn/push_util=2Ec
+++ b/s=
rc/openvpn/push_util=2Ec
@@ -222,7 +222,7 @@
 
 /* Return true if the clien=
t supports push-update */
 static bool
-support_push_update(struct multi_in=
stance *mi)
+support_push_update(const struct multi_instance *mi)
 {
     A=
SSERT(mi->context=2Ec2=2Etls_multi);
     const unsigned int iv_proto_peer =
=3D extract_iv_proto(mi->context=2Ec2=2Etls_multi->peer_info);
diff --git a=
/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index 52adacf=2E=2E358=
8483 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@=
@ -92,7 +92,7 @@
 
 /* check if a particular packet_id is present in ack */=

 static inline bool
-reliable_ack_packet_id_present(struct reliable_ack *a=
ck, packet_id_type pid)
+reliable_ack_packet_id_present(const struct reliab=
le_ack *ack, packet_id_type pid)
 {
     for (int i =3D 0; i < ack->len; ++=
i)
     {
@@ -733,7 +733,7 @@
  */
 
 void
-reliable_mark_active_incoming(s=
truct reliable *rel, struct buffer *buf, packet_id_type pid,
+reliable_mark=
_active_incoming(struct reliable *rel, const struct buffer *buf, packet_id_=
type pid,
                               int opcode)
 {
     for (int i =3D=
 0; i < rel->size; ++i)
@@ -793,7 +793,7 @@
 
 /* delete a buffer previousl=
y activated by reliable_mark_active() */
 void
-reliable_mark_deleted(struc=
t reliable *rel, struct buffer *buf)
+reliable_mark_deleted(struct reliable=
 *rel, const struct buffer *buf)
 {
     for (int i =3D 0; i < rel->size; +=
+i)
     {
diff --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh=

index a5ed75c=2E=2E8d9e2e3 100644
--- a/src/openvpn/reliable=2Eh
+++ b/src=
/openvpn/reliable=2Eh
@@ -173,7 +173,7 @@
  * @li False, if there are packe=
t IDs to be acknowledged=2E
  */
 static inline bool
-reliable_ack_empty(st=
ruct reliable_ack *ack)
+reliable_ack_empty(const struct reliable_ack *ack)=

 {
     return !ack->len;
 }
@@ -186,7 +186,7 @@
  * @returns the number o=
f outstanding acks
  */
 static inline int
-reliable_ack_outstanding(struct=
 reliable_ack *ack)
+reliable_ack_outstanding(const struct reliable_ack *ac=
k)
 {
     return ack->len;
 }
@@ -336,7 +336,7 @@
  * @param pid The packe=
t's packet ID=2E
  * @param opcode The packet's opcode=2E
  */
-void reliab=
le_mark_active_incoming(struct reliable *rel, struct buffer *buf, packet_id=
_type pid,
+void reliable_mark_active_incoming(struct reliable *rel, const =
struct buffer *buf, packet_id_type pid,
                                   =
 int opcode);
 
 /**
@@ -389,7 +389,7 @@
  * @param rel The reliable struct=
ure associated with the given buffer=2E
  * @param buf The buffer of the re=
liable entry which is to be removed=2E
  */
-void reliable_mark_deleted(str=
uct reliable *rel, struct buffer *buf);
+void reliable_mark_deleted(struct =
reliable *rel, const struct buffer *buf);
 
 /** @} name Functions for extr=
acting incoming packets */
 
diff --git a/src/openvpn/route=2Ec b/src/openv=
pn/route=2Ec
index 03a2526=2E=2E078bb7e 100644
--- a/src/openvpn/route=2Ec
=
+++ b/src/openvpn/route=2Ec
@@ -898,8 +898,9 @@
 }
 
 static bool
-add_bypa=
ss_routes(struct route_bypass *rb, in_addr_t gateway, const struct tuntap *=
tt,
-                  unsigned int flags, const struct route_gateway_info =
*rgi,
+add_bypass_routes(const struct route_bypass *rb, in_addr_t gateway,
=
+                  const struct tuntap *tt, unsigned int flags,
+          =
        const struct route_gateway_info *rgi,
                   const stru=
ct env_set *es, openvpn_net_ctx_t *ctx)
 {
     int ret =3D true;
@@ -916,8=
 +917,9 @@
 }
 
 static void
-del_bypass_routes(struct route_bypass *rb, in=
_addr_t gateway, const struct tuntap *tt,
-                  unsigned int f=
lags, const struct route_gateway_info *rgi,
+del_bypass_routes(const struct=
 route_bypass *rb, in_addr_t gateway,
+                  const struct tunta=
p *tt, unsigned int flags,
+                  const struct route_gateway_in=
fo *rgi,
                   const struct env_set *es, openvpn_net_ctx_t *ct=
x)
 {
     int i;
@@ -3942,7 +3944,7 @@
 #else  /* if defined(_WIN32) */
 
=
 static void
-get_bypass_addresses(struct route_bypass *rb, const unsigned =
int flags) /* PLATFORM-SPECIFIC */
+get_bypass_addresses(struct route_bypas=
s *rb, const unsigned int flags)
 {
 }
 
diff --git a/src/openvpn/schedule=
=2Ec b/src/openvpn/schedule=2Ec
index 6772ad6=2E=2E694f4d1 100644
--- a/src=
/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -389,4 +389,4 @@
 {=

     s->earliest_wakeup =3D NULL; /* invalidate cache */
     schedule_rem=
ove_node(s, e);
-}
\ No newline at end of file
+}
diff --git a/src/openvpn/=
socket=2Ec b/src/openvpn/socket=2Ec
index 50126bf=2E=2E6684350 100644
--- a=
/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -619,7 +619,7 @@
 }=

 
 static void
-bind_local(struct link_socket *sock, const sa_family_t ai_=
family)
+bind_local(const struct link_socket *sock, const sa_family_t ai_fa=
mily)
 {
     /* bind to local address/port */
     if (sock->bind_local)
@=
@ -886,8 +886,8 @@
 }
 
 void
-socket_bind(socket_descriptor_t sd, struct a=
ddrinfo *local, int ai_family, const char *prefix,
-            bool ipv6on=
ly)
+socket_bind(socket_descriptor_t sd, const struct addrinfo *local, int =
ai_family,
+            const char *prefix, bool ipv6only)
 {
     struct g=
c_arena gc =3D gc_new();
 
@@ -1095,8 +1095,8 @@
  * such as TCP=2E
  */
 
=
-static void stream_buf_init(struct stream_buf *sb, struct buffer *buf, con=
st unsigned int sockflags,
-                            const int proto);
+=
static void stream_buf_init(struct stream_buf *sb, const struct buffer *buf=
,
+                            const unsigned int sockflags, const int prot=
o);
 
 static void stream_buf_close(struct stream_buf *sb);
 
@@ -1453,7 +1=
453,7 @@
 }
 
 static void
-phase2_set_socket_flags(struct link_socket *soc=
k)
+phase2_set_socket_flags(const struct link_socket *sock)
 {
     /* TCP_=
NODELAY is enabled by default on every TCP socket; dco-win is
      * skipp=
ed as it manages its own socket */
@@ -2053,7 +2053,7 @@
 }
 
 static void
=
-stream_buf_init(struct stream_buf *sb, struct buffer *buf, const unsigned =
int sockflags,
+stream_buf_init(struct stream_buf *sb, const struct buffer =
*buf, const unsigned int sockflags,
                 const int proto)
 {
  =
   sb->buf_init =3D *buf;
@@ -2319,7 +2319,7 @@
 #endif
 
 static ssize_t
-=
link_socket_read_udp_posix_recvmsg(struct link_socket *sock, struct buffer =
*buf,
+link_socket_read_udp_posix_recvmsg(const struct link_socket *sock, s=
truct buffer *buf,
                                    struct link_socket_a=
ctual *from, socklen_t *fromlen)
 {
     struct iovec iov;
@@ -2391,7 +2391=
,7 @@
 #endif /* if ENABLE_IP_PKTINFO */
 
 ssize_t
-link_socket_read_udp_p=
osix(struct link_socket *sock, struct buffer *buf,
+link_socket_read_udp_po=
six(const struct link_socket *sock, struct buffer *buf,
                   =
         struct link_socket_actual *from)
 {
     ssize_t recvlen;
@@ -2454=
,7 +2454,7 @@
 #if ENABLE_IP_PKTINFO
 
 ssize_t
-link_socket_write_udp_posi=
x_sendmsg(struct link_socket *sock, struct buffer *buf,
+link_socket_write_=
udp_posix_sendmsg(const struct link_socket *sock, const struct buffer *buf,=

                                     struct link_socket_actual *to)
 {
   =
  struct iovec iov;
@@ -2648,7 +2648,7 @@
 }
 
 int
-socket_send_queue(stru=
ct link_socket *sock, struct buffer *buf, const struct link_socket_actual *=
to)
+socket_send_queue(struct link_socket *sock, const struct buffer *buf, =
const struct link_socket_actual *to)
 {
     if (sock->writes=2Eiostate =3D=
=3D IOSTATE_INITIAL)
     {
@@ -2748,8 +2748,8 @@
     return sock->writes=
=2Eiostate;
 }
 
-void
-read_sockaddr_from_overlapped(struct overlapped_io =
*io, struct sockaddr *dst, int overlapped_ret)
+static void
+read_sockaddr_=
from_overlapped(const struct overlapped_io *io, struct sockaddr *dst, int o=
verlapped_ret)
 {
     if (overlapped_ret >=3D 0 && io->addr_defined)
     =
{
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 89465b=
c=2E=2Ec6bcd86 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=
=2Eh
@@ -268,7 +268,7 @@
 
 int socket_recv_queue(struct link_socket *sock,=
 int maxsize);
 
-int socket_send_queue(struct link_socket *sock, struct bu=
ffer *buf,
+int socket_send_queue(struct link_socket *sock, const struct bu=
ffer *buf,
                       const struct link_socket_actual *to);
 
 =
typedef struct
@@ -348,8 +348,8 @@
 
 struct link_socket *link_socket_new(v=
oid);
 
-void socket_bind(socket_descriptor_t sd, struct addrinfo *local, i=
nt af_family, const char *prefix,
-                 bool ipv6only);
+void s=
ocket_bind(socket_descriptor_t sd, const struct addrinfo *local, int af_fam=
ily,
+                 const char *prefix, bool ipv6only);
 
 int openvpn_c=
onnect(socket_descriptor_t sd, const struct sockaddr *remote, int connect_t=
imeout,
                     volatile int *signal_received);
@@ -483,7 +483=
,7 @@
 }
 
 static inline bool
-link_socket_verify_incoming_addr(struct buf=
fer *buf, const struct link_socket_info *info,
+link_socket_verify_incoming=
_addr(const struct buffer *buf, const struct link_socket_info *info,
      =
                            const struct link_socket_actual *from_addr)
 {
=
     if (buf->len > 0)
@@ -607,7 +607,7 @@
 
 #else  /* ifdef _WIN32 */
 
-=
ssize_t link_socket_read_udp_posix(struct link_socket *sock, struct buffer =
*buf,
+ssize_t link_socket_read_udp_posix(const struct link_socket *sock, s=
truct buffer *buf,
                                    struct link_socket_a=
ctual *from);
 
 #endif /* ifdef _WIN32 */
@@ -693,12 +693,12 @@
 
 #else /=
* ifdef _WIN32 */
 
-ssize_t link_socket_write_udp_posix_sendmsg(struct lin=
k_socket *sock, struct buffer *buf,
+ssize_t link_socket_write_udp_posix_se=
ndmsg(const struct link_socket *sock, const struct buffer *buf,
           =
                                  struct link_socket_actual *to);
 
 
 stat=
ic inline ssize_t
-link_socket_write_udp_posix(struct link_socket *sock, st=
ruct buffer *buf,
+link_socket_write_udp_posix(const struct link_socket *so=
ck, const struct buffer *buf,
                             struct link_sock=
et_actual *to)
 {
 #if ENABLE_IP_PKTINFO
@@ -714,7 +714,7 @@
 }
 
 static i=
nline ssize_t
-link_socket_write_tcp_posix(struct link_socket *sock, struct=
 buffer *buf)
+link_socket_write_tcp_posix(const struct link_socket *sock, =
const struct buffer *buf)
 {
     return send(sock->sd, BPTR(buf), BLENZ(bu=
f), MSG_NOSIGNAL);
 }
@@ -772,7 +772,7 @@
  * from tunnel packet=2E
  */
 s=
tatic inline void
-link_socket_set_tos(struct link_socket *sock)
+link_sock=
et_set_tos(const struct link_socket *sock)
 {
     if (sock && sock->ptos_d=
efined)
     {
@@ -818,6 +818,8 @@
     }
 }
 
+/* cppcheck-suppress constP=
arameterPointer
+ * sock is modified on Windows via &sock->listen_handle */=

 static inline void
 socket_reset_listen_persistent(struct link_socket *so=
ck)
 {
diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=
=2Eh
index 13f5962=2E=2Eadd08ba 100644
--- a/src/openvpn/socket_util=2Eh
++=
+ b/src/openvpn/socket_util=2Eh
@@ -439,7 +439,7 @@
 
 
 static inline bool=

-addrlist_match_proto(const struct openvpn_sockaddr *a1, struct addrinfo *=
addr_list, const int proto)
+addrlist_match_proto(const struct openvpn_sock=
addr *a1, const struct addrinfo *addr_list, const int proto)
 {
     return=
 link_socket_proto_connection_oriented(proto) ? addrlist_match(a1, addr_lis=
t)
                                                         : addrlist_port=
_match(a1, addr_list);
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/soc=
ks=2Ec
index 19f3d54=2E=2E77ca863 100644
--- a/src/openvpn/socks=2Ec
+++ b/=
src/openvpn/socks=2Ec
@@ -82,7 +82,7 @@
 
 static bool
 socks_proxy_recv_ch=
ar(uint8_t *c, const char *name, socket_descriptor_t sd,
-                 =
     struct event_timeout *server_poll_timeout,
+                      cons=
t struct event_timeout *server_poll_timeout,
                       volatil=
e int *signal_received)
 {
     fd_set reads;
@@ -97,8 +97,8 @@
 }
 
 stati=
c bool
-socks_username_password_auth(struct socks_proxy_info *p, socket_des=
criptor_t sd,
-                             struct event_timeout *server_po=
ll_timeout,
+socks_username_password_auth(const struct socks_proxy_info *p,=
 socket_descriptor_t sd,
+                             const struct event_t=
imeout *server_poll_timeout,
                              volatile int *si=
gnal_received)
 {
     char to_send[516];
@@ -156,8 +156,8 @@
 }
 
 static =
bool
-socks_handshake(struct socks_proxy_info *p, socket_descriptor_t sd,
-=
                struct event_timeout *server_poll_timeout, volatile int *si=
gnal_received)
+socks_handshake(const struct socks_proxy_info *p, socket_de=
scriptor_t sd,
+                const struct event_timeout *server_poll_tim=
eout, volatile int *signal_received)
 {
     uint8_t buf[2];
     int len =
=3D 0;
@@ -231,7 +231,7 @@
 
 static bool
 recv_socks_reply(socket_descript=
or_t sd, struct openvpn_sockaddr *addr,
-                 struct event_time=
out *server_poll_timeout, volatile int *signal_received)
+                 =
const struct event_timeout *server_poll_timeout, volatile int *signal_recei=
ved)
 {
     uint8_t atyp =3D 0;
     int alen =3D 0;
@@ -334,11 +334,11 @@=

 }
 
 void
-establish_socks_proxy_passthru(struct socks_proxy_info *p,
+es=
tablish_socks_proxy_passthru(const struct socks_proxy_info *p,
            =
                    socket_descriptor_t sd, /* already open to proxy */
   =
                             const char *host,       /* openvpn server remo=
te */
                                const char *servname,   /* openvpn se=
rver port */
-                               struct event_timeout *server_p=
oll_timeout,
+                               const struct event_timeout *se=
rver_poll_timeout,
                                struct signal_info *sig_=
info)
 {
     char buf[270];
@@ -392,10 +392,10 @@
 }
 
 void
-establish_so=
cks_proxy_udpassoc(struct socks_proxy_info *p,
+establish_socks_proxy_udpas=
soc(const struct socks_proxy_info *p,
                                socke=
t_descriptor_t ctrl_sd, /* already open to proxy */
                       =
         struct openvpn_sockaddr *relay_addr,
-                            =
   struct event_timeout *server_poll_timeout,
+                            =
   const struct event_timeout *server_poll_timeout,
                       =
         struct signal_info *sig_info)
 {
     if (!socks_handshake(p, ctrl=
_sd, server_poll_timeout, &sig_info->signal_received))
diff --git a/src/ope=
nvpn/socks=2Eh b/src/openvpn/socks=2Eh
index 846113d=2E=2Ef7c93b6 100644
--=
- a/src/openvpn/socks=2Eh
+++ b/src/openvpn/socks=2Eh
@@ -47,17 +47,17 @@
 =

 void socks_proxy_close(struct socks_proxy_info *sp);
 
-void establish_so=
cks_proxy_passthru(struct socks_proxy_info *p,
+void establish_socks_proxy_=
passthru(const struct socks_proxy_info *p,
                                =
     socket_descriptor_t sd, /* already open to proxy */
                  =
                   const char *host,       /* openvpn server remote */
    =
                                 const char *servname,   /* openvpn server =
port */
-                                    struct event_timeout *server_p=
oll_timeout,
+                                    const struct event_timeou=
t *server_poll_timeout,
                                     struct signal_=
info *sig_info);
 
-void establish_socks_proxy_udpassoc(struct socks_proxy_=
info *p,
+void establish_socks_proxy_udpassoc(const struct socks_proxy_info=
 *p,
                                     socket_descriptor_t ctrl_sd, /* a=
lready open to proxy */
                                     struct openvpn=
_sockaddr *relay_addr,
-                                    struct event_ti=
meout *server_poll_timeout,
+                                    const stru=
ct event_timeout *server_poll_timeout,
                                    =
 struct signal_info *sig_info);
 
 void socks_process_incoming_udp(struct b=
uffer *buf, struct link_socket_actual *from);
diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec
index 5e12135=2E=2Ea13a71a 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1159,7 +1159,7 @@
 }
 
 struct tl=
s_multi *
-tls_multi_init(struct tls_options *tls_options)
+tls_multi_init(=
const struct tls_options *tls_options)
 {
     struct tls_multi *ret;
 
@@ =
-1188,7 +1188,7 @@
  */
 
 struct tls_auth_standalone *
-tls_auth_standalon=
e_init(struct tls_options *tls_options, struct gc_arena *gc)
+tls_auth_stan=
dalone_init(const struct tls_options *tls_options, struct gc_arena *gc)
 {
=
     struct tls_auth_standalone *tas;
 
@@ -1336,7 +1336,7 @@
 
 static voi=
d
 init_epoch_keys(struct key_state *ks, struct tls_multi *multi, const str=
uct key_type *key_type,
-                bool server, struct key2 *key2)
+ =
               bool server, const struct key2 *key2)
 {
     /* For now we =
hardcode this to be 16 for the software based data channel
      * DCO base=
d implementations/HW implementation might adjust this number
@@ -1375,7 +13=
75,7 @@
 
 static void
 init_key_contexts(struct key_state *ks, struct tls_=
multi *multi, const struct key_type *key_type,
-                  bool serv=
er, struct key2 *key2, bool dco_enabled)
+                  bool server, co=
nst struct key2 *key2, bool dco_enabled)
 {
     struct key_ctx_bi *key =3D=
 &ks->crypto_options=2Ekey_ctx_bi;
 
@@ -1573,8 +1573,9 @@
 
 bool
 tls_ses=
sion_update_crypto_params_do_work(struct tls_multi *multi, struct tls_sessi=
on *session,
-                                         struct options *opti=
ons, struct frame *frame,
-                                         struct =
frame *frame_fragment, struct link_socket_info *lsi,
+                     =
                    const struct options *options, struct frame *frame,
+  =
                                       struct frame *frame_fragment,
+     =
                                    const struct link_socket_info *lsi,
   =
                                       dco_context_t *dco)
 {
     if (sess=
ion->key[KS_PRIMARY]=2Ecrypto_options=2Ekey_ctx_bi=2Einitialized)
@@ -1643,=
7 +1644,7 @@
 bool
 tls_session_update_crypto_params(struct tls_multi *mult=
i, struct tls_session *session,
                                  struct op=
tions *options, struct frame *frame,
-                                 stru=
ct frame *frame_fragment, struct link_socket_info *lsi,
+                  =
               struct frame *frame_fragment, const struct link_socket_info =
*lsi,
                                  dco_context_t *dco)
 {
     if (!ch=
eck_session_cipher(session, options))
@@ -2495,8 +2496,8 @@
 }
 
 bool
-ses=
sion_skip_to_pre_start(struct tls_session *session, struct tls_pre_decrypt_=
state *state,
-                          struct link_socket_actual *from)
+=
session_skip_to_pre_start(struct tls_session *session, const struct tls_pre=
_decrypt_state *state,
+                          const struct link_socket_=
actual *from)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];
 =
    ks->session_id_remote =3D state->peer_session_id;
@@ -4036,7 +4037,7 @@=

 }
 
 void
-tls_post_encrypt(struct tls_multi *multi, struct buffer *buf)
=
+tls_post_encrypt(struct tls_multi *multi, const struct buffer *buf)
 {
   =
  struct key_state *ks =3D multi->save_ks;
     multi->save_ks =3D NULL;
@@=
 -4167,7 +4168,7 @@
  * into a garbage collectable string which is returned=
=2E
  */
 const char *
-protocol_dump(struct buffer *buffer, unsigned int f=
lags, struct gc_arena *gc)
+protocol_dump(const struct buffer *buffer, unsi=
gned int flags, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_bu=
f_gc(256, gc);
     struct buffer buf =3D *buffer;
diff --git a/src/openvpn=
/ssl=2Eh b/src/openvpn/ssl=2Eh
index 7ddf965=2E=2E93e6200 100644
--- a/src/=
openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -166,7 +166,7 @@
  *
  * @retu=
rn A newly allocated and initialized \c tls_multi structure=2E
  */
-struct=
 tls_multi *tls_multi_init(struct tls_options *tls_options);
+struct tls_mu=
lti *tls_multi_init(const struct tls_options *tls_options);
 
 /**
  * Fina=
lize initialization of a \c tls_multi structure=2E
@@ -187,7 +187,7 @@
 /*
=
  * Initialize a standalone tls-auth verification object=2E
  */
-struct tl=
s_auth_standalone *tls_auth_standalone_init(struct tls_options *tls_options=
,
+struct tls_auth_standalone *tls_auth_standalone_init(const struct tls_op=
tions *tls_options,
                                                      s=
truct gc_arena *gc);
 
 /**
@@ -371,7 +371,7 @@
  * @param multi - The TLS =
state for this packet's destination VPN tunnel=2E
  * @param buf - The buff=
er containing the outgoing packet=2E
  */
-void tls_post_encrypt(struct tls=
_multi *multi, struct buffer *buf);
+void tls_post_encrypt(struct tls_multi=
 *multi, const struct buffer *buf);
 
 /** @} name Functions for managing s=
ecurity parameter state for data channel packets */
 
@@ -461,7 +461,8 @@
 =
 */
 bool tls_session_update_crypto_params(struct tls_multi *multi, struct =
tls_session *session,
                                       struct options=
 *options, struct frame *frame,
-                                      stru=
ct frame *frame_fragment, struct link_socket_info *lsi,
+                  =
                    struct frame *frame_fragment,
+                        =
              const struct link_socket_info *lsi,
                         =
              dco_context_t *dco);
 
 /*
@@ -525,7 +526,7 @@
 #define PD_VE=
RBOSE                 (1 << 10)
 #define PD_TLS_CRYPT               (1 << 1=
1)
 
-const char *protocol_dump(struct buffer *buffer, unsigned int flags, =
struct gc_arena *gc);
+const char *protocol_dump(const struct buffer *buffe=
r, unsigned int flags, struct gc_arena *gc);
 
 /*
  * debugging code
@@ -5=
73,7 +574,7 @@
 /* Special method to skip the three way handshake RESET sta=
ges=2E This is
  * used by the HMAC code when seeing a packet that matches =
the previous
  * HMAC based stateless server state */
-bool session_skip_to=
_pre_start(struct tls_session *session, struct tls_pre_decrypt_state *state=
,
-                               struct link_socket_actual *from);
+bool s=
ession_skip_to_pre_start(struct tls_session *session, const struct tls_pre_=
decrypt_state *state,
+                               const struct link_soc=
ket_actual *from);
 
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src/op=
envpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh
index 816fb9c=2E=2Eed39=
5e7 100644
--- a/src/openvpn/ssl_backend=2Eh
+++ b/src/openvpn/ssl_backend=
=2Eh
@@ -144,7 +144,7 @@
  *
  * @return      true if the context is initia=
lised, false if not=2E
  */
-bool tls_ctx_initialised(struct tls_root_ctx *=
ctx);
+bool tls_ctx_initialised(const struct tls_root_ctx *ctx);
 
 /**
  *=
 Set any library specific options=2E
@@ -177,7 +177,7 @@
  * @param ciphers=
       String containing : delimited cipher names, or NULL to use
  *      =
                                sane defaults=2E
  */
-void tls_ctx_restric=
t_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers);
+void tls_c=
tx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const char *ciphe=
rs);
 
 /**
  * Set the TLS certificate profile=2E  The profile defines whi=
ch crypto
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtl=
s=2Ec
index d5c9e5c=2E=2E49ea0bc 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+=
++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -161,7 +161,7 @@
 }
 
 bool
-tls_ctx_in=
itialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(const struct tls_r=
oot_ctx *ctx)
 {
     /* either this should be NULL or should be non-null a=
nd then have a
      * valid TLS ctx inside as well */
@@ -284,7 +284,7 @@
=
 }
 
 void
-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const =
char *ciphers)
+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *c=
tx, const char *ciphers)
 {
     if (ciphers =3D=3D NULL)
     {
diff --git=
 a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index d31f78f=
=2E=2E401bd1b 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ss=
l_openssl=2Ec
@@ -147,7 +147,7 @@
 }
 
 bool
-tls_ctx_initialised(struct tl=
s_root_ctx *ctx)
+tls_ctx_initialised(const struct tls_root_ctx *ctx)
 {
  =
   /* either this should be NULL or should be non-null and then have a
    =
  * valid TLS ctx inside as well */
@@ -464,7 +464,7 @@
 #endif
 
 void
-tl=
s_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)=

+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const char=
 *ciphers)
 {
     if (ciphers =3D=3D NULL)
     {
@@ -1111,7 +1111,7 @@
 }=

 
 static void
-tls_ctx_load_cert_uri(struct tls_root_ctx *tls_ctx, const =
char *uri)
+tls_ctx_load_cert_uri(const struct tls_root_ctx *tls_ctx, const=
 char *uri)
 {
 #if defined(HAVE_OPENSSL_STORE_API)
     X509 *x =3D NULL;
=
@@ -2026,7 +2026,7 @@
 }
 
 static void
-bio_debug_data(const char *mode, B=
IO *bio, const uint8_t *buf, int len, const char *desc)
+bio_debug_data(con=
st char *mode, const BIO *bio, const uint8_t *buf, int len, const char *des=
c)
 {
     struct gc_arena gc =3D gc_new();
     if (len > 0)
@@ -2040,7 +2=
040,7 @@
 }
 
 static void
-bio_debug_oc(const char *mode, BIO *bio)
+bio_d=
ebug_oc(const char *mode, const BIO *bio)
 {
     open_biofp();
     fprint=
f(biofp, "BIO %s time=3D%" PRIi64 " bio=3D" ptr_format "\n", mode, (int64_t=
)time(NULL),
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec=

index f8444451=2E=2Ee2a0c62 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src=
/openvpn/ssl_pkt=2Ec
@@ -57,7 +57,7 @@
  *  @return         if the swap was=
 successful (buf was large enough)
  */
 static bool
-swap_hmac(struct buff=
er *buf, const struct crypto_options *co, bool incoming)
+swap_hmac(const s=
truct buffer *buf, const struct crypto_options *co, bool incoming)
 {
     =
ASSERT(co);
 
@@ -117,7 +117,7 @@
  */
 static void
 tls_wrap_control(struc=
t tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,
-                 =
struct session_id *session_id)
+                 const struct session_id *s=
ession_id)
 {
     if (ctx->mode =3D=3D TLS_WRAP_AUTH || ctx->mode =3D=3D T=
LS_WRAP_NONE)
     {
@@ -401,9 +401,9 @@
 
 
 struct buffer
-tls_reset_stan=
dalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-        =
             struct session_id *own_sid, struct session_id *remote_sid, uin=
t8_t header,
-                     bool request_resend_wkc)
+tls_reset_stan=
dalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,
+  =
                   const struct session_id *own_sid, const struct session_i=
d *remote_sid,
+                     uint8_t header, bool request_resend_wk=
c)
 {
     /* Copy buffer here to point at the same data but allow tls_wrap=
_control
      * to potentially change buf to point to another buffer witho=
ut
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 82c=
b5b1=2E=2E9107ae1 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ss=
l_pkt=2Eh
@@ -218,8 +218,9 @@
  * from the tls pre decrypt state=2E
  *
  *=
/
-struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_=
auth_standalone *tas,
-                                   struct session_id=
 *own_sid, struct session_id *remote_sid,
+struct buffer tls_reset_standalo=
ne(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,
+      =
                             const struct session_id *own_sid,
+           =
                        const struct session_id *remote_sid,
              =
                      uint8_t header, bool request_resend_wkc);
 
 
diff --=
git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 063fa5d=
=2E=2E3304cb46 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ss=
l_verify=2Ec
@@ -1139,7 +1139,7 @@
  * cache=2E
  */
 static bool
-tls_auth=
entication_status_use_cache(struct tls_multi *multi)
+tls_authentication_st=
atus_use_cache(const struct tls_multi *multi)
 {
     unsigned int idx =3D =
min_uint(multi->tas_cache_num_updates, SIZE(cache_intervals) - 1);
     tim=
e_t latency =3D cache_intervals[idx];
@@ -1283,7 +1283,7 @@
  * Check if th=
e script/plugin left a message in the auth failed message
  * file and rela=
y it to the user */
 static void
-check_for_client_reason(struct tls_multi =
*multi, struct auth_deferred_status *status)
+check_for_client_reason(struc=
t tls_multi *multi, const struct auth_deferred_status *status)
 {
     stru=
ct gc_arena gc =3D gc_new();
     const char *msg =3D key_state_check_auth_=
failed_message_file(status, &gc);
@@ -1552,7 +1552,7 @@
 #endif /* ifdef EN=
ABLE_MANAGEMENT */
 
 static bool
-set_verify_user_pass_env(struct user_pas=
s *up, struct tls_multi *multi, struct tls_session *session)
+set_verify_us=
er_pass_env(const struct user_pass *up, struct tls_multi *multi, struct tls=
_session *session)
 {
     /* Is username defined? */
     if ((session->op=
t->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
@@ -1=
580,7 +1580,7 @@
 }
 
 bool
-ssl_verify_username_length(struct tls_session =
*session, const char *username)
+ssl_verify_username_length(const struct tl=
s_session *session, const char *username)
 {
     if ((session->opt->ssl_fl=
ags & SSLF_USERNAME_AS_COMMON_NAME)
         && strlen(username) > TLS_USER=
NAME_LEN)
diff --git a/src/openvpn/ssl_verify=2Eh b/src/openvpn/ssl_verify=
=2Eh
index 3176d76=2E=2Ee77bc4a 100644
--- a/src/openvpn/ssl_verify=2Eh
+++=
 b/src/openvpn/ssl_verify=2Eh
@@ -202,7 +202,7 @@
  * @return              =
true if name is under limit or username-as-common-name
  *                 =
     is not active
  */
-bool ssl_verify_username_length(struct tls_session=
 *session, const char *username);
+bool ssl_verify_username_length(const st=
ruct tls_session *session, const char *username);
 
 /**
  * Runs the --cli=
ent-crresponse script if one is defined=2E
@@ -275,7 +275,7 @@
 void auth_s=
et_client_reason(struct tls_multi *multi, const char *client_reason);
 
 st=
atic inline const char *
-tls_client_reason(struct tls_multi *multi)
+tls_c=
lient_reason(const struct tls_multi *multi)
 {
     return multi->client_re=
ason;
 }
diff --git a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec
index=
 c7d375b=2E=2Ecfbc38d 100644
--- a/src/openvpn/status=2Ec
+++ b/src/openvpn=
/status=2Ec
@@ -135,7 +135,7 @@
 }
 
 void
-status_reset(struct status_outp=
ut *so)
+status_reset(const struct status_output *so)
 {
     if (so && so-=
>fd >=3D 0)
     {
diff --git a/src/openvpn/status=2Eh b/src/openvpn/status=
=2Eh
index 7953a4e=2E=2E4c01d75 100644
--- a/src/openvpn/status=2Eh
+++ b/s=
rc/openvpn/status=2Eh
@@ -69,7 +69,7 @@
 
 bool status_trigger(struct statu=
s_output *so);
 
-void status_reset(struct status_output *so);
+void status=
_reset(const struct status_output *so);
 
 void status_flush(struct status_=
output *so);
 
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index=
 bc262cd=2E=2E7e1999d 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tu=
n=2Ec
@@ -835,7 +835,7 @@
          const char *ifconfig_ipv6_local_parm,  =
   /* --ifconfig parm 1 IPv6 */
          int ifconfig_ipv6_netbits_parm,
 =
         const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 IPv=
6 */
-         struct addrinfo *local_public, struct addrinfo *remote_publi=
c, const bool strict_warn,
+         const struct addrinfo *local_public, c=
onst struct addrinfo *remote_public, const bool strict_warn,
          stru=
ct env_set *es, openvpn_net_ctx_t *ctx, struct tuntap *tt)
 {
     if (!tt)=

@@ -978,7 +978,7 @@
  * -> helper function to simplify code below
  */
 st=
atic void
-add_route_connected_v6_net(struct tuntap *tt, const struct env_s=
et *es)
+add_route_connected_v6_net(const struct tuntap *tt, const struct e=
nv_set *es)
 {
     struct route_ipv6 r6;
 
@@ -1020,7 +1020,7 @@
  */
 
 i=
n_addr_t
-create_arbitrary_remote(struct tuntap *tt)
+create_arbitrary_remo=
te(const struct tuntap *tt)
 {
     in_addr_t remote;
 
@@ -1592,7 +1592,7 =
@@
 }
 
 static void
-undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx=
_t *ctx)
+undo_ifconfig_ipv4(const struct tuntap *tt, openvpn_net_ctx_t *ct=
x)
 {
 #if defined(TARGET_LINUX)
     int netbits =3D netmask_to_netbits2(t=
t->remote_netmask);
@@ -1627,7 +1627,7 @@
 }
 
 static void
-undo_ifconfig_=
ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv6(const s=
truct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
   =
  if (net_addr_v6_del(ctx, tt->actual_name, &tt->local_ipv6, tt->netbits_ip=
v6) < 0)
@@ -1652,7 +1652,7 @@
 }
 
 void
-undo_ifconfig(struct tuntap *tt,=
 openvpn_net_ctx_t *ctx)
+undo_ifconfig(const struct tuntap *tt, openvpn_ne=
t_ctx_t *ctx)
 {
     if (tt->backend_driver !=3D DRIVER_NULL && tt->backen=
d_driver !=3D DRIVER_AFUNIX)
     {
@@ -1729,7 +1729,7 @@
 #endif
 
 static=
 ssize_t
-write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
+write=
_tun_header(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     i=
f (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1746,9 +1746,11 @@
            =
 type =3D htonl(AF_INET);
         }
 
+        /* argument to writev is a =
pointer to const but we still need to drop
+         * the const from buf p=
ointer here */
         iv[0]=2Eiov_base =3D &type;
         iv[0]=2Eiov_le=
n =3D sizeof(type);
-        iv[1]=2Eiov_base =3D buf;
+        iv[1]=2Eiov=
_base =3D (void *)buf;
         iv[1]=2Eiov_len =3D len;
 
         return =
header_modify_read_write_return(writev(tt->fd, iv, 2));
@@ -1760,7 +1762,7 =
@@
 }
 
 static ssize_t
-read_tun_header(struct tuntap *tt, uint8_t *buf, i=
nt len)
+read_tun_header(const struct tuntap *tt, uint8_t *buf, int len)
 {=

     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1786,13 +1788,13 @@
  */=

 #if !defined(TARGET_DARWIN)
 ssize_t
-write_tun(struct tuntap *tt, uint8_=
t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, in=
t len)
 {
     return write_tun_header(tt, buf, len);
 }
 
 ssize_t
-read_t=
un(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap =
*tt, uint8_t *buf, int len)
 {
     return read_tun_header(tt, buf, len);
 =
}
@@ -1808,7 +1810,7 @@
 
 #if defined(TARGET_LINUX) || defined(TARGET_FREE=
BSD)
 static bool
-tun_dco_enabled(struct tuntap *tt)
+tun_dco_enabled(cons=
t struct tuntap *tt)
 {
     return tt->backend_driver =3D=3D DRIVER_DCO;
 =
}
@@ -2055,13 +2057,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8=
_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, i=
nt len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(str=
uct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, u=
int8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -2260,13=
 +2262,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int =
len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
  =
   return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *t=
t, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, =
int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -2596,7 +2598,7 @@
 }=

 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun=
(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     struct strbu=
f sbuf;
     sbuf=2Elen =3D len;
@@ -2605,7 +2607,7 @@
 }
 
 ssize_t
-read_=
tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap=
 *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
     int f =3D 0;
=
@@ -3103,7 +3105,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *=
buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int l=
en)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
@@ -3116,7 +3=
118,7 @@
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
=
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->b=
ackend_driver =3D=3D DRIVER_UTUN)
     {
@@ -3320,7 +3322,7 @@
 }
 
 int
-t=
un_write_queue(struct tuntap *tt, struct buffer *buf)
+tun_write_queue(stru=
ct tuntap *tt, const struct buffer *buf)
 {
     if (tt->writes=2Eiostate =
=3D=3D IOSTATE_INITIAL)
     {
@@ -3375,7 +3377,7 @@
 }
 
 int
-tun_write_w=
in32(struct tuntap *tt, struct buffer *buf)
+tun_write_win32(struct tuntap =
*tt, const struct buffer *buf)
 {
     int err =3D 0;
     int status =3D 0=
;
@@ -5383,7 +5385,7 @@
 }
 
 void
-fork_register_dns_action(struct tuntap =
*tt)
+fork_register_dns_action(const struct tuntap *tt)
 {
     if (tt && t=
t->options=2Eregister_dns && tt->options=2Emsg_channel)
     {
@@ -5473,7 +=
5475,7 @@
 }
 
 static void
-tuntap_get_mtu(struct tuntap *tt)
+tuntap_get_=
mtu(const struct tuntap *tt)
 {
     ULONG mtu =3D 0;
     DWORD len;
@@ -6=
048,7 +6050,7 @@
 }
 
 void
-tun_show_debug(struct tuntap *tt)
+tun_show_de=
bug(const struct tuntap *tt)
 {
     if (tt->backend_driver =3D=3D WINDOWS_=
DRIVER_TAP_WINDOWS6)
     {
diff --git a/src/openvpn/tun=2Eh b/src/openvpn/=
tun=2Eh
index 931e54d=2E=2Ebeb0d0e 100644
--- a/src/openvpn/tun=2Eh
+++ b/s=
rc/openvpn/tun=2Eh
@@ -272,9 +272,9 @@
 
 void close_tun_handle(struct tunt=
ap *tt);
 
-ssize_t write_tun(struct tuntap *tt, uint8_t *buf, int len);
+s=
size_t write_tun(const struct tuntap *tt, const uint8_t *buf, int len);
 
-=
ssize_t read_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t read_t=
un(const struct tuntap *tt, uint8_t *buf, int len);
 
 #ifdef ENABLE_FEATUR=
E_TUN_PERSIST
 void tuncfg(const char *dev, const char *dev_type, const cha=
r *dev_node, int persist_mode,
@@ -293,7 +293,7 @@
                        =
 const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */
 =
                        int ifconfig_ipv6_netbits_parm,           /* --ifco=
nfig parm 1 / bits */
                         const char *ifconfig_ipv6_re=
mote_parm,    /* --ifconfig parm 2 / IPv6 */
-                        struc=
t addrinfo *local_public, struct addrinfo *remote_public,
+                =
        const struct addrinfo *local_public, const struct addrinfo *remote_=
public,
                         const bool strict_warn, struct env_set *es=
, openvpn_net_ctx_t *ctx,
                         struct tuntap *tt);
 
@@=
 -320,7 +320,7 @@
  * @param tt    the tuntap interface context
  * @param =
ctx   the networking API opaque context
  */
-void undo_ifconfig(struct tun=
tap *tt, openvpn_net_ctx_t *ctx);
+void undo_ifconfig(const struct tuntap *=
tt, openvpn_net_ctx_t *ctx);
 
 bool is_dev_type(const char *dev, const cha=
r *dev_type, const char *match_type);
 
@@ -351,7 +351,7 @@
 #define IFCONF=
IG_DEFAULT IFCONFIG_AFTER_TUN_OPEN
 
 static inline int
-ifconfig_order(str=
uct tuntap *tt)
+ifconfig_order(const struct tuntap *tt)
 {
     if (tt->ba=
ckend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -381,7 +381,7 @@
 #define ROUT=
E_ORDER_DEFAULT ROUTE_AFTER_TUN
 
 static inline int
-route_order(struct tu=
ntap *tt)
+route_order(const struct tuntap *tt)
 {
     if (tt->backend_dri=
ver =3D=3D DRIVER_AFUNIX)
     {
@@ -454,13 +454,13 @@
 
 const char *tap_w=
in_getinfo(const struct tuntap *tt, struct gc_arena *gc);
 
-void tun_show_=
debug(struct tuntap *tt);
+void tun_show_debug(const struct tuntap *tt);
 
=
 bool dhcp_release_by_adapter_index(const DWORD adapter_index);
 
 bool dhc=
p_renew_by_adapter_index(const DWORD adapter_index);
 
-void fork_register_=
dns_action(struct tuntap *tt);
+void fork_register_dns_action(const struct =
tuntap *tt);
 
 void ipconfig_register_dns(const struct env_set *es);
 
@@ =
-470,7 +470,7 @@
 
 int tun_read_queue(struct tuntap *tt, int maxsize);
 
-=
int tun_write_queue(struct tuntap *tt, struct buffer *buf);
+int tun_write_=
queue(struct tuntap *tt, const struct buffer *buf);
 
 static inline bool
 =
tuntap_stop(int status)
@@ -499,7 +499,7 @@
     return false;
 }
 
-int tu=
n_write_win32(struct tuntap *tt, struct buffer *buf);
+int tun_write_win32(=
struct tuntap *tt, const struct buffer *buf);
 
 static inline bool
 is_ip_=
packet_valid(const struct buffer *buf)
@@ -529,13 +529,13 @@
 }
 
 static i=
nline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(const s=
truct tuntap *tt)
 {
     return tt && tt->backend_driver =3D=3D DRIVER_DCO=
;
 }
 
 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, ss=
ize_t status)
+tuntap_is_dco_win_timeout(const struct tuntap *tt, ssize_t s=
tatus)
 {
     return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_err=
no() =3D=3D ERROR_NETNAME_DELETED);
 }
@@ -555,25 +555,25 @@
 }
 
 static i=
nline void
-tun_standby_init(struct tuntap *tt)
+tun_standby_init(const str=
uct tuntap *tt)
 {
 }
 
 static inline bool
-tun_standby(struct tuntap *tt)=

+tun_standby(const struct tuntap *tt)
 {
     return true;
 }
 
 
 static =
inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(const =
struct tuntap *tt)
 {
     return false;
 }
 
 static inline bool
-tuntap_i=
s_dco_win_timeout(struct tuntap *tt, ssize_t status)
+tuntap_is_dco_win_tim=
eout(const struct tuntap *tt, ssize_t status)
 {
     return false;
 }
diff=
 --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec
index a67a=
472=2E=2Ee9223bc 100644
--- a/src/openvpn/tun_afunix=2Ec
+++ b/src/openvpn/=
tun_afunix=2Ec
@@ -48,7 +48,7 @@
 
 
 static void
-tun_afunix_exec_child(co=
nst char *dev_node, struct tuntap *tt, struct env_set *env)
+tun_afunix_exe=
c_child(const char *dev_node, struct tuntap *tt, const struct env_set *env)=

 {
     const char *msgprefix =3D "ERROR: failure executing process for tu=
n:";
     struct argv argv =3D argv_new();
@@ -73,7 +73,7 @@
 }
 
 void
-op=
en_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set=
 *orig_env)
+open_tun_afunix(const struct options *o, int mtu, struct tunta=
p *tt, const struct env_set *orig_env)
 {
     struct gc_arena gc =3D gc_ne=
w();
 
diff --git a/src/openvpn/tun_afunix=2Eh b/src/openvpn/tun_afunix=2Eh=

index 5b6a8e0=2E=2Efb88eb2 100644
--- a/src/openvpn/tun_afunix=2Eh
+++ b/s=
rc/openvpn/tun_afunix=2Eh
@@ -31,7 +31,7 @@
  * the user provided taking ca=
re of implementing the actual tun
  * device=2E
  */
-void open_tun_afunix(=
struct options *o, int mtu, struct tuntap *tt, struct env_set *env);
+void =
open_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, const =
struct env_set *env);
 
 
 /**
diff --git a/src/openvpn/vlan=2Ec b/src/open=
vpn/vlan=2Ec
index bffc60e=2E=2Ecd32a9b 100644
--- a/src/openvpn/vlan=2Ec
+=
++ b/src/openvpn/vlan=2Ec
@@ -288,7 +288,7 @@
 }
 
 void
-vlan_process_outg=
oing_tun(struct multi_context *m, struct multi_instance *mi)
+vlan_process_=
outgoing_tun(const struct multi_context *m, struct multi_instance *mi)
 {
 =
    if (!m->top=2Eoptions=2Evlan_tagging)
     {
diff --git a/src/openvpn/v=
lan=2Eh b/src/openvpn/vlan=2Eh
index 9389f89=2E=2Ecd2f66f 100644
--- a/src/=
openvpn/vlan=2Eh
+++ b/src/openvpn/vlan=2Eh
@@ -35,6 +35,6 @@
 
 bool vlan_=
is_tagged(const struct buffer *buf);
 
-void vlan_process_outgoing_tun(stru=
ct multi_context *m, struct multi_instance *mi);
+void vlan_process_outgoin=
g_tun(const struct multi_context *m, struct multi_instance *mi);
 
 #endif =
/* VLAN_H */
diff --git a/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh
ind=
ex ef32062=2E=2Ebcbfa67 100644
--- a/src/openvpn/win32=2Eh
+++ b/src/openvp=
n/win32=2Eh
@@ -226,7 +226,7 @@
 void overlapped_io_close(struct overlapped=
_io *o);
 
 static inline bool
-overlapped_io_active(struct overlapped_io *=
o)
+overlapped_io_active(const struct overlapped_io *o)
 {
     return o->i=
ostate =3D=3D IOSTATE_QUEUED || o->iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;=

 }
diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openv=
pnmsica=2Ec
index a861e8a=2E=2E25fa1e4 100644
--- a/src/openvpnmsica/openvp=
nmsica=2Ec
+++ b/src/openvpnmsica/openvpnmsica=2Ec
@@ -77,7 +77,7 @@
  * @r=
eturn ERROR_SUCCESS on success; An error code otherwise
  */
 static UINT
-=
setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ str=
uct msica_arg_seq *seq)
+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPC=
WSTR szProperty, _In_ const struct msica_arg_seq *seq)
 {
     UINT uiResul=
t;
     LPWSTR szSequence =3D msica_arg_seq_join(seq);
diff --git a/src/ope=
nvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index a9e9665=2E=
=2E36c2847 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnse=
rv/interactive=2Ec
@@ -522,7 +522,7 @@
 
 
 static SOCKADDR_INET
-sockaddr_=
inet(short family, inet_address_t *addr)
+sockaddr_inet(short family, const=
 inet_address_t *addr)
 {
     SOCKADDR_INET sa_inet;
     ZeroMemory(&sa_i=
net, sizeof(sa_inet));
@@ -3841,7 +3841,7 @@
 
 static DWORD
 UpdateWaitHan=
dles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_event, HANDLE exit_eve=
nt,
-                  list_item_t *threads)
+                  const list_=
item_t *threads)
 {
     static DWORD size =3D 10;
     static LPHANDLE han=
dles =3D NULL;
diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/=
tests/unit_tests/openvpn/mock_management=2Ec
index 77f6ce2=2E=2Efff4c2b 100=
644
--- a/tests/unit_tests/openvpn/mock_management=2Ec
+++ b/tests/unit_tes=
ts/openvpn/mock_management=2Ec
@@ -36,7 +36,7 @@
 struct management *manage=
ment; /* GLOBAL */
 
 void
-management_auth_failure(struct management *man,=
 const char *type, const char *reason)
+management_auth_failure(const struc=
t management *man, const char *type, const char *reason)
 {
     ASSERT(fal=
se);
 }
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_te=
sts/openvpn/test_misc=2Ec
index 6c39b7f=2E=2E8c964c7 100644
--- a/tests/uni=
t_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
=
@@ -145,7 +145,7 @@
 }
 
 static struct hash_element *
-hash_lookup_by_valu=
e(struct hash *hash, void *value)
+hash_lookup_by_value(struct hash *hash, =
const void *value)
 {
     struct hash_iterator hi;
     struct hash_elemen=
t *he;
diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/uni=
t_tests/openvpn/test_user_pass=2Ec
index c0a0866=2E=2E7636a33 100644
--- a/=
tests/unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests/openvpn/=
test_user_pass=2Ec
@@ -59,7 +59,7 @@
     return mock();
 }
 void
-manageme=
nt_auth_failure(struct management *man, const char *type, const char *reaso=
n)
+management_auth_failure(const struct management *man, const char *type,=
 const char *reason)
 {
     assert_true(0);
 }

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Ge=
rrit-Change-Number: 1663
Gerrit-PatchSet: 11
Gerrit-Owner: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--gkw6zbq8oMk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #11</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">R=
emove instances of constParameterPointer cppcheck warnings<br><br>This requ=
ires a few suppressions since cppcheck<br>doesn&#39;t quite understand the =
different code-paths<br>implemented by preprocessor defines=2E<br><br>Chang=
e-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/cppcheck-sup=
pression<br>M sample/sample-plugins/client-connect/sample-client-connect=2E=
c<br>M sample/sample-plugins/defer/multi-auth=2Ec<br>M sample/sample-plugin=
s/keying-material-exporter-demo/keyingmaterialexporter=2Ec<br>M src/openvpn=
/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/clinat=2Ec<br>M sr=
c/openvpn/clinat=2Eh<br>M src/openvpn/comp=2Ec<br>M src/openvpn/comp=2Eh<br=
>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/dco=
=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dco_freebsd=2Ec<br>M src/ope=
nvpn/dco_internal=2Eh<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_w=
in=2Ec<br>M src/openvpn/dhcp=2Ec<br>M src/openvpn/dhcp=2Eh<br>M src/openvpn=
/event=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/forward=2Eh<br>M s=
rc/openvpn/init=2Ec<br>M src/openvpn/init=2Eh<br>M src/openvpn/interval=2Eh=
<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/manag=
e=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/mbuf=2Ec<br>M src/openvp=
n/mbuf=2Eh<br>M src/openvpn/mss=2Ec<br>M src/openvpn/mss=2Eh<br>M src/openv=
pn/mtcp=2Ec<br>M src/openvpn/mtcp=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/op=
envpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/networking=2Eh<=
br>M src/openvpn/networking_iproute2=2Ec<br>M src/openvpn/networking_sitnl=
=2Ec<br>M src/openvpn/occ=2Eh<br>M src/openvpn/openssl_compat=2Eh<br>M src/=
openvpn/options=2Ec<br>M src/openvpn/options_parse=2Ec<br>M src/openvpn/oti=
me=2Ec<br>M src/openvpn/otime=2Eh<br>M src/openvpn/proto=2Eh<br>M src/openv=
pn/proxy=2Ec<br>M src/openvpn/proxy=2Eh<br>M src/openvpn/ps=2Ec<br>M src/op=
envpn/ps=2Eh<br>M src/openvpn/push=2Ec<br>M src/openvpn/push=2Eh<br>M src/o=
penvpn/push_util=2Ec<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/reliabl=
e=2Eh<br>M src/openvpn/route=2Ec<br>M src/openvpn/schedule=2Ec<br>M src/ope=
nvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M src/openvpn/socket_util=2E=
h<br>M src/openvpn/socks=2Ec<br>M src/openvpn/socks=2Eh<br>M src/openvpn/ss=
l=2Ec<br>M src/openvpn/ssl=2Eh<br>M src/openvpn/ssl_backend=2Eh<br>M src/op=
envpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl=
_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M src/openvpn/ssl_verify=2Ec<br>M =
src/openvpn/ssl_verify=2Eh<br>M src/openvpn/status=2Ec<br>M src/openvpn/sta=
tus=2Eh<br>M src/openvpn/tun=2Ec<br>M src/openvpn/tun=2Eh<br>M src/openvpn/=
tun_afunix=2Ec<br>M src/openvpn/tun_afunix=2Eh<br>M src/openvpn/vlan=2Ec<br=
>M src/openvpn/vlan=2Eh<br>M src/openvpn/win32=2Eh<br>M src/openvpnmsica/op=
envpnmsica=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M tests/unit_tests/o=
penvpn/mock_management=2Ec<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>M=
 tests/unit_tests/openvpn/test_user_pass=2Ec<br>88 files changed, 333 inser=
tions(+), 289 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1663/11</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression</span><br>=
<span>index 900e03c=2E=2E5bc4b24 100644</span><br><span>--- a/dev-tools/cpp=
check-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppression</spa=
n><br><span>@@ -2,7 +2,6 @@</span><br><span> # occurences right now=2E They=
 still should be fixed at some point</span><br><span> constParameter</span>=
<br><span> constParameterCallback</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-constParameterPointer</span><br><span> invalidPrintfArgType_sin=
t</span><br><span> invalidPrintfArgType_uint</span><br><span> usleepCalled<=
/span><br><span>@@ -33,6 +32,39 @@</span><br><span> badBitmaskCheck:tests/u=
nit_tests/openvpn/test_pkt=2Ec</span><br><span> # IGN: we store integers in=
 pointers</span><br><span> CastAddressToIntegerAtReturn:src/openvpn/multi=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterP=
ointer:/usr/include/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# IGN: test files provide mocks/stubs that match prototypes from headers =
exactly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParamet=
erPointer:tests/unit_tests/openvpn/mock_*</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+constParameterPointer:tests/unit_tests/openvpn/test_*=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPoint=
er:tests/unit_tests/openvpnserv/test_*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# FP: different crypto implementations but same API</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:sr=
c/openvpn/crypto_mbedtls_legacy=2Ec:85</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+constParameterPointer:src/openvpn/crypto_openssl=2Ec:172=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPoint=
er:src/openvpn/crypto_openssl=2Ec:1456</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+constParameterPointer:src/openvpn/cryptoapi=2Ec:58</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src=
/openvpn/ssl_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+constParameterPointer:src/openvpn/ssl_openssl=2Ec</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/ssl_ve=
rify_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# I=
GN: too many different implementations, not worth it</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/dco*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:=
src/openvpn/socket=2E*</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# FP: parameters are modified on some platform only</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/dns=2E=
c:859</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameter=
Pointer:src/openvpn/error=2Ec:223</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+constParameterPointer:src/openvpn/forward=2Ec:1247</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/open=
vpn/manage=2Ec:344</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
onstParameterPointer:src/openvpn/manage=2Ec:3332</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/misc=2Ec:792=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPoint=
er:src/openvpn/misc=2Ec:812</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+constParameterPointer:src/openvpn/options=2Ec:3205</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/ro=
ute=2Ec:3947</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constPa=
rameterPointer:src/openvpn/tun=2Ec:560</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+constParameterPointer:src/openvpn/tun=2Ec:2188</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/ope=
nvpn/tun_afunix=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# IGN: not a FP but the documentation for the FP_ISSET claims this is not c=
onst=2E=2E=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constP=
arameterPointer:src/openvpn/event=2Ec:1015</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# IGN: MinGW Debug build doesn&#39;t like this, caus=
es -Wmaybe-uninitialized</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+constParameterPointer:src/openvpn/buffer=2Eh:1105</span><br><span> # I=
GN: event code uses a pointer to store integers</span><br><span> intToPoint=
erCast:src/openvpn/forward=2Ec</span><br><span> intToPointerCast:src/openvp=
n/multi_io=2Ec</span><br><span>diff --git a/sample/sample-plugins/client-co=
nnect/sample-client-connect=2Ec b/sample/sample-plugins/client-connect/samp=
le-client-connect=2Ec</span><br><span>index 420de61=2E=2Ecbd98e8 100644</sp=
an><br><span>--- a/sample/sample-plugins/client-connect/sample-client-conne=
ct=2Ec</span><br><span>+++ b/sample/sample-plugins/client-connect/sample-cl=
ient-connect=2Ec</span><br><span>@@ -344,7 +344,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-openvpn_plugin_client_connect(struct plugin_context *context,=
 const char **argv, const char **envp)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+openvpn_plugin_client_connect(const struct plugin_contex=
t *context, const char **argv, const char **envp)</span><br><span> {</span>=
<br><span>     /* log environment variables handed to us by OpenVPN, but</s=
pan><br><span>      * only if &quot;setenv verb&quot; is 3 or higher (arbit=
rary number)</span><br><span>@@ -465,7 +465,7 @@</span><br><span> </span><b=
r><span> int</span><br><span> openvpn_plugin_client_connect_defer_v2(struct=
 plugin_context *context,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                       struct plugin_per_client_context=
 *pcc,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                          const struct plugin_per_client_context *pcc,</spa=
n><br><span>                                        struct openvpn_plugin_s=
tring_list **return_list)</span><br><span> {</span><br><span>     time_t ti=
me_left =3D pcc-&gt;sleep_until - time(NULL);</span><br><span>diff --git a/=
sample/sample-plugins/defer/multi-auth=2Ec b/sample/sample-plugins/defer/mu=
lti-auth=2Ec</span><br><span>index bacf557=2E=2Ecdd616f 100644</span><br><s=
pan>--- a/sample/sample-plugins/defer/multi-auth=2Ec</span><br><span>+++ b/=
sample/sample-plugins/defer/multi-auth=2Ec</span><br><span>@@ -255,7 +255,7=
 @@</span><br><span> }</span><br><span> </span><br><span> static bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-do_auth_user_pass(struct pl=
ugin_context *context, const char *username, const char *password)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+do_auth_user_pass(const stru=
ct plugin_context *context, const char *username, const char *password)</sp=
an><br><span> {</span><br><span>     plog(context, PLOG_NOTE, &quot;expect_=
user=3D%s, received_user=3D%s, expect_passw=3D%s, received_passw=3D%s&quot;=
,</span><br><span>          np(context-&gt;test_valid_user), np(username), =
np(context-&gt;test_valid_pass), np(password));</span><br><span>@@ -279,7 +=
279,7 @@</span><br><span> </span><br><span> </span><br><span> static int</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-auth_user_pass_verify(st=
ruct plugin_context *context, struct plugin_per_client_context *pcc,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+auth_user_pass_verify(cons=
t struct plugin_context *context, struct plugin_per_client_context *pcc,</s=
pan><br><span>                       const char *argv[], const char *envp[]=
)</span><br><span> {</span><br><span>     /* get username/password from env=
p string array */</span><br><span>diff --git a/sample/sample-plugins/keying=
-material-exporter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/=
keying-material-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>in=
dex 25c9ff5=2E=2E512861a 100644</span><br><span>--- a/sample/sample-plugins=
/keying-material-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>+=
++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexpo=
rter=2Ec</span><br><span>@@ -186,7 +186,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-file_store(char *file, char *content)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+file_store(const char *file, const char *=
content)</span><br><span> {</span><br><span>     FILE *f;</span><br><span> =
    if (!(f =3D fopen(file, &quot;w+&quot;)))</span><br><span>@@ -202,7 +20=
2,7 @@</span><br><span> server_store(struct openvpn_plugin_args_func_in con=
st *args)</span><br><span> {</span><br><span>     struct plugin *plugin =3D=
 (struct plugin *)args-&gt;handle;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct session *sess =3D (struct session *)args-&gt;per_cl=
ient_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct session *sess =3D (struct session *)args-&gt;per_client_context;=
</span><br><span> </span><br><span>     char file[MAXPATH];</span><br><span=
>     snprintf(file, sizeof(file) - 1, &quot;/tmp/openvpn_sso_%s&quot;, ses=
s-&gt;key);</span><br><span>@@ -214,7 +214,7 @@</span><br><span> client_sto=
re(struct openvpn_plugin_args_func_in const *args)</span><br><span> {</span=
><br><span>     struct plugin *plugin =3D (struct plugin *)args-&gt;handle;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct session *s=
ess =3D (struct session *)args-&gt;per_client_context;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct session *sess =3D (stru=
ct session *)args-&gt;per_client_context;</span><br><span> </span><br><span=
>     char *file =3D &quot;/tmp/openvpn_sso_user&quot;;</span><br><span>   =
  ovpn_note(&quot;app session file: %s&quot;, file);</span><br><span>diff -=
-git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>inde=
x f57c8c2=2E=2E2f4d037 100644</span><br><span>--- a/src/openvpn/buffer=2Ec<=
/span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -290,7 +290=
,7 @@</span><br><span>  * truncated by buf_printf</span><br><span>  */</spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_=
catrunc(struct buffer *buf, const char *str)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+buf_catrunc(const struct buffer *buf, const char *=
str)</span><br><span> {</span><br><span>     if (buf_forward_capacity(buf) =
&lt;=3D 1)</span><br><span>     {</span><br><span>@@ -1091,7 +1091,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-string_check_buf(struct buffer *buf, cons=
t unsigned int inclusive, const unsigned int exclusive)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+string_check_buf(const struct buffer *b=
uf, const unsigned int inclusive, const unsigned int exclusive)</span><br><=
span> {</span><br><span>     ASSERT(buf);</span><br><span> </span><br><span=
>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><sp=
an>index 93aa786=2E=2Ea425737 100644</span><br><span>--- a/src/openvpn/buff=
er=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -488=
,7 +488,7 @@</span><br><span>  * write a string to the end of a buffer that=
 was</span><br><span>  * truncated by buf_printf</span><br><span>  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void buf_catrunc(struct buf=
fer *buf, const char *str);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void buf_catrunc(const struct buffer *buf, const char *str);</span>=
<br><span> </span><br><span> /*</span><br><span>  * Parse a string based on=
 a given delimiter char</span><br><span>@@ -782,7 +782,7 @@</span><br><span=
> }</span><br><span> </span><br><span> static inline int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-buf_peek_u8(struct buffer *buf)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+buf_peek_u8(const struct buf=
fer *buf)</span><br><span> {</span><br><span>     int ret;</span><br><span>=
     if (BLEN(buf) &lt; 1)</span><br><span>@@ -955,7 +955,7 @@</span><br><s=
pan>  * @param exclusive Character classes that are not allowed even if the=
y are also in inclusive=2E</span><br><span>  * @return True if the string c=
onsists only of allowed characters, false otherwise=2E</span><br><span>  */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool string_check_buf=
(struct buffer *buf, const unsigned int inclusive,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool string_check_buf(const struct buffer *b=
uf, const unsigned int inclusive,</span><br><span>                       co=
nst unsigned int exclusive);</span><br><span> </span><br><span> /**</span><=
br><span>diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec</span=
><br><span>index 32c1325=2E=2Eb465950 100644</span><br><span>--- a/src/open=
vpn/clinat=2Ec</span><br><span>+++ b/src/openvpn/clinat=2Ec</span><br><span=
>@@ -159,7 +159,7 @@</span><br><span> #endif</span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-print=
_pkt(struct openvpn_iphdr *iph, const char *prefix, const int direction, co=
nst msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+print_pkt(const struct openvpn_iphdr *iph, const char *prefix, const int=
 direction, const msglvl_t msglevel)</span><br><span> {</span><br><span>   =
  struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -18=
1,7 +181,7 @@</span><br><span> }</span><br><span> </span><br><span> void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-client_nat_transform(con=
st struct client_nat_option_list *list, struct buffer *ipbuf,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+client_nat_transform(const struct=
 client_nat_option_list *list, const struct buffer *ipbuf,</span><br><span>=
                      const int direction)</span><br><span> {</span><br><sp=
an>     struct ip_tcp_udp_hdr *h =3D (struct ip_tcp_udp_hdr *)BPTR(ipbuf);<=
/span><br><span>diff --git a/src/openvpn/clinat=2Eh b/src/openvpn/clinat=2E=
h</span><br><span>index 1e8ceb3=2E=2Ebc56037 100644</span><br><span>--- a/s=
rc/openvpn/clinat=2Eh</span><br><span>+++ b/src/openvpn/clinat=2Eh</span><b=
r><span>@@ -60,7 +60,7 @@</span><br><span>                                 =
   const char *network, const char *netmask,</span><br><span>              =
                      const char *foreign_network, msglvl_t msglevel);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void cli=
ent_nat_transform(const struct client_nat_option_list *list, struct buffer =
*ipbuf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void client_=
nat_transform(const struct client_nat_option_list *list, const struct buffe=
r *ipbuf,</span><br><span>                           const int direction);<=
/span><br><span> </span><br><span> #endif /* if !defined(CLINAT_H) */</span=
><br><span>diff --git a/src/openvpn/comp=2Ec b/src/openvpn/comp=2Ec</span><=
br><span>index b88b79f=2E=2E387a7c4 100644</span><br><span>--- a/src/openvp=
n/comp=2Ec</span><br><span>+++ b/src/openvpn/comp=2Ec</span><br><span>@@ -1=
59,7 +159,7 @@</span><br><span> #endif /* USE_COMP */</span><br><span> </sp=
an><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-che=
ck_compression_settings_valid(struct compress_options *info, msglvl_t msgle=
vel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_compressi=
on_settings_valid(const struct compress_options *info, msglvl_t msglevel)</=
span><br><span> {</span><br><span>     /*</span><br><span>      * We also a=
llow comp-stub-v2 here as it technically allows escaping of</span><br><span=
>diff --git a/src/openvpn/comp=2Eh b/src/openvpn/comp=2Eh</span><br><span>i=
ndex 29a90a2=2E=2Ead80243 100644</span><br><span>--- a/src/openvpn/comp=2Eh=
</span><br><span>+++ b/src/openvpn/comp=2Eh</span><br><span>@@ -91,7 +91,7 =
@@</span><br><span>  * flags of allow-compression and also the whether algo=
rithms are compiled</span><br><span>  * in</span><br><span>  */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-bool check_compression_settings_v=
alid(struct compress_options *info, msglvl_t msglevel);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool check_compression_settings_valid(c=
onst struct compress_options *info, msglvl_t msglevel);</span><br><span> </=
span><br><span> #ifdef USE_COMP</span><br><span> #include &quot;buffer=2Eh&=
quot;</span><br><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/cry=
pto=2Ec</span><br><span>index 67ff0d3=2E=2E5753e4f 100644</span><br><span>-=
-- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</s=
pan><br><span>@@ -1105,7 +1105,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-key_is_zero(struct key *key, const struct key_type *kt)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+key_is_zero(const struct key *key,=
 const struct key_type *kt)</span><br><span> {</span><br><span>     size_t =
cipher_length =3D cipher_kt_key_size(kt-&gt;cipher);</span><br><span>     f=
or (size_t i =3D 0; i &lt; cipher_length; ++i)</span><br><span>@@ -1123,7 +=
1123,7 @@</span><br><span>  * Make sure that cipher key is a valid key for =
current key_type=2E</span><br><span>  */</span><br><span> bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-check_key(struct key *key, const s=
truct key_type *kt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
check_key(const struct key *key, const struct key_type *kt)</span><br><span=
> {</span><br><span>     if (cipher_defined(kt-&gt;cipher))</span><br><span=
>     {</span><br><span>@@ -1196,7 +1196,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-test_crypto(struct crypto_options *co, struct frame *frame)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_crypto(struct crypto_o=
ptions *co, const struct frame *frame)</span><br><span> {</span><br><span> =
    int i, j;</span><br><span>     struct gc_arena gc =3D gc_new();</span><=
br><span>diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh</span=
><br><span>index ee5b50f=2E=2Ee3c1c6a 100644</span><br><span>--- a/src/open=
vpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><br><span=
>@@ -414,7 +414,7 @@</span><br><span>  */</span><br><span> int write_key_fi=
le(const int nkeys, const char *filename);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-bool check_key(struct key *key, cons=
t struct key_type *kt);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool check_key(const struct key *key, const struct key_type *kt);</span=
><br><span> </span><br><span> /**</span><br><span>  * Initialize a key_type=
 structure with=2E</span><br><span>@@ -614,7 +614,7 @@</span><br><span> /**=
 Print a cipher list entry */</span><br><span> void print_cipher(const char=
 *cipher);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void test_crypto(struct crypto_options *co, struct frame *f);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void test_crypto(struct cr=
ypto_options *co, const struct frame *f);</span><br><span> </span><br><span=
> </span><br><span> /* key direction functions */</span><br><span>diff --gi=
t a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index f5d409d=
=2E=2Efd56787 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><s=
pan>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -572,7 +572,7 @@</span><br=
><span> }</span><br><span> </span><br><span> static bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-dco_multi_get_localaddr(struct multi_con=
text *m, struct multi_instance *mi,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+dco_multi_get_localaddr(const struct multi_context *m, cons=
t struct multi_instance *mi,</span><br><span>                         struc=
t sockaddr_storage *local)</span><br><span> {</span><br><span> #if ENABLE_I=
P_PKTINFO</span><br><span>@@ -584,7 +584,7 @@</span><br><span>         retu=
rn false;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct link_socket_actual *actual =3D &amp=
;c-&gt;c2=2Elink_socket_infos[0]-&gt;lsa-&gt;actual;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct link_socket_actual *actu=
al =3D &amp;c-&gt;c2=2Elink_socket_infos[0]-&gt;lsa-&gt;actual;</span><br><=
span> </span><br><span>     switch (actual-&gt;dest=2Eaddr=2Esa=2Esa_family=
)</span><br><span>     {</span><br><span>@@ -622,7 +622,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-dco_multi_add_new_peer(struct multi_context *m, struc=
t multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+dco_multi_add_new_peer(const struct multi_context *m, struct multi_instan=
ce *mi)</span><br><span> {</span><br><span>     const struct context *c =3D=
 &amp;mi-&gt;context;</span><br><span> </span><br><span>@@ -676,7 +676,7 @@=
</span><br><span> }</span><br><span> </span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-dco_install_iroute(struct multi_conte=
xt *m, struct multi_instance *mi, struct mroute_addr *addr)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+dco_install_iroute(struct multi_con=
text *m, struct multi_instance *mi, const struct mroute_addr *addr)</span><=
br><span> {</span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FR=
EEBSD) || defined(_WIN32)</span><br><span>     if (!dco_enabled(&amp;m-&gt;=
top=2Eoptions))</span><br><span>@@ -795,7 +795,7 @@</span><br><span>       =
  /* Checked if we added a host route as the assigned client IP address was=
</span><br><span>          * outside the --ifconfig-ipv6 tun interface conf=
ig */</span><br><span> #if !defined(_WIN32)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        struct in6_addr *dest =3D &amp;mi-&gt;context=
=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const struct in6_addr *dest =3D &amp;mi-&gt;context=
=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span>         if (multi_check_=
push_ifconfig_ipv6_extra_route(mi, dest))</span><br><span>         {</span>=
<br><span>             /* On windows we do not install these routes, so we =
also do not need to delete them */</span><br><span>diff --git a/src/openvpn=
/dco=2Eh b/src/openvpn/dco=2Eh</span><br><span>index 4e5aad5=2E=2E694875c 1=
00644</span><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/o=
penvpn/dco=2Eh</span><br><span>@@ -204,7 +204,7 @@</span><br><span>  * @par=
am mi        the client instance</span><br><span>  * @return          0 on =
success or a negative error code otherwise</span><br><span>  */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-int dco_multi_add_new_peer(struct=
 multi_context *m, struct multi_instance *mi);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+int dco_multi_add_new_peer(const struct multi_co=
ntext *m, struct multi_instance *mi);</span><br><span> </span><br><span> /*=
*</span><br><span>  * Install an iroute in DCO, which means adding a route =
to the system routing</span><br><span>@@ -215,7 +215,7 @@</span><br><span> =
 * @param addr      the route to add</span><br><span>  */</span><br><span> =
void dco_install_iroute(struct multi_context *m, struct multi_instance *mi,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
   struct mroute_addr *addr);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        const struct mroute_addr *addr);</span><b=
r><span> </span><br><span> /**</span><br><span>  * Remove all routes added =
through the specified client</span><br><span>@@ -253,7 +253,7 @@</span><br>=
<span>  * a 64 bit packet counter and AEAD tag at the end=2E</span><br><spa=
n>  */</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-dco_supports_epoch_data(struct context *c);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct context=
 *c);</span><br><span> #else  /* if defined(ENABLE_DCO) */</span><br><span>=
 </span><br><span> typedef void *dco_context_t;</span><br><span>@@ -350,7 +=
350,7 @@</span><br><span> }</span><br><span> </span><br><span> static inlin=
e int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_multi_add_ne=
w_peer(struct multi_context *m, struct multi_instance *mi)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+dco_multi_add_new_peer(const struct =
multi_context *m, struct multi_instance *mi)</span><br><span> {</span><br><=
span>     return 0;</span><br><span> }</span><br><span>@@ -384,7 +384,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> static inline bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(=
struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
co_supports_epoch_data(const struct context *c)</span><br><span> {</span><b=
r><span>     return false;</span><br><span> }</span><br><span>diff --git a/=
src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br><span>i=
ndex d933aaf=2E=2E7346903 100644</span><br><span>--- a/src/openvpn/dco_free=
bsd=2Ec</span><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@=
@ -930,7 +930,7 @@</span><br><span> }</span><br><span> </span><br><span> bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_=
data(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+dco_supports_epoch_data(const struct context *c)</span><br><span> {</sp=
an><br><span>     return false;</span><br><span> }</span><br><span>diff --g=
it a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh</span><br>=
<span>index fcf8aca=2E=2E1022e66 100644</span><br><span>--- a/src/openvpn/d=
co_internal=2Eh</span><br><span>+++ b/src/openvpn/dco_internal=2Eh</span><b=
r><span>@@ -59,8 +59,9 @@</span><br><span>  * They are implemented by dco_l=
inux=2Ec</span><br><span>  */</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-int dco_new_peer(dco_context_t *dco, unsigned int=
 peerid, socket_descriptor_t sd, struct sockaddr *localaddr,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                 struct sockaddr *re=
moteaddr, const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_new_peer(dc=
o_context_t *dco, unsigned int peerid, socket_descriptor_t sd,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                 struct sockaddr=
 *localaddr, struct sockaddr *remoteaddr,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                 const struct in_addr *vpn_ipv4, cons=
t struct in6_addr *vpn_ipv6);</span><br><span> </span><br><span> int dco_de=
l_peer(dco_context_t *dco, unsigned int peerid);</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec<=
/span><br><span>index 56f6259=2E=2E31bbe87 100644</span><br><span>--- a/src=
/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</spa=
n><br><span>@@ -114,7 +114,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> static struct nl_msg *</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_nlmsg_create(const =
dco_context_t *dco, uint8_t cmd)</span><br><span> {</span><br><span>     st=
ruct nl_msg *nl_msg =3D nlmsg_alloc();</span><br><span>     if (!nl_msg)</s=
pan><br><span>@@ -804,7 +804,7 @@</span><br><span> </span><br><span> /* lib=
nl &lt; 3=2E11=2E0 does not implement nla_get_uint() */</span><br><span> st=
atic uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_nla=
_get_uint(struct nlattr *attr)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ovpn_nla_get_uint(const struct nlattr *attr)</span><br><span> {<=
/span><br><span>     if (nla_len(attr) =3D=3D sizeof(uint32_t))</span><br><=
span>     {</span><br><span>@@ -916,7 +916,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> static bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[=
])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_iface_check(=
const dco_context_t *dco, struct nlattr *attrs[])</span><br><span> {</span>=
<br><span>     /* we must know which interface this message is referring to=
 in order to</span><br><span>      * avoid mixing messages for other instan=
ces</span><br><span>@@ -1340,7 +1340,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-dco_supports_epoch_data(struct context *c)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct context *c)=
</span><br><span> {</span><br><span>     return false;</span><br><span> }</=
span><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=
=2Ec</span><br><span>index b3268bc=2E=2E8deb9d8 100644</span><br><span>--- =
a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</sp=
an><br><span>@@ -1100,7 +1100,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco=
_supports_epoch_data(struct context *c)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+dco_supports_epoch_data(const struct context *c)</span>=
<br><span> {</span><br><span>     OVPN_VERSION ver =3D { 0 };</span><br><sp=
an>     return dco_get_version(&amp;ver) &amp;&amp; ((ver=2EMajor =3D=3D 2 =
&amp;&amp; ver=2EMinor &gt;=3D 8) || (ver=2EMajor &gt; 2));</span><br><span=
>diff --git a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec</span><br><span>i=
ndex a54ab3f=2E=2E68173e6 100644</span><br><span>--- a/src/openvpn/dhcp=2Ec=
</span><br><span>+++ b/src/openvpn/dhcp=2Ec</span><br><span>@@ -145,7 +145,=
7 @@</span><br><span> }</span><br><span> </span><br><span> in_addr_t</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-dhcp_extract_router_msg(stru=
ct buffer *ipbuf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dh=
cp_extract_router_msg(const struct buffer *ipbuf)</span><br><span> {</span>=
<br><span>     struct dhcp_full *df =3D (struct dhcp_full *)BPTR(ipbuf);</s=
pan><br><span>     const int optlen =3D</span><br><span>diff --git a/src/op=
envpn/dhcp=2Eh b/src/openvpn/dhcp=2Eh</span><br><span>index 38ebf8d=2E=2Eed=
8a0c9 100644</span><br><span>--- a/src/openvpn/dhcp=2Eh</span><br><span>+++=
 b/src/openvpn/dhcp=2Eh</span><br><span>@@ -91,7 +91,7 @@</span><br><span> =
</span><br><span> #pragma pack()</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-in_addr_t dhcp_extract_router_msg(struct buffe=
r *ipbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in_addr_t=
 dhcp_extract_router_msg(const struct buffer *ipbuf);</span><br><span> </sp=
an><br><span> #if defined(_WIN32) || defined(DHCP_UNIT_TEST)</span><br><spa=
n> #include &quot;tun=2Eh&quot;</span><br><span>diff --git a/src/openvpn/ev=
ent=2Eh b/src/openvpn/event=2Eh</span><br><span>index b784dfe=2E=2E0940a1d =
100644</span><br><span>--- a/src/openvpn/event=2Eh</span><br><span>+++ b/sr=
c/openvpn/event=2Eh</span><br><span>@@ -204,7 +204,7 @@</span><br><span> #e=
lse /* ifdef _WIN32 */</span><br><span> </span><br><span> static inline voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wait_signal(struct e=
vent_set *es, void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+wait_signal(const struct event_set *es, const void *arg)</span><br><sp=
an> {</span><br><span> }</span><br><span> </span><br><span>diff --git a/src=
/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 658199=
8=2E=2E4ddac11 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><=
br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -231,7 +231,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> static void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-parse_incoming_control_channel_=
command(struct context *c, struct buffer *buf)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+parse_incoming_control_channel_command(struct co=
ntext *c, const struct buffer *buf)</span><br><span> {</span><br><span>    =
 if (buf_string_match_head_str(buf, &quot;AUTH_FAILED&quot;))</span><br><sp=
an>     {</span><br><span>@@ -501,7 +501,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-get_server_poll_remaining_time(struct event_timeout *server_poll_tim=
eout)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_server_pol=
l_remaining_time(const struct event_timeout *server_poll_timeout)</span><br=
><span> {</span><br><span>     update_time();</span><br><span>     int rema=
ining =3D event_timeout_remaining(server_poll_timeout);</span><br><span>@@ =
-598,7 +598,7 @@</span><br><span>  * Buffer reallocation, for use with null=
 encryption=2E</span><br><span>  */</span><br><span> static inline void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-buffer_turnover(const uin=
t8_t *orig_buf, struct buffer *dest_stub, struct buffer *src_stub,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+buffer_turnover(const uint8_=
t *orig_buf, struct buffer *dest_stub, const struct buffer *src_stub,</span=
><br><span>                 struct buffer *storage)</span><br><span> {</spa=
n><br><span>     if (orig_buf =3D=3D src_stub-&gt;data &amp;&amp; src_stub-=
&gt;data !=3D storage-&gt;data)</span><br><span>@@ -885,7 +885,7 @@</span><=
br><span>  */</span><br><span> </span><br><span> static inline void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-socks_postprocess_incoming_li=
nk(struct context *c, struct link_socket *sock)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+socks_postprocess_incoming_link(struct context =
*c, const struct link_socket *sock)</span><br><span> {</span><br><span>    =
 if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;info=2Eproto =3D=3D PROTO_UDP=
)</span><br><span>     {</span><br><span>@@ -982,7 +982,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-process_incoming_link_part1(struct context *c, struc=
t link_socket_info *lsi, bool floated)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+process_incoming_link_part1(struct context *c, const str=
uct link_socket_info *lsi, bool floated)</span><br><span> {</span><br><span=
>     struct gc_arena gc =3D gc_new();</span><br><span>     bool decrypt_st=
atus =3D false;</span><br><span>@@ -1532,7 +1532,7 @@</span><br><span>  * @=
param client    Determines whether to the send packet back via tun or link<=
/span><br><span>  */</span><br><span> void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-ipv6_send_icmp_unreachable(struct context *c, struct b=
uffer *buf, bool client)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ipv6_send_icmp_unreachable(struct context *c, const struct buffer *buf=
, bool client)</span><br><span> {</span><br><span> #define MAX_ICMPV6LEN 12=
80</span><br><span>     struct openvpn_icmp6hdr icmp6out;</span><br><span>d=
iff --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><sp=
an>index 324c0b4=2E=2Eee7d2e2 100644</span><br><span>--- a/src/openvpn/forw=
ard=2Eh</span><br><span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -1=
27,7 +127,7 @@</span><br><span>  */</span><br><span> void encrypt_sign(stru=
ct context *c, bool comp_frag);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-int get_server_poll_remaining_time(struct event=
_timeout *server_poll_timeout);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+int get_server_poll_remaining_time(const struct event_timeout *=
server_poll_timeout);</span><br><span> </span><br><span> /*****************=
*****************************************************/</span><br><span> /**=
</span><br><span>@@ -178,7 +178,7 @@</span><br><span>  *</span><br><span>  =
* @return true if packet is authenticated, false otherwise=2E</span><br><sp=
an>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool process_i=
ncoming_link_part1(struct context *c, struct link_socket_info *lsi, bool fl=
oated);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool process=
_incoming_link_part1(struct context *c, const struct link_socket_info *lsi,=
 bool floated);</span><br><span> </span><br><span> /**</span><br><span>  * =
Continues processing a packet read from the external network interface=2E</=
span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</sp=
an><br><span>index 218a663=2E=2E11042f0 100644</span><br><span>--- a/src/op=
envpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@=
@ -818,7 +818,7 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_port_sh=
are(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+init_port_share(const struct context *c)</span><br><span> {</span><br><s=
pan>     if (!port_share &amp;&amp; (c-&gt;options=2Eport_share_host &amp;&=
amp; c-&gt;options=2Eport_share_port))</span><br><span>     {</span><br><sp=
an>@@ -1265,7 +1265,7 @@</span><br><span>  * prepending to msg() output=2E<=
/span><br><span>  */</span><br><span> const char *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-format_common_name(struct context *c, struct g=
c_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+format_=
common_name(const struct context *c, struct gc_arena *gc)</span><br><span> =
{</span><br><span>     struct buffer out =3D alloc_buf_gc(256, gc);</span><=
br><span>     if (c-&gt;c2=2Etls_multi)</span><br><span>@@ -1751,7 +1751,7 =
@@</span><br><span> </span><br><span> </span><br><span> static bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-can_preserve_tun(struct tunta=
p *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+can_preserve_=
tun(const struct tuntap *tt)</span><br><span> {</span><br><span>     if (tt=
 &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>   =
  {</span><br><span>@@ -1773,7 +1773,7 @@</span><br><span>  * @param c poin=
ter to the connection context</span><br><span>  */</span><br><span> static =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_wfp_block(str=
uct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_=
wfp_block(const struct context *c)</span><br><span> {</span><br><span> #if =
defined(_WIN32)</span><br><span>     /* Fortify &#39;redirect-gateway block=
-local&#39; with firewall rules? */</span><br><span>@@ -1799,7 +1799,7 @@</=
span><br><span>  * @param adapter_index the VPN adapter index</span><br><sp=
an>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-del_wfp_block(struct context *c, unsigned long adapter_index=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+del_wfp_block(cons=
t struct context *c, unsigned long adapter_index)</span><br><span> {</span>=
<br><span> #if defined(_WIN32)</span><br><span>     if (c-&gt;options=2Eblo=
ck_outside_dns || block_local_needed(c-&gt;c1=2Eroute_list))</span><br><spa=
n>diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh</span><br><span>=
index 9d5050d=2E=2Eaf4393c 100644</span><br><span>--- a/src/openvpn/init=2E=
h</span><br><span>+++ b/src/openvpn/init=2Eh</span><br><span>@@ -91,7 +91,7=
 @@</span><br><span> </span><br><span> unsigned int pull_permission_mask(co=
nst struct context *c);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-const char *format_common_name(struct context *c, struc=
t gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+con=
st char *format_common_name(const struct context *c, struct gc_arena *gc);<=
/span><br><span> </span><br><span> void reset_coarse_timers(struct context =
*c);</span><br><span> </span><br><span>diff --git a/src/openvpn/interval=2E=
h b/src/openvpn/interval=2Eh</span><br><span>index 59051bd=2E=2E0cfe202 100=
644</span><br><span>--- a/src/openvpn/interval=2Eh</span><br><span>+++ b/sr=
c/openvpn/interval=2Eh</span><br><span>@@ -89,7 +89,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static inline void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-interval_schedule_wakeup(struct interval *=
top, interval_t *wakeup)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+interval_schedule_wakeup(const struct interval *top, interval_t *wakeu=
p)</span><br><span> {</span><br><span>     const time_t local_now =3D now;<=
/span><br><span>     interval_earliest_wakeup(wakeup, top-&gt;last_test_tru=
e + top-&gt;refresh, local_now);</span><br><span>@@ -214,7 +214,7 @@</span>=
<br><span>  * This function does not check if the timeout is actually valid=
=2E</span><br><span>  */</span><br><span> static inline interval_t</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-event_timeout_remaining(struct=
 event_timeout *et)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
event_timeout_remaining(const struct event_timeout *et)</span><br><span> {<=
/span><br><span>     return (interval_t)((et-&gt;last + et-&gt;n) - now);</=
span><br><span> }</span><br><span>diff --git a/src/openvpn/list=2Ec b/src/o=
penvpn/list=2Ec</span><br><span>index 2553579=2E=2E45b4f54 100644</span><br=
><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2E=
c</span><br><span>@@ -167,7 +167,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
hash_remove_by_value(struct hash *hash, void *value)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+hash_remove_by_value(struct hash *hash, c=
onst void *value)</span><br><span> {</span><br><span>     struct hash_itera=
tor hi;</span><br><span>     const struct hash_element *he;</span><br><span=
>diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>i=
ndex cbf1abf=2E=2E07df3c14 100644</span><br><span>--- a/src/openvpn/list=2E=
h</span><br><span>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -78,7 +78,7=
 @@</span><br><span> </span><br><span> bool hash_remove_fast(struct hash *h=
ash, struct hash_bucket *bucket, const void *key, uint64_t hv);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void hash_remov=
e_by_value(struct hash *hash, void *value);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void hash_remove_by_value(struct hash *hash, const =
void *value);</span><br><span> </span><br><span> struct hash_iterator</span=
><br><span> {</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/ope=
nvpn/manage=2Ec</span><br><span>index 604bbcd=2E=2E17abfd8 100644</span><br=
><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manag=
e=2Ec</span><br><span>@@ -330,7 +330,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-man_delete_unix_socket(struct management *man)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+man_delete_unix_socket(const struct m=
anagement *man)</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPORT</=
span><br><span>     if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_=
CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><span>@@ -675,7 +675,7 @=
@</span><br><span>  * for the log and echo commands=2E</span><br><span>  */=
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-man_history(struct management *man, const char *parm, const char *t=
ype, struct log_history *log,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+man_history(struct management *man, const char *parm, const char =
*type, const struct log_history *log,</span><br><span>             bool *re=
altime, const unsigned int lep_flags)</span><br><span> {</span><br><span>  =
   struct gc_arena gc =3D gc_new();</span><br><span>@@ -843,7 +843,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-man_forget_passwords(struct manage=
ment *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_forge=
t_passwords(const struct management *man)</span><br><span> {</span><br><spa=
n>     ssl_purge_auth(false);</span><br><span>     (void)ssl_clean_auth_tok=
en();</span><br><span>@@ -851,7 +851,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-man_net(struct management *man)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+man_net(const struct management *man)</span><br><spa=
n> {</span><br><span>     if (man-&gt;persist=2Ecallback=2Eshow_net)</span>=
<br><span>     {</span><br><span>@@ -887,7 +887,7 @@</span><br><span> #ifde=
f ENABLE_PKCS11</span><br><span> </span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-man_pkcs11_id_count(struct managem=
ent *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_pkcs11=
_id_count(const struct management *man)</span><br><span> {</span><br><span>=
     msg(M_CLIENT, &quot;&gt;PKCS11ID-COUNT:%d&quot;, pkcs11_management_id_=
count());</span><br><span> }</span><br><span>@@ -1350,7 +1350,7 @@</span><b=
r><span>  * @return          Return whether p has n (or at least n) paramet=
ers</span><br><span>  */</span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-man_need(struct management *man, const char=
 **p, const int n, unsigned int flags)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+man_need(const struct management *man, const char **p, c=
onst int n, unsigned int flags)</span><br><span> {</span><br><span>     int=
 i;</span><br><span>     ASSERT(p[0]);</span><br><span>@@ -2365,7 +2365,7 @=
@</span><br><span>  * the route/ifconfig/open tun command=2E   See doc/andr=
oid=2Etxt for details=2E</span><br><span>  */</span><br><span> bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-management_android_control(st=
ruct management *man, const char *command, const char *msg)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+management_android_control(const st=
ruct management *man, const char *command, const char *msg)</span><br><span=
> {</span><br><span>     if (!man)</span><br><span>     {</span><br><span>@=
@ -3013,7 +3013,7 @@</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_up_dow=
n(struct management *man, const char *updown, const struct env_set *es)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+management_up_down(cons=
t struct management *man, const char *updown, const struct env_set *es)</sp=
an><br><span> {</span><br><span>     if (man-&gt;settings=2Eflags &amp; MF_=
UP_DOWN)</span><br><span>     {</span><br><span>@@ -3023,13 +3023,13 @@</sp=
an><br><span> }</span><br><span> </span><br><span> void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-management_notify(struct management *man,=
 const char *severity, const char *type, const char *text)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+management_notify(const struct manag=
ement *man, const char *severity, const char *type, const char *text)</span=
><br><span> {</span><br><span>     msg(M_CLIENT, &quot;&gt;NOTIFY:%s,%s,%s&=
quot;, severity, type, text);</span><br><span> }</span><br><span> </span><b=
r><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-manageme=
nt_notify_generic(struct management *man, const char *str)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+management_notify_generic(const stru=
ct management *man, const char *str)</span><br><span> {</span><br><span>   =
  msg(M_CLIENT, &quot;%s&quot;, str);</span><br><span> }</span><br><span>@@=
 -3115,7 +3115,8 @@</span><br><span> }</span><br><span> </span><br><span> v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_notify_=
client_close(struct management *management, struct man_def_auth_context *md=
ac,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_notif=
y_client_close(const struct management *management,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                               struct man=
_def_auth_context *mdac,</span><br><span>                                co=
nst struct env_set *es)</span><br><span> {</span><br><span>     if ((mdac-&=
gt;flags &amp; DAF_INITIAL_AUTH) &amp;&amp; !(mdac-&gt;flags &amp; DAF_CONN=
ECTION_CLOSED))</span><br><span>@@ -3206,7 +3207,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-management_auth_failure(struct management *man, const char =
*type, const char *reason)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+management_auth_failure(const struct management *man, const char *ty=
pe, const char *reason)</span><br><span> {</span><br><span>     if (reason)=
</span><br><span>     {</span><br><span>@@ -3219,7 +3220,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-management_auth_token(struct management *man, const=
 char *token)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+manage=
ment_auth_token(const struct management *man, const char *token)</span><br>=
<span> {</span><br><span>     msg(M_CLIENT, &quot;&gt;PASSWORD:Auth-Token:%=
s&quot;, token);</span><br><span> }</span><br><span>diff --git a/src/openvp=
n/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 1be3549=2E=2E71=
680a6 100644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+=
++ b/src/openvpn/manage=2Eh</span><br><span>@@ -362,7 +362,7 @@</span><br><=
span>                                 const unsigned int flags, const char =
*static_challenge);</span><br><span> </span><br><span> #ifdef TARGET_ANDROI=
D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool management_andr=
oid_control(struct management *man, const char *command, const char *msg);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool management_andr=
oid_control(const struct management *man, const char *command, const char *=
msg);</span><br><span> </span><br><span> #define ANDROID_KEEP_OLD_TUN      =
1</span><br><span> #define ANDROID_OPEN_BEFORE_CLOSE 2</span><br><span>@@ -=
376,12 +376,12 @@</span><br><span> </span><br><span> void management_event_=
loop_n_seconds(struct management *man, int sec);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void management_up_down(struct=
 management *man, const char *updown, const struct env_set *es);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void management_up_down(const =
struct management *man, const char *updown, const struct env_set *es);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void man=
agement_notify(struct management *man, const char *severity, const char *ty=
pe,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void management_=
notify(const struct management *man, const char *severity, const char *type=
,</span><br><span>                        const char *text);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void management_no=
tify_generic(struct management *man, const char *str);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void management_notify_generic(const str=
uct management *man, const char *str);</span><br><span> </span><br><span> v=
oid management_notify_client_needing_auth(struct management *management,</s=
pan><br><span>                                            const unsigned in=
t auth_id,</span><br><span>@@ -391,7 +391,7 @@</span><br><span> void manage=
ment_connection_established(struct management *management,</span><br><span>=
                                        struct man_def_auth_context *mdac, =
const struct env_set *es);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void management_notify_client_close(struct managemen=
t *management,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
management_notify_client_close(const struct management *management,</span><=
br><span>                                     struct man_def_auth_context *=
mdac, const struct env_set *es);</span><br><span> </span><br><span> void ma=
nagement_learn_addr(struct management *management, struct man_def_auth_cont=
ext *mdac,</span><br><span>@@ -476,12 +476,12 @@</span><br><span>  * OpenVP=
N calls here to indicate a password failure</span><br><span>  */</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void managemen=
t_auth_failure(struct management *man, const char *type, const char *reason=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void management_a=
uth_failure(const struct management *man, const char *type, const char *rea=
son);</span><br><span> </span><br><span> /*</span><br><span>  * Echo an aut=
hentication token to management interface</span><br><span>  */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void management_auth_token(struct =
management *man, const char *token);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void management_auth_token(const struct management *man, c=
onst char *token);</span><br><span> </span><br><span> /*</span><br><span>  =
* These functions drive the bytecount in/out counters=2E</span><br><span>di=
ff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec</span><br><span>inde=
x 7b790ed=2E=2E9a37e30 100644</span><br><span>--- a/src/openvpn/mbuf=2Ec</s=
pan><br><span>+++ b/src/openvpn/mbuf=2Ec</span><br><span>@@ -149,7 +149,7 @=
@</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-mbuf_dereference_instance(struct mbu=
f_set *ms, struct multi_instance *mi)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+mbuf_dereference_instance(struct mbuf_set *ms, const stru=
ct multi_instance *mi)</span><br><span> {</span><br><span>     if (ms)</spa=
n><br><span>     {</span><br><span>diff --git a/src/openvpn/mbuf=2Eh b/src/=
openvpn/mbuf=2Eh</span><br><span>index cfe698c=2E=2Ee368054 100644</span><b=
r><span>--- a/src/openvpn/mbuf=2Eh</span><br><span>+++ b/src/openvpn/mbuf=
=2Eh</span><br><span>@@ -75,7 +75,7 @@</span><br><span> </span><br><span> b=
ool mbuf_extract_item(struct mbuf_set *ms, struct mbuf_item *item);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void mbuf_d=
ereference_instance(struct mbuf_set *ms, struct multi_instance *mi);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void mbuf_dereference_inst=
ance(struct mbuf_set *ms, const struct multi_instance *mi);</span><br><span=
> </span><br><span> static inline bool</span><br><span> mbuf_defined(const =
struct mbuf_set *ms)</span><br><span>diff --git a/src/openvpn/mss=2Ec b/src=
/openvpn/mss=2Ec</span><br><span>index 36bbb43=2E=2Ea7242a8 100644</span><b=
r><span>--- a/src/openvpn/mss=2Ec</span><br><span>+++ b/src/openvpn/mss=2Ec=
</span><br><span>@@ -43,7 +43,7 @@</span><br><span>  *              if yes,=
 hand to mss_fixup_dowork()</span><br><span>  */</span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-mss_fixup_ipv4(struct buff=
er *buf, uint16_t maxmss)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+mss_fixup_ipv4(const struct buffer *buf, uint16_t maxmss)</span><br><=
span> {</span><br><span>     const struct openvpn_iphdr *pip;</span><br><sp=
an>     int hlen;</span><br><span>@@ -80,7 +80,7 @@</span><br><span>  *    =
          (IPv6 header structure is sufficiently different from IPv4=2E=2E=
=2E)</span><br><span>  */</span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-mss_fixup_ipv6(struct buffer *buf, uint16_t maxms=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mss_fixup_ipv6(co=
nst struct buffer *buf, uint16_t maxmss)</span><br><span> {</span><br><span=
>     const struct openvpn_ipv6hdr *pip6;</span><br><span>     struct buffe=
r newbuf;</span><br><span>@@ -136,7 +136,7 @@</span><br><span>  */</span><b=
r><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+mss_fixup_dowork(const struct b=
uffer *buf, uint16_t maxmss)</span><br><span> {</span><br><span>     int ol=
en, optlen;</span><br><span>     uint8_t *opt;</span><br><span>@@ -239,8 +2=
39,8 @@</span><br><span> }</span><br><span> </span><br><span> static void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-frame_calculate_fragmen=
t(struct frame *frame, struct key_type *kt, const struct options *options,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
   struct link_socket_info *lsi)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+frame_calculate_fragment(struct frame *frame, const struct key=
_type *kt, const struct options *options,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                         const struct link_socket_inf=
o *lsi)</span><br><span> {</span><br><span> #if defined(ENABLE_FRAGMENT)</s=
pan><br><span>     size_t overhead;</span><br><span>@@ -269,8 +269,8 @@</sp=
an><br><span> }</span><br><span> </span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-frame_calculate_mssfix(struct fram=
e *frame, struct key_type *kt, const struct options *options,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                       struct link_=
socket_info *lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fr=
ame_calculate_mssfix(struct frame *frame, const struct key_type *kt, const =
struct options *options,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                       const struct link_socket_info *lsi)</span><br><=
span> {</span><br><span>     if (options-&gt;ce=2Emssfix_fixed)</span><br><=
span>     {</span><br><span>@@ -314,8 +314,8 @@</span><br><span> }</span><b=
r><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-frame_calculate_dynamic(struct frame *frame, struct key_type *kt,=
 const struct options *options,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                        struct link_socket_info *lsi)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+frame_calculate_dynamic(struct =
frame *frame, const struct key_type *kt, const struct options *options,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 const struct link_socket_info *lsi)</span><br><span> {</span><br><span>   =
  if (options-&gt;ce=2Efragment &gt; 0)</span><br><span>     {</span><br><s=
pan>diff --git a/src/openvpn/mss=2Eh b/src/openvpn/mss=2Eh</span><br><span>=
index 1d092bb=2E=2E6b832a2 100644</span><br><span>--- a/src/openvpn/mss=2Eh=
</span><br><span>+++ b/src/openvpn/mss=2Eh</span><br><span>@@ -29,15 +29,15=
 @@</span><br><span> #include &quot;socket=2Eh&quot;</span><br><span> #incl=
ude &quot;ssl_common=2Eh&quot;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void mss_fixup_ipv4(struct buffer *buf, uint16_t=
 maxmss);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void mss_f=
ixup_ipv4(const struct buffer *buf, uint16_t maxmss);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void mss_fixup_ipv6(struc=
t buffer *buf, uint16_t maxmss);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void mss_fixup_ipv6(const struct buffer *buf, uint16_t maxmss)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void mss_fixup_dowork(const struct bu=
ffer *buf, uint16_t maxmss);</span><br><span> </span><br><span> /** Set the=
 --mssfix option=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void frame_calculate_dynamic(struct frame *frame, struct key_type *kt,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
    const struct options *options, struct link_socket_info *lsi);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void frame_calculate_dynamic(=
struct frame *frame, const struct key_type *kt,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                             const struct optio=
ns *options, const struct link_socket_info *lsi);</span><br><span> </span><=
br><span> /**</span><br><span>  * Checks and adjusts the fragment and mssfi=
x value according to the</span><br><span>diff --git a/src/openvpn/mtcp=2Ec =
b/src/openvpn/mtcp=2Ec</span><br><span>index 5d88f8a=2E=2E922db3f 100644</s=
pan><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/=
mtcp=2Ec</span><br><span>@@ -91,7 +91,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-multi_tcp_instance_specific_init(struct multi_context *m, struct multi=
_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi=
_tcp_instance_specific_init(const struct multi_context *m, struct multi_ins=
tance *mi)</span><br><span> {</span><br><span>     /* buffer for queued TCP=
 socket output packets */</span><br><span>     mi-&gt;tcp_link_out_deferred=
 =3D mbuf_init(m-&gt;top=2Eoptions=2En_bcast_buf);</span><br><span>diff --g=
it a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh</span><br><span>index 9b7d=
1d2=2E=2Ebb117fa 100644</span><br><span>--- a/src/openvpn/mtcp=2Eh</span><b=
r><span>+++ b/src/openvpn/mtcp=2Eh</span><br><span>@@ -35,7 +35,7 @@</span>=
<br><span> </span><br><span> void multi_tcp_dereference_instance(struct mul=
ti_io *multi_io, struct multi_instance *mi);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-bool multi_tcp_instance_specific_i=
nit(struct multi_context *m, struct multi_instance *mi);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool multi_tcp_instance_specific_init(=
const struct multi_context *m, struct multi_instance *mi);</span><br><span>=
 </span><br><span> void multi_tcp_instance_specific_free(struct multi_insta=
nce *mi);</span><br><span> </span><br><span>diff --git a/src/openvpn/mudp=
=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index def4769=2E=2E02f111d 1006=
44</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/ope=
nvpn/mudp=2Ec</span><br><span>@@ -74,7 +74,7 @@</span><br><span> </span><br=
><span> static void</span><br><span> send_hmac_reset_packet(struct multi_co=
ntext *m, struct tls_pre_decrypt_state *state,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                       struct tls_auth_standalone =
*tas, struct session_id *sid,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                       const struct tls_auth_standalone *tas, con=
st struct session_id *sid,</span><br><span>                        bool req=
uest_resend_wkc, struct link_socket *sock)</span><br><span> {</span><br><sp=
an>     reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=
=2Esend);</span><br><span>@@ -97,7 +97,7 @@</span><br><span> </span><br><sp=
an>     enum first_packet_verdict verdict;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct tls_auth_standalone *tas =
=3D m-&gt;top=2Ec2=2Etls_auth_standalone;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const struct tls_auth_standalone *tas =3D m-&gt;t=
op=2Ec2=2Etls_auth_standalone;</span><br><span> </span><br><span>     verdi=
ct =3D tls_pre_decrypt_lite(tas, state, &amp;m-&gt;top=2Ec2=2Efrom, &amp;m-=
&gt;top=2Ec2=2Ebuf);</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 862d5da=2E=2Ef=
ae3d5f 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+=
++ b/src/openvpn/multi=2Ec</span><br><span>@@ -57,7 +57,7 @@</span><br><spa=
n> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span> static =
const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-id(struct=
 multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+id(const struct multi_instance *mi)</span><br><span> {</span><br><span>   =
  if (mi)</span><br><span>     {</span><br><span>@@ -1315,7 +1315,7 @@</spa=
n><br><span>  * same common name=2E</span><br><span>  */</span><br><span> s=
tatic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_delet=
e_dup(struct multi_context *m, struct multi_instance *new_mi)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+multi_delete_dup(struct multi_con=
text *m, const struct multi_instance *new_mi)</span><br><span> {</span><br>=
<span>     if (new_mi)</span><br><span>     {</span><br><span>@@ -2260,7 +2=
260,7 @@</span><br><span> }</span><br><span> </span><br><span> static bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_client_setup_dco=
_initial(struct multi_context *m, struct multi_instance *mi,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+multi_client_setup_dco_initial(con=
st struct multi_context *m, struct multi_instance *mi,</span><br><span>    =
                            struct gc_arena *gc)</span><br><span> {</span><=
br><span>     if (!dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><s=
pan>@@ -3195,7 +3195,7 @@</span><br><span> </span><br><span> #if defined(EN=
ABLE_DCO)</span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-process_incoming_del_peer(struct multi_context *m, struct =
multi_instance *mi, dco_context_t *dco)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+process_incoming_del_peer(struct multi_context *m, stru=
ct multi_instance *mi, const dco_context_t *dco)</span><br><span> {</span><=
br><span>     const char *reason =3D &quot;ovpn-dco: unknown reason&quot;;<=
/span><br><span>     switch (dco-&gt;dco_del_peer_reason)</span><br><span>@=
@ -4239,7 +4239,7 @@</span><br><span> </span><br><span> /* Searches for the=
 address and deletes it if it is owned by the multi_instance */</span><br><=
span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mult=
i_unlearn_addr(struct multi_context *m, struct multi_instance *mi, const st=
ruct mroute_addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+multi_unlearn_addr(struct multi_context *m, const struct multi_instance=
 *mi, const struct mroute_addr *addr)</span><br><span> {</span><br><span>  =
   struct hash_element *he;</span><br><span>     const uint64_t hv =3D hash=
_value(m-&gt;vhash, addr);</span><br><span>@@ -4274,7 +4274,7 @@</span><br>=
<span>  * @param a     The new IPv4 address in network byte order</span><br=
><span>  */</span><br><span> static void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-multi_unlearn_in_addr_t(struct multi_context *m, struct =
multi_instance *mi, in_addr_t a)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+multi_unlearn_in_addr_t(struct multi_context *m, const struct =
multi_instance *mi, in_addr_t a)</span><br><span> {</span><br><span>     st=
ruct mroute_addr addr;</span><br><span>     CLEAR(addr);</span><br><span>@@=
 -4292,7 +4292,7 @@</span><br><span>  * @param a6    The new IPv6 address</=
span><br><span>  */</span><br><span> static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-multi_unlearn_in6_addr(struct multi_context *m, =
struct multi_instance *mi, struct in6_addr a6)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+multi_unlearn_in6_addr(struct multi_context *m, =
const struct multi_instance *mi, struct in6_addr a6)</span><br><span> {</sp=
an><br><span>     struct mroute_addr addr;</span><br><span>     CLEAR(addr)=
;</span><br><span>@@ -4408,7 +4408,7 @@</span><br><span> </span><br><span> =
bool</span><br><span> multi_check_push_ifconfig_ipv6_extra_route(struct mul=
ti_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                      struct in6_addr *dest)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
         const struct in6_addr *dest)</span><br><span> {</span><br><span>  =
   const struct options *o =3D &amp;mi-&gt;context=2Eoptions;</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=
=2Eh</span><br><span>index 8b837fa=2E=2Ec285fc3 100644</span><br><span>--- =
a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><=
br><span>@@ -516,7 +516,7 @@</span><br><span>  */</span><br><span> </span><=
br><span> static inline void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-set_prefix(struct multi_instance *mi)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+set_prefix(const struct multi_instance *mi)</span>=
<br><span> {</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span=
>     if (mi-&gt;msg_prefix[0])</span><br><span>@@ -690,7 +690,7 @@</span><=
br><span>  */</span><br><span> bool</span><br><span> multi_check_push_ifcon=
fig_ipv6_extra_route(struct multi_instance *mi,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                           struct=
 in6_addr *dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                         const struct in6_addr *dest);</spa=
n><br><span> </span><br><span> /*</span><br><span>  * Check for signals=2E<=
/span><br><span>diff --git a/src/openvpn/networking=2Eh b/src/openvpn/netwo=
rking=2Eh</span><br><span>index bce0c19=2E=2E25233c8 100644</span><br><span=
>--- a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/openvpn/network=
ing=2Eh</span><br><span>@@ -44,7 +44,7 @@</span><br><span>  */</span><br><s=
pan> #if !defined(ENABLE_IPROUTE)</span><br><span> static inline int</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-net_ctx_init(struct context =
*c, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)</span=
><br><span> {</span><br><span>     (void)c;</span><br><span>     (void)ctx;=
</span><br><span>@@ -75,7 +75,7 @@</span><br><span>  *</span><br><span>  * =
@return          0 on success, a negative error code otherwise</span><br><s=
pan>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_ctx_i=
nit(struct context *c, openvpn_net_ctx_t *ctx);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+int net_ctx_init(const struct context *c, openv=
pn_net_ctx_t *ctx);</span><br><span> </span><br><span> /**</span><br><span>=
  * Release resources allocated by the internal garbage collector</span><br=
><span>@@ -102,7 +102,7 @@</span><br><span>  * @return          0 on succes=
s, negative error code on error</span><br><span>  */</span><br><span> int n=
et_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, cons=
t char *type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
          void *arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                  const void *arg);</span><br><span> </span><br><span> /*=
*</span><br><span>  * Retrieve the interface type</span><br><span>diff --gi=
t a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=
=2Ec</span><br><span>index a1f3525=2E=2Ef091fb3 100644</span><br><span>--- =
a/src/openvpn/networking_iproute2=2Ec</span><br><span>+++ b/src/openvpn/net=
working_iproute2=2Ec</span><br><span>@@ -36,7 +36,7 @@</span><br><span> #in=
clude &lt;netinet/in=2Eh&gt;</span><br><span> </span><br><span> int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-net_ctx_init(struct context *=
c, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)</span>=
<br><span> {</span><br><span>     ctx-&gt;es =3D NULL;</span><br><span>    =
 if (c)</span><br><span>@@ -61,7 +61,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *typ=
e, void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_if=
ace_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const =
void *arg)</span><br><span> {</span><br><span>     struct argv argv =3D arg=
v_new();</span><br><span> </span><br><span>diff --git a/src/openvpn/network=
ing_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index e6e7=
2d0=2E=2Ea1d220f 100644</span><br><span>--- a/src/openvpn/networking_sitnl=
=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span=
>@@ -987,7 +987,7 @@</span><br><span> }</span><br><span> </span><br><span> =
static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_=
del(sa_family_t af_family, const char *iface, inet_address_t *addr, int pre=
fixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_d=
el(sa_family_t af_family, const char *iface, const inet_address_t *addr, in=
t prefixlen)</span><br><span> {</span><br><span>     int ifindex;</span><br=
><span> </span><br><span>@@ -1230,8 +1230,8 @@</span><br><span> }</span><br=
><span> </span><br><span> static int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-sitnl_route_del(const char *iface, sa_family_t af_family, in=
et_address_t *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                inet_address_t *gw, uint32_t table, int metric)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_del(con=
st char *iface, sa_family_t af_family, const inet_address_t *dst, int prefi=
xlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  const inet_address_t *gw, uint32_t table, int metric)</span><br><span> {<=
/span><br><span>     int ifindex =3D 0;</span><br><span> </span><br><span>@=
@ -1308,7 +1308,7 @@</span><br><span> </span><br><span> </span><br><span> i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_new(openv=
pn_net_ctx_t *ctx, const char *iface, const char *type, void *arg)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_new(openvpn_net_ct=
x_t *ctx, const char *iface, const char *type, const void *arg)</span><br><=
span> {</span><br><span>     struct sitnl_link_req req =3D {};</span><br><s=
pan>     int ret =3D -1;</span><br><span>diff --git a/src/openvpn/occ=2Eh b=
/src/openvpn/occ=2Eh</span><br><span>index bda4f18=2E=2E49def4d 100644</spa=
n><br><span>--- a/src/openvpn/occ=2Eh</span><br><span>+++ b/src/openvpn/occ=
=2Eh</span><br><span>@@ -156,7 +156,7 @@</span><br><span>  * via control ch=
annel=2E</span><br><span>  * @return control channel exit message should be=
 used */</span><br><span> static inline bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-cc_exit_notify_enabled(struct context *c)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+cc_exit_notify_enabled(const s=
truct context *c)</span><br><span> {</span><br><span>     /* Check if we ha=
ve TLS active at all */</span><br><span>     if (!c-&gt;c2=2Etls_multi)</sp=
an><br><span>diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/open=
ssl_compat=2Eh</span><br><span>index 098bdd5=2E=2E1a934db 100644</span><br>=
<span>--- a/src/openvpn/openssl_compat=2Eh</span><br><span>+++ b/src/openvp=
n/openssl_compat=2Eh</span><br><span>@@ -127,7 +127,7 @@</span><br><span> /=
* Mimics the functions but only when the default context without</span><br>=
<span>  * options is chosen */</span><br><span> static inline const EVP_CIP=
HER *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-EVP_CIPHER_fetch=
(void *ctx, const char *algorithm, const char *properties)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+EVP_CIPHER_fetch(const void *ctx, co=
nst char *algorithm, const char *properties)</span><br><span> {</span><br><=
span>     ASSERT(!ctx);</span><br><span>     ASSERT(!properties);</span><br=
><span>@@ -135,7 +135,7 @@</span><br><span> }</span><br><span> </span><br><=
span> static inline const EVP_MD *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-EVP_MD_fetch(void *ctx, const char *algorithm, const char *pro=
perties)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+EVP_MD_fetc=
h(const void *ctx, const char *algorithm, const char *properties)</span><br=
><span> {</span><br><span>     ASSERT(!ctx);</span><br><span>     ASSERT(!p=
roperties);</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/open=
vpn/options=2Ec</span><br><span>index 5451f86=2E=2E5e74a41 100644</span><br=
><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/opti=
ons=2Ec</span><br><span>@@ -3076,7 +3076,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-options_postprocess_mutate_le(struct connection_entry *ce, s=
truct local_entry *le, int mode)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+options_postprocess_mutate_le(const struct connection_entry *c=
e, struct local_entry *le, int mode)</span><br><span> {</span><br><span>   =
  /* use the global port if none is specified */</span><br><span>     if (!=
le-&gt;port)</span><br><span>@@ -5006,7 +5006,7 @@</span><br><span> static =
bool</span><br><span> verify_permission(const char *name, const char *file,=
 int line, const uint64_t type,</span><br><span>                   const ui=
nt64_t allowed, uint64_t *found, const msglvl_t msglevel,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                  struct options *optio=
ns, bool is_inline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                  const struct options *options, bool is_inline)</span><br>=
<span> {</span><br><span>     if (!(type &amp; allowed))</span><br><span>  =
   {</span><br><span>@@ -5573,7 +5573,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-show_compression_warning(struct compress_options *info)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+show_compression_warning(co=
nst struct compress_options *info)</span><br><span> {</span><br><span>     =
if (comp_non_stub_enabled(info))</span><br><span>     {</span><br><span>dif=
f --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_parse=2Ec</sp=
an><br><span>index 88ab4d2=2E=2E0e94522 100644</span><br><span>--- a/src/op=
envpn/options_parse=2Ec</span><br><span>+++ b/src/openvpn/options_parse=2Ec=
</span><br><span>@@ -258,7 +258,7 @@</span><br><span> }</span><br><span> </=
span><br><span> static char *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-read_inline_file(struct in_src *is, const char *close_tag, int *num=
_lines, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+read_inline_file(const struct in_src *is, const char *close_tag, i=
nt *num_lines, struct gc_arena *gc)</span><br><span> {</span><br><span>    =
 char line[OPTION_LINE_SIZE];</span><br><span>     struct buffer buf =3D al=
loc_buf(8 * OPTION_LINE_SIZE);</span><br><span>@@ -302,7 +302,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> static int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-check_inline_file(struct in_src *is, cha=
r *p[], struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+check_inline_file(const struct in_src *is, char *p[], struct gc_ar=
ena *gc)</span><br><span> {</span><br><span>     int num_inline_lines =3D 0=
;</span><br><span> </span><br><span>diff --git a/src/openvpn/otime=2Ec b/sr=
c/openvpn/otime=2Ec</span><br><span>index 1608458=2E=2E5d3633c 100644</span=
><br><span>--- a/src/openvpn/otime=2Ec</span><br><span>+++ b/src/openvpn/ot=
ime=2Ec</span><br><span>@@ -66,7 +66,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-update_now_usec(struct timeval *tv)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+update_now_usec(const struct timeval *tv)</span><br><sp=
an> {</span><br><span>     const time_t last =3D now;</span><br><span>     =
update_now(tv-&gt;tv_sec);</span><br><span>diff --git a/src/openvpn/otime=
=2Eh b/src/openvpn/otime=2Eh</span><br><span>index f02cc31=2E=2Ecc92bf7 100=
644</span><br><span>--- a/src/openvpn/otime=2Eh</span><br><span>+++ b/src/o=
penvpn/otime=2Eh</span><br><span>@@ -65,7 +65,7 @@</span><br><span> void up=
date_now(const time_t system_time);</span><br><span> </span><br><span> exte=
rn time_t now_usec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id update_now_usec(struct timeval *tv);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void update_now_usec(const struct timeval *tv);</span><=
br><span> </span><br><span> static inline int</span><br><span> openvpn_gett=
imeofday(struct timeval *tv, void *tz)</span><br><span>diff --git a/src/ope=
nvpn/proto=2Eh b/src/openvpn/proto=2Eh</span><br><span>index 3570582=2E=2E3=
3bf4ea 100644</span><br><span>--- a/src/openvpn/proto=2Eh</span><br><span>+=
++ b/src/openvpn/proto=2Eh</span><br><span>@@ -248,7 +248,7 @@</span><br><s=
pan>  * and offset of IP header (via parameter)=2E</span><br><span>  */</sp=
an><br><span> static inline int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-get_tun_ip_ver(int tunnel_type, struct buffer *buf, int *ip_hdr_o=
ffset)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_tun_ip_ve=
r(int tunnel_type, const struct buffer *buf, int *ip_hdr_offset)</span><br>=
<span> {</span><br><span>     int ip_ver =3D -1;</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><b=
r><span>index 4de7615=2E=2Ed4e0a8b 100644</span><br><span>--- a/src/openvpn=
/proxy=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -=
527,8 +527,9 @@</span><br><span> }</span><br><span> </span><br><span> stati=
c bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_proxy_heade=
rs(struct http_proxy_info *p, socket_descriptor_t sd, /* already open to pr=
oxy */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
   const char *host                                   /* openvpn server rem=
ote */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_proxy_hea=
ders(const struct http_proxy_info *p,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                  socket_descriptor_t sd, /* already open=
 to proxy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
           const char *host        /* openvpn server remote */</span><br><s=
pan> )</span><br><span> {</span><br><span>     char buf[512];</span><br><sp=
an>@@ -597,8 +598,8 @@</span><br><span>                               socke=
t_descriptor_t sd, /* already open to proxy */</span><br><span>            =
                   const char *host,       /* openvpn server remote */</spa=
n><br><span>                               const char *port,       /* openv=
pn server port */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                          struct event_timeout *server_poll_timeout, struct=
 buffer *lookahead,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                            struct signal_info *sig_info)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                              const s=
truct event_timeout *server_poll_timeout,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                              struct buffer *lookahea=
d, struct signal_info *sig_info)</span><br><span> {</span><br><span>     st=
ruct gc_arena gc =3D gc_new();</span><br><span>     char buf[512];</span><b=
r><span>diff --git a/src/openvpn/proxy=2Eh b/src/openvpn/proxy=2Eh</span><b=
r><span>index e662e7d=2E=2Ea2f4e47 100644</span><br><span>--- a/src/openvpn=
/proxy=2Eh</span><br><span>+++ b/src/openvpn/proxy=2Eh</span><br><span>@@ -=
89,7 +89,7 @@</span><br><span>                                    socket_de=
scriptor_t sd, /* already open to proxy */</span><br><span>                =
                    const char *host,       /* openvpn server remote */</sp=
an><br><span>                                    const char *port,       /*=
 openvpn server port */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                   struct event_timeout *server_poll_time=
out,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                    const struct event_timeout *server_poll_timeout,</span>=
<br><span>                                    struct buffer *lookahead, str=
uct signal_info *sig_info);</span><br><span> </span><br><span> uint8_t *mak=
e_base64_string2(const uint8_t *str, int str_len, struct gc_arena *gc);</sp=
an><br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br=
><span>index 57afacd=2E=2E0e581e5 100644</span><br><span>--- a/src/openvpn/=
ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -332,7 +=
332,7 @@</span><br><span>  * the proxy can determine true client origin=2E<=
/span><br><span>  */</span><br><span> static void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-journal_add(const char *journal_dir, struct pro=
xy_connection *pc, struct proxy_connection *cp)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+journal_add(const char *journal_dir, const stru=
ct proxy_connection *pc, struct proxy_connection *cp)</span><br><span> {</s=
pan><br><span>     struct openvpn_sockaddr from, to;</span><br><span> </spa=
n><br><span>@@ -410,7 +410,7 @@</span><br><span> static bool</span><br><spa=
n> proxy_entry_new(struct proxy_connection **list, struct event_set *es,</s=
pan><br><span>                 const struct openvpn_sockaddr server_addr, c=
onst socket_descriptor_t sd_client,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                struct buffer *initial_data, const char *jour=
nal_dir)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     const struct buffer *initial_data, const char *journal_dir)</span><br>=
<span> {</span><br><span>     socket_descriptor_t sd_server;</span><br><spa=
n>     int status;</span><br><span>@@ -1013,7 +1013,7 @@</span><br><span>  =
* call=2E</span><br><span>  */</span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-port_share_redirect(struct port_share *ps, =
const struct buffer *head, socket_descriptor_t sd)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+port_share_redirect(const struct port_share =
*ps, const struct buffer *head, socket_descriptor_t sd)</span><br><span> {<=
/span><br><span>     if (ps)</span><br><span>     {</span><br><span>diff --=
git a/src/openvpn/ps=2Eh b/src/openvpn/ps=2Eh</span><br><span>index 557ecf5=
=2E=2E918ceb6 100644</span><br><span>--- a/src/openvpn/ps=2Eh</span><br><sp=
an>+++ b/src/openvpn/ps=2Eh</span><br><span>@@ -49,7 +49,7 @@</span><br><sp=
an> </span><br><span> bool is_openvpn_protocol(const struct buffer *buf);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void =
port_share_redirect(struct port_share *ps, const struct buffer *head, socke=
t_descriptor_t sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void port_share_redirect(const struct port_share *ps, const struct buffer *=
head, socket_descriptor_t sd);</span><br><span> </span><br><span> #endif /*=
 if PORT_SHARE */</span><br><span> #endif /* ifndef PS_H */</span><br><span=
>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>i=
ndex 79f20e1=2E=2E2daee77 100644</span><br><span>--- a/src/openvpn/push=2Ec=
</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -430,7 +430,=
7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-send_auth_pending_messages(struct=
 tls_multi *tls_multi, struct tls_session *session,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+send_auth_pending_messages(const struct t=
ls_multi *tls_multi, struct tls_session *session,</span><br><span>         =
                   const char *extra, unsigned int timeout)</span><br><span=
> {</span><br><span>     struct key_state *ks =3D &amp;session-&gt;key[KS_P=
RIMARY];</span><br><span>diff --git a/src/openvpn/push=2Eh b/src/openvpn/pu=
sh=2Eh</span><br><span>index dff945f=2E=2E39302f6 100644</span><br><span>--=
- a/src/openvpn/push=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</span><=
br><span>@@ -117,7 +117,7 @@</span><br><span>  * doc/management-notes=2Etxt=
 under client-pending-auth for</span><br><span>  * more details on message =
format</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-bool send_auth_pending_messages(struct tls_multi *tls_multi, struct t=
ls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool send_auth_pending_messages(const struct tls_multi *tls_multi, struct =
tls_session *session,</span><br><span>                                 cons=
t char *extra, unsigned int timeout);</span><br><span> </span><br><span> vo=
id send_restart(struct context *c, const char *kill_msg);</span><br><span>d=
iff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br=
><span>index af22af5=2E=2E008d45f 100644</span><br><span>--- a/src/openvpn/=
push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><br><sp=
an>@@ -222,7 +222,7 @@</span><br><span> </span><br><span> /* Return true if=
 the client supports push-update */</span><br><span> static bool</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-support_push_update(struct multi=
_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+suppo=
rt_push_update(const struct multi_instance *mi)</span><br><span> {</span><b=
r><span>     ASSERT(mi-&gt;context=2Ec2=2Etls_multi);</span><br><span>     =
const unsigned int iv_proto_peer =3D extract_iv_proto(mi-&gt;context=2Ec2=
=2Etls_multi-&gt;peer_info);</span><br><span>diff --git a/src/openvpn/relia=
ble=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index 52adacf=2E=2E35884=
83 100644</span><br><span>--- a/src/openvpn/reliable=2Ec</span><br><span>++=
+ b/src/openvpn/reliable=2Ec</span><br><span>@@ -92,7 +92,7 @@</span><br><s=
pan> </span><br><span> /* check if a particular packet_id is present in ack=
 */</span><br><span> static inline bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-reliable_ack_packet_id_present(struct reliable_ack *ack, =
packet_id_type pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
reliable_ack_packet_id_present(const struct reliable_ack *ack, packet_id_ty=
pe pid)</span><br><span> {</span><br><span>     for (int i =3D 0; i &lt; ac=
k-&gt;len; ++i)</span><br><span>     {</span><br><span>@@ -733,7 +733,7 @@<=
/span><br><span>  */</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-reliable_mark_active_incoming(struct=
 reliable *rel, struct buffer *buf, packet_id_type pid,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+reliable_mark_active_incoming(struct re=
liable *rel, const struct buffer *buf, packet_id_type pid,</span><br><span>=
                               int opcode)</span><br><span> {</span><br><sp=
an>     for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>@@ -793=
,7 +793,7 @@</span><br><span> </span><br><span> /* delete a buffer previous=
ly activated by reliable_mark_active() */</span><br><span> void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-reliable_mark_deleted(struct reli=
able *rel, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+reliable_mark_deleted(struct reliable *rel, const struct buffer =
*buf)</span><br><span> {</span><br><span>     for (int i =3D 0; i &lt; rel-=
&gt;size; ++i)</span><br><span>     {</span><br><span>diff --git a/src/open=
vpn/reliable=2Eh b/src/openvpn/reliable=2Eh</span><br><span>index a5ed75c=
=2E=2E8d9e2e3 100644</span><br><span>--- a/src/openvpn/reliable=2Eh</span><=
br><span>+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ -173,7 +173,7 @@=
</span><br><span>  * @li False, if there are packet IDs to be acknowledged=
=2E</span><br><span>  */</span><br><span> static inline bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-reliable_ack_empty(struct reliable_a=
ck *ack)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ac=
k_empty(const struct reliable_ack *ack)</span><br><span> {</span><br><span>=
     return !ack-&gt;len;</span><br><span> }</span><br><span>@@ -186,7 +186=
,7 @@</span><br><span>  * @returns the number of outstanding acks</span><br=
><span>  */</span><br><span> static inline int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-reliable_ack_outstanding(struct reliable_ack *ack)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_outsta=
nding(const struct reliable_ack *ack)</span><br><span> {</span><br><span>  =
   return ack-&gt;len;</span><br><span> }</span><br><span>@@ -336,7 +336,7 =
@@</span><br><span>  * @param pid The packet&#39;s packet ID=2E</span><br><=
span>  * @param opcode The packet&#39;s opcode=2E</span><br><span>  */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void reliable_mark_active_=
incoming(struct reliable *rel, struct buffer *buf, packet_id_type pid,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void reliable_mark_activ=
e_incoming(struct reliable *rel, const struct buffer *buf, packet_id_type p=
id,</span><br><span>                                    int opcode);</span>=
<br><span> </span><br><span> /**</span><br><span>@@ -389,7 +389,7 @@</span>=
<br><span>  * @param rel The reliable structure associated with the given b=
uffer=2E</span><br><span>  * @param buf The buffer of the reliable entry wh=
ich is to be removed=2E</span><br><span>  */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void reliable_mark_deleted(struct reliable *rel, str=
uct buffer *buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id reliable_mark_deleted(struct reliable *rel, const struct buffer *buf);</=
span><br><span> </span><br><span> /** @} name Functions for extracting inco=
ming packets */</span><br><span> </span><br><span>diff --git a/src/openvpn/=
route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 03a2526=2E=2E078bb7=
e 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/=
src/openvpn/route=2Ec</span><br><span>@@ -898,8 +898,9 @@</span><br><span> =
}</span><br><span> </span><br><span> static bool</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-add_bypass_routes(struct route_bypass *rb, in_ad=
dr_t gateway, const struct tuntap *tt,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                  unsigned int flags, const struct route_g=
ateway_info *rgi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ad=
d_bypass_routes(const struct route_bypass *rb, in_addr_t gateway,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                  const struc=
t tuntap *tt, unsigned int flags,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                  const struct route_gateway_info *rgi,</span=
><br><span>                   const struct env_set *es, openvpn_net_ctx_t *=
ctx)</span><br><span> {</span><br><span>     int ret =3D true;</span><br><s=
pan>@@ -916,8 +917,9 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-del_byp=
ass_routes(struct route_bypass *rb, in_addr_t gateway, const struct tuntap =
*tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
 unsigned int flags, const struct route_gateway_info *rgi,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+del_bypass_routes(const struct route=
_bypass *rb, in_addr_t gateway,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                  const struct tuntap *tt, unsigned int flags,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  co=
nst struct route_gateway_info *rgi,</span><br><span>                   cons=
t struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br>=
<span>     int i;</span><br><span>@@ -3942,7 +3944,7 @@</span><br><span> #e=
lse  /* if defined(_WIN32) */</span><br><span> </span><br><span> static voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_bypass_addresses=
(struct route_bypass *rb, const unsigned int flags) /* PLATFORM-SPECIFIC */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_bypass_addresse=
s(struct route_bypass *rb, const unsigned int flags)</span><br><span> {</sp=
an><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/=
schedule=2Ec b/src/openvpn/schedule=2Ec</span><br><span>index 6772ad6=2E=2E=
694f4d1 100644</span><br><span>--- a/src/openvpn/schedule=2Ec</span><br><sp=
an>+++ b/src/openvpn/schedule=2Ec</span><br><span>@@ -389,4 +389,4 @@</span=
><br><span> {</span><br><span>     s-&gt;earliest_wakeup =3D NULL; /* inval=
idate cache */</span><br><span>     schedule_remove_node(s, e);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>\ No newline at=
 end of file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</sp=
an><br><span>index 50126bf=2E=2E6684350 100644</span><br><span>--- a/src/op=
envpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><sp=
an>@@ -619,7 +619,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bind_loc=
al(struct link_socket *sock, const sa_family_t ai_family)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bind_local(const struct link_socket *=
sock, const sa_family_t ai_family)</span><br><span> {</span><br><span>     =
/* bind to local address/port */</span><br><span>     if (sock-&gt;bind_loc=
al)</span><br><span>@@ -886,8 +886,8 @@</span><br><span> }</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-socket_bind(socket_descriptor_t sd, struct addrinfo *local, int ai_family=
, const char *prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            bool ipv6only)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+socket_bind(socket_descriptor_t sd, const struct addrinfo *local, in=
t ai_family,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     const char *prefix, bool ipv6only)</span><br><span> {</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ =
-1095,8 +1095,8 @@</span><br><span>  * such as TCP=2E</span><br><span>  */<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic void stream_buf_init(struct stream_buf *sb, struct buffer *buf, const un=
signed int sockflags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                            const int proto);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void stream_buf_init(struct stream_buf *sb=
, const struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                            const unsigned int sockflags, const int=
 proto);</span><br><span> </span><br><span> static void stream_buf_close(st=
ruct stream_buf *sb);</span><br><span> </span><br><span>@@ -1453,7 +1453,7 =
@@</span><br><span> }</span><br><span> </span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-phase2_set_socket_flags(stru=
ct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+phase2_set_socket_flags(const struct link_socket *sock)</span><br><span> =
{</span><br><span>     /* TCP_NODELAY is enabled by default on every TCP so=
cket; dco-win is</span><br><span>      * skipped as it manages its own sock=
et */</span><br><span>@@ -2053,7 +2053,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-stream_buf_init(struct stream_buf *sb, struct buffer *buf, con=
st unsigned int sockflags,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+stream_buf_init(struct stream_buf *sb, const struct buffer *buf, con=
st unsigned int sockflags,</span><br><span>                 const int proto=
)</span><br><span> {</span><br><span>     sb-&gt;buf_init =3D *buf;</span><=
br><span>@@ -2319,7 +2319,7 @@</span><br><span> #endif</span><br><span> </s=
pan><br><span> static ssize_t</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-link_socket_read_udp_posix_recvmsg(struct link_socket *sock, struct=
 buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_s=
ocket_read_udp_posix_recvmsg(const struct link_socket *sock, struct buffer =
*buf,</span><br><span>                                    struct link_socke=
t_actual *from, socklen_t *fromlen)</span><br><span> {</span><br><span>    =
 struct iovec iov;</span><br><span>@@ -2391,7 +2391,7 @@</span><br><span> #=
endif /* if ENABLE_IP_PKTINFO */</span><br><span> </span><br><span> ssize_t=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_read_udp_=
posix(struct link_socket *sock, struct buffer *buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+link_socket_read_udp_posix(const struct l=
ink_socket *sock, struct buffer *buf,</span><br><span>                     =
       struct link_socket_actual *from)</span><br><span> {</span><br><span>=
     ssize_t recvlen;</span><br><span>@@ -2454,7 +2454,7 @@</span><br><span=
> #if ENABLE_IP_PKTINFO</span><br><span> </span><br><span> ssize_t</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_udp_posix_se=
ndmsg(struct link_socket *sock, struct buffer *buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+link_socket_write_udp_posix_sendmsg(const=
 struct link_socket *sock, const struct buffer *buf,</span><br><span>      =
                               struct link_socket_actual *to)</span><br><sp=
an> {</span><br><span>     struct iovec iov;</span><br><span>@@ -2648,7 +26=
48,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-socket_send_queue(struct link_s=
ocket *sock, struct buffer *buf, const struct link_socket_actual *to)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_send_queue(struct =
link_socket *sock, const struct buffer *buf, const struct link_socket_actua=
l *to)</span><br><span> {</span><br><span>     if (sock-&gt;writes=2Eiostat=
e =3D=3D IOSTATE_INITIAL)</span><br><span>     {</span><br><span>@@ -2748,8=
 +2748,8 @@</span><br><span>     return sock-&gt;writes=2Eiostate;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_socka=
ddr_from_overlapped(struct overlapped_io *io, struct sockaddr *dst, int ove=
rlapped_ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_sockaddr_f=
rom_overlapped(const struct overlapped_io *io, struct sockaddr *dst, int ov=
erlapped_ret)</span><br><span> {</span><br><span>     if (overlapped_ret &g=
t;=3D 0 &amp;&amp; io-&gt;addr_defined)</span><br><span>     {</span><br><s=
pan>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br>=
<span>index 89465bc=2E=2Ec6bcd86 100644</span><br><span>--- a/src/openvpn/s=
ocket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -=
268,7 +268,7 @@</span><br><span> </span><br><span> int socket_recv_queue(st=
ruct link_socket *sock, int maxsize);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-int socket_send_queue(struct link_socket =
*sock, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int socket_send_queue(struct link_socket *sock, const struct buffer =
*buf,</span><br><span>                       const struct link_socket_actua=
l *to);</span><br><span> </span><br><span> typedef struct</span><br><span>@=
@ -348,8 +348,8 @@</span><br><span> </span><br><span> struct link_socket *l=
ink_socket_new(void);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void socket_bind(socket_descriptor_t sd, struct addrinfo =
*local, int af_family, const char *prefix,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                 bool ipv6only);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void socket_bind(socket_descriptor_t sd, =
const struct addrinfo *local, int af_family,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                 const char *prefix, bool ipv6only=
);</span><br><span> </span><br><span> int openvpn_connect(socket_descriptor=
_t sd, const struct sockaddr *remote, int connect_timeout,</span><br><span>=
                     volatile int *signal_received);</span><br><span>@@ -48=
3,7 +483,7 @@</span><br><span> }</span><br><span> </span><br><span> static =
inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socke=
t_verify_incoming_addr(struct buffer *buf, const struct link_socket_info *i=
nfo,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_ver=
ify_incoming_addr(const struct buffer *buf, const struct link_socket_info *=
info,</span><br><span>                                  const struct link_s=
ocket_actual *from_addr)</span><br><span> {</span><br><span>     if (buf-&g=
t;len &gt; 0)</span><br><span>@@ -607,7 +607,7 @@</span><br><span> </span><=
br><span> #else  /* ifdef _WIN32 */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ssize_t link_socket_read_udp_posix(struct l=
ink_socket *sock, struct buffer *buf,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ssize_t link_socket_read_udp_posix(const struct link_sock=
et *sock, struct buffer *buf,</span><br><span>                             =
       struct link_socket_actual *from);</span><br><span> </span><br><span>=
 #endif /* ifdef _WIN32 */</span><br><span>@@ -693,12 +693,12 @@</span><br>=
<span> </span><br><span> #else /* ifdef _WIN32 */</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t link_socket_write_udp=
_posix_sendmsg(struct link_socket *sock, struct buffer *buf,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ssize_t link_socket_write_udp_posi=
x_sendmsg(const struct link_socket *sock, const struct buffer *buf,</span><=
br><span>                                             struct link_socket_ac=
tual *to);</span><br><span> </span><br><span> </span><br><span> static inli=
ne ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket=
_write_udp_posix(struct link_socket *sock, struct buffer *buf,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+link_socket_write_udp_posix(cons=
t struct link_socket *sock, const struct buffer *buf,</span><br><span>     =
                        struct link_socket_actual *to)</span><br><span> {</=
span><br><span> #if ENABLE_IP_PKTINFO</span><br><span>@@ -714,7 +714,7 @@</=
span><br><span> }</span><br><span> </span><br><span> static inline ssize_t<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_tcp_=
posix(struct link_socket *sock, struct buffer *buf)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+link_socket_write_tcp_posix(const struct =
link_socket *sock, const struct buffer *buf)</span><br><span> {</span><br><=
span>     return send(sock-&gt;sd, BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);</s=
pan><br><span> }</span><br><span>@@ -772,7 +772,7 @@</span><br><span>  * fr=
om tunnel packet=2E</span><br><span>  */</span><br><span> static inline voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_set_tos(=
struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+link_socket_set_tos(const struct link_socket *sock)</span><br><span> =
{</span><br><span>     if (sock &amp;&amp; sock-&gt;ptos_defined)</span><br=
><span>     {</span><br><span>@@ -818,6 +818,8 @@</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* cppcheck-suppress constParameterPointer</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * sock is modified on Windows via &a=
mp;sock-&gt;listen_handle */</span><br><span> static inline void</span><br>=
<span> socket_reset_listen_persistent(struct link_socket *sock)</span><br><=
span> {</span><br><span>diff --git a/src/openvpn/socket_util=2Eh b/src/open=
vpn/socket_util=2Eh</span><br><span>index 13f5962=2E=2Eadd08ba 100644</span=
><br><span>--- a/src/openvpn/socket_util=2Eh</span><br><span>+++ b/src/open=
vpn/socket_util=2Eh</span><br><span>@@ -439,7 +439,7 @@</span><br><span> </=
span><br><span> </span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-addrlist_match_proto(const struct openvpn_s=
ockaddr *a1, struct addrinfo *addr_list, const int proto)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+addrlist_match_proto(const struct ope=
nvpn_sockaddr *a1, const struct addrinfo *addr_list, const int proto)</span=
><br><span> {</span><br><span>     return link_socket_proto_connection_orie=
nted(proto) ? addrlist_match(a1, addr_list)</span><br><span>               =
                                          : addrlist_port_match(a1, addr_li=
st);</span><br><span>diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=
=2Ec</span><br><span>index 19f3d54=2E=2E77ca863 100644</span><br><span>--- =
a/src/openvpn/socks=2Ec</span><br><span>+++ b/src/openvpn/socks=2Ec</span><=
br><span>@@ -82,7 +82,7 @@</span><br><span> </span><br><span> static bool</=
span><br><span> socks_proxy_recv_char(uint8_t *c, const char *name, socket_=
descriptor_t sd,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                 struct event_timeout *server_poll_timeout,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                      const struct =
event_timeout *server_poll_timeout,</span><br><span>                       =
volatile int *signal_received)</span><br><span> {</span><br><span>     fd_s=
et reads;</span><br><span>@@ -97,8 +97,8 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-socks_username_password_auth(struct socks_proxy_info *p, socke=
t_descriptor_t sd,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                          struct event_timeout *server_poll_timeout,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+socks_username_password_au=
th(const struct socks_proxy_info *p, socket_descriptor_t sd,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                             const=
 struct event_timeout *server_poll_timeout,</span><br><span>               =
               volatile int *signal_received)</span><br><span> {</span><br>=
<span>     char to_send[516];</span><br><span>@@ -156,8 +156,8 @@</span><br=
><span> }</span><br><span> </span><br><span> static bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-socks_handshake(struct socks_proxy_info =
*p, socket_descriptor_t sd,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                struct event_timeout *server_poll_timeout, volatile i=
nt *signal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+socks_handshake(const struct socks_proxy_info *p, socket_descriptor_t sd,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                cons=
t struct event_timeout *server_poll_timeout, volatile int *signal_received)=
</span><br><span> {</span><br><span>     uint8_t buf[2];</span><br><span>  =
   int len =3D 0;</span><br><span>@@ -231,7 +231,7 @@</span><br><span> </sp=
an><br><span> static bool</span><br><span> recv_socks_reply(socket_descript=
or_t sd, struct openvpn_sockaddr *addr,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                 struct event_timeout *server_poll_timeou=
t, volatile int *signal_received)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                 const struct event_timeout *server_poll_time=
out, volatile int *signal_received)</span><br><span> {</span><br><span>    =
 uint8_t atyp =3D 0;</span><br><span>     int alen =3D 0;</span><br><span>@=
@ -334,11 +334,11 @@</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-establish_socks_p=
roxy_passthru(struct socks_proxy_info *p,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+establish_socks_proxy_passthru(const struct socks_pro=
xy_info *p,</span><br><span>                                socket_descript=
or_t sd, /* already open to proxy */</span><br><span>                      =
          const char *host,       /* openvpn server remote */</span><br><sp=
an>                                const char *servname,   /* openvpn serve=
r port */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                   struct event_timeout *server_poll_timeout,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                               co=
nst struct event_timeout *server_poll_timeout,</span><br><span>            =
                    struct signal_info *sig_info)</span><br><span> {</span>=
<br><span>     char buf[270];</span><br><span>@@ -392,10 +392,10 @@</span><=
br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-establish_socks_proxy_udpassoc(struct socks=
_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+esta=
blish_socks_proxy_udpassoc(const struct socks_proxy_info *p,</span><br><spa=
n>                                socket_descriptor_t ctrl_sd, /* already o=
pen to proxy */</span><br><span>                                struct open=
vpn_sockaddr *relay_addr,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                               struct event_timeout *server_poll_timeou=
t,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
              const struct event_timeout *server_poll_timeout,</span><br><s=
pan>                                struct signal_info *sig_info)</span><br=
><span> {</span><br><span>     if (!socks_handshake(p, ctrl_sd, server_poll=
_timeout, &amp;sig_info-&gt;signal_received))</span><br><span>diff --git a/=
src/openvpn/socks=2Eh b/src/openvpn/socks=2Eh</span><br><span>index 846113d=
=2E=2Ef7c93b6 100644</span><br><span>--- a/src/openvpn/socks=2Eh</span><br>=
<span>+++ b/src/openvpn/socks=2Eh</span><br><span>@@ -47,17 +47,17 @@</span=
><br><span> </span><br><span> void socks_proxy_close(struct socks_proxy_inf=
o *sp);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-void establish_socks_proxy_passthru(struct socks_proxy_info *p,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void establish_socks_proxy_=
passthru(const struct socks_proxy_info *p,</span><br><span>                =
                     socket_descriptor_t sd, /* already open to proxy */</s=
pan><br><span>                                     const char *host,       =
/* openvpn server remote */</span><br><span>                               =
      const char *servname,   /* openvpn server port */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                    struc=
t event_timeout *server_poll_timeout,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                    const struct event_ti=
meout *server_poll_timeout,</span><br><span>                               =
      struct signal_info *sig_info);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void establish_socks_proxy_udpassoc(struct=
 socks_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void establish_socks_proxy_udpassoc(const struct socks_proxy_info *p,</sp=
an><br><span>                                     socket_descriptor_t ctrl_=
sd, /* already open to proxy */</span><br><span>                           =
          struct openvpn_sockaddr *relay_addr,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                    struct event_t=
imeout *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                    const struct event_timeout *se=
rver_poll_timeout,</span><br><span>                                     str=
uct signal_info *sig_info);</span><br><span> </span><br><span> void socks_p=
rocess_incoming_udp(struct buffer *buf, struct link_socket_actual *from);</=
span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span=
><br><span>index 5e12135=2E=2Ea13a71a 100644</span><br><span>--- a/src/open=
vpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1=
159,7 +1159,7 @@</span><br><span> }</span><br><span> </span><br><span> stru=
ct tls_multi *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_mul=
ti_init(struct tls_options *tls_options)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+tls_multi_init(const struct tls_options *tls_options)<=
/span><br><span> {</span><br><span>     struct tls_multi *ret;</span><br><s=
pan> </span><br><span>@@ -1188,7 +1188,7 @@</span><br><span>  */</span><br>=
<span> </span><br><span> struct tls_auth_standalone *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tls_auth_standalone_init(struct tls_options=
 *tls_options, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+tls_auth_standalone_init(const struct tls_options *tls_opti=
ons, struct gc_arena *gc)</span><br><span> {</span><br><span>     struct tl=
s_auth_standalone *tas;</span><br><span> </span><br><span>@@ -1336,7 +1336,=
7 @@</span><br><span> </span><br><span> static void</span><br><span> init_e=
poch_keys(struct key_state *ks, struct tls_multi *multi, const struct key_t=
ype *key_type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         bool server, struct key2 *key2)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                bool server, const struct key2 *key2)<=
/span><br><span> {</span><br><span>     /* For now we hardcode this to be 1=
6 for the software based data channel</span><br><span>      * DCO based imp=
lementations/HW implementation might adjust this number</span><br><span>@@ =
-1375,7 +1375,7 @@</span><br><span> </span><br><span> static void</span><br=
><span> init_key_contexts(struct key_state *ks, struct tls_multi *multi, co=
nst struct key_type *key_type,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                  bool server, struct key2 *key2, bool dco_enabled=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
bool server, const struct key2 *key2, bool dco_enabled)</span><br><span> {<=
/span><br><span>     struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=
=2Ekey_ctx_bi;</span><br><span> </span><br><span>@@ -1573,8 +1573,9 @@</spa=
n><br><span> </span><br><span> bool</span><br><span> tls_session_update_cry=
pto_params_do_work(struct tls_multi *multi, struct tls_session *session,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
                 struct options *options, struct frame *frame,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
       struct frame *frame_fragment, struct link_socket_info *lsi,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
             const struct options *options, struct frame *frame,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
           struct frame *frame_fragment,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                         const struct =
link_socket_info *lsi,</span><br><span>                                    =
      dco_context_t *dco)</span><br><span> {</span><br><span>     if (sessi=
on-&gt;key[KS_PRIMARY]=2Ecrypto_options=2Ekey_ctx_bi=2Einitialized)</span><=
br><span>@@ -1643,7 +1644,7 @@</span><br><span> bool</span><br><span> tls_s=
ession_update_crypto_params(struct tls_multi *multi, struct tls_session *se=
ssion,</span><br><span>                                  struct options *op=
tions, struct frame *frame,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                 struct frame *frame_fragment, struct=
 link_socket_info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                 struct frame *frame_fragment, const st=
ruct link_socket_info *lsi,</span><br><span>                               =
   dco_context_t *dco)</span><br><span> {</span><br><span>     if (!check_s=
ession_cipher(session, options))</span><br><span>@@ -2495,8 +2496,8 @@</spa=
n><br><span> }</span><br><span> </span><br><span> bool</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-session_skip_to_pre_start(struct tls_sessi=
on *session, struct tls_pre_decrypt_state *state,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                          struct link_socket_ac=
tual *from)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+session_=
skip_to_pre_start(struct tls_session *session, const struct tls_pre_decrypt=
_state *state,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                     const struct link_socket_actual *from)</span><br><span=
> {</span><br><span>     struct key_state *ks =3D &amp;session-&gt;key[KS_P=
RIMARY];</span><br><span>     ks-&gt;session_id_remote =3D state-&gt;peer_s=
ession_id;</span><br><span>@@ -4036,7 +4037,7 @@</span><br><span> }</span><=
br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-tls_post_encrypt(struct tls_multi *multi, struct buffer *buf)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_post_encrypt(struc=
t tls_multi *multi, const struct buffer *buf)</span><br><span> {</span><br>=
<span>     struct key_state *ks =3D multi-&gt;save_ks;</span><br><span>    =
 multi-&gt;save_ks =3D NULL;</span><br><span>@@ -4167,7 +4168,7 @@</span><b=
r><span>  * into a garbage collectable string which is returned=2E</span><b=
r><span>  */</span><br><span> const char *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-protocol_dump(struct buffer *buffer, unsigned int flag=
s, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+protocol_dump(const struct buffer *buffer, unsigned int flags, struct g=
c_arena *gc)</span><br><span> {</span><br><span>     struct buffer out =3D =
alloc_buf_gc(256, gc);</span><br><span>     struct buffer buf =3D *buffer;<=
/span><br><span>diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh</spa=
n><br><span>index 7ddf965=2E=2E93e6200 100644</span><br><span>--- a/src/ope=
nvpn/ssl=2Eh</span><br><span>+++ b/src/openvpn/ssl=2Eh</span><br><span>@@ -=
166,7 +166,7 @@</span><br><span>  *</span><br><span>  * @return A newly all=
ocated and initialized \c tls_multi structure=2E</span><br><span>  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-struct tls_multi *tls_multi=
_init(struct tls_options *tls_options);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+struct tls_multi *tls_multi_init(const struct tls_optio=
ns *tls_options);</span><br><span> </span><br><span> /**</span><br><span>  =
* Finalize initialization of a \c tls_multi structure=2E</span><br><span>@@=
 -187,7 +187,7 @@</span><br><span> /*</span><br><span>  * Initialize a stan=
dalone tls-auth verification object=2E</span><br><span>  */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-struct tls_auth_standalone *tls_auth_=
standalone_init(struct tls_options *tls_options,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+struct tls_auth_standalone *tls_auth_standalon=
e_init(const struct tls_options *tls_options,</span><br><span>             =
                                         struct gc_arena *gc);</span><br><s=
pan> </span><br><span> /**</span><br><span>@@ -371,7 +371,7 @@</span><br><s=
pan>  * @param multi - The TLS state for this packet&#39;s destination VPN =
tunnel=2E</span><br><span>  * @param buf - The buffer containing the outgoi=
ng packet=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void tls_post_encrypt(struct tls_multi *multi, struct buffer *b=
uf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tls_post_e=
ncrypt(struct tls_multi *multi, const struct buffer *buf);</span><br><span>=
 </span><br><span> /** @} name Functions for managing security parameter st=
ate for data channel packets */</span><br><span> </span><br><span>@@ -461,7=
 +461,8 @@</span><br><span>  */</span><br><span> bool tls_session_update_cr=
ypto_params(struct tls_multi *multi, struct tls_session *session,</span><br=
><span>                                       struct options *options, stru=
ct frame *frame,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                 struct frame *frame_fragment, struct link_=
socket_info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                    struct frame *frame_fragment,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
         const struct link_socket_info *lsi,</span><br><span>              =
                         dco_context_t *dco);</span><br><span> </span><br><=
span> /*</span><br><span>@@ -525,7 +526,7 @@</span><br><span> #define PD_VE=
RBOSE                 (1 &lt;&lt; 10)</span><br><span> #define PD_TLS_CRYPT=
               (1 &lt;&lt; 11)</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-const char *protocol_dump(struct buffer *buffer,=
 unsigned int flags, struct gc_arena *gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+const char *protocol_dump(const struct buffer *buffe=
r, unsigned int flags, struct gc_arena *gc);</span><br><span> </span><br><s=
pan> /*</span><br><span>  * debugging code</span><br><span>@@ -573,7 +574,7=
 @@</span><br><span> /* Special method to skip the three way handshake RESE=
T stages=2E This is</span><br><span>  * used by the HMAC code when seeing a=
 packet that matches the previous</span><br><span>  * HMAC based stateless =
server state */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool s=
ession_skip_to_pre_start(struct tls_session *session, struct tls_pre_decryp=
t_state *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                         struct link_socket_actual *from);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool session_skip_to_pre_start(struc=
t tls_session *session, const struct tls_pre_decrypt_state *state,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
   const struct link_socket_actual *from);</span><br><span> </span><br><spa=
n> #endif /* ifndef OPENVPN_SSL_H */</span><br><span>diff --git a/src/openv=
pn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh</span><br><span>index 816f=
b9c=2E=2Eed395e7 100644</span><br><span>--- a/src/openvpn/ssl_backend=2Eh</=
span><br><span>+++ b/src/openvpn/ssl_backend=2Eh</span><br><span>@@ -144,7 =
+144,7 @@</span><br><span>  *</span><br><span>  * @return      true if the =
context is initialised, false if not=2E</span><br><span>  */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-bool tls_ctx_initialised(struct tls_=
root_ctx *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
 tls_ctx_initialised(const struct tls_root_ctx *ctx);</span><br><span> </sp=
an><br><span> /**</span><br><span>  * Set any library specific options=2E</=
span><br><span>@@ -177,7 +177,7 @@</span><br><span>  * @param ciphers      =
 String containing : delimited cipher names, or NULL to use</span><br><span=
>  *                                      sane defaults=2E</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tls_ctx_rest=
rict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void tls_ctx_restrict_cipher=
s_tls13(const struct tls_root_ctx *ctx, const char *ciphers);</span><br><sp=
an> </span><br><span> /**</span><br><span>  * Set the TLS certificate profi=
le=2E  The profile defines which crypto</span><br><span>diff --git a/src/op=
envpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index d=
5c9e5c=2E=2E49ea0bc 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2E=
c</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -161=
,7 +161,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_initialised(struc=
t tls_root_ctx *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+tls_ctx_initialised(const struct tls_root_ctx *ctx)</span><br><span> {</sp=
an><br><span>     /* either this should be NULL or should be non-null and t=
hen have a</span><br><span>      * valid TLS ctx inside as well */</span><b=
r><span>@@ -284,7 +284,7 @@</span><br><span> }</span><br><span> </span><br>=
<span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_re=
strict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_restrict_ciphers_tl=
s13(const struct tls_root_ctx *ctx, const char *ciphers)</span><br><span> {=
</span><br><span>     if (ciphers =3D=3D NULL)</span><br><span>     {</span=
><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_opens=
sl=2Ec</span><br><span>index d31f78f=2E=2E401bd1b 100644</span><br><span>--=
- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_opens=
sl=2Ec</span><br><span>@@ -147,7 +147,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-tls_ctx_initialised(struct tls_root_ctx *ctx)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+tls_ctx_initialised(const struct tls_root_ct=
x *ctx)</span><br><span> {</span><br><span>     /* either this should be NU=
LL or should be non-null and then have a</span><br><span>      * valid TLS =
ctx inside as well */</span><br><span>@@ -464,7 +464,7 @@</span><br><span> =
#endif</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx=
 *ctx, const char *ciphers)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, cons=
t char *ciphers)</span><br><span> {</span><br><span>     if (ciphers =3D=3D=
 NULL)</span><br><span>     {</span><br><span>@@ -1111,7 +1111,7 @@</span><=
br><span> }</span><br><span> </span><br><span> static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_load_cert_uri(struct tls_root_=
ctx *tls_ctx, const char *uri)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+tls_ctx_load_cert_uri(const struct tls_root_ctx *tls_ctx, const =
char *uri)</span><br><span> {</span><br><span> #if defined(HAVE_OPENSSL_STO=
RE_API)</span><br><span>     X509 *x =3D NULL;</span><br><span>@@ -2026,7 +=
2026,7 @@</span><br><span> }</span><br><span> </span><br><span> static void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bio_debug_data(const =
char *mode, BIO *bio, const uint8_t *buf, int len, const char *desc)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bio_debug_data(const char =
*mode, const BIO *bio, const uint8_t *buf, int len, const char *desc)</span=
><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><=
br><span>     if (len &gt; 0)</span><br><span>@@ -2040,7 +2040,7 @@</span><=
br><span> }</span><br><span> </span><br><span> static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-bio_debug_oc(const char *mode, BIO *bi=
o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bio_debug_oc(cons=
t char *mode, const BIO *bio)</span><br><span> {</span><br><span>     open_=
biofp();</span><br><span>     fprintf(biofp, &quot;BIO %s time=3D%&quot; PR=
Ii64 &quot; bio=3D&quot; ptr_format &quot;\n&quot;, mode, (int64_t)time(NUL=
L),</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_=
pkt=2Ec</span><br><span>index f8444451=2E=2Ee2a0c62 100644</span><br><span>=
--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec=
</span><br><span>@@ -57,7 +57,7 @@</span><br><span>  *  @return         if =
the swap was successful (buf was large enough)</span><br><span>  */</span><=
br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
swap_hmac(struct buffer *buf, const struct crypto_options *co, bool incomin=
g)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+swap_hmac(const s=
truct buffer *buf, const struct crypto_options *co, bool incoming)</span><b=
r><span> {</span><br><span>     ASSERT(co);</span><br><span> </span><br><sp=
an>@@ -117,7 +117,7 @@</span><br><span>  */</span><br><span> static void</s=
pan><br><span> tls_wrap_control(struct tls_wrap_ctx *ctx, uint8_t header, s=
truct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
              struct session_id *session_id)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                 const struct session_id *session_=
id)</span><br><span> {</span><br><span>     if (ctx-&gt;mode =3D=3D TLS_WRA=
P_AUTH || ctx-&gt;mode =3D=3D TLS_WRAP_NONE)</span><br><span>     {</span><=
br><span>@@ -401,9 +401,9 @@</span><br><span> </span><br><span> </span><br>=
<span> struct buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-t=
ls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *t=
as,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
   struct session_id *own_sid, struct session_id *remote_sid, uint8_t heade=
r,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
  bool request_resend_wkc)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth=
_standalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                   const struct session_id *own_sid, const struct session_i=
d *remote_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                uint8_t header, bool request_resend_wkc)</span><br><span> {=
</span><br><span>     /* Copy buffer here to point at the same data but all=
ow tls_wrap_control</span><br><span>      * to potentially change buf to po=
int to another buffer without</span><br><span>diff --git a/src/openvpn/ssl_=
pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 82cb5b1=2E=2E9107ae=
1 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ =
b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -218,8 +218,9 @@</span><br><sp=
an>  * from the tls pre decrypt state=2E</span><br><span>  *</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer t=
ls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *t=
as,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                 struct session_id *own_sid, struct session_id *remote_sid,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer tls_r=
eset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone =
*tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                     const struct session_id *own_sid,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                   const=
 struct session_id *remote_sid,</span><br><span>                           =
         uint8_t header, bool request_resend_wkc);</span><br><span> </span>=
<br><span> </span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/o=
penvpn/ssl_verify=2Ec</span><br><span>index 063fa5d=2E=2E3304cb46 100644</s=
pan><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/op=
envpn/ssl_verify=2Ec</span><br><span>@@ -1139,7 +1139,7 @@</span><br><span>=
  * cache=2E</span><br><span>  */</span><br><span> static bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-tls_authentication_status_use_cach=
e(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+tls_authentication_status_use_cache(const struct tls_multi *multi)</=
span><br><span> {</span><br><span>     unsigned int idx =3D min_uint(multi-=
&gt;tas_cache_num_updates, SIZE(cache_intervals) - 1);</span><br><span>    =
 time_t latency =3D cache_intervals[idx];</span><br><span>@@ -1283,7 +1283,=
7 @@</span><br><span>  * Check if the script/plugin left a message in the a=
uth failed message</span><br><span>  * file and relay it to the user */</sp=
an><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-check_for_client_reason(struct tls_multi *multi, struct auth_deferred_s=
tatus *status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check=
_for_client_reason(struct tls_multi *multi, const struct auth_deferred_stat=
us *status)</span><br><span> {</span><br><span>     struct gc_arena gc =3D =
gc_new();</span><br><span>     const char *msg =3D key_state_check_auth_fai=
led_message_file(status, &amp;gc);</span><br><span>@@ -1552,7 +1552,7 @@</s=
pan><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span=
><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-set_verify_user_pass_env(struct user_pass *up, struct tls_multi *multi, s=
truct tls_session *session)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+set_verify_user_pass_env(const struct user_pass *up, struct tls_mul=
ti *multi, struct tls_session *session)</span><br><span> {</span><br><span>=
     /* Is username defined? */</span><br><span>     if ((session-&gt;opt-&=
gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up-&gt;username)=
)</span><br><span>@@ -1580,7 +1580,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-ssl_verify_username_length(struct tls_session *session, const char *usern=
ame)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_verify_user=
name_length(const struct tls_session *session, const char *username)</span>=
<br><span> {</span><br><span>     if ((session-&gt;opt-&gt;ssl_flags &amp; =
SSLF_USERNAME_AS_COMMON_NAME)</span><br><span>         &amp;&amp; strlen(us=
ername) &gt; TLS_USERNAME_LEN)</span><br><span>diff --git a/src/openvpn/ssl=
_verify=2Eh b/src/openvpn/ssl_verify=2Eh</span><br><span>index 3176d76=2E=
=2Ee77bc4a 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Eh</span><b=
r><span>+++ b/src/openvpn/ssl_verify=2Eh</span><br><span>@@ -202,7 +202,7 @=
@</span><br><span>  * @return              true if name is under limit or u=
sername-as-common-name</span><br><span>  *                      is not acti=
ve</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-bool ssl_verify_username_length(struct tls_session *session, const char *=
username);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ssl_=
verify_username_length(const struct tls_session *session, const char *usern=
ame);</span><br><span> </span><br><span> /**</span><br><span>  * Runs the -=
-client-crresponse script if one is defined=2E</span><br><span>@@ -275,7 +2=
75,7 @@</span><br><span> void auth_set_client_reason(struct tls_multi *mult=
i, const char *client_reason);</span><br><span> </span><br><span> static in=
line const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_=
client_reason(struct tls_multi *multi)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tls_client_reason(const struct tls_multi *multi)</span><=
br><span> {</span><br><span>     return multi-&gt;client_reason;</span><br>=
<span> }</span><br><span>diff --git a/src/openvpn/status=2Ec b/src/openvpn/=
status=2Ec</span><br><span>index c7d375b=2E=2Ecfbc38d 100644</span><br><spa=
n>--- a/src/openvpn/status=2Ec</span><br><span>+++ b/src/openvpn/status=2Ec=
</span><br><span>@@ -135,7 +135,7 @@</span><br><span> }</span><br><span> </=
span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatus_reset(struct status_output *so)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+status_reset(const struct status_output *so)</span><br><s=
pan> {</span><br><span>     if (so &amp;&amp; so-&gt;fd &gt;=3D 0)</span><b=
r><span>     {</span><br><span>diff --git a/src/openvpn/status=2Eh b/src/op=
envpn/status=2Eh</span><br><span>index 7953a4e=2E=2E4c01d75 100644</span><b=
r><span>--- a/src/openvpn/status=2Eh</span><br><span>+++ b/src/openvpn/stat=
us=2Eh</span><br><span>@@ -69,7 +69,7 @@</span><br><span> </span><br><span>=
 bool status_trigger(struct status_output *so);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void status_reset(struct status=
_output *so);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void s=
tatus_reset(const struct status_output *so);</span><br><span> </span><br><s=
pan> void status_flush(struct status_output *so);</span><br><span> </span><=
br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><=
span>index bc262cd=2E=2E7e1999d 100644</span><br><span>--- a/src/openvpn/tu=
n=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -835,7 +=
835,7 @@</span><br><span>          const char *ifconfig_ipv6_local_parm,   =
  /* --ifconfig parm 1 IPv6 */</span><br><span>          int ifconfig_ipv6_=
netbits_parm,</span><br><span>          const char *ifconfig_ipv6_remote_pa=
rm,    /* --ifconfig parm 2 IPv6 */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-         struct addrinfo *local_public, struct addrinfo *remo=
te_public, const bool strict_warn,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         const struct addrinfo *local_public, const struct a=
ddrinfo *remote_public, const bool strict_warn,</span><br><span>          s=
truct env_set *es, openvpn_net_ctx_t *ctx, struct tuntap *tt)</span><br><sp=
an> {</span><br><span>     if (!tt)</span><br><span>@@ -978,7 +978,7 @@</sp=
an><br><span>  * -&gt; helper function to simplify code below</span><br><sp=
an>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-add_route_connected_v6_net(struct tuntap *tt, const struct e=
nv_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_rout=
e_connected_v6_net(const struct tuntap *tt, const struct env_set *es)</span=
><br><span> {</span><br><span>     struct route_ipv6 r6;</span><br><span> <=
/span><br><span>@@ -1020,7 +1020,7 @@</span><br><span>  */</span><br><span>=
 </span><br><span> in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-create_arbitrary_remote(struct tuntap *tt)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+create_arbitrary_remote(const struct tuntap *=
tt)</span><br><span> {</span><br><span>     in_addr_t remote;</span><br><sp=
an> </span><br><span>@@ -1592,7 +1592,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv4(co=
nst struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br=
><span> #if defined(TARGET_LINUX)</span><br><span>     int netbits =3D netm=
ask_to_netbits2(tt-&gt;remote_netmask);</span><br><span>@@ -1627,7 +1627,7 =
@@</span><br><span> }</span><br><span> </span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv6(struct tu=
ntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t=
 *ctx)</span><br><span> {</span><br><span> #if defined(TARGET_LINUX)</span>=
<br><span>     if (net_addr_v6_del(ctx, tt-&gt;actual_name, &amp;tt-&gt;loc=
al_ipv6, tt-&gt;netbits_ipv6) &lt; 0)</span><br><span>@@ -1652,7 +1652,7 @@=
</span><br><span> }</span><br><span> </span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig(struct tuntap *tt, open=
vpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><s=
pan> {</span><br><span>     if (tt-&gt;backend_driver !=3D DRIVER_NULL &amp=
;&amp; tt-&gt;backend_driver !=3D DRIVER_AFUNIX)</span><br><span>     {</sp=
an><br><span>@@ -1729,7 +1729,7 @@</span><br><span> #endif</span><br><span>=
 </span><br><span> static ssize_t</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-write_tun_header(struct tuntap *tt, uint8_t *buf, int len)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun_header(const s=
truct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br=
><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</sp=
an><br><span>@@ -1746,9 +1746,11 @@</span><br><span>             type =3D h=
tonl(AF_INET);</span><br><span>         }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* argument to writev is a =
pointer to const but we still need to drop</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * the const from buf pointer here */</span>=
<br><span>         iv[0]=2Eiov_base =3D &amp;type;</span><br><span>        =
 iv[0]=2Eiov_len =3D sizeof(type);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        iv[1]=2Eiov_base =3D buf;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        iv[1]=2Eiov_base =3D (void *)buf;</span>=
<br><span>         iv[1]=2Eiov_len =3D len;</span><br><span> </span><br><sp=
an>         return header_modify_read_write_return(writev(tt-&gt;fd, iv, 2)=
);</span><br><span>@@ -1760,7 +1762,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static ssize_t</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-read_tun_header(struct tuntap *tt, uint8_t *buf, int len)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun_header(const st=
ruct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>=
     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br>=
<span>@@ -1786,13 +1788,13 @@</span><br><span>  */</span><br><span> #if !de=
fined(TARGET_DARWIN)</span><br><span> ssize_t</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const str=
uct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><=
span>     return write_tun_header(tt, buf, len);</span><br><span> }</span><=
br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *=
tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     return r=
ead_tun_header(tt, buf, len);</span><br><span> }</span><br><span>@@ -1808,7=
 +1810,7 @@</span><br><span> </span><br><span> #if defined(TARGET_LINUX) ||=
 defined(TARGET_FREEBSD)</span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tun_dco_enabled(struct tuntap *tt)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+tun_dco_enabled(const struct=
 tuntap *tt)</span><br><span> {</span><br><span>     return tt-&gt;backend_=
driver =3D=3D DRIVER_DCO;</span><br><span> }</span><br><span>@@ -2055,13 +2=
057,13 @@</span><br><span> }</span><br><span> </span><br><span> ssize_t</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *=
tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)</spa=
n><br><span> {</span><br><span>     return write(tt-&gt;fd, buf, len);</spa=
n><br><span> }</span><br><span> </span><br><span> ssize_t</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *bu=
f, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun=
(const struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><=
br><span>     return read(tt-&gt;fd, buf, len);</span><br><span> }</span><b=
r><span>@@ -2260,13 +2262,13 @@</span><br><span> }</span><br><span> </span>=
<br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wri=
te_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8=
_t *buf, int len)</span><br><span> {</span><br><span>     return write(tt-&=
gt;fd, buf, len);</span><br><span> }</span><br><span> </span><br><span> ssi=
ze_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct t=
untap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</spa=
n><br><span> {</span><br><span>     return read(tt-&gt;fd, buf, len);</span=
><br><span> }</span><br><span>@@ -2596,7 +2598,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tun=
tap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span>  =
   struct strbuf sbuf;</span><br><span>     sbuf=2Elen =3D len;</span><br><=
span>@@ -2605,7 +2607,7 @@</span><br><span> }</span><br><span> </span><br><=
span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun=
(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int =
len)</span><br><span> {</span><br><span>     struct strbuf sbuf;</span><br>=
<span>     int f =3D 0;</span><br><span>@@ -3103,7 +3105,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> ssize_t</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int l=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const =
struct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span><b=
r><span>     if (tt-&gt;backend_driver =3D=3D DRIVER_UTUN)</span><br><span>=
     {</span><br><span>@@ -3116,7 +3118,7 @@</span><br><span> }</span><br><=
span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, =
uint8_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;b=
ackend_driver =3D=3D DRIVER_UTUN)</span><br><span>     {</span><br><span>@@=
 -3320,7 +3322,7 @@</span><br><span> }</span><br><span> </span><br><span> i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_write_queue(str=
uct tuntap *tt, struct buffer *buf)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+tun_write_queue(struct tuntap *tt, const struct buffer *buf=
)</span><br><span> {</span><br><span>     if (tt-&gt;writes=2Eiostate =3D=
=3D IOSTATE_INITIAL)</span><br><span>     {</span><br><span>@@ -3375,7 +337=
7,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-tun_write_win32(struct tuntap *t=
t, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+tun_write_win32(struct tuntap *tt, const struct buffer *buf)</span><br><=
span> {</span><br><span>     int err =3D 0;</span><br><span>     int status=
 =3D 0;</span><br><span>@@ -5383,7 +5385,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-fork_register_dns_action(struct tuntap *tt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+fork_register_dns_action(const struct tun=
tap *tt)</span><br><span> {</span><br><span>     if (tt &amp;&amp; tt-&gt;o=
ptions=2Eregister_dns &amp;&amp; tt-&gt;options=2Emsg_channel)</span><br><s=
pan>     {</span><br><span>@@ -5473,7 +5475,7 @@</span><br><span> }</span><=
br><span> </span><br><span> static void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-tuntap_get_mtu(struct tuntap *tt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tuntap_get_mtu(const struct tuntap *tt)</=
span><br><span> {</span><br><span>     ULONG mtu =3D 0;</span><br><span>   =
  DWORD len;</span><br><span>@@ -6048,7 +6050,7 @@</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-tun_show_debug(struct tuntap *tt)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+tun_show_debug(const struct tuntap *tt)</span><b=
r><span> {</span><br><span>     if (tt-&gt;backend_driver =3D=3D WINDOWS_DR=
IVER_TAP_WINDOWS6)</span><br><span>     {</span><br><span>diff --git a/src/=
openvpn/tun=2Eh b/src/openvpn/tun=2Eh</span><br><span>index 931e54d=2E=2Ebe=
b0d0e 100644</span><br><span>--- a/src/openvpn/tun=2Eh</span><br><span>+++ =
b/src/openvpn/tun=2Eh</span><br><span>@@ -272,9 +272,9 @@</span><br><span> =
</span><br><span> void close_tun_handle(struct tuntap *tt);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t write_tun(s=
truct tuntap *tt, uint8_t *buf, int len);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ssize_t write_tun(const struct tuntap *tt, const uint=
8_t *buf, int len);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-ssize_t read_tun(struct tuntap *tt, uint8_t *buf, int len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t read_tun(co=
nst struct tuntap *tt, uint8_t *buf, int len);</span><br><span> </span><br>=
<span> #ifdef ENABLE_FEATURE_TUN_PERSIST</span><br><span> void tuncfg(const=
 char *dev, const char *dev_type, const char *dev_node, int persist_mode,</=
span><br><span>@@ -293,7 +293,7 @@</span><br><span>                        =
 const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */</=
span><br><span>                         int ifconfig_ipv6_netbits_parm,    =
       /* --ifconfig parm 1 / bits */</span><br><span>                     =
    const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
    struct addrinfo *local_public, struct addrinfo *remote_public,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        cons=
t struct addrinfo *local_public, const struct addrinfo *remote_public,</spa=
n><br><span>                         const bool strict_warn, struct env_set=
 *es, openvpn_net_ctx_t *ctx,</span><br><span>                         stru=
ct tuntap *tt);</span><br><span> </span><br><span>@@ -320,7 +320,7 @@</span=
><br><span>  * @param tt    the tuntap interface context</span><br><span>  =
* @param ctx   the networking API opaque context</span><br><span>  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void undo_ifconfig(struct t=
untap *tt, openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx=
_t *ctx);</span><br><span> </span><br><span> bool is_dev_type(const char *d=
ev, const char *dev_type, const char *match_type);</span><br><span> </span>=
<br><span>@@ -351,7 +351,7 @@</span><br><span> #define IFCONFIG_DEFAULT IFC=
ONFIG_AFTER_TUN_OPEN</span><br><span> </span><br><span> static inline int</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_order(struct t=
untap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_=
order(const struct tuntap *tt)</span><br><span> {</span><br><span>     if (=
tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><b=
r><span>@@ -381,7 +381,7 @@</span><br><span> #define ROUTE_ORDER_DEFAULT RO=
UTE_AFTER_TUN</span><br><span> </span><br><span> static inline int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-route_order(struct tuntap *tt)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+route_order(const s=
truct tuntap *tt)</span><br><span> {</span><br><span>     if (tt-&gt;backen=
d_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -4=
54,13 +454,13 @@</span><br><span> </span><br><span> const char *tap_win_get=
info(const struct tuntap *tt, struct gc_arena *gc);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void tun_show_debug(struct =
tuntap *tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tu=
n_show_debug(const struct tuntap *tt);</span><br><span> </span><br><span> b=
ool dhcp_release_by_adapter_index(const DWORD adapter_index);</span><br><sp=
an> </span><br><span> bool dhcp_renew_by_adapter_index(const DWORD adapter_=
index);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-void fork_register_dns_action(struct tuntap *tt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void fork_register_dns_action(const struc=
t tuntap *tt);</span><br><span> </span><br><span> void ipconfig_register_dn=
s(const struct env_set *es);</span><br><span> </span><br><span>@@ -470,7 +4=
70,7 @@</span><br><span> </span><br><span> int tun_read_queue(struct tuntap=
 *tt, int maxsize);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-int tun_write_queue(struct tuntap *tt, struct buffer *buf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int tun_write_queue=
(struct tuntap *tt, const struct buffer *buf);</span><br><span> </span><br>=
<span> static inline bool</span><br><span> tuntap_stop(int status)</span><b=
r><span>@@ -499,7 +499,7 @@</span><br><span>     return false;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int tun_write_win32(struct tuntap *tt, struct buffer *buf);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+int tun_write_win32(struct tunta=
p *tt, const struct buffer *buf);</span><br><span> </span><br><span> static=
 inline bool</span><br><span> is_ip_packet_valid(const struct buffer *buf)<=
/span><br><span>@@ -529,13 +529,13 @@</span><br><span> }</span><br><span> <=
/span><br><span> static inline bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-tuntap_is_dco_win(struct tuntap *tt)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win(const struct tuntap *tt)</=
span><br><span> {</span><br><span>     return tt &amp;&amp; tt-&gt;backend_=
driver =3D=3D DRIVER_DCO;</span><br><span> }</span><br><span> </span><br><s=
pan> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const =
struct tuntap *tt, ssize_t status)</span><br><span> {</span><br><span>     =
return tuntap_is_dco_win(tt) &amp;&amp; (status &lt; 0) &amp;&amp; (openvpn=
_errno() =3D=3D ERROR_NETNAME_DELETED);</span><br><span> }</span><br><span>=
@@ -555,25 +555,25 @@</span><br><span> }</span><br><span> </span><br><span>=
 static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tu=
n_standby_init(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+tun_standby_init(const struct tuntap *tt)</span><br><span> {<=
/span><br><span> }</span><br><span> </span><br><span> static inline bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_standby(struct tunta=
p *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_standby(c=
onst struct tuntap *tt)</span><br><span> {</span><br><span>     return true=
;</span><br><span> }</span><br><span> </span><br><span> </span><br><span> s=
tatic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tunt=
ap_is_dco_win(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+tuntap_is_dco_win(const struct tuntap *tt)</span><br><span> {<=
/span><br><span>     return false;</span><br><span> }</span><br><span> </sp=
an><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeo=
ut(const struct tuntap *tt, ssize_t status)</span><br><span> {</span><br><s=
pan>     return false;</span><br><span> }</span><br><span>diff --git a/src/=
openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec</span><br><span>index a=
67a472=2E=2Ee9223bc 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Ec=
</span><br><span>+++ b/src/openvpn/tun_afunix=2Ec</span><br><span>@@ -48,7 =
+48,7 @@</span><br><span> </span><br><span> </span><br><span> static void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_afunix_exec_child(c=
onst char *dev_node, struct tuntap *tt, struct env_set *env)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_exec_child(const char *=
dev_node, struct tuntap *tt, const struct env_set *env)</span><br><span> {<=
/span><br><span>     const char *msgprefix =3D &quot;ERROR: failure executi=
ng process for tun:&quot;;</span><br><span>     struct argv argv =3D argv_n=
ew();</span><br><span>@@ -73,7 +73,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct env=
_set *orig_env)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+open=
_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, const stru=
ct env_set *orig_env)</span><br><span> {</span><br><span>     struct gc_are=
na gc =3D gc_new();</span><br><span> </span><br><span>diff --git a/src/open=
vpn/tun_afunix=2Eh b/src/openvpn/tun_afunix=2Eh</span><br><span>index 5b6a8=
e0=2E=2Efb88eb2 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Eh</sp=
an><br><span>+++ b/src/openvpn/tun_afunix=2Eh</span><br><span>@@ -31,7 +31,=
7 @@</span><br><span>  * the user provided taking care of implementing the =
actual tun</span><br><span>  * device=2E</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void open_tun_afunix(struct options=
 *o, int mtu, struct tuntap *tt, struct env_set *env);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void open_tun_afunix(const struct option=
s *o, int mtu, struct tuntap *tt, const struct env_set *env);</span><br><sp=
an> </span><br><span> </span><br><span> /**</span><br><span>diff --git a/sr=
c/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec</span><br><span>index bffc60e=2E=
=2Ecd32a9b 100644</span><br><span>--- a/src/openvpn/vlan=2Ec</span><br><spa=
n>+++ b/src/openvpn/vlan=2Ec</span><br><span>@@ -288,7 +288,7 @@</span><br>=
<span> }</span><br><span> </span><br><span> void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-vlan_process_outgoing_tun(struct multi_context *=
m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+vlan_process_outgoing_tun(const struct multi_context *m, struct m=
ulti_instance *mi)</span><br><span> {</span><br><span>     if (!m-&gt;top=
=2Eoptions=2Evlan_tagging)</span><br><span>     {</span><br><span>diff --gi=
t a/src/openvpn/vlan=2Eh b/src/openvpn/vlan=2Eh</span><br><span>index 9389f=
89=2E=2Ecd2f66f 100644</span><br><span>--- a/src/openvpn/vlan=2Eh</span><br=
><span>+++ b/src/openvpn/vlan=2Eh</span><br><span>@@ -35,6 +35,6 @@</span><=
br><span> </span><br><span> bool vlan_is_tagged(const struct buffer *buf);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void=
 vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *=
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void vlan_proce=
ss_outgoing_tun(const struct multi_context *m, struct multi_instance *mi);<=
/span><br><span> </span><br><span> #endif /* VLAN_H */</span><br><span>diff=
 --git a/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh</span><br><span>inde=
x ef32062=2E=2Ebcbfa67 100644</span><br><span>--- a/src/openvpn/win32=2Eh</=
span><br><span>+++ b/src/openvpn/win32=2Eh</span><br><span>@@ -226,7 +226,7=
 @@</span><br><span> void overlapped_io_close(struct overlapped_io *o);</sp=
an><br><span> </span><br><span> static inline bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-overlapped_io_active(struct overlapped_io *o)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+overlapped_io_active=
(const struct overlapped_io *o)</span><br><span> {</span><br><span>     ret=
urn o-&gt;iostate =3D=3D IOSTATE_QUEUED || o-&gt;iostate =3D=3D IOSTATE_IMM=
EDIATE_RETURN;</span><br><span> }</span><br><span>diff --git a/src/openvpnm=
sica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>i=
ndex a861e8a=2E=2E25fa1e4 100644</span><br><span>--- a/src/openvpnmsica/ope=
nvpnmsica=2Ec</span><br><span>+++ b/src/openvpnmsica/openvpnmsica=2Ec</span=
><br><span>@@ -77,7 +77,7 @@</span><br><span>  * @return ERROR_SUCCESS on s=
uccess; An error code otherwise</span><br><span>  */</span><br><span> stati=
c UINT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-setup_sequence(=
_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ struct msica_arg_s=
eq *seq)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+setup_seque=
nce(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ const struct m=
sica_arg_seq *seq)</span><br><span> {</span><br><span>     UINT uiResult;</=
span><br><span>     LPWSTR szSequence =3D msica_arg_seq_join(seq);</span><b=
r><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/inte=
ractive=2Ec</span><br><span>index a9e9665=2E=2E36c2847 100644</span><br><sp=
an>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpns=
erv/interactive=2Ec</span><br><span>@@ -522,7 +522,7 @@</span><br><span> </=
span><br><span> </span><br><span> static SOCKADDR_INET</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-sockaddr_inet(short family, inet_address_t=
 *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sockaddr_ine=
t(short family, const inet_address_t *addr)</span><br><span> {</span><br><s=
pan>     SOCKADDR_INET sa_inet;</span><br><span>     ZeroMemory(&amp;sa_ine=
t, sizeof(sa_inet));</span><br><span>@@ -3841,7 +3841,7 @@</span><br><span>=
 </span><br><span> static DWORD</span><br><span> UpdateWaitHandles(LPHANDLE=
 *handles_ptr, LPDWORD count, HANDLE io_event, HANDLE exit_event,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                  list_item_t *=
threads)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
       const list_item_t *threads)</span><br><span> {</span><br><span>     =
static DWORD size =3D 10;</span><br><span>     static LPHANDLE handles =3D =
NULL;</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_management=
=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>index 7=
7f6ce2=2E=2Efff4c2b 100644</span><br><span>--- a/tests/unit_tests/openvpn/m=
ock_management=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_mana=
gement=2Ec</span><br><span>@@ -36,7 +36,7 @@</span><br><span> struct manage=
ment *management; /* GLOBAL */</span><br><span> </span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(st=
ruct management *man, const char *type, const char *reason)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+management_auth_failure(const struc=
t management *man, const char *type, const char *reason)</span><br><span> {=
</span><br><span>     ASSERT(false);</span><br><span> }</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn=
/test_misc=2Ec</span><br><span>index 6c39b7f=2E=2E8c964c7 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/te=
sts/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -145,7 +145,7 @@</s=
pan><br><span> }</span><br><span> </span><br><span> static struct hash_elem=
ent *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_lookup_by_v=
alue(struct hash *hash, void *value)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+hash_lookup_by_value(struct hash *hash, const void *value)=
</span><br><span> {</span><br><span>     struct hash_iterator hi;</span><br=
><span>     struct hash_element *he;</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pas=
s=2Ec</span><br><span>index c0a0866=2E=2E7636a33 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_user_pass=2Ec</span><br><span>@@ -59,7 +59,7 @@</sp=
an><br><span>     return mock();</span><br><span> }</span><br><span> void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_auth_failure=
(struct management *man, const char *type, const char *reason)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+management_auth_failure(const st=
ruct management *man, const char *type, const char *reason)</span><br><span=
> {</span><br><span>     assert_true(0);</span><br><span> }</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1663?usp=3Demail">change 1663</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5d=
af2b116f58 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1663 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D=
"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--gkw6zbq8oMk=--


--===============1650974314612895514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1650974314612895514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1650974314612895514==--

