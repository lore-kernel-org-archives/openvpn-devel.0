Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A1DC55174
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yaOKGwnsmw7DeBUFlSYtBWUjYmyKU7q4F3GpTKsFucE=; b=Kg1SbS2ig6adwlEjNaNPLXX0AP
	e4adihZLf4sJeOBdNcRF+dad6fDU2/GdSPJ2J6ChqtAEHs3XO8tJg5KgiRnoQJsfFOj09tMGkY+hy
	KvQ2McjtxJB5EExh85NfcHzuwsLk2DgIltd3jAXU8gtSMgA9knebSkSZlJ7LS2dAtkHk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsgdl-0006AZ-0r;
	Sat, 08 Aug 2026 12:59:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsgdi-0006AQ-TE
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 12:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LsnNBiOxKJ6u3WBO3JQB58dN8zIpPHvV4cSGHTyg56c=; b=LK7WJOZvdAY6FoMiddnXenFoo2
 4Xzc+CO8xWilLDvj+G44DcQzFxGC5MhMX3Q0ouffcxkSseTtMvB8ErETSOmsFCi+Ob7ktj37E3/qe
 vPxfyPyKe+avleJvrZHkTtGLk95+6xVLPMFEVzO6+CSrlCGlxSwBa9/OpvkjOgNM8UUs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LsnNBiOxKJ6u3WBO3JQB58dN8zIpPHvV4cSGHTyg56c=; b=C
 QiUoXIFqrZk/epvNfcvO+MAnHJkhh4LJX+tDy87UsutLZL587jxfxWoT4vpRYvtWHYfx5w5XYVlA3
 gGEnR8Kwmu7fioj1RM3QJrv9mm/B6Hoy5ZCJBL9ZoSEFjn49l17Fv6EeLULVbI+8vIrsSnU9Dvo+C
 wvlbmoD9lWUQIGlo=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsgdm-0001GQ-Ko for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 12:59:03 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so183758f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786193936; x=1786798736; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LsnNBiOxKJ6u3WBO3JQB58dN8zIpPHvV4cSGHTyg56c=;
 b=LCSdWiV0JBwbudt6PuMdNxvH4BU9yyov9Qwm+cC30Kjue7bE/ZHjbzbIcxxW80MfSw
 DJMsmeOKXeTTOpgmwHrbimey+QSwACBWVDHTIowFlegoT3PW59Iw6iBymgN1rpMT1fNb
 YDizcogTlYPJCKYH4cpPR85a1cUWGBgSJiW+S+DpNmFlXknobtm5l+mPYMr4thf6ZWbx
 FTdA5q2vmg54LrgMHvNtw/RW/peGuvCo2mhEtG/TTU1bjNMvmMXscGXLKaTn1bHDZOhJ
 rwSMzoCBl0nxgFLx6BQTUa2DPW/Ie6r2Yhw6fdFd2RqW3OXuJqCNybqpwJo6OUrP+ghl
 K5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786193936; x=1786798736;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LsnNBiOxKJ6u3WBO3JQB58dN8zIpPHvV4cSGHTyg56c=;
 b=XaijcRA0rcoHBoVeGloLzTVpxpJXXtBM//7EWWnOeW9CRp9K2tyJNxyU1T0IZ9AMql
 o+zQpgpdeayHy2YT77NvKkWlnpysZnFFQNF8//QyoPMVvHvCevXjqLhha+V9WW/Vsvdd
 iAlcZev0UOwU+d2IJvQLeXU/czfKtxtM3Wlc6TqP5nAVlq1D+0IHJg2mMJ/kASeSroPK
 Wm+T/ShUuqIASyNAHyhVdMuVm2gXaTP+ERHjValdcUMDuGc4BtgttfoWbYc2INZudtrF
 rkELGrkrJtAKbKCbztlLk1Y9ikz8WZAvATjUmPBWuJqx9r52XrgKaS4e+AUBnPjjABuL
 s9qA==
X-Gm-Message-State: AOJu0YwClqawyY1LUO2eYrNOfcHiJgiWmzrHyhID1BUJJD7qTFBWEFbg
 Ya93aPQ2f+ORrJwQ20xqWI4WEzPYeyp437q3vN5MWso934tdRC8/hE0qBn4XCxl4JrIg1seE9Fv
 3ykSOvBm6G6ytPSrrwocTBQHYbWxxkUOPL8gkYv4DHCT1HVSXjB1cpcbES94Pl3rmz8H4huWQde
 6p9kLtVA==
X-Gm-Gg: AR+sD11r5uVdhAAiVkAuesD5orbowU+ZUA+Qt38n1C27BygzuGTXSJxnMdrqeqpmRTC
 M7bJPhpaNEwnh2w4L3PtiIN+SvfBvga0odXaMPL1MsEEI3F9ZHuBc68tumIefnusujKfBjGddBQ
 vKtdlWC3w3AD3z7SLrlBkB82pKQOcNT/41csLK+xZYBMNaobIU/LEU9ES62oayo4evIDE0pe6Hz
 s3MRRc5LaoDfX8tXZy3TFJyBAM6nAaF/c7Xi8pmhNejNDwpOCM4Ao1PVzWQ52nvyDxIOvLWe0B5
 d60rfFeFKIIVnkVwjP4LmQtq7W5bPnxlTsLVWxQXuxrd0PTZX+fv6qTnK4pTcssxc2gS+kcKEmi
 rIuzp5WimlGWaiAr5XZmtT3VfXyFoTZfGclb7WbrXpfKV0J1D3siHzwnjonuhgBJ8aKncWsUaHD
 Zpvufsse0GjjTGq412t7sH6nBcfaK1QjBvOeJQHoBXu9oewARHOn9Y6Mc2hXXAuCRrWHMsrA7CC
 AkpbXk19dvUiOv3WyMwx/VLlQ3PArAadk1Pqz2Ey648v78YY/JiLIH5qINIZabGdGkC5PkEMyGy
 mlLZW7WQG1VPxHUcFHecQeI5dIkSB/BgiAhD0wDf96oIFdegTds=
X-Received: by 2002:a05:6000:46cd:b0:47f:f43e:f0cd with SMTP id
 ffacd0b85a97d-47ff43ef171mr24947061f8f.4.1786193936460; 
 Sat, 08 Aug 2026 05:58:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f9182sm15172345f8f.28.2026.08.08.05.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 05:58:56 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 12:58:53 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: e6fd07d842db523bf0b0aeb8952b6b190dbf8188
X-Gerrit-Comment-Date: Sat, 8 Aug 2026 12:58:53 +0000
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <deb012cb1bd0f97558957132869fa695805c36cd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsgdm-0001GQ-Ko
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove various
 unused functions
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
Content-Type: multipart/mixed; boundary="===============3722760401151423750=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3722760401151423750==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jgus31u+G8o="; charset=UTF-8

--Jgus31u+G8o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1610?usp=3Demail )

Change subject: Remove various unused func=
tions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 12: Code-Review+1

(1 comment)

File src/openvpn/buffer=2Eh:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1610/comment/1bc6b612_ae93ea62?usp=3Demail=
 :
PS12, Line 818: {
I understand that this might not be used but feels a b=
it weird to remove it nonetheless=2E



-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1610?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Gerrit-Change-N=
umber: 1610
Gerrit-PatchSet: 12
Gerrit-Owner: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sat, 08 Aug 20=
26 12:58:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Jgus31u+G8o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 12:<span style=3D"b=
order-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backg=
round-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/buffer=2Eh:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1610/comment/1bc6b612_ae93ea62?usp=3Demail">Patch Set #12, Line 818:</a> <c=
ode style=3D"font-family:monospace,monospace">{</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">I understand tha=
t this might not be used but feels a bit weird to remove it nonetheless=2E<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1610?usp=3Demail">change 1610</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c=
65b835360b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1610 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 08=
 Aug 2026 12:58:53 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--Jgus31u+G8o=--


--===============3722760401151423750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3722760401151423750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3722760401151423750==--

