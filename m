Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727D5CD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lSwnNl+X2EKUCMx/yJWy51x7fZR1TNlx6Y6IeL0Pi9E=; b=BH8Bk7HUXsVEudX25O6RL/JxwO
	lhtOosnPE9s/M1/XtEFZHrhzlF1RzoHDHdWorLhj2440oOq1/xZ5GTcvvFvdL4L6iypcF1Gt8ESry
	copttc2RwGnfEoL3snmikjHXmOMrpay7emQGb9W9OOWUf8WGPEzGl6/VqX8QHmEfEWro=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxnu-00005W-Nt;
	Tue, 09 Jun 2026 14:51:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxns-000059-TB
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=we3o9u4KPF/y5q8wiKnP+fuR1xGYo48wbVIY09jJrzc=; b=JK41D8w55Jfs4Br/uI4DUwecdm
 abw2DO8LaGHGHO2grJtt7+zHZBqUTPA66CVupJS1c5V0HsvgwZMyncGqiH9QX6c/n9QUWIgMc3W2I
 FudtJmLgM/XntO9i01BHHmAwvxDsfVkRvRaEhmI3v3Xr0L6QH9HWbpXm1FzuDFTKJ30w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=we3o9u4KPF/y5q8wiKnP+fuR1xGYo48wbVIY09jJrzc=; b=Y
 S2ta42PJU6JrSwF+39Z4rXoIsihu/LSu0E+fqIzKvKsF7Df1q6yYnqfT1hZXwidYPAPgPFDEjHg81
 ddSUEhMRCkJs8hztfrETXF6UxTDFlxYqNmUWbw9WuzbsiuHvP/Won2Kee2uanZGCkqjjffPJc3v6m
 4ejJTy2xBvSruakI=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxnp-0007gG-UE for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:51:45 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490b7866869so63472715e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781016691; x=1781621491; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=we3o9u4KPF/y5q8wiKnP+fuR1xGYo48wbVIY09jJrzc=;
 b=TT3gX3Qn9qT3WsKWU6OJs2JOsD84HluBB9WUawiGqB4H9RvNwFX+cRCnuvIq37h30q
 bTTUAVHyiXkeuDoOC6jEZmMoBjEDG1XVAPYCJtBa7M1FOOSSjcph9e4g0Mf37bIbX6zW
 WcYOche9kdac9hwbz0pxuYKDpI5DyrXPsEvMKGm5TW4NL3usDJ8imhxnJOzAfW5Ezc3/
 ASxi8AtYxvKURaNm7TCUoS0oKXAJkyH9jOb46XjVt/jmcHkF+dPeEMRl62mIhfkDBPuV
 R6MxI32OZyCOLwbkXfUcfqxCB0LbyWRyjlqjTAlZXqALUwzl9FVyXykB8bTwJnBIlMBr
 arzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781016691; x=1781621491;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=we3o9u4KPF/y5q8wiKnP+fuR1xGYo48wbVIY09jJrzc=;
 b=HNXxYviXs+wk75XRNxwIGevfuSTvk8w2Q+MAI4en/9rr5OLNlabnFRQcQE8ehXx6G2
 2IhCkQ/NMBoAZyZTUfSlDg5moY64zLxCEgbAZYPXl1xT5f5C9EEG5/nJ6AEBQJ+tapz3
 SMPTGnmaAkEq/PYQ0WHTKQpn4XxNJfTRzvTJ3K7HOu0+2THclwrgQ4II4kmwToWc4J0U
 laIXrDaa6C2XWdHVk5HMzF+7u8hLMTgmxP6fRsxUE8JqqWkESub6Fk+CMCHfcDxY5MKz
 CAIgejzLWl+IzTCJ10jvb6Sb75eooJwUxDwdWhsOsKaTFugoPg/VeLTlbfT1pg2KGonH
 gcrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hRhgFc5dg0iAYPsddt+EMizL9VJBBt8mzEwY40EGD2r3Dpy9srgefROCnqBvCqZ4+hnM6PNplnW+SLX76@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyJ1G70ZhCjzCg1ZxXe+sJLDrGdhjYA6Orzt7pFE+QpkqObdqhS
 J3iQtz3+c1ga5D5BlPLtcnV5RAYDOLb8amA+4VYs3av1+J3ylbKH4HDVSdwYp/pPHDslb2ZC4Bc
 fDDGnFdG5CI4n3nYEhfqJvVXT2f+XttTChynIBbvLlcflPvCmw0hz5NEhoR+ro6Z7uxey98gLdg
 VxkZ67zQ==
X-Gm-Gg: Acq92OHvHszPLhEUK6XtnEola3uhn3AzLNGdzljlD5RTTA1xulU7YGui5IMbkTBKNRS
 dMTvGUPtnnhY+ctMtn9FyFv7PfaVSQz+z47bEaG6qBaMMj7Rp0oRf2EOurpH951qirULMwJ3x9x
 bMsDZtZ1qMya7lA5/Co6qgGgsFXh57FJMCPodkRk3xLRPeoBBIqqm5qgMDD0GKBp+Mr3f7mXEhQ
 gg4R77pQceo+Ri6/Tc1ZluCyJKabh32j7GQfNcJLT5GOZc7O/Kl/AP1x0jPGcYGvA+sYmvq2RWO
 OUaot1PblKlhE421EVAGjBWXdePR6QFXXp/oNnkV4bLOnzonwwdo1zJ9tUs7pqArgKds2KQTZUY
 phjSmLltWoXO6yYph5ORS/+DbYHPEePIB+efQTfmYcqbwOvaGTtcWu6v6x7LOjGTzK1NTz9+zXh
 EjnFyZqOC2tq0A3Y+wE+H0LybtSBRk1HWqwBLuiCmEskeZU8dguH1bNIXVfc1W3Usehd741Nw3a
 vlfyzffBikbtxmyuc9Km58jSmmuhNDXI8agFyqQuctrXVae8E6HraPNnGIScYroUc9jNV89UNnz
 3R9lUIpD2Xh1MVjqreD6YnFzY6SgT2Y7KFY=
X-Received: by 2002:a05:600c:4e04:b0:490:cc1b:15c7 with SMTP id
 5b1f17b1804b1-490cc1b1631mr166902245e9.30.1780991641522; 
 Tue, 09 Jun 2026 00:54:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc391aaasm531050275e9.1.2026.06.09.00.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 00:54:01 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 07:53:59 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
X-Gerrit-Change-Number: 1702
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1702?usp=email>
X-Gerrit-Commit: 9bb6c3cf8378bba2bd4c7ae2495f6882de92cd95
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 07:53:59 +0000
In-Reply-To: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
References: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5NDU1ODgwMDAwLkkyZGYwZmVjNzg2MTg0YjlmY2Y5YjdjNTZjNzQ4MTYzMjVjZGI2OTQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2479b81e679e26a8a745dd44a9bf14bd643fa9dd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxnp-0007gG-UE
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mudp: send HMAC
 reset reply synchronously
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3180347906945833390=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3180347906945833390==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SnOVimnagGY="; charset=UTF-8

--SnOVimnagGY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos=2E

cron2 has po=
sted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1702?usp=3Demail )

Change subject: mudp: send HMAC reset rep=
ly synchronously
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1702?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
Gerrit-Change-Number=
: 1702
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Eco=
m>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Gia=
an <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 09 Jun 2026 07:53:=
59 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--SnOVimnagGY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos=2E </p>
<p>Patch set 2:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail">View Change</a></p><u=
l style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail">change 1702</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2df0f=
ec786184b9fcf9b7c56c74816325cdb6942 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1702 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmar=
co@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &=
lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Jun 202=
6 07:53:59 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body>=
</html>
--SnOVimnagGY=--


--===============3180347906945833390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3180347906945833390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3180347906945833390==--

