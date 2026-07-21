Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A9DC44529
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/qo0WeSgtOe6TP+EtrizBM+UGEKWzrDFROhp+66Z/Kg=; b=gi3ywrh2YfaeDU/cL/5RukpuL+
	WyGselp6CQYo/+idDs49MdbBGRkfx3cQ41qZA0k5yzoMUMR/PbexufLykE+sFk+7/HxrpB69hBnLm
	HVfgbfks/j8P1sKZzwjOF+Mvje998PmKpNSTSWGkSIrvO7QS/vSPE8VmpGDJ5FugXN9E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm6eX-0007mo-4O;
	Tue, 21 Jul 2026 09:20:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wm6eV-0007mg-LZ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 09:20:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tvJwaF7sLI0BjZLmU2+XRuIJenv2J6NctVhdOVdiV7k=; b=ReYRcu223FjhP47TYygyo4I92h
 LBSBC/yfLZQJ4f+jw9GvN2DQqoBBi2OT4/gwvrEb4C0P9KWNeEIkFAtQFwNaxbGthP03Hj3/GrjRv
 b1FOs/6IpuR+zowI++kPMakFYCWZg4z85fui2BoDq+SxGMW5SCzjuLwZiEPor+J6ssN8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tvJwaF7sLI0BjZLmU2+XRuIJenv2J6NctVhdOVdiV7k=; b=T
 r+C8+V1e6smw3Vm23T2iqjRPn3kBQDnc3jQOlLQt1Zux+EXY4ZnuuIFitro25XrNwXYldniTAu4Sp
 HN/xT8fHEwkRp1rGZcnSb+raTSIXrl7xuAXLcVl4KrErZ4c6Fhh3LJRS32lXnncg1Wo/kaV03PxKT
 1oQWQLKSpUwHMHDc=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm6eS-0001Hs-Bj for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 09:20:39 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so7184832f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784625630; x=1785230430; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tvJwaF7sLI0BjZLmU2+XRuIJenv2J6NctVhdOVdiV7k=;
 b=BpIOb0b8uDtv45ANPfF47032kZ2gf7C9qqPx4zaAL5+wMQ/X6P5aSmMQiXfRUmnnKO
 fNbCYWeDR465L6qVyfmtwaOvTm21rJd99Lqzlf16wYj8HNU80+jVynviEjeeZPXUnXNM
 96NduAoKstJysEmFvSoeoTNRGI6ralLxE7ZclmN1Xc+L1Xq2JXFVsIPe6y3GQxziWfGT
 5HiVnFNwBo8yKW4kGIDSXwS4M+CdCJ9ksuctR+f0+wJIAL8WepXCZzudw4tlW/xQKrtm
 sX9x3HSCWtH46l4ij/zRYLSdJ66vzGpqCMyjlBz6W5Mmkva3oUvE//SBTzFIxiW0q4JS
 mxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784625630; x=1785230430;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tvJwaF7sLI0BjZLmU2+XRuIJenv2J6NctVhdOVdiV7k=;
 b=IlqMAgGOu3MpP/DH1oQIvy0oU4NtUvj+zygMkorT7oVx40xj1/d+7sbeGxmvaBgZW3
 eV7LuFz5/VAuxhg2TTrHNrLfVl2NQGACCYlfGf9FShhTIQtYKebJtNbEqBJpgI8gMxgV
 lQG0RB+2AvfpXTOSIB2ySugKQDbCJbvdKfFpULyetY62TocRBmGasX+q8tD+tp/RLTOi
 8QjRbYMTlAV7ACHBAOk8AthsT2l8wtuAgFA8o6Vp7auY6/2loypb1Zp3J4/Z1b07RKlB
 8CPzegR6/GUFD1hIstmAdMj0zq933PnyaF+edRrcCVOvRSg63eLg4zY934rQo8n9gaF5
 p0QA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr77Z64K2gznZxob7rg17CwXR0KiDwBeWV5LFy5A/5o++wQN/11rnjiUit/4MFFUjRipv08ZMeDteou/NH0@lists.sourceforge.net
X-Gm-Message-State: AOJu0YySHAUZ2460wHZ1YHO9FNKrVECCp6f1bQ1zLZ6wRjPMNRtDesBa
 SKcHMYGQCaQ+PQXOEKUxt2NZAE1dQpdBbT90brgIsD2klSH5s/uNGsYdFK4c0wY/p4RH96/xn46
 Lx3KwvJrAs/SL0C1LcsYnn5vvjo2So3BhT3/PAdNnjPGM0WCJkqtKW0GV9I0yoM562i2e
X-Gm-Gg: AR+sD13qtyd/DPyqSeVz8Y6B8KIi/ywaNV25KsnWZb4+p0c08IPxUE0vDkOQ8wphUcd
 GxUlAWYkyvI8fQ4ar33Z5dNH1I7xgK3p7eHiUsEnHV6aCd2Bbf5b3C+2Njcyg42iBVpN0lgqX/M
 HL0Y+2b8En4pVMQA9Pn6aGZdBZOU3tQvuZLhAlX50Hvq1CNeV7BPTUn6ZRtd6uhOKEIldBeqLvj
 uJTDltSciL9pnHxCaVaQe6CeCDQRqnV0HnzcHNAXz8J0Ye907f81x3u4DWbsRnaxdTalWwVRP+k
 eTuB9rYt30is1PWViHwRJBoNVtFyYTpgR6GSHoB0x7TXXslouTiCwFYzrttHqCPaFve9nQAZydp
 kAJTQ65/n1RdJWRZ+we6fis9MRcHEPYWaZiQozRoaPSa4VIFePWppJH0n2zq7LS7CCH8E1DSMLz
 Gb8CMZo97gjrnE1daJPp7ZiNCUCUTGzlJKZ/ZDRk9SB04Xi2WEM/VjRdKLs7jmDSS+ohCbj30eo
 TIPSMj8OZ8udOs3c9KK7UOxhW/rpGpvkW6YIlOuaJRcqH6cbZKQVKqa+v9wrdytb8I7
X-Received: by 2002:a05:6000:22c2:b0:47f:71a6:970e with SMTP id
 ffacd0b85a97d-47f71a69d15mr12890897f8f.2.1784625629589; 
 Tue, 21 Jul 2026 02:20:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49469sm38997630f8f.7.2026.07.21.02.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 02:20:29 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 09:20:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
X-Gerrit-Change-Number: 1797
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1797?usp=email>
X-Gerrit-Commit: 3f3d4b30df229e59ffa72bd725fcc167d64284de
X-Gerrit-Comment-Date: Tue, 21 Jul 2026 09:20:25 +0000
In-Reply-To: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
References: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTg2MDY2MDAwLkk0MzRhNTM3M2Y3N2IwZjc1NzBhNmEyYWFmZTBlYWY5NzBlMmVhYmU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ff7cd8b2bb7e61b28f9a5ead7559faf3ed2a8c52-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wm6eS-0001Hs-Bj
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Enable TCP_NODELAY
 by default and deprecate --tcp-nodelay
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0891088453971049826=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0891088453971049826==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8+CP9zcNSFg="; charset=UTF-8

--8+CP9zcNSFg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex=2E

cron2 has posted comments o=
n this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?=
usp=3Demail )

Change subject: Enable TCP_NODELAY by default and deprecate =
--tcp-nodelay
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2: Code-Review-2

(1 comment)

Patchset:

PS2: 
The documentat=
ion reads as if this is intended for 2=2E7, but the way it is coded (removi=
ng the `push` bits) will turn TCP_NODELAY *off* on clients where this is to=
day pushed from the server (server config with `tcp-nodelay` -> `helper_tcp=
_nodelay()` -> `push socket-flags TCP_NODELAY`)=2E

So for a 2=2E7 patch, "=
turn it on" is likely acceptable, but "turn off the pushing functionality" =
it is not=2E  For a master patch, it's still arguable if that is a good ide=
a=2E

That said, the documentation also spends quite a few (new!) words on =
explaining what `TCP_NODELAY` does - which is a bit weird to add this if it=
's no longer configurable=2E  So this needs more work overall=2E



-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0e=
af970e2eabe7
Gerrit-Change-Number: 1797
Gerrit-PatchSet: 2
Gerrit-Owner: or=
dex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2E=
de>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ordex=
 <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 21 Jul 2026 09:20:25 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--8+CP9zcNSFg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex=2E </p>
<p>Patch set 2:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1797?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">The documentation reads as if this is inte=
nded for 2=2E7, but the way it is coded (removing the `push` bits) will tur=
n TCP_NODELAY *off* on clients where this is today pushed from the server (=
server config with `tcp-nodelay` -&gt; `helper_tcp_nodelay()` -&gt; `push s=
ocket-flags TCP_NODELAY`)=2E</p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">So for a 2=2E7 patch, &quot;turn it on&quo=
t; is likely acceptable, but &quot;turn off the pushing functionality&quot;=
 it is not=2E  For a master patch, it&#39;s still arguable if that is a goo=
d idea=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">That said, the documentation also spends quite a few (new!) w=
ords on explaining what `TCP_NODELAY` does - which is a bit weird to add th=
is if it&#39;s no longer configurable=2E  So this needs more work overall=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1797?usp=3Demail">change 1797</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0=
eaf970e2eabe7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 179=
7 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 21=
 Jul 2026 09:20:25 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--8+CP9zcNSFg=--


--===============0891088453971049826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0891088453971049826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0891088453971049826==--

