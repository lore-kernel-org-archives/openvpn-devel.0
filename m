Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E1BCD8CAA
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zz3GFZZrD8Bocud2UvkoQn2zGaJFYFYYODHLfjH8SZo=; b=VLJifdGgZegb41L/lv6D7bAU41
	U6Iz7Ez4f+i2YFw3PGN6H0W2ByG8+D0xZUt6APAISZCZh4GV10qeABiKqVT6hlrfElgJVNTn7gvfd
	vcRwDJA+t8QT9ilp7/2I7B3AwQIjalvrZOT8Xojhh1zul0zgIog1+UH8VJZ2KYXQP9dY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxut-0000lg-ER;
	Tue, 09 Jun 2026 14:59:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxur-0000lN-Lq
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MlB+/uMy0owGuuN6jfvJPWrRHSZG3JuwvbT/l4XnIs4=; b=VbSDN5zNYsWtyrrQ3UWic+znvE
 +GU1GVWdvYhEZOsIZI5qbL6I8vGRRPXJJmPowzzQh1ASAN2JA6fcSHh+o+B7htHiRyX93ldE3dSFZ
 mfUpmQhNgv3/Cr34W2k47h73fDuerT3vn+3w/w0pTItpEYeYYnJAr+cU2p7X9a47+FeU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MlB+/uMy0owGuuN6jfvJPWrRHSZG3JuwvbT/l4XnIs4=; b=W
 LMbU+BLn3q0mkJGaB4XysNzawz4DH96ahE34WczfWxlliekUOjxO9rrZMMaDwvh/L6Yp0CytP6mOA
 CzwM23dr9Sor1eL4dR9qk4eyVA8QyHYNwGLN/X9OGNkqI69YhcHDEF+xsWtOnKz7sS/a+LMZc/AwR
 IK5HSfpNcaVl/Im8=;
Received: from mail-lj1-f182.google.com ([209.85.208.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxum-0008W2-TF for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:58:58 +0000
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-3967738c801so48174541fa.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781017127; x=1781621927; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MlB+/uMy0owGuuN6jfvJPWrRHSZG3JuwvbT/l4XnIs4=;
 b=NeoppaQsX00i5WHllxE+Szn3MUSdnHWpC3yNEi/Rh9im+rUl9P9lr2/GVpiVqf/29x
 /pg1Om5Pnq9d7aBILWisfncQNeOJajDUfyEJiXUxa5FdgsPTc8apse/Sr1c6JvQHWYVq
 53xvanL4ce6MJDeA+dU0gRInS8f1fIi7w/952HgNgzlBdt7uY8TPYRhnSJExeI1zJaQV
 2ainWlIwC9RbSDG5zwdVwRzGeKbW7X2tzUogA17zgPsgyJMScvPVhxVbORSU74Y4ZtuC
 vWiXEIo1bry5RTK3oWGJjI0qciIrA5uLIXWpOX/WPHgGz4aDgZDoDZEg5+dzExHS30sT
 uZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017127; x=1781621927;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MlB+/uMy0owGuuN6jfvJPWrRHSZG3JuwvbT/l4XnIs4=;
 b=P6mPBMY+Mm+N+fedGoeAYo5dHS2w3Vwf2yqxNr67hkePTPy6HygyD4snUSpIsjAPt4
 XAmprGUSU89feK8h9UOKjSMbe5jMiwuUC/i/swdV4Kdc41VxCFi4EqE01a89GGz39kWO
 QRSm+il3rJUaE42/SeCTsOjNCIgRDAOI8GiLjzTikFZUSlU2pziBjyJESEMWLpRuyqD6
 BFk5zdlKqSYmKoF9Mfj09UMvp4+zla+39FW66VT56AF4Kc0xMQDa8z+IgajcFTffRA8Y
 dqdjAFMGBbDIKdffFJjPyPrCwuPCb3fyP2pTe/mXaGCoYrqaqCvzXdATo/QM/VBt3wyd
 ol8w==
X-Gm-Message-State: AOJu0YyRGTKUQh1J09nJBVf+OAVLMBPtClvBPaLUY2jBdy7idwadGuEG
 cJCSrHglbtmJJd26v8RqcvqX4nWm8LAzOh0cNilPAyXAydF7YsBFHyRZL20Z4ZCiFKmeIyfk8D2
 BoDawjy16fULbubPKMWkNgMlJdefCucjNhlEYJhHsqxmOutv5xfEvMKLgpedin5zceRLFp2+RoR
 9Kuvwxqg==
X-Gm-Gg: Acq92OFzDHqHfdUMEVNeyCehEn5Y4hTDCiPk05miplmY0XLnytCwwQyJtoSbwh8Wzkd
 b+mcIhYI6r6jMHsYkmZQAqKjicVIclBDP652dqh5zSdgT1WvxAcj2VQYtREgBtTNCyVXC+7sKF9
 PbnC4bqetDyh/gtAQnHbGgFGHlmAc+wia+WjVTwMDcXOcm61EIic7CY95mHblSU9Kqo5QJq+ob6
 Uf6B/raK1Xnu0vAHYuaT31NXRG80erK38C/wR92xQFsk/g/q5xyM7QwAMwhJBNqhGKj0GdZrYz4
 OXpYPz9LSmnNv/mHMDtR6x+xxN0VxWthrrIua49dayVG/KhRIFDopDxrmq+Mu41IyDcvciaxwPC
 +COuCyvnF44BZYpBizIE8VAjoznQZ1d/lK/RSQ59tiilvk+8V4CFhZPlFLx6zCD4wX3IupKrof0
 UXWDNGX+xc3BDW3SATO5m1jRPh4A5gBnFpYZIFsv2/kI3G/pL5xz94eqLK9MDhJu0jS9NtkOlQg
 88ea5egvPRmYVjYj06BrhqSjLi8/zOFt6T6ma//TYvdPhUfFBgPm0zb6febsYX+xD8Yl1wtaBpA
 ENFAnd5F8xYGnqrkNW4oUI0R
X-Received: by 2002:a05:600c:314e:b0:490:9d1b:2022 with SMTP id
 5b1f17b1804b1-490c257bb25mr308732455e9.13.1780989074414; 
 Tue, 09 Jun 2026 00:11:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc391aaasm527210335e9.1.2026.06.09.00.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 00:11:13 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 07:11:12 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I05720ccc3bcf706bbe62254afb74562580f5de56
X-Gerrit-Change-Number: 1665
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1665?usp=email>
X-Gerrit-Commit: a71e8508f93f6ea19841779e42b9d60561613195
In-Reply-To: <gerrit.1778102459000.I05720ccc3bcf706bbe62254afb74562580f5de56@gerrit.openvpn.net>
References: <gerrit.1778102459000.I05720ccc3bcf706bbe62254afb74562580f5de56@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MTAyNDU5MDAwLkkwNTcyMGNjYzNiY2Y3MDZiYmU2MjI1NGFmYjc0NTYyNTgwZjVkZTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <df2512741c4b779b74b2e691172d54979607d065-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxum-0008W2-TF
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7717978975439540813=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7717978975439540813==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZZTQJFX1skQ="; charset=UTF-8

--ZZTQJFX1skQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1665?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: dev-tools: Fix run-cppcheck to cover more code
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dev-tools: Fi=
x run-cppcheck to cover more code

Massively improve how we call cppcheck t=
o cover
more code and identify more issues=2E

When specifying any -D argum=
ent all other defines
are ignored unless --force or --max-configs is
specif=
ied as well=2E I mistakenly assumed that this
was covered by --check-level=
=3Dexhaustive=2E We need
to try finding a value for --max-configs so that
c=
ppcheck doesn't spend hours scanning options=2Ec

Add a library cfg for our=
 code which for now
- identifies some printf-style functions
- adds some co=
mmon macro defines

Use existing libraries=2E

Add a second call to cppchec=
k to separate the
Windows and Unixy code scans=2E This avoids some
very non=
-sensical define combinations=2E

Change-Id: I05720ccc3bcf706bbe62254afb745=
62580f5de56
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acke=
d-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1665
Message-Id: <20260607170713=2E4980-1-gert@gre=
enie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg37078=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppression
A dev-tools/openvpn-cp=
pcheck-library=2Ecfg
M dev-tools/run-cppcheck=2Esh
3 files changed, 89 inse=
rtions(+), 17 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/65/1665/5

diff --git a/dev-tools/cppcheck-suppression=
 b/dev-tools/cppcheck-suppression
index 439cbb1=2E=2E2e3350b 100644
--- a/d=
ev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -5,6 =
+5,9 @@
 constParameterPointer
 constVariable
 constVariablePointer
+invali=
dPrintfArgType_sint
+invalidPrintfArgType_uint
+usleepCalled
 variableScope=

 # We have a lot of library includes, not all of them are really required,=

 # so ignore them
@@ -16,29 +19,44 @@
 # These are specific false-positive=
s (FP) or ignored (IGN) issues
 # We might want to move some of them to inl=
ine-suppression to avoid
 # the static line-numbers
+# IGN: posix=2Ecfg: We=
 are not threadsafe
+getgrnamCalled
+getpwnamCalled
+getservbynameCalled
+l=
ocaltimeCalled
+strtokCalled
+# FP: posix=2Ecfg claims suseconds_t is unsig=
ned for some reason
+unsignedLessThanZero:src/openvpn/otime=2Eh:235
 # IGN:=
 multi code does weird things with pointers to local variables=2E=2E=2E
 au=
toVariables:src/openvpn/multi=2Ec:4177
 autoVariables:src/openvpn/multi_io=
=2Ec:280
 # IGN: the code header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used=
 intentionally
 badBitmaskCheck:src/openvpn/mudp=2Ec
 badBitmaskCheck:tests=
/unit_tests/openvpn/test_pkt=2Ec
+# IGN: we store integers in pointers
+Cas=
tAddressToIntegerAtReturn:src/openvpn/multi=2Ec
 # IGN: event code uses a p=
ointer to store integers
-intToPointerCast:src/openvpn/multi_io=2Ec
 intToP=
ointerCast:src/openvpn/forward=2Ec
-# FP: crt_error is always true on Unix,=
 but not Windows
+intToPointerCast:src/openvpn/multi_io=2Ec
+intToPointerCa=
st:src/openvpn/ps=2Ec
+# FP: constant but differs between platforms
 knownC=
onditionTrueFalse:src/openvpn/error=2Eh:380
+knownConditionTrueFalse:src/op=
envpn/fdmisc=2Ec:80
+knownConditionTrueFalse:src/openvpn/lladdr=2Ec:65
+kno=
wnConditionTrueFalse:src/openvpn/platform=2Ec
 # FP: code needs to accomoda=
te many different defines
+knownConditionTrueFalse:src/openvpn/event=2Ec:11=
39
 knownConditionTrueFalse:src/openvpn/event=2Ec:1148
 # FP: dco_win suppo=
rt has "false" stubs
 knownConditionTrueFalse:src/openvpn/forward=2Ec
 know=
nConditionTrueFalse:src/openvpn/init=2Ec
 knownConditionTrueFalse:src/openv=
pn/multi_io=2Ec:163
-# FP: cppcheck thinks that management_query_user_pass =
is always true,
-# but no idea why
+# FP: cppcheck thinks that some functio=
ns always return true, but they don't
 knownConditionTrueFalse:src/openvpn/=
misc=2Ec:97
+knownConditionTrueFalse:src/openvpn/sig=2Eh:116
 # FP: cert_ur=
i_supported is a wrapper around defines, so it's
 # always constant but dif=
fers depending on OpenSSL version
-knownConditionTrueFalse:src/openvpn/ssl_=
openssl=2Ec:1258
+knownConditionTrueFalse:src/openvpn/ssl_openssl=2Ec:1332
=
 # FP: cppcheck doesn't understand that the function changes szErrMessage
 =
knownConditionTrueFalse:src/tapctl/main=2Ec:704
 knownConditionTrueFalse:sr=
c/openvpnmsica/dllmain=2Ec:164
@@ -50,9 +68,13 @@
 missingInclude:src/openv=
pnserv/common=2Ec:25
 # IGN: strlen(NULL) is not nice code, but seems to wo=
rk
 nullPointerRedundantCheck:src/openvpn/init=2Ec:299
+# FP: cppcheck does=
n't understand ZeroMemory
+redundantAssignment:src/openvpnserv/interactive=
=2Ec:203
 # IGN: We reuse the same variable name due to macro usage
 shadow=
Variable:src/openvpn/options=2Ec:2580
 shadowVariable:src/openvpn/options=
=2Ec:2598
+# FP: this file is never compiled on _WIN32
+umaskCalled:tests/u=
nit_tests/openvpn/test_pkcs11=2Ec
 # FP: yes, t_prev is unitialized, but t_=
prev_len is 0, so that's handled
 uninitvar:src/openvpn/crypto_epoch=2Ec:60=

 # FP: yes, parm is unitialized, but parm_len is 0, so that's handled
@@ -=
61,6 +83,10 @@
 ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:698
 uni=
nitvar:src/openvpnserv/interactive=2Ec:1935
 uninitvar:src/tapctl/main=2Ec:=
566
+# FP: we added a check but cppcheck is not convinced
+uninitvar:src/op=
envpnserv/interactive=2Ec:2667
+# FP: weird parse error, the macro is fine =
in the rest of the file
+unknownMacro:src/openvpnserv/interactive=2Ec:3488
=
 # FP: cppcheck doesn't account for short-circuiting
 unreadVariable:src/op=
envpn/manage=2Ec:682
 unusedFunction:src/openvpn/siphash_reference=2Ec
diff=
 --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-tools/openvpn-cppch=
eck-library=2Ecfg
new file mode 100644
index 0000000=2E=2E1ea91f4
--- /dev/=
null
+++ b/dev-tools/openvpn-cppcheck-library=2Ecfg
@@ -0,0 +1,29 @@
+<?xml=
 version =3D"1=2E0"?>
+<def>
+  <function name=3D"x_msg">
+    <formatstr t=
ype=3D"printf"/>
+    <arg nr=3D"2">
+      <formatstr />
+    </arg>
+  </=
function>
+  <function name=3D"buf_printf">
+    <formatstr type=3D"printf"=
/>
+    <arg nr=3D"2">
+      <formatstr />
+    </arg>
+  </function>
+  <=
function name=3D"checked_snprintf">
+    <formatstr type=3D"printf"/>
+    =
<arg nr=3D"3">
+      <formatstr />
+    </arg>
+  </function>
+  <function=
 name=3D"check_malloc_return">
+    <noreturn>true</noreturn>
+  </function=
>
+  <define name=3D"HAVE_CONFIG_H" value=3D"1" />
+  <define name=3D"CONFI=
GURE_SPECIAL_BUILD" value=3D"foo" />
+  <!-- work around macro confusion --=
>
+  <define name=3D"CMSG_FIRSTHDR" value=3D"cmsg_firsthdr" />
+  <define n=
ame=3D"CMSG_NXTHDR" value=3D"cmsg_nxthdr" />
+</def>
diff --git a/dev-tools=
/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index 674fc092=2E=2E40db33=
e 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Es=
h
@@ -7,20 +7,37 @@
 : ${BUILD_DIR:=3D$PWD}
 : ${INCLUDE_FLAGS:=3D}
 CPPCHE=
CK_DIR=3D"${BUILD_DIR}/cppcheck_build_dir"
+COMMON_ARGS=3D"-j$(nproc) -q \
=
+ -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
+ -I=2E=
/include/ -I=2E/tests/unit_tests/openvpn/ \
+ -I=2E/src/compat/ -I=2E/src/o=
penvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pam/ \
+ -I${BUILD_DI=
R} -I${BUILD_DIR}/include/ \
+ --enable=3Dall \
+ --library=3D${SCRIPT_DIR}=
/openvpn-cppcheck-library=2Ecfg \
+ --library=3Dopenssl=2Ecfg \
+ --suppres=
sions-list=3D${SCRIPT_DIR}/cppcheck-suppression \
+ --cppcheck-build-dir=3D=
${CPPCHECK_DIR} \
+ --check-level=3Dexhaustive --max-configs=3D10 \
+ --err=
or-exitcode=3D1"
+
 
 set -x
 
 mkdir -p "$CPPCHECK_DIR"
 cd "${SOURCE_DIR}=
"
-cppcheck -j$(nproc) \
-	 -DHAVE_CONFIG_H -U_WIN32 \
-         -DMBEDTLS_=
SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
-	 -I=2E/include/ -=
I=2E/tests/unit_tests/openvpn/ \
-	 -I=2E/src/compat/ -I=2E/src/openvpn/ -I=
=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pam/ \
-	 -I"${BUILD_DIR}" -I"$=
{BUILD_DIR}/include/" $INCLUDE_FLAGS \
-	 --enable=3Dall \
-	 --suppression=
s-list=3D"${SCRIPT_DIR}/cppcheck-suppression" \
-	 --cppcheck-build-dir=3D"=
${CPPCHECK_DIR}" \
-	 --check-level=3Dexhaustive \
-	 --error-exitcode=3D1 =
\
-	 src/ tests/ sample/
+cppcheck $COMMON_ARGS $INCLUDE_FLAGS \
+         =
--platform=3Dunix64 \
+         --library=3Dposix=2Ecfg --library=3Dbsd=2Ec=
fg --library=3Dgnu=2Ecfg \
+         -U_WIN32 \
+         src/openvpn/ src/=
compat/ src/plugins/ sample/ \
+         tests/unit_tests/example_test/ tes=
ts/unit_tests/openvpn/ \
+         tests/unit_tests/plugins/
+cppcheck $COM=
MON_ARGS \
+         --platform=3Dwin64 \
+         --library=3Dwindows=2Ec=
fg \
+         -D_WIN32 \
+         -UTARGET_LINUX -UTARGET_FREEBSD -UTARGE=
T_OPENBSD -UTARGET_NETBSD \
+         -UTARGET_DARWIN -UTARGET_ANDROID -UTA=
RGET_SOLARIS -UTARGET_DRAGONFLY \
+         -UTARGET_AIX \
+         src/op=
envpn* src/compat/ \
+         tests/unit_tests/example_test/ tests/unit_te=
sts/openvpn*

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1665?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I057=
20ccc3bcf706bbe62254afb74562580f5de56
Gerrit-Change-Number: 1665
Gerrit-Pat=
chSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Review=
er: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--ZZTQJFX1skQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1665?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">dev-tools: Fix run-cppchec=
k to cover more code<br><br>Massively improve how we call cppcheck to cover=
<br>more code and identify more issues=2E<br><br>When specifying any -D arg=
ument all other defines<br>are ignored unless --force or --max-configs is<b=
r>specified as well=2E I mistakenly assumed that this<br>was covered by --c=
heck-level=3Dexhaustive=2E We need<br>to try finding a value for --max-conf=
igs so that<br>cppcheck doesn&#39;t spend hours scanning options=2Ec<br><br=
>Add a library cfg for our code which for now<br>- identifies some printf-s=
tyle functions<br>- adds some common macro defines<br><br>Use existing libr=
aries=2E<br><br>Add a second call to cppcheck to separate the<br>Windows an=
d Unixy code scans=2E This avoids some<br>very non-sensical define combinat=
ions=2E<br><br>Change-Id: I05720ccc3bcf706bbe62254afb74562580f5de56<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1665<br>Message-Id: &lt;20260607170713=2E4980-=
1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg37078=2Ehtml<br>Signed-off-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cppcheck-supp=
ression<br>A dev-tools/openvpn-cppcheck-library=2Ecfg<br>M dev-tools/run-cp=
pcheck=2Esh<br>3 files changed, 89 insertions(+), 17 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/65/1665/5</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/dev=
-tools/cppcheck-suppression</span><br><span>index 439cbb1=2E=2E2e3350b 1006=
44</span><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++=
 b/dev-tools/cppcheck-suppression</span><br><span>@@ -5,6 +5,9 @@</span><br=
><span> constParameterPointer</span><br><span> constVariable</span><br><spa=
n> constVariablePointer</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+invalidPrintfArgType_sint</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+invalidPrintfArgType_uint</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+usleepCalled</span><br><span> variableScope</span><br><span=
> # We have a lot of library includes, not all of them are really required,=
</span><br><span> # so ignore them</span><br><span>@@ -16,29 +19,44 @@</spa=
n><br><span> # These are specific false-positives (FP) or ignored (IGN) iss=
ues</span><br><span> # We might want to move some of them to inline-suppres=
sion to avoid</span><br><span> # the static line-numbers</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# IGN: posix=2Ecfg: We are not threads=
afe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+getgrnamCalled</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+getpwnamCalled</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+getservbynameCalled</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+localtimeCalled</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+strtokCalled</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# FP: posix=2Ecfg claims suseconds_t =
is unsigned for some reason</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+unsignedLessThanZero:src/openvpn/otime=2Eh:235</span><br><span> # I=
GN: multi code does weird things with pointers to local variables=2E=2E=2E<=
/span><br><span> autoVariables:src/openvpn/multi=2Ec:4177</span><br><span> =
autoVariables:src/openvpn/multi_io=2Ec:280</span><br><span> # IGN: the code=
 header =3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is used intentionally</spa=
n><br><span> badBitmaskCheck:src/openvpn/mudp=2Ec</span><br><span> badBitma=
skCheck:tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# IGN: we store integers in pointers</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+CastAddressToIntegerAtReturn:src=
/openvpn/multi=2Ec</span><br><span> # IGN: event code uses a pointer to sto=
re integers</span><br><span style=3D"color: hsl(0, 100%, 40%);">-intToPoint=
erCast:src/openvpn/multi_io=2Ec</span><br><span> intToPointerCast:src/openv=
pn/forward=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: c=
rt_error is always true on Unix, but not Windows</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+intToPointerCast:src/openvpn/multi_io=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+intToPointerCast:src/ope=
nvpn/ps=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: co=
nstant but differs between platforms</span><br><span> knownConditionTrueFal=
se:src/openvpn/error=2Eh:380</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:80</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/=
lladdr=2Ec:65</span><br><span style=3D"color: hsl(120, 100%, 40%);">+knownC=
onditionTrueFalse:src/openvpn/platform=2Ec</span><br><span> # FP: code need=
s to accomodate many different defines</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/event=2Ec:1139</span=
><br><span> knownConditionTrueFalse:src/openvpn/event=2Ec:1148</span><br><s=
pan> # FP: dco_win support has &quot;false&quot; stubs</span><br><span> kno=
wnConditionTrueFalse:src/openvpn/forward=2Ec</span><br><span> knownConditio=
nTrueFalse:src/openvpn/init=2Ec</span><br><span> knownConditionTrueFalse:sr=
c/openvpn/multi_io=2Ec:163</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# FP: cppcheck thinks that management_query_user_pass is always true,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-# but no idea why</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: cppcheck thinks th=
at some functions always return true, but they don&#39;t</span><br><span> k=
nownConditionTrueFalse:src/openvpn/misc=2Ec:97</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/sig=2Eh:116<=
/span><br><span> # FP: cert_uri_supported is a wrapper around defines, so i=
t&#39;s</span><br><span> # always constant but differs depending on OpenSSL=
 version</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditio=
nTrueFalse:src/openvpn/ssl_openssl=2Ec:1258</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/ssl_openssl=2Ec=
:1332</span><br><span> # FP: cppcheck doesn&#39;t understand that the funct=
ion changes szErrMessage</span><br><span> knownConditionTrueFalse:src/tapct=
l/main=2Ec:704</span><br><span> knownConditionTrueFalse:src/openvpnmsica/dl=
lmain=2Ec:164</span><br><span>@@ -50,9 +68,13 @@</span><br><span> missingIn=
clude:src/openvpnserv/common=2Ec:25</span><br><span> # IGN: strlen(NULL) is=
 not nice code, but seems to work</span><br><span> nullPointerRedundantChec=
k:src/openvpn/init=2Ec:299</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# FP: cppcheck doesn&#39;t understand ZeroMemory</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+redundantAssignment:src/openvpnserv/int=
eractive=2Ec:203</span><br><span> # IGN: We reuse the same variable name du=
e to macro usage</span><br><span> shadowVariable:src/openvpn/options=2Ec:25=
80</span><br><span> shadowVariable:src/openvpn/options=2Ec:2598</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# FP: this file is never compil=
ed on _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+umaskCa=
lled:tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span> # FP: yes, t=
_prev is unitialized, but t_prev_len is 0, so that&#39;s handled</span><br>=
<span> uninitvar:src/openvpn/crypto_epoch=2Ec:60</span><br><span> # FP: yes=
, parm is unitialized, but parm_len is 0, so that&#39;s handled</span><br><=
span>@@ -61,6 +83,10 @@</span><br><span> ctuuninitvar:src/openvpn/crypto_mb=
edtls_legacy=2Ec:698</span><br><span> uninitvar:src/openvpnserv/interactive=
=2Ec:1935</span><br><span> uninitvar:src/tapctl/main=2Ec:566</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# FP: we added a check but cppchec=
k is not convinced</span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
ninitvar:src/openvpnserv/interactive=2Ec:2667</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# FP: weird parse error, the macro is fine in the=
 rest of the file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+un=
knownMacro:src/openvpnserv/interactive=2Ec:3488</span><br><span> # FP: cppc=
heck doesn&#39;t account for short-circuiting</span><br><span> unreadVariab=
le:src/openvpn/manage=2Ec:682</span><br><span> unusedFunction:src/openvpn/s=
iphash_reference=2Ec</span><br><span>diff --git a/dev-tools/openvpn-cppchec=
k-library=2Ecfg b/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>=
new file mode 100644</span><br><span>index 0000000=2E=2E1ea91f4</span><br><=
span>--- /dev/null</span><br><span>+++ b/dev-tools/openvpn-cppcheck-library=
=2Ecfg</span><br><span>@@ -0,0 +1,29 @@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+&lt;?xml version =3D&quot;1=2E0&quot;?&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+&lt;def&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  &lt;function name=3D&quot;x_msg&quot;&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;formatst=
r type=3D&quot;printf&quot;/&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &lt;arg nr=3D&quot;2&quot;&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      &lt;formatstr /&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;/arg&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;/function&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;function name=3D&quot;buf_printf&quot;=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;formats=
tr type=3D&quot;printf&quot;/&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &lt;arg nr=3D&quot;2&quot;&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      &lt;formatstr /&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &lt;/arg&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/function&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;function name=3D&quot;checked_snpri=
ntf&quot;&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &l=
t;formatstr type=3D&quot;printf&quot;/&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &lt;arg nr=3D&quot;3&quot;&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      &lt;formatstr /&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &lt;/arg&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  &lt;/function&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  &lt;function name=3D&quot;check_=
malloc_return&quot;&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &lt;noreturn&gt;true&lt;/noreturn&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;/function&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;define name=3D&quot;HAVE_CONFIG_H&quot; val=
ue=3D&quot;1&quot; /&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  &lt;define name=3D&quot;CONFIGURE_SPECIAL_BUILD&quot; value=3D&quot;=
foo&quot; /&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;!-- work around macro confusion --&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;define name=3D&quot;CMSG_FIRSTHDR&quot; value=3D=
&quot;cmsg_firsthdr&quot; /&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;define name=3D&quot;CMSG_NXTHDR&quot; value=3D&quot;cmsg_=
nxthdr&quot; /&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&=
lt;/def&gt;</span><br><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-=
tools/run-cppcheck=2Esh</span><br><span>index 674fc092=2E=2E40db33e 100755<=
/span><br><span>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev=
-tools/run-cppcheck=2Esh</span><br><span>@@ -7,20 +7,37 @@</span><br><span>=
 : ${BUILD_DIR:=3D$PWD}</span><br><span> : ${INCLUDE_FLAGS:=3D}</span><br><=
span> CPPCHECK_DIR=3D&quot;${BUILD_DIR}/cppcheck_build_dir&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+COMMON_ARGS=3D&quot;-j$(nproc)=
 -q \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ -DMBEDTLS_SSL=
_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ -I=2E/include/ -I=2E/tests/unit_tests/op=
envpn/ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ -I=2E/src/=
compat/ -I=2E/src/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pa=
m/ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ -I${BUILD_DIR}=
 -I${BUILD_DIR}/include/ \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ --enable=3Dall \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ --library=3D${SCRIPT_DIR}/openvpn-cppcheck-library=2Ecfg \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ --library=3Dopenssl=2Ecfg \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ --suppressions-list=
=3D${SCRIPT_DIR}/cppcheck-suppression \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ --cppcheck-build-dir=3D${CPPCHECK_DIR} \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ --check-level=3Dexhaustive --max=
-configs=3D10 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ --e=
rror-exitcode=3D1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> </span><br><span> set -x</span><br><span> </span><br>=
<span> mkdir -p &quot;$CPPCHECK_DIR&quot;</span><br><span> cd &quot;${SOURC=
E_DIR}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cppcheck =
-j$(nproc) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 -DHAVE_=
CONFIG_H -U_WIN32 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	 -I=2E/include/ -I=2E/t=
ests/unit_tests/openvpn/ \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	 -I=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/src/openvpnserv/ -I=2E/sr=
c/plugins/auth-pam/ \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	 -I&quot;${BUILD_DIR}&quot; -I&quot;${BUILD_DIR}/include/&quot; $INCLUDE_F=
LAGS \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 --enable=3Dal=
l \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 --suppressions-l=
ist=3D&quot;${SCRIPT_DIR}/cppcheck-suppression&quot; \</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	 --cppcheck-build-dir=3D&quot;${CPPCHECK_=
DIR}&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 --check=
-level=3Dexhaustive \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	 --error-exitcode=3D1 \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	 src/ tests/ sample/</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+cppcheck $COMMON_ARGS $INCLUDE_FLAGS \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         --platform=3Dunix64 \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         --library=3Dposix=2Ecfg --libra=
ry=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         -U_WIN32 \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         src/openvpn/ src/compat/ src/plugins/ sample/ \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         tests/unit=
_tests/example_test/ tests/unit_tests/openvpn/ \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         tests/unit_tests/plugins/</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+cppcheck $COMMON_ARGS \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         --platform=3Dwin64=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         --librar=
y=3Dwindows=2Ecfg \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         -D_WIN32 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         -UTARGET_D=
ARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         -UTARGET_AIX \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         src/openvpn* src/comp=
at/ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         tests=
/unit_tests/example_test/ tests/unit_tests/openvpn*</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1665?usp=3Demail">change 1665</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1665?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I05720ccc3bcf706bbe62254afb74562580f5de56=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1665 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bod=
y></html>
--ZZTQJFX1skQ=--


--===============7717978975439540813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7717978975439540813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7717978975439540813==--

