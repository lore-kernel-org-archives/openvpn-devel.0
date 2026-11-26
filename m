Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBE606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=isp9e+tA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RbLxQ16B;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jDS2CFlJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SwGFnXEg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eFQk/jTXTCZoJ5dZbvfEa5E9D97jwAlahnL5K/icwL0=; b=isp9e+tAAyB4DV2fnK1d+o2bUD
	cEwqOPzLceUhe7k9AogJjw945zJGFnWrlARc1pN3KSjq+uoLxVjZRpyyr2TmAeZa6kVJTI8AINaQK
	AnhTNfzvgjPdJhlOj+LaQ459i24Ptkstfl2m9drXukgeTHIikW6kT/ViOhKZK2EMs5tA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWTnX-000000004ym-2V9I;
	Thu, 26 Nov 2026 07:21:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWTnW-000000004yf-3NLs
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 07:21:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vdrMPvDaqrsHFLgkziyNbegwhju/OmNR0eIDAHUvDdw=; b=RbLxQ16Bc83ijzdiNFXCyifMgT
 Nj9RLIslJ0pk/chJLirCV9wsE0b1o2ZR6Ul6YSxUTjid8RTwaCzx026SoWhJjaP1ls5BLITGiFTAE
 UBbpuJZsQ1k1yWTmkql6g3BgTQzFL7coeG8ovNP5TR03nujKwF5wHWsydsu6yzyjSf7A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vdrMPvDaqrsHFLgkziyNbegwhju/OmNR0eIDAHUvDdw=; b=jDS2CFlJxUUnGqHInoHjO/XmTd
 k2Eigki3lTAGdEdZGoIBmKJCFGxeF4p0ntd+ILKghnNr3r/j6VlJx2DIfoDCPVF5wSKbw5jbNpLaD
 NMilfXXrrvGj1j7f+FmMlTRqxRDidZpm8LF78nbtWeBqQL76YSjQ0eFTgUq5WWVpvA9c=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWTnV-0000000085E-0cOi for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 07:21:38 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so51268145e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 23:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795677690; x=1796282490; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vdrMPvDaqrsHFLgkziyNbegwhju/OmNR0eIDAHUvDdw=;
 b=SwGFnXEgCCbdrYdTx0+Q43k54+4F9akIOGPMzLS3DTnrHQki1h/XFxA/wpA427Qv0l
 5dh4XcwY4PPsRvShrJ/VmVV0xRjlSeRpYy5vUVlOXCREpDtO+BgUr/Dgbj9gIq/AJbM6
 DOjxIBeFmqSKtKDkXQiuzSps/I9iLT1HlZ3JyWg9iiwNMzakBz5P+BOcm60u8KpWsOWo
 6CCRBmJmlyJHOmgULWrxblKNtDE5pqFMcNuKEQMJIOs93XOvSjIVKj4ex51e32tYNMHx
 6RMQcjBN1l9f6MzV/ss4duYKBJm65E0ueGxlNij/iN/Bc87mXNqhhYmlw0W8AyGKH2Lp
 kF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795677690; x=1796282490;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vdrMPvDaqrsHFLgkziyNbegwhju/OmNR0eIDAHUvDdw=;
 b=h6SoI3c70dl7ULUSPx6s0DVfAsu1eIOoOmVeKDyDoWtYIPApa9egdccr4S8flKvFGR
 Y0miF2KjoWQC6PyqGdTsKOlKoZSobjfDeVOYNkkHJ5M+9/52SyK+/nqTxwNdDtAbdVUq
 e4SC88RHyUI7nL2OryOllc+uT//zyt1YvWLYC/j33e7fch2lposEIHrtSYkZtG9aREVV
 6etgUjOiPcS9MeafDWmymmZsZbM07/3K4G+Vo/FHpxirWNKNk4rzqs78wAVNdoWlswT8
 7tQF88pUixmFaO/YqPXUaddVXCNMVa8tzKCxNptGrw0450m1TKGiHAAkAVG5M+xkllQr
 VmEw==
X-Forwarded-Encrypted: i=1;
 AL+hErHOUrHdEaKj52NflCjK0qjy8QQDCkT/1iYNLgSzqljQ+z7UbHIplePQXpbtESqugKG3vJAZC9/YyW9oCeHn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+8ig82BB726fNbkLDTi9EdFAbuk4FqhpOE+EztesbN5B/jnmp/
 +utx9it0gLLFEMB2PPY/4XzsnyjeS5608JZYlO4GrgLYFYaWwV96rZFna6y4yaBV8SKfzb/iU2a
 tuz7MuMWH2hppCKfrDslnLPcAEwo1JCkk5mqWhp9G6i59E91vd/4bDlhO5Is3n06zHHSymtYP/o
 0tEDKYNw==
X-Gm-Gg: AZFdTZce7pAmo/TwL0ks/XKPaPIXvLwpVhNAx3fqckO2KZqXXkKmPgGJgo2K4FwP4oY
 Uejs2Bkc49gILX+U1T/uuoP2fCM1YA/ucJtshMcZthzaCnfkGXw5BD7bIPOIwYKX5Y3PlBMvV9G
 WjpxWyJw8mgDKRnPOrFyPTMJCvlPbUDoBzRYqRkZnvRqkppzF9kZNprSip0zc4iCHDD4sFbWDXk
 nvckHoizBip5x8QiFd/wNdTgU6lOI30gM1J4rth9WFY863uC582Lod86dgsiIGdiSe+s+9wmjPN
 1sjQnfLyc5wiCguKtV37nqTZG7dLwpNQcfCmS5951c9X2o4Ev4uyyyHYaH7Von+Qyfi6ff/jWs9
 3k02aiKZmSyNu3ScT2Q//E+XJLB8VVwsoXHBQzEkANNlDnRXhYCEGfpKkEwu51ByxFNJZ7yVsul
 TyC7TiNer6M0tv4OQzOb7xzEfwH+kRPEzI79yk1Zq+cisUWgaD35Lgz0mw1+GWwsVV8M06bNrzF
 7IUzNYrzY90y0ShtqBdbxHVhrwI9UikSpQu/rAz0sFnGjqiPtFOvFwurgOxTjjeW6s4i1cFcOsI
 esir8SLHcDRHMGFSKD/Qlog4s02F4EAauMONapHJRieWYEvM8RvyEpA+azc30kHtpgrlyP5n46w
 BOd8GKvcxktMQR20AjFSeI5QRlJpC5i/DCfUA8odinvahu4YxzTv2vXCWQ6RCpgmj6QbLHaYxfr
 s3iBybyWZoj3pnwKM=
X-Received: by 2002:a05:600c:3b8a:b0:4bb:76d9:f81a with SMTP id
 5b1f17b1804b1-4bb88824fc8mr427654865e9.34.1795677690401; 
 Wed, 25 Nov 2026 23:21:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm598749035e9.3.2026.11.25.23.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 23:21:30 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 07:21:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
X-Gerrit-Change-Number: 2349
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2349?usp=email>
X-Gerrit-Commit: 8e2bca57b9c422b8c104ad665f8186cd65a93fe5
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 07:21:28 +0000
In-Reply-To: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
References: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkk1ODQ3ZDYwMmEwMjQwNDRkOTEwOWY1MjFkZTc4ODVkNTVkMjhhOTY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea094b2fe0a072150801eb0c98df17c2a2f94170-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWTnV-0000000085E-0cOi
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: restrict dns
 var names and values in the updown runner
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4757844555858007014=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4757844555858007014==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dOAKJNvNG6c="; charset=UTF-8

--dOAKJNvNG6c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail )

Change subject: dns:=
 restrict dns var names and values in the updown runner
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5847d602a024044d91=
09f521de7885d55d28a968
Gerrit-Change-Number: 2349
Gerrit-PatchSet: 2
Gerrit=
-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Da=
te: Thu, 26 Nov 2026 07:21:28 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--dOAKJNvNG6c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 2:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail">ch=
ange 2349</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I5847d602a024044d9109f521de7885d55d28a968 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2349 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hu=
nd &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Thu, 26 Nov 2026 07:21:28 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--dOAKJNvNG6c=--


--===============4757844555858007014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4757844555858007014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4757844555858007014==--

