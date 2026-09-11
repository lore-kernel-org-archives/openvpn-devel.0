Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B49C88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=d850cF5MKg7sAO78LJuOb22Y7aylOWSPUH9nSJTQiN4=; b=JCVwky0qyB78oa
	CFzBFfC37Doi4BUN5f87uh/bF7T5/H1YW3xgfeSaPfR4ie3aXyMs5MhQy0wklFjansxYtcgiPRIht
	zoA8NtF0FTNMU/MOq/D3OMILJ7GNu7iyWdQhhgEXTX+duGIjAnV8HVPBFQfPumhbtN9+A7XJ+OmK8
	ZFM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4zll-0003Vz-Q1;
	Fri, 11 Sep 2026 11:50:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4zlO-0003Un-6T
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 11:49:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s919109RUL6soc487a/tAiyHnaWNI4REYPZymA1oVlQ=; b=ObrbZMRwT1fDeYDi6EI0K1k6mA
 I8Zl7SdIjm8uye8E5ioOrKPQaPtWw4qjBaDZ7gtEV2s6PcjZ35nFhCXaqv5nurtNFm3MZ6X8u4Ijb
 mIeRN9gEEyNECc7ePMjV+4yxeD6/011OVrsCXyQRIkzqEeMEIOKr7AnHesjSKseyOSMM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=s919109RUL6soc487a/tAiyHnaWNI4REYPZymA1oVlQ=; b=W
 pi5hGkKjtrhnLatlrdr/nSGqPipLo0B2q8h9zQ3ra664T29nWbN3iAkvBoi8CWfqkwkSxGborhozl
 5Hw4/QaGDS3vE+kKvtIIjnDp1dja0MU6hzQPq56YSAWaV9S9jOPz7s9LQiDkJOnOZ4I+QLEiBYBEr
 fUpGbIEskDiJe4vM=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4zlN-0001O6-S0 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 11:49:50 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49d036e0e99so5098375e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 04:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789127383; x=1789732183; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s919109RUL6soc487a/tAiyHnaWNI4REYPZymA1oVlQ=;
 b=PKouJhTGia1yh3YS9eO1wsnxu2TnYNjXCC/BYM7W+2mQ0naiCeO3BAXvgJji3soVCw
 qv3JuEeJJBUBslZY/31cElsDhxBtIiDdBabmDU6qs9IOz+WjEIBvizuJasXu/Lsk88bC
 AiR8/QM1t3Iuj2EyvszhMgmV9TzvwLBik6GjdPG0delF4dF3EezZweo9L3R6vLEw++LE
 uXcd2Nxs2Y0UdMdxSAhu3+Mz6/0BePaW+IGhITiay4RG6ElkqWhrbYvB36N8XythlMP6
 kzjA3gO1BPGMEQnhrEtbJdVFqzXQGlN27NwLotgAlju43PnVPI9fbqqtEicRU/3DDhVN
 ppjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789127383; x=1789732183;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s919109RUL6soc487a/tAiyHnaWNI4REYPZymA1oVlQ=;
 b=ECPN4IZYwF5Mw6zpaxegkLaZnNwE1bgikYb/Tn9bgfjDN1IXiNqhym9dQZB51I7Rbc
 DJ5ItxnLJBep1kHd5WzyA4rjt3/eLQtdM77hBtA3Rp76HLhLYX3Q3Z0zYdtwt3DacwPa
 Fz1MkywNu9UqcUud4IYOPMgFlVABhZMDWdQ8kzsfYW2rncsN1XZzLyzrxg6fAQV43tVs
 fSj63VY441gvZA7J1CTIkj6YcslZGwnW1efOKMl4iovVD4Wl5/H90LcKu23Tx3KNSX33
 GMxrg/lCYrWJogSn1iefgJxSF64dclYzJUhI0QPvWQldquo0glDuYrfRQn0OJEWy7F14
 sTfQ==
X-Gm-Message-State: AFuF++njJ2JhS8+3M5B1GGdP697oFogt7CZ4AL67Hsn0rsD5wu62cMqH
 5K0Xj2hg8cy7glezgRmeJBYVtJOXvvni3xtVKb1ymzLXeWruU267dxvRKC3WxDOSR18HqCsKDhp
 wcLVnSNfFUHnbpFQW9za0DI7KibaYKD6fO2J6J5u3y68VosM1jlbccjj1LaEuvp6xS8kzx6hg27
 XRF3lKLA==
X-Gm-Gg: AYBFou2sE0ZPEjjs0y9npcA287xbReRW/gBcL5XDyh6yWiQi7sHSlz+mIdWAPY5FaIj
 zuw2Tu7/UD1t+6JHoc0/7QP1DqVaKrZ89HzQpvc1Y48kxzCElRGjM/Qw67BY/i/FodSoUKHgd5H
 N0GuBThCZX8XaFcj0GbJjqGh6b8PJA6mh9tT9oru1e8DWpF1bu8TsP8iiLGBdl2/F++boYrfIhw
 xkDFruDvolDHU8mFhdbCYZMKXolP9rCYBeGNssQvQX5+ykk9AJbA6m9CPeXDqDz71RQS9uwvzk3
 VAmohy9C2uNjMD8U0WFUcqrlu6xYjVW+FQbEKAx05KDC4dtUr7lQaD+2zTXgNEH9LHQKS2WYgzF
 TZ9B2ADhPIi8vEvsj+OTE6J0gwfSt0of0yTkGD/W8mzEkpviD4dbXrtLzvtkHsg6OL0EEOGJN1y
 VtmF78T3u7/dOj4WgO+Tfc/jHQhb9HzaMqMaduLlOf4L46rt2nveS2trDhZ+HK6MukFRY+LQiyq
 /uX9/bup6kCyqe8BZstNxEGXwA+cwAiInCHNyqJbj6KH3D+ZfTgysTyn2Te32aXGNfiNO92DtGf
 pvpXqA/nNqPRuprl5roNqX7kniuCnazLqX9Gp/d7fqf0AtutmpjFi7P2Q+LIEw==
X-Received: by 2002:a05:600c:3b1f:b0:49c:cee2:1697 with SMTP id
 5b1f17b1804b1-49e619e0f85mr43740575e9.16.1789127383131; 
 Fri, 11 Sep 2026 04:49:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm5631843f8f.27.2026.09.11.04.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 04:49:42 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 11:49:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I65f8826f343822c75e789d91881c9dbac676880f
X-Gerrit-Change-Number: 1911
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1911?usp=email>
X-Gerrit-Commit: d351ce40ac593ceeef48eda9b0bb676be8f157ed
References: <gerrit.1789127367000.I65f8826f343822c75e789d91881c9dbac676880f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkk2NWY4ODI2ZjM0MzgyMmM3NWU3ODlkOTE4ODFjOWRiYWM2NzY4ODBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <504d5fdbee660cee8f98de016e56304060993cba-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4zlN-0001O6-S0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cppcheck: Update
 suppressions for current master
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
Content-Type: multipart/mixed; boundary="===============6907882763543366646=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6907882763543366646==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M7ouNb5XRfE="; charset=UTF-8

--M7ouNb5XRfE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1911?usp=3Demail

to review the following change=2E


Chang=
e subject: cppcheck: Update suppressions for current master
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cppcheck: Update suppression=
s for current master

Trying to get to a state where it actually passes whe=
n
merged=2E

Change-Id: I65f8826f343822c75e789d91881c9dbac676880f
Signed-of=
f-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M dev-tools/cppcheck-=
suppression
M dev-tools/run-cppcheck=2Esh
M src/openvpn/ssl=2Ec
3 files cha=
nged, 6 insertions(+), 14 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/11/1911/1

diff --git a/dev-tools/cppchec=
k-suppression b/dev-tools/cppcheck-suppression
index f4f88a3=2E=2Ee1ffe37 1=
00644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppres=
sion
@@ -26,17 +26,14 @@
 getpwnamCalled
 getservbynameCalled
 localtimeCal=
led
-strtokCalled
 # FP: posix=2Ecfg claims suseconds_t is unsigned for som=
e reason
 unsignedLessThanZero:src/openvpn/otime=2Eh:148
 # IGN: multi code=
 does weird things with pointers to local variables=2E=2E=2E
-autoVariables=
:src/openvpn/multi=2Ec:4232
+autoVariables:src/openvpn/multi=2Ec:4242
 auto=
Variables:src/openvpn/multi_io=2Ec:324
 # IGN: the code header =3D 0 | (OPC=
ODE << P_OPCODE_SHIFT) is used intentionally
 badBitmaskCheck:src/openvpn/m=
udp=2Ec
 badBitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec
-# IGN: we s=
tore integers in pointers
-CastAddressToIntegerAtReturn:src/openvpn/multi=
=2Ec
 # IGN: Windows specific (unsigned long =3D=3D unsigned int)
 compareV=
alueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928
 # FP: cppcheck seem=
s to have wrong signature of DeviceIoControl()
@@ -78,8 +75,6 @@
 nullPoint=
erRedundantCheck:src/openvpn/init=2Ec:301
 # FP: cppcheck doesn't understan=
d ZeroMemory
 redundantAssignment:src/openvpnserv/interactive=2Ec:203
-# FP=
: cppcheck doesn't know the NLA macros
-redundantInitialization:src/openvpn=
/dco_linux=2Ec
 # IGN: We reuse the same variable name due to macro usage
 =
shadowVariable:src/openvpn/options=2Ec:1948
 shadowVariable:src/openvpn/opt=
ions=2Ec:1966
@@ -93,12 +88,10 @@
 uninitvar:src/openvpn/options_parse=2Ec:=
148
 # FP: uninit is fine when it is a return parameter
 ctuuninitvar:src/o=
penvpn/crypto_mbedtls_legacy=2Ec:690
-uninitvar:src/openvpnserv/interactive=
=2Ec:2775
+uninitvar:src/openvpnserv/interactive=2Ec:2783
 uninitvar:src/ta=
pctl/main=2Ec:566
-# FP: we added a check but cppcheck is not convinced
-un=
initvar:src/openvpnserv/interactive=2Ec:2667
 # FP: weird parse error, the =
macro is fine in the rest of the file
-unknownMacro:src/openvpnserv/interac=
tive=2Ec:3596
+unknownMacro:src/openvpnserv/interactive=2Ec:3604
 # FP: cpp=
check doesn't account for short-circuiting
 unreadVariable:src/openvpn/mana=
ge=2Ec:682
 unusedFunction:src/openvpn/siphash_reference=2Ec
@@ -112,8 +105=
,6 @@
 unusedFunction:tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
 # =
IGN: keep mocking around for future use
 unusedFunction:tests/unit_tests/op=
envpn/mock_msg=2Ec
-# FP: doesn't account for --wrap
-unusedFunction:tests/=
unit_tests/openvpn/test_tls_crypt=2Ec
 unusedFunction:/usr/include/*
 # FP:=
 cppcheck doesn't know the NLA macros
 unusedLabel:src/openvpn/dco_linux=2E=
c
diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
in=
dex fc14405=2E=2E37de267 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev=
-tools/run-cppcheck=2Esh
@@ -33,7 +33,7 @@
  --suppressions-list=3D${SCRIPT=
_DIR}/cppcheck-suppression \
  --cppcheck-build-dir=3D${CPPCHECK_DIR} \
  -=
-check-level=3D${CPPCHECK_CHECK_LEVEL} --max-configs=3D10 \
- --error-exitc=
ode=3D1"
+ --error-exitcode=3D1 --showtime=3Dsummary"
 
 set -x
 
@@ -53,5 =
+53,6 @@
     -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NET=
BSD \
     -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGO=
NFLY \
     -UTARGET_AIX \
+    -UOPENSSL_NO_EC \
     src/openvpn* src/com=
pat/ \
     tests/unit_tests/example_test/ tests/unit_tests/openvpn*
diff -=
-git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 71459ee=2E=2E48508e5=
 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3226,7 +322=
6,7 @@
         return;
     }
 
-    uint8_t *dataptr =3D to_link->data;
+=
    const uint8_t *dataptr =3D to_link->data;
 
     /* we don't expect sen=
d_reliable to be NULL when state is
      * not S_UNDEF, but people have re=
ported crashes nonetheless,

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1911?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I65f8826f343822c75e789d91881c9dbac676880f
Gerrit-Change-Number: 19=
11
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>

--M7ouNb5XRfE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1911?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">cppcheck: Update suppressions for current master<br><br>Trying to get =
to a state where it actually passes when<br>merged=2E<br><br>Change-Id: I65=
f8826f343822c75e789d91881c9dbac676880f<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/cppcheck-suppression<=
br>M dev-tools/run-cppcheck=2Esh<br>M src/openvpn/ssl=2Ec<br>3 files change=
d, 6 insertions(+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/11/1911/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression</s=
pan><br><span>index f4f88a3=2E=2Ee1ffe37 100644</span><br><span>--- a/dev-t=
ools/cppcheck-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppress=
ion</span><br><span>@@ -26,17 +26,14 @@</span><br><span> getpwnamCalled</sp=
an><br><span> getservbynameCalled</span><br><span> localtimeCalled</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-strtokCalled</span><br><span> =
# FP: posix=2Ecfg claims suseconds_t is unsigned for some reason</span><br>=
<span> unsignedLessThanZero:src/openvpn/otime=2Eh:148</span><br><span> # IG=
N: multi code does weird things with pointers to local variables=2E=2E=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-autoVariables:src/openv=
pn/multi=2Ec:4232</span><br><span style=3D"color: hsl(120, 100%, 40%);">+au=
toVariables:src/openvpn/multi=2Ec:4242</span><br><span> autoVariables:src/o=
penvpn/multi_io=2Ec:324</span><br><span> # IGN: the code header =3D 0 | (OP=
CODE &lt;&lt; P_OPCODE_SHIFT) is used intentionally</span><br><span> badBit=
maskCheck:src/openvpn/mudp=2Ec</span><br><span> badBitmaskCheck:tests/unit_=
tests/openvpn/test_pkt=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# IGN: we store integers in pointers</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-CastAddressToIntegerAtReturn:src/openvpn/multi=2Ec</spa=
n><br><span> # IGN: Windows specific (unsigned long =3D=3D unsigned int)</s=
pan><br><span> compareValueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:9=
28</span><br><span> # FP: cppcheck seems to have wrong signature of DeviceI=
oControl()</span><br><span>@@ -78,8 +75,6 @@</span><br><span> nullPointerRe=
dundantCheck:src/openvpn/init=2Ec:301</span><br><span> # FP: cppcheck doesn=
&#39;t understand ZeroMemory</span><br><span> redundantAssignment:src/openv=
pnserv/interactive=2Ec:203</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# FP: cppcheck doesn&#39;t know the NLA macros</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-redundantInitialization:src/openvpn/dco_lin=
ux=2Ec</span><br><span> # IGN: We reuse the same variable name due to macro=
 usage</span><br><span> shadowVariable:src/openvpn/options=2Ec:1948</span><=
br><span> shadowVariable:src/openvpn/options=2Ec:1966</span><br><span>@@ -9=
3,12 +88,10 @@</span><br><span> uninitvar:src/openvpn/options_parse=2Ec:148=
</span><br><span> # FP: uninit is fine when it is a return parameter</span>=
<br><span> ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:690</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-uninitvar:src/openvpnserv/inter=
active=2Ec:2775</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unin=
itvar:src/openvpnserv/interactive=2Ec:2783</span><br><span> uninitvar:src/t=
apctl/main=2Ec:566</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# F=
P: we added a check but cppcheck is not convinced</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-uninitvar:src/openvpnserv/interactive=2Ec:2667<=
/span><br><span> # FP: weird parse error, the macro is fine in the rest of =
the file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unknownMacro:=
src/openvpnserv/interactive=2Ec:3596</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+unknownMacro:src/openvpnserv/interactive=2Ec:3604</span><b=
r><span> # FP: cppcheck doesn&#39;t account for short-circuiting</span><br>=
<span> unreadVariable:src/openvpn/manage=2Ec:682</span><br><span> unusedFun=
ction:src/openvpn/siphash_reference=2Ec</span><br><span>@@ -112,8 +105,6 @@=
</span><br><span> unusedFunction:tests/unit_tests/openvpnserv/test_openvpns=
erv=2Ec</span><br><span> # IGN: keep mocking around for future use</span><b=
r><span> unusedFunction:tests/unit_tests/openvpn/mock_msg=2Ec</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# FP: doesn&#39;t account for --wra=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedFunction:tests=
/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span> unusedFunction:/usr=
/include/*</span><br><span> # FP: cppcheck doesn&#39;t know the NLA macros<=
/span><br><span> unusedLabel:src/openvpn/dco_linux=2Ec</span><br><span>diff=
 --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><b=
r><span>index fc14405=2E=2E37de267 100755</span><br><span>--- a/dev-tools/r=
un-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><b=
r><span>@@ -33,7 +33,7 @@</span><br><span>  --suppressions-list=3D${SCRIPT_=
DIR}/cppcheck-suppression \</span><br><span>  --cppcheck-build-dir=3D${CPPC=
HECK_DIR} \</span><br><span>  --check-level=3D${CPPCHECK_CHECK_LEVEL} --max=
-configs=3D10 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- --err=
or-exitcode=3D1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ --error-exitcode=3D1 --showtime=3Dsummary&quot;</span><br><span> </span>=
<br><span> set -x</span><br><span> </span><br><span>@@ -53,5 +53,6 @@</span=
><br><span>     -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_N=
ETBSD \</span><br><span>     -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLA=
RIS -UTARGET_DRAGONFLY \</span><br><span>     -UTARGET_AIX \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    -UOPENSSL_NO_EC \</span><br><s=
pan>     src/openvpn* src/compat/ \</span><br><span>     tests/unit_tests/e=
xample_test/ tests/unit_tests/openvpn*</span><br><span>diff --git a/src/ope=
nvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 71459ee=2E=2E48508=
e5 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/s=
rc/openvpn/ssl=2Ec</span><br><span>@@ -3226,7 +3226,7 @@</span><br><span>  =
       return;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    uint8_t *dataptr =3D to_link-&gt;data=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t =
*dataptr =3D to_link-&gt;data;</span><br><span> </span><br><span>     /* we=
 don&#39;t expect send_reliable to be NULL when state is</span><br><span>  =
    * not S_UNDEF, but people have reported crashes nonetheless,</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1911?usp=3Demail">change 1911</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1911?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I65f8826f343822c75e789d91881=
c9dbac676880f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 191=
1 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--M7ouNb5XRfE=--


--===============6907882763543366646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6907882763543366646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6907882763543366646==--

