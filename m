Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF80DC79F9E
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ro0QPuANpLpnsiixlrtmt837xP6LgHkLbUfoQ8qU6tg=; b=IFpmj9QOBulAqejYRSsbe23Oht
	/rRCI/3r7hBRZWKO8VeeRfnic87/oDLxmVuKQ3glPUNvMQPI4ArzdrG6ES39JZI5T1lLTzvHYo8rG
	ALzg+KVBxspfyLt41Nnv0lDK+UpOy/M15EMqwxcaCAlthaDIKHA16QjN3o7CPg4DsVhY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3gW6-0005I4-SG;
	Mon, 07 Sep 2026 21:04:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3gVl-0005Hk-Vh
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 21:04:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9jR1WzwPQ23860gANJYeu2LnF+tdzCfY/TDdPbk7oH4=; b=iZbOKQHdZr77psC4fZA2dAHeWh
 1X+Voj9K6lszZAUlSd6LFXLmWAf//4c5vxaseWEevs8qnYZ1YZKxYAKw9znB3f7vzHeXEanjQ3OI/
 Yh5mN1zefdt6DGpc5T1AZlVTjnBJrAh8FgAnrNpEXf2eYACAskudtLx4WOwfAVZ1+/YE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9jR1WzwPQ23860gANJYeu2LnF+tdzCfY/TDdPbk7oH4=; b=j
 TRZSPCV5ahxYnLSW5t32oOq2pTGOWp1ZwpKUng2ofZayyFbILqGsOMFanKcAbPqaciRlmxu1/Bwgo
 X5QEdvovQfJsRUaHPY3XO7sHMdpveDDHAYAN79ti8grwguYi8o+y4ZlSmz8DzXq4vxtnwmpCdp/+8
 pooUMLhnuVI0C0S0=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3gVc-00056X-FU for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 21:04:17 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-485850cf499so2525490f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788815042; x=1789419842; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9jR1WzwPQ23860gANJYeu2LnF+tdzCfY/TDdPbk7oH4=;
 b=Pp4kw0a48fhjciw5V7ICCrOwb2I2zBZ635vcn57rOCNsUhz6E1ctwHSFiGid+Rt7hi
 tNIOnk1yeCQOYM6sPOaJniU8kiPP1SnpwJoDPJbrbk3if2/zx/GmWtHzSUPJqdj+X5tj
 +RatSqFnY581cgcRhDqj8teNmWDgnxPcyoalyiRWY8ZW25zVmAv0zLcFGka51L17AvUx
 CGfnvT0Z5KA7qB1Mp2Mctfn6ywPnbNuH2XmQMXBKz2KiYeNOyhWLI9ZYkIXCyNSVpMjK
 1Ru68fyDEMl3kTEh/vA/wDOZUImLtSK8O2JZRiWWcXRuHN634Jlwem285cmInC8PbXAk
 vH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788815042; x=1789419842;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9jR1WzwPQ23860gANJYeu2LnF+tdzCfY/TDdPbk7oH4=;
 b=Nl5jU2JuyaR/6/KJxXJ1Fxcwtv/6RDMJDwhn4DQiWJf356ahLDWV5PMHuYOMYevw/X
 GNt9ymRRjTeFqXQrBooRWreJGimVMyuuqyh/cXRg7kKYDnaU9M47uDbVChvjUbTTJ+Tl
 9iixu9Vl+xS+zXTKjwGeRgiV6kUf75zdEU9PSidgPv7Il0JOpfmTOEg833OoiPzzSdSb
 lbfv5noWwhFC9M2L6VAAwNmYnvLMoXfk1kweun6O8Adve3tL2+Mgj3G1JaQPygDzaN7C
 2NMXBimzbKruk6p2riqV89+dCiR3llfRuxvSV90X1YRGTs3NOf6SJ3EyC5vz9+iFbFUK
 J8iw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJ2TFYm8FoOqhMzcrmoA2sHvmXeRFV/IWDsxhWf43V7/Qa8gJ8nUaqMef7gkZksb8VwrvEm/aMUr1EuUqj@lists.sourceforge.net
X-Gm-Message-State: AFuF++mo5d7N6WPE82k/FH1urVDagKttgrt/FdQ5ZEuwta25Io2wuWrs
 FPUk97jgU2cdNtaWgX7+KmA+eRrU6oVSmG+fOhVsvumvIUvyDNiPJbzU27ZkeKOR2i7WvuQKS5L
 +a9i8+RMklxH7sH1s/5BVYsU9bePzpu5Tfuk7Quk0lR2/CJI0lSKJLmIL0gR+GkvbjaLg
X-Gm-Gg: AYBFou2Nd1uzuRORTt10ETcgjCGCcWOmWMIJBn6ORSCh2kpI+VP5zdrAgk213WCAFGL
 nmE22o9tpAUj9DOYl0c9Hy/qZMv8Mo8Ipo8dh5IOYJ/LJa33LHPhn7pLMojYxutLPF/NEjpHxxh
 TClG7Dwv5Aqjlvx/aejyxxRagbvEqA+0Hy6/mCf2gw1/3cA2VM1pvZdYZwPM/6U6mXJZNEr0JUZ
 sOSRUs3sZa0nKXtfFr4ov5QrND3rmGckjbPT3jDk6wleBg8vM6IoYO6kGUJ9vSNSD3WcBucoyMb
 8V4bcbwM+n4XG32oSsBa3yux6isXtaqCCVp9BFUQ4R+C5AdyH12jOFLwA3PAxwh4BfML2/Y76er
 O4fzCu5KiU5h6di/4lVVSxzWN55TNMfzbSUrPHityww6CeydUt/kK1B5mg8mlL+b8JkREXJANM5
 gbLWZPV6ZMNIyn1zGdRbjcvxbE4cGCxmO6tnS3l90OQTFhj8r12wckv8aKymhqJ3KmSTWlJd3cI
 DE/VFKrea9/gi6bAVkJxidWeCtB48h7JjhAhI6s64vt9POwY1w37+aS0Ef6J0jRnWMLnSxaeRR+
 36f7Jjtm7D2FimsJ6OzJ05vnzRNeOZX8nVg51fDunrTrSrMzNpQ=
X-Received: by 2002:a5d:5f52:0:b0:485:9233:a5ae with SMTP id
 ffacd0b85a97d-4859233aaf2mr16120224f8f.3.1788815040295; 
 Mon, 07 Sep 2026 14:04:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859162f354sm23632363f8f.20.2026.09.07.14.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:03:59 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 21:03:55 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: d7f6fe0f617fb0389d7b6cb6b965d49228e812b9
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b1c98a4cf5fe54f46e29953571ab6178b5b725cc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3gVc-00056X-FU
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
Content-Type: multipart/mixed; boundary="===============7381106706834950924=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7381106706834950924==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oWJ5NTUdQIw="; charset=UTF-8

--oWJ5NTUdQIw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail

to look at the new patch=
 set (#20)=2E


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
M src/openvpn/buffer=2Eh
M src/openvpn/clinat=2Ec
M src/=
openvpn/comp=2Ec
M src/openvpn/comp=2Eh
M src/openvpn/crypto=2Ec
M src/open=
vpn/crypto=2Eh
M src/openvpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/dc=
o_freebsd=2Ec
M src/openvpn/dco_internal=2Eh
M src/openvpn/dco_linux=2Ec
M =
src/openvpn/dco_win=2Ec
M src/openvpn/event=2Eh
M src/openvpn/forward=2Ec
M=
 src/openvpn/forward=2Eh
M src/openvpn/init=2Ec
M src/openvpn/init=2Eh
M sr=
c/openvpn/interval=2Eh
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/=
openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/mbuf=2Ec
M src/op=
envpn/mbuf=2Eh
M src/openvpn/mss=2Ec
M src/openvpn/mss=2Eh
M src/openvpn/mt=
cp=2Ec
M src/openvpn/mtcp=2Eh
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2E=
c
M src/openvpn/multi=2Eh
M src/openvpn/multi_io=2Ec
M src/openvpn/networki=
ng=2Eh
M src/openvpn/networking_iproute2=2Ec
M src/openvpn/networking_sitnl=
=2Ec
M src/openvpn/occ=2Eh
M src/openvpn/openssl_compat=2Eh
M src/openvpn/o=
ptions=2Ec
M src/openvpn/options_parse=2Ec
M src/openvpn/otime=2Ec
M src/op=
envpn/otime=2Eh
M src/openvpn/proto=2Eh
M src/openvpn/proxy=2Ec
M src/openv=
pn/proxy=2Eh
M src/openvpn/ps=2Ec
M src/openvpn/ps=2Eh
M src/openvpn/push=
=2Ec
M src/openvpn/push=2Eh
M src/openvpn/push_util=2Ec
M src/openvpn/relia=
ble=2Ec
M src/openvpn/reliable=2Eh
M src/openvpn/route=2Ec
M src/openvpn/sc=
hedule=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M src/openvpn/=
socket_util=2Eh
M src/openvpn/socks=2Ec
M src/openvpn/socks=2Eh
M src/openv=
pn/ssl=2Ec
M src/openvpn/ssl=2Eh
M src/openvpn/ssl_backend=2Eh
M src/openvp=
n/ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M=
 src/openvpn/ssl_pkt=2Eh
M src/openvpn/ssl_verify=2Ec
M src/openvpn/ssl_ver=
ify=2Eh
M src/openvpn/status=2Ec
M src/openvpn/status=2Eh
M src/openvpn/tun=
=2Ec
M src/openvpn/tun=2Eh
M src/openvpn/tun_afunix=2Ec
M src/openvpn/tun_a=
funix=2Eh
M src/openvpn/vlan=2Ec
M src/openvpn/vlan=2Eh
M src/openvpn/win32=
=2Eh
M src/openvpnmsica/openvpnmsica=2Ec
M src/openvpnserv/interactive=2Ec
=
M tests/unit_tests/openvpn/mock_management=2Ec
M tests/unit_tests/openvpn/t=
est_misc=2Ec
M tests/unit_tests/openvpn/test_user_pass=2Ec
85 files changed=
, 337 insertions(+), 283 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/63/1663/20

diff --git a/dev-tools/cppche=
ck-suppression b/dev-tools/cppcheck-suppression
index 965e8ec=2E=2Ec3a085d =
100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppre=
ssion
@@ -2,7 +2,6 @@
 # occurences right now=2E They still should be fixed=
 at some point
 constParameter
 constParameterCallback
-constParameterPoint=
er
 invalidPrintfArgType_sint
 invalidPrintfArgType_uint
 unusedFunction
@@=
 -27,13 +26,51 @@
 # FP: posix=2Ecfg claims suseconds_t is unsigned for som=
e reason
 unsignedLessThanZero:src/openvpn/otime=2Eh:148
 # IGN: multi code=
 does weird things with pointers to local variables=2E=2E=2E
-autoVariables=
:src/openvpn/multi=2Ec:4232
+autoVariables:src/openvpn/multi=2Ec:4243
 auto=
Variables:src/openvpn/multi_io=2Ec:324
 # IGN: the code header =3D 0 | (OPC=
ODE << P_OPCODE_SHIFT) is used intentionally
 badBitmaskCheck:src/openvpn/m=
udp=2Ec
 badBitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec
 # IGN: we s=
tore integers in pointers
 CastAddressToIntegerAtReturn:src/openvpn/multi=
=2Ec
+# IGN: external
+constParameterPointer:/usr/include/*
+# IGN: test fi=
les provide mocks/stubs that match prototypes from headers exactly
+constPa=
rameterPointer:tests/unit_tests/openvpn/mock_*
+constParameterPointer:tests=
/unit_tests/openvpn/test_*
+constParameterPointer:tests/unit_tests/openvpns=
erv/test_*
+# FP: different crypto implementations but same API
+constParam=
eterPointer:src/openvpn/crypto_mbedtls_legacy=2Ec:85
+constParameterPointer=
:src/openvpn/crypto_openssl=2Ec:173
+constParameterPointer:src/openvpn/cryp=
to_openssl=2Ec:1433
+constParameterPointer:src/openvpn/cryptoapi=2Ec:58
+co=
nstParameterPointer:src/openvpn/ssl_mbedtls=2Ec
+constParameterPointer:src/=
openvpn/ssl_openssl=2Ec
+constParameterPointer:src/openvpn/ssl_verify_mbedt=
ls=2Ec
+constParameterPointer:tests/unit_tests/openvpn/siphash_openssl=2Ec
=
+# IGN: too many different implementations, not worth it
+constParameterPoi=
nter:src/openvpn/dco*
+constParameterPointer:src/openvpn/socket=2E*
+# FP: =
parameters are modified on some platform only
+constParameterPointer:src/op=
envpn/dns=2Ec:859
+constParameterPointer:src/openvpn/error=2Ec:223
+constPa=
rameterPointer:src/openvpn/forward=2Ec:1245
+constParameterPointer:src/open=
vpn/manage=2Ec:344
+constParameterPointer:src/openvpn/manage=2Ec:3329
+cons=
tParameterPointer:src/openvpn/misc=2Ec:793
+constParameterPointer:src/openv=
pn/misc=2Ec:813
+constParameterPointer:src/openvpn/options=2Ec:3205
+constP=
arameterPointer:src/openvpn/route=2Ec:3947
+constParameterPointer:src/openv=
pn/tun=2Ec:560
+constParameterPointer:src/openvpn/tun=2Ec:2188
+constParame=
terPointer:src/openvpn/tun_afunix=2Ec
+# IGN: not a FP but the documentatio=
n for the FP_ISSET claims this is not const=2E=2E=2E
+constParameterPointer=
:src/openvpn/event=2Ec:1015
+# FP: we play around with const in the interfa=
ce too much
+# also hides: fun:check_malloc_return: causes -Wmaybe-uninitia=
lized in MinGW Debug build
+constParameterPointer:src/openvpn/buffer=2Eh
+#=
 FP: const silently removed due to pointer arithmentic
+constParameterPoint=
er:src/openvpn/buffer=2Ec:273
 # IGN: Windows specific (unsigned long =3D=
=3D unsigned int)
 compareValueOutOfTypeRangeError:src/openvpn/ssl_verify=
=2Ec:928
 # FP: cppcheck seems to have wrong signature of DeviceIoControl()=

diff --git a/sample/sample-plugins/client-connect/sample-client-connect=2E=
c b/sample/sample-plugins/client-connect/sample-client-connect=2Ec
index 42=
0de61=2E=2Ecbd98e8 100644
--- a/sample/sample-plugins/client-connect/sample=
-client-connect=2Ec
+++ b/sample/sample-plugins/client-connect/sample-clien=
t-connect=2Ec
@@ -344,7 +344,7 @@
 }
 
 int
-openvpn_plugin_client_connect(=
struct plugin_context *context, const char **argv, const char **envp)
+open=
vpn_plugin_client_connect(const struct plugin_context *context, const char =
**argv, const char **envp)
 {
     /* log environment variables handed to u=
s by OpenVPN, but
      * only if "setenv verb" is 3 or higher (arbitrary n=
umber)
@@ -465,7 +465,7 @@
 
 int
 openvpn_plugin_client_connect_defer_v2(s=
truct plugin_context *context,
-                                       stru=
ct plugin_per_client_context *pcc,
+                                       =
const struct plugin_per_client_context *pcc,
                              =
          struct openvpn_plugin_string_list **return_list)
 {
     time_t t=
ime_left =3D pcc->sleep_until - time(NULL);
diff --git a/sample/sample-plug=
ins/defer/multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec
index=
 bacf557=2E=2Ecdd616f 100644
--- a/sample/sample-plugins/defer/multi-auth=
=2Ec
+++ b/sample/sample-plugins/defer/multi-auth=2Ec
@@ -255,7 +255,7 @@
 =
}
 
 static bool
-do_auth_user_pass(struct plugin_context *context, const c=
har *username, const char *password)
+do_auth_user_pass(const struct plugin=
_context *context, const char *username, const char *password)
 {
     plog=
(context, PLOG_NOTE, "expect_user=3D%s, received_user=3D%s, expect_passw=3D=
%s, received_passw=3D%s",
          np(context->test_valid_user), np(userna=
me), np(context->test_valid_pass), np(password));
@@ -279,7 +279,7 @@
 
 
 =
static int
-auth_user_pass_verify(struct plugin_context *context, struct pl=
ugin_per_client_context *pcc,
+auth_user_pass_verify(const struct plugin_co=
ntext *context, struct plugin_per_client_context *pcc,
                    =
   const char *argv[], const char *envp[])
 {
     /* get username/password=
 from envp string array */
diff --git a/sample/sample-plugins/keying-materi=
al-exporter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/keying-=
material-exporter-demo/keyingmaterialexporter=2Ec
index 25c9ff5=2E=2E512861=
a 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingma=
terialexporter=2Ec
+++ b/sample/sample-plugins/keying-material-exporter-dem=
o/keyingmaterialexporter=2Ec
@@ -186,7 +186,7 @@
 }
 
 static void
-file_st=
ore(char *file, char *content)
+file_store(const char *file, const char *co=
ntent)
 {
     FILE *f;
     if (!(f =3D fopen(file, "w+")))
@@ -202,7 +202=
,7 @@
 server_store(struct openvpn_plugin_args_func_in const *args)
 {
    =
 struct plugin *plugin =3D (struct plugin *)args->handle;
-    struct sessi=
on *sess =3D (struct session *)args->per_client_context;
+    const struct =
session *sess =3D (struct session *)args->per_client_context;
 
     char f=
ile[MAXPATH];
     snprintf(file, sizeof(file) - 1, "/tmp/openvpn_sso_%s", =
sess->key);
@@ -214,7 +214,7 @@
 client_store(struct openvpn_plugin_args_fu=
nc_in const *args)
 {
     struct plugin *plugin =3D (struct plugin *)args-=
>handle;
-    struct session *sess =3D (struct session *)args->per_client_c=
ontext;
+    const struct session *sess =3D (struct session *)args->per_cli=
ent_context;
 
     char *file =3D "/tmp/openvpn_sso_user";
     ovpn_note(=
"app session file: %s", file);
diff --git a/src/openvpn/buffer=2Eh b/src/op=
envpn/buffer=2Eh
index 22a8b74=2E=2E44ed434 100644
--- a/src/openvpn/buffer=
=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1918,7 +1918,7 @@
  * @param a  The a=
rena to test=2E
  */
 static inline bool
-gc_defined(struct gc_arena *a)
+g=
c_defined(const struct gc_arena *a)
 {
     return a->list !=3D NULL;
 }
di=
ff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec
index 3724022=2E=
=2E9fa8f5f 100644
--- a/src/openvpn/clinat=2Ec
+++ b/src/openvpn/clinat=2Ec=

@@ -159,7 +159,7 @@
 #endif
 
 static void
-print_pkt(struct openvpn_iphdr=
 *iph, const char *prefix, const int direction, const msglvl_t msglevel)
+p=
rint_pkt(const struct openvpn_iphdr *iph, const char *prefix, const int dir=
ection, const msglvl_t msglevel)
 {
     struct gc_arena gc =3D gc_new();
 =

diff --git a/src/openvpn/comp=2Ec b/src/openvpn/comp=2Ec
index b88b79f=2E=
=2E387a7c4 100644
--- a/src/openvpn/comp=2Ec
+++ b/src/openvpn/comp=2Ec
@@ =
-159,7 +159,7 @@
 #endif /* USE_COMP */
 
 bool
-check_compression_settings=
_valid(struct compress_options *info, msglvl_t msglevel)
+check_compression=
_settings_valid(const struct compress_options *info, msglvl_t msglevel)
 {
=
     /*
      * We also allow comp-stub-v2 here as it technically allows es=
caping of
diff --git a/src/openvpn/comp=2Eh b/src/openvpn/comp=2Eh
index 29=
a90a2=2E=2Ead80243 100644
--- a/src/openvpn/comp=2Eh
+++ b/src/openvpn/comp=
=2Eh
@@ -91,7 +91,7 @@
  * flags of allow-compression and also the whether =
algorithms are compiled
  * in
  */
-bool check_compression_settings_valid(=
struct compress_options *info, msglvl_t msglevel);
+bool check_compression_=
settings_valid(const struct compress_options *info, msglvl_t msglevel);
 
 =
#ifdef USE_COMP
 #include "buffer=2Eh"
diff --git a/src/openvpn/crypto=2Ec =
b/src/openvpn/crypto=2Ec
index e5ad31a=2E=2Ee29d581 100644
--- a/src/openvp=
n/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1105,7 +1105,7 @@
 }
 
 stati=
c bool
-key_is_zero(struct key *key, const struct key_type *kt)
+key_is_zer=
o(const struct key *key, const struct key_type *kt)
 {
     size_t cipher_l=
ength =3D cipher_kt_key_size(kt->cipher);
     for (size_t i =3D 0; i < cip=
her_length; ++i)
@@ -1123,7 +1123,7 @@
  * Make sure that cipher key is a v=
alid key for current key_type=2E
  */
 bool
-check_key(struct key *key, con=
st struct key_type *kt)
+check_key(const struct key *key, const struct key_=
type *kt)
 {
     if (cipher_defined(kt->cipher))
     {
@@ -1196,7 +1196,7=
 @@
 }
 
 void
-test_crypto(struct crypto_options *co, struct frame *frame)=

+test_crypto(struct crypto_options *co, const struct frame *frame)
 {
    =
 int i, j;
     struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/c=
rypto=2Eh b/src/openvpn/crypto=2Eh
index ee5b50f=2E=2Ee3c1c6a 100644
--- a/=
src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -414,7 +414,7 @@
  *=
/
 int write_key_file(const int nkeys, const char *filename);
 
-bool check=
_key(struct key *key, const struct key_type *kt);
+bool check_key(const str=
uct key *key, const struct key_type *kt);
 
 /**
  * Initialize a key_type =
structure with=2E
@@ -614,7 +614,7 @@
 /** Print a cipher list entry */
 vo=
id print_cipher(const char *cipher);
 
-void test_crypto(struct crypto_opti=
ons *co, struct frame *f);
+void test_crypto(struct crypto_options *co, con=
st struct frame *f);
 
 
 /* key direction functions */
diff --git a/src/op=
envpn/dco=2Ec b/src/openvpn/dco=2Ec
index 8eae4bf=2E=2E3bf1fb2 100644
--- a=
/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -573,7 +573,7 @@
 }
 
 st=
atic bool
-dco_multi_get_localaddr(struct multi_context *m, struct multi_in=
stance *mi,
+dco_multi_get_localaddr(const struct multi_context *m, const s=
truct multi_instance *mi,
                         struct sockaddr_storage =
*local)
 {
 #if ENABLE_IP_PKTINFO
@@ -585,7 +585,7 @@
         return false=
;
     }
 
-    struct link_socket_actual *actual =3D &c->c2=2Elink_socket_=
infos[0]->lsa->actual;
+    const struct link_socket_actual *actual =3D &c-=
>c2=2Elink_socket_infos[0]->lsa->actual;
 
     switch (actual->dest=2Eaddr=
=2Esa=2Esa_family)
     {
@@ -623,7 +623,7 @@
 }
 
 int
-dco_multi_add_new_=
peer(struct multi_context *m, struct multi_instance *mi)
+dco_multi_add_new=
_peer(const struct multi_context *m, struct multi_instance *mi)
 {
     con=
st struct context *c =3D &mi->context;
 
@@ -677,7 +677,7 @@
 }
 
 void
-dc=
o_install_iroute(struct multi_context *m, struct multi_instance *mi, struct=
 mroute_addr *addr)
+dco_install_iroute(struct multi_context *m, struct mul=
ti_instance *mi, const struct mroute_addr *addr)
 {
 #if defined(TARGET_LIN=
UX) || defined(TARGET_FREEBSD) || defined(_WIN32)
     if (!dco_enabled(&m-=
>top=2Eoptions))
@@ -796,7 +796,7 @@
         /* Checked if we added a host=
 route as the assigned client IP address was
          * outside the --ifco=
nfig-ipv6 tun interface config */
 #if !defined(_WIN32)
-        struct in6=
_addr *dest =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
+        cons=
t struct in6_addr *dest =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
 =
        if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest))
         =
{
             /* On windows we do not install these routes, so we also do =
not need to delete them */
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/d=
co=2Eh
index 4e5aad5=2E=2E694875c 100644
--- a/src/openvpn/dco=2Eh
+++ b/sr=
c/openvpn/dco=2Eh
@@ -204,7 +204,7 @@
  * @param mi        the client insta=
nce
  * @return          0 on success or a negative error code otherwise
  =
*/
-int dco_multi_add_new_peer(struct multi_context *m, struct multi_instan=
ce *mi);
+int dco_multi_add_new_peer(const struct multi_context *m, struct =
multi_instance *mi);
 
 /**
  * Install an iroute in DCO, which means addin=
g a route to the system routing
@@ -215,7 +215,7 @@
  * @param addr      th=
e route to add
  */
 void dco_install_iroute(struct multi_context *m, struc=
t multi_instance *mi,
-                        struct mroute_addr *addr);
+=
                        const struct mroute_addr *addr);
 
 /**
  * Remove =
all routes added through the specified client
@@ -253,7 +253,7 @@
  * a 64 =
bit packet counter and AEAD tag at the end=2E
  */
 bool
-dco_supports_epoc=
h_data(struct context *c);
+dco_supports_epoch_data(const struct context *c=
);
 #else  /* if defined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ =
-350,7 +350,7 @@
 }
 
 static inline int
-dco_multi_add_new_peer(struct mul=
ti_context *m, struct multi_instance *mi)
+dco_multi_add_new_peer(const str=
uct multi_context *m, struct multi_instance *mi)
 {
     return 0;
 }
@@ -3=
84,7 +384,7 @@
 }
 
 static inline bool
-dco_supports_epoch_data(struct con=
text *c)
+dco_supports_epoch_data(const struct context *c)
 {
     return f=
alse;
 }
diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=
=2Ec
index d933aaf=2E=2E7346903 100644
--- a/src/openvpn/dco_freebsd=2Ec
++=
+ b/src/openvpn/dco_freebsd=2Ec
@@ -930,7 +930,7 @@
 }
 
 bool
-dco_support=
s_epoch_data(struct context *c)
+dco_supports_epoch_data(const struct conte=
xt *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_internal=2Eh b=
/src/openvpn/dco_internal=2Eh
index fcf8aca=2E=2E1022e66 100644
--- a/src/o=
penvpn/dco_internal=2Eh
+++ b/src/openvpn/dco_internal=2Eh
@@ -59,8 +59,9 @=
@
  * They are implemented by dco_linux=2Ec
  */
 
-int dco_new_peer(dco_co=
ntext_t *dco, unsigned int peerid, socket_descriptor_t sd, struct sockaddr =
*localaddr,
-                 struct sockaddr *remoteaddr, const struct in_=
addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
+int dco_new_peer(dco_con=
text_t *dco, unsigned int peerid, socket_descriptor_t sd,
+                =
 struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+                =
 const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
 
 int d=
co_del_peer(dco_context_t *dco, unsigned int peerid);
 
diff --git a/src/op=
envpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 56f6259=2E=2E31bbe87 =
100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -=
114,7 +114,7 @@
 }
 
 static struct nl_msg *
-ovpn_dco_nlmsg_create(dco_con=
text_t *dco, uint8_t cmd)
+ovpn_dco_nlmsg_create(const dco_context_t *dco, =
uint8_t cmd)
 {
     struct nl_msg *nl_msg =3D nlmsg_alloc();
     if (!nl_=
msg)
@@ -804,7 +804,7 @@
 
 /* libnl < 3=2E11=2E0 does not implement nla_ge=
t_uint() */
 static uint64_t
-ovpn_nla_get_uint(struct nlattr *attr)
+ovpn_=
nla_get_uint(const struct nlattr *attr)
 {
     if (nla_len(attr) =3D=3D si=
zeof(uint32_t))
     {
@@ -916,7 +916,7 @@
 }
 
 static bool
-ovpn_iface_ch=
eck(dco_context_t *dco, struct nlattr *attrs[])
+ovpn_iface_check(const dco=
_context_t *dco, struct nlattr *attrs[])
 {
     /* we must know which inte=
rface this message is referring to in order to
      * avoid mixing message=
s for other instances
@@ -1340,7 +1340,7 @@
 }
 
 bool
-dco_supports_epoch_=
data(struct context *c)
+dco_supports_epoch_data(const struct context *c)
 =
{
     return false;
 }
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/=
dco_win=2Ec
index b3268bc=2E=2E8deb9d8 100644
--- a/src/openvpn/dco_win=2Ec=

+++ b/src/openvpn/dco_win=2Ec
@@ -1100,7 +1100,7 @@
 }
 
 bool
-dco_suppor=
ts_epoch_data(struct context *c)
+dco_supports_epoch_data(const struct cont=
ext *c)
 {
     OVPN_VERSION ver =3D { 0 };
     return dco_get_version(&ve=
r) && ((ver=2EMajor =3D=3D 2 && ver=2EMinor >=3D 8) || (ver=2EMajor > 2));
=
diff --git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh
index b784dfe=2E=
=2E0940a1d 100644
--- a/src/openvpn/event=2Eh
+++ b/src/openvpn/event=2Eh
@=
@ -204,7 +204,7 @@
 #else /* ifdef _WIN32 */
 
 static inline void
-wait_si=
gnal(struct event_set *es, void *arg)
+wait_signal(const struct event_set *=
es, const void *arg)
 {
 }
 
diff --git a/src/openvpn/forward=2Ec b/src/ope=
nvpn/forward=2Ec
index 83cd113=2E=2E56fc124 100644
--- a/src/openvpn/forwar=
d=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -231,7 +231,7 @@
 }
 
 static void
-=
parse_incoming_control_channel_command(struct context *c, struct buffer *bu=
f)
+parse_incoming_control_channel_command(struct context *c, const struct =
buffer *buf)
 {
     if (buf_string_match_head_str(buf, "AUTH_FAILED"))
   =
  {
@@ -501,7 +501,7 @@
 }
 
 int
-get_server_poll_remaining_time(struct ev=
ent_timeout *server_poll_timeout)
+get_server_poll_remaining_time(const str=
uct event_timeout *server_poll_timeout)
 {
     update_time();
     int rem=
aining =3D event_timeout_remaining(server_poll_timeout);
@@ -598,7 +598,7 @=
@
  * Buffer reallocation, for use with null encryption=2E
  */
 static inl=
ine void
-buffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub=
, struct buffer *src_stub,
+buffer_turnover(const uint8_t *orig_buf, struct=
 buffer *dest_stub, const struct buffer *src_stub,
                 struct =
buffer *storage)
 {
     if (orig_buf =3D=3D src_stub->data && src_stub->da=
ta !=3D storage->data)
@@ -885,7 +885,7 @@
  */
 
 static inline void
-sock=
s_postprocess_incoming_link(struct context *c, struct link_socket *sock)
+s=
ocks_postprocess_incoming_link(struct context *c, const struct link_socket =
*sock)
 {
     if (sock->socks_proxy && sock->info=2Eproto =3D=3D PROTO_UDP=
)
     {
@@ -982,7 +982,7 @@
 }
 
 bool
-process_incoming_link_part1(struct=
 context *c, struct link_socket_info *lsi, bool floated)
+process_incoming_=
link_part1(struct context *c, const struct link_socket_info *lsi, bool floa=
ted)
 {
     struct gc_arena gc =3D gc_new();
     bool decrypt_status =3D =
false;
@@ -1532,7 +1532,7 @@
  * @param client    Determines whether to the=
 send packet back via tun or link
  */
 void
-ipv6_send_icmp_unreachable(st=
ruct context *c, struct buffer *buf, bool client)
+ipv6_send_icmp_unreachab=
le(struct context *c, const struct buffer *buf, bool client)
 {
 #define MA=
X_ICMPV6LEN 1280
     struct openvpn_icmp6hdr icmp6out;
diff --git a/src/op=
envpn/forward=2Eh b/src/openvpn/forward=2Eh
index 324c0b4=2E=2Eee7d2e2 1006=
44
--- a/src/openvpn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -127,7 +1=
27,7 @@
  */
 void encrypt_sign(struct context *c, bool comp_frag);
 
-int =
get_server_poll_remaining_time(struct event_timeout *server_poll_timeout);
=
+int get_server_poll_remaining_time(const struct event_timeout *server_poll=
_timeout);
 
 /************************************************************=
**********/
 /**
@@ -178,7 +178,7 @@
  *
  * @return true if packet is auth=
enticated, false otherwise=2E
  */
-bool process_incoming_link_part1(struct=
 context *c, struct link_socket_info *lsi, bool floated);
+bool process_inc=
oming_link_part1(struct context *c, const struct link_socket_info *lsi, boo=
l floated);
 
 /**
  * Continues processing a packet read from the external=
 network interface=2E
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec
index 453ee7e=2E=2E525c135 100644
--- a/src/openvpn/init=2Ec
+++ b/src=
/openvpn/init=2Ec
@@ -803,7 +803,7 @@
 }
 
 static void
-init_port_share(st=
ruct context *c)
+init_port_share(const struct context *c)
 {
     if (!por=
t_share && (c->options=2Eport_share_host && c->options=2Eport_share_port))
=
     {
@@ -1245,7 +1245,7 @@
  * prepending to msg() output=2E
  */
 const =
char *
-format_common_name(struct context *c, struct gc_arena *gc)
+format_=
common_name(const struct context *c, struct gc_arena *gc)
 {
     struct bu=
ffer out =3D alloc_buf_gc(256, gc);
     if (c->c2=2Etls_multi)
@@ -1731,7 =
+1731,7 @@
 
 
 static bool
-can_preserve_tun(struct tuntap *tt)
+can_prese=
rve_tun(const struct tuntap *tt)
 {
     if (tt && tt->backend_driver =3D=
=3D DRIVER_AFUNIX)
     {
@@ -1753,7 +1753,7 @@
  * @param c pointer to the=
 connection context
  */
 static void
-add_wfp_block(struct context *c)
+ad=
d_wfp_block(const struct context *c)
 {
 #if defined(_WIN32)
     /* Fortif=
y 'redirect-gateway block-local' with firewall rules? */
@@ -1779,7 +1779,7=
 @@
  * @param adapter_index the VPN adapter index
  */
 static void
-del_w=
fp_block(struct context *c, unsigned long adapter_index)
+del_wfp_block(con=
st struct context *c, unsigned long adapter_index)
 {
 #if defined(_WIN32)
=
     if (c->options=2Eblock_outside_dns || block_local_needed(c->c1=2Eroute=
_list))
diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
index ce8f=
74e=2E=2Ec486158 100644
--- a/src/openvpn/init=2Eh
+++ b/src/openvpn/init=
=2Eh
@@ -91,7 +91,7 @@
 
 uint64_t pull_permission_mask(const struct contex=
t *c);
 
-const char *format_common_name(struct context *c, struct gc_arena=
 *gc);
+const char *format_common_name(const struct context *c, struct gc_a=
rena *gc);
 
 void reset_coarse_timers(struct context *c);
 
diff --git a/s=
rc/openvpn/interval=2Eh b/src/openvpn/interval=2Eh
index 59051bd=2E=2E0cfe2=
02 100644
--- a/src/openvpn/interval=2Eh
+++ b/src/openvpn/interval=2Eh
@@ =
-89,7 +89,7 @@
 }
 
 static inline void
-interval_schedule_wakeup(struct in=
terval *top, interval_t *wakeup)
+interval_schedule_wakeup(const struct int=
erval *top, interval_t *wakeup)
 {
     const time_t local_now =3D now;
   =
  interval_earliest_wakeup(wakeup, top->last_test_true + top->refresh, loca=
l_now);
@@ -214,7 +214,7 @@
  * This function does not check if the timeout=
 is actually valid=2E
  */
 static inline interval_t
-event_timeout_remaini=
ng(struct event_timeout *et)
+event_timeout_remaining(const struct event_ti=
meout *et)
 {
     return (interval_t)((et->last + et->n) - now);
 }
diff -=
-git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index e51dcd0=2E=2Edcd59=
d7 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -164,7 +=
164,7 @@
 }
 
 void
-hash_remove_by_value(struct hash *hash, void *value)
+=
hash_remove_by_value(struct hash *hash, const void *value)
 {
     struct h=
ash_iterator hi;
     const struct hash_element *he;
diff --git a/src/openv=
pn/list=2Eh b/src/openvpn/list=2Eh
index 55bc3c8=2E=2E23267d0 100644
--- a/=
src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -78,7 +78,7 @@
 
 bool h=
ash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const void *=
key, uint64_t hv);
 
-void hash_remove_by_value(struct hash *hash, void *va=
lue);
+void hash_remove_by_value(struct hash *hash, const void *value);
 
 =
struct hash_iterator
 {
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/m=
anage=2Ec
index 8e46470=2E=2E81a60a7 100644
--- a/src/openvpn/manage=2Ec
++=
+ b/src/openvpn/manage=2Ec
@@ -330,7 +330,7 @@
 }
 
 static void
-man_delet=
e_unix_socket(struct management *man)
+man_delete_unix_socket(const struct =
management *man)
 {
 #if UNIX_SOCK_SUPPORT
     if ((man->settings=2Eflags =
& (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
@@ -675,7 +67=
5,7 @@
  * for the log and echo commands=2E
  */
 static void
-man_history(=
struct management *man, const char *parm, const char *type, struct log_hist=
ory *log,
+man_history(struct management *man, const char *parm, const char=
 *type, const struct log_history *log,
             bool *realtime, const u=
nsigned int lep_flags)
 {
     struct gc_arena gc =3D gc_new();
@@ -851,7 +=
851,7 @@
 }
 
 static void
-man_net(struct management *man)
+man_net(const =
struct management *man)
 {
     if (man->persist=2Ecallback=2Eshow_net)
   =
  {
@@ -887,7 +887,7 @@
 #ifdef ENABLE_PKCS11
 
 static void
-man_pkcs11_id=
_count(struct management *man)
+man_pkcs11_id_count(const struct management=
 *man)
 {
     msg(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_management_id_cou=
nt());
 }
@@ -2363,7 +2363,7 @@
  * the route/ifconfig/open tun command=2E =
  See doc/android=2Etxt for details=2E
  */
 bool
-management_android_contr=
ol(struct management *man, const char *command, const char *msg)
+managemen=
t_android_control(const struct management *man, const char *command, const =
char *msg)
 {
     if (!man)
     {
@@ -3010,7 +3010,7 @@
 }
 
 void
-manag=
ement_up_down(struct management *man, const char *updown, const struct env_=
set *es)
+management_up_down(const struct management *man, const char *updo=
wn, const struct env_set *es)
 {
     if (man->settings=2Eflags & MF_UP_DOW=
N)
     {
@@ -3112,7 +3112,8 @@
 }
 
 void
-management_notify_client_close(=
struct management *management, struct man_def_auth_context *mdac,
+manageme=
nt_notify_client_close(const struct management *management,
+              =
                 struct man_def_auth_context *mdac,
                       =
         const struct env_set *es)
 {
     if ((mdac->flags & DAF_INITIAL_A=
UTH) && !(mdac->flags & DAF_CONNECTION_CLOSED))
@@ -3203,7 +3204,7 @@
 }
 
=
 void
-management_auth_failure(struct management *man, const char *type, co=
nst char *reason)
+management_auth_failure(const struct management *man, co=
nst char *type, const char *reason)
 {
     if (reason)
     {
diff --git a=
/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 3ab937c=2E=2E8aa5c87=
 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -368,7=
 +368,7 @@
                                 const unsigned int flags, const=
 char *static_challenge);
 
 #ifdef TARGET_ANDROID
-bool management_android=
_control(struct management *man, const char *command, const char *msg);
+bo=
ol management_android_control(const struct management *man, const char *com=
mand, const char *msg);
 
 #define ANDROID_KEEP_OLD_TUN      1
 #define AND=
ROID_OPEN_BEFORE_CLOSE 2
@@ -382,7 +382,7 @@
 
 void management_event_loop_=
n_seconds(struct management *man, int sec);
 
-void management_up_down(stru=
ct management *man, const char *updown, const struct env_set *es);
+void ma=
nagement_up_down(const struct management *man, const char *updown, const st=
ruct env_set *es);
 
 void management_notify(const char *severity, const ch=
ar *type,
                        const char *text);
@@ -397,7 +397,7 @@
 v=
oid management_connection_established(struct management *management,
      =
                                  struct man_def_auth_context *mdac, const =
struct env_set *es);
 
-void management_notify_client_close(struct manageme=
nt *management,
+void management_notify_client_close(const struct managemen=
t *management,
                                     struct man_def_auth_con=
text *mdac, const struct env_set *es);
 
 void management_learn_addr(struct=
 man_def_auth_context *mdac,
@@ -482,7 +482,7 @@
  * OpenVPN calls here to =
indicate a password failure
  */
 
-void management_auth_failure(struct man=
agement *man, const char *type, const char *reason);
+void management_auth_=
failure(const struct management *man, const char *type, const char *reason)=
;
 
 /*
  * Echo an authentication token to management interface
diff --git=
 a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec
index 7b790ed=2E=2E9a37e30 1=
00644
--- a/src/openvpn/mbuf=2Ec
+++ b/src/openvpn/mbuf=2Ec
@@ -149,7 +149,=
7 @@
 }
 
 void
-mbuf_dereference_instance(struct mbuf_set *ms, struct mult=
i_instance *mi)
+mbuf_dereference_instance(struct mbuf_set *ms, const struc=
t multi_instance *mi)
 {
     if (ms)
     {
diff --git a/src/openvpn/mbuf=
=2Eh b/src/openvpn/mbuf=2Eh
index cfe698c=2E=2Ee368054 100644
--- a/src/ope=
nvpn/mbuf=2Eh
+++ b/src/openvpn/mbuf=2Eh
@@ -75,7 +75,7 @@
 
 bool mbuf_ext=
ract_item(struct mbuf_set *ms, struct mbuf_item *item);
 
-void mbuf_derefe=
rence_instance(struct mbuf_set *ms, struct multi_instance *mi);
+void mbuf_=
dereference_instance(struct mbuf_set *ms, const struct multi_instance *mi);=

 
 static inline bool
 mbuf_defined(const struct mbuf_set *ms)
diff --git =
a/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec
index 36bbb43=2E=2E0cfa272d 100=
644
--- a/src/openvpn/mss=2Ec
+++ b/src/openvpn/mss=2Ec
@@ -239,8 +239,8 @@=

 }
 
 static void
-frame_calculate_fragment(struct frame *frame, struct ke=
y_type *kt, const struct options *options,
-                         struct=
 link_socket_info *lsi)
+frame_calculate_fragment(struct frame *frame, cons=
t struct key_type *kt, const struct options *options,
+                    =
     const struct link_socket_info *lsi)
 {
 #if defined(ENABLE_FRAGMENT)
 =
    size_t overhead;
@@ -269,8 +269,8 @@
 }
 
 static void
-frame_calculate=
_mssfix(struct frame *frame, struct key_type *kt, const struct options *opt=
ions,
-                       struct link_socket_info *lsi)
+frame_calculat=
e_mssfix(struct frame *frame, const struct key_type *kt, const struct optio=
ns *options,
+                       const struct link_socket_info *lsi)
 {=

     if (options->ce=2Emssfix_fixed)
     {
@@ -314,8 +314,8 @@
 }
 
 void=

-frame_calculate_dynamic(struct frame *frame, struct key_type *kt, const s=
truct options *options,
-                        struct link_socket_info *l=
si)
+frame_calculate_dynamic(struct frame *frame, const struct key_type *kt=
, const struct options *options,
+                        const struct link=
_socket_info *lsi)
 {
     if (options->ce=2Efragment > 0)
     {
diff --gi=
t a/src/openvpn/mss=2Eh b/src/openvpn/mss=2Eh
index 1d092bb=2E=2E2eab55a 10=
0644
--- a/src/openvpn/mss=2Eh
+++ b/src/openvpn/mss=2Eh
@@ -36,8 +36,8 @@
=
 void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);
 
 /** Set the=
 --mssfix option=2E */
-void frame_calculate_dynamic(struct frame *frame, s=
truct key_type *kt,
-                             const struct options *opt=
ions, struct link_socket_info *lsi);
+void frame_calculate_dynamic(struct f=
rame *frame, const struct key_type *kt,
+                             const=
 struct options *options, const struct link_socket_info *lsi);
 
 /**
  * C=
hecks and adjusts the fragment and mssfix value according to the
diff --git=
 a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 5d88f8a=2E=2E922db3f 1=
00644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -91,7 +91,7 =
@@
 }
 
 bool
-multi_tcp_instance_specific_init(struct multi_context *m, st=
ruct multi_instance *mi)
+multi_tcp_instance_specific_init(const struct mul=
ti_context *m, struct multi_instance *mi)
 {
     /* buffer for queued TCP =
socket output packets */
     mi->tcp_link_out_deferred =3D mbuf_init(m->to=
p=2Eoptions=2En_bcast_buf);
diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn=
/mtcp=2Eh
index 9b7d1d2=2E=2Ebb117fa 100644
--- a/src/openvpn/mtcp=2Eh
+++ =
b/src/openvpn/mtcp=2Eh
@@ -35,7 +35,7 @@
 
 void multi_tcp_dereference_inst=
ance(struct multi_io *multi_io, struct multi_instance *mi);
 
-bool multi_t=
cp_instance_specific_init(struct multi_context *m, struct multi_instance *m=
i);
+bool multi_tcp_instance_specific_init(const struct multi_context *m, s=
truct multi_instance *mi);
 
 void multi_tcp_instance_specific_free(struct =
multi_instance *mi);
 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec
index de3d467=2E=2E5e37682 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src=
/openvpn/mudp=2Ec
@@ -53,8 +53,9 @@
  * @param sock    the socket to send t=
he reply on
  */
 static void
-send_standalone_reply(struct multi_context *=
m, struct buffer *buf, const char *prefix,
-                      const cha=
r *detail, struct link_socket *sock)
+send_standalone_reply(struct multi_co=
ntext *m, const struct buffer *buf,
+                      const char *pref=
ix, const char *detail,
+                      struct link_socket *sock)
 {=

     struct context *c =3D &m->top;
 
@@ -74,7 +75,7 @@
 
 static void
 se=
nd_hmac_reset_packet(struct multi_context *m, struct tls_pre_decrypt_state =
*state,
-                       struct tls_auth_standalone *tas, struct ses=
sion_id *sid,
+                       const struct tls_auth_standalone *tas=
, const struct session_id *sid,
                        bool request_resend=
_wkc, struct link_socket *sock)
 {
     reset_packet_id_send(&state->tls_wr=
ap_tmp=2Eopt=2Epacket_id=2Esend);
@@ -97,11 +98,11 @@
 
     enum first_pac=
ket_verdict verdict;
 
-    struct tls_auth_standalone *tas =3D m->top=2Ec2=
=2Etls_auth_standalone;
+    const struct tls_auth_standalone *tas =3D m->t=
op=2Ec2=2Etls_auth_standalone;
 
     verdict =3D tls_pre_decrypt_lite(tas,=
 state, &m->top=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
-    uint8_t *hmac_key =
=3D m->top=2Ec2=2Esession_id_key;
+    const uint8_t *hmac_key =3D m->top=
=2Ec2=2Esession_id_key;
     const struct openvpn_sockaddr *from =3D &m->to=
p=2Ec2=2Efrom=2Edest;
     int handwindow =3D m->top=2Eoptions=2Ehandshake_=
window;
 
@@ -218,7 +219,7 @@
 static struct multi_instance *
 handle_conne=
ction_attempt(struct multi_context *m,
                           struct li=
nk_socket *sock,
-                          struct mroute_addr *real)
+    =
                      const struct mroute_addr *real)
 {
     struct hash *=
hash =3D m->hash;
     struct tls_pre_decrypt_state state =3D { 0 };
@@ -28=
6,7 +287,7 @@
  * @return      instance matching the address, NULL otherwis=
e
  */
 static struct multi_instance *
-multi_get_instance_udp_real(struct =
multi_context *m, struct mroute_addr *real)
+multi_get_instance_udp_real(st=
ruct multi_context *m, const struct mroute_addr *real)
 {
     struct hash =
*hash =3D m->hash;
     struct hash_element *he;
@@ -320,7 +321,9 @@
  * ma=
intaining real address hash table atomicity=2E
  */
 struct multi_instance =
*
-multi_get_instance_udp_data(struct multi_context *m, bool *floated, stru=
ct mroute_addr *real, struct link_socket *sock)
+multi_get_instance_udp_dat=
a(struct multi_context *m, bool *floated,
+                            cons=
t struct mroute_addr *real,
+                            const struct link_=
socket *sock)
 {
     struct multi_instance *mi =3D NULL;
 
diff --git a/sr=
c/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 3e72b92=2E=2E89e2d4c 1006=
44
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -57,7 +57,7 @=
@
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
 static const char *
-id(struct multi_in=
stance *mi)
+id(const struct multi_instance *mi)
 {
     if (mi)
     {
@@ =
-1314,7 +1314,7 @@
  * same common name=2E
  */
 static void
-multi_delete_=
dup(struct multi_context *m, struct multi_instance *new_mi)
+multi_delete_d=
up(struct multi_context *m, const struct multi_instance *new_mi)
 {
     if=
 (new_mi)
     {
@@ -2259,7 +2259,7 @@
 }
 
 static bool
-multi_client_setu=
p_dco_initial(struct multi_context *m, struct multi_instance *mi,
+multi_cl=
ient_setup_dco_initial(const struct multi_context *m, struct multi_instance=
 *mi,
                                struct gc_arena *gc)
 {
     if (!dco=
_enabled(&mi->context=2Eoptions))
@@ -3078,7 +3078,8 @@
  * positive=2E
  *=
/
 static bool
-multi_check_dest_addr_allowed(struct multi_context *m, stru=
ct multi_instance *mi, struct mroute_addr *real)
+multi_check_dest_addr_all=
owed(struct multi_context *m, struct multi_instance *mi,
+                 =
             const struct mroute_addr *real)
 {
     struct hash *hash =3D =
m->hash;
     const uint64_t hv =3D hash_value(hash, real);
@@ -3237,7 +323=
8,7 @@
 
 #if defined(ENABLE_DCO)
 static void
-process_incoming_del_peer(s=
truct multi_context *m, struct multi_instance *mi, dco_context_t *dco)
+pro=
cess_incoming_del_peer(struct multi_context *m, struct multi_instance *mi, =
const dco_context_t *dco)
 {
     const char *reason =3D "ovpn-dco: unknown=
 reason";
     switch (dco->dco_del_peer_reason)
@@ -4291,7 +4292,7 @@
 
 /=
* Searches for the address and deletes it if it is owned by the multi_insta=
nce */
 static void
-multi_unlearn_addr(struct multi_context *m, struct mul=
ti_instance *mi, const struct mroute_addr *addr)
+multi_unlearn_addr(struct=
 multi_context *m, const struct multi_instance *mi, const struct mroute_add=
r *addr)
 {
     struct hash_element *he;
     const uint64_t hv =3D hash_v=
alue(m->vhash, addr);
@@ -4326,7 +4327,7 @@
  * @param a     The new IPv4 a=
ddress in network byte order
  */
 static void
-multi_unlearn_in_addr_t(str=
uct multi_context *m, struct multi_instance *mi, in_addr_t a)
+multi_unlear=
n_in_addr_t(struct multi_context *m, const struct multi_instance *mi, in_ad=
dr_t a)
 {
     struct mroute_addr addr;
     CLEAR(addr);
@@ -4344,7 +4345=
,7 @@
  * @param a6    The new IPv6 address
  */
 static void
-multi_unlear=
n_in6_addr(struct multi_context *m, struct multi_instance *mi, struct in6_a=
ddr a6)
+multi_unlearn_in6_addr(struct multi_context *m, const struct multi=
_instance *mi, struct in6_addr a6)
 {
     struct mroute_addr addr;
     CL=
EAR(addr);
@@ -4460,7 +4461,7 @@
 
 bool
 multi_check_push_ifconfig_ipv6_ex=
tra_route(struct multi_instance *mi,
-                                     =
      struct in6_addr *dest)
+                                           co=
nst struct in6_addr *dest)
 {
     const struct options *o =3D &mi->context=
=2Eoptions;
 
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
in=
dex 6cb86c7=2E=2E5b8d56a 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openv=
pn/multi=2Eh
@@ -517,7 +517,7 @@
  */
 
 static inline void
-set_prefix(str=
uct multi_instance *mi)
+set_prefix(const struct multi_instance *mi)
 {
 #i=
fdef MULTI_DEBUG_EVENT_LOOP
     if (mi->msg_prefix[0])
@@ -691,7 +691,7 @@=

  */
 bool
 multi_check_push_ifconfig_ipv6_extra_route(struct multi_instan=
ce *mi,
-                                           struct in6_addr *dest);=

+                                           const struct in6_addr *dest);
=
 
 /*
  * Check for signals=2E
diff --git a/src/openvpn/multi_io=2Ec b/src/=
openvpn/multi_io=2Ec
index 3604684=2E=2E52eb8c7 100644
--- a/src/openvpn/mu=
lti_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -159,7 +159,7 @@
  * a point-t=
o-multipoint tunnel=2E
  */
 static unsigned int
-p2mp_iow_flags(const stru=
ct multi_context *m, struct link_socket *sock)
+p2mp_iow_flags(const struct=
 multi_context *m, const struct link_socket *sock)
 {
     unsigned int fla=
gs =3D IOW_WAIT_SIGNAL;
 
diff --git a/src/openvpn/networking=2Eh b/src/ope=
nvpn/networking=2Eh
index bce0c19=2E=2E25233c8 100644
--- a/src/openvpn/net=
working=2Eh
+++ b/src/openvpn/networking=2Eh
@@ -44,7 +44,7 @@
  */
 #if !d=
efined(ENABLE_IPROUTE)
 static inline int
-net_ctx_init(struct context *c, =
openvpn_net_ctx_t *ctx)
+net_ctx_init(const struct context *c, openvpn_net_=
ctx_t *ctx)
 {
     (void)c;
     (void)ctx;
@@ -75,7 +75,7 @@
  *
  * @ret=
urn          0 on success, a negative error code otherwise
  */
-int net_ct=
x_init(struct context *c, openvpn_net_ctx_t *ctx);
+int net_ctx_init(const =
struct context *c, openvpn_net_ctx_t *ctx);
 
 /**
  * Release resources al=
located by the internal garbage collector
@@ -102,7 +102,7 @@
  * @return  =
        0 on success, negative error code on error
  */
 int net_iface_new(=
openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *type,=

-                  void *arg);
+                  const void *arg);
 
 /**=

  * Retrieve the interface type
diff --git a/src/openvpn/networking_iprout=
e2=2Ec b/src/openvpn/networking_iproute2=2Ec
index a1f3525=2E=2Ef091fb3 100=
644
--- a/src/openvpn/networking_iproute2=2Ec
+++ b/src/openvpn/networking_=
iproute2=2Ec
@@ -36,7 +36,7 @@
 #include <netinet/in=2Eh>
 
 int
-net_ctx_i=
nit(struct context *c, openvpn_net_ctx_t *ctx)
+net_ctx_init(const struct c=
ontext *c, openvpn_net_ctx_t *ctx)
 {
     ctx->es =3D NULL;
     if (c)
@@=
 -61,7 +61,7 @@
 }
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char=
 *iface, const char *type, void *arg)
+net_iface_new(openvpn_net_ctx_t *ctx=
, const char *iface, const char *type, const void *arg)
 {
     struct argv=
 argv =3D argv_new();
 
diff --git a/src/openvpn/networking_sitnl=2Ec b/src=
/openvpn/networking_sitnl=2Ec
index a396255=2E=2E13e0f0b 100644
--- a/src/o=
penvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -1007=
,7 +1007,7 @@
 }
 
 static int
-sitnl_addr_del(sa_family_t af_family, const=
 char *iface, inet_address_t *addr, int prefixlen)
+sitnl_addr_del(sa_famil=
y_t af_family, const char *iface, const inet_address_t *addr, int prefixlen=
)
 {
     int ifindex;
 
@@ -1250,8 +1250,8 @@
 }
 
 static int
-sitnl_rout=
e_del(const char *iface, sa_family_t af_family, inet_address_t *dst, int pr=
efixlen,
-                inet_address_t *gw, uint32_t table, int metric)
+=
sitnl_route_del(const char *iface, sa_family_t af_family, const inet_addres=
s_t *dst, int prefixlen,
+                const inet_address_t *gw, uint32_=
t table, int metric)
 {
     int ifindex =3D 0;
 
@@ -1328,7 +1328,7 @@
 
 =

 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char =
*type, void *arg)
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface,=
 const char *type, const void *arg)
 {
     struct sitnl_link_req req =3D {=
};
     int ret =3D -1;
diff --git a/src/openvpn/occ=2Eh b/src/openvpn/occ=
=2Eh
index bda4f18=2E=2E49def4d 100644
--- a/src/openvpn/occ=2Eh
+++ b/src/=
openvpn/occ=2Eh
@@ -156,7 +156,7 @@
  * via control channel=2E
  * @return =
control channel exit message should be used */
 static inline bool
-cc_exit=
_notify_enabled(struct context *c)
+cc_exit_notify_enabled(const struct con=
text *c)
 {
     /* Check if we have TLS active at all */
     if (!c->c2=
=2Etls_multi)
diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/ope=
nssl_compat=2Eh
index 098bdd5=2E=2E1a934db 100644
--- a/src/openvpn/openssl=
_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -127,7 +127,7 @@
 /* Mi=
mics the functions but only when the default context without
  * options is=
 chosen */
 static inline const EVP_CIPHER *
-EVP_CIPHER_fetch(void *ctx, c=
onst char *algorithm, const char *properties)
+EVP_CIPHER_fetch(const void =
*ctx, const char *algorithm, const char *properties)
 {
     ASSERT(!ctx);
=
     ASSERT(!properties);
@@ -135,7 +135,7 @@
 }
 
 static inline const EVP=
_MD *
-EVP_MD_fetch(void *ctx, const char *algorithm, const char *propertie=
s)
+EVP_MD_fetch(const void *ctx, const char *algorithm, const char *proper=
ties)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
diff --git a/src/open=
vpn/options=2Ec b/src/openvpn/options=2Ec
index 8d8bba7=2E=2Eef7e063 100644=

--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -2423,7 +24=
23,7 @@
 }
 
 static void
-options_postprocess_mutate_le(struct connection_=
entry *ce, struct local_entry *le, int mode)
+options_postprocess_mutate_le=
(const struct connection_entry *ce, struct local_entry *le, int mode)
 {
  =
   /* use the global port if none is specified */
     if (!le->port)
@@ -3=
576,7 +3576,7 @@
 static bool
 verify_permission(const char *name, const ch=
ar *file, int line, const uint64_t type,
                   const uint64_t =
allowed, uint64_t *found, const msglvl_t msglevel,
-                  struc=
t options *options, bool is_inline)
+                  const struct options=
 *options, bool is_inline)
 {
     if (!(type & allowed))
     {
@@ -4143,7=
 +4143,7 @@
 }
 
 static void
-show_compression_warning(struct compress_opt=
ions *info)
+show_compression_warning(const struct compress_options *info)
=
 {
     if (comp_non_stub_enabled(info))
     {
diff --git a/src/openvpn/op=
tions_parse=2Ec b/src/openvpn/options_parse=2Ec
index 88ab4d2=2E=2E0e94522 =
100644
--- a/src/openvpn/options_parse=2Ec
+++ b/src/openvpn/options_parse=
=2Ec
@@ -258,7 +258,7 @@
 }
 
 static char *
-read_inline_file(struct in_sr=
c *is, const char *close_tag, int *num_lines, struct gc_arena *gc)
+read_in=
line_file(const struct in_src *is, const char *close_tag, int *num_lines, s=
truct gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE];
     struct buffer=
 buf =3D alloc_buf(8 * OPTION_LINE_SIZE);
@@ -302,7 +302,7 @@
 }
 
 static =
int
-check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
+=
check_inline_file(const struct in_src *is, char *p[], struct gc_arena *gc)
=
 {
     int num_inline_lines =3D 0;
 
diff --git a/src/openvpn/otime=2Ec b/=
src/openvpn/otime=2Ec
index 1608458=2E=2E5d3633c 100644
--- a/src/openvpn/o=
time=2Ec
+++ b/src/openvpn/otime=2Ec
@@ -66,7 +66,7 @@
 }
 
 void
-update_n=
ow_usec(struct timeval *tv)
+update_now_usec(const struct timeval *tv)
 {
 =
    const time_t last =3D now;
     update_now(tv->tv_sec);
diff --git a/sr=
c/openvpn/otime=2Eh b/src/openvpn/otime=2Eh
index d14f01e=2E=2E74d21ff 1006=
44
--- a/src/openvpn/otime=2Eh
+++ b/src/openvpn/otime=2Eh
@@ -65,7 +65,7 @=
@
 void update_now(const time_t system_time);
 
 extern time_t now_usec;
-v=
oid update_now_usec(struct timeval *tv);
+void update_now_usec(const struct=
 timeval *tv);
 
 static inline int
 openvpn_gettimeofday(struct timeval *t=
v, void *tz)
diff --git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh
ind=
ex 9bb0866=2E=2E1665751 100644
--- a/src/openvpn/proto=2Eh
+++ b/src/openvp=
n/proto=2Eh
@@ -248,7 +248,7 @@
  * and offset of IP header (via parameter)=
=2E
  */
 static inline int
-get_tun_ip_ver(int tunnel_type, struct buffer =
*buf, int *ip_hdr_offset)
+get_tun_ip_ver(int tunnel_type, const struct buf=
fer *buf, int *ip_hdr_offset)
 {
     int ip_ver =3D -1;
 
diff --git a/src=
/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index e0700aa=2E=2E5e13d1f 10064=
4
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -527,8 +527,9 =
@@
 }
 
 static bool
-add_proxy_headers(struct http_proxy_info *p, socket_d=
escriptor_t sd, /* already open to proxy */
-                  const char *=
host                                   /* openvpn server remote */
+add_pro=
xy_headers(const struct http_proxy_info *p,
+                  socket_descr=
iptor_t sd, /* already open to proxy */
+                  const char *host=
        /* openvpn server remote */
 )
 {
     char buf[512];
@@ -597,8 +59=
8,8 @@
                               socket_descriptor_t sd, /* already op=
en to proxy */
                               const char *host,       /* op=
envpn server remote */
                               const char *port,    =
   /* openvpn server port */
-                              struct event_ti=
meout *server_poll_timeout, struct buffer *lookahead,
-                    =
          struct signal_info *sig_info)
+                              cons=
t struct event_timeout *server_poll_timeout,
+                             =
 struct buffer *lookahead, struct signal_info *sig_info)
 {
     struct gc_=
arena gc =3D gc_new();
     char buf[512];
diff --git a/src/openvpn/proxy=
=2Eh b/src/openvpn/proxy=2Eh
index e662e7d=2E=2Ea2f4e47 100644
--- a/src/op=
envpn/proxy=2Eh
+++ b/src/openvpn/proxy=2Eh
@@ -89,7 +89,7 @@
             =
                       socket_descriptor_t sd, /* already open to proxy */
=
                                    const char *host,       /* openvpn serv=
er remote */
                                    const char *port,       /*=
 openvpn server port */
-                                   struct event_ti=
meout *server_poll_timeout,
+                                   const struc=
t event_timeout *server_poll_timeout,
                                    s=
truct buffer *lookahead, struct signal_info *sig_info);
 
 uint8_t *make_ba=
se64_string2(const uint8_t *str, int str_len, struct gc_arena *gc);
diff --=
git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 08c2673=2E=2E2679c4d5 1=
00644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -334,7 +334,7 @@=

  * the proxy can determine true client origin=2E
  */
 static void
-journ=
al_add(const char *journal_dir, struct proxy_connection *pc, struct proxy_c=
onnection *cp)
+journal_add(const char *journal_dir, const struct proxy_con=
nection *pc, struct proxy_connection *cp)
 {
     struct openvpn_sockaddr f=
rom, to;
 
@@ -412,7 +412,7 @@
 static bool
 proxy_entry_new(struct proxy_c=
onnection **list, struct event_set *es,
                 const struct openv=
pn_sockaddr server_addr, const socket_descriptor_t sd_client,
-            =
    struct buffer *initial_data, const char *journal_dir)
+                =
const struct buffer *initial_data, const char *journal_dir)
 {
     socket_=
descriptor_t sd_server;
     int status;
@@ -1015,7 +1015,7 @@
  * call=2E
=
  */
 void
-port_share_redirect(struct port_share *ps, const struct buffer =
*head, socket_descriptor_t sd)
+port_share_redirect(const struct port_share=
 *ps, const struct buffer *head, socket_descriptor_t sd)
 {
     if (ps)
  =
   {
diff --git a/src/openvpn/ps=2Eh b/src/openvpn/ps=2Eh
index 557ecf5=2E=
=2E918ceb6 100644
--- a/src/openvpn/ps=2Eh
+++ b/src/openvpn/ps=2Eh
@@ -49,=
7 +49,7 @@
 
 bool is_openvpn_protocol(const struct buffer *buf);
 
-void p=
ort_share_redirect(struct port_share *ps, const struct buffer *head, socket=
_descriptor_t sd);
+void port_share_redirect(const struct port_share *ps, c=
onst struct buffer *head, socket_descriptor_t sd);
 
 #endif /* if PORT_SHA=
RE */
 #endif /* ifndef PS_H */
diff --git a/src/openvpn/push=2Ec b/src/ope=
nvpn/push=2Ec
index 761a59e=2E=2Ed72596e 100644
--- a/src/openvpn/push=2Ec
=
+++ b/src/openvpn/push=2Ec
@@ -430,7 +430,7 @@
 }
 
 bool
-send_auth_pendin=
g_messages(struct tls_multi *tls_multi, struct tls_session *session,
+send_=
auth_pending_messages(const struct tls_multi *tls_multi, struct tls_session=
 *session,
                            const char *extra, unsigned int time=
out)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];
diff --git=
 a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index dff945f=2E=2E39302f6 1=
00644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -117,7 +117,=
7 @@
  * doc/management-notes=2Etxt under client-pending-auth for
  * more =
details on message format
  */
-bool send_auth_pending_messages(struct tls_=
multi *tls_multi, struct tls_session *session,
+bool send_auth_pending_mess=
ages(const struct tls_multi *tls_multi, struct tls_session *session,
      =
                           const char *extra, unsigned int timeout);
 
 voi=
d send_restart(struct context *c, const char *kill_msg);
diff --git a/src/o=
penvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index 0213041=2E=2E7fa5987=
 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ =
-222,7 +222,7 @@
 
 /* Return true if the client supports push-update */
 s=
tatic bool
-support_push_update(struct multi_instance *mi)
+support_push_up=
date(const struct multi_instance *mi)
 {
     ASSERT(mi->context=2Ec2=2Etls=
_multi);
     const unsigned int iv_proto_peer =3D extract_iv_proto(mi->con=
text=2Ec2=2Etls_multi->peer_info);
diff --git a/src/openvpn/reliable=2Ec b/=
src/openvpn/reliable=2Ec
index ced438e=2E=2Eba819a3 100644
--- a/src/openvp=
n/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -92,7 +92,7 @@
 
 /* check=
 if a particular packet_id is present in ack */
 static inline bool
-reliab=
le_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)
+rel=
iable_ack_packet_id_present(const struct reliable_ack *ack, packet_id_type =
pid)
 {
     for (int i =3D 0; i < ack->len; ++i)
     {
@@ -391,7 +391,7 @=
@
 }
 
 int
-validate_packet_id_window(struct reliable *rel, packet_id_type=
 pid)
+validate_packet_id_window(const struct reliable *rel, packet_id_type=
 pid)
 {
     return reliable_pid_min(pid, rel->packet_id)
            && r=
eliable_pid_min(subtract_pid(rel->packet_id, RELIABLE_CAPACITY), pid);
@@ -=
768,7 +768,7 @@
  */
 
 void
-reliable_mark_active_incoming(struct reliable=
 *rel, struct buffer *buf, packet_id_type pid,
+reliable_mark_active_incomi=
ng(struct reliable *rel, const struct buffer *buf, packet_id_type pid,
    =
                           int opcode)
 {
     for (int i =3D 0; i < rel->s=
ize; ++i)
@@ -828,7 +828,7 @@
 
 /* delete a buffer previously activated by=
 reliable_mark_active() */
 void
-reliable_mark_deleted(struct reliable *re=
l, struct buffer *buf)
+reliable_mark_deleted(struct reliable *rel, const s=
truct buffer *buf)
 {
     for (int i =3D 0; i < rel->size; ++i)
     {
dif=
f --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh
index a85f2e9=
=2E=2E12d5367 100644
--- a/src/openvpn/reliable=2Eh
+++ b/src/openvpn/relia=
ble=2Eh
@@ -184,7 +184,7 @@
  * @li False, if there are packet IDs to be ac=
knowledged=2E
  */
 static inline bool
-reliable_ack_empty(struct reliable_=
ack *ack)
+reliable_ack_empty(const struct reliable_ack *ack)
 {
     retur=
n !ack->len;
 }
@@ -198,7 +198,7 @@
  * included in the valid range=2E
  */=

 int
-validate_packet_id_window(struct reliable *rel, packet_id_type pid);=

+validate_packet_id_window(const struct reliable *rel, packet_id_type pid)=
;
 
 /**
  * Returns the number of packets that need to be acked=2E
@@ -208=
,7 +208,7 @@
  * @returns the number of outstanding acks
  */
 static inlin=
e int
-reliable_ack_outstanding(struct reliable_ack *ack)
+reliable_ack_out=
standing(const struct reliable_ack *ack)
 {
     return ack->len;
 }
@@ -35=
8,7 +358,7 @@
  * @param pid The packet's packet ID=2E
  * @param opcode Th=
e packet's opcode=2E
  */
-void reliable_mark_active_incoming(struct reliab=
le *rel, struct buffer *buf, packet_id_type pid,
+void reliable_mark_active=
_incoming(struct reliable *rel, const struct buffer *buf, packet_id_type pi=
d,
                                    int opcode);
 
 /**
@@ -411,7 +411,7=
 @@
  * @param rel The reliable structure associated with the given buffer=
=2E
  * @param buf The buffer of the reliable entry which is to be removed=
=2E
  */
-void reliable_mark_deleted(struct reliable *rel, struct buffer *b=
uf);
+void reliable_mark_deleted(struct reliable *rel, const struct buffer =
*buf);
 
 /** @} name Functions for extracting incoming packets */
 
diff -=
-git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 03a2526=2E=2E078=
bb7e 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -898=
,8 +898,9 @@
 }
 
 static bool
-add_bypass_routes(struct route_bypass *rb, =
in_addr_t gateway, const struct tuntap *tt,
-                  unsigned int=
 flags, const struct route_gateway_info *rgi,
+add_bypass_routes(const stru=
ct route_bypass *rb, in_addr_t gateway,
+                  const struct tun=
tap *tt, unsigned int flags,
+                  const struct route_gateway_=
info *rgi,
                   const struct env_set *es, openvpn_net_ctx_t *=
ctx)
 {
     int ret =3D true;
@@ -916,8 +917,9 @@
 }
 
 static void
-del_b=
ypass_routes(struct route_bypass *rb, in_addr_t gateway, const struct tunta=
p *tt,
-                  unsigned int flags, const struct route_gateway_in=
fo *rgi,
+del_bypass_routes(const struct route_bypass *rb, in_addr_t gatewa=
y,
+                  const struct tuntap *tt, unsigned int flags,
+       =
           const struct route_gateway_info *rgi,
                   const s=
truct env_set *es, openvpn_net_ctx_t *ctx)
 {
     int i;
@@ -3942,7 +3944,=
7 @@
 #else  /* if defined(_WIN32) */
 
 static void
-get_bypass_addresses(=
struct route_bypass *rb, const unsigned int flags) /* PLATFORM-SPECIFIC */
=
+get_bypass_addresses(struct route_bypass *rb, const unsigned int flags)
 {=

 }
 
diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec
inde=
x 6772ad6=2E=2E694f4d1 100644
--- a/src/openvpn/schedule=2Ec
+++ b/src/open=
vpn/schedule=2Ec
@@ -389,4 +389,4 @@
 {
     s->earliest_wakeup =3D NULL; /=
* invalidate cache */
     schedule_remove_node(s, e);
-}
\ No newline at e=
nd of file
+}
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
=
index 73871b2=2E=2Eb3cdc60 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/op=
envpn/socket=2Ec
@@ -619,7 +619,7 @@
 }
 
 static void
-bind_local(struct l=
ink_socket *sock)
+bind_local(const struct link_socket *sock)
 {
     /* bi=
nd to local address/port */
     if (sock->bind_local)
@@ -878,8 +878,8 @@
=
 }
 
 void
-socket_bind(socket_descriptor_t sd, struct addrinfo *local, int=
 ai_family, const char *prefix,
-            bool ipv6only)
+socket_bind(so=
cket_descriptor_t sd, const struct addrinfo *local, int ai_family,
+       =
     const char *prefix, bool ipv6only)
 {
     struct gc_arena gc =3D gc_n=
ew();
 
@@ -1087,8 +1087,8 @@
  * such as TCP=2E
  */
 
-static void stream=
_buf_init(struct stream_buf *sb, struct buffer *buf, const unsigned int soc=
kflags,
-                            const int proto);
+static void stream_=
buf_init(struct stream_buf *sb, const struct buffer *buf,
+                =
            const unsigned int sockflags, const int proto);
 
 static void =
stream_buf_close(struct stream_buf *sb);
 
@@ -1441,7 +1441,7 @@
 }
 
 stat=
ic void
-phase2_set_socket_flags(struct link_socket *sock)
+phase2_set_sock=
et_flags(const struct link_socket *sock)
 {
     /* TCP_NODELAY is enabled =
by default on every TCP socket; dco-win is
      * skipped as it manages it=
s own socket */
@@ -2037,7 +2037,7 @@
 }
 
 static void
-stream_buf_init(st=
ruct stream_buf *sb, struct buffer *buf, const unsigned int sockflags,
+str=
eam_buf_init(struct stream_buf *sb, const struct buffer *buf, const unsigne=
d int sockflags,
                 const int proto)
 {
     sb->buf_init =3D=
 *buf;
@@ -2303,7 +2303,7 @@
 #endif
 
 static ssize_t
-link_socket_read_ud=
p_posix_recvmsg(struct link_socket *sock, struct buffer *buf,
+link_socket_=
read_udp_posix_recvmsg(const struct link_socket *sock, struct buffer *buf,
=
                                    struct link_socket_actual *from, sockle=
n_t *fromlen)
 {
     struct iovec iov;
@@ -2375,7 +2375,7 @@
 #endif /* if=
 ENABLE_IP_PKTINFO */
 
 ssize_t
-link_socket_read_udp_posix(struct link_so=
cket *sock, struct buffer *buf,
+link_socket_read_udp_posix(const struct li=
nk_socket *sock, struct buffer *buf,
                            struct lin=
k_socket_actual *from)
 {
     ssize_t recvlen;
@@ -2438,7 +2438,7 @@
 #if =
ENABLE_IP_PKTINFO
 
 ssize_t
-link_socket_write_udp_posix_sendmsg(struct li=
nk_socket *sock, struct buffer *buf,
+link_socket_write_udp_posix_sendmsg(c=
onst struct link_socket *sock, const struct buffer *buf,
                  =
                   struct link_socket_actual *to)
 {
     struct iovec iov;=

@@ -2634,7 +2634,7 @@
 }
 
 int
-socket_send_queue(struct link_socket *soc=
k, struct buffer *buf, const struct link_socket_actual *to)
+socket_send_qu=
eue(struct link_socket *sock, const struct buffer *buf, const struct link_s=
ocket_actual *to)
 {
     if (sock->writes=2Eiostate =3D=3D IOSTATE_INITIAL=
)
     {
@@ -2734,8 +2734,8 @@
     return sock->writes=2Eiostate;
 }
 
-vo=
id
-read_sockaddr_from_overlapped(struct overlapped_io *io, struct sockaddr=
 *dst, int overlapped_ret)
+static void
+read_sockaddr_from_overlapped(cons=
t struct overlapped_io *io, struct sockaddr *dst, int overlapped_ret)
 {
  =
   if (overlapped_ret >=3D 0 && io->addr_defined)
     {
diff --git a/src/o=
penvpn/socket=2Eh b/src/openvpn/socket=2Eh
index c6a29f4=2E=2Eaea9f42 10064=
4
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -268,7 +268,=
7 @@
 
 int socket_recv_queue(struct link_socket *sock, int maxsize);
 
-in=
t socket_send_queue(struct link_socket *sock, struct buffer *buf,
+int sock=
et_send_queue(struct link_socket *sock, const struct buffer *buf,
         =
              const struct link_socket_actual *to);
 
 typedef struct
@@ -3=
48,8 +348,8 @@
 
 struct link_socket *link_socket_new(void);
 
-void socket=
_bind(socket_descriptor_t sd, struct addrinfo *local, int af_family, const =
char *prefix,
-                 bool ipv6only);
+void socket_bind(socket_de=
scriptor_t sd, const struct addrinfo *local, int af_family,
+              =
   const char *prefix, bool ipv6only);
 
 int openvpn_connect(socket_descri=
ptor_t sd, const struct sockaddr *remote, int connect_timeout,
            =
         volatile int *signal_received);
@@ -483,7 +483,7 @@
 }
 
 static i=
nline bool
-link_socket_verify_incoming_addr(struct buffer *buf, const stru=
ct link_socket_info *info,
+link_socket_verify_incoming_addr(const struct b=
uffer *buf, const struct link_socket_info *info,
                          =
        const struct link_socket_actual *from_addr)
 {
     if (buf->len > =
0)
@@ -607,7 +607,7 @@
 
 #else  /* ifdef _WIN32 */
 
-ssize_t link_socket_=
read_udp_posix(struct link_socket *sock, struct buffer *buf,
+ssize_t link_=
socket_read_udp_posix(const struct link_socket *sock, struct buffer *buf,
 =
                                   struct link_socket_actual *from);
 
 #en=
dif /* ifdef _WIN32 */
@@ -693,12 +693,12 @@
 
 #else /* ifdef _WIN32 */
 
=
-ssize_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock, stru=
ct buffer *buf,
+ssize_t link_socket_write_udp_posix_sendmsg(const struct l=
ink_socket *sock, const struct buffer *buf,
                               =
              struct link_socket_actual *to);
 
 
 static inline ssize_t
-l=
ink_socket_write_udp_posix(struct link_socket *sock, struct buffer *buf,
+l=
ink_socket_write_udp_posix(const struct link_socket *sock, const struct buf=
fer *buf,
                             struct link_socket_actual *to)
 {
 #=
if ENABLE_IP_PKTINFO
@@ -714,7 +714,7 @@
 }
 
 static inline ssize_t
-link_=
socket_write_tcp_posix(struct link_socket *sock, struct buffer *buf)
+link_=
socket_write_tcp_posix(const struct link_socket *sock, const struct buffer =
*buf)
 {
     return send(sock->sd, CBPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
=
 }
@@ -772,7 +772,7 @@
  * from tunnel packet=2E
  */
 static inline void
-=
link_socket_set_tos(struct link_socket *sock)
+link_socket_set_tos(const st=
ruct link_socket *sock)
 {
     if (sock && sock->ptos_defined)
     {
@@ -=
818,6 +818,8 @@
     }
 }
 
+/* cppcheck-suppress constParameterPointer
+ *=
 sock is modified on Windows via &sock->listen_handle */
 static inline voi=
d
 socket_reset_listen_persistent(struct link_socket *sock)
 {
diff --git a=
/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh
index 13f5962=2E=
=2Eadd08ba 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/socke=
t_util=2Eh
@@ -439,7 +439,7 @@
 
 
 static inline bool
-addrlist_match_prot=
o(const struct openvpn_sockaddr *a1, struct addrinfo *addr_list, const int =
proto)
+addrlist_match_proto(const struct openvpn_sockaddr *a1, const struc=
t addrinfo *addr_list, const int proto)
 {
     return link_socket_proto_co=
nnection_oriented(proto) ? addrlist_match(a1, addr_list)
                  =
                                       : addrlist_port_match(a1, addr_list)=
;
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
index 19f3d54=
=2E=2E77ca863 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn/socks=2E=
c
@@ -82,7 +82,7 @@
 
 static bool
 socks_proxy_recv_char(uint8_t *c, const=
 char *name, socket_descriptor_t sd,
-                      struct event_ti=
meout *server_poll_timeout,
+                      const struct event_timeo=
ut *server_poll_timeout,
                       volatile int *signal_receiv=
ed)
 {
     fd_set reads;
@@ -97,8 +97,8 @@
 }
 
 static bool
-socks_userna=
me_password_auth(struct socks_proxy_info *p, socket_descriptor_t sd,
-     =
                        struct event_timeout *server_poll_timeout,
+socks_u=
sername_password_auth(const struct socks_proxy_info *p, socket_descriptor_t=
 sd,
+                             const struct event_timeout *server_poll_=
timeout,
                              volatile int *signal_received)
 {
  =
   char to_send[516];
@@ -156,8 +156,8 @@
 }
 
 static bool
-socks_handshak=
e(struct socks_proxy_info *p, socket_descriptor_t sd,
-                stru=
ct event_timeout *server_poll_timeout, volatile int *signal_received)
+sock=
s_handshake(const struct socks_proxy_info *p, socket_descriptor_t sd,
+    =
            const struct event_timeout *server_poll_timeout, volatile int *=
signal_received)
 {
     uint8_t buf[2];
     int len =3D 0;
@@ -231,7 +231=
,7 @@
 
 static bool
 recv_socks_reply(socket_descriptor_t sd, struct openv=
pn_sockaddr *addr,
-                 struct event_timeout *server_poll_time=
out, volatile int *signal_received)
+                 const struct event_ti=
meout *server_poll_timeout, volatile int *signal_received)
 {
     uint8_t =
atyp =3D 0;
     int alen =3D 0;
@@ -334,11 +334,11 @@
 }
 
 void
-establis=
h_socks_proxy_passthru(struct socks_proxy_info *p,
+establish_socks_proxy_p=
assthru(const struct socks_proxy_info *p,
                                s=
ocket_descriptor_t sd, /* already open to proxy */
                        =
        const char *host,       /* openvpn server remote */
               =
                 const char *servname,   /* openvpn server port */
-       =
                        struct event_timeout *server_poll_timeout,
+       =
                        const struct event_timeout *server_poll_timeout,
  =
                              struct signal_info *sig_info)
 {
     char bu=
f[270];
@@ -392,10 +392,10 @@
 }
 
 void
-establish_socks_proxy_udpassoc(st=
ruct socks_proxy_info *p,
+establish_socks_proxy_udpassoc(const struct sock=
s_proxy_info *p,
                                socket_descriptor_t ctrl_s=
d, /* already open to proxy */
                                struct openv=
pn_sockaddr *relay_addr,
-                               struct event_timeo=
ut *server_poll_timeout,
+                               const struct event=
_timeout *server_poll_timeout,
                                struct signa=
l_info *sig_info)
 {
     if (!socks_handshake(p, ctrl_sd, server_poll_time=
out, &sig_info->signal_received))
diff --git a/src/openvpn/socks=2Eh b/src/=
openvpn/socks=2Eh
index 846113d=2E=2Ef7c93b6 100644
--- a/src/openvpn/socks=
=2Eh
+++ b/src/openvpn/socks=2Eh
@@ -47,17 +47,17 @@
 
 void socks_proxy_cl=
ose(struct socks_proxy_info *sp);
 
-void establish_socks_proxy_passthru(st=
ruct socks_proxy_info *p,
+void establish_socks_proxy_passthru(const struct=
 socks_proxy_info *p,
                                     socket_descripto=
r_t sd, /* already open to proxy */
                                     co=
nst char *host,       /* openvpn server remote */
                         =
            const char *servname,   /* openvpn server port */
-            =
                        struct event_timeout *server_poll_timeout,
+       =
                             const struct event_timeout *server_poll_timeou=
t,
                                     struct signal_info *sig_info);
 
-v=
oid establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
+void establ=
ish_socks_proxy_udpassoc(const struct socks_proxy_info *p,
                =
                     socket_descriptor_t ctrl_sd, /* already open to proxy =
*/
                                     struct openvpn_sockaddr *relay_addr=
,
-                                    struct event_timeout *server_poll_ti=
meout,
+                                    const struct event_timeout *ser=
ver_poll_timeout,
                                     struct signal_info *=
sig_info);
 
 void socks_process_incoming_udp(struct buffer *buf, struct li=
nk_socket_actual *from);
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=
=2Ec
index 71459ee=2E=2E5cc2b1b 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/=
openvpn/ssl=2Ec
@@ -1171,7 +1171,7 @@
 }
 
 struct tls_multi *
-tls_multi_i=
nit(struct tls_options *tls_options)
+tls_multi_init(const struct tls_optio=
ns *tls_options)
 {
     struct tls_multi *ret;
 
@@ -1212,7 +1212,7 @@
  *=
/
 
 struct tls_auth_standalone *
-tls_auth_standalone_init(struct tls_opti=
ons *tls_options, struct gc_arena *gc)
+tls_auth_standalone_init(const stru=
ct tls_options *tls_options, struct gc_arena *gc)
 {
     struct tls_auth_s=
tandalone *tas;
 
@@ -1360,7 +1360,7 @@
 
 static void
 init_epoch_keys(str=
uct key_state *ks, struct tls_multi *multi, const struct key_type *key_type=
,
-                bool server, struct key2 *key2)
+                bool se=
rver, const struct key2 *key2)
 {
     /* For now we hardcode this to be 4 =
for the software based data channel
      * DCO based implementations/HW im=
plementation might adjust this number
@@ -1403,7 +1403,7 @@
 
 static void
=
 init_key_contexts(struct key_state *ks, struct tls_multi *multi, const str=
uct key_type *key_type,
-                  bool server, struct key2 *key2, =
bool dco_enabled)
+                  bool server, const struct key2 *key2, =
bool dco_enabled)
 {
     struct key_ctx_bi *key =3D &ks->crypto_options=2E=
key_ctx_bi;
 
@@ -1601,8 +1601,9 @@
 
 bool
 tls_session_update_crypto_para=
ms_do_work(struct tls_multi *multi, struct tls_session *session,
-         =
                                struct options *options, struct frame *fram=
e,
-                                         struct frame *frame_fragment, =
struct link_socket_info *lsi,
+                                         con=
st struct options *options, struct frame *frame,
+                         =
                struct frame *frame_fragment,
+                            =
             const struct link_socket_info *lsi,
                          =
                dco_context_t *dco)
 {
     if (session->key[KS_PRIMARY]=2E=
crypto_options=2Ekey_ctx_bi=2Einitialized)
@@ -1671,7 +1672,7 @@
 bool
 tls=
_session_update_crypto_params(struct tls_multi *multi, struct tls_session *=
session,
                                  struct options *options, struct =
frame *frame,
-                                 struct frame *frame_fragmen=
t, struct link_socket_info *lsi,
+                                 struct f=
rame *frame_fragment, const struct link_socket_info *lsi,
                 =
                 dco_context_t *dco)
 {
     if (!check_session_cipher(sess=
ion, options))
@@ -1887,7 +1888,8 @@
 }
 
 static bool
-push_peer_info_peer=
id(struct buffer *out, struct tls_multi *multi, struct tls_session *session=
)
+push_peer_info_peerid(struct buffer *out, const struct tls_multi *multi,=

+                      const struct tls_session *session)
 {
     if (mult=
i->rx_peer_id =3D=3D MAX_PEER_ID || session->opt->dco_enabled)
     {
@@ -1=
922,7 +1924,7 @@
  * @return          true if no error was encountered
  */=

 static bool
-push_peer_info(struct buffer *buf, struct tls_multi *multi, =
struct tls_session *session)
+push_peer_info(struct buffer *buf, const stru=
ct tls_multi *multi, struct tls_session *session)
 {
     struct gc_arena g=
c =3D gc_new();
     bool ret =3D false;
@@ -2566,8 +2568,8 @@
 }
 
 bool
-=
session_skip_to_pre_start(struct tls_session *session, struct tls_pre_decry=
pt_state *state,
-                          struct link_socket_actual *from=
)
+session_skip_to_pre_start(struct tls_session *session, const struct tls_=
pre_decrypt_state *state,
+                          const struct link_sock=
et_actual *from)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY]=
;
     ks->session_id_remote =3D state->peer_session_id;
@@ -2785,7 +2787,7=
 @@
 
 static bool
 check_outgoing_ciphertext(struct key_state *ks, struct =
tls_session *session,
-                          struct buffer *to_link, bo=
ol *continue_tls_process)
+                          const struct buffer *t=
o_link, bool *continue_tls_process)
 {
     if (to_link->len)
     {
@@ -32=
26,7 +3228,7 @@
         return;
     }
 
-    uint8_t *dataptr =3D to_link=
->data;
+    const uint8_t *dataptr =3D to_link->data;
 
     /* we don't e=
xpect send_reliable to be NULL when state is
      * not S_UNDEF, but peopl=
e have reported crashes nonetheless,
@@ -4126,7 +4128,7 @@
 }
 
 void
-tls_=
post_encrypt(struct tls_multi *multi, struct buffer *buf)
+tls_post_encrypt=
(struct tls_multi *multi, const struct buffer *buf)
 {
     struct key_stat=
e *ks =3D multi->save_ks;
     multi->save_ks =3D NULL;
@@ -4257,7 +4259,7 =
@@
  * into a garbage collectable string which is returned=2E
  */
 const c=
har *
-protocol_dump(struct buffer *buffer, unsigned int flags, struct gc_a=
rena *gc)
+protocol_dump(const struct buffer *buffer, unsigned int flags, s=
truct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
  =
   struct buffer buf =3D *buffer;
diff --git a/src/openvpn/ssl=2Eh b/src/op=
envpn/ssl=2Eh
index 7ddf965=2E=2E93e6200 100644
--- a/src/openvpn/ssl=2Eh
+=
++ b/src/openvpn/ssl=2Eh
@@ -166,7 +166,7 @@
  *
  * @return A newly alloca=
ted and initialized \c tls_multi structure=2E
  */
-struct tls_multi *tls_m=
ulti_init(struct tls_options *tls_options);
+struct tls_multi *tls_multi_in=
it(const struct tls_options *tls_options);
 
 /**
  * Finalize initializati=
on of a \c tls_multi structure=2E
@@ -187,7 +187,7 @@
 /*
  * Initialize a =
standalone tls-auth verification object=2E
  */
-struct tls_auth_standalone=
 *tls_auth_standalone_init(struct tls_options *tls_options,
+struct tls_aut=
h_standalone *tls_auth_standalone_init(const struct tls_options *tls_option=
s,
                                                      struct gc_arena *g=
c);
 
 /**
@@ -371,7 +371,7 @@
  * @param multi - The TLS state for this pa=
cket's destination VPN tunnel=2E
  * @param buf - The buffer containing the=
 outgoing packet=2E
  */
-void tls_post_encrypt(struct tls_multi *multi, st=
ruct buffer *buf);
+void tls_post_encrypt(struct tls_multi *multi, const st=
ruct buffer *buf);
 
 /** @} name Functions for managing security parameter=
 state for data channel packets */
 
@@ -461,7 +461,8 @@
  */
 bool tls_ses=
sion_update_crypto_params(struct tls_multi *multi, struct tls_session *sess=
ion,
                                       struct options *options, struct=
 frame *frame,
-                                      struct frame *frame_f=
ragment, struct link_socket_info *lsi,
+                                   =
   struct frame *frame_fragment,
+                                      con=
st struct link_socket_info *lsi,
                                       dco=
_context_t *dco);
 
 /*
@@ -525,7 +526,7 @@
 #define PD_VERBOSE            =
     (1 << 10)
 #define PD_TLS_CRYPT               (1 << 11)
 
-const char =
*protocol_dump(struct buffer *buffer, unsigned int flags, struct gc_arena *=
gc);
+const char *protocol_dump(const struct buffer *buffer, unsigned int f=
lags, struct gc_arena *gc);
 
 /*
  * debugging code
@@ -573,7 +574,7 @@
 /=
* Special method to skip the three way handshake RESET stages=2E This is
  =
* used by the HMAC code when seeing a packet that matches the previous
  * =
HMAC based stateless server state */
-bool session_skip_to_pre_start(struct=
 tls_session *session, struct tls_pre_decrypt_state *state,
-              =
                 struct link_socket_actual *from);
+bool session_skip_to_pr=
e_start(struct tls_session *session, const struct tls_pre_decrypt_state *st=
ate,
+                               const struct link_socket_actual *from)=
;
 
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src/openvpn/ssl_backend=
=2Eh b/src/openvpn/ssl_backend=2Eh
index a6d57f2=2E=2E29e07a6 100644
--- a/=
src/openvpn/ssl_backend=2Eh
+++ b/src/openvpn/ssl_backend=2Eh
@@ -137,7 +13=
7,7 @@
  *
  * @return      true if the context is initialised, false if no=
t=2E
  */
-bool tls_ctx_initialised(struct tls_root_ctx *ctx);
+bool tls_ct=
x_initialised(const struct tls_root_ctx *ctx);
 
 /**
  * Set any library s=
pecific options=2E
@@ -170,7 +170,7 @@
  * @param ciphers       String cont=
aining : delimited cipher names, or NULL to use
  *                        =
              sane defaults=2E
  */
-void tls_ctx_restrict_ciphers_tls13(st=
ruct tls_root_ctx *ctx, const char *ciphers);
+void tls_ctx_restrict_cipher=
s_tls13(const struct tls_root_ctx *ctx, const char *ciphers);
 
 /**
  * Se=
t the TLS certificate profile=2E  The profile defines which crypto
diff --g=
it a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index c92c42=
3=2E=2Ecddf856 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/s=
sl_mbedtls=2Ec
@@ -146,7 +146,7 @@
 }
 
 bool
-tls_ctx_initialised(struct t=
ls_root_ctx *ctx)
+tls_ctx_initialised(const struct tls_root_ctx *ctx)
 {
 =
    /* either this should be NULL or should be non-null and then have a
   =
   * valid TLS ctx inside as well */
@@ -269,7 +269,7 @@
 }
 
 void
-tls_ct=
x_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)
+tl=
s_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const char *ci=
phers)
 {
     if (ciphers =3D=3D NULL)
     {
diff --git a/src/openvpn/ssl=
_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 7cfe9f4=2E=2Ecb3de65 10064=
4
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -1=
29,7 +129,7 @@
 }
 
 bool
-tls_ctx_initialised(struct tls_root_ctx *ctx)
+t=
ls_ctx_initialised(const struct tls_root_ctx *ctx)
 {
     /* either this s=
hould be NULL or should be non-null and then have a
      * valid TLS ctx i=
nside as well */
@@ -446,7 +446,7 @@
 #endif
 
 void
-tls_ctx_restrict_ciph=
ers_tls13(struct tls_root_ctx *ctx, const char *ciphers)
+tls_ctx_restrict_=
ciphers_tls13(const struct tls_root_ctx *ctx, const char *ciphers)
 {
     =
if (ciphers =3D=3D NULL)
     {
@@ -1093,7 +1093,7 @@
 }
 
 static void
-tl=
s_ctx_load_cert_uri(struct tls_root_ctx *tls_ctx, const char *uri)
+tls_ctx=
_load_cert_uri(const struct tls_root_ctx *tls_ctx, const char *uri)
 {
 #if=
 defined(HAVE_OPENSSL_STORE_API)
     X509 *x =3D NULL;
@@ -2008,7 +2008,7 =
@@
 }
 
 static void
-bio_debug_data(const char *mode, BIO *bio, const uint=
8_t *buf, int len, const char *desc)
+bio_debug_data(const char *mode, cons=
t BIO *bio, const uint8_t *buf, int len, const char *desc)
 {
     struct g=
c_arena gc =3D gc_new();
     if (len > 0)
@@ -2022,7 +2022,7 @@
 }
 
 stat=
ic void
-bio_debug_oc(const char *mode, BIO *bio)
+bio_debug_oc(const char =
*mode, const BIO *bio)
 {
     open_biofp();
     fprintf(biofp, "BIO %s ti=
me=3D%" PRIi64 " bio=3D" ptr_format "\n", mode, (int64_t)time(NULL),
diff -=
-git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 90b2aec=2E=
=2E60b005f 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=
=2Ec
@@ -118,7 +118,7 @@
  */
 static void
 tls_wrap_control(struct tls_wra=
p_ctx *ctx, uint8_t header, struct buffer *buf,
-                 struct se=
ssion_id *session_id)
+                 const struct session_id *session_id=
)
 {
     if (ctx->mode =3D=3D TLS_WRAP_AUTH || ctx->mode =3D=3D TLS_WRAP_N=
ONE)
     {
@@ -402,9 +402,9 @@
 
 
 struct buffer
-tls_reset_standalone(st=
ruct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                 =
    struct session_id *own_sid, struct session_id *remote_sid, uint8_t head=
er,
-                     bool request_resend_wkc)
+tls_reset_standalone(st=
ruct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,
+           =
          const struct session_id *own_sid, const struct session_id *remote=
_sid,
+                     uint8_t header, bool request_resend_wkc)
 {
   =
  /* Copy buffer here to point at the same data but allow tls_wrap_control
=
      * to potentially change buf to point to another buffer without
@@ -48=
9,7 +489,7 @@
 bool
 check_session_hmac_and_pkt_id(struct tls_pre_decrypt_s=
tate *state,
                               const struct openvpn_sockaddr *=
from,
-                              uint8_t *key,
+                       =
       const uint8_t *key,
                               int handwindow,
 =
                              bool pkt_is_ack)
 {
diff --git a/src/openvpn/=
ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 03e8930=2E=2E8203e4a 100644
---=
 a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -183,7 +183,7 @=
@
  * @return              the expected server session id
  */
 bool check_=
session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const struct o=
penvpn_sockaddr *from,
-                                   uint8_t *key, in=
t handwindow, bool pkt_is_ack);
+                                   const u=
int8_t *key, int handwindow, bool pkt_is_ack);
 
 /*
  * Write a control ch=
annel authentication record=2E
@@ -210,8 +210,9 @@
  * from the tls pre dec=
rypt state=2E
  *
  */
-struct buffer tls_reset_standalone(struct tls_wrap_=
ctx *ctx, struct tls_auth_standalone *tas,
-                               =
    struct session_id *own_sid, struct session_id *remote_sid,
+struct buff=
er tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_sta=
ndalone *tas,
+                                   const struct session_id *=
own_sid,
+                                   const struct session_id *remot=
e_sid,
                                    uint8_t header, bool request_res=
end_wkc);
 
 
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_ver=
ify=2Ec
index 3653eb4=2E=2E0e40370 100644
--- a/src/openvpn/ssl_verify=2Ec
=
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1139,7 +1139,7 @@
  * cache=2E
  */
 s=
tatic bool
-tls_authentication_status_use_cache(struct tls_multi *multi)
+t=
ls_authentication_status_use_cache(const struct tls_multi *multi)
 {
     u=
nsigned int idx =3D min_uint(multi->tas_cache_num_updates, SIZE(cache_inter=
vals) - 1);
     time_t latency =3D cache_intervals[idx];
@@ -1283,7 +1283,=
7 @@
  * Check if the script/plugin left a message in the auth failed messa=
ge
  * file and relay it to the user */
 static void
-check_for_client_reas=
on(struct tls_multi *multi, struct auth_deferred_status *status)
+check_for=
_client_reason(struct tls_multi *multi, const struct auth_deferred_status *=
status)
 {
     struct gc_arena gc =3D gc_new();
     const char *msg =3D k=
ey_state_check_auth_failed_message_file(status, &gc);
@@ -1552,7 +1552,7 @@=

 #endif /* ifdef ENABLE_MANAGEMENT */
 
 static bool
-set_verify_user_pass=
_env(struct user_pass *up, struct tls_multi *multi, struct tls_session *ses=
sion)
+set_verify_user_pass_env(const struct user_pass *up, struct tls_mult=
i *multi, struct tls_session *session)
 {
     /* Is username defined? */
 =
    if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(=
up->username))
@@ -1580,7 +1580,7 @@
 }
 
 bool
-ssl_verify_username_length=
(struct tls_session *session, const char *username)
+ssl_verify_username_le=
ngth(const struct tls_session *session, const char *username)
 {
     if ((=
session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
         && strlen(=
username) > TLS_USERNAME_LEN)
diff --git a/src/openvpn/ssl_verify=2Eh b/src=
/openvpn/ssl_verify=2Eh
index 3176d76=2E=2Ee77bc4a 100644
--- a/src/openvpn=
/ssl_verify=2Eh
+++ b/src/openvpn/ssl_verify=2Eh
@@ -202,7 +202,7 @@
  * @r=
eturn              true if name is under limit or username-as-common-name
 =
 *                      is not active
  */
-bool ssl_verify_username_length=
(struct tls_session *session, const char *username);
+bool ssl_verify_usern=
ame_length(const struct tls_session *session, const char *username);
 
 /**=

  * Runs the --client-crresponse script if one is defined=2E
@@ -275,7 +27=
5,7 @@
 void auth_set_client_reason(struct tls_multi *multi, const char *cl=
ient_reason);
 
 static inline const char *
-tls_client_reason(struct tls_m=
ulti *multi)
+tls_client_reason(const struct tls_multi *multi)
 {
     retu=
rn multi->client_reason;
 }
diff --git a/src/openvpn/status=2Ec b/src/openv=
pn/status=2Ec
index c7d375b=2E=2Ecfbc38d 100644
--- a/src/openvpn/status=2E=
c
+++ b/src/openvpn/status=2Ec
@@ -135,7 +135,7 @@
 }
 
 void
-status_reset=
(struct status_output *so)
+status_reset(const struct status_output *so)
 {=

     if (so && so->fd >=3D 0)
     {
diff --git a/src/openvpn/status=2Eh b=
/src/openvpn/status=2Eh
index 7953a4e=2E=2E4c01d75 100644
--- a/src/openvpn=
/status=2Eh
+++ b/src/openvpn/status=2Eh
@@ -69,7 +69,7 @@
 
 bool status_t=
rigger(struct status_output *so);
 
-void status_reset(struct status_output=
 *so);
+void status_reset(const struct status_output *so);
 
 void status_f=
lush(struct status_output *so);
 
diff --git a/src/openvpn/tun=2Ec b/src/op=
envpn/tun=2Ec
index af48921=2E=2Eabb46af 100644
--- a/src/openvpn/tun=2Ec
+=
++ b/src/openvpn/tun=2Ec
@@ -835,7 +835,7 @@
          const char *ifconfig=
_ipv6_local_parm,     /* --ifconfig parm 1 IPv6 */
          int ifconfig_i=
pv6_netbits_parm,
          const char *ifconfig_ipv6_remote_parm,    /* --=
ifconfig parm 2 IPv6 */
-         struct addrinfo *local_public, struct add=
rinfo *remote_public, const bool strict_warn,
+         const struct addrin=
fo *local_public, const struct addrinfo *remote_public, const bool strict_w=
arn,
          struct env_set *es, openvpn_net_ctx_t *ctx, struct tuntap *t=
t)
 {
     if (!tt)
@@ -978,7 +978,7 @@
  * -> helper function to simplify =
code below
  */
 static void
-add_route_connected_v6_net(struct tuntap *tt,=
 const struct env_set *es)
+add_route_connected_v6_net(const struct tuntap =
*tt, const struct env_set *es)
 {
     struct route_ipv6 r6;
 
@@ -1020,7 +=
1020,7 @@
  */
 
 in_addr_t
-create_arbitrary_remote(struct tuntap *tt)
+cr=
eate_arbitrary_remote(const struct tuntap *tt)
 {
     in_addr_t remote;
 
=
@@ -1592,7 +1592,7 @@
 }
 
 static void
-undo_ifconfig_ipv4(struct tuntap *=
tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4(const struct tuntap *tt, op=
envpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     int netbits =3D ne=
tmask_to_netbits2(tt->remote_netmask);
@@ -1627,7 +1627,7 @@
 }
 
 static v=
oid
-undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_if=
config_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if define=
d(TARGET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_name, &tt->local_i=
pv6, tt->netbits_ipv6) < 0)
@@ -1652,7 +1652,7 @@
 }
 
 void
-undo_ifconfig=
(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig(const struct tun=
tap *tt, openvpn_net_ctx_t *ctx)
 {
     if (tt->backend_driver !=3D DRIVER=
_NULL && tt->backend_driver !=3D DRIVER_AFUNIX)
     {
@@ -1720,7 +1720,7 @=
@
 }
 
 static ssize_t
-write_tun_header(struct tuntap *tt, uint8_t *buf, i=
nt len)
+write_tun_header(const struct tuntap *tt, const uint8_t *buf, int =
len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1737,9 +1737,11 @=
@
             type =3D htonl(AF_INET);
         }
 
+        /* argument t=
o writev is a pointer to const but we still need to drop
+         * the co=
nst from buf pointer here */
         iv[0]=2Eiov_base =3D &type;
         =
iv[0]=2Eiov_len =3D sizeof(type);
-        iv[1]=2Eiov_base =3D buf;
+     =
   iv[1]=2Eiov_base =3D (void *)buf;
         iv[1]=2Eiov_len =3D len;
 
  =
       return header_modify_read_write_return(writev(tt->fd, iv, 2));
@@ -1=
751,7 +1753,7 @@
 }
 
 static ssize_t
-read_tun_header(struct tuntap *tt, u=
int8_t *buf, int len)
+read_tun_header(const struct tuntap *tt, uint8_t *bu=
f, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1777,13 +1=
779,13 @@
  */
 #if !defined(TARGET_DARWIN)
 ssize_t
-write_tun(struct tunt=
ap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const ui=
nt8_t *buf, int len)
 {
     return write_tun_header(tt, buf, len);
 }
 
 s=
size_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const =
struct tuntap *tt, uint8_t *buf, int len)
 {
     return read_tun_header(tt=
, buf, len);
 }
@@ -1799,7 +1801,7 @@
 
 #if defined(TARGET_LINUX) || defin=
ed(TARGET_FREEBSD)
 static bool
-tun_dco_enabled(struct tuntap *tt)
+tun_dc=
o_enabled(const struct tuntap *tt)
 {
     return tt->backend_driver =3D=3D=
 DRIVER_DCO;
 }
@@ -2046,13 +2048,13 @@
 }
 
 ssize_t
-write_tun(struct tun=
tap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const u=
int8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t=

-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct=
 tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
=
 }
@@ -2251,13 +2253,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint=
8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, =
int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(st=
ruct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, =
uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -2587,7=
 +2589,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int l=
en)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
   =
  struct strbuf sbuf;
     sbuf=2Elen =3D len;
@@ -2596,7 +2598,7 @@
 }
 
 =
ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const=
 struct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
    =
 int f =3D 0;
@@ -3094,7 +3096,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap =
*tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8=
_t *buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {=

@@ -3107,7 +3109,7 @@
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *=
buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
=
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
@@ -3311,7 +3313,7 @=
@
 }
 
 int
-tun_write_queue(struct tuntap *tt, struct buffer *buf)
+tun_wr=
ite_queue(struct tuntap *tt, const struct buffer *buf)
 {
     if (tt->writ=
es=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
@@ -3366,7 +3368,7 @@
 }
 
 int=

-tun_write_win32(struct tuntap *tt, struct buffer *buf)
+tun_write_win32(s=
truct tuntap *tt, const struct buffer *buf)
 {
     int err =3D 0;
     int=
 status =3D 0;
@@ -5374,7 +5376,7 @@
 }
 
 void
-fork_register_dns_action(s=
truct tuntap *tt)
+fork_register_dns_action(const struct tuntap *tt)
 {
   =
  if (tt && tt->options=2Eregister_dns && tt->options=2Emsg_channel)
     {=

@@ -5464,7 +5466,7 @@
 }
 
 static void
-tuntap_get_mtu(struct tuntap *tt)=

+tuntap_get_mtu(const struct tuntap *tt)
 {
     ULONG mtu =3D 0;
     DWO=
RD len;
@@ -6039,7 +6041,7 @@
 }
 
 void
-tun_show_debug(struct tuntap *tt)=

+tun_show_debug(const struct tuntap *tt)
 {
     if (tt->backend_driver =
=3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)
     {
diff --git a/src/openvpn/tun=2Eh=
 b/src/openvpn/tun=2Eh
index 2477560=2E=2E0ff2a0b 100644
--- a/src/openvpn/=
tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -272,9 +272,9 @@
 
 void close_tun_han=
dle(struct tuntap *tt);
 
-ssize_t write_tun(struct tuntap *tt, uint8_t *bu=
f, int len);
+ssize_t write_tun(const struct tuntap *tt, const uint8_t *buf=
, int len);
 
-ssize_t read_tun(struct tuntap *tt, uint8_t *buf, int len);
=
+ssize_t read_tun(const struct tuntap *tt, uint8_t *buf, int len);
 
 #ifde=
f ENABLE_FEATURE_TUN_PERSIST
 void tuncfg(const char *dev, const char *dev_=
type, const char *dev_node, int persist_mode,
@@ -293,7 +293,7 @@
         =
                const char *ifconfig_ipv6_local_parm,     /* --ifconfig par=
m 1 / IPv6 */
                         int ifconfig_ipv6_netbits_parm,     =
      /* --ifconfig parm 1 / bits */
                         const char *i=
fconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 */
-              =
          struct addrinfo *local_public, struct addrinfo *remote_public,
+ =
                       const struct addrinfo *local_public, const struct ad=
drinfo *remote_public,
                         const bool strict_warn, str=
uct env_set *es, openvpn_net_ctx_t *ctx,
                         struct tu=
ntap *tt);
 
@@ -320,7 +320,7 @@
  * @param tt    the tuntap interface cont=
ext
  * @param ctx   the networking API opaque context
  */
-void undo_ifco=
nfig(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+void undo_ifconfig(const =
struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
 bool is_dev_type(const char =
*dev, const char *dev_type, const char *match_type);
 
@@ -351,7 +351,7 @@
=
 #define IFCONFIG_DEFAULT IFCONFIG_AFTER_TUN_OPEN
 
 static inline int
-ifc=
onfig_order(struct tuntap *tt)
+ifconfig_order(const struct tuntap *tt)
 {
=
     if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -381,7 +381,7 @=
@
 #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN
 
 static inline int
-route_=
order(struct tuntap *tt)
+route_order(const struct tuntap *tt)
 {
     if (=
tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -454,13 +454,13 @@
 
 co=
nst char *tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc);
 
=
-void tun_show_debug(struct tuntap *tt);
+void tun_show_debug(const struct =
tuntap *tt);
 
 bool dhcp_release_by_adapter_index(const DWORD adapter_inde=
x);
 
 bool dhcp_renew_by_adapter_index(const DWORD adapter_index);
 
-void=
 fork_register_dns_action(struct tuntap *tt);
+void fork_register_dns_actio=
n(const struct tuntap *tt);
 
 void ipconfig_register_dns(const struct env_=
set *es);
 
@@ -470,7 +470,7 @@
 
 int tun_read_queue(struct tuntap *tt, in=
t maxsize);
 
-int tun_write_queue(struct tuntap *tt, struct buffer *buf);
=
+int tun_write_queue(struct tuntap *tt, const struct buffer *buf);
 
 stati=
c inline bool
 tuntap_stop(int status)
@@ -499,7 +499,7 @@
     return fals=
e;
 }
 
-int tun_write_win32(struct tuntap *tt, struct buffer *buf);
+int t=
un_write_win32(struct tuntap *tt, const struct buffer *buf);
 
 static inli=
ne bool
 is_ip_packet_valid(const struct buffer *buf)
@@ -529,13 +529,13 @@=

 }
 
 static inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_=
dco_win(const struct tuntap *tt)
 {
     return tt && tt->backend_driver =
=3D=3D DRIVER_DCO;
 }
 
 static inline bool
-tuntap_is_dco_win_timeout(stru=
ct tuntap *tt, ssize_t status)
+tuntap_is_dco_win_timeout(const struct tunt=
ap *tt, ssize_t status)
 {
     return tuntap_is_dco_win(tt) && (status < 0=
) && (openvpn_errno() =3D=3D ERROR_NETNAME_DELETED);
 }
@@ -555,25 +555,25 =
@@
 }
 
 static inline void
-tun_standby_init(struct tuntap *tt)
+tun_stand=
by_init(const struct tuntap *tt)
 {
 }
 
 static inline bool
-tun_standby(s=
truct tuntap *tt)
+tun_standby(const struct tuntap *tt)
 {
     return true=
;
 }
 
 
 static inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_=
is_dco_win(const struct tuntap *tt)
 {
     return false;
 }
 
 static inli=
ne bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)
+tunt=
ap_is_dco_win_timeout(const struct tuntap *tt, ssize_t status)
 {
     retu=
rn false;
 }
diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afun=
ix=2Ec
index a67a472=2E=2Ee9223bc 100644
--- a/src/openvpn/tun_afunix=2Ec
+=
++ b/src/openvpn/tun_afunix=2Ec
@@ -48,7 +48,7 @@
 
 
 static void
-tun_afu=
nix_exec_child(const char *dev_node, struct tuntap *tt, struct env_set *env=
)
+tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, const str=
uct env_set *env)
 {
     const char *msgprefix =3D "ERROR: failure executi=
ng process for tun:";
     struct argv argv =3D argv_new();
@@ -73,7 +73,7 =
@@
 }
 
 void
-open_tun_afunix(struct options *o, int mtu, struct tuntap *t=
t, struct env_set *orig_env)
+open_tun_afunix(const struct options *o, int =
mtu, struct tuntap *tt, const struct env_set *orig_env)
 {
     struct gc_a=
rena gc =3D gc_new();
 
diff --git a/src/openvpn/tun_afunix=2Eh b/src/openv=
pn/tun_afunix=2Eh
index 5b6a8e0=2E=2Efb88eb2 100644
--- a/src/openvpn/tun_a=
funix=2Eh
+++ b/src/openvpn/tun_afunix=2Eh
@@ -31,7 +31,7 @@
  * the user p=
rovided taking care of implementing the actual tun
  * device=2E
  */
-void=
 open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_=
set *env);
+void open_tun_afunix(const struct options *o, int mtu, struct t=
untap *tt, const struct env_set *env);
 
 
 /**
diff --git a/src/openvpn/vl=
an=2Ec b/src/openvpn/vlan=2Ec
index 69ac10d=2E=2E04e18d6 100644
--- a/src/o=
penvpn/vlan=2Ec
+++ b/src/openvpn/vlan=2Ec
@@ -288,7 +288,7 @@
 }
 
 void
-=
vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *m=
i)
+vlan_process_outgoing_tun(const struct multi_context *m, struct multi_i=
nstance *mi)
 {
     if (!m->top=2Eoptions=2Evlan_tagging)
     {
diff --gi=
t a/src/openvpn/vlan=2Eh b/src/openvpn/vlan=2Eh
index 9389f89=2E=2Ecd2f66f =
100644
--- a/src/openvpn/vlan=2Eh
+++ b/src/openvpn/vlan=2Eh
@@ -35,6 +35,6=
 @@
 
 bool vlan_is_tagged(const struct buffer *buf);
 
-void vlan_process_=
outgoing_tun(struct multi_context *m, struct multi_instance *mi);
+void vla=
n_process_outgoing_tun(const struct multi_context *m, struct multi_instance=
 *mi);
 
 #endif /* VLAN_H */
diff --git a/src/openvpn/win32=2Eh b/src/open=
vpn/win32=2Eh
index 8be3d96=2E=2E39ff7d8 100644
--- a/src/openvpn/win32=2Eh=

+++ b/src/openvpn/win32=2Eh
@@ -227,7 +227,7 @@
 void overlapped_io_close(=
struct overlapped_io *o);
 
 static inline bool
-overlapped_io_active(struc=
t overlapped_io *o)
+overlapped_io_active(const struct overlapped_io *o)
 {=

     return o->iostate =3D=3D IOSTATE_QUEUED || o->iostate =3D=3D IOSTATE_=
IMMEDIATE_RETURN;
 }
diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/o=
penvpnmsica/openvpnmsica=2Ec
index a861e8a=2E=2E25fa1e4 100644
--- a/src/op=
envpnmsica/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvpnmsica=2Ec
@@ -77,=
7 +77,7 @@
  * @return ERROR_SUCCESS on success; An error code otherwise
  =
*/
 static UINT
-setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szP=
roperty, _In_ struct msica_arg_seq *seq)
+setup_sequence(_In_ MSIHANDLE hIn=
stall, _In_z_ LPCWSTR szProperty, _In_ const struct msica_arg_seq *seq)
 {
=
     UINT uiResult;
     LPWSTR szSequence =3D msica_arg_seq_join(seq);
dif=
f --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec=

index d2288b9=2E=2Eee5d22a 100644
--- a/src/openvpnserv/interactive=2Ec
++=
+ b/src/openvpnserv/interactive=2Ec
@@ -522,7 +522,7 @@
 
 
 static SOCKADD=
R_INET
-sockaddr_inet(short family, inet_address_t *addr)
+sockaddr_inet(sh=
ort family, const inet_address_t *addr)
 {
     SOCKADDR_INET sa_inet;
    =
 ZeroMemory(&sa_inet, sizeof(sa_inet));
@@ -3849,7 +3849,7 @@
 
 static DWO=
RD
 UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_event=
, HANDLE exit_event,
-                  list_item_t *threads)
+            =
      const list_item_t *threads)
 {
     static DWORD size =3D 10;
     st=
atic LPHANDLE handles =3D NULL;
diff --git a/tests/unit_tests/openvpn/mock_=
management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
index 77f6ce2=
=2E=2Efff4c2b 100644
--- a/tests/unit_tests/openvpn/mock_management=2Ec
+++=
 b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -36,7 +36,7 @@
 struct m=
anagement *management; /* GLOBAL */
 
 void
-management_auth_failure(struct=
 management *man, const char *type, const char *reason)
+management_auth_fa=
ilure(const struct management *man, const char *type, const char *reason)
 =
{
     ASSERT(false);
 }
diff --git a/tests/unit_tests/openvpn/test_misc=2E=
c b/tests/unit_tests/openvpn/test_misc=2Ec
index a41c27b=2E=2Ea8daee6 10064=
4
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openv=
pn/test_misc=2Ec
@@ -146,7 +146,7 @@
 }
 
 static struct hash_element *
-ha=
sh_lookup_by_value(struct hash *hash, void *value)
+hash_lookup_by_value(st=
ruct hash *hash, const void *value)
 {
     struct hash_iterator hi;
     s=
truct hash_element *he;
diff --git a/tests/unit_tests/openvpn/test_user_pas=
s=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec
index c0a0866=2E=2E7636=
a33 100644
--- a/tests/unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/un=
it_tests/openvpn/test_user_pass=2Ec
@@ -59,7 +59,7 @@
     return mock();
 =
}
 void
-management_auth_failure(struct management *man, const char *type, =
const char *reason)
+management_auth_failure(const struct management *man, =
const char *type, const char *reason)
 {
     assert_true(0);
 }

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I56248cf6d199c2da770774b8=
fd1e5daf2b116f58
Gerrit-Change-Number: 1663
Gerrit-PatchSet: 20
Gerrit-Owne=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <fra=
nk@lichtenheld=2Ecom>

--oWJ5NTUdQIw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #20</strong> to this change=2E</p><p><a href=3D"http:=
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
br>M src/openvpn/buffer=2Eh<br>M src/openvpn/clinat=2Ec<br>M src/openvpn/co=
mp=2Ec<br>M src/openvpn/comp=2Eh<br>M src/openvpn/crypto=2Ec<br>M src/openv=
pn/crypto=2Eh<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/op=
envpn/dco_freebsd=2Ec<br>M src/openvpn/dco_internal=2Eh<br>M src/openvpn/dc=
o_linux=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/event=2Eh<br>M sr=
c/openvpn/forward=2Ec<br>M src/openvpn/forward=2Eh<br>M src/openvpn/init=2E=
c<br>M src/openvpn/init=2Eh<br>M src/openvpn/interval=2Eh<br>M src/openvpn/=
list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/manage=2Ec<br>M src/ope=
nvpn/manage=2Eh<br>M src/openvpn/mbuf=2Ec<br>M src/openvpn/mbuf=2Eh<br>M sr=
c/openvpn/mss=2Ec<br>M src/openvpn/mss=2Eh<br>M src/openvpn/mtcp=2Ec<br>M s=
rc/openvpn/mtcp=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br=
>M src/openvpn/multi=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/net=
working=2Eh<br>M src/openvpn/networking_iproute2=2Ec<br>M src/openvpn/netwo=
rking_sitnl=2Ec<br>M src/openvpn/occ=2Eh<br>M src/openvpn/openssl_compat=2E=
h<br>M src/openvpn/options=2Ec<br>M src/openvpn/options_parse=2Ec<br>M src/=
openvpn/otime=2Ec<br>M src/openvpn/otime=2Eh<br>M src/openvpn/proto=2Eh<br>=
M src/openvpn/proxy=2Ec<br>M src/openvpn/proxy=2Eh<br>M src/openvpn/ps=2Ec<=
br>M src/openvpn/ps=2Eh<br>M src/openvpn/push=2Ec<br>M src/openvpn/push=2Eh=
<br>M src/openvpn/push_util=2Ec<br>M src/openvpn/reliable=2Ec<br>M src/open=
vpn/reliable=2Eh<br>M src/openvpn/route=2Ec<br>M src/openvpn/schedule=2Ec<b=
r>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M src/openvpn/soc=
ket_util=2Eh<br>M src/openvpn/socks=2Ec<br>M src/openvpn/socks=2Eh<br>M src=
/openvpn/ssl=2Ec<br>M src/openvpn/ssl=2Eh<br>M src/openvpn/ssl_backend=2Eh<=
br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/=
openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M src/openvpn/ssl_verif=
y=2Ec<br>M src/openvpn/ssl_verify=2Eh<br>M src/openvpn/status=2Ec<br>M src/=
openvpn/status=2Eh<br>M src/openvpn/tun=2Ec<br>M src/openvpn/tun=2Eh<br>M s=
rc/openvpn/tun_afunix=2Ec<br>M src/openvpn/tun_afunix=2Eh<br>M src/openvpn/=
vlan=2Ec<br>M src/openvpn/vlan=2Eh<br>M src/openvpn/win32=2Eh<br>M src/open=
vpnmsica/openvpnmsica=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M tests/u=
nit_tests/openvpn/mock_management=2Ec<br>M tests/unit_tests/openvpn/test_mi=
sc=2Ec<br>M tests/unit_tests/openvpn/test_user_pass=2Ec<br>85 files changed=
, 337 insertions(+), 283 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1663/20</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression=
</span><br><span>index 965e8ec=2E=2Ec3a085d 100644</span><br><span>--- a/de=
v-tools/cppcheck-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppr=
ession</span><br><span>@@ -2,7 +2,6 @@</span><br><span> # occurences right =
now=2E They still should be fixed at some point</span><br><span> constParam=
eter</span><br><span> constParameterCallback</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-constParameterPointer</span><br><span> invalidPrintf=
ArgType_sint</span><br><span> invalidPrintfArgType_uint</span><br><span> un=
usedFunction</span><br><span>@@ -27,13 +26,51 @@</span><br><span> # FP: pos=
ix=2Ecfg claims suseconds_t is unsigned for some reason</span><br><span> un=
signedLessThanZero:src/openvpn/otime=2Eh:148</span><br><span> # IGN: multi =
code does weird things with pointers to local variables=2E=2E=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-autoVariables:src/openvpn/multi=
=2Ec:4232</span><br><span style=3D"color: hsl(120, 100%, 40%);">+autoVariab=
les:src/openvpn/multi=2Ec:4243</span><br><span> autoVariables:src/openvpn/m=
ulti_io=2Ec:324</span><br><span> # IGN: the code header =3D 0 | (OPCODE &lt=
;&lt; P_OPCODE_SHIFT) is used intentionally</span><br><span> badBitmaskChec=
k:src/openvpn/mudp=2Ec</span><br><span> badBitmaskCheck:tests/unit_tests/op=
envpn/test_pkt=2Ec</span><br><span> # IGN: we store integers in pointers</s=
pan><br><span> CastAddressToIntegerAtReturn:src/openvpn/multi=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: external</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:/usr/includ=
e/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: test file=
s provide mocks/stubs that match prototypes from headers exactly</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:tests/un=
it_tests/openvpn/mock_*</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+constParameterPointer:tests/unit_tests/openvpn/test_*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:tests/unit_test=
s/openvpnserv/test_*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# FP: different crypto implementations but same API</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/crypto_=
mbedtls_legacy=2Ec:85</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+constParameterPointer:src/openvpn/crypto_openssl=2Ec:173</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/cr=
ypto_openssl=2Ec:1433</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+constParameterPointer:src/openvpn/cryptoapi=2Ec:58</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/ssl_mbe=
dtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParame=
terPointer:src/openvpn/ssl_openssl=2Ec</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+constParameterPointer:src/openvpn/ssl_verify_mbedtls=2Ec=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPoint=
er:tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# IGN: too many different implementations, not =
worth it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParame=
terPointer:src/openvpn/dco*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+constParameterPointer:src/openvpn/socket=2E*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# FP: parameters are modified on some pla=
tform only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constPara=
meterPointer:src/openvpn/dns=2Ec:859</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+constParameterPointer:src/openvpn/error=2Ec:223</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/open=
vpn/forward=2Ec:1245</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+constParameterPointer:src/openvpn/manage=2Ec:344</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/manage=2Ec:=
3329</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterP=
ointer:src/openvpn/misc=2Ec:793</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+constParameterPointer:src/openvpn/misc=2Ec:813</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/op=
tions=2Ec:3205</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const=
ParameterPointer:src/openvpn/route=2Ec:3947</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/tun=2Ec:560</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src=
/openvpn/tun=2Ec:2188</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+constParameterPointer:src/openvpn/tun_afunix=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# IGN: not a FP but the documentation for th=
e FP_ISSET claims this is not const=2E=2E=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/event=2Ec:1015</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: we play around =
with const in the interface too much</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# also hides: fun:check_malloc_return: causes -Wmaybe-unin=
itialized in MinGW Debug build</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+constParameterPointer:src/openvpn/buffer=2Eh</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# FP: const silently removed due to poi=
nter arithmentic</span><br><span style=3D"color: hsl(120, 100%, 40%);">+con=
stParameterPointer:src/openvpn/buffer=2Ec:273</span><br><span> # IGN: Windo=
ws specific (unsigned long =3D=3D unsigned int)</span><br><span> compareVal=
ueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928</span><br><span> # FP:=
 cppcheck seems to have wrong signature of DeviceIoControl()</span><br><spa=
n>diff --git a/sample/sample-plugins/client-connect/sample-client-connect=
=2Ec b/sample/sample-plugins/client-connect/sample-client-connect=2Ec</span=
><br><span>index 420de61=2E=2Ecbd98e8 100644</span><br><span>--- a/sample/s=
ample-plugins/client-connect/sample-client-connect=2Ec</span><br><span>+++ =
b/sample/sample-plugins/client-connect/sample-client-connect=2Ec</span><br>=
<span>@@ -344,7 +344,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn_plugi=
n_client_connect(struct plugin_context *context, const char **argv, const c=
har **envp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_=
plugin_client_connect(const struct plugin_context *context, const char **ar=
gv, const char **envp)</span><br><span> {</span><br><span>     /* log envir=
onment variables handed to us by OpenVPN, but</span><br><span>      * only =
if &quot;setenv verb&quot; is 3 or higher (arbitrary number)</span><br><spa=
n>@@ -465,7 +465,7 @@</span><br><span> </span><br><span> int</span><br><spa=
n> openvpn_plugin_client_connect_defer_v2(struct plugin_context *context,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
                struct plugin_per_client_context *pcc,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                       c=
onst struct plugin_per_client_context *pcc,</span><br><span>               =
                         struct openvpn_plugin_string_list **return_list)</=
span><br><span> {</span><br><span>     time_t time_left =3D pcc-&gt;sleep_u=
ntil - time(NULL);</span><br><span>diff --git a/sample/sample-plugins/defer=
/multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec</span><br><spa=
n>index bacf557=2E=2Ecdd616f 100644</span><br><span>--- a/sample/sample-plu=
gins/defer/multi-auth=2Ec</span><br><span>+++ b/sample/sample-plugins/defer=
/multi-auth=2Ec</span><br><span>@@ -255,7 +255,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> static bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-do_auth_user_pass(struct plugin_context *context, cons=
t char *username, const char *password)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+do_auth_user_pass(const struct plugin_context *context,=
 const char *username, const char *password)</span><br><span> {</span><br><=
span>     plog(context, PLOG_NOTE, &quot;expect_user=3D%s, received_user=3D=
%s, expect_passw=3D%s, received_passw=3D%s&quot;,</span><br><span>         =
 np(context-&gt;test_valid_user), np(username), np(context-&gt;test_valid_p=
ass), np(password));</span><br><span>@@ -279,7 +279,7 @@</span><br><span> <=
/span><br><span> </span><br><span> static int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-auth_user_pass_verify(struct plugin_context *contex=
t, struct plugin_per_client_context *pcc,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+auth_user_pass_verify(const struct plugin_context *co=
ntext, struct plugin_per_client_context *pcc,</span><br><span>             =
          const char *argv[], const char *envp[])</span><br><span> {</span>=
<br><span>     /* get username/password from envp string array */</span><br=
><span>diff --git a/sample/sample-plugins/keying-material-exporter-demo/key=
ingmaterialexporter=2Ec b/sample/sample-plugins/keying-material-exporter-de=
mo/keyingmaterialexporter=2Ec</span><br><span>index 25c9ff5=2E=2E512861a 10=
0644</span><br><span>--- a/sample/sample-plugins/keying-material-exporter-d=
emo/keyingmaterialexporter=2Ec</span><br><span>+++ b/sample/sample-plugins/=
keying-material-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>@@=
 -186,7 +186,7 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-file_store(ch=
ar *file, char *content)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+file_store(const char *file, const char *content)</span><br><span> {</=
span><br><span>     FILE *f;</span><br><span>     if (!(f =3D fopen(file, &=
quot;w+&quot;)))</span><br><span>@@ -202,7 +202,7 @@</span><br><span> serve=
r_store(struct openvpn_plugin_args_func_in const *args)</span><br><span> {<=
/span><br><span>     struct plugin *plugin =3D (struct plugin *)args-&gt;ha=
ndle;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct sessi=
on *sess =3D (struct session *)args-&gt;per_client_context;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const struct session *sess =3D =
(struct session *)args-&gt;per_client_context;</span><br><span> </span><br>=
<span>     char file[MAXPATH];</span><br><span>     snprintf(file, sizeof(f=
ile) - 1, &quot;/tmp/openvpn_sso_%s&quot;, sess-&gt;key);</span><br><span>@=
@ -214,7 +214,7 @@</span><br><span> client_store(struct openvpn_plugin_args=
_func_in const *args)</span><br><span> {</span><br><span>     struct plugin=
 *plugin =3D (struct plugin *)args-&gt;handle;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct session *sess =3D (struct session *)arg=
s-&gt;per_client_context;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const struct session *sess =3D (struct session *)args-&gt;per_cli=
ent_context;</span><br><span> </span><br><span>     char *file =3D &quot;/t=
mp/openvpn_sso_user&quot;;</span><br><span>     ovpn_note(&quot;app session=
 file: %s&quot;, file);</span><br><span>diff --git a/src/openvpn/buffer=2Eh=
 b/src/openvpn/buffer=2Eh</span><br><span>index 22a8b74=2E=2E44ed434 100644=
</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/ope=
nvpn/buffer=2Eh</span><br><span>@@ -1918,7 +1918,7 @@</span><br><span>  * @=
param a  The arena to test=2E</span><br><span>  */</span><br><span> static =
inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gc_defined=
(struct gc_arena *a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+gc_defined(const struct gc_arena *a)</span><br><span> {</span><br><span>  =
   return a-&gt;list !=3D NULL;</span><br><span> }</span><br><span>diff --g=
it a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index =
3724022=2E=2E9fa8f5f 100644</span><br><span>--- a/src/openvpn/clinat=2Ec</s=
pan><br><span>+++ b/src/openvpn/clinat=2Ec</span><br><span>@@ -159,7 +159,7=
 @@</span><br><span> #endif</span><br><span> </span><br><span> static void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-print_pkt(struct openv=
pn_iphdr *iph, const char *prefix, const int direction, const msglvl_t msgl=
evel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_pkt(cons=
t struct openvpn_iphdr *iph, const char *prefix, const int direction, const=
 msglvl_t msglevel)</span><br><span> {</span><br><span>     struct gc_arena=
 gc =3D gc_new();</span><br><span> </span><br><span>diff --git a/src/openvp=
n/comp=2Ec b/src/openvpn/comp=2Ec</span><br><span>index b88b79f=2E=2E387a7c=
4 100644</span><br><span>--- a/src/openvpn/comp=2Ec</span><br><span>+++ b/s=
rc/openvpn/comp=2Ec</span><br><span>@@ -159,7 +159,7 @@</span><br><span> #e=
ndif /* USE_COMP */</span><br><span> </span><br><span> bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-check_compression_settings_valid(stru=
ct compress_options *info, msglvl_t msglevel)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+check_compression_settings_valid(const struct com=
press_options *info, msglvl_t msglevel)</span><br><span> {</span><br><span>=
     /*</span><br><span>      * We also allow comp-stub-v2 here as it techn=
ically allows escaping of</span><br><span>diff --git a/src/openvpn/comp=2Eh=
 b/src/openvpn/comp=2Eh</span><br><span>index 29a90a2=2E=2Ead80243 100644</=
span><br><span>--- a/src/openvpn/comp=2Eh</span><br><span>+++ b/src/openvpn=
/comp=2Eh</span><br><span>@@ -91,7 +91,7 @@</span><br><span>  * flags of al=
low-compression and also the whether algorithms are compiled</span><br><spa=
n>  * in</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-bool check_compression_settings_valid(struct compress_options *info=
, msglvl_t msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool check_compression_settings_valid(const struct compress_options *info=
, msglvl_t msglevel);</span><br><span> </span><br><span> #ifdef USE_COMP</s=
pan><br><span> #include &quot;buffer=2Eh&quot;</span><br><span>diff --git a=
/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index e5ad=
31a=2E=2Ee29d581 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span>=
<br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1105,7 +1105,7 @=
@</span><br><span> }</span><br><span> </span><br><span> static bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-key_is_zero(struct key *key, =
const struct key_type *kt)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+key_is_zero(const struct key *key, const struct key_type *kt)</span>=
<br><span> {</span><br><span>     size_t cipher_length =3D cipher_kt_key_si=
ze(kt-&gt;cipher);</span><br><span>     for (size_t i =3D 0; i &lt; cipher_=
length; ++i)</span><br><span>@@ -1123,7 +1123,7 @@</span><br><span>  * Make=
 sure that cipher key is a valid key for current key_type=2E</span><br><spa=
n>  */</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-check_key(struct key *key, const struct key_type *kt)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+check_key(const struct key *key, c=
onst struct key_type *kt)</span><br><span> {</span><br><span>     if (ciphe=
r_defined(kt-&gt;cipher))</span><br><span>     {</span><br><span>@@ -1196,7=
 +1196,7 @@</span><br><span> }</span><br><span> </span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-test_crypto(struct crypto_=
options *co, struct frame *frame)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_crypto(struct crypto_options *co, const struct frame *fr=
ame)</span><br><span> {</span><br><span>     int i, j;</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/=
crypto=2Eh b/src/openvpn/crypto=2Eh</span><br><span>index ee5b50f=2E=2Ee3c1=
c6a 100644</span><br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++=
 b/src/openvpn/crypto=2Eh</span><br><span>@@ -414,7 +414,7 @@</span><br><sp=
an>  */</span><br><span> int write_key_file(const int nkeys, const char *fi=
lename);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-bool check_key(struct key *key, const struct key_type *kt);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool check_key(const struct ke=
y *key, const struct key_type *kt);</span><br><span> </span><br><span> /**<=
/span><br><span>  * Initialize a key_type structure with=2E</span><br><span=
>@@ -614,7 +614,7 @@</span><br><span> /** Print a cipher list entry */</spa=
n><br><span> void print_cipher(const char *cipher);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void test_crypto(struct cry=
pto_options *co, struct frame *f);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_crypto(struct crypto_options *co, const struct fra=
me *f);</span><br><span> </span><br><span> </span><br><span> /* key directi=
on functions */</span><br><span>diff --git a/src/openvpn/dco=2Ec b/src/open=
vpn/dco=2Ec</span><br><span>index 8eae4bf=2E=2E3bf1fb2 100644</span><br><sp=
an>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</spa=
n><br><span>@@ -573,7 +573,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-dco_multi_get_localaddr(struct multi_context *m, struct multi_instance *mi=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_get_loca=
laddr(const struct multi_context *m, const struct multi_instance *mi,</span=
><br><span>                         struct sockaddr_storage *local)</span><=
br><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span>@@ -585,=
7 +585,7 @@</span><br><span>         return false;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct link_socket_actual *actual =3D &amp;c-&gt;c2=2Elink_socket_infos[0]-&=
gt;lsa-&gt;actual;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct link_socket_actual *actual =3D &amp;c-&gt;c2=2Elink_socket_=
infos[0]-&gt;lsa-&gt;actual;</span><br><span> </span><br><span>     switch =
(actual-&gt;dest=2Eaddr=2Esa=2Esa_family)</span><br><span>     {</span><br>=
<span>@@ -623,7 +623,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_multi_add=
_new_peer(struct multi_context *m, struct multi_instance *mi)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+dco_multi_add_new_peer(const stru=
ct multi_context *m, struct multi_instance *mi)</span><br><span> {</span><b=
r><span>     const struct context *c =3D &amp;mi-&gt;context;</span><br><sp=
an> </span><br><span>@@ -677,7 +677,7 @@</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-dco_install_iroute(struct multi_context *m, struct multi_instance *mi, s=
truct mroute_addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dco_install_iroute(struct multi_context *m, struct multi_instance *mi,=
 const struct mroute_addr *addr)</span><br><span> {</span><br><span> #if de=
fined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br=
><span>     if (!dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span>@@ =
-796,7 +796,7 @@</span><br><span>         /* Checked if we added a host rou=
te as the assigned client IP address was</span><br><span>          * outsid=
e the --ifconfig-ipv6 tun interface config */</span><br><span> #if !defined=
(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struc=
t in6_addr *dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct =
in6_addr *dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</sp=
an><br><span>         if (multi_check_push_ifconfig_ipv6_extra_route(mi, de=
st))</span><br><span>         {</span><br><span>             /* On windows =
we do not install these routes, so we also do not need to delete them */</s=
pan><br><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh</span>=
<br><span>index 4e5aad5=2E=2E694875c 100644</span><br><span>--- a/src/openv=
pn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><br><span>@@ -20=
4,7 +204,7 @@</span><br><span>  * @param mi        the client instance</spa=
n><br><span>  * @return          0 on success or a negative error code othe=
rwise</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-int dco_multi_add_new_peer(struct multi_context *m, struct multi_insta=
nce *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_mu=
lti_add_new_peer(const struct multi_context *m, struct multi_instance *mi);=
</span><br><span> </span><br><span> /**</span><br><span>  * Install an irou=
te in DCO, which means adding a route to the system routing</span><br><span=
>@@ -215,7 +215,7 @@</span><br><span>  * @param addr      the route to add<=
/span><br><span>  */</span><br><span> void dco_install_iroute(struct multi_=
context *m, struct multi_instance *mi,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                        struct mroute_addr *addr);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        con=
st struct mroute_addr *addr);</span><br><span> </span><br><span> /**</span>=
<br><span>  * Remove all routes added through the specified client</span><b=
r><span>@@ -253,7 +253,7 @@</span><br><span>  * a 64 bit packet counter and=
 AEAD tag at the end=2E</span><br><span>  */</span><br><span> bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct=
 context *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_su=
pports_epoch_data(const struct context *c);</span><br><span> #else  /* if d=
efined(ENABLE_DCO) */</span><br><span> </span><br><span> typedef void *dco_=
context_t;</span><br><span>@@ -350,7 +350,7 @@</span><br><span> }</span><br=
><span> </span><br><span> static inline int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-dco_multi_add_new_peer(struct multi_context *m, struc=
t multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+dco_multi_add_new_peer(const struct multi_context *m, struct multi_instan=
ce *mi)</span><br><span> {</span><br><span>     return 0;</span><br><span> =
}</span><br><span>@@ -384,7 +384,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> static inline bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-dco_supports_epoch_data(struct context *c)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct c=
ontext *c)</span><br><span> {</span><br><span>     return false;</span><br>=
<span> }</span><br><span>diff --git a/src/openvpn/dco_freebsd=2Ec b/src/ope=
nvpn/dco_freebsd=2Ec</span><br><span>index d933aaf=2E=2E7346903 100644</spa=
n><br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>+++ b/src/ope=
nvpn/dco_freebsd=2Ec</span><br><span>@@ -930,7 +930,7 @@</span><br><span> }=
</span><br><span> </span><br><span> bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-dco_supports_epoch_data(struct context *c)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const str=
uct context *c)</span><br><span> {</span><br><span>     return false;</span=
><br><span> }</span><br><span>diff --git a/src/openvpn/dco_internal=2Eh b/s=
rc/openvpn/dco_internal=2Eh</span><br><span>index fcf8aca=2E=2E1022e66 1006=
44</span><br><span>--- a/src/openvpn/dco_internal=2Eh</span><br><span>+++ b=
/src/openvpn/dco_internal=2Eh</span><br><span>@@ -59,8 +59,9 @@</span><br><=
span>  * They are implemented by dco_linux=2Ec</span><br><span>  */</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco_new=
_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, stru=
ct sockaddr *localaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                 struct sockaddr *remoteaddr, const struct in_addr *vpn_i=
pv4, const struct in6_addr *vpn_ipv6);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+int dco_new_peer(dco_context_t *dco, unsigned int peerid=
, socket_descriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                 struct sockaddr *localaddr, struct sockaddr *remotea=
ddr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);</span><=
br><span> </span><br><span> int dco_del_peer(dco_context_t *dco, unsigned i=
nt peerid);</span><br><span> </span><br><span>diff --git a/src/openvpn/dco_=
linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index 56f6259=2E=2E31=
bbe87 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><spa=
n>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -114,7 +114,7 @@</span=
><br><span> }</span><br><span> </span><br><span> static struct nl_msg *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_nlmsg_create(dco=
_context_t *dco, uint8_t cmd)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ovpn_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)</spa=
n><br><span> {</span><br><span>     struct nl_msg *nl_msg =3D nlmsg_alloc()=
;</span><br><span>     if (!nl_msg)</span><br><span>@@ -804,7 +804,7 @@</sp=
an><br><span> </span><br><span> /* libnl &lt; 3=2E11=2E0 does not implement=
 nla_get_uint() */</span><br><span> static uint64_t</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ovpn_nla_get_uint(struct nlattr *attr)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_nla_get_uint(const =
struct nlattr *attr)</span><br><span> {</span><br><span>     if (nla_len(at=
tr) =3D=3D sizeof(uint32_t))</span><br><span>     {</span><br><span>@@ -916=
,7 +916,7 @@</span><br><span> }</span><br><span> </span><br><span> static b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_iface_check(d=
co_context_t *dco, struct nlattr *attrs[])</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ovpn_iface_check(const dco_context_t *dco, struct nl=
attr *attrs[])</span><br><span> {</span><br><span>     /* we must know whic=
h interface this message is referring to in order to</span><br><span>      =
* avoid mixing messages for other instances</span><br><span>@@ -1340,7 +134=
0,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct =
context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supp=
orts_epoch_data(const struct context *c)</span><br><span> {</span><br><span=
>     return false;</span><br><span> }</span><br><span>diff --git a/src/ope=
nvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index b3268bc=2E=
=2E8deb9d8 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><=
span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -1100,7 +1100,7 @@</s=
pan><br><span> }</span><br><span> </span><br><span> bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct context *=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoc=
h_data(const struct context *c)</span><br><span> {</span><br><span>     OVP=
N_VERSION ver =3D { 0 };</span><br><span>     return dco_get_version(&amp;v=
er) &amp;&amp; ((ver=2EMajor =3D=3D 2 &amp;&amp; ver=2EMinor &gt;=3D 8) || =
(ver=2EMajor &gt; 2));</span><br><span>diff --git a/src/openvpn/event=2Eh b=
/src/openvpn/event=2Eh</span><br><span>index b784dfe=2E=2E0940a1d 100644</s=
pan><br><span>--- a/src/openvpn/event=2Eh</span><br><span>+++ b/src/openvpn=
/event=2Eh</span><br><span>@@ -204,7 +204,7 @@</span><br><span> #else /* if=
def _WIN32 */</span><br><span> </span><br><span> static inline void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-wait_signal(struct event_set =
*es, void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wait=
_signal(const struct event_set *es, const void *arg)</span><br><span> {</sp=
an><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/=
forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 83cd113=2E=2E56=
fc124 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>=
+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -231,7 +231,7 @@</span><br=
><span> }</span><br><span> </span><br><span> static void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-parse_incoming_control_channel_command(s=
truct context *c, struct buffer *buf)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+parse_incoming_control_channel_command(struct context *c,=
 const struct buffer *buf)</span><br><span> {</span><br><span>     if (buf_=
string_match_head_str(buf, &quot;AUTH_FAILED&quot;))</span><br><span>     {=
</span><br><span>@@ -501,7 +501,7 @@</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ge=
t_server_poll_remaining_time(struct event_timeout *server_poll_timeout)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+get_server_poll_remaini=
ng_time(const struct event_timeout *server_poll_timeout)</span><br><span> {=
</span><br><span>     update_time();</span><br><span>     int remaining =3D=
 event_timeout_remaining(server_poll_timeout);</span><br><span>@@ -598,7 +5=
98,7 @@</span><br><span>  * Buffer reallocation, for use with null encrypti=
on=2E</span><br><span>  */</span><br><span> static inline void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-buffer_turnover(const uint8_t *ori=
g_buf, struct buffer *dest_stub, struct buffer *src_stub,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+buffer_turnover(const uint8_t *orig_b=
uf, struct buffer *dest_stub, const struct buffer *src_stub,</span><br><spa=
n>                 struct buffer *storage)</span><br><span> {</span><br><sp=
an>     if (orig_buf =3D=3D src_stub-&gt;data &amp;&amp; src_stub-&gt;data =
!=3D storage-&gt;data)</span><br><span>@@ -885,7 +885,7 @@</span><br><span>=
  */</span><br><span> </span><br><span> static inline void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-socks_postprocess_incoming_link(struct=
 context *c, struct link_socket *sock)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+socks_postprocess_incoming_link(struct context *c, const=
 struct link_socket *sock)</span><br><span> {</span><br><span>     if (sock=
-&gt;socks_proxy &amp;&amp; sock-&gt;info=2Eproto =3D=3D PROTO_UDP)</span><=
br><span>     {</span><br><span>@@ -982,7 +982,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-process_incoming_link_part1(struct context *c, struct link_so=
cket_info *lsi, bool floated)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+process_incoming_link_part1(struct context *c, const struct link_=
socket_info *lsi, bool floated)</span><br><span> {</span><br><span>     str=
uct gc_arena gc =3D gc_new();</span><br><span>     bool decrypt_status =3D =
false;</span><br><span>@@ -1532,7 +1532,7 @@</span><br><span>  * @param cli=
ent    Determines whether to the send packet back via tun or link</span><br=
><span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-ipv6_send_icmp_unreachable(struct context *c, struct buffer *bu=
f, bool client)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ipv6=
_send_icmp_unreachable(struct context *c, const struct buffer *buf, bool cl=
ient)</span><br><span> {</span><br><span> #define MAX_ICMPV6LEN 1280</span>=
<br><span>     struct openvpn_icmp6hdr icmp6out;</span><br><span>diff --git=
 a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><span>index =
324c0b4=2E=2Eee7d2e2 100644</span><br><span>--- a/src/openvpn/forward=2Eh</=
span><br><span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -127,7 +127=
,7 @@</span><br><span>  */</span><br><span> void encrypt_sign(struct contex=
t *c, bool comp_frag);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-int get_server_poll_remaining_time(struct event_timeout =
*server_poll_timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+int get_server_poll_remaining_time(const struct event_timeout *server_po=
ll_timeout);</span><br><span> </span><br><span> /**************************=
********************************************/</span><br><span> /**</span><b=
r><span>@@ -178,7 +178,7 @@</span><br><span>  *</span><br><span>  * @return=
 true if packet is authenticated, false otherwise=2E</span><br><span>  */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool process_incoming_l=
ink_part1(struct context *c, struct link_socket_info *lsi, bool floated);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool process_incoming=
_link_part1(struct context *c, const struct link_socket_info *lsi, bool flo=
ated);</span><br><span> </span><br><span> /**</span><br><span>  * Continues=
 processing a packet read from the external network interface=2E</span><br>=
<span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><s=
pan>index 453ee7e=2E=2E525c135 100644</span><br><span>--- a/src/openvpn/ini=
t=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -803,7 =
+803,7 @@</span><br><span> }</span><br><span> </span><br><span> static void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_port_share(struc=
t context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_p=
ort_share(const struct context *c)</span><br><span> {</span><br><span>     =
if (!port_share &amp;&amp; (c-&gt;options=2Eport_share_host &amp;&amp; c-&g=
t;options=2Eport_share_port))</span><br><span>     {</span><br><span>@@ -12=
45,7 +1245,7 @@</span><br><span>  * prepending to msg() output=2E</span><br=
><span>  */</span><br><span> const char *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-format_common_name(struct context *c, struct gc_arena *=
gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+format_common_na=
me(const struct context *c, struct gc_arena *gc)</span><br><span> {</span><=
br><span>     struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span>=
     if (c-&gt;c2=2Etls_multi)</span><br><span>@@ -1731,7 +1731,7 @@</span>=
<br><span> </span><br><span> </span><br><span> static bool</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-can_preserve_tun(struct tuntap *tt)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+can_preserve_tun(const=
 struct tuntap *tt)</span><br><span> {</span><br><span>     if (tt &amp;&am=
p; tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span=
><br><span>@@ -1753,7 +1753,7 @@</span><br><span>  * @param c pointer to th=
e connection context</span><br><span>  */</span><br><span> static void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-add_wfp_block(struct conte=
xt *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_wfp_block=
(const struct context *c)</span><br><span> {</span><br><span> #if defined(_=
WIN32)</span><br><span>     /* Fortify &#39;redirect-gateway block-local&#3=
9; with firewall rules? */</span><br><span>@@ -1779,7 +1779,7 @@</span><br>=
<span>  * @param adapter_index the VPN adapter index</span><br><span>  */</=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-del_wfp_block(struct context *c, unsigned long adapter_index)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+del_wfp_block(const struct =
context *c, unsigned long adapter_index)</span><br><span> {</span><br><span=
> #if defined(_WIN32)</span><br><span>     if (c-&gt;options=2Eblock_outsid=
e_dns || block_local_needed(c-&gt;c1=2Eroute_list))</span><br><span>diff --=
git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh</span><br><span>index ce8=
f74e=2E=2Ec486158 100644</span><br><span>--- a/src/openvpn/init=2Eh</span><=
br><span>+++ b/src/openvpn/init=2Eh</span><br><span>@@ -91,7 +91,7 @@</span=
><br><span> </span><br><span> uint64_t pull_permission_mask(const struct co=
ntext *c);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-const char *format_common_name(struct context *c, struct gc_arena *g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *form=
at_common_name(const struct context *c, struct gc_arena *gc);</span><br><sp=
an> </span><br><span> void reset_coarse_timers(struct context *c);</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/interval=2Eh b/src/openv=
pn/interval=2Eh</span><br><span>index 59051bd=2E=2E0cfe202 100644</span><br=
><span>--- a/src/openvpn/interval=2Eh</span><br><span>+++ b/src/openvpn/int=
erval=2Eh</span><br><span>@@ -89,7 +89,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static inline void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-interval_schedule_wakeup(struct interval *top, interval=
_t *wakeup)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+interval=
_schedule_wakeup(const struct interval *top, interval_t *wakeup)</span><br>=
<span> {</span><br><span>     const time_t local_now =3D now;</span><br><sp=
an>     interval_earliest_wakeup(wakeup, top-&gt;last_test_true + top-&gt;r=
efresh, local_now);</span><br><span>@@ -214,7 +214,7 @@</span><br><span>  *=
 This function does not check if the timeout is actually valid=2E</span><br=
><span>  */</span><br><span> static inline interval_t</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-event_timeout_remaining(struct event_timeou=
t *et)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+event_timeout=
_remaining(const struct event_timeout *et)</span><br><span> {</span><br><sp=
an>     return (interval_t)((et-&gt;last + et-&gt;n) - now);</span><br><spa=
n> }</span><br><span>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=
=2Ec</span><br><span>index e51dcd0=2E=2Edcd59d7 100644</span><br><span>--- =
a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</span><br=
><span>@@ -164,7 +164,7 @@</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_remove=
_by_value(struct hash *hash, void *value)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+hash_remove_by_value(struct hash *hash, const void *v=
alue)</span><br><span> {</span><br><span>     struct hash_iterator hi;</spa=
n><br><span>     const struct hash_element *he;</span><br><span>diff --git =
a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>index 55bc3c8=
=2E=2E23267d0 100644</span><br><span>--- a/src/openvpn/list=2Eh</span><br><=
span>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -78,7 +78,7 @@</span><br=
><span> </span><br><span> bool hash_remove_fast(struct hash *hash, struct h=
ash_bucket *bucket, const void *key, uint64_t hv);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void hash_remove_by_value(st=
ruct hash *hash, void *value);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void hash_remove_by_value(struct hash *hash, const void *value);=
</span><br><span> </span><br><span> struct hash_iterator</span><br><span> {=
</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=
=2Ec</span><br><span>index 8e46470=2E=2E81a60a7 100644</span><br><span>--- =
a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span=
><br><span>@@ -330,7 +330,7 @@</span><br><span> }</span><br><span> </span><=
br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
man_delete_unix_socket(struct management *man)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+man_delete_unix_socket(const struct management *=
man)</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><s=
pan>     if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_=
CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><span>@@ -675,7 +675,7 @@</span><br=
><span>  * for the log and echo commands=2E</span><br><span>  */</span><br>=
<span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man=
_history(struct management *man, const char *parm, const char *type, struct=
 log_history *log,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
an_history(struct management *man, const char *parm, const char *type, cons=
t struct log_history *log,</span><br><span>             bool *realtime, con=
st unsigned int lep_flags)</span><br><span> {</span><br><span>     struct g=
c_arena gc =3D gc_new();</span><br><span>@@ -851,7 +851,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-man_net(struct management *man)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+man_net(const struct management=
 *man)</span><br><span> {</span><br><span>     if (man-&gt;persist=2Ecallba=
ck=2Eshow_net)</span><br><span>     {</span><br><span>@@ -887,7 +887,7 @@</=
span><br><span> #ifdef ENABLE_PKCS11</span><br><span> </span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_pkcs11_id=
_count(struct management *man)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+man_pkcs11_id_count(const struct management *man)</span><br><spa=
n> {</span><br><span>     msg(M_CLIENT, &quot;&gt;PKCS11ID-COUNT:%d&quot;, =
pkcs11_management_id_count());</span><br><span> }</span><br><span>@@ -2363,=
7 +2363,7 @@</span><br><span>  * the route/ifconfig/open tun command=2E   S=
ee doc/android=2Etxt for details=2E</span><br><span>  */</span><br><span> b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_android=
_control(struct management *man, const char *command, const char *msg)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+management_android_contr=
ol(const struct management *man, const char *command, const char *msg)</spa=
n><br><span> {</span><br><span>     if (!man)</span><br><span>     {</span>=
<br><span>@@ -3010,7 +3010,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-manage=
ment_up_down(struct management *man, const char *updown, const struct env_s=
et *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_u=
p_down(const struct management *man, const char *updown, const struct env_s=
et *es)</span><br><span> {</span><br><span>     if (man-&gt;settings=2Eflag=
s &amp; MF_UP_DOWN)</span><br><span>     {</span><br><span>@@ -3112,7 +3112=
,8 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-management_notify_client_close(s=
truct management *management, struct man_def_auth_context *mdac,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+management_notify_client_close=
(const struct management *management,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                               struct man_def_auth_contex=
t *mdac,</span><br><span>                                const struct env_s=
et *es)</span><br><span> {</span><br><span>     if ((mdac-&gt;flags &amp; D=
AF_INITIAL_AUTH) &amp;&amp; !(mdac-&gt;flags &amp; DAF_CONNECTION_CLOSED))<=
/span><br><span>@@ -3203,7 +3204,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
management_auth_failure(struct management *man, const char *type, const cha=
r *reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+managemen=
t_auth_failure(const struct management *man, const char *type, const char *=
reason)</span><br><span> {</span><br><span>     if (reason)</span><br><span=
>     {</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/m=
anage=2Eh</span><br><span>index 3ab937c=2E=2E8aa5c87 100644</span><br><span=
>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh<=
/span><br><span>@@ -368,7 +368,7 @@</span><br><span>                       =
          const unsigned int flags, const char *static_challenge);</span><b=
r><span> </span><br><span> #ifdef TARGET_ANDROID</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-bool management_android_control(struct managemen=
t *man, const char *command, const char *msg);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool management_android_control(const struct man=
agement *man, const char *command, const char *msg);</span><br><span> </spa=
n><br><span> #define ANDROID_KEEP_OLD_TUN      1</span><br><span> #define A=
NDROID_OPEN_BEFORE_CLOSE 2</span><br><span>@@ -382,7 +382,7 @@</span><br><s=
pan> </span><br><span> void management_event_loop_n_seconds(struct manageme=
nt *man, int sec);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-void management_up_down(struct management *man, const char *=
updown, const struct env_set *es);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void management_up_down(const struct management *man, const =
char *updown, const struct env_set *es);</span><br><span> </span><br><span>=
 void management_notify(const char *severity, const char *type,</span><br><=
span>                        const char *text);</span><br><span>@@ -397,7 +=
397,7 @@</span><br><span> void management_connection_established(struct man=
agement *management,</span><br><span>                                      =
  struct man_def_auth_context *mdac, const struct env_set *es);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void management=
_notify_client_close(struct management *management,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void management_notify_client_close(const=
 struct management *management,</span><br><span>                           =
          struct man_def_auth_context *mdac, const struct env_set *es);</sp=
an><br><span> </span><br><span> void management_learn_addr(struct man_def_a=
uth_context *mdac,</span><br><span>@@ -482,7 +482,7 @@</span><br><span>  * =
OpenVPN calls here to indicate a password failure</span><br><span>  */</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void man=
agement_auth_failure(struct management *man, const char *type, const char *=
reason);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void manage=
ment_auth_failure(const struct management *man, const char *type, const cha=
r *reason);</span><br><span> </span><br><span> /*</span><br><span>  * Echo =
an authentication token to management interface</span><br><span>diff --git =
a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec</span><br><span>index 7b790ed=
=2E=2E9a37e30 100644</span><br><span>--- a/src/openvpn/mbuf=2Ec</span><br><=
span>+++ b/src/openvpn/mbuf=2Ec</span><br><span>@@ -149,7 +149,7 @@</span><=
br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-mbuf_dereference_instance(struct mbuf_set *=
ms, struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+mbuf_dereference_instance(struct mbuf_set *ms, const struct mult=
i_instance *mi)</span><br><span> {</span><br><span>     if (ms)</span><br><=
span>     {</span><br><span>diff --git a/src/openvpn/mbuf=2Eh b/src/openvpn=
/mbuf=2Eh</span><br><span>index cfe698c=2E=2Ee368054 100644</span><br><span=
>--- a/src/openvpn/mbuf=2Eh</span><br><span>+++ b/src/openvpn/mbuf=2Eh</spa=
n><br><span>@@ -75,7 +75,7 @@</span><br><span> </span><br><span> bool mbuf_=
extract_item(struct mbuf_set *ms, struct mbuf_item *item);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void mbuf_dereferenc=
e_instance(struct mbuf_set *ms, struct multi_instance *mi);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void mbuf_dereference_instance(stru=
ct mbuf_set *ms, const struct multi_instance *mi);</span><br><span> </span>=
<br><span> static inline bool</span><br><span> mbuf_defined(const struct mb=
uf_set *ms)</span><br><span>diff --git a/src/openvpn/mss=2Ec b/src/openvpn/=
mss=2Ec</span><br><span>index 36bbb43=2E=2E0cfa272d 100644</span><br><span>=
--- a/src/openvpn/mss=2Ec</span><br><span>+++ b/src/openvpn/mss=2Ec</span><=
br><span>@@ -239,8 +239,8 @@</span><br><span> }</span><br><span> </span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fr=
ame_calculate_fragment(struct frame *frame, struct key_type *kt, const stru=
ct options *options,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                        struct link_socket_info *lsi)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+frame_calculate_fragment(struct frame *fr=
ame, const struct key_type *kt, const struct options *options,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                         const s=
truct link_socket_info *lsi)</span><br><span> {</span><br><span> #if define=
d(ENABLE_FRAGMENT)</span><br><span>     size_t overhead;</span><br><span>@@=
 -269,8 +269,8 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-frame_calcula=
te_mssfix(struct frame *frame, struct key_type *kt, const struct options *o=
ptions,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
         struct link_socket_info *lsi)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+frame_calculate_mssfix(struct frame *frame, const struct=
 key_type *kt, const struct options *options,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                       const struct link_socket_i=
nfo *lsi)</span><br><span> {</span><br><span>     if (options-&gt;ce=2Emssf=
ix_fixed)</span><br><span>     {</span><br><span>@@ -314,8 +314,8 @@</span>=
<br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-frame_calculate_dynamic(struct frame *frame=
, struct key_type *kt, const struct options *options,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        struct link_socket_=
info *lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+frame_cal=
culate_dynamic(struct frame *frame, const struct key_type *kt, const struct=
 options *options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       const struct link_socket_info *lsi)</span><br><span>=
 {</span><br><span>     if (options-&gt;ce=2Efragment &gt; 0)</span><br><sp=
an>     {</span><br><span>diff --git a/src/openvpn/mss=2Eh b/src/openvpn/ms=
s=2Eh</span><br><span>index 1d092bb=2E=2E2eab55a 100644</span><br><span>---=
 a/src/openvpn/mss=2Eh</span><br><span>+++ b/src/openvpn/mss=2Eh</span><br>=
<span>@@ -36,8 +36,8 @@</span><br><span> void mss_fixup_dowork(struct buffe=
r *buf, uint16_t maxmss);</span><br><span> </span><br><span> /** Set the --=
mssfix option=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id frame_calculate_dynamic(struct frame *frame, struct key_type *kt,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
 const struct options *options, struct link_socket_info *lsi);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void frame_calculate_dynamic(str=
uct frame *frame, const struct key_type *kt,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                             const struct options =
*options, const struct link_socket_info *lsi);</span><br><span> </span><br>=
<span> /**</span><br><span>  * Checks and adjusts the fragment and mssfix v=
alue according to the</span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/s=
rc/openvpn/mtcp=2Ec</span><br><span>index 5d88f8a=2E=2E922db3f 100644</span=
><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtc=
p=2Ec</span><br><span>@@ -91,7 +91,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-multi_tcp_instance_specific_init(struct multi_context *m, struct multi_in=
stance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_tc=
p_instance_specific_init(const struct multi_context *m, struct multi_instan=
ce *mi)</span><br><span> {</span><br><span>     /* buffer for queued TCP so=
cket output packets */</span><br><span>     mi-&gt;tcp_link_out_deferred =
=3D mbuf_init(m-&gt;top=2Eoptions=2En_bcast_buf);</span><br><span>diff --gi=
t a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh</span><br><span>index 9b7d1=
d2=2E=2Ebb117fa 100644</span><br><span>--- a/src/openvpn/mtcp=2Eh</span><br=
><span>+++ b/src/openvpn/mtcp=2Eh</span><br><span>@@ -35,7 +35,7 @@</span><=
br><span> </span><br><span> void multi_tcp_dereference_instance(struct mult=
i_io *multi_io, struct multi_instance *mi);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-bool multi_tcp_instance_specific_in=
it(struct multi_context *m, struct multi_instance *mi);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool multi_tcp_instance_specific_init(c=
onst struct multi_context *m, struct multi_instance *mi);</span><br><span> =
</span><br><span> void multi_tcp_instance_specific_free(struct multi_instan=
ce *mi);</span><br><span> </span><br><span>diff --git a/src/openvpn/mudp=2E=
c b/src/openvpn/mudp=2Ec</span><br><span>index de3d467=2E=2E5e37682 100644<=
/span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvp=
n/mudp=2Ec</span><br><span>@@ -53,8 +53,9 @@</span><br><span>  * @param soc=
k    the socket to send the reply on</span><br><span>  */</span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-send_stand=
alone_reply(struct multi_context *m, struct buffer *buf, const char *prefix=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
  const char *detail, struct link_socket *sock)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+send_standalone_reply(struct multi_context *m, =
const struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                      const char *prefix, const char *detail,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                      struc=
t link_socket *sock)</span><br><span> {</span><br><span>     struct context=
 *c =3D &amp;m-&gt;top;</span><br><span> </span><br><span>@@ -74,7 +75,7 @@=
</span><br><span> </span><br><span> static void</span><br><span> send_hmac_=
reset_packet(struct multi_context *m, struct tls_pre_decrypt_state *state,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
 struct tls_auth_standalone *tas, struct session_id *sid,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                       const struct t=
ls_auth_standalone *tas, const struct session_id *sid,</span><br><span>    =
                    bool request_resend_wkc, struct link_socket *sock)</spa=
n><br><span> {</span><br><span>     reset_packet_id_send(&amp;state-&gt;tls=
_wrap_tmp=2Eopt=2Epacket_id=2Esend);</span><br><span>@@ -97,11 +98,11 @@</s=
pan><br><span> </span><br><span>     enum first_packet_verdict verdict;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct tls_auth_standalone *tas =3D m-&gt;top=2Ec2=2Etls_auth_standalone;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct tls_aut=
h_standalone *tas =3D m-&gt;top=2Ec2=2Etls_auth_standalone;</span><br><span=
> </span><br><span>     verdict =3D tls_pre_decrypt_lite(tas, state, &amp;m=
-&gt;top=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *hmac_key =3D m-&=
gt;top=2Ec2=2Esession_id_key;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const uint8_t *hmac_key =3D m-&gt;top=2Ec2=2Esession_id_key;<=
/span><br><span>     const struct openvpn_sockaddr *from =3D &amp;m-&gt;top=
=2Ec2=2Efrom=2Edest;</span><br><span>     int handwindow =3D m-&gt;top=2Eop=
tions=2Ehandshake_window;</span><br><span> </span><br><span>@@ -218,7 +219,=
7 @@</span><br><span> static struct multi_instance *</span><br><span> handl=
e_connection_attempt(struct multi_context *m,</span><br><span>             =
              struct link_socket *sock,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                          struct mroute_addr *real)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
 const struct mroute_addr *real)</span><br><span> {</span><br><span>     st=
ruct hash *hash =3D m-&gt;hash;</span><br><span>     struct tls_pre_decrypt=
_state state =3D { 0 };</span><br><span>@@ -286,7 +287,7 @@</span><br><span=
>  * @return      instance matching the address, NULL otherwise</span><br><=
span>  */</span><br><span> static struct multi_instance *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-multi_get_instance_udp_real(struct mult=
i_context *m, struct mroute_addr *real)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+multi_get_instance_udp_real(struct multi_context *m, co=
nst struct mroute_addr *real)</span><br><span> {</span><br><span>     struc=
t hash *hash =3D m-&gt;hash;</span><br><span>     struct hash_element *he;<=
/span><br><span>@@ -320,7 +321,9 @@</span><br><span>  * maintaining real ad=
dress hash table atomicity=2E</span><br><span>  */</span><br><span> struct =
multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi=
_get_instance_udp_data(struct multi_context *m, bool *floated, struct mrout=
e_addr *real, struct link_socket *sock)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+multi_get_instance_udp_data(struct multi_context *m, bo=
ol *floated,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                     const struct mroute_addr *real,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            const struct =
link_socket *sock)</span><br><span> {</span><br><span>     struct multi_ins=
tance *mi =3D NULL;</span><br><span> </span><br><span>diff --git a/src/open=
vpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 3e72b92=2E=2E89=
e2d4c 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>++=
+ b/src/openvpn/multi=2Ec</span><br><span>@@ -57,7 +57,7 @@</span><br><span=
> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span> static c=
onst char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-id(struct =
multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
id(const struct multi_instance *mi)</span><br><span> {</span><br><span>    =
 if (mi)</span><br><span>     {</span><br><span>@@ -1314,7 +1314,7 @@</span=
><br><span>  * same common name=2E</span><br><span>  */</span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_delete=
_dup(struct multi_context *m, struct multi_instance *new_mi)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+multi_delete_dup(struct multi_cont=
ext *m, const struct multi_instance *new_mi)</span><br><span> {</span><br><=
span>     if (new_mi)</span><br><span>     {</span><br><span>@@ -2259,7 +22=
59,7 @@</span><br><span> }</span><br><span> </span><br><span> static bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_client_setup_dco_=
initial(struct multi_context *m, struct multi_instance *mi,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+multi_client_setup_dco_initial(cons=
t struct multi_context *m, struct multi_instance *mi,</span><br><span>     =
                           struct gc_arena *gc)</span><br><span> {</span><b=
r><span>     if (!dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><sp=
an>@@ -3078,7 +3078,8 @@</span><br><span>  * positive=2E</span><br><span>  =
*/</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-multi_check_dest_addr_allowed(struct multi_context *m, struct mul=
ti_instance *mi, struct mroute_addr *real)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+multi_check_dest_addr_allowed(struct multi_context *=
m, struct multi_instance *mi,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                              const struct mroute_addr *real)</sp=
an><br><span> {</span><br><span>     struct hash *hash =3D m-&gt;hash;</spa=
n><br><span>     const uint64_t hv =3D hash_value(hash, real);</span><br><s=
pan>@@ -3237,7 +3238,7 @@</span><br><span> </span><br><span> #if defined(EN=
ABLE_DCO)</span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-process_incoming_del_peer(struct multi_context *m, struct =
multi_instance *mi, dco_context_t *dco)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+process_incoming_del_peer(struct multi_context *m, stru=
ct multi_instance *mi, const dco_context_t *dco)</span><br><span> {</span><=
br><span>     const char *reason =3D &quot;ovpn-dco: unknown reason&quot;;<=
/span><br><span>     switch (dco-&gt;dco_del_peer_reason)</span><br><span>@=
@ -4291,7 +4292,7 @@</span><br><span> </span><br><span> /* Searches for the=
 address and deletes it if it is owned by the multi_instance */</span><br><=
span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mult=
i_unlearn_addr(struct multi_context *m, struct multi_instance *mi, const st=
ruct mroute_addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+multi_unlearn_addr(struct multi_context *m, const struct multi_instance=
 *mi, const struct mroute_addr *addr)</span><br><span> {</span><br><span>  =
   struct hash_element *he;</span><br><span>     const uint64_t hv =3D hash=
_value(m-&gt;vhash, addr);</span><br><span>@@ -4326,7 +4327,7 @@</span><br>=
<span>  * @param a     The new IPv4 address in network byte order</span><br=
><span>  */</span><br><span> static void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-multi_unlearn_in_addr_t(struct multi_context *m, struct =
multi_instance *mi, in_addr_t a)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+multi_unlearn_in_addr_t(struct multi_context *m, const struct =
multi_instance *mi, in_addr_t a)</span><br><span> {</span><br><span>     st=
ruct mroute_addr addr;</span><br><span>     CLEAR(addr);</span><br><span>@@=
 -4344,7 +4345,7 @@</span><br><span>  * @param a6    The new IPv6 address</=
span><br><span>  */</span><br><span> static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-multi_unlearn_in6_addr(struct multi_context *m, =
struct multi_instance *mi, struct in6_addr a6)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+multi_unlearn_in6_addr(struct multi_context *m, =
const struct multi_instance *mi, struct in6_addr a6)</span><br><span> {</sp=
an><br><span>     struct mroute_addr addr;</span><br><span>     CLEAR(addr)=
;</span><br><span>@@ -4460,7 +4461,7 @@</span><br><span> </span><br><span> =
bool</span><br><span> multi_check_push_ifconfig_ipv6_extra_route(struct mul=
ti_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                      struct in6_addr *dest)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
         const struct in6_addr *dest)</span><br><span> {</span><br><span>  =
   const struct options *o =3D &amp;mi-&gt;context=2Eoptions;</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=
=2Eh</span><br><span>index 6cb86c7=2E=2E5b8d56a 100644</span><br><span>--- =
a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><=
br><span>@@ -517,7 +517,7 @@</span><br><span>  */</span><br><span> </span><=
br><span> static inline void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-set_prefix(struct multi_instance *mi)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+set_prefix(const struct multi_instance *mi)</span>=
<br><span> {</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span=
>     if (mi-&gt;msg_prefix[0])</span><br><span>@@ -691,7 +691,7 @@</span><=
br><span>  */</span><br><span> bool</span><br><span> multi_check_push_ifcon=
fig_ipv6_extra_route(struct multi_instance *mi,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                           struct=
 in6_addr *dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                         const struct in6_addr *dest);</spa=
n><br><span> </span><br><span> /*</span><br><span>  * Check for signals=2E<=
/span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_i=
o=2Ec</span><br><span>index 3604684=2E=2E52eb8c7 100644</span><br><span>---=
 a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec<=
/span><br><span>@@ -159,7 +159,7 @@</span><br><span>  * a point-to-multipoi=
nt tunnel=2E</span><br><span>  */</span><br><span> static unsigned int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-p2mp_iow_flags(const struc=
t multi_context *m, struct link_socket *sock)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+p2mp_iow_flags(const struct multi_context *m, con=
st struct link_socket *sock)</span><br><span> {</span><br><span>     unsign=
ed int flags =3D IOW_WAIT_SIGNAL;</span><br><span> </span><br><span>diff --=
git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh</span><br><sp=
an>index bce0c19=2E=2E25233c8 100644</span><br><span>--- a/src/openvpn/netw=
orking=2Eh</span><br><span>+++ b/src/openvpn/networking=2Eh</span><br><span=
>@@ -44,7 +44,7 @@</span><br><span>  */</span><br><span> #if !defined(ENABL=
E_IPROUTE)</span><br><span> static inline int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-net_ctx_init(struct context *c, openvpn_net_ctx_t *=
ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_init(co=
nst struct context *c, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br=
><span>     (void)c;</span><br><span>     (void)ctx;</span><br><span>@@ -75=
,7 +75,7 @@</span><br><span>  *</span><br><span>  * @return          0 on s=
uccess, a negative error code otherwise</span><br><span>  */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-int net_ctx_init(struct context *c, =
openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+int net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx);</sp=
an><br><span> </span><br><span> /**</span><br><span>  * Release resources a=
llocated by the internal garbage collector</span><br><span>@@ -102,7 +102,7=
 @@</span><br><span>  * @return          0 on success, negative error code =
on error</span><br><span>  */</span><br><span> int net_iface_new(openvpn_ne=
t_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *type,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                  void *arg);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  con=
st void *arg);</span><br><span> </span><br><span> /**</span><br><span>  * R=
etrieve the interface type</span><br><span>diff --git a/src/openvpn/network=
ing_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span>inde=
x a1f3525=2E=2Ef091fb3 100644</span><br><span>--- a/src/openvpn/networking_=
iproute2=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec</spa=
n><br><span>@@ -36,7 +36,7 @@</span><br><span> #include &lt;netinet/in=2Eh&=
gt;</span><br><span> </span><br><span> int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_init(const=
 struct context *c, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><s=
pan>     ctx-&gt;es =3D NULL;</span><br><span>     if (c)</span><br><span>@=
@ -61,7 +61,7 @@</span><br><span> }</span><br><span> </span><br><span> int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_new(openvpn_=
net_ctx_t *ctx, const char *iface, const char *type, void *arg)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+net_iface_new(openvpn_net_ctx_t=
 *ctx, const char *iface, const char *type, const void *arg)</span><br><spa=
n> {</span><br><span>     struct argv argv =3D argv_new();</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openv=
pn/networking_sitnl=2Ec</span><br><span>index a396255=2E=2E13e0f0b 100644</=
span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b=
/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -1007,7 +1007,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> static int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_del(sa_family_t af_famil=
y, const char *iface, inet_address_t *addr, int prefixlen)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_del(sa_family_t af_family=
, const char *iface, const inet_address_t *addr, int prefixlen)</span><br><=
span> {</span><br><span>     int ifindex;</span><br><span> </span><br><span=
>@@ -1250,8 +1250,8 @@</span><br><span> }</span><br><span> </span><br><span=
> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_rou=
te_del(const char *iface, sa_family_t af_family, inet_address_t *dst, int p=
refixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    inet_address_t *gw, uint32_t table, int metric)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+sitnl_route_del(const char *iface, sa_fam=
ily_t af_family, const inet_address_t *dst, int prefixlen,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                const inet_address_t=
 *gw, uint32_t table, int metric)</span><br><span> {</span><br><span>     i=
nt ifindex =3D 0;</span><br><span> </span><br><span>@@ -1328,7 +1328,7 @@</=
span><br><span> </span><br><span> </span><br><span> int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-net_iface_new(openvpn_net_ctx_t *ctx, con=
st char *iface, const char *type, void *arg)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+net_iface_new(openvpn_net_ctx_t *ctx, const char *=
iface, const char *type, const void *arg)</span><br><span> {</span><br><spa=
n>     struct sitnl_link_req req =3D {};</span><br><span>     int ret =3D -=
1;</span><br><span>diff --git a/src/openvpn/occ=2Eh b/src/openvpn/occ=2Eh</=
span><br><span>index bda4f18=2E=2E49def4d 100644</span><br><span>--- a/src/=
openvpn/occ=2Eh</span><br><span>+++ b/src/openvpn/occ=2Eh</span><br><span>@=
@ -156,7 +156,7 @@</span><br><span>  * via control channel=2E</span><br><sp=
an>  * @return control channel exit message should be used */</span><br><sp=
an> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-cc_exit_notify_enabled(struct context *c)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+cc_exit_notify_enabled(const struct context *c)</spa=
n><br><span> {</span><br><span>     /* Check if we have TLS active at all *=
/</span><br><span>     if (!c-&gt;c2=2Etls_multi)</span><br><span>diff --gi=
t a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span><=
br><span>index 098bdd5=2E=2E1a934db 100644</span><br><span>--- a/src/openvp=
n/openssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh</=
span><br><span>@@ -127,7 +127,7 @@</span><br><span> /* Mimics the functions=
 but only when the default context without</span><br><span>  * options is c=
hosen */</span><br><span> static inline const EVP_CIPHER *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-EVP_CIPHER_fetch(void *ctx, const char=
 *algorithm, const char *properties)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+EVP_CIPHER_fetch(const void *ctx, const char *algorithm, c=
onst char *properties)</span><br><span> {</span><br><span>     ASSERT(!ctx)=
;</span><br><span>     ASSERT(!properties);</span><br><span>@@ -135,7 +135,=
7 @@</span><br><span> }</span><br><span> </span><br><span> static inline co=
nst EVP_MD *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-EVP_MD_fe=
tch(void *ctx, const char *algorithm, const char *properties)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+EVP_MD_fetch(const void *ctx, con=
st char *algorithm, const char *properties)</span><br><span> {</span><br><s=
pan>     ASSERT(!ctx);</span><br><span>     ASSERT(!properties);</span><br>=
<span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span>=
<br><span>index 8d8bba7=2E=2Eef7e063 100644</span><br><span>--- a/src/openv=
pn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><spa=
n>@@ -2423,7 +2423,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options=
_postprocess_mutate_le(struct connection_entry *ce, struct local_entry *le,=
 int mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_p=
ostprocess_mutate_le(const struct connection_entry *ce, struct local_entry =
*le, int mode)</span><br><span> {</span><br><span>     /* use the global po=
rt if none is specified */</span><br><span>     if (!le-&gt;port)</span><br=
><span>@@ -3576,7 +3576,7 @@</span><br><span> static bool</span><br><span> =
verify_permission(const char *name, const char *file, int line, const uint6=
4_t type,</span><br><span>                   const uint64_t allowed, uint64=
_t *found, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                  struct options *options, bool is_inline)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                  cons=
t struct options *options, bool is_inline)</span><br><span> {</span><br><sp=
an>     if (!(type &amp; allowed))</span><br><span>     {</span><br><span>@=
@ -4143,7 +4143,7 @@</span><br><span> }</span><br><span> </span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_compr=
ession_warning(struct compress_options *info)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+show_compression_warning(const struct compress_op=
tions *info)</span><br><span> {</span><br><span>     if (comp_non_stub_enab=
led(info))</span><br><span>     {</span><br><span>diff --git a/src/openvpn/=
options_parse=2Ec b/src/openvpn/options_parse=2Ec</span><br><span>index 88a=
b4d2=2E=2E0e94522 100644</span><br><span>--- a/src/openvpn/options_parse=2E=
c</span><br><span>+++ b/src/openvpn/options_parse=2Ec</span><br><span>@@ -2=
58,7 +258,7 @@</span><br><span> }</span><br><span> </span><br><span> static=
 char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_inline_fi=
le(struct in_src *is, const char *close_tag, int *num_lines, struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_inline_f=
ile(const struct in_src *is, const char *close_tag, int *num_lines, struct =
gc_arena *gc)</span><br><span> {</span><br><span>     char line[OPTION_LINE=
_SIZE];</span><br><span>     struct buffer buf =3D alloc_buf(8 * OPTION_LIN=
E_SIZE);</span><br><span>@@ -302,7 +302,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static int</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-check_inline_file(struct in_src *is, char *p[], struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_inline_=
file(const struct in_src *is, char *p[], struct gc_arena *gc)</span><br><sp=
an> {</span><br><span>     int num_inline_lines =3D 0;</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/otime=2Ec b/src/openvpn/otime=2Ec</s=
pan><br><span>index 1608458=2E=2E5d3633c 100644</span><br><span>--- a/src/o=
penvpn/otime=2Ec</span><br><span>+++ b/src/openvpn/otime=2Ec</span><br><spa=
n>@@ -66,7 +66,7 @@</span><br><span> }</span><br><span> </span><br><span> v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-update_now_usec(st=
ruct timeval *tv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+up=
date_now_usec(const struct timeval *tv)</span><br><span> {</span><br><span>=
     const time_t last =3D now;</span><br><span>     update_now(tv-&gt;tv_s=
ec);</span><br><span>diff --git a/src/openvpn/otime=2Eh b/src/openvpn/otime=
=2Eh</span><br><span>index d14f01e=2E=2E74d21ff 100644</span><br><span>--- =
a/src/openvpn/otime=2Eh</span><br><span>+++ b/src/openvpn/otime=2Eh</span><=
br><span>@@ -65,7 +65,7 @@</span><br><span> void update_now(const time_t sy=
stem_time);</span><br><span> </span><br><span> extern time_t now_usec;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void update_now_usec(struc=
t timeval *tv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 update_now_usec(const struct timeval *tv);</span><br><span> </span><br><sp=
an> static inline int</span><br><span> openvpn_gettimeofday(struct timeval =
*tv, void *tz)</span><br><span>diff --git a/src/openvpn/proto=2Eh b/src/ope=
nvpn/proto=2Eh</span><br><span>index 9bb0866=2E=2E1665751 100644</span><br>=
<span>--- a/src/openvpn/proto=2Eh</span><br><span>+++ b/src/openvpn/proto=
=2Eh</span><br><span>@@ -248,7 +248,7 @@</span><br><span>  * and offset of =
IP header (via parameter)=2E</span><br><span>  */</span><br><span> static i=
nline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_tun_ip_v=
er(int tunnel_type, struct buffer *buf, int *ip_hdr_offset)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+get_tun_ip_ver(int tunnel_type, con=
st struct buffer *buf, int *ip_hdr_offset)</span><br><span> {</span><br><sp=
an>     int ip_ver =3D -1;</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index e0700aa=
=2E=2E5e13d1f 100644</span><br><span>--- a/src/openvpn/proxy=2Ec</span><br>=
<span>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -527,8 +527,9 @@</span=
><br><span> }</span><br><span> </span><br><span> static bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-add_proxy_headers(struct http_proxy_=
info *p, socket_descriptor_t sd, /* already open to proxy */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                  const char *host  =
                                 /* openvpn server remote */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+add_proxy_headers(const struct htt=
p_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
               socket_descriptor_t sd, /* already open to proxy */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                  const char=
 *host        /* openvpn server remote */</span><br><span> )</span><br><spa=
n> {</span><br><span>     char buf[512];</span><br><span>@@ -597,8 +598,8 @=
@</span><br><span>                               socket_descriptor_t sd, /*=
 already open to proxy */</span><br><span>                               co=
nst char *host,       /* openvpn server remote */</span><br><span>         =
                      const char *port,       /* openvpn server port */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
     struct event_timeout *server_poll_timeout, struct buffer *lookahead,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
       struct signal_info *sig_info)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                              const struct event_timeout *=
server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                              struct buffer *lookahead, struct signal_info=
 *sig_info)</span><br><span> {</span><br><span>     struct gc_arena gc =3D =
gc_new();</span><br><span>     char buf[512];</span><br><span>diff --git a/=
src/openvpn/proxy=2Eh b/src/openvpn/proxy=2Eh</span><br><span>index e662e7d=
=2E=2Ea2f4e47 100644</span><br><span>--- a/src/openvpn/proxy=2Eh</span><br>=
<span>+++ b/src/openvpn/proxy=2Eh</span><br><span>@@ -89,7 +89,7 @@</span><=
br><span>                                    socket_descriptor_t sd, /* alr=
eady open to proxy */</span><br><span>                                    c=
onst char *host,       /* openvpn server remote */</span><br><span>        =
                            const char *port,       /* openvpn server port =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                struct event_timeout *server_poll_timeout,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                   c=
onst struct event_timeout *server_poll_timeout,</span><br><span>           =
                         struct buffer *lookahead, struct signal_info *sig_=
info);</span><br><span> </span><br><span> uint8_t *make_base64_string2(cons=
t uint8_t *str, int str_len, struct gc_arena *gc);</span><br><span>diff --g=
it a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index 08c2673=
=2E=2E2679c4d5 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><s=
pan>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -334,7 +334,7 @@</span><br>=
<span>  * the proxy can determine true client origin=2E</span><br><span>  *=
/</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-journal_add(const char *journal_dir, struct proxy_connection *pc, =
struct proxy_connection *cp)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+journal_add(const char *journal_dir, const struct proxy_connection=
 *pc, struct proxy_connection *cp)</span><br><span> {</span><br><span>     =
struct openvpn_sockaddr from, to;</span><br><span> </span><br><span>@@ -412=
,7 +412,7 @@</span><br><span> static bool</span><br><span> proxy_entry_new(=
struct proxy_connection **list, struct event_set *es,</span><br><span>     =
            const struct openvpn_sockaddr server_addr, const socket_descrip=
tor_t sd_client,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           struct buffer *initial_data, const char *journal_dir)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                const struct b=
uffer *initial_data, const char *journal_dir)</span><br><span> {</span><br>=
<span>     socket_descriptor_t sd_server;</span><br><span>     int status;<=
/span><br><span>@@ -1015,7 +1015,7 @@</span><br><span>  * call=2E</span><br=
><span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-port_share_redirect(struct port_share *ps, const struct buffer =
*head, socket_descriptor_t sd)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+port_share_redirect(const struct port_share *ps, const struct bu=
ffer *head, socket_descriptor_t sd)</span><br><span> {</span><br><span>    =
 if (ps)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/ps=
=2Eh b/src/openvpn/ps=2Eh</span><br><span>index 557ecf5=2E=2E918ceb6 100644=
</span><br><span>--- a/src/openvpn/ps=2Eh</span><br><span>+++ b/src/openvpn=
/ps=2Eh</span><br><span>@@ -49,7 +49,7 @@</span><br><span> </span><br><span=
> bool is_openvpn_protocol(const struct buffer *buf);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void port_share_redirect(=
struct port_share *ps, const struct buffer *head, socket_descriptor_t sd);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void port_share_redi=
rect(const struct port_share *ps, const struct buffer *head, socket_descrip=
tor_t sd);</span><br><span> </span><br><span> #endif /* if PORT_SHARE */</s=
pan><br><span> #endif /* ifndef PS_H */</span><br><span>diff --git a/src/op=
envpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 761a59e=2E=2Ed7=
2596e 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++=
 b/src/openvpn/push=2Ec</span><br><span>@@ -430,7 +430,7 @@</span><br><span=
> }</span><br><span> </span><br><span> bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-send_auth_pending_messages(struct tls_multi *tls_mult=
i, struct tls_session *session,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+send_auth_pending_messages(const struct tls_multi *tls_multi, s=
truct tls_session *session,</span><br><span>                            con=
st char *extra, unsigned int timeout)</span><br><span> {</span><br><span>  =
   struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><sp=
an>diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh</span><br><span=
>index dff945f=2E=2E39302f6 100644</span><br><span>--- a/src/openvpn/push=
=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</span><br><span>@@ -117,7 +=
117,7 @@</span><br><span>  * doc/management-notes=2Etxt under client-pendin=
g-auth for</span><br><span>  * more details on message format</span><br><sp=
an>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool send_auth=
_pending_messages(struct tls_multi *tls_multi, struct tls_session *session,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool send_auth_pend=
ing_messages(const struct tls_multi *tls_multi, struct tls_session *session=
,</span><br><span>                                 const char *extra, unsig=
ned int timeout);</span><br><span> </span><br><span> void send_restart(stru=
ct context *c, const char *kill_msg);</span><br><span>diff --git a/src/open=
vpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index 0213041=
=2E=2E7fa5987 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span>=
<br><span>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@ -222,7 +222,7 =
@@</span><br><span> </span><br><span> /* Return true if the client supports=
 push-update */</span><br><span> static bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-support_push_update(struct multi_instance *mi)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+support_push_update(const=
 struct multi_instance *mi)</span><br><span> {</span><br><span>     ASSERT(=
mi-&gt;context=2Ec2=2Etls_multi);</span><br><span>     const unsigned int i=
v_proto_peer =3D extract_iv_proto(mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_=
info);</span><br><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/=
reliable=2Ec</span><br><span>index ced438e=2E=2Eba819a3 100644</span><br><s=
pan>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliab=
le=2Ec</span><br><span>@@ -92,7 +92,7 @@</span><br><span> </span><br><span>=
 /* check if a particular packet_id is present in ack */</span><br><span> s=
tatic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reli=
able_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_packet_id=
_present(const struct reliable_ack *ack, packet_id_type pid)</span><br><spa=
n> {</span><br><span>     for (int i =3D 0; i &lt; ack-&gt;len; ++i)</span>=
<br><span>     {</span><br><span>@@ -391,7 +391,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-validate_packet_id_window(struct reliable *rel, packet_id_typ=
e pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+validate_pack=
et_id_window(const struct reliable *rel, packet_id_type pid)</span><br><spa=
n> {</span><br><span>     return reliable_pid_min(pid, rel-&gt;packet_id)</=
span><br><span>            &amp;&amp; reliable_pid_min(subtract_pid(rel-&gt=
;packet_id, RELIABLE_CAPACITY), pid);</span><br><span>@@ -768,7 +768,7 @@</=
span><br><span>  */</span><br><span> </span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-reliable_mark_active_incoming(struct =
reliable *rel, struct buffer *buf, packet_id_type pid,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+reliable_mark_active_incoming(struct rel=
iable *rel, const struct buffer *buf, packet_id_type pid,</span><br><span> =
                              int opcode)</span><br><span> {</span><br><spa=
n>     for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>@@ -828,=
7 +828,7 @@</span><br><span> </span><br><span> /* delete a buffer previousl=
y activated by reliable_mark_active() */</span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-reliable_mark_deleted(struct relia=
ble *rel, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+reliable_mark_deleted(struct reliable *rel, const struct buffer *=
buf)</span><br><span> {</span><br><span>     for (int i =3D 0; i &lt; rel-&=
gt;size; ++i)</span><br><span>     {</span><br><span>diff --git a/src/openv=
pn/reliable=2Eh b/src/openvpn/reliable=2Eh</span><br><span>index a85f2e9=2E=
=2E12d5367 100644</span><br><span>--- a/src/openvpn/reliable=2Eh</span><br>=
<span>+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ -184,7 +184,7 @@</s=
pan><br><span>  * @li False, if there are packet IDs to be acknowledged=2E<=
/span><br><span>  */</span><br><span> static inline bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-reliable_ack_empty(struct reliable_ack *=
ack)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_em=
pty(const struct reliable_ack *ack)</span><br><span> {</span><br><span>    =
 return !ack-&gt;len;</span><br><span> }</span><br><span>@@ -198,7 +198,7 @=
@</span><br><span>  * included in the valid range=2E</span><br><span>  */</=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-va=
lidate_packet_id_window(struct reliable *rel, packet_id_type pid);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+validate_packet_id_window(co=
nst struct reliable *rel, packet_id_type pid);</span><br><span> </span><br>=
<span> /**</span><br><span>  * Returns the number of packets that need to b=
e acked=2E</span><br><span>@@ -208,7 +208,7 @@</span><br><span>  * @returns=
 the number of outstanding acks</span><br><span>  */</span><br><span> stati=
c inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_=
ack_outstanding(struct reliable_ack *ack)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+reliable_ack_outstanding(const struct reliable_ack *a=
ck)</span><br><span> {</span><br><span>     return ack-&gt;len;</span><br><=
span> }</span><br><span>@@ -358,7 +358,7 @@</span><br><span>  * @param pid =
The packet&#39;s packet ID=2E</span><br><span>  * @param opcode The packet&=
#39;s opcode=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-void reliable_mark_active_incoming(struct reliable *rel, str=
uct buffer *buf, packet_id_type pid,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void reliable_mark_active_incoming(struct reliable *rel, c=
onst struct buffer *buf, packet_id_type pid,</span><br><span>              =
                      int opcode);</span><br><span> </span><br><span> /**</=
span><br><span>@@ -411,7 +411,7 @@</span><br><span>  * @param rel The relia=
ble structure associated with the given buffer=2E</span><br><span>  * @para=
m buf The buffer of the reliable entry which is to be removed=2E</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void reliab=
le_mark_deleted(struct reliable *rel, struct buffer *buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void reliable_mark_deleted(struct re=
liable *rel, const struct buffer *buf);</span><br><span> </span><br><span> =
/** @} name Functions for extracting incoming packets */</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec<=
/span><br><span>index 03a2526=2E=2E078bb7e 100644</span><br><span>--- a/src=
/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><s=
pan>@@ -898,8 +898,9 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_byp=
ass_routes(struct route_bypass *rb, in_addr_t gateway, const struct tuntap =
*tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
 unsigned int flags, const struct route_gateway_info *rgi,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+add_bypass_routes(const struct route=
_bypass *rb, in_addr_t gateway,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                  const struct tuntap *tt, unsigned int flags,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  co=
nst struct route_gateway_info *rgi,</span><br><span>                   cons=
t struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br>=
<span>     int ret =3D true;</span><br><span>@@ -916,8 +917,9 @@</span><br>=
<span> }</span><br><span> </span><br><span> static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-del_bypass_routes(struct route_bypass *rb=
, in_addr_t gateway, const struct tuntap *tt,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                  unsigned int flags, const struct =
route_gateway_info *rgi,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+del_bypass_routes(const struct route_bypass *rb, in_addr_t gateway,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                  cons=
t struct tuntap *tt, unsigned int flags,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                  const struct route_gateway_info *rgi=
,</span><br><span>                   const struct env_set *es, openvpn_net_=
ctx_t *ctx)</span><br><span> {</span><br><span>     int i;</span><br><span>=
@@ -3942,7 +3944,7 @@</span><br><span> #else  /* if defined(_WIN32) */</spa=
n><br><span> </span><br><span> static void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-get_bypass_addresses(struct route_bypass *rb, const un=
signed int flags) /* PLATFORM-SPECIFIC */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+get_bypass_addresses(struct route_bypass *rb, const u=
nsigned int flags)</span><br><span> {</span><br><span> }</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedul=
e=2Ec</span><br><span>index 6772ad6=2E=2E694f4d1 100644</span><br><span>---=
 a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src/openvpn/schedule=2Ec<=
/span><br><span>@@ -389,4 +389,4 @@</span><br><span> {</span><br><span>    =
 s-&gt;earliest_wakeup =3D NULL; /* invalidate cache */</span><br><span>   =
  schedule_remove_node(s, e);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span>\ No newline at end of file</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvp=
n/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 73871b2=2E=2Eb3=
cdc60 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+=
++ b/src/openvpn/socket=2Ec</span><br><span>@@ -619,7 +619,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-bind_local(struct link_socket *sock)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+bind_local(const struct l=
ink_socket *sock)</span><br><span> {</span><br><span>     /* bind to local =
address/port */</span><br><span>     if (sock-&gt;bind_local)</span><br><sp=
an>@@ -878,8 +878,8 @@</span><br><span> }</span><br><span> </span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket_bind(soc=
ket_descriptor_t sd, struct addrinfo *local, int ai_family, const char *pre=
fix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            bool =
ipv6only)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_bin=
d(socket_descriptor_t sd, const struct addrinfo *local, int ai_family,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            const char *=
prefix, bool ipv6only)</span><br><span> {</span><br><span>     struct gc_ar=
ena gc =3D gc_new();</span><br><span> </span><br><span>@@ -1087,8 +1087,8 @=
@</span><br><span>  * such as TCP=2E</span><br><span>  */</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void stream_bu=
f_init(struct stream_buf *sb, struct buffer *buf, const unsigned int sockfl=
ags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
           const int proto);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void stream_buf_init(struct stream_buf *sb, const struct bu=
ffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                   const unsigned int sockflags, const int proto);</span><b=
r><span> </span><br><span> static void stream_buf_close(struct stream_buf *=
sb);</span><br><span> </span><br><span>@@ -1441,7 +1441,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-phase2_set_socket_flags(struct link_socket =
*sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+phase2_set_so=
cket_flags(const struct link_socket *sock)</span><br><span> {</span><br><sp=
an>     /* TCP_NODELAY is enabled by default on every TCP socket; dco-win i=
s</span><br><span>      * skipped as it manages its own socket */</span><br=
><span>@@ -2037,7 +2037,7 @@</span><br><span> }</span><br><span> </span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
ream_buf_init(struct stream_buf *sb, struct buffer *buf, const unsigned int=
 sockflags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stream_b=
uf_init(struct stream_buf *sb, const struct buffer *buf, const unsigned int=
 sockflags,</span><br><span>                 const int proto)</span><br><sp=
an> {</span><br><span>     sb-&gt;buf_init =3D *buf;</span><br><span>@@ -23=
03,7 +2303,7 @@</span><br><span> #endif</span><br><span> </span><br><span> =
static ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_so=
cket_read_udp_posix_recvmsg(struct link_socket *sock, struct buffer *buf,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_read_udp_=
posix_recvmsg(const struct link_socket *sock, struct buffer *buf,</span><br=
><span>                                    struct link_socket_actual *from,=
 socklen_t *fromlen)</span><br><span> {</span><br><span>     struct iovec i=
ov;</span><br><span>@@ -2375,7 +2375,7 @@</span><br><span> #endif /* if ENA=
BLE_IP_PKTINFO */</span><br><span> </span><br><span> ssize_t</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-link_socket_read_udp_posix(struct li=
nk_socket *sock, struct buffer *buf,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+link_socket_read_udp_posix(const struct link_socket *sock,=
 struct buffer *buf,</span><br><span>                            struct lin=
k_socket_actual *from)</span><br><span> {</span><br><span>     ssize_t recv=
len;</span><br><span>@@ -2438,7 +2438,7 @@</span><br><span> #if ENABLE_IP_P=
KTINFO</span><br><span> </span><br><span> ssize_t</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-link_socket_write_udp_posix_sendmsg(struct link=
_socket *sock, struct buffer *buf,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+link_socket_write_udp_posix_sendmsg(const struct link_socket=
 *sock, const struct buffer *buf,</span><br><span>                         =
            struct link_socket_actual *to)</span><br><span> {</span><br><sp=
an>     struct iovec iov;</span><br><span>@@ -2634,7 +2634,7 @@</span><br><=
span> }</span><br><span> </span><br><span> int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-socket_send_queue(struct link_socket *sock, struct=
 buffer *buf, const struct link_socket_actual *to)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+socket_send_queue(struct link_socket *sock, =
const struct buffer *buf, const struct link_socket_actual *to)</span><br><s=
pan> {</span><br><span>     if (sock-&gt;writes=2Eiostate =3D=3D IOSTATE_IN=
ITIAL)</span><br><span>     {</span><br><span>@@ -2734,8 +2734,8 @@</span><=
br><span>     return sock-&gt;writes=2Eiostate;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-read_sockaddr_from_overlapped=
(struct overlapped_io *io, struct sockaddr *dst, int overlapped_ret)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+read_sockaddr_from_overlapped(cons=
t struct overlapped_io *io, struct sockaddr *dst, int overlapped_ret)</span=
><br><span> {</span><br><span>     if (overlapped_ret &gt;=3D 0 &amp;&amp; =
io-&gt;addr_defined)</span><br><span>     {</span><br><span>diff --git a/sr=
c/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index c6a29f4=
=2E=2Eaea9f42 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br=
><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -268,7 +268,7 @@</sp=
an><br><span> </span><br><span> int socket_recv_queue(struct link_socket *s=
ock, int maxsize);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-int socket_send_queue(struct link_socket *sock, struct buffe=
r *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int socket_s=
end_queue(struct link_socket *sock, const struct buffer *buf,</span><br><sp=
an>                       const struct link_socket_actual *to);</span><br><=
span> </span><br><span> typedef struct</span><br><span>@@ -348,8 +348,8 @@<=
/span><br><span> </span><br><span> struct link_socket *link_socket_new(void=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid socket_bind(socket_descriptor_t sd, struct addrinfo *local, int af_fami=
ly, const char *prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                 bool ipv6only);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void socket_bind(socket_descriptor_t sd, const struct addrin=
fo *local, int af_family,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                 const char *prefix, bool ipv6only);</span><br><span>=
 </span><br><span> int openvpn_connect(socket_descriptor_t sd, const struct=
 sockaddr *remote, int connect_timeout,</span><br><span>                   =
  volatile int *signal_received);</span><br><span>@@ -483,7 +483,7 @@</span=
><br><span> }</span><br><span> </span><br><span> static inline bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_verify_incoming_a=
ddr(struct buffer *buf, const struct link_socket_info *info,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+link_socket_verify_incoming_addr(c=
onst struct buffer *buf, const struct link_socket_info *info,</span><br><sp=
an>                                  const struct link_socket_actual *from_=
addr)</span><br><span> {</span><br><span>     if (buf-&gt;len &gt; 0)</span=
><br><span>@@ -607,7 +607,7 @@</span><br><span> </span><br><span> #else  /*=
 ifdef _WIN32 */</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-ssize_t link_socket_read_udp_posix(struct link_socket *sock, s=
truct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
size_t link_socket_read_udp_posix(const struct link_socket *sock, struct bu=
ffer *buf,</span><br><span>                                    struct link_=
socket_actual *from);</span><br><span> </span><br><span> #endif /* ifdef _W=
IN32 */</span><br><span>@@ -693,12 +693,12 @@</span><br><span> </span><br><=
span> #else /* ifdef _WIN32 */</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-ssize_t link_socket_write_udp_posix_sendmsg(stru=
ct link_socket *sock, struct buffer *buf,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ssize_t link_socket_write_udp_posix_sendmsg(const str=
uct link_socket *sock, const struct buffer *buf,</span><br><span>          =
                                   struct link_socket_actual *to);</span><b=
r><span> </span><br><span> </span><br><span> static inline ssize_t</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_udp_posix(st=
ruct link_socket *sock, struct buffer *buf,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+link_socket_write_udp_posix(const struct link_socke=
t *sock, const struct buffer *buf,</span><br><span>                        =
     struct link_socket_actual *to)</span><br><span> {</span><br><span> #if=
 ENABLE_IP_PKTINFO</span><br><span>@@ -714,7 +714,7 @@</span><br><span> }</=
span><br><span> </span><br><span> static inline ssize_t</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-link_socket_write_tcp_posix(struct link_s=
ocket *sock, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+link_socket_write_tcp_posix(const struct link_socket *sock, co=
nst struct buffer *buf)</span><br><span> {</span><br><span>     return send=
(sock-&gt;sd, CBPTR(buf), BLENZ(buf), MSG_NOSIGNAL);</span><br><span> }</sp=
an><br><span>@@ -772,7 +772,7 @@</span><br><span>  * from tunnel packet=2E<=
/span><br><span>  */</span><br><span> static inline void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-link_socket_set_tos(struct link_socket *=
sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_se=
t_tos(const struct link_socket *sock)</span><br><span> {</span><br><span>  =
   if (sock &amp;&amp; sock-&gt;ptos_defined)</span><br><span>     {</span>=
<br><span>@@ -818,6 +818,8 @@</span><br><span>     }</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* cp=
pcheck-suppress constParameterPointer</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * sock is modified on Windows via &amp;sock-&gt;listen_h=
andle */</span><br><span> static inline void</span><br><span> socket_reset_=
listen_persistent(struct link_socket *sock)</span><br><span> {</span><br><s=
pan>diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh<=
/span><br><span>index 13f5962=2E=2Eadd08ba 100644</span><br><span>--- a/src=
/openvpn/socket_util=2Eh</span><br><span>+++ b/src/openvpn/socket_util=2Eh<=
/span><br><span>@@ -439,7 +439,7 @@</span><br><span> </span><br><span> </sp=
an><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-addrlist_match_proto(const struct openvpn_sockaddr *a1, struct a=
ddrinfo *addr_list, const int proto)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+addrlist_match_proto(const struct openvpn_sockaddr *a1, co=
nst struct addrinfo *addr_list, const int proto)</span><br><span> {</span><=
br><span>     return link_socket_proto_connection_oriented(proto) ? addrlis=
t_match(a1, addr_list)</span><br><span>                                    =
                     : addrlist_port_match(a1, addr_list);</span><br><span>=
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span>=
index 19f3d54=2E=2E77ca863 100644</span><br><span>--- a/src/openvpn/socks=
=2Ec</span><br><span>+++ b/src/openvpn/socks=2Ec</span><br><span>@@ -82,7 +=
82,7 @@</span><br><span> </span><br><span> static bool</span><br><span> soc=
ks_proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                      st=
ruct event_timeout *server_poll_timeout,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                      const struct event_timeout *serv=
er_poll_timeout,</span><br><span>                       volatile int *signa=
l_received)</span><br><span> {</span><br><span>     fd_set reads;</span><br=
><span>@@ -97,8 +97,8 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_=
username_password_auth(struct socks_proxy_info *p, socket_descriptor_t sd,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
       struct event_timeout *server_poll_timeout,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+socks_username_password_auth(const struct soc=
ks_proxy_info *p, socket_descriptor_t sd,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                             const struct event_timeo=
ut *server_poll_timeout,</span><br><span>                              vola=
tile int *signal_received)</span><br><span> {</span><br><span>     char to_=
send[516];</span><br><span>@@ -156,8 +156,8 @@</span><br><span> }</span><br=
><span> </span><br><span> static bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-socks_handshake(struct socks_proxy_info *p, socket_descript=
or_t sd,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   struct event_timeout *server_poll_timeout, volatile int *signal_received=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socks_handshake(co=
nst struct socks_proxy_info *p, socket_descriptor_t sd,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                const struct event_time=
out *server_poll_timeout, volatile int *signal_received)</span><br><span> {=
</span><br><span>     uint8_t buf[2];</span><br><span>     int len =3D 0;</=
span><br><span>@@ -231,7 +231,7 @@</span><br><span> </span><br><span> stati=
c bool</span><br><span> recv_socks_reply(socket_descriptor_t sd, struct ope=
nvpn_sockaddr *addr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                struct event_timeout *server_poll_timeout, volatile int *si=
gnal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
            const struct event_timeout *server_poll_timeout, volatile int *=
signal_received)</span><br><span> {</span><br><span>     uint8_t atyp =3D 0=
;</span><br><span>     int alen =3D 0;</span><br><span>@@ -334,11 +334,11 @=
@</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-establish_socks_proxy_passthru(struc=
t socks_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+establish_socks_proxy_passthru(const struct socks_proxy_info *p,</span><=
br><span>                                socket_descriptor_t sd, /* already=
 open to proxy */</span><br><span>                                const cha=
r *host,       /* openvpn server remote */</span><br><span>                =
                const char *servname,   /* openvpn server port */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
struct event_timeout *server_poll_timeout,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                               const struct event_ti=
meout *server_poll_timeout,</span><br><span>                               =
 struct signal_info *sig_info)</span><br><span> {</span><br><span>     char=
 buf[270];</span><br><span>@@ -392,10 +392,10 @@</span><br><span> }</span><=
br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-establish_socks_proxy_udpassoc(struct socks_proxy_info *p,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+establish_socks_proxy_udp=
assoc(const struct socks_proxy_info *p,</span><br><span>                   =
             socket_descriptor_t ctrl_sd, /* already open to proxy */</span=
><br><span>                                struct openvpn_sockaddr *relay_a=
ddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
              struct event_timeout *server_poll_timeout,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                               const s=
truct event_timeout *server_poll_timeout,</span><br><span>                 =
               struct signal_info *sig_info)</span><br><span> {</span><br><=
span>     if (!socks_handshake(p, ctrl_sd, server_poll_timeout, &amp;sig_in=
fo-&gt;signal_received))</span><br><span>diff --git a/src/openvpn/socks=2Eh=
 b/src/openvpn/socks=2Eh</span><br><span>index 846113d=2E=2Ef7c93b6 100644<=
/span><br><span>--- a/src/openvpn/socks=2Eh</span><br><span>+++ b/src/openv=
pn/socks=2Eh</span><br><span>@@ -47,17 +47,17 @@</span><br><span> </span><b=
r><span> void socks_proxy_close(struct socks_proxy_info *sp);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void establish_so=
cks_proxy_passthru(struct socks_proxy_info *p,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void establish_socks_proxy_passthru(const struct=
 socks_proxy_info *p,</span><br><span>                                     =
socket_descriptor_t sd, /* already open to proxy */</span><br><span>       =
                              const char *host,       /* openvpn server rem=
ote */</span><br><span>                                     const char *ser=
vname,   /* openvpn server port */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                    struct event_timeout *serv=
er_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                 const struct event_timeout *server_poll_ti=
meout,</span><br><span>                                     struct signal_i=
nfo *sig_info);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void establish_socks_proxy_udpassoc(struct socks_proxy_info *p,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void establish_sock=
s_proxy_udpassoc(const struct socks_proxy_info *p,</span><br><span>        =
                             socket_descriptor_t ctrl_sd, /* already open t=
o proxy */</span><br><span>                                     struct open=
vpn_sockaddr *relay_addr,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                    struct event_timeout *server_poll_t=
imeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                        const struct event_timeout *server_poll_timeout,</s=
pan><br><span>                                     struct signal_info *sig_=
info);</span><br><span> </span><br><span> void socks_process_incoming_udp(s=
truct buffer *buf, struct link_socket_actual *from);</span><br><span>diff -=
-git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 7145=
9ee=2E=2E5cc2b1b 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br=
><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1171,7 +1171,7 @@</spa=
n><br><span> }</span><br><span> </span><br><span> struct tls_multi *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-tls_multi_init(struct tls_op=
tions *tls_options)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
tls_multi_init(const struct tls_options *tls_options)</span><br><span> {</s=
pan><br><span>     struct tls_multi *ret;</span><br><span> </span><br><span=
>@@ -1212,7 +1212,7 @@</span><br><span>  */</span><br><span> </span><br><sp=
an> struct tls_auth_standalone *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-tls_auth_standalone_init(struct tls_options *tls_options, struct=
 gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_a=
uth_standalone_init(const struct tls_options *tls_options, struct gc_arena =
*gc)</span><br><span> {</span><br><span>     struct tls_auth_standalone *ta=
s;</span><br><span> </span><br><span>@@ -1360,7 +1360,7 @@</span><br><span>=
 </span><br><span> static void</span><br><span> init_epoch_keys(struct key_=
state *ks, struct tls_multi *multi, const struct key_type *key_type,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                bool server,=
 struct key2 *key2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                bool server, const struct key2 *key2)</span><br><span> {</s=
pan><br><span>     /* For now we hardcode this to be 4 for the software bas=
ed data channel</span><br><span>      * DCO based implementations/HW implem=
entation might adjust this number</span><br><span>@@ -1403,7 +1403,7 @@</sp=
an><br><span> </span><br><span> static void</span><br><span> init_key_conte=
xts(struct key_state *ks, struct tls_multi *multi, const struct key_type *k=
ey_type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
     bool server, struct key2 *key2, bool dco_enabled)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                  bool server, const str=
uct key2 *key2, bool dco_enabled)</span><br><span> {</span><br><span>     s=
truct key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=2Ekey_ctx_bi;</span><b=
r><span> </span><br><span>@@ -1601,8 +1601,9 @@</span><br><span> </span><br=
><span> bool</span><br><span> tls_session_update_crypto_params_do_work(stru=
ct tls_multi *multi, struct tls_session *session,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                         struct=
 options *options, struct frame *frame,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                         struct frame *fr=
ame_fragment, struct link_socket_info *lsi,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                         const stru=
ct options *options, struct frame *frame,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                         struct frame=
 *frame_fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                       const struct link_socket_info *lsi,<=
/span><br><span>                                          dco_context_t *dc=
o)</span><br><span> {</span><br><span>     if (session-&gt;key[KS_PRIMARY]=
=2Ecrypto_options=2Ekey_ctx_bi=2Einitialized)</span><br><span>@@ -1671,7 +1=
672,7 @@</span><br><span> bool</span><br><span> tls_session_update_crypto_p=
arams(struct tls_multi *multi, struct tls_session *session,</span><br><span=
>                                  struct options *options, struct frame *f=
rame,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                 struct frame *frame_fragment, struct link_socket_info *lsi=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
               struct frame *frame_fragment, const struct link_socket_info =
*lsi,</span><br><span>                                  dco_context_t *dco)=
</span><br><span> {</span><br><span>     if (!check_session_cipher(session,=
 options))</span><br><span>@@ -1887,7 +1888,8 @@</span><br><span> }</span><=
br><span> </span><br><span> static bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-push_peer_info_peerid(struct buffer *out, struct tls_mult=
i *multi, struct tls_session *session)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+push_peer_info_peerid(struct buffer *out, const struct t=
ls_multi *multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                   const struct tls_session *session)</span><br><span> {</s=
pan><br><span>     if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID || session-&=
gt;opt-&gt;dco_enabled)</span><br><span>     {</span><br><span>@@ -1922,7 +=
1924,7 @@</span><br><span>  * @return          true if no error was encount=
ered</span><br><span>  */</span><br><span> static bool</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-push_peer_info(struct buffer *buf, struct =
tls_multi *multi, struct tls_session *session)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+push_peer_info(struct buffer *buf, const struct =
tls_multi *multi, struct tls_session *session)</span><br><span> {</span><br=
><span>     struct gc_arena gc =3D gc_new();</span><br><span>     bool ret =
=3D false;</span><br><span>@@ -2566,8 +2568,8 @@</span><br><span> }</span><=
br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-session_skip_to_pre_start(struct tls_session *session, struct tl=
s_pre_decrypt_state *state,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                          struct link_socket_actual *from)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+session_skip_to_pre_start(stru=
ct tls_session *session, const struct tls_pre_decrypt_state *state,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                          c=
onst struct link_socket_actual *from)</span><br><span> {</span><br><span>  =
   struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><sp=
an>     ks-&gt;session_id_remote =3D state-&gt;peer_session_id;</span><br><=
span>@@ -2785,7 +2787,7 @@</span><br><span> </span><br><span> static bool</=
span><br><span> check_outgoing_ciphertext(struct key_state *ks, struct tls_=
session *session,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                      struct buffer *to_link, bool *continue_tls_process)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
     const struct buffer *to_link, bool *continue_tls_process)</span><br><s=
pan> {</span><br><span>     if (to_link-&gt;len)</span><br><span>     {</sp=
an><br><span>@@ -3226,7 +3228,7 @@</span><br><span>         return;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    uint8_t *dataptr =3D to_link-&gt;data;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *dataptr =3D to_link-&=
gt;data;</span><br><span> </span><br><span>     /* we don&#39;t expect send=
_reliable to be NULL when state is</span><br><span>      * not S_UNDEF, but=
 people have reported crashes nonetheless,</span><br><span>@@ -4126,7 +4128=
,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-tls_post_encrypt(struct tls_mult=
i *multi, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+tls_post_encrypt(struct tls_multi *multi, const struct buffer *bu=
f)</span><br><span> {</span><br><span>     struct key_state *ks =3D multi-&=
gt;save_ks;</span><br><span>     multi-&gt;save_ks =3D NULL;</span><br><spa=
n>@@ -4257,7 +4259,7 @@</span><br><span>  * into a garbage collectable stri=
ng which is returned=2E</span><br><span>  */</span><br><span> const char *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-protocol_dump(struct b=
uffer *buffer, unsigned int flags, struct gc_arena *gc)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+protocol_dump(const struct buffer *buff=
er, unsigned int flags, struct gc_arena *gc)</span><br><span> {</span><br><=
span>     struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span>    =
 struct buffer buf =3D *buffer;</span><br><span>diff --git a/src/openvpn/ss=
l=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 7ddf965=2E=2E93e6200 1006=
44</span><br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src/open=
vpn/ssl=2Eh</span><br><span>@@ -166,7 +166,7 @@</span><br><span>  *</span><=
br><span>  * @return A newly allocated and initialized \c tls_multi structu=
re=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-struct tls_multi *tls_multi_init(struct tls_options *tls_options);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_multi *tls_m=
ulti_init(const struct tls_options *tls_options);</span><br><span> </span><=
br><span> /**</span><br><span>  * Finalize initialization of a \c tls_multi=
 structure=2E</span><br><span>@@ -187,7 +187,7 @@</span><br><span> /*</span=
><br><span>  * Initialize a standalone tls-auth verification object=2E</spa=
n><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struc=
t tls_auth_standalone *tls_auth_standalone_init(struct tls_options *tls_opt=
ions,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_aut=
h_standalone *tls_auth_standalone_init(const struct tls_options *tls_option=
s,</span><br><span>                                                      st=
ruct gc_arena *gc);</span><br><span> </span><br><span> /**</span><br><span>=
@@ -371,7 +371,7 @@</span><br><span>  * @param multi - The TLS state for th=
is packet&#39;s destination VPN tunnel=2E</span><br><span>  * @param buf - =
The buffer containing the outgoing packet=2E</span><br><span>  */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void tls_post_encrypt(struct tl=
s_multi *multi, struct buffer *buf);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void tls_post_encrypt(struct tls_multi *multi, const struc=
t buffer *buf);</span><br><span> </span><br><span> /** @} name Functions fo=
r managing security parameter state for data channel packets */</span><br><=
span> </span><br><span>@@ -461,7 +461,8 @@</span><br><span>  */</span><br><=
span> bool tls_session_update_crypto_params(struct tls_multi *multi, struct=
 tls_session *session,</span><br><span>                                    =
   struct options *options, struct frame *frame,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                      struct fra=
me *frame_fragment, struct link_socket_info *lsi,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                      struct =
frame *frame_fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                      const struct link_socket_info *lsi=
,</span><br><span>                                       dco_context_t *dco=
);</span><br><span> </span><br><span> /*</span><br><span>@@ -525,7 +526,7 @=
@</span><br><span> #define PD_VERBOSE                 (1 &lt;&lt; 10)</span=
><br><span> #define PD_TLS_CRYPT               (1 &lt;&lt; 11)</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *prot=
ocol_dump(struct buffer *buffer, unsigned int flags, struct gc_arena *gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *protocol=
_dump(const struct buffer *buffer, unsigned int flags, struct gc_arena *gc)=
;</span><br><span> </span><br><span> /*</span><br><span>  * debugging code<=
/span><br><span>@@ -573,7 +574,7 @@</span><br><span> /* Special method to s=
kip the three way handshake RESET stages=2E This is</span><br><span>  * use=
d by the HMAC code when seeing a packet that matches the previous</span><br=
><span>  * HMAC based stateless server state */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-bool session_skip_to_pre_start(struct tls_session=
 *session, struct tls_pre_decrypt_state *state,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                               struct link_socket=
_actual *from);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
 session_skip_to_pre_start(struct tls_session *session, const struct tls_pr=
e_decrypt_state *state,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                               const struct link_socket_actual *from);<=
/span><br><span> </span><br><span> #endif /* ifndef OPENVPN_SSL_H */</span>=
<br><span>diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backen=
d=2Eh</span><br><span>index a6d57f2=2E=2E29e07a6 100644</span><br><span>---=
 a/src/openvpn/ssl_backend=2Eh</span><br><span>+++ b/src/openvpn/ssl_backen=
d=2Eh</span><br><span>@@ -137,7 +137,7 @@</span><br><span>  *</span><br><sp=
an>  * @return      true if the context is initialised, false if not=2E</sp=
an><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool=
 tls_ctx_initialised(struct tls_root_ctx *ctx);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool tls_ctx_initialised(const struct tls_root_=
ctx *ctx);</span><br><span> </span><br><span> /**</span><br><span>  * Set a=
ny library specific options=2E</span><br><span>@@ -170,7 +170,7 @@</span><b=
r><span>  * @param ciphers       String containing : delimited cipher names=
, or NULL to use</span><br><span>  *                                      s=
ane defaults=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-void tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx=
, const char *ciphers);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, con=
st char *ciphers);</span><br><span> </span><br><span> /**</span><br><span> =
 * Set the TLS certificate profile=2E  The profile defines which crypto</sp=
an><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbe=
dtls=2Ec</span><br><span>index c92c423=2E=2Ecddf856 100644</span><br><span>=
--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbe=
dtls=2Ec</span><br><span>@@ -146,7 +146,7 @@</span><br><span> }</span><br><=
span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-tls_ctx_initialised(struct tls_root_ctx *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tls_ctx_initialised(const struct tls_root=
_ctx *ctx)</span><br><span> {</span><br><span>     /* either this should be=
 NULL or should be non-null and then have a</span><br><span>      * valid T=
LS ctx inside as well */</span><br><span>@@ -269,7 +269,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *=
ctx, const char *ciphers)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const =
char *ciphers)</span><br><span> {</span><br><span>     if (ciphers =3D=3D N=
ULL)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/ssl_op=
enssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index 7cfe9f4=2E=2E=
cb3de65 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br>=
<span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -129,7 +129,7 @@=
</span><br><span> }</span><br><span> </span><br><span> bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_initialised(struct tls_root_c=
tx *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_ini=
tialised(const struct tls_root_ctx *ctx)</span><br><span> {</span><br><span=
>     /* either this should be NULL or should be non-null and then have a</=
span><br><span>      * valid TLS ctx inside as well */</span><br><span>@@ -=
446,7 +446,7 @@</span><br><span> #endif</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_restrict_=
ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_restrict_ciphers_tls13(con=
st struct tls_root_ctx *ctx, const char *ciphers)</span><br><span> {</span>=
<br><span>     if (ciphers =3D=3D NULL)</span><br><span>     {</span><br><s=
pan>@@ -1093,7 +1093,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_c=
tx_load_cert_uri(struct tls_root_ctx *tls_ctx, const char *uri)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_load_cert_uri(const str=
uct tls_root_ctx *tls_ctx, const char *uri)</span><br><span> {</span><br><s=
pan> #if defined(HAVE_OPENSSL_STORE_API)</span><br><span>     X509 *x =3D N=
ULL;</span><br><span>@@ -2008,7 +2008,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-bio_debug_data(const char *mode, BIO *bio, const uint8_t *buf, =
int len, const char *desc)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bio_debug_data(const char *mode, const BIO *bio, const uint8_t *buf,=
 int len, const char *desc)</span><br><span> {</span><br><span>     struct =
gc_arena gc =3D gc_new();</span><br><span>     if (len &gt; 0)</span><br><s=
pan>@@ -2022,7 +2022,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bio_d=
ebug_oc(const char *mode, BIO *bio)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bio_debug_oc(const char *mode, const BIO *bio)</span><br><s=
pan> {</span><br><span>     open_biofp();</span><br><span>     fprintf(biof=
p, &quot;BIO %s time=3D%&quot; PRIi64 &quot; bio=3D&quot; ptr_format &quot;=
\n&quot;, mode, (int64_t)time(NULL),</span><br><span>diff --git a/src/openv=
pn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 90b2aec=2E=
=2E60b005f 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><=
span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -118,7 +118,7 @@</spa=
n><br><span>  */</span><br><span> static void</span><br><span> tls_wrap_con=
trol(struct tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                 struct sessio=
n_id *session_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
               const struct session_id *session_id)</span><br><span> {</spa=
n><br><span>     if (ctx-&gt;mode =3D=3D TLS_WRAP_AUTH || ctx-&gt;mode =3D=
=3D TLS_WRAP_NONE)</span><br><span>     {</span><br><span>@@ -402,9 +402,9 =
@@</span><br><span> </span><br><span> </span><br><span> struct buffer</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_reset_standalone(struct=
 tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                     struct session_id *own=
_sid, struct session_id *remote_sid, uint8_t header,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                     bool request_resend_wk=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_reset_standal=
one(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                     const=
 struct session_id *own_sid, const struct session_id *remote_sid,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                     uint8_t =
header, bool request_resend_wkc)</span><br><span> {</span><br><span>     /*=
 Copy buffer here to point at the same data but allow tls_wrap_control</spa=
n><br><span>      * to potentially change buf to point to another buffer wi=
thout</span><br><span>@@ -489,7 +489,7 @@</span><br><span> bool</span><br><=
span> check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,</s=
pan><br><span>                               const struct openvpn_sockaddr =
*from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
               uint8_t *key,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                              const uint8_t *key,</span><br><span>=
                               int handwindow,</span><br><span>            =
                   bool pkt_is_ack)</span><br><span> {</span><br><span>diff=
 --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>=
index 03e8930=2E=2E8203e4a 100644</span><br><span>--- a/src/openvpn/ssl_pkt=
=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -183,=
7 +183,7 @@</span><br><span>  * @return              the expected server se=
ssion id</span><br><span>  */</span><br><span> bool check_session_hmac_and_=
pkt_id(struct tls_pre_decrypt_state *state, const struct openvpn_sockaddr *=
from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                   uint8_t *key, int handwindow, bool pkt_is_ack);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
       const uint8_t *key, int handwindow, bool pkt_is_ack);</span><br><spa=
n> </span><br><span> /*</span><br><span>  * Write a control channel authent=
ication record=2E</span><br><span>@@ -210,8 +210,9 @@</span><br><span>  * f=
rom the tls pre decrypt state=2E</span><br><span>  *</span><br><span>  */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer tls_reset=
_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
         struct session_id *own_sid, struct session_id *remote_sid,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer tls_reset_sta=
ndalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
             const struct session_id *own_sid,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                   const struct =
session_id *remote_sid,</span><br><span>                                   =
 uint8_t header, bool request_resend_wkc);</span><br><span> </span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/s=
sl_verify=2Ec</span><br><span>index 3653eb4=2E=2E0e40370 100644</span><br><=
span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl=
_verify=2Ec</span><br><span>@@ -1139,7 +1139,7 @@</span><br><span>  * cache=
=2E</span><br><span>  */</span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tls_authentication_status_use_cache(struct =
tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tl=
s_authentication_status_use_cache(const struct tls_multi *multi)</span><br>=
<span> {</span><br><span>     unsigned int idx =3D min_uint(multi-&gt;tas_c=
ache_num_updates, SIZE(cache_intervals) - 1);</span><br><span>     time_t l=
atency =3D cache_intervals[idx];</span><br><span>@@ -1283,7 +1283,7 @@</spa=
n><br><span>  * Check if the script/plugin left a message in the auth faile=
d message</span><br><span>  * file and relay it to the user */</span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check=
_for_client_reason(struct tls_multi *multi, struct auth_deferred_status *st=
atus)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_for_clie=
nt_reason(struct tls_multi *multi, const struct auth_deferred_status *statu=
s)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();=
</span><br><span>     const char *msg =3D key_state_check_auth_failed_messa=
ge_file(status, &amp;gc);</span><br><span>@@ -1552,7 +1552,7 @@</span><br><=
span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><spa=
n> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set_ver=
ify_user_pass_env(struct user_pass *up, struct tls_multi *multi, struct tls=
_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
et_verify_user_pass_env(const struct user_pass *up, struct tls_multi *multi=
, struct tls_session *session)</span><br><span> {</span><br><span>     /* I=
s username defined? */</span><br><span>     if ((session-&gt;opt-&gt;ssl_fl=
ags &amp; SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up-&gt;username))</span><=
br><span>@@ -1580,7 +1580,7 @@</span><br><span> }</span><br><span> </span><=
br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssl_ver=
ify_username_length(struct tls_session *session, const char *username)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_verify_username_leng=
th(const struct tls_session *session, const char *username)</span><br><span=
> {</span><br><span>     if ((session-&gt;opt-&gt;ssl_flags &amp; SSLF_USER=
NAME_AS_COMMON_NAME)</span><br><span>         &amp;&amp; strlen(username) &=
gt; TLS_USERNAME_LEN)</span><br><span>diff --git a/src/openvpn/ssl_verify=
=2Eh b/src/openvpn/ssl_verify=2Eh</span><br><span>index 3176d76=2E=2Ee77bc4=
a 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Eh</span><br><span>+=
++ b/src/openvpn/ssl_verify=2Eh</span><br><span>@@ -202,7 +202,7 @@</span><=
br><span>  * @return              true if name is under limit or username-a=
s-common-name</span><br><span>  *                      is not active</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool ss=
l_verify_username_length(struct tls_session *session, const char *username)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ssl_verify_us=
ername_length(const struct tls_session *session, const char *username);</sp=
an><br><span> </span><br><span> /**</span><br><span>  * Runs the --client-c=
rresponse script if one is defined=2E</span><br><span>@@ -275,7 +275,7 @@</=
span><br><span> void auth_set_client_reason(struct tls_multi *multi, const =
char *client_reason);</span><br><span> </span><br><span> static inline cons=
t char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_client_re=
ason(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+tls_client_reason(const struct tls_multi *multi)</span><br><span>=
 {</span><br><span>     return multi-&gt;client_reason;</span><br><span> }<=
/span><br><span>diff --git a/src/openvpn/status=2Ec b/src/openvpn/status=2E=
c</span><br><span>index c7d375b=2E=2Ecfbc38d 100644</span><br><span>--- a/s=
rc/openvpn/status=2Ec</span><br><span>+++ b/src/openvpn/status=2Ec</span><b=
r><span>@@ -135,7 +135,7 @@</span><br><span> }</span><br><span> </span><br>=
<span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-status_res=
et(struct status_output *so)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+status_reset(const struct status_output *so)</span><br><span> {</s=
pan><br><span>     if (so &amp;&amp; so-&gt;fd &gt;=3D 0)</span><br><span> =
    {</span><br><span>diff --git a/src/openvpn/status=2Eh b/src/openvpn/sta=
tus=2Eh</span><br><span>index 7953a4e=2E=2E4c01d75 100644</span><br><span>-=
-- a/src/openvpn/status=2Eh</span><br><span>+++ b/src/openvpn/status=2Eh</s=
pan><br><span>@@ -69,7 +69,7 @@</span><br><span> </span><br><span> bool sta=
tus_trigger(struct status_output *so);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void status_reset(struct status_output *=
so);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void status_res=
et(const struct status_output *so);</span><br><span> </span><br><span> void=
 status_flush(struct status_output *so);</span><br><span> </span><br><span>=
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>inde=
x af48921=2E=2Eabb46af 100644</span><br><span>--- a/src/openvpn/tun=2Ec</sp=
an><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -835,7 +835,7 @@<=
/span><br><span>          const char *ifconfig_ipv6_local_parm,     /* --if=
config parm 1 IPv6 */</span><br><span>          int ifconfig_ipv6_netbits_p=
arm,</span><br><span>          const char *ifconfig_ipv6_remote_parm,    /*=
 --ifconfig parm 2 IPv6 */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-         struct addrinfo *local_public, struct addrinfo *remote_public=
, const bool strict_warn,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+         const struct addrinfo *local_public, const struct addrinfo *=
remote_public, const bool strict_warn,</span><br><span>          struct env=
_set *es, openvpn_net_ctx_t *ctx, struct tuntap *tt)</span><br><span> {</sp=
an><br><span>     if (!tt)</span><br><span>@@ -978,7 +978,7 @@</span><br><s=
pan>  * -&gt; helper function to simplify code below</span><br><span>  */</=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-add_route_connected_v6_net(struct tuntap *tt, const struct env_set *e=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_route_connect=
ed_v6_net(const struct tuntap *tt, const struct env_set *es)</span><br><spa=
n> {</span><br><span>     struct route_ipv6 r6;</span><br><span> </span><br=
><span>@@ -1020,7 +1020,7 @@</span><br><span>  */</span><br><span> </span><=
br><span> in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cr=
eate_arbitrary_remote(struct tuntap *tt)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+create_arbitrary_remote(const struct tuntap *tt)</span=
><br><span> {</span><br><span>     in_addr_t remote;</span><br><span> </spa=
n><br><span>@@ -1592,7 +1592,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv4(const struc=
t tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #=
if defined(TARGET_LINUX)</span><br><span>     int netbits =3D netmask_to_ne=
tbits2(tt-&gt;remote_netmask);</span><br><span>@@ -1627,7 +1627,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv6(struct tuntap *tt,=
 openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</s=
pan><br><span> {</span><br><span> #if defined(TARGET_LINUX)</span><br><span=
>     if (net_addr_v6_del(ctx, tt-&gt;actual_name, &amp;tt-&gt;local_ipv6, =
tt-&gt;netbits_ipv6) &lt; 0)</span><br><span>@@ -1652,7 +1652,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-undo_ifconfig(struct tuntap *tt, openvpn_net_c=
tx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+undo_ifco=
nfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</s=
pan><br><span>     if (tt-&gt;backend_driver !=3D DRIVER_NULL &amp;&amp; tt=
-&gt;backend_driver !=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><s=
pan>@@ -1720,7 +1720,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wr=
ite_tun_header(struct tuntap *tt, uint8_t *buf, int len)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+write_tun_header(const struct tuntap *=
tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span>     if=
 (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@=
@ -1737,9 +1737,11 @@</span><br><span>             type =3D htonl(AF_INET);=
</span><br><span>         }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* argument to writev is a pointer to con=
st but we still need to drop</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * the const from buf pointer here */</span><br><span>    =
     iv[0]=2Eiov_base =3D &amp;type;</span><br><span>         iv[0]=2Eiov_l=
en =3D sizeof(type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       iv[1]=2Eiov_base =3D buf;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        iv[1]=2Eiov_base =3D (void *)buf;</span><br><span>    =
     iv[1]=2Eiov_len =3D len;</span><br><span> </span><br><span>         re=
turn header_modify_read_write_return(writev(tt-&gt;fd, iv, 2));</span><br><=
span>@@ -1751,7 +1753,7 @@</span><br><span> }</span><br><span> </span><br><=
span> static ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-r=
ead_tun_header(struct tuntap *tt, uint8_t *buf, int len)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+read_tun_header(const struct tuntap *t=
t, uint8_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-&g=
t;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -1777=
,13 +1779,13 @@</span><br><span>  */</span><br><span> #if !defined(TARGET_D=
ARWIN)</span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt=
, const uint8_t *buf, int len)</span><br><span> {</span><br><span>     retu=
rn write_tun_header(tt, buf, len);</span><br><span> }</span><br><span> </sp=
an><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *b=
uf, int len)</span><br><span> {</span><br><span>     return read_tun_header=
(tt, buf, len);</span><br><span> }</span><br><span>@@ -1799,7 +1801,7 @@</s=
pan><br><span> </span><br><span> #if defined(TARGET_LINUX) || defined(TARGE=
T_FREEBSD)</span><br><span> static bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-tun_dco_enabled(struct tuntap *tt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tun_dco_enabled(const struct tuntap *tt)<=
/span><br><span> {</span><br><span>     return tt-&gt;backend_driver =3D=3D=
 DRIVER_DCO;</span><br><span> }</span><br><span>@@ -2046,13 +2048,13 @@</sp=
an><br><span> }</span><br><span> </span><br><span> ssize_t</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *=
buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_=
tun(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><span> =
{</span><br><span>     return write(tt-&gt;fd, buf, len);</span><br><span> =
}</span><br><span> </span><br><span> ssize_t</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct=
 tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>    =
 return read(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span>@@ -2=
251,13 +2253,13 @@</span><br><span> }</span><br><span> </span><br><span> ss=
ize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct=
 tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t *buf, int =
len)</span><br><span> {</span><br><span>     return write(tt-&gt;fd, buf, l=
en);</span><br><span> }</span><br><span> </span><br><span> ssize_t</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, ui=
nt8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</span><br><span> =
{</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><span> }=
</span><br><span>@@ -2587,7 +2589,7 @@</span><br><span> }</span><br><span> =
</span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, cons=
t uint8_t *buf, int len)</span><br><span> {</span><br><span>     struct str=
buf sbuf;</span><br><span>     sbuf=2Elen =3D len;</span><br><span>@@ -2596=
,7 +2598,7 @@</span><br><span> }</span><br><span> </span><br><span> ssize_t=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tunta=
p *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</span><b=
r><span> {</span><br><span>     struct strbuf sbuf;</span><br><span>     in=
t f =3D 0;</span><br><span>@@ -3094,7 +3096,7 @@</span><br><span> }</span><=
br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap=
 *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span>     =
if (tt-&gt;backend_driver =3D=3D DRIVER_UTUN)</span><br><span>     {</span>=
<br><span>@@ -3107,7 +3109,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-rea=
d_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf,=
 int len)</span><br><span> {</span><br><span>     if (tt-&gt;backend_driver=
 =3D=3D DRIVER_UTUN)</span><br><span>     {</span><br><span>@@ -3311,7 +331=
3,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-tun_write_queue(struct tuntap *t=
t, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+tun_write_queue(struct tuntap *tt, const struct buffer *buf)</span><br><=
span> {</span><br><span>     if (tt-&gt;writes=2Eiostate =3D=3D IOSTATE_INI=
TIAL)</span><br><span>     {</span><br><span>@@ -3366,7 +3368,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-tun_write_win32(struct tuntap *tt, struct buffe=
r *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_write_wi=
n32(struct tuntap *tt, const struct buffer *buf)</span><br><span> {</span><=
br><span>     int err =3D 0;</span><br><span>     int status =3D 0;</span><=
br><span>@@ -5374,7 +5376,7 @@</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fork_re=
gister_dns_action(struct tuntap *tt)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+fork_register_dns_action(const struct tuntap *tt)</span><b=
r><span> {</span><br><span>     if (tt &amp;&amp; tt-&gt;options=2Eregister=
_dns &amp;&amp; tt-&gt;options=2Emsg_channel)</span><br><span>     {</span>=
<br><span>@@ -5464,7 +5466,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-tuntap_get_mtu(struct tuntap *tt)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+tuntap_get_mtu(const struct tuntap *tt)</span><br><span> {</=
span><br><span>     ULONG mtu =3D 0;</span><br><span>     DWORD len;</span>=
<br><span>@@ -6039,7 +6041,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_sh=
ow_debug(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+tun_show_debug(const struct tuntap *tt)</span><br><span> {</span><b=
r><span>     if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)<=
/span><br><span>     {</span><br><span>diff --git a/src/openvpn/tun=2Eh b/s=
rc/openvpn/tun=2Eh</span><br><span>index 2477560=2E=2E0ff2a0b 100644</span>=
<br><span>--- a/src/openvpn/tun=2Eh</span><br><span>+++ b/src/openvpn/tun=
=2Eh</span><br><span>@@ -272,9 +272,9 @@</span><br><span> </span><br><span>=
 void close_tun_handle(struct tuntap *tt);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-ssize_t write_tun(struct tuntap *tt,=
 uint8_t *buf, int len);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ssize_t write_tun(const struct tuntap *tt, const uint8_t *buf, int len=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
size_t read_tun(struct tuntap *tt, uint8_t *buf, int len);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ssize_t read_tun(const struct tuntap=
 *tt, uint8_t *buf, int len);</span><br><span> </span><br><span> #ifdef ENA=
BLE_FEATURE_TUN_PERSIST</span><br><span> void tuncfg(const char *dev, const=
 char *dev_type, const char *dev_node, int persist_mode,</span><br><span>@@=
 -293,7 +293,7 @@</span><br><span>                         const char *ifco=
nfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */</span><br><span>  =
                       int ifconfig_ipv6_netbits_parm,           /* --ifcon=
fig parm 1 / bits */</span><br><span>                         const char *i=
fconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                        struct addrin=
fo *local_public, struct addrinfo *remote_public,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        const struct addrinfo=
 *local_public, const struct addrinfo *remote_public,</span><br><span>     =
                    const bool strict_warn, struct env_set *es, openvpn_net=
_ctx_t *ctx,</span><br><span>                         struct tuntap *tt);</=
span><br><span> </span><br><span>@@ -320,7 +320,7 @@</span><br><span>  * @p=
aram tt    the tuntap interface context</span><br><span>  * @param ctx   th=
e networking API opaque context</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void undo_ifconfig(struct tuntap *tt, openv=
pn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx);</span>=
<br><span> </span><br><span> bool is_dev_type(const char *dev, const char *=
dev_type, const char *match_type);</span><br><span> </span><br><span>@@ -35=
1,7 +351,7 @@</span><br><span> #define IFCONFIG_DEFAULT IFCONFIG_AFTER_TUN_=
OPEN</span><br><span> </span><br><span> static inline int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-ifconfig_order(struct tuntap *tt)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_order(const stru=
ct tuntap *tt)</span><br><span> {</span><br><span>     if (tt-&gt;backend_d=
river =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -381,=
7 +381,7 @@</span><br><span> #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN</s=
pan><br><span> </span><br><span> static inline int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-route_order(struct tuntap *tt)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+route_order(const struct tuntap *tt=
)</span><br><span> {</span><br><span>     if (tt-&gt;backend_driver =3D=3D =
DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -454,13 +454,13 @@=
</span><br><span> </span><br><span> const char *tap_win_getinfo(const struc=
t tuntap *tt, struct gc_arena *gc);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void tun_show_debug(struct tuntap *tt);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void tun_show_debug(con=
st struct tuntap *tt);</span><br><span> </span><br><span> bool dhcp_release=
_by_adapter_index(const DWORD adapter_index);</span><br><span> </span><br><=
span> bool dhcp_renew_by_adapter_index(const DWORD adapter_index);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void fork_re=
gister_dns_action(struct tuntap *tt);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void fork_register_dns_action(const struct tuntap *tt);</=
span><br><span> </span><br><span> void ipconfig_register_dns(const struct e=
nv_set *es);</span><br><span> </span><br><span>@@ -470,7 +470,7 @@</span><b=
r><span> </span><br><span> int tun_read_queue(struct tuntap *tt, int maxsiz=
e);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
int tun_write_queue(struct tuntap *tt, struct buffer *buf);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+int tun_write_queue(struct tuntap *=
tt, const struct buffer *buf);</span><br><span> </span><br><span> static in=
line bool</span><br><span> tuntap_stop(int status)</span><br><span>@@ -499,=
7 +499,7 @@</span><br><span>     return false;</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int tun_write=
_win32(struct tuntap *tt, struct buffer *buf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+int tun_write_win32(struct tuntap *tt, const str=
uct buffer *buf);</span><br><span> </span><br><span> static inline bool</sp=
an><br><span> is_ip_packet_valid(const struct buffer *buf)</span><br><span>=
@@ -529,13 +529,13 @@</span><br><span> }</span><br><span> </span><br><span>=
 static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tu=
ntap_is_dco_win(struct tuntap *tt)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+tuntap_is_dco_win(const struct tuntap *tt)</span><br><span> =
{</span><br><span>     return tt &amp;&amp; tt-&gt;backend_driver =3D=3D DR=
IVER_DCO;</span><br><span> }</span><br><span> </span><br><span> static inli=
ne bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_=
win_timeout(struct tuntap *tt, ssize_t status)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const struct tuntap *t=
t, ssize_t status)</span><br><span> {</span><br><span>     return tuntap_is=
_dco_win(tt) &amp;&amp; (status &lt; 0) &amp;&amp; (openvpn_errno() =3D=3D =
ERROR_NETNAME_DELETED);</span><br><span> }</span><br><span>@@ -555,25 +555,=
25 @@</span><br><span> }</span><br><span> </span><br><span> static inline v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_standby_init(s=
truct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tu=
n_standby_init(const struct tuntap *tt)</span><br><span> {</span><br><span>=
 }</span><br><span> </span><br><span> static inline bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-tun_standby(struct tuntap *tt)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+tun_standby(const struct tunt=
ap *tt)</span><br><span> {</span><br><span>     return true;</span><br><spa=
n> }</span><br><span> </span><br><span> </span><br><span> static inline boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win(st=
ruct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun=
tap_is_dco_win(const struct tuntap *tt)</span><br><span> {</span><br><span>=
     return false;</span><br><span> }</span><br><span> </span><br><span> st=
atic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tunta=
p_is_dco_win_timeout(struct tuntap *tt, ssize_t status)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const struct =
tuntap *tt, ssize_t status)</span><br><span> {</span><br><span>     return =
false;</span><br><span> }</span><br><span>diff --git a/src/openvpn/tun_afun=
ix=2Ec b/src/openvpn/tun_afunix=2Ec</span><br><span>index a67a472=2E=2Ee922=
3bc 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Ec</span><br><span=
>+++ b/src/openvpn/tun_afunix=2Ec</span><br><span>@@ -48,7 +48,7 @@</span><=
br><span> </span><br><span> </span><br><span> static void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-tun_afunix_exec_child(const char *dev_n=
ode, struct tuntap *tt, struct env_set *env)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+tun_afunix_exec_child(const char *dev_node, struct=
 tuntap *tt, const struct env_set *env)</span><br><span> {</span><br><span>=
     const char *msgprefix =3D &quot;ERROR: failure executing process for t=
un:&quot;;</span><br><span>     struct argv argv =3D argv_new();</span><br>=
<span>@@ -73,7 +73,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-open_tun_afuni=
x(struct options *o, int mtu, struct tuntap *tt, struct env_set *orig_env)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+open_tun_afunix(cons=
t struct options *o, int mtu, struct tuntap *tt, const struct env_set *orig=
_env)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new=
();</span><br><span> </span><br><span>diff --git a/src/openvpn/tun_afunix=
=2Eh b/src/openvpn/tun_afunix=2Eh</span><br><span>index 5b6a8e0=2E=2Efb88eb=
2 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Eh</span><br><span>+=
++ b/src/openvpn/tun_afunix=2Eh</span><br><span>@@ -31,7 +31,7 @@</span><br=
><span>  * the user provided taking care of implementing the actual tun</sp=
an><br><span>  * device=2E</span><br><span>  */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void open_tun_afunix(struct options *o, int mtu, =
struct tuntap *tt, struct env_set *env);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void open_tun_afunix(const struct options *o, int mtu,=
 struct tuntap *tt, const struct env_set *env);</span><br><span> </span><br=
><span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/vlan=
=2Ec b/src/openvpn/vlan=2Ec</span><br><span>index 69ac10d=2E=2E04e18d6 1006=
44</span><br><span>--- a/src/openvpn/vlan=2Ec</span><br><span>+++ b/src/ope=
nvpn/vlan=2Ec</span><br><span>@@ -288,7 +288,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-vlan_process_outgoing_tun(struct multi_context *m, struct multi=
_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vlan_=
process_outgoing_tun(const struct multi_context *m, struct multi_instance *=
mi)</span><br><span> {</span><br><span>     if (!m-&gt;top=2Eoptions=2Evlan=
_tagging)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/v=
lan=2Eh b/src/openvpn/vlan=2Eh</span><br><span>index 9389f89=2E=2Ecd2f66f 1=
00644</span><br><span>--- a/src/openvpn/vlan=2Eh</span><br><span>+++ b/src/=
openvpn/vlan=2Eh</span><br><span>@@ -35,6 +35,6 @@</span><br><span> </span>=
<br><span> bool vlan_is_tagged(const struct buffer *buf);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void vlan_process_out=
going_tun(struct multi_context *m, struct multi_instance *mi);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void vlan_process_outgoing_tun(c=
onst struct multi_context *m, struct multi_instance *mi);</span><br><span> =
</span><br><span> #endif /* VLAN_H */</span><br><span>diff --git a/src/open=
vpn/win32=2Eh b/src/openvpn/win32=2Eh</span><br><span>index 8be3d96=2E=2E39=
ff7d8 100644</span><br><span>--- a/src/openvpn/win32=2Eh</span><br><span>++=
+ b/src/openvpn/win32=2Eh</span><br><span>@@ -227,7 +227,7 @@</span><br><sp=
an> void overlapped_io_close(struct overlapped_io *o);</span><br><span> </s=
pan><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-overlapped_io_active(struct overlapped_io *o)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+overlapped_io_active(const struct ove=
rlapped_io *o)</span><br><span> {</span><br><span>     return o-&gt;iostate=
 =3D=3D IOSTATE_QUEUED || o-&gt;iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;</s=
pan><br><span> }</span><br><span>diff --git a/src/openvpnmsica/openvpnmsica=
=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>index a861e8a=2E=
=2E25fa1e4 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica=2Ec</=
span><br><span>+++ b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -=
77,7 +77,7 @@</span><br><span>  * @return ERROR_SUCCESS on success; An erro=
r code otherwise</span><br><span>  */</span><br><span> static UINT</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-setup_sequence(_In_ MSIHANDLE =
hInstall, _In_z_ LPCWSTR szProperty, _In_ struct msica_arg_seq *seq)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+setup_sequence(_In_ MSIHAN=
DLE hInstall, _In_z_ LPCWSTR szProperty, _In_ const struct msica_arg_seq *s=
eq)</span><br><span> {</span><br><span>     UINT uiResult;</span><br><span>=
     LPWSTR szSequence =3D msica_arg_seq_join(seq);</span><br><span>diff --=
git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</sp=
an><br><span>index d2288b9=2E=2Eee5d22a 100644</span><br><span>--- a/src/op=
envpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=
=2Ec</span><br><span>@@ -522,7 +522,7 @@</span><br><span> </span><br><span>=
 </span><br><span> static SOCKADDR_INET</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-sockaddr_inet(short family, inet_address_t *addr)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+sockaddr_inet(short family,=
 const inet_address_t *addr)</span><br><span> {</span><br><span>     SOCKAD=
DR_INET sa_inet;</span><br><span>     ZeroMemory(&amp;sa_inet, sizeof(sa_in=
et));</span><br><span>@@ -3849,7 +3849,7 @@</span><br><span> </span><br><sp=
an> static DWORD</span><br><span> UpdateWaitHandles(LPHANDLE *handles_ptr, =
LPDWORD count, HANDLE io_event, HANDLE exit_event,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                  list_item_t *threads)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                  const li=
st_item_t *threads)</span><br><span> {</span><br><span>     static DWORD si=
ze =3D 10;</span><br><span>     static LPHANDLE handles =3D NULL;</span><br=
><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/un=
it_tests/openvpn/mock_management=2Ec</span><br><span>index 77f6ce2=2E=2Efff=
4c2b 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_management=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Ec</sp=
an><br><span>@@ -36,7 +36,7 @@</span><br><span> struct management *manageme=
nt; /* GLOBAL */</span><br><span> </span><br><span> void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(struct managemen=
t *man, const char *type, const char *reason)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+management_auth_failure(const struct management *=
man, const char *type, const char *reason)</span><br><span> {</span><br><sp=
an>     ASSERT(false);</span><br><span> }</span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec=
</span><br><span>index a41c27b=2E=2Ea8daee6 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_misc=2Ec</span><br><span>@@ -146,7 +146,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> static struct hash_element *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-hash_lookup_by_value(struct ha=
sh *hash, void *value)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+hash_lookup_by_value(struct hash *hash, const void *value)</span><br><sp=
an> {</span><br><span>     struct hash_iterator hi;</span><br><span>     st=
ruct hash_element *he;</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><b=
r><span>index c0a0866=2E=2E7636a33 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_user_pass=2Ec</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_user_pass=2Ec</span><br><span>@@ -59,7 +59,7 @@</span><br><span> =
    return mock();</span><br><span> }</span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(struct manage=
ment *man, const char *type, const char *reason)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+management_auth_failure(const struct managemen=
t *man, const char *type, const char *reason)</span><br><span> {</span><br>=
<span>     assert_true(0);</span><br><span> }</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1663?usp=3Demail">change 1663</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1663?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1663 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> =
Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>

</body></html>
--oWJ5NTUdQIw=--


--===============7381106706834950924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7381106706834950924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7381106706834950924==--

