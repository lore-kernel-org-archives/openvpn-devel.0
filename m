Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBE2CC6B2A
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0gcmfpYEQQv5rpY1BmfNXnyUHWdlS/mOygHN3OCWJEM=; b=ia1/cMIcP+sZcVNdSBVmhcc99S
	ew7Kx2zLIRNTub1EhD+ETF7meW9vP0zcDGrhAISWo11GLfKitai0grQJ7OKe4BkuQv0DNWvvOQklD
	9fXpTPMk+qNKxHp6ZaaSiGpwjgJBkBX1ao3DLUvYbe/HaBEmCtd3gZRZASEy+Ynh9Ixw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGxBa-00077C-Sd;
	Wed, 14 Oct 2026 11:30:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGxBa-000774-AV
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:30:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=l4jgW50Y94jsheOUuZmRi5tqoM/H1jDW5S12st3waCw=; b=Vbk5FleywXU8sfnp0fYnrLOXLR
 pIVuH0GaTMHHp4kpAPhqFHO8jNQsR74x4rgqIXz7/Jhs5sNX1F9zFUIc9wyjEe1yGUW0YFBfcNDLM
 u8R7cK+F2PX3nbgTqo9zqvEz8N63M3NbukL1uoU8ZSe7BnORW/DHclC2+UQx7xt1Cqn8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l4jgW50Y94jsheOUuZmRi5tqoM/H1jDW5S12st3waCw=; b=l
 1mtgouPdQtGcOLw/SK5UPL6FNKXJ2T0/N9HiaFRHFLU9ezZDUWF2bSazfyEMCVYkDaMPZB0v5tszs
 JeDsavASqJNxnoEiSlCrdaAD2DJW5f/Yk5cxnxwQ2Ezdi/6OPmLln3NUPXUEELimzjQJbrOLMnUa8
 x2A2Cs6cIrwDCYnA=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGxBZ-0004Fr-Kv for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:30:18 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso37371765e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791977411; x=1792582211; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l4jgW50Y94jsheOUuZmRi5tqoM/H1jDW5S12st3waCw=;
 b=aT6Iyw9s/QTrcofh0TSl885KMMd1SXwEe4xsmwpDvey0wUOuCXT/Ds9ATwTC9b3R8/
 2WummuVSryeHLTqI6tn4HgzTBUlfpKDhWxyxxyJbvyWlBqEqU2Yp66wNOSqVdXgqkjSg
 0eWbbs7baYhetFqY8a81aT+Az98SrfwOYNnldNw2VFz4dZflDCaMhFbzULZiOzrZYpBw
 0tnJ1YRb/Q1WinL69dfamwhAHuvk2xRfAH2teiBI5xmkrawFBMZ4UbWK0sRc8lZZcwrx
 jxw4/tdMRPJlkWsQ8VDX3i8kFm1aKA6y7VM0BOX0nXZ30Xg/L1OrZkREi9rHtNX716bL
 RIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791977411; x=1792582211;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=l4jgW50Y94jsheOUuZmRi5tqoM/H1jDW5S12st3waCw=;
 b=zovGGlEYl6OF9BJG3U7s7HebNMsExXV1HKYE2oWWmcIRn9smbAhHq+9Q/Mm2iGm3hl
 GElulqcGhh7fWhIRwVL1/zM14p2EL7mEsT7QFj+NQbIjZzR8KFyZ777Lv37UNE5G3/tH
 TETIlTa5IbIsx2PF1txJHBXrmiZ2Cm5hbKAUGsAsQzOE8acBe2+hYjBbrk6BIzDXXD/y
 /OsR+Hc0UT6IO3qp+IrkjelHjueZTVTxQmgiMmCU3xQOuX3jI4DK2D4f0Dh5/J460lKf
 1PXDb3fbIV49Et11icyRVgWexjFLMDxDn9+zXvNAfmwOu4qmNZkvIrFfqYxdZFc5gHG5
 vqSA==
X-Forwarded-Encrypted: i=1;
 AKwUvByjAsm7xYrUbjH6D/SvcEGTB43sds3MjSYhD0DXT5ZVNWl2Rzw0SCPMQ7/2tkWFI//kTRLRXh7oeKtyVL2f@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIMKuoR/ovHPni0ghetVLqoP5YOq8Fwxt8+JFnG35bInfEyTKJY
 /Rid4nR5+8v7qQEZv6RamOrhWK3NG2udZKjLMDY7ZjSt0GZ6DpRlIA5ZtjyptE9G6rdkvTUerWA
 kEZJaD4XJQVrN3dG8sOFzbjcpr/EUaxlbuc8TDsafa81o+UkLoLdg4h7YqoYE9hMLrmIhkjTr8c
 TQL9bO1g==
X-Gm-Gg: AYBFou3nFLqrMTTuiIdOpoBf7cyGFyPV/qoJP/qz27E1LyWBZlVycUIMSvKoTaNuAC3
 072uYe+6a39xy39bJPVxBNAje6k2wYaJArKlTTwXTU4rDs9R38ArUK/Tw+AFEeB5v91zayL5F8k
 CPsN3Lgb3c29aNIuJqmm27lLgM2FTSqW4aho9maaC8ROq/Ap7p8Q4wrVwHPw0VngsJQJfkkd28v
 LetGqZgwH1cQVJs/50rG556nELQiZyKUoy+EM+7MLgc7500Leoj4SZF8nF3Hye1epOewOpBx6es
 YVxiJhLcaOhKLvzqMGEdduZa9jdiv4MWBhp4frkaUTEp+WZYs3jLpW7H7jXQ8AOVG4dJB/lNeti
 Tx2lS6VuSnZJuki/6/UOCPdxOPCK37Cu2r56rL5WPROn0dhop3Osw8Ub6dd9XQQIYMvXi2hT+CY
 GLGY80wGihVtQGv1SvVKfIXiiG/wOpu0ZjWLgfg/LE3iMQT6HhJN+dzJtAThGy4diAncfrOiQqS
 nPLfwSpNbK1OAGEakIk5nvDhqYy7hytaK/223z7qjPM2hvFLvApa6akUBoLCcH3YH4yq2faUoz1
 N3ORqz911uL2P3G6tDe0gjGrVqVY1rwYPHTa1LbDH31gchhiWBPtIoFq1Bm7
X-Received: by 2002:a05:600c:8b0a:b0:4a1:6992:f861 with SMTP id
 5b1f17b1804b1-4a18e446db6mr285570185e9.1.1791977407617; 
 Wed, 14 Oct 2026 04:30:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b4b8cc7dsm29814855e9.4.2026.10.14.04.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:30:07 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 11:30:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
X-Gerrit-Change-Number: 1997
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1997?usp=email>
X-Gerrit-Commit: 512103d0b5776e82beaeca0b200bc992b27f09c1
X-Gerrit-Comment-Date: Wed, 14 Oct 2026 11:30:05 +0000
In-Reply-To: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
References: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkkxZDZlZDVkNDA5MTAzNTliNjViOWY1YzVkOGY1NmFkM2QzYmM4MjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea1bdc3fb43897945591bbaecdde0bc5ff5784fc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGxBZ-0004Fr-Kv
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Fix small
 issues in buf_printf and buf_puts
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8565439523352958556=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8565439523352958556==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7ROdyg0pK40="; charset=UTF-8

--7ROdyg0pK40=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail )

Change=
 subject: buffer: Fix small issues in buf_printf and buf_puts
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comment=
s)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997/commen=
t/197fc833_3acab81f?usp=3Demail :
PS1, Line 7: buffer: Fix small issues buf=
_printf and buf_puts
> Is this missing an "in"?
Done


File src/openvpn/buf=
fer=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997/comment/22d3fcbc_=
6f86f28b?usp=3Demail :
PS1, Line 795:  * @return true if the buffer was cha=
nged, i=2Ee=2E at least one character was appended=2E
> I was thinking of t=
he empty string: `buf_puts(buf, "")` with `cap > 1` returns `true`, but not=
hing g [=E2=80=A6]
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1997?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
Gerrit-Change-Number: 1997=

Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Comment-Date: Wed, 14 Oct 2026 11:30:05 +0000
Gerrit-H=
asComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Comment-In-Reply-To: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>

--7ROdyg0pK40=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1997/comment/197fc833_3acab81f?usp=3Demail">Patch Set #1, Li=
ne 7:</a> <code style=3D"font-family:monospace,monospace">buffer: Fix small=
 issues buf_printf and buf_puts</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Is this missing an &q=
uot;in&quot;?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/buffer=2Eh:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1997/comment/22d3fcbc_6f86f28b?usp=3Demail">Patch Set #1, Line 795:</a>=
 <code style=3D"font-family:monospace,monospace"> * @return true if the buf=
fer was changed, i=2Ee=2E at least one character was appended=2E</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">I was thinking of the empty string: `buf_puts(buf, &quot;&quot;=
)` with `cap &gt; 1` returns `true`, but nothing g [=E2=80=A6]</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail">change 1997</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d6ed5d40910359b=
65b9f5c5d8f56ad3d3bc827a </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1997 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed,=
 14 Oct 2026 11:30:05 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </di=
v>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In=
-Reply-To: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body=
></html>
--7ROdyg0pK40=--


--===============8565439523352958556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8565439523352958556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8565439523352958556==--

