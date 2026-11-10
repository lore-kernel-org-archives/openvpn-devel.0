Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145E606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GX2UmspI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ljLSkUHm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U4uHiwvB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RvCpH8SL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BPDGjZSFoxtJGdt+3YZqQggXiOiRwkwjiYCXsXjOrEg=; b=GX2UmspIe5nnwWPfl6MNLReQeg
	3BlwkZ31AYCrmLUVd7z26h/YFb52XOzUvIytTmAcTaeZ1S5SYOI1nd6efAi2ZcEQp4ypKJ7tlz1pD
	PJr08RC+K3VWWzFCbhOi+rPnogAB4uNJVjNoO0MfwrfdgCweMwnOHzCC9oyeA2L5j1AE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQnAh-000000005mM-0ObB;
	Tue, 10 Nov 2026 14:50:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQnAN-000000005l6-0uAN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:49:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BrfIPAJ+y9XQsxy5QYsF9vwndAi0JvHukuL7lxho8E8=; b=ljLSkUHmdz7xCzrFnWwNsjUAb8
 nUzWxs8bpnYTW6zGdFKipRCCwyNxa/+Cc5px9QqYcSxYAzKNgEQmFSUaKOoM9Y4Nc7Z/7/UQDI22C
 QlU+TfyhvAx8IpwiwJrNwdv0jOcJsEpQITohgGL/QcblVDhG2HFinzzm623MdVpLPlUU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BrfIPAJ+y9XQsxy5QYsF9vwndAi0JvHukuL7lxho8E8=; b=U4uHiwvB6qtQahjFu6kdpSnTCs
 b8urvjGwrL8L91lwpjuyAaWbQ/XRoW3ZlYM5w/c+rifFzRlCBBYRbBDQQACvUb6FUqrDOpKIdqw68
 ZJSeGTY/ap19WfX8NYHUNo0VLOj+cKRkqcVGeAEeiT/XWS5Jsw7oFWqbI1OGBiL/hYvI=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQnAF-000000000Hw-1xBu for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:49:37 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso935885f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 06:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794322169; x=1794926969; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BrfIPAJ+y9XQsxy5QYsF9vwndAi0JvHukuL7lxho8E8=;
 b=RvCpH8SLN5vS81y0ieqxUVXlyoRD8K/+ggjfOdPk5JTo3ah6QFI0i9/Ke6PFYuJwQg
 I6LYvIhbvhhaZw8ygdp0rAbfKuiWFHiSFOaaZoMJaXAE5sYr5JGKsmx8r5cbL4wf+YWt
 YL3wkh+9lgM1Jy3XyuImA6O+AHuM3tA0T4V3K0XARiZEyNrE6wG9//TL6ZD6v3srsF6i
 WJWkLpLDCw3Ln0/9BuUvESKxPuXEra1Jqx4/IG93NHL/V8h6X3GQqT7u5u3PcrONY/Jx
 u2WTw+mgJOmi8XSauKxkl2KrIMuHWfmpEjA0rBcHy70uqpJr6nSz7X66+9nNNusGWE/i
 Hh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794322169; x=1794926969;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BrfIPAJ+y9XQsxy5QYsF9vwndAi0JvHukuL7lxho8E8=;
 b=hObAjkzFWWVjAM9W3eVmh3nO8wPynSO3FPumzEJx4QDS7aS+bwB4xfjLX6zFYwJR/s
 0QhSX99ow1EoXnUy1eyq0TgaXZ2nrjH096gV+xmR/DLpN2hEtbTTLtkCFC9aHcNPuooN
 5BBa8PQ0//YIRCc2Sn4hBKsu9FAPouE+Z7O89vc1xKIuS6/tNnofb6R7APSENR6CTTuE
 W33EMoHQdxQAFU1Den7jxqP/n4nfjAuWA36Ww766gt3tS4T8H4Zgyu7o0u9iiMYxHZX0
 5HRFSlc2PV4/u7PqQyX6w4fmoxGwPCYUf3DAExhUWr15PgM72E4mTH1J4HK2jaeNtoLY
 72Nw==
X-Forwarded-Encrypted: i=1;
 AL+hErG64GqyzXJGeWqkUimcQtnrXOOvMhQBi0atB4aQNSDErN/kPkPpTqv+9z81GE+aGMexwqaZoay0XPTTzBBA@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8BUPnvAEWhVztsSL+jlgi2lWJukQxE24Iq7B65paDvNdIUvUw7
 ZJ04y6MluatZncuO6hGzSkExI5y5s3P6hEUFAQjzRVpP5h6bmH7XIPbIw+44NKN9H6F+XYZdWv1
 dFJsqg7qYmX4dMd3Mt7xLCSnn0ps9HEL6mgHuhSwXW/pJuTwKumzwj/Hnk7F5pxHyMj45mgjh54
 VbHBDH9A==
X-Gm-Gg: AYBFou27ZR0nVn1Vk8YV3sRoOy6A5S9JsGZklxQ/mTtUkct1Wz2Onsu1CKzJhDs0d14
 DGrBMia89n30+5S/bY+lveZ4vTwZt6+CSVQkhgTwKdubD0p1ptvHKt588aQTW9XEPja6xK31LcZ
 O5wyJLbo9UcX9uYAeXl8GiJ0LFiOD26LvR8KR/pFUyD9D2AE/Viw6urrep/jGoWNHi0kuL66LX6
 lBIu6r8MggT1/AtzgRH6gmTGZXy+2N0g1Rlomc6dTpdjBvrvUaEyrudwQQQ2tLtO8A+5BmR6VMV
 rEJZEKw6RwOAMlMWsOBm2Km+fmAB8ycVBu5KMfKruUaVEyb4SIltZHa7iPIyDjSRkOVO4HxjrU2
 BcQ5+X7uV8sPNYPfVZvmzf7zbRPvG333Ur4cJ4LrtyWViNjR3BKvh9uDHl+bEro4MhlFf63E/1i
 qk771c4xq8mngdyXIJuphxCKIHcPwXAJNShbmCDFxrFuj2RQ5u+LKBLD2gFUSGhRoqzhnEOJRE7
 2uVUMNfMo9XTGfghaVzsy5/5R/5StlK/Owolj54qGbm5IKAOZEfcG758fyiph9BUt2E8b4kQbK4
 R0gleRIDeFj7vsLNIWZ2GXgqAmnFVw4MoDP/XZIw1R59QINMNIz/BSgtfWLwzn2Ml7kJqpLd7Rx
 9Yu4ZVd7uPDFQmY14qmdqIVjaY2+imfWzAzHaZ1d/5Jm6avSKXUWP209rQ8u/t6pJ0yrL+Ffu2g
 mXaTwAn/g2mhLdp4g=
X-Received: by 2002:a05:6000:401f:b0:499:1c0d:4568 with SMTP id
 ffacd0b85a97d-4991c0d45b8mr2122675f8f.48.1794322168632; 
 Tue, 10 Nov 2026 06:49:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49836a9951csm5186143f8f.56.2026.11.10.06.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:49:28 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 14:49:27 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1c87faefd3adc2d95b5318437d097c3970a120d3
X-Gerrit-Change-Number: 2168
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2168?usp=email>
X-Gerrit-Commit: e15233110ff23b820b082a284b93503d13df1e53
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 14:49:27 +0000
In-Reply-To: <gerrit.1794321442000.I1c87faefd3adc2d95b5318437d097c3970a120d3@gerrit.openvpn.net>
References: <gerrit.1794321442000.I1c87faefd3adc2d95b5318437d097c3970a120d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzIxNDQyMDAwLkkxYzg3ZmFlZmQzYWRjMmQ5NWI1MzE4NDM3ZDA5N2MzOTcwYTEyMGQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <76de2954f04c5f586d8f4e441f24870e6edd95bb-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQnAF-000000000Hw-1xBu
Subject: [Openvpn-devel] [M] Change in openvpn[master]: console: Switch
 response_len to size_t
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6618750927680595388=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6618750927680595388==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1Xrlkr7C/U0="; charset=UTF-8

--1Xrlkr7C/U0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=3Demail )

Change=
 subject: console: Switch response_len to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c87faefd3adc2d95b5318437d=
097c3970a120d3
Gerrit-Change-Number: 2168
Gerrit-PatchSet: 1
Gerrit-Owner: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date:=
 Tue, 10 Nov 2026 14:49:27 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: =
Yes

--1Xrlkr7C/U0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2168?usp=
=3Demail">change 2168</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2168?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1c87faefd3adc2d95b5318437d097c3970a120d3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2168 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Tue, 10 Nov 2026 14:49:27 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--1Xrlkr7C/U0=--


--===============6618750927680595388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6618750927680595388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6618750927680595388==--

