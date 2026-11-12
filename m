Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6AB606A881
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AS3/vX4l;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HBOtCfvP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IQ4QwHyD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EhE6Pb44
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ii5KvNe706QjBu3ftXiI9lRIPMLarUvELeZRyyeerz8=; b=AS3/vX4lRU7kVtmvxD1GPqRGdB
	HkPcINnI3mmku/DOBUw7Ktqq6hhMwF2uUOgR0k89B71C6uTWSavpEv0459AjpdEre9K49mET/whsf
	lN32/3LYFaLUtl/Jbuq7SYZVnWp/dq//kVEAfvSNR8ngoMaqE+VutDyu6cnLgeW4xfAY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYbn-000000003uy-11z3;
	Thu, 12 Nov 2026 17:29:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYbl-000000003uk-2Too
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:29:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=woORrq0ZTojZlCHOVvOG/eYZFCDghIDmrTV0c8bGowY=; b=HBOtCfvPeqlD4+/0k3sBM+CNdf
 9olbvIH4L2LolVyBZ2HOMsRo6uBc6FklRen2NsuHKzjBEOKdIfiKfLP4/taxcW2TwEv5OgwAnD+4r
 a4Ew2HQ/XOJtBMY5MQ5KJ2qBiiIz6b7uA0e/eIDeKfBrulxbLLcmxEepHNhO0Nkn/spw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=woORrq0ZTojZlCHOVvOG/eYZFCDghIDmrTV0c8bGowY=; b=IQ4QwHyDAdPYLYpoJHt9BGujsL
 maapBiVfX5pIi9NusCvWLPwInkL7sQWO3hGd5xs6uWtfPv6Ym5ieiA7pLEQiAXrFvNguTu6W4Pa4I
 iPceNqqBAqFWo2PRp0/3ZFeMt7T7mo+lLmSQeUgkJ5Owku3Bd6nq3YNFRPuONAUtsqI0=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYbk-000000003Q2-1xZJ for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:29:09 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4910b863b84so744204f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794504542; x=1795109342; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=woORrq0ZTojZlCHOVvOG/eYZFCDghIDmrTV0c8bGowY=;
 b=EhE6Pb44beSCDC3NWYHZfGuY9+TT2v3UgmNIT3mue8B2FUe6csqYVYxsCTZOWFsqnR
 caTNoatGSIiUxEC1bSVGhSM2uZ4y0iEWme6hbx0/myBy2NbUoewCHG+np4AdG0kroi4P
 KVnV9fC61Zy70kWjQfVxmxAt2fnt32lAvbDcVOYKTLjpUDXzu7uVwvqpSwavTdBEfopc
 j1i/r7al597Ai8rFcBDjsr5OLNhIXpjZOXsNJ3qbYH8rZHdZykluGjrkyQEAyA+jTtS3
 sklKrzH6pdk5/2Elj6UhwUKNF1VrwOAfhFMFFTKtbIk3ia3VoTIKFnZcIwKk6h4fUYfo
 383Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794504542; x=1795109342;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=woORrq0ZTojZlCHOVvOG/eYZFCDghIDmrTV0c8bGowY=;
 b=gKaXfpYwBYpY0RZqOuCuSwNUaPvNXgDLE2+MJ5H83akrBtMafy/cXLuA3aVWuH0+ZY
 TN/IwnHDvqKipmrBq9xyEXY2F1HJxHaRGCuss0N2PAeMV2CCXhvXK/1g87utktIRUHu2
 yQc4YWeDN/+AlfuQgADS8d1Mo2y9RHAZXW0MXgTfUsExfhE5lkUgL7HzBTi8pn9Zfxvg
 J3sa4ZIAAwUmqxy3KvkafUX3mmjsOQ5RcV6HcJjA6D4Vyzb8R+a5TXwjzzmtHCX/ZvRb
 NJmsXxDbIlxqwew0isGgpyG/bGRbIaunkwWycuLoBuCZ+pHUzOb06bjnn6zXmC815u8Q
 kU9w==
X-Forwarded-Encrypted: i=1;
 AL+hErERtyVUg0A+U4ceAGSBg4CbIV9J01bptyPBpPx71JJSav7YkbX/6tBS8fb+RLdrz96kJqBRnpwqC0Ug1Jl1@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8ZoJfApUUvVb7UXiVGZmYO+mJK7Gh9J+iT/KVRi2BiEOJis7yo
 eFoa098kDDwE/gcP8tXL43dXhHL4MfAjRLlU6v/XfwwrAzWPLUZgVbEp/yVCWzGfKWxVDllWxOQ
 KsrNsRXeyHD9r24UwD33Rg+6a/8TH19Mbf4fJ9PXU95ORJm+06pTOkcwduNDDhcNp+4gr
X-Gm-Gg: AYBFou1Uk6vzda1wPFUR/RaZ2oD6ps4P/s5Di29cgETtSKaDrJ92poEthcyauW45JCK
 r6acnzyZnl/9A+YGC/0144PJmiTd+uHvZzg5ymvFkamiBxoDxaE+Fkbn/H16dO9++oNPFa6bk4Q
 99QCIvTDM1hIuXd8sR/KbmzzdYf/HTkwBDADjcxoxQkkOQ1EqgrtHEqA3zNC4RUCOmoi+6N/7Al
 WSgR9fo4MB+K5sA2AbCz+NM6vilUT3ODoKF2J6wHXpVgOcW4BmwyD0kFZnM2IJgHid8/59WuAfQ
 A5ceZFym0CyDLg8aa87E8yNqo4ZjKd9nqUvbIL7vJUknSKR+ILpnH9oXnXiS1/J7IHvjATEwfRc
 6I6+owVv4Xu0A/4oowSGPHsAIJRuyvhHurcgHkU3Funy76LMZySs7Ftr4lTvP/xvDrhU1Dn+i8f
 fnPGMuBM1/UePWopUlyDq6WumS0Kpc0nrm7YS/41McULqJTblWKxUW05hsArcX8YRVosN6wEf4v
 0efKkBUqmYLM3E2YGNBF0Sn72YcFgNlZ+kWeYhauxhyoPEj9Iy+6b/l3S3YUlTtYcM2yTB0SnCt
 3luLng1H9NZvzwC9pUbBZCVhopDebbN32XWmNV7lNKRHxb8Ne4hK+gOKJFuvJZqFTsvwh/9dR7j
 UrBFUslIj/QZkpYC9nhLc5Qo+DiiabuODTNHrvvXtoQ4N6X/zv5bqQBVLqj0N4GzWUP+Q5asM1J
 t4bwKhrUZqVdJ/qSvZlTKLiOR5NmfGUXuNyfHt
X-Received: by 2002:a5d:5f05:0:b0:48e:76ab:78f3 with SMTP id
 ffacd0b85a97d-49c7026072fmr103225f8f.15.1794504541637; 
 Thu, 12 Nov 2026 09:29:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d03b104sm438732f8f.6.2026.11.12.09.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:29:01 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:28:59 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: c4d3d47750d4359fe2726370f3a69c3558932737
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 17:28:59 +0000
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <54400dcc1eacb9eaf1e6d91595d86db843b781a2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYbk-000000003Q2-1xZJ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 IPv6 name servers in NRPT exclude rules
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7370740914685147299=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7370740914685147299==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NgURoPK6YpQ="; charset=UTF-8

--NgURoPK6YpQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Heiko Hund has posted comments on this change by R=C4=83zvan Cojocaru=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail )

Change sub=
ject: openvpnserv: keep IPv6 name servers in NRPT exclude rules
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(2 comm=
ents)

File src/openvpnserv/interactive=2Ec:

https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2162/comment/d99e56a4_a98881a0?usp=3Demail :
PS3, Line 2138: =
TrimNameServers(PSTR addrs)
First I was like, meh=2E Windows handles this, =
but turns out not for each of the ways you can set name servers with system=
 tools=2E So, this actually does make sense to do=2E WMI inputs are not san=
itized, and ppl will set bad data with powershell sooner or later=2E


http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162/comment/de1ade99_cb43a208?usp=
=3Demail :
PS3, Line 2589:                 v6_addrs[-1] =3D ',';
While tech=
nically correct, I think `data[i]=2Eaddresses[v4_addrs_size - 1] =3D ',';` =
is understandable easier



-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2162?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
Gerrit-Change-Number: 216=
2
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Heiko Hund <he=
iko@ist=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Thu, 12 Nov 2026 17:28:59 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No

--NgURoPK6YpQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Heiko H=
und has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive=2E=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2162/comment/d99e56a4_a98881a0?usp=3Demail=
">Patch Set #3, Line 2138:</a> <code style=3D"font-family:monospace,monospa=
ce">TrimNameServers(PSTR addrs)</code></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">First I was like, meh=2E Windows=
 handles this, but turns out not for each of the ways you can set name serv=
ers with system tools=2E So, this actually does make sense to do=2E WMI inp=
uts are not sanitized, and ppl will set bad data with powershell sooner or =
later=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2162/comment/de1ade99_cb43a208?usp=3Demail">Patch Set #3, Line 2589:</a> <c=
ode style=3D"font-family:monospace,monospace">                v6_addrs[-1] =
=3D &#39;,&#39;;</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">While technically correct, I think `data[i]=2Ea=
ddresses[v4_addrs_size - 1] =3D &#39;,&#39;;` is understandable easier</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2162?usp=3Demail">change 2162</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d33=
9bc9e972 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2162 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &=
lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Thu, 12 Nov 2026 17:28:59 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No=
 </div>

</body></html>
--NgURoPK6YpQ=--


--===============7370740914685147299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7370740914685147299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7370740914685147299==--

