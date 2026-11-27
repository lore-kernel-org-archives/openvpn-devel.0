Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02D606A32E
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Mv0C1iRv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d0vilKbL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lklxNG9B;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V2/SYu/o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sI62CgeGpsOFIzz+ruIW3rzFEEKm4DgZZqq6yc4re5A=; b=Mv0C1iRveDaYUPWWPp4S0EupZ+
	mPK0UR97TG7cjNJRUGfrxDHGNFcozhLkKCriShjNJa0UiCrK6eRPPcIQqCrOd3BB0V91s4H1fz7dw
	0T8ZbewhiGR7EmEvzXvP0tjTXG4l/EGH5Q1IxGKX2L+48wnW3an6S9b3SiX65ToJDDy8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWwPj-0000000031s-3kE4;
	Fri, 27 Nov 2026 13:54:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWwPi-0000000031l-2szr
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:54:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DhOQ57U8wIqOo170QHxJkk80TdXs3+T9QtYGy3zYT20=; b=d0vilKbLaQL9/wq8kkP8hN4PwL
 CTQdCMnMY7w1DhhU66F+MDFeezlSWNfoqNaCeP42SN28wPSMROakz3y9OjRBXbAhdjpdlOQx8pS95
 rAF2dDeiDhSDJBWu9raS5etKU8i/5DbUL4JkudMJxwIPrzG3cOgOf2ARwYL1ZPKBEc5M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DhOQ57U8wIqOo170QHxJkk80TdXs3+T9QtYGy3zYT20=; b=lklxNG9BD89fklXMbjpy1eiiJW
 HPFp6ymlLBm0mZsPBdCUbqRhvkIJFaOJ20Irj87pE5xWMgIoTL8mHhT77zixiElffgNE6Svo7Z5t+
 vR1FLUgl1ZTyNnNbbfiJiprp5nt5D9ZzFMsSPoTd7kVJVdE9N5CmWqkqw1rgNNrRiX6Y=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWwPe-000000005Oi-26Dc for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:54:58 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso58413655e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 05:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795787688; x=1796392488; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DhOQ57U8wIqOo170QHxJkk80TdXs3+T9QtYGy3zYT20=;
 b=V2/SYu/o+tymw9DPUgB/wTtXs5eIUDE6CFk4AtYxMtMH8MuYtbNLN+SKweIJ5nOfYx
 5uNFgm0NS4BY/sXx3gEaacsms4ElIu7vdpLHDAnfPt9lIXATvjBRRUdglf7OSplB9SdC
 IpkTCOAG9hrp5ezD3xW8U97ewPprG/8T1rw9j9FzO47z+a1acjXoW2RN0BOTrJXv8PvS
 11EN4fPsw3o5la1typ0XSTM8+8jhSJrtkrzc3G6ctle+P5uW5zZa0+iGhzTe+C7kyOmP
 L6XuhuebS9JY3uggEIjnAQ/nErkBh0mRY1rSgoJz4uogHUGrkQJCrgCzmWQLmELF5q1A
 a8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795787688; x=1796392488;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DhOQ57U8wIqOo170QHxJkk80TdXs3+T9QtYGy3zYT20=;
 b=AP4fjr/cw44MNNc3tkOd8u8rcWs/b0SPB2J1M8gYSK1ouxGvKbJLVdYuA8puq1Em+d
 bPNpJsVsGQLjA1lu/+gAeVFDIGpKEw1CLGxCQ3biaWvJaZ8t4IVUfMwDyrQX6RLQalbz
 K7X5u3kdyH2LJ3P7B/5hQ7xo/Ww+3tNVl805PLx+UwW2xiMaRrQDIHLp8eS98fLVU7M7
 6IeEBwxAFw185vEPZdn2nf1zu6Tvr65feNVi5EMTBPeMrrdCojeP4e2nBPejTnO6v/qg
 2td4bw0yREf2ez7ytUHwuKhQ15vGpp2z3ZetG2In6TTdJuH6VT9eqgcYHrS9OP5XoPMA
 KuMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGC+h/3mZBquxBXNUPnqKyQ8e3sbRS7KJTE8rVoyovafVDLQ1an9U6HdPho5HlsAKjySDphcuk6STKHQIf1@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Y53Go+tlIIpIo3pmKqvjkJsTBZSTuWqfRP7GQIRdbkjaN1aLi
 gHpN+yyB0OJxIcjCnK6rFti3orfd3Y9Xa8SjgzBBJl642DmMlY0gXGa6QrKQwppFU8wqirSV+aK
 bb7wRYIoAtD2gqNPT2KebNC3NVGbTlE3FW4hjl7OkCMQwBh2/55JAib1ji22jGden5zDT
X-Gm-Gg: AZFdTZdEPtWyvdpoYvNlldvBc6vSf9JKfVlGnm+lA7ibuzMSFyE/nlFN//ISj3PFoA8
 yIo40uZTZoNsDlr+zp0Qp3CqqQxB9zpDtVQcuNp49vsFDIC9UDjHMCB6YSdMPj8VPWo3xT/5U9i
 pigHy5BqxUXvROayVdl6LZTIGbPfNNX5mp+H3D28F+O55dAJZE0MF36gNK6oOg6xCAFsGsgmN3/
 b9ll/pksMTA7Z15VjbrbmSnp3PGhbnwBwjdKGhObxLaSXoZQu+74gryW1DyN+Qzl6ykqWYYaOFX
 cF5hpTMqZKMJBeu0GrlBzOvTxvEU/n2mkbtAtkdD2NOKZA6IfM41UcD1wHQFEE4AkxJVxEkDtIY
 1EDGuuehphiZw5/vAS4IvmsYcAg8nws06bZT+zsJwpt3A/jJiVxM+9Lc4ihLqyOQFmEzYCYHxo1
 zehOc5U6M/LvR8ibEEkjeCHFxlkFnsmZzVzWspHI+qpB05GC9LAeK0JCe/INrSHybFJtrOqGiIW
 QddFJxyG9hBri1c4HhyM318Dam9XCnZCG+GieglR3T8sWd8r79QO8bPsV7DtxlQEG7twEIPwLxe
 k6E0QHpIygDjWzFIwhlb7mGhpqTtLPCaN3oz0XNp+ZNKhk2VsTcu0FaaEvC6epU1Lxn2VQDixtj
 iwW62El1m48qdvrjQNP0jJamzfZmSZaMUHTSufu06VzBaKe3DwavhO3nobq9FXgEHsMCaPO2Uyh
 aRP6rWEuLDMT7tLHE=
X-Received: by 2002:a05:600c:1115:b0:4bb:a602:6c8b with SMTP id
 5b1f17b1804b1-4bba60271damr132583445e9.14.1795787687763; 
 Fri, 27 Nov 2026 05:54:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989e3sm47724831f8f.52.2026.11.27.05.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 05:54:47 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 13:54:46 +0000
To: Alejandro <alepacheco99@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
X-Gerrit-Change-Number: 2002
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2002?usp=email>
X-Gerrit-Commit: 7804ba8b301e89c1727251a5ee3bf3f4ad5f55e7
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 13:54:46 +0000
In-Reply-To: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
References: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU0MDY4MDAwLkkzNzljMzZlMTU1NzE3OGQyMmQzZWUyN2NkNmVkNTFiNWMzYTJlNzkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <252d2096aac530359551e6fcd2f6cc75199f3350-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xWwPe-000000005Oi-26Dc
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep the outgoing
 control packet in a buffer owned by tls_multi
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
 alepacheco99@gmail.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, lstipakov@gmail.com,
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1958790958407054541=="
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1958790958407054541==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rF9RaPNITD4="; charset=UTF-8

--rF9RaPNITD4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Alejandro, Antonio Quartulli, Arne Sc=
hwabe, Gert Doering, Lev Stipakov, Steffan Karger=2E

Frank Lichtenheld has=
 posted comments on this change by Alejandro=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2002?usp=3Demail )

Change subject: Keep the outgoing co=
ntrol packet in a buffer owned by tls_multi
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Build-Request+1


-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed=
51b5c3a2e793
Gerrit-Change-Number: 2002
Gerrit-PatchSet: 3
Gerrit-Owner: Al=
ejandro <alepacheco99@gmail=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <anto=
nio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Lev Stipako=
v <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Alejandro <alepacheco99@gmail=2Ecom>
Gerrit-Attention: Lev Stipakov <lsti=
pakov@gmail=2Ecom>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit-Attention: Steffan Karger <steffan@karger=2Eme>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Fri, 27 Nov 2026 13:54:4=
6 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--rF9RaPNITD4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Alejandro, Antonio Quartulli, Arne Schwabe, Gert Doer=
ing, Lev Stipakov, Steffan Karger=2E </p>
<p>Frank Lichtenheld has posted c=
omments on this change by Alejandro=2E</p><p>Patch set 3:<span style=3D"bor=
der-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgro=
und-color: #d4ffd4;">Build-Request +1</span></p><p><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">View Change</a></p><ul styl=
e=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">change 2002</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I379c36e1=
557178d22d3ee27cd6ed51b5c3a2e793 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 2002 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: Alejandro &lt;alepacheco=
99@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ant=
onio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Alejandro &lt;ale=
pacheco99@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Steffan Karger &lt;=
steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 1=
3:54:46 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></h=
tml>
--rF9RaPNITD4=--


--===============1958790958407054541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1958790958407054541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1958790958407054541==--

