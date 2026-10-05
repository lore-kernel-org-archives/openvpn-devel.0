Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E9DCA5FF0
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RIJ9SZD3GzTkwvSMI0BIM1CLMfIm77n4If0hpVBhcDo=; b=ipim5sVdTc6GkU9mBPxIu01G17
	9uefUvLAHnKxecraL7MhmMJEGhQ/ymg0WL+3wyRxVurBx4fzeJQt25lVChseycOh3UbBYa2kcGxI/
	8XFYWWaFx995d0tvpU2NgeJTux99JKziEI3jkHtnBKJ9VLlta/Mni/G52TwZRQm0agiw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDi8E-0007XS-Ox;
	Mon, 05 Oct 2026 12:49:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDi8D-0007XM-SA
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 12:49:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IlxEXi1iuIVJXWbHDQ6mdXQPKsBk+jsmkvJAq9ZLoq8=; b=KSXqaxLq59fj8HDbZsgHLLiWut
 OK6ToiZ3OavZnpR8OkiZbhJR2bH+LiLckz7NGGxJ+UJC0pRyGFRwHYO9RH5wxA1PHyz1qm6Dsxb0F
 OVmigc5vzJf+MGe7IVlX+w+YUudjAtvYLUYLadphOlC4uSsMHfRTtXkbdINdMhHnUhns=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IlxEXi1iuIVJXWbHDQ6mdXQPKsBk+jsmkvJAq9ZLoq8=; b=G
 5iCvpWrtCBiV2jGC3WaomX3tIX7I/+NSgC0nvo5rYmdSqipw3uTLkw8l4V0CCJhZW+5Zr2XTrZbL8
 HXCutYd7Pqdg7ZADkDvKZk/bgQSezKhI5SzZcO5wfV1oL64RSJ/NdxDU1uNpdHL+u0MRqFw3rmH76
 fDQQJNcw+w/luomw=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDi8C-0007Oe-BT for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 12:49:25 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48b0d19cf7eso626744f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 05:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791204558; x=1791809358; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IlxEXi1iuIVJXWbHDQ6mdXQPKsBk+jsmkvJAq9ZLoq8=;
 b=UCrHQ5FO9hN268lNJxqMnK3+ArA3eiAh9eGHOmZONRyztxHq5sXvtKA2ElRXQj9Pf8
 xLaUOWpshHGFqUttDDFqes1czIEf2UBvNAOx4YhGl5UPyuur5HsMwZaCSN4AybCK0XXn
 prgU5DR9HvR8JFToFlyNv1CJNcYbSZgD76ooP9upJkVsLVUmaLncQqiOBmp84/c3Df9H
 Qe0NTgXafErbh1XGm26SfnhD0dzwAfhtF7w6hlaZyx2KkL3SydKEhJasKtXTKlv7FzVU
 OHe58+YI0MJiXYsr4YEwed1uxMboNxo1eWJ3T848PxzOOd5Gj8TdvilBgf3jzLgKsx1U
 ceOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791204558; x=1791809358;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IlxEXi1iuIVJXWbHDQ6mdXQPKsBk+jsmkvJAq9ZLoq8=;
 b=ffF53UI3QwUqGye4Rng49cl2nl7Ig+862IIysrEaErmyOrKdvVozRwfjpzzNXKy3p6
 N1Am8hUKLBkAIbWKojAdWjbuGz3bpcNyA4G3/NROttvUdv8V16XcA80mAPLrhZQ17kCo
 UQxNtwtFQQYIaYRT10x1wVT15qJtDJMDJUOMbNLpQuuBT/56MbaYdHr4u/IC75t2i3qm
 DpaGnAuMMqCwAEZa1MkIy3XdXaGxxvpyUy5QXHgfrFEaget+ggbX+qXlPUt3RbKW81b0
 HLs0PHPUIB2nNQoFvEUFYXpABNW9cjMne2IgaXeDQ1w6PG6/1jP3FOUACwSdE6u0zESC
 tgWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzh5yFSSVD7Z8Cg7sttdqWpdNe4jHa8Q1wzHMxyAYDzrk455RQ0f0Vgvu0XMzGCHEzGD/WgOHXXxUkEdRHz@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKmKVqIBx50i7sCiOzj1jL9utFUHCGfm0DLvsqq50+ITsC1qbQs
 v1g8ihGSkhHFLbb6GE+WLDC0b74n7Y9EFLz8YIgFdqVJY8K9VONqBDPPnNjk2Sg33gFOl9Y1S3Z
 pp3hrQ4nOV0Jy0WcigXRbI4ohCqw9FkmlZ97jdi1Co5V3GZAAGnCm41BNP2MmotZBoXzn
X-Gm-Gg: AYBFou0zr7L0cCiQDvNRXEuBxliVyeDnTNYWhyhHLjoNFqGp26HVVTSvrxmU0NzzdMG
 aa2YSASBOEAZ1iEedqU4x5wXlTrNTKCF6ySXTVtt4uFMc2obSL8DzkmsFsVON7yTqrVFPVMTAZP
 9jISVbsoE/exgO1MwoFkrI+pb6suVMFmtxdq9wDr4C0kQR7xrXHN4+QwYPaxk9K8I5JEM6J1jTx
 Vm16ZvV+APKlS77oI/NzrreBQP6leyUcWe2Q3DftLT2AlPLKoVhe6zNZbRTyEgt8u2/tmEaogdz
 yvZVP0Bozp3YfnhH9HAZPHNzWYn3DnEq8jP56U8KYeXCZZoUmPxjJffBQkr4dSfETEUlcZPqF3v
 dxBhqnImeZNpwO8jg9VtOeNeehUdOTDxb7L9UZRjCqW2T4sSs033xFRtXMgrCB7r2diM+WVLUOy
 abIY5Z4KYH8e5IxKILBrqm9CYoJQiqEoXU/HvwY3agFW1YbmB9Rgh7tdG/TZcqFszjFt4mDrwLj
 hDQvXX/2JFlUgfithT9w6ke6MNv5YShWMQZ+0F+3TpA2LmrW+gtQjjGJVuUWhH4THIwOXLOI8tY
 GMXeWPVu4gt7VsOJU5GU8B24YfycMchKpBxhpDDtoVaehT87dWrPDD8OpBlR
X-Received: by 2002:a5d:54cd:0:b0:487:1577:9e33 with SMTP id
 ffacd0b85a97d-48b068bf670mr21040146f8f.25.1791204557621; 
 Mon, 05 Oct 2026 05:49:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6227fc19sm3340632f8f.17.2026.10.05.05.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 05:49:17 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 12:49:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71
X-Gerrit-Change-Number: 1961
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1961?usp=email>
X-Gerrit-Commit: d9769b4275aee5ef4cb47fba767b0327c795dcc3
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 12:49:15 +0000
In-Reply-To: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
References: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkk5NTc5YWI5YTNmNTg4YTM4NDFiYjkwYzlhNGI5MzBiNzY5MGUwYjcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ba3d1f6563628227e0e7f022b9d43c3dd1617a98-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDi8C-0007Oe-BT
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mbuf: don't count
 dereferenced items in the queue length
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
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5044987470189355819=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5044987470189355819==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oPzzEvnhu74="; charset=UTF-8

--oPzzEvnhu74=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru, plaisthos=2E

G=
ianmarco De Gregori has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail )

Cha=
nge subject: mbuf: don't count dereferenced items in the queue length
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(=
3 comments)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
61/comment/76b1973a_0b9390ea?usp=3Demail :
PS1, Line 23: what can still be =
sent=2E
> I think this not 100% true because unless I'm misreading the code=
 the `[live][hole][hole][hole]` cor [=E2=80=A6]
You are right, and I have r=
eworded it=2E mbuf_reclaim_head() only advances while the head itself is a =
hole, so with [live][hole][hole][hole] nothing is reclaimed and len keeps c=
ounting three unsendable slots=2E 

The comment above mbuf_reclaim_head() m=
ade the same overstated claim, so I fixed that too=2E 
The corner case is a=
lso covered by a new unit test as well, see my reply on line 218=2E


File =
tests/unit_tests/openvpn/test_mbuf=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1961/comment/75a2c04b_386684fa?usp=3Demail :
PS1, Line 150: 
> Wou=
ld testing also that after an extract, the reclaim skips a hole and stops a=
t a live item, be usef [=E2=80=A6]
Useful indeed, test_mbuf_extract_reclaim=
s_tail covers the reclaim running to the end of the ring, but not the recla=
im stopping=2E Added test_mbuf_extract_reclaims_up_to_live, which builds [m=
i][hole][mi], extracts the head, and checks that the hole is reclaimed whil=
e the walk stops at the live item behind it, leaving len =3D=3D 1 and mbuf_=
peek() pointing at it=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961/=
comment/b981d9b3_368cf2fc?usp=3Demail :
PS1, Line 218: test_mbuf_add_on_sta=
le_full_queue(void **state)
> Is this test not guaranteed to pass if `test_=
mbuf_dereference_reclaims_queue()` passes? The end of t [=E2=80=A6]
True, a=
fter the fix mbuf_dereference_instance() reclaims, so by the time that test=
 does the add the queue is already empty, and checking that it accepts a ne=
w item is what test_mbuf_dereference_reclaims_queue() already does at its e=
nd=2E

Replaced it with test_mbuf_add_on_full_queue_with_holes, which build=
s the case you pointed at in the commit message: [live][hole][hole][hole], =
where the reclaim can do nothing because the head is live, and checks that =
mbuf_add_item() still copes, evicting the live head and taking the holes wi=
th it=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
961?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comme=
nt
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9579ab9=
a3f588a3841bb90c9a4b930b7690e0b71
Gerrit-Change-Number: 1961
Gerrit-PatchSe=
t: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
omment-Date: Mon, 05 Oct 2026 12:49:15 +0000
Gerrit-HasComments: Yes
Gerrit=
-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>

--oPzzEvnhu74=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru, plaisthos=2E </p>
<p>Gianmarco =
De Gregori has posted comments on this change by Gianmarco De Gregori=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail"=
>View Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1961/comment/76b1973a_0b9390ea?usp=3Demail">Patch Set #1=
, Line 23:</a> <code style=3D"font-family:monospace,monospace">what can sti=
ll be sent=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">I think this not 100% true because unle=
ss I&#39;m misreading the code the `[live][hole][hole][hole]` cor [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">You are right, and I have reworded it=2E mbuf_reclaim=
_head() only advances while the head itself is a hole, so with [live][hole]=
[hole][hole] nothing is reclaimed and len keeps counting three unsendable s=
lots=2E </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">The comment above mbuf_reclaim_head() made the same overstated=
 claim, so I fixed that too=2E <br>The corner case is also covered by a new=
 unit test as well, see my reply on line 218=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_mbuf=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1961/comment/75a2c04b_386684fa?usp=3Demail">=
Patch Set #1, Line 150:</a> <code style=3D"font-family:monospace,monospace"=
></code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">Would testing also that after an extract, the recla=
im skips a hole and stops at a live item, be usef [=E2=80=A6]</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Useful indeed, test_mbuf_extract_reclaims_tail covers the reclaim runni=
ng to the end of the ring, but not the reclaim stopping=2E Added test_mbuf_=
extract_reclaims_up_to_live, which builds [mi][hole][mi], extracts the head=
, and checks that the hole is reclaimed while the walk stops at the live it=
em behind it, leaving len =3D=3D 1 and mbuf_peek() pointing at it=2E</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961/comment/b9=
81d9b3_368cf2fc?usp=3Demail">Patch Set #1, Line 218:</a> <code style=3D"fon=
t-family:monospace,monospace">test_mbuf_add_on_stale_full_queue(void **stat=
e)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">Is this test not guaranteed to pass if `test_mbuf_=
dereference_reclaims_queue()` passes? The end of t [=E2=80=A6]</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">True, after the fix mbuf_dereference_instance() reclaims, so by the ti=
me that test does the add the queue is already empty, and checking that it =
accepts a new item is what test_mbuf_dereference_reclaims_queue() already d=
oes at its end=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Replaced it with test_mbuf_add_on_full_queue_with_hol=
es, which builds the case you pointed at in the commit message: [live][hole=
][hole][hole], where the reclaim can do nothing because the head is live, a=
nd checks that mbuf_add_item() still copes, evicting the live head and taki=
ng the holes with it=2E</p></li></ul></li></ul><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demail">change 1961</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1961?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I957=
9ab9a3f588a3841bb90c9a4b930b7690e0b71 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1961 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregor=
i &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Mon, 05 Oct 2026 12:49:15 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: N=
o </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--oPzzEvnhu74=--


--===============5044987470189355819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5044987470189355819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5044987470189355819==--

