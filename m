Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A16FCA600B
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CmKOVbb5k/b6eC73okfRo4gb1TFrvcSc4STp0al9g0U=; b=Y1/arhVd/0OeFg4IrRxVqX2iNG
	Ojn8K3AghgxPh2IT+slu3l9udS9IzfuL3itkClVC+3RZ6g4fEuG7k9C0DNFHznsYXXN4NVAqQ2gSM
	juhFpk2lccSVwR7aoaZzxrIF/8iVCum2KPsPV8pCqOvGBIU6kc9LMe1dk4QLpJozAOhQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEo8B-0003A0-BA;
	Thu, 08 Oct 2026 13:25:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEo8A-00039o-3d
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 13:25:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oIYJXLekmIHRkec+uDAB+IVq4Yw73LsnPb+7LlW0duQ=; b=EuMmLl9Aav+o1NN3XBJGPCsG2t
 MyqeAAUovRT2/JtoyzVHWJXoqzSRyt/8QbGVD2L5ACUULgsNbpWVpWC6YvFpQQDffBVUULrTYvz9N
 g6Hl6bLUJj+1WoFW5ZahOJT3Z2HtYkPju2OkkFGvu4mi4sTojqNcEkPZG8ctSrtZKTqg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oIYJXLekmIHRkec+uDAB+IVq4Yw73LsnPb+7LlW0duQ=; b=a
 FrJRPyQfiX9sAk2LlB+T7l3zxCWCqtcA3WHxQr5D8ycgQdcGC7hTXrB0L5TzTW9yPMGmAM9WsJazv
 WgolaLmiKw6gtUFPOE/sTv+iRunLx5LHMfs6IPFw+8RX/6fVjQLcvn4kWkvwGdVwT1mvk+lB5hfiL
 AiQKuBfZxuYPcRWo=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEo88-0007YL-Uw for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 13:25:54 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so23233555e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791465946; x=1792070746; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oIYJXLekmIHRkec+uDAB+IVq4Yw73LsnPb+7LlW0duQ=;
 b=fsW4Edllbx7pioyUIyeWinKOPZ6vi0rfgvVzTwNzkdmCXH52pAk8T9jCp3kyzSbkMd
 pvZtFELnLC8Amm/CD37fMhra4cIJsWFzjym4d7DBtzMGXohXozd+SSXi4Sp1O0Eup58z
 15049yCtDphbrB/emgtKS+lXAxyU4MMyEco3xbFLxrpki6xOHpH4t0OPiFZYj5yE026M
 0JyP3/d9uTijoCNBJSjHhn1l2+MTlqrwF4shgMnA0j6WgNi1TD1vrTSgt6Mxsbln5/Iz
 7uDo2ZnPP0O90j/L59sgwm5ssg7zUeUgOkHarRwioYXBRsVpzc3Unv4QyIKcq4QTOmTx
 mGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465946; x=1792070746;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oIYJXLekmIHRkec+uDAB+IVq4Yw73LsnPb+7LlW0duQ=;
 b=Fdxd4EIlDxRrDqMDYy6uLWuXIVSaoIarx1i/XJy23+ofi4tPzDV46nGOiTYS73O+7C
 rI3QsUxKToY3wOtDJ8uee7s6CtefgBvILxdDCxpPZP9SLNCGDCYRMdDD0LPZLwWUU6Hp
 BXk85vc93xu2/lu5LAoPxDb/oAA/sKQh0D9McYrxlk08lEJk7vyXfB3oFtrYpC8WNGQf
 k/KhvILn8zRDUrlIg4I6Q4T35PkBZ04bDRNww1Q7twrQD6KLNIjC/tmHMw6qjjdvOwnA
 NSndkenSZKiR+bPZExISaoJx8DYnKnAzUwUqJh0t4GrJgtYbJ5sLAvGdqcA4YMZQy706
 2XHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWuD/F0e/eRdIs6emMpvhld3Esh09ivCb3Q5HH7BI9A3ex2iVO0P2HUdwpmszxu6AQGTqsNuY+KTq6X70h@lists.sourceforge.net
X-Gm-Message-State: AFuF++kPgbMSYam3NPO4Ghc11IA13FD+L0MP6k5/kujbgHBiPfbbD9kC
 5PPqoySVE17fPp5q/65jrmSfoH5DGRQubBKfr1rzuwA0oYktKhlN6pSyStR7LkCu2OwxDjuhkx9
 LdJ/S9rUxKYvHB6aA/68GSVWdBsUA9j/k+LZwG8HPJwwxEYWdfH+GfAPX3dEViL8YGgCbSjdQzK
 HfJJEF9A==
X-Gm-Gg: AYBFou3hUV2G+8LuDfdN284/aUYMnJLqqhL2eMDTvgVhnBOXlqF1yRd5yqeSVAUP4vU
 s822aDagr7RpkT1d3L5oLEiMQ6hQlNLnWj4EjfXTtIwQjkEXUWlfszKOll8gCrUAsq4fmox09M4
 YEAHos/S7LLl05Syczkk9jYi3v6MmYlnq0x09vwfQQ3EMilwp4AxLLyLYnNhRFwjTD3geJ0k3q4
 x/8DRARUfMykt/TkSg2KpmX60aM8cggoyMGjCr8ONmbPJStDhtPku4/odPi0lDW4AAC2tZHJmIL
 k6CMi6VfD9kEwQB/UnZ8rdMbRvHT7MYzZUm4CuwKF8/F66piG5jyO3uEBffArAWHvHqYNU+U4wz
 9MplpwZbPKj/Iiwa/LzZtwWAoX1pfFeXgKhRBLjvEwREGDfH1b8LaqjOWhTaikYyF7nZ1guEYWB
 gU5brei/TQzGWQWHq+9PT3Uxl+Q2mTSYzmkqJquBkKIQ8CiXJFyeflSd49ge4jSTx5755o1bX4C
 o9Q8hdrnVF2nUwUfGzw8fIIoHGMYAU37PqprHNIy0fv7YywojYh7Fx4F70oj/iz9jC+wziMt3/b
 InB8vr8o0F96/4P9lPD0Ddk5c01K+AYe1RdsdjRTznDos598DDjnEFShRVp8KQ==
X-Received: by 2002:a05:600c:6098:b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-4a18031123amr107827005e9.8.1791465946198; 
 Thu, 08 Oct 2026 06:25:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843b2eadsm74483345e9.10.2026.10.08.06.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:25:45 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 13:25:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 32
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 5acd7a922b4bcdb4579db8006d8db02c2d38fc3e
X-Gerrit-Comment-Date: Thu, 8 Oct 2026 13:25:43 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c3577a7a9d49856ca1a40691f81a82788291e5a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEo88-0007YL-Uw
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, antonio@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3445920931117901001=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3445920931117901001==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ufdo4eRU6Oc="; charset=UTF-8

--ufdo4eRU6Oc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Frank Lichtenheld=
=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E ( h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail )

Change subjec=
t: Add lookup of multi session by session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 32:

(3 comments)

Commit Messag=
e:

PS31: 
> the TCP part was resolved, thanks! [=E2=80=A6]
I pointed out t=
hat you no longer need different source ports to create sessions but also t=
hat this is not a meaningful difference=2E


File doc/man-sections/advanced=
-options=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/83=
32e6e0_15090ffa?usp=3Demail :
PS32, Line 42:   If ``s`` is specified, the s=
ize of session id hash table is
> missing "set" after "is"?
Acknowledged


=
File src/openvpn/multi=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
7/comment/1e343fab_7ed79fd1?usp=3Demail :
PS32, Line 275:     msg(D_MULTI_L=
OW, "MULTI: multi_init called, r=3D%d v=3D%d s=3D%d", t->options=2Ereal_has=
h_size,
> I think you accidentally reverted this line after your rebase=2E =
These should all be %u=2E
Acknowledged=2E But they should be PRIu32 as we a=
re using uint32_t and not unsigned int=2E



-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit=
-Change-Number: 1727
Gerrit-PatchSet: 32
Gerrit-Owner: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: An=
tonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 08 Oct 2026 13:25:43=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: A=
ntonio Quartulli <antonio@mandelbit=2Ecom>

--ufdo4eRU6Oc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Frank Lichtenheld=2E </p>
<p>Arne =
Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Chang=
e</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1727/comment/66aea76b_6c08a6ce?usp=3Demail">Patch Set #31:</a> </p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">the TCP part was resolved, thanks! [=E2=80=A6]</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
I pointed out that you no longer need different source ports to create sess=
ions but also that this is not a meaningful difference=2E</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/advanced-opt=
ions=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/8332e6e0_15090ffa?us=
p=3Demail">Patch Set #32, Line 42:</a> <code style=3D"font-family:monospace=
,monospace">  If ``s`` is specified, the size of session id hash table is</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">missing &quot;set&quot; after &quot;is&quot;?</blockqu=
ote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment=
/1e343fab_7ed79fd1?usp=3Demail">Patch Set #32, Line 275:</a> <code style=3D=
"font-family:monospace,monospace">    msg(D_MULTI_LOW, &quot;MULTI: multi_i=
nit called, r=3D%d v=3D%d s=3D%d&quot;, t-&gt;options=2Ereal_hash_size,</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">I think you accidentally reverted this line after your r=
ebase=2E These should all be %u=2E</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged=2E But the=
y should be PRIu32 as we are using uint32_t and not unsigned int=2E</p></li=
></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec86002=
11651b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1727 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 32 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: A=
ntonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quart=
ulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Thu, 08 Oct 2026 13:25:43 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"displa=
y:none"> Comment-In-Reply-To: Antonio Quartulli &lt;antonio@mandelbit=2Ecom=
&gt; </div>

</body></html>
--ufdo4eRU6Oc=--


--===============3445920931117901001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3445920931117901001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3445920931117901001==--

