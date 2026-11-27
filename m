Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92433606A323
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=R/X6+qoQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lxIHBrQc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h9MjibD6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cucpjKAE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TdahSsMfIa1SZoZeer9/zOqR1jFHsuzo3FcLjZNhI4s=; b=R/X6+qoQfvfsq4mG84Mz77OiCE
	iILHQuns4ERyqfeTFZzcJLz9OeH3DSGlvyrcdHTCfMnQAJ+eXel+qCzXOYvNLmPNBoFh2M7OxnFIm
	2sPVOe9UElVvWYZn5w8gDxSRmrR2xtIf9hwIl8jZA8xzXnJmd2/4wMsU69ixg98Gvxbk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWxRn-000000001hU-0XCT;
	Fri, 27 Nov 2026 15:01:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWxRm-000000001hK-1OSD
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 15:01:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AESWq4Y3QW48tuWn2XqqXNZxGEQVGWWuOZnQuTyL220=; b=lxIHBrQcSQwvwAGVpyHhRh4Ctq
 HAePqhLYv23e7dVEMN68o8R5T2sIuPdD5Z1OG1/n825ch9H8m4XzWK8Nwuy8TQOtNWAdtyQYX/DSj
 yWuCGKAHy69rMfEYxQf4E1kJHJ5i98RXmMHAFyLjnyl4LkPkGoySXuzOs3Vvpz+GOVUU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AESWq4Y3QW48tuWn2XqqXNZxGEQVGWWuOZnQuTyL220=; b=h9MjibD6+AgYj6k8nzLeqY7R7r
 Smd+FRybvZ8ehbAkwFq9OlqZjIBxWll3tAxqya7ww9MRCFGC802E0lKdR1V0NguAjztGSxZWqECII
 8nP0D8kJ3nySCxa6Ixv7+CbPXy1f+7+h23uR66wPxzTir/xJsgAfQ4HQkzkl+IfRJvvM=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWxRj-000000003iS-28Vf for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 15:01:10 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4a32576da88so4761534f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 07:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795791661; x=1796396461; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AESWq4Y3QW48tuWn2XqqXNZxGEQVGWWuOZnQuTyL220=;
 b=cucpjKAETHOwgVXglp4OtlhgrkHgkGkCE4JewpTFzRCQJ9GJu1BSOq0dTvVCAxjvlR
 Ys38U2eIAasBIH02BQ44bG4dmHkiYuNmoTgS2DMjf85PIo/iujFIeOGjBPN7wtUkb5RA
 mFiIhtJg+uV9NwtB1Xcult1dbT9pQM6+LzIX4qcE7wGN6Nta392wlTaK8XoEXCsUApFB
 o8KSJ9HqjWPydJXVkSu/2xmyOJ3Xi4Rr00dLoxh73CsCwtuXFQ378qNfo5eg9WTz84ho
 2nXgTSedTc+DG3QaQ2eRzaE4xHnRqw3paKwhIXyMOzYQ7NIdG4DsTSS4ucmAoZAbgRAb
 f73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795791661; x=1796396461;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AESWq4Y3QW48tuWn2XqqXNZxGEQVGWWuOZnQuTyL220=;
 b=CofbpQYGwixg2e8NexbV+sdgcrzxbqtQPA3cD0seSn598YhUfVZ85d5f4/rsODFKuF
 EbNfdsOAnqpk06sgJ86MW3uT82O2j0JO0wKSPRE3M5ZmtIOpxhDazisVGpDfiPi0MCil
 5QVN8QIEg93AZneA/f90MTQJPsgMgmbulSofKJqZYyJDvaPLYVUGiQPDrxfC+TM4QPTz
 EjC+9EMLxi59HjsAO+yPe2ThPvh5XwOwZ4cHOIqI3BzhIyzbW7GnJnohKtzZC708J3Hf
 07lj6nVukLL6QdoOFc5LCWK2ZTRb/T/0EPEmxtCHuKt1tAKLxC6iuvAqJbUa77XSAt2/
 Rt4g==
X-Forwarded-Encrypted: i=1;
 AL+hErGpkpF0pNNOg9KS7fArSfrM7ObjncE7+M9vzUCTXwC8Pug3bFO9QQgKhdccgn+O+plepU+iThnTOQezxlpy@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9UmWY255d04J60akmLwIDQimAvMgZGGvMOQX6sahJQWieYqbZo
 y8gd7LLAo09kGZ6t9Lc7oPX7PKnPNNY6KMCCi/cdvWiBpGjv5ZZfC0KFOE8l7OySzJUulmlTj0+
 nicEkmnI5yqeb1C2+MO7Yqwdy5Fjy8DibvauWBiuWV+pBJqIl/96YT9+dRF5rjD8mFTC/Jxe1BP
 82AzvFZA==
X-Gm-Gg: AZFdTZc06ofM+KR2SK+jOLtOw0Z888i/ZZkxr1ixGwkWQADATWgLpxb9mhIJDuIYwYM
 56j+JuXPQc6DbdemrBFoj40mNf3zt0U2in3X5550tfN0Ld2icmcpHQAQ45cHgosylBU2YGX0Rk7
 p7iVYTNI7xZhnXttUBSjrul6RsXgqtoj51PMAGzI+8bEvk2vGG+2lsuh45lr17NIwXE7F1EIHHI
 ICip2Gw4DdzRwHxYGlEg0d9noEGYwdhv02Toe0ivYVA4IoRWyYaGMD35gmBC+p4nlO19MtDdQyi
 bsqKHj11S0b6FzOW4A4YDcsg8UzvE0hqPOLA8EOn95RKwuLdlDbA5tr+XPicY5DUQUwJNrILCIH
 feUyM94him/JkL00Koc/YWpPgFUvR3vYm10MTytRMATQI1BfN6TTa/fiToYTRibSH+CaGlOcw3V
 hxS7b3icQRBGyKz17ePfJKtZLmYWP9C+zsAQyiNju6l9pge5z2mwxvEnfoq6WHNOuIZYDWmeAV/
 3bm3SP26P2Tt6+jjZi6+YsV+j26jud+F1/H4FWJf4SKcH3/+F+Z/VnJhzjUg+3W08r5dNPDQKEV
 BY9bYYd6ZbWD1rIuzUNc8C6uDThkM+rVRJnJU4Tkpfq9ZkVNd9xXPH3f7yT6gBkqdLETmtXF70g
 NI8mKVLnQ05RfuT3WZLQ9B3E+YuAUPB995msPgSiUGsawnR3WPTJMVNaum2r/428jOtoQJ09Bky
 lvJYCcDNwpUgJ53GQ=
X-Received: by 2002:a05:6000:1789:b0:491:971a:c568 with SMTP id
 ffacd0b85a97d-4abb3861356mr45643403f8f.10.1795791658962; 
 Fri, 27 Nov 2026 07:00:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6ae2dd55sm46323163f8f.30.2026.11.27.07.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 07:00:58 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 15:00:55 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8a1b576401313f826a188dc40f226726f378066b
X-Gerrit-Change-Number: 2363
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2363?usp=email>
X-Gerrit-Commit: fa5e73dfb6f41ccdcf160708bf09f1b9e485873f
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 15:00:55 +0000
In-Reply-To: <gerrit.1795791294000.I8a1b576401313f826a188dc40f226726f378066b@gerrit.openvpn.net>
References: <gerrit.1795791294000.I8a1b576401313f826a188dc40f226726f378066b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzkxMjk0MDAwLkk4YTFiNTc2NDAxMzEzZjgyNmExODhkYzQwZjIyNjcyNmYzNzgwNjZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9d4a7775730636f42ee58936704913bda0454c97-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWxRj-000000003iS-28Vf
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: xkey_provider: free
 the signing context when sign init fails
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
Content-Type: multipart/mixed; boundary="===============0331156103457224268=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0331156103457224268==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BVgarFQ8ef4="; charset=UTF-8

--BVgarFQ8ef4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail )

Cha=
nge subject: xkey_provider: free the signing context when sign init fails
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=


(1 comment)

File src/openvpn/xkey_provider=2Ec:

https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2363/comment/2434a803_a2412d60?usp=3Demail :
PS1, Line =
1097:     int ret =3D 0;
while we're in the function maybe we can remove th=
e useless assignment here as well?



-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2363?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I8a1b576401313f826a188dc40f226726f378066b
Gerrit-Change-N=
umber: 2363
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 27 Nov 2026 15:00:55 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: No

--BVgarFQ8ef4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/xkey_provide=
r=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2363/comment/2434a803_a2412d60?usp=3De=
mail">Patch Set #1, Line 1097:</a> <code style=3D"font-family:monospace,mon=
ospace">    int ret =3D 0;</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">while we&#39;re in the function maybe=
 we can remove the useless assignment here as well?</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/236=
3?usp=3Demail">change 2363</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2363?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I8a1b576401313f826a188dc40f226726f378066b </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 2363 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit=
-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 15:00:55 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>

</body></html>
--BVgarFQ8ef4=--


--===============0331156103457224268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0331156103457224268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0331156103457224268==--

