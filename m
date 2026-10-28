Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ADB606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F5QvAna5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Yo7u7qIR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZQT4EenL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ENtaYu0c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VwbM1QOb9QV8lEzRVTfceajDKjs0h6ES1su48lR7Sk4=; b=F5QvAna5SnPwp2R0CsXNqdnaV/
	ewoAfvT5+hlPjGpgJb/t+d4TKy4r5TYmRn2Ivt5c7F4v8LjebxPh6MHahMk7EItxegHKhYnmKmAyZ
	mWUuEAE72Vr/qjn5V3ZoGeG50gAhLWtrC4owQ0DOdO1iSBRYIxQu3IEnnVRt9Enr5h9c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM6MC-000000001yS-0Nkf;
	Wed, 28 Oct 2026 16:18:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM6MA-000000001yJ-1atH
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:18:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Aw3vw+/a41sWKBtO6KwT3bs8G8zCK7fSBIdBgz33qMM=; b=Yo7u7qIRLhLll8BImyygJj2Wt6
 0xXVDmC1CWs/XJcJDySRMwAIW/O8BYCLqhcECu/lgPkIzW/8XdT2WvrnnR8VFM/AY9+F/VecaZB8/
 L+zg+hU+nxtIH7Lace7yyBq78UUiZwkJdnCPWSMWKGihO5maBGqnRYdJY392V7I8qqB0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Aw3vw+/a41sWKBtO6KwT3bs8G8zCK7fSBIdBgz33qMM=; b=ZQT4EenLxVpZO5GqI+T1xS7E8p
 nA972PjcIPyaHACDU/1977GdDRoHYoWnLN4gQNw5ZaLUmaq+XE8nMec4sQDXpSiQ6Cgr5wbkzVlXJ
 fGwO1tPbeFmUyQwd48EYh+fJEHyb5rloCmWk0njwe+II/YAf3EPOIpQkCz3ozWon/yOw=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM6M9-000000004m6-1YTE for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:18:29 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so8619585e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793204303; x=1793809103; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Aw3vw+/a41sWKBtO6KwT3bs8G8zCK7fSBIdBgz33qMM=;
 b=ENtaYu0cmgvXWWFGXHkKGEfNGzs9CFB3pPzklgagIIcW30ZfFApS2Lw7BRUVgKSm8l
 2LfiLxEbzImgOx0a9B60k71/Qb0mgV/SgZHzGT9/hiJ9dC1Gd77CwkD6PYqMV6FPdCFo
 WjhLpBxAnQnEDW2bMT6G5AH66OwiGpXVmvTEF0EZdXZYjb2mUEtckZYwLlAIh92d5Waj
 KAjYszerCAoR2IRHkD27ZEgS6FwkGHsTYLu+3vRuFYtV/grBELYeqZeWBisp2eS81JKn
 gWydv0Jy0MV6HiJKJsyVhDUYDw2+t/Pq4I0gweO79LjoNKdt1DZXcczVcvvgPjsczK6/
 gWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793204303; x=1793809103;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Aw3vw+/a41sWKBtO6KwT3bs8G8zCK7fSBIdBgz33qMM=;
 b=NJ+XaAJRftAQVIvH7SdgJn+sFZbHaM1V6E3Fv0OpYTdK3Pip76lb+Jv6otJMB9H6wg
 n9A5/LjeyKJS6MOHBLZRvc5zul0CAWJAp5vBgUfhRYQPqmnE77ujGYck66vSNEPQlvd2
 9B2GficZzmuIncytkYpyVsQXjfjlIEdFSofJsB1IfDUjdlFcDaCXhfKD5BxvVB8DFgWB
 0vkIEnoqs6/ccZtSJ6krIVwipQZbX7RVhVZIDbY3F2YOp/Wi5TlyHvZ0mi/xYvqWZDyN
 sGbaC7HBkMGag7TTte/DMp1fF7htK4X23wlgY1/xjgs4geWp567dcEG/n73f0VzVOBv8
 Nd6A==
X-Gm-Message-State: AFq9FYLJdV7ZK6C1SXQ+cKlXYf6ZJmmQrM6jgeFhYkHhR404ADPkNSnz
 FIq30T96qHmHjWq6JcaV8dW0tAdD8hh19R+xzZtlIwp+cL9HcjHuEMnB0WZw9S1Ms9JZP8Jesbc
 7gAjVkR27m2PykjILsNxe8rg8ZtPjtl2xbuVua2qj+gjnAlrpGJrA81YiTAls71RNCRzK
X-Gm-Gg: AYBFou0LWKXyhk5OOk9q1lgaf+gPv0AuyTPl+80UzPQq+Xi9jqwzQ/bQ47uUh23TGl/
 g/cVjNsmvq3+kyHbqobsRfUc99AB3xDnW6JII1vi5QJgiwtdFeuCo3h1I89OtJ8vhF/VVTPKnFM
 cqNCw6Y6/kmxppOXuafC070hZ2WG8pvuainBDcjBQQY8GwLdFhzqg7MM8DmF0A2uKJ+97ep2urB
 zEzPJZOEGWKBmBvHMkJew3KGeCS9wlq0gjPr9MS2Sdx1ZzDo+m1O+6fJUhJi9IZ6ZT0V2SMatII
 NJHgyq60uMXQXJkhZbVZrgN9g2iVvwjPlpfBvhIVohbvaUS03f0sbjG9vxUnrcX+DajmN57SMUP
 HSScAZvQ+E7EfHpsTP+JW1PqBt/3BV+OXlE4TxsqIpWEpy1MQuqjBd8Q3uskFOTq0A5zGbP0R0h
 FcJUfJbIPtUK8daVfQ0Cs2Iwy1SFQ4CP7wKUeloeeYz6jTfnyhaeweZWwfN/AwAQDRrgHxsw51e
 FDfFc4p57JdXYyoVtHH8CxqSTe+EyCqoNjV3zCYlkpcFxOG+uBYQ5SqAebuYIdq1aO6FwfLMHFe
 HakRu401Nv4tmWZMBjIeV/azbuTUzxjCBy4m47YlLrrXy1dlUAO5e94Cy5rVexjpjN3Q4lkLhsW
 0JqQtHKj8LkZ/qjF5Hb0bmxtHvH0lRepEzxwIGiHWou6EubfHZuVnzwL92NkvibWI76pHzK3kgF
 FByUupqw1krlcujJyPqnmafyws5QvZ50LjM/+5
X-Received: by 2002:a05:600c:154e:b0:4a6:44b:2593 with SMTP id
 5b1f17b1804b1-4a9672f8b6emr55023675e9.29.1793204302524; 
 Wed, 28 Oct 2026 09:18:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa82516a45sm2281875e9.15.2026.10.28.09.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:18:22 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 16:18:19 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf
X-Gerrit-Change-Number: 2064
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2064?usp=email>
X-Gerrit-Commit: f332dfdec52be14670fd45c63c66ea0d9f1e19c0
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 16:18:19 +0000
In-Reply-To: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
References: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjAzOTMxMDAwLklhZDUxYjJmMzFlNDIxNWM1OGUxNjBjYzYyMzk4MzYwMTVlYTRkM2NmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e8575bef2e6dd89bf96b0db421e9682e83c7304a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM6M9-000000004m6-1YTE
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Track number of
 assigned peer ids and use it for max-clients check
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
Content-Type: multipart/mixed; boundary="===============6565174827056895675=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6565174827056895675==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A3Ni7SIsDX8="; charset=UTF-8

--A3Ni7SIsDX8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2064?usp=3Demail )

Change subject: Track number o=
f assigned peer ids and use it for max-clients check
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(2 co=
mments)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064/c=
omment/c46ef0ec_6ff000a4?usp=3Demail :
PS1, Line 12: UDP connections only r=
eally this later in the connection establishment
Typo: "only really this la=
ter"=2E Not sure what the correct phrasing would be=2E


https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2064/comment/7437432e_55efdbb3?usp=3Demail :
PS1, =
Line 13: and then only for peers that are of capable of DATA_V2=2E
Typo: "p=
eers that are capable of DATA_V2"=2E



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf
Gerrit-Chan=
ge-Number: 2064
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date:=
 Wed, 28 Oct 2026 16:18:19 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels:=
 Yes

--A3Ni7SIsDX8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064/=
comment/c46ef0ec_6ff000a4?usp=3Demail">Patch Set #1, Line 12:</a> <code sty=
le=3D"font-family:monospace,monospace">UDP connections only really this lat=
er in the connection establishment</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Typo: &quot;only really this =
later&quot;=2E Not sure what the correct phrasing would be=2E</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064/comment/7437432e_=
55efdbb3?usp=3Demail">Patch Set #1, Line 13:</a> <code style=3D"font-family=
:monospace,monospace">and then only for peers that are of capable of DATA_V=
2=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Typo: &quot;peers that are capable of DATA_V2&quot;=2E</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2064?usp=3Demail">change 2064</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Iad51b2f31e4215c58e160cc623983601=
5ea4d3cf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2064 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed=
, 28 Oct 2026 16:18:19 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </=
div>

</body></html>
--A3Ni7SIsDX8=--


--===============6565174827056895675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6565174827056895675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6565174827056895675==--

