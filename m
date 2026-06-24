Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56506CDB47C
	for <openvpn-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ivDtqO85zzY6ve5c1VIMj1WfGZTcNB8WbBHrAurEsDQ=; b=MtK0I6/a6/MxYLBcrJf0TM/PJA
	N/v5k8yly9XMNhJyTVcAoXn9XwyisUvxpjOuThdSGx8dyXMr9iyAOn/MWeHAODDEgNlHPkzxbb9Hh
	jZ6au2XwL5ug8JGK71Z/7Hi/pKTfJhjhqefWrw6Dp1y4d3ZX0zM01nSz2bgDQDpofuhc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcLCR-0006z8-PW;
	Wed, 24 Jun 2026 10:51:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcLCC-0006xq-OD
 for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 10:51:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wRxRrNvJq7bDpEckoKOBCPbXGtWzQbd6Rt4DVgm19C8=; b=bM30JyBH+eIDCSh6/HBIiUoB3r
 ZJROX7rzZ8Hr/pfXNAGqmPJ/1gko04fB5Vj/UGlcGEHWjtm6dyrq8Dk4Khg/McxXAWgH6GDuO2C+R
 8e0VvbZDQ2Q74BpSH9Qv1FGEiMCXznlSrwD/3dT+hd8JW+p3wy0OWfk39hycV9/VnBag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wRxRrNvJq7bDpEckoKOBCPbXGtWzQbd6Rt4DVgm19C8=; b=W
 JSu6g9SWVXODsUFSrJd+p5hYKDIO4dS4nUNUFJtOQCP5qfnKkuJQymu9pBKHC93mzYURQYOAPl2Vm
 Ri+94vgMQTdMkuCxVzSBze+v0j5CdUR3RxqvQNPgmIm9xVAm+LR/gK9AxvPH7JJEBsAe3uBJhMN+L
 vgGCKOQcpKnWtWsg=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcLCB-0006iC-QG for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 10:51:05 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-46cbf263113so222342f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 24 Jun 2026 03:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782298253; x=1782903053; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wRxRrNvJq7bDpEckoKOBCPbXGtWzQbd6Rt4DVgm19C8=;
 b=ZRbuUXPfCym6/r4BJCNO6D9ZztrAeGzCF3L4kbwhy0OJuY2+Oy7tVCglznw/I10ctQ
 VacI9ijt4ZrZAL6WKVKK9XK+btFAqhItRnAZDJIdqtCDuNsbUVc9OaaDfDKPrROml57q
 Qt4GmzrdWPEyCrymkN4aZGAtJXfGiHb1z9UUy/7DZ65LqZtkpfAAXJAk2KcU3zd4wolA
 0/q2xGtaDSL2aenz1GcwlDb21ujaPXi8fZpnakR76evm4IJ1xChtp+c71S5xJgWLxpYc
 P9yXLIf+vAwqqqfPZ7/Hn1TEVSb+8335RI2HsLZFbZi139YaVGFbr5re1wE8/EXGCcof
 JWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782298253; x=1782903053;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wRxRrNvJq7bDpEckoKOBCPbXGtWzQbd6Rt4DVgm19C8=;
 b=Vb6v5sQ/BXk7LQGLskRBMGAJ/6Vw65IXkRIv6166lc5ga6y8PCQj0pYJ0ZKHD4MC7m
 6jD772csdrFFyn2gPAGy2D52DmvDsGWbfEF5pTDddYoocgIN0+dYj5DNIjdncU4PgvW/
 /AIfhs9EWeQYMZSEKlchU+2pS+eyC9VwlZ33Ybtbc4orhZwdxvgVafyXoRSCnVLuQpp6
 6NybQeg0LgKZDdN5LG2HWwT1Pa+aTjrrygeN3PjVfB2UzMeNkMXKlYobMStqEf5y+itX
 BJ5NWUauNIJgnr/KWGhEifT92i637DeQNSKCYBd7AiPauOIo0GpAclzXx7YQTqjSDSqa
 VA4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ99ZK96LIKPHfQE0DjyaLBJyp0Q7r7eW+dFkJzec+jAC2FQpysdljMUBEzJBJgyX1XWSAF9zikYopZJ4Zmh@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwEE3GMFt58+MphQKbrdPcbeHgjngIhTvAv5gughJJGwAjGvtD1
 3Xf6pkoLzJHWn9q8mvXSd+Wxsfc/iNe86CwX3lPQex7hSu+H92TM4Lmd/gVaeRqfpCjKoZ0Rev0
 +3bEmxNKcRgjtQsrMhmnSv6ESWJbitW9isB+0MSs/FXvGlAt2cybafwMhjsXH9StxEPVd
X-Gm-Gg: AfdE7ckiJSvCPsPo8QsaMOgPZrpTT7zSyYhQ5Zqrg45IormzCmfUNUUK9+I3EBdeKTn
 uWRJwD9NUgnAKhGNWBLbPiVhJ+1eZbUjAHt0h5rTg5Muc5wgoPz45000J/oTHSgh5CcyHPvgnsx
 rjG0rB7JcQqdIcpCwHsuk2MBe3VX1oVSLilSeeAkSRTvbj5ewM6a+d1ugI3sGSZV+Mmit2hYJcX
 U911fAnTyQcDOTQwn4499z0jLo75pZQ60vsp53Gjbfg6JGJB5QkjR0w1uGkfni7wzIPacs5pnF9
 V2R4/WLl1c8q3ZY7e4j1y7seIurlXQrlnqEnvQhOWX+/VoKowaCYl6vefsqJCBopwwEVPhMkEI3
 oAZVoPqHeWPYcm+CyCBxUeCSTS3aGD6xfwLbq+V8H097Tct1PLZNOYynuxrk0AfHGwQfgvDAesL
 gncnTppV2T1pGaA3RfwFfBsg+VaJAtCSc3YAIJzyvFb7Y/5MuUCS0uypTifqV+K9q2jxHTScT9b
 Zf72GPCpK1+7ZMuHZDMlpXn6AqTARHzyGwQA4RtCMXWNXQ1/fZr0L8SEz4AcmumIP0lmLK56iEg
 WNk=
X-Received: by 2002:a05:600c:c4b8:b0:492:4050:d495 with SMTP id
 5b1f17b1804b1-49260879083mr39689395e9.30.1782298251628; 
 Wed, 24 Jun 2026 03:50:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd154fdsm415986255e9.1.2026.06.24.03.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:50:51 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 24 Jun 2026 10:50:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3f9834cc13c49b9249653d7d8637383f50c2fb87
X-Gerrit-Change-Number: 1729
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1729?usp=email>
X-Gerrit-Commit: 78a52c142ef1f4957c01f932c088fb78e58ac5a7
X-Gerrit-Comment-Date: Wed, 24 Jun 2026 10:50:49 +0000
In-Reply-To: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
References: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMjUyMDMzMDAwLkkzZjk4MzRjYzEzYzQ5YjkyNDk2NTNkN2Q4NjM3MzgzZjUwYzJmYjg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ebbbe719ba0b428cd12e441e06af35866d2f7bbe-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcLCB-0006iC-QG
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: don't let
 stale-routes-check delete permanent routes
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
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0405827720347827610=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0405827720347827610==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TX83tVkWum8="; charset=UTF-8

--TX83tVkWum8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

ordex has posted commen=
ts on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
729?usp=3Demail )

Change subject: multi: don't let stale-routes-check dele=
te permanent routes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/multi=2Ec:

http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1729/comment/a9a46ab7_6fd7dcb5?usp=3Demail =
:
PS1, Line 1363:         if (multi_route_defined(m, r) && !(r->flags & MUL=
TI_ROUTE_PERMANENT)
> Why do we need the PERMANENT flag? Cannot we just use=
 here r->flags & MULTI_ROUTE_CACHE? Or are ther [=E2=80=A6]
as per the comm=
it message:

"Routes learned from configuration (iroutes and pushed ifconfi=
g
addresses) and genuinely dynamic routes (TAP source addresses learned
fro=
m the data channel) were both added with flags =3D=3D 0, so
check_stale_rou=
tes() could not tell them apart and aged out all of
them=2E"

hence the PER=
MANENT flag is to make the distinction clear=2E Those learnt through TAP st=
ill have no flags and are expected to go through the stale check



-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I3f9834cc13c49b9249653d7d8637=
383f50c2fb87
Gerrit-Change-Number: 1729
Gerrit-PatchSet: 1
Gerrit-Owner: or=
dex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-=
Date: Wed, 24 Jun 2026 10:50:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--TX83tVkWum8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1729?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729/comm=
ent/a9a46ab7_6fd7dcb5?usp=3Demail">Patch Set #1, Line 1363:</a> <code style=
=3D"font-family:monospace,monospace">        if (multi_route_defined(m, r) =
&amp;&amp; !(r-&gt;flags &amp; MULTI_ROUTE_PERMANENT)</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Why do we need the PERMANENT flag? Cannot we just use here r-&gt;flags &am=
p; MULTI_ROUTE_CACHE? Or are ther [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">as per the c=
ommit message:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">&quot;Routes learned from configuration (iroutes and pus=
hed ifconfig<br>addresses) and genuinely dynamic routes (TAP source address=
es learned<br>from the data channel) were both added with flags =3D=3D 0, s=
o<br>check_stale_routes() could not tell them apart and aged out all of<br>=
them=2E&quot;</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">hence the PERMANENT flag is to make the distinction clear=
=2E Those learnt through TAP still have no flags and are expected to go thr=
ough the stale check</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demail">change 1729</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f9834cc=
13c49b9249653d7d8637383f50c2fb87 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1729 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Wed, 24 Jun 2026 10:50:49 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: N=
o </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--TX83tVkWum8=--


--===============0405827720347827610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0405827720347827610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0405827720347827610==--

