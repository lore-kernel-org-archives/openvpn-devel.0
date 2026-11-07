Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50900606A332
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JBvhtI2Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=O8UxHgRu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KxUftxq5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MYKMYkvC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nW1wTABH2lrBBFH3vruR8KORPDOUQNjk7K3R8KI7LBI=; b=JBvhtI2ZkSORIc20rjVGnFdSLj
	xHcqj/ORkAAUaNtbBva+vWjDcueLsFyoPo312Vaom+VG6Oq8ujEOKUX66xcgmL6JbihD7oZJP7RnW
	v7Jo92Nh+eh+q8gv63kkdyf9r7ly2eABp1VwuM+UaukWlGqbeAG6izzJdXNiWeUwd7mY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPiKU-000000006aA-2B4I;
	Sat, 07 Nov 2026 15:27:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPiKT-000000006a1-2fUJ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 15:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nRCeaOaH0R+SNTTh3LkfyG2smadIHUrpbpmMsq8nJDs=; b=O8UxHgRutl7S0C42hefIeLhwtB
 Ev8Ftstspdosgb+XHt3rxDRPAlL+DLrehzA5NqTGHTE1vIj8YBG4vM2X5FCA3bPXLQc1mq2pbm14R
 nnsSCuLhVufRkywvZ8S5iFi9MVWzWnGt82TOdpMLStf0s1xew7i4uQJpBFK/1gWx2c7w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nRCeaOaH0R+SNTTh3LkfyG2smadIHUrpbpmMsq8nJDs=; b=KxUftxq5KBlS+Lc0wHZWNgB8oE
 wKDdQZL17OGgFNNqeHmiKtogmeTaqRH47glqmINXKxygXwAtfq3aw3LCZ8DeMaJWlkISCq2m+YkR0
 Ug3IvfeqK3j7FBloLvRjTpeVGFjy8IVNWSq9HcUob3FEd+M5cFIoIIn6UWR/hzmoEitQ=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPiKS-000000004NK-0fSr for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 15:27:41 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so929173f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794065253; x=1794670053; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nRCeaOaH0R+SNTTh3LkfyG2smadIHUrpbpmMsq8nJDs=;
 b=MYKMYkvCPa0BV84fn7SZ93Fpd33bDa2giFpDMNLPRAmBlRjkZWlZlw2O3ujmA0Q2nr
 vpjJsf+WsHk7QIuTmkhUMKW5m2zqa5Uo3XEpNmqYqxY+aW3D4/XQD2gE5QFkMTV7mPO0
 oMXNhf0D0w00EldJyyW2e/9vp24Ihdqf8iYz3RO37nr0aubCXZYbGT3U/Ws8vq3OO9y7
 U8OvfviaCiI+aOyZKnd3NUMkHSl/0Mw3iHxkTZ4hjRiyqj7RNlmOywM7bw5ym2vO6OCb
 kEjNXosoLEA2bEnc/JW7giFQheObAGrKXzUua0u/Z1dsj1WNBbHFSO2xxaHNniAxkDdI
 ErcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794065253; x=1794670053;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nRCeaOaH0R+SNTTh3LkfyG2smadIHUrpbpmMsq8nJDs=;
 b=cXdWIPd4nuwbvXwzDgMiDXxUGOEWj+mquR80fxIOEArkWhR7XxoRw7Uaymsk0QIEha
 ZpzpNDriVIQkY/JdetjtC/5YTm9PCQ+7O+Qi0utmx+xKPMINzBmPmW5wukY/SNvhtoYL
 aYM8W/CoYxuifFr1SSr81dhRmnGiCk3ml+yvMtrVVijhYr0yc8OQNRhnmVMu6D5yD8+s
 TwpD9GDmV4v98PyigSXIJh6l/dT5JQK6gg7rJg2b7TRHeLMlLOa0L6a28t6X1YM/Xxbj
 z50d+T/P4tIlhVFOrzqXiNy0qAKXJE9EDzjnNcv9T+fN803J3LgKNyGG2YKDf67qBN9o
 L9dQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEy2GtNgy1/N3vepscBxfbODacJb8ij02XprGtEa3piZCT2S9SlyU6PVVndmbniyukXc3cucpWXsfkhePXa@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/ZkhV5gMM6+IeC8TWP4sZ6F9XrYEN/nAhlocqCH8l+5p099uV8
 q2T2P0L2c5cvuzisK8TdTYnVtPQpDrygBVMzORMymm4I6MQaCVfpTvDTkWKciKffizZsvEv/thc
 MH8RQ8I4CZ5KqAwsarHtaMmh59BKVRucQKzKEPwPdlSCNjhfXBPwiv3UHFcJk7/SzzXm6tAzofV
 ++TZ+d/w==
X-Gm-Gg: AYBFou09xLq4ZaeOWAbOZe4kl3idg6BGUIUsRWljiFW+E2fjrfMGPqHfdtOiN7fs82R
 g6dyKYNIvEn2cR65IYOtPJ7+GutGUmOs+E+XQcXeerzYP4jQQ4J+QZAK+Rxu2q9atbVs3DWSVcf
 X6/wISJr0kBNydgDx9LylUCDJuy5F5ji5MooR808+R3PQL8sxOGoxHAoHA9J8PqlGdEbJbVVTA/
 KjHWBz1AGb8qFoXMlGfuuzkqQ4gMT9OaCP2Is+Wk95kM6xh0ym13aqK98alLF1H31nMdu43rgrK
 U0SEr6oJZF3ATx+bMvEHLM8/Gr033cKYRkYCgxxsacyPPUkC3rDk/nnNjT/nt13TIulrE2O/PA5
 azhg9zTBx0jwxxT7XgqUwc6g/XDiF1Y593tQFVNFQnDxmSQqiuw7fTAyW7ogJNgSkGcO2L9hVXg
 Q68Jj1wDkKFfJQ/AsL/Xl0enP9yQ49vfTAwyBM7yidzllITk5pWoOGJswpkSc9EzkqtIXNiQQMG
 oNRtBoRpncnzdPsOjEBrLLPqk9PsOPTf/eHIuVRKiOiX9miRhdTHt0PLWz59PLGBsHfEdEKQIgF
 qLVGuYZ3rUl7MnxouyQsZl3X6lUbBpbBIlyfw5wzsNF7kZ0I+5lyhi1QrG+nQL8zg17dgpqp9tz
 0TRnBE2CjdfWPOEWXcox3V7kzdIdmo7Ua7ZZYWxBDb3SebAkFFUZu5ucIU9LrV6T5EBL8KFxVBt
 ZqN41FEapRCXknF4l+NTz8xBVOxBKxSOXOHbc=
X-Received: by 2002:a5d:5d08:0:b0:48d:fdd0:6ce8 with SMTP id
 ffacd0b85a97d-49272c2779dmr13960363f8f.3.1794065253448; 
 Sat, 07 Nov 2026 07:27:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d723320csm9392949f8f.26.2026.11.07.07.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 07:27:33 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 15:27:32 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d545f0a6de5ab795a0c80447002f5cb54b48b32
X-Gerrit-Change-Number: 2151
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2151?usp=email>
X-Gerrit-Commit: c0f3f3916c8909732e773f4e17f46e2ad88cbf4e
In-Reply-To: <gerrit.1794064436000.I1d545f0a6de5ab795a0c80447002f5cb54b48b32@gerrit.openvpn.net>
References: <gerrit.1794064436000.I1d545f0a6de5ab795a0c80447002f5cb54b48b32@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY0NDM2MDAwLkkxZDU0NWYwYTZkZTVhYjc5NWEwYzgwNDQ3MDAyZjVjYjU0YjQ4YjMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d31a14ae4e30a7eb9544b292ecf21f247ed378bf-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPiKS-000000004NK-0fSr
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: merge the
 FreeBSD and DragonFly IPv4 route branches
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0215772692763922686=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0215772692763922686==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZzrDKvrF9J8="; charset=UTF-8

--ZzrDKvrF9J8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

R=C4=83zvan Cojocaru has abandoned this change=2E ( https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2151?usp=3Demail )

Change subject: route: merge the Fr=
eeBSD and DragonFly IPv4 route branches
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Abandoned
-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: abandon
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I1d545f0a6de5ab795a0c80447002f5cb54b48b32
Gerrit-Chan=
ge-Number: 2151
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ZzrDKvrF9J8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>R=C4=83zvan Cojoc=
aru <strong>abandoned</strong> this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail">View Change</a></p><div st=
yle=3D"white-space:pre-wrap">Abandoned</div><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail">change 2151</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: abandon </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d545=
f0a6de5ab795a0c80447002f5cb54b48b32 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2151 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--ZzrDKvrF9J8=--


--===============0215772692763922686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0215772692763922686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0215772692763922686==--

