Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882BF606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WyCSoqFA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kfhfxH4D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AFcudp0f;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gDcPlxG8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nJgEK5fDp9x5fPQH/hXpRzulL2ZZROe0wMQDkKiqMDo=; b=WyCSoqFAZupKkJSIQ0+LIxfKCt
	EI6RuO4ixmQuo2zmEqnDOvU8vN5me3T1R3u8qRjNU7DnAOTFIB5xT2up9rADL6YMJuxokGjISjPB0
	khJF5tFITf/0mHYFzvH7yoTwt0/fkHPwSg+AZ133sEgAn9phLvmAozWqVCRW5Z3ek+4c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xK8oi-000000005QA-1rui;
	Fri, 23 Oct 2026 06:31:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xK8oh-000000005Q3-1Fvq
 for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 06:31:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2GIBvFRVzEdIiA8D4tmtjEETevxy/IUpJ33qhuF825Y=; b=kfhfxH4DWNYbbvcZk7/vmXxbcd
 0n/JgVlxqX0grHXBH1GGT6Y3KWv1egNBOFBC+DUBlCM8vQy26vjeW2Ac8dzlM+FD/62rIgL53FgZH
 9X+NjgS8mybHB5QtUsUilJwqNfz9NE1OPKivZya1Z/r0j+vbvxK1WZiDWUp6rJdAp3SU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2GIBvFRVzEdIiA8D4tmtjEETevxy/IUpJ33qhuF825Y=; b=AFcudp0fE4mVABCt6PQaa7795R
 iLjzw4FopbX4cmpWLycyrLm+/Tr/Zq2brPzkLELAfkI+d8WGHsGR8UDNMQ1n7o9293n8QFLW9C0i6
 NwLxU+r8S5KdnroipHe/TRjqbmSn16113yC8RAX1HuQirqy1LMMix8am35bpn+lgp0rg=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xK8of-0000000008J-1Ksi for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 06:31:51 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1ec92f655so4327585e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 23:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792737103; x=1793341903; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2GIBvFRVzEdIiA8D4tmtjEETevxy/IUpJ33qhuF825Y=;
 b=gDcPlxG8mFaanRYzn82qWOA1x2WhuKS8OCn3DLN75QGBbzrS14enupnLY77B5iGnZW
 FmOpf7sO4DAL0v3DDlFC+hbSYQit4ggDx3Sfki7+GwjAP0+92YmIyJlyTkE8yaGUoqep
 WzLq7t6perEczGpT+fBzVvjSsjwneT1gPpJf7GhJNGrC20iZcjLRuuyM+te9ATWXws3m
 bBWG7MvR2tC99M5zSPMm0RrwgZpFdZOom7Hga+3pxMJgHTNJMcxPF27CNaT7IhA3XYva
 cQv4fsx9G5LXdXFtb2y9kiuHgbI0FoqmWoMARFHn136z9xlBon3y4g5daSliLuhOWCic
 qhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737103; x=1793341903;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2GIBvFRVzEdIiA8D4tmtjEETevxy/IUpJ33qhuF825Y=;
 b=HhVOq6EECdGVcL0fzZVUdlqPzrzWq0MUXl0liJv/U7FVjvknyJZsOFwGwh7I7p17J4
 mQ2YjiEvbnus0SyPSGWQzeNVR8fZJ8EMMfVI5Kwg/CLCJo++VKzqpr620Scblj6EcePn
 ZP7LjqXf5BpxB27CPbcVG6egfqZ4rkDjo4mP6j4xvRrItBcz0F1kbnY7e+e8Ke4j8NOV
 CA7NaKohE6joInxWvQTbWcB+ThtkT/Dht1m7gm363qLydOnqFBNa/30L/1LiGyjADFRG
 ZwkXP7e3DBNhCaaaMtKGnrUXqGDI10YQoFJ3K+nLAaBiFlRKKkZwCaqfBSvnoTTVvPxS
 3Mag==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1pMbBykJ7qjOTPlL6PSQ0NtzmmMqpyQPhUctuK1TM3ZnU0GFG/IOx08RomO/ZQZKC0OiprsMkJfiHye47@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJE/zuougQ5oddWP7neytVMigWv4qhtJRl8VA8argokG0lTiRk4
 zbemZ3u8gG5LB3RyzavNhqm8yqvrHVQf1X7S2lpBmgZOER/A8LOGJjouhT4SucBI9zOX196R0BC
 7yzFeC27Vo0PRMqMCSUkdCWcOIFTV5b00c9oZJr23T/M9CkZlW+5GqrUg97ZjmT3ZH8Ir
X-Gm-Gg: AYBFou2nLp+RBEUFDrkcDmahNYPL2/dVrUj0BADjCit/Vxwp5czSSoWMQWwsDDgUFqo
 xVGSSWCm7L1WwOYUzghcun+NAOozik/PCyRn/ODxMlNuhlO/TVe7uOYpcjIMFvfD7jKql82fUuU
 VbXJScTpAgl6psT6FyCBG78qNm/hCghOFyledd7c4TO86RoJ33/KMs6tU23XHFCz5aTq2XTZ4Xe
 3jXXpRMBw3PMQU2BXoKpRt6UYyws/rjunXTS0gnFalB5Xkpz2NdG/kKOeknA90vRFQFQxNPb3CX
 dsX/TsD4mzVxRaU7U+Pjxj1dTzNtrZvhqs2x0zWqWOjIUkLLnu5M7q9cr9rZ7lxlQRmLFqmM8xH
 7GQa2pe/W1XjafZ+uPnLZFZW0m66jYyn1erdZfxhO3B2KKPMNkRM4A0eAFaQ0UexLLMTIM2CAiy
 YhJqq0Yd95n82thzwTnR2tXzsCG+uXJ4E+i4sXL5+8j7b3a/wTE3ARmJeNa1F30dSc9pfcoDQ0B
 a9iE3/+TCoL49fTwW7sioODJWQ+7dVY6f4AloTEvLiaCAU7RECe/hvKVOHDOIndPuU5ecQXc/3J
 xNtQBHJ030bRQZ9bo2PYA6Rm7U+vl8MCL2mjKcTg50+DQRjfnPsZcUzbd51dfCI9CNpGIPssm9t
 CJtL3KefTNaE9yzD2rYwoRcjGXHwnfqThZEf136fV3tM=
X-Received: by 2002:a05:600c:6289:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4a211bf040emr19488965e9.2.1792737102529; 
 Thu, 22 Oct 2026 23:31:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2153c1b7csm14313495e9.1.2026.10.22.23.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:31:42 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 23 Oct 2026 06:31:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I10326c787cd8149e7617279e45166073d66b9101
X-Gerrit-Change-Number: 1897
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1897?usp=email>
X-Gerrit-Commit: 52abc98d46a5797e6c823005f89399f370380d3c
X-Gerrit-Comment-Date: Fri, 23 Oct 2026 06:31:40 +0000
In-Reply-To: <gerrit.1788477047000.I10326c787cd8149e7617279e45166073d66b9101@gerrit.openvpn.net>
References: <gerrit.1788477047000.I10326c787cd8149e7617279e45166073d66b9101@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDc3MDQ3MDAwLkkxMDMyNmM3ODdjZDgxNDllNzYxNzI3OWU0NTE2NjA3M2Q2NmI5MTAxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <344c4035e1d7ea57cdf8f07be7187bfa7e1032bf-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xK8of-0000000008J-1Ksi
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1300859616159060257=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1300859616159060257==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dj3kgRvA73E="; charset=UTF-8

--Dj3kgRvA73E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Antonio Quartulli=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=3Demail )

Change=
 subject: dco_freebsd: close DCO fds when closing the tun device
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I10326c787cd=
8149e7617279e45166073d66b9101
Gerrit-Change-Number: 1897
Gerrit-PatchSet: 2=

Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbi=
t=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Comment-Date: Fri, 23 Oct 2026 06:31:40 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--Dj3kgRvA73E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Antonio Quartulli=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=
=3Demail">change 1897</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1897?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I10326c787cd8149e7617279e45166073d66b9101 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1897 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;anton=
io@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Fri, 23 Oct 2026 06:31:40 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Dj3kgRvA73E=--


--===============1300859616159060257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1300859616159060257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1300859616159060257==--

