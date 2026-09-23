Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED59C98304
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:Date:
	Message-Id:Mime-Version:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e0yOk3dYKvKj4kEIgKAGReKb5y3Si902RnjR7bAq8AE=; b=M78svu8WsAmdNOvx7k+9cJJFC2
	cCTmnPmubRUyZe3Z6FxQjS51eWEltwSjg4/CSCYBPA5P3jvK7S375/oUYOJLsBXZaQh9lJmg0QKQC
	WBlnQfcixtF4cx9zl4IzYWcWRRtYqH0//oC+sgnC9tlr/ruZ51XKPInctt5mJ4HWCsXs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9PWK-0006Lq-IC;
	Wed, 23 Sep 2026 16:08:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yuriy.darnobyt@openvpn.com>) id 1x9PWI-0006Lj-LH
 for Openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 16:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:Subject:Mime-Version:
 Content-Type:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ugbGCwJm7oFPYT4eTK8oClm7EshQfNVWXDgaoQVEgVQ=; b=K3EvUlyyvAsAt5vkiX0e2vho5p
 H+05hM3uu1Kw2LVd9hbTNPkr6RjfCgjhEjBuhXHgETMc05QRwmAWgmUrT6tWzKlRRY1PEExgJq3wp
 EJe2PGEA99Cme6OZIDg3WG08conszI+V7T329dE44z6ZnQV5+1KzBEfGrEaCB/1Xo3Pg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:Subject:Mime-Version:Content-Type:From:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ugbGCwJm7oFPYT4eTK8oClm7EshQfNVWXDgaoQVEgVQ=; b=Y
 +pfygzOcmjsXPU7fIC3yzfu+hvUgHOLODxvSwpNuFWQJ/URL/kwxcncZNMXnJEMt7+XhmcGYR5lJa
 Q8iO7lhT+av6g8+AHfLjZ/xKIHOIUqZOlGSFSsikYiWWADvdBZdNeHvNWQeK6QeP7cHATIa0eIstu
 zwP+e8ymbxESZfQg=;
Received: from mail-lr2-f35.google.com ([74.125.230.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9PWE-0004Sn-Hl for Openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 16:08:28 +0000
Received: by mail-lr2-f35.google.com with SMTP id
 38308e7fff4ca-3a60e33d456so10282641fa.1
 for <Openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1790179700; x=1790784500; darn=lists.sourceforge.net;
 h=to:date:message-id:subject:mime-version:content-type:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ugbGCwJm7oFPYT4eTK8oClm7EshQfNVWXDgaoQVEgVQ=;
 b=M7uFuDgSmXRLffj17Te0rYZAKgy2c2RHHMOVAs3aqz6PZmFbPevNXa91DIWnJoAeHr
 PCpI3n2Px93tHu9U0WvxUWrnplKkP+/F8vTb6XNNL7B/VqFYhvqD6w40DXQK/LFiuTAp
 K1EGZlgQtH1ZUJgccIGUd1SL7FVBqYxeVrSLpFhJvHhVbGp3UIxLUPWKTDPiN4RKqiFk
 8FLUMrfkWjVuwpUh8YOY6vCgQkrkyvRBMK5o1shm3KIt1vgGfZo9OIV3IHg1WKzXumIe
 3yE6ZmU+YEkEH2MqPwxIrQEVp5vUq9vhH9XT0vzTqh1cvCvg8y9LPdospYUMjlJjfyQA
 kx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790179700; x=1790784500;
 h=to:date:message-id:subject:mime-version:content-type:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ugbGCwJm7oFPYT4eTK8oClm7EshQfNVWXDgaoQVEgVQ=;
 b=G75bPrAqOAzBekYfxVrtp8lpnDpEDvfHjU5wItDLgSQSa4JKpcjwzAiOdKDfubGTEJ
 aU33EEaQkCCd3S0C3RJWT5mO0Qw2HDxQ/vJox0LlKE3UFmqnWYgGvKD5uQ3KiLnJvQ9r
 7QbV0lJS32lMLdZSgyYfcysG5xUfrPhT2oPhlyWW7VryPW4HFfLWAIusvijRVO+Li17F
 mdlAjhpHi19Jsm5sRfkJPsDlLYdm51+Z2NNBzJXzNEZJFPvwQ14fdDjmCCudkHVVHyIF
 I3smnOg8QuuekUFIfMFW5LeO8qGCVTsx4LLAFoGiFQwXbpGQaVYaQv/dLryCxWEUhjsL
 JsAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPFuZ/VHpKXYG3hmmVpkl7XPEeb5hqFg1Ph0vWv/3vQRGcLU7lGEnf0IgPg3riIxB7FyZbY8ZoGZhV2mu6@lists.sourceforge.net
X-Gm-Message-State: AFuF++nIsvoay6pTrLUzlWidcTfvTNzEuSRLehlf182KaPbe1+Bh9et0
 hRZmFPJZIY8oXn2jJnXmI56GVWOSlEDq0zAzh2ZN2CFPnooiR9k3/EcrCwRe6uI1UoYF5NRYvC2
 t9QYcrDy4uAFxmTbmwXUnKTGizeIPR7AM0CXG5Yd8m5RGF1KMy5V61ueV/Q8mR7JIJyVcXxupcA
 uwUICe+GhF
X-Gm-Gg: AYBFou3Ad7TQ6vRPbH/xDDdwSF8iug/mgZcwTueCVFEEDGS5+za1KfOkO27kIWaNypn
 w5CDrTKorW+9w7GO7lLKuqm7tkjD39p1Im8wkRXQmvdk17+9CPIIqdeheX1dKO0KhsyaR6lhOj4
 X1+POonXvPQTjNuck8OHoClW+OErWvcydg1L61b8sd0R7bcxpE6NtYEIeCwe5uz3TBmWAFbaQAP
 Ph6DqpyEXA85kZnT8yXzb/x2hs65SElag5G7G+NW2IHM3q/EQudYZ9KkPbFmLnEYOoqcalTt06I
 nZaBxxCqZktdhBspKu2BEPSSXqsP6qI6ONAJ5jkTWNxNztN/D1wQi7SvpcPRA0L/kfQd3diLPV5
 wciSPJqzUOl7yt1mpFmeCUzScoRIMKhHm1IR40yklyTV3Psgw45XJH2DgPAH72gdOVE8twmqK7G
 mz6X8M3dwa6KQFwowAh8dyCVjqPDw/PJeibJWlVe0tCJe4rL+7slolYDPcz8gnLOIjmz5QJW7oz
 LRk4wfwd+mNlFAIoOH6U1/vELw=
X-Received: by 2002:a17:907:3f20:b0:c29:6400:ef8e with SMTP id
 a640c23a62f3a-c2aae1f825fmr256490866b.42.1790178075673; 
 Wed, 23 Sep 2026 08:41:15 -0700 (PDT)
Received: from smtpclient.apple ([45.89.91.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae5c89d7sm145200166b.10.2026.09.23.08.41.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Sep 2026 08:41:14 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Message-Id: <D83C46D6-F150-4E3C-962B-B56F3BEC0735@openvpn.com>
Date: Wed, 23 Sep 2026 18:41:03 +0300
To: Openvpn-announce@lists.sourceforge.net,
 Openvpn-devel@lists.sourceforge.net, Openvpn-users@lists.sourceforge.net
X-Mailer: Apple Mail (2.3864.700.51.1.1)
X-Headers-End: 1x9PWE-0004Sn-Hl
Subject: [Openvpn-devel] OpenVPN 2.6.23 released
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
From: Yuriy Darnobyt via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Yuriy Darnobyt <yuriy.darnobyt@openvpn.com>
Content-Type: multipart/mixed; boundary="===============7427094932552255867=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============7427094932552255867==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_50FAD344-0E5E-4739-9CD5-836C7B28F21B"


--Apple-Mail=_50FAD344-0E5E-4739-9CD5-836C7B28F21B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

The OpenVPN community project team is proud to release OpenVPN 2.6.23. =
This is a
bugfix release fixing several security issues.

Security fixes:

* ssl: do not trust the peer's request to resend the wrapped client key
* reliability layer: avoid unbounded reliable TLS timeout, and ignore =
acks for
 packets that cannot be outstanding (CVE-2026-84732)
 Both reliability layer bugs found by Mark Bregman (Fox-IT)
* improve on check_session_buf_not_used(), catch possible double-free in =
the lame
 duck case (CVE-2026-84471)
 Bug reported by Andreas Gabriel Berbescu and Haruki Oyama (Waseda =
University)
* windows: fix CreateProcess() command line quoting for characters that =
are special
 to cmd.exe, where a combination of validation script plus rogue CA =
could lead to
 misbehavior (CVE-2026-84256)
 Bug found by Clouditera Security
* windows: fix tapctl to always call netsh.exe with full path (as we do =
elsewhere)
 (CVE-2026-84226)
 Bug found by BreachX Zero Day Labs (using Typhon AI Mil v2)
* windows: don't use NULL DACL with system objects, namely the --service =
exit event
 and the netsh.exe guard semaphore.
 The old approach was prone to a local DoS where one user could =
interfere with
 other users' openvpn processes by blocking the netsh semaphore or =
sending events.
 This only affects setups not using the iservice, or using the automatic =
service to
 start/stop openvpn (CVE-2026-82312)
 Bug found by DEBRAJ BASAK
* dhcp (windows): fix off-by-one in write_dhcp_search_str() temp buffer =
guard -
 suitable DHCP options could lead to a single-byte overflow of a temp =
buffer
 (CVE-2026-81738)
 Bug found by Andre Kropp (Nexory) and ChinhNguyen
* openvpnserv (windows): detect and refuse sibling dirs in =
CheckConfigPath()
 (CVE-2026-81830)
 Bug found by Harshit Varu

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/v2.6.23/Changes.rst =
<https://github.com/OpenVPN/openvpn/blob/v2.7./Changes.rst>>

Source code can be downloaded from our download page:

<https://openvpn.net/community/>

Kind regards,
Yuriy Darnobyt=

--Apple-Mail=_50FAD344-0E5E-4739-9CD5-836C7B28F21B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div>The OpenVPN community project team =
is proud to release OpenVPN 2.6.23. This is a</div><div>bugfix release =
fixing several security issues.</div><div><br></div><div>Security =
fixes:</div><div><br></div><div>* ssl: do not trust the peer's request =
to resend the wrapped client key</div><div>* reliability layer: avoid =
unbounded reliable TLS timeout, and ignore acks =
for</div><div>&nbsp;packets that cannot be outstanding =
(CVE-2026-84732)</div><div>&nbsp;Both reliability layer bugs found by =
Mark Bregman (Fox-IT)</div><div>* improve on =
check_session_buf_not_used(), catch possible double-free in the =
lame</div><div>&nbsp;duck case (CVE-2026-84471)</div><div>&nbsp;Bug =
reported by Andreas Gabriel Berbescu and Haruki Oyama (Waseda =
University)</div><div>* windows: fix CreateProcess() command line =
quoting for characters that are special</div><div>&nbsp;to cmd.exe, =
where a combination of validation script plus rogue CA could lead =
to</div><div>&nbsp;misbehavior (CVE-2026-84256)</div><div>&nbsp;Bug =
found by Clouditera Security</div><div>* windows: fix tapctl to always =
call netsh.exe with full path (as we do =
elsewhere)</div><div>&nbsp;(CVE-2026-84226)</div><div>&nbsp;Bug found by =
BreachX Zero Day Labs (using Typhon AI Mil v2)</div><div>* windows: =
don't use NULL DACL with system objects, namely the --service exit =
event</div><div>&nbsp;and the netsh.exe guard =
semaphore.</div><div>&nbsp;The old approach was prone to a local DoS =
where one user could interfere with</div><div>&nbsp;other users' openvpn =
processes by blocking the netsh semaphore or sending =
events.</div><div>&nbsp;This only affects setups not using the iservice, =
or using the automatic service to</div><div>&nbsp;start/stop openvpn =
(CVE-2026-82312)</div><div>&nbsp;Bug found by DEBRAJ BASAK</div><div>* =
dhcp (windows): fix off-by-one in write_dhcp_search_str() temp buffer =
guard -</div><div>&nbsp;suitable DHCP options could lead to a =
single-byte overflow of a temp =
buffer</div><div>&nbsp;(CVE-2026-81738)</div><div>&nbsp;Bug found by =
Andre Kropp (Nexory) and ChinhNguyen</div><div>* openvpnserv (windows): =
detect and refuse sibling dirs in =
CheckConfigPath()</div><div>&nbsp;(CVE-2026-81830)</div><div>&nbsp;Bug =
found by Harshit Varu</div><div><br></div><div><p style=3D"margin: 0px; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal; -webkit-text-stroke-color: rgb(255, =
255, 255);"><span style=3D"font-kerning: none;">More details can be =
found in the Changes document:</span></p><p style=3D"margin: 0px; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal; -webkit-text-stroke-color: rgb(255, =
255, 255); min-height: 14px;"><span style=3D"font-kerning: =
none;"></span><br></p><p style=3D"margin: 0px; font-width: normal; =
line-height: normal; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: =
rgb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 255);"><span =
style=3D"font-kerning: none; color: rgb(0, 0, 0); =
-webkit-text-stroke-color: rgb(255, 255, 255);">&lt;<a =
href=3D"https://github.com/OpenVPN/openvpn/blob/v2.7./Changes.rst"><span =
style=3D"font-kerning: none; -webkit-text-stroke-color: rgb(53, 134, =
255);">https://github.com/OpenVPN/openvpn/blob/v2.6.23/Changes.rst</span><=
/a>&gt;</span></p><p style=3D"margin: 0px; font-width: normal; =
line-height: normal; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; =
-webkit-text-stroke-color: rgb(255, 255, 255); min-height: 14px;"><span =
style=3D"font-kerning: none;"></span><br></p><p style=3D"margin: 0px; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal; -webkit-text-stroke-color: rgb(255, =
255, 255);"><span style=3D"font-kerning: none;">Source code can be =
downloaded from our download page:</span></p><p style=3D"margin: 0px; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal; -webkit-text-stroke-color: rgb(255, =
255, 255); min-height: 14px;"><span style=3D"font-kerning: =
none;"></span><br></p><p style=3D"margin: 0px; font-width: normal; =
line-height: normal; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: =
rgb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 255);"><span =
style=3D"font-kerning: none; color: rgb(0, 0, 0); =
-webkit-text-stroke-color: rgb(255, 255, 255);">&lt;<a =
href=3D"https://openvpn.net/community/"><span style=3D"font-kerning: =
none; -webkit-text-stroke-color: rgb(53, 134, =
255);">https://openvpn.net/community/</span></a>&gt;</span></p><p =
style=3D"margin: 0px; font-width: normal; line-height: normal; =
font-size-adjust: none; font-kerning: auto; font-variant-alternates: =
normal; font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal; -webkit-text-stroke-color: rgb(255, =
255, 255); min-height: 14px;"><span style=3D"font-kerning: =
none;"></span></p><p style=3D"margin: 0px; font-width: normal; =
line-height: normal; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; =
-webkit-text-stroke-color: rgb(255, 255, 255); min-height: 14px;"><span =
style=3D"font-kerning: none;"></span><br></p><p style=3D"margin: 0px; =
font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal; color: rgb(0, 0, 0); =
-webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kerning: =
none;">Kind regards,</span></p><p style=3D"margin: 0px; font-width: =
normal; line-height: normal; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: =
rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><span =
style=3D"font-kerning: none;">Yuriy =
Darnobyt</span></p></div></body></html>=

--Apple-Mail=_50FAD344-0E5E-4739-9CD5-836C7B28F21B--


--===============7427094932552255867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7427094932552255867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7427094932552255867==--

