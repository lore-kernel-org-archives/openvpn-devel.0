Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A160A3831
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OH8536Ta;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TE3Ihwqt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=E9CVga2Z;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CFKtJwp4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=kvBZJiNJ83ekx2Fy101G7YFCf1vanZk94Y7e/LjCWsw=; b=OH8536TaP+vkjE0Vb4VrYqSzA+
	aUHozk+X6SrMKZntrPToRUbUfPNoLJhadY12PfVbQq5OQ6ZdzVaoocfwMOI5UMWbTT4c6cvdOZUb/
	6ETp10MfM5PP+v23V2ABRQ+XGuWDU5vScgsfLzGcQUJdUvLpyf1zlVkmJbL5kGmzWHDw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR46c-000000005A8-1aKO;
	Wed, 11 Nov 2026 08:54:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR46b-0000000059u-0YZl
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:54:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HyZfqIdcGX977F8cCCmowYw7q6BgyD8VWHIr0hmxdz8=; b=TE3IhwqtmTJpiwgEI105aWJg4v
 U2FpncOjWHDwAEGNlCKKNqs3gn7xeOdeSv47CiXsEz7MEM3wm3inBnEatw2n8MKqW7Nc7XwfbSZ+x
 KxfEi9m1nVqLMeFntLAuHO/3Xfx18dtAiKwpx4aymFX/aE9rg7awSBka4KIXDSGYuHlI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HyZfqIdcGX977F8cCCmowYw7q6BgyD8VWHIr0hmxdz8=; b=E9CVga2ZkxLNDAz7aEU6gGxBsv
 3y64Z6jYVu/RoJGvkSuAac2WblADRWFaYA44ZaYAIUfMUi/7NG9hqUSV71GceXzuV/3eKrVT6a+DD
 UbwCC4lBUQvwPATW/Aw1IFYt6AWPKOB3K17botAOMDZjskbLIVxX609VW4lmAE9Tp1FE=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR46a-000000000gi-2GIv for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:54:57 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so31280935e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 00:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794387290; x=1794992090; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HyZfqIdcGX977F8cCCmowYw7q6BgyD8VWHIr0hmxdz8=;
 b=CFKtJwp4wdYms2XhfRSbpkgy+Xv4S3jV47WCxul4UUCqvMvhybHYkgUBEhNVhuhEsK
 Xb/8EHwglQgkhJ6spr/gYCJLpdveLT1A5Hjf45cjuVRzzgOSDrSv1d0zK30EFMJrFxYf
 sYzyzk0W8bLilIdvX4IFw+lqBvG3+8xBtPlW7kDOfHel8o5ktTVhfam+qkoI/vIS1+Mo
 bdpS65J/Edki3ijcaaucxXnVnVNiTk1Lozv2FoqY9FUW7evJ08ZrcHLrY31aNyuZYtDM
 KLR048MLYzKW1KrmxkGplaSh8S+vSwHY4k5XC1h36h0Ocaq97yrbf4Pf4WVsL3ngvi8k
 2yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794387290; x=1794992090;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HyZfqIdcGX977F8cCCmowYw7q6BgyD8VWHIr0hmxdz8=;
 b=BhtM8x4zE1i5nS8PzhRIzOhpafxkE5HZ3viNTuGYlRO1Q6IcpbuOqlYks/CyxGiqkJ
 mLXJKJD7IZY8lhS76bxS5RFDAuCVVpCd9ECbr6dumOFtXhsfUemfYdbKTNLenfkmJnV/
 zaLHxZpi+ZwlE2SFjg9h1lx96Epukg6GHDXQOlR1LsQCSM3wRqohb77WnDTDjjbcWnOh
 wlHKG2FwIP+uMLXAwEzyCb28ybJ47oG7gK1Lzu9ThOR+38IL1cgsLBTaPcNW9AJwfo0W
 e7r+57u+MWWz3BiNtpYm2S4wa1u34GZ4HfAmYXNPmxL+AvBNZBCA+rVk6zP5C09aS+gN
 H5zQ==
X-Gm-Message-State: APuU4Z9fpL40EK34zPWwvjgriLCrOmpoilkMsvzupvcN6GPLUTI5NR7S
 tVTPRBxoQyZN6h/vXx+rNgGXoqoQvz1921emR7zsqKQPjdZgy7QBNUS6hpYPgV+QP+m411+rEwi
 Jj9gtSuQx07OgqJU2KfPQfBCK4nOFyhYh1OgIkHNjrfekFuczeaMrwLNJ8FD/sWOWYRn2/s7W4x
 Io0d3Yrg==
X-Gm-Gg: AYBFou3cw82XvUCNcN2aUUmzm6eTK25oVJjC/atkVPWqs+7+CGqkBSrP/CiCQ1UN4ub
 gnHYyEpg6iY8Y+Jk3K3jDQyAnfvuad/f3iA0OdLHSJKxUAsm7L92D2XUiTr391h8k/loM7Eo4OS
 nDHv9je4adzyyw/AFAgJiNTx70TKUcYyVlll1sUdaQSwP0ZtN5zA5E/llCfS6o019TsF7azvfKe
 qYf5QT6sl0y8ydAXhaJskX7BicysV2+GJsjUCze7ie1gumIIKvYqEiRP/GH2lg0OOWvjrEWBPno
 U+GE5QFr3ITddFD3kGYrz1YrH7Jgpk876RChlpSNfeD9HZ/3MwCBZWySBl4d1PU1yC2bk0OHVyl
 QAheDWp9ELAmBWoG5JBGZCn/FqLrcQdiQwHNCuANf9KVajlDYZQ9v46+tlXZI3CK/Kle2L7QBJz
 uqo6sC5o5MX1Xc/05mp4+LO4w6DZBrDBBA2z0P/vo+KHFJN523me5cwgoXtimd5vZFzLu2j20pQ
 v0Ky3Osh4vnQij6wfZUsl5NvG7c8KQY8HNZtjeXfWnHcZjphe0H74gt+uuR2113HfCg6FD0vZZY
 qxjOK7gnm3X5WEDGLDfF5lP07pw/HbqbSBGruVk+5+yY/k7yT2Wij/TuQtL22Jwca65eeunL+zc
 YorwkovVlGX6zi0h7Y3IIwSB4OkxvYAYUcn/H97/0pCP2/vmqJEutXa/+puN+c2IFRnldLeYBNP
 Sac+aXSgsp+l27sVM=
X-Received: by 2002:a05:600c:3103:b0:4a3:59c9:a750 with SMTP id
 5b1f17b1804b1-4ba09364c0emr28400465e9.9.1794387289852; 
 Wed, 11 Nov 2026 00:54:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835e20327sm10108220f8f.26.2026.11.11.00.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:54:49 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 08:54:49 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0705cff831cbd18686721dffbe5960976e3489da
X-Gerrit-Change-Number: 2173
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2173?usp=email>
X-Gerrit-Commit: 49a91a2aa35287d1a5361a8bb21507d4f38f5347
References: <gerrit.1794387287000.I0705cff831cbd18686721dffbe5960976e3489da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzg3Mjg3MDAwLkkwNzA1Y2ZmODMxY2JkMTg2ODY3MjFkZmZiZTU5NjA5NzZlMzQ4OWRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b793ce6decd4accd84950742923831b34c4c815d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR46a-000000000gi-2GIv
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun_afunix: reap
 the child process on close
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3446560804689820038=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3446560804689820038==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QybhewMZ3nY="; charset=UTF-8

--QybhewMZ3nY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2173?usp=3Demail

to review the following change=2E
=


Change subject: tun_afunix: reap the child process on close
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tun_afunix: reap the chil=
d process on close

close_tun_afunix() sent SIGINT to the child but never w=
aited for it,
leaving a zombie on every restart=2E

Change-Id: I0705cff831c=
bd18686721dffbe5960976e3489da
Signed-off-by: Razvan Cojocaru <razvanc@mailb=
ox=2Eorg>
---
M src/openvpn/tun_afunix=2Ec
1 file changed, 1 insertion(+), =
0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/73/2173/1

diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/=
tun_afunix=2Ec
index 79d706a=2E=2E16731d2 100644
--- a/src/openvpn/tun_afun=
ix=2Ec
+++ b/src/openvpn/tun_afunix=2Ec
@@ -139,6 +139,7 @@
     if (tt->af=
unix=2Echildprocess)
     {
         kill(tt->afunix=2Echildprocess, SIGINT=
);
+        waitpid(tt->afunix=2Echildprocess, NULL, 0);
     }
 
     free=
(tt->actual_name);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2173?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I0705cff831cbd18686721dffbe5960976e3489da
Gerrit-Change-Number: 2173
Gerr=
it-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>

--QybhewMZ3nY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2173?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">tun_afunix: reap the child process on close<br><br>clos=
e_tun_afunix() sent SIGINT to the child but never waited for it,<br>leaving=
 a zombie on every restart=2E<br><br>Change-Id: I0705cff831cbd18686721dffbe=
5960976e3489da<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt;<br>---<br>M src/openvpn/tun_afunix=2Ec<br>1 file changed, 1 insertion(+=
), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/73/2173/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec</span><br><span>index 79d706=
a=2E=2E16731d2 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Ec</spa=
n><br><span>+++ b/src/openvpn/tun_afunix=2Ec</span><br><span>@@ -139,6 +139=
,7 @@</span><br><span>     if (tt-&gt;afunix=2Echildprocess)</span><br><spa=
n>     {</span><br><span>         kill(tt-&gt;afunix=2Echildprocess, SIGINT=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        waitpid(t=
t-&gt;afunix=2Echildprocess, NULL, 0);</span><br><span>     }</span><br><sp=
an> </span><br><span>     free(tt-&gt;actual_name);</span><br></pre><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2173?usp=
=3Demail">change 2173</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2173?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I0705cff831cbd18686721dffbe5960976e3489da </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2173 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--QybhewMZ3nY=--


--===============3446560804689820038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3446560804689820038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3446560804689820038==--

