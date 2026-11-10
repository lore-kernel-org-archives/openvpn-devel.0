Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A4606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=U8PZVOGz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=adOAneQO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=juiyU77g;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=W/4WqnOG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VkMufHcojMGyopT4EdssztXWU8b4S6A0KrJkODTzRnk=; b=U8PZVOGzt1zvKejz2Lfi8tO/MF
	n8gzW52FTum3oCsdEHp4xFIw09Y6t4jdiiHBM8hyMI6jslXQ3BA12ufTISX+K/IWGkKuhks7pebdm
	SdCFYQvugH7WaSqFT2hMVQym4DfNXki/CsWb25QFKB1epLq2LFqliaNeghaqRmoEQDO4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQjo0-000000005No-2xkO;
	Tue, 10 Nov 2026 11:14:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQjnz-000000005MP-33W6
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:14:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tp2Y5Ub/ZXiEFsCCfXz3X1Nwj+Bhn02tjcdvZmveI3g=; b=adOAneQOhUiTii+nDStEH6y2M0
 sO3NjUewphvfGvcorVyBVnc4ut3e2jsy5InZW9+YWSquf87LNInqopMsPXMPIwRuO+Xk00M9qB7jg
 Gl/Ky9K1Y/YmCuajWNL5yy5zK3QeXxOV/1qyEGVWI9y5KQBJsU0+hqT4nTEz3wAYxRPk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tp2Y5Ub/ZXiEFsCCfXz3X1Nwj+Bhn02tjcdvZmveI3g=; b=juiyU77gWm9LhJZs6AMs10xXiU
 6XJmW0aZBYbQi4l0YUh3vQz9fo2ycKi7bRy1fot6BJuouiAoYoOrDI+1G1Y7CbgPrR5q9kkPU+HOC
 x5LHvUXJB9JZSfOfFkiqzFcVvLLcw238TYmAGV/oRVHaEVvP8jIqpEO2Zhf2diRnUBn0=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQjne-0000000044o-2gFC for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:14:04 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so17340485e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 03:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794309236; x=1794914036; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Tp2Y5Ub/ZXiEFsCCfXz3X1Nwj+Bhn02tjcdvZmveI3g=;
 b=W/4WqnOGNHAtNhnb890Ep5JfczPGJBz9RPx6ikB24DM3sm/rjTRqAw2Cvi1ot6C4+v
 7Zo0WQZ1hrj/CgATYhSWF3epoI07LRlKWgPLqLlTaLbPhrWzaE+v6OKMw1za3MMLxNpy
 M477kkutcQpjtSg2JdeE3UskAdC/oudynHU4nTqaHzmbPvBVx+mvNFFSsxohW+nUsdOj
 RiEyEFs+D5MEftRCs0yg91cL9E2jD1C2/6QEbAPPDiwR0Q/ADrkZH1faivuJt8S7nNsk
 7d5FG7fkRpMLo3uULN5FgQ7z/GbGAwXXu/NOAwxDg70/WL+34bYX5Fehq1wTE3BUA7k4
 N2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794309236; x=1794914036;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Tp2Y5Ub/ZXiEFsCCfXz3X1Nwj+Bhn02tjcdvZmveI3g=;
 b=WGAQ2MKHIMSf7/vNUqWioAvqrwuRwk6raQoRS/kDV8F4XGEMQGpQKZhieP/QlGx1pv
 Dcb4sVpyUU0ZvYM0FZve+ZesYB/o7Ctbg7GXxspFS5unsuHBCFzukHVzx1cogadEAGCV
 qPYXqv/sk6SRw877SfU7qOJvxwp0YqdyWBpIobdLLHkYwwvxfAqsrFr2l2G1UJGDIVb1
 QXLPbyFuGo01e/nI2o4BT00aCHSstnPkw6oAu6JkhNqOwh8d0+xg+5JgSWoTh1Bk5Sui
 k9bk99yx7yhKqrimN63hrcG5b+EAFm6+M8Zq0QxkHT1PQulHauqUNWf12SCFUVOjtWjC
 Y54A==
X-Forwarded-Encrypted: i=1;
 AL+hErG9vR8UyE8GrsYU78Q2bKcRIwQwSNfRdtZhNGVBQzFWU4YvuuYtdYcDe6gdlq/DscpJ6mvdE5iidPdX8we8@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+pvbJ6iSN7m+hxGTl/QLy3UqNQD9QbWfRvOjYnhFfIWHo9cvnU
 JxRcDviY8x7UxBYYaCxqgurbY6j9Rb2eg5qQ/aF0phbiKxiBhn2N4mSKdgx5EqzgMxgU/RkSSrJ
 Ejg7H64CuWRUdakQpdUHFnpSvBvASMF0Q16kNR6fbg8UezpVOxa4J956t6zokEdb4C9qO
X-Gm-Gg: AYBFou2RFjBJwEfPZdntir9A9uD74I7w/yXU3PgCSGbS6TUCq8zt3usEwjaiLk+hNfB
 Ux1AxkJ/fo6SYD0tk4uwGaqh9NeTLfExARlChb2JNXF0BO/FDsw/qN8BsNGdiCXzk2MuXL4ZDHg
 U8z1wCMVUDyQCP0ueQcieLW6yzk8B/y1InHst8yATIMygXpv4huX/TBEdLKSh9plD004A4+6p6Z
 C48FGEy7zMb2e+PLOdScdxBPpbKo4Nt4Lrlrn0eWfUZKG+6ungcSS/uUKOkNmaMC5Q8nqKbd16t
 a9FB/pgHPHj3w4ZJ0JFcoswBE7MfPvZJiGWN7FoLs0zm+iWMbyNFfXpRaZtB00MryFQq+JuCWIT
 N/PajZH2IYJ3Tzr2eCJsqNNbmNyo2NhPdvF1/UQvgSryCaYrF+CX7WUWmIRn0Ta4EqVOYn5RZe+
 yU2A2LTtIvytXcixEYkKZCtHDWFYcL0HWx1/MfjH5047J6EAZgj1uS6qZN5CpfbJXlHJxMjDzhb
 4rDay18kxTcEvALHxjXJsvG0wrOmWAeO2yoKzvpLCOhpNsV0p26oMmNzrtKkKynTrV6oq/zt3nr
 V39TRLu8GfFWGlLgGY7zjZfhLOYsTegp1vIxQ6Y8kuswdvOuhiG7qq3zN5xvWuJE5l+htOwwlVI
 Y6ccHrcwttE18KYNLkpq7kE8KTO0vm5yQgGbx3iLXPyjQuJI4nNVMAn0p1dKb7beeyM9gWew5d3
 k3b9qbgVGgAojCalM=
X-Received: by 2002:a05:600c:8b66:b0:4a2:167a:c93b with SMTP id
 5b1f17b1804b1-4ba023510e2mr38468465e9.30.1794309236048; 
 Tue, 10 Nov 2026 03:13:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba022fbf75sm47860755e9.0.2026.11.10.03.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:13:55 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 11:13:54 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f
X-Gerrit-Change-Number: 2163
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2163?usp=email>
X-Gerrit-Commit: 4cec021e663787b962dc818dec3af846fcc88b78
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 11:13:54 +0000
In-Reply-To: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
References: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA3Njk4MDAwLkk1YzUyY2M1YzNhYWFkMjFkMWMyMmYzNmY2NDUxMjM1MzAyZWE2YzRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b5eca27f6e1f209fdc5cfc2422f65fffec26ed80-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQjne-0000000044o-2gFC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: sitnl: clear
 inet_address_t locals with CLEAR()
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
Content-Type: multipart/mixed; boundary="===============2754527030156090346=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2754527030156090346==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ELqQtKc6PbE="; charset=UTF-8

--ELqQtKc6PbE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Demail )

Cha=
nge subject: sitnl: clear inet_address_t locals with CLEAR()
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5c52cc5c3aaad2=
1d1c22f36f6451235302ea6c4f
Gerrit-Change-Number: 2163
Gerrit-PatchSet: 2
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
ntonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Tue, 10 Nov 2026 11:13:54 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: Yes

--ELqQtKc6PbE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?=
usp=3Demail">change 2163</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2163?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2163 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
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
isplay:none"> Gerrit-Comment-Date: Tue, 10 Nov 2026 11:13:54 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ELqQtKc6PbE=--


--===============2754527030156090346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2754527030156090346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2754527030156090346==--

