Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C641606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q0ulGkXS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VqnPmSGl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MW5EYLwD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ol+sTMt7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3YjSjZEOqxxowgU6AKjG3XDatAJA5DP/7vfqrQ/PuZU=; b=Q0ulGkXSLt+0g8oPxCwf2csMQU
	oRPCb/Cg+vpIYhh7bF6yZHyVvaPbkyFxOpWnvSWdXFYo8Ru6IWgLXoe/5ohb76MMqvez7P7LbS1nH
	SCqnM9k/J9Zedzql9w1E4PqimPJWnv9dE+zAcGM3wJHlw+jQY6NMYTq670bOaaWDar/U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNoZ3-000000007OI-0PtF;
	Mon, 02 Nov 2026 09:42:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNoZ1-000000007OB-1dWZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:42:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0X8h2DuoUcKtuQ98GPVtA/Owhr3M5t2RKr1LcrfTSAo=; b=VqnPmSGlHcziyJdn/d/4RYSWkx
 vVRjCMcHokmXJb7BAB9C8l+R/cQDv4jrL4jT/e8JXGEWXI4yx9muLKsgKoM93qZhgSCorcSb3J8KZ
 4diRYMGPbkFiqvR0eo6+aumdcOErfFesHZTokeHSRCdqW2hmQiEp5HZTWvECK/n7g/wc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0X8h2DuoUcKtuQ98GPVtA/Owhr3M5t2RKr1LcrfTSAo=; b=MW5EYLwDSYeRQ1f8bWRfxM8Jmu
 GDAlB2hNKfMfuHVticiDGY6VDrBk3FclQsuuE8R7kq4tEXP16zxlcUmRuYw1wKnMh2ZCat0a5MFat
 PO1p6m2rQHP8SPlKY/O6sjT3mPqvtlPgCnAn+w4tKITnFUUXYHKynkwbeGCVxZOkieHo=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNoZ0-000000002OQ-366X for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:42:51 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so35679905e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 01:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793612564; x=1794217364; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0X8h2DuoUcKtuQ98GPVtA/Owhr3M5t2RKr1LcrfTSAo=;
 b=Ol+sTMt7mboSg18ZB9TNCsG55jcoPi5fYT8ojHWev5dTGIGoOLMteiglEGZAk/MQQ5
 nN+DDNAR4J6K63pKx38etOiEqwIRnERTBnh3Iv191IPeaCRY2dtBdYvBr+wGMqCqkIrD
 3N6e0fA3r4gwztSz3ch2tT6M9bPLoTVfAwI7IGbRshaberjzBmZ+7BlLEcPi0R/6jSiL
 cYxSTbinH0IWCdemqzxzDTbnDISSxpvoyqiRYgUs4MssKhaz6qOc7PSz1me7zmvz8qLp
 YOovqL5Vs4skBpQRCyH9bSGBb+LSxmgaD2WVe81iORYu1wj41CsHPOh5P3UjLFUhddpO
 /bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793612564; x=1794217364;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0X8h2DuoUcKtuQ98GPVtA/Owhr3M5t2RKr1LcrfTSAo=;
 b=gwgFW+MSPOGnuAqEKRKiADpEVvtYAwZORnXz6Jx+ktMQhp7eiF/kkZYg+wj1baHcjD
 tDDD+qm0eimNy0cU6BI3z71DJbM8AL+3fyGdiEP5l6+QBR8nIGlK7w95oz3vzeiJWPeH
 03R5XJyE7w/ZH+uqTPU7ydgh6aRDJjdcyS3Io6jg08w9bAuX1qCQPhnb9B6pwN36iXXM
 77U537Ou01RAdXSWUZMHGF0SomRDfv1x4hU3CbwSWKCeOKHZ4curTvKOQ/tpZ/r4q6Qp
 /jZtzJ/9Jpz3jB2BCsWHnsLBjgoGZmzAQZArXYQ3YaEt0TVtnpvTcvfi+o6G3hxFAZii
 CgXQ==
X-Gm-Message-State: AFq9FYIQY+eumtsBCecHuXVme5/kU6NA7BB7BBdYymmEV2k8oFCmtVme
 7AkuwaEdfmQnRsThnwSU0IfEua2hQSbfvyKoeBHIK0b4gcq8LvIibyAeat1adhP1HzUJ4zpLU15
 q3Kcr5cfvOo2taKCMmhnT2nuMvhKvo0N1jo2TwQU9NDXtq0ABFXiI/KBULYQLMlWHCa4RIbOf2L
 +O1yoaFg==
X-Gm-Gg: AYBFou1PDVn4RHccFbLiJ1JylPzIcyfP5ReEJ1uXiu3o6duGzgxfSSYYo+MCTPkR7tb
 4htbNdh+z5jLoTe8IvbIIqMW9NBpy6k6gQ7Etlwra6zaCVNPhJ/JXurVLvlgnvzbbNu280xglp3
 l5rDlSuMwEErFXXkc3Pn/tVTgbUAwDNVyJfFEPNdQ0Ql7YukyXl2wNfxkDX0BFCGUSxHQ4B77lV
 LbI8ACIgwUgweNLRMjGN5bi4jXjKApcHTr6HcEhuZxtZpYvFtGSgmRxl8oGd2FksSlLOzbD3U3C
 9TX2iRkypF7IzzmVG02PNA9/faZ/futPy0+NR4vX6gHcRiqGJRkxR4W05AX/C3EuSJ5H6z8fAXP
 +0LDdohJ26N0QmHJc+u8MRATW9d81RyschaU+UrccmDACV1gEgXjPIwlnPHdn3erbkMFo3xRWKh
 a4e5AuW0NA9WzCYmp0+Pg3ZUJqffghsRvptk7NRLQc1OGMa+q5STKbOUy5y7ERoydFjuuL3S/12
 FlN2XkgXIWwhL37ViyfucEmO5QT7ITwvK+MSZJ4khT+3BT1SNzlQB4jEaRBFJzwuy8VjW7Q2sEw
 aw4eBYELS86aCehMG2LRUFUzGnuv4RIHb3QpHhjLGg+DqCtvBttOpVP2+5qT3VY7EOLtl9nQun3
 9AbGaXYwIkCnwtRCCr9/u1ctQpY3Qx2cbMal8FoB9N4PSGpFNytY/oZLqOPro5xPUxQpR7AtUjk
 DmLgLR1khNQ/c4/A==
X-Received: by 2002:a05:600c:848c:b0:4a3:5da2:38ae with SMTP id
 5b1f17b1804b1-4ac17a3628emr221297795e9.14.1793612563863; 
 Mon, 02 Nov 2026 01:42:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab61d8b9f4sm304950305e9.12.2026.11.02.01.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:42:43 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 09:42:41 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iefd88cd537fa301d47a0c80d6fa520053c092bb3
X-Gerrit-Change-Number: 2065
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2065?usp=email>
X-Gerrit-Commit: 38fc47ea1b2f12239a0f0a2a0bb02085a0d7b56d
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 09:42:41 +0000
In-Reply-To: <gerrit.1793205511000.Iefd88cd537fa301d47a0c80d6fa520053c092bb3@gerrit.openvpn.net>
References: <gerrit.1793205511000.Iefd88cd537fa301d47a0c80d6fa520053c092bb3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA1NTExMDAwLkllZmQ4OGNkNTM3ZmEzMDFkNDdhMGM4MGQ2ZmE1MjAwNTNjMDkyYmIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8db03d91e535b1f14cf16e605ea44c2ddf67d280-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNoZ0-000000002OQ-366X
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Use m->instances
 instead of m->hash to iterate clients
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7353479390744139525=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7353479390744139525==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i/e3HL/4Yuo="; charset=UTF-8

--i/e3HL/4Yuo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2065?usp=3Demail )

Change subject: Use m->instanc=
es instead of m->hash to iterate clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2065?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Iefd88cd537fa301d47a0c80d6fa520053c0=
92bb3
Gerrit-Change-Number: 2065
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Comment-Date: Mon, 02 Nov 2026 09:42:41 +0000
Gerrit-HasComments: No
Ge=
rrit-Has-Labels: Yes

--i/e3HL/4Yuo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2065?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2065?usp=3Demail">change 2065</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2065?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefd=
88cd537fa301d47a0c80d6fa520053c092bb3 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2065 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Mon, 02 Nov 2026 09:42:41 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: Yes </div>

</body></html>
--i/e3HL/4Yuo=--


--===============7353479390744139525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7353479390744139525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7353479390744139525==--

