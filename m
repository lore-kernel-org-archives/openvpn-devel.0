Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AE8C5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jUwFJCLZUfLuIInT54altk0S4D/0/hwxbsosMrGtfKs=; b=PxiZCPVl7kMqqRzatBC/wIv7uJ
	RfXhbnn5/ltOi4iEFBxSaEMZXP3tHqSPisoDK8K15E0JjIqbZRaUdMzIr1THDoDERxrVCWjWX0BD3
	r31666fiP5ImjCZpdznRIcOL+Zy9DV6Z35gaSFiwY7OtVPxBDPAGyyGxE6/3HnQ4dI5c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz79o-0007H0-SC;
	Wed, 26 Aug 2026 06:30:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz79n-0007Gs-6K
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:30:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vM+FKWlCGjdLHN+uoB31ziQheLE14WQa5QtKXng5Khc=; b=GE+9z0+jOWJEk2mgI3Rz74GGOh
 /EBg3rU+989YMOChc51TAXg5uMnVubZAABuNigpz3PzsFd9K/KJG7t0udeOwxOLjstmIbd2UASX58
 aWENxfbz531/AZf/ul1pJFjpsU90x2FS9i92WRHXlPgpw18FwOCH425st+3jjfkPW4Ko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vM+FKWlCGjdLHN+uoB31ziQheLE14WQa5QtKXng5Khc=; b=R
 DdzC+r1DAGdfPl6FIuHiE5xvruwtDAd2PqYY6V6ie4V1OzVBI5XEidB44Z6b+Ws4z9dZkHSxiR1sM
 42swgKfdHPZk7v8cvlg/6Z4Z9NCjrDCz1jxDiFtGQ211NkEKu3mKSio0p3E8/wWVamoiKzLDfrUho
 ptFpFMwG6gkuAwv8=;
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz79j-0007BG-Ps for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:30:43 +0000
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso65367566b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 23:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787725833; x=1788330633; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vM+FKWlCGjdLHN+uoB31ziQheLE14WQa5QtKXng5Khc=;
 b=Sx5/5zO3dJHLYjO4IE3xUMRRb3Fn1S9vuk4DPt68FenUcW5evyYNAvoJ7J8TXD5o+Z
 wfeJ1pwIbjMlEZAYLOK+OdT9RFZhC780/zblwPhC3F1b9xnu26zOlhTDNEcv2XXaIDXi
 g60CAFpKxVlY6TAsWHfR7uuy03mhTJu1OkdfL7e+5bGmt1b9NbCrLv0cqI8RmZY32kQC
 NuzjqDMGFOmVAhGsXL3VpePJdTVRB4XZdK7xhVKwIL8VGYBURNsTWbI/AVUfCFb3PL5Q
 cmqQnID6qC7VaGdHhpexaYZoyrC9POtFz3e2psfmSXvwCSUjkh1ftGub+GuyoWpZ9FD4
 shKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787725833; x=1788330633;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vM+FKWlCGjdLHN+uoB31ziQheLE14WQa5QtKXng5Khc=;
 b=ckXCuWfcOJ0mK2S7ESthJTmtLomyTdI69QGw9dJf+r3ut4OEyFzoFTYRKi7Ha279x7
 /K1zXn3Gu+WMejzoWDvq7nZJyIT1YWcXbMCy52GTbi5OAAg/T7D3H0mcjrSanIQ1xeNg
 BOtGqqNOGcsx7XKpfEPnGB5IH4PvINkvNx8a79upQ006DWtA8Pcsu/9Uam4oQggzKxKd
 IZngBYi7pRDrmUbLwRSY8wBeKAz8sYNsqENdWNun808L+AvhPaXJwKIGTTD9QNQ4HqS7
 XiwyQTA5HG505GFxszJJJumhSo6XtIEdp9InZLUCKmaBy1iCuKVezCORezPKimbUdn7Z
 ryCA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSh7RlR3x4ORkjjHJr6ExioGLOF4zmnjJNrsHKrSHoenzmzKUDbYrYKNG5VckgKtfB98oJwu6E/sfmtLyA@lists.sourceforge.net
X-Gm-Message-State: AFuF++k8xE+XKOen+uhZRnYzZeMsTiLHEURNlL9367QxysuBlCeTZhgK
 JSWwWKXi3MEkQAm5Xij2AfZR3G75BCk8Wr9R5cnh71Aa9tfOywsB4+s4x5f6fcomWljIZxi6d9k
 DtN6Pl3zQhxkdL3RjMSmQkmQMcy8xos7FLxIqpAj6VoziZ7nUqx6r3zGHG4I57skwZVW6
X-Gm-Gg: AR+sD11MD8MUJIs2utD/ntf9+WCH8IUs4Ft0+35M/HB6Y9KcGlMJw1K5YHTVp3OKLWA
 bqSroBQhjo4J331B2lTgYqBtqYAnohpQeV027Deea5exFBuAFFMYXtKEZ7UBfZJ9YTXSHWJttha
 F4Xb4qNqaM2W42H6lSPzWv2OmTHHHoE0Vu8mSwtV9Lejn3hxjgEzUmGUf1SdpSTQog8lunKhCeM
 DwepYmvbierrjM+KATl/pzvUsFURQtlIYXGkKIWvF0o0u2G30/JvLFermC7W5yNkiniWMPKC8b2
 x4Y4taET1UZ0df1IpwT61w1wo5zZZaKNdXI6AY26cxFJ8xWogi/C2V0RaOhCCt/7bj7BKzvCsqN
 tSYgoX6N7aoN4SUAvSR7tGF3sq4Lz5ydeCevF0YRV/2eE/wyE7DifNXF6phsn0ZfBbndVwf0tXs
 eyLI+px8uPQsbKtCap350MOd9s7l8BklU7EQ1rksCd+VQk16X/R9sIzoV7T2Old9aNb8EQZIfI9
 semgpDyXsChgAfQGopHFi0v2nHJpjHtmoQDCPiGg8RZ4XvkYlN6KS5pAOqyRignnGIFei/glmpv
 n+TQdWlgAXTihJnQ0NKLkn3RduzCquwxRRG142CTdsjmHdohgUg=
X-Received: by 2002:a17:907:72c6:b0:c21:34a3:4df9 with SMTP id
 a640c23a62f3a-c250bb58ab3mr503575266b.3.1787725832890; 
 Tue, 25 Aug 2026 23:30:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5e0701sm336295066b.12.2026.08.25.23.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 23:30:32 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 06:30:31 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id56fbfa4767346995eaa05ac95c7a20fbba99b2d
X-Gerrit-Change-Number: 1869
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1869?usp=email>
X-Gerrit-Commit: 172b15c2cf526c2c901739ab5f1f4271b27adbe6
In-Reply-To: <gerrit.1787672720000.Id56fbfa4767346995eaa05ac95c7a20fbba99b2d@gerrit.openvpn.net>
References: <gerrit.1787672720000.Id56fbfa4767346995eaa05ac95c7a20fbba99b2d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLklkNTZmYmZhNDc2NzM0Njk5NWVhYTA1YWM5NWM3YTIwZmJiYTk5YjJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ed6f7811fc08a621400142b35af6243fef689148-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz79j-0007BG-Ps
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1943875184802931719=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1943875184802931719==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/rx1dU/kkQg="; charset=UTF-8

--/rx1dU/kkQg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1869?usp=3Demail )

Change subject: Make cppcheck run pass on top of cu=
rrent master
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Make cppcheck run pass on top of current master

* Update cppcheck-suppre=
ssions to be in sync with
  current code
* Suppress some additional finding=
s that we have
  patches for in the queue but which are not merged,
  yet
*=
 Add some additional fixes for categories we had
  fixed but for which new =
occurences crept in

The goal is to have one commit that allows us to
enabl=
e a cppcheck run in buildbot to keep it
up to date going forward=2E

Change=
-Id: Id56fbfa4767346995eaa05ac95c7a20fbba99b2d
Signed-off-by: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1869
Message-=
Id: <20260825154932=2E4586-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Ema=
il-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38677=2Ehtml
Si=
gned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tools/cppchec=
k-suppression
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/=
multi_io=2Ec
M src/openvpn/openvpn=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M test=
s/unit_tests/openvpn/test_pkt=2Ec
7 files changed, 42 insertions(+), 23 del=
etions(-)




diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppch=
eck-suppression
index 900e03c=2E=2Ea585513 100644
--- a/dev-tools/cppcheck-=
suppression
+++ b/dev-tools/cppcheck-suppression
@@ -5,6 +5,10 @@
 constPar=
ameterPointer
 invalidPrintfArgType_sint
 invalidPrintfArgType_uint
+redund=
antAssignment
+redundantInitialization
+unreadVariable
+unusedFunction
 usl=
eepCalled
 variableScope
 # We have a lot of library includes, not all of t=
hem are really required,
@@ -24,15 +28,21 @@
 localtimeCalled
 strtokCalled=

 # FP: posix=2Ecfg claims suseconds_t is unsigned for some reason
-unsigne=
dLessThanZero:src/openvpn/otime=2Eh:235
+unsignedLessThanZero:src/openvpn/o=
time=2Eh:148
 # IGN: multi code does weird things with pointers to local va=
riables=2E=2E=2E
-autoVariables:src/openvpn/multi=2Ec:4177
-autoVariables:s=
rc/openvpn/multi_io=2Ec:280
+autoVariables:src/openvpn/multi=2Ec:4232
+auto=
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
+# IGN: Windows specific (unsigned long =3D=3D unsigned int)
+compareV=
alueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928
+# FP: cppcheck seem=
s to have wrong signature of DeviceIoControl()
+constVariablePointer:src/op=
envpn/dco_win=2Ec
+# IGN: test_networking code would break with iproute2 bu=
t that is prevented
+ctunullpointer:src/openvpn/networking_iproute2=2Ec
 # =
IGN: event code uses a pointer to store integers
 intToPointerCast:src/open=
vpn/forward=2Ec
 intToPointerCast:src/openvpn/multi_io=2Ec
@@ -40,7 +50,7 @=
@
 # FP: constant but differs between platforms
 knownConditionTrueFalse:sr=
c/openvpn/error=2Eh:380
 knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:80
=
-knownConditionTrueFalse:src/openvpn/lladdr=2Ec:65
+knownConditionTrueFalse=
:src/openvpn/lladdr=2Ec:64
 knownConditionTrueFalse:src/openvpn/platform=2E=
c
 # FP: code needs to accomodate many different defines
 knownConditionTru=
eFalse:src/openvpn/event=2Ec:1139
@@ -48,13 +58,13 @@
 # FP: dco_win suppor=
t has "false" stubs
 knownConditionTrueFalse:src/openvpn/forward=2Ec
 known=
ConditionTrueFalse:src/openvpn/init=2Ec
-knownConditionTrueFalse:src/openvp=
n/multi_io=2Ec:163
+knownConditionTrueFalse:src/openvpn/multi_io=2Ec:197
 #=
 FP: cppcheck thinks that some functions always return true, but they don't=

 knownConditionTrueFalse:src/openvpn/misc=2Ec:97
 knownConditionTrueFalse:=
src/openvpn/sig=2Eh:116
 # FP: cert_uri_supported is a wrapper around defin=
es, so it's
 # always constant but differs depending on OpenSSL version
-kn=
ownConditionTrueFalse:src/openvpn/ssl_openssl=2Ec:1332
+knownConditionTrueF=
alse:src/openvpn/ssl_openssl=2Ec:1260
 # FP: cppcheck doesn't understand th=
at the function changes szErrMessage
 knownConditionTrueFalse:src/tapctl/ma=
in=2Ec:704
 knownConditionTrueFalse:src/openvpnmsica/dllmain=2Ec:164
@@ -65=
,12 +75,18 @@
 # FP: eventmsg=2Eh is not built on Unix
 missingInclude:src/=
openvpnserv/common=2Ec:25
 # IGN: strlen(NULL) is not nice code, but seems =
to work
-nullPointerRedundantCheck:src/openvpn/init=2Ec:299
+nullPointerRed=
undantCheck:src/openvpn/init=2Ec:301
 # FP: cppcheck doesn't understand Zer=
oMemory
 redundantAssignment:src/openvpnserv/interactive=2Ec:203
+# FP: cpp=
check doesn't know the NLA macros
+redundantInitialization:src/openvpn/dco_=
linux=2Ec
 # IGN: We reuse the same variable name due to macro usage
-shado=
wVariable:src/openvpn/options=2Ec:2580
-shadowVariable:src/openvpn/options=
=2Ec:2598
+shadowVariable:src/openvpn/options=2Ec:1948
+shadowVariable:src/=
openvpn/options=2Ec:1966
+# IGN: sure this is theoretically undefined, but =
works
+shiftNegativeLHS:tests/unit_tests/openvpn/test_schedule=2Ec:183
+# F=
P: fun:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is confused
+syntaxError:=
tests/unit_tests/openvpn/test_tls_crypt=2Ec:684
 # FP: this file is never c=
ompiled on _WIN32
 umaskCalled:tests/unit_tests/openvpn/test_pkcs11=2Ec
 # =
FP: yes, t_prev is unitialized, but t_prev_len is 0, so that's handled
@@ -=
78,13 +94,13 @@
 # FP: yes, parm is unitialized, but parm_len is 0, so that=
's handled
 uninitvar:src/openvpn/options_parse=2Ec:148
 # FP: uninit is fi=
ne when it is a return parameter
-ctuuninitvar:src/openvpn/crypto_mbedtls_l=
egacy=2Ec:698
-uninitvar:src/openvpnserv/interactive=2Ec:1935
+ctuuninitvar=
:src/openvpn/crypto_mbedtls_legacy=2Ec:690
+uninitvar:src/openvpnserv/inter=
active=2Ec:2775
 uninitvar:src/tapctl/main=2Ec:566
 # FP: we added a check =
but cppcheck is not convinced
 uninitvar:src/openvpnserv/interactive=2Ec:26=
67
 # FP: weird parse error, the macro is fine in the rest of the file
-unk=
nownMacro:src/openvpnserv/interactive=2Ec:3488
+unknownMacro:src/openvpnser=
v/interactive=2Ec:3596
 # FP: cppcheck doesn't account for short-circuiting=

 unreadVariable:src/openvpn/manage=2Ec:682
 unusedFunction:src/openvpn/sip=
hash_reference=2Ec
@@ -101,8 +117,10 @@
 # FP: doesn't account for --wrap
 =
unusedFunction:tests/unit_tests/openvpn/test_tls_crypt=2Ec
 unusedFunction:=
/usr/include/*
+# FP: cppcheck doesn't know the NLA macros
+unusedLabel:src=
/openvpn/dco_linux=2Ec
 # IGN: old code that is difficult to test (MSG_ERRQ=
UEUE), ignore for now
-unusedStructMember:src/openvpn/mtu=2Ec:281
+unusedSt=
ructMember:src/openvpn/mtu=2Ec:289
 # FP: used implictly by NL macros
 unus=
edStructMember:src/openvpn/networking_sitnl=2Ec
 # IGN: keep explanatory fi=
elds in test data
@@ -111,3 +129,5 @@
 variableScope:src/openvpn/networking=
_sitnl=2Ec:1390
 # IGN: nicer to keep the "variable" earlier
 variableScope=
:src/openvpnserv/interactive=2Ec:2687
+# FP: fun:platform_create_temp_file:=
 cppcheck is confused
+wrongPrintfScanfArgNum:src/openvpn/platform=2Ec:553
=
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 6d9c181=2E=
=2Ede3d467 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ =
-324,7 +324,7 @@
 {
     struct multi_instance *mi =3D NULL;
 
-    uint8_t=
 *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+    const uint8_t *ptr =3D BPTR(&m->to=
p=2Ec2=2Ebuf);
     uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
     bool v2 =
=3D (op =3D=3D P_DATA_V2) && (m->top=2Ec2=2Ebuf=2Elen >=3D (1 + 3));
     b=
ool peer_id_disabled =3D false;
@@ -376,7 +376,7 @@
         return NULL;
 =
    }
 
-    uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+    const uint8_t =
*ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
     uint8_t op =3D ptr[0] >> P_OPCODE_S=
HIFT;
 
     struct mroute_addr real =3D { 0 };
diff --git a/src/openvpn/mu=
lti=2Ec b/src/openvpn/multi=2Ec
index 60a5148=2E=2E74939bf 100644
--- a/src=
/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3095,8 +3095,8 @@
 
    =
 struct multi_instance *ex_mi =3D he->value;
 
-    struct tls_multi *m1 =
=3D mi->context=2Ec2=2Etls_multi;
-    struct tls_multi *m2 =3D ex_mi->cont=
ext=2Ec2=2Etls_multi;
+    const struct tls_multi *m1 =3D mi->context=2Ec2=
=2Etls_multi;
+    const struct tls_multi *m2 =3D ex_mi->context=2Ec2=2Etls=
_multi;
 
     struct gc_arena gc =3D gc_new();
     int ret =3D false;
dif=
f --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index d8cc708=
=2E=2E3604684 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi=
_io=2Ec
@@ -191,12 +191,12 @@
 int
 multi_io_wait(struct multi_context *m)
=
 {
-    int status, i;
+    int status;
     unsigned int *persistent =3D &=
m->multi_io->tun_rwflags;
 
     if (!tuntap_is_dco_win(m->top=2Ec1=2Etunta=
p))
     {
-        for (i =3D 0; i < m->top=2Ec1=2Elink_sockets_num; i++)
=
+        for (int i =3D 0; i < m->top=2Ec1=2Elink_sockets_num; i++)
       =
  {
             socket_set_listen_persistent(m->top=2Ec2=2Elink_sockets[i]=
, m->multi_io->es,
                                          &m->top=2Ec2=
=2Elink_sockets[i]->ev_arg);
diff --git a/src/openvpn/openvpn=2Ec b/src/ope=
nvpn/openvpn=2Ec
index 7d35195=2E=2E24d6bb6 100644
--- a/src/openvpn/openvp=
n=2Ec
+++ b/src/openvpn/openvpn=2Ec
@@ -32,7 +32,6 @@
 #include "win32=2Eh"=

 #include "options_show=2Eh"
 #include "platform=2Eh"
-#include "string=2E=
h"
 
 #include "memdbg=2Eh"
 
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/sr=
c/openvpn/ssl_mbedtls=2Ec
index faf5a27=2E=2Ec92c423 100644
--- a/src/openv=
pn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -286,7 +286,7 @@
 v=
oid
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers=
)
 {
-    char *tmp_ciphers, *tmp_ciphers_orig, *token;
+    char *tmp_ciph=
ers, *tmp_ciphers_orig;
 
     if (NULL =3D=3D ciphers)
     {
@@ -306,7 +3=
06,7 @@
     char *lasts =3D NULL;
     tmp_ciphers_orig =3D tmp_ciphers =
=3D string_alloc(ciphers, NULL);
 
-    token =3D strtok_r(tmp_ciphers, ":"=
, &lasts);
+    const char *token =3D strtok_r(tmp_ciphers, ":", &lasts);
 =
    while (token)
     {
         ctx->allowed_ciphers[i] =3D mbedtls_ssl_g=
et_ciphersuite_id(tls_translate_cipher_name(token));
diff --git a/tests/uni=
t_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index =
5ec6781=2E=2Ea732c2b 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++=
 b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -562,7 +562,7 @@
 static void
 =
test_calc_session_id_hmac_static(void **ut_state)
 {
-    uint8_t key[SIPHA=
SH_KEY_SIZE] =3D { 1, 2, 3, 0 };
+    const uint8_t key[SIPHASH_KEY_SIZE] =
=3D { 1, 2, 3, 0 };
     static const int handwindow =3D 100;
 
     struct=
 openvpn_sockaddr addr =3D { 0 };

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1869?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: Id56fbfa4767346995eaa05ac95c7a20fbba99b2d
Gerrit-Change-Number:=
 1869
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--/rx1dU/kkQg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1869?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Make cppcheck run pass on top of current m=
aster<br><br>* Update cppcheck-suppressions to be in sync with<br>  current=
 code<br>* Suppress some additional findings that we have<br>  patches for =
in the queue but which are not merged,<br>  yet<br>* Add some additional fi=
xes for categories we had<br>  fixed but for which new occurences crept in<=
br><br>The goal is to have one commit that allows us to<br>enable a cppchec=
k run in buildbot to keep it<br>up to date going forward=2E<br><br>Change-I=
d: Id56fbfa4767346995eaa05ac95c7a20fbba99b2d<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1869<br>Message-Id: &lt;20260825154932=2E4586-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg38677=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cppcheck-suppression<br>M src/openvpn=
/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<br>M src=
/openvpn/openvpn=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M tests/unit_tests=
/openvpn/test_pkt=2Ec<br>7 files changed, 42 insertions(+), 23 deletions(-)=
<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/dev-tools/c=
ppcheck-suppression</span><br><span>index 900e03c=2E=2Ea585513 100644</span=
><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b/dev-t=
ools/cppcheck-suppression</span><br><span>@@ -5,6 +5,10 @@</span><br><span>=
 constParameterPointer</span><br><span> invalidPrintfArgType_sint</span><br=
><span> invalidPrintfArgType_uint</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+redundantAssignment</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+redundantInitialization</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+unreadVariable</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+unusedFunction</span><br><span> usleepCalled</span><br><span> =
variableScope</span><br><span> # We have a lot of library includes, not all=
 of them are really required,</span><br><span>@@ -24,15 +28,21 @@</span><br=
><span> localtimeCalled</span><br><span> strtokCalled</span><br><span> # FP=
: posix=2Ecfg claims suseconds_t is unsigned for some reason</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-unsignedLessThanZero:src/openvpn/oti=
me=2Eh:235</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsignedL=
essThanZero:src/openvpn/otime=2Eh:148</span><br><span> # IGN: multi code do=
es weird things with pointers to local variables=2E=2E=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-autoVariables:src/openvpn/multi=2Ec:417=
7</span><br><span style=3D"color: hsl(0, 100%, 40%);">-autoVariables:src/op=
envpn/multi_io=2Ec:280</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+autoVariables:src/openvpn/multi=2Ec:4232</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+autoVariables:src/openvpn/multi_io=2Ec:324</span><b=
r><span> # IGN: the code header =3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is=
 used intentionally</span><br><span> badBitmaskCheck:src/openvpn/mudp=2Ec</=
span><br><span> badBitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec</span=
><br><span> # IGN: we store integers in pointers</span><br><span> CastAddre=
ssToIntegerAtReturn:src/openvpn/multi=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# IGN: Windows specific (unsigned long =3D=3D unsigne=
d int)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+compareValueO=
utOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# FP: cppcheck seems to have wrong signature =
of DeviceIoControl()</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+constVariablePointer:src/openvpn/dco_win=2Ec</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# IGN: test_networking code would break with ipro=
ute2 but that is prevented</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ctunullpointer:src/openvpn/networking_iproute2=2Ec</span><br><span> =
# IGN: event code uses a pointer to store integers</span><br><span> intToPo=
interCast:src/openvpn/forward=2Ec</span><br><span> intToPointerCast:src/ope=
nvpn/multi_io=2Ec</span><br><span>@@ -40,7 +50,7 @@</span><br><span> # FP: =
constant but differs between platforms</span><br><span> knownConditionTrueF=
alse:src/openvpn/error=2Eh:380</span><br><span> knownConditionTrueFalse:src=
/openvpn/fdmisc=2Ec:80</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-knownConditionTrueFalse:src/openvpn/lladdr=2Ec:65</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/lladdr=
=2Ec:64</span><br><span> knownConditionTrueFalse:src/openvpn/platform=2Ec</=
span><br><span> # FP: code needs to accomodate many different defines</span=
><br><span> knownConditionTrueFalse:src/openvpn/event=2Ec:1139</span><br><s=
pan>@@ -48,13 +58,13 @@</span><br><span> # FP: dco_win support has &quot;fa=
lse&quot; stubs</span><br><span> knownConditionTrueFalse:src/openvpn/forwar=
d=2Ec</span><br><span> knownConditionTrueFalse:src/openvpn/init=2Ec</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/o=
penvpn/multi_io=2Ec:163</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+knownConditionTrueFalse:src/openvpn/multi_io=2Ec:197</span><br><span> #=
 FP: cppcheck thinks that some functions always return true, but they don&#=
39;t</span><br><span> knownConditionTrueFalse:src/openvpn/misc=2Ec:97</span=
><br><span> knownConditionTrueFalse:src/openvpn/sig=2Eh:116</span><br><span=
> # FP: cert_uri_supported is a wrapper around defines, so it&#39;s</span><=
br><span> # always constant but differs depending on OpenSSL version</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/=
openvpn/ssl_openssl=2Ec:1332</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+knownConditionTrueFalse:src/openvpn/ssl_openssl=2Ec:1260</span><br=
><span> # FP: cppcheck doesn&#39;t understand that the function changes szE=
rrMessage</span><br><span> knownConditionTrueFalse:src/tapctl/main=2Ec:704<=
/span><br><span> knownConditionTrueFalse:src/openvpnmsica/dllmain=2Ec:164</=
span><br><span>@@ -65,12 +75,18 @@</span><br><span> # FP: eventmsg=2Eh is n=
ot built on Unix</span><br><span> missingInclude:src/openvpnserv/common=2Ec=
:25</span><br><span> # IGN: strlen(NULL) is not nice code, but seems to wor=
k</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nullPointerRedundant=
Check:src/openvpn/init=2Ec:299</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+nullPointerRedundantCheck:src/openvpn/init=2Ec:301</span><br><sp=
an> # FP: cppcheck doesn&#39;t understand ZeroMemory</span><br><span> redun=
dantAssignment:src/openvpnserv/interactive=2Ec:203</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# FP: cppcheck doesn&#39;t know the NLA macr=
os</span><br><span style=3D"color: hsl(120, 100%, 40%);">+redundantInitiali=
zation:src/openvpn/dco_linux=2Ec</span><br><span> # IGN: We reuse the same =
variable name due to macro usage</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-shadowVariable:src/openvpn/options=2Ec:2580</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-shadowVariable:src/openvpn/options=2Ec:259=
8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+shadowVariable:src=
/openvpn/options=2Ec:1948</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+shadowVariable:src/openvpn/options=2Ec:1966</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# IGN: sure this is theoretically undefined, =
but works</span><br><span style=3D"color: hsl(120, 100%, 40%);">+shiftNegat=
iveLHS:tests/unit_tests/openvpn/test_schedule=2Ec:183</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# FP: fun:tls_crypt_v2_wrap_unwrap_invali=
d: cppcheck is confused</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+syntaxError:tests/unit_tests/openvpn/test_tls_crypt=2Ec:684</span><br><=
span> # FP: this file is never compiled on _WIN32</span><br><span> umaskCal=
led:tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span> # FP: yes, t_=
prev is unitialized, but t_prev_len is 0, so that&#39;s handled</span><br><=
span>@@ -78,13 +94,13 @@</span><br><span> # FP: yes, parm is unitialized, b=
ut parm_len is 0, so that&#39;s handled</span><br><span> uninitvar:src/open=
vpn/options_parse=2Ec:148</span><br><span> # FP: uninit is fine when it is =
a return parameter</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ctu=
uninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:698</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-uninitvar:src/openvpnserv/interactive=2Ec:1=
935</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctuuninitvar:src=
/openvpn/crypto_mbedtls_legacy=2Ec:690</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+uninitvar:src/openvpnserv/interactive=2Ec:2775</span><br=
><span> uninitvar:src/tapctl/main=2Ec:566</span><br><span> # FP: we added a=
 check but cppcheck is not convinced</span><br><span> uninitvar:src/openvpn=
serv/interactive=2Ec:2667</span><br><span> # FP: weird parse error, the mac=
ro is fine in the rest of the file</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-unknownMacro:src/openvpnserv/interactive=2Ec:3488</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+unknownMacro:src/openvpnserv/int=
eractive=2Ec:3596</span><br><span> # FP: cppcheck doesn&#39;t account for s=
hort-circuiting</span><br><span> unreadVariable:src/openvpn/manage=2Ec:682<=
/span><br><span> unusedFunction:src/openvpn/siphash_reference=2Ec</span><br=
><span>@@ -101,8 +117,10 @@</span><br><span> # FP: doesn&#39;t account for =
--wrap</span><br><span> unusedFunction:tests/unit_tests/openvpn/test_tls_cr=
ypt=2Ec</span><br><span> unusedFunction:/usr/include/*</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# FP: cppcheck doesn&#39;t know the NLA =
macros</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unusedLabel:s=
rc/openvpn/dco_linux=2Ec</span><br><span> # IGN: old code that is difficult=
 to test (MSG_ERRQUEUE), ignore for now</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-unusedStructMember:src/openvpn/mtu=2Ec:281</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+unusedStructMember:src/openvpn/mtu=
=2Ec:289</span><br><span> # FP: used implictly by NL macros</span><br><span=
> unusedStructMember:src/openvpn/networking_sitnl=2Ec</span><br><span> # IG=
N: keep explanatory fields in test data</span><br><span>@@ -111,3 +129,5 @@=
</span><br><span> variableScope:src/openvpn/networking_sitnl=2Ec:1390</span=
><br><span> # IGN: nicer to keep the &quot;variable&quot; earlier</span><br=
><span> variableScope:src/openvpnserv/interactive=2Ec:2687</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# FP: fun:platform_create_temp_file:=
 cppcheck is confused</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+wrongPrintfScanfArgNum:src/openvpn/platform=2Ec:553</span><br><span>diff =
--git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 6=
d9c181=2E=2Ede3d467 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span=
><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -324,7 +324,7 @@</=
span><br><span> {</span><br><span>     struct multi_instance *mi =3D NULL;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const uint8_t *ptr =3D BPTR(&amp;m-&gt;to=
p=2Ec2=2Ebuf);</span><br><span>     uint8_t op =3D ptr[0] &gt;&gt; P_OPCODE=
_SHIFT;</span><br><span>     bool v2 =3D (op =3D=3D P_DATA_V2) &amp;&amp; (=
m-&gt;top=2Ec2=2Ebuf=2Elen &gt;=3D (1 + 3));</span><br><span>     bool peer=
_id_disabled =3D false;</span><br><span>@@ -376,7 +376,7 @@</span><br><span=
>         return NULL;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *ptr =3D BPTR(&amp;m-=
&gt;top=2Ec2=2Ebuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><spa=
n>     uint8_t op =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span> </sp=
an><br><span>     struct mroute_addr real =3D { 0 };</span><br><span>diff -=
-git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index =
60a5148=2E=2E74939bf 100644</span><br><span>--- a/src/openvpn/multi=2Ec</sp=
an><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3095,8 +3095,8=
 @@</span><br><span> </span><br><span>     struct multi_instance *ex_mi =3D=
 he-&gt;value;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct tls_multi *m1 =3D mi-&gt;context=2Ec2=2Etls_multi;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_multi *m2=
 =3D ex_mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const struct tls_multi *m1 =3D mi-&gt;context=2Ec2=
=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct tls_multi *m2 =3D ex_mi-&gt;context=2Ec2=2Etls_multi;</span><br>=
<span> </span><br><span>     struct gc_arena gc =3D gc_new();</span><br><sp=
an>     int ret =3D false;</span><br><span>diff --git a/src/openvpn/multi_i=
o=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index d8cc708=2E=2E3604684=
 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ =
b/src/openvpn/multi_io=2Ec</span><br><span>@@ -191,12 +191,12 @@</span><br>=
<span> int</span><br><span> multi_io_wait(struct multi_context *m)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int sta=
tus, i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int stat=
us;</span><br><span>     unsigned int *persistent =3D &amp;m-&gt;multi_io-&=
gt;tun_rwflags;</span><br><span> </span><br><span>     if (!tuntap_is_dco_w=
in(m-&gt;top=2Ec1=2Etuntap))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; m-&gt;top=2Ec1=
=2Elink_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        for (int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i=
++)</span><br><span>         {</span><br><span>             socket_set_list=
en_persistent(m-&gt;top=2Ec2=2Elink_sockets[i], m-&gt;multi_io-&gt;es,</spa=
n><br><span>                                          &amp;m-&gt;top=2Ec2=
=2Elink_sockets[i]-&gt;ev_arg);</span><br><span>diff --git a/src/openvpn/op=
envpn=2Ec b/src/openvpn/openvpn=2Ec</span><br><span>index 7d35195=2E=2E24d6=
bb6 100644</span><br><span>--- a/src/openvpn/openvpn=2Ec</span><br><span>++=
+ b/src/openvpn/openvpn=2Ec</span><br><span>@@ -32,7 +32,6 @@</span><br><sp=
an> #include &quot;win32=2Eh&quot;</span><br><span> #include &quot;options_=
show=2Eh&quot;</span><br><span> #include &quot;platform=2Eh&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;string=2Eh&quot;=
</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><=
br><span> </span><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/o=
penvpn/ssl_mbedtls=2Ec</span><br><span>index faf5a27=2E=2Ec92c423 100644</s=
pan><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/o=
penvpn/ssl_mbedtls=2Ec</span><br><span>@@ -286,7 +286,7 @@</span><br><span>=
 void</span><br><span> tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, c=
onst char *ciphers)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    char *tmp_ciphers, *tmp_ciphers_orig, *token;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_ciphers, *tmp_=
ciphers_orig;</span><br><span> </span><br><span>     if (NULL =3D=3D cipher=
s)</span><br><span>     {</span><br><span>@@ -306,7 +306,7 @@</span><br><sp=
an>     char *lasts =3D NULL;</span><br><span>     tmp_ciphers_orig =3D tmp=
_ciphers =3D string_alloc(ciphers, NULL);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    token =3D strtok_r(tmp_ciphers, &=
quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *token =3D strtok_r(tmp_ciphers, &quot;:&quot;, &amp;=
lasts);</span><br><span>     while (token)</span><br><span>     {</span><br=
><span>         ctx-&gt;allowed_ciphers[i] =3D mbedtls_ssl_get_ciphersuite_=
id(tls_translate_cipher_name(token));</span><br><span>diff --git a/tests/un=
it_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span=
><br><span>index 5ec6781=2E=2Ea732c2b 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_pkt=2Ec</span><br><span>@@ -562,7 +562,7 @@</span><br><span> static =
void</span><br><span> test_calc_session_id_hmac_static(void **ut_state)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ui=
nt8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const uint8_t key[SIPHASH_KEY_SIZE] =3D { 1=
, 2, 3, 0 };</span><br><span>     static const int handwindow =3D 100;</spa=
n><br><span> </span><br><span>     struct openvpn_sockaddr addr =3D { 0 };<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3Demail">change 1869</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1869?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Id56fbfa4767346995eaa05=
ac95c7a20fbba99b2d </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1869 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@=
greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>

</body></html>
--/rx1dU/kkQg=--


--===============1943875184802931719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1943875184802931719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1943875184802931719==--

