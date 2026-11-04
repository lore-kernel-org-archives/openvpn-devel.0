Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13029606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QGS0RhCJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VyhV+1t3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a31SFbev;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LlaYx/fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jJSKCHGAUnT86k2Jt5Eupm549OqXDZsZI8jOMa5DBcU=; b=QGS0RhCJ+MoBcVle0SOzjJUSRx
	dim17HtW25Ee+k+tg2hhBd6BnuD+rcmgs7gB4jAsw5Z40GxZi8waJMDm9fodqsnQZZUF9QmaY9ZW/
	dSuNs72OJpaMs6ajqRVyeUSMCTGNEYgmQX0oNa/X+jWcAYpsIvbTRxX3Zh5hn515rCcw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOYk0-000000006IC-2anK;
	Wed, 04 Nov 2026 11:01:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOYjs-000000006HW-3Hw1
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 11:01:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=raSBY1WGSBWEoIUjmd/mlAARmJP1KwK89Q2brs/v+A8=; b=VyhV+1t3rri0HjCV2CIxQHD2ip
 YpkCueiwFJPioRVajJzflyy86JkaJlm9OkincQvcHpS4tGmHp89sLmHrlA75OL1RswZVuxtEfnVfZ
 XntNHZA1N0xz8N+aPlGWs5i48VqSqpgDbvnZa1w5oS/s8j5Xl346Ins36clMq39YcKaY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=raSBY1WGSBWEoIUjmd/mlAARmJP1KwK89Q2brs/v+A8=; b=a31SFbev6Kw+8QJGkHpgBYVuAo
 7N7/6Hl95ShUputrnHENMrfamG2u/ZWyerTEUu8zOrF5juUM1ajFPAzRNtWQ6zQedmaOvbzqZXKHH
 SKbKNEOi3z4H+z7Y7InFJfSGVBnsF6dVlybc5BF8khmmuL1w7i3Wv0yPZYN2xA2cNZkg=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOYjr-0000000005z-1RaH for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 11:01:08 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so3584465e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 03:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793790061; x=1794394861; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=raSBY1WGSBWEoIUjmd/mlAARmJP1KwK89Q2brs/v+A8=;
 b=LlaYx/frB0Vk5tnb1PYoBKrxIrr5S1nVgnhlDxQiy0+kFho+lS6gjKeDKl+gT+IiNz
 yUoZFqnUEybvGVBiYLlETnHDP3DO8qZj9hPWsGfyOSVRfbcINz1CLpWLbce/gVnMPVOP
 Gt18NP0rVcDYjx8n79v/ziNpSWHvrgekejGaNHnSnOcIqH+WY3H19vYOE0YQ3DWNEo2Z
 iq3Z6gsYqXIg9GFi+vDDSrIq5d58j2+28374jxaOfoMJxb0O1zHgmsphT6saeRKXjL8f
 NwiAPM8t9u1hT6FLqMO3MBTL0oAbXdBMLm/Sz8FptMvEyZTl3g9+u9771OzxznA8R17R
 V9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793790061; x=1794394861;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=raSBY1WGSBWEoIUjmd/mlAARmJP1KwK89Q2brs/v+A8=;
 b=FtoDaEtZRECJDJx+ozOE5K3wr4jbZJMF3ZOH7FG4vwlcZbnz/WaCaxFCjUYe6tz3kS
 Tlrmxl7mNhbH3LB/N6JGFbJUdQ1l1jTKtVkjDbl2BH8ltYsyJsIy8/+UyE8tv/2/U0F2
 mYZU4/Qz84kDfsDJ1DlbLIxw025N+4CUFOfrG8F6A7QUq4Xw0ZjK5XcYnN5crFWQuFjG
 tE8IXOdoUOzaz+A0vlE+NyyO6gHS6H7DNH9UZvVHpBpcPfdXzE2lCxeFvnSNGHzhZUN5
 oFCiqmri0q1Yce7lyvaxdRPMujJSCVTQxP+/LUX6m/QkXXqrR7K8ZDQyS5tZ+qHV1ELH
 vkcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3HxQ5HEhracaAOGM8q9OoQX8aw4VGPV+IVh6sFiJPQe32zU8ozep9mRq1p6yUADnImmZYWD2HAJSRkliH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8317Ucs6AY3/wJcjkPuR/GMMMx5SfbUIdGibIyFXYl+GEACbmy
 I30o9aeGtqvyl0wx9Yo4XrEndxDWQrB3/uRynnEqlZbBInX8ysZklg311C/F1oqG2I5iC0QyLgu
 G5+T9wU3VoAEN7gJDQh6nkxB1eep+VzJ/iGvY0TsWY/8tf8U2bfDPrmONBfY6RlHiiqWQ
X-Gm-Gg: AYBFou1jRdt4fXHui1BCi87vhq1bH3WiVY1ySGCC7oriQrOagGLSBqAU6uvnbM1D0lg
 kFNM0ZFEDcBCTNPsc3dob0u+V5LbnhASsFCkwgo7psYiRXKtz7yd+AbviyAZ2JZTz94UI2YJML0
 Q2C9wxe4yXy23pPKlCx5APKx1oBOe4aGyu21Z3qRaAnFR2BUJobTZx9k3tCwEWrm2k7tGGiDl+k
 dKWVVz2Zv/H2+E/FkwxeG29piVKxec4ESUJJ5LFGDqcGRGFbxxHuWlj5f/uKHlRX/778V+DfaW+
 459zEv4RkQi3RvR20tL8nuW3ttqmq+RabJLYP16S1DJztodLgUXu3tgRa0prEKdS0B6lBNVX5+F
 GV3BEH582vw2NcyJKfkLbRNzNXMmwbKWoi9JaakLQarMFHQ+kl0cgD35O4IIvej0iH1F7GZOf/9
 ls1sB4Dfv9yAdL3x5RB6OLpZahCofGWLPJUh1kppRRBiMIJbhK4vIkaQpRPmIN8MJQ5sjsVwR8C
 is1Kp1j+CFik/IgWFA2n4d3rgZcCptWyse5vVqw4ioGmYjeEhyxr6jll3LyZzjJ9SuN9TISljyh
 oISpjcTrkjb1hmMT1CUI8HZW9VNZBhT96YcWMZ6oGJDFAqb6FF1a64hHLbzRtFHKv1ngQ87xwZo
 Zb/+sC+acidUta9meNY9UHixp0zLICAVz2InNReaO96pS0rEKS8O2dEQiCN1zYR75wd1DFYWbIB
 NxpmoZYwruR0hO4ZBpE9dyToC2etyPgbhj4Ik=
X-Received: by 2002:a05:600c:6212:b0:4b0:a7aa:843 with SMTP id
 5b1f17b1804b1-4b0a7aa0a54mr195484895e9.25.1793790059545; 
 Wed, 04 Nov 2026 03:00:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c17ecdasm69939235e9.5.2026.11.04.03.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 03:00:59 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 11:00:57 +0000
To: Ralf Lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: d6770048b77488747e40f67058e821c6ea13337f
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 11:00:57 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <219ea22e1714d548e410c4d6fe6fb6845dfe205d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOYjr-0000000005z-1RaH
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2558325225810682810=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2558325225810682810==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o51JV8mvLSQ="; charset=UTF-8

--o51JV8mvLSQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Antonio Q=
uartulli has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux=
: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File src/openvp=
n/options=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/f4e=
647cf_06dfdc75?usp=3Demail :
PS2, Line 4468:     else if (streq(p[0], "rps-=
off") && !p[1])
> I intentionally left this outside the Linux ifdef because=
 the option asks openvpn not to enable RPS  [=E2=80=A6]
this is a good poin=
t=2E I see that also `--disable-dco` is always parsed (but the usage is hid=
den) when ENABLE_DCO is not compiled in=2E
I'd do the same then=2E



-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I97c55e211f9113d090808724=
ab43cb3c94099fb0
Gerrit-Change-Number: 1991
Gerrit-PatchSet: 2
Gerrit-Owner=
: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <anto=
nio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 11:0=
0:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-T=
o: Ralf Lici <ralf@mandelbit=2Ecom>
Comment-In-Reply-To: Antonio Quartulli =
<antonio@mandelbit=2Ecom>

--o51JV8mvLSQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Antonio Quartulli =
has posted comments on this change by Ralf Lici=2E</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1991/comment/f4e647cf_06dfdc75?usp=3Demail">Patch Set #2, Line 446=
8:</a> <code style=3D"font-family:monospace,monospace">    else if (streq(p=
[0], &quot;rps-off&quot;) &amp;&amp; !p[1])</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I intent=
ionally left this outside the Linux ifdef because the option asks openvpn n=
ot to enable RPS  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">this is a good point=2E I se=
e that also `--disable-dco` is always parsed (but the usage is hidden) when=
 ENABLE_DCO is not compiled in=2E<br>I&#39;d do the same then=2E</p></li></=
ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1991?usp=3Demail">change 1991</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1991?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099=
fb0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1991 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Wed, 04 Nov 2026 11:00:57 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Comment-In-Reply-To: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&=
gt; </div>

</body></html>
--o51JV8mvLSQ=--


--===============2558325225810682810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2558325225810682810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2558325225810682810==--

