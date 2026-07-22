Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED1EC44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rja6p+6Ez9cAt9N6WLl5qTVjTH5goBZAmfe173Q41y8=; b=nBdZ+0VK2wvIvznG4NwNBa2iCe
	qwGrPJfY8Ozj9PigyGf20wBT8pXRPqNq6UQhKPMUtcE9G5RW/gJYVWLC9aedtg3eOLu6qb4lFBjqQ
	V7sPaq5KQqlpbDPvH6UqkS5qszVGB3+TjUwvdiNPg5RCtgx9kmiSb7L6mkGbg4JhGvUI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmZ6m-0002s7-2P;
	Wed, 22 Jul 2026 15:43:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmZ6c-0002rv-Gs
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 15:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GqHgWljEenkww3oNFPlAsksfYaF1+8Zp92eEwa3Ofto=; b=axEREck9jhBx1dMkThEG+VBogC
 2nXwtIygw0RzQ+/x2JAD4wxt+mg+vQSYRqwsvQfaJHXQdbEWooy/jARmCegL8X/uLR66QuTrvUliJ
 xyzANhXxgfSomRlPV35dTAWt6JvN3ibHPySh++wQ7HcAQsesvG8+Ql6UolCTrKymJ1So=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GqHgWljEenkww3oNFPlAsksfYaF1+8Zp92eEwa3Ofto=; b=m
 QL8nomoQEdpu3uiGCriFZ5bGFCf1cd2+HRID9tA7A40lZRwamwe0g9BbAHJcTtYnGE6/NDGSVsbl2
 y+O3AWK2GrtvUdpqFbhrBsvwaTZR9T/bQLJtwSBxddMcvog9GONu7pfpRidxl5tohpGc8zpTdRNRb
 Vp8YwYQX3R8zuTHU=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmZ6b-0005ua-Pb for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 15:43:34 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso49226495e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784735002; x=1785339802; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GqHgWljEenkww3oNFPlAsksfYaF1+8Zp92eEwa3Ofto=;
 b=YqxY8m1lfSW0yhtKtstZYHH4fI6pmCJS2RYWnkWgSSwAC3yjh/tCO59zJXo0vBcUxv
 15zQtscGKrojL2azzbRFk1h8pgTlamwIbry+cVTagKZLl9OUYeZfk5DerFYdHaZrFh8O
 iLCMCCsU4mnPIDyKv42mauK4wgeuwl4IB8HbxxYQ7n3M371YfnVxMxk313G6JdzxKoZ2
 vm0jcA0ZSeTF10MD2AcSh8y30KHX+wn2Sk466VijpIzxQLDO6EOpX33mFCPpDHymC+US
 Eg7Dv0hjxp42DiHoPz7RwlKe9OBc6rIfjEm24TCRjiLpwWk8tGPjVD5EUz6RlepmO4KQ
 h1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784735002; x=1785339802;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GqHgWljEenkww3oNFPlAsksfYaF1+8Zp92eEwa3Ofto=;
 b=L/tgcBzONRK41CncC98VpTWi3SPHoj2Dt/7JKC4PKmuEUVCjsdz8pgYEXicNFRKPll
 Mv8sQRPjAzwLsmYPraqaNWsT7i5ovVtIzFp/5PoFDZY25GvK0m0i3S8Nojbia5GsIQ0f
 9GPrzWHtdjVJB5Jgu6crcjfa4MwoxXavE/ctHaLCX241wW3P4ChkhvtIjG8++qwF0hgz
 9YltsD3/dD1yaxYkjI1VpJ0567ldYgVaar6ESonSVwWdPcz+/30oIBR7O/vwGt5CgCmu
 vfrkBq+4Jb1A7WgyWx1cXUj8jr713Q6vkijzbn6hbQlfEixIj8KCqmepMYLfw3vm5tIT
 e4lQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roli86YCql4ORewosTLLKW34VStiu2lC83mh9qG/vsR4Y9lFbhXCiNZB4A+WWI0VvdTJxFL/ZMYTFmguMqB@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz4+IXfvbOIBp7pK5piqrB0Q4vLLjGKu/EWPigNJWWodH381FyH
 y/DcZ3mv/21uv5MeVBxPooy3aul5z7uGzshVpxpXEJd6MKUTWj+lQ5ECiDFUmNWdbQ2Y5Z7Rul0
 VuONB6kNdungs2aRKz3hOMCNOGdZViXmgsz9hhN18RiOGngW+o3zLX8Hr0xQXtPvq/zyP
X-Gm-Gg: AR+sD11N4EFWbbrQ6KQbidSzjd4cIAOKlHD54f8JxtHHI53Zxr8poo4ozzdpOiXNZ/A
 UI7b5ksOX+0ThiSeRFzZm24jNCN3J1MebuJWx5GlKgh0scwDKnngJiC6gKLxMEGj7a5gUs/HPsy
 JuGD6ZBH73j2eLQDO6cElF36Z3pCvqeX9QkP6jjhWrdUhLwrcgywNNfS/53nQzmxhdxWVjUKFwF
 bQd/G+8AcIJB7K+odqyw4xsUUOn1xzJqi9PvNR2QMUEVJ4XzQgMNr3UCqJOj5jOBJsh9LkKPeVq
 hVyafpfMrehEpqxSQpP45KK1QRt5/0VSAoI9l1f6TPvqcfSzkCTXGYqUy17t2gOKMzwC0dxeL+i
 m+yHSZiGhkEVX4+5AIO8Iu1SRaHA4X+E9s/s/Q3NFKipl/cLDf0CR13apj4iLBDnbanVqSIAG5N
 r30qaZNe7xzeSV2Ix1swhu+kGQ9yGfuoef8WglkP2EqlaMOPg1VoJEfPNEWthJCwpqJ2PhBLYcT
 ypFy/RVF4wuUi9GXQk2kSJtOc7kQXdWsuvzbTuTYZ9RBqcC3c13lizCT8s9KMNE0S2X
X-Received: by 2002:a05:600c:3b19:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-4954a3db76amr270933825e9.11.1784735002099; 
 Wed, 22 Jul 2026 08:43:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956ab45df3sm57153895e9.1.2026.07.22.08.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:43:21 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 15:43:20 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: c615b953bdde58c49ce0609f5f8ca62efdbe1460
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 15:43:20 +0000
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <073c089dabb067d89a6b6d02e5a89aade9e04d9e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmZ6b-0005ua-Pb
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Answer
 SERVER_PROBE on the server (P_CONTROL_OOB_V1)
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1857832591026658069=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1857832591026658069==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EDEjfvmzK+Y="; charset=UTF-8

--EDEjfvmzK+Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1744?usp=3Demail )

Change subject: oob: Answer SERVER_PROBE o=
n the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 8:

(1 comment)

File src/openvpn/mudp=2Ec:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744/comment/20c220e3_79e91dfd?u=
sp=3Demail :
PS8, Line 250:         if (!reflect_filter_rate_limit_check(m-=
>initial_rate_limiter))
Why did you move this check here instead of just ex=
tending the if condition above?



-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Gerrit-Change-Number=
: 1744
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Wed, 2=
2 Jul 2026 15:43:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--EDEjfvmzK+Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
44/comment/20c220e3_79e91dfd?usp=3Demail">Patch Set #8, Line 250:</a> <code=
 style=3D"font-family:monospace,monospace">        if (!reflect_filter_rate=
_limit_check(m-&gt;initial_rate_limiter))</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Why did you move this =
check here instead of just extending the if condition above?</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1744?usp=3Demail">change 1744</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1744?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1744 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none">=
 Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed,=
 22 Jul 2026 15:43:20 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </di=
v>

</body></html>
--EDEjfvmzK+Y=--


--===============1857832591026658069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1857832591026658069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1857832591026658069==--

