Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9230ECD6E41
	for <openvpn-devel@archiver.kernel.org>; Wed, 27 May 2026 15:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VLsFcZnEaN9nmOAq0lwHJn2G2pO5YDNqKZfFIuS5cE4=; b=IFFK0h8tj1cTPmeTEbTUY8MLh6
	wrVYN0MfZs0a4Z9/8G2QmPmvt5JDCJDXqsrSVfvvO3hwht/3D84aInog1UhwDjdEtMutvcm39Xgvk
	BMdNJWJcaJ0t14Yxq/wH29Lj+3IpFKNd5Y4pKPQRIVHVrlAgA7hYcy5DXxPvauEaGXA0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSG0o-0001DV-Nq;
	Wed, 27 May 2026 15:17:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wSG0i-0001Cs-5S
 for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 15:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OP5B7BnDEpMt3F3tuF46bR6P1d3cil4doVp6nCJaW8E=; b=EKKHN9KICD+8PQwID5XXs4MrjS
 37Sr/7gj9+QQsZKwrSt49+hz+JqYwdTr6YbTxlth0+SHrMXxM7IVfbBQxw/1XmUOv1fVEIFaMzZeI
 A8k6p6iuP27Ye0rUF4HSmswokg3655tLbp729+TWezeP8bR2EQbRhtj6YoWxKCuD3dCA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OP5B7BnDEpMt3F3tuF46bR6P1d3cil4doVp6nCJaW8E=; b=J
 I6F9EEfkUGBqUCrAOmKMDNJ8eo8g0NZVr1lu1P22PGLmt6nO+WAMOGOcUjhP0kj64yM6hrLnJi/sY
 W4mwKwLA7cOX0HdWQNj7c59TvViD0k9Cv4Iegiz2YPa2V1LvCHS3NdgJLCldzRhzhGeJjtBtU8ant
 p4guWhgxKQJIrljY=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wSG0f-0002KN-QV for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 15:17:32 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso6988794f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 27 May 2026 08:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779895039; x=1780499839; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OP5B7BnDEpMt3F3tuF46bR6P1d3cil4doVp6nCJaW8E=;
 b=CkZk255MLoQhRS5i86UI9Lm9Gzjf5I2rPeC0QQBEPdUmYwdufu9RBsXc05MgTC6COZ
 TZ+TWrZsMOyvQZWbO9L9yUhWmfj/EUqgqLUEhy2PZUgL42vf1EvulubblSDMVjY7X1dy
 SDOX1qw6zPmwsrW2bSWDTMLPvvKgvH2UL8nGZAyohQLSfkmB0LmtwU7MxyTBbFgCTafa
 w693kS06R2Wgcl7vSwe1lBgS7BmpN/MFxSpttspaEuTL4RUvgVzbZL8tYD3ZnJSBkpWV
 a2RuVwdlgoomUTGmGNIFbNZ4YRlIzwEBV1oIlA/Na6ppJ45cbwy2mWNBT4bKXE+CLmio
 TX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779895039; x=1780499839;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OP5B7BnDEpMt3F3tuF46bR6P1d3cil4doVp6nCJaW8E=;
 b=LXkvlz9cd4XSciv3T4rJFLWV9wIXXqdJVDo1ohb6KDzSQ1YljFhTwFpmwzAUXap2vY
 Hdr7S6AjWHDBD9EArEg15e0kxtvvg73nwya5q/rbKBJoKcCeDpGZ4MOSl5zw/5HKNjnX
 A6VHU57VN/vBUF/eFh75TXRcSPYheb8a9I6dawB8FbnEl2ZqzHZX5OQEbLqQlbNL5ZWR
 nT5lHRLBS1TFTjwXjIhxqVyF5Iu0xn3q9W5qCqMqanWU8LK7r/axZ8rPxXedrK7m13EM
 GDQnVYNgEpMBXAEa8kQMTyuZEFkAoV1+7+j06o7/zaWBYFunqJjFE9tXN9Din9nrVd4V
 /XLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ayhco1EdBvTYOF5vlm+zRAHAYg6Fnsi4JGGCfQDt2XyEeqRh3UIyPGsw3s4FwTws6SVIxDPCWTdvWpLYL@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxY9CexRq5qBW/NwzyX1StttI1fqRI1mLX3UhPUqUlK3wrzK30r
 mbQD+QiHPKCHDWsqKzWISqDlcVWS32X3LopQUINfYsIicXQyB4z1LuDkWZvvDHZincfBSMGsnv6
 EVoGtLQuP25Sfzl53Px5idErTJI2U1mMmBmWGWISMD3gXqiK3MMqb9r8aX/elmcRPOpnYwlrgFG
 KBRanVBw==
X-Gm-Gg: Acq92OEhxZKhdsW2UxXr3f3O1DkeaduB3ZPPynTqGsJcwmHnzEDdK8Qh4w52oQuh/Zm
 kx3RyxaCcnt2b9cGbn1hMKJ2oeqnRqzGB/27FDY8VFGgqAhUviNB6ljjLr7lYTyAfFKZsz3uMrN
 7buok7dMechA8I3qSUqmxzFbYzHlrbu/2s/Khv5YY9WULMrt+H6NDBLx835Y+Iv2G3s9ofo36ln
 nkyN7X+QdvefUepsyonJBEwSvvw3bRw/yLUEtLheaz0HU5jqscpi6orpy1WI0/8ORbhhwW4ecHe
 N5AnJma7k5DWayWdhp3gkqklOylkRPg9jaJPzdmUS7FfsgeelUXjpNLyOLf9F8AWrB8tr7CCdCz
 WaBDOovpPo2IOw4UFm7KbHcyEGsuCxH0+RYHWMrrwIC/Mz9oYNAFHAvpdqwM8cxACj3lvPoMd1C
 5WZlqnhvkG3ui8VA0myQQgy1Iz/qj4uyJiKgRoYbJfQ4h8PO3JJ+oqqnMKU46zvsQRx7WjWC9Ie
 uUqIPXlYUh3WIn5gScnVow/zT/Mk/vKFoNj2f+dyAHpND5e6/DKjQ4QmzPTZ6ZvCSmQSP4a57K5
 dXalqyDJGN1Viw==
X-Received: by 2002:a05:6000:184d:b0:45e:a086:82bc with SMTP id
 ffacd0b85a97d-45eb39e3f86mr38130768f8f.28.1779895038568; 
 Wed, 27 May 2026 08:17:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5579b8sm6611588f8f.9.2026.05.27.08.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:17:18 -0700 (PDT)
From: "its_Giaan (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 27 May 2026 15:17:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 040bb8548c15c48df5d615e916e46e7669c8d32b
X-Gerrit-Comment-Date: Wed, 27 May 2026 15:17:16 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f236b43dcff55073edb9148415e43480bf3c931-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wSG0f-0002KN-QV
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3775050140936972458=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3775050140936972458==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zyCdgLg245A="; charset=UTF-8

--zyCdgLg245A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

its_Giaan=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introdu=
ce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 11:

(1 comment)

File src/openvpn/ssl_util=2Ec:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/0c6c5f26_037956c9?usp=
=3Demail :
PS10, Line 84:             if (r =3D=3D 1 && peer_id < UINT32_MA=
X)
> This check should check < MAX_PEER_ID instead of UINT32_MAX since we o=
therwise still end up with an  [=E2=80=A6]
Done



-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerr=
it-Change-Number: 1089
Gerrit-PatchSet: 11
Gerrit-Owner: its_Giaan <gianmar=
co@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Commen=
t-Date: Wed, 27 May 2026 15:17:16 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--zyCdgLg245A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/ssl_util=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1089/comment/0c6c5f26_037956c9?usp=3Demail">Patch Set #10, Line 84:=
</a> <code style=3D"font-family:monospace,monospace">            if (r =3D=
=3D 1 &amp;&amp; peer_id &lt; UINT32_MAX)</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This check =
should check &lt; MAX_PEER_ID instead of UINT32_MAX since we otherwise stil=
l end up with an  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089=
?usp=3Demail">change 1089</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-O=
wner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Wed, 27 May 2026 15:17:16 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--zyCdgLg245A=--


--===============3775050140936972458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3775050140936972458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3775050140936972458==--

