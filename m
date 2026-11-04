Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9F6606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=P2il32tM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QGVSWvWv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h+FSpomk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CRxv2cOo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AZK2Z8a7JAGsoNB74rr1tNwTvpeaML5NhzU+NE/X9CE=; b=P2il32tMxFTGo1GUdeayFP2CtU
	Wif9tNMkD/6b5U1ckncTiQJ+9/D4oOifXhtze3t8H1qaZxk/PQvCI6SlncNC9q9d1+xwXBXGl1zrh
	0DK66Nmms6e7f5L4GnUAxfVw2P2+m8k9xxyjlbakxOP+qATKGuce8yKT5+WhwfQIHMi8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOVUe-0000000017H-30jI;
	Wed, 04 Nov 2026 07:33:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOVUd-0000000017B-0Bhy
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:33:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gUCFYdDoXwZZW4IEh8RMeD3Z8hF4rnjy8FL1fAiPS0U=; b=QGVSWvWvL6zUZvJYhMEs2c1ZVZ
 GUfx+j+vxSr40t/cHzJ0dvzk2/VzyvDmX7enUCn9xQ0UtZUp/66E0aD7iLxS9dbCwt2iBnEBjLFBR
 I9z3UvuW51vcXUH7qSW1NUQINmoXYHHoHdoVtYXM04bgY+xj9/dJDTRrUg8bm5/q/OVw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gUCFYdDoXwZZW4IEh8RMeD3Z8hF4rnjy8FL1fAiPS0U=; b=h+FSpomk4Nid33lQZhV7jT3aZQ
 LBlQYAc/uDxstYBOZRc0ORTY/Bv8ze+PzsC7Zl6hnEkvlE+iwMHhtwroGrhhzGqJOgtRXTVWNNMlc
 Yhg2r1aVVgBmgHPVE4u4nxhH7f39wOS72KmxWFxb+LZ7l1XYbpkhr81LvBbJHrHVs94g=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOVUa-000000006Cy-0i17 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:33:10 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so8998515e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 23:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793777581; x=1794382381; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gUCFYdDoXwZZW4IEh8RMeD3Z8hF4rnjy8FL1fAiPS0U=;
 b=CRxv2cOoG6KejTCYC8XHjjTg8U1MqhFm7WwR6pXSBHUdSzkH0HaeBCXeeyXzEd2uox
 XOokNlpdULT0gFvJMsJwSxQlarK9JT0F3K9VssIRO1AQfwJxrujOl+reLZ4Hd6wcBnCG
 zklRU6EmRrVmswmX02xUW5QPPZqUKV51WFL1GFsH4v9cqERvJfkBfLUbDRCKVocUSfZO
 j6IwDAxK/V5zyqarQ2nFLrYyh1Tp0OWwgLcyGrSbFIsFUnXCrHTcM4DrP04u2KyZot20
 1C2QVJNkMcXEMW2JQJY4Ne0sqVZCYHd3Hd+182WD+qSENdyiKBlUZniuGe+ESuPyH3fe
 hZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793777581; x=1794382381;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gUCFYdDoXwZZW4IEh8RMeD3Z8hF4rnjy8FL1fAiPS0U=;
 b=1dlotZrdrHUSvI2F6FfJ24NOlyYnIJGK7dje6hi5u9nZCZ8Uy9/IXhllqsY0XIyAU4
 UIeLH3F6Vsp3GvO61hEiyo3QZHjkBpGF7kD/4nLV1nbZZlP2lZ9Ou3kfc9oQId8PSKBw
 WiotwGo21kY7GHRB/ATL1LkLkp2N/wdIvdwlmRtCX0mdGGv1M63YJnshlMTs4VJmFKYf
 jmQHdJ3tFna6nNbExFc/4SpoxH08ap0kaDQldBckHqsCEhGA6X4mAzK2YwLObGtnuC4L
 SVexj7s8Hf2+4lIReujFRX7DfUBJJbVv2Al2nUahIWU84pQwMSFHlvuo7bx/5JC0idJN
 dwuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJdNfSiE0lS1WbS0FEENxz6XEGp/XfkANMthDA084FV/gnvg4E125Mm3MtH5AbCgyWJ7c+SPXUbZxCuhS8@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+tDVlAQm7I0VTf4ETX0em8lR7nZ/lhoGAB9pBPJTxzg5Tc3BdR
 6iXLW4ORHFhskMCe558o1FbHbY7sE3lnSDDnMbGD3QBlV0IjqlS0U+CdnfNPfqbNh84OmweVhtE
 ckKQbF4MfUnURozf0YvmiCfkB3yG0YR3qEkSMnPQ3r726e/BOc+bK8EO04JRk58l1Gx2o
X-Gm-Gg: AYBFou0FAKZ+a+HikWAzvCDShPfqLM6WebzhLZMDIyjDmsx8ggvmO+zLBeoaw3HR0dP
 v23BXbckP9doJ07+6QiJQB92nAt+dUl7/PixeCPp9HfhNjqzmyZYpj6WoKTNA1+DJQ68UhLfU85
 Qiifx0++kU/8ZBeDN4JM62BQi51G3JQua90LnDRHkJIDALsCaQQ3k+45T4/0X/7FKnc01q4FLM/
 XsHO/9+CO7JHPiojTB7jsKvjBXWoim4baSYr8rJR3mpyb+tlV4KyH1RAGRaMCIoFgS+PWJbTSfw
 ZW/RHt6YEb1A5fiFrNWsT5WUUFKd+0dlNVIJsL390E7YEdW5dF/YVF//LFkz57/wXRWKdJJmDQ6
 GLQRALex6yQwL3M+3DLp+bo5+pyJFla65uuaIvLJ9VEdeUxFnK5/BnzryXFg2djONP6hbLkYxGe
 cYuz+aCifhNed6Ehenqo4exk3IfgAy/g+UAbRMVo5YXVUd70ZE9UE1IDFDBa23uWodPtkoENnp4
 R7YehbEmfXjRT135yOJsb83Ovlgh1agrfjsv3wzuiAm+FCt1x3DEAqr7O3MRTQsOVmkPGdO67kS
 7E0thBpvHv6bdcf4LdE8HWllsDFpPdQaSjLTd4QDYFkq4FcTWxCWuOQcL2J6ku5sJV4lW6l0RbQ
 D1Mn6RBwVWuPQ02vGFgUp2WRW6QNW+3bfkq6TBh7U2538M8yy5A5uIpqgfH3Elr9kO2nsJXX3HR
 6dDWlRvsJotMePWg==
X-Received: by 2002:a05:600c:8116:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4ac17e10724mr351306255e9.16.1793777581276; 
 Tue, 03 Nov 2026 23:33:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4107b7198sm18560825e9.0.2026.11.03.23.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:33:00 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 07:32:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: d6770048b77488747e40f67058e821c6ea13337f
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 07:32:59 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <33dc551fd379a9e62ccf29e14d3bd9e016f8de2d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOVUa-000000006Cy-0i17
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6388111686168167785=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6388111686168167785==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Mc0b8Nb3jKc="; charset=UTF-8

--Mc0b8Nb3jKc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

R=
alf Lici has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux=
: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

File src/openv=
pn/options=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/ec=
633b22_2d53bf78?usp=3Demail :
PS2, Line 211:     "--rps-off       : Do not =
automatically enable Receive Packet Steering on DCO interfaces=2E\n"
> how =
about keeping the same format as --disable-dco? therefore --disable-rps? [=
=E2=80=A6]
Acknowledged


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/c=
omment/d4434d14_aef3dec6?usp=3Demail :
PS2, Line 4468:     else if (streq(p=
[0], "rps-off") && !p[1])
> and shouldn't the new option only live in the l=
inux ifdef?
I intentionally left this outside the Linux ifdef because the o=
ption asks openvpn not to enable RPS automatically, which is already the be=
haviour on other platforms=2E Accepting it as a no-op therefore honours tha=
t request and allows the same configuration to be used across platforms=2E
=

This is also documented explicitly=2E Would you still prefer rejecting the=
 option on non-Linux platforms?



-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1991?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
Gerrit-Change-Numb=
er: 1991
Gerrit-PatchSet: 2
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom>
=
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <a=
ntonio@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 07:32:59 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Antonio Quartulli <an=
tonio@mandelbit=2Ecom>

--Mc0b8Nb3jKc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Ralf Lici =
has posted comments on this change by Ralf Lici=2E</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></p><p=
>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1991/comment/ec633b22_2d53bf78?usp=3Demail">Patch Set #2, Line 21=
1:</a> <code style=3D"font-family:monospace,monospace">    &quot;--rps-off =
      : Do not automatically enable Receive Packet Steering on DCO interfac=
es=2E\n&quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">how about keeping the same format as --=
disable-dco? therefore --disable-rps? [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowl=
edged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/199=
1/comment/d4434d14_aef3dec6?usp=3Demail">Patch Set #2, Line 4468:</a> <code=
 style=3D"font-family:monospace,monospace">    else if (streq(p[0], &quot;r=
ps-off&quot;) &amp;&amp; !p[1])</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">and shouldn&#39;t the=
 new option only live in the linux ifdef?</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">I intentionally =
left this outside the Linux ifdef because the option asks openvpn not to en=
able RPS automatically, which is already the behaviour on other platforms=
=2E Accepting it as a no-op therefore honours that request and allows the s=
ame configuration to be used across platforms=2E</p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">This is also documente=
d explicitly=2E Would you still prefer rejecting the option on non-Linux pl=
atforms?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">change 1991</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I97c55e211f9113d0908=
08724ab43cb3c94099fb0 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1991 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Ralf Lici &lt;ralf@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli =
&lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Anto=
nio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 07:=
32:59 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D=
"display:none"> Comment-In-Reply-To: Antonio Quartulli &lt;antonio@mandelbi=
t=2Ecom&gt; </div>

</body></html>
--Mc0b8Nb3jKc=--


--===============6388111686168167785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6388111686168167785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6388111686168167785==--

