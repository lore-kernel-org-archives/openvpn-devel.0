Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF4D606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 25 Oct 2026 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hwIx5Mw7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ikVQOsJD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VerDVor3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GCk2/qSK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LYKxTbbAlCM8A6uMr+jtLIN/Q32YD5+vHmZAD60s/QA=; b=hwIx5Mw7IaOUFuvS/O5wRSEOv7
	VmeFdcamM/hxdjyq5DGIA69VW4g1PM5mo6CE7FY3XBe+K8syw5pKGM4Thekza5xba/FZht4GoRWeq
	AXdjZz+tSlYFeyOPJ/oM03yJq7Ygb/62kky+sZM6rIpKxp6hmdvo8iEN8Xd1flES+dkA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xL6do-0000000026V-34y4;
	Sun, 25 Oct 2026 22:24:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xL6dn-0000000026P-1QUb
 for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 22:24:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PDkHfofY+ZlwBBtDn0+D6BWJ2QSElEoQ2x43fgwZsFI=; b=ikVQOsJDAo8RSrYcaf/WqGd/0r
 WiL1Ivg2kSP+c/SRM0PVUc1N7rhq4MM3WeV1+HToOQ2SBkLvCj7R7XBWU6W79Ktopksc9xxxTBmr0
 gCuI2xUE1vEtfLfZrGAhXP+G/LJT/tM5bBUyutZhnwmk3LXabNsg9PUnVU+g3EcCJdno=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PDkHfofY+ZlwBBtDn0+D6BWJ2QSElEoQ2x43fgwZsFI=; b=VerDVor3MWLiPhaIS55sBYm1mB
 Nlzae/iiwlUWHT1TF3TGnelDJd0Gm1vlmfV3i7qziXeEWXHQbssvcrkXgemLNQO4k/uyTyViG47gx
 vJLfrln4A2R41fKOKFCRJgPpAKsrC7yfoLXEguJjDsC8vYdTjTUtjxT/V+IpOG8PUxjk=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL6dm-00000000406-2Jfi for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 22:24:35 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so3794405e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792967068; x=1793571868; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PDkHfofY+ZlwBBtDn0+D6BWJ2QSElEoQ2x43fgwZsFI=;
 b=GCk2/qSK6JLypJfYcKWsaBtSpXyYmCpbH9Hd6fueuTAxKndjuHUXPEkYVTQAAFcW93
 KxG/OGAF1C6qA505SjLPlVOWW+pbQS71GDtl2lvBxmHC350Nza9JKy2UFzZUqK+3lJEU
 jUWizrQO6J6zCDuIRFDpRSJCOFeGOVbSjXcZiH9ZzSrtzkyz/368Mw8Xvy9YHzt9nb1d
 91xiIfV2Imbgo1olcEMpHjY8PTFVw74PEd0eM7ghUN5Env26nC23y+FktJ+fRsXoYAAx
 MEcG4wLi751YZmWd6ymkgaDjF8/H2Q/CajzQ6ONcfHJpmR9UODZ/58C6ZrZ7UbWtWwRl
 fKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792967068; x=1793571868;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PDkHfofY+ZlwBBtDn0+D6BWJ2QSElEoQ2x43fgwZsFI=;
 b=HQ1XcU+jqPLICsLcYECyhSNzU/esRcFA1S6SfjnEpi2DnPgyixTJsPJIK+uNQ0WNfn
 bQUL1sBlT7c3LqGc9JqKCOPMBgSiQqcscq2pjr6xuJzOCv1MYOr7TMaLp/xYZHxxWATM
 TQUjBe8U2Zhy6bc9m2XCqDeJa63DFoO7KD7e6t+Jfay5kEQyvbQatat6/H40/u1oz6Ip
 iVSePqPk84GmfwJNhn6n7BdKTyig1qFaV/83baAUnBOM4NwwGOym7B9nHWKqQBH+3Eps
 zYo72cXuL5Po+Sq/JhHa2LQOficNiNeHBBpfJqI/gsHsq6Hk7o+EVG4DBPo7Nj3Nz5lV
 e/cQ==
X-Gm-Message-State: AFq9FYIrv/1m6dGxwE8w2EshYOCrEPAvi7j5s1WsuD+1YZ2NjL21lZNe
 utFT+pjmMA1IDOQtoavpYpxW7fuO8cEh9BjhP7vJEOfTAPfAe14q7AZCkMn4YdXkIu4z1qBi9pI
 4aCJK8vq37HM6f4rcFVEDISMkB17cYmVi51IIcdL21AhwdsDTnHsuNm2zuwE8m38kNyVODPXxJp
 0Vw4bcTg==
X-Gm-Gg: AYBFou2G2xUuPWD6Tgmr+H1kb39fAecjQmOcXVDdAih8nTQeO6q1A7K7bYl9mtJNEMU
 xZA79u1R+KQsdGOWoc4XohyCshkZOhhMlxlYKjmMOl0Jkv9uZXIuVSv/W8K5m/ySsbPlp7D21yJ
 hk1uqHYDp/up4hzD9W8Bl7MdUIgjMJ/jMuB2/N1/ShtCeL9jJ6/IdwSchgeZ1gElpZ8emYdKNLI
 1TWtZ16NcF8hbFmv6p8YBvbj7je+yyXC0bwiWES0v6KCXfWMJEqbmISW7rsCkbITiorAm/6GH0w
 GERxnhM5jr9Movd8Eo8ofeqfPPW7DPdbuWrCXEH8Es0CsCnqBsoPpWy4aECi2wICrcnB3PvlBEk
 SIl8ljaHZl6F5cfFZDHSC9goALadQBO5AaaxFv0bQTS5G3fkHCZuAaGUddqcdkldTWA+GNstzjx
 kfotSFzNhVYkaM6bD9cyCFODsFqFm3krU8A8ehpozE1936b1E2IsUikITQPjA2qy0VMSxkocYGX
 8nFx5+d/tjBObcP8J3bX5ziIw4cUbfelftvd2Fltjg7Rrf0KPMGcSnjmPOdj1Y1ZpcW+159SFhO
 GHfrOiJ+W8BoT8EXaLLKXdRRUVM1Jwq1fAN5lOr+hEl0o5+PFqEJjPrtPLm1GOwnihd3HFTSlEJ
 hvKAWNg2e17fN93PpWL5yIXn+NBdcslZ/oKzDC1YaTg==
X-Received: by 2002:a05:600c:a00c:b0:4a1:f90d:6f4c with SMTP id
 5b1f17b1804b1-4a35ac7f09dmr74551845e9.7.1792967067728; 
 Sun, 25 Oct 2026 15:24:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2ed5a2sm157109915e9.15.2026.10.25.15.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 15:24:27 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 25 Oct 2026 22:24:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I62d95dad21891351a16cd6be43063406a024acee
X-Gerrit-Change-Number: 2032
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2032?usp=email>
X-Gerrit-Commit: 734db16a8afd2de4703886fcf966d22ce4741b24
X-Gerrit-Comment-Date: Sun, 25 Oct 2026 22:24:25 +0000
In-Reply-To: <gerrit.1792965388000.I62d95dad21891351a16cd6be43063406a024acee@gerrit.openvpn.net>
References: <gerrit.1792965388000.I62d95dad21891351a16cd6be43063406a024acee@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyOTY1Mzg4MDAwLkk2MmQ5NWRhZDIxODkxMzUxYTE2Y2Q2YmU0MzA2MzQwNmEwMjRhY2VlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0beaa3d7005e6ce71f724ae3038fd1889f4268b3-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xL6dm-00000000406-2Jfi
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: release the
 session-id hash reference on shutdown
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4976431578321385116=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4976431578321385116==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vXCZS3mJER4="; charset=UTF-8

--vXCZS3mJER4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli=2E

Arne Schwabe ha=
s posted comments on this change by Antonio Quartulli=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2032?usp=3Demail )

Change subject: multi: rel=
ease the session-id hash reference on shutdown
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2032?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I62d95dad21891351a16cd6be4306=
3406a024acee
Gerrit-Change-Number: 2032
Gerrit-PatchSet: 1
Gerrit-Owner: An=
tonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2E=
com>
Gerrit-Comment-Date: Sun, 25 Oct 2026 22:24:25 +0000
Gerrit-HasComment=
s: No
Gerrit-Has-Labels: Yes

--vXCZS3mJER4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Antonio Quartulli=2E</p><p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2032?usp=3Demail">View Change</a></p><=
ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2032?usp=3Demail">change 203=
2</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2032?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6=
2d95dad21891351a16cd6be43063406a024acee </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2032 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio Quartulli=
 &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ant=
onio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Sun, 25 Oct 2026 22:24:25 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: Yes </div>

</body></html>
--vXCZS3mJER4=--


--===============4976431578321385116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4976431578321385116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4976431578321385116==--

