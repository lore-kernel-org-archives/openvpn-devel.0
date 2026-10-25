Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4BD606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 25 Oct 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ayuuDXzW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dzPaw/IM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LW7oxWX5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AY/svhfK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QqvFYxIx3Wh2U/iDvRIwgMi6U1fk0kO7zF3RazDK65s=; b=ayuuDXzWQpP6lMVH14bDuTeYqo
	plz/1SU4JeKVaywNsLnGocytqGrCGyAR17DRdlcGgsRKkapIG9x//dAgytMNyj7uDqDLyfYPArf3W
	DsId3eM2Jlp8pYkwmj5XT7cv2Ev/dahefpLNNjIbQHM5hJPisb2YDpu/fU6mNPN/jy4k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xL6BB-000000008Q3-2UtQ;
	Sun, 25 Oct 2026 21:55:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xL6B4-000000008Pp-3W34
 for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 21:54:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gZvaVbubvnnq+OJoHP2iF1jhBclMTDQOmGRA+qhtwls=; b=dzPaw/IMdLbwFKv/7ureuxipbj
 Hg2pMWIEeCZIJhvhw16pn9+ki+rNh83snVejLlxw8Ctxeot70ionrkp4dDl5O9C5abT3rfPfmFGQe
 Z3VoNjNlOuSza7yRxCXVbtCosBEamceE6SK2o7ZDf4+4qlpl9s+7fqg+H4k+wY+iHh/w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gZvaVbubvnnq+OJoHP2iF1jhBclMTDQOmGRA+qhtwls=; b=LW7oxWX5ihhAu7QgFKBh/IGmwt
 r9v5ZHpH9zYPYLpOrbcKVADbdDqkSTwdwh87WSNOMBsGF/0vc4vLB4h0mUm4UNatNOVwJU8b38LUo
 0SJRjaqhevBwDbB1N1GSgpZ700uEL1dLSzjLKvQva7+pJfvorDAtQ3+cXZSEzPInr5/M=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL6B3-000000005ns-48B3 for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 21:54:54 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so4383955e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792965287; x=1793570087; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gZvaVbubvnnq+OJoHP2iF1jhBclMTDQOmGRA+qhtwls=;
 b=AY/svhfKJw8235puP4bXqdmrdWkbMK9YStG2yAnQVD83x5nQUpCMvnVuypSR7L5/yA
 oMopbVIUvX+RQ/Q4D2OWMBRfjhyAjDDQPo6rKMskuwkf7yXDRLqZ8F+rSrW7O4nVm2K6
 k30BfsBJA8QfG528dfKPNsFTXwpNqocoBc514F0WSiROST3t3E9J6EsfeKIhmscBB5sk
 22R2gTYtbF+8GL/EoWV9AB0J9kCIE5Zos2LviRztrCbJ7C3/spGP6ym6ebfQaj4nbBK/
 dA1BHqnYSmkWFBodpeswUIkSyEoHlHAKcZ24mRLqcg2bL1YSddPYsL7nAuW6/9w7f0Wd
 qUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792965287; x=1793570087;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gZvaVbubvnnq+OJoHP2iF1jhBclMTDQOmGRA+qhtwls=;
 b=pH5h4fqXftVle0oiEa0hAfQvmnuCOknNz850TnUupxk2o4l3LSjXPmMt1cMEIbPxNp
 uYRcWBOBXaYj4ybFrGbaxzyEFCBD+qezOQBoQPVh6Tr+OhAfmFiTULLnXrUcQedRIWPH
 BrdLNOTwWzow2gKSsJI8k2YS4Br7thSUsTSyE+Il+07uPBIsNqiJEertonN3bgp4tSLU
 QZpqNVm2RKxATMFhYs8j5RMFxuHf/u4hSQyP6XAtSzQaieYYsgoakFvqirPayBGTZ08s
 Ndbdtap6uqgHEZPL7lAEsLP+oSk1ztcpk98uc2l1BKoYoGZjGBWeD1rubG4rJ8ba9nJF
 LVgw==
X-Gm-Message-State: AFq9FYK8sG67Y9YAHBCJYxFtRivYe6Wy1K0GjEdnwcSuyxacsFH7rkej
 ZebqR4cRWTzYPYqExt3NHz+f4+Gcn4hYeoJ5tDLTBj22DZ/ms81AzCAZl0AaTEmZ2A6YwkeE3Ho
 NwCBFFBR0F61pv1FsPBi05pSnif3JEknrF6PaW39AOjQ4FQOQs2+/CNsuO18YfxlVGLhhd8ldyJ
 RSGcIq0A==
X-Gm-Gg: AYBFou1TkMBygFG7K6BVsfp2m+jMUsCpqMf2/yVwGlpYZQVifc5/4CNjhG0ZXHc7332
 S6MW9dc55oH/tjieEBND0o5rTd+f/eQwcF91IeHYC9tgCrx87UALjPModQHV3cPwI53JOQkxOiP
 xOVYsauCDOjv+GyudRw6v63XTbpFTZwsjq9sxp0lWtNqy0mm99VyGm8EnMj63m2MQAfjEy18+rZ
 NWsHThsPRgVHnumkQQ9cgXc2IT9JmFTm7koZ3DZC474rdOF029vIWnsSbNs+dfc6k7UQf7m9Dwz
 lwnfy0NxJiCffznaTUDrRhGOUvO8kKg7BbWCA3w6RLuzWvHk3mWyFelonXZQ8eRKtvJo1zHXXcD
 qSyTIyNPUwU6xmEvcQCaEz7xQdnwHw2uiPRZfevY1+SRxGzqwQLmdUo5MyCSEAqaCS63dIZr6fZ
 4SGqKtwcO2/wlYJIvHZMvaaeCnsGZTGwQ6dlvb30DonLqyHfRuOT8cLLTaLCSUfJqSq9PO0D5Q8
 wJKU207LtQbtNTuBYVotoSCXnLsuXM3Xm3uRxeOBMm0fWxbJJG/AJ+TzaEBP2PuxmjdJpdoGAUC
 tqntpN+l+k/CwD/Nv57GFilX3RLKQHkEtIhkBwZ2xSKNF32I5yllTMJ5ErfPqjspk0bJNFHqHN7
 Rgtq08uextDIQl+WaAllKs8Lfqsh0/W+toO0AuWYlXA==
X-Received: by 2002:a05:600c:6095:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4a35ac7f0d2mr75779035e9.9.1792965287307; 
 Sun, 25 Oct 2026 14:54:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a574088sm132764475e9.9.2026.10.25.14.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 14:54:46 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 25 Oct 2026 21:54:44 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I136d57b7487f228e37894fa710b1ccc2c4606eb5
X-Gerrit-Change-Number: 2031
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2031?usp=email>
X-Gerrit-Commit: add6d94d1fc4685974f158c6e4ac7e32ed8620eb
X-Gerrit-Comment-Date: Sun, 25 Oct 2026 21:54:44 +0000
In-Reply-To: <gerrit.1792963979000.I136d57b7487f228e37894fa710b1ccc2c4606eb5@gerrit.openvpn.net>
References: <gerrit.1792963979000.I136d57b7487f228e37894fa710b1ccc2c4606eb5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyOTYzOTc5MDAwLkkxMzZkNTdiNzQ4N2YyMjhlMzc4OTRmYTcxMGIxY2NjMmM0NjA2ZWI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <efae1620901648a700539f427a0e5083a3abfdd5-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xL6B3-000000005ns-48B3
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix typo of nprocs
 instead of nproc in run-cppcheck.sh
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2173237745582923849=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2173237745582923849==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wjkHlDEEB+8="; charset=UTF-8

--wjkHlDEEB+8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Antonio Quartulli ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2031?usp=3Demail )

Change subject: Fix typo of nproc=
s instead of nproc in run-cppcheck=2Esh
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I136d57b7487f228e37894fa710b1ccc2c46=
06eb5
Gerrit-Change-Number: 2031
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antoni=
o@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Comment-Date: Sun, 25 Oct 2026 21:54:44 +0000
Gerrit-HasComments: No
Ger=
rit-Has-Labels: Yes

--wjkHlDEEB+8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Demail">View Change</a></p><ul st=
yle=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Demail">change 2031</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I136d5=
7b7487f228e37894fa710b1ccc2c4606eb5 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2031 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Sun, 25 Oct 2026 21:54:44 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>

</body></html>
--wjkHlDEEB+8=--


--===============2173237745582923849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2173237745582923849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2173237745582923849==--

