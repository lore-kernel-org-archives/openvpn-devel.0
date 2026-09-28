Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660DCCA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5++gnS4MXd0A1ieVSwMigMghTybAJSIOYn4qzpTfDmw=; b=gxWWj3gHRh6IseM+iJ6zgHwUg1
	eYlAyafRO35CCNhZuFm8QSz0CBo+7E7CLYuvuM+qIqgln0kl7aXnqc56Ccub8ewbV0zwdNKYpFWhM
	0WT/k0aNZAV/yPQK2ZYB1rN8FLUWrj9K0cPefLrwgCuTC9x+lEsuqEFk9E8DpPY1z0Wg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBCYT-0000ZF-Q0;
	Mon, 28 Sep 2026 14:42:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBCYT-0000Z9-2k
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:42:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dyeij9A9MtzL+80q3OcJq4iewrgpEHfBZsVigKOOgzw=; b=mTolXl3ujJSWeTwuZw/++wesF6
 wJBH/sm3X5fJDDmgeDhtREDAWIU/lRL1xzjMGYodwS+gwlEHd5Zb2lEdlfdQFGESuwPH/KtPJIof/
 X2oIhTBIwgYw4mVlxvNKueuGeWzIO9lV5MtqXpLnYr5qBdq+7TxydfubGvIWYXFrERDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dyeij9A9MtzL+80q3OcJq4iewrgpEHfBZsVigKOOgzw=; b=B
 qTkeRJCHqc5w/+bYwfy4ZblFHjPWgtlfftcWWJGco0yKdM7QyoFMNFQpQksHuJKngCYPVsABmxEa6
 fJ5EK/pdlbJsVYn03wUOAntc3GAONsqVOhqQUyw7BkoAwz44WQzZkbVNyKbipo/mB20VHd0q35dRX
 BT9GcykGwT4cByY0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBCYO-00070a-Ro for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:42:06 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffb83bf7aso16922455e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790606518; x=1791211318; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dyeij9A9MtzL+80q3OcJq4iewrgpEHfBZsVigKOOgzw=;
 b=GunOoIu7M1VdvWwt1VOXiQmJhJ1DzTXyzjWze1c7xtz9XRVg4oEDU82trSFZsIDC4n
 fLzo06IRh+aFmQ+/TC7Lw6WyJjYLoZYeTRrlOrXWoTEYQEkEzVPmeGfoZggNmeIxe6c/
 +P0vexZxh5WlbAPBL/z6l+Z4k7F6nuBT0RWOMEsVIStrEBb+C9E34a0eQhiy0BWkjjZ5
 5dTpg5QjRytxuHLD0Z/TBtmDcuTFyiAUxyFMKo3DoU+QIrS8KpA3gb+UmIkdDRrnl+XO
 JHp0Z9w5c7YFuZQRiWx/cb5+lXXATfiL5Nfi/rmXqiFedjGtGlAPqlBKfqhHLKILnqkM
 qdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790606518; x=1791211318;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dyeij9A9MtzL+80q3OcJq4iewrgpEHfBZsVigKOOgzw=;
 b=UBUUwunWfQg8fBLG6tjQ3FMiD7xcBFJOaLIjX2Zd5n14lC3c92HN1S5rVMdUsm55iK
 4m8ZRjcwYa4yabEZ8aJ38aGWlSzxtahSxf8F8k7aI55kgXAdL/BHOReKpJwLXiHo8FjK
 3Nfu/CxHPZ/35r8/JQ0Z7n/sFI24NxqKBwEYxjI91pg1APz1qQ/v6ZxpB5V+tML+yYd0
 tvw7xJW0OuWmD1vPGD5ig/vBltT3LSG9+tcdFK1And1y8LsWSde43zXtpMLIZcQ2RTMv
 am3KU7taQlaSi5VZm4tlLO2OZP/wvVTtDYGB86eI1A/yh62BeaJey+7mnZrils9S61QV
 3hpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+0KzOVVvr4StviKU/GRED7ZFfqqt2HocnZVE3hi/eobaAuG/w1hivnB5swi8Ep4jZ3pu4JgxRp26aHeYR@lists.sourceforge.net
X-Gm-Message-State: AFuF++m/ZkVXS6YSjo3idt8h+IyFVrmkyKIxsMSmnVl6w1HTkl+GSqNW
 d1qmtPEIJgdPZ6oo3ez8ZtlT2kyTrCDjqSUVk1AIMeTJV8v6g9e1jFW+Bj96KHz3aF7GcB8BHzP
 SdpWoOz7NPm5PuTNLMHokSwCYiTj7AKFTzRFDlmmgG3bS8ebuTQbwDqVzfQ0Wo2tS1uLa
X-Gm-Gg: AYBFou3H2lT3eS8IVkk93Mg3Bq91iIdFw2konTWVo1mFhO/kcaWuvgjSQE3hXGmZ4QJ
 Zrzlg4w8NIEgXAcX3ncAxM8elhrha1PSMFOgkHdVZ/x65hobZUIqvGn/+5rXCRoj+GFbOjjXUw/
 3ScJvsQro3r8V4evr7KOiVrI59CuQADNiWNNTbbPX0csZBnkYuJwY9F27GxLJxchyVPSsleywG6
 s/tUs3p4yF2OQf4jGqmH6T1q1NaaQhm5ACIvmRAdIExFzcLDh++I+LRHHZXH27NqUO/16HX1lm/
 BYI8vByDypljGDp1sVBTekjSry11d0lZRHYvawLAanvJbrK/UoRu81PiMaQ0yzmjpVpWF1eHfH4
 aj0AJZvDLv3MfWL1WmD6QcQCa6LtMGxXcaW0tVRYJwdFjB1tyUnLSVKR54oBz2RM6kznIWE0L21
 3nJ00z3XqHDpbH0OdU40A381/7eJlgUdoNvw48u+X9X5Z3FB9BH3FoL67ZFix+rP0cVhyQKoKL1
 qQwGxxFDmZLv5tG20vpY17VBAW8oT+3T4T11IqEg4N7JLjqeYO6MQYKACYRiKoPXyB+a1s01sIU
 7hsILUiidgNFhMOcrERqHRI997DO71leN0jDOtBGGfK6q+9bLxpyWHExEoivMA==
X-Received: by 2002:a05:600c:37c4:b0:4a0:b6:460f with SMTP id
 5b1f17b1804b1-4a001e8c579mr75122995e9.33.1790606518132; 
 Mon, 28 Sep 2026 07:41:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a007fd182csm46833965e9.2.2026.09.28.07.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:41:57 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 14:41:55 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 7f48516ea1d96c7a8545cbdb1292def401ac411e
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 14:41:55 +0000
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <833f5394fa4a6375ba691a49f0bd7e3d1885f431-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBCYO-00070a-Ro
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Build against
 Windows 10 API and remove some backwards compatility code
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
Content-Type: multipart/mixed; boundary="===============8223662826502167504=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8223662826502167504==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JNIO1w1f2bM="; charset=UTF-8

--JNIO1w1f2bM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1955?usp=3Demail )

Change subject: Build against Win=
dows 10 API and remove some backwards compatility code
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I44d7171c7e4f8497bf8b90=
2380df92a58bf8a79a
Gerrit-Change-Number: 1955
Gerrit-PatchSet: 2
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 28 Sep 2026 14:41:55=
 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--JNIO1w1f2bM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>razvanc has posted=
 comments on this change by flichtenheld=2E</p><p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">change 1955</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I44d7171c=
7e4f8497bf8b902380df92a58bf8a79a </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1955 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Mon, 28 Sep 2026 14:41:55 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--JNIO1w1f2bM=--


--===============8223662826502167504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8223662826502167504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8223662826502167504==--

