Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140DB606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MLHi70A1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TLMvQeGr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U4xOhr2u;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FWTF22hQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5+er9Zu+UgTzpdry/8RIBtamimYyx2tkAMY9mqKmerE=; b=MLHi70A1IfkgQTV9RrOcduUzke
	q6ir/RfAzLAk6npr/QPbO2knDkstLvwQ2XaYhROks8vQs2vMwi+QYiTbCK5Lnsqf5StezAs7S+3bF
	q5haQN09w/2HIuylSy8xhhckoQQNLFrnp4sSIlKW/qwIV4E/i2Vbjp/1opPzopob3rBM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQkE1-000000001U2-3KI0;
	Tue, 10 Nov 2026 11:41:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQkE1-000000001Tw-0l0x
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NivjZ1O7tYIylqZUWzrsQ0twvGa39SWB0YYcSyNJ3HI=; b=TLMvQeGrtDyMycmLskN5noonVX
 aUEwq9hb0YymlHAQEJroaMPghQxPkGOF5LVD9OXjgE7A5nTDsPukCnDmgDb1H6KtkxCluTVkdik3K
 0P0aLywZsUNYr/JC3JWuABpu3C8DWC12hkFCZNRU1iGmSlgJl4rEPs0Uq6/54dTSGWgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NivjZ1O7tYIylqZUWzrsQ0twvGa39SWB0YYcSyNJ3HI=; b=U4xOhr2uBAotH8SKFTOcEtXWaL
 nN4YMYNEXLvxytxyYeJaBuWJX3l62TJnQn6wftUoubyDSSIxzxt7kfn8FH7tcdrPDrK7NHlDWGK97
 +NnvqQOrkUOY1MK9j5kWhKamiY8hbqNQJQkPS+EfrqlwCGh0dnsPYWe0Qng5SA6R6YHk=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQkE0-000000004Ua-0nqM for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:41:17 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so7805545e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 03:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794310869; x=1794915669; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NivjZ1O7tYIylqZUWzrsQ0twvGa39SWB0YYcSyNJ3HI=;
 b=FWTF22hQHIfQaj4cTPz9SCSsmSTIE2PqjQseRWv9ajj6uQcJQjqevc4gzJiuC7EQ/a
 ukAV7108GRTO1fKkeNrDv3MUeTZdojUIDsi9HAxxKYjJ+OWf0npxt3vXwnuRvxvkPBr9
 /m0mhR8IXh6hfSL7gVXFAOAl3bCOCMbASb33DP74FjOoCMVhmqpJpBjk6yMoyuCJ8EZb
 D6vgp7LynIcVxukKxKCGXlgX+TwFa0K5eLPIzW3/33UVpOErvf4qx5oGxTz3hx3CCt2Z
 jyxagQARdMEc2geVu9Wsd1QsKNVWywtgaBJ9aPpALTLntwnhzcdHI77vbfGjmzGgfc5I
 1d2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794310869; x=1794915669;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NivjZ1O7tYIylqZUWzrsQ0twvGa39SWB0YYcSyNJ3HI=;
 b=LHee/b0NX3ZQTyxA9bucbvLaK1jfrgfCzjJPsI5WCa8/ms6GF4I+/jCDzXxAQpot26
 Bs5ZHcw0pTASxwFc65TyK2pnQABq4TgYxxkjANzKxQ0AHWbqmJCEO4TfmNRvNX+UfD1l
 MNnmOzSIDYoGMD9hNuWllGtk4jxyERND4lNyk87uzVlRiobISgStxjS/EtzW3OuQZKTQ
 oe7AeFpUUGjTfBlDR2wCTyoLvGcBmes+HK7LQxgVYiR0Lgx2gnSPFTHv8VRJqxZ/GC8S
 Nty9cojbpnmiV38cyguJDJzMnj8B+MQbt84R0OJEVmbe521sSVmjt7EhCgL1a9538jrc
 ZOaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGzVjTLsGJTPieVxNHA47bXuGImNez6XYBbpMzhs2t1rEYCgDzxtJ+0uJE3mOR0y8eg/szNrics1ILG4zZ/@lists.sourceforge.net
X-Gm-Message-State: APuU4Z96T0pUlqbaStAcy56W+2f7QuGDLZ0G5Vk6N/8dMez2XbTgBvqy
 InwJ46JZvqfwN/wt2nyGII8GdfgZ/8zLVvko4bYhvGe7ke+wEDrdnpJm8N4/ZzZN20ST/e7QStR
 k/o0iwGebxJK+hmwMahvHCv0ocJJiMbvF/+Be9e04vHhUl+Fb+5nKv+/syJm/hrjoo2GM1z/jQe
 b7Qz4zIQ==
X-Gm-Gg: AYBFou1X5OwF7cePxPrzAhpQ7lW+oGih7EpDlN0wJZZ3Uz/xp9aC2PV9LakO4Krxd4E
 gU4sWshdDoBMXux6NTfGAjdfnOkRrJPP5L0dhYbmgHX5DFIpcVSP+WVNeFCQ8vTDgJyZ2q2K3Hw
 5xqcduEhH9Zwt6akdLsUNJo8QTgbMdZCTMu7uqjNj3pgOC6h99+BbYo4wQwWR51t/2gAmbtbTxy
 O/tB+759mnT0BtQqj01w74JwwO4CaJa/UoLnBNkSZQ2hvHJE+c9DX9lsgocszf6/QBcsy28Irlz
 9NbgST0R84qKbTYUA5INgHcLrKTKNobHdyY/sho4POtouf4EP3cV/PW9S91zpv4JqAmvsRNtQ9m
 jq0FP0ZrX9o8PwL0MzgJsS7T2p9BKXd5qz9ntU9ENz0z/lahyAneVJCtrnkgbkzy49wEUhwD6Ix
 WgIx3eZDsF5A9K6RrqoRnCC1DOptxJXrYXYWU4cymlrJvz/O+I/ZmIe32TiVyC5p9wf/vON/3Yc
 660T3cpuD3kIpPjYnzpbtcxzR98Ha++ge0T8Nj776mY8uExyl5oDSWS/fT6AnYv6LHZARvHOzRm
 EV8u34TLdXMoMMUIgK7KV5XKF3+Nq1fWeBj5DlS0S+yCn8Oeg6LIMohkSP4RwqRsbdqWIRIgexQ
 0e4ISZ9ajZ0TGOMm1RIpAKSSxsfP8IVONWQdN8Ut3EO4vfzjANeTR4BVajO8bhdugJAsMkJApL9
 CNsFbkPJeWIBO/0dg=
X-Received: by 2002:a05:600c:4f47:b0:4a1:d8fc:8165 with SMTP id
 5b1f17b1804b1-4ba0234bc10mr39821245e9.20.1794310869376; 
 Tue, 10 Nov 2026 03:41:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe2c5asm95522275e9.5.2026.11.10.03.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:41:08 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 11:41:06 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
X-Gerrit-Change-Number: 2157
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2157?usp=email>
X-Gerrit-Commit: f339a5edaaffaed82865b0ac2029c8e34a8655a6
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 11:41:06 +0000
In-Reply-To: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
References: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkwMmY4ZGYwMWY4ZjMzY2I5Y2QwNGNkODQ0ZDFmMTg5MzY4OGY1MWU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8e9613afdc2023ce3249baae79682e2388208a16-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQkE0-000000004Ua-0nqM
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Various trivial
 -Wsign-conversion fixes
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1940568512922877414=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1940568512922877414==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uF+Bb7L+o98="; charset=UTF-8

--uF+Bb7L+o98=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail )

Change=
 subject: Various trivial -Wsign-conversion fixes
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(2 comme=
nts)

File src/openvpn/crypto=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2157/comment/febc068d_0832a30c?usp=3Demail :
PS2, Line 858:            =
+ max_uint(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
`packet_id_size=
(true)` returns `int`, so the sum still converts `int` to `unsigned int`=2E=



https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157/comment/f4abf554_392fb32=
7?usp=3Demail :
PS2, Line 1553:         fmt =3D format_hex_ex((const uint8_=
t *)&key, sizeof(key), 0, bytes_per_line, "\n", &gc);
`crypto=2Ec:1553:68: =
error: conversion from 'size_t' to 'unsigned int' may change value [-Werror=
=3Dconversion]`

`const unsigned int bytes_per_line =3D 16;` fixes it=2E


=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02f8df01f8f33cb9cd=
04cd844d1f1893688f51e8
Gerrit-Change-Number: 2157
Gerrit-PatchSet: 2
Gerrit=
-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Commen=
t-Date: Tue, 10 Nov 2026 11:41:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: Yes

--uF+Bb7L+o98=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail=
">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2157/comment/febc068d_0832a30c?usp=3Demail"=
>Patch Set #2, Line 858:</a> <code style=3D"font-family:monospace,monospace=
">           + max_uint(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">`packet_id_size(true)` returns `int`, so the sum still converts `i=
nt` to `unsigned int`=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2157/comment/f4abf554_392fb327?usp=3Demail">Patch Set #2, L=
ine 1553:</a> <code style=3D"font-family:monospace,monospace">        fmt =
=3D format_hex_ex((const uint8_t *)&amp;key, sizeof(key), 0, bytes_per_line=
, &quot;\n&quot;, &amp;gc);</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">`crypto=2Ec:1553:68: error: conversi=
on from &#39;size_t&#39; to &#39;unsigned int&#39; may change value [-Werro=
r=3Dconversion]`</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">`const unsigned int bytes_per_line =3D 16;` fixes it=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2157?usp=3Demail">change 2157</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I02f8df01f8f33cb9cd04c=
d844d1f1893688f51e8 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2157 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 No=
v 2026 11:41:06 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComment=
s: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

<=
/body></html>
--uF+Bb7L+o98=--


--===============1940568512922877414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1940568512922877414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1940568512922877414==--

