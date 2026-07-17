Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F000C4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+omEwjAJJh+o/RpbDsMcCBhvQIzFPyw9uvguP0XXqvM=; b=CH0X5LP8OCEHwjdQ/VIylfejYU
	otvV67En2639i1SlP6P9MgegXz5IDSC4WB+Mh10DlAJSavRyi5SWQSh5keu0HLuV4foFEwnMPyU7+
	WdVoyMmTyjfALREJWv3viGgnuI97XO6u/a1J7IGzxBvyApH/f6Lhi34P5gGRaRGO5MCk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkkRW-0002lk-Rj;
	Fri, 17 Jul 2026 15:25:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkkRV-0002ld-9J
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 15:25:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AXhSLPsKDKjzYI67j7oqNS6cat5zxNqt+ahROac6n/U=; b=M/gopeGwLMYPYeJFGtREIpSqwe
 OWP33MCEegg5vRWGk4Cc6pj3/kYmIrW307NaXHr0ggsFEI5JCqhmS2kQkKgnMG+ZZzM0yzXm5/Mqm
 4+kIqapJ8leiWXVYuc8VmasJBgHtxknuQ9hx2A6wMgFmkJxI5ZTZLdA0GyS2ch6PphCo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AXhSLPsKDKjzYI67j7oqNS6cat5zxNqt+ahROac6n/U=; b=Z
 WJXAnCCHrshjLupjfENWwX20fTpdRqnRVpWDwJG9VVVkLwWqh1yxtCM/VCd0ThGIw6WLJgEeyqq+4
 bqJJdZXeB+wrlmWwfvNtM7Le/JnMROCjHi4+E1p7pRoR+9AggJMMkqoZf0FgYVEpdVVqS92CJ5d5x
 JB8l9qSaJnNnL3RU=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkkRR-0007gt-Cj for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 15:25:34 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-495437bb891so11975345e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784301927; x=1784906727; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AXhSLPsKDKjzYI67j7oqNS6cat5zxNqt+ahROac6n/U=;
 b=GUs9IMncmaF++PcQiAmIV1ubQEziQHiRDqLS6Y0VVPMvTtfZwNJIE17rgq/a8nrEYH
 mPyZ+5F55MMn84MvkTUUHzYsE07+Vx6zdmB6JoGTr3GloZeABTRrLVaVkp14X5O8C6JY
 tTh5e7Y/qJEGWOJ03EbMnpz4zfK0/wSZDLvRZOhyVji5/wBk0to7i/nDkbIxVGdfV/Lk
 Y+0ocNttbKPLmN2sypdakHaewfyEYa9qf2ZbzWcV0denlBUiyON+UDnwuKWg9awwZG2q
 AzGL89jg2HgRqX5DCnLWi/58iwPzbDe8LOKK5zLelMpXL/l8SbN44NuNx1lNqceZPhs0
 fDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784301927; x=1784906727;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AXhSLPsKDKjzYI67j7oqNS6cat5zxNqt+ahROac6n/U=;
 b=CUIZCRBlPq3gJbBq+QYH/jrK8yCWUz7gpmFRk+uPdOPB37njVJjYAuU69UeBaGoSbV
 INzAOgxvtCuHvTwH90veSN5mQ7hUtUgeMJY5nQjmJ1IYI6wplzp1fgVCpXz40p6aKUHe
 0/DZxjDrJeNoizfaXzQp35otfsfX1c9Vg1f5TBIwRjZrVDV5deCP53olC74XcOZ3BZwB
 ireyUVBpqC8lbK0gAjGg9ioKXO68YhngQBOQeS6BLdPXVWjwa0bDX14mngBAw+/pH9H5
 Relb0sqMC7+LceLN6DkCJgmEZ4l5p83vBd6+rzvmYQvjeLWysCf15ubZzKT+h8cFncip
 G6bg==
X-Gm-Message-State: AOJu0YyERvhjtLDSdjlzqtRlcLoctkHVOw2ZYjv+6nk94IU1/qqq7JTv
 f3hJCzBgNG7eF7zN8WwtN0LjWQWWm4HYKHlNcoL3vNM4DWaPnuAyOwnM4aBcrjb8kXKP/IrwvI6
 ZkqjdH4pkkPIZr8cSPL5kml0nDxY70W4z2rg6rM9Csf8KR3dIMbfP58bHs/wANSy6qizz
X-Gm-Gg: AfdE7ckskb4VZZlKEKiHHb8jO1ezIbo8DIvAQQgVFtbRqxG9ktRDoT547FhjOFtrZnU
 1wLrkWlPiLiM50s7jIYL/RCxWkkcmtIl1tLW2CptOUQZ31y7Kb547v/1iID2GNJ1bD6VSQ4MxOn
 r+GLSg/ToSnEqaUojfbkcuFLQiwdc9+HlfbtoiAPwV1dUL8aVgS9O8oxcscm4cf1HdMdYftGleJ
 VHMatIzzc//fzQGIfl/EX8G/gQlhEp7xN/60qWl1HOsCXhX58wZoHqGCyWAhUXsNTJFOEh0SrzR
 yMX9GfwKwCF31TG+/Pho6r0tiNf4b6YflmPFLKkC0qDSOUw0gPDykiLDrd4l7LRre0zLYW12Qp+
 r50hAJRYcuxQSWeebsX9zm3h++FqrZ2eIbtRkRuBR6lqDn6AddN6UaHvIQ3aYGVJPxbcUn59V9y
 PRug1wLkUhIDKY0IW1SrIdhwu5Nn9SxWnOiAO+sCL9rOWxl6GgqtFxvHIn+f7oIZ9yEZi+13OkK
 g7fHgrTErGkRkyXbdVSGf+MkWyTS8G5VTi+oiYR/9aFZK1Ym+yFE6NNFp5qrGAXUetBxLpvKyyN
 EoU=
X-Received: by 2002:a05:600c:1381:b0:493:b698:9247 with SMTP id
 5b1f17b1804b1-4954a33dd74mr39318935e9.14.1784301926634; 
 Fri, 17 Jul 2026 08:25:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2edda2sm53128755e9.13.2026.07.17.08.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 08:25:26 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 15:25:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 2c063aab2095cb86186f395d73a59626431ea289
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 15:25:24 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1ff58817f1678e7de450f556f75bbb02094b24a3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkkRR-0007gt-Cj
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1098716722946775002=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1098716722946775002==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tnYEIkxxXlc="; charset=UTF-8

--tnYEIkxxXlc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi session b=
y session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 5: Code-Review-2

(2 comments)

File src/openvpn/sid_hash=2Eh:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/5f1dda6a_a224f258?=
usp=3Demail :
PS5, Line 59:     struct hash_element *he =3D multi_hash_sid_=
lookup(m, sid);
```
sid_hash=2Eh:59:56: error: passing argument 2 of =E2=80=
=98multi_hash_sid_lookup=E2=80=99 discards =E2=80=98const=E2=80=99 qualifie=
r from pointer target type [-Werror=3Ddiscarded-qualifiers]
   59 |     str=
uct hash_element *he =3D multi_hash_sid_lookup(m, sid);
      |            =
                                            ^~~
sid_hash=2Eh:48:67: note: e=
xpected =E2=80=98struct session_id *=E2=80=99 but argument is of type =E2=
=80=98const struct session_id *=E2=80=99
   48 | multi_hash_sid_lookup(stru=
ct multi_context *m, struct session_id *sid)
```


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1727/comment/73b795c6_c478883e?usp=3Demail :
PS5, Line 6=
4:         ASSERT(hash_remove_fast(m->sid_hash, bucket, sid, hv));
```
sid_=
hash=2Eh:64:46: error: =E2=80=98bucket=E2=80=99 undeclared (first use in th=
is function); did you mean =E2=80=98socket=E2=80=99?
   64 |         ASSERT=
(hash_remove_fast(m->sid_hash, bucket, sid, hv));
sid_hash=2Eh:64:59: error=
: =E2=80=98hv=E2=80=99 undeclared (first use in this function); did you mea=
n =E2=80=98he=E2=80=99?
   64 |         ASSERT(hash_remove_fast(m->sid_hash=
, bucket, sid, hv));
```



-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
=
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 17 Jul 2026 15:25:24 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--tnYEIkxxXlc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 5:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/sid_hash=2Eh:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
727/comment/5f1dda6a_a224f258?usp=3Demail">Patch Set #5, Line 59:</a> <code=
 style=3D"font-family:monospace,monospace">    struct hash_element *he =3D =
multi_hash_sid_lookup(m, sid);</code></p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">```<br>sid_hash=2Eh:=
59:56: error: passing argument 2 of =E2=80=98multi_hash_sid_lookup=E2=80=99=
 discards =E2=80=98const=E2=80=99 qualifier from pointer target type [-Werr=
or=3Ddiscarded-qualifiers]<br>   59 |     struct hash_element *he =3D multi=
_hash_sid_lookup(m, sid);<br>      |                                       =
                 ^~~<br>sid_hash=2Eh:48:67: note: expected =E2=80=98struct =
session_id *=E2=80=99 but argument is of type =E2=80=98const struct session=
_id *=E2=80=99<br>   48 | multi_hash_sid_lookup(struct multi_context *m, st=
ruct session_id *sid)<br>```</pre></li><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1727/comment/73b795c6_c478883e?usp=3Demail">Patch Set =
#5, Line 64:</a> <code style=3D"font-family:monospace,monospace">        AS=
SERT(hash_remove_fast(m-&gt;sid_hash, bucket, sid, hv));</code></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">```<br>sid_hash=2Eh:64:46: error: =E2=80=98bucket=E2=80=99 undeclared=
 (first use in this function); did you mean =E2=80=98socket=E2=80=99?<br>  =
 64 |         ASSERT(hash_remove_fast(m-&gt;sid_hash, bucket, sid, hv));<br=
>sid_hash=2Eh:64:59: error: =E2=80=98hv=E2=80=99 undeclared (first use in t=
his function); did you mean =E2=80=98he=E2=80=99?<br>   64 |         ASSERT=
(hash_remove_fast(m-&gt;sid_hash, bucket, sid, hv));<br>```</pre></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1727?usp=3Demail">change 1727</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1727 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Fri, 17 Jul 2026 15:25:24 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--tnYEIkxxXlc=--


--===============1098716722946775002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1098716722946775002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1098716722946775002==--

