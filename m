Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092DBCD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zAUc2ulDnLv4ALkZ+lq0NG/3GoS3AoR+IHnq4+RhOgI=; b=LivlvHvzpzW8WMS3jtIn+CNtJ5
	Mp661tKW4oIJMyM62mUqPnVrFis0G2H+kTlzWvPkQ7qnd9om3VDF6GoMWqfSXolrymBtd6jWbsmGm
	4GxZHPVEjf2rSa0EK5v4aiTS/iqDPr4Cv87Ru0ILXIH06Q3lQLTk56o4YmXv5UNgyfOs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxGM-0003cM-Mo;
	Tue, 09 Jun 2026 14:17:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxGK-0003cE-S0
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zWlOvML8bVkqqGDrgQJlZXJyQISisWTiT5pt/V6TwpY=; b=Gna3s4Z5xz6Onjo5QAHfo+yOA7
 vRSYsjLW7vy2w+RjsVnLrebLZz/CkH6idWVJor30ujWzcDIhvrbw3aw54ViYX8EolPqBk+t6uqYTH
 0OIgfOqrCfNNN+OR1KSbJgDBE8BRq9Rk9tIfudfRdHeVXMFaXF1SiJt+IRcZy+8FT7vE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zWlOvML8bVkqqGDrgQJlZXJyQISisWTiT5pt/V6TwpY=; b=m
 zWKi6scv8/kppG9OU0cS6UKK+s3qL+AYxVINEGT4igGLUyrT4av0s0/dfM5TJkvxXYs5OYJSPXAjW
 SW9wW9OliTBTj2wP+O88d40Qeh/hbnN70x4d5b9FWPf0iYl0KnBehZ2k9acZJuvuaY8kN4hl9ffO9
 hlG9K3CVsTvC5rsw=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxFu-0000Fu-Ca for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:17:05 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4600ddc4017so3942316f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781014587; x=1781619387; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zWlOvML8bVkqqGDrgQJlZXJyQISisWTiT5pt/V6TwpY=;
 b=HN7y+bN+5G4yhVDKNau7Pm1bUD+v6TDoWZghh1Nxo+IM6D5K+bqiMlK40x/kD0OHPs
 j5dwd+Cs78VhIs3hXjE1WrALfNnD+GAgZQdb2XlTLoS+esRxOflMhwuSlCEoT3NIQc2m
 wik7m4xBXxzYDtZBVH+9UhUFUq++YrlQhJWIwciIgZPceiwjIsiL1RtmAYuvZWpdSp9i
 cVhBkcI2kGBd6aTWbrgUT0Ims33ttR7sSpIil8bZVmxsw/UysADXBAYub93FznaqAdBQ
 TVp4QgP6tk2ZeAdG1kOWDxLzzo+M9ofhkqV3AE8T1lR9xjk9f542JLx6m0ZNwYumye5/
 kl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781014587; x=1781619387;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zWlOvML8bVkqqGDrgQJlZXJyQISisWTiT5pt/V6TwpY=;
 b=Cuqb0OfnfP/HdKRp6g2k5OQhwZhWEnOQlkFrsD0oFMg5LKYihFxtOr+unMf+EBTT5b
 eRMB8T1n3IwZa6bw5ZOoDOwnMH3lIqXXoLI40w7pL/lHBbuPvs+nOuoddfkbSErfGt1i
 QFQbVJd/S4gwN/48EZv6BMxLer7KOkrLO4NFwYixGdXSR8Bm8dCctsSjykG7qhoi6clS
 rH/QrP3YfG7S0lUE3NOMW6nRfz4THSLmMZ5Cq/dSOxfuwKSA4V0Gu9N+zBS1pggeebCR
 /Q/xkqK76awaY9z1uLfEI44WaTvOfkxa1PCqvAqdPwbzAjXpoEddd7W/Qbnf3RBIRgVd
 gokg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ncwzWXG7Nn8ggpZWZBLF9dv4dhW0hVDvJT0BWawyC9rDkUVSUgTncJnnSCv1Meym4F+hv/+kE9E9sZmjp@lists.sourceforge.net
X-Gm-Message-State: AOJu0YybmRyZX7FTBNSB3NqEWt5NyhxQq3ReQiaYzcgjT87R7WJvsR9I
 67qTmMSK1MzDDhaIJWswdVd9oNNf8io7NRA+6/zUM7/W5Bc8peq5nVGMwgwzdk6aBYoXuWAEmDU
 LG8IlUR4+xlyIw8hec32O/T+WONJS/Gt4w60DwsqA3AF0iMHgfKl9R7Ns+VqRC+tE9USd0u2nh7
 CCJSTPIg==
X-Gm-Gg: Acq92OGsGRz+L1P1RQZCUSwK6CSY1APyarv4+EZYzdm9+4ZNNIxhpToe+hErV7OOaHt
 Lu1Yqel9tpC7HgR06Qk9yfT9gY4+82P4RM1djejL/oMyerEo8WyYPMo0MuXTVfNjZ9ALvnN2MN9
 ms6v90SM3MQGmqB8FwrHw4IguJ+ORuQN/Cb/R6OHK5bVTz5AVvgaupMyPwsERgJ1xNCgUTPr6ti
 M+Ox++SPELM8KQyq4Eqci6ePeWe60CmG1J9P1VyD1Hzwou/9eso4LgXKRApJstRaaTP13OJU93Z
 78Nrh12Yx4nWbf0yhFU4Rqwo1CnvVq85+RQ9hW8PZYxQzENUqFBT1ua2dPrCgq+qN5vIekOGKWn
 WuVOe8U/K7W+UjJi6HYboM9KfnmwCLCEIlzySxYqEVXWIAr/E7hdjhjdidT+CZiOgdY5vsTnmza
 6cMzIu0UsHcnxlQFGDw0iDALkJxqTsGVXCld5OumRX6UAAprRov0irIkZC5UI57nYz9mMcAXLRM
 eETpV/9iziOyv9KKNX1VedsXjKWSlHryGQAdXi0+ZoLewwrNpUvKizTN2MaVcElJGCJAPO11Fjm
 mzGk4VlOMYAafePcPj3lZnaJ
X-Received: by 2002:a05:600c:458a:b0:48f:e518:d110 with SMTP id
 5b1f17b1804b1-490c2614beemr270764895e9.32.1780989075263; 
 Tue, 09 Jun 2026 00:11:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2e4004sm59947681f8f.9.2026.06.09.00.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 00:11:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 07:11:14 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I05720ccc3bcf706bbe62254afb74562580f5de56
X-Gerrit-Change-Number: 1665
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1665?usp=email>
X-Gerrit-Commit: a71e8508f93f6ea19841779e42b9d60561613195
In-Reply-To: <gerrit.1778102459000.I05720ccc3bcf706bbe62254afb74562580f5de56@gerrit.openvpn.net>
References: <gerrit.1778102459000.I05720ccc3bcf706bbe62254afb74562580f5de56@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MTAyNDU5MDAwLkkwNTcyMGNjYzNiY2Y3MDZiYmU2MjI1NGFmYjc0NTYyNTgwZjVkZTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <df2512741c4b779b74b2e691172d54979607d065-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxFu-0000Fu-Ca
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dev-tools: Fix
 run-cppcheck to cover more code
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7635993815089796893=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7635993815089796893==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T6xAP5TIWSE="; charset=UTF-8

--T6xAP5TIWSE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1665?usp=3Demail )

Change subject: dev-tools: Fix run-cppcheck to cove=
r more code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

d=
ev-tools: Fix run-cppcheck to cover more code

Massively improve how we cal=
l cppcheck to cover
more code and identify more issues=2E

When specifying =
any -D argument all other defines
are ignored unless --force or --max-confi=
gs is
specified as well=2E I mistakenly assumed that this
was covered by --=
check-level=3Dexhaustive=2E We need
to try finding a value for --max-config=
s so that
cppcheck doesn't spend hours scanning options=2Ec

Add a library =
cfg for our code which for now
- identifies some printf-style functions
- a=
dds some common macro defines

Use existing libraries=2E

Add a second call=
 to cppcheck to separate the
Windows and Unixy code scans=2E This avoids so=
me
very non-sensical define combinations=2E

Change-Id: I05720ccc3bcf706bbe=
62254afb74562580f5de56
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1665
Message-Id: <20260607170713=2E498=
0-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg37078=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppression
A dev-tools=
/openvpn-cppcheck-library=2Ecfg
M dev-tools/run-cppcheck=2Esh
3 files chang=
ed, 89 insertions(+), 17 deletions(-)




diff --git a/dev-tools/cppcheck-s=
uppression b/dev-tools/cppcheck-suppression
index 439cbb1=2E=2E2e3350b 1006=
44
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppressio=
n
@@ -5,6 +5,9 @@
 constParameterPointer
 constVariable
 constVariablePoint=
er
+invalidPrintfArgType_sint
+invalidPrintfArgType_uint
+usleepCalled
 var=
iableScope
 # We have a lot of library includes, not all of them are really=
 required,
 # so ignore them
@@ -16,29 +19,44 @@
 # These are specific fals=
e-positives (FP) or ignored (IGN) issues
 # We might want to move some of t=
hem to inline-suppression to avoid
 # the static line-numbers
+# IGN: posix=
=2Ecfg: We are not threadsafe
+getgrnamCalled
+getpwnamCalled
+getservbynam=
eCalled
+localtimeCalled
+strtokCalled
+# FP: posix=2Ecfg claims suseconds_=
t is unsigned for some reason
+unsignedLessThanZero:src/openvpn/otime=2Eh:2=
35
 # IGN: multi code does weird things with pointers to local variables=2E=
=2E=2E
 autoVariables:src/openvpn/multi=2Ec:4177
 autoVariables:src/openvpn=
/multi_io=2Ec:280
 # IGN: the code header =3D 0 | (OPCODE << P_OPCODE_SHIFT=
) is used intentionally
 badBitmaskCheck:src/openvpn/mudp=2Ec
 badBitmaskCh=
eck:tests/unit_tests/openvpn/test_pkt=2Ec
+# IGN: we store integers in poin=
ters
+CastAddressToIntegerAtReturn:src/openvpn/multi=2Ec
 # IGN: event code=
 uses a pointer to store integers
-intToPointerCast:src/openvpn/multi_io=2E=
c
 intToPointerCast:src/openvpn/forward=2Ec
-# FP: crt_error is always true=
 on Unix, but not Windows
+intToPointerCast:src/openvpn/multi_io=2Ec
+intTo=
PointerCast:src/openvpn/ps=2Ec
+# FP: constant but differs between platform=
s
 knownConditionTrueFalse:src/openvpn/error=2Eh:380
+knownConditionTrueFal=
se:src/openvpn/fdmisc=2Ec:80
+knownConditionTrueFalse:src/openvpn/lladdr=2E=
c:65
+knownConditionTrueFalse:src/openvpn/platform=2Ec
 # FP: code needs to=
 accomodate many different defines
+knownConditionTrueFalse:src/openvpn/eve=
nt=2Ec:1139
 knownConditionTrueFalse:src/openvpn/event=2Ec:1148
 # FP: dco_=
win support has "false" stubs
 knownConditionTrueFalse:src/openvpn/forward=
=2Ec
 knownConditionTrueFalse:src/openvpn/init=2Ec
 knownConditionTrueFalse=
:src/openvpn/multi_io=2Ec:163
-# FP: cppcheck thinks that management_query_=
user_pass is always true,
-# but no idea why
+# FP: cppcheck thinks that so=
me functions always return true, but they don't
 knownConditionTrueFalse:sr=
c/openvpn/misc=2Ec:97
+knownConditionTrueFalse:src/openvpn/sig=2Eh:116
 # F=
P: cert_uri_supported is a wrapper around defines, so it's
 # always consta=
nt but differs depending on OpenSSL version
-knownConditionTrueFalse:src/op=
envpn/ssl_openssl=2Ec:1258
+knownConditionTrueFalse:src/openvpn/ssl_openssl=
=2Ec:1332
 # FP: cppcheck doesn't understand that the function changes szEr=
rMessage
 knownConditionTrueFalse:src/tapctl/main=2Ec:704
 knownConditionTr=
ueFalse:src/openvpnmsica/dllmain=2Ec:164
@@ -50,9 +68,13 @@
 missingInclude=
:src/openvpnserv/common=2Ec:25
 # IGN: strlen(NULL) is not nice code, but s=
eems to work
 nullPointerRedundantCheck:src/openvpn/init=2Ec:299
+# FP: cpp=
check doesn't understand ZeroMemory
+redundantAssignment:src/openvpnserv/in=
teractive=2Ec:203
 # IGN: We reuse the same variable name due to macro usag=
e
 shadowVariable:src/openvpn/options=2Ec:2580
 shadowVariable:src/openvpn/=
options=2Ec:2598
+# FP: this file is never compiled on _WIN32
+umaskCalled:=
tests/unit_tests/openvpn/test_pkcs11=2Ec
 # FP: yes, t_prev is unitialized,=
 but t_prev_len is 0, so that's handled
 uninitvar:src/openvpn/crypto_epoch=
=2Ec:60
 # FP: yes, parm is unitialized, but parm_len is 0, so that's handl=
ed
@@ -61,6 +83,10 @@
 ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:6=
98
 uninitvar:src/openvpnserv/interactive=2Ec:1935
 uninitvar:src/tapctl/ma=
in=2Ec:566
+# FP: we added a check but cppcheck is not convinced
+uninitvar=
:src/openvpnserv/interactive=2Ec:2667
+# FP: weird parse error, the macro i=
s fine in the rest of the file
+unknownMacro:src/openvpnserv/interactive=2E=
c:3488
 # FP: cppcheck doesn't account for short-circuiting
 unreadVariable=
:src/openvpn/manage=2Ec:682
 unusedFunction:src/openvpn/siphash_reference=
=2Ec
diff --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-tools/open=
vpn-cppcheck-library=2Ecfg
new file mode 100644
index 0000000=2E=2E1ea91f4
=
--- /dev/null
+++ b/dev-tools/openvpn-cppcheck-library=2Ecfg
@@ -0,0 +1,29 =
@@
+<?xml version =3D"1=2E0"?>
+<def>
+  <function name=3D"x_msg">
+    <fo=
rmatstr type=3D"printf"/>
+    <arg nr=3D"2">
+      <formatstr />
+    </a=
rg>
+  </function>
+  <function name=3D"buf_printf">
+    <formatstr type=
=3D"printf"/>
+    <arg nr=3D"2">
+      <formatstr />
+    </arg>
+  </fun=
ction>
+  <function name=3D"checked_snprintf">
+    <formatstr type=3D"prin=
tf"/>
+    <arg nr=3D"3">
+      <formatstr />
+    </arg>
+  </function>
+=
  <function name=3D"check_malloc_return">
+    <noreturn>true</noreturn>
+ =
 </function>
+  <define name=3D"HAVE_CONFIG_H" value=3D"1" />
+  <define na=
me=3D"CONFIGURE_SPECIAL_BUILD" value=3D"foo" />
+  <!-- work around macro c=
onfusion -->
+  <define name=3D"CMSG_FIRSTHDR" value=3D"cmsg_firsthdr" />
+=
  <define name=3D"CMSG_NXTHDR" value=3D"cmsg_nxthdr" />
+</def>
diff --git =
a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index 674fc092=
=2E=2E40db33e 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-=
cppcheck=2Esh
@@ -7,20 +7,37 @@
 : ${BUILD_DIR:=3D$PWD}
 : ${INCLUDE_FLAGS:=
=3D}
 CPPCHECK_DIR=3D"${BUILD_DIR}/cppcheck_build_dir"
+COMMON_ARGS=3D"-j$(=
nproc) -q \
+ -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPO=
RT \
+ -I=2E/include/ -I=2E/tests/unit_tests/openvpn/ \
+ -I=2E/src/compat/=
 -I=2E/src/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pam/ \
+ =
-I${BUILD_DIR} -I${BUILD_DIR}/include/ \
+ --enable=3Dall \
+ --library=3D$=
{SCRIPT_DIR}/openvpn-cppcheck-library=2Ecfg \
+ --library=3Dopenssl=2Ecfg \=

+ --suppressions-list=3D${SCRIPT_DIR}/cppcheck-suppression \
+ --cppcheck-=
build-dir=3D${CPPCHECK_DIR} \
+ --check-level=3Dexhaustive --max-configs=3D=
10 \
+ --error-exitcode=3D1"
+
 
 set -x
 
 mkdir -p "$CPPCHECK_DIR"
 cd "$=
{SOURCE_DIR}"
-cppcheck -j$(nproc) \
-	 -DHAVE_CONFIG_H -U_WIN32 \
-       =
  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
-	 -I=
=2E/include/ -I=2E/tests/unit_tests/openvpn/ \
-	 -I=2E/src/compat/ -I=2E/s=
rc/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pam/ \
-	 -I"${BU=
ILD_DIR}" -I"${BUILD_DIR}/include/" $INCLUDE_FLAGS \
-	 --enable=3Dall \
-	=
 --suppressions-list=3D"${SCRIPT_DIR}/cppcheck-suppression" \
-	 --cppcheck=
-build-dir=3D"${CPPCHECK_DIR}" \
-	 --check-level=3Dexhaustive \
-	 --error=
-exitcode=3D1 \
-	 src/ tests/ sample/
+cppcheck $COMMON_ARGS $INCLUDE_FLAG=
S \
+         --platform=3Dunix64 \
+         --library=3Dposix=2Ecfg --lib=
rary=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \
+         -U_WIN32 \
+         src=
/openvpn/ src/compat/ src/plugins/ sample/ \
+         tests/unit_tests/exa=
mple_test/ tests/unit_tests/openvpn/ \
+         tests/unit_tests/plugins/
=
+cppcheck $COMMON_ARGS \
+         --platform=3Dwin64 \
+         --library=
=3Dwindows=2Ecfg \
+         -D_WIN32 \
+         -UTARGET_LINUX -UTARGET_F=
REEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
+         -UTARGET_DARWIN -UTARGE=
T_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
+         -UTARGET_AIX \
+ =
        src/openvpn* src/compat/ \
+         tests/unit_tests/example_test/=
 tests/unit_tests/openvpn*

-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1665?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I05720ccc3bcf706bbe62254afb74562580f5de56
Gerrit-Change-Number: 1665
G=
errit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--T6xAP5TIWSE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1665?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dev-tools: Fix run-cppcheck to cover more =
code<br><br>Massively improve how we call cppcheck to cover<br>more code an=
d identify more issues=2E<br><br>When specifying any -D argument all other =
defines<br>are ignored unless --force or --max-configs is<br>specified as w=
ell=2E I mistakenly assumed that this<br>was covered by --check-level=3Dexh=
austive=2E We need<br>to try finding a value for --max-configs so that<br>c=
ppcheck doesn&#39;t spend hours scanning options=2Ec<br><br>Add a library c=
fg for our code which for now<br>- identifies some printf-style functions<b=
r>- adds some common macro defines<br><br>Use existing libraries=2E<br><br>=
Add a second call to cppcheck to separate the<br>Windows and Unixy code sca=
ns=2E This avoids some<br>very non-sensical define combinations=2E<br><br>C=
hange-Id: I05720ccc3bcf706bbe62254afb74562580f5de56<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1665<br>Message-Id: &lt;20260607170713=2E4980-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg37078=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cppcheck-suppression<br>A dev-t=
ools/openvpn-cppcheck-library=2Ecfg<br>M dev-tools/run-cppcheck=2Esh<br>3 f=
iles changed, 89 insertions(+), 17 deletions(-)<br><br></pre>
<pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression</span><b=
r><span>index 439cbb1=2E=2E2e3350b 100644</span><br><span>--- a/dev-tools/c=
ppcheck-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppression</s=
pan><br><span>@@ -5,6 +5,9 @@</span><br><span> constParameterPointer</span>=
<br><span> constVariable</span><br><span> constVariablePointer</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+invalidPrintfArgType_sint</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+invalidPrintfArgType_uint<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+usleepCalled</span><=
br><span> variableScope</span><br><span> # We have a lot of library include=
s, not all of them are really required,</span><br><span> # so ignore them</=
span><br><span>@@ -16,29 +19,44 @@</span><br><span> # These are specific fa=
lse-positives (FP) or ignored (IGN) issues</span><br><span> # We might want=
 to move some of them to inline-suppression to avoid</span><br><span> # the=
 static line-numbers</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# IGN: posix=2Ecfg: We are not threadsafe</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+getgrnamCalled</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+getpwnamCalled</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+getservbynameCalled</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+localtimeCalled</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+strtokCalled</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# FP: posix=2Ecfg claims suseconds_t is unsigned for some reason</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+unsignedLessThanZero:src/ope=
nvpn/otime=2Eh:235</span><br><span> # IGN: multi code does weird things wit=
h pointers to local variables=2E=2E=2E</span><br><span> autoVariables:src/o=
penvpn/multi=2Ec:4177</span><br><span> autoVariables:src/openvpn/multi_io=
=2Ec:280</span><br><span> # IGN: the code header =3D 0 | (OPCODE &lt;&lt; P=
_OPCODE_SHIFT) is used intentionally</span><br><span> badBitmaskCheck:src/o=
penvpn/mudp=2Ec</span><br><span> badBitmaskCheck:tests/unit_tests/openvpn/t=
est_pkt=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: w=
e store integers in pointers</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+CastAddressToIntegerAtReturn:src/openvpn/multi=2Ec</span><br><span=
> # IGN: event code uses a pointer to store integers</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-intToPointerCast:src/openvpn/multi_io=2Ec</=
span><br><span> intToPointerCast:src/openvpn/forward=2Ec</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# FP: crt_error is always true on Unix, =
but not Windows</span><br><span style=3D"color: hsl(120, 100%, 40%);">+intT=
oPointerCast:src/openvpn/multi_io=2Ec</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+intToPointerCast:src/openvpn/ps=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# FP: constant but differs between platfo=
rms</span><br><span> knownConditionTrueFalse:src/openvpn/error=2Eh:380</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+knownConditionTrueFalse:=
src/openvpn/fdmisc=2Ec:80</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+knownConditionTrueFalse:src/openvpn/lladdr=2Ec:65</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/pla=
tform=2Ec</span><br><span> # FP: code needs to accomodate many different de=
fines</span><br><span style=3D"color: hsl(120, 100%, 40%);">+knownCondition=
TrueFalse:src/openvpn/event=2Ec:1139</span><br><span> knownConditionTrueFal=
se:src/openvpn/event=2Ec:1148</span><br><span> # FP: dco_win support has &q=
uot;false&quot; stubs</span><br><span> knownConditionTrueFalse:src/openvpn/=
forward=2Ec</span><br><span> knownConditionTrueFalse:src/openvpn/init=2Ec</=
span><br><span> knownConditionTrueFalse:src/openvpn/multi_io=2Ec:163</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck thinks that m=
anagement_query_user_pass is always true,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-# but no idea why</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# FP: cppcheck thinks that some functions always return t=
rue, but they don&#39;t</span><br><span> knownConditionTrueFalse:src/openvp=
n/misc=2Ec:97</span><br><span style=3D"color: hsl(120, 100%, 40%);">+knownC=
onditionTrueFalse:src/openvpn/sig=2Eh:116</span><br><span> # FP: cert_uri_s=
upported is a wrapper around defines, so it&#39;s</span><br><span> # always=
 constant but differs depending on OpenSSL version</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/ssl_openss=
l=2Ec:1258</span><br><span style=3D"color: hsl(120, 100%, 40%);">+knownCond=
itionTrueFalse:src/openvpn/ssl_openssl=2Ec:1332</span><br><span> # FP: cppc=
heck doesn&#39;t understand that the function changes szErrMessage</span><b=
r><span> knownConditionTrueFalse:src/tapctl/main=2Ec:704</span><br><span> k=
nownConditionTrueFalse:src/openvpnmsica/dllmain=2Ec:164</span><br><span>@@ =
-50,9 +68,13 @@</span><br><span> missingInclude:src/openvpnserv/common=2Ec:=
25</span><br><span> # IGN: strlen(NULL) is not nice code, but seems to work=
</span><br><span> nullPointerRedundantCheck:src/openvpn/init=2Ec:299</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: cppcheck doesn&#39;t=
 understand ZeroMemory</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+redundantAssignment:src/openvpnserv/interactive=2Ec:203</span><br><span>=
 # IGN: We reuse the same variable name due to macro usage</span><br><span>=
 shadowVariable:src/openvpn/options=2Ec:2580</span><br><span> shadowVariabl=
e:src/openvpn/options=2Ec:2598</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# FP: this file is never compiled on _WIN32</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+umaskCalled:tests/unit_tests/openvpn/tes=
t_pkcs11=2Ec</span><br><span> # FP: yes, t_prev is unitialized, but t_prev_=
len is 0, so that&#39;s handled</span><br><span> uninitvar:src/openvpn/cryp=
to_epoch=2Ec:60</span><br><span> # FP: yes, parm is unitialized, but parm_l=
en is 0, so that&#39;s handled</span><br><span>@@ -61,6 +83,10 @@</span><br=
><span> ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:698</span><br><s=
pan> uninitvar:src/openvpnserv/interactive=2Ec:1935</span><br><span> uninit=
var:src/tapctl/main=2Ec:566</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# FP: we added a check but cppcheck is not convinced</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+uninitvar:src/openvpnserv/interact=
ive=2Ec:2667</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: w=
eird parse error, the macro is fine in the rest of the file</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+unknownMacro:src/openvpnserv/intera=
ctive=2Ec:3488</span><br><span> # FP: cppcheck doesn&#39;t account for shor=
t-circuiting</span><br><span> unreadVariable:src/openvpn/manage=2Ec:682</sp=
an><br><span> unusedFunction:src/openvpn/siphash_reference=2Ec</span><br><s=
pan>diff --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-tools/openv=
pn-cppcheck-library=2Ecfg</span><br><span>new file mode 100644</span><br><s=
pan>index 0000000=2E=2E1ea91f4</span><br><span>--- /dev/null</span><br><spa=
n>+++ b/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>@@ -0,0 +1=
,29 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;?xml vers=
ion =3D&quot;1=2E0&quot;?&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+&lt;def&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  &lt;function name=3D&quot;x_msg&quot;&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &lt;formatstr type=3D&quot;printf&quot;/&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;arg nr=3D&qu=
ot;2&quot;&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 &lt;formatstr /&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &lt;/arg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&lt;/function&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&lt;function name=3D&quot;buf_printf&quot;&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;formatstr type=3D&quot;printf&quot;/&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;arg nr=3D&q=
uot;2&quot;&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  &lt;formatstr /&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &lt;/arg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;/function&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;function name=3D&quot;checked_snprintf&quot;&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;formatstr type=3D&quot;printf&quo=
t;/&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;arg =
nr=3D&quot;3&quot;&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      &lt;formatstr /&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &lt;/arg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  &lt;/function&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  &lt;function name=3D&quot;check_malloc_return&quot;&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &lt;noreturn&gt;true&lt;/no=
return&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/fu=
nction&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;def=
ine name=3D&quot;HAVE_CONFIG_H&quot; value=3D&quot;1&quot; /&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;define name=3D&quot;CONF=
IGURE_SPECIAL_BUILD&quot; value=3D&quot;foo&quot; /&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- work around macro confusion -=
-&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;define n=
ame=3D&quot;CMSG_FIRSTHDR&quot; value=3D&quot;cmsg_firsthdr&quot; /&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;define name=3D&qu=
ot;CMSG_NXTHDR&quot; value=3D&quot;cmsg_nxthdr&quot; /&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+&lt;/def&gt;</span><br><span>diff --=
git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><=
span>index 674fc092=2E=2E40db33e 100755</span><br><span>--- a/dev-tools/run=
-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br>=
<span>@@ -7,20 +7,37 @@</span><br><span> : ${BUILD_DIR:=3D$PWD}</span><br><=
span> : ${INCLUDE_FLAGS:=3D}</span><br><span> CPPCHECK_DIR=3D&quot;${BUILD_=
DIR}/cppcheck_build_dir&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+COMMON_ARGS=3D&quot;-j$(nproc) -q \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_=
MATERIAL_EXPORT \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ -=
I=2E/include/ -I=2E/tests/unit_tests/openvpn/ \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ -I=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/src=
/openvpnserv/ -I=2E/src/plugins/auth-pam/ \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ -I${BUILD_DIR} -I${BUILD_DIR}/include/ \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ --enable=3Dall \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ --library=3D${SCRIPT_DIR}/open=
vpn-cppcheck-library=2Ecfg \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ --library=3Dopenssl=2Ecfg \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ --suppressions-list=3D${SCRIPT_DIR}/cppcheck-suppression=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ --cppcheck-build=
-dir=3D${CPPCHECK_DIR} \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ --check-level=3Dexhaustive --max-configs=3D10 \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ --error-exitcode=3D1&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><spa=
n> set -x</span><br><span> </span><br><span> mkdir -p &quot;$CPPCHECK_DIR&q=
uot;</span><br><span> cd &quot;${SOURCE_DIR}&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-cppcheck -j$(nproc) \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	 -DHAVE_CONFIG_H -U_WIN32 \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         -DMBEDTLS_SSL_PROTO_TLS1_3 -DM=
BEDTLS_SSL_KEYING_MATERIAL_EXPORT \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	 -I=2E/include/ -I=2E/tests/unit_tests/openvpn/ \</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	 -I=2E/src/compat/ -I=2E/src/op=
envpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pam/ \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	 -I&quot;${BUILD_DIR}&quot; -I&quot;=
${BUILD_DIR}/include/&quot; $INCLUDE_FLAGS \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	 --enable=3Dall \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	 --suppressions-list=3D&quot;${SCRIPT_DIR}/cppcheck-su=
ppression&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 --=
cppcheck-build-dir=3D&quot;${CPPCHECK_DIR}&quot; \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	 --check-level=3Dexhaustive \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	 --error-exitcode=3D1 \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	 src/ tests/ sample/</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+cppcheck $COMMON_ARGS $INCLUDE_F=
LAGS \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         --pl=
atform=3Dunix64 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         -U_WIN32 =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         src/openv=
pn/ src/compat/ src/plugins/ sample/ \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         tests/unit_tests/example_test/ tests/unit_tests=
/openvpn/ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 tests/unit_tests/plugins/</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+cppcheck $COMMON_ARGS \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         --platform=3Dwin64 \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         --library=3Dwindows=2Ecfg \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         -D_WIN32 \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         -UTARGET_LINUX -UTARGET_FREE=
BSD -UTARGET_OPENBSD -UTARGET_NETBSD \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLAR=
IS -UTARGET_DRAGONFLY \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+         -UTARGET_AIX \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         src/openvpn* src/compat/ \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         tests/unit_tests/example_test/ tests/unit_=
tests/openvpn*</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1665?usp=3Demail">change 1665=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1665?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I05720=
ccc3bcf706bbe62254afb74562580f5de56 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1665 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>

</body></html>
--T6xAP5TIWSE=--


--===============7635993815089796893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7635993815089796893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7635993815089796893==--

