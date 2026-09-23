Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A13C982FA
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5qPRDZnbxjojr3u9MT8cSNau2XcSAyKuF5Ikl0ubYw=; b=lkHawyhvy5RKGFe/9tE0jv+4Oz
	8bolet1H1NRxom6qhMBYVGa5iwf7UUHegY3iPV4184/NZj9Mh9dvA46qLj1czDBRl6wp3PBmhcJwh
	FazbkkN/YUxTdOUTLaoP4F3Kz/rRqEBVc3RxpvPxWehb7lf5nfT5RaG+u8Q+eF2vJslw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9JN4-0003qF-1D;
	Wed, 23 Sep 2026 09:34:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9JN2-0003q1-GP
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:34:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1rmD3/+yzvP5bS08OW3YYhgpvYzMuN6xrKaAbkQWMP0=; b=m898szNDcREBG94HlXZJGiticI
 gceicmlWcIy5Ma8c7l0avIjtpBoJQj0uI5rcDXh7CUykyiBtNaKXX32SffSv/GsongIFTi3VAnYIm
 yfKS6RUYjoqMEdNwotDo1ha2vXbK64irn+MZrVgeQyB+h1yG4uWBzsmJCFz9TB+ACHrQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1rmD3/+yzvP5bS08OW3YYhgpvYzMuN6xrKaAbkQWMP0=; b=B
 1RP2aasriTwAvBCaOE2y1XChjiA+OYCkx4FFbLPGRj1G4nRhAVUQ1RBcMaOs+TO91+YCt8468n9od
 Uo483iNzUnBqJc2POJxuSd2ogoOeZI372tDfGvgekknGUm4OsWiO13uc7GZ+LJxrCP2+O+08ixyIz
 EA/ARu5M85kgd/eg=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9JMz-0002wj-CS for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:34:33 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so3993665e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790156063; x=1790760863; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1rmD3/+yzvP5bS08OW3YYhgpvYzMuN6xrKaAbkQWMP0=;
 b=CzzYTbH3xgqQdUJOiBaXHVNpnoafog2J2qgzyHet+K6ddFg/D1WoDn3rnWlXYO7pq+
 eojC9lSWN1c6pkZ+Y/ztb/0NeoT6AQIsiuD15k+IVughZPov1f2OFRdLy/TuKsVymddG
 g5nLeZgwsshEvD22vfSwyytyd0uvCYLbkzkgUNN7qpE+HEJd7BmC0HGq1bv86t/Ptn7U
 Si0jFpOmpLqe7+5gMVmArn8sCGORDd2bsOUpZaWHh5+5AHsUJEmY5fXO8O4Z2lK5lj6A
 Q9mpQEQkI/Tg/VvAh1l5xQfPSFRvKMMnY+w7w+iK7qjwpgVp8DVVjrJV0ptLwa0hd/qd
 AvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790156063; x=1790760863;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1rmD3/+yzvP5bS08OW3YYhgpvYzMuN6xrKaAbkQWMP0=;
 b=GP0RKX8RB2r8DRdg/4BHAtYmizbSJFyI0e5gFyNsSCjNxh3tg54HzJWZqgNWTF2rHK
 yNR29odYdy8S0aKTjq8g50XKkbA7tOkuE1c/8Z75TMuOyrmaHNwXnLb0Xqscfd/HGbwl
 c/uLUp7fVvGnx1xwfH8A3vsp9NVFLaFJCfTqqeWWPo9mkaKtkB2dDE1l+msQd8BC97ai
 q+Itjjjs2mXrQ99XwdzkNTSC0tHwW4BecdRx2WJxl28hK2QXfgcZ+v1qBnHZkBBQT7pv
 847zNLKj5cQwKEzpBdffi5cCXiOq6YU7Sb0tC2t/Niq2GuFJb+BMhsrmi4WgHT9hJLEc
 ZIJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYyBg3A6CS6qc63sUAY0dXEeXzm2sCKBipvqWEezIYxI2lX07bucDl0ZHvec7PKqpQoagx0ynIfsyErjQH@lists.sourceforge.net
X-Gm-Message-State: AFuF++kSIXB6Fr8I9oiH7NVoBcl8C4HljPWiOpum3dQFKhdklhr0znON
 7t1T5QRG9YCsICQoJkDE+fFTeQfFF8LKWIqKjf3xAKTlf4X7SL0Ibr5TtuN6KVaVGfoJn9+sfA3
 ogqA/zAjQFg9jSvqEDM1feGty2cjPqi3zlsGd8DBHfxNfzceVagdzrZxzRBAG1Zsx3S4x
X-Gm-Gg: AYBFou2/RknO/VyJr9cyeS6kvzAdKW2nkYOYRJ7ddyZwRT8U+KcshWZsXw8IcoTMCXn
 1GllD2kWCTNLKKxFIqmQb9Y3ECDOyXj1+Gq5GAXCUCA7OkbcshrXvsg42uwQ9oJDqsaUnGcEN1+
 wgk3f1Vx4rULMltRGZtq/P5F0jWIVcWIpp/b179mnMorX6YOlMh3fcBymhoEtzfHGAQhw+x65Uu
 1IMggoX4YtI0G1jrOiS3wotvFYMxEDXi4WDdQanFU/tUwu8um6fjG2Rb1L3h4e385Kd+vSX3gC1
 cy/3tf3KNO2o9qvNPLxUZSU91iuB9QkTWVuG7BsIhtN0grrmVqWKh427/rWUWaTQk+QnSgAMeny
 ssJZmle0+RDGdyfmfnvnekyJ/G+5Lmm4XzNjYiEHB3f0ybzDzqycnCwiEoSawEJoEnkRZ9bYr1H
 PbP8EWasd5bX2HtFUnPXNvDKFkE8BLyaRiuiVicS9k84BAu9A2GFWE/9OKUr+bqd3QWkF3M6QNx
 3hycPOxfPqtUtqCBo1RMLQ8RBf9LFYHHNAivsnLbp9DwvqVXUMawTSQYlvOEzrDqCRMRrvdw1Fj
 fUodsSptVGvP/Cnm0mWnlGcHHEmVD84/cXbj1VMPQY9lH+NrY1ElF+iaG5OC
X-Received: by 2002:a05:600c:34ca:b0:49f:ce78:3568 with SMTP id
 5b1f17b1804b1-49fdeffd818mr24270325e9.25.1790156062736; 
 Wed, 23 Sep 2026 02:34:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c5c41asm37378815e9.4.2026.09.23.02.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 02:34:22 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 09:34:21 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I98f33343d35453219e43b8730cc10bcef119ea20
X-Gerrit-Change-Number: 1944
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1944?usp=email>
X-Gerrit-Commit: ab8bbcb4c70a4f775cae0c445e2a654109c9d701
In-Reply-To: <gerrit.1790155491000.I98f33343d35453219e43b8730cc10bcef119ea20@gerrit.openvpn.net>
References: <gerrit.1790155491000.I98f33343d35453219e43b8730cc10bcef119ea20@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMTU1NDkxMDAwLkk5OGYzMzM0M2QzNTQ1MzIxOWU0M2I4NzMwY2MxMGJjZWYxMTllYTIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <68f4ea642ec99e8b47033f624a2b40e8c04785c2-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9JMz-0002wj-CS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Inline ret
 definition in dco_linux.c
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2633218996903254560=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2633218996903254560==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JPK9qqQj/Ts="; charset=UTF-8

--JPK9qqQj/Ts=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1944?usp=3Demail )

Change subject: Inline ret definition in dco_li=
nux=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Aba=
ndoned
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1944?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: abandon
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I98f33343d35453=
219e43b8730cc10bcef119ea20
Gerrit-Change-Number: 1944
Gerrit-PatchSet: 1
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>

--JPK9qqQj/Ts=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>abandoned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1944?usp=3Demail">View Change</a></p><div style=3D"white=
-space:pre-wrap">Abandoned</div><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1944?usp=3Demail">change 1944</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1944?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: abandon </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I98f33343d35453219e43b=
8730cc10bcef119ea20 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1944 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></=
html>
--JPK9qqQj/Ts=--


--===============2633218996903254560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2633218996903254560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2633218996903254560==--

