Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31120606A329
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JBFYuByz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G1LIdFsB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XC4JnH2v;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SsiDhP+E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XUnPwwmtdm2pDeg75hdp9159oavS6qT0My+wnIZ55YA=; b=JBFYuByzLmOOcsTsPicidMUvMY
	vzOJqvTazD4seSipwftMci36rzKo9LyOOlP3I4sLRZ0oPwftWGyUAdkCrKUZUdK3KVobQtZ7IAV6F
	8vqWdXUgdRKDUWvh4lwzAMtB26xv9lTJaKJbQy8w0zh2pjqENRZMg1QKSxm9VLlT/je8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMtJo-000000006UL-0wx4;
	Fri, 30 Oct 2026 20:35:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMtJm-000000006UE-0Tn9
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 20:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AtsG0853+DZgc+0HeSoEq/rAxum4HwCfuWR4hM4pQdI=; b=G1LIdFsB6K+IuLNA2Uh1kOEA4/
 LuMgJe6FOKs3/swsGx5RDlrHitP1k1dHFTekRH5kPEjGcyZC4OTomY7yMzeJz0aND2O9jhrEvjd64
 snQgcpXcakMAc/SZM1//Q9LC6Xzg6gpSPLtZ+zat+Cv775zashZL6JhZdjRBFgtvnZTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AtsG0853+DZgc+0HeSoEq/rAxum4HwCfuWR4hM4pQdI=; b=XC4JnH2va02DeWaK44qxGlEEEn
 ysMnP7s2C6FjWXxx2Ig6RhrBfBBWlBRaZPbIrlwUijAouDYmxIlYGYfxKcjC4Ifl/Uf5xmDY0y6X4
 9WbbQ4l8Sfet8sjM86J4V3M3XzKPoDaBiF1ZP/tjkxSlnU2VZ8R7iBC2tRFLP4c0JaYQ=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMtJk-0000000082a-4Bnb for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 20:35:18 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so932966f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 13:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793392510; x=1793997310; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AtsG0853+DZgc+0HeSoEq/rAxum4HwCfuWR4hM4pQdI=;
 b=SsiDhP+EZPTWOmZ/xhauaY5qEfZP0trcLZvmOCth6oyqAnV3nYqE5v1elBKaH7MdtG
 bm0lfy8L10sLdzEni8QdtiSRu2vx5AooW6IIbbhnvIst/MQiInRsxuU5UgVER90aqQOi
 m/sM3LgJGKOOePuOezk3ZWZl6iGOj34szd23YRlw/yV6bF+9qfc64jurT2om+KsZYQlA
 8zw3rUDg8/3MVbUx1kUpybX1VJq1KOwrzF+vkCR5ErC/5jEY/1kzE0SZ6y1U3cLUJkL8
 9CRX5dkH/TD5DuY6GNlZRuJJqttdITaDJZSM4iQxCTCdOICwtzgJTkt2rF8MF647/QWT
 V4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793392510; x=1793997310;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AtsG0853+DZgc+0HeSoEq/rAxum4HwCfuWR4hM4pQdI=;
 b=1/KU0Ry8qyL47v+eqDzn/ce55te4sakwpzQGW2SRK4UVcgJurQ71nkjO5qosvhM7+A
 UsdB6NQ6RdbrEYcE0JdoPQLaVSnD8lm8zyuIFtUYti8Q/WXbYm79KM6kp20eU8Qg0Hje
 ymjWBEtI/7iCGyvjrrXHZRvG+Y3XrN1njPcTBEdDiLokGeO43eVkdBElcEaT5T7+LxuQ
 mfWFhzcMXpvdlya5aEDFh+fF1eKtDUFBmF9D8Ip9KqQmbvZNVyf1tYoN60r4ROvMVkNV
 pRHIXvtuXS6ntEXAT9k5OUitpAREbYM5aD/UfDkcBaotK3tkNPadLLUe6Hwq+Bv3d1/K
 QpCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfsARJHUzPwlCycstM3qpR69OuAKEJEM7bKrjTtRVp7vHAvGJxF4TPV1KVZ7usKNz7bDEDQjsMtNJazmPw@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIdtvNv7OL5MtfD6eZSv0lDL4jqbkkF9i4CovTsoAGOmrwrycfJ
 RMED9RAhnnm0tTITlQKaq3mcXOXF4tng1o73YHBch1Y3zJsu9VJiSV5NeiNHlsMnOalyUwx8vUQ
 D+kdxt/9FrkgjxJPdzKCyRa0A6Db4Rvn/dHA9HUhKBUHyeE99klOV5qHALFt/otVWgahd
X-Gm-Gg: AYBFou2mEzgECrNYxTVnNTkTDx3qv7L+xdON/eJpCAXa9M8y2dyfVmKWGFCpei7YfZp
 xfv6YohMme2ijqeikZzo2kk0p686/i6S4elYuerJikRLNABvdJ+9K2ZcU28i7PoUupO1FBhVOdc
 ZkOqRXssZdoXOtjOJAowcYFlxruB6DMA6ceqXaT/kdJl0xUIaytSuOauV2N+gKHvG45vgBqJL4d
 DmqEZc3Tics+/4qfRRrWTp10U6UV4VjNID0iBl0WyX0rfK7H/x8jveUflGqXvvkFbKiuWmC8REM
 oR4hU399BGthMkfsYV2a4Rf7zVsdufTbQHzMWlqDMk5c+SA2OUZc5pJwUIFzZ4DlrsbZezJxGIX
 zylrjsbQqA/XjWOTbP0J5B7e0xNc/EC5SJ14bg9VDzXZNndO2gb/Am8jZiBHEMNqUZsgUZJSNIC
 OnOIlX304BHPQHsa42Hm3nKH9qADZt5sG97L6K3XeJlzt9iz+AA/3wiq2fMH2xcxyw1iijIoLw7
 WWIejFweaVD5SxDSS29hEGc7GJr4jalN3OCbmecmiZ1D/zeX5vlH4Ze74dnLMfxfxLfSEQPsul1
 zdAdpzYmh8BtQspXukWta1xVK+kisvXWCZjPynpJtCADf5c/yy6iCuacSC/KP+UnAsjbTd/vKXz
 XqZ94PwibUma7/kJFtZII0oN5JRPOl8P/kHj37n2t4oCEgwC9/wGdbsKzMq1xBH1Ss/i19wZA+Q
 krko/sSbRlDo1AoIA=
X-Received: by 2002:a05:6000:4b17:b0:48e:64e3:e923 with SMTP id
 ffacd0b85a97d-48e6e4f541amr8554631f8f.28.1793392509821; 
 Fri, 30 Oct 2026 13:35:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d425sm5232694f8f.1.2026.10.30.13.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 13:35:09 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 20:35:07 +0000
To: Selva Nair <selva.nair@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
X-Gerrit-Change-Number: 2069
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2069?usp=email>
X-Gerrit-Commit: bf6aedd7511393ae863b7671645fadfd78184b47
X-Gerrit-Comment-Date: Fri, 30 Oct 2026 20:35:07 +0000
In-Reply-To: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLklhYzIzZDUxNDFhOGMyOWUyMzlkMGYyYWVlYTQ5N2QzYTAwMmU2MDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8938d514dc05817990b98bc73737be9422d660cf-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMtJk-0000000082a-4Bnb
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Optionally indicate
 username in >PASSWORD '<UP_TYPE>' prompts
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4308271396851849235=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4308271396851849235==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3irzOJRbqJo="; charset=UTF-8

--3irzOJRbqJo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Selv=
a Nair=2E

R=C4=83zvan Cojocaru has posted comments on this change by Selva=
 Nair=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail )

C=
hange subject: Optionally indicate username in >PASSWORD '<UP_TYPE>' prompt=
s
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 4: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2069?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Iac23d5141a8c29e239d0f2aeea497d3a002e609b
Gerrit-Change-Number: 2069
Gerrit=
-PatchSet: 4
Gerrit-Owner: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Rev=
iewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerri=
t-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 30 Oct =
2026 20:35:07 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--3irzOJRbqJo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Selva Nair=2E </p>
<=
p>R=C4=83zvan Cojocaru has posted comments on this change by Selva Nair=2E<=
/p><p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block;=
 margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</sp=
an></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3D=
email">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/206=
9?usp=3Demail">change 2069</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2069?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 2069 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit=
-Owner: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Se=
lva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-D=
ate: Fri, 30 Oct 2026 20:35:07 +0000 </div>
<div style=3D"display:none"> Ge=
rrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels:=
 Yes </div>

</body></html>
--3irzOJRbqJo=--


--===============4308271396851849235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4308271396851849235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4308271396851849235==--

