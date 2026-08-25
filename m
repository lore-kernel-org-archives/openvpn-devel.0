Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF320C61DBE
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5LdrJPSyuMRwBaiwm6te93rKodj+Zdd4FscojibUMOg=; b=JeEqgRfalX8a0h7Gzj8S1dSQ5f
	hiX2VBSfNjeLJX/LFaCiFMNOJE4cyRIHnyYm5k/btpZUDY+n06O5SUSgkhC1MVKLkFE94A9C4zyPV
	IVcGCRjN3i7sO0X50hg7DJIRasoqIJUXxMESA6Unw3F3mx4UJWwbjVr4jQRVYQfttf8U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytQD-0006L7-Ro;
	Tue, 25 Aug 2026 15:50:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wytQC-0006Ks-4c
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:50:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tTic4t+7uAyhaU8rnoJ6cg9TTidNsKtnpRD1UpHDqqM=; b=D1CP2nSCs2aXWirmTn/zAHW7ZE
 OjQ1UZZjiNCPjU9TFWDi6jEHm/vngQI/+PrebYuRIbAA3/gd3Ep8Vxgh7jheZrwdYOXLoUPl6ij0A
 NOmzMtfIC49qCVGkRKy2XcA1AOjI8trMNd5vHRJ2WZIQ5/F185kp35AK81cQ7MlyZELU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tTic4t+7uAyhaU8rnoJ6cg9TTidNsKtnpRD1UpHDqqM=; b=I
 Tz/asHnl7P4YzVOD0Tgi4EpXlgVokID37Zth+Xz5V5mbjhlFhhJQX9VJwq4YC04pGegHUlaJVTfqn
 a/2dgM2P5eNrn+TQDp7Ub8QUjAwwbJnGHFgYld8IBIu3KjQMw/bdNcJzyfI1B6rJlWEzWJk4HLKkQ
 N73ujXiuae/fFJSM=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytQ0-0001O7-HR for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:50:33 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso246580a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787673026; x=1788277826; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tTic4t+7uAyhaU8rnoJ6cg9TTidNsKtnpRD1UpHDqqM=;
 b=MBa2qVZPxGWxEISgr9uU/w5tbnDBCtvgIotyzrAalQYY3qI3rS9idBHw2tKqjsYzLG
 hyndhTBhx2RkYHRVvDhVAatkpaInAyQkxN7VeZBs9BnF7G9ZfDey2ImwRtA+VZJjXw23
 J5mSETnsyfrTadgdSRW1/3hZSykX1VwmjhPtW7ua8G/2WvMTprKNrUDb6J29WcYYilED
 ZDyT9BPHuZ1pHSbKGXVPAR+gqgamy5Mswd++aj+Y4IC/9lUEQ9mkOIdKRpq8t7Zk6e/Q
 EJelobIKANMDRnv9yuQGIsHaBcN/p3eH2tT9iIwoaOW3uHHzx+Ch5/5SIlDoqoPXAIf1
 WJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787673026; x=1788277826;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tTic4t+7uAyhaU8rnoJ6cg9TTidNsKtnpRD1UpHDqqM=;
 b=W/q+DJO71LgW5GjOMTnTwqS0MeTMf82rl8U2y8ht6TZV3/nEkZH9llxMp+IFwra2wn
 MYakdMozmCrPQ8WVplNAGGfPzcTuoJuxG5JzdIU6MjNo1TzyUfPtuGDQjhlwchVIGwhi
 E2rluxcJyiKtben7rlUIbGpajXK3YJk8g5Gh39WrB6xVinqiiXY4A9vFhcm3MzavledS
 bmiPoMTjITs5lrnK1gxoR7KdLpLw5ScViZ9ch1gUlHjY27Nu3oiISMlOYtl3eV4RPE7F
 eTK4Hez+PAVapN6EEwhPIcSKl95F/uApNSpg29YUW5lcc3YU8fN9Uc2f2pTgbrQaVmTF
 e6Cg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqT4VzuKB5mN9x3/dx8Gntza40Qc3+P6KqSrDFk2bzFrffENhkThFffyjED9LZAEyGLoy3O7utlHBIuDAvr@lists.sourceforge.net
X-Gm-Message-State: AFuF++nYAkIdlUPOFzyd8e+fZ94Ks8u5iaBZNeDQvDsgpFeyTV4wX4d6
 EDCwuxc1+9UEirnksL+F3QoKJ08pPBqGFHpCizws5KBEA9zENLjZ7SlML9vg5CI9gvCOeCAo4n0
 w4e7NzdyaHUbzg4tOcnm/ckF/bQibvCWzW8orRhYtcEm5N+Drj6kw9TsW75Odt8WUrMI8bsUv1B
 5UUS4WIg==
X-Gm-Gg: AR+sD10sYq+5B/7Z0e0nUA5hXO3BWcDEutPsTFQz1jd6MdO9kiBglPPQHQ2dSuGo7LN
 kYrxjLdRMCejmq9JbRZWKUswBE1IyaW9jR6UqRPuEPNpz8mGQb2aGC4mK1b3sxw0oeMmYVo/Jy9
 cO0z36lKDePj86O9f0e+kZk1ZxtMRdO7CgYMBNK1VycKwVT8ro9Hr7plE/K0XXoa1OZAS4Vmkz+
 ZWRalrCKJjOiFa/8BLeiwa5YVjfdG5U58PKrQvyd90Ro9Ncr3feNK4VEaVSdXLrvHe8bJrbiLrQ
 C2chsavtXnpWfd2ZoQI7sPZhVsWQ8cqfmG2ssp8Sl9oShgFRjc+uwrA4FU0cnVLw1JRZMtKY8be
 jLEZFVbxt0xdwNv0z7g4XGuCWsEk7xObvacLLMGUJyxuHpCnkTcWFE4zD5uMTMFA1pEslrmTvJS
 b2JrI/Om8sWllWRs1+qJ4KeBzqAxHUWS62O/H/XRneqVGtDbfRo5jCwPWF2n/tuYOSPCsw2D/AI
 Cnjvfv7Osn553aVs5cwwY53UA7Vh8ChJKwG1bdLqX6IoLuSQ+lvfV8D9ACqvmgY9/CkVAtCLp3m
 YLyOkaNcMud0bc2zc6lA4ONwNB7XVYeYw5mxep0Hbivko7GhvExQBvlP6TWVSQ==
X-Received: by 2002:a05:6402:274a:b0:6a1:f95b:8cef with SMTP id
 4fb4d7f45d1cf-6a582b1476emr32699354a12.4.1787673025774; 
 Tue, 25 Aug 2026 08:50:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de5f7bb8sm382869a12.0.2026.08.25.08.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 08:50:25 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 15:50:22 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: b60ab3c9f41d033dd44c5b0f70f23a0da11224a9
X-Gerrit-Comment-Date: Tue, 25 Aug 2026 15:50:22 +0000
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fe0af80331b2387a1d0efcadf7e2557ead49bfaa-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wytQ0-0001O7-HR
Subject: [Openvpn-devel] [M] Change in openvpn[master]: t_client.sh.in: Add
 support for expected test failures
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1521022358317240099=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1521022358317240099==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TeooaBszu6c="; charset=UTF-8

--TeooaBszu6c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1755?usp=3Demail )

Change subject: t_client=2Esh=2Ei=
n: Add support for expected test failures
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb=
844
Gerrit-Change-Number: 1755
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Comment-Date: Tue, 25 Aug 2026 15:50:22 +0000
Gerrit-H=
asComments: No
Gerrit-Has-Labels: Yes

--TeooaBszu6c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 5:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail">change 1755=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c51=
bcdda5666e0dab2adcdaff28408c9bfcb844 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1755 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 25 Aug 2026 15:=
50:22 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--TeooaBszu6c=--


--===============1521022358317240099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1521022358317240099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1521022358317240099==--

