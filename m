Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9BE606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LMWyrBha;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FQbObM50;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VGox1+Pj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RlgTX8K7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rrhigRhWrxgWvd7doWPGG3l+BNICJgXdUmGOCzLOxfQ=; b=LMWyrBhayH+D5FYWj1Tio78PRu
	o5gFdalOBaVtYnimssMvFC+bDZcA6LEN5+5N6h/RfQpbjdGE560X7ewABPhpSDTsYv8B3fbV17S+p
	WS4cszCAkj8CoQh6p+W99KzfQDRKsLQfv/CeL2F0es4sdEWG7Km8C/bTpv/rh25LYnLY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKpq-000000005bp-1Lja;
	Tue, 03 Nov 2026 20:10:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOKpo-000000005bi-2964
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 20:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z7lpTOeLXff9uUX8KFVd0J7QvJIayelPtNJp8CkQ2RA=; b=FQbObM50PH9Ez3MNMOob2WdX+F
 U7fIAKz7EGGsmH+A9WF4ELOEhl9XsAH+1JvkJFbB2UXawobsLFIwfH77AEw+ppLlEi2P7UWUOisVL
 5/76Hs60lL4/auz16Qr/QwXNRdNXFAJBq9n8dnpiBqBu3nkakm68HEI4ZAK+Z94h6ddA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z7lpTOeLXff9uUX8KFVd0J7QvJIayelPtNJp8CkQ2RA=; b=VGox1+Pj+un58xZldz4i11Rnmr
 h49TqCFrjILu23ktlOXXUSstfgRWzZj6dDEpxvTT4rfM2NoPy7OLczp8E05Thg5UkV7/ITvQcd0rc
 0VFoL6B5S1iu9Qq0OY3MTc1u3PSZtbSakLsHlDzsACPV+6S2vtvwDsH26ErtiEHGHnDU=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOKpm-000000005NQ-3kwg for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 20:10:20 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so3983426f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 12:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793736612; x=1794341412; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z7lpTOeLXff9uUX8KFVd0J7QvJIayelPtNJp8CkQ2RA=;
 b=RlgTX8K7v59WGo/OT4kZcynM0a+tIFK4LXAcnFhnvt3/Upni15h2yTwQ7QLe2dR3Ss
 VEdFu8RS+xQS5MbTmCoZbg/XGGnyMNzWIGFVj2AzKrnSNYNOvLFSbC6FgSruFEN8nhKq
 nIH6MI8KeKjmEo/gxWEQAlwJjN8ey3h2b7tN9GX1qTba9/4wq1zYisS0PXWBlgnf9IQQ
 wyaMNK6XzH/kiSdjP2+ktvU5x26S9ODAt3irXZK2H9FGuR3/yNgaocXb7LA0y742BfxR
 ucPYvrOWr5lZhPcm2mLNgfzAxZgvzi6KCtjbPssz9Tl0JOidbTTwqdNSr2jZrSXgjDqs
 xoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793736612; x=1794341412;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z7lpTOeLXff9uUX8KFVd0J7QvJIayelPtNJp8CkQ2RA=;
 b=L03kkOhK2aOSXirSeVkGGZKUx4wLjx0+TwNFtBYzdSubd9tubJdrEsSzhHkgBuOSoa
 bNwkvWz1gFd85Nv7EwKW6J4R3Kg0hokXT1RWLIyPHGPmTURra0JSoaYA8neIyHDON3Nc
 xHJVWPj9vTrzJLAABDuoiVKAmN9dR3s8X9qMeoP0+M0nbIIs7vmya+SWPVYsnAhkllw+
 DznXR9Qb+ks9x4lfxuwlBr0vTsdws37nbu4t2tekN4Ddr4nO3E2mNrosiLuPKqeJGMcr
 QLW0iziXcPF25i3VUC80QyfemhW4Ucfgw+8Tq5inPw7fHLJYxGOMOmE9o4ILNslDVjg2
 qYlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqtguqJG9VqedcTNwnFTmz3NlWneEnyxR2xBLjj659/7wK7Lh6OrO7HlLSqbofJjjQY9Y0q1DyI998YNTb@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9j5O+AafBoH/TYh+Uf5NHAg/M/YV4d98YTZ/CghYcCNr8sPhwr
 inb8v+NSmHdm8vacvO0pvxTiEP/mqlStUHLgIm8rHiVpEQGr4VUVJvO/PZe8erE6e0FbnhdDVHj
 +YfYGdpta/9rHEpbMdYG0DX/7bsblEurFeueHsBAFHckG7wDgoU+AyAUyAK6Z+LFerTuE9gFTqq
 lFEavr9A==
X-Gm-Gg: AYBFou0cDRnD7IHWY3oJERe3Jkzt8R7Udy5+V3PxFU9xBN2ov55lavDPMGYp9eL+M1c
 LXHYAvUPB3Y4yxzcyqi+TAh0xx7EsZQj8s2yPcvnJP+FbPD27kA8E2GpVfrD1rDPV+AKboSMF//
 EPNkf/1n+aeo00SIZIDf3oue/k8YCa1uQ0x+dJxW8/omzL3W/bRZcRYlEG5Fgz0cM1Q9hIOTEpw
 lTfAVQYm/GxLWveX6jcH/UaTPP1yqkfZoLPOuORVATGHY9jgsGjZZEzIvNP/IqQ+ToXeuYHys6n
 Fmw6E6ip8upKeAJQEEJP8CJjZJBaQDI3sGoEUPku13PXZAaYsXVrjWiVDKjntWXoaxyNOLz++ae
 1cwvHiCKiXn/rASHADXlDF1oBXw3qBLnACTvAGjMrZfK/FpGe4gFVWmeGoDYGBMvSmrnxI4TFZy
 NAAbtnWiSJdCTbstH71+fLGoqomT4RiUUVV7shSKv98hJ68a6uvP4l44dyjYrvZJSqXqUJjIGmj
 9EOBPDtl2DNkT0lX0g5DPwmXqXsWNb9Ggw5LYUjJAvqiFf0DHPEDIc7Y+XvxYQ6k2As9Cd2qrLm
 06trUEPoEXaLJTKh7uSoKHWo8UFRMsURywZ2mJtsEa8IfeVHEtQy0t18dVNmys4PFima3cBFhEG
 HN+4AmEKDVhrcxLXEkrD8VYcQWkZxLLG46eCOXb1Y3YiEALVB7xPwz70fligSqETKk6u/0H9Spg
 qgKANVVeeMB92855i2BjzGKN8lmwmqesk7u1k=
X-Received: by 2002:a5d:5d84:0:b0:48d:f99d:a0d3 with SMTP id
 ffacd0b85a97d-48e6e526679mr31331951f8f.46.1793736612234; 
 Tue, 03 Nov 2026 12:10:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fcc5b1613sm391232f8f.25.2026.11.03.12.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:10:11 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 20:10:10 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ifc707ef69d614c3408b6f88c780e337e95baafac
X-Gerrit-Change-Number: 2111
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2111?usp=email>
X-Gerrit-Commit: d2b8fc1d0fa0ddf8d96e14529f50113a950920f8
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 20:10:10 +0000
In-Reply-To: <gerrit.1793733834000.Ifc707ef69d614c3408b6f88c780e337e95baafac@gerrit.openvpn.net>
References: <gerrit.1793733834000.Ifc707ef69d614c3408b6f88c780e337e95baafac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzMzODM0MDAwLklmYzcwN2VmNjlkNjE0YzM0MDhiNmY4OGM3ODBlMzM3ZTk1YmFhZmFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f733cc58484e96fbac57accd2b7cf602e6a1c89-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOKpm-000000005NQ-3kwg
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: free
 security descriptors in RunOpenvpn()
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
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3324260559497227020=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3324260559497227020==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EAjHCtHiZsA="; charset=UTF-8

--EAjHCtHiZsA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Heiko Hund has posted comments on this change by R=C4=83zvan Cojocaru=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2111?usp=3Demail )

Change sub=
ject: openvpnserv: free security descriptors in RunOpenvpn()
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2111?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc707ef69d614c=
3408b6f88c780e337e95baafac
Gerrit-Change-Number: 2111
Gerrit-PatchSet: 1
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko=
@openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date=
: Tue, 03 Nov 2026 20:10:10 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels:=
 Yes

--EAjHCtHiZsA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Heiko H=
und has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Pat=
ch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2111?usp=3Demail">Vi=
ew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2111?usp=3De=
mail">change 2111</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2111?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Ifc707ef69d614c3408b6f88c780e337e95baafac </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2111 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Heiko Hund &lt;heik=
o@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Tue, 03 Nov 2026 20:10:10 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Ger=
rit-Has-Labels: Yes </div>

</body></html>
--EAjHCtHiZsA=--


--===============3324260559497227020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3324260559497227020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3324260559497227020==--

