Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96B2CDB479
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=icJgRL+eGmML4prEAhgwnh7fDxyxzZKj3mX6inp4WrQ=; b=JFrqG+lyh+K9JbxDEq7ISbACyJ
	7e47Tc+jHjRJVUVdH3OYqDSCJ1f5Yqxcpw0HAZ6dQ0ek5ZUH7ELQgwklNqCFu7ZQtn/NoC7z1K/jO
	56h+sBuOH5mFQtnWfaoNPRkkJLob4L09KlixRypQteXE+L8DmLKi9LB2Wca8CFYkpZGE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcjug-0000mm-TK;
	Thu, 25 Jun 2026 13:14:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcjuf-0000mf-Ov
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:14:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qnbgjlUGowi7M4l64CbxY/i1lam3Jm8le8GWDtwIcBY=; b=SMLEw+f3ZYPD8bcgKNGMLVzEzS
 oCWsdScNBJjcbag8rpuhlLPiOB6rQg2i6jMWm1FZIA6utWVBszy/aNTWBf7ZiDdTqbITjAxYbnuIn
 FdR0gF6vd20s0JgSpaJIOUicsDmwZ/h+6P/mLv31nCDoH7Nb5rkcJTcuPUg2ZcH0VZqM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qnbgjlUGowi7M4l64CbxY/i1lam3Jm8le8GWDtwIcBY=; b=O
 CR2tEJ05pGByiI1bVeOrZfazOYwGlHAlT2XMsO5TLQRja7hiMliF3A37jTLLZQRfRwUhY6vZR63id
 /n1ulIL78+Sxt4NEj4Dj1YxiWsIwQemGpo3RLPrVornCbBRsHE85qSAj4CQHtsqOalXDBxL1Fn9Ca
 BRh+497lp6dlDoqk=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcjud-00009h-SW for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:14:37 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so23011145e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782393270; x=1782998070; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qnbgjlUGowi7M4l64CbxY/i1lam3Jm8le8GWDtwIcBY=;
 b=Tn43ttz5ZNOribsVj7pASt4KqZFMtNGr7zO5HMgKp0COPVn6ZfuiK1qPP2BXpKRb2d
 XbdbMlFnYw5DC6RKafsU/AeLyr5p05qkhmBokK+b66u0aHItX7Kbn/hnsavuZQ8oeWFv
 QjYymc6QdiCwL6arfRXIL7Sxb22b15KnqmgSEPY5aROM9VliCkCjoPJXND/yalbT8cSm
 PgcFu019V4x3uT2bzCKSXNg9FJdHs8iIh3y+PKwynH16m0Em7DHuuMqJlAg4X3/moYeg
 bMwSkd5JRjD+IusjkGbg8+tBuCUNSAJRMh1RVFDHTFp4NCITEzZCi12euYFKf16DMJII
 C7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782393270; x=1782998070;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qnbgjlUGowi7M4l64CbxY/i1lam3Jm8le8GWDtwIcBY=;
 b=CvnCebMxRIdkZcYW7jPK7nDS4Pvs3s2vO7tdc8OphBouHZE9es9hdTsL/GwyzHF3hL
 h05VyQv67z3xeAZVOv0f1pIboSMGBxP6uvq8TbdzJKaKnEsZpXj0lNDvvKeHSZGulX8/
 Gy7fJ+xtc/Rnt7m0R3CZrQApmuDTdr4G0UfzQdoOhTOIi6BxxQM7YDX3xoWTV/7L614W
 ZvnhrYwWdEH2Hlm+6jC0zLsVkzTgGt7erPZWv5eoJ1iQeHtM0IVRvTDjapbmyee9drR0
 b0f4jCHMkbt26b8JhUdalvQwXqJ2k8CYIkO7Pz5gDw/MBKwsKlU2Ajk7gsjbxZG8VuL9
 sdXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+t6Hgz6fkVbkpegWLybREQXFoipOLRZRURHjzVswXbI9u+vGlssgqM8dZZMeKmOkgO9x8FDZO9S6NAFNPy@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwemJFXGHXqKn716ncudsKXiqnhg2jNBfJ2fI2cg3dD6zQfDtIu
 kTXTShVriW5mPsp4mVxZb16wu2fjwzMRMX+r0GT02U1uaaJjMs2Uardn+TwE0TmlGazXBQ9wB5m
 htvr33KZo827vs9N9BrndFzMLwiigD229BbM47QuR7ndgY76T4zPADOTLIBHZ8ZTom8j+nw77yU
 ZXhhCWSg==
X-Gm-Gg: AfdE7cl90MvNvE1a5xQIx2O9caZ8yvaAqxFZiqEYmNL80IUtxj80YHhfjrCKzZKf2D4
 ReOS6nQx2Ojz6sHGiVXpzO4zTVtPwdIakTcROLsvXiKZTbw5IKF8xg1t2MCUDmLhKh9oqFK+VcB
 9CoxCDQgdKqMxOoDBMw8OpUZOcovVVKN54jKGKQ7p6YNsWPlDqP9x8vUwiesRPuAOVaEbhhiQT/
 xFka3V0XfrY9Gw7rlyG7+YUWqBH97nV3PmuJI2nt5MlQQBsxDejNWIp//i0BChCWJ/tAE5f3Z91
 f1f6b4z9PajVvCWHP83eKNwa9qg3cQBCHC5iI4PdkVeG4Ds1ELnS8dNXbQGMwAhISkgpxbTImns
 +MkSBVpTsIPgq7989iPTvbQZGFllGlIUXiAuu2zCx2vCTKQYkSg0KJTAgYhQbR8MJu6cWWWZWVE
 TCNTT2rTtcxUsqXInIn1XjFA9/2rL65DuV7t3f8x5rfgg9zTG9ChBiPGUvEGfQMHWoZgKgRvcuD
 UAnYu6lN23L51KupLn00W2ivyu1EoP5Pa/kM45ghqwe2uPg6Ug/vTjSKbUPSB96MB0JStX9FgCe
 OTQ=
X-Received: by 2002:a05:600c:6288:b0:492:3291:9011 with SMTP id
 5b1f17b1804b1-4926689f42cmr34674705e9.30.1782393269579; 
 Thu, 25 Jun 2026 06:14:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49265975147sm75104105e9.5.2026.06.25.06.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:14:29 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:14:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
X-Gerrit-Change-Number: 1722
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1722?usp=email>
X-Gerrit-Commit: 465e1097541975a86ae6ba928f9ebf4be0755c6a
X-Gerrit-Comment-Date: Thu, 25 Jun 2026 13:14:27 +0000
In-Reply-To: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
References: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk5ZjEwZDkxNDA3MzQ3ZmFmMzIzOTc1MzVjOTVlMmQ4MGExNTc1YmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4a9932c7d9ff2c20a85033ca6c2cf75f76dce8dc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcjud-00009h-SW
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move incoming data
 processing in its own method
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
Content-Type: multipart/mixed; boundary="===============0387530437611382790=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0387530437611382790==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sHWiimDmYz8="; charset=UTF-8

--sHWiimDmYz8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1722?usp=3Demail )

Change subject: Move incoming data processing=
 in its own method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2:

(2 comments)

File src/openvpn/multi=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1722/comment/521a732d_f2918b0e?usp=3Demail=
 :
PS2, Line 3339: multi_process_incoming_link_data(struct multi_context *m=
, bool floated, struct link_socket *sock)
> should have documentation
Done
=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722/comment/46dfeace_252523b2?=
usp=3Demail :
PS2, Line 3346:     lsi =3D &sock->info;
> any reason not to =
combine that with the declaration above?
blindness when moving the code aro=
und=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9f10d914073=
47faf32397535c95e2d80a1575bd5
Gerrit-Change-Number: 1722
Gerrit-PatchSet: 2=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Thu, 25 Jun 2026 13:14:27 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@l=
ichtenheld=2Ecom>

--sHWiimDmYz8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1722?usp=3Demail">View Change</a></p><p>2 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722/=
comment/521a732d_f2918b0e?usp=3Demail">Patch Set #2, Line 3339:</a> <code s=
tyle=3D"font-family:monospace,monospace">multi_process_incoming_link_data(s=
truct multi_context *m, bool floated, struct link_socket *sock)</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">should have documentation</blockquote></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722/comment/46dfeace_2525=
23b2?usp=3Demail">Patch Set #2, Line 3346:</a> <code style=3D"font-family:m=
onospace,monospace">    lsi =3D &amp;sock-&gt;info;</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">a=
ny reason not to combine that with the declaration above?</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
blindness when moving the code around=2E</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demai=
l">change 1722</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
22?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I9f10d91407347faf32397535c95e2d80a1575bd5 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1722 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Thu, 25 Jun 2026 13:14:27 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html=
>
--sHWiimDmYz8=--


--===============0387530437611382790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0387530437611382790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0387530437611382790==--

