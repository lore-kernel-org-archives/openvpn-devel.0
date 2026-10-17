Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33811CCF2C7
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 23:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OvCpFzvTPXMQKmHuGp/0IzwQojNshEcMdfVaxzICiP8=; b=ITuZzW5XoC41A6miCsxbg1zxh8
	Wb+1txGwffdLbKiGEKT2bi6z58r81AfiPD2fVWb4zBcmtIMBv5lCPRS4LvsbganhApAUojrR0Shvg
	nUqTbPj2Cbkm+qkm8t612SUeJbQXEydWnUrMY/SMPmp/Idvnf/uRVWhTIh/p5so1K+5o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIEF6-00050a-Kl;
	Sat, 17 Oct 2026 23:55:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIEF5-00050T-66
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 23:55:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=h3/5M6CkrWP2B0R8rUcxwE96GqIkoMFRV+DKs5P/ne0=; b=h+DwzzKW7L+BMFxAkYWHwMMCMw
 GRnkXo3K/LKvF2g0KpACIl0u47DurBeZ1S6XFXB5crRaeBa6an8RA04YyYypP3KJKkAjjxndx0k1n
 9YI9oNeA0oPiwL6LAyJZ+Cmu2A6pBCuwrRdAzdGhsbt2ZjQgsrYHQ913iTTZ3Cxm1Cp4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=h3/5M6CkrWP2B0R8rUcxwE96GqIkoMFRV+DKs5P/ne0=; b=S
 xJ2Q48EyZ+xnEoxrcgmyAbpsiCyqmnzVag3VcKAC/bJn7bjpfRlOXNaySFQgklPb7lV+G9JO8Wkl9
 72hNaEopwJbPjBLaRll4OBxDKmftDtEk0lI90sfQcXBejtYGNCwMIJ4G0b+mapVuXhf2gKY6v3Guo
 yVIAJ/qvIZwUmKEE=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIEF5-0005Zc-AL for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 23:55:11 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso11254775e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 16:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792281305; x=1792886105; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h3/5M6CkrWP2B0R8rUcxwE96GqIkoMFRV+DKs5P/ne0=;
 b=YvUWCFAl0qMfnL2yZsppbPFm8lK1a8D8RyHv/ZyuRjceSrJ6YsHfbwhgdpl+qCHrXB
 nV8FxlupD8N15yTNfjd6SLXvjNv2xd2RmyYd5feeda7QRLJmQC1FSfAt96PlbKgIeZi+
 /3d367gmB42xDLHgAf6U/DveYRIwc9D32joJOtDRpg59aA7z9UMmfaBaXDdcOv+pdiYj
 pFgCqXf2KUP++iOWJDQNlYKMw0tk+SC9q6OsRZRHPfd1CMPT1J9A0247/Q1HrGQl6jd/
 8w+7uB5AibJpzu/P9ZpmekAlx7A5M0+0OVT6yKsyzURe9OHIuzSUPxEGwfm7xZThhkkS
 tX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792281305; x=1792886105;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h3/5M6CkrWP2B0R8rUcxwE96GqIkoMFRV+DKs5P/ne0=;
 b=JplWwLsxnG/YFD7yics4PLjD6+xDRMMIWEVfxTzQXzL1M/IwkDS6YIEJNK57ebJGjh
 Cz6zVPwPpKlq17XjA2ScD/lckyzXz5MQNP+n6PoCbsF7uUPhVNWq/usSIFiZFdlszpKO
 xL0OAPmGDWw/mVoQKtq8aZIFWjTLv2lKyjnGLqEdhpjmu6G6zutD4RSIxIjpoxWDU7Io
 5Gkp8PpVupbUf8wrdCyBVCcB3QJUGUeio4OVEHLSovu9ulX/00YMO6z2W0zlPUKCHd4f
 GOTpC+BYHXYqt0YHwPAVzRvKJdq86cdTjc9DVQV69Z7pubdAueY57qiK/lcse7xdUf+l
 6YfA==
X-Forwarded-Encrypted: i=1;
 AKwUvByByquyrYnynlgIBU2qbl/DPFlAXc5eWEI+RhFu0T8+/bd8W2bUlj2o0BKBWThFm6dvNfxhRbPfTVOwbWT9@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIJs8PHWE8w/Kugk6Y87GwGta7aOw4V2oAXUgn/E0YmtLKwyNIK
 bFEuQ2dMT/uVHypYwl/vB38MFcmaUcmQzRcsnU065XS3dEPLY4qStkfg6uKcTiRWM0GdZVbkloc
 FVSYfsFzY8JlTkxGUGdmtVYCJM/7u0xEJ9UtN965fMZMJQ7cSrPb4KqbaWvhMUneFqbhj
X-Gm-Gg: AYBFou2lICFHGqha8BjQJy6HQoxhadxR3PGDBGotTwvjUybzhpTZeIbxVmEw5a3S3FM
 FbpdrASjYQihjQoaTSAZhq+6s8J789NnIBsalYvxqcZzbhHpWpBg9m6Px/TixrPLB4nc3ArStnI
 iq9qxmNpxTGZQckXDWQOHj1TrDla6Xbh51163W1c4C6QBplH+uIrnVjqTwyVrhytBM5X/Nn4xpY
 8apm83cxuNnab2t5xkvnnizmW0dBdmTi4p4cASLIiMoe1tTbxTkCcTlz4YL7WzkbZAVQBtyxI7J
 SBvHeZcHpJXbm3g6RD70L8lMQB8VeGFU48FIpI1uhwxFEDelR6qf+p9dnp+tuKNVzejd8qOhaTD
 HKA+zYoaObStp59QFvhhdFvMfrwxpUxD2d+CHUdwLAbOqdLktoRPpDa8oIAu249E429FnHzBdVO
 +USVsPZrs84m/4ve/cjXMGfL2TfsuPTcYDJzbTzCtHEHgOJIAM744YEJGleXu8aYJn4iyPCAI1v
 aCUqaHXDxP46iTgA3UXivdDZL0GCsTpc9AVmC5uEX4dKQgn9kht9vn9HFjn9U/TcSizeQV4COKl
 AYOQNwDNIvdeSbSl1QsRCbRv3zFIsHjoBM6K+KMoMi1y5ywxpZUEwZYa1/zaOA==
X-Received: by 2002:a05:600c:6992:b0:4a1:d7c3:d3d with SMTP id
 5b1f17b1804b1-4a1d7c30dd2mr71036035e9.10.1792281304765; 
 Sat, 17 Oct 2026 16:55:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d30d778bsm144588865e9.9.2026.10.17.16.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 16:55:04 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 23:55:01 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
X-Gerrit-Change-Number: 1790
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1790?usp=email>
X-Gerrit-Commit: db260d1a93b5ce161b963d944e75bbf26538d74e
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 23:55:01 +0000
In-Reply-To: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
References: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTUwMzkwMDAwLkkwYmZmOGQwYTU0OWE2NWI3ZGEwMWVhMGU3ODViN2VjOGJlYTE3ZjA1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <83bb7ed50310145ac8175800ecdc332c82c25670-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIEF5-0005Zc-AL
Subject: [Openvpn-devel] [L] Change in openvpn[master]: pool,
 multi: persist subnet pools via --ifconfig-pool-persist
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2001554049429170809=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2001554049429170809==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FZssPBulrfM="; charset=UTF-8

--FZssPBulrfM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

A=
ntonio Quartulli has posted comments on this change by Antonio Quartulli=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail )

Change su=
bject: pool, multi: persist subnet pools via --ifconfig-pool-persist
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

Chan=
ges since PS2 (PS3/PS4), rebased on top of the previous patches:

- pool=2E=
h: the new prototypes now use doxygen comments (Frank's comment)=2E
- ifcon=
fig_pool_read() again warns, per address family, when a persisted address f=
alls outside every configured pool (or outside the pool of its IPv4 address=
); such entries are still ignored=2E
- The subnet pools are now created at =
startup by 1783, so this patch only reloads them from the persist file=2E
-=
 A persisted entry cannot take over a reserved pool gateway=2E
- New unit t=
ests for the gateway reservation, including against a persisted entry=2E


=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0bff8d0a549a65b7da=
01ea0e785b7ec8bea17f05
Gerrit-Change-Number: 1790
Gerrit-PatchSet: 4
Gerrit=
-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment=
-Date: Sat, 17 Oct 2026 23:55:01 +0000
Gerrit-HasComments: No
Gerrit-Has-La=
bels: No

--FZssPBulrfM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli has posted comments on this change by Antonio Quartulli=2E</p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Chan=
ges since PS2 (PS3/PS4), rebased on top of the previous patches:</p><ul cla=
ss=3D"blocks"><li>pool=2Eh: the new prototypes now use doxygen comments (Fr=
ank&#39;s comment)=2E</li><li>ifconfig_pool_read() again warns, per address=
 family, when a persisted address falls outside every configured pool (or o=
utside the pool of its IPv4 address); such entries are still ignored=2E</li=
><li>The subnet pools are now created at startup by 1783, so this patch onl=
y reloads them from the persist file=2E</li><li>A persisted entry cannot ta=
ke over a reserved pool gateway=2E</li><li>New unit tests for the gateway r=
eservation, including against a persisted entry=2E</li></ul><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">View Change</a>=
</p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">change =
1790</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1790 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio Qu=
artulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Comment-Date: Sat, 17 Oct 2026 23:55:01 +0000 </div>
<div style=3D"displa=
y:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: No </div>

</body></html>
--FZssPBulrfM=--


--===============2001554049429170809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2001554049429170809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2001554049429170809==--

