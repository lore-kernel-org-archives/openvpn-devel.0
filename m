Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4067C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0WaJTHchq1setmEDkWAFceXa3Mb1ORI21bIpvuJd7Po=; b=A6XKDAyJLm2XXpqveypWZFG+Tq
	7AaNQZ5PE+O8hHDQX94ENGcHSyX7Mz9r78OIjvPZcSEEW2DLD6g9gmP4b4Ezxm7zRC+2qgqs3ziP5
	OHJsiLXlP0n7/WpH04cydvVDDmezMXRG7p/c7j91dwfjSThBWFsMgfNEfLFyaKfH6bu8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnJDJ-0008BQ-2K;
	Fri, 24 Jul 2026 16:57:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnJDB-0008Ao-8S
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:57:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lBHy6MqHn2DSnxnXOXchjCeH80ijIQN7/XXuq8dJfTY=; b=HNqJ9sFJBuokkN+qdne16OaaBQ
 6qaGQI7VBvAQK4nxvxyOU0Kcw6hAx3nhVT1aJu6JsGuMRPRjmdgGw5XWA4q0AzjiUTBf9RTfclTc0
 kGG7Bb8Y+0Ktd/F7cwMIo01Tgz+BZiXwnC7LU82BmqfQmEKbrRF1aMa6rx+jrPUpcyG0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lBHy6MqHn2DSnxnXOXchjCeH80ijIQN7/XXuq8dJfTY=; b=G
 giHkug8/6GPMOTT6fkyqvcjKxpds517EnHEg2EGZjGLSq6LtiXGiV0TkytArd13uHYN2nUn+DGVAq
 MBoLHXYGcpUOryv9cA5XT6Hd811cMc9SMaN8urgpSLGNAcQkuTsGRKJhyHQBDmx1nUX2LGGCcw7m8
 /maDQsFt2Ys2UMzk=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnJDB-00036l-Dr for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:57:25 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so9440505e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784912239; x=1785517039; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lBHy6MqHn2DSnxnXOXchjCeH80ijIQN7/XXuq8dJfTY=;
 b=FzeK/rOp0IPb4BciyztcRLDOBmcKtDlzrSlWVl67sJzFowB3zevuO99HqJC1KbP/1z
 Aa/Cm54IysVN20H9274iE0yehqYB9FYqqVhUP8kK29vmUFet6GY7UfTSjYaYwXK8mQD+
 kTfSS0Q8thdTti/HsFShDiPxTfCrvzI6tRby+X4uGyO2fTZ3K18QTkU9vKFeNc1w9+NP
 UjuFxZz5p5yV8o+hqNbN4UG7zkI6EUyEOfPdhvW+iRp0guZ0/sgHiXZ9HauW8H+WdoOH
 acB+6w4vgYhks/j2WptvGmvO4+05clg5qqLPcL9PZNUa95RO4pRC/IaSxjasdmIMg7Gq
 hnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784912239; x=1785517039;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lBHy6MqHn2DSnxnXOXchjCeH80ijIQN7/XXuq8dJfTY=;
 b=I2v06Bt/Z+ACiiT0qBuM+WauMuEsAIhC5kBT3OOtwSa0HKTBCVekL0bP7cSKuX52jA
 jzvYydxG9OybW3weeD8C/e1RDCw5yF2BBEw2ZclVuyIAyqU43+K/ga+GZSvjftgHnbCV
 8KwKAWP7uoVUYRkXrvEwqouzXbqlzIXwOpNtytfAo4Rwi84Vi6gJd8S0MsIWMBaeh4aO
 fpiKmBPvKDZD7FRwyjHjfMRwft5X0X+qplzlkwsJaYpTuQc52zUD4ZzLX1YYwvevdE5n
 7uaMx7fgbQMx32K89EDN411WFH1GZ3XcgTCE4LsA2Q+sw8uuw1hMu4nY/lUzTuznVefS
 /kVQ==
X-Gm-Message-State: AOJu0YwCNud2rKXVu0Iya2a69eYtbQ2utTZfs3/phmq4ooS+9a8S2Rcc
 bbJdYR9MlTXjMPTS20JIw1hyu3gjPZSAcy8WDtYyeG6o+LW21K7/td8X1a7XcPDMPCdqkI2aOFx
 uj5+TnV/WflFX3Bg7tb+FjyVsBiTzY2cmErEr0DRrl9zZnlt1JfWN0wzD4kXlgYDTfzYT1axrvO
 j4gmfXuA==
X-Gm-Gg: AR+sD11BhYw64af9SuaMgW082vzQe/ooHoujxMRqdH3cApQQgUZXc/qbeQ39pKm5Dvj
 uxuL0YbFf73B5SssU0F965eb2Lrj2pHa1Eu7kmQwP/mxmqhmbg3CYGAQlOPR0IOiUmdrgVsqA1A
 gzjHyQFkGZrhWVdJ4DBhbdtUiGWQwrTwsdVCboza+pCW2ZL1XPEE0WdyJuKQ3HloEzgpmiD0Vzm
 TZ9GMnA/1tQ3+c8AP+ynjwpQlv+KBi+x4CNJbBdX8PQIB5yYY5UaF5AKar/dpEKApcrbUir+Zon
 ZLqIFHm+z1yml9ytYSdwBAYC4bR4gUIRfewUvzq3pBGxnnbALNM+wA1qEO+AuTSbc1l3tJRYGYk
 COPIMTWRaDr0kVi54CO4EaH5AC1CmUBajFTngZ2+2F54b/oQ4O5ghudGeAdtcDaDue4hnpMG8qN
 naH3Cyj3+KC69fVzRYc/GPYpA37ZxCMNwXlOMUQSez9wnuk8rp7n3zgiGxTYdIm922wDk4VjCUX
 RodqhEqcP8Ose9YuWMdJ+UHF3I38ZqA43WxA3j0y1JovatjfbDkJEMtoZipc0SS4i93
X-Received: by 2002:a05:600c:3114:b0:495:3bc6:d381 with SMTP id
 5b1f17b1804b1-49699716838mr20601145e9.2.1784912238746; 
 Fri, 24 Jul 2026 09:57:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4c8d6b5sm760895e9.2.2026.07.24.09.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:57:18 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:57:17 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibea20c0f2c3df9f1f6509d662ab2b5fb4ce5e18d
X-Gerrit-Change-Number: 1531
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1531?usp=email>
X-Gerrit-Commit: 1056b69289db0a8464ea8b7a14009cee1d01611d
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 16:57:17 +0000
In-Reply-To: <gerrit.1771250081000.Ibea20c0f2c3df9f1f6509d662ab2b5fb4ce5e18d@gerrit.openvpn.net>
References: <gerrit.1771250081000.Ibea20c0f2c3df9f1f6509d662ab2b5fb4ce5e18d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcxMjUwMDgxMDAwLkliZWEyMGMwZjJjM2RmOWYxZjY1MDlkNjYyYWIyYjVmYjRjZTVlMThkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <81db64c840e263f6e8ce43ac37f369a993f7c389-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnJDB-00036l-Dr
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: management:
 resync timer on bytecount interval change
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1821607942464412714=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1821607942464412714==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HeS+w0MIaNE="; charset=UTF-8

--HeS+w0MIaNE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici=2E

plaisthos has posted co=
mments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1531?usp=3Demail )

Change subject: management: resync timer on byte=
count interval change
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/manage=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1531/comment/89b44519_1aac559c?usp=3Dem=
ail :
PS1, Line 494:     if (man->persist=2Ecallback=2Earg)
All the other u=
ses of man->persist=2Ecallback=2Earg seem to just use that without check=2E=
 Any reason that we need to check it here?



-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1531?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: r=
elease/2=2E6
Gerrit-Change-Id: Ibea20c0f2c3df9f1f6509d662ab2b5fb4ce5e18d
Ge=
rrit-Change-Number: 1531
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@m=
andelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Fri, 24 Jul 20=
26 16:57:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--HeS+w0MIaNE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ralf_lici=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1531?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/manage=2Ec:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1531/com=
ment/89b44519_1aac559c?usp=3Demail">Patch Set #1, Line 494:</a> <code style=
=3D"font-family:monospace,monospace">    if (man-&gt;persist=2Ecallback=2Ea=
rg)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">All the other uses of man-&gt;persist=2Ecallback=2Earg seem =
to just use that without check=2E Any reason that we need to check it here?=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1531?usp=3Demail">change 1531</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1531?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E6 </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibea20c0f2c3df9f1f6509d=
662ab2b5fb4ce5e18d </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1531 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 24 Jul 2026 =
16:57:17 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></=
html>
--HeS+w0MIaNE=--


--===============1821607942464412714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1821607942464412714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1821607942464412714==--

