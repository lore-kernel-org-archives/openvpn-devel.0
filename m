Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63229C5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aS++4dizf/JiB8xbfx1wKf6+bf/dspfqpKcDJfgEono=; b=VJGAtkQ9RUsvAXGi2AuUnz187+
	lzkd03DcmwGicAHd/zOl8w14uBqf26Lg5auUAhEA9X6YQqruN0VoK24hkMPsPZcOgh2SzeCnSNrnw
	op3u9MIsF9vcea/f39uIWs63wvY859DEsw/FAUQjooyfoJ2994zVvcq5so6ZAbQYCn0w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvwAU-00052y-Rw;
	Mon, 17 Aug 2026 12:10:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvwAT-00052n-E0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:10:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xgOVXmMCMdPFzwd5qm/mcRNoZ65LBixKDxmhppyUhhQ=; b=cLnr95q7K8DXRNCbeKxV8v/Pc1
 jODLmjzND1UYD3i+3jTBKw68JDST6OCByAIFpRctea9elFbKgLe+oHXXS/vBqANHlTX5zk42Hs4vW
 ljZx6iRByUdvRyhDqmYMxEa5hwhppT7LcHNWbZnei+eFCMhezonqDjkZ5UuoQxTk9rBQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xgOVXmMCMdPFzwd5qm/mcRNoZ65LBixKDxmhppyUhhQ=; b=A
 T1uhL+lex4MV90KOb6TRoCHVwzRRsy5P7g+a6MpWgWxPOEYamZOCjA4/9q0yMPbQDnLW69qKwh3DL
 Nfp5tNyOHd350FfIK19E3E1Yz9L/0Tsm+f0iE/HqkYf+OUr2skxNHEs583t513zMY2jZ8raqwi1oW
 SrK9TcC24Ui2ab4U=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvwAS-0005A1-ON for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:10:18 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so33458795e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786968610; x=1787573410; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xgOVXmMCMdPFzwd5qm/mcRNoZ65LBixKDxmhppyUhhQ=;
 b=B6z/Hwy4oUtIp9IXAa0IOkCErbbbATq+IcdmRuSVMgh4VDHbJ0K33qlLIHyZE5Zk/m
 oBGtfhUQ4vbNuwLUGlIkZoYJvr42mEQAKQFAwt0fn6/oznoJipAnAP581gUDM3bDlVVv
 HhS8tH+HYIQfgZ32+YAO9ZGLhwZn8prG8/hGiChIngAVPV7VpNWWAMKVajDeUNn2bIGJ
 +JkPoweS3zbMHE6XFJ9q5QrpGlk4pAZa5j5MH6Hi1RAd5rmYvD0VYOPev54wCj+b1Znq
 FR7sZ9XgMGLzLc3A+n8I3vy5DWnQ6MIS3OQYfpgNcsQWTSXEUKnhWZ1pTBPfpmUROkAK
 ogDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968610; x=1787573410;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xgOVXmMCMdPFzwd5qm/mcRNoZ65LBixKDxmhppyUhhQ=;
 b=UvLNX0aOqKd9+PeI5720/BznijeCeu8iW1vxchqxS+vBdSd+g75k1KxqeyeB6PwlB/
 oRGq0FH76IV4c+UIA07ivl1n8o+l+SgL+XcB7DyVn2c9BiUCp6SBhovPruiYIvnQFqg9
 kpgkBMUdEhkPxpeW0fLzy5uV+jZUeNNbQ9OK5H8sR/6qszZqdYNoTmXm7rBwvEuwYoOE
 TOU6VAquVYY9+FBZArg1xZ6vWuS5XDdoLy7kXVDGFOWXGq+k/dhLn/f7FnMB+aXDoFev
 dvQazZZkhA4bhglS+Mug+TRYIlhKJl3kvv2Qy5lT6/I/yMkbnGO+PnpUxdzlJXUEMIJw
 sa3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGFOUEDWJju7bDEmGi5X9lyD3Pw/YJ5KLjrsppGqsKdsqt/x2l8AIpFqSBnNvpAPWlGBZxX/vAPssTxnFW@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzHP7+pQ7XcR8YAeKzJFg/YTmBA7io79srYSNUbCnWnGBXeFypM
 hTpPiB2+9xR6CPg0OHXykpVSGJR5sxtP5HRyHF73ThQezG1DuycZecwyIfvgqOocwJ0ZkwP0S2n
 mtNltn7rf58fxj14cKSrPguvPfOE2rTE4u7UIbIFurMFe0Ue8kuzLFi4jfAjrAR+razEa
X-Gm-Gg: AR+sD116YpQ2Fiv1Kk0d0Ao4nmKd7YQ/rN1UlvVwdoGPmRNX1sUPi8/KGmljHziiz1o
 pZx6SQTwauvF9vNdZkExzfhHfm7RmOHZF52vPdXmA17rpEypu7MGGXOTfW4DMLgh7gMrNaVbpA5
 1KYOoSdRs/JYAg3Icg1h/EuGiF+4CkKlpvktzVF7vmxVnbj8sf2/eYY7vvhNVZQmThtwoHWD0/+
 HYwX6U7v9gKCr1+gnEEVyH6m1uZl840NH3eKuwyr6iPefRMh+xssNAyM5uh+ngMusVl60u4k1uq
 B6/uIsKV/0PLa7MOFjZ9FXk47sBQMH3Gk8zQSlP0VCr35ijN9rcuel/Zh8Q4LPnTjivZXv9t7ZY
 NMUy1NBbQjyiuyL6qzFOUN+K2M2HbPsdQ1GEsioqQO8VS47sq0hYvORo4vWB7zIu0KuIPNTWCk4
 n2D5vCUzKvXb6+2/CqRxaRwvUJ1P9Dn+X1hr/2Rj43FaybCWQrwIeFCa4HcYw09uWFxxssbKomF
 jC3AZq2BfKjFx/qGm/1pIyPc7zzymKzOysPdCjoCxxNbprIlCvL9nRRpT22eddI30EO9EknMJVb
 mBEgCn++mqiRW7HuoDTcfV3wxhqu9Yix/3QbfKwlfewpAS31k7+IFSEXLEB9NQ==
X-Received: by 2002:a05:600c:a45:b0:499:5b04:6920 with SMTP id
 5b1f17b1804b1-49987990f37mr356301575e9.16.1786968608966; 
 Mon, 17 Aug 2026 05:10:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b896sm3464169f8f.16.2026.08.17.05.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:10:07 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:10:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
X-Gerrit-Change-Number: 1774
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1774?usp=email>
X-Gerrit-Commit: e63a56cc61447adbed04e4059e7f16c3eeb690ff
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 12:10:05 +0000
In-Reply-To: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ZGFmYWI3NGI4MmZiZjc3MGMxNzk4YjQ4NTFhMGZkNWU0YjVkODFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ca1728b04dd98bc07250d469f19e1adc7aae5235-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvwAS-0005A1-ON
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 file access code from options.c
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3932191599106129475=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3932191599106129475==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F3XhjMcnQqc="; charset=UTF-8

--F3XhjMcnQqc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1774?usp=3Demail )

Change subject: options: Factor o=
ut file access code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/chec=
k_file_access=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774/comment/=
de1e2a99_7a7572a9?usp=3Demail :
PS2, Line 25: 
> Should this header also do=
: [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1774?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
Gerrit-Change-Number: 1774
Gerrit=
-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Mon, 17 Aug 20=
26 12:10:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-=
Reply-To: razvanc <razvanc@mailbox=2Eorg>

--F3XhjMcnQqc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/check_file_access=2Eh:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1774/comment/de1e2a99_7a7572a9?usp=3Demail">Patch Set #2, Line =
25:</a> <code style=3D"font-family:monospace,monospace"></code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">Should this header also do: [=E2=80=A6]</blockquote></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1774?usp=3Demail">change 1774</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1774?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d=
81e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1774 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Mon, 17 Aug 2026 12:10:05 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--F3XhjMcnQqc=--


--===============3932191599106129475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3932191599106129475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3932191599106129475==--

