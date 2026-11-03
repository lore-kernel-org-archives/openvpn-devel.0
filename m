Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE2606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=elpS0wzl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Bw5+dULs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZyJhEugQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ALSLX/dr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Bk5WndFnNv9CRU++4bztU7i7S+aysm8T3xFVoeFhrgU=; b=elpS0wzl2iX7ZiOSIViCcmHGm6
	PbrRILAociBUVOitncvj12NfYWkuVsbiI5s92gcvXA/lxvRu2EupprBAULb3EXuIm453YAac9TJYg
	qGdx7axJBUNTiEhdbiWmzROCDUMkElzCGz+zaM/Ikao2XWf8ouAb3uPuVlXt7y5jfysI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOFEF-0000000060h-1Sao;
	Tue, 03 Nov 2026 14:11:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOFEE-0000000060a-381K
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 14:11:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6/L816+P/SKs+76DNJ2l3GZ+AyNADoonXzU3GS590ec=; b=Bw5+dULsjhvT/aKe/Ty+YTRX0d
 F2GxKZbPxWQnkijg34+5Dk4qDqBiRqNT1eGbRqjDf1FiinXfdxznXYv3bYTxjzGiSbHJIyvkQNhqd
 pLuBJSRnLIt/hp/fFWCjgYS0BXacjHCv+RTCvsNdeXFh9whYZTL+G9JpFgDc8yNOMfD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6/L816+P/SKs+76DNJ2l3GZ+AyNADoonXzU3GS590ec=; b=ZyJhEugQplqfs2eyNZuubXdZf9
 zmwCXcvbg1jgfJCINyes9Kt9Ye7GJqVlP+JEkhrqE72m2xAOFyA3loTBRWbKbbZqe8coI51Nyriv4
 /zFeLIzyi1RLaKXsROTFw/SsNcCFS8lOfpAif0evZtfU1CSmfrZwGKT+QrTIgqzP6dVY=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOFEC-000000004RU-3q5Z for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 14:11:10 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so2564975f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 06:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793715062; x=1794319862; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6/L816+P/SKs+76DNJ2l3GZ+AyNADoonXzU3GS590ec=;
 b=ALSLX/drwrcfFBozTnP/ywk8j0x6sbuWdOKV3kCAVpSBtgglWRLyuTJZ09gtv6Nl+d
 NbqTdusV3MzpI0v4BQbPf2eR9O2QXAJ3P9cQrBCGON8OjHHmlb8bczrqOZVCjbrRyuDy
 u3Bw4MqyzE2Czr6sXxvvXENNfetP7dXJZcuke+XKY4be1oIYbiuw+FeY7jbQKJ6o/DZQ
 MiH6QT+KLCjdR9PDbHKBeT34coTXEjSdoLFIscQyr2cvz3lg55/XfZz6Z4FmzxLlDzo5
 MppX8Ybhmd8krPnzKyD/6c8wUE4rp+XH1lsPPL/bj4ByL37WUNHPT2QzsXRzEg8ribHx
 r/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793715062; x=1794319862;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6/L816+P/SKs+76DNJ2l3GZ+AyNADoonXzU3GS590ec=;
 b=N+f2MT8NBWKG0f1Z/QDADiRs4JwpapU3TNpucWVTrKdxMtrSqdM5Twm7EDJLhga9lw
 T+/l609tlvZRlCdgaPrX5n3JCqMPhbSWH1NLJgcKmoNJVvXJeMRO9Hru60kDToxoCMEL
 N4AsfB5eDGMbg384yE5ZNSfhTAqSITXzXHFSY0gy22DZcQHe6b/a/OYt6XI0BlQ/ze6O
 50onP46oTP0tmxYvZzsiv/cyFmAT9a6xdpHSl2zQksJ8CPbUMN4TCGVhfE3X2SLzxTQw
 GISc7cbu5QLGwXF+LhhZ03YhWJjFGr16ORtJWiHY4O5SOeF+fSW743Hx/VdtO7lYPga9
 q5Yg==
X-Gm-Message-State: APuU4Z+7Rx62GwsiGUbB2jo5C257f93RRzx4CbTUlg6VrWuTK59uJ0Wf
 2TZ7aFNGZcSHGHdvm2LAsfmcPSIjj31506P7rwE73jxXtmV4AOGhZa+Hh7jxhIxbNS5FKCEUACe
 yNUZzgbbF0QVtIzIYH0AfCkNtrAc28GupV9dHpmB22/ltuM5xQW/mXlyYCtEcplYNDWSy
X-Gm-Gg: AYBFou1JLyrhCRKNfsmfGFp60hNumXNmfzLHcA9yTCLl7GrHtHg9NL6FBOp89yPVBqr
 i7ZETxEnrL69C+KidnoJWzWmS5UMGeGBjjSBYgo+xWy22uWgg8rttDDLYGzeuCcV3rLRFrXJ1Zq
 rpMRV+9gT9eiQqq0wCrO0tATqntmey/IXLvXhRqfH0V5gy96ZJtxmm1GnHkT7pUadDLULKlfRLr
 8h44OZgfgoSsa1wPDYQdK3pICPTomToX0JSNzc1c0mN+vG0JNYYdSE8BQ8e/hJB+0iZlFJbkqof
 PCKgBKI0uszg9f1M1BSoKhw8aqJVhOXHH6YNH4UudjxFFlCcPBJ9e7br+FUfHiFGT45oSxQhqFW
 U1pdP+wkWw43md8L+pPXldrVcXcpElWKtPostLKrSw5tAPObgbOEL/TKtMHRV/kfD1neH/2sx1U
 uCYJz6DRf0ZeG+hcHlxpJNPLJF9DDWH5k6U+i2AX2uLMJEVwwUReclz/vUJJ7KTbsScdU/QHe8Q
 hkeWXpRr+rxELfW8IuSIF8SVmrq3leHYIducVPftTijyy3LrB8knxN3oje/hhOxnp7kefVV276i
 NfghDHWVTi/gOH2pojR4mffQN9pX1L3Sbop8lm8AfOuz/BL1w78Z5GiykWVKBaC1spmHGMcrFum
 Zvp+iBDoDF/+q+2/oT/lT9oIBLrYnF7ddNarp8qmtpGmc8EUMzY9BxpiJ7DqbCSc97VMuyFlNE9
 AyWLg7oXzP8Z52eomI4m9arShoR9PLIIolnEI=
X-Received: by 2002:a05:6000:4203:b0:48e:6145:498f with SMTP id
 ffacd0b85a97d-48e6e4faee1mr28899829f8f.55.1793715062003; 
 Tue, 03 Nov 2026 06:11:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78f95sm23737192f8f.28.2026.11.03.06.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:11:01 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 14:10:59 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
X-Gerrit-Change-Number: 2108
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2108?usp=email>
X-Gerrit-Commit: 51425676a1171e901b3d515c34dc11fa4eeb3abe
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 14:10:59 +0000
In-Reply-To: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
References: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk1NzFlMzBiYjIyZWM3YmZmYzJjNWZhMDRmZGNkNzNiNTJjZTQ3ZTVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1ffb178dd6f93ffceaa0cafe4d0fb13a375ea0cb-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOFEC-000000004RU-3q5Z
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Silence remaining
 cppcheck warnings on macOS and FreeBSD
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0086985067177462464=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0086985067177462464==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uSb/KdimQHw="; charset=UTF-8

--uSb/KdimQHw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2108?usp=3Demail )

Change subject: Silence remaining=
 cppcheck warnings on macOS and FreeBSD
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(6 comments)

Pat=
chset:

PS1: 
Strictly speaking correct, but maybe we can clean this up a b=
it more?


File src/openvpn/route=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2108/comment/373849c7_ad9db057?usp=3Demail :
PS1, Line 3336:     co=
nst struct sockaddr *gate =3D NULL, *ifp =3D NULL, *sa;
I would move at lea=
st the definition of sa down to the first use=2E


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2108/comment/68ee0b99_f8815ce7?usp=3Demail :
PS1, Line 3=
409:                 sa =3D (struct sockaddr *)cp;
use the const also in th=
e cast?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108/comment/458e2a30_=
073889a7?usp=3Demail :
PS1, Line 3428:     if (gate !=3D NULL)
For gate we =
use !=3D NULL and for ifp we use `if (ifp)`=2E Very inconsistent=2E


https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108/comment/04eae770_c0099e0d?usp=3D=
email :
PS1, Line 3431:         rgi->gateway=2Eaddr =3D ntohl(((struct sock=
addr_in *)gate)->sin_addr=2Es_addr);
since gate is only used once as a sock=
addr_in, maybe it should be one directly?


https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2108/comment/40fd93a4_471fdced?usp=3Demail :
PS1, Line 3440:   =
          const struct sockaddr_dl *adl =3D (struct sockaddr_dl *)ifp;
also=
 use the const in the cast here?

make ifp a sockaddr_dl directly?



-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04=
fdcd73b52ce47e5e
Gerrit-Change-Number: 2108
Gerrit-PatchSet: 1
Gerrit-Owner=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Tue, 03 Nov 2026 14:10:59 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--uSb/KdimQHw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail">View Change</a></p><p>6 c=
omments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Strictly speaking correct, bu=
t maybe we can clean this up a bit more?</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/route=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2108/comment/373849c7_ad9db057?usp=3Demail">Patch Set #1, Line 3336:=
</a> <code style=3D"font-family:monospace,monospace">    const struct socka=
ddr *gate =3D NULL, *ifp =3D NULL, *sa;</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I would move at least th=
e definition of sa down to the first use=2E</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108/comment/68ee0b99_f8815ce7?usp=3Dema=
il">Patch Set #1, Line 3409:</a> <code style=3D"font-family:monospace,monos=
pace">                sa =3D (struct sockaddr *)cp;</code></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">use the cons=
t also in the cast?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2108/comment/458e2a30_073889a7?usp=3Demail">Patch Set #1, Line 3=
428:</a> <code style=3D"font-family:monospace,monospace">    if (gate !=3D =
NULL)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">For gate we use !=3D NULL and for ifp we use `if (ifp)`=2E=
 Very inconsistent=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2108/comment/04eae770_c0099e0d?usp=3Demail">Patch Set #1, Line=
 3431:</a> <code style=3D"font-family:monospace,monospace">        rgi-&gt;=
gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)gate)-&gt;sin_addr=2Es_addr=
);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">since gate is only used once as a sockaddr_in, maybe it shoul=
d be one directly?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2108/comment/40fd93a4_471fdced?usp=3Demail">Patch Set #1, Line 34=
40:</a> <code style=3D"font-family:monospace,monospace">            const s=
truct sockaddr_dl *adl =3D (struct sockaddr_dl *)ifp;</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">also use t=
he const in the cast here?</p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">make ifp a sockaddr_dl directly?</p></li></u=
l></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2108?usp=3Demail">change 2108</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2108?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47=
e5e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2108 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03=
 Nov 2026 14:10:59 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--uSb/KdimQHw=--


--===============0086985067177462464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0086985067177462464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0086985067177462464==--

