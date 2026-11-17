Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1CD606A88B
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XwbxWKeF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WR0VfKYv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W6hkW0Dz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HyZlFVnM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VYaNVbiRwaF70H8QvR5y66xwdCzUrjuFX5s43qf2LRg=; b=XwbxWKeFG+AdfqU/z64ReU2kom
	/JVUNQ7u1/3JvuHyh0xDWEnF38mrhrP9Q76tXx584Lh9nkYOtvhc0dbEssvSuRvjPQnEOmvIloozW
	Ic0xCvzE0MiHyHFoQHodwqPjvCAbWUng1AzU+x0D17o7jQIKPxVx8hg2eEnyr0bHocL8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTMmP-0000000021o-3w4s;
	Tue, 17 Nov 2026 17:15:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTMmN-0000000021f-28cv
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:15:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2z5wQvhrwY0HZQOMVPA5boZ9DlCNsxmTu+NrSFdtKOU=; b=WR0VfKYvZ+N9PEjRhGbJL2n80D
 fCydzedm/aC3F5gJk4sJjRrfm44o+wT8MZeMASlp46or5ozhZl1hD7Wp/vk9p99t90L2l3CtvqOXX
 4MPb/pUqt4Va7HbRNjKU35Jyujo44EkixvQ34MADUcQRzyxLaIELEwBuSrGDLz2HvA8Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2z5wQvhrwY0HZQOMVPA5boZ9DlCNsxmTu+NrSFdtKOU=; b=W6hkW0DzOamVGecM/Koc/9E4Jm
 1Qg8VGAsXPVqy82k+vknBfwehlBVYfTjpkMsmZDwJ3NFW7n3cudxIp3USIW5EvQYg+Hv7n0ogiYvb
 GgVudmC11i4fALIr1nzYb9BYP/MQwSOpTcUNeY0N0z2kBMDW5TeZ0GVMzldNjuJ+ChR8=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTMmM-0000000049o-0Jjp for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:15:35 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso1062205e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794935727; x=1795540527; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2z5wQvhrwY0HZQOMVPA5boZ9DlCNsxmTu+NrSFdtKOU=;
 b=HyZlFVnMDrB82Jga54zMmO8OL2DfPdxfI6y/IdYqsYUnd5cXQlGhozLMlzLFOvGsN5
 r7DLIfvRdTR6oXQZXLRFgFtMnq8FLboDQfUqxKjXyKcRRAkcbIaDjgp+FC6k/vTpVIwr
 IYocGhtwFM6jIXWquXyJ1qAZ7akPAtpz3/UdzxNfOHTAM0VGFtJThjTT720Dyn/+MKiC
 q/5RgwpLxl+lBu8geZx4Zd17sP3nrsYtsDMg0QafIYZ6PoBH2nDg2QJ1dGXZV0DJ97Et
 ITz8oE4vGKvge8U6bmGXdY40hZYkiY3RXZVdFo3XPohgj5MInkbPHx4EOKB9NA1qclkP
 gdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794935727; x=1795540527;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2z5wQvhrwY0HZQOMVPA5boZ9DlCNsxmTu+NrSFdtKOU=;
 b=SrOERWrkWP6XAdU7NBymc02HuapUeadwqAFicHB9sphtkymZtasE5n2r4l/OHukrnD
 0X985ZEAwrAknzLbEFFsfuHYmspfnnYQb5e2vnNLz/+GpLi+yybdukspjY1VwxD0Y0H3
 wSXomqSDv7MID+75AIXPfkuirn3eis0M6cJ4QsDQGazltfYuytkYQErHlR/TWYfxcL5A
 N8KllQ++gV6qOyt262ZsW9OoU3iydNrWNOGgCPJyLsFRuUpLLp1I6v3nD31SIbLlSFTC
 u7ZTZViOwwXJgr1Wcu/8RNOFzIDnpVrJR+ArQzFks/NvKkOlCNhWP72YwOV0nPg+yXYf
 cYjw==
X-Forwarded-Encrypted: i=1;
 AL+hErHeJ9n7xtYTpXrA31fxHq5CEJf2wdG5Rf+CrqxzsL/CTkMTZAlwPl4k2zr9dFNNnI0KXXrF3Nf/ytoiw69+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9xwfRQ0k9REvBWyv6zkUQMcfj4xGKgwCzXtI+JRVFv2U3g0dH0
 mKnF6moQQ8Hi7DPqEbqXbYrw+2Urvfth70toPgeEHuNvW3jTJRBontxY7abNBKHrugrMBhWjPv/
 09vmsUdatn3gb+DXMwQWq1i121Mjvn57s+34X1hxbkUUGZ1+x2cxhJaH6aOAZ7Jhl+xRX
X-Gm-Gg: AYBFou3elOko1lRRuaiPyVGej7NJnwVsaKvFstQGkmlLEPYLX0YLbLnOydWfEdtuW2O
 JaBWerfroxJ4zDsoE6AedOY7dC6ybNTPwkR5vjpeaFrIWsC5V9OzSrL55VnJD2vtyDj/6IFOSry
 bUx9O2e78eODcO4JxS1KgSjgq8tulos2V+doPELNX5jdUWehKeIB0wyK5cSLj72OvOpm0UBytkG
 VP7dKzXli7k080ykPKyglJ0ocKvEk4io5Ptr7sHQJNwBgmudcyaD7C4c4BN//n/Ktxw8oBV4XNG
 jzrz44w3BewoY1GE7b+QO5mBCub6qqV6QQAk7sOK2r1d2Q3uhJC9AXJLUtsSL3csj6gV6O1bayr
 Prq2Xi/PsiV5s8z1E8PWX0AdfEnjVRtCKMguULkqQylBxAkvYVjrEbUbeQbOloervQSAGStPgRT
 VDNkf56BCrXyRf1V+W1DGEv/l4ZIUDQ7+8D73J0hfooylt0WM98SvB3jZZob6fURT/qb5HdRSaW
 lJgz6xGNQxEMdGGgPTYM9OFPNzgKwSJ/cMuDKiDKprhExf6CjvIJ8s+JYFq/LHnAUJt8KpFFuCA
 XTbZSen427xXILaxa+xHzpfFm5TicgWTeue/HDVCJ1eSME4H64ptzbzDl8s7JVmhJRMAjlc7h8q
 HG9k8gg1NsUnZVwOgGGG9flW5ArsjFpHK14g926uGVWpM4ntzrsVdbL5Rs5KFMJFny9VhFZnNu6
 IDmC/7bxE9N/CEmI8=
X-Received: by 2002:a05:600c:1142:b0:4a3:59ee:86b with SMTP id
 5b1f17b1804b1-4bb5f39cdb6mr181313995e9.4.1794935727306; 
 Tue, 17 Nov 2026 09:15:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783e9288sm82939855e9.15.2026.11.17.09.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:15:27 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 17:15:25 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c
X-Gerrit-Change-Number: 2214
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2214?usp=email>
X-Gerrit-Commit: 3990c07cdf21e87fd14872c86d1633ee38f86ed8
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 17:15:25 +0000
In-Reply-To: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
References: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTM0OTkyMDAwLkkzMzEyM2ZlNjIxNTEyMzc2NDEwNzY1MDMxZmM5YWU2OGNkZDkxYTZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <317a3b2bf58a598a4b6ff2886aba43eec2be7081-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTMmM-0000000049o-0Jjp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_openssl: fix
 -Wsign-conversion in tls_ctx_set_tls_groups()
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
Content-Type: multipart/mixed; boundary="===============4025899744711953846=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4025899744711953846==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XBd3rpKJrUs="; charset=UTF-8

--XBd3rpKJrUs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Demail )

Cha=
nge subject: ssl_openssl: fix -Wsign-conversion in tls_ctx_set_tls_groups()=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2214?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I33123fe621512376410765031fc9ae68cdd91a6c
Gerrit-Change-Number: 2214
Gerrit=
-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Tue, 17 Nov 2026 17:15:25 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--XBd3rpKJrUs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?=
usp=3Demail">change 2214</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2214?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2214 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 17:15:25 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--XBd3rpKJrUs=--


--===============4025899744711953846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4025899744711953846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4025899744711953846==--

