Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88D3C561E6
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DnDMuuP0UuD1NcOAkBqfupHAItSpQtcZ9tg7tNvY/C4=; b=VRLLRxoxW/TBxJlPQwz2dypVs3
	GtvYcaLyr8QldK04MH461UiG4g2EbPHnw8uRlsTHnbRaJGwJOOro0AmizILKRplIP7fGyzKPyE4Ws
	s3NXfy7OmJNYfl+2tfgrPEVsUQuQXh3vqt4m+h/p0AnZ5M7NODlloelJoQG88lela28A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrdFx-0007rt-JN;
	Wed, 05 Aug 2026 15:10:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrdFw-0007rm-6m
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 15:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KKkx/P+dogsdt1lnoPJuo+WEbX1gu0laNERkKJ6Xe9M=; b=UZyrmLksRIdnzPkzOkWvlolbaS
 MBKB9w7xnb3dq+JWCexmCoj7+VERyxmJ4otXFtRT3uis3GfhNHD0ZYNgxZEvZ/XjjRYImdkUcTxuj
 TTpCQyBUO8I+3zX1tFKHiQygK9v8QFAf2QTAXDnuQ/f0v3GIESbIDWCz4GkpomHZ+Yl4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KKkx/P+dogsdt1lnoPJuo+WEbX1gu0laNERkKJ6Xe9M=; b=Y
 Vd/B2Fd4Y7dpqD1MqTO3oBxvTGCro9b9b15Bs0p0N4oLITgHLZarrVh/uC9Awqsw4C/DbfvBff+CP
 QwQ3z8mtSxvpRAXgLYoRNCb6wAiNjO8YRuzjnFOdryzGQgLh8ah90cyDj71S29//IOU/rRs0Hbg+G
 l1K12oT6DEwH2jaY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrdFu-000292-48 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 15:10:05 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4956242332dso8740735e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785942596; x=1786547396; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KKkx/P+dogsdt1lnoPJuo+WEbX1gu0laNERkKJ6Xe9M=;
 b=bDe+ynNxNAzv7a8Zs/YE+gUroFJkHiBRo3NfUcZtFNel/2Heqm2X0RF/SihZVnxW0S
 IDh0ocLL6spveudbhA0fZj+ccMTa9JmZOyfbLIQkgjFrWJ/GDeT3lRKED8kjDuomUiQu
 4tTly34qBuh9znpz20x5ynAhph4swP5rJgOyc3LwBqf4NWN+4MC+C6bBFss/HAz5sMkv
 To1yA3IKVcsd/ZAP6arDuLwvFRsGmjS65TzyxecINmF+BxGLLf7F/n69qABN3mF7J4Iu
 ZbZ/s4ylpcx+wNxkQ/HiZkVFW2j/00KiLyJ+KSIPM67b81uXh1jZ9p5PflNSgkdkad+3
 SLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785942596; x=1786547396;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KKkx/P+dogsdt1lnoPJuo+WEbX1gu0laNERkKJ6Xe9M=;
 b=Ng9YR93BOpxlAefiod0Y/uRK2Lpz3TfTjMXPHW1dd0PVzaYAAfrkgcVoG+xQhNXxgq
 9Ln61ugSFuFBaPOj2vUFu5+DJ+u0sjyiAR8wdlk//iDPSdEqAOy/+rC7MXlS/N0PNsIe
 cyCeTMrmG0+CG6E8t9c2Pqr1/vL67shyxDrvWisrp7umiGShmQHflw3gcxZPZozrImrB
 sTHDCTcOEQCc/hFs2fezdcZJs7sWizI4KzdEnwOdxEpj5WNMQESJ1IE6/JxR254uh7b2
 fhS77s1c6t3uFensA/fVf54ezhekF2AOyMUWFr7eTVplNP9ByPJok37InytK8ow21f+S
 k67g==
X-Forwarded-Encrypted: i=1;
 AHgh+RozO6zwKTohiZpUqAr211Mx7Jg5euFtUCxut7DjkYhQvVNLrCSvFFoXjsYH2Tmlt6U3LtTjgyJgMifZ9mqU@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxOEaqGFK+nbjBj/APHUqD44k4+mVgtgGjq8JikCMvs9ZNVGbbw
 TDc/flhVIssr2KLFPTu6xjIsNDAI9T/vgVAVtnqX16IyOyckLsJoJIwRGVssl1Bis/+Uo7R4BHF
 6yX/t1C5hfDEj+vlAFwpAE5I3QVZwat2/H7KuspAqCCxi1nwA80lTZ22kiKWi48Znu1hVASKfhM
 lZ+ns0Xw==
X-Gm-Gg: AR+sD10AZlUFNoDmn0d2l6Lcz9cinSpidhP0U8J9XQen9uvnBFWUDu33x68PfjdDrTi
 b1j2/XfhK0EGnZajyVmzXonnAQ097KXjJRpvs2v1nb97otPN3APHtSferssDu8XmEyTx1hzBZ2K
 U7QT+YGfWrYDwHKzf2sVJYdGvpdvy6WGt0WxlsKL2qv31IfKAgagcGmhzcVh5ktMuYa7B2+fb9x
 lzyrZSWLcBWjmRkVbZ9AG8ZODC2BeTIaYcdQ+wSXwCMnXV2U6elWP0z79Kbhow5F4zFucl+QlnQ
 kbFLa8jh2GQi5qe2A1jCXzonSMGipjViPrYzgSrVpTn3ILl9EI4c/1Fn6RxMY8RM/0YRunuoL2B
 qwvzmRvtV2qcYB6UuKMrxosgirsC+phbSgf44qSQ9JHvbjymCpchycV7p3SEpRbteYCd9KHb22W
 PX/IlC4woXBXjTcgff0F4OK+gp6tKa982ULRB6tp2FJyUuYt0ovdLcOkpxqAveBrRuW8Eansm1A
 PhEgjOZebhEAR/wfT20TI8QyzUegeeX/dusIHjqcOgFMGyYu/xHmgukm+0HXFz2uw8bL7ftiPxc
 ou6gBYOociQaruk5royhJoHoMYCOYCjCzRMy4CYimJTu2eA0fV57hGM3gF7sfwA=
X-Received: by 2002:a05:600c:e548:10b0:493:f0f5:f2d7 with SMTP id
 5b1f17b1804b1-4994e71af1fmr87050815e9.7.1785942595750; 
 Wed, 05 Aug 2026 08:09:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fd4c33sm168134075e9.8.2026.08.05.08.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:09:55 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 15:09:54 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
X-Gerrit-Change-Number: 1837
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1837?usp=email>
X-Gerrit-Commit: b55b3d3d525662ec8f138a9ca86592c3ba58c33b
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 15:09:54 +0000
In-Reply-To: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
References: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1OTMxNzkzMDAwLkk3MjgwNjdlZjA4NDgxYzg3YzdiNjkxOGM4OGViY2FlZWVjNDY2NTM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <043fb74b82545e510750572b36279cbebb1f201f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrdFu-000292-48
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Reenable xmit_hold
 when using p2p tcp-server and tls-server
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
Content-Type: multipart/mixed; boundary="===============6557459780311372522=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6557459780311372522==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J6lkOOQzUcs="; charset=UTF-8

--J6lkOOQzUcs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1837?usp=3Demail )

Change subject: Reenable xmit_hold when using=
  p2p tcp-server and tls-server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1:

(7 comments)

Commit Message:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/238d7783_0128ca67?usp=3Demail=
 :
PS1, Line 7: Reenable xmit_hold when using  p2p tcp-server and tls-serve=
r
> spurious whitespace
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
37/comment/51d08ab2_e9cfffc5?usp=3Demail :
PS1, Line 9: Commit 619c3e9 chan=
ged the logic to only enable xmit_hold only
> doubled "only"
Done


http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/321fc139_9c01d6f5?usp=3Dema=
il :
PS1, Line 10: when c->mode is CM_CHILD_TOP=2E This works for the --mod=
e server
> Remove "the"
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
37/comment/fe050e83_ab706fd1?usp=3Demail :
PS1, Line 11: was probably done =
to allow this to properly work when the server
> "and was" ?
Done


http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/f162c472_acb77db8?usp=3Dema=
il :
PS1, Line 12: is listening on multiple sockets and options->ce=2Eproto=
 cannot be
> missing word after "be"=2E [=E2=80=A6]
Done


http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1837/comment/6d65ee1e_58880f3f?usp=3Demail :
PS1,=
 Line 15: Restore the logic for p2p logic to avoid both sides starting send=
ing
> doubled "logic"
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837=
/comment/3d426e9f_ea3bdeba?usp=3Demail :
PS1, Line 16: reset at the same ti=
me=2E
> "resets"
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1837?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I728067ef08481c87c7b6918c88ebcaeeec466534
Gerrit-Change-Number: 1837
Ger=
rit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 05 Aug 2026 15:09:54 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flicht=
enheld <frank@lichtenheld=2Ecom>

--J6lkOOQzUcs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1837?usp=3Demail">View Change</a></p><p>7 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/238d=
7783_0128ca67?usp=3Demail">Patch Set #1, Line 7:</a> <code style=3D"font-fa=
mily:monospace,monospace">Reenable xmit_hold when using  p2p tcp-server and=
 tls-server</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">spurious whitespace</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comm=
ent/51d08ab2_e9cfffc5?usp=3Demail">Patch Set #1, Line 9:</a> <code style=3D=
"font-family:monospace,monospace">Commit 619c3e9 changed the logic to only =
enable xmit_hold only</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">doubled &quot;only&quot;</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1837/comment/321fc139_9c01d6f5?usp=3Demail">Patch Set #1, Line 10:</a=
> <code style=3D"font-family:monospace,monospace">when c-&gt;mode is CM_CHI=
LD_TOP=2E This works for the --mode server</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Remove &=
quot;the&quot;</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/fe050e83_ab706fd1?usp=3Demail">Pa=
tch Set #1, Line 11:</a> <code style=3D"font-family:monospace,monospace">wa=
s probably done to allow this to properly work when the server</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">&quot;and was&quot; ?</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/f162c472_acb77=
db8?usp=3Demail">Patch Set #1, Line 12:</a> <code style=3D"font-family:mono=
space,monospace">is listening on multiple sockets and options-&gt;ce=2Eprot=
o cannot be</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">missing word after &quot;be&quot;=2E [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1837/comment/6d65ee1e_58880f3f?usp=3Demail">Patch Set #=
1, Line 15:</a> <code style=3D"font-family:monospace,monospace">Restore the=
 logic for p2p logic to avoid both sides starting sending</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">doubled &quot;logic&quot;</blockquote></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/3d426e9f_ea3bdeba?u=
sp=3Demail">Patch Set #1, Line 16:</a> <code style=3D"font-family:monospace=
,monospace">reset at the same time=2E</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;resets&qu=
ot;</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail">change 1837=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7280=
67ef08481c87c7b6918c88ebcaeeec466534 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1837 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Wed, 05 Aug 2026 15:09:54 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--J6lkOOQzUcs=--


--===============6557459780311372522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6557459780311372522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6557459780311372522==--

