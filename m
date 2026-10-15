Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862C4CC6B3A
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yu+g+KMVM/wV7FES7EH/LxYfuqQooL19yyEgr3+jqK4=; b=FoSJZmLw5hLchmeNsIdWFiFqdG
	5TtmMiEgdDRxLrEhGgdPZchSsmQNdniRo+ttA4eNpPdarJSL0Yn8jyTKCNX1+UKhbG+3cY4HFXoax
	XihDzOezE0XOChSj46+ABbYL3Ql5JjsLya98WXpjYxgXanwh2TgxULS/sjw+QNmCNsW4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHNR8-0008BC-3O;
	Thu, 15 Oct 2026 15:32:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHNR6-0008Au-UE
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2wepqeZl6yO+KNjv9D1ICDYem6zBoxk5ZaIE8j8Xuv8=; b=aDCH64zkrkjO3Hu8fg1Af3Vf46
 Tnq7cslB7ZlsDdIGZEq3zkIKB+KCVWG93g+ZWc6idLkzTfLf3NH9CqGr7MK+W7lKtVkXBdEcFCeQt
 gMoZ06j5tcz6r4tySpAB7e8FhxBCqanIEQ/wuNr/VNbQZf84YdygnZyaasWZBry5wxqE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2wepqeZl6yO+KNjv9D1ICDYem6zBoxk5ZaIE8j8Xuv8=; b=f
 kTi1S6WgPfIcsZYHrS4S/qjZJ6by5G9hsG5afwHStysiskMTM+2fGDr8lixVfl7rcUv0C/NtfEoJx
 VR1h410wYu2Vj3roM6tNQtK731MgevcBpnfBkGAm6rpw9wpKY5+OXgVABIAf8kcSRWFkK/VOB7e5O
 2kBhb5TsC/V6vQNQ=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHNQx-00026a-Tm for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:31:59 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so45634615e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 08:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792078309; x=1792683109; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2wepqeZl6yO+KNjv9D1ICDYem6zBoxk5ZaIE8j8Xuv8=;
 b=LYUypGLtIihImXdMAluI90xc5e/19IgHsS73XyHlT2b7y2uw+OKNHLED07pO4DYnD3
 gXb+uNwxqPM3kaDigj3HWi9WJTGEUPtcRSlZkpo5tQtC+vRUGtkh9OZcz8h899sZEG6z
 GqfJx7Xf7In02GmAcrapl9yaxFKzAOvtaGMKWgbmViLQfIASzjXRHWMuVGAfb347Fhr8
 Y3iPMjhpQFRl2Iy4denv/TaB4nDwfZT8Avegtzxi3ZIUC6fCOS1egKngGW2Yc6eO1CQx
 KyP3R/bZ5uxX/ce9jUEojuXnI0ykFbcLpAESUD1AwrVN0R1ZWa9pmBfz8MCGTYFkhr7s
 hHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792078309; x=1792683109;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2wepqeZl6yO+KNjv9D1ICDYem6zBoxk5ZaIE8j8Xuv8=;
 b=ar+PWjlJgbu5d9cmx8a+K3r9LCUuZuldYWiGN7Y4JfapuRRJLeR4gugLxqk3lYw27M
 UfkOTFIGxa+th8ctOd4oW+lJuBFJHVL/Ef8d1uSm4XMDbLPyt1G7N9OFk4Q9Wpa03rSW
 CikcQDc6bi6qp4SQTtX8vClcRIX9zBvkGF+9XR0E/Yv7IE6WmqRfgny68DqTpDJjTG2J
 25y5T/ILRXAgjS4WKMtlI6CqpTBE/WNu0QuPrOfi6Gzqo4eY+iq9FMtP+Yeg0f7tSNcD
 3yKqmc44kbkDjHctJJivvRYENWZMqDO+90EKj87Iwh9sy15lxk1gP1lyH3v3GO3nBqlF
 TJdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBJF3+tEVaAq76Si1/mXWG2ZxvLm863lE0uu2wk6tWVLu/90tuXUBycbdJDkAR2oSop8aY2bDkQKYSS08C@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI0OFnLnRYNMZG1hO8KBJVVKNGg/4bvanVUUZJ9pJa9XsO80LMr
 F18RKBXQPgT347qVbTDsdNWeRamV+0ZlMR2PdpZ2FJ5a+loiRcDajBJ/wYwWaTrvvIXYB6Eh9ml
 iKgUrRRddcY8zg07UJpZJ+WVI5PwbX54w9U1VWWD2GB35UR8Qht1jyHwBhsXsmTd9G9dhTdMMno
 yVDiYFQQ==
X-Gm-Gg: AYBFou3uoa74/cYd2N+73p8HSLyQwBMQpdX13t269n+7VWWfMLFORu1SK9aO5vIhwIQ
 0tv7GDH8+36fkof2gLve9vG9lszwSJLzW2P/DWTHpJBzWVguUK+Y9eP/nVnfKUSsLym+PW6Qo1p
 C6KoTt0juYuj4CSNR5yDr+CpnX0im+1c6w5e11YDyDmDV5q4Okg5IC/Xlfc817ygCY5CWAMh2gf
 ZmaLK/1d27yq1OJNzZWXHGey6eUjEov1quptmCnsc7z3Ipb+4m5B+Ea6jawKSfaSt19Mm5McwMj
 bJIXvI8WaOcCqL+kY/Zon8sJyqk3o7p1/lxDPwOvcVo2adbgfPCr61+qs71ARwO+H/ok53uuzJe
 HlpPfL7EcYP3vAYxiMGBvEOlvkmtLDRatKSRBeDB9/3PUXYg2fYMDqm3W7C+Jl3NwEDT3lrzaVj
 Mh8STsfvHCcSdTOH0mVivntxl8A3ypPUnaNkf6YGMAgAiq2ltw+J29cqtx0OkhKHmFOOy4z0mXe
 G5BYQHm6PAYb+Pr7pyPGrcCGD+g3aP9/Qoqwj8plqtta2nLPZgBNxfNj0yJwvl90xfogjbIFda5
 4sLZXU3IqypPrK6QKg2qC+mXiyDkLjI5DlxkyB8lFBz+RJjCbxD0YZn4Y7Ah
X-Received: by 2002:a05:600c:3f18:b0:49f:fbad:29c1 with SMTP id
 5b1f17b1804b1-4a18e4cedfcmr369126055e9.33.1792078307969; 
 Thu, 15 Oct 2026 08:31:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd91c55bsm70453795e9.0.2026.10.15.08.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:31:47 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 15:31:46 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c4
X-Gerrit-Change-Number: 1966
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1966?usp=email>
X-Gerrit-Commit: 6d382d5e6932787f963d98293385cd691d8909b9
In-Reply-To: <gerrit.1790774523000.I76c310f9e69276d4f21a4ad31a24490553d6d5c4@gerrit.openvpn.net>
References: <gerrit.1790774523000.I76c310f9e69276d4f21a4ad31a24490553d6d5c4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzc0NTIzMDAwLkk3NmMzMTBmOWU2OTI3NmQ0ZjIxYTRhZDMxYTI0NDkwNTUzZDZkNWM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <70f15ee41a5eee45bbdeb17ce7dfd1d12314dfdf-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHNQx-00026a-Tm
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cppcheck: Review
 suppressions for constParameter and constParameterCa...
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8766638286594066993=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8766638286594066993==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C5fWex+nfZk="; charset=UTF-8

--C5fWex+nfZk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1966?usp=3Demail )

Change subject: cppcheck: Review suppressio=
ns for constParameter and constParameterCallback
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cppcheck: Review suppressions for con=
stParameter and constParameterCallback

I reviewed all the occurrences of t=
he two cppcheck
errors constParameter and constParameterCallback=2E

All of=
 constParameterCallback occurences were bogus and
I think in most cases the=
y will be=2E So continue to ignore
it completely but document that we consi=
dered it and it
is not useful=2E

All existing cases of constParameter were=
 bogus, but
there might be useful hits in the future so I only
suppress the=
 existing occurrences=2E

Change-Id: I76c310f9e69276d4f21a4ad31a24490553d6d=
5c4
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1966
Message-Id: <20261007172125=2E23573-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg39761=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppressions=2Exml
1 file changed, 20=
 insertions(+), 11 deletions(-)




diff --git a/dev-tools/cppcheck-suppres=
sions=2Exml b/dev-tools/cppcheck-suppressions=2Exml
index bd24c3b=2E=2E3333=
7cf 100644
--- a/dev-tools/cppcheck-suppressions=2Exml
+++ b/dev-tools/cppc=
heck-suppressions=2Exml
@@ -3,23 +3,20 @@
   <!-- We start with enable=3Dal=
l, but then suppress some issues that have too many
        occurences righ=
t now=2E They still should be fixed at some point -->
   <suppress>
-    <i=
d>constParameter</id>
-  </suppress>
-  <suppress>
-    <id>constParameterC=
allback</id>
-  </suppress>
-  <suppress>
     <id>unusedFunction</id>
   <=
/suppress>
   <suppress>
     <id>usleepCalled</id>
   </suppress>
-  <!-- =
We have a lot of library includes, not all of them are really required,
+  =
<!-- These are specific false-positives (FP) or ignored (IGN) issues
+     =
  We might want to move some of them to inline-suppression to avoid
+      =
 the static line-numbers -->
+  <!-- IGN: We have a lot of library includes=
, not all of them are really required,
        so ignore them -->
   <suppr=
ess>
     <id>missingIncludeSystem</id>
   </suppress>
-  <!-- cppcheck doe=
sn't understand about check_malloc_return, so these are
+  <!-- FP: cppchec=
k doesn't understand about check_malloc_return, so these are
        usuall=
y misleading -->
   <suppress>
     <id>nullPointerOutOfMemory</id>
@@ -27,=
9 +24,6 @@
   <suppress>
     <id>nullPointerArithmeticOutOfMemory</id>
   =
</suppress>
-  <!-- These are specific false-positives (FP) or ignored (IGN=
) issues
-       We might want to move some of them to inline-suppression t=
o avoid
-       the static line-numbers -->
   <!-- IGN: posix=2Ecfg: We ar=
e not threadsafe -->
   <suppress>
     <id>getgrnamCalled</id>
@@ -62,6 +5=
6,11 @@
     <id>badBitmaskCheck</id>
     <fileName>tests/unit_tests/openv=
pn/test_pkt=2Ec</fileName>
   </suppress>
+  <!-- FP: All occurrences are e=
ither external types or types that
+       explicitly need to be non-const =
in some variants of the callback -->
+  <suppress>
+    <id>constParameterC=
allback</id>
+  </suppress>
   <!-- IGN: we use casts to remove const -->
 =
  <suppress>
     <id>constParameterPointer</id>
@@ -74,6 +73,12 @@
     <f=
ileName>src/openvpn/buffer=2Ec</fileName>
     <symbolName>buf</symbolName>=

   </suppress>
+  <!-- FP: can't change the signature of wmain -->
+  <sup=
press>
+    <id>constParameter</id>
+    <fileName>src/openvpn/openvpn=2Ec<=
/fileName>
+    <symbolName>wargv</symbolName>
+  </suppress>
   <!-- IGN: =
external -->
   <suppress>
     <id>constParameterPointer</id>
@@ -81,6 +86=
,10 @@
   </suppress>
   <!-- IGN: too many false-positives due to stubs --=
>
   <suppress>
+    <id>constParameter</id>
+    <fileName>tests/unit_test=
s/openvpn*/test_*</fileName>
+  </suppress>
+  <suppress>
     <id>constPar=
ameterPointer</id>
     <fileName>tests/unit_tests/openvpn*/test_*</fileNam=
e>
   </suppress>

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1966?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7=
6c310f9e69276d4f21a4ad31a24490553d6d5c4
Gerrit-Change-Number: 1966
Gerrit-P=
atchSet: 7
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>

--C5fWex+nfZk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1966?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">cppcheck: Review suppressions for =
constParameter and constParameterCallback<br><br>I reviewed all the occurre=
nces of the two cppcheck<br>errors constParameter and constParameterCallbac=
k=2E<br><br>All of constParameterCallback occurences were bogus and<br>I th=
ink in most cases they will be=2E So continue to ignore<br>it completely bu=
t document that we considered it and it<br>is not useful=2E<br><br>All exis=
ting cases of constParameter were bogus, but<br>there might be useful hits =
in the future so I only<br>suppress the existing occurrences=2E<br><br>Chan=
ge-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c4<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1966<br>Message-Id: &lt;20261007172125=2E23573-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg39761=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cppcheck-suppressions=2Exml<br>1 =
file changed, 20 insertions(+), 11 deletions(-)<br><br></pre>
<pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=
=2Exml</span><br><span>index bd24c3b=2E=2E33337cf 100644</span><br><span>--=
- a/dev-tools/cppcheck-suppressions=2Exml</span><br><span>+++ b/dev-tools/c=
ppcheck-suppressions=2Exml</span><br><span>@@ -3,23 +3,20 @@</span><br><spa=
n>   &lt;!-- We start with enable=3Dall, but then suppress some issues that=
 have too many</span><br><span>        occurences right now=2E They still s=
hould be fixed at some point --&gt;</span><br><span>   &lt;suppress&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;id&gt;constParame=
ter&lt;/id&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/=
suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;sup=
press&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;id&g=
t;constParameterCallback&lt;/id&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  &lt;suppress&gt;</span><br><span>     &lt;id&gt;unusedFunctio=
n&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span>   &lt;su=
ppress&gt;</span><br><span>     &lt;id&gt;usleepCalled&lt;/id&gt;</span><br=
><span>   &lt;/suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  &lt;!-- We have a lot of library includes, not all of them are real=
ly required,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!=
-- These are specific false-positives (FP) or ignored (IGN) issues</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+       We might want to move=
 some of them to inline-suppression to avoid</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+       the static line-numbers --&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: We have a lot of =
library includes, not all of them are really required,</span><br><span>    =
    so ignore them --&gt;</span><br><span>   &lt;suppress&gt;</span><br><sp=
an>     &lt;id&gt;missingIncludeSystem&lt;/id&gt;</span><br><span>   &lt;/s=
uppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;!-- =
cppcheck doesn&#39;t understand about check_malloc_return, so these are</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: cppcheck =
doesn&#39;t understand about check_malloc_return, so these are</span><br><s=
pan>        usually misleading --&gt;</span><br><span>   &lt;suppress&gt;</=
span><br><span>     &lt;id&gt;nullPointerOutOfMemory&lt;/id&gt;</span><br><=
span>@@ -27,9 +24,6 @@</span><br><span>   &lt;suppress&gt;</span><br><span>=
     &lt;id&gt;nullPointerArithmeticOutOfMemory&lt;/id&gt;</span><br><span>=
   &lt;/suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 &lt;!-- These are specific false-positives (FP) or ignored (IGN) issues</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-       We might want to =
move some of them to inline-suppression to avoid</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-       the static line-numbers --&gt;</span><br>=
<span>   &lt;!-- IGN: posix=2Ecfg: We are not threadsafe --&gt;</span><br><=
span>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;getgrnamCalled&lt;/=
id&gt;</span><br><span>@@ -62,6 +56,11 @@</span><br><span>     &lt;id&gt;ba=
dBitmaskCheck&lt;/id&gt;</span><br><span>     &lt;fileName&gt;tests/unit_te=
sts/openvpn/test_pkt=2Ec&lt;/fileName&gt;</span><br><span>   &lt;/suppress&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: Al=
l occurrences are either external types or types that</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+       explicitly need to be non-const in=
 some variants of the callback --&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &lt;id&gt;constParameterCallback&lt;/id&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br>=
<span>   &lt;!-- IGN: we use casts to remove const --&gt;</span><br><span> =
  &lt;suppress&gt;</span><br><span>     &lt;id&gt;constParameterPointer&lt;=
/id&gt;</span><br><span>@@ -74,6 +73,12 @@</span><br><span>     &lt;fileNam=
e&gt;src/openvpn/buffer=2Ec&lt;/fileName&gt;</span><br><span>     &lt;symbo=
lName&gt;buf&lt;/symbolName&gt;</span><br><span>   &lt;/suppress&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: can&#39;t ch=
ange the signature of wmain --&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &lt;id&gt;constParameter&lt;/id&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/openvpn=
=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &lt;symbolName&gt;wargv&lt;/symbolName&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span>   &lt;!--=
 IGN: external --&gt;</span><br><span>   &lt;suppress&gt;</span><br><span> =
    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span>@@ -81,6 +86=
,10 @@</span><br><span>   &lt;/suppress&gt;</span><br><span>   &lt;!-- IGN:=
 too many false-positives due to stubs --&gt;</span><br><span>   &lt;suppre=
ss&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt=
;constParameter&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &lt;fileName&gt;tests/unit_tests/openvpn*/test_*&lt;/fileName&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;=
</span><br><span>     &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br>=
<span>     &lt;fileName&gt;tests/unit_tests/openvpn*/test_*&lt;/fileName&gt=
;</span><br><span>   &lt;/suppress&gt;</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966?usp=3Demail">chang=
e 1966</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I76c310f9e69276d4f21a4ad31a24490553d6d5c4 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1966 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--C5fWex+nfZk=--


--===============8766638286594066993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8766638286594066993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8766638286594066993==--

