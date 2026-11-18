Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19426606A33B
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T3U6QUmq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AyewW9/Q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=j7lCs1x6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VeFP40iS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hJtjc9NTict1O6TQ2+D3LOq9Eg1VFM7E9xBtA3bby18=; b=T3U6QUmqyE4r7N7ajcjCT9lqWA
	7QzgVz9Lf+/Gulci625CIjQFtGuFhXWGVU4/aPSvcLMxtZHlwlW9kfAdtXddn5VYrAAEDR4ytAljt
	gKcEbcuYhayDKvYU9Gt96VBS5quhIAjA2T94OSf/ZQCCzHeFVvIycEWRjS5VYIobM+es=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xThTx-000000006OL-3LxD;
	Wed, 18 Nov 2026 15:21:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xThTv-000000006OD-3bDr
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:21:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gFtgrYdVip3LlkQEskF0aDVwf68c1lyXvd9VBRPR/yw=; b=AyewW9/QJbDjm0TC/uF0l6C+e+
 XisZQVeUljFENvvrfgWlGMvMhdMuMLw6l8BsH4OL3x+07ElY2T2DDKudgj/ABffJRuaMdglnGugTb
 OCJBtyIpNfO1ydbeFHanxDq2Q0/0IwrwrBVDVhhxWkU5FbrZQbkX5Y492Q9uoCStAMvU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gFtgrYdVip3LlkQEskF0aDVwf68c1lyXvd9VBRPR/yw=; b=j7lCs1x6qFiElEu3hSaMfzDlH4
 VbFm54F++SqrDBn9lUjrEIhzFmHxemM6/bEUQAnN9I5PDZy6Ie2uM+CK3Hw121hhdB4FOiAnuqigA
 npqJiGmhk65NayUEYdq/2ADLiJrNDFMMYoWgcEcrXNZSL9qCPZneNE4U1Jl5x9NnRWy0=;
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xThTu-000000004Bn-1ktI for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:21:55 +0000
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6b87a240de3so1649771a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 07:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795015308; x=1795620108; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gFtgrYdVip3LlkQEskF0aDVwf68c1lyXvd9VBRPR/yw=;
 b=VeFP40iSen9wopx4uxZuU8EVS91cEUt0RnCjxAx6Wi2SxKFuZ9jTRapuufYjJSmaV4
 vwreSfic2VGk0Tg1kvoUJ4R0S20ELNtQHN7j0qteZJGUv7g6ee/1lu5YunHHPtPBA8kW
 XL7YMOTVWaxMVsXn4K+VW3ZFRzUwoudSdXGwf3oT6jbiYsvbumEWXEzO7glyWkXs8i99
 l/BCV6TpXFBM5F2t7keohs49GQhjsH694+BvrlGCc/0JCIOfB+v1NP2QPRFjwWm9ztAs
 7R3mcgiZ39vOYQkECfKilRayvO7Tzpi9BxJWkm3lgvMZ5rbTF75PVF+2zRuiMXlLiy59
 YtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015308; x=1795620108;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gFtgrYdVip3LlkQEskF0aDVwf68c1lyXvd9VBRPR/yw=;
 b=FYjWRyWBjMFZJT0LGlarsK+wRxHumCPqHbjbVi1ae/mX9UaTzn+sVDHTamdV/pVWAa
 PJGOr8+UH6vfcdGD3ZmvhY+51QM4Jlw0APV4xJENA1iQa+d4mvrFd0swYu9STnufPpra
 8ZyI/5Q6/s1NW21sOsxXWsRbxJzf6QpHt4jzhbQHk4JhujhPgSJsZVRYThGXw1r1+2Vd
 N18biyNIhEXszCFQslajSUkdXctPflUHEit1Ci9Bs9+uw9Ksm1dFqrSTVMwsGt5AIVk0
 hyZoUaq7G+PyWxfgE14j1YR++5iwntjIaXtl6JmdHUNEI1izkAp/313R7oEhWkiYxeKZ
 HC6A==
X-Forwarded-Encrypted: i=1;
 AL+hErGaPF3KutZHv3X5/58mttkk58aekCrT1LmjM/vrXK5bX2JuZD5EtlY4IKloatD336UuKcqPrTM1lUk3UfqM@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8IAP7RAUJUyBp8zjOhww5PiSbd2PYEP5OoNOdl+8kHQKe3KXaE
 GifYwTFRkxUAikyoKLYy/OdAVH2ZmjM9ADHpMB46lEmSivastBt4xoHN6g/EoVOt+tvE9lCf4Ba
 9DG0PE0X45iec22lfTcsxFTTIJHglhGw/4F1I07LBRyXNePmFiUJSafMlE5HztLb7kVuvaAc12H
 gFfMug7A==
X-Gm-Gg: AYBFou3K57gt0xdLGPBE4r0/JuyVrjinZeY7JtOPzEjCkGvu23c8U2mvFvYU4PJ7oMR
 co64siSmmGja0vgXDkjeA5fueVKt7zygZnj8VxqCfe0/teA/jmJXTTyBu4PDGy9SP+aEMWwnxaD
 1vH3+A7aIUCkd4o7dnB7aHKImqcari0xH/268kM+MEFZxEtINIA82Vt3t2NLcer6iAtIwbgf+qV
 bQJNkVDgEkDkt35/mQSuN0A+5jUrAmGWR/5YSt880tIvzwCT2fBPMXVHMQCCbE/7QXWVkKodVhR
 u9WWkeujI/8gpmRW3fnTYUfTqeEXgRm/VZWYP2njTs/vkvFQSMHDpdzpB45gXUzLg6JcoYWByZx
 /i9SGKqKcv8fqUKpa2BFKTyVFu5f0fRJIVQJxu/nMluif5q94FjJrtJJy3fqGwXovkHyDLfe9Oi
 xICFXx7N8oixo9DlG0nAwljp7iCpqNompKavDhSDa8bbSKQMuSdihmb/X2m5r7cwxHFeoUEitq1
 Wl4SgsH36/bGDpjkZNAczuO5VR9kM3NARQrA6BvTBYlCFReCAmInNKt+W1tyY4XnjYnApBSzcoH
 1qErgEo4lO2GFlDw7tHkD5gR/WEj0a3QrctvzBfGslnRLEEWNFlE6v3ZQle9x00RR1s4WbeTg7Y
 W5rKADu/USvCTJnpiEl9SsD41NZHDiL5jz42BteTUYhOZ/U8E0zCLc7Xi9zXiJWKNFYsGxO5kCa
 g50HunqhR4bK2okNg=
X-Received: by 2002:aa7:c513:0:b0:6b7:d1a4:fe38 with SMTP id
 4fb4d7f45d1cf-6b887f161e6mr2012641a12.40.1795015307446; 
 Wed, 18 Nov 2026 07:21:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65683d5a2sm5555950f8f.43.2026.11.18.07.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:21:47 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 15:21:46 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
X-Gerrit-Change-Number: 2217
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2217?usp=email>
X-Gerrit-Commit: 86b4a70d6fe72b7bfdde90600c8601f0a4b76b3d
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 15:21:46 +0000
In-Reply-To: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
References: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkxNjI2MDAwLklhNDhjMWVmYzlhNjg3MzgzYTFkYzg3ZWRkNDlkOGJhM2ViNWE4N2FkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18a8c8fa68965af22dbafcb34575b9ea08674981-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xThTu-000000004Bn-1ktI
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify: use
 check_for_client_reason() in tls_authentication_status()
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5273171253411041421=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5273171253411041421==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/p97hfhFhJM="; charset=UTF-8

--/p97hfhFhJM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demail )

Cha=
nge subject: ssl_verify: use check_for_client_reason() in tls_authenticatio=
n_status()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1:

(1 comment)

File src/openvpn/ssl_verify=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2217/comment/c4a456fb_a2e56804?usp=3Demail :
P=
S1, Line 1167:     struct gc_arena gc =3D gc_new();
> I would move this gc =
into `key_state_check_auth_failed_message_file`=2E No use in it here=2E
Don=
e=2E With the gc there, key_state_check_auth_failed_message_file() would al=
so have to set the reason, leaving check_for_client_reason() an empty wrapp=
er, so I merged the two under the latter name=2E



-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
G=
errit-Change-Number: 2217
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 18 Nov 2026=
 15:21:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Re=
ply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--/p97hfhFhJM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217/comment/c4a456fb_a2e56804?usp=3Dem=
ail">Patch Set #1, Line 1167:</a> <code style=3D"font-family:monospace,mono=
space">    struct gc_arena gc =3D gc_new();</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I would =
move this gc into `key_state_check_auth_failed_message_file`=2E No use in i=
t here=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Done=2E With the gc there, key_state_check_auth_=
failed_message_file() would also have to set the reason, leaving check_for_=
client_reason() an empty wrapper, so I merged the two under the latter name=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2217?usp=3Demail">change 2217</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia48c1efc9a687383a1dc8=
7edd49d8ba3eb5a87ad </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2217 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 No=
v 2026 15:21:46 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComment=
s: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<di=
v style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>

</body></html>
--/p97hfhFhJM=--


--===============5273171253411041421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5273171253411041421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5273171253411041421==--

