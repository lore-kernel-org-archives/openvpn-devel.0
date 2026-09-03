Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840B9C624A4
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cUTpB20YF+0HRimGCRaWADETwtZO36sayn534Y0W2Mo=; b=J8TOzVpskgJJAodRUiVJnFu/hi
	9d2fAQvTgiTYD0U2TNUD1ReoNcX2DPUhuFW+u7K2c+3iSD/xBo0pzlyp/NQ8qIcG3bOczQCvDJkrs
	j+rK0jeV7wE+SODzrK6c72fr4259+i1KTO0NkLQANl0nJ1vA/0bYPLLVSDHHF6VhMjAk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x27EH-000789-Sa;
	Thu, 03 Sep 2026 13:11:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x27EG-000781-DC
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 13:11:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=C06rMo3BhRzZT1SdwE0CPqgEd4zjDKwQJDOIkY6eI1E=; b=HZMki2ve0+gHMVD38xbYt9icsP
 mrFWnNvJs9ur9ZNEKIbe0bCTeDV5MYlfkOWou+lQBSkiWhZZ7KsjtUKRiZ/GvFCVl2q7Cjjyoi+Ls
 ADqWqRiE9kLXLkjS3CBw3tTIbAUQA64EUZUpuCEZI9UUz89pa4zBJapUEIH7T0A/r2GU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=C06rMo3BhRzZT1SdwE0CPqgEd4zjDKwQJDOIkY6eI1E=; b=H
 sFQi8cAX4ZTfOMzfsycWN+Uc2ENdoLiBT/YJZ/tojjjyt97VtjVJi8IhVDcJnlI6U8XoF106vJTtZ
 sWKUJebaA74d57JEbsLX9hil9wJz8EyQfsiffzCnm/dDkNCbHoZ0W9jO2pnqIBRBJM3HEECFwgX6u
 VRdpVYtl3VI/Qfh4=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x27EF-0003Yx-N4 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 13:11:44 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso17757715e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788441097; x=1789045897; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C06rMo3BhRzZT1SdwE0CPqgEd4zjDKwQJDOIkY6eI1E=;
 b=C3C/dKukvcmib4EKlzibL1/y29i3rI4lQtP4K5XjhcoS7TPvK62INTiRaZjvdvGdQE
 s8w7dx/w05c2c5x6UmdosYOarKpOrflurRr9MbKV0iazjJd5gmpu6ns5MSs3QNi/pD3d
 jw7+Qfi53SpNEsz5Zzzk2VCRBh84rfMNx3A5FldJkAImSa+lGhcNEXeiu54wH1KA2o+l
 9Yjvyben2PbEC7kS8/bjCjfYZUG9tKyhDSHvffGw1qTWxJNbv+zHTIDoqY0STiT9X35Y
 pzs0jqYXy5jGyYKLdJHPc/HnKV9GnkHHQhlgaJ263IhogbRrZPpx2Yyb4QMfYDoIlPWK
 pi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441097; x=1789045897;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C06rMo3BhRzZT1SdwE0CPqgEd4zjDKwQJDOIkY6eI1E=;
 b=a22pMMaoOjPXwP2NhcMutriAo7UMCyEw5lx9qe08DRFAU+6UT1jDVblhW0XWmpiPpL
 oNqDqdAzo9SKgYIVcxITRde78wasGUrIX2vuOu8bzHkiXpD9QxHgj8zFxJ+M2JF6ZuJy
 yKy9rb73qP/2aefvQBBo02DjXRE3wAIrfMKza9GcYz8k0LPegFqDsg5p31hC+m3KWXlh
 aG5MdNFTECr1WV5v9tZ6S6NgMDEYmcpJTeg8nOxauE7p5VFC9enCy53EirgZ5U8BNjGr
 PGOK57E/hIxLAONM+VpUjXHW8DjISPYu77d5Jw0uB+D6n8aXEEVy+nksyLChKQibbXI+
 cPqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRyP0PRYQBoA9/Fa6EYOBKQWFUHDV5BoWNRLy4+4Ck8YWc4EzAB0dR5+A0deFNpwMhE8sn2tn7BnoHPLx5@lists.sourceforge.net
X-Gm-Message-State: AFuF++mD9ZdGxu9w3Y1hL2dNQRExsvmbZblHDbad67jsSz4tUcQVlr9p
 yJkoTZe4HCPqJ33ZArK/64o2lSF6SjKdyBoNIQyhAEgkvFrzYDCdlY7pCKt45SGjXz+IShwRkSu
 20ThjlUlzgHpsavHZLIiHOO9hBnwyWOvOamrdJNimeOYhjOJL30q2aEkTvw9q5O01qG+P
X-Gm-Gg: AYBFou0aDFJf8gmSGV6BbAq8mNKBm5j0cVopZGFcimSwKu3dwPURe/ZoTPK/+x1Cyj7
 +TmlGlDbtGLNPL1Xc9zCCJc+VKqR+7mTj4SKzfxItlc76REZEz2JnbBwNYuonHvDmh/bbcoxlsy
 xPRuIjPitUgUz+HVd++RpHHPa/Yy/whCk4yb7VQCjsElLY99rKLovST2FqemUJ2Y6EjEY2b+kTw
 ieGSOCH4IOayrYhuswfOvK7Va8EjRoh+CXMcdA9gQ1tkoTXAzYtI+mhRzeyrQyKO1RSSfQfLaRV
 Y3+OJlwj441u5FHVOUIMeKn/wRiNc8akLD713jPb1KwGxbmIJt7oDfblZNwl0pa1RsH1fgHoFs6
 AB1q2Idfz7lGgfZ7z0wdwWTxNUY0KoMvY3W3fJwfvW6M+4dVO7/EwgQM6Zoj9IDZtSJjZFa2ohY
 7YgWTf8OTM5nH8y5dI1rS5G3az5vURoa+r/kvbewZfiKvGXbjCCCdSd5CrNBjfPqsaU43N2JAQR
 QEJl2ffSVBlt87DvPC1foHNjAiDB2wRoCKM4sgeVSc3W+b4f2D7uhDp3235W8i09Mz5qFcgfygL
 FKF95jZ8QTDIVKP6TgBuElm1Ic2VSQlBpzgVWhVJsAt1ru+c03Y=
X-Received: by 2002:a05:600c:1991:b0:49b:2796:be30 with SMTP id
 5b1f17b1804b1-49ce5838916mr201606085e9.11.1788441097077; 
 Thu, 03 Sep 2026 06:11:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eea468sm14556126f8f.26.2026.09.03.06.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:11:36 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 13:11:35 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1cd2fcb363b6ee95f25c5cba72f74f85e43ab66d
X-Gerrit-Change-Number: 1896
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1896?usp=email>
X-Gerrit-Commit: 3e597f69e1f1583a086fe787c591924f58020ecf
X-Gerrit-Comment-Date: Thu, 3 Sep 2026 13:11:35 +0000
In-Reply-To: <gerrit.1788440813000.I1cd2fcb363b6ee95f25c5cba72f74f85e43ab66d@gerrit.openvpn.net>
References: <gerrit.1788440813000.I1cd2fcb363b6ee95f25c5cba72f74f85e43ab66d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDQwODEzMDAwLkkxY2QyZmNiMzYzYjZlZTk1ZjI1YzVjYmE3MmY3NGY4NWU0M2FiNjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8551e76325637815615fb36afb5d9fd875c69698-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x27EF-0003Yx-N4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: set
 ifindex also when adopting a pre-existing interface
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0882880743744916801=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0882880743744916801==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IZEUp5WuvPk="; charset=UTF-8

--IZEUp5WuvPk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

ordex has posted commen=
ts on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
896?usp=3Demail )

Change subject: dco_linux: set ifindex also when adoptin=
g a pre-existing interface
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review-2

(1 comment)

Patchset:

PS1: 
du=
plicate of patch 1734



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1896?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I1cd2fcb363b6ee95f25c5cba72f74f85e43ab66d
Gerrit-Change-Number: 1896
Ger=
rit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Review=
er: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Co=
mment-Date: Thu, 03 Sep 2026 13:11:35 +0000
Gerrit-HasComments: Yes
Gerrit-=
Has-Labels: Yes

--IZEUp5WuvPk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1896?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1896?tab=3Dcomments&amp=
;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">duplicate of patch 1734</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1896?usp=3Demail">change 1896</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1896?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I1cd2fcb363b6ee95f25c5cba72f74f85e43ab66d </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1896 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 03 Sep 2026 1=
3:11:35 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></=
html>
--IZEUp5WuvPk=--


--===============0882880743744916801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0882880743744916801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0882880743744916801==--

