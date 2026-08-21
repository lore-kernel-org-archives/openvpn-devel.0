Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A004FC5DF9B
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LUjMrifIa+Lf0k4gNbET6uBiDpN/AbcNqr+unpwTaDY=; b=mRY6l9O7BPBLikr4gjuJzNESy1
	YzMjwWDmPJIkCKfR4n5RFnl3wi24k/aCkHBLlFx/f5aubVezVUtdwl+BQ1Mqeh+jpnBcR2vG4HWuw
	1BaA6YVVRh1hVFeMm6EWaXYrd+FK0MATNLpnUYO4JqPUSP929CtyUINzo4pR0H4rmLp8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxWCa-0000wC-QV;
	Fri, 21 Aug 2026 20:50:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxWCY-0000vr-AY
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 20:50:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LL1ha9Vph0buWa4yoxLqHcattzoyQccv1RwcUEo9rxo=; b=KHjPMEfIUy92TmNIqVjhNOLNjb
 iibRxqvMEfYbtUlAAJqttGrvsk0XJUItg/GIhgHsyIyC+PXVCfIIpsGmW+lojkYOQtkmyJQFlVvEA
 ESh18SavEPCSAPuxnt6MDBYXYDUvzX21jCK786CVg4LD+ObwOz/f4YAtVKZTEFGny64A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LL1ha9Vph0buWa4yoxLqHcattzoyQccv1RwcUEo9rxo=; b=P
 yA6X9tc4z+90t5lCKo4ESEoZ5/C87Pu1twfc0pNw74/ESAlvZseCHhmPz1slQAX4NEdT925lxWziu
 PMvO5C2ilRb6JxsuVh9ROnzZoYJcC3LrYvAEKQ9g+b92tMGqlHJ2+8MMnl/SFxPV/7KrxtK/sWWWr
 Jzyan73bBRfIQSZ4=;
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxWCI-0005hg-7h for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 20:50:51 +0000
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c214321dc32so292486866b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787345436; x=1787950236; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LL1ha9Vph0buWa4yoxLqHcattzoyQccv1RwcUEo9rxo=;
 b=FxlDb9HtGIIcKIm2A2Mjts9oi7vcIXCGSmM1k7AE89VzMKQDYPMAxSAcsQBNncquaI
 jqQ7DY+iwd9NwaKZKElf/j7sansrNaKFuFX6VGF+RJhmXb1gGL/UhtvbYG213FCIBSGU
 PuBitjLDofQfFJTfeSxdItxeLZT2tJkWuvD/WX+f7BriOEqlFjVD7IgO5gGul6XXrbCJ
 uHcfAyHSyohY1otuhfLJ/JYUxcm55CX6nBc3fk2iUhkj8BQ8m02LVoy3GDsFHBCDbjzZ
 MYvLON8ajLBwQhZXuAIznnS9+9P3nalGB1Uqk48EJMfMaHwOsaX3jFBKTV2J9jTATyes
 l+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787345436; x=1787950236;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LL1ha9Vph0buWa4yoxLqHcattzoyQccv1RwcUEo9rxo=;
 b=A8zTvCweUZHKJci9/5shUEsk3eCIaiYmTaCDB8Dhy50OJHqgYk80zyHH5lapSZx2jr
 XqS+lHZL7k3E2fKuA75XTjMwM5X3eYbnsl0a2gN47ZHqUEZJV5xy0wZBrjoTF/2ePyW+
 NOyH3vcueFqUHiTfyddQ4Sl2ApnXxOsWU6au6XKMR4GUDrJ+Z4293a/JPhwSLHRWap93
 Hvp9Un+CBLOabEJjn2mAxvNI8h/cFgrp2LqR9gWypK+NKS5UABvtm2od3DBXmBq/NuY6
 uJ7cbfWPq7HAiVSC1FswEZwhswef6sZ9cPeaNKr8lCu8VTe593Ge5lLgbzh20be4yV/+
 c11A==
X-Gm-Message-State: AFuF++kuNxZWU2gNC+CK4zG7ILoFnBJwVG7vyod0qXY2i2GOvg9yR4ZC
 WTYfZorUrm2q+GboMktfGruiXnfgbYJxVWA7U/f1r9RMjASGkgNrF6Y6jZj/+tUHzQkjGuQiVEn
 mXQYSXKWIvDnEwwE6X6jxmGGA79JOkH0pC3ilzxoXIt8o+N46B37FzwClZPjcySbtkwu1UlA91A
 3MBE7Ehw==
X-Gm-Gg: AR+sD11ci9iODYbkPPeDkmHMTBTxxPciZBgK6y6zOYMLHCbAM/VQr2mCVEM7b1xl+Ls
 4WWwP0TXYF9BFXWgqxJVU/Rp9dfQME1686H3t7Odnhtn75FAwzOoajvkHYdnUEtJVg6hTEZ7gLl
 7y1TprnuluCvoczJcBO7BS1Si7Jvvyb+ytBNxeYhAQXQQ0xzg8g1k68dJ/tpn8poCzLavkUjHlZ
 Ga3MB+GF3kLLXWpHII/ep3khxu6QWC0BQxFeupuNQVw2B1sWCInpb9SgVrOfvo2OtwzIqtiKMF3
 0RVJnlsuCzt2oLdTyk1lTd/Hbk869Y4iBwxUVxrLiOH186Tpg7d1gC3a10Z7xKRo87wNGbYhovG
 MXvPGEYXbF6K98qTJRAu9Nr8igeKX8+r5NX23JA2qh9kHxAPxES6+7h0FzOvFbQxNogZwpCrVCv
 24B+ROIRGVLZoVJFuosm3BdbtCOzZ3EgiYBSIEmSE/fpN6//dhCflUIkcV32R/3j+ak/qHhfBa3
 33hZ4Xwkeo4JqrJS5o719LLmuQfBd0GYCOXnzWrKvp40QWGM1LuIIQGh1nsjVxR1YPGBMKK4HhO
 eSSHRV7pJIJZLd8J7/9kilqq1YHTqxJTyH0DIJD8JhPqwSxKhKIOunfoPhGaMg==
X-Received: by 2002:a17:906:9fd0:b0:c20:1db7:f486 with SMTP id
 a640c23a62f3a-c246a2ef579mr934043566b.4.1787345434635; 
 Fri, 21 Aug 2026 13:50:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b05dcfsm533126666b.14.2026.08.21.13.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 13:50:33 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 20:50:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: ac34a36059466dca3234c706b75e882c1f2bccd2
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <467c43b1f640b6476386a42b73a9d5d4fde3c6d6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxWCI-0005hg-7h
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6799222715797605930=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6799222715797605930==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zFqoLllrC68="; charset=UTF-8

--zFqoLllrC68=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1858?usp=3Demail )


Change subject: Implement sending/rece=
iving app custom control protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Implement sending/receiving app custom control proto=
col

Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M doc/man-sections/c=
lient-options=2Erst
M doc/management-notes=2Etxt
M src/openvpn/Makefile=2Ea=
m
A src/openvpn/acc=2Ec
A src/openvpn/acc=2Eh
M src/openvpn/forward=2Ec
M s=
rc/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src=
/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M sr=
c/openvpn/push=2Ec
M src/openvpn/push=2Eh
M src/openvpn/push_util=2Ec
A src=
/openvpn/push_util=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M=
 tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/mock_man=
agement=2Ec
A tests/unit_tests/openvpn/mock_management=2Eh
M tests/unit_tes=
ts/openvpn/mock_push_dependencies=2Ec
A tests/unit_tests/openvpn/test_acc=
=2Ec
A tests/unit_tests/openvpn/test_acc=2Eh
M tests/unit_tests/openvpn/tes=
t_misc=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
27 files changed, 1,318 =
insertions(+), 23 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/58/1858/2

diff --git a/CMakeLists=2Etxt b/CMakeLi=
sts=2Etxt
index 6eb5954=2E=2E8f52e44 100644
--- a/CMakeLists=2Etxt
+++ b/CM=
akeLists=2Etxt
@@ -424,6 +424,8 @@
     src/compat/compat-gettimeofday=2Ec
=
     src/compat/compat-strsep=2Ec
     src/compat/compat-strtok_r=2Ec
+    =
src/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
     src/openvpn/argv=2Ec
    =
 src/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -560,8 +562,9 @@
     =
src/openvpn/ps=2Ec
     src/openvpn/ps=2Eh
     src/openvpn/push=2Ec
-    s=
rc/openvpn/push_util=2Ec
     src/openvpn/push=2Eh
+    src/openvpn/push_ut=
il=2Ec
+    src/openvpn/push_util=2Eh
     src/openvpn/pushlist=2Eh
     sr=
c/openvpn/reflect_filter=2Ec
     src/openvpn/reflect_filter=2Eh
@@ -812,7 =
+815,10 @@
             tests/unit_tests/openvpn/mock_management=2Ec
      =
       tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
             test=
s/unit_tests/openvpn/mock_win32_execve=2Ec
+            tests/unit_tests/op=
envpn/test_acc=2Ec
+            src/openvpn/acc=2Ec
             src/openvp=
n/argv=2Ec
+            src/openvpn/auth_token=2Ec
             src/openvpn=
/base64=2Ec
             src/openvpn/crypto_epoch=2Ec
             src/open=
vpn/crypto_mbedtls=2Ec
@@ -826,8 +832,11 @@
             src/openvpn/option=
s_util=2Ec
             src/openvpn/otime=2Ec
             src/openvpn/pack=
et_id=2Ec
+            src/openvpn/reliable=2Ec
+            src/openvpn/se=
ssion_id=2Ec
             src/openvpn/run_command=2Ec
             src/open=
vpn/ssl_mbedtls=2Ec
+            src/openvpn/ssl_ncp=2Ec
             src/o=
penvpn/ssl_openssl=2Ec
             src/openvpn/ssl_util=2Ec
             s=
rc/openvpn/ssl_verify_mbedtls=2Ec
@@ -844,6 +853,8 @@
     target_sources(t=
est_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random=2Ec
    =
     tests/unit_tests/openvpn/test_schedule=2Ec
+        tests/unit_tests/o=
penvpn/mock_management=2Ec
+        src/openvpn/base64=2Ec
         src/ope=
nvpn/options_util=2Ec
         src/openvpn/otime=2Ec
         src/openvpn/s=
sl_util=2Ec
diff --git a/doc/man-sections/client-options=2Erst b/doc/man-se=
ctions/client-options=2Erst
index 87c138a=2E=2E89ba7cf 100644
--- a/doc/man=
-sections/client-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
=
@@ -12,6 +12,17 @@
   When this option is set, OpenVPN will not drop incomi=
ng tun packets with
   same destination as host=2E
 
+--app-custom-control =
protocollist
+  Sets the list of supported app custom control protocols=2E
=
+  These protocols are announced to the server when this option is used
+  =
as a client=2E If the option is set on a server it will negotiate the
+  co=
mmon protocols with the client=2E
+
+  The protocollist is a : separated li=
st of protocol identifiers=2E
+
+  See management-notes=2Etxt in the OpenVP=
N distribution  and the OpenVPN RFC
+  draft for a description of app custo=
m control protocol support=2E
+
 --auth-token token
   This is not an optio=
n to be used directly in any configuration files,
   but rather push this o=
ption from a ``--client-connect`` script or a
diff --git a/doc/management-n=
otes=2Etxt b/doc/management-notes=2Etxt
index d6b3fbb=2E=2Eb2dcc0a 100644
-=
-- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -798,6 =
+798,56 @@
 The client should return the response to the crtext challenge
 =
using the cr-response command=2E
 
+app custom control
+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If the special string "ACC" is passed=
 as {EXTRA} OpenVPN will determine
+the common app custom protocols between=
 the client and the sever and insruct
+the client that the server will send=
 control messages to the client using
+the ACC protocol=2E
+
+The server sh=
ould then use acc-msg command to send app custom control messages
+to the c=
lient to faciliate the pending authentication=2E
+
+COMMAND -- client-acc-m=
sg (OpenVPN 2=2E8 or higher)
+------------------------------------------
+
=
+This commands sends an app custom control message to a client,
+the format=
 of the command is:
+
+  client-acc-msg {CID} {KID}
+  {protocol}
+  {flags=
}
+  {message}
+  END
+
+CID,KID -- client ID and Key ID=2E  See documentat=
ion for ">CLIENT:"
+notification for more info=2E
+
+protocol -- the ACC pr=
otocol identified that this message should be
+            tagged with=2E
+=

+flags    -- a colon seperated list of the encoding and the flag if
+     =
       the message is a fragment=2E E=2Eg=2E "6:F" for a base64 encoded
+  =
          message that is also a fragment and not complete yet=2E
+
+messag=
e  -- The message encoded in the encoding specified in flags
+
+
+COMMAND -=
- acc-msg (OpenVPN 2=2E8 or higher)
+--------------------------------------=
----
+
+This commands sends an app custom command to the peer, the format o=
f the
+command is
+
+  acc-msg
+  {protocol}
+  {flags}
+  {message}
+  END=

+
+See the client-acc-msg command for more details about the format of the=
 message=2E
+
+
 COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)
 -------=
----------------------------------------
 
@@ -1247,6 +1297,23 @@
    respo=
nse=2E Mechanisms that need multiple rounds or more complex answers
    sho=
uld implement a different response type than CR_RESPONSE=2E
 
+(6) App cust=
om control message
+
+    This message is an application specific payload m=
essage that is transported
+    over the OpenVPN control channel=2E
+
+    =
In server mode:
+
+    >CLIENT:ACC,{CID},{KID},{protocol},{fragment},{msg_b=
ase64}
+
+    In client mode:
+
+    >ACC:{protocol},{fragment},{msg_base64=
}
+
+    The protocol is a short ascii string identifying the app specific =
custom
+    protocol and identifies the protocol=2E If fragment is set to 1=
, the message
+    is not complete and the next message should be concatena=
ted to this message
+    to form a complete message=2E
 
 Variables:
 
diff=
 --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 7fd12b=
4=2E=2E4fcccf1 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Mak=
efile=2Eam
@@ -42,6 +42,7 @@
 sbin_PROGRAMS =3D openvpn
 
 openvpn_SOURCES =
=3D \
+	acc=2Ec acc=2Eh \
 	argv=2Ec argv=2Eh \
 	auth_token=2Ec auth_token=
=2Eh \
 	base64=2Ec base64=2Eh \
@@ -121,7 +122,8 @@
 	proto=2Ec proto=2Eh =
\
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
-	push=2Ec push_util=2Ec push=
=2Eh \
+	push=2Ec push=2Eh \
+	push_util=2Ec push_util=2Eh \
 	pushlist=2Eh=
 \
 	reflect_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec reliable=2Eh \
=
diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
new file mode 100644=

index 0000000=2E=2E2b7e65f
--- /dev/null
+++ b/src/openvpn/acc=2Ec
@@ -0,0=
 +1,390 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP network=
s
+ *             over a single TCP/UDP port, with support for SSL/TLS-base=
d
+ *             session authentication and key exchange,
+ *             =
packet encryption, packet authentication, and
+ *             packet compre=
ssion=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ * =
 Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This pro=
gram is free software; you can redistribute it and/or modify
+ *  it under =
the terms of the GNU General Public License version 2
+ *  as published by =
the Free Software Foundation=2E
+ *
+ *  This program is distributed in the=
 hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even t=
he implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ =
*  You should have received a copy of the GNU General Public License along
=
+ *  with this program; if not, write to the Free Software Foundation, Inc=
=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ *=
/
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshe=
ad=2Eh"
+
+#include <string=2Eh>
+#include "buffer=2Eh"
+#include "push_uti=
l=2Eh"
+#include "error=2Eh"
+#include "acc=2Eh"
+#include "forward=2Eh"
+#=
include "options_util=2Eh"
+#include "ssl_util=2Eh"
+#include "ssl_ncp=2Eh"=

+
+enum acc_message_flag
+{
+    ACC_MESSAGE_FLAGS_ASCII =3D 1,
+    ACC_M=
ESSAGE_FLAGS_BASE64 =3D 2,
+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,
+};
+
+
+=
static void
+log_acc_message(struct context *c, const struct buffer *buf, i=
nt payload_len,
+                const char *protocol, int flags)
+{
+    b=
ool fragment =3D flags & ACC_MESSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MANAGEM=
ENT
+    struct gc_arena gc =3D gc_new();
+    const char *payload_msg =3D =
NULL;
+
+    /* For simplicity, we always encode payload to be base64 encod=
ed
+     * if not already in base64 format */
+    if (flags & ACC_MESSAGE_=
FLAGS_ASCII)
+    {
+        char *b64out =3D NULL;
+        ASSERT(openvpn=
_base64_encode(BPTR(buf), payload_len, &b64out) >=3D 0);
+        gc_addspe=
cial(b64out, free, &gc);
+        payload_msg =3D b64out;
+    }
+    else
=
+    {
+        payload_msg =3D BSTR(buf);
+    }
+
+    if (management)
+ =
   {
+        struct tls_session *session =3D &c->c2=2Etls_multi->session[T=
M_ACTIVE];
+
+        struct man_def_auth_context *mda =3D session->opt->md=
a_context;
+        if (c->options=2Emode =3D=3D MODE_SERVER)
+        {
+ =
           /* server mode=2E Report client context */
+            unsigned=
 int mda_key_id =3D get_primary_key(c->c2=2Etls_multi)->mda_key_id;
+      =
      msg(M_CLIENT, ">CLIENT:ACC,%lu,%u,%s,%d,%s",
+                mda->ci=
d, mda_key_id, protocol, fragment, payload_msg);
+        }
+        else
+=
        {
+            /* Client mode=2E Do not a report a CLIENT id */
+  =
          msg(M_CLIENT, ">ACC:%s,%d,%s", protocol, fragment, payload_msg);
=
+        }
+    }
+    gc_free(&gc);
+#endif /* ifdef ENABLE_MANAGEMENT */
=
+    msg(D_PUSH, "Received custom app control message (protocol '%s'%s)",
+=
        protocol, fragment ? ", fragment" : "");
+}
+
+
+/**
+ *  Parses th=
e flags field of an app control message and moves the
+ *  buffer past the =
flags string=2E If there is an
+ *  error parsing the flags field the metho=
d returns -1 and
+ *  puts the error reason in err_reason
+ */
+static int
=
+parse_acc_message_flags(struct buffer *buf, const char **err_reason, struc=
t gc_arena *gc)
+{
+    const char *flags =3D extract_field(buf, ',', gc);
=
+
+    if (!flags)
+    {
+        *err_reason =3D "could not extract flags=
 field";
+        return -1;
+    }
+
+
+    int acc_flags =3D 0;
+
+    fo=
r (const char *flag =3D flags; *flag !=3D '\0'; flag++)
+    {
+        if =
(*flag =3D=3D 'A')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS=
_ASCII;
+        }
+        else if (*flag =3D=3D '6')
+        {
+        =
    acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;
+        }
+        else if (*=
flag =3D=3D 'F')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_F=
RAGMENT;
+        }
+        else
+        {
+            *err_reason =3D "=
Unknown flag in flags";
+            return -1;
+        }
+    }
+    /* T=
he message should be encoded with exactly one encoding=2E Ensure that
+    =
 * only one of the flags is present */
+    bool asciienc =3D (bool)(acc_fl=
ags & ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc =3D (bool)(acc_flags & =
ACC_MESSAGE_FLAGS_BASE64);
+
+    if (base64enc + asciienc !=3D 1)
+    {
+=
        char *tmp =3D gc_malloc(512, 1, gc);
+        snprintf(tmp, 512, "n=
umber of encodings must be exactly one "
+                           "(B64=
=3D%d, ASCII=3D%d)",
+                 base64enc, asciienc);
+        *err_=
reason =3D tmp;
+        return -1;
+    }
+
+    return acc_flags;
+}
+
+
=
+void
+receive_acc_message(struct context *c, const struct buffer *buffer)
=
+{
+    struct gc_arena gc =3D gc_new();
+    const char *err_reason =3D ""=
;
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */
+    struc=
t buffer buf =3D *buffer;
+
+    if (!buf_advance(&buf, strlen("ACC")) || b=
uf_read_u8(&buf) !=3D ',')
+    {
+        err_reason =3D "missing , after =
ACC";
+        goto err;
+    }
+
+    /* extract protocol, payload length,=
 flags substrings */
+    char *protocol =3D extract_field(&buf, ',', &gc);=

+    if (!protocol)
+    {
+        err_reason =3D "could not extract prot=
ocol field";
+        goto err;
+    }
+
+    int payload_len =3D 0;
+    i=
f (!buffer_read_int(&buf, &payload_len))
+    {
+        err_reason =3D "co=
uld not extract payload length field";
+        goto err;
+    }
+
+    /* =
comma after the length */
+    if (buf_read_u8(&buf) !=3D ',')
+    {
+    =
    err_reason =3D "missing , after payload len";
+        goto err;
+    }=

+
+    int flags =3D parse_acc_message_flags(&buf, &err_reason, &gc);
+
+ =
   if (flags < 0)
+    {
+        goto err;
+    }
+
+    /* We should have=
 a final NUL byte in the control message buffer
+     * and thus the length=
 of the buffer should be payload_len + 1 */
+    if (buf_len(&buf) !=3D pay=
load_len + 1)
+    {
+        char *tmp =3D gc_malloc(512, 1, &gc);
+      =
  snprintf(tmp, 512, "field length %d, payload length %d mismatch",
+      =
           payload_len, buf_len(&buf) - 1);
+        err_reason =3D tmp;
+ =
       goto err;
+    }
+
+
+    log_acc_message(c, &buf, payload_len, prot=
ocol, flags);
+    gc_free(&gc);
+    return;
+
+err:
+    msg(D_PUSH_ERROR=
S, "WARNING: Received malformed custom app control channel "
+             =
          "(%s) message control message: %s",
+        err_reason,
+       =
 format_hex(BPTR(&buf), BLEN(&buf), 80, &gc));
+    gc_free(&gc);
+}
+
+
+b=
ool
+send_acc_message(struct context *c,
+                 struct tls_multi=
 *tls_multi,
+                 struct tls_session *session,
+              =
   const char *protocol, bool fragment,
+                 const char *msg, =
bool base64)
+{
+    /* TODO check client capabilities */
+    /* 3 for the=
 encoding, potential F, and , 1 for the final flag, 5 for the message size =
itself */
+    const size_t max_header_size =3D strlen("ACC,") + 3 + strlen=
(protocol) + 1 + 5;
+
+    size_t len =3D max_header_size + strlen(msg);
+
=
+    if (len > PUSH_BUNDLE_SIZE)
+    {
+        msg(M_CLIENT, "message len=
gth (%zu) exceeds maximum possible message length (%d)", len, PUSH_BUNDLE_S=
IZE);
+        return false;
+    }
+
+    struct gc_arena gc =3D gc_new();=

+    struct buffer buf =3D alloc_buf_gc(len, &gc);
+
+    /* Example messa=
ge: ACC,muppets,15,A,I am Miss Piggy */
+    buf_printf(&buf, "ACC,%s,%zu,%=
s%s,%s", protocol,
+               strlen(msg),
+               base64 ? "6=
" : "A",
+               fragment ? "F" : "",
+               msg);
+
+    =
send_control_channel_string_dowork(session, BSTR(&buf), D_PUSH);
+    resch=
edule_multi_process(c);
+    return true;
+}
+
+char *
+parse_acc_parameter=
s(const char *capabilities,
+                     const char *delim,
+     =
                int *max_acc_len,
+                     bool server,
+     =
                struct gc_arena *gc)
+{
+    char *tmp_message =3D string_a=
lloc(capabilities, NULL);
+    char *tmp_message_orig =3D tmp_message;
+   =
 char *lasts =3D NULL;
+
+    const char *token =3D strtok_r(tmp_message, d=
elim, &lasts);
+
+    int p =3D 0;
+    int acclen =3D 0;
+    const char *=
protocols =3D NULL;
+    char *ret =3D NULL;
+
+    /* In server mode we al=
low more capabilities than our own, in client
+     * mode we reject if we =
should use capabilities that we do not support */
+    int allowed_acc_len =
=3D server ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
+      =
  if (p =3D=3D 0 && !atoi_constrained(token, &acclen, "ACC message length",=
 ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+        {
+            =
goto done;
+        }
+
+        if (p =3D=3D 1 && (!tls_item_in_cipher_lis=
t("A", token) || !tls_item_in_cipher_list("6", token)))
+        {
+       =
     msg(D_PUSH_ERRORS, "App custom control encoding must include base64 an=
d ascii");
+            goto done;
+        }
+
+        if (p =3D=3D 1 && =
!server && strcmp(token, "A:6") && strcmp(token, "6:A"))
+        {
+      =
      msg(D_PUSH_ERRORS, "App custom control encoding must exactly base64 a=
nd ascii");
+            goto done;
+        }
+
+        if (p =3D=3D 2)
+=
        {
+            protocols =3D token;
+        }
+
+        if (p =3D=
=3D 3)
+        {
+            msg(D_PUSH_ERRORS, "Too many parameters for =
INFO ACC message/IV_SSO=2E");
+            goto done;
+        }
+
+       =
 token =3D strtok_r(NULL, delim, &lasts);
+        p++;
+    }
+
+    *max_=
acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    ret =3D string_alloc(pro=
tocols, gc);
+
+done:
+    free(tmp_message_orig);
+    return ret;
+}
+
+
=
+void
+determine_common_acc_protocols(struct context *c)
+{
+    if (!c->op=
tions=2Eacc_protocols)
+    {
+        /* No app custom protocols have been=
 configured server-side=2E */
+        return;
+    }
+    if (c->options=
=2Eacc_negotiated_protocols)
+    {
+        /* We already have determined =
the common protocols=2E Doing this
+         * again would just add an extr=
a string allocation to options->gc */
+        return;
+    }
+
+    struct=
 gc_arena gc =3D gc_new();
+
+    /* example IV_ACC: IV_ACC=3D2048,6:A,flow=
er:power */
+    const char *peer_info =3D c->c2=2Etls_multi->peer_info;
+ =
   char *iv_acc =3D extract_var_peer_info(peer_info, "IV_ACC=3D", &gc);
+  =
  if (!iv_acc)
+    {
+        gc_free(&gc);
+        return;
+    }
+
+   =
 int max_acc_len =3D 0;
+    char *protocols =3D parse_acc_parameters(iv_ac=
c, ",", &max_acc_len, true, &gc);
+
+    if (!protocols)
+    {
+        gc=
_free(&gc);
+        msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info variable=
 of peer is malformed");
+        return;
+    }
+
+    char *lasts =3D NUL=
L;
+    const char *token =3D strtok_r(protocols, ":", &lasts);
+
+    stru=
ct buffer common_protocols =3D alloc_buf_gc(1024, &gc);
+
+    while (token=
)
+    {
+        if (tls_item_in_cipher_list(token, c->options=2Eacc_proto=
cols))
+        {
+            /* protocol is in both server and client lis=
t */
+            if (buf_len(&common_protocols) > 0)
+            {
+     =
           buf_write_u8(&common_protocols, ':');
+            }
+          =
  buf_printf(&common_protocols, "%s", token);
+        }
+        token =3D=
 strtok_r(NULL, ":", &lasts);
+    }
+
+    if (buf_len(&common_protocols) =
=3D=3D 0)
+    {
+        gc_free(&gc);
+        msg(D_PUSH_DEBUG, "WARNING=
: No common app custom control protocol=2E");
+        return;
+    }
+
+  =
  c->options=2Eacc_negotiated_protocols =3D string_alloc(buf_str(&common_pr=
otocols), &c->options=2Egc);
+    c->options=2Eapp_custom_protocol_len =3D =
max_acc_len;
+    gc_free(&gc);
+}
\ No newline at end of file
diff --git a=
/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
new file mode 100644
index 00000=
00=2E=2Ec86eb5d
--- /dev/null
+++ b/src/openvpn/acc=2Eh
@@ -0,0 +1,92 @@
+/=
*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *        =
     over a single TCP/UDP port, with support for SSL/TLS-based
+ *        =
     session authentication and key exchange,
+ *             packet encryp=
tion, packet authentication, and
+ *             packet compression=2E
+ *
=
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C=
) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free =
software; you can redistribute it and/or modify
+ *  it under the terms of =
the GNU General Public License version 2
+ *  as published by the Free Soft=
ware Foundation=2E
+ *
+ *  This program is distributed in the hope that it=
 will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied wa=
rranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See =
the
+ *  GNU General Public License for more details=2E
+ *
+ *  You should=
 have received a copy of the GNU General Public License along
+ *  with thi=
s program; if not, write to the Free Software Foundation, Inc=2E,
+ *  51 F=
ranklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef A=
CC_H
+#define ACC_H
+
+#include "openvpn=2Eh"
+
+#define ACC_MIN_MSG_LEN 64=

+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * This method parses an app custom =
control message and delivers it to the
+ * management interface=2E We leave=
 reassembly of fragmented messages to the
+ * management interface=2E
+ *
+=
 * @param c            The context struct
+ * @param buffer       Buffer co=
ntaining the control message with ACC
+ */
+void
+receive_acc_message(struc=
t context *c, const struct buffer *buffer);
+
+
+bool
+send_acc_message(str=
uct context *c,
+                 struct tls_multi *tls_multi,
+           =
      struct tls_session *session,
+                 const char *protocol, =
bool fragment,
+                 const char *msg, bool base64);
+
+
+/**
+ =
* Parses an info message from the server that contains app custom control i=
nfo
+ * information prior to the PUSH_REPLY to be able to use app custom co=
ntrol
+ * protocols before sending
+ *
+ * In client mode only allow what w=
e support ourselves=2E In server mode
+ * allow also capabilities that we n=
ot support ourselves=2E
+ *
+ * @param capabilities      The string to pars=
e
+ * @param delim             The delimiter to use when parsing the string=
=2E
+ *                          IV_ACC uses "," as delimiter while the
+ *=
                          custom-control PUSH message uses " " as "," is
+ =
*                          already used to separate different push directiv=
es
+ * @param max_acc_len       Set to the maximum ACC message length
+ * @=
param server            Whether we are server or client
+ * @param gc      =
          The gc arena to use for allocating the resulting string
+ * @retu=
rn                  The resulting protocol string or NULL on error
+ */
+ch=
ar *
+parse_acc_parameters(const char *capabilities,
+                     =
const char *delim,
+                     int *max_acc_len,
+               =
      bool server,
+                     struct gc_arena *gc);
+
+/**
+ * P=
arses the IV_ACC of the peer and sets c->options=2Eacc_negotiated_protocols=

+ * to the common protocols of server and client and
+ * c->options=2Eapp_=
custom_protocol_len  to the maximum length of the ACC message
+ * support b=
y both server and client=2E
+ *
+ * If there is no common protocol or the c=
lient does not support any app custom
+ * protocol c->options=2Eacc_negotia=
ted_protocols will be set to NULL=2E
+ *
+ * @param c     the client contex=
t to use the set the app custom protocols=2E
+ */
+void
+determine_common_a=
cc_protocols(struct context *c);
+#endif
diff --git a/src/openvpn/forward=
=2Ec b/src/openvpn/forward=2Ec
index 46e1a53=2E=2E48a9b7c 100644
--- a/src/=
openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -42,6 +42,7 @@
 #inclu=
de "dco=2Eh"
 #include "auth_token=2Eh"
 #include "tun_afunix=2Eh"
+#includ=
e "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -251,11 +252,11 @@
     }
     el=
se if (buf_string_match_head_str(buf, "INFO_PRE"))
     {
-        server_p=
ushed_info(buf, 8);
+        server_pushed_info(c, buf, 8);
     }
     els=
e if (buf_string_match_head_str(buf, "INFO"))
     {
-        server_pushed=
_info(buf, 4);
+        server_pushed_info(c, buf, 4);
     }
     else if =
(buf_string_match_head_str(buf, "CR_RESPONSE"))
     {
@@ -265,6 +266,10 @@=

     {
         receive_auth_pending(c, buf);
     }
+    else if (buf_str=
ing_match_head_str(buf, "ACC"))
+    {
+        receive_acc_message(c, buf)=
;
+    }
     else if (buf_string_match_head_str(buf, "EXIT"))
     {
     =
    receive_exit_message(c);
diff --git a/src/openvpn/init=2Ec b/src/openvp=
n/init=2Ec
index 101fa64=2E=2Efc7e9b4 100644
--- a/src/openvpn/init=2Ec
+++=
 b/src/openvpn/init=2Ec
@@ -2283,6 +2283,10 @@
             buf_printf(&out=
, " aead-epoch");
         }
     }
+    if (c->options=2Eacc_negotiated_pr=
otocols)
+    {
+        buf_printf(&out, "custom-control %d,A:6,%s", c->op=
tions=2Eapp_custom_protocol_len, c->options=2Eacc_negotiated_protocols);
+ =
   }
 
     if (BLENZ(&out) > strlen(header))
     {
@@ -2527,6 +2531,11 @@=

         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (c->op=
tions=2Eacc_protocols)
+    {
+        flags |=3D OPT_P_ACC;
+    }
+
     =
return flags;
 }
 
@@ -3342,6 +3351,7 @@
     to=2Everify_hash_depth =3D op=
tions->verify_hash_depth;
     to=2Everify_hash_no_ca =3D options->verify_h=
ash_no_ca;
     memcpy(to=2Ex509_username_field, options->x509_username_fie=
ld, sizeof(to=2Ex509_username_field));
+    to=2Eacc_protocols =3D options-=
>acc_protocols;
     to=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =3D &c->net_=
ctx;
 
@@ -4300,6 +4310,27 @@
 }
 #endif /* ifdef TARGET_ANDROID */
 
+stat=
ic bool
+management_acc_msg(void *arg,
+                   struct buffer_li=
st *input) /* ownership transferred */
+{
+    struct gc_arena gc =3D gc_ne=
w();
+    struct context *c =3D arg;
+
+    bool ret =3D true;
+    if (buf=
fer_list_defined(input))
+    {
+        struct tls_multi *multi =3D c->c2=
=2Etls_multi;
+        struct tls_session *session =3D &multi->session[TM_A=
CTIVE];
+        struct options *opt =3D &c->options;
+
+        ret =3D ma=
nagement_send_acc_message(c, multi, session, opt->acc_negotiated_protocols,=
 input);
+    }
+
+    buffer_list_free(input);
+    gc_free(&gc);
+    ret=
urn ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 void
@@ -4316,6 +4347,=
7 @@
         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;
         cb=
=2Eremote_cmd =3D management_callback_remote_cmd;
         cb=2Esend_cc_mes=
sage =3D management_callback_send_cc_message;
+        cb=2Eacc_msg =3D man=
agement_acc_msg;
 #ifdef TARGET_ANDROID
         cb=2Enetwork_change =3D ma=
nagement_callback_network_change;
 #endif
diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec
index bfc2aa2=2E=2Ea9f2463 100644
--- a/src/o=
penvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -44,8 +44,10 @@
 #include=
 "dco=2Eh"
 #include "push=2Eh"
 #include "multi=2Eh"
+#include "acc=2Eh"
 =

 #include "memdbg=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PKCS11
 #i=
nclude "pkcs11=2Eh"
@@ -1080,6 +1082,35 @@
             }
             brea=
k;
 
+        case IEC_CLIENT_ACC_MSG:
+            if (man->persist=2Ecall=
back=2Eclient_acc_msg)
+            {
+                bool status =3D (*ma=
n->persist=2Ecallback=2Eclient_acc_msg)(man->persist=2Ecallback=2Earg,
+   =
                                                                   man->con=
nection=2Ein_extra_cid,
+                                                  =
                    man->connection=2Ein_extra_kid,
+                      =
                                                man->connection=2Ein_extra)=
;
+                man->connection=2Ein_extra =3D NULL;
+                re=
port_command_status(status, "client-acc-msg");
+            }
+            =
else
+            {
+                man_command_unsupported("client-acc-ms=
g");
+            }
+            break;
+
+        case IEC_ACC_MSG:
+     =
       if (man->persist=2Ecallback=2Eacc_msg)
+            {
+             =
   bool status =3D (*man->persist=2Ecallback=2Eacc_msg)(man->persist=2Ecall=
back=2Earg,
+                                                              =
 man->connection=2Ein_extra);
+                man->connection=2Ein_extra =
=3D NULL;
+                report_command_status(status, "acc-msg");
+     =
       }
+            else
+            {
+                man_command_unsu=
pported("acc-msg");
+            }
+            break;
         case IEC_PK=
_SIGN:
             man->connection=2Eext_key_state =3D EKS_READY;
        =
     buffer_list_free(man->connection=2Eext_key_input);
@@ -1204,6 +1235,29=
 @@
 }
 
 static void
+man_client_acc_msg(struct management *man, const cha=
r *cid_str,
+                   const char *kid_str)
+{
+    struct man_con=
nection *mc =3D &man->connection;
+    mc->in_extra_cid =3D 0;
+    mc->in_=
extra_kid =3D 0;
+    if (parse_cid(cid_str, &mc->in_extra_cid)
+        &&=
 parse_uint(kid_str, "KID", &mc->in_extra_kid))
+    {
+        mc->in_extr=
a_cmd =3D IEC_CLIENT_ACC_MSG;
+        in_extra_reset(mc, IER_NEW);
+    }
=
+}
+
+static void
+man_acc_msg(struct management *man)
+{
+    struct man_c=
onnection *mc =3D &man->connection;
+    mc->in_extra_cmd =3D IEC_ACC_MSG;
=
+    in_extra_reset(mc, IER_NEW);
+}
+
+static void
 man_client_auth(struct=
 management *man, const char *cid_str, const char *kid_str, const bool extr=
a)
 {
     struct man_connection *mc =3D &man->connection;
@@ -1760,6 +1814=
,17 @@
             man_client_pending_auth(man, p[1], p[2], p[3], p[4]);
 =
        }
     }
+    else if (streq(p[0], "client-acc-msg"))
+    {
+     =
   if (man_need(man, p, 2, 0))
+        {
+            man_client_acc_msg(m=
an, p[1], p[2]);
+        }
+    }
+    else if (streq(p[0], "acc-msg"))
+ =
   {
+        man_acc_msg(man);
+    }
     else if (streq(p[0], "rsa-sig")=
)
     {
         man_pk_sig(man, "rsa-sig");
@@ -3121,6 +3186,7 @@
     }
=
 }
 
+
 void
 management_connection_established(struct management *manageme=
nt, struct man_def_auth_context *mdac,
                                   c=
onst struct env_set *es)
@@ -4352,6 +4418,65 @@
     }
 }
 
+bool
+manageme=
nt_send_acc_message(struct context *c, struct tls_multi *multi, struct tls_=
session *session,
+                            const char *negotiated_proto=
cols, struct buffer_list *input)
+{
+    /* ensure that are enough inputs i=
n the list */
+    if (!input || input->size < 3)
+    {
+        msg(M_CLI=
ENT, "not enough input lines for acc message");
+        return false;
+   =
 }
+
+    struct gc_arena gc =3D gc_new();
+
+    const struct buffer *prot=
o_buf =3D buffer_list_peek(input);
+    const char *protocol =3D string_all=
oc(BSTR(proto_buf), &gc);
+    buffer_list_pop(input);
+
+    const struct =
buffer *encoding_buf =3D buffer_list_peek(input);
+    char *encoding =3D b=
uf_str(encoding_buf);
+    char *flag =3D NULL;
+    bool b64encoding =3D f=
alse;
+    bool fragment =3D false;
+
+    while ((flag =3D strsep(&encodin=
g, ":")))
+    {
+        if (!strcmp(flag, "6"))
+        {
+            b=
64encoding =3D true;
+        }
+        else if (!strcmp(flag, "F"))
+    =
    {
+            fragment =3D true;
+        }
+    }
+    buffer_list_po=
p(input);
+
+    buffer_list_aggregate_separator(input, 10000, "");
+    co=
nst struct buffer *acc_msg_buf =3D buffer_list_peek(input);
+
+    if (!pro=
to_buf || !acc_msg_buf)
+    {
+        msg(M_CLIENT, "missing protocol or =
message");
+        goto error;
+    }
+    if (!negotiated_protocols || !t=
ls_item_in_cipher_list(protocol, negotiated_protocols))
+    {
+        msg=
(M_CLIENT, "protocol not in the list of negotiated protocols: %s", np(negot=
iated_protocols));
+        goto error;
+    }
+
+    bool ret =3D send_acc=
_message(c, multi, session, protocol,
+                                frag=
ment, buf_str(acc_msg_buf),
+                                b64encoding);
=
+    gc_free(&gc);
+    return ret;
+error:
+    gc_free(&gc);
+    return =
false;
+}
 #else /* ifdef ENABLE_MANAGEMENT */
 
 #include "win32=2Eh"
diff=
 --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 71e88d0=2E=
=2E39bdf99 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh=

@@ -184,12 +184,19 @@
     int (*n_clients)(void *arg);
     bool (*send_c=
c_message)(void *arg, const char *message, const char *parameter);
     boo=
l (*kill_by_cid)(void *arg, const unsigned long cid, const char *kill_msg);=

+
     bool (*client_auth)(void *arg, const unsigned long cid, const unsig=
ned int mda_key_id,
                         const bool auth, const char *r=
eason, const char *client_reason,
                         struct buffer_li=
st *cc_config); /* ownership transferred */
     bool (*client_pending_auth=
)(void *arg, const unsigned long cid, const unsigned int kid,
             =
                    const char *extra, unsigned int timeout);
     char *(*=
get_peer_info)(void *arg, const unsigned long cid);
+    bool (*client_acc_=
msg)(void *arg,
+                           const unsigned long cid,
+     =
                      const unsigned int mda_key_id,
+                     =
      struct buffer_list *msg);
+    bool (*acc_msg)(void *arg,
+          =
          struct buffer_list *msg);
     bool (*proxy_cmd)(void *arg, const=
 char **p);
     bool (*remote_cmd)(void *arg, const char **p);
 #ifdef TAR=
GET_ANDROID
@@ -292,13 +299,15 @@
     struct command_line *in;
     struct=
 buffer_list *out;
 
-#define IEC_UNDEF       0
-#define IEC_CLIENT_AUTH 1
=
+#define IEC_UNDEF          0
+#define IEC_CLIENT_AUTH    1
 /* #define IEC=
_CLIENT_PF   2 *REMOVED FEATURE* */
-#define IEC_RSA_SIGN    3
-#define IEC=
_CERTIFICATE 4
-#define IEC_PK_SIGN     5
-#define IEC_PASSWORD    6
+#defi=
ne IEC_RSA_SIGN       3
+#define IEC_CERTIFICATE    4
+#define IEC_PK_SIGN =
       5
+#define IEC_PASSWORD       6
+#define IEC_CLIENT_ACC_MSG 7
+#defi=
ne IEC_ACC_MSG        8
     int in_extra_cmd;
     struct buffer_list *in_=
extra;
     unsigned long in_extra_cid;
@@ -511,4 +520,13 @@
  */
 void man=
agement_sleep(const int n);
 
+/** Parses the ACC message from the input bu=
ffer_list and send to the
+ * session identified by session and multi
+ */
=
+struct tls_session;
+struct tls_multi;
+bool
+management_send_acc_message(=
struct context *c, struct tls_multi *multi, struct tls_session *session,
+ =
                           const char *negotiated_protocols, struct buffer_=
list *input);
+
 #endif /* ifndef MANAGE_H */
diff --git a/src/openvpn/mult=
i=2Ec b/src/openvpn/multi=2Ec
index dda5c6b=2E=2Eae2b80d 100644
--- a/src/o=
penvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -52,6 +52,7 @@
 #include "s=
sl_util=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
+#include "=
acc=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -1773,6 +1774,13 @@
   =
      o->imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;
     }
 
+    =
if (o->acc_protocols)
+    {
+        /* If ACC is enabled server side call=
 to find common acc protocols,
+         * will be pushed during push messa=
ge */
+        determine_common_acc_protocols(c);
+    }
+
     /* Select c=
ipher if client supports Negotiable Crypto Parameters */
 
     /* if we ha=
ve already created our key, we cannot *change* our own
@@ -4032,6 +4040,24 =
@@
     }
 }
 
+static const char *
+calculate_app_control_extra(struct con=
text *c, struct gc_arena *gc)
+{
+    determine_common_acc_protocols(c);
+
=
+    if (!c->options=2Eacc_negotiated_protocols)
+    {
+        msg(M_CLIE=
NT, "ACC: No negotiated protocols");
+        return NULL;
+    }
+
+    st=
ruct buffer buf =3D alloc_buf_gc(1024, gc);
+
+    buf_printf(&buf, "ACC:%d=
 A:6 %s", c->options=2Eapp_custom_protocol_len, c->options=2Eacc_negotiated=
_protocols);
+    return buf_str(&buf);
+}
+
+
 static bool
 management_cli=
ent_pending_auth(void *arg, const unsigned long cid, const unsigned int mda=
_key_id,
                                const char *extra, unsigned int ti=
meout)
@@ -4042,17 +4068,29 @@
     if (mi)
     {
         struct tls_mult=
i *multi =3D mi->context=2Ec2=2Etls_multi;
+
+        struct gc_arena gc =
=3D gc_new();
+        if (!strcmp(extra, "ACC"))
+        {
+            e=
xtra =3D calculate_app_control_extra(&mi->context, &gc);
+            if (!=
extra)
+            {
+                gc_free(&gc);
+                retur=
n false;
+            }
+        }
         struct tls_session *session =3D=
 lookup_session_by_mda_key_id(multi, mda_key_id);
 
         if (!session)
=
         {
             return false;
         }
-        
+
         /* se=
nds INFO_PRE and AUTH_PENDING messages to client */
         bool ret =3D s=
end_auth_pending_messages(multi, session, extra, timeout);
         resched=
ule_multi_process(&mi->context);
         multi_schedule_context_wakeup(m, =
mi);
+        gc_free(&gc);
         return ret;
     }
     return false;
=
@@ -4096,6 +4134,39 @@
     return ret;
 }
 
+
+static bool
+management_cli=
ent_acc_msg(void *arg,
+                          const unsigned long cid,
=
+                          const unsigned int mda_key_id,
+                =
          struct buffer_list *input) /* ownership transferred */
+{
+    st=
ruct multi_context *m =3D (struct multi_context *)arg;
+    struct multi_in=
stance *mi =3D lookup_by_cid(m, cid);
+
+    bool ret =3D false;
+    if (m=
i && buffer_list_defined(input))
+    {
+        struct tls_multi *multi =
=3D mi->context=2Ec2=2Etls_multi;
+        struct tls_session *session =3D =
lookup_session_by_mda_key_id(multi, mda_key_id);
+        if (!session)
+  =
      {
+            msg(M_CLIENT, "client session not found");
+          =
  buffer_list_free(input);
+            return false;
+        }
+
+       =
 struct options *opt =3D &mi->context=2Eoptions;
+
+        ret =3D managem=
ent_send_acc_message(&mi->context, multi, session, opt->acc_negotiated_prot=
ocols, input);
+        multi_schedule_context_wakeup(m, mi);
+    }
+
+   =
 buffer_list_free(input);
+    return ret;
+}
+
+
 static char *
 managemen=
t_get_peer_info(void *arg, const unsigned long cid)
 {
@@ -4132,6 +4203,7 @=
@
         cb=2En_clients =3D management_callback_n_clients;
         cb=2E=
kill_by_cid =3D management_kill_by_cid;
         cb=2Eclient_auth =3D manag=
ement_client_auth;
+        cb=2Eclient_acc_msg =3D management_client_acc_m=
sg;
         cb=2Eclient_pending_auth =3D management_client_pending_auth;
 =
        cb=2Eget_peer_info =3D management_get_peer_info;
         cb=2Epush=
_update_broadcast =3D management_callback_send_push_update_broadcast;
diff =
--git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 4391434=2E=
=2E65610a71 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -35,6 +35,7 @@
 
 #include "syshead=2Eh"
 
+#include "acc=2Eh"
 #in=
clude "buffer=2Eh"
 #include "error=2Eh"
 #include "common=2Eh"
@@ -7132,6 =
+7133,28 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->fo=
rce_key_material_export =3D true;
     }
+    else if (streq(p[0], "app-cus=
tom-control") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GEN=
ERAL);
+        options->acc_protocols =3D p[1];
+    }
+    else if (streq=
(p[0], "custom-control") && p[1] && p[2] && p[3] && !p[4])
+    {
+        =
VERIFY_PERMISSION(OPT_P_ACC);
+
+        if (!streq(p[2], "A:6") && !streq(=
p[2], "6:A"))
+        {
+            msg(msglevel, "App custom control enc=
oding must be base64 and ascii");
+            goto err;
+        }
+
+    =
    if (!atoi_constrained(p[1], &options->app_custom_protocol_len,
+       =
                       "app custom message message length", ACC_MIN_MSG_LEN=
, ACC_MAX_MSG_LEN, msglevel))
+        {
+            goto err;
+        }
=
+        options->acc_negotiated_protocols =3D p[3];
+    }
     else if (s=
treq(p[0], "prng") && p[1] && !p[3])
     {
         msg(M_WARN, "NOTICE: -=
-prng option ignored (SSL library PRNG is used)");
diff --git a/src/openvpn=
/options=2Eh b/src/openvpn/options=2Eh
index e92a5cd=2E=2Eaa02382 100644
--=
- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -711,6 +711,16=
 @@
     /* force using TLS key material export for data channel key genera=
tion */
     bool force_key_material_export;
 
+    /** The app custom cont=
rol protocols we should announce as supported */
+    const char *acc_proto=
cols;
+
+    /** the protocols that are negotiated with the peer=2E As a cl=
ient we
+     * trust the server pushed list here */
+    const char *acc_n=
egotiated_protocols;
+
+    /** the maximum length of an ACC control channe=
l message */
+    int app_custom_protocol_len;
+
     bool vlan_tagging;
  =
   enum vlan_acceptable_frames vlan_accept;
     uint16_t vlan_pvid;
@@ -76=
2,9 +772,10 @@
 #define OPT_P_INLINE          (1u << 29)
 #define OPT_P_PUS=
H_MTU        (1u << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
+#define =
OPT_P_ACC             (1ull << 32)
 
 /* Options allowed in the normal conf=
iguration file */
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MOD=
E | OPT_P_PEER_ID | 0x0ull)))
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OP=
T_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define PULL_DEFINED(opt) ((=
opt)->pull)
 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
inde=
x 5b15f71=2E=2E7697ec2 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/=
push=2Ec
@@ -27,6 +27,9 @@
 #include "syshead=2Eh"
 
 #include "push=2Eh"
+=

+#include "acc=2Eh"
+#include "push_util=2Eh"
 #include "options=2Eh"
 #in=
clude "crypto=2Eh"
 #include "ssl=2Eh"
@@ -220,9 +223,8 @@
 #endif
 }
 
-
 =
void
-server_pushed_info(const struct buffer *buffer, const int adv)
+serve=
r_pushed_info(struct context *c, const struct buffer *buffer, const int adv=
)
 {
     const char *m =3D "";
     struct buffer buf =3D *buffer;
@@ -232=
,6 +234,27 @@
         m =3D BSTR(&buf);
     }
 
+    if (strncmp(m, "ACC:=
", 4) =3D=3D 0)
+    {
+        int max_acc_len =3D 0;
+
+
+        /* exam=
ple string to parse: ACC:1400 A:6 flower:happy */
+        /* Skip over the=
 ACC: prefix */
+        m +=3D 4;
+
+        char *protocols =3D parse_acc=
_parameters(m, " ", &max_acc_len, false, &c->options=2Egc);
+        if (pr=
otocols)
+        {
+            c->options=2Eacc_negotiated_protocols =3D =
protocols;
+            c->options=2Eapp_custom_protocol_len =3D max_acc_le=
n;
+        }
+        else
+        {
+            msg(D_PUSH_ERRORS, "WAR=
NING: Received ACC info command with invalid parameters");
+        }
+    =
}
+
 #ifdef ENABLE_MANAGEMENT
     struct gc_arena gc;
     if (management)=

@@ -284,6 +307,7 @@
     msg(D_PUSH, "CR response was sent by client ('%s'=
)", m);
 }
 
+
 /**
  * Parse the keyword for the AUTH_PENDING request
  * =
@param buffer                buffer containing the keywords, the buffer's
@=
@ -440,7 +464,6 @@
     const char *const peer_info =3D tls_multi->peer_inf=
o;
     unsigned int proto =3D extract_iv_proto(peer_info);
 
-
     /* Cal=
culate the maximum timeout and subtract the time we already waited */
     =
unsigned int max_timeout =3D
         max_uint(tls_multi->opt=2Erenegotiate=
_seconds / 2, tls_multi->opt=2Ehandshake_window);
@@ -731,6 +754,11 @@
    =
             client_max_mtu, o->ce=2Etun_mtu, o->ce=2Etun_mtu);
         }
=
     }
+
+    if (c->options=2Eacc_negotiated_protocols)
+    {
+        pu=
sh_option_fmt(gc, push_list, M_USAGE, "custom-control %d A:6 %s", c->option=
s=2Eapp_custom_protocol_len, c->options=2Eacc_negotiated_protocols);
+    }=

 }
 
 #if defined(__GNUC__) || defined(__clang__)
diff --git a/src/openvpn=
/push=2Eh b/src/openvpn/push=2Eh
index dff945f=2E=2E3aca8a7 100644
--- a/sr=
c/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52,6 +52,7 @@
 
 int proc=
ess_incoming_push_request(struct context *c);
 
+
 /**
  * @brief Handles t=
he receiving of a push-update message and applies updates to the specified
=
  * options=2E
@@ -92,7 +93,7 @@
 
 void receive_exit_message(struct contex=
t *c);
 
-void server_pushed_info(const struct buffer *buffer, const int ad=
v);
+void server_pushed_info(struct context *c, const struct buffer *buffer=
, const int adv);
 
 void receive_cr_response(struct context *c, const stru=
ct buffer *buffer);
 
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/=
push_util=2Ec
index fcc5411=2E=2E6462a97 100644
--- a/src/openvpn/push_util=
=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -370,4 +370,4 @@
 
     RETURN_UPDA=
TE_STATUS(n_sent);
 }
-#endif /* ifdef ENABLE_MANAGEMENT */
+#endif /* ifde=
f ENABLE_MANAGEMENT */
\ No newline at end of file
diff --git a/src/openvpn=
/push_util=2Eh b/src/openvpn/push_util=2Eh
new file mode 100644
index 00000=
00=2E=2Ec9cc680
--- /dev/null
+++ b/src/openvpn/push_util=2Eh
@@ -0,0 +1,34=
 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *  =
           over a single TCP/UDP port, with support for SSL/TLS-based
+ *  =
           session authentication and key exchange,
+ *             packet =
encryption, packet authentication, and
+ *             packet compression=
=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copy=
right (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program =
is free software; you can redistribute it and/or modify
+ *  it under the t=
erms of the GNU General Public License version 2
+ *  as published by the F=
ree Software Foundation=2E
+ *
+ *  This program is distributed in the hope=
 that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the im=
plied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  Y=
ou should have received a copy of the GNU General Public License along
+ * =
 with this program; if not, write to the Free Software Foundation, Inc=2E,
=
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+=
#include "buffer=2Eh"
+
+/**
+ * Extract a field from buf that end with the=
 \c sep character=2E The
+ * returned string is allocated in the gc_arena=
=2E If the seperator character
+ * is not found, the function returns the n=
ullptr=2E
+ */
+char *
+extract_field(struct buffer *buf, char sep, struct =
gc_arena *gc);
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index=
 d5bd602=2E=2E12e19aa 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ss=
l=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epoch=2Eh"
 #include "ssl=2Eh"
=
+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
 #include "ssl_backend=2Eh"
=
 #include "ssl_ncp=2Eh"
@@ -2054,6 +2055,11 @@
                     }
     =
            }
             }
+
+            if (session->opt->acc_protocols=
)
+            {
+                buf_printf(&out, "IV_ACC=3D%d,6:A,%s\n", =
ACC_MAX_MSG_LEN, session->opt->acc_protocols);
+            }
         }
  =
   }
 
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh=

index db61198=2E=2E3b326a7 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/s=
rc/openvpn/ssl_common=2Eh
@@ -452,6 +452,9 @@
     size_t ekm_size;
 
     =
bool dco_enabled; /**< Whether keys have to be installed in DCO or not */
+=

+    /** The app custom control protocols we should announce as supported =
*/
+    const char *acc_protocols;
 };
 
 /** @addtogroup control_processor=

diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/ope=
nvpn/Makefile=2Eam
index 5954902=2E=2Ecfa5efc 100644
--- a/tests/unit_tests=
/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -103=
,9 +103,11 @@
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $=
(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2Ec \
+    test=
_acc=2Ec test_acc=2Eh \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
-	moc=
k_management=2Ec \
+	mock_management=2Ec mock_management=2Eh \
 	mock_ssl_d=
ependencies=2Ec mock_win32_execve=2Ec \
+	$(top_srcdir)/src/openvpn/acc=2Ec=
 \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base6=
4=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -127,6 +129,7 @@
 	$(to=
p_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_ope=
nssl=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \
+	$(top_srcdir)/sr=
c/openvpn/ssl_ncp=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_=
srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \
 	$(top_srcdir)/src/openvpn/ss=
l_verify_openssl=2Ec \
@@ -375,8 +378,10 @@
 
 misc_testdriver_SOURCES =3D =
test_misc=2Ec \
 	test_schedule=2Ec test_schedule=2Eh \
+	mock_management=
=2Ec mock_management=2Eh \
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_ran=
dom=2Ec \
+	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/open=
vpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	$(top_src=
dir)/src/openvpn/ssl_util=2Ec \
@@ -388,6 +393,7 @@
 	$(top_srcdir)/src/ope=
nvpn/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
+
 p=
ush_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(to=
p_srcdir)/src/compat \
 	-I$(top_srcdir)/tests/unit_tests/openvpn \
diff --=
git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openv=
pn/mock_management=2Ec
index 77f6ce2=2E=2Ee3bf828 100644
--- a/tests/unit_t=
ests/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/mock_manage=
ment=2Ec
@@ -29,8 +29,11 @@
 
 #include "syshead=2Eh"
 
+#include <stdlib=
=2Eh>
 #include "manage=2Eh"
 
+#include "mock_management=2Eh"
+
 #ifdef EN=
ABLE_MANAGEMENT
 
 struct management *management; /* GLOBAL */
@@ -61,3 +64=
,15 @@
 management_sleep(const int n)
 {
 }
+
+void
+init_mock_management(v=
oid)
+{
+    ALLOC_OBJ_CLEAR(management, struct management);
+}
+
+void
+un=
init_mock_management(void)
+{
+    free(management);
+}
\ No newline at end=
 of file
diff --git a/tests/unit_tests/openvpn/mock_management=2Eh b/tests/=
unit_tests/openvpn/mock_management=2Eh
new file mode 100644
index 0000000=
=2E=2Ee21aec43
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_management=
=2Eh
@@ -0,0 +1,32 @@
+/*
+ *  OpenVPN -- An application to securely tunnel=
 IP networks
+ *             over a single TCP/UDP port, with support for S=
SL/TLS-based
+ *             session authentication and key exchange,
+ *  =
           packet encryption, packet authentication, and
+ *             pa=
cket compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=
=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+=
 *  This program is free software; you can redistribute it and/or modify
+ =
*  it under the terms of the GNU General Public License version 2
+ *  as p=
ublished by the Free Software Foundation=2E
+ *
+ *  This program is distri=
buted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; wi=
thout even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PA=
RTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more detai=
ls=2E
+ *
+ *  You should have received a copy of the GNU General Public Li=
cense along
+ *  with this program; if not, write to the Free Software Foun=
dation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
 USA=2E
+ */
+
+#ifndef MOCK_MANAGEMENT_H
+#define MOCK_MANAGEMENT_H
+void =
init_mock_management(void);
+
+void uninit_mock_management(void);
+
+#endif=

diff --git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/u=
nit_tests/openvpn/mock_push_dependencies=2Ec
index 112bcfd=2E=2Ec16d0cb 100=
644
--- a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
+++ b/tests/u=
nit_tests/openvpn/mock_push_dependencies=2Ec
@@ -43,7 +43,8 @@
     uint64_=
t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS=

                      | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_=
COMP | OPT_P_PERSIST
                      | OPT_P_MESSAGES | OPT_P_EXPLICI=
T_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                     | OPT_P_PEER_=
ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+           =
          | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_=
P_DHCPDNS
+                     | OPT_P_ACC;
     return flags;
 }
 
diff -=
-git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/tes=
t_acc=2Ec
new file mode 100644
index 0000000=2E=2E2b3e2dc
--- /dev/null
+++=
 b/tests/unit_tests/openvpn/test_acc=2Ec
@@ -0,0 +1,236 @@
+/*
+ *  OpenVPN=
 -- An application to securely tunnel IP networks
+ *             over a si=
ngle TCP/UDP port, with support for SSL/TLS-based
+ *             session a=
uthentication and key exchange,
+ *             packet encryption, packet a=
uthentication, and
+ *             packet compression=2E
+ *
+ *  Copyright=
 (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Sc=
hwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you =
can redistribute it and/or modify
+ *  it under the terms of the GNU Genera=
l Public License version 2
+ *  as published by the Free Software Foundatio=
n=2E
+ *
+ *  This program is distributed in the hope that it will be usefu=
l,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * =
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU G=
eneral Public License for more details=2E
+ *
+ *  You should have received=
 a copy of the GNU General Public License along
+ *  with this program; if =
not, write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street=
, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#=
include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdio=
=2Eh>
+#include <stdlib=2Eh>
+#include <stdarg=2Eh>
+#include <string=2Eh>
=
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "acc=2Eh"
+#inclu=
de "test_acc=2Eh"
+
+#include "mock_msg=2Eh"
+
+/* Mock functions */
+bool
=
+send_control_channel_string_dowork(struct tls_session *session,
+         =
                          const char *str, int msglevel)
+{
+    assert_fal=
se(true);
+    return false;
+}
+
+void
+send_push_reply_auth_token(struct =
tls_multi *multi)
+{
+}
+
+void
+auth_set_client_reason(struct tls_multi *m=
ulti, const char *reason)
+{
+}
+
+#define MSG_PAYLOAD "FgMBARkBAAEVAwNanUa=
lkEDDxLBpZw9JnjI3tBM"                \
+                    "r4engpg/cDgS48=
DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS" \
+                    "4md4OJwoQ=
AwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP" \
+                    "AJwB=
nwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH" \
+                    =
"QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc" \
+               =
     "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA" \
+          =
          "AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ" \
+     =
               "93rQwityP9eKSijXgcQ=3D=3D"
+
+void
+test_acc_parse_client_m=
essages(void **state)
+{
+    /* ensure that the messages get to mock_msg *=
/
+    x_debug_level =3D 3;
+    management =3D (void *)0x12345678;
+    st=
ruct gc_arena gc =3D gc_new();
+
+    /* contains a TLS 1=2E3 ClientHello *=
/
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PAYLOAD;
+
+    struct bu=
ffer msg_buf;
+    struct context c =3D { 0 };
+    c=2Eoptions=2Emode =3D =
MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi=
, &gc);
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &gc);=

+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt =3D &c=2Ec2=2Etls_mult=
i->opt;
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=2Eopt->mda_context =3D =
&c=2Ec2=2Emda_context;
+    buf_set_read(&msg_buf, (void *)msg, sizeof(msg)=
);
+    receive_acc_message(&c, &msg_buf);
+
+    assert_string_equal(mock_=
msg_buf, "Received custom app control message (protocol 'cck1')");
+    ass=
ert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cck1,0," MSG_PAYLOAD)=
;
+
+    const char flower_msg[] =3D "ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//=
SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)flowe=
r_msg, sizeof(flower_msg));
+    receive_acc_message(&c, &msg_buf);
+    as=
sert_string_equal(mock_msg_buf, "Received custom app control message (proto=
col 'flower')");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,=
0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D");
+
+   =
 CLEAR(mock_managment_buf);
+    const char msg_incorrect_len[] =3D "ACC,fo=
rtune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=
=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_incorrect_len, sizeof(msg_=
incorrect_len));
+    receive_acc_message(&c, &msg_buf);
+    const char *e=
rror =3D "WARNING: Received malformed custom app control channel "
+       =
                 "(field length 62, payload length 64 mismatch) message "
+=
                        "control message: 496e7367 496d316c 496a6f67 496d5a=
79 "
+                        "62326369 4c434141 65475a6d 2f534a7[more=2E=
=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, error);
+    assert_stri=
ng_equal(mock_managment_buf, "");
+
+    CLEAR(mock_managment_buf);
+    co=
nst char msg_fragment[] =3D "ACC,power,12,6F,aGVsbG8gdw=3D=3D";
+    buf_se=
t_read(&msg_buf, (void *)msg_fragment, sizeof(msg_fragment));
+    receive_=
acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "Received=
 custom app control message (protocol 'power', fragment)");
+    assert_str=
ing_equal(mock_managment_buf, ">CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D");
=
+
+    CLEAR(mock_managment_buf);
+    /* check two encoding present */
+  =
  const char flower_msg_two_encs[] =3D "ACC,flower,48,6A,SSBhbSAAIEtlcm1pdC=
D//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)fl=
ower_msg_two_encs, sizeof(flower_msg_two_encs));
+    receive_acc_message(&=
c, &msg_buf);
+
+    error =3D "WARNING: Received malformed custom app cont=
rol channel (number of "
+            "encodings must be exactly one (B64=
=3D1, ASCII=3D1)) message control "
+            "message: 53534268 6253414=
1 4945746c 636d3170 6443442f 2f534230 "
+            "61475567 37372b3[more=
=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    assert_str=
ing_equal(mock_managment_buf, "");
+
+    /* no encoding present */
+    co=
nst char flower_msg_no_encs[] =3D "ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0a=
GUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)flower_ms=
g_no_encs, sizeof(flower_msg_no_encs));
+    receive_acc_message(&c, &msg_b=
uf);
+
+    error =3D "WARNING: Received malformed custom app control chann=
el (number of "
+            "encodings must be exactly one (B64=3D0, ASCII=
=3D0)) message control "
+            "message: 53534268 62534141 4945746c =
636d3170 6443442f 2f534230 "
+            "61475567 37372b3[more=2E=2E=2E]"=
;
+    assert_string_equal(mock_msg_buf, error);
+    assert_string_equal(m=
ock_managment_buf, "");
+
+    x_debug_level =3D 0;
+    management =3D NUL=
L;
+    gc_free(&gc);
+}
+
+void
+test_parse_acc_parameters(void **state)
+=
{
+    struct gc_arena gc =3D gc_new();
+    /* parameters to INFO message =
*/
+    const char *info_acc_msg =3D "4096 A:6 flower:happy";
+
+    int ma=
x_len =3D 0;
+    const char *protocols =3D parse_acc_parameters(info_acc_m=
sg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower:=
happy");
+    assert_int_equal(max_len, 1280);
+
+    /* a client does not =
accept a length longer than it supports */
+    protocols =3D parse_acc_par=
ameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protocol=
s);
+
+    /* message with lower limit than our, should work for client and=
 server */
+    info_acc_msg =3D "1111 A:6 flower:happy";
+    protocols =
=3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    ass=
ert_string_equal(protocols, "flower:happy");
+    assert_int_equal(max_len,=
 1111);
+
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_l=
en, true, &gc);
+    assert_string_equal(protocols, "flower:happy");
+    a=
ssert_int_equal(max_len, 1111);
+
+    /* more encodings than supported=2E =
Server should be okay, client should fail */
+    info_acc_msg =3D "1200 A:=
6:B flower:happy";
+    protocols =3D parse_acc_parameters(info_acc_msg, " =
", &max_len, false, &gc);
+    assert_null(protocols);
+
+    protocols =3D=
 parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_=
string_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, 120=
0);
+
+    /* extra parameter */
+    info_acc_msg =3D "1400 A:6 flower:hap=
py 77";
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len=
, true, &gc);
+    assert_null(protocols);
+
+    protocols =3D parse_acc_p=
arameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protoc=
ols);
+
+
+    const char *iv_acc_capabilities =3D "1400,A:6,flower:happy:p=
ower";
+    protocols =3D parse_acc_parameters(iv_acc_capabilities, ",", &m=
ax_len, true, &gc);
+    assert_string_equal(protocols, "flower:happy:power=
");
+
+    /* too small protocol length */
+    info_acc_msg =3D "32 A:6 fl=
ower:happy";
+    protocols =3D parse_acc_parameters(info_acc_msg, ",", &ma=
x_len, true, &gc);
+    assert_null(protocols);
+
+    /* non-numerical pro=
tocol length */
+    info_acc_msg =3D "abff A:6 flower:happy 77";
+    prot=
ocols =3D parse_acc_parameters(info_acc_msg, ",", &max_len, true, &gc);
+  =
  assert_null(protocols);
+
+    /* non-numerical protocol length */
+    i=
nfo_acc_msg =3D "abff A:6 flower:happy 77";
+    protocols =3D parse_acc_pa=
rameters(info_acc_msg, ",", &max_len, true, &gc);
+    assert_null(protocol=
s);
+
+    gc_free(&gc);
+}
+
+void
+test_acc_common_protocols(void **state=
)
+{
+    struct context c =3D { 0 };
+    c=2Eoptions=2Egc =3D gc_new();
+=

+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &c=2Eoptions=
=2Egc);
+
+    c=2Ec2=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=
=3D1400,A:6,flower:happy:power";
+    c=2Eoptions=2Eacc_protocols =3D "powe=
r:flower:star";
+
+    determine_common_acc_protocols(&c);
+
+    assert_in=
t_equal(c=2Eoptions=2Eapp_custom_protocol_len, ACC_MAX_MSG_LEN);
+    asser=
t_string_equal(c=2Eoptions=2Eacc_negotiated_protocols, "flower:power");
+
+=
    gc_free(&c=2Eoptions=2Egc);
+}
\ No newline at end of file
diff --git a=
/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=
=2Eh
new file mode 100644
index 0000000=2E=2E11ecf32
--- /dev/null
+++ b/te=
sts/unit_tests/openvpn/test_acc=2Eh
@@ -0,0 +1,33 @@
+/*
+ *  OpenVPN -- An=
 application to securely tunnel IP networks
+ *             over a single T=
CP/UDP port, with support for SSL/TLS-based
+ *             session authent=
ication and key exchange,
+ *             packet encryption, packet authent=
ication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2=
025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe =
<arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can re=
distribute it and/or modify
+ *  it under the terms of the GNU General Publ=
ic License version 2
+ *  as published by the Free Software Foundation=2E
+=
 *
+ *  This program is distributed in the hope that it will be useful,
+ *=
  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCH=
ANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General=
 Public License for more details=2E
+ *
+ *  You should have received a cop=
y of the GNU General Public License along
+ *  with this program; if not, w=
rite to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fift=
h Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef TEST_ACC_H
+#define T=
EST_ACC_H
+void test_acc_parse_client_messages(void **state);
+
+void test_=
parse_acc_parameters(void **state);
+
+void test_acc_common_protocols(void =
**state);
+#endif
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tes=
ts/unit_tests/openvpn/test_misc=2Ec
index 5f03860=2E=2E18e4356 100644
--- a=
/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test=
_misc=2Ec
@@ -40,11 +40,35 @@
 #include "list=2Eh"
 #include "mock_msg=2Eh"=

 #include "crypto=2Eh"
+#include "test_schedule=2Eh"
+#include "mock_manag=
ement=2Eh"
+#include "multi=2Eh"
+
 #ifdef _WIN32
 #include "win32-util=2Eh=
"
 #endif
-#include "test_schedule=2Eh"
 
+/* extra mocks */
+bool
+apply_p=
ush_options(struct context *c, struct options *options, struct buffer *buf,=

+                   uint64_t permission_mask, uint64_t *option_types_found=
,
+                   struct env_set *es, bool is_update)
+{
+    return tr=
ue;
+}
+
+bool
+send_control_channel_string(struct context *c, const char *=
str, msglvl_t msglevel)
+{
+    check_expected_ptr(str);
+    return true;
=
+}
+
+struct multi_instance *
+lookup_by_cid(struct multi_context *m, const=
 unsigned long cid)
+{
+    return *(m->instances);
+}
 
 static void
 test=
_compat_lzo_string(void **state)
@@ -492,5 +516,8 @@
 main(void)
 {
     op=
envpn_unit_test_setup();
-    return cmocka_run_group_tests(misc_tests, NUL=
L, NULL);
+    init_mock_management();
+    int ret =3D cmocka_run_group_te=
sts(misc_tests, NULL, NULL);
+    uninit_mock_management();
+    return ret=
;
 }
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/=
openvpn/test_ssl=2Ec
index d6b63d0=2E=2Eb3889cd 100644
--- a/tests/unit_tes=
ts/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -52,=
6 +52,8 @@
 #include "ssl_verify=2Eh"
 #include "openvpn=2Eh"
 
+#include "=
test_acc=2Eh"
+
 /* Mock function to be allowed to include win32=2Ec which =
is required for
  * getting the temp directory */
 #ifdef _WIN32
@@ -87,6 +=
89,16 @@
     return;
 }
 
+/* Define a dummy dco cipher option to avoid li=
nking against all the DCO
+ * units */
+#if defined(ENABLE_DCO)
+const char=
 *
+dco_get_supported_ciphers(void)
+{
+    return "AES-192-GCM:AES-128-CBC=
:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+}
+#endif
+
 /* generated usi=
ng
  * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -k=
eyout - \
  * -noenc -sha256 -days 3650 -subj '/CN=3Dovpn-test-secp384r1'  =
-nodes \
@@ -960,8 +972,10 @@
         cmocka_unit_test(test_data_channel_k=
nown_vectors_epoch),
         cmocka_unit_test(test_data_channel_known_vect=
ors_shortpktid),
         cmocka_unit_test(crypto_test_print_cert_details),=

-        cmocka_unit_test(ssl_test_extract_peer_info)
-
+        cmocka_un=
it_test(ssl_test_extract_peer_info),
+        cmocka_unit_test(test_acc_par=
se_client_messages),
+        cmocka_unit_test(test_parse_acc_parameters),
=
+        cmocka_unit_test(test_acc_common_protocols)
     };
 
 #if defined=
(ENABLE_CRYPTO_OPENSSL)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858=

Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--zFqoLllrC68=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Implement sending/receiving app custom control protocol<br><br>Ch=
ange-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84<br>Signed-off-by: Arne S=
chwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man=
-sections/client-options=2Erst<br>M doc/management-notes=2Etxt<br>M src/ope=
nvpn/Makefile=2Eam<br>A src/openvpn/acc=2Ec<br>A src/openvpn/acc=2Eh<br>M s=
rc/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2E=
c<br>M src/openvpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/o=
ptions=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/push=2Ec<br>M src/=
openvpn/push=2Eh<br>M src/openvpn/push_util=2Ec<br>A src/openvpn/push_util=
=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M tests/un=
it_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/mock_managemen=
t=2Ec<br>A tests/unit_tests/openvpn/mock_management=2Eh<br>M tests/unit_tes=
ts/openvpn/mock_push_dependencies=2Ec<br>A tests/unit_tests/openvpn/test_ac=
c=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Eh<br>M tests/unit_tests/open=
vpn/test_misc=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>27 files ch=
anged, 1,318 insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/2</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index =
6eb5954=2E=2E8f52e44 100644</span><br><span>--- a/CMakeLists=2Etxt</span><b=
r><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -424,6 +424,8 @@</span><b=
r><span>     src/compat/compat-gettimeofday=2Ec</span><br><span>     src/co=
mpat/compat-strsep=2Ec</span><br><span>     src/compat/compat-strtok_r=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/acc=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn=
/acc=2Eh</span><br><span>     src/openvpn/argv=2Ec</span><br><span>     src=
/openvpn/argv=2Eh</span><br><span>     src/openvpn/base64=2Ec</span><br><sp=
an>@@ -560,8 +562,9 @@</span><br><span>     src/openvpn/ps=2Ec</span><br><s=
pan>     src/openvpn/ps=2Eh</span><br><span>     src/openvpn/push=2Ec</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    src/openvpn/push_util=
=2Ec</span><br><span>     src/openvpn/push=2Eh</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    src/openvpn/push_util=2Ec</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/push_util=2Eh</span><b=
r><span>     src/openvpn/pushlist=2Eh</span><br><span>     src/openvpn/refl=
ect_filter=2Ec</span><br><span>     src/openvpn/reflect_filter=2Eh</span><b=
r><span>@@ -812,7 +815,10 @@</span><br><span>             tests/unit_tests/=
openvpn/mock_management=2Ec</span><br><span>             tests/unit_tests/o=
penvpn/mock_ssl_dependencies=2Ec</span><br><span>             tests/unit_te=
sts/openvpn/mock_win32_execve=2Ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            tests/unit_tests/openvpn/test_acc=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/acc=2Ec=
</span><br><span>             src/openvpn/argv=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            src/openvpn/auth_token=2Ec</span=
><br><span>             src/openvpn/base64=2Ec</span><br><span>            =
 src/openvpn/crypto_epoch=2Ec</span><br><span>             src/openvpn/cryp=
to_mbedtls=2Ec</span><br><span>@@ -826,8 +832,11 @@</span><br><span>       =
      src/openvpn/options_util=2Ec</span><br><span>             src/openvpn=
/otime=2Ec</span><br><span>             src/openvpn/packet_id=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/relia=
ble=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
src/openvpn/session_id=2Ec</span><br><span>             src/openvpn/run_com=
mand=2Ec</span><br><span>             src/openvpn/ssl_mbedtls=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/ssl_n=
cp=2Ec</span><br><span>             src/openvpn/ssl_openssl=2Ec</span><br><=
span>             src/openvpn/ssl_util=2Ec</span><br><span>             src=
/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -844,6 +853,8 @@</span><=
br><span>     target_sources(test_misc PRIVATE</span><br><span>         tes=
ts/unit_tests/openvpn/mock_get_random=2Ec</span><br><span>         tests/un=
it_tests/openvpn/test_schedule=2Ec</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        tests/unit_tests/openvpn/mock_management=2Ec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/base64=
=2Ec</span><br><span>         src/openvpn/options_util=2Ec</span><br><span>=
         src/openvpn/otime=2Ec</span><br><span>         src/openvpn/ssl_uti=
l=2Ec</span><br><span>diff --git a/doc/man-sections/client-options=2Erst b/=
doc/man-sections/client-options=2Erst</span><br><span>index 87c138a=2E=2E89=
ba7cf 100644</span><br><span>--- a/doc/man-sections/client-options=2Erst</s=
pan><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><span>@=
@ -12,6 +12,17 @@</span><br><span>   When this option is set, OpenVPN will =
not drop incoming tun packets with</span><br><span>   same destination as h=
ost=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+--app-custom-control protocollist</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  Sets the list of supported app custom control protocol=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  These protoco=
ls are announced to the server when this option is used</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  as a client=2E If the option is set o=
n a server it will negotiate the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  common protocols with the client=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  The protocollist is a : separated list of protocol identifier=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  See management-notes=2Etxt in th=
e OpenVPN distribution  and the OpenVPN RFC</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  draft for a description of app custom control pro=
tocol support=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> --auth-token token</span><br><span>   This is not an option =
to be used directly in any configuration files,</span><br><span>   but rath=
er push this option from a ``--client-connect`` script or a</span><br><span=
>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</span=
><br><span>index d6b3fbb=2E=2Eb2dcc0a 100644</span><br><span>--- a/doc/mana=
gement-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</span><=
br><span>@@ -798,6 +798,56 @@</span><br><span> The client should return the=
 response to the crtext challenge</span><br><span> using the cr-response co=
mmand=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+app custom control</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+If the special string &quot;ACC&qu=
ot; is passed as {EXTRA} OpenVPN will determine</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+the common app custom protocols between the cli=
ent and the sever and insruct</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+the client that the server will send control messages to the clie=
nt using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the ACC pro=
tocol=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+The server should then use acc=
-msg command to send app custom control messages</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+to the client to faciliate the pending authent=
ication=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- client-acc-msg (O=
penVPN 2=2E8 or higher)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+------------------------------------------</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+This commands sends an app custom control message to a client,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+the format of the comman=
d is:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  client-acc-msg {CID} {KID}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  {flags}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  {message}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  END</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CID,KID=
 -- client ID and Key ID=2E  See documentation for &quot;&gt;CLIENT:&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+notification for mor=
e info=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+protocol -- the ACC protocol =
identified that this message should be</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            tagged with=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+flags    -- a colon seperated list of the encoding and the flag if</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            the messa=
ge is a fragment=2E E=2Eg=2E &quot;6:F&quot; for a base64 encoded</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            message that is a=
lso a fragment and not complete yet=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
message  -- The message encoded in the encoding specified in flags</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+-----------------------------------------=
-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+This commands sends an app custom com=
mand to the peer, the format of the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+command is</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  acc-msg</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  {flags}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  {message}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  END</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+See t=
he client-acc-msg command for more details about the format of the message=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMMAND -- client=
-deny  (OpenVPN 2=2E1 or higher)</span><br><span> -------------------------=
----------------------</span><br><span> </span><br><span>@@ -1247,6 +1297,2=
3 @@</span><br><span>    response=2E Mechanisms that need multiple rounds o=
r more complex answers</span><br><span>    should implement a different res=
ponse type than CR_RESPONSE=2E</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+(6) App custom control message</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    This message is an application specific payload me=
ssage that is transported</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    over the OpenVPN control channel=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    In server mode:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;CLIE=
NT:ACC,{CID},{KID},{protocol},{fragment},{msg_base64}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    In client mode:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&gt;ACC:{protocol},{fragment},{msg_base64}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    The protocol is a short ascii string identifying the app specific c=
ustom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocol a=
nd identifies the protocol=2E If fragment is set to 1, the message</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    is not complete and the =
next message should be concatenated to this message</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    to form a complete message=2E</span><=
br><span> </span><br><span> Variables:</span><br><span> </span><br><span>di=
ff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br>=
<span>index 7fd12b4=2E=2E4fcccf1 100644</span><br><span>--- a/src/openvpn/M=
akefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><spa=
n>@@ -42,6 +42,7 @@</span><br><span> sbin_PROGRAMS =3D openvpn</span><br><s=
pan> </span><br><span> openvpn_SOURCES =3D \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	acc=2Ec acc=2Eh \</span><br><span> 	argv=2Ec argv=
=2Eh \</span><br><span> 	auth_token=2Ec auth_token=2Eh \</span><br><span> 	=
base64=2Ec base64=2Eh \</span><br><span>@@ -121,7 +122,8 @@</span><br><span=
> 	proto=2Ec proto=2Eh \</span><br><span> 	proxy=2Ec proxy=2Eh \</span><br>=
<span> 	ps=2Ec ps=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	push=2Ec push_util=2Ec push=2Eh \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	push=2Ec push=2Eh \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	push_util=2Ec push_util=2Eh \</span><br><span> 	pushlist=
=2Eh \</span><br><span> 	reflect_filter=2Ec reflect_filter=2Eh \</span><br>=
<span> 	reliable=2Ec reliable=2Eh \</span><br><span>diff --git a/src/openvp=
n/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>new file mode 100644</span>=
<br><span>index 0000000=2E=2E2b7e65f</span><br><span>--- /dev/null</span><b=
r><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -0,0 +1,390 @@</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tu=
nnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            over a single TCP/UDP port, with support for SSL/TLS-based</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session a=
uthentication and key exchange,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             packet encryption, packet authentication, and</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025=
 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, write to the Free Software Foundation, Inc=2E,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth=
 Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG=
_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;co=
nfig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;push_u=
til=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;forward=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
sl_ncp=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+enum acc_message_flag<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_ASCII =3D 1,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_B=
ASE64 =3D 2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC=
_MESSAGE_FLAGS_FRAGMENT =3D 4,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+log_acc_message(struct context *c, const struct buff=
er *buf, int payload_len,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                const char *protocol, int flags)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bool fragment =3D flags &amp; ACC_MESSAGE_FLAGS_FRAGME=
NT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MA=
NAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *payload_msg =3D NULL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* For simplicity, we always encode payload to be base64 encoded</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * if not already=
 in base64 format */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (flags &amp; ACC_MESSAGE_FLAGS_ASCII)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        char *b64out =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        ASSERT(openvpn_base64_encode(BPTR(buf), payl=
oad_len, &amp;b64out) &gt;=3D 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        gc_addspecial(b64out, free, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D b64out;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        payload_msg =3D BSTR(buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_=
session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct man_def_auth_context *mda =
=3D session-&gt;opt-&gt;mda_context;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            /* server mode=2E Repor=
t client context */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            unsigned int mda_key_id =3D get_primary_key(c-&gt;c2=2Etls_mult=
i)-&gt;mda_key_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(M_CLIENT, &quot;&gt;CLIENT:ACC,%lu,%u,%s,%d,%s&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                mda-&gt;ci=
d, mda_key_id, protocol, fragment, payload_msg);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            /* Client mode=2E Do not a report a CLIENT id */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;=
&gt;ACC:%s,%d,%s&quot;, protocol, fragment, payload_msg);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &quot;Received custom app=
 control message (protocol &#39;%s&#39;%s)&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        protocol, fragment ? &quot;, fragment=
&quot; : &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Parses the flags field of an app control message and moves the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  buffer past the f=
lags string=2E If there is an</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  error parsing the flags field the method returns -1 and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  puts the error reason=
 in err_reason</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_message_flags(struct=
 buffer *buf, const char **err_reason, struct gc_arena *gc)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *flags =3D extract_field(buf, &#39;,&#=
39;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        *err_reason =3D &quot;could not extract=
 flags field&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int acc_flags =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (const char *flag =3D flags; *flag !=3D &#39;\0&#39;; flag+=
+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (*flag =3D=3D &#39;A=
&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=
=3D ACC_MESSAGE_FLAGS_ASCII;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else if (*flag =3D=3D &#39;6&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        else if (*flag =3D=3D &#39;F&#39=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D =
ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *err_re=
ason =3D &quot;Unknown flag in flags&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return -1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* The message should be encoded with exactly one encoding=2E Ensure=
 that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * only on=
e of the flags is present */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool asciienc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_ASC=
II);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool base64=
enc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_BASE64);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (base64enc + asciienc !=3D 1)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &=
quot;number of encodings must be exactly one &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           &quot;(B64=3D%=
d, ASCII=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                 base64enc, asciienc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        *err_reason =3D tmp;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return -1;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return acc_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+receive_acc_message(struct context *c, const struct buffer *buffer)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *err_reas=
on =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Example mes=
sage: ACC,muppets,15,A,I am Miss Piggy */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D *buffer;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!buf_advance(&amp;buf, strlen(&quot;ACC&quot;)) |=
| buf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        err_reason =3D &quot;missing , after ACC&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* extract protocol, payload length, flags substrings */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *protocol =3D ex=
tract_field(&amp;buf, &#39;,&#39;, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!protocol)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        err_reason =3D &quot;could not extract protocol field&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int payload_len =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!buffer_read_int(&amp;buf, &amp;payl=
oad_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &=
quot;could not extract payload length field&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* comma after the length */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (buf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        err_reason =3D &quot;missing , after payload=
 len&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int flags =3D parse_acc_message_flags=
(&amp;buf, &amp;err_reason, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (flags &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto =
err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* We should have a final NUL byte in the co=
ntrol message buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * and thus the length of the buffer should be payload_len + 1 */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;buf=
) !=3D payload_len + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ch=
ar *tmp =3D gc_malloc(512, 1, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        snprintf(tmp, 512, &quot;field length %d, paylo=
ad length %d mismatch&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                 payload_len, buf_len(&amp;buf) - 1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D tmp;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 log_acc_message(c, &amp;buf, payload_len, protocol, flags);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(D_PUSH_ERRORS, &quot;WARNING: Received malformed custom app contro=
l channel &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                    &quot;(%s) message control message: %s&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        format_hex(BPTR(&amp;=
buf), BLEN(&amp;buf), 80, &amp;gc));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+send_acc_message(struct context *c,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                 struct tls_multi *t=
ls_multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
       struct tls_session *session,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                 const char *protocol, bool fragment,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const ch=
ar *msg, bool base64)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TODO chec=
k client capabilities */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* 3 for the encoding, potential F, and , 1 for the final flag, 5 =
for the message size itself */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const size_t max_header_size =3D strlen(&quot;ACC,&quot;) + =
3 + strlen(protocol) + 1 + 5;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_=
t len =3D max_header_size + strlen(msg);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (len &gt; PUSH_BUNDLE_SIZE)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_CLIENT, &quot;message length (%zu) exceeds maximum possibl=
e message length (%d)&quot;, len, PUSH_BUNDLE_SIZE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(len, &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Example message: ACC,muppets,15,A=
,I am Miss Piggy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    buf_printf(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&quot;, protocol,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+               strlen(msg),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+               base6=
4 ? &quot;6&quot; : &quot;A&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+               fragment ? &quot;F&quot; : &quot;&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+               msg);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    send_control_channel_string_dowork(se=
ssion, BSTR(&amp;buf), D_PUSH);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    reschedule_multi_process(c);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_parameters(const c=
har *capabilities,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    const char *delim,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                     int *max_acc_len,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     bool server,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                     st=
ruct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_messa=
ge =3D string_alloc(capabilities, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    char *tmp_message_orig =3D tmp_message;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp_me=
ssage, delim, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int p =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int accle=
n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *protocols =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    char *ret =3D NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* In =
server mode we allow more capabilities than our own, in client</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * mode we reject if we shou=
ld use capabilities that we do not support */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int allowed_acc_len =3D server ? INT_MAX : AC=
C_MAX_MSG_LEN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (token)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 0 &amp;&amp; !atoi_=
constrained(token, &amp;acclen, &quot;ACC message length&quot;, ACC_MIN_MSG=
_LEN, allowed_acc_len, D_PUSH_ERRORS))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            goto done;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=
=3D 1 &amp;&amp; (!tls_item_in_cipher_list(&quot;A&quot;, token) || !tls_it=
em_in_cipher_list(&quot;6&quot;, token)))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_PUSH_ERRORS, &quot;App custom control encodin=
g must include base64 and ascii&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            goto done;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (p =3D=3D 1 &amp;&amp; !server &amp;&amp; strcmp(token, &quot;A:6&quot=
;) &amp;&amp; strcmp(token, &quot;6:A&quot;))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;App custom control enc=
oding must exactly base64 and ascii&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            goto done;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (p =3D=3D 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    protocols =3D token;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 3)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS,=
 &quot;Too many parameters for INFO ACC message/IV_SSO=2E&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            goto done;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        token =3D strtok_r(NULL, delim, &amp;lasts);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        p++;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D string_alloc(=
protocols, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    free(tmp_message_orig);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protocol=
s(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;op=
tions=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
No app custom protocols have been configured server-side=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_negotiated_protocols)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* We already have determi=
ned the common protocols=2E Doing this</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * again would just add an extra string allocati=
on to options-&gt;gc */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* example IV_ACC: IV_ACC=3D204=
8,6:A,flower:power */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *peer_info =3D c-&gt;c2=2Etls_multi-&gt;peer_info;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    char *iv_acc =3D extrac=
t_var_peer_info(peer_info, &quot;IV_ACC=3D&quot;, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!iv_acc)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
max_acc_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   char *protocols =3D parse_acc_parameters(iv_acc, &quot;,&quot;, &amp;max=
_acc_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!prot=
ocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ER=
RORS, &quot;WARNING: IV_ACC peer info variable of peer is malformed&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(protocols, &quo=
t;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er common_protocols =3D alloc_buf_gc(1024, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    while (token)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (tls_item_in_cipher_list(token, c-&gt;options=2Eacc_protocols))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            /* protocol is in b=
oth server and client list */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (buf_len(&amp;common_protocols) &gt; 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                buf_write_u8(&amp;co=
mmon_protocols, &#39;:&#39;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            buf_printf(&amp;common_protocols, &quot;%s&quot;, token);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r(NULL=
, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;co=
mmon_protocols) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(D_PUSH_DEBUG, &quot;WARNING: No common app custom control protoco=
l=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_negotiated_protocols=
 =3D string_alloc(buf_str(&amp;common_protocols), &amp;c-&gt;options=2Egc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=
=2Eapp_custom_protocol_len =3D max_acc_len;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline at end of file</sp=
an><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span><=
br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ec86eb5d</s=
pan><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Eh</span=
><br><span>@@ -0,0 +1,92 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenV=
PN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (=
C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Th=
is program is free software; you can redistribute it and/or modify</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of th=
e GNU General Public License version 2</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, write to the Free Sof=
tware Foundation, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef ACC_H</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_MIN_MSG_=
LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_M=
AX_MSG_LEN 1280</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * This method parses an app custom con=
trol message and delivers it to the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * management interface=2E We leave reassembly of fragmente=
d messages to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 management interface=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c =
           The context struct</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param buffer       Buffer containing the control message with=
 ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+receive_acc_message(struct context *c, const s=
truct buffer *buffer);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+send_acc_message(struct context *c,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 struct tls_multi =
*tls_multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
         struct tls_session *session,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                 const char *protocol, bool fragment,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const =
char *msg, bool base64);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Parses an info message from the server that co=
ntains app custom control info</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * information prior to the PUSH_REPLY to be able to use app cus=
tom control</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * proto=
cols before sending</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In client mode=
 only allow what we support ourselves=2E In server mode</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * allow also capabilities that we not =
support ourselves=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param capabi=
lities      The string to parse</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param delim             The delimiter to use when parsing t=
he string=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
                     IV_ACC uses &quot;,&quot; as delimiter while the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                       =
   custom-control PUSH message uses &quot; &quot; as &quot;,&quot; is</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                       =
   already used to separate different push directives</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param max_acc_len       Set to the ma=
ximum ACC message length</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param server            Whether we are server or client</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc                Th=
e gc arena to use for allocating the resulting string</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return                  The resulting=
 protocol string or NULL on error</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ch=
ar *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_param=
eters(const char *capabilities,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     const char *delim,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     int *max_acc_len,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                     b=
ool server,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
             struct gc_arena *gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parses the IV_ACC=
 of the peer and sets c-&gt;options=2Eacc_negotiated_protocols</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * to the common protocols of se=
rver and client and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * c-&gt;options=2Eapp_custom_protocol_len  to the maximum length of the AC=
C message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * support=
 by both server and client=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If t=
here is no common protocol or the client does not support any app custom</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * protocol c-&gt;opti=
ons=2Eacc_negotiated_protocols will be set to NULL=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param c     the client context to use the set the app =
custom protocols=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protocols(=
struct context *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/f=
orward=2Ec</span><br><span>index 46e1a53=2E=2E48a9b7c 100644</span><br><spa=
n>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=
=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;dco=
=2Eh&quot;</span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><=
span> #include &quot;tun_afunix=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span>=
<br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><spa=
n>@@ -251,11 +252,11 @@</span><br><span>     }</span><br><span>     else if=
 (buf_string_match_head_str(buf, &quot;INFO_PRE&quot;))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pus=
hed_info(buf, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      server_pushed_info(c, buf, 8);</span><br><span>     }</span><br><span=
>     else if (buf_string_match_head_str(buf, &quot;INFO&quot;))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
erver_pushed_info(buf, 4);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        server_pushed_info(c, buf, 4);</span><br><span>     }</span>=
<br><span>     else if (buf_string_match_head_str(buf, &quot;CR_RESPONSE&qu=
ot;))</span><br><span>     {</span><br><span>@@ -265,6 +266,10 @@</span><br=
><span>     {</span><br><span>         receive_auth_pending(c, buf);</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (buf_string_match_head_str(buf, &quot;ACC&quot;))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        receive_acc_message(c, buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else i=
f (buf_string_match_head_str(buf, &quot;EXIT&quot;))</span><br><span>     {=
</span><br><span>         receive_exit_message(c);</span><br><span>diff --g=
it a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 101f=
a64=2E=2Efc7e9b4 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><b=
r><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2283,6 +2283,10 @@</=
span><br><span>             buf_printf(&amp;out, &quot; aead-epoch&quot;);<=
/span><br><span>         }</span><br><span>     }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_negotiated_protoc=
ols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, =
&quot;custom-control %d,A:6,%s&quot;, c-&gt;options=2Eapp_custom_protocol_l=
en, c-&gt;options=2Eacc_negotiated_protocols);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     if =
(BLENZ(&amp;out) &gt; strlen(header))</span><br><span>     {</span><br><spa=
n>@@ -2527,6 +2531,11 @@</span><br><span>         flags |=3D (OPT_P_ROUTE |=
 OPT_P_DHCPDNS);</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_protocols=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_ACC;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return flags;<=
/span><br><span> }</span><br><span> </span><br><span>@@ -3342,6 +3351,7 @@<=
/span><br><span>     to=2Everify_hash_depth =3D options-&gt;verify_hash_dep=
th;</span><br><span>     to=2Everify_hash_no_ca =3D options-&gt;verify_hash=
_no_ca;</span><br><span>     memcpy(to=2Ex509_username_field, options-&gt;x=
509_username_field, sizeof(to=2Ex509_username_field));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    to=2Eacc_protocols =3D options-&gt;a=
cc_protocols;</span><br><span>     to=2Ees =3D c-&gt;c2=2Ees;</span><br><sp=
an>     to=2Enet_ctx =3D &amp;c-&gt;net_ctx;</span><br><span> </span><br><s=
pan>@@ -4300,6 +4310,27 @@</span><br><span> }</span><br><span> #endif /* if=
def TARGET_ANDROID */</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+management_acc_msg(void *arg,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                   struct buffer_list *input) /* owne=
rship transferred */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct context *c =3D arg;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 ret =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (buffer_list_defined(input))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *session =3D =
&amp;multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct options *opt =3D &amp;c-&gt;options;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        ret =3D management_send_acc_message(c, =
multi, session, opt-&gt;acc_negotiated_protocols, input);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buffer_list_free(input);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><=
br><span> </span><br><span> void</span><br><span>@@ -4316,6 +4347,7 @@</spa=
n><br><span>         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</spa=
n><br><span>         cb=2Eremote_cmd =3D management_callback_remote_cmd;</s=
pan><br><span>         cb=2Esend_cc_message =3D management_callback_send_cc=
_message;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=
=2Eacc_msg =3D management_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</=
span><br><span>         cb=2Enetwork_change =3D management_callback_network=
_change;</span><br><span> #endif</span><br><span>diff --git a/src/openvpn/m=
anage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index bfc2aa2=2E=2Ea9f24=
63 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ =
b/src/openvpn/manage=2Ec</span><br><span>@@ -44,8 +44,10 @@</span><br><span=
> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;push=2Eh&quo=
t;</span><br><span> #include &quot;multi=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span=
> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><b=
r><span> </span><br><span> #ifdef ENABLE_PKCS11</span><br><span> #include &=
quot;pkcs11=2Eh&quot;</span><br><span>@@ -1080,6 +1082,35 @@</span><br><spa=
n>             }</span><br><span>             break;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        case IEC_CLIENT_=
ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (man-&gt;persist=2Ecallback=2Eclient_acc_msg)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                bool status =3D (*man-&gt;persist=
=2Ecallback=2Eclient_acc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                                       man-&gt;connection=2Ein_extra_cid,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                                                 man-&gt;connection=2Ein_ex=
tra_kid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                                                           man-&gt;connecti=
on=2Ein_extra);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            man-&gt;connection=2Ein_extra =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                report_command_status(sta=
tus, &quot;client-acc-msg&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               man_command_unsupported(&quot;client-acc-msg&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        case IEC_ACC_MSG:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (man-&gt;persist=2Ecallback=2Eac=
c_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                boo=
l status =3D (*man-&gt;persist=2Ecallback=2Eacc_msg)(man-&gt;persist=2Ecall=
back=2Earg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                                       man-&gt;connection=
=2Ein_extra);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          man-&gt;connection=2Ein_extra =3D NULL;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                report_command_status(status,=
 &quot;acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    man_command_unsupported(&quot;acc-msg&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            break;</span><br><span>         case IE=
C_PK_SIGN:</span><br><span>             man-&gt;connection=2Eext_key_state =
=3D EKS_READY;</span><br><span>             buffer_list_free(man-&gt;connec=
tion=2Eext_key_input);</span><br><span>@@ -1204,6 +1235,29 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+man_client_acc_msg(struct management *man=
, const char *cid_str,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                   const char *kid_str)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct man_connection *mc =3D &amp;man-&gt;connection;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_cid =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_=
kid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (p=
arse_cid(cid_str, &amp;mc-&gt;in_extra_cid)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        &amp;&amp; parse_uint(kid_str, &quot;KID&qu=
ot;, &amp;mc-&gt;in_extra_kid))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      mc-&gt;in_extra_cmd =3D IEC_CLIENT_ACC_MSG;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        in_extra_reset(mc, IER_NEW);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_acc_msg=
(struct management *man)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ma=
n_connection *mc =3D &amp;man-&gt;connection;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_cmd =3D IEC_ACC_MSG;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    in_extra_reset(mc, IER_N=
EW);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span> man_client_auth(struct =
management *man, const char *cid_str, const char *kid_str, const bool extra=
)</span><br><span> {</span><br><span>     struct man_connection *mc =3D &am=
p;man-&gt;connection;</span><br><span>@@ -1760,6 +1814,17 @@</span><br><spa=
n>             man_client_pending_auth(man, p[1], p[2], p[3], p[4]);</span>=
<br><span>         }</span><br><span>     }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;client-acc-msg&quot;=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(man, p, 2,=
 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            man_client_ac=
c_msg(man, p[1], p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p=
[0], &quot;acc-msg&quot;))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 man_acc_msg(man);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span>     else if (streq(p[0], &quot;rsa-sig&quot;))</span>=
<br><span>     {</span><br><span>         man_pk_sig(man, &quot;rsa-sig&quo=
t;);</span><br><span>@@ -3121,6 +3186,7 @@</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> void</span><br><span> management_connection_estab=
lished(struct management *management, struct man_def_auth_context *mdac,</s=
pan><br><span>                                   const struct env_set *es)<=
/span><br><span>@@ -4352,6 +4418,65 @@</span><br><span>     }</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_=
send_acc_message(struct context *c, struct tls_multi *multi, struct tls_ses=
sion *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                       const char *negotiated_protocols, struct buffer_list=
 *input)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* ensure that are enough=
 inputs in the list */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!input || input-&gt;size &lt; 3)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(M_CLIENT, &quot;not enough input lines for acc messag=
e&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *proto_buf =3D bu=
ffer_list_peek(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *protocol =3D string_alloc(BSTR(proto_buf), &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(inp=
ut);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *encoding_=
buf =3D buffer_list_peek(input);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    char *encoding =3D buf_str(encoding_buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    char *flag =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool b64encoding =3D false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool fragment =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    while ((flag =3D strsep(=
&amp;encoding, &quot;:&quot;)))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (!strcmp(flag, &quot;6&quot;))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            b64encoding =3D true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        else if (!strcmp(flag, &quot;F&quot;))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            fragment =3D true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    buffer_list_pop(input);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buffer_list_aggregate_separator(input, 10000, &quot;&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buff=
er *acc_msg_buf =3D buffer_list_peek(input);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!proto_buf || !acc_msg_buf)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_CLIENT, &quot;missing protocol or message&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!negotiated_protocols || !tls=
_item_in_cipher_list(protocol, negotiated_protocols))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_CLIENT, &quot;protocol not in the list of=
 negotiated protocols: %s&quot;, np(negotiated_protocols));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    bool ret =3D send_acc_message(c, multi, session, protocol,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
       fragment, buf_str(acc_msg_buf),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                b64encoding);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+error:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #else /* ifdef ENABLE_=
MANAGEMENT */</span><br><span> </span><br><span> #include &quot;win32=2Eh&q=
uot;</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/mana=
ge=2Eh</span><br><span>index 71e88d0=2E=2E39bdf99 100644</span><br><span>--=
- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</sp=
an><br><span>@@ -184,12 +184,19 @@</span><br><span>     int (*n_clients)(vo=
id *arg);</span><br><span>     bool (*send_cc_message)(void *arg, const cha=
r *message, const char *parameter);</span><br><span>     bool (*kill_by_cid=
)(void *arg, const unsigned long cid, const char *kill_msg);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool (*clien=
t_auth)(void *arg, const unsigned long cid, const unsigned int mda_key_id,<=
/span><br><span>                         const bool auth, const char *reaso=
n, const char *client_reason,</span><br><span>                         stru=
ct buffer_list *cc_config); /* ownership transferred */</span><br><span>   =
  bool (*client_pending_auth)(void *arg, const unsigned long cid, const uns=
igned int kid,</span><br><span>                                 const char =
*extra, unsigned int timeout);</span><br><span>     char *(*get_peer_info)(=
void *arg, const unsigned long cid);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bool (*client_acc_msg)(void *arg,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                           const unsigne=
d long cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                   const unsigned int mda_key_id,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                           struct buffer_list=
 *msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool (*a=
cc_msg)(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   struct buffer_list *msg);</span><br><span>     bool (*pr=
oxy_cmd)(void *arg, const char **p);</span><br><span>     bool (*remote_cmd=
)(void *arg, const char **p);</span><br><span> #ifdef TARGET_ANDROID</span>=
<br><span>@@ -292,13 +299,15 @@</span><br><span>     struct command_line *i=
n;</span><br><span>     struct buffer_list *out;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_UNDEF       0</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CLIENT_AUTH 1<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_UNDEF   =
       0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC=
_CLIENT_AUTH    1</span><br><span> /* #define IEC_CLIENT_PF   2 *REMOVED FE=
ATURE* */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_=
RSA_SIGN    3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
IEC_CERTIFICATE 4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine IEC_PK_SIGN     5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define IEC_PASSWORD    6</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define IEC_RSA_SIGN       3</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define IEC_CERTIFICATE    4</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define IEC_PK_SIGN        5</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define IEC_PASSWORD       6</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_ACC_MSG 7</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_ACC_MSG    =
    8</span><br><span>     int in_extra_cmd;</span><br><span>     struct bu=
ffer_list *in_extra;</span><br><span>     unsigned long in_extra_cid;</span=
><br><span>@@ -511,4 +520,13 @@</span><br><span>  */</span><br><span> void =
management_sleep(const int n);</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/** Parses the ACC message from the input buff=
er_list and send to the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * session identified by session and multi</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+struct tls_session;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+struct tls_multi;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+manage=
ment_send_acc_message(struct context *c, struct tls_multi *multi, struct tl=
s_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                            const char *negotiated_protocols, struct buffer=
_list *input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> #endif /* ifndef MANAGE_H */</span><br><span>diff --git a/src/=
openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index dda5c6b=2E=
=2Eae2b80d 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -52,6 +52,7 @@</span><br>=
<span> #include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;dc=
o=2Eh&quot;</span><br><span> #include &quot;reflect_filter=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quo=
t;</span><br><span> </span><br><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</s=
pan><br><span> </span><br><span>@@ -1773,6 +1774,13 @@</span><br><span>    =
     o-&gt;imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (o-&gt;acc_protocols)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* If ACC is enabled server side call to find common acc protoc=
ols,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * will=
 be pushed during push message */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        determine_common_acc_protocols(c);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     /* Select cipher if client sup=
ports Negotiable Crypto Parameters */</span><br><span> </span><br><span>   =
  /* if we have already created our key, we cannot *change* our own</span><=
br><span>@@ -4032,6 +4040,24 @@</span><br><span>     }</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cal=
culate_app_control_extra(struct context *c, struct gc_arena *gc)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    determine_common_acc_protocols(c);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!c-&gt;options=2Eacc_negotiated_protocol=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ACC=
: No negotiated protocols&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
buf =3D alloc_buf_gc(1024, gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf=
_printf(&amp;buf, &quot;ACC:%d A:6 %s&quot;, c-&gt;options=2Eapp_custom_pro=
tocol_len, c-&gt;options=2Eacc_negotiated_protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return buf_str(&amp;buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> static bool</span><br><span> management_client_pen=
ding_auth(void *arg, const unsigned long cid, const unsigned int mda_key_id=
,</span><br><span>                                const char *extra, unsign=
ed int timeout)</span><br><span>@@ -4042,17 +4068,29 @@</span><br><span>   =
  if (mi)</span><br><span>     {</span><br><span>         struct tls_multi =
*multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!strcmp(extra, &quot;ACC&quot;))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            extra =3D calculate_ap=
p_control_extra(&amp;mi-&gt;context, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (!extra)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>      =
   struct tls_session *session =3D lookup_session_by_mda_key_id(multi, mda_=
key_id);</span><br><span> </span><br><span>         if (!session)</span><br=
><span>         {</span><br><span>             return false;</span><br><spa=
n>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
      /* sends INFO_PRE and AUTH_PENDING messages to client */</span><br><s=
pan>         bool ret =3D send_auth_pending_messages(multi, session, extra,=
 timeout);</span><br><span>         reschedule_multi_process(&amp;mi-&gt;co=
ntext);</span><br><span>         multi_schedule_context_wakeup(m, mi);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc)=
;</span><br><span>         return ret;</span><br><span>     }</span><br><sp=
an>     return false;</span><br><span>@@ -4096,6 +4134,39 @@</span><br><spa=
n>     return ret;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+management_client_acc_msg(void *arg,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                          const unsigned long cid=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
        const unsigned int mda_key_id,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                          struct buffer_list *input) /* =
ownership transferred */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mu=
lti_context *m =3D (struct multi_context *)arg;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D lookup_by_cid=
(m, cid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; buf=
fer_list_defined(input))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
truct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *session=
 =3D lookup_session_by_mda_key_id(multi, mda_key_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!session)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;client session no=
t found&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        buffer_list_free(input);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct options *opt =3D &amp;mi-&gt;context=2Eoptions;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        ret =3D management_send_acc_message(&amp;mi-&gt;cont=
ext, multi, session, opt-&gt;acc_negotiated_protocols, input);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        multi_schedule_context_w=
akeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    buffer_list_free(input);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> static char *</span><br><span> management_get_peer_in=
fo(void *arg, const unsigned long cid)</span><br><span> {</span><br><span>@=
@ -4132,6 +4203,7 @@</span><br><span>         cb=2En_clients =3D management=
_callback_n_clients;</span><br><span>         cb=2Ekill_by_cid =3D manageme=
nt_kill_by_cid;</span><br><span>         cb=2Eclient_auth =3D management_cl=
ient_auth;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
b=2Eclient_acc_msg =3D management_client_acc_msg;</span><br><span>         =
cb=2Eclient_pending_auth =3D management_client_pending_auth;</span><br><spa=
n>         cb=2Eget_peer_info =3D management_get_peer_info;</span><br><span=
>         cb=2Epush_update_broadcast =3D management_callback_send_push_upda=
te_broadcast;</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/op=
envpn/options=2Ec</span><br><span>index 4391434=2E=2E65610a71 100644</span>=
<br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/o=
ptions=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><s=
pan> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br>=
<span> #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;erro=
r=2Eh&quot;</span><br><span> #include &quot;common=2Eh&quot;</span><br><spa=
n>@@ -7132,6 +7133,28 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_G=
ENERAL);</span><br><span>         options-&gt;force_key_material_export =3D=
 true;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (streq(p[0], &quot;app-custom-control&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        options-&gt;acc_protocols =3D p[1];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;custom-control&quot;=
) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[4])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ACC);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!streq(p[2], &quot;A:6&quot;)=
 &amp;&amp; !streq(p[2], &quot;6:A&quot;))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(msglevel, &quot;App custom control encoding mu=
st be base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ato=
i_constrained(p[1], &amp;options-&gt;app_custom_protocol_len,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                              &qu=
ot;app custom message message length&quot;, ACC_MIN_MSG_LEN, ACC_MAX_MSG_LE=
N, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto=
 err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;acc_=
negotiated_protocols =3D p[3];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;prng&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>=
         msg(M_WARN, &quot;NOTICE: --prng option ignored (SSL library PRNG =
is used)&quot;);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src=
/openvpn/options=2Eh</span><br><span>index e92a5cd=2E=2Eaa02382 100644</spa=
n><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn=
/options=2Eh</span><br><span>@@ -711,6 +711,16 @@</span><br><span>     /* f=
orce using TLS key material export for data channel key generation */</span=
><br><span>     bool force_key_material_export;</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /** The app custom contro=
l protocols we should announce as supported */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *acc_protocols;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /** the protocols that are negotiated with the peer=
=2E As a client we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * trust the server pushed list here */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *acc_negotiated_protocols;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /** the maximum length of an ACC control chan=
nel message */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt app_custom_protocol_len;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     bool vlan_tagging;</span><br><span>     enum =
vlan_acceptable_frames vlan_accept;</span><br><span>     uint16_t vlan_pvid=
;</span><br><span>@@ -762,9 +772,10 @@</span><br><span> #define OPT_P_INLIN=
E          (1u &lt;&lt; 29)</span><br><span> #define OPT_P_PUSH_MTU        =
(1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUTE_TABLE     (1u &lt;&lt=
; 31)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_=
ACC             (1ull &lt;&lt; 32)</span><br><span> </span><br><span> /* Op=
tions allowed in the normal configuration file */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P=
_PULL_MODE | OPT_P_PEER_ID | 0x0ull)))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MOD=
E | OPT_P_PEER_ID | OPT_P_ACC))</span><br><span> </span><br><span> #define =
PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 5b=
15f71=2E=2E7697ec2 100644</span><br><span>--- a/src/openvpn/push=2Ec</span>=
<br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -27,6 +27,9 @@</spa=
n><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br><=
span> #include &quot;push=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;push_util=2Eh&quot;</span><br><span> #include &quot;op=
tions=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br>=
<span> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -220,9 +223,8 @@</sp=
an><br><span> #endif</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-server_pushed_info(const struct buffer=
 *buffer, const int adv)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+server_pushed_info(struct context *c, const struct buffer *buffer, con=
st int adv)</span><br><span> {</span><br><span>     const char *m =3D &quot=
;&quot;;</span><br><span>     struct buffer buf =3D *buffer;</span><br><spa=
n>@@ -232,6 +234,27 @@</span><br><span>         m =3D BSTR(&amp;buf);</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&quot;, 4) =3D=3D 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int max_acc_len =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* example string to parse: ACC:1400 A:6 flower:happy */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Skip over th=
e ACC: prefix */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     m +=3D 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *protocols =
=3D parse_acc_parameters(m, &quot; &quot;, &amp;max_acc_len, false, &amp;c-=
&gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    c-&gt;options=2Eacc_negotiated_protocols =3D protocols;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;options=2Eapp_cus=
tom_protocol_len =3D max_acc_len;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(D_PUSH_ERRORS, &quot;WARNING: Received ACC info command with invalid par=
ameters&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENA=
BLE_MANAGEMENT</span><br><span>     struct gc_arena gc;</span><br><span>   =
  if (management)</span><br><span>@@ -284,6 +307,7 @@</span><br><span>     =
msg(D_PUSH, &quot;CR response was sent by client (&#39;%s&#39;)&quot;, m);<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Parse the keywor=
d for the AUTH_PENDING request</span><br><span>  * @param buffer           =
     buffer containing the keywords, the buffer&#39;s</span><br><span>@@ -4=
40,7 +464,6 @@</span><br><span>     const char *const peer_info =3D tls_mul=
ti-&gt;peer_info;</span><br><span>     unsigned int proto =3D extract_iv_pr=
oto(peer_info);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>     /* Calculate the maximum timeout and subt=
ract the time we already waited */</span><br><span>     unsigned int max_ti=
meout =3D</span><br><span>         max_uint(tls_multi-&gt;opt=2Erenegotiate=
_seconds / 2, tls_multi-&gt;opt=2Ehandshake_window);</span><br><span>@@ -73=
1,6 +754,11 @@</span><br><span>                 client_max_mtu, o-&gt;ce=2E=
tun_mtu, o-&gt;ce=2Etun_mtu);</span><br><span>         }</span><br><span>  =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_negoti=
ated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        push_optio=
n_fmt(gc, push_list, M_USAGE, &quot;custom-control %d A:6 %s&quot;, c-&gt;o=
ptions=2Eapp_custom_protocol_len, c-&gt;options=2Eacc_negotiated_protocols)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan> }</span><br><span> </span><br><span> #if defined(__GNUC__) || defined(=
__clang__)</span><br><span>diff --git a/src/openvpn/push=2Eh b/src/openvpn/=
push=2Eh</span><br><span>index dff945f=2E=2E3aca8a7 100644</span><br><span>=
--- a/src/openvpn/push=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</span=
><br><span>@@ -52,6 +52,7 @@</span><br><span> </span><br><span> int process=
_incoming_push_request(struct context *c);</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><s=
pan>  * @brief Handles the receiving of a push-update message and applies u=
pdates to the specified</span><br><span>  * options=2E</span><br><span>@@ -=
92,7 +93,7 @@</span><br><span> </span><br><span> void receive_exit_message(=
struct context *c);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-void server_pushed_info(const struct buffer *buffer, const =
int adv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void serve=
r_pushed_info(struct context *c, const struct buffer *buffer, const int adv=
);</span><br><span> </span><br><span> void receive_cr_response(struct conte=
xt *c, const struct buffer *buffer);</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br><s=
pan>index fcc5411=2E=2E6462a97 100644</span><br><span>--- a/src/openvpn/pus=
h_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><br><span>=
@@ -370,4 +370,4 @@</span><br><span> </span><br><span>     RETURN_UPDATE_ST=
ATUS(n_sent);</span><br><span> }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT */</span><br>=
<span>\ No newline at end of file</span><br><span>diff --git a/src/openvpn/=
push_util=2Eh b/src/openvpn/push_util=2Eh</span><br><span>new file mode 100=
644</span><br><span>index 0000000=2E=2Ec9cc680</span><br><span>--- /dev/nul=
l</span><br><span>+++ b/src/openvpn/push_util=2Eh</span><br><span>@@ -0,0 +=
1,34 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application=
 to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             over a single TCP/UDP port, with support for SSL=
/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      session authentication and key exchange,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet encryption, packet authent=
ication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        packet compression=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Cop=
yright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt=
;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softw=
are; you can redistribute it and/or modify</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Lic=
ense version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  a=
s published by the Free Software Foundation=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  This program is distributed in the hope that it will be usefu=
l,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT A=
NY WARRANTY; without even the implied warranty of</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, write to the Free Software Foundation, Inc=2E,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Extract a field from buf tha=
t end with the \c sep character=2E The</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * returned string is allocated in the gc_arena=2E If th=
e seperator character</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * is not found, the function returns the nullptr=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+extract_field(struct buffer *buf, char sep, struct gc_arena *gc);</sp=
an><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><=
br><span>index d5bd602=2E=2E12e19aa 100644</span><br><span>--- a/src/openvp=
n/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -55,=
6 +55,7 @@</span><br><span> </span><br><span> #include &quot;crypto_epoch=
=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br=
><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span> #include &quot=
;ssl_backend=2Eh&quot;</span><br><span> #include &quot;ssl_ncp=2Eh&quot;</s=
pan><br><span>@@ -2054,6 +2055,11 @@</span><br><span>                     }=
</span><br><span>                 }</span><br><span>             }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (session-&gt;opt-&gt;acc_protoco=
ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_pr=
intf(&amp;out, &quot;IV_ACC=3D%d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&=
gt;opt-&gt;acc_protocols);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span>         }</span><br><span>     }</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src=
/openvpn/ssl_common=2Eh</span><br><span>index db61198=2E=2E3b326a7 100644</=
span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/o=
penvpn/ssl_common=2Eh</span><br><span>@@ -452,6 +452,9 @@</span><br><span> =
    size_t ekm_size;</span><br><span> </span><br><span>     bool dco_enable=
d; /**&lt; Whether keys have to be installed in DCO or not */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /** The app custom control protocols we should a=
nnounce as supported */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *acc_protocols;</span><br><span> };</span><br><span> </s=
pan><br><span> /** @addtogroup control_processor</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefi=
le=2Eam</span><br><span>index 5954902=2E=2Ecfa5efc 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/uni=
t_tests/openvpn/Makefile=2Eam</span><br><span>@@ -103,9 +103,11 @@</span><b=
r><span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_L=
DFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =
=3D test_ssl=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   test_acc=2Ec test_acc=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh =
test_common=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	moc=
k_management=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
mock_management=2Ec mock_management=2Eh \</span><br><span> 	mock_ssl_depend=
encies=2Ec mock_win32_execve=2Ec \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	$(top_srcdir)/src/openvpn/acc=2Ec \</span><br><span> 	$(top=
_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn=
/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</spa=
n><br><span>@@ -127,6 +129,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn=
/run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_openssl=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn=
/ssl_ncp=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</=
span><br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \</span><br><sp=
an>@@ -375,8 +378,10 @@</span><br><span> </span><br><span> misc_testdriver_=
SOURCES =3D test_misc=2Ec \</span><br><span> 	test_schedule=2Ec test_schedu=
le=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_manag=
ement=2Ec mock_management=2Eh \</span><br><span> 	mock_msg=2Ec test_common=
=2Eh  \</span><br><span> 	mock_get_random=2Ec \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/base64=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/options_util=2Ec \</span><br><span> 	$(top_srcdir)/src/o=
penvpn/ssl_util=2Ec \</span><br><span>@@ -388,6 +393,7 @@</span><br><span> =
	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/sr=
c/openvpn/siphash_reference=2Ec</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> push_update_msg_testdriver_=
CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/=
src/compat \</span><br><span> 	-I$(top_srcdir)/tests/unit_tests/openvpn \</=
span><br><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/=
tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>index 77f6ce2=
=2E=2Ee3bf828 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_ma=
nagement=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=
=2Ec</span><br><span>@@ -29,8 +29,11 @@</span><br><span> </span><br><span> =
#include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span>=
 #include &quot;manage=2Eh&quot;</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;mock_management=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifde=
f ENABLE_MANAGEMENT</span><br><span> </span><br><span> struct management *m=
anagement; /* GLOBAL */</span><br><span>@@ -61,3 +64,15 @@</span><br><span>=
 management_sleep(const int n)</span><br><span> {</span><br><span> }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+init_mock_management(void)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ALLOC_OBJ_CLEAR(management, struct management);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uninit_mock_mana=
gement(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(management);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No =
newline at end of file</span><br><span>diff --git a/tests/unit_tests/openvp=
n/mock_management=2Eh b/tests/unit_tests/openvpn/mock_management=2Eh</span>=
<br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ee21aec43<=
/span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvp=
n/mock_management=2Eh</span><br><span>@@ -0,0 +1,32 @@</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP netwo=
rks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             o=
ver a single TCP/UDP port, with support for SSL/TLS-based</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication=
 and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*             packet encryption, packet authentication, and</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN In=
c &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  This program is free software; you can redistribute =
it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 it under the terms of the GNU General Public License version 2</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free So=
ftware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program=
 is distributed in the hope that it will be useful,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publi=
c License for more details=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, write to the Free Software Foundation, Inc=2E,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifndef MOCK_MANAGEMENT_H</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MOCK_MANAGEMENT_=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void init_mock_man=
agement(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void uninit_mock_managem=
ent(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff =
--git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_te=
sts/openvpn/mock_push_dependencies=2Ec</span><br><span>index 112bcfd=2E=2Ec=
16d0cb 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_push_depe=
ndencies=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_push_depen=
dencies=2Ec</span><br><span>@@ -43,7 +43,8 @@</span><br><span>     uint64_t=
 flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS<=
/span><br><span>                      | OPT_P_SETENV | OPT_P_SHAPER | OPT_P=
_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><span>                      |=
 OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                     | OPT=
_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                     | O=
PT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                     | =
OPT_P_ACC;</span><br><span>     return flags;</span><br><span> }</span><br>=
<span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_acc=2Ec =
b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>new file mode 10064=
4</span><br><span>index 0000000=2E=2E2b3e2dc</span><br><span>--- /dev/null<=
/span><br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span=
>@@ -0,0 +1,236 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An =
application to securely tunnel IP networks</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with supp=
ort for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             session authentication and key exchange,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pac=
ket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet compression=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne =
Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is=
 free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, write to the Free Software Foundati=
on, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 F=
ranklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
yshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;st=
dlib=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Mock functions */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_cont=
rol_channel_string_dowork(struct tls_session *session,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                   const=
 char *str, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_f=
alse(true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+send_push_reply_auth_token(struct tls_multi *multi)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+auth_set_client_reason(st=
ruct tls_multi *multi, const char *reason)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define MSG_PAYLOAD &quot;FgMBAR=
kBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM&quot;                \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    &quot;r4engpg/cDgS=
48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS&quot; \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    &quot;4md4OJwoQAwEwITAxM=
BwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP&quot; \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    &quot;AJwBnwArAFAA5wAnAEwAzAQA=
AnP8BAAEAAAsABAMAAQIACgAWABQAH&quot; \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    &quot;QAXAB4AGQAYAQABAQECAQMBBAAWAAA=
AFwAAAA0AMAAuBAMFAwYDCAc&quot; \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    &quot;ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQM=
DAwEDAgQCBQIGAgArA&quot; \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    &quot;AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2Fsx=
OfOIV4gn/NyJ&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    &quot;93rQwityP9eKSijXgcQ=3D=3D&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_acc_parse_client_messages(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* ensure that the messages get to mock_msg */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 3;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    management =3D (void *)=
0x12345678;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* con=
tains a TLS 1=2E3 ClientHello */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char msg[] =3D &quot;ACC,cck1,384,6,&quot; MSG_PAYLO=
AD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer msg_buf;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct context c =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=
=2Emode =3D MODE_SERVER;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_=
CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_mu=
lti, struct tls_multi, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;c=2Ec2=2Etls_multi-=
&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=
=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt-&gt;mda_context =3D &amp;c=2Ec2=
=2Emda_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buf_set_read(&amp;msg_buf, (void *)msg, sizeof(msg));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_=
buf, &quot;Received custom app control message (protocol &#39;cck1&#39;)&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_str=
ing_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,cck1,0,&quot; MSG_PA=
YLOAD);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char flower_msg[] =3D=
 &quot;ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_=
read(&amp;msg_buf, (void *)flower_msg, sizeof(flower_msg));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &am=
p;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_string_equal(mock_msg_buf, &quot;Received custom app control message (pr=
otocol &#39;flower&#39;)&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:A=
CC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char msg_incorre=
ct_len[] =3D &quot;ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiA=
iSSBhbSAAS2VybWl0IiB9Ig=3D=3D&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg_incorrect_len, =
sizeof(msg_incorrect_len));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *error =3D &quot;WARNING:=
 Received malformed custom app control channel &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        &quot;(field leng=
th 62, payload length 64 mismatch) message &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        &quot;control message=
: 496e7367 496d316c 496a6f67 496d5a79 &quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        &quot;62326369 4c434141 65=
475a6d 2f534a7[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(mock_msg_buf, error);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char msg_f=
ragment[] =3D &quot;ACC,power,12,6F,aGVsbG8gdw=3D=3D&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (voi=
d *)msg_fragment, sizeof(msg_fragment));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(moc=
k_msg_buf, &quot;Received custom app control message (protocol &#39;power&#=
39;, fragment)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,pow=
er,1,aGVsbG8gdw=3D=3D&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR=
(mock_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* check two encoding present */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char flower_msg_two_encs[] =3D &quot;ACC,flowe=
r,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_b=
uf, (void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, =
&amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARN=
ING: Received malformed custom app control channel (number of &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;encoding=
s must be exactly one (B64=3D1, ASCII=3D1)) message control &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;message: 5=
3534268 62534141 4945746c 636d3170 6443442f 2f534230 &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;61475567 37372b3[=
more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_string_equal(mock_msg_buf, error);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &qu=
ot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* no encoding present =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char fl=
ower_msg_no_encs[] =3D &quot;ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+=
94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg_no_encs, sizeof(=
flower_msg_no_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    error =3D &quot;WARNING: Received malformed custom app contro=
l channel (number of &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            &quot;encodings must be exactly one (B64=3D0, ASCII=3D0=
)) message control &quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &quot;message: 53534268 62534141 4945746c 636d3170 644344=
2f 2f534230 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;61475567 37372b3[more=2E=2E=2E]&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, e=
rror);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(mock_managment_buf, &quot;&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    x_debug_level =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    management =3D NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_parse_acc_parameters(void **=
state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* paramet=
ers to INFO message */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *info_acc_msg =3D &quot;4096 A:6 flower:happy&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int max_len =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =3D parse_ac=
c_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal=
(protocols, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(max_len, 1280);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* a client does not accept a length longer than it su=
pports */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protoc=
ols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, fal=
se, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* message wi=
th lower limit than our, should work for client and server */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1111 A=
:6 flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp=
;max_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_l=
en, 1111);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_=
parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(p=
rotocols, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(max_len, 1111);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* more encodings than supported=2E Server should be oka=
y, client should fail */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    info_acc_msg =3D &quot;1200 A:6:B flower:happy&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_para=
meters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(=
info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &=
quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(max_len, 1200);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* extra parameter */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    info_acc_msg =3D &quot;1400 A:6 flower:happy 77&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_ac=
c_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protoco=
ls);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parame=
ters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *iv_acc_capabilities =3D &quot;1400,A:6,flowe=
r:happy:power&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    protocols =3D parse_acc_parameters(iv_acc_capabilities, &quot;,&quot;,=
 &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_string_equal(protocols, &quot;flower:happy:power&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* too small protocol length */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =
=3D &quot;32 A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot=
;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* non-numerical protocol length */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;abff A:6 flower:hap=
py 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pro=
tocols =3D parse_acc_parameters(info_acc_msg, &quot;,&quot;, &amp;max_len, =
true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* non-nume=
rical protocol length */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    info_acc_msg =3D &quot;abff A:6 flower:happy 77&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_par=
ameters(info_acc_msg, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_commo=
n_protocols(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct c=
ontext c =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    c=2Eoptions=2Egc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &amp;c=2Eoptions=
=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;peer=
_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2E=
acc_protocols =3D &quot;power:flower:star&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    determine_common_acc_protocols(&amp;c);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(c=2Eoptions=2Eapp_custom_protocol_len, =
ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(c=2Eoptions=2Eacc_negotiated_protocols, &quot;flower:=
power&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c=2Eopti=
ons=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span>\ No newline at end of file</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh</span>=
<br><span>new file mode 100644</span><br><span>index 0000000=2E=2E11ecf32</=
span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_acc=2Eh</span><br><span>@@ -0,0 +1,33 @@</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a si=
ngle TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             session authentication and key=
 exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      packet encryption, packet authentication, and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sa=
les@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  This program is free software; you can redistribute it and/o=
r modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it unde=
r the terms of the GNU General Public License version 2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software F=
oundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is dist=
ributed in the hope that it will be useful,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the impl=
ied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License =
for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should ha=
ve received a copy of the GNU General Public License along</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write=
 to the Free Software Foundation, Inc=2E,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110=
-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ACC_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define TEST_ACC_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void test_acc_parse_client_messages(void =
**state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void test_parse_acc_parameter=
s(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_common_p=
rotocols(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=
=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index 5f03860=
=2E=2E18e4356 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_mi=
sc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><=
br><span>@@ -40,11 +40,35 @@</span><br><span> #include &quot;list=2Eh&quot;=
</span><br><span> #include &quot;mock_msg=2Eh&quot;</span><br><span> #inclu=
de &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;test_schedule=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;mock_management=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
#ifdef _WIN32</span><br><span> #include &quot;win32-util=2Eh&quot;</span><b=
r><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#inclu=
de &quot;test_schedule=2Eh&quot;</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* extra mocks */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+apply_push_options(struct context *c, struct options *options=
, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                   uint64_t permission_mask, uint64_t *option_types_found=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
 struct env_set *es, bool is_update)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+send_control_channel_string(struct context *c, const cha=
r *str, msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_e=
xpected_ptr(str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct multi_instance *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+lookup_by_cid(struct multi_context *m=
, const unsigned long cid)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
*(m-&gt;instances);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span> </span><br><span> static void</span><br><span> test_comp=
at_lzo_string(void **state)</span><br><span>@@ -492,5 +516,8 @@</span><br><=
span> main(void)</span><br><span> {</span><br><span>     openvpn_unit_test_=
setup();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return cm=
ocka_run_group_tests(misc_tests, NULL, NULL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    init_mock_management();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int ret =3D cmocka_run_group_tests(mi=
sc_tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uninit_mock_management();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return ret;</span><br><span> }</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=
=2Ec</span><br><span>index d6b63d0=2E=2Eb3889cd 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_te=
sts/openvpn/test_ssl=2Ec</span><br><span>@@ -52,6 +52,8 @@</span><br><span>=
 #include &quot;ssl_verify=2Eh&quot;</span><br><span> #include &quot;openvp=
n=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;test_acc=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /* Mock function to be allowed to=
 include win32=2Ec which is required for</span><br><span>  * getting the te=
mp directory */</span><br><span> #ifdef _WIN32</span><br><span>@@ -87,6 +89=
,16 @@</span><br><span>     return;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define a dummy dco =
cipher option to avoid linking against all the DCO</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * units */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+const char *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+dco_get_supported_ciphers(void)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return &quot;AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-12=
8-GCM:CHACHA20-POLY1305&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*=
 generated using</span><br><span>  * openssl req -x509 -newkey ec -pkeyopt =
ec_paramgen_curve:secp384r1 -keyout - \</span><br><span>  * -noenc -sha256 =
-days 3650 -subj &#39;/CN=3Dovpn-test-secp384r1&#39;  -nodes \</span><br><s=
pan>@@ -960,8 +972,10 @@</span><br><span>         cmocka_unit_test(test_dat=
a_channel_known_vectors_epoch),</span><br><span>         cmocka_unit_test(t=
est_data_channel_known_vectors_shortpktid),</span><br><span>         cmocka=
_unit_test(crypto_test_print_cert_details),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        cmocka_unit_test(ssl_test_extract_peer_info)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(ssl_test_extract=
_peer_info),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_acc_parse_client_messages),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_parse_acc_para=
meters),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_acc_common_protocols)</span><br><span>     };</span><br>=
<span> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de=
86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1858 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"=
display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--zFqoLllrC68=--


--===============6799222715797605930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6799222715797605930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6799222715797605930==--

