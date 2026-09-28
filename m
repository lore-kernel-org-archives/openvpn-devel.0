Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCCACA5FA5
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjnvazJRRgW3tYUW27PCf8eI5QoRJpvadusoQVwJGb4=; b=kMdlbWx/k06ly2eiLntjfMwHB6
	ZbvqysP1hyQ+pX33s3XLRUdZHpfAePMUQkajAa2tb57yltylRmyWJYVExVrzl3EbdW0G2qVTVMxEn
	TJbbfMkCn/CfBfdofDMlemQLrkQiO7186yKQ46feLx+W84XujuWo1Xx8Thiux9XLdFDA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBC8I-0000zC-0U;
	Mon, 28 Sep 2026 14:15:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBC8G-0000z6-Hd
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:15:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kmM5GmOImMrqLY0EGJgCBnvj0TZI0Y/Q9bcE/utGxB4=; b=FjA9uxm81qtqeh0WsyV1oyRr+Z
 yrSFOrrfBxXcxcyPFsvnvTsCuVtvk3NkYkGygdunBj/Z86bzR4TgQ/8+xpwxVCUmd1CGQW0gkbkNU
 F5f07rghMThY000p4jEZYXIqh8Rn+6emai7lGjmkH7QoZxK6/YNSIPSCNkb7XgsTrJLI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kmM5GmOImMrqLY0EGJgCBnvj0TZI0Y/Q9bcE/utGxB4=; b=B
 hi8lVbwjM4ZuQQk08I28w2pViel7Vb/Fkey25aanQSuM8956IqsZjjakstWaT1JJ9utJBc3A7GyoG
 ND1LhC1C/mzUabNRpNViahZCi2Y39KwTMTgse/cHWOQApWgrsxEWJKpP81DxemFciRtgiEBKe3yPg
 uYWm7pymWPQR2Dfk=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBC8F-0006Um-IL for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:15:04 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so17320865e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790604897; x=1791209697; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kmM5GmOImMrqLY0EGJgCBnvj0TZI0Y/Q9bcE/utGxB4=;
 b=DBdX60QYA48kJCQlTTgwaSiWflzY3tcnqt8T4RG7XHJvnr8YoAZdFmdKTh6GcDGxuA
 6Navd/XqGeP0vmknUgxFxBHqmT9Z+o1/8JUcOcTwuZ25hfBJftyKE70gUOzqemBixJyJ
 NJeih6DK2Sz1UnIztK3HOHfergxzIK0pbYBkdHyhGrCWzknb0wQEZv/+qPwixb6knuj5
 3kIyPtApGt+Bm/Xbu6355Kvg9DtG1RNJA0OGsSw+0AldDn4GA0Nfam/pFPiIqviCOZsG
 yVc5QEvgJkX1EpKQY+FT722v6utTLp4Ua1ueaQXlY9lQiw+eQnYSl23KI95yNV7mzhlE
 OFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790604897; x=1791209697;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kmM5GmOImMrqLY0EGJgCBnvj0TZI0Y/Q9bcE/utGxB4=;
 b=TlWRtJR9m+vvj2fy+qxJ4cIeHb1q8ybCvpUhmoztAQ5PGzi/fwN/toNhjof4gjXfQl
 H9cj8rHypIgyLyPzlSZsVa+POXHHc6Ifck/cSWskyW7iwFByarNvKAFTQ/HQj4xMFOb/
 iJArBukIc8qpF6HJO41FMZ9hZ/bAcJIPtuGA2pGi7ehVJBbQ3jPnAENFe2PACsy5mtLD
 LovAcS4b9j5CbXPVQwbfAYzA3RzwlgdEYBsabv/Ky/fZ+oXdBgAPmhOjm55ulHO1wj18
 OAYfLkBAZuNI9dgQw1LvSAgqBuKxYLESip0f3QqhDBCv8W3xW3RbmJJ01ixYIRCQciFb
 2arQ==
X-Gm-Message-State: AFuF++mt2fnbXtVVbsmdvOkWjVpbnKLasMLZE3BORdwnoTiQW8WcG18x
 SwUzvSoULaeRiH3T15uaMVTQWxH54LC9XS88gWTuPcRmbfaQhHF3UJ/9+Mw7K5r448GmDeysOaZ
 hiKBwtLS6EFW+vSL46knH4LfBriviR7e0WHn3M6iZItQpweIkqfrLyVrRpCeu45ZC1tWBzqaIMg
 mX5OFGUw==
X-Gm-Gg: AYBFou28K7XLaIpXW2wbC30lf5JW7ivzt+UknJwIhFwUxbICe8tYXyH+IR45IJE2Yd1
 FDi/JubnX2+YYj1+TkK7BFPUkPouDsB4LUWQPHmVs9MNEIdffaivdY4/0eb515nOJejX4hiHpRT
 fTyy76+haOFqInfuWSFBrk91Mr2n4X2PfRrHu8m930BQBD+7OducZQ9oD25ux5YU4jFt/rSFNXr
 SGCYo7y870Oip/t5NCJWOpJESt9c+KF4VfKAqgmFCX81tU7oRFm2Uz5JshMLvg312xsS2yVXtEZ
 jeFMMoTTBi8uqsYD+3YR3h170sNOSfwhYs9vT309moznaLyyaz6RmNElmBGft3v4hrVuvRP16/8
 6OE5eWPl4mmVWwSCeIf8yBZDM/tvSHvq0rldgzkOuFp2xMRJqDl1bekhEpujZPuHeEnd5KkQnua
 44NELswiDYkZ4+D1f/RjE9gg5MXLBF+o05dD/q0X3GzsCVOu51+DA8mgOTUu+kkBmhZLDsRl3VF
 Ti8aSLSe4DpORla3o4q4a1GileegobnPKg7eAXVXIOT7c6tVrZjynFQImH2eyNg2jAtCMNKkbz0
 vp4l2B5iH063qsUSA5fz4ICVyuuv44n4GJEQ7SEp0a/xt5Xy8USm/fpiT4GrKUYxxz4ezmsL
X-Received: by 2002:a05:600c:a418:b0:49f:e4ca:e1d with SMTP id
 5b1f17b1804b1-49fe66fa070mr190248155e9.27.1790604896874; 
 Mon, 28 Sep 2026 07:14:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm142308985e9.9.2026.09.28.07.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:14:56 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 14:14:55 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3b835558451414d8a4e8058114643555be69d391
X-Gerrit-Change-Number: 1957
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1957?usp=email>
X-Gerrit-Commit: 94fb95498d8c52fa3b219f91edad2f81240def9c
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 14:14:55 +0000
In-Reply-To: <gerrit.1790604535000.I3b835558451414d8a4e8058114643555be69d391@gerrit.openvpn.net>
References: <gerrit.1790604535000.I3b835558451414d8a4e8058114643555be69d391@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjA0NTM1MDAwLkkzYjgzNTU1ODQ1MTQxNGQ4YTRlODA1ODExNDY0MzU1NWJlNjlkMzkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d338612b37e4f2b7e3837e43c9a59cb4789b95e4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBC8F-0006Um-IL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cppcheck: Fix
 handling of likely() on Windows
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2347461090434404898=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2347461090434404898==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+mCtXJUoyY0="; charset=UTF-8

--+mCtXJUoyY0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1957?usp=3Demail )

Change subject: cppcheck: Fix handling of =
likely() on Windows
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1957?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I3b835558451414d8a4e8058114643555be69d391
Gerrit-Change-Num=
ber: 1957
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 28 Sep 2026=
 14:14:55 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--+mCtXJUoyY0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos has posted comments=
 on this change by flichtenheld=2E</p><p>Patch set 1:<span style=3D"border-=
radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-=
color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1957?usp=3Demail">View Change</a></p><ul style=3D"li=
st-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1957?usp=3Demail">change 1957</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1957?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I3b835558451414d8a4e8=
058114643555be69d391 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 1957 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: M=
on, 28 Sep 2026 14:14:55 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes <=
/div>

</body></html>
--+mCtXJUoyY0=--


--===============2347461090434404898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2347461090434404898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2347461090434404898==--

