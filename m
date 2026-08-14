Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68835C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wSK4N54ayyMX587/AiuKngEQPAD9Qnr5zg24UE5MUs0=; b=hwEwrdFxnhQoWRpBhBdpfWRkYn
	rQhpgWhhq6qvl8zxxPrXrsMku6u9rY5gmniC3pGZ64Uy97tDHZMWJiuyR6v7Iuhaho/imRuSgLGze
	28tA6eJ1JbuIw4aUxS4f5xuX6ZX7ldmsWM6NeDOAW8nbxLybqaqA/E8YooxY3f9RyvLw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wutgM-0005Mv-T3;
	Fri, 14 Aug 2026 15:18:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wutgM-0005Mo-0y
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:18:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TcAMC35lmcOc4BklbwFQQXw+EUYNzL7SF3TG/UrZIaI=; b=ZDUyrnhaca5MojerUqWJYyk18r
 /OzRPPV9APWnmxVgVxsbWXxQnf4HJS/QBxRYrVxNeHtfTDMVxoOyBs9RcSIh8YYGOy3+6ip3dgaAN
 Ozqi/5ORofGtMLB17vXShng/JYhImJd/GMAfiBJAu1hVk/F0ZB9t0BQXpb8c1nh0dgf4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TcAMC35lmcOc4BklbwFQQXw+EUYNzL7SF3TG/UrZIaI=; b=m
 TyvrlMI4oft/VSoe2SgankFHt7DmPtgAIw2PgPZPkQNCTyyH/Sjc/xkLJ5He9mu8JcUjGq/XU11/u
 5d9vzLCQ0ao39jGW3Oy8ML1iaBeuKKVh6PibezW2Kd/5a+xcaFZaJh3qWKDNhsXibAHZeRMXent4+
 w4/95A0ac/DssDf0=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wutgK-0004Kt-24 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:18:53 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso1018449f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786720725; x=1787325525; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TcAMC35lmcOc4BklbwFQQXw+EUYNzL7SF3TG/UrZIaI=;
 b=JqeFXImGfTefDzbEtWwxTsBgZReBz5+aNYmzR7MY6ApoqaVdTb2gB7z4jC0BmFTpjl
 oDgU1NyHPJu9Yp4neN2ay1/SF1PU6uSF3L0Lrgycb35FE+aJm+Vz88akXgsGrKyClrcv
 9MHyzmE6gKJO/e+lOTjwkf6njIiVyeeI86JyN9Qwu0fFO/fmqiWkfWYYjikkbI3iIaOj
 KrWSViTiyakPS77yS79DXIa2J9a257kuTyT/ihcoXOjAfeEijua16DsP9Rtjrj4a/Q1S
 wbEherSVUuWnjr3BK7DYErnMwljV5IBpii+DG4o9JzCa2L0p7K3xSZ/qbo5A/V041FfX
 O2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786720725; x=1787325525;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TcAMC35lmcOc4BklbwFQQXw+EUYNzL7SF3TG/UrZIaI=;
 b=UjUv1pcSWTsZ07PRtRP7u2bYk1TM+geqfd4kZ4a76RMEOU4suiPMr+YiTpkqivqj1P
 780cNEU5CdKK14Mg1hViM/b/qm+tULrSyEapXX3Y2OpyDcVzzbMC9OTmy6/uROUYoPVM
 rDEbh+Hfe0cwiIjyEXaLTCoZo+p+BOm+Xrkt6qHOx5OnY1jokg6gDcDWXXEZWDrfcRkT
 fdjQSmYMWXycBsueDs5RRbJ9W9zk7Rt4VZysdwG//m0pL1Zvh5viECNgs9808JXt2J+a
 EFuQIlfdK9/rQtIOYO3Mg1QEL4dX2DUTj10F6aYlUdbPAwCrvEV80Ax/8o2plA0oztil
 g+Ug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqmbx387V12kogck2wWODCyc3tJOWhSW5bmpV4T7vLxrEugF6lhPh+TP+CHfeY2RSVGjbv6Sd0pvtD5q2Zh@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxvMWyll2O3VB/MAm78NO5+QGJNiITibUDZIdAjDVTxTmHHqBwG
 XOoGqMv1Du1sSdPc01EJInMwi4hYgIRM+nAWaA9eYbVPVccwYHJn/3qAFwY2+JfGM2M7+fOaATg
 8omw+ISOEC+RdjO+J7V1LI0CWgt8BDqLrvJ18mQfyegAgElTM4PUhMuw9TLVKASgeRStX
X-Gm-Gg: AR+sD10m2HtjLzhUp9qolWXb+xe3qwi7Jp0ueAazOldAH7jm/ZjD97WTADbdxkHWmGN
 aUL0jvWlJrkYrP+wEiKMXQbXhWk9UDO3Qj7cjMlZBIU6DPrkHtAX5oYTwBdOmjPHhbqRDd2ykKz
 JFY3hRZtz0J5Xji5HESawPeIft/fWCdVT/wT1wf5BQdReUpNZIwN5nD5biE9nPDwz4GEfFDb56g
 rli0RgIGWcqXpTjXauA66Kj2R6TTA2q4AGmu2Q6+JJNBfBOIHdvOp7kz2jBu4IJdGRpgD/7QU6b
 9m81f6Ge11nCkaZDakvAsSgMpTH7yo3hDVf3+DtSi0oVbuammBuGYFNx6sV8mWBjT8SzJgdPLY6
 ruPmzBu3/cLxi73ybAsN5zb+WuicnvxtsacVO0EzjVvDoBxKguOjtMv36Pi24IEZ8Nj8yrjAguB
 GSqRYx53wcSxVQFshlMaXEuOOr3mS44efh9DnsX/stOg7IJbosrfP8vkqTwo3vQ+My5l8Rw8oCC
 IfUkBmdhVoTU3RS16cMJetboYCj2PV2HYlE7JqUXxXEJ17ya8kotrkMM1iMFNt+abimlF1fDLPY
 xFcpuexw+5KiqXDUwM3JnMuKNN7qlj2ntIFYvLaXa/TFnS5esAGNcEhzXC3Vt9Q=
X-Received: by 2002:adf:ec02:0:b0:47f:ddc0:602a with SMTP id
 ffacd0b85a97d-4816078a582mr7517397f8f.18.1786720725340; 
 Fri, 14 Aug 2026 08:18:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f21a068sm8857463f8f.12.2026.08.14.08.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 08:18:45 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 15:18:43 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
X-Gerrit-Change-Number: 1776
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1776?usp=email>
X-Gerrit-Commit: 7f3f56c1e3ec3751f9f88957701d5eb0c192f93e
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 15:18:43 +0000
In-Reply-To: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
References: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjEzMzg0MDAwLkliMTIzYjdiZjU4MzE3YTFiZTVhZjFhMWQ0NWRlY2I4ZjMxZjJlYzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2d5595626ff20e706c56d1da1b0513cd88a870d8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wutgK-0004Kt-24
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Start a new document
 CODE_CHECKLIST
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
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3796675412377550419=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3796675412377550419==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UdD4M3o6RSo="; charset=UTF-8

--UdD4M3o6RSo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

ralf_lici=
 has posted comments on this change by flichtenheld=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1776?usp=3Demail )

Change subject: Start a new doc=
ument CODE_CHECKLIST
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2:

(1 comment)

Patchset:

PS2: 
JFTR, amusingly Sashik=
o (the kernel AI review bot) picked up this patch and performed a review=2E=
 Apparently it found a few typos and inconsistent markdown escaping=2E Here=
's the link https://sashiko=2Edev/#/patchset/20260814103024=2E28342-1-gert@=
greenie=2Emuc=2Ede?part=3D1



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1776?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
Gerrit-Change-Number: =
1776
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-CC: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 14 Aug 2026 15:18=
:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--UdD4M3o6RSo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">JFTR, amusingly Sashiko (the=
 kernel AI review bot) picked up this patch and performed a review=2E Appar=
ently it found a few typos and inconsistent markdown escaping=2E Here&#39;s=
 the link https://sashiko=2Edev/#/patchset/20260814103024=2E28342-1-gert@gr=
eenie=2Emuc=2Ede?part=3D1</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail">change 1776=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib123=
b7bf58317a1be5af1a1d45decb8f31f2ec68 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1776 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ral=
f_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 14=
 Aug 2026 15:18:43 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=

</body></html>
--UdD4M3o6RSo=--


--===============3796675412377550419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3796675412377550419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3796675412377550419==--

