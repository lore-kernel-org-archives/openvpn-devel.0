Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F74606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HX7fXnjp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GlQ0BTkH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lpfarW6x;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Bn5cyzto
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=btrb2oM3s37Ni4oNVmBHOXzJ3i4vnCSDwsU+3M8vagc=; b=HX7fXnjpDAgjxcKv1jklrcFyyq
	ZBrkQyLH9dgFlTXX8+kfMpIEb5zdpn6I436YoEeAoIoNdaWIRNiuDshzZ1jc9pQVCVExHSKDWwmg7
	0sm60xB6EYKVcNOAX9oD5GF/rFS6+zOPpkFCc9zKEJiG1u0LUMsOPrNebcwVH6r7hsgc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRMRO-000000004XP-1Iuv;
	Thu, 12 Nov 2026 04:29:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRMRN-000000004XJ-3rMi
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 04:29:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o6TZ83JvQPBfWmhcfWZaccsxwTnMphT2kzLMI5N1bP0=; b=GlQ0BTkH5Ibxj1iqaSzOGmWNx8
 oE1w4qpThZoFZFnBow5/oSpmoCR1jo7jirrD0XZNZs3VaK1ngNRKjBnlpw6SBSw2f1QU1/hvTPDvY
 MoAwpR/CRZmeCD0Q5/S+9hln7JYICtxAhZ3XcYZkWJ3fYGW/nhgn7Ua2ai6ljkJ5mMag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o6TZ83JvQPBfWmhcfWZaccsxwTnMphT2kzLMI5N1bP0=; b=lpfarW6xmVynQNSUIvSZsSug9H
 sFWS2fZTItm9XIg/cfHqkTrZkdCMkYSJ5+7JqXDwkU9BOHkZoUcag8qbyJqfpQcYCb0QKgNTEtlQy
 EFRq6btN/8xHMh4ZQphDWCnj/Oaugu7b/1dALuJi4ai9LozAiG+8GuKZAl7QpaEdER7Q=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRMRN-000000003IN-17cO for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 04:29:37 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so3214565f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 20:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794457771; x=1795062571; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o6TZ83JvQPBfWmhcfWZaccsxwTnMphT2kzLMI5N1bP0=;
 b=Bn5cyztogawGHVx7RjW12fpwADQ6WYCu3UOuYV+ayy0axOPnR2ns0FJTvIHwTqHmZ1
 lxxrbElsBhpRmdme/iAkrlU8XMR6Bgf9pxvJM7xTrHlUVVBpvO13gWmaPkPv6SbYfqRP
 WIgbSi3Vr5eB/h0x1/jPOk4XDRpAVQT/4Towbnu5pq3/KnJT5RSPWCw/AMJ0esupH+5C
 5WUac5XsxaXB/WQNuLx7tVCJ5l3xQzrwfFA0dZt9DQiwL6MwGgXsAg6REMpeJZpE5jIr
 7zd4mv57LmqWPcsb1TggdHy31RUXRL5j3XZhgldbJKGzZHTQgHOdNxw7FcLEuIZaJF67
 SpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794457771; x=1795062571;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=o6TZ83JvQPBfWmhcfWZaccsxwTnMphT2kzLMI5N1bP0=;
 b=fZdJAVAZ/kbEPvkmVgNryVYuVluE2cgeCWr8iQpIzxx0U5VwKwQq2fRSrnxd9tTZjs
 r5wNfDAXSEWWpkSTg00+upb/f7IMeReHSgFtTE4Nt2M1wjkaVzGs9pKXduRfa0bPn6BG
 wVz28blpsyEdG9oJJpAYui3ZGRzzB7jZ1rJM8r4jH4iZh8AkuWJSyfCuFcWkdroLUZHU
 u+rt4G6ygKtHxhHh1eO7DVgkesOXDaUZXi8iviaUyhBsD4q/RjUKISAE83KXGH8aNVTH
 e41pG/aGldSVVKX+xbDiVNe/mIQNelBNrqYtgRl8tsqEQhk32cGvHB5t7TEx4SEWYLrJ
 Zl2g==
X-Forwarded-Encrypted: i=1;
 AL+hErFriFYXRcG36aqnpWo3/CKwaggaVFdWIrS9yE/pnEa07/ClfeEoPbhmKRIwWzXHRcl7XD7Nm12dFyzjOi1A@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/fEA6U+DeYko6YTkRksgNdzMPdqeJss+G5iM8if9oItipF5Gnm
 Wyy9ro3nsH6fky26SM0+hS+o9b4eZqDQDJ2KqxX5AzhQul16FCHb7G25ofMQYIF2i5ZmwQGS4Aw
 xT+g6KA2uy8A4y2DI9cAsKn1tN3WmJ3EssPQKDMSoUjY9ZkKRLVPhbZy7DG5mdgS3+/lO
X-Gm-Gg: AYBFou0L0Xc7Od4Djb7yaxpv2YpqL5d2wD59xKWg5SDYnhumK4qx8Ht0OBysQoqKBZP
 Wb4QtbdGedrTIIjsGitCnQyJQWmMlRioAmAnpvuauX1+FRj1K4pLlI47C8SAavtBj6q+CIZ0mQF
 sXq9ILrCLyvjYVPBcXtCUlrizbLOvHTAvccfTY+PgjIMdZ4I+PvcU5UV6iMftm1PsfvO0ojT73E
 k9zY3ToSB4iSAZKZuR1McGjiTpZsi87jjjyF0EhJMkH6yK+idfELgEYnClsNQkBVRO41K0ufjry
 qNK5sRZHMts4nR1H14y377HOgTzT2B3DgemNqwZf46V8u7of1pm7GB7bC7DkXWZQQIbX2aF7bGZ
 TRPBLGL3W+CFZoDO8tg5SujuZ1Mn+w09atZe+02F477727lPYNKDLrJA6bHHCADlCsA1F0SKUNt
 1QgQvwQN6ScJrtTzQTteCFLLHbXpi7vB9T2G9Fk9TS6ne1btcS8IDc/HMhxIgrmyYOSovXDIpTA
 4LoFP1N+60edNG58bb3QfZplIRcQPXZGU0bhs9PWDmrtcdCEHZrUS2b4Vk7GvdDckaXJVVZqskq
 U5crOw7HM9GWELrGbldSLaIVuEww3lNgv5ZYmJGuyil/gVD/Z29UNNPEiaapbtvU/kddSiWVFs+
 kvdlghroCcwRncqaL6m1Ysls7H7Fq1GAPaaMsZ5tkxHEiRTnD1oPzHjj8JVH/Z7C+GxtLjFveI6
 wCooqP3+9lUnolAh4=
X-Received: by 2002:a5d:5e07:0:b0:48e:5d33:da5c with SMTP id
 ffacd0b85a97d-499c48154a6mr6140551f8f.1.1794457770646; 
 Wed, 11 Nov 2026 20:29:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm13600069f8f.49.2026.11.11.20.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 20:29:30 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 04:29:29 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idf378bb5af0b2b4e8d746e252159b756e96c37fb
X-Gerrit-Change-Number: 2160
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2160?usp=email>
X-Gerrit-Commit: 54055b0dbb5834babd8a6f116c3602beb02dd10a
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 04:29:29 +0000
In-Reply-To: <gerrit.1794300996000.Idf378bb5af0b2b4e8d746e252159b756e96c37fb@gerrit.openvpn.net>
References: <gerrit.1794300996000.Idf378bb5af0b2b4e8d746e252159b756e96c37fb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwOTk2MDAwLklkZjM3OGJiNWFmMGIyYjRlOGQ3NDZlMjUyMTU5Yjc1NmU5NmMzN2ZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f555e0219909511badd2f681ab0a85d58de326a9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRMRN-000000003IN-17cO
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: always
 free the domains in UndoDnsSearchDomains()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6254358023236082618=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6254358023236082618==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vYAa9iGIBwE="; charset=UTF-8

--vYAa9iGIBwE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Heiko Hund has posted comments on this change by R=C4=83zvan Cojocaru=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160?usp=3Demail )

Change sub=
ject: openvpnserv: always free the domains in UndoDnsSearchDomains()
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
60?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idf378bb5=
af0b2b4e8d746e252159b756e96c37fb
Gerrit-Change-Number: 2160
Gerrit-PatchSet=
: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@ist=2Ee=
igentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Dat=
e: Thu, 12 Nov 2026 04:29:29 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--vYAa9iGIBwE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Heiko H=
und has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Pat=
ch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160?usp=3Demail">Vi=
ew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160?usp=3De=
mail">change 2160</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2160?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Idf378bb5af0b2b4e8d746e252159b756e96c37fb </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2160 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Nov 2026 04=
:29:29 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></ht=
ml>
--vYAa9iGIBwE=--


--===============6254358023236082618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6254358023236082618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6254358023236082618==--

