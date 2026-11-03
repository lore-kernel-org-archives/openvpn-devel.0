Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73173606A329
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KGjRA2vR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=I3ltxFjA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZqdUZKYV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MsnB40BQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gGeDGDv/Vscgiu0W2UMqdvbc+/S9NjHtoOKE9WgWNKY=; b=KGjRA2vRX5BdkDEXvjKbH0dSpM
	SELfNCMrVOAhZOO68uWqleA834hSyyKj1imv09CGklyfQf5MEVyEZ2G4NDIJO08VYRiiMLbLwcoEq
	el/XUNOdbi8K6AaddSg2NcKp7E8O6xdrSfgbbydiVV9QGpluE2WWe+ZrdEA6wFwxVtVc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO9F8-000000002wK-0X8S;
	Tue, 03 Nov 2026 07:47:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO9F6-000000002wC-47fK
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 07:47:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9k3avu0n7Wom+sSXSLitF3KM6neMo1JQ0s8IUJ+O4W4=; b=I3ltxFjAnWN/0+qkk3pD0qA53g
 Km218cApDx3Kf3UgBQaQXf9Qfwx8yPOmuZu8CfK+NHqAhJzImVU7JYoU4xRs06uOuA26PHXh1ZlOC
 aG0woScuNzI5pRlIp1RFlgKAdmKvYRgRoPSytHh9u5zeCxELQdwHeJYiQ1Fh1jmVceq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9k3avu0n7Wom+sSXSLitF3KM6neMo1JQ0s8IUJ+O4W4=; b=ZqdUZKYVywMp1AuocC3Rs1kRKg
 i351BLhhP/IeGrjzlWsy746IhgYJE0heuF5brXPxIolSliuMtq7kkHUmy51YwiJ1s9FJXBBqjT3Ui
 VTt+WVVs7FNmCCb/uE22KjDbJbNj5WRBVKaHdC6P6iwOJLXeO4MTg4o8xjYr6LAdBL2M=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO9F4-000000002c2-49NB for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 07:47:40 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so4513315e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 23:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793692052; x=1794296852; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9k3avu0n7Wom+sSXSLitF3KM6neMo1JQ0s8IUJ+O4W4=;
 b=MsnB40BQMHFe+VPkNtWXuRVWfeCOcrv2OEBNLtm/3N1SGdOhuU9/TJm1kQSbjH35JG
 SmZo4f6k6xZa8z1rsbIh/2aSZXZiYdS9g1zCEUUQsu/9eQTwQheLf9n4nubaPIdEkBhv
 YBqj02TQX69b/bAz1s/WxXUVX+4Bdi+nrBHJtBU8udNKmVwe8nu6gqmyXBnfpLAmX+li
 F9CfuxGPv7xT9LSMfiwITxEyVKRkTpzPSGsfBpwNMXRhG+CI9MDmJ1Zxn8+avryBxCc7
 lL6sbEzHQ17AEyrUstLusDLtgl/JAZBo/om2TBE8tcEtIDzmR02y7WNBloB/nqi1a8vV
 0kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793692052; x=1794296852;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9k3avu0n7Wom+sSXSLitF3KM6neMo1JQ0s8IUJ+O4W4=;
 b=n09JVxrxG7o6RIS6xYA9AEawom9mXbu5jZVdzrPuw1O3EfAIF6/RTUmlmvI1brcxJx
 ON3LjNMmh1zxeL+/WwfcrbjLU90S5B5fkz9USmZlPU2ktLnDj7n7rjSNJJR6siGCSrav
 jJUMzKwETcAyg9pTqUWHCItHmllX8b+P+Cw3qJ8uVnrGGZXe1i4VtjhnoMXwO32L7miN
 Nuf+JQz/p7EbX5ni0HPmTUGWybYBWA6mggUJpRfGSI9wnPKN6ae53mjvTgo/bOaBeckr
 wVE7Lxa56Wh+o/1Dpn9LUWso05G0oC2Kr7joe0cGiHhyVhKYuATr1WJ8EqORcRNs1kcQ
 SyQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4fh1p2sRbXhm0l79/bLDPE8u+YOr0xz852QHv0PUdCdshIe8XNBNJ9b/kbcsEg2jMWNs7HIRinBvJdRZo@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8K1ahEWLtNfpmDlOuSYskjfH/b2rVWv+HiL+DfWdoyhhJLSL/l
 zSEulKP6NW06taNHKQY45LE3Qsz/7lRPHYr1rQXugcx0/7T7NJ2bbiejz7sC6U2urBP5gAdss0V
 tXnMd24AF5G995JwQJbFE7IATlMkZQQuiDhAXU7a8ENKffKZR7ePin0McCjMgUXfg2E8XlM+nO1
 XfjND5Kw==
X-Gm-Gg: AYBFou3OgCwF2uKYA3FtXxtt8m62cAKART5TCADyHSJLvs2POyF88W21WXXMmhO7V6U
 epoZBH/5TxX9rqXTbm4WkVUYiXjxkL4L/s1t6FlMhsjf0owiRtsrqn9TfpP67lPwTqKch5OohXA
 IpzsI41Z3hIhaAimwy4zaMO5frZ6BjTX+LKaAhomnYo9ChRKuBzGtLUYiwV8CfPvOfhCfA28o5y
 rYHPSkyJIarM+WYme59C/IubtITa/Fkp1q6Xf0nriNL/EgaAJiR/zdl0RVOvKW76R6wW53Ivr4K
 8wkzGv9vvJfbIp6XaMlhxMTXqyVYb/XVG2tPGKYCklKanKKs0ogs4eUhea0bKZnKIbqpLmZOSZu
 NhD8FFyR3kFl2S7Tb8aVhToJZbnmOSD4S1XtExYOcv0xU3ijsV1P5oDDs0Wk1x3Jm2Op/gNKq/b
 NLbdbPt40WF8h21dH02AFx83G2hHL79ZLCOE2dWaN3owwmOYbpOIupMjCyP0w5jQpY6zLRwKnIM
 cFZhBxFzLQKEF4QlMYnvH9Xz065VQ/1EdqPbdMtHiUNhWNdOSyOw1AmjjyOCZSScP16NOAaqr06
 f2afxCfYtCaVufyjLGbZA7+8XOunbp4K9lJteMVqgwB0GaJbrgL+f3g8bJOCb/HBZRAnwRvy4Og
 Mkss3r8mvZdbQExkcmwmNHoJzrKH/e7QTLfmhEAyRItWrBb7T4IIJZraTH9cjZFyin62lTgqPJk
 5glm9PIMw+kTsf7A==
X-Received: by 2002:a05:600c:1387:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4ac1793e81cmr296824535e9.13.1793692052328; 
 Mon, 02 Nov 2026 23:47:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a5372d8bsm43636325e9.0.2026.11.02.23.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 23:47:32 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 07:47:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4bc08f4d7d8e5b33f951a3340df187da7253449e
X-Gerrit-Change-Number: 2100
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2100?usp=email>
X-Gerrit-Commit: adac8cc9b4bdcd7be7b54a0f0d70f59acaa253a6
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 07:47:31 +0000
In-Reply-To: <gerrit.1793689251000.I4bc08f4d7d8e5b33f951a3340df187da7253449e@gerrit.openvpn.net>
References: <gerrit.1793689251000.I4bc08f4d7d8e5b33f951a3340df187da7253449e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg5MjUxMDAwLkk0YmMwOGY0ZDdkOGU1YjMzZjk1MWEzMzQwZGYxODdkYTcyNTM0NDllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e8ad60a72e59a0d739ebeebbe154e95f6f4af95c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO9F4-000000002c2-49NB
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: options: remove
 dangling pre_pull_default() declaration
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6908668608902539681=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6908668608902539681==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZPuaApI/i3U="; charset=UTF-8

--ZPuaApI/i3U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2100?usp=3Demail )

Change=
 subject: options: remove dangling pre_pull_default() declaration
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2100?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4bc08f4d7d8=
e5b33f951a3340df187da7253449e
Gerrit-Change-Number: 2100
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <=
gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Com=
ment-Date: Tue, 03 Nov 2026 07:47:31 +0000
Gerrit-HasComments: No
Gerrit-Ha=
s-Labels: Yes

--ZPuaApI/i3U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2100?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2100?usp=
=3Demail">change 2100</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2100?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I4bc08f4d7d8e5b33f951a3340df187da7253449e </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2100 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 07:47:31 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ZPuaApI/i3U=--


--===============6908668608902539681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6908668608902539681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6908668608902539681==--

