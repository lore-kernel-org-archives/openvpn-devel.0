Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C15C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FTxLp+qCnrMaY/GTZEAVsaVOkjC9j4BbJYrX7sbMdCI=; b=CtYQHRI7tr9Bi3HFL+DI3gB9Z/
	KamrOyCFIuaKlSI9205Va1bIyf6kiDA0+0T8pL9ZnRS5CmXxPNX5tLihRsh/VDeTCRoa2C2+WisCf
	Aauff5dOXCdaAHnqsnodOBVgfdr59BrA6GobmDCsf0ecPwQsMWRK9ihcqA6yE5fHE1FA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weuQO-0000KT-RO;
	Wed, 01 Jul 2026 12:52:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weuPq-0000Jr-4w
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 12:51:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Z+1tO3I/iyAd9OM09mjADPFzsSArjOmNF2oWK68ebXw=; b=nTA1nEb/UrLlU5UlY7neyBuTdO
 Laaw7RuT5FqKu4BD1XghxzJYjbQ34LNvmflstcxx9yDziudnqTJLAm5ckMcRZHk9FECXYWDVnYTrk
 LosIjD/52PGPioLmhWNlKLP1gyZjcyj+/hmqIUMs+VXOhHAwXdWA2qSsXXF35nIX+nIk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Z+1tO3I/iyAd9OM09mjADPFzsSArjOmNF2oWK68ebXw=; b=Y
 QTtcBZlhYTOaMkT9EPViIQkqLKr5jfkluAYx5HyA6L7cCmEt0gGlg+WGpCktpSU9ESNIyZlJhwPdx
 UZVYgyjomvEmVV48rqJ4PjJZAmIFucM2RQCEKcpPallC0cZdYgoK3iE+YOKjMwFQX9u9a60sshc1l
 6h6+XwkCViNun+UU=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weuPn-0007wc-Js for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 12:51:45 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493c1950518so3266125e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782910292; x=1783515092; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z+1tO3I/iyAd9OM09mjADPFzsSArjOmNF2oWK68ebXw=;
 b=dK31I8Yi6rUmTWoJ1GEENjWIftAGR711k+bJWAI7hjhqqL1Lt+ZTRz/McA7Q/92lcR
 CHpxmA9kiXqRXA/t4JSpIqceDUVdOnb+WmIJdRSjE9hEUNtvtuVuPZkBEQfVYK9D+OGF
 1hc/auAmJn2aYhCmmiC39U9O/dj2yHNhIdPmcQRF9qsj2+/pT8lCPD7WfacOsl5jZncn
 Km8mXMPe805EdJra0xF/rBURCcP1baaTDTMyijAq89cESB4T0uYQ799YsVe73frMdvNi
 M3mcTLZFU73V5rm42j18IntGVp61qdRG81AijfzIILNMaZaeMD586OkKDBG3hCPaSS+4
 GuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782910292; x=1783515092;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z+1tO3I/iyAd9OM09mjADPFzsSArjOmNF2oWK68ebXw=;
 b=cP2/Es3UkUlu/+lzdI4717/HVzImQ3/V3mBbP2ospRaYu5YI4KLUwcJQVScP71YHG9
 Ls6OURDhxWfVIcRLFsffgxMp59Loe1crmjyrJAwWEH1hXJ+Yiqh6A4d/YQ6uwp+QsDLi
 BdW6NbPbVkU6VQJBY3XZrsL4F3pZRrtpMCK9Qayd3uSU0sQg1wr8m8FIIT2Dwg/dNlfa
 D/922qZ2yZ47NwInnHT1o8QDcezk3/nstg74DsQuCQ4A15nBL5Zx6pJihLukEGcFLzkJ
 ArZ48bx88P+nppkA5wxPt08CmhuvdDfJEtrxOOd/IC9KZrKGlmkJgkwKbieKmNKoL3qu
 qFcg==
X-Gm-Message-State: AOJu0YwhxnzC/NZeuihuC+SPJQroheJDZSvpcuIa5ihFG01Iq0RPhxmt
 vjczBEnlhuuTbpWvRk0kSO0JZ3OyhdotEZNpjHXrYFNX5aN8AjHNIRUY6y9XQIKHLCP1EwjfFoM
 2p/KkqETu/Q8dyoh2lCZrYitzl4BCY9TTCjPhLO7WeuVrLmdMewl1OZeFrUsa2FT3AuT9OodDVx
 N5eQxqgw==
X-Gm-Gg: AfdE7ckYIh8cmvxIvRBdoMRzBHYDbc6WmnwE9iBlMqKxW2R1if/IBwzpFjkGvQxQpGL
 nwY+oLqBMuaCMt5z0H1c53r7nEJ0v79AOJsogmA3w2xDR0w3MI3HPYjSq6GNUYTgKUNUsb6c2YC
 ESvg1d1A3GNR2ThQSVbEB9bf4RETYmQKkQoDPj6Y5CrJ9x7Y15mz//RjaPt2xYlG6DgtO5duCnY
 HXngpF3Lkcu6874VT1w7pvNhzwPt3Eic2KZh8R/bv2uEovrNCiUmAsoND0VJ6gfrCX9gzqcQvEg
 MuiL3GYzFBXpkP/geFgorpKdW3aNa7MdZ/gvTkjfBi71eDJVRe02GY4R6l/pZ5GUjzvO/2YWjyk
 cC2kkRgSV82BZQcE9SjdtqXUyacQ+f2AI+kdWKXtxdWuSVNtR7o/tXwtyOMWrHd/8p7zLTL9tdx
 RpDH8lRWd4nFFHvXyK/Z2sm1p5qwPwndvohO+PsHR80ZHdFxOy5dneJKkOZLB/jP+zf+s6eLKvN
 KeTWASE1Z8KLnPaMrdeu3EFFP5wTBPycWkSk1Yjc/B+E1AfjySs3nLSd0qS8hOANsxqe0Yj8GXp
 ERw=
X-Received: by 2002:a05:600c:5391:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-493c231f8b2mr25778765e9.6.1782910292340; 
 Wed, 01 Jul 2026 05:51:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef23feasm48060365e9.2.2026.07.01.05.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:51:31 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 12:51:30 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic8c83132a4de64f27e6453ddb90ebcf137500db2
X-Gerrit-Change-Number: 1735
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1735?usp=email>
X-Gerrit-Commit: f0a65c3eb248ff25a418ac3403cd603bd5364782
X-Gerrit-Comment-Date: Wed, 1 Jul 2026 12:51:30 +0000
In-Reply-To: <gerrit.1782545314000.Ic8c83132a4de64f27e6453ddb90ebcf137500db2@gerrit.openvpn.net>
References: <gerrit.1782545314000.Ic8c83132a4de64f27e6453ddb90ebcf137500db2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkljOGM4MzEzMmE0ZGU2NGYyN2U2NDUzZGRiOTBlYmNmMTM3NTAwZGIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a905676c38c5423e54526bf5933d0f7deb5978ba-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weuPn-0007wc-Js
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: create and
 destroy Linux DCO devices with --mktun/--rmtun
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
Content-Type: multipart/mixed; boundary="===============3394605588175847246=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3394605588175847246==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FLqYfln555k="; charset=UTF-8

--FLqYfln555k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici=2E

plaisthos has posted co=
mments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1735?usp=3Demail )

Change subject: init: create and destroy Linux D=
CO devices with --mktun/--rmtun
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
> I was ta=
lking about this behavior change with Antonio, and we were thinking about a=
dding an optional [=E2=80=A6]
you could make the argument to mktun optional=
=2E Like have --mktun [dco-p2p|dco-server|tun] and if it is not there you g=
et DCO if possible



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1735?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Ic8c83132a4de64f27e6453ddb90ebcf137500db2
Gerrit-Change-Number: 1735
Gerrit=
-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbi=
t=2Ecom>
Gerrit-Comment-Date: Wed, 01 Jul 2026 12:51:30 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Comment-In-Reply-To: ralf_lici <ralf@mandelbit=2Ecom>

--FLqYfln555k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ralf_lici=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1735?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">I was talking about this behavi=
or change with Antonio, and we were thinking about adding an optional [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">you could make the argument to mktun optional=2E L=
ike have --mktun [dco-p2p|dco-server|tun] and if it is not there you get DC=
O if possible</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=3Demail">change 1735</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic8c83132a4de64f27=
e6453ddb90ebcf137500db2 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1735 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 01 Jul =
2026 12:51:30 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments:=
 Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div =
style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ral=
f_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--FLqYfln555k=--


--===============3394605588175847246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3394605588175847246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3394605588175847246==--

