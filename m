Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A699606A32F
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KdC9dOmg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QBkYsZTV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SG5EVPrE;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EN5Qd+A+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jJdNw9Gmhn2QVac5s/Y3kDEqg0IIN3lBnP1hjVUzyE4=; b=KdC9dOmgp5Yyl6VyNdYxo0DlPY
	LljebHZ/v+AY/kNstJJ6mRiBFIH3kNB7OkPzk+qs8RkiEnVUnXWHtOQ+CzK2TbppflV39QOht4DN4
	atCWxBdIAoDpD4i/WN/itCEk11uuXhaHwZlfXmWgtPlgwsY9H+LNGRuTzQ6ysBpHpqpI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOFPJ-000000004Bs-0Osb;
	Tue, 03 Nov 2026 14:22:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOFPG-000000004BY-0Cw5
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 14:22:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mRnffclicN2b3sisNQ2rtbOkzcctu0yopD9zVseLPPk=; b=QBkYsZTV6ojyRvYsQfKAsgNee9
 YY4nkOICWDb18yp3NOSs9/evFtenrz57YVeLsXFuZvVhG8YcKmgJBU+S21jCB6sk9Lj/SZNhCCuNx
 ekacvmgZUpvEjn9Ce0Tbh8574k8NqOKrBmVL6ZRm1bUfsNMfknluV7UIXYtFjNcTMLMU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mRnffclicN2b3sisNQ2rtbOkzcctu0yopD9zVseLPPk=; b=SG5EVPrEdGvDXojSQhv0/4u1BC
 yxta04/GXhHZiN8S/8jLvPv610SsD4xziFQeeH+aofu/3C27aGTAYw3oRg7S05ipFIfosw234Kiar
 YK8YRVhdc7X4w3dbT2n1lhx1VUikqtPAfsJZeP5ECoDOXT+xt8qhNK+Fbp2Nk1AYsaXM=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOFOv-000000006S5-2hqS for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 14:22:14 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so33991335e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 06:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793715727; x=1794320527; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mRnffclicN2b3sisNQ2rtbOkzcctu0yopD9zVseLPPk=;
 b=EN5Qd+A+nscZXSwwagG2B79I6CyLdhKcpsx2QU1DLCqZduZK3q2eMtnzuQ5kPjH70j
 RBbT6V42lN6todLduUkbNxZqN06QN6g6HRB2vAPxKMBHk+8qw9zWU0pmlcmGUEsVZr1P
 867AKtN8XnOjehLFedH6foXpQ3vgLQlVv60kl7H8DKbQA+EQ6mJauUQBuuhLDmXjrV7K
 Xu3NyZ9a9EBKjAhlUuWGTxJb8zXcGMQN8q1jPDJWZOQasD8UHVqMTLPdKHww9RLnOsyd
 6ZMlvDA2WP8Bv91uK4wp9OcL0bvaLt2DFdoxS0aYpu2c12L4nQsKykh5bUvs64DRMgUF
 da5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793715727; x=1794320527;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mRnffclicN2b3sisNQ2rtbOkzcctu0yopD9zVseLPPk=;
 b=zxIG1KSxIab6RqrGuwAkJ14cWjhjtAqWYGQXvRum4BhlTYw/p5dtTDv7pjBSjJESY5
 C0VtuqCYoHgqF5Ugr5/Ui2OcGJG9FZbnN6YHYORbZlC4uphNBHDYMoA/6jxmAUCJCkoN
 uCCkl42VmKGom4b/uV/MWOY5J5okKWmWgUdTlYIJKeas4kOOOaJkp/7OmdNvnd/f7nBC
 WIVnvhi8PA7K1AcoxwSYVGcVeXgWdunvj7Whl3PR6kl2s5M/20AGWEeS7ozitvGrRB2X
 ZGcSqKzFxV8YHhevAkoZXuVvDbCa01carT2jRngIlX0x5V16mUHpQGqhPaU6o3r/wpgo
 eqZg==
X-Gm-Message-State: APuU4Z+BKlkul1Gjhp8r+aJfp177VylnBcA7FDnfUkQKeo5FOBI4TgaY
 nbNsSuWS7hyI15EebIQdlXgQ4tMJBiicRVSgyIr0Cn2t7zH2FjKS3PER6NJtpgyrvlH2IanwYjn
 0ET6bZQ3dr2WDZ80GyCgLwLDtBLIB9YYpNX8OhAc7hT99y8YG/2KuhtViQt+o0oGxyNh9NeGGwo
 j6j/Tmug==
X-Gm-Gg: AYBFou1pL5lY1CAXYpKULr6Lw1Bh0RyhtJ89wJvJTArjPuzIlgEr1mt7NNDBdDHGX5w
 0i0i42b7o6KEX8+gla9o0Krjyp6XcxvJpOaAkeLQr7XoMj7J3uEMEMHmv212Pvo7ibNfuKx2eRP
 9gUcJq9ZVZHAcQu0Um4BXHbyb2vibK7E7/Vujeguh3rEMo4E2z0soTXWBc1S0tgFaKEP6oB5h4b
 iEbt7fZC19K4XoPH5hQRCHJ4+Ip+4+1hGzPtZQxbW7p65/fjBhHLLYUM1XvnLiF8JWrtZHTh4IS
 jASSqQtHvU/NOLQeymLIMSHQMKsCwBKQnA+8/XHfwOwdQluyDxtHGJvuEJ2ZWassRlgWDALK6JT
 8/o7DGyPqM+IabUuSCyatdGH9MUiTrJRk32M3/OpdVf4mT/6e7Z3MZ21HGzvuTviRsw0N1qlrCe
 Us4PaaKAedFkrhc6RuH0rdd3WSVp1pXU4odpYCPxpMtNsEWG0TYKxxe682vNgYAJP+xtB/9kqDK
 NspqjjBow9yYw+iGcDxp8NV19tzW8rKE48B7nD851XklALt9f86oLkstZY/Xbyl/z8yF6M6kUaT
 sZGNqq+ix7mOdZOu8L6FDhlZ0exEmo1IZ3dd3rQqtDxFPSCOjub5BO2B1SUWP3Z6W7tvr4kozZl
 RTknTSUAy8MM+Vn7vCReC/DFFD0VQl0kVHx8XwgQlOwN3NcHpoUJKEQWHIzJNcYlkBRQJe4lf7R
 RvBVbxmjXLq3WmPWnqyCewS9vc9M5BQcoxfSo=
X-Received: by 2002:a05:600c:8b55:b0:4a1:ddca:8b66 with SMTP id
 5b1f17b1804b1-4ac19234a06mr287632325e9.31.1793715726902; 
 Tue, 03 Nov 2026 06:22:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad35fdsm236324735e9.2.2026.11.03.06.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:22:06 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 14:22:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: 62f2e92139f2da7f4d5d29f94c3a4d995ff56e41
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 14:22:04 +0000
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <51383498866eab8d0314569d0d5373c1b57fcb42-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOFOv-000000006S5-2hqS
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Add python scripts
 that demonstrate using the mangement interface
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2331683511237267331=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2331683511237267331==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J/Qs0BChCPI="; charset=UTF-8

--J/Qs0BChCPI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061=2E

Arn=
e Schwabe has posted comments on this change by Arne Schwabe=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail )

Change subject: Add p=
ython scripts that demonstrate using the mangement interface
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6:

(3 comment=
s)

File sample/management/omi_tools=2Epy:

https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1859/comment/d8ad69da_eb24024b?usp=3Demail :
PS5, Line 72:     =
transport, protocol, finish_future =3D await start_management_protocol()
> =
Missing arguments?
Removed that function=2E It is not used and not helpful=
=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/bb214e29_ca32=
53e4?usp=3Demail :
PS5, Line 87: fork
> asyncio=2E [=E2=80=A6]
Done


https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/744acf57_6c012592?usp=3D=
email :
PS5, Line 99:         asyncio=2Erun(main_func(connect_parameters))
=
> main() does not have any arguments
Done



-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
Gerrit=
-Change-Number: 1859
Gerrit-PatchSet: 6
Gerrit-Owner: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Nam=
e of user not set #1000061
Gerrit-Comment-Date: Tue, 03 Nov 2026 14:22:04 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Nam=
e of user not set #1000061

--J/Qs0BChCPI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061=2E </p>
<p>Arne Schwabe=
 has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a></=
p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/omi_tools=2Epy:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1859/comment/d8ad69da_eb24024b?usp=3Demail">Patch =
Set #5, Line 72:</a> <code style=3D"font-family:monospace,monospace">    tr=
ansport, protocol, finish_future =3D await start_management_protocol()</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">Missing arguments?</blockquote></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Removed that function=
=2E It is not used and not helpful=2E</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/bb214e29_ca3253e4?usp=3Demail">Pa=
tch Set #5, Line 87:</a> <code style=3D"font-family:monospace,monospace">fo=
rk</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">asyncio=2E [=E2=80=A6]</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/7=
44acf57_6c012592?usp=3Demail">Patch Set #5, Line 99:</a> <code style=3D"fon=
t-family:monospace,monospace">        asyncio=2Erun(main_func(connect_param=
eters))</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">main() does not have any arguments</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">change 1859</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib09bafabf612e950=
1ea757647c86a450c73228a5 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1859 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Name of user=
 not set #1000061 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Name of user not set #1000061 </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 14:22:04 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:non=
e"> Comment-In-Reply-To: Name of user not set #1000061 </div>

</body></htm=
l>
--J/Qs0BChCPI=--


--===============2331683511237267331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2331683511237267331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2331683511237267331==--

