Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E27C606A333
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=icSLd+7i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UQuktwBf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TTLbCvDn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JYREepym
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lZbMCWT4vUvmNv97W699lOL0bKD8HosgaCraUE1Kv0s=; b=icSLd+7i1j1ceHqr0PLwDb6EMz
	k6D+rQZdQkqygcnP+yQe3WBX3SpzITeIVHhvQHzBvvcXJp46bBcCqspPtWhiyiJ6ozgbNBV4h9FUo
	/nSLDoPIXzK+mGYi/lkubdYWUOR4mtRoVDQ98m9YmNin79/RpUmYWut5pHT5EcAlVg/k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWGI0-000000004Nd-0LB5;
	Wed, 25 Nov 2026 16:56:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWGHx-000000004NV-3TdR
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8tx0LKEmyn5vI3dyt1cPU3crQhrIO+e2rmhoFhCE03M=; b=UQuktwBf93iWq+Byv5n3GzlLVA
 SAnnkaQKFPAtTjNJu4whYNifAE3mHw0QtmoFOCvljbhR5RBUvPlRfrQKTUVV1IVl/Pdlw89AyVJ45
 t1GhDH61cDwIleF2a4ij5Dqbyu0tFCxbYoKeOMZxNjwjunKNZbBEi4U7T7KYvC7BNIx8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8tx0LKEmyn5vI3dyt1cPU3crQhrIO+e2rmhoFhCE03M=; b=TTLbCvDn3dyGag51aipfRjrfFm
 0j+lDuBBdRV0kxKHN5LliKf4uMyxqBqRcNV92hMpRgNSqFly6S/TkG+Hh8vhg0XhGJ0bspVSTCW8S
 vDHhhyqNUTwAMperWiTlv0Kp581/LdVGNlY30+6PVDTiw5+cD6Ge3TCzs1jz0K5QgDXE=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWGHw-0000000052C-1tcp for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:56:09 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4aa5833c263so5800808f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 08:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795625762; x=1796230562; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8tx0LKEmyn5vI3dyt1cPU3crQhrIO+e2rmhoFhCE03M=;
 b=JYREepymBy3460RhoP01S97PvDvP+cRyl/WSFC29XDht4lKa++x9s7X1ht4hP71AVq
 zZiYvDCGyVazunFAymUmU0dMOPU7JrJi9Qbng6E/W6iHJfUEsMr3IJlaFKZPnRhEBUlR
 PkXYUf/XWuhfw3aDCx2+qryBvkyDpkKixc7tNszdcMCazZ22zc3fXvejgXi8DdZtLxQo
 KkShlkEAWnopvQkZzwEqwNN975NtGXEuHORb+pC6jc8PEoBAajwMwrfPz0WVugZYbIPx
 ci7JmEuZhT9GjwAKq2no7FQFxYt/wUhKZ7NIXw16wtBhlLaS0ppaDA+yrdPxaYrYJaEZ
 8Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795625762; x=1796230562;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8tx0LKEmyn5vI3dyt1cPU3crQhrIO+e2rmhoFhCE03M=;
 b=df7OmFdBtsiQccQT70K+qSpw8J4vems1E1SmMuCv/+WWvVUPbWAeeIfiOFjIkRe7+s
 HnosrhMGiebj09ve4diIFo5maAiPiCN2J32IKoV7cJUbR7BSI2c076O/uh3wL7LFjCqW
 2r44bgnPWNoPjF4DZ6uzvXYtJkEvHTfAwbs8Lm41M6NmCKb1VkEkYpMxzo1yg+NW2f3+
 1zXmVDBsn9xL6uX5JWqUuE/bC54xDsHEXfa/Y3YRQs4KIQQnq03GKMZ5nTis1PoaeTI4
 kP5d0yz7If/Ww4wLrbrBqbChhYopRPvB1F/PPKQ3Dww0lVSekD/T4EfPe7TCFRjJlNF2
 6hQw==
X-Forwarded-Encrypted: i=1;
 AL+hErE8F1J0Ct4qnIBTG/odXMOcltpfMJ9o+567jjTs8pAekQlHkGS70x38oXiYJuA9VCBoJFOElUWLMsZMbhYk@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9pBW5IJNkNn8WeafhyFbjwgiZQfdW58qmpv6sWDfFSxdcm6bQe
 Ml1DT8aSTyxkEaFNK9lYs+hbFpuYjQZ8GhFKUaYKGW9VC+h2Q8K6NNkV3AdiYB6TwOrqy7t206F
 acIvuY1PsRS/U3Vx0wa6c+Uur0W7m7o25+/+hin1s4pHCH1NMmqwBgdliOmy/wAs54sId54vKuH
 tQ3W//LA==
X-Gm-Gg: AZFdTZeSMwfPqNKu+0V9NwI5t+UN8rPBI0ML5px681lj7L3sHmxkDBRpKutqOdfuU5/
 5qj2onR/8gZQc49BGPGr0Dm2kCesGNWeGbCSJF+XvukXdb96DlRfah3q0xiWSzkXG6nUpccU14y
 l9vSxWK07C2JYSORZNWpAO5I4ypegqp++hdsJnBXNlzxbvKGiwwUdikJyVQcE1KOX5ljBFm+/Hw
 vZfKF0S8QpT9C9Iv6tVRpPu0HBEKXqi1U2aBX/86ZytQji/hCga7msL0DrxamZdf7funBW3Ashq
 kQcAmbOsZ0b+gkjyfRa/+7A57kpxpZ9o6p1B5qdT9rorwxq89U8F38UvnYZ42J3CuFM/t3kVvgn
 niaBU+F2aBT01V0cCAxxhMruhqwBiNcqwXPhDLS7BcU1JAunfFYCKE+J1RB2PcWlOXpsL6ZizbY
 GS6ddnlTCMSCR8OyO+YYdlly+PKJbvZWEKstSCdsWJ7lYsS8HkUFpgTJ0dQ2BAavyb2ZE8z9Qpl
 daCYGw15Yxl30OThr3hVmcu+ps+9lxI+O36VocKXkMIm7SSmEZ1W68wX6FzW/doWXHFxm9ZU5mq
 anYxFN9u/YBnDRrEHoXtKQdJ9cOnwcmoOCxq0ZrcID1fVrhaL/1QwAHfD5ViBKevPqkPwyGYut1
 9ANoWZU4/z41eRRpKr8CDWR6jpKkhFpPcjmRtkKwmuELXK6dYPvHBtYaBDQmsycioGrfr9F6+oF
 S1v8ysSvYNbOWT/nQ=
X-Received: by 2002:a05:600c:34c9:b0:4a3:5d64:df91 with SMTP id
 5b1f17b1804b1-4bb88810d28mr407621885e9.18.1795625760718; 
 Wed, 25 Nov 2026 08:56:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm834116385e9.14.2026.11.25.08.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 08:56:00 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 16:55:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b
X-Gerrit-Change-Number: 2346
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2346?usp=email>
X-Gerrit-Commit: 347dc16f2c3b30ed94bf0c75562ea6276bf694fa
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 16:55:59 +0000
In-Reply-To: <gerrit.1795624133000.I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b@gerrit.openvpn.net>
References: <gerrit.1795624133000.I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjI0MTMzMDAwLkkxZTg0NTI1MGI2ZTYwNmZmYjQ5ZmE1ZmUxYmZkMDM0YmU3ZWFhZjJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1ec6915eaae630ff0f4e06ab6f78f705d6b39ee2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWGHw-0000000052C-1tcp
Subject: [Openvpn-devel] [L] Change in openvpn[master]: push: check INFO_PRE
 length before sending AUTH_PENDING
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
Content-Type: multipart/mixed; boundary="===============1705518529419201810=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1705518529419201810==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fhZI7GkMjNM="; charset=UTF-8

--fhZI7GkMjNM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail )

Cha=
nge subject: push: check INFO_PRE length before sending AUTH_PENDING
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 c=
omment)

File tests/unit_tests/openvpn/test_push=2Ec:

https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2346/comment/af252e63_b9efcf22?usp=3Demail :
PS1, Li=
ne 58: #ifdef ENABLE_MANAGEMENT
> Why can't this use mock_management=2E [=
=E2=80=A6]
It can=2E The management, management_auth_failure() and manageme=
nt_set_state() stubs duplicate it; will link mock_management=2Ec in the nex=
t patch set=2E management_notify*(), management_notify_client_cr_response()=
 and ssl_put_auth_challenge() aren't in it, so those stay local (or I can m=
ove them into mock_management=2Ec if you prefer)=2E



-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2=
b
Gerrit-Change-Number: 2346
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 25 Nov 2=
026 16:55:59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In=
-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--fhZI7GkMjNM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn=
/test_push=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346/comment/af252e63_b9efcf=
22?usp=3Demail">Patch Set #1, Line 58:</a> <code style=3D"font-family:monos=
pace,monospace">#ifdef ENABLE_MANAGEMENT</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why can&#39;=
t this use mock_management=2E [=E2=80=A6]</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">It can=2E The ma=
nagement, management_auth_failure() and management_set_state() stubs duplic=
ate it; will link mock_management=2Ec in the next patch set=2E management_n=
otify*(), management_notify_client_cr_response() and ssl_put_auth_challenge=
() aren&#39;t in it, so those stay local (or I can move them into mock_mana=
gement=2Ec if you prefer)=2E</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail">change 2=
346</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2346 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Wed, 25 Nov 2026 16:55:59 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--fhZI7GkMjNM=--


--===============1705518529419201810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1705518529419201810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1705518529419201810==--

