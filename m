Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E17CC43327
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Q00Y/sh6O1fCxCQVTvUo4qHjj6S4Q8yLR/X/XCwQ0w=; b=jXQpmc4xJoDW0rXLPW4fcQhihx
	5V795BO6fxdc2qaTsnJP1Jkz7++8NGAYrEWn9xGInL+BQxupbydGkcwtW0JI+1qpSLW/VzQcjsmKZ
	sEnZZo69EvbGBZXWvKQVKJt9Vo+u4IheJ1/E2VmoMVBSwWe3NHfnprumf1KpSFIiRy6o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weBG3-0003Ml-Aw;
	Mon, 29 Jun 2026 12:38:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weBFz-0003MT-Gl
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:38:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JcvGwtBsihPrDebpLUWJMDfK6+je1oqm2u4vCGhjN6g=; b=ZzQimjjL+6kTazCDInC6FY6Q6b
 T6pqt3ZT3hKdlCtQ4NbWN0vTvMJ/E6U3uIM9F73mjIusanquT99n475T4wEb8nZHQYYyh0XpAqUPl
 zSnzwOa8BtMq8ZgUdfX3X21OgpqJ6kLu6GMt33lkr3KXrBOaqmaeBE7q2XH/lyJnQZH4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JcvGwtBsihPrDebpLUWJMDfK6+je1oqm2u4vCGhjN6g=; b=L
 wj71dIJpwzsgeKCU3bJZmv2zdxy8E7Lkk8eAQkVhYPoXSvI6IoiQwGFjfAdyYlXZCsfyPdJN+wD/j
 0ag6bv1/pK5xMdHuddRm4ta9JtnUOMuEbglrmGZCNiKifXccFZYWECmgkGapD2QQ5H+7IcQlSPriW
 KvHl/JFYdgWL901Q=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weBFh-0003Oe-1t for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:38:18 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493ad116e05so6196175e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 05:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782736691; x=1783341491; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JcvGwtBsihPrDebpLUWJMDfK6+je1oqm2u4vCGhjN6g=;
 b=C0tiS+t++s3zDc2VcL1pLeolU7xsKNsuvzlA4dM6hoOWkatgc3jqHqcu7hnJZJLkV2
 a0EEE6yIT1A/xOntEs8nuKAJ/LhqF7J144cLnhfQxQgj4adE+dOo6eEy8gfCD/u+Kvr0
 Vii16+RSTI6eKWFaEJWG3hMg+c/MgowPYC4EV6paworJYPoP1pJNYAZ0J/Q3k+Bv0/zj
 NoNJ9YCwFeNV6EbV4mErstCdUiHqVqGgAJRuPkGM+tZfQJAKAqC6YvCKhs7fevvuQfv4
 LlqeVexwzItFjGHwwwJa2XxwFADGxGmZvxZE4xOxvWHaWWzJ2a17QHmgPOZ0fCTvCE83
 YtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782736691; x=1783341491;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JcvGwtBsihPrDebpLUWJMDfK6+je1oqm2u4vCGhjN6g=;
 b=FtJ2et0qk6AcGcxBQHNE7TZg5dhkqqUTh5Cwayp7yh0OSdyaP4ptG4K2eITzE1DtsN
 Iq59eioHsdS5pr2paCN4LRGo8H7TpeShCJkj3Hp4bPDpqwroeh38HUTjZu6dQ8abyDgT
 5C2XHwbFvvJRcz6hD+ByLXvwLRmuyNy2gU5y2aWng56iWY9yssMlM3X0B+WTMy9yyXdD
 Enx3lKGoiAUlb+lRb7VXS+3rNv9drxAa7NIJdpZxB/smd242T3znzmXav9//4wopihXz
 U165fv0CILK2SinJqUJK25997B7Qs04rYgsfRbCa/lvLghetxozyWWRYIN2Ihjhd+BeO
 nL9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DDuTNIKqSJKmnBjyOmoSvqw7lXN1NM/COTAcMmBM2Rt38S9anBaKak973qRIVNCvubdxdNvIG1gK7B4tT@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxjDRAYj2tWmfOELp/sSqZcN1D5f+jdXs6Lr3IPwwBbo9YP0IBn
 RATk+8VwfKkDYT7oqVCeg7xlGZgzRIO3+xglB10fsDTa1LRpo3e49DXHxrrTSKmiQdCCEhxtMsd
 iRT8PyvzZY5WzjxNyaAQ6dOaERxUPH4PcjwCZzABZA0QlrP1g4G9A5jVSmjSttwqr898g
X-Gm-Gg: AfdE7cmNJo6+Aq34YArjEfkJmAF33YTKtigSInaNJgYKwfmydmkPZO6NbT7rG/S3wiF
 GDQAaZWyjOpfLbiMbTpjn1IY+V/cb8hFBElkPUM2nkf+6s2OUqBCz0Ydc0FcdC8h5LFouwcYkb8
 C0THwDuZFCmukJ3DLcsqgSKt6QC7GLUfgywKqIKWI7BXlnaoMleshkPrzEFs6n7Vg6YSVtA2OnT
 7kDhpFDiNa1SnEqS9JTUmENk4235b4j1134H9/bsIA64WjFd7FgtjhENQXdo6mreEPLra+XPuxH
 XlAvvOSQfsLJQvHFQ6FOgAT3KLDmSdBc/85TFHT3VhS3jmJPT75DJS3+RnKWoGTMlqR5IsUrro4
 tiBGjGbkAaCv5BMCGxyTqgso17bXFycay0Os0VaBFg1tq0tXHOixtm6xzSQ/Ri7E1r8d1D0KTQY
 2aFbWcAGFR0nQiVnbgYn9LchsXS2PTUm2jVAoSacsSisBYC4LOjm5+dsyhcTGdxr14scGjKvsAR
 BkFR9paYHm5KFKX0qgDcbheFzWv6G9TjHZvcOmrs7H62TBhOocOb78J5eNCAQHYePnHM3QpLr2d
 UUvWlzEwGY4OCg==
X-Received: by 2002:a05:600c:4703:b0:492:1e36:1fe9 with SMTP id
 5b1f17b1804b1-4926689296fmr232018095e9.37.1782736690705; 
 Mon, 29 Jun 2026 05:38:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492690a1a85sm544519685e9.15.2026.06.29.05.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:38:10 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 12:38:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
X-Gerrit-Change-Number: 1740
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1740?usp=email>
X-Gerrit-Commit: 4c1d09e3bb0b5db506178a6d091fc08dc8a456ee
X-Gerrit-Comment-Date: Mon, 29 Jun 2026 12:38:09 +0000
In-Reply-To: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNjc3ZjQzZmMzZWIwMDUyZjhlODBkOWE3ZjA5OGQzNGFkMDNkZmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3a32f32039cb799ffc2ed2ac6805f66bb7c08f6b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weBFh-0003Oe-1t
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Add
 buf_read_u64() and buf_write_u64()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1478696321253330708=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1478696321253330708==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XVsgYe3Svzc="; charset=UTF-8

--XVsgYe3Svzc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

stipa has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
740?usp=3Demail )

Change subject: buffer: Add buf_read_u64() and buf_write=
_u64()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1:

(1 comment)

Patchset:

PS1: 
> We have htonll that we use every=
where else=2E  I think you should also that here=2E
Agreed, fixed=2E



-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a=
7f098d34ad03dfe1
Gerrit-Change-Number: 1740
Gerrit-PatchSet: 1
Gerrit-Owner=
: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Commen=
t-Date: Mon, 29 Jun 2026 12:38:09 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--XVsgYe3Svzc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1740?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">We have htonll that we use ever=
ywhere else=2E  I think you should also that here=2E</blockquote></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Agree=
d, fixed=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail">change 1740</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic677f43fc3eb0052f=
8e80d9a7f098d34ad03dfe1 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1740 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 29=
 Jun 2026 12:38:09 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>

</body></html>
--XVsgYe3Svzc=--


--===============1478696321253330708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1478696321253330708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1478696321253330708==--

