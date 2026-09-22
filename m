Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6742C982FF
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5R+zxkMlMqhVG6WXKhSmlEw7HFV5nqY8wriOTuoPiE=; b=g9Lo2dn8+6JEo9onN9iHtttjrz
	vptc83QcS+G9eArKLCQoUCU5l9Pzx2w2iDTBP93Qr0vafX/PjXmR21e41pRFfFzNf+tgv6xH3rMHZ
	c5lnQedfOlRqaoChwgVgQCZP6KmzVnvTDHQZwFTj9YU8+LAcS0mnpoY0LZY11oaRUsU8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x90j1-0005vR-0h;
	Tue, 22 Sep 2026 13:39:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x90iq-0005uR-3o
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:39:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sKGCGcpesiIHPHFBO8fNzKFd0hmTmjQhdZqIlXrGwyg=; b=dqd9ZnTaub6vK4kHEnNtJg17Ey
 MDLUYQ3Kl2sfQwkna6NftdrqT8UZpGGNgQGTGN4Tg8d/xKDhcEFekti9AJiYJftWH1PCecv1wkSq0
 ExJ6cHunfynmWiOxwlkfloxiBi3vwt7SzVCzgrOe+4DaAA2DvLsMhy5UTtaQFZDciTgE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sKGCGcpesiIHPHFBO8fNzKFd0hmTmjQhdZqIlXrGwyg=; b=X
 FaL4EwYF9tq9ghSXFI3RdljZvgQrgaOcZAIfJRaHKapBEnztH5gjRqcwFAVm7q1h/Gv8HtpG1YC/l
 JAcrQ8RGISStgZYLn/rLnNlbb1gc+N57V/HA2Wf3Gyjz4wvOWLl6MxLHVmWwPhlY5XFTb0Z0lJ+Fe
 +Sr+rBiWReayEKrE=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x90ip-0001MP-18 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:39:48 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso30285925e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790084380; x=1790689180; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sKGCGcpesiIHPHFBO8fNzKFd0hmTmjQhdZqIlXrGwyg=;
 b=HgOZe5VwPijD0cjh0DDzZOBhMW8uDn41nBoIA/QnGOnQeboNWyZpVZDGMvAjJDJsUc
 gfQG+T63uko531yqvpgxOFS5abw5ajicaC3im3ode34MM/xrtZSsbO3TxQl5Vwa87Qpr
 sViLOzHU8EWMwgYcKPtPvnzTZ0/mY+p9+YAfo9m27OsUZvsSBODtnpiQe/QmDLDO5VCS
 S4MH+3des+ooAh3aOpWYY9uC/ThP3Ll87sgRe9YedJ7VtSrhldUx6CIKDB7Rzd0C80Ds
 o5taNra+7TD3ohr4FtrmNgyDFBBNMv4FMhv5BrqM11N9/Yksgsay59VK+NV7RSUnnlQK
 FuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790084380; x=1790689180;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sKGCGcpesiIHPHFBO8fNzKFd0hmTmjQhdZqIlXrGwyg=;
 b=F+/uXcMVuvJlLGK4EO9XEbZfXbM2BLOfLwlpwdYtIlg0UDGn8yFVfP+2rw8onh8T+q
 dwFB1BU8SWn+Lz0PsBTMjJb/E9gkvDIU7KG4qwQTydJC6XWTy2q0n+cOKUj1wGJfvGOf
 PuZUEfqGuJVIgU2Ip3DZpK4NTe8/jKw6uBh2FfGUGH29TLgODu4Y72oxUaTJFV4KvE/d
 VlUcEUtqyaUcDR3mS8AzsD54qULEYPesgCF2xG9uArxnuO3dTU2rOZI+UYee//GAJO38
 IQloq2vAMOvjRPg2z9PDJkafZB8/Z/4uCyx7okDqgy138jp8KSgzpOdF/WcsZpPhaf5H
 zhzg==
X-Gm-Message-State: AFuF++nobxnZk0DX0JnIbQU/HY1DIQE9Ext8cnOrfa9GCqYnBkZFDIaX
 VLKsI3E4JrvOFDx/DdwzSYJR/x68ATGiESjk79O8vzk+wI7S7iA4iGzitSC8yR765WPExJgwtjM
 IX2dGcRo5WVuGxOELLeAYnFFl7o/ZWFiRCVkjKGh7LTsDMAH1ISk05ey8gwnngfu2o6cf
X-Gm-Gg: AYBFou3dOWOvrQUBcRNF7VLuVsrT1hv7JFe37M2RA+Y+up8NF3FYbzNkY4YkeC5CKEL
 6H7aKADsZlZH5y5mddaCNBdiAneWi09r79bLM/j/G9dVa+MYYvW+yi5BnM9FJke109QO6EvZSVK
 1RRTpoEw/3oRKmrqHnBiLSNcyyF/LHZh0Bc4xyPFyupDLE9Krq6crm2EgrpaKUKnhufhyDcg9uy
 F0Nbfiu9i3hLCOPs3HegI6iGS29oKjzeQY1PCWtB4cjhA9HxNtPqxxf3z2zm4CoxTujwkyri79y
 7BTGl8OGz0A7Pjtu7i093QLXm0ytFkntYKipeEtsuSBaUb833t3DbgReMD52EFOXV76D43htIbK
 9HDMD7fcQq1llc1BHXZnAfDqBPa3tlSP1C1DZZ1S2jO6s9c86MlHx4T0A46zcvFLdN1Nt1KmjXM
 wVEp4yxtMsBH7agRLLvghLEp9W5V3WvirDiNjojI93rnFgJBC8F6XMKBGSRR0NYBXKLWh35awYQ
 VPLtuAoQXgQt4iZEzjD3f/E0zy5IY+ocDvORPzlFO7SFmG+GD3yIIVNVxXKMdiPkyU7rh2I+eeY
 fw31eFPcOmiZTTICeaPhUcCSBU3tjemJk0tF5/6Ke/GIk7jnD6Cw8iVpPQXU1A==
X-Received: by 2002:a05:600c:3493:b0:49f:bd3c:bc21 with SMTP id
 5b1f17b1804b1-49fc573b55emr191133375e9.28.1790084380323; 
 Tue, 22 Sep 2026 06:39:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862785a4fsm5388035f8f.24.2026.09.22.06.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:39:39 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 13:39:38 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: 91b470d50dd8a5cbfd0cfeb3e84dff79f2b82930
X-Gerrit-Comment-Date: Tue, 22 Sep 2026 13:39:38 +0000
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e59d5944378fcbb244de73c353f5e02cd6c6ee59-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x90ip-0001MP-18
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change most
 ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7895446566029100257=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7895446566029100257==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8VLPcRTsdTM="; charset=UTF-8

--8VLPcRTsdTM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1942?usp=3Demail )

Change subject: Change most ENABLE_DEBUG ifde=
fs to ifndef ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(3 comments)

File configure=2Ea=
c:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/22b16a8b_32fb6cb=
e?usp=3Demail :
PS2, Line 134: 	[AS_HELP_STRING([--enable-developer-debug],=
 [enable developer debugging support (enable gremlin) @<:@default=3Dyes@:>@=
])],
default=3Dno


File src/openvpn/crypto_mbedtls=2Ec:

http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1942/comment/8479785a_d94bdfa2?usp=3Demail :
PS2, =
Line 846:     /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG t=
o avoid unused
comment is now wrong


File src/openvpn/options=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/ee61e51a_53c078db?usp=3Dem=
ail :
PS2, Line 4941: #if defined(ENABLE_SMALL)
`#ifdef ENABLE_SMALL`



--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3f96cd1c3488b558b8a5975=
94d99edcba1214d27
Gerrit-Change-Number: 1942
Gerrit-PatchSet: 2
Gerrit-Owne=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Comment-Date: Tue, 22 Sep 2026 13:39:38 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: Yes

--8VLPcRTsdTM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld has posted comments=
 on this change by plaisthos=2E</p><p>Patch set 2:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1942?usp=3Demail">View Change</a></p><p>3 comments:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File configure=2Eac:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/22b=
16a8b_32fb6cbe?usp=3Demail">Patch Set #2, Line 134:</a> <code style=3D"font=
-family:monospace,monospace">	[AS_HELP_STRING([--enable-developer-debug], [=
enable developer debugging support (enable gremlin) @&lt;:@default=3Dyes@:&=
gt;@])],</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">default=3Dno</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/crypto_mbedtls=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1942/comment/8479785a_d94bdfa2?usp=3Demail">Patch Set #2, Line 846:<=
/a> <code style=3D"font-family:monospace,monospace">    /* used by the D_SH=
OW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">comment=
 is now wrong</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fil=
e src/openvpn/options=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/ee61e5=
1a_53c078db?usp=3Demail">Patch Set #2, Line 4941:</a> <code style=3D"font-f=
amily:monospace,monospace">#if defined(ENABLE_SMALL)</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">`#ifdef ENA=
BLE_SMALL`</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">change 1942</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f96cd1c3488b558b8a5=
97594d99edcba1214d27 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 1942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: T=
ue, 22 Sep 2026 13:39:38 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--8VLPcRTsdTM=--


--===============7895446566029100257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7895446566029100257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7895446566029100257==--

