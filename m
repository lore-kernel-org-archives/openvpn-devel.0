Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E22EC5CFDB
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9kPTsYQFfDlnSkuQdLwwS5VIwzLznZ324zA/+7r+vA4=; b=if9qmhCn2NZACjQbtxJ8UiMZ+I
	Bg2XS/cNSgRY3qgt8qlRFtYwAwOH8Tt5pqkekzcEGAa790BYeiiSrdXf6jkQo++TBCNFRK+woW/HW
	6V7DeB3kYMbeNwJgayUtXig7wPzJweG6r7XvznO6kZQ/Ww+gBCqAad6DlFFD72SulY68=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wus37-0006uv-CD;
	Fri, 14 Aug 2026 13:34:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wus35-0006ue-I6
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 13:34:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tbhYkCisAL1rtdhA8JT2LnjwMyK/JFamRvW/3J3S5Rk=; b=RQtf3Lk/TpSggqYe8dxCq+GHct
 oHw/B3jXiWWcuhX+1vO6DU8AlWjZ1B/kt2AN9fx5skJHaeVBGGKqMupeDYvsdLYNrsaxIueGJ4l6Z
 JBZiswbF8Yr51jiuUO+u2FQVaNgDhbpPnPeC4NeJnXHj8eQgr7iBbo6KlMrnOqBi004k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tbhYkCisAL1rtdhA8JT2LnjwMyK/JFamRvW/3J3S5Rk=; b=X
 HdsvDHuCKnkH7Gw+E+A7UCU2XcFTajbmBgm2pzlyL1IYB6H3GSZi8bjuL69vf6cVvwVaAslthjF6B
 68U29oheyLcSF4dwjVXItgsBlW6cdcEJPGSyXeaXKS19QSbvpKeA0DhJceWwbQjPY2F1bRIqjOexu
 y079kxOJiJHQts40=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wus38-0000ln-EM for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 13:34:16 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so13997795e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786714448; x=1787319248; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tbhYkCisAL1rtdhA8JT2LnjwMyK/JFamRvW/3J3S5Rk=;
 b=STqFrxsrHOnAsR3YqOd5C6YsIjjb4gZD4qM1ry7979wMFXeL9DxoXQIy/o+Wl60Qb1
 eiEcSl70jShQ6m7Fcymp8lEAkU/83BauC4jVzhztbiI9JHVzTkXWL7wcPM4NzUhJNK5y
 +qgnl4rllSVlVv6vKcO4DqZkExTcWVc5ILL4nwidWEU9CMWHaDBjaICILPPIt62ErqrL
 G8vG2jz6Dp4Wn7pDoXbEReKBc9T7mwmzQfSoNBreR/zOnu6s23NLlfIvTsUIwxpQbkN2
 lTMEjoHGNGGUyctHSrYZuYVDwCx1zQvJpmuNxZujSXEKp3FnJT0HXBNo8C5aEz1UjWaA
 JyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786714448; x=1787319248;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tbhYkCisAL1rtdhA8JT2LnjwMyK/JFamRvW/3J3S5Rk=;
 b=WDrDIGp0yojaeNRHXu6eiodEI1hmmxpCpSCymNW5pcFFN+KuN06j9Qgj3F+vef104c
 ch+8146vZF2YMeOnZln5UyPt8oNPuJUMQssCNH7sn/IwgLTkKrC8PEY5afG9LvoW9c/v
 AfQsJ/Inq3lIsAEzRE9+XKwN2z4uXzRc8mGtoAFyHCWOgwFXVXTCdAMwwvt1LDmLqD6f
 L63odqRERZyuXzqrHwUz+DbJfih6GSJs+OcrMwHCvbDkBbjUEvkBXUyAZZn7nXIWNSpr
 O7C3llvcO3YStY9FLLNTzFAQywcvHZQk99BbnA3GpPUEgchi038pJ8TAMJbIxcV+GqjV
 56jA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoemQgCao12q/EM0rhkgQGfnDQdxVtr6QGE0SLSU2c4rg6Kgx9iURh4hW6jXC7ROG5EzT+Uc40RLFCH+YcH@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzNlZll3xAkKStIXatxMpp213/U/dZZV2dz69YT+3ayg2vue7U5
 yuYXhDtoz2PMJ8CQ+kcGN7wfhLLUPNuV4iWkfv+0o5pm2bagjaDlf/5cjEfupG96u/NoNzcsY8k
 9m2V+eEK6FxMqq++A8IqVMzNK9SbPCTA0j8yIORABMLIvv2uJ/8bsvMFzI9Kvr29QweG2
X-Gm-Gg: AR+sD13Z7hCFvRpnZPz9RRDVaQ1ZwE1/8w7vEVEUnZXt38SXrCQ2/crxGJiwl/fN9Z2
 V5UMCZeev/E4DqLQ2IuV/fp92fAbe/w/UKrH/S4Ys/cpXr3B7L2PAFwgZO0PsGA7x01Ev8qTqsR
 CM+oyhPk+vFjJz6FvHlhn+p8lGkBIl9e21gmdXc1Tg3d0rFW7hcFPm54Bi7Kz3jjBO6sklXgHwW
 XcGrg6IpR96uWn54/z1Um4xS59yerywg1s3a89p9Aq9ynHluSgTgvu/hNJN0j7MyjsR9hFYncpF
 1NqFJsLE5EY9VdH1oJ3+basWtbttVNxwpVe3yrgHf6g+b8NkOY0JLfj4B6ImPn0XgpPLT1oEKyl
 8FVdtaP6dRU8JLRR+wntjg3C7iFT+d+Ppkr9tKJvtvq4FHpl7ltuNp1Rfn78DjP4yUkEwAQQeM+
 447ezpd5zkxOjHA+/RZfdcTxslEfr5OyNLyYDdTNK18w3tWPs1KzUIveKFkRZ8GywIzlJnmDLdF
 1hHR+ARKWa0B0b4y69GkHiCR/ZeyxY6eDVDvfLvzOOtEfZ9wiWPI1XG0ffAsKn9by92osn6tDhx
 qQADPIAVPFTyCP/6S9W5qHhhzws2pqiVRGjoRUVstuHLU8zOGPk=
X-Received: by 2002:a05:600c:a45:b0:499:48be:3189 with SMTP id
 5b1f17b1804b1-499878ccebcmr73841425e9.0.1786714448169; 
 Fri, 14 Aug 2026 06:34:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b24746sm89346225e9.12.2026.08.14.06.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:34:07 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 13:34:06 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
X-Gerrit-Change-Number: 1618
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1618?usp=email>
X-Gerrit-Commit: ed759afec30cf6e1ce9c06af92679a17afdc89f1
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 13:34:06 +0000
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLkk1MjhmNWZkMjAwZDg3Nzg0MWU0NzNlNWUwNWI3YWM3OTE1ZmEyZTMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <428e34a15b6e0303b8d8f992cebdeb2264219265-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wus38-0000ln-EM
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename variables
 that shadow other variables or functions
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
Content-Type: multipart/mixed; boundary="===============4261547675450203872=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4261547675450203872==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZjAJZlwtM8Q="; charset=UTF-8

--ZjAJZlwtM8Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1618?usp=3Demail )

Change subject: Rename variables =
that shadow other variables or functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13:

(1 comment)

File tests/unit_t=
ests/openvpn/test_dhcp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618=
/comment/337dfaf8_96106acb?usp=3Demail :
PS13, Line 58:     struct buffer c=
lean_buf =3D alloc_buf_gc(512, &gc);
> clear_buf vs=2E [=E2=80=A6]
I assume=
 I wasn't that worried due to clear_buf() being a function=2E



-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7=
915fa2e33
Gerrit-Change-Number: 1618
Gerrit-PatchSet: 13
Gerrit-Owner: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Comment-Date: Fri, 14 Aug 2026 13:34:06 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailb=
ox=2Eorg>

--ZjAJZlwtM8Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File tests/unit_tests/openvpn/test_dhcp=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1618/comment/337dfaf8_96106acb?usp=3Demail">Patch Set #1=
3, Line 58:</a> <code style=3D"font-family:monospace,monospace">    struct =
buffer clean_buf =3D alloc_buf_gc(512, &amp;gc);</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">clea=
r_buf vs=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">I assume I wasn&#39;t that worried=
 due to clear_buf() being a function=2E</p></li></ul></li></ul><p>To view, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail=
">change 1618</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/161=
8?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1618 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Aug 2026 13:3=
4:06 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"=
display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>

</body></html>
--ZjAJZlwtM8Q=--


--===============4261547675450203872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4261547675450203872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4261547675450203872==--

