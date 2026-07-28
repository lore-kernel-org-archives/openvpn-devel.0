Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C239C54F4C
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3iQG3aHBrwONeP6M0tHkgt7MGVlqES8/vP2c4phzIIU=; b=eYZS8Dl5BUuwZ6uXX2UhekNJXT
	pHPBZvJGdyNbfr4KUXfMJvv/z17m133l4fB0xuZuI0pwQ2NSy/3pXjqnX5NiI8VDtc3XFaP2MrygQ
	KT9wqJgbP22xHO1ZXudtWJ/9syGGb45YSryu5fR1mpa//hGKsVX/QVt18stg5LtCGhlI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojOy-00021F-2M;
	Tue, 28 Jul 2026 15:07:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojOv-000219-LW
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:07:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SLyV3MtnWdYxKM0uHUsH2+OdMf9WU2lPvzg1pKFD9BU=; b=T8RxQssc3YPGlNVheLlSuNasv/
 8UaOwu5DQmsZ/b9iOCY9Zlpk80SLWDam8sz5Xby5Rgsf5Kv9LQhyGTtv6dea2wCuOjLH5lNLMsSCV
 GdqJfmis6TWiFXIWiPymEBIc15FBzTvZL62ETq22kdHMTc3sAU41fZ8mugz7XiUXXw3Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SLyV3MtnWdYxKM0uHUsH2+OdMf9WU2lPvzg1pKFD9BU=; b=S
 bmvTP1maOMrCMu3cYM2mIh2Au0SOJ1l2vTHrIzLd80v2X5DnQyNxx9Eoi4pVTiAbvXXRbOZq6htbl
 isZXyIvVsdM58sJ/DZ7SB7TgHgNjKKqJKRqZ2XbCsiVfITeW0FtjL4jLtEmToTM/HD1nllmHElhUA
 dQrHE4ZIUdfJOrUk=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojOu-0000Zy-W1 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:07:26 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso36073555e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251238; x=1785856038; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SLyV3MtnWdYxKM0uHUsH2+OdMf9WU2lPvzg1pKFD9BU=;
 b=FSDQuakPr2nLWXuCgyfN2oTzp0mhppm/GnGHD8Y8QTLDynAQbmg48Ik1nvFt2KyJnA
 6+H7OGE7iWcYdcLkzqiooxEf7sl0ZIgMm8lBkvNWaC8GAUaOsJQ28wcwcwCNW5Sr6H53
 wWh6PPrJqmITf8zZrOacRKwl5hZehQDtRZnvOTmRTwadA4AcF68NzlKkRnf32+3MgVjc
 XUvpd6c/V6Bu5HD9t496wDnoE1Cr9trh/5Ih2ds1frcoOpIY79dwkM+ESZzoLYx2V150
 ZXHpKscU+tZ6hVickF/RLdIsFxH/e/5rU/5M2ExSk/dEbZlrg7E1wb0c5f1aqOtvKEr8
 MZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251238; x=1785856038;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SLyV3MtnWdYxKM0uHUsH2+OdMf9WU2lPvzg1pKFD9BU=;
 b=kR11OlMrwMnJU2a0KTuFJF0FxNKf6tsTE/vppZ7aB62N6aW+Bb4qAqjWhWKwP3HlhR
 OLoaZ2T7kibaFtjLOUjHv+VhA+glM0LbLtAOB7pntZHXT51csE91ufYTMSZgdqz+Kx6L
 3dylR9mzjcGF8myXMioEEtttXD2ehfmynd0sS5hQjOiq4nzcjjc8Dwx6oz9aRX3AWkT1
 NrthQG4GfK9BEVp7SeSdDslsMoPmELaFcQMHtfQqemho8McZkjWmh6tnohPg1Kt+8qq4
 cqdbIvuAVXBJPwkbBXVZdAtVxTKqX01PiI0+hPYj+nhg/vk5SAunr6hv/i4kVrkC9anG
 Nlzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKTeC+gedFc20G6Ld9+FVHw/0U+h8UI5d71wH+bDdeItAW9P7N2LfSgl/i09zxH8UxPS1iRnV+2OlxQxZt@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzUXACK6q0oo+rdtQCDDIIRS7iwtGEiyD7l+yIPXF0XPWvinQwl
 fh+Wig1YSs7qW5jBOwqJMuNevDha3NLsQ/F2AJLS+xYsxkIayS2qh08llMOmUUbyL06tfaAkCgt
 j6+sXe1IxwQEZ01fFXnYXBXmBgVXkQlxEIpF++s327hqBTK6h4rfHi3+cHiuQ3DcMVaBR
X-Gm-Gg: AR+sD13BZGjaOkyUkDSQ9loWmuvKyvYBYY/35SAx1jAWoQC9ynPB+TbFWONgmq97a2L
 WpfDXQytkmLSq3aonlv2FfoTT0vthxD/sEIRjRMXJ0B45zVhcRdVcQuN/f3PN0GhJFUMHC6n/wj
 f5yirz9ueKUJonSSEZZRm/RZ5bjbhMCSsapVYJDvbhwKykvFutV2aiBOPtp7YV/65rTN4ZD/oTV
 nDxtYJ6XMYL129ZzDXHJViaSlpBaxnFQYp3I5f6R9vaVYVhJd9xLA/So6UWe9Sygj8cYJvmZ7Wu
 Tz4MtersXIgyCjAy4W/L6cQuzWcC52i97a0oOLaghYGa/4+0mHKaHxEq5bV1a3VtYw5QSiUFl7A
 o7AAqxt2sD+8X9VK+W9R+yva0FF0R0J9zGwxUlcaqtZKp9DojNQdlq4WSKWBjPDxpT9ZpMbEjb2
 hrteFoJ24iM7VlA35s6XyRDZoTV+Vs2gygsYFftzIiSYsf5Rck74xlYsX0Ce3WRAoWCwu22qU2f
 pZ49rbMGeQLrjFnHUrsmKIojxAxgAvXLehEkcyD4zp/EvSQ3/712bSJ8nIbP7v0ezDk
X-Received: by 2002:a05:600c:4693:b0:493:f6e6:ce2a with SMTP id
 5b1f17b1804b1-496c653a7acmr32528175e9.2.1785251238250; 
 Tue, 28 Jul 2026 08:07:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c66cebsm60313977f8f.30.2026.07.28.08.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:07:17 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:07:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: c5e88395585325f1c756413fc87b21be31a11935
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 15:07:15 +0000
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <00b83a2be238c5938f32611d284dcf34cc0ccfcf-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojOu-0000Zy-W1
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 probe-result ranking for server selection
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2538843806173510400=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2538843806173510400==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eIoQSNjRlXA="; charset=UTF-8

--eIoQSNjRlXA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

stipa has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
746?usp=3Demail )

Change subject: oob: Add probe-result ranking for server=
 selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 10:

(1 comment)

File src/openvpn/oob=2Ec:

http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1746/comment/8b9de417_1e47a3f7?usp=3Demail :
PS9, Lin=
e 268:     if (ra->responded)
> I think if you started with  [=E2=80=A6]
Ac=
knowledged



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1746?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comme=
nt
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I55da68c=
c341bcfc707fd34ca2f84ff9b6a55501f
Gerrit-Change-Number: 1746
Gerrit-PatchSe=
t: 10
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Comment-Date: Tue, 28 Jul 2026 15:07:15 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@r=
fc2549=2Eorg>

--eIoQSNjRlXA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1746?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746/commen=
t/8b9de417_1e47a3f7?usp=3Demail">Patch Set #9, Line 268:</a> <code style=3D=
"font-family:monospace,monospace">    if (ra-&gt;responded)</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">I think if you started with  [=E2=80=A6]</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledg=
ed</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1746?usp=3Demail">change 1746</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f8=
4ff9b6a55501f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 174=
6 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=
=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Jul 2026 1=
5:07:15 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--eIoQSNjRlXA=--


--===============2538843806173510400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2538843806173510400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2538843806173510400==--

