Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEEB606A336
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KXDfg+U/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mi7Np5Jp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aP79HCea;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ErD05HRk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2SmfMACtmWsmJ6HgrfumpkEMdsZm9zlprD8RE7NP5p4=; b=KXDfg+U/JrekcxjLXxPvRhJMq5
	KPUzBhr6M8Y1AFPmmIjf8uI5j4zOTtTiqWcQITjMThwYHHt8MQkYtQ62FcVEbJMoUTunVIQq9XhQW
	vMYX/OesvoLTAP2Yqv8BKZjBXq+p1/FtVzqT3oqYUzbx5EE5UTZ6Xox8CJG2EyH2d7qQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRVV-0000000008W-1ufh;
	Mon, 09 Nov 2026 15:42:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQRVU-0000000008P-092q
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/JlrIcXcGpFP81bWu66AyG0ffhcoC17+GB/xla3JGr4=; b=mi7Np5JpNXkdTw1U/v5zA1tzPe
 xPuzeaYcLdJIIbo4jC5Q8p1GfMFzCdoxsmVxXWMSbfHDY70xFijLMr27yKFGS9C3DMEQNcQcTIw2U
 cfF2WePfnWwg77ThR5FS2mUjpxXqb7E2YouY6WcxXH1StYIMnhqp1L+8Oq2UuxFRRbKI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/JlrIcXcGpFP81bWu66AyG0ffhcoC17+GB/xla3JGr4=; b=aP79HCeadDf2DYlWgedEK7ZY5A
 eFZPF8v/FqKa8er/1OS6JUuDddxCQpcDUVI3mSV6qj0ek3Pq6R+r9KeFn1ln2MrHsDUlieU96tsm3
 TbWuQLELswV1CiVC47IyoIw3CvvYOY6w9YheJnGhd0xue1xH4lDjS3o17PSrnjbMbiCs=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQRVT-000000001Mp-1YLb for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:42:03 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-491971ac844so996062f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 07:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794238917; x=1794843717; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/JlrIcXcGpFP81bWu66AyG0ffhcoC17+GB/xla3JGr4=;
 b=ErD05HRkO76K/CXa7twcpJX/aZ6Ka7EqIC5tBAIQjxt9iNwHPn3ozgiyjhgU66oVra
 i2lHtDM/86/U+CrV98tAUt9rJdez7FyKIhyJ/LBenPjHLcwOD6fZV+P+yeRmFrvte9B3
 URllYVWDb5mpU5G75/QYLKe1DahEbTYOIY6JLaqQQtmWwjg+ME61WpXPvgHeY6QtIoVq
 pNtlOLEclLpr9NHkmvbor5oG9PTN/ecV8hXvuiO16ohhSo5bWxGCGiTNaXFohVj2xh8p
 GlsTLtV9ns6UX/N0uNu0YAmiJki+eKO99jRBEcn929X9EYS7jVF5fT7pzm13h27aR1ut
 qKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794238917; x=1794843717;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/JlrIcXcGpFP81bWu66AyG0ffhcoC17+GB/xla3JGr4=;
 b=QtoX/AYKFCn2VpsA0ukjiAae9SvDFM9OKViDsnHIGYk59s+G1wB6qUG7NFbCNDSMth
 gSZgnIeQjQCSq4KH0Efq/ZRli6dXKRIky2lkkEUtY3y612g2tl8X9tRxXBX/tFsm8Rvm
 jtVac/z2ZJaqbInstLvf7gVx1/FzzQ9vnNjQGAEb3T4E+V1oUzI5QPcAdTk74CdwFqb0
 3V0/1/zTyfaYYq9bnGU9t2PeKIaXqPBcLTcwyRVzw009cc0F5Yuu9ZxW+gfwUwgHJr+F
 YLjsBBDONOMfNQbsephv+20kB/CaBiS7pR0MzkgZY4hAMWJb7jIEVdM5+bm3wDDPJRTm
 XFOA==
X-Forwarded-Encrypted: i=1;
 AL+hErGxaNJnChLPyexfDhRKTVsLPkJVlYdhZAusznIMfnSxPpO3erIEwTdVBzf/lbrIVrbbdN8JnZkLXnbk9xE+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8KPUJOzfxbEaT+4x2EjoGoQ9FA+Z6EtSJ9Rhy6gGYLF7UWqhia
 bwBuKqSyGzr2CBlKGnp57nzuTlMZmQW4uL2W0g68A85LD4RP2AHls0JTb27poTL2yC/2qdstjD1
 Jq+82s6yxSsmatuxp7hRsCk2ST0DG65zKgwaktH0kykjvrrt6GBH7KObRiwBl4916DDYB
X-Gm-Gg: AYBFou0+KSgkNvAXpV7/+/KNzL1IulBWg2cchrWopkNBKSbgFtAcW9YsFLCmPNFKs3k
 Co9UG1/84BykVzZQNDZmn8CrDrb5VaQF2rHL1iHfyIQeKcfAkrbHzIxxff3HLr7pAxUJK5hB6US
 J0q3l5XL8AuIMCgu+hWyAuvvEN7r+G30b6siXXiMjW0mmEMXl8859P/XOKzJ9fB7rjjwlUB9aus
 JdZW9zgeTz3PfMBfCZJuTPbW8tygwnaA1JobfI6pNAXh2CAjQi8JqGJP3fzTmQAGwu76IDTR48Z
 hOlbGbgprzhGQjeDedTxKSV9p+8WKdLWKXuptoFH8VYb7S/xXC9Rie8Ve2Lt2WjQ0q428K6qc5E
 n7lUF0NWUSzervRcB8aeOkCPYwO3hs1a7NcaWcvMGlfUAzApTetCXmj9Ey5YqX+pHFwD/UaJCVe
 NfP4bv7O45IZjVrZjdAxDNN6KYfDMo7ynhU8Mcqwj6hoR7hD9tPTFAiBSnmLRr83ErtEv0XYfwr
 DgUtTOwXW2vqQ91+M/Ja5zsCTdvxBFZ+GbhqtKAf/SgKGbbGYhXD3GB2j943tXyq50rJIKt+jLd
 vvpsPTNaLO2ZSQTKbW0zJpDVA9YyDeCmK7KfxfG+L0NBSyYAupez4WYsHgtRTjKcGRwm2zPESU3
 zMSkwWDiCmNNeEBQPPeeYUn7LF9E33drSwimP8+TnaArITVEV9JZlsCVOC8OmHLTc4WvPuQED/w
 ZOrvU2H0+S1PEDWQ==
X-Received: by 2002:a05:6000:2303:b0:491:ef0a:1f5d with SMTP id
 ffacd0b85a97d-4958530ca7amr9479493f8f.39.1794238916566; 
 Mon, 09 Nov 2026 07:41:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-495e725c4ccsm7839098f8f.53.2026.11.09.07.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 07:41:56 -0800 (PST)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 15:41:54 +0000
To: opidopiopi@gmail.com
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: 56b444718cd97a0d87129e8ff57a96f8bf1ad97a
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 15:41:54 +0000
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <17b72f9a950e241980fab56660c2d6b687b6b966-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQRVT-000000001Mp-1YLb
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement multiline
 responses for pkcs11-id commands
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org, opidopiopi@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 yura.uddr@gmail.com, gert@greenie.muc.de
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 Yuriy Darnobyt <yura.uddr@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5604948856937211635=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5604948856937211635==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5ySZAiM5Zew="; charset=UTF-8

--5ySZAiM5Zew=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering, Yuriy Darnobyt, opidopiopi@gmail=2Ecom=2E

Selva Nair has posted =
comments on this change by opidopiopi@gmail=2Ecom=2E ( https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2148?usp=3Demail )

Change subject: Implement multil=
ine responses for pkcs11-id commands
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2


-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832=
b8
Gerrit-Change-Number: 2148
Gerrit-PatchSet: 5
Gerrit-Owner: opidopiopi@g=
mail=2Ecom
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-CC: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-CC: Yuriy Darnobyt <yura=2Euddr@gmail=2Ecom>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: opidop=
iopi@gmail=2Ecom
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Attention=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: Yuriy Darno=
byt <yura=2Euddr@gmail=2Ecom>
Gerrit-Comment-Date: Mon, 09 Nov 2026 15:41:5=
4 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--5ySZAiM5Zew=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering, Yuriy =
Darnobyt, opidopiopi@gmail=2Ecom=2E </p>
<p>Selva Nair has posted comments =
on this change by opidopiopi@gmail=2Ecom=2E</p><p>Patch set 5:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail">change 2148</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09e=
55085cde6dbc0040e111a42128527d59832b8 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2148 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: opidopiopi@gmail=2E=
com </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Yuriy Darnob=
yt &lt;yura=2Euddr@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: opidopiopi@gmail=2Ecom </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Yuriy Darnobyt &lt;y=
ura=2Euddr@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Mon, 09 Nov 2026 15:41:54 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--5ySZAiM5Zew=--


--===============5604948856937211635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5604948856937211635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5604948856937211635==--

