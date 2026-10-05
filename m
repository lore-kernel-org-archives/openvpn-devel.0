Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7593ACA5FFD
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L1WXtCB3FKUUpoZU4N1sXWpXuoPdZyQGQL6u1FBl7OQ=; b=LXRx9IGVtU3uo8AFGF0pIooyU4
	t8tvhBoWOHqEowAGqieV5qFeDPs9xjjqkoYA8kGjXYlKvdR3pxoR3837Olr70/CuidawUhSwq6ulA
	qteB/5L7zR7YAICE1MF1vRcdszKh7I6+7+6Lvcn1GxEoT6VfYtnY7a+ChMunndRzc6tY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDfmm-0008Qr-LV;
	Mon, 05 Oct 2026 10:19:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDfmk-0008Qb-Ia
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 10:19:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wB8Y5VfcwSfRIgIV+thfcBFo5LfHV+/FR/Tux1o4YpU=; b=kKhWsjs9CdjL0pwso2rZZp6kKp
 /N92aIJwv4cm14MtOKeCmwgeiYlZNbZ//H9VD4YT6uRd1ufQCQgV/oJ5U5bSs7/dMwRdmQZw3rCTz
 //mn6EdsvVa6DKYQCBK+hgcuSOfbf0ILqItm+C4Nu1M/sYJoXDxq5aJmuGL2+I/N2iH0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wB8Y5VfcwSfRIgIV+thfcBFo5LfHV+/FR/Tux1o4YpU=; b=i
 TJG9XjRsOVayfr3upKU+ev+s0C3p4bln8A5zNAPUFxCTEMJgR9Iq6B7sUnBzGMV6xsc2mz8nymcRc
 8wFi08biMEqA7k2REi6SB/csbwRGvRgX5AfP1VxUpcNikix9k5XjQRaFdXEv4cBR2ia1UoG2NxX+N
 Wu1p8aTRD9NPo9DQ=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDfmj-0004Z8-Ur for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 10:19:07 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49fff72474fso10868615e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 03:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791195539; x=1791800339; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wB8Y5VfcwSfRIgIV+thfcBFo5LfHV+/FR/Tux1o4YpU=;
 b=UtRHwMyX9P4BkzItiaLvjP3z+TcQfwmSp8yjW7hVE0Mu7z0rfqg5bzHrGAONQicymc
 tbJIffOvJYqwA+MS7TpdTOpwDvwtv1lTYHAQ5pgVJJNMJ7sru3x82+q9DCUe+devWYYb
 hQ1fZB8Qi8qVnpXmo88CVz7Ks0bUduK2ICy9CGwc0zlCAo/oG2wsR0HxPQwKl0X1DAKQ
 Gz/dgQxd6sk9QMoEycgFECYE75Bok7cfNfSs2ZmRw5wDk3+diKobCRnAvOleN/3/hV/9
 bdZkcaxn+IZ9yIeT20/Tpa4IP9FnH8VfQVZA41ZIQi5s9x3CUm95S9ycKn17mOQHnkAa
 pseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195539; x=1791800339;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wB8Y5VfcwSfRIgIV+thfcBFo5LfHV+/FR/Tux1o4YpU=;
 b=CIwaLnTJaB/8noPRUFF8FYdbsHH6rUoKSEmP8cSr1CrZ+1CTtxEGfe/y7NukwWQHqm
 CV7VuwoXLLAGOn1qNQz5OOvo5GCzdhOh8uZIcjFJNk51d6pywwRjK0aWxi0rfLCDbR6U
 QbRHjmQfvHuYRAfW7YVi16wl3wsdICfwR60ZyGo/CNqHkwGJ1+idzTNVQkqSnGwC8uqV
 ongQfkUH8NSWw+I+aAINHXZcTp9cWzj4JirRBopGQixgEiw5MSC7nM5GVelZsh8twywq
 KZzPIciJzuibKorHGpvBbQF6AAprI6CsKQaVuCwXeFYzoME6IN9Ly83K8RUuaY1/yum3
 0vJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOftYuHV8DI7PhWeQ16rdWIkqyRR9HROaM1ruf/glfZeuZ92oeenB+4Otp2PG+33BXe7dDfrcLrQwir0Vi@lists.sourceforge.net
X-Gm-Message-State: AFuF++nFVINn6THJ293QXsGXOUr3jwT/dPhVBNckWXtxogVi2ggPINPd
 U5vF+UZpWST+JGfOGsuULcVxZJW4nvS46NzOKc5FWybxo6ICks2nrk6z8PjVT0Ctq5jdHmmVsX/
 ghzlAUFDib0PT20WSpofTIjeHzKH7fmtenKNu0KsQSbeb96ye5ja/BGhZTOQlXbNhWxsv
X-Gm-Gg: AYBFou2eGfKvXHYAuqQbjvYpL7ealCv3Qa2NbK3F7DOZKJbHUPFTyhCpWU54Zb7dRqe
 kYC/60xNi6/qWobukmyJSNklrQaxvFzOoyMPGMTqDtCByFHlJivbVpoEwy33bbLoKNPCRZQAFcO
 iKsPyCAD+lwrh+/XLH25DyXe8xeoWwUB4ZWbRfzO6bImZtocVW0CIWAoQyIZzLBlywTWM8y7JFM
 bjcEeS3Sc3gBDCIjgA465wzFu47oaT7dkGrUDxB25C3a6ABxggF10AloOE1Ihcih9qrZtNx/GNj
 7BMOxvzSiavZBnHGK1n2o8kJGIz1W4X/2OKuyXNTuL2rmi9HUhyOOymi6VVu/cLCAkTJN0sM+/t
 U8jGVVOU0KRHtm6C/zOcwAWMjCzu/vDeoEv8XYNBACAmKKJGq2E8En5dYhPcFbgrhG//hWJak1Y
 N4tc5KsG/dHpFTkyx6Aa85tHA68rxK/dmE5Ho+oE35zqYK6FuOZTT3sjMcrC5ISe7iiUsy6nXcC
 V+a6NTuAuIhMPvfnEpBdI0iUqRM21OQW3H3tmzcAnbjNusG+J6g7gd8zyjPKX1ZLoUbAfwS/0pV
 nFHqDpIZOeWhtf9Uh5/fLnUBg8RI90cj8pg4WCD72W/VFMUF7qJGoyzF2Lbs
X-Received: by 2002:a05:600c:4f8e:b0:4a1:70d4:c69 with SMTP id
 5b1f17b1804b1-4a170d43f4bmr49289295e9.28.1791195538171; 
 Mon, 05 Oct 2026 03:18:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02769a818sm346894135e9.2.2026.10.05.03.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:57 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 10:18:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
X-Gerrit-Change-Number: 1962
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1962?usp=email>
X-Gerrit-Commit: 40a2f1f4b5d59defe28d8e9b091f4580c4e3114a
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 10:18:56 +0000
In-Reply-To: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
References: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkkxNjVjNjMyZGE2YTgzN2QwY2NhNTViZWU0YzJjYzM5MGI5MWQxZTU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3bea7121877dfaeaff8de452e7acda24325c85d3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDfmj-0004Z8-Ur
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: drop
 IOW_MBUF
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
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0522327551336398929=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0522327551336398929==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BMAvURAwT4A="; charset=UTF-8

--BMAvURAwT4A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru, plaisthos=2E

G=
ianmarco De Gregori has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail )

Cha=
nge subject: multi_io: drop IOW_MBUF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/mult=
i_io=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962/comment/9713f2d9=
_c6de6288?usp=3Demail :
PS1, Line 568:         while (!IS_SIG(&m->top) && (=
mi =3D mbuf_peek(m->mbuf)) !=3D NULL)
> Is the server always exiting or res=
tarting on signals? For `SIGUSR2`, for example, if I'm reading th [=E2=80=
=A6]
Ah right, I overlooked SIGUSR2=2E Well in that case the cost is one pa=
ss of the event loop, with the next iteration draining normally, the same o=
rder as the timeout branch=2E



-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1962?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
Gerrit-Change-Number=
: 1962
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco@man=
delbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 05 Oct 2026 10:18:56 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Comment-In-Reply-To: Gianmarco De Gregori=
 <gianmarco@mandelbit=2Ecom>

--BMAvURAwT4A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru, plaisthos=2E </p>
<p>Gianmarco =
De Gregori has posted comments on this change by Gianmarco De Gregori=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi_io=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1962/comment/9713f2d9_c6de6288?usp=3Demail"=
>Patch Set #1, Line 568:</a> <code style=3D"font-family:monospace,monospace=
">        while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (mi =3D mbuf_peek(m-&gt=
;mbuf)) !=3D NULL)</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Is the server always exiting or re=
starting on signals? For `SIGUSR2`, for example, if I&#39;m reading th [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Ah right, I overlooked SIGUSR2=2E Well in that cas=
e the cost is one pass of the event loop, with the next iteration draining =
normally, the same order as the timeout branch=2E</p></li></ul></li></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?=
usp=3Demail">change 1962</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1962?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1962 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Mon, 05 Oct 2026 10:18:56 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Commen=
t-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Comment-In-Reply-To: Gianmarco De Gregori &lt;gi=
anmarco@mandelbit=2Ecom&gt; </div>

</body></html>
--BMAvURAwT4A=--


--===============0522327551336398929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0522327551336398929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0522327551336398929==--

