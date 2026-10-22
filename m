Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD240606A319
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W8eK8uWG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VxBAKFVk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=F0mtcO/j;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=J7yHK0vk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5K7aQTOaT2cdQjqdS/Ft/ZEglnIUbW61GMgJipEkui4=; b=W8eK8uWGZKd0luOr9nvjJpqrnf
	UQz1FYT98cczlLExafuxiaQVohEtuE/GCoE0HzlyRE3AF97bj4pN92mSQHQrCr2eMD0z17aPMOCGG
	4C9aLy5syPuBzCfIfRjhi4NZWxdWosGfeS18fd2MHERyTihSy0hSEYZ6Z5ACx6yQkAEo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJza6-000000002iW-2Tnx;
	Thu, 22 Oct 2026 20:40:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJza4-000000002hy-33Gj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 20:40:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UMUE4H0uxCOomVjiQ3BAn4zX+lb00AdAUoUcP6OUu2U=; b=VxBAKFVkFfGQsl6Y99SbXfVrnF
 H+aMhM9Tq5SVXv58VQMD1+BMM/o7JoJc2BO4IsiGOZiXprtq3JJy1iHCdPvq8s2lGztlBg3Hg8909
 eK3IjIUYzoBUNCMS30GGfiFxnnXJJp17ygKREaqu1sGH2kDHlAYKPWN+YlYLEojnGymo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UMUE4H0uxCOomVjiQ3BAn4zX+lb00AdAUoUcP6OUu2U=; b=F0mtcO/jPKg83pO0GLKaGkRaIM
 UHPmHgaWuFv9rgOgDQDjWf7sU3VYiSp0L3aHV4WTuUusyirHE+fRz5e2zaTH9urYdN8oxbTwx8N2v
 Pi7Ww+njugX40rS2qk2tTLKWnTBJ9G+sHO/6yoavpOFUjRACxHeZtFpBD3gr+Af+leIw=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJza3-000000003cM-1JTh for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 20:40:08 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso2146205e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792701601; x=1793306401; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UMUE4H0uxCOomVjiQ3BAn4zX+lb00AdAUoUcP6OUu2U=;
 b=J7yHK0vkB1I3t46q2LDHRIxY3Oc6hKu/LQNE62KkDmFHyEdtsYhe4x85zPiPqYhSRB
 WGTVH6u5lyM/9KgabYU4OKH+ysM8ZHwCzEr4TAKq6p+yVrYcFwis6kOrkgjTomKqATUv
 IZ5w4PBCv6qCn0ttZmGuOIYimjth39EbzXmTtf+NIPFjvMKQjtQG4K5CG/hi8c9bPThm
 EbnTWvculJuj/0k9rM4IvvDVd0AQbPLB41mM6B0Fp7NSVFMCFtMkwGgwSQzCooMZ6i9G
 uoyzYPnCFjsNIf+jNElLXDZohsX5KZCGJtgeUI7UoO64beAGPsRC6FiPPsqyMF8Ufu5c
 zJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792701601; x=1793306401;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UMUE4H0uxCOomVjiQ3BAn4zX+lb00AdAUoUcP6OUu2U=;
 b=WpUezXiZCtDqzC23XAyy0JTocaRNfd7BHfGku14+E/XGZmFnAaNid6jz3BldrDbBz0
 P+Eey3DZlN0BwMLJisS7InwAsGcQni/upS+EPiF7plEpOHSc49r4YYOHdUDd8F4zX0C9
 UKtCe2Lw7yo8/QnB3TT35WYEziHC7lYAbot/5WUGKxyoSjHBt1ap6oCUogKdogaO9Gvh
 di6jjqF8dSDZx0x6ihAtNnY6XWrm8wC57ciKDr4aKWg3T5KYUoAcbcsuEVE2L/mutt46
 4lHgVqApp/Uo0ZxRlG97FqRqGcjdZG1eqv2OHzBSEykjHNpp1rbXzyLt6vL2ULeyuO3g
 2R3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByZ3+rikxWCL8+F0diZrSXGBldicK/6yfzkBW4unNak+kGaQ/4xju/+H0MEgy4SIUhd/F0CTVKhkuMzsMYV@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJsnKCdF/lcxzt5y1ERfyye/iAKSCu4R+PLNjTq6Lt+Ed07YNA+
 WDGNEUNHLlkcRKzRb2oOZD237maHrqzIr505lhRil1DH2n/OnXeh+b1Rc1GdLG8Bi0JiG92PyJ6
 ArjeFoA0hu30JAwf2d4xv/Go9kuljFiP2t9gIkHGTiVMvDc0gUQ7vKvzFCZC7ZmxSvZB8
X-Gm-Gg: AYBFou3WYa30fbZPjBZkSC04W5h6wtMQVWpomaC3Ma1AOezElM+YbRHpTbVaDKBGJIq
 g07UcJutIwc99p7NGaTDd4OcX9Sfof2unzhhgWdUhvfrSGTk6OqZZz+WUbIzwTLKRJfPXn9I9JU
 3OYGGuKYUoNuZTORKU46rW/oGLu/LBU1YQbQQlapzT57bJLPcSvsMIztyLzmmUWhaA0EXwLTBoo
 VJUjdbwS4FxeyebH/UXMS9IvGX8/oLLNhIfAVjcSMXC2rklb1Z33LVsNIEl/pWFb+B67GiJNhVO
 HEyFSGA3zGO0zqnYvYN2OxU6LS+tBkOgT7F7Ubu3tjqbj250lARQH3fw2v/JMuWzYsQB9m+qlqa
 hKKW7NW/axuFtqGOU9m8HsZVxvYTtXNZr8FnP+oitDAny/R7Vz8ElDwghXE4fcFDLQAdtrZLiHL
 /yk4drG4s5Zc4Sc1x+blacAJMiiEtibiHLhIqfPX63zH/m96IUEWQt5kw6UdIswB2Hh53wZFjcw
 RG0WZItWjdvv4MO1J6hLsVtQE8+gSymWLkjGG4Iv9WOvd83qZI6Gh0grEuLfUOhFlChNWvAGWv3
 vhix7BrM1PnNq6KIQL9wA/NHbLeQm+ATGLWog+B0dZ9svX+O3FPHDmtUBcrSj8yjcGJ0NJjapmZ
 ozvpgXqd+Y69n06JScn+aUd94/9KJDYnwgHp/Z1g58es=
X-Received: by 2002:a05:600c:1392:b0:4a1:742e:3 with SMTP id
 5b1f17b1804b1-4a211ecf2d6mr2910435e9.27.1792701600539; 
 Thu, 22 Oct 2026 13:40:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a211b899ccsm7317205e9.3.2026.10.22.13.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 13:39:59 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 20:39:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I10326c787cd8149e7617279e45166073d66b9101
X-Gerrit-Change-Number: 1897
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1897?usp=email>
X-Gerrit-Commit: 52abc98d46a5797e6c823005f89399f370380d3c
X-Gerrit-Comment-Date: Thu, 22 Oct 2026 20:39:57 +0000
In-Reply-To: <gerrit.1788477047000.I10326c787cd8149e7617279e45166073d66b9101@gerrit.openvpn.net>
References: <gerrit.1788477047000.I10326c787cd8149e7617279e45166073d66b9101@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDc3MDQ3MDAwLkkxMDMyNmM3ODdjZDgxNDllNzYxNzI3OWU0NTE2NjA3M2Q2NmI5MTAxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6c3604ff9d37ee8d4ade771bb309b7d7a3e61b90-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xJza3-000000003cM-1JTh
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_freebsd: close
 DCO fds when closing the tun device
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1848169991975383260=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1848169991975383260==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="weDRYjs92rc="; charset=UTF-8

--weDRYjs92rc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by Antonio Quartulli=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=3Demail )

Change=
 subject: dco_freebsd: close DCO fds when closing the tun device
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comm=
ent)

File src/openvpn/dco_freebsd=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1897/comment/68ee7f1a_4718dbeb?usp=3Demail :
PS1, Line 349: close_=
tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx)
> `close_tun_dco()` does=
n't appear to ever get called for FreeBSD=2E
Done



-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I10326c787cd8149e7617279e45166073d66b9101
=
Gerrit-Change-Number: 1897
Gerrit-PatchSet: 2
Gerrit-Owner: Antonio Quartul=
li <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 22 Oct 20=
26 20:39:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-=
Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--weDRYjs92rc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by Antonio Quartulli=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_freebsd=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1897/comment/68ee7f1a_4718dbeb?usp=3Demail"=
>Patch Set #1, Line 349:</a> <code style=3D"font-family:monospace,monospace=
">close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx)</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">`close_tun_dco()` doesn&#39;t appear to ever get called for FreeBSD=
=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=3Demail">change 189=
7</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1=
0326c787cd8149e7617279e45166073d66b9101 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1897 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio Quartulli=
 &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Com=
ment-Date: Thu, 22 Oct 2026 20:39:57 +0000 </div>
<div style=3D"display:non=
e"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--weDRYjs92rc=--


--===============1848169991975383260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1848169991975383260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1848169991975383260==--

