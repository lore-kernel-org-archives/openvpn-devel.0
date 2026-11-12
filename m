Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C0606A323
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SpNaeVpN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=J77fCULI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FhY/07Ha;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=acnCvRJB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=60jufvb5/Pj/GXKmtLApbvR65WDq98X0itzya/sWTkA=; b=SpNaeVpNry4QCHnf6KFqaGs53c
	sTTlU+hL+6UGPkCPwy2nNlbkyNpvfjp+6JrWXP7pJpkGPlBbVG2KVdvam6FDqeQUsA2CEjrVq4IBc
	eLu8wV60M2hX7HOOeyKEwx9b4UAmPsR3sztvIeIUlcHaE+0jBqsU+9U5xBHqEEVfQCy4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRQ9n-000000001Rg-33Bb;
	Thu, 12 Nov 2026 08:27:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRQ9l-000000001Ra-33yM
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 08:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qy4mUUalorDLezsCUwnJE0zZ6WGSnu029Ue1kOn7uCw=; b=J77fCULIEDFFU+bAXmNMnhVGqc
 6gO5AxYUW8towUXY5U7o3VRTh2tMeqFjiGuJDucV0UCqxOxgi54v+Vf6xbVna7Zj6lL5KXrJYvaBp
 IwrwzsDgMx/yRiImVDpxqqPMpk6nhJmdyNT9meSPsqIWJgNIhWMZjh4rrsXMHhHQImBg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qy4mUUalorDLezsCUwnJE0zZ6WGSnu029Ue1kOn7uCw=; b=FhY/07HaN6p3Y+zS0lzFFBmAH6
 VturET7ao9JMpabzYxUyURURUcy3oooo6beEgFWf1okKWR2iEl3x78c4z9kzsh4g9dYvawQcg4GRu
 1U56GlQKqjinT6uWRDkXDy6KgaAH4SrQW5sjDJBZWP8qjTad9M1WxW0lggJewivq60RQ=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRQ9i-000000000GR-3nFc for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 08:27:41 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so43560585e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 00:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794472052; x=1795076852; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qy4mUUalorDLezsCUwnJE0zZ6WGSnu029Ue1kOn7uCw=;
 b=acnCvRJBfAgQek15BEzgj1rEQC3pN9FW/80qoQYsqrZygVFWSTz/oN7C3dD1aASTIL
 4C+D68hCQmmG9JeYf6AQPOmH0bKuGoion24pakcuEvGmd+pCmlNWwF53svkR3wfYbc68
 gNVgynzUbfuEXkUcznd/E9/Z8eCxVP8VPG7qEAdZMbLSWFCNtRK9bZY6eJvBBXIINExv
 Mwb+I+nsp6kTHAvbeHKfGWZ+ndbef+o8xxfQed3VjuH8RMxSTcNhy9hDvdB6+1zTm9kk
 JDVKKM8/GBD69k2hPoG388jDx0EuejWQFtBsP2maZ3UZp1xvjNRHLrB+MyZ3p7AOyH7+
 /MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794472052; x=1795076852;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qy4mUUalorDLezsCUwnJE0zZ6WGSnu029Ue1kOn7uCw=;
 b=Ho0cvFkf2rKtuw9/4iz/4Iyx+BczU4YqWMzot8xmgkHW4ps2c2IbKDiO7bKVG07Xw6
 nePIcFRfjHUoR3mobvatRQ6Uuceort5LO9V9m4eXPFBkdQw5C5GskFbwFoobTG7LSdbS
 vKaXt+ggMn8QCBLZusuWox12CainOw7lL02Qb8JUzZUmlpnQ+IixMjtgBTDHgUTvMZFx
 nArCtprGTHUG5H8PfvICyox0CGvjbFpclVTbhhs5jU1+Rnk8rmefWsLAs4eVQfJ+iqAT
 ifUVkok+reiBpEhv+AbLArzVWgykXTDtuldGZTImL6NAMGHYg+jA9WhI6OHrXJva6c21
 BygQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHv0zAwjwAF48nmvJRulcdJZ2yUS9a0DPbZl77JLnOXDIzt4VvXKh+DBVRpHFFrvMZD+NejYTCIlJ15oLtl@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+FxUvwPbo5NLBogk91B7Sp9RfMvs8d5hV3ppdaIy28UG4GQM19
 PBB0RJuLbhbdHm7Yr+vmM+hu7p9FLDecNN5GAlV92zWPUOsuudOLzaWLzAI/8SV8FYvTKEKe2yF
 z9137heMNbZ+hfkLqisS1HzTOpLXbvVEXbTOjvaXvFFrBeJI7A9GsWXbhGEQB7ux1kHucTCxNXZ
 KuIvyj6A==
X-Gm-Gg: AYBFou3rBhKSrFNabRIngJO8DFI9S0M71ATehtcDnJy09Zd4kooiJ8xoQLY1v4QgLII
 eTfDiSi58fyFBMBb2QbCqaVf10Hg0A7bCKJ0Ee8rB0l2nMGhiFNO8hq2gjL6vsNaiYcULtPlt7/
 wcCimpudBgrVEpVLRgirdy2w5INTZzSwrON8pC4NhxRlt05vzzorJHp2b2vHw85rZNurT/5xHnq
 37dtuJrVYXRDHEJX8LfOCPmg+nWRhg9Noh3Ryk0N+BG9guPleH1b5Sv11IyGH9Y6hgD6zhYgd00
 fhT+opgZfHakGuaNEFMD0PFiApO78u0LCJO39z56Vagf/9jxZaRyiTSB/54+H6XWXCWhcDEpR7K
 8yjJPN8QlPaBZ2u3kxSyziHeXWMD3AV3JNc0Pbn3otEad3yfgBzE7JTKGxTf0WSYTxt/md7YXvU
 KIPjjexj5ZOwdC9cPcA6YZ0782Lwmv4buBdirKz3tmboCLP8zLvTyi/X/EKQtmOvpbNvYpMKvNQ
 ghzWGlrJwo/4XozZ+/QyGsnAp6Osd/3lPvxcTdrWSIqcRBzs1W66urEE+HnquB+O86vXdbHXVAB
 H+fzjOww8bNcr30QppfbqVf1+WO4hVJcPdcFEUAjaMKq/Dd5pP9MCK2DR4NE6Q0uD5AJyIIrlJU
 I0/ZiVQQCP4HoG5g38p8vzW+PG1nlO4eZY2aY3/aiqrQ2iHqooF7FGFz7PAynN8CP3jRAw+Z+6d
 +U6BziPn1X6pRDqDM=
X-Received: by 2002:a05:600c:c166:b0:4b3:ad9d:e21 with SMTP id
 5b1f17b1804b1-4ba0936ed51mr91909245e9.12.1794472052203; 
 Thu, 12 Nov 2026 00:27:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm15959933f8f.18.2026.11.12.00.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 00:27:31 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 08:27:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: 840b0bd7cbeb34ecb479f1d12302b8c037337bb0
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 08:27:30 +0000
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3656dfaae01dec84a535ec92c16a31f182f3af04-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xRQ9i-000000000GR-3nFc
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: reject
 a config file passed without --config
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6591882494018927964=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6591882494018927964==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BBiZ5kiFXzw="; charset=UTF-8

--BBiZ5kiFXzw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Heik=
o Hund=2E

R=C4=83zvan Cojocaru has posted comments on this change by R=C4=
=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=
=3Demail )

Change subject: openvpnserv: reject a config file passed withou=
t --config
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 5:

(1 comment)

Patchset:

PS4: 
> I don't think we should make =
this work=2E Any caller know to us uses --config explicitly=2E [=E2=80=A6]
=
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I57469ca50c5=
51ad475510690ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerrit-PatchSet: 5=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Heiko Hund <heiko@ist=2Eeigentlich=
=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attent=
ion: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 12 Nov 2026 08:27=
:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To=
: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>

--BBiZ5kiFXzw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Heiko Hund=2E </p>
<=
p>R=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Co=
jocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?=
usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2159?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</=
a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">I don&#39;t think we should make this work=2E Any caller=
 know to us uses --config explicitly=2E [=E2=80=A6]</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2159?usp=3Demail">change 2159</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I57469ca50c551ad475510690ecfa=
2d5e7cf9cfcf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2159=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Qua=
rtulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: Heiko Hund &lt;heiko@ist=2Eeigentlich=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@i=
st=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Thu, 12 Nov 2026 08:27:30 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comm=
ent-In-Reply-To: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>

</=
body></html>
--BBiZ5kiFXzw=--


--===============6591882494018927964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6591882494018927964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6591882494018927964==--

