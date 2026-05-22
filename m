Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C51CCD5BB0
	for <openvpn-devel@archiver.kernel.org>; Fri, 22 May 2026 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xdA3hGtoS23j3DiIuME3vzwq4Ve+x2TrSrRNqQ2AAL4=; b=fkCoNguTyltglMUe28QZmj4p8x
	aw2jvE2eD5HPhTEhgMMU7KsEMTCHkD67cpzHrE09uIVQsaFIIe0z1cF5+S/I5p7oUMYz3hdE1wjkk
	vPr7JI1ugIaDG0pXkL38j7o/S5/8TMyezu6n1VaBorgKfsxu1nqoUw7DkPb70z3m7meE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wQS5v-0006l8-1J;
	Fri, 22 May 2026 15:47:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wQS5Q-0006iy-UY
 for openvpn-devel@lists.sourceforge.net;
 Fri, 22 May 2026 15:46:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DgtjuEjN2eMuLLm7aS/tkLWsE/NsH7tdnVRDtjJfmqg=; b=BZ4RToejg2xyiZ9MAIQziZdXTy
 6MD5VdLgmjkzCoJmOjrEhEosl9fwVOXjjGRljSgcYFH5PmPbbvWrhGWeJ+/9+5AQ8mwRNsN9f7uqg
 A1LKbhwBBmqbZtPUszVfwCd/pd7RjDcOR1kCTC9NMyR0pCKe0i0sfiTltvM0moL8tXyk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DgtjuEjN2eMuLLm7aS/tkLWsE/NsH7tdnVRDtjJfmqg=; b=l
 ZvLBbg87U8VmcETzMSqpkZMxXB94rXOy8CB8Ol9DSe6Ipe8zSucy8nG1dbTCYFhjv5mLHOd4dLW42
 1Ynw6A5EbPpTrfxkN6VqO6OwdGSgB5ZmStdSqP5B8LyTLyS+IIkwIHBKn5iH/M7GUj8jvLbV4Dlhv
 PUJHXgHXUFIcSTwA=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wQS5K-0003Co-FA for openvpn-devel@lists.sourceforge.net;
 Fri, 22 May 2026 15:46:57 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-490426d72f7so9338765e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 22 May 2026 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779464799; x=1780069599; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DgtjuEjN2eMuLLm7aS/tkLWsE/NsH7tdnVRDtjJfmqg=;
 b=dPPtLapOnOxUUKkd3KmOKm8LUQfsnML6h33rfEbE5uxCuylASAPnfm4YU8eg2BPgFS
 Ynz/WOTQCDAbu3aa7ReTUdIUc3WprdvWd/0cSEFCMgfcSOtQx61CgOMrQW0dW7Nu/JoY
 Trn4jmN54fEFJkTwy/vaBCH9pJdG+Zthfsb9j4FszeaBRWGDTb0CZDCPK3oJjcF0EVG2
 TFpoFD+2tb3NVVw71I1H2QkD8Q3bL5aZcUSy4h2Av8wcFZchjiobHZLs9jrqQBpDSHmc
 T4MDV0HNqpHikKxuPMODnLAg4MdBw9ISLfnqSoRHhNs0jVk9G1QImUUeEFm+KMRJYjuf
 X65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779464799; x=1780069599;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DgtjuEjN2eMuLLm7aS/tkLWsE/NsH7tdnVRDtjJfmqg=;
 b=duCFho5LcqdaSjsTgJ0oFZN7RyQvHnyzcenguUo8L4+tcl1+zw2vmYAhtCVnJ6NCNp
 knfamimkENofqK0zUQ4MuoS7j4W5re8ydy5x6qeTxscPpjVoE3M72JUZTVH3tXEBxIhk
 DJZrnXJk1aC8MCJCxcwRR/D6MPrOUXeu8DWrisHUdDw4GspdRfpwalffEkTtDjEOyF/o
 vKL0LFaBayE3ZovYa64lOqzxVBlQpPdb6axdsiVMw93mHDoBV2kwd3vJnnRR3FsHIMCW
 HxxKtN3zioKnLu1Ak2rsmKEH3yTCU+O2OTIHyGpik/4KpVE+UrOZT6TEf7Ulb0iGirae
 AYJQ==
X-Gm-Message-State: AOJu0YwxJr+caP3JKxcRc8pGz/X9k4A17/pDczHeUO4e2B777KYR+hN6
 Frd0wE/FKtTezPLZiXrX+VVVRxo6DdfDA6/RN4yCxPARPtAGsF/itVIKIGTQwhqxxugdneYW5ej
 EI//d2pm26VDVjB90ee+IbBBHu2pjbtzSfZ4T9NWl06kb65bDW4cRgXgYvmCJsN1KqY5eHPch7f
 D0GCbzeA==
X-Gm-Gg: Acq92OElvEAYog+Hm6JwSfu9eyZm6z3tz3oodaO9KZp05Dy8wkLH0yZQsrpC9IHayyp
 /0PjlKqL7XKl/lvsCpePn3lf03P1VBm9QaPQLlReizxttQ2OA1ujAf1MfnETDAhmNwe2ysT4o4e
 fA9fc+ZC2NJXu7MY/7c385JMX9Bmt/agWsymE6A2cH7rksfmM8tGjJlKAaXC62VzK08h79dVIZp
 7dYb7cpfn4oBC7n8ZwyB5ndlcQy8oecJkEw2/6JTuquGduXUwSpZ+fTlzh236GiFcvqNj/MpDAu
 O0x27CkShzZ8BLjhpwvGVpUHW1etVQNPqHjzzTi7HmPPWcGeDo055p/m53ZkHqGaT8uUW+pdG1J
 /dzsjXy2IGzFPjva5Oy68CgR7ANFKnhuQUnUelN9FhtsSYd6b0SuZBvAJcBdGyqrnOhOLIQzFAL
 xlj73lTPt0URA7rLGwG5eL/eJ9UpGzS/7TXbDS6+GC95xcu/dg2/CHvAGJ4Ln3i2GsHZbDHmWD0
 ho6Srrxn1WzBhZC5x47jrQV0mfIOUNyAZUMgKJ0jGuyI/sPtBnTWpgRzn9lF79N+7yITIztQsBO
 MsRCMqDV3+yIkY7hpO/uHLi+9hxgA/HbAe0=
X-Received: by 2002:a05:600d:640f:10b0:490:3d45:48d7 with SMTP id
 5b1f17b1804b1-4904248d296mr46852665e9.6.1779464798097; 
 Fri, 22 May 2026 08:46:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ac676sm51382185e9.13.2026.05.22.08.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 08:46:37 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 22 May 2026 15:46:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 1ef1a50cd20a9a10e14f7f80c36e8cb0be657623
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2e7f56915a688b698a075ba03097231508a4a2ca-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wQS5K-0003Co-FA
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8815926891199585887=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8815926891199585887==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X+OSXowG4+8="; charset=UTF-8

--X+OSXowG4+8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1663?usp=3Demail

to look at the new patch set (#8)=2E

=

Change subject: Remove instances of constParameterPointer cppcheck warning=
s
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
pn refs/changes/63/1663/8

diff --git a/dev-tools/cppcheck-suppression b/de=
v-tools/cppcheck-suppression
index 900e03c=2E=2E5bc4b24 100644
--- a/dev-to=
ols/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -2,7 +2,6 =
@@
 # occurences right now=2E They still should be fixed at some point
 con=
stParameter
 constParameterCallback
-constParameterPointer
 invalidPrintfAr=
gType_sint
 invalidPrintfArgType_uint
 usleepCalled
@@ -33,6 +32,39 @@
 bad=
BitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec
 # IGN: we store integer=
s in pointers
 CastAddressToIntegerAtReturn:src/openvpn/multi=2Ec
+constPar=
ameterPointer:/usr/include/*
+# IGN: test files provide mocks/stubs that ma=
tch prototypes from headers exactly
+constParameterPointer:tests/unit_tests=
/openvpn/mock_*
+constParameterPointer:tests/unit_tests/openvpn/test_*
+con=
stParameterPointer:tests/unit_tests/openvpnserv/test_*
+# FP: different cry=
pto implementations but same API
+constParameterPointer:src/openvpn/crypto_=
mbedtls_legacy=2Ec:85
+constParameterPointer:src/openvpn/crypto_openssl=2Ec=
:172
+constParameterPointer:src/openvpn/crypto_openssl=2Ec:1456
+constParam=
eterPointer:src/openvpn/cryptoapi=2Ec:58
+constParameterPointer:src/openvpn=
/ssl_mbedtls=2Ec
+constParameterPointer:src/openvpn/ssl_openssl=2Ec
+constP=
arameterPointer:src/openvpn/ssl_verify_mbedtls=2Ec
+# IGN: too many differe=
nt implementations, not worth it
+constParameterPointer:src/openvpn/dco*
+c=
onstParameterPointer:src/openvpn/socket=2E*
+# FP: parameters are modified =
on some platform only
+constParameterPointer:src/openvpn/dns=2Ec:859
+const=
ParameterPointer:src/openvpn/error=2Ec:223
+constParameterPointer:src/openv=
pn/forward=2Ec:1247
+constParameterPointer:src/openvpn/manage=2Ec:344
+cons=
tParameterPointer:src/openvpn/manage=2Ec:3332
+constParameterPointer:src/op=
envpn/misc=2Ec:792
+constParameterPointer:src/openvpn/misc=2Ec:812
+constPa=
rameterPointer:src/openvpn/options=2Ec:3205
+constParameterPointer:src/open=
vpn/route=2Ec:3947
+constParameterPointer:src/openvpn/tun=2Ec:560
+constPar=
ameterPointer:src/openvpn/tun=2Ec:2188
+constParameterPointer:src/openvpn/t=
un_afunix=2Ec
+# IGN: not a FP but the documentation for the FP_ISSET claim=
s this is not const=2E=2E=2E
+constParameterPointer:src/openvpn/event=2Ec:1=
015
+# IGN: MinGW Debug build doesn't like this, causes -Wmaybe-uninitializ=
ed
+constParameterPointer:src/openvpn/buffer=2Eh:1105
 # IGN: event code us=
es a pointer to store integers
 intToPointerCast:src/openvpn/forward=2Ec
 i=
ntToPointerCast:src/openvpn/multi_io=2Ec
diff --git a/sample/sample-plugins=
/client-connect/sample-client-connect=2Ec b/sample/sample-plugins/client-co=
nnect/sample-client-connect=2Ec
index 420de61=2E=2Ecbd98e8 100644
--- a/sam=
ple/sample-plugins/client-connect/sample-client-connect=2Ec
+++ b/sample/sa=
mple-plugins/client-connect/sample-client-connect=2Ec
@@ -344,7 +344,7 @@
 =
}
 
 int
-openvpn_plugin_client_connect(struct plugin_context *context, con=
st char **argv, const char **envp)
+openvpn_plugin_client_connect(const str=
uct plugin_context *context, const char **argv, const char **envp)
 {
     =
/* log environment variables handed to us by OpenVPN, but
      * only if "=
setenv verb" is 3 or higher (arbitrary number)
@@ -465,7 +465,7 @@
 
 int
 =
openvpn_plugin_client_connect_defer_v2(struct plugin_context *context,
-   =
                                    struct plugin_per_client_context *pcc,
=
+                                       const struct plugin_per_client_cont=
ext *pcc,
                                        struct openvpn_plugin_str=
ing_list **return_list)
 {
     time_t time_left =3D pcc->sleep_until - tim=
e(NULL);
diff --git a/sample/sample-plugins/defer/multi-auth=2Ec b/sample/s=
ample-plugins/defer/multi-auth=2Ec
index bacf557=2E=2Ecdd616f 100644
--- a/=
sample/sample-plugins/defer/multi-auth=2Ec
+++ b/sample/sample-plugins/defe=
r/multi-auth=2Ec
@@ -255,7 +255,7 @@
 }
 
 static bool
-do_auth_user_pass(s=
truct plugin_context *context, const char *username, const char *password)
=
+do_auth_user_pass(const struct plugin_context *context, const char *userna=
me, const char *password)
 {
     plog(context, PLOG_NOTE, "expect_user=3D%=
s, received_user=3D%s, expect_passw=3D%s, received_passw=3D%s",
          n=
p(context->test_valid_user), np(username), np(context->test_valid_pass), np=
(password));
@@ -279,7 +279,7 @@
 
 
 static int
-auth_user_pass_verify(str=
uct plugin_context *context, struct plugin_per_client_context *pcc,
+auth_u=
ser_pass_verify(const struct plugin_context *context, struct plugin_per_cli=
ent_context *pcc,
                       const char *argv[], const char *en=
vp[])
 {
     /* get username/password from envp string array */
diff --git=
 a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexport=
er=2Ec b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterial=
exporter=2Ec
index 25c9ff5=2E=2E512861a 100644
--- a/sample/sample-plugins/=
keying-material-exporter-demo/keyingmaterialexporter=2Ec
+++ b/sample/sampl=
e-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec
@@ -186,=
7 +186,7 @@
 }
 
 static void
-file_store(char *file, char *content)
+file_=
store(const char *file, const char *content)
 {
     FILE *f;
     if (!(f =
=3D fopen(file, "w+")))
@@ -202,7 +202,7 @@
 server_store(struct openvpn_pl=
ugin_args_func_in const *args)
 {
     struct plugin *plugin =3D (struct pl=
ugin *)args->handle;
-    struct session *sess =3D (struct session *)args->=
per_client_context;
+    const struct session *sess =3D (struct session *)a=
rgs->per_client_context;
 
     char file[MAXPATH];
     snprintf(file, siz=
eof(file) - 1, "/tmp/openvpn_sso_%s", sess->key);
@@ -214,7 +214,7 @@
 clie=
nt_store(struct openvpn_plugin_args_func_in const *args)
 {
     struct plu=
gin *plugin =3D (struct plugin *)args->handle;
-    struct session *sess =
=3D (struct session *)args->per_client_context;
+    const struct session *=
sess =3D (struct session *)args->per_client_context;
 
     char *file =3D =
"/tmp/openvpn_sso_user";
     ovpn_note("app session file: %s", file);
diff=
 --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 131e1d6=2E=
=2Ef9990d6 100644
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
index 6a751ad=2E=2E9bdb36a 100644
--- a/src/openvpn/buffer=2Eh=

+++ b/src/openvpn/buffer=2Eh
@@ -487,7 +487,7 @@
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
@@ -774,7 +774,7 @@
 }
 
 static inline int
-buf_peek_u8(struct bu=
ffer *buf)
+buf_peek_u8(const struct buffer *buf)
 {
     int ret;
     if =
(BLEN(buf) < 1)
@@ -923,7 +923,7 @@
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
index a9a33c0=2E=
=2Ee04eedf 100644
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
fbca2a0=2E=2E044f2d2 100644
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
@@ -609,7 +609,7 @@
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
 69ce1d7=2E=2Ef509a29 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dc=
o=2Ec
@@ -556,7 +556,7 @@
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
@@ -568=
,7 +568,7 @@
         return false;
     }
 
-    struct link_socket_actual=
 *actual =3D &c->c2=2Elink_socket_infos[0]->lsa->actual;
+    const struct =
link_socket_actual *actual =3D &c->c2=2Elink_socket_infos[0]->lsa->actual;
=
 
     switch (actual->dest=2Eaddr=2Esa=2Esa_family)
     {
@@ -606,7 +606,=
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
@@ -660,7 +660,7 @@
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
@@ -779,7 +779,7 @@
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
index 887d7d7=2E=2E1d=
76859 100644
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
@@ -984,7 +984,7 @@
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
@@ -1534,7 +1534,7 @@
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
index 0d3e492=2E=2Ed8e07fa 100644
--- a/src/openvpn/forward=2Eh
+++ b=
/src/openvpn/forward=2Eh
@@ -112,7 +112,7 @@
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
@@ -163,7 +163,7 @@
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
index 0861cb5=2E=2E41fa557 100644
=
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -817,7 +817,7 @@
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
@@ -1269,7 +1269,7 @@
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
@@ -1755,7 +1755,7 @@
 
 
 static bool
-can_preser=
ve_tun(struct tuntap *tt)
+can_preserve_tun(const struct tuntap *tt)
 {
   =
  if (tt && tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -1777,7 +177=
7,7 @@
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
@@ -1803,7 +1803,7 @@
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
index 2e1cf05=2E=2Ec04ee4f 100644
--- a/src/openvpn/list=2Ec
++=
+ b/src/openvpn/list=2Ec
@@ -162,7 +162,7 @@
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
x 04cc3ab=2E=2E089637d 100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/=
list=2Eh
@@ -73,7 +73,7 @@
 
 bool hash_remove_fast(struct hash *hash, stru=
ct hash_bucket *bucket, const void *key, uint32_t hv);
 
-void hash_remove_=
by_value(struct hash *hash, void *value);
+void hash_remove_by_value(struct=
 hash *hash, const void *value);
 
 struct hash_iterator
 {
diff --git a/sr=
c/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 604bbcd=2E=2E17abfd8 10=
0644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -330,7 +3=
30,7 @@
 }
 
 static void
-man_delete_unix_socket(struct management *man)
+=
man_delete_unix_socket(const struct management *man)
 {
 #if UNIX_SOCK_SUPP=
ORT
     if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)=
) =3D=3D MF_UNIX_SOCK)
@@ -675,7 +675,7 @@
  * for the log and echo command=
s=2E
  */
 static void
-man_history(struct management *man, const char *par=
m, const char *type, struct log_history *log,
+man_history(struct managemen=
t *man, const char *parm, const char *type, const struct log_history *log,
=
             bool *realtime, const unsigned int lep_flags)
 {
     struct g=
c_arena gc =3D gc_new();
@@ -843,7 +843,7 @@
 }
 
 static void
-man_forget_=
passwords(struct management *man)
+man_forget_passwords(const struct manage=
ment *man)
 {
     ssl_purge_auth(false);
     (void)ssl_clean_auth_token()=
;
@@ -851,7 +851,7 @@
 }
 
 static void
-man_net(struct management *man)
+m=
an_net(const struct management *man)
 {
     if (man->persist=2Ecallback=2E=
show_net)
     {
@@ -887,7 +887,7 @@
 #ifdef ENABLE_PKCS11
 
 static void
-=
man_pkcs11_id_count(struct management *man)
+man_pkcs11_id_count(const stru=
ct management *man)
 {
     msg(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_mana=
gement_id_count());
 }
@@ -1350,7 +1350,7 @@
  * @return          Return wh=
ether p has n (or at least n) parameters
  */
 static bool
-man_need(struct=
 management *man, const char **p, const int n, unsigned int flags)
+man_nee=
d(const struct management *man, const char **p, const int n, unsigned int f=
lags)
 {
     int i;
     ASSERT(p[0]);
@@ -2365,7 +2365,7 @@
  * the route=
/ifconfig/open tun command=2E   See doc/android=2Etxt for details=2E
  */
 =
bool
-management_android_control(struct management *man, const char *comman=
d, const char *msg)
+management_android_control(const struct management *ma=
n, const char *command, const char *msg)
 {
     if (!man)
     {
@@ -3013,=
7 +3013,7 @@
 }
 
 void
-management_up_down(struct management *man, const c=
har *updown, const struct env_set *es)
+management_up_down(const struct man=
agement *man, const char *updown, const struct env_set *es)
 {
     if (man=
->settings=2Eflags & MF_UP_DOWN)
     {
@@ -3023,13 +3023,13 @@
 }
 
 void
=
-management_notify(struct management *man, const char *severity, const char=
 *type, const char *text)
+management_notify(const struct management *man, =
const char *severity, const char *type, const char *text)
 {
     msg(M_CLI=
ENT, ">NOTIFY:%s,%s,%s", severity, type, text);
 }
 
 void
-management_noti=
fy_generic(struct management *man, const char *str)
+management_notify_gene=
ric(const struct management *man, const char *str)
 {
     msg(M_CLIENT, "%=
s", str);
 }
@@ -3115,7 +3115,8 @@
 }
 
 void
-management_notify_client_clo=
se(struct management *management, struct man_def_auth_context *mdac,
+manag=
ement_notify_client_close(const struct management *management,
+           =
                    struct man_def_auth_context *mdac,
                    =
            const struct env_set *es)
 {
     if ((mdac->flags & DAF_INITIA=
L_AUTH) && !(mdac->flags & DAF_CONNECTION_CLOSED))
@@ -3206,7 +3207,7 @@
 }=

 
 void
-management_auth_failure(struct management *man, const char *type,=
 const char *reason)
+management_auth_failure(const struct management *man,=
 const char *type, const char *reason)
 {
     if (reason)
     {
@@ -3219,=
7 +3220,7 @@
 }
 
 void
-management_auth_token(struct management *man, cons=
t char *token)
+management_auth_token(const struct management *man, const c=
har *token)
 {
     msg(M_CLIENT, ">PASSWORD:Auth-Token:%s", token);
 }
dif=
f --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 1be3549=2E=
=2E71680a6 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh=

@@ -362,7 +362,7 @@
                                 const unsigned int fl=
ags, const char *static_challenge);
 
 #ifdef TARGET_ANDROID
-bool manageme=
nt_android_control(struct management *man, const char *command, const char =
*msg);
+bool management_android_control(const struct management *man, const=
 char *command, const char *msg);
 
 #define ANDROID_KEEP_OLD_TUN      1
 #=
define ANDROID_OPEN_BEFORE_CLOSE 2
@@ -376,12 +376,12 @@
 
 void management=
_event_loop_n_seconds(struct management *man, int sec);
 
-void management_=
up_down(struct management *man, const char *updown, const struct env_set *e=
s);
+void management_up_down(const struct management *man, const char *updo=
wn, const struct env_set *es);
 
-void management_notify(struct management =
*man, const char *severity, const char *type,
+void management_notify(const=
 struct management *man, const char *severity, const char *type,
          =
              const char *text);
 
-void management_notify_generic(struct m=
anagement *man, const char *str);
+void management_notify_generic(const str=
uct management *man, const char *str);
 
 void management_notify_client_nee=
ding_auth(struct management *management,
                                  =
          const unsigned int auth_id,
@@ -391,7 +391,7 @@
 void management_=
connection_established(struct management *management,
                     =
                   struct man_def_auth_context *mdac, const struct env_set =
*es);
 
-void management_notify_client_close(struct management *management,=

+void management_notify_client_close(const struct management *management,
=
                                     struct man_def_auth_context *mdac, con=
st struct env_set *es);
 
 void management_learn_addr(struct management *ma=
nagement, struct man_def_auth_context *mdac,
@@ -476,12 +476,12 @@
  * Open=
VPN calls here to indicate a password failure
  */
 
-void management_auth_=
failure(struct management *man, const char *type, const char *reason);
+voi=
d management_auth_failure(const struct management *man, const char *type, c=
onst char *reason);
 
 /*
  * Echo an authentication token to management in=
terface
  */
-void management_auth_token(struct management *man, const char=
 *token);
+void management_auth_token(const struct management *man, const c=
har *token);
 
 /*
  * These functions drive the bytecount in/out counters=
=2E
diff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec
index 5e1b585=
=2E=2E39f85ba 100644
--- a/src/openvpn/mbuf=2Ec
+++ b/src/openvpn/mbuf=2Ec
=
@@ -160,7 +160,7 @@
 }
 
 void
-mbuf_dereference_instance(struct mbuf_set *=
ms, struct multi_instance *mi)
+mbuf_dereference_instance(struct mbuf_set *=
ms, const struct multi_instance *mi)
 {
     if (ms)
     {
diff --git a/sr=
c/openvpn/mbuf=2Eh b/src/openvpn/mbuf=2Eh
index cfe698c=2E=2Ee368054 100644=

--- a/src/openvpn/mbuf=2Eh
+++ b/src/openvpn/mbuf=2Eh
@@ -75,7 +75,7 @@
 
=
 bool mbuf_extract_item(struct mbuf_set *ms, struct mbuf_item *item);
 
-vo=
id mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance *mi=
);
+void mbuf_dereference_instance(struct mbuf_set *ms, const struct multi_=
instance *mi);
 
 static inline bool
 mbuf_defined(const struct mbuf_set *m=
s)
diff --git a/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec
index 36bbb43=2E=
=2Ea7242a8 100644
--- a/src/openvpn/mss=2Ec
+++ b/src/openvpn/mss=2Ec
@@ -4=
3,7 +43,7 @@
  *              if yes, hand to mss_fixup_dowork()
  */
 void=

-mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss)
+mss_fixup_ipv4(const=
 struct buffer *buf, uint16_t maxmss)
 {
     const struct openvpn_iphdr *p=
ip;
     int hlen;
@@ -80,7 +80,7 @@
  *              (IPv6 header structur=
e is sufficiently different from IPv4=2E=2E=2E)
  */
 void
-mss_fixup_ipv6(=
struct buffer *buf, uint16_t maxmss)
+mss_fixup_ipv6(const struct buffer *b=
uf, uint16_t maxmss)
 {
     const struct openvpn_ipv6hdr *pip6;
     struc=
t buffer newbuf;
@@ -136,7 +136,7 @@
  */
 
 void
-mss_fixup_dowork(struct =
buffer *buf, uint16_t maxmss)
+mss_fixup_dowork(const struct buffer *buf, u=
int16_t maxmss)
 {
     int olen, optlen;
     uint8_t *opt;
@@ -239,8 +239=
,8 @@
 }
 
 static void
-frame_calculate_fragment(struct frame *frame, stru=
ct key_type *kt, const struct options *options,
-                         s=
truct link_socket_info *lsi)
+frame_calculate_fragment(struct frame *frame,=
 const struct key_type *kt, const struct options *options,
+               =
          const struct link_socket_info *lsi)
 {
 #if defined(ENABLE_FRAGME=
NT)
     size_t overhead;
@@ -269,8 +269,8 @@
 }
 
 static void
-frame_calc=
ulate_mssfix(struct frame *frame, struct key_type *kt, const struct options=
 *options,
-                       struct link_socket_info *lsi)
+frame_cal=
culate_mssfix(struct frame *frame, const struct key_type *kt, const struct =
options *options,
+                       const struct link_socket_info *ls=
i)
 {
     if (options->ce=2Emssfix_fixed)
     {
@@ -314,8 +314,8 @@
 }
 
=
 void
-frame_calculate_dynamic(struct frame *frame, struct key_type *kt, co=
nst struct options *options,
-                        struct link_socket_in=
fo *lsi)
+frame_calculate_dynamic(struct frame *frame, const struct key_typ=
e *kt, const struct options *options,
+                        const struct=
 link_socket_info *lsi)
 {
     if (options->ce=2Efragment > 0)
     {
diff=
 --git a/src/openvpn/mss=2Eh b/src/openvpn/mss=2Eh
index 1d092bb=2E=2E6b832=
a2 100644
--- a/src/openvpn/mss=2Eh
+++ b/src/openvpn/mss=2Eh
@@ -29,15 +29=
,15 @@
 #include "socket=2Eh"
 #include "ssl_common=2Eh"
 
-void mss_fixup_=
ipv4(struct buffer *buf, uint16_t maxmss);
+void mss_fixup_ipv4(const struc=
t buffer *buf, uint16_t maxmss);
 
-void mss_fixup_ipv6(struct buffer *buf,=
 uint16_t maxmss);
+void mss_fixup_ipv6(const struct buffer *buf, uint16_t =
maxmss);
 
-void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);
+vo=
id mss_fixup_dowork(const struct buffer *buf, uint16_t maxmss);
 
 /** Set =
the --mssfix option=2E */
-void frame_calculate_dynamic(struct frame *frame=
, struct key_type *kt,
-                             const struct options *=
options, struct link_socket_info *lsi);
+void frame_calculate_dynamic(struc=
t frame *frame, const struct key_type *kt,
+                             co=
nst struct options *options, const struct link_socket_info *lsi);
 
 /**
  =
* Checks and adjusts the fragment and mssfix value according to the
diff --=
git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index df94a70=2E=2Ed9f14b=
3 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -91,7 +91=
,7 @@
 }
 
 bool
-multi_tcp_instance_specific_init(struct multi_context *m,=
 struct multi_instance *mi)
+multi_tcp_instance_specific_init(const struct =
multi_context *m, struct multi_instance *mi)
 {
     /* buffer for queued T=
CP socket output packets */
     mi->tcp_link_out_deferred =3D mbuf_init(m-=
>top=2Eoptions=2En_bcast_buf);
diff --git a/src/openvpn/mtcp=2Eh b/src/open=
vpn/mtcp=2Eh
index 9b7d1d2=2E=2Ebb117fa 100644
--- a/src/openvpn/mtcp=2Eh
+=
++ b/src/openvpn/mtcp=2Eh
@@ -35,7 +35,7 @@
 
 void multi_tcp_dereference_i=
nstance(struct multi_io *multi_io, struct multi_instance *mi);
 
-bool mult=
i_tcp_instance_specific_init(struct multi_context *m, struct multi_instance=
 *mi);
+bool multi_tcp_instance_specific_init(const struct multi_context *m=
, struct multi_instance *mi);
 
 void multi_tcp_instance_specific_free(stru=
ct multi_instance *mi);
 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/m=
udp=2Ec
index 50d72d5=2E=2E4828a17 100644
--- a/src/openvpn/mudp=2Ec
+++ b/=
src/openvpn/mudp=2Ec
@@ -39,7 +39,7 @@
 
 static void
 send_hmac_reset_pack=
et(struct multi_context *m, struct tls_pre_decrypt_state *state,
-         =
              struct tls_auth_standalone *tas, struct session_id *sid,
+   =
                    const struct tls_auth_standalone *tas, const struct ses=
sion_id *sid,
                        bool request_resend_wkc)
 {
     rese=
t_packet_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
@@ -69,7 +=
69,7 @@
 
     enum first_packet_verdict verdict;
 
-    struct tls_auth_st=
andalone *tas =3D m->top=2Ec2=2Etls_auth_standalone;
+    const struct tls_=
auth_standalone *tas =3D m->top=2Ec2=2Etls_auth_standalone;
 
     verdict =
=3D tls_pre_decrypt_lite(tas, state, &m->top=2Ec2=2Efrom, &m->top=2Ec2=2Ebu=
f);
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index c72c=
4b2=2E=2Edd4d61d 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=
=2Ec
@@ -57,7 +57,7 @@
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
 static const char =
*
-id(struct multi_instance *mi)
+id(const struct multi_instance *mi)
 {
  =
   if (mi)
     {
@@ -1315,7 +1315,7 @@
  * same common name=2E
  */
 stati=
c void
-multi_delete_dup(struct multi_context *m, struct multi_instance *ne=
w_mi)
+multi_delete_dup(struct multi_context *m, const struct multi_instanc=
e *new_mi)
 {
     if (new_mi)
     {
@@ -2260,7 +2260,7 @@
 }
 
 static bo=
ol
-multi_client_setup_dco_initial(struct multi_context *m, struct multi_in=
stance *mi,
+multi_client_setup_dco_initial(const struct multi_context *m, =
struct multi_instance *mi,
                                struct gc_arena =
*gc)
 {
     if (!dco_enabled(&mi->context=2Eoptions))
@@ -3195,7 +3195,7 @=
@
 
 #if defined(ENABLE_DCO)
 static void
-process_incoming_del_peer(struct=
 multi_context *m, struct multi_instance *mi, dco_context_t *dco)
+process_=
incoming_del_peer(struct multi_context *m, struct multi_instance *mi, const=
 dco_context_t *dco)
 {
     const char *reason =3D "ovpn-dco: unknown reas=
on";
     switch (dco->dco_del_peer_reason)
@@ -4226,7 +4226,7 @@
 
 /* Sea=
rches for the address and deletes it if it is owned by the multi_instance *=
/
 static void
-multi_unlearn_addr(struct multi_context *m, struct multi_in=
stance *mi, const struct mroute_addr *addr)
+multi_unlearn_addr(struct mult=
i_context *m, const struct multi_instance *mi, const struct mroute_addr *ad=
dr)
 {
     struct hash_element *he;
     const uint32_t hv =3D hash_value(=
m->vhash, addr);
@@ -4261,7 +4261,7 @@
  * @param a     The new IPv4 addres=
s in network byte order
  */
 static void
-multi_unlearn_in_addr_t(struct m=
ulti_context *m, struct multi_instance *mi, in_addr_t a)
+multi_unlearn_in_=
addr_t(struct multi_context *m, const struct multi_instance *mi, in_addr_t =
a)
 {
     struct mroute_addr addr;
     CLEAR(addr);
@@ -4279,7 +4279,7 @@=

  * @param a6    The new IPv6 address
  */
 static void
-multi_unlearn_in6=
_addr(struct multi_context *m, struct multi_instance *mi, struct in6_addr a=
6)
+multi_unlearn_in6_addr(struct multi_context *m, const struct multi_inst=
ance *mi, struct in6_addr a6)
 {
     struct mroute_addr addr;
     CLEAR(a=
ddr);
@@ -4395,7 +4395,7 @@
 
 bool
 multi_check_push_ifconfig_ipv6_extra_r=
oute(struct multi_instance *mi,
-                                          =
 struct in6_addr *dest)
+                                           const s=
truct in6_addr *dest)
 {
     const struct options *o =3D &mi->context=2Eop=
tions;
 
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 3=
ed08d4=2E=2Ecd7aa3e 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/mu=
lti=2Eh
@@ -520,7 +520,7 @@
  */
 
 static inline void
-set_prefix(struct m=
ulti_instance *mi)
+set_prefix(const struct multi_instance *mi)
 {
 #ifdef =
MULTI_DEBUG_EVENT_LOOP
     if (mi->msg_prefix[0])
@@ -694,7 +694,7 @@
  */=

 bool
 multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *m=
i,
-                                           struct in6_addr *dest);
+   =
                                        const struct in6_addr *dest);
 
 /*=

  * Check for signals=2E
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
index e6e72d0=2E=2Ea1d220f 100644
--- a/src/o=
penvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -987,=
7 +987,7 @@
 }
 
 static int
-sitnl_addr_del(sa_family_t af_family, const c=
har *iface, inet_address_t *addr, int prefixlen)
+sitnl_addr_del(sa_family_=
t af_family, const char *iface, const inet_address_t *addr, int prefixlen)
=
 {
     int ifindex;
 
@@ -1230,8 +1230,8 @@
 }
 
 static int
-sitnl_route_=
del(const char *iface, sa_family_t af_family, inet_address_t *dst, int pref=
ixlen,
-                inet_address_t *gw, uint32_t table, int metric)
+si=
tnl_route_del(const char *iface, sa_family_t af_family, const inet_address_=
t *dst, int prefixlen,
+                const inet_address_t *gw, uint32_t =
table, int metric)
 {
     int ifindex =3D 0;
 
@@ -1308,7 +1308,7 @@
 
 
 =
int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *t=
ype, void *arg)
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, c=
onst char *type, const void *arg)
 {
     struct sitnl_link_req req =3D {};=

     int ret =3D -1;
diff --git a/src/openvpn/occ=2Eh b/src/openvpn/occ=2E=
h
index bda4f18=2E=2E49def4d 100644
--- a/src/openvpn/occ=2Eh
+++ b/src/ope=
nvpn/occ=2Eh
@@ -156,7 +156,7 @@
  * via control channel=2E
  * @return con=
trol channel exit message should be used */
 static inline bool
-cc_exit_no=
tify_enabled(struct context *c)
+cc_exit_notify_enabled(const struct contex=
t *c)
 {
     /* Check if we have TLS active at all */
     if (!c->c2=2Etl=
s_multi)
diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_=
compat=2Eh
index 3494ce6=2E=2E32e0b6f 100644
--- a/src/openvpn/openssl_comp=
at=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -124,7 +124,7 @@
 /* Mimics =
the functions but only when the default context without
  * options is chos=
en */
 static inline const EVP_CIPHER *
-EVP_CIPHER_fetch(void *ctx, const =
char *algorithm, const char *properties)
+EVP_CIPHER_fetch(const void *ctx,=
 const char *algorithm, const char *properties)
 {
     ASSERT(!ctx);
     =
ASSERT(!properties);
@@ -132,7 +132,7 @@
 }
 
 static inline const EVP_MD *=

-EVP_MD_fetch(void *ctx, const char *algorithm, const char *properties)
+E=
VP_MD_fetch(const void *ctx, const char *algorithm, const char *properties)=

 {
     ASSERT(!ctx);
     ASSERT(!properties);
diff --git a/src/openvpn/o=
ptions=2Ec b/src/openvpn/options=2Ec
index fd0d3fc=2E=2E6d85a23 100644
--- =
a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3050,7 +3050,7 =
@@
 }
 
 static void
-options_postprocess_mutate_le(struct connection_entry=
 *ce, struct local_entry *le, int mode)
+options_postprocess_mutate_le(cons=
t struct connection_entry *ce, struct local_entry *le, int mode)
 {
     /*=
 use the global port if none is specified */
     if (!le->port)
@@ -4980,7=
 +4980,7 @@
 static bool
 verify_permission(const char *name, const char *f=
ile, int line, const uint64_t type,
                   const uint64_t allow=
ed, uint64_t *found, const msglvl_t msglevel,
-                  struct opt=
ions *options, bool is_inline)
+                  const struct options *opt=
ions, bool is_inline)
 {
     if (!(type & allowed))
     {
@@ -5547,7 +554=
7,7 @@
 }
 
 static void
-show_compression_warning(struct compress_options =
*info)
+show_compression_warning(const struct compress_options *info)
 {
  =
   if (comp_non_stub_enabled(info))
     {
diff --git a/src/openvpn/options=
_parse=2Ec b/src/openvpn/options_parse=2Ec
index 88ab4d2=2E=2E0e94522 10064=
4
--- a/src/openvpn/options_parse=2Ec
+++ b/src/openvpn/options_parse=2Ec
@=
@ -258,7 +258,7 @@
 }
 
 static char *
-read_inline_file(struct in_src *is,=
 const char *close_tag, int *num_lines, struct gc_arena *gc)
+read_inline_f=
ile(const struct in_src *is, const char *close_tag, int *num_lines, struct =
gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE];
     struct buffer buf =
=3D alloc_buf(8 * OPTION_LINE_SIZE);
@@ -302,7 +302,7 @@
 }
 
 static int
-=
check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
+check=
_inline_file(const struct in_src *is, char *p[], struct gc_arena *gc)
 {
  =
   int num_inline_lines =3D 0;
 
diff --git a/src/openvpn/otime=2Ec b/src/o=
penvpn/otime=2Ec
index 1608458=2E=2E5d3633c 100644
--- a/src/openvpn/otime=
=2Ec
+++ b/src/openvpn/otime=2Ec
@@ -66,7 +66,7 @@
 }
 
 void
-update_now_u=
sec(struct timeval *tv)
+update_now_usec(const struct timeval *tv)
 {
     =
const time_t last =3D now;
     update_now(tv->tv_sec);
diff --git a/src/op=
envpn/otime=2Eh b/src/openvpn/otime=2Eh
index 84e315b=2E=2Eb5a9f7c 100644
-=
-- a/src/openvpn/otime=2Eh
+++ b/src/openvpn/otime=2Eh
@@ -65,7 +65,7 @@
 v=
oid update_now(const time_t system_time);
 
 extern time_t now_usec;
-void =
update_now_usec(struct timeval *tv);
+void update_now_usec(const struct tim=
eval *tv);
 
 static inline int
 openvpn_gettimeofday(struct timeval *tv, v=
oid *tz)
diff --git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh
index 3=
570582=2E=2E33bf4ea 100644
--- a/src/openvpn/proto=2Eh
+++ b/src/openvpn/pr=
oto=2Eh
@@ -248,7 +248,7 @@
  * and offset of IP header (via parameter)=2E
=
  */
 static inline int
-get_tun_ip_ver(int tunnel_type, struct buffer *buf=
, int *ip_hdr_offset)
+get_tun_ip_ver(int tunnel_type, const struct buffer =
*buf, int *ip_hdr_offset)
 {
     int ip_ver =3D -1;
 
diff --git a/src/ope=
nvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index 4de7615=2E=2Ed4e0a8b 100644
--=
- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -527,8 +527,9 @@
 =
}
 
 static bool
-add_proxy_headers(struct http_proxy_info *p, socket_descr=
iptor_t sd, /* already open to proxy */
-                  const char *host=
                                   /* openvpn server remote */
+add_proxy_h=
eaders(const struct http_proxy_info *p,
+                  socket_descripto=
r_t sd, /* already open to proxy */
+                  const char *host    =
    /* openvpn server remote */
 )
 {
     char buf[512];
@@ -597,8 +598,8 =
@@
                               socket_descriptor_t sd, /* already open t=
o proxy */
                               const char *host,       /* openvp=
n server remote */
                               const char *port,       /=
* openvpn server port */
-                              struct event_timeou=
t *server_poll_timeout, struct buffer *lookahead,
-                        =
      struct signal_info *sig_info)
+                              const st=
ruct event_timeout *server_poll_timeout,
+                              str=
uct buffer *lookahead, struct signal_info *sig_info)
 {
     struct gc_aren=
a gc =3D gc_new();
     char buf[512];
diff --git a/src/openvpn/proxy=2Eh b=
/src/openvpn/proxy=2Eh
index e662e7d=2E=2Ea2f4e47 100644
--- a/src/openvpn/=
proxy=2Eh
+++ b/src/openvpn/proxy=2Eh
@@ -89,7 +89,7 @@
                   =
                 socket_descriptor_t sd, /* already open to proxy */
      =
                              const char *host,       /* openvpn server rem=
ote */
                                    const char *port,       /* openv=
pn server port */
-                                   struct event_timeout =
*server_poll_timeout,
+                                   const struct even=
t_timeout *server_poll_timeout,
                                    struct =
buffer *lookahead, struct signal_info *sig_info);
 
 uint8_t *make_base64_s=
tring2(const uint8_t *str, int str_len, struct gc_arena *gc);
diff --git a/=
src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 57afacd=2E=2E0e581e5 100644
-=
-- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -332,7 +332,7 @@
  * th=
e proxy can determine true client origin=2E
  */
 static void
-journal_add(=
const char *journal_dir, struct proxy_connection *pc, struct proxy_connecti=
on *cp)
+journal_add(const char *journal_dir, const struct proxy_connection=
 *pc, struct proxy_connection *cp)
 {
     struct openvpn_sockaddr from, to=
;
 
@@ -410,7 +410,7 @@
 static bool
 proxy_entry_new(struct proxy_connecti=
on **list, struct event_set *es,
                 const struct openvpn_sock=
addr server_addr, const socket_descriptor_t sd_client,
-                str=
uct buffer *initial_data, const char *journal_dir)
+                const s=
truct buffer *initial_data, const char *journal_dir)
 {
     socket_descrip=
tor_t sd_server;
     int status;
@@ -1013,7 +1013,7 @@
  * call=2E
  */
 v=
oid
-port_share_redirect(struct port_share *ps, const struct buffer *head, =
socket_descriptor_t sd)
+port_share_redirect(const struct port_share *ps, c=
onst struct buffer *head, socket_descriptor_t sd)
 {
     if (ps)
     {
di=
ff --git a/src/openvpn/ps=2Eh b/src/openvpn/ps=2Eh
index 557ecf5=2E=2E918ce=
b6 100644
--- a/src/openvpn/ps=2Eh
+++ b/src/openvpn/ps=2Eh
@@ -49,7 +49,7 =
@@
 
 bool is_openvpn_protocol(const struct buffer *buf);
 
-void port_shar=
e_redirect(struct port_share *ps, const struct buffer *head, socket_descrip=
tor_t sd);
+void port_share_redirect(const struct port_share *ps, const str=
uct buffer *head, socket_descriptor_t sd);
 
 #endif /* if PORT_SHARE */
 #=
endif /* ifndef PS_H */
diff --git a/src/openvpn/push=2Ec b/src/openvpn/pus=
h=2Ec
index a030acd=2E=2E373272f 100644
--- a/src/openvpn/push=2Ec
+++ b/sr=
c/openvpn/push=2Ec
@@ -435,7 +435,7 @@
 #endif
 
 bool
-send_auth_pending_m=
essages(struct tls_multi *tls_multi, struct tls_session *session,
+send_aut=
h_pending_messages(const struct tls_multi *tls_multi, struct tls_session *s=
ession,
                            const char *extra, unsigned int timeout=
)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];
diff --git a/=
src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index dff945f=2E=2E39302f6 1006=
44
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -117,7 +117,7 @=
@
  * doc/management-notes=2Etxt under client-pending-auth for
  * more det=
ails on message format
  */
-bool send_auth_pending_messages(struct tls_mul=
ti *tls_multi, struct tls_session *session,
+bool send_auth_pending_message=
s(const struct tls_multi *tls_multi, struct tls_session *session,
         =
                        const char *extra, unsigned int timeout);
 
 void s=
end_restart(struct context *c, const char *kill_msg);
diff --git a/src/open=
vpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index af22af5=2E=2E008d45f 10=
0644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -22=
2,7 +222,7 @@
 
 /* Return true if the client supports push-update */
 stat=
ic bool
-support_push_update(struct multi_instance *mi)
+support_push_updat=
e(const struct multi_instance *mi)
 {
     ASSERT(mi->context=2Ec2=2Etls_mu=
lti);
     const unsigned int iv_proto_peer =3D extract_iv_proto(mi->contex=
t=2Ec2=2Etls_multi->peer_info);
diff --git a/src/openvpn/reliable=2Ec b/src=
/openvpn/reliable=2Ec
index 52adacf=2E=2E3588483 100644
--- a/src/openvpn/r=
eliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -92,7 +92,7 @@
 
 /* check if=
 a particular packet_id is present in ack */
 static inline bool
-reliable_=
ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)
+reliab=
le_ack_packet_id_present(const struct reliable_ack *ack, packet_id_type pid=
)
 {
     for (int i =3D 0; i < ack->len; ++i)
     {
@@ -733,7 +733,7 @@
 =
 */
 
 void
-reliable_mark_active_incoming(struct reliable *rel, struct buf=
fer *buf, packet_id_type pid,
+reliable_mark_active_incoming(struct reliabl=
e *rel, const struct buffer *buf, packet_id_type pid,
                     =
          int opcode)
 {
     for (int i =3D 0; i < rel->size; ++i)
@@ -793=
,7 +793,7 @@
 
 /* delete a buffer previously activated by reliable_mark_ac=
tive() */
 void
-reliable_mark_deleted(struct reliable *rel, struct buffer =
*buf)
+reliable_mark_deleted(struct reliable *rel, const struct buffer *buf=
)
 {
     for (int i =3D 0; i < rel->size; ++i)
     {
diff --git a/src/ope=
nvpn/reliable=2Eh b/src/openvpn/reliable=2Eh
index a5ed75c=2E=2E8d9e2e3 100=
644
--- a/src/openvpn/reliable=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -173,7=
 +173,7 @@
  * @li False, if there are packet IDs to be acknowledged=2E
  *=
/
 static inline bool
-reliable_ack_empty(struct reliable_ack *ack)
+reliab=
le_ack_empty(const struct reliable_ack *ack)
 {
     return !ack->len;
 }
@=
@ -186,7 +186,7 @@
  * @returns the number of outstanding acks
  */
 static=
 inline int
-reliable_ack_outstanding(struct reliable_ack *ack)
+reliable_a=
ck_outstanding(const struct reliable_ack *ack)
 {
     return ack->len;
 }
=
@@ -336,7 +336,7 @@
  * @param pid The packet's packet ID=2E
  * @param opc=
ode The packet's opcode=2E
  */
-void reliable_mark_active_incoming(struct =
reliable *rel, struct buffer *buf, packet_id_type pid,
+void reliable_mark_=
active_incoming(struct reliable *rel, const struct buffer *buf, packet_id_t=
ype pid,
                                    int opcode);
 
 /**
@@ -389,7 =
+389,7 @@
  * @param rel The reliable structure associated with the given b=
uffer=2E
  * @param buf The buffer of the reliable entry which is to be rem=
oved=2E
  */
-void reliable_mark_deleted(struct reliable *rel, struct buffe=
r *buf);
+void reliable_mark_deleted(struct reliable *rel, const struct buf=
fer *buf);
 
 /** @} name Functions for extracting incoming packets */
 
di=
ff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 1d3ea86=2E=
=2E590d844 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@=
@ -898,8 +898,9 @@
 }
 
 static bool
-add_bypass_routes(struct route_bypass=
 *rb, in_addr_t gateway, const struct tuntap *tt,
-                  unsign=
ed int flags, const struct route_gateway_info *rgi,
+add_bypass_routes(cons=
t struct route_bypass *rb, in_addr_t gateway,
+                  const stru=
ct tuntap *tt, unsigned int flags,
+                  const struct route_ga=
teway_info *rgi,
                   const struct env_set *es, openvpn_net_c=
tx_t *ctx)
 {
     int ret =3D true;
@@ -916,8 +917,9 @@
 }
 
 static void
=
-del_bypass_routes(struct route_bypass *rb, in_addr_t gateway, const struct=
 tuntap *tt,
-                  unsigned int flags, const struct route_gate=
way_info *rgi,
+del_bypass_routes(const struct route_bypass *rb, in_addr_t =
gateway,
+                  const struct tuntap *tt, unsigned int flags,
+ =
                 const struct route_gateway_info *rgi,
                   c=
onst struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     int i;
@@ -3942,7 =
+3944,7 @@
 #else  /* if defined(_WIN32) */
 
 static void
-get_bypass_addr=
esses(struct route_bypass *rb, const unsigned int flags) /* PLATFORM-SPECIF=
IC */
+get_bypass_addresses(struct route_bypass *rb, const unsigned int fla=
gs)
 {
 }
 
diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2E=
c
index 6d9bb62=2E=2Ec29009e 100644
--- a/src/openvpn/schedule=2Ec
+++ b/sr=
c/openvpn/schedule=2Ec
@@ -501,7 +501,7 @@
 }
 
 int
-schedule_debug(struct=
 schedule *s, int *count, struct timeval *least)
+schedule_debug(const stru=
ct schedule *s, int *count, struct timeval *least)
 {
     struct timeval m=
in;
     struct timeval max;
diff --git a/src/openvpn/socket=2Ec b/src/open=
vpn/socket=2Ec
index 0382aea=2E=2E5474e94 100644
--- a/src/openvpn/socket=
=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -647,7 +647,7 @@
 }
 
 static void
-bi=
nd_local(struct link_socket *sock, const sa_family_t ai_family)
+bind_local=
(const struct link_socket *sock, const sa_family_t ai_family)
 {
     /* bi=
nd to local address/port */
     if (sock->bind_local)
@@ -914,8 +914,8 @@
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
 
@@ -1123,8 +1123,8 @@
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
 
@@ -1481,7 +1481,7 @@
 }
 
 stat=
ic void
-phase2_set_socket_flags(struct link_socket *sock)
+phase2_set_sock=
et_flags(const struct link_socket *sock)
 {
     /* set misc socket paramet=
ers */
     socket_set_flags(sock->sd, sock->sockflags);
@@ -2073,7 +2073,7=
 @@
 }
 
 static void
-stream_buf_init(struct stream_buf *sb, struct buffer=
 *buf, const unsigned int sockflags,
+stream_buf_init(struct stream_buf *sb=
, const struct buffer *buf, const unsigned int sockflags,
                 =
const int proto)
 {
     sb->buf_init =3D *buf;
@@ -2337,7 +2337,7 @@
 #end=
if
 
 static socklen_t
-link_socket_read_udp_posix_recvmsg(struct link_sock=
et *sock, struct buffer *buf,
+link_socket_read_udp_posix_recvmsg(const str=
uct link_socket *sock, struct buffer *buf,
                                =
    struct link_socket_actual *from)
 {
     struct iovec iov;
@@ -2405,7 +=
2405,7 @@
 #endif /* if ENABLE_IP_PKTINFO */
 
 int
-link_socket_read_udp_p=
osix(struct link_socket *sock, struct buffer *buf,
+link_socket_read_udp_po=
six(const struct link_socket *sock, struct buffer *buf,
                   =
         struct link_socket_actual *from)
 {
     socklen_t fromlen =3D siz=
eof(from->dest=2Eaddr);
@@ -2462,7 +2462,7 @@
 #if ENABLE_IP_PKTINFO
 
 ssi=
ze_t
-link_socket_write_udp_posix_sendmsg(struct link_socket *sock, struct =
buffer *buf,
+link_socket_write_udp_posix_sendmsg(const struct link_socket =
*sock, const struct buffer *buf,
                                     struc=
t link_socket_actual *to)
 {
     struct iovec iov;
@@ -2656,7 +2656,7 @@
 =
}
 
 int
-socket_send_queue(struct link_socket *sock, struct buffer *buf, c=
onst struct link_socket_actual *to)
+socket_send_queue(struct link_socket *=
sock, const struct buffer *buf, const struct link_socket_actual *to)
 {
   =
  if (sock->writes=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
@@ -2756,8 +275=
6,8 @@
     return sock->writes=2Eiostate;
 }
 
-void
-read_sockaddr_from_o=
verlapped(struct overlapped_io *io, struct sockaddr *dst, int overlapped_re=
t)
+static void
+read_sockaddr_from_overlapped(const struct overlapped_io *=
io, struct sockaddr *dst, int overlapped_ret)
 {
     if (overlapped_ret >=
=3D 0 && io->addr_defined)
     {
diff --git a/src/openvpn/socket=2Eh b/src=
/openvpn/socket=2Eh
index 71a3595=2E=2E6771ec5 100644
--- a/src/openvpn/soc=
ket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -267,7 +267,7 @@
 
 int socket_recv=
_queue(struct link_socket *sock, int maxsize);
 
-int socket_send_queue(str=
uct link_socket *sock, struct buffer *buf,
+int socket_send_queue(struct li=
nk_socket *sock, const struct buffer *buf,
                       const str=
uct link_socket_actual *to);
 
 typedef struct
@@ -347,8 +347,8 @@
 
 struc=
t link_socket *link_socket_new(void);
 
-void socket_bind(socket_descriptor=
_t sd, struct addrinfo *local, int af_family, const char *prefix,
-        =
         bool ipv6only);
+void socket_bind(socket_descriptor_t sd, const st=
ruct addrinfo *local, int af_family,
+                 const char *prefix, =
bool ipv6only);
 
 int openvpn_connect(socket_descriptor_t sd, const struct=
 sockaddr *remote, int connect_timeout,
                     volatile int *=
signal_received);
@@ -484,7 +484,7 @@
 }
 
 static inline bool
-link_socket=
_verify_incoming_addr(struct buffer *buf, const struct link_socket_info *in=
fo,
+link_socket_verify_incoming_addr(const struct buffer *buf, const struc=
t link_socket_info *info,
                                  const struct li=
nk_socket_actual *from_addr)
 {
     if (buf->len > 0)
@@ -608,7 +608,7 @@
=
 
 #else  /* ifdef _WIN32 */
 
-int link_socket_read_udp_posix(struct link_=
socket *sock, struct buffer *buf,
+int link_socket_read_udp_posix(const str=
uct link_socket *sock, struct buffer *buf,
                                =
struct link_socket_actual *from);
 
 #endif /* ifdef _WIN32 */
@@ -694,12 +=
694,12 @@
 
 #else /* ifdef _WIN32 */
 
-ssize_t link_socket_write_udp_posi=
x_sendmsg(struct link_socket *sock, struct buffer *buf,
+ssize_t link_socke=
t_write_udp_posix_sendmsg(const struct link_socket *sock, const struct buff=
er *buf,
                                             struct link_socket_ac=
tual *to);
 
 
 static inline ssize_t
-link_socket_write_udp_posix(struct l=
ink_socket *sock, struct buffer *buf,
+link_socket_write_udp_posix(const st=
ruct link_socket *sock, const struct buffer *buf,
                         =
    struct link_socket_actual *to)
 {
 #if ENABLE_IP_PKTINFO
@@ -715,7 +715=
,7 @@
 }
 
 static inline ssize_t
-link_socket_write_tcp_posix(struct link_=
socket *sock, struct buffer *buf)
+link_socket_write_tcp_posix(const struct=
 link_socket *sock, const struct buffer *buf)
 {
     return send(sock->sd,=
 BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
 }
@@ -773,7 +773,7 @@
  * from tunn=
el packet=2E
  */
 static inline void
-link_socket_set_tos(struct link_sock=
et *sock)
+link_socket_set_tos(const struct link_socket *sock)
 {
     if (=
sock && sock->ptos_defined)
     {
@@ -819,6 +819,8 @@
     }
 }
 
+/* cppc=
heck-suppress constParameterPointer
+ * sock is modified on Windows via &so=
ck->listen_handle */
 static inline void
 socket_reset_listen_persistent(st=
ruct link_socket *sock)
 {
diff --git a/src/openvpn/socket_util=2Eh b/src/o=
penvpn/socket_util=2Eh
index 13f5962=2E=2Eadd08ba 100644
--- a/src/openvpn/=
socket_util=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -439,7 +439,7 @@
 
 
 =
static inline bool
-addrlist_match_proto(const struct openvpn_sockaddr *a1,=
 struct addrinfo *addr_list, const int proto)
+addrlist_match_proto(const s=
truct openvpn_sockaddr *a1, const struct addrinfo *addr_list, const int pro=
to)
 {
     return link_socket_proto_connection_oriented(proto) ? addrlist_=
match(a1, addr_list)
                                                      =
   : addrlist_port_match(a1, addr_list);
diff --git a/src/openvpn/socks=2Ec=
 b/src/openvpn/socks=2Ec
index 19f3d54=2E=2E77ca863 100644
--- a/src/openvp=
n/socks=2Ec
+++ b/src/openvpn/socks=2Ec
@@ -82,7 +82,7 @@
 
 static bool
 s=
ocks_proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,
=
-                      struct event_timeout *server_poll_timeout,
+        =
              const struct event_timeout *server_poll_timeout,
            =
           volatile int *signal_received)
 {
     fd_set reads;
@@ -97,8 +9=
7,8 @@
 }
 
 static bool
-socks_username_password_auth(struct socks_proxy_i=
nfo *p, socket_descriptor_t sd,
-                             struct event_=
timeout *server_poll_timeout,
+socks_username_password_auth(const struct so=
cks_proxy_info *p, socket_descriptor_t sd,
+                             co=
nst struct event_timeout *server_poll_timeout,
                            =
  volatile int *signal_received)
 {
     char to_send[516];
@@ -156,8 +156,=
8 @@
 }
 
 static bool
-socks_handshake(struct socks_proxy_info *p, socket_=
descriptor_t sd,
-                struct event_timeout *server_poll_timeout=
, volatile int *signal_received)
+socks_handshake(const struct socks_proxy_=
info *p, socket_descriptor_t sd,
+                const struct event_timeou=
t *server_poll_timeout, volatile int *signal_received)
 {
     uint8_t buf[=
2];
     int len =3D 0;
@@ -231,7 +231,7 @@
 
 static bool
 recv_socks_repl=
y(socket_descriptor_t sd, struct openvpn_sockaddr *addr,
-                 =
struct event_timeout *server_poll_timeout, volatile int *signal_received)
+=
                 const struct event_timeout *server_poll_timeout, volatile =
int *signal_received)
 {
     uint8_t atyp =3D 0;
     int alen =3D 0;
@@ -=
334,11 +334,11 @@
 }
 
 void
-establish_socks_proxy_passthru(struct socks_p=
roxy_info *p,
+establish_socks_proxy_passthru(const struct socks_proxy_info=
 *p,
                                socket_descriptor_t sd, /* already ope=
n to proxy */
                                const char *host,       /* op=
envpn server remote */
                                const char *servname=
,   /* openvpn server port */
-                               struct event_=
timeout *server_poll_timeout,
+                               const struct =
event_timeout *server_poll_timeout,
                                struct =
signal_info *sig_info)
 {
     char buf[270];
@@ -392,10 +392,10 @@
 }
 
 v=
oid
-establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
+establish_=
socks_proxy_udpassoc(const struct socks_proxy_info *p,
                    =
            socket_descriptor_t ctrl_sd, /* already open to proxy */
      =
                          struct openvpn_sockaddr *relay_addr,
-           =
                    struct event_timeout *server_poll_timeout,
+           =
                    const struct event_timeout *server_poll_timeout,
      =
                          struct signal_info *sig_info)
 {
     if (!socks_=
handshake(p, ctrl_sd, server_poll_timeout, &sig_info->signal_received))
dif=
f --git a/src/openvpn/socks=2Eh b/src/openvpn/socks=2Eh
index 846113d=2E=2E=
f7c93b6 100644
--- a/src/openvpn/socks=2Eh
+++ b/src/openvpn/socks=2Eh
@@ -=
47,17 +47,17 @@
 
 void socks_proxy_close(struct socks_proxy_info *sp);
 
-=
void establish_socks_proxy_passthru(struct socks_proxy_info *p,
+void estab=
lish_socks_proxy_passthru(const struct socks_proxy_info *p,
               =
                      socket_descriptor_t sd, /* already open to proxy */
 =
                                    const char *host,       /* openvpn serv=
er remote */
                                     const char *servname,   /=
* openvpn server port */
-                                    struct event_=
timeout *server_poll_timeout,
+                                    const st=
ruct event_timeout *server_poll_timeout,
                                  =
   struct signal_info *sig_info);
 
-void establish_socks_proxy_udpassoc(st=
ruct socks_proxy_info *p,
+void establish_socks_proxy_udpassoc(const struct=
 socks_proxy_info *p,
                                     socket_descripto=
r_t ctrl_sd, /* already open to proxy */
                                  =
   struct openvpn_sockaddr *relay_addr,
-                                  =
  struct event_timeout *server_poll_timeout,
+                             =
       const struct event_timeout *server_poll_timeout,
                   =
                  struct signal_info *sig_info);
 
 void socks_process_inco=
ming_udp(struct buffer *buf, struct link_socket_actual *from);
diff --git a=
/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 7f3b4dc=2E=2E262522b 10064=
4
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1159,7 +1159,7 @@=

 }
 
 struct tls_multi *
-tls_multi_init(struct tls_options *tls_options)
=
+tls_multi_init(const struct tls_options *tls_options)
 {
     struct tls_m=
ulti *ret;
 
@@ -1188,7 +1188,7 @@
  */
 
 struct tls_auth_standalone *
-tl=
s_auth_standalone_init(struct tls_options *tls_options, struct gc_arena *gc=
)
+tls_auth_standalone_init(const struct tls_options *tls_options, struct g=
c_arena *gc)
 {
     struct tls_auth_standalone *tas;
 
@@ -1336,7 +1336,7 =
@@
 
 static void
 init_epoch_keys(struct key_state *ks, struct tls_multi *=
multi, const struct key_type *key_type,
-                bool server, struc=
t key2 *key2)
+                bool server, const struct key2 *key2)
 {
   =
  /* For now we hardcode this to be 16 for the software based data channel
=
      * DCO based implementations/HW implementation might adjust this numbe=
r
@@ -1375,7 +1375,7 @@
 
 static void
 init_key_contexts(struct key_state =
*ks, struct tls_multi *multi, const struct key_type *key_type,
-           =
       bool server, struct key2 *key2, bool dco_enabled)
+                 =
 bool server, const struct key2 *key2, bool dco_enabled)
 {
     struct key=
_ctx_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
 
@@ -1573,8 +1573,9 @@
=
 
 bool
 tls_session_update_crypto_params_do_work(struct tls_multi *multi, =
struct tls_session *session,
-                                         stru=
ct options *options, struct frame *frame,
-                                =
         struct frame *frame_fragment, struct link_socket_info *lsi,
+     =
                                    const struct options *options, struct f=
rame *frame,
+                                         struct frame *frame_=
fragment,
+                                         const struct link_socke=
t_info *lsi,
                                          dco_context_t *dco)
=
 {
     if (session->key[KS_PRIMARY]=2Ecrypto_options=2Ekey_ctx_bi=2Einitia=
lized)
@@ -1643,7 +1644,7 @@
 bool
 tls_session_update_crypto_params(struct=
 tls_multi *multi, struct tls_session *session,
                           =
       struct options *options, struct frame *frame,
-                     =
            struct frame *frame_fragment, struct link_socket_info *lsi,
+  =
                               struct frame *frame_fragment, const struct l=
ink_socket_info *lsi,
                                  dco_context_t *dco)=

 {
     if (!check_session_cipher(session, options))
@@ -2495,8 +2496,8 @@=

 }
 
 bool
-session_skip_to_pre_start(struct tls_session *session, struct =
tls_pre_decrypt_state *state,
-                          struct link_socket=
_actual *from)
+session_skip_to_pre_start(struct tls_session *session, cons=
t struct tls_pre_decrypt_state *state,
+                          const str=
uct link_socket_actual *from)
 {
     struct key_state *ks =3D &session->ke=
y[KS_PRIMARY];
     ks->session_id_remote =3D state->peer_session_id;
@@ -4=
011,7 +4012,7 @@
 }
 
 void
-tls_post_encrypt(struct tls_multi *multi, stru=
ct buffer *buf)
+tls_post_encrypt(struct tls_multi *multi, const struct buf=
fer *buf)
 {
     struct key_state *ks =3D multi->save_ks;
     multi->save=
_ks =3D NULL;
@@ -4142,7 +4143,7 @@
  * into a garbage collectable string w=
hich is returned=2E
  */
 const char *
-protocol_dump(struct buffer *buffer=
, unsigned int flags, struct gc_arena *gc)
+protocol_dump(const struct buff=
er *buffer, unsigned int flags, struct gc_arena *gc)
 {
     struct buffer =
out =3D alloc_buf_gc(256, gc);
     struct buffer buf =3D *buffer;
diff --g=
it a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 5822336=2E=2E3370321 1=
00644
--- a/src/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -166,7 +166,7 =
@@
  *
  * @return A newly allocated and initialized \c tls_multi structure=
=2E
  */
-struct tls_multi *tls_multi_init(struct tls_options *tls_options)=
;
+struct tls_multi *tls_multi_init(const struct tls_options *tls_options);=

 
 /**
  * Finalize initialization of a \c tls_multi structure=2E
@@ -187,=
7 +187,7 @@
 /*
  * Initialize a standalone tls-auth verification object=2E=

  */
-struct tls_auth_standalone *tls_auth_standalone_init(struct tls_opti=
ons *tls_options,
+struct tls_auth_standalone *tls_auth_standalone_init(con=
st struct tls_options *tls_options,
                                       =
               struct gc_arena *gc);
 
 /**
@@ -371,7 +371,7 @@
  * @param =
multi - The TLS state for this packet's destination VPN tunnel=2E
  * @para=
m buf - The buffer containing the outgoing packet=2E
  */
-void tls_post_en=
crypt(struct tls_multi *multi, struct buffer *buf);
+void tls_post_encrypt(=
struct tls_multi *multi, const struct buffer *buf);
 
 /** @} name Function=
s for managing security parameter state for data channel packets */
 
@@ -4=
61,7 +461,8 @@
  */
 bool tls_session_update_crypto_params(struct tls_multi=
 *multi, struct tls_session *session,
                                     =
  struct options *options, struct frame *frame,
-                          =
            struct frame *frame_fragment, struct link_socket_info *lsi,
+  =
                                    struct frame *frame_fragment,
+        =
                              const struct link_socket_info *lsi,
         =
                              dco_context_t *dco);
 
 /*
@@ -525,7 +526,7 @=
@
 #define PD_VERBOSE                 (1 << 10)
 #define PD_TLS_CRYPT      =
         (1 << 11)
 
-const char *protocol_dump(struct buffer *buffer, unsi=
gned int flags, struct gc_arena *gc);
+const char *protocol_dump(const stru=
ct buffer *buffer, unsigned int flags, struct gc_arena *gc);
 
 /*
  * debu=
gging code
@@ -573,7 +574,7 @@
 /* Special method to skip the three way han=
dshake RESET stages=2E This is
  * used by the HMAC code when seeing a pack=
et that matches the previous
  * HMAC based stateless server state */
-bool=
 session_skip_to_pre_start(struct tls_session *session, struct tls_pre_decr=
ypt_state *state,
-                               struct link_socket_actual=
 *from);
+bool session_skip_to_pre_start(struct tls_session *session, const=
 struct tls_pre_decrypt_state *state,
+                               const=
 struct link_socket_actual *from);
 
 #endif /* ifndef OPENVPN_SSL_H */
dif=
f --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh
index 8=
16fb9c=2E=2Eed395e7 100644
--- a/src/openvpn/ssl_backend=2Eh
+++ b/src/open=
vpn/ssl_backend=2Eh
@@ -144,7 +144,7 @@
  *
  * @return      true if the co=
ntext is initialised, false if not=2E
  */
-bool tls_ctx_initialised(struct=
 tls_root_ctx *ctx);
+bool tls_ctx_initialised(const struct tls_root_ctx *c=
tx);
 
 /**
  * Set any library specific options=2E
@@ -177,7 +177,7 @@
  *=
 @param ciphers       String containing : delimited cipher names, or NULL t=
o use
  *                                      sane defaults=2E
  */
-void =
tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *cipher=
s);
+void tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, co=
nst char *ciphers);
 
 /**
  * Set the TLS certificate profile=2E  The prof=
ile defines which crypto
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/ope=
nvpn/ssl_mbedtls=2Ec
index 9d408c0=2E=2E7893be0 100644
--- a/src/openvpn/ss=
l_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -161,7 +161,7 @@
 }
 
 b=
ool
-tls_ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(con=
st struct tls_root_ctx *ctx)
 {
     /* either this should be NULL or shoul=
d be non-null and then have a
      * valid TLS ctx inside as well */
@@ -2=
84,7 +284,7 @@
 }
 
 void
-tls_ctx_restrict_ciphers_tls13(struct tls_root_c=
tx *ctx, const char *ciphers)
+tls_ctx_restrict_ciphers_tls13(const struct =
tls_root_ctx *ctx, const char *ciphers)
 {
     if (ciphers =3D=3D NULL)
  =
   {
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec=

index 306f85cd=2E=2E706d78d 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b=
/src/openvpn/ssl_openssl=2Ec
@@ -147,7 +147,7 @@
 }
 
 bool
-tls_ctx_initia=
lised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(const struct tls_root_=
ctx *ctx)
 {
     /* either this should be NULL or should be non-null and t=
hen have a
      * valid TLS ctx inside as well */
@@ -509,7 +509,7 @@
 #en=
dif
 
 void
-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const=
 char *ciphers)
+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *=
ctx, const char *ciphers)
 {
     if (ciphers =3D=3D NULL)
     {
@@ -1165,=
7 +1165,7 @@
 }
 
 static void
-tls_ctx_load_cert_uri(struct tls_root_ctx *=
tls_ctx, const char *uri)
+tls_ctx_load_cert_uri(const struct tls_root_ctx =
*tls_ctx, const char *uri)
 {
 #if defined(HAVE_OPENSSL_STORE_API)
     X50=
9 *x =3D NULL;
@@ -2078,7 +2078,7 @@
 }
 
 static void
-bio_debug_data(cons=
t char *mode, BIO *bio, const uint8_t *buf, int len, const char *desc)
+bio=
_debug_data(const char *mode, const BIO *bio, const uint8_t *buf, int len, =
const char *desc)
 {
     struct gc_arena gc =3D gc_new();
     if (len > 0=
)
@@ -2092,7 +2092,7 @@
 }
 
 static void
-bio_debug_oc(const char *mode, B=
IO *bio)
+bio_debug_oc(const char *mode, const BIO *bio)
 {
     open_biofp=
();
     fprintf(biofp, "BIO %s time=3D%" PRIi64 " bio=3D" ptr_format "\n",=
 mode, (int64_t)time(NULL),
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/open=
vpn/ssl_pkt=2Ec
index 1805995=2E=2E6b53e7e 100644
--- a/src/openvpn/ssl_pkt=
=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -57,7 +57,7 @@
  *  @return         i=
f the swap was successful (buf was large enough)
  */
 static bool
-swap_hm=
ac(struct buffer *buf, const struct crypto_options *co, bool incoming)
+swa=
p_hmac(const struct buffer *buf, const struct crypto_options *co, bool inco=
ming)
 {
     ASSERT(co);
 
@@ -117,7 +117,7 @@
  */
 static void
 tls_wrap=
_control(struct tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,
-   =
              struct session_id *session_id)
+                 const struct=
 session_id *session_id)
 {
     if (ctx->mode =3D=3D TLS_WRAP_AUTH || ctx-=
>mode =3D=3D TLS_WRAP_NONE)
     {
@@ -403,9 +403,9 @@
 
 
 struct buffer
-=
tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *=
tas,
-                     struct session_id *own_sid, struct session_id *r=
emote_sid, uint8_t header,
-                     bool request_resend_wkc)
+=
tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standa=
lone *tas,
+                     const struct session_id *own_sid, const st=
ruct session_id *remote_sid,
+                     uint8_t header, bool req=
uest_resend_wkc)
 {
     /* Copy buffer here to point at the same data but =
allow tls_wrap_control
      * to potentially change buf to point to anothe=
r buffer without
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=
=2Eh
index ac9d4be=2E=2Effd34f4 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/=
src/openvpn/ssl_pkt=2Eh
@@ -220,8 +220,9 @@
  * from the tls pre decrypt st=
ate=2E
  *
  */
-struct buffer tls_reset_standalone(struct tls_wrap_ctx *ct=
x, struct tls_auth_standalone *tas,
-                                   str=
uct session_id *own_sid, struct session_id *remote_sid,
+struct buffer tls_=
reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone=
 *tas,
+                                   const struct session_id *own_sid=
,
+                                   const struct session_id *remote_sid,
=
                                    uint8_t header, bool request_resend_wkc=
);
 
 
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec=

index e5b55a1=2E=2E0298106 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/s=
rc/openvpn/ssl_verify=2Ec
@@ -1137,7 +1137,7 @@
  * cache=2E
  */
 static b=
ool
-tls_authentication_status_use_cache(struct tls_multi *multi)
+tls_auth=
entication_status_use_cache(const struct tls_multi *multi)
 {
     unsigned=
 int idx =3D min_uint(multi->tas_cache_num_updates, SIZE(cache_intervals) -=
 1);
     time_t latency =3D cache_intervals[idx];
@@ -1281,7 +1281,7 @@
  =
* Check if the script/plugin left a message in the auth failed message
  * =
file and relay it to the user */
 static void
-check_for_client_reason(stru=
ct tls_multi *multi, struct auth_deferred_status *status)
+check_for_client=
_reason(struct tls_multi *multi, const struct auth_deferred_status *status)=

 {
     struct gc_arena gc =3D gc_new();
     const char *msg =3D key_stat=
e_check_auth_failed_message_file(status, &gc);
@@ -1550,7 +1550,7 @@
 #endi=
f /* ifdef ENABLE_MANAGEMENT */
 
 static bool
-set_verify_user_pass_env(st=
ruct user_pass *up, struct tls_multi *multi, struct tls_session *session)
+=
set_verify_user_pass_env(const struct user_pass *up, struct tls_multi *mult=
i, struct tls_session *session)
 {
     /* Is username defined? */
     if =
((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->use=
rname))
@@ -1578,7 +1578,7 @@
 }
 
 bool
-ssl_verify_username_length(struct=
 tls_session *session, const char *username)
+ssl_verify_username_length(co=
nst struct tls_session *session, const char *username)
 {
     if ((session=
->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
         && strlen(usernam=
e) > TLS_USERNAME_LEN)
diff --git a/src/openvpn/ssl_verify=2Eh b/src/openvp=
n/ssl_verify=2Eh
index 3176d76=2E=2Ee77bc4a 100644
--- a/src/openvpn/ssl_ve=
rify=2Eh
+++ b/src/openvpn/ssl_verify=2Eh
@@ -202,7 +202,7 @@
  * @return  =
            true if name is under limit or username-as-common-name
  *     =
                 is not active
  */
-bool ssl_verify_username_length(struct=
 tls_session *session, const char *username);
+bool ssl_verify_username_len=
gth(const struct tls_session *session, const char *username);
 
 /**
  * Ru=
ns the --client-crresponse script if one is defined=2E
@@ -275,7 +275,7 @@
=
 void auth_set_client_reason(struct tls_multi *multi, const char *client_re=
ason);
 
 static inline const char *
-tls_client_reason(struct tls_multi *m=
ulti)
+tls_client_reason(const struct tls_multi *multi)
 {
     return mult=
i->client_reason;
 }
diff --git a/src/openvpn/status=2Ec b/src/openvpn/stat=
us=2Ec
index c7d375b=2E=2Ecfbc38d 100644
--- a/src/openvpn/status=2Ec
+++ b=
/src/openvpn/status=2Ec
@@ -135,7 +135,7 @@
 }
 
 void
-status_reset(struct=
 status_output *so)
+status_reset(const struct status_output *so)
 {
     i=
f (so && so->fd >=3D 0)
     {
diff --git a/src/openvpn/status=2Eh b/src/op=
envpn/status=2Eh
index 7953a4e=2E=2E4c01d75 100644
--- a/src/openvpn/status=
=2Eh
+++ b/src/openvpn/status=2Eh
@@ -69,7 +69,7 @@
 
 bool status_trigger(=
struct status_output *so);
 
-void status_reset(struct status_output *so);
=
+void status_reset(const struct status_output *so);
 
 void status_flush(st=
ruct status_output *so);
 
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/t=
un=2Ec
index bc262cd=2E=2E7e1999d 100644
--- a/src/openvpn/tun=2Ec
+++ b/sr=
c/openvpn/tun=2Ec
@@ -835,7 +835,7 @@
          const char *ifconfig_ipv6_l=
ocal_parm,     /* --ifconfig parm 1 IPv6 */
          int ifconfig_ipv6_net=
bits_parm,
          const char *ifconfig_ipv6_remote_parm,    /* --ifconfi=
g parm 2 IPv6 */
-         struct addrinfo *local_public, struct addrinfo *=
remote_public, const bool strict_warn,
+         const struct addrinfo *loc=
al_public, const struct addrinfo *remote_public, const bool strict_warn,
  =
        struct env_set *es, openvpn_net_ctx_t *ctx, struct tuntap *tt)
 {
 =
    if (!tt)
@@ -978,7 +978,7 @@
  * -> helper function to simplify code be=
low
  */
 static void
-add_route_connected_v6_net(struct tuntap *tt, const =
struct env_set *es)
+add_route_connected_v6_net(const struct tuntap *tt, co=
nst struct env_set *es)
 {
     struct route_ipv6 r6;
 
@@ -1020,7 +1020,7 =
@@
  */
 
 in_addr_t
-create_arbitrary_remote(struct tuntap *tt)
+create_ar=
bitrary_remote(const struct tuntap *tt)
 {
     in_addr_t remote;
 
@@ -159=
2,7 +1592,7 @@
 }
 
 static void
-undo_ifconfig_ipv4(struct tuntap *tt, ope=
nvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4(const struct tuntap *tt, openvpn_n=
et_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     int netbits =3D netmask_t=
o_netbits2(tt->remote_netmask);
@@ -1627,7 +1627,7 @@
 }
 
 static void
-un=
do_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_=
ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGE=
T_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_name, &tt->local_ipv6, tt=
->netbits_ipv6) < 0)
@@ -1652,7 +1652,7 @@
 }
 
 void
-undo_ifconfig(struct=
 tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig(const struct tuntap *tt=
, openvpn_net_ctx_t *ctx)
 {
     if (tt->backend_driver !=3D DRIVER_NULL &=
& tt->backend_driver !=3D DRIVER_AFUNIX)
     {
@@ -1729,7 +1729,7 @@
 #end=
if
 
 static ssize_t
-write_tun_header(struct tuntap *tt, uint8_t *buf, int=
 len)
+write_tun_header(const struct tuntap *tt, const uint8_t *buf, int le=
n)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1746,9 +1746,11 @@
=
             type =3D htonl(AF_INET);
         }
 
+        /* argument to =
writev is a pointer to const but we still need to drop
+         * the cons=
t from buf pointer here */
         iv[0]=2Eiov_base =3D &type;
         iv=
[0]=2Eiov_len =3D sizeof(type);
-        iv[1]=2Eiov_base =3D buf;
+       =
 iv[1]=2Eiov_base =3D (void *)buf;
         iv[1]=2Eiov_len =3D len;
 
    =
     return header_modify_read_write_return(writev(tt->fd, iv, 2));
@@ -176=
0,7 +1762,7 @@
 }
 
 static ssize_t
-read_tun_header(struct tuntap *tt, uin=
t8_t *buf, int len)
+read_tun_header(const struct tuntap *tt, uint8_t *buf,=
 int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1786,13 +178=
8,13 @@
  */
 #if !defined(TARGET_DARWIN)
 ssize_t
-write_tun(struct tuntap=
 *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint=
8_t *buf, int len)
 {
     return write_tun_header(tt, buf, len);
 }
 
 ssi=
ze_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const st=
ruct tuntap *tt, uint8_t *buf, int len)
 {
     return read_tun_header(tt, =
buf, len);
 }
@@ -1808,7 +1810,7 @@
 
 #if defined(TARGET_LINUX) || defined=
(TARGET_FREEBSD)
 static bool
-tun_dco_enabled(struct tuntap *tt)
+tun_dco_=
enabled(const struct tuntap *tt)
 {
     return tt->backend_driver =3D=3D D=
RIVER_DCO;
 }
@@ -2055,13 +2057,13 @@
 }
 
 ssize_t
-write_tun(struct tunta=
p *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uin=
t8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-=
read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct t=
untap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }=

@@ -2260,13 +2262,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_=
t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, in=
t len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(stru=
ct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, ui=
nt8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -2596,7 +=
2598,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len=
)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     =
struct strbuf sbuf;
     sbuf=2Elen =3D len;
@@ -2605,7 +2607,7 @@
 }
 
 ss=
ize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const s=
truct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
     i=
nt f =3D 0;
@@ -3103,7 +3105,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *t=
t, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t=
 *buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
@=
@ -3116,7 +3118,7 @@
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *bu=
f, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
  =
   if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
@@ -3320,7 +3322,7 @@
=
 }
 
 int
-tun_write_queue(struct tuntap *tt, struct buffer *buf)
+tun_writ=
e_queue(struct tuntap *tt, const struct buffer *buf)
 {
     if (tt->writes=
=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
@@ -3375,7 +3377,7 @@
 }
 
 int
-=
tun_write_win32(struct tuntap *tt, struct buffer *buf)
+tun_write_win32(str=
uct tuntap *tt, const struct buffer *buf)
 {
     int err =3D 0;
     int s=
tatus =3D 0;
@@ -5383,7 +5385,7 @@
 }
 
 void
-fork_register_dns_action(str=
uct tuntap *tt)
+fork_register_dns_action(const struct tuntap *tt)
 {
     =
if (tt && tt->options=2Eregister_dns && tt->options=2Emsg_channel)
     {
@=
@ -5473,7 +5475,7 @@
 }
 
 static void
-tuntap_get_mtu(struct tuntap *tt)
+=
tuntap_get_mtu(const struct tuntap *tt)
 {
     ULONG mtu =3D 0;
     DWORD=
 len;
@@ -6048,7 +6050,7 @@
 }
 
 void
-tun_show_debug(struct tuntap *tt)
+=
tun_show_debug(const struct tuntap *tt)
 {
     if (tt->backend_driver =3D=
=3D WINDOWS_DRIVER_TAP_WINDOWS6)
     {
diff --git a/src/openvpn/tun=2Eh b/=
src/openvpn/tun=2Eh
index 6a7af85=2E=2E41b93cb 100644
--- a/src/openvpn/tun=
=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -272,9 +272,9 @@
 
 void close_tun_handle=
(struct tuntap *tt);
 
-ssize_t write_tun(struct tuntap *tt, uint8_t *buf, =
int len);
+ssize_t write_tun(const struct tuntap *tt, const uint8_t *buf, i=
nt len);
 
-ssize_t read_tun(struct tuntap *tt, uint8_t *buf, int len);
+ss=
ize_t read_tun(const struct tuntap *tt, uint8_t *buf, int len);
 
 #ifdef E=
NABLE_FEATURE_TUN_PERSIST
 void tuncfg(const char *dev, const char *dev_typ=
e, const char *dev_node, int persist_mode,
@@ -293,7 +293,7 @@
            =
             const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1=
 / IPv6 */
                         int ifconfig_ipv6_netbits_parm,        =
   /* --ifconfig parm 1 / bits */
                         const char *ifco=
nfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 */
-                 =
       struct addrinfo *local_public, struct addrinfo *remote_public,
+    =
                    const struct addrinfo *local_public, const struct addri=
nfo *remote_public,
                         const bool strict_warn, struct=
 env_set *es, openvpn_net_ctx_t *ctx,
                         struct tunta=
p *tt);
 
@@ -320,7 +320,7 @@
  * @param tt    the tuntap interface context=

  * @param ctx   the networking API opaque context
  */
-void undo_ifconfi=
g(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+void undo_ifconfig(const str=
uct tuntap *tt, openvpn_net_ctx_t *ctx);
 
 bool is_dev_type(const char *de=
v, const char *dev_type, const char *match_type);
 
@@ -351,7 +351,7 @@
 #d=
efine IFCONFIG_DEFAULT IFCONFIG_AFTER_TUN_OPEN
 
 static inline int
-ifconf=
ig_order(struct tuntap *tt)
+ifconfig_order(const struct tuntap *tt)
 {
   =
  if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -381,7 +381,7 @@
 =
#define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN
 
 static inline int
-route_ord=
er(struct tuntap *tt)
+route_order(const struct tuntap *tt)
 {
     if (tt-=
>backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -454,13 +454,13 @@
 
 const=
 char *tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc);
 
-vo=
id tun_show_debug(struct tuntap *tt);
+void tun_show_debug(const struct tun=
tap *tt);
 
 bool dhcp_release_by_adapter_index(const DWORD adapter_index);=

 
 bool dhcp_renew_by_adapter_index(const DWORD adapter_index);
 
-void fo=
rk_register_dns_action(struct tuntap *tt);
+void fork_register_dns_action(c=
onst struct tuntap *tt);
 
 void ipconfig_register_dns(const struct env_set=
 *es);
 
@@ -470,7 +470,7 @@
 
 int tun_read_queue(struct tuntap *tt, int m=
axsize);
 
-int tun_write_queue(struct tuntap *tt, struct buffer *buf);
+in=
t tun_write_queue(struct tuntap *tt, const struct buffer *buf);
 
 static i=
nline bool
 tuntap_stop(int status)
@@ -499,7 +499,7 @@
     return false;
=
 }
 
-int tun_write_win32(struct tuntap *tt, struct buffer *buf);
+int tun_=
write_win32(struct tuntap *tt, const struct buffer *buf);
 
 static inline =
bool
 is_ip_packet_valid(const struct buffer *buf)
@@ -529,13 +529,13 @@
 }=

 
 static inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco=
_win(const struct tuntap *tt)
 {
     return tt && tt->backend_driver =3D=
=3D DRIVER_DCO;
 }
 
 static inline bool
-tuntap_is_dco_win_timeout(struct =
tuntap *tt, int status)
+tuntap_is_dco_win_timeout(const struct tuntap *tt,=
 int status)
 {
     return tuntap_is_dco_win(tt) && (status < 0) && (openv=
pn_errno() =3D=3D ERROR_NETNAME_DELETED);
 }
@@ -555,25 +555,25 @@
 }
 
 st=
atic inline void
-tun_standby_init(struct tuntap *tt)
+tun_standby_init(con=
st struct tuntap *tt)
 {
 }
 
 static inline bool
-tun_standby(struct tunta=
p *tt)
+tun_standby(const struct tuntap *tt)
 {
     return true;
 }
 
 
 s=
tatic inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(=
const struct tuntap *tt)
 {
     return false;
 }
 
 static inline bool
-tu=
ntap_is_dco_win_timeout(struct tuntap *tt, int status)
+tuntap_is_dco_win_t=
imeout(const struct tuntap *tt, int status)
 {
     return false;
 }
diff -=
-git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec
index a67a47=
2=2E=2Ee9223bc 100644
--- a/src/openvpn/tun_afunix=2Ec
+++ b/src/openvpn/tu=
n_afunix=2Ec
@@ -48,7 +48,7 @@
 
 
 static void
-tun_afunix_exec_child(cons=
t char *dev_node, struct tuntap *tt, struct env_set *env)
+tun_afunix_exec_=
child(const char *dev_node, struct tuntap *tt, const struct env_set *env)
 =
{
     const char *msgprefix =3D "ERROR: failure executing process for tun:=
";
     struct argv argv =3D argv_new();
@@ -73,7 +73,7 @@
 }
 
 void
-open=
_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set *=
orig_env)
+open_tun_afunix(const struct options *o, int mtu, struct tuntap =
*tt, const struct env_set *orig_env)
 {
     struct gc_arena gc =3D gc_new(=
);
 
diff --git a/src/openvpn/tun_afunix=2Eh b/src/openvpn/tun_afunix=2Eh
i=
ndex 5b6a8e0=2E=2Efb88eb2 100644
--- a/src/openvpn/tun_afunix=2Eh
+++ b/src=
/openvpn/tun_afunix=2Eh
@@ -31,7 +31,7 @@
  * the user provided taking care=
 of implementing the actual tun
  * device=2E
  */
-void open_tun_afunix(st=
ruct options *o, int mtu, struct tuntap *tt, struct env_set *env);
+void op=
en_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, const st=
ruct env_set *env);
 
 
 /**
diff --git a/src/openvpn/vlan=2Ec b/src/openvp=
n/vlan=2Ec
index bffc60e=2E=2Ecd32a9b 100644
--- a/src/openvpn/vlan=2Ec
+++=
 b/src/openvpn/vlan=2Ec
@@ -288,7 +288,7 @@
 }
 
 void
-vlan_process_outgoi=
ng_tun(struct multi_context *m, struct multi_instance *mi)
+vlan_process_ou=
tgoing_tun(const struct multi_context *m, struct multi_instance *mi)
 {
   =
  if (!m->top=2Eoptions=2Evlan_tagging)
     {
diff --git a/src/openvpn/vla=
n=2Eh b/src/openvpn/vlan=2Eh
index 9389f89=2E=2Ecd2f66f 100644
--- a/src/op=
envpn/vlan=2Eh
+++ b/src/openvpn/vlan=2Eh
@@ -35,6 +35,6 @@
 
 bool vlan_is=
_tagged(const struct buffer *buf);
 
-void vlan_process_outgoing_tun(struct=
 multi_context *m, struct multi_instance *mi);
+void vlan_process_outgoing_=
tun(const struct multi_context *m, struct multi_instance *mi);
 
 #endif /*=
 VLAN_H */
diff --git a/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh
index=
 ef32062=2E=2Ebcbfa67 100644
--- a/src/openvpn/win32=2Eh
+++ b/src/openvpn/=
win32=2Eh
@@ -226,7 +226,7 @@
 void overlapped_io_close(struct overlapped_i=
o *o);
 
 static inline bool
-overlapped_io_active(struct overlapped_io *o)=

+overlapped_io_active(const struct overlapped_io *o)
 {
     return o->ios=
tate =3D=3D IOSTATE_QUEUED || o->iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;
 =
}
diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpn=
msica=2Ec
index a861e8a=2E=2E25fa1e4 100644
--- a/src/openvpnmsica/openvpnm=
sica=2Ec
+++ b/src/openvpnmsica/openvpnmsica=2Ec
@@ -77,7 +77,7 @@
  * @ret=
urn ERROR_SUCCESS on success; An error code otherwise
  */
 static UINT
-se=
tup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ struc=
t msica_arg_seq *seq)
+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWS=
TR szProperty, _In_ const struct msica_arg_seq *seq)
 {
     UINT uiResult;=

     LPWSTR szSequence =3D msica_arg_seq_join(seq);
diff --git a/src/openv=
pnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 628ec85=2E=
=2E1fff6af 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnse=
rv/interactive=2Ec
@@ -521,7 +521,7 @@
 
 
 static SOCKADDR_INET
-sockaddr_=
inet(short family, inet_address_t *addr)
+sockaddr_inet(short family, const=
 inet_address_t *addr)
 {
     SOCKADDR_INET sa_inet;
     ZeroMemory(&sa_i=
net, sizeof(sa_inet));
@@ -3733,7 +3733,7 @@
 
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
index 4a055e7=2E=2Eaf96764 100644
--- a/tests/uni=
t_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
=
@@ -146,7 +146,7 @@
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
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--X+OSXowG4+8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #8</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Re=
move instances of constParameterPointer cppcheck warnings<br><br>This requi=
res a few suppressions since cppcheck<br>doesn&#39;t quite understand the d=
ifferent code-paths<br>implemented by preprocessor defines=2E<br><br>Change=
-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/cppcheck-supp=
ression<br>M sample/sample-plugins/client-connect/sample-client-connect=2Ec=
<br>M sample/sample-plugins/defer/multi-auth=2Ec<br>M sample/sample-plugins=
/keying-material-exporter-demo/keyingmaterialexporter=2Ec<br>M src/openvpn/=
buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/clinat=2Ec<br>M src=
/openvpn/clinat=2Eh<br>M src/openvpn/comp=2Ec<br>M src/openvpn/comp=2Eh<br>=
M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/dco=
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
=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1663/8</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression</span><br><=
span>index 900e03c=2E=2E5bc4b24 100644</span><br><span>--- a/dev-tools/cppc=
heck-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppression</span=
><br><span>@@ -2,7 +2,6 @@</span><br><span> # occurences right now=2E They =
still should be fixed at some point</span><br><span> constParameter</span><=
br><span> constParameterCallback</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-constParameterPointer</span><br><span> invalidPrintfArgType_sint=
</span><br><span> invalidPrintfArgType_uint</span><br><span> usleepCalled</=
span><br><span>@@ -33,6 +32,39 @@</span><br><span> badBitmaskCheck:tests/un=
it_tests/openvpn/test_pkt=2Ec</span><br><span> # IGN: we store integers in =
pointers</span><br><span> CastAddressToIntegerAtReturn:src/openvpn/multi=2E=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPoin=
ter:/usr/include/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 IGN: test files provide mocks/stubs that match prototypes from headers exa=
ctly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterP=
ointer:tests/unit_tests/openvpn/mock_*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+constParameterPointer:tests/unit_tests/openvpn/test_*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:=
tests/unit_tests/openvpnserv/test_*</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# FP: different crypto implementations but same API</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/o=
penvpn/crypto_mbedtls_legacy=2Ec:85</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+constParameterPointer:src/openvpn/crypto_openssl=2Ec:172</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:=
src/openvpn/crypto_openssl=2Ec:1456</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+constParameterPointer:src/openvpn/cryptoapi=2Ec:58</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/op=
envpn/ssl_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+constParameterPointer:src/openvpn/ssl_openssl=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/ssl_ver=
ify_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IG=
N: too many different implementations, not worth it</span><br><span style=
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
x 131e1d6=2E=2Ef9990d6 100644</span><br><span>--- a/src/openvpn/buffer=2Ec<=
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
an>index 6a751ad=2E=2E9bdb36a 100644</span><br><span>--- a/src/openvpn/buff=
er=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -487=
,7 +487,7 @@</span><br><span>  * write a string to the end of a buffer that=
 was</span><br><span>  * truncated by buf_printf</span><br><span>  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void buf_catrunc(struct buf=
fer *buf, const char *str);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void buf_catrunc(const struct buffer *buf, const char *str);</span>=
<br><span> </span><br><span> /*</span><br><span>  * Parse a string based on=
 a given delimiter char</span><br><span>@@ -774,7 +774,7 @@</span><br><span=
> }</span><br><span> </span><br><span> static inline int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-buf_peek_u8(struct buffer *buf)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+buf_peek_u8(const struct buf=
fer *buf)</span><br><span> {</span><br><span>     int ret;</span><br><span>=
     if (BLEN(buf) &lt; 1)</span><br><span>@@ -923,7 +923,7 @@</span><br><s=
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
pto=2Ec</span><br><span>index a9a33c0=2E=2Ee04eedf 100644</span><br><span>-=
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
><br><span>index fbca2a0=2E=2E044f2d2 100644</span><br><span>--- a/src/open=
vpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><br><span=
>@@ -414,7 +414,7 @@</span><br><span>  */</span><br><span> int write_key_fi=
le(const int nkeys, const char *filename);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-bool check_key(struct key *key, cons=
t struct key_type *kt);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool check_key(const struct key *key, const struct key_type *kt);</span=
><br><span> </span><br><span> /**</span><br><span>  * Initialize a key_type=
 structure with=2E</span><br><span>@@ -609,7 +609,7 @@</span><br><span> /**=
 Print a cipher list entry */</span><br><span> void print_cipher(const char=
 *cipher);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void test_crypto(struct crypto_options *co, struct frame *f);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void test_crypto(struct cr=
ypto_options *co, const struct frame *f);</span><br><span> </span><br><span=
> </span><br><span> /* key direction functions */</span><br><span>diff --gi=
t a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index 69ce1d7=
=2E=2Ef509a29 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><s=
pan>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -556,7 +556,7 @@</span><br=
><span> }</span><br><span> </span><br><span> static bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-dco_multi_get_localaddr(struct multi_con=
text *m, struct multi_instance *mi,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+dco_multi_get_localaddr(const struct multi_context *m, cons=
t struct multi_instance *mi,</span><br><span>                         struc=
t sockaddr_storage *local)</span><br><span> {</span><br><span> #if ENABLE_I=
P_PKTINFO</span><br><span>@@ -568,7 +568,7 @@</span><br><span>         retu=
rn false;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct link_socket_actual *actual =3D &amp=
;c-&gt;c2=2Elink_socket_infos[0]-&gt;lsa-&gt;actual;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct link_socket_actual *actu=
al =3D &amp;c-&gt;c2=2Elink_socket_infos[0]-&gt;lsa-&gt;actual;</span><br><=
span> </span><br><span>     switch (actual-&gt;dest=2Eaddr=2Esa=2Esa_family=
)</span><br><span>     {</span><br><span>@@ -606,7 +606,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-dco_multi_add_new_peer(struct multi_context *m, struc=
t multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+dco_multi_add_new_peer(const struct multi_context *m, struct multi_instan=
ce *mi)</span><br><span> {</span><br><span>     const struct context *c =3D=
 &amp;mi-&gt;context;</span><br><span> </span><br><span>@@ -660,7 +660,7 @@=
</span><br><span> }</span><br><span> </span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-dco_install_iroute(struct multi_conte=
xt *m, struct multi_instance *mi, struct mroute_addr *addr)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+dco_install_iroute(struct multi_con=
text *m, struct multi_instance *mi, const struct mroute_addr *addr)</span><=
br><span> {</span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FR=
EEBSD) || defined(_WIN32)</span><br><span>     if (!dco_enabled(&amp;m-&gt;=
top=2Eoptions))</span><br><span>@@ -779,7 +779,7 @@</span><br><span>       =
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
/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 887d7d=
7=2E=2E1d76859 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><=
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
)</span><br><span>     {</span><br><span>@@ -984,7 +984,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-process_incoming_link_part1(struct context *c, struc=
t link_socket_info *lsi, bool floated)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+process_incoming_link_part1(struct context *c, const str=
uct link_socket_info *lsi, bool floated)</span><br><span> {</span><br><span=
>     struct gc_arena gc =3D gc_new();</span><br><span>     bool decrypt_st=
atus =3D false;</span><br><span>@@ -1534,7 +1534,7 @@</span><br><span>  * @=
param client    Determines whether to the send packet back via tun or link<=
/span><br><span>  */</span><br><span> void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-ipv6_send_icmp_unreachable(struct context *c, struct b=
uffer *buf, bool client)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ipv6_send_icmp_unreachable(struct context *c, const struct buffer *buf=
, bool client)</span><br><span> {</span><br><span> #define MAX_ICMPV6LEN 12=
80</span><br><span>     struct openvpn_icmp6hdr icmp6out;</span><br><span>d=
iff --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><sp=
an>index 0d3e492=2E=2Ed8e07fa 100644</span><br><span>--- a/src/openvpn/forw=
ard=2Eh</span><br><span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -1=
12,7 +112,7 @@</span><br><span>  */</span><br><span> void encrypt_sign(stru=
ct context *c, bool comp_frag);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-int get_server_poll_remaining_time(struct event=
_timeout *server_poll_timeout);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+int get_server_poll_remaining_time(const struct event_timeout *=
server_poll_timeout);</span><br><span> </span><br><span> /*****************=
*****************************************************/</span><br><span> /**=
</span><br><span>@@ -163,7 +163,7 @@</span><br><span>  *</span><br><span>  =
* @return true if packet is authenticated, false otherwise=2E</span><br><sp=
an>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool process_i=
ncoming_link_part1(struct context *c, struct link_socket_info *lsi, bool fl=
oated);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool process=
_incoming_link_part1(struct context *c, const struct link_socket_info *lsi,=
 bool floated);</span><br><span> </span><br><span> /**</span><br><span>  * =
Continues processing a packet read from the external network interface=2E</=
span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</sp=
an><br><span>index 0861cb5=2E=2E41fa557 100644</span><br><span>--- a/src/op=
envpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@=
@ -817,7 +817,7 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_port_sh=
are(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+init_port_share(const struct context *c)</span><br><span> {</span><br><s=
pan>     if (!port_share &amp;&amp; (c-&gt;options=2Eport_share_host &amp;&=
amp; c-&gt;options=2Eport_share_port))</span><br><span>     {</span><br><sp=
an>@@ -1269,7 +1269,7 @@</span><br><span>  * prepending to msg() output=2E<=
/span><br><span>  */</span><br><span> const char *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-format_common_name(struct context *c, struct g=
c_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+format_=
common_name(const struct context *c, struct gc_arena *gc)</span><br><span> =
{</span><br><span>     struct buffer out =3D alloc_buf_gc(256, gc);</span><=
br><span>     if (c-&gt;c2=2Etls_multi)</span><br><span>@@ -1755,7 +1755,7 =
@@</span><br><span> </span><br><span> </span><br><span> static bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-can_preserve_tun(struct tunta=
p *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+can_preserve_=
tun(const struct tuntap *tt)</span><br><span> {</span><br><span>     if (tt=
 &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>   =
  {</span><br><span>@@ -1777,7 +1777,7 @@</span><br><span>  * @param c poin=
ter to the connection context</span><br><span>  */</span><br><span> static =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_wfp_block(str=
uct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_=
wfp_block(const struct context *c)</span><br><span> {</span><br><span> #if =
defined(_WIN32)</span><br><span>     /* Fortify &#39;redirect-gateway block=
-local&#39; with firewall rules? */</span><br><span>@@ -1803,7 +1803,7 @@</=
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
penvpn/list=2Ec</span><br><span>index 2e1cf05=2E=2Ec04ee4f 100644</span><br=
><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2E=
c</span><br><span>@@ -162,7 +162,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
hash_remove_by_value(struct hash *hash, void *value)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+hash_remove_by_value(struct hash *hash, c=
onst void *value)</span><br><span> {</span><br><span>     struct hash_itera=
tor hi;</span><br><span>     const struct hash_element *he;</span><br><span=
>diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>i=
ndex 04cc3ab=2E=2E089637d 100644</span><br><span>--- a/src/openvpn/list=2Eh=
</span><br><span>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -73,7 +73,7 =
@@</span><br><span> </span><br><span> bool hash_remove_fast(struct hash *ha=
sh, struct hash_bucket *bucket, const void *key, uint32_t hv);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void hash_remove=
_by_value(struct hash *hash, void *value);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void hash_remove_by_value(struct hash *hash, const v=
oid *value);</span><br><span> </span><br><span> struct hash_iterator</span>=
<br><span> {</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/open=
vpn/manage=2Ec</span><br><span>index 604bbcd=2E=2E17abfd8 100644</span><br>=
<span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=
=2Ec</span><br><span>@@ -330,7 +330,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-man_delete_unix_socket(struct management *man)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+man_delete_unix_socket(const struct ma=
nagement *man)</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPORT</s=
pan><br><span>     if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_C=
ONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><span>@@ -675,7 +675,7 @@=
</span><br><span>  * for the log and echo commands=2E</span><br><span>  */<=
/span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-man_history(struct management *man, const char *parm, const char *ty=
pe, struct log_history *log,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+man_history(struct management *man, const char *parm, const char *=
type, const struct log_history *log,</span><br><span>             bool *rea=
ltime, const unsigned int lep_flags)</span><br><span> {</span><br><span>   =
  struct gc_arena gc =3D gc_new();</span><br><span>@@ -843,7 +843,7 @@</spa=
n><br><span> }</span><br><span> </span><br><span> static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-man_forget_passwords(struct managem=
ent *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_forget=
_passwords(const struct management *man)</span><br><span> {</span><br><span=
>     ssl_purge_auth(false);</span><br><span>     (void)ssl_clean_auth_toke=
n();</span><br><span>@@ -851,7 +851,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-man_net(struct management *man)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+man_net(const struct management *man)</span><br><span=
> {</span><br><span>     if (man-&gt;persist=2Ecallback=2Eshow_net)</span><=
br><span>     {</span><br><span>@@ -887,7 +887,7 @@</span><br><span> #ifdef=
 ENABLE_PKCS11</span><br><span> </span><br><span> static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-man_pkcs11_id_count(struct manageme=
nt *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_pkcs11_=
id_count(const struct management *man)</span><br><span> {</span><br><span> =
    msg(M_CLIENT, &quot;&gt;PKCS11ID-COUNT:%d&quot;, pkcs11_management_id_c=
ount());</span><br><span> }</span><br><span>@@ -1350,7 +1350,7 @@</span><br=
><span>  * @return          Return whether p has n (or at least n) paramete=
rs</span><br><span>  */</span><br><span> static bool</span><br><span style=
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
x 5e1b585=2E=2E39f85ba 100644</span><br><span>--- a/src/openvpn/mbuf=2Ec</s=
pan><br><span>+++ b/src/openvpn/mbuf=2Ec</span><br><span>@@ -160,7 +160,7 @=
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
b/src/openvpn/mtcp=2Ec</span><br><span>index df94a70=2E=2Ed9f14b3 100644</s=
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
=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 50d72d5=2E=2E4828a17 1006=
44</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/ope=
nvpn/mudp=2Ec</span><br><span>@@ -39,7 +39,7 @@</span><br><span> </span><br=
><span> static void</span><br><span> send_hmac_reset_packet(struct multi_co=
ntext *m, struct tls_pre_decrypt_state *state,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                       struct tls_auth_standalone =
*tas, struct session_id *sid,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                       const struct tls_auth_standalone *tas, con=
st struct session_id *sid,</span><br><span>                        bool req=
uest_resend_wkc)</span><br><span> {</span><br><span>     reset_packet_id_se=
nd(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);</span><br><span>@=
@ -69,7 +69,7 @@</span><br><span> </span><br><span>     enum first_packet_v=
erdict verdict;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct tls_auth_standalone *tas =3D m-&gt;top=2Ec2=2Etls_au=
th_standalone;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst struct tls_auth_standalone *tas =3D m-&gt;top=2Ec2=2Etls_auth_standalo=
ne;</span><br><span> </span><br><span>     verdict =3D tls_pre_decrypt_lite=
(tas, state, &amp;m-&gt;top=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Ebuf);</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvp=
n/multi=2Ec</span><br><span>index c72c4b2=2E=2Edd4d61d 100644</span><br><sp=
an>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec<=
/span><br><span>@@ -57,7 +57,7 @@</span><br><span> </span><br><span> #ifdef=
 MULTI_DEBUG_EVENT_LOOP</span><br><span> static const char *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-id(struct multi_instance *mi)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+id(const struct multi_inst=
ance *mi)</span><br><span> {</span><br><span>     if (mi)</span><br><span> =
    {</span><br><span>@@ -1315,7 +1315,7 @@</span><br><span>  * same common=
 name=2E</span><br><span>  */</span><br><span> static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-multi_delete_dup(struct multi_context =
*m, struct multi_instance *new_mi)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+multi_delete_dup(struct multi_context *m, const struct multi=
_instance *new_mi)</span><br><span> {</span><br><span>     if (new_mi)</spa=
n><br><span>     {</span><br><span>@@ -2260,7 +2260,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-multi_client_setup_dco_initial(struct multi_conte=
xt *m, struct multi_instance *mi,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+multi_client_setup_dco_initial(const struct multi_context *m,=
 struct multi_instance *mi,</span><br><span>                               =
 struct gc_arena *gc)</span><br><span> {</span><br><span>     if (!dco_enab=
led(&amp;mi-&gt;context=2Eoptions))</span><br><span>@@ -3195,7 +3195,7 @@</=
span><br><span> </span><br><span> #if defined(ENABLE_DCO)</span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-process_in=
coming_del_peer(struct multi_context *m, struct multi_instance *mi, dco_con=
text_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process=
_incoming_del_peer(struct multi_context *m, struct multi_instance *mi, cons=
t dco_context_t *dco)</span><br><span> {</span><br><span>     const char *r=
eason =3D &quot;ovpn-dco: unknown reason&quot;;</span><br><span>     switch=
 (dco-&gt;dco_del_peer_reason)</span><br><span>@@ -4226,7 +4226,7 @@</span>=
<br><span> </span><br><span> /* Searches for the address and deletes it if =
it is owned by the multi_instance */</span><br><span> static void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_addr(struct multi=
_context *m, struct multi_instance *mi, const struct mroute_addr *addr)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_addr(stru=
ct multi_context *m, const struct multi_instance *mi, const struct mroute_a=
ddr *addr)</span><br><span> {</span><br><span>     struct hash_element *he;=
</span><br><span>     const uint32_t hv =3D hash_value(m-&gt;vhash, addr);<=
/span><br><span>@@ -4261,7 +4261,7 @@</span><br><span>  * @param a     The =
new IPv4 address in network byte order</span><br><span>  */</span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_un=
learn_in_addr_t(struct multi_context *m, struct multi_instance *mi, in_addr=
_t a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_=
in_addr_t(struct multi_context *m, const struct multi_instance *mi, in_addr=
_t a)</span><br><span> {</span><br><span>     struct mroute_addr addr;</spa=
n><br><span>     CLEAR(addr);</span><br><span>@@ -4279,7 +4279,7 @@</span><=
br><span>  * @param a6    The new IPv6 address</span><br><span>  */</span><=
br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
multi_unlearn_in6_addr(struct multi_context *m, struct multi_instance *mi, =
struct in6_addr a6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
multi_unlearn_in6_addr(struct multi_context *m, const struct multi_instance=
 *mi, struct in6_addr a6)</span><br><span> {</span><br><span>     struct mr=
oute_addr addr;</span><br><span>     CLEAR(addr);</span><br><span>@@ -4395,=
7 +4395,7 @@</span><br><span> </span><br><span> bool</span><br><span> multi=
_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
           struct in6_addr *dest)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                           const struct in6_a=
ddr *dest)</span><br><span> {</span><br><span>     const struct options *o =
=3D &amp;mi-&gt;context=2Eoptions;</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index =
3ed08d4=2E=2Ecd7aa3e 100644</span><br><span>--- a/src/openvpn/multi=2Eh</sp=
an><br><span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -520,7 +520,7 @=
@</span><br><span>  */</span><br><span> </span><br><span> static inline voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set_prefix(struct mu=
lti_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+se=
t_prefix(const struct multi_instance *mi)</span><br><span> {</span><br><spa=
n> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>     if (mi-&gt;msg_prefix=
[0])</span><br><span>@@ -694,7 +694,7 @@</span><br><span>  */</span><br><sp=
an> bool</span><br><span> multi_check_push_ifconfig_ipv6_extra_route(struct=
 multi_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                          struct in6_addr *dest);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
              const struct in6_addr *dest);</span><br><span> </span><br><sp=
an> /*</span><br><span>  * Check for signals=2E</span><br><span>diff --git =
a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh</span><br><span>i=
ndex bce0c19=2E=2E25233c8 100644</span><br><span>--- a/src/openvpn/networki=
ng=2Eh</span><br><span>+++ b/src/openvpn/networking=2Eh</span><br><span>@@ =
-44,7 +44,7 @@</span><br><span>  */</span><br><span> #if !defined(ENABLE_IP=
ROUTE)</span><br><span> static inline int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_init(const =
struct context *c, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><sp=
an>     (void)c;</span><br><span>     (void)ctx;</span><br><span>@@ -75,7 +=
75,7 @@</span><br><span>  *</span><br><span>  * @return          0 on succe=
ss, a negative error code otherwise</span><br><span>  */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-int net_ctx_init(struct context *c, open=
vpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+int net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx);</span><=
br><span> </span><br><span> /**</span><br><span>  * Release resources alloc=
ated by the internal garbage collector</span><br><span>@@ -102,7 +102,7 @@<=
/span><br><span>  * @return          0 on success, negative error code on e=
rror</span><br><span>  */</span><br><span> int net_iface_new(openvpn_net_ct=
x_t *ctx, const openvpn_net_iface_t *iface, const char *type,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                  void *arg);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                  const v=
oid *arg);</span><br><span> </span><br><span> /**</span><br><span>  * Retri=
eve the interface type</span><br><span>diff --git a/src/openvpn/networking_=
iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span>index a1=
f3525=2E=2Ef091fb3 100644</span><br><span>--- a/src/openvpn/networking_ipro=
ute2=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec</span><b=
r><span>@@ -36,7 +36,7 @@</span><br><span> #include &lt;netinet/in=2Eh&gt;<=
/span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_init(const str=
uct context *c, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>=
     ctx-&gt;es =3D NULL;</span><br><span>     if (c)</span><br><span>@@ -6=
1,7 +61,7 @@</span><br><span> }</span><br><span> </span><br><span> int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_new(openvpn_net_=
ctx_t *ctx, const char *iface, const char *type, void *arg)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+net_iface_new(openvpn_net_ctx_t *ct=
x, const char *iface, const char *type, const void *arg)</span><br><span> {=
</span><br><span>     struct argv argv =3D argv_new();</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/n=
etworking_sitnl=2Ec</span><br><span>index e6e72d0=2E=2Ea1d220f 100644</span=
><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src=
/openvpn/networking_sitnl=2Ec</span><br><span>@@ -987,7 +987,7 @@</span><br=
><span> }</span><br><span> </span><br><span> static int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_del(sa_family_t af_family, con=
st char *iface, inet_address_t *addr, int prefixlen)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_del(sa_family_t af_family, con=
st char *iface, const inet_address_t *addr, int prefixlen)</span><br><span>=
 {</span><br><span>     int ifindex;</span><br><span> </span><br><span>@@ -=
1230,8 +1230,8 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_de=
l(const char *iface, sa_family_t af_family, inet_address_t *dst, int prefix=
len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                i=
net_address_t *gw, uint32_t table, int metric)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+sitnl_route_del(const char *iface, sa_family_t a=
f_family, const inet_address_t *dst, int prefixlen,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                const inet_address_t *gw,=
 uint32_t table, int metric)</span><br><span> {</span><br><span>     int if=
index =3D 0;</span><br><span> </span><br><span>@@ -1308,7 +1308,7 @@</span>=
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
pan>index 3494ce6=2E=2E32e0b6f 100644</span><br><span>--- a/src/openvpn/ope=
nssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh</span>=
<br><span>@@ -124,7 +124,7 @@</span><br><span> /* Mimics the functions but =
only when the default context without</span><br><span>  * options is chosen=
 */</span><br><span> static inline const EVP_CIPHER *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-EVP_CIPHER_fetch(void *ctx, const char *alg=
orithm, const char *properties)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+EVP_CIPHER_fetch(const void *ctx, const char *algorithm, const =
char *properties)</span><br><span> {</span><br><span>     ASSERT(!ctx);</sp=
an><br><span>     ASSERT(!properties);</span><br><span>@@ -132,7 +132,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> static inline const E=
VP_MD *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-EVP_MD_fetch(v=
oid *ctx, const char *algorithm, const char *properties)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+EVP_MD_fetch(const void *ctx, const ch=
ar *algorithm, const char *properties)</span><br><span> {</span><br><span> =
    ASSERT(!ctx);</span><br><span>     ASSERT(!properties);</span><br><span=
>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><=
span>index fd0d3fc=2E=2E6d85a23 100644</span><br><span>--- a/src/openvpn/op=
tions=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ =
-3050,7 +3050,7 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_post=
process_mutate_le(struct connection_entry *ce, struct local_entry *le, int =
mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_postpr=
ocess_mutate_le(const struct connection_entry *ce, struct local_entry *le, =
int mode)</span><br><span> {</span><br><span>     /* use the global port if=
 none is specified */</span><br><span>     if (!le-&gt;port)</span><br><spa=
n>@@ -4980,7 +4980,7 @@</span><br><span> static bool</span><br><span> verif=
y_permission(const char *name, const char *file, int line, const uint64_t t=
ype,</span><br><span>                   const uint64_t allowed, uint64_t *f=
ound, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                  struct options *options, bool is_inline)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  const str=
uct options *options, bool is_inline)</span><br><span> {</span><br><span>  =
   if (!(type &amp; allowed))</span><br><span>     {</span><br><span>@@ -55=
47,7 +5547,7 @@</span><br><span> }</span><br><span> </span><br><span> stati=
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
</span><br><span>index 84e315b=2E=2Eb5a9f7c 100644</span><br><span>--- a/sr=
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
nvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index 4de7615=2E=2Ed=
4e0a8b 100644</span><br><span>--- a/src/openvpn/proxy=2Ec</span><br><span>+=
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
src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index 57afacd=2E=2E=
0e581e5 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++=
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
ush=2Ec b/src/openvpn/push=2Ec</span><br><span>index a030acd=2E=2E373272f 1=
00644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/=
openvpn/push=2Ec</span><br><span>@@ -435,7 +435,7 @@</span><br><span> #endi=
f</span><br><span> </span><br><span> bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-send_auth_pending_messages(struct tls_multi *tls_multi,=
 struct tls_session *session,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+send_auth_pending_messages(const struct tls_multi *tls_multi, str=
uct tls_session *session,</span><br><span>                            const=
 char *extra, unsigned int timeout)</span><br><span> {</span><br><span>    =
 struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span=
>diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh</span><br><span>i=
ndex dff945f=2E=2E39302f6 100644</span><br><span>--- a/src/openvpn/push=2Eh=
</span><br><span>+++ b/src/openvpn/push=2Eh</span><br><span>@@ -117,7 +117,=
7 @@</span><br><span>  * doc/management-notes=2Etxt under client-pending-au=
th for</span><br><span>  * more details on message format</span><br><span> =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool send_auth_pen=
ding_messages(struct tls_multi *tls_multi, struct tls_session *session,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool send_auth_pending_=
messages(const struct tls_multi *tls_multi, struct tls_session *session,</s=
pan><br><span>                                 const char *extra, unsigned =
int timeout);</span><br><span> </span><br><span> void send_restart(struct c=
ontext *c, const char *kill_msg);</span><br><span>diff --git a/src/openvpn/=
push_util=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index af22af5=2E=
=2E008d45f 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span><br=
><span>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@ -222,7 +222,7 @@<=
/span><br><span> </span><br><span> /* Return true if the client supports pu=
sh-update */</span><br><span> static bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-support_push_update(struct multi_instance *mi)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+support_push_update(const st=
ruct multi_instance *mi)</span><br><span> {</span><br><span>     ASSERT(mi-=
&gt;context=2Ec2=2Etls_multi);</span><br><span>     const unsigned int iv_p=
roto_peer =3D extract_iv_proto(mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_inf=
o);</span><br><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/rel=
iable=2Ec</span><br><span>index 52adacf=2E=2E3588483 100644</span><br><span=
>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliable=
=2Ec</span><br><span>@@ -92,7 +92,7 @@</span><br><span> </span><br><span> /=
* check if a particular packet_id is present in ack */</span><br><span> sta=
tic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliab=
le_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_packet_id_p=
resent(const struct reliable_ack *ack, packet_id_type pid)</span><br><span>=
 {</span><br><span>     for (int i =3D 0; i &lt; ack-&gt;len; ++i)</span><b=
r><span>     {</span><br><span>@@ -733,7 +733,7 @@</span><br><span>  */</sp=
an><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-reliable_mark_active_incoming(struct reliable *rel, struct b=
uffer *buf, packet_id_type pid,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+reliable_mark_active_incoming(struct reliable *rel, const struc=
t buffer *buf, packet_id_type pid,</span><br><span>                        =
       int opcode)</span><br><span> {</span><br><span>     for (int i =3D 0=
; i &lt; rel-&gt;size; ++i)</span><br><span>@@ -793,7 +793,7 @@</span><br><=
span> </span><br><span> /* delete a buffer previously activated by reliable=
_mark_active() */</span><br><span> void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-reliable_mark_deleted(struct reliable *rel, struct buffer=
 *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_mark=
_deleted(struct reliable *rel, const struct buffer *buf)</span><br><span> {=
</span><br><span>     for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br=
><span>     {</span><br><span>diff --git a/src/openvpn/reliable=2Eh b/src/o=
penvpn/reliable=2Eh</span><br><span>index a5ed75c=2E=2E8d9e2e3 100644</span=
><br><span>--- a/src/openvpn/reliable=2Eh</span><br><span>+++ b/src/openvpn=
/reliable=2Eh</span><br><span>@@ -173,7 +173,7 @@</span><br><span>  * @li F=
alse, if there are packet IDs to be acknowledged=2E</span><br><span>  */</s=
pan><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-reliable_ack_empty(struct reliable_ack *ack)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+reliable_ack_empty(const struct reliab=
le_ack *ack)</span><br><span> {</span><br><span>     return !ack-&gt;len;</=
span><br><span> }</span><br><span>@@ -186,7 +186,7 @@</span><br><span>  * @=
returns the number of outstanding acks</span><br><span>  */</span><br><span=
> static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-re=
liable_ack_outstanding(struct reliable_ack *ack)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+reliable_ack_outstanding(const struct reliable=
_ack *ack)</span><br><span> {</span><br><span>     return ack-&gt;len;</spa=
n><br><span> }</span><br><span>@@ -336,7 +336,7 @@</span><br><span>  * @par=
am pid The packet&#39;s packet ID=2E</span><br><span>  * @param opcode The =
packet&#39;s opcode=2E</span><br><span>  */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void reliable_mark_active_incoming(struct reliable *r=
el, struct buffer *buf, packet_id_type pid,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void reliable_mark_active_incoming(struct reliable =
*rel, const struct buffer *buf, packet_id_type pid,</span><br><span>       =
                             int opcode);</span><br><span> </span><br><span=
> /**</span><br><span>@@ -389,7 +389,7 @@</span><br><span>  * @param rel Th=
e reliable structure associated with the given buffer=2E</span><br><span>  =
* @param buf The buffer of the reliable entry which is to be removed=2E</sp=
an><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void=
 reliable_mark_deleted(struct reliable *rel, struct buffer *buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void reliable_mark_deleted(st=
ruct reliable *rel, const struct buffer *buf);</span><br><span> </span><br>=
<span> /** @} name Functions for extracting incoming packets */</span><br><=
span> </span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/rou=
te=2Ec</span><br><span>index 1d3ea86=2E=2E590d844 100644</span><br><span>--=
- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span=
><br><span>@@ -898,8 +898,9 @@</span><br><span> }</span><br><span> </span><=
br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
add_bypass_routes(struct route_bypass *rb, in_addr_t gateway, const struct =
tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
        unsigned int flags, const struct route_gateway_info *rgi,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+add_bypass_routes(const struc=
t route_bypass *rb, in_addr_t gateway,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                  const struct tuntap *tt, unsigned int =
flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
     const struct route_gateway_info *rgi,</span><br><span>                =
   const struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span> {</sp=
an><br><span>     int ret =3D true;</span><br><span>@@ -916,8 +917,9 @@</sp=
an><br><span> }</span><br><span> </span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-del_bypass_routes(struct route_byp=
ass *rb, in_addr_t gateway, const struct tuntap *tt,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                  unsigned int flags, const=
 struct route_gateway_info *rgi,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+del_bypass_routes(const struct route_bypass *rb, in_addr_t gat=
eway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
    const struct tuntap *tt, unsigned int flags,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                  const struct route_gateway_i=
nfo *rgi,</span><br><span>                   const struct env_set *es, open=
vpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>     int i;</span><b=
r><span>@@ -3942,7 +3944,7 @@</span><br><span> #else  /* if defined(_WIN32)=
 */</span><br><span> </span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-get_bypass_addresses(struct route_bypass *rb, =
const unsigned int flags) /* PLATFORM-SPECIFIC */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+get_bypass_addresses(struct route_bypass *rb,=
 const unsigned int flags)</span><br><span> {</span><br><span> }</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/schedule=2Ec b/src/openvpn=
/schedule=2Ec</span><br><span>index 6d9bb62=2E=2Ec29009e 100644</span><br><=
span>--- a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src/openvpn/sched=
ule=2Ec</span><br><span>@@ -501,7 +501,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-schedule_debug(struct schedule *s, int *count, struct timeval *least)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_debug(const=
 struct schedule *s, int *count, struct timeval *least)</span><br><span> {<=
/span><br><span>     struct timeval min;</span><br><span>     struct timeva=
l max;</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/so=
cket=2Ec</span><br><span>index 0382aea=2E=2E5474e94 100644</span><br><span>=
--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</=
span><br><span>@@ -647,7 +647,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-bind_local(struct link_socket *sock, const sa_family_t ai_family)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+bind_local(const struct l=
ink_socket *sock, const sa_family_t ai_family)</span><br><span> {</span><br=
><span>     /* bind to local address/port */</span><br><span>     if (sock-=
&gt;bind_local)</span><br><span>@@ -914,8 +914,8 @@</span><br><span> }</spa=
n><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-socket_bind(socket_descriptor_t sd, struct addrinfo *local, i=
nt ai_family, const char *prefix,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            bool ipv6only)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+socket_bind(socket_descriptor_t sd, const struct addrinf=
o *local, int ai_family,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            const char *prefix, bool ipv6only)</span><br><span> {</spa=
n><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><=
br><span>@@ -1123,8 +1123,8 @@</span><br><span>  * such as TCP=2E</span><br=
><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static void stream_buf_init(struct stream_buf *sb, struct buffer *b=
uf, const unsigned int sockflags,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                            const int proto);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void stream_buf_init(struct st=
ream_buf *sb, const struct buffer *buf,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                            const unsigned int sockflag=
s, const int proto);</span><br><span> </span><br><span> static void stream_=
buf_close(struct stream_buf *sb);</span><br><span> </span><br><span>@@ -148=
1,7 +1481,7 @@</span><br><span> }</span><br><span> </span><br><span> static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-phase2_set_socke=
t_flags(struct link_socket *sock)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+phase2_set_socket_flags(const struct link_socket *sock)</span=
><br><span> {</span><br><span>     /* set misc socket parameters */</span><=
br><span>     socket_set_flags(sock-&gt;sd, sock-&gt;sockflags);</span><br>=
<span>@@ -2073,7 +2073,7 @@</span><br><span> }</span><br><span> </span><br>=
<span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-str=
eam_buf_init(struct stream_buf *sb, struct buffer *buf, const unsigned int =
sockflags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stream_bu=
f_init(struct stream_buf *sb, const struct buffer *buf, const unsigned int =
sockflags,</span><br><span>                 const int proto)</span><br><spa=
n> {</span><br><span>     sb-&gt;buf_init =3D *buf;</span><br><span>@@ -233=
7,7 +2337,7 @@</span><br><span> #endif</span><br><span> </span><br><span> s=
tatic socklen_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_s=
ocket_read_udp_posix_recvmsg(struct link_socket *sock, struct buffer *buf,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_read_udp=
_posix_recvmsg(const struct link_socket *sock, struct buffer *buf,</span><b=
r><span>                                    struct link_socket_actual *from=
)</span><br><span> {</span><br><span>     struct iovec iov;</span><br><span=
>@@ -2405,7 +2405,7 @@</span><br><span> #endif /* if ENABLE_IP_PKTINFO */</=
span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-link_socket_read_udp_posix(struct link_socket *sock, struct=
 buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_s=
ocket_read_udp_posix(const struct link_socket *sock, struct buffer *buf,</s=
pan><br><span>                            struct link_socket_actual *from)<=
/span><br><span> {</span><br><span>     socklen_t fromlen =3D sizeof(from-&=
gt;dest=2Eaddr);</span><br><span>@@ -2462,7 +2462,7 @@</span><br><span> #if=
 ENABLE_IP_PKTINFO</span><br><span> </span><br><span> ssize_t</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_udp_posix_sendmsg=
(struct link_socket *sock, struct buffer *buf,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+link_socket_write_udp_posix_sendmsg(const struct=
 link_socket *sock, const struct buffer *buf,</span><br><span>             =
                        struct link_socket_actual *to)</span><br><span> {</=
span><br><span>     struct iovec iov;</span><br><span>@@ -2656,7 +2656,7 @@=
</span><br><span> }</span><br><span> </span><br><span> int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-socket_send_queue(struct link_socket *=
sock, struct buffer *buf, const struct link_socket_actual *to)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+socket_send_queue(struct link_so=
cket *sock, const struct buffer *buf, const struct link_socket_actual *to)<=
/span><br><span> {</span><br><span>     if (sock-&gt;writes=2Eiostate =3D=
=3D IOSTATE_INITIAL)</span><br><span>     {</span><br><span>@@ -2756,8 +275=
6,8 @@</span><br><span>     return sock-&gt;writes=2Eiostate;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_sockaddr_f=
rom_overlapped(struct overlapped_io *io, struct sockaddr *dst, int overlapp=
ed_ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_sockaddr_from_o=
verlapped(const struct overlapped_io *io, struct sockaddr *dst, int overlap=
ped_ret)</span><br><span> {</span><br><span>     if (overlapped_ret &gt;=3D=
 0 &amp;&amp; io-&gt;addr_defined)</span><br><span>     {</span><br><span>d=
iff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span=
>index 71a3595=2E=2E6771ec5 100644</span><br><span>--- a/src/openvpn/socket=
=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -267,7=
 +267,7 @@</span><br><span> </span><br><span> int socket_recv_queue(struct =
link_socket *sock, int maxsize);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-int socket_send_queue(struct link_socket *sock=
, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int socket_send_queue(struct link_socket *sock, const struct buffer *buf,=
</span><br><span>                       const struct link_socket_actual *to=
);</span><br><span> </span><br><span> typedef struct</span><br><span>@@ -34=
7,8 +347,8 @@</span><br><span> </span><br><span> struct link_socket *link_s=
ocket_new(void);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void socket_bind(socket_descriptor_t sd, struct addrinfo *loca=
l, int af_family, const char *prefix,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                 bool ipv6only);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void socket_bind(socket_descriptor_t sd, const=
 struct addrinfo *local, int af_family,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                 const char *prefix, bool ipv6only);</s=
pan><br><span> </span><br><span> int openvpn_connect(socket_descriptor_t sd=
, const struct sockaddr *remote, int connect_timeout,</span><br><span>     =
                volatile int *signal_received);</span><br><span>@@ -484,7 +=
484,7 @@</span><br><span> }</span><br><span> </span><br><span> static inlin=
e bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_ver=
ify_incoming_addr(struct buffer *buf, const struct link_socket_info *info,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_verify_i=
ncoming_addr(const struct buffer *buf, const struct link_socket_info *info,=
</span><br><span>                                  const struct link_socket=
_actual *from_addr)</span><br><span> {</span><br><span>     if (buf-&gt;len=
 &gt; 0)</span><br><span>@@ -608,7 +608,7 @@</span><br><span> </span><br><s=
pan> #else  /* ifdef _WIN32 */</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-int link_socket_read_udp_posix(struct link_socke=
t *sock, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+int link_socket_read_udp_posix(const struct link_socket *sock, str=
uct buffer *buf,</span><br><span>                                struct lin=
k_socket_actual *from);</span><br><span> </span><br><span> #endif /* ifdef =
_WIN32 */</span><br><span>@@ -694,12 +694,12 @@</span><br><span> </span><br=
><span> #else /* ifdef _WIN32 */</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-ssize_t link_socket_write_udp_posix_sendmsg(st=
ruct link_socket *sock, struct buffer *buf,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ssize_t link_socket_write_udp_posix_sendmsg(const s=
truct link_socket *sock, const struct buffer *buf,</span><br><span>        =
                                     struct link_socket_actual *to);</span>=
<br><span> </span><br><span> </span><br><span> static inline ssize_t</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_udp_posix(=
struct link_socket *sock, struct buffer *buf,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+link_socket_write_udp_posix(const struct link_soc=
ket *sock, const struct buffer *buf,</span><br><span>                      =
       struct link_socket_actual *to)</span><br><span> {</span><br><span> #=
if ENABLE_IP_PKTINFO</span><br><span>@@ -715,7 +715,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static inline ssize_t</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-link_socket_write_tcp_posix(struct link=
_socket *sock, struct buffer *buf)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+link_socket_write_tcp_posix(const struct link_socket *sock, =
const struct buffer *buf)</span><br><span> {</span><br><span>     return se=
nd(sock-&gt;sd, BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);</span><br><span> }</s=
pan><br><span>@@ -773,7 +773,7 @@</span><br><span>  * from tunnel packet=2E=
</span><br><span>  */</span><br><span> static inline void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-link_socket_set_tos(struct link_socket =
*sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_s=
et_tos(const struct link_socket *sock)</span><br><span> {</span><br><span> =
    if (sock &amp;&amp; sock-&gt;ptos_defined)</span><br><span>     {</span=
><br><span>@@ -819,6 +819,8 @@</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* c=
ppcheck-suppress constParameterPointer</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * sock is modified on Windows via &amp;sock-&gt;listen_=
handle */</span><br><span> static inline void</span><br><span> socket_reset=
_listen_persistent(struct link_socket *sock)</span><br><span> {</span><br><=
span>diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh=
</span><br><span>index 13f5962=2E=2Eadd08ba 100644</span><br><span>--- a/sr=
c/openvpn/socket_util=2Eh</span><br><span>+++ b/src/openvpn/socket_util=2Eh=
</span><br><span>@@ -439,7 +439,7 @@</span><br><span> </span><br><span> </s=
pan><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-addrlist_match_proto(const struct openvpn_sockaddr *a1, struct =
addrinfo *addr_list, const int proto)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+addrlist_match_proto(const struct openvpn_sockaddr *a1, c=
onst struct addrinfo *addr_list, const int proto)</span><br><span> {</span>=
<br><span>     return link_socket_proto_connection_oriented(proto) ? addrli=
st_match(a1, addr_list)</span><br><span>                                   =
                      : addrlist_port_match(a1, addr_list);</span><br><span=
>diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span=
>index 19f3d54=2E=2E77ca863 100644</span><br><span>--- a/src/openvpn/socks=
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
-git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 7f3b=
4dc=2E=2E262522b 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br=
><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1159,7 +1159,7 @@</spa=
n><br><span> }</span><br><span> </span><br><span> struct tls_multi *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-tls_multi_init(struct tls_op=
tions *tls_options)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
tls_multi_init(const struct tls_options *tls_options)</span><br><span> {</s=
pan><br><span>     struct tls_multi *ret;</span><br><span> </span><br><span=
>@@ -1188,7 +1188,7 @@</span><br><span>  */</span><br><span> </span><br><sp=
an> struct tls_auth_standalone *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-tls_auth_standalone_init(struct tls_options *tls_options, struct=
 gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_a=
uth_standalone_init(const struct tls_options *tls_options, struct gc_arena =
*gc)</span><br><span> {</span><br><span>     struct tls_auth_standalone *ta=
s;</span><br><span> </span><br><span>@@ -1336,7 +1336,7 @@</span><br><span>=
 </span><br><span> static void</span><br><span> init_epoch_keys(struct key_=
state *ks, struct tls_multi *multi, const struct key_type *key_type,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                bool server,=
 struct key2 *key2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                bool server, const struct key2 *key2)</span><br><span> {</s=
pan><br><span>     /* For now we hardcode this to be 16 for the software ba=
sed data channel</span><br><span>      * DCO based implementations/HW imple=
mentation might adjust this number</span><br><span>@@ -1375,7 +1375,7 @@</s=
pan><br><span> </span><br><span> static void</span><br><span> init_key_cont=
exts(struct key_state *ks, struct tls_multi *multi, const struct key_type *=
key_type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
      bool server, struct key2 *key2, bool dco_enabled)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                  bool server, const st=
ruct key2 *key2, bool dco_enabled)</span><br><span> {</span><br><span>     =
struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_options=2Ekey_ctx_bi;</span><=
br><span> </span><br><span>@@ -1573,8 +1573,9 @@</span><br><span> </span><b=
r><span> bool</span><br><span> tls_session_update_crypto_params_do_work(str=
uct tls_multi *multi, struct tls_session *session,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                         struc=
t options *options, struct frame *frame,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                         struct frame *f=
rame_fragment, struct link_socket_info *lsi,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                         const str=
uct options *options, struct frame *frame,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                         struct fram=
e *frame_fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                        const struct link_socket_info *lsi,=
</span><br><span>                                          dco_context_t *d=
co)</span><br><span> {</span><br><span>     if (session-&gt;key[KS_PRIMARY]=
=2Ecrypto_options=2Ekey_ctx_bi=2Einitialized)</span><br><span>@@ -1643,7 +1=
644,7 @@</span><br><span> bool</span><br><span> tls_session_update_crypto_p=
arams(struct tls_multi *multi, struct tls_session *session,</span><br><span=
>                                  struct options *options, struct frame *f=
rame,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                 struct frame *frame_fragment, struct link_socket_info *lsi=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
               struct frame *frame_fragment, const struct link_socket_info =
*lsi,</span><br><span>                                  dco_context_t *dco)=
</span><br><span> {</span><br><span>     if (!check_session_cipher(session,=
 options))</span><br><span>@@ -2495,8 +2496,8 @@</span><br><span> }</span><=
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
span>@@ -4011,7 +4012,7 @@</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_post_en=
crypt(struct tls_multi *multi, struct buffer *buf)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+tls_post_encrypt(struct tls_multi *multi, co=
nst struct buffer *buf)</span><br><span> {</span><br><span>     struct key_=
state *ks =3D multi-&gt;save_ks;</span><br><span>     multi-&gt;save_ks =3D=
 NULL;</span><br><span>@@ -4142,7 +4143,7 @@</span><br><span>  * into a gar=
bage collectable string which is returned=2E</span><br><span>  */</span><br=
><span> const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-p=
rotocol_dump(struct buffer *buffer, unsigned int flags, struct gc_arena *gc=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+protocol_dump(cons=
t struct buffer *buffer, unsigned int flags, struct gc_arena *gc)</span><br=
><span> {</span><br><span>     struct buffer out =3D alloc_buf_gc(256, gc);=
</span><br><span>     struct buffer buf =3D *buffer;</span><br><span>diff -=
-git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 5822=
336=2E=2E3370321 100644</span><br><span>--- a/src/openvpn/ssl=2Eh</span><br=
><span>+++ b/src/openvpn/ssl=2Eh</span><br><span>@@ -166,7 +166,7 @@</span>=
<br><span>  *</span><br><span>  * @return A newly allocated and initialized=
 \c tls_multi structure=2E</span><br><span>  */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-struct tls_multi *tls_multi_init(struct tls_optio=
ns *tls_options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
ruct tls_multi *tls_multi_init(const struct tls_options *tls_options);</spa=
n><br><span> </span><br><span> /**</span><br><span>  * Finalize initializat=
ion of a \c tls_multi structure=2E</span><br><span>@@ -187,7 +187,7 @@</spa=
n><br><span> /*</span><br><span>  * Initialize a standalone tls-auth verifi=
cation object=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-struct tls_auth_standalone *tls_auth_standalone_init(struct=
 tls_options *tls_options,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+struct tls_auth_standalone *tls_auth_standalone_init(const struct tl=
s_options *tls_options,</span><br><span>                                   =
                   struct gc_arena *gc);</span><br><span> </span><br><span>=
 /**</span><br><span>@@ -371,7 +371,7 @@</span><br><span>  * @param multi -=
 The TLS state for this packet&#39;s destination VPN tunnel=2E</span><br><s=
pan>  * @param buf - The buffer containing the outgoing packet=2E</span><br=
><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tls_p=
ost_encrypt(struct tls_multi *multi, struct buffer *buf);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void tls_post_encrypt(struct tls_mult=
i *multi, const struct buffer *buf);</span><br><span> </span><br><span> /**=
 @} name Functions for managing security parameter state for data channel p=
ackets */</span><br><span> </span><br><span>@@ -461,7 +461,8 @@</span><br><=
span>  */</span><br><span> bool tls_session_update_crypto_params(struct tls=
_multi *multi, struct tls_session *session,</span><br><span>               =
                        struct options *options, struct frame *frame,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
           struct frame *frame_fragment, struct link_socket_info *lsi,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
              struct frame *frame_fragment,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                      const struct =
link_socket_info *lsi,</span><br><span>                                    =
   dco_context_t *dco);</span><br><span> </span><br><span> /*</span><br><sp=
an>@@ -525,7 +526,7 @@</span><br><span> #define PD_VERBOSE                 =
(1 &lt;&lt; 10)</span><br><span> #define PD_TLS_CRYPT               (1 &lt;=
&lt; 11)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-const char *protocol_dump(struct buffer *buffer, unsigned int flags, s=
truct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+const char *protocol_dump(const struct buffer *buffer, unsigned int flags,=
 struct gc_arena *gc);</span><br><span> </span><br><span> /*</span><br><spa=
n>  * debugging code</span><br><span>@@ -573,7 +574,7 @@</span><br><span> /=
* Special method to skip the three way handshake RESET stages=2E This is</s=
pan><br><span>  * used by the HMAC code when seeing a packet that matches t=
he previous</span><br><span>  * HMAC based stateless server state */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-bool session_skip_to_pre_sta=
rt(struct tls_session *session, struct tls_pre_decrypt_state *state,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
   struct link_socket_actual *from);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bool session_skip_to_pre_start(struct tls_session *session=
, const struct tls_pre_decrypt_state *state,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                               const struct link_s=
ocket_actual *from);</span><br><span> </span><br><span> #endif /* ifndef OP=
ENVPN_SSL_H */</span><br><span>diff --git a/src/openvpn/ssl_backend=2Eh b/s=
rc/openvpn/ssl_backend=2Eh</span><br><span>index 816fb9c=2E=2Eed395e7 10064=
4</span><br><span>--- a/src/openvpn/ssl_backend=2Eh</span><br><span>+++ b/s=
rc/openvpn/ssl_backend=2Eh</span><br><span>@@ -144,7 +144,7 @@</span><br><s=
pan>  *</span><br><span>  * @return      true if the context is initialised=
, false if not=2E</span><br><span>  */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-bool tls_ctx_initialised(struct tls_root_ctx *ctx);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool tls_ctx_initialised(c=
onst struct tls_root_ctx *ctx);</span><br><span> </span><br><span> /**</spa=
n><br><span>  * Set any library specific options=2E</span><br><span>@@ -177=
,7 +177,7 @@</span><br><span>  * @param ciphers       String containing : d=
elimited cipher names, or NULL to use</span><br><span>  *                  =
                    sane defaults=2E</span><br><span>  */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void tls_ctx_restrict_ciphers_tls13(str=
uct tls_root_ctx *ctx, const char *ciphers);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void tls_ctx_restrict_ciphers_tls13(const struct t=
ls_root_ctx *ctx, const char *ciphers);</span><br><span> </span><br><span> =
/**</span><br><span>  * Set the TLS certificate profile=2E  The profile def=
ines which crypto</span><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec =
b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 9d408c0=2E=2E7893be0 10=
0644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ =
b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -161,7 +161,7 @@</span><br=
><span> }</span><br><span> </span><br><span> bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-tls_ctx_initialised(struct tls_root_ctx *ctx)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_initialised(c=
onst struct tls_root_ctx *ctx)</span><br><span> {</span><br><span>     /* e=
ither this should be NULL or should be non-null and then have a</span><br><=
span>      * valid TLS ctx inside as well */</span><br><span>@@ -284,7 +284=
,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_restrict_ciphers_tls13(s=
truct tls_root_ctx *ctx, const char *ciphers)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+tls_ctx_restrict_ciphers_tls13(const struct tls_r=
oot_ctx *ctx, const char *ciphers)</span><br><span> {</span><br><span>     =
if (ciphers =3D=3D NULL)</span><br><span>     {</span><br><span>diff --git =
a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span=
>index 306f85cd=2E=2E706d78d 100644</span><br><span>--- a/src/openvpn/ssl_o=
penssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><spa=
n>@@ -147,7 +147,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_initiali=
sed(struct tls_root_ctx *ctx)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+tls_ctx_initialised(const struct tls_root_ctx *ctx)</span><br><sp=
an> {</span><br><span>     /* either this should be NULL or should be non-n=
ull and then have a</span><br><span>      * valid TLS ctx inside as well */=
</span><br><span>@@ -509,7 +509,7 @@</span><br><span> #endif</span><br><spa=
n> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ci=
phers)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_restr=
ict_ciphers_tls13(const struct tls_root_ctx *ctx, const char *ciphers)</spa=
n><br><span> {</span><br><span>     if (ciphers =3D=3D NULL)</span><br><spa=
n>     {</span><br><span>@@ -1165,7 +1165,7 @@</span><br><span> }</span><br=
><span> </span><br><span> static void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-tls_ctx_load_cert_uri(struct tls_root_ctx *tls_ctx, const c=
har *uri)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_lo=
ad_cert_uri(const struct tls_root_ctx *tls_ctx, const char *uri)</span><br>=
<span> {</span><br><span> #if defined(HAVE_OPENSSL_STORE_API)</span><br><sp=
an>     X509 *x =3D NULL;</span><br><span>@@ -2078,7 +2078,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-bio_debug_data(const char *mode, BIO *bio,=
 const uint8_t *buf, int len, const char *desc)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bio_debug_data(const char *mode, const BIO *bio=
, const uint8_t *buf, int len, const char *desc)</span><br><span> {</span><=
br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     if (len=
 &gt; 0)</span><br><span>@@ -2092,7 +2092,7 @@</span><br><span> }</span><br=
><span> </span><br><span> static void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-bio_debug_oc(const char *mode, BIO *bio)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bio_debug_oc(const char *mode, const B=
IO *bio)</span><br><span> {</span><br><span>     open_biofp();</span><br><s=
pan>     fprintf(biofp, &quot;BIO %s time=3D%&quot; PRIi64 &quot; bio=3D&qu=
ot; ptr_format &quot;\n&quot;, mode, (int64_t)time(NULL),</span><br><span>d=
iff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><sp=
an>index 1805995=2E=2E6b53e7e 100644</span><br><span>--- a/src/openvpn/ssl_=
pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -5=
7,7 +57,7 @@</span><br><span>  *  @return         if the swap was successfu=
l (buf was large enough)</span><br><span>  */</span><br><span> static bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-swap_hmac(struct buffe=
r *buf, const struct crypto_options *co, bool incoming)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+swap_hmac(const struct buffer *buf, con=
st struct crypto_options *co, bool incoming)</span><br><span> {</span><br><=
span>     ASSERT(co);</span><br><span> </span><br><span>@@ -117,7 +117,7 @@=
</span><br><span>  */</span><br><span> static void</span><br><span> tls_wra=
p_control(struct tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                 struct s=
ession_id *session_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 const struct session_id *session_id)</span><br><span> {=
</span><br><span>     if (ctx-&gt;mode =3D=3D TLS_WRAP_AUTH || ctx-&gt;mode=
 =3D=3D TLS_WRAP_NONE)</span><br><span>     {</span><br><span>@@ -403,9 +40=
3,9 @@</span><br><span> </span><br><span> </span><br><span> struct buffer</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_reset_standalone(st=
ruct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                     struct session_id *=
own_sid, struct session_id *remote_sid, uint8_t header,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                     bool request_resend_=
wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_reset_stand=
alone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                     con=
st struct session_id *own_sid, const struct session_id *remote_sid,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     uint8_=
t header, bool request_resend_wkc)</span><br><span> {</span><br><span>     =
/* Copy buffer here to point at the same data but allow tls_wrap_control</s=
pan><br><span>      * to potentially change buf to point to another buffer =
without</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/=
ssl_pkt=2Eh</span><br><span>index ac9d4be=2E=2Effd34f4 100644</span><br><sp=
an>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=
=2Eh</span><br><span>@@ -220,8 +220,9 @@</span><br><span>  * from the tls p=
re decrypt state=2E</span><br><span>  *</span><br><span>  */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-struct buffer tls_reset_standalone(s=
truct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                   stru=
ct session_id *own_sid, struct session_id *remote_sid,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+struct buffer tls_reset_standalone(struc=
t tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
const struct session_id *own_sid,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                   const struct session_id *r=
emote_sid,</span><br><span>                                    uint8_t head=
er, bool request_resend_wkc);</span><br><span> </span><br><span> </span><br=
><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec=
</span><br><span>index e5b55a1=2E=2E0298106 100644</span><br><span>--- a/sr=
c/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</=
span><br><span>@@ -1137,7 +1137,7 @@</span><br><span>  * cache=2E</span><br=
><span>  */</span><br><span> static bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-tls_authentication_status_use_cache(struct tls_multi *mu=
lti)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_authenticat=
ion_status_use_cache(const struct tls_multi *multi)</span><br><span> {</spa=
n><br><span>     unsigned int idx =3D min_uint(multi-&gt;tas_cache_num_upda=
tes, SIZE(cache_intervals) - 1);</span><br><span>     time_t latency =3D ca=
che_intervals[idx];</span><br><span>@@ -1281,7 +1281,7 @@</span><br><span> =
 * Check if the script/plugin left a message in the auth failed message</sp=
an><br><span>  * file and relay it to the user */</span><br><span> static v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_for_client_r=
eason(struct tls_multi *multi, struct auth_deferred_status *status)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+check_for_client_reason(str=
uct tls_multi *multi, const struct auth_deferred_status *status)</span><br>=
<span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><s=
pan>     const char *msg =3D key_state_check_auth_failed_message_file(statu=
s, &amp;gc);</span><br><span>@@ -1550,7 +1550,7 @@</span><br><span> #endif =
/* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> static boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set_verify_user_pass=
_env(struct user_pass *up, struct tls_multi *multi, struct tls_session *ses=
sion)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set_verify_use=
r_pass_env(const struct user_pass *up, struct tls_multi *multi, struct tls_=
session *session)</span><br><span> {</span><br><span>     /* Is username de=
fined? */</span><br><span>     if ((session-&gt;opt-&gt;ssl_flags &amp; SSL=
F_AUTH_USER_PASS_OPTIONAL) || strlen(up-&gt;username))</span><br><span>@@ -=
1578,7 +1578,7 @@</span><br><span> }</span><br><span> </span><br><span> boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssl_verify_username_=
length(struct tls_session *session, const char *username)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ssl_verify_username_length(const stru=
ct tls_session *session, const char *username)</span><br><span> {</span><br=
><span>     if ((session-&gt;opt-&gt;ssl_flags &amp; SSLF_USERNAME_AS_COMMO=
N_NAME)</span><br><span>         &amp;&amp; strlen(username) &gt; TLS_USERN=
AME_LEN)</span><br><span>diff --git a/src/openvpn/ssl_verify=2Eh b/src/open=
vpn/ssl_verify=2Eh</span><br><span>index 3176d76=2E=2Ee77bc4a 100644</span>=
<br><span>--- a/src/openvpn/ssl_verify=2Eh</span><br><span>+++ b/src/openvp=
n/ssl_verify=2Eh</span><br><span>@@ -202,7 +202,7 @@</span><br><span>  * @r=
eturn              true if name is under limit or username-as-common-name</=
span><br><span>  *                      is not active</span><br><span>  */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool ssl_verify_userna=
me_length(struct tls_session *session, const char *username);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bool ssl_verify_username_length(c=
onst struct tls_session *session, const char *username);</span><br><span> <=
/span><br><span> /**</span><br><span>  * Runs the --client-crresponse scrip=
t if one is defined=2E</span><br><span>@@ -275,7 +275,7 @@</span><br><span>=
 void auth_set_client_reason(struct tls_multi *multi, const char *client_re=
ason);</span><br><span> </span><br><span> static inline const char *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-tls_client_reason(struct tls=
_multi *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_c=
lient_reason(const struct tls_multi *multi)</span><br><span> {</span><br><s=
pan>     return multi-&gt;client_reason;</span><br><span> }</span><br><span=
>diff --git a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec</span><br><sp=
an>index c7d375b=2E=2Ecfbc38d 100644</span><br><span>--- a/src/openvpn/stat=
us=2Ec</span><br><span>+++ b/src/openvpn/status=2Ec</span><br><span>@@ -135=
,7 +135,7 @@</span><br><span> }</span><br><span> </span><br><span> void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-status_reset(struct statu=
s_output *so)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+status=
_reset(const struct status_output *so)</span><br><span> {</span><br><span> =
    if (so &amp;&amp; so-&gt;fd &gt;=3D 0)</span><br><span>     {</span><br=
><span>diff --git a/src/openvpn/status=2Eh b/src/openvpn/status=2Eh</span><=
br><span>index 7953a4e=2E=2E4c01d75 100644</span><br><span>--- a/src/openvp=
n/status=2Eh</span><br><span>+++ b/src/openvpn/status=2Eh</span><br><span>@=
@ -69,7 +69,7 @@</span><br><span> </span><br><span> bool status_trigger(str=
uct status_output *so);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-void status_reset(struct status_output *so);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void status_reset(const struct=
 status_output *so);</span><br><span> </span><br><span> void status_flush(s=
truct status_output *so);</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index bc262cd=2E=2E=
7e1999d 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>++=
+ b/src/openvpn/tun=2Ec</span><br><span>@@ -835,7 +835,7 @@</span><br><span=
>          const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 I=
Pv6 */</span><br><span>          int ifconfig_ipv6_netbits_parm,</span><br>=
<span>          const char *ifconfig_ipv6_remote_parm,    /* --ifconfig par=
m 2 IPv6 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         s=
truct addrinfo *local_public, struct addrinfo *remote_public, const bool st=
rict_warn,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
const struct addrinfo *local_public, const struct addrinfo *remote_public, =
const bool strict_warn,</span><br><span>          struct env_set *es, openv=
pn_net_ctx_t *ctx, struct tuntap *tt)</span><br><span> {</span><br><span>  =
   if (!tt)</span><br><span>@@ -978,7 +978,7 @@</span><br><span>  * -&gt; h=
elper function to simplify code below</span><br><span>  */</span><br><span>=
 static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_route=
_connected_v6_net(struct tuntap *tt, const struct env_set *es)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+add_route_connected_v6_net(const=
 struct tuntap *tt, const struct env_set *es)</span><br><span> {</span><br>=
<span>     struct route_ipv6 r6;</span><br><span> </span><br><span>@@ -1020=
,7 +1020,7 @@</span><br><span>  */</span><br><span> </span><br><span> in_ad=
dr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-create_arbitrary_=
remote(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+create_arbitrary_remote(const struct tuntap *tt)</span><br><span> {</=
span><br><span>     in_addr_t remote;</span><br><span> </span><br><span>@@ =
-1592,7 +1592,7 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfi=
g_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv4(const struct tuntap *tt, o=
penvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #if defined(TARG=
ET_LINUX)</span><br><span>     int netbits =3D netmask_to_netbits2(tt-&gt;r=
emote_netmask);</span><br><span>@@ -1627,7 +1627,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ct=
x_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+undo_ifcon=
fig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> =
{</span><br><span> #if defined(TARGET_LINUX)</span><br><span>     if (net_a=
ddr_v6_del(ctx, tt-&gt;actual_name, &amp;tt-&gt;local_ipv6, tt-&gt;netbits_=
ipv6) &lt; 0)</span><br><span>@@ -1652,7 +1652,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig(const stru=
ct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> =
    if (tt-&gt;backend_driver !=3D DRIVER_NULL &amp;&amp; tt-&gt;backend_dr=
iver !=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -1729,7 =
+1729,7 @@</span><br><span> #endif</span><br><span> </span><br><span> stati=
c ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun_he=
ader(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+write_tun_header(const struct tuntap *tt, const =
uint8_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;t=
ype =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -1746,9 =
+1746,11 @@</span><br><span>             type =3D htonl(AF_INET);</span><br=
><span>         }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* argument to writev is a pointer to const but we =
still need to drop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * the const from buf pointer here */</span><br><span>         iv[0]=
=2Eiov_base =3D &amp;type;</span><br><span>         iv[0]=2Eiov_len =3D siz=
eof(type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[=
1]=2Eiov_base =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        iv[1]=2Eiov_base =3D (void *)buf;</span><br><span>         iv[1]=
=2Eiov_len =3D len;</span><br><span> </span><br><span>         return heade=
r_modify_read_write_return(writev(tt-&gt;fd, iv, 2));</span><br><span>@@ -1=
760,7 +1762,7 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun_he=
ader(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+read_tun_header(const struct tuntap *tt, uint8_t=
 *buf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;type =3D=
=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -1786,13 +1788,=
13 @@</span><br><span>  */</span><br><span> #if !defined(TARGET_DARWIN)</sp=
an><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const =
uint8_t *buf, int len)</span><br><span> {</span><br><span>     return write=
_tun_header(tt, buf, len);</span><br><span> }</span><br><span> </span><br><=
span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun=
(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int =
len)</span><br><span> {</span><br><span>     return read_tun_header(tt, buf=
, len);</span><br><span> }</span><br><span>@@ -1808,7 +1810,7 @@</span><br>=
<span> </span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D)</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-tun_dco_enabled(struct tuntap *tt)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+tun_dco_enabled(const struct tuntap *tt)</span><br=
><span> {</span><br><span>     return tt-&gt;backend_driver =3D=3D DRIVER_D=
CO;</span><br><span> }</span><br><span>@@ -2055,13 +2057,13 @@</span><br><s=
pan> }</span><br><span> </span><br><span> ssize_t</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int =
len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const=
 struct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span><=
br><span>     return write(tt-&gt;fd, buf, len);</span><br><span> }</span><=
br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *=
tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     return r=
ead(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span>@@ -2260,13 +2=
262,13 @@</span><br><span> }</span><br><span> </span><br><span> ssize_t</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *=
tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)</spa=
n><br><span> {</span><br><span>     return write(tt-&gt;fd, buf, len);</spa=
n><br><span> }</span><br><span> </span><br><span> ssize_t</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *bu=
f, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun=
(const struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><=
br><span>     return read(tt-&gt;fd, buf, len);</span><br><span> }</span><b=
r><span>@@ -2596,7 +2598,7 @@</span><br><span> }</span><br><span> </span><b=
r><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write=
_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t=
 *buf, int len)</span><br><span> {</span><br><span>     struct strbuf sbuf;=
</span><br><span>     sbuf=2Elen =3D len;</span><br><span>@@ -2605,7 +2607,=
7 @@</span><br><span> }</span><br><span> </span><br><span> ssize_t</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, ui=
nt8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</span><br><span> =
{</span><br><span>     struct strbuf sbuf;</span><br><span>     int f =3D 0=
;</span><br><span>@@ -3103,7 +3105,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, con=
st uint8_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-&g=
t;backend_driver =3D=3D DRIVER_UTUN)</span><br><span>     {</span><br><span=
>@@ -3116,7 +3118,7 @@</span><br><span> }</span><br><span> </span><br><span=
> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(str=
uct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)=
</span><br><span> {</span><br><span>     if (tt-&gt;backend_driver =3D=3D D=
RIVER_UTUN)</span><br><span>     {</span><br><span>@@ -3320,7 +3322,7 @@</s=
pan><br><span> }</span><br><span> </span><br><span> int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-tun_write_queue(struct tuntap *tt, struct=
 buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_wr=
ite_queue(struct tuntap *tt, const struct buffer *buf)</span><br><span> {</=
span><br><span>     if (tt-&gt;writes=2Eiostate =3D=3D IOSTATE_INITIAL)</sp=
an><br><span>     {</span><br><span>@@ -3375,7 +3377,7 @@</span><br><span> =
}</span><br><span> </span><br><span> int</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-tun_write_win32(struct tuntap *tt, struct buffer *buf)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_write_win32(struc=
t tuntap *tt, const struct buffer *buf)</span><br><span> {</span><br><span>=
     int err =3D 0;</span><br><span>     int status =3D 0;</span><br><span>=
@@ -5383,7 +5385,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fork_register_dn=
s_action(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+fork_register_dns_action(const struct tuntap *tt)</span><br><span> =
{</span><br><span>     if (tt &amp;&amp; tt-&gt;options=2Eregister_dns &amp=
;&amp; tt-&gt;options=2Emsg_channel)</span><br><span>     {</span><br><span=
>@@ -5473,7 +5475,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_g=
et_mtu(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+tuntap_get_mtu(const struct tuntap *tt)</span><br><span> {</span><br>=
<span>     ULONG mtu =3D 0;</span><br><span>     DWORD len;</span><br><span=
>@@ -6048,7 +6050,7 @@</span><br><span> }</span><br><span> </span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_show_debug(=
struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
un_show_debug(const struct tuntap *tt)</span><br><span> {</span><br><span> =
    if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)</span><br=
><span>     {</span><br><span>diff --git a/src/openvpn/tun=2Eh b/src/openvp=
n/tun=2Eh</span><br><span>index 6a7af85=2E=2E41b93cb 100644</span><br><span=
>--- a/src/openvpn/tun=2Eh</span><br><span>+++ b/src/openvpn/tun=2Eh</span>=
<br><span>@@ -272,9 +272,9 @@</span><br><span> </span><br><span> void close=
_tun_handle(struct tuntap *tt);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-ssize_t write_tun(struct tuntap *tt, uint8_t *b=
uf, int len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_=
t write_tun(const struct tuntap *tt, const uint8_t *buf, int len);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t read=
_tun(struct tuntap *tt, uint8_t *buf, int len);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ssize_t read_tun(const struct tuntap *tt, uint8=
_t *buf, int len);</span><br><span> </span><br><span> #ifdef ENABLE_FEATURE=
_TUN_PERSIST</span><br><span> void tuncfg(const char *dev, const char *dev_=
type, const char *dev_node, int persist_mode,</span><br><span>@@ -293,7 +29=
3,7 @@</span><br><span>                         const char *ifconfig_ipv6_l=
ocal_parm,     /* --ifconfig parm 1 / IPv6 */</span><br><span>             =
            int ifconfig_ipv6_netbits_parm,           /* --ifconfig parm 1 =
/ bits */</span><br><span>                         const char *ifconfig_ipv=
6_remote_parm,    /* --ifconfig parm 2 / IPv6 */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        struct addrinfo *local_p=
ublic, struct addrinfo *remote_public,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        const struct addrinfo *local_pub=
lic, const struct addrinfo *remote_public,</span><br><span>                =
         const bool strict_warn, struct env_set *es, openvpn_net_ctx_t *ctx=
,</span><br><span>                         struct tuntap *tt);</span><br><s=
pan> </span><br><span>@@ -320,7 +320,7 @@</span><br><span>  * @param tt    =
the tuntap interface context</span><br><span>  * @param ctx   the networkin=
g API opaque context</span><br><span>  */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-void undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t=
 *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void undo_if=
config(const struct tuntap *tt, openvpn_net_ctx_t *ctx);</span><br><span> <=
/span><br><span> bool is_dev_type(const char *dev, const char *dev_type, co=
nst char *match_type);</span><br><span> </span><br><span>@@ -351,7 +351,7 @=
@</span><br><span> #define IFCONFIG_DEFAULT IFCONFIG_AFTER_TUN_OPEN</span><=
br><span> </span><br><span> static inline int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-ifconfig_order(struct tuntap *tt)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ifconfig_order(const struct tuntap *t=
t)</span><br><span> {</span><br><span>     if (tt-&gt;backend_driver =3D=3D=
 DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -381,7 +381,7 @@<=
/span><br><span> #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN</span><br><spa=
n> </span><br><span> static inline int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-route_order(struct tuntap *tt)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+route_order(const struct tuntap *tt)</span><br>=
<span> {</span><br><span>     if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNI=
X)</span><br><span>     {</span><br><span>@@ -454,13 +454,13 @@</span><br><=
span> </span><br><span> const char *tap_win_getinfo(const struct tuntap *tt=
, struct gc_arena *gc);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-void tun_show_debug(struct tuntap *tt);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void tun_show_debug(const struct tu=
ntap *tt);</span><br><span> </span><br><span> bool dhcp_release_by_adapter_=
index(const DWORD adapter_index);</span><br><span> </span><br><span> bool d=
hcp_renew_by_adapter_index(const DWORD adapter_index);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void fork_register_dns_a=
ction(struct tuntap *tt);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void fork_register_dns_action(const struct tuntap *tt);</span><br><sp=
an> </span><br><span> void ipconfig_register_dns(const struct env_set *es);=
</span><br><span> </span><br><span>@@ -470,7 +470,7 @@</span><br><span> </s=
pan><br><span> int tun_read_queue(struct tuntap *tt, int maxsize);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int tun_writ=
e_queue(struct tuntap *tt, struct buffer *buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+int tun_write_queue(struct tuntap *tt, const st=
ruct buffer *buf);</span><br><span> </span><br><span> static inline bool</s=
pan><br><span> tuntap_stop(int status)</span><br><span>@@ -499,7 +499,7 @@<=
/span><br><span>     return false;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-int tun_write_win32(struc=
t tuntap *tt, struct buffer *buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int tun_write_win32(struct tuntap *tt, const struct buffer *=
buf);</span><br><span> </span><br><span> static inline bool</span><br><span=
> is_ip_packet_valid(const struct buffer *buf)</span><br><span>@@ -529,13 +=
529,13 @@</span><br><span> }</span><br><span> </span><br><span> static inli=
ne bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_=
win(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+tuntap_is_dco_win(const struct tuntap *tt)</span><br><span> {</span><br>=
<span>     return tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_DCO;</s=
pan><br><span> }</span><br><span> </span><br><span> static inline bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win_timeout(=
struct tuntap *tt, int status)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+tuntap_is_dco_win_timeout(const struct tuntap *tt, int status)</=
span><br><span> {</span><br><span>     return tuntap_is_dco_win(tt) &amp;&a=
mp; (status &lt; 0) &amp;&amp; (openvpn_errno() =3D=3D ERROR_NETNAME_DELETE=
D);</span><br><span> }</span><br><span>@@ -555,25 +555,25 @@</span><br><spa=
n> }</span><br><span> </span><br><span> static inline void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-tun_standby_init(struct tuntap *tt)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_standby_init(const=
 struct tuntap *tt)</span><br><span> {</span><br><span> }</span><br><span> =
</span><br><span> static inline bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-tun_standby(struct tuntap *tt)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+tun_standby(const struct tuntap *tt)</span><br><s=
pan> {</span><br><span>     return true;</span><br><span> }</span><br><span=
> </span><br><span> </span><br><span> static inline bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win(struct tuntap *tt)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win(const=
 struct tuntap *tt)</span><br><span> {</span><br><span>     return false;</=
span><br><span> }</span><br><span> </span><br><span> static inline bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win_timeout=
(struct tuntap *tt, int status)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+tuntap_is_dco_win_timeout(const struct tuntap *tt, int status)<=
/span><br><span> {</span><br><span>     return false;</span><br><span> }</s=
pan><br><span>diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afu=
nix=2Ec</span><br><span>index a67a472=2E=2Ee9223bc 100644</span><br><span>-=
-- a/src/openvpn/tun_afunix=2Ec</span><br><span>+++ b/src/openvpn/tun_afuni=
x=2Ec</span><br><span>@@ -48,7 +48,7 @@</span><br><span> </span><br><span> =
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, stru=
ct env_set *env)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun=
_afunix_exec_child(const char *dev_node, struct tuntap *tt, const struct en=
v_set *env)</span><br><span> {</span><br><span>     const char *msgprefix =
=3D &quot;ERROR: failure executing process for tun:&quot;;</span><br><span>=
     struct argv argv =3D argv_new();</span><br><span>@@ -73,7 +73,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-open_tun_afunix(struct options *o, int mt=
u, struct tuntap *tt, struct env_set *orig_env)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+open_tun_afunix(const struct options *o, int mt=
u, struct tuntap *tt, const struct env_set *orig_env)</span><br><span> {</s=
pan><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span=
><br><span>diff --git a/src/openvpn/tun_afunix=2Eh b/src/openvpn/tun_afunix=
=2Eh</span><br><span>index 5b6a8e0=2E=2Efb88eb2 100644</span><br><span>--- =
a/src/openvpn/tun_afunix=2Eh</span><br><span>+++ b/src/openvpn/tun_afunix=
=2Eh</span><br><span>@@ -31,7 +31,7 @@</span><br><span>  * the user provide=
d taking care of implementing the actual tun</span><br><span>  * device=2E<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct e=
nv_set *env);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void o=
pen_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, const s=
truct env_set *env);</span><br><span> </span><br><span> </span><br><span> /=
**</span><br><span>diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec=
</span><br><span>index bffc60e=2E=2Ecd32a9b 100644</span><br><span>--- a/sr=
c/openvpn/vlan=2Ec</span><br><span>+++ b/src/openvpn/vlan=2Ec</span><br><sp=
an>@@ -288,7 +288,7 @@</span><br><span> }</span><br><span> </span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vlan_process_ou=
tgoing_tun(struct multi_context *m, struct multi_instance *mi)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+vlan_process_outgoing_tun(const =
struct multi_context *m, struct multi_instance *mi)</span><br><span> {</spa=
n><br><span>     if (!m-&gt;top=2Eoptions=2Evlan_tagging)</span><br><span> =
    {</span><br><span>diff --git a/src/openvpn/vlan=2Eh b/src/openvpn/vlan=
=2Eh</span><br><span>index 9389f89=2E=2Ecd2f66f 100644</span><br><span>--- =
a/src/openvpn/vlan=2Eh</span><br><span>+++ b/src/openvpn/vlan=2Eh</span><br=
><span>@@ -35,6 +35,6 @@</span><br><span> </span><br><span> bool vlan_is_ta=
gged(const struct buffer *buf);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void vlan_process_outgoing_tun(struct multi_con=
text *m, struct multi_instance *mi);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void vlan_process_outgoing_tun(const struct multi_context =
*m, struct multi_instance *mi);</span><br><span> </span><br><span> #endif /=
* VLAN_H */</span><br><span>diff --git a/src/openvpn/win32=2Eh b/src/openvp=
n/win32=2Eh</span><br><span>index ef32062=2E=2Ebcbfa67 100644</span><br><sp=
an>--- a/src/openvpn/win32=2Eh</span><br><span>+++ b/src/openvpn/win32=2Eh<=
/span><br><span>@@ -226,7 +226,7 @@</span><br><span> void overlapped_io_clo=
se(struct overlapped_io *o);</span><br><span> </span><br><span> static inli=
ne bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-overlapped_io_=
active(struct overlapped_io *o)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+overlapped_io_active(const struct overlapped_io *o)</span><br><=
span> {</span><br><span>     return o-&gt;iostate =3D=3D IOSTATE_QUEUED || =
o-&gt;iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;</span><br><span> }</span><br=
><span>diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/op=
envpnmsica=2Ec</span><br><span>index a861e8a=2E=2E25fa1e4 100644</span><br>=
<span>--- a/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>+++ b/src/ope=
nvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -77,7 +77,7 @@</span><br><spa=
n>  * @return ERROR_SUCCESS on success; An error code otherwise</span><br><=
span>  */</span><br><span> static UINT</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szP=
roperty, _In_ struct msica_arg_seq *seq)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR=
 szProperty, _In_ const struct msica_arg_seq *seq)</span><br><span> {</span=
><br><span>     UINT uiResult;</span><br><span>     LPWSTR szSequence =3D m=
sica_arg_seq_join(seq);</span><br><span>diff --git a/src/openvpnserv/intera=
ctive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 628ec85=
=2E=2E1fff6af 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec<=
/span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -5=
21,7 +521,7 @@</span><br><span> </span><br><span> </span><br><span> static =
SOCKADDR_INET</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sockaddr=
_inet(short family, inet_address_t *addr)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+sockaddr_inet(short family, const inet_address_t *add=
r)</span><br><span> {</span><br><span>     SOCKADDR_INET sa_inet;</span><br=
><span>     ZeroMemory(&amp;sa_inet, sizeof(sa_inet));</span><br><span>@@ -=
3733,7 +3733,7 @@</span><br><span> </span><br><span> static DWORD</span><br=
><span> UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_e=
vent, HANDLE exit_event,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                  list_item_t *threads)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                  const list_item_t *threads)</span>=
<br><span> {</span><br><span>     static DWORD size =3D 10;</span><br><span=
>     static LPHANDLE handles =3D NULL;</span><br><span>diff --git a/tests/=
unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_mana=
gement=2Ec</span><br><span>index 77f6ce2=2E=2Efff4c2b 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>+++ b/=
tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>@@ -36,7 +36,7=
 @@</span><br><span> struct management *management; /* GLOBAL */</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-management_auth_failure(struct management *man, const char *type, c=
onst char *reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
anagement_auth_failure(const struct management *man, const char *type, cons=
t char *reason)</span><br><span> {</span><br><span>     ASSERT(false);</spa=
n><br><span> }</span><br><span>diff --git a/tests/unit_tests/openvpn/test_m=
isc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index 4a05=
5e7=2E=2Eaf96764 100644</span><br><span>--- a/tests/unit_tests/openvpn/test=
_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</spa=
n><br><span>@@ -146,7 +146,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> static struct hash_element *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-hash_lookup_by_value(struct hash *hash, void *value)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_lookup_by_value(str=
uct hash *hash, const void *value)</span><br><span> {</span><br><span>     =
struct hash_iterator hi;</span><br><span>     struct hash_element *he;</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/test=
s/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>index c0a0866=2E=2E=
7636a33 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pas=
s=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec</sp=
an><br><span>@@ -59,7 +59,7 @@</span><br><span>     return mock();</span><b=
r><span> }</span><br><span> void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-management_auth_failure(struct management *man, const char *type=
, const char *reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+management_auth_failure(const struct management *man, const char *type, c=
onst char *reason)</span><br><span> {</span><br><span>     assert_true(0);<=
/span><br><span> }</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">change 16=
63</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1663 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--X+OSXowG4+8=--


--===============8815926891199585887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8815926891199585887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8815926891199585887==--

