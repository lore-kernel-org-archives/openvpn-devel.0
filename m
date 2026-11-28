Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406F606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RylAqVju;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eSFNR+KH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DSV83nWb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c4mibayy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nUySXn1glsOaqe2yVAeg0ee/WdhbsJL1abQ5NMXNctk=; b=RylAqVjuZXRSmjJ8BChR33v0o2
	UZuh9xrZ0E4XQLwqRIBY3MdUR0/vnB2W7G8PU7iJYQcO8HDWCsvGAFmty45ERlxZWL3lL8fM8XiMv
	yf1PANbFupF4r3nkfnNB2OSyEK5WewOLwTYg5cC08bJmYBT4fUYTKQCjYmLyuOx+fgkg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xXFlo-0000000011x-2vyY;
	Sat, 28 Nov 2026 10:35:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xXFln-00000000116-3654
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 10:35:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+2UcEpv4XxMHZY4/C6wZjfeMy6RMgJql89UjAL1XcEc=; b=eSFNR+KHoWu9NxpjeLsiEKYeF9
 URltRS0rgeZl1c9qPYlzAPW18hv6gTalM1KfYQOJzZkRArRtrNh646mzS3rCrYW7/pDEC0TASrN6y
 gvNxuXV94liDAUkucxVbxIKLlmy9JJQNfngd1QSfv0tAuhF8oZ8BIqzlYrQ2N49K+m84=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+2UcEpv4XxMHZY4/C6wZjfeMy6RMgJql89UjAL1XcEc=; b=DSV83nWbFoq6tKoerdmkCPJGQL
 6iN1gDHZWiBCDuhJYt95HAV9x6dR8iPVhzRze42w3FiMgzKy2n9rxfTwdEKWALfjDRWtHIcJmSQoE
 QGkl6gI+8TyMXdHfx/fsHzGawaQFiUXD6ts3KXxmGjzwmC5XZ5H2UepXniP+IrlUleT0=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xXFll-000000003eZ-1xiX for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 10:35:03 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4a9be758734so5583924f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 28 Nov 2026 02:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795862095; x=1796466895; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+2UcEpv4XxMHZY4/C6wZjfeMy6RMgJql89UjAL1XcEc=;
 b=c4mibayy7WKR4ChBJSQOlOD54n9pzTA6IaXqUy0MomLkkzV0UCPYcE2vJMJAmjlx6Q
 c4QPECs/aGAF4w+UslO8w2mOryLmU2S+CuDRIRhAQULEvf0XdP0R8kc4i8otpf+oIsKN
 tOUB3nCgGwAKeWN3qIvl34Qd3U5fGai+Tlw6yqGx1IA/fWdgi0p7ykpC+B60xh9RZ6gn
 Pk8X8vgLj406PKbd16XMODMYcIAQp5XMpbhgBWfKD+YTYE5wPmodXkBOsMLMhmBF+59g
 /RpCxhqdbA5SmbnKp50naKDOC0xMqbdtyOTUIkydum+s3J8h63ryZVoHsT9R8ohcgyu7
 gUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795862095; x=1796466895;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+2UcEpv4XxMHZY4/C6wZjfeMy6RMgJql89UjAL1XcEc=;
 b=PpIQvdN/c5rRcTcPB6URp10HdSgj9SKPfhtc/j/TvjtwuyG1+l27YjS7S+9wTeYt33
 rHf/hYOu/tx7JcHWycH8rAs4KS3/eXnWuW4714Zqc714nmTdk1F+skPHJH6VMJlQpI8e
 ZFrSM07v3hn0Uvkzes3rhaY5BY+VwbfcCAC24Sx6naowt0UnlYdpQw6ixd5ho7MthyDi
 yCO4chxGUlxpyrRoZockqMzVpeaLtYEsYGhQtq4VE2l/6qbm3KpFjw3bWlAUVSPl6lJ/
 UIAXPZtWK/Lqoiop31NTMkERgCE0LArsxzDBxrVwfZHr9rFWQInfz7w1sEGJ1fkHWCNa
 hyUQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHHNxlZK4PqVFivn4J9xld2Nr9X/B0s70N6WhDXgnKOHic9gb4pQ5JFzydDK7Uq9lG77H4DPjI4c3VoKUbn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+L93/OGNt3yijEmnWbAMF0/zi9UHOyA09hwxH0HmL9mwsQ7pE4
 P+tjhHvHvpA/9lcJxsWi2PjYqcrqQFwGc8hNYyE6PRCpjldh1AdJjlSSfk1Gd1VmkQlM0CigWKr
 2HQggQEUTy+4X2FpNYOjeJTohh8hTPnAev/fkCCaxvUYL9HRsl11Q7v7a9QLt89rk00ilM2yFfS
 ki+vwYcQ==
X-Gm-Gg: AZFdTZdERC1CcbKdHvRyzR8Q6juKAvcFtX9579xiS7+hyxX1j1xo9SYpbnzNb+wBDy2
 mVRDHRVfri7r+PkFgrFmFpmcrUbaEAr6nKa+P7P7a6yAUx+7d7oNE+Qv3NLZrrfylk55IAQ9I/1
 kNp/5sbJm/sqrI73PkBeol1KeBsPCxSI4LWzleqhMFR1j3bQfzSCIjH+QZm9LXVeY2T55FLLfgr
 CQGTMFBWaXes2+gGWAhEIh0Bs48QxVNbm/GtEAPiCpLbCBK/xwnH+mQbnurj7RzHue2UdPMvwV+
 VETebxzuViYxFA0kqU0zUimFWrsVxhPgkXy5OZcgPNar5/36c8SuoZxygHoU5Z6q+XK+L3D67zX
 o2oKIF1lIGKoTTWYAWWwi63q28GtYdwshWzF4KHZtxLlVpUx+Bp/K9gQBWYQIe3Y8w1z887vvVm
 QSQ/gRC/03yBYyCgpZyP5OFWHCWdk6n0xkecBr5pWz36eRZP5+J/XtAbLwI2WfYD/4V/b1IF32s
 fN5XQ7IKgs/RE4hYV4LhHDRjjqCap1pb1dwQCmYKOp27kKrmHMY+o05Dyyfin3wEvJpAKb2a9+q
 0XKuIuGYrA9G4Var+krS0YwO9vyUGVAuOGASlAmld2kRSPluzEu5Orwz92nUiXH88ygYOAtfW3P
 ILU1hTbuF74wc6go1goazIsrxhVAtAF9voryw0kH1OUC4UzH6Ltk+QLRfES3GWnxRR7ip8dY19c
 gtAQzHJzEhb4egOV4=
X-Received: by 2002:a05:6000:2c13:b0:491:fd47:5df3 with SMTP id
 ffacd0b85a97d-4abab02d216mr52016506f8f.7.1795862094512; 
 Sat, 28 Nov 2026 02:34:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b3415763f7sm27744316f8f.9.2026.11.28.02.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 02:34:54 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 10:34:52 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
X-Gerrit-Change-Number: 2349
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2349?usp=email>
X-Gerrit-Commit: b6bc63f13a9294dfbd40fef75b558999a7627a44
X-Gerrit-Comment-Date: Sat, 28 Nov 2026 10:34:52 +0000
In-Reply-To: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
References: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkk1ODQ3ZDYwMmEwMjQwNDRkOTEwOWY1MjFkZTc4ODVkNTVkMjhhOTY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <99ee452ce7b8746f99f354eb71a17911fd7cc486-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xXFll-000000003eZ-1xiX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: restrict dns
 var names and values in the updown runner
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, abcderyscreenprinting@gmail.com,
 heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Deri Haerudi <abcderyscreenprinting@gmail.com>
Content-Type: multipart/mixed; boundary="===============0556647324202415750=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0556647324202415750==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7easP082V3U="; charset=UTF-8

--7easP082V3U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail )

Change subject: dns:=
 restrict dns var names and values in the updown runner
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

Fil=
e src/openvpn/dns=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349/com=
ment/7b1c9a81_e2539805?usp=3Demail :
PS4, Line 697: dns_var_dev_valid(const=
 char *value, size_t size)
> Should we also reject a leading `=2E` (which w=
ould cover `"=2E=2E [=E2=80=A6]
On second thought checking for `=2E` should=
n't matter because the rest of the pipeline should reject it later even if =
it escapes here=2E So that is optional here=2E



-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
Ger=
rit-Change-Number: 2349
Gerrit-PatchSet: 4
Gerrit-Owner: Heiko Hund <heiko@=
ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
G=
errit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Heik=
o Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 28 Nov 2026 10:34:52 +0000=

Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>

--7easP082V3U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail">View Change</a><=
/p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/dns=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2349/comment/7b1c9a81_e2539805?usp=3Demail">Patch Set #4, Line =
697:</a> <code style=3D"font-family:monospace,monospace">dns_var_dev_valid(=
const char *value, size_t size)</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should we also reject=
 a leading `=2E` (which would cover `&quot;=2E=2E [=E2=80=A6]</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">On second thought checking for `=2E` shouldn&#39;t matter because the r=
est of the pipeline should reject it later even if it escapes here=2E So th=
at is optional here=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail">change 2349</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I584=
7d602a024044d9109f521de7885d55d28a968 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2349 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heik=
o@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Deri Haerudi &lt;abcderyscreenprinting@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Heiko Hund &lt;heiko=
@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Sat, 28 Nov 2026 10:34:52 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Co=
mment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>

</body></html>
--7easP082V3U=--


--===============0556647324202415750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0556647324202415750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0556647324202415750==--

