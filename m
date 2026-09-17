Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6984C982CF
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9FTiEugWia8yt7g+5DFH1eCL7NyRb0A31Xusil5f5Q4=; b=Orlkrqspzl4Wf3zx3YTW6+13HL
	qyfYtKDfND6WnK/zuIDlNXxvPLJ85v4DSV6mApoWupIZ6T+V8rZ6KLxUM3TrZ203VIYIJeInYinhR
	XTSMlc4DAq+2DIzW+RrRFojtByWFLtJydkOomwSOsxlbdYBLj7dz0s76yd/0Hpe/0jW8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7Bxg-0000UX-6Z;
	Thu, 17 Sep 2026 13:15:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7Bxe-0000UJ-Pn
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:15:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ABBnm964kbHERhTgPHABo4af1jWjjNBJTUuEYQJwQCo=; b=H1jkCshVnp2W0uBeFUlvHCxfln
 OfFTbS9E3Njc8t6Al5u5uQViOLOpwiT8pqdcKl0tC1EaWEYj+6dPKBV5xIjrl5WWs93IZ5tBCTeit
 hBjtVaHnrM69TWb3aTFjNpYo/MZzj/WIzjbgjLD6IOJ64nn4oNpT3N5otwIuKv8nGTA8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ABBnm964kbHERhTgPHABo4af1jWjjNBJTUuEYQJwQCo=; b=E
 uofKU8AFIKBxIb4huWZ3AXTgJqGqiC4fAlEvfGc5ySNPKcNwykpjdYCaKm3/Eka39YbRlAc86q5V2
 6kQNhWtupPh2BSd/6jvfaMHshbgfHtwlQZ4mT5jsQYX+pVcNA1QQCRSu5sfKHTdb+v8dOk80+PqxD
 ce1s/RHGFxSJtl38=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7Bxe-0007R2-5j for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:15:35 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e66390995so4514145e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789650928; x=1790255728; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ABBnm964kbHERhTgPHABo4af1jWjjNBJTUuEYQJwQCo=;
 b=cN9S3vtuUlCkTqh7MhX0J9agPmlX4Z4BPtBeqi0jDiRzoZRF/+A9O6KYIby9ZgVmcu
 6RZjIdV8QbBmny3scgrZupoBSY/beB4vudSOT86+HxjVvfsEFb6HLHVpERfj/fIiS0HN
 Q63X1Tow3EN8YgtKkOoStMYrZdUtKrBw6otLcZ5mjyOafYXJZJJIu/Lswx9kYc9cz/mK
 e09df7t7+6gnEBfQ21m3A61EBxWXNo6LcNdgIdllEzZ4dB5KTpzYai6edPP/xs+oGvBx
 rUPLY3vVXAlZr3CwFoHh0jr3FPtXL5/WE1hJwESx6GA41kxq5hwDsvBWrxdmTIaF1nA/
 sxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789650928; x=1790255728;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ABBnm964kbHERhTgPHABo4af1jWjjNBJTUuEYQJwQCo=;
 b=LFbZNTyjoZM/A9xmJoYFSw0TW4FjqCdPiylHwfoELMhRYfMKtaJg9xFodKzeIy5lL5
 zxGuZXzYCEzeH+P0hnMmWTu7S1JNbqi3ZSY0JQbV46q3LPSSTkefR3i7QhEepvtyP6MS
 T6/l9GNla/2o50N40+axBdoCu5hWhhtcyW2gZ4c74htYEJa5CH670u1csR+Lg7+7JmhY
 1moVPfmni/kX18MjKaAag147ewtTan53qj/3c2f8UlpnFJF+w3AFtzBn87aZafISnUV8
 863hmp5soVSQxvVt4nC/RT9p/FQ/u9Nl3Met3zYCrIEcO5d9ZgE9hU+SjtMpFLuFfIMW
 eK/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEWgRyams+jyKh7/kvYgv14hlntsSVzAGVQLVjY34foCKalUajvBawBsEmAgwB2rfi4936WDLa+zQEL5Y/@lists.sourceforge.net
X-Gm-Message-State: AFuF++n+kYSIJtYgprD5B+k2tAT4GHDnbYrZHUyT+yH7ThnzDYZOe+k3
 PM6bbgkRA5IDmve5mHYEEuj2fvFXLd5OfBZU033ERYOzW/9WMb42e/mZXWtxoU2M4jQOeKorqPY
 i5mAvUTQItW484WxMhrZQD1scZzHThbZRWQXCUso3b4C3A2fflVrf6wa4vlSPBXXf0d68UfOJ+R
 ommAfYQA==
X-Gm-Gg: AYBFou1JuAkZU1wEFzUgGizpJFudysFYhu4qJ30pF9KbAKoHiWj7E1ytsVMAoSvTmbG
 7DiUkg4p/uAZK3IhXomkB0sSCCUXJVHDG7k+RRpT4lcDT5N39q8xaa/jZs1UdI9xP/PmiouY3qY
 BAkJP0lx1uuQpreBhAU4eVYYCeAaFe6jYnB5PX0VYwu0+9YEHaVfVBWXTSv2sVHUyaHUxgj+UKd
 9tcBzRlcs+iA6r/hiHFzGBs7ML9z07gk2iGYACiCBRze1b4Hk0jh9zffrtIC+K64FGkq5XehdDX
 tx2S/VnGQm+kqqCcn+RO5oW8Nh/pq4zSu0RhJILkGrDSndrTJwAsxvZo0gCzTuJBwfMUyx9yvCK
 CFO6EmG+RcwbPh0NYxL3M7IaprxRFR0VmZ8TH6uYloJ92ICGNO3nUNOpr52p63isW+HxuIBVak7
 WUddnD51OoCJur3Se6mWNfazqlhwebAVwTR2Mm7jS6eVG4vrtiaXdn0kyDVE8r2sEPHa8xgcMSG
 I/qTpfYVLDDJKIMHb4VKFG/Wtm2OU7UOZYc4fg/RaU0MYD8w/zrqwWxUfErnK4WTctNsULLIUJJ
 bs/IB+q9d7jkDhpj9fGo5J3Z6iBTWn+SUIJHSNP8s1xH2rBo9hXMnd7hSVaBHQ==
X-Received: by 2002:a05:600c:540e:b0:49c:fc6c:be03 with SMTP id
 5b1f17b1804b1-49eb732c347mr74353785e9.26.1789650927445; 
 Thu, 17 Sep 2026 06:15:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf4161fsm14244757f8f.34.2026.09.17.06.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 06:15:27 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 13:15:25 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: 5fc002eff7bf1be5478dae6e28a336f1bc904b06
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 13:15:25 +0000
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <48d18acb86595001cbbb0e82699bbb349ab32fa4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7Bxe-0007R2-5j
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Measure probe
 RTT for candidate-band selection
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7598494003328570874=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7598494003328570874==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="15zpTf5hgFk="; charset=UTF-8

--15zpTf5hgFk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1748?usp=3Demail )

Change subject: oob: Measure probe RTT for ca=
ndidate-band selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 26: Code-Review+1


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Gerrit-Chang=
e-Number: 1748
Gerrit-PatchSet: 26
Gerrit-Owner: stipa <lstipakov@gmail=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Dat=
e: Thu, 17 Sep 2026 13:15:25 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--15zpTf5hgFk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 26:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">change 1748</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I375a4174=
9060b7d006647bc27002c55436c8a8bb </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1748 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
6 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Thu, 17 Sep 2026 13:15:25 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--15zpTf5hgFk=--


--===============7598494003328570874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7598494003328570874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7598494003328570874==--

