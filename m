Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DC4C88E5C
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nW0sfWMP4TGXraViDfmoj2KuyPPE/PCfbx/wys5zlKA=; b=DOIfMWvT4r+uVq5+ObGtlM1bIW
	BzpNTuOdkaGUHa7LKT5/YSTkGeo6eavUshPfuFy9Crdgms6F+JGfKPvihuTM2aSXeevedAh3QTzya
	ZDPwcYiL07K2Pj1cLIaJ9bOY8WAvDWbUp94yyq0DdPqKW+PvlJZ4HEpl+OckMKNPzj7Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4zls-0000yA-Fh;
	Fri, 11 Sep 2026 11:50:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4zlV-0000wq-PS
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 11:49:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=naZX+OMJOdRr7T8l1ctuQHe/fKnBYQKeGV5tK5R048U=; b=gvRg2YAsaJZSYuq91ZSkG+kwac
 UzgV8TrEfMtBZEl8FixOFTbebLbu+6fv3eSzVo8m39hctH501NSCA/2xIUIHts8Wbi5ROSvmrwNUI
 bc20wz20tAClnBZIup4H2s4I93VxQj7iaXpGUPop9F6+LT9OxQLn4mNUcwfTwXy6nWoo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=naZX+OMJOdRr7T8l1ctuQHe/fKnBYQKeGV5tK5R048U=; b=d
 n51oJDZ/Ec7iDWE4t23bU4eJfpDl5kP7EwcYaiUd3ojWtIfnJvf0XLZGO87ZTSRfuuss68Zu956e/
 UL7Kyvjid7/RDCnxjIqBOLyetYr8zN9cxq1/0jon7K+mKHMEviEoki8o+KoUEyDDoKxLUcf9ACgfa
 pKdP1rf0L41AqYLI=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4zlK-00037b-Ha for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 11:49:55 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49e6697179cso1490415e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789127380; x=1789732180; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=naZX+OMJOdRr7T8l1ctuQHe/fKnBYQKeGV5tK5R048U=;
 b=YFC+5eOQyjE3K4eD2nD/xho77mFzE2z2f1gUJfg4yqreiyYwg+2DBqKd28WIUMOkxm
 57BC8Kp7OhQxdIYofiE6iLVGvhxoPU0KlBydKTdTEl73UVnUZ/JByTsLVAxBekBttRyo
 EmgMFyX17uvlokfcLXkIToapYh06s1IgpBuuESE3x7OOZWyBteYASUs1eNVx0OW61Mvd
 O15pGMgGPCd/BMitaTPn6/0st+V9/vGjvp8OznMihRVvC0nTWKtniq18xBnBBLj4EXnO
 E6/fWvtYTpnVcV0e3vp4DfWmPmYVFxjwuvpS6mW+x5pnJwVAfuE7D+O5JqwmUOiSBDSa
 xCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789127380; x=1789732180;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=naZX+OMJOdRr7T8l1ctuQHe/fKnBYQKeGV5tK5R048U=;
 b=q9EARw5xa+UwKtAUf79Gs4UVaLRLTlf9MYqq7lzIt8F+kMqeerrcXt/gp4xBszOJ2G
 vIqjGgeFiAg8unZURDMTrj81tpAzghEB8GpOFgcgskYu47McvWrtiVIHYD8mphYJXGWd
 903iZBljPQ/5TChJltcvC1PiQOowwanYoRARuSPUpuwY2VzGg6xsbHSmDaRaxQ7GRBbQ
 7g9k1u4tORvm66WvIn7FLsnBpG+JJBynrtoen9PQp2p9Z/lCJYgWd6GKByUN/66R2cIl
 Pbd7CZvf/vKmbJFcICz3F26Dk0V8Y/fpSwKtrN1f8wlpSA9eHbDR98TSHqP9gu+EXl5y
 jH3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhwh9SJpG2JSGiecJbMc1hieexAlFV26i4xid4x9JjXhHasvlyXeuCPfLbIsffh1U7CreCUoM4e9Ugit6+@lists.sourceforge.net
X-Gm-Message-State: AFuF++kuzwigGFt7N0bS4dkCfCgIur5y4n9gvjQCl//sBv+lgGfAnuH3
 w3HbTXphDWf7uKO8nqhSBO2EEoY7P/vce87b0d4iPJnaqXQRsmnAgTch+sJ/vo689iDC1/OIiAa
 nr68QJkWASi/2849g5fP1dJoFpbJilcG6H7LQb2FpS2RmebF+W3mPoiY9Vs2b2GgW16uQ
X-Gm-Gg: AYBFou2aLUrPJdDAN17J+Ropby8Jc8bpD6lo7jVhZrt6wn43kGeNNtQku+gvl12wQoz
 4nXfm+jjsjAQRZb6AFVhtLj4Wvp2fpa/bZCynzt36GKBjQ9DNuwjc7OZp3ueJd3mwjIz2fnOBoa
 nRJ2vrS8Cr/norkUxyPF9KZjpAmHqQHA3I/UouHpveIAc+RsraQ2v+PqgOB+qBDGCqg3EkXvnqM
 d7u8BQvmCOZIm6dwqSRKhBH54t8To2ifH6ue+wfAOHvJHjDS6u9UBnl4fK7DTmAMabEB2/N4KuD
 4Lrxm6lac9C97Y0EqhSdzTvRtaXJ8ciSgbY+zRdETpcvHErcpBCbgFbVNCgPosI5Rc78n7EJMIb
 p1cHng2G9Sgxx4EzV2RqGUkL9i9gFtdDQ5i5WbUQGslY8uyL3aZitpk2mSDtAsX55euioVgNIb0
 oHt0YESqtGa+2u+tkdz3NAZPipULcw7SlAkgnIsnDvgYKUnhtL5i6BAgjMhGfBqZaTfoA+EPlVI
 8uo68mR7Jxx7JnEFpJ1A6pKozL1332gk+Hs78NKTK8cJRx6EVoMSt/LCKcXAWnYk/N6+bHFvdIb
 RhLSm8TCgTdGig9+gYbQGd6JZ3yLcJqXoUnqE0TZzqHRbYkCYOKmHAqjJO/LVyv5h3NKLoB4
X-Received: by 2002:a05:600c:3b07:b0:49c:fa20:cbff with SMTP id
 5b1f17b1804b1-49e619c18a3mr44172405e9.22.1789127377933; 
 Fri, 11 Sep 2026 04:49:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62230e72sm32853235e9.4.2026.09.11.04.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 04:49:37 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 11:49:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 17e33a6771bd71402d15fce9016460cf8dc0ff18
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <64b3ea7af7971bb1269694d4f2ce6e2d603c85bb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4zlK-00037b-Ha
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
Content-Type: multipart/mixed; boundary="===============1276304446152474710=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1276304446152474710==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="an5raqUDWxU="; charset=UTF-8

--an5raqUDWxU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

Hello plaistho=
s, 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail

to look at the new patch set=
 (#22)=2E


Change subject: Remove instances of constParameterPointer cppch=
eck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Remove instances of constParameterPointer cppcheck warnings

This require=
s a few suppressions since cppcheck
doesn't quite understand the different =
code-paths
implemented by preprocessor defines=2E

Change-Id: I56248cf6d199=
c2da770774b8fd1e5daf2b116f58
Signed-off-by: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
---
M dev-tools/cppcheck-suppression
M sample/sample-plugins/c=
lient-connect/sample-client-connect=2Ec
M sample/sample-plugins/defer/multi=
-auth=2Ec
M sample/sample-plugins/keying-material-exporter-demo/keyingmater=
ialexporter=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/clinat=2Ec
M src/ope=
nvpn/comp=2Ec
M src/openvpn/comp=2Eh
M src/openvpn/crypto=2Ec
M src/openvpn=
/crypto=2Eh
M src/openvpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/dco_f=
reebsd=2Ec
M src/openvpn/dco_internal=2Eh
M src/openvpn/dco_linux=2Ec
M src=
/openvpn/dco_win=2Ec
M src/openvpn/error=2Ec
M src/openvpn/error=2Eh
M src/=
openvpn/event=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/forward=2Eh
M src=
/openvpn/init=2Ec
M src/openvpn/init=2Eh
M src/openvpn/interval=2Eh
M src/o=
penvpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/manage=2Ec
M src/openv=
pn/manage=2Eh
M src/openvpn/mbuf=2Ec
M src/openvpn/mbuf=2Eh
M src/openvpn/m=
ss=2Ec
M src/openvpn/mss=2Eh
M src/openvpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
=
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M sr=
c/openvpn/multi_io=2Ec
M src/openvpn/networking=2Eh
M src/openvpn/networkin=
g_iproute2=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn/occ=2Eh
M s=
rc/openvpn/openssl_compat=2Eh
M src/openvpn/options=2Ec
M src/openvpn/optio=
ns_parse=2Ec
M src/openvpn/otime=2Ec
M src/openvpn/otime=2Eh
M src/openvpn/=
proto=2Eh
M src/openvpn/proxy=2Ec
M src/openvpn/proxy=2Eh
M src/openvpn/ps=
=2Ec
M src/openvpn/ps=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push=2Eh
M s=
rc/openvpn/push_util=2Ec
M src/openvpn/reliable=2Ec
M src/openvpn/reliable=
=2Eh
M src/openvpn/route=2Ec
M src/openvpn/schedule=2Ec
M src/openvpn/socke=
t=2Ec
M src/openvpn/socket=2Eh
M src/openvpn/socket_util=2Eh
M src/openvpn/=
socks=2Ec
M src/openvpn/socks=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl=
=2Eh
M src/openvpn/ssl_backend=2Eh
M src/openvpn/ssl_mbedtls=2Ec
M src/open=
vpn/ssl_openssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M s=
rc/openvpn/ssl_verify=2Ec
M src/openvpn/ssl_verify=2Eh
M src/openvpn/status=
=2Ec
M src/openvpn/status=2Eh
M src/openvpn/tun=2Ec
M src/openvpn/tun=2Eh
M=
 src/openvpn/tun_afunix=2Ec
M src/openvpn/tun_afunix=2Eh
M src/openvpn/vlan=
=2Ec
M src/openvpn/vlan=2Eh
M src/openvpn/win32=2Eh
M src/openvpnmsica/open=
vpnmsica=2Ec
M src/openvpnserv/interactive=2Ec
M tests/unit_tests/openvpn/m=
ock_management=2Ec
M tests/unit_tests/openvpn/siphash_openssl=2Ec
M tests/u=
nit_tests/openvpn/test_misc=2Ec
M tests/unit_tests/openvpn/test_user_pass=
=2Ec
88 files changed, 345 insertions(+), 289 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1663/22

diff --git=
 a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 29=
9d7a3=2E=2E6ac2fe5 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-to=
ols/cppcheck-suppression
@@ -2,7 +2,6 @@
 # occurences right now=2E They st=
ill should be fixed at some point
 constParameter
 constParameterCallback
-=
constParameterPointer
 invalidPrintfArgType_sint
 invalidPrintfArgType_uint=

 unusedFunction
@@ -26,11 +25,54 @@
 # FP: posix=2Ecfg claims suseconds_t =
is unsigned for some reason
 unsignedLessThanZero:src/openvpn/otime=2Eh:148=

 # IGN: multi code does weird things with pointers to local variables=2E=
=2E=2E
-autoVariables:src/openvpn/multi=2Ec:4242
+autoVariables:src/openvpn=
/multi=2Ec:4243
 autoVariables:src/openvpn/multi_io=2Ec:324
 # IGN: the cod=
e header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally
 badBitma=
skCheck:src/openvpn/mudp=2Ec
 badBitmaskCheck:tests/unit_tests/openvpn/test=
_pkt=2Ec
+# IGN: we store integers in pointers
+CastAddressToIntegerAtRetur=
n:src/openvpn/multi=2Ec
+# IGN: external
+constParameterPointer:/usr/includ=
e/*
+# IGN: test files provide mocks/stubs that match prototypes from heade=
rs exactly
+constParameterPointer:tests/unit_tests/openvpn/mock_*
+constPar=
ameterPointer:tests/unit_tests/openvpn/test_*
+constParameterPointer:tests/=
unit_tests/openvpnserv/test_*
+# FP: different crypto implementations but s=
ame API
+constParameterPointer:src/openvpn/crypto_mbedtls=2Ec:81
+constPara=
meterPointer:src/openvpn/crypto_mbedtls=2Ec:333
+constParameterPointer:src/=
openvpn/crypto_mbedtls_legacy=2Ec:85
+constParameterPointer:src/openvpn/cry=
pto_openssl=2Ec:173
+constParameterPointer:src/openvpn/crypto_openssl=2Ec:1=
433
+constParameterPointer:src/openvpn/cryptoapi=2Ec:58
+constParameterPoin=
ter:src/openvpn/ssl_mbedtls=2Ec
+constParameterPointer:src/openvpn/ssl_open=
ssl=2Ec
+constParameterPointer:src/openvpn/ssl_verify_mbedtls=2Ec
+constPar=
ameterPointer:tests/unit_tests/openvpn/siphash_openssl=2Ec
+# IGN: too many=
 different implementations, not worth it
+constParameterPointer:src/openvpn=
/dco*
+constParameterPointer:src/openvpn/socket=2E*
+# FP: parameters are m=
odified on some platform only
+constParameterPointer:src/openvpn/dns=2Ec:85=
9
+constParameterPointer:src/openvpn/error=2Ec:223
+constParameterPointer:s=
rc/openvpn/forward=2Ec:1245
+constParameterPointer:src/openvpn/manage=2Ec:3=
44
+constParameterPointer:src/openvpn/manage=2Ec:3329
+constParameterPointe=
r:src/openvpn/misc=2Ec:793
+constParameterPointer:src/openvpn/misc=2Ec:813
=
+constParameterPointer:src/openvpn/options=2Ec:2578
+constParameterPointer:=
src/openvpn/options=2Ec:3205
+constParameterPointer:src/openvpn/route=2Ec:3=
947
+constParameterPointer:src/openvpn/tun=2Ec:560
+constParameterPointer:s=
rc/openvpn/tun=2Ec:2188
+constParameterPointer:src/openvpn/tun_afunix=2Ec
+=
# IGN: not a FP but the documentation for the FP_ISSET claims this is not c=
onst=2E=2E=2E
+constParameterPointer:src/openvpn/event=2Ec:1015
+# FP: we p=
lay around with const in the interface too much
+# also hides: fun:check_ma=
lloc_return: causes -Wmaybe-uninitialized in MinGW Debug build
+constParame=
terPointer:src/openvpn/buffer=2Eh
+# FP: const silently removed due to poin=
ter arithmentic
+constParameterPointer:src/openvpn/buffer=2Ec:273
 # IGN: W=
indows specific (unsigned long =3D=3D unsigned int)
 compareValueOutOfTypeR=
angeError:src/openvpn/ssl_verify=2Ec:928
 # FP: cppcheck seems to have wron=
g signature of DeviceIoControl()
diff --git a/sample/sample-plugins/client-=
connect/sample-client-connect=2Ec b/sample/sample-plugins/client-connect/sa=
mple-client-connect=2Ec
index 420de61=2E=2Ecbd98e8 100644
--- a/sample/samp=
le-plugins/client-connect/sample-client-connect=2Ec
+++ b/sample/sample-plu=
gins/client-connect/sample-client-connect=2Ec
@@ -344,7 +344,7 @@
 }
 
 int=

-openvpn_plugin_client_connect(struct plugin_context *context, const char =
**argv, const char **envp)
+openvpn_plugin_client_connect(const struct plug=
in_context *context, const char **argv, const char **envp)
 {
     /* log e=
nvironment variables handed to us by OpenVPN, but
      * only if "setenv v=
erb" is 3 or higher (arbitrary number)
@@ -465,7 +465,7 @@
 
 int
 openvpn_=
plugin_client_connect_defer_v2(struct plugin_context *context,
-           =
                            struct plugin_per_client_context *pcc,
+       =
                                const struct plugin_per_client_context *pcc=
,
                                        struct openvpn_plugin_string_list=
 **return_list)
 {
     time_t time_left =3D pcc->sleep_until - time(NULL);=

diff --git a/sample/sample-plugins/defer/multi-auth=2Ec b/sample/sample-pl=
ugins/defer/multi-auth=2Ec
index bacf557=2E=2Ecdd616f 100644
--- a/sample/s=
ample-plugins/defer/multi-auth=2Ec
+++ b/sample/sample-plugins/defer/multi-=
auth=2Ec
@@ -255,7 +255,7 @@
 }
 
 static bool
-do_auth_user_pass(struct pl=
ugin_context *context, const char *username, const char *password)
+do_auth=
_user_pass(const struct plugin_context *context, const char *username, cons=
t char *password)
 {
     plog(context, PLOG_NOTE, "expect_user=3D%s, recei=
ved_user=3D%s, expect_passw=3D%s, received_passw=3D%s",
          np(contex=
t->test_valid_user), np(username), np(context->test_valid_pass), np(passwor=
d));
@@ -279,7 +279,7 @@
 
 
 static int
-auth_user_pass_verify(struct plug=
in_context *context, struct plugin_per_client_context *pcc,
+auth_user_pass=
_verify(const struct plugin_context *context, struct plugin_per_client_cont=
ext *pcc,
                       const char *argv[], const char *envp[])
 {=

     /* get username/password from envp string array */
diff --git a/sampl=
e/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec b=
/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=
=2Ec
index 25c9ff5=2E=2E512861a 100644
--- a/sample/sample-plugins/keying-m=
aterial-exporter-demo/keyingmaterialexporter=2Ec
+++ b/sample/sample-plugin=
s/keying-material-exporter-demo/keyingmaterialexporter=2Ec
@@ -186,7 +186,7=
 @@
 }
 
 static void
-file_store(char *file, char *content)
+file_store(co=
nst char *file, const char *content)
 {
     FILE *f;
     if (!(f =3D fope=
n(file, "w+")))
@@ -202,7 +202,7 @@
 server_store(struct openvpn_plugin_arg=
s_func_in const *args)
 {
     struct plugin *plugin =3D (struct plugin *)a=
rgs->handle;
-    struct session *sess =3D (struct session *)args->per_clie=
nt_context;
+    const struct session *sess =3D (struct session *)args->per=
_client_context;
 
     char file[MAXPATH];
     snprintf(file, sizeof(file=
) - 1, "/tmp/openvpn_sso_%s", sess->key);
@@ -214,7 +214,7 @@
 client_store=
(struct openvpn_plugin_args_func_in const *args)
 {
     struct plugin *plu=
gin =3D (struct plugin *)args->handle;
-    struct session *sess =3D (struc=
t session *)args->per_client_context;
+    const struct session *sess =3D (=
struct session *)args->per_client_context;
 
     char *file =3D "/tmp/open=
vpn_sso_user";
     ovpn_note("app session file: %s", file);
diff --git a/s=
rc/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 22a8b74=2E=2E44ed434 1=
00644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1918,7 =
+1918,7 @@
  * @param a  The arena to test=2E
  */
 static inline bool
-gc_=
defined(struct gc_arena *a)
+gc_defined(const struct gc_arena *a)
 {
     r=
eturn a->list !=3D NULL;
 }
diff --git a/src/openvpn/clinat=2Ec b/src/openv=
pn/clinat=2Ec
index 3724022=2E=2E9fa8f5f 100644
--- a/src/openvpn/clinat=2E=
c
+++ b/src/openvpn/clinat=2Ec
@@ -159,7 +159,7 @@
 #endif
 
 static void
-=
print_pkt(struct openvpn_iphdr *iph, const char *prefix, const int directio=
n, const msglvl_t msglevel)
+print_pkt(const struct openvpn_iphdr *iph, con=
st char *prefix, const int direction, const msglvl_t msglevel)
 {
     stru=
ct gc_arena gc =3D gc_new();
 
diff --git a/src/openvpn/comp=2Ec b/src/open=
vpn/comp=2Ec
index b88b79f=2E=2E387a7c4 100644
--- a/src/openvpn/comp=2Ec
+=
++ b/src/openvpn/comp=2Ec
@@ -159,7 +159,7 @@
 #endif /* USE_COMP */
 
 boo=
l
-check_compression_settings_valid(struct compress_options *info, msglvl_t=
 msglevel)
+check_compression_settings_valid(const struct compress_options =
*info, msglvl_t msglevel)
 {
     /*
      * We also allow comp-stub-v2 her=
e as it technically allows escaping of
diff --git a/src/openvpn/comp=2Eh b/=
src/openvpn/comp=2Eh
index 29a90a2=2E=2Ead80243 100644
--- a/src/openvpn/co=
mp=2Eh
+++ b/src/openvpn/comp=2Eh
@@ -91,7 +91,7 @@
  * flags of allow-comp=
ression and also the whether algorithms are compiled
  * in
  */
-bool chec=
k_compression_settings_valid(struct compress_options *info, msglvl_t msglev=
el);
+bool check_compression_settings_valid(const struct compress_options *=
info, msglvl_t msglevel);
 
 #ifdef USE_COMP
 #include "buffer=2Eh"
diff --=
git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index e5ad31a=2E=2Ee2=
9d581 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -=
1105,7 +1105,7 @@
 }
 
 static bool
-key_is_zero(struct key *key, const str=
uct key_type *kt)
+key_is_zero(const struct key *key, const struct key_type=
 *kt)
 {
     size_t cipher_length =3D cipher_kt_key_size(kt->cipher);
    =
 for (size_t i =3D 0; i < cipher_length; ++i)
@@ -1123,7 +1123,7 @@
  * Mak=
e sure that cipher key is a valid key for current key_type=2E
  */
 bool
-c=
heck_key(struct key *key, const struct key_type *kt)
+check_key(const struc=
t key *key, const struct key_type *kt)
 {
     if (cipher_defined(kt->ciphe=
r))
     {
@@ -1196,7 +1196,7 @@
 }
 
 void
-test_crypto(struct crypto_opti=
ons *co, struct frame *frame)
+test_crypto(struct crypto_options *co, const=
 struct frame *frame)
 {
     int i, j;
     struct gc_arena gc =3D gc_new(=
);
diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index ee5b5=
0f=2E=2Ee3c1c6a 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypt=
o=2Eh
@@ -414,7 +414,7 @@
  */
 int write_key_file(const int nkeys, const c=
har *filename);
 
-bool check_key(struct key *key, const struct key_type *k=
t);
+bool check_key(const struct key *key, const struct key_type *kt);
 
 /=
**
  * Initialize a key_type structure with=2E
@@ -614,7 +614,7 @@
 /** Pri=
nt a cipher list entry */
 void print_cipher(const char *cipher);
 
-void t=
est_crypto(struct crypto_options *co, struct frame *f);
+void test_crypto(s=
truct crypto_options *co, const struct frame *f);
 
 
 /* key direction fun=
ctions */
diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index 8eae=
4bf=2E=2Ec2cafae 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec=

@@ -534,7 +534,7 @@
     ASSERT(sock->info=2Econnection_established);
 
  =
   struct sockaddr *remoteaddr =3D &sock->info=2Elsa->actual=2Edest=2Eaddr=
=2Esa;
-    struct tls_multi *multi =3D c->c2=2Etls_multi;
+    const struc=
t tls_multi *multi =3D c->c2=2Etls_multi;
 #ifdef TARGET_FREEBSD
     /* In=
 Linux in P2P mode the kernel automatically removes an existing peer
      =
* when adding a new peer=2E FreeBSD needs to explicitly be told to do that =
*/
@@ -573,7 +573,7 @@
 }
 
 static bool
-dco_multi_get_localaddr(struct mu=
lti_context *m, struct multi_instance *mi,
+dco_multi_get_localaddr(const s=
truct multi_context *m, const struct multi_instance *mi,
                  =
       struct sockaddr_storage *local)
 {
 #if ENABLE_IP_PKTINFO
@@ -585,7 =
+585,7 @@
         return false;
     }
 
-    struct link_socket_actual *a=
ctual =3D &c->c2=2Elink_socket_infos[0]->lsa->actual;
+    const struct lin=
k_socket_actual *actual =3D &c->c2=2Elink_socket_infos[0]->lsa->actual;
 
 =
    switch (actual->dest=2Eaddr=2Esa=2Esa_family)
     {
@@ -623,7 +623,7 @=
@
 }
 
 int
-dco_multi_add_new_peer(struct multi_context *m, struct multi_i=
nstance *mi)
+dco_multi_add_new_peer(const struct multi_context *m, struct =
multi_instance *mi)
 {
     const struct context *c =3D &mi->context;
 
@@ =
-677,7 +677,7 @@
 }
 
 void
-dco_install_iroute(struct multi_context *m, st=
ruct multi_instance *mi, struct mroute_addr *addr)
+dco_install_iroute(stru=
ct multi_context *m, struct multi_instance *mi, const struct mroute_addr *a=
ddr)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_W=
IN32)
     if (!dco_enabled(&m->top=2Eoptions))
@@ -796,7 +796,7 @@
       =
  /* Checked if we added a host route as the assigned client IP address was=

          * outside the --ifconfig-ipv6 tun interface config */
 #if !defi=
ned(_WIN32)
-        struct in6_addr *dest =3D &mi->context=2Ec2=2Epush_ifc=
onfig_ipv6_local;
+        const struct in6_addr *dest =3D &mi->context=2Ec=
2=2Epush_ifconfig_ipv6_local;
         if (multi_check_push_ifconfig_ipv6_e=
xtra_route(mi, dest))
         {
             /* On windows we do not insta=
ll these routes, so we also do not need to delete them */
diff --git a/src/=
openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index 4e5aad5=2E=2E694875c 100644
---=
 a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -204,7 +204,7 @@
  * @p=
aram mi        the client instance
  * @return          0 on success or a n=
egative error code otherwise
  */
-int dco_multi_add_new_peer(struct multi_=
context *m, struct multi_instance *mi);
+int dco_multi_add_new_peer(const s=
truct multi_context *m, struct multi_instance *mi);
 
 /**
  * Install an i=
route in DCO, which means adding a route to the system routing
@@ -215,7 +2=
15,7 @@
  * @param addr      the route to add
  */
 void dco_install_iroute=
(struct multi_context *m, struct multi_instance *mi,
-                     =
   struct mroute_addr *addr);
+                        const struct mroute_=
addr *addr);
 
 /**
  * Remove all routes added through the specified clien=
t
@@ -253,7 +253,7 @@
  * a 64 bit packet counter and AEAD tag at the end=
=2E
  */
 bool
-dco_supports_epoch_data(struct context *c);
+dco_supports_e=
poch_data(const struct context *c);
 #else  /* if defined(ENABLE_DCO) */
 
=
 typedef void *dco_context_t;
@@ -350,7 +350,7 @@
 }
 
 static inline int
-=
dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
=
+dco_multi_add_new_peer(const struct multi_context *m, struct multi_instanc=
e *mi)
 {
     return 0;
 }
@@ -384,7 +384,7 @@
 }
 
 static inline bool
-d=
co_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(const st=
ruct context *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_free=
bsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index d933aaf=2E=2E7346903 100644
---=
 a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -930,7 =
+930,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_suppo=
rts_epoch_data(const struct context *c)
 {
     return false;
 }
diff --git=
 a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh
index fcf8ac=
a=2E=2E1022e66 100644
--- a/src/openvpn/dco_internal=2Eh
+++ b/src/openvpn/=
dco_internal=2Eh
@@ -59,8 +59,9 @@
  * They are implemented by dco_linux=2E=
c
  */
 
-int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_=
descriptor_t sd, struct sockaddr *localaddr,
-                 struct socka=
ddr *remoteaddr, const struct in_addr *vpn_ipv4, const struct in6_addr *vpn=
_ipv6);
+int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_d=
escriptor_t sd,
+                 struct sockaddr *localaddr, struct sockad=
dr *remoteaddr,
+                 const struct in_addr *vpn_ipv4, const str=
uct in6_addr *vpn_ipv6);
 
 int dco_del_peer(dco_context_t *dco, unsigned i=
nt peerid);
 
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linu=
x=2Ec
index 56f6259=2E=2E31bbe87 100644
--- a/src/openvpn/dco_linux=2Ec
+++=
 b/src/openvpn/dco_linux=2Ec
@@ -114,7 +114,7 @@
 }
 
 static struct nl_msg=
 *
-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)
+ovpn_dco_nlmsg_=
create(const dco_context_t *dco, uint8_t cmd)
 {
     struct nl_msg *nl_msg=
 =3D nlmsg_alloc();
     if (!nl_msg)
@@ -804,7 +804,7 @@
 
 /* libnl < 3=
=2E11=2E0 does not implement nla_get_uint() */
 static uint64_t
-ovpn_nla_g=
et_uint(struct nlattr *attr)
+ovpn_nla_get_uint(const struct nlattr *attr)
=
 {
     if (nla_len(attr) =3D=3D sizeof(uint32_t))
     {
@@ -916,7 +916,7 =
@@
 }
 
 static bool
-ovpn_iface_check(dco_context_t *dco, struct nlattr *a=
ttrs[])
+ovpn_iface_check(const dco_context_t *dco, struct nlattr *attrs[])=

 {
     /* we must know which interface this message is referring to in or=
der to
      * avoid mixing messages for other instances
@@ -1340,7 +1340,7=
 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_ep=
och_data(const struct context *c)
 {
     return false;
 }
diff --git a/src=
/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index b3268bc=2E=2E8deb9d8 1=
00644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -1100,=
7 +1100,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_su=
pports_epoch_data(const struct context *c)
 {
     OVPN_VERSION ver =3D { 0=
 };
     return dco_get_version(&ver) && ((ver=2EMajor =3D=3D 2 && ver=2EMi=
nor >=3D 8) || (ver=2EMajor > 2));
diff --git a/src/openvpn/error=2Ec b/src=
/openvpn/error=2Ec
index 26d4c7c=2E=2E32d819d 100644
--- a/src/openvpn/erro=
r=2Ec
+++ b/src/openvpn/error=2Ec
@@ -623,7 +623,7 @@
  * from the OS=2E
  =
*/
 void
-x_check_status(ssize_t status, const char *description, struct li=
nk_socket *sock, struct tuntap *tt)
+x_check_status(ssize_t status, const c=
har *description, struct link_socket *sock, const struct tuntap *tt)
 {
   =
  const char *extended_msg =3D NULL;
 
diff --git a/src/openvpn/error=2Eh b=
/src/openvpn/error=2Eh
index a887fc7=2E=2E35c4996 100644
--- a/src/openvpn/=
error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -302,10 +302,10 @@
 void set_check=
_status(unsigned int info_level, unsigned int verbose_level);
 
 void x_che=
ck_status(ssize_t status, const char *description, struct link_socket *sock=
,
-                    struct tuntap *tt);
+                    const struc=
t tuntap *tt);
 
 static inline void
-check_status(ssize_t status, const ch=
ar *description, struct link_socket *sock, struct tuntap *tt)
+check_status=
(ssize_t status, const char *description, struct link_socket *sock, const s=
truct tuntap *tt)
 {
     if (status < 0 || check_debug_level(x_cs_verbose_=
level))
     {
diff --git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh
i=
ndex b784dfe=2E=2E0940a1d 100644
--- a/src/openvpn/event=2Eh
+++ b/src/open=
vpn/event=2Eh
@@ -204,7 +204,7 @@
 #else /* ifdef _WIN32 */
 
 static inlin=
e void
-wait_signal(struct event_set *es, void *arg)
+wait_signal(const str=
uct event_set *es, const void *arg)
 {
 }
 
diff --git a/src/openvpn/forwar=
d=2Ec b/src/openvpn/forward=2Ec
index 83cd113=2E=2E56fc124 100644
--- a/src=
/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -231,7 +231,7 @@
 }
 =

 static void
-parse_incoming_control_channel_command(struct context *c, st=
ruct buffer *buf)
+parse_incoming_control_channel_command(struct context *c=
, const struct buffer *buf)
 {
     if (buf_string_match_head_str(buf, "AUT=
H_FAILED"))
     {
@@ -501,7 +501,7 @@
 }
 
 int
-get_server_poll_remaining=
_time(struct event_timeout *server_poll_timeout)
+get_server_poll_remaining=
_time(const struct event_timeout *server_poll_timeout)
 {
     update_time(=
);
     int remaining =3D event_timeout_remaining(server_poll_timeout);
@@ =
-598,7 +598,7 @@
  * Buffer reallocation, for use with null encryption=2E
 =
 */
 static inline void
-buffer_turnover(const uint8_t *orig_buf, struct bu=
ffer *dest_stub, struct buffer *src_stub,
+buffer_turnover(const uint8_t *o=
rig_buf, struct buffer *dest_stub, const struct buffer *src_stub,
         =
        struct buffer *storage)
 {
     if (orig_buf =3D=3D src_stub->data =
&& src_stub->data !=3D storage->data)
@@ -885,7 +885,7 @@
  */
 
 static in=
line void
-socks_postprocess_incoming_link(struct context *c, struct link_s=
ocket *sock)
+socks_postprocess_incoming_link(struct context *c, const stru=
ct link_socket *sock)
 {
     if (sock->socks_proxy && sock->info=2Eproto =
=3D=3D PROTO_UDP)
     {
@@ -982,7 +982,7 @@
 }
 
 bool
-process_incoming_l=
ink_part1(struct context *c, struct link_socket_info *lsi, bool floated)
+p=
rocess_incoming_link_part1(struct context *c, const struct link_socket_info=
 *lsi, bool floated)
 {
     struct gc_arena gc =3D gc_new();
     bool dec=
rypt_status =3D false;
@@ -1532,7 +1532,7 @@
  * @param client    Determine=
s whether to the send packet back via tun or link
  */
 void
-ipv6_send_icm=
p_unreachable(struct context *c, struct buffer *buf, bool client)
+ipv6_sen=
d_icmp_unreachable(struct context *c, const struct buffer *buf, bool client=
)
 {
 #define MAX_ICMPV6LEN 1280
     struct openvpn_icmp6hdr icmp6out;
dif=
f --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh
index 324c0b4=
=2E=2Eee7d2e2 100644
--- a/src/openvpn/forward=2Eh
+++ b/src/openvpn/forwar=
d=2Eh
@@ -127,7 +127,7 @@
  */
 void encrypt_sign(struct context *c, bool c=
omp_frag);
 
-int get_server_poll_remaining_time(struct event_timeout *serv=
er_poll_timeout);
+int get_server_poll_remaining_time(const struct event_ti=
meout *server_poll_timeout);
 
 /******************************************=
****************************/
 /**
@@ -178,7 +178,7 @@
  *
  * @return true=
 if packet is authenticated, false otherwise=2E
  */
-bool process_incoming=
_link_part1(struct context *c, struct link_socket_info *lsi, bool floated);=

+bool process_incoming_link_part1(struct context *c, const struct link_soc=
ket_info *lsi, bool floated);
 
 /**
  * Continues processing a packet read=
 from the external network interface=2E
diff --git a/src/openvpn/init=2Ec b=
/src/openvpn/init=2Ec
index 453ee7e=2E=2E525c135 100644
--- a/src/openvpn/i=
nit=2Ec
+++ b/src/openvpn/init=2Ec
@@ -803,7 +803,7 @@
 }
 
 static void
-i=
nit_port_share(struct context *c)
+init_port_share(const struct context *c)=

 {
     if (!port_share && (c->options=2Eport_share_host && c->options=2Ep=
ort_share_port))
     {
@@ -1245,7 +1245,7 @@
  * prepending to msg() outpu=
t=2E
  */
 const char *
-format_common_name(struct context *c, struct gc_ar=
ena *gc)
+format_common_name(const struct context *c, struct gc_arena *gc)
=
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
     if (c->c2=2Etls_m=
ulti)
@@ -1731,7 +1731,7 @@
 
 
 static bool
-can_preserve_tun(struct tunta=
p *tt)
+can_preserve_tun(const struct tuntap *tt)
 {
     if (tt && tt->bac=
kend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -1753,7 +1753,7 @@
  * @param c=
 pointer to the connection context
  */
 static void
-add_wfp_block(struct =
context *c)
+add_wfp_block(const struct context *c)
 {
 #if defined(_WIN32)=

     /* Fortify 'redirect-gateway block-local' with firewall rules? */
@@ =
-1779,7 +1779,7 @@
  * @param adapter_index the VPN adapter index
  */
 sta=
tic void
-del_wfp_block(struct context *c, unsigned long adapter_index)
+de=
l_wfp_block(const struct context *c, unsigned long adapter_index)
 {
 #if d=
efined(_WIN32)
     if (c->options=2Eblock_outside_dns || block_local_neede=
d(c->c1=2Eroute_list))
diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=
=2Eh
index ce8f74e=2E=2Ec486158 100644
--- a/src/openvpn/init=2Eh
+++ b/src=
/openvpn/init=2Eh
@@ -91,7 +91,7 @@
 
 uint64_t pull_permission_mask(const =
struct context *c);
 
-const char *format_common_name(struct context *c, st=
ruct gc_arena *gc);
+const char *format_common_name(const struct context *c=
, struct gc_arena *gc);
 
 void reset_coarse_timers(struct context *c);
 
d=
iff --git a/src/openvpn/interval=2Eh b/src/openvpn/interval=2Eh
index 59051=
bd=2E=2E0cfe202 100644
--- a/src/openvpn/interval=2Eh
+++ b/src/openvpn/int=
erval=2Eh
@@ -89,7 +89,7 @@
 }
 
 static inline void
-interval_schedule_wak=
eup(struct interval *top, interval_t *wakeup)
+interval_schedule_wakeup(con=
st struct interval *top, interval_t *wakeup)
 {
     const time_t local_now=
 =3D now;
     interval_earliest_wakeup(wakeup, top->last_test_true + top->=
refresh, local_now);
@@ -214,7 +214,7 @@
  * This function does not check i=
f the timeout is actually valid=2E
  */
 static inline interval_t
-event_ti=
meout_remaining(struct event_timeout *et)
+event_timeout_remaining(const st=
ruct event_timeout *et)
 {
     return (interval_t)((et->last + et->n) - no=
w);
 }
diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index e51dc=
d0=2E=2Edcd59d7 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2E=
c
@@ -164,7 +164,7 @@
 }
 
 void
-hash_remove_by_value(struct hash *hash, v=
oid *value)
+hash_remove_by_value(struct hash *hash, const void *value)
 {
=
     struct hash_iterator hi;
     const struct hash_element *he;
diff --gi=
t a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
index 55bc3c8=2E=2E23267d0 =
100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -78,7 +78,7=
 @@
 
 bool hash_remove_fast(struct hash *hash, struct hash_bucket *bucket,=
 const void *key, uint64_t hv);
 
-void hash_remove_by_value(struct hash *h=
ash, void *value);
+void hash_remove_by_value(struct hash *hash, const void=
 *value);
 
 struct hash_iterator
 {
diff --git a/src/openvpn/manage=2Ec b/=
src/openvpn/manage=2Ec
index e6f9574=2E=2E606d766 100644
--- a/src/openvpn/=
manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -330,7 +330,7 @@
 }
 
 static vo=
id
-man_delete_unix_socket(struct management *man)
+man_delete_unix_socket(=
const struct management *man)
 {
 #if UNIX_SOCK_SUPPORT
     if ((man->sett=
ings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
=
@@ -675,7 +675,7 @@
  * for the log and echo commands=2E
  */
 static void
=
-man_history(struct management *man, const char *parm, const char *type, st=
ruct log_history *log,
+man_history(struct management *man, const char *par=
m, const char *type, const struct log_history *log,
             bool *real=
time, const unsigned int lep_flags)
 {
     struct gc_arena gc =3D gc_new()=
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
@@ -2363,7 +2363,7 @@
  * the route/ifconfig/open tu=
n command=2E   See doc/android=2Etxt for details=2E
  */
 bool
-management_=
android_control(struct management *man, const char *command, const char *ms=
g)
+management_android_control(const struct management *man, const char *co=
mmand, const char *msg)
 {
     if (!man)
     {
@@ -3010,7 +3010,7 @@
 }
 =

 void
-management_up_down(struct management *man, const char *updown, cons=
t struct env_set *es)
+management_up_down(const struct management *man, con=
st char *updown, const struct env_set *es)
 {
     if (man->settings=2Eflag=
s & MF_UP_DOWN)
     {
@@ -3204,7 +3204,7 @@
 }
 
 void
-management_auth_fa=
ilure(struct management *man, const char *type, const char *reason)
+manage=
ment_auth_failure(const struct management *man, const char *type, const cha=
r *reason)
 {
     if (reason)
     {
diff --git a/src/openvpn/manage=2Eh b=
/src/openvpn/manage=2Eh
index 3ab937c=2E=2E8aa5c87 100644
--- a/src/openvpn=
/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -368,7 +368,7 @@
              =
                   const unsigned int flags, const char *static_challenge);=

 
 #ifdef TARGET_ANDROID
-bool management_android_control(struct managemen=
t *man, const char *command, const char *msg);
+bool management_android_con=
trol(const struct management *man, const char *command, const char *msg);
 =

 #define ANDROID_KEEP_OLD_TUN      1
 #define ANDROID_OPEN_BEFORE_CLOSE 2
=
@@ -382,7 +382,7 @@
 
 void management_event_loop_n_seconds(struct manageme=
nt *man, int sec);
 
-void management_up_down(struct management *man, const=
 char *updown, const struct env_set *es);
+void management_up_down(const st=
ruct management *man, const char *updown, const struct env_set *es);
 
 voi=
d management_notify(const char *severity, const char *type,
               =
         const char *text);
@@ -397,7 +397,7 @@
 void management_connection=
_established(struct management *management,
                               =
         struct man_def_auth_context *mdac, const struct env_set *es);
 
-v=
oid management_notify_client_close(struct management *management,
+void man=
agement_notify_client_close(const struct management *management,
          =
                           struct man_def_auth_context *mdac, const struct =
env_set *es);
 
 void management_learn_addr(struct man_def_auth_context *md=
ac,
@@ -482,7 +482,7 @@
  * OpenVPN calls here to indicate a password failu=
re
  */
 
-void management_auth_failure(struct management *man, const char =
*type, const char *reason);
+void management_auth_failure(const struct mana=
gement *man, const char *type, const char *reason);
 
 /*
  * Echo an authe=
ntication token to management interface
diff --git a/src/openvpn/mbuf=2Ec b=
/src/openvpn/mbuf=2Ec
index 7b790ed=2E=2E9a37e30 100644
--- a/src/openvpn/m=
buf=2Ec
+++ b/src/openvpn/mbuf=2Ec
@@ -149,7 +149,7 @@
 }
 
 void
-mbuf_der=
eference_instance(struct mbuf_set *ms, struct multi_instance *mi)
+mbuf_der=
eference_instance(struct mbuf_set *ms, const struct multi_instance *mi)
 {
=
     if (ms)
     {
diff --git a/src/openvpn/mbuf=2Eh b/src/openvpn/mbuf=2E=
h
index cfe698c=2E=2Ee368054 100644
--- a/src/openvpn/mbuf=2Eh
+++ b/src/op=
envpn/mbuf=2Eh
@@ -75,7 +75,7 @@
 
 bool mbuf_extract_item(struct mbuf_set =
*ms, struct mbuf_item *item);
 
-void mbuf_dereference_instance(struct mbuf=
_set *ms, struct multi_instance *mi);
+void mbuf_dereference_instance(struc=
t mbuf_set *ms, const struct multi_instance *mi);
 
 static inline bool
 mb=
uf_defined(const struct mbuf_set *ms)
diff --git a/src/openvpn/mss=2Ec b/sr=
c/openvpn/mss=2Ec
index 36bbb43=2E=2E0cfa272d 100644
--- a/src/openvpn/mss=
=2Ec
+++ b/src/openvpn/mss=2Ec
@@ -239,8 +239,8 @@
 }
 
 static void
-frame=
_calculate_fragment(struct frame *frame, struct key_type *kt, const struct =
options *options,
-                         struct link_socket_info *lsi)
+=
frame_calculate_fragment(struct frame *frame, const struct key_type *kt, co=
nst struct options *options,
+                         const struct link_so=
cket_info *lsi)
 {
 #if defined(ENABLE_FRAGMENT)
     size_t overhead;
@@ -=
269,8 +269,8 @@
 }
 
 static void
-frame_calculate_mssfix(struct frame *fra=
me, struct key_type *kt, const struct options *options,
-                  =
     struct link_socket_info *lsi)
+frame_calculate_mssfix(struct frame *fr=
ame, const struct key_type *kt, const struct options *options,
+           =
            const struct link_socket_info *lsi)
 {
     if (options->ce=2Em=
ssfix_fixed)
     {
@@ -314,8 +314,8 @@
 }
 
 void
-frame_calculate_dynamic=
(struct frame *frame, struct key_type *kt, const struct options *options,
-=
                        struct link_socket_info *lsi)
+frame_calculate_dyna=
mic(struct frame *frame, const struct key_type *kt, const struct options *o=
ptions,
+                        const struct link_socket_info *lsi)
 {
   =
  if (options->ce=2Efragment > 0)
     {
diff --git a/src/openvpn/mss=2Eh b=
/src/openvpn/mss=2Eh
index 1d092bb=2E=2E2eab55a 100644
--- a/src/openvpn/ms=
s=2Eh
+++ b/src/openvpn/mss=2Eh
@@ -36,8 +36,8 @@
 void mss_fixup_dowork(st=
ruct buffer *buf, uint16_t maxmss);
 
 /** Set the --mssfix option=2E */
-v=
oid frame_calculate_dynamic(struct frame *frame, struct key_type *kt,
-    =
                         const struct options *options, struct link_socket_=
info *lsi);
+void frame_calculate_dynamic(struct frame *frame, const struct=
 key_type *kt,
+                             const struct options *options,=
 const struct link_socket_info *lsi);
 
 /**
  * Checks and adjusts the fra=
gment and mssfix value according to the
diff --git a/src/openvpn/mtcp=2Ec b=
/src/openvpn/mtcp=2Ec
index 5d88f8a=2E=2E922db3f 100644
--- a/src/openvpn/m=
tcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -91,7 +91,7 @@
 }
 
 bool
-multi_tcp_=
instance_specific_init(struct multi_context *m, struct multi_instance *mi)
=
+multi_tcp_instance_specific_init(const struct multi_context *m, struct mul=
ti_instance *mi)
 {
     /* buffer for queued TCP socket output packets */
=
     mi->tcp_link_out_deferred =3D mbuf_init(m->top=2Eoptions=2En_bcast_buf=
);
diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh
index 9b7d1d2=
=2E=2Ebb117fa 100644
--- a/src/openvpn/mtcp=2Eh
+++ b/src/openvpn/mtcp=2Eh
=
@@ -35,7 +35,7 @@
 
 void multi_tcp_dereference_instance(struct multi_io *m=
ulti_io, struct multi_instance *mi);
 
-bool multi_tcp_instance_specific_in=
it(struct multi_context *m, struct multi_instance *mi);
+bool multi_tcp_ins=
tance_specific_init(const struct multi_context *m, struct multi_instance *m=
i);
 
 void multi_tcp_instance_specific_free(struct multi_instance *mi);
 
=
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index de3d467=2E=
=2E85c4ab3 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ =
-53,8 +53,9 @@
  * @param sock    the socket to send the reply on
  */
 sta=
tic void
-send_standalone_reply(struct multi_context *m, struct buffer *buf=
, const char *prefix,
-                      const char *detail, struct lin=
k_socket *sock)
+send_standalone_reply(struct multi_context *m, const struc=
t buffer *buf,
+                      const char *prefix, const char *detai=
l,
+                      struct link_socket *sock)
 {
     struct context =
*c =3D &m->top;
 
@@ -74,7 +75,7 @@
 
 static void
 send_hmac_reset_packet(=
struct multi_context *m, struct tls_pre_decrypt_state *state,
-            =
           struct tls_auth_standalone *tas, struct session_id *sid,
+      =
                 const struct tls_auth_standalone *tas, const struct sessio=
n_id *sid,
                        bool request_resend_wkc, struct link_soc=
ket *sock)
 {
     reset_packet_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket=
_id=2Esend);
@@ -97,11 +98,11 @@
 
     enum first_packet_verdict verdict;
=
 
-    struct tls_auth_standalone *tas =3D m->top=2Ec2=2Etls_auth_standalon=
e;
+    const struct tls_auth_standalone *tas =3D m->top=2Ec2=2Etls_auth_st=
andalone;
 
     verdict =3D tls_pre_decrypt_lite(tas, state, &m->top=2Ec2=
=2Efrom, &m->top=2Ec2=2Ebuf);
 
-    uint8_t *hmac_key =3D m->top=2Ec2=2Ese=
ssion_id_key;
+    const uint8_t *hmac_key =3D m->top=2Ec2=2Esession_id_key=
;
     const struct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
=
     int handwindow =3D m->top=2Eoptions=2Ehandshake_window;
 
@@ -218,7 +2=
19,7 @@
 static struct multi_instance *
 handle_connection_attempt(struct m=
ulti_context *m,
                           struct link_socket *sock,
-    =
                      struct mroute_addr *real)
+                          =
const struct mroute_addr *real)
 {
     struct hash *hash =3D m->hash;
    =
 struct tls_pre_decrypt_state state =3D { 0 };
@@ -286,13 +287,12 @@
  * @r=
eturn      instance matching the address, NULL otherwise
  */
 static struc=
t multi_instance *
-multi_get_instance_udp_real(struct multi_context *m, st=
ruct mroute_addr *real)
+multi_get_instance_udp_real(struct multi_context *=
m, const struct mroute_addr *real)
 {
     struct hash *hash =3D m->hash;
-=
    struct hash_element *he;
     const uint64_t hv =3D hash_value(hash, re=
al);
     struct hash_bucket *bucket =3D hash_bucket(hash, hv);
-    he =3D=
 hash_lookup_fast(hash, bucket, real, hv);
+    const struct hash_element *=
he =3D hash_lookup_fast(hash, bucket, real, hv);
     if (he)
     {
      =
   return he->value;
@@ -320,7 +320,9 @@
  * maintaining real address hash =
table atomicity=2E
  */
 struct multi_instance *
-multi_get_instance_udp_da=
ta(struct multi_context *m, bool *floated, struct mroute_addr *real, struct=
 link_socket *sock)
+multi_get_instance_udp_data(struct multi_context *m, b=
ool *floated,
+                            const struct mroute_addr *real,
=
+                            const struct link_socket *sock)
 {
     struct=
 multi_instance *mi =3D NULL;
 
diff --git a/src/openvpn/multi=2Ec b/src/op=
envpn/multi=2Ec
index 3e72b92=2E=2E89e2d4c 100644
--- a/src/openvpn/multi=
=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -57,7 +57,7 @@
 
 #ifdef MULTI_DEBUG_EV=
ENT_LOOP
 static const char *
-id(struct multi_instance *mi)
+id(const stru=
ct multi_instance *mi)
 {
     if (mi)
     {
@@ -1314,7 +1314,7 @@
  * sam=
e common name=2E
  */
 static void
-multi_delete_dup(struct multi_context *=
m, struct multi_instance *new_mi)
+multi_delete_dup(struct multi_context *m=
, const struct multi_instance *new_mi)
 {
     if (new_mi)
     {
@@ -2259,=
7 +2259,7 @@
 }
 
 static bool
-multi_client_setup_dco_initial(struct multi=
_context *m, struct multi_instance *mi,
+multi_client_setup_dco_initial(con=
st struct multi_context *m, struct multi_instance *mi,
                    =
            struct gc_arena *gc)
 {
     if (!dco_enabled(&mi->context=2Eop=
tions))
@@ -3078,7 +3078,8 @@
  * positive=2E
  */
 static bool
-multi_chec=
k_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi, str=
uct mroute_addr *real)
+multi_check_dest_addr_allowed(struct multi_context =
*m, struct multi_instance *mi,
+                              const struct =
mroute_addr *real)
 {
     struct hash *hash =3D m->hash;
     const uint64=
_t hv =3D hash_value(hash, real);
@@ -3237,7 +3238,7 @@
 
 #if defined(ENAB=
LE_DCO)
 static void
-process_incoming_del_peer(struct multi_context *m, st=
ruct multi_instance *mi, dco_context_t *dco)
+process_incoming_del_peer(str=
uct multi_context *m, struct multi_instance *mi, const dco_context_t *dco)
=
 {
     const char *reason =3D "ovpn-dco: unknown reason";
     switch (dco=
->dco_del_peer_reason)
@@ -4291,7 +4292,7 @@
 
 /* Searches for the address=
 and deletes it if it is owned by the multi_instance */
 static void
-multi=
_unlearn_addr(struct multi_context *m, struct multi_instance *mi, const str=
uct mroute_addr *addr)
+multi_unlearn_addr(struct multi_context *m, const s=
truct multi_instance *mi, const struct mroute_addr *addr)
 {
     struct ha=
sh_element *he;
     const uint64_t hv =3D hash_value(m->vhash, addr);
@@ -=
4326,7 +4327,7 @@
  * @param a     The new IPv4 address in network byte ord=
er
  */
 static void
-multi_unlearn_in_addr_t(struct multi_context *m, stru=
ct multi_instance *mi, in_addr_t a)
+multi_unlearn_in_addr_t(struct multi_c=
ontext *m, const struct multi_instance *mi, in_addr_t a)
 {
     struct mro=
ute_addr addr;
     CLEAR(addr);
@@ -4344,7 +4345,7 @@
  * @param a6    The=
 new IPv6 address
  */
 static void
-multi_unlearn_in6_addr(struct multi_co=
ntext *m, struct multi_instance *mi, struct in6_addr a6)
+multi_unlearn_in6=
_addr(struct multi_context *m, const struct multi_instance *mi, struct in6_=
addr a6)
 {
     struct mroute_addr addr;
     CLEAR(addr);
@@ -4460,7 +446=
1,7 @@
 
 bool
 multi_check_push_ifconfig_ipv6_extra_route(struct multi_ins=
tance *mi,
-                                           struct in6_addr *des=
t)
+                                           const struct in6_addr *dest)=

 {
     const struct options *o =3D &mi->context=2Eoptions;
 
diff --git a=
/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 6cb86c7=2E=2E5b8d56a 1=
00644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -517,7 +51=
7,7 @@
  */
 
 static inline void
-set_prefix(struct multi_instance *mi)
+s=
et_prefix(const struct multi_instance *mi)
 {
 #ifdef MULTI_DEBUG_EVENT_LOO=
P
     if (mi->msg_prefix[0])
@@ -691,7 +691,7 @@
  */
 bool
 multi_check_p=
ush_ifconfig_ipv6_extra_route(struct multi_instance *mi,
-                 =
                          struct in6_addr *dest);
+                        =
                   const struct in6_addr *dest);
 
 /*
  * Check for signal=
s=2E
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index=
 3604684=2E=2E52eb8c7 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openv=
pn/multi_io=2Ec
@@ -159,7 +159,7 @@
  * a point-to-multipoint tunnel=2E
  *=
/
 static unsigned int
-p2mp_iow_flags(const struct multi_context *m, struc=
t link_socket *sock)
+p2mp_iow_flags(const struct multi_context *m, const s=
truct link_socket *sock)
 {
     unsigned int flags =3D IOW_WAIT_SIGNAL;
 
=
diff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
index =
bce0c19=2E=2E25233c8 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/open=
vpn/networking=2Eh
@@ -44,7 +44,7 @@
  */
 #if !defined(ENABLE_IPROUTE)
 st=
atic inline int
-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+n=
et_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)
 {
     (void)=
c;
     (void)ctx;
@@ -75,7 +75,7 @@
  *
  * @return          0 on success,=
 a negative error code otherwise
  */
-int net_ctx_init(struct context *c, =
openvpn_net_ctx_t *ctx);
+int net_ctx_init(const struct context *c, openvpn=
_net_ctx_t *ctx);
 
 /**
  * Release resources allocated by the internal ga=
rbage collector
@@ -102,7 +102,7 @@
  * @return          0 on success, nega=
tive error code on error
  */
 int net_iface_new(openvpn_net_ctx_t *ctx, co=
nst openvpn_net_iface_t *iface, const char *type,
-                  void *=
arg);
+                  const void *arg);
 
 /**
  * Retrieve the interfac=
e type
diff --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/netwo=
rking_iproute2=2Ec
index a1f3525=2E=2Ef091fb3 100644
--- a/src/openvpn/netw=
orking_iproute2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -36,7 +36,=
7 @@
 #include <netinet/in=2Eh>
 
 int
-net_ctx_init(struct context *c, ope=
nvpn_net_ctx_t *ctx)
+net_ctx_init(const struct context *c, openvpn_net_ctx=
_t *ctx)
 {
     ctx->es =3D NULL;
     if (c)
@@ -61,7 +61,7 @@
 }
 
 int
=
-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type,=
 void *arg)
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const=
 char *type, const void *arg)
 {
     struct argv argv =3D argv_new();
 
di=
ff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=
=2Ec
index a396255=2E=2E13e0f0b 100644
--- a/src/openvpn/networking_sitnl=
=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -1007,7 +1007,7 @@
 }
 
 sta=
tic int
-sitnl_addr_del(sa_family_t af_family, const char *iface, inet_addr=
ess_t *addr, int prefixlen)
+sitnl_addr_del(sa_family_t af_family, const ch=
ar *iface, const inet_address_t *addr, int prefixlen)
 {
     int ifindex;
=
 
@@ -1250,8 +1250,8 @@
 }
 
 static int
-sitnl_route_del(const char *iface=
, sa_family_t af_family, inet_address_t *dst, int prefixlen,
-             =
   inet_address_t *gw, uint32_t table, int metric)
+sitnl_route_del(const c=
har *iface, sa_family_t af_family, const inet_address_t *dst, int prefixlen=
,
+                const inet_address_t *gw, uint32_t table, int metric)
 {=

     int ifindex =3D 0;
 
@@ -1328,7 +1328,7 @@
 
 
 int
-net_iface_new(op=
envpn_net_ctx_t *ctx, const char *iface, const char *type, void *arg)
+net_=
iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, cons=
t void *arg)
 {
     struct sitnl_link_req req =3D {};
     int ret =3D -1;=

diff --git a/src/openvpn/occ=2Eh b/src/openvpn/occ=2Eh
index bda4f18=2E=2E=
49def4d 100644
--- a/src/openvpn/occ=2Eh
+++ b/src/openvpn/occ=2Eh
@@ -156,=
7 +156,7 @@
  * via control channel=2E
  * @return control channel exit mes=
sage should be used */
 static inline bool
-cc_exit_notify_enabled(struct c=
ontext *c)
+cc_exit_notify_enabled(const struct context *c)
 {
     /* Chec=
k if we have TLS active at all */
     if (!c->c2=2Etls_multi)
diff --git a=
/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh
index 098b=
dd5=2E=2E1a934db 100644
--- a/src/openvpn/openssl_compat=2Eh
+++ b/src/open=
vpn/openssl_compat=2Eh
@@ -127,7 +127,7 @@
 /* Mimics the functions but onl=
y when the default context without
  * options is chosen */
 static inline =
const EVP_CIPHER *
-EVP_CIPHER_fetch(void *ctx, const char *algorithm, cons=
t char *properties)
+EVP_CIPHER_fetch(const void *ctx, const char *algorith=
m, const char *properties)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
=
@@ -135,7 +135,7 @@
 }
 
 static inline const EVP_MD *
-EVP_MD_fetch(void *=
ctx, const char *algorithm, const char *properties)
+EVP_MD_fetch(const voi=
d *ctx, const char *algorithm, const char *properties)
 {
     ASSERT(!ctx)=
;
     ASSERT(!properties);
diff --git a/src/openvpn/options=2Ec b/src/open=
vpn/options=2Ec
index 15f2fcd=2E=2Ef1306bb 100644
--- a/src/openvpn/options=
=2Ec
+++ b/src/openvpn/options=2Ec
@@ -2423,7 +2423,7 @@
 }
 
 static void
=
-options_postprocess_mutate_le(struct connection_entry *ce, struct local_en=
try *le, int mode)
+options_postprocess_mutate_le(const struct connection_e=
ntry *ce, struct local_entry *le, int mode)
 {
     /* use the global port =
if none is specified */
     if (!le->port)
@@ -3576,7 +3576,7 @@
 static b=
ool
 verify_permission(const char *name, const char *file, int line, const =
uint64_t type,
                   const uint64_t allowed, uint64_t *found, =
const msglvl_t msglevel,
-                  struct options *options, bool i=
s_inline)
+                  const struct options *options, bool is_inline)=

 {
     if (!(type & allowed))
     {
@@ -3652,7 +3652,7 @@
 }
 
 static i=
nline msglvl_t
-msglevel_forward_compatible(struct options *options, const =
msglvl_t msglevel)
+msglevel_forward_compatible(const struct options *optio=
ns, const msglvl_t msglevel)
 {
     return options->forward_compatible ? M=
_WARN : msglevel;
 }
@@ -4143,7 +4143,7 @@
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
index d14f01e=2E=2E74d21ff 100644
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
index 9bb0866=2E=2E1665751 100644
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
index 74a6cf9=2E=2Ec3ad7de 100644
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

index 08c2673=2E=2E2679c4d5 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/open=
vpn/ps=2Ec
@@ -334,7 +334,7 @@
  * the proxy can determine true client orig=
in=2E
  */
 static void
-journal_add(const char *journal_dir, struct proxy_=
connection *pc, struct proxy_connection *cp)
+journal_add(const char *journ=
al_dir, const struct proxy_connection *pc, struct proxy_connection *cp)
 {
=
     struct openvpn_sockaddr from, to;
 
@@ -412,7 +412,7 @@
 static bool
 =
proxy_entry_new(struct proxy_connection **list, struct event_set *es,
     =
            const struct openvpn_sockaddr server_addr, const socket_descrip=
tor_t sd_client,
-                struct buffer *initial_data, const char *=
journal_dir)
+                const struct buffer *initial_data, const char=
 *journal_dir)
 {
     socket_descriptor_t sd_server;
     int status;
@@ -=
1015,7 +1015,7 @@
  * call=2E
  */
 void
-port_share_redirect(struct port_s=
hare *ps, const struct buffer *head, socket_descriptor_t sd)
+port_share_re=
direct(const struct port_share *ps, const struct buffer *head, socket_descr=
iptor_t sd)
 {
     if (ps)
     {
diff --git a/src/openvpn/ps=2Eh b/src/op=
envpn/ps=2Eh
index 557ecf5=2E=2E918ceb6 100644
--- a/src/openvpn/ps=2Eh
+++=
 b/src/openvpn/ps=2Eh
@@ -49,7 +49,7 @@
 
 bool is_openvpn_protocol(const s=
truct buffer *buf);
 
-void port_share_redirect(struct port_share *ps, cons=
t struct buffer *head, socket_descriptor_t sd);
+void port_share_redirect(c=
onst struct port_share *ps, const struct buffer *head, socket_descriptor_t =
sd);
 
 #endif /* if PORT_SHARE */
 #endif /* ifndef PS_H */
diff --git a/s=
rc/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 761a59e=2E=2Ed72596e 10064=
4
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -430,7 +430,7 @@=

 }
 
 bool
-send_auth_pending_messages(struct tls_multi *tls_multi, struct=
 tls_session *session,
+send_auth_pending_messages(const struct tls_multi *=
tls_multi, struct tls_session *session,
                            const c=
har *extra, unsigned int timeout)
 {
     struct key_state *ks =3D &session=
->key[KS_PRIMARY];
diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh=

index dff945f=2E=2E39302f6 100644
--- a/src/openvpn/push=2Eh
+++ b/src/ope=
nvpn/push=2Eh
@@ -117,7 +117,7 @@
  * doc/management-notes=2Etxt under clie=
nt-pending-auth for
  * more details on message format
  */
-bool send_auth=
_pending_messages(struct tls_multi *tls_multi, struct tls_session *session,=

+bool send_auth_pending_messages(const struct tls_multi *tls_multi, struct=
 tls_session *session,
                                 const char *extra, =
unsigned int timeout);
 
 void send_restart(struct context *c, const char *=
kill_msg);
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=
=2Ec
index 0213041=2E=2E7fa5987 100644
--- a/src/openvpn/push_util=2Ec
+++ =
b/src/openvpn/push_util=2Ec
@@ -222,7 +222,7 @@
 
 /* Return true if the cl=
ient supports push-update */
 static bool
-support_push_update(struct multi=
_instance *mi)
+support_push_update(const struct multi_instance *mi)
 {
   =
  ASSERT(mi->context=2Ec2=2Etls_multi);
     const unsigned int iv_proto_pe=
er =3D extract_iv_proto(mi->context=2Ec2=2Etls_multi->peer_info);
diff --gi=
t a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index ced438e=2E=2E=
ba819a3 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2E=
c
@@ -92,7 +92,7 @@
 
 /* check if a particular packet_id is present in ack=
 */
 static inline bool
-reliable_ack_packet_id_present(struct reliable_ack=
 *ack, packet_id_type pid)
+reliable_ack_packet_id_present(const struct rel=
iable_ack *ack, packet_id_type pid)
 {
     for (int i =3D 0; i < ack->len;=
 ++i)
     {
@@ -391,7 +391,7 @@
 }
 
 int
-validate_packet_id_window(struc=
t reliable *rel, packet_id_type pid)
+validate_packet_id_window(const struc=
t reliable *rel, packet_id_type pid)
 {
     return reliable_pid_min(pid, r=
el->packet_id)
            && reliable_pid_min(subtract_pid(rel->packet_id,=
 RELIABLE_CAPACITY), pid);
@@ -768,7 +768,7 @@
  */
 
 void
-reliable_mark_=
active_incoming(struct reliable *rel, struct buffer *buf, packet_id_type pi=
d,
+reliable_mark_active_incoming(struct reliable *rel, const struct buffer=
 *buf, packet_id_type pid,
                               int opcode)
 {
  =
   for (int i =3D 0; i < rel->size; ++i)
@@ -828,7 +828,7 @@
 
 /* delete a=
 buffer previously activated by reliable_mark_active() */
 void
-reliable_m=
ark_deleted(struct reliable *rel, struct buffer *buf)
+reliable_mark_delete=
d(struct reliable *rel, const struct buffer *buf)
 {
     for (int i =3D 0;=
 i < rel->size; ++i)
     {
diff --git a/src/openvpn/reliable=2Eh b/src/ope=
nvpn/reliable=2Eh
index a85f2e9=2E=2E12d5367 100644
--- a/src/openvpn/relia=
ble=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -184,7 +184,7 @@
  * @li False, i=
f there are packet IDs to be acknowledged=2E
  */
 static inline bool
-reli=
able_ack_empty(struct reliable_ack *ack)
+reliable_ack_empty(const struct r=
eliable_ack *ack)
 {
     return !ack->len;
 }
@@ -198,7 +198,7 @@
  * incl=
uded in the valid range=2E
  */
 int
-validate_packet_id_window(struct reli=
able *rel, packet_id_type pid);
+validate_packet_id_window(const struct rel=
iable *rel, packet_id_type pid);
 
 /**
  * Returns the number of packets t=
hat need to be acked=2E
@@ -208,7 +208,7 @@
  * @returns the number of outs=
tanding acks
  */
 static inline int
-reliable_ack_outstanding(struct relia=
ble_ack *ack)
+reliable_ack_outstanding(const struct reliable_ack *ack)
 {
=
     return ack->len;
 }
@@ -358,7 +358,7 @@
  * @param pid The packet's pa=
cket ID=2E
  * @param opcode The packet's opcode=2E
  */
-void reliable_mar=
k_active_incoming(struct reliable *rel, struct buffer *buf, packet_id_type =
pid,
+void reliable_mark_active_incoming(struct reliable *rel, const struct=
 buffer *buf, packet_id_type pid,
                                    int o=
pcode);
 
 /**
@@ -411,7 +411,7 @@
  * @param rel The reliable structure as=
sociated with the given buffer=2E
  * @param buf The buffer of the reliable=
 entry which is to be removed=2E
  */
-void reliable_mark_deleted(struct re=
liable *rel, struct buffer *buf);
+void reliable_mark_deleted(struct reliab=
le *rel, const struct buffer *buf);
 
 /** @} name Functions for extracting=
 incoming packets */
 
diff --git a/src/openvpn/route=2Ec b/src/openvpn/rou=
te=2Ec
index 03a2526=2E=2E078bb7e 100644
--- a/src/openvpn/route=2Ec
+++ b/=
src/openvpn/route=2Ec
@@ -898,8 +898,9 @@
 }
 
 static bool
-add_bypass_rou=
tes(struct route_bypass *rb, in_addr_t gateway, const struct tuntap *tt,
- =
                 unsigned int flags, const struct route_gateway_info *rgi,
=
+add_bypass_routes(const struct route_bypass *rb, in_addr_t gateway,
+     =
             const struct tuntap *tt, unsigned int flags,
+                =
  const struct route_gateway_info *rgi,
                   const struct env=
_set *es, openvpn_net_ctx_t *ctx)
 {
     int ret =3D true;
@@ -916,8 +917,=
9 @@
 }
 
 static void
-del_bypass_routes(struct route_bypass *rb, in_addr_=
t gateway, const struct tuntap *tt,
-                  unsigned int flags, =
const struct route_gateway_info *rgi,
+del_bypass_routes(const struct route=
_bypass *rb, in_addr_t gateway,
+                  const struct tuntap *tt,=
 unsigned int flags,
+                  const struct route_gateway_info *rg=
i,
                   const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
=
     int i;
@@ -3942,7 +3944,7 @@
 #else  /* if defined(_WIN32) */
 
 stati=
c void
-get_bypass_addresses(struct route_bypass *rb, const unsigned int fl=
ags) /* PLATFORM-SPECIFIC */
+get_bypass_addresses(struct route_bypass *rb,=
 const unsigned int flags)
 {
 }
 
diff --git a/src/openvpn/schedule=2Ec b/=
src/openvpn/schedule=2Ec
index 6772ad6=2E=2E694f4d1 100644
--- a/src/openvp=
n/schedule=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -389,4 +389,4 @@
 {
     s=
->earliest_wakeup =3D NULL; /* invalidate cache */
     schedule_remove_nod=
e(s, e);
-}
\ No newline at end of file
+}
diff --git a/src/openvpn/socket=
=2Ec b/src/openvpn/socket=2Ec
index 73871b2=2E=2Eb3cdc60 100644
--- a/src/o=
penvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -619,7 +619,7 @@
 }
 
 st=
atic void
-bind_local(struct link_socket *sock)
+bind_local(const struct li=
nk_socket *sock)
 {
     /* bind to local address/port */
     if (sock->bi=
nd_local)
@@ -878,8 +878,8 @@
 }
 
 void
-socket_bind(socket_descriptor_t s=
d, struct addrinfo *local, int ai_family, const char *prefix,
-            =
bool ipv6only)
+socket_bind(socket_descriptor_t sd, const struct addrinfo *=
local, int ai_family,
+            const char *prefix, bool ipv6only)
 {
  =
   struct gc_arena gc =3D gc_new();
 
@@ -1087,8 +1087,8 @@
  * such as TCP=
=2E
  */
 
-static void stream_buf_init(struct stream_buf *sb, struct buffe=
r *buf, const unsigned int sockflags,
-                            const in=
t proto);
+static void stream_buf_init(struct stream_buf *sb, const struct =
buffer *buf,
+                            const unsigned int sockflags, con=
st int proto);
 
 static void stream_buf_close(struct stream_buf *sb);
 
@@=
 -1441,7 +1441,7 @@
 }
 
 static void
-phase2_set_socket_flags(struct link_=
socket *sock)
+phase2_set_socket_flags(const struct link_socket *sock)
 {
 =
    /* TCP_NODELAY is enabled by default on every TCP socket; dco-win is
  =
    * skipped as it manages its own socket */
@@ -2037,7 +2037,7 @@
 }
 
 s=
tatic void
-stream_buf_init(struct stream_buf *sb, struct buffer *buf, cons=
t unsigned int sockflags,
+stream_buf_init(struct stream_buf *sb, const str=
uct buffer *buf, const unsigned int sockflags,
                 const int p=
roto)
 {
     sb->buf_init =3D *buf;
@@ -2303,7 +2303,7 @@
 #endif
 
 stati=
c ssize_t
-link_socket_read_udp_posix_recvmsg(struct link_socket *sock, str=
uct buffer *buf,
+link_socket_read_udp_posix_recvmsg(const struct link_sock=
et *sock, struct buffer *buf,
                                    struct li=
nk_socket_actual *from, socklen_t *fromlen)
 {
     struct iovec iov;
@@ -2=
375,7 +2375,7 @@
 #endif /* if ENABLE_IP_PKTINFO */
 
 ssize_t
-link_socket=
_read_udp_posix(struct link_socket *sock, struct buffer *buf,
+link_socket_=
read_udp_posix(const struct link_socket *sock, struct buffer *buf,
        =
                    struct link_socket_actual *from)
 {
     ssize_t recvle=
n;
@@ -2438,7 +2438,7 @@
 #if ENABLE_IP_PKTINFO
 
 ssize_t
-link_socket_wri=
te_udp_posix_sendmsg(struct link_socket *sock, struct buffer *buf,
+link_so=
cket_write_udp_posix_sendmsg(const struct link_socket *sock, const struct b=
uffer *buf,
                                     struct link_socket_actual =
*to)
 {
     struct iovec iov;
@@ -2634,7 +2634,7 @@
 }
 
 int
-socket_send=
_queue(struct link_socket *sock, struct buffer *buf, const struct link_sock=
et_actual *to)
+socket_send_queue(struct link_socket *sock, const struct bu=
ffer *buf, const struct link_socket_actual *to)
 {
     if (sock->writes=2E=
iostate =3D=3D IOSTATE_INITIAL)
     {
@@ -2734,8 +2734,8 @@
     return so=
ck->writes=2Eiostate;
 }
 
-void
-read_sockaddr_from_overlapped(struct over=
lapped_io *io, struct sockaddr *dst, int overlapped_ret)
+static void
+read=
_sockaddr_from_overlapped(const struct overlapped_io *io, struct sockaddr *=
dst, int overlapped_ret)
 {
     if (overlapped_ret >=3D 0 && io->addr_defi=
ned)
     {
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
in=
dex c6a29f4=2E=2Eaea9f42 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/open=
vpn/socket=2Eh
@@ -268,7 +268,7 @@
 
 int socket_recv_queue(struct link_soc=
ket *sock, int maxsize);
 
-int socket_send_queue(struct link_socket *sock,=
 struct buffer *buf,
+int socket_send_queue(struct link_socket *sock, const=
 struct buffer *buf,
                       const struct link_socket_actual=
 *to);
 
 typedef struct
@@ -348,8 +348,8 @@
 
 struct link_socket *link_so=
cket_new(void);
 
-void socket_bind(socket_descriptor_t sd, struct addrinfo=
 *local, int af_family, const char *prefix,
-                 bool ipv6only=
);
+void socket_bind(socket_descriptor_t sd, const struct addrinfo *local, =
int af_family,
+                 const char *prefix, bool ipv6only);
 
 int=
 openvpn_connect(socket_descriptor_t sd, const struct sockaddr *remote, int=
 connect_timeout,
                     volatile int *signal_received);
@@ -=
483,7 +483,7 @@
 }
 
 static inline bool
-link_socket_verify_incoming_addr(=
struct buffer *buf, const struct link_socket_info *info,
+link_socket_verif=
y_incoming_addr(const struct buffer *buf, const struct link_socket_info *in=
fo,
                                  const struct link_socket_actual *from=
_addr)
 {
     if (buf->len > 0)
@@ -607,7 +607,7 @@
 
 #else  /* ifdef _WI=
N32 */
 
-ssize_t link_socket_read_udp_posix(struct link_socket *sock, stru=
ct buffer *buf,
+ssize_t link_socket_read_udp_posix(const struct link_socke=
t *sock, struct buffer *buf,
                                    struct lin=
k_socket_actual *from);
 
 #endif /* ifdef _WIN32 */
@@ -693,12 +693,12 @@
=
 
 #else /* ifdef _WIN32 */
 
-ssize_t link_socket_write_udp_posix_sendmsg(=
struct link_socket *sock, struct buffer *buf,
+ssize_t link_socket_write_ud=
p_posix_sendmsg(const struct link_socket *sock, const struct buffer *buf,
 =
                                            struct link_socket_actual *to);=

 
 
 static inline ssize_t
-link_socket_write_udp_posix(struct link_socket=
 *sock, struct buffer *buf,
+link_socket_write_udp_posix(const struct link_=
socket *sock, const struct buffer *buf,
                             struct=
 link_socket_actual *to)
 {
 #if ENABLE_IP_PKTINFO
@@ -714,7 +714,7 @@
 }
 =

 static inline ssize_t
-link_socket_write_tcp_posix(struct link_socket *so=
ck, struct buffer *buf)
+link_socket_write_tcp_posix(const struct link_sock=
et *sock, const struct buffer *buf)
 {
     return send(sock->sd, CBPTR(buf=
), BLENZ(buf), MSG_NOSIGNAL);
 }
@@ -772,7 +772,7 @@
  * from tunnel packet=
=2E
  */
 static inline void
-link_socket_set_tos(struct link_socket *sock)=

+link_socket_set_tos(const struct link_socket *sock)
 {
     if (sock && s=
ock->ptos_defined)
     {
@@ -818,6 +818,8 @@
     }
 }
 
+/* cppcheck-supp=
ress constParameterPointer
+ * sock is modified on Windows via &sock->liste=
n_handle */
 static inline void
 socket_reset_listen_persistent(struct link=
_socket *sock)
 {
diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/so=
cket_util=2Eh
index 13f5962=2E=2Eadd08ba 100644
--- a/src/openvpn/socket_ut=
il=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -439,7 +439,7 @@
 
 
 static in=
line bool
-addrlist_match_proto(const struct openvpn_sockaddr *a1, struct a=
ddrinfo *addr_list, const int proto)
+addrlist_match_proto(const struct ope=
nvpn_sockaddr *a1, const struct addrinfo *addr_list, const int proto)
 {
  =
   return link_socket_proto_connection_oriented(proto) ? addrlist_match(a1,=
 addr_list)
                                                         : addr=
list_port_match(a1, addr_list);
diff --git a/src/openvpn/socks=2Ec b/src/op=
envpn/socks=2Ec
index 19f3d54=2E=2Eff3c590 100644
--- a/src/openvpn/socks=
=2Ec
+++ b/src/openvpn/socks=2Ec
@@ -82,7 +82,7 @@
 
 static bool
 socks_pr=
oxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,
-      =
                struct event_timeout *server_poll_timeout,
+               =
       const struct event_timeout *server_poll_timeout,
                   =
    volatile int *signal_received)
 {
     fd_set reads;
@@ -97,8 +97,8 @@
=
 }
 
 static bool
-socks_username_password_auth(struct socks_proxy_info *p,=
 socket_descriptor_t sd,
-                             struct event_timeout=
 *server_poll_timeout,
+socks_username_password_auth(const struct socks_pro=
xy_info *p, socket_descriptor_t sd,
+                             const str=
uct event_timeout *server_poll_timeout,
                              volat=
ile int *signal_received)
 {
     char to_send[516];
@@ -156,8 +156,8 @@
 }=

 
 static bool
-socks_handshake(struct socks_proxy_info *p, socket_descrip=
tor_t sd,
-                struct event_timeout *server_poll_timeout, volat=
ile int *signal_received)
+socks_handshake(const struct socks_proxy_info *p=
, socket_descriptor_t sd,
+                const struct event_timeout *serv=
er_poll_timeout, volatile int *signal_received)
 {
     uint8_t buf[2];
   =
  int len =3D 0;
@@ -231,7 +231,7 @@
 
 static bool
 recv_socks_reply(socke=
t_descriptor_t sd, struct openvpn_sockaddr *addr,
-                 struct =
event_timeout *server_poll_timeout, volatile int *signal_received)
+       =
          const struct event_timeout *server_poll_timeout, volatile int *si=
gnal_received)
 {
     uint8_t atyp =3D 0;
     int alen =3D 0;
@@ -323,8 +=
323,7 @@
         return port;
     }
 
-    struct servent *service;
-    =
service =3D getservbyname(servname, NULL);
+    const struct servent *servi=
ce =3D getservbyname(servname, NULL);
     if (service)
     {
         ret=
urn service->s_port;
@@ -334,11 +333,11 @@
 }
 
 void
-establish_socks_prox=
y_passthru(struct socks_proxy_info *p,
+establish_socks_proxy_passthru(cons=
t struct socks_proxy_info *p,
                                socket_descri=
ptor_t sd, /* already open to proxy */
                                cons=
t char *host,       /* openvpn server remote */
                           =
     const char *servname,   /* openvpn server port */
-                   =
            struct event_timeout *server_poll_timeout,
+                   =
            const struct event_timeout *server_poll_timeout,
              =
                  struct signal_info *sig_info)
 {
     char buf[270];
@@ -=
392,10 +391,10 @@
 }
 
 void
-establish_socks_proxy_udpassoc(struct socks_p=
roxy_info *p,
+establish_socks_proxy_udpassoc(const struct socks_proxy_info=
 *p,
                                socket_descriptor_t ctrl_sd, /* alread=
y open to proxy */
                                struct openvpn_sockaddr =
*relay_addr,
-                               struct event_timeout *server_p=
oll_timeout,
+                               const struct event_timeout *se=
rver_poll_timeout,
                                struct signal_info *sig_=
info)
 {
     if (!socks_handshake(p, ctrl_sd, server_poll_timeout, &sig_in=
fo->signal_received))
diff --git a/src/openvpn/socks=2Eh b/src/openvpn/sock=
s=2Eh
index 846113d=2E=2Ef7c93b6 100644
--- a/src/openvpn/socks=2Eh
+++ b/s=
rc/openvpn/socks=2Eh
@@ -47,17 +47,17 @@
 
 void socks_proxy_close(struct s=
ocks_proxy_info *sp);
 
-void establish_socks_proxy_passthru(struct socks_p=
roxy_info *p,
+void establish_socks_proxy_passthru(const struct socks_proxy=
_info *p,
                                     socket_descriptor_t sd, /* a=
lready open to proxy */
                                     const char *ho=
st,       /* openvpn server remote */
                                     =
const char *servname,   /* openvpn server port */
-                        =
            struct event_timeout *server_poll_timeout,
+                   =
                 const struct event_timeout *server_poll_timeout,
         =
                            struct signal_info *sig_info);
 
-void establis=
h_socks_proxy_udpassoc(struct socks_proxy_info *p,
+void establish_socks_pr=
oxy_udpassoc(const struct socks_proxy_info *p,
                            =
         socket_descriptor_t ctrl_sd, /* already open to proxy */
         =
                            struct openvpn_sockaddr *relay_addr,
-         =
                           struct event_timeout *server_poll_timeout,
+    =
                                const struct event_timeout *server_poll_tim=
eout,
                                     struct signal_info *sig_info);
 =

 void socks_process_incoming_udp(struct buffer *buf, struct link_socket_ac=
tual *from);
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 5=
8f0f28=2E=2E72e71b3 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=
=2Ec
@@ -1171,7 +1171,7 @@
 }
 
 struct tls_multi *
-tls_multi_init(struct =
tls_options *tls_options)
+tls_multi_init(const struct tls_options *tls_opt=
ions)
 {
     struct tls_multi *ret;
 
@@ -1212,7 +1212,7 @@
  */
 
 struct=
 tls_auth_standalone *
-tls_auth_standalone_init(struct tls_options *tls_op=
tions, struct gc_arena *gc)
+tls_auth_standalone_init(const struct tls_opti=
ons *tls_options, struct gc_arena *gc)
 {
     struct tls_auth_standalone *=
tas;
 
@@ -1360,7 +1360,7 @@
 
 static void
 init_epoch_keys(struct key_sta=
te *ks, struct tls_multi *multi, const struct key_type *key_type,
-        =
        bool server, struct key2 *key2)
+                bool server, const=
 struct key2 *key2)
 {
     /* For now we hardcode this to be 4 for the sof=
tware based data channel
      * DCO based implementations/HW implementatio=
n might adjust this number
@@ -1601,8 +1601,9 @@
 
 bool
 tls_session_updat=
e_crypto_params_do_work(struct tls_multi *multi, struct tls_session *sessio=
n,
-                                         struct options *options, struc=
t frame *frame,
-                                         struct frame *fra=
me_fragment, struct link_socket_info *lsi,
+                               =
          const struct options *options, struct frame *frame,
+            =
                             struct frame *frame_fragment,
+               =
                          const struct link_socket_info *lsi,
             =
                             dco_context_t *dco)
 {
     if (session->key[K=
S_PRIMARY]=2Ecrypto_options=2Ekey_ctx_bi=2Einitialized)
@@ -1671,7 +1672,7 =
@@
 bool
 tls_session_update_crypto_params(struct tls_multi *multi, struct =
tls_session *session,
                                  struct options *opt=
ions, struct frame *frame,
-                                 struct frame *=
frame_fragment, struct link_socket_info *lsi,
+                            =
     struct frame *frame_fragment, const struct link_socket_info *lsi,
    =
                              dco_context_t *dco)
 {
     if (!check_sessio=
n_cipher(session, options))
@@ -1887,7 +1888,8 @@
 }
 
 static bool
-push_p=
eer_info_peerid(struct buffer *out, struct tls_multi *multi, struct tls_ses=
sion *session)
+push_peer_info_peerid(struct buffer *out, const struct tls_=
multi *multi,
+                      const struct tls_session *session)
 {
=
     if (multi->rx_peer_id =3D=3D MAX_PEER_ID || session->opt->dco_enabled)=

     {
@@ -1922,7 +1924,7 @@
  * @return          true if no error was enc=
ountered
  */
 static bool
-push_peer_info(struct buffer *buf, struct tls_m=
ulti *multi, struct tls_session *session)
+push_peer_info(struct buffer *bu=
f, const struct tls_multi *multi, struct tls_session *session)
 {
     stru=
ct gc_arena gc =3D gc_new();
     bool ret =3D false;
@@ -2566,8 +2568,8 @@=

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
@@ -2=
785,7 +2787,7 @@
 
 static bool
 check_outgoing_ciphertext(struct key_state=
 *ks, struct tls_session *session,
-                          struct buffer=
 *to_link, bool *continue_tls_process)
+                          const str=
uct buffer *to_link, bool *continue_tls_process)
 {
     if (to_link->len)
=
     {
@@ -4126,7 +4128,7 @@
 }
 
 void
-tls_post_encrypt(struct tls_multi =
*multi, struct buffer *buf)
+tls_post_encrypt(struct tls_multi *multi, cons=
t struct buffer *buf)
 {
     struct key_state *ks =3D multi->save_ks;
    =
 multi->save_ks =3D NULL;
@@ -4257,7 +4259,7 @@
  * into a garbage collecta=
ble string which is returned=2E
  */
 const char *
-protocol_dump(struct bu=
ffer *buffer, unsigned int flags, struct gc_arena *gc)
+protocol_dump(const=
 struct buffer *buffer, unsigned int flags, struct gc_arena *gc)
 {
     st=
ruct buffer out =3D alloc_buf_gc(256, gc);
     struct buffer buf =3D *buff=
er;
diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 7ddf965=2E=
=2E93e6200 100644
--- a/src/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -1=
66,7 +166,7 @@
  *
  * @return A newly allocated and initialized \c tls_mul=
ti structure=2E
  */
-struct tls_multi *tls_multi_init(struct tls_options *=
tls_options);
+struct tls_multi *tls_multi_init(const struct tls_options *t=
ls_options);
 
 /**
  * Finalize initialization of a \c tls_multi structure=
=2E
@@ -187,7 +187,7 @@
 /*
  * Initialize a standalone tls-auth verificati=
on object=2E
  */
-struct tls_auth_standalone *tls_auth_standalone_init(str=
uct tls_options *tls_options,
+struct tls_auth_standalone *tls_auth_standal=
one_init(const struct tls_options *tls_options,
                           =
                           struct gc_arena *gc);
 
 /**
@@ -371,7 +371,7 @@=

  * @param multi - The TLS state for this packet's destination VPN tunnel=
=2E
  * @param buf - The buffer containing the outgoing packet=2E
  */
-voi=
d tls_post_encrypt(struct tls_multi *multi, struct buffer *buf);
+void tls_=
post_encrypt(struct tls_multi *multi, const struct buffer *buf);
 
 /** @} =
name Functions for managing security parameter state for data channel packe=
ts */
 
@@ -461,7 +461,8 @@
  */
 bool tls_session_update_crypto_params(str=
uct tls_multi *multi, struct tls_session *session,
                        =
               struct options *options, struct frame *frame,
-             =
                         struct frame *frame_fragment, struct link_socket_i=
nfo *lsi,
+                                      struct frame *frame_fragme=
nt,
+                                      const struct link_socket_info *l=
si,
                                       dco_context_t *dco);
 
 /*
@@ -5=
25,7 +526,7 @@
 #define PD_VERBOSE                 (1 << 10)
 #define PD_TL=
S_CRYPT               (1 << 11)
 
-const char *protocol_dump(struct buffer =
*buffer, unsigned int flags, struct gc_arena *gc);
+const char *protocol_du=
mp(const struct buffer *buffer, unsigned int flags, struct gc_arena *gc);
 =

 /*
  * debugging code
@@ -573,7 +574,7 @@
 /* Special method to skip the =
three way handshake RESET stages=2E This is
  * used by the HMAC code when =
seeing a packet that matches the previous
  * HMAC based stateless server s=
tate */
-bool session_skip_to_pre_start(struct tls_session *session, struct=
 tls_pre_decrypt_state *state,
-                               struct link_=
socket_actual *from);
+bool session_skip_to_pre_start(struct tls_session *s=
ession, const struct tls_pre_decrypt_state *state,
+                       =
        const struct link_socket_actual *from);
 
 #endif /* ifndef OPENVPN=
_SSL_H */
diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backen=
d=2Eh
index a6d57f2=2E=2E29e07a6 100644
--- a/src/openvpn/ssl_backend=2Eh
+=
++ b/src/openvpn/ssl_backend=2Eh
@@ -137,7 +137,7 @@
  *
  * @return      t=
rue if the context is initialised, false if not=2E
  */
-bool tls_ctx_initi=
alised(struct tls_root_ctx *ctx);
+bool tls_ctx_initialised(const struct tl=
s_root_ctx *ctx);
 
 /**
  * Set any library specific options=2E
@@ -170,7 =
+170,7 @@
  * @param ciphers       String containing : delimited cipher nam=
es, or NULL to use
  *                                      sane defaults=
=2E
  */
-void tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, con=
st char *ciphers);
+void tls_ctx_restrict_ciphers_tls13(const struct tls_ro=
ot_ctx *ctx, const char *ciphers);
 
 /**
  * Set the TLS certificate profi=
le=2E  The profile defines which crypto
diff --git a/src/openvpn/ssl_mbedtl=
s=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index c92c423=2E=2Ecddf856 100644
--- a=
/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -146,7 +1=
46,7 @@
 }
 
 bool
-tls_ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_=
initialised(const struct tls_root_ctx *ctx)
 {
     /* either this should b=
e NULL or should be non-null and then have a
      * valid TLS ctx inside a=
s well */
@@ -269,7 +269,7 @@
 }
 
 void
-tls_ctx_restrict_ciphers_tls13(st=
ruct tls_root_ctx *ctx, const char *ciphers)
+tls_ctx_restrict_ciphers_tls1=
3(const struct tls_root_ctx *ctx, const char *ciphers)
 {
     if (ciphers =
=3D=3D NULL)
     {
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/=
ssl_openssl=2Ec
index 7cfe9f4=2E=2Ecb3de65 100644
--- a/src/openvpn/ssl_ope=
nssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -129,7 +129,7 @@
 }
 
 bool
-=
tls_ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(const st=
ruct tls_root_ctx *ctx)
 {
     /* either this should be NULL or should be =
non-null and then have a
      * valid TLS ctx inside as well */
@@ -446,7 =
+446,7 @@
 #endif
 
 void
-tls_ctx_restrict_ciphers_tls13(struct tls_root_c=
tx *ctx, const char *ciphers)
+tls_ctx_restrict_ciphers_tls13(const struct =
tls_root_ctx *ctx, const char *ciphers)
 {
     if (ciphers =3D=3D NULL)
  =
   {
@@ -1093,7 +1093,7 @@
 }
 
 static void
-tls_ctx_load_cert_uri(struct =
tls_root_ctx *tls_ctx, const char *uri)
+tls_ctx_load_cert_uri(const struct=
 tls_root_ctx *tls_ctx, const char *uri)
 {
 #if defined(HAVE_OPENSSL_STORE=
_API)
     X509 *x =3D NULL;
@@ -2008,7 +2008,7 @@
 }
 
 static void
-bio_d=
ebug_data(const char *mode, BIO *bio, const uint8_t *buf, int len, const ch=
ar *desc)
+bio_debug_data(const char *mode, const BIO *bio, const uint8_t *=
buf, int len, const char *desc)
 {
     struct gc_arena gc =3D gc_new();
  =
   if (len > 0)
@@ -2022,7 +2022,7 @@
 }
 
 static void
-bio_debug_oc(const=
 char *mode, BIO *bio)
+bio_debug_oc(const char *mode, const BIO *bio)
 {
 =
    open_biofp();
     fprintf(biofp, "BIO %s time=3D%" PRIi64 " bio=3D" pt=
r_format "\n", mode, (int64_t)time(NULL),
diff --git a/src/openvpn/ssl_pkt=
=2Ec b/src/openvpn/ssl_pkt=2Ec
index 90b2aec=2E=2E60b005f 100644
--- a/src/=
openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -118,7 +118,7 @@
  */
=
 static void
 tls_wrap_control(struct tls_wrap_ctx *ctx, uint8_t header, st=
ruct buffer *buf,
-                 struct session_id *session_id)
+       =
          const struct session_id *session_id)
 {
     if (ctx->mode =3D=3D=
 TLS_WRAP_AUTH || ctx->mode =3D=3D TLS_WRAP_NONE)
     {
@@ -402,9 +402,9 @=
@
 
 
 struct buffer
-tls_reset_standalone(struct tls_wrap_ctx *ctx, struct=
 tls_auth_standalone *tas,
-                     struct session_id *own_sid=
, struct session_id *remote_sid, uint8_t header,
-                     bool=
 request_resend_wkc)
+tls_reset_standalone(struct tls_wrap_ctx *ctx, const =
struct tls_auth_standalone *tas,
+                     const struct session=
_id *own_sid, const struct session_id *remote_sid,
+                     ui=
nt8_t header, bool request_resend_wkc)
 {
     /* Copy buffer here to point=
 at the same data but allow tls_wrap_control
      * to potentially change =
buf to point to another buffer without
@@ -489,7 +489,7 @@
 bool
 check_ses=
sion_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,
                 =
              const struct openvpn_sockaddr *from,
-                       =
       uint8_t *key,
+                              const uint8_t *key,
   =
                            int handwindow,
                               =
bool pkt_is_ack)
 {
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_=
pkt=2Eh
index 03e8930=2E=2E8203e4a 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++=
 b/src/openvpn/ssl_pkt=2Eh
@@ -183,7 +183,7 @@
  * @return              the=
 expected server session id
  */
 bool check_session_hmac_and_pkt_id(struct=
 tls_pre_decrypt_state *state, const struct openvpn_sockaddr *from,
-      =
                             uint8_t *key, int handwindow, bool pkt_is_ack)=
;
+                                   const uint8_t *key, int handwindow, b=
ool pkt_is_ack);
 
 /*
  * Write a control channel authentication record=2E=

@@ -210,8 +210,9 @@
  * from the tls pre decrypt state=2E
  *
  */
-struct=
 buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_stan=
dalone *tas,
-                                   struct session_id *own_sid=
, struct session_id *remote_sid,
+struct buffer tls_reset_standalone(struct=
 tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,
+               =
                    const struct session_id *own_sid,
+                    =
               const struct session_id *remote_sid,
                       =
             uint8_t header, bool request_resend_wkc);
 
 
diff --git a/src=
/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 3653eb4=2E=2E0e4=
0370 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=
=2Ec
@@ -1139,7 +1139,7 @@
  * cache=2E
  */
 static bool
-tls_authenticati=
on_status_use_cache(struct tls_multi *multi)
+tls_authentication_status_use=
_cache(const struct tls_multi *multi)
 {
     unsigned int idx =3D min_uint=
(multi->tas_cache_num_updates, SIZE(cache_intervals) - 1);
     time_t late=
ncy =3D cache_intervals[idx];
@@ -1283,7 +1283,7 @@
  * Check if the script=
/plugin left a message in the auth failed message
  * file and relay it to =
the user */
 static void
-check_for_client_reason(struct tls_multi *multi, =
struct auth_deferred_status *status)
+check_for_client_reason(struct tls_mu=
lti *multi, const struct auth_deferred_status *status)
 {
     struct gc_ar=
ena gc =3D gc_new();
     const char *msg =3D key_state_check_auth_failed_m=
essage_file(status, &gc);
@@ -1552,7 +1552,7 @@
 #endif /* ifdef ENABLE_MAN=
AGEMENT */
 
 static bool
-set_verify_user_pass_env(struct user_pass *up, s=
truct tls_multi *multi, struct tls_session *session)
+set_verify_user_pass_=
env(const struct user_pass *up, struct tls_multi *multi, struct tls_session=
 *session)
 {
     /* Is username defined? */
     if ((session->opt->ssl_f=
lags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
@@ -1580,7 +1=
580,7 @@
 }
 
 bool
-ssl_verify_username_length(struct tls_session *session=
, const char *username)
+ssl_verify_username_length(const struct tls_sessio=
n *session, const char *username)
 {
     if ((session->opt->ssl_flags & SS=
LF_USERNAME_AS_COMMON_NAME)
         && strlen(username) > TLS_USERNAME_LEN=
)
diff --git a/src/openvpn/ssl_verify=2Eh b/src/openvpn/ssl_verify=2Eh
inde=
x 3176d76=2E=2Ee77bc4a 100644
--- a/src/openvpn/ssl_verify=2Eh
+++ b/src/op=
envpn/ssl_verify=2Eh
@@ -202,7 +202,7 @@
  * @return              true if n=
ame is under limit or username-as-common-name
  *                      is n=
ot active
  */
-bool ssl_verify_username_length(struct tls_session *session=
, const char *username);
+bool ssl_verify_username_length(const struct tls_=
session *session, const char *username);
 
 /**
  * Runs the --client-crres=
ponse script if one is defined=2E
@@ -275,7 +275,7 @@
 void auth_set_client=
_reason(struct tls_multi *multi, const char *client_reason);
 
 static inli=
ne const char *
-tls_client_reason(struct tls_multi *multi)
+tls_client_rea=
son(const struct tls_multi *multi)
 {
     return multi->client_reason;
 }
=
diff --git a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec
index c7d375b=
=2E=2Ecfbc38d 100644
--- a/src/openvpn/status=2Ec
+++ b/src/openvpn/status=
=2Ec
@@ -135,7 +135,7 @@
 }
 
 void
-status_reset(struct status_output *so)=

+status_reset(const struct status_output *so)
 {
     if (so && so->fd >=
=3D 0)
     {
diff --git a/src/openvpn/status=2Eh b/src/openvpn/status=2Eh
=
index 7953a4e=2E=2E4c01d75 100644
--- a/src/openvpn/status=2Eh
+++ b/src/op=
envpn/status=2Eh
@@ -69,7 +69,7 @@
 
 bool status_trigger(struct status_out=
put *so);
 
-void status_reset(struct status_output *so);
+void status_rese=
t(const struct status_output *so);
 
 void status_flush(struct status_outpu=
t *so);
 
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index af48=
921=2E=2Eabb46af 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec=

@@ -835,7 +835,7 @@
          const char *ifconfig_ipv6_local_parm,     /*=
 --ifconfig parm 1 IPv6 */
          int ifconfig_ipv6_netbits_parm,
      =
    const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 IPv6 */
=
-         struct addrinfo *local_public, struct addrinfo *remote_public, co=
nst bool strict_warn,
+         const struct addrinfo *local_public, const =
struct addrinfo *remote_public, const bool strict_warn,
          struct en=
v_set *es, openvpn_net_ctx_t *ctx, struct tuntap *tt)
 {
     if (!tt)
@@ -=
978,7 +978,7 @@
  * -> helper function to simplify code below
  */
 static =
void
-add_route_connected_v6_net(struct tuntap *tt, const struct env_set *e=
s)
+add_route_connected_v6_net(const struct tuntap *tt, const struct env_se=
t *es)
 {
     struct route_ipv6 r6;
 
@@ -1020,7 +1020,7 @@
  */
 
 in_add=
r_t
-create_arbitrary_remote(struct tuntap *tt)
+create_arbitrary_remote(co=
nst struct tuntap *tt)
 {
     in_addr_t remote;
 
@@ -1592,7 +1592,7 @@
 }=

 
 static void
-undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *c=
tx)
+undo_ifconfig_ipv4(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {=

 #if defined(TARGET_LINUX)
     int netbits =3D netmask_to_netbits2(tt->re=
mote_netmask);
@@ -1627,7 +1627,7 @@
 }
 
 static void
-undo_ifconfig_ipv6(=
struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv6(const struct=
 tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     if =
(net_addr_v6_del(ctx, tt->actual_name, &tt->local_ipv6, tt->netbits_ipv6) <=
 0)
@@ -1652,7 +1652,7 @@
 }
 
 void
-undo_ifconfig(struct tuntap *tt, open=
vpn_net_ctx_t *ctx)
+undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx=
_t *ctx)
 {
     if (tt->backend_driver !=3D DRIVER_NULL && tt->backend_dri=
ver !=3D DRIVER_AFUNIX)
     {
@@ -1720,7 +1720,7 @@
 }
 
 static ssize_t
-=
write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
+write_tun_heade=
r(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     if (tt->typ=
e =3D=3D DEV_TYPE_TUN)
     {
@@ -1737,9 +1737,11 @@
             type =3D =
htonl(AF_INET);
         }
 
+        /* argument to writev is a pointer to=
 const but we still need to drop
+         * the const from buf pointer her=
e */
         iv[0]=2Eiov_base =3D &type;
         iv[0]=2Eiov_len =3D size=
of(type);
-        iv[1]=2Eiov_base =3D buf;
+        iv[1]=2Eiov_base =3D =
(void *)buf;
         iv[1]=2Eiov_len =3D len;
 
         return header_mod=
ify_read_write_return(writev(tt->fd, iv, 2));
@@ -1751,7 +1753,7 @@
 }
 
 s=
tatic ssize_t
-read_tun_header(struct tuntap *tt, uint8_t *buf, int len)
+r=
ead_tun_header(const struct tuntap *tt, uint8_t *buf, int len)
 {
     if (=
tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1777,13 +1779,13 @@
  */
 #if !def=
ined(TARGET_DARWIN)
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, in=
t len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
=
     return write_tun_header(tt, buf, len);
 }
 
 ssize_t
-read_tun(struct =
tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8=
_t *buf, int len)
 {
     return read_tun_header(tt, buf, len);
 }
@@ -1799=
,7 +1801,7 @@
 
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
 stat=
ic bool
-tun_dco_enabled(struct tuntap *tt)
+tun_dco_enabled(const struct t=
untap *tt)
 {
     return tt->backend_driver =3D=3D DRIVER_DCO;
 }
@@ -2046=
,13 +2048,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, i=
nt len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {=

     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap=
 *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *bu=
f, int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -2251,13 +2253,13 =
@@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+writ=
e_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     return =
write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t=
 *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 =
{
     return read(tt->fd, buf, len);
 }
@@ -2587,7 +2589,7 @@
 }
 
 ssize_=
t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const str=
uct tuntap *tt, const uint8_t *buf, int len)
 {
     struct strbuf sbuf;
  =
   sbuf=2Elen =3D len;
@@ -2596,7 +2598,7 @@
 }
 
 ssize_t
-read_tun(struct=
 tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint=
8_t *buf, int len)
 {
     struct strbuf sbuf;
     int f =3D 0;
@@ -3094,7=
 +3096,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int l=
en)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
   =
  if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
@@ -3107,7 +3109,7 @@
 =
}
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(=
const struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->backend_dri=
ver =3D=3D DRIVER_UTUN)
     {
@@ -3311,7 +3313,7 @@
 }
 
 int
-tun_write_q=
ueue(struct tuntap *tt, struct buffer *buf)
+tun_write_queue(struct tuntap =
*tt, const struct buffer *buf)
 {
     if (tt->writes=2Eiostate =3D=3D IOST=
ATE_INITIAL)
     {
@@ -3366,7 +3368,7 @@
 }
 
 int
-tun_write_win32(struct=
 tuntap *tt, struct buffer *buf)
+tun_write_win32(struct tuntap *tt, const =
struct buffer *buf)
 {
     int err =3D 0;
     int status =3D 0;
@@ -5374,=
7 +5376,7 @@
 }
 
 void
-fork_register_dns_action(struct tuntap *tt)
+fork_=
register_dns_action(const struct tuntap *tt)
 {
     if (tt && tt->options=
=2Eregister_dns && tt->options=2Emsg_channel)
     {
@@ -5464,7 +5466,7 @@
=
 }
 
 static void
-tuntap_get_mtu(struct tuntap *tt)
+tuntap_get_mtu(const =
struct tuntap *tt)
 {
     ULONG mtu =3D 0;
     DWORD len;
@@ -6039,7 +604=
1,7 @@
 }
 
 void
-tun_show_debug(struct tuntap *tt)
+tun_show_debug(const =
struct tuntap *tt)
 {
     if (tt->backend_driver =3D=3D WINDOWS_DRIVER_TAP=
_WINDOWS6)
     {
diff --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
in=
dex 2477560=2E=2E0ff2a0b 100644
--- a/src/openvpn/tun=2Eh
+++ b/src/openvpn=
/tun=2Eh
@@ -272,9 +272,9 @@
 
 void close_tun_handle(struct tuntap *tt);
 =

-ssize_t write_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t wri=
te_tun(const struct tuntap *tt, const uint8_t *buf, int len);
 
-ssize_t re=
ad_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t read_tun(const s=
truct tuntap *tt, uint8_t *buf, int len);
 
 #ifdef ENABLE_FEATURE_TUN_PERS=
IST
 void tuncfg(const char *dev, const char *dev_type, const char *dev_nod=
e, int persist_mode,
@@ -293,7 +293,7 @@
                         const cha=
r *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */
           =
              int ifconfig_ipv6_netbits_parm,           /* --ifconfig parm =
1 / bits */
                         const char *ifconfig_ipv6_remote_parm,=
    /* --ifconfig parm 2 / IPv6 */
-                        struct addrinfo=
 *local_public, struct addrinfo *remote_public,
+                        co=
nst struct addrinfo *local_public, const struct addrinfo *remote_public,
  =
                       const bool strict_warn, struct env_set *es, openvpn_=
net_ctx_t *ctx,
                         struct tuntap *tt);
 
@@ -320,7 +3=
20,7 @@
  * @param tt    the tuntap interface context
  * @param ctx   the =
networking API opaque context
  */
-void undo_ifconfig(struct tuntap *tt, o=
penvpn_net_ctx_t *ctx);
+void undo_ifconfig(const struct tuntap *tt, openvp=
n_net_ctx_t *ctx);
 
 bool is_dev_type(const char *dev, const char *dev_typ=
e, const char *match_type);
 
@@ -351,7 +351,7 @@
 #define IFCONFIG_DEFAULT=
 IFCONFIG_AFTER_TUN_OPEN
 
 static inline int
-ifconfig_order(struct tuntap=
 *tt)
+ifconfig_order(const struct tuntap *tt)
 {
     if (tt->backend_driv=
er =3D=3D DRIVER_AFUNIX)
     {
@@ -381,7 +381,7 @@
 #define ROUTE_ORDER_DE=
FAULT ROUTE_AFTER_TUN
 
 static inline int
-route_order(struct tuntap *tt)
=
+route_order(const struct tuntap *tt)
 {
     if (tt->backend_driver =3D=3D=
 DRIVER_AFUNIX)
     {
@@ -454,13 +454,13 @@
 
 const char *tap_win_getinfo=
(const struct tuntap *tt, struct gc_arena *gc);
 
-void tun_show_debug(stru=
ct tuntap *tt);
+void tun_show_debug(const struct tuntap *tt);
 
 bool dhcp=
_release_by_adapter_index(const DWORD adapter_index);
 
 bool dhcp_renew_by=
_adapter_index(const DWORD adapter_index);
 
-void fork_register_dns_action=
(struct tuntap *tt);
+void fork_register_dns_action(const struct tuntap *tt=
);
 
 void ipconfig_register_dns(const struct env_set *es);
 
@@ -470,7 +47=
0,7 @@
 
 int tun_read_queue(struct tuntap *tt, int maxsize);
 
-int tun_wr=
ite_queue(struct tuntap *tt, struct buffer *buf);
+int tun_write_queue(stru=
ct tuntap *tt, const struct buffer *buf);
 
 static inline bool
 tuntap_sto=
p(int status)
@@ -499,7 +499,7 @@
     return false;
 }
 
-int tun_write_wi=
n32(struct tuntap *tt, struct buffer *buf);
+int tun_write_win32(struct tun=
tap *tt, const struct buffer *buf);
 
 static inline bool
 is_ip_packet_val=
id(const struct buffer *buf)
@@ -529,13 +529,13 @@
 }
 
 static inline bool=

-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(const struct tunt=
ap *tt)
 {
     return tt && tt->backend_driver =3D=3D DRIVER_DCO;
 }
 
 st=
atic inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t stat=
us)
+tuntap_is_dco_win_timeout(const struct tuntap *tt, ssize_t status)
 {
=
     return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno() =3D=
=3D ERROR_NETNAME_DELETED);
 }
@@ -555,25 +555,25 @@
 }
 
 static inline vo=
id
-tun_standby_init(struct tuntap *tt)
+tun_standby_init(const struct tunt=
ap *tt)
 {
 }
 
 static inline bool
-tun_standby(struct tuntap *tt)
+tun_st=
andby(const struct tuntap *tt)
 {
     return true;
 }
 
 
 static inline b=
ool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(const struct t=
untap *tt)
 {
     return false;
 }
 
 static inline bool
-tuntap_is_dco_wi=
n_timeout(struct tuntap *tt, ssize_t status)
+tuntap_is_dco_win_timeout(con=
st struct tuntap *tt, ssize_t status)
 {
     return false;
 }
diff --git a=
/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec
index a67a472=2E=
=2Ee9223bc 100644
--- a/src/openvpn/tun_afunix=2Ec
+++ b/src/openvpn/tun_af=
unix=2Ec
@@ -48,7 +48,7 @@
 
 
 static void
-tun_afunix_exec_child(const ch=
ar *dev_node, struct tuntap *tt, struct env_set *env)
+tun_afunix_exec_chil=
d(const char *dev_node, struct tuntap *tt, const struct env_set *env)
 {
  =
   const char *msgprefix =3D "ERROR: failure executing process for tun:";
 =
    struct argv argv =3D argv_new();
@@ -73,7 +73,7 @@
 }
 
 void
-open_tun=
_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set *orig=
_env)
+open_tun_afunix(const struct options *o, int mtu, struct tuntap *tt,=
 const struct env_set *orig_env)
 {
     struct gc_arena gc =3D gc_new();
 =

diff --git a/src/openvpn/tun_afunix=2Eh b/src/openvpn/tun_afunix=2Eh
index=
 5b6a8e0=2E=2Efb88eb2 100644
--- a/src/openvpn/tun_afunix=2Eh
+++ b/src/ope=
nvpn/tun_afunix=2Eh
@@ -31,7 +31,7 @@
  * the user provided taking care of =
implementing the actual tun
  * device=2E
  */
-void open_tun_afunix(struct=
 options *o, int mtu, struct tuntap *tt, struct env_set *env);
+void open_t=
un_afunix(const struct options *o, int mtu, struct tuntap *tt, const struct=
 env_set *env);
 
 
 /**
diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vl=
an=2Ec
index 69ac10d=2E=2E04e18d6 100644
--- a/src/openvpn/vlan=2Ec
+++ b/s=
rc/openvpn/vlan=2Ec
@@ -288,7 +288,7 @@
 }
 
 void
-vlan_process_outgoing_t=
un(struct multi_context *m, struct multi_instance *mi)
+vlan_process_outgoi=
ng_tun(const struct multi_context *m, struct multi_instance *mi)
 {
     if=
 (!m->top=2Eoptions=2Evlan_tagging)
     {
diff --git a/src/openvpn/vlan=2E=
h b/src/openvpn/vlan=2Eh
index 9389f89=2E=2Ecd2f66f 100644
--- a/src/openvp=
n/vlan=2Eh
+++ b/src/openvpn/vlan=2Eh
@@ -35,6 +35,6 @@
 
 bool vlan_is_tag=
ged(const struct buffer *buf);
 
-void vlan_process_outgoing_tun(struct mul=
ti_context *m, struct multi_instance *mi);
+void vlan_process_outgoing_tun(=
const struct multi_context *m, struct multi_instance *mi);
 
 #endif /* VLA=
N_H */
diff --git a/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh
index 8be=
3d96=2E=2E39ff7d8 100644
--- a/src/openvpn/win32=2Eh
+++ b/src/openvpn/win3=
2=2Eh
@@ -227,7 +227,7 @@
 void overlapped_io_close(struct overlapped_io *o=
);
 
 static inline bool
-overlapped_io_active(struct overlapped_io *o)
+ov=
erlapped_io_active(const struct overlapped_io *o)
 {
     return o->iostate=
 =3D=3D IOSTATE_QUEUED || o->iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;
 }
di=
ff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsic=
a=2Ec
index a861e8a=2E=2E25fa1e4 100644
--- a/src/openvpnmsica/openvpnmsica=
=2Ec
+++ b/src/openvpnmsica/openvpnmsica=2Ec
@@ -77,7 +77,7 @@
  * @return =
ERROR_SUCCESS on success; An error code otherwise
  */
 static UINT
-setup_=
sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ struct ms=
ica_arg_seq *seq)
+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR s=
zProperty, _In_ const struct msica_arg_seq *seq)
 {
     UINT uiResult;
   =
  LPWSTR szSequence =3D msica_arg_seq_join(seq);
diff --git a/src/openvpnse=
rv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 7819f5a=2E=2Ed5a=
2fd0 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/int=
eractive=2Ec
@@ -522,7 +522,7 @@
 
 
 static SOCKADDR_INET
-sockaddr_inet(s=
hort family, inet_address_t *addr)
+sockaddr_inet(short family, const inet_=
address_t *addr)
 {
     SOCKADDR_INET sa_inet;
     ZeroMemory(&sa_inet, s=
izeof(sa_inet));
diff --git a/tests/unit_tests/openvpn/mock_management=2Ec =
b/tests/unit_tests/openvpn/mock_management=2Ec
index 77f6ce2=2E=2Efff4c2b 1=
00644
--- a/tests/unit_tests/openvpn/mock_management=2Ec
+++ b/tests/unit_t=
ests/openvpn/mock_management=2Ec
@@ -36,7 +36,7 @@
 struct management *mana=
gement; /* GLOBAL */
 
 void
-management_auth_failure(struct management *ma=
n, const char *type, const char *reason)
+management_auth_failure(const str=
uct management *man, const char *type, const char *reason)
 {
     ASSERT(f=
alse);
 }
diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests=
/unit_tests/openvpn/siphash_openssl=2Ec
index c301f2d=2E=2E99a7763 100644
-=
-- a/tests/unit_tests/openvpn/siphash_openssl=2Ec
+++ b/tests/unit_tests/op=
envpn/siphash_openssl=2Ec
@@ -101,7 +101,7 @@
 bool
 siphash_openssl_availa=
ble(void *sip_context)
 {
-    struct siphash_context *sip =3D sip_context;=

+    const struct siphash_context *sip =3D sip_context;
 
     return (boo=
l)(sip->mac);
 }
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/test=
s/unit_tests/openvpn/test_misc=2Ec
index a41c27b=2E=2Ea8daee6 100644
--- a/=
tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_=
misc=2Ec
@@ -146,7 +146,7 @@
 }
 
 static struct hash_element *
-hash_looku=
p_by_value(struct hash *hash, void *value)
+hash_lookup_by_value(struct has=
h *hash, const void *value)
 {
     struct hash_iterator hi;
     struct ha=
sh_element *he;
diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/=
tests/unit_tests/openvpn/test_user_pass=2Ec
index c0a0866=2E=2E7636a33 1006=
44
--- a/tests/unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests=
/openvpn/test_user_pass=2Ec
@@ -59,7 +59,7 @@
     return mock();
 }
 void
=
-management_auth_failure(struct management *man, const char *type, const ch=
ar *reason)
+management_auth_failure(const struct management *man, const ch=
ar *type, const char *reason)
 {
     assert_true(0);
 }

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b=
116f58
Gerrit-Change-Number: 1663
Gerrit-PatchSet: 22
Gerrit-Owner: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2E=
org>

--an5raqUDWxU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld <strong>up=
loaded patch set #22</strong> to this change=2E</p><p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></p><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">Remove instances of constParameterPointer cppcheck warnings<br><br>=
This requires a few suppressions since cppcheck<br>doesn&#39;t quite unders=
tand the different code-paths<br>implemented by preprocessor defines=2E<br>=
<br>Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/cpp=
check-suppression<br>M sample/sample-plugins/client-connect/sample-client-c=
onnect=2Ec<br>M sample/sample-plugins/defer/multi-auth=2Ec<br>M sample/samp=
le-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec<br>M sr=
c/openvpn/buffer=2Eh<br>M src/openvpn/clinat=2Ec<br>M src/openvpn/comp=2Ec<=
br>M src/openvpn/comp=2Eh<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/cryp=
to=2Eh<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/d=
co_freebsd=2Ec<br>M src/openvpn/dco_internal=2Eh<br>M src/openvpn/dco_linux=
=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/error=2Ec<br>M src/openv=
pn/error=2Eh<br>M src/openvpn/event=2Eh<br>M src/openvpn/forward=2Ec<br>M s=
rc/openvpn/forward=2Eh<br>M src/openvpn/init=2Ec<br>M src/openvpn/init=2Eh<=
br>M src/openvpn/interval=2Eh<br>M src/openvpn/list=2Ec<br>M src/openvpn/li=
st=2Eh<br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/ope=
nvpn/mbuf=2Ec<br>M src/openvpn/mbuf=2Eh<br>M src/openvpn/mss=2Ec<br>M src/o=
penvpn/mss=2Eh<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mtcp=2Eh<br>M src=
/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>=
M src/openvpn/multi_io=2Ec<br>M src/openvpn/networking=2Eh<br>M src/openvpn=
/networking_iproute2=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M src/ope=
nvpn/occ=2Eh<br>M src/openvpn/openssl_compat=2Eh<br>M src/openvpn/options=
=2Ec<br>M src/openvpn/options_parse=2Ec<br>M src/openvpn/otime=2Ec<br>M src=
/openvpn/otime=2Eh<br>M src/openvpn/proto=2Eh<br>M src/openvpn/proxy=2Ec<br=
>M src/openvpn/proxy=2Eh<br>M src/openvpn/ps=2Ec<br>M src/openvpn/ps=2Eh<br=
>M src/openvpn/push=2Ec<br>M src/openvpn/push=2Eh<br>M src/openvpn/push_uti=
l=2Ec<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/reliable=2Eh<br>M src/=
openvpn/route=2Ec<br>M src/openvpn/schedule=2Ec<br>M src/openvpn/socket=2Ec=
<br>M src/openvpn/socket=2Eh<br>M src/openvpn/socket_util=2Eh<br>M src/open=
vpn/socks=2Ec<br>M src/openvpn/socks=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/=
openvpn/ssl=2Eh<br>M src/openvpn/ssl_backend=2Eh<br>M src/openvpn/ssl_mbedt=
ls=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M s=
rc/openvpn/ssl_pkt=2Eh<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/ssl=
_verify=2Eh<br>M src/openvpn/status=2Ec<br>M src/openvpn/status=2Eh<br>M sr=
c/openvpn/tun=2Ec<br>M src/openvpn/tun=2Eh<br>M src/openvpn/tun_afunix=2Ec<=
br>M src/openvpn/tun_afunix=2Eh<br>M src/openvpn/vlan=2Ec<br>M src/openvpn/=
vlan=2Eh<br>M src/openvpn/win32=2Eh<br>M src/openvpnmsica/openvpnmsica=2Ec<=
br>M src/openvpnserv/interactive=2Ec<br>M tests/unit_tests/openvpn/mock_man=
agement=2Ec<br>M tests/unit_tests/openvpn/siphash_openssl=2Ec<br>M tests/un=
it_tests/openvpn/test_misc=2Ec<br>M tests/unit_tests/openvpn/test_user_pass=
=2Ec<br>88 files changed, 345 insertions(+), 289 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/63/1663/22</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/dev-to=
ols/cppcheck-suppression</span><br><span>index 299d7a3=2E=2E6ac2fe5 100644<=
/span><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b/=
dev-tools/cppcheck-suppression</span><br><span>@@ -2,7 +2,6 @@</span><br><s=
pan> # occurences right now=2E They still should be fixed at some point</sp=
an><br><span> constParameter</span><br><span> constParameterCallback</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-constParameterPointer</span>=
<br><span> invalidPrintfArgType_sint</span><br><span> invalidPrintfArgType_=
uint</span><br><span> unusedFunction</span><br><span>@@ -26,11 +25,54 @@</s=
pan><br><span> # FP: posix=2Ecfg claims suseconds_t is unsigned for some re=
ason</span><br><span> unsignedLessThanZero:src/openvpn/otime=2Eh:148</span>=
<br><span> # IGN: multi code does weird things with pointers to local varia=
bles=2E=2E=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-autoVari=
ables:src/openvpn/multi=2Ec:4242</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+autoVariables:src/openvpn/multi=2Ec:4243</span><br><span> auto=
Variables:src/openvpn/multi_io=2Ec:324</span><br><span> # IGN: the code hea=
der =3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is used intentionally</span><b=
r><span> badBitmaskCheck:src/openvpn/mudp=2Ec</span><br><span> badBitmaskCh=
eck:tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# IGN: we store integers in pointers</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+CastAddressToIntegerAtReturn:src/ope=
nvpn/multi=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN=
: external</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constPara=
meterPointer:/usr/include/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# IGN: test files provide mocks/stubs that match prototypes from he=
aders exactly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constP=
arameterPointer:tests/unit_tests/openvpn/mock_*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+constParameterPointer:tests/unit_tests/openvpn/=
test_*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParamete=
rPointer:tests/unit_tests/openvpnserv/test_*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# FP: different crypto implementations but same AP=
I</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPoin=
ter:src/openvpn/crypto_mbedtls=2Ec:81</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+constParameterPointer:src/openvpn/crypto_mbedtls=2Ec:333<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointe=
r:src/openvpn/crypto_mbedtls_legacy=2Ec:85</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/crypto_openssl=2Ec=
:173</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterP=
ointer:src/openvpn/crypto_openssl=2Ec:1433</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/cryptoapi=2Ec:58</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer=
:src/openvpn/ssl_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+constParameterPointer:src/openvpn/ssl_openssl=2Ec</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/ss=
l_verify_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+constParameterPointer:tests/unit_tests/openvpn/siphash_openssl=2Ec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: too many different i=
mplementations, not worth it</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+constParameterPointer:src/openvpn/dco*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/socket=2E*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: parameters are m=
odified on some platform only</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+constParameterPointer:src/openvpn/dns=2Ec:859</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/error=
=2Ec:223</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParame=
terPointer:src/openvpn/forward=2Ec:1245</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+constParameterPointer:src/openvpn/manage=2Ec:344</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/=
openvpn/manage=2Ec:3329</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+constParameterPointer:src/openvpn/misc=2Ec:793</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/misc=2Ec:8=
13</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPoi=
nter:src/openvpn/options=2Ec:2578</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+constParameterPointer:src/openvpn/options=2Ec:3205</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/open=
vpn/route=2Ec:3947</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
onstParameterPointer:src/openvpn/tun=2Ec:560</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/tun=2Ec:2188</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:s=
rc/openvpn/tun_afunix=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# IGN: not a FP but the documentation for the FP_ISSET claims this is=
 not const=2E=2E=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
constParameterPointer:src/openvpn/event=2Ec:1015</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# FP: we play around with const in the interfa=
ce too much</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# also h=
ides: fun:check_malloc_return: causes -Wmaybe-uninitialized in MinGW Debug =
build</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameter=
Pointer:src/openvpn/buffer=2Eh</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# FP: const silently removed due to pointer arithmentic</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/op=
envpn/buffer=2Ec:273</span><br><span> # IGN: Windows specific (unsigned lon=
g =3D=3D unsigned int)</span><br><span> compareValueOutOfTypeRangeError:src=
/openvpn/ssl_verify=2Ec:928</span><br><span> # FP: cppcheck seems to have w=
rong signature of DeviceIoControl()</span><br><span>diff --git a/sample/sam=
ple-plugins/client-connect/sample-client-connect=2Ec b/sample/sample-plugin=
s/client-connect/sample-client-connect=2Ec</span><br><span>index 420de61=2E=
=2Ecbd98e8 100644</span><br><span>--- a/sample/sample-plugins/client-connec=
t/sample-client-connect=2Ec</span><br><span>+++ b/sample/sample-plugins/cli=
ent-connect/sample-client-connect=2Ec</span><br><span>@@ -344,7 +344,7 @@</=
span><br><span> }</span><br><span> </span><br><span> int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-openvpn_plugin_client_connect(struct plu=
gin_context *context, const char **argv, const char **envp)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_client_connect(const=
 struct plugin_context *context, const char **argv, const char **envp)</spa=
n><br><span> {</span><br><span>     /* log environment variables handed to =
us by OpenVPN, but</span><br><span>      * only if &quot;setenv verb&quot; =
is 3 or higher (arbitrary number)</span><br><span>@@ -465,7 +465,7 @@</span=
><br><span> </span><br><span> int</span><br><span> openvpn_plugin_client_co=
nnect_defer_v2(struct plugin_context *context,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                       struct plug=
in_per_client_context *pcc,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                       const struct plugin_per_clie=
nt_context *pcc,</span><br><span>                                        st=
ruct openvpn_plugin_string_list **return_list)</span><br><span> {</span><br=
><span>     time_t time_left =3D pcc-&gt;sleep_until - time(NULL);</span><b=
r><span>diff --git a/sample/sample-plugins/defer/multi-auth=2Ec b/sample/sa=
mple-plugins/defer/multi-auth=2Ec</span><br><span>index bacf557=2E=2Ecdd616=
f 100644</span><br><span>--- a/sample/sample-plugins/defer/multi-auth=2Ec</=
span><br><span>+++ b/sample/sample-plugins/defer/multi-auth=2Ec</span><br><=
span>@@ -255,7 +255,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_aut=
h_user_pass(struct plugin_context *context, const char *username, const cha=
r *password)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_auth=
_user_pass(const struct plugin_context *context, const char *username, cons=
t char *password)</span><br><span> {</span><br><span>     plog(context, PLO=
G_NOTE, &quot;expect_user=3D%s, received_user=3D%s, expect_passw=3D%s, rece=
ived_passw=3D%s&quot;,</span><br><span>          np(context-&gt;test_valid_=
user), np(username), np(context-&gt;test_valid_pass), np(password));</span>=
<br><span>@@ -279,7 +279,7 @@</span><br><span> </span><br><span> </span><br=
><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-aut=
h_user_pass_verify(struct plugin_context *context, struct plugin_per_client=
_context *pcc,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+auth_=
user_pass_verify(const struct plugin_context *context, struct plugin_per_cl=
ient_context *pcc,</span><br><span>                       const char *argv[=
], const char *envp[])</span><br><span> {</span><br><span>     /* get usern=
ame/password from envp string array */</span><br><span>diff --git a/sample/=
sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec b/s=
ample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=
=2Ec</span><br><span>index 25c9ff5=2E=2E512861a 100644</span><br><span>--- =
a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporte=
r=2Ec</span><br><span>+++ b/sample/sample-plugins/keying-material-exporter-=
demo/keyingmaterialexporter=2Ec</span><br><span>@@ -186,7 +186,7 @@</span><=
br><span> }</span><br><span> </span><br><span> static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-file_store(char *file, char *content)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+file_store(const cha=
r *file, const char *content)</span><br><span> {</span><br><span>     FILE =
*f;</span><br><span>     if (!(f =3D fopen(file, &quot;w+&quot;)))</span><b=
r><span>@@ -202,7 +202,7 @@</span><br><span> server_store(struct openvpn_pl=
ugin_args_func_in const *args)</span><br><span> {</span><br><span>     stru=
ct plugin *plugin =3D (struct plugin *)args-&gt;handle;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct session *sess =3D (struct sess=
ion *)args-&gt;per_client_context;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct session *sess =3D (struct session *)args-&g=
t;per_client_context;</span><br><span> </span><br><span>     char file[MAXP=
ATH];</span><br><span>     snprintf(file, sizeof(file) - 1, &quot;/tmp/open=
vpn_sso_%s&quot;, sess-&gt;key);</span><br><span>@@ -214,7 +214,7 @@</span>=
<br><span> client_store(struct openvpn_plugin_args_func_in const *args)</sp=
an><br><span> {</span><br><span>     struct plugin *plugin =3D (struct plug=
in *)args-&gt;handle;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct session *sess =3D (struct session *)args-&gt;per_client_context;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct se=
ssion *sess =3D (struct session *)args-&gt;per_client_context;</span><br><s=
pan> </span><br><span>     char *file =3D &quot;/tmp/openvpn_sso_user&quot;=
;</span><br><span>     ovpn_note(&quot;app session file: %s&quot;, file);</=
span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh=
</span><br><span>index 22a8b74=2E=2E44ed434 100644</span><br><span>--- a/sr=
c/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br=
><span>@@ -1918,7 +1918,7 @@</span><br><span>  * @param a  The arena to tes=
t=2E</span><br><span>  */</span><br><span> static inline bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-gc_defined(struct gc_arena *a)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+gc_defined(const struct =
gc_arena *a)</span><br><span> {</span><br><span>     return a-&gt;list !=3D=
 NULL;</span><br><span> }</span><br><span>diff --git a/src/openvpn/clinat=
=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index 3724022=2E=2E9fa8f5f 10=
0644</span><br><span>--- a/src/openvpn/clinat=2Ec</span><br><span>+++ b/src=
/openvpn/clinat=2Ec</span><br><span>@@ -159,7 +159,7 @@</span><br><span> #e=
ndif</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-print_pkt(struct openvpn_iphdr *iph, const =
char *prefix, const int direction, const msglvl_t msglevel)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+print_pkt(const struct openvpn_iphd=
r *iph, const char *prefix, const int direction, const msglvl_t msglevel)</=
span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</sp=
an><br><span> </span><br><span>diff --git a/src/openvpn/comp=2Ec b/src/open=
vpn/comp=2Ec</span><br><span>index b88b79f=2E=2E387a7c4 100644</span><br><s=
pan>--- a/src/openvpn/comp=2Ec</span><br><span>+++ b/src/openvpn/comp=2Ec</=
span><br><span>@@ -159,7 +159,7 @@</span><br><span> #endif /* USE_COMP */</=
span><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-check_compression_settings_valid(struct compress_options *=
info, msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+check_compression_settings_valid(const struct compress_options *info, =
msglvl_t msglevel)</span><br><span> {</span><br><span>     /*</span><br><sp=
an>      * We also allow comp-stub-v2 here as it technically allows escapin=
g of</span><br><span>diff --git a/src/openvpn/comp=2Eh b/src/openvpn/comp=
=2Eh</span><br><span>index 29a90a2=2E=2Ead80243 100644</span><br><span>--- =
a/src/openvpn/comp=2Eh</span><br><span>+++ b/src/openvpn/comp=2Eh</span><br=
><span>@@ -91,7 +91,7 @@</span><br><span>  * flags of allow-compression and=
 also the whether algorithms are compiled</span><br><span>  * in</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool check_=
compression_settings_valid(struct compress_options *info, msglvl_t msglevel=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_compre=
ssion_settings_valid(const struct compress_options *info, msglvl_t msglevel=
);</span><br><span> </span><br><span> #ifdef USE_COMP</span><br><span> #inc=
lude &quot;buffer=2Eh&quot;</span><br><span>diff --git a/src/openvpn/crypto=
=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index e5ad31a=2E=2Ee29d581 10=
0644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src=
/openvpn/crypto=2Ec</span><br><span>@@ -1105,7 +1105,7 @@</span><br><span> =
}</span><br><span> </span><br><span> static bool</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-key_is_zero(struct key *key, const struct key_ty=
pe *kt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key_is_zero(=
const struct key *key, const struct key_type *kt)</span><br><span> {</span>=
<br><span>     size_t cipher_length =3D cipher_kt_key_size(kt-&gt;cipher);<=
/span><br><span>     for (size_t i =3D 0; i &lt; cipher_length; ++i)</span>=
<br><span>@@ -1123,7 +1123,7 @@</span><br><span>  * Make sure that cipher k=
ey is a valid key for current key_type=2E</span><br><span>  */</span><br><s=
pan> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_key(st=
ruct key *key, const struct key_type *kt)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+check_key(const struct key *key, const struct key_typ=
e *kt)</span><br><span> {</span><br><span>     if (cipher_defined(kt-&gt;ci=
pher))</span><br><span>     {</span><br><span>@@ -1196,7 +1196,7 @@</span><=
br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-test_crypto(struct crypto_options *co, stru=
ct frame *frame)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_crypto(struct crypto_options *co, const struct frame *frame)</span><br><s=
pan> {</span><br><span>     int i, j;</span><br><span>     struct gc_arena =
gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/=
openvpn/crypto=2Eh</span><br><span>index ee5b50f=2E=2Ee3c1c6a 100644</span>=
<br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/cr=
ypto=2Eh</span><br><span>@@ -414,7 +414,7 @@</span><br><span>  */</span><br=
><span> int write_key_file(const int nkeys, const char *filename);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool check_k=
ey(struct key *key, const struct key_type *kt);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool check_key(const struct key *key, const str=
uct key_type *kt);</span><br><span> </span><br><span> /**</span><br><span> =
 * Initialize a key_type structure with=2E</span><br><span>@@ -614,7 +614,7=
 @@</span><br><span> /** Print a cipher list entry */</span><br><span> void=
 print_cipher(const char *cipher);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void test_crypto(struct crypto_options *co,=
 struct frame *f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid test_crypto(struct crypto_options *co, const struct frame *f);</span><b=
r><span> </span><br><span> </span><br><span> /* key direction functions */<=
/span><br><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</spa=
n><br><span>index 8eae4bf=2E=2Ec2cafae 100644</span><br><span>--- a/src/ope=
nvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -=
534,7 +534,7 @@</span><br><span>     ASSERT(sock-&gt;info=2Econnection_esta=
blished);</span><br><span> </span><br><span>     struct sockaddr *remoteadd=
r =3D &amp;sock-&gt;info=2Elsa-&gt;actual=2Edest=2Eaddr=2Esa;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct tls_multi *multi =3D c-&=
gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span>=
 #ifdef TARGET_FREEBSD</span><br><span>     /* In Linux in P2P mode the ker=
nel automatically removes an existing peer</span><br><span>      * when add=
ing a new peer=2E FreeBSD needs to explicitly be told to do that */</span><=
br><span>@@ -573,7 +573,7 @@</span><br><span> }</span><br><span> </span><br=
><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dc=
o_multi_get_localaddr(struct multi_context *m, struct multi_instance *mi,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_get_localad=
dr(const struct multi_context *m, const struct multi_instance *mi,</span><b=
r><span>                         struct sockaddr_storage *local)</span><br>=
<span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span>@@ -585,7 +=
585,7 @@</span><br><span>         return false;</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct link_socket_actual *actual =3D &amp;c-&gt;c2=2Elink_socket_infos[0]-&gt;=
lsa-&gt;actual;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct link_socket_actual *actual =3D &amp;c-&gt;c2=2Elink_socket_inf=
os[0]-&gt;lsa-&gt;actual;</span><br><span> </span><br><span>     switch (ac=
tual-&gt;dest=2Eaddr=2Esa=2Esa_family)</span><br><span>     {</span><br><sp=
an>@@ -623,7 +623,7 @@</span><br><span> }</span><br><span> </span><br><span=
> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_multi_add_ne=
w_peer(struct multi_context *m, struct multi_instance *mi)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+dco_multi_add_new_peer(const struct =
multi_context *m, struct multi_instance *mi)</span><br><span> {</span><br><=
span>     const struct context *c =3D &amp;mi-&gt;context;</span><br><span>=
 </span><br><span>@@ -677,7 +677,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
dco_install_iroute(struct multi_context *m, struct multi_instance *mi, stru=
ct mroute_addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+dco_install_iroute(struct multi_context *m, struct multi_instance *mi, co=
nst struct mroute_addr *addr)</span><br><span> {</span><br><span> #if defin=
ed(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br><s=
pan>     if (!dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span>@@ -79=
6,7 +796,7 @@</span><br><span>         /* Checked if we added a host route =
as the assigned client IP address was</span><br><span>          * outside t=
he --ifconfig-ipv6 tun interface config */</span><br><span> #if !defined(_W=
IN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct i=
n6_addr *dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct in6=
_addr *dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span>=
<br><span>         if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest)=
)</span><br><span>         {</span><br><span>             /* On windows we =
do not install these routes, so we also do not need to delete them */</span=
><br><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh</span><br=
><span>index 4e5aad5=2E=2E694875c 100644</span><br><span>--- a/src/openvpn/=
dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><br><span>@@ -204,7=
 +204,7 @@</span><br><span>  * @param mi        the client instance</span><=
br><span>  * @return          0 on success or a negative error code otherwi=
se</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-int dco_multi_add_new_peer(struct multi_context *m, struct multi_instance=
 *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_multi=
_add_new_peer(const struct multi_context *m, struct multi_instance *mi);</s=
pan><br><span> </span><br><span> /**</span><br><span>  * Install an iroute =
in DCO, which means adding a route to the system routing</span><br><span>@@=
 -215,7 +215,7 @@</span><br><span>  * @param addr      the route to add</sp=
an><br><span>  */</span><br><span> void dco_install_iroute(struct multi_con=
text *m, struct multi_instance *mi,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        struct mroute_addr *addr);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        const =
struct mroute_addr *addr);</span><br><span> </span><br><span> /**</span><br=
><span>  * Remove all routes added through the specified client</span><br><=
span>@@ -253,7 +253,7 @@</span><br><span>  * a 64 bit packet counter and AE=
AD tag at the end=2E</span><br><span>  */</span><br><span> bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct co=
ntext *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_suppo=
rts_epoch_data(const struct context *c);</span><br><span> #else  /* if defi=
ned(ENABLE_DCO) */</span><br><span> </span><br><span> typedef void *dco_con=
text_t;</span><br><span>@@ -350,7 +350,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static inline int</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-dco_multi_add_new_peer(struct multi_context *m, struct m=
ulti_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
co_multi_add_new_peer(const struct multi_context *m, struct multi_instance =
*mi)</span><br><span> {</span><br><span>     return 0;</span><br><span> }</=
span><br><span>@@ -384,7 +384,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-dco_supports_epoch_data(struct context *c)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct cont=
ext *c)</span><br><span> {</span><br><span>     return false;</span><br><sp=
an> }</span><br><span>diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvp=
n/dco_freebsd=2Ec</span><br><span>index d933aaf=2E=2E7346903 100644</span><=
br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>+++ b/src/openvp=
n/dco_freebsd=2Ec</span><br><span>@@ -930,7 +930,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-dco_supports_epoch_data(struct context *c)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct=
 context *c)</span><br><span> {</span><br><span>     return false;</span><b=
r><span> }</span><br><span>diff --git a/src/openvpn/dco_internal=2Eh b/src/=
openvpn/dco_internal=2Eh</span><br><span>index fcf8aca=2E=2E1022e66 100644<=
/span><br><span>--- a/src/openvpn/dco_internal=2Eh</span><br><span>+++ b/sr=
c/openvpn/dco_internal=2Eh</span><br><span>@@ -59,8 +59,9 @@</span><br><spa=
n>  * They are implemented by dco_linux=2Ec</span><br><span>  */</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco_new_pe=
er(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, struct =
sockaddr *localaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4=
, const struct in6_addr *vpn_ipv6);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+int dco_new_peer(dco_context_t *dco, unsigned int peerid, s=
ocket_descriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 struct sockaddr *localaddr, struct sockaddr *remoteaddr=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 c=
onst struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);</span><br>=
<span> </span><br><span> int dco_del_peer(dco_context_t *dco, unsigned int =
peerid);</span><br><span> </span><br><span>diff --git a/src/openvpn/dco_lin=
ux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index 56f6259=2E=2E31bbe=
87 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+=
++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -114,7 +114,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> static struct nl_msg *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_nlmsg_create(dco_co=
ntext_t *dco, uint8_t cmd)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ovpn_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)</span><=
br><span> {</span><br><span>     struct nl_msg *nl_msg =3D nlmsg_alloc();</=
span><br><span>     if (!nl_msg)</span><br><span>@@ -804,7 +804,7 @@</span>=
<br><span> </span><br><span> /* libnl &lt; 3=2E11=2E0 does not implement nl=
a_get_uint() */</span><br><span> static uint64_t</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-ovpn_nla_get_uint(struct nlattr *attr)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_nla_get_uint(const struc=
t nlattr *attr)</span><br><span> {</span><br><span>     if (nla_len(attr) =
=3D=3D sizeof(uint32_t))</span><br><span>     {</span><br><span>@@ -916,7 +=
916,7 @@</span><br><span> }</span><br><span> </span><br><span> static bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_iface_check(dco_c=
ontext_t *dco, struct nlattr *attrs[])</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ovpn_iface_check(const dco_context_t *dco, struct nlattr=
 *attrs[])</span><br><span> {</span><br><span>     /* we must know which in=
terface this message is referring to in order to</span><br><span>      * av=
oid mixing messages for other instances</span><br><span>@@ -1340,7 +1340,7 =
@@</span><br><span> }</span><br><span> </span><br><span> bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct cont=
ext *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports=
_epoch_data(const struct context *c)</span><br><span> {</span><br><span>   =
  return false;</span><br><span> }</span><br><span>diff --git a/src/openvpn=
/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index b3268bc=2E=2E8=
deb9d8 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span=
>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -1100,7 +1100,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct context *c)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_d=
ata(const struct context *c)</span><br><span> {</span><br><span>     OVPN_V=
ERSION ver =3D { 0 };</span><br><span>     return dco_get_version(&amp;ver)=
 &amp;&amp; ((ver=2EMajor =3D=3D 2 &amp;&amp; ver=2EMinor &gt;=3D 8) || (ve=
r=2EMajor &gt; 2));</span><br><span>diff --git a/src/openvpn/error=2Ec b/sr=
c/openvpn/error=2Ec</span><br><span>index 26d4c7c=2E=2E32d819d 100644</span=
><br><span>--- a/src/openvpn/error=2Ec</span><br><span>+++ b/src/openvpn/er=
ror=2Ec</span><br><span>@@ -623,7 +623,7 @@</span><br><span>  * from the OS=
=2E</span><br><span>  */</span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-x_check_status(ssize_t status, const char *descrip=
tion, struct link_socket *sock, struct tuntap *tt)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+x_check_status(ssize_t status, const char *d=
escription, struct link_socket *sock, const struct tuntap *tt)</span><br><s=
pan> {</span><br><span>     const char *extended_msg =3D NULL;</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/error=2Eh b/src/openvpn/erro=
r=2Eh</span><br><span>index a887fc7=2E=2E35c4996 100644</span><br><span>---=
 a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn/error=2Eh</span>=
<br><span>@@ -302,10 +302,10 @@</span><br><span> void set_check_status(unsi=
gned int info_level, unsigned int verbose_level);</span><br><span> </span><=
br><span> void x_check_status(ssize_t status, const char *description, stru=
ct link_socket *sock,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    struct tuntap *tt);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    const struct tuntap *tt);</span><br=
><span> </span><br><span> static inline void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-check_status(ssize_t status, const char *description=
, struct link_socket *sock, struct tuntap *tt)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+check_status(ssize_t status, const char *descrip=
tion, struct link_socket *sock, const struct tuntap *tt)</span><br><span> {=
</span><br><span>     if (status &lt; 0 || check_debug_level(x_cs_verbose_l=
evel))</span><br><span>     {</span><br><span>diff --git a/src/openvpn/even=
t=2Eh b/src/openvpn/event=2Eh</span><br><span>index b784dfe=2E=2E0940a1d 10=
0644</span><br><span>--- a/src/openvpn/event=2Eh</span><br><span>+++ b/src/=
openvpn/event=2Eh</span><br><span>@@ -204,7 +204,7 @@</span><br><span> #els=
e /* ifdef _WIN32 */</span><br><span> </span><br><span> static inline void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-wait_signal(struct eve=
nt_set *es, void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+wait_signal(const struct event_set *es, const void *arg)</span><br><span=
> {</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 83cd113=
=2E=2E56fc124 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><b=
r><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -231,7 +231,7 @@</=
span><br><span> }</span><br><span> </span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-parse_incoming_control_channel_c=
ommand(struct context *c, struct buffer *buf)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+parse_incoming_control_channel_command(struct con=
text *c, const struct buffer *buf)</span><br><span> {</span><br><span>     =
if (buf_string_match_head_str(buf, &quot;AUTH_FAILED&quot;))</span><br><spa=
n>     {</span><br><span>@@ -501,7 +501,7 @@</span><br><span> }</span><br><=
span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-get_server_poll_remaining_time(struct event_timeout *server_poll_time=
out)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_server_poll=
_remaining_time(const struct event_timeout *server_poll_timeout)</span><br>=
<span> {</span><br><span>     update_time();</span><br><span>     int remai=
ning =3D event_timeout_remaining(server_poll_timeout);</span><br><span>@@ -=
598,7 +598,7 @@</span><br><span>  * Buffer reallocation, for use with null =
encryption=2E</span><br><span>  */</span><br><span> static inline void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-buffer_turnover(const uint=
8_t *orig_buf, struct buffer *dest_stub, struct buffer *src_stub,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+buffer_turnover(const uint8_t=
 *orig_buf, struct buffer *dest_stub, const struct buffer *src_stub,</span>=
<br><span>                 struct buffer *storage)</span><br><span> {</span=
><br><span>     if (orig_buf =3D=3D src_stub-&gt;data &amp;&amp; src_stub-&=
gt;data !=3D storage-&gt;data)</span><br><span>@@ -885,7 +885,7 @@</span><b=
r><span>  */</span><br><span> </span><br><span> static inline void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-socks_postprocess_incoming_lin=
k(struct context *c, struct link_socket *sock)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+socks_postprocess_incoming_link(struct context *=
c, const struct link_socket *sock)</span><br><span> {</span><br><span>     =
if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;info=2Eproto =3D=3D PROTO_UDP)=
</span><br><span>     {</span><br><span>@@ -982,7 +982,7 @@</span><br><span=
> }</span><br><span> </span><br><span> bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-process_incoming_link_part1(struct context *c, struct=
 link_socket_info *lsi, bool floated)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+process_incoming_link_part1(struct context *c, const stru=
ct link_socket_info *lsi, bool floated)</span><br><span> {</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span>     bool decrypt_sta=
tus =3D false;</span><br><span>@@ -1532,7 +1532,7 @@</span><br><span>  * @p=
aram client    Determines whether to the send packet back via tun or link</=
span><br><span>  */</span><br><span> void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-ipv6_send_icmp_unreachable(struct context *c, struct bu=
ffer *buf, bool client)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ipv6_send_icmp_unreachable(struct context *c, const struct buffer *buf,=
 bool client)</span><br><span> {</span><br><span> #define MAX_ICMPV6LEN 128=
0</span><br><span>     struct openvpn_icmp6hdr icmp6out;</span><br><span>di=
ff --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><spa=
n>index 324c0b4=2E=2Eee7d2e2 100644</span><br><span>--- a/src/openvpn/forwa=
rd=2Eh</span><br><span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -12=
7,7 +127,7 @@</span><br><span>  */</span><br><span> void encrypt_sign(struc=
t context *c, bool comp_frag);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-int get_server_poll_remaining_time(struct event_=
timeout *server_poll_timeout);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+int get_server_poll_remaining_time(const struct event_timeout *s=
erver_poll_timeout);</span><br><span> </span><br><span> /******************=
****************************************************/</span><br><span> /**<=
/span><br><span>@@ -178,7 +178,7 @@</span><br><span>  *</span><br><span>  *=
 @return true if packet is authenticated, false otherwise=2E</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool process_in=
coming_link_part1(struct context *c, struct link_socket_info *lsi, bool flo=
ated);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool process_=
incoming_link_part1(struct context *c, const struct link_socket_info *lsi, =
bool floated);</span><br><span> </span><br><span> /**</span><br><span>  * C=
ontinues processing a packet read from the external network interface=2E</s=
pan><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</spa=
n><br><span>index 453ee7e=2E=2E525c135 100644</span><br><span>--- a/src/ope=
nvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@=
 -803,7 +803,7 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_port_sha=
re(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+init_port_share(const struct context *c)</span><br><span> {</span><br><sp=
an>     if (!port_share &amp;&amp; (c-&gt;options=2Eport_share_host &amp;&a=
mp; c-&gt;options=2Eport_share_port))</span><br><span>     {</span><br><spa=
n>@@ -1245,7 +1245,7 @@</span><br><span>  * prepending to msg() output=2E</=
span><br><span>  */</span><br><span> const char *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-format_common_name(struct context *c, struct gc=
_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+format_c=
ommon_name(const struct context *c, struct gc_arena *gc)</span><br><span> {=
</span><br><span>     struct buffer out =3D alloc_buf_gc(256, gc);</span><b=
r><span>     if (c-&gt;c2=2Etls_multi)</span><br><span>@@ -1731,7 +1731,7 @=
@</span><br><span> </span><br><span> </span><br><span> static bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-can_preserve_tun(struct tuntap=
 *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+can_preserve_t=
un(const struct tuntap *tt)</span><br><span> {</span><br><span>     if (tt =
&amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>    =
 {</span><br><span>@@ -1753,7 +1753,7 @@</span><br><span>  * @param c point=
er to the connection context</span><br><span>  */</span><br><span> static v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_wfp_block(stru=
ct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_w=
fp_block(const struct context *c)</span><br><span> {</span><br><span> #if d=
efined(_WIN32)</span><br><span>     /* Fortify &#39;redirect-gateway block-=
local&#39; with firewall rules? */</span><br><span>@@ -1779,7 +1779,7 @@</s=
pan><br><span>  * @param adapter_index the VPN adapter index</span><br><spa=
n>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-del_wfp_block(struct context *c, unsigned long adapter_index)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+del_wfp_block(const=
 struct context *c, unsigned long adapter_index)</span><br><span> {</span><=
br><span> #if defined(_WIN32)</span><br><span>     if (c-&gt;options=2Ebloc=
k_outside_dns || block_local_needed(c-&gt;c1=2Eroute_list))</span><br><span=
>diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh</span><br><span>i=
ndex ce8f74e=2E=2Ec486158 100644</span><br><span>--- a/src/openvpn/init=2Eh=
</span><br><span>+++ b/src/openvpn/init=2Eh</span><br><span>@@ -91,7 +91,7 =
@@</span><br><span> </span><br><span> uint64_t pull_permission_mask(const s=
truct context *c);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-const char *format_common_name(struct context *c, struct gc_=
arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const ch=
ar *format_common_name(const struct context *c, struct gc_arena *gc);</span=
><br><span> </span><br><span> void reset_coarse_timers(struct context *c);<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/interval=2Eh b/s=
rc/openvpn/interval=2Eh</span><br><span>index 59051bd=2E=2E0cfe202 100644</=
span><br><span>--- a/src/openvpn/interval=2Eh</span><br><span>+++ b/src/ope=
nvpn/interval=2Eh</span><br><span>@@ -89,7 +89,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> static inline void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-interval_schedule_wakeup(struct interval *top, =
interval_t *wakeup)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
interval_schedule_wakeup(const struct interval *top, interval_t *wakeup)</s=
pan><br><span> {</span><br><span>     const time_t local_now =3D now;</span=
><br><span>     interval_earliest_wakeup(wakeup, top-&gt;last_test_true + t=
op-&gt;refresh, local_now);</span><br><span>@@ -214,7 +214,7 @@</span><br><=
span>  * This function does not check if the timeout is actually valid=2E</=
span><br><span>  */</span><br><span> static inline interval_t</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-event_timeout_remaining(struct even=
t_timeout *et)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+event=
_timeout_remaining(const struct event_timeout *et)</span><br><span> {</span=
><br><span>     return (interval_t)((et-&gt;last + et-&gt;n) - now);</span>=
<br><span> }</span><br><span>diff --git a/src/openvpn/list=2Ec b/src/openvp=
n/list=2Ec</span><br><span>index e51dcd0=2E=2Edcd59d7 100644</span><br><spa=
n>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</sp=
an><br><span>@@ -164,7 +164,7 @@</span><br><span> }</span><br><span> </span=
><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_=
remove_by_value(struct hash *hash, void *value)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+hash_remove_by_value(struct hash *hash, const v=
oid *value)</span><br><span> {</span><br><span>     struct hash_iterator hi=
;</span><br><span>     const struct hash_element *he;</span><br><span>diff =
--git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>index 5=
5bc3c8=2E=2E23267d0 100644</span><br><span>--- a/src/openvpn/list=2Eh</span=
><br><span>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -78,7 +78,7 @@</sp=
an><br><span> </span><br><span> bool hash_remove_fast(struct hash *hash, st=
ruct hash_bucket *bucket, const void *key, uint64_t hv);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-void hash_remove_by_va=
lue(struct hash *hash, void *value);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void hash_remove_by_value(struct hash *hash, const void *v=
alue);</span><br><span> </span><br><span> struct hash_iterator</span><br><s=
pan> {</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/ma=
nage=2Ec</span><br><span>index e6f9574=2E=2E606d766 100644</span><br><span>=
--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</=
span><br><span>@@ -330,7 +330,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-man_delete_unix_socket(struct management *man)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+man_delete_unix_socket(const struct manageme=
nt *man)</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPORT</span><b=
r><span>     if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT=
_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><span>@@ -675,7 +675,7 @@</span=
><br><span>  * for the log and echo commands=2E</span><br><span>  */</span>=
<br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-man_history(struct management *man, const char *parm, const char *type, st=
ruct log_history *log,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+man_history(struct management *man, const char *parm, const char *type, =
const struct log_history *log,</span><br><span>             bool *realtime,=
 const unsigned int lep_flags)</span><br><span> {</span><br><span>     stru=
ct gc_arena gc =3D gc_new();</span><br><span>@@ -851,7 +851,7 @@</span><br>=
<span> }</span><br><span> </span><br><span> static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-man_net(struct management *man)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+man_net(const struct manageme=
nt *man)</span><br><span> {</span><br><span>     if (man-&gt;persist=2Ecall=
back=2Eshow_net)</span><br><span>     {</span><br><span>@@ -887,7 +887,7 @@=
</span><br><span> #ifdef ENABLE_PKCS11</span><br><span> </span><br><span> s=
tatic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_pkcs11_=
id_count(struct management *man)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+man_pkcs11_id_count(const struct management *man)</span><br><s=
pan> {</span><br><span>     msg(M_CLIENT, &quot;&gt;PKCS11ID-COUNT:%d&quot;=
, pkcs11_management_id_count());</span><br><span> }</span><br><span>@@ -236=
3,7 +2363,7 @@</span><br><span>  * the route/ifconfig/open tun command=2E  =
 See doc/android=2Etxt for details=2E</span><br><span>  */</span><br><span>=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_andro=
id_control(struct management *man, const char *command, const char *msg)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+management_android_con=
trol(const struct management *man, const char *command, const char *msg)</s=
pan><br><span> {</span><br><span>     if (!man)</span><br><span>     {</spa=
n><br><span>@@ -3010,7 +3010,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mana=
gement_up_down(struct management *man, const char *updown, const struct env=
_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management=
_up_down(const struct management *man, const char *updown, const struct env=
_set *es)</span><br><span> {</span><br><span>     if (man-&gt;settings=2Efl=
ags &amp; MF_UP_DOWN)</span><br><span>     {</span><br><span>@@ -3204,7 +32=
04,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(struct=
 management *man, const char *type, const char *reason)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+management_auth_failure(const struct ma=
nagement *man, const char *type, const char *reason)</span><br><span> {</sp=
an><br><span>     if (reason)</span><br><span>     {</span><br><span>diff -=
-git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>inde=
x 3ab937c=2E=2E8aa5c87 100644</span><br><span>--- a/src/openvpn/manage=2Eh<=
/span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -368,7 +368=
,7 @@</span><br><span>                                 const unsigned int f=
lags, const char *static_challenge);</span><br><span> </span><br><span> #if=
def TARGET_ANDROID</span><br><span style=3D"color: hsl(0, 100%, 40%);">-boo=
l management_android_control(struct management *man, const char *command, c=
onst char *msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l management_android_control(const struct management *man, const char *comm=
and, const char *msg);</span><br><span> </span><br><span> #define ANDROID_K=
EEP_OLD_TUN      1</span><br><span> #define ANDROID_OPEN_BEFORE_CLOSE 2</sp=
an><br><span>@@ -382,7 +382,7 @@</span><br><span> </span><br><span> void ma=
nagement_event_loop_n_seconds(struct management *man, int sec);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void management=
_up_down(struct management *man, const char *updown, const struct env_set *=
es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void management=
_up_down(const struct management *man, const char *updown, const struct env=
_set *es);</span><br><span> </span><br><span> void management_notify(const =
char *severity, const char *type,</span><br><span>                        c=
onst char *text);</span><br><span>@@ -397,7 +397,7 @@</span><br><span> void=
 management_connection_established(struct management *management,</span><br=
><span>                                        struct man_def_auth_context =
*mdac, const struct env_set *es);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void management_notify_client_close(struct =
management *management,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void management_notify_client_close(const struct management *management=
,</span><br><span>                                     struct man_def_auth_=
context *mdac, const struct env_set *es);</span><br><span> </span><br><span=
> void management_learn_addr(struct man_def_auth_context *mdac,</span><br><=
span>@@ -482,7 +482,7 @@</span><br><span>  * OpenVPN calls here to indicate=
 a password failure</span><br><span>  */</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void management_auth_failure(struct ma=
nagement *man, const char *type, const char *reason);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void management_auth_failure(const struct=
 management *man, const char *type, const char *reason);</span><br><span> <=
/span><br><span> /*</span><br><span>  * Echo an authentication token to man=
agement interface</span><br><span>diff --git a/src/openvpn/mbuf=2Ec b/src/o=
penvpn/mbuf=2Ec</span><br><span>index 7b790ed=2E=2E9a37e30 100644</span><br=
><span>--- a/src/openvpn/mbuf=2Ec</span><br><span>+++ b/src/openvpn/mbuf=2E=
c</span><br><span>@@ -149,7 +149,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance *mi)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbuf_dereference_inst=
ance(struct mbuf_set *ms, const struct multi_instance *mi)</span><br><span>=
 {</span><br><span>     if (ms)</span><br><span>     {</span><br><span>diff=
 --git a/src/openvpn/mbuf=2Eh b/src/openvpn/mbuf=2Eh</span><br><span>index =
cfe698c=2E=2Ee368054 100644</span><br><span>--- a/src/openvpn/mbuf=2Eh</spa=
n><br><span>+++ b/src/openvpn/mbuf=2Eh</span><br><span>@@ -75,7 +75,7 @@</s=
pan><br><span> </span><br><span> bool mbuf_extract_item(struct mbuf_set *ms=
, struct mbuf_item *item);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void mbuf_dereference_instance(struct mbuf_set *ms, =
struct multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void mbuf_dereference_instance(struct mbuf_set *ms, const struct mu=
lti_instance *mi);</span><br><span> </span><br><span> static inline bool</s=
pan><br><span> mbuf_defined(const struct mbuf_set *ms)</span><br><span>diff=
 --git a/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec</span><br><span>index 36=
bbb43=2E=2E0cfa272d 100644</span><br><span>--- a/src/openvpn/mss=2Ec</span>=
<br><span>+++ b/src/openvpn/mss=2Ec</span><br><span>@@ -239,8 +239,8 @@</sp=
an><br><span> }</span><br><span> </span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-frame_calculate_fragment(struct fr=
ame *frame, struct key_type *kt, const struct options *options,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                         struct l=
ink_socket_info *lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+frame_calculate_fragment(struct frame *frame, const struct key_type *kt, =
const struct options *options,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                         const struct link_socket_info *lsi)</sp=
an><br><span> {</span><br><span> #if defined(ENABLE_FRAGMENT)</span><br><sp=
an>     size_t overhead;</span><br><span>@@ -269,8 +269,8 @@</span><br><spa=
n> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-frame_calculate_mssfix(struct frame *frame,=
 struct key_type *kt, const struct options *options,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                       struct link_socket_i=
nfo *lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+frame_calc=
ulate_mssfix(struct frame *frame, const struct key_type *kt, const struct o=
ptions *options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                    const struct link_socket_info *lsi)</span><br><span> {<=
/span><br><span>     if (options-&gt;ce=2Emssfix_fixed)</span><br><span>   =
  {</span><br><span>@@ -314,8 +314,8 @@</span><br><span> }</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-frame_calculate_dynamic(struct frame *frame, struct key_type *kt, const s=
truct options *options,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        struct link_socket_info *lsi)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+frame_calculate_dynamic(struct frame *f=
rame, const struct key_type *kt, const struct options *options,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        const s=
truct link_socket_info *lsi)</span><br><span> {</span><br><span>     if (op=
tions-&gt;ce=2Efragment &gt; 0)</span><br><span>     {</span><br><span>diff=
 --git a/src/openvpn/mss=2Eh b/src/openvpn/mss=2Eh</span><br><span>index 1d=
092bb=2E=2E2eab55a 100644</span><br><span>--- a/src/openvpn/mss=2Eh</span><=
br><span>+++ b/src/openvpn/mss=2Eh</span><br><span>@@ -36,8 +36,8 @@</span>=
<br><span> void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);</spa=
n><br><span> </span><br><span> /** Set the --mssfix option=2E */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void frame_calculate_dynamic(str=
uct frame *frame, struct key_type *kt,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                             const struct options *options=
, struct link_socket_info *lsi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void frame_calculate_dynamic(struct frame *frame, const struct=
 key_type *kt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                        const struct options *options, const struct link_so=
cket_info *lsi);</span><br><span> </span><br><span> /**</span><br><span>  *=
 Checks and adjusts the fragment and mssfix value according to the</span><b=
r><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br>=
<span>index 5d88f8a=2E=2E922db3f 100644</span><br><span>--- a/src/openvpn/m=
tcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -91,7=
 +91,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_instance_specific_=
init(struct multi_context *m, struct multi_instance *mi)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+multi_tcp_instance_specific_init(const=
 struct multi_context *m, struct multi_instance *mi)</span><br><span> {</sp=
an><br><span>     /* buffer for queued TCP socket output packets */</span><=
br><span>     mi-&gt;tcp_link_out_deferred =3D mbuf_init(m-&gt;top=2Eoption=
s=2En_bcast_buf);</span><br><span>diff --git a/src/openvpn/mtcp=2Eh b/src/o=
penvpn/mtcp=2Eh</span><br><span>index 9b7d1d2=2E=2Ebb117fa 100644</span><br=
><span>--- a/src/openvpn/mtcp=2Eh</span><br><span>+++ b/src/openvpn/mtcp=2E=
h</span><br><span>@@ -35,7 +35,7 @@</span><br><span> </span><br><span> void=
 multi_tcp_dereference_instance(struct multi_io *multi_io, struct multi_ins=
tance *mi);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-bool multi_tcp_instance_specific_init(struct multi_context *m, stru=
ct multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool multi_tcp_instance_specific_init(const struct multi_context *m, st=
ruct multi_instance *mi);</span><br><span> </span><br><span> void multi_tcp=
_instance_specific_free(struct multi_instance *mi);</span><br><span> </span=
><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><=
br><span>index de3d467=2E=2E85c4ab3 100644</span><br><span>--- a/src/openvp=
n/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -5=
3,8 +53,9 @@</span><br><span>  * @param sock    the socket to send the repl=
y on</span><br><span>  */</span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-send_standalone_reply(struct multi_context=
 *m, struct buffer *buf, const char *prefix,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                      const char *detail, struct lin=
k_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send=
_standalone_reply(struct multi_context *m, const struct buffer *buf,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                      cons=
t char *prefix, const char *detail,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                      struct link_socket *sock)</span><br><=
span> {</span><br><span>     struct context *c =3D &amp;m-&gt;top;</span><b=
r><span> </span><br><span>@@ -74,7 +75,7 @@</span><br><span> </span><br><sp=
an> static void</span><br><span> send_hmac_reset_packet(struct multi_contex=
t *m, struct tls_pre_decrypt_state *state,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                       struct tls_auth_standalone *tas=
, struct session_id *sid,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                       const struct tls_auth_standalone *tas, const s=
truct session_id *sid,</span><br><span>                        bool request=
_resend_wkc, struct link_socket *sock)</span><br><span> {</span><br><span> =
    reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Ese=
nd);</span><br><span>@@ -97,11 +98,11 @@</span><br><span> </span><br><span>=
     enum first_packet_verdict verdict;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct tls_auth_standalone *tas =3D=
 m-&gt;top=2Ec2=2Etls_auth_standalone;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const struct tls_auth_standalone *tas =3D m-&gt;top=
=2Ec2=2Etls_auth_standalone;</span><br><span> </span><br><span>     verdict=
 =3D tls_pre_decrypt_lite(tas, state, &amp;m-&gt;top=2Ec2=2Efrom, &amp;m-&g=
t;top=2Ec2=2Ebuf);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    uint8_t *hmac_key =3D m-&gt;top=2Ec2=2Esession_id_key;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *hm=
ac_key =3D m-&gt;top=2Ec2=2Esession_id_key;</span><br><span>     const stru=
ct openvpn_sockaddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br>=
<span>     int handwindow =3D m-&gt;top=2Eoptions=2Ehandshake_window;</span=
><br><span> </span><br><span>@@ -218,7 +219,7 @@</span><br><span> static st=
ruct multi_instance *</span><br><span> handle_connection_attempt(struct mul=
ti_context *m,</span><br><span>                           struct link_socke=
t *sock,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
             struct mroute_addr *real)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                          const struct mroute_addr *real=
)</span><br><span> {</span><br><span>     struct hash *hash =3D m-&gt;hash;=
</span><br><span>     struct tls_pre_decrypt_state state =3D { 0 };</span><=
br><span>@@ -286,13 +287,12 @@</span><br><span>  * @return      instance ma=
tching the address, NULL otherwise</span><br><span>  */</span><br><span> st=
atic struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-multi_get_instance_udp_real(struct multi_context *m, struct mroute_a=
ddr *real)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get=
_instance_udp_real(struct multi_context *m, const struct mroute_addr *real)=
</span><br><span> {</span><br><span>     struct hash *hash =3D m-&gt;hash;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash_elemen=
t *he;</span><br><span>     const uint64_t hv =3D hash_value(hash, real);</=
span><br><span>     struct hash_bucket *bucket =3D hash_bucket(hash, hv);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    he =3D hash_lookup_=
fast(hash, bucket, real, hv);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const struct hash_element *he =3D hash_lookup_fast(hash, buck=
et, real, hv);</span><br><span>     if (he)</span><br><span>     {</span><b=
r><span>         return he-&gt;value;</span><br><span>@@ -320,7 +320,9 @@</=
span><br><span>  * maintaining real address hash table atomicity=2E</span><=
br><span>  */</span><br><span> struct multi_instance *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-multi_get_instance_udp_data(struct multi_c=
ontext *m, bool *floated, struct mroute_addr *real, struct link_socket *soc=
k)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_instanc=
e_udp_data(struct multi_context *m, bool *floated,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                            const struct mro=
ute_addr *real,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                        const struct link_socket *sock)</span><br><span> {<=
/span><br><span>     struct multi_instance *mi =3D NULL;</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec<=
/span><br><span>index 3e72b92=2E=2E89e2d4c 100644</span><br><span>--- a/src=
/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><s=
pan>@@ -57,7 +57,7 @@</span><br><span> </span><br><span> #ifdef MULTI_DEBUG=
_EVENT_LOOP</span><br><span> static const char *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-id(struct multi_instance *mi)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+id(const struct multi_instance *mi)</s=
pan><br><span> {</span><br><span>     if (mi)</span><br><span>     {</span>=
<br><span>@@ -1314,7 +1314,7 @@</span><br><span>  * same common name=2E</sp=
an><br><span>  */</span><br><span> static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-multi_delete_dup(struct multi_context *m, struct m=
ulti_instance *new_mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+multi_delete_dup(struct multi_context *m, const struct multi_instance *n=
ew_mi)</span><br><span> {</span><br><span>     if (new_mi)</span><br><span>=
     {</span><br><span>@@ -2259,7 +2259,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-multi_client_setup_dco_initial(struct multi_context *m, struc=
t multi_instance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+multi_client_setup_dco_initial(const struct multi_context *m, struct mult=
i_instance *mi,</span><br><span>                                struct gc_a=
rena *gc)</span><br><span> {</span><br><span>     if (!dco_enabled(&amp;mi-=
&gt;context=2Eoptions))</span><br><span>@@ -3078,7 +3078,8 @@</span><br><sp=
an>  * positive=2E</span><br><span>  */</span><br><span> static bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_dest_addr_allowe=
d(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *r=
eal)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_des=
t_addr_allowed(struct multi_context *m, struct multi_instance *mi,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
  const struct mroute_addr *real)</span><br><span> {</span><br><span>     s=
truct hash *hash =3D m-&gt;hash;</span><br><span>     const uint64_t hv =3D=
 hash_value(hash, real);</span><br><span>@@ -3237,7 +3238,7 @@</span><br><s=
pan> </span><br><span> #if defined(ENABLE_DCO)</span><br><span> static void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-process_incoming_del_=
peer(struct multi_context *m, struct multi_instance *mi, dco_context_t *dco=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process_incoming_d=
el_peer(struct multi_context *m, struct multi_instance *mi, const dco_conte=
xt_t *dco)</span><br><span> {</span><br><span>     const char *reason =3D &=
quot;ovpn-dco: unknown reason&quot;;</span><br><span>     switch (dco-&gt;d=
co_del_peer_reason)</span><br><span>@@ -4291,7 +4292,7 @@</span><br><span> =
</span><br><span> /* Searches for the address and deletes it if it is owned=
 by the multi_instance */</span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_addr(struct multi_context *m=
, struct multi_instance *mi, const struct mroute_addr *addr)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_addr(struct multi_co=
ntext *m, const struct multi_instance *mi, const struct mroute_addr *addr)<=
/span><br><span> {</span><br><span>     struct hash_element *he;</span><br>=
<span>     const uint64_t hv =3D hash_value(m-&gt;vhash, addr);</span><br><=
span>@@ -4326,7 +4327,7 @@</span><br><span>  * @param a     The new IPv4 ad=
dress in network byte order</span><br><span>  */</span><br><span> static vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_in_ad=
dr_t(struct multi_context *m, struct multi_instance *mi, in_addr_t a)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_in_addr_t(s=
truct multi_context *m, const struct multi_instance *mi, in_addr_t a)</span=
><br><span> {</span><br><span>     struct mroute_addr addr;</span><br><span=
>     CLEAR(addr);</span><br><span>@@ -4344,7 +4345,7 @@</span><br><span>  =
* @param a6    The new IPv6 address</span><br><span>  */</span><br><span> s=
tatic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_unlea=
rn_in6_addr(struct multi_context *m, struct multi_instance *mi, struct in6_=
addr a6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_unlea=
rn_in6_addr(struct multi_context *m, const struct multi_instance *mi, struc=
t in6_addr a6)</span><br><span> {</span><br><span>     struct mroute_addr a=
ddr;</span><br><span>     CLEAR(addr);</span><br><span>@@ -4460,7 +4461,7 @=
@</span><br><span> </span><br><span> bool</span><br><span> multi_check_push=
_ifconfig_ipv6_extra_route(struct multi_instance *mi,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                           =
struct in6_addr *dest)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                           const struct in6_addr *dest)<=
/span><br><span> {</span><br><span>     const struct options *o =3D &amp;mi=
-&gt;context=2Eoptions;</span><br><span> </span><br><span>diff --git a/src/=
openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 6cb86c7=2E=
=2E5b8d56a 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><sp=
an>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -517,7 +517,7 @@</span><b=
r><span>  */</span><br><span> </span><br><span> static inline void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-set_prefix(struct multi_instan=
ce *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set_prefix(c=
onst struct multi_instance *mi)</span><br><span> {</span><br><span> #ifdef =
MULTI_DEBUG_EVENT_LOOP</span><br><span>     if (mi-&gt;msg_prefix[0])</span=
><br><span>@@ -691,7 +691,7 @@</span><br><span>  */</span><br><span> bool</=
span><br><span> multi_check_push_ifconfig_ipv6_extra_route(struct multi_ins=
tance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                                struct in6_addr *dest);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
    const struct in6_addr *dest);</span><br><span> </span><br><span> /*</sp=
an><br><span>  * Check for signals=2E</span><br><span>diff --git a/src/open=
vpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 3604684=
=2E=2E52eb8c7 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><=
br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -159,7 +159,7 @@=
</span><br><span>  * a point-to-multipoint tunnel=2E</span><br><span>  */</=
span><br><span> static unsigned int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-p2mp_iow_flags(const struct multi_context *m, struct link_soc=
ket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+p2mp_iow_=
flags(const struct multi_context *m, const struct link_socket *sock)</span>=
<br><span> {</span><br><span>     unsigned int flags =3D IOW_WAIT_SIGNAL;</=
span><br><span> </span><br><span>diff --git a/src/openvpn/networking=2Eh b/=
src/openvpn/networking=2Eh</span><br><span>index bce0c19=2E=2E25233c8 10064=
4</span><br><span>--- a/src/openvpn/networking=2Eh</span><br><span>+++ b/sr=
c/openvpn/networking=2Eh</span><br><span>@@ -44,7 +44,7 @@</span><br><span>=
  */</span><br><span> #if !defined(ENABLE_IPROUTE)</span><br><span> static =
inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_ctx_ini=
t(struct context *c, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+net_ctx_init(const struct context *c, openvpn_net_=
ctx_t *ctx)</span><br><span> {</span><br><span>     (void)c;</span><br><spa=
n>     (void)ctx;</span><br><span>@@ -75,7 +75,7 @@</span><br><span>  *</sp=
an><br><span>  * @return          0 on success, a negative error code other=
wise</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-int net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+int net_ctx_init(const struct =
context *c, openvpn_net_ctx_t *ctx);</span><br><span> </span><br><span> /**=
</span><br><span>  * Release resources allocated by the internal garbage co=
llector</span><br><span>@@ -102,7 +102,7 @@</span><br><span>  * @return    =
      0 on success, negative error code on error</span><br><span>  */</span=
><br><span> int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_ifa=
ce_t *iface, const char *type,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                  void *arg);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                  const void *arg);</span><br><span> </s=
pan><br><span> /**</span><br><span>  * Retrieve the interface type</span><b=
r><span>diff --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/netw=
orking_iproute2=2Ec</span><br><span>index a1f3525=2E=2Ef091fb3 100644</span=
><br><span>--- a/src/openvpn/networking_iproute2=2Ec</span><br><span>+++ b/=
src/openvpn/networking_iproute2=2Ec</span><br><span>@@ -36,7 +36,7 @@</span=
><br><span> #include &lt;netinet/in=2Eh&gt;</span><br><span> </span><br><sp=
an> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_ctx_init(s=
truct context *c, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+net_ctx_init(const struct context *c, openvpn_net_ctx=
_t *ctx)</span><br><span> {</span><br><span>     ctx-&gt;es =3D NULL;</span=
><br><span>     if (c)</span><br><span>@@ -61,7 +61,7 @@</span><br><span> }=
</span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, =
const char *type, void *arg)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const cha=
r *type, const void *arg)</span><br><span> {</span><br><span>     struct ar=
gv argv =3D argv_new();</span><br><span> </span><br><span>diff --git a/src/=
openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><=
span>index a396255=2E=2E13e0f0b 100644</span><br><span>--- a/src/openvpn/ne=
tworking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</=
span><br><span>@@ -1007,7 +1007,7 @@</span><br><span> }</span><br><span> </=
span><br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-sitnl_addr_del(sa_family_t af_family, const char *iface, inet_address_=
t *addr, int prefixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+sitnl_addr_del(sa_family_t af_family, const char *iface, const inet_add=
ress_t *addr, int prefixlen)</span><br><span> {</span><br><span>     int if=
index;</span><br><span> </span><br><span>@@ -1250,8 +1250,8 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-sitnl_route_del(const char *iface, sa_famil=
y_t af_family, inet_address_t *dst, int prefixlen,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                inet_address_t *gw, uint32_t t=
able, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+si=
tnl_route_del(const char *iface, sa_family_t af_family, const inet_address_=
t *dst, int prefixlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                const inet_address_t *gw, uint32_t table, int metric)</s=
pan><br><span> {</span><br><span>     int ifindex =3D 0;</span><br><span> <=
/span><br><span>@@ -1328,7 +1328,7 @@</span><br><span> </span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ne=
t_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, vo=
id *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_n=
ew(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void =
*arg)</span><br><span> {</span><br><span>     struct sitnl_link_req req =3D=
 {};</span><br><span>     int ret =3D -1;</span><br><span>diff --git a/src/=
openvpn/occ=2Eh b/src/openvpn/occ=2Eh</span><br><span>index bda4f18=2E=2E49=
def4d 100644</span><br><span>--- a/src/openvpn/occ=2Eh</span><br><span>+++ =
b/src/openvpn/occ=2Eh</span><br><span>@@ -156,7 +156,7 @@</span><br><span> =
 * via control channel=2E</span><br><span>  * @return control channel exit =
message should be used */</span><br><span> static inline bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-cc_exit_notify_enabled(struct conte=
xt *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cc_exit_notif=
y_enabled(const struct context *c)</span><br><span> {</span><br><span>     =
/* Check if we have TLS active at all */</span><br><span>     if (!c-&gt;c2=
=2Etls_multi)</span><br><span>diff --git a/src/openvpn/openssl_compat=2Eh b=
/src/openvpn/openssl_compat=2Eh</span><br><span>index 098bdd5=2E=2E1a934db =
100644</span><br><span>--- a/src/openvpn/openssl_compat=2Eh</span><br><span=
>+++ b/src/openvpn/openssl_compat=2Eh</span><br><span>@@ -127,7 +127,7 @@</=
span><br><span> /* Mimics the functions but only when the default context w=
ithout</span><br><span>  * options is chosen */</span><br><span> static inl=
ine const EVP_CIPHER *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-EVP_CIPHER_fetch(void *ctx, const char *algorithm, const char *properties)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+EVP_CIPHER_fetch(co=
nst void *ctx, const char *algorithm, const char *properties)</span><br><sp=
an> {</span><br><span>     ASSERT(!ctx);</span><br><span>     ASSERT(!prope=
rties);</span><br><span>@@ -135,7 +135,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static inline const EVP_MD *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-EVP_MD_fetch(void *ctx, const char *algorit=
hm, const char *properties)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+EVP_MD_fetch(const void *ctx, const char *algorithm, const char *pr=
operties)</span><br><span> {</span><br><span>     ASSERT(!ctx);</span><br><=
span>     ASSERT(!properties);</span><br><span>diff --git a/src/openvpn/opt=
ions=2Ec b/src/openvpn/options=2Ec</span><br><span>index 15f2fcd=2E=2Ef1306=
bb 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++=
 b/src/openvpn/options=2Ec</span><br><span>@@ -2423,7 +2423,7 @@</span><br>=
<span> }</span><br><span> </span><br><span> static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-options_postprocess_mutate_le(struct conn=
ection_entry *ce, struct local_entry *le, int mode)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+options_postprocess_mutate_le(const struc=
t connection_entry *ce, struct local_entry *le, int mode)</span><br><span> =
{</span><br><span>     /* use the global port if none is specified */</span=
><br><span>     if (!le-&gt;port)</span><br><span>@@ -3576,7 +3576,7 @@</sp=
an><br><span> static bool</span><br><span> verify_permission(const char *na=
me, const char *file, int line, const uint64_t type,</span><br><span>      =
             const uint64_t allowed, uint64_t *found, const msglvl_t msglev=
el,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
struct options *options, bool is_inline)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                  const struct options *options, bool =
is_inline)</span><br><span> {</span><br><span>     if (!(type &amp; allowed=
))</span><br><span>     {</span><br><span>@@ -3652,7 +3652,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static inline msglvl_t</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-msglevel_forward_compatible(str=
uct options *options, const msglvl_t msglevel)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+msglevel_forward_compatible(const struct options=
 *options, const msglvl_t msglevel)</span><br><span> {</span><br><span>    =
 return options-&gt;forward_compatible ? M_WARN : msglevel;</span><br><span=
> }</span><br><span>@@ -4143,7 +4143,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-show_compression_warning(struct compress_options *info)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+show_compression_warning(con=
st struct compress_options *info)</span><br><span> {</span><br><span>     i=
f (comp_non_stub_enabled(info))</span><br><span>     {</span><br><span>diff=
 --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_parse=2Ec</spa=
n><br><span>index 88ab4d2=2E=2E0e94522 100644</span><br><span>--- a/src/ope=
nvpn/options_parse=2Ec</span><br><span>+++ b/src/openvpn/options_parse=2Ec<=
/span><br><span>@@ -258,7 +258,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static char *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-read_inline_file(struct in_src *is, const char *close_tag, int *num_=
lines, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+read_inline_file(const struct in_src *is, const char *close_tag, in=
t *num_lines, struct gc_arena *gc)</span><br><span> {</span><br><span>     =
char line[OPTION_LINE_SIZE];</span><br><span>     struct buffer buf =3D all=
oc_buf(8 * OPTION_LINE_SIZE);</span><br><span>@@ -302,7 +302,7 @@</span><br=
><span> }</span><br><span> </span><br><span> static int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-check_inline_file(struct in_src *is, char=
 *p[], struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+check_inline_file(const struct in_src *is, char *p[], struct gc_are=
na *gc)</span><br><span> {</span><br><span>     int num_inline_lines =3D 0;=
</span><br><span> </span><br><span>diff --git a/src/openvpn/otime=2Ec b/src=
/openvpn/otime=2Ec</span><br><span>index 1608458=2E=2E5d3633c 100644</span>=
<br><span>--- a/src/openvpn/otime=2Ec</span><br><span>+++ b/src/openvpn/oti=
me=2Ec</span><br><span>@@ -66,7 +66,7 @@</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-update_now_usec(struct timeval *tv)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+update_now_usec(const struct timeval *tv)</span><br><spa=
n> {</span><br><span>     const time_t last =3D now;</span><br><span>     u=
pdate_now(tv-&gt;tv_sec);</span><br><span>diff --git a/src/openvpn/otime=2E=
h b/src/openvpn/otime=2Eh</span><br><span>index d14f01e=2E=2E74d21ff 100644=
</span><br><span>--- a/src/openvpn/otime=2Eh</span><br><span>+++ b/src/open=
vpn/otime=2Eh</span><br><span>@@ -65,7 +65,7 @@</span><br><span> void updat=
e_now(const time_t system_time);</span><br><span> </span><br><span> extern =
time_t now_usec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void =
update_now_usec(struct timeval *tv);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void update_now_usec(const struct timeval *tv);</span><br>=
<span> </span><br><span> static inline int</span><br><span> openvpn_gettime=
ofday(struct timeval *tv, void *tz)</span><br><span>diff --git a/src/openvp=
n/proto=2Eh b/src/openvpn/proto=2Eh</span><br><span>index 9bb0866=2E=2E1665=
751 100644</span><br><span>--- a/src/openvpn/proto=2Eh</span><br><span>+++ =
b/src/openvpn/proto=2Eh</span><br><span>@@ -248,7 +248,7 @@</span><br><span=
>  * and offset of IP header (via parameter)=2E</span><br><span>  */</span>=
<br><span> static inline int</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-get_tun_ip_ver(int tunnel_type, struct buffer *buf, int *ip_hdr_offs=
et)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_tun_ip_ver(i=
nt tunnel_type, const struct buffer *buf, int *ip_hdr_offset)</span><br><sp=
an> {</span><br><span>     int ip_ver =3D -1;</span><br><span> </span><br><=
span>diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><=
span>index 74a6cf9=2E=2Ec3ad7de 100644</span><br><span>--- a/src/openvpn/pr=
oxy=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -527=
,8 +527,9 @@</span><br><span> }</span><br><span> </span><br><span> static b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_proxy_headers(=
struct http_proxy_info *p, socket_descriptor_t sd, /* already open to proxy=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
const char *host                                   /* openvpn server remote=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_proxy_header=
s(const struct http_proxy_info *p,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                  socket_descriptor_t sd, /* already open to=
 proxy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
        const char *host        /* openvpn server remote */</span><br><span=
> )</span><br><span> {</span><br><span>     char buf[512];</span><br><span>=
@@ -597,8 +598,8 @@</span><br><span>                               socket_d=
escriptor_t sd, /* already open to proxy */</span><br><span>               =
                const char *host,       /* openvpn server remote */</span><=
br><span>                               const char *port,       /* openvpn =
server port */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                       struct event_timeout *server_poll_timeout, struct bu=
ffer *lookahead,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                         struct signal_info *sig_info)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                              const stru=
ct event_timeout *server_poll_timeout,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                              struct buffer *lookahead, =
struct signal_info *sig_info)</span><br><span> {</span><br><span>     struc=
t gc_arena gc =3D gc_new();</span><br><span>     char buf[512];</span><br><=
span>diff --git a/src/openvpn/proxy=2Eh b/src/openvpn/proxy=2Eh</span><br><=
span>index e662e7d=2E=2Ea2f4e47 100644</span><br><span>--- a/src/openvpn/pr=
oxy=2Eh</span><br><span>+++ b/src/openvpn/proxy=2Eh</span><br><span>@@ -89,=
7 +89,7 @@</span><br><span>                                    socket_descr=
iptor_t sd, /* already open to proxy */</span><br><span>                   =
                 const char *host,       /* openvpn server remote */</span>=
<br><span>                                    const char *port,       /* op=
envpn server port */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                  struct event_timeout *server_poll_timeout=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                 const struct event_timeout *server_poll_timeout,</span><br=
><span>                                    struct buffer *lookahead, struct=
 signal_info *sig_info);</span><br><span> </span><br><span> uint8_t *make_b=
ase64_string2(const uint8_t *str, int str_len, struct gc_arena *gc);</span>=
<br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><s=
pan>index 08c2673=2E=2E2679c4d5 100644</span><br><span>--- a/src/openvpn/ps=
=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -334,7 +33=
4,7 @@</span><br><span>  * the proxy can determine true client origin=2E</s=
pan><br><span>  */</span><br><span> static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-journal_add(const char *journal_dir, struct proxy=
_connection *pc, struct proxy_connection *cp)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+journal_add(const char *journal_dir, const struct=
 proxy_connection *pc, struct proxy_connection *cp)</span><br><span> {</spa=
n><br><span>     struct openvpn_sockaddr from, to;</span><br><span> </span>=
<br><span>@@ -412,7 +412,7 @@</span><br><span> static bool</span><br><span>=
 proxy_entry_new(struct proxy_connection **list, struct event_set *es,</spa=
n><br><span>                 const struct openvpn_sockaddr server_addr, con=
st socket_descriptor_t sd_client,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                struct buffer *initial_data, const char *journa=
l_dir)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   const struct buffer *initial_data, const char *journal_dir)</span><br><s=
pan> {</span><br><span>     socket_descriptor_t sd_server;</span><br><span>=
     int status;</span><br><span>@@ -1015,7 +1015,7 @@</span><br><span>  * =
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
x 761a59e=2E=2Ed72596e 100644</span><br><span>--- a/src/openvpn/push=2Ec</s=
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
 b/src/openvpn/reliable=2Ec</span><br><span>index ced438e=2E=2Eba819a3 1006=
44</span><br><span>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src=
/openvpn/reliable=2Ec</span><br><span>@@ -92,7 +92,7 @@</span><br><span> </=
span><br><span> /* check if a particular packet_id is present in ack */</sp=
an><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-reliable_ack_packet_id_present(struct reliable_ack *ack, packet_=
id_type pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliabl=
e_ack_packet_id_present(const struct reliable_ack *ack, packet_id_type pid)=
</span><br><span> {</span><br><span>     for (int i =3D 0; i &lt; ack-&gt;l=
en; ++i)</span><br><span>     {</span><br><span>@@ -391,7 +391,7 @@</span><=
br><span> }</span><br><span> </span><br><span> int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-validate_packet_id_window(struct reliable *rel=
, packet_id_type pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+validate_packet_id_window(const struct reliable *rel, packet_id_type pid)=
</span><br><span> {</span><br><span>     return reliable_pid_min(pid, rel-&=
gt;packet_id)</span><br><span>            &amp;&amp; reliable_pid_min(subtr=
act_pid(rel-&gt;packet_id, RELIABLE_CAPACITY), pid);</span><br><span>@@ -76=
8,7 +768,7 @@</span><br><span>  */</span><br><span> </span><br><span> void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_mark_active_i=
ncoming(struct reliable *rel, struct buffer *buf, packet_id_type pid,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_mark_active_inco=
ming(struct reliable *rel, const struct buffer *buf, packet_id_type pid,</s=
pan><br><span>                               int opcode)</span><br><span> {=
</span><br><span>     for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br=
><span>@@ -828,7 +828,7 @@</span><br><span> </span><br><span> /* delete a b=
uffer previously activated by reliable_mark_active() */</span><br><span> vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_mark_delet=
ed(struct reliable *rel, struct buffer *buf)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+reliable_mark_deleted(struct reliable *rel, const =
struct buffer *buf)</span><br><span> {</span><br><span>     for (int i =3D =
0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br><span>diff --=
git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh</span><br><span>i=
ndex a85f2e9=2E=2E12d5367 100644</span><br><span>--- a/src/openvpn/reliable=
=2Eh</span><br><span>+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ -184=
,7 +184,7 @@</span><br><span>  * @li False, if there are packet IDs to be a=
cknowledged=2E</span><br><span>  */</span><br><span> static inline bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_ack_empty(struct=
 reliable_ack *ack)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
reliable_ack_empty(const struct reliable_ack *ack)</span><br><span> {</span=
><br><span>     return !ack-&gt;len;</span><br><span> }</span><br><span>@@ =
-198,7 +198,7 @@</span><br><span>  * included in the valid range=2E</span><=
br><span>  */</span><br><span> int</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-validate_packet_id_window(struct reliable *rel, packet_id_type=
 pid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+validate_pack=
et_id_window(const struct reliable *rel, packet_id_type pid);</span><br><sp=
an> </span><br><span> /**</span><br><span>  * Returns the number of packets=
 that need to be acked=2E</span><br><span>@@ -208,7 +208,7 @@</span><br><sp=
an>  * @returns the number of outstanding acks</span><br><span>  */</span><=
br><span> static inline int</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-reliable_ack_outstanding(struct reliable_ack *ack)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+reliable_ack_outstanding(const struct =
reliable_ack *ack)</span><br><span> {</span><br><span>     return ack-&gt;l=
en;</span><br><span> }</span><br><span>@@ -358,7 +358,7 @@</span><br><span>=
  * @param pid The packet&#39;s packet ID=2E</span><br><span>  * @param opc=
ode The packet&#39;s opcode=2E</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void reliable_mark_active_incoming(struct r=
eliable *rel, struct buffer *buf, packet_id_type pid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void reliable_mark_active_incoming(struct=
 reliable *rel, const struct buffer *buf, packet_id_type pid,</span><br><sp=
an>                                    int opcode);</span><br><span> </span=
><br><span> /**</span><br><span>@@ -411,7 +411,7 @@</span><br><span>  * @pa=
ram rel The reliable structure associated with the given buffer=2E</span><b=
r><span>  * @param buf The buffer of the reliable entry which is to be remo=
ved=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void reliable_mark_deleted(struct reliable *rel, struct buffer *buf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void reliable_mark_=
deleted(struct reliable *rel, const struct buffer *buf);</span><br><span> <=
/span><br><span> /** @} name Functions for extracting incoming packets */</=
span><br><span> </span><br><span>diff --git a/src/openvpn/route=2Ec b/src/o=
penvpn/route=2Ec</span><br><span>index 03a2526=2E=2E078bb7e 100644</span><b=
r><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=
=2Ec</span><br><span>@@ -898,8 +898,9 @@</span><br><span> }</span><br><span=
> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-add_bypass_routes(struct route_bypass *rb, in_addr_t gateway, con=
st struct tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                  unsigned int flags, const struct route_gateway_info *rgi,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_bypass_routes(c=
onst struct route_bypass *rb, in_addr_t gateway,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                  const struct tuntap *tt, uns=
igned int flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
               const struct route_gateway_info *rgi,</span><br><span>      =
             const struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><s=
pan> {</span><br><span>     int ret =3D true;</span><br><span>@@ -916,8 +91=
7,9 @@</span><br><span> }</span><br><span> </span><br><span> static void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-del_bypass_routes(struct=
 route_bypass *rb, in_addr_t gateway, const struct tuntap *tt,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                  unsigned int fla=
gs, const struct route_gateway_info *rgi,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+del_bypass_routes(const struct route_bypass *rb, in_a=
ddr_t gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
             const struct tuntap *tt, unsigned int flags,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                  const struct route_=
gateway_info *rgi,</span><br><span>                   const struct env_set =
*es, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>     int i;=
</span><br><span>@@ -3942,7 +3944,7 @@</span><br><span> #else  /* if define=
d(_WIN32) */</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-get_bypass_addresses(struct route_byp=
ass *rb, const unsigned int flags) /* PLATFORM-SPECIFIC */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+get_bypass_addresses(struct route_by=
pass *rb, const unsigned int flags)</span><br><span> {</span><br><span> }</=
span><br><span> </span><br><span>diff --git a/src/openvpn/schedule=2Ec b/sr=
c/openvpn/schedule=2Ec</span><br><span>index 6772ad6=2E=2E694f4d1 100644</s=
pan><br><span>--- a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src/open=
vpn/schedule=2Ec</span><br><span>@@ -389,4 +389,4 @@</span><br><span> {</sp=
an><br><span>     s-&gt;earliest_wakeup =3D NULL; /* invalidate cache */</s=
pan><br><span>     schedule_remove_node(s, e);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span>\ No newline at end of file</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff -=
-git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>inde=
x 73871b2=2E=2Eb3cdc60 100644</span><br><span>--- a/src/openvpn/socket=2Ec<=
/span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -619,7 +619=
,7 @@</span><br><span> }</span><br><span> </span><br><span> static void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-bind_local(struct link_so=
cket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bind_loc=
al(const struct link_socket *sock)</span><br><span> {</span><br><span>     =
/* bind to local address/port */</span><br><span>     if (sock-&gt;bind_loc=
al)</span><br><span>@@ -878,8 +878,8 @@</span><br><span> }</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-socket_bind(socket_descriptor_t sd, struct addrinfo *local, int ai_family=
, const char *prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            bool ipv6only)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+socket_bind(socket_descriptor_t sd, const struct addrinfo *local, in=
t ai_family,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     const char *prefix, bool ipv6only)</span><br><span> {</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ =
-1087,8 +1087,8 @@</span><br><span>  * such as TCP=2E</span><br><span>  */<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic void stream_buf_init(struct stream_buf *sb, struct buffer *buf, const un=
signed int sockflags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                            const int proto);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void stream_buf_init(struct stream_buf *sb=
, const struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                            const unsigned int sockflags, const int=
 proto);</span><br><span> </span><br><span> static void stream_buf_close(st=
ruct stream_buf *sb);</span><br><span> </span><br><span>@@ -1441,7 +1441,7 =
@@</span><br><span> }</span><br><span> </span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-phase2_set_socket_flags(stru=
ct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+phase2_set_socket_flags(const struct link_socket *sock)</span><br><span> =
{</span><br><span>     /* TCP_NODELAY is enabled by default on every TCP so=
cket; dco-win is</span><br><span>      * skipped as it manages its own sock=
et */</span><br><span>@@ -2037,7 +2037,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-stream_buf_init(struct stream_buf *sb, struct buffer *buf, con=
st unsigned int sockflags,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+stream_buf_init(struct stream_buf *sb, const struct buffer *buf, con=
st unsigned int sockflags,</span><br><span>                 const int proto=
)</span><br><span> {</span><br><span>     sb-&gt;buf_init =3D *buf;</span><=
br><span>@@ -2303,7 +2303,7 @@</span><br><span> #endif</span><br><span> </s=
pan><br><span> static ssize_t</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-link_socket_read_udp_posix_recvmsg(struct link_socket *sock, struct=
 buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_s=
ocket_read_udp_posix_recvmsg(const struct link_socket *sock, struct buffer =
*buf,</span><br><span>                                    struct link_socke=
t_actual *from, socklen_t *fromlen)</span><br><span> {</span><br><span>    =
 struct iovec iov;</span><br><span>@@ -2375,7 +2375,7 @@</span><br><span> #=
endif /* if ENABLE_IP_PKTINFO */</span><br><span> </span><br><span> ssize_t=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_read_udp_=
posix(struct link_socket *sock, struct buffer *buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+link_socket_read_udp_posix(const struct l=
ink_socket *sock, struct buffer *buf,</span><br><span>                     =
       struct link_socket_actual *from)</span><br><span> {</span><br><span>=
     ssize_t recvlen;</span><br><span>@@ -2438,7 +2438,7 @@</span><br><span=
> #if ENABLE_IP_PKTINFO</span><br><span> </span><br><span> ssize_t</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_udp_posix_se=
ndmsg(struct link_socket *sock, struct buffer *buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+link_socket_write_udp_posix_sendmsg(const=
 struct link_socket *sock, const struct buffer *buf,</span><br><span>      =
                               struct link_socket_actual *to)</span><br><sp=
an> {</span><br><span>     struct iovec iov;</span><br><span>@@ -2634,7 +26=
34,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-socket_send_queue(struct link_s=
ocket *sock, struct buffer *buf, const struct link_socket_actual *to)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_send_queue(struct =
link_socket *sock, const struct buffer *buf, const struct link_socket_actua=
l *to)</span><br><span> {</span><br><span>     if (sock-&gt;writes=2Eiostat=
e =3D=3D IOSTATE_INITIAL)</span><br><span>     {</span><br><span>@@ -2734,8=
 +2734,8 @@</span><br><span>     return sock-&gt;writes=2Eiostate;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_socka=
ddr_from_overlapped(struct overlapped_io *io, struct sockaddr *dst, int ove=
rlapped_ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_sockaddr_f=
rom_overlapped(const struct overlapped_io *io, struct sockaddr *dst, int ov=
erlapped_ret)</span><br><span> {</span><br><span>     if (overlapped_ret &g=
t;=3D 0 &amp;&amp; io-&gt;addr_defined)</span><br><span>     {</span><br><s=
pan>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br>=
<span>index c6a29f4=2E=2Eaea9f42 100644</span><br><span>--- a/src/openvpn/s=
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
span>     return send(sock-&gt;sd, CBPTR(buf), BLENZ(buf), MSG_NOSIGNAL);</=
span><br><span> }</span><br><span>@@ -772,7 +772,7 @@</span><br><span>  * f=
rom tunnel packet=2E</span><br><span>  */</span><br><span> static inline vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_set_tos=
(struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+link_socket_set_tos(const struct link_socket *sock)</span><br><span>=
 {</span><br><span>     if (sock &amp;&amp; sock-&gt;ptos_defined)</span><b=
r><span>     {</span><br><span>@@ -818,6 +818,8 @@</span><br><span>     }</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* cppcheck-suppress constParameterPointer</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * sock is modified on Windows via &=
amp;sock-&gt;listen_handle */</span><br><span> static inline void</span><br=
><span> socket_reset_listen_persistent(struct link_socket *sock)</span><br>=
<span> {</span><br><span>diff --git a/src/openvpn/socket_util=2Eh b/src/ope=
nvpn/socket_util=2Eh</span><br><span>index 13f5962=2E=2Eadd08ba 100644</spa=
n><br><span>--- a/src/openvpn/socket_util=2Eh</span><br><span>+++ b/src/ope=
nvpn/socket_util=2Eh</span><br><span>@@ -439,7 +439,7 @@</span><br><span> <=
/span><br><span> </span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-addrlist_match_proto(const struct openvpn_s=
ockaddr *a1, struct addrinfo *addr_list, const int proto)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+addrlist_match_proto(const struct ope=
nvpn_sockaddr *a1, const struct addrinfo *addr_list, const int proto)</span=
><br><span> {</span><br><span>     return link_socket_proto_connection_orie=
nted(proto) ? addrlist_match(a1, addr_list)</span><br><span>               =
                                          : addrlist_port_match(a1, addr_li=
st);</span><br><span>diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=
=2Ec</span><br><span>index 19f3d54=2E=2Eff3c590 100644</span><br><span>--- =
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
@ -323,8 +323,7 @@</span><br><span>         return port;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct servent *service;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    service =3D getservbyname(servname, NULL);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct servent *service =3D ge=
tservbyname(servname, NULL);</span><br><span>     if (service)</span><br><s=
pan>     {</span><br><span>         return service-&gt;s_port;</span><br><s=
pan>@@ -334,11 +333,11 @@</span><br><span> }</span><br><span> </span><br><s=
pan> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-establish_so=
cks_proxy_passthru(struct socks_proxy_info *p,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+establish_socks_proxy_passthru(const struct sock=
s_proxy_info *p,</span><br><span>                                socket_des=
criptor_t sd, /* already open to proxy */</span><br><span>                 =
               const char *host,       /* openvpn server remote */</span><b=
r><span>                                const char *servname,   /* openvpn =
server port */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                        struct event_timeout *server_poll_timeout,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
   const struct event_timeout *server_poll_timeout,</span><br><span>       =
                         struct signal_info *sig_info)</span><br><span> {</=
span><br><span>     char buf[270];</span><br><span>@@ -392,10 +391,10 @@</s=
pan><br><span> }</span><br><span> </span><br><span> void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-establish_socks_proxy_udpassoc(struct so=
cks_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+e=
stablish_socks_proxy_udpassoc(const struct socks_proxy_info *p,</span><br><=
span>                                socket_descriptor_t ctrl_sd, /* alread=
y open to proxy */</span><br><span>                                struct o=
penvpn_sockaddr *relay_addr,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                               struct event_timeout *server_poll_tim=
eout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                 const struct event_timeout *server_poll_timeout,</span><br=
><span>                                struct signal_info *sig_info)</span>=
<br><span> {</span><br><span>     if (!socks_handshake(p, ctrl_sd, server_p=
oll_timeout, &amp;sig_info-&gt;signal_received))</span><br><span>diff --git=
 a/src/openvpn/socks=2Eh b/src/openvpn/socks=2Eh</span><br><span>index 8461=
13d=2E=2Ef7c93b6 100644</span><br><span>--- a/src/openvpn/socks=2Eh</span><=
br><span>+++ b/src/openvpn/socks=2Eh</span><br><span>@@ -47,17 +47,17 @@</s=
pan><br><span> </span><br><span> void socks_proxy_close(struct socks_proxy_=
info *sp);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void establish_socks_proxy_passthru(struct socks_proxy_info *p,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void establish_socks_pro=
xy_passthru(const struct socks_proxy_info *p,</span><br><span>             =
                        socket_descriptor_t sd, /* already open to proxy */=
</span><br><span>                                     const char *host,    =
   /* openvpn server remote */</span><br><span>                            =
         const char *servname,   /* openvpn server port */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                    st=
ruct event_timeout *server_poll_timeout,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                    const struct event=
_timeout *server_poll_timeout,</span><br><span>                            =
         struct signal_info *sig_info);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void establish_socks_proxy_udpassoc(str=
uct socks_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void establish_socks_proxy_udpassoc(const struct socks_proxy_info *p,<=
/span><br><span>                                     socket_descriptor_t ct=
rl_sd, /* already open to proxy */</span><br><span>                        =
             struct openvpn_sockaddr *relay_addr,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                    struct even=
t_timeout *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                    const struct event_timeout =
*server_poll_timeout,</span><br><span>                                     =
struct signal_info *sig_info);</span><br><span> </span><br><span> void sock=
s_process_incoming_udp(struct buffer *buf, struct link_socket_actual *from)=
;</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</s=
pan><br><span>index 58f0f28=2E=2E72e71b3 100644</span><br><span>--- a/src/o=
penvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@=
 -1171,7 +1171,7 @@</span><br><span> }</span><br><span> </span><br><span> s=
truct tls_multi *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_=
multi_init(struct tls_options *tls_options)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+tls_multi_init(const struct tls_options *tls_option=
s)</span><br><span> {</span><br><span>     struct tls_multi *ret;</span><br=
><span> </span><br><span>@@ -1212,7 +1212,7 @@</span><br><span>  */</span><=
br><span> </span><br><span> struct tls_auth_standalone *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-tls_auth_standalone_init(struct tls_opti=
ons *tls_options, struct gc_arena *gc)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tls_auth_standalone_init(const struct tls_options *tls_o=
ptions, struct gc_arena *gc)</span><br><span> {</span><br><span>     struct=
 tls_auth_standalone *tas;</span><br><span> </span><br><span>@@ -1360,7 +13=
60,7 @@</span><br><span> </span><br><span> static void</span><br><span> ini=
t_epoch_keys(struct key_state *ks, struct tls_multi *multi, const struct ke=
y_type *key_type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            bool server, struct key2 *key2)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                bool server, const struct key2 *key=
2)</span><br><span> {</span><br><span>     /* For now we hardcode this to b=
e 4 for the software based data channel</span><br><span>      * DCO based i=
mplementations/HW implementation might adjust this number</span><br><span>@=
@ -1601,8 +1601,9 @@</span><br><span> </span><br><span> bool</span><br><spa=
n> tls_session_update_crypto_params_do_work(struct tls_multi *multi, struct=
 tls_session *session,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                         struct options *options, struct f=
rame *frame,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                                struct frame *frame_fragment, struct link_s=
ocket_info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                      const struct options *options, struct=
 frame *frame,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                    struct frame *frame_fragment,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
            const struct link_socket_info *lsi,</span><br><span>           =
                               dco_context_t *dco)</span><br><span> {</span=
><br><span>     if (session-&gt;key[KS_PRIMARY]=2Ecrypto_options=2Ekey_ctx_=
bi=2Einitialized)</span><br><span>@@ -1671,7 +1672,7 @@</span><br><span> bo=
ol</span><br><span> tls_session_update_crypto_params(struct tls_multi *mult=
i, struct tls_session *session,</span><br><span>                           =
       struct options *options, struct frame *frame,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                 struct fra=
me *frame_fragment, struct link_socket_info *lsi,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                 struct frame=
 *frame_fragment, const struct link_socket_info *lsi,</span><br><span>     =
                             dco_context_t *dco)</span><br><span> {</span><=
br><span>     if (!check_session_cipher(session, options))</span><br><span>=
@@ -1887,7 +1888,8 @@</span><br><span> }</span><br><span> </span><br><span>=
 static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-push_peer=
_info_peerid(struct buffer *out, struct tls_multi *multi, struct tls_sessio=
n *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_pee=
r_info_peerid(struct buffer *out, const struct tls_multi *multi,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                      const st=
ruct tls_session *session)</span><br><span> {</span><br><span>     if (mult=
i-&gt;rx_peer_id =3D=3D MAX_PEER_ID || session-&gt;opt-&gt;dco_enabled)</sp=
an><br><span>     {</span><br><span>@@ -1922,7 +1924,7 @@</span><br><span> =
 * @return          true if no error was encountered</span><br><span>  */</=
span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-push_peer_info(struct buffer *buf, struct tls_multi *multi, struct tl=
s_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
push_peer_info(struct buffer *buf, const struct tls_multi *multi, struct tl=
s_session *session)</span><br><span> {</span><br><span>     struct gc_arena=
 gc =3D gc_new();</span><br><span>     bool ret =3D false;</span><br><span>=
@@ -2566,8 +2568,8 @@</span><br><span> }</span><br><span> </span><br><span>=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-session_skip_to_=
pre_start(struct tls_session *session, struct tls_pre_decrypt_state *state,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
     struct link_socket_actual *from)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+session_skip_to_pre_start(struct tls_session *session, co=
nst struct tls_pre_decrypt_state *state,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                          const struct link_socket_act=
ual *from)</span><br><span> {</span><br><span>     struct key_state *ks =3D=
 &amp;session-&gt;key[KS_PRIMARY];</span><br><span>     ks-&gt;session_id_r=
emote =3D state-&gt;peer_session_id;</span><br><span>@@ -2785,7 +2787,7 @@<=
/span><br><span> </span><br><span> static bool</span><br><span> check_outgo=
ing_ciphertext(struct key_state *ks, struct tls_session *session,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                          struc=
t buffer *to_link, bool *continue_tls_process)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                          const struct buffer *t=
o_link, bool *continue_tls_process)</span><br><span> {</span><br><span>    =
 if (to_link-&gt;len)</span><br><span>     {</span><br><span>@@ -4126,7 +41=
28,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-tls_post_encrypt(struct tls_mu=
lti *multi, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+tls_post_encrypt(struct tls_multi *multi, const struct buffer *=
buf)</span><br><span> {</span><br><span>     struct key_state *ks =3D multi=
-&gt;save_ks;</span><br><span>     multi-&gt;save_ks =3D NULL;</span><br><s=
pan>@@ -4257,7 +4259,7 @@</span><br><span>  * into a garbage collectable st=
ring which is returned=2E</span><br><span>  */</span><br><span> const char =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-protocol_dump(struct=
 buffer *buffer, unsigned int flags, struct gc_arena *gc)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+protocol_dump(const struct buffer *bu=
ffer, unsigned int flags, struct gc_arena *gc)</span><br><span> {</span><br=
><span>     struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span>  =
   struct buffer buf =3D *buffer;</span><br><span>diff --git a/src/openvpn/=
ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 7ddf965=2E=2E93e6200 10=
0644</span><br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src/op=
envpn/ssl=2Eh</span><br><span>@@ -166,7 +166,7 @@</span><br><span>  *</span=
><br><span>  * @return A newly allocated and initialized \c tls_multi struc=
ture=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-struct tls_multi *tls_multi_init(struct tls_options *tls_options);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_multi *tls=
_multi_init(const struct tls_options *tls_options);</span><br><span> </span=
><br><span> /**</span><br><span>  * Finalize initialization of a \c tls_mul=
ti structure=2E</span><br><span>@@ -187,7 +187,7 @@</span><br><span> /*</sp=
an><br><span>  * Initialize a standalone tls-auth verification object=2E</s=
pan><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-str=
uct tls_auth_standalone *tls_auth_standalone_init(struct tls_options *tls_o=
ptions,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_a=
uth_standalone *tls_auth_standalone_init(const struct tls_options *tls_opti=
ons,</span><br><span>                                                      =
struct gc_arena *gc);</span><br><span> </span><br><span> /**</span><br><spa=
n>@@ -371,7 +371,7 @@</span><br><span>  * @param multi - The TLS state for =
this packet&#39;s destination VPN tunnel=2E</span><br><span>  * @param buf =
- The buffer containing the outgoing packet=2E</span><br><span>  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void tls_post_encrypt(struct =
tls_multi *multi, struct buffer *buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void tls_post_encrypt(struct tls_multi *multi, const str=
uct buffer *buf);</span><br><span> </span><br><span> /** @} name Functions =
for managing security parameter state for data channel packets */</span><br=
><span> </span><br><span>@@ -461,7 +461,8 @@</span><br><span>  */</span><br=
><span> bool tls_session_update_crypto_params(struct tls_multi *multi, stru=
ct tls_session *session,</span><br><span>                                  =
     struct options *options, struct frame *frame,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                      struct f=
rame *frame_fragment, struct link_socket_info *lsi,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                      str=
uct frame *frame_fragment,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                      const struct link_socket_info =
*lsi,</span><br><span>                                       dco_context_t =
*dco);</span><br><span> </span><br><span> /*</span><br><span>@@ -525,7 +526=
,7 @@</span><br><span> #define PD_VERBOSE                 (1 &lt;&lt; 10)</=
span><br><span> #define PD_TLS_CRYPT               (1 &lt;&lt; 11)</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *=
protocol_dump(struct buffer *buffer, unsigned int flags, struct gc_arena *g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *prot=
ocol_dump(const struct buffer *buffer, unsigned int flags, struct gc_arena =
*gc);</span><br><span> </span><br><span> /*</span><br><span>  * debugging c=
ode</span><br><span>@@ -573,7 +574,7 @@</span><br><span> /* Special method =
to skip the three way handshake RESET stages=2E This is</span><br><span>  *=
 used by the HMAC code when seeing a packet that matches the previous</span=
><br><span>  * HMAC based stateless server state */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool session_skip_to_pre_start(struct tls_s=
ession *session, struct tls_pre_decrypt_state *state,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                               struct link_=
socket_actual *from);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool session_skip_to_pre_start(struct tls_session *session, const struct =
tls_pre_decrypt_state *state,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                               const struct link_socket_actual *f=
rom);</span><br><span> </span><br><span> #endif /* ifndef OPENVPN_SSL_H */<=
/span><br><span>diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_=
backend=2Eh</span><br><span>index a6d57f2=2E=2E29e07a6 100644</span><br><sp=
an>--- a/src/openvpn/ssl_backend=2Eh</span><br><span>+++ b/src/openvpn/ssl_=
backend=2Eh</span><br><span>@@ -137,7 +137,7 @@</span><br><span>  *</span><=
br><span>  * @return      true if the context is initialised, false if not=
=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-bool tls_ctx_initialised(struct tls_root_ctx *ctx);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool tls_ctx_initialised(const struct tl=
s_root_ctx *ctx);</span><br><span> </span><br><span> /**</span><br><span>  =
* Set any library specific options=2E</span><br><span>@@ -170,7 +170,7 @@</=
span><br><span>  * @param ciphers       String containing : delimited ciphe=
r names, or NULL to use</span><br><span>  *                                =
      sane defaults=2E</span><br><span>  */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void tls_ctx_restrict_ciphers_tls13(struct tls_root_c=
tx *ctx, const char *ciphers);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *c=
tx, const char *ciphers);</span><br><span> </span><br><span> /**</span><br>=
<span>  * Set the TLS certificate profile=2E  The profile defines which cry=
pto</span><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/=
ssl_mbedtls=2Ec</span><br><span>index c92c423=2E=2Ecddf856 100644</span><br=
><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/=
ssl_mbedtls=2Ec</span><br><span>@@ -146,7 +146,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-tls_ctx_initialised(struct tls_root_ctx *ctx)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_initialised(const struct tl=
s_root_ctx *ctx)</span><br><span> {</span><br><span>     /* either this sho=
uld be NULL or should be non-null and then have a</span><br><span>      * v=
alid TLS ctx inside as well */</span><br><span>@@ -269,7 +269,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-tls_ctx_restrict_ciphers_tls13(struct tls_root=
_ctx *ctx, const char *ciphers)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, =
const char *ciphers)</span><br><span> {</span><br><span>     if (ciphers =
=3D=3D NULL)</span><br><span>     {</span><br><span>diff --git a/src/openvp=
n/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index 7cfe9=
f4=2E=2Ecb3de65 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</s=
pan><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -129,7 +=
129,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_initialised(struct tl=
s_root_ctx *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls=
_ctx_initialised(const struct tls_root_ctx *ctx)</span><br><span> {</span><=
br><span>     /* either this should be NULL or should be non-null and then =
have a</span><br><span>      * valid TLS ctx inside as well */</span><br><s=
pan>@@ -446,7 +446,7 @@</span><br><span> #endif</span><br><span> </span><br=
><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_r=
estrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_restrict_ciphers_t=
ls13(const struct tls_root_ctx *ctx, const char *ciphers)</span><br><span> =
{</span><br><span>     if (ciphers =3D=3D NULL)</span><br><span>     {</spa=
n><br><span>@@ -1093,7 +1093,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-tls_ctx_load_cert_uri(struct tls_root_ctx *tls_ctx, const char *uri)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_load_cert_uri(c=
onst struct tls_root_ctx *tls_ctx, const char *uri)</span><br><span> {</spa=
n><br><span> #if defined(HAVE_OPENSSL_STORE_API)</span><br><span>     X509 =
*x =3D NULL;</span><br><span>@@ -2008,7 +2008,7 @@</span><br><span> }</span=
><br><span> </span><br><span> static void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-bio_debug_data(const char *mode, BIO *bio, const uint8_=
t *buf, int len, const char *desc)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bio_debug_data(const char *mode, const BIO *bio, const uint8=
_t *buf, int len, const char *desc)</span><br><span> {</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span>     if (len &gt; 0)</spa=
n><br><span>@@ -2022,7 +2022,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-bio_debug_oc(const char *mode, BIO *bio)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bio_debug_oc(const char *mode, const BIO *bio)</spa=
n><br><span> {</span><br><span>     open_biofp();</span><br><span>     fpri=
ntf(biofp, &quot;BIO %s time=3D%&quot; PRIi64 &quot; bio=3D&quot; ptr_forma=
t &quot;\n&quot;, mode, (int64_t)time(NULL),</span><br><span>diff --git a/s=
rc/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 90b2=
aec=2E=2E60b005f 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span=
><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -118,7 +118,7 @=
@</span><br><span>  */</span><br><span> static void</span><br><span> tls_wr=
ap_control(struct tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                 struct =
session_id *session_id)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 const struct session_id *session_id)</span><br><span> =
{</span><br><span>     if (ctx-&gt;mode =3D=3D TLS_WRAP_AUTH || ctx-&gt;mod=
e =3D=3D TLS_WRAP_NONE)</span><br><span>     {</span><br><span>@@ -402,9 +4=
02,9 @@</span><br><span> </span><br><span> </span><br><span> struct buffer<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_reset_standalone(s=
truct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                     struct session_id =
*own_sid, struct session_id *remote_sid, uint8_t header,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                     bool request_resend=
_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_reset_stan=
dalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                     co=
nst struct session_id *own_sid, const struct session_id *remote_sid,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                     uint8=
_t header, bool request_resend_wkc)</span><br><span> {</span><br><span>    =
 /* Copy buffer here to point at the same data but allow tls_wrap_control</=
span><br><span>      * to potentially change buf to point to another buffer=
 without</span><br><span>@@ -489,7 +489,7 @@</span><br><span> bool</span><b=
r><span> check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,=
</span><br><span>                               const struct openvpn_sockad=
dr *from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                  uint8_t *key,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                              const uint8_t *key,</span><br><sp=
an>                               int handwindow,</span><br><span>         =
                      bool pkt_is_ack)</span><br><span> {</span><br><span>d=
iff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><sp=
an>index 03e8930=2E=2E8203e4a 100644</span><br><span>--- a/src/openvpn/ssl_=
pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -1=
83,7 +183,7 @@</span><br><span>  * @return              the expected server=
 session id</span><br><span>  */</span><br><span> bool check_session_hmac_a=
nd_pkt_id(struct tls_pre_decrypt_state *state, const struct openvpn_sockadd=
r *from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                      uint8_t *key, int handwindow, bool pkt_is_ack);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
          const uint8_t *key, int handwindow, bool pkt_is_ack);</span><br><=
span> </span><br><span> /*</span><br><span>  * Write a control channel auth=
entication record=2E</span><br><span>@@ -210,8 +210,9 @@</span><br><span>  =
* from the tls pre decrypt state=2E</span><br><span>  *</span><br><span>  *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer tls_re=
set_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
            struct session_id *own_sid, struct session_id *remote_sid,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer tls_reset_=
standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                const struct session_id *own_sid,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                   const stru=
ct session_id *remote_sid,</span><br><span>                                =
    uint8_t header, bool request_resend_wkc);</span><br><span> </span><br><=
span> </span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvp=
n/ssl_verify=2Ec</span><br><span>index 3653eb4=2E=2E0e40370 100644</span><b=
r><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/=
ssl_verify=2Ec</span><br><span>@@ -1139,7 +1139,7 @@</span><br><span>  * ca=
che=2E</span><br><span>  */</span><br><span> static bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-tls_authentication_status_use_cache(stru=
ct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+tls_authentication_status_use_cache(const struct tls_multi *multi)</span><=
br><span> {</span><br><span>     unsigned int idx =3D min_uint(multi-&gt;ta=
s_cache_num_updates, SIZE(cache_intervals) - 1);</span><br><span>     time_=
t latency =3D cache_intervals[idx];</span><br><span>@@ -1283,7 +1283,7 @@</=
span><br><span>  * Check if the script/plugin left a message in the auth fa=
iled message</span><br><span>  * file and relay it to the user */</span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ch=
eck_for_client_reason(struct tls_multi *multi, struct auth_deferred_status =
*status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_for_c=
lient_reason(struct tls_multi *multi, const struct auth_deferred_status *st=
atus)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new=
();</span><br><span>     const char *msg =3D key_state_check_auth_failed_me=
ssage_file(status, &amp;gc);</span><br><span>@@ -1552,7 +1552,7 @@</span><b=
r><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><=
span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set_=
verify_user_pass_env(struct user_pass *up, struct tls_multi *multi, struct =
tls_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+set_verify_user_pass_env(const struct user_pass *up, struct tls_multi *mu=
lti, struct tls_session *session)</span><br><span> {</span><br><span>     /=
* Is username defined? */</span><br><span>     if ((session-&gt;opt-&gt;ssl=
_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up-&gt;username))</spa=
n><br><span>@@ -1580,7 +1580,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssl_=
verify_username_length(struct tls_session *session, const char *username)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_verify_username_l=
ength(const struct tls_session *session, const char *username)</span><br><s=
pan> {</span><br><span>     if ((session-&gt;opt-&gt;ssl_flags &amp; SSLF_U=
SERNAME_AS_COMMON_NAME)</span><br><span>         &amp;&amp; strlen(username=
) &gt; TLS_USERNAME_LEN)</span><br><span>diff --git a/src/openvpn/ssl_verif=
y=2Eh b/src/openvpn/ssl_verify=2Eh</span><br><span>index 3176d76=2E=2Ee77bc=
4a 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Eh</span><br><span>=
+++ b/src/openvpn/ssl_verify=2Eh</span><br><span>@@ -202,7 +202,7 @@</span>=
<br><span>  * @return              true if name is under limit or username-=
as-common-name</span><br><span>  *                      is not active</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool s=
sl_verify_username_length(struct tls_session *session, const char *username=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ssl_verify_u=
sername_length(const struct tls_session *session, const char *username);</s=
pan><br><span> </span><br><span> /**</span><br><span>  * Runs the --client-=
crresponse script if one is defined=2E</span><br><span>@@ -275,7 +275,7 @@<=
/span><br><span> void auth_set_client_reason(struct tls_multi *multi, const=
 char *client_reason);</span><br><span> </span><br><span> static inline con=
st char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_client_r=
eason(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+tls_client_reason(const struct tls_multi *multi)</span><br><span=
> {</span><br><span>     return multi-&gt;client_reason;</span><br><span> }=
</span><br><span>diff --git a/src/openvpn/status=2Ec b/src/openvpn/status=
=2Ec</span><br><span>index c7d375b=2E=2Ecfbc38d 100644</span><br><span>--- =
a/src/openvpn/status=2Ec</span><br><span>+++ b/src/openvpn/status=2Ec</span=
><br><span>@@ -135,7 +135,7 @@</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-status_=
reset(struct status_output *so)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+status_reset(const struct status_output *so)</span><br><span> {=
</span><br><span>     if (so &amp;&amp; so-&gt;fd &gt;=3D 0)</span><br><spa=
n>     {</span><br><span>diff --git a/src/openvpn/status=2Eh b/src/openvpn/=
status=2Eh</span><br><span>index 7953a4e=2E=2E4c01d75 100644</span><br><spa=
n>--- a/src/openvpn/status=2Eh</span><br><span>+++ b/src/openvpn/status=2Eh=
</span><br><span>@@ -69,7 +69,7 @@</span><br><span> </span><br><span> bool =
status_trigger(struct status_output *so);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void status_reset(struct status_outpu=
t *so);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void status_=
reset(const struct status_output *so);</span><br><span> </span><br><span> v=
oid status_flush(struct status_output *so);</span><br><span> </span><br><sp=
an>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>i=
ndex af48921=2E=2Eabb46af 100644</span><br><span>--- a/src/openvpn/tun=2Ec<=
/span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -835,7 +835,7 =
@@</span><br><span>          const char *ifconfig_ipv6_local_parm,     /* -=
-ifconfig parm 1 IPv6 */</span><br><span>          int ifconfig_ipv6_netbit=
s_parm,</span><br><span>          const char *ifconfig_ipv6_remote_parm,   =
 /* --ifconfig parm 2 IPv6 */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         struct addrinfo *local_public, struct addrinfo *remote_pub=
lic, const bool strict_warn,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         const struct addrinfo *local_public, const struct addrinf=
o *remote_public, const bool strict_warn,</span><br><span>          struct =
env_set *es, openvpn_net_ctx_t *ctx, struct tuntap *tt)</span><br><span> {<=
/span><br><span>     if (!tt)</span><br><span>@@ -978,7 +978,7 @@</span><br=
><span>  * -&gt; helper function to simplify code below</span><br><span>  *=
/</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-add_route_connected_v6_net(struct tuntap *tt, const struct env_set=
 *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_route_conn=
ected_v6_net(const struct tuntap *tt, const struct env_set *es)</span><br><=
span> {</span><br><span>     struct route_ipv6 r6;</span><br><span> </span>=
<br><span>@@ -1020,7 +1020,7 @@</span><br><span>  */</span><br><span> </spa=
n><br><span> in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-create_arbitrary_remote(struct tuntap *tt)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+create_arbitrary_remote(const struct tuntap *tt)</s=
pan><br><span> {</span><br><span>     in_addr_t remote;</span><br><span> </=
span><br><span>@@ -1592,7 +1592,7 @@</span><br><span> }</span><br><span> </=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv4(const st=
ruct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span=
> #if defined(TARGET_LINUX)</span><br><span>     int netbits =3D netmask_to=
_netbits2(tt-&gt;remote_netmask);</span><br><span>@@ -1627,7 +1627,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv6(struct tuntap *=
tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx)=
</span><br><span> {</span><br><span> #if defined(TARGET_LINUX)</span><br><s=
pan>     if (net_addr_v6_del(ctx, tt-&gt;actual_name, &amp;tt-&gt;local_ipv=
6, tt-&gt;netbits_ipv6) &lt; 0)</span><br><span>@@ -1652,7 +1652,7 @@</span=
><br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig(struct tuntap *tt, openvpn_ne=
t_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+undo_i=
fconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {=
</span><br><span>     if (tt-&gt;backend_driver !=3D DRIVER_NULL &amp;&amp;=
 tt-&gt;backend_driver !=3D DRIVER_AFUNIX)</span><br><span>     {</span><br=
><span>@@ -1720,7 +1720,7 @@</span><br><span> }</span><br><span> </span><br=
><span> static ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-write_tun_header(struct tuntap *tt, uint8_t *buf, int len)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+write_tun_header(const struct tunta=
p *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span>    =
 if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><spa=
n>@@ -1737,9 +1737,11 @@</span><br><span>             type =3D htonl(AF_INE=
T);</span><br><span>         }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* argument to writev is a pointer to =
const but we still need to drop</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * the const from buf pointer here */</span><br><span> =
        iv[0]=2Eiov_base =3D &amp;type;</span><br><span>         iv[0]=2Eio=
v_len =3D sizeof(type);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        iv[1]=2Eiov_base =3D buf;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        iv[1]=2Eiov_base =3D (void *)buf;</span><br><span> =
        iv[1]=2Eiov_len =3D len;</span><br><span> </span><br><span>        =
 return header_modify_read_write_return(writev(tt-&gt;fd, iv, 2));</span><b=
r><span>@@ -1751,7 +1753,7 @@</span><br><span> }</span><br><span> </span><b=
r><span> static ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-read_tun_header(struct tuntap *tt, uint8_t *buf, int len)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+read_tun_header(const struct tuntap=
 *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     if (tt=
-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -1=
777,13 +1779,13 @@</span><br><span>  */</span><br><span> #if !defined(TARGE=
T_DARWIN)</span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap =
*tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span>     r=
eturn write_tun_header(tt, buf, len);</span><br><span> }</span><br><span> <=
/span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t=
 *buf, int len)</span><br><span> {</span><br><span>     return read_tun_hea=
der(tt, buf, len);</span><br><span> }</span><br><span>@@ -1799,7 +1801,7 @@=
</span><br><span> </span><br><span> #if defined(TARGET_LINUX) || defined(TA=
RGET_FREEBSD)</span><br><span> static bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-tun_dco_enabled(struct tuntap *tt)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+tun_dco_enabled(const struct tuntap *tt=
)</span><br><span> {</span><br><span>     return tt-&gt;backend_driver =3D=
=3D DRIVER_DCO;</span><br><span> }</span><br><span>@@ -2046,13 +2048,13 @@<=
/span><br><span> }</span><br><span> </span><br><span> ssize_t</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_=
t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wri=
te_tun(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><spa=
n> {</span><br><span>     return write(tt-&gt;fd, buf, len);</span><br><spa=
n> }</span><br><span> </span><br><span> ssize_t</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const str=
uct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span> =
    return read(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span>@@=
 -2251,13 +2253,13 @@</span><br><span> }</span><br><span> </span><br><span>=
 ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(str=
uct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t *buf, i=
nt len)</span><br><span> {</span><br><span>     return write(tt-&gt;fd, buf=
, len);</span><br><span> }</span><br><span> </span><br><span> ssize_t</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt,=
 uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</span><br><spa=
n> {</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><span=
> }</span><br><span>@@ -2587,7 +2589,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, c=
onst uint8_t *buf, int len)</span><br><span> {</span><br><span>     struct =
strbuf sbuf;</span><br><span>     sbuf=2Elen =3D len;</span><br><span>@@ -2=
596,7 +2598,7 @@</span><br><span> }</span><br><span> </span><br><span> ssiz=
e_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tu=
ntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</span=
><br><span> {</span><br><span>     struct strbuf sbuf;</span><br><span>    =
 int f =3D 0;</span><br><span>@@ -3094,7 +3096,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tun=
tap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span>  =
   if (tt-&gt;backend_driver =3D=3D DRIVER_UTUN)</span><br><span>     {</sp=
an><br><span>@@ -3107,7 +3109,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *b=
uf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;backend_dri=
ver =3D=3D DRIVER_UTUN)</span><br><span>     {</span><br><span>@@ -3311,7 +=
3313,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-tun_write_queue(struct tuntap=
 *tt, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+tun_write_queue(struct tuntap *tt, const struct buffer *buf)</span><b=
r><span> {</span><br><span>     if (tt-&gt;writes=2Eiostate =3D=3D IOSTATE_=
INITIAL)</span><br><span>     {</span><br><span>@@ -3366,7 +3368,7 @@</span=
><br><span> }</span><br><span> </span><br><span> int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tun_write_win32(struct tuntap *tt, struct b=
uffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_writ=
e_win32(struct tuntap *tt, const struct buffer *buf)</span><br><span> {</sp=
an><br><span>     int err =3D 0;</span><br><span>     int status =3D 0;</sp=
an><br><span>@@ -5374,7 +5376,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-for=
k_register_dns_action(struct tuntap *tt)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+fork_register_dns_action(const struct tuntap *tt)</spa=
n><br><span> {</span><br><span>     if (tt &amp;&amp; tt-&gt;options=2Eregi=
ster_dns &amp;&amp; tt-&gt;options=2Emsg_channel)</span><br><span>     {</s=
pan><br><span>@@ -5464,7 +5466,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-tuntap_get_mtu(struct tuntap *tt)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tuntap_get_mtu(const struct tuntap *tt)</span><br><span>=
 {</span><br><span>     ULONG mtu =3D 0;</span><br><span>     DWORD len;</s=
pan><br><span>@@ -6039,7 +6041,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tu=
n_show_debug(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+tun_show_debug(const struct tuntap *tt)</span><br><span> {</spa=
n><br><span>     if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOW=
S6)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/tun=2Eh=
 b/src/openvpn/tun=2Eh</span><br><span>index 2477560=2E=2E0ff2a0b 100644</s=
pan><br><span>--- a/src/openvpn/tun=2Eh</span><br><span>+++ b/src/openvpn/t=
un=2Eh</span><br><span>@@ -272,9 +272,9 @@</span><br><span> </span><br><spa=
n> void close_tun_handle(struct tuntap *tt);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-ssize_t write_tun(struct tuntap *t=
t, uint8_t *buf, int len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ssize_t write_tun(const struct tuntap *tt, const uint8_t *buf, int l=
en);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-ssize_t read_tun(struct tuntap *tt, uint8_t *buf, int len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ssize_t read_tun(const struct tunt=
ap *tt, uint8_t *buf, int len);</span><br><span> </span><br><span> #ifdef E=
NABLE_FEATURE_TUN_PERSIST</span><br><span> void tuncfg(const char *dev, con=
st char *dev_type, const char *dev_node, int persist_mode,</span><br><span>=
@@ -293,7 +293,7 @@</span><br><span>                         const char *if=
config_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */</span><br><span>=
                         int ifconfig_ipv6_netbits_parm,           /* --ifc=
onfig parm 1 / bits */</span><br><span>                         const char =
*ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        struct addr=
info *local_public, struct addrinfo *remote_public,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        const struct addr=
info *local_public, const struct addrinfo *remote_public,</span><br><span> =
                        const bool strict_warn, struct env_set *es, openvpn=
_net_ctx_t *ctx,</span><br><span>                         struct tuntap *tt=
);</span><br><span> </span><br><span>@@ -320,7 +320,7 @@</span><br><span>  =
* @param tt    the tuntap interface context</span><br><span>  * @param ctx =
  the networking API opaque context</span><br><span>  */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void undo_ifconfig(struct tuntap *tt, op=
envpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx);</sp=
an><br><span> </span><br><span> bool is_dev_type(const char *dev, const cha=
r *dev_type, const char *match_type);</span><br><span> </span><br><span>@@ =
-351,7 +351,7 @@</span><br><span> #define IFCONFIG_DEFAULT IFCONFIG_AFTER_T=
UN_OPEN</span><br><span> </span><br><span> static inline int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-ifconfig_order(struct tuntap *tt)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_order(const s=
truct tuntap *tt)</span><br><span> {</span><br><span>     if (tt-&gt;backen=
d_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -3=
81,7 +381,7 @@</span><br><span> #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN=
</span><br><span> </span><br><span> static inline int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-route_order(struct tuntap *tt)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+route_order(const struct tuntap =
*tt)</span><br><span> {</span><br><span>     if (tt-&gt;backend_driver =3D=
=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -454,13 +454,1=
3 @@</span><br><span> </span><br><span> const char *tap_win_getinfo(const s=
truct tuntap *tt, struct gc_arena *gc);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void tun_show_debug(struct tuntap *tt);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tun_show_debug=
(const struct tuntap *tt);</span><br><span> </span><br><span> bool dhcp_rel=
ease_by_adapter_index(const DWORD adapter_index);</span><br><span> </span><=
br><span> bool dhcp_renew_by_adapter_index(const DWORD adapter_index);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void for=
k_register_dns_action(struct tuntap *tt);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void fork_register_dns_action(const struct tuntap *tt=
);</span><br><span> </span><br><span> void ipconfig_register_dns(const stru=
ct env_set *es);</span><br><span> </span><br><span>@@ -470,7 +470,7 @@</spa=
n><br><span> </span><br><span> int tun_read_queue(struct tuntap *tt, int ma=
xsize);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-int tun_write_queue(struct tuntap *tt, struct buffer *buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int tun_write_queue(struct tunt=
ap *tt, const struct buffer *buf);</span><br><span> </span><br><span> stati=
c inline bool</span><br><span> tuntap_stop(int status)</span><br><span>@@ -=
499,7 +499,7 @@</span><br><span>     return false;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int tun_w=
rite_win32(struct tuntap *tt, struct buffer *buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+int tun_write_win32(struct tuntap *tt, const=
 struct buffer *buf);</span><br><span> </span><br><span> static inline bool=
</span><br><span> is_ip_packet_valid(const struct buffer *buf)</span><br><s=
pan>@@ -529,13 +529,13 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-tuntap_is_dco_win(struct tuntap *tt)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tuntap_is_dco_win(const struct tuntap *tt)</span><br><sp=
an> {</span><br><span>     return tt &amp;&amp; tt-&gt;backend_driver =3D=
=3D DRIVER_DCO;</span><br><span> }</span><br><span> </span><br><span> stati=
c inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_i=
s_dco_win_timeout(struct tuntap *tt, ssize_t status)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const struct tu=
ntap *tt, ssize_t status)</span><br><span> {</span><br><span>     return tu=
ntap_is_dco_win(tt) &amp;&amp; (status &lt; 0) &amp;&amp; (openvpn_errno() =
=3D=3D ERROR_NETNAME_DELETED);</span><br><span> }</span><br><span>@@ -555,2=
5 +555,25 @@</span><br><span> }</span><br><span> </span><br><span> static i=
nline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_standby=
_init(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+tun_standby_init(const struct tuntap *tt)</span><br><span> {</span><br=
><span> }</span><br><span> </span><br><span> static inline bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-tun_standby(struct tuntap *tt)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_standby(const stru=
ct tuntap *tt)</span><br><span> {</span><br><span>     return true;</span><=
br><span> }</span><br><span> </span><br><span> </span><br><span> static inl=
ine bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco=
_win(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+tuntap_is_dco_win(const struct tuntap *tt)</span><br><span> {</span><br=
><span>     return false;</span><br><span> }</span><br><span> </span><br><s=
pan> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const =
struct tuntap *tt, ssize_t status)</span><br><span> {</span><br><span>     =
return false;</span><br><span> }</span><br><span>diff --git a/src/openvpn/t=
un_afunix=2Ec b/src/openvpn/tun_afunix=2Ec</span><br><span>index a67a472=2E=
=2Ee9223bc 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Ec</span><b=
r><span>+++ b/src/openvpn/tun_afunix=2Ec</span><br><span>@@ -48,7 +48,7 @@<=
/span><br><span> </span><br><span> </span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-tun_afunix_exec_child(const char=
 *dev_node, struct tuntap *tt, struct env_set *env)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tun_afunix_exec_child(const char *dev_nod=
e, struct tuntap *tt, const struct env_set *env)</span><br><span> {</span><=
br><span>     const char *msgprefix =3D &quot;ERROR: failure executing proc=
ess for tun:&quot;;</span><br><span>     struct argv argv =3D argv_new();</=
span><br><span>@@ -73,7 +73,7 @@</span><br><span> }</span><br><span> </span=
><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-open_=
tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set *o=
rig_env)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+open_tun_af=
unix(const struct options *o, int mtu, struct tuntap *tt, const struct env_=
set *orig_env)</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span> </span><br><span>diff --git a/src/openvpn/tu=
n_afunix=2Eh b/src/openvpn/tun_afunix=2Eh</span><br><span>index 5b6a8e0=2E=
=2Efb88eb2 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Eh</span><b=
r><span>+++ b/src/openvpn/tun_afunix=2Eh</span><br><span>@@ -31,7 +31,7 @@<=
/span><br><span>  * the user provided taking care of implementing the actua=
l tun</span><br><span>  * device=2E</span><br><span>  */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void open_tun_afunix(struct options *o, =
int mtu, struct tuntap *tt, struct env_set *env);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void open_tun_afunix(const struct options *o,=
 int mtu, struct tuntap *tt, const struct env_set *env);</span><br><span> <=
/span><br><span> </span><br><span> /**</span><br><span>diff --git a/src/ope=
nvpn/vlan=2Ec b/src/openvpn/vlan=2Ec</span><br><span>index 69ac10d=2E=2E04e=
18d6 100644</span><br><span>--- a/src/openvpn/vlan=2Ec</span><br><span>+++ =
b/src/openvpn/vlan=2Ec</span><br><span>@@ -288,7 +288,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-vlan_process_outgoing_tun(struct multi_context *m, str=
uct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+vlan_process_outgoing_tun(const struct multi_context *m, struct multi_i=
nstance *mi)</span><br><span> {</span><br><span>     if (!m-&gt;top=2Eoptio=
ns=2Evlan_tagging)</span><br><span>     {</span><br><span>diff --git a/src/=
openvpn/vlan=2Eh b/src/openvpn/vlan=2Eh</span><br><span>index 9389f89=2E=2E=
cd2f66f 100644</span><br><span>--- a/src/openvpn/vlan=2Eh</span><br><span>+=
++ b/src/openvpn/vlan=2Eh</span><br><span>@@ -35,6 +35,6 @@</span><br><span=
> </span><br><span> bool vlan_is_tagged(const struct buffer *buf);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void vlan_pr=
ocess_outgoing_tun(struct multi_context *m, struct multi_instance *mi);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void vlan_process_outgo=
ing_tun(const struct multi_context *m, struct multi_instance *mi);</span><b=
r><span> </span><br><span> #endif /* VLAN_H */</span><br><span>diff --git a=
/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh</span><br><span>index 8be3d9=
6=2E=2E39ff7d8 100644</span><br><span>--- a/src/openvpn/win32=2Eh</span><br=
><span>+++ b/src/openvpn/win32=2Eh</span><br><span>@@ -227,7 +227,7 @@</spa=
n><br><span> void overlapped_io_close(struct overlapped_io *o);</span><br><=
span> </span><br><span> static inline bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-overlapped_io_active(struct overlapped_io *o)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+overlapped_io_active(const s=
truct overlapped_io *o)</span><br><span> {</span><br><span>     return o-&g=
t;iostate =3D=3D IOSTATE_QUEUED || o-&gt;iostate =3D=3D IOSTATE_IMMEDIATE_R=
ETURN;</span><br><span> }</span><br><span>diff --git a/src/openvpnmsica/ope=
nvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>index a86=
1e8a=2E=2E25fa1e4 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsic=
a=2Ec</span><br><span>+++ b/src/openvpnmsica/openvpnmsica=2Ec</span><br><sp=
an>@@ -77,7 +77,7 @@</span><br><span>  * @return ERROR_SUCCESS on success; =
An error code otherwise</span><br><span>  */</span><br><span> static UINT</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-setup_sequence(_In_ MSI=
HANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ struct msica_arg_seq *seq)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+setup_sequence(_In_=
 MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ const struct msica_arg=
_seq *seq)</span><br><span> {</span><br><span>     UINT uiResult;</span><br=
><span>     LPWSTR szSequence =3D msica_arg_seq_join(seq);</span><br><span>=
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=
=2Ec</span><br><span>index 7819f5a=2E=2Ed5a2fd0 100644</span><br><span>--- =
a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/int=
eractive=2Ec</span><br><span>@@ -522,7 +522,7 @@</span><br><span> </span><b=
r><span> </span><br><span> static SOCKADDR_INET</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-sockaddr_inet(short family, inet_address_t *addr)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sockaddr_inet(short=
 family, const inet_address_t *addr)</span><br><span> {</span><br><span>   =
  SOCKADDR_INET sa_inet;</span><br><span>     ZeroMemory(&amp;sa_inet, size=
of(sa_inet));</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_ma=
nagement=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span=
>index 77f6ce2=2E=2Efff4c2b 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/mock_management=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/m=
ock_management=2Ec</span><br><span>@@ -36,7 +36,7 @@</span><br><span> struc=
t management *management; /* GLOBAL */</span><br><span> </span><br><span> v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_auth_fa=
ilure(struct management *man, const char *type, const char *reason)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+management_auth_failure(con=
st struct management *man, const char *type, const char *reason)</span><br>=
<span> {</span><br><span>     ASSERT(false);</span><br><span> }</span><br><=
span>diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit=
_tests/openvpn/siphash_openssl=2Ec</span><br><span>index c301f2d=2E=2E99a77=
63 100644</span><br><span>--- a/tests/unit_tests/openvpn/siphash_openssl=2E=
c</span><br><span>+++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec</span>=
<br><span>@@ -101,7 +101,7 @@</span><br><span> bool</span><br><span> siphas=
h_openssl_available(void *sip_context)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct siphash_context *sip =3D sip=
_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
struct siphash_context *sip =3D sip_context;</span><br><span> </span><br><s=
pan>     return (bool)(sip-&gt;mac);</span><br><span> }</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn=
/test_misc=2Ec</span><br><span>index a41c27b=2E=2Ea8daee6 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/te=
sts/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -146,7 +146,7 @@</s=
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
<div style=3D"display:none"> Gerrit-PatchSet: 22 </div>
<div style=3D=
"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razv=
anc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--an5raqUDWxU=--


--===============1276304446152474710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1276304446152474710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1276304446152474710==--

