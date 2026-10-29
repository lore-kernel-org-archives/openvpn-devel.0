Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F9606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TqVFQCOm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aQlTtrpX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RgHKf26H;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MUZ1HQZN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=H9azKe8629ZyjXsMdbxUPlW6uLFu+ptKGaHhfJaKpro=; b=TqVFQCOmtfUAV6O2P1S9FPPi5U
	N1XDkOv6TOrqjCk2WGZaxndJc3r9WDNAOpWwqzLb/HhodnyVt2aV9fkymOHry72fX/iWVDVjXQUHm
	fYiquoeAR+PL1AJMkWfdCfsvAAnpHOXaEdLC++MsIt/gnuo+YPgOTeUE0AXLU2ETWzM4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMUxs-000000001ns-0Byx;
	Thu, 29 Oct 2026 18:35:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMUxa-000000001mh-09TX
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 18:34:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jb8+ydOT1fLSj9AThgulC7qzlfi0T5ltbiSAx2/lVxQ=; b=aQlTtrpXhlYnhVMxUvhEYfHhwM
 t8pttpuZL2aAOrS0V1A7p7QL5S2UE7RZVK5CAmG8CzP9HDN1dvnC7nGeOEFvNRxwKnjbupQyHem4O
 VPM95rEvQF53Ih3FtZksbL0Y5S+nYTm3zU8AAUwvsDhG5Z/w/5grWkPg0sgg2NPXWt9E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jb8+ydOT1fLSj9AThgulC7qzlfi0T5ltbiSAx2/lVxQ=; b=RgHKf26HRA96sXS4dSEVfPwvHh
 y1ZOsnsNaN39ULPuZMgyleATNhGUKvPJlJqF46P26+n+SyHH2BNaAcsQUvXPxGN0HViLDXbPiQ5VR
 GmQMjhcwVDKRvyp0msfpDGU7NfCNfk12LCJ+b9pTI96SAZxLoduAwAgitygqGFiQhyZo=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMUxP-000000002xT-3Fc4 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 18:34:37 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso23005775e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793298869; x=1793903669; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jb8+ydOT1fLSj9AThgulC7qzlfi0T5ltbiSAx2/lVxQ=;
 b=MUZ1HQZNSQYzVznr+CO1Du+c21BuvWAID3vT7XqZ3q2Eq9qFP9Nu55Fx25lwrxthUi
 SnVhgxY0H9vy5puLppeOujSHW9FnpYp7BR4y5dMUEt6gD9ov6KB81UJOAdKtuvsoSyQr
 jTDESmaLt966owsKhMJMLouseN9QOpFE1eYUXE5spoFaHsqDfhbHQrT/U4cYC36UY9cd
 R2YURTS0iaGlFC/gJXvIWfcXYcuKmnH/6QzwVSztnWLcLHveAsgpV3QwLZYDhjT15Grp
 sujshGNtmkZR069QYAsffnVDPPCGinU0YQjSIQkIvJ4Fzyq+wV7T0iN8YU+aKnoh5DyS
 ZAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793298869; x=1793903669;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jb8+ydOT1fLSj9AThgulC7qzlfi0T5ltbiSAx2/lVxQ=;
 b=NJNQb+xN0A5YB2REbjB8jQ0X9s+pA/Q6yCWnNZlffXbedJTEXvKq3XToFnrscT+GFV
 8L82raYB7IASk7J0v9chVchDoQa3ouNHuq/bomNFAul9BAy3+sRfy0ZqojfqCuBgPFxv
 2UTjUlotXLUwz3IVqvMs662hF1HaM94O+jYhHcSNObuxjYxKcvXHSpT/VBJZA+D6c0Ii
 5KSkGKWga8EacO0ag6SKZGL3XvAIWxkAtKD+NZISBrO4JxAWTJPTnX09tdltjqJx4Kx0
 4GE2n7fjF4iJQv6VppgBxVsIQIxtHqSubkQvb+5BnGgzV0Du9Aj8YE5Kf5D5Yb+bblrD
 GY5g==
X-Gm-Message-State: AFq9FYLllN823njH8ooD2hjEuKzhYfMxFU0NI2E3+7TU583blW7KdUTO
 WPAvZL4dvyIg8f/eZ8rR/VPXQeVpTd77uyWY16GNDlEDpbMFt5vg3qGcShnb8aAF1OjxqNSfj5x
 zNnyHv8sSO2PlYSD+n82yhhmN4Jg4wMHdRRrHWpv2TDeBu/BjIniLmhdAnBV/alL0dnYD4noyfK
 arUmAp3A==
X-Gm-Gg: AYBFou1QLFVGQ/mdFXqZsAGiGpWAAq/3AlDbE/9Xh1l8JHwidglya1hQ/Dp/cMkRenv
 Ko5hNtKmARZzVGmCnQELIsPlmvLQmAUvUa0uH4cw5ZEk/jAZ0hpLoy+im0B1EPKpkUaJnB6ZRk/
 whveIfChcliIJb3sm2e9o/FlRew5hEqQ3bEyt070BG8Ld0pdRRmTFhs9XWn2xpIJMDMbWOcBDe3
 o41axwxGK9vVuu4Gx3ve3UJKfs4HvapKR4FldBaNHvImugZaMbcax5KNqDcoU0yQev+abDZ6Y8+
 Nbdcmi8NQ1+7SKvbp9eQ3R4/fW/BWXJLIB3f7KJAih7c5807vGdfFLxUsF7pQrsmeHKuTP9htRy
 p04RjAsRrrsfbbOgNEu+/AOhnQs3EdaWa5TxcIBsPFmDYFi6V0Nbj06RtIArHRflOr2k79u1Sst
 NkJ9G8e4eTAaY/StY5lLxiv+5rK4hVegoQaOso7K7ZCTjZWQrYIm+t+W0VkgHrl39KhFUxI51un
 UK8xQRLaAkMaVQzpNF5nLrpgJiAfVNCZZ4R+0zTMvUp6E9f4ZnjFfX5Gwbz3f9UnGplQdZPLWFU
 fGqthGPT/egMGHWbDc9512W1VMTtkkzNMyG+YbnmqtG1fwSSVQrEFFNmTBqhX7J2j8cPioTPhur
 b8WJvHLAzx90bSyBuyJR3dtaZ7AkDil0bQcYkIDqrg6Nx40m7lmmg3Xd9rTYlBgN3DWJIymaF+0
 uG1IKZT51eq321Lc4=
X-Received: by 2002:a05:600c:1387:b0:4a3:5aea:21e5 with SMTP id
 5b1f17b1804b1-4a96667bb17mr142425095e9.9.1793298868934; 
 Thu, 29 Oct 2026 11:34:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6eb7383dsm115153f8f.11.2026.10.29.11.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 11:34:28 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 18:34:28 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5aa1a838afa924df292e630efb173c3b1dc5b407
X-Gerrit-Change-Number: 2072
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2072?usp=email>
X-Gerrit-Commit: f43f954d3f38a0a6cbe8b2675be8d5532a726e7a
References: <gerrit.1793298866000.I5aa1a838afa924df292e630efb173c3b1dc5b407@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjk4ODY2MDAwLkk1YWExYTgzOGFmYTkyNGRmMjkyZTYzMGVmYjE3M2MzYjFkYzViNDA3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3a08ac3867cbd3f7fedd7d1943634fa4241802ff-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMUxP-000000002xT-3Fc4
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: cmake: don't prefix
 the event message DLL with lib
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3442269391550659647=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3442269391550659647==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZZdmEbQ9FgU="; charset=UTF-8

--ZZdmEbQ9FgU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2072?usp=3Demail

to review the following change=2E
=


Change subject: cmake: don't prefix the event message DLL with lib
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cmake: don't prefix=
 the event message DLL with lib

MinGW builds named the DLL libopenvpnservm=
sg=2Edll, while the event log
expects openvpnservmsg=2Edll=2E

Change-Id: I=
5aa1a838afa924df292e630efb173c3b1dc5b407
Signed-off-by: Heiko Hund <heiko@i=
st=2Eeigentlich=2Enet>
---
M src/openvpnserv/CMakeLists=2Etxt
1 file change=
d, 2 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/72/2072/1

diff --git a/src/openvpnserv/CMakeL=
ists=2Etxt b/src/openvpnserv/CMakeLists=2Etxt
index 2cc4a93=2E=2E35f1efe 10=
0644
--- a/src/openvpnserv/CMakeLists=2Etxt
+++ b/src/openvpnserv/CMakeList=
s=2Etxt
@@ -69,7 +69,8 @@
 if (MSVC)
     set_target_properties(openvpnserv=
msg PROPERTIES LINK_FLAGS "/NOENTRY")
 else()
-    set_target_properties(op=
envpnservmsg PROPERTIES LINKER_LANGUAGE C OUTPUT_NAME "openvpnservmsg")
+  =
  set_target_properties(openvpnservmsg PROPERTIES LINKER_LANGUAGE C OUTPUT_=
NAME "openvpnservmsg"
+                                                   P=
REFIX "")
     target_link_options(openvpnservmsg PRIVATE
         -Wl,--en=
try=3D0
         -nostdlib

-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2072?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I5aa1a838afa924df292e630efb173c3b1dc5b407
Gerrit-Change-Number: 2=
072
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>

--ZZdmEbQ9FgU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2072?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">cmake: don&#39;t prefix the event message DLL with lib<br><br>Min=
GW builds named the DLL libopenvpnservmsg=2Edll, while the event log<br>exp=
ects openvpnservmsg=2Edll=2E<br><br>Change-Id: I5aa1a838afa924df292e630efb1=
73c3b1dc5b407<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet=
&gt;<br>---<br>M src/openvpnserv/CMakeLists=2Etxt<br>1 file changed, 2 inse=
rtions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/72/2072/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpnserv/CMakeLists=2Etxt b/src/openvpnserv/CMakeLists=2Etxt</span><=
br><span>index 2cc4a93=2E=2E35f1efe 100644</span><br><span>--- a/src/openvp=
nserv/CMakeLists=2Etxt</span><br><span>+++ b/src/openvpnserv/CMakeLists=2Et=
xt</span><br><span>@@ -69,7 +69,8 @@</span><br><span> if (MSVC)</span><br><=
span>     set_target_properties(openvpnservmsg PROPERTIES LINK_FLAGS &quot;=
/NOENTRY&quot;)</span><br><span> else()</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    set_target_properties(openvpnservmsg PROPERTIES LINKE=
R_LANGUAGE C OUTPUT_NAME &quot;openvpnservmsg&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    set_target_properties(openvpnservmsg =
PROPERTIES LINKER_LANGUAGE C OUTPUT_NAME &quot;openvpnservmsg&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
                        PREFIX &quot;&quot;)</span><br><span>     target_li=
nk_options(openvpnservmsg PRIVATE</span><br><span>         -Wl,--entry=3D0<=
/span><br><span>         -nostdlib</span><br></pre><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072?usp=3Demail">change 20=
72</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I5aa1a838afa924df292e630efb173c3b1dc5b407 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2072 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund=
 &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ZZdmEbQ9FgU=--


--===============3442269391550659647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3442269391550659647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3442269391550659647==--

