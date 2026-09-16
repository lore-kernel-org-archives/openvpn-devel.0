Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43224C88E5C
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mfsw0b7SJCk51TM9mx2HGwVM0vWI7iumcuu7+9oPaGw=; b=CfjCoQnlhuhq7BkP+cPA0160P4
	yzD9oJyvu4wj4hB9lZ/JnEBBZiS1SbEBAdk+K/OhVQyYesslq4nyYUZ9XG2Zt9EYM4lxbFzpyOfG9
	4H+ullrXk6ZMyDMI6hvLyHWr2KgG3YymSnOsWtP7Eca2kozBd3EN420wbEnwR4pcG9Iw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6lqJ-0003Ub-Lu;
	Wed, 16 Sep 2026 09:22:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6lqH-0003UT-M0
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 09:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NIRNqTfL05bCcOVh3ku1yiyqOJle1gJBZesFroIJ0+g=; b=S1JhiJQkXcY0q/lnhB/dTCwis1
 RU49GzIdQb7WGiQw6eYx4vOv5VgsJEzQxbHiEJNj8b1c97K+7e0kMCSKz8TMyDlZ0BjdsyGsxIKQy
 eF9VNFH6cYFy7gFnotIhKuRGc1VHYMrjRb25zvUJr/89Ub1qKJYKfPOmt8pJ1/RpyiFQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NIRNqTfL05bCcOVh3ku1yiyqOJle1gJBZesFroIJ0+g=; b=U
 xvNfpn+IDjvDW5vl0OLCJiA2s68Qbb/Vg8P1Z1sqS3lyRm0ujKHz2tic1ox7Yqh3PQ2ZazDo8JcDZ
 LBYYvHm3SthN841Jg52NnX/YuaCZVT5b2K5CPJKnwxhQY4TD7NmKKvimzGmXhR1CSWT8Ctn6tCp1x
 /zdUfJgM8qxDgWOc=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6lqF-00070a-Mt for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 09:22:13 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so3970965e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789550525; x=1790155325; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NIRNqTfL05bCcOVh3ku1yiyqOJle1gJBZesFroIJ0+g=;
 b=f3PAKQ/tXy84ihqAKtGcASlPvQSxWYVNajsmFJI6Qs22RUOKGGoNF7LYsoARcjih3Q
 r3fIarI5GlixVe/mwSPAVzuJGJheJgAxUy//qnw8iGXHIQnW2pDYKGpf5U2tobGG25H7
 JZPnYvUwXMoRs+CvrzBZpN14jsj+6h6T6QF3W76JGk75+tJk6KwFqXCzPAg2I7xOu/iO
 5IDlEBx6cJew5FZOzwrYQVWEkXRkSpHqB33J7ZUkWK9XjhGrmI4kQUI5Vr7peOhCkRHP
 Ke+X5na2f4x68SqLtPOYkysit6R3IlaJEF9a8LjTyNgxJttwzlJPHZDXai6eNaiSsEB9
 1FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789550525; x=1790155325;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NIRNqTfL05bCcOVh3ku1yiyqOJle1gJBZesFroIJ0+g=;
 b=w4t3za/VolNIas78FSnLxEyO8Y1n0nd9AEiEOtPjuZ/LKRFALVUTyw0o/817fkTH2f
 TIhUaIrqhQ79d8OAk3dVbT2BfSFm7iSGEdG8Dh3CExgrz60wY+X84ieCC0Y4Cv9Kkwo3
 zcKFuH7u8xakgx/iUBNT5tIQ6pQMNwortigHAmwj8xSwBC4XyY07QDn9zzVVkpuwr6nS
 kvynHbIE6pjGT6XR9GFoyWajXeKze/ATYTWUaw9DsxMuWoYdUi5QVhJGNVq/e4oGoJXy
 nNps1GwuEKaMaEC27WUaOiTWhFPJdveNGKLcIxLttYlwIpXSgQ7dHffjV0MVTWEwFu3P
 YtIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBygvIdmTWMDHnf6GlIRSQqmZ2jx8zYwalvpdcvqfp/H2O9sQP4geZjCgeNp3RChEG7Tj7ocXJwlEZWe0op+@lists.sourceforge.net
X-Gm-Message-State: AFuF++l9kqLMyDG1PTF2biU67QuQK5dKD/FO5l/wMr8vROmslhzyRfwC
 jPiTKL4WEuTjSG11qawYUpy6mPi7xUQ3N8G7oR6Bth2bHIGx39XVYzrFNEmYlTUMeJ7bEVOGN+g
 +qfHgkpjmD2nFOrosiHGHId24UqCalfAtOYDrZl6dd99AppZaQBkAI/UxOL0C1hqFbbTr
X-Gm-Gg: AYBFou1lvKiRMS1K1Qx/+gklgF0nOOZh5CKIydsTsgpyMSl2l+PjckAhzOnEZzVIti0
 uuwHQCBehPzAZn9eJzHqI8rRHS4O8Y9EFrJYaRCMo3YOPDMjJqtFFyT5O5mUQtfCAPgclrnoIGB
 kXdNYfgUO6AAT8kL4l2oK5CDn6hP9ADUUHsE0uRniisSiqrI3qmGQa7Cx55mGvmrD1KiKW87NC5
 jY0O7H5RxVYoeRuSk8hLSJWupfcW+NIjEWlwJltEHNY4qbOZDTxurY0q+oBYKSftpZmBsH5yk1t
 ub4G53MqzqVrrbz7olE4+LJHAd/G+1QLrg9vYfxjEG0Yjx1VGgcSeIfjei3c7Z+yk9OqrmvjRiK
 TRCTjzlKJGhHV5I3o06K746Ds3j6lGIaq6EGtkvHfASfHfsZq/GskTuE3kuTLTRlp+Rbta8CDTo
 rpo7y5zGblfWWrrAiXxoctGrsgnLWOgNAoq/g2dajZtBnU7PppYHnyndgjlSRPMnREyTmjbXldk
 FMOuLgMeA0hVY5BD8PdIsObFxtpMiHcyyQGSJOf4bUETlJYNOfw9gNM55NKdrhxUw0YOp2WY8EA
 EfcL+TT9UyumNBcY38yxlZeFdocMX0Z0xlogZMNGHkEprL5YmrHG09g4z7W2vw==
X-Received: by 2002:a05:600c:4e48:b0:49c:fc6e:a3d6 with SMTP id
 5b1f17b1804b1-49eb732d07emr22372475e9.21.1789550524852; 
 Wed, 16 Sep 2026 02:22:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fa70sm5437550f8f.9.2026.09.16.02.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 02:22:04 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 09:22:03 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: fef050d631e4f3c467777a59a8f495251ceac0fa
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 09:22:03 +0000
In-Reply-To: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c4b56e0a47017e29de7e49ac6f80ce615dd65276-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6lqF-00070a-Mt
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Wrap the client
 SERVER_PROBE with tls-auth/tls-crypt
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2077386368965251275=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2077386368965251275==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u2tg0Lw2HqQ="; charset=UTF-8

--u2tg0Lw2HqQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1750?usp=3Demail )

Change subject: oob: Wrap the client SERVER_P=
ROBE with tls-auth/tls-crypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 22: Code-Review+1


-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
Gerrit=
-Change-Number: 1750
Gerrit-PatchSet: 22
Gerrit-Owner: stipa <lstipakov@gma=
il=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comme=
nt-Date: Wed, 16 Sep 2026 09:22:03 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--u2tg0Lw2HqQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 22:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail">change 1750</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1f9d7b5a=
5ec19bf77c0c212795f583c5ba4c03ac </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1750 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Wed, 16 Sep 2026 09:22:03 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--u2tg0Lw2HqQ=--


--===============2077386368965251275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2077386368965251275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2077386368965251275==--

