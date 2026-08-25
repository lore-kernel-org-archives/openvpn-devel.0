Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAED8C61DC2
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EWZtksVLh/dW/NnpsUZim0DTGtwQJX6LEF730wdNcu4=; b=gZ8pKsCVKfBVsTUF6hv2m95iPb
	RKPkMKXXK7i5GlL48/8onaLmrH+k3kYKQkUvI/WJe4BMQfRe6k5suuDK1w8gdZyBitF6hjDZbuKaB
	HN/lZtz4J6JmnLvEiFNIzKTGe8wm7tOu3d9PDtPtvWsjBD27+WdLeupfjV2DDj6yngTg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytLZ-0001pa-S4;
	Tue, 25 Aug 2026 15:45:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wytLW-0001pS-Hl
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:45:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ipxX3zmOX6d2rBQ/Q0E+fKZaNQR59KJr56LTVmg/QMs=; b=UPKkv8/v8uPMjUYEUO+Mt+xL6C
 vj4RSHTS9CR9hdeV2eYtcyU7UOtHEz16DBmw2xfOglC2fxl4aYmqRXJc15KrJrsFtZdNVv+nIDiGH
 KVbHNOHm+6eQcj3eMNlKdoIpYrfdcEULQI3+RkMRU84LD36kM43EBk7cvt+91q5ovEYw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ipxX3zmOX6d2rBQ/Q0E+fKZaNQR59KJr56LTVmg/QMs=; b=X
 0cizrTFIP0i+BV1yM9a8LigNGyhYSJPXVw7r/QRpXyW4OHLaCB7h5WK1lFsdevQVOpx6BFjMIgORw
 FTLW7ARZZsf+Yvk9I2A/wY1lhKpqGyMfxqQubsTrLu/SGrUjIVFH5M8WFvQiQa91snimS3Mc3csUx
 JHSa0yp8cb/SY8mM=;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytLN-0002Co-GN for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:45:51 +0000
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so781970266b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787672739; x=1788277539; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ipxX3zmOX6d2rBQ/Q0E+fKZaNQR59KJr56LTVmg/QMs=;
 b=eSgLWipRIfHeL3csz87JfiTtWh6hsXcIwcNq2hfGYfp9Gx1VUZQ6IED76BoRNzF2fm
 4rx+Z1p3QvCT53qJT5MnSr29nMv68JIkOMUNBj2Y9bi6k8ODs60zUbn5ePAjKpbi/VO3
 N8D4V3WrfMSprYAGNKtzfRQDT1ViBim6IWMula9fMGxcmATW8iVGeAN2e9hbunJ2Lp40
 nZtuyy4oHsBROxy+ylGW794V3L1lsD1fj04NyhkhF48noElRyo9trbGFDfhlh86jZQAS
 U6nbGLlNXODAYkqKoW3rv2ig3SVM9Cnex/cCwf7aIsIlaQed3doSYNPIYsqIXECKvIYe
 CTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787672739; x=1788277539;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ipxX3zmOX6d2rBQ/Q0E+fKZaNQR59KJr56LTVmg/QMs=;
 b=nazLHndTlGIxfb2ODuV0BZvtpLKAnMjNwan0T56xrY5vqd2urNxHLlRDlolOHXu2Bh
 7GxURNV0n0+Uubp/bz8FE8NT7kMtJPMgpi1JRUjaNO9VvLbNgk1DqdVuM+zb4iBpsHjs
 dpD7dc7qiIHfaJHjLT2HVah3MSQ6uMn7+m6cvvbhC/IV/TlCTlXYwwOtZX71DHlDt6aP
 CgBORGFDX+4rTeQCSafysOF5uD+QER/mPn3fcKWXDX23i9nLzIZ0eT6nZrZp5C3kid2Z
 Vs8pMQGY4B9iKYCR0DXRccYJp01fVWqeAIJDS8kZtuIsYYET1UEShRHiZTXVZyHRM9w5
 yc6w==
X-Gm-Message-State: AFuF++lYg6ly63E94wFiRNyNpS3hHN/0Nr9SAV5bHEktB/HNIBaBQhT2
 TTRlMqXfA0vFs1C7leO+aaxXCHnl2gsYGB1lwax9boadpBNREy8iSqC6f1MLY2TH9FGgI/DwskJ
 jYnV3wTpNexHiNp/kmUzWtF/wwcfvF03yoM/7NgE0oKh2PNFa4R+I9emb0wCP2s/Z0mFS
X-Gm-Gg: AR+sD12GD9lM9AEZ0VmyS8+osyJAam+0up3zKw48psGndnp/Rov5ZBv45MXVXJFpMKw
 7kc/Srzmz0lwBe0Q3HKh119S6SM9dJ3IGkXfm/WwYKjD7LL8dIewJDjMFOh4b4A1isfOy1KdOBU
 4q90G5Y/qttx6q8OHg85nK6dVvsXOiYRevuYw3CDVcVz7MQ8Hb8vFjaItHQzRW+QC5tGT5D6oEr
 EhZG6ChVHX1tBPTap44WtEfgS3wxlEi2br5Z2UV4LT5586IYtEpQ5jfKEDL6Nl/K2QriLjvFodD
 3v4qn1i6QUPxkUNCvjtyjdB871702qCLP8yJHjM/GIZk8R5mjWGy3BzBNAfWnx1okeiBHW80l3s
 R65RdWVmIgDjIrtjn3Kn3XbWmiWpz4E6a+Zf61voN6dsAWTlGzyb9sCHTGbzty+MfraA4vT8o/G
 esWJNKmhEXrfjs3MGfsEIvSRGFZEK/0DF3/dxDOGCsYguI8yxJ2I/VzWrnWhtcDKMVb7TZu1EL6
 QsNB7nwhxiv0vZYt0Yps909NqitILXcqQIZ+gAC92t9PdXg07Hn0mWPHGjO7ks05Y7F2A4NBznY
 xlxOcemWSFjl4VQvwaw9xQvrNULZYeH545bLliUFPXlPd6Xx+4s=
X-Received: by 2002:a17:907:c5ce:b0:c24:dfa2:14d2 with SMTP id
 a640c23a62f3a-c24dfa215e7mr760757766b.15.1787672736451; 
 Tue, 25 Aug 2026 08:45:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a73038asm11408466b.26.2026.08.25.08.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 08:45:35 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 15:45:20 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 0866f76a03f9284abd418b91ca1933a513d4cbc6
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c3e78f1d2d0e5275cdda8e0d45cbd183fa5ae429-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wytLN-0002Co-GN
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
Content-Type: multipart/mixed; boundary="===============6326516673908783246=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6326516673908783246==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9TGs8R1Fn5g="; charset=UTF-8

--9TGs8R1Fn5g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1663?usp=3Demail

to look at the new patch set (#17)=2E
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
M src/openvpn/multi_io=2Ec
M src/ope=
nvpn/networking=2Eh
M src/openvpn/networking_iproute2=2Ec
M src/openvpn/net=
working_sitnl=2Ec
M src/openvpn/occ=2Eh
M src/openvpn/openssl_compat=2Eh
M =
src/openvpn/options=2Ec
M src/openvpn/options_parse=2Ec
M src/openvpn/otime=
=2Ec
M src/openvpn/otime=2Eh
M src/openvpn/proto=2Eh
M src/openvpn/proxy=2E=
c
M src/openvpn/proxy=2Eh
M src/openvpn/ps=2Ec
M src/openvpn/ps=2Eh
M src/o=
penvpn/push=2Ec
M src/openvpn/push=2Eh
M src/openvpn/push_util=2Ec
M src/op=
envpn/reliable=2Ec
M src/openvpn/reliable=2Eh
M src/openvpn/route=2Ec
M src=
/openvpn/schedule=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M s=
rc/openvpn/socket_util=2Eh
M src/openvpn/socks=2Ec
M src/openvpn/socks=2Eh
=
M src/openvpn/ssl=2Ec
M src/openvpn/ssl=2Eh
M src/openvpn/ssl_backend=2Eh
M=
 src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ss=
l_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M src/openvpn/ssl_verify=2Ec
M src/open=
vpn/ssl_verify=2Eh
M src/openvpn/status=2Ec
M src/openvpn/status=2Eh
M src/=
openvpn/tun=2Ec
M src/openvpn/tun=2Eh
M src/openvpn/tun_afunix=2Ec
M src/op=
envpn/tun_afunix=2Eh
M src/openvpn/vlan=2Ec
M src/openvpn/vlan=2Eh
M src/op=
envpn/win32=2Eh
M src/openvpnmsica/openvpnmsica=2Ec
M src/openvpnserv/inter=
active=2Ec
M tests/unit_tests/openvpn/mock_management=2Ec
M tests/unit_test=
s/openvpn/test_misc=2Ec
M tests/unit_tests/openvpn/test_user_pass=2Ec
89 fi=
les changed, 355 insertions(+), 304 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1663/17

diff --git a/dev-to=
ols/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 2a3cf2e=2E=
=2E8736c2f 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppc=
heck-suppression
@@ -2,7 +2,6 @@
 # occurences right now=2E They still shou=
ld be fixed at some point
 constParameter
 constParameterCallback
-constPar=
ameterPointer
 invalidPrintfArgType_sint
 invalidPrintfArgType_uint
 unused=
Function
@@ -27,13 +26,48 @@
 # FP: posix=2Ecfg claims suseconds_t is unsig=
ned for some reason
 unsignedLessThanZero:src/openvpn/otime=2Eh:148
 # IGN:=
 multi code does weird things with pointers to local variables=2E=2E=2E
-au=
toVariables:src/openvpn/multi=2Ec:4232
+autoVariables:src/openvpn/multi=2Ec=
:4233
 autoVariables:src/openvpn/multi_io=2Ec:324
 # IGN: the code header =
=3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally
 badBitmaskCheck:s=
rc/openvpn/mudp=2Ec
 badBitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec
=
 # IGN: we store integers in pointers
 CastAddressToIntegerAtReturn:src/ope=
nvpn/multi=2Ec
+# IGN: external
+constParameterPointer:/usr/include/*
+# IG=
N: test files provide mocks/stubs that match prototypes from headers exactl=
y
+constParameterPointer:tests/unit_tests/openvpn/mock_*
+constParameterPoi=
nter:tests/unit_tests/openvpn/test_*
+constParameterPointer:tests/unit_test=
s/openvpnserv/test_*
+# FP: different crypto implementations but same API
+=
constParameterPointer:src/openvpn/crypto_mbedtls_legacy=2Ec:85
+constParame=
terPointer:src/openvpn/crypto_openssl=2Ec:173
+constParameterPointer:src/op=
envpn/crypto_openssl=2Ec:1433
+constParameterPointer:src/openvpn/cryptoapi=
=2Ec:58
+constParameterPointer:src/openvpn/ssl_mbedtls=2Ec
+constParameterP=
ointer:src/openvpn/ssl_openssl=2Ec
+constParameterPointer:src/openvpn/ssl_v=
erify_mbedtls=2Ec
+constParameterPointer:tests/unit_tests/openvpn/siphash_o=
penssl=2Ec
+# IGN: too many different implementations, not worth it
+constP=
arameterPointer:src/openvpn/dco*
+constParameterPointer:src/openvpn/socket=
=2E*
+# FP: parameters are modified on some platform only
+constParameterPo=
inter:src/openvpn/dns=2Ec:859
+constParameterPointer:src/openvpn/error=2Ec:=
223
+constParameterPointer:src/openvpn/forward=2Ec:1245
+constParameterPoin=
ter:src/openvpn/manage=2Ec:344
+constParameterPointer:src/openvpn/manage=2E=
c:3332
+constParameterPointer:src/openvpn/misc=2Ec:793
+constParameterPoint=
er:src/openvpn/misc=2Ec:813
+constParameterPointer:src/openvpn/options=2Ec:=
3205
+constParameterPointer:src/openvpn/route=2Ec:3947
+constParameterPoint=
er:src/openvpn/tun=2Ec:560
+constParameterPointer:src/openvpn/tun=2Ec:2188
=
+constParameterPointer:src/openvpn/tun_afunix=2Ec
+# IGN: not a FP but the =
documentation for the FP_ISSET claims this is not const=2E=2E=2E
+constPara=
meterPointer:src/openvpn/event=2Ec:1015
+# IGN: fun:check_malloc_return: ca=
uses -Wmaybe-uninitialized in MinGW Debug build
+constParameterPointer:src/=
openvpn/buffer=2Eh:2082
 # IGN: Windows specific (unsigned long =3D=3D unsi=
gned int)
 compareValueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928
 =
# FP: cppcheck seems to have wrong signature of DeviceIoControl()
diff --gi=
t a/sample/sample-plugins/client-connect/sample-client-connect=2Ec b/sample=
/sample-plugins/client-connect/sample-client-connect=2Ec
index 420de61=2E=
=2Ecbd98e8 100644
--- a/sample/sample-plugins/client-connect/sample-client-=
connect=2Ec
+++ b/sample/sample-plugins/client-connect/sample-client-connec=
t=2Ec
@@ -344,7 +344,7 @@
 }
 
 int
-openvpn_plugin_client_connect(struct p=
lugin_context *context, const char **argv, const char **envp)
+openvpn_plug=
in_client_connect(const struct plugin_context *context, const char **argv, =
const char **envp)
 {
     /* log environment variables handed to us by Ope=
nVPN, but
      * only if "setenv verb" is 3 or higher (arbitrary number)
@=
@ -465,7 +465,7 @@
 
 int
 openvpn_plugin_client_connect_defer_v2(struct pl=
ugin_context *context,
-                                       struct plugi=
n_per_client_context *pcc,
+                                       const st=
ruct plugin_per_client_context *pcc,
                                      =
  struct openvpn_plugin_string_list **return_list)
 {
     time_t time_left=
 =3D pcc->sleep_until - time(NULL);
diff --git a/sample/sample-plugins/defe=
r/multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec
index bacf557=
=2E=2Ecdd616f 100644
--- a/sample/sample-plugins/defer/multi-auth=2Ec
+++ b=
/sample/sample-plugins/defer/multi-auth=2Ec
@@ -255,7 +255,7 @@
 }
 
 stati=
c bool
-do_auth_user_pass(struct plugin_context *context, const char *usern=
ame, const char *password)
+do_auth_user_pass(const struct plugin_context *=
context, const char *username, const char *password)
 {
     plog(context, =
PLOG_NOTE, "expect_user=3D%s, received_user=3D%s, expect_passw=3D%s, receiv=
ed_passw=3D%s",
          np(context->test_valid_user), np(username), np(co=
ntext->test_valid_pass), np(password));
@@ -279,7 +279,7 @@
 
 
 static int=

-auth_user_pass_verify(struct plugin_context *context, struct plugin_per_c=
lient_context *pcc,
+auth_user_pass_verify(const struct plugin_context *con=
text, struct plugin_per_client_context *pcc,
                       const c=
har *argv[], const char *envp[])
 {
     /* get username/password from envp=
 string array */
diff --git a/sample/sample-plugins/keying-material-exporte=
r-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/keying-material-e=
xporter-demo/keyingmaterialexporter=2Ec
index 25c9ff5=2E=2E512861a 100644
-=
-- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexpo=
rter=2Ec
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingma=
terialexporter=2Ec
@@ -186,7 +186,7 @@
 }
 
 static void
-file_store(char *=
file, char *content)
+file_store(const char *file, const char *content)
 {
=
     FILE *f;
     if (!(f =3D fopen(file, "w+")))
@@ -202,7 +202,7 @@
 ser=
ver_store(struct openvpn_plugin_args_func_in const *args)
 {
     struct pl=
ugin *plugin =3D (struct plugin *)args->handle;
-    struct session *sess =
=3D (struct session *)args->per_client_context;
+    const struct session *=
sess =3D (struct session *)args->per_client_context;
 
     char file[MAXPA=
TH];
     snprintf(file, sizeof(file) - 1, "/tmp/openvpn_sso_%s", sess->key=
);
@@ -214,7 +214,7 @@
 client_store(struct openvpn_plugin_args_func_in con=
st *args)
 {
     struct plugin *plugin =3D (struct plugin *)args->handle;
=
-    struct session *sess =3D (struct session *)args->per_client_context;
+=
    const struct session *sess =3D (struct session *)args->per_client_conte=
xt;
 
     char *file =3D "/tmp/openvpn_sso_user";
     ovpn_note("app sess=
ion file: %s", file);
diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buf=
fer=2Ec
index 046e231=2E=2Ea004b60 100644
--- a/src/openvpn/buffer=2Ec
+++ =
b/src/openvpn/buffer=2Ec
@@ -270,7 +270,7 @@
  * truncated by buf_printf
  =
*/
 void
-buf_catrunc(struct buffer *buf, const char *str)
+buf_catrunc(con=
st struct buffer *buf, const char *str)
 {
     if (buf_forward_capacity(bu=
f) <=3D 1)
     {
@@ -1035,7 +1035,7 @@
 }
 
 bool
-string_check_buf(struct=
 buffer *buf, const unsigned int inclusive, const unsigned int exclusive)
+=
string_check_buf(const struct buffer *buf, const unsigned int inclusive, co=
nst unsigned int exclusive)
 {
     ASSERT(buf);
 
diff --git a/src/openvpn=
/buffer=2Eh b/src/openvpn/buffer=2Eh
index bc5cffb=2E=2E5cf834f 100644
--- =
a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -853,7 +853,7 @@
 =
 * @param buf   The buffer to append the truncation marker to=2E
  * @param=
 str   The null-terminated marker string to write=2E
  */
-void buf_catrunc=
(struct buffer *buf, const char *str);
+void buf_catrunc(const struct buffe=
r *buf, const char *str);
 
 /**
  * Extract the next token from a buffer, =
delimited by a given character=2E
@@ -1427,7 +1427,7 @@
  *         is empt=
y=2E
  */
 static inline int
-buf_peek_u8(struct buffer *buf)
+buf_peek_u8(=
const struct buffer *buf)
 {
     int ret;
     if (BLEN(buf) < 1)
@@ -1720=
,7 +1720,7 @@
  * @param exclusive Character classes that are not allowed e=
ven if they are also in inclusive=2E
  * @return True if the string consist=
s only of allowed characters, false otherwise=2E
  */
-bool string_check_bu=
f(struct buffer *buf, const unsigned int inclusive,
+bool string_check_buf(=
const struct buffer *buf, const unsigned int inclusive,
                   =
    const unsigned int exclusive);
 
 /**
@@ -1856,7 +1856,7 @@
  * @param =
a  The arena to test=2E
  */
 static inline bool
-gc_defined(struct gc_aren=
a *a)
+gc_defined(const struct gc_arena *a)
 {
     return a->list !=3D NUL=
L;
 }
diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec
index 37=
24022=2E=2Ed03f9f2 100644
--- a/src/openvpn/clinat=2Ec
+++ b/src/openvpn/cl=
inat=2Ec
@@ -159,7 +159,7 @@
 #endif
 
 static void
-print_pkt(struct openv=
pn_iphdr *iph, const char *prefix, const int direction, const msglvl_t msgl=
evel)
+print_pkt(const struct openvpn_iphdr *iph, const char *prefix, const=
 int direction, const msglvl_t msglevel)
 {
     struct gc_arena gc =3D gc_=
new();
 
@@ -181,7 +181,7 @@
 }
 
 void
-client_nat_transform(const struct =
client_nat_option_list *list, struct buffer *ipbuf,
+client_nat_transform(c=
onst struct client_nat_option_list *list, const struct buffer *ipbuf,
     =
                 const int direction)
 {
     struct ip_tcp_udp_hdr *h =3D =
(struct ip_tcp_udp_hdr *)BPTR(ipbuf);
diff --git a/src/openvpn/clinat=2Eh b=
/src/openvpn/clinat=2Eh
index 1e8ceb3=2E=2Ebc56037 100644
--- a/src/openvpn=
/clinat=2Eh
+++ b/src/openvpn/clinat=2Eh
@@ -60,7 +60,7 @@
                =
                    const char *network, const char *netmask,
             =
                       const char *foreign_network, msglvl_t msglevel);
 
-=
void client_nat_transform(const struct client_nat_option_list *list, struct=
 buffer *ipbuf,
+void client_nat_transform(const struct client_nat_option_l=
ist *list, const struct buffer *ipbuf,
                           const int=
 direction);
 
 #endif /* if !defined(CLINAT_H) */
diff --git a/src/openvpn=
/comp=2Ec b/src/openvpn/comp=2Ec
index b88b79f=2E=2E387a7c4 100644
--- a/sr=
c/openvpn/comp=2Ec
+++ b/src/openvpn/comp=2Ec
@@ -159,7 +159,7 @@
 #endif /=
* USE_COMP */
 
 bool
-check_compression_settings_valid(struct compress_opt=
ions *info, msglvl_t msglevel)
+check_compression_settings_valid(const stru=
ct compress_options *info, msglvl_t msglevel)
 {
     /*
      * We also al=
low comp-stub-v2 here as it technically allows escaping of
diff --git a/src=
/openvpn/comp=2Eh b/src/openvpn/comp=2Eh
index 29a90a2=2E=2Ead80243 100644
=
--- a/src/openvpn/comp=2Eh
+++ b/src/openvpn/comp=2Eh
@@ -91,7 +91,7 @@
  *=
 flags of allow-compression and also the whether algorithms are compiled
  =
* in
  */
-bool check_compression_settings_valid(struct compress_options *i=
nfo, msglvl_t msglevel);
+bool check_compression_settings_valid(const struc=
t compress_options *info, msglvl_t msglevel);
 
 #ifdef USE_COMP
 #include =
"buffer=2Eh"
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
i=
ndex e5ad31a=2E=2Ee29d581 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/ope=
nvpn/crypto=2Ec
@@ -1105,7 +1105,7 @@
 }
 
 static bool
-key_is_zero(struct=
 key *key, const struct key_type *kt)
+key_is_zero(const struct key *key, c=
onst struct key_type *kt)
 {
     size_t cipher_length =3D cipher_kt_key_si=
ze(kt->cipher);
     for (size_t i =3D 0; i < cipher_length; ++i)
@@ -1123,=
7 +1123,7 @@
  * Make sure that cipher key is a valid key for current key_t=
ype=2E
  */
 bool
-check_key(struct key *key, const struct key_type *kt)
+c=
heck_key(const struct key *key, const struct key_type *kt)
 {
     if (ciph=
er_defined(kt->cipher))
     {
@@ -1196,7 +1196,7 @@
 }
 
 void
-test_crypt=
o(struct crypto_options *co, struct frame *frame)
+test_crypto(struct crypt=
o_options *co, const struct frame *frame)
 {
     int i, j;
     struct gc_=
arena gc =3D gc_new();
diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/cr=
ypto=2Eh
index ee5b50f=2E=2Ee3c1c6a 100644
--- a/src/openvpn/crypto=2Eh
+++=
 b/src/openvpn/crypto=2Eh
@@ -414,7 +414,7 @@
  */
 int write_key_file(cons=
t int nkeys, const char *filename);
 
-bool check_key(struct key *key, cons=
t struct key_type *kt);
+bool check_key(const struct key *key, const struct=
 key_type *kt);
 
 /**
  * Initialize a key_type structure with=2E
@@ -614,=
7 +614,7 @@
 /** Print a cipher list entry */
 void print_cipher(const char=
 *cipher);
 
-void test_crypto(struct crypto_options *co, struct frame *f);=

+void test_crypto(struct crypto_options *co, const struct frame *f);
 
 
 =
/* key direction functions */
diff --git a/src/openvpn/dco=2Ec b/src/openvp=
n/dco=2Ec
index 8eae4bf=2E=2E3bf1fb2 100644
--- a/src/openvpn/dco=2Ec
+++ b=
/src/openvpn/dco=2Ec
@@ -573,7 +573,7 @@
 }
 
 static bool
-dco_multi_get_l=
ocaladdr(struct multi_context *m, struct multi_instance *mi,
+dco_multi_get=
_localaddr(const struct multi_context *m, const struct multi_instance *mi,
=
                         struct sockaddr_storage *local)
 {
 #if ENABLE_IP_=
PKTINFO
@@ -585,7 +585,7 @@
         return false;
     }
 
-    struct lin=
k_socket_actual *actual =3D &c->c2=2Elink_socket_infos[0]->lsa->actual;
+  =
  const struct link_socket_actual *actual =3D &c->c2=2Elink_socket_infos[0]=
->lsa->actual;
 
     switch (actual->dest=2Eaddr=2Esa=2Esa_family)
     {
=
@@ -623,7 +623,7 @@
 }
 
 int
-dco_multi_add_new_peer(struct multi_context =
*m, struct multi_instance *mi)
+dco_multi_add_new_peer(const struct multi_c=
ontext *m, struct multi_instance *mi)
 {
     const struct context *c =3D &=
mi->context;
 
@@ -677,7 +677,7 @@
 }
 
 void
-dco_install_iroute(struct mu=
lti_context *m, struct multi_instance *mi, struct mroute_addr *addr)
+dco_i=
nstall_iroute(struct multi_context *m, struct multi_instance *mi, const str=
uct mroute_addr *addr)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREE=
BSD) || defined(_WIN32)
     if (!dco_enabled(&m->top=2Eoptions))
@@ -796,7=
 +796,7 @@
         /* Checked if we added a host route as the assigned cli=
ent IP address was
          * outside the --ifconfig-ipv6 tun interface co=
nfig */
 #if !defined(_WIN32)
-        struct in6_addr *dest =3D &mi->conte=
xt=2Ec2=2Epush_ifconfig_ipv6_local;
+        const struct in6_addr *dest =
=3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
         if (multi_check_=
push_ifconfig_ipv6_extra_route(mi, dest))
         {
             /* On win=
dows we do not install these routes, so we also do not need to delete them =
*/
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index 4e5aad5=2E=
=2E694875c 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -2=
04,7 +204,7 @@
  * @param mi        the client instance
  * @return        =
  0 on success or a negative error code otherwise
  */
-int dco_multi_add_n=
ew_peer(struct multi_context *m, struct multi_instance *mi);
+int dco_multi=
_add_new_peer(const struct multi_context *m, struct multi_instance *mi);
 
=
 /**
  * Install an iroute in DCO, which means adding a route to the system=
 routing
@@ -215,7 +215,7 @@
  * @param addr      the route to add
  */
 vo=
id dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
-=
                        struct mroute_addr *addr);
+                       =
 const struct mroute_addr *addr);
 
 /**
  * Remove all routes added throug=
h the specified client
@@ -253,7 +253,7 @@
  * a 64 bit packet counter and =
AEAD tag at the end=2E
  */
 bool
-dco_supports_epoch_data(struct context *=
c);
+dco_supports_epoch_data(const struct context *c);
 #else  /* if define=
d(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ -350,7 +350,7 @@
 }
 
 =
static inline int
-dco_multi_add_new_peer(struct multi_context *m, struct m=
ulti_instance *mi)
+dco_multi_add_new_peer(const struct multi_context *m, s=
truct multi_instance *mi)
 {
     return 0;
 }
@@ -384,7 +384,7 @@
 }
 
 st=
atic inline bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_=
epoch_data(const struct context *c)
 {
     return false;
 }
diff --git a/s=
rc/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index d933aaf=2E=
=2E7346903 100644
--- a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_f=
reebsd=2Ec
@@ -930,7 +930,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct c=
ontext *c)
+dco_supports_epoch_data(const struct context *c)
 {
     return=
 false;
 }
diff --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_inte=
rnal=2Eh
index fcf8aca=2E=2E1022e66 100644
--- a/src/openvpn/dco_internal=
=2Eh
+++ b/src/openvpn/dco_internal=2Eh
@@ -59,8 +59,9 @@
  * They are impl=
emented by dco_linux=2Ec
  */
 
-int dco_new_peer(dco_context_t *dco, unsig=
ned int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,
-      =
           struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4, con=
st struct in6_addr *vpn_ipv6);
+int dco_new_peer(dco_context_t *dco, unsign=
ed int peerid, socket_descriptor_t sd,
+                 struct sockaddr *l=
ocaladdr, struct sockaddr *remoteaddr,
+                 const struct in_ad=
dr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
 
 int dco_del_peer(dco_con=
text_t *dco, unsigned int peerid);
 
diff --git a/src/openvpn/dco_linux=2Ec=
 b/src/openvpn/dco_linux=2Ec
index 56f6259=2E=2E31bbe87 100644
--- a/src/op=
envpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -114,7 +114,7 @@
 }
=
 
 static struct nl_msg *
-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_=
t cmd)
+ovpn_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)
 {
   =
  struct nl_msg *nl_msg =3D nlmsg_alloc();
     if (!nl_msg)
@@ -804,7 +804=
,7 @@
 
 /* libnl < 3=2E11=2E0 does not implement nla_get_uint() */
 static=
 uint64_t
-ovpn_nla_get_uint(struct nlattr *attr)
+ovpn_nla_get_uint(const =
struct nlattr *attr)
 {
     if (nla_len(attr) =3D=3D sizeof(uint32_t))
   =
  {
@@ -916,7 +916,7 @@
 }
 
 static bool
-ovpn_iface_check(dco_context_t *=
dco, struct nlattr *attrs[])
+ovpn_iface_check(const dco_context_t *dco, st=
ruct nlattr *attrs[])
 {
     /* we must know which interface this message =
is referring to in order to
      * avoid mixing messages for other instanc=
es
@@ -1340,7 +1340,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context=
 *c)
+dco_supports_epoch_data(const struct context *c)
 {
     return false=
;
 }
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index b=
3268bc=2E=2E8deb9d8 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/=
dco_win=2Ec
@@ -1100,7 +1100,7 @@
 }
 
 bool
-dco_supports_epoch_data(struc=
t context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     OVP=
N_VERSION ver =3D { 0 };
     return dco_get_version(&ver) && ((ver=2EMajor=
 =3D=3D 2 && ver=2EMinor >=3D 8) || (ver=2EMajor > 2));
diff --git a/src/op=
envpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec
index a54ab3f=2E=2E68173e6 100644
---=
 a/src/openvpn/dhcp=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -145,7 +145,7 @@
 }
 =

 in_addr_t
-dhcp_extract_router_msg(struct buffer *ipbuf)
+dhcp_extract_ro=
uter_msg(const struct buffer *ipbuf)
 {
     struct dhcp_full *df =3D (stru=
ct dhcp_full *)BPTR(ipbuf);
     const int optlen =3D
diff --git a/src/open=
vpn/dhcp=2Eh b/src/openvpn/dhcp=2Eh
index 38ebf8d=2E=2Eed8a0c9 100644
--- a=
/src/openvpn/dhcp=2Eh
+++ b/src/openvpn/dhcp=2Eh
@@ -91,7 +91,7 @@
 
 #prag=
ma pack()
 
-in_addr_t dhcp_extract_router_msg(struct buffer *ipbuf);
+in_a=
ddr_t dhcp_extract_router_msg(const struct buffer *ipbuf);
 
 #if defined(_=
WIN32) || defined(DHCP_UNIT_TEST)
 #include "tun=2Eh"
diff --git a/src/open=
vpn/event=2Eh b/src/openvpn/event=2Eh
index b784dfe=2E=2E0940a1d 100644
---=
 a/src/openvpn/event=2Eh
+++ b/src/openvpn/event=2Eh
@@ -204,7 +204,7 @@
 #=
else /* ifdef _WIN32 */
 
 static inline void
-wait_signal(struct event_set=
 *es, void *arg)
+wait_signal(const struct event_set *es, const void *arg)
=
 {
 }
 
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
inde=
x 6581998=2E=2E4ddac11 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openv=
pn/forward=2Ec
@@ -231,7 +231,7 @@
 }
 
 static void
-parse_incoming_contro=
l_channel_command(struct context *c, struct buffer *buf)
+parse_incoming_co=
ntrol_channel_command(struct context *c, const struct buffer *buf)
 {
     =
if (buf_string_match_head_str(buf, "AUTH_FAILED"))
     {
@@ -501,7 +501,7 =
@@
 }
 
 int
-get_server_poll_remaining_time(struct event_timeout *server_p=
oll_timeout)
+get_server_poll_remaining_time(const struct event_timeout *se=
rver_poll_timeout)
 {
     update_time();
     int remaining =3D event_time=
out_remaining(server_poll_timeout);
@@ -598,7 +598,7 @@
  * Buffer realloca=
tion, for use with null encryption=2E
  */
 static inline void
-buffer_turn=
over(const uint8_t *orig_buf, struct buffer *dest_stub, struct buffer *src_=
stub,
+buffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, c=
onst struct buffer *src_stub,
                 struct buffer *storage)
 {
 =
    if (orig_buf =3D=3D src_stub->data && src_stub->data !=3D storage->data=
)
@@ -885,7 +885,7 @@
  */
 
 static inline void
-socks_postprocess_incomin=
g_link(struct context *c, struct link_socket *sock)
+socks_postprocess_inco=
ming_link(struct context *c, const struct link_socket *sock)
 {
     if (so=
ck->socks_proxy && sock->info=2Eproto =3D=3D PROTO_UDP)
     {
@@ -982,7 +9=
82,7 @@
 }
 
 bool
-process_incoming_link_part1(struct context *c, struct l=
ink_socket_info *lsi, bool floated)
+process_incoming_link_part1(struct con=
text *c, const struct link_socket_info *lsi, bool floated)
 {
     struct g=
c_arena gc =3D gc_new();
     bool decrypt_status =3D false;
@@ -1532,7 +15=
32,7 @@
  * @param client    Determines whether to the send packet back via=
 tun or link
  */
 void
-ipv6_send_icmp_unreachable(struct context *c, stru=
ct buffer *buf, bool client)
+ipv6_send_icmp_unreachable(struct context *c,=
 const struct buffer *buf, bool client)
 {
 #define MAX_ICMPV6LEN 1280
    =
 struct openvpn_icmp6hdr icmp6out;
diff --git a/src/openvpn/forward=2Eh b/s=
rc/openvpn/forward=2Eh
index 324c0b4=2E=2Eee7d2e2 100644
--- a/src/openvpn/=
forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -127,7 +127,7 @@
  */
 void en=
crypt_sign(struct context *c, bool comp_frag);
 
-int get_server_poll_remai=
ning_time(struct event_timeout *server_poll_timeout);
+int get_server_poll_=
remaining_time(const struct event_timeout *server_poll_timeout);
 
 /******=
****************************************************************/
 /**
@@ -=
178,7 +178,7 @@
  *
  * @return true if packet is authenticated, false othe=
rwise=2E
  */
-bool process_incoming_link_part1(struct context *c, struct l=
ink_socket_info *lsi, bool floated);
+bool process_incoming_link_part1(stru=
ct context *c, const struct link_socket_info *lsi, bool floated);
 
 /**
  =
* Continues processing a packet read from the external network interface=2E=

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index a8e041d=2E=
=2E58473c5 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ =
-809,7 +809,7 @@
 }
 
 static void
-init_port_share(struct context *c)
+ini=
t_port_share(const struct context *c)
 {
     if (!port_share && (c->option=
s=2Eport_share_host && c->options=2Eport_share_port))
     {
@@ -1251,7 +12=
51,7 @@
  * prepending to msg() output=2E
  */
 const char *
-format_common=
_name(struct context *c, struct gc_arena *gc)
+format_common_name(const str=
uct context *c, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_bu=
f_gc(256, gc);
     if (c->c2=2Etls_multi)
@@ -1737,7 +1737,7 @@
 
 
 stati=
c bool
-can_preserve_tun(struct tuntap *tt)
+can_preserve_tun(const struct =
tuntap *tt)
 {
     if (tt && tt->backend_driver =3D=3D DRIVER_AFUNIX)
    =
 {
@@ -1759,7 +1759,7 @@
  * @param c pointer to the connection context
  *=
/
 static void
-add_wfp_block(struct context *c)
+add_wfp_block(const struc=
t context *c)
 {
 #if defined(_WIN32)
     /* Fortify 'redirect-gateway blo=
ck-local' with firewall rules? */
@@ -1785,7 +1785,7 @@
  * @param adapter_=
index the VPN adapter index
  */
 static void
-del_wfp_block(struct context=
 *c, unsigned long adapter_index)
+del_wfp_block(const struct context *c, u=
nsigned long adapter_index)
 {
 #if defined(_WIN32)
     if (c->options=2Eb=
lock_outside_dns || block_local_needed(c->c1=2Eroute_list))
diff --git a/sr=
c/openvpn/init=2Eh b/src/openvpn/init=2Eh
index ce8f74e=2E=2Ec486158 100644=

--- a/src/openvpn/init=2Eh
+++ b/src/openvpn/init=2Eh
@@ -91,7 +91,7 @@
 
=
 uint64_t pull_permission_mask(const struct context *c);
 
-const char *for=
mat_common_name(struct context *c, struct gc_arena *gc);
+const char *forma=
t_common_name(const struct context *c, struct gc_arena *gc);
 
 void reset_=
coarse_timers(struct context *c);
 
diff --git a/src/openvpn/interval=2Eh b=
/src/openvpn/interval=2Eh
index 59051bd=2E=2E0cfe202 100644
--- a/src/openv=
pn/interval=2Eh
+++ b/src/openvpn/interval=2Eh
@@ -89,7 +89,7 @@
 }
 
 stat=
ic inline void
-interval_schedule_wakeup(struct interval *top, interval_t *=
wakeup)
+interval_schedule_wakeup(const struct interval *top, interval_t *w=
akeup)
 {
     const time_t local_now =3D now;
     interval_earliest_wakeu=
p(wakeup, top->last_test_true + top->refresh, local_now);
@@ -214,7 +214,7 =
@@
  * This function does not check if the timeout is actually valid=2E
  *=
/
 static inline interval_t
-event_timeout_remaining(struct event_timeout *=
et)
+event_timeout_remaining(const struct event_timeout *et)
 {
     return=
 (interval_t)((et->last + et->n) - now);
 }
diff --git a/src/openvpn/list=
=2Ec b/src/openvpn/list=2Ec
index e51dcd0=2E=2Edcd59d7 100644
--- a/src/ope=
nvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -164,7 +164,7 @@
 }
 
 void
-ha=
sh_remove_by_value(struct hash *hash, void *value)
+hash_remove_by_value(st=
ruct hash *hash, const void *value)
 {
     struct hash_iterator hi;
     c=
onst struct hash_element *he;
diff --git a/src/openvpn/list=2Eh b/src/openv=
pn/list=2Eh
index 55bc3c8=2E=2E23267d0 100644
--- a/src/openvpn/list=2Eh
++=
+ b/src/openvpn/list=2Eh
@@ -78,7 +78,7 @@
 
 bool hash_remove_fast(struct =
hash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv);
 
-v=
oid hash_remove_by_value(struct hash *hash, void *value);
+void hash_remove=
_by_value(struct hash *hash, const void *value);
 
 struct hash_iterator
 {=

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 604bbcd=
=2E=2E17abfd8 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=
=2Ec
@@ -330,7 +330,7 @@
 }
 
 static void
-man_delete_unix_socket(struct m=
anagement *man)
+man_delete_unix_socket(const struct management *man)
 {
 #=
if UNIX_SOCK_SUPPORT
     if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_C=
ONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
@@ -675,7 +675,7 @@
  * for the log=
 and echo commands=2E
  */
 static void
-man_history(struct management *man=
, const char *parm, const char *type, struct log_history *log,
+man_history=
(struct management *man, const char *parm, const char *type, const struct l=
og_history *log,
             bool *realtime, const unsigned int lep_flags)=

 {
     struct gc_arena gc =3D gc_new();
@@ -843,7 +843,7 @@
 }
 
 static =
void
-man_forget_passwords(struct management *man)
+man_forget_passwords(co=
nst struct management *man)
 {
     ssl_purge_auth(false);
     (void)ssl_c=
lean_auth_token();
@@ -851,7 +851,7 @@
 }
 
 static void
-man_net(struct ma=
nagement *man)
+man_net(const struct management *man)
 {
     if (man->pers=
ist=2Ecallback=2Eshow_net)
     {
@@ -887,7 +887,7 @@
 #ifdef ENABLE_PKCS11=

 
 static void
-man_pkcs11_id_count(struct management *man)
+man_pkcs11_id=
_count(const struct management *man)
 {
     msg(M_CLIENT, ">PKCS11ID-COUNT=
:%d", pkcs11_management_id_count());
 }
@@ -1350,7 +1350,7 @@
  * @return  =
        Return whether p has n (or at least n) parameters
  */
 static bool=

-man_need(struct management *man, const char **p, const int n, unsigned in=
t flags)
+man_need(const struct management *man, const char **p, const int =
n, unsigned int flags)
 {
     int i;
     ASSERT(p[0]);
@@ -2365,7 +2365,7=
 @@
  * the route/ifconfig/open tun command=2E   See doc/android=2Etxt for =
details=2E
  */
 bool
-management_android_control(struct management *man, c=
onst char *command, const char *msg)
+management_android_control(const stru=
ct management *man, const char *command, const char *msg)
 {
     if (!man)=

     {
@@ -3013,7 +3013,7 @@
 }
 
 void
-management_up_down(struct managem=
ent *man, const char *updown, const struct env_set *es)
+management_up_down=
(const struct management *man, const char *updown, const struct env_set *es=
)
 {
     if (man->settings=2Eflags & MF_UP_DOWN)
     {
@@ -3023,13 +3023,=
13 @@
 }
 
 void
-management_notify(struct management *man, const char *sev=
erity, const char *type, const char *text)
+management_notify(const struct =
management *man, const char *severity, const char *type, const char *text)
=
 {
     msg(M_CLIENT, ">NOTIFY:%s,%s,%s", severity, type, text);
 }
 
 void=

-management_notify_generic(struct management *man, const char *str)
+manag=
ement_notify_generic(const struct management *man, const char *str)
 {
    =
 msg(M_CLIENT, "%s", str);
 }
@@ -3115,7 +3115,8 @@
 }
 
 void
-management_=
notify_client_close(struct management *management, struct man_def_auth_cont=
ext *mdac,
+management_notify_client_close(const struct management *managem=
ent,
+                               struct man_def_auth_context *mdac,
   =
                             const struct env_set *es)
 {
     if ((mdac->f=
lags & DAF_INITIAL_AUTH) && !(mdac->flags & DAF_CONNECTION_CLOSED))
@@ -320=
6,7 +3207,7 @@
 }
 
 void
-management_auth_failure(struct management *man, =
const char *type, const char *reason)
+management_auth_failure(const struct=
 management *man, const char *type, const char *reason)
 {
     if (reason)=

     {
@@ -3219,7 +3220,7 @@
 }
 
 void
-management_auth_token(struct mana=
gement *man, const char *token)
+management_auth_token(const struct managem=
ent *man, const char *token)
 {
     msg(M_CLIENT, ">PASSWORD:Auth-Token:%s=
", token);
 }
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
=
index 27d3b60=2E=2E0d011df 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/op=
envpn/manage=2Eh
@@ -368,7 +368,7 @@
                                 const=
 unsigned int flags, const char *static_challenge);
 
 #ifdef TARGET_ANDROI=
D
-bool management_android_control(struct management *man, const char *comm=
and, const char *msg);
+bool management_android_control(const struct manage=
ment *man, const char *command, const char *msg);
 
 #define ANDROID_KEEP_O=
LD_TUN      1
 #define ANDROID_OPEN_BEFORE_CLOSE 2
@@ -382,12 +382,12 @@
 
=
 void management_event_loop_n_seconds(struct management *man, int sec);
 
-=
void management_up_down(struct management *man, const char *updown, const s=
truct env_set *es);
+void management_up_down(const struct management *man, =
const char *updown, const struct env_set *es);
 
-void management_notify(st=
ruct management *man, const char *severity, const char *type,
+void managem=
ent_notify(const struct management *man, const char *severity, const char *=
type,
                        const char *text);
 
-void management_notify_=
generic(struct management *man, const char *str);
+void management_notify_g=
eneric(const struct management *man, const char *str);
 
 void management_n=
otify_client_needing_auth(struct management *management,
                  =
                          const unsigned int auth_id,
@@ -397,7 +397,7 @@
 =
void management_connection_established(struct management *management,
     =
                                   struct man_def_auth_context *mdac, const=
 struct env_set *es);
 
-void management_notify_client_close(struct managem=
ent *management,
+void management_notify_client_close(const struct manageme=
nt *management,
                                     struct man_def_auth_co=
ntext *mdac, const struct env_set *es);
 
 void management_learn_addr(struc=
t management *management, struct man_def_auth_context *mdac,
@@ -482,12 +48=
2,12 @@
  * OpenVPN calls here to indicate a password failure
  */
 
-void =
management_auth_failure(struct management *man, const char *type, const cha=
r *reason);
+void management_auth_failure(const struct management *man, con=
st char *type, const char *reason);
 
 /*
  * Echo an authentication token =
to management interface
  */
-void management_auth_token(struct management =
*man, const char *token);
+void management_auth_token(const struct manageme=
nt *man, const char *token);
 
 /*
  * These functions drive the bytecount =
in/out counters=2E
diff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec=

index 7b790ed=2E=2E9a37e30 100644
--- a/src/openvpn/mbuf=2Ec
+++ b/src/ope=
nvpn/mbuf=2Ec
@@ -149,7 +149,7 @@
 }
 
 void
-mbuf_dereference_instance(str=
uct mbuf_set *ms, struct multi_instance *mi)
+mbuf_dereference_instance(str=
uct mbuf_set *ms, const struct multi_instance *mi)
 {
     if (ms)
     {
d=
iff --git a/src/openvpn/mbuf=2Eh b/src/openvpn/mbuf=2Eh
index cfe698c=2E=2E=
e368054 100644
--- a/src/openvpn/mbuf=2Eh
+++ b/src/openvpn/mbuf=2Eh
@@ -75=
,7 +75,7 @@
 
 bool mbuf_extract_item(struct mbuf_set *ms, struct mbuf_item=
 *item);
 
-void mbuf_dereference_instance(struct mbuf_set *ms, struct mult=
i_instance *mi);
+void mbuf_dereference_instance(struct mbuf_set *ms, const=
 struct multi_instance *mi);
 
 static inline bool
 mbuf_defined(const stru=
ct mbuf_set *ms)
diff --git a/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec
ind=
ex 36bbb43=2E=2Ea7242a8 100644
--- a/src/openvpn/mss=2Ec
+++ b/src/openvpn/=
mss=2Ec
@@ -43,7 +43,7 @@
  *              if yes, hand to mss_fixup_dowork=
()
  */
 void
-mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss)
+mss_fix=
up_ipv4(const struct buffer *buf, uint16_t maxmss)
 {
     const struct ope=
nvpn_iphdr *pip;
     int hlen;
@@ -80,7 +80,7 @@
  *              (IPv6 he=
ader structure is sufficiently different from IPv4=2E=2E=2E)
  */
 void
-ms=
s_fixup_ipv6(struct buffer *buf, uint16_t maxmss)
+mss_fixup_ipv6(const str=
uct buffer *buf, uint16_t maxmss)
 {
     const struct openvpn_ipv6hdr *pip=
6;
     struct buffer newbuf;
@@ -136,7 +136,7 @@
  */
 
 void
-mss_fixup_d=
owork(struct buffer *buf, uint16_t maxmss)
+mss_fixup_dowork(const struct b=
uffer *buf, uint16_t maxmss)
 {
     int olen, optlen;
     uint8_t *opt;
@=
@ -239,8 +239,8 @@
 }
 
 static void
-frame_calculate_fragment(struct frame=
 *frame, struct key_type *kt, const struct options *options,
-             =
            struct link_socket_info *lsi)
+frame_calculate_fragment(struct =
frame *frame, const struct key_type *kt, const struct options *options,
+  =
                       const struct link_socket_info *lsi)
 {
 #if defined(=
ENABLE_FRAGMENT)
     size_t overhead;
@@ -269,8 +269,8 @@
 }
 
 static voi=
d
-frame_calculate_mssfix(struct frame *frame, struct key_type *kt, const s=
truct options *options,
-                       struct link_socket_info *ls=
i)
+frame_calculate_mssfix(struct frame *frame, const struct key_type *kt, =
const struct options *options,
+                       const struct link_so=
cket_info *lsi)
 {
     if (options->ce=2Emssfix_fixed)
     {
@@ -314,8 +3=
14,8 @@
 }
 
 void
-frame_calculate_dynamic(struct frame *frame, struct key=
_type *kt, const struct options *options,
-                        struct l=
ink_socket_info *lsi)
+frame_calculate_dynamic(struct frame *frame, const s=
truct key_type *kt, const struct options *options,
+                       =
 const struct link_socket_info *lsi)
 {
     if (options->ce=2Efragment > 0=
)
     {
diff --git a/src/openvpn/mss=2Eh b/src/openvpn/mss=2Eh
index 1d092=
bb=2E=2E6b832a2 100644
--- a/src/openvpn/mss=2Eh
+++ b/src/openvpn/mss=2Eh
=
@@ -29,15 +29,15 @@
 #include "socket=2Eh"
 #include "ssl_common=2Eh"
 
-vo=
id mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss);
+void mss_fixup_ipv=
4(const struct buffer *buf, uint16_t maxmss);
 
-void mss_fixup_ipv6(struct=
 buffer *buf, uint16_t maxmss);
+void mss_fixup_ipv6(const struct buffer *b=
uf, uint16_t maxmss);
 
-void mss_fixup_dowork(struct buffer *buf, uint16_t=
 maxmss);
+void mss_fixup_dowork(const struct buffer *buf, uint16_t maxmss)=
;
 
 /** Set the --mssfix option=2E */
-void frame_calculate_dynamic(struct=
 frame *frame, struct key_type *kt,
-                             const str=
uct options *options, struct link_socket_info *lsi);
+void frame_calculate_=
dynamic(struct frame *frame, const struct key_type *kt,
+                  =
           const struct options *options, const struct link_socket_info *ls=
i);
 
 /**
  * Checks and adjusts the fragment and mssfix value according t=
o the
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 5d88f8=
a=2E=2E922db3f 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec=

@@ -91,7 +91,7 @@
 }
 
 bool
-multi_tcp_instance_specific_init(struct mult=
i_context *m, struct multi_instance *mi)
+multi_tcp_instance_specific_init(=
const struct multi_context *m, struct multi_instance *mi)
 {
     /* buffer=
 for queued TCP socket output packets */
     mi->tcp_link_out_deferred =3D=
 mbuf_init(m->top=2Eoptions=2En_bcast_buf);
diff --git a/src/openvpn/mtcp=
=2Eh b/src/openvpn/mtcp=2Eh
index 9b7d1d2=2E=2Ebb117fa 100644
--- a/src/ope=
nvpn/mtcp=2Eh
+++ b/src/openvpn/mtcp=2Eh
@@ -35,7 +35,7 @@
 
 void multi_tc=
p_dereference_instance(struct multi_io *multi_io, struct multi_instance *mi=
);
 
-bool multi_tcp_instance_specific_init(struct multi_context *m, struct=
 multi_instance *mi);
+bool multi_tcp_instance_specific_init(const struct m=
ulti_context *m, struct multi_instance *mi);
 
 void multi_tcp_instance_spe=
cific_free(struct multi_instance *mi);
 
diff --git a/src/openvpn/mudp=2Ec =
b/src/openvpn/mudp=2Ec
index de3d467=2E=2E5e37682 100644
--- a/src/openvpn/=
mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -53,8 +53,9 @@
  * @param sock    th=
e socket to send the reply on
  */
 static void
-send_standalone_reply(stru=
ct multi_context *m, struct buffer *buf, const char *prefix,
-             =
         const char *detail, struct link_socket *sock)
+send_standalone_rep=
ly(struct multi_context *m, const struct buffer *buf,
+                    =
  const char *prefix, const char *detail,
+                      struct lin=
k_socket *sock)
 {
     struct context *c =3D &m->top;
 
@@ -74,7 +75,7 @@
=
 
 static void
 send_hmac_reset_packet(struct multi_context *m, struct tls_=
pre_decrypt_state *state,
-                       struct tls_auth_standalon=
e *tas, struct session_id *sid,
+                       const struct tls_au=
th_standalone *tas, const struct session_id *sid,
                        b=
ool request_resend_wkc, struct link_socket *sock)
 {
     reset_packet_id_s=
end(&state->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
@@ -97,11 +98,11 @@
 
 =
    enum first_packet_verdict verdict;
 
-    struct tls_auth_standalone *t=
as =3D m->top=2Ec2=2Etls_auth_standalone;
+    const struct tls_auth_standa=
lone *tas =3D m->top=2Ec2=2Etls_auth_standalone;
 
     verdict =3D tls_pre=
_decrypt_lite(tas, state, &m->top=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
-    =
uint8_t *hmac_key =3D m->top=2Ec2=2Esession_id_key;
+    const uint8_t *hma=
c_key =3D m->top=2Ec2=2Esession_id_key;
     const struct openvpn_sockaddr =
*from =3D &m->top=2Ec2=2Efrom=2Edest;
     int handwindow =3D m->top=2Eopti=
ons=2Ehandshake_window;
 
@@ -218,7 +219,7 @@
 static struct multi_instance=
 *
 handle_connection_attempt(struct multi_context *m,
                    =
       struct link_socket *sock,
-                          struct mroute_a=
ddr *real)
+                          const struct mroute_addr *real)
 {
  =
   struct hash *hash =3D m->hash;
     struct tls_pre_decrypt_state state =
=3D { 0 };
@@ -286,7 +287,7 @@
  * @return      instance matching the addre=
ss, NULL otherwise
  */
 static struct multi_instance *
-multi_get_instance=
_udp_real(struct multi_context *m, struct mroute_addr *real)
+multi_get_ins=
tance_udp_real(struct multi_context *m, const struct mroute_addr *real)
 {
=
     struct hash *hash =3D m->hash;
     struct hash_element *he;
@@ -320,7=
 +321,9 @@
  * maintaining real address hash table atomicity=2E
  */
 struc=
t multi_instance *
-multi_get_instance_udp_data(struct multi_context *m, bo=
ol *floated, struct mroute_addr *real, struct link_socket *sock)
+multi_get=
_instance_udp_data(struct multi_context *m, bool *floated,
+               =
             const struct mroute_addr *real,
+                            c=
onst struct link_socket *sock)
 {
     struct multi_instance *mi =3D NULL;
=
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 74939bf=
=2E=2E73f8d24 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -57,7 +57,7 @@
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
 static const char *
-=
id(struct multi_instance *mi)
+id(const struct multi_instance *mi)
 {
     =
if (mi)
     {
@@ -1314,7 +1314,7 @@
  * same common name=2E
  */
 static v=
oid
-multi_delete_dup(struct multi_context *m, struct multi_instance *new_m=
i)
+multi_delete_dup(struct multi_context *m, const struct multi_instance *=
new_mi)
 {
     if (new_mi)
     {
@@ -2259,7 +2259,7 @@
 }
 
 static bool
=
-multi_client_setup_dco_initial(struct multi_context *m, struct multi_insta=
nce *mi,
+multi_client_setup_dco_initial(const struct multi_context *m, str=
uct multi_instance *mi,
                                struct gc_arena *gc=
)
 {
     if (!dco_enabled(&mi->context=2Eoptions))
@@ -3078,7 +3078,8 @@
 =
 * positive=2E
  */
 static bool
-multi_check_dest_addr_allowed(struct mult=
i_context *m, struct multi_instance *mi, struct mroute_addr *real)
+multi_c=
heck_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi,
=
+                              const struct mroute_addr *real)
 {
     stru=
ct hash *hash =3D m->hash;
     const uint64_t hv =3D hash_value(hash, real=
);
@@ -3237,7 +3238,7 @@
 
 #if defined(ENABLE_DCO)
 static void
-process_i=
ncoming_del_peer(struct multi_context *m, struct multi_instance *mi, dco_co=
ntext_t *dco)
+process_incoming_del_peer(struct multi_context *m, struct mu=
lti_instance *mi, const dco_context_t *dco)
 {
     const char *reason =3D =
"ovpn-dco: unknown reason";
     switch (dco->dco_del_peer_reason)
@@ -4281=
,7 +4282,7 @@
 
 /* Searches for the address and deletes it if it is owned =
by the multi_instance */
 static void
-multi_unlearn_addr(struct multi_cont=
ext *m, struct multi_instance *mi, const struct mroute_addr *addr)
+multi_u=
nlearn_addr(struct multi_context *m, const struct multi_instance *mi, const=
 struct mroute_addr *addr)
 {
     struct hash_element *he;
     const uint=
64_t hv =3D hash_value(m->vhash, addr);
@@ -4316,7 +4317,7 @@
  * @param a =
    The new IPv4 address in network byte order
  */
 static void
-multi_unl=
earn_in_addr_t(struct multi_context *m, struct multi_instance *mi, in_addr_=
t a)
+multi_unlearn_in_addr_t(struct multi_context *m, const struct multi_i=
nstance *mi, in_addr_t a)
 {
     struct mroute_addr addr;
     CLEAR(addr)=
;
@@ -4334,7 +4335,7 @@
  * @param a6    The new IPv6 address
  */
 static =
void
-multi_unlearn_in6_addr(struct multi_context *m, struct multi_instance=
 *mi, struct in6_addr a6)
+multi_unlearn_in6_addr(struct multi_context *m, =
const struct multi_instance *mi, struct in6_addr a6)
 {
     struct mroute_=
addr addr;
     CLEAR(addr);
@@ -4450,7 +4451,7 @@
 
 bool
 multi_check_pus=
h_ifconfig_ipv6_extra_route(struct multi_instance *mi,
-                   =
                        struct in6_addr *dest)
+                           =
                const struct in6_addr *dest)
 {
     const struct options *=
o =3D &mi->context=2Eoptions;
 
diff --git a/src/openvpn/multi=2Eh b/src/op=
envpn/multi=2Eh
index 8b837fa=2E=2Ec285fc3 100644
--- a/src/openvpn/multi=
=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -516,7 +516,7 @@
  */
 
 static inline =
void
-set_prefix(struct multi_instance *mi)
+set_prefix(const struct multi_=
instance *mi)
 {
 #ifdef MULTI_DEBUG_EVENT_LOOP
     if (mi->msg_prefix[0])=

@@ -690,7 +690,7 @@
  */
 bool
 multi_check_push_ifconfig_ipv6_extra_route=
(struct multi_instance *mi,
-                                           str=
uct in6_addr *dest);
+                                           const stru=
ct in6_addr *dest);
 
 /*
  * Check for signals=2E
diff --git a/src/openvpn=
/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 3604684=2E=2E52eb8c7 100644
=
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -159,7 +15=
9,7 @@
  * a point-to-multipoint tunnel=2E
  */
 static unsigned int
-p2mp_=
iow_flags(const struct multi_context *m, struct link_socket *sock)
+p2mp_io=
w_flags(const struct multi_context *m, const struct link_socket *sock)
 {
 =
    unsigned int flags =3D IOW_WAIT_SIGNAL;
 
diff --git a/src/openvpn/netw=
orking=2Eh b/src/openvpn/networking=2Eh
index bce0c19=2E=2E25233c8 100644
-=
-- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@@ -44,7 +=
44,7 @@
  */
 #if !defined(ENABLE_IPROUTE)
 static inline int
-net_ctx_init=
(struct context *c, openvpn_net_ctx_t *ctx)
+net_ctx_init(const struct cont=
ext *c, openvpn_net_ctx_t *ctx)
 {
     (void)c;
     (void)ctx;
@@ -75,7 +=
75,7 @@
  *
  * @return          0 on success, a negative error code otherw=
ise
  */
-int net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx);
+int=
 net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx);
 
 /**
  * =
Release resources allocated by the internal garbage collector
@@ -102,7 +10=
2,7 @@
  * @return          0 on success, negative error code on error
  */=

 int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *ifac=
e, const char *type,
-                  void *arg);
+                  cons=
t void *arg);
 
 /**
  * Retrieve the interface type
diff --git a/src/openv=
pn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec
index a1f3=
525=2E=2Ef091fb3 100644
--- a/src/openvpn/networking_iproute2=2Ec
+++ b/src=
/openvpn/networking_iproute2=2Ec
@@ -36,7 +36,7 @@
 #include <netinet/in=2E=
h>
 
 int
-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+net_ctx=
_init(const struct context *c, openvpn_net_ctx_t *ctx)
 {
     ctx->es =3D =
NULL;
     if (c)
@@ -61,7 +61,7 @@
 }
 
 int
-net_iface_new(openvpn_net_ct=
x_t *ctx, const char *iface, const char *type, void *arg)
+net_iface_new(op=
envpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)=

 {
     struct argv argv =3D argv_new();
 
diff --git a/src/openvpn/networ=
king_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index e6e72d0=2E=2Ea1d220=
f 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networkin=
g_sitnl=2Ec
@@ -987,7 +987,7 @@
 }
 
 static int
-sitnl_addr_del(sa_family_=
t af_family, const char *iface, inet_address_t *addr, int prefixlen)
+sitnl=
_addr_del(sa_family_t af_family, const char *iface, const inet_address_t *a=
ddr, int prefixlen)
 {
     int ifindex;
 
@@ -1230,8 +1230,8 @@
 }
 
 stat=
ic int
-sitnl_route_del(const char *iface, sa_family_t af_family, inet_addr=
ess_t *dst, int prefixlen,
-                inet_address_t *gw, uint32_t ta=
ble, int metric)
+sitnl_route_del(const char *iface, sa_family_t af_family,=
 const inet_address_t *dst, int prefixlen,
+                const inet_addr=
ess_t *gw, uint32_t table, int metric)
 {
     int ifindex =3D 0;
 
@@ -130=
8,7 +1308,7 @@
 
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *=
iface, const char *type, void *arg)
+net_iface_new(openvpn_net_ctx_t *ctx, =
const char *iface, const char *type, const void *arg)
 {
     struct sitnl_=
link_req req =3D {};
     int ret =3D -1;
diff --git a/src/openvpn/occ=2Eh =
b/src/openvpn/occ=2Eh
index bda4f18=2E=2E49def4d 100644
--- a/src/openvpn/o=
cc=2Eh
+++ b/src/openvpn/occ=2Eh
@@ -156,7 +156,7 @@
  * via control channe=
l=2E
  * @return control channel exit message should be used */
 static inl=
ine bool
-cc_exit_notify_enabled(struct context *c)
+cc_exit_notify_enabled=
(const struct context *c)
 {
     /* Check if we have TLS active at all */
=
     if (!c->c2=2Etls_multi)
diff --git a/src/openvpn/openssl_compat=2Eh b/=
src/openvpn/openssl_compat=2Eh
index 098bdd5=2E=2E1a934db 100644
--- a/src/=
openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -127,7 +=
127,7 @@
 /* Mimics the functions but only when the default context without=

  * options is chosen */
 static inline const EVP_CIPHER *
-EVP_CIPHER_fet=
ch(void *ctx, const char *algorithm, const char *properties)
+EVP_CIPHER_fe=
tch(const void *ctx, const char *algorithm, const char *properties)
 {
    =
 ASSERT(!ctx);
     ASSERT(!properties);
@@ -135,7 +135,7 @@
 }
 
 static i=
nline const EVP_MD *
-EVP_MD_fetch(void *ctx, const char *algorithm, const =
char *properties)
+EVP_MD_fetch(const void *ctx, const char *algorithm, con=
st char *properties)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
diff -=
-git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index b210a5d=2E=
=2Ed5c0fe4 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -2423,7 +2423,7 @@
 }
 
 static void
-options_postprocess_mutate_le=
(struct connection_entry *ce, struct local_entry *le, int mode)
+options_po=
stprocess_mutate_le(const struct connection_entry *ce, struct local_entry *=
le, int mode)
 {
     /* use the global port if none is specified */
     i=
f (!le->port)
@@ -3576,7 +3576,7 @@
 static bool
 verify_permission(const c=
har *name, const char *file, int line, const uint64_t type,
               =
    const uint64_t allowed, uint64_t *found, const msglvl_t msglevel,
-    =
              struct options *options, bool is_inline)
+                  c=
onst struct options *options, bool is_inline)
 {
     if (!(type & allowed)=
)
     {
@@ -4143,7 +4143,7 @@
 }
 
 static void
-show_compression_warning(=
struct compress_options *info)
+show_compression_warning(const struct compr=
ess_options *info)
 {
     if (comp_non_stub_enabled(info))
     {
diff --g=
it a/src/openvpn/options_parse=2Ec b/src/openvpn/options_parse=2Ec
index 88=
ab4d2=2E=2E0e94522 100644
--- a/src/openvpn/options_parse=2Ec
+++ b/src/ope=
nvpn/options_parse=2Ec
@@ -258,7 +258,7 @@
 }
 
 static char *
-read_inline=
_file(struct in_src *is, const char *close_tag, int *num_lines, struct gc_a=
rena *gc)
+read_inline_file(const struct in_src *is, const char *close_tag,=
 int *num_lines, struct gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE];
=
     struct buffer buf =3D alloc_buf(8 * OPTION_LINE_SIZE);
@@ -302,7 +302,=
7 @@
 }
 
 static int
-check_inline_file(struct in_src *is, char *p[], stru=
ct gc_arena *gc)
+check_inline_file(const struct in_src *is, char *p[], str=
uct gc_arena *gc)
 {
     int num_inline_lines =3D 0;
 
diff --git a/src/op=
envpn/otime=2Ec b/src/openvpn/otime=2Ec
index 1608458=2E=2E5d3633c 100644
-=
-- a/src/openvpn/otime=2Ec
+++ b/src/openvpn/otime=2Ec
@@ -66,7 +66,7 @@
 }=

 
 void
-update_now_usec(struct timeval *tv)
+update_now_usec(const struct=
 timeval *tv)
 {
     const time_t last =3D now;
     update_now(tv->tv_sec=
);
diff --git a/src/openvpn/otime=2Eh b/src/openvpn/otime=2Eh
index d14f01e=
=2E=2E74d21ff 100644
--- a/src/openvpn/otime=2Eh
+++ b/src/openvpn/otime=2E=
h
@@ -65,7 +65,7 @@
 void update_now(const time_t system_time);
 
 extern t=
ime_t now_usec;
-void update_now_usec(struct timeval *tv);
+void update_now=
_usec(const struct timeval *tv);
 
 static inline int
 openvpn_gettimeofday=
(struct timeval *tv, void *tz)
diff --git a/src/openvpn/proto=2Eh b/src/ope=
nvpn/proto=2Eh
index 3570582=2E=2E33bf4ea 100644
--- a/src/openvpn/proto=2E=
h
+++ b/src/openvpn/proto=2Eh
@@ -248,7 +248,7 @@
  * and offset of IP head=
er (via parameter)=2E
  */
 static inline int
-get_tun_ip_ver(int tunnel_ty=
pe, struct buffer *buf, int *ip_hdr_offset)
+get_tun_ip_ver(int tunnel_type=
, const struct buffer *buf, int *ip_hdr_offset)
 {
     int ip_ver =3D -1;
=
 
diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index e0700aa=
=2E=2E5e13d1f 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2E=
c
@@ -527,8 +527,9 @@
 }
 
 static bool
-add_proxy_headers(struct http_prox=
y_info *p, socket_descriptor_t sd, /* already open to proxy */
-           =
       const char *host                                   /* openvpn server=
 remote */
+add_proxy_headers(const struct http_proxy_info *p,
+           =
       socket_descriptor_t sd, /* already open to proxy */
+               =
   const char *host        /* openvpn server remote */
 )
 {
     char buf[=
512];
@@ -597,8 +598,8 @@
                               socket_descriptor_=
t sd, /* already open to proxy */
                               const char=
 *host,       /* openvpn server remote */
                               co=
nst char *port,       /* openvpn server port */
-                          =
    struct event_timeout *server_poll_timeout, struct buffer *lookahead,
- =
                             struct signal_info *sig_info)
+               =
               const struct event_timeout *server_poll_timeout,
+          =
                    struct buffer *lookahead, struct signal_info *sig_info)=

 {
     struct gc_arena gc =3D gc_new();
     char buf[512];
diff --git a/=
src/openvpn/proxy=2Eh b/src/openvpn/proxy=2Eh
index e662e7d=2E=2Ea2f4e47 10=
0644
--- a/src/openvpn/proxy=2Eh
+++ b/src/openvpn/proxy=2Eh
@@ -89,7 +89,7=
 @@
                                    socket_descriptor_t sd, /* already =
open to proxy */
                                    const char *host,     =
  /* openvpn server remote */
                                    const cha=
r *port,       /* openvpn server port */
-                                 =
  struct event_timeout *server_poll_timeout,
+                             =
      const struct event_timeout *server_poll_timeout,
                    =
                struct buffer *lookahead, struct signal_info *sig_info);
 
=
 uint8_t *make_base64_string2(const uint8_t *str, int str_len, struct gc_ar=
ena *gc);
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index be91a9=
9=2E=2E0c91449 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ =
-332,7 +332,7 @@
  * the proxy can determine true client origin=2E
  */
 st=
atic void
-journal_add(const char *journal_dir, struct proxy_connection *pc=
, struct proxy_connection *cp)
+journal_add(const char *journal_dir, const =
struct proxy_connection *pc, struct proxy_connection *cp)
 {
     struct op=
envpn_sockaddr from, to;
 
@@ -410,7 +410,7 @@
 static bool
 proxy_entry_ne=
w(struct proxy_connection **list, struct event_set *es,
                 co=
nst struct openvpn_sockaddr server_addr, const socket_descriptor_t sd_clien=
t,
-                struct buffer *initial_data, const char *journal_dir)
+=
                const struct buffer *initial_data, const char *journal_dir)=

 {
     socket_descriptor_t sd_server;
     int status;
@@ -1013,7 +1013,7=
 @@
  * call=2E
  */
 void
-port_share_redirect(struct port_share *ps, cons=
t struct buffer *head, socket_descriptor_t sd)
+port_share_redirect(const s=
truct port_share *ps, const struct buffer *head, socket_descriptor_t sd)
 {=

     if (ps)
     {
diff --git a/src/openvpn/ps=2Eh b/src/openvpn/ps=2Eh
i=
ndex 557ecf5=2E=2E918ceb6 100644
--- a/src/openvpn/ps=2Eh
+++ b/src/openvpn=
/ps=2Eh
@@ -49,7 +49,7 @@
 
 bool is_openvpn_protocol(const struct buffer *=
buf);
 
-void port_share_redirect(struct port_share *ps, const struct buffe=
r *head, socket_descriptor_t sd);
+void port_share_redirect(const struct po=
rt_share *ps, const struct buffer *head, socket_descriptor_t sd);
 
 #endif=
 /* if PORT_SHARE */
 #endif /* ifndef PS_H */
diff --git a/src/openvpn/pus=
h=2Ec b/src/openvpn/push=2Ec
index fa7bf1e=2E=2Ec2c1914 100644
--- a/src/op=
envpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -430,7 +430,7 @@
 }
 
 bool
-s=
end_auth_pending_messages(struct tls_multi *tls_multi, struct tls_session *=
session,
+send_auth_pending_messages(const struct tls_multi *tls_multi, str=
uct tls_session *session,
                            const char *extra, un=
signed int timeout)
 {
     struct key_state *ks =3D &session->key[KS_PRIMA=
RY];
diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index dff945f=
=2E=2E39302f6 100644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
=
@@ -117,7 +117,7 @@
  * doc/management-notes=2Etxt under client-pending-aut=
h for
  * more details on message format
  */
-bool send_auth_pending_messa=
ges(struct tls_multi *tls_multi, struct tls_session *session,
+bool send_au=
th_pending_messages(const struct tls_multi *tls_multi, struct tls_session *=
session,
                                 const char *extra, unsigned int t=
imeout);
 
 void send_restart(struct context *c, const char *kill_msg);
dif=
f --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index 02130=
41=2E=2E7fa5987 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/pu=
sh_util=2Ec
@@ -222,7 +222,7 @@
 
 /* Return true if the client supports pu=
sh-update */
 static bool
-support_push_update(struct multi_instance *mi)
+=
support_push_update(const struct multi_instance *mi)
 {
     ASSERT(mi->con=
text=2Ec2=2Etls_multi);
     const unsigned int iv_proto_peer =3D extract_i=
v_proto(mi->context=2Ec2=2Etls_multi->peer_info);
diff --git a/src/openvpn/=
reliable=2Ec b/src/openvpn/reliable=2Ec
index 690e50d6=2E=2E392eb57 100644
=
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -92,7 +92,=
7 @@
 
 /* check if a particular packet_id is present in ack */
 static inl=
ine bool
-reliable_ack_packet_id_present(struct reliable_ack *ack, packet_i=
d_type pid)
+reliable_ack_packet_id_present(const struct reliable_ack *ack,=
 packet_id_type pid)
 {
     for (int i =3D 0; i < ack->len; ++i)
     {
@@=
 -724,7 +724,7 @@
  */
 
 void
-reliable_mark_active_incoming(struct reliab=
le *rel, struct buffer *buf, packet_id_type pid,
+reliable_mark_active_inco=
ming(struct reliable *rel, const struct buffer *buf, packet_id_type pid,
  =
                             int opcode)
 {
     for (int i =3D 0; i < rel-=
>size; ++i)
@@ -784,7 +784,7 @@
 
 /* delete a buffer previously activated =
by reliable_mark_active() */
 void
-reliable_mark_deleted(struct reliable *=
rel, struct buffer *buf)
+reliable_mark_deleted(struct reliable *rel, const=
 struct buffer *buf)
 {
     for (int i =3D 0; i < rel->size; ++i)
     {
d=
iff --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh
index a5ed7=
5c=2E=2E8d9e2e3 100644
--- a/src/openvpn/reliable=2Eh
+++ b/src/openvpn/rel=
iable=2Eh
@@ -173,7 +173,7 @@
  * @li False, if there are packet IDs to be =
acknowledged=2E
  */
 static inline bool
-reliable_ack_empty(struct reliabl=
e_ack *ack)
+reliable_ack_empty(const struct reliable_ack *ack)
 {
     ret=
urn !ack->len;
 }
@@ -186,7 +186,7 @@
  * @returns the number of outstandin=
g acks
  */
 static inline int
-reliable_ack_outstanding(struct reliable_ac=
k *ack)
+reliable_ack_outstanding(const struct reliable_ack *ack)
 {
     r=
eturn ack->len;
 }
@@ -336,7 +336,7 @@
  * @param pid The packet's packet I=
D=2E
  * @param opcode The packet's opcode=2E
  */
-void reliable_mark_acti=
ve_incoming(struct reliable *rel, struct buffer *buf, packet_id_type pid,
+=
void reliable_mark_active_incoming(struct reliable *rel, const struct buffe=
r *buf, packet_id_type pid,
                                    int opcode)=
;
 
 /**
@@ -389,7 +389,7 @@
  * @param rel The reliable structure associat=
ed with the given buffer=2E
  * @param buf The buffer of the reliable entry=
 which is to be removed=2E
  */
-void reliable_mark_deleted(struct reliable=
 *rel, struct buffer *buf);
+void reliable_mark_deleted(struct reliable *re=
l, const struct buffer *buf);
 
 /** @} name Functions for extracting incom=
ing packets */
 
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec=

index 03a2526=2E=2E078bb7e 100644
--- a/src/openvpn/route=2Ec
+++ b/src/op=
envpn/route=2Ec
@@ -898,8 +898,9 @@
 }
 
 static bool
-add_bypass_routes(st=
ruct route_bypass *rb, in_addr_t gateway, const struct tuntap *tt,
-       =
           unsigned int flags, const struct route_gateway_info *rgi,
+add_b=
ypass_routes(const struct route_bypass *rb, in_addr_t gateway,
+           =
       const struct tuntap *tt, unsigned int flags,
+                  cons=
t struct route_gateway_info *rgi,
                   const struct env_set *=
es, openvpn_net_ctx_t *ctx)
 {
     int ret =3D true;
@@ -916,8 +917,9 @@
 =
}
 
 static void
-del_bypass_routes(struct route_bypass *rb, in_addr_t gate=
way, const struct tuntap *tt,
-                  unsigned int flags, const =
struct route_gateway_info *rgi,
+del_bypass_routes(const struct route_bypas=
s *rb, in_addr_t gateway,
+                  const struct tuntap *tt, unsig=
ned int flags,
+                  const struct route_gateway_info *rgi,
   =
                const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     i=
nt i;
@@ -3942,7 +3944,7 @@
 #else  /* if defined(_WIN32) */
 
 static void=

-get_bypass_addresses(struct route_bypass *rb, const unsigned int flags) /=
* PLATFORM-SPECIFIC */
+get_bypass_addresses(struct route_bypass *rb, const=
 unsigned int flags)
 {
 }
 
diff --git a/src/openvpn/schedule=2Ec b/src/op=
envpn/schedule=2Ec
index 6772ad6=2E=2E694f4d1 100644
--- a/src/openvpn/sche=
dule=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -389,4 +389,4 @@
 {
     s->earl=
iest_wakeup =3D NULL; /* invalidate cache */
     schedule_remove_node(s, e=
);
-}
\ No newline at end of file
+}
diff --git a/src/openvpn/socket=2Ec b/=
src/openvpn/socket=2Ec
index 50126bf=2E=2E6684350 100644
--- a/src/openvpn/=
socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -619,7 +619,7 @@
 }
 
 static vo=
id
-bind_local(struct link_socket *sock, const sa_family_t ai_family)
+bind=
_local(const struct link_socket *sock, const sa_family_t ai_family)
 {
    =
 /* bind to local address/port */
     if (sock->bind_local)
@@ -886,8 +886=
,8 @@
 }
 
 void
-socket_bind(socket_descriptor_t sd, struct addrinfo *loca=
l, int ai_family, const char *prefix,
-            bool ipv6only)
+socket_b=
ind(socket_descriptor_t sd, const struct addrinfo *local, int ai_family,
+ =
           const char *prefix, bool ipv6only)
 {
     struct gc_arena gc =
=3D gc_new();
 
@@ -1095,8 +1095,8 @@
  * such as TCP=2E
  */
 
-static voi=
d stream_buf_init(struct stream_buf *sb, struct buffer *buf, const unsigned=
 int sockflags,
-                            const int proto);
+static void=
 stream_buf_init(struct stream_buf *sb, const struct buffer *buf,
+        =
                    const unsigned int sockflags, const int proto);
 
 stat=
ic void stream_buf_close(struct stream_buf *sb);
 
@@ -1453,7 +1453,7 @@
 }=

 
 static void
-phase2_set_socket_flags(struct link_socket *sock)
+phase2_=
set_socket_flags(const struct link_socket *sock)
 {
     /* TCP_NODELAY is =
enabled by default on every TCP socket; dco-win is
      * skipped as it ma=
nages its own socket */
@@ -2053,7 +2053,7 @@
 }
 
 static void
-stream_buf=
_init(struct stream_buf *sb, struct buffer *buf, const unsigned int sockfla=
gs,
+stream_buf_init(struct stream_buf *sb, const struct buffer *buf, const=
 unsigned int sockflags,
                 const int proto)
 {
     sb->buf_=
init =3D *buf;
@@ -2319,7 +2319,7 @@
 #endif
 
 static ssize_t
-link_socket=
_read_udp_posix_recvmsg(struct link_socket *sock, struct buffer *buf,
+link=
_socket_read_udp_posix_recvmsg(const struct link_socket *sock, struct buffe=
r *buf,
                                    struct link_socket_actual *from=
, socklen_t *fromlen)
 {
     struct iovec iov;
@@ -2391,7 +2391,7 @@
 #end=
if /* if ENABLE_IP_PKTINFO */
 
 ssize_t
-link_socket_read_udp_posix(struct=
 link_socket *sock, struct buffer *buf,
+link_socket_read_udp_posix(const s=
truct link_socket *sock, struct buffer *buf,
                            st=
ruct link_socket_actual *from)
 {
     ssize_t recvlen;
@@ -2454,7 +2454,7 =
@@
 #if ENABLE_IP_PKTINFO
 
 ssize_t
-link_socket_write_udp_posix_sendmsg(s=
truct link_socket *sock, struct buffer *buf,
+link_socket_write_udp_posix_s=
endmsg(const struct link_socket *sock, const struct buffer *buf,
          =
                           struct link_socket_actual *to)
 {
     struct io=
vec iov;
@@ -2648,7 +2648,7 @@
 }
 
 int
-socket_send_queue(struct link_soc=
ket *sock, struct buffer *buf, const struct link_socket_actual *to)
+socket=
_send_queue(struct link_socket *sock, const struct buffer *buf, const struc=
t link_socket_actual *to)
 {
     if (sock->writes=2Eiostate =3D=3D IOSTATE=
_INITIAL)
     {
@@ -2748,8 +2748,8 @@
     return sock->writes=2Eiostate;
=
 }
 
-void
-read_sockaddr_from_overlapped(struct overlapped_io *io, struct =
sockaddr *dst, int overlapped_ret)
+static void
+read_sockaddr_from_overlap=
ped(const struct overlapped_io *io, struct sockaddr *dst, int overlapped_re=
t)
 {
     if (overlapped_ret >=3D 0 && io->addr_defined)
     {
diff --git=
 a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 89465bc=2E=2Ec6bcd=
86 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -268=
,7 +268,7 @@
 
 int socket_recv_queue(struct link_socket *sock, int maxsize=
);
 
-int socket_send_queue(struct link_socket *sock, struct buffer *buf,
+=
int socket_send_queue(struct link_socket *sock, const struct buffer *buf,
 =
                      const struct link_socket_actual *to);
 
 typedef stru=
ct
@@ -348,8 +348,8 @@
 
 struct link_socket *link_socket_new(void);
 
-voi=
d socket_bind(socket_descriptor_t sd, struct addrinfo *local, int af_family=
, const char *prefix,
-                 bool ipv6only);
+void socket_bind(s=
ocket_descriptor_t sd, const struct addrinfo *local, int af_family,
+      =
           const char *prefix, bool ipv6only);
 
 int openvpn_connect(socke=
t_descriptor_t sd, const struct sockaddr *remote, int connect_timeout,
    =
                 volatile int *signal_received);
@@ -483,7 +483,7 @@
 }
 
 =
static inline bool
-link_socket_verify_incoming_addr(struct buffer *buf, co=
nst struct link_socket_info *info,
+link_socket_verify_incoming_addr(const =
struct buffer *buf, const struct link_socket_info *info,
                  =
                const struct link_socket_actual *from_addr)
 {
     if (buf=
->len > 0)
@@ -607,7 +607,7 @@
 
 #else  /* ifdef _WIN32 */
 
-ssize_t link=
_socket_read_udp_posix(struct link_socket *sock, struct buffer *buf,
+ssize=
_t link_socket_read_udp_posix(const struct link_socket *sock, struct buffer=
 *buf,
                                    struct link_socket_actual *from)=
;
 
 #endif /* ifdef _WIN32 */
@@ -693,12 +693,12 @@
 
 #else /* ifdef _WIN=
32 */
 
-ssize_t link_socket_write_udp_posix_sendmsg(struct link_socket *so=
ck, struct buffer *buf,
+ssize_t link_socket_write_udp_posix_sendmsg(const =
struct link_socket *sock, const struct buffer *buf,
                       =
                      struct link_socket_actual *to);
 
 
 static inline ss=
ize_t
-link_socket_write_udp_posix(struct link_socket *sock, struct buffer =
*buf,
+link_socket_write_udp_posix(const struct link_socket *sock, const st=
ruct buffer *buf,
                             struct link_socket_actual *t=
o)
 {
 #if ENABLE_IP_PKTINFO
@@ -714,7 +714,7 @@
 }
 
 static inline ssize_=
t
-link_socket_write_tcp_posix(struct link_socket *sock, struct buffer *buf=
)
+link_socket_write_tcp_posix(const struct link_socket *sock, const struct=
 buffer *buf)
 {
     return send(sock->sd, BPTR(buf), BLENZ(buf), MSG_NOSI=
GNAL);
 }
@@ -772,7 +772,7 @@
  * from tunnel packet=2E
  */
 static inline=
 void
-link_socket_set_tos(struct link_socket *sock)
+link_socket_set_tos(c=
onst struct link_socket *sock)
 {
     if (sock && sock->ptos_defined)
    =
 {
@@ -818,6 +818,8 @@
     }
 }
 
+/* cppcheck-suppress constParameterPoin=
ter
+ * sock is modified on Windows via &sock->listen_handle */
 static inl=
ine void
 socket_reset_listen_persistent(struct link_socket *sock)
 {
diff =
--git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh
index 13f=
5962=2E=2Eadd08ba 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvp=
n/socket_util=2Eh
@@ -439,7 +439,7 @@
 
 
 static inline bool
-addrlist_mat=
ch_proto(const struct openvpn_sockaddr *a1, struct addrinfo *addr_list, con=
st int proto)
+addrlist_match_proto(const struct openvpn_sockaddr *a1, cons=
t struct addrinfo *addr_list, const int proto)
 {
     return link_socket_p=
roto_connection_oriented(proto) ? addrlist_match(a1, addr_list)
           =
                                              : addrlist_port_match(a1, add=
r_list);
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
index 1=
9f3d54=2E=2E77ca863 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn/so=
cks=2Ec
@@ -82,7 +82,7 @@
 
 static bool
 socks_proxy_recv_char(uint8_t *c,=
 const char *name, socket_descriptor_t sd,
-                      struct ev=
ent_timeout *server_poll_timeout,
+                      const struct event=
_timeout *server_poll_timeout,
                       volatile int *signal_=
received)
 {
     fd_set reads;
@@ -97,8 +97,8 @@
 }
 
 static bool
-socks_=
username_password_auth(struct socks_proxy_info *p, socket_descriptor_t sd,
=
-                             struct event_timeout *server_poll_timeout,
+s=
ocks_username_password_auth(const struct socks_proxy_info *p, socket_descri=
ptor_t sd,
+                             const struct event_timeout *server=
_poll_timeout,
                              volatile int *signal_received)=

 {
     char to_send[516];
@@ -156,8 +156,8 @@
 }
 
 static bool
-socks_ha=
ndshake(struct socks_proxy_info *p, socket_descriptor_t sd,
-              =
  struct event_timeout *server_poll_timeout, volatile int *signal_received)=

+socks_handshake(const struct socks_proxy_info *p, socket_descriptor_t sd,=

+                const struct event_timeout *server_poll_timeout, volatile=
 int *signal_received)
 {
     uint8_t buf[2];
     int len =3D 0;
@@ -231,=
7 +231,7 @@
 
 static bool
 recv_socks_reply(socket_descriptor_t sd, struct=
 openvpn_sockaddr *addr,
-                 struct event_timeout *server_pol=
l_timeout, volatile int *signal_received)
+                 const struct ev=
ent_timeout *server_poll_timeout, volatile int *signal_received)
 {
     ui=
nt8_t atyp =3D 0;
     int alen =3D 0;
@@ -334,11 +334,11 @@
 }
 
 void
-es=
tablish_socks_proxy_passthru(struct socks_proxy_info *p,
+establish_socks_p=
roxy_passthru(const struct socks_proxy_info *p,
                           =
     socket_descriptor_t sd, /* already open to proxy */
                  =
              const char *host,       /* openvpn server remote */
         =
                       const char *servname,   /* openvpn server port */
- =
                              struct event_timeout *server_poll_timeout,
+ =
                              const struct event_timeout *server_poll_timeo=
ut,
                                struct signal_info *sig_info)
 {
     c=
har buf[270];
@@ -392,10 +392,10 @@
 }
 
 void
-establish_socks_proxy_udpas=
soc(struct socks_proxy_info *p,
+establish_socks_proxy_udpassoc(const struc=
t socks_proxy_info *p,
                                socket_descriptor_t =
ctrl_sd, /* already open to proxy */
                                struct=
 openvpn_sockaddr *relay_addr,
-                               struct event=
_timeout *server_poll_timeout,
+                               const struct=
 event_timeout *server_poll_timeout,
                                struct=
 signal_info *sig_info)
 {
     if (!socks_handshake(p, ctrl_sd, server_pol=
l_timeout, &sig_info->signal_received))
diff --git a/src/openvpn/socks=2Eh =
b/src/openvpn/socks=2Eh
index 846113d=2E=2Ef7c93b6 100644
--- a/src/openvpn=
/socks=2Eh
+++ b/src/openvpn/socks=2Eh
@@ -47,17 +47,17 @@
 
 void socks_pr=
oxy_close(struct socks_proxy_info *sp);
 
-void establish_socks_proxy_passt=
hru(struct socks_proxy_info *p,
+void establish_socks_proxy_passthru(const =
struct socks_proxy_info *p,
                                     socket_des=
criptor_t sd, /* already open to proxy */
                                 =
    const char *host,       /* openvpn server remote */
                   =
                  const char *servname,   /* openvpn server port */
-      =
                              struct event_timeout *server_poll_timeout,
+ =
                                   const struct event_timeout *server_poll_=
timeout,
                                     struct signal_info *sig_info)=
;
 
-void establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
+void =
establish_socks_proxy_udpassoc(const struct socks_proxy_info *p,
          =
                           socket_descriptor_t ctrl_sd, /* already open to =
proxy */
                                     struct openvpn_sockaddr *rela=
y_addr,
-                                    struct event_timeout *server_p=
oll_timeout,
+                                    const struct event_timeou=
t *server_poll_timeout,
                                     struct signal_=
info *sig_info);
 
 void socks_process_incoming_udp(struct buffer *buf, str=
uct link_socket_actual *from);
diff --git a/src/openvpn/ssl=2Ec b/src/openv=
pn/ssl=2Ec
index 5f5d1f9=2E=2Ee376db5 100644
--- a/src/openvpn/ssl=2Ec
+++ =
b/src/openvpn/ssl=2Ec
@@ -1153,7 +1153,7 @@
 }
 
 struct tls_multi *
-tls_m=
ulti_init(struct tls_options *tls_options)
+tls_multi_init(const struct tls=
_options *tls_options)
 {
     struct tls_multi *ret;
 
@@ -1194,7 +1194,7 =
@@
  */
 
 struct tls_auth_standalone *
-tls_auth_standalone_init(struct tl=
s_options *tls_options, struct gc_arena *gc)
+tls_auth_standalone_init(cons=
t struct tls_options *tls_options, struct gc_arena *gc)
 {
     struct tls_=
auth_standalone *tas;
 
@@ -1342,7 +1342,7 @@
 
 static void
 init_epoch_ke=
ys(struct key_state *ks, struct tls_multi *multi, const struct key_type *ke=
y_type,
-                bool server, struct key2 *key2)
+                b=
ool server, const struct key2 *key2)
 {
     /* For now we hardcode this to=
 be 4 for the software based data channel
      * DCO based implementations=
/HW implementation might adjust this number
@@ -1385,7 +1385,7 @@
 
 static=
 void
 init_key_contexts(struct key_state *ks, struct tls_multi *multi, con=
st struct key_type *key_type,
-                  bool server, struct key2 *=
key2, bool dco_enabled)
+                  bool server, const struct key2 *=
key2, bool dco_enabled)
 {
     struct key_ctx_bi *key =3D &ks->crypto_opti=
ons=2Ekey_ctx_bi;
 
@@ -1583,8 +1583,9 @@
 
 bool
 tls_session_update_crypt=
o_params_do_work(struct tls_multi *multi, struct tls_session *session,
-   =
                                      struct options *options, struct frame=
 *frame,
-                                         struct frame *frame_frag=
ment, struct link_socket_info *lsi,
+                                      =
   const struct options *options, struct frame *frame,
+                   =
                      struct frame *frame_fragment,
+                      =
                   const struct link_socket_info *lsi,
                    =
                      dco_context_t *dco)
 {
     if (session->key[KS_PRIMA=
RY]=2Ecrypto_options=2Ekey_ctx_bi=2Einitialized)
@@ -1653,7 +1654,7 @@
 boo=
l
 tls_session_update_crypto_params(struct tls_multi *multi, struct tls_ses=
sion *session,
                                  struct options *options, s=
truct frame *frame,
-                                 struct frame *frame_f=
ragment, struct link_socket_info *lsi,
+                                 st=
ruct frame *frame_fragment, const struct link_socket_info *lsi,
           =
                       dco_context_t *dco)
 {
     if (!check_session_ciphe=
r(session, options))
@@ -1869,7 +1870,8 @@
 }
 
 static bool
-push_peer_inf=
o_peerid(struct buffer *out, struct tls_multi *multi, struct tls_session *s=
ession)
+push_peer_info_peerid(struct buffer *out, const struct tls_multi *=
multi,
+                      const struct tls_session *session)
 {
     if=
 (multi->rx_peer_id =3D=3D MAX_PEER_ID || session->opt->dco_enabled)
     {=

@@ -1904,7 +1906,7 @@
  * @return          true if no error was encountere=
d
  */
 static bool
-push_peer_info(struct buffer *buf, struct tls_multi *m=
ulti, struct tls_session *session)
+push_peer_info(struct buffer *buf, cons=
t struct tls_multi *multi, struct tls_session *session)
 {
     struct gc_a=
rena gc =3D gc_new();
     bool ret =3D false;
@@ -2548,8 +2550,8 @@
 }
 
 =
bool
-session_skip_to_pre_start(struct tls_session *session, struct tls_pre=
_decrypt_state *state,
-                          struct link_socket_actual=
 *from)
+session_skip_to_pre_start(struct tls_session *session, const struc=
t tls_pre_decrypt_state *state,
+                          const struct lin=
k_socket_actual *from)
 {
     struct key_state *ks =3D &session->key[KS_PR=
IMARY];
     ks->session_id_remote =3D state->peer_session_id;
@@ -2767,7 +=
2769,7 @@
 
 static bool
 check_outgoing_ciphertext(struct key_state *ks, s=
truct tls_session *session,
-                          struct buffer *to_li=
nk, bool *continue_tls_process)
+                          const struct buf=
fer *to_link, bool *continue_tls_process)
 {
     if (to_link->len)
     {
=
@@ -4096,7 +4098,7 @@
 }
 
 void
-tls_post_encrypt(struct tls_multi *multi,=
 struct buffer *buf)
+tls_post_encrypt(struct tls_multi *multi, const struc=
t buffer *buf)
 {
     struct key_state *ks =3D multi->save_ks;
     multi-=
>save_ks =3D NULL;
@@ -4227,7 +4229,7 @@
  * into a garbage collectable str=
ing which is returned=2E
  */
 const char *
-protocol_dump(struct buffer *b=
uffer, unsigned int flags, struct gc_arena *gc)
+protocol_dump(const struct=
 buffer *buffer, unsigned int flags, struct gc_arena *gc)
 {
     struct bu=
ffer out =3D alloc_buf_gc(256, gc);
     struct buffer buf =3D *buffer;
dif=
f --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 7ddf965=2E=2E93e6=
200 100644
--- a/src/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -166,7 +1=
66,7 @@
  *
  * @return A newly allocated and initialized \c tls_multi stru=
cture=2E
  */
-struct tls_multi *tls_multi_init(struct tls_options *tls_opt=
ions);
+struct tls_multi *tls_multi_init(const struct tls_options *tls_opti=
ons);
 
 /**
  * Finalize initialization of a \c tls_multi structure=2E
@@ =
-187,7 +187,7 @@
 /*
  * Initialize a standalone tls-auth verification obje=
ct=2E
  */
-struct tls_auth_standalone *tls_auth_standalone_init(struct tls=
_options *tls_options,
+struct tls_auth_standalone *tls_auth_standalone_ini=
t(const struct tls_options *tls_options,
                                  =
                    struct gc_arena *gc);
 
 /**
@@ -371,7 +371,7 @@
  * @p=
aram multi - The TLS state for this packet's destination VPN tunnel=2E
  * =
@param buf - The buffer containing the outgoing packet=2E
  */
-void tls_po=
st_encrypt(struct tls_multi *multi, struct buffer *buf);
+void tls_post_enc=
rypt(struct tls_multi *multi, const struct buffer *buf);
 
 /** @} name Fun=
ctions for managing security parameter state for data channel packets */
 
=
@@ -461,7 +461,8 @@
  */
 bool tls_session_update_crypto_params(struct tls_=
multi *multi, struct tls_session *session,
                                =
       struct options *options, struct frame *frame,
-                     =
                 struct frame *frame_fragment, struct link_socket_info *lsi=
,
+                                      struct frame *frame_fragment,
+   =
                                   const struct link_socket_info *lsi,
    =
                                   dco_context_t *dco);
 
 /*
@@ -525,7 +52=
6,7 @@
 #define PD_VERBOSE                 (1 << 10)
 #define PD_TLS_CRYPT =
              (1 << 11)
 
-const char *protocol_dump(struct buffer *buffer,=
 unsigned int flags, struct gc_arena *gc);
+const char *protocol_dump(const=
 struct buffer *buffer, unsigned int flags, struct gc_arena *gc);
 
 /*
  *=
 debugging code
@@ -573,7 +574,7 @@
 /* Special method to skip the three wa=
y handshake RESET stages=2E This is
  * used by the HMAC code when seeing a=
 packet that matches the previous
  * HMAC based stateless server state */
=
-bool session_skip_to_pre_start(struct tls_session *session, struct tls_pre=
_decrypt_state *state,
-                               struct link_socket_a=
ctual *from);
+bool session_skip_to_pre_start(struct tls_session *session, =
const struct tls_pre_decrypt_state *state,
+                               =
const struct link_socket_actual *from);
 
 #endif /* ifndef OPENVPN_SSL_H *=
/
diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh
in=
dex a6d57f2=2E=2E29e07a6 100644
--- a/src/openvpn/ssl_backend=2Eh
+++ b/src=
/openvpn/ssl_backend=2Eh
@@ -137,7 +137,7 @@
  *
  * @return      true if t=
he context is initialised, false if not=2E
  */
-bool tls_ctx_initialised(s=
truct tls_root_ctx *ctx);
+bool tls_ctx_initialised(const struct tls_root_c=
tx *ctx);
 
 /**
  * Set any library specific options=2E
@@ -170,7 +170,7 @=
@
  * @param ciphers       String containing : delimited cipher names, or N=
ULL to use
  *                                      sane defaults=2E
  */
-=
void tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *c=
iphers);
+void tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ct=
x, const char *ciphers);
 
 /**
  * Set the TLS certificate profile=2E  The=
 profile defines which crypto
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/sr=
c/openvpn/ssl_mbedtls=2Ec
index c92c423=2E=2Ecddf856 100644
--- a/src/openv=
pn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -146,7 +146,7 @@
 }=

 
 bool
-tls_ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_initialise=
d(const struct tls_root_ctx *ctx)
 {
     /* either this should be NULL or =
should be non-null and then have a
      * valid TLS ctx inside as well */
=
@@ -269,7 +269,7 @@
 }
 
 void
-tls_ctx_restrict_ciphers_tls13(struct tls_r=
oot_ctx *ctx, const char *ciphers)
+tls_ctx_restrict_ciphers_tls13(const st=
ruct tls_root_ctx *ctx, const char *ciphers)
 {
     if (ciphers =3D=3D NUL=
L)
     {
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openss=
l=2Ec
index 7cfe9f4=2E=2Ecb3de65 100644
--- a/src/openvpn/ssl_openssl=2Ec
+=
++ b/src/openvpn/ssl_openssl=2Ec
@@ -129,7 +129,7 @@
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
@@ -446,7 +446,7 @@
=
 #endif
 
 void
-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, c=
onst char *ciphers)
+tls_ctx_restrict_ciphers_tls13(const struct tls_root_c=
tx *ctx, const char *ciphers)
 {
     if (ciphers =3D=3D NULL)
     {
@@ -1=
093,7 +1093,7 @@
 }
 
 static void
-tls_ctx_load_cert_uri(struct tls_root_c=
tx *tls_ctx, const char *uri)
+tls_ctx_load_cert_uri(const struct tls_root_=
ctx *tls_ctx, const char *uri)
 {
 #if defined(HAVE_OPENSSL_STORE_API)
    =
 X509 *x =3D NULL;
@@ -2008,7 +2008,7 @@
 }
 
 static void
-bio_debug_data(=
const char *mode, BIO *bio, const uint8_t *buf, int len, const char *desc)
=
+bio_debug_data(const char *mode, const BIO *bio, const uint8_t *buf, int l=
en, const char *desc)
 {
     struct gc_arena gc =3D gc_new();
     if (len=
 > 0)
@@ -2022,7 +2022,7 @@
 }
 
 static void
-bio_debug_oc(const char *mod=
e, BIO *bio)
+bio_debug_oc(const char *mode, const BIO *bio)
 {
     open_b=
iofp();
     fprintf(biofp, "BIO %s time=3D%" PRIi64 " bio=3D" ptr_format "=
\n", mode, (int64_t)time(NULL),
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/=
openvpn/ssl_pkt=2Ec
index 6a6d9f9=2E=2E4ced4c4 100644
--- a/src/openvpn/ssl=
_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -58,7 +58,7 @@
  *  @return      =
   if the swap was successful (buf was large enough)
  */
 static bool
-swa=
p_hmac(struct buffer *buf, const struct crypto_options *co, bool incoming)
=
+swap_hmac(const struct buffer *buf, const struct crypto_options *co, bool =
incoming)
 {
     ASSERT(co);
 
@@ -118,7 +118,7 @@
  */
 static void
 tls_=
wrap_control(struct tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,
=
-                 struct session_id *session_id)
+                 const st=
ruct session_id *session_id)
 {
     if (ctx->mode =3D=3D TLS_WRAP_AUTH || =
ctx->mode =3D=3D TLS_WRAP_NONE)
     {
@@ -402,9 +402,9 @@
 
 
 struct buff=
er
-tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalo=
ne *tas,
-                     struct session_id *own_sid, struct session_i=
d *remote_sid, uint8_t header,
-                     bool request_resend_wk=
c)
+tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_st=
andalone *tas,
+                     const struct session_id *own_sid, cons=
t struct session_id *remote_sid,
+                     uint8_t header, bool=
 request_resend_wkc)
 {
     /* Copy buffer here to point at the same data =
but allow tls_wrap_control
      * to potentially change buf to point to an=
other buffer without
@@ -489,7 +489,7 @@
 bool
 check_session_hmac_and_pkt_=
id(struct tls_pre_decrypt_state *state,
                               cons=
t struct openvpn_sockaddr *from,
-                              uint8_t *ke=
y,
+                              const uint8_t *key,
                     =
          int handwindow,
                               bool pkt_is_ack)
 =
{
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 03e8=
930=2E=2E8203e4a 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl=
_pkt=2Eh
@@ -183,7 +183,7 @@
  * @return              the expected server s=
ession id
  */
 bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_s=
tate *state, const struct openvpn_sockaddr *from,
-                        =
           uint8_t *key, int handwindow, bool pkt_is_ack);
+               =
                    const uint8_t *key, int handwindow, bool pkt_is_ack);
 =

 /*
  * Write a control channel authentication record=2E
@@ -210,8 +210,9 =
@@
  * from the tls pre decrypt state=2E
  *
  */
-struct buffer tls_reset_=
standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-    =
                               struct session_id *own_sid, struct session_i=
d *remote_sid,
+struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx=
, const struct tls_auth_standalone *tas,
+                                 =
  const struct session_id *own_sid,
+                                   con=
st struct session_id *remote_sid,
                                    uint8=
_t header, bool request_resend_wkc);
 
 
diff --git a/src/openvpn/ssl_verif=
y=2Ec b/src/openvpn/ssl_verify=2Ec
index 063fa5d=2E=2E3304cb46 100644
--- a=
/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1139,7 +11=
39,7 @@
  * cache=2E
  */
 static bool
-tls_authentication_status_use_cache=
(struct tls_multi *multi)
+tls_authentication_status_use_cache(const struct=
 tls_multi *multi)
 {
     unsigned int idx =3D min_uint(multi->tas_cache_n=
um_updates, SIZE(cache_intervals) - 1);
     time_t latency =3D cache_inter=
vals[idx];
@@ -1283,7 +1283,7 @@
  * Check if the script/plugin left a mess=
age in the auth failed message
  * file and relay it to the user */
 static=
 void
-check_for_client_reason(struct tls_multi *multi, struct auth_deferre=
d_status *status)
+check_for_client_reason(struct tls_multi *multi, const s=
truct auth_deferred_status *status)
 {
     struct gc_arena gc =3D gc_new()=
;
     const char *msg =3D key_state_check_auth_failed_message_file(status,=
 &gc);
@@ -1552,7 +1552,7 @@
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 stati=
c bool
-set_verify_user_pass_env(struct user_pass *up, struct tls_multi *mu=
lti, struct tls_session *session)
+set_verify_user_pass_env(const struct us=
er_pass *up, struct tls_multi *multi, struct tls_session *session)
 {
     =
/* Is username defined? */
     if ((session->opt->ssl_flags & SSLF_AUTH_US=
ER_PASS_OPTIONAL) || strlen(up->username))
@@ -1580,7 +1580,7 @@
 }
 
 bool=

-ssl_verify_username_length(struct tls_session *session, const char *usern=
ame)
+ssl_verify_username_length(const struct tls_session *session, const c=
har *username)
 {
     if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMM=
ON_NAME)
         && strlen(username) > TLS_USERNAME_LEN)
diff --git a/src/=
openvpn/ssl_verify=2Eh b/src/openvpn/ssl_verify=2Eh
index 3176d76=2E=2Ee77b=
c4a 100644
--- a/src/openvpn/ssl_verify=2Eh
+++ b/src/openvpn/ssl_verify=2E=
h
@@ -202,7 +202,7 @@
  * @return              true if name is under limit =
or username-as-common-name
  *                      is not active
  */
-boo=
l ssl_verify_username_length(struct tls_session *session, const char *usern=
ame);
+bool ssl_verify_username_length(const struct tls_session *session, c=
onst char *username);
 
 /**
  * Runs the --client-crresponse script if one=
 is defined=2E
@@ -275,7 +275,7 @@
 void auth_set_client_reason(struct tls_=
multi *multi, const char *client_reason);
 
 static inline const char *
-tl=
s_client_reason(struct tls_multi *multi)
+tls_client_reason(const struct tl=
s_multi *multi)
 {
     return multi->client_reason;
 }
diff --git a/src/op=
envpn/status=2Ec b/src/openvpn/status=2Ec
index c7d375b=2E=2Ecfbc38d 100644=

--- a/src/openvpn/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ -135,7 +135,7=
 @@
 }
 
 void
-status_reset(struct status_output *so)
+status_reset(const =
struct status_output *so)
 {
     if (so && so->fd >=3D 0)
     {
diff --gi=
t a/src/openvpn/status=2Eh b/src/openvpn/status=2Eh
index 7953a4e=2E=2E4c01=
d75 100644
--- a/src/openvpn/status=2Eh
+++ b/src/openvpn/status=2Eh
@@ -69=
,7 +69,7 @@
 
 bool status_trigger(struct status_output *so);
 
-void statu=
s_reset(struct status_output *so);
+void status_reset(const struct status_o=
utput *so);
 
 void status_flush(struct status_output *so);
 
diff --git a/=
src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index af48921=2E=2Eabb46af 100644=

--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -835,7 +835,7 @@
  =
        const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 IPv6=
 */
          int ifconfig_ipv6_netbits_parm,
          const char *ifconfi=
g_ipv6_remote_parm,    /* --ifconfig parm 2 IPv6 */
-         struct addrin=
fo *local_public, struct addrinfo *remote_public, const bool strict_warn,
+=
         const struct addrinfo *local_public, const struct addrinfo *remote=
_public, const bool strict_warn,
          struct env_set *es, openvpn_net_=
ctx_t *ctx, struct tuntap *tt)
 {
     if (!tt)
@@ -978,7 +978,7 @@
  * -> =
helper function to simplify code below
  */
 static void
-add_route_connect=
ed_v6_net(struct tuntap *tt, const struct env_set *es)
+add_route_connected=
_v6_net(const struct tuntap *tt, const struct env_set *es)
 {
     struct r=
oute_ipv6 r6;
 
@@ -1020,7 +1020,7 @@
  */
 
 in_addr_t
-create_arbitrary_r=
emote(struct tuntap *tt)
+create_arbitrary_remote(const struct tuntap *tt)
=
 {
     in_addr_t remote;
 
@@ -1592,7 +1592,7 @@
 }
 
 static void
-undo_i=
fconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4=
(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LI=
NUX)
     int netbits =3D netmask_to_netbits2(tt->remote_netmask);
@@ -1627=
,7 +1627,7 @@
 }
 
 static void
-undo_ifconfig_ipv6(struct tuntap *tt, open=
vpn_net_ctx_t *ctx)
+undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_ne=
t_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     if (net_addr_v6_del(ctx, t=
t->actual_name, &tt->local_ipv6, tt->netbits_ipv6) < 0)
@@ -1652,7 +1652,7 =
@@
 }
 
 void
-undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+un=
do_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     if (tt=
->backend_driver !=3D DRIVER_NULL && tt->backend_driver !=3D DRIVER_AFUNIX)=

     {
@@ -1720,7 +1720,7 @@
 }
 
 static ssize_t
-write_tun_header(struct=
 tuntap *tt, uint8_t *buf, int len)
+write_tun_header(const struct tuntap *=
tt, const uint8_t *buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
=
     {
@@ -1737,9 +1737,11 @@
             type =3D htonl(AF_INET);
       =
  }
 
+        /* argument to writev is a pointer to const but we still nee=
d to drop
+         * the const from buf pointer here */
         iv[0]=2Ei=
ov_base =3D &type;
         iv[0]=2Eiov_len =3D sizeof(type);
-        iv[1=
]=2Eiov_base =3D buf;
+        iv[1]=2Eiov_base =3D (void *)buf;
         i=
v[1]=2Eiov_len =3D len;
 
         return header_modify_read_write_return(w=
ritev(tt->fd, iv, 2));
@@ -1751,7 +1753,7 @@
 }
 
 static ssize_t
-read_tun=
_header(struct tuntap *tt, uint8_t *buf, int len)
+read_tun_header(const st=
ruct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->type =3D=3D DEV_TYP=
E_TUN)
     {
@@ -1777,13 +1779,13 @@
  */
 #if !defined(TARGET_DARWIN)
 ss=
ize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const=
 struct tuntap *tt, const uint8_t *buf, int len)
 {
     return write_tun_h=
eader(tt, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *bu=
f, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
  =
   return read_tun_header(tt, buf, len);
 }
@@ -1799,7 +1801,7 @@
 
 #if de=
fined(TARGET_LINUX) || defined(TARGET_FREEBSD)
 static bool
-tun_dco_enable=
d(struct tuntap *tt)
+tun_dco_enabled(const struct tuntap *tt)
 {
     retu=
rn tt->backend_driver =3D=3D DRIVER_DCO;
 }
@@ -2046,13 +2048,13 @@
 }
 
 s=
size_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(cons=
t struct tuntap *tt, const uint8_t *buf, int len)
 {
     return write(tt->=
fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int=
 len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     ret=
urn read(tt->fd, buf, len);
 }
@@ -2251,13 +2253,13 @@
 }
 
 ssize_t
-write=
_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tunt=
ap *tt, const uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len)=
;
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_t=
un(const struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->=
fd, buf, len);
 }
@@ -2587,7 +2589,7 @@
 }
 
 ssize_t
-write_tun(struct tun=
tap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const u=
int8_t *buf, int len)
 {
     struct strbuf sbuf;
     sbuf=2Elen =3D len;
=
@@ -2596,7 +2598,7 @@
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *b=
uf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
 =
    struct strbuf sbuf;
     int f =3D 0;
@@ -3094,7 +3096,7 @@
 }
 
 ssize=
_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const st=
ruct tuntap *tt, const uint8_t *buf, int len)
 {
     if (tt->backend_drive=
r =3D=3D DRIVER_UTUN)
     {
@@ -3107,7 +3109,7 @@
 }
 
 ssize_t
-read_tun(=
struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt=
, uint8_t *buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)=

     {
@@ -3311,7 +3313,7 @@
 }
 
 int
-tun_write_queue(struct tuntap *tt,=
 struct buffer *buf)
+tun_write_queue(struct tuntap *tt, const struct buffe=
r *buf)
 {
     if (tt->writes=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
@@ =
-3366,7 +3368,7 @@
 }
 
 int
-tun_write_win32(struct tuntap *tt, struct buf=
fer *buf)
+tun_write_win32(struct tuntap *tt, const struct buffer *buf)
 {
=
     int err =3D 0;
     int status =3D 0;
@@ -5374,7 +5376,7 @@
 }
 
 void=

-fork_register_dns_action(struct tuntap *tt)
+fork_register_dns_action(con=
st struct tuntap *tt)
 {
     if (tt && tt->options=2Eregister_dns && tt->o=
ptions=2Emsg_channel)
     {
@@ -5464,7 +5466,7 @@
 }
 
 static void
-tunta=
p_get_mtu(struct tuntap *tt)
+tuntap_get_mtu(const struct tuntap *tt)
 {
  =
   ULONG mtu =3D 0;
     DWORD len;
@@ -6039,7 +6041,7 @@
 }
 
 void
-tun_s=
how_debug(struct tuntap *tt)
+tun_show_debug(const struct tuntap *tt)
 {
  =
   if (tt->backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)
     {
diff -=
-git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 931e54d=2E=2Ebeb0d0e=
 100644
--- a/src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -272,9 +272,=
9 @@
 
 void close_tun_handle(struct tuntap *tt);
 
-ssize_t write_tun(stru=
ct tuntap *tt, uint8_t *buf, int len);
+ssize_t write_tun(const struct tunt=
ap *tt, const uint8_t *buf, int len);
 
-ssize_t read_tun(struct tuntap *tt=
, uint8_t *buf, int len);
+ssize_t read_tun(const struct tuntap *tt, uint8_=
t *buf, int len);
 
 #ifdef ENABLE_FEATURE_TUN_PERSIST
 void tuncfg(const c=
har *dev, const char *dev_type, const char *dev_node, int persist_mode,
@@ =
-293,7 +293,7 @@
                         const char *ifconfig_ipv6_local_p=
arm,     /* --ifconfig parm 1 / IPv6 */
                         int ifconf=
ig_ipv6_netbits_parm,           /* --ifconfig parm 1 / bits */
            =
             const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2=
 / IPv6 */
-                        struct addrinfo *local_public, struct a=
ddrinfo *remote_public,
+                        const struct addrinfo *loc=
al_public, const struct addrinfo *remote_public,
                         c=
onst bool strict_warn, struct env_set *es, openvpn_net_ctx_t *ctx,
        =
                 struct tuntap *tt);
 
@@ -320,7 +320,7 @@
  * @param tt   =
 the tuntap interface context
  * @param ctx   the networking API opaque co=
ntext
  */
-void undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx);
=
+void undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
 bo=
ol is_dev_type(const char *dev, const char *dev_type, const char *match_typ=
e);
 
@@ -351,7 +351,7 @@
 #define IFCONFIG_DEFAULT IFCONFIG_AFTER_TUN_OPEN=

 
 static inline int
-ifconfig_order(struct tuntap *tt)
+ifconfig_order(co=
nst struct tuntap *tt)
 {
     if (tt->backend_driver =3D=3D DRIVER_AFUNIX)=

     {
@@ -381,7 +381,7 @@
 #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN
 
=
 static inline int
-route_order(struct tuntap *tt)
+route_order(const struc=
t tuntap *tt)
 {
     if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@=
@ -454,13 +454,13 @@
 
 const char *tap_win_getinfo(const struct tuntap *tt=
, struct gc_arena *gc);
 
-void tun_show_debug(struct tuntap *tt);
+void tu=
n_show_debug(const struct tuntap *tt);
 
 bool dhcp_release_by_adapter_inde=
x(const DWORD adapter_index);
 
 bool dhcp_renew_by_adapter_index(const DWO=
RD adapter_index);
 
-void fork_register_dns_action(struct tuntap *tt);
+vo=
id fork_register_dns_action(const struct tuntap *tt);
 
 void ipconfig_regi=
ster_dns(const struct env_set *es);
 
@@ -470,7 +470,7 @@
 
 int tun_read_q=
ueue(struct tuntap *tt, int maxsize);
 
-int tun_write_queue(struct tuntap =
*tt, struct buffer *buf);
+int tun_write_queue(struct tuntap *tt, const str=
uct buffer *buf);
 
 static inline bool
 tuntap_stop(int status)
@@ -499,7 =
+499,7 @@
     return false;
 }
 
-int tun_write_win32(struct tuntap *tt, s=
truct buffer *buf);
+int tun_write_win32(struct tuntap *tt, const struct bu=
ffer *buf);
 
 static inline bool
 is_ip_packet_valid(const struct buffer *=
buf)
@@ -529,13 +529,13 @@
 }
 
 static inline bool
-tuntap_is_dco_win(stru=
ct tuntap *tt)
+tuntap_is_dco_win(const struct tuntap *tt)
 {
     return t=
t && tt->backend_driver =3D=3D DRIVER_DCO;
 }
 
 static inline bool
-tuntap=
_is_dco_win_timeout(struct tuntap *tt, ssize_t status)
+tuntap_is_dco_win_t=
imeout(const struct tuntap *tt, ssize_t status)
 {
     return tuntap_is_dc=
o_win(tt) && (status < 0) && (openvpn_errno() =3D=3D ERROR_NETNAME_DELETED)=
;
 }
@@ -555,25 +555,25 @@
 }
 
 static inline void
-tun_standby_init(struc=
t tuntap *tt)
+tun_standby_init(const struct tuntap *tt)
 {
 }
 
 static in=
line bool
-tun_standby(struct tuntap *tt)
+tun_standby(const struct tuntap =
*tt)
 {
     return true;
 }
 
 
 static inline bool
-tuntap_is_dco_win(str=
uct tuntap *tt)
+tuntap_is_dco_win(const struct tuntap *tt)
 {
     return =
false;
 }
 
 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *t=
t, ssize_t status)
+tuntap_is_dco_win_timeout(const struct tuntap *tt, ssiz=
e_t status)
 {
     return false;
 }
diff --git a/src/openvpn/tun_afunix=2E=
c b/src/openvpn/tun_afunix=2Ec
index a67a472=2E=2Ee9223bc 100644
--- a/src/=
openvpn/tun_afunix=2Ec
+++ b/src/openvpn/tun_afunix=2Ec
@@ -48,7 +48,7 @@
 =

 
 static void
-tun_afunix_exec_child(const char *dev_node, struct tuntap =
*tt, struct env_set *env)
+tun_afunix_exec_child(const char *dev_node, stru=
ct tuntap *tt, const struct env_set *env)
 {
     const char *msgprefix =3D=
 "ERROR: failure executing process for tun:";
     struct argv argv =3D arg=
v_new();
@@ -73,7 +73,7 @@
 }
 
 void
-open_tun_afunix(struct options *o, i=
nt mtu, struct tuntap *tt, struct env_set *orig_env)
+open_tun_afunix(const=
 struct options *o, int mtu, struct tuntap *tt, const struct env_set *orig_=
env)
 {
     struct gc_arena gc =3D gc_new();
 
diff --git a/src/openvpn/tu=
n_afunix=2Eh b/src/openvpn/tun_afunix=2Eh
index 5b6a8e0=2E=2Efb88eb2 100644=

--- a/src/openvpn/tun_afunix=2Eh
+++ b/src/openvpn/tun_afunix=2Eh
@@ -31,7=
 +31,7 @@
  * the user provided taking care of implementing the actual tun
=
  * device=2E
  */
-void open_tun_afunix(struct options *o, int mtu, struct=
 tuntap *tt, struct env_set *env);
+void open_tun_afunix(const struct optio=
ns *o, int mtu, struct tuntap *tt, const struct env_set *env);
 
 
 /**
dif=
f --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec
index bffc60e=2E=2Ecd=
32a9b 100644
--- a/src/openvpn/vlan=2Ec
+++ b/src/openvpn/vlan=2Ec
@@ -288,=
7 +288,7 @@
 }
 
 void
-vlan_process_outgoing_tun(struct multi_context *m, =
struct multi_instance *mi)
+vlan_process_outgoing_tun(const struct multi_co=
ntext *m, struct multi_instance *mi)
 {
     if (!m->top=2Eoptions=2Evlan_t=
agging)
     {
diff --git a/src/openvpn/vlan=2Eh b/src/openvpn/vlan=2Eh
ind=
ex 9389f89=2E=2Ecd2f66f 100644
--- a/src/openvpn/vlan=2Eh
+++ b/src/openvpn=
/vlan=2Eh
@@ -35,6 +35,6 @@
 
 bool vlan_is_tagged(const struct buffer *buf=
);
 
-void vlan_process_outgoing_tun(struct multi_context *m, struct multi_=
instance *mi);
+void vlan_process_outgoing_tun(const struct multi_context *=
m, struct multi_instance *mi);
 
 #endif /* VLAN_H */
diff --git a/src/open=
vpn/win32=2Eh b/src/openvpn/win32=2Eh
index ef32062=2E=2Ebcbfa67 100644
---=
 a/src/openvpn/win32=2Eh
+++ b/src/openvpn/win32=2Eh
@@ -226,7 +226,7 @@
 v=
oid overlapped_io_close(struct overlapped_io *o);
 
 static inline bool
-ov=
erlapped_io_active(struct overlapped_io *o)
+overlapped_io_active(const str=
uct overlapped_io *o)
 {
     return o->iostate =3D=3D IOSTATE_QUEUED || o-=
>iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;
 }
diff --git a/src/openvpnmsica/=
openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index a861e8a=2E=2E25f=
a1e4 100644
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/openvpnmsica/=
openvpnmsica=2Ec
@@ -77,7 +77,7 @@
  * @return ERROR_SUCCESS on success; An=
 error code otherwise
  */
 static UINT
-setup_sequence(_In_ MSIHANDLE hIns=
tall, _In_z_ LPCWSTR szProperty, _In_ struct msica_arg_seq *seq)
+setup_seq=
uence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ const struct=
 msica_arg_seq *seq)
 {
     UINT uiResult;
     LPWSTR szSequence =3D msic=
a_arg_seq_join(seq);
diff --git a/src/openvpnserv/interactive=2Ec b/src/ope=
nvpnserv/interactive=2Ec
index a9e9665=2E=2E36c2847 100644
--- a/src/openvp=
nserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -522,7 +522,=
7 @@
 
 
 static SOCKADDR_INET
-sockaddr_inet(short family, inet_address_t =
*addr)
+sockaddr_inet(short family, const inet_address_t *addr)
 {
     SOC=
KADDR_INET sa_inet;
     ZeroMemory(&sa_inet, sizeof(sa_inet));
@@ -3841,7 =
+3841,7 @@
 
 static DWORD
 UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWOR=
D count, HANDLE io_event, HANDLE exit_event,
-                  list_item_t=
 *threads)
+                  const list_item_t *threads)
 {
     static DW=
ORD size =3D 10;
     static LPHANDLE handles =3D NULL;
diff --git a/tests/=
unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_mana=
gement=2Ec
index 77f6ce2=2E=2Efff4c2b 100644
--- a/tests/unit_tests/openvpn=
/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ =
-36,7 +36,7 @@
 struct management *management; /* GLOBAL */
 
 void
-manage=
ment_auth_failure(struct management *man, const char *type, const char *rea=
son)
+management_auth_failure(const struct management *man, const char *typ=
e, const char *reason)
 {
     ASSERT(false);
 }
diff --git a/tests/unit_te=
sts/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index a4=
1c27b=2E=2Ea8daee6 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ =
b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -146,7 +146,7 @@
 }
 
 static s=
truct hash_element *
-hash_lookup_by_value(struct hash *hash, void *value)
=
+hash_lookup_by_value(struct hash *hash, const void *value)
 {
     struct =
hash_iterator hi;
     struct hash_element *he;
diff --git a/tests/unit_tes=
ts/openvpn/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec=

index c0a0866=2E=2E7636a33 100644
--- a/tests/unit_tests/openvpn/test_user=
_pass=2Ec
+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec
@@ -59,7 +59,7 =
@@
     return mock();
 }
 void
-management_auth_failure(struct management =
*man, const char *type, const char *reason)
+management_auth_failure(const =
struct management *man, const char *type, const char *reason)
 {
     asser=
t_true(0);
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1663?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I56=
248cf6d199c2da770774b8fd1e5daf2b116f58
Gerrit-Change-Number: 1663
Gerrit-Pa=
tchSet: 17
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>

--9TGs8R1Fn5g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #17</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
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
envpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/multi_io=2Ec<br=
>M src/openvpn/networking=2Eh<br>M src/openvpn/networking_iproute2=2Ec<br>M=
 src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/occ=2Eh<br>M src/openvpn=
/openssl_compat=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options_p=
arse=2Ec<br>M src/openvpn/otime=2Ec<br>M src/openvpn/otime=2Eh<br>M src/ope=
nvpn/proto=2Eh<br>M src/openvpn/proxy=2Ec<br>M src/openvpn/proxy=2Eh<br>M s=
rc/openvpn/ps=2Ec<br>M src/openvpn/ps=2Eh<br>M src/openvpn/push=2Ec<br>M sr=
c/openvpn/push=2Eh<br>M src/openvpn/push_util=2Ec<br>M src/openvpn/reliable=
=2Ec<br>M src/openvpn/reliable=2Eh<br>M src/openvpn/route=2Ec<br>M src/open=
vpn/schedule=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br=
>M src/openvpn/socket_util=2Eh<br>M src/openvpn/socks=2Ec<br>M src/openvpn/=
socks=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=2Eh<br>M src/openvp=
n/ssl_backend=2Eh<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_ope=
nssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M src=
/openvpn/ssl_verify=2Ec<br>M src/openvpn/ssl_verify=2Eh<br>M src/openvpn/st=
atus=2Ec<br>M src/openvpn/status=2Eh<br>M src/openvpn/tun=2Ec<br>M src/open=
vpn/tun=2Eh<br>M src/openvpn/tun_afunix=2Ec<br>M src/openvpn/tun_afunix=2Eh=
<br>M src/openvpn/vlan=2Ec<br>M src/openvpn/vlan=2Eh<br>M src/openvpn/win32=
=2Eh<br>M src/openvpnmsica/openvpnmsica=2Ec<br>M src/openvpnserv/interactiv=
e=2Ec<br>M tests/unit_tests/openvpn/mock_management=2Ec<br>M tests/unit_tes=
ts/openvpn/test_misc=2Ec<br>M tests/unit_tests/openvpn/test_user_pass=2Ec<b=
r>89 files changed, 355 insertions(+), 304 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63=
/1663/17</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cp=
pcheck-suppression</span><br><span>index 2a3cf2e=2E=2E8736c2f 100644</span>=
<br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b/dev-to=
ols/cppcheck-suppression</span><br><span>@@ -2,7 +2,6 @@</span><br><span> #=
 occurences right now=2E They still should be fixed at some point</span><br=
><span> constParameter</span><br><span> constParameterCallback</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-constParameterPointer</span><br><s=
pan> invalidPrintfArgType_sint</span><br><span> invalidPrintfArgType_uint</=
span><br><span> unusedFunction</span><br><span>@@ -27,13 +26,48 @@</span><b=
r><span> # FP: posix=2Ecfg claims suseconds_t is unsigned for some reason</=
span><br><span> unsignedLessThanZero:src/openvpn/otime=2Eh:148</span><br><s=
pan> # IGN: multi code does weird things with pointers to local variables=
=2E=2E=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-autoVariable=
s:src/openvpn/multi=2Ec:4232</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+autoVariables:src/openvpn/multi=2Ec:4233</span><br><span> autoVari=
ables:src/openvpn/multi_io=2Ec:324</span><br><span> # IGN: the code header =
=3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is used intentionally</span><br><s=
pan> badBitmaskCheck:src/openvpn/mudp=2Ec</span><br><span> badBitmaskCheck:=
tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span> # IGN: we store inte=
gers in pointers</span><br><span> CastAddressToIntegerAtReturn:src/openvpn/=
multi=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: ext=
ernal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameter=
Pointer:/usr/include/*</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# IGN: test files provide mocks/stubs that match prototypes from headers=
 exactly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParame=
terPointer:tests/unit_tests/openvpn/mock_*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+constParameterPointer:tests/unit_tests/openvpn/test_=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPoin=
ter:tests/unit_tests/openvpnserv/test_*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# FP: different crypto implementations but same API</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:s=
rc/openvpn/crypto_mbedtls_legacy=2Ec:85</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+constParameterPointer:src/openvpn/crypto_openssl=2Ec:17=
3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPoin=
ter:src/openvpn/crypto_openssl=2Ec:1433</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+constParameterPointer:src/openvpn/cryptoapi=2Ec:58</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:sr=
c/openvpn/ssl_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+constParameterPointer:src/openvpn/ssl_openssl=2Ec</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/ssl_v=
erify_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
nstParameterPointer:tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# IGN: too many different impl=
ementations, not worth it</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+constParameterPointer:src/openvpn/dco*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/socket=2E*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: parameters are modi=
fied on some platform only</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+constParameterPointer:src/openvpn/dns=2Ec:859</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/error=
=2Ec:223</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParame=
terPointer:src/openvpn/forward=2Ec:1245</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+constParameterPointer:src/openvpn/manage=2Ec:344</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/=
openvpn/manage=2Ec:3332</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+constParameterPointer:src/openvpn/misc=2Ec:793</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/misc=2Ec:8=
13</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPoi=
nter:src/openvpn/options=2Ec:3205</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+constParameterPointer:src/openvpn/route=2Ec:3947</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvp=
n/tun=2Ec:560</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constP=
arameterPointer:src/openvpn/tun=2Ec:2188</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+constParameterPointer:src/openvpn/tun_afunix=2Ec</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: not a FP but the d=
ocumentation for the FP_ISSET claims this is not const=2E=2E=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openv=
pn/event=2Ec:1015</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
IGN: fun:check_malloc_return: causes -Wmaybe-uninitialized in MinGW Debug b=
uild</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterP=
ointer:src/openvpn/buffer=2Eh:2082</span><br><span> # IGN: Windows specific=
 (unsigned long =3D=3D unsigned int)</span><br><span> compareValueOutOfType=
RangeError:src/openvpn/ssl_verify=2Ec:928</span><br><span> # FP: cppcheck s=
eems to have wrong signature of DeviceIoControl()</span><br><span>diff --gi=
t a/sample/sample-plugins/client-connect/sample-client-connect=2Ec b/sample=
/sample-plugins/client-connect/sample-client-connect=2Ec</span><br><span>in=
dex 420de61=2E=2Ecbd98e8 100644</span><br><span>--- a/sample/sample-plugins=
/client-connect/sample-client-connect=2Ec</span><br><span>+++ b/sample/samp=
le-plugins/client-connect/sample-client-connect=2Ec</span><br><span>@@ -344=
,7 +344,7 @@</span><br><span> }</span><br><span> </span><br><span> int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn_plugin_client_conn=
ect(struct plugin_context *context, const char **argv, const char **envp)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_client=
_connect(const struct plugin_context *context, const char **argv, const cha=
r **envp)</span><br><span> {</span><br><span>     /* log environment variab=
les handed to us by OpenVPN, but</span><br><span>      * only if &quot;sete=
nv verb&quot; is 3 or higher (arbitrary number)</span><br><span>@@ -465,7 +=
465,7 @@</span><br><span> </span><br><span> int</span><br><span> openvpn_pl=
ugin_client_connect_defer_v2(struct plugin_context *context,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
   struct plugin_per_client_context *pcc,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                       const struct p=
lugin_per_client_context *pcc,</span><br><span>                            =
            struct openvpn_plugin_string_list **return_list)</span><br><spa=
n> {</span><br><span>     time_t time_left =3D pcc-&gt;sleep_until - time(N=
ULL);</span><br><span>diff --git a/sample/sample-plugins/defer/multi-auth=
=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec</span><br><span>index bac=
f557=2E=2Ecdd616f 100644</span><br><span>--- a/sample/sample-plugins/defer/=
multi-auth=2Ec</span><br><span>+++ b/sample/sample-plugins/defer/multi-auth=
=2Ec</span><br><span>@@ -255,7 +255,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-do_auth_user_pass(struct plugin_context *context, const char *use=
rname, const char *password)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+do_auth_user_pass(const struct plugin_context *context, const char=
 *username, const char *password)</span><br><span> {</span><br><span>     p=
log(context, PLOG_NOTE, &quot;expect_user=3D%s, received_user=3D%s, expect_=
passw=3D%s, received_passw=3D%s&quot;,</span><br><span>          np(context=
-&gt;test_valid_user), np(username), np(context-&gt;test_valid_pass), np(pa=
ssword));</span><br><span>@@ -279,7 +279,7 @@</span><br><span> </span><br><=
span> </span><br><span> static int</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-auth_user_pass_verify(struct plugin_context *context, struct p=
lugin_per_client_context *pcc,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+auth_user_pass_verify(const struct plugin_context *context, stru=
ct plugin_per_client_context *pcc,</span><br><span>                       c=
onst char *argv[], const char *envp[])</span><br><span> {</span><br><span> =
    /* get username/password from envp string array */</span><br><span>diff=
 --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterial=
exporter=2Ec b/sample/sample-plugins/keying-material-exporter-demo/keyingma=
terialexporter=2Ec</span><br><span>index 25c9ff5=2E=2E512861a 100644</span>=
<br><span>--- a/sample/sample-plugins/keying-material-exporter-demo/keyingm=
aterialexporter=2Ec</span><br><span>+++ b/sample/sample-plugins/keying-mate=
rial-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>@@ -186,7 +18=
6,7 @@</span><br><span> }</span><br><span> </span><br><span> static void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-file_store(char *file, c=
har *content)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+file_s=
tore(const char *file, const char *content)</span><br><span> {</span><br><s=
pan>     FILE *f;</span><br><span>     if (!(f =3D fopen(file, &quot;w+&quo=
t;)))</span><br><span>@@ -202,7 +202,7 @@</span><br><span> server_store(str=
uct openvpn_plugin_args_func_in const *args)</span><br><span> {</span><br><=
span>     struct plugin *plugin =3D (struct plugin *)args-&gt;handle;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct session *sess =
=3D (struct session *)args-&gt;per_client_context;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const struct session *sess =3D (struct s=
ession *)args-&gt;per_client_context;</span><br><span> </span><br><span>   =
  char file[MAXPATH];</span><br><span>     snprintf(file, sizeof(file) - 1,=
 &quot;/tmp/openvpn_sso_%s&quot;, sess-&gt;key);</span><br><span>@@ -214,7 =
+214,7 @@</span><br><span> client_store(struct openvpn_plugin_args_func_in =
const *args)</span><br><span> {</span><br><span>     struct plugin *plugin =
=3D (struct plugin *)args-&gt;handle;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct session *sess =3D (struct session *)args-&gt;per=
_client_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const struct session *sess =3D (struct session *)args-&gt;per_client_conte=
xt;</span><br><span> </span><br><span>     char *file =3D &quot;/tmp/openvp=
n_sso_user&quot;;</span><br><span>     ovpn_note(&quot;app session file: %s=
&quot;, file);</span><br><span>diff --git a/src/openvpn/buffer=2Ec b/src/op=
envpn/buffer=2Ec</span><br><span>index 046e231=2E=2Ea004b60 100644</span><b=
r><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buff=
er=2Ec</span><br><span>@@ -270,7 +270,7 @@</span><br><span>  * truncated by=
 buf_printf</span><br><span>  */</span><br><span> void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-buf_catrunc(struct buffer *buf, const char=
 *str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_catrunc(c=
onst struct buffer *buf, const char *str)</span><br><span> {</span><br><spa=
n>     if (buf_forward_capacity(buf) &lt;=3D 1)</span><br><span>     {</spa=
n><br><span>@@ -1035,7 +1035,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stri=
ng_check_buf(struct buffer *buf, const unsigned int inclusive, const unsign=
ed int exclusive)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
ring_check_buf(const struct buffer *buf, const unsigned int inclusive, cons=
t unsigned int exclusive)</span><br><span> {</span><br><span>     ASSERT(bu=
f);</span><br><span> </span><br><span>diff --git a/src/openvpn/buffer=2Eh b=
/src/openvpn/buffer=2Eh</span><br><span>index bc5cffb=2E=2E5cf834f 100644</=
span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openv=
pn/buffer=2Eh</span><br><span>@@ -853,7 +853,7 @@</span><br><span>  * @para=
m buf   The buffer to append the truncation marker to=2E</span><br><span>  =
* @param str   The null-terminated marker string to write=2E</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void buf_catrun=
c(struct buffer *buf, const char *str);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void buf_catrunc(const struct buffer *buf, const char *=
str);</span><br><span> </span><br><span> /**</span><br><span>  * Extract th=
e next token from a buffer, delimited by a given character=2E</span><br><sp=
an>@@ -1427,7 +1427,7 @@</span><br><span>  *         is empty=2E</span><br>=
<span>  */</span><br><span> static inline int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-buf_peek_u8(struct buffer *buf)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+buf_peek_u8(const struct buffer *buf)</=
span><br><span> {</span><br><span>     int ret;</span><br><span>     if (BL=
EN(buf) &lt; 1)</span><br><span>@@ -1720,7 +1720,7 @@</span><br><span>  * @=
param exclusive Character classes that are not allowed even if they are als=
o in inclusive=2E</span><br><span>  * @return True if the string consists o=
nly of allowed characters, false otherwise=2E</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool string_check_buf(struct b=
uffer *buf, const unsigned int inclusive,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool string_check_buf(const struct buffer *buf, const=
 unsigned int inclusive,</span><br><span>                       const unsig=
ned int exclusive);</span><br><span> </span><br><span> /**</span><br><span>=
@@ -1856,7 +1856,7 @@</span><br><span>  * @param a  The arena to test=2E</s=
pan><br><span>  */</span><br><span> static inline bool</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-gc_defined(struct gc_arena *a)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+gc_defined(const struct gc_aren=
a *a)</span><br><span> {</span><br><span>     return a-&gt;list !=3D NULL;<=
/span><br><span> }</span><br><span>diff --git a/src/openvpn/clinat=2Ec b/sr=
c/openvpn/clinat=2Ec</span><br><span>index 3724022=2E=2Ed03f9f2 100644</spa=
n><br><span>--- a/src/openvpn/clinat=2Ec</span><br><span>+++ b/src/openvpn/=
clinat=2Ec</span><br><span>@@ -159,7 +159,7 @@</span><br><span> #endif</spa=
n><br><span> </span><br><span> static void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-print_pkt(struct openvpn_iphdr *iph, const char *prefi=
x, const int direction, const msglvl_t msglevel)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+print_pkt(const struct openvpn_iphdr *iph, con=
st char *prefix, const int direction, const msglvl_t msglevel)</span><br><s=
pan> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><spa=
n> </span><br><span>@@ -181,7 +181,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-client_nat_transform(const struct client_nat_option_list *list, struct bu=
ffer *ipbuf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+client_=
nat_transform(const struct client_nat_option_list *list, const struct buffe=
r *ipbuf,</span><br><span>                      const int direction)</span>=
<br><span> {</span><br><span>     struct ip_tcp_udp_hdr *h =3D (struct ip_t=
cp_udp_hdr *)BPTR(ipbuf);</span><br><span>diff --git a/src/openvpn/clinat=
=2Eh b/src/openvpn/clinat=2Eh</span><br><span>index 1e8ceb3=2E=2Ebc56037 10=
0644</span><br><span>--- a/src/openvpn/clinat=2Eh</span><br><span>+++ b/src=
/openvpn/clinat=2Eh</span><br><span>@@ -60,7 +60,7 @@</span><br><span>     =
                               const char *network, const char *netmask,</s=
pan><br><span>                                    const char *foreign_netwo=
rk, msglvl_t msglevel);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-void client_nat_transform(const struct client_nat_optio=
n_list *list, struct buffer *ipbuf,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void client_nat_transform(const struct client_nat_option_li=
st *list, const struct buffer *ipbuf,</span><br><span>                     =
      const int direction);</span><br><span> </span><br><span> #endif /* if=
 !defined(CLINAT_H) */</span><br><span>diff --git a/src/openvpn/comp=2Ec b/=
src/openvpn/comp=2Ec</span><br><span>index b88b79f=2E=2E387a7c4 100644</spa=
n><br><span>--- a/src/openvpn/comp=2Ec</span><br><span>+++ b/src/openvpn/co=
mp=2Ec</span><br><span>@@ -159,7 +159,7 @@</span><br><span> #endif /* USE_C=
OMP */</span><br><span> </span><br><span> bool</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-check_compression_settings_valid(struct compress_o=
ptions *info, msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+check_compression_settings_valid(const struct compress_options=
 *info, msglvl_t msglevel)</span><br><span> {</span><br><span>     /*</span=
><br><span>      * We also allow comp-stub-v2 here as it technically allows=
 escaping of</span><br><span>diff --git a/src/openvpn/comp=2Eh b/src/openvp=
n/comp=2Eh</span><br><span>index 29a90a2=2E=2Ead80243 100644</span><br><spa=
n>--- a/src/openvpn/comp=2Eh</span><br><span>+++ b/src/openvpn/comp=2Eh</sp=
an><br><span>@@ -91,7 +91,7 @@</span><br><span>  * flags of allow-compressi=
on and also the whether algorithms are compiled</span><br><span>  * in</spa=
n><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool =
check_compression_settings_valid(struct compress_options *info, msglvl_t ms=
glevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_=
compression_settings_valid(const struct compress_options *info, msglvl_t ms=
glevel);</span><br><span> </span><br><span> #ifdef USE_COMP</span><br><span=
> #include &quot;buffer=2Eh&quot;</span><br><span>diff --git a/src/openvpn/=
crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index e5ad31a=2E=2Ee29d=
581 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++=
 b/src/openvpn/crypto=2Ec</span><br><span>@@ -1105,7 +1105,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static bool</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-key_is_zero(struct key *key, const struct =
key_type *kt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key_is=
_zero(const struct key *key, const struct key_type *kt)</span><br><span> {<=
/span><br><span>     size_t cipher_length =3D cipher_kt_key_size(kt-&gt;cip=
her);</span><br><span>     for (size_t i =3D 0; i &lt; cipher_length; ++i)<=
/span><br><span>@@ -1123,7 +1123,7 @@</span><br><span>  * Make sure that ci=
pher key is a valid key for current key_type=2E</span><br><span>  */</span>=
<br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_=
key(struct key *key, const struct key_type *kt)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+check_key(const struct key *key, const struct k=
ey_type *kt)</span><br><span> {</span><br><span>     if (cipher_defined(kt-=
&gt;cipher))</span><br><span>     {</span><br><span>@@ -1196,7 +1196,7 @@</=
span><br><span> }</span><br><span> </span><br><span> void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-test_crypto(struct crypto_options *co, =
struct frame *frame)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_crypto(struct crypto_options *co, const struct frame *frame)</span><b=
r><span> {</span><br><span>     int i, j;</span><br><span>     struct gc_ar=
ena gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/crypto=2Eh b/=
src/openvpn/crypto=2Eh</span><br><span>index ee5b50f=2E=2Ee3c1c6a 100644</s=
pan><br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvp=
n/crypto=2Eh</span><br><span>@@ -414,7 +414,7 @@</span><br><span>  */</span=
><br><span> int write_key_file(const int nkeys, const char *filename);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool che=
ck_key(struct key *key, const struct key_type *kt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool check_key(const struct key *key, con=
st struct key_type *kt);</span><br><span> </span><br><span> /**</span><br><=
span>  * Initialize a key_type structure with=2E</span><br><span>@@ -614,7 =
+614,7 @@</span><br><span> /** Print a cipher list entry */</span><br><span=
> void print_cipher(const char *cipher);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void test_crypto(struct crypto_options=
 *co, struct frame *f);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void test_crypto(struct crypto_options *co, const struct frame *f);</sp=
an><br><span> </span><br><span> </span><br><span> /* key direction function=
s */</span><br><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec=
</span><br><span>index 8eae4bf=2E=2E3bf1fb2 100644</span><br><span>--- a/sr=
c/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span=
>@@ -573,7 +573,7 @@</span><br><span> }</span><br><span> </span><br><span> =
static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_multi_=
get_localaddr(struct multi_context *m, struct multi_instance *mi,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_get_localaddr(const=
 struct multi_context *m, const struct multi_instance *mi,</span><br><span>=
                         struct sockaddr_storage *local)</span><br><span> {=
</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span>@@ -585,7 +585,7 @@=
</span><br><span>         return false;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_=
socket_actual *actual =3D &amp;c-&gt;c2=2Elink_socket_infos[0]-&gt;lsa-&gt;=
actual;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const st=
ruct link_socket_actual *actual =3D &amp;c-&gt;c2=2Elink_socket_infos[0]-&g=
t;lsa-&gt;actual;</span><br><span> </span><br><span>     switch (actual-&gt=
;dest=2Eaddr=2Esa=2Esa_family)</span><br><span>     {</span><br><span>@@ -6=
23,7 +623,7 @@</span><br><span> }</span><br><span> </span><br><span> int</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_multi_add_new_peer(s=
truct multi_context *m, struct multi_instance *mi)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+dco_multi_add_new_peer(const struct multi_co=
ntext *m, struct multi_instance *mi)</span><br><span> {</span><br><span>   =
  const struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span>=
<br><span>@@ -677,7 +677,7 @@</span><br><span> }</span><br><span> </span><b=
r><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_inst=
all_iroute(struct multi_context *m, struct multi_instance *mi, struct mrout=
e_addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_in=
stall_iroute(struct multi_context *m, struct multi_instance *mi, const stru=
ct mroute_addr *addr)</span><br><span> {</span><br><span> #if defined(TARGE=
T_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br><span>    =
 if (!dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span>@@ -796,7 +796=
,7 @@</span><br><span>         /* Checked if we added a host route as the a=
ssigned client IP address was</span><br><span>          * outside the --ifc=
onfig-ipv6 tun interface config */</span><br><span> #if !defined(_WIN32)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct in6_addr =
*dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        const struct in6_addr *d=
est =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><spa=
n>         if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest))</span>=
<br><span>         {</span><br><span>             /* On windows we do not i=
nstall these routes, so we also do not need to delete them */</span><br><sp=
an>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh</span><br><span>i=
ndex 4e5aad5=2E=2E694875c 100644</span><br><span>--- a/src/openvpn/dco=2Eh<=
/span><br><span>+++ b/src/openvpn/dco=2Eh</span><br><span>@@ -204,7 +204,7 =
@@</span><br><span>  * @param mi        the client instance</span><br><span=
>  * @return          0 on success or a negative error code otherwise</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dc=
o_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_multi_add_new=
_peer(const struct multi_context *m, struct multi_instance *mi);</span><br>=
<span> </span><br><span> /**</span><br><span>  * Install an iroute in DCO, =
which means adding a route to the system routing</span><br><span>@@ -215,7 =
+215,7 @@</span><br><span>  * @param addr      the route to add</span><br><=
span>  */</span><br><span> void dco_install_iroute(struct multi_context *m,=
 struct multi_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                        struct mroute_addr *addr);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        const struct m=
route_addr *addr);</span><br><span> </span><br><span> /**</span><br><span> =
 * Remove all routes added through the specified client</span><br><span>@@ =
-253,7 +253,7 @@</span><br><span>  * a 64 bit packet counter and AEAD tag a=
t the end=2E</span><br><span>  */</span><br><span> bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct context *c=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoc=
h_data(const struct context *c);</span><br><span> #else  /* if defined(ENAB=
LE_DCO) */</span><br><span> </span><br><span> typedef void *dco_context_t;<=
/span><br><span>@@ -350,7 +350,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static inline int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-dco_multi_add_new_peer(struct multi_context *m, struct multi_ins=
tance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi=
_add_new_peer(const struct multi_context *m, struct multi_instance *mi)</sp=
an><br><span> {</span><br><span>     return 0;</span><br><span> }</span><br=
><span>@@ -384,7 +384,7 @@</span><br><span> }</span><br><span> </span><br><=
span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-dco_supports_epoch_data(struct context *c)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct context *c)<=
/span><br><span> {</span><br><span>     return false;</span><br><span> }</s=
pan><br><span>diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_fr=
eebsd=2Ec</span><br><span>index d933aaf=2E=2E7346903 100644</span><br><span=
>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>+++ b/src/openvpn/dco_fr=
eebsd=2Ec</span><br><span>@@ -930,7 +930,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-dco_supports_epoch_data(struct context *c)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct context=
 *c)</span><br><span> {</span><br><span>     return false;</span><br><span>=
 }</span><br><span>diff --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/=
dco_internal=2Eh</span><br><span>index fcf8aca=2E=2E1022e66 100644</span><b=
r><span>--- a/src/openvpn/dco_internal=2Eh</span><br><span>+++ b/src/openvp=
n/dco_internal=2Eh</span><br><span>@@ -59,8 +59,9 @@</span><br><span>  * Th=
ey are implemented by dco_linux=2Ec</span><br><span>  */</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco_new_peer(dco_c=
ontext_t *dco, unsigned int peerid, socket_descriptor_t sd, struct sockaddr=
 *localaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
        struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4, const =
struct in6_addr *vpn_ipv6);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_de=
scriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
            struct sockaddr *localaddr, struct sockaddr *remoteaddr,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 const str=
uct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);</span><br><span> <=
/span><br><span> int dco_del_peer(dco_context_t *dco, unsigned int peerid);=
</span><br><span> </span><br><span>diff --git a/src/openvpn/dco_linux=2Ec b=
/src/openvpn/dco_linux=2Ec</span><br><span>index 56f6259=2E=2E31bbe87 10064=
4</span><br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src=
/openvpn/dco_linux=2Ec</span><br><span>@@ -114,7 +114,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> static struct nl_msg *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_nlmsg_create(dco_context_t =
*dco, uint8_t cmd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+o=
vpn_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)</span><br><span=
> {</span><br><span>     struct nl_msg *nl_msg =3D nlmsg_alloc();</span><br=
><span>     if (!nl_msg)</span><br><span>@@ -804,7 +804,7 @@</span><br><spa=
n> </span><br><span> /* libnl &lt; 3=2E11=2E0 does not implement nla_get_ui=
nt() */</span><br><span> static uint64_t</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-ovpn_nla_get_uint(struct nlattr *attr)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ovpn_nla_get_uint(const struct nlattr=
 *attr)</span><br><span> {</span><br><span>     if (nla_len(attr) =3D=3D si=
zeof(uint32_t))</span><br><span>     {</span><br><span>@@ -916,7 +916,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> static bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_iface_check(dco_context_t =
*dco, struct nlattr *attrs[])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ovpn_iface_check(const dco_context_t *dco, struct nlattr *attrs[]=
)</span><br><span> {</span><br><span>     /* we must know which interface t=
his message is referring to in order to</span><br><span>      * avoid mixin=
g messages for other instances</span><br><span>@@ -1340,7 +1340,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct context *c)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_d=
ata(const struct context *c)</span><br><span> {</span><br><span>     return=
 false;</span><br><span> }</span><br><span>diff --git a/src/openvpn/dco_win=
=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index b3268bc=2E=2E8deb9d8 1=
00644</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/s=
rc/openvpn/dco_win=2Ec</span><br><span>@@ -1100,7 +1100,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct context *c)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const=
 struct context *c)</span><br><span> {</span><br><span>     OVPN_VERSION ve=
r =3D { 0 };</span><br><span>     return dco_get_version(&amp;ver) &amp;&am=
p; ((ver=2EMajor =3D=3D 2 &amp;&amp; ver=2EMinor &gt;=3D 8) || (ver=2EMajor=
 &gt; 2));</span><br><span>diff --git a/src/openvpn/dhcp=2Ec b/src/openvpn/=
dhcp=2Ec</span><br><span>index a54ab3f=2E=2E68173e6 100644</span><br><span>=
--- a/src/openvpn/dhcp=2Ec</span><br><span>+++ b/src/openvpn/dhcp=2Ec</span=
><br><span>@@ -145,7 +145,7 @@</span><br><span> }</span><br><span> </span><=
br><span> in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dh=
cp_extract_router_msg(struct buffer *ipbuf)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+dhcp_extract_router_msg(const struct buffer *ipbuf)=
</span><br><span> {</span><br><span>     struct dhcp_full *df =3D (struct d=
hcp_full *)BPTR(ipbuf);</span><br><span>     const int optlen =3D</span><br=
><span>diff --git a/src/openvpn/dhcp=2Eh b/src/openvpn/dhcp=2Eh</span><br><=
span>index 38ebf8d=2E=2Eed8a0c9 100644</span><br><span>--- a/src/openvpn/dh=
cp=2Eh</span><br><span>+++ b/src/openvpn/dhcp=2Eh</span><br><span>@@ -91,7 =
+91,7 @@</span><br><span> </span><br><span> #pragma pack()</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-in_addr_t dhcp_extra=
ct_router_msg(struct buffer *ipbuf);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+in_addr_t dhcp_extract_router_msg(const struct buffer *ipb=
uf);</span><br><span> </span><br><span> #if defined(_WIN32) || defined(DHCP=
_UNIT_TEST)</span><br><span> #include &quot;tun=2Eh&quot;</span><br><span>d=
iff --git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh</span><br><span>i=
ndex b784dfe=2E=2E0940a1d 100644</span><br><span>--- a/src/openvpn/event=2E=
h</span><br><span>+++ b/src/openvpn/event=2Eh</span><br><span>@@ -204,7 +20=
4,7 @@</span><br><span> #else /* ifdef _WIN32 */</span><br><span> </span><b=
r><span> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-wait_signal(struct event_set *es, void *arg)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+wait_signal(const struct event_set *es, cons=
t void *arg)</span><br><span> {</span><br><span> }</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</s=
pan><br><span>index 6581998=2E=2E4ddac11 100644</span><br><span>--- a/src/o=
penvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br>=
<span>@@ -231,7 +231,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-parse=
_incoming_control_channel_command(struct context *c, struct buffer *buf)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_incoming_control=
_channel_command(struct context *c, const struct buffer *buf)</span><br><sp=
an> {</span><br><span>     if (buf_string_match_head_str(buf, &quot;AUTH_FA=
ILED&quot;))</span><br><span>     {</span><br><span>@@ -501,7 +501,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-get_server_poll_remaining_time(struct even=
t_timeout *server_poll_timeout)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+get_server_poll_remaining_time(const struct event_timeout *serv=
er_poll_timeout)</span><br><span> {</span><br><span>     update_time();</sp=
an><br><span>     int remaining =3D event_timeout_remaining(server_poll_tim=
eout);</span><br><span>@@ -598,7 +598,7 @@</span><br><span>  * Buffer reall=
ocation, for use with null encryption=2E</span><br><span>  */</span><br><sp=
an> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-buffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, struct =
buffer *src_stub,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bu=
ffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, const stru=
ct buffer *src_stub,</span><br><span>                 struct buffer *storag=
e)</span><br><span> {</span><br><span>     if (orig_buf =3D=3D src_stub-&gt=
;data &amp;&amp; src_stub-&gt;data !=3D storage-&gt;data)</span><br><span>@=
@ -885,7 +885,7 @@</span><br><span>  */</span><br><span> </span><br><span> =
static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-soc=
ks_postprocess_incoming_link(struct context *c, struct link_socket *sock)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+socks_postprocess_inc=
oming_link(struct context *c, const struct link_socket *sock)</span><br><sp=
an> {</span><br><span>     if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;inf=
o=2Eproto =3D=3D PROTO_UDP)</span><br><span>     {</span><br><span>@@ -982,=
7 +982,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-process_incoming_link_part=
1(struct context *c, struct link_socket_info *lsi, bool floated)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+process_incoming_link_part1(st=
ruct context *c, const struct link_socket_info *lsi, bool floated)</span><b=
r><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br>=
<span>     bool decrypt_status =3D false;</span><br><span>@@ -1532,7 +1532,=
7 @@</span><br><span>  * @param client    Determines whether to the send pa=
cket back via tun or link</span><br><span>  */</span><br><span> void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-ipv6_send_icmp_unreachable(s=
truct context *c, struct buffer *buf, bool client)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ipv6_send_icmp_unreachable(struct context *c=
, const struct buffer *buf, bool client)</span><br><span> {</span><br><span=
> #define MAX_ICMPV6LEN 1280</span><br><span>     struct openvpn_icmp6hdr i=
cmp6out;</span><br><span>diff --git a/src/openvpn/forward=2Eh b/src/openvpn=
/forward=2Eh</span><br><span>index 324c0b4=2E=2Eee7d2e2 100644</span><br><s=
pan>--- a/src/openvpn/forward=2Eh</span><br><span>+++ b/src/openvpn/forward=
=2Eh</span><br><span>@@ -127,7 +127,7 @@</span><br><span>  */</span><br><sp=
an> void encrypt_sign(struct context *c, bool comp_frag);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int get_server_poll_r=
emaining_time(struct event_timeout *server_poll_timeout);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+int get_server_poll_remaining_time(co=
nst struct event_timeout *server_poll_timeout);</span><br><span> </span><br=
><span> /******************************************************************=
****/</span><br><span> /**</span><br><span>@@ -178,7 +178,7 @@</span><br><s=
pan>  *</span><br><span>  * @return true if packet is authenticated, false =
otherwise=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-bool process_incoming_link_part1(struct context *c, struct link=
_socket_info *lsi, bool floated);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool process_incoming_link_part1(struct context *c, const str=
uct link_socket_info *lsi, bool floated);</span><br><span> </span><br><span=
> /**</span><br><span>  * Continues processing a packet read from the exter=
nal network interface=2E</span><br><span>diff --git a/src/openvpn/init=2Ec =
b/src/openvpn/init=2Ec</span><br><span>index a8e041d=2E=2E58473c5 100644</s=
pan><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/=
init=2Ec</span><br><span>@@ -809,7 +809,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-init_port_share(struct context *c)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+init_port_share(const struct context *c)</span=
><br><span> {</span><br><span>     if (!port_share &amp;&amp; (c-&gt;option=
s=2Eport_share_host &amp;&amp; c-&gt;options=2Eport_share_port))</span><br>=
<span>     {</span><br><span>@@ -1251,7 +1251,7 @@</span><br><span>  * prep=
ending to msg() output=2E</span><br><span>  */</span><br><span> const char =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-format_common_name(s=
truct context *c, struct gc_arena *gc)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+format_common_name(const struct context *c, struct gc_ar=
ena *gc)</span><br><span> {</span><br><span>     struct buffer out =3D allo=
c_buf_gc(256, gc);</span><br><span>     if (c-&gt;c2=2Etls_multi)</span><br=
><span>@@ -1737,7 +1737,7 @@</span><br><span> </span><br><span> </span><br>=
<span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-can=
_preserve_tun(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+can_preserve_tun(const struct tuntap *tt)</span><br><span> {</=
span><br><span>     if (tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_A=
FUNIX)</span><br><span>     {</span><br><span>@@ -1759,7 +1759,7 @@</span><=
br><span>  * @param c pointer to the connection context</span><br><span>  *=
/</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-add_wfp_block(struct context *c)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+add_wfp_block(const struct context *c)</span><br><spa=
n> {</span><br><span> #if defined(_WIN32)</span><br><span>     /* Fortify &=
#39;redirect-gateway block-local&#39; with firewall rules? */</span><br><sp=
an>@@ -1785,7 +1785,7 @@</span><br><span>  * @param adapter_index the VPN a=
dapter index</span><br><span>  */</span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-del_wfp_block(struct context *c, u=
nsigned long adapter_index)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+del_wfp_block(const struct context *c, unsigned long adapter_index)=
</span><br><span> {</span><br><span> #if defined(_WIN32)</span><br><span>  =
   if (c-&gt;options=2Eblock_outside_dns || block_local_needed(c-&gt;c1=2Er=
oute_list))</span><br><span>diff --git a/src/openvpn/init=2Eh b/src/openvpn=
/init=2Eh</span><br><span>index ce8f74e=2E=2Ec486158 100644</span><br><span=
>--- a/src/openvpn/init=2Eh</span><br><span>+++ b/src/openvpn/init=2Eh</spa=
n><br><span>@@ -91,7 +91,7 @@</span><br><span> </span><br><span> uint64_t p=
ull_permission_mask(const struct context *c);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-const char *format_common_name(st=
ruct context *c, struct gc_arena *gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+const char *format_common_name(const struct context *c, =
struct gc_arena *gc);</span><br><span> </span><br><span> void reset_coarse_=
timers(struct context *c);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/interval=2Eh b/src/openvpn/interval=2Eh</span><br><span>index 59=
051bd=2E=2E0cfe202 100644</span><br><span>--- a/src/openvpn/interval=2Eh</s=
pan><br><span>+++ b/src/openvpn/interval=2Eh</span><br><span>@@ -89,7 +89,7=
 @@</span><br><span> }</span><br><span> </span><br><span> static inline voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-interval_schedule_wa=
keup(struct interval *top, interval_t *wakeup)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+interval_schedule_wakeup(const struct interval *=
top, interval_t *wakeup)</span><br><span> {</span><br><span>     const time=
_t local_now =3D now;</span><br><span>     interval_earliest_wakeup(wakeup,=
 top-&gt;last_test_true + top-&gt;refresh, local_now);</span><br><span>@@ -=
214,7 +214,7 @@</span><br><span>  * This function does not check if the tim=
eout is actually valid=2E</span><br><span>  */</span><br><span> static inli=
ne interval_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-event_ti=
meout_remaining(struct event_timeout *et)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+event_timeout_remaining(const struct event_timeout *e=
t)</span><br><span> {</span><br><span>     return (interval_t)((et-&gt;last=
 + et-&gt;n) - now);</span><br><span> }</span><br><span>diff --git a/src/op=
envpn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index e51dcd0=2E=2Edc=
d59d7 100644</span><br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++=
 b/src/openvpn/list=2Ec</span><br><span>@@ -164,7 +164,7 @@</span><br><span=
> }</span><br><span> </span><br><span> void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-hash_remove_by_value(struct hash *hash, void *value)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_remove_by_value=
(struct hash *hash, const void *value)</span><br><span> {</span><br><span> =
    struct hash_iterator hi;</span><br><span>     const struct hash_element=
 *he;</span><br><span>diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=
=2Eh</span><br><span>index 55bc3c8=2E=2E23267d0 100644</span><br><span>--- =
a/src/openvpn/list=2Eh</span><br><span>+++ b/src/openvpn/list=2Eh</span><br=
><span>@@ -78,7 +78,7 @@</span><br><span> </span><br><span> bool hash_remov=
e_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint=
64_t hv);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void hash_remove_by_value(struct hash *hash, void *value);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void hash_remove_by_value(stru=
ct hash *hash, const void *value);</span><br><span> </span><br><span> struc=
t hash_iterator</span><br><span> {</span><br><span>diff --git a/src/openvpn=
/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 604bbcd=2E=2E17a=
bfd8 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>++=
+ b/src/openvpn/manage=2Ec</span><br><span>@@ -330,7 +330,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-man_delete_unix_socket(struct management *m=
an)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_delete_unix_=
socket(const struct management *man)</span><br><span> {</span><br><span> #i=
f UNIX_SOCK_SUPPORT</span><br><span>     if ((man-&gt;settings=2Eflags &amp=
; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><sp=
an>@@ -675,7 +675,7 @@</span><br><span>  * for the log and echo commands=2E=
</span><br><span>  */</span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-man_history(struct management *man, const char=
 *parm, const char *type, struct log_history *log,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+man_history(struct management *man, const ch=
ar *parm, const char *type, const struct log_history *log,</span><br><span>=
             bool *realtime, const unsigned int lep_flags)</span><br><span>=
 {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>@@=
 -843,7 +843,7 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_forget_pa=
sswords(struct management *man)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+man_forget_passwords(const struct management *man)</span><br><s=
pan> {</span><br><span>     ssl_purge_auth(false);</span><br><span>     (vo=
id)ssl_clean_auth_token();</span><br><span>@@ -851,7 +851,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-man_net(struct management *man)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+man_net(const struct management=
 *man)</span><br><span> {</span><br><span>     if (man-&gt;persist=2Ecallba=
ck=2Eshow_net)</span><br><span>     {</span><br><span>@@ -887,7 +887,7 @@</=
span><br><span> #ifdef ENABLE_PKCS11</span><br><span> </span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_pkcs11_id=
_count(struct management *man)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+man_pkcs11_id_count(const struct management *man)</span><br><spa=
n> {</span><br><span>     msg(M_CLIENT, &quot;&gt;PKCS11ID-COUNT:%d&quot;, =
pkcs11_management_id_count());</span><br><span> }</span><br><span>@@ -1350,=
7 +1350,7 @@</span><br><span>  * @return          Return whether p has n (o=
r at least n) parameters</span><br><span>  */</span><br><span> static bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_need(struct manage=
ment *man, const char **p, const int n, unsigned int flags)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+man_need(const struct management *m=
an, const char **p, const int n, unsigned int flags)</span><br><span> {</sp=
an><br><span>     int i;</span><br><span>     ASSERT(p[0]);</span><br><span=
>@@ -2365,7 +2365,7 @@</span><br><span>  * the route/ifconfig/open tun comm=
and=2E   See doc/android=2Etxt for details=2E</span><br><span>  */</span><b=
r><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-manageme=
nt_android_control(struct management *man, const char *command, const char =
*msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_and=
roid_control(const struct management *man, const char *command, const char =
*msg)</span><br><span> {</span><br><span>     if (!man)</span><br><span>   =
  {</span><br><span>@@ -3013,7 +3013,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-management_up_down(struct management *man, const char *updown, const st=
ruct env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ma=
nagement_up_down(const struct management *man, const char *updown, const st=
ruct env_set *es)</span><br><span> {</span><br><span>     if (man-&gt;setti=
ngs=2Eflags &amp; MF_UP_DOWN)</span><br><span>     {</span><br><span>@@ -30=
23,13 +3023,13 @@</span><br><span> }</span><br><span> </span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_notify(st=
ruct management *man, const char *severity, const char *type, const char *t=
ext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_noti=
fy(const struct management *man, const char *severity, const char *type, co=
nst char *text)</span><br><span> {</span><br><span>     msg(M_CLIENT, &quot=
;&gt;NOTIFY:%s,%s,%s&quot;, severity, type, text);</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-management_notify_generic(struct management *man, const char *=
str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_noti=
fy_generic(const struct management *man, const char *str)</span><br><span> =
{</span><br><span>     msg(M_CLIENT, &quot;%s&quot;, str);</span><br><span>=
 }</span><br><span>@@ -3115,7 +3115,8 @@</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-management_notify_client_close(struct management *management, struct man=
_def_auth_context *mdac,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+management_notify_client_close(const struct management *management,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
         struct man_def_auth_context *mdac,</span><br><span>               =
                 const struct env_set *es)</span><br><span> {</span><br><sp=
an>     if ((mdac-&gt;flags &amp; DAF_INITIAL_AUTH) &amp;&amp; !(mdac-&gt;f=
lags &amp; DAF_CONNECTION_CLOSED))</span><br><span>@@ -3206,7 +3207,7 @@</s=
pan><br><span> }</span><br><span> </span><br><span> void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(struct managemen=
t *man, const char *type, const char *reason)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+management_auth_failure(const struct management *=
man, const char *type, const char *reason)</span><br><span> {</span><br><sp=
an>     if (reason)</span><br><span>     {</span><br><span>@@ -3219,7 +3220=
,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-management_auth_token(struct man=
agement *man, const char *token)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+management_auth_token(const struct management *man, const char=
 *token)</span><br><span> {</span><br><span>     msg(M_CLIENT, &quot;&gt;PA=
SSWORD:Auth-Token:%s&quot;, token);</span><br><span> }</span><br><span>diff=
 --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>in=
dex 27d3b60=2E=2E0d011df 100644</span><br><span>--- a/src/openvpn/manage=2E=
h</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -368,7 +3=
68,7 @@</span><br><span>                                 const unsigned int=
 flags, const char *static_challenge);</span><br><span> </span><br><span> #=
ifdef TARGET_ANDROID</span><br><span style=3D"color: hsl(0, 100%, 40%);">-b=
ool management_android_control(struct management *man, const char *command,=
 const char *msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool management_android_control(const struct management *man, const char *co=
mmand, const char *msg);</span><br><span> </span><br><span> #define ANDROID=
_KEEP_OLD_TUN      1</span><br><span> #define ANDROID_OPEN_BEFORE_CLOSE 2</=
span><br><span>@@ -382,12 +382,12 @@</span><br><span> </span><br><span> voi=
d management_event_loop_n_seconds(struct management *man, int sec);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void manage=
ment_up_down(struct management *man, const char *updown, const struct env_s=
et *es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void manage=
ment_up_down(const struct management *man, const char *updown, const struct=
 env_set *es);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void management_notify(struct management *man, const char *sever=
ity, const char *type,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void management_notify(const struct management *man, const char *severit=
y, const char *type,</span><br><span>                        const char *te=
xt);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void management_notify_generic(struct management *man, const char *str);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void management_notif=
y_generic(const struct management *man, const char *str);</span><br><span> =
</span><br><span> void management_notify_client_needing_auth(struct managem=
ent *management,</span><br><span>                                          =
  const unsigned int auth_id,</span><br><span>@@ -397,7 +397,7 @@</span><br=
><span> void management_connection_established(struct management *managemen=
t,</span><br><span>                                        struct man_def_a=
uth_context *mdac, const struct env_set *es);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void management_notify_client_clo=
se(struct management *management,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void management_notify_client_close(const struct management *=
management,</span><br><span>                                     struct man=
_def_auth_context *mdac, const struct env_set *es);</span><br><span> </span=
><br><span> void management_learn_addr(struct management *management, struc=
t man_def_auth_context *mdac,</span><br><span>@@ -482,12 +482,12 @@</span><=
br><span>  * OpenVPN calls here to indicate a password failure</span><br><s=
pan>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void management_auth_failure(struct management *man, const char *type,=
 const char *reason);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void management_auth_failure(const struct management *man, const char *ty=
pe, const char *reason);</span><br><span> </span><br><span> /*</span><br><s=
pan>  * Echo an authentication token to management interface</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void management=
_auth_token(struct management *man, const char *token);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void management_auth_token(const struct=
 management *man, const char *token);</span><br><span> </span><br><span> /*=
</span><br><span>  * These functions drive the bytecount in/out counters=2E=
</span><br><span>diff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec</=
span><br><span>index 7b790ed=2E=2E9a37e30 100644</span><br><span>--- a/src/=
openvpn/mbuf=2Ec</span><br><span>+++ b/src/openvpn/mbuf=2Ec</span><br><span=
>@@ -149,7 +149,7 @@</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbuf_dereference_=
instance(struct mbuf_set *ms, struct multi_instance *mi)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+mbuf_dereference_instance(struct mbuf_=
set *ms, const struct multi_instance *mi)</span><br><span> {</span><br><spa=
n>     if (ms)</span><br><span>     {</span><br><span>diff --git a/src/open=
vpn/mbuf=2Eh b/src/openvpn/mbuf=2Eh</span><br><span>index cfe698c=2E=2Ee368=
054 100644</span><br><span>--- a/src/openvpn/mbuf=2Eh</span><br><span>+++ b=
/src/openvpn/mbuf=2Eh</span><br><span>@@ -75,7 +75,7 @@</span><br><span> </=
span><br><span> bool mbuf_extract_item(struct mbuf_set *ms, struct mbuf_ite=
m *item);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void mbuf_dereference_instance(struct mbuf_set *ms, struct multi_inst=
ance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void mbuf=
_dereference_instance(struct mbuf_set *ms, const struct multi_instance *mi)=
;</span><br><span> </span><br><span> static inline bool</span><br><span> mb=
uf_defined(const struct mbuf_set *ms)</span><br><span>diff --git a/src/open=
vpn/mss=2Ec b/src/openvpn/mss=2Ec</span><br><span>index 36bbb43=2E=2Ea7242a=
8 100644</span><br><span>--- a/src/openvpn/mss=2Ec</span><br><span>+++ b/sr=
c/openvpn/mss=2Ec</span><br><span>@@ -43,7 +43,7 @@</span><br><span>  *    =
          if yes, hand to mss_fixup_dowork()</span><br><span>  */</span><br=
><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mss_fixup=
_ipv4(struct buffer *buf, uint16_t maxmss)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+mss_fixup_ipv4(const struct buffer *buf, uint16_t ma=
xmss)</span><br><span> {</span><br><span>     const struct openvpn_iphdr *p=
ip;</span><br><span>     int hlen;</span><br><span>@@ -80,7 +80,7 @@</span>=
<br><span>  *              (IPv6 header structure is sufficiently different=
 from IPv4=2E=2E=2E)</span><br><span>  */</span><br><span> void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-mss_fixup_ipv6(struct buffer *buf=
, uint16_t maxmss)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
ss_fixup_ipv6(const struct buffer *buf, uint16_t maxmss)</span><br><span> {=
</span><br><span>     const struct openvpn_ipv6hdr *pip6;</span><br><span> =
    struct buffer newbuf;</span><br><span>@@ -136,7 +136,7 @@</span><br><sp=
an>  */</span><br><span> </span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-mss_fixup_dowork(struct buffer *buf, uint16_t max=
mss)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mss_fixup_dowor=
k(const struct buffer *buf, uint16_t maxmss)</span><br><span> {</span><br><=
span>     int olen, optlen;</span><br><span>     uint8_t *opt;</span><br><s=
pan>@@ -239,8 +239,8 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-frame_c=
alculate_fragment(struct frame *frame, struct key_type *kt, const struct op=
tions *options,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                   struct link_socket_info *lsi)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+frame_calculate_fragment(struct frame *frame, =
const struct key_type *kt, const struct options *options,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                         const struct=
 link_socket_info *lsi)</span><br><span> {</span><br><span> #if defined(ENA=
BLE_FRAGMENT)</span><br><span>     size_t overhead;</span><br><span>@@ -269=
,8 +269,8 @@</span><br><span> }</span><br><span> </span><br><span> static v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-frame_calculate_ms=
sfix(struct frame *frame, struct key_type *kt, const struct options *option=
s,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
    struct link_socket_info *lsi)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+frame_calculate_mssfix(struct frame *frame, const struct key_=
type *kt, const struct options *options,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                       const struct link_socket_info *=
lsi)</span><br><span> {</span><br><span>     if (options-&gt;ce=2Emssfix_fi=
xed)</span><br><span>     {</span><br><span>@@ -314,8 +314,8 @@</span><br><=
span> }</span><br><span> </span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-frame_calculate_dynamic(struct frame *frame, stru=
ct key_type *kt, const struct options *options,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                        struct link_socket_info *=
lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+frame_calculate=
_dynamic(struct frame *frame, const struct key_type *kt, const struct optio=
ns *options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 const struct link_socket_info *lsi)</span><br><span> {</sp=
an><br><span>     if (options-&gt;ce=2Efragment &gt; 0)</span><br><span>   =
  {</span><br><span>diff --git a/src/openvpn/mss=2Eh b/src/openvpn/mss=2Eh<=
/span><br><span>index 1d092bb=2E=2E6b832a2 100644</span><br><span>--- a/src=
/openvpn/mss=2Eh</span><br><span>+++ b/src/openvpn/mss=2Eh</span><br><span>=
@@ -29,15 +29,15 @@</span><br><span> #include &quot;socket=2Eh&quot;</span>=
<br><span> #include &quot;ssl_common=2Eh&quot;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void mss_fixup_ipv4(struct buffe=
r *buf, uint16_t maxmss);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void mss_fixup_ipv4(const struct buffer *buf, uint16_t maxmss);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void mss_=
fixup_ipv6(struct buffer *buf, uint16_t maxmss);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void mss_fixup_ipv6(const struct buffer *buf, =
uint16_t maxmss);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void mss_fixup_dowork=
(const struct buffer *buf, uint16_t maxmss);</span><br><span> </span><br><s=
pan> /** Set the --mssfix option=2E */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void frame_calculate_dynamic(struct frame *frame, struct k=
ey_type *kt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                    const struct options *options, struct link_socket_info =
*lsi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void frame_ca=
lculate_dynamic(struct frame *frame, const struct key_type *kt,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                             co=
nst struct options *options, const struct link_socket_info *lsi);</span><br=
><span> </span><br><span> /**</span><br><span>  * Checks and adjusts the fr=
agment and mssfix value according to the</span><br><span>diff --git a/src/o=
penvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index 5d88f8a=2E=2E9=
22db3f 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>++=
+ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -91,7 +91,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-multi_tcp_instance_specific_init(struct multi_context =
*m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+multi_tcp_instance_specific_init(const struct multi_context *m, =
struct multi_instance *mi)</span><br><span> {</span><br><span>     /* buffe=
r for queued TCP socket output packets */</span><br><span>     mi-&gt;tcp_l=
ink_out_deferred =3D mbuf_init(m-&gt;top=2Eoptions=2En_bcast_buf);</span><b=
r><span>diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh</span><br>=
<span>index 9b7d1d2=2E=2Ebb117fa 100644</span><br><span>--- a/src/openvpn/m=
tcp=2Eh</span><br><span>+++ b/src/openvpn/mtcp=2Eh</span><br><span>@@ -35,7=
 +35,7 @@</span><br><span> </span><br><span> void multi_tcp_dereference_ins=
tance(struct multi_io *multi_io, struct multi_instance *mi);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool multi_tcp_ins=
tance_specific_init(struct multi_context *m, struct multi_instance *mi);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool multi_tcp_instanc=
e_specific_init(const struct multi_context *m, struct multi_instance *mi);<=
/span><br><span> </span><br><span> void multi_tcp_instance_specific_free(st=
ruct multi_instance *mi);</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index de3d467=2E=
=2E5e37682 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><spa=
n>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -53,8 +53,9 @@</span><br><s=
pan>  * @param sock    the socket to send the reply on</span><br><span>  */=
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-send_standalone_reply(struct multi_context *m, struct buffer *buf, =
const char *prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                    const char *detail, struct link_socket *sock)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+send_standalone_reply(struct =
multi_context *m, const struct buffer *buf,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                      const char *prefix, const cha=
r *detail,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
             struct link_socket *sock)</span><br><span> {</span><br><span> =
    struct context *c =3D &amp;m-&gt;top;</span><br><span> </span><br><span=
>@@ -74,7 +75,7 @@</span><br><span> </span><br><span> static void</span><br=
><span> send_hmac_reset_packet(struct multi_context *m, struct tls_pre_decr=
ypt_state *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                   struct tls_auth_standalone *tas, struct session_id *sid,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
    const struct tls_auth_standalone *tas, const struct session_id *sid,</s=
pan><br><span>                        bool request_resend_wkc, struct link_=
socket *sock)</span><br><span> {</span><br><span>     reset_packet_id_send(=
&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);</span><br><span>@@ -=
97,11 +98,11 @@</span><br><span> </span><br><span>     enum first_packet_ve=
rdict verdict;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct tls_auth_standalone *tas =3D m-&gt;top=2Ec2=2Etls_aut=
h_standalone;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct tls_auth_standalone *tas =3D m-&gt;top=2Ec2=2Etls_auth_standalon=
e;</span><br><span> </span><br><span>     verdict =3D tls_pre_decrypt_lite(=
tas, state, &amp;m-&gt;top=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Ebuf);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t=
 *hmac_key =3D m-&gt;top=2Ec2=2Esession_id_key;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const uint8_t *hmac_key =3D m-&gt;top=2Ec2=
=2Esession_id_key;</span><br><span>     const struct openvpn_sockaddr *from=
 =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br><span>     int handwindow=
 =3D m-&gt;top=2Eoptions=2Ehandshake_window;</span><br><span> </span><br><s=
pan>@@ -218,7 +219,7 @@</span><br><span> static struct multi_instance *</sp=
an><br><span> handle_connection_attempt(struct multi_context *m,</span><br>=
<span>                           struct link_socket *sock,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                          struct mrout=
e_addr *real)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                    const struct mroute_addr *real)</span><br><span> {</spa=
n><br><span>     struct hash *hash =3D m-&gt;hash;</span><br><span>     str=
uct tls_pre_decrypt_state state =3D { 0 };</span><br><span>@@ -286,7 +287,7=
 @@</span><br><span>  * @return      instance matching the address, NULL ot=
herwise</span><br><span>  */</span><br><span> static struct multi_instance =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_instance_u=
dp_real(struct multi_context *m, struct mroute_addr *real)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_udp_real(struct m=
ulti_context *m, const struct mroute_addr *real)</span><br><span> {</span><=
br><span>     struct hash *hash =3D m-&gt;hash;</span><br><span>     struct=
 hash_element *he;</span><br><span>@@ -320,7 +321,9 @@</span><br><span>  * =
maintaining real address hash table atomicity=2E</span><br><span>  */</span=
><br><span> struct multi_instance *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-multi_get_instance_udp_data(struct multi_context *m, bool *fl=
oated, struct mroute_addr *real, struct link_socket *sock)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_udp_data(struct m=
ulti_context *m, bool *floated,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                            const struct mroute_addr *real,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
     const struct link_socket *sock)</span><br><span> {</span><br><span>   =
  struct multi_instance *mi =3D NULL;</span><br><span> </span><br><span>dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>ind=
ex 74939bf=2E=2E73f8d24 100644</span><br><span>--- a/src/openvpn/multi=2Ec<=
/span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -57,7 +57,7 =
@@</span><br><span> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><=
br><span> static const char *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-id(struct multi_instance *mi)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+id(const struct multi_instance *mi)</span><br><span> {</s=
pan><br><span>     if (mi)</span><br><span>     {</span><br><span>@@ -1314,=
7 +1314,7 @@</span><br><span>  * same common name=2E</span><br><span>  */</=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-multi_delete_dup(struct multi_context *m, struct multi_instance *new_=
mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_delete_dup=
(struct multi_context *m, const struct multi_instance *new_mi)</span><br><s=
pan> {</span><br><span>     if (new_mi)</span><br><span>     {</span><br><s=
pan>@@ -2259,7 +2259,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi=
_client_setup_dco_initial(struct multi_context *m, struct multi_instance *m=
i,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_setu=
p_dco_initial(const struct multi_context *m, struct multi_instance *mi,</sp=
an><br><span>                                struct gc_arena *gc)</span><br=
><span> {</span><br><span>     if (!dco_enabled(&amp;mi-&gt;context=2Eoptio=
ns))</span><br><span>@@ -3078,7 +3078,8 @@</span><br><span>  * positive=2E<=
/span><br><span>  */</span><br><span> static bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-multi_check_dest_addr_allowed(struct multi_cont=
ext *m, struct multi_instance *mi, struct mroute_addr *real)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+multi_check_dest_addr_allowed(stru=
ct multi_context *m, struct multi_instance *mi,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                              const struct mrou=
te_addr *real)</span><br><span> {</span><br><span>     struct hash *hash =
=3D m-&gt;hash;</span><br><span>     const uint64_t hv =3D hash_value(hash,=
 real);</span><br><span>@@ -3237,7 +3238,7 @@</span><br><span> </span><br><=
span> #if defined(ENABLE_DCO)</span><br><span> static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-process_incoming_del_peer(struct multi=
_context *m, struct multi_instance *mi, dco_context_t *dco)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+process_incoming_del_peer(struct mu=
lti_context *m, struct multi_instance *mi, const dco_context_t *dco)</span>=
<br><span> {</span><br><span>     const char *reason =3D &quot;ovpn-dco: un=
known reason&quot;;</span><br><span>     switch (dco-&gt;dco_del_peer_reaso=
n)</span><br><span>@@ -4281,7 +4282,7 @@</span><br><span> </span><br><span>=
 /* Searches for the address and deletes it if it is owned by the multi_ins=
tance */</span><br><span> static void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-multi_unlearn_addr(struct multi_context *m, struct multi_in=
stance *mi, const struct mroute_addr *addr)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+multi_unlearn_addr(struct multi_context *m, const s=
truct multi_instance *mi, const struct mroute_addr *addr)</span><br><span> =
{</span><br><span>     struct hash_element *he;</span><br><span>     const =
uint64_t hv =3D hash_value(m-&gt;vhash, addr);</span><br><span>@@ -4316,7 +=
4317,7 @@</span><br><span>  * @param a     The new IPv4 address in network =
byte order</span><br><span>  */</span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_in_addr_t(struct multi=
_context *m, struct multi_instance *mi, in_addr_t a)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_in_addr_t(struct multi_cont=
ext *m, const struct multi_instance *mi, in_addr_t a)</span><br><span> {</s=
pan><br><span>     struct mroute_addr addr;</span><br><span>     CLEAR(addr=
);</span><br><span>@@ -4334,7 +4335,7 @@</span><br><span>  * @param a6    T=
he new IPv6 address</span><br><span>  */</span><br><span> static void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_in6_addr(stru=
ct multi_context *m, struct multi_instance *mi, struct in6_addr a6)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_in6_addr(stru=
ct multi_context *m, const struct multi_instance *mi, struct in6_addr a6)</=
span><br><span> {</span><br><span>     struct mroute_addr addr;</span><br><=
span>     CLEAR(addr);</span><br><span>@@ -4450,7 +4451,7 @@</span><br><spa=
n> </span><br><span> bool</span><br><span> multi_check_push_ifconfig_ipv6_e=
xtra_route(struct multi_instance *mi,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                           struct in6_addr =
*dest)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                              const struct in6_addr *dest)</span><br><span>=
 {</span><br><span>     const struct options *o =3D &amp;mi-&gt;context=2Eo=
ptions;</span><br><span> </span><br><span>diff --git a/src/openvpn/multi=2E=
h b/src/openvpn/multi=2Eh</span><br><span>index 8b837fa=2E=2Ec285fc3 100644=
</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/open=
vpn/multi=2Eh</span><br><span>@@ -516,7 +516,7 @@</span><br><span>  */</spa=
n><br><span> </span><br><span> static inline void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-set_prefix(struct multi_instance *mi)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+set_prefix(const struct multi=
_instance *mi)</span><br><span> {</span><br><span> #ifdef MULTI_DEBUG_EVENT=
_LOOP</span><br><span>     if (mi-&gt;msg_prefix[0])</span><br><span>@@ -69=
0,7 +690,7 @@</span><br><span>  */</span><br><span> bool</span><br><span> m=
ulti_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
               struct in6_addr *dest);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                           const struct =
in6_addr *dest);</span><br><span> </span><br><span> /*</span><br><span>  * =
Check for signals=2E</span><br><span>diff --git a/src/openvpn/multi_io=2Ec =
b/src/openvpn/multi_io=2Ec</span><br><span>index 3604684=2E=2E52eb8c7 10064=
4</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/=
openvpn/multi_io=2Ec</span><br><span>@@ -159,7 +159,7 @@</span><br><span>  =
* a point-to-multipoint tunnel=2E</span><br><span>  */</span><br><span> sta=
tic unsigned int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-p2mp_=
iow_flags(const struct multi_context *m, struct link_socket *sock)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+p2mp_iow_flags(const struct =
multi_context *m, const struct link_socket *sock)</span><br><span> {</span>=
<br><span>     unsigned int flags =3D IOW_WAIT_SIGNAL;</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/networking=2Eh b/src/openvpn/network=
ing=2Eh</span><br><span>index bce0c19=2E=2E25233c8 100644</span><br><span>-=
-- a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/openvpn/networkin=
g=2Eh</span><br><span>@@ -44,7 +44,7 @@</span><br><span>  */</span><br><spa=
n> #if !defined(ENABLE_IPROUTE)</span><br><span> static inline int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-net_ctx_init(struct context *c=
, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)</span><=
br><span> {</span><br><span>     (void)c;</span><br><span>     (void)ctx;</=
span><br><span>@@ -75,7 +75,7 @@</span><br><span>  *</span><br><span>  * @r=
eturn          0 on success, a negative error code otherwise</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_ctx_ini=
t(struct context *c, openvpn_net_ctx_t *ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+int net_ctx_init(const struct context *c, openvpn=
_net_ctx_t *ctx);</span><br><span> </span><br><span> /**</span><br><span>  =
* Release resources allocated by the internal garbage collector</span><br><=
span>@@ -102,7 +102,7 @@</span><br><span>  * @return          0 on success,=
 negative error code on error</span><br><span>  */</span><br><span> int net=
_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const =
char *type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
        void *arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                  const void *arg);</span><br><span> </span><br><span> /**<=
/span><br><span>  * Retrieve the interface type</span><br><span>diff --git =
a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec=
</span><br><span>index a1f3525=2E=2Ef091fb3 100644</span><br><span>--- a/sr=
c/openvpn/networking_iproute2=2Ec</span><br><span>+++ b/src/openvpn/network=
ing_iproute2=2Ec</span><br><span>@@ -36,7 +36,7 @@</span><br><span> #includ=
e &lt;netinet/in=2Eh&gt;</span><br><span> </span><br><span> int</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-net_ctx_init(struct context *c, o=
penvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)</span><br>=
<span> {</span><br><span>     ctx-&gt;es =3D NULL;</span><br><span>     if =
(c)</span><br><span>@@ -61,7 +61,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-n=
et_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, v=
oid *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_=
new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void=
 *arg)</span><br><span> {</span><br><span>     struct argv argv =3D argv_ne=
w();</span><br><span> </span><br><span>diff --git a/src/openvpn/networking_=
sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index e6e72d0=
=2E=2Ea1d220f 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec=
</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ =
-987,7 +987,7 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_del(=
sa_family_t af_family, const char *iface, inet_address_t *addr, int prefixl=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_del(s=
a_family_t af_family, const char *iface, const inet_address_t *addr, int pr=
efixlen)</span><br><span> {</span><br><span>     int ifindex;</span><br><sp=
an> </span><br><span>@@ -1230,8 +1230,8 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-sitnl_route_del(const char *iface, sa_family_t af_family, inet_a=
ddress_t *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                inet_address_t *gw, uint32_t table, int metric)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_del(const c=
har *iface, sa_family_t af_family, const inet_address_t *dst, int prefixlen=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                co=
nst inet_address_t *gw, uint32_t table, int metric)</span><br><span> {</spa=
n><br><span>     int ifindex =3D 0;</span><br><span> </span><br><span>@@ -1=
308,7 +1308,7 @@</span><br><span> </span><br><span> </span><br><span> int</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_new(openvpn_n=
et_ctx_t *ctx, const char *iface, const char *type, void *arg)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+net_iface_new(openvpn_net_ctx_t =
*ctx, const char *iface, const char *type, const void *arg)</span><br><span=
> {</span><br><span>     struct sitnl_link_req req =3D {};</span><br><span>=
     int ret =3D -1;</span><br><span>diff --git a/src/openvpn/occ=2Eh b/src=
/openvpn/occ=2Eh</span><br><span>index bda4f18=2E=2E49def4d 100644</span><b=
r><span>--- a/src/openvpn/occ=2Eh</span><br><span>+++ b/src/openvpn/occ=2Eh=
</span><br><span>@@ -156,7 +156,7 @@</span><br><span>  * via control channe=
l=2E</span><br><span>  * @return control channel exit message should be use=
d */</span><br><span> static inline bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-cc_exit_notify_enabled(struct context *c)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+cc_exit_notify_enabled(const struc=
t context *c)</span><br><span> {</span><br><span>     /* Check if we have T=
LS active at all */</span><br><span>     if (!c-&gt;c2=2Etls_multi)</span><=
br><span>diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_=
compat=2Eh</span><br><span>index 098bdd5=2E=2E1a934db 100644</span><br><spa=
n>--- a/src/openvpn/openssl_compat=2Eh</span><br><span>+++ b/src/openvpn/op=
enssl_compat=2Eh</span><br><span>@@ -127,7 +127,7 @@</span><br><span> /* Mi=
mics the functions but only when the default context without</span><br><spa=
n>  * options is chosen */</span><br><span> static inline const EVP_CIPHER =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-EVP_CIPHER_fetch(voi=
d *ctx, const char *algorithm, const char *properties)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+EVP_CIPHER_fetch(const void *ctx, const =
char *algorithm, const char *properties)</span><br><span> {</span><br><span=
>     ASSERT(!ctx);</span><br><span>     ASSERT(!properties);</span><br><sp=
an>@@ -135,7 +135,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static inline const EVP_MD *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-EVP_MD_fetch(void *ctx, const char *algorithm, const char *propert=
ies)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+EVP_MD_fetch(co=
nst void *ctx, const char *algorithm, const char *properties)</span><br><sp=
an> {</span><br><span>     ASSERT(!ctx);</span><br><span>     ASSERT(!prope=
rties);</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/=
options=2Ec</span><br><span>index b210a5d=2E=2Ed5c0fe4 100644</span><br><sp=
an>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=
=2Ec</span><br><span>@@ -2423,7 +2423,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-options_postprocess_mutate_le(struct connection_entry *ce, stru=
ct local_entry *le, int mode)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+options_postprocess_mutate_le(const struct connection_entry *ce, =
struct local_entry *le, int mode)</span><br><span> {</span><br><span>     /=
* use the global port if none is specified */</span><br><span>     if (!le-=
&gt;port)</span><br><span>@@ -3576,7 +3576,7 @@</span><br><span> static boo=
l</span><br><span> verify_permission(const char *name, const char *file, in=
t line, const uint64_t type,</span><br><span>                   const uint6=
4_t allowed, uint64_t *found, const msglvl_t msglevel,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                  struct options *options,=
 bool is_inline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
               const struct options *options, bool is_inline)</span><br><sp=
an> {</span><br><span>     if (!(type &amp; allowed))</span><br><span>     =
{</span><br><span>@@ -4143,7 +4143,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-show_compression_warning(struct compress_options *info)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+show_compression_warning(const=
 struct compress_options *info)</span><br><span> {</span><br><span>     if =
(comp_non_stub_enabled(info))</span><br><span>     {</span><br><span>diff -=
-git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_parse=2Ec</span>=
<br><span>index 88ab4d2=2E=2E0e94522 100644</span><br><span>--- a/src/openv=
pn/options_parse=2Ec</span><br><span>+++ b/src/openvpn/options_parse=2Ec</s=
pan><br><span>@@ -258,7 +258,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> static char *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-read_inline_file(struct in_src *is, const char *close_tag, int *num_li=
nes, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+read_inline_file(const struct in_src *is, const char *close_tag, int =
*num_lines, struct gc_arena *gc)</span><br><span> {</span><br><span>     ch=
ar line[OPTION_LINE_SIZE];</span><br><span>     struct buffer buf =3D alloc=
_buf(8 * OPTION_LINE_SIZE);</span><br><span>@@ -302,7 +302,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-check_inline_file(struct in_src *is, char *=
p[], struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+check_inline_file(const struct in_src *is, char *p[], struct gc_arena=
 *gc)</span><br><span> {</span><br><span>     int num_inline_lines =3D 0;</=
span><br><span> </span><br><span>diff --git a/src/openvpn/otime=2Ec b/src/o=
penvpn/otime=2Ec</span><br><span>index 1608458=2E=2E5d3633c 100644</span><b=
r><span>--- a/src/openvpn/otime=2Ec</span><br><span>+++ b/src/openvpn/otime=
=2Ec</span><br><span>@@ -66,7 +66,7 @@</span><br><span> }</span><br><span> =
</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-update_now_usec(struct timeval *tv)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+update_now_usec(const struct timeval *tv)</span><br><span>=
 {</span><br><span>     const time_t last =3D now;</span><br><span>     upd=
ate_now(tv-&gt;tv_sec);</span><br><span>diff --git a/src/openvpn/otime=2Eh =
b/src/openvpn/otime=2Eh</span><br><span>index d14f01e=2E=2E74d21ff 100644</=
span><br><span>--- a/src/openvpn/otime=2Eh</span><br><span>+++ b/src/openvp=
n/otime=2Eh</span><br><span>@@ -65,7 +65,7 @@</span><br><span> void update_=
now(const time_t system_time);</span><br><span> </span><br><span> extern ti=
me_t now_usec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void up=
date_now_usec(struct timeval *tv);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void update_now_usec(const struct timeval *tv);</span><br><s=
pan> </span><br><span> static inline int</span><br><span> openvpn_gettimeof=
day(struct timeval *tv, void *tz)</span><br><span>diff --git a/src/openvpn/=
proto=2Eh b/src/openvpn/proto=2Eh</span><br><span>index 3570582=2E=2E33bf4e=
a 100644</span><br><span>--- a/src/openvpn/proto=2Eh</span><br><span>+++ b/=
src/openvpn/proto=2Eh</span><br><span>@@ -248,7 +248,7 @@</span><br><span> =
 * and offset of IP header (via parameter)=2E</span><br><span>  */</span><b=
r><span> static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-get_tun_ip_ver(int tunnel_type, struct buffer *buf, int *ip_hdr_offset=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_tun_ip_ver(int=
 tunnel_type, const struct buffer *buf, int *ip_hdr_offset)</span><br><span=
> {</span><br><span>     int ip_ver =3D -1;</span><br><span> </span><br><sp=
an>diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><sp=
an>index e0700aa=2E=2E5e13d1f 100644</span><br><span>--- a/src/openvpn/prox=
y=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -527,8=
 +527,9 @@</span><br><span> }</span><br><span> </span><br><span> static boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_proxy_headers(st=
ruct http_proxy_info *p, socket_descriptor_t sd, /* already open to proxy *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  co=
nst char *host                                   /* openvpn server remote *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_proxy_headers(=
const struct http_proxy_info *p,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                  socket_descriptor_t sd, /* already open to p=
roxy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
      const char *host        /* openvpn server remote */</span><br><span> =
)</span><br><span> {</span><br><span>     char buf[512];</span><br><span>@@=
 -597,8 +598,8 @@</span><br><span>                               socket_des=
criptor_t sd, /* already open to proxy */</span><br><span>                 =
              const char *host,       /* openvpn server remote */</span><br=
><span>                               const char *port,       /* openvpn se=
rver port */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                     struct event_timeout *server_poll_timeout, struct buff=
er *lookahead,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                       struct signal_info *sig_info)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              const struc=
t event_timeout *server_poll_timeout,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                              struct buffer *lookahead, s=
truct signal_info *sig_info)</span><br><span> {</span><br><span>     struct=
 gc_arena gc =3D gc_new();</span><br><span>     char buf[512];</span><br><s=
pan>diff --git a/src/openvpn/proxy=2Eh b/src/openvpn/proxy=2Eh</span><br><s=
pan>index e662e7d=2E=2Ea2f4e47 100644</span><br><span>--- a/src/openvpn/pro=
xy=2Eh</span><br><span>+++ b/src/openvpn/proxy=2Eh</span><br><span>@@ -89,7=
 +89,7 @@</span><br><span>                                    socket_descri=
ptor_t sd, /* already open to proxy */</span><br><span>                    =
                const char *host,       /* openvpn server remote */</span><=
br><span>                                    const char *port,       /* ope=
nvpn server port */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                 struct event_timeout *server_poll_timeout,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                const struct event_timeout *server_poll_timeout,</span><br>=
<span>                                    struct buffer *lookahead, struct =
signal_info *sig_info);</span><br><span> </span><br><span> uint8_t *make_ba=
se64_string2(const uint8_t *str, int str_len, struct gc_arena *gc);</span><=
br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><sp=
an>index be91a99=2E=2E0c91449 100644</span><br><span>--- a/src/openvpn/ps=
=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -332,7 +33=
2,7 @@</span><br><span>  * the proxy can determine true client origin=2E</s=
pan><br><span>  */</span><br><span> static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-journal_add(const char *journal_dir, struct proxy=
_connection *pc, struct proxy_connection *cp)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+journal_add(const char *journal_dir, const struct=
 proxy_connection *pc, struct proxy_connection *cp)</span><br><span> {</spa=
n><br><span>     struct openvpn_sockaddr from, to;</span><br><span> </span>=
<br><span>@@ -410,7 +410,7 @@</span><br><span> static bool</span><br><span>=
 proxy_entry_new(struct proxy_connection **list, struct event_set *es,</spa=
n><br><span>                 const struct openvpn_sockaddr server_addr, con=
st socket_descriptor_t sd_client,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                struct buffer *initial_data, const char *journa=
l_dir)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   const struct buffer *initial_data, const char *journal_dir)</span><br><s=
pan> {</span><br><span>     socket_descriptor_t sd_server;</span><br><span>=
     int status;</span><br><span>@@ -1013,7 +1013,7 @@</span><br><span>  * =
call=2E</span><br><span>  */</span><br><span> void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-port_share_redirect(struct port_share *ps, con=
st struct buffer *head, socket_descriptor_t sd)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+port_share_redirect(const struct port_share *ps=
, const struct buffer *head, socket_descriptor_t sd)</span><br><span> {</sp=
an><br><span>     if (ps)</span><br><span>     {</span><br><span>diff --git=
 a/src/openvpn/ps=2Eh b/src/openvpn/ps=2Eh</span><br><span>index 557ecf5=2E=
=2E918ceb6 100644</span><br><span>--- a/src/openvpn/ps=2Eh</span><br><span>=
+++ b/src/openvpn/ps=2Eh</span><br><span>@@ -49,7 +49,7 @@</span><br><span>=
 </span><br><span> bool is_openvpn_protocol(const struct buffer *buf);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void por=
t_share_redirect(struct port_share *ps, const struct buffer *head, socket_d=
escriptor_t sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d port_share_redirect(const struct port_share *ps, const struct buffer *hea=
d, socket_descriptor_t sd);</span><br><span> </span><br><span> #endif /* if=
 PORT_SHARE */</span><br><span> #endif /* ifndef PS_H */</span><br><span>di=
ff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>inde=
x fa7bf1e=2E=2Ec2c1914 100644</span><br><span>--- a/src/openvpn/push=2Ec</s=
pan><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -430,7 +430,7 @=
@</span><br><span> }</span><br><span> </span><br><span> bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-send_auth_pending_messages(struct tl=
s_multi *tls_multi, struct tls_session *session,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+send_auth_pending_messages(const struct tls_mu=
lti *tls_multi, struct tls_session *session,</span><br><span>              =
              const char *extra, unsigned int timeout)</span><br><span> {</=
span><br><span>     struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMAR=
Y];</span><br><span>diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2E=
h</span><br><span>index dff945f=2E=2E39302f6 100644</span><br><span>--- a/s=
rc/openvpn/push=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</span><br><s=
pan>@@ -117,7 +117,7 @@</span><br><span>  * doc/management-notes=2Etxt unde=
r client-pending-auth for</span><br><span>  * more details on message forma=
t</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-bool send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_se=
ssion *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
 send_auth_pending_messages(const struct tls_multi *tls_multi, struct tls_s=
ession *session,</span><br><span>                                 const cha=
r *extra, unsigned int timeout);</span><br><span> </span><br><span> void se=
nd_restart(struct context *c, const char *kill_msg);</span><br><span>diff -=
-git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br><spa=
n>index 0213041=2E=2E7fa5987 100644</span><br><span>--- a/src/openvpn/push_=
util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@=
 -222,7 +222,7 @@</span><br><span> </span><br><span> /* Return true if the =
client supports push-update */</span><br><span> static bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-support_push_update(struct multi_inst=
ance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+support_pu=
sh_update(const struct multi_instance *mi)</span><br><span> {</span><br><sp=
an>     ASSERT(mi-&gt;context=2Ec2=2Etls_multi);</span><br><span>     const=
 unsigned int iv_proto_peer =3D extract_iv_proto(mi-&gt;context=2Ec2=2Etls_=
multi-&gt;peer_info);</span><br><span>diff --git a/src/openvpn/reliable=2Ec=
 b/src/openvpn/reliable=2Ec</span><br><span>index 690e50d6=2E=2E392eb57 100=
644</span><br><span>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/sr=
c/openvpn/reliable=2Ec</span><br><span>@@ -92,7 +92,7 @@</span><br><span> <=
/span><br><span> /* check if a particular packet_id is present in ack */</s=
pan><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-reliable_ack_packet_id_present(struct reliable_ack *ack, packet=
_id_type pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliab=
le_ack_packet_id_present(const struct reliable_ack *ack, packet_id_type pid=
)</span><br><span> {</span><br><span>     for (int i =3D 0; i &lt; ack-&gt;=
len; ++i)</span><br><span>     {</span><br><span>@@ -724,7 +724,7 @@</span>=
<br><span>  */</span><br><span> </span><br><span> void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-reliable_mark_active_incoming(struct relia=
ble *rel, struct buffer *buf, packet_id_type pid,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+reliable_mark_active_incoming(struct reliable=
 *rel, const struct buffer *buf, packet_id_type pid,</span><br><span>      =
                         int opcode)</span><br><span> {</span><br><span>   =
  for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>@@ -784,7 +78=
4,7 @@</span><br><span> </span><br><span> /* delete a buffer previously act=
ivated by reliable_mark_active() */</span><br><span> void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-reliable_mark_deleted(struct reliable *=
rel, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+reliable_mark_deleted(struct reliable *rel, const struct buffer *buf)<=
/span><br><span> {</span><br><span>     for (int i =3D 0; i &lt; rel-&gt;si=
ze; ++i)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/re=
liable=2Eh b/src/openvpn/reliable=2Eh</span><br><span>index a5ed75c=2E=2E8d=
9e2e3 100644</span><br><span>--- a/src/openvpn/reliable=2Eh</span><br><span=
>+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ -173,7 +173,7 @@</span><=
br><span>  * @li False, if there are packet IDs to be acknowledged=2E</span=
><br><span>  */</span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-reliable_ack_empty(struct reliable_ack *ack=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_empty=
(const struct reliable_ack *ack)</span><br><span> {</span><br><span>     re=
turn !ack-&gt;len;</span><br><span> }</span><br><span>@@ -186,7 +186,7 @@</=
span><br><span>  * @returns the number of outstanding acks</span><br><span>=
  */</span><br><span> static inline int</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-reliable_ack_outstanding(struct reliable_ack *ack)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_outstanding(c=
onst struct reliable_ack *ack)</span><br><span> {</span><br><span>     retu=
rn ack-&gt;len;</span><br><span> }</span><br><span>@@ -336,7 +336,7 @@</spa=
n><br><span>  * @param pid The packet&#39;s packet ID=2E</span><br><span>  =
* @param opcode The packet&#39;s opcode=2E</span><br><span>  */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void reliable_mark_active_incomin=
g(struct reliable *rel, struct buffer *buf, packet_id_type pid,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void reliable_mark_active_incom=
ing(struct reliable *rel, const struct buffer *buf, packet_id_type pid,</sp=
an><br><span>                                    int opcode);</span><br><sp=
an> </span><br><span> /**</span><br><span>@@ -389,7 +389,7 @@</span><br><sp=
an>  * @param rel The reliable structure associated with the given buffer=
=2E</span><br><span>  * @param buf The buffer of the reliable entry which i=
s to be removed=2E</span><br><span>  */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void reliable_mark_deleted(struct reliable *rel, struct b=
uffer *buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void re=
liable_mark_deleted(struct reliable *rel, const struct buffer *buf);</span>=
<br><span> </span><br><span> /** @} name Functions for extracting incoming =
packets */</span><br><span> </span><br><span>diff --git a/src/openvpn/route=
=2Ec b/src/openvpn/route=2Ec</span><br><span>index 03a2526=2E=2E078bb7e 100=
644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/o=
penvpn/route=2Ec</span><br><span>@@ -898,8 +898,9 @@</span><br><span> }</sp=
an><br><span> </span><br><span> static bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-add_bypass_routes(struct route_bypass *rb, in_addr_t =
gateway, const struct tuntap *tt,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                  unsigned int flags, const struct route_gatewa=
y_info *rgi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_byp=
ass_routes(const struct route_bypass *rb, in_addr_t gateway,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                  const struct tun=
tap *tt, unsigned int flags,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                  const struct route_gateway_info *rgi,</span><br>=
<span>                   const struct env_set *es, openvpn_net_ctx_t *ctx)<=
/span><br><span> {</span><br><span>     int ret =3D true;</span><br><span>@=
@ -916,8 +917,9 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-del_bypass_r=
outes(struct route_bypass *rb, in_addr_t gateway, const struct tuntap *tt,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  unsi=
gned int flags, const struct route_gateway_info *rgi,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+del_bypass_routes(const struct route_bypa=
ss *rb, in_addr_t gateway,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                  const struct tuntap *tt, unsigned int flags,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                  const s=
truct route_gateway_info *rgi,</span><br><span>                   const str=
uct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span=
>     int i;</span><br><span>@@ -3942,7 +3944,7 @@</span><br><span> #else  =
/* if defined(_WIN32) */</span><br><span> </span><br><span> static void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-get_bypass_addresses(stru=
ct route_bypass *rb, const unsigned int flags) /* PLATFORM-SPECIFIC */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+get_bypass_addresses(str=
uct route_bypass *rb, const unsigned int flags)</span><br><span> {</span><b=
r><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/sched=
ule=2Ec b/src/openvpn/schedule=2Ec</span><br><span>index 6772ad6=2E=2E694f4=
d1 100644</span><br><span>--- a/src/openvpn/schedule=2Ec</span><br><span>++=
+ b/src/openvpn/schedule=2Ec</span><br><span>@@ -389,4 +389,4 @@</span><br>=
<span> {</span><br><span>     s-&gt;earliest_wakeup =3D NULL; /* invalidate=
 cache */</span><br><span>     schedule_remove_node(s, e);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>\ No newline at end =
of file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><b=
r><span>index 50126bf=2E=2E6684350 100644</span><br><span>--- a/src/openvpn=
/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@=
 -619,7 +619,7 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bind_local(st=
ruct link_socket *sock, const sa_family_t ai_family)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bind_local(const struct link_socket *sock=
, const sa_family_t ai_family)</span><br><span> {</span><br><span>     /* b=
ind to local address/port */</span><br><span>     if (sock-&gt;bind_local)<=
/span><br><span>@@ -886,8 +886,8 @@</span><br><span> }</span><br><span> </s=
pan><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-so=
cket_bind(socket_descriptor_t sd, struct addrinfo *local, int ai_family, co=
nst char *prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        bool ipv6only)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+socket_bind(socket_descriptor_t sd, const struct addrinfo *local, int ai=
_family,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 const char *prefix, bool ipv6only)</span><br><span> {</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -109=
5,8 +1095,8 @@</span><br><span>  * such as TCP=2E</span><br><span>  */</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static v=
oid stream_buf_init(struct stream_buf *sb, struct buffer *buf, const unsign=
ed int sockflags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                        const int proto);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void stream_buf_init(struct stream_buf *sb, co=
nst struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                            const unsigned int sockflags, const int pro=
to);</span><br><span> </span><br><span> static void stream_buf_close(struct=
 stream_buf *sb);</span><br><span> </span><br><span>@@ -1453,7 +1453,7 @@</=
span><br><span> }</span><br><span> </span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-phase2_set_socket_flags(struct l=
ink_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ph=
ase2_set_socket_flags(const struct link_socket *sock)</span><br><span> {</s=
pan><br><span>     /* TCP_NODELAY is enabled by default on every TCP socket=
; dco-win is</span><br><span>      * skipped as it manages its own socket *=
/</span><br><span>@@ -2053,7 +2053,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-stream_buf_init(struct stream_buf *sb, struct buffer *buf, const u=
nsigned int sockflags,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+stream_buf_init(struct stream_buf *sb, const struct buffer *buf, const u=
nsigned int sockflags,</span><br><span>                 const int proto)</s=
pan><br><span> {</span><br><span>     sb-&gt;buf_init =3D *buf;</span><br><=
span>@@ -2319,7 +2319,7 @@</span><br><span> #endif</span><br><span> </span>=
<br><span> static ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-link_socket_read_udp_posix_recvmsg(struct link_socket *sock, struct buf=
fer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socke=
t_read_udp_posix_recvmsg(const struct link_socket *sock, struct buffer *buf=
,</span><br><span>                                    struct link_socket_ac=
tual *from, socklen_t *fromlen)</span><br><span> {</span><br><span>     str=
uct iovec iov;</span><br><span>@@ -2391,7 +2391,7 @@</span><br><span> #endi=
f /* if ENABLE_IP_PKTINFO */</span><br><span> </span><br><span> ssize_t</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_read_udp_posi=
x(struct link_socket *sock, struct buffer *buf,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+link_socket_read_udp_posix(const struct link_so=
cket *sock, struct buffer *buf,</span><br><span>                           =
 struct link_socket_actual *from)</span><br><span> {</span><br><span>     s=
size_t recvlen;</span><br><span>@@ -2454,7 +2454,7 @@</span><br><span> #if =
ENABLE_IP_PKTINFO</span><br><span> </span><br><span> ssize_t</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_udp_posix_sendmsg(=
struct link_socket *sock, struct buffer *buf,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+link_socket_write_udp_posix_sendmsg(const struct =
link_socket *sock, const struct buffer *buf,</span><br><span>              =
                       struct link_socket_actual *to)</span><br><span> {</s=
pan><br><span>     struct iovec iov;</span><br><span>@@ -2648,7 +2648,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-socket_send_queue(struct link_socket *s=
ock, struct buffer *buf, const struct link_socket_actual *to)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+socket_send_queue(struct link_soc=
ket *sock, const struct buffer *buf, const struct link_socket_actual *to)</=
span><br><span> {</span><br><span>     if (sock-&gt;writes=2Eiostate =3D=3D=
 IOSTATE_INITIAL)</span><br><span>     {</span><br><span>@@ -2748,8 +2748,8=
 @@</span><br><span>     return sock-&gt;writes=2Eiostate;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_sockaddr_from=
_overlapped(struct overlapped_io *io, struct sockaddr *dst, int overlapped_=
ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+read_sockaddr_from_over=
lapped(const struct overlapped_io *io, struct sockaddr *dst, int overlapped=
_ret)</span><br><span> {</span><br><span>     if (overlapped_ret &gt;=3D 0 =
&amp;&amp; io-&gt;addr_defined)</span><br><span>     {</span><br><span>diff=
 --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>in=
dex 89465bc=2E=2Ec6bcd86 100644</span><br><span>--- a/src/openvpn/socket=2E=
h</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -268,7 +2=
68,7 @@</span><br><span> </span><br><span> int socket_recv_queue(struct lin=
k_socket *sock, int maxsize);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-int socket_send_queue(struct link_socket *sock, s=
truct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt socket_send_queue(struct link_socket *sock, const struct buffer *buf,</s=
pan><br><span>                       const struct link_socket_actual *to);<=
/span><br><span> </span><br><span> typedef struct</span><br><span>@@ -348,8=
 +348,8 @@</span><br><span> </span><br><span> struct link_socket *link_sock=
et_new(void);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-void socket_bind(socket_descriptor_t sd, struct addrinfo *local, =
int af_family, const char *prefix,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                 bool ipv6only);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void socket_bind(socket_descriptor_t sd, const st=
ruct addrinfo *local, int af_family,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                 const char *prefix, bool ipv6only);</span=
><br><span> </span><br><span> int openvpn_connect(socket_descriptor_t sd, c=
onst struct sockaddr *remote, int connect_timeout,</span><br><span>        =
             volatile int *signal_received);</span><br><span>@@ -483,7 +483=
,7 @@</span><br><span> }</span><br><span> </span><br><span> static inline b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_verify=
_incoming_addr(struct buffer *buf, const struct link_socket_info *info,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_verify_inco=
ming_addr(const struct buffer *buf, const struct link_socket_info *info,</s=
pan><br><span>                                  const struct link_socket_ac=
tual *from_addr)</span><br><span> {</span><br><span>     if (buf-&gt;len &g=
t; 0)</span><br><span>@@ -607,7 +607,7 @@</span><br><span> </span><br><span=
> #else  /* ifdef _WIN32 */</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-ssize_t link_socket_read_udp_posix(struct link_sock=
et *sock, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ssize_t link_socket_read_udp_posix(const struct link_socket *sock=
, struct buffer *buf,</span><br><span>                                    s=
truct link_socket_actual *from);</span><br><span> </span><br><span> #endif =
/* ifdef _WIN32 */</span><br><span>@@ -693,12 +693,12 @@</span><br><span> <=
/span><br><span> #else /* ifdef _WIN32 */</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-ssize_t link_socket_write_udp_posix_s=
endmsg(struct link_socket *sock, struct buffer *buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ssize_t link_socket_write_udp_posix_sendm=
sg(const struct link_socket *sock, const struct buffer *buf,</span><br><spa=
n>                                             struct link_socket_actual *t=
o);</span><br><span> </span><br><span> </span><br><span> static inline ssiz=
e_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_=
udp_posix(struct link_socket *sock, struct buffer *buf,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+link_socket_write_udp_posix(const struc=
t link_socket *sock, const struct buffer *buf,</span><br><span>            =
                 struct link_socket_actual *to)</span><br><span> {</span><b=
r><span> #if ENABLE_IP_PKTINFO</span><br><span>@@ -714,7 +714,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> static inline ssize_t</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_tcp_posix(s=
truct link_socket *sock, struct buffer *buf)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+link_socket_write_tcp_posix(const struct link_sock=
et *sock, const struct buffer *buf)</span><br><span> {</span><br><span>    =
 return send(sock-&gt;sd, BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);</span><br><=
span> }</span><br><span>@@ -772,7 +772,7 @@</span><br><span>  * from tunnel=
 packet=2E</span><br><span>  */</span><br><span> static inline void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_set_tos(struct li=
nk_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+lin=
k_socket_set_tos(const struct link_socket *sock)</span><br><span> {</span><=
br><span>     if (sock &amp;&amp; sock-&gt;ptos_defined)</span><br><span>  =
   {</span><br><span>@@ -818,6 +818,8 @@</span><br><span>     }</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* cppcheck-suppress constParameterPointer</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * sock is modified on Windows via &amp;sock-&=
gt;listen_handle */</span><br><span> static inline void</span><br><span> so=
cket_reset_listen_persistent(struct link_socket *sock)</span><br><span> {</=
span><br><span>diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socke=
t_util=2Eh</span><br><span>index 13f5962=2E=2Eadd08ba 100644</span><br><spa=
n>--- a/src/openvpn/socket_util=2Eh</span><br><span>+++ b/src/openvpn/socke=
t_util=2Eh</span><br><span>@@ -439,7 +439,7 @@</span><br><span> </span><br>=
<span> </span><br><span> static inline bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-addrlist_match_proto(const struct openvpn_sockaddr *a=
1, struct addrinfo *addr_list, const int proto)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+addrlist_match_proto(const struct openvpn_socka=
ddr *a1, const struct addrinfo *addr_list, const int proto)</span><br><span=
> {</span><br><span>     return link_socket_proto_connection_oriented(proto=
) ? addrlist_match(a1, addr_list)</span><br><span>                         =
                                : addrlist_port_match(a1, addr_list);</span=
><br><span>diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec</span=
><br><span>index 19f3d54=2E=2E77ca863 100644</span><br><span>--- a/src/open=
vpn/socks=2Ec</span><br><span>+++ b/src/openvpn/socks=2Ec</span><br><span>@=
@ -82,7 +82,7 @@</span><br><span> </span><br><span> static bool</span><br><=
span> socks_proxy_recv_char(uint8_t *c, const char *name, socket_descriptor=
_t sd,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
       struct event_timeout *server_poll_timeout,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                      const struct event_time=
out *server_poll_timeout,</span><br><span>                       volatile i=
nt *signal_received)</span><br><span> {</span><br><span>     fd_set reads;<=
/span><br><span>@@ -97,8 +97,8 @@</span><br><span> }</span><br><span> </spa=
n><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-socks_username_password_auth(struct socks_proxy_info *p, socket_descript=
or_t sd,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                struct event_timeout *server_poll_timeout,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+socks_username_password_auth(const s=
truct socks_proxy_info *p, socket_descriptor_t sd,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                             const struct ev=
ent_timeout *server_poll_timeout,</span><br><span>                         =
     volatile int *signal_received)</span><br><span> {</span><br><span>    =
 char to_send[516];</span><br><span>@@ -156,8 +156,8 @@</span><br><span> }<=
/span><br><span> </span><br><span> static bool</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-socks_handshake(struct socks_proxy_info *p, socket=
_descriptor_t sd,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            struct event_timeout *server_poll_timeout, volatile int *signal=
_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socks_han=
dshake(const struct socks_proxy_info *p, socket_descriptor_t sd,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                const struct e=
vent_timeout *server_poll_timeout, volatile int *signal_received)</span><br=
><span> {</span><br><span>     uint8_t buf[2];</span><br><span>     int len=
 =3D 0;</span><br><span>@@ -231,7 +231,7 @@</span><br><span> </span><br><sp=
an> static bool</span><br><span> recv_socks_reply(socket_descriptor_t sd, s=
truct openvpn_sockaddr *addr,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                 struct event_timeout *server_poll_timeout, volatil=
e int *signal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 const struct event_timeout *server_poll_timeout, volat=
ile int *signal_received)</span><br><span> {</span><br><span>     uint8_t a=
typ =3D 0;</span><br><span>     int alen =3D 0;</span><br><span>@@ -334,11 =
+334,11 @@</span><br><span> }</span><br><span> </span><br><span> void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-establish_socks_proxy_passt=
hru(struct socks_proxy_info *p,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+establish_socks_proxy_passthru(const struct socks_proxy_info *p=
,</span><br><span>                                socket_descriptor_t sd, /=
* already open to proxy */</span><br><span>                                =
const char *host,       /* openvpn server remote */</span><br><span>       =
                         const char *servname,   /* openvpn server port */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
         struct event_timeout *server_poll_timeout,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                               const stru=
ct event_timeout *server_poll_timeout,</span><br><span>                    =
            struct signal_info *sig_info)</span><br><span> {</span><br><spa=
n>     char buf[270];</span><br><span>@@ -392,10 +392,10 @@</span><br><span=
> }</span><br><span> </span><br><span> void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-establish_socks_proxy_udpassoc(struct socks_proxy_inf=
o *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+establish_sock=
s_proxy_udpassoc(const struct socks_proxy_info *p,</span><br><span>        =
                        socket_descriptor_t ctrl_sd, /* already open to pro=
xy */</span><br><span>                                struct openvpn_sockad=
dr *relay_addr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                         struct event_timeout *server_poll_timeout,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
    const struct event_timeout *server_poll_timeout,</span><br><span>      =
                          struct signal_info *sig_info)</span><br><span> {<=
/span><br><span>     if (!socks_handshake(p, ctrl_sd, server_poll_timeout, =
&amp;sig_info-&gt;signal_received))</span><br><span>diff --git a/src/openvp=
n/socks=2Eh b/src/openvpn/socks=2Eh</span><br><span>index 846113d=2E=2Ef7c9=
3b6 100644</span><br><span>--- a/src/openvpn/socks=2Eh</span><br><span>+++ =
b/src/openvpn/socks=2Eh</span><br><span>@@ -47,17 +47,17 @@</span><br><span=
> </span><br><span> void socks_proxy_close(struct socks_proxy_info *sp);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void e=
stablish_socks_proxy_passthru(struct socks_proxy_info *p,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void establish_socks_proxy_passthru(c=
onst struct socks_proxy_info *p,</span><br><span>                          =
           socket_descriptor_t sd, /* already open to proxy */</span><br><s=
pan>                                     const char *host,       /* openvpn=
 server remote */</span><br><span>                                     cons=
t char *servname,   /* openvpn server port */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                    struct event_ti=
meout *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                    const struct event_timeout *ser=
ver_poll_timeout,</span><br><span>                                     stru=
ct signal_info *sig_info);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void establish_socks_proxy_udpassoc(struct socks_pro=
xy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void est=
ablish_socks_proxy_udpassoc(const struct socks_proxy_info *p,</span><br><sp=
an>                                     socket_descriptor_t ctrl_sd, /* alr=
eady open to proxy */</span><br><span>                                     =
struct openvpn_sockaddr *relay_addr,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                    struct event_timeout *se=
rver_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                   const struct event_timeout *server_poll_=
timeout,</span><br><span>                                     struct signal=
_info *sig_info);</span><br><span> </span><br><span> void socks_process_inc=
oming_udp(struct buffer *buf, struct link_socket_actual *from);</span><br><=
span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span=
>index 5f5d1f9=2E=2Ee376db5 100644</span><br><span>--- a/src/openvpn/ssl=2E=
c</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1153,7 +115=
3,7 @@</span><br><span> }</span><br><span> </span><br><span> struct tls_mul=
ti *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_multi_init(st=
ruct tls_options *tls_options)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+tls_multi_init(const struct tls_options *tls_options)</span><br>=
<span> {</span><br><span>     struct tls_multi *ret;</span><br><span> </spa=
n><br><span>@@ -1194,7 +1194,7 @@</span><br><span>  */</span><br><span> </s=
pan><br><span> struct tls_auth_standalone *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-tls_auth_standalone_init(struct tls_options *tls_opti=
ons, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+tls_auth_standalone_init(const struct tls_options *tls_options, struc=
t gc_arena *gc)</span><br><span> {</span><br><span>     struct tls_auth_sta=
ndalone *tas;</span><br><span> </span><br><span>@@ -1342,7 +1342,7 @@</span=
><br><span> </span><br><span> static void</span><br><span> init_epoch_keys(=
struct key_state *ks, struct tls_multi *multi, const struct key_type *key_t=
ype,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                b=
ool server, struct key2 *key2)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                bool server, const struct key2 *key2)</span><br>=
<span> {</span><br><span>     /* For now we hardcode this to be 4 for the s=
oftware based data channel</span><br><span>      * DCO based implementation=
s/HW implementation might adjust this number</span><br><span>@@ -1385,7 +13=
85,7 @@</span><br><span> </span><br><span> static void</span><br><span> ini=
t_key_contexts(struct key_state *ks, struct tls_multi *multi, const struct =
key_type *key_type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                bool server, struct key2 *key2, bool dco_enabled)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                  bool server=
, const struct key2 *key2, bool dco_enabled)</span><br><span> {</span><br><=
span>     struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=2Ekey_ctx_b=
i;</span><br><span> </span><br><span>@@ -1583,8 +1583,9 @@</span><br><span>=
 </span><br><span> bool</span><br><span> tls_session_update_crypto_params_d=
o_work(struct tls_multi *multi, struct tls_session *session,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
     struct options *options, struct frame *frame,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                         struc=
t frame *frame_fragment, struct link_socket_info *lsi,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
 const struct options *options, struct frame *frame,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
struct frame *frame_fragment,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                         const struct link_socket=
_info *lsi,</span><br><span>                                          dco_c=
ontext_t *dco)</span><br><span> {</span><br><span>     if (session-&gt;key[=
KS_PRIMARY]=2Ecrypto_options=2Ekey_ctx_bi=2Einitialized)</span><br><span>@@=
 -1653,7 +1654,7 @@</span><br><span> bool</span><br><span> tls_session_upda=
te_crypto_params(struct tls_multi *multi, struct tls_session *session,</spa=
n><br><span>                                  struct options *options, stru=
ct frame *frame,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                            struct frame *frame_fragment, struct link_socke=
t_info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                          struct frame *frame_fragment, const struct link_s=
ocket_info *lsi,</span><br><span>                                  dco_cont=
ext_t *dco)</span><br><span> {</span><br><span>     if (!check_session_ciph=
er(session, options))</span><br><span>@@ -1869,7 +1870,8 @@</span><br><span=
> }</span><br><span> </span><br><span> static bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-push_peer_info_peerid(struct buffer *out, stru=
ct tls_multi *multi, struct tls_session *session)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+push_peer_info_peerid(struct buffer *out, con=
st struct tls_multi *multi,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                      const struct tls_session *session)</span><br>=
<span> {</span><br><span>     if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID |=
| session-&gt;opt-&gt;dco_enabled)</span><br><span>     {</span><br><span>@=
@ -1904,7 +1906,7 @@</span><br><span>  * @return          true if no error =
was encountered</span><br><span>  */</span><br><span> static bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-push_peer_info(struct buffer *b=
uf, struct tls_multi *multi, struct tls_session *session)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+push_peer_info(struct buffer *buf, co=
nst struct tls_multi *multi, struct tls_session *session)</span><br><span> =
{</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>   =
  bool ret =3D false;</span><br><span>@@ -2548,8 +2550,8 @@</span><br><span=
> }</span><br><span> </span><br><span> bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-session_skip_to_pre_start(struct tls_session *session=
, struct tls_pre_decrypt_state *state,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                          struct link_socket_actual *from)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+session_skip_to_pre=
_start(struct tls_session *session, const struct tls_pre_decrypt_state *sta=
te,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
          const struct link_socket_actual *from)</span><br><span> {</span><=
br><span>     struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</s=
pan><br><span>     ks-&gt;session_id_remote =3D state-&gt;peer_session_id;<=
/span><br><span>@@ -2767,7 +2769,7 @@</span><br><span> </span><br><span> st=
atic bool</span><br><span> check_outgoing_ciphertext(struct key_state *ks, =
struct tls_session *session,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                          struct buffer *to_link, bool *continue_tls=
_process)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                const struct buffer *to_link, bool *continue_tls_process)</=
span><br><span> {</span><br><span>     if (to_link-&gt;len)</span><br><span=
>     {</span><br><span>@@ -4096,7 +4098,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-tls_post_encrypt(struct tls_multi *multi, struct buffer *buf)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_post_encrypt(struct t=
ls_multi *multi, const struct buffer *buf)</span><br><span> {</span><br><sp=
an>     struct key_state *ks =3D multi-&gt;save_ks;</span><br><span>     mu=
lti-&gt;save_ks =3D NULL;</span><br><span>@@ -4227,7 +4229,7 @@</span><br><=
span>  * into a garbage collectable string which is returned=2E</span><br><=
span>  */</span><br><span> const char *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-protocol_dump(struct buffer *buffer, unsigned int flags, =
struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+protocol_dump(const struct buffer *buffer, unsigned int flags, struct gc_a=
rena *gc)</span><br><span> {</span><br><span>     struct buffer out =3D all=
oc_buf_gc(256, gc);</span><br><span>     struct buffer buf =3D *buffer;</sp=
an><br><span>diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh</span><=
br><span>index 7ddf965=2E=2E93e6200 100644</span><br><span>--- a/src/openvp=
n/ssl=2Eh</span><br><span>+++ b/src/openvpn/ssl=2Eh</span><br><span>@@ -166=
,7 +166,7 @@</span><br><span>  *</span><br><span>  * @return A newly alloca=
ted and initialized \c tls_multi structure=2E</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-struct tls_multi *tls_multi_in=
it(struct tls_options *tls_options);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+struct tls_multi *tls_multi_init(const struct tls_options =
*tls_options);</span><br><span> </span><br><span> /**</span><br><span>  * F=
inalize initialization of a \c tls_multi structure=2E</span><br><span>@@ -1=
87,7 +187,7 @@</span><br><span> /*</span><br><span>  * Initialize a standal=
one tls-auth verification object=2E</span><br><span>  */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-struct tls_auth_standalone *tls_auth_sta=
ndalone_init(struct tls_options *tls_options,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+struct tls_auth_standalone *tls_auth_standalone_i=
nit(const struct tls_options *tls_options,</span><br><span>                =
                                      struct gc_arena *gc);</span><br><span=
> </span><br><span> /**</span><br><span>@@ -371,7 +371,7 @@</span><br><span=
>  * @param multi - The TLS state for this packet&#39;s destination VPN tun=
nel=2E</span><br><span>  * @param buf - The buffer containing the outgoing =
packet=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void tls_post_encrypt(struct tls_multi *multi, struct buffer *buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tls_post_encr=
ypt(struct tls_multi *multi, const struct buffer *buf);</span><br><span> </=
span><br><span> /** @} name Functions for managing security parameter state=
 for data channel packets */</span><br><span> </span><br><span>@@ -461,7 +4=
61,8 @@</span><br><span>  */</span><br><span> bool tls_session_update_crypt=
o_params(struct tls_multi *multi, struct tls_session *session,</span><br><s=
pan>                                       struct options *options, struct =
frame *frame,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                              struct frame *frame_fragment, struct link_soc=
ket_info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                 struct frame *frame_fragment,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
      const struct link_socket_info *lsi,</span><br><span>                 =
                      dco_context_t *dco);</span><br><span> </span><br><spa=
n> /*</span><br><span>@@ -525,7 +526,7 @@</span><br><span> #define PD_VERBO=
SE                 (1 &lt;&lt; 10)</span><br><span> #define PD_TLS_CRYPT   =
            (1 &lt;&lt; 11)</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-const char *protocol_dump(struct buffer *buffer, un=
signed int flags, struct gc_arena *gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+const char *protocol_dump(const struct buffer *buffer, =
unsigned int flags, struct gc_arena *gc);</span><br><span> </span><br><span=
> /*</span><br><span>  * debugging code</span><br><span>@@ -573,7 +574,7 @@=
</span><br><span> /* Special method to skip the three way handshake RESET s=
tages=2E This is</span><br><span>  * used by the HMAC code when seeing a pa=
cket that matches the previous</span><br><span>  * HMAC based stateless ser=
ver state */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool sess=
ion_skip_to_pre_start(struct tls_session *session, struct tls_pre_decrypt_s=
tate *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                      struct link_socket_actual *from);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool session_skip_to_pre_start(struct t=
ls_session *session, const struct tls_pre_decrypt_state *state,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
const struct link_socket_actual *from);</span><br><span> </span><br><span> =
#endif /* ifndef OPENVPN_SSL_H */</span><br><span>diff --git a/src/openvpn/=
ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh</span><br><span>index a6d57f2=
=2E=2E29e07a6 100644</span><br><span>--- a/src/openvpn/ssl_backend=2Eh</spa=
n><br><span>+++ b/src/openvpn/ssl_backend=2Eh</span><br><span>@@ -137,7 +13=
7,7 @@</span><br><span>  *</span><br><span>  * @return      true if the con=
text is initialised, false if not=2E</span><br><span>  */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-bool tls_ctx_initialised(struct tls_roo=
t_ctx *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool tl=
s_ctx_initialised(const struct tls_root_ctx *ctx);</span><br><span> </span>=
<br><span> /**</span><br><span>  * Set any library specific options=2E</spa=
n><br><span>@@ -170,7 +170,7 @@</span><br><span>  * @param ciphers       St=
ring containing : delimited cipher names, or NULL to use</span><br><span>  =
*                                      sane defaults=2E</span><br><span>  *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tls_ctx_restric=
t_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void tls_ctx_restrict_ciphers_t=
ls13(const struct tls_root_ctx *ctx, const char *ciphers);</span><br><span>=
 </span><br><span> /**</span><br><span>  * Set the TLS certificate profile=
=2E  The profile defines which crypto</span><br><span>diff --git a/src/open=
vpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index c92=
c423=2E=2Ecddf856 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec<=
/span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -146,7=
 +146,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_initialised(struct =
tls_root_ctx *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
ls_ctx_initialised(const struct tls_root_ctx *ctx)</span><br><span> {</span=
><br><span>     /* either this should be NULL or should be non-null and the=
n have a</span><br><span>      * valid TLS ctx inside as well */</span><br>=
<span>@@ -269,7 +269,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_rest=
rict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_restrict_ciphers_tls1=
3(const struct tls_root_ctx *ctx, const char *ciphers)</span><br><span> {</=
span><br><span>     if (ciphers =3D=3D NULL)</span><br><span>     {</span><=
br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=
=2Ec</span><br><span>index 7cfe9f4=2E=2Ecb3de65 100644</span><br><span>--- =
a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=
=2Ec</span><br><span>@@ -129,7 +129,7 @@</span><br><span> }</span><br><span=
> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-tls_ctx_initialised(struct tls_root_ctx *ctx)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+tls_ctx_initialised(const struct tls_root_ctx =
*ctx)</span><br><span> {</span><br><span>     /* either this should be NULL=
 or should be non-null and then have a</span><br><span>      * valid TLS ct=
x inside as well */</span><br><span>@@ -446,7 +446,7 @@</span><br><span> #e=
ndif</span><br><span> </span><br><span> void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *=
ctx, const char *ciphers)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const =
char *ciphers)</span><br><span> {</span><br><span>     if (ciphers =3D=3D N=
ULL)</span><br><span>     {</span><br><span>@@ -1093,7 +1093,7 @@</span><br=
><span> }</span><br><span> </span><br><span> static void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-tls_ctx_load_cert_uri(struct tls_root_ct=
x *tls_ctx, const char *uri)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+tls_ctx_load_cert_uri(const struct tls_root_ctx *tls_ctx, const ch=
ar *uri)</span><br><span> {</span><br><span> #if defined(HAVE_OPENSSL_STORE=
_API)</span><br><span>     X509 *x =3D NULL;</span><br><span>@@ -2008,7 +20=
08,7 @@</span><br><span> }</span><br><span> </span><br><span> static void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-bio_debug_data(const ch=
ar *mode, BIO *bio, const uint8_t *buf, int len, const char *desc)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bio_debug_data(const char *m=
ode, const BIO *bio, const uint8_t *buf, int len, const char *desc)</span><=
br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br=
><span>     if (len &gt; 0)</span><br><span>@@ -2022,7 +2022,7 @@</span><br=
><span> }</span><br><span> </span><br><span> static void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-bio_debug_oc(const char *mode, BIO *bio)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bio_debug_oc(const =
char *mode, const BIO *bio)</span><br><span> {</span><br><span>     open_bi=
ofp();</span><br><span>     fprintf(biofp, &quot;BIO %s time=3D%&quot; PRIi=
64 &quot; bio=3D&quot; ptr_format &quot;\n&quot;, mode, (int64_t)time(NULL)=
,</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pk=
t=2Ec</span><br><span>index 6a6d9f9=2E=2E4ced4c4 100644</span><br><span>---=
 a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</s=
pan><br><span>@@ -58,7 +58,7 @@</span><br><span>  *  @return         if the=
 swap was successful (buf was large enough)</span><br><span>  */</span><br>=
<span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-swa=
p_hmac(struct buffer *buf, const struct crypto_options *co, bool incoming)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+swap_hmac(const stru=
ct buffer *buf, const struct crypto_options *co, bool incoming)</span><br><=
span> {</span><br><span>     ASSERT(co);</span><br><span> </span><br><span>=
@@ -118,7 +118,7 @@</span><br><span>  */</span><br><span> static void</span=
><br><span> tls_wrap_control(struct tls_wrap_ctx *ctx, uint8_t header, stru=
ct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
           struct session_id *session_id)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                 const struct session_id *session_id)=
</span><br><span> {</span><br><span>     if (ctx-&gt;mode =3D=3D TLS_WRAP_A=
UTH || ctx-&gt;mode =3D=3D TLS_WRAP_NONE)</span><br><span>     {</span><br>=
<span>@@ -402,9 +402,9 @@</span><br><span> </span><br><span> </span><br><sp=
an> struct buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_=
reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
struct session_id *own_sid, struct session_id *remote_sid, uint8_t header,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     b=
ool request_resend_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_st=
andalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                const struct session_id *own_sid, const struct session_id *=
remote_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
             uint8_t header, bool request_resend_wkc)</span><br><span> {</s=
pan><br><span>     /* Copy buffer here to point at the same data but allow =
tls_wrap_control</span><br><span>      * to potentially change buf to point=
 to another buffer without</span><br><span>@@ -489,7 +489,7 @@</span><br><s=
pan> bool</span><br><span> check_session_hmac_and_pkt_id(struct tls_pre_dec=
rypt_state *state,</span><br><span>                               const str=
uct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                              uint8_t *key,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                              const uint8_t *=
key,</span><br><span>                               int handwindow,</span><=
br><span>                               bool pkt_is_ack)</span><br><span> {=
</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=
=2Eh</span><br><span>index 03e8930=2E=2E8203e4a 100644</span><br><span>--- =
a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</sp=
an><br><span>@@ -183,7 +183,7 @@</span><br><span>  * @return              t=
he expected server session id</span><br><span>  */</span><br><span> bool ch=
eck_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const stru=
ct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                   uint8_t *key, int handwindow, bool =
pkt_is_ack);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                            const uint8_t *key, int handwindow, bool pkt_is=
_ack);</span><br><span> </span><br><span> /*</span><br><span>  * Write a co=
ntrol channel authentication record=2E</span><br><span>@@ -210,8 +210,9 @@<=
/span><br><span>  * from the tls pre decrypt state=2E</span><br><span>  *</=
span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
ruct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_=
standalone *tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                              struct session_id *own_sid, struct session_id=
 *remote_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct=
 buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_aut=
h_standalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                  const struct session_id *own_sid,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
        const struct session_id *remote_sid,</span><br><span>              =
                      uint8_t header, bool request_resend_wkc);</span><br><=
span> </span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_verif=
y=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 063fa5d=2E=2E3304c=
b46 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span=
>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1139,7 +1139,7 @@</sp=
an><br><span>  * cache=2E</span><br><span>  */</span><br><span> static bool=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_authentication_st=
atus_use_cache(struct tls_multi *multi)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+tls_authentication_status_use_cache(const struct tls_mu=
lti *multi)</span><br><span> {</span><br><span>     unsigned int idx =3D mi=
n_uint(multi-&gt;tas_cache_num_updates, SIZE(cache_intervals) - 1);</span><=
br><span>     time_t latency =3D cache_intervals[idx];</span><br><span>@@ -=
1283,7 +1283,7 @@</span><br><span>  * Check if the script/plugin left a mes=
sage in the auth failed message</span><br><span>  * file and relay it to th=
e user */</span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-check_for_client_reason(struct tls_multi *multi, struct au=
th_deferred_status *status)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+check_for_client_reason(struct tls_multi *multi, const struct auth_=
deferred_status *status)</span><br><span> {</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span>     const char *msg =3D key_state_c=
heck_auth_failed_message_file(status, &amp;gc);</span><br><span>@@ -1552,7 =
+1552,7 @@</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br>=
<span> </span><br><span> static bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-set_verify_user_pass_env(struct user_pass *up, struct tls_mu=
lti *multi, struct tls_session *session)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+set_verify_user_pass_env(const struct user_pass *up, s=
truct tls_multi *multi, struct tls_session *session)</span><br><span> {</sp=
an><br><span>     /* Is username defined? */</span><br><span>     if ((sess=
ion-&gt;opt-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up-=
&gt;username))</span><br><span>@@ -1580,7 +1580,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-ssl_verify_username_length(struct tls_session *session, cons=
t char *username)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ss=
l_verify_username_length(const struct tls_session *session, const char *use=
rname)</span><br><span> {</span><br><span>     if ((session-&gt;opt-&gt;ssl=
_flags &amp; SSLF_USERNAME_AS_COMMON_NAME)</span><br><span>         &amp;&a=
mp; strlen(username) &gt; TLS_USERNAME_LEN)</span><br><span>diff --git a/sr=
c/openvpn/ssl_verify=2Eh b/src/openvpn/ssl_verify=2Eh</span><br><span>index=
 3176d76=2E=2Ee77bc4a 100644</span><br><span>--- a/src/openvpn/ssl_verify=
=2Eh</span><br><span>+++ b/src/openvpn/ssl_verify=2Eh</span><br><span>@@ -2=
02,7 +202,7 @@</span><br><span>  * @return              true if name is und=
er limit or username-as-common-name</span><br><span>  *                    =
  is not active</span><br><span>  */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-bool ssl_verify_username_length(struct tls_session *session,=
 const char *username);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool ssl_verify_username_length(const struct tls_session *session, cons=
t char *username);</span><br><span> </span><br><span> /**</span><br><span> =
 * Runs the --client-crresponse script if one is defined=2E</span><br><span=
>@@ -275,7 +275,7 @@</span><br><span> void auth_set_client_reason(struct tl=
s_multi *multi, const char *client_reason);</span><br><span> </span><br><sp=
an> static inline const char *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-tls_client_reason(struct tls_multi *multi)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tls_client_reason(const struct tls_multi =
*multi)</span><br><span> {</span><br><span>     return multi-&gt;client_rea=
son;</span><br><span> }</span><br><span>diff --git a/src/openvpn/status=2Ec=
 b/src/openvpn/status=2Ec</span><br><span>index c7d375b=2E=2Ecfbc38d 100644=
</span><br><span>--- a/src/openvpn/status=2Ec</span><br><span>+++ b/src/ope=
nvpn/status=2Ec</span><br><span>@@ -135,7 +135,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-status_reset(struct status_output *so)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+status_reset(const struct status_output *=
so)</span><br><span> {</span><br><span>     if (so &amp;&amp; so-&gt;fd &gt=
;=3D 0)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/sta=
tus=2Eh b/src/openvpn/status=2Eh</span><br><span>index 7953a4e=2E=2E4c01d75=
 100644</span><br><span>--- a/src/openvpn/status=2Eh</span><br><span>+++ b/=
src/openvpn/status=2Eh</span><br><span>@@ -69,7 +69,7 @@</span><br><span> <=
/span><br><span> bool status_trigger(struct status_output *so);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void status_res=
et(struct status_output *so);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void status_reset(const struct status_output *so);</span><br><spa=
n> </span><br><span> void status_flush(struct status_output *so);</span><br=
><span> </span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=
=2Ec</span><br><span>index af48921=2E=2Eabb46af 100644</span><br><span>--- =
a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><=
span>@@ -835,7 +835,7 @@</span><br><span>          const char *ifconfig_ipv=
6_local_parm,     /* --ifconfig parm 1 IPv6 */</span><br><span>          in=
t ifconfig_ipv6_netbits_parm,</span><br><span>          const char *ifconfi=
g_ipv6_remote_parm,    /* --ifconfig parm 2 IPv6 */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         struct addrinfo *local_public, str=
uct addrinfo *remote_public, const bool strict_warn,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         const struct addrinfo *local_pub=
lic, const struct addrinfo *remote_public, const bool strict_warn,</span><b=
r><span>          struct env_set *es, openvpn_net_ctx_t *ctx, struct tuntap=
 *tt)</span><br><span> {</span><br><span>     if (!tt)</span><br><span>@@ -=
978,7 +978,7 @@</span><br><span>  * -&gt; helper function to simplify code =
below</span><br><span>  */</span><br><span> static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-add_route_connected_v6_net(struct tuntap =
*tt, const struct env_set *es)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+add_route_connected_v6_net(const struct tuntap *tt, const struct=
 env_set *es)</span><br><span> {</span><br><span>     struct route_ipv6 r6;=
</span><br><span> </span><br><span>@@ -1020,7 +1020,7 @@</span><br><span>  =
*/</span><br><span> </span><br><span> in_addr_t</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-create_arbitrary_remote(struct tuntap *tt)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+create_arbitrary_remote(co=
nst struct tuntap *tt)</span><br><span> {</span><br><span>     in_addr_t re=
mote;</span><br><span> </span><br><span>@@ -1592,7 +1592,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv4(struct tuntap *tt, openv=
pn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
ndo_ifconfig_ipv4(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><b=
r><span> {</span><br><span> #if defined(TARGET_LINUX)</span><br><span>     =
int netbits =3D netmask_to_netbits2(tt-&gt;remote_netmask);</span><br><span=
>@@ -1627,7 +1627,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifc=
onfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv6(const struct tuntap *t=
t, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #if defined(=
TARGET_LINUX)</span><br><span>     if (net_addr_v6_del(ctx, tt-&gt;actual_n=
ame, &amp;tt-&gt;local_ipv6, tt-&gt;netbits_ipv6) &lt; 0)</span><br><span>@=
@ -1652,7 +1652,7 @@</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig(str=
uct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_=
t *ctx)</span><br><span> {</span><br><span>     if (tt-&gt;backend_driver !=
=3D DRIVER_NULL &amp;&amp; tt-&gt;backend_driver !=3D DRIVER_AFUNIX)</span>=
<br><span>     {</span><br><span>@@ -1720,7 +1720,7 @@</span><br><span> }</=
span><br><span> </span><br><span> static ssize_t</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-write_tun_header(struct tuntap *tt, uint8_t *buf=
, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun=
_header(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><sp=
an> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><=
span>     {</span><br><span>@@ -1737,9 +1737,11 @@</span><br><span>        =
     type =3D htonl(AF_INET);</span><br><span>         }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* argument =
to writev is a pointer to const but we still need to drop</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * the const from buf pointer=
 here */</span><br><span>         iv[0]=2Eiov_base =3D &amp;type;</span><br=
><span>         iv[0]=2Eiov_len =3D sizeof(type);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        iv[1]=2Eiov_base =3D buf;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        iv[1]=2Eiov_base =3D (voi=
d *)buf;</span><br><span>         iv[1]=2Eiov_len =3D len;</span><br><span>=
 </span><br><span>         return header_modify_read_write_return(writev(tt=
-&gt;fd, iv, 2));</span><br><span>@@ -1751,7 +1753,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> static ssize_t</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-read_tun_header(struct tuntap *tt, uint8_t *buf=
, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun_=
header(const struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</=
span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>  =
   {</span><br><span>@@ -1777,13 +1779,13 @@</span><br><span>  */</span><br=
><span> #if !defined(TARGET_DARWIN)</span><br><span> ssize_t</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t=
 *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+writ=
e_tun(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><span=
> {</span><br><span>     return write_tun_header(tt, buf, len);</span><br><=
span> }</span><br><span> </span><br><span> ssize_t</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int =
len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const =
struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><spa=
n>     return read_tun_header(tt, buf, len);</span><br><span> }</span><br><=
span>@@ -1799,7 +1801,7 @@</span><br><span> </span><br><span> #if defined(T=
ARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span> static bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-tun_dco_enabled(struct tunta=
p *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_dco_enabl=
ed(const struct tuntap *tt)</span><br><span> {</span><br><span>     return =
tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><br><span> }</span><br><span=
>@@ -2046,13 +2048,13 @@</span><br><span> }</span><br><span> </span><br><sp=
an> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(=
struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t *buf=
, int len)</span><br><span> {</span><br><span>     return write(tt-&gt;fd, =
buf, len);</span><br><span> }</span><br><span> </span><br><span> ssize_t</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *=
tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</span><br><=
span> {</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><s=
pan> }</span><br><span>@@ -2251,13 +2253,13 @@</span><br><span> }</span><br=
><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *=
tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span>     re=
turn write(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span> </span=
><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-re=
ad_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf=
, int len)</span><br><span> {</span><br><span>     return read(tt-&gt;fd, b=
uf, len);</span><br><span> }</span><br><span>@@ -2587,7 +2589,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> ssize_t</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, =
int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(c=
onst struct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</sp=
an><br><span>     struct strbuf sbuf;</span><br><span>     sbuf=2Elen =3D l=
en;</span><br><span>@@ -2596,7 +2598,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uin=
t8_t *buf, int len)</span><br><span> {</span><br><span>     struct strbuf s=
buf;</span><br><span>     int f =3D 0;</span><br><span>@@ -3094,7 +3096,7 @=
@</span><br><span> }</span><br><span> </span><br><span> ssize_t</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint=
8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+w=
rite_tun(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><s=
pan> {</span><br><span>     if (tt-&gt;backend_driver =3D=3D DRIVER_UTUN)</=
span><br><span>     {</span><br><span>@@ -3107,7 +3109,7 @@</span><br><span=
> }</span><br><span> </span><br><span> ssize_t</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const stru=
ct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>  =
   if (tt-&gt;backend_driver =3D=3D DRIVER_UTUN)</span><br><span>     {</sp=
an><br><span>@@ -3311,7 +3313,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_=
write_queue(struct tuntap *tt, struct buffer *buf)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+tun_write_queue(struct tuntap *tt, const str=
uct buffer *buf)</span><br><span> {</span><br><span>     if (tt-&gt;writes=
=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><span>     {</span><br><span>@=
@ -3366,7 +3368,7 @@</span><br><span> }</span><br><span> </span><br><span> =
int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_write_win32(st=
ruct tuntap *tt, struct buffer *buf)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+tun_write_win32(struct tuntap *tt, const struct buffer *bu=
f)</span><br><span> {</span><br><span>     int err =3D 0;</span><br><span> =
    int status =3D 0;</span><br><span>@@ -5374,7 +5376,7 @@</span><br><span=
> }</span><br><span> </span><br><span> void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-fork_register_dns_action(struct tuntap *tt)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+fork_register_dns_action(cons=
t struct tuntap *tt)</span><br><span> {</span><br><span>     if (tt &amp;&a=
mp; tt-&gt;options=2Eregister_dns &amp;&amp; tt-&gt;options=2Emsg_channel)<=
/span><br><span>     {</span><br><span>@@ -5464,7 +5466,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tuntap_get_mtu(struct tuntap *tt)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_get_mtu(const struct t=
untap *tt)</span><br><span> {</span><br><span>     ULONG mtu =3D 0;</span><=
br><span>     DWORD len;</span><br><span>@@ -6039,7 +6041,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-tun_show_debug(struct tuntap *tt)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+tun_show_debug(const struct tuntap *=
tt)</span><br><span> {</span><br><span>     if (tt-&gt;backend_driver =3D=
=3D WINDOWS_DRIVER_TAP_WINDOWS6)</span><br><span>     {</span><br><span>dif=
f --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh</span><br><span>index 9=
31e54d=2E=2Ebeb0d0e 100644</span><br><span>--- a/src/openvpn/tun=2Eh</span>=
<br><span>+++ b/src/openvpn/tun=2Eh</span><br><span>@@ -272,9 +272,9 @@</sp=
an><br><span> </span><br><span> void close_tun_handle(struct tuntap *tt);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize=
_t write_tun(struct tuntap *tt, uint8_t *buf, int len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ssize_t write_tun(const struct tuntap *=
tt, const uint8_t *buf, int len);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ssize_t read_tun(struct tuntap *tt, uint8_t=
 *buf, int len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssi=
ze_t read_tun(const struct tuntap *tt, uint8_t *buf, int len);</span><br><s=
pan> </span><br><span> #ifdef ENABLE_FEATURE_TUN_PERSIST</span><br><span> v=
oid tuncfg(const char *dev, const char *dev_type, const char *dev_node, int=
 persist_mode,</span><br><span>@@ -293,7 +293,7 @@</span><br><span>        =
                 const char *ifconfig_ipv6_local_parm,     /* --ifconfig pa=
rm 1 / IPv6 */</span><br><span>                         int ifconfig_ipv6_n=
etbits_parm,           /* --ifconfig parm 1 / bits */</span><br><span>     =
                    const char *ifconfig_ipv6_remote_parm,    /* --ifconfig=
 parm 2 / IPv6 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    struct addrinfo *local_public, struct addrinfo *remote_=
public,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            const struct addrinfo *local_public, const struct addrinfo *rem=
ote_public,</span><br><span>                         const bool strict_warn=
, struct env_set *es, openvpn_net_ctx_t *ctx,</span><br><span>             =
            struct tuntap *tt);</span><br><span> </span><br><span>@@ -320,7=
 +320,7 @@</span><br><span>  * @param tt    the tuntap interface context</s=
pan><br><span>  * @param ctx   the networking API opaque context</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void undo_i=
fconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void undo_ifconfig(const struct tuntap *t=
t, openvpn_net_ctx_t *ctx);</span><br><span> </span><br><span> bool is_dev_=
type(const char *dev, const char *dev_type, const char *match_type);</span>=
<br><span> </span><br><span>@@ -351,7 +351,7 @@</span><br><span> #define IF=
CONFIG_DEFAULT IFCONFIG_AFTER_TUN_OPEN</span><br><span> </span><br><span> s=
tatic inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifcon=
fig_order(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ifconfig_order(const struct tuntap *tt)</span><br><span> {</span><=
br><span>     if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><sp=
an>     {</span><br><span>@@ -381,7 +381,7 @@</span><br><span> #define ROUT=
E_ORDER_DEFAULT ROUTE_AFTER_TUN</span><br><span> </span><br><span> static i=
nline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-route_order(=
struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+r=
oute_order(const struct tuntap *tt)</span><br><span> {</span><br><span>    =
 if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</sp=
an><br><span>@@ -454,13 +454,13 @@</span><br><span> </span><br><span> const=
 char *tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tun_=
show_debug(struct tuntap *tt);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void tun_show_debug(const struct tuntap *tt);</span><br><span> <=
/span><br><span> bool dhcp_release_by_adapter_index(const DWORD adapter_ind=
ex);</span><br><span> </span><br><span> bool dhcp_renew_by_adapter_index(co=
nst DWORD adapter_index);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void fork_register_dns_action(struct tuntap *tt);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void fork_register_dns_=
action(const struct tuntap *tt);</span><br><span> </span><br><span> void ip=
config_register_dns(const struct env_set *es);</span><br><span> </span><br>=
<span>@@ -470,7 +470,7 @@</span><br><span> </span><br><span> int tun_read_q=
ueue(struct tuntap *tt, int maxsize);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-int tun_write_queue(struct tuntap *tt, st=
ruct buffer *buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt tun_write_queue(struct tuntap *tt, const struct buffer *buf);</span><br>=
<span> </span><br><span> static inline bool</span><br><span> tuntap_stop(in=
t status)</span><br><span>@@ -499,7 +499,7 @@</span><br><span>     return f=
alse;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-int tun_write_win32(struct tuntap *tt, struct buffer *=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int tun_write_=
win32(struct tuntap *tt, const struct buffer *buf);</span><br><span> </span=
><br><span> static inline bool</span><br><span> is_ip_packet_valid(const st=
ruct buffer *buf)</span><br><span>@@ -529,13 +529,13 @@</span><br><span> }<=
/span><br><span> </span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win(struct tuntap *tt)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win(const st=
ruct tuntap *tt)</span><br><span> {</span><br><span>     return tt &amp;&am=
p; tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><br><span> }</span><br><s=
pan> </span><br><span> static inline bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t st=
atus)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_=
win_timeout(const struct tuntap *tt, ssize_t status)</span><br><span> {</sp=
an><br><span>     return tuntap_is_dco_win(tt) &amp;&amp; (status &lt; 0) &=
amp;&amp; (openvpn_errno() =3D=3D ERROR_NETNAME_DELETED);</span><br><span> =
}</span><br><span>@@ -555,25 +555,25 @@</span><br><span> }</span><br><span>=
 </span><br><span> static inline void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-tun_standby_init(struct tuntap *tt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tun_standby_init(const struct tuntap *tt)=
</span><br><span> {</span><br><span> }</span><br><span> </span><br><span> s=
tatic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_=
standby(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+tun_standby(const struct tuntap *tt)</span><br><span> {</span><br><s=
pan>     return true;</span><br><span> }</span><br><span> </span><br><span>=
 </span><br><span> static inline bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-tuntap_is_dco_win(struct tuntap *tt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win(const struct tuntap *tt=
)</span><br><span> {</span><br><span>     return false;</span><br><span> }<=
/span><br><span> </span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win_timeout(struct tuntap *tt=
, ssize_t status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tu=
ntap_is_dco_win_timeout(const struct tuntap *tt, ssize_t status)</span><br>=
<span> {</span><br><span>     return false;</span><br><span> }</span><br><s=
pan>diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec</s=
pan><br><span>index a67a472=2E=2Ee9223bc 100644</span><br><span>--- a/src/o=
penvpn/tun_afunix=2Ec</span><br><span>+++ b/src/openvpn/tun_afunix=2Ec</spa=
n><br><span>@@ -48,7 +48,7 @@</span><br><span> </span><br><span> </span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tu=
n_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct env_set=
 *env)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_ex=
ec_child(const char *dev_node, struct tuntap *tt, const struct env_set *env=
)</span><br><span> {</span><br><span>     const char *msgprefix =3D &quot;E=
RROR: failure executing process for tun:&quot;;</span><br><span>     struct=
 argv argv =3D argv_new();</span><br><span>@@ -73,7 +73,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-open_tun_afunix(struct options *o, int mtu, struct t=
untap *tt, struct env_set *orig_env)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+open_tun_afunix(const struct options *o, int mtu, struct t=
untap *tt, const struct env_set *orig_env)</span><br><span> {</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>=
diff --git a/src/openvpn/tun_afunix=2Eh b/src/openvpn/tun_afunix=2Eh</span>=
<br><span>index 5b6a8e0=2E=2Efb88eb2 100644</span><br><span>--- a/src/openv=
pn/tun_afunix=2Eh</span><br><span>+++ b/src/openvpn/tun_afunix=2Eh</span><b=
r><span>@@ -31,7 +31,7 @@</span><br><span>  * the user provided taking care=
 of implementing the actual tun</span><br><span>  * device=2E</span><br><sp=
an>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void open_tun_=
afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set *env);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void open_tun_afuni=
x(const struct options *o, int mtu, struct tuntap *tt, const struct env_set=
 *env);</span><br><span> </span><br><span> </span><br><span> /**</span><br>=
<span>diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec</span><br><s=
pan>index bffc60e=2E=2Ecd32a9b 100644</span><br><span>--- a/src/openvpn/vla=
n=2Ec</span><br><span>+++ b/src/openvpn/vlan=2Ec</span><br><span>@@ -288,7 =
+288,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-vlan_process_outgoing_tun(st=
ruct multi_context *m, struct multi_instance *mi)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+vlan_process_outgoing_tun(const struct multi_=
context *m, struct multi_instance *mi)</span><br><span> {</span><br><span> =
    if (!m-&gt;top=2Eoptions=2Evlan_tagging)</span><br><span>     {</span><=
br><span>diff --git a/src/openvpn/vlan=2Eh b/src/openvpn/vlan=2Eh</span><br=
><span>index 9389f89=2E=2Ecd2f66f 100644</span><br><span>--- a/src/openvpn/=
vlan=2Eh</span><br><span>+++ b/src/openvpn/vlan=2Eh</span><br><span>@@ -35,=
6 +35,6 @@</span><br><span> </span><br><span> bool vlan_is_tagged(const str=
uct buffer *buf);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void vlan_process_outgoing_tun(struct multi_context *m, struc=
t multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void vlan_process_outgoing_tun(const struct multi_context *m, struct mul=
ti_instance *mi);</span><br><span> </span><br><span> #endif /* VLAN_H */</s=
pan><br><span>diff --git a/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh</s=
pan><br><span>index ef32062=2E=2Ebcbfa67 100644</span><br><span>--- a/src/o=
penvpn/win32=2Eh</span><br><span>+++ b/src/openvpn/win32=2Eh</span><br><spa=
n>@@ -226,7 +226,7 @@</span><br><span> void overlapped_io_close(struct over=
lapped_io *o);</span><br><span> </span><br><span> static inline bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-overlapped_io_active(struct =
overlapped_io *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ov=
erlapped_io_active(const struct overlapped_io *o)</span><br><span> {</span>=
<br><span>     return o-&gt;iostate =3D=3D IOSTATE_QUEUED || o-&gt;iostate =
=3D=3D IOSTATE_IMMEDIATE_RETURN;</span><br><span> }</span><br><span>diff --=
git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec=
</span><br><span>index a861e8a=2E=2E25fa1e4 100644</span><br><span>--- a/sr=
c/openvpnmsica/openvpnmsica=2Ec</span><br><span>+++ b/src/openvpnmsica/open=
vpnmsica=2Ec</span><br><span>@@ -77,7 +77,7 @@</span><br><span>  * @return =
ERROR_SUCCESS on success; An error code otherwise</span><br><span>  */</spa=
n><br><span> static UINT</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ =
struct msica_arg_seq *seq)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _=
In_ const struct msica_arg_seq *seq)</span><br><span> {</span><br><span>   =
  UINT uiResult;</span><br><span>     LPWSTR szSequence =3D msica_arg_seq_j=
oin(seq);</span><br><span>diff --git a/src/openvpnserv/interactive=2Ec b/sr=
c/openvpnserv/interactive=2Ec</span><br><span>index a9e9665=2E=2E36c2847 10=
0644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>=
+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -522,7 +522,7 @@</=
span><br><span> </span><br><span> </span><br><span> static SOCKADDR_INET</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-sockaddr_inet(short fami=
ly, inet_address_t *addr)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+sockaddr_inet(short family, const inet_address_t *addr)</span><br><sp=
an> {</span><br><span>     SOCKADDR_INET sa_inet;</span><br><span>     Zero=
Memory(&amp;sa_inet, sizeof(sa_inet));</span><br><span>@@ -3841,7 +3841,7 @=
@</span><br><span> </span><br><span> static DWORD</span><br><span> UpdateWa=
itHandles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_event, HANDLE exi=
t_event,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
     list_item_t *threads)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                  const list_item_t *threads)</span><br><span> {</sp=
an><br><span>     static DWORD size =3D 10;</span><br><span>     static LPH=
ANDLE handles =3D NULL;</span><br><span>diff --git a/tests/unit_tests/openv=
pn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec</span=
><br><span>index 77f6ce2=2E=2Efff4c2b 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/mock_management=2Ec</span><br><span>+++ b/tests/unit_tests=
/openvpn/mock_management=2Ec</span><br><span>@@ -36,7 +36,7 @@</span><br><s=
pan> struct management *management; /* GLOBAL */</span><br><span> </span><b=
r><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-manageme=
nt_auth_failure(struct management *man, const char *type, const char *reaso=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_auth_f=
ailure(const struct management *man, const char *type, const char *reason)<=
/span><br><span> {</span><br><span>     ASSERT(false);</span><br><span> }</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/=
unit_tests/openvpn/test_misc=2Ec</span><br><span>index a41c27b=2E=2Ea8daee6=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span>=
<br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -=
146,7 +146,7 @@</span><br><span> }</span><br><span> </span><br><span> stati=
c struct hash_element *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-hash_lookup_by_value(struct hash *hash, void *value)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+hash_lookup_by_value(struct hash *hash, =
const void *value)</span><br><span> {</span><br><span>     struct hash_iter=
ator hi;</span><br><span>     struct hash_element *he;</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests/ope=
nvpn/test_user_pass=2Ec</span><br><span>index c0a0866=2E=2E7636a33 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>@@ =
-59,7 +59,7 @@</span><br><span>     return mock();</span><br><span> }</span=
><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-manag=
ement_auth_failure(struct management *man, const char *type, const char *re=
ason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_aut=
h_failure(const struct management *man, const char *type, const char *reaso=
n)</span><br><span> {</span><br><span>     assert_true(0);</span><br><span>=
 }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">change 1663</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I56248cf6d199c=
2da770774b8fd1e5daf2b116f58 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1663 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 17 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--9TGs8R1Fn5g=--


--===============6326516673908783246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6326516673908783246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6326516673908783246==--

