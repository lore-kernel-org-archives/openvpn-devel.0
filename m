Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4974606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=k9BBK8UB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=c0fDY/w0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OGUkPLvZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PoH8xNWZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PopRXmoW4PhBr2s6khPoBJyIzEb90Zp75niw1DbZfY0=; b=k9BBK8UBnQU/6nA7V3X967blWM
	e1nzkxaBH9VTfL+QLM2js1frySuk8LscHpCpMjer7yEhTs2i65aGsFgfznFt6u1Cfht3RjsiULvU2
	in30YgPvg5Hb23s8kpN6EYiQU3X/up6MVk/qlA5QbkDwQ6Nmvq2mJQRZKNHh62ED5UuI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRBvd-000000005jY-0tfx;
	Wed, 11 Nov 2026 17:16:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRBvY-000000005j6-0CDS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 17:16:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VJEnxNePuomoH6GmS8sAO5hoyEoz3Q/8FjP5tEFcftc=; b=c0fDY/w0SG4DiXhlda22TmK3yx
 1SoLxb0N2/HBtTKYAbg6iX5me0nSsdC3oV/sQwBDTeZ0RjS/A5J7j1wFtdBj9Svp4ekzS29vbGPl5
 Cvvu7RO+RuaxOSRh5rTmgga4Vj2Tem6SoA6dWOdEpU+dlgqzYf2P/Y0K1H+KMnZqxqvw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VJEnxNePuomoH6GmS8sAO5hoyEoz3Q/8FjP5tEFcftc=; b=OGUkPLvZJtBApNDN9GZlhy8jfd
 1nninRNU9ND5CPZzyfxLuo+XM2ULti4ehVTnZo70QIjUjuz5dt6qBP5twJoondlZOaQDMnZkbLvC/
 PBEq5bsPjZ8ZWU0fKLuldl+ojqLTvsiSktB42e5XL7/sVR8bCpmpRxfSBLWjPZOGQTj8=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRBvW-000000003O6-2cTe for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 17:16:03 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so19912045e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794417356; x=1795022156; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VJEnxNePuomoH6GmS8sAO5hoyEoz3Q/8FjP5tEFcftc=;
 b=PoH8xNWZ3afpVdDPo1ZZC/d95rNGcDXiCj355OAISbUrqyV5TOudEBV3T4uCeHKjLM
 b+x10GKTfwInyEwqgfAfP9H9gXOt5l5OV5a9lY/tXmnlVU01CiGqRcv3xptg4b1ci4LN
 XTLUpBEVgAspwhGeF/T6Agw3V1wIvTK1RHll4k+PFWIvmVKLto14RJXA8Z/7x3MP8rvh
 b0KUqzwrGm6Mml3y6+uBGAp1J4JCOGOI5opW3l0i83tWicCP0lwENr1DP4yaWCHuMAR5
 f4L/xwlyYYusmA5WLZmTSraHaW4pXvjLoQe7U7pv5OUPgEQOUjlhAK8gy7DdhcInqgvv
 2IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417356; x=1795022156;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VJEnxNePuomoH6GmS8sAO5hoyEoz3Q/8FjP5tEFcftc=;
 b=DAxcehxMPEtEi6EbLC8t1rV2R/4/I7P8d3ZjRBTt1zNxzCvn4F3pwcUP7F9y/DnOFL
 3oHjc/VvVvmbuUc8oxt5EttprYO9A1rKRCwZA5Emy1lJ7pLTGHZ1ZDA2CDwXS5Za7l9B
 QMBEpQM3cjv8rxhxgoG0fKwl/Y1D6pooSKtPG3vlvyHQH46yOve8fDqEDZd1+L7sMX2U
 W+gWT5jZjZkZoAmkLteCEsaH0OXiZmKtRfsbHVqo7ILtUjBJXoHorkOJZ7iobYJ0ckYl
 BHY3K3v4LWeCZMIUQ8NRm0G4xZqu7ox7ASjZKjBwzQtZslMd/b7/6eaZnkuKe0rtygLJ
 lA/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGMu8rIPJ0BYxYltKWgHGnpx3I/lNJdF1jlWvy0sL0Iegmu52kyCsIY4VJZCauImBt0huAynapp+N/9e2KO@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Wi9bJ0QieB/kMotbjG+M9LHrJmix2oKTt2FgPOjBtZcH6/dUr
 guEF73oxn/Ei3dH3fU9Jxumct31oEbySaLwrHf4YOgJNnulJH08MILMT1hFajHxuWjFcBhAugkt
 RpDzGGWHrSjVRJ1gXUEOmYFd1vpwfVli4B6NoAgHl/eYkKL2g82w8abw7jXPAOwrhLwne2KiRfp
 jWWHBgMw==
X-Gm-Gg: AYBFou3+7WioZxVrbCg14coTZwMRh6nGUyS1u358zFaFvEcmXu2wUggIpZb01OTtT3u
 d6b1m9OmW1sC1q2PICH8NCNldHq7rEjgQVywMIA9TVotDeH80Y1xzd158FZFBpgMZg3tZGEmxAA
 yPXrPnBcZ+9hiPjqYxSDTh6CPBtOI5VhcxUC8x9UMN2CkhhvhuD0eyiikq8qjnzS+JqP3bjIjga
 3NjW5299w7rNp4FmoRcTQ6MPIg1JHmHKvZRWhWhjF5bPwZx4fRc0LucIXrb1Q6g6+/Y6zT3yTLk
 wsYjWg4BkMuojyqD1grfpViE25RyCP1gTO/Zrie1mz4Kr5BBVaNQb9Ps+urGqI6seGpdm6N2xvx
 rPRCwHbwLFouaYP6pu77TfMB1QSe2oA6sGB3qYu3ZMkfhsGEvb17q9htYjOV2R4JYa0ZvpdoLJZ
 ivAJBP1RS+9zaRqDzRcnFlpeM1uS1Hxw0vuIZ2g9XF+Y67TLrHTtLRgQ4waYSjoLPnFQH1kuMTg
 DocuU3lGrxx0MPffHJqqEPHwHc8EDvfaXuMhZGLP2ziibNxQtGh5foL+elHC1lDAaMEMKaTverS
 hQansdGl5JqIPWLyxwwCyRdh/cQOa2kaZ3Onx+mAMexz2bfv3lwT09Weh9FeAiJ+hi8LzBffGsN
 fD2TiJ2QLFbjSRk5mAANGu+w1P7OGW5lWoA6vImX1ZsREuusGpzKpGiCmyIEv4O5hMXdhedZDEB
 fF/EVyYn9c0oOMk7KNIegNndPaCwURLFnZxYMY
X-Received: by 2002:a05:600c:c167:b0:4a6:30c3:1114 with SMTP id
 5b1f17b1804b1-4ba0938a12dmr55604665e9.12.1794417355898; 
 Wed, 11 Nov 2026 09:15:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e284339sm2164445e9.5.2026.11.11.09.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:15:55 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 17:15:54 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: 19f2ddf9de29e73f657ea877c51e3418c71ff33d
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 17:15:54 +0000
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a7fc4f044a5de3f5526176c9c2acac2ed218019a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xRBvW-000000003O6-2cTe
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto*: Avoid sign
 conversion warnings by using defines directly
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4322262974325232980=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4322262974325232980==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XxNk8p+Hij8="; charset=UTF-8

--XxNk8p+Hij8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail )

Change=
 subject: crypto*: Avoid sign conversion warnings by using defines directly=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 5:

(2 comments)

File src/openvpn/crypto_epoch=2Ec:

https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2158/comment/3458e29c_eef2e638?usp=3Demail :
PS4, Li=
ne 44: #endif
> I think this pragma can no go away as well=2E
Done


https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158/comment/ba88f4be_3bb4af9b?usp=3De=
mail :
PS4, Line 466: #endif
> This `pop` can now go away as well=2E
Done

=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3bcb4cb8e17ff80a5=
cb8acdaf18d1072159184e5
Gerrit-Change-Number: 2158
Gerrit-PatchSet: 5
Gerri=
t-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comm=
ent-Date: Wed, 11 Nov 2026 17:15:54 +0000
Gerrit-HasComments: Yes
Gerrit-Ha=
s-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>

--XxNk8p+Hij8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_epoch=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158/comment/3458e29c_eef2e638?usp=3Dem=
ail">Patch Set #4, Line 44:</a> <code style=3D"font-family:monospace,monosp=
ace">#endif</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">I think this pragma can no go away as wel=
l=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2158/comment/ba88f4be_3bb4af9b?usp=3Demail">Patch Set #4=
, Line 466:</a> <code style=3D"font-family:monospace,monospace">#endif</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">This `pop` can now go away as well=2E</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2158?usp=3Demail">change 2158</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf=
18d1072159184e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2=
158 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Nov=
 2026 17:15:54 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>

</body></html>
--XxNk8p+Hij8=--


--===============4322262974325232980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4322262974325232980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4322262974325232980==--

