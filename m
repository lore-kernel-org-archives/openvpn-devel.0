Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FE0C88E79
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7/t8V2ApW2IVi6bMN2uYy47kMdtrAUEtex4q9rI6fS8=; b=cT7gTuSZWfnBUvrKAKGiI36Uvr
	mI4p6sj2QxKiN+8dZmuPp8cjyHyr5nspOg/UyAnvxKHx5uTfWa/1DLA91VsvuJXINLfcolww1Ri+6
	3X2tTyUFjBK1lapTmlbjKIWjU/Kc72w0hcB48W9qb3uyPRQauOEotIaj/Mlozi0JHjis=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67Wo-0006ho-EF;
	Mon, 14 Sep 2026 14:19:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67Wm-0006hW-J6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AdnUbK+a7UvgU71442TP5UqJd09DlMAj1i0iC14aIfc=; b=F0x4egS9Ni94JRvphWCRIMiKgI
 GacbdhhVefZYICg0P0RmrwjULfuYYqb2IonqdFP96W76Lm9kPBLKfqNBhggfgak+QXXUYva/YMQYs
 gNgkdotOs2jcrVLNIC8SvejIQoiXzcmPnXwXzPDlQvXx/YPsB1k+BZy7pjajf7FRLpzY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AdnUbK+a7UvgU71442TP5UqJd09DlMAj1i0iC14aIfc=; b=a
 /vAbO2xmbpcKfItj0W44LVjbQqQ2zSCE7xW7FbW9DUoH9NovwON1a+mzff/A3/RpQTK2YiKwCncDd
 pOTJQ0fHUuxE0sAyAiwzpVNY3hwMzXEgSeX9W0dpSYj/9ygoCypBKaItZfDzU1PHts+NwxBYZbPNW
 8SKMxicoXTu+9ciM=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67Wj-0001TT-O2 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:24 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so1763670f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395555; x=1790000355; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AdnUbK+a7UvgU71442TP5UqJd09DlMAj1i0iC14aIfc=;
 b=dp4EsMQk6tHBke2QsXpmRHAmAdyDw2PsmsqRlazgfW0o/aqJklWiYfTM5CZKsveztj
 uo+7fk/WQbUNxwPi4V6jK0XSgfxSiTSzBFYWiteZL/cCZZ9KClbGcAaToIwB09IU+W3J
 Kr0q4Xxbl9ytJDoymxz083pU3Nz72KQrVuUVk+AaYlIQ/oCBP0vIw8uqls6EY6eVRgdK
 kcO3z+oJjUxuJkH73g038mRkxq7vIncmWkGe2pTIw29/kECS7MwjvfAK9KLtZ5W4iSpO
 22QDSjOq2S5B2OV+iHoe6DriogzjkN40ZwuMCEP+egTSY36aGGB/tZFMRHjmqIs3rGph
 DSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395555; x=1790000355;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AdnUbK+a7UvgU71442TP5UqJd09DlMAj1i0iC14aIfc=;
 b=PyicJCzJQ1g+O7poWenb34CEzBmUIxc0EZaysfELV10tKJKHjxeFO3BCweS2gKSgWe
 IMysDxj9LmJrIzHng5B3UF+SeA8OgrRR+AKr77lqXa8Z/FCwNqHGO634TjDApS8xSESI
 6Rs8ELBtrOO4S819Ngchi15rLqux0Do64MMXL1oPheSt5nWpUGn3KM+QhYJHrZPFifMW
 bMd8h8soswge8NEvNgETDAb00FPzSoJ9Bj830ILUsoWmOfrazgDabUf4p0omnVV4dVjN
 rjtzwAdnpNLLl1dzWmOz4a6a31IYRbjr+ibRPoavZLYsvpqwfccaQIFBePepO5Hx4TOV
 +F/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcApz+gjrKSZk5n27D7DLQvPWE0+Zmyy0SH78wR6TjR6mLx/8WFiix7sCFutx52tWPowqW+qkUfNjwEu+C@lists.sourceforge.net
X-Gm-Message-State: AFuF++n6bbwSt0YKDasGgriQ6O+349HOmKu/h3b8oWp12/+doTl+Chnd
 wEg/d7ljmTb9PcDGiWmCIGoV2bX9LNKQooRM5Mc1g/N6j/c4m3c6AZjdzqwBighxAOXIUI65nfQ
 vxFM/wUss42AVaFP4+mjHH7CKdYEcwmxPR+Z2SIApCHwekb4T4Yw+SRCqfxmSLmvk80hM
X-Gm-Gg: AYBFou0xKfwp7Ti5VxGfo0iFPVm5r1ewRnUexSaWewLfGYzLeUNi1DwqTl42hXISDmD
 GnHSxuN8LEQ+CtGIrTb2zYVjh/3LhoPUaaDupdGQdXePL1I8gpz3W5F17hrkVETbYzYYCydHE3B
 KUk2InvVA1TtEEPxc7j/hUO+RZhTpfEUimpBNh73cKaX/4bJ814Dw1Xs+l/SpAFZ5iaihAPGIFv
 Oijrj+u1B/r5zXoveu+OLeLzGYvziI8uYysNC/nb8Q/BOLkEo5MtlIvJ288KWpTLdz4RaNz3MP2
 2HP5TtXY1gcZOTSUqC7eyelHJSPNilhlA1QeKYwCo0oUALSU/yy3BRo0jJuw1kEjzKyGA+QA3u6
 30OLRZ0K26/N0a2ccKpn75YP47kU3p6HazMlbDQLsRs6Tyhz6CjKq4y8vagOuOdnU4JSyv+k1yn
 aLdTlrt5RJOpl6FPVh1SLoAid3q3ZPNMPiz2AvR9uIOzIdmSETWqik8dDCa7QCpAcX3L69fF488
 uYwFEXA7l5q27DlYvO7SZrX+IPy/3ZYT3mn//XC0R1c5k/B37Heqhs+k3Ne5r2SGhi8BiVKJvzb
 VpEsAuTHY4f+p0roRn6K33AodnO2qKRUVqFL+A457XDl/Ta7JeKwECEnDavaTk6KXpiS+mls
X-Received: by 2002:a05:6000:41de:b0:487:513:e55b with SMTP id
 ffacd0b85a97d-4870513e59amr681378f8f.27.1789395554943; 
 Mon, 14 Sep 2026 07:19:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb3602eesm26077431f8f.34.2026.09.14.07.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:19:14 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:19:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 0e4f26ec62f719eb61db55882e367f47586a8483
X-Gerrit-Comment-Date: Mon, 14 Sep 2026 14:19:13 +0000
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <56bdb443dd137a9acaf87046d105a0083448329a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67Wj-0001TT-O2
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 --server-probe to order client remotes by probe
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6609397289629528828=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6609397289629528828==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uIVkzUrIACE="; charset=UTF-8

--uIVkzUrIACE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1747?usp=3Demail )

Change subject: oob: Add --server-probe to or=
der client remotes by probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 22:

(2 comments)

File src/openvpn/oob_client=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/1a40e8dd_7904=
9879?usp=3Demail :
PS19, Line 213:         pc->sd[i] =3D create_socket_udp_=
configured((sa_family_t)families[i], o->sockflags, &sbs,
> Good catch, this=
 was a regression from sockets refactoring=2E [=E2=80=A6]
This now covers a=
 failed bind(), so a busy [::]:port no longer kills a client that would hav=
e connected over IPv4=2E Before this case was fatal=2E


http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1747/comment/b6a561ac_2885f83a?usp=3Demail :
PS19, =
Line 464:             && !oob_probe_same_bind(l->array[0], ce, &c->options)=
)
> Changed as you suggested=2E [=E2=80=A6]
Follow-up: half-fixed=2E We pic=
ked the right entry for binding and comparisons, but still wrapped the prob=
e with array[0] key even if we don't probe array[0] (like TCP or SOCKS case=
)=2E Now key comes from the same entry as everything else=2E



-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9c=
de3c06f2
Gerrit-Change-Number: 1747
Gerrit-PatchSet: 22
Gerrit-Owner: stipa=
 <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-Comment-Date: Mon, 14 Sep 2026 14:19:13 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ralf_lici <ralf@mandel=
bit=2Ecom>
Comment-In-Reply-To: stipa <lstipakov@gmail=2Ecom>

--uIVkzUrIACE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><p>2 c=
omments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/oob_client=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1747/comment/1a40e8dd_79049879?usp=3Demail">Patch Set #19, Line 213=
:</a> <code style=3D"font-family:monospace,monospace">        pc-&gt;sd[i] =
=3D create_socket_udp_configured((sa_family_t)families[i], o-&gt;sockflags,=
 &amp;sbs,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">Good catch, this was a regression from soc=
kets refactoring=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">This now covers a failed=
 bind(), so a busy [::]:port no longer kills a client that would have conne=
cted over IPv4=2E Before this case was fatal=2E</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/b6a561ac_2885f83a?usp=3D=
email">Patch Set #19, Line 464:</a> <code style=3D"font-family:monospace,mo=
nospace">            &amp;&amp; !oob_probe_same_bind(l-&gt;array[0], ce, &a=
mp;c-&gt;options))</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Changed as you suggested=2E [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Follow-up: half-fixed=2E We picked the right entry=
 for binding and comparisons, but still wrapped the probe with array[0] key=
 even if we don&#39;t probe array[0] (like TCP or SOCKS case)=2E Now key co=
mes from the same entry as everything else=2E</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=
=3Demail">change 1747</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1747?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1747 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 22 </div>
<div style=3D"display:none"> Gerrit-Owner=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 14 Sep 20=
26 14:19:13 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Y=
es </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div st=
yle=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;l=
stipakov@gmail=2Ecom&gt; </div>

</body></html>
--uIVkzUrIACE=--


--===============6609397289629528828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6609397289629528828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6609397289629528828==--

