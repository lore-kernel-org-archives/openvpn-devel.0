Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1EAC88E4D
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8kpuf+W+z+jM2BDiP8n01QID651Nt44lcbpK9ch5V70=; b=TKd9hvQ+upMpu0uWIAEZjdp60X
	lVqOUck3mUcB2iKyNyOSnrKtGQIiROYbGB505R3Nr8fMWIz4h52dx+ZyKosTt8yOA8EhKm8E30P3G
	9fmIc8QWz9hrGG9okcmfRwIBAIC/lIW6OxhKHlgvMMkRsMx47WFIfpwd+K4lv7SZvII4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x51Jt-0007lD-4Z;
	Fri, 11 Sep 2026 13:29:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x51Js-0007l6-70
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:29:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uoElnBdWOcMRskP+IBQgi8MgXBJlsn3mRATwwKlYX9E=; b=L0X8utxGU51ygYdpW2IT44EpMy
 sD8PNHNf3KRtspfYY94XDJMztVmsSG0TfLS7Qw3BpYdTMpLbf/hQ36JvtzIaorf7+YD4PTG8q4lkh
 2uqBPmMyFBPoq59oR0oHXSEgzRnTjBZKXoXVctSOmJjXbPvS8E/ULMUN+3W6aqws/AM0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uoElnBdWOcMRskP+IBQgi8MgXBJlsn3mRATwwKlYX9E=; b=V
 zP+CPbOqeI0jrftWmaEyO3ikWBaGE/VfFBI+04uFusCTF75cjIJocqQE1keP/3kqz0i4ollmZoJZF
 W/Q5tMaUwXvK7iRCRiZTDAQY9FFkxLqr4pPtdgDIo/qOEqCVRC6Jy/6Kp4AObg2taH+XJSLVoTEZx
 zPfVlmVqBPwYGepI=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x51Jo-0005cQ-4L for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:29:29 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso13922845e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 06:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789133361; x=1789738161; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uoElnBdWOcMRskP+IBQgi8MgXBJlsn3mRATwwKlYX9E=;
 b=bgZsq1oM7JJFc7TJFvVQk6QqhxkI/Fn//IfFxvOIAbobXbEAqmy9i+cEuzhLDuRDbn
 PNhw9Au0HR5qD2B3peBFBYxIJoO4+mHoTDRgE7YlO8L6tFL2kb2GKzbp4pQPNr/n03zw
 h7bUI6jDXy5JzESpmXaqH3mSOz2vs7sNkNXyClOxVpebrictS49rYygIEoBUQI0Wh5nL
 UVxKO86nl0pjXk9m3BWkjN2JozeQ63PQooW5C/ZVysjJgO9jz8UuGmszxfgifjmS0tIq
 yjqIzG7hndzHq68wfXpol0JutUT2d1jn5LU1q1jisGsPuOOfN165sxw5ceXOdLt5u2he
 w87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789133361; x=1789738161;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uoElnBdWOcMRskP+IBQgi8MgXBJlsn3mRATwwKlYX9E=;
 b=WAYKp7Jr5rmbP4zOMHsqrctwQXVCe+OzEwD/KpH+pYGduewSR0j5sHmp3iW047UbQK
 SgQUfxKNcSEFPh1yvUJoH0E3zqgCWsABC2127Njpdh4rFpxUcUqthjO7gUn98jYlw+QL
 wYZUWgBXuSJSsil0jGCzehaM9oibEXz4aSqcLPLTiql23Gq1ow4MEMSfVpQ6RtMYpXtA
 TWFNqKUAjoCrswO8n4puRkHOe7lQVJsFqdZsMB1pI5t11v52eCUggtC0T6lc2q+6FFvP
 lv92xaeHGYolP5L5CmHqZLtNep1nes5Ihj0JvCQidtJ/wGIk0VKAmzzJ29itfEWR6gIb
 +f+g==
X-Forwarded-Encrypted: i=1;
 AKwUvByKqyjyWCudFapNXgPzMWt9GS16lwpGZ3BXw3vjat9pYdBO9z/cW5SfVJV09IRO2r0UkUkJ6njAzVYYTozA@lists.sourceforge.net
X-Gm-Message-State: AFuF++kQkkuafEEdRyWZ6cVpLL9lvsRqSFIwm34scGNnQL6Llffkq7Mj
 fP7FPlcYmE3zVQV+aXK7pEM9hXVDhljujtF5TJGqE7QEXlZjyUQLZrvYCsFkbA4uzl4baPCXhwE
 hUpYlCgjmo1r+rh26UzYcY2uXryVzea8Qyl1aCweeAUBHCRoiyLKnTF3B26NBbo0t/b1QVWJEfG
 T57cyYbQ==
X-Gm-Gg: AYBFou0/4FzCErfAI/Dkzf2+gxhp+TTKQ3I5InyoUJey/Yg36i0Ybmz/1YqIsXSbEWU
 gM6Y8S8DCRwnd3QvYjaT2tZ1TDU7rmu/yTIvrnWiUuvJY5CALn+L7B3ZjSP0EaRzt4FPXU4W6tX
 66yd6NO4AbfgFqGoTB8t9fbNm4+pE3DAC/fJJqf20JZjHynA8a6d3tvBhPmU1IBUH0M/qOnh9+X
 Tze8y22QiqU1N286+T0VAPNFoewlPpyTjswi7bIBWGUrilpu4YLBv8DzuzHUhGypQGgqaNMecjH
 GILVcT46hNbJch6J9s8JwF2HtnaMTF5bZzcncTcgZGDicS40b/ciCZtHKiLomnbYQoOBebDkkDj
 bR1wQDsvPPecNrsrGebM8IC4F6oLryiKANaZ5bjSMHWyJVt1dVX54HwPXJBlkHvbxzxtYFQsIiH
 nqeQYN6WlYrf4NZIj/dJChFF01PLiPv5nXyyDZM6CqAFuF8VxFgiRoPSPwfAV7ofnT7Z/5bDnVj
 bs0qyx3ROJHjFg4WxPgtQQ7AqNOm5VecoN05jc6tCDT/v/xWGXPsgxSyHO8Fmq+U0NTsn+QtCkz
 m1kzQmnbtm5UP1uAYs2We6U8dUe5HJ4b06NuwfkzzH/CkAAueYkjhNdAHtHdgg==
X-Received: by 2002:a05:600c:4743:b0:49c:fa21:1c8b with SMTP id
 5b1f17b1804b1-49e619dfe71mr44073545e9.32.1789133361399; 
 Fri, 11 Sep 2026 06:29:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60acff8bsm75969395e9.9.2026.09.11.06.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 06:29:20 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 13:29:19 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
X-Gerrit-Change-Number: 1912
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1912?usp=email>
X-Gerrit-Commit: c674d3c37f1d589451feb45c760b2b63f4bae94a
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 13:29:19 +0000
In-Reply-To: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
References: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkkwYWM5MzRkYTVlZWVkMDQyNGI1NGVkOWI1MjhhMmJmMmI1NjFmZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18daba6116c4d2b1b0ac245067525d06bdd60198-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x51Jo-0005cQ-4L
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix various function
 parameters shadowing other symbols
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
Content-Type: multipart/mixed; boundary="===============3318732015618090096=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3318732015618090096==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P5vBKKR0LD8="; charset=UTF-8

--P5vBKKR0LD8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1912?usp=3Demail )

Change subject: Fix various funct=
ion parameters shadowing other symbols
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File src/openvpn/mana=
ge=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912/comment/684e4277_fa=
e05fa8?usp=3Demail :
PS2, Line 3113:     man_output_env(es, true, managemen=
t->connection=2Eenv_filter_level, "CLIENT");
Shouldn't this be man->connect=
ion=2E=2E=2E?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1912?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ac9=
34da5eeed0424b54ed9b528a2bf2b561ffdf
Gerrit-Change-Number: 1912
Gerrit-Patc=
hSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg=
>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 11 Sep 2=
026 13:29:19 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--P5vBKKR0LD8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/manage=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1912/comment/684e4277_fae05fa8?usp=3Demail">Patch Set #2, Line 3113:<=
/a> <code style=3D"font-family:monospace,monospace">    man_output_env(es, =
true, management-&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot;);</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Shouldn&#39;t this be man-&gt;connection=2E=2E=2E?</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1912?usp=3Demail">change 1912</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1912?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1912 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Fri, 11 Sep 2026 13:29:19 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>

</body></html>
--P5vBKKR0LD8=--


--===============3318732015618090096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3318732015618090096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3318732015618090096==--

