Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B1606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jd69DNjK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iADSH/P3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V52SJDmQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Bl0CGZTO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NLzYEazRVaL34axk5foKy8VViRtcyD9uOMhw/L4rsz4=; b=jd69DNjKejB8QMGAKzPUdeD7Ra
	MzCFmPCEpBP5kA3eKHNCyZYBGs0/anwPXir3Z2PmVI0wlPUhRIPlNmvsFm1WgEb09Ia/Y9gUDFhoa
	2RFnI82e/gf6s8o+LSECoyaNjewOdpLPuEFnJSHhJIqmDdIrqAaOlE6aPKocMhhJ++B4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX27l-000000001dD-0ZoR;
	Fri, 27 Nov 2026 20:00:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX27j-000000001d6-1fVC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 20:00:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H/5LogrfCSl9tASh127Q4aX+G3zvkwIBB0kgRLcrPcU=; b=iADSH/P3c23k20YJsFADyor+/6
 +8d1HKdDAa5OxMALkyMJXdQTbbV10Ce0+CLumDJXDE6fJ8mxCznwnecKFxT13v5ylpk16oDu0GRWY
 bIMdMqb204ilvuMV7XAYjCV6nKgioxTLhVi7wyfJICv8OfC8Df4CuhpnKHgtrVYx3K0s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H/5LogrfCSl9tASh127Q4aX+G3zvkwIBB0kgRLcrPcU=; b=V52SJDmQCAe08ZdwQjVu+Kn3yv
 rnl+ZD8CSGdGA0kr/4jf43FPCmIbVlhkyPA0zb3xE439lTI2/ZvGfoVZhnhEfgrOnzjVqIsFGI2Aa
 p0Se2DsrDHY68WETDsWfu/7Ky2XmW1teTJZ3ytYY2sJgjLtvjKgm8M3PpJCxiGkSS+H8=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX27i-000000004bq-0z7P for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 20:00:46 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so82721055e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 12:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795809640; x=1796414440; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H/5LogrfCSl9tASh127Q4aX+G3zvkwIBB0kgRLcrPcU=;
 b=Bl0CGZTOjIUSaIsQa2GCsg4PD7WS8L/FBzbyUTpqQuTtzrDn9C+kVtk5mvSK5A0LtI
 0MmvAy0xRedM8CZB2TS9J+2mNo4ficIyXdx0zlJE+X0E58glsqP8Z887rRy4tipxEYXE
 KpGeCqP1jZ9HnFbyJq1xYPo0DlMKOC4XrqKaxdjsS5FaXp6mxUOO3J/IZINdFKNFAMJQ
 6cbvryPHIRLUnAYpcFwEI4HzhW8R9Oose1UE8CwCgXdklB/pyeSGEtZg0O7g++DHUM/+
 fSCdKvt4i+2HEKrdb7QLFE8j+1jPDS7QtaYMAqZ2JW1GDJcQV81hFX7FAWZrlXJoyUO5
 T9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795809640; x=1796414440;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=H/5LogrfCSl9tASh127Q4aX+G3zvkwIBB0kgRLcrPcU=;
 b=VTPzkp/0x53pLsh95nMNNyL+cD8CImKhKYHA+lF4nWEqS44HL/It4n/40icxS2QRNf
 jal5wHeCELbtoUKAn9KxFscb5sheWAAB5LZnOBDMsdETJY64GYcM8Ua9gDUPIYGw9b1q
 L2NynjBm2cEtltNjXZs+Gs4MmlWF6mdu2jv/LIxOZgLFBoqoT78Au9oncXc9+IV5PpZf
 lCl3kilTMdkRcoNo9w3g9KyNiZKyFLk7vQy93m04Gw29pG5pa7YOIk2m34K3a+OSiOro
 Ea82Eijif32+mz/IY25i+nd4nmcC0kyLGJwmToh+ZOSDW5fLG1EWPYQTsX7MlO8Tog1b
 zERg==
X-Forwarded-Encrypted: i=1;
 AL+hErHsdrr4P7ynewzpNyafHXSDPhLqgO9PXK5cy74Wi3k660O3p2fE9qacvti80sHdL7EGx3fIK/W0xtHVhhyj@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8I2M8+tElLELtK+0xvOpOfEzJPyiONZ2XbjB4S6dhRzsuwowfE
 TFqHJhtvXWoyUagGZZ+b5VhLN3/me5byA7AWBiL7tEhnowNcpptHIKdCb0l1HcLn49HDvjsp4sA
 k7Rw7HjdsprS5tVMbw4H+KcuoAsCSEbBfG/Jo4iddOKG0PoV4QLYiYmMLaS76xdeVzDRb6VokSK
 AkGa2ipw==
X-Gm-Gg: AZFdTZfxkMg4p0jKhfDgp+kUkmSP46qsPRQuruD/hGPVELPMDvHWiRyS6KnyP4gG3lJ
 jwNTUxkItuaAWUQEfdhxctZ+I6VGE5P6m2aaaQaABqnChE5/nM4Qq9sdgt8K4FqnCoy150/zIox
 jn9GrfAyDFGj7Ku1P8mbu24s5wwmpJ4ujqZj3xiogGvabN23yUf5rv2IBnMT5C7+qX4sbcnxc6y
 lUxsF8bqpHJFoWveErlopP72ubAhBsG0lO+LtwVUfF2AOeHBm0xvTRimr2qBmHcses7RanD2KH+
 O917E3xNHoNeqbPcHgNUwVZ0q2kNsQKZaqsY94YyzT2Vda2mpXNe48+CC2KamekIR7cRVP2RjES
 iv8aQBAhZ52TSRrBlL+uij8kjBwKHTkj9X7VEuvF3o64F0IxTLzNNyNZS4ydtJO9KwoZrqqcor7
 dqJepYWepS0o8+o0R8eydLYgfv2/2BDNQG1LT+EFNU+Uu7Xfx392lVv6oNzGG14pTtZdUAS9onS
 Gr/Cv1+yqci72DGVCmlunCvd3KoXWxWWeWmKD/v6qpvqlRDKKrYXGl425zfd9w0yWaT+l0Nt2Kz
 Ft+8+iYWGN+2EuVxz5C1QCEQen6tVwl0QNYF4s9iuJMwABoccASpB4rMalqWUX5pE4Ak7OPvB5O
 afiNfPUGqk3fPn6ADVw5VOb1Ck/GfoGj1K1dmGIPCzb5LbxXLOKAJeyL+ajotWRH2Mswvcv/3db
 TNFVSPeCcMErpG9u0=
X-Received: by 2002:a05:600c:5246:b0:4bb:60ba:49e0 with SMTP id
 5b1f17b1804b1-4bb88930707mr554192275e9.26.1795809639556; 
 Fri, 27 Nov 2026 12:00:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm755050145e9.2.2026.11.27.12.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:00:39 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 20:00:37 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408
X-Gerrit-Change-Number: 2360
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2360?usp=email>
X-Gerrit-Commit: b0f799c435a2d85b25f3453c4da825ee8f64ac87
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 20:00:37 +0000
In-Reply-To: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
References: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Nzc5MDExMDAwLkliMjBmNDk2NWYyNTQ3MmY0N2I5ODk4MWQ1NGVhZjRlMjI2OWQ3NDA4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2b6dba805b8e897b47af69a4dbc74ace1cf428de-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX27i-000000004bq-0z7P
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: preserve
 --dns-updown across PUSH_UPDATE
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 marco@mandelbit.com, razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2225501544696675211=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2225501544696675211==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mg06dfieRH0="; charset=UTF-8

--mg06dfieRH0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

Heiko H=
und has posted comments on this change by Marco Baffo=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail )

Change subject: options: p=
reserve --dns-updown across PUSH_UPDATE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Patchset:

PS2: 
S=
houldn't this work with prepull data like the regular pull?



-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Ib20f4965f25472f47b98981d54eaf4e=
2269d7408
Gerrit-Change-Number: 2360
Gerrit-PatchSet: 2
Gerrit-Owner: Marco=
 Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Marco Baff=
o <marco@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Comment-Date: Fri, 27 Nov 2026 20:00:37 +0000
Gerrit-HasC=
omments: Yes
Gerrit-Has-Labels: No

--mg06dfieRH0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>Heiko Hund has p=
osted comments on this change by Marco Baffo=2E</p><p><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail">View Change</a></p><p>1 =
comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Shouldn&#39;t this work with =
prepull data like the regular pull?</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail">c=
hange 2360</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2360 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Ba=
ffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Heiko Hund &lt=
;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Marco Baffo &lt;marco@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Fri, 27 Nov 2026 20:00:37 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>

</body></html>
--mg06dfieRH0=--


--===============2225501544696675211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2225501544696675211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2225501544696675211==--

