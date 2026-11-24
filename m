Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686F606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dteu55PB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kRopkXKl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m74SX+va;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MzJttXEB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=twLdi0WbYHgv4xfdxMGEPC3Rs26mcd4IXT9wsqFgqI8=; b=dteu55PBodZUs/c3iVNe/PfWIh
	tFPyR9Z2xtrEtM7Wegk8aw4pA2831OOL6pPbxmBG8ZM5QidR9rntQkiQR6lUhTkZAPPU1CqP06Dd3
	DL3Je93MDf1Fh2uIsKfUDvU6LrEstZVV2r5czA+aKxiC5n/0TDMYt8ImWqJqx+Alb1oU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVtrH-000000003yq-1z1v;
	Tue, 24 Nov 2026 16:59:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVtrG-000000003yB-24mt
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:59:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BpxGK53NGM9PpNJZO6q/JFDIwcicrFNA0TwvB1BzMhw=; b=kRopkXKlCL8ckp8I2KTl3fQuPN
 I2qPmDyLrz4gB1b2wRqMtx0a4EKXDP6BfsoNE3nw3bdtmHFlZZ9tYwQmFSxvF43pYNdcpztOIeXHq
 PJfZdB7X6fMZXDKhRqQg92Uz3dwpjan7+A2GtiNZTbHmBOzAr+xfTKtncxBl6S5PIHFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BpxGK53NGM9PpNJZO6q/JFDIwcicrFNA0TwvB1BzMhw=; b=m74SX+vau0Hkj6/buugGJ7iS9M
 IW4kXyOm93JRjJWgKvCu33EIERl05NuMaEocEq/+RvaOOlOEQsJ7a5gzbd4JQjjxAz0Ny28SFOMKy
 B6q2A8N3DVc/YG0OnIgJldV/w5tCaGnrpJAJlc33vibnUsO9pLFD9JiVscIBbAedvpwA=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVtqj-000000000Pa-3vQs for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:58:34 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4a32576da88so2773334f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 08:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795539507; x=1796144307; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BpxGK53NGM9PpNJZO6q/JFDIwcicrFNA0TwvB1BzMhw=;
 b=MzJttXEBqW1Gmb5/1ZjkL/xdHtFGDuFpvCAC1kQiYEiF20iLX0CHRACzb/EWA9xRYZ
 T24bXKLZiKzuz/wA9jrg2WtgQGBpmOF3eHybg2mFf+ksOYBHUN1OlP56ifL+dTrODfqh
 jRzZ4yfHiIu0vQp4raleXbMuw9f27aPwr9p2RuU+ODDI7Q0SH6ufJvZZs/JqxSGNiZn8
 +6LxUEnUQ8b0ZeU/TV+WsrKgHPiXFrOrDFq3ZKbZRS9Lb6Af1+hirmh+RWeM+4BySa12
 95Hqgfa81wc82C+21p6EdL76lSfArmc5h9s53sCCZc7Sn5RIoBBIxACIPMAkLnQ+rm+M
 /boQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795539507; x=1796144307;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BpxGK53NGM9PpNJZO6q/JFDIwcicrFNA0TwvB1BzMhw=;
 b=H2OMnRXgCeWV44k5gLMrBrQPBI8zwUc7CXYZt3B29CSbGAi5L+D2yzgYoDXeusGZS0
 Sqts0DsFmrPILCXNZxc0WT5X4jX7GEmwINDpOFds7kz1yVUGrcFi6LnNYzIo6wkeIlLh
 uh+Itt7m1xC1bOQ62nPKvsysizTlk+e5///AbQyTizvmxa9JywNz4DiB/hQsuHT2ghHZ
 /+A+D1vvdLLDq41edMcDlCgWQZgvbv/Dn7LzPhSBnd9AF37oMyVC7JuM8S8YW3fFfZSx
 cR6WposU8fJ7Gc8WSGQ9THC+onf3GlsRrklg6IFmCbm70Ocjk0YdNlZniS1qTPuaJhZl
 eDhw==
X-Forwarded-Encrypted: i=1;
 AL+hErHNeXJTEHtqW2q34RhbpuPhFZYTLtfWTvTCGSrLmlBAMGZR5ETDTjOM/169yQEZARBoqA6icYxiJCKgyuHI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9vvx/037DZV8zmIIjJTjM/+54ZvFppzIlsE/yHT1HT7EcTEmdD
 tb0Vy+CJCd8gM3BXkbe7RqlMDaWKPox6ORSir0wEWsKUFtnoPBqQaIQ2Tqa+j8FprZleD0hoQBq
 Y9ZbGa3klI5HK4MLPmzbmljyCyzGnPYBJB820P9z1UHcg5DmQkjHIFmSJxCXzsV6a1lEdcFWJYV
 z2iqTPgw==
X-Gm-Gg: AZFdTZesIzyY1qywMCe+imJYiKlHkavssNaD+QQryUO2QRq6amID3/HUpu5/UnN5zJv
 oelT0QuZZ6sS9+xnpkEJqzv5EI85JTIYATxAD72EJhpGUEi2jMiVIZnAEg/lBMkFs1abiC8qPLD
 T8tNb39qteEYEueqvf7sfEXSEw/f1TRD5sP/wQ+E0BXAQEaBzgUpYWvJA50dXj8CfWNRg4yEA7P
 nzuthCVYMPWy2rFC/U3qVh2n0c+ulD+UN4BhK2YuJkoz51wCp9VGYXOX00CglP+UlojHQzdrw42
 e402OdLcddLrSRCTKpS/l4qWlG7cEDqgSYrWvrcyJ3U1vDSchQ3r4nuyoCcy9CuaCTOr18V4AEe
 W45imi1PkIzpRC4H77GwNqEV3iL5OD+bDpVx/KG4BR5fYqlvXn3cl7FqXQwUm+xQTnikCi+UrRZ
 tP8r1gD67D/w8bP3cFWretYONn2/gGfdKJJktK/Ij7hKIQDACCHNafKHJibDwR9YAGyNIi95g7v
 enNlTzLxJwn7WzrGkLuzX2IhvBGgXPZDbTLZupCQUK43EHBcYaJhc9H9hZOAjW62gU0cKj9cDdQ
 BzNEgWBDyJ3RncwjvFc65lAxk2DU3jkkY69rcqwGs9VOCI4OY5U+8Ymke9MnZjt2Nyt0dYrVGQd
 YcS/sRuRPU+vmBFOOMK+iRB13GAosg1rNVaW8+wzFK2eToVHGEJqVvJid+KeNLOUTzmo3+we23B
 wX46Ec+5nHgDz5fwAX/rW5TY5OJ89B0Kaq79u6
X-Received: by 2002:a5d:5d82:0:b0:4ac:7595:6f68 with SMTP id
 ffacd0b85a97d-4ac75957253mr25269820f8f.36.1795539507186; 
 Tue, 24 Nov 2026 08:58:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm30193278f8f.31.2026.11.24.08.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:58:26 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 16:58:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5
X-Gerrit-Change-Number: 2339
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2339?usp=email>
X-Gerrit-Commit: 6c639e79beaafa6159e677e587bc82ca01fa34db
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 16:58:25 +0000
In-Reply-To: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
References: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTM4MzExMDAwLkk4N2RkNDFiNjZmN2Q3N2NhYjdhYWY4MGZhOWQ5MDk1ZTQ2YzAzM2Q1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a76474a3bd2dc07dad653e953c073c31f2b09eed-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xVtqj-000000000Pa-3vQs
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: Fix
 conversion warnings in man_write
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
Content-Type: multipart/mixed; boundary="===============3321246242520409864=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3321246242520409864==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UKF+ljtENl0="; charset=UTF-8

--UKF+ljtENl0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail )

Change=
 subject: manage: Fix conversion warnings in man_write
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Com=
mit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339/comment/354f5=
f3b_f2628340?usp=3Demail :
PS1, Line 7: manage: Fix conversion warnings in =
man_read
> Doesn't this change modify code in `man_write()` (not `man_read(=
)`)?
Sigh, what you get if you write the commit message too hastily



-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80=
fa9d9095e46c033d5
Gerrit-Change-Number: 2339
Gerrit-PatchSet: 2
Gerrit-Owne=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Da=
te: Tue, 24 Nov 2026 16:58:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--UKF+ljtENl0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2339/comment/354f5f3b_f2628340?usp=3Demail">Patch Set #1, Lin=
e 7:</a> <code style=3D"font-family:monospace,monospace">manage: Fix conver=
sion warnings in man_read</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">Doesn&#39;t this change mod=
ify code in `man_write()` (not `man_read()`)?</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Sigh, what y=
ou get if you write the commit message too hastily</p></li></ul></li></ul><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339=
?usp=3Demail">change 2339</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2339?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2339 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Tue, 24 Nov 2026 16:58:25 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>

</body></html>
--UKF+ljtENl0=--


--===============3321246242520409864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3321246242520409864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3321246242520409864==--

