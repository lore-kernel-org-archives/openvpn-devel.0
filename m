Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70160606A337
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Da4Ce9px;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BVMAFDYw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RmXytVkx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Y9eQnTZc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SbgQXIed4ljq+XdYHavgQmKrI70W6sNyL68p9hwWyMY=; b=Da4Ce9pxkiKsGYLYIrPUHwccoJ
	OY0XBHFO8s4BdUAl+KYlUtI6BSY2gOPEI1x4RUiL+moaf6ToLwxLnfrUJpE+C8+62omdtU325lBNd
	m/+pYN9jKxDmVj8v961x4dz1PDXVxIWECMMWY5y6qeY7d83IR8zoRvdgspfL7bkHyJSY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xStpe-00000000525-0lb6;
	Mon, 16 Nov 2026 10:21:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xStpK-0000000050T-3rwK
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:20:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c30u7MBf6qegKVK5nOHENSSBLSPHgY8a5BZjKddWh4k=; b=BVMAFDYwF7OE//mye15K6dVfmq
 oiwg6u2Fe4KnUGSqznoh9v2iQO8sNMiMgO3bUpATSm285TsVmETv5Wu+GvjYYem/mNVAliq8XdnqE
 w2JjGnG1ZdB/1BQt2DFzaPrz9nQfAZYuVILpjKlhxLyYJWQw62MIypk55oXG2Y2xtqFY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c30u7MBf6qegKVK5nOHENSSBLSPHgY8a5BZjKddWh4k=; b=RmXytVkxKhdkuFoMkd6OKIJm8R
 W32XPixtv5x0uDJt50T6N49o8ile/JmI4fTZNFlklYsSl+ytwn7sBVYUeVNlkXwa4wA+iGjavwZiG
 0hda1REZxt+N2WbO8LAqnTDflCJKNPxMzCZhWnJCxFE3W+bj3eDNqApgzEZE4PQ2sUwU=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xStpH-000000000ko-17x8 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:20:42 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso2127763f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 02:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794824433; x=1795429233; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c30u7MBf6qegKVK5nOHENSSBLSPHgY8a5BZjKddWh4k=;
 b=Y9eQnTZcv1UJYXO1/1qP0t6QUwUN1NKvdYPEy+Pq0jf104HBbLKgtTFAvP0dbtTysJ
 sxFU6ynCfbYDgx3bAsb0I/mLZFEughcJOT1svhyR/eMPMNh1NzJCu3JWU4EnqrRux1a4
 TKtBemPscketZ9kOQ/IT9umcdDEyHt/3gweyNqw5Aj/bP+XSSSKtK9smgAY6J8fAUiNL
 Tq41fTk3Mlrz0AA+GEL01kYdOC8QE5xjlTL+xyVelxuhRta88gJRL66vfxmrgKJ4u40L
 832ieZ2kiNwGtSlJUqs+njvNGK54NSgCE8wofePv6Z4vv5HXfvDUgIBI3aw/hhV+uQZZ
 IIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794824433; x=1795429233;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=c30u7MBf6qegKVK5nOHENSSBLSPHgY8a5BZjKddWh4k=;
 b=KVfCwxFme69TEi7RBHCc49v7pl/qG8wqABP8SEbVKOxBYb2wSSbTaCl3/EooaDyr46
 mIegoqbxwSbKhp8wy9p4KzCzhk2eIu/gQCDLSFx281JrByqpZS3KWf+VpXH1znA74xE1
 40ejEFiilTycN+aI61Jc4gx/QG5nrso7ydWfwgqwW5EMidcSOGfah9F0mYnUyy4u7kZc
 NKK4v4heNXF+SnSeIYavGbBq1sYeLtN/bCHmqmrnUZ0uvxBjTwoZnzUWNz+UzhLr3oQ4
 pYOj4ba+//EdnssN5TbHrz4D3czoQPR3r98Smg9nf0YQxRMXlucNUpR+bJSA4RGNsCW9
 LQLQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG0RQQE/ozBgVnm6y9x6xn4iuk/7+pnnDyryzFJhzLyOgvrvPlwHyFlnfIutbb9+bENBx5qIYCMXAKK3Vrb@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9vhX+Jodu4TRvIDBp4WWBDzY+NplzlhmjuHqBgptXOD+G9srvH
 G/LpELfYaCprIJKfgT1p9JZN5cTIeY1IkhVSQ6fgJeSZnCcEcxjysF4xSv3yIkS0EAVsQfxNmwY
 Iw/4Uw3e3nnWmfvfbQfgVvHkuPyGhJbPYB0Et2vseTNdgHdE7GLUgSJDAbrI4Ha37C8jb
X-Gm-Gg: AZFdTZeT3JMJIm4hOGtOb0T/TSgdGJHttx56gpBikwwJ1FwUjWH87tOjp1q2UfzgNaL
 jdMAgVjHyw2kfMSV2mizQKJFUpRIESjB4IKuOu4fL5cH9CKfjJMrfvXfZ7gM88x2/o9xLBOuz6M
 ajJfCxyNBXC3yCNXIRPS9pR8/g9ujB4Il6T4liDaIX+MxkNuoTUtoRwAbdn6kSX5LgK+62xE4we
 Hyn11NvtmIwq+wXIyg+A+TUPWBl/Ut1m3nd+gI2mb+dskhX/hDqsA406nfb4AA5xkBv5TDYUfgY
 /5mndUQ4VZrlJJVT4saRkTr257s62sGTYBH0D/jG5G0bfbqekj1sBivdloeEb/Bkv+CEZ9htk6o
 biuUlvrzkeU3YBCWo+u1Kq8e6F6bi243HqyWRRY3kWrFQmRlvXE7AxAn9GYYmKbVqL7A5sDymWF
 a8CflpptiXRQcPm//YAmAH5vf6BotGvEVD87R6/vo7+16dLMw9lkK86qd+ECEuKVLzmZxgZy7LQ
 jmoEZtIOeRXAkbCjwWuPm9N8yltdOT/YIai+ULpgfLlL4ugY9eCcMDmjXc1Q+ckcC5OPkd5bBnk
 Y75WQDxKSwro8y8KqQNWcSTm3XmTJotDeqGCQtLwcNpYlBDxK/CU0UcIh+Egk8ehHZWsm1S14hN
 X7C3enG+vDUaPpbbe6P2dtgDgeCXIvY2GnyfBjKvg10HJOqS91hoUup64N0bgNXRuBtsXUuHeYk
 oJbQr/DrzQVdn0rJBk
X-Received: by 2002:a05:6000:2886:b0:4a1:bddf:9003 with SMTP id
 ffacd0b85a97d-4a1bddf9034mr4029444f8f.49.1794824432438; 
 Mon, 16 Nov 2026 02:20:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c6451sm22855566f8f.45.2026.11.16.02.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:20:32 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 10:20:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idb3c52174e588016240e9c9162a1676e1531c551
X-Gerrit-Change-Number: 2101
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2101?usp=email>
X-Gerrit-Commit: 6ff900bd4f226e6b1b1c992d531f3eb7d3111d23
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 10:20:31 +0000
In-Reply-To: <gerrit.1793693047000.Idb3c52174e588016240e9c9162a1676e1531c551@gerrit.openvpn.net>
References: <gerrit.1793693047000.Idb3c52174e588016240e9c9162a1676e1531c551@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjkzMDQ3MDAwLklkYjNjNTIxNzRlNTg4MDE2MjQwZTljOTE2MmExNjc2ZTE1MzFjNTUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f8c9ebe52301f007808450f0e6f3cc3c07e09d03-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xStpH-000000000ko-17x8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: check
 ovpn_dco_nlmsg_create() result in new/get peer
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1250276063606330597=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1250276063606330597==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R0yhgoEG8zw="; charset=UTF-8

--R0yhgoEG8zw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2101?usp=3Demail )

Cha=
nge subject: dco_linux: check ovpn_dco_nlmsg_create() result in new/get pee=
r
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2101?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Idb3c52174e588016240e9c9162a1676e1531c551
Gerrit-Change-Number: 2101
Gerrit=
-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Mon, 16 Nov 2026 10:20:31 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--R0yhgoEG8zw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2101?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2101?=
usp=3Demail">change 2101</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2101?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Idb3c52174e588016240e9c9162a1676e1531c551 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2101 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 10:20:31 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--R0yhgoEG8zw=--


--===============1250276063606330597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1250276063606330597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1250276063606330597==--

