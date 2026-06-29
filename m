Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D789BC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uoS/aD3S3ch1zTFzWgTGDu0lJv9nNJlFFOWjMbHElsk=; b=MMuxCb4VE0yVI4FQpS1qylt1CK
	vMTH9HLnv4cimQqt2ZWJz86kbLp7BRc5W3/xdNzMQOkzSck7db6+7vh+XV7Ng/uZ9fbEs4LrmOEyk
	x1UwrO+6Ef4FncvIIWXYrt/tgzGE0ePjRlfcbIvOwlN4T4sPB0/UVHiwejkIgXRAJDEU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weB51-0006CC-FG;
	Mon, 29 Jun 2026 12:27:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weB50-0006Bz-Dj
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:27:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=l+Z8nwPns7N5x4N53ye7mllECCFvb1KL2Yqk53MOfp0=; b=c/vOw/J49hvekqXCGeepBbWW3z
 8Nqaxj8VqhTeEif2/W/D3VQEOBLiP7orthOTlXxxO8bcw/1l/YfGRiBGjgayyTRgK7unC7QP6muRD
 +eQahEROSFIkc8shDXJ0Vfzx9+Ahft+wSe9N6mNBYxEWbcM0VHO4Y8InLBEdTs9LlLKs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l+Z8nwPns7N5x4N53ye7mllECCFvb1KL2Yqk53MOfp0=; b=T
 NRO0U6aIeF/axdp4m1+BIO6cKKanqYi8mr5PY0x9DjL/OnMBz2WorJAGloYfyFWkY9W2/awZMpMb/
 RJTmr0129puFiPmdigjGICTmUTEnB8AFoTYRCWeLk+qC943yRmipQgaKf22Ef8uojXjKsuFRQK4pt
 0n2mYqhAc9JBc5pU=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weB4z-0002Ys-3h for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:27:15 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-472493849a3so1282468f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782736022; x=1783340822; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l+Z8nwPns7N5x4N53ye7mllECCFvb1KL2Yqk53MOfp0=;
 b=K1ymR0mhZEsOVUXeIX8OmNaafCoLOrqQs0DOoAwnIRH+w3L25VVpvjZxjfCnSP8nco
 bjJlRcTuKBPKkVLPCn53SM7b3KmJN+0t8BWfEtqSTXjaljB6aMvMrDwBqlmhudTLgNxM
 /FXvhnxRRLPlWwM9eS10eTAXLcvlMo96WmCHLxeyd/pEaGHgJriqaw2+2iBOBK99+jfd
 RLUFKlxOQKvbLXTtwejdbIOS5+rOfj5HXrUg2YFhNdlKnsrueMoiTEMUhdzTo08oKmUA
 gMf6Jox1xGRv0u7a2VH4iK8rgZeFOpw2CI55Ehpq5K4kC7sevS6r8Bee8PRC2xkBiw67
 kzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782736022; x=1783340822;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l+Z8nwPns7N5x4N53ye7mllECCFvb1KL2Yqk53MOfp0=;
 b=MzSQaetjPgdFBcPpRbY6pd58OiXdUIipAG7EYPQx1LsxYJAErj7mr4Lp89tZ4accTD
 HbUsG4duRv7kiml/3Kyda4ytNp6euRqizNQkAdemWa2oOpV83U5py25RTXWvXZoAvx5E
 zIZvyYr72bxmLBWjMl1p8/K4T5xU8rZ3Hml0bwSYo+gI70pH5FUsG5r+oox8eBuVd5FX
 WZ3V/ZG5npdi1cPXyeMeazMXgpdaQn2ZOePbgAuAMWYsjzsbCS4QA98AxltRP8HtIvqi
 h4+opzmeucC64zhgG2tUPNd03J73/8EgHqPISJgVdLIThXi4k9tw0xmjhCBrG5oB1UYC
 wu3g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp86UEo0x4K4i/7O1RJZqs3FZhpg2t9yD5OpM1JjzCMQ2y2bC/n2R/EhRcfpJZcWZ1Tah9BZs+XeUaU5AuG@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwKX2PWHfuEfh3X3fIDyYA1GrkIh4OLi6zQeItXhSPj6yPTErWN
 MX5YIcuZnAGpDJG0BlMzrXFqtmu8ooQYfSyxofdKLncASgr00qp+MarANWW3LaubG15MsqBvgYJ
 0vXXbYtRzmnVADyeunzqn+GHFE9srrMFnCwd8CPbcB6ogVnj7MPqCjD6lplEl5NBnGMtAw37Ma3
 3yGilSrg==
X-Gm-Gg: AfdE7cmBsrhXkFULIDZOpw4BBNGdJ9Rirzzg35FmslXtJyzfQS2fbh9U2MYV49Fz7Hj
 2uNYfwxM/yy9xHt59KO/rihEQxeUQ++/BTl3q8CHiwPUVhu+iC1HDU3J7WndyMJOv0tJOrLY4kz
 bIxwv6EbOgaFRqcadTl6kHMGlecRF1QgXAzjRDOBmILiLNQY1lWNbcTlS/aO7YTY/PWgp3Pw/J4
 hJ9zZ3PTuzCmkIiDPGO61xE9UcaT0x4adosE89vTLzF1wvAybhHlC9FCQJ7aUViQBpHQvIUPhSF
 SfAVE9BNZ9YIUuX/ppjmf9EP1fzMYPNp0kC7yhTWHJfid5Pe+bhToQ3y7Rs1AmAIYU5z2VMIq6l
 hG4MttbD8kJ+4mpK1asiTuGjdO8As2/lHzBPgGpFlHUXv8APEL8nzneBl7drMyBfdZOEE/w49fI
 WcUOFGintcfgY420qnvhyxxnzuwvbfplgqj8Z36ZcSXHFy+S07NvmALp882HnAlFWJ/TJlsF6Cy
 69zRcAuJZYZhcIq5/U1lH486rD9UQwjrz4q4M7x10iEZBHKBCE4QEZyrvVEPpvdrfFYDuwYphq1
 GlE=
X-Received: by 2002:a5d:5d81:0:b0:461:cd9e:2368 with SMTP id
 ffacd0b85a97d-46dc0e050f2mr26885807f8f.27.1782736021919; 
 Mon, 29 Jun 2026 05:27:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4721c88bfcasm20548892f8f.10.2026.06.29.05.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:27:01 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 12:27:00 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
X-Gerrit-Change-Number: 1736
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1736?usp=email>
X-Gerrit-Commit: d809e5626304963ddaff0a8b8ff1e3a6b2db8c09
X-Gerrit-Comment-Date: Mon, 29 Jun 2026 12:27:00 +0000
In-Reply-To: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
References: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTU2MDk5MDAwLkliN2Y5YzljZTVlZDc3ODE5MDQ0NWNjNGNmYWE4ZjNjZDVkMTExMGJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d00be6a35ad3bd73465c0a227117d268f4e79694-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weB4z-0002Ys-3h
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win32: fix plugin
 trusted-dir check prefix bypass
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0139645097754336669=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0139645097754336669==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nwC4Bzr7Oa0="; charset=UTF-8

--nwC4Bzr7Oa0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

stipa has posted=
 comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1736?usp=3Demail )

Change subject: win32: fix plugin trusted-dir che=
ck prefix bypass
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2:

(2 comments)

File src/openvpn/win32-util=2Ec:

http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736/comment/eceaf529_9076a5c9?usp=3Dema=
il :
PS1, Line 182:     if (dir_len =3D=3D 0 || wcsnicmp(dir, path, dir_len=
) !=3D 0)
> I think since you are doing dir_len -1 below you should maybe c=
hange the dir_len check to be <=3D 1
dir <=3D 1 should not happen - we pass=
 normalized dir - but I can fix it anyway=2E


File tests/unit_tests/openvp=
n/test_misc=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736/comment/3b=
37e912_e2c5249b?usp=3Demail :
PS1, Line 492: 
> this upsets clang-format, a=
las - if you move towards an empty opening brace (`=2E=2E=2E [=E2=80=A6]
wi=
ll fix=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
736?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib7f9c9ce=
5ed778190445cc4cfaa8f3cd5d1110bc
Gerrit-Change-Number: 1736
Gerrit-PatchSet=
: 2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert=
@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Mon, 29 Jun 2026 12:27:00 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: cron2 <gert@greenie=2Emu=
c=2Ede>

--nwC4Bzr7Oa0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/win32-util=2Ec:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1736/comment/eceaf529_9076a5c9?usp=3Demail">Patch Set #1, Line 182:</a=
> <code style=3D"font-family:monospace,monospace">    if (dir_len =3D=3D 0 =
|| wcsnicmp(dir, path, dir_len) !=3D 0)</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I think since=
 you are doing dir_len -1 below you should maybe change the dir_len check t=
o be &lt;=3D 1</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">dir &lt;=3D 1 should not happen - we pass n=
ormalized dir - but I can fix it anyway=2E</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_misc=2Ec:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1736/comment/3b37e912_e2c5249b?usp=3Demail">Patch =
Set #1, Line 492:</a> <code style=3D"font-family:monospace,monospace"></cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">this upsets clang-format, alas - if you move towards an e=
mpty opening brace (`=2E=2E=2E [=E2=80=A6]</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">will fix=2E</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1736?usp=3Demail">change 1736</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d=
1110bc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1736 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Mon, 29 Jun 2026 12:27:00 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-I=
n-Reply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--nwC4Bzr7Oa0=--


--===============0139645097754336669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0139645097754336669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0139645097754336669==--

