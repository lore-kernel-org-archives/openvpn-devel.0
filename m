Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2725DC61DB9
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=AW+YYmrK4GVKGwWveDW5lOZDw1LO6ts8nM4bzlXIIXk=; b=QAKQbTcK0bmU5T
	X3/rEmmSg0ToHK4y1A9XViUQOyhtHWeWN8ThN3qRzut27uUynxD3++gpDnoBREjNC7+TuxQylbxDr
	rShy5sfNV3wlIsErsoLygi4iriNJCTOReCMYjHC2JsngJON7OpshTSG6xuz4AEhV0cl+a1qk0t1W+
	j1I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytLY-0006DH-Vq;
	Tue, 25 Aug 2026 15:45:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wytLW-0006D6-Rk
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:45:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YZqeTHA0l7gf+Po3VOfya1fhAQX3gs8MqR6PI9PCVcg=; b=R6sajYlr02ki67M+m/5NXBq85M
 sgSQA19iihj8wAEK92RVe3kTwMKqnJwG0tO3ldpicu+0LxY41vQcH8Ml52M/3YoHq0IQAKyyM0HYl
 rAHGvjKSKohnl29B0p28w7osOCWFAFprNrB/2P5/jUxFZfdRzcWniTSdTaum8nbIcYM0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YZqeTHA0l7gf+Po3VOfya1fhAQX3gs8MqR6PI9PCVcg=; b=A
 Sn/Fi3/n2+zp4lBoSK5WuXKV1RXG6WTDQWy0/SmTCMIxBJiutKb/TzSIcdgsJln/upqQ9CmbR1x5i
 b+U/4W+X7vjHPU2h4B78tFLhfXZmAA6GJL/88q6zMEJtz8CpuSQxm7eLrOYUW8Ze8qVB1H4zXHCUz
 Amcs5zx4PrZuPGUU=;
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytLV-0002D2-Ew for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:45:55 +0000
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so8664804a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787672747; x=1788277547; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YZqeTHA0l7gf+Po3VOfya1fhAQX3gs8MqR6PI9PCVcg=;
 b=g9hZPDFicRhowoF3urcgbNg7mB34QB/WLuXyt6454/H+aafp5VnxG/tpI/+jDMedX7
 Boe/n6PjMaJAujYPRsB24dtuQvCN0LlbGgCyrUvkEtlvtChSeRo7BeLs6Hb9r2xNTET1
 M+D6U1a08W1Le6AoUM7BscCoZwHKRTymvqfYGKzZAxe3GjS8X1Lj9ZITLu282chDP1j0
 rnbWwfQsZWo3KHLzyEyC+Xjty+P0QNdFaSJeyApdJmB2qIzlKLOIL4jkQ0j6dp3x6D0L
 PEQnYgUH3nsfAK04qCh/GhM+K8q8SX/NThTbxnd6uCOQLBCH6zHbwpVTTf6drtRgw/g3
 rVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787672747; x=1788277547;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YZqeTHA0l7gf+Po3VOfya1fhAQX3gs8MqR6PI9PCVcg=;
 b=Z8ml+jET+6MCQV6ihx3BehZWSYYsrW5wECypYol9G0hy/RYU5fLFz7oa8ZAG+yIxwB
 ZZdS0RcvvQNHD5QixoeIMeYBzNO7Lpwu6553HHtyLcGzZ3w4aigg2WFX1KJ40oV52oIE
 +CUTfcXVYkEU0dbLX6JuwrFEQwcY65yRbiWigsECA1bzpV/bQ6U0ejQ6t2zuhysiVpva
 pf2wGMMtWNWFfmrRiuVTItq1kOO6MHRT1y0sAXmv+N4jDegLjm5g2EEl4A0QoETofe20
 VqLGOlxm2ULmjAXLsckw/iB1mxMMcvh6F+imb6lFVrNQfX+SYnw1RAn5cCvByuaFtrPV
 qgSg==
X-Gm-Message-State: AFuF++nltc2jzfaDI2aYwrghPyAp/D4ehJJAww1MLRFSKX5vxY2F6m5B
 tTod58RSKDH56p7ttO/p3xEzAPC6RNSqKLG5N+qCgbBLso1sx5bSMsAU1tEWvuz2KiZTYTTc5Fx
 fk5QC3TrTtOalrB+PdahwPrASBxhCoA5Jb9UcEOK9/d3EvDPAKMX8pgv+Hd79LoY9U/ueWDhhnU
 FC9rmmeA==
X-Gm-Gg: AR+sD10VLf+IuNJT+iovHJbG8+Pi9ZDFtfsAufx5WMCglv3EDqrqnR5g/ELukzMtVTP
 QkrPQWNBVDxogQXBPhmT+wvy7TFntYvy5AZ7JH7degquAKAhCMMfejzOv9zX4UU4CUE6hEqkGuU
 Qai3+S+/WfqzJISsk4ZVGHQqyUNa0K+WHvTnN/aNFLlgHL593LOQhgfDXPMo/M3/KzlwCZPuYwQ
 X/fuyVbkP+FFMNcB6vtUUDDv1d2RiYc/7ZKmjELV0loTnDZlmCKhH//KN9tA+Q2bcKeSu5lNa3E
 FNAccb1TIopey0j1OWIAoFbYsPpPrIMxlF5+3yqPdCFz8duVCoMR9cDu7JwsHgI09h+apOXQHQE
 l2xlwPgtWMZ61Y3tv9w1QnonUx9w+j5UyWhiAA5O2FOruura0gbDQU4lVauzs+RjYg+DqbTVbwy
 CHIZL7LisBGcOG1fVP2oqjC+wLFSYOFszp/7RFkxD7dvA4ealmrWiUhXrQis5dvfqu73pq+kK9b
 wBBqllZXsanGGgmcqcIBYilzzWTvCBdREkstqC4bCnBThm16Q+m9Xh9bePj1+BRY109aNl9Ft7O
 nUXV4EHKdVxtHGyXxpvvnhQ2+/zzEbthS7L03ni/S058+2vPFbW/RESb
X-Received: by 2002:a05:6402:5191:b0:6a0:eb:ae41 with SMTP id
 4fb4d7f45d1cf-6a5c414ac54mr7284132a12.10.1787672746167; 
 Tue, 25 Aug 2026 08:45:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8b625bsm339741a12.6.2026.08.25.08.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 08:45:44 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 15:45:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id56fbfa4767346995eaa05ac95c7a20fbba99b2d
X-Gerrit-Change-Number: 1869
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1869?usp=email>
X-Gerrit-Commit: 0f575c5ac88f329fd34904f141c52401cdbfa62e
References: <gerrit.1787672720000.Id56fbfa4767346995eaa05ac95c7a20fbba99b2d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLklkNTZmYmZhNDc2NzM0Njk5NWVhYTA1YWM5NWM3YTIwZmJiYTk5YjJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7ae4e28d8a2e58e092cbbdacf7cf43f266e027a3-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wytLV-0002D2-Ew
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1669004344396079055=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1669004344396079055==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7lQ9td85x50="; charset=UTF-8

--7lQ9td85x50=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1869?usp=3Demail

to review the following change=2E


Chang=
e subject: Make cppcheck run pass on top of current master
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make cppcheck run pass on to=
p of current master

* Update cppcheck-suppressions to be in sync with
  cu=
rrent code
* Suppress some additional findings that we have
  patches for i=
n the queue but which are not merged,
  yet
* Add some additional fixes for=
 categories we had
  fixed but for which new occurences crept in

The goal =
is to have one commit that allows us to
enable a cppcheck run in buildbot t=
o keep it
up to date going forward=2E

Change-Id: Id56fbfa4767346995eaa05ac=
95c7a20fbba99b2d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

---
M dev-tools/cppcheck-suppression
M src/openvpn/mudp=2Ec
M src/openvpn/=
multi=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/openvpn=2Ec
M src/openvp=
n/ssl_mbedtls=2Ec
M tests/unit_tests/openvpn/test_pkt=2Ec
7 files changed, =
42 insertions(+), 23 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/69/1869/1

diff --git a/dev-tools/cppcheck-sup=
pression b/dev-tools/cppcheck-suppression
index 900e03c=2E=2Ea585513 100644=

--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
=
@@ -5,6 +5,10 @@
 constParameterPointer
 invalidPrintfArgType_sint
 invalid=
PrintfArgType_uint
+redundantAssignment
+redundantInitialization
+unreadVar=
iable
+unusedFunction
 usleepCalled
 variableScope
 # We have a lot of libr=
ary includes, not all of them are really required,
@@ -24,15 +28,21 @@
 loc=
altimeCalled
 strtokCalled
 # FP: posix=2Ecfg claims suseconds_t is unsigne=
d for some reason
-unsignedLessThanZero:src/openvpn/otime=2Eh:235
+unsigned=
LessThanZero:src/openvpn/otime=2Eh:148
 # IGN: multi code does weird things=
 with pointers to local variables=2E=2E=2E
-autoVariables:src/openvpn/multi=
=2Ec:4177
-autoVariables:src/openvpn/multi_io=2Ec:280
+autoVariables:src/op=
envpn/multi=2Ec:4232
+autoVariables:src/openvpn/multi_io=2Ec:324
 # IGN: th=
e code header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally
 bad=
BitmaskCheck:src/openvpn/mudp=2Ec
 badBitmaskCheck:tests/unit_tests/openvpn=
/test_pkt=2Ec
 # IGN: we store integers in pointers
 CastAddressToIntegerAt=
Return:src/openvpn/multi=2Ec
+# IGN: Windows specific (unsigned long =3D=3D=
 unsigned int)
+compareValueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:=
928
+# FP: cppcheck seems to have wrong signature of DeviceIoControl()
+con=
stVariablePointer:src/openvpn/dco_win=2Ec
+# IGN: test_networking code woul=
d break with iproute2 but that is prevented
+ctunullpointer:src/openvpn/net=
working_iproute2=2Ec
 # IGN: event code uses a pointer to store integers
 i=
ntToPointerCast:src/openvpn/forward=2Ec
 intToPointerCast:src/openvpn/multi=
_io=2Ec
@@ -40,7 +50,7 @@
 # FP: constant but differs between platforms
 kn=
ownConditionTrueFalse:src/openvpn/error=2Eh:380
 knownConditionTrueFalse:sr=
c/openvpn/fdmisc=2Ec:80
-knownConditionTrueFalse:src/openvpn/lladdr=2Ec:65
=
+knownConditionTrueFalse:src/openvpn/lladdr=2Ec:64
 knownConditionTrueFalse=
:src/openvpn/platform=2Ec
 # FP: code needs to accomodate many different de=
fines
 knownConditionTrueFalse:src/openvpn/event=2Ec:1139
@@ -48,13 +58,13 =
@@
 # FP: dco_win support has "false" stubs
 knownConditionTrueFalse:src/op=
envpn/forward=2Ec
 knownConditionTrueFalse:src/openvpn/init=2Ec
-knownCondi=
tionTrueFalse:src/openvpn/multi_io=2Ec:163
+knownConditionTrueFalse:src/ope=
nvpn/multi_io=2Ec:197
 # FP: cppcheck thinks that some functions always ret=
urn true, but they don't
 knownConditionTrueFalse:src/openvpn/misc=2Ec:97
 =
knownConditionTrueFalse:src/openvpn/sig=2Eh:116
 # FP: cert_uri_supported i=
s a wrapper around defines, so it's
 # always constant but differs dependin=
g on OpenSSL version
-knownConditionTrueFalse:src/openvpn/ssl_openssl=2Ec:1=
332
+knownConditionTrueFalse:src/openvpn/ssl_openssl=2Ec:1260
 # FP: cppche=
ck doesn't understand that the function changes szErrMessage
 knownConditio=
nTrueFalse:src/tapctl/main=2Ec:704
 knownConditionTrueFalse:src/openvpnmsic=
a/dllmain=2Ec:164
@@ -65,12 +75,18 @@
 # FP: eventmsg=2Eh is not built on U=
nix
 missingInclude:src/openvpnserv/common=2Ec:25
 # IGN: strlen(NULL) is n=
ot nice code, but seems to work
-nullPointerRedundantCheck:src/openvpn/init=
=2Ec:299
+nullPointerRedundantCheck:src/openvpn/init=2Ec:301
 # FP: cppchec=
k doesn't understand ZeroMemory
 redundantAssignment:src/openvpnserv/intera=
ctive=2Ec:203
+# FP: cppcheck doesn't know the NLA macros
+redundantInitial=
ization:src/openvpn/dco_linux=2Ec
 # IGN: We reuse the same variable name d=
ue to macro usage
-shadowVariable:src/openvpn/options=2Ec:2580
-shadowVaria=
ble:src/openvpn/options=2Ec:2598
+shadowVariable:src/openvpn/options=2Ec:19=
48
+shadowVariable:src/openvpn/options=2Ec:1966
+# IGN: sure this is theore=
tically undefined, but works
+shiftNegativeLHS:tests/unit_tests/openvpn/tes=
t_schedule=2Ec:183
+# FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is=
 confused
+syntaxError:tests/unit_tests/openvpn/test_tls_crypt=2Ec:684
 # F=
P: this file is never compiled on _WIN32
 umaskCalled:tests/unit_tests/open=
vpn/test_pkcs11=2Ec
 # FP: yes, t_prev is unitialized, but t_prev_len is 0,=
 so that's handled
@@ -78,13 +94,13 @@
 # FP: yes, parm is unitialized, but=
 parm_len is 0, so that's handled
 uninitvar:src/openvpn/options_parse=2Ec:=
148
 # FP: uninit is fine when it is a return parameter
-ctuuninitvar:src/o=
penvpn/crypto_mbedtls_legacy=2Ec:698
-uninitvar:src/openvpnserv/interactive=
=2Ec:1935
+ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:690
+uninitva=
r:src/openvpnserv/interactive=2Ec:2775
 uninitvar:src/tapctl/main=2Ec:566
 =
# FP: we added a check but cppcheck is not convinced
 uninitvar:src/openvpn=
serv/interactive=2Ec:2667
 # FP: weird parse error, the macro is fine in th=
e rest of the file
-unknownMacro:src/openvpnserv/interactive=2Ec:3488
+unkn=
ownMacro:src/openvpnserv/interactive=2Ec:3596
 # FP: cppcheck doesn't accou=
nt for short-circuiting
 unreadVariable:src/openvpn/manage=2Ec:682
 unusedF=
unction:src/openvpn/siphash_reference=2Ec
@@ -101,8 +117,10 @@
 # FP: doesn=
't account for --wrap
 unusedFunction:tests/unit_tests/openvpn/test_tls_cry=
pt=2Ec
 unusedFunction:/usr/include/*
+# FP: cppcheck doesn't know the NLA =
macros
+unusedLabel:src/openvpn/dco_linux=2Ec
 # IGN: old code that is diff=
icult to test (MSG_ERRQUEUE), ignore for now
-unusedStructMember:src/openvp=
n/mtu=2Ec:281
+unusedStructMember:src/openvpn/mtu=2Ec:289
 # FP: used impli=
ctly by NL macros
 unusedStructMember:src/openvpn/networking_sitnl=2Ec
 # I=
GN: keep explanatory fields in test data
@@ -111,3 +129,5 @@
 variableScope=
:src/openvpn/networking_sitnl=2Ec:1390
 # IGN: nicer to keep the "variable"=
 earlier
 variableScope:src/openvpnserv/interactive=2Ec:2687
+# FP: fun:pla=
tform_create_temp_file: cppcheck is confused
+wrongPrintfScanfArgNum:src/op=
envpn/platform=2Ec:553
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec
index 6d9c181=2E=2Ede3d467 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src=
/openvpn/mudp=2Ec
@@ -324,7 +324,7 @@
 {
     struct multi_instance *mi =3D=
 NULL;
 
-    uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+    const uint8_t=
 *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
     uint8_t op =3D ptr[0] >> P_OPCODE_=
SHIFT;
     bool v2 =3D (op =3D=3D P_DATA_V2) && (m->top=2Ec2=2Ebuf=2Elen >=
=3D (1 + 3));
     bool peer_id_disabled =3D false;
@@ -376,7 +376,7 @@
   =
      return NULL;
     }
 
-    uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);=

+    const uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
     uint8_t op =3D =
ptr[0] >> P_OPCODE_SHIFT;
 
     struct mroute_addr real =3D { 0 };
diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 60a5148=2E=2E7493=
9bf 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3095=
,8 +3095,8 @@
 
     struct multi_instance *ex_mi =3D he->value;
 
-    str=
uct tls_multi *m1 =3D mi->context=2Ec2=2Etls_multi;
-    struct tls_multi *=
m2 =3D ex_mi->context=2Ec2=2Etls_multi;
+    const struct tls_multi *m1 =3D=
 mi->context=2Ec2=2Etls_multi;
+    const struct tls_multi *m2 =3D ex_mi->c=
ontext=2Ec2=2Etls_multi;
 
     struct gc_arena gc =3D gc_new();
     int r=
et =3D false;
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=
=2Ec
index d8cc708=2E=2E3604684 100644
--- a/src/openvpn/multi_io=2Ec
+++ b=
/src/openvpn/multi_io=2Ec
@@ -191,12 +191,12 @@
 int
 multi_io_wait(struct =
multi_context *m)
 {
-    int status, i;
+    int status;
     unsigned int=
 *persistent =3D &m->multi_io->tun_rwflags;
 
     if (!tuntap_is_dco_win(m=
->top=2Ec1=2Etuntap))
     {
-        for (i =3D 0; i < m->top=2Ec1=2Elink_=
sockets_num; i++)
+        for (int i =3D 0; i < m->top=2Ec1=2Elink_sockets=
_num; i++)
         {
             socket_set_listen_persistent(m->top=2Ec2=
=2Elink_sockets[i], m->multi_io->es,
                                      =
    &m->top=2Ec2=2Elink_sockets[i]->ev_arg);
diff --git a/src/openvpn/openv=
pn=2Ec b/src/openvpn/openvpn=2Ec
index 7d35195=2E=2E24d6bb6 100644
--- a/sr=
c/openvpn/openvpn=2Ec
+++ b/src/openvpn/openvpn=2Ec
@@ -32,7 +32,6 @@
 #inc=
lude "win32=2Eh"
 #include "options_show=2Eh"
 #include "platform=2Eh"
-#in=
clude "string=2Eh"
 
 #include "memdbg=2Eh"
 
diff --git a/src/openvpn/ssl_=
mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index faf5a27=2E=2Ec92c423 100644=

--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -28=
6,7 +286,7 @@
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, con=
st char *ciphers)
 {
-    char *tmp_ciphers, *tmp_ciphers_orig, *token;
+  =
  char *tmp_ciphers, *tmp_ciphers_orig;
 
     if (NULL =3D=3D ciphers)
   =
  {
@@ -306,7 +306,7 @@
     char *lasts =3D NULL;
     tmp_ciphers_orig =
=3D tmp_ciphers =3D string_alloc(ciphers, NULL);
 
-    token =3D strtok_r(=
tmp_ciphers, ":", &lasts);
+    const char *token =3D strtok_r(tmp_ciphers,=
 ":", &lasts);
     while (token)
     {
         ctx->allowed_ciphers[i] =
=3D mbedtls_ssl_get_ciphersuite_id(tls_translate_cipher_name(token));
diff =
--git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/te=
st_pkt=2Ec
index 5ec6781=2E=2Ea732c2b 100644
--- a/tests/unit_tests/openvpn=
/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -562,7 +562,7 =
@@
 static void
 test_calc_session_id_hmac_static(void **ut_state)
 {
-    =
uint8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, 0 };
+    const uint8_t key[SI=
PHASH_KEY_SIZE] =3D { 1, 2, 3, 0 };
     static const int handwindow =3D 10=
0;
 
     struct openvpn_sockaddr addr =3D { 0 };

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Id56fbfa4767346995eaa05ac95c7a20fbba99b2d
Ge=
rrit-Change-Number: 1869
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--7lQ9td85x50=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Make cppcheck run pass on top of current master<br><br>* Update cppche=
ck-suppressions to be in sync with<br>  current code<br>* Suppress some add=
itional findings that we have<br>  patches for in the queue but which are n=
ot merged,<br>  yet<br>* Add some additional fixes for categories we had<br=
>  fixed but for which new occurences crept in<br><br>The goal is to have o=
ne commit that allows us to<br>enable a cppcheck run in buildbot to keep it=
<br>up to date going forward=2E<br><br>Change-Id: Id56fbfa4767346995eaa05ac=
95c7a20fbba99b2d<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>---<br>M dev-tools/cppcheck-suppression<br>M src/openvpn/mudp=
=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<br>M src/open=
vpn/openvpn=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M tests/unit_tests/open=
vpn/test_pkt=2Ec<br>7 files changed, 42 insertions(+), 23 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/69/1869/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression =
b/dev-tools/cppcheck-suppression</span><br><span>index 900e03c=2E=2Ea585513=
 100644</span><br><span>--- a/dev-tools/cppcheck-suppression</span><br><spa=
n>+++ b/dev-tools/cppcheck-suppression</span><br><span>@@ -5,6 +5,10 @@</sp=
an><br><span> constParameterPointer</span><br><span> invalidPrintfArgType_s=
int</span><br><span> invalidPrintfArgType_uint</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+redundantAssignment</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+redundantInitialization</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+unreadVariable</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+unusedFunction</span><br><span> usleepCalled</spa=
n><br><span> variableScope</span><br><span> # We have a lot of library incl=
udes, not all of them are really required,</span><br><span>@@ -24,15 +28,21=
 @@</span><br><span> localtimeCalled</span><br><span> strtokCalled</span><b=
r><span> # FP: posix=2Ecfg claims suseconds_t is unsigned for some reason</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsignedLessThanZero:sr=
c/openvpn/otime=2Eh:235</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+unsignedLessThanZero:src/openvpn/otime=2Eh:148</span><br><span> # IGN: =
multi code does weird things with pointers to local variables=2E=2E=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-autoVariables:src/openvpn/=
multi=2Ec:4177</span><br><span style=3D"color: hsl(0, 100%, 40%);">-autoVar=
iables:src/openvpn/multi_io=2Ec:280</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+autoVariables:src/openvpn/multi=2Ec:4232</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+autoVariables:src/openvpn/multi_io=2Ec=
:324</span><br><span> # IGN: the code header =3D 0 | (OPCODE &lt;&lt; P_OPC=
ODE_SHIFT) is used intentionally</span><br><span> badBitmaskCheck:src/openv=
pn/mudp=2Ec</span><br><span> badBitmaskCheck:tests/unit_tests/openvpn/test_=
pkt=2Ec</span><br><span> # IGN: we store integers in pointers</span><br><sp=
an> CastAddressToIntegerAtReturn:src/openvpn/multi=2Ec</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# IGN: Windows specific (unsigned long =
=3D=3D unsigned int)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+compareValueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# FP: cppcheck seems to have wr=
ong signature of DeviceIoControl()</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+constVariablePointer:src/openvpn/dco_win=2Ec</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# IGN: test_networking code would b=
reak with iproute2 but that is prevented</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ctunullpointer:src/openvpn/networking_iproute2=2Ec</sp=
an><br><span> # IGN: event code uses a pointer to store integers</span><br>=
<span> intToPointerCast:src/openvpn/forward=2Ec</span><br><span> intToPoint=
erCast:src/openvpn/multi_io=2Ec</span><br><span>@@ -40,7 +50,7 @@</span><br=
><span> # FP: constant but differs between platforms</span><br><span> known=
ConditionTrueFalse:src/openvpn/error=2Eh:380</span><br><span> knownConditio=
nTrueFalse:src/openvpn/fdmisc=2Ec:80</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-knownConditionTrueFalse:src/openvpn/lladdr=2Ec:65</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/op=
envpn/lladdr=2Ec:64</span><br><span> knownConditionTrueFalse:src/openvpn/pl=
atform=2Ec</span><br><span> # FP: code needs to accomodate many different d=
efines</span><br><span> knownConditionTrueFalse:src/openvpn/event=2Ec:1139<=
/span><br><span>@@ -48,13 +58,13 @@</span><br><span> # FP: dco_win support =
has &quot;false&quot; stubs</span><br><span> knownConditionTrueFalse:src/op=
envpn/forward=2Ec</span><br><span> knownConditionTrueFalse:src/openvpn/init=
=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTru=
eFalse:src/openvpn/multi_io=2Ec:163</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/multi_io=2Ec:197</span>=
<br><span> # FP: cppcheck thinks that some functions always return true, bu=
t they don&#39;t</span><br><span> knownConditionTrueFalse:src/openvpn/misc=
=2Ec:97</span><br><span> knownConditionTrueFalse:src/openvpn/sig=2Eh:116</s=
pan><br><span> # FP: cert_uri_supported is a wrapper around defines, so it&=
#39;s</span><br><span> # always constant but differs depending on OpenSSL v=
ersion</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionT=
rueFalse:src/openvpn/ssl_openssl=2Ec:1332</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/ssl_openssl=2Ec:1=
260</span><br><span> # FP: cppcheck doesn&#39;t understand that the functio=
n changes szErrMessage</span><br><span> knownConditionTrueFalse:src/tapctl/=
main=2Ec:704</span><br><span> knownConditionTrueFalse:src/openvpnmsica/dllm=
ain=2Ec:164</span><br><span>@@ -65,12 +75,18 @@</span><br><span> # FP: even=
tmsg=2Eh is not built on Unix</span><br><span> missingInclude:src/openvpnse=
rv/common=2Ec:25</span><br><span> # IGN: strlen(NULL) is not nice code, but=
 seems to work</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nullPoi=
nterRedundantCheck:src/openvpn/init=2Ec:299</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+nullPointerRedundantCheck:src/openvpn/init=2Ec:301<=
/span><br><span> # FP: cppcheck doesn&#39;t understand ZeroMemory</span><br=
><span> redundantAssignment:src/openvpnserv/interactive=2Ec:203</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# FP: cppcheck doesn&#39;t know=
 the NLA macros</span><br><span style=3D"color: hsl(120, 100%, 40%);">+redu=
ndantInitialization:src/openvpn/dco_linux=2Ec</span><br><span> # IGN: We re=
use the same variable name due to macro usage</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-shadowVariable:src/openvpn/options=2Ec:2580</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-shadowVariable:src/openvpn/op=
tions=2Ec:2598</span><br><span style=3D"color: hsl(120, 100%, 40%);">+shado=
wVariable:src/openvpn/options=2Ec:1948</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+shadowVariable:src/openvpn/options=2Ec:1966</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# IGN: sure this is theoreticall=
y undefined, but works</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+shiftNegativeLHS:tests/unit_tests/openvpn/test_schedule=2Ec:183</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# FP: fun:tls_crypt_v2_wrap_=
unwrap_invalid: cppcheck is confused</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+syntaxError:tests/unit_tests/openvpn/test_tls_crypt=2Ec:68=
4</span><br><span> # FP: this file is never compiled on _WIN32</span><br><s=
pan> umaskCalled:tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span> =
# FP: yes, t_prev is unitialized, but t_prev_len is 0, so that&#39;s handle=
d</span><br><span>@@ -78,13 +94,13 @@</span><br><span> # FP: yes, parm is u=
nitialized, but parm_len is 0, so that&#39;s handled</span><br><span> unini=
tvar:src/openvpn/options_parse=2Ec:148</span><br><span> # FP: uninit is fin=
e when it is a return parameter</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:698</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-uninitvar:src/openvpnserv/intera=
ctive=2Ec:1935</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctuun=
initvar:src/openvpn/crypto_mbedtls_legacy=2Ec:690</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+uninitvar:src/openvpnserv/interactive=2Ec:277=
5</span><br><span> uninitvar:src/tapctl/main=2Ec:566</span><br><span> # FP:=
 we added a check but cppcheck is not convinced</span><br><span> uninitvar:=
src/openvpnserv/interactive=2Ec:2667</span><br><span> # FP: weird parse err=
or, the macro is fine in the rest of the file</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-unknownMacro:src/openvpnserv/interactive=2Ec:3488</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+unknownMacro:src/open=
vpnserv/interactive=2Ec:3596</span><br><span> # FP: cppcheck doesn&#39;t ac=
count for short-circuiting</span><br><span> unreadVariable:src/openvpn/mana=
ge=2Ec:682</span><br><span> unusedFunction:src/openvpn/siphash_reference=2E=
c</span><br><span>@@ -101,8 +117,10 @@</span><br><span> # FP: doesn&#39;t a=
ccount for --wrap</span><br><span> unusedFunction:tests/unit_tests/openvpn/=
test_tls_crypt=2Ec</span><br><span> unusedFunction:/usr/include/*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# FP: cppcheck doesn&#39;t kn=
ow the NLA macros</span><br><span style=3D"color: hsl(120, 100%, 40%);">+un=
usedLabel:src/openvpn/dco_linux=2Ec</span><br><span> # IGN: old code that i=
s difficult to test (MSG_ERRQUEUE), ignore for now</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-unusedStructMember:src/openvpn/mtu=2Ec:281</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+unusedStructMember:src/=
openvpn/mtu=2Ec:289</span><br><span> # FP: used implictly by NL macros</spa=
n><br><span> unusedStructMember:src/openvpn/networking_sitnl=2Ec</span><br>=
<span> # IGN: keep explanatory fields in test data</span><br><span>@@ -111,=
3 +129,5 @@</span><br><span> variableScope:src/openvpn/networking_sitnl=2Ec=
:1390</span><br><span> # IGN: nicer to keep the &quot;variable&quot; earlie=
r</span><br><span> variableScope:src/openvpnserv/interactive=2Ec:2687</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: fun:platform_create=
_temp_file: cppcheck is confused</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+wrongPrintfScanfArgNum:src/openvpn/platform=2Ec:553</span><br>=
<span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><s=
pan>index 6d9c181=2E=2Ede3d467 100644</span><br><span>--- a/src/openvpn/mud=
p=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -324,7 =
+324,7 @@</span><br><span> {</span><br><span>     struct multi_instance *mi=
 =3D NULL;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *ptr =3D BPTR(&a=
mp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>     uint8_t op =3D ptr[0] &gt;&g=
t; P_OPCODE_SHIFT;</span><br><span>     bool v2 =3D (op =3D=3D P_DATA_V2) &=
amp;&amp; (m-&gt;top=2Ec2=2Ebuf=2Elen &gt;=3D (1 + 3));</span><br><span>   =
  bool peer_id_disabled =3D false;</span><br><span>@@ -376,7 +376,7 @@</spa=
n><br><span>         return NULL;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *ptr =3D B=
PTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</sp=
an><br><span>     uint8_t op =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br>=
<span> </span><br><span>     struct mroute_addr real =3D { 0 };</span><br><=
span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><=
span>index 60a5148=2E=2E74939bf 100644</span><br><span>--- a/src/openvpn/mu=
lti=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -309=
5,8 +3095,8 @@</span><br><span> </span><br><span>     struct multi_instance=
 *ex_mi =3D he-&gt;value;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct tls_multi *m1 =3D mi-&gt;context=2Ec2=2Etl=
s_multi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tl=
s_multi *m2 =3D ex_mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct tls_multi *m1 =3D mi-&gt=
;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const struct tls_multi *m2 =3D ex_mi-&gt;context=2Ec2=2Etls_mult=
i;</span><br><span> </span><br><span>     struct gc_arena gc =3D gc_new();<=
/span><br><span>     int ret =3D false;</span><br><span>diff --git a/src/op=
envpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index d8cc708=
=2E=2E3604684 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><=
br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -191,12 +191,12 =
@@</span><br><span> int</span><br><span> multi_io_wait(struct multi_context=
 *m)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int status, i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int status;</span><br><span>     unsigned int *persistent =3D &amp;m-&=
gt;multi_io-&gt;tun_rwflags;</span><br><span> </span><br><span>     if (!tu=
ntap_is_dco_win(m-&gt;top=2Ec1=2Etuntap))</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; m-&=
gt;top=2Ec1=2Elink_sockets_num; i++)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        for (int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_soc=
kets_num; i++)</span><br><span>         {</span><br><span>             sock=
et_set_listen_persistent(m-&gt;top=2Ec2=2Elink_sockets[i], m-&gt;multi_io-&=
gt;es,</span><br><span>                                          &amp;m-&gt=
;top=2Ec2=2Elink_sockets[i]-&gt;ev_arg);</span><br><span>diff --git a/src/o=
penvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec</span><br><span>index 7d35195=
=2E=2E24d6bb6 100644</span><br><span>--- a/src/openvpn/openvpn=2Ec</span><b=
r><span>+++ b/src/openvpn/openvpn=2Ec</span><br><span>@@ -32,7 +32,6 @@</sp=
an><br><span> #include &quot;win32=2Eh&quot;</span><br><span> #include &quo=
t;options_show=2Eh&quot;</span><br><span> #include &quot;platform=2Eh&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;string=
=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quo=
t;</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_mbedtls=
=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index faf5a27=2E=2Ec92c4=
23 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span=
>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -286,7 +286,7 @@</spa=
n><br><span> void</span><br><span> tls_ctx_restrict_ciphers(struct tls_root=
_ctx *ctx, const char *ciphers)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    char *tmp_ciphers, *tmp_ciphers_orig, *tok=
en;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_ci=
phers, *tmp_ciphers_orig;</span><br><span> </span><br><span>     if (NULL =
=3D=3D ciphers)</span><br><span>     {</span><br><span>@@ -306,7 +306,7 @@<=
/span><br><span>     char *lasts =3D NULL;</span><br><span>     tmp_ciphers=
_orig =3D tmp_ciphers =3D string_alloc(ciphers, NULL);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    token =3D strtok_r(t=
mp_ciphers, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp_ciphers, &quot;:=
&quot;, &amp;lasts);</span><br><span>     while (token)</span><br><span>   =
  {</span><br><span>         ctx-&gt;allowed_ciphers[i] =3D mbedtls_ssl_get=
_ciphersuite_id(tls_translate_cipher_name(token));</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_=
pkt=2Ec</span><br><span>index 5ec6781=2E=2Ea732c2b 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit=
_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -562,7 +562,7 @@</span><br><=
span> static void</span><br><span> test_calc_session_id_hmac_static(void **=
ut_state)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    uint8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, 0 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t key[SIPHASH_KEY_=
SIZE] =3D { 1, 2, 3, 0 };</span><br><span>     static const int handwindow =
=3D 100;</span><br><span> </span><br><span>     struct openvpn_sockaddr add=
r =3D { 0 };</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3Demail">change 1869</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id56fbf=
a4767346995eaa05ac95c7a20fbba99b2d </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1869 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--7lQ9td85x50=--


--===============1669004344396079055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1669004344396079055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1669004344396079055==--

