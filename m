Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB8606A31E
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MwavGxx5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QNFH3CzS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ApVNOltJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gC2KRHBW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BJ/+kFVZeregIAB3hgx7FgZ7N5d8lcpLopXZIh1oUZw=; b=MwavGxx5SK3McmxIIpbS4674zr
	yS0qVuBT5qXWpXoL9bOvv8G7G6MBQpM7u+A3icnTepBMhJWM9vky0GW2rTXSx5vegfZPMhS+82zK7
	9P785LSnMiWV9/1d6ZO8x3rmjhCkaDbNdTgVDMGFtDZsyBEKsjsR2lIF2QJs0wMTmCEM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVY9U-000000004HQ-03Tv;
	Mon, 23 Nov 2026 17:48:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVY9S-000000004HK-2HTk
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:48:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fHHUPQ6ZhRB75mhzrUDNvJrqCStt/HVmTdUyw1Oe+iw=; b=QNFH3CzSi9qNX7WYhqbT/qgua7
 atbK5+RS0phIkU9mbLkNQ8mXTZRd2ifK1Ut6yjmyzPArQxgEP9Km4STdm9joakFz6b5ccNmJD1LZj
 yqFTwLRpi5HuyQ6n2HZsrLuBKss8jNTJGoJzqqC1bRipdOEJ2BXVeFQVgxyQMVuCpLfY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fHHUPQ6ZhRB75mhzrUDNvJrqCStt/HVmTdUyw1Oe+iw=; b=ApVNOltJULAH38eh3IlcJmzYCz
 JqeDxHHFwjrv+1GNHWHrQBxr064VnHUVKxc8BO2QP7X52149cR307Nh4j3+ByJ6CYzQAHjSHGu75b
 k2xhEsprwJ5Yjw7QfM/PMkO53AGuPCPSvl0+iYDZgHlMBujHA7j3LS8XGWKeNpiOShjg=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVY9R-0000000029j-3RB3 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:48:26 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so34657495e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 09:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795456099; x=1796060899; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fHHUPQ6ZhRB75mhzrUDNvJrqCStt/HVmTdUyw1Oe+iw=;
 b=gC2KRHBW+ixkKCtMD82mrk2eqlO39W8BX0PchnHy5tWO4LVxE22wJQeIyGVw0JmRMK
 IY3V3x3L8zc2k56AN2xXztvK32E7mYcGqU5t67IsqUnIt0ETS0f0aA/8aXSD/6RhDbn3
 o2wzkXq/uWUS0iKwvNJgwzY8guh073pQN3twLieUkmlniLh79Xa1PeigG5csmUMpxkaq
 ZBE8izn522OfsktgMOpJuQjoT7kbyRDb15C4TuXATGx5Z7wqcufYDRUFn7AdXO9sxGvS
 tp2xxb15NUO1BWLDICPiHmoRq01NnZ/g21ZbDBAzNzzdWJwUmDZwxRGqkeuQzR4QL28r
 7FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456099; x=1796060899;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fHHUPQ6ZhRB75mhzrUDNvJrqCStt/HVmTdUyw1Oe+iw=;
 b=UrG0RNzRuW382MoCBHwASzylLEyKSV4AaNArRQncLUtG49GsDdF2KRtDEfwqtT6v3y
 p6ot1RChLd1HzTdIsoAEH1mM3JsgDHKvGaJNcxlu6esN+10EvgHYJrwz98KcEK4o9fIW
 1ktXblodlrjKwNvagQSSpn+jYH0DABEXq2efiLji61JPNdD3O5oswPJ2RuBxygO7nojU
 lBthSWhrVlVCZIszPYKsSNA7iXS+a/oKm54l3e02cLxlWRrcfn5iICE8LmJNODnKWScO
 4KIxUeQQqTpub3WiVOQ0Njh90q5cjwioFo6+hKw26Up5ZUQCjvxtrGq3M/ohSoa+Gn27
 o8tQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFdqumsRC0qcjf0aHafK0Jq1zxTmBR9RbDsqPuLtKf2hjKWiVH4sjWlqXgkJx6uPiLB44hnWZDRNPsuhgvt@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/GZ01pMSWtPE58ay63SNvfnwE/tIFP13KoaCBZyddCE4O5Q7ts
 xtp8xcp5V0ER7QVwd5k4jyL2i/P4yPghJwklVJ8Y5g+K6Czz6eelJ8o3CkMrBTn+zsj0002nvor
 bdDwUu3YMcILb1crTLdWjioWyTSd1js52CM9oHINg+TJLB311w6458qKz/b7xTYG+DmuS
X-Gm-Gg: AZFdTZeTsPM13RtAwWuOXWJqH4pmdSMmqisITd0mMyZCoIc/FM/KhfVmllJrQJfE0Se
 Zh4gZfYhZxQu4YNbyll2YL9U8djAsilEVVPt6f9W9m0af+ixzApFjiY+KjY6/xzFBLrURcv2yfi
 n7rFRlaDeR2tk2JdNAdvQPLRFcOODSn8CsZUb9YjCriUtTPuQdaWEhRuR6V/5Igo6pg8jaYZWAP
 VwsdDHMgy5tlKh2vkEMT9pTq41o01pY8Vitzab3rcArkn8f0dg9lMi5gkZjtnIFCFLBbjQmSw64
 miyJ1yb+Y1srkmcIpxeaoojORNy6hqag4XvAvfcYCl8JUPiYvqj4xEKYy+BC03hWNI/ZRwN0aHr
 3Xki0aY7kjAAIDbbBN9e85Xd5tsik+EPk7yvWLTPTuUQP0iiOoUFapEJMJSOmOdHPvB/bpRC18j
 VgDQActcDyD3beJOWLJuyMpCg6ev00VhJxSM1r2nyOCIspEt3IKudPA8Hnwgl5SBAtX5xFTS9oG
 W6pbLuq5C/awWSk4Gu8J+uTCIpSu1YuKhCJxEHUX/5vjO77OOfpTe8iBebKOhlEK6ZpSkiwBban
 r3kvLS6rQ7dRA0G+rfsz3DmTAA67V5aiEs4olopgnr9Kw0cAEoGV2e76z9gDf+mjZ3Z/QG1xAHb
 njfCypkqc/tkA+n+lgAtWJlnlhfSRNU1XC7XmxyGbG9Ll72O8AspyE+NPWEvCNqo+IlmlXO4Rkb
 ZASoMKwY26cBtpyUE=
X-Received: by 2002:a05:600c:828e:b0:4a2:526b:d40f with SMTP id
 5b1f17b1804b1-4bb88785898mr262910095e9.0.1795456099042; 
 Mon, 23 Nov 2026 09:48:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c248b75sm23956269f8f.54.2026.11.23.09.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:48:18 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 17:48:18 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9b2ed331b92212cf517568b0a0acecf5a97b2d36
X-Gerrit-Change-Number: 2330
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2330?usp=email>
X-Gerrit-Commit: f7a56d3206481b5aa8bb39723cdab03e3c503446
In-Reply-To: <gerrit.1795445611000.I9b2ed331b92212cf517568b0a0acecf5a97b2d36@gerrit.openvpn.net>
References: <gerrit.1795445611000.I9b2ed331b92212cf517568b0a0acecf5a97b2d36@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQ1NjExMDAwLkk5YjJlZDMzMWI5MjIxMmNmNTE3NTY4YjBhMGFjZWNmNWE5N2IyZDM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fc496f7ea78315b3f6f1b988fb8d09c05e7f7799-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVY9R-0000000029j-3RB3
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_common: drop
 unused key_state.acf_last_mod
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8671866964403222931=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8671866964403222931==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HRktNjFDU4Q="; charset=UTF-8

--HRktNjFDU4Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2330?usp=3Demail )

Change subject: ssl_common: drop unused key=
_state=2Eacf_last_mod
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

ssl_common: drop unused key_state=2Eacf_last_mod

Added in 47ae8=
457 and never read or written=2E

Change-Id: I9b2ed331b92212cf517568b0a0ace=
cf5a97b2d36
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2330
Message-Id: <20261123152105=2E9130-1-gert@gr=
eenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg41836=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/ssl_common=2Eh
1 file changed, 0 insertio=
ns(+), 1 deletion(-)




diff --git a/src/openvpn/ssl_common=2Eh b/src/open=
vpn/ssl_common=2Eh
index 436770b=2E=2Ecfe3fea 100644
--- a/src/openvpn/ssl_=
common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -263,7 +263,6 @@
     unsign=
ed int mda_key_id;
     enum auth_deferred_result mda_status;
 #endif
-    =
time_t acf_last_mod;
 
     struct auth_deferred_status plugin_auth;
     s=
truct auth_deferred_status script_auth;

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2330?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I9b2ed331b92212cf517568b0a0acecf5a97b2d36
Gerrit-Chang=
e-Number: 2330
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--HRktNjFDU4Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2330?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl_common: drop unused key_state=
=2Eacf_last_mod<br><br>Added in 47ae8457 and never read or written=2E<br><b=
r>Change-Id: I9b2ed331b92212cf517568b0a0acecf5a97b2d36<br>Signed-off-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2330<br>Message-Id: &lt;20261123152105=2E9130-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg41836=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_common=2Eh<br>1 file =
changed, 0 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index 43=
6770b=2E=2Ecfe3fea 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh<=
/span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -263,7 =
+263,6 @@</span><br><span>     unsigned int mda_key_id;</span><br><span>   =
  enum auth_deferred_result mda_status;</span><br><span> #endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    time_t acf_last_mod;</span><b=
r><span> </span><br><span>     struct auth_deferred_status plugin_auth;</sp=
an><br><span>     struct auth_deferred_status script_auth;</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/233=
0?usp=3Demail">change 2330</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2330?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I9b2ed331b92212cf517568b0a0acecf5a97b2d36 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2330 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--HRktNjFDU4Q=--


--===============8671866964403222931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8671866964403222931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8671866964403222931==--

