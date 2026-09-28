Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BAACA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UqxAdOSSjQhLbYLZvx1aPQJfCJdI3p0IAc7GPR+7NYs=; b=Pz6wGh+KH6+wr9bv0mYdxtbX4V
	q3Y5du2LjS402IbwnU1Uy4aoZ2n03nbUMo4E/wkk5dEOlNwlJE0DPDVXSLalsrzCulz4/0c01Sw+J
	nVSuouOfBH/SGNS0+yNv/odXI9YDioHQUo2K5CfoB1ATeBJvJcKEHJrQsjr6ht22TLFs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBCFH-00019S-1E;
	Mon, 28 Sep 2026 14:22:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBCFF-00019L-JL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:22:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CvOOmx3qgNEGhRkcILJWhJShxtHzhSykG4mT1RaP1KY=; b=F62Js+M4vfj435O7crOm18LUe9
 lVMKy+vPw318CgMXBFoQHDA0OgdBaIUyOym3T+PsZmKT+VmL6ND/wDomR2ndUqu+IqHTly4/7LzRN
 MvuBAYpALg0P1vyR+up+rmJTgTmo0zJaMxOX5I/W0HCgIcs3NIqEZwfQGDkev834Zch0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CvOOmx3qgNEGhRkcILJWhJShxtHzhSykG4mT1RaP1KY=; b=Y
 m+MEe2iVUmY63ogSlj3mQ8t4PA+lQHhwyFVRKRc8zzVsTbwr0BhID7rq27owZSjjeJFJ69lCOx3Ba
 /p4bMLs6txXOcTz6VJO9dDC7S7wRarTg9JCUO8wowg4hBkciIm86dSZ6XtiLgS/7AIkBTYsawd3MN
 iRSK5yTMWjGI8dgE=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBCFC-000409-Uo for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:22:17 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffb83bf7aso16716225e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790605328; x=1791210128; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CvOOmx3qgNEGhRkcILJWhJShxtHzhSykG4mT1RaP1KY=;
 b=SAphm26mcGkEoE+eMmWAZDZ69kouGjSjzq+G2SHIWIAoHSKa0RM2BtxURdxaDCekmN
 YICd8XBo/kiow35bXPlKG8vuWzBU1u/bXWc8Q9D3WtvUjfulBJjdl9W1+ud+asvhuY/C
 XdJ6tXJP7cj0uvC8FpWgws2a8OjuqZExu5lck4PrjQqb8luw036GS//2tqeUitIxsNjc
 Gedn+1uleMPeJ7M/LEvIIbxGj5sucBSHBxpr5Gws5g5eAW1eCpSZi83sMx01KA+VmiS0
 U00LdRnmQ49MwVVr9H7NGD4lMdB5lflMrOaQOr7X6nWx421hNs6CW9FVcwcsIAe/EWuB
 gxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790605328; x=1791210128;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CvOOmx3qgNEGhRkcILJWhJShxtHzhSykG4mT1RaP1KY=;
 b=yH7GebtxO1kDKgXFfDaw8gpNVVSqdjs6LhkFjeSBNi78dJ/6nAXEhfZGJf1vnu6ahD
 YzHskcfL1YrwMPZ8l9p3BLSWWQmhwmCbIpXHgzJ9NZigAzKR8H8Jmq7zInAX55DNDUSK
 XjLcQVoJCoHWAHXnKFtnYaIyJQRTYA/1K5nAKSp637Jgg1RwcajAi8bOXY1DJDRI5arO
 tLSMQGABi9COM85PCJAiJDQCG/u48GDwZQEiTa37uphbivdkqTGLdNzJfYLQeMlGKUJd
 vmWj3UjO1RIbvIQiyrd216JcPMNpRCvFL5nQNwznYLyfbOp/2gJID/94sG937pf9M88T
 CeFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4TY2XkK59PuMkJIsAilDhA5TGtXJTVoHlIcjr6G9oCVd/7LMHbI7wBnPbuJCpCtXYGOgg8uV62ZgvMPus@lists.sourceforge.net
X-Gm-Message-State: AFuF++l8qX2wu8rAeRNm6cawS1zp80dncumRFbhxjR4sptmAhlc+F/e4
 pAPX1RcG5zv3wCeRkK8lVNEBgsVeW0rTOryG7KLZYlRUjmLWrWR0CclalsPv+kGkUKd+tmF/Jiu
 jZOVoWbb5IHcg897eTS3BM8WToXA8eRq/WtDC/wmeT08XN+R8KhgbUIlGh3Ti9HMDUxIv
X-Gm-Gg: AYBFou28csb5CGPxki1MUvSLX3DqtkmTBjEM2txZVTOZ1TftKEs670zpSTft4XufRvw
 k5WZXKobdr6e5XGM9UrYOTggiK1p2LBmfQptWqYHtn76WA/QwIj73OnmomJ+Qq4bpHO8I77OpWc
 EpdZfdGM67rk3tMdakjDfxQn7dY/+XBXUDdDY/lU6Xt+LfW3mc/ESzc2dyLsnqN1Lw4mAYYZTUl
 ZOquXRIXgjPzkfhItL7qvPO/1//w2FQbxplXl0UI8dpO8ZGteJ5KBW3/j5U53ghHHV+G0OA64YH
 FEJUZwE80WNWV+2wmdi7NdvVFq4CnkmXfX/o7LaK2X1PUk/xGzHNjiKsBtSHkTcu0Op3SBSbpBi
 47NsOUiI2op9AoauljfuCqvSwv/y5DhlCybRPxE5/f9DtOeqAn8deJhP5jlTCx8e5y8Ia2FrJfc
 0nXGAjGXuzU1yn8l/JxEqM4HH63hbS7pr3vB7ip0JNh9QYfLjiyKucyxTLTZ1zs9Yrk4klsOEQh
 mxtEh4cKKw/XHqtJdHDN9iLwtL/u7Z3hD1SNF/Gg81QctmZiHdOW4JLNetixemppbqAGvC78oyn
 VQfTQ5h7tA5ytQR1JaAvp2M44Wf2d0cK9u9/oaKiu/2uQLFD2Jb7x1msVYf9pA==
X-Received: by 2002:a05:600c:138f:b0:49e:602a:b4ec with SMTP id
 5b1f17b1804b1-49fe66d2700mr229787805e9.8.1790605327318; 
 Mon, 28 Sep 2026 07:22:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00571744csm76001625e9.13.2026.09.28.07.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:22:05 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 14:22:04 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 7f48516ea1d96c7a8545cbdb1292def401ac411e
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 14:22:04 +0000
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <220de9f4e2c132372c1433135d5955f22647b254-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBCFC-000409-Uo
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Build against
 Windows 10 API and remove some backwards compatility code
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
Content-Type: multipart/mixed; boundary="===============2405104963083769179=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2405104963083769179==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b+7Yck3fW+I="; charset=UTF-8

--b+7Yck3fW+I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1955?usp=3Demail )

Change subject: Build against Win=
dows 10 API and remove some backwards compatility code
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Com=
mit Message:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955/comment/5f702b=
35_a751a9ea?usp=3Demail :
PS2, Line 13: versions anymore, so let's also rem=
ove that=2E
> Unfortunately, if I'm reading this correctly Microsoft still =
supports things like Windows Server 201 [=E2=80=A6]
And I forgot to include=
 the link=2E=2E=2E

https://learn=2Emicrosoft=2Ecom/en-us/lifecycle/product=
s/?terms=3Dserver%202016



-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1955?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
Gerrit-Change-Number: 1955
=
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mo=
n, 28 Sep 2026 14:22:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No=

Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--b+7Yck3fW+I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>razvanc has posted=
 comments on this change by flichtenheld=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955/comment/=
5f702b35_a751a9ea?usp=3Demail">Patch Set #2, Line 13:</a> <code style=3D"fo=
nt-family:monospace,monospace">versions anymore, so let&#39;s also remove t=
hat=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">Unfortunately, if I&#39;m reading this correct=
ly Microsoft still supports things like Windows Server 201 [=E2=80=A6]</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">And I forgot to include the link=2E=2E=2E</p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">https://learn=2E=
microsoft=2Ecom/en-us/lifecycle/products/?terms=3Dserver%202016</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1955?usp=3Demail">change 1955</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1955?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a=
79a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1955 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Mon, 28 Sep 2026 14:22:04 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: razv=
anc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--b+7Yck3fW+I=--


--===============2405104963083769179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2405104963083769179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2405104963083769179==--

