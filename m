Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94020606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SF3ceqCJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aWUlfi3L;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=USbqFHby;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VlFEQlLc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GCmx9+DY8alN+ZCUpaQsHGquGHBogC4ZFpnEsiwF0a4=; b=SF3ceqCJFDJsMO4CLzcdb0TvN2
	LN23LMrVLVAdfhGUJtmqccPY0PE7CWU/Myt7M/3/00oKKYC8ap9o3wcFtsElVY2Ae6klig0xff9Fn
	lKPas+o4slXRAtSQvy1WDwQqviif30IRekJCogHpE1y6T09rT1EFTrLyJvON9E25XAok=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTjhy-000000006t3-327l;
	Wed, 18 Nov 2026 17:44:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTjhu-000000006su-3hms
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:44:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pXV+h32C5bd/NAa5EZVwdIiAT14CNZYG8WZDrW/dVzc=; b=aWUlfi3L6V9KBc2MXuW4TP2M1v
 8Z5GyA/3A6tjRk1K+uBOUFsAmz2vpOVXseB8qNvgFbSfSUGxVSOoldYfSGtBDIKcPSSU59mf/QBl7
 3V7DFYemuKloc1A8eOXykS0/N/m3L3oF7iq77G9B6VATMCx7O6xEPqdbS5TMhzDGlgLk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pXV+h32C5bd/NAa5EZVwdIiAT14CNZYG8WZDrW/dVzc=; b=USbqFHby2wlTq5ruAl0Tfl+O1L
 AWD+U3dpkBIrWxaXGwL1BZzIboza6R0O2YTbI7CbUd0PPCv0DihUOZAZxRSQXYrVw4zK714h2kw1W
 bE5QdAYTtd3XRxNpshj4QO+VorGVZMV9dS1YTnTyY/2MEYc2ncB3X/E2vKID9H8A2A0A=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTjhr-000000007nF-3oJv for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:44:29 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so14176205e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 09:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795023861; x=1795628661; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pXV+h32C5bd/NAa5EZVwdIiAT14CNZYG8WZDrW/dVzc=;
 b=VlFEQlLcvzVw3sSyiS9Ka8CdRx4KHkoP21nXJf2c2wXm1abFY7C6YbR2kCtq1VfDw3
 XqOVAdkNVRO1p3oJTGCI1ET4qh1t4ju2DpnWioatCi6xCC8Xj+ln21/syb9FOKSldXkk
 fmJJD+oO1OzzM5hZAaavv3Xgo5W/xvv0SEtQSNQ9z9L3i8p0wiw13C/2RfxDw+GX3WUV
 P/ULXXC329GrGKEIOygYDvmzutNE5kn0ek44hIq7dD5BgkyVHx0FeNz6gRtjoyNj7tQT
 xvdGmyPfUWJ1s46Gh3OFxvtpioOhdncl2WHl/ykSuSyMARTD97hmJsQ4hqbkQeX1/kIY
 YlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795023861; x=1795628661;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pXV+h32C5bd/NAa5EZVwdIiAT14CNZYG8WZDrW/dVzc=;
 b=gZVpbn8maHLNSiBUACOu9Fmh939Hmp86JsqVzncf2QGZAFyvOjNvK+tYikQsHA6G8o
 Mq9W+6OYbcp/0T0MvrNQK/yd3b5W1H6uXGUU2Nsjd8/b4hktFgCexYuSLAC7G+wnnwwY
 cx8gorq+qH2KRZg84DM1ktMUuUzP0js0qcKrQXMCuX08PeKXDkOBKQGmw0Q4CnMuGwDt
 5m8XLsQQAbWO1H+NA45Gy4WsKocMcAgc399s9eZhOTIrWDXjRQ28DHA/xqQzpMGc47t3
 lfe1Ryu5V/TWWi7LujfjSN+LxBdHZnfSxERxiboK2c4g2EBlHo6927qpeNdzR1ZwOkjR
 5Ung==
X-Forwarded-Encrypted: i=1;
 AL+hErEEPhoHt9lIHaUj0feTxsIIQlFeq1qgXdVXiyfKoFOh4zkvKKcfYlTVAgCjRDn5K6lOQJWDiCOJu/ixg6uS@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/K48BvD75gvfsRRd6YuLOqNDHdAAavk6zrzlJmyOaQ9Mwa+gWG
 kR6b1JbQkv4491nfJPzG7/HEPShwh1eE13+bDUYrskc35lySNyMJP5AJIYAujwP2OwDeXF40nQx
 9XLnYsZHhlJ7aRo7jnAFBYkT1YIXDOvgfvAckcY+vzTTBUpcX8jqZvzH0TV9eTUDW5Ega
X-Gm-Gg: AYBFou102GNVBZ0UzeYWZvSq6RyVypM+bpbRzVcNU9khmopOBCSL79oOZPDCxmeiqBU
 gafrX9/KeeyFtU+ox0zIfCl8XuQFt5Ux4fOTFevnhfukfZN1tO8PUDnUdi6HM0FVZ0Nq/c75SyG
 9wl9mMtBe0szBiJ7duOAa/+m1apjKEPFwLU8wQjngJQSTMA9JqZKtpEvDofe52W6xRuc8W/xokQ
 Tm7l6x3Is8W1/WtQE6z6LwENX7Uw5RbdMlM95U/jicLWTwuRXmh3arooBxwKOo33Im3iR80NwxN
 aYobPlQ8UDaFrVQj2JFWoSWVu7AOFt2Ebx/XnpFRfgs3rN6ZKrzJ5P7glJp0FHmS3xGO0MNyzoK
 dbzKPuCiBolR25cemMr9PasiXEpIqmH4FP0Cyw/xM0qX70dO9ck5JT5LZUQmrUuQ4FgiGfRUHWi
 Bnl3b28c2GIKV1p66I7VSggsMGqyrWhWcGwcQyCx+/74wJQav98Inh8PWjd6OSchVMW25HFE7Ks
 cNhBl5pNe5Cik5KMI/ToTwOvpHcqjQkdWHK4sNk8tbZ+OCtUNJaaV7AsadE4LOd6WxGJJuB8ZZx
 IaT48C84cA80nnQeCjnB13U0yg4uVWYguz3DhH+5SoqeeUtVK+2NYhnL9nhvYGruyf22PtVBnjU
 VcTlzSBR6d8FfUQ4TWB3XhT6LyJf46PX6+/3SMvQaQab2xUneRjjSHzxsCCjLYoY94rw8mZSV7b
 48Sv7l/tvnMgNgcKI=
X-Received: by 2002:a05:600c:3e07:b0:4bb:5de1:e90f with SMTP id
 5b1f17b1804b1-4bb7da44cbdmr63103015e9.31.1795023861097; 
 Wed, 18 Nov 2026 09:44:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8329e8b3sm3415305e9.12.2026.11.18.09.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:44:20 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 17:44:19 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
X-Gerrit-Change-Number: 2210
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2210?usp=email>
X-Gerrit-Commit: 83a67bd908e799cc6a97f312a842f29b096c02f2
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 17:44:19 +0000
In-Reply-To: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
References: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkk5NzgwNDFlYTRlNjMyM2Y1YTkyZDg3MjE4MDlmMGZhNDRiOWMyZTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <640d67dd5f0fc5c82c14f1855028e12d9dcd4952-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTjhr-000000007nF-3oJv
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: pause the
 listeners when accept() runs out of resources
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5595220773300718749=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5595220773300718749==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ghrrz+mpUrs="; charset=UTF-8

--Ghrrz+mpUrs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, Gianmarco=
 De Gregori=2E

R=C4=83zvan Cojocaru has posted comments on this change by =
Gianmarco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?u=
sp=3Demail )

Change subject: socket: pause the listeners when accept() run=
s out of resources
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2210?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
Gerrit-Change-N=
umber: 2210
Gerrit-PatchSet: 3
Gerrit-Owner: Gianmarco De Gregori <gianmarc=
o@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@ma=
ndelbit=2Ecom>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Ger=
rit-Comment-Date: Wed, 18 Nov 2026 17:44:19 +0000
Gerrit-HasComments: No
Ge=
rrit-Has-Labels: Yes

--Ghrrz+mpUrs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, Gianmarco De Gregori=2E <=
/p>
<p>R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco=
 De Gregori=2E</p><p>Patch set 3:<span style=3D"border-radius: 3px; display=
: inline-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Cod=
e-Review +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2210?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; pad=
ding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2210?usp=3Demail">change 2210</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b=
9c2e03 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2210 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Gianmarco De Gregori &lt;gi=
anmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Wed, 18 Nov 2026 17:44:19 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Ghrrz+mpUrs=--


--===============5595220773300718749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5595220773300718749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5595220773300718749==--

