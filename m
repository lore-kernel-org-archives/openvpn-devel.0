Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACE4C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hjqxl1RjdBiMy7I6jYGHOG9jF89YR/AjLPhamRrh9y8=; b=LzElS+VYb62hxMTSoqS7WV6khF
	+iUo6iiBcbwV/eBt/+KQP99vCqYYnRHVmm91BbF35SmMhREhjQyLF8aQttfZ5im6ujZrjgCMezgN3
	WQyr/kZ9HJt1a28GRSMVQr12GyeEi9iAjf73wePpZAX0bi3C11BBP1Qwy5cwjXGxYRH0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnCx3-0006in-U1;
	Fri, 24 Jul 2026 10:16:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnCx2-0006ia-Vf
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 10:16:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=X+SQv/2qng6hPUPePoAfHWZcu+rcH4aooFxfCdWmDq4=; b=iU2qg1uhLDMh0fcH5bkhrVn8ul
 pGUeiQic7+NFa182hOVmscHjjPLV+Q1gtNm/sicZXzyBmadNu7gTZIrikVIdbdUbYbECESt/fiY/L
 fuJcOGYLWAchwlSG9I6za/XEe6+Mk2pRgL8eguHh7e/YeVlWiCJp7nrVE8fYCjwdfPS8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=X+SQv/2qng6hPUPePoAfHWZcu+rcH4aooFxfCdWmDq4=; b=G
 /npl6QYAIGNRzHTujMR9XuV9D2w7JLNzf5j08jMFEN+mFkW9x4mtvo4rccYiEUVm401GT+wphHlvu
 hU1MW04exdfXd82JoLu3nNTRMgsYMnWyRGfcm1Ccaju1bbk67aSo1UNdhdnxgPYF82wRwtdQorp3x
 sfaXEYqU46qAxJvk=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnCwz-0002eM-7s for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 10:16:16 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso260130f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784888167; x=1785492967; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X+SQv/2qng6hPUPePoAfHWZcu+rcH4aooFxfCdWmDq4=;
 b=JsqmYUT566sqet5isxtdlbhgEZnc9HFvEfRk1Nmx/xi6HJHj0AGM78rC+4nee5mFe1
 p6hnr2Le5DwLuxBw443z0RUTtfy6FR2szQn3/C8jfIvGWh3CXJRj542sVNFpvy4c8vY0
 OuAH73ezq/nyWU/EnF9oY8bK9iauF2QOIB+HwyZip4zdyghQcUvONS7XR1gGIHqYiLYu
 qjaJmUXI27X6gi/flmOVwnEALrGFfNqB8rq+Ey4X6QBViFZdbhJh+owmrYbg94fPHqNO
 QxLwbaGGaSB3cMEjpyAXReFHU6EGOOrgbbWLbVkTpq7c7Lc4J8Sr4DyFR/r4I9JObJdx
 H81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784888167; x=1785492967;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X+SQv/2qng6hPUPePoAfHWZcu+rcH4aooFxfCdWmDq4=;
 b=Fo/Rol/74uayoN2G7fkdJGOaZBrCyFyFyhx/Ujs7/vkbGrnF+poqatLT7t8sMhtD+1
 FrWDof3Uq6qzx5/XKqAt2oBYlEzGFxyip0ZmdxUmiVv6fg0q5/rz8D/ouly6MGmNhv6h
 TwTCLF5OBAN8Zz8osLvmhhzJZxNgZPRgX6Yv72bJhwbVwrvtBbylciD1DmLB2KvEdAAq
 aLwmir2odjday1EqYRWVMK/YQrEUbkn4AW5ntErxBCQ0eG618xJyziKI5iQ2NxZs/wjX
 nh2GgiJZWDnfiOnd2MoxBrZ+4hbvQiP3vQLsON11yxqirqypPWd0H7Dg3r+muZcZVKk2
 DXyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNqc2Nnu6thPHqB1UcYv/FEF2wCSogTb+/YmNcorjbGpMy4wm2DQmhku4JKO8cJ9aC76L1ZULG9ylQTfwl@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyCe9C9WdCzMq0Obk5aWK4PVtkT9cWN306YClzKGkPW1trqyz+l
 9KmuqNkpMp6DsqeDQOjMxFPkoEj40dIMpzyaCspW+/Fg1grfRu9iFI+nvc+sR7Kdr9cN7xQLPN9
 wW/Zabjc1iXInvdzS5m7GtCGe/0fSapWgqnNAYkA/2nzEjBArzZ61YBGAZzmgHWWOl1iX
X-Gm-Gg: AR+sD11dVXWfr8FfCBmzkavdxl6pYiPmXZi4i7P/YSUL7HBgK1CFCmVxA6lLQW6Fcl8
 RS2wmpG6Nv/hyHTS8AAiqEiabqQoGM+xgR6BmnerjNyo8FGJloCq0gGGFdf4yZ0RIbv3nTwKJa/
 kbvk//uz9ssMUzuWkOmwEQ9J+JndzSPnzsYuCwb7mFVeFy6C2o0WJZwuWsDEdYvleHsA8kdMcIs
 BAzHmvkGjodJ8SmWqwJew5XjwOMsju8r3nJm/tXg7/tBnxUj2epcmHKTPxk644tpOKOJxctCY3C
 7bkudSD0qOqdOusE7d9cCusSuQqz8GUwLB710geFl+VnlfgtXUDz4ce9QUmUPSd3Y+t5dggQ08k
 tbjkwExv0haqDWvTXEs2NSIejs7eIzCiXOgGWMpNDSABv7KyUt7BWZsAzX4Fj79H05BIra1iq2R
 KjLb4l0/gON9EII8T6uFmEeYMA6QqnUNVjw7j2CH/wrvBt1E9z6i+KdRYTkN+z6Aj8WOotKggtH
 HRa9qAHLuSNSIQOxhp13e+INWc/BYNgdOnwqSXWm6AwWxhhIKKlPztmR5xY1O2lrxYr
X-Received: by 2002:a05:600c:4f8e:b0:493:f78f:cd70 with SMTP id
 5b1f17b1804b1-49573cfc965mr97216005e9.18.1784888166855; 
 Fri, 24 Jul 2026 03:16:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af910besm70951315e9.14.2026.07.24.03.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:16:06 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 10:16:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a
X-Gerrit-Change-Number: 1537
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1537?usp=email>
X-Gerrit-Commit: 5994bb2e25c5da7108da5c9e7c44aee8be1a9fa8
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 10:16:04 +0000
In-Reply-To: <gerrit.1771284291000.I0ca7b5b7ec1a01acaad222c99db137c94c88555a@gerrit.openvpn.net>
References: <gerrit.1771284291000.I0ca7b5b7ec1a01acaad222c99db137c94c88555a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcxMjg0MjkxMDAwLkkwY2E3YjViN2VjMWEwMWFjYWFkMjIyYzk5ZGIxMzdjOTRjODg1NTVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9ec4141a2c2ea67c68032f95251d2d1dae9486f6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnCwz-0002eM-7s
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: make `tun`
 the default for `--dev`
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com,
 gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5163719375191097692=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5163719375191097692==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dV4KXatHUA4="; charset=UTF-8

--dV4KXatHUA4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

flichtenheld has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1537?usp=3Demail )

Change subject: options: make `tun` the de=
fault for `--dev`
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1537?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a
Gerrit-Change-Number=
: 1537
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Ger=
rit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex =
<antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Fri, 24 Jul 2026 10:16:04 +0=
000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--dV4KXatHUA4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 3:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1537?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537?usp=3Demail">change 1537</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ca7b5b7=
ec1a01acaad222c99db137c94c88555a </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1537 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 24 Jul 2026 10:16:=
04 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
=
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--dV4KXatHUA4=--


--===============5163719375191097692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5163719375191097692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5163719375191097692==--

