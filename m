Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC00CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cNSgpTsLoTeMl9Uk0Ij3U4sqKJatRSW+jYQSKKsV/KQ=; b=ggztqqXKowIfQquWKC32Rp/wwf
	r339VDu5ZIKhsUIH3YRCNsNFRENcCiJ+7afUZqmrMz8dlvVMxsVPbkw6OwtNQvm9Sf3XV2nfluMKe
	U9/R7OvwNVvVOGB6BA5s8vOnhbdCLA6y9UMOB7DCn+uomI9vzyhTB1AFvpa3G7YYp6dA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbcYG-0000f5-OL;
	Mon, 22 Jun 2026 11:10:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbcYF-0000ey-99
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 11:10:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ffgoJqW7J0fj2Xa+oBrs/1tMQkwVzpBZo0UnsRYB3lE=; b=Oq+4RxEC6oF5T9BOQWhPoTlIJK
 LWnk5hZpw0JZNqTAUD+BwbvioiLM9vj7NCijNuhLseFMdFGfDK8JZWxxXGEcgEANZ2ydSBeHMUyfV
 YiKqVXSfhWng7wniutiAj/vgxb4GZyr+xZFJGWUf/hV5gMEuL9x4YQjqZFweT0Eg+THk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ffgoJqW7J0fj2Xa+oBrs/1tMQkwVzpBZo0UnsRYB3lE=; b=G
 AL4Oi9LLws5MOokulBkFQDTVseGdDn7H3NZECvprTDtKlUw5H9r3gMyE/xtGiS3thHvvGqMy5urTB
 kknNtguur+Ebqvq7N7//ENkXFMj8QBGk2lWl5pGV7Wc2QnygCMizughHJ++P6tSs1Ywqt8blJdLDg
 WBMsIihLKhA/hxS4=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbcYC-0008Lc-Jg for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 11:10:51 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so3243994f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782126637; x=1782731437; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ffgoJqW7J0fj2Xa+oBrs/1tMQkwVzpBZo0UnsRYB3lE=;
 b=Sqnblf5EJd69Jq7emqWi8lc/1VeF08ZRyOu5/BVNet/WI4QCo3N172Y+kEFH7kXQfz
 kyQ8biqcJlQ335csJOWoHY90b+U3C2IVRFQ0xYc49QFjHJZ0A3TBJouplqM3cSLjA/ju
 TpV3uFdVCNa7McykTVPLVL6oDztnQolTDyZKFnnyeYtkztkbTtGfNiHOXaXFIw2o4Te2
 Q7CRGx5mxjhypBV3h/EcGMmSvOfnZ+vGXo0hNOioECATp3DtQ7quzy9JNB/X6cAm9wHB
 iHcTxs/fzL1Wjqr0FXKHtVp6cGeUFTArG3tQdBbgPyQI6OB5PBUOIpvUGX8oBf6D0Ivj
 4AGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782126637; x=1782731437;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ffgoJqW7J0fj2Xa+oBrs/1tMQkwVzpBZo0UnsRYB3lE=;
 b=SNqlXL3FZQZmCPoNxRdtdSVIFoCXH16CEi7jabwHLpmorygwW3l1G2Jd4HgIBaQDEU
 HhR6vzDWKMpkOAI5iLHdRsYBoyVazLz8R1/zmweQCAKsYAbziXthnhunW63nb8dCoc7M
 AXaC7u499ZwCiLObpqzInsQdRdlulZmHtveDlONillCkR7SX6U98K/jYHdWqO7BfTAqp
 afZ2c5BXn0le5rmEuARcwOTO0zVI/qBvJGDmC4TG5hEoz/ywdg9Kh0Bd8M5OzmEjzVxK
 TJWOrz8YZMEzSPi9VQikOVk5QP2jEnOoJ8tkaGvRGlmoZXIB8O/neY6n2C2CUlTVrIQC
 7l3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrU6RPW/pyYgIuUBklHf0jUIRCFjcw20HWCKDALk69bpgrxOEndJx45gKJdlrfJ2x+xEeCBNQiNKVLsX9AK@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyLCf9QyGgpxi5twI0e8c40tAAqkNdn1g8w2igK8STYzqF72rMj
 LK9earRhQtUZqyGRpsv6/KAsc4cjsaGtkcnAKB4DNRmq+kIGY2TnKIJPZOSshEuLO9DzaKf1ln6
 ROd064vy27NNwfyL51DPE7gHiVZXpvoajcOcKsu6LftupbPQXId66Bno4UTIYmW2B1YaPxu7IE6
 FYvI/6iw==
X-Gm-Gg: AfdE7cmQYo3xm1aLdgwY5kA+aEVFogoMpTc4bpzlilGhWGvCCTdDyMwCFkO4YpQsalJ
 GtXrA0JYdDIZaFmwOk4sI02YpP8/uzQN2mwPaAXnai+cWGC7zIG/WnCUDmQlhunVSeS9o3ph2Le
 7joQbaXYHuOuw0Umftglqw9aXJorTg6FA1fuHbNOYJB2MbMPxvES5dcM6IpFLRWYjVIo3j9FjC7
 WdPeKhBKWzP7mTVz0WC6fBGetV8VHykI/eqsV/sjbxxU+dZZce9d1Pe7nVzcSYqzgH9iTusWI5T
 v1c0iO3KgCgT+TQLV0EcvwO9L9hQ1iELGnI6X1iSLH7A5V4EfbpD/p9yxa3oTKGuao6Diyajaye
 urTCrrgo8iIuEIAMyL4BYR5upDkA2/sFvVnVR6y8nbs1QywCf15gFUgpxZtri74mjp2mSHmXcvE
 sAFCzlzx6ZUhFno0ECi7BWec7OmX5CoYLTMXYJLuBWDjfBw4ijcaUxd08DXc1VxkiDDKmb2enRQ
 ryhgc5IGs5rnx936mbu8ihcCRbOzYgHXgP7EDSDRQ76mbTmcL1hgAL/+koVyCx68aj+82HpwPSr
 5V4=
X-Received: by 2002:a5d:5d10:0:b0:461:dfe2:c7ed with SMTP id
 ffacd0b85a97d-4656dff26cdmr19840534f8f.27.1782126637359; 
 Mon, 22 Jun 2026 04:10:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666788226sm25372381f8f.23.2026.06.22.04.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 04:10:36 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 11:10:35 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
X-Gerrit-Change-Number: 1715
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1715?usp=email>
X-Gerrit-Commit: afeea8df799b1bb1c3fad0cb00fc336538f0217d
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 11:10:35 +0000
In-Reply-To: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
References: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMDc3MTAzMDAwLkk0OWIzN2I1YTkwNTU0ZmEyZDRhODNjOGZjNTYwOGRhZDJhMzZiODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c5eee2f5f036bb1822be63cf46763fcbd9651980-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbcYC-0008Lc-Jg
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: fix
 use-after-free of DNS options on client connect
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, antonio@mandelbit.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1442197519773784356=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1442197519773784356==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mn071klYhS0="; charset=UTF-8

--mn071klYhS0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex=2E

plaist=
hos has posted comments on this change by ordex=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1715?usp=3Demail )

Change subject: options: fix use-af=
ter-free of DNS options on client connect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b=
835
Gerrit-Change-Number: 1715
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <anto=
nio@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerri=
t-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: o=
rdex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 22 Jun 2026 11:10:=
35 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--mn071klYhS0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, ordex=2E </p>
<p>Patch set 3:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail">View Change</a>=
</p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail">change 1=
715</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
49b37b5a90554fa2d4a83c8fc5608dad2a36b835 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1715 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;=
antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Mon, 22 Jun 2026 11:10:35 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--mn071klYhS0=--


--===============1442197519773784356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1442197519773784356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1442197519773784356==--

