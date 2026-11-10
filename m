Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B14606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hl6p0cA/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HtEpBJqd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PM0FxcZX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DI53NShX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4ZiVd2nN/XH4R2C1P1r8LdKZqLFBB9bRPXY+iYxKcLQ=; b=hl6p0cA/Xfw1Z7F+EaGn2n9W2+
	tCIt89MzrtD6W2083LFS3defssucCkRWSsegDdIrEcfyOfrHnLCPT5i5J9dF8ISls4zyKlelo3Ej5
	Q6hSivJjLCW7FU3Q/RqLU/biFw4DXp0LTjFA8m8qOmSEXny5X/qFy9+uQvyGa0d49N5c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQkvp-000000001Q4-1hb1;
	Tue, 10 Nov 2026 12:26:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQkvV-000000001Pk-1jAX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:26:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wDSLnvOQ2YZkPPzpFtYdMLYiNWbIW1Uqugk5W1Z+PlE=; b=HtEpBJqdzcf1kibDEcUmd/q7jJ
 9mVc9sb0N+I3lmJ5nJt8uRoBldVU11wjZXnGQZ9Bq2QF8Wp4Wh0Z/HNOcfaGnBUQBJwj9PBOK+XP9
 XsKzttq1jeBmJjXqMUup3HOrd3pkDv6Z1IBrPljWcj81HyaYXE4fJgSM5rJ7pODJXuhc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wDSLnvOQ2YZkPPzpFtYdMLYiNWbIW1Uqugk5W1Z+PlE=; b=PM0FxcZXRzcODZqagW7Qa3ZWNJ
 ugYHg6MmiWdIKiGmbH7Q0gIlmh2DRm9S/qmnUcnPBEtcJnS/fQyeU446pi5pCSGF0Kh8LEsTH5w8X
 NbziVWIyJ6Ks6f2NLL2QCi1H09g7dGDFB9zOo+4uRR4kz5Ih6Cp/+YMLbyRbZrgUy6t4=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQkvP-000000005c7-2UnB for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:26:09 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso15949905e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 04:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794313561; x=1794918361; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wDSLnvOQ2YZkPPzpFtYdMLYiNWbIW1Uqugk5W1Z+PlE=;
 b=DI53NShXT3E0IDptntrdbJWzOOj3gMC8AifNXWOj60L351yVFOSe5MyX9LVksLe9pl
 KvjJ6N7SRbZV//q5QrACRQdTyIr2elSxURQwW0eAuLTkOYTweNsqGejhihm1i7hQj1vS
 Zzm103Tk5pAmynrW0V7/DfdPEa7bKChVs0b69XW1FAFtmOMAethP3pfDVpsXqOm76mwp
 bjnT8dvh3TkWUBbHfv/LJLJNJSDcJ4oKlkok5ol7ntsk09mWEIn9xcDvimngCJEUHbhk
 WYSnLqqHfa9+i3EEnr7Cghd2rxfReIYZ7vbiY4HRdsEVdVuRYEqILqRPVq1c05p629e9
 lF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313561; x=1794918361;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wDSLnvOQ2YZkPPzpFtYdMLYiNWbIW1Uqugk5W1Z+PlE=;
 b=h5+du1h0Fwsm5BpVaXIfZP0eNcx82q8eTBai4UsJABSNPcQqbEdpZbThia7mwpnoYR
 X3AvhBQv4h519Y813VetG3eYDkbV7tjhZfC3p9EAKGKIFZdv+XMxTkcSaREzwATr75Uc
 +LedYuqnR8xGApLaDQFoyaoMLNc6PbqyZSH9CCwmiKFfYBySdrsIGlBrZ8iPV2wFB9Ls
 wk3VzxJNIC8IIGuh5zSOn0K/V6S+e+gaejO3ZJEtvKt7HD8MPZmyozzNesrPa22S7Hqn
 Yei4KIhpIFvzki+dZgKywV8mGzff7qxr84VovtOO3afMFRA8jzQ7T4Dw92M0coTRyLh/
 V6JA==
X-Forwarded-Encrypted: i=1;
 AL+hErFl487rbXF/vg4owEtNrEgSoHYBnv9Osh+VHkS6n4rDLsll0uAiQQ5B2ajhtXvxOi5rIEIp0HndzmZLieap@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9FP3wvs7qp3/bk1a81PvtD5kNwYDRbSJ5YoU9RxIwOCvs/te70
 kz97gIkmQz6w/G5cpSzWZQaV94VytneMXc4uBSOdVTCAGeTTp1ZETmvDWXzAZgzaNWytU6fIBLW
 2Ye6e6J9HGu9zoZDiaZPDeCLCIrHkEpWL4fswldxeBLEhyzUmOBD/A7KpY1gr8wq6gXLc
X-Gm-Gg: AYBFou3cGBGHds4cUiM/+86cc47nRil1TAM9aIyZ9GSn9gNWLs7/T10wf257GS2nHnL
 huEB1nS+8hPR33XuceBLiFnPCPWBlPdGUybOfK0ER/LZZis397LGDrzqzLke1CjA37v9u3d1nTQ
 L56GJMQRatA7ZcbkAMbCef15JQ+2CNbAGVEcN+tWSyVtcJQ1fK/TZVrHj3AT7rLyXYAo15sF6aq
 qF6mvy1nAQPZfteKipK79F43/cSm3WLqBDSpiYcMrbos25TO9dhVT2e1k4I3k7PT12+9bBPOWYW
 OE1qwDXUxzhNm7XoOV9kF7F95mvB5sAinJcKbrTOoVmjDjC3r93DiVnLLx/9+qz6RCFL+O0MCHn
 oUwS1GamfwsWdKJRE3KNJeXC31VZ8AipXRGtVpbkBN65bCehJFrO92beGZTl/Uk2s5z30T3Q4w1
 35bU95bJJcQo5wZy5GW1B1jGuUl2Y6B2LFqkEypNrOV1ojwvFTJNiQpG+Kdt8HNPI6ONSow1MqC
 +jU0b34h+XiwEIytbABqObjk+Abv5XzXgnbghTDFQiTlbbiffoYNZr2hIdJoovfdI8FWXN0g95Z
 GQIh3s2Dnj23nQ/YPZVP3CYOtEVca+rbY9hK5JqKordjGUtexOpCf4I0jDqaZu0uPo9nV33DDM3
 ZnUh9xKOZXecZjI18d9KCzqkdC/Tm7quDYzC8YLhDigcF3kJaENh//aZL4+5qWjOWBBwbpcQAB1
 uMsY2rH0w9tZQnsK2Z+DUn9aMV+RMFohCmf7hQ
X-Received: by 2002:a05:600c:1d8c:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4ba0235658bmr42013575e9.33.1794313560788; 
 Tue, 10 Nov 2026 04:26:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba023690f5sm46081895e9.3.2026.11.10.04.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:25:59 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 12:25:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
X-Gerrit-Change-Number: 2157
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2157?usp=email>
X-Gerrit-Commit: f339a5edaaffaed82865b0ac2029c8e34a8655a6
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 12:25:57 +0000
In-Reply-To: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
References: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkwMmY4ZGYwMWY4ZjMzY2I5Y2QwNGNkODQ0ZDFmMTg5MzY4OGY1MWU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <92989a2db999139f17b79fda4c67db86cbb3448e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQkvP-000000005c7-2UnB
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2810141478169988771=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2810141478169988771==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Wtrjk7Bs/hg="; charset=UTF-8

--Wtrjk7Bs/hg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail )

Change=
 subject: Various trivial -Wsign-conversion fixes
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

File src=
/openvpn/crypto=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157/comme=
nt/84391446_ecd986b1?usp=3Demail :
PS2, Line 858:            + max_uint(OPE=
NVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
> `packet_id_size(true)` retu=
rns `int`, so the sum still converts `int` to `unsigned int`=2E
That part i=
s in the next patch=2E The distribution into patches is sometimes a bit awk=
ward, admittedly=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157/comme=
nt/c1ef59ef_c4b97d88?usp=3Demail :
PS2, Line 1553:         fmt =3D format_h=
ex_ex((const uint8_t *)&key, sizeof(key), 0, bytes_per_line, "\n", &gc);
> =
`crypto=2E [=E2=80=A6]
Done



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2157?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
Gerrit-Change-Number:=
 2157
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 10 Nov 2026 12:25:57 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>

--Wtrjk7Bs/hg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto=2Ec:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2157/comment/84391446_ecd986b1?usp=3Demail">Pa=
tch Set #2, Line 858:</a> <code style=3D"font-family:monospace,monospace"> =
          + max_uint(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">`packet_id_size(true)` returns `int`, so the sum still con=
verts `int` to `unsigned int`=2E</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">That part is in the next=
 patch=2E The distribution into patches is sometimes a bit awkward, admitte=
dly=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
57/comment/c1ef59ef_c4b97d88?usp=3Demail">Patch Set #2, Line 1553:</a> <cod=
e style=3D"font-family:monospace,monospace">        fmt =3D format_hex_ex((=
const uint8_t *)&amp;key, sizeof(key), 0, bytes_per_line, &quot;\n&quot;, &=
amp;gc);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">`crypto=2E [=E2=80=A6]</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2157?usp=3Demail">change 2157</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d=
1f1893688f51e8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 21=
57 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Nov 20=
26 12:25:57 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Y=
es </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div st=
yle=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>

</body></html>
--Wtrjk7Bs/hg=--


--===============2810141478169988771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2810141478169988771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2810141478169988771==--

