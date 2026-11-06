Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AFF606A339
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Gx3A18LO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eJDiwcQI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fwq7TkL8;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ln0T3XDK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xBiU7CHdmNbXuLGGtn3AeT8IP+3SKhPj6EUHiWNUSDg=; b=Gx3A18LOH+AiXH61dIs2diUAlW
	wy3Zcle2KGDE0Z/Vwbjz/70c6EMKKIOHAJj01pXh4H9FdZQl/axvwrFb9gB7vsgxiBD+FE6Bhxjkc
	wN4wwyZqIXlqfoqYtxJnIvn5q5bvrnGALhZdzOcLhwPbt/kpFkc01UlShq+S5omylzSA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPKbV-000000005iM-3sDT;
	Fri, 06 Nov 2026 14:07:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPKbU-000000005iG-2KJ8
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:07:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OUTwpxywafylOs6WbncVCl5CQQf64TaIlgnfFQ4JD/o=; b=eJDiwcQIqV1LOo7XeGDddENX68
 QFxhhWJurUgIGPoNBXqFOA5Yvgukmdqw54EjvtMw5U0OZguMAgHmeh/mOZWyGGz2e242Ws6ADt9YJ
 K+3elSRBgP+VTXGM+4yDH2OlxzwD069MPVCrhAQzznoZ6KMhGXNKvctFGRJv0ESNXeu4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OUTwpxywafylOs6WbncVCl5CQQf64TaIlgnfFQ4JD/o=; b=fwq7TkL8req9z4iJW2RWMmpqpM
 eJE/rv8AFLGBaNGwpFhDmaqdhpjZBJwRGi/aylDgzTzSoiTS8LYXer9Wkvfm43tG83nDe917PGmQ+
 3BX8MO1YkjsKFhJUwWWVnIapzQjs+1HU9OPJd4T6ovTA1d5JYxagSUl7ERl9mYD5rock=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPKbR-000000004Fb-3Ki3 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:07:40 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so4641995e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 06:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793974051; x=1794578851; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OUTwpxywafylOs6WbncVCl5CQQf64TaIlgnfFQ4JD/o=;
 b=Ln0T3XDKEABqD3BdGwq5W0xt4dExe3ZuTtzFsPbc/mKYqy1fBoXdYq3jMs6gjeNAm+
 xB85vBY1fXlNCnvEF/a+LYLySPwNotdpVUFPJJW4o84Zy/d/v6fflKqUxXbm3Dt4BdoX
 pYEAInpaCHcWUEPq0twnRCNobnNSz07YiTWvU1HMEIqQyCgjWKjEzVmmZtTeVigzrhXP
 y7T3/i6y5GuJ760DyrZMaUWPrMGQcuc7tUR/rUti5dYPLAlIFIlB2OsG2X4BbWpzvtqC
 eiyliwBgt3k5ojf/y8B6csbgHKMjpzlO2wD5xIcR90B8L5iWIQDWKFDXhTKfAyn596Eo
 lQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793974051; x=1794578851;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OUTwpxywafylOs6WbncVCl5CQQf64TaIlgnfFQ4JD/o=;
 b=peiO+mw71+Pjp3ZsakriMMa276iQANbmyXKVXJkRzpcN+9VZ4PmuT90ChA2QIWd9Tm
 CW6AVRFcyDpAC6MEWufLsHSpKmlXUnk3P5MSuVsyyHvauZWAVU0SeNolzDPM9EoqmHha
 lJ+ThO3I96aF1uEgFFHQ+b6CDZfuqoM0REfGexgg2USobB8E1WL80iAchDg4U0gBamB0
 C1X9rUv0oAXD5Ran2SIT5CTv6BxHC0lVpLzL7qZFz253UMZJMrjvm4K3M5DqDhDiTXzy
 7GDCzuCr9VuEfeG80S5wxRzM7Px6f0n5EuYpFk9Dl5tys7Ijf7AgIvB8pVssDme9BZxS
 8Njw==
X-Gm-Message-State: APuU4Z+DuV4iqVprgnT2mR6uOLDf+9YLRkIhj34BaWc3VkLNkuLaXu6d
 PmPX+0D8EO8SU65S7jgn07tvMJARBR+ATiXKMijrdkO3Zgp7eP7w7VbNpruM+jzJG/02oTKk4WB
 1UohB5sMy/j38cWjgjk86cZuBLi9E2IvXgAZN+3B8y8s8mVs0Bs+qbH/OOlWnXME6HsDQWKhiTR
 cfDbI70w==
X-Gm-Gg: AYBFou1NKsTT5gOVchEemlhEovTK/o5R2ntxrKDm7lTVKmRG1VOZuNvIimm67uB2ZHR
 0jhwJfViVCGGe3ipT51ksTNvWSyas6poXeS92ADwCWFYPHbNjfnsTUJGxa4e0V+lBiPqVF9ZoOW
 WaSFc8mBZKRFHpE1V/zvAU/tOnODXRMiAgxeQIFusYE8zy2mBVja3W6/YxmgdxGWy7uuD0Pzbny
 +4/nwEBewsRz/6W09pEk6CM+icsYfswOv9+lrwzyGq3JxCy0bPb/nKmNKMoc8oPV2/ApUvyJPmS
 kJe9iDjRhdlKfvsdNxiDIfhq5diF9Mq9b9XaredlS/7yiglEExMuDmiO1SevvaILjnCuR982CGH
 BKu+Iau4tiFWbANdcOl4aar/UWMoZgrVkRcWrdl/6TcA0Q3wN8HcKLJAS3tv67QLxOY0OZ6YVpi
 E5bx4v+LxHrVjNfzDPToibUNmre3XDcxMQWYZIwgjg2D+PtxF29aUz/A+JrXNZJZlCa1pU8MAuM
 3RRke3hccGti9HAJj6Oj9LiBfkyv4oZbpNeW12WIKrx0SX+WyAfJAH4y4G5lMSSPg+LcOuObdPo
 /mCjoqZPrti4A0L8jtKEAm7n71TyBzlFSCjZW0vHT75nCpl5AOLPgvI/Oe1x6jHPOwtTwlOqeC3
 sbi8oDPl4xJugUApSVOKlZrSXEwq50q5hCBNPUDVf6ZqaZ24Hj9/L3cUF2vpN48WQnue9b5onQB
 iSjhLoP+ECgCP+BA==
X-Received: by 2002:a05:600c:1d01:b0:4a2:397:73e9 with SMTP id
 5b1f17b1804b1-4b6de3b179amr42577195e9.18.1793974050940; 
 Fri, 06 Nov 2026 06:07:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e1b5d7desm69503015e9.8.2026.11.06.06.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 06:07:30 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 14:07:29 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc
X-Gerrit-Change-Number: 2146
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2146?usp=email>
X-Gerrit-Commit: 8b7e241ff25b9ebe71c56cdf0a3b4d7424cf252b
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 14:07:29 +0000
In-Reply-To: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
References: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTcwMjAxMDAwLkllZDllMzZkNDViMzBhODg2MTBjYWZlZTY2OGVjZWZhOThiMjllZGRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d7fbd055b8987643b03ae45f9012add43e913e0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPKbR-000000004Fb-3Ki3
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: reflect_filter:
 zero the rate limiter on allocation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 lstipakov@gmail.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1434147563708127969=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1434147563708127969==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bDdnG9z4gR8="; charset=UTF-8

--bDdnG9z4gR8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Lev Stipakov=2E

Arne Schwabe has pos=
ted comments on this change by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2146?usp=3Demail )

Change subject: reflect_filter: zero=
 the rate limiter on allocation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comment)

File src/open=
vpn/reflect_filter=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146/co=
mment/cc296543_26bc552d?usp=3Demail :
PS1, Line 97:     irl->last_period_re=
set =3D 0;
Either have all fields set by =3D or do not se the ones that are=
 =3D 0 when the object is cleared=2E The original code had this wrong but t=
he fix that wants to fix this should get it right=2E



-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29ed=
dc
Gerrit-Change-Number: 2146
Gerrit-PatchSet: 1
Gerrit-Owner: Lev Stipakov=
 <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date=
: Fri, 06 Nov 2026 14:07:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: Yes

--bDdnG9z4gR8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Lev Stipakov=2E </p>
<p>Arne Schwabe has posted comme=
nts on this change by Lev Stipakov=2E</p><p>Patch set 1:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/reflect_filter=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2146/comment/cc296543_26bc552d?usp=3Demail">Patch Set #1, Line 97:=
</a> <code style=3D"font-family:monospace,monospace">    irl-&gt;last_perio=
d_reset =3D 0;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Either have all fields set by =3D or do not se th=
e ones that are =3D 0 when the object is cleared=2E The original code had t=
his wrong but the fix that wants to fix this should get it right=2E</p></li=
></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2146?usp=3Demail">change 2146</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b=
29eddc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2146 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 06 Nov 2026 1=
4:07:29 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></=
html>
--bDdnG9z4gR8=--


--===============1434147563708127969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1434147563708127969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1434147563708127969==--

