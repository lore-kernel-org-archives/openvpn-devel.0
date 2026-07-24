Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A5DC531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3YaDnjZ0b4NF2ax4een3SeXuyvmEaIqBdf8tcSmOieg=; b=mnzFEA9gaEFou6FVdk1jylSTKs
	XmryHW2gbmR5RBf/wYOPqQzF4SY9DI/y/pBKNweN3+zirYSUgAA8CunnVHxrmvCnX30xmonBevFZd
	mulsZEJt1ldWKoLitRi92AOXcj3EJlcZDwrMva4Pky50xRNCLfxX/4I/0oOsDr/djIis=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnIio-0005dE-HS;
	Fri, 24 Jul 2026 16:26:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnIim-0005cu-F7
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:26:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mFGlJC18VN8IJGcmNSjIBhHiDZowMVaZDWIOtTEzF/s=; b=XAE/YQEH0HNtMQtVVssQ3PS4zU
 YcA3k134grp5W7KDQaBOxzifft8yaU0VbbqcbjfkxuyMJ8LTprVSXBWtGSOFPEeqm4EekMXqXdWfr
 xfIyP3vh4+2TbRAkSmCmrXnuGaROitRfEMSuiDhn3KS1u/3PE8ap+ko47MyYy1d1znp0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mFGlJC18VN8IJGcmNSjIBhHiDZowMVaZDWIOtTEzF/s=; b=W
 A402/V5/BQ24pLf5payNhZfSofgQRNDH+t5zeXT5yvd5tQpOKFhgmWxGn4ONHCsJNC2wUr91mrSWa
 a1d+XnOlIgfF0wKUL6OCkkgqoR/Nchz98t7gbzKN6LsPoK8+RLwbbe/Ih4fC9Qh5WJixEQcXQ+IPZ
 nkorGN51efhFR4fY=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIiq-0006n9-22 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:26:01 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49548aebcd8so5012225e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784910354; x=1785515154; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mFGlJC18VN8IJGcmNSjIBhHiDZowMVaZDWIOtTEzF/s=;
 b=Q9Dav/0KiqiLfgVDiSFW8c+PFE1b1L/Ly86rW3aqxj7b1k0GoTGn7ejh4kNs2o+UPo
 IDHYJrB4KuQoN0+saX6v2D5ZEjcDSqbWuloUCvlFT2EnTPkcDRaplTGoxSW+yKPjTa7E
 XNzQ9+NsPFEdFtdl4+ZBIv4jTpB5P+PQ5/SwSdYRseLLvEU3A5goF5Pvk7oTM5iFXZGF
 2JhdPd0blBEQD3UKgHEy46t+mUXwCZ+TQSBjlqqAVH6IHkE4vhhkwKd1Jt1RcfoGPMz8
 YVCQ0wFJl3UIbZg6M8Pp2BFQL4d6Cb1vspV+UMGNSkYcuNi1LItKzq1exDsDvJz0sE5N
 9tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784910354; x=1785515154;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mFGlJC18VN8IJGcmNSjIBhHiDZowMVaZDWIOtTEzF/s=;
 b=Dpf/mhlmARFbo+VcevfV15OR/AlyAD1utvvZLluMszeRCvV2YlgS3zOji3s2WPzpKr
 M8maR6KZ80L8sUcpBLeKumGy/hfzdA8qaP5kPu4C4XOcPP8SZ/U6OaR6A5BUrGhqSzct
 NkOCmVHZaHhCM0WkRuhN+pzT1Jm+g/XhqYFEkmfoaW99nHeod9ySQVBlqL1OEuNCMIjm
 qpMGHourK8FTRsKX/t7WZKZsdJ/g3AGufxuYQMUBAHqrNsO/TbHElwrt0YIMK8HElyIu
 T748wPpv+2cy4KaHIOAqTluY1r7+0RrYRaiPC+V5feFcd5kOK4g0sFSm0/ywV8+3mU71
 dFZA==
X-Gm-Message-State: AOJu0YyJWCiQsTab9pE8w+bqKET9s0Kvr3TobRgookjfNQ7d4ChHYkTe
 CtxHFRU5rzGqJ9XdX+SX80tGCmjj4L9JnX+BMtFTEP5iRGpJ0C5/FFr1WOaKWKz2awqVOfcLLAQ
 49C7fmzF1jly7RHck28NY912jLrfKLWFTlvlW8Lw4j+C5TROf5WFftppdFSmRtUEcGvYa
X-Gm-Gg: AR+sD12vzG0GZvVaLzSJJBnaNlYKEPurhJ/TwwcCiWI1busHQbR8RLPUHRpu+lgKc4b
 QCmsS5X0IFB54zG7QgSy8Ge/ogg5dpG5Xf2sfPd/qgvdxQvk5Fnsqun+mcQwv4CyDirs6zvFxRB
 FDueeY0r5eF7UDpTuDGiHNtE2p/8t2g/VXuRWat/QFegm05LcexTbo2OqI7jWy5mI9xwF7euloI
 J8Xo8F+hXQm9axv19CNWEUNV5sFLMLV7xsX4LP3FXf1+tgaKornhCGogrtoJ1c1uliWEWPudjMp
 7ddMaR6o5313pMA4yPnynYiIRYDgDjJXqOk2Lbbiis9GHiE3nvAiQb11qL4hFx4PZvvKPxRDWLw
 iyP4Dn+aTRgT8ydA2qik2ex1fO40W9jPbLPIBmsgifH3PMcSTWhVSg79e1iIeO/jEWlT8z2Oxqz
 tlocjzjIV7Bo3hCUllmuLyxMl8TKBhAnaoayffhE/qePJkGfGAsHWUNKhG75Gf+XzcVGekt0mCE
 EUiVAL3wmlEKGBjQDQoxOoNFd46cqKv5cN6fy+iSNWMxtN9Oq2Pb7KeTZ1f15Vk1IEY
X-Received: by 2002:a05:600c:b99:b0:495:782e:8faf with SMTP id
 5b1f17b1804b1-495782e8fbfmr69109955e9.30.1784910353703; 
 Fri, 24 Jul 2026 09:25:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b480fafasm3753705e9.0.2026.07.24.09.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:25:53 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:25:51 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517
X-Gerrit-Change-Number: 1731
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1731?usp=email>
X-Gerrit-Commit: b66d266e2ce556b3364769361586ccac0f66afe5
In-Reply-To: <gerrit.1782390484000.I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517@gerrit.openvpn.net>
References: <gerrit.1782390484000.I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMzkwNDg0MDAwLkk5NmQzNjk4NjAxYmI1YWFjM2EwZDdhYzZhYzViNWRkMjNjOTc1NTE3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a61b8db3d49bb9de07bbc34f1acbe9e5089c4cb7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnIiq-0006n9-22
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Silence warning
 with gcc 15 and O0/01
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5473832615314996836=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5473832615314996836==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P0YWS60Iq90="; charset=UTF-8

--P0YWS60Iq90=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1731?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Silence warning with gcc 15 and O0/01
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Silence warning wit=
h gcc 15 and O0/01

When compiling with low optimisation level gcc complain=
s

   route=2Ec:1783:44: error: conversion from =E2=80=98int=E2=80=99 to =
=E2=80=98uint8_t=E2=80=99 {aka =E2=80=98unsigned char=E2=80=99} may change =
value [-Werror=3Dconversion]
    1783 |             r6->network=2Es6_addr[b=
yte--] &=3D (0xff << bits_to_clear);

With higher it apparently detects tha=
t this is cannot be and does not
trigger the warning=2E Explicitly cast to =
uint8_t to silence this warning

Change-Id: I96d3698601bb5aac3a0d7ac6ac5b5d=
d23c975517
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1731
Message-Id: <20260723180445=2E17392-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg37816=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/route=2Ec
1 file changed, 1 insertion(+), 1 =
deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/31/1731/2

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec=

index 81ce867=2E=2E8ea745d 100644
--- a/src/openvpn/route=2Ec
+++ b/src/op=
envpn/route=2Ec
@@ -1780,7 +1780,7 @@
         }
         else
         {
-=
            r6->network=2Es6_addr[byte--] &=3D (0xff << bits_to_clear);
+  =
          r6->network=2Es6_addr[byte--] &=3D (uint8_t)(0xff << bits_to_clea=
r);
             bits_to_clear =3D 0;
         }
     }

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1731?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I96d3698601bb5aac3a0d7ac6ac5b5dd23c9=
75517
Gerrit-Change-Number: 1731
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--P0YWS60Iq90=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1731?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Silence warning with=
 gcc 15 and O0/01<br><br>When compiling with low optimisation level gcc com=
plains<br><br>   route=2Ec:1783:44: error: conversion from =E2=80=98int=E2=
=80=99 to =E2=80=98uint8_t=E2=80=99 {aka =E2=80=98unsigned char=E2=80=99} m=
ay change value [-Werror=3Dconversion]<br>    1783 |             r6-&gt;net=
work=2Es6_addr[byte--] &amp;=3D (0xff &lt;&lt; bits_to_clear);<br><br>With =
higher it apparently detects that this is cannot be and does not<br>trigger=
 the warning=2E Explicitly cast to uint8_t to silence this warning<br><br>C=
hange-Id: I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517<br>Signed-off-by: Arne =
Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1731<br>Message-Id: &lt;20260723180445=2E17392-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg37816=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file changed, 1 =
insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/1731/2</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 81ce86=
7=2E=2E8ea745d 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br=
><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -1780,7 +1780,7 @@</s=
pan><br><span>         }</span><br><span>         else</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            r6-=
&gt;network=2Es6_addr[byte--] &amp;=3D (0xff &lt;&lt; bits_to_clear);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            r6-&gt;networ=
k=2Es6_addr[byte--] &amp;=3D (uint8_t)(0xff &lt;&lt; bits_to_clear);</span>=
<br><span>             bits_to_clear =3D 0;</span><br><span>         }</spa=
n><br><span>     }</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1731?usp=3Demail">change 17=
31</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1731?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1731 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--P0YWS60Iq90=--


--===============5473832615314996836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5473832615314996836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5473832615314996836==--

