Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79275C88E45
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=80tJKQNw9JatDsP63ec+31dEzlGJIyoUbVIv6Zijb20=; b=W3No/C0IXzBuhj4EjGYzlxPJIU
	OxQBeYi9/LEsXGEC0MPacBEgT3PmxZMOOMh8vRQ7Mgm856dTnKH0IGaBtR9DJDHgps53BXP/bC96o
	6EIKWATtkuNyO0KiyDFuIhpcjAGH1g5OIuVRTPhLeavS6mAScfkPlfWAPUpN9TL+Lj+s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x52zp-00085e-El;
	Fri, 11 Sep 2026 15:16:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x52zE-00083w-Kz
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:16:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GiSblNj0pIF9AXj2DQQSZUAIViY9jQjAE2D+Cbfm1TQ=; b=B+uXTABzCVQ9VHsvsqkpefCKZt
 YiJKOlwm3EaJ73yZeJ86/4jsNlO8OygYOPfDv1RgYnGCzyCPx3Ejr0zOJPeiLp5hxpZXGYDQA2841
 16sq3JyXtNd0QMe5y6kh0XOfJOAJ9rxj3UK0L1ALwjaMCCTq7UH43Ew9tl+0oqMHBIsY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GiSblNj0pIF9AXj2DQQSZUAIViY9jQjAE2D+Cbfm1TQ=; b=C
 BYW/XfMbnFN/zjEixJOscSE59yM+kSmSIHUdt6MuaBQqSpXHtUbh/BAh+OkCb2il750Cssx9njMn1
 ndPLtafAHHDLK9szw1fMgmFksxfVa/Jl/fyhPqBsX4eTwrMQ6VOat7eur5wH6aCfURXXHg6Z0z8AI
 P2R+OkfV5B2Ui21g=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x52zE-0007Nx-Ie for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:16:21 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-495437bb891so5058255e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789139774; x=1789744574; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GiSblNj0pIF9AXj2DQQSZUAIViY9jQjAE2D+Cbfm1TQ=;
 b=G5QIS4E3aab848GmnJ/m4mQOif/+JiADdbQUDxzbLZc6kzHQ5usRjA9EabcX9FkXKU
 Z0IV0smdUR3HihpQ6TzKclqZpsrZuurMcxnexfdSInCS1oUyzNaDY05h+UOuRSOUG/Dl
 yIEzXfm8jr0XpYC0yWZja7b/abFr89JJEbq1xO465JThotkzcdGLB3aTLxthM+NWNoET
 nVWXzM7rsjAn7WsB8NEwczzlJfA0els0pzVvCfpZXmyI0fiSlQ888cUQPQlwcZFEXyie
 +Uls2yjK8DLhXUOpDig8BdTSY2ASjI8+fRUVIhx0LftuoHaLgLk6u/kAQYxrX/nHtitj
 euPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789139774; x=1789744574;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GiSblNj0pIF9AXj2DQQSZUAIViY9jQjAE2D+Cbfm1TQ=;
 b=gMVBPR5PZEfLhvG/KyDtRyZpv+JebuF13tEB04WH1SmQEvTk3bi5LuVJwYQ5JhfpsQ
 2ICUE4z54bENXiDIUqceHQ4tvcZc7Y0stwbNf4vDV8NQ9YOLpHgtKDFSRnJmA+A6gkBa
 A1b+EvBccjUPaNJEd4y07rrjvlPh9XNf5C1XJOK3myucPRC5IAhruh6EWjFIEOmNITV9
 CKiQLx5LGhhpdpS6zvCMMNjMW+aQDW3pvHRPtyh1DXoCUpbQcTrfrf9VZN6mEoUTV44V
 CfXpHrjKatuCYEEJJFhOgMm5IrHCdabwwRMLKPOdf8iqSbvbFW7bTAwWDgPvpjpLp7sJ
 QLcw==
X-Forwarded-Encrypted: i=1;
 AKwUvByBZiVv0D+YiemvETwVzO1znvxWTEVmt3ECMo3B4MWzebLN7dPgQ/1naXTSbry/1x2vCp3VkUMQ0kX0e1VM@lists.sourceforge.net
X-Gm-Message-State: AFuF++lSZT2v10UaMiMT1ozmP2Qa1lxJor65t9gPvQISkOPN5ggd6Xnu
 m4OaiqPURmngDVqO167ozFmgfyaWyNVrzfUT4gYtnobkvZP1K2P76mlAszkJMURq+zhsaV1pIYO
 +8uQgjsqH4E+y1T37ihLCyyqMdR/LDQ0Bj6AQpXzWtR4C2WvWNFTMa3szxNlB6v9iuFpy
X-Gm-Gg: AYBFou0agTa1pjS4qd+3Hr4VGt7q3nXswwqH49LR2ehwiDu61JNz1T7Tz40RsPrH1VE
 wh17qCFovOu6woYiV43aZ4BrSeqDFncy1Qt4PdIA+9BAR9fYFTysSGe8J2qyJ8uBLVmqIUbm9rb
 Bx8WurUpT2+w1DREE9Mf4pi/wZ/z1WUSvYkj2qotlrDJThShz0uSRJGel3mf2QIw91lHDDN8os5
 WvUQSJgMQ/96veCvId7ARVWhoG/0Mt+Bf2i1Wsm45wFT+/dVD01gayq1CZWRnYLY2ERo5tMl2mm
 OjwehgiM1kpFpVTpNUVejxpqnm/7j4DdNOWff1QKdjZw1bi4Rwd9phfHhUzgXTXeJknX26EYWFI
 iQZ+iTiH2SMRqk6otAR7G/aBYPZ4IBcQ3p92vnesgmNZrC4DOgmKiMhJ3d5O/MP3YNrdCeMs7iO
 6Nh2h30ENsbMxk+6uN3vcaKVmSWcOU+LTOBq7AseonNtdUrputRIuTvWDbzHHoXksF9rYJ7IjLL
 WEwuE+2HI46HqSZLJZs+xt8BIrm//43rdiW51nejiOMqM4UY5xtm06LEtLzmUpZvsoDJLlRN1bC
 i1wSVd0tH37MNe9GNlpC5/XLBRje8DefQ5pI0NWXYPq57cnVttGq8cShiYlQ3A==
X-Received: by 2002:a05:600c:a40b:b0:49c:f13d:ffeb with SMTP id
 5b1f17b1804b1-49d26dc5aacmr89815115e9.15.1789139773790; 
 Fri, 11 Sep 2026 08:16:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e608sm6759465f8f.23.2026.09.11.08.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:16:13 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:16:12 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
X-Gerrit-Change-Number: 1912
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1912?usp=email>
X-Gerrit-Commit: b32e3b58e898f1e19c1c5d49019db566c749b810
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 15:16:12 +0000
In-Reply-To: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
References: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkkwYWM5MzRkYTVlZWVkMDQyNGI1NGVkOWI1MjhhMmJmMmI1NjFmZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7dbcbb81c2400cf03c0ea94710c9970c46d9ed08-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x52zE-0007Nx-Ie
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix various function
 parameters shadowing other symbols
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2151487426710294527=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2151487426710294527==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="acBcKYji0+0="; charset=UTF-8

--acBcKYji0+0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1912?usp=3Demail )

Change subject: Fix various funct=
ion parameters shadowing other symbols
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf=

Gerrit-Change-Number: 1912
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Comment-Date: Fri, 11 Sep 2026 15:16:12 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--acBcKYji0+0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail">change 1912=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ac9=
34da5eeed0424b54ed9b528a2bf2b561ffdf </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1912 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 11 Sep 2026 15:=
16:12 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--acBcKYji0+0=--


--===============2151487426710294527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2151487426710294527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2151487426710294527==--

