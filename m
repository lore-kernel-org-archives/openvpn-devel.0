Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F6606D814
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OqwKVXOp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B7tENRaV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aVpAfZ4O;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JBirnOZz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mk0EmV7p4b1TIgJwxiU4OSmRqUiRu7as2APBqFbK3dI=; b=OqwKVXOpCttI2bf9OuNlcgVZqF
	NWmIMFeZBp/oH6XY1VF7HhrQ/xe9K6JmO9Qx/AzVnEun4xg/0/zzyLgabOdmOEX0UjyEwytcDThP9
	e5E7w1bpz3SUEHxFlirSFIdlbShF+RsT4KS9L72q7y+TaBo/R1EMldCprqmrPfVDKSB4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOd7S-000000007ki-42H0;
	Wed, 04 Nov 2026 15:41:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOd7R-000000007kU-1keG
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:41:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XpbdSVCLFgrZ1GH7SSaaac8UpmBwG3ViIckAFeP6Zaw=; b=B7tENRaV6zxwbsiFF7r+ttkOQb
 69a8O9wR51mARLHU+ft0l3t4opTwfGp7E3c7er7I9cMaETrP5CRh5RI2P2Co1B2aKgocglvFUGYT/
 aeqptdKCYzK85oNBdoHxlGcSqm7FGd2CN459XCBFh7IuNIpcYI24+bftq+u1EaPLb9kQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XpbdSVCLFgrZ1GH7SSaaac8UpmBwG3ViIckAFeP6Zaw=; b=aVpAfZ4OZWsSSENrrD82duIbyu
 jjY/XNZSW75NNATG0jV+kMHwtkwc2/ktqvvLD1AdBe1AudJyy169A+TFcRZyP0w4dtF/Md4mtlf93
 TEwUj/uLZQg3nxlmhIM+tXxjVMD96sJqN/hT7H2qLhSSVdeaR8qX7UqfAj/B2lLWUOJo=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOd7P-000000004vb-3x53 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:41:45 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so830206f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 07:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793806897; x=1794411697; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XpbdSVCLFgrZ1GH7SSaaac8UpmBwG3ViIckAFeP6Zaw=;
 b=JBirnOZzTL7yP0pSRvqJ/aevvFmmwZYOixOVOySlJpl08q+371umqptzTtypVkJVwo
 bSBeevti/p9WBGf2XLsV+1VWCTaKDV+bi6Rw3M4c9CwvRxpnZEM4ur2BnkhSJ/6UDhQp
 G8G485IeEvcOJrkG9+xCl1O+bVXV+o3kErwsXaECVVTxTPyIW9ML0DP5E9uyYuoDqhND
 BUe6MV7OV8wyNNP24HtukkWQFZdCN+kma22R6eU/qxXBeITtvTqD64UCq8n0U4cLTIk3
 lKBEy06lI25wDFf3PErSlzLlU4FBw725mX3ggCA8J/Ji/nged/+5rl4faRXswp/wnJZa
 QViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793806897; x=1794411697;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XpbdSVCLFgrZ1GH7SSaaac8UpmBwG3ViIckAFeP6Zaw=;
 b=lJdrRQomwu0N8WICJtp+ss1rfCck7DakHWbs2tG8o80u+6BbaTGiCsdZNTqz6baXnt
 dArqZQjt8DAAIB0cwoKuGauF2MAwz+gmSuy+BHJByMwM3ePRTS+xHtvFKXjFskZH9jj7
 TMPAf/g1s3bwq6XInXhj+/zwY3DYpcx2jURm72pf47H/gUm6IV7AK2fg9og99JbHXALV
 i6VMdneLDU6IxbnPIOqScnk1Vmq5qITTBkOv0/bzjfn2kj1JMOQ+YCQk9zYYo9fOMtJs
 Q902bIeUDMSf0r2zgHz9X5e5wxueSCOr1GgXFQyFEyeGuNw4ClZVDsjscD9iMm+U4uhk
 fEoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnysmx/HQKx8XZHMe4ckXbdV5ftzSzPsxcKuobGaWZ34LkR9eJY1cx2cfzfPujueehNo/LwM+cIiYs7l7o@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/i7boUVUFxzcaNf1W4hqag7RaouaTz8nHm8ZXgzEAkUHLNx0wx
 yYT6eV+p3RG9Fypc4Z79RIOoYMMbxHGoRm+RYFzut5+WLCm5D1BeKZLytCC9kh5gM8UIzhznw4T
 km7s2eskmA6NCUgTdRLAVi+URVKd7D3wPnv/3Mz0Gy+N/zOqoK5Os61NOwTmU5sh5keiO
X-Gm-Gg: AYBFou3SdYGjAsIVgAJSvK7u+xPyg0G5nX+lQRZlCtmapVmweYUKZOjYBnuW/B6TrZu
 Ezn8NlnZ23CiB1lKGgRdG7Q6B2S2MiUhUCW9XgmFF4OetuDIAoTYTkG6iikAsv8htQ3omHiE98a
 bobEGMXZjLUbOAvOJEHSwKrUCK6baZKpM/hCPhQ02RNoc7lSyFC57/ze08MQzrrnY0DKohHJVii
 XtLVibe2WW04ItPFi2a5DegSE5j4YmBoEWASKYQhF5UwhIRFM4ODBLBmxatYpYOX307H3R6Naeq
 2G5WW1+gYzrnRY73/rOZiwfRKMmWpI26cz3duR4n2/2YEYKNmACN3Fhl+1FvtlSrJbpih4ez2VG
 HqSQVmhgAC61CR/7//n0GodF9vRWYN49QWXOTZO8StUd/IP6VWaleX6lsl5ZrGNUTwGYSb9SnAO
 fDa0VPI0B87CYJNDWlGo3Qpd2EnYT91Hug+88zDpc4JuoE2Ri0UzjUwq0daTmjlL0yOM9h/9gP1
 UZs6t4hrdqfiYL3tfwkgdU+/0bu4AhNoVPGprBvIAYeN81gw3KlRbUdaCYDOtUMOUPdP+pU62Wo
 Llpoo+AD1tEcetFboNI5j/j5kKMhf/uoEuna9doxbGZFoc/rWtLzIC/aieIsHJzF9OC8VS2cWaz
 NobDDXk4Dkk50D34zdbCY52no6oNGeOjH5a2/IXb3z45ZbY9aDPmeTVGeKNg2biimCR8AQ+Rj7u
 J3Q5j4DGLcTCt83w==
X-Received: by 2002:a05:6000:4a19:b0:48c:4442:54e with SMTP id
 ffacd0b85a97d-48e6e4f4405mr33792876f8f.30.1793806897158; 
 Wed, 04 Nov 2026 07:41:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fece99b33sm4281668f8f.23.2026.11.04.07.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:41:36 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 15:41:35 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: de5de87aafd7ad3390d7c748f79a37cf6dd6eb24
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 15:41:35 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7cec2f26ce31b6692061776ef619970367c6ff43-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOd7P-000000004vb-3x53
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5076568832470826653=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5076568832470826653==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NWu4PPp4eQ4="; charset=UTF-8

--NWu4PPp4eQ4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Lev Stipakov has posted comments on this change by Lev=
 Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail =
)

Change subject: control_msg: Add a shared TLV codec and use it for early=
 negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 4:

(2 comments)

File src/openvpn/control_msg=2Eh:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/b0d53211_3d4c3e2b?usp=3Demai=
l :
PS3, Line 49: /* The header every TLV carries: the 15-bit type and opti=
onal flag packed into
> Please make this `/**` so Doxygen picks it up=2E
fi=
xed


File tests/unit_tests/openvpn/test_pkt=2Ec:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965/comment/368041a6_057d60e2?usp=3Demail :
PS3, Line 4=
8: int run_control_msg_tests(void); /* test_control_msg=2Ec */
> This looks=
 a little weird, testing the new functions seems to go a different way than=
 the existing c [=E2=80=A6]
agreed=2E Done the same way as test_acc=2Ec - a=
dded test_control_msg=2Eh, dropped the extern and the separate runner, so i=
t's one group of 19 tests now=2E



-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Num=
ber: 1965
Gerrit-PatchSet: 4
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2E=
com>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comm=
ent-Date: Wed, 04 Nov 2026 15:41:35 +0000
Gerrit-HasComments: Yes
Gerrit-Ha=
s-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>

--NWu4PPp4eQ4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Lev Stipakov has posted comments on this change by Lev Stipakov=
=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3D=
email">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/contr=
ol_msg=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/b0d53211_3d4c3e2b?us=
p=3Demail">Patch Set #3, Line 49:</a> <code style=3D"font-family:monospace,=
monospace">/* The header every TLV carries: the 15-bit type and optional fl=
ag packed into</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">Please make this `/**` so Doxygen pick=
s it up=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">fixed</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File tests/unit_tests/openvpn/test_pkt=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965/comment/368041a6_057d60e2?usp=3Demail">Patch Set #3=
, Line 48:</a> <code style=3D"font-family:monospace,monospace">int run_cont=
rol_msg_tests(void); /* test_control_msg=2Ec */</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This =
looks a little weird, testing the new functions seems to go a different way=
 than the existing c [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">agreed=2E Done the same =
way as test_acc=2Ec - added test_control_msg=2Eh, dropped the extern and th=
e separate runner, so it&#39;s one group of 19 tests now=2E</p></li></ul></=
li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1965?usp=3Demail">change 1965</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>=

<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </=
div>
<div style=3D"display:none"> Gerrit-Change-Number: 1965 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"=
> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Wed, 04 Nov 2026 15:41:35 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-=
To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></htm=
l>
--NWu4PPp4eQ4=--


--===============5076568832470826653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5076568832470826653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5076568832470826653==--

