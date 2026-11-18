Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1E60A2607
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AalD/1aD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SZiECAPt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HK3UYFoI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Fzjfw3pm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GsOqlC/7Ecxu7rAiKZ0s52vkHAv0iI0siRoQrki9Mpg=; b=AalD/1aDFcPvpv/c/LdHCcJ3O1
	xk+cJZALdsW52iQWP5eKmwKZjgv8Ssw+BZD71gVEB4tR9OTrlo9IMZYpON+ZiN+pGdLr7xGCtaTac
	i/QKdEa2SDom+UQ7GvXlIxiQ0zSNxXtH+T2KYxtHNL4Dhd8S9r5YlgWRcjQNFKysKpsk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTdR6-000000008FZ-1oij;
	Wed, 18 Nov 2026 11:02:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTdR2-000000008F3-2H0t
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GcpKAG0pNkJBBS0CKEpM/IRVY3kuyuC3dZInC0fd1tM=; b=SZiECAPtUgbA/g/ZwPmhF1V5CR
 vTC5anrvaVb3IrzHYLTRpCn4UwPyyv6rA2eWYeDkpYbwSEvKfAB3fzaMwH53CKQx0aW/LuOz8u8V6
 CopLD0KY4H1zyuAsbf+TABfMnlazWK0DMjXUd/AkfXg9zM40qtMMx6vRoqYsJ4mXzHHI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GcpKAG0pNkJBBS0CKEpM/IRVY3kuyuC3dZInC0fd1tM=; b=HK3UYFoIQ4/ybISXetZHfA9/x3
 aCsfUIiYNUqC8MnuYVnUMatMft30f/cSfOhfTAnUt5qikXGidSvfH9bRXA9IA93wbLWr4/1l7Ihog
 A3KkzPp+JfjvxA3ZRYu2bJROz5Y4Y90g9O4J1dLmb1Sb1VzhcdM2a0XYeSzdoqyDcp0E=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTdQW-0000000073t-3bLm for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:02:10 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so9754845e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 03:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794999722; x=1795604522; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GcpKAG0pNkJBBS0CKEpM/IRVY3kuyuC3dZInC0fd1tM=;
 b=Fzjfw3pm9pyMNTmcgr3soXkx+0b7U9+TahN7Ikf7l4FJG67teGwQIKccNZFoxS5roL
 kvo9r4a8mNZ4QsdQ1miABDnGEczz2gTVoMe2t5AXVt2kTboP7iTATj4OS+bSSYhK92WX
 qogmV0v8MREmPabxyNaH4WsS90jMgn+m/NPHvbNEE3PU5ypMnSGR+3LOw8VT97uFikE5
 Lh8QHkjvqtsVu0V6B4SIWfk6XwJJ9KO4PS2ksmJJyEJK4NUAlWwjvrzuUXxa9k0xuWkV
 pYa1CUysVM2sC8w+GGYq0c+z6JE1XBnykN+gAikDbZpA4JU+WwQFsh0/zBgkJ2cDNiTv
 o+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794999722; x=1795604522;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GcpKAG0pNkJBBS0CKEpM/IRVY3kuyuC3dZInC0fd1tM=;
 b=oDmQTH6o04Yq+SxY2wqrQK0dm69qHHAaHGnkj2vbHYx9eG/4OuXs5XGhwOu1n6P7Nv
 DsWpQDapUfV8ZoHrUduxOVM9sB8+4xTlMD6Hg3qzenS/PKdQ6DsItoMcObNQ9hpC5Laz
 H+0D9sufjO/nXpBlbU42eTsrBtcAB023ZD4sIWUhztVY4iKy8jA/EYatVhvHFtCvLGfC
 M6/Hi5FTreXOkff4/n1QDeGxjg/Je0XHiOWq4dCFsgLp0Q17aMpSGgqddDdhx+MEJn7K
 dMDqe3/yah5NyJ8JlOfsXznmbn0UyEG3mgRXh6tiGeEr4uPxrF0emtcOttn9KPkg4Qqe
 vzsg==
X-Forwarded-Encrypted: i=1;
 AL+hErGalRU+uHljMulANN8LMpMMKeVMZfsmtvzhTUc+rXifC4pLWcFoCLyAlzRI8Klzx42kZSs50TWM5vR5JkrZ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/7hwuQhyisMHVakIV6bv7kXkMsSHSeIQYrIdMgyev+ZC9rTFji
 a5B4WZAyCBgnc5ZS/RMePVUVcvKJHy5I7TiAx9vO8z3UT58MeqyKx9KEdTU9aw/c6A2g/eLs5PX
 nEO0sWfx5sF1ybwaq/2ND5MtS5/t5NUQNajNWHD8B7llH5Vrlqf1ma6yMP5Thj+e/Ap5t
X-Gm-Gg: AYBFou1MCMoq8HEDoE5QdI96K8lP/aBbCRPP9zXYTKbIdWcgbVQeMC5i9yqBLCR1ygf
 apIsHVsHt0idSDuoHGMIJ0dm05gP6JN2AcXYbVB16Mryu0OLjLzDaMPwDaWc/BdwMqZUZkLDe9X
 VvLC+yY0N9pyQjkDR8lapVnxjgHJtxIDUZ5HLTRMRQx6wK+iBLkdfko9v14bLOZeI/5+D6ImzyA
 QVyUYJdLclTA0TEbfhBceHHchozzwqL4Mswuz7WsSOgTbr1+pPSwvzJBPEdsaH/4QnEMWlK1D+3
 +c3avMrfPAxo/uG6jBMg1nTXYF/fV/QYp1EfXZrkbzxVJrmg0T/2rz+PI+r4rbjT2khUqO6apAP
 QIsg6CrKuzck45DLr0Tw70t1uoUKDIcYJ/30H1J//cu2uR3HLPLQl8+V240afaHhg6ALaSIvvQx
 Z1HViozLTaKnl8op2iO0oldWI0a4t0JjpcZOWgTQH1ttunBT0JovSQ1MG4TbcJOaGt4nYgHhWzW
 lCrmXhhGcWZElgc1u9C/hii3SokbW+DT1G1lwHclGlcKvRm4g/JDOgJwG1LC1S7ujQHjQjOOJ/M
 OwjUgPJhzN4HgEEu0sMuiztrrOe/1ptVsNvNg3gl5IYi4E0fi4tPca2NSpU3P+G4t00yCmxSV7q
 cW5omLWgf5HH9oYF3o8s1Xn95l92Rz3lAYH12hOjSW3zwEDMODm5HTNm8enkKNfyvr5ZSzfAmk4
 OVLr9dsS4pnJ/fTsM=
X-Received: by 2002:a05:600d:82e4:b0:4bb:6c71:b268 with SMTP id
 5b1f17b1804b1-4bb7da0f6edmr47352375e9.6.1794999721875; 
 Wed, 18 Nov 2026 03:02:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6575a5c28sm4225466f8f.59.2026.11.18.03.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 03:02:01 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 11:02:00 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
X-Gerrit-Change-Number: 2210
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2210?usp=email>
X-Gerrit-Commit: 83a67bd908e799cc6a97f312a842f29b096c02f2
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 11:02:00 +0000
In-Reply-To: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
References: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkk5NzgwNDFlYTRlNjMyM2Y1YTkyZDg3MjE4MDlmMGZhNDRiOWMyZTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bccca942785822147154036f65fcf78a35f3b789-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTdQW-0000000073t-3bLm
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: pause the
 listeners when accept() runs out of resources
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4945912751964952607=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4945912751964952607==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Al3WSTI+oHc="; charset=UTF-8

--Al3WSTI+oHc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, R=C4=83zv=
an Cojocaru=2E

Gianmarco De Gregori has posted comments on this change by =
Gianmarco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?u=
sp=3Demail )

Change subject: socket: pause the listeners when accept() run=
s out of resources
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3:

(3 comments)

File src/openvpn/manage=2Ec:

https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210/comment/faf50fa5_3231bd56?usp=3Dema=
il :
PS2, Line 3325:                 if (man_persist_state(persistent, paus=
ed ? 4 : 1))
> what is this `4`? [=E2=80=A6]
Done


File src/openvpn/socket=
=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210/comment/83743194_9b5=
a2146?usp=3Demail :
PS2, Line 434:     const bool out_of_resources =3D err =
=3D=3D EMFILE || err =3D=3D ENFILE || err =3D=3D ENOBUFS || err =3D=3D ENOM=
EM;
> please sprinkle a few braces over this - there's too many operators f=
or mere mortals to grok this (` [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2210/comment/15e1375a_8156730c?usp=3Demail :
PS2, Line 4=
38:         accept_resume =3D now + 1;
> can we add some logging here?  Thi=
s will create spurious "connection refused" on the client side - w [=E2=80=
=A6]
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2210?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I978041=
ea4e6323f5a92d8721809f0fa44b9c2e03
Gerrit-Change-Number: 2210
Gerrit-PatchS=
et: 3
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Wed, 18 Nov=
 2026 11:02:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-=
In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>

--Al3WSTI+oHc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, R=C4=83zvan Cojocaru=2E <=
/p>
<p>Gianmarco De Gregori has posted comments on this change by Gianmarco=
 De Gregori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2210?usp=3Demail">View Change</a></p><p>3 comments:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/manage=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210/comment/faf50fa5_3231=
bd56?usp=3Demail">Patch Set #2, Line 3325:</a> <code style=3D"font-family:m=
onospace,monospace">                if (man_persist_state(persistent, pause=
d ? 4 : 1))</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">what is this `4`? [=E2=80=A6]</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/socket=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210/comment/83743194_=
9b5a2146?usp=3Demail">Patch Set #2, Line 434:</a> <code style=3D"font-famil=
y:monospace,monospace">    const bool out_of_resources =3D err =3D=3D EMFIL=
E || err =3D=3D ENFILE || err =3D=3D ENOBUFS || err =3D=3D ENOMEM;</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">please sprinkle a few braces over this - there&#39;s too many=
 operators for mere mortals to grok this (` [=E2=80=A6]</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210/c=
omment/15e1375a_8156730c?usp=3Demail">Patch Set #2, Line 438:</a> <code sty=
le=3D"font-family:monospace,monospace">        accept_resume =3D now + 1;</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">can we add some logging here?  This will create spurio=
us &quot;connection refused&quot; on the client side - w [=E2=80=A6]</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail">change 2210</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I978041ea4e63=
23f5a92d8721809f0fa44b9c2e03 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2210 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gia=
nmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div=
>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Nov 2026 11:02:=
00 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>=

<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"di=
splay:none"> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2Emuc=2Ede&=
gt; </div>

</body></html>
--Al3WSTI+oHc=--


--===============4945912751964952607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4945912751964952607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4945912751964952607==--

