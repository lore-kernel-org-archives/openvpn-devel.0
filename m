Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F8606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JtkrjURz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hXrg5YV8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZzkP9uFc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aMj+ITs9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0tjLMF5O3mUB0FcfsCi6wTn7BJ9bHCtwK3avGBzY2sc=; b=JtkrjURzF0CbQMbTsMbjHyz/Y7
	v2ZioETTLSN4izr6PwF0xhLJCfYHBDusaKaotUewohiRC2qEj5GLlAYSqCiXjM2HLRDxFP3k0xJ9F
	LC6D1AUFC7seZO1R5B0Od36xg6HJKQakwJcFbsSMELPC96pX+Gyi5ApZ8ZvB/ytz86pg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLfkE-000000007l1-3F5t;
	Tue, 27 Oct 2026 11:53:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLfkC-000000007ku-3PXD
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:53:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tFRBUvhFf2aruVqE8qeeIwzBweSao1OGUZ4Xth3ZkNk=; b=hXrg5YV8c6jlFsGovlBsm7bUME
 f0UN6QO2wnaQhxkDTAe7w7IU/5GhxX2ip9+sB+XsUYWFPx+JUd7mVR1QsQEpju3zdE20gwjk1haLl
 I0GyxXSto7d9juHA3AJgaddpny57rWTg3FzthiG+s2ndCiCcl+KXIdzg0iOhGUtb0EPA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tFRBUvhFf2aruVqE8qeeIwzBweSao1OGUZ4Xth3ZkNk=; b=ZzkP9uFcEEKBuyv0IK4+G0Xnh5
 v4+ySag+CVNzcy2eezRSp3vxlB9y1sf44cYF4yggDB8s1W27zU65aFnQ4Fv768/kERLsM5Vb9RCSV
 +oQygCzZueN7ZcWdLlVdHURmkhXWXb5MinwQZ4YetCvm3JGTdWLtmQl6mCiGQxz0bZlE=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLfkB-000000004Rv-427m for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:53:32 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so6389975e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 04:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793102005; x=1793706805; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tFRBUvhFf2aruVqE8qeeIwzBweSao1OGUZ4Xth3ZkNk=;
 b=aMj+ITs9n7qEb4d3YPw11yMyyXkOU8tbS6txY9OxvdmBI3UlcfBBX+PlzxNcRTFzdU
 u7UfSZa1nJl20fnIt+bfQU74SfLHf7u7ngnqwP8RPaELQiAXw4ovdPQXCc3512JBHVEi
 DH752lTQJ0MnT8geZ+/q4FUSXlqcbahVaPB3A9NnwAM2AUfJlMkX62DemP4PclSmdWVa
 mM1Q7o2E3fsjQOmf7A0weJmYreOFbAtFgj3l7DXH32CmrVxhJGbJTVBx43DuFZaafcCu
 1CWZm94U4f2G55gc2SsERKZgV7j1E6ppMxQycT3FiEB+Yhm9wipUVEiVGmOl20fhjPso
 gNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793102005; x=1793706805;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tFRBUvhFf2aruVqE8qeeIwzBweSao1OGUZ4Xth3ZkNk=;
 b=KvBr5tEh0C8ASLowekCBHTjVSLLtzNHoDA/9PaD26C8oSScLw2u6jBrfpgqAZWXPPD
 9ZNRq0fsVGhShhtsRU9YntXDDmYWVgzXv0pZXSXcpDvICH/tMvjnRcVTfyp9ivNNKSqS
 MMtmzHiYWKvqxLErZ7vIQuWs8KijUN5GoE1r3GmAu9Dn4oZTTvKqHLcINwjZxscVHJJY
 hb7CndZjvNS1x5kYzBadmD1tqFhzGehgp5xaa3H+Nu5aPckVHBIKhC6XVH5Di1Ec6oDH
 oDUuRH9xvavAgTH2sk9/1dZoQ9mqzGwghzkKcL3BSAeimj7Ec+dhAXjUUGb6/4lVJDdc
 +7Sw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzB4cGqKwUa6ISvwrVXxLgV6YmZJuiXoFifqfsWEE0dVn3jPru2/X2Idt0+gDMuozL2M8KzZ2qfXredvxb0@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJVznUS+Fcs9URtcOl0RaOQyJYFVBfpCinIGXRNixUYKgp5ipsj
 iMvk4lm/ojHG61R0hklZoaiaOHnp1gp/WVTuJlIsYqEUr2LYFdSAZTHt8I8+VR8sE3AHRNx90Vv
 e820xcHFf5/hSouGX15u8cET+GL92FjP+LkGmm6TRLrLQJwccH2yXE5+UNsfcN/fBLv41
X-Gm-Gg: AYBFou00CEV2TaAMyUQZgyyFHyeRxzEQv8tH6Q0Wgee8cijlb9cKWxDjWj4Q7S7wrho
 AYfuu9eaFKHN+JPckD6tcnw4iM/itw1gKQIhRyUMTzcnRZnDjqETQXof2gJ4agQQmLz4UeuTWn7
 cFToqvKlakaIyt7QLaNnALfwsLMtL4XXxIkRsw2RJfvFmrNnRmCjiYJDYs4GvHpoB1t8npnGwGa
 NUzP77VeqHcjxrNVRMPCrmMw6ISzO3xAYetpx/PnKBjMB9LczYcfnMdDmW8xVvz2wl8oZDm8mk7
 XYSBRYNKgbI6wcKfU5645xYClPfOdsHl90w/HuCpcG6+bGrIfxCGP0J/vQ4+P42JES00J7VJUiB
 tVIGdNhxib/xN/BIvdtBc10JtOJM5XV47QCZvnDxsYh5CqTgYJyoY5IoAiqyBSYWT53XK0qt7PB
 ZNbZDkJj/vHBAJhtBpuaAPHWpzsSArK51u9LqOZNOQ66JEzVojpIngVUyVarQ4FkBgAOqVh8qmd
 SaIW6XwC1UfzDW1liy9Cb7JVwuUenIvsiknQa/+CVmhnYgEpoUqDeEibNzMtqOL5ux3ugTBSdyK
 K8wxVyoclrdMJctUGl1EmT5LnE9dFNcFGvTbjEoDYiYDBnRnrZtGRp1C1fL/x0gJUJBu4Q12rhT
 H5l8z+dnRZ7bjpH55PoOGtrHkyFF4+QNSkA7e57tzsg==
X-Received: by 2002:a05:600c:322a:b0:4a5:9224:fa10 with SMTP id
 5b1f17b1804b1-4a7c60a0174mr38533315e9.18.1793102005284; 
 Tue, 27 Oct 2026 04:53:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4bc5sm22595954f8f.34.2026.10.27.04.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:53:25 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 11:53:22 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If09735841cd90aa4b07e85448ccf3b2f5944528e
X-Gerrit-Change-Number: 2054
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2054?usp=email>
X-Gerrit-Commit: 99c1de64602c12a01e50fac2a373692a941c0d95
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 11:53:22 +0000
In-Reply-To: <gerrit.1793096063000.If09735841cd90aa4b07e85448ccf3b2f5944528e@gerrit.openvpn.net>
References: <gerrit.1793096063000.If09735841cd90aa4b07e85448ccf3b2f5944528e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk2MDYzMDAwLklmMDk3MzU4NDFjZDkwYWE0YjA3ZTg1NDQ4Y2NmM2IyZjU5NDQ1MjhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ab747bbccc1555205cd0922f5f8789bc6248153-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLfkB-000000004Rv-427m
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: add support
 for --transport-plugin
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0287698628924178736=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0287698628924178736==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fEUnsSJXedI="; charset=UTF-8

--fEUnsSJXedI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Frank Lichtenheld has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2054?usp=3Demail )

Cha=
nge subject: options: add support for --transport-plugin
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(2=
 comments)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/205=
4/comment/92979c4b_3fa148e6?usp=3Demail :
PS1, Line 13: The fondamental adv=
antage of this plugin is that the core codebase does
fundamental


https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2054/comment/44b9c63b_59bff22b?usp=3Dema=
il :
PS1, Line 22: The manpage has been extended accordingly=2E
A lie? Noth=
ing in this patch touches the man pages



-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2054?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: If09735841cd90aa4b07e85448ccf3b2f5944528e
Gerrit-Cha=
nge-Number: 2054
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <gia=
nmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco D=
e Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 27 Oct 2026=
 11:53:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--fEUnsSJXedI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Gianmarco De Gregori=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2054?usp=3Dem=
ail">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2054/comment/92979c4b_3fa148e6?usp=3Demail">Patch Set=
 #1, Line 13:</a> <code style=3D"font-family:monospace,monospace">The fonda=
mental advantage of this plugin is that the core codebase does</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">f=
undamental</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2054/comment/44b9c63b_59bff22b?usp=3Demail">Patch Set #1, Line 22:</a> =
<code style=3D"font-family:monospace,monospace">The manpage has been extend=
ed accordingly=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">A lie? Nothing in this patch touches the man p=
ages</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2054?usp=3Demail">change 2054</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2054?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: If09735841cd90aa4b07e8=
5448ccf3b2f5944528e </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2054 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Gianmarco De Gregori &lt;gianmarco@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: T=
ue, 27 Oct 2026 11:53:22 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--fEUnsSJXedI=--


--===============0287698628924178736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0287698628924178736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0287698628924178736==--

