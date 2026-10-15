Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1E2CC6B33
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nbXwtP1xepH6okw6cJbA1FrYHGVr/RUEZPpgcd/QyUE=; b=BssAp5Lhv77cchchgozKRjxl+1
	EU/IYt4AaIMb+nGcKZpkAdGVbG42hRXzEZiaxZrckRt2+n4lgnUyTPo3VIDq3Qq3irC/RWcEEk84R
	bwTL9T+ygLhE99xgGgX3QBo82ihmwRIWIr94cfTx0MS64UKwO8QuWX0q2Glk1sUh0y00=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHJLo-00040L-Av;
	Thu, 15 Oct 2026 11:10:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHJLm-00040E-NW
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:10:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1yDxXLmR0OKp0hAkAmnG6ZsyhcoVXyEdxxUT+jp5OaM=; b=hs8cJwVV3itp2QGSg6m1FtzM0k
 VQCEFi9mH0l+ymj02fEmuezrzUv2BkmCh/kkPv/GK6OONf4uBbvWs9KhgSnRF1SH35/MflLm7fvVK
 yCIZpZAt3rUD6Jnimodm1Z0qL8IVtxVJA0eY9F0zj1DKk9lKaSiENsmXAttZAE221qZc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1yDxXLmR0OKp0hAkAmnG6ZsyhcoVXyEdxxUT+jp5OaM=; b=Z
 7XCFbInTQdIfasZHi3/1LJcnfKZgZxnyIP74VfHOa3iis8rcMYoJgExCAmJZnGUzfSDiIJiEkY3GI
 xC3yK7Ex498s29nxzWBZM7r52TVNQgjqT7bQhGDHpyWFEXJQr3tKeQFL9yjzR8y0oOt3vtQzmJB3U
 r76eGVw22v2USXus=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHJLk-0006Rv-GG for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:10:19 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so41462025e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792062610; x=1792667410; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1yDxXLmR0OKp0hAkAmnG6ZsyhcoVXyEdxxUT+jp5OaM=;
 b=gd+XfdgeygKMYS+/JyGD9xrY7Tlb7u+8ykz7GwtPO1cmcbrdLsXagqogXGGZDdtiTA
 hH0kKw/IUD3FKb+T200IcGldd3cdjF74Ttv9xvQTZAEmrrzlemj4ymHtKmWGEb8UAJlv
 Ggc9M3OhzGBIZxOzFaAalxSH5HuwOKG4HXa/CvvD1UwyIAGp1rX+p28AF8JOPZfeM0z/
 3dXZjbn9kxHOZtTr6x/aNPn8UUM8Fd2RRd1RB8QzQuC6swSrOeu/nvZ19qWvjJe85NDg
 ck1cRrnsRgJiQzUiqn3bwlmE9Ng/XFuvbm71rZmSvR65+/jLInNLaI61brGr9RsMn2+8
 1HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792062610; x=1792667410;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1yDxXLmR0OKp0hAkAmnG6ZsyhcoVXyEdxxUT+jp5OaM=;
 b=LAm5cDmLzzCKSmGpe790yO/Q8y01Jv8yCqqSK4e0NSan4wswvY+Sp6tYxvHIUMfns4
 rJnAfg+/qXg2Zzs6x0FiFcAH998QYuSuHCDOlxnp097BPmKeZxof8LFaZY25jo9qU70W
 hCdELzNwG4wCuww8Cfh+5ItzvWXUeMPYzYaxBaDyzz7NWiqiWLYt7vepLZszo0nDm1ei
 7aso0OO1L0F5yzycjseoZwUUw9ViI0lMgkaWOSHJGbQ/0uTb/6bSvfKBOVZ2i6AqyH2F
 NSEFjD3xrgVpa74+mdgKf2t5tq/iRYpY9JEorzl8wwpoawYkq2bwj2af9K3SSuTvkkrs
 yahA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuh88iExFgH9B9hilunQr3SBxRlNSaL0u7kYz9S8UMBwfag3DloHlueJAjpDEfMrRG3jg4Nuz8JMGNdz8i@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIFtDzdB5nZ/6Dtwj/LTKiVl+vWELmgk0eZ0cvqVyv0rLZGoCGq
 j3okPVHhu6cNMN41z6LDGi6q9Ix7PkFJk6OoyceuXVlA1u6UXGupT2BYAw+BkLIpvmE7pz7YpL0
 3ogbbItEsXXS9vmSNGmkjC2P/xzxq4CpaRRpy7MVwNQgmvdhfPL0XqVf0iFYeAiNctiyy
X-Gm-Gg: AYBFou0xjivcFsEeeadPcZ6Z+9UXyJJUwGziBLpZZMV6bWrykRlGSvfCBxlzpxZgsBp
 w9EoGbKxGSCeyCQtszCYJYYcqxkAebhkkHeWNyBZGcYRV2M979eMCKtOHU9ZuCTCUepePBWkbHn
 6ACqM2WfBIhm0H9GjxmiMdiUOPLjv86dPzHpETBHR5oSzEkhzid4P+cYrLQiRDJD078e7biKfMi
 SyId/WetbTKTFfGkAcdhHFS1yNOI4srINoUVQw3YOZX5mh/VTKWThXCGhTNg00/8yQbW0W22zH3
 9aq6NLTzhgWyTYjjPa3iQ01RO8WQfxFUESoimMYRxth/x4le1vpjd/TCmveKBy5YP0mNuvXB4dw
 T1Anxp2eMTkPNYNjwHgtJVZpePGfA+4Izrdrr/k9+FwerzZaIvVcgeZBi/1dgso+dbqGXUNMp2i
 EUrHd0WzO6Vb3jsnYakQGUb2ywtMzjPs43/KLRo+vqkkZflaoaaPm+Z3kLOSe1bfHvydh9wWbMD
 MUHbCKNDyBc4reQB99/JoOuySFn87o3qxCklyuaxKKZUsdSZhQVTBpW/U7s7h9SljEKKyplg5hJ
 dRCWR5xvlUM5wS5/PhhZevk3hkSlB5X3QE7SSTJ0nalhcRhu8r+Q+4v29KKX
X-Received: by 2002:a05:600c:3b1a:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-4a18e4b91f8mr319894525e9.20.1792062609468; 
 Thu, 15 Oct 2026 04:10:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0967affsm16317632f8f.1.2026.10.15.04.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 04:10:09 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 11:10:07 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1
X-Gerrit-Change-Number: 1999
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1999?usp=email>
X-Gerrit-Commit: 1164885b3fb963d16f9b0649f3995618b975db64
X-Gerrit-Comment-Date: Thu, 15 Oct 2026 11:10:07 +0000
In-Reply-To: <gerrit.1792062421000.I6294665e39ddf012f0a3943d0e356576f4fe02e1@gerrit.openvpn.net>
References: <gerrit.1792062421000.I6294665e39ddf012f0a3943d0e356576f4fe02e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDYyNDIxMDAwLkk2Mjk0NjY1ZTM5ZGRmMDEyZjBhMzk0M2QwZTM1NjU3NmY0ZmUwMmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cbfed2500a171d620b4ee4b6378c835c3e39fef4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHJLk-0006Rv-GG
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clang-format: Enable
 InsertNewlineAtEOF
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3554911271855638948=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3554911271855638948==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5374IC3JgCk="; charset=UTF-8

--5374IC3JgCk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

G=
ert Doering has posted comments on this change by Frank Lichtenheld=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail )

Change subject=
: clang-format: Enable InsertNewlineAtEOF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I6294665e39ddf012f0a3943d0e356576f4f=
e02e1
Gerrit-Change-Number: 1999
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 15 Oct 202=
6 11:10:07 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--5374IC3JgCk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Gert Doeri=
ng has posted comments on this change by Frank Lichtenheld=2E</p><p>Patch s=
et 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail">View C=
hange</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail=
">change 1999</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
999?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1999 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Comment-Date: Thu, 15 Oct 2026 11:10:07 +0000 </div>
<div style=3D"displa=
y:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: Yes </div>

</body></html>
--5374IC3JgCk=--


--===============3554911271855638948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3554911271855638948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3554911271855638948==--

