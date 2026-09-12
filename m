Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F408EC79FB6
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8aV8A7QaHS2cpWjHpJasixURDpom8QYLhlBm1+VDpA=; b=WFE/+rpVgvJhlbsExAe6Ql9whU
	I1GVqjYuAx0dEl1VSg2kYbhXznJnCdtgG82Hg6LrFCIHqrVEo5s6ISp6YsASfhsMUmTyBJzcrAqai
	4L4gMB72wQGDPsW6kS+mbeGi/zb3rYXCRsa6bPHvpu0oMlU0GDJm8dtTlciDP2nZlaws=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5MkQ-0007y5-GH;
	Sat, 12 Sep 2026 12:22:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5MkP-0007xz-Cp
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 12:22:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=r2UK0jCac5XNmC/FyOxj9fHn0erKfsGBTAYHoWxA56o=; b=V3Gx4v80z97kQSFMEgiHBjlYeM
 Dg1IujQBX90azDi+laBLBHhPAKdv6pj2GfPIQFKcJMzhwQ4XjMF2Z1xkfLfBq0TKBr4IVzpv9GAXs
 IfUAfQc6hlyKF3mFDOwX2X2F6uoJI2OVDphxcqdOJ9ulOxqgyfY9Y1RXrOasHzHko7Sc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=r2UK0jCac5XNmC/FyOxj9fHn0erKfsGBTAYHoWxA56o=; b=K
 FchYgZBW9PHQxTWzb5MF2nxS3PBfClTJhMuaZWatwYpBFE3ZJBEYHrHGsbCbZzLT10i8NjSNOnjHd
 EaO0mniJL6sjqC+kEMRQ5i1YlkiZ76ke54y8la1exU3UgX4GLX2iwXOVsV1gdhtOGamY05VY/PpBx
 D5ptYZdHcFel0GAQ=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5MkO-0005lW-3g for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 12:22:21 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49e6deb520eso5596105e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 12 Sep 2026 05:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789215733; x=1789820533; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r2UK0jCac5XNmC/FyOxj9fHn0erKfsGBTAYHoWxA56o=;
 b=ADb3nv+OoYfd6WLVivq9ImDv5/OBgU+V4Gj3RmoHGn9WYXYqY4Uw+vCwEnCtaSH+qH
 9rUTASd2xm5wwvxnEhZqQTq3KcycuJbAeV6GKVcnsyVnWJu0LBZyrEhMqWcBhSM+GHfy
 +Oz+zfCGYbCXHfHmCcH1TFfXsqMV9EnOTzeHtzGbXL3fXiNdUzBsV2QrCdd3BjCzNyLB
 pThN0AWQ+dZVqmMxz7cS6sr+M7Y6b9mjJR/+tt84gC7E+rAcafsZX4WgrwcMcRy+ozOa
 xrXfEqU6dAbY9CLxjjI+VkEa+QsoJ4u1+D2Zo293fQMtUBQ4tLF1d2L4W1LehkSwzr56
 mIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789215733; x=1789820533;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=r2UK0jCac5XNmC/FyOxj9fHn0erKfsGBTAYHoWxA56o=;
 b=YItk7MUX2+QWb5CEm+LeuoFZvI3SusjvJB5JbVJV9c2lK8jAqXOQ9MBm0yi8NuGO2S
 DKVjunqG2+GS3dLfADdLIsw4Vhvrdl8HxAUGy5KSSPvCmNsz9nVaAErmYwq32N7RWkZC
 pElCp7LvViLq9F0UD1tjwNuB4Sz2ldOqhM/X6cHaeMoGYrFfCuNP02MLDliUKVgQzPSF
 oRwi2z6OaH2moqdfBN/hLdiQRqvxIvKW54X/2poPHCbgQ3KZjipRzD6If4ceH4brdvt0
 2KqWB5BpLvcRNMerQeeSFMGjbYiYqqCTwPJEKd8VHk/+tVf6jJWzHYhmYblBVhH9HH91
 GnFA==
X-Gm-Message-State: AFuF++ltEafBmgNW8yCavupZo6Dx7pAijAw2Pp+mHIeDADp19MORkX4R
 Xm1D4iCJTMyuch+1IybG0h7sZ2tTKeDHo18cUOvThMuW9GoMGbGAWh5MS/0pOSKMuWOu3xpyock
 x9fpenhUUdhPXIZqmWHXCKITaMkbTnRLUB2hIgdU6ESUh/UZ8lwpYPbZ5XuXEunnAIvzj
X-Gm-Gg: AYBFou28A2vraZ4S7Sz1VhSM6N+46egk2K98SPh+At1DeMlnyCPygJh1+Y9lNVZG92I
 JsZChe2RJ97TuO12lSUwe8Q4CiC8sd3iCiFTEBZz52dnJMAR15IZwAfHnXuMyGGHqSBRIjJhOXh
 3kjgOnzFGW4IQ3xoC9PqatfhW5mU6hUyWAM110NRUnp6ZNznNo5nJgrSTvB1ZdXTLJqW0VNi7mm
 L3Lobfnt+12FoTSpUGSzQiJs4Vf8PYZn92HOdnpI6blt6LwkGFZ3SBwNrjm8tlKb19XwWCWegF+
 6LuhfypcYKZg9fKoPbSQDwuw8ZInbyHON23wyZydMHIC04u4ucFLegs58c6pdRgl5ofjdyRBzER
 NCzAkXJyRhoy63t+Fa0iArXBU5NyvMbe3WlivIVTpCNzKTAabPVQnx2ljw1w1Vc7pMnVIGjkV6c
 Vf0flPHBxO2NsNIlgVPsvEyzQFL+n6yvtpuZv0mw0UgqQMQMvbIc/mbkBOrY00ppxn3hnnSJVyz
 JkSvoU3uKLYtev+HkKHgr3hRVohhfd8yXBcT92w8ie/vd3JkpEavcEFahkapb7Qax3pgDf0OvWh
 4wj0Vz+mgTjgrvz2bC284wMScyU6zhw4EWplRKeq/Jr2TXXsNKlSK6ZI9WO74g==
X-Received: by 2002:a05:600c:46ce:b0:49e:7368:26 with SMTP id
 5b1f17b1804b1-49e7368030amr6727055e9.22.1789215733347; 
 Sat, 12 Sep 2026 05:22:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e6f1sm12160405f8f.6.2026.09.12.05.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:22:12 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 12 Sep 2026 12:22:11 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I65f8826f343822c75e789d91881c9dbac676880f
X-Gerrit-Change-Number: 1911
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1911?usp=email>
X-Gerrit-Commit: e542754a8fc979e025e6d70186102b1934c1162d
In-Reply-To: <gerrit.1789127367000.I65f8826f343822c75e789d91881c9dbac676880f@gerrit.openvpn.net>
References: <gerrit.1789127367000.I65f8826f343822c75e789d91881c9dbac676880f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkk2NWY4ODI2ZjM0MzgyMmM3NWU3ODlkOTE4ODFjOWRiYWM2NzY4ODBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea92c0e125a4c88939f633f7fd2a826ba59455ef-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5MkO-0005lW-3g
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2193456827052072179=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2193456827052072179==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3E5/dyKOxkM="; charset=UTF-8

--3E5/dyKOxkM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1911?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: cppcheck: Update suppressions for current mast=
er
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cppcheck: =
Update suppressions for current master

Trying to get to a state where it a=
ctually passes when
merged=2E

Change-Id: I65f8826f343822c75e789d91881c9dba=
c676880f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-b=
y: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1911
Message-Id: <20260912102348=2E423-1-gert@greeni=
e=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg39128=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppression
M dev-tools/run-cppcheck=
=2Esh
M src/openvpn/ssl=2Ec
3 files changed, 6 insertions(+), 14 deletions(=
-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/11/=
1911/2

diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-su=
ppression
index f4f88a3=2E=2Ee1ffe37 100644
--- a/dev-tools/cppcheck-suppre=
ssion
+++ b/dev-tools/cppcheck-suppression
@@ -26,17 +26,14 @@
 getpwnamCal=
led
 getservbynameCalled
 localtimeCalled
-strtokCalled
 # FP: posix=2Ecfg =
claims suseconds_t is unsigned for some reason
 unsignedLessThanZero:src/op=
envpn/otime=2Eh:148
 # IGN: multi code does weird things with pointers to l=
ocal variables=2E=2E=2E
-autoVariables:src/openvpn/multi=2Ec:4232
+autoVari=
ables:src/openvpn/multi=2Ec:4242
 autoVariables:src/openvpn/multi_io=2Ec:32=
4
 # IGN: the code header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intent=
ionally
 badBitmaskCheck:src/openvpn/mudp=2Ec
 badBitmaskCheck:tests/unit_t=
ests/openvpn/test_pkt=2Ec
-# IGN: we store integers in pointers
-CastAddres=
sToIntegerAtReturn:src/openvpn/multi=2Ec
 # IGN: Windows specific (unsigned=
 long =3D=3D unsigned int)
 compareValueOutOfTypeRangeError:src/openvpn/ssl=
_verify=2Ec:928
 # FP: cppcheck seems to have wrong signature of DeviceIoCo=
ntrol()
@@ -78,8 +75,6 @@
 nullPointerRedundantCheck:src/openvpn/init=2Ec:3=
01
 # FP: cppcheck doesn't understand ZeroMemory
 redundantAssignment:src/o=
penvpnserv/interactive=2Ec:203
-# FP: cppcheck doesn't know the NLA macros
=
-redundantInitialization:src/openvpn/dco_linux=2Ec
 # IGN: We reuse the sam=
e variable name due to macro usage
 shadowVariable:src/openvpn/options=2Ec:=
1948
 shadowVariable:src/openvpn/options=2Ec:1966
@@ -93,12 +88,10 @@
 unin=
itvar:src/openvpn/options_parse=2Ec:148
 # FP: uninit is fine when it is a =
return parameter
 ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:690
-u=
ninitvar:src/openvpnserv/interactive=2Ec:2775
+uninitvar:src/openvpnserv/in=
teractive=2Ec:2783
 uninitvar:src/tapctl/main=2Ec:566
-# FP: we added a che=
ck but cppcheck is not convinced
-uninitvar:src/openvpnserv/interactive=2Ec=
:2667
 # FP: weird parse error, the macro is fine in the rest of the file
-=
unknownMacro:src/openvpnserv/interactive=2Ec:3596
+unknownMacro:src/openvpn=
serv/interactive=2Ec:3604
 # FP: cppcheck doesn't account for short-circuit=
ing
 unreadVariable:src/openvpn/manage=2Ec:682
 unusedFunction:src/openvpn/=
siphash_reference=2Ec
@@ -112,8 +105,6 @@
 unusedFunction:tests/unit_tests/=
openvpnserv/test_openvpnserv=2Ec
 # IGN: keep mocking around for future use=

 unusedFunction:tests/unit_tests/openvpn/mock_msg=2Ec
-# FP: doesn't accou=
nt for --wrap
-unusedFunction:tests/unit_tests/openvpn/test_tls_crypt=2Ec
 =
unusedFunction:/usr/include/*
 # FP: cppcheck doesn't know the NLA macros
 =
unusedLabel:src/openvpn/dco_linux=2Ec
diff --git a/dev-tools/run-cppcheck=
=2Esh b/dev-tools/run-cppcheck=2Esh
index fc14405=2E=2E37de267 100755
--- a=
/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -33,7 +33=
,7 @@
  --suppressions-list=3D${SCRIPT_DIR}/cppcheck-suppression \
  --cppc=
heck-build-dir=3D${CPPCHECK_DIR} \
  --check-level=3D${CPPCHECK_CHECK_LEVEL=
} --max-configs=3D10 \
- --error-exitcode=3D1"
+ --error-exitcode=3D1 --sho=
wtime=3Dsummary"
 
 set -x
 
@@ -53,5 +53,6 @@
     -UTARGET_LINUX -UTARGET=
_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
     -UTARGET_DARWIN -UTARGET_A=
NDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
     -UTARGET_AIX \
+    -UOPE=
NSSL_NO_EC \
     src/openvpn* src/compat/ \
     tests/unit_tests/example_=
test/ tests/unit_tests/openvpn*
diff --git a/src/openvpn/ssl=2Ec b/src/open=
vpn/ssl=2Ec
index 71459ee=2E=2E48508e5 100644
--- a/src/openvpn/ssl=2Ec
+++=
 b/src/openvpn/ssl=2Ec
@@ -3226,7 +3226,7 @@
         return;
     }
 
-   =
 uint8_t *dataptr =3D to_link->data;
+    const uint8_t *dataptr =3D to_lin=
k->data;
 
     /* we don't expect send_reliable to be NULL when state is
 =
     * not S_UNDEF, but people have reported crashes nonetheless,

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1911?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65f8826f343822c75e789d91=
881c9dbac676880f
Gerrit-Change-Number: 1911
Gerrit-PatchSet: 2
Gerrit-Owner=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--3E5/dyKOxkM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1911?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">cppcheck: Update suppres=
sions for current master<br><br>Trying to get to a state where it actually =
passes when<br>merged=2E<br><br>Change-Id: I65f8826f343822c75e789d91881c9db=
ac676880f<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1911<br>Message-Id: &lt;202609=
12102348=2E423-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39128=2Ehtml<br>Signe=
d-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tool=
s/cppcheck-suppression<br>M dev-tools/run-cppcheck=2Esh<br>M src/openvpn/ss=
l=2Ec<br>3 files changed, 6 insertions(+), 14 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/11/1911/2</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/dev-tools/=
cppcheck-suppression</span><br><span>index f4f88a3=2E=2Ee1ffe37 100644</spa=
n><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b/dev-=
tools/cppcheck-suppression</span><br><span>@@ -26,17 +26,14 @@</span><br><s=
pan> getpwnamCalled</span><br><span> getservbynameCalled</span><br><span> l=
ocaltimeCalled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-strtokC=
alled</span><br><span> # FP: posix=2Ecfg claims suseconds_t is unsigned for=
 some reason</span><br><span> unsignedLessThanZero:src/openvpn/otime=2Eh:14=
8</span><br><span> # IGN: multi code does weird things with pointers to loc=
al variables=2E=2E=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
autoVariables:src/openvpn/multi=2Ec:4232</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+autoVariables:src/openvpn/multi=2Ec:4242</span><br><sp=
an> autoVariables:src/openvpn/multi_io=2Ec:324</span><br><span> # IGN: the =
code header =3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is used intentionally<=
/span><br><span> badBitmaskCheck:src/openvpn/mudp=2Ec</span><br><span> badB=
itmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-# IGN: we store integers in pointers</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-CastAddressToIntegerAtReturn:src=
/openvpn/multi=2Ec</span><br><span> # IGN: Windows specific (unsigned long =
=3D=3D unsigned int)</span><br><span> compareValueOutOfTypeRangeError:src/o=
penvpn/ssl_verify=2Ec:928</span><br><span> # FP: cppcheck seems to have wro=
ng signature of DeviceIoControl()</span><br><span>@@ -78,8 +75,6 @@</span><=
br><span> nullPointerRedundantCheck:src/openvpn/init=2Ec:301</span><br><spa=
n> # FP: cppcheck doesn&#39;t understand ZeroMemory</span><br><span> redund=
antAssignment:src/openvpnserv/interactive=2Ec:203</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-# FP: cppcheck doesn&#39;t know the NLA macros<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-redundantInitializatio=
n:src/openvpn/dco_linux=2Ec</span><br><span> # IGN: We reuse the same varia=
ble name due to macro usage</span><br><span> shadowVariable:src/openvpn/opt=
ions=2Ec:1948</span><br><span> shadowVariable:src/openvpn/options=2Ec:1966<=
/span><br><span>@@ -93,12 +88,10 @@</span><br><span> uninitvar:src/openvpn/=
options_parse=2Ec:148</span><br><span> # FP: uninit is fine when it is a re=
turn parameter</span><br><span> ctuuninitvar:src/openvpn/crypto_mbedtls_leg=
acy=2Ec:690</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uninitvar:=
src/openvpnserv/interactive=2Ec:2775</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+uninitvar:src/openvpnserv/interactive=2Ec:2783</span><br><=
span> uninitvar:src/tapctl/main=2Ec:566</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# FP: we added a check but cppcheck is not convinced</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-uninitvar:src/openvpnserv/=
interactive=2Ec:2667</span><br><span> # FP: weird parse error, the macro is=
 fine in the rest of the file</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-unknownMacro:src/openvpnserv/interactive=2Ec:3596</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+unknownMacro:src/openvpnserv/interact=
ive=2Ec:3604</span><br><span> # FP: cppcheck doesn&#39;t account for short-=
circuiting</span><br><span> unreadVariable:src/openvpn/manage=2Ec:682</span=
><br><span> unusedFunction:src/openvpn/siphash_reference=2Ec</span><br><spa=
n>@@ -112,8 +105,6 @@</span><br><span> unusedFunction:tests/unit_tests/open=
vpnserv/test_openvpnserv=2Ec</span><br><span> # IGN: keep mocking around fo=
r future use</span><br><span> unusedFunction:tests/unit_tests/openvpn/mock_=
msg=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: doesn&#3=
9;t account for --wrap</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-unusedFunction:tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span=
> unusedFunction:/usr/include/*</span><br><span> # FP: cppcheck doesn&#39;t=
 know the NLA macros</span><br><span> unusedLabel:src/openvpn/dco_linux=2Ec=
</span><br><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-c=
ppcheck=2Esh</span><br><span>index fc14405=2E=2E37de267 100755</span><br><s=
pan>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-c=
ppcheck=2Esh</span><br><span>@@ -33,7 +33,7 @@</span><br><span>  --suppress=
ions-list=3D${SCRIPT_DIR}/cppcheck-suppression \</span><br><span>  --cppche=
ck-build-dir=3D${CPPCHECK_DIR} \</span><br><span>  --check-level=3D${CPPCHE=
CK_CHECK_LEVEL} --max-configs=3D10 \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- --error-exitcode=3D1&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ --error-exitcode=3D1 --showtime=3Dsummary&quot;</sp=
an><br><span> </span><br><span> set -x</span><br><span> </span><br><span>@@=
 -53,5 +53,6 @@</span><br><span>     -UTARGET_LINUX -UTARGET_FREEBSD -UTARG=
ET_OPENBSD -UTARGET_NETBSD \</span><br><span>     -UTARGET_DARWIN -UTARGET_=
ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \</span><br><span>     -UTARGET=
_AIX \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    -UOPENSSL=
_NO_EC \</span><br><span>     src/openvpn* src/compat/ \</span><br><span>  =
   tests/unit_tests/example_test/ tests/unit_tests/openvpn*</span><br><span=
>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>ind=
ex 71459ee=2E=2E48508e5 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</s=
pan><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3226,7 +3226,7 =
@@</span><br><span>         return;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *dataptr=
 =3D to_link-&gt;data;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const uint8_t *dataptr =3D to_link-&gt;data;</span><br><span> </span=
><br><span>     /* we don&#39;t expect send_reliable to be NULL when state =
is</span><br><span>      * not S_UNDEF, but people have reported crashes no=
netheless,</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1911?usp=3Demail">change 1911</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1911?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65f8=
826f343822c75e789d91881c9dbac676880f </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1911 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--3E5/dyKOxkM=--


--===============2193456827052072179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2193456827052072179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2193456827052072179==--

