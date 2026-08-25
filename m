Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F07C61DB9
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ed1NhW6RIzkBsBX5hfgkN7kuPtjbLLYs/kQB8+0gmag=; b=OUZ7DOBSUaeYsch48wqsFaMcdu
	Am99XwQql6PPYg7AIVZR6hcB2TyeUf8c33+48Bw3sn+iDUpnYPawubpSuT/MxHNSESh0hECpqrh5s
	vA4eaolBjIUdqhcHIyqAF9168fNxY+rhoAQvB0w4xFv0HreMw+uFcGDjjvMrZi7mAyag=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytRT-0006OL-9L;
	Tue, 25 Aug 2026 15:52:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wytRS-0006OE-3u
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:52:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=P7FD6Bjl0Bu6j3Jor7Zlx4fvs4RfHo27a490Vz0U2lQ=; b=eSj+kBcuvwiq0AoXmkkDWnyvUx
 +8rLLG1pF3CKa2FnodJlpApdz5hGdtAj2YF8Dgf/JUIpYT6IJi8hyKHgoJDOoxk1QjU9ctBk4+JXp
 8S91CGSWK8I1zY5RyWdj84MvgSjzDwTBSjqle18xfs6iMESEZUYR/CN1VsAk5cThTP8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=P7FD6Bjl0Bu6j3Jor7Zlx4fvs4RfHo27a490Vz0U2lQ=; b=O
 EDrtVO9STC1nyn6LZk3DxS022iyN/wsJYM7h75MmSgXy+Fq7yNb9uvT4QWj51dudvxSqS3JLM4xe+
 7xaua+i/zOexzK4+P/bIazcpjhgKeQEMH4YnPSFUcHnrlO6h+kG3srFg0pLYV5c35YRBsr1iu4I6p
 l70oJ2tkCweAw57Y=;
Received: from mail-ed1-f44.google.com ([209.85.208.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytRR-0002Mt-9W for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:52:02 +0000
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso8710896a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787673115; x=1788277915; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P7FD6Bjl0Bu6j3Jor7Zlx4fvs4RfHo27a490Vz0U2lQ=;
 b=fy5JjhzD15BzRJ6BVSAM4d72ukMNXaExIoLEcx+gtqa/6rkSzLutC6EoOrQdXOBWEQ
 8FiSbVlNp5khx9cDm820sRZoYJU5YO2ES4NzPmcaQ/py6Yx5mFXEK1ANOdGoVsXcXee9
 C3b/pGs6pZKB0Cm7JWroZ0Jvf/mTHt8sjJYszfHomKMcatxzeGV0Ds1zl9sledONlY3+
 atsB1flYi/9cMsT7luAxyuxLh5SEqCN9dS+isaWnNwyBUeTIo+D8NmNVG8LLImk+l3wN
 2loE0vo05OkK2vlz2I0AJ7Gasr9oa25AlwA4Ctp1XTxD4j9RgNbyRmb9ZXi9IzaJzYZR
 u1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787673115; x=1788277915;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=P7FD6Bjl0Bu6j3Jor7Zlx4fvs4RfHo27a490Vz0U2lQ=;
 b=paOllXHx1o+uJ+6lTenHrzwKu3qkAshBCz8sJueItmn2sY+mRJAwiNULCrSk8RQRpD
 Zg+rp0R6pkvbnTd4JNxKy82biCyQO5PQC0wgNH4lH57l02cqUeFzhioMGHDSqd2jqjXF
 QOIKOa4jCeW0dNjdNOVmCSwmWL6q7o5c6kAjBWPdS9t8ANUK4q2hxr74ugKd7+PkAfnA
 zBBUUT4MZXsy66dEfh4lZsKMjmwFz1z6/BcHJJ/6ENE8ETNlhvLVct+Rh96t5uaObQ3M
 DlxziybKQ4xZ+lB7D/MXAByY8o7m7lBTs0oVh6wPQ3vfmuBudKX3sFGryAwIN9a1PKXD
 JIyA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq79Y+JTHfKyySpd9Y5bESGGKWKi0c29BCf6o0+NSYzTj5gDIaNsHlMo07aeBeqYEPojXDlfwuQdWfVc3Gy@lists.sourceforge.net
X-Gm-Message-State: AFuF++k7myilSbdCXycTX66646YVUpnePMukXfyCZotGpX4cvV80T+Bo
 MoQ5Uiim/clW2gp6UFx3l0pbYMfxgMwVkTMbP1uOEICeN5K8MaNKogCcBPxoCRV6kyfnyD+HDd5
 TmVi2UK7tabFu8J4v3+dC3UIkTym7qyH03Av75X8C7qRefev6ltdX52VeXg5lAkJaZu+c
X-Gm-Gg: AR+sD13zwI/Fa60111uHlxVaJ/JWlTKMTqU3My2EfpF+NRhl0i31Eaj4KDJEQBDUuTQ
 Ppd7YvnwT8oJC7ONkmo+HiYWW67s0tBk/+adxNkBIrEYs0FyskMbsECbnxhgH8g7RAzSGro2YBi
 trl46jWiVonOq/9BlOrGiuI3qSBFSfE9IO4foaLh2eRnvJhkoMmSv3JEdBNsLBVHGFLOWLaWM63
 FCpa6Vl/Y14jXXSNP6Lza0RdxbunSwmxht1vbR5YQCGeEbYjHvvKaKsw034I051mvAO7umKYmq+
 eubcdO9ejCUqpou5jhdthmN4750IV78oEIk/jTJbMrW6RiAmeBapFoeHUflnyyUjlwDhzjym+Yy
 G6aQx+KymSFt/VtRanVvzAqYjxQBizxbDb9Jw8QxpdnakKYzxphrwqUGyCo1X8UCaJNZsuC1gR3
 nunmo+mYQbkESKhTMKqZiDpGMhXSIx/RFj472Axrv/7/YQ99T5Ylq2a9ubRjI/64m6q78voEDgf
 PMjS26Jedby66KEUt/LSYE8nOBZiXteq+UHbaEOfLnzaaEbMg4Fthi89yxTDZoajm/R+Y1uWggF
 QlJ2rilzhC26PwdQtgG9t5xQu1jaR11/fH10EAUwePD7EJtj46Y=
X-Received: by 2002:a17:906:f59b:b0:c20:7cb1:9046 with SMTP id
 a640c23a62f3a-c24924b7508mr2947302566b.8.1787673114658; 
 Tue, 25 Aug 2026 08:51:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ab82sm16112066b.31.2026.08.25.08.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 08:51:54 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 15:51:52 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: deleteVote
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: b60ab3c9f41d033dd44c5b0f70f23a0da11224a9
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e7cea29165fb1673a252341d188794cc8f5980cb-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wytRR-0002Mt-9W
Subject: [Openvpn-devel] [M] Change in openvpn[master]: t_client.sh.in: Add
 support for expected test failures
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7559364463365087211=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7559364463365087211==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="314fi2hhbmI="; charset=UTF-8

--314fi2hhbmI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as removed a vote from this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1755?usp=3Demail )


Change subject: t_client=2Esh=2Ein: Add support=
 for expected test failures
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Removed Code-Review+2 by razvanc <razvanc@mailbox=2Eorg>
=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: deleteVote
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c51bcdda5666e0dab=
2adcdaff28408c9bfcb844
Gerrit-Change-Number: 1755
Gerrit-PatchSet: 5
Gerrit=
-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flicht=
enheld <frank@lichtenheld=2Ecom>

--314fi2hhbmI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>razvanc <strong>re=
moved a vote</strong> from this change=2E</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1755?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap">Removed Code-Review+2 by razvanc &lt;razvanc@mail=
box=2Eorg&gt;</div><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1755?usp=3Demail">change 1755</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: deleteVote </div>
<div style=3D"display:none"> Gerrit-Project: op=
envpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div=
 style=3D"display:none"> Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408=
c9bfcb844 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1755 </=
div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"d=
isplay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: r=
azvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--314fi2hhbmI=--


--===============7559364463365087211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7559364463365087211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7559364463365087211==--

