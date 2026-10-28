Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F26606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Gs4U27xJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CrCaSt1s;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y5uCb14t;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D7sxQrIh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=h712qDqBvNjgCddQUomXz2rHEzuX78wkN92QJhKTwYE=; b=Gs4U27xJKrsiCPGDUW8nZLXbCa
	28yaHUY+hE3ynTia9YD/zUMLE54ntoXbJgEd73Ap1E+IZBd9R32KrfEVk32kLZNDt6yaXOsAZaKny
	qCPONmmeePxL/8q7sDwqrg5z/q6YDVQzS+E+N1ESWbeDNAAro9syKTQ5w5aAD9SENKBY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM2bz-000000006ws-42zX;
	Wed, 28 Oct 2026 12:18:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM2bz-000000006wm-0P7R
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 12:18:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jHCmEFEDbhAypOVKCU2+SscPdpEgxqiiRyXD+6PRT28=; b=CrCaSt1sbbvY+WSmSB86PYVRk8
 x3rfo1p6G2etMFLOZeXCoW901iUNN9lo9njewyLcAyn33Bkq+vb9m5/plYO3YxWllIsHLFRnGlKGb
 V4xrq42jZ7Xi7e1jKT/2SLpISyegAfcHrwbdz3G69RmSSnNXvRVJaiabMxWaipDyAwf0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jHCmEFEDbhAypOVKCU2+SscPdpEgxqiiRyXD+6PRT28=; b=Y5uCb14tbKKHkWB2H1D4w5ZoH+
 7DS1GYGjK+tPwuGeqDCj2gV8V6cV2bRzjaoPsUOplDUNFI9q5RqtvTyBZhmFguLfoH6rCwKrdC9cI
 6Atx8SwxI4sGA0mF1BgzIDuL3LT1ASkpusycknE6DD3tdaGDN195xu38Lu6j+Ph/SaeA=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM2bw-000000005GQ-2538 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 12:18:35 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso647140f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 05:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793189906; x=1793794706; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jHCmEFEDbhAypOVKCU2+SscPdpEgxqiiRyXD+6PRT28=;
 b=D7sxQrIhG2bXV5IbmSqy0pAznGFXxVQr4ZJmotlFgIQVUc3tiKK8SOu8ppWDJPXZUg
 E4vdUwpZEq3IowjeSRaVaM3yX+8JXB5yFkjE0CW6kwgcmGTR/d9ruZgltTzvRytQ9Gfs
 AtRJLOasEt7lWVenf+eAyjxf6VNkfK87S6StXihj29c+MXkb4TyNeoUuuQ0qaV12yMXi
 81ZQSo1Xrc93dLpQlRDbBL4DxIll0WXvGp3V4VDPdpkZ5CpGcf8Ey5lp7Dc73q54Gg8g
 VcEQokwCdf+PsoLz7Fybv2n/fJQ2lnWi2ALJoKByPdQNcpnhvjVOKw7fJphhv4bYaMgL
 F1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189906; x=1793794706;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jHCmEFEDbhAypOVKCU2+SscPdpEgxqiiRyXD+6PRT28=;
 b=R4LT/jz5w17/l6MxWevWC6T4zzpHO3pWKJCoDclSSrtgIG1AEgxkiF7nL1/rUx2HnS
 nrOY0g6iwUQBSJFCClBLOKn2Zw+/mT+pqNKFHidgqoBuOlVUL6Cfi3x4qb2jBc2ZbNCY
 fURKoBX0gf7B/fqbGWdpxOOETqI843hhBmKv3gbFcjth/UU9lL4MDJFCUZ8cOlaFtCRI
 Z8kaUulTToQmX1iFG6NqPXfKMau9UbIXVvgqwh3bf7zjXBbGs8CohC3iYT1dUA9PRg7+
 RDypMRdilSylYRdn9OVP5rmnFu2yp9aDf59v0eHTMHBLZLFeQ8f2fIzQt2uhUM+V+V9G
 JwaQ==
X-Gm-Message-State: AFq9FYLCZb9Z4632lyqRghf50t6+AlrAtX7Ds631wZAy54ENNYpg1rzQ
 hhBsxcyCxqq/zydi0qXwnyCmEGSpnMQou1C6CO/qWKEKFTr58GJVwheu4+iZHgpGKit3jifCRok
 2O8NfbcyaExRUV31Sdl73f+pwPzvNdwibHSWOZKCsdjvZnn+X8INL6axZzAqxyHg0j+JHGGY2iY
 olTNg5Sw==
X-Gm-Gg: AYBFou1hXcFI9q+nJN7xa6nbGNKs6lSSfBAA0MuJlxUwhV77z7DSj1MbmwxmedpiIYG
 rwUvbomAfo2Sfin5lcQ/qXxOSTVkCXY7wyidUHJoN3VFl/C5BpGIYok75llgqf0wn/zF5RiBKdv
 5iDWw/DHWG4tBcOG5xBU9GbHm1y5CJsgPyutseltAGzji83JJHrrYZ12NKZZCf/NbDdjcU6kWAm
 WrnAm/3MKg2HBY2rSzjF0Hd+bUgk9fqXiQo3Hv3XEULc1LMv2PGK8fI9LvyBS2wYkqSNEXC6sPB
 8MEO7PpFDKiTWOV3G+qLjlmLHwg5Z6NI5BRAijWXIhjr5ES9E4R/iWBvIv12slxTo3qiCBavSfq
 BRunZn7QUQp0+ivqzJO+bGPotO0QsF4BG+EW5HWekFd1OFcVWNuNvBnmE8gT2ActOoF+dEVLhq4
 TuX19eGmjgvIOpS57qN5DUTWCiv0Hq3V6aZkTib+Z3NheRpbi20+OPpaHTa8z9nUF40Fk2rKVCF
 8KO4R5dtp+IMF2iZMm+D5wPsaS+HBRPfl3sw0VPJHLNz2jSJ+yLw+khSEUffBbkeHLkzL/pq+TT
 LU5nr28wjn1VbuXFxBTJsDa9QPHrVYv3AfKj90ioRwb3M7TBhzX8Ytt3e/WQ8HzLnZstAG5inQh
 dE5pxzAOIAmt0IGWqmH0TlmlxmBnDYgPbl81433CX7Aaafvp9hNpWjociC2KNO9vri4ZxIU8O7O
 TF9+RMMGlBq7wxl6I=
X-Received: by 2002:a05:6000:4b0b:b0:48c:7386:af18 with SMTP id
 ffacd0b85a97d-48e5d58d56dmr5461217f8f.8.1793189905863; 
 Wed, 28 Oct 2026 05:18:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd47basm30855794f8f.32.2026.10.28.05.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 05:18:25 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 12:18:22 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4
X-Gerrit-Change-Number: 2058
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2058?usp=email>
X-Gerrit-Commit: 23c43e0e52e1fdc5a2da32e7453d977ab48a1d65
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 12:18:22 +0000
In-Reply-To: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
References: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTg3MjQ5MDAwLklkZTVhMzA2NGU1MWQ0YTIyZjkxNGU3NmMxZDgxNjVmZGQ0ZDAwNWY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c1cbeff5a80b5d29f5886965f0a1bd804913af21-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM2bw-000000005GQ-2538
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Mark buffer invalid
 with username mismatch in server side float
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
Content-Type: multipart/mixed; boundary="===============3561096760320105613=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3561096760320105613==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q72UsohjW/8="; charset=UTF-8

--Q72UsohjW/8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2058?usp=3Demail )

Change subject: Mark buffer in=
valid with username mismatch in server side float
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d=
8165fdd4d005f4
Gerrit-Change-Number: 2058
Gerrit-PatchSet: 2
Gerrit-Owner: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Wed, 28 Oct 2026 12:18:22 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--Q72UsohjW/8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail">change 2058</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ide5=
a3064e51d4a22f914e76c1d8165fdd4d005f4 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2058 </div>
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
ne"> Gerrit-Comment-Date: Wed, 28 Oct 2026 12:18:22 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Q72UsohjW/8=--


--===============3561096760320105613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3561096760320105613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3561096760320105613==--

