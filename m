Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4231EC79FA1
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DeRHoyEh1+ep5S/Z7idyRMPnWzsCbXoNLJQKXCA7ZF8=; b=KjbN6rpubp0IeeUYtz37VN1oHp
	ohy4uVNwGOFJLl8bV1t9IuP+Kwy3g/H1XcaWem5pq3HhIHcFOGE1qLC1J4T5EFKI38o6Kh9SEsYYw
	RpRVdFE2uzt6IPbEsnjUwIuWJX5db4vmphzf0DCjtxLxI9DZ3Xmy7zmMDqFjiPDbJKds=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3bn5-0007nT-OA;
	Mon, 07 Sep 2026 16:01:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3bn3-0007nN-Nv
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:01:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KlLweRCAhZl2an/uTSEtT6gbza+TcLXi3/bdgEwTWps=; b=EetHGxj6cUpmE8JqwEJF5F8AjG
 /XNWCNmBEO+z76r5ZPn55zU/6O+ZbeZerjmpqyROQaAwK07sQO8MGEs/cksO5smTHQSY1mxld/75D
 mH1z8UHNAWTZjL4LQqp6pyuL3ZXQ6hlxG+m/InR5SaYnsmarRpyMkXBw7z0o0mz/QpDI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KlLweRCAhZl2an/uTSEtT6gbza+TcLXi3/bdgEwTWps=; b=b
 4rF8DhtclFbw9cMVjpBIKAkL77TteiHAmjTqG8rg+zwO1JXUZUcS8mJZ6yeQN0d63HfgxMPoMBHmX
 xVwmVpwy+iW9aWruTy14mCLV4mraN1GSHMtAANOr75cidYB6HJ6Fpq9aWtG4TJXHk3zByazSsqnBL
 Hr96CrK3SKz0UvAA=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3bmx-0005um-8k for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:01:49 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so35824355e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788796897; x=1789401697; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KlLweRCAhZl2an/uTSEtT6gbza+TcLXi3/bdgEwTWps=;
 b=Q76BVVe3zet4BrtoLm4wjdCrZEF50M8I4UMLJwrYmqimu6tqr9NUM1tYEn7iuflQiE
 AyBMOODepBwZFAcVnbl17izwdLoOt6Hu4LFtTFjaLvh1b60AzBwal7uyVcm4ytzRuc1p
 7guU/ptLQaFBfQTjhQH4ztxWA1W/0tBXF04G5EdhllgCcdig3dqGZWn6jUfjZptwIQiY
 3jvoZFljYzMQ+btVlrv61CXvKtwWj60OjX1LJYNLfNAwDi8AQE2OjK+8Lk3hzEh87w1U
 EaRgn3aFeReUWgBNvzpnCIKalr0m/mnV0hRlsBhXbrd67J32sZyIZi9YXr3kadgtT93F
 A0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788796897; x=1789401697;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KlLweRCAhZl2an/uTSEtT6gbza+TcLXi3/bdgEwTWps=;
 b=gtL//UaS1zYm2UHzUY82jEcrTQznVTeGWy8UYpl24GJmfuNICwUwTI5OPXG6iePGXd
 +RGU92Mx82lz2p2GzbQPLhOe9sdxjPUUY1WLiGv7RNmzPJGYeEyT/aFHgeWMo8LVNY1e
 RdRi6UCQvloZX/r5rAxt5kqA1+laYDtwIvD73vNHnQJJaOyEy1dzv5ORrCt2gFcABDJA
 BDvjwOHiEFkqImU8X9jrD+30j487HIhFKsqvSW5x1lyi25REhAXJhn4FSocG5aC8v5uD
 Fj9/6NwtwBIIpMIM6ojFq6DoEIgCAXvoITCbWK3J0qdQ10pvONBLkrP1Tnbgty7NqUi0
 KLjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+gr5TiI8Xh+gfWF3KOdLETBoYxs9q0QG6Wuaj1xTpjTN1xiqj6rNS42sGZTH9ZIZKT64oQfcG8N3BNFYt@lists.sourceforge.net
X-Gm-Message-State: AFuF++ltmjTYaIRlLQ9/yF1GEKxGLnXA0BysMnmSRrDK/Hg5pQMStgtl
 Xk3Ry8/6KfPcf4pbqCLB4rgIoyEoP4/Jkl6A5p9KImq3XPL8qofVvsIiOCWl7aq0FflxhoO+/yk
 YNBXQKtiHbTQ/mtxj9h+7Nsvdba6JNvhn/objOn5wRoGBtGDNxvgUwhjJC2N0vLE9lBFK5BIHg9
 wPDdDN2A==
X-Gm-Gg: AYBFou0JXPxixReLjTPBQrwhufwJiGgm3rgr2hxfwChwccxJAoSKD3zNx951lZVwxH0
 2o10b6xHneTQDMkqauWd/DMmvI3F6Wvfr/+CxQULyYm6c7R0CjkzIW+/NVlQ+qBqnMVkXaK4eh9
 nbuXlweevdsyaocZsQybWPqdPWhf6O/vLY3OEvrKWJieYI9V5VuyYOH0hLCjdBxM6uqp/FFVcA5
 resaumSim7CfkD+QL1K9RrfTwQXmvKpiynR/SSEFFTHBzDOafPDcUnkVKXS3Cubl7fLFiu17i0w
 lRsq65FYbnoKgi55FxkXjlz7jBEV9nqiOuKDAXIzk0S/blBBwC0jAA8eOMEoqtLh6bz2MuXIakV
 JC9nxy1L2YFnO4PbH8MP1dwtye9krtFk2vWr23I0nKxjPl13dM5fM28EiXAqZlyfyAT6W51+9ka
 Ui2aFMmS+GOcM8xSAX2tfAOCsvUg7ESsiVW/5vB1eMVU0ZRsZOSLVjpdxJzHEWjpOTuk1zg+7jf
 wu+/vLrF8kWaUygJYrcVU/pNhs3ENSBnk+7GqSuTHcNxeZRD2P4n6MS0uilyDjENLpkiHnclaGl
 xzaAq2xZFH1TbbCddrs8zzAguZSTkxqf6LdURHXjibEv2T61Vrc=
X-Received: by 2002:a05:600c:6214:b0:49c:dca4:94c with SMTP id
 5b1f17b1804b1-49cf825115bmr481043765e9.13.1788796891959; 
 Mon, 07 Sep 2026 09:01:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfd3f815bsm230250285e9.4.2026.09.07.09.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:01:31 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 16:01:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: e0b4f924dbba0bc73155270d0db8a50fb12c92c2
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c8ab257d814fd66aac81aeb41bcd14e1203b2d8c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3bmx-0005um-8k
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0634022607324922488=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0634022607324922488==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8582YZ0uhVU="; charset=UTF-8

--8582YZ0uhVU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail

to look at the new patch=
 set (#19)=2E


Change subject: Remove instances of constParameterPointer c=
ppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Remove instances of constParameterPointer cppcheck warnings

This requ=
ires a few suppressions since cppcheck
doesn't quite understand the differe=
nt code-paths
implemented by preprocessor defines=2E

Change-Id: I56248cf6d=
199c2da770774b8fd1e5daf2b116f58
Signed-off-by: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
---
M dev-tools/cppcheck-suppression
M sample/sample-plugin=
s/client-connect/sample-client-connect=2Ec
M sample/sample-plugins/defer/mu=
lti-auth=2Ec
M sample/sample-plugins/keying-material-exporter-demo/keyingma=
terialexporter=2Ec
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/=
openvpn/clinat=2Ec
M src/openvpn/clinat=2Eh
M src/openvpn/comp=2Ec
M src/op=
envpn/comp=2Eh
M src/openvpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/open=
vpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M src/openv=
pn/dco_internal=2Eh
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
M=
 src/openvpn/dhcp=2Ec
M src/openvpn/dhcp=2Eh
M src/openvpn/event=2Eh
M src/=
openvpn/forward=2Ec
M src/openvpn/forward=2Eh
M src/openvpn/init=2Ec
M src/=
openvpn/init=2Eh
M src/openvpn/interval=2Eh
M src/openvpn/list=2Ec
M src/op=
envpn/list=2Eh
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/open=
vpn/mbuf=2Ec
M src/openvpn/mbuf=2Eh
M src/openvpn/mss=2Ec
M src/openvpn/mss=
=2Eh
M src/openvpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/openvpn/mudp=2Ec
M=
 src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/multi_io=2Ec
M=
 src/openvpn/networking=2Eh
M src/openvpn/networking_iproute2=2Ec
M src/ope=
nvpn/networking_sitnl=2Ec
M src/openvpn/occ=2Eh
M src/openvpn/openssl_compa=
t=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options_parse=2Ec
M src/openv=
pn/otime=2Ec
M src/openvpn/otime=2Eh
M src/openvpn/proto=2Eh
M src/openvpn/=
proxy=2Ec
M src/openvpn/proxy=2Eh
M src/openvpn/ps=2Ec
M src/openvpn/ps=2Eh=

M src/openvpn/push=2Ec
M src/openvpn/push=2Eh
M src/openvpn/push_util=2Ec
=
M src/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
M src/openvpn/route=
=2Ec
M src/openvpn/schedule=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/sock=
et=2Eh
M src/openvpn/socket_util=2Eh
M src/openvpn/socks=2Ec
M src/openvpn/=
socks=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl=2Eh
M src/openvpn/ssl_bac=
kend=2Eh
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/=
openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M src/openvpn/ssl_verify=2Ec
=
M src/openvpn/ssl_verify=2Eh
M src/openvpn/status=2Ec
M src/openvpn/status=
=2Eh
M src/openvpn/tun=2Ec
M src/openvpn/tun=2Eh
M src/openvpn/tun_afunix=
=2Ec
M src/openvpn/tun_afunix=2Eh
M src/openvpn/vlan=2Ec
M src/openvpn/vlan=
=2Eh
M src/openvpn/win32=2Eh
M src/openvpnmsica/openvpnmsica=2Ec
M src/open=
vpnserv/interactive=2Ec
M tests/unit_tests/openvpn/mock_management=2Ec
M te=
sts/unit_tests/openvpn/test_misc=2Ec
M tests/unit_tests/openvpn/test_user_p=
ass=2Ec
89 files changed, 358 insertions(+), 307 deletions(-)


  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1663/19

diff --=
git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index=
 965e8ec=2E=2E59262160f 100644
--- a/dev-tools/cppcheck-suppression
+++ b/d=
ev-tools/cppcheck-suppression
@@ -2,7 +2,6 @@
 # occurences right now=2E Th=
ey still should be fixed at some point
 constParameter
 constParameterCallb=
ack
-constParameterPointer
 invalidPrintfArgType_sint
 invalidPrintfArgType=
_uint
 unusedFunction
@@ -27,13 +26,48 @@
 # FP: posix=2Ecfg claims susecon=
ds_t is unsigned for some reason
 unsignedLessThanZero:src/openvpn/otime=2E=
h:148
 # IGN: multi code does weird things with pointers to local variables=
=2E=2E=2E
-autoVariables:src/openvpn/multi=2Ec:4232
+autoVariables:src/open=
vpn/multi=2Ec:4233
 autoVariables:src/openvpn/multi_io=2Ec:324
 # IGN: the =
code header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally
 badBi=
tmaskCheck:src/openvpn/mudp=2Ec
 badBitmaskCheck:tests/unit_tests/openvpn/t=
est_pkt=2Ec
 # IGN: we store integers in pointers
 CastAddressToIntegerAtRe=
turn:src/openvpn/multi=2Ec
+# IGN: external
+constParameterPointer:/usr/inc=
lude/*
+# IGN: test files provide mocks/stubs that match prototypes from he=
aders exactly
+constParameterPointer:tests/unit_tests/openvpn/mock_*
+const=
ParameterPointer:tests/unit_tests/openvpn/test_*
+constParameterPointer:tes=
ts/unit_tests/openvpnserv/test_*
+# FP: different crypto implementations bu=
t same API
+constParameterPointer:src/openvpn/crypto_mbedtls_legacy=2Ec:85
=
+constParameterPointer:src/openvpn/crypto_openssl=2Ec:173
+constParameterPo=
inter:src/openvpn/crypto_openssl=2Ec:1433
+constParameterPointer:src/openvp=
n/cryptoapi=2Ec:58
+constParameterPointer:src/openvpn/ssl_mbedtls=2Ec
+cons=
tParameterPointer:src/openvpn/ssl_openssl=2Ec
+constParameterPointer:src/op=
envpn/ssl_verify_mbedtls=2Ec
+constParameterPointer:tests/unit_tests/openvp=
n/siphash_openssl=2Ec
+# IGN: too many different implementations, not worth=
 it
+constParameterPointer:src/openvpn/dco*
+constParameterPointer:src/open=
vpn/socket=2E*
+# FP: parameters are modified on some platform only
+constP=
arameterPointer:src/openvpn/dns=2Ec:859
+constParameterPointer:src/openvpn/=
error=2Ec:223
+constParameterPointer:src/openvpn/forward=2Ec:1245
+constPar=
ameterPointer:src/openvpn/manage=2Ec:344
+constParameterPointer:src/openvpn=
/manage=2Ec:3332
+constParameterPointer:src/openvpn/misc=2Ec:793
+constPara=
meterPointer:src/openvpn/misc=2Ec:813
+constParameterPointer:src/openvpn/op=
tions=2Ec:3205
+constParameterPointer:src/openvpn/route=2Ec:3947
+constPara=
meterPointer:src/openvpn/tun=2Ec:560
+constParameterPointer:src/openvpn/tun=
=2Ec:2188
+constParameterPointer:src/openvpn/tun_afunix=2Ec
+# IGN: not a F=
P but the documentation for the FP_ISSET claims this is not const=2E=2E=2E
=
+constParameterPointer:src/openvpn/event=2Ec:1015
+# IGN: fun:check_malloc_=
return: causes -Wmaybe-uninitialized in MinGW Debug build
+constParameterPo=
inter:src/openvpn/buffer=2Eh:2082
 # IGN: Windows specific (unsigned long =
=3D=3D unsigned int)
 compareValueOutOfTypeRangeError:src/openvpn/ssl_verif=
y=2Ec:928
 # FP: cppcheck seems to have wrong signature of DeviceIoControl(=
)
diff --git a/sample/sample-plugins/client-connect/sample-client-connect=
=2Ec b/sample/sample-plugins/client-connect/sample-client-connect=2Ec
index=
 420de61=2E=2Ecbd98e8 100644
--- a/sample/sample-plugins/client-connect/sam=
ple-client-connect=2Ec
+++ b/sample/sample-plugins/client-connect/sample-cl=
ient-connect=2Ec
@@ -344,7 +344,7 @@
 }
 
 int
-openvpn_plugin_client_conne=
ct(struct plugin_context *context, const char **argv, const char **envp)
+o=
penvpn_plugin_client_connect(const struct plugin_context *context, const ch=
ar **argv, const char **envp)
 {
     /* log environment variables handed t=
o us by OpenVPN, but
      * only if "setenv verb" is 3 or higher (arbitrar=
y number)
@@ -465,7 +465,7 @@
 
 int
 openvpn_plugin_client_connect_defer_v=
2(struct plugin_context *context,
-                                       s=
truct plugin_per_client_context *pcc,
+                                    =
   const struct plugin_per_client_context *pcc,
                           =
             struct openvpn_plugin_string_list **return_list)
 {
     time_=
t time_left =3D pcc->sleep_until - time(NULL);
diff --git a/sample/sample-p=
lugins/defer/multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec
in=
dex bacf557=2E=2Ecdd616f 100644
--- a/sample/sample-plugins/defer/multi-aut=
h=2Ec
+++ b/sample/sample-plugins/defer/multi-auth=2Ec
@@ -255,7 +255,7 @@
=
 }
 
 static bool
-do_auth_user_pass(struct plugin_context *context, const =
char *username, const char *password)
+do_auth_user_pass(const struct plugi=
n_context *context, const char *username, const char *password)
 {
     plo=
g(context, PLOG_NOTE, "expect_user=3D%s, received_user=3D%s, expect_passw=
=3D%s, received_passw=3D%s",
          np(context->test_valid_user), np(use=
rname), np(context->test_valid_pass), np(password));
@@ -279,7 +279,7 @@
 
=
 
 static int
-auth_user_pass_verify(struct plugin_context *context, struct=
 plugin_per_client_context *pcc,
+auth_user_pass_verify(const struct plugin=
_context *context, struct plugin_per_client_context *pcc,
                 =
      const char *argv[], const char *envp[])
 {
     /* get username/passw=
ord from envp string array */
diff --git a/sample/sample-plugins/keying-mat=
erial-exporter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/keyi=
ng-material-exporter-demo/keyingmaterialexporter=2Ec
index 25c9ff5=2E=2E512=
861a 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyin=
gmaterialexporter=2Ec
+++ b/sample/sample-plugins/keying-material-exporter-=
demo/keyingmaterialexporter=2Ec
@@ -186,7 +186,7 @@
 }
 
 static void
-file=
_store(char *file, char *content)
+file_store(const char *file, const char =
*content)
 {
     FILE *f;
     if (!(f =3D fopen(file, "w+")))
@@ -202,7 +=
202,7 @@
 server_store(struct openvpn_plugin_args_func_in const *args)
 {
 =
    struct plugin *plugin =3D (struct plugin *)args->handle;
-    struct se=
ssion *sess =3D (struct session *)args->per_client_context;
+    const stru=
ct session *sess =3D (struct session *)args->per_client_context;
 
     cha=
r file[MAXPATH];
     snprintf(file, sizeof(file) - 1, "/tmp/openvpn_sso_%s=
", sess->key);
@@ -214,7 +214,7 @@
 client_store(struct openvpn_plugin_args=
_func_in const *args)
 {
     struct plugin *plugin =3D (struct plugin *)ar=
gs->handle;
-    struct session *sess =3D (struct session *)args->per_clien=
t_context;
+    const struct session *sess =3D (struct session *)args->per_=
client_context;
 
     char *file =3D "/tmp/openvpn_sso_user";
     ovpn_no=
te("app session file: %s", file);
diff --git a/src/openvpn/buffer=2Ec b/src=
/openvpn/buffer=2Ec
index 5ce2e39=2E=2E40d5c40 100644
--- a/src/openvpn/buf=
fer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -270,7 +270,7 @@
  * truncated by b=
uf_printf
  */
 void
-buf_catrunc(struct buffer *buf, const char *str)
+buf=
_catrunc(const struct buffer *buf, const char *str)
 {
     if (buf_forward=
_capacity(buf) <=3D 1)
     {
@@ -1035,7 +1035,7 @@
 }
 
 bool
-string_chec=
k_buf(struct buffer *buf, const unsigned int inclusive, const unsigned int =
exclusive)
+string_check_buf(const struct buffer *buf, const unsigned int i=
nclusive, const unsigned int exclusive)
 {
     ASSERT(buf);
 
diff --git a=
/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 4471697=2E=2E9488698=
 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -853,7=
 +853,7 @@
  * @param buf   The buffer to append the truncation marker to=
=2E
  * @param str   The null-terminated marker string to write=2E
  */
-vo=
id buf_catrunc(struct buffer *buf, const char *str);
+void buf_catrunc(cons=
t struct buffer *buf, const char *str);
 
 /**
  * Extract the next token f=
rom a buffer, delimited by a given character=2E
@@ -1427,7 +1427,7 @@
  *  =
       is empty=2E
  */
 static inline int
-buf_peek_u8(struct buffer *buf)=

+buf_peek_u8(const struct buffer *buf)
 {
     int ret;
     if (BLEN(buf)=
 < 1)
@@ -1720,7 +1720,7 @@
  * @param exclusive Character classes that are=
 not allowed even if they are also in inclusive=2E
  * @return True if the =
string consists only of allowed characters, false otherwise=2E
  */
-bool s=
tring_check_buf(struct buffer *buf, const unsigned int inclusive,
+bool str=
ing_check_buf(const struct buffer *buf, const unsigned int inclusive,
     =
                  const unsigned int exclusive);
 
 /**
@@ -1856,7 +1856,7 =
@@
  * @param a  The arena to test=2E
  */
 static inline bool
-gc_defined(=
struct gc_arena *a)
+gc_defined(const struct gc_arena *a)
 {
     return a-=
>list !=3D NULL;
 }
diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clina=
t=2Ec
index 3724022=2E=2Ed03f9f2 100644
--- a/src/openvpn/clinat=2Ec
+++ b/=
src/openvpn/clinat=2Ec
@@ -159,7 +159,7 @@
 #endif
 
 static void
-print_pk=
t(struct openvpn_iphdr *iph, const char *prefix, const int direction, const=
 msglvl_t msglevel)
+print_pkt(const struct openvpn_iphdr *iph, const char =
*prefix, const int direction, const msglvl_t msglevel)
 {
     struct gc_ar=
ena gc =3D gc_new();
 
@@ -181,7 +181,7 @@
 }
 
 void
-client_nat_transform=
(const struct client_nat_option_list *list, struct buffer *ipbuf,
+client_n=
at_transform(const struct client_nat_option_list *list, const struct buffer=
 *ipbuf,
                      const int direction)
 {
     struct ip_tcp_u=
dp_hdr *h =3D (struct ip_tcp_udp_hdr *)BPTR(ipbuf);
diff --git a/src/openvp=
n/clinat=2Eh b/src/openvpn/clinat=2Eh
index 1e8ceb3=2E=2Ebc56037 100644
---=
 a/src/openvpn/clinat=2Eh
+++ b/src/openvpn/clinat=2Eh
@@ -60,7 +60,7 @@
  =
                                  const char *network, const char *netmask,=

                                    const char *foreign_network, msglvl_t =
msglevel);
 
-void client_nat_transform(const struct client_nat_option_list=
 *list, struct buffer *ipbuf,
+void client_nat_transform(const struct clien=
t_nat_option_list *list, const struct buffer *ipbuf,
                      =
     const int direction);
 
 #endif /* if !defined(CLINAT_H) */
diff --git=
 a/src/openvpn/comp=2Ec b/src/openvpn/comp=2Ec
index b88b79f=2E=2E387a7c4 1=
00644
--- a/src/openvpn/comp=2Ec
+++ b/src/openvpn/comp=2Ec
@@ -159,7 +159,=
7 @@
 #endif /* USE_COMP */
 
 bool
-check_compression_settings_valid(struc=
t compress_options *info, msglvl_t msglevel)
+check_compression_settings_va=
lid(const struct compress_options *info, msglvl_t msglevel)
 {
     /*
    =
  * We also allow comp-stub-v2 here as it technically allows escaping of
di=
ff --git a/src/openvpn/comp=2Eh b/src/openvpn/comp=2Eh
index 29a90a2=2E=2Ea=
d80243 100644
--- a/src/openvpn/comp=2Eh
+++ b/src/openvpn/comp=2Eh
@@ -91,=
7 +91,7 @@
  * flags of allow-compression and also the whether algorithms a=
re compiled
  * in
  */
-bool check_compression_settings_valid(struct compr=
ess_options *info, msglvl_t msglevel);
+bool check_compression_settings_val=
id(const struct compress_options *info, msglvl_t msglevel);
 
 #ifdef USE_C=
OMP
 #include "buffer=2Eh"
diff --git a/src/openvpn/crypto=2Ec b/src/openvp=
n/crypto=2Ec
index e5ad31a=2E=2Ee29d581 100644
--- a/src/openvpn/crypto=2Ec=

+++ b/src/openvpn/crypto=2Ec
@@ -1105,7 +1105,7 @@
 }
 
 static bool
-key_=
is_zero(struct key *key, const struct key_type *kt)
+key_is_zero(const stru=
ct key *key, const struct key_type *kt)
 {
     size_t cipher_length =3D ci=
pher_kt_key_size(kt->cipher);
     for (size_t i =3D 0; i < cipher_length; =
++i)
@@ -1123,7 +1123,7 @@
  * Make sure that cipher key is a valid key for=
 current key_type=2E
  */
 bool
-check_key(struct key *key, const struct ke=
y_type *kt)
+check_key(const struct key *key, const struct key_type *kt)
 {=

     if (cipher_defined(kt->cipher))
     {
@@ -1196,7 +1196,7 @@
 }
 
 vo=
id
-test_crypto(struct crypto_options *co, struct frame *frame)
+test_crypt=
o(struct crypto_options *co, const struct frame *frame)
 {
     int i, j;
 =
    struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/crypto=2Eh b/=
src/openvpn/crypto=2Eh
index ee5b50f=2E=2Ee3c1c6a 100644
--- a/src/openvpn/=
crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -414,7 +414,7 @@
  */
 int write=
_key_file(const int nkeys, const char *filename);
 
-bool check_key(struct =
key *key, const struct key_type *kt);
+bool check_key(const struct key *key=
, const struct key_type *kt);
 
 /**
  * Initialize a key_type structure wi=
th=2E
@@ -614,7 +614,7 @@
 /** Print a cipher list entry */
 void print_cip=
her(const char *cipher);
 
-void test_crypto(struct crypto_options *co, str=
uct frame *f);
+void test_crypto(struct crypto_options *co, const struct fr=
ame *f);
 
 
 /* key direction functions */
diff --git a/src/openvpn/dco=2E=
c b/src/openvpn/dco=2Ec
index 8eae4bf=2E=2E3bf1fb2 100644
--- a/src/openvpn=
/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -573,7 +573,7 @@
 }
 
 static bool
-d=
co_multi_get_localaddr(struct multi_context *m, struct multi_instance *mi,
=
+dco_multi_get_localaddr(const struct multi_context *m, const struct multi_=
instance *mi,
                         struct sockaddr_storage *local)
 {
 =
#if ENABLE_IP_PKTINFO
@@ -585,7 +585,7 @@
         return false;
     }
 
-=
    struct link_socket_actual *actual =3D &c->c2=2Elink_socket_infos[0]->ls=
a->actual;
+    const struct link_socket_actual *actual =3D &c->c2=2Elink_s=
ocket_infos[0]->lsa->actual;
 
     switch (actual->dest=2Eaddr=2Esa=2Esa_f=
amily)
     {
@@ -623,7 +623,7 @@
 }
 
 int
-dco_multi_add_new_peer(struct =
multi_context *m, struct multi_instance *mi)
+dco_multi_add_new_peer(const =
struct multi_context *m, struct multi_instance *mi)
 {
     const struct co=
ntext *c =3D &mi->context;
 
@@ -677,7 +677,7 @@
 }
 
 void
-dco_install_ir=
oute(struct multi_context *m, struct multi_instance *mi, struct mroute_addr=
 *addr)
+dco_install_iroute(struct multi_context *m, struct multi_instance =
*mi, const struct mroute_addr *addr)
 {
 #if defined(TARGET_LINUX) || defin=
ed(TARGET_FREEBSD) || defined(_WIN32)
     if (!dco_enabled(&m->top=2Eoptio=
ns))
@@ -796,7 +796,7 @@
         /* Checked if we added a host route as th=
e assigned client IP address was
          * outside the --ifconfig-ipv6 tu=
n interface config */
 #if !defined(_WIN32)
-        struct in6_addr *dest =
=3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
+        const struct in6=
_addr *dest =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
         if (=
multi_check_push_ifconfig_ipv6_extra_route(mi, dest))
         {
          =
   /* On windows we do not install these routes, so we also do not need to =
delete them */
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index=
 4e5aad5=2E=2E694875c 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dc=
o=2Eh
@@ -204,7 +204,7 @@
  * @param mi        the client instance
  * @ret=
urn          0 on success or a negative error code otherwise
  */
-int dco_=
multi_add_new_peer(struct multi_context *m, struct multi_instance *mi);
+in=
t dco_multi_add_new_peer(const struct multi_context *m, struct multi_instan=
ce *mi);
 
 /**
  * Install an iroute in DCO, which means adding a route to=
 the system routing
@@ -215,7 +215,7 @@
  * @param addr      the route to a=
dd
  */
 void dco_install_iroute(struct multi_context *m, struct multi_inst=
ance *mi,
-                        struct mroute_addr *addr);
+            =
            const struct mroute_addr *addr);
 
 /**
  * Remove all routes a=
dded through the specified client
@@ -253,7 +253,7 @@
  * a 64 bit packet c=
ounter and AEAD tag at the end=2E
  */
 bool
-dco_supports_epoch_data(struc=
t context *c);
+dco_supports_epoch_data(const struct context *c);
 #else  /=
* if defined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ -350,7 +350,=
7 @@
 }
 
 static inline int
-dco_multi_add_new_peer(struct multi_context *=
m, struct multi_instance *mi)
+dco_multi_add_new_peer(const struct multi_co=
ntext *m, struct multi_instance *mi)
 {
     return 0;
 }
@@ -384,7 +384,7 =
@@
 }
 
 static inline bool
-dco_supports_epoch_data(struct context *c)
+dc=
o_supports_epoch_data(const struct context *c)
 {
     return false;
 }
dif=
f --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index d=
933aaf=2E=2E7346903 100644
--- a/src/openvpn/dco_freebsd=2Ec
+++ b/src/open=
vpn/dco_freebsd=2Ec
@@ -930,7 +930,7 @@
 }
 
 bool
-dco_supports_epoch_data=
(struct context *c)
+dco_supports_epoch_data(const struct context *c)
 {
  =
   return false;
 }
diff --git a/src/openvpn/dco_internal=2Eh b/src/openvpn=
/dco_internal=2Eh
index fcf8aca=2E=2E1022e66 100644
--- a/src/openvpn/dco_i=
nternal=2Eh
+++ b/src/openvpn/dco_internal=2Eh
@@ -59,8 +59,9 @@
  * They a=
re implemented by dco_linux=2Ec
  */
 
-int dco_new_peer(dco_context_t *dco=
, unsigned int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,
=
-                 struct sockaddr *remoteaddr, const struct in_addr *vpn_ip=
v4, const struct in6_addr *vpn_ipv6);
+int dco_new_peer(dco_context_t *dco,=
 unsigned int peerid, socket_descriptor_t sd,
+                 struct sock=
addr *localaddr, struct sockaddr *remoteaddr,
+                 const struc=
t in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
 
 int dco_del_peer(=
dco_context_t *dco, unsigned int peerid);
 
diff --git a/src/openvpn/dco_li=
nux=2Ec b/src/openvpn/dco_linux=2Ec
index 56f6259=2E=2E31bbe87 100644
--- a=
/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -114,7 +114,7=
 @@
 }
 
 static struct nl_msg *
-ovpn_dco_nlmsg_create(dco_context_t *dco,=
 uint8_t cmd)
+ovpn_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)=

 {
     struct nl_msg *nl_msg =3D nlmsg_alloc();
     if (!nl_msg)
@@ -804=
,7 +804,7 @@
 
 /* libnl < 3=2E11=2E0 does not implement nla_get_uint() */
=
 static uint64_t
-ovpn_nla_get_uint(struct nlattr *attr)
+ovpn_nla_get_uint=
(const struct nlattr *attr)
 {
     if (nla_len(attr) =3D=3D sizeof(uint32_=
t))
     {
@@ -916,7 +916,7 @@
 }
 
 static bool
-ovpn_iface_check(dco_cont=
ext_t *dco, struct nlattr *attrs[])
+ovpn_iface_check(const dco_context_t *=
dco, struct nlattr *attrs[])
 {
     /* we must know which interface this m=
essage is referring to in order to
      * avoid mixing messages for other =
instances
@@ -1340,7 +1340,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct =
context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     retur=
n false;
 }
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
=
index b3268bc=2E=2E8deb9d8 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/o=
penvpn/dco_win=2Ec
@@ -1100,7 +1100,7 @@
 }
 
 bool
-dco_supports_epoch_dat=
a(struct context *c)
+dco_supports_epoch_data(const struct context *c)
 {
 =
    OVPN_VERSION ver =3D { 0 };
     return dco_get_version(&ver) && ((ver=
=2EMajor =3D=3D 2 && ver=2EMinor >=3D 8) || (ver=2EMajor > 2));
diff --git =
a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec
index 5cdcfcf=2E=2E847f7d0 10=
0644
--- a/src/openvpn/dhcp=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -145,7 +145,7=
 @@
 }
 
 in_addr_t
-dhcp_extract_router_msg(struct buffer *ipbuf)
+dhcp_ex=
tract_router_msg(const struct buffer *ipbuf)
 {
     struct dhcp_full *df =
=3D (struct dhcp_full *)BPTR(ipbuf);
     const int optlen =3D
diff --git a=
/src/openvpn/dhcp=2Eh b/src/openvpn/dhcp=2Eh
index 38ebf8d=2E=2Eed8a0c9 100=
644
--- a/src/openvpn/dhcp=2Eh
+++ b/src/openvpn/dhcp=2Eh
@@ -91,7 +91,7 @@=

 
 #pragma pack()
 
-in_addr_t dhcp_extract_router_msg(struct buffer *ipbu=
f);
+in_addr_t dhcp_extract_router_msg(const struct buffer *ipbuf);
 
 #if =
defined(_WIN32) || defined(DHCP_UNIT_TEST)
 #include "tun=2Eh"
diff --git a=
/src/openvpn/event=2Eh b/src/openvpn/event=2Eh
index b784dfe=2E=2E0940a1d 1=
00644
--- a/src/openvpn/event=2Eh
+++ b/src/openvpn/event=2Eh
@@ -204,7 +20=
4,7 @@
 #else /* ifdef _WIN32 */
 
 static inline void
-wait_signal(struct =
event_set *es, void *arg)
+wait_signal(const struct event_set *es, const vo=
id *arg)
 {
 }
 
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=
=2Ec
index 6581998=2E=2E4ddac11 100644
--- a/src/openvpn/forward=2Ec
+++ b/=
src/openvpn/forward=2Ec
@@ -231,7 +231,7 @@
 }
 
 static void
-parse_incomi=
ng_control_channel_command(struct context *c, struct buffer *buf)
+parse_in=
coming_control_channel_command(struct context *c, const struct buffer *buf)=

 {
     if (buf_string_match_head_str(buf, "AUTH_FAILED"))
     {
@@ -501,=
7 +501,7 @@
 }
 
 int
-get_server_poll_remaining_time(struct event_timeout =
*server_poll_timeout)
+get_server_poll_remaining_time(const struct event_ti=
meout *server_poll_timeout)
 {
     update_time();
     int remaining =3D e=
vent_timeout_remaining(server_poll_timeout);
@@ -598,7 +598,7 @@
  * Buffer=
 reallocation, for use with null encryption=2E
  */
 static inline void
-bu=
ffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, struct buf=
fer *src_stub,
+buffer_turnover(const uint8_t *orig_buf, struct buffer *des=
t_stub, const struct buffer *src_stub,
                 struct buffer *stor=
age)
 {
     if (orig_buf =3D=3D src_stub->data && src_stub->data !=3D stor=
age->data)
@@ -885,7 +885,7 @@
  */
 
 static inline void
-socks_postproces=
s_incoming_link(struct context *c, struct link_socket *sock)
+socks_postpro=
cess_incoming_link(struct context *c, const struct link_socket *sock)
 {
  =
   if (sock->socks_proxy && sock->info=2Eproto =3D=3D PROTO_UDP)
     {
@@ =
-982,7 +982,7 @@
 }
 
 bool
-process_incoming_link_part1(struct context *c,=
 struct link_socket_info *lsi, bool floated)
+process_incoming_link_part1(s=
truct context *c, const struct link_socket_info *lsi, bool floated)
 {
    =
 struct gc_arena gc =3D gc_new();
     bool decrypt_status =3D false;
@@ -1=
532,7 +1532,7 @@
  * @param client    Determines whether to the send packet=
 back via tun or link
  */
 void
-ipv6_send_icmp_unreachable(struct context=
 *c, struct buffer *buf, bool client)
+ipv6_send_icmp_unreachable(struct co=
ntext *c, const struct buffer *buf, bool client)
 {
 #define MAX_ICMPV6LEN =
1280
     struct openvpn_icmp6hdr icmp6out;
diff --git a/src/openvpn/forwar=
d=2Eh b/src/openvpn/forward=2Eh
index 324c0b4=2E=2Eee7d2e2 100644
--- a/src=
/openvpn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -127,7 +127,7 @@
  */=

 void encrypt_sign(struct context *c, bool comp_frag);
 
-int get_server_p=
oll_remaining_time(struct event_timeout *server_poll_timeout);
+int get_ser=
ver_poll_remaining_time(const struct event_timeout *server_poll_timeout);
 =

 /**********************************************************************/
=
 /**
@@ -178,7 +178,7 @@
  *
  * @return true if packet is authenticated, f=
alse otherwise=2E
  */
-bool process_incoming_link_part1(struct context *c,=
 struct link_socket_info *lsi, bool floated);
+bool process_incoming_link_p=
art1(struct context *c, const struct link_socket_info *lsi, bool floated);
=
 
 /**
  * Continues processing a packet read from the external network int=
erface=2E
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 11=
09a13=2E=2Eb020db2 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=
=2Ec
@@ -803,7 +803,7 @@
 }
 
 static void
-init_port_share(struct context =
*c)
+init_port_share(const struct context *c)
 {
     if (!port_share && (c=
->options=2Eport_share_host && c->options=2Eport_share_port))
     {
@@ -12=
45,7 +1245,7 @@
  * prepending to msg() output=2E
  */
 const char *
-forma=
t_common_name(struct context *c, struct gc_arena *gc)
+format_common_name(c=
onst struct context *c, struct gc_arena *gc)
 {
     struct buffer out =3D =
alloc_buf_gc(256, gc);
     if (c->c2=2Etls_multi)
@@ -1731,7 +1731,7 @@
 
=
 
 static bool
-can_preserve_tun(struct tuntap *tt)
+can_preserve_tun(const=
 struct tuntap *tt)
 {
     if (tt && tt->backend_driver =3D=3D DRIVER_AFUN=
IX)
     {
@@ -1753,7 +1753,7 @@
  * @param c pointer to the connection con=
text
  */
 static void
-add_wfp_block(struct context *c)
+add_wfp_block(con=
st struct context *c)
 {
 #if defined(_WIN32)
     /* Fortify 'redirect-gat=
eway block-local' with firewall rules? */
@@ -1779,7 +1779,7 @@
  * @param =
adapter_index the VPN adapter index
  */
 static void
-del_wfp_block(struct=
 context *c, unsigned long adapter_index)
+del_wfp_block(const struct conte=
xt *c, unsigned long adapter_index)
 {
 #if defined(_WIN32)
     if (c->opt=
ions=2Eblock_outside_dns || block_local_needed(c->c1=2Eroute_list))
diff --=
git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
index ce8f74e=2E=2Ec48615=
8 100644
--- a/src/openvpn/init=2Eh
+++ b/src/openvpn/init=2Eh
@@ -91,7 +91=
,7 @@
 
 uint64_t pull_permission_mask(const struct context *c);
 
-const c=
har *format_common_name(struct context *c, struct gc_arena *gc);
+const cha=
r *format_common_name(const struct context *c, struct gc_arena *gc);
 
 voi=
d reset_coarse_timers(struct context *c);
 
diff --git a/src/openvpn/interv=
al=2Eh b/src/openvpn/interval=2Eh
index 59051bd=2E=2E0cfe202 100644
--- a/s=
rc/openvpn/interval=2Eh
+++ b/src/openvpn/interval=2Eh
@@ -89,7 +89,7 @@
 }=

 
 static inline void
-interval_schedule_wakeup(struct interval *top, inte=
rval_t *wakeup)
+interval_schedule_wakeup(const struct interval *top, inter=
val_t *wakeup)
 {
     const time_t local_now =3D now;
     interval_earlie=
st_wakeup(wakeup, top->last_test_true + top->refresh, local_now);
@@ -214,7=
 +214,7 @@
  * This function does not check if the timeout is actually vali=
d=2E
  */
 static inline interval_t
-event_timeout_remaining(struct event_t=
imeout *et)
+event_timeout_remaining(const struct event_timeout *et)
 {
   =
  return (interval_t)((et->last + et->n) - now);
 }
diff --git a/src/openvp=
n/list=2Ec b/src/openvpn/list=2Ec
index e51dcd0=2E=2Edcd59d7 100644
--- a/s=
rc/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -164,7 +164,7 @@
 }
 
 vo=
id
-hash_remove_by_value(struct hash *hash, void *value)
+hash_remove_by_va=
lue(struct hash *hash, const void *value)
 {
     struct hash_iterator hi;
=
     const struct hash_element *he;
diff --git a/src/openvpn/list=2Eh b/src=
/openvpn/list=2Eh
index 55bc3c8=2E=2E23267d0 100644
--- a/src/openvpn/list=
=2Eh
+++ b/src/openvpn/list=2Eh
@@ -78,7 +78,7 @@
 
 bool hash_remove_fast(=
struct hash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv=
);
 
-void hash_remove_by_value(struct hash *hash, void *value);
+void hash=
_remove_by_value(struct hash *hash, const void *value);
 
 struct hash_iter=
ator
 {
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index =
604bbcd=2E=2E17abfd8 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/=
manage=2Ec
@@ -330,7 +330,7 @@
 }
 
 static void
-man_delete_unix_socket(st=
ruct management *man)
+man_delete_unix_socket(const struct management *man)=

 {
 #if UNIX_SOCK_SUPPORT
     if ((man->settings=2Eflags & (MF_UNIX_SOCK =
| MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
@@ -675,7 +675,7 @@
  * for t=
he log and echo commands=2E
  */
 static void
-man_history(struct managemen=
t *man, const char *parm, const char *type, struct log_history *log,
+man_h=
istory(struct management *man, const char *parm, const char *type, const st=
ruct log_history *log,
             bool *realtime, const unsigned int lep_=
flags)
 {
     struct gc_arena gc =3D gc_new();
@@ -843,7 +843,7 @@
 }
 
 s=
tatic void
-man_forget_passwords(struct management *man)
+man_forget_passwo=
rds(const struct management *man)
 {
     ssl_purge_auth(false);
     (void=
)ssl_clean_auth_token();
@@ -851,7 +851,7 @@
 }
 
 static void
-man_net(str=
uct management *man)
+man_net(const struct management *man)
 {
     if (man=
->persist=2Ecallback=2Eshow_net)
     {
@@ -887,7 +887,7 @@
 #ifdef ENABLE_=
PKCS11
 
 static void
-man_pkcs11_id_count(struct management *man)
+man_pkc=
s11_id_count(const struct management *man)
 {
     msg(M_CLIENT, ">PKCS11ID=
-COUNT:%d", pkcs11_management_id_count());
 }
@@ -1350,7 +1350,7 @@
  * @re=
turn          Return whether p has n (or at least n) parameters
  */
 stati=
c bool
-man_need(struct management *man, const char **p, const int n, unsig=
ned int flags)
+man_need(const struct management *man, const char **p, cons=
t int n, unsigned int flags)
 {
     int i;
     ASSERT(p[0]);
@@ -2365,7 +=
2365,7 @@
  * the route/ifconfig/open tun command=2E   See doc/android=2Etx=
t for details=2E
  */
 bool
-management_android_control(struct management *=
man, const char *command, const char *msg)
+management_android_control(cons=
t struct management *man, const char *command, const char *msg)
 {
     if =
(!man)
     {
@@ -3013,7 +3013,7 @@
 }
 
 void
-management_up_down(struct m=
anagement *man, const char *updown, const struct env_set *es)
+management_u=
p_down(const struct management *man, const char *updown, const struct env_s=
et *es)
 {
     if (man->settings=2Eflags & MF_UP_DOWN)
     {
@@ -3023,13 =
+3023,13 @@
 }
 
 void
-management_notify(struct management *man, const cha=
r *severity, const char *type, const char *text)
+management_notify(const s=
truct management *man, const char *severity, const char *type, const char *=
text)
 {
     msg(M_CLIENT, ">NOTIFY:%s,%s,%s", severity, type, text);
 }
 =

 void
-management_notify_generic(struct management *man, const char *str)
=
+management_notify_generic(const struct management *man, const char *str)
 =
{
     msg(M_CLIENT, "%s", str);
 }
@@ -3115,7 +3115,8 @@
 }
 
 void
-manag=
ement_notify_client_close(struct management *management, struct man_def_aut=
h_context *mdac,
+management_notify_client_close(const struct management *m=
anagement,
+                               struct man_def_auth_context *mda=
c,
                                const struct env_set *es)
 {
     if ((m=
dac->flags & DAF_INITIAL_AUTH) && !(mdac->flags & DAF_CONNECTION_CLOSED))
@=
@ -3206,7 +3207,7 @@
 }
 
 void
-management_auth_failure(struct management =
*man, const char *type, const char *reason)
+management_auth_failure(const =
struct management *man, const char *type, const char *reason)
 {
     if (r=
eason)
     {
@@ -3219,7 +3220,7 @@
 }
 
 void
-management_auth_token(struc=
t management *man, const char *token)
+management_auth_token(const struct m=
anagement *man, const char *token)
 {
     msg(M_CLIENT, ">PASSWORD:Auth-To=
ken:%s", token);
 }
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manag=
e=2Eh
index 27d3b60=2E=2E0d011df 100644
--- a/src/openvpn/manage=2Eh
+++ b/=
src/openvpn/manage=2Eh
@@ -368,7 +368,7 @@
                                =
 const unsigned int flags, const char *static_challenge);
 
 #ifdef TARGET_=
ANDROID
-bool management_android_control(struct management *man, const char=
 *command, const char *msg);
+bool management_android_control(const struct =
management *man, const char *command, const char *msg);
 
 #define ANDROID_=
KEEP_OLD_TUN      1
 #define ANDROID_OPEN_BEFORE_CLOSE 2
@@ -382,12 +382,12=
 @@
 
 void management_event_loop_n_seconds(struct management *man, int sec=
);
 
-void management_up_down(struct management *man, const char *updown, c=
onst struct env_set *es);
+void management_up_down(const struct management =
*man, const char *updown, const struct env_set *es);
 
-void management_not=
ify(struct management *man, const char *severity, const char *type,
+void m=
anagement_notify(const struct management *man, const char *severity, const =
char *type,
                        const char *text);
 
-void management_n=
otify_generic(struct management *man, const char *str);
+void management_no=
tify_generic(const struct management *man, const char *str);
 
 void manage=
ment_notify_client_needing_auth(struct management *management,
            =
                                const unsigned int auth_id,
@@ -397,7 +397,=
7 @@
 void management_connection_established(struct management *management,=

                                        struct man_def_auth_context *mdac,=
 const struct env_set *es);
 
-void management_notify_client_close(struct m=
anagement *management,
+void management_notify_client_close(const struct ma=
nagement *management,
                                     struct man_def_a=
uth_context *mdac, const struct env_set *es);
 
 void management_learn_addr=
(struct management *management, struct man_def_auth_context *mdac,
@@ -482,=
12 +482,12 @@
  * OpenVPN calls here to indicate a password failure
  */
 
=
-void management_auth_failure(struct management *man, const char *type, con=
st char *reason);
+void management_auth_failure(const struct management *ma=
n, const char *type, const char *reason);
 
 /*
  * Echo an authentication =
token to management interface
  */
-void management_auth_token(struct manag=
ement *man, const char *token);
+void management_auth_token(const struct ma=
nagement *man, const char *token);
 
 /*
  * These functions drive the byte=
count in/out counters=2E
diff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mb=
uf=2Ec
index 7b790ed=2E=2E9a37e30 100644
--- a/src/openvpn/mbuf=2Ec
+++ b/s=
rc/openvpn/mbuf=2Ec
@@ -149,7 +149,7 @@
 }
 
 void
-mbuf_dereference_instan=
ce(struct mbuf_set *ms, struct multi_instance *mi)
+mbuf_dereference_instan=
ce(struct mbuf_set *ms, const struct multi_instance *mi)
 {
     if (ms)
  =
   {
diff --git a/src/openvpn/mbuf=2Eh b/src/openvpn/mbuf=2Eh
index cfe698c=
=2E=2Ee368054 100644
--- a/src/openvpn/mbuf=2Eh
+++ b/src/openvpn/mbuf=2Eh
=
@@ -75,7 +75,7 @@
 
 bool mbuf_extract_item(struct mbuf_set *ms, struct mbu=
f_item *item);
 
-void mbuf_dereference_instance(struct mbuf_set *ms, struc=
t multi_instance *mi);
+void mbuf_dereference_instance(struct mbuf_set *ms,=
 const struct multi_instance *mi);
 
 static inline bool
 mbuf_defined(cons=
t struct mbuf_set *ms)
diff --git a/src/openvpn/mss=2Ec b/src/openvpn/mss=
=2Ec
index 36bbb43=2E=2Ea7242a8 100644
--- a/src/openvpn/mss=2Ec
+++ b/src/=
openvpn/mss=2Ec
@@ -43,7 +43,7 @@
  *              if yes, hand to mss_fixu=
p_dowork()
  */
 void
-mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss)
=
+mss_fixup_ipv4(const struct buffer *buf, uint16_t maxmss)
 {
     const st=
ruct openvpn_iphdr *pip;
     int hlen;
@@ -80,7 +80,7 @@
  *              =
(IPv6 header structure is sufficiently different from IPv4=2E=2E=2E)
  */
 =
void
-mss_fixup_ipv6(struct buffer *buf, uint16_t maxmss)
+mss_fixup_ipv6(c=
onst struct buffer *buf, uint16_t maxmss)
 {
     const struct openvpn_ipv6=
hdr *pip6;
     struct buffer newbuf;
@@ -136,7 +136,7 @@
  */
 
 void
-mss=
_fixup_dowork(struct buffer *buf, uint16_t maxmss)
+mss_fixup_dowork(const =
struct buffer *buf, uint16_t maxmss)
 {
     int olen, optlen;
     uint8_t=
 *opt;
@@ -239,8 +239,8 @@
 }
 
 static void
-frame_calculate_fragment(stru=
ct frame *frame, struct key_type *kt, const struct options *options,
-     =
                    struct link_socket_info *lsi)
+frame_calculate_fragment=
(struct frame *frame, const struct key_type *kt, const struct options *opti=
ons,
+                         const struct link_socket_info *lsi)
 {
 #if =
defined(ENABLE_FRAGMENT)
     size_t overhead;
@@ -269,8 +269,8 @@
 }
 
 st=
atic void
-frame_calculate_mssfix(struct frame *frame, struct key_type *kt,=
 const struct options *options,
-                       struct link_socket_=
info *lsi)
+frame_calculate_mssfix(struct frame *frame, const struct key_ty=
pe *kt, const struct options *options,
+                       const struct=
 link_socket_info *lsi)
 {
     if (options->ce=2Emssfix_fixed)
     {
@@ -=
314,8 +314,8 @@
 }
 
 void
-frame_calculate_dynamic(struct frame *frame, st=
ruct key_type *kt, const struct options *options,
-                        =
struct link_socket_info *lsi)
+frame_calculate_dynamic(struct frame *frame,=
 const struct key_type *kt, const struct options *options,
+               =
         const struct link_socket_info *lsi)
 {
     if (options->ce=2Efrag=
ment > 0)
     {
diff --git a/src/openvpn/mss=2Eh b/src/openvpn/mss=2Eh
ind=
ex 1d092bb=2E=2E6b832a2 100644
--- a/src/openvpn/mss=2Eh
+++ b/src/openvpn/=
mss=2Eh
@@ -29,15 +29,15 @@
 #include "socket=2Eh"
 #include "ssl_common=2E=
h"
 
-void mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss);
+void mss_f=
ixup_ipv4(const struct buffer *buf, uint16_t maxmss);
 
-void mss_fixup_ipv=
6(struct buffer *buf, uint16_t maxmss);
+void mss_fixup_ipv6(const struct b=
uffer *buf, uint16_t maxmss);
 
-void mss_fixup_dowork(struct buffer *buf, =
uint16_t maxmss);
+void mss_fixup_dowork(const struct buffer *buf, uint16_t=
 maxmss);
 
 /** Set the --mssfix option=2E */
-void frame_calculate_dynami=
c(struct frame *frame, struct key_type *kt,
-                             c=
onst struct options *options, struct link_socket_info *lsi);
+void frame_ca=
lculate_dynamic(struct frame *frame, const struct key_type *kt,
+          =
                   const struct options *options, const struct link_socket_=
info *lsi);
 
 /**
  * Checks and adjusts the fragment and mssfix value acc=
ording to the
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
inde=
x 5d88f8a=2E=2E922db3f 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/=
mtcp=2Ec
@@ -91,7 +91,7 @@
 }
 
 bool
-multi_tcp_instance_specific_init(str=
uct multi_context *m, struct multi_instance *mi)
+multi_tcp_instance_specif=
ic_init(const struct multi_context *m, struct multi_instance *mi)
 {
     /=
* buffer for queued TCP socket output packets */
     mi->tcp_link_out_defe=
rred =3D mbuf_init(m->top=2Eoptions=2En_bcast_buf);
diff --git a/src/openvp=
n/mtcp=2Eh b/src/openvpn/mtcp=2Eh
index 9b7d1d2=2E=2Ebb117fa 100644
--- a/s=
rc/openvpn/mtcp=2Eh
+++ b/src/openvpn/mtcp=2Eh
@@ -35,7 +35,7 @@
 
 void mu=
lti_tcp_dereference_instance(struct multi_io *multi_io, struct multi_instan=
ce *mi);
 
-bool multi_tcp_instance_specific_init(struct multi_context *m, =
struct multi_instance *mi);
+bool multi_tcp_instance_specific_init(const st=
ruct multi_context *m, struct multi_instance *mi);
 
 void multi_tcp_instan=
ce_specific_free(struct multi_instance *mi);
 
diff --git a/src/openvpn/mud=
p=2Ec b/src/openvpn/mudp=2Ec
index de3d467=2E=2E5e37682 100644
--- a/src/op=
envpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -53,8 +53,9 @@
  * @param sock=
    the socket to send the reply on
  */
 static void
-send_standalone_repl=
y(struct multi_context *m, struct buffer *buf, const char *prefix,
-       =
               const char *detail, struct link_socket *sock)
+send_standalo=
ne_reply(struct multi_context *m, const struct buffer *buf,
+              =
        const char *prefix, const char *detail,
+                      stru=
ct link_socket *sock)
 {
     struct context *c =3D &m->top;
 
@@ -74,7 +75=
,7 @@
 
 static void
 send_hmac_reset_packet(struct multi_context *m, struc=
t tls_pre_decrypt_state *state,
-                       struct tls_auth_sta=
ndalone *tas, struct session_id *sid,
+                       const struct =
tls_auth_standalone *tas, const struct session_id *sid,
                   =
     bool request_resend_wkc, struct link_socket *sock)
 {
     reset_packe=
t_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
@@ -97,11 +98,11 =
@@
 
     enum first_packet_verdict verdict;
 
-    struct tls_auth_standal=
one *tas =3D m->top=2Ec2=2Etls_auth_standalone;
+    const struct tls_auth_=
standalone *tas =3D m->top=2Ec2=2Etls_auth_standalone;
 
     verdict =3D t=
ls_pre_decrypt_lite(tas, state, &m->top=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 =

-    uint8_t *hmac_key =3D m->top=2Ec2=2Esession_id_key;
+    const uint8_=
t *hmac_key =3D m->top=2Ec2=2Esession_id_key;
     const struct openvpn_soc=
kaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
     int handwindow =3D m->top=
=2Eoptions=2Ehandshake_window;
 
@@ -218,7 +219,7 @@
 static struct multi_i=
nstance *
 handle_connection_attempt(struct multi_context *m,
             =
              struct link_socket *sock,
-                          struct m=
route_addr *real)
+                          const struct mroute_addr *real=
)
 {
     struct hash *hash =3D m->hash;
     struct tls_pre_decrypt_state =
state =3D { 0 };
@@ -286,7 +287,7 @@
  * @return      instance matching the=
 address, NULL otherwise
  */
 static struct multi_instance *
-multi_get_in=
stance_udp_real(struct multi_context *m, struct mroute_addr *real)
+multi_g=
et_instance_udp_real(struct multi_context *m, const struct mroute_addr *rea=
l)
 {
     struct hash *hash =3D m->hash;
     struct hash_element *he;
@@ =
-320,7 +321,9 @@
  * maintaining real address hash table atomicity=2E
  */
=
 struct multi_instance *
-multi_get_instance_udp_data(struct multi_context =
*m, bool *floated, struct mroute_addr *real, struct link_socket *sock)
+mul=
ti_get_instance_udp_data(struct multi_context *m, bool *floated,
+         =
                   const struct mroute_addr *real,
+                       =
     const struct link_socket *sock)
 {
     struct multi_instance *mi =3D =
NULL;
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 46=
ff1ba=2E=2E0750468 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/mul=
ti=2Ec
@@ -57,7 +57,7 @@
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
 static const cha=
r *
-id(struct multi_instance *mi)
+id(const struct multi_instance *mi)
 {
=
     if (mi)
     {
@@ -1314,7 +1314,7 @@
  * same common name=2E
  */
 sta=
tic void
-multi_delete_dup(struct multi_context *m, struct multi_instance *=
new_mi)
+multi_delete_dup(struct multi_context *m, const struct multi_insta=
nce *new_mi)
 {
     if (new_mi)
     {
@@ -2259,7 +2259,7 @@
 }
 
 static =
bool
-multi_client_setup_dco_initial(struct multi_context *m, struct multi_=
instance *mi,
+multi_client_setup_dco_initial(const struct multi_context *m=
, struct multi_instance *mi,
                                struct gc_aren=
a *gc)
 {
     if (!dco_enabled(&mi->context=2Eoptions))
@@ -3078,7 +3078,8=
 @@
  * positive=2E
  */
 static bool
-multi_check_dest_addr_allowed(struct=
 multi_context *m, struct multi_instance *mi, struct mroute_addr *real)
+mu=
lti_check_dest_addr_allowed(struct multi_context *m, struct multi_instance =
*mi,
+                              const struct mroute_addr *real)
 {
    =
 struct hash *hash =3D m->hash;
     const uint64_t hv =3D hash_value(hash,=
 real);
@@ -3237,7 +3238,7 @@
 
 #if defined(ENABLE_DCO)
 static void
-proc=
ess_incoming_del_peer(struct multi_context *m, struct multi_instance *mi, d=
co_context_t *dco)
+process_incoming_del_peer(struct multi_context *m, stru=
ct multi_instance *mi, const dco_context_t *dco)
 {
     const char *reason=
 =3D "ovpn-dco: unknown reason";
     switch (dco->dco_del_peer_reason)
@@ =
-4291,7 +4292,7 @@
 
 /* Searches for the address and deletes it if it is o=
wned by the multi_instance */
 static void
-multi_unlearn_addr(struct multi=
_context *m, struct multi_instance *mi, const struct mroute_addr *addr)
+mu=
lti_unlearn_addr(struct multi_context *m, const struct multi_instance *mi, =
const struct mroute_addr *addr)
 {
     struct hash_element *he;
     const=
 uint64_t hv =3D hash_value(m->vhash, addr);
@@ -4326,7 +4327,7 @@
  * @par=
am a     The new IPv4 address in network byte order
  */
 static void
-mult=
i_unlearn_in_addr_t(struct multi_context *m, struct multi_instance *mi, in_=
addr_t a)
+multi_unlearn_in_addr_t(struct multi_context *m, const struct mu=
lti_instance *mi, in_addr_t a)
 {
     struct mroute_addr addr;
     CLEAR(=
addr);
@@ -4344,7 +4345,7 @@
  * @param a6    The new IPv6 address
  */
 st=
atic void
-multi_unlearn_in6_addr(struct multi_context *m, struct multi_ins=
tance *mi, struct in6_addr a6)
+multi_unlearn_in6_addr(struct multi_context=
 *m, const struct multi_instance *mi, struct in6_addr a6)
 {
     struct mr=
oute_addr addr;
     CLEAR(addr);
@@ -4460,7 +4461,7 @@
 
 bool
 multi_chec=
k_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
-              =
                             struct in6_addr *dest)
+                      =
                     const struct in6_addr *dest)
 {
     const struct opti=
ons *o =3D &mi->context=2Eoptions;
 
diff --git a/src/openvpn/multi=2Eh b/s=
rc/openvpn/multi=2Eh
index 6cb86c7=2E=2E5b8d56a 100644
--- a/src/openvpn/mu=
lti=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -517,7 +517,7 @@
  */
 
 static inli=
ne void
-set_prefix(struct multi_instance *mi)
+set_prefix(const struct mul=
ti_instance *mi)
 {
 #ifdef MULTI_DEBUG_EVENT_LOOP
     if (mi->msg_prefix[=
0])
@@ -691,7 +691,7 @@
  */
 bool
 multi_check_push_ifconfig_ipv6_extra_ro=
ute(struct multi_instance *mi,
-                                           =
struct in6_addr *dest);
+                                           const s=
truct in6_addr *dest);
 
 /*
  * Check for signals=2E
diff --git a/src/open=
vpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 3604684=2E=2E52eb8c7 1006=
44
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -159,7 =
+159,7 @@
  * a point-to-multipoint tunnel=2E
  */
 static unsigned int
-p2=
mp_iow_flags(const struct multi_context *m, struct link_socket *sock)
+p2mp=
_iow_flags(const struct multi_context *m, const struct link_socket *sock)
 =
{
     unsigned int flags =3D IOW_WAIT_SIGNAL;
 
diff --git a/src/openvpn/n=
etworking=2Eh b/src/openvpn/networking=2Eh
index bce0c19=2E=2E25233c8 10064=
4
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@@ -44,=
7 +44,7 @@
  */
 #if !defined(ENABLE_IPROUTE)
 static inline int
-net_ctx_i=
nit(struct context *c, openvpn_net_ctx_t *ctx)
+net_ctx_init(const struct c=
ontext *c, openvpn_net_ctx_t *ctx)
 {
     (void)c;
     (void)ctx;
@@ -75,=
7 +75,7 @@
  *
  * @return          0 on success, a negative error code oth=
erwise
  */
-int net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx);
+=
int net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx);
 
 /**
 =
 * Release resources allocated by the internal garbage collector
@@ -102,7 =
+102,7 @@
  * @return          0 on success, negative error code on error
 =
 */
 int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *i=
face, const char *type,
-                  void *arg);
+                  c=
onst void *arg);
 
 /**
  * Retrieve the interface type
diff --git a/src/op=
envpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec
index a=
1f3525=2E=2Ef091fb3 100644
--- a/src/openvpn/networking_iproute2=2Ec
+++ b/=
src/openvpn/networking_iproute2=2Ec
@@ -36,7 +36,7 @@
 #include <netinet/in=
=2Eh>
 
 int
-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+net_=
ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)
 {
     ctx->es =
=3D NULL;
     if (c)
@@ -61,7 +61,7 @@
 }
 
 int
-net_iface_new(openvpn_ne=
t_ctx_t *ctx, const char *iface, const char *type, void *arg)
+net_iface_ne=
w(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void *=
arg)
 {
     struct argv argv =3D argv_new();
 
diff --git a/src/openvpn/ne=
tworking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index a396255=2E=2E13=
e0f0b 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/netwo=
rking_sitnl=2Ec
@@ -1007,7 +1007,7 @@
 }
 
 static int
-sitnl_addr_del(sa_f=
amily_t af_family, const char *iface, inet_address_t *addr, int prefixlen)
=
+sitnl_addr_del(sa_family_t af_family, const char *iface, const inet_addres=
s_t *addr, int prefixlen)
 {
     int ifindex;
 
@@ -1250,8 +1250,8 @@
 }
 =

 static int
-sitnl_route_del(const char *iface, sa_family_t af_family, ine=
t_address_t *dst, int prefixlen,
-                inet_address_t *gw, uint3=
2_t table, int metric)
+sitnl_route_del(const char *iface, sa_family_t af_f=
amily, const inet_address_t *dst, int prefixlen,
+                const ine=
t_address_t *gw, uint32_t table, int metric)
 {
     int ifindex =3D 0;
 
@=
@ -1328,7 +1328,7 @@
 
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const =
char *iface, const char *type, void *arg)
+net_iface_new(openvpn_net_ctx_t =
*ctx, const char *iface, const char *type, const void *arg)
 {
     struct =
sitnl_link_req req =3D {};
     int ret =3D -1;
diff --git a/src/openvpn/oc=
c=2Eh b/src/openvpn/occ=2Eh
index bda4f18=2E=2E49def4d 100644
--- a/src/ope=
nvpn/occ=2Eh
+++ b/src/openvpn/occ=2Eh
@@ -156,7 +156,7 @@
  * via control =
channel=2E
  * @return control channel exit message should be used */
 stat=
ic inline bool
-cc_exit_notify_enabled(struct context *c)
+cc_exit_notify_e=
nabled(const struct context *c)
 {
     /* Check if we have TLS active at a=
ll */
     if (!c->c2=2Etls_multi)
diff --git a/src/openvpn/openssl_compat=
=2Eh b/src/openvpn/openssl_compat=2Eh
index 098bdd5=2E=2E1a934db 100644
---=
 a/src/openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -=
127,7 +127,7 @@
 /* Mimics the functions but only when the default context =
without
  * options is chosen */
 static inline const EVP_CIPHER *
-EVP_CIP=
HER_fetch(void *ctx, const char *algorithm, const char *properties)
+EVP_CI=
PHER_fetch(const void *ctx, const char *algorithm, const char *properties)
=
 {
     ASSERT(!ctx);
     ASSERT(!properties);
@@ -135,7 +135,7 @@
 }
 
 s=
tatic inline const EVP_MD *
-EVP_MD_fetch(void *ctx, const char *algorithm,=
 const char *properties)
+EVP_MD_fetch(const void *ctx, const char *algorit=
hm, const char *properties)
 {
     ASSERT(!ctx);
     ASSERT(!properties);=

diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 58dbd=
28=2E=2E16e2954 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/opti=
ons=2Ec
@@ -2423,7 +2423,7 @@
 }
 
 static void
-options_postprocess_mutate=
_le(struct connection_entry *ce, struct local_entry *le, int mode)
+options=
_postprocess_mutate_le(const struct connection_entry *ce, struct local_entr=
y *le, int mode)
 {
     /* use the global port if none is specified */
   =
  if (!le->port)
@@ -3576,7 +3576,7 @@
 static bool
 verify_permission(cons=
t char *name, const char *file, int line, const uint64_t type,
            =
       const uint64_t allowed, uint64_t *found, const msglvl_t msglevel,
- =
                 struct options *options, bool is_inline)
+                =
  const struct options *options, bool is_inline)
 {
     if (!(type & allow=
ed))
     {
@@ -4143,7 +4143,7 @@
 }
 
 static void
-show_compression_warni=
ng(struct compress_options *info)
+show_compression_warning(const struct co=
mpress_options *info)
 {
     if (comp_non_stub_enabled(info))
     {
diff =
--git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_parse=2Ec
index=
 88ab4d2=2E=2E0e94522 100644
--- a/src/openvpn/options_parse=2Ec
+++ b/src/=
openvpn/options_parse=2Ec
@@ -258,7 +258,7 @@
 }
 
 static char *
-read_inl=
ine_file(struct in_src *is, const char *close_tag, int *num_lines, struct g=
c_arena *gc)
+read_inline_file(const struct in_src *is, const char *close_t=
ag, int *num_lines, struct gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE=
];
     struct buffer buf =3D alloc_buf(8 * OPTION_LINE_SIZE);
@@ -302,7 +3=
02,7 @@
 }
 
 static int
-check_inline_file(struct in_src *is, char *p[], s=
truct gc_arena *gc)
+check_inline_file(const struct in_src *is, char *p[], =
struct gc_arena *gc)
 {
     int num_inline_lines =3D 0;
 
diff --git a/src=
/openvpn/otime=2Ec b/src/openvpn/otime=2Ec
index 1608458=2E=2E5d3633c 10064=
4
--- a/src/openvpn/otime=2Ec
+++ b/src/openvpn/otime=2Ec
@@ -66,7 +66,7 @@=

 }
 
 void
-update_now_usec(struct timeval *tv)
+update_now_usec(const str=
uct timeval *tv)
 {
     const time_t last =3D now;
     update_now(tv->tv_=
sec);
diff --git a/src/openvpn/otime=2Eh b/src/openvpn/otime=2Eh
index d14f=
01e=2E=2E74d21ff 100644
--- a/src/openvpn/otime=2Eh
+++ b/src/openvpn/otime=
=2Eh
@@ -65,7 +65,7 @@
 void update_now(const time_t system_time);
 
 exter=
n time_t now_usec;
-void update_now_usec(struct timeval *tv);
+void update_=
now_usec(const struct timeval *tv);
 
 static inline int
 openvpn_gettimeof=
day(struct timeval *tv, void *tz)
diff --git a/src/openvpn/proto=2Eh b/src/=
openvpn/proto=2Eh
index 3570582=2E=2E33bf4ea 100644
--- a/src/openvpn/proto=
=2Eh
+++ b/src/openvpn/proto=2Eh
@@ -248,7 +248,7 @@
  * and offset of IP h=
eader (via parameter)=2E
  */
 static inline int
-get_tun_ip_ver(int tunnel=
_type, struct buffer *buf, int *ip_hdr_offset)
+get_tun_ip_ver(int tunnel_t=
ype, const struct buffer *buf, int *ip_hdr_offset)
 {
     int ip_ver =3D -=
1;
 
diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index e0700=
aa=2E=2E5e13d1f 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=
=2Ec
@@ -527,8 +527,9 @@
 }
 
 static bool
-add_proxy_headers(struct http_p=
roxy_info *p, socket_descriptor_t sd, /* already open to proxy */
-        =
          const char *host                                   /* openvpn ser=
ver remote */
+add_proxy_headers(const struct http_proxy_info *p,
+        =
          socket_descriptor_t sd, /* already open to proxy */
+            =
      const char *host        /* openvpn server remote */
 )
 {
     char b=
uf[512];
@@ -597,8 +598,8 @@
                               socket_descript=
or_t sd, /* already open to proxy */
                               const c=
har *host,       /* openvpn server remote */
                              =
 const char *port,       /* openvpn server port */
-                       =
       struct event_timeout *server_poll_timeout, struct buffer *lookahead,=

-                              struct signal_info *sig_info)
+            =
                  const struct event_timeout *server_poll_timeout,
+       =
                       struct buffer *lookahead, struct signal_info *sig_in=
fo)
 {
     struct gc_arena gc =3D gc_new();
     char buf[512];
diff --git=
 a/src/openvpn/proxy=2Eh b/src/openvpn/proxy=2Eh
index e662e7d=2E=2Ea2f4e47=
 100644
--- a/src/openvpn/proxy=2Eh
+++ b/src/openvpn/proxy=2Eh
@@ -89,7 +8=
9,7 @@
                                    socket_descriptor_t sd, /* alrea=
dy open to proxy */
                                    const char *host,  =
     /* openvpn server remote */
                                    const =
char *port,       /* openvpn server port */
-                              =
     struct event_timeout *server_poll_timeout,
+                          =
         const struct event_timeout *server_poll_timeout,
                 =
                   struct buffer *lookahead, struct signal_info *sig_info);=

 
 uint8_t *make_base64_string2(const uint8_t *str, int str_len, struct gc=
_arena *gc);
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index be9=
1a99=2E=2E0c91449 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
=
@@ -332,7 +332,7 @@
  * the proxy can determine true client origin=2E
  */
=
 static void
-journal_add(const char *journal_dir, struct proxy_connection =
*pc, struct proxy_connection *cp)
+journal_add(const char *journal_dir, con=
st struct proxy_connection *pc, struct proxy_connection *cp)
 {
     struct=
 openvpn_sockaddr from, to;
 
@@ -410,7 +410,7 @@
 static bool
 proxy_entry=
_new(struct proxy_connection **list, struct event_set *es,
                =
 const struct openvpn_sockaddr server_addr, const socket_descriptor_t sd_cl=
ient,
-                struct buffer *initial_data, const char *journal_dir=
)
+                const struct buffer *initial_data, const char *journal_d=
ir)
 {
     socket_descriptor_t sd_server;
     int status;
@@ -1013,7 +101=
3,7 @@
  * call=2E
  */
 void
-port_share_redirect(struct port_share *ps, c=
onst struct buffer *head, socket_descriptor_t sd)
+port_share_redirect(cons=
t struct port_share *ps, const struct buffer *head, socket_descriptor_t sd)=

 {
     if (ps)
     {
diff --git a/src/openvpn/ps=2Eh b/src/openvpn/ps=2E=
h
index 557ecf5=2E=2E918ceb6 100644
--- a/src/openvpn/ps=2Eh
+++ b/src/open=
vpn/ps=2Eh
@@ -49,7 +49,7 @@
 
 bool is_openvpn_protocol(const struct buffe=
r *buf);
 
-void port_share_redirect(struct port_share *ps, const struct bu=
ffer *head, socket_descriptor_t sd);
+void port_share_redirect(const struct=
 port_share *ps, const struct buffer *head, socket_descriptor_t sd);
 
 #en=
dif /* if PORT_SHARE */
 #endif /* ifndef PS_H */
diff --git a/src/openvpn/=
push=2Ec b/src/openvpn/push=2Ec
index fa7bf1e=2E=2Ec2c1914 100644
--- a/src=
/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -430,7 +430,7 @@
 }
 
 bool=

-send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_sessio=
n *session,
+send_auth_pending_messages(const struct tls_multi *tls_multi, =
struct tls_session *session,
                            const char *extra,=
 unsigned int timeout)
 {
     struct key_state *ks =3D &session->key[KS_PR=
IMARY];
diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index dff9=
45f=2E=2E39302f6 100644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=
=2Eh
@@ -117,7 +117,7 @@
  * doc/management-notes=2Etxt under client-pendin=
g-auth for
  * more details on message format
  */
-bool send_auth_pending_=
messages(struct tls_multi *tls_multi, struct tls_session *session,
+bool se=
nd_auth_pending_messages(const struct tls_multi *tls_multi, struct tls_sess=
ion *session,
                                 const char *extra, unsigned =
int timeout);
 
 void send_restart(struct context *c, const char *kill_msg)=
;
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index =
0213041=2E=2E7fa5987 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openv=
pn/push_util=2Ec
@@ -222,7 +222,7 @@
 
 /* Return true if the client suppor=
ts push-update */
 static bool
-support_push_update(struct multi_instance *=
mi)
+support_push_update(const struct multi_instance *mi)
 {
     ASSERT(mi=
->context=2Ec2=2Etls_multi);
     const unsigned int iv_proto_peer =3D extr=
act_iv_proto(mi->context=2Ec2=2Etls_multi->peer_info);
diff --git a/src/ope=
nvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index ced438e=2E=2Eba819a3 100=
644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -92,7 =
+92,7 @@
 
 /* check if a particular packet_id is present in ack */
 static=
 inline bool
-reliable_ack_packet_id_present(struct reliable_ack *ack, pack=
et_id_type pid)
+reliable_ack_packet_id_present(const struct reliable_ack *=
ack, packet_id_type pid)
 {
     for (int i =3D 0; i < ack->len; ++i)
     =
{
@@ -391,7 +391,7 @@
 }
 
 int
-validate_packet_id_window(struct reliable =
*rel, packet_id_type pid)
+validate_packet_id_window(const struct reliable =
*rel, packet_id_type pid)
 {
     return reliable_pid_min(pid, rel->packet_=
id)
            && reliable_pid_min(subtract_pid(rel->packet_id, RELIABLE_C=
APACITY), pid);
@@ -768,7 +768,7 @@
  */
 
 void
-reliable_mark_active_inco=
ming(struct reliable *rel, struct buffer *buf, packet_id_type pid,
+reliabl=
e_mark_active_incoming(struct reliable *rel, const struct buffer *buf, pack=
et_id_type pid,
                               int opcode)
 {
     for (int=
 i =3D 0; i < rel->size; ++i)
@@ -828,7 +828,7 @@
 
 /* delete a buffer pre=
viously activated by reliable_mark_active() */
 void
-reliable_mark_deleted=
(struct reliable *rel, struct buffer *buf)
+reliable_mark_deleted(struct re=
liable *rel, const struct buffer *buf)
 {
     for (int i =3D 0; i < rel->s=
ize; ++i)
     {
diff --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliab=
le=2Eh
index a85f2e9=2E=2E12d5367 100644
--- a/src/openvpn/reliable=2Eh
+++=
 b/src/openvpn/reliable=2Eh
@@ -184,7 +184,7 @@
  * @li False, if there are=
 packet IDs to be acknowledged=2E
  */
 static inline bool
-reliable_ack_em=
pty(struct reliable_ack *ack)
+reliable_ack_empty(const struct reliable_ack=
 *ack)
 {
     return !ack->len;
 }
@@ -198,7 +198,7 @@
  * included in the=
 valid range=2E
  */
 int
-validate_packet_id_window(struct reliable *rel, =
packet_id_type pid);
+validate_packet_id_window(const struct reliable *rel,=
 packet_id_type pid);
 
 /**
  * Returns the number of packets that need to=
 be acked=2E
@@ -208,7 +208,7 @@
  * @returns the number of outstanding ack=
s
  */
 static inline int
-reliable_ack_outstanding(struct reliable_ack *ac=
k)
+reliable_ack_outstanding(const struct reliable_ack *ack)
 {
     return=
 ack->len;
 }
@@ -358,7 +358,7 @@
  * @param pid The packet's packet ID=2E
=
  * @param opcode The packet's opcode=2E
  */
-void reliable_mark_active_in=
coming(struct reliable *rel, struct buffer *buf, packet_id_type pid,
+void =
reliable_mark_active_incoming(struct reliable *rel, const struct buffer *bu=
f, packet_id_type pid,
                                    int opcode);
 
 =
/**
@@ -411,7 +411,7 @@
  * @param rel The reliable structure associated wi=
th the given buffer=2E
  * @param buf The buffer of the reliable entry whic=
h is to be removed=2E
  */
-void reliable_mark_deleted(struct reliable *rel=
, struct buffer *buf);
+void reliable_mark_deleted(struct reliable *rel, co=
nst struct buffer *buf);
 
 /** @} name Functions for extracting incoming p=
ackets */
 
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
inde=
x 03a2526=2E=2E078bb7e 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn=
/route=2Ec
@@ -898,8 +898,9 @@
 }
 
 static bool
-add_bypass_routes(struct =
route_bypass *rb, in_addr_t gateway, const struct tuntap *tt,
-            =
      unsigned int flags, const struct route_gateway_info *rgi,
+add_bypass=
_routes(const struct route_bypass *rb, in_addr_t gateway,
+                =
  const struct tuntap *tt, unsigned int flags,
+                  const str=
uct route_gateway_info *rgi,
                   const struct env_set *es, o=
penvpn_net_ctx_t *ctx)
 {
     int ret =3D true;
@@ -916,8 +917,9 @@
 }
 
 =
static void
-del_bypass_routes(struct route_bypass *rb, in_addr_t gateway, =
const struct tuntap *tt,
-                  unsigned int flags, const struc=
t route_gateway_info *rgi,
+del_bypass_routes(const struct route_bypass *rb=
, in_addr_t gateway,
+                  const struct tuntap *tt, unsigned i=
nt flags,
+                  const struct route_gateway_info *rgi,
        =
           const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     int i;=

@@ -3942,7 +3944,7 @@
 #else  /* if defined(_WIN32) */
 
 static void
-get=
_bypass_addresses(struct route_bypass *rb, const unsigned int flags) /* PLA=
TFORM-SPECIFIC */
+get_bypass_addresses(struct route_bypass *rb, const unsi=
gned int flags)
 {
 }
 
diff --git a/src/openvpn/schedule=2Ec b/src/openvpn=
/schedule=2Ec
index 6772ad6=2E=2E694f4d1 100644
--- a/src/openvpn/schedule=
=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -389,4 +389,4 @@
 {
     s->earliest=
_wakeup =3D NULL; /* invalidate cache */
     schedule_remove_node(s, e);
-=
}
\ No newline at end of file
+}
diff --git a/src/openvpn/socket=2Ec b/src/=
openvpn/socket=2Ec
index e06c379=2E=2E52829a3 100644
--- a/src/openvpn/sock=
et=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -619,7 +619,7 @@
 }
 
 static void
-=
bind_local(struct link_socket *sock)
+bind_local(const struct link_socket *=
sock)
 {
     /* bind to local address/port */
     if (sock->bind_local)
@=
@ -878,8 +878,8 @@
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
 
@@ -1087,8 +1087,8 @@
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
 
@@ -1441,7 +1=
441,7 @@
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
@@ -2037,7 +2037,7 @@
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
@@ -2303,7 +2303,7 @@
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
@@ -2375,7 +2375=
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
@@ -2438=
,7 +2438,7 @@
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
@@ -2632,7 +2632,7 @@
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
@@ -2732,8 +2732,8 @@
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
index 71459ee=2E=2E5cc2b1b 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1171,7 +1171,7 @@
 }
 
 struct tl=
s_multi *
-tls_multi_init(struct tls_options *tls_options)
+tls_multi_init(=
const struct tls_options *tls_options)
 {
     struct tls_multi *ret;
 
@@ =
-1212,7 +1212,7 @@
  */
 
 struct tls_auth_standalone *
-tls_auth_standalon=
e_init(struct tls_options *tls_options, struct gc_arena *gc)
+tls_auth_stan=
dalone_init(const struct tls_options *tls_options, struct gc_arena *gc)
 {
=
     struct tls_auth_standalone *tas;
 
@@ -1360,7 +1360,7 @@
 
 static voi=
d
 init_epoch_keys(struct key_state *ks, struct tls_multi *multi, const str=
uct key_type *key_type,
-                bool server, struct key2 *key2)
+ =
               bool server, const struct key2 *key2)
 {
     /* For now we =
hardcode this to be 4 for the software based data channel
      * DCO based=
 implementations/HW implementation might adjust this number
@@ -1403,7 +140=
3,7 @@
 
 static void
 init_key_contexts(struct key_state *ks, struct tls_m=
ulti *multi, const struct key_type *key_type,
-                  bool serve=
r, struct key2 *key2, bool dco_enabled)
+                  bool server, con=
st struct key2 *key2, bool dco_enabled)
 {
     struct key_ctx_bi *key =3D =
&ks->crypto_options=2Ekey_ctx_bi;
 
@@ -1601,8 +1601,9 @@
 
 bool
 tls_sess=
ion_update_crypto_params_do_work(struct tls_multi *multi, struct tls_sessio=
n *session,
-                                         struct options *optio=
ns, struct frame *frame,
-                                         struct f=
rame *frame_fragment, struct link_socket_info *lsi,
+                      =
                   const struct options *options, struct frame *frame,
+   =
                                      struct frame *frame_fragment,
+      =
                                   const struct link_socket_info *lsi,
    =
                                      dco_context_t *dco)
 {
     if (sessi=
on->key[KS_PRIMARY]=2Ecrypto_options=2Ekey_ctx_bi=2Einitialized)
@@ -1671,7=
 +1672,7 @@
 bool
 tls_session_update_crypto_params(struct tls_multi *multi=
, struct tls_session *session,
                                  struct opt=
ions *options, struct frame *frame,
-                                 struc=
t frame *frame_fragment, struct link_socket_info *lsi,
+                   =
              struct frame *frame_fragment, const struct link_socket_info *=
lsi,
                                  dco_context_t *dco)
 {
     if (!che=
ck_session_cipher(session, options))
@@ -1887,7 +1888,8 @@
 }
 
 static boo=
l
-push_peer_info_peerid(struct buffer *out, struct tls_multi *multi, struc=
t tls_session *session)
+push_peer_info_peerid(struct buffer *out, const st=
ruct tls_multi *multi,
+                      const struct tls_session *ses=
sion)
 {
     if (multi->rx_peer_id =3D=3D MAX_PEER_ID || session->opt->dco=
_enabled)
     {
@@ -1922,7 +1924,7 @@
  * @return          true if no erro=
r was encountered
  */
 static bool
-push_peer_info(struct buffer *buf, str=
uct tls_multi *multi, struct tls_session *session)
+push_peer_info(struct b=
uffer *buf, const struct tls_multi *multi, struct tls_session *session)
 {
=
     struct gc_arena gc =3D gc_new();
     bool ret =3D false;
@@ -2566,8 +=
2568,8 @@
 }
 
 bool
-session_skip_to_pre_start(struct tls_session *session=
, struct tls_pre_decrypt_state *state,
-                          struct li=
nk_socket_actual *from)
+session_skip_to_pre_start(struct tls_session *sess=
ion, const struct tls_pre_decrypt_state *state,
+                          =
const struct link_socket_actual *from)
 {
     struct key_state *ks =3D &se=
ssion->key[KS_PRIMARY];
     ks->session_id_remote =3D state->peer_session_=
id;
@@ -2785,7 +2787,7 @@
 
 static bool
 check_outgoing_ciphertext(struct =
key_state *ks, struct tls_session *session,
-                          stru=
ct buffer *to_link, bool *continue_tls_process)
+                          =
const struct buffer *to_link, bool *continue_tls_process)
 {
     if (to_li=
nk->len)
     {
@@ -3226,7 +3228,7 @@
         return;
     }
 
-    uint8_=
t *dataptr =3D to_link->data;
+    const uint8_t *dataptr =3D to_link->data=
;
 
     /* we don't expect send_reliable to be NULL when state is
      * =
not S_UNDEF, but people have reported crashes nonetheless,
@@ -4126,7 +4128=
,7 @@
 }
 
 void
-tls_post_encrypt(struct tls_multi *multi, struct buffer *=
buf)
+tls_post_encrypt(struct tls_multi *multi, const struct buffer *buf)
 =
{
     struct key_state *ks =3D multi->save_ks;
     multi->save_ks =3D NUL=
L;
@@ -4257,7 +4259,7 @@
  * into a garbage collectable string which is ret=
urned=2E
  */
 const char *
-protocol_dump(struct buffer *buffer, unsigned =
int flags, struct gc_arena *gc)
+protocol_dump(const struct buffer *buffer,=
 unsigned int flags, struct gc_arena *gc)
 {
     struct buffer out =3D all=
oc_buf_gc(256, gc);
     struct buffer buf =3D *buffer;
diff --git a/src/op=
envpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 7ddf965=2E=2E93e6200 100644
--- a=
/src/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -166,7 +166,7 @@
  *
  * =
@return A newly allocated and initialized \c tls_multi structure=2E
  */
-s=
truct tls_multi *tls_multi_init(struct tls_options *tls_options);
+struct t=
ls_multi *tls_multi_init(const struct tls_options *tls_options);
 
 /**
  *=
 Finalize initialization of a \c tls_multi structure=2E
@@ -187,7 +187,7 @@=

 /*
  * Initialize a standalone tls-auth verification object=2E
  */
-stru=
ct tls_auth_standalone *tls_auth_standalone_init(struct tls_options *tls_op=
tions,
+struct tls_auth_standalone *tls_auth_standalone_init(const struct t=
ls_options *tls_options,
                                                  =
    struct gc_arena *gc);
 
 /**
@@ -371,7 +371,7 @@
  * @param multi - The=
 TLS state for this packet's destination VPN tunnel=2E
  * @param buf - The=
 buffer containing the outgoing packet=2E
  */
-void tls_post_encrypt(struc=
t tls_multi *multi, struct buffer *buf);
+void tls_post_encrypt(struct tls_=
multi *multi, const struct buffer *buf);
 
 /** @} name Functions for manag=
ing security parameter state for data channel packets */
 
@@ -461,7 +461,8=
 @@
  */
 bool tls_session_update_crypto_params(struct tls_multi *multi, st=
ruct tls_session *session,
                                       struct op=
tions *options, struct frame *frame,
-                                     =
 struct frame *frame_fragment, struct link_socket_info *lsi,
+             =
                         struct frame *frame_fragment,
+                   =
                   const struct link_socket_info *lsi,
                    =
                   dco_context_t *dco);
 
 /*
@@ -525,7 +526,7 @@
 #define =
PD_VERBOSE                 (1 << 10)
 #define PD_TLS_CRYPT               (1=
 << 11)
 
-const char *protocol_dump(struct buffer *buffer, unsigned int fl=
ags, struct gc_arena *gc);
+const char *protocol_dump(const struct buffer *=
buffer, unsigned int flags, struct gc_arena *gc);
 
 /*
  * debugging code
=
@@ -573,7 +574,7 @@
 /* Special method to skip the three way handshake RESE=
T stages=2E This is
  * used by the HMAC code when seeing a packet that mat=
ches the previous
  * HMAC based stateless server state */
-bool session_sk=
ip_to_pre_start(struct tls_session *session, struct tls_pre_decrypt_state *=
state,
-                               struct link_socket_actual *from);
+b=
ool session_skip_to_pre_start(struct tls_session *session, const struct tls=
_pre_decrypt_state *state,
+                               const struct lin=
k_socket_actual *from);
 
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/s=
rc/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh
index a6d57f2=2E=
=2E29e07a6 100644
--- a/src/openvpn/ssl_backend=2Eh
+++ b/src/openvpn/ssl_b=
ackend=2Eh
@@ -137,7 +137,7 @@
  *
  * @return      true if the context is =
initialised, false if not=2E
  */
-bool tls_ctx_initialised(struct tls_root=
_ctx *ctx);
+bool tls_ctx_initialised(const struct tls_root_ctx *ctx);
 
 /=
**
  * Set any library specific options=2E
@@ -170,7 +170,7 @@
  * @param c=
iphers       String containing : delimited cipher names, or NULL to use
  *=
                                      sane defaults=2E
  */
-void tls_ctx_r=
estrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers);
+void=
 tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const char =
*ciphers);
 
 /**
  * Set the TLS certificate profile=2E  The profile defin=
es which crypto
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_=
mbedtls=2Ec
index c92c423=2E=2Ecddf856 100644
--- a/src/openvpn/ssl_mbedtls=
=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -146,7 +146,7 @@
 }
 
 bool
-tls_=
ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(const struct=
 tls_root_ctx *ctx)
 {
     /* either this should be NULL or should be non-=
null and then have a
      * valid TLS ctx inside as well */
@@ -269,7 +269=
,7 @@
 }
 
 void
-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, =
const char *ciphers)
+tls_ctx_restrict_ciphers_tls13(const struct tls_root_=
ctx *ctx, const char *ciphers)
 {
     if (ciphers =3D=3D NULL)
     {
diff=
 --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 7c=
fe9f4=2E=2Ecb3de65 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openv=
pn/ssl_openssl=2Ec
@@ -129,7 +129,7 @@
 }
 
 bool
-tls_ctx_initialised(stru=
ct tls_root_ctx *ctx)
+tls_ctx_initialised(const struct tls_root_ctx *ctx)
=
 {
     /* either this should be NULL or should be non-null and then have a=

      * valid TLS ctx inside as well */
@@ -446,7 +446,7 @@
 #endif
 
 voi=
d
-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *cip=
hers)
+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const=
 char *ciphers)
 {
     if (ciphers =3D=3D NULL)
     {
@@ -1093,7 +1093,7 =
@@
 }
 
 static void
-tls_ctx_load_cert_uri(struct tls_root_ctx *tls_ctx, c=
onst char *uri)
+tls_ctx_load_cert_uri(const struct tls_root_ctx *tls_ctx, =
const char *uri)
 {
 #if defined(HAVE_OPENSSL_STORE_API)
     X509 *x =3D N=
ULL;
@@ -2008,7 +2008,7 @@
 }
 
 static void
-bio_debug_data(const char *mo=
de, BIO *bio, const uint8_t *buf, int len, const char *desc)
+bio_debug_dat=
a(const char *mode, const BIO *bio, const uint8_t *buf, int len, const char=
 *desc)
 {
     struct gc_arena gc =3D gc_new();
     if (len > 0)
@@ -2022=
,7 +2022,7 @@
 }
 
 static void
-bio_debug_oc(const char *mode, BIO *bio)
+=
bio_debug_oc(const char *mode, const BIO *bio)
 {
     open_biofp();
     f=
printf(biofp, "BIO %s time=3D%" PRIi64 " bio=3D" ptr_format "\n", mode, (in=
t64_t)time(NULL),
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pk=
t=2Ec
index 6a6d9f9=2E=2E4ced4c4 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b=
/src/openvpn/ssl_pkt=2Ec
@@ -58,7 +58,7 @@
  *  @return         if the swap=
 was successful (buf was large enough)
  */
 static bool
-swap_hmac(struct =
buffer *buf, const struct crypto_options *co, bool incoming)
+swap_hmac(con=
st struct buffer *buf, const struct crypto_options *co, bool incoming)
 {
 =
    ASSERT(co);
 
@@ -118,7 +118,7 @@
  */
 static void
 tls_wrap_control(s=
truct tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,
-             =
    struct session_id *session_id)
+                 const struct session_i=
d *session_id)
 {
     if (ctx->mode =3D=3D TLS_WRAP_AUTH || ctx->mode =3D=
=3D TLS_WRAP_NONE)
     {
@@ -402,9 +402,9 @@
 
 
 struct buffer
-tls_reset=
_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-   =
                  struct session_id *own_sid, struct session_id *remote_sid=
, uint8_t header,
-                     bool request_resend_wkc)
+tls_reset=
_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas=
,
+                     const struct session_id *own_sid, const struct sess=
ion_id *remote_sid,
+                     uint8_t header, bool request_rese=
nd_wkc)
 {
     /* Copy buffer here to point at the same data but allow tls=
_wrap_control
      * to potentially change buf to point to another buffer =
without
@@ -489,7 +489,7 @@
 bool
 check_session_hmac_and_pkt_id(struct tls=
_pre_decrypt_state *state,
                               const struct open=
vpn_sockaddr *from,
-                              uint8_t *key,
+         =
                     const uint8_t *key,
                               int=
 handwindow,
                               bool pkt_is_ack)
 {
diff --git =
a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 03e8930=2E=2E8203=
e4a 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -=
183,7 +183,7 @@
  * @return              the expected server session id
  *=
/
 bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, =
const struct openvpn_sockaddr *from,
-                                   ui=
nt8_t *key, int handwindow, bool pkt_is_ack);
+                            =
       const uint8_t *key, int handwindow, bool pkt_is_ack);
 
 /*
  * Writ=
e a control channel authentication record=2E
@@ -210,8 +210,9 @@
  * from t=
he tls pre decrypt state=2E
  *
  */
-struct buffer tls_reset_standalone(st=
ruct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                 =
                  struct session_id *own_sid, struct session_id *remote_sid=
,
+struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, const struc=
t tls_auth_standalone *tas,
+                                   const struc=
t session_id *own_sid,
+                                   const struct ses=
sion_id *remote_sid,
                                    uint8_t header, bo=
ol request_resend_wkc);
 
 
diff --git a/src/openvpn/ssl_verify=2Ec b/src/o=
penvpn/ssl_verify=2Ec
index 063fa5d=2E=2E3304cb46 100644
--- a/src/openvpn/=
ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1139,7 +1139,7 @@
  * c=
ache=2E
  */
 static bool
-tls_authentication_status_use_cache(struct tls_m=
ulti *multi)
+tls_authentication_status_use_cache(const struct tls_multi *m=
ulti)
 {
     unsigned int idx =3D min_uint(multi->tas_cache_num_updates, S=
IZE(cache_intervals) - 1);
     time_t latency =3D cache_intervals[idx];
@@=
 -1283,7 +1283,7 @@
  * Check if the script/plugin left a message in the au=
th failed message
  * file and relay it to the user */
 static void
-check_=
for_client_reason(struct tls_multi *multi, struct auth_deferred_status *sta=
tus)
+check_for_client_reason(struct tls_multi *multi, const struct auth_de=
ferred_status *status)
 {
     struct gc_arena gc =3D gc_new();
     const =
char *msg =3D key_state_check_auth_failed_message_file(status, &gc);
@@ -15=
52,7 +1552,7 @@
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 static bool
-set_v=
erify_user_pass_env(struct user_pass *up, struct tls_multi *multi, struct t=
ls_session *session)
+set_verify_user_pass_env(const struct user_pass *up, =
struct tls_multi *multi, struct tls_session *session)
 {
     /* Is usernam=
e defined? */
     if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIO=
NAL) || strlen(up->username))
@@ -1580,7 +1580,7 @@
 }
 
 bool
-ssl_verify_=
username_length(struct tls_session *session, const char *username)
+ssl_ver=
ify_username_length(const struct tls_session *session, const char *username=
)
 {
     if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
    =
     && strlen(username) > TLS_USERNAME_LEN)
diff --git a/src/openvpn/ssl_v=
erify=2Eh b/src/openvpn/ssl_verify=2Eh
index 3176d76=2E=2Ee77bc4a 100644
--=
- a/src/openvpn/ssl_verify=2Eh
+++ b/src/openvpn/ssl_verify=2Eh
@@ -202,7 +=
202,7 @@
  * @return              true if name is under limit or username-a=
s-common-name
  *                      is not active
  */
-bool ssl_verify_=
username_length(struct tls_session *session, const char *username);
+bool s=
sl_verify_username_length(const struct tls_session *session, const char *us=
ername);
 
 /**
  * Runs the --client-crresponse script if one is defined=
=2E
@@ -275,7 +275,7 @@
 void auth_set_client_reason(struct tls_multi *mult=
i, const char *client_reason);
 
 static inline const char *
-tls_client_re=
ason(struct tls_multi *multi)
+tls_client_reason(const struct tls_multi *mu=
lti)
 {
     return multi->client_reason;
 }
diff --git a/src/openvpn/statu=
s=2Ec b/src/openvpn/status=2Ec
index c7d375b=2E=2Ecfbc38d 100644
--- a/src/=
openvpn/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ -135,7 +135,7 @@
 }
 
 v=
oid
-status_reset(struct status_output *so)
+status_reset(const struct stat=
us_output *so)
 {
     if (so && so->fd >=3D 0)
     {
diff --git a/src/ope=
nvpn/status=2Eh b/src/openvpn/status=2Eh
index 7953a4e=2E=2E4c01d75 100644
=
--- a/src/openvpn/status=2Eh
+++ b/src/openvpn/status=2Eh
@@ -69,7 +69,7 @@=

 
 bool status_trigger(struct status_output *so);
 
-void status_reset(str=
uct status_output *so);
+void status_reset(const struct status_output *so);=

 
 void status_flush(struct status_output *so);
 
diff --git a/src/openvpn=
/tun=2Ec b/src/openvpn/tun=2Ec
index af48921=2E=2Eabb46af 100644
--- a/src/=
openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -835,7 +835,7 @@
          con=
st char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 IPv6 */
       =
   int ifconfig_ipv6_netbits_parm,
          const char *ifconfig_ipv6_remo=
te_parm,    /* --ifconfig parm 2 IPv6 */
-         struct addrinfo *local_p=
ublic, struct addrinfo *remote_public, const bool strict_warn,
+         co=
nst struct addrinfo *local_public, const struct addrinfo *remote_public, co=
nst bool strict_warn,
          struct env_set *es, openvpn_net_ctx_t *ctx,=
 struct tuntap *tt)
 {
     if (!tt)
@@ -978,7 +978,7 @@
  * -> helper func=
tion to simplify code below
  */
 static void
-add_route_connected_v6_net(s=
truct tuntap *tt, const struct env_set *es)
+add_route_connected_v6_net(con=
st struct tuntap *tt, const struct env_set *es)
 {
     struct route_ipv6 r=
6;
 
@@ -1020,7 +1020,7 @@
  */
 
 in_addr_t
-create_arbitrary_remote(struc=
t tuntap *tt)
+create_arbitrary_remote(const struct tuntap *tt)
 {
     in_=
addr_t remote;
 
@@ -1592,7 +1592,7 @@
 }
 
 static void
-undo_ifconfig_ipv=
4(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4(const stru=
ct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     i=
nt netbits =3D netmask_to_netbits2(tt->remote_netmask);
@@ -1627,7 +1627,7 =
@@
 }
 
 static void
-undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx=
_t *ctx)
+undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ct=
x)
 {
 #if defined(TARGET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_n=
ame, &tt->local_ipv6, tt->netbits_ipv6) < 0)
@@ -1652,7 +1652,7 @@
 }
 
 vo=
id
-undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig=
(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     if (tt->backend_d=
river !=3D DRIVER_NULL && tt->backend_driver !=3D DRIVER_AFUNIX)
     {
@@ =
-1720,7 +1720,7 @@
 }
 
 static ssize_t
-write_tun_header(struct tuntap *tt=
, uint8_t *buf, int len)
+write_tun_header(const struct tuntap *tt, const u=
int8_t *buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -=
1737,9 +1737,11 @@
             type =3D htonl(AF_INET);
         }
 
+    =
    /* argument to writev is a pointer to const but we still need to drop
+=
         * the const from buf pointer here */
         iv[0]=2Eiov_base =3D=
 &type;
         iv[0]=2Eiov_len =3D sizeof(type);
-        iv[1]=2Eiov_bas=
e =3D buf;
+        iv[1]=2Eiov_base =3D (void *)buf;
         iv[1]=2Eiov_=
len =3D len;
 
         return header_modify_read_write_return(writev(tt->f=
d, iv, 2));
@@ -1751,7 +1753,7 @@
 }
 
 static ssize_t
-read_tun_header(str=
uct tuntap *tt, uint8_t *buf, int len)
+read_tun_header(const struct tuntap=
 *tt, uint8_t *buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
    =
 {
@@ -1777,13 +1779,13 @@
  */
 #if !defined(TARGET_DARWIN)
 ssize_t
-writ=
e_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tun=
tap *tt, const uint8_t *buf, int len)
 {
     return write_tun_header(tt, b=
uf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)=

+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     return r=
ead_tun_header(tt, buf, len);
 }
@@ -1799,7 +1801,7 @@
 
 #if defined(TARGE=
T_LINUX) || defined(TARGET_FREEBSD)
 static bool
-tun_dco_enabled(struct tu=
ntap *tt)
+tun_dco_enabled(const struct tuntap *tt)
 {
     return tt->back=
end_driver =3D=3D DRIVER_DCO;
 }
@@ -2046,13 +2048,13 @@
 }
 
 ssize_t
-wri=
te_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tu=
ntap *tt, const uint8_t *buf, int len)
 {
     return write(tt->fd, buf, le=
n);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read=
_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt=
->fd, buf, len);
 }
@@ -2251,13 +2253,13 @@
 }
 
 ssize_t
-write_tun(struct=
 tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, con=
st uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssi=
ze_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const st=
ruct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, le=
n);
 }
@@ -2587,7 +2589,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, ui=
nt8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf=
, int len)
 {
     struct strbuf sbuf;
     sbuf=2Elen =3D len;
@@ -2596,7 =
+2598,7 @@
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len=
)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     struct =
strbuf sbuf;
     int f =3D 0;
@@ -3094,7 +3096,7 @@
 }
 
 ssize_t
-write_t=
un(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap=
 *tt, const uint8_t *buf, int len)
 {
     if (tt->backend_driver =3D=3D DR=
IVER_UTUN)
     {
@@ -3107,7 +3109,7 @@
 }
 
 ssize_t
-read_tun(struct tunt=
ap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *=
buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
@@ =
-3311,7 +3313,7 @@
 }
 
 int
-tun_write_queue(struct tuntap *tt, struct buf=
fer *buf)
+tun_write_queue(struct tuntap *tt, const struct buffer *buf)
 {
=
     if (tt->writes=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
@@ -3366,7 +33=
68,7 @@
 }
 
 int
-tun_write_win32(struct tuntap *tt, struct buffer *buf)
+=
tun_write_win32(struct tuntap *tt, const struct buffer *buf)
 {
     int er=
r =3D 0;
     int status =3D 0;
@@ -5374,7 +5376,7 @@
 }
 
 void
-fork_regi=
ster_dns_action(struct tuntap *tt)
+fork_register_dns_action(const struct t=
untap *tt)
 {
     if (tt && tt->options=2Eregister_dns && tt->options=2Ems=
g_channel)
     {
@@ -5464,7 +5466,7 @@
 }
 
 static void
-tuntap_get_mtu(s=
truct tuntap *tt)
+tuntap_get_mtu(const struct tuntap *tt)
 {
     ULONG mt=
u =3D 0;
     DWORD len;
@@ -6039,7 +6041,7 @@
 }
 
 void
-tun_show_debug(s=
truct tuntap *tt)
+tun_show_debug(const struct tuntap *tt)
 {
     if (tt->=
backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)
     {
diff --git a/src/=
openvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 931e54d=2E=2Ebeb0d0e 100644
---=
 a/src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -272,9 +272,9 @@
 
 voi=
d close_tun_handle(struct tuntap *tt);
 
-ssize_t write_tun(struct tuntap *=
tt, uint8_t *buf, int len);
+ssize_t write_tun(const struct tuntap *tt, con=
st uint8_t *buf, int len);
 
-ssize_t read_tun(struct tuntap *tt, uint8_t *=
buf, int len);
+ssize_t read_tun(const struct tuntap *tt, uint8_t *buf, int=
 len);
 
 #ifdef ENABLE_FEATURE_TUN_PERSIST
 void tuncfg(const char *dev, c=
onst char *dev_type, const char *dev_node, int persist_mode,
@@ -293,7 +293=
,7 @@
                         const char *ifconfig_ipv6_local_parm,     /*=
 --ifconfig parm 1 / IPv6 */
                         int ifconfig_ipv6_net=
bits_parm,           /* --ifconfig parm 1 / bits */
                       =
  const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 */
=
-                        struct addrinfo *local_public, struct addrinfo *re=
mote_public,
+                        const struct addrinfo *local_public, =
const struct addrinfo *remote_public,
                         const bool s=
trict_warn, struct env_set *es, openvpn_net_ctx_t *ctx,
                   =
      struct tuntap *tt);
 
@@ -320,7 +320,7 @@
  * @param tt    the tuntap=
 interface context
  * @param ctx   the networking API opaque context
  */
=
-void undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+void undo_=
ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
 bool is_dev_t=
ype(const char *dev, const char *dev_type, const char *match_type);
 
@@ -3=
51,7 +351,7 @@
 #define IFCONFIG_DEFAULT IFCONFIG_AFTER_TUN_OPEN
 
 static =
inline int
-ifconfig_order(struct tuntap *tt)
+ifconfig_order(const struct =
tuntap *tt)
 {
     if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ =
-381,7 +381,7 @@
 #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN
 
 static inl=
ine int
-route_order(struct tuntap *tt)
+route_order(const struct tuntap *t=
t)
 {
     if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -454,13 +=
454,13 @@
 
 const char *tap_win_getinfo(const struct tuntap *tt, struct gc=
_arena *gc);
 
-void tun_show_debug(struct tuntap *tt);
+void tun_show_debu=
g(const struct tuntap *tt);
 
 bool dhcp_release_by_adapter_index(const DWO=
RD adapter_index);
 
 bool dhcp_renew_by_adapter_index(const DWORD adapter_=
index);
 
-void fork_register_dns_action(struct tuntap *tt);
+void fork_reg=
ister_dns_action(const struct tuntap *tt);
 
 void ipconfig_register_dns(co=
nst struct env_set *es);
 
@@ -470,7 +470,7 @@
 
 int tun_read_queue(struct=
 tuntap *tt, int maxsize);
 
-int tun_write_queue(struct tuntap *tt, struct=
 buffer *buf);
+int tun_write_queue(struct tuntap *tt, const struct buffer =
*buf);
 
 static inline bool
 tuntap_stop(int status)
@@ -499,7 +499,7 @@
 =
    return false;
 }
 
-int tun_write_win32(struct tuntap *tt, struct buffe=
r *buf);
+int tun_write_win32(struct tuntap *tt, const struct buffer *buf);=

 
 static inline bool
 is_ip_packet_valid(const struct buffer *buf)
@@ -52=
9,13 +529,13 @@
 }
 
 static inline bool
-tuntap_is_dco_win(struct tuntap *=
tt)
+tuntap_is_dco_win(const struct tuntap *tt)
 {
     return tt && tt->ba=
ckend_driver =3D=3D DRIVER_DCO;
 }
 
 static inline bool
-tuntap_is_dco_win=
_timeout(struct tuntap *tt, ssize_t status)
+tuntap_is_dco_win_timeout(cons=
t struct tuntap *tt, ssize_t status)
 {
     return tuntap_is_dco_win(tt) &=
& (status < 0) && (openvpn_errno() =3D=3D ERROR_NETNAME_DELETED);
 }
@@ -55=
5,25 +555,25 @@
 }
 
 static inline void
-tun_standby_init(struct tuntap *t=
t)
+tun_standby_init(const struct tuntap *tt)
 {
 }
 
 static inline bool
-=
tun_standby(struct tuntap *tt)
+tun_standby(const struct tuntap *tt)
 {
   =
  return true;
 }
 
 
 static inline bool
-tuntap_is_dco_win(struct tuntap =
*tt)
+tuntap_is_dco_win(const struct tuntap *tt)
 {
     return false;
 }
 =

 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t =
status)
+tuntap_is_dco_win_timeout(const struct tuntap *tt, ssize_t status)=

 {
     return false;
 }
diff --git a/src/openvpn/tun_afunix=2Ec b/src/ope=
nvpn/tun_afunix=2Ec
index a67a472=2E=2Ee9223bc 100644
--- a/src/openvpn/tun=
_afunix=2Ec
+++ b/src/openvpn/tun_afunix=2Ec
@@ -48,7 +48,7 @@
 
 
 static =
void
-tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct=
 env_set *env)
+tun_afunix_exec_child(const char *dev_node, struct tuntap *=
tt, const struct env_set *env)
 {
     const char *msgprefix =3D "ERROR: fa=
ilure executing process for tun:";
     struct argv argv =3D argv_new();
@@=
 -73,7 +73,7 @@
 }
 
 void
-open_tun_afunix(struct options *o, int mtu, str=
uct tuntap *tt, struct env_set *orig_env)
+open_tun_afunix(const struct opt=
ions *o, int mtu, struct tuntap *tt, const struct env_set *orig_env)
 {
   =
  struct gc_arena gc =3D gc_new();
 
diff --git a/src/openvpn/tun_afunix=2E=
h b/src/openvpn/tun_afunix=2Eh
index 5b6a8e0=2E=2Efb88eb2 100644
--- a/src/=
openvpn/tun_afunix=2Eh
+++ b/src/openvpn/tun_afunix=2Eh
@@ -31,7 +31,7 @@
 =
 * the user provided taking care of implementing the actual tun
  * device=
=2E
  */
-void open_tun_afunix(struct options *o, int mtu, struct tuntap *t=
t, struct env_set *env);
+void open_tun_afunix(const struct options *o, int=
 mtu, struct tuntap *tt, const struct env_set *env);
 
 
 /**
diff --git a/=
src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec
index bffc60e=2E=2Ecd32a9b 1006=
44
--- a/src/openvpn/vlan=2Ec
+++ b/src/openvpn/vlan=2Ec
@@ -288,7 +288,7 @=
@
 }
 
 void
-vlan_process_outgoing_tun(struct multi_context *m, struct mul=
ti_instance *mi)
+vlan_process_outgoing_tun(const struct multi_context *m, =
struct multi_instance *mi)
 {
     if (!m->top=2Eoptions=2Evlan_tagging)
  =
   {
diff --git a/src/openvpn/vlan=2Eh b/src/openvpn/vlan=2Eh
index 9389f89=
=2E=2Ecd2f66f 100644
--- a/src/openvpn/vlan=2Eh
+++ b/src/openvpn/vlan=2Eh
=
@@ -35,6 +35,6 @@
 
 bool vlan_is_tagged(const struct buffer *buf);
 
-void=
 vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *=
mi);
+void vlan_process_outgoing_tun(const struct multi_context *m, struct =
multi_instance *mi);
 
 #endif /* VLAN_H */
diff --git a/src/openvpn/win32=
=2Eh b/src/openvpn/win32=2Eh
index 8be3d96=2E=2E39ff7d8 100644
--- a/src/op=
envpn/win32=2Eh
+++ b/src/openvpn/win32=2Eh
@@ -227,7 +227,7 @@
 void overl=
apped_io_close(struct overlapped_io *o);
 
 static inline bool
-overlapped_=
io_active(struct overlapped_io *o)
+overlapped_io_active(const struct overl=
apped_io *o)
 {
     return o->iostate =3D=3D IOSTATE_QUEUED || o->iostate =
=3D=3D IOSTATE_IMMEDIATE_RETURN;
 }
diff --git a/src/openvpnmsica/openvpnms=
ica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index a861e8a=2E=2E25fa1e4 1006=
44
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvpnms=
ica=2Ec
@@ -77,7 +77,7 @@
  * @return ERROR_SUCCESS on success; An error co=
de otherwise
  */
 static UINT
-setup_sequence(_In_ MSIHANDLE hInstall, _In=
_z_ LPCWSTR szProperty, _In_ struct msica_arg_seq *seq)
+setup_sequence(_In=
_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ const struct msica_ar=
g_seq *seq)
 {
     UINT uiResult;
     LPWSTR szSequence =3D msica_arg_seq=
_join(seq);
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/=
interactive=2Ec
index d2288b9=2E=2Eee5d22a 100644
--- a/src/openvpnserv/int=
eractive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -522,7 +522,7 @@
 
 
=
 static SOCKADDR_INET
-sockaddr_inet(short family, inet_address_t *addr)
+s=
ockaddr_inet(short family, const inet_address_t *addr)
 {
     SOCKADDR_INE=
T sa_inet;
     ZeroMemory(&sa_inet, sizeof(sa_inet));
@@ -3849,7 +3849,7 @=
@
 
 static DWORD
 UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, =
HANDLE io_event, HANDLE exit_event,
-                  list_item_t *threads=
)
+                  const list_item_t *threads)
 {
     static DWORD size =
=3D 10;
     static LPHANDLE handles =3D NULL;
diff --git a/tests/unit_test=
s/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=2E=
c
index 77f6ce2=2E=2Efff4c2b 100644
--- a/tests/unit_tests/openvpn/mock_man=
agement=2Ec
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -36,7 +36=
,7 @@
 struct management *management; /* GLOBAL */
 
 void
-management_auth=
_failure(struct management *man, const char *type, const char *reason)
+man=
agement_auth_failure(const struct management *man, const char *type, const =
char *reason)
 {
     ASSERT(false);
 }
diff --git a/tests/unit_tests/openv=
pn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index a41c27b=2E=
=2Ea8daee6 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/=
unit_tests/openvpn/test_misc=2Ec
@@ -146,7 +146,7 @@
 }
 
 static struct ha=
sh_element *
-hash_lookup_by_value(struct hash *hash, void *value)
+hash_lo=
okup_by_value(struct hash *hash, const void *value)
 {
     struct hash_ite=
rator hi;
     struct hash_element *he;
diff --git a/tests/unit_tests/openv=
pn/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec
index c=
0a0866=2E=2E7636a33 100644
--- a/tests/unit_tests/openvpn/test_user_pass=2E=
c
+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec
@@ -59,7 +59,7 @@
     =
return mock();
 }
 void
-management_auth_failure(struct management *man, co=
nst char *type, const char *reason)
+management_auth_failure(const struct m=
anagement *man, const char *type, const char *reason)
 {
     assert_true(0=
);
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I56248cf6d1=
99c2da770774b8fd1e5daf2b116f58
Gerrit-Change-Number: 1663
Gerrit-PatchSet: =
19
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: fli=
chtenheld <frank@lichtenheld=2Ecom>

--8582YZ0uhVU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #19</strong> to this change=2E</p><p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Remove instances of constParameterPointer cppcheck warnings<br=
><br>This requires a few suppressions since cppcheck<br>doesn&#39;t quite u=
nderstand the different code-paths<br>implemented by preprocessor defines=
=2E<br><br>Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-to=
ols/cppcheck-suppression<br>M sample/sample-plugins/client-connect/sample-c=
lient-connect=2Ec<br>M sample/sample-plugins/defer/multi-auth=2Ec<br>M samp=
le/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec<=
br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/cl=
inat=2Ec<br>M src/openvpn/clinat=2Eh<br>M src/openvpn/comp=2Ec<br>M src/ope=
nvpn/comp=2Eh<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M =
src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dco_freebsd=
=2Ec<br>M src/openvpn/dco_internal=2Eh<br>M src/openvpn/dco_linux=2Ec<br>M =
src/openvpn/dco_win=2Ec<br>M src/openvpn/dhcp=2Ec<br>M src/openvpn/dhcp=2Eh=
<br>M src/openvpn/event=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/f=
orward=2Eh<br>M src/openvpn/init=2Ec<br>M src/openvpn/init=2Eh<br>M src/ope=
nvpn/interval=2Eh<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M =
src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/mbuf=2E=
c<br>M src/openvpn/mbuf=2Eh<br>M src/openvpn/mss=2Ec<br>M src/openvpn/mss=
=2Eh<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mtcp=2Eh<br>M src/openvpn/m=
udp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/open=
vpn/multi_io=2Ec<br>M src/openvpn/networking=2Eh<br>M src/openvpn/networkin=
g_iproute2=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/occ=
=2Eh<br>M src/openvpn/openssl_compat=2Eh<br>M src/openvpn/options=2Ec<br>M =
src/openvpn/options_parse=2Ec<br>M src/openvpn/otime=2Ec<br>M src/openvpn/o=
time=2Eh<br>M src/openvpn/proto=2Eh<br>M src/openvpn/proxy=2Ec<br>M src/ope=
nvpn/proxy=2Eh<br>M src/openvpn/ps=2Ec<br>M src/openvpn/ps=2Eh<br>M src/ope=
nvpn/push=2Ec<br>M src/openvpn/push=2Eh<br>M src/openvpn/push_util=2Ec<br>M=
 src/openvpn/reliable=2Ec<br>M src/openvpn/reliable=2Eh<br>M src/openvpn/ro=
ute=2Ec<br>M src/openvpn/schedule=2Ec<br>M src/openvpn/socket=2Ec<br>M src/=
openvpn/socket=2Eh<br>M src/openvpn/socket_util=2Eh<br>M src/openvpn/socks=
=2Ec<br>M src/openvpn/socks=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/s=
sl=2Eh<br>M src/openvpn/ssl_backend=2Eh<br>M src/openvpn/ssl_mbedtls=2Ec<br=
>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvp=
n/ssl_pkt=2Eh<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/ssl_verify=
=2Eh<br>M src/openvpn/status=2Ec<br>M src/openvpn/status=2Eh<br>M src/openv=
pn/tun=2Ec<br>M src/openvpn/tun=2Eh<br>M src/openvpn/tun_afunix=2Ec<br>M sr=
c/openvpn/tun_afunix=2Eh<br>M src/openvpn/vlan=2Ec<br>M src/openvpn/vlan=2E=
h<br>M src/openvpn/win32=2Eh<br>M src/openvpnmsica/openvpnmsica=2Ec<br>M sr=
c/openvpnserv/interactive=2Ec<br>M tests/unit_tests/openvpn/mock_management=
=2Ec<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>M tests/unit_tests/open=
vpn/test_user_pass=2Ec<br>89 files changed, 358 insertions(+), 307 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/63/1663/19</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-su=
ppression b/dev-tools/cppcheck-suppression</span><br><span>index 965e8ec=2E=
=2E59262160f 100644</span><br><span>--- a/dev-tools/cppcheck-suppression</s=
pan><br><span>+++ b/dev-tools/cppcheck-suppression</span><br><span>@@ -2,7 =
+2,6 @@</span><br><span> # occurences right now=2E They still should be fix=
ed at some point</span><br><span> constParameter</span><br><span> constPara=
meterCallback</span><br><span style=3D"color: hsl(0, 100%, 40%);">-constPar=
ameterPointer</span><br><span> invalidPrintfArgType_sint</span><br><span> i=
nvalidPrintfArgType_uint</span><br><span> unusedFunction</span><br><span>@@=
 -27,13 +26,48 @@</span><br><span> # FP: posix=2Ecfg claims suseconds_t is =
unsigned for some reason</span><br><span> unsignedLessThanZero:src/openvpn/=
otime=2Eh:148</span><br><span> # IGN: multi code does weird things with poi=
nters to local variables=2E=2E=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-autoVariables:src/openvpn/multi=2Ec:4232</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+autoVariables:src/openvpn/multi=2Ec:4233<=
/span><br><span> autoVariables:src/openvpn/multi_io=2Ec:324</span><br><span=
> # IGN: the code header =3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is used i=
ntentionally</span><br><span> badBitmaskCheck:src/openvpn/mudp=2Ec</span><b=
r><span> badBitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec</span><br><s=
pan> # IGN: we store integers in pointers</span><br><span> CastAddressToInt=
egerAtReturn:src/openvpn/multi=2Ec</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# IGN: external</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+constParameterPointer:/usr/include/*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# IGN: test files provide mocks/stubs that matc=
h prototypes from headers exactly</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+constParameterPointer:tests/unit_tests/openvpn/mock_*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:tests=
/unit_tests/openvpn/test_*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+constParameterPointer:tests/unit_tests/openvpnserv/test_*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# FP: different crypto impleme=
ntations but same API</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+constParameterPointer:src/openvpn/crypto_mbedtls_legacy=2Ec:85</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/open=
vpn/crypto_openssl=2Ec:173</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+constParameterPointer:src/openvpn/crypto_openssl=2Ec:1433</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/open=
vpn/cryptoapi=2Ec:58</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+constParameterPointer:src/openvpn/ssl_mbedtls=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/ssl_openss=
l=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameter=
Pointer:src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+constParameterPointer:tests/unit_tests/openvpn/sipha=
sh_openssl=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN=
: too many different implementations, not worth it</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/dco*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src=
/openvpn/socket=2E*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# FP: parameters are modified on some platform only</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/dns=2Ec=
:859</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterP=
ointer:src/openvpn/error=2Ec:223</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+constParameterPointer:src/openvpn/forward=2Ec:1245</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openv=
pn/manage=2Ec:344</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
nstParameterPointer:src/openvpn/manage=2Ec:3332</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/misc=2Ec:793<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointe=
r:src/openvpn/misc=2Ec:813</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+constParameterPointer:src/openvpn/options=2Ec:3205</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/rou=
te=2Ec:3947</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constPar=
ameterPointer:src/openvpn/tun=2Ec:560</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+constParameterPointer:src/openvpn/tun=2Ec:2188</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/open=
vpn/tun_afunix=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 IGN: not a FP but the documentation for the FP_ISSET claims this is not co=
nst=2E=2E=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constPa=
rameterPointer:src/openvpn/event=2Ec:1015</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# IGN: fun:check_malloc_return: causes -Wmaybe-uninit=
ialized in MinGW Debug build</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+constParameterPointer:src/openvpn/buffer=2Eh:2082</span><br><span>=
 # IGN: Windows specific (unsigned long =3D=3D unsigned int)</span><br><spa=
n> compareValueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928</span><br=
><span> # FP: cppcheck seems to have wrong signature of DeviceIoControl()</=
span><br><span>diff --git a/sample/sample-plugins/client-connect/sample-cli=
ent-connect=2Ec b/sample/sample-plugins/client-connect/sample-client-connec=
t=2Ec</span><br><span>index 420de61=2E=2Ecbd98e8 100644</span><br><span>---=
 a/sample/sample-plugins/client-connect/sample-client-connect=2Ec</span><br=
><span>+++ b/sample/sample-plugins/client-connect/sample-client-connect=2Ec=
</span><br><span>@@ -344,7 +344,7 @@</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-op=
envpn_plugin_client_connect(struct plugin_context *context, const char **ar=
gv, const char **envp)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+openvpn_plugin_client_connect(const struct plugin_context *context, cons=
t char **argv, const char **envp)</span><br><span> {</span><br><span>     /=
* log environment variables handed to us by OpenVPN, but</span><br><span>  =
    * only if &quot;setenv verb&quot; is 3 or higher (arbitrary number)</sp=
an><br><span>@@ -465,7 +465,7 @@</span><br><span> </span><br><span> int</sp=
an><br><span> openvpn_plugin_client_connect_defer_v2(struct plugin_context =
*context,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                           struct plugin_per_client_context *pcc,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
          const struct plugin_per_client_context *pcc,</span><br><span>    =
                                    struct openvpn_plugin_string_list **ret=
urn_list)</span><br><span> {</span><br><span>     time_t time_left =3D pcc-=
&gt;sleep_until - time(NULL);</span><br><span>diff --git a/sample/sample-pl=
ugins/defer/multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec</sp=
an><br><span>index bacf557=2E=2Ecdd616f 100644</span><br><span>--- a/sample=
/sample-plugins/defer/multi-auth=2Ec</span><br><span>+++ b/sample/sample-pl=
ugins/defer/multi-auth=2Ec</span><br><span>@@ -255,7 +255,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-do_auth_user_pass(struct plugin_context *co=
ntext, const char *username, const char *password)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+do_auth_user_pass(const struct plugin_contex=
t *context, const char *username, const char *password)</span><br><span> {<=
/span><br><span>     plog(context, PLOG_NOTE, &quot;expect_user=3D%s, recei=
ved_user=3D%s, expect_passw=3D%s, received_passw=3D%s&quot;,</span><br><spa=
n>          np(context-&gt;test_valid_user), np(username), np(context-&gt;t=
est_valid_pass), np(password));</span><br><span>@@ -279,7 +279,7 @@</span><=
br><span> </span><br><span> </span><br><span> static int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-auth_user_pass_verify(struct plugin_cont=
ext *context, struct plugin_per_client_context *pcc,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+auth_user_pass_verify(const struct plugin=
_context *context, struct plugin_per_client_context *pcc,</span><br><span> =
                      const char *argv[], const char *envp[])</span><br><sp=
an> {</span><br><span>     /* get username/password from envp string array =
*/</span><br><span>diff --git a/sample/sample-plugins/keying-material-expor=
ter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/keying-material=
-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>index 25c9ff5=2E=
=2E512861a 100644</span><br><span>--- a/sample/sample-plugins/keying-materi=
al-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>+++ b/sample/sa=
mple-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec</span=
><br><span>@@ -186,7 +186,7 @@</span><br><span> }</span><br><span> </span><=
br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
file_store(char *file, char *content)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+file_store(const char *file, const char *content)</span><=
br><span> {</span><br><span>     FILE *f;</span><br><span>     if (!(f =3D =
fopen(file, &quot;w+&quot;)))</span><br><span>@@ -202,7 +202,7 @@</span><br=
><span> server_store(struct openvpn_plugin_args_func_in const *args)</span>=
<br><span> {</span><br><span>     struct plugin *plugin =3D (struct plugin =
*)args-&gt;handle;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct session *sess =3D (struct session *)args-&gt;per_client_context;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct sessi=
on *sess =3D (struct session *)args-&gt;per_client_context;</span><br><span=
> </span><br><span>     char file[MAXPATH];</span><br><span>     snprintf(f=
ile, sizeof(file) - 1, &quot;/tmp/openvpn_sso_%s&quot;, sess-&gt;key);</spa=
n><br><span>@@ -214,7 +214,7 @@</span><br><span> client_store(struct openvp=
n_plugin_args_func_in const *args)</span><br><span> {</span><br><span>     =
struct plugin *plugin =3D (struct plugin *)args-&gt;handle;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct session *sess =3D (struct =
session *)args-&gt;per_client_context;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const struct session *sess =3D (struct session *)arg=
s-&gt;per_client_context;</span><br><span> </span><br><span>     char *file=
 =3D &quot;/tmp/openvpn_sso_user&quot;;</span><br><span>     ovpn_note(&quo=
t;app session file: %s&quot;, file);</span><br><span>diff --git a/src/openv=
pn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 5ce2e39=2E=2E4=
0d5c40 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>=
+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -270,7 +270,7 @@</span><br>=
<span>  * truncated by buf_printf</span><br><span>  */</span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_catrunc(struct b=
uffer *buf, const char *str)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+buf_catrunc(const struct buffer *buf, const char *str)</span><br><=
span> {</span><br><span>     if (buf_forward_capacity(buf) &lt;=3D 1)</span=
><br><span>     {</span><br><span>@@ -1035,7 +1035,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-string_check_buf(struct buffer *buf, const unsigned int i=
nclusive, const unsigned int exclusive)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+string_check_buf(const struct buffer *buf, const unsign=
ed int inclusive, const unsigned int exclusive)</span><br><span> {</span><b=
r><span>     ASSERT(buf);</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 4471697=
=2E=2E9488698 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br=
><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -853,7 +853,7 @@</sp=
an><br><span>  * @param buf   The buffer to append the truncation marker to=
=2E</span><br><span>  * @param str   The null-terminated marker string to w=
rite=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void buf_catrunc(struct buffer *buf, const char *str);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void buf_catrunc(const struct buf=
fer *buf, const char *str);</span><br><span> </span><br><span> /**</span><b=
r><span>  * Extract the next token from a buffer, delimited by a given char=
acter=2E</span><br><span>@@ -1427,7 +1427,7 @@</span><br><span>  *         =
is empty=2E</span><br><span>  */</span><br><span> static inline int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-buf_peek_u8(struct buffer *bu=
f)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_peek_u8(const=
 struct buffer *buf)</span><br><span> {</span><br><span>     int ret;</span=
><br><span>     if (BLEN(buf) &lt; 1)</span><br><span>@@ -1720,7 +1720,7 @@=
</span><br><span>  * @param exclusive Character classes that are not allowe=
d even if they are also in inclusive=2E</span><br><span>  * @return True if=
 the string consists only of allowed characters, false otherwise=2E</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool str=
ing_check_buf(struct buffer *buf, const unsigned int inclusive,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool string_check_buf(const str=
uct buffer *buf, const unsigned int inclusive,</span><br><span>            =
           const unsigned int exclusive);</span><br><span> </span><br><span=
> /**</span><br><span>@@ -1856,7 +1856,7 @@</span><br><span>  * @param a  T=
he arena to test=2E</span><br><span>  */</span><br><span> static inline boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gc_defined(struct gc=
_arena *a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+gc_define=
d(const struct gc_arena *a)</span><br><span> {</span><br><span>     return =
a-&gt;list !=3D NULL;</span><br><span> }</span><br><span>diff --git a/src/o=
penvpn/clinat=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index 3724022=2E=
=2Ed03f9f2 100644</span><br><span>--- a/src/openvpn/clinat=2Ec</span><br><s=
pan>+++ b/src/openvpn/clinat=2Ec</span><br><span>@@ -159,7 +159,7 @@</span>=
<br><span> #endif</span><br><span> </span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-print_pkt(struct openvpn_iphdr *=
iph, const char *prefix, const int direction, const msglvl_t msglevel)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+print_pkt(const struct o=
penvpn_iphdr *iph, const char *prefix, const int direction, const msglvl_t =
msglevel)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc=
_new();</span><br><span> </span><br><span>@@ -181,7 +181,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-client_nat_transform(const struct client_nat_option=
_list *list, struct buffer *ipbuf,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+client_nat_transform(const struct client_nat_option_list *li=
st, const struct buffer *ipbuf,</span><br><span>                      const=
 int direction)</span><br><span> {</span><br><span>     struct ip_tcp_udp_h=
dr *h =3D (struct ip_tcp_udp_hdr *)BPTR(ipbuf);</span><br><span>diff --git =
a/src/openvpn/clinat=2Eh b/src/openvpn/clinat=2Eh</span><br><span>index 1e8=
ceb3=2E=2Ebc56037 100644</span><br><span>--- a/src/openvpn/clinat=2Eh</span=
><br><span>+++ b/src/openvpn/clinat=2Eh</span><br><span>@@ -60,7 +60,7 @@</=
span><br><span>                                    const char *network, con=
st char *netmask,</span><br><span>                                    const=
 char *foreign_network, msglvl_t msglevel);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void client_nat_transform(const str=
uct client_nat_option_list *list, struct buffer *ipbuf,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void client_nat_transform(const struct =
client_nat_option_list *list, const struct buffer *ipbuf,</span><br><span> =
                          const int direction);</span><br><span> </span><br=
><span> #endif /* if !defined(CLINAT_H) */</span><br><span>diff --git a/src=
/openvpn/comp=2Ec b/src/openvpn/comp=2Ec</span><br><span>index b88b79f=2E=
=2E387a7c4 100644</span><br><span>--- a/src/openvpn/comp=2Ec</span><br><spa=
n>+++ b/src/openvpn/comp=2Ec</span><br><span>@@ -159,7 +159,7 @@</span><br>=
<span> #endif /* USE_COMP */</span><br><span> </span><br><span> bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-check_compression_settings_v=
alid(struct compress_options *info, msglvl_t msglevel)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+check_compression_settings_valid(const s=
truct compress_options *info, msglvl_t msglevel)</span><br><span> {</span><=
br><span>     /*</span><br><span>      * We also allow comp-stub-v2 here as=
 it technically allows escaping of</span><br><span>diff --git a/src/openvpn=
/comp=2Eh b/src/openvpn/comp=2Eh</span><br><span>index 29a90a2=2E=2Ead80243=
 100644</span><br><span>--- a/src/openvpn/comp=2Eh</span><br><span>+++ b/sr=
c/openvpn/comp=2Eh</span><br><span>@@ -91,7 +91,7 @@</span><br><span>  * fl=
ags of allow-compression and also the whether algorithms are compiled</span=
><br><span>  * in</span><br><span>  */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-bool check_compression_settings_valid(struct compress_opti=
ons *info, msglvl_t msglevel);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool check_compression_settings_valid(const struct compress_opti=
ons *info, msglvl_t msglevel);</span><br><span> </span><br><span> #ifdef US=
E_COMP</span><br><span> #include &quot;buffer=2Eh&quot;</span><br><span>dif=
f --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>i=
ndex e5ad31a=2E=2Ee29d581 100644</span><br><span>--- a/src/openvpn/crypto=
=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1105,=
7 +1105,7 @@</span><br><span> }</span><br><span> </span><br><span> static b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_is_zero(struct=
 key *key, const struct key_type *kt)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+key_is_zero(const struct key *key, const struct key_type =
*kt)</span><br><span> {</span><br><span>     size_t cipher_length =3D ciphe=
r_kt_key_size(kt-&gt;cipher);</span><br><span>     for (size_t i =3D 0; i &=
lt; cipher_length; ++i)</span><br><span>@@ -1123,7 +1123,7 @@</span><br><sp=
an>  * Make sure that cipher key is a valid key for current key_type=2E</sp=
an><br><span>  */</span><br><span> bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-check_key(struct key *key, const struct key_type *kt)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+check_key(const struct =
key *key, const struct key_type *kt)</span><br><span> {</span><br><span>   =
  if (cipher_defined(kt-&gt;cipher))</span><br><span>     {</span><br><span=
>@@ -1196,7 +1196,7 @@</span><br><span> }</span><br><span> </span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-test_crypto(str=
uct crypto_options *co, struct frame *frame)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+test_crypto(struct crypto_options *co, const struc=
t frame *frame)</span><br><span> {</span><br><span>     int i, j;</span><br=
><span>     struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/s=
rc/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh</span><br><span>index ee5b50=
f=2E=2Ee3c1c6a 100644</span><br><span>--- a/src/openvpn/crypto=2Eh</span><b=
r><span>+++ b/src/openvpn/crypto=2Eh</span><br><span>@@ -414,7 +414,7 @@</s=
pan><br><span>  */</span><br><span> int write_key_file(const int nkeys, con=
st char *filename);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-bool check_key(struct key *key, const struct key_type *kt);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_key(cons=
t struct key *key, const struct key_type *kt);</span><br><span> </span><br>=
<span> /**</span><br><span>  * Initialize a key_type structure with=2E</spa=
n><br><span>@@ -614,7 +614,7 @@</span><br><span> /** Print a cipher list en=
try */</span><br><span> void print_cipher(const char *cipher);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void test_crypto=
(struct crypto_options *co, struct frame *f);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void test_crypto(struct crypto_options *co, const=
 struct frame *f);</span><br><span> </span><br><span> </span><br><span> /* =
key direction functions */</span><br><span>diff --git a/src/openvpn/dco=2Ec=
 b/src/openvpn/dco=2Ec</span><br><span>index 8eae4bf=2E=2E3bf1fb2 100644</s=
pan><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/d=
co=2Ec</span><br><span>@@ -573,7 +573,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-dco_multi_get_localaddr(struct multi_context *m, struct multi_i=
nstance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_mul=
ti_get_localaddr(const struct multi_context *m, const struct multi_instance=
 *mi,</span><br><span>                         struct sockaddr_storage *loc=
al)</span><br><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><br><sp=
an>@@ -585,7 +585,7 @@</span><br><span>         return false;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct link_socket_actual *actual =3D &amp;c-&gt;c2=2Elink_socket=
_infos[0]-&gt;lsa-&gt;actual;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const struct link_socket_actual *actual =3D &amp;c-&gt;c2=2El=
ink_socket_infos[0]-&gt;lsa-&gt;actual;</span><br><span> </span><br><span> =
    switch (actual-&gt;dest=2Eaddr=2Esa=2Esa_family)</span><br><span>     {=
</span><br><span>@@ -623,7 +623,7 @@</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dc=
o_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_add_new_peer=
(const struct multi_context *m, struct multi_instance *mi)</span><br><span>=
 {</span><br><span>     const struct context *c =3D &amp;mi-&gt;context;</s=
pan><br><span> </span><br><span>@@ -677,7 +677,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-dco_install_iroute(struct multi_context *m, struct multi_inst=
ance *mi, struct mroute_addr *addr)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+dco_install_iroute(struct multi_context *m, struct multi_in=
stance *mi, const struct mroute_addr *addr)</span><br><span> {</span><br><s=
pan> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32=
)</span><br><span>     if (!dco_enabled(&amp;m-&gt;top=2Eoptions))</span><b=
r><span>@@ -796,7 +796,7 @@</span><br><span>         /* Checked if we added=
 a host route as the assigned client IP address was</span><br><span>       =
   * outside the --ifconfig-ipv6 tun interface config */</span><br><span> #=
if !defined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      struct in6_addr *dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ip=
v6_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst struct in6_addr *dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6=
_local;</span><br><span>         if (multi_check_push_ifconfig_ipv6_extra_r=
oute(mi, dest))</span><br><span>         {</span><br><span>             /* =
On windows we do not install these routes, so we also do not need to delete=
 them */</span><br><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=
=2Eh</span><br><span>index 4e5aad5=2E=2E694875c 100644</span><br><span>--- =
a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><br><=
span>@@ -204,7 +204,7 @@</span><br><span>  * @param mi        the client in=
stance</span><br><span>  * @return          0 on success or a negative erro=
r code otherwise</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-int dco_multi_add_new_peer(struct multi_context *m, struct =
multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+int dco_multi_add_new_peer(const struct multi_context *m, struct multi_ins=
tance *mi);</span><br><span> </span><br><span> /**</span><br><span>  * Inst=
all an iroute in DCO, which means adding a route to the system routing</spa=
n><br><span>@@ -215,7 +215,7 @@</span><br><span>  * @param addr      the ro=
ute to add</span><br><span>  */</span><br><span> void dco_install_iroute(st=
ruct multi_context *m, struct multi_instance *mi,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        struct mroute_addr *add=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        const struct mroute_addr *addr);</span><br><span> </span><br><span>=
 /**</span><br><span>  * Remove all routes added through the specified clie=
nt</span><br><span>@@ -253,7 +253,7 @@</span><br><span>  * a 64 bit packet =
counter and AEAD tag at the end=2E</span><br><span>  */</span><br><span> bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_=
data(struct context *c);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dco_supports_epoch_data(const struct context *c);</span><br><span> #el=
se  /* if defined(ENABLE_DCO) */</span><br><span> </span><br><span> typedef=
 void *dco_context_t;</span><br><span>@@ -350,7 +350,7 @@</span><br><span> =
}</span><br><span> </span><br><span> static inline int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-dco_multi_add_new_peer(struct multi_contex=
t *m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+dco_multi_add_new_peer(const struct multi_context *m, struct m=
ulti_instance *mi)</span><br><span> {</span><br><span>     return 0;</span>=
<br><span> }</span><br><span>@@ -384,7 +384,7 @@</span><br><span> }</span><=
br><span> </span><br><span> static inline bool</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct context *c)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(con=
st struct context *c)</span><br><span> {</span><br><span>     return false;=
</span><br><span> }</span><br><span>diff --git a/src/openvpn/dco_freebsd=2E=
c b/src/openvpn/dco_freebsd=2Ec</span><br><span>index d933aaf=2E=2E7346903 =
100644</span><br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>++=
+ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -930,7 +930,7 @@</span><=
br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct context *c)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_d=
ata(const struct context *c)</span><br><span> {</span><br><span>     return=
 false;</span><br><span> }</span><br><span>diff --git a/src/openvpn/dco_int=
ernal=2Eh b/src/openvpn/dco_internal=2Eh</span><br><span>index fcf8aca=2E=
=2E1022e66 100644</span><br><span>--- a/src/openvpn/dco_internal=2Eh</span>=
<br><span>+++ b/src/openvpn/dco_internal=2Eh</span><br><span>@@ -59,8 +59,9=
 @@</span><br><span>  * They are implemented by dco_linux=2Ec</span><br><sp=
an>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descri=
ptor_t sd, struct sockaddr *localaddr,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                 struct sockaddr *remoteaddr, const struct=
 in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int dco_new_peer(dco_context_t *dco, unsi=
gned int peerid, socket_descriptor_t sd,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                 struct sockaddr *localaddr, struct so=
ckaddr *remoteaddr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                 const struct in_addr *vpn_ipv4, const struct in6_addr *vpn=
_ipv6);</span><br><span> </span><br><span> int dco_del_peer(dco_context_t *=
dco, unsigned int peerid);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index =
56f6259=2E=2E31bbe87 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec=
</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -114,7 =
+114,7 @@</span><br><span> }</span><br><span> </span><br><span> static stru=
ct nl_msg *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_n=
lmsg_create(dco_context_t *dco, uint8_t cmd)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ovpn_dco_nlmsg_create(const dco_context_t *dco, ui=
nt8_t cmd)</span><br><span> {</span><br><span>     struct nl_msg *nl_msg =
=3D nlmsg_alloc();</span><br><span>     if (!nl_msg)</span><br><span>@@ -80=
4,7 +804,7 @@</span><br><span> </span><br><span> /* libnl &lt; 3=2E11=2E0 d=
oes not implement nla_get_uint() */</span><br><span> static uint64_t</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_nla_get_uint(struct nla=
ttr *attr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_nla_=
get_uint(const struct nlattr *attr)</span><br><span> {</span><br><span>    =
 if (nla_len(attr) =3D=3D sizeof(uint32_t))</span><br><span>     {</span><b=
r><span>@@ -916,7 +916,7 @@</span><br><span> }</span><br><span> </span><br>=
<span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovp=
n_iface_check(dco_context_t *dco, struct nlattr *attrs[])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ovpn_iface_check(const dco_context_t =
*dco, struct nlattr *attrs[])</span><br><span> {</span><br><span>     /* we=
 must know which interface this message is referring to in order to</span><=
br><span>      * avoid mixing messages for other instances</span><br><span>=
@@ -1340,7 +1340,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epo=
ch_data(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+dco_supports_epoch_data(const struct context *c)</span><br><span> {<=
/span><br><span>     return false;</span><br><span> }</span><br><span>diff =
--git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>i=
ndex b3268bc=2E=2E8deb9d8 100644</span><br><span>--- a/src/openvpn/dco_win=
=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -1100=
,7 +1100,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(=
struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
co_supports_epoch_data(const struct context *c)</span><br><span> {</span><b=
r><span>     OVPN_VERSION ver =3D { 0 };</span><br><span>     return dco_ge=
t_version(&amp;ver) &amp;&amp; ((ver=2EMajor =3D=3D 2 &amp;&amp; ver=2EMino=
r &gt;=3D 8) || (ver=2EMajor &gt; 2));</span><br><span>diff --git a/src/ope=
nvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec</span><br><span>index 5cdcfcf=2E=2E847=
f7d0 100644</span><br><span>--- a/src/openvpn/dhcp=2Ec</span><br><span>+++ =
b/src/openvpn/dhcp=2Ec</span><br><span>@@ -145,7 +145,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> in_addr_t</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-dhcp_extract_router_msg(struct buffer *ipbuf)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+dhcp_extract_router_msg=
(const struct buffer *ipbuf)</span><br><span> {</span><br><span>     struct=
 dhcp_full *df =3D (struct dhcp_full *)BPTR(ipbuf);</span><br><span>     co=
nst int optlen =3D</span><br><span>diff --git a/src/openvpn/dhcp=2Eh b/src/=
openvpn/dhcp=2Eh</span><br><span>index 38ebf8d=2E=2Eed8a0c9 100644</span><b=
r><span>--- a/src/openvpn/dhcp=2Eh</span><br><span>+++ b/src/openvpn/dhcp=
=2Eh</span><br><span>@@ -91,7 +91,7 @@</span><br><span> </span><br><span> #=
pragma pack()</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-in_addr_t dhcp_extract_router_msg(struct buffer *ipbuf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+in_addr_t dhcp_extract_route=
r_msg(const struct buffer *ipbuf);</span><br><span> </span><br><span> #if d=
efined(_WIN32) || defined(DHCP_UNIT_TEST)</span><br><span> #include &quot;t=
un=2Eh&quot;</span><br><span>diff --git a/src/openvpn/event=2Eh b/src/openv=
pn/event=2Eh</span><br><span>index b784dfe=2E=2E0940a1d 100644</span><br><s=
pan>--- a/src/openvpn/event=2Eh</span><br><span>+++ b/src/openvpn/event=2Eh=
</span><br><span>@@ -204,7 +204,7 @@</span><br><span> #else /* ifdef _WIN32=
 */</span><br><span> </span><br><span> static inline void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-wait_signal(struct event_set *es, void =
*arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wait_signal(co=
nst struct event_set *es, const void *arg)</span><br><span> {</span><br><sp=
an> }</span><br><span> </span><br><span>diff --git a/src/openvpn/forward=2E=
c b/src/openvpn/forward=2Ec</span><br><span>index 6581998=2E=2E4ddac11 1006=
44</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/=
openvpn/forward=2Ec</span><br><span>@@ -231,7 +231,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-parse_incoming_control_channel_command(struct cont=
ext *c, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+parse_incoming_control_channel_command(struct context *c, const str=
uct buffer *buf)</span><br><span> {</span><br><span>     if (buf_string_mat=
ch_head_str(buf, &quot;AUTH_FAILED&quot;))</span><br><span>     {</span><br=
><span>@@ -501,7 +501,7 @@</span><br><span> }</span><br><span> </span><br><=
span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_server_p=
oll_remaining_time(struct event_timeout *server_poll_timeout)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+get_server_poll_remaining_time(co=
nst struct event_timeout *server_poll_timeout)</span><br><span> {</span><br=
><span>     update_time();</span><br><span>     int remaining =3D event_tim=
eout_remaining(server_poll_timeout);</span><br><span>@@ -598,7 +598,7 @@</s=
pan><br><span>  * Buffer reallocation, for use with null encryption=2E</spa=
n><br><span>  */</span><br><span> static inline void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-buffer_turnover(const uint8_t *orig_buf, st=
ruct buffer *dest_stub, struct buffer *src_stub,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+buffer_turnover(const uint8_t *orig_buf, struc=
t buffer *dest_stub, const struct buffer *src_stub,</span><br><span>       =
          struct buffer *storage)</span><br><span> {</span><br><span>     i=
f (orig_buf =3D=3D src_stub-&gt;data &amp;&amp; src_stub-&gt;data !=3D stor=
age-&gt;data)</span><br><span>@@ -885,7 +885,7 @@</span><br><span>  */</spa=
n><br><span> </span><br><span> static inline void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-socks_postprocess_incoming_link(struct context =
*c, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+socks_postprocess_incoming_link(struct context *c, const struct l=
ink_socket *sock)</span><br><span> {</span><br><span>     if (sock-&gt;sock=
s_proxy &amp;&amp; sock-&gt;info=2Eproto =3D=3D PROTO_UDP)</span><br><span>=
     {</span><br><span>@@ -982,7 +982,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-process_incoming_link_part1(struct context *c, struct link_socket_info=
 *lsi, bool floated)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+process_incoming_link_part1(struct context *c, const struct link_socket_in=
fo *lsi, bool floated)</span><br><span> {</span><br><span>     struct gc_ar=
ena gc =3D gc_new();</span><br><span>     bool decrypt_status =3D false;</s=
pan><br><span>@@ -1532,7 +1532,7 @@</span><br><span>  * @param client    De=
termines whether to the send packet back via tun or link</span><br><span>  =
*/</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-ipv6_send_icmp_unreachable(struct context *c, struct buffer *buf, bool c=
lient)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ipv6_send_icm=
p_unreachable(struct context *c, const struct buffer *buf, bool client)</sp=
an><br><span> {</span><br><span> #define MAX_ICMPV6LEN 1280</span><br><span=
>     struct openvpn_icmp6hdr icmp6out;</span><br><span>diff --git a/src/op=
envpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><span>index 324c0b4=
=2E=2Eee7d2e2 100644</span><br><span>--- a/src/openvpn/forward=2Eh</span><b=
r><span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -127,7 +127,7 @@</=
span><br><span>  */</span><br><span> void encrypt_sign(struct context *c, b=
ool comp_frag);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-int get_server_poll_remaining_time(struct event_timeout *server=
_poll_timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int =
get_server_poll_remaining_time(const struct event_timeout *server_poll_time=
out);</span><br><span> </span><br><span> /*********************************=
*************************************/</span><br><span> /**</span><br><span=
>@@ -178,7 +178,7 @@</span><br><span>  *</span><br><span>  * @return true i=
f packet is authenticated, false otherwise=2E</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool process_incoming_link_par=
t1(struct context *c, struct link_socket_info *lsi, bool floated);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool process_incoming_link_p=
art1(struct context *c, const struct link_socket_info *lsi, bool floated);<=
/span><br><span> </span><br><span> /**</span><br><span>  * Continues proces=
sing a packet read from the external network interface=2E</span><br><span>d=
iff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>ind=
ex 1109a13=2E=2Eb020db2 100644</span><br><span>--- a/src/openvpn/init=2Ec</=
span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -803,7 +803,7 =
@@</span><br><span> }</span><br><span> </span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-init_port_share(struct conte=
xt *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_port_sha=
re(const struct context *c)</span><br><span> {</span><br><span>     if (!po=
rt_share &amp;&amp; (c-&gt;options=2Eport_share_host &amp;&amp; c-&gt;optio=
ns=2Eport_share_port))</span><br><span>     {</span><br><span>@@ -1245,7 +1=
245,7 @@</span><br><span>  * prepending to msg() output=2E</span><br><span>=
  */</span><br><span> const char *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-format_common_name(struct context *c, struct gc_arena *gc)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+format_common_name(cons=
t struct context *c, struct gc_arena *gc)</span><br><span> {</span><br><spa=
n>     struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span>     if=
 (c-&gt;c2=2Etls_multi)</span><br><span>@@ -1731,7 +1731,7 @@</span><br><sp=
an> </span><br><span> </span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-can_preserve_tun(struct tuntap *tt)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+can_preserve_tun(const stru=
ct tuntap *tt)</span><br><span> {</span><br><span>     if (tt &amp;&amp; tt=
-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br>=
<span>@@ -1753,7 +1753,7 @@</span><br><span>  * @param c pointer to the con=
nection context</span><br><span>  */</span><br><span> static void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-add_wfp_block(struct context *c=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_wfp_block(cons=
t struct context *c)</span><br><span> {</span><br><span> #if defined(_WIN32=
)</span><br><span>     /* Fortify &#39;redirect-gateway block-local&#39; wi=
th firewall rules? */</span><br><span>@@ -1779,7 +1779,7 @@</span><br><span=
>  * @param adapter_index the VPN adapter index</span><br><span>  */</span>=
<br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-del_wfp_block(struct context *c, unsigned long adapter_index)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+del_wfp_block(const struct conte=
xt *c, unsigned long adapter_index)</span><br><span> {</span><br><span> #if=
 defined(_WIN32)</span><br><span>     if (c-&gt;options=2Eblock_outside_dns=
 || block_local_needed(c-&gt;c1=2Eroute_list))</span><br><span>diff --git a=
/src/openvpn/init=2Eh b/src/openvpn/init=2Eh</span><br><span>index ce8f74e=
=2E=2Ec486158 100644</span><br><span>--- a/src/openvpn/init=2Eh</span><br><=
span>+++ b/src/openvpn/init=2Eh</span><br><span>@@ -91,7 +91,7 @@</span><br=
><span> </span><br><span> uint64_t pull_permission_mask(const struct contex=
t *c);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-const char *format_common_name(struct context *c, struct gc_arena *gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *format_c=
ommon_name(const struct context *c, struct gc_arena *gc);</span><br><span> =
</span><br><span> void reset_coarse_timers(struct context *c);</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/interval=2Eh b/src/openvpn/i=
nterval=2Eh</span><br><span>index 59051bd=2E=2E0cfe202 100644</span><br><sp=
an>--- a/src/openvpn/interval=2Eh</span><br><span>+++ b/src/openvpn/interva=
l=2Eh</span><br><span>@@ -89,7 +89,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> static inline void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-interval_schedule_wakeup(struct interval *top, interval_t *=
wakeup)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+interval_sch=
edule_wakeup(const struct interval *top, interval_t *wakeup)</span><br><spa=
n> {</span><br><span>     const time_t local_now =3D now;</span><br><span> =
    interval_earliest_wakeup(wakeup, top-&gt;last_test_true + top-&gt;refre=
sh, local_now);</span><br><span>@@ -214,7 +214,7 @@</span><br><span>  * Thi=
s function does not check if the timeout is actually valid=2E</span><br><sp=
an>  */</span><br><span> static inline interval_t</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-event_timeout_remaining(struct event_timeout *e=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+event_timeout_rem=
aining(const struct event_timeout *et)</span><br><span> {</span><br><span> =
    return (interval_t)((et-&gt;last + et-&gt;n) - now);</span><br><span> }=
</span><br><span>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</=
span><br><span>index e51dcd0=2E=2Edcd59d7 100644</span><br><span>--- a/src/=
openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</span><br><span=
>@@ -164,7 +164,7 @@</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_remove_by_va=
lue(struct hash *hash, void *value)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+hash_remove_by_value(struct hash *hash, const void *value)<=
/span><br><span> {</span><br><span>     struct hash_iterator hi;</span><br>=
<span>     const struct hash_element *he;</span><br><span>diff --git a/src/=
openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>index 55bc3c8=2E=2E=
23267d0 100644</span><br><span>--- a/src/openvpn/list=2Eh</span><br><span>+=
++ b/src/openvpn/list=2Eh</span><br><span>@@ -78,7 +78,7 @@</span><br><span=
> </span><br><span> bool hash_remove_fast(struct hash *hash, struct hash_bu=
cket *bucket, const void *key, uint64_t hv);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void hash_remove_by_value(struct h=
ash *hash, void *value);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void hash_remove_by_value(struct hash *hash, const void *value);</span=
><br><span> </span><br><span> struct hash_iterator</span><br><span> {</span=
><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</sp=
an><br><span>index 604bbcd=2E=2E17abfd8 100644</span><br><span>--- a/src/op=
envpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><sp=
an>@@ -330,7 +330,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_dele=
te_unix_socket(struct management *man)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+man_delete_unix_socket(const struct management *man)</sp=
an><br><span> {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span>    =
 if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT))=
 =3D=3D MF_UNIX_SOCK)</span><br><span>@@ -675,7 +675,7 @@</span><br><span> =
 * for the log and echo commands=2E</span><br><span>  */</span><br><span> s=
tatic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_history=
(struct management *man, const char *parm, const char *type, struct log_his=
tory *log,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_histo=
ry(struct management *man, const char *parm, const char *type, const struct=
 log_history *log,</span><br><span>             bool *realtime, const unsig=
ned int lep_flags)</span><br><span> {</span><br><span>     struct gc_arena =
gc =3D gc_new();</span><br><span>@@ -843,7 +843,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-man_forget_passwords(struct management *man)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+man_forget_passwords(const s=
truct management *man)</span><br><span> {</span><br><span>     ssl_purge_au=
th(false);</span><br><span>     (void)ssl_clean_auth_token();</span><br><sp=
an>@@ -851,7 +851,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_net(=
struct management *man)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+man_net(const struct management *man)</span><br><span> {</span><br><spa=
n>     if (man-&gt;persist=2Ecallback=2Eshow_net)</span><br><span>     {</s=
pan><br><span>@@ -887,7 +887,7 @@</span><br><span> #ifdef ENABLE_PKCS11</sp=
an><br><span> </span><br><span> static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-man_pkcs11_id_count(struct management *man)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+man_pkcs11_id_count(const str=
uct management *man)</span><br><span> {</span><br><span>     msg(M_CLIENT, =
&quot;&gt;PKCS11ID-COUNT:%d&quot;, pkcs11_management_id_count());</span><br=
><span> }</span><br><span>@@ -1350,7 +1350,7 @@</span><br><span>  * @return=
          Return whether p has n (or at least n) parameters</span><br><span=
>  */</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-man_need(struct management *man, const char **p, const int n, =
unsigned int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
man_need(const struct management *man, const char **p, const int n, unsigne=
d int flags)</span><br><span> {</span><br><span>     int i;</span><br><span=
>     ASSERT(p[0]);</span><br><span>@@ -2365,7 +2365,7 @@</span><br><span> =
 * the route/ifconfig/open tun command=2E   See doc/android=2Etxt for detai=
ls=2E</span><br><span>  */</span><br><span> bool</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-management_android_control(struct management *ma=
n, const char *command, const char *msg)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+management_android_control(const struct management *ma=
n, const char *command, const char *msg)</span><br><span> {</span><br><span=
>     if (!man)</span><br><span>     {</span><br><span>@@ -3013,7 +3013,7 @=
@</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-management_up_down(struct management=
 *man, const char *updown, const struct env_set *es)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+management_up_down(const struct managemen=
t *man, const char *updown, const struct env_set *es)</span><br><span> {</s=
pan><br><span>     if (man-&gt;settings=2Eflags &amp; MF_UP_DOWN)</span><br=
><span>     {</span><br><span>@@ -3023,13 +3023,13 @@</span><br><span> }</s=
pan><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-management_notify(struct management *man, const char *sever=
ity, const char *type, const char *text)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+management_notify(const struct management *man, const =
char *severity, const char *type, const char *text)</span><br><span> {</spa=
n><br><span>     msg(M_CLIENT, &quot;&gt;NOTIFY:%s,%s,%s&quot;, severity, t=
ype, text);</span><br><span> }</span><br><span> </span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-management_notify_generic(=
struct management *man, const char *str)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+management_notify_generic(const struct management *man=
, const char *str)</span><br><span> {</span><br><span>     msg(M_CLIENT, &q=
uot;%s&quot;, str);</span><br><span> }</span><br><span>@@ -3115,7 +3115,8 @=
@</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-management_notify_client_close(struc=
t management *management, struct man_def_auth_context *mdac,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+management_notify_client_close(con=
st struct management *management,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                               struct man_def_auth_context *m=
dac,</span><br><span>                                const struct env_set *=
es)</span><br><span> {</span><br><span>     if ((mdac-&gt;flags &amp; DAF_I=
NITIAL_AUTH) &amp;&amp; !(mdac-&gt;flags &amp; DAF_CONNECTION_CLOSED))</spa=
n><br><span>@@ -3206,7 +3207,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mana=
gement_auth_failure(struct management *man, const char *type, const char *r=
eason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_au=
th_failure(const struct management *man, const char *type, const char *reas=
on)</span><br><span> {</span><br><span>     if (reason)</span><br><span>   =
  {</span><br><span>@@ -3219,7 +3220,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-management_auth_token(struct management *man, const char *token)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+management_auth_token(cons=
t struct management *man, const char *token)</span><br><span> {</span><br><=
span>     msg(M_CLIENT, &quot;&gt;PASSWORD:Auth-Token:%s&quot;, token);</sp=
an><br><span> }</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/o=
penvpn/manage=2Eh</span><br><span>index 27d3b60=2E=2E0d011df 100644</span><=
br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/man=
age=2Eh</span><br><span>@@ -368,7 +368,7 @@</span><br><span>               =
                  const unsigned int flags, const char *static_challenge);<=
/span><br><span> </span><br><span> #ifdef TARGET_ANDROID</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-bool management_android_control(struct m=
anagement *man, const char *command, const char *msg);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool management_android_control(const st=
ruct management *man, const char *command, const char *msg);</span><br><spa=
n> </span><br><span> #define ANDROID_KEEP_OLD_TUN      1</span><br><span> #=
define ANDROID_OPEN_BEFORE_CLOSE 2</span><br><span>@@ -382,12 +382,12 @@</s=
pan><br><span> </span><br><span> void management_event_loop_n_seconds(struc=
t management *man, int sec);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void management_up_down(struct management *man, co=
nst char *updown, const struct env_set *es);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void management_up_down(const struct management *m=
an, const char *updown, const struct env_set *es);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void management_notify(struc=
t management *man, const char *severity, const char *type,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void management_notify(const struct =
management *man, const char *severity, const char *type,</span><br><span>  =
                      const char *text);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void management_notify_generic(struct =
management *man, const char *str);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void management_notify_generic(const struct management *man,=
 const char *str);</span><br><span> </span><br><span> void management_notif=
y_client_needing_auth(struct management *management,</span><br><span>      =
                                      const unsigned int auth_id,</span><br=
><span>@@ -397,7 +397,7 @@</span><br><span> void management_connection_esta=
blished(struct management *management,</span><br><span>                    =
                    struct man_def_auth_context *mdac, const struct env_set=
 *es);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void management_notify_client_close(struct management *management,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void management_notify_cl=
ient_close(const struct management *management,</span><br><span>           =
                          struct man_def_auth_context *mdac, const struct e=
nv_set *es);</span><br><span> </span><br><span> void management_learn_addr(=
struct management *management, struct man_def_auth_context *mdac,</span><br=
><span>@@ -482,12 +482,12 @@</span><br><span>  * OpenVPN calls here to indi=
cate a password failure</span><br><span>  */</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void management_auth_failure(struc=
t management *man, const char *type, const char *reason);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void management_auth_failure(const st=
ruct management *man, const char *type, const char *reason);</span><br><spa=
n> </span><br><span> /*</span><br><span>  * Echo an authentication token to=
 management interface</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void management_auth_token(struct management *man, con=
st char *token);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d management_auth_token(const struct management *man, const char *token);</=
span><br><span> </span><br><span> /*</span><br><span>  * These functions dr=
ive the bytecount in/out counters=2E</span><br><span>diff --git a/src/openv=
pn/mbuf=2Ec b/src/openvpn/mbuf=2Ec</span><br><span>index 7b790ed=2E=2E9a37e=
30 100644</span><br><span>--- a/src/openvpn/mbuf=2Ec</span><br><span>+++ b/=
src/openvpn/mbuf=2Ec</span><br><span>@@ -149,7 +149,7 @@</span><br><span> }=
</span><br><span> </span><br><span> void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-mbuf_dereference_instance(struct mbuf_set *ms, struct mu=
lti_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mb=
uf_dereference_instance(struct mbuf_set *ms, const struct multi_instance *m=
i)</span><br><span> {</span><br><span>     if (ms)</span><br><span>     {</=
span><br><span>diff --git a/src/openvpn/mbuf=2Eh b/src/openvpn/mbuf=2Eh</sp=
an><br><span>index cfe698c=2E=2Ee368054 100644</span><br><span>--- a/src/op=
envpn/mbuf=2Eh</span><br><span>+++ b/src/openvpn/mbuf=2Eh</span><br><span>@=
@ -75,7 +75,7 @@</span><br><span> </span><br><span> bool mbuf_extract_item(=
struct mbuf_set *ms, struct mbuf_item *item);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void mbuf_dereference_instance(st=
ruct mbuf_set *ms, struct multi_instance *mi);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void mbuf_dereference_instance(struct mbuf_set *=
ms, const struct multi_instance *mi);</span><br><span> </span><br><span> st=
atic inline bool</span><br><span> mbuf_defined(const struct mbuf_set *ms)</=
span><br><span>diff --git a/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec</span=
><br><span>index 36bbb43=2E=2Ea7242a8 100644</span><br><span>--- a/src/open=
vpn/mss=2Ec</span><br><span>+++ b/src/openvpn/mss=2Ec</span><br><span>@@ -4=
3,7 +43,7 @@</span><br><span>  *              if yes, hand to mss_fixup_dow=
ork()</span><br><span>  */</span><br><span> void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-mss_fixup_ipv4(struct buffer *buf, uint16_t maxm=
ss)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mss_fixup_ipv4(c=
onst struct buffer *buf, uint16_t maxmss)</span><br><span> {</span><br><spa=
n>     const struct openvpn_iphdr *pip;</span><br><span>     int hlen;</spa=
n><br><span>@@ -80,7 +80,7 @@</span><br><span>  *              (IPv6 header=
 structure is sufficiently different from IPv4=2E=2E=2E)</span><br><span>  =
*/</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-mss_fixup_ipv6(struct buffer *buf, uint16_t maxmss)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+mss_fixup_ipv6(const struct buffer *buf,=
 uint16_t maxmss)</span><br><span> {</span><br><span>     const struct open=
vpn_ipv6hdr *pip6;</span><br><span>     struct buffer newbuf;</span><br><sp=
an>@@ -136,7 +136,7 @@</span><br><span>  */</span><br><span> </span><br><sp=
an> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mss_fixup_dow=
ork(struct buffer *buf, uint16_t maxmss)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+mss_fixup_dowork(const struct buffer *buf, uint16_t ma=
xmss)</span><br><span> {</span><br><span>     int olen, optlen;</span><br><=
span>     uint8_t *opt;</span><br><span>@@ -239,8 +239,8 @@</span><br><span=
> }</span><br><span> </span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-frame_calculate_fragment(struct frame *frame, =
struct key_type *kt, const struct options *options,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                         struct link_socket=
_info *lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+frame_ca=
lculate_fragment(struct frame *frame, const struct key_type *kt, const stru=
ct options *options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                         const struct link_socket_info *lsi)</span><br><sp=
an> {</span><br><span> #if defined(ENABLE_FRAGMENT)</span><br><span>     si=
ze_t overhead;</span><br><span>@@ -269,8 +269,8 @@</span><br><span> }</span=
><br><span> </span><br><span> static void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-frame_calculate_mssfix(struct frame *frame, struct key_=
type *kt, const struct options *options,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                       struct link_socket_info *lsi)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+frame_calculate_mssfix(=
struct frame *frame, const struct key_type *kt, const struct options *optio=
ns,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
       const struct link_socket_info *lsi)</span><br><span> {</span><br><sp=
an>     if (options-&gt;ce=2Emssfix_fixed)</span><br><span>     {</span><br=
><span>@@ -314,8 +314,8 @@</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-frame_calcu=
late_dynamic(struct frame *frame, struct key_type *kt, const struct options=
 *options,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
             struct link_socket_info *lsi)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+frame_calculate_dynamic(struct frame *frame, const s=
truct key_type *kt, const struct options *options,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        const struct link_so=
cket_info *lsi)</span><br><span> {</span><br><span>     if (options-&gt;ce=
=2Efragment &gt; 0)</span><br><span>     {</span><br><span>diff --git a/src=
/openvpn/mss=2Eh b/src/openvpn/mss=2Eh</span><br><span>index 1d092bb=2E=2E6=
b832a2 100644</span><br><span>--- a/src/openvpn/mss=2Eh</span><br><span>+++=
 b/src/openvpn/mss=2Eh</span><br><span>@@ -29,15 +29,15 @@</span><br><span>=
 #include &quot;socket=2Eh&quot;</span><br><span> #include &quot;ssl_common=
=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void mss_fixup_ipv4(const stru=
ct buffer *buf, uint16_t maxmss);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void mss_fixup_ipv6(struct buffer *buf, uin=
t16_t maxmss);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
mss_fixup_ipv6(const struct buffer *buf, uint16_t maxmss);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void mss_fixup_dowor=
k(struct buffer *buf, uint16_t maxmss);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void mss_fixup_dowork(const struct buffer *buf, uint16_=
t maxmss);</span><br><span> </span><br><span> /** Set the --mssfix option=
=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void frame_calc=
ulate_dynamic(struct frame *frame, struct key_type *kt,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                             const struct=
 options *options, struct link_socket_info *lsi);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void frame_calculate_dynamic(struct frame *fr=
ame, const struct key_type *kt,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                             const struct options *options, con=
st struct link_socket_info *lsi);</span><br><span> </span><br><span> /**</s=
pan><br><span>  * Checks and adjusts the fragment and mssfix value accordin=
g to the</span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mt=
cp=2Ec</span><br><span>index 5d88f8a=2E=2E922db3f 100644</span><br><span>--=
- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><=
br><span>@@ -91,7 +91,7 @@</span><br><span> }</span><br><span> </span><br><=
span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_i=
nstance_specific_init(struct multi_context *m, struct multi_instance *mi)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_tcp_instance_sp=
ecific_init(const struct multi_context *m, struct multi_instance *mi)</span=
><br><span> {</span><br><span>     /* buffer for queued TCP socket output p=
ackets */</span><br><span>     mi-&gt;tcp_link_out_deferred =3D mbuf_init(m=
-&gt;top=2Eoptions=2En_bcast_buf);</span><br><span>diff --git a/src/openvpn=
/mtcp=2Eh b/src/openvpn/mtcp=2Eh</span><br><span>index 9b7d1d2=2E=2Ebb117fa=
 100644</span><br><span>--- a/src/openvpn/mtcp=2Eh</span><br><span>+++ b/sr=
c/openvpn/mtcp=2Eh</span><br><span>@@ -35,7 +35,7 @@</span><br><span> </spa=
n><br><span> void multi_tcp_dereference_instance(struct multi_io *multi_io,=
 struct multi_instance *mi);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-bool multi_tcp_instance_specific_init(struct multi=
_context *m, struct multi_instance *mi);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool multi_tcp_instance_specific_init(const struct mul=
ti_context *m, struct multi_instance *mi);</span><br><span> </span><br><spa=
n> void multi_tcp_instance_specific_free(struct multi_instance *mi);</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn=
/mudp=2Ec</span><br><span>index de3d467=2E=2E5e37682 100644</span><br><span=
>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</spa=
n><br><span>@@ -53,8 +53,9 @@</span><br><span>  * @param sock    the socket=
 to send the reply on</span><br><span>  */</span><br><span> static void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-send_standalone_reply(str=
uct multi_context *m, struct buffer *buf, const char *prefix,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                      const char *d=
etail, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+send_standalone_reply(struct multi_context *m, const struct bu=
ffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
             const char *prefix, const char *detail,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      struct link_socket =
*sock)</span><br><span> {</span><br><span>     struct context *c =3D &amp;m=
-&gt;top;</span><br><span> </span><br><span>@@ -74,7 +75,7 @@</span><br><sp=
an> </span><br><span> static void</span><br><span> send_hmac_reset_packet(s=
truct multi_context *m, struct tls_pre_decrypt_state *state,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                       struct tls_au=
th_standalone *tas, struct session_id *sid,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                       const struct tls_auth_standa=
lone *tas, const struct session_id *sid,</span><br><span>                  =
      bool request_resend_wkc, struct link_socket *sock)</span><br><span> {=
</span><br><span>     reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eop=
t=2Epacket_id=2Esend);</span><br><span>@@ -97,11 +98,11 @@</span><br><span>=
 </span><br><span>     enum first_packet_verdict verdict;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_auth_s=
tandalone *tas =3D m-&gt;top=2Ec2=2Etls_auth_standalone;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const struct tls_auth_standalone *=
tas =3D m-&gt;top=2Ec2=2Etls_auth_standalone;</span><br><span> </span><br><=
span>     verdict =3D tls_pre_decrypt_lite(tas, state, &amp;m-&gt;top=2Ec2=
=2Efrom, &amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    uint8_t *hmac_key =3D m-&gt;top=2Ec2=
=2Esession_id_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const uint8_t *hmac_key =3D m-&gt;top=2Ec2=2Esession_id_key;</span><br><=
span>     const struct openvpn_sockaddr *from =3D &amp;m-&gt;top=2Ec2=2Efro=
m=2Edest;</span><br><span>     int handwindow =3D m-&gt;top=2Eoptions=2Ehan=
dshake_window;</span><br><span> </span><br><span>@@ -218,7 +219,7 @@</span>=
<br><span> static struct multi_instance *</span><br><span> handle_connectio=
n_attempt(struct multi_context *m,</span><br><span>                        =
   struct link_socket *sock,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                          struct mroute_addr *real)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                          const stru=
ct mroute_addr *real)</span><br><span> {</span><br><span>     struct hash *=
hash =3D m-&gt;hash;</span><br><span>     struct tls_pre_decrypt_state stat=
e =3D { 0 };</span><br><span>@@ -286,7 +287,7 @@</span><br><span>  * @retur=
n      instance matching the address, NULL otherwise</span><br><span>  */</=
span><br><span> static struct multi_instance *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-multi_get_instance_udp_real(struct multi_context *=
m, struct mroute_addr *real)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+multi_get_instance_udp_real(struct multi_context *m, const struct =
mroute_addr *real)</span><br><span> {</span><br><span>     struct hash *has=
h =3D m-&gt;hash;</span><br><span>     struct hash_element *he;</span><br><=
span>@@ -320,7 +321,9 @@</span><br><span>  * maintaining real address hash =
table atomicity=2E</span><br><span>  */</span><br><span> struct multi_insta=
nce *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_instan=
ce_udp_data(struct multi_context *m, bool *floated, struct mroute_addr *rea=
l, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+multi_get_instance_udp_data(struct multi_context *m, bool *floated=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
          const struct mroute_addr *real,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                            const struct link_socket =
*sock)</span><br><span> {</span><br><span>     struct multi_instance *mi =
=3D NULL;</span><br><span> </span><br><span>diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 46ff1ba=2E=2E0750468 100=
644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/o=
penvpn/multi=2Ec</span><br><span>@@ -57,7 +57,7 @@</span><br><span> </span>=
<br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span> static const char=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-id(struct multi_ins=
tance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+id(const =
struct multi_instance *mi)</span><br><span> {</span><br><span>     if (mi)<=
/span><br><span>     {</span><br><span>@@ -1314,7 +1314,7 @@</span><br><spa=
n>  * same common name=2E</span><br><span>  */</span><br><span> static void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_delete_dup(stru=
ct multi_context *m, struct multi_instance *new_mi)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_delete_dup(struct multi_context *m,=
 const struct multi_instance *new_mi)</span><br><span> {</span><br><span>  =
   if (new_mi)</span><br><span>     {</span><br><span>@@ -2259,7 +2259,7 @@=
</span><br><span> }</span><br><span> </span><br><span> static bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-multi_client_setup_dco_initial=
(struct multi_context *m, struct multi_instance *mi,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_client_setup_dco_initial(const stru=
ct multi_context *m, struct multi_instance *mi,</span><br><span>           =
                     struct gc_arena *gc)</span><br><span> {</span><br><spa=
n>     if (!dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><span>@@ =
-3078,7 +3078,8 @@</span><br><span>  * positive=2E</span><br><span>  */</sp=
an><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-multi_check_dest_addr_allowed(struct multi_context *m, struct multi_ins=
tance *mi, struct mroute_addr *real)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+multi_check_dest_addr_allowed(struct multi_context *m, str=
uct multi_instance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                              const struct mroute_addr *real)</span><br=
><span> {</span><br><span>     struct hash *hash =3D m-&gt;hash;</span><br>=
<span>     const uint64_t hv =3D hash_value(hash, real);</span><br><span>@@=
 -3237,7 +3238,7 @@</span><br><span> </span><br><span> #if defined(ENABLE_D=
CO)</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-process_incoming_del_peer(struct multi_context *m, struct multi_=
instance *mi, dco_context_t *dco)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+process_incoming_del_peer(struct multi_context *m, struct mul=
ti_instance *mi, const dco_context_t *dco)</span><br><span> {</span><br><sp=
an>     const char *reason =3D &quot;ovpn-dco: unknown reason&quot;;</span>=
<br><span>     switch (dco-&gt;dco_del_peer_reason)</span><br><span>@@ -429=
1,7 +4292,7 @@</span><br><span> </span><br><span> /* Searches for the addre=
ss and deletes it if it is owned by the multi_instance */</span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_unle=
arn_addr(struct multi_context *m, struct multi_instance *mi, const struct m=
route_addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mu=
lti_unlearn_addr(struct multi_context *m, const struct multi_instance *mi, =
const struct mroute_addr *addr)</span><br><span> {</span><br><span>     str=
uct hash_element *he;</span><br><span>     const uint64_t hv =3D hash_value=
(m-&gt;vhash, addr);</span><br><span>@@ -4326,7 +4327,7 @@</span><br><span>=
  * @param a     The new IPv4 address in network byte order</span><br><span=
>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-multi_unlearn_in_addr_t(struct multi_context *m, struct multi_=
instance *mi, in_addr_t a)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+multi_unlearn_in_addr_t(struct multi_context *m, const struct multi_=
instance *mi, in_addr_t a)</span><br><span> {</span><br><span>     struct m=
route_addr addr;</span><br><span>     CLEAR(addr);</span><br><span>@@ -4344=
,7 +4345,7 @@</span><br><span>  * @param a6    The new IPv6 address</span><=
br><span>  */</span><br><span> static void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-multi_unlearn_in6_addr(struct multi_context *m, struct=
 multi_instance *mi, struct in6_addr a6)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+multi_unlearn_in6_addr(struct multi_context *m, const =
struct multi_instance *mi, struct in6_addr a6)</span><br><span> {</span><br=
><span>     struct mroute_addr addr;</span><br><span>     CLEAR(addr);</spa=
n><br><span>@@ -4460,7 +4461,7 @@</span><br><span> </span><br><span> bool</=
span><br><span> multi_check_push_ifconfig_ipv6_extra_route(struct multi_ins=
tance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                                struct in6_addr *dest)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
   const struct in6_addr *dest)</span><br><span> {</span><br><span>     con=
st struct options *o =3D &amp;mi-&gt;context=2Eoptions;</span><br><span> </=
span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</=
span><br><span>index 6cb86c7=2E=2E5b8d56a 100644</span><br><span>--- a/src/=
openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><sp=
an>@@ -517,7 +517,7 @@</span><br><span>  */</span><br><span> </span><br><sp=
an> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-set_prefix(struct multi_instance *mi)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+set_prefix(const struct multi_instance *mi)</span><br><s=
pan> {</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>     =
if (mi-&gt;msg_prefix[0])</span><br><span>@@ -691,7 +691,7 @@</span><br><sp=
an>  */</span><br><span> bool</span><br><span> multi_check_push_ifconfig_ip=
v6_extra_route(struct multi_instance *mi,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                           struct in6_a=
ddr *dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                   const struct in6_addr *dest);</span><br>=
<span> </span><br><span> /*</span><br><span>  * Check for signals=2E</span>=
<br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec<=
/span><br><span>index 3604684=2E=2E52eb8c7 100644</span><br><span>--- a/src=
/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span>=
<br><span>@@ -159,7 +159,7 @@</span><br><span>  * a point-to-multipoint tun=
nel=2E</span><br><span>  */</span><br><span> static unsigned int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-p2mp_iow_flags(const struct mult=
i_context *m, struct link_socket *sock)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+p2mp_iow_flags(const struct multi_context *m, const str=
uct link_socket *sock)</span><br><span> {</span><br><span>     unsigned int=
 flags =3D IOW_WAIT_SIGNAL;</span><br><span> </span><br><span>diff --git a/=
src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh</span><br><span>ind=
ex bce0c19=2E=2E25233c8 100644</span><br><span>--- a/src/openvpn/networking=
=2Eh</span><br><span>+++ b/src/openvpn/networking=2Eh</span><br><span>@@ -4=
4,7 +44,7 @@</span><br><span>  */</span><br><span> #if !defined(ENABLE_IPRO=
UTE)</span><br><span> static inline int</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_init(const st=
ruct context *c, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span=
>     (void)c;</span><br><span>     (void)ctx;</span><br><span>@@ -75,7 +75=
,7 @@</span><br><span>  *</span><br><span>  * @return          0 on success=
, a negative error code otherwise</span><br><span>  */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-int net_ctx_init(struct context *c, openvp=
n_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx);</span><br=
><span> </span><br><span> /**</span><br><span>  * Release resources allocat=
ed by the internal garbage collector</span><br><span>@@ -102,7 +102,7 @@</s=
pan><br><span>  * @return          0 on success, negative error code on err=
or</span><br><span>  */</span><br><span> int net_iface_new(openvpn_net_ctx_=
t *ctx, const openvpn_net_iface_t *iface, const char *type,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                  void *arg);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  const voi=
d *arg);</span><br><span> </span><br><span> /**</span><br><span>  * Retriev=
e the interface type</span><br><span>diff --git a/src/openvpn/networking_ip=
route2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span>index a1f3=
525=2E=2Ef091fb3 100644</span><br><span>--- a/src/openvpn/networking_iprout=
e2=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec</span><br>=
<span>@@ -36,7 +36,7 @@</span><br><span> #include &lt;netinet/in=2Eh&gt;</s=
pan><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_init(const struc=
t context *c, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>  =
   ctx-&gt;es =3D NULL;</span><br><span>     if (c)</span><br><span>@@ -61,=
7 +61,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_new(openvpn_net_ct=
x_t *ctx, const char *iface, const char *type, void *arg)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+net_iface_new(openvpn_net_ctx_t *ctx,=
 const char *iface, const char *type, const void *arg)</span><br><span> {</=
span><br><span>     struct argv argv =3D argv_new();</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/net=
working_sitnl=2Ec</span><br><span>index a396255=2E=2E13e0f0b 100644</span><=
br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/o=
penvpn/networking_sitnl=2Ec</span><br><span>@@ -1007,7 +1007,7 @@</span><br=
><span> }</span><br><span> </span><br><span> static int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_del(sa_family_t af_family, con=
st char *iface, inet_address_t *addr, int prefixlen)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_del(sa_family_t af_family, con=
st char *iface, const inet_address_t *addr, int prefixlen)</span><br><span>=
 {</span><br><span>     int ifindex;</span><br><span> </span><br><span>@@ -=
1250,8 +1250,8 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_de=
l(const char *iface, sa_family_t af_family, inet_address_t *dst, int prefix=
len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                i=
net_address_t *gw, uint32_t table, int metric)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+sitnl_route_del(const char *iface, sa_family_t a=
f_family, const inet_address_t *dst, int prefixlen,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                const inet_address_t *gw,=
 uint32_t table, int metric)</span><br><span> {</span><br><span>     int if=
index =3D 0;</span><br><span> </span><br><span>@@ -1328,7 +1328,7 @@</span>=
<br><span> </span><br><span> </span><br><span> int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-net_iface_new(openvpn_net_ctx_t *ctx, const ch=
ar *iface, const char *type, void *arg)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface=
, const char *type, const void *arg)</span><br><span> {</span><br><span>   =
  struct sitnl_link_req req =3D {};</span><br><span>     int ret =3D -1;</s=
pan><br><span>diff --git a/src/openvpn/occ=2Eh b/src/openvpn/occ=2Eh</span>=
<br><span>index bda4f18=2E=2E49def4d 100644</span><br><span>--- a/src/openv=
pn/occ=2Eh</span><br><span>+++ b/src/openvpn/occ=2Eh</span><br><span>@@ -15=
6,7 +156,7 @@</span><br><span>  * via control channel=2E</span><br><span>  =
* @return control channel exit message should be used */</span><br><span> s=
tatic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cc_e=
xit_notify_enabled(struct context *c)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+cc_exit_notify_enabled(const struct context *c)</span><br=
><span> {</span><br><span>     /* Check if we have TLS active at all */</sp=
an><br><span>     if (!c-&gt;c2=2Etls_multi)</span><br><span>diff --git a/s=
rc/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span><br><s=
pan>index 098bdd5=2E=2E1a934db 100644</span><br><span>--- a/src/openvpn/ope=
nssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh</span>=
<br><span>@@ -127,7 +127,7 @@</span><br><span> /* Mimics the functions but =
only when the default context without</span><br><span>  * options is chosen=
 */</span><br><span> static inline const EVP_CIPHER *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-EVP_CIPHER_fetch(void *ctx, const char *alg=
orithm, const char *properties)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+EVP_CIPHER_fetch(const void *ctx, const char *algorithm, const =
char *properties)</span><br><span> {</span><br><span>     ASSERT(!ctx);</sp=
an><br><span>     ASSERT(!properties);</span><br><span>@@ -135,7 +135,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> static inline const E=
VP_MD *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-EVP_MD_fetch(v=
oid *ctx, const char *algorithm, const char *properties)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+EVP_MD_fetch(const void *ctx, const ch=
ar *algorithm, const char *properties)</span><br><span> {</span><br><span> =
    ASSERT(!ctx);</span><br><span>     ASSERT(!properties);</span><br><span=
>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><=
span>index 58dbd28=2E=2E16e2954 100644</span><br><span>--- a/src/openvpn/op=
tions=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ =
-2423,7 +2423,7 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_post=
process_mutate_le(struct connection_entry *ce, struct local_entry *le, int =
mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_postpr=
ocess_mutate_le(const struct connection_entry *ce, struct local_entry *le, =
int mode)</span><br><span> {</span><br><span>     /* use the global port if=
 none is specified */</span><br><span>     if (!le-&gt;port)</span><br><spa=
n>@@ -3576,7 +3576,7 @@</span><br><span> static bool</span><br><span> verif=
y_permission(const char *name, const char *file, int line, const uint64_t t=
ype,</span><br><span>                   const uint64_t allowed, uint64_t *f=
ound, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                  struct options *options, bool is_inline)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  const str=
uct options *options, bool is_inline)</span><br><span> {</span><br><span>  =
   if (!(type &amp; allowed))</span><br><span>     {</span><br><span>@@ -41=
43,7 +4143,7 @@</span><br><span> }</span><br><span> </span><br><span> stati=
c void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_compressio=
n_warning(struct compress_options *info)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+show_compression_warning(const struct compress_options=
 *info)</span><br><span> {</span><br><span>     if (comp_non_stub_enabled(i=
nfo))</span><br><span>     {</span><br><span>diff --git a/src/openvpn/optio=
ns_parse=2Ec b/src/openvpn/options_parse=2Ec</span><br><span>index 88ab4d2=
=2E=2E0e94522 100644</span><br><span>--- a/src/openvpn/options_parse=2Ec</s=
pan><br><span>+++ b/src/openvpn/options_parse=2Ec</span><br><span>@@ -258,7=
 +258,7 @@</span><br><span> }</span><br><span> </span><br><span> static cha=
r *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_inline_file(s=
truct in_src *is, const char *close_tag, int *num_lines, struct gc_arena *g=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_inline_file(=
const struct in_src *is, const char *close_tag, int *num_lines, struct gc_a=
rena *gc)</span><br><span> {</span><br><span>     char line[OPTION_LINE_SIZ=
E];</span><br><span>     struct buffer buf =3D alloc_buf(8 * OPTION_LINE_SI=
ZE);</span><br><span>@@ -302,7 +302,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-check_inline_file(struct in_src *is, char *p[], struct gc_arena *g=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_inline_file=
(const struct in_src *is, char *p[], struct gc_arena *gc)</span><br><span> =
{</span><br><span>     int num_inline_lines =3D 0;</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/otime=2Ec b/src/openvpn/otime=2Ec</span>=
<br><span>index 1608458=2E=2E5d3633c 100644</span><br><span>--- a/src/openv=
pn/otime=2Ec</span><br><span>+++ b/src/openvpn/otime=2Ec</span><br><span>@@=
 -66,7 +66,7 @@</span><br><span> }</span><br><span> </span><br><span> void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-update_now_usec(struct=
 timeval *tv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+update=
_now_usec(const struct timeval *tv)</span><br><span> {</span><br><span>    =
 const time_t last =3D now;</span><br><span>     update_now(tv-&gt;tv_sec);=
</span><br><span>diff --git a/src/openvpn/otime=2Eh b/src/openvpn/otime=2Eh=
</span><br><span>index d14f01e=2E=2E74d21ff 100644</span><br><span>--- a/sr=
c/openvpn/otime=2Eh</span><br><span>+++ b/src/openvpn/otime=2Eh</span><br><=
span>@@ -65,7 +65,7 @@</span><br><span> void update_now(const time_t system=
_time);</span><br><span> </span><br><span> extern time_t now_usec;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void update_now_usec(struct ti=
meval *tv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void upd=
ate_now_usec(const struct timeval *tv);</span><br><span> </span><br><span> =
static inline int</span><br><span> openvpn_gettimeofday(struct timeval *tv,=
 void *tz)</span><br><span>diff --git a/src/openvpn/proto=2Eh b/src/openvpn=
/proto=2Eh</span><br><span>index 3570582=2E=2E33bf4ea 100644</span><br><spa=
n>--- a/src/openvpn/proto=2Eh</span><br><span>+++ b/src/openvpn/proto=2Eh</=
span><br><span>@@ -248,7 +248,7 @@</span><br><span>  * and offset of IP hea=
der (via parameter)=2E</span><br><span>  */</span><br><span> static inline =
int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_tun_ip_ver(int=
 tunnel_type, struct buffer *buf, int *ip_hdr_offset)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+get_tun_ip_ver(int tunnel_type, const str=
uct buffer *buf, int *ip_hdr_offset)</span><br><span> {</span><br><span>   =
  int ip_ver =3D -1;</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index e0700aa=2E=2E5=
e13d1f 100644</span><br><span>--- a/src/openvpn/proxy=2Ec</span><br><span>+=
++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -527,8 +527,9 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-add_proxy_headers(struct http_proxy_info *p=
, socket_descriptor_t sd, /* already open to proxy */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                  const char *host         =
                          /* openvpn server remote */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+add_proxy_headers(const struct http_proxy=
_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
        socket_descriptor_t sd, /* already open to proxy */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                  const char *host =
       /* openvpn server remote */</span><br><span> )</span><br><span> {</s=
pan><br><span>     char buf[512];</span><br><span>@@ -597,8 +598,8 @@</span=
><br><span>                               socket_descriptor_t sd, /* alread=
y open to proxy */</span><br><span>                               const cha=
r *host,       /* openvpn server remote */</span><br><span>                =
               const char *port,       /* openvpn server port */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                              st=
ruct event_timeout *server_poll_timeout, struct buffer *lookahead,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
struct signal_info *sig_info)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                              const struct event_timeout *server_=
poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                        struct buffer *lookahead, struct signal_info *sig_i=
nfo)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new(=
);</span><br><span>     char buf[512];</span><br><span>diff --git a/src/ope=
nvpn/proxy=2Eh b/src/openvpn/proxy=2Eh</span><br><span>index e662e7d=2E=2Ea=
2f4e47 100644</span><br><span>--- a/src/openvpn/proxy=2Eh</span><br><span>+=
++ b/src/openvpn/proxy=2Eh</span><br><span>@@ -89,7 +89,7 @@</span><br><spa=
n>                                    socket_descriptor_t sd, /* already op=
en to proxy */</span><br><span>                                    const ch=
ar *host,       /* openvpn server remote */</span><br><span>               =
                     const char *port,       /* openvpn server port */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
         struct event_timeout *server_poll_timeout,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                   const =
struct event_timeout *server_poll_timeout,</span><br><span>                =
                    struct buffer *lookahead, struct signal_info *sig_info)=
;</span><br><span> </span><br><span> uint8_t *make_base64_string2(const uin=
t8_t *str, int str_len, struct gc_arena *gc);</span><br><span>diff --git a/=
src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index be91a99=2E=2E=
0c91449 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++=
 b/src/openvpn/ps=2Ec</span><br><span>@@ -332,7 +332,7 @@</span><br><span> =
 * the proxy can determine true client origin=2E</span><br><span>  */</span=
><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-journal_add(const char *journal_dir, struct proxy_connection *pc, struct =
proxy_connection *cp)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+journal_add(const char *journal_dir, const struct proxy_connection *pc, s=
truct proxy_connection *cp)</span><br><span> {</span><br><span>     struct =
openvpn_sockaddr from, to;</span><br><span> </span><br><span>@@ -410,7 +410=
,7 @@</span><br><span> static bool</span><br><span> proxy_entry_new(struct =
proxy_connection **list, struct event_set *es,</span><br><span>            =
     const struct openvpn_sockaddr server_addr, const socket_descriptor_t s=
d_client,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    struct buffer *initial_data, const char *journal_dir)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                const struct buffer *=
initial_data, const char *journal_dir)</span><br><span> {</span><br><span> =
    socket_descriptor_t sd_server;</span><br><span>     int status;</span><=
br><span>@@ -1013,7 +1013,7 @@</span><br><span>  * call=2E</span><br><span>=
  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-port_share_redirect(struct port_share *ps, const struct buffer *head, =
socket_descriptor_t sd)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+port_share_redirect(const struct port_share *ps, const struct buffer *h=
ead, socket_descriptor_t sd)</span><br><span> {</span><br><span>     if (ps=
)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/ps=2Eh b/=
src/openvpn/ps=2Eh</span><br><span>index 557ecf5=2E=2E918ceb6 100644</span>=
<br><span>--- a/src/openvpn/ps=2Eh</span><br><span>+++ b/src/openvpn/ps=2Eh=
</span><br><span>@@ -49,7 +49,7 @@</span><br><span> </span><br><span> bool =
is_openvpn_protocol(const struct buffer *buf);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void port_share_redirect(struct =
port_share *ps, const struct buffer *head, socket_descriptor_t sd);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void port_share_redirect(co=
nst struct port_share *ps, const struct buffer *head, socket_descriptor_t s=
d);</span><br><span> </span><br><span> #endif /* if PORT_SHARE */</span><br=
><span> #endif /* ifndef PS_H */</span><br><span>diff --git a/src/openvpn/p=
ush=2Ec b/src/openvpn/push=2Ec</span><br><span>index fa7bf1e=2E=2Ec2c1914 1=
00644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/=
openvpn/push=2Ec</span><br><span>@@ -430,7 +430,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-send_auth_pending_messages(struct tls_multi *tls_multi, stru=
ct tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+send_auth_pending_messages(const struct tls_multi *tls_multi, struct t=
ls_session *session,</span><br><span>                            const char=
 *extra, unsigned int timeout)</span><br><span> {</span><br><span>     stru=
ct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span>diff=
 --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh</span><br><span>index =
dff945f=2E=2E39302f6 100644</span><br><span>--- a/src/openvpn/push=2Eh</spa=
n><br><span>+++ b/src/openvpn/push=2Eh</span><br><span>@@ -117,7 +117,7 @@<=
/span><br><span>  * doc/management-notes=2Etxt under client-pending-auth fo=
r</span><br><span>  * more details on message format</span><br><span>  */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool send_auth_pending_=
messages(struct tls_multi *tls_multi, struct tls_session *session,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool send_auth_pending_messa=
ges(const struct tls_multi *tls_multi, struct tls_session *session,</span><=
br><span>                                 const char *extra, unsigned int t=
imeout);</span><br><span> </span><br><span> void send_restart(struct contex=
t *c, const char *kill_msg);</span><br><span>diff --git a/src/openvpn/push_=
util=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index 0213041=2E=2E7fa=
5987 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span><br><span=
>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@ -222,7 +222,7 @@</span>=
<br><span> </span><br><span> /* Return true if the client supports push-upd=
ate */</span><br><span> static bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-support_push_update(struct multi_instance *mi)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+support_push_update(const struct m=
ulti_instance *mi)</span><br><span> {</span><br><span>     ASSERT(mi-&gt;co=
ntext=2Ec2=2Etls_multi);</span><br><span>     const unsigned int iv_proto_p=
eer =3D extract_iv_proto(mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_info);</s=
pan><br><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=
=2Ec</span><br><span>index ced438e=2E=2Eba819a3 100644</span><br><span>--- =
a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</=
span><br><span>@@ -92,7 +92,7 @@</span><br><span> </span><br><span> /* chec=
k if a particular packet_id is present in ack */</span><br><span> static in=
line bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_ack=
_packet_id_present(struct reliable_ack *ack, packet_id_type pid)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_packet_id_present=
(const struct reliable_ack *ack, packet_id_type pid)</span><br><span> {</sp=
an><br><span>     for (int i =3D 0; i &lt; ack-&gt;len; ++i)</span><br><spa=
n>     {</span><br><span>@@ -391,7 +391,7 @@</span><br><span> }</span><br><=
span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-validate_packet_id_window(struct reliable *rel, packet_id_type pid)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+validate_packet_id_wi=
ndow(const struct reliable *rel, packet_id_type pid)</span><br><span> {</sp=
an><br><span>     return reliable_pid_min(pid, rel-&gt;packet_id)</span><br=
><span>            &amp;&amp; reliable_pid_min(subtract_pid(rel-&gt;packet_=
id, RELIABLE_CAPACITY), pid);</span><br><span>@@ -768,7 +768,7 @@</span><br=
><span>  */</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-reliable_mark_active_incoming(struct reliab=
le *rel, struct buffer *buf, packet_id_type pid,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+reliable_mark_active_incoming(struct reliable =
*rel, const struct buffer *buf, packet_id_type pid,</span><br><span>       =
                        int opcode)</span><br><span> {</span><br><span>    =
 for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>@@ -828,7 +828=
,7 @@</span><br><span> </span><br><span> /* delete a buffer previously acti=
vated by reliable_mark_active() */</span><br><span> void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-reliable_mark_deleted(struct reliable *r=
el, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+reliable_mark_deleted(struct reliable *rel, const struct buffer *buf)</=
span><br><span> {</span><br><span>     for (int i =3D 0; i &lt; rel-&gt;siz=
e; ++i)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/rel=
iable=2Eh b/src/openvpn/reliable=2Eh</span><br><span>index a85f2e9=2E=2E12d=
5367 100644</span><br><span>--- a/src/openvpn/reliable=2Eh</span><br><span>=
+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ -184,7 +184,7 @@</span><b=
r><span>  * @li False, if there are packet IDs to be acknowledged=2E</span>=
<br><span>  */</span><br><span> static inline bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-reliable_ack_empty(struct reliable_ack *ack)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_empty(co=
nst struct reliable_ack *ack)</span><br><span> {</span><br><span>     retur=
n !ack-&gt;len;</span><br><span> }</span><br><span>@@ -198,7 +198,7 @@</spa=
n><br><span>  * included in the valid range=2E</span><br><span>  */</span><=
br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-validate=
_packet_id_window(struct reliable *rel, packet_id_type pid);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+validate_packet_id_window(const st=
ruct reliable *rel, packet_id_type pid);</span><br><span> </span><br><span>=
 /**</span><br><span>  * Returns the number of packets that need to be acke=
d=2E</span><br><span>@@ -208,7 +208,7 @@</span><br><span>  * @returns the n=
umber of outstanding acks</span><br><span>  */</span><br><span> static inli=
ne int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_ack_ou=
tstanding(struct reliable_ack *ack)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+reliable_ack_outstanding(const struct reliable_ack *ack)</s=
pan><br><span> {</span><br><span>     return ack-&gt;len;</span><br><span> =
}</span><br><span>@@ -358,7 +358,7 @@</span><br><span>  * @param pid The pa=
cket&#39;s packet ID=2E</span><br><span>  * @param opcode The packet&#39;s =
opcode=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void reliable_mark_active_incoming(struct reliable *rel, struct bu=
ffer *buf, packet_id_type pid,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void reliable_mark_active_incoming(struct reliable *rel, const s=
truct buffer *buf, packet_id_type pid,</span><br><span>                    =
                int opcode);</span><br><span> </span><br><span> /**</span><=
br><span>@@ -411,7 +411,7 @@</span><br><span>  * @param rel The reliable st=
ructure associated with the given buffer=2E</span><br><span>  * @param buf =
The buffer of the reliable entry which is to be removed=2E</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void reliable_mar=
k_deleted(struct reliable *rel, struct buffer *buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void reliable_mark_deleted(struct reliabl=
e *rel, const struct buffer *buf);</span><br><span> </span><br><span> /** @=
} name Functions for extracting incoming packets */</span><br><span> </span=
><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span=
><br><span>index 03a2526=2E=2E078bb7e 100644</span><br><span>--- a/src/open=
vpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@=
@ -898,8 +898,9 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_bypass_r=
outes(struct route_bypass *rb, in_addr_t gateway, const struct tuntap *tt,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  unsi=
gned int flags, const struct route_gateway_info *rgi,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+add_bypass_routes(const struct route_bypa=
ss *rb, in_addr_t gateway,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                  const struct tuntap *tt, unsigned int flags,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                  const s=
truct route_gateway_info *rgi,</span><br><span>                   const str=
uct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span=
>     int ret =3D true;</span><br><span>@@ -916,8 +917,9 @@</span><br><span=
> }</span><br><span> </span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-del_bypass_routes(struct route_bypass *rb, in_=
addr_t gateway, const struct tuntap *tt,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                  unsigned int flags, const struct route=
_gateway_info *rgi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
del_bypass_routes(const struct route_bypass *rb, in_addr_t gateway,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  const str=
uct tuntap *tt, unsigned int flags,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                  const struct route_gateway_info *rgi,</sp=
an><br><span>                   const struct env_set *es, openvpn_net_ctx_t=
 *ctx)</span><br><span> {</span><br><span>     int i;</span><br><span>@@ -3=
942,7 +3944,7 @@</span><br><span> #else  /* if defined(_WIN32) */</span><br=
><span> </span><br><span> static void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-get_bypass_addresses(struct route_bypass *rb, const unsigne=
d int flags) /* PLATFORM-SPECIFIC */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+get_bypass_addresses(struct route_bypass *rb, const unsign=
ed int flags)</span><br><span> {</span><br><span> }</span><br><span> </span=
><br><span>diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec=
</span><br><span>index 6772ad6=2E=2E694f4d1 100644</span><br><span>--- a/sr=
c/openvpn/schedule=2Ec</span><br><span>+++ b/src/openvpn/schedule=2Ec</span=
><br><span>@@ -389,4 +389,4 @@</span><br><span> {</span><br><span>     s-&g=
t;earliest_wakeup =3D NULL; /* invalidate cache */</span><br><span>     sch=
edule_remove_node(s, e);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span>\ No newline at end of file</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/soc=
ket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index e06c379=2E=2E52829a3=
 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/=
src/openvpn/socket=2Ec</span><br><span>@@ -619,7 +619,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> static void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-bind_local(struct link_socket *sock)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bind_local(const struct link_s=
ocket *sock)</span><br><span> {</span><br><span>     /* bind to local addre=
ss/port */</span><br><span>     if (sock-&gt;bind_local)</span><br><span>@@=
 -878,8 +878,8 @@</span><br><span> }</span><br><span> </span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket_bind(socket_d=
escriptor_t sd, struct addrinfo *local, int ai_family, const char *prefix,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            bool ipv6o=
nly)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_bind(soc=
ket_descriptor_t sd, const struct addrinfo *local, int ai_family,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            const char *prefi=
x, bool ipv6only)</span><br><span> {</span><br><span>     struct gc_arena g=
c =3D gc_new();</span><br><span> </span><br><span>@@ -1087,8 +1087,8 @@</sp=
an><br><span>  * such as TCP=2E</span><br><span>  */</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static void stream_buf_ini=
t(struct stream_buf *sb, struct buffer *buf, const unsigned int sockflags,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
      const int proto);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void stream_buf_init(struct stream_buf *sb, const struct buffer =
*buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
              const unsigned int sockflags, const int proto);</span><br><sp=
an> </span><br><span> static void stream_buf_close(struct stream_buf *sb);<=
/span><br><span> </span><br><span>@@ -1441,7 +1441,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-phase2_set_socket_flags(struct link_socket *sock)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+phase2_set_socket_fl=
ags(const struct link_socket *sock)</span><br><span> {</span><br><span>    =
 /* TCP_NODELAY is enabled by default on every TCP socket; dco-win is</span=
><br><span>      * skipped as it manages its own socket */</span><br><span>=
@@ -2037,7 +2037,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stream_bu=
f_init(struct stream_buf *sb, struct buffer *buf, const unsigned int sockfl=
ags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stream_buf_init=
(struct stream_buf *sb, const struct buffer *buf, const unsigned int sockfl=
ags,</span><br><span>                 const int proto)</span><br><span> {</=
span><br><span>     sb-&gt;buf_init =3D *buf;</span><br><span>@@ -2303,7 +2=
303,7 @@</span><br><span> #endif</span><br><span> </span><br><span> static =
ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_re=
ad_udp_posix_recvmsg(struct link_socket *sock, struct buffer *buf,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_read_udp_posix_r=
ecvmsg(const struct link_socket *sock, struct buffer *buf,</span><br><span>=
                                    struct link_socket_actual *from, sockle=
n_t *fromlen)</span><br><span> {</span><br><span>     struct iovec iov;</sp=
an><br><span>@@ -2375,7 +2375,7 @@</span><br><span> #endif /* if ENABLE_IP_=
PKTINFO */</span><br><span> </span><br><span> ssize_t</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-link_socket_read_udp_posix(struct link_sock=
et *sock, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+link_socket_read_udp_posix(const struct link_socket *sock, struct=
 buffer *buf,</span><br><span>                            struct link_socke=
t_actual *from)</span><br><span> {</span><br><span>     ssize_t recvlen;</s=
pan><br><span>@@ -2438,7 +2438,7 @@</span><br><span> #if ENABLE_IP_PKTINFO<=
/span><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-link_socket_write_udp_posix_sendmsg(struct link_socket=
 *sock, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+link_socket_write_udp_posix_sendmsg(const struct link_socket *sock,=
 const struct buffer *buf,</span><br><span>                                =
     struct link_socket_actual *to)</span><br><span> {</span><br><span>    =
 struct iovec iov;</span><br><span>@@ -2632,7 +2632,7 @@</span><br><span> }=
</span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-socket_send_queue(struct link_socket *sock, struct buffer=
 *buf, const struct link_socket_actual *to)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+socket_send_queue(struct link_socket *sock, const s=
truct buffer *buf, const struct link_socket_actual *to)</span><br><span> {<=
/span><br><span>     if (sock-&gt;writes=2Eiostate =3D=3D IOSTATE_INITIAL)<=
/span><br><span>     {</span><br><span>@@ -2732,8 +2732,8 @@</span><br><spa=
n>     return sock-&gt;writes=2Eiostate;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-read_sockaddr_from_overlapped(struct=
 overlapped_io *io, struct sockaddr *dst, int overlapped_ret)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+read_sockaddr_from_overlapped(const struc=
t overlapped_io *io, struct sockaddr *dst, int overlapped_ret)</span><br><s=
pan> {</span><br><span>     if (overlapped_ret &gt;=3D 0 &amp;&amp; io-&gt;=
addr_defined)</span><br><span>     {</span><br><span>diff --git a/src/openv=
pn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 89465bc=2E=2Ec=
6bcd86 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>=
+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -268,7 +268,7 @@</span><br>=
<span> </span><br><span> int socket_recv_queue(struct link_socket *sock, in=
t maxsize);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-int socket_send_queue(struct link_socket *sock, struct buffer *buf,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int socket_send_que=
ue(struct link_socket *sock, const struct buffer *buf,</span><br><span>    =
                   const struct link_socket_actual *to);</span><br><span> <=
/span><br><span> typedef struct</span><br><span>@@ -348,8 +348,8 @@</span><=
br><span> </span><br><span> struct link_socket *link_socket_new(void);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void soc=
ket_bind(socket_descriptor_t sd, struct addrinfo *local, int af_family, con=
st char *prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
            bool ipv6only);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void socket_bind(socket_descriptor_t sd, const struct addrinfo *loc=
al, int af_family,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                const char *prefix, bool ipv6only);</span><br><span> </span=
><br><span> int openvpn_connect(socket_descriptor_t sd, const struct sockad=
dr *remote, int connect_timeout,</span><br><span>                     volat=
ile int *signal_received);</span><br><span>@@ -483,7 +483,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static inline bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-link_socket_verify_incoming_addr(str=
uct buffer *buf, const struct link_socket_info *info,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+link_socket_verify_incoming_addr(const st=
ruct buffer *buf, const struct link_socket_info *info,</span><br><span>    =
                              const struct link_socket_actual *from_addr)</=
span><br><span> {</span><br><span>     if (buf-&gt;len &gt; 0)</span><br><s=
pan>@@ -607,7 +607,7 @@</span><br><span> </span><br><span> #else  /* ifdef =
_WIN32 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-ssize_t link_socket_read_udp_posix(struct link_socket *sock, struct b=
uffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t =
link_socket_read_udp_posix(const struct link_socket *sock, struct buffer *b=
uf,</span><br><span>                                    struct link_socket_=
actual *from);</span><br><span> </span><br><span> #endif /* ifdef _WIN32 */=
</span><br><span>@@ -693,12 +693,12 @@</span><br><span> </span><br><span> #=
else /* ifdef _WIN32 */</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-ssize_t link_socket_write_udp_posix_sendmsg(struct link=
_socket *sock, struct buffer *buf,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ssize_t link_socket_write_udp_posix_sendmsg(const struct lin=
k_socket *sock, const struct buffer *buf,</span><br><span>                 =
                            struct link_socket_actual *to);</span><br><span=
> </span><br><span> </span><br><span> static inline ssize_t</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_udp_posix(struct li=
nk_socket *sock, struct buffer *buf,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+link_socket_write_udp_posix(const struct link_socket *sock=
, const struct buffer *buf,</span><br><span>                             st=
ruct link_socket_actual *to)</span><br><span> {</span><br><span> #if ENABLE=
_IP_PKTINFO</span><br><span>@@ -714,7 +714,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> static inline ssize_t</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-link_socket_write_tcp_posix(struct link_socket *=
sock, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+link_socket_write_tcp_posix(const struct link_socket *sock, const str=
uct buffer *buf)</span><br><span> {</span><br><span>     return send(sock-&=
gt;sd, BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);</span><br><span> }</span><br><=
span>@@ -772,7 +772,7 @@</span><br><span>  * from tunnel packet=2E</span><b=
r><span>  */</span><br><span> static inline void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-link_socket_set_tos(struct link_socket *sock)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_set_tos(co=
nst struct link_socket *sock)</span><br><span> {</span><br><span>     if (s=
ock &amp;&amp; sock-&gt;ptos_defined)</span><br><span>     {</span><br><spa=
n>@@ -818,6 +818,8 @@</span><br><span>     }</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* cppcheck-s=
uppress constParameterPointer</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * sock is modified on Windows via &amp;sock-&gt;listen_handle */=
</span><br><span> static inline void</span><br><span> socket_reset_listen_p=
ersistent(struct link_socket *sock)</span><br><span> {</span><br><span>diff=
 --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh</span><b=
r><span>index 13f5962=2E=2Eadd08ba 100644</span><br><span>--- a/src/openvpn=
/socket_util=2Eh</span><br><span>+++ b/src/openvpn/socket_util=2Eh</span><b=
r><span>@@ -439,7 +439,7 @@</span><br><span> </span><br><span> </span><br><=
span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-addrlist_match_proto(const struct openvpn_sockaddr *a1, struct addrinfo =
*addr_list, const int proto)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+addrlist_match_proto(const struct openvpn_sockaddr *a1, const stru=
ct addrinfo *addr_list, const int proto)</span><br><span> {</span><br><span=
>     return link_socket_proto_connection_oriented(proto) ? addrlist_match(=
a1, addr_list)</span><br><span>                                            =
             : addrlist_port_match(a1, addr_list);</span><br><span>diff --g=
it a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span>index 19=
f3d54=2E=2E77ca863 100644</span><br><span>--- a/src/openvpn/socks=2Ec</span=
><br><span>+++ b/src/openvpn/socks=2Ec</span><br><span>@@ -82,7 +82,7 @@</s=
pan><br><span> </span><br><span> static bool</span><br><span> socks_proxy_r=
ecv_char(uint8_t *c, const char *name, socket_descriptor_t sd,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                      struct event=
_timeout *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                      const struct event_timeout *server_poll_ti=
meout,</span><br><span>                       volatile int *signal_received=
)</span><br><span> {</span><br><span>     fd_set reads;</span><br><span>@@ =
-97,8 +97,8 @@</span><br><span> }</span><br><span> </span><br><span> static=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_username_p=
assword_auth(struct socks_proxy_info *p, socket_descriptor_t sd,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                             str=
uct event_timeout *server_poll_timeout,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+socks_username_password_auth(const struct socks_proxy_i=
nfo *p, socket_descriptor_t sd,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                             const struct event_timeout *server=
_poll_timeout,</span><br><span>                              volatile int *=
signal_received)</span><br><span> {</span><br><span>     char to_send[516];=
</span><br><span>@@ -156,8 +156,8 @@</span><br><span> }</span><br><span> </=
span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-socks_handshake(struct socks_proxy_info *p, socket_descriptor_t sd,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                struct =
event_timeout *server_poll_timeout, volatile int *signal_received)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+socks_handshake(const struct=
 socks_proxy_info *p, socket_descriptor_t sd,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                const struct event_timeout *serve=
r_poll_timeout, volatile int *signal_received)</span><br><span> {</span><br=
><span>     uint8_t buf[2];</span><br><span>     int len =3D 0;</span><br><=
span>@@ -231,7 +231,7 @@</span><br><span> </span><br><span> static bool</sp=
an><br><span> recv_socks_reply(socket_descriptor_t sd, struct openvpn_socka=
ddr *addr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
      struct event_timeout *server_poll_timeout, volatile int *signal_recei=
ved)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  const struct event_timeout *server_poll_timeout, volatile int *signal_rec=
eived)</span><br><span> {</span><br><span>     uint8_t atyp =3D 0;</span><b=
r><span>     int alen =3D 0;</span><br><span>@@ -334,11 +334,11 @@</span><b=
r><span> }</span><br><span> </span><br><span> void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-establish_socks_proxy_passthru(struct socks_pr=
oxy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+establi=
sh_socks_proxy_passthru(const struct socks_proxy_info *p,</span><br><span> =
                               socket_descriptor_t sd, /* already open to p=
roxy */</span><br><span>                                const char *host,  =
     /* openvpn server remote */</span><br><span>                          =
      const char *servname,   /* openvpn server port */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                               struct eve=
nt_timeout *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                               const struct event_timeout *ser=
ver_poll_timeout,</span><br><span>                                struct si=
gnal_info *sig_info)</span><br><span> {</span><br><span>     char buf[270];=
</span><br><span>@@ -392,10 +392,10 @@</span><br><span> }</span><br><span> =
</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-establish_socks_proxy_udpassoc(struct socks_proxy_info *p,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+establish_socks_proxy_udpassoc(cons=
t struct socks_proxy_info *p,</span><br><span>                             =
   socket_descriptor_t ctrl_sd, /* already open to proxy */</span><br><span=
>                                struct openvpn_sockaddr *relay_addr,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
    struct event_timeout *server_poll_timeout,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                               const struct even=
t_timeout *server_poll_timeout,</span><br><span>                           =
     struct signal_info *sig_info)</span><br><span> {</span><br><span>     =
if (!socks_handshake(p, ctrl_sd, server_poll_timeout, &amp;sig_info-&gt;sig=
nal_received))</span><br><span>diff --git a/src/openvpn/socks=2Eh b/src/ope=
nvpn/socks=2Eh</span><br><span>index 846113d=2E=2Ef7c93b6 100644</span><br>=
<span>--- a/src/openvpn/socks=2Eh</span><br><span>+++ b/src/openvpn/socks=
=2Eh</span><br><span>@@ -47,17 +47,17 @@</span><br><span> </span><br><span>=
 void socks_proxy_close(struct socks_proxy_info *sp);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void establish_socks_prox=
y_passthru(struct socks_proxy_info *p,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void establish_socks_proxy_passthru(const struct socks_p=
roxy_info *p,</span><br><span>                                     socket_d=
escriptor_t sd, /* already open to proxy */</span><br><span>               =
                      const char *host,       /* openvpn server remote */</=
span><br><span>                                     const char *servname,  =
 /* openvpn server port */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                    struct event_timeout *server_poll_=
timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                         const struct event_timeout *server_poll_timeout,</=
span><br><span>                                     struct signal_info *sig=
_info);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-void establish_socks_proxy_udpassoc(struct socks_proxy_info *p,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void establish_socks_proxy_=
udpassoc(const struct socks_proxy_info *p,</span><br><span>                =
                     socket_descriptor_t ctrl_sd, /* already open to proxy =
*/</span><br><span>                                     struct openvpn_sock=
addr *relay_addr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                                struct event_timeout *server_poll_timeout,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                const struct event_timeout *server_poll_timeout,</span><br>=
<span>                                     struct signal_info *sig_info);</=
span><br><span> </span><br><span> void socks_process_incoming_udp(struct bu=
ffer *buf, struct link_socket_actual *from);</span><br><span>diff --git a/s=
rc/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 71459ee=2E=
=2E5cc2b1b 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span=
>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1171,7 +1171,7 @@</span><br>=
<span> }</span><br><span> </span><br><span> struct tls_multi *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-tls_multi_init(struct tls_options =
*tls_options)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_mu=
lti_init(const struct tls_options *tls_options)</span><br><span> {</span><b=
r><span>     struct tls_multi *ret;</span><br><span> </span><br><span>@@ -1=
212,7 +1212,7 @@</span><br><span>  */</span><br><span> </span><br><span> st=
ruct tls_auth_standalone *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-tls_auth_standalone_init(struct tls_options *tls_options, struct gc_ar=
ena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_auth_st=
andalone_init(const struct tls_options *tls_options, struct gc_arena *gc)</=
span><br><span> {</span><br><span>     struct tls_auth_standalone *tas;</sp=
an><br><span> </span><br><span>@@ -1360,7 +1360,7 @@</span><br><span> </spa=
n><br><span> static void</span><br><span> init_epoch_keys(struct key_state =
*ks, struct tls_multi *multi, const struct key_type *key_type,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                bool server, struc=
t key2 *key2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          bool server, const struct key2 *key2)</span><br><span> {</span><b=
r><span>     /* For now we hardcode this to be 4 for the software based dat=
a channel</span><br><span>      * DCO based implementations/HW implementati=
on might adjust this number</span><br><span>@@ -1403,7 +1403,7 @@</span><br=
><span> </span><br><span> static void</span><br><span> init_key_contexts(st=
ruct key_state *ks, struct tls_multi *multi, const struct key_type *key_typ=
e,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  b=
ool server, struct key2 *key2, bool dco_enabled)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                  bool server, const struct ke=
y2 *key2, bool dco_enabled)</span><br><span> {</span><br><span>     struct =
key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=2Ekey_ctx_bi;</span><br><spa=
n> </span><br><span>@@ -1601,8 +1601,9 @@</span><br><span> </span><br><span=
> bool</span><br><span> tls_session_update_crypto_params_do_work(struct tls=
_multi *multi, struct tls_session *session,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                         struct optio=
ns *options, struct frame *frame,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                         struct frame *frame_fr=
agment, struct link_socket_info *lsi,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                         const struct opt=
ions *options, struct frame *frame,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                         struct frame *fram=
e_fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                 const struct link_socket_info *lsi,</span>=
<br><span>                                          dco_context_t *dco)</sp=
an><br><span> {</span><br><span>     if (session-&gt;key[KS_PRIMARY]=2Ecryp=
to_options=2Ekey_ctx_bi=2Einitialized)</span><br><span>@@ -1671,7 +1672,7 @=
@</span><br><span> bool</span><br><span> tls_session_update_crypto_params(s=
truct tls_multi *multi, struct tls_session *session,</span><br><span>      =
                            struct options *options, struct frame *frame,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
          struct frame *frame_fragment, struct link_socket_info *lsi,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
        struct frame *frame_fragment, const struct link_socket_info *lsi,</=
span><br><span>                                  dco_context_t *dco)</span>=
<br><span> {</span><br><span>     if (!check_session_cipher(session, option=
s))</span><br><span>@@ -1887,7 +1888,8 @@</span><br><span> }</span><br><spa=
n> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-push_peer_info_peerid(struct buffer *out, struct tls_multi *mult=
i, struct tls_session *session)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+push_peer_info_peerid(struct buffer *out, const struct tls_mult=
i *multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
            const struct tls_session *session)</span><br><span> {</span><br=
><span>     if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID || session-&gt;opt-=
&gt;dco_enabled)</span><br><span>     {</span><br><span>@@ -1922,7 +1924,7 =
@@</span><br><span>  * @return          true if no error was encountered</s=
pan><br><span>  */</span><br><span> static bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-push_peer_info(struct buffer *buf, struct tls_mul=
ti *multi, struct tls_session *session)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+push_peer_info(struct buffer *buf, const struct tls_mul=
ti *multi, struct tls_session *session)</span><br><span> {</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span>     bool ret =3D fal=
se;</span><br><span>@@ -2566,8 +2568,8 @@</span><br><span> }</span><br><spa=
n> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-session_skip_to_pre_start(struct tls_session *session, struct tls_pre_d=
ecrypt_state *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                         struct link_socket_actual *from)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+session_skip_to_pre_start(struct tls_=
session *session, const struct tls_pre_decrypt_state *state,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                          const st=
ruct link_socket_actual *from)</span><br><span> {</span><br><span>     stru=
ct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span>    =
 ks-&gt;session_id_remote =3D state-&gt;peer_session_id;</span><br><span>@@=
 -2785,7 +2787,7 @@</span><br><span> </span><br><span> static bool</span><b=
r><span> check_outgoing_ciphertext(struct key_state *ks, struct tls_session=
 *session,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
               struct buffer *to_link, bool *continue_tls_process)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                          co=
nst struct buffer *to_link, bool *continue_tls_process)</span><br><span> {<=
/span><br><span>     if (to_link-&gt;len)</span><br><span>     {</span><br>=
<span>@@ -3226,7 +3228,7 @@</span><br><span>         return;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    uint8_t *dataptr =3D to_link-&gt;data;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const uint8_t *dataptr =3D to_link-&gt;data=
;</span><br><span> </span><br><span>     /* we don&#39;t expect send_reliab=
le to be NULL when state is</span><br><span>      * not S_UNDEF, but people=
 have reported crashes nonetheless,</span><br><span>@@ -4126,7 +4128,7 @@</=
span><br><span> }</span><br><span> </span><br><span> void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-tls_post_encrypt(struct tls_multi *mult=
i, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+tls_post_encrypt(struct tls_multi *multi, const struct buffer *buf)</spa=
n><br><span> {</span><br><span>     struct key_state *ks =3D multi-&gt;save=
_ks;</span><br><span>     multi-&gt;save_ks =3D NULL;</span><br><span>@@ -4=
257,7 +4259,7 @@</span><br><span>  * into a garbage collectable string whic=
h is returned=2E</span><br><span>  */</span><br><span> const char *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-protocol_dump(struct buffer *=
buffer, unsigned int flags, struct gc_arena *gc)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+protocol_dump(const struct buffer *buffer, uns=
igned int flags, struct gc_arena *gc)</span><br><span> {</span><br><span>  =
   struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span>     struct=
 buffer buf =3D *buffer;</span><br><span>diff --git a/src/openvpn/ssl=2Eh b=
/src/openvpn/ssl=2Eh</span><br><span>index 7ddf965=2E=2E93e6200 100644</spa=
n><br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src/openvpn/ssl=
=2Eh</span><br><span>@@ -166,7 +166,7 @@</span><br><span>  *</span><br><spa=
n>  * @return A newly allocated and initialized \c tls_multi structure=2E</=
span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
ruct tls_multi *tls_multi_init(struct tls_options *tls_options);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+struct tls_multi *tls_multi_in=
it(const struct tls_options *tls_options);</span><br><span> </span><br><spa=
n> /**</span><br><span>  * Finalize initialization of a \c tls_multi struct=
ure=2E</span><br><span>@@ -187,7 +187,7 @@</span><br><span> /*</span><br><s=
pan>  * Initialize a standalone tls-auth verification object=2E</span><br><=
span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct tls_a=
uth_standalone *tls_auth_standalone_init(struct tls_options *tls_options,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_auth_stand=
alone *tls_auth_standalone_init(const struct tls_options *tls_options,</spa=
n><br><span>                                                      struct gc=
_arena *gc);</span><br><span> </span><br><span> /**</span><br><span>@@ -371=
,7 +371,7 @@</span><br><span>  * @param multi - The TLS state for this pack=
et&#39;s destination VPN tunnel=2E</span><br><span>  * @param buf - The buf=
fer containing the outgoing packet=2E</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void tls_post_encrypt(struct tls_multi=
 *multi, struct buffer *buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void tls_post_encrypt(struct tls_multi *multi, const struct buffe=
r *buf);</span><br><span> </span><br><span> /** @} name Functions for manag=
ing security parameter state for data channel packets */</span><br><span> <=
/span><br><span>@@ -461,7 +461,8 @@</span><br><span>  */</span><br><span> b=
ool tls_session_update_crypto_params(struct tls_multi *multi, struct tls_se=
ssion *session,</span><br><span>                                       stru=
ct options *options, struct frame *frame,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                      struct frame *fra=
me_fragment, struct link_socket_info *lsi,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                      struct frame *=
frame_fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                  const struct link_socket_info *lsi,</span=
><br><span>                                       dco_context_t *dco);</spa=
n><br><span> </span><br><span> /*</span><br><span>@@ -525,7 +526,7 @@</span=
><br><span> #define PD_VERBOSE                 (1 &lt;&lt; 10)</span><br><s=
pan> #define PD_TLS_CRYPT               (1 &lt;&lt; 11)</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *protocol_du=
mp(struct buffer *buffer, unsigned int flags, struct gc_arena *gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+const char *protocol_dump(c=
onst struct buffer *buffer, unsigned int flags, struct gc_arena *gc);</span=
><br><span> </span><br><span> /*</span><br><span>  * debugging code</span><=
br><span>@@ -573,7 +574,7 @@</span><br><span> /* Special method to skip the=
 three way handshake RESET stages=2E This is</span><br><span>  * used by th=
e HMAC code when seeing a packet that matches the previous</span><br><span>=
  * HMAC based stateless server state */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-bool session_skip_to_pre_start(struct tls_session *sessi=
on, struct tls_pre_decrypt_state *state,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                               struct link_socket_actual=
 *from);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool sessio=
n_skip_to_pre_start(struct tls_session *session, const struct tls_pre_decry=
pt_state *state,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                            const struct link_socket_actual *from);</span><=
br><span> </span><br><span> #endif /* ifndef OPENVPN_SSL_H */</span><br><sp=
an>diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh</=
span><br><span>index a6d57f2=2E=2E29e07a6 100644</span><br><span>--- a/src/=
openvpn/ssl_backend=2Eh</span><br><span>+++ b/src/openvpn/ssl_backend=2Eh</=
span><br><span>@@ -137,7 +137,7 @@</span><br><span>  *</span><br><span>  * =
@return      true if the context is initialised, false if not=2E</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool tls_ct=
x_initialised(struct tls_root_ctx *ctx);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool tls_ctx_initialised(const struct tls_root_ctx *ct=
x);</span><br><span> </span><br><span> /**</span><br><span>  * Set any libr=
ary specific options=2E</span><br><span>@@ -170,7 +170,7 @@</span><br><span=
>  * @param ciphers       String containing : delimited cipher names, or NU=
LL to use</span><br><span>  *                                      sane def=
aults=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-void tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const=
 char *ciphers);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const char=
 *ciphers);</span><br><span> </span><br><span> /**</span><br><span>  * Set =
the TLS certificate profile=2E  The profile defines which crypto</span><br>=
<span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2E=
c</span><br><span>index c92c423=2E=2Ecddf856 100644</span><br><span>--- a/s=
rc/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2E=
c</span><br><span>@@ -146,7 +146,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
tls_ctx_initialised(struct tls_root_ctx *ctx)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+tls_ctx_initialised(const struct tls_root_ctx *ct=
x)</span><br><span> {</span><br><span>     /* either this should be NULL or=
 should be non-null and then have a</span><br><span>      * valid TLS ctx i=
nside as well */</span><br><span>@@ -269,7 +269,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, con=
st char *ciphers)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tl=
s_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const char *ci=
phers)</span><br><span> {</span><br><span>     if (ciphers =3D=3D NULL)</sp=
an><br><span>     {</span><br><span>diff --git a/src/openvpn/ssl_openssl=2E=
c b/src/openvpn/ssl_openssl=2Ec</span><br><span>index 7cfe9f4=2E=2Ecb3de65 =
100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>++=
+ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -129,7 +129,7 @@</span><=
br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tls_ctx_initialised(struct tls_root_ctx *ct=
x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_initialis=
ed(const struct tls_root_ctx *ctx)</span><br><span> {</span><br><span>     =
/* either this should be NULL or should be non-null and then have a</span><=
br><span>      * valid TLS ctx inside as well */</span><br><span>@@ -446,7 =
+446,7 @@</span><br><span> #endif</span><br><span> </span><br><span> void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_restrict_cipher=
s_tls13(struct tls_root_ctx *ctx, const char *ciphers)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+tls_ctx_restrict_ciphers_tls13(const str=
uct tls_root_ctx *ctx, const char *ciphers)</span><br><span> {</span><br><s=
pan>     if (ciphers =3D=3D NULL)</span><br><span>     {</span><br><span>@@=
 -1093,7 +1093,7 @@</span><br><span> }</span><br><span> </span><br><span> s=
tatic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_loa=
d_cert_uri(struct tls_root_ctx *tls_ctx, const char *uri)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+tls_ctx_load_cert_uri(const struct tl=
s_root_ctx *tls_ctx, const char *uri)</span><br><span> {</span><br><span> #=
if defined(HAVE_OPENSSL_STORE_API)</span><br><span>     X509 *x =3D NULL;</=
span><br><span>@@ -2008,7 +2008,7 @@</span><br><span> }</span><br><span> </=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-bio_debug_data(const char *mode, BIO *bio, const uint8_t *buf, int le=
n, const char *desc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bio_debug_data(const char *mode, const BIO *bio, const uint8_t *buf, int l=
en, const char *desc)</span><br><span> {</span><br><span>     struct gc_are=
na gc =3D gc_new();</span><br><span>     if (len &gt; 0)</span><br><span>@@=
 -2022,7 +2022,7 @@</span><br><span> }</span><br><span> </span><br><span> s=
tatic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bio_debug_o=
c(const char *mode, BIO *bio)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bio_debug_oc(const char *mode, const BIO *bio)</span><br><span> {=
</span><br><span>     open_biofp();</span><br><span>     fprintf(biofp, &qu=
ot;BIO %s time=3D%&quot; PRIi64 &quot; bio=3D&quot; ptr_format &quot;\n&quo=
t;, mode, (int64_t)time(NULL),</span><br><span>diff --git a/src/openvpn/ssl=
_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 6a6d9f9=2E=2E4ced4=
c4 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++=
 b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -58,7 +58,7 @@</span><br><spa=
n>  *  @return         if the swap was successful (buf was large enough)</s=
pan><br><span>  */</span><br><span> static bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-swap_hmac(struct buffer *buf, const struct crypto=
_options *co, bool incoming)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+swap_hmac(const struct buffer *buf, const struct crypto_options *c=
o, bool incoming)</span><br><span> {</span><br><span>     ASSERT(co);</span=
><br><span> </span><br><span>@@ -118,7 +118,7 @@</span><br><span>  */</span=
><br><span> static void</span><br><span> tls_wrap_control(struct tls_wrap_c=
tx *ctx, uint8_t header, struct buffer *buf,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                 struct session_id *session_id)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const s=
truct session_id *session_id)</span><br><span> {</span><br><span>     if (c=
tx-&gt;mode =3D=3D TLS_WRAP_AUTH || ctx-&gt;mode =3D=3D TLS_WRAP_NONE)</spa=
n><br><span>     {</span><br><span>@@ -402,9 +402,9 @@</span><br><span> </s=
pan><br><span> </span><br><span> struct buffer</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-tls_reset_standalone(struct tls_wrap_ctx *ctx, str=
uct tls_auth_standalone *tas,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                     struct session_id *own_sid, struct session_id =
*remote_sid, uint8_t header,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                     bool request_resend_wkc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tls_reset_standalone(struct tls_wrap_ctx =
*ctx, const struct tls_auth_standalone *tas,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                     const struct session_id *own_=
sid, const struct session_id *remote_sid,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                     uint8_t header, bool request_res=
end_wkc)</span><br><span> {</span><br><span>     /* Copy buffer here to poi=
nt at the same data but allow tls_wrap_control</span><br><span>      * to p=
otentially change buf to point to another buffer without</span><br><span>@@=
 -489,7 +489,7 @@</span><br><span> bool</span><br><span> check_session_hmac=
_and_pkt_id(struct tls_pre_decrypt_state *state,</span><br><span>          =
                     const struct openvpn_sockaddr *from,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                              uint8_t *=
key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
               const uint8_t *key,</span><br><span>                        =
       int handwindow,</span><br><span>                               bool =
pkt_is_ack)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl=
_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 03e8930=2E=2E8203e=
4a 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++=
 b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -183,7 +183,7 @@</span><br><s=
pan>  * @return              the expected server session id</span><br><span=
>  */</span><br><span> bool check_session_hmac_and_pkt_id(struct tls_pre_de=
crypt_state *state, const struct openvpn_sockaddr *from,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                   uint8=
_t *key, int handwindow, bool pkt_is_ack);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                   const uint8_t *ke=
y, int handwindow, bool pkt_is_ack);</span><br><span> </span><br><span> /*<=
/span><br><span>  * Write a control channel authentication record=2E</span>=
<br><span>@@ -210,8 +210,9 @@</span><br><span>  * from the tls pre decrypt =
state=2E</span><br><span>  *</span><br><span>  */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-struct buffer tls_reset_standalone(struct tls_w=
rap_ctx *ctx, struct tls_auth_standalone *tas,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                   struct session_=
id *own_sid, struct session_id *remote_sid,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+struct buffer tls_reset_standalone(struct tls_wrap_=
ctx *ctx, const struct tls_auth_standalone *tas,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                   const struc=
t session_id *own_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                   const struct session_id *remote_sid,<=
/span><br><span>                                    uint8_t header, bool re=
quest_resend_wkc);</span><br><span> </span><br><span> </span><br><span>diff=
 --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br>=
<span>index 063fa5d=2E=2E3304cb46 100644</span><br><span>--- a/src/openvpn/=
ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><=
span>@@ -1139,7 +1139,7 @@</span><br><span>  * cache=2E</span><br><span>  *=
/</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-tls_authentication_status_use_cache(struct tls_multi *multi)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_authentication_status=
_use_cache(const struct tls_multi *multi)</span><br><span> {</span><br><spa=
n>     unsigned int idx =3D min_uint(multi-&gt;tas_cache_num_updates, SIZE(=
cache_intervals) - 1);</span><br><span>     time_t latency =3D cache_interv=
als[idx];</span><br><span>@@ -1283,7 +1283,7 @@</span><br><span>  * Check i=
f the script/plugin left a message in the auth failed message</span><br><sp=
an>  * file and relay it to the user */</span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-check_for_client_reason(stru=
ct tls_multi *multi, struct auth_deferred_status *status)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+check_for_client_reason(struct tls_mu=
lti *multi, const struct auth_deferred_status *status)</span><br><span> {</=
span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     c=
onst char *msg =3D key_state_check_auth_failed_message_file(status, &amp;gc=
);</span><br><span>@@ -1552,7 +1552,7 @@</span><br><span> #endif /* ifdef E=
NABLE_MANAGEMENT */</span><br><span> </span><br><span> static bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-set_verify_user_pass_env(struc=
t user_pass *up, struct tls_multi *multi, struct tls_session *session)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+set_verify_user_pass_env=
(const struct user_pass *up, struct tls_multi *multi, struct tls_session *s=
ession)</span><br><span> {</span><br><span>     /* Is username defined? */<=
/span><br><span>     if ((session-&gt;opt-&gt;ssl_flags &amp; SSLF_AUTH_USE=
R_PASS_OPTIONAL) || strlen(up-&gt;username))</span><br><span>@@ -1580,7 +15=
80,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-ssl_verify_username_length(str=
uct tls_session *session, const char *username)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ssl_verify_username_length(const struct tls_ses=
sion *session, const char *username)</span><br><span> {</span><br><span>   =
  if ((session-&gt;opt-&gt;ssl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME)</s=
pan><br><span>         &amp;&amp; strlen(username) &gt; TLS_USERNAME_LEN)</=
span><br><span>diff --git a/src/openvpn/ssl_verify=2Eh b/src/openvpn/ssl_ve=
rify=2Eh</span><br><span>index 3176d76=2E=2Ee77bc4a 100644</span><br><span>=
--- a/src/openvpn/ssl_verify=2Eh</span><br><span>+++ b/src/openvpn/ssl_veri=
fy=2Eh</span><br><span>@@ -202,7 +202,7 @@</span><br><span>  * @return     =
         true if name is under limit or username-as-common-name</span><br><=
span>  *                      is not active</span><br><span>  */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-bool ssl_verify_username_length(=
struct tls_session *session, const char *username);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool ssl_verify_username_length(const str=
uct tls_session *session, const char *username);</span><br><span> </span><b=
r><span> /**</span><br><span>  * Runs the --client-crresponse script if one=
 is defined=2E</span><br><span>@@ -275,7 +275,7 @@</span><br><span> void au=
th_set_client_reason(struct tls_multi *multi, const char *client_reason);</=
span><br><span> </span><br><span> static inline const char *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-tls_client_reason(struct tls_multi *=
multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_client_re=
ason(const struct tls_multi *multi)</span><br><span> {</span><br><span>    =
 return multi-&gt;client_reason;</span><br><span> }</span><br><span>diff --=
git a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec</span><br><span>index=
 c7d375b=2E=2Ecfbc38d 100644</span><br><span>--- a/src/openvpn/status=2Ec</=
span><br><span>+++ b/src/openvpn/status=2Ec</span><br><span>@@ -135,7 +135,=
7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-status_reset(struct status_output=
 *so)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+status_reset(c=
onst struct status_output *so)</span><br><span> {</span><br><span>     if (=
so &amp;&amp; so-&gt;fd &gt;=3D 0)</span><br><span>     {</span><br><span>d=
iff --git a/src/openvpn/status=2Eh b/src/openvpn/status=2Eh</span><br><span=
>index 7953a4e=2E=2E4c01d75 100644</span><br><span>--- a/src/openvpn/status=
=2Eh</span><br><span>+++ b/src/openvpn/status=2Eh</span><br><span>@@ -69,7 =
+69,7 @@</span><br><span> </span><br><span> bool status_trigger(struct stat=
us_output *so);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void status_reset(struct status_output *so);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void status_reset(const struct status_=
output *so);</span><br><span> </span><br><span> void status_flush(struct st=
atus_output *so);</span><br><span> </span><br><span>diff --git a/src/openvp=
n/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index af48921=2E=2Eabb46af =
100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/=
openvpn/tun=2Ec</span><br><span>@@ -835,7 +835,7 @@</span><br><span>       =
   const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 IPv6 */</=
span><br><span>          int ifconfig_ipv6_netbits_parm,</span><br><span>  =
        const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 IPv6=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         struct ad=
drinfo *local_public, struct addrinfo *remote_public, const bool strict_war=
n,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         const st=
ruct addrinfo *local_public, const struct addrinfo *remote_public, const bo=
ol strict_warn,</span><br><span>          struct env_set *es, openvpn_net_c=
tx_t *ctx, struct tuntap *tt)</span><br><span> {</span><br><span>     if (!=
tt)</span><br><span>@@ -978,7 +978,7 @@</span><br><span>  * -&gt; helper fu=
nction to simplify code below</span><br><span>  */</span><br><span> static =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_route_connect=
ed_v6_net(struct tuntap *tt, const struct env_set *es)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+add_route_connected_v6_net(const struct =
tuntap *tt, const struct env_set *es)</span><br><span> {</span><br><span>  =
   struct route_ipv6 r6;</span><br><span> </span><br><span>@@ -1020,7 +1020=
,7 @@</span><br><span>  */</span><br><span> </span><br><span> in_addr_t</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-create_arbitrary_remote(s=
truct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cr=
eate_arbitrary_remote(const struct tuntap *tt)</span><br><span> {</span><br=
><span>     in_addr_t remote;</span><br><span> </span><br><span>@@ -1592,7 =
+1592,7 @@</span><br><span> }</span><br><span> </span><br><span> static voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv4(s=
truct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+undo_ifconfig_ipv4(const struct tuntap *tt, openvpn_n=
et_ctx_t *ctx)</span><br><span> {</span><br><span> #if defined(TARGET_LINUX=
)</span><br><span>     int netbits =3D netmask_to_netbits2(tt-&gt;remote_ne=
tmask);</span><br><span>@@ -1627,7 +1627,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv6=
(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</span>=
<br><span> #if defined(TARGET_LINUX)</span><br><span>     if (net_addr_v6_d=
el(ctx, tt-&gt;actual_name, &amp;tt-&gt;local_ipv6, tt-&gt;netbits_ipv6) &l=
t; 0)</span><br><span>@@ -1652,7 +1652,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig(const struct tunta=
p *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>     if (=
tt-&gt;backend_driver !=3D DRIVER_NULL &amp;&amp; tt-&gt;backend_driver !=
=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -1720,7 +1720,=
7 @@</span><br><span> }</span><br><span> </span><br><span> static ssize_t</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun_header(struct=
 tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+write_tun_header(const struct tuntap *tt, const uint8_t *bu=
f, int len)</span><br><span> {</span><br><span>     if (tt-&gt;type =3D=3D =
DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -1737,9 +1737,11 @@=
</span><br><span>             type =3D htonl(AF_INET);</span><br><span>    =
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* argument to writev is a pointer to const but we still need =
to drop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * t=
he const from buf pointer here */</span><br><span>         iv[0]=2Eiov_base=
 =3D &amp;type;</span><br><span>         iv[0]=2Eiov_len =3D sizeof(type);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1]=2Eiov_ba=
se =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
iv[1]=2Eiov_base =3D (void *)buf;</span><br><span>         iv[1]=2Eiov_len =
=3D len;</span><br><span> </span><br><span>         return header_modify_re=
ad_write_return(writev(tt-&gt;fd, iv, 2));</span><br><span>@@ -1751,7 +1753=
,7 @@</span><br><span> }</span><br><span> </span><br><span> static ssize_t<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun_header(struct=
 tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+read_tun_header(const struct tuntap *tt, uint8_t *buf, int =
len)</span><br><span> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYP=
E_TUN)</span><br><span>     {</span><br><span>@@ -1777,13 +1779,13 @@</span=
><br><span>  */</span><br><span> #if !defined(TARGET_DARWIN)</span><br><spa=
n> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(s=
truct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t *buf,=
 int len)</span><br><span> {</span><br><span>     return write_tun_header(t=
t, buf, len);</span><br><span> }</span><br><span> </span><br><span> ssize_t=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tunta=
p *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</span><b=
r><span> {</span><br><span>     return read_tun_header(tt, buf, len);</span=
><br><span> }</span><br><span>@@ -1799,7 +1801,7 @@</span><br><span> </span=
><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br>=
<span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun=
_dco_enabled(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+tun_dco_enabled(const struct tuntap *tt)</span><br><span> {</sp=
an><br><span>     return tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><br=
><span> }</span><br><span>@@ -2046,13 +2048,13 @@</span><br><span> }</span>=
<br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tunta=
p *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span>    =
 return write(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span> </s=
pan><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t=
 *buf, int len)</span><br><span> {</span><br><span>     return read(tt-&gt;=
fd, buf, len);</span><br><span> }</span><br><span>@@ -2251,13 +2253,13 @@</=
span><br><span> }</span><br><span> </span><br><span> ssize_t</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t=
 *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+writ=
e_tun(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><span=
> {</span><br><span>     return write(tt-&gt;fd, buf, len);</span><br><span=
> }</span><br><span> </span><br><span> ssize_t</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const stru=
ct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>  =
   return read(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span>@@ =
-2587,7 +2589,7 @@</span><br><span> }</span><br><span> </span><br><span> ss=
ize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct=
 tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t *buf, int =
len)</span><br><span> {</span><br><span>     struct strbuf sbuf;</span><br>=
<span>     sbuf=2Elen =3D len;</span><br><span>@@ -2596,7 +2598,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> ssize_t</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf,=
 int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(c=
onst struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br=
><span>     struct strbuf sbuf;</span><br><span>     int f =3D 0;</span><br=
><span>@@ -3094,7 +3096,7 @@</span><br><span> }</span><br><span> </span><br=
><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_=
tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t =
*buf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;backend_d=
river =3D=3D DRIVER_UTUN)</span><br><span>     {</span><br><span>@@ -3107,7=
 +3109,7 @@</span><br><span> }</span><br><span> </span><br><span> ssize_t</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap =
*tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</span><br>=
<span> {</span><br><span>     if (tt-&gt;backend_driver =3D=3D DRIVER_UTUN)=
</span><br><span>     {</span><br><span>@@ -3311,7 +3313,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-tun_write_queue(struct tuntap *tt, struct buffer *bu=
f)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_write_queue(s=
truct tuntap *tt, const struct buffer *buf)</span><br><span> {</span><br><s=
pan>     if (tt-&gt;writes=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><spa=
n>     {</span><br><span>@@ -3366,7 +3368,7 @@</span><br><span> }</span><br=
><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-tun_write_win32(struct tuntap *tt, struct buffer *buf)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+tun_write_win32(struct tuntap *t=
t, const struct buffer *buf)</span><br><span> {</span><br><span>     int er=
r =3D 0;</span><br><span>     int status =3D 0;</span><br><span>@@ -5374,7 =
+5376,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-fork_register_dns_action(st=
ruct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+for=
k_register_dns_action(const struct tuntap *tt)</span><br><span> {</span><br=
><span>     if (tt &amp;&amp; tt-&gt;options=2Eregister_dns &amp;&amp; tt-&=
gt;options=2Emsg_channel)</span><br><span>     {</span><br><span>@@ -5464,7=
 +5466,7 @@</span><br><span> }</span><br><span> </span><br><span> static vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_get_mtu(stru=
ct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tunta=
p_get_mtu(const struct tuntap *tt)</span><br><span> {</span><br><span>     =
ULONG mtu =3D 0;</span><br><span>     DWORD len;</span><br><span>@@ -6039,7=
 +6041,7 @@</span><br><span> }</span><br><span> </span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_show_debug(struct tunt=
ap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_show_deb=
ug(const struct tuntap *tt)</span><br><span> {</span><br><span>     if (tt-=
&gt;backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)</span><br><span>    =
 {</span><br><span>diff --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh</=
span><br><span>index 931e54d=2E=2Ebeb0d0e 100644</span><br><span>--- a/src/=
openvpn/tun=2Eh</span><br><span>+++ b/src/openvpn/tun=2Eh</span><br><span>@=
@ -272,9 +272,9 @@</span><br><span> </span><br><span> void close_tun_handle=
(struct tuntap *tt);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-ssize_t write_tun(struct tuntap *tt, uint8_t *buf, int len=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t write_tun=
(const struct tuntap *tt, const uint8_t *buf, int len);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t read_tun(struct=
 tuntap *tt, uint8_t *buf, int len);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ssize_t read_tun(const struct tuntap *tt, uint8_t *buf, in=
t len);</span><br><span> </span><br><span> #ifdef ENABLE_FEATURE_TUN_PERSIS=
T</span><br><span> void tuncfg(const char *dev, const char *dev_type, const=
 char *dev_node, int persist_mode,</span><br><span>@@ -293,7 +293,7 @@</spa=
n><br><span>                         const char *ifconfig_ipv6_local_parm, =
    /* --ifconfig parm 1 / IPv6 */</span><br><span>                        =
 int ifconfig_ipv6_netbits_parm,           /* --ifconfig parm 1 / bits */</=
span><br><span>                         const char *ifconfig_ipv6_remote_pa=
rm,    /* --ifconfig parm 2 / IPv6 */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        struct addrinfo *local_public, stru=
ct addrinfo *remote_public,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        const struct addrinfo *local_public, const =
struct addrinfo *remote_public,</span><br><span>                         co=
nst bool strict_warn, struct env_set *es, openvpn_net_ctx_t *ctx,</span><br=
><span>                         struct tuntap *tt);</span><br><span> </span=
><br><span>@@ -320,7 +320,7 @@</span><br><span>  * @param tt    the tuntap =
interface context</span><br><span>  * @param ctx   the networking API opaqu=
e context</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void undo_ifconfig(cons=
t struct tuntap *tt, openvpn_net_ctx_t *ctx);</span><br><span> </span><br><=
span> bool is_dev_type(const char *dev, const char *dev_type, const char *m=
atch_type);</span><br><span> </span><br><span>@@ -351,7 +351,7 @@</span><br=
><span> #define IFCONFIG_DEFAULT IFCONFIG_AFTER_TUN_OPEN</span><br><span> <=
/span><br><span> static inline int</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-ifconfig_order(struct tuntap *tt)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ifconfig_order(const struct tuntap *tt)</span><b=
r><span> {</span><br><span>     if (tt-&gt;backend_driver =3D=3D DRIVER_AFU=
NIX)</span><br><span>     {</span><br><span>@@ -381,7 +381,7 @@</span><br><=
span> #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN</span><br><span> </span><=
br><span> static inline int</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-route_order(struct tuntap *tt)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+route_order(const struct tuntap *tt)</span><br><span> {</s=
pan><br><span>     if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><b=
r><span>     {</span><br><span>@@ -454,13 +454,13 @@</span><br><span> </spa=
n><br><span> const char *tap_win_getinfo(const struct tuntap *tt, struct gc=
_arena *gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void tun_show_debug(struct tuntap *tt);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void tun_show_debug(const struct tuntap *tt);<=
/span><br><span> </span><br><span> bool dhcp_release_by_adapter_index(const=
 DWORD adapter_index);</span><br><span> </span><br><span> bool dhcp_renew_b=
y_adapter_index(const DWORD adapter_index);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void fork_register_dns_action(struc=
t tuntap *tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
fork_register_dns_action(const struct tuntap *tt);</span><br><span> </span>=
<br><span> void ipconfig_register_dns(const struct env_set *es);</span><br>=
<span> </span><br><span>@@ -470,7 +470,7 @@</span><br><span> </span><br><sp=
an> int tun_read_queue(struct tuntap *tt, int maxsize);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-int tun_write_queue(str=
uct tuntap *tt, struct buffer *buf);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+int tun_write_queue(struct tuntap *tt, const struct buffer=
 *buf);</span><br><span> </span><br><span> static inline bool</span><br><sp=
an> tuntap_stop(int status)</span><br><span>@@ -499,7 +499,7 @@</span><br><=
span>     return false;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-int tun_write_win32(struct tuntap *t=
t, struct buffer *buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+int tun_write_win32(struct tuntap *tt, const struct buffer *buf);</span=
><br><span> </span><br><span> static inline bool</span><br><span> is_ip_pac=
ket_valid(const struct buffer *buf)</span><br><span>@@ -529,13 +529,13 @@</=
span><br><span> }</span><br><span> </span><br><span> static inline bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win(struct =
tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_i=
s_dco_win(const struct tuntap *tt)</span><br><span> {</span><br><span>     =
return tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><br><sp=
an> }</span><br><span> </span><br><span> static inline bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win_timeout(struct tunt=
ap *tt, ssize_t status)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+tuntap_is_dco_win_timeout(const struct tuntap *tt, ssize_t status)</spa=
n><br><span> {</span><br><span>     return tuntap_is_dco_win(tt) &amp;&amp;=
 (status &lt; 0) &amp;&amp; (openvpn_errno() =3D=3D ERROR_NETNAME_DELETED);=
</span><br><span> }</span><br><span>@@ -555,25 +555,25 @@</span><br><span> =
}</span><br><span> </span><br><span> static inline void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-tun_standby_init(struct tuntap *tt)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_standby_init(const st=
ruct tuntap *tt)</span><br><span> {</span><br><span> }</span><br><span> </s=
pan><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-tun_standby(struct tuntap *tt)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+tun_standby(const struct tuntap *tt)</span><br><span=
> {</span><br><span>     return true;</span><br><span> }</span><br><span> <=
/span><br><span> </span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win(struct tuntap *tt)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win(const st=
ruct tuntap *tt)</span><br><span> {</span><br><span>     return false;</spa=
n><br><span> }</span><br><span> </span><br><span> static inline bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win_timeout(st=
ruct tuntap *tt, ssize_t status)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+tuntap_is_dco_win_timeout(const struct tuntap *tt, ssize_t sta=
tus)</span><br><span> {</span><br><span>     return false;</span><br><span>=
 }</span><br><span>diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tu=
n_afunix=2Ec</span><br><span>index a67a472=2E=2Ee9223bc 100644</span><br><s=
pan>--- a/src/openvpn/tun_afunix=2Ec</span><br><span>+++ b/src/openvpn/tun_=
afunix=2Ec</span><br><span>@@ -48,7 +48,7 @@</span><br><span> </span><br><s=
pan> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-tun_afunix_exec_child(const char *dev_node, struct tuntap *tt,=
 struct env_set *env)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, const stru=
ct env_set *env)</span><br><span> {</span><br><span>     const char *msgpre=
fix =3D &quot;ERROR: failure executing process for tun:&quot;;</span><br><s=
pan>     struct argv argv =3D argv_new();</span><br><span>@@ -73,7 +73,7 @@=
</span><br><span> }</span><br><span> </span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-open_tun_afunix(struct options *o, in=
t mtu, struct tuntap *tt, struct env_set *orig_env)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+open_tun_afunix(const struct options *o, =
int mtu, struct tuntap *tt, const struct env_set *orig_env)</span><br><span=
> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> =
</span><br><span>diff --git a/src/openvpn/tun_afunix=2Eh b/src/openvpn/tun_=
afunix=2Eh</span><br><span>index 5b6a8e0=2E=2Efb88eb2 100644</span><br><spa=
n>--- a/src/openvpn/tun_afunix=2Eh</span><br><span>+++ b/src/openvpn/tun_af=
unix=2Eh</span><br><span>@@ -31,7 +31,7 @@</span><br><span>  * the user pro=
vided taking care of implementing the actual tun</span><br><span>  * device=
=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, stru=
ct env_set *env);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id open_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, con=
st struct env_set *env);</span><br><span> </span><br><span> </span><br><spa=
n> /**</span><br><span>diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=
=2Ec</span><br><span>index bffc60e=2E=2Ecd32a9b 100644</span><br><span>--- =
a/src/openvpn/vlan=2Ec</span><br><span>+++ b/src/openvpn/vlan=2Ec</span><br=
><span>@@ -288,7 +288,7 @@</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vlan_proces=
s_outgoing_tun(struct multi_context *m, struct multi_instance *mi)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+vlan_process_outgoing_tun(co=
nst struct multi_context *m, struct multi_instance *mi)</span><br><span> {<=
/span><br><span>     if (!m-&gt;top=2Eoptions=2Evlan_tagging)</span><br><sp=
an>     {</span><br><span>diff --git a/src/openvpn/vlan=2Eh b/src/openvpn/v=
lan=2Eh</span><br><span>index 9389f89=2E=2Ecd2f66f 100644</span><br><span>-=
-- a/src/openvpn/vlan=2Eh</span><br><span>+++ b/src/openvpn/vlan=2Eh</span>=
<br><span>@@ -35,6 +35,6 @@</span><br><span> </span><br><span> bool vlan_is=
_tagged(const struct buffer *buf);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void vlan_process_outgoing_tun(struct multi=
_context *m, struct multi_instance *mi);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void vlan_process_outgoing_tun(const struct multi_cont=
ext *m, struct multi_instance *mi);</span><br><span> </span><br><span> #end=
if /* VLAN_H */</span><br><span>diff --git a/src/openvpn/win32=2Eh b/src/op=
envpn/win32=2Eh</span><br><span>index 8be3d96=2E=2E39ff7d8 100644</span><br=
><span>--- a/src/openvpn/win32=2Eh</span><br><span>+++ b/src/openvpn/win32=
=2Eh</span><br><span>@@ -227,7 +227,7 @@</span><br><span> void overlapped_i=
o_close(struct overlapped_io *o);</span><br><span> </span><br><span> static=
 inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-overlappe=
d_io_active(struct overlapped_io *o)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+overlapped_io_active(const struct overlapped_io *o)</span>=
<br><span> {</span><br><span>     return o-&gt;iostate =3D=3D IOSTATE_QUEUE=
D || o-&gt;iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;</span><br><span> }</spa=
n><br><span>diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsi=
ca/openvpnmsica=2Ec</span><br><span>index a861e8a=2E=2E25fa1e4 100644</span=
><br><span>--- a/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>+++ b/sr=
c/openvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -77,7 +77,7 @@</span><br=
><span>  * @return ERROR_SUCCESS on success; An error code otherwise</span>=
<br><span>  */</span><br><span> static UINT</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWST=
R szProperty, _In_ struct msica_arg_seq *seq)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LP=
CWSTR szProperty, _In_ const struct msica_arg_seq *seq)</span><br><span> {<=
/span><br><span>     UINT uiResult;</span><br><span>     LPWSTR szSequence =
=3D msica_arg_seq_join(seq);</span><br><span>diff --git a/src/openvpnserv/i=
nteractive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index d228=
8b9=2E=2Eee5d22a 100644</span><br><span>--- a/src/openvpnserv/interactive=
=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>=
@@ -522,7 +522,7 @@</span><br><span> </span><br><span> </span><br><span> st=
atic SOCKADDR_INET</span><br><span style=3D"color: hsl(0, 100%, 40%);">-soc=
kaddr_inet(short family, inet_address_t *addr)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+sockaddr_inet(short family, const inet_address_t=
 *addr)</span><br><span> {</span><br><span>     SOCKADDR_INET sa_inet;</spa=
n><br><span>     ZeroMemory(&amp;sa_inet, sizeof(sa_inet));</span><br><span=
>@@ -3849,7 +3849,7 @@</span><br><span> </span><br><span> static DWORD</spa=
n><br><span> UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE=
 io_event, HANDLE exit_event,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                  list_item_t *threads)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                  const list_item_t *threads)</=
span><br><span> {</span><br><span>     static DWORD size =3D 10;</span><br>=
<span>     static LPHANDLE handles =3D NULL;</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock=
_management=2Ec</span><br><span>index 77f6ce2=2E=2Efff4c2b 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>@@ -36,7 =
+36,7 @@</span><br><span> struct management *management; /* GLOBAL */</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-management_auth_failure(struct management *man, const char *ty=
pe, const char *reason)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+management_auth_failure(const struct management *man, const char *type,=
 const char *reason)</span><br><span> {</span><br><span>     ASSERT(false);=
</span><br><span> }</span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index=
 a41c27b=2E=2Ea8daee6 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec=
</span><br><span>@@ -146,7 +146,7 @@</span><br><span> }</span><br><span> </=
span><br><span> static struct hash_element *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-hash_lookup_by_value(struct hash *hash, void *value)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_lookup_by_valu=
e(struct hash *hash, const void *value)</span><br><span> {</span><br><span>=
     struct hash_iterator hi;</span><br><span>     struct hash_element *he;=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b=
/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>index c0a0866=
=2E=2E7636a33 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_us=
er_pass=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass=
=2Ec</span><br><span>@@ -59,7 +59,7 @@</span><br><span>     return mock();<=
/span><br><span> }</span><br><span> void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-management_auth_failure(struct management *man, const ch=
ar *type, const char *reason)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+management_auth_failure(const struct management *man, const char =
*type, const char *reason)</span><br><span> {</span><br><span>     assert_t=
rue(0);</span><br><span> }</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">c=
hange 1663</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1663 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owner: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>

</body></html>
--8582YZ0uhVU=--


--===============0634022607324922488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0634022607324922488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0634022607324922488==--

