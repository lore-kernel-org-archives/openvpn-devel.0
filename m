Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89577606A32A
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HhWnM43X;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jaWSMbiE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ffqK1weZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Rc0JIewe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Sems3k/A8GnEu13KlzVzLBm60uQTZECU7pDJcX+mwk8=; b=HhWnM43XMVp9poVxjP0xFiZUmz
	RcZiK1i6wWF2jV7FHFRA7AHOjMeq6qdgzUTsJN37/FtBFOb+C3K2A/4bdBx3h0EVTM59WZ9HIc6of
	oF7z+6UB61+mnMrwdLTACmf+vKCNZDQ45z7gZoabtevPP49suyIOa8O7EzsxGcWXs24I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYr3-0000000052G-0utc;
	Thu, 12 Nov 2026 17:44:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYr1-0000000051v-3jyU
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:44:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Szt84tQaTWKPyE+hfYXLquocrk32heQ/Y9yO2IeYYM=; b=jaWSMbiElQ+I2TxgyUTeCTG8Xq
 fm0CsIHm2bXB0D23L/7W7My+agAcmDVPs3thb8Jj9TBphQfAEQIaMIjKSvsjC0I4nFFEoFf/Vw1ET
 7HOj+vB9+3kDQO8bGYVpb/pY1+tzy39LMl77+cYIhWhO6ZysMLiKFlhnxB310Btwqr58=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Szt84tQaTWKPyE+hfYXLquocrk32heQ/Y9yO2IeYYM=; b=ffqK1weZ2nuCTPP1dRRZg2Kq1G
 Iosq5XzqXLYCjV2/jp7M7kGWD2FqyrOYkyBCjZw2QZV86xoVrdJtAUNtqJQ9FBXKtfmmqF4glFhFG
 CBZxEvS5uz8nwOCiPDr7FlQLXSD1zVsAw/fEXiq7DqxV7M60oyLwdOFWxxrW3kswj8qk=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYr0-000000003ta-17qp for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:44:55 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-49a92144733so17280f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794505488; x=1795110288; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8Szt84tQaTWKPyE+hfYXLquocrk32heQ/Y9yO2IeYYM=;
 b=Rc0JIewehCldQIzl8WMVo1v+1xGGs44wPoVMhq7AqRPiKWb5f3yRqCW+En3LHxPv3y
 t4AuhfD+y1b0OEVZQixHVqIC5m/h5pmr6Jgx8g5iJM5hlOJDo1rBqnRkUWpILFn1zd/z
 GM/GMqM2ulsNC+JpwM/OUO+kZLw0pQXhP5T0YHM1ggF1w1dZQ8H7hOvzxJLY8HOvWCDm
 1KnvAJMydrbmVo05ehpKVesKYur0SCAyjadHhBwD5bwyS6mNjCh4FwVQQxyF+7EezOBl
 3QMLxErgTquWerG4VSULKjNRwzaAuvQMXMN2ubrnplVDo7JwwdzTxZdgSDQfjgEX54+Y
 mRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505488; x=1795110288;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8Szt84tQaTWKPyE+hfYXLquocrk32heQ/Y9yO2IeYYM=;
 b=lApPosELKkj+YgHa6XTlYk36lKZPP3SdO7vVml34rg3MUU182DhE2mMQqquZoR3QFM
 ZBXyp79q29UyzxKw51a55dhnzqpHiX+qz1QZTyWcuwTl6YRlWmWOy/gbXU0F8tHuTnwN
 Idmb0j0zRzXAN9p9nIzbDJEuZw0DLr/+ReeWtSMu5CuLU2l4m4g14OA//sQf7tpTMacU
 /3NSO1MHQG1LPt1Sa6inad5K9mLLWu+k2v1prRfknASeK68OooZr6W/nNrCkZ8V80KdU
 RoLoNN9PGUZuUFKi1z3iPXs4PMcpZrxmLkumx/GF4R3d6FJVwP1pWR0BHn2Il672xFTg
 Ikpg==
X-Forwarded-Encrypted: i=1;
 AL+hErH0S0XxQmhVUEXU73y+FMdpMGwTTn5TpNdaHo56a/yX6wWU8K8J43hZ0j19sekX21LLbJlEP7stUwfE3uh+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8MePxqVkqGInJzLhNjbBNGHSQEkO61KdF8MkurdULHaPSgqgS7
 mbWNYShU5z5DJRuMNaytGN7Zb1ypC1qlz9OckzTIpGSWv1NTb/4MUqIzmSmkHNSSfmxHc/+zNH3
 lo5Fu6sxMF7mZMeDQDpKUBMdo/Ex37U4d5nDg+L0Is0AKNBDCMQplXnEh8BN5EAzArRrvR8Q9jg
 0yBFEwhg==
X-Gm-Gg: AYBFou3CB+Zh4nV4mN1biMLpBbOvUmkKN/xdJCeAd6DkjJPdwbrm55bzYmYoyv8z90e
 6YwpD3QO9pZ00bvNN9sdY1qZxKG6QocJocCAiFWk9JXKjFSpLJCD7Anc8s0Rrma/j1oiWLAEgCf
 GiiOkulpnD9M033ykz1MwuNdwH6C4Gm6+HuWTq5lB5gxMye6ukONt+Ben5QtjkgaS+5MpKYzEi/
 iqX6qAY6K0H21ZAcRGoCpVtlwiJpwpNbaGVKA+4gt2kD2bGDLhFhuw36xsOIO31U+JQwCs4dToN
 W8UU87ZWI34KMNUrdSj0LjUuqzZzoqkeqpgu9EB/amdl+sGC52wpcUqCgnVaI+uqSdgC11VknaE
 OTYosMcacWz88J/YLm/egG7iWGNAE1O+duFx4OizkD/h3FYeIIMexYU/Ls9UtOd78GXQz3suLAt
 OAlGOzcMTy5xaMhWbrgsH5j1I4PWGPSve67UZeEN4o712bAB+dnoKYoFjNWoRkhZNq89cOaNgnd
 tseskz+WpMxVV6SbbHoijldNCfek6nTHaXBSgG9vwi83u5Yh7XIqZYR4C5scn8Sd5wwJjJIH7si
 asfzHSv0GClnGMuYGoJAyjf8J8lOBXnX0wk1OCLB/nr3GoXvofRimlXMnVhNOMCt/PO4QHKYRjQ
 74fJftJC3aRyaRdduEdwY68oRMMDHQG7lQvvfqdD3GT2XKkeTdfBa1GNpgjR5h6LzSGenc8sRDI
 hgE2U4/+jl+tCMucObqxndoFlj6UYGHCznsJF0
X-Received: by 2002:a5d:5e03:0:b0:48d:e6f6:21cf with SMTP id
 ffacd0b85a97d-49c71e3d70bmr203285f8f.31.1794505487482; 
 Thu, 12 Nov 2026 09:44:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d22394esm547906f8f.3.2026.11.12.09.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:44:47 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:44:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: b81201a9c5f58370555f91a78d696969f8f21965
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 17:44:45 +0000
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <efa5e6d44f9c125669b48dd69bccb431bb644bf2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xRYr0-000000003ta-17qp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 IPv6 name servers in NRPT exclude rules
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4167026581018498982=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4167026581018498982==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2+tCXjTy47A="; charset=UTF-8

--2+tCXjTy47A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Heik=
o Hund=2E

R=C4=83zvan Cojocaru has posted comments on this change by R=C4=
=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=
=3Demail )

Change subject: openvpnserv: keep IPv6 name servers in NRPT exc=
lude rules
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 4:

(1 comment)

File src/openvpnserv/interactive=2Ec:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2162/comment/56c54794_1c8ea7f1?usp=3Demai=
l :
PS3, Line 2589:                 v6_addrs[-1] =3D ',';
> While technical=
ly correct, I think `data[i]=2E [=E2=80=A6]
Done



-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
G=
errit-Change-Number: 2162
Gerrit-PatchSet: 4
Gerrit-Owner: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@ma=
ndelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quart=
ulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eei=
gentlich=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Comment-Date: Thu, 12 Nov 2026 17:44:45 +0000
Gerrit-HasComments: Y=
es
Gerrit-Has-Labels: No
Comment-In-Reply-To: Heiko Hund <heiko@ist=2Eeigen=
tlich=2Enet>

--2+tCXjTy47A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Heiko Hund=2E </p>
<=
p>R=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Co=
jocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?=
usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpns=
erv/interactive=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162/comment/56c54794_1c=
8ea7f1?usp=3Demail">Patch Set #3, Line 2589:</a> <code style=3D"font-family=
:monospace,monospace">                v6_addrs[-1] =3D &#39;,&#39;;</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">While technically correct, I think `data[i]=2E [=E2=80=A6]</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail">change 2162</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic602b=
125d857f1beed4af8661f522d339bc9e972 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2162 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Heiko Hund &lt;he=
iko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@m=
andelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: He=
iko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Nov 2026 17:=
44:45 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D=
"display:none"> Comment-In-Reply-To: Heiko Hund &lt;heiko@ist=2Eeigentlich=
=2Enet&gt; </div>

</body></html>
--2+tCXjTy47A=--


--===============4167026581018498982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4167026581018498982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4167026581018498982==--

