Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9278DC5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sDhuFKNyoVOPtp3Geh++GnPbijFirR83s21Si2FqIpI=; b=GhkrTro7DZZC+bnLogryzLqer1
	XbPX6w4kglcm4rKdKG43r8yiZLXI20pmjJDUMGTrD7vq5f2SxNX5fE63K9KzaaHm6vWiQ758wGNp0
	iBmIVQYxovCnz7wIsCbk7O73e+TOQJmWdA9nkG0yKUjlyEuWwP2Huy2PHNjIpiA56POM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyXKJ-0005LL-Lg;
	Mon, 24 Aug 2026 16:15:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyXKI-0005LF-Jy
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:15:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hN0i2YcXFJiy67j4wTdeuh+94sqjXn52vj02xxNZkaI=; b=ZgOb7F46wuBCX089QyzloKkAOd
 SHrh4C+z3P21H+J1lS3UbMMn9IrTvi51g2M4LOFMQLOVpYRaQQKTJ3oo8AYF9fUnN7kJo0e6XTztw
 X5nvvO4WvT0DV41DfrRB63VjjAU67TvNFrs9DWHQWpCe0+yNZl9qB6XM6MWAV79PYCdg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hN0i2YcXFJiy67j4wTdeuh+94sqjXn52vj02xxNZkaI=; b=S
 qpcYG6mrkvEJIpY2G4xLFPFA7sxraz01tShFkVEgkLu+huPpmFYSUTJ5M7wW8CSr3RSC2Zg159Jdc
 5h1X4FnYFVLdl2C/pGr2ZdltNKIKAWPFeGvxjtpAzTWsgaVqzQLGs4ODXkBNkrBD0jFPLCXXcJ4JP
 97TxOL+0FgeDPpaA=;
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyXKE-0007Mc-OY for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:15:08 +0000
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c1c50c1e29bso598710466b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 09:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787588100; x=1788192900; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hN0i2YcXFJiy67j4wTdeuh+94sqjXn52vj02xxNZkaI=;
 b=PfEc6JZxyognK7HMu0/ICL/U+csz1g/llRCwD12duxhd6fY2xw+U58ny4Ou3nSrZRi
 xLgB3gJmjz2kxGK9gMOLCXI7Tts5RGmkjfI8FL9J2ON8e2ywBGbBQP3k6lk1TO1p4ibx
 iTzMFTPl8p2QTPlT55kOlSCCEyYvKLT62Kn9SvhO4bILNSGkNxPtiqQrb9D8EksvQ89Z
 L8q6/26r0najCM+UN1RxYNLrlwCBe2PPMz8DYEIZwKRFrwWFA9FPtp7+XUsfTHc1Zxwj
 JpA3Rnm7sAgQQJZtEfcS98ItUSadC/6/gMI3u09AdjtYtyMS7/h8NroOdNg5deUWmdbS
 iMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588100; x=1788192900;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hN0i2YcXFJiy67j4wTdeuh+94sqjXn52vj02xxNZkaI=;
 b=fuIYdO7Joi/ZQ8TgQnreGYtcSERZfSAcHMnffIMZkz/Wib+vyj+IBdNuRfhiBnkTIk
 C+FW/PltVpASGR8bnF1HA53l3/KPhqhXC9u0MKA6TsJuxGuAPNi40D3KyYsqvu2byysV
 Y37QMTX86vBdul/qw9r1+omxKWi38bvupCRsyA+aRJeX0NR82UZU0zC/biIZrDnOxrqr
 kDc4o1QxzHtocSRKeoHEWbp7/QUiU+Ia1UqgJSYg1Rq+VVRwPTbyudiuWeEAOXPa+mq1
 2ecv8Y4xgO//OvIYsw/f5f1ROOqu2oprbCS+9O+c5Dpe01T7KhaPCIp4xBwBF+2jctFp
 6+aw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpgU8ZdhmgZqX0EURycXqjyIgkNiQuiVl15cjVowwoBcFyCJjllG9V+Er6KnK1mGJLEpkSN8YgG8aQgP4Md@lists.sourceforge.net
X-Gm-Message-State: AFuF++kMHaVnZFiomgpDVTofO2HTYxNjLdbdc8WEsQZMo/XyF4HSdHwY
 gPQc2I2+K4kxhOPsS5Kh7XYwyohGGiAN/ZxMBsLbG2sTGZyKZDdT3o59XQ+VSMruZLlpYnhzcQy
 rflEThoqWqS0MorcdzI7TQeDQhoK9yxO6ShvRGRSqhK6qEFIa+xWMiEebSgD+EJYlaGKx
X-Gm-Gg: AR+sD103p+fYJUoCqcVNSch6IWWOQQTosKhonN/7sko5YIVsXljMpEtrQ9I3xZajK6S
 OpNTmwutBxbUdMU8JfBSiTgAItCXTZUaUpGhvvbOngZV1uua6TyM2Niu3vX+dzW3EFXpaeFpL5g
 /0VIDPRUZ1LFRxLY0URI9f6XA73OlVo9Nm/1f+5CKKor0GxoJ8MQc/w2tUm97cVacwkDaG5L29x
 v2YgBaIvs70zY+Ha/Fwr4G8NSxNN4xBJ5/tdbBaY+MAG44SVAn2dJm4Af3Dh9rox9Mew8923bfK
 QBM84H2mKIMtbnLE+xbXds6rwVgls75nta1XSEhBMM2Woj1TN80lYbDp/1sfrtsg1dgqcoEAer0
 Hec1rjB82q4Bw86XcfWstyMXeEzbetK/vJTRO8Se0B28Q7JXDZRIfari38vDh8+UT1YgHm5OD86
 3s9HtTjJdY263unASOVFdtc2k/bFkuJyh2rSdHeW9S5qb/dVWDmgZ+V0wipMmmVyduxgCHXtBmD
 5KZ4KCH++m/LtS75ByYRbxTa/Cq6UMIPpEFUQrHED1G7yzHP08muKtb762o0FeYYKYtQLx9FxPY
 8IeTDxQegQ0ExJ1xArN/JAHEpbRoPfVVewXEIGkbGNrKS0Pjs2I=
X-Received: by 2002:a17:907:7b83:b0:c20:fe93:a86 with SMTP id
 a640c23a62f3a-c246a62b495mr3471403566b.18.1787588099391; 
 Mon, 24 Aug 2026 09:14:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e02a8fbsm13499727a12.13.2026.08.24.09.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:14:59 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 16:14:58 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I395cc722d53201d775c20ae3cf9d50149bfc90ed
X-Gerrit-Change-Number: 1863
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1863?usp=email>
X-Gerrit-Commit: 8a2da4f9d45f55ba898c82bf430135f28ee802fa
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 16:14:58 +0000
In-Reply-To: <gerrit.1787570563000.I395cc722d53201d775c20ae3cf9d50149bfc90ed@gerrit.openvpn.net>
References: <gerrit.1787570563000.I395cc722d53201d775c20ae3cf9d50149bfc90ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkkzOTVjYzcyMmQ1MzIwMWQ3NzVjMjBhZTNjZjlkNTAxNDliZmM5MGVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9c0d1d19350637ea641cea266c3c748cbc3546d7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyXKE-0007Mc-OY
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_win: Remove
 unused dco_start_tun declaration
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2246231883705194785=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2246231883705194785==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hRKLN+eKhi4="; charset=UTF-8

--hRKLN+eKhi4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1863?usp=3Demail )

Change subject: dco_win: Remove unu=
sed dco_start_tun declaration
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1863?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I395cc722d53201d775c20ae3cf9d50149bfc90ed
Gerrit=
-Change-Number: 1863
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Mon, 24 Aug 2026 16:14:58 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--hRKLN+eKhi4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1863?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1863?usp=3Demail">change 1863=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1863?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I395c=
c722d53201d775c20ae3cf9d50149bfc90ed </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1863 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 24 Aug 2026 16:=
14:58 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--hRKLN+eKhi4=--


--===============2246231883705194785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2246231883705194785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2246231883705194785==--

