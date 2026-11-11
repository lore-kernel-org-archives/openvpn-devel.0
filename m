Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35908606A324
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LkLCU1/+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OkEp7PXS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZIVMQyRW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K45vlCdR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=E1lOzOy8uTTz6X+cba0YLNrkU3WwrkUO9m+sVnYFimI=; b=LkLCU1/+otWRxK5j2hQe7zGCP/
	3XVatFeQAejt/eR1GWfnZ0zUenKklP2X+Cz3xU9TH9//e6q8P0QbfT9vsAixHqLXJmRhHcmeHEccX
	lKooRD43ugTMxTM6bcvhthqZpt2osekg55v4hdRQ0I7gOPQFWW+QhHKyBK3EkfURmqo0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR67V-000000005m5-3lQI;
	Wed, 11 Nov 2026 11:04:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR67T-000000005lS-0xNg
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8PX+Psug0biZ2ks9lvCZ8+C9cR0Lti+mV9iIjAKnhHk=; b=OkEp7PXS9QOaKt/litcL+/7F+T
 TnRvQx3M3ANkJjpDR6CDC8V5kPR7WXhhwUDx7rih8rAOThDAYMqy2Lr/RRmzfgapC53rgVQd/f634
 8oKxisstqcoIMHRucjWFgn5JHe5BPVbVbPwFPpOnomWWs4rWwkRLKMzEeIOl5RrFg3+8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8PX+Psug0biZ2ks9lvCZ8+C9cR0Lti+mV9iIjAKnhHk=; b=ZIVMQyRWYpKw6o1CLfdW0xWx5H
 JqPKogPsEOiduS125z/EkMJBV1H6o/l7eJ5P3DV0K+fkkxe9N98bdWes6NO52+PXu0VOJXalx8qyr
 PUNGvjhRZSUqhnG25zYndtKffUCES/xBSpEV5WxBlDxrC7NsWP91APdmbO3a2KYLWLmA=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR67Q-000000005G1-27Kj for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:03:57 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so1743474f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 03:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794395030; x=1794999830; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8PX+Psug0biZ2ks9lvCZ8+C9cR0Lti+mV9iIjAKnhHk=;
 b=K45vlCdROQwPTJxWk1yhIFZElhVSe/QHPlMbIZXcUunZJGJgUrBmQiPKG4vQCYTrOS
 9cZJswIVA8IlxJ5WGfIbV3bZGyuJjC7QUCMtdG02AwYIIjupQLMaUaTY5Uoook2mFpoI
 TD3aUtgjn63F+kS9g92+SO1itt3qB320dJoFrxZG5CVBLji7UsbjkvJwyXC4LL1zUZX2
 +B2JIk/AGjirgttNUVydrM5CJiqEWDbCaOTFzfUwkqh38jOKx8tcBvIwt9fUwLXKFwdY
 ZtM8YFrObIojpvw1ukKkMgSSHRa5qd4pnyUJT1auulvcvBPrt+bTESmG1mE9YfvD2hmq
 +q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794395030; x=1794999830;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8PX+Psug0biZ2ks9lvCZ8+C9cR0Lti+mV9iIjAKnhHk=;
 b=UnFIHP6HiTCiCXfD4wCXavHd8LLf5DkUiGkdv6JqlcCgVFHcbfAHeXUjcFglrbCJbt
 Ur+kW3vfRHgqQgrtR/e94jSFfe6Xsgv2VvRnwu+ATj/b9fCK7RdQ+FB/EG0+AkJwWOqg
 5j1N93KTcuwFSIozSRSOopJA3zxVaZQeUQDJ3LUW3sug8WXp51nMIS/+D3RMcyvA/4+/
 U7qGRxeUnNle36Ir8OXu7Pogu4c5LQvUk8Vat/lYy6DdwR8LOFKF+rzEANAW9jSk4Qm/
 R+TLDWrUJT7R4zZDxn1h6xmc0jO9ppAt8f6WT+DsnbGAdzVLgcTMslGVahM1mxkkllY0
 47GA==
X-Forwarded-Encrypted: i=1;
 AL+hErHuR7IQrFU06ysn1epmgZPAS4gBbHQ21KsGH1xfXh0IrT1BhrIDzzRWWLc1MfXKsyPvQLG/xOWivfC09cO6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9khSJ6bV6YKl+SD4Fku1G7/1C7h8VWW8lm/1qpju1pVDZ3Mjf0
 1qmBo6nU97R0MsesHGXANuUtqBT8HiUBZ3jUni2/VwmNEnaAypv9dItWoq4JKqDv1wCc/8HN6IQ
 BVLfa0q57oEKUXiJg/ovYGcuHTRksAyia8sgzHSjD1RuYVf47DYfY3suJH6I7RNTT6DK8DBMW2O
 oe19YvMg==
X-Gm-Gg: AYBFou3DWH9nd5jHhSGdJlNFSn4Nmll20tHFTuNeBlNmzVFyzoygiGP7a7BZNv357zv
 n9aut5BsinttGbTIcgRHCbtgteYRHfvfhRf7HAVaytnpMnLdwWaaNKXMNswDNUbJihq41FqlCbd
 1sYrxFhUJRX0CNuqWw5F4NSNJVtlpIAqfu/bHbNR7of0uBt4fsytX8mDgmCVXe/JOvwi1RITDI+
 DhgT4RshZd2W4GS1ZnOnqfqUm5L+vO1HtdoVlFgTa3VENbgUlwnnZk3DmYZfs3fDA1s/tL/dNZ+
 ya/THg82sr1lylrRvRklS2oBqe//TBSqO4S1ji62mWL0DWadDvgcc+JVR1pKDaLQhI9lGlr9zht
 U5PW4rBWSkMlFZxLEJ+syGxPXZH7kygx5o/zkLi5CFgkmqnhr+24exTqey/YU52SwmCGut9sTiJ
 kI7HJu9bebaGECQKPV0jV7ZQC8m6Ynfir0dV0Zem130fbpkeqaJJgFDL3nrgAY/Ze3/LEsi/b4A
 Z9RT3JTVE5OQMfyZ5MZDvJIdMzRxt4rtaY8ne+TaWt6btXBl7jwRZFriXBbHluPWO6pxndatHdF
 i9mtz+YPZLVrkZmxdMlnbcmxAr5ZI+iyzJryQmlfIPcfigEBLmaKEUTXamOwPf4WGl6lw6u78Cr
 yapm842aSTESG670h9b1RJsXtv4jxx7A2zcnm3/rS7TQKR2LQqegg9aQM/OjeBb6XZ1yAVjTAct
 GGeDzVxPdIITti5MU=
X-Received: by 2002:a05:6000:250a:b0:48b:db7:86a7 with SMTP id
 ffacd0b85a97d-499c8c6703cmr3762565f8f.50.1794395029718; 
 Wed, 11 Nov 2026 03:03:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835e20f91sm11281966f8f.27.2026.11.11.03.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 03:03:49 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 11:03:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: cfcfa546220d8c080dd4b07f6cd326808e2ae37b
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 11:03:48 +0000
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cbdb2f8d1ee1c1954566ec53d766f2451b0ba1b7-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR67Q-000000005G1-27Kj
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: pass a
 lone config file to openvpn with --config
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1601346895421505365=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1601346895421505365==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XjZP3aXSZEY="; charset=UTF-8

--XjZP3aXSZEY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail )

Cha=
nge subject: openvpnserv: pass a lone config file to openvpn with --config
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:=


(1 comment)

Patchset:

PS3: 
Pushed v3 to fix cppcheck warnings that wer=
e previously suppressed in moved code=2E



-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
Gerrit-Ch=
ange-Number: 2159
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 11 Nov 2026 11:03:=
48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--XjZP3aXSZEY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2159?tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Push=
ed v3 to fix cppcheck warnings that were previously suppressed in moved cod=
e=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2159?usp=3Demail">change 2159</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I57469ca50c551ad475510=
690ecfa2d5e7cf9cfcf </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2159 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio =
Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11=
 Nov 2026 11:03:48 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=

</body></html>
--XjZP3aXSZEY=--


--===============1601346895421505365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1601346895421505365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1601346895421505365==--

