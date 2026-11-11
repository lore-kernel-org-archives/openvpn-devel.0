Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF166606A327
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gf8Qw6vc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hvmGxE7M;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iN4o1qNS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OUWeqTrz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ldPZM2I1FBlQwQhVzL4JArHQGozItFNb2+ZhSuix9OU=; b=gf8Qw6vcxRntIQSTUCu6rVzaVm
	lXRWMIu9cO0qy4Zre8JtpivpR2KA/2XwoZA9DzvtpRuEpbsWjL10nPxt45Qpje+VL1MM1ET7r6q2+
	Ng4yhILHmLJzb1Drz+8LLjETk73zdrPQ6Raar3tlE5QJ8MyKU4WTK0V3TnViNrPUCa9w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4Vi-000000003El-44Jz;
	Wed, 11 Nov 2026 09:20:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR4VJ-000000003DC-05Cf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:20:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OGFUJ4HKdRxcAJL2l8S3rPsTHFSsQQIaJsIZoxkp+Sk=; b=hvmGxE7M5c4Mh7XCkS2zUNbjKI
 /AX+0rQHwz8Nk0R+jfuZHnkQNjb9+EGkVsB4CqvUwuAnO8oVa4+Zl8Bz+H6V3/Z0L+xn124Rrv7iZ
 kxh03RF7Sdngzm41NOpWuAMHu/a5Qh6B7Kp5t2/q2IhqucUF04BlyP84YenSYRc2eQMA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OGFUJ4HKdRxcAJL2l8S3rPsTHFSsQQIaJsIZoxkp+Sk=; b=iN4o1qNS5ocaWlsCs4fm/84342
 /PoVYHttwTKNGsEiExpxvj7n8OlG7cbA0hRZzt7BkqCYsIxgdcS99ZL4Rsd55bIJyv32HVB3x75M+
 UL8XyIC/eoOaiqhhkuoWWwbHE9HtgyyoJVzZm+DgQswaU6kn0BFbPzJlR7G3TUujQPO8=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR4VH-0000000006j-1mgV for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:20:28 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so24177275e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794388821; x=1794993621; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OGFUJ4HKdRxcAJL2l8S3rPsTHFSsQQIaJsIZoxkp+Sk=;
 b=OUWeqTrziLs+f70n3fuwUMJtiWr1WQElxBlen/wASpmDdSpJd1slJYMGBL09Epg1FN
 nsSNfj6LQ0olp0oVZ5Eh6spRur+BgHpE5OvqXOkLrNzOtZL4qFtZLSRxOpxhM9CKZQSD
 yQHgCJAhGa4yK1VKhgy64h8XfQP9IukMaoLqNecP94XTJ+2JbrY1mPriBcHHn0MzxJTg
 nOtNmGDteJz+ThLoFOkA/UT/8I79flITqJVCvJm0vVLDd8CFabMsCq1JRly9HSpkInH6
 EIiCl583gK0hS+8udJl8Y1Abq/9rODjpevjVBIHRUo8/DLe13F+51ocvfrvD1Nyi4DnE
 s/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388821; x=1794993621;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OGFUJ4HKdRxcAJL2l8S3rPsTHFSsQQIaJsIZoxkp+Sk=;
 b=MukcvMJZEqY8PUkts6fnrmHTZqEgR/ks9/8GbaCDMdmYdy8z8BDT5N3gHly3ZHRomD
 hlUJ1EWuo/K4QyTqIkQuG4vXSG6GtMkHcHETisAymFFGeEYWYmvfEb0Yh0XhRfxvbcj6
 bdtVS4dGWtSLIfqenkiZM/PpXPi7s9ZNzKyl7JZrFWVqb2DSKfG9UArmWYoGJQqbG8wH
 mVgECb7HvBq5XoDEQR9HqaL0Ih3lMbGahGE6cNqEKQyfMQ2+TaLlLCkJJCz4LdeL4Bnt
 6Ma5GrcvGEWdApPOy3b6j1gH7GihMdyqx70hIw89eDeoYZqG0fHY669UgfZ22ndpsPDQ
 hxeQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGMXBM0C1XvqjOdT0V0SN1N8bH5zKNWsFoQv1Kmtr9kLP8SUltdMVgwNGwLz8KaXg4Jx9qOMqu7OWySzu80@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/UdvCn8agRB3QMh3gJ236zqPTlQ0v7xNLSrKgSmhbSLxmPT1zQ
 W7PPnjSr5CUIJ6nHZrvFTj7TQ94jADoU6v0d6HSUddhcURN4StKuPatJ+Brv62gCBxqxweleLfW
 SEY7enwSNNriKKLLq9EisOW3GBD4fvJoz4vUuyVkq1Sj80TZAIWKP2VywnjeYHcMslofkcDvmta
 01B/XBmg==
X-Gm-Gg: AYBFou3ffUPamucT1mgXcIrlFrr8YfQGGGCJ2EN0dYTpmRE4/igsSsf0UUi6eJTXHqb
 541FK1EFx24niET94QcyIqTB8OtidYhOuSOdcO8XMz4plGqKKNrCHA6cnhJtbIqxYCWGOAw5u/u
 Dg0d4MbvP6vHqhLn2Ie0aqetFVFXpMZ1ny1bbxAhDOyscAR5c2fP8UPHMVuTIhIq9Sn9UKUFOSw
 CuPk9xJ88I2huoDo23jDIT1cRloH5J/j1gJY3D0wbLgVWjWZzCmOHbR5xKlf2P3UIcl13etBDYR
 Cl3k+SsjLzGQYrHaldVJyzuXyGKK9o+M/auv2ZlAM4qFRxZNjDnkK8fSpXjaxN8wiQvgfvHIhPi
 g6Kzv3777qF/GnFlsYMJXs6PS7dhR3YA0vk+4/eSqp1DWTTjCgkOnKUr/Tw0XszkDHnyMv01mMW
 Yf5jSEa5BW0cJnAJycHOsgKSstdg1y/0DMvXrGyLFBMX8CPN25EgtB2sn4mTuaSm/9g2dRISk7v
 MmcqGgzwr61UXJb1Id36exoqPBCJFkfccW2yfal1qJGObZQkUq2CZzQF/ixLDx9i0wmppam4j+1
 NtUWUbYnVtxGYe80I7ZY3hY6qmyYl4qjXMJJxFgy5NY5WLjolpqTl7vsLWLY4Nj+GaDQVsanqvQ
 4rRs+HjhyaXCWrxWNaCdxqXtzUZGIcVSkBKVOcezBMD2cxPbxh7QTKfPhIivdrRfgFv7TAxWMg5
 HKK1GPuqmoNzrG6ig=
X-Received: by 2002:a05:600c:6819:b0:4a2:167a:c946 with SMTP id
 5b1f17b1804b1-4ba0935f880mr29597945e9.13.1794388820729; 
 Wed, 11 Nov 2026 01:20:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363dffa1sm9594603f8f.39.2026.11.11.01.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:20:20 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:20:18 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: 2e800a1dd0418ad2290286c2154a9466036f6233
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 09:20:18 +0000
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <33145855c1330d21a3a180f3907997b72b4ec778-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR4VH-0000000006j-1mgV
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7723140222194760111=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7723140222194760111==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NgHz1/IyN/c="; charset=UTF-8

--NgHz1/IyN/c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail )

Cha=
nge subject: openvpnserv: keep IPv6 name servers in NRPT exclude rules
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(=
1 comment)

Patchset:

PS2: 
> Sorry, I don't understand=2E [=E2=80=A6]
sor=
ry - copy/paste'd the wrong line=2E the issue was in the line below=2E=2E
"=
read the IPv6 name servers in after the IPv4 list," << here "in" should be =
removed, no?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2162?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic60=
2b125d857f1beed4af8661f522d339bc9e972
Gerrit-Change-Number: 2162
Gerrit-Pat=
chSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-=
Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Comment-Date: Wed, 11 Nov 2026 09:20:18 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Antonio Quartulli <antonio@=
mandelbit=2Ecom>
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>

--NgHz1/IyN/c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2162?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">Sorry, I don&#39;t understand=2E [=E2=80=A6]</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">sorry =
- copy/paste&#39;d the wrong line=2E the issue was in the line below=2E=2E<=
br>&quot;read the IPv6 name servers in after the IPv4 list,&quot; &lt;&lt; =
here &quot;in&quot; should be removed, no?</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3De=
mail">change 2162</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2162?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2162 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 09:20:18 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In=
-Reply-To: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>

</body></html>
--NgHz1/IyN/c=--


--===============7723140222194760111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7723140222194760111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7723140222194760111==--

