Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831F5606A835
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kDG+L/BQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ReGuwoyn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LkZEHytz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NPJ5zLXm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XoZsenG1xF3yff6lcw+MxKZeUt0gh2k/EPTE/JuIIJA=; b=kDG+L/BQk2IDNCshM05xdvvUj4
	fRt2AGYSnb95bynIcu+JOQYQcYaRLC4PQX91jFygnZQenRyG8lOPnv5x8Mw4bjYdpTzpN+/sKm1Ej
	TnrwitXW26po3RjY6Ho3I0sYRY8C8Qb6dcC5PP6uv4iMibTF1pOK+MnrfHquWklvGoQs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUSpr-000000004is-2U0s;
	Fri, 20 Nov 2026 17:55:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUSpp-000000004il-2NEg
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 17:55:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l3NI82KVFpUyMFZEZUomSFvCKuFrLmyGRQ0HSAVUaB0=; b=ReGuwoynPXotZIx1AszdexP4uF
 AdyAfdbhIQlYIsNS0G8ypPSKoOm9zdN3rl1NFw4PQ2guT3HRKfoftyq5nFZ3MH3Z6pgvTwFzSmD3g
 oP4acutut1kHKzoSVTuaxBy7Fwh513vawKFXIO0aI031G6wkKOjoyOM70Tq3ENZKUH9U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l3NI82KVFpUyMFZEZUomSFvCKuFrLmyGRQ0HSAVUaB0=; b=LkZEHytzU3jPuLTEtjHtkPk/98
 6ANVWNSpKRX+u6LU4a0o2zzwlMDul2+1MJpUa/YmWtCwJr/Z74ZKNJJW3WfcWIPM6F0kefSxXri7r
 SEK/bL6BVU8CL/z72CDeW1eU4Z5ZLvB8KEK/yKlSyYHgudZOwRwUwJqGZ9cdGtscM2LY=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUSpo-000000007Cg-3Vns for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 17:55:41 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so9162485e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795197334; x=1795802134; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l3NI82KVFpUyMFZEZUomSFvCKuFrLmyGRQ0HSAVUaB0=;
 b=NPJ5zLXmVxAnH66AAjx7CDm3defP6xixEB0SbjfuyBSiO/oLdc0L3cpH/aJJ4TtS0N
 a41QU7Mr68FM40zLBiwHXpR9EKlzBTscT9JmKD6PXP8JcgJSW0CyTHe6xXRjWJcuiVJ9
 Pk9UBSOtdppHdCB2gVBJhLHXvT0WqyP+7+blPh0rFWR8pkCQfl5g5M3ep9oobaeyOZwx
 4kQGfJg33SESlDyTWHSY3ZaGaRao2EuKGXoRQoM1tDSvGy6nCLVZvQMaFrdEKJ488+Tx
 7jrLRxvGzxDH6bseZA4izB/3lAw9eqFwzNEZs2dbaRc2e2iXv3yLnW/rcswkBl8N9NAo
 DJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795197334; x=1795802134;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=l3NI82KVFpUyMFZEZUomSFvCKuFrLmyGRQ0HSAVUaB0=;
 b=Rb5uTix+ZkvxrrhLh9W8gfo+aLc1tDsKxbjAnDTT2hHhL8BfHpz4D868AZrWHl7I+c
 YUat3VtwwVFd+aQW8X6iffnF+NI/D1C5o7A/lLkhKeHLs4je1GNuYRD+praIwD6pXk/S
 bgxS6/TEXp3lK7ND/ZX+tqT1a2Y/SyIzT6qY4pHCwZryZMAkuxLP0qkBtI3x6ctp+IG0
 JAiMuvYFgXDakyu5wNRl47OJx+liotjY+Q6JG/HhqoDzte3zlkpgrYQJ8PD2P6BiAPYT
 99fvTiTsQiplmoZDHu4GPd/M/N0Htp3h2PnFFFVrYqjXiJr4MtsAZQwzklsIKPRlHJBk
 P5yA==
X-Forwarded-Encrypted: i=1;
 AL+hErGO711Uz/3iDn6HsiXqyJt9nUYwbblPeVo6kIMaqt8Sz9mDoWqngCYUg+mOzxsm1vobnj6Vh1XjVAH2jzoD@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+O7QJGRV4pofS7NzbRS5UYiMZs71DAVtr2EiRnRiakAdS2Pcy0
 tvFdnbUlxl2/rotN2yxIty6nRNBU0WQ5shuQml5L49dbuCmmub0U2Z6e143cLS+9pU649ZaEOcH
 Bf+2nBiP+sNwmcgGoYLrhPy414Pb0BW3eGyz43esrHkpE+rc4fsGSf5dVAARedmAQ6i121ApfAY
 v8BTOgpA==
X-Gm-Gg: AYBFou2aXHoIH9ZQuRtu8NXdi3QD27649C7Q55MT1AZyaD+RaZkcGcOiEHbq1dF0sSw
 2UBS3XvmqSbJM30Av+bCpTxMAoE+xDUxWMA0niZNqYyc36ULvr5UxWM6coqinzAo5D0bMGNOesQ
 QZ6s05yGNLL7E0iy9bhCJZPYeY5mbU58iNqCZS6Cy0BuSauUAN4SIHwYZeWNuQ0pYl9tvUG6rgh
 PZ3v/OQXj8npzwq0A5BwO1SbLGu1FyKCpTj6qZgdOPtysPClIyY5rdMe0/L4E9SM9T4VhzjuoTW
 hpp8aGyuidRNW6lfSKsC3Cbo/PzrZtnnfMwqu/Cuh3sC1bWT2D79iXPhYwX6ISOtt4SwplkUYjz
 jOFCkqztV+sni/bfCmZrWdHFSvLdUnRpv9ar2LIFUGR70XcnlGeOrP5UAxtEEJu/XjgWv3v0P98
 BMwMNHl4cknojBpIhWDEYSwNEDLXhi78+FBYjTw0jV2P4I+WwTIBjk6ugvywV9MDcBJ/jLrNmoi
 vEZqsKE74RVEurxzFtDOBELH0IAni8RVkV0Nih+bshzp8yV9/GzXXAfzlrzK6QNdnVsCmgWJtmC
 ZktbnVjXgEZkOoPiJFDtbY6KDtyp5FVAdMSSdDVwZpZDhdeW+2MdQ7mSqLgZNVzWWU1g4hOjnL2
 K0wk+vt2+LQELPZLEynfKTpPAhgz+9AYtn8AC4lAWC881QJWV5N+o3dV+X4/ORQfT3DOwrSwgkq
 cWERIrjGL/wuXzjiEiYOY2hD/mGEwyUqDxgsE7
X-Received: by 2002:a05:600c:4e8e:b0:4ba:59fa:510e with SMTP id
 5b1f17b1804b1-4bb8893014dmr88618695e9.23.1795197334142; 
 Fri, 20 Nov 2026 09:55:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb905f1489sm4758775e9.0.2026.11.20.09.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 09:55:33 -0800 (PST)
X-Google-Original-From: "Laptops (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 17:55:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib57d973a2f8ef48c3710f7d034da1a91c64d4755
X-Gerrit-Change-Number: 2035
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2035?usp=email>
X-Gerrit-Commit: 8c8f29f8e1a4275f073b2b9810032d53561f8071
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 17:55:33 +0000
In-Reply-To: <gerrit.1793032811000.Ib57d973a2f8ef48c3710f7d034da1a91c64d4755@gerrit.openvpn.net>
References: <gerrit.1793032811000.Ib57d973a2f8ef48c3710f7d034da1a91c64d4755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDMyODExMDAwLkliNTdkOTczYTJmOGVmNDhjMzcxMGY3ZDAzNGRhMWE5MWM2NGQ0NzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e2cbb466079097c8be834f8485dca3f7acc4f010-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xUSpo-000000007Cg-3Vns
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: add optional
 -fbounds-safety annotations
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Laptops \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: jeff@incrediblybased.co, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Laptops \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0336368654797137415=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0336368654797137415==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="miuoIIjI3Ng="; charset=UTF-8

--miuoIIjI3Ng=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Laptops has posted c=
omments on this change by Laptops=2E ( https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2035?usp=3Demail )

Change subject: buffer: add optional -fbounds-sa=
fety annotations
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2:

Patch Set 2: rebased over Frank's size_t changes to buf=
fer=2Eh (buf_set_write
is now size_t here too), and fixed the --enable-fbou=
nds-safety build on
Linux: glibc doesn't annotate memchr(), so buf_extract_=
field() now forges
the result to a pointer to the one matching byte (with a=
 no-op fallback in
compat=2Eh)=2E Tested on Debian 13: the default gcc buil=
d with --enable-werror
and an --enable-fbounds-safety build (Clang from the=
 Swift 6=2E4 toolchain)
both pass all 17 unit test drivers=2E Happy to reba=
se again if buffer=2Eh
types keep changing=2E


-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2035?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Ib57d973a2f8ef48c3710f7d034da1a91c64d4755
Gerri=
t-Change-Number: 2035
Gerrit-PatchSet: 2
Gerrit-Owner: Laptops <jeff@incred=
iblybased=2Eco>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fr=
i, 20 Nov 2026 17:55:33 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--miuoIIjI3Ng=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Laptops has posted comments o=
n this change by Laptops=2E</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Patch Set 2: rebased over Frank&#39;s size_=
t changes to buffer=2Eh (buf_set_write<br>is now size_t here too), and fixe=
d the --enable-fbounds-safety build on<br>Linux: glibc doesn&#39;t annotate=
 memchr(), so buf_extract_field() now forges<br>the result to a pointer to =
the one matching byte (with a no-op fallback in<br>compat=2Eh)=2E Tested on=
 Debian 13: the default gcc build with --enable-werror<br>and an --enable-f=
bounds-safety build (Clang from the Swift 6=2E4 toolchain)<br>both pass all=
 17 unit test drivers=2E Happy to rebase again if buffer=2Eh<br>types keep =
changing=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/203=
5?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0=
;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2035?usp=3Demail">change 2035</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2035?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>=

<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Id: Ib57d973a2f8ef48c3710f7d034da1a91c64d4755 </=
div>
<div style=3D"display:none"> Gerrit-Change-Number: 2035 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"=
> Gerrit-Owner: Laptops &lt;jeff@incrediblybased=2Eco&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 20 Nov 2026 17:5=
5:33 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--miuoIIjI3Ng=--


--===============0336368654797137415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0336368654797137415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0336368654797137415==--

