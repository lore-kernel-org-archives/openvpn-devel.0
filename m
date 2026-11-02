Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E92F606A329
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=V/7CH9J2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VSGloEa5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FHqOChGT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NU2UtvDG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7YWQRVm1ORxpIvH+g5LD1Aw4x07J509Uf0OyyahBjT0=; b=V/7CH9J2qYJgEyzKk9qv7l/9LG
	16JYhI0GjzZeU0Ka6XCHq+iy9vgU7YkGeiRcVSeXDT2GklH7kJFRNlPoZQCQbgrQcL4Bb0UtdeBnX
	O6w4PGJGeYNX2TnG/Ccoquc6YZhESO/BTrABd9AX/rifhyWq+X47WgMfQExYCocrkqTE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNnzr-000000000tS-2Kmr;
	Mon, 02 Nov 2026 09:06:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNnzZ-000000000sO-2KOR
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:06:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZwRxPYjDCh9cWRrsH/90c/jY1m4KaQCjWWubrYTOeJ8=; b=VSGloEa5GC3hcEtHCAbKFMv2fz
 djNtZ0Ev7ZjS6S3LDsQgvAn5JGQi981R6tSJUhGTPoBRlRpm0k/a9Z/X8C/736alBhQ5XjHCM1U5I
 CwtBQgDDpSHCgF4ivxe/cYpY3mwqnTjClP1RYjg7HKwm9XXvdvX1YWg6jb7/lV9LVU74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZwRxPYjDCh9cWRrsH/90c/jY1m4KaQCjWWubrYTOeJ8=; b=FHqOChGTRPuLZDvP4uaQ14y6qf
 5+T5ycQMXZsU8KaBi5cYylGgVsTIyRbYoVVPuqHJ8KXZ/zvsl9pEkj/0TdooG4sJBzcUKpAvsP5LC
 vRUfyVMmvlYHHx3Qd4KtmUePNkYYdk3mzqFIi0dVwkiRtlXVLRzojFLKePLWZEJRmUko=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNnzU-000000000Da-1fKi for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:06:10 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so28980525e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 01:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793610362; x=1794215162; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZwRxPYjDCh9cWRrsH/90c/jY1m4KaQCjWWubrYTOeJ8=;
 b=NU2UtvDGhbnSTQO3EzB9S8RUP/mnTR4hGO7HS/lGFprfB/Phe42xClcM3Ar3VVmAcq
 GZyTNrNrrOYICuOmDpaIgKI+aKI95AEsgEfJ9S6Td7qMEinct9KKLPdDa//Pt9Gzw2bg
 u0IxPf6wCGi265XwcmIhvloBY9u54hPDhnc3H/21RoLWiwW/Vel0l0FGWMdmpWSEBsij
 6cuBY8bqgT5cFmZEhlgc74+aTE6RSEGcjDPNPTNGq27b+m0RjSVuuVijzYMYAVlE+4sW
 O7kbrX+Xhogc5oMYyVap+ctAgO3+woV+hqrJjWgP7fkhDFWKS7EW+lfRVoyb5iAL1yEL
 4Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793610362; x=1794215162;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZwRxPYjDCh9cWRrsH/90c/jY1m4KaQCjWWubrYTOeJ8=;
 b=bi3SqIYooXasb1b84jxxn7JUbjCwJGpUf89rs7xTZBrihHEMv4qiF7tCc65hhp+mSr
 W1cp9BcVVjcgVUXwbZMhwG+97N9/07tK5L82ad2lbuKAhOF6MA4eZZ5BKEeRXA8hyTZp
 C5TqqNfxDouAIZbRCyAguNjgnr51m9KOlW9RYoO1oVMw0rlt7wwYc82BIQrvTpf6aVsi
 8u4K/xQvCyTvBrNn7Lhwigyq42zYoGouSkp4u+Qqc+mcXG8EzTrVQ8aKVN+k4pxSDlfU
 EXSiCXtFMSN+TBrUuS6uAg6cyHxP7SmVcXJM0FDoKPbTWBrvZ8mnHpuD8c1EKy2PUkre
 QOqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzf5iWYXwSpZ0HvXv9pn/yMFhIKoAEc6yddclhFI1dhkPpQlMCXbaIrDnB1N4orI1TrrJSmXuF4PR+6JCJw@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL1ksG9nvfdFZcCtLcZ7WAX7vYK23FZVA+l6oO4WjjZQ3zC3AUs
 RKhsKICEZo01qoxZ4nSPYumuqI6gn6vYfcS37ukcMqUQfszEzvy368eh4ceIsiGYYBO3UjCLdzp
 nAfPfFOvu97Dnk7GJuW2lJE4voTdYjcIsa/Oyge65zW/GVQeoVqeZSlRZBsH14U4zcFydTaslqD
 mZ8HfPVQ==
X-Gm-Gg: AYBFou1HJPSxFz79vwzs9111T4GChfyRxM7UwenJz6HUCcFsl1scIyUcxPOKFchmA+Q
 1mgJTcb0ssn+S3Ofx1FKMdmhk8PhrN0r3ygMQzseFUai124d/m3J6d0+Q0OsKHkxAeHh3pMTdDI
 vTOYcT0IDJ6s6k8nBMhRh5Qb1WoRl7RVYs3zCeLkoq4vAzZIEok033URUVSJRhnpn638DoH9vI2
 2NTIhd8dVgxk3ADqUJDlf65tfQID4WwTV3KHwQEd+0j56M2JGEYuhtpnqNzpYQp4fwksYsgmNn4
 ZMAad9vntl2OTqoHEqghz9PdqHCwiyf6Wpvon0ExYY+nrg72dGoR1hShXnC/udcJ0WKKuzYsldA
 jlK5yr+QSUaswKnBtz+D36y48sg4RnMT5gAgO/XIkac7vzDSQDxT5+t/IazPUulmZ8ZXz2On0ye
 Ps81cM8pT1hSrO5/tWme/O8hSjmDArYvaJFXIy4MMbEa7oxVee16lxDNktvBAUA2WTrnknxjNfP
 06FKwROOm6KOLrJFcZFEfEC61h6WFD1RGO6d07dOYRHED8BHOSHAJgl8hO1YVv94qIas99SbGdV
 Nd398sYlg/B8cDYJhgdf+JqOTdcDHmpfY4YzyX53Xa3tCsrYi0pH11csHhcl9rV2oUCZaJ2P1qO
 SmB5HQDprslqUZKGW1JOBgc+FP6kiotILN3oH6ptNtNTQzKof+elhh4Di2jCboIwIa1SFCLPQx0
 Sq8fJ7Z+QBa0afzw==
X-Received: by 2002:a05:600c:83c5:b0:4a1:f377:5c75 with SMTP id
 5b1f17b1804b1-4ac19329ea4mr188282145e9.33.1793610361501; 
 Mon, 02 Nov 2026 01:06:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a66caefsm208166555e9.5.2026.11.02.01.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:06:00 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 09:05:59 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
X-Gerrit-Change-Number: 2076
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2076?usp=email>
X-Gerrit-Commit: f3971fc06ca8892e990f6836769d6f73ba3be61d
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 09:05:59 +0000
In-Reply-To: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
References: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzU2MDAwLkliNWViMjRiMTU2YWNiNWE5OWM2MTQwNTBmYjFiZDY0ZmU0NmQ4YjUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ca6f2d9286ce23bb0ee75942ae839452272cbbc6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNnzU-000000000Da-1fKi
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth_token: Wipe
 the server secret key after loading it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, hansaemw@gmail.com, gert@greenie.muc.de
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3157632966949728874=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3157632966949728874==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/HqQ5mQqA7o="; charset=UTF-8

--/HqQ5mQqA7o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, Hansaem W=
i=2E

Steffan Karger has posted comments on this change by Hansaem Wi=2E ( =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail )

Change subje=
ct: auth_token: Wipe the server secret key after loading it
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5eb24b156acb5a99=
c614050fb1bd64fe46d8b52
Gerrit-Change-Number: 2076
Gerrit-PatchSet: 2
Gerri=
t-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emu=
c=2Ede>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Han=
saem Wi <hansaemw@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Ge=
rrit-Comment-Date: Mon, 02 Nov 2026 09:05:59 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--/HqQ5mQqA7o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, Hansaem Wi=2E </p>
<p>Ste=
ffan Karger has posted comments on this change by Hansaem Wi=2E</p><p>Patch=
 set 2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 =
2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail">View=
 Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Dema=
il">change 2076</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2076?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2076 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Han=
saem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Kar=
ger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Hansaem Wi &lt;hansaemw@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 09:05:59 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--/HqQ5mQqA7o=--


--===============3157632966949728874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3157632966949728874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3157632966949728874==--

