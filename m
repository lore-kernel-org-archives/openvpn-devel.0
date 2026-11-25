Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A3606A696
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aRyJUFX3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SnzcT9LO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=je62jzw0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GN+vdp7z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GbVAx7jQvvBQB44kt7QjklW5XgGZ1Y8ckxnwSUaaCxE=; b=aRyJUFX3uMQ1RhfmMfl9qv0o5d
	BIn6BxJVdIKF+MwcOA1+m7PCyhuXWIMd/F2cWuFZHCP+CwAASaWFsZ1NaBMtMn65wR+cXqevEW8XX
	8P5Fr32xZcNbc8AedIyJ6TRbRUVc8+0JusOYNMuZXykpZ8bt+3nj+4eh8sXuQpdCUVvc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xW9QD-000000002lh-3ek4;
	Wed, 25 Nov 2026 09:36:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xW9QD-000000002la-0WkD
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 09:36:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1vpDstz+YBKBbPLbBITB3L0acYA0B8IDe9la8R1ox8Q=; b=SnzcT9LO+dApfBywR0R28oxdQ9
 y0Ma61TMzZMlmG7ujMayCNwtIXN9+DSf8JL0KXeD4iF30o3Q3ExUgMmmwWA75zGuttKOsz8l3QHAe
 syYovZMBhmBRwtBdplwcdId9zA9+vlMK5HVNvLnpUIea6v51ScITFD2PMC9BnR4bQaYo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1vpDstz+YBKBbPLbBITB3L0acYA0B8IDe9la8R1ox8Q=; b=je62jzw0n+kIsbPKHEsFKnEl3O
 7b49KjbKK+7BryccyQI/0aIXT6jKt7FxrtdKh8tmAApsm/i4MHdXKMtjMzjxjn4l6Fx/dQ+IKXvMR
 gNTUozr6ReUwqDiSmJinkEErY7tTMdIkVq8qzTx3PzKiinMW8INaLHnY8hgCHyZjb9uk=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xW9QA-000000003Pz-2Ax3 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 09:36:13 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso57512265e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 01:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795599364; x=1796204164; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1vpDstz+YBKBbPLbBITB3L0acYA0B8IDe9la8R1ox8Q=;
 b=GN+vdp7zqp0OJTf8p4DZFxT3fEU0KBc95ncBsH/wZtTMXE7rd9F3uQDaf6YFe2K5eB
 WKz5AraGiwc+fAB4igRpHqCwUZGj38zz8JrVdUwdfefqcIu+5r9Nmu2ZKwdmr/1sQ82/
 fxrwdoqZuA09wDZdwcVsTb6dVw+c8N4uI37ZPwEVPojl7k4WsWuDQfMB4fKZ1FiVuL11
 cBLfZ5aWiHitQzyUnPDei/ZkzwGJXQ1HmEDaA0C51ZN3lWdvQSIipENrYPMyyVDpSTIC
 1vdFZBYAU6GbPQHV2zx+e0YbFKwB3ilBjrs3zkuYFRPVgyXHHOZJLwlYz/toEEoXX5Bo
 EkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795599364; x=1796204164;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1vpDstz+YBKBbPLbBITB3L0acYA0B8IDe9la8R1ox8Q=;
 b=VjB23RXGYF8bUwg/j2I4hC+Z1Uv5y2AufgtvwNhADyjDSy8ig1Od8ff/+OqFpo9mgW
 YAnP3dF6iPVBSIPMSXMKgLaQADAzyLQjJJ3wFHV4bEMN7Jt0BbOJd9r6zakOhmt3eBco
 xI4ZuM+ug8p74N93vIkLc39O3qg5TGRSgyJoD/p9ETA+1PR4C94ivwkC95TZJwB37QZk
 7dBnqRE1CiEj357l8CizKoSZSo+idGmbJTm3XP9+Ai9d1AgFp4pCaKHvxcnm9hDHc0JY
 rrBk8+MSewvsmOZxoLKiL1Vr6HQqXHe+TD/WaYZFV7QyPjPD+cuhsJuDPfTfkwX3CxhY
 j6Eg==
X-Forwarded-Encrypted: i=1;
 AL+hErFePII/zjI3rnRl0r3WFkJ7nzf5AQaNVEZe+/AN5qoQXX45HkQlPv+RllPaN2QCOk9SiKPfvlV/1gJKc23J@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+PIo+Cml+tudVgvywLrD19vNoJSn0tEu8CY32SSORxdcs6UMlP
 OrIvSEo4DJwOQ410UbOzmh0Iq5LNDvKFTKbPz7e6RyiUiibfpzfp5nnPZT9IpA0Kiy4nxIvhRVX
 RbDvvggTWCOrZH0ldk+8z+HAYIAKM3l7OWQ413J7cP15YnOHoSAuZULNHTQ286IDnVovj
X-Gm-Gg: AZFdTZeEwPp+6ab9SwK/VHZFynfI2Q4SM3bdzt4ACVMQwYLpoVmj36Yz+BVgQT88Dsd
 NDL9q94QSErVBu0hQD1/LPyqgNBt5G5sB9r1sJxmAWdDrOU9aNoZ+jlUvwP6IZFXmWvwfGcBje8
 UsPeM6qjEjfsdC8t987heh60p3I8yf2SuwBx0E5a5StZnUX4uHgARqQXrMBILzKNH6nopz1vElZ
 O1xy6EuQtpq2xjJDH+Oy1UVFgAoSk9X9BMl/UBfc6/UrJV7Gy3vOYSHHz8QccwYRSV1TELBq8nb
 R+uksSIvAoIAbJSZA39D5ite8kAi3GZOSiPwVmdJoCl+rfpDjVC+prpfOHjsrKATti7abPb/w/B
 DngLcbR693EJrzuMzAjIpFBSD1EkJaSd1O8WVIWyQln3T49l4ahjLWpFH7Nqqj3DQAlt/LSg6oQ
 +sYjWUkmlxBmtWKBHh1crLeIoQoOIFXQToBDu6OPScOsFtfTB5RFKtZ4E3PQQALeXk4NbMpn6b7
 C/lWlkirGPX44dZ7F2YDYh4Exw38kbAMJ4Nihb/xs3NvxgiLjfG9eyRfGZUWGnoQqwBmlsDn+dw
 3S8C/4RL2mGe6lKQU+ytKWfR6BkzWnF7gyDCVeMa6BuXunaDOBv9w4Rw7dErOPnpAPjchW7DaZH
 UFfVXOu6Y41fOhtxPueWidUjJ5ohsTqTntlwIYVmGl6on06RENnYF+ghlE7A9E4rfG1Y7C53hr1
 gAsHSLheu/qb017Hc=
X-Received: by 2002:a05:600c:a085:b0:4bb:85d9:156e with SMTP id
 5b1f17b1804b1-4bb8880fe46mr347332765e9.11.1795599363862; 
 Wed, 25 Nov 2026 01:36:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b2c5sm500417315e9.5.2026.11.25.01.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 01:36:03 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 09:36:02 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: 53542aefa682e59d804ae353be9731bf15ed9dfd
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 09:36:02 +0000
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f5d127c857634683872dd101977a8e6c11f3ef5b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xW9QA-000000003Pz-2Ax3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7724701429574664216=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7724701429574664216==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BlhMZJ5+RPs="; charset=UTF-8

--BlhMZJ5+RPs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Deri Haerudi has posted comments on this change by Deri Haerudi=2E ( http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail )

Change subject: =
dns-scripts: parse dns_vars_file as data instead of sourcing it
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

Patch S=
et 2: addressed both comments (dev check in the reader plus %=2E=2E=2E% sed=
 addresses, '|| exit 1' on an unreadable vars file) and reworded the messag=
e accordingly=2E

I also corrected the last paragraph of the message=2E The=
 resolv=2Econf output is only byte-identical with 0 or 6 search domains; wi=
th 1-5 the old loop left fewer trailing blanks on the 'search' line=2E

Tes=
ted with dash and bash: crafted dev values (sed 'e', r, w, leading '-', '=
=2E=2E', spaces, quotes, $(=2E=2E=2E)) are rejected or inert; tun0, eth0=2E=
100, wg0, utun3 and tun/0 still round-trip dns-up/dns-down to the original =
resolv=2Econf; normal resolvectl/resolvconf output is unchanged from PS1=2E=



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id05f3e4e32aeb8=
06d762858e754adc82f42d4371
Gerrit-Change-Number: 2341
Gerrit-PatchSet: 2
Ge=
rrit-Owner: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Comment-Date: Wed, 25 Nov 2026 09:36:02 +0000
Gerrit-HasComments: No
Ge=
rrit-Has-Labels: No

--BlhMZJ5+RPs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Deri Ha=
erudi has posted comments on this change by Deri Haerudi=2E</p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Patch Set 2=
: addressed both comments (dev check in the reader plus %=2E=2E=2E% sed add=
resses, &#39;|| exit 1&#39; on an unreadable vars file) and reworded the me=
ssage accordingly=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">I also corrected the last paragraph of the message=
=2E The resolv=2Econf output is only byte-identical with 0 or 6 search doma=
ins; with 1-5 the old loop left fewer trailing blanks on the &#39;search&#3=
9; line=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Tested with dash and bash: crafted dev values (sed &#39;e&#3=
9;, r, w, leading &#39;-&#39;, &#39;=2E=2E&#39;, spaces, quotes, $(=2E=2E=
=2E)) are rejected or inert; tun0, eth0=2E100, wg0, utun3 and tun/0 still r=
ound-trip dns-up/dns-down to the original resolv=2Econf; normal resolvectl/=
resolvconf output is unchanged from PS1=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">change 2341</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id05f3e4e32a=
eb806d762858e754adc82f42d4371 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2341 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Deri Haerudi &lt;abcderyscr=
eenprinting@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Wed, 25 Nov 2026 09:36:02 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels=
: No </div>

</body></html>
--BlhMZJ5+RPs=--


--===============7724701429574664216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7724701429574664216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7724701429574664216==--

