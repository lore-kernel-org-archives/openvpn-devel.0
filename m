Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB2BC624D7
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xFGLmodw5ixM18XQ85SNaakQ/C+luV64qFslBuuhVWs=; b=BEP6tMLlfZI7rxA44JF+IFEm2N
	e3xEhbhApDMZ3LHBw4S+urFOo9TxrNX7N8ooaDvLHGkuK4CSQhlRoLieyhaHZEwN5uFbKB5GPXtYg
	ilikaVSTxkkhACHy+e5b/vuxdUrrLqIqtpy27+6zj2K9CCXy7muGn5tu6ELsXDfjp824=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2DqX-00056R-QE;
	Thu, 03 Sep 2026 20:15:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2DqW-00056L-U8
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 20:15:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=K76YLWHNxVnBCoDCyJuKx5DFu0aEZgomEHI1Zvpv7+A=; b=jZEh+Z+UNS8WUss/mhbsJe0dmb
 Y4/VqedKFRUP5zUXWHoWpgvoTDl9jyUxl05DWtwIB3BP9CdGk6iz79Lnggq+q8E2vbTTlKgHM6lSu
 6itbMpBswoD59kIbK+uIZ2EycGVAdnXciEPAvvxxt/C432rsnT3dBluFceOLBSS/HoM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=K76YLWHNxVnBCoDCyJuKx5DFu0aEZgomEHI1Zvpv7+A=; b=e
 c1pvVFsw5CpxHUTuq34okBZDcxQISVZMxE4GQUnMuSAE5cn0HXG2FG5CXuGV4XocKKX1DJaQeMk4X
 K7i8Ju60SmPEl1DTFAryZr7aoBQ8OvPpTAhzhQtgxBBXEk3AX5t/c0zZ6JvvPykuS+8CNRNwIYmWT
 ccmRIZk002yHDCBc=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2DqS-0004yz-JQ for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 20:15:38 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49cdc81f40eso2012755e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 13:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788466530; x=1789071330; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K76YLWHNxVnBCoDCyJuKx5DFu0aEZgomEHI1Zvpv7+A=;
 b=WvvAD8DqsBu90FeGJRjq3HzONbgsyM6zUFYibIDUD80qaLVCBJZgu28DN5mOWATrMy
 k4axykDtzHMerdIHjymEfzbTv5bF3u/LkIXRDH4LfVlmj2rPXx162Kx+Zxx53sCWonfx
 lO0g2v2d9HLsMOmvqsgIHWB+1xz36FizbcbU1eW99yAtIbtnq+0UACrrITvkZ+2im9uq
 +DXnQXQ1ZJP+W8VsVAQNgnE8NwSclzHzF6ZM6BLRaekukbHvZkWtrgqnKPMxT9os0o32
 UJPm5xrPi6W8aG7Fy7KYkykQIaU1cYIPDjjjFtWoFl6Sk7Cahdwawho5a7QOiy6EDH0G
 VAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788466530; x=1789071330;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K76YLWHNxVnBCoDCyJuKx5DFu0aEZgomEHI1Zvpv7+A=;
 b=icwrhkt7gE2bk53plmktDcGn4iS5dbX8QZHqsOuAW92PyOZm94nPAYujFI06OsYLs4
 8AcO22sATdQxS7GwRJXMfxELfl4TFZy2ONAtsylCGpddwQ6yScnDR+xt//2+E1cyVfoV
 hyLqUvtN3CD3h3HhPgWDMZjk3XRAaPAEKNxZ2zJRNK0s1Vv603znBz5E3aiaFSVstgY/
 cqMHACGDtE4nf6PGqg66GPIHY0nwEluuNltpaw796KNzQ9gAxHzE44lovv5Qtzjgt2LF
 IqqFdn8WFzlmCKsP9j1d8POfPl0SYkpJWshPnkE4O9t7Gjtrcg9r7QueLdeUk3oX1SHO
 GlDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwC86z4bcEMG8HRiPGhEoKvz/WHMG0AGbC19ZyEFf1ROR44zjMWnQmOXUIiaTgtjtT/MX0+cfKYenr6Fn+w@lists.sourceforge.net
X-Gm-Message-State: AFuF++n1NjVFW2jjkR2IWfOS8P1+qVluMyNYvJ1Wl5zNvSUO7U5kkxR0
 yD8PGW8aqJGcfIXZF+LolsUjzDMycz2hqqy0x4ewM3l3RWwvmYbYcP1WkGbF1q9k2gUoavytyKd
 PiOUKfID/ttewU07AmtAShlJW+5M1SatsU59/xjDmBtgz7T84RcJU9tNGJ3hDv9VulobQ
X-Gm-Gg: AYBFou2ufZqo66uGwa7mfvI/PbeTBLXivDUIEj78omfRdKpopHG6F5V/t89MKj/ONJK
 0SrY0q6Df30AepDsUhfAur6ARnkRdi8tLRMhBAQPocjeU54yW5CKix5owSODYB3rdFN0LWKPUCs
 Rs2oOHO7q4uYg7mm5/f3ojPAFT4L9ZlzuxT0SUtj0Ez5NKucZig986NyuOpbsAIHMpgTIED+zdc
 iNJUCB7eWD886c/l1HiexBOWDyOvaDrs6oDx7U1ZV/r5Xj5nTh7Wm1J2fP1fEdIPf5GFESQoqGe
 5PnneCDBV/2Uy9lIrj7qvIolJbeYJfY0Cw9YKAQaqH4YKsqQ2x62MStJDh5iNPKc+kW6GC2e8hw
 S4w0/5NQWRnxASR8tTpDu2H10HSmUtbPgMX6b4iuv0MO+ChVj4sMf1wo7SvWlWjzDsebKp7HPdn
 o6Cl7+tpXX1+zA+43ACU2Ofe+97yGk4oqC0tiMYsEQfXeu+1iMEqWd3gwaWHteWPyR3jY//cLir
 kLgfRIQhS2FaUSiArqsiquW6YFir6Mi2F9x5SS1QT5i34V7tYHuvP78YHTOP8et1efDODZNQjbq
 ix+CofLOimVvPxOIK/BZ8jS/oWiVTjnty61pw0sCfEDwCczkcdU=
X-Received: by 2002:a05:600c:1990:b0:49c:f512:2361 with SMTP id
 5b1f17b1804b1-49cf82524a2mr6061545e9.14.1788466528549; 
 Thu, 03 Sep 2026 13:15:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d476esm105346225e9.1.2026.09.03.13.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 13:15:28 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 20:15:26 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: 2902b94906e9b21e9288d9e43b24a3c6b5775e17
X-Gerrit-Comment-Date: Thu, 3 Sep 2026 20:15:26 +0000
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fc4ff1e7147d0d8ddb3d3ac17521de63b2b286c6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2DqS-0004yz-JQ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support pre-existing
 Linux DCO interfaces
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3036852828423587842=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3036852828423587842==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nsju595IQXQ="; charset=UTF-8

--nsju595IQXQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

ordex has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1734?usp=3Demail )

Change subject: Support pre-existing Linu=
x DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 1: Code-Review-1


-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1734?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
Gerrit-Change-Number=
: 1734
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Ge=
rrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date:=
 Thu, 03 Sep 2026 20:15:26 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: =
Yes

--nsju595IQXQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">View Change</a></p><u=
l style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">change 1734</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I72302=
403bddee4b0b0ee2441ae9e246f48d0bc81 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1734 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: orde=
x &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Thu, 03 Sep 2026 20:15:26 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--nsju595IQXQ=--


--===============3036852828423587842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3036852828423587842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3036852828423587842==--

