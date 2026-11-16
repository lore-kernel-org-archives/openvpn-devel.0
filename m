Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE67606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jUEI9BVX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lNzfOr4h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PM4Ugwcu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VrAC6Ram
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PgnpMaKSP4alNdZ1y3I9l45rH5NJV1s1Ql0gCbulqbM=; b=jUEI9BVX5JjIWyD2gPl0stta+I
	p8thoI0KKUy9KpFonK1tsYFICzoa6U3bLo8qGEPeVkOjnS9iaKviGhBwF4b/L6UbzQ8IfqImGOHVL
	KG00p5QgPyT9b+XKqV7QcKOSeHLp7TdpVTTgv5RMka7p1YcaAWv3U7cGT+bQ2CDjuKh4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSyRt-0000000036N-2lqX;
	Mon, 16 Nov 2026 15:16:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSyRZ-00000000362-05zr
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:16:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JhsA17MXuZV9r/cvxrsNXH4PDN0Xwak+BeNGbX2B+QA=; b=lNzfOr4hzyvL+0w+0H4f3ckKd9
 gFN70KAdcBAlKO/i3uN+0XDKfS8Q1c5Xg5XK0Sw5PMOZ/7hHy5YzXla4VWZ8f/eFwBsQngCMxvqgL
 Eibu2i42L19POUEvsOkbhnq0il7n3Ri3J1EZprORURw9rM1H02GM2Nvjp5GdZOCa0agg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JhsA17MXuZV9r/cvxrsNXH4PDN0Xwak+BeNGbX2B+QA=; b=PM4UgwcuojRD5tXfGCzkLY1ksh
 fyFD0C6EtpFpjybdwm0byeNQxVngt8LUq3lohYFA1goAi6SbSq10qg0v2O+oEneJpzduoIuAyV4xd
 PFWx6qbmCsYCHfC6D6xDdtA9DIecCHWKHJOf40ZY1ExAMCnwYVPpkp98vX7QSdKbMitw=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSyRS-0000000076e-3sUK for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:16:24 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so1882587f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 07:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794842176; x=1795446976; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JhsA17MXuZV9r/cvxrsNXH4PDN0Xwak+BeNGbX2B+QA=;
 b=VrAC6RamN6IgPr5vcP+qXiWr8j3i28+4m5YeiO2ipLpLkzQq9VhyJJbBJs1rNFFASP
 F48wQgIT4mUP3lZeMjNR2K8UFHYp4dUrcFEm5YBwEUFfXaJX2HU+HkaoFEANbcgp8HQB
 02+hWTYOmD925WxgPe0ED1c1iAie80lNnkpCeT8z1zcNMuacirRbBJBacFft9jOHD0Mx
 0IjAgpLqP8sCSH6jw1SKm4G1YSsObAGhQ6ggpfhcm+PdQjyQYp3oH3Pwg8paMX4Kv+lv
 QYkzzI9lOZuo3dyFQ9m4NQZ7pmkdDAnZYxCBWQjQatWR8n91GPJQJ1Z5y7iimmTKJDgL
 GP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794842176; x=1795446976;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JhsA17MXuZV9r/cvxrsNXH4PDN0Xwak+BeNGbX2B+QA=;
 b=XfIoNb+QKKT45erNOnPXy8/UmMTupeM8wSvldFeyRyxYEYNCh0nXe9BQXXOpXmfaNI
 ZAMKLFb3U7ExYFSPDnblfJqZEO61CZHVBvjlBoyFsBo270alandvv22BHBYUK7Lsh4+5
 /Irqr53kanspDTGz9zK82ThRoy08Enqyoshm+ToY7Jm1QZUhQT+zNflULoofH1NT3dgx
 dt57O+IJ7IIHBGwTDdmCC6LaofPm6SPgNhKZ2VmbmvQQUM6BWHKdi4zCeK+1q+6fWkzL
 5fpFZ9idLRLqWAkvq/BIzqVgcaV37zkqDmtLGPMjxDAH+I6dJYNqQcaoaLHBH4rHXT+s
 sctw==
X-Forwarded-Encrypted: i=1;
 AL+hErFr6fZizJjta2dopDkqECysIuANtH0pPM9T86saI+dHpwd5PDZApWECLBbJxlFZpFtEnIjvT94rKcbPfWQW@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+J46rpH33O8k68tb+g5dMN09T2NRUL250tkQ5SVat62lM2lk+O
 3+OOZKGGudkz6AKkPn4fVRUuqfnhEk95BQ/phpofLm6QHsKRongkVd4BSB+R0Xcdiv1rPOIXkrG
 HH2TPEzIo7+cbRHmyN0rVbjNcUr9yzu4CxuKe15FrWKjYq6odSqhQHX1Daj5rLx/gdEuV
X-Gm-Gg: AZFdTZc2ipL0bfFOq+yGyeSe+xvr2y0sDRM0N8Dyp/D2YNr6MR6/X6sbRnpK3UFRh9s
 7OXUbAhIxWfVYncodd8Wa9KFBeU90djy0VkKxqY7oRbC4DbixGIzE7q8DbBWWR99ml0NDoG6G6a
 qK74sMnc9etUJPT+yDXwxo+YCywTPx3uhOWD0v7sCwwbren5MHBEqPaFvPCY3hCXFHbA0co2yij
 MLbiclz6gde1PlUCl90K/wV3Ql6DlaHaAG/nPS0ZyDHxg1LfJAoM1SmY8PeUESTWrCQiAO+snfm
 lRsynkLrC50jqPbZWioInuf4d7aRVtD49ilr6Ga3eVpiPbbaq8NpkQ7h8EeItogKrWqTAMhFyKh
 mpDL8LJBSWILZQoRMGuABu0G7xocmNEx6vWhVN3eULuPkACFOuvEp2xx70vPVYXHPzPBcfJa5Ty
 UJ/UdXcHODtI5NHIjiEfX3siJsP2RH1oIaJcO0JuAFrHfn5i2oRMdfaKaJLM38W/+2WRgwSgZSt
 9sm44g2F9Osojwo/3F9JBq3w3s71iwqALR8ZOa3ZxUvCapLUQ1nUYymYvtkohR9heQ9DWntPwDO
 ChF7Uya070vd1K4fkpsPGt81DH2Z3aGlz9ZR+Dy6G+MvzOjGs4pcP9RmBwuJ4N5Ux2mhjSnXzqX
 bbhBbkUM2wlNICnfLBAX3QfEOSuoz3xL3pUbJylE4AByo/Vu44TtWI2lDIWUcum+IABBatVoY5v
 y4bRCK6Z3z2WE8UaA=
X-Received: by 2002:a5d:6384:0:b0:48d:f541:a6e7 with SMTP id
 ffacd0b85a97d-49c742a6211mr16109947f8f.40.1794842176090; 
 Mon, 16 Nov 2026 07:16:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f7828a4sm22983421f8f.23.2026.11.16.07.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:16:15 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 15:16:14 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253
X-Gerrit-Change-Number: 2197
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2197?usp=email>
X-Gerrit-Commit: e7a1fc7dac733dcc0f3f5d3f6dc90f67ad2d7209
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 15:16:14 +0000
In-Reply-To: <gerrit.1794839855000.I33f70825c058c24ecabd8e80e5ac84bff07c9253@gerrit.openvpn.net>
References: <gerrit.1794839855000.I33f70825c058c24ecabd8e80e5ac84bff07c9253@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkkzM2Y3MDgyNWMwNThjMjRlY2FiZDhlODBlNWFjODRiZmYwN2M5MjUzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e61592a43c403bbf8b2f73931689d5caf0c85677-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSyRS-0000000076e-3sUK
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Various trivial
 -Wsign-conversion fixes (part 2)
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8187594735878763840=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8187594735878763840==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D5qNpY4qBqI="; charset=UTF-8

--D5qNpY4qBqI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197?usp=3Demail )

Change=
 subject: Various trivial -Wsign-conversion fixes (part 2)
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33f70825c058c24ec=
abd8e80e5ac84bff07c9253
Gerrit-Change-Number: 2197
Gerrit-PatchSet: 2
Gerri=
t-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comme=
nt-Date: Mon, 16 Nov 2026 15:16:14 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--D5qNpY4qBqI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197?usp=
=3Demail">change 2197</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2197?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2197 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 15:16:14 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--D5qNpY4qBqI=--


--===============8187594735878763840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8187594735878763840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8187594735878763840==--

