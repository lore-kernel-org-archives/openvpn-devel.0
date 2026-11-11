Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087DA606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DlGmxvdg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AP2RLaoV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TCkST46j;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QgjL5YN/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=w/Sr/qL/SRZgqgYzJuUcYBrjjXlTTUf8alCkQkI9K3o=; b=DlGmxvdgrl0CCEuxl/0nAsn0kL
	HkjiakVDwFNInSyPCCx0JS7r5C62M21NIUd3bhHpAGvlZBdIPoORRK5gZY31QZ6pEZ6NaBfLTEajm
	KJHdhhpctZZH1ac+14/KZIPkHj4vYFMUNw7+IFCjqy3wQC5HlTAP6XQ1zbQXMQS7Nr+w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR6NV-000000007BK-3Rz7;
	Wed, 11 Nov 2026 11:20:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR6NV-000000007BD-0w59
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:20:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6LwV+PzLitqqW9nBgZdmPhi1MG5mPdwcjXhZv5kVu6c=; b=AP2RLaoVrAbcxl3qaTexSvKHao
 TPZd8QpZvL3s0XuJBNgM3abtJmbdn1J5iNcVg9sr6CJBPJBB9FBQowY3OTnaqFyjKXKvmFSq7+RXn
 QkA9U3GfE6aMhEWrgZabFTvJgsMS9TVdJfOT1Sa+kSAfGiXvQBx4AhwdmEK0xhIlbXaA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6LwV+PzLitqqW9nBgZdmPhi1MG5mPdwcjXhZv5kVu6c=; b=TCkST46jepp6gWkROh8LNBPRVl
 4E44FMe1gTcYGnBOzLeURbKxW8rVE2Ry6jeSgyCtBvIluvr+Cx5IVqQtZRtipr4W3mRX1IBYm/H7Y
 ZYVTa1xIztayn0o/x9Hh4NdkQPOS79+50h1/6NgC1Sjo0o5OeOBIO6aJbxP6epkKaMWo=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR6NS-000000005kH-2Y2J for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:20:33 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so38717655e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 03:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794396024; x=1795000824; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6LwV+PzLitqqW9nBgZdmPhi1MG5mPdwcjXhZv5kVu6c=;
 b=QgjL5YN/aAvhWd96Rf2XAxidj0fqsAeUhu8f6fJ/OpSq4KZOW/sf8Hlz4VuzqNA7pw
 Zd5KrcbiJTICTmxzzhMoXkV6xl8vDnsxNm26kaQd72eSBzLNeAEltsM4MZFQ0X6kJC4x
 0TjJMJ/+0fy034Wr1oFg5cAiP+wXpd5L8I5ThnECt1PnL9pqbC01ifQFd4vljxss/sT6
 uYk8CO+J8jMeHHIhRLJQV5hQpJ3FYWgGkCsUCAwVIvr8fT4ZLxu9kfrG/K/dHL9dqurr
 M83cCvs/aP7VSxmn1qmfygWZaxUb8WIzBc1l+dWgufudfeORMCOuXJWcEpcaCkOQv6dD
 zGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794396024; x=1795000824;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6LwV+PzLitqqW9nBgZdmPhi1MG5mPdwcjXhZv5kVu6c=;
 b=xvi/VDuOdSQffE42EFgHh8EgRKg0iJ3yIhs9bUYpRoIPlU2OH0tSYe1+K92a6O7MFX
 M8atcTfGQwbeISnJt1BCiv1n3QiHq1ZtL9lT+XKDcTRy308tkDp77bTzOgTDPgLDVU0G
 GZe6FBIoSe7NONCS3qsr/EQkmADpRZM0SogNGFbrXJh7KbAMz3rGyubdDpIfghZGcW+C
 KPaLZ5YCsBp6a0NdKifKBGJhiL4e5UehI5nalxpp4g0EvveAn2i4Tk7K+Hh1uK54h92w
 6FhLbbLuOV5Gh5yxhC2rY7QtCm3XUQpHcP+z8He0LS9B1czCQaCr7wbs2qE1lNtxiTG6
 sqUA==
X-Forwarded-Encrypted: i=1;
 AL+hErFRuG48qLvkgn538pmqSOD730/uAZloLGSyFcByfE5ayZ5mbJpBB5gGYKDx1Hev2wjZl19S7z/EuXEt4ZB/@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+aXzhhO9wDU0OsRtQChuoF/xKpt9/KIvcgszURAZ0X+Sk0JIJE
 c9Iw+W+L16hKd3r23r30Tn/Kg+Sw+IvzMB6/BabC6zosCl91XFAg7rv0jZDBA+3nWxBLBf9BvDn
 FGzAuxxSOyAqQt6ixuk8l528pKzNdJMzf1CxIVt7zzqDVuRuHWjGjOP1I29iQqi0+YJbb
X-Gm-Gg: AYBFou1R2uFfxDZp7WevPx1XT3OwbzqaI9B3qoZnFaqqamiWookKxRVmkOJXQ1KhyLf
 6Klf0YcclRJ5QqVjsKAdWJxX6AH5R/Y+Ml9opmkzR3eNkTuNe3S2gkAtAVNcAacl2i58+e9KNth
 YKpvrDDOqwN4yU4HffJU3ksMOnxqJ5x+WAMNAkMvlu83hJbpoCiWI5Ng5efOfRSoqjuY4M+ex1p
 bxLx3Ka27y350HfmWdHvn+IC2l67YtA5jkvA+C2Db7E7KCGE28q8VgPzSPixD4+h9gi1Wf1cKem
 jPgworQtDNy+6WKnCXwCsH9wMi7q2qqLvlJ5nlZVUh8uvxk0L+NnT0+Zmzw9WERSTZK2PuQZmb7
 FJh30ocFdvwnqEYh0Ixbdf+HgDHlbbb7i5/nuuvadaQmtrjxAmV/FI0ZW6MJqrVA+xojFHWGK5l
 WgBTl9whm33qyw2WkBbVfV8fxoz7R8yaSVmx+UicObM7NelP98BiO16Zm+0+H2YNO2FQapqROk6
 kA2p2lTguE9bfD93pARKP0LNYjCVayqsWvfNpLGje/C2bUwE/wMDs9LKw2+VLuRRcMzZVRJckF6
 LhEwTwkq3hWaWxK/uzyx6h7QiAtVeXLeHQFLUIHpd/hg+Cpn+Nhc4I+C5QKIXKIv7kzk2CwT45K
 HmMpRT3JhIrprBbefuetfk3MJkaZjZWrH7NDmE3TPlw7WMo07CYkxyviGR/tNBLWQFe6jHOUJAz
 1zjMYi2/WM7coJLcE=
X-Received: by 2002:a05:600c:840e:b0:4b0:c1ae:829 with SMTP id
 5b1f17b1804b1-4ba093a9516mr38510665e9.30.1794396023899; 
 Wed, 11 Nov 2026 03:20:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe2c5asm204380805e9.5.2026.11.11.03.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 03:20:23 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 11:20:20 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: 5d019414bc457a8c6d3e9d4bffeb2fe456a44ec0
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 11:20:20 +0000
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f25a2b927bab82073d1d4cfac6853b1180e07b57-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR6NS-000000005kH-2Y2J
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: pass a
 lone config file to openvpn with --config
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
Content-Type: multipart/mixed; boundary="===============2952949327537835061=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2952949327537835061==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9xp7a9ofWX8="; charset=UTF-8

--9xp7a9ofWX8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail )

Cha=
nge subject: openvpnserv: pass a lone config file to openvpn with --config
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2159?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I57=
469ca50c551ad475510690ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerrit-Pa=
tchSet: 4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Wed, 11 Nov 2026 11:20:20 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--9xp7a9ofWX8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?=
usp=3Demail">change 2159</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2159?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2159 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 4 </div>
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
isplay:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 11:20:20 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--9xp7a9ofWX8=--


--===============2952949327537835061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2952949327537835061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2952949327537835061==--

