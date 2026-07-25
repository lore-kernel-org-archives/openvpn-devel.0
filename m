Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A65C531C9
	for <openvpn-devel@archiver.kernel.org>; Sat, 25 Jul 2026 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I7JoWWoWXyvNZ3bPdt3jdprdsN/W3XFX0SFoOgQwetU=; b=CLnrx48XNJaKn3RY6CVrUvfLwe
	zsx56c0IbwrUtJLx/WsQop7GeWPTzyytQQesxn8HMGFbg+UhgwQOojGAgUlKvbAleikrTyTCumGSy
	42Fus5sHlQymXujhym1uV5KUoHEOOXMkDP3n6W7DFZLof6B9LoeKWmThHprk/hy2TQgU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnkN4-0002j7-4j;
	Sat, 25 Jul 2026 21:57:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnkN2-0002iq-AZ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 21:57:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YwZ6yoINB1JhyDCRxOEMyf2wBTjNe3lhifHl3ngrWKY=; b=ZDhCBk0yk7jCkjqfNx90N7dVNR
 DeY3cyMo01QI6iWbNj6u6RKc9emawCKD7UT8OG2p1AjggiW+q/w+rELkYqFNfu3KcLUBM1JMG1TW7
 EnI2Bx6zuet/nhQU4b1g6IVqznmqC8xwSvqyBKikRs4x94xQAzt4WYI9QI5vhY1+Cdt4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YwZ6yoINB1JhyDCRxOEMyf2wBTjNe3lhifHl3ngrWKY=; b=m
 3TIv38VTkAwxjVm+gHs97gcDrtEUgggK6dZuAZ8u1DkaS2+XZSqr8gS4NW3DKxuCFtudLUB4B1EXQ
 7yvsH9ii4iof5wbkGgQr0dp5QMrHYYc8P0jJ9F1gnpiZOn7b2cQKluqzSfAeVPr4msCMW+MhLwKDk
 DuinwnIuZDxn/UFc=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnkN5-0002Vr-G4 for openvpn-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 21:57:25 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so10292745e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 14:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785016637; x=1785621437; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YwZ6yoINB1JhyDCRxOEMyf2wBTjNe3lhifHl3ngrWKY=;
 b=ao+EMOSUOsb4d3sEab1NkE/aL/DrzGLtDGbkxj8nusQseV4oDNhi0NDKL7GcxERf2i
 dligNo3SMcnQEFZTA1XQdL4ap5ZayrqvggdWn+eUM5HsbAZa3zpniBkVfRW4wnuYwBVm
 rOXAzttaUosmntA/yUSzQjV0lsrHihFBlvSq0CMvVUlar+dWuHsqp9xzPfgnNRR0SLP9
 YzV7jj3VDLGhs3dmkKIx/B+js/OlMyNzlUhnsF4iSmFISaEKZsaR2K7KMBnSK9ICO4M6
 DQ/R8wUuAgcqplUet0tahWghmPw5xBTak6cxZMjpJmlinEzpC/d6qMwuEUDN7CC6CzQq
 XFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785016637; x=1785621437;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YwZ6yoINB1JhyDCRxOEMyf2wBTjNe3lhifHl3ngrWKY=;
 b=IAI5sDdUIQ1LHlixpc3dTvmTky1Vm1xlVbkeIevM/BfrotW9p1QvOUN6YUpMf2HBn6
 cbW95rsheXDjyLa5DV/7aXJhsU/mLLMt6PzkSCUjXlvOHcGrpIv+qWTejXOSKohJHZAx
 jAFEnIoSbnW9bOOIjVllOcNzKG6oSqX/eEEM8PG33JyjbVEar/w0RrwMa/VSwUENgIAS
 JapifNjVm4HMOMzzmYpYLZtpWSz5RFw4BKhqnBfs5OJHz7shovgHQWORZv3ruiKXKmP5
 CYquO8NOZN73DFpfoFVdzylIPw9MJq3x5qkI+54SN/S2Yb1Kj1GvEfyUEs6G267xF7C6
 7klg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZr9/l28QupZYPHAQeA1zukHo1mOcI0txIHyDB6WmMdd25Xk71KmatBnbXIcoqHgcrBL9EoW6K3NYRRkM6@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwfyR9Yd6k7MFwfeJa5qXL4jWsXLc8yv0PvdXALD5W/hKCD+f3e
 rb1avnDNznqop1JDJ2Vq0sjmfsw2C7ECu9B+d0c1jzvyKCXfzn1BBoLbr8E5EtmHHIQjTM0avfM
 nWMXDxz9sCxC3Cg2Tp87/tt08LNADgPbmKZCtPvoPZI/bSE3GWRFpE7uKCB+oMc2uBWBwoLXBrs
 SrsDuiXQ==
X-Gm-Gg: AR+sD11qoObPRd5pNfLapQy9HPbYQEd3ZZxHw9AuIWHUzrM3N4yqfOD6G0Ii2APmipe
 Dwm+V5elv4fGrNnvybYuyL9jkSzDdCuCcedTEgg0LO92o6SCkw6mU/NR39Tk9LfEIOplAOQQBsm
 wNFWi/6s6Ev4JUNAp8QDtLObYytNZZADCUZxzIOtLAPFivqFCfT9xoLaEYT0ajGCVDDme5hMwmP
 NCJh0R8qs+bIoR1ibCt50cSfNAcU2BtF4d4vrBG8Zdq3tZfAArh9JzbMTLfxgrsSWCPCLCjoAzL
 oddhj4m4zosczGtLl1iA+76Aq4T9MSKfoJnwG1qyuO4WAw7EH/lQ0KeNbtCKNjoAfbbTfjoz8Ur
 5niAhbFhw1J52mvXQS5hnHgXOh7yYlDMTix8XqRW+LXa1UtHv2kg4CaZnui356daca6xPmhNYgP
 9J1xLxcmq451BjX3/Axo/ssajzbv67uzbL0yWTP7tMmLldGNbkxzValZgGT5PtSpBEb7t7un1E4
 0W0MTCjVHaCTXkvIbU3alenXCI9u/8gaGToBEf+kVcChBP0HZLcLrEKnQNn2j7fF7r2Itm+XvxF
 roY=
X-Received: by 2002:a05:600c:c87:b0:495:4b00:1bab with SMTP id
 5b1f17b1804b1-496b5747e1cmr42753435e9.21.1785016636848; 
 Sat, 25 Jul 2026 14:57:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b842691sm141904745e9.1.2026.07.25.14.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 14:57:16 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 25 Jul 2026 21:57:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 8e2633f6f324e1c67abbb65d329706d86d74ee96
X-Gerrit-Comment-Date: Sat, 25 Jul 2026 21:57:14 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6dee96a985f66b717a7f7ce4c0945790fa77ae7e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnkN5-0002Vr-G4
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6904024265279091770=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6904024265279091770==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K0WqHqv01nY="; charset=UTF-8

--K0WqHqv01nY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1573?usp=3Demail )

Change subject: Replace custom hash_func with=
 siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 15:

(3 comments)

File src/openvpn/siphash=2Eh:

http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1573/comment/b8accde5_d7e6251e?usp=3Demail :
PS11, =
Line 112:  * @return a unit64_t containing the result of the hashing
> "uin=
t64_t"
Done


File src/openvpn/siphash=2Ec:

http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1573/comment/bab31858_9e3d1955?usp=3Demail :
PS11, Line 29: #in=
clude "config-msvc=2Eh"
> config-msvc=2E [=E2=80=A6]
Done


http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/d3b4f90e_c8ce2852?usp=3Demail :
P=
S11, Line 46:     siphash_cryptolib_init(8);
> Doesn't that need to check w=
ith `siphash_cryptolib_available`? [=E2=80=A6]
Done



-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
=
Gerrit-Change-Number: 1573
Gerrit-PatchSet: 15
Gerrit-Owner: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Sat, 25 Jul 2026 21:57:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--K0WqHqv01nY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>3 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/siphash=2Eh:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/157=
3/comment/b8accde5_d7e6251e?usp=3Demail">Patch Set #11, Line 112:</a> <code=
 style=3D"font-family:monospace,monospace"> * @return a unit64_t containing=
 the result of the hashing</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;uint64_t&quot;</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
File src/openvpn/siphash=2Ec:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/bab=
31858_9e3d1955?usp=3Demail">Patch Set #11, Line 29:</a> <code style=3D"font=
-family:monospace,monospace">#include &quot;config-msvc=2Eh&quot;</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">config-msvc=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/d3b4f90e_c=
8ce2852?usp=3Demail">Patch Set #11, Line 46:</a> <code style=3D"font-family=
:monospace,monospace">    siphash_cryptolib_init(8);</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Doesn&#39;t that need to check with `siphash_cryptolib_available`? [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">change 1573=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I807f=
398903ac2047530800c29949793c6f4f0ec9 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1573 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Sat, 25 Jul 2026 21:57:14 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--K0WqHqv01nY=--


--===============6904024265279091770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6904024265279091770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6904024265279091770==--

