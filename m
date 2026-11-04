Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663C2606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OOJlFSEk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YYECuuu2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=b6UssZ4u;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JRlVT8/R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FQtEp8Aw9ekA5J6Zu/guIITyNdC230KPPlWzvbrZNLA=; b=OOJlFSEkW9lotw95vX8CbwndAz
	ZVWrp/MpFwczYa7K6mVM+N1P/O5VKYQnYzFFs0YEj/hz0zh+2di5wSD8FoBw98BfYYazSK9UpbTiz
	Xg2tgdPeQiee6uyZb1n7FfDDr0ZPCBfCtxuw0GF5NjFMzqd/dtHRHi279hiuY7Rpb1AM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOZw1-000000007vo-3MiN;
	Wed, 04 Nov 2026 12:17:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOZw0-000000007vh-49jU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:17:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CNDydXwPX8AonvHse9VwDApeNxw16ZXKcuqluokdYqI=; b=YYECuuu2cruXZl8tDMr7EbrycW
 +/3A4VcYOHxqnl2fZjSsMhuE5csp7Vwr9tSilocCuwREFYTRsq4yHwKqUduNi0dz3GiKlZ19fl3H6
 mxwMQN0Gvgid2/xgys79qpDYRdbZLxZ95NGAyPXxExoi9cy1pNnC70C5C5TvfgFwnDYI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CNDydXwPX8AonvHse9VwDApeNxw16ZXKcuqluokdYqI=; b=b6UssZ4utxQUSfWQ01q9YYRLaO
 6/C4SPwgHj8T0QTNb3vDDCWs+Ge9OBFzqN3EkhmxbPDX0Uz9sPhga1AnU/GffASzIbIdH0nsRO6Nv
 BZM8uMB7Lc683O5v64WcazKnlvkChe5R8c++ierpYjYe/2Oqntq2kYGVIr/lOa0C+B/U=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOZvy-0000000080x-1bEy for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:17:44 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so559700f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793794656; x=1794399456; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CNDydXwPX8AonvHse9VwDApeNxw16ZXKcuqluokdYqI=;
 b=JRlVT8/RPpyKZgetBThLHJyNDXFmcPrqAwjPJdQwEX8p86LNgyPb1Zh9j7zEjiRkem
 ze7GUimmBHdIKz/piAKgLPY9aGnzk+xMzkz3qnskVK8I7cKattnYu0LSwWoQFyfoutk+
 uJ4TommiKeUyDKBbOe6fwy3Ehj+BLrdLBeAO2dsB95RCkBSdgE2UkV2/xvbDoeTtIZEA
 KLX0N794dlAHq3W2ASD/5X7VIenDvpsxXPwJ2JB4QT3gqyHueLd/B9Y4ciYE3RJ/zQXp
 MInKy5bWIiXkHJ7ujK/K5XiA5TQ7ucBisb9u+Vi4aevwyaOabUIvt5kM7RZAFquBVRw8
 Fbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793794656; x=1794399456;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CNDydXwPX8AonvHse9VwDApeNxw16ZXKcuqluokdYqI=;
 b=GJs3Z9oUJ8J6VKuI5csFjcIjy5bjPtteRVFjphRuRjtAuK4B7bH9IDZcNU+7NhPP4x
 2lrxI9WEk16kka6Zs5L0lMfHfu51C+f+OZttBmx4h2BLBFwRazqtUW8uvecs8ouhijrG
 d0DXExs7g4eUZAfpizwHcnW6e5uq4XmgzATh4WyFQZAOjB7ErmIu3YBe//JbuxFa1VXm
 aD2ONBrpkapWBYZvpI4ybGx0QmkRUDFSphEFcFgihYxxA15q3jV6WeHAERdScO9kDtU8
 aBiGWfmSPipAad1yvydxR5T7XB8Q6QgZKX9sikb3wRp4xpO9ydjyIXcta2BdJJTfBKgi
 kTyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8OxUXV0aATFwpMTZRukvatb4UcMwDxjPN2WwarE1MutSvKCZG5/PE9YdaxxkV1oXHjtAHL/kMeUAKCIhG@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8js1rQvXFwlynRMZbhYH/yGtbJQ1JSTOYgK2aoDmQU7fn/Seod
 iDYzLBf8MnP89uJUGqyTg9qg/HYJnYzDZyGoXtdDbjNVD4j45GHdx3FU3bDS6wKovzf8HXqYZ7p
 Di699fZFxHq/0B8A8wLUp1HQejM974Z/dcd6d8V2kGHLqF9on1JU/nWUrEFHM5DZJnGiswBeg2V
 17Pu3J9w==
X-Gm-Gg: AYBFou1DZq79CMC42B8JoIKYsIEzkpKoCIX60lVQOct+rcocijNP+okT7XnJAI2RCyh
 yRW7TgXisU/TmCsTS7DF1Mo+OYauLTdsLriQCwjbq90JXcJ6XH3DRbNPuSzfCUUNTb6JcAWmKh6
 eIlL98WLIB4jf6V0NZ8aAbvB/6EsfeBjbNVGOvVAUBRgVqpjuY/sw/Flvj7TpctOFCw1H4vF/98
 MT+eIS8Oem7/XryLl0LGHVZ9DWIsZn0m97YWMDu9vW/7D66UXYQ8y7QmyBIQo+gxsw3+Z91f2f1
 Yp9AwLn0stqh8eLmJxnT+u1gLl/30+05tiUMWhDLuMiQNOsNkkd+OnsMYDO8Kaeuf2g1pW7No8D
 b9IO7WqtImyj19l13z5fJ5+4ZTwV+95TdK5OrXKH8BuxX1QU8YNs1w9xOSykRd1b6UfXXhU30En
 9zClqEorrAKndl8ak40VQFY2DbPubEcp1dKD8LLIN9wbfAWaiPUJy7iE2+3RzeMLUeDhS9hkrL9
 Fja9zyfxNu2HINloB5En9qxQPsMuMhUDgWLH5Nd5wuCuQ0b7eFnv2fwEELSxII+f7/zOy6/cEsk
 tPm5sr0/FdWsnEStyqE1i3lM74DrNnx2ACFsy66lZAefzNz4KMebnGEMZWBhHHeACHI8KcwCOyd
 qazDe14Pk/cTZ3JUcqmPKhjxdUNKohHhgdOHjUxdrx7TURc2UkGcGjIkBEtLQxyN5viKGDv/zXn
 FTLaDkBKq/AxDqTQ==
X-Received: by 2002:a05:6000:4818:b0:48f:bd89:2b32 with SMTP id
 ffacd0b85a97d-48fbd987860mr5467732f8f.52.1793794655172; 
 Wed, 04 Nov 2026 04:17:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea180ee1sm4241524f8f.4.2026.11.04.04.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:17:34 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:17:33 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icab02b28773a409821fa9b80ccb1560d2796d1df
X-Gerrit-Change-Number: 2117
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2117?usp=email>
X-Gerrit-Commit: 0a434bfae460af3b651e1737ec38cef82c58b546
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 12:17:33 +0000
In-Reply-To: <gerrit.1793776420000.Icab02b28773a409821fa9b80ccb1560d2796d1df@gerrit.openvpn.net>
References: <gerrit.1793776420000.Icab02b28773a409821fa9b80ccb1560d2796d1df@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NDIwMDAwLkljYWIwMmIyODc3M2E0MDk4MjFmYTliODBjY2IxNTYwZDI3OTZkMWRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0bc701ef21f206ce23a8a19dfeeedd36f1362f45-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOZvy-0000000080x-1bEy
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: print
 tls-crypt-v2 client key hint before CRYPT_ERROR
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2159992905560362496=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2159992905560362496==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fiJxT9Z7/OM="; charset=UTF-8

--fiJxT9Z7/OM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2117?usp=3Demail )

Cha=
nge subject: tls_crypt: print tls-crypt-v2 client key hint before CRYPT_ERR=
OR
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2117?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Icab02b28773a409821fa9b80ccb1560d2796d1df
Gerrit-Change-Number: 2117
Gerrit=
-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 12:17:33 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--fiJxT9Z7/OM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2117?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2117?=
usp=3Demail">change 2117</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2117?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Icab02b28773a409821fa9b80ccb1560d2796d1df </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2117 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 12:17:33 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--fiJxT9Z7/OM=--


--===============2159992905560362496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2159992905560362496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2159992905560362496==--

