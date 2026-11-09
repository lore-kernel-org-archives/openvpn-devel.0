Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F3E606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bAzkERlJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hGLXbIZx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ppy8uzOk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RAy7vdaQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5jFex4E/F6aLH0mn4L9s5ksbsCEUisCpAo1ZlhOHQ+w=; b=bAzkERlJlvu8HV7Ex9bvDC0LKv
	sQBphP9rGFpZzObb5HGEOJkTF+m/XMe2DW9Mh2gWpG6uAVf0SBjmAHbRX73CVgLP3UsEi66Ybpfox
	ehP5ZqeMI/NxnOh5WyYMozT3Teq2XtNympKTL+5ceUTX8zXo18MuDyaCsBTU5CdTo++Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQUbd-000000002Yy-1KIp;
	Mon, 09 Nov 2026 19:00:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQUbc-000000002Ys-0Vwu
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 19:00:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RLZgNjlZ/vVwrkSdrsLSV7DMZpC+nEBupXtzJuJiGdo=; b=hGLXbIZx2rlrgafBAwGGSwm6DJ
 99dgBnMbeAVOy3FV/JqYiDm4iDqE/PShWEPNOb89IWe0/ub6rBEYadMkKBe+HyUlqwzuIsA1Eb/zP
 L255pWypA/VVtkIijhmUnIyiO8K7+fFL6x1KUDQIzIKlEqdX36k/AT94jM0w/U21j6hs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RLZgNjlZ/vVwrkSdrsLSV7DMZpC+nEBupXtzJuJiGdo=; b=Ppy8uzOk0/etXb/4XFvgMdmZka
 jctM0IrMKJBpxXw3k1hrPBDdD5ShXo9ehESGTg8ng68i8fw7bF97AXZW4uAOYeiA+TJSxufQH5QEN
 RezNaaahxn3BRO4mkOaN848OkjKlVkVnE97/+/AJFcMrJMv3WcHcSR6bUyEYPVT571+Y=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQUba-00000000763-3qBP for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 19:00:36 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso8753775e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794250828; x=1794855628; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RLZgNjlZ/vVwrkSdrsLSV7DMZpC+nEBupXtzJuJiGdo=;
 b=RAy7vdaQc1S8eqVIDL5rnRfMKxRgENitVTj03XyWbAi5EjQbilmSuUgAdJFlX1177K
 tg1KIdfSaCMek8CPvx1TyP345vnviA1ZZ71zKaG1HC8D/uXuVpnbKSf64qzjiKMbpkRn
 lw14VLyPs74s/ISYQgI8QQhu4fIpAbYrLwvWxKiZHk50GGs9viQirHK98zWRiopU2r9K
 zeXB9sO6tefXZrwY0kdExJkQmvtjzUYAPuah18pk3C7sy01UNEednlkEXYnxX6TkA1tM
 5SP8I4geNJq2AhqtGAUUkXfHFiOZ84XaXJFu0bIK5Y0Mzvkw3+3yLRMoikP6q0EJWo5Y
 uXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794250828; x=1794855628;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RLZgNjlZ/vVwrkSdrsLSV7DMZpC+nEBupXtzJuJiGdo=;
 b=s9/Yx9mqMAnhizNkBpHmHySs8rRZeWyZiqDnGXKOCWM2tldotuSz/sn3itIu90xg3U
 0JvEQ2Ee2e0V4fMezwUmuwwpuI4w7+jN+GzdaYtY76Xas74VTN1aIuERii9++b7gnOM2
 rOpw7FYg1PHH2OpcOztgrO6x470MrtyyJ+W/I5PsACG+3xNLq6AwjWiXH2Hr8OSI1ilo
 QHdcRfditRfiqNxkxkCGSEGznN5LT7fA/iH0P5hb9v6fAAYdAHI9aYOa09i3+vrz8fc3
 GHelDEJAVOxI+vHYoIB1Jym7Qb89nI8LDwulDp0LFK5t9itH6sjcCPy/iTjdHMgcvSoP
 EzEg==
X-Forwarded-Encrypted: i=1;
 AL+hErGKLTuKXQBLqbRkv3vUVF6FPCZAqOLWDaE5yjiUMiWFjEwnoy31oNRoEbXI+BKIR5SLulsWLFsmdirek2HX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8VSaDXPHdIwkrtz/cHKBfRBMpBARgkl+NGQXJ2u1zzWHOCXspC
 KDoKsejI/0gBZBHFitViM5usOCN9B6ayaMMjPw3iQ64MQWgf5hE5ZIH4sz9t5GRE2sa+kTBlwn/
 Pc8XCkMpoA6/hOvzzTjNuMld5T2CInXL/ARBeD23GM1ECeUKTAKElIEK/g/KxPuBdIPNQyHApyf
 xlSI/OXA==
X-Gm-Gg: AYBFou19T9CLSQZw2w4Y6vqWbebcc740Ein99QSFqS9QCBYWX+3btDLUWGfAOLWJSzT
 M17cRm4o5RScogCiAxJV2Fh2HmU8wQF0Epp8tzqRY5YBQxyhH+3TFMY29fmi9kDO7/iWQAKwzmt
 AZ9Qeawu8WNqyfZTUTG77WIhisxobTSd1HsRaepc04J9wXzqAccoRbUNPXfCQrYXE8mfJy1fVJj
 O3zWIm8OdyzALO0aJD6QTo7tQUmzAURVOXu3JjXW95KzFOQ2CQTXHLsPVisCqE4/W3J0A0CMFY5
 TqOIZ6AyQvRrE5p2TSB0zRiNOY0eOc0VY2hPVncA5n2WtA52IWmh+RBVYJnb6zE33u+XeQKDE+Z
 Kj+69Bl7FZnEliTuCR90HQ7/srMhojbwJjqPWkMnWZ6PEv1vM16YzphsZlk/a0hS/EhzJ4QgxST
 zsZMy1C5cCl6hp+PFewUZPL96GCoA+s3RzG52tLV0xd3mVTAQBDKlQPiUTeBOz0YqYJcJGxYb7T
 27V5bbAIjuvvmK0p4mqxtDnnAEsCn3FPpYHQYc1ZijuyciaiO8gaUkud4E2/Nhg3XIGPnvPK4h5
 T77MTdV9d8SIRp4UG3vqY1S1MCLO2Wn/9bb/x2UF72GvNQXqoceZ2wVc+Eq/ywNnBvPI5QC8x5f
 35B8I0XW13nb14L9ybzbll2uEAb5O+ftPiJyK7+IIYdY63/gHa6ngcUvfXf7hUapyj/YLYyJ74p
 oN/bN6B/E1kLg+hQ==
X-Received: by 2002:a05:600c:350a:b0:4a6:42cc:bf66 with SMTP id
 5b1f17b1804b1-4ba0233d8b3mr2613655e9.11.1794250828165; 
 Mon, 09 Nov 2026 11:00:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02300988sm4038185e9.0.2026.11.09.11.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 11:00:27 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 19:00:26 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: af75ea4bebd55229af79ff739e68042736cfb986
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 19:00:26 +0000
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cf8542724181dc42dd0459a7f5c22894c7321750-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQUba-00000000763-3qBP
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove replay-persist
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5676317303184137347=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5676317303184137347==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mDl8ornCDiQ="; charset=UTF-8

--mDl8ornCDiQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering=2E

R=C4=83zvan Cojocaru has posted comments on this change by Arn=
e Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail =
)

Change subject: Remove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 7: Code-Review+2


-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce=
93815
Gerrit-Change-Number: 2082
Gerrit-PatchSet: 7
Gerrit-Owner: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert=
@greenie=2Emuc=2Ede>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Mon, 09 Nov 2026 19:00:26 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--mDl8ornCDiQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=
=2E</p><p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-bl=
ock; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2=
</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?us=
p=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"><=
/ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2082?usp=3Demail">change 2082</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2082?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2082 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert D=
oering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Mon, 09 Nov 2026 19:00:26 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: Yes </div>

</body></html>
--mDl8ornCDiQ=--


--===============5676317303184137347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5676317303184137347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5676317303184137347==--

