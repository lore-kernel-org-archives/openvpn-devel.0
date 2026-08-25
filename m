Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9860C61DB6
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y6O4WxFNUeBrnX5H9xptV9V7xRUYvi4GS151gco3OCQ=; b=P3FNc498o29EwplvhOFphv+ygT
	0k5cvxpabLCUP8XH0zvAIibl1w6MNJNgoSMZCdINkV72vA9gYnyvJc80k8Ygw0Q4dl/ZuWWwWoPe6
	nB32wXh2wjN4WX8o79D1OjMr4w4Ssba2WDJu932srk4URJGZioYJqr/Vgt31dKKoMuxU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyljN-0000XQ-AB;
	Tue, 25 Aug 2026 07:37:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyljM-0000XJ-4x
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:37:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WlBHiwQY7E11t28xIzCQK45yHnNCdWaX9L6AQVCyiFY=; b=II/bYfK5cLfuHh6sUU5xzunLBo
 7qofkmagzwVLiCdRYZeX6iOrrRx9brHGA6DBREnGVOkRNzF/9jMwbBOElsnULPH8kZYEF6440z7n4
 xB8/rDKwA+g5xei4/KqBBlKZgD1n1X8nv6Vr60Gpu8mfMqT3PvTdg6YRVJ833n5E2ndM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WlBHiwQY7E11t28xIzCQK45yHnNCdWaX9L6AQVCyiFY=; b=S
 rU7/9YuC7/KF8+YJEaFv5N/97lq+0bi/r1CUc76HLufTS6gR4SJWpWz1RsXtN/sNos3Ng8yXMlsPE
 omzf81zBMdnLteUxPGvUgKxTS92gaheSyvypoZCyhYnZNQinsTh4KRA+vAV6DEt4dtRzg5+lBT/g7
 9BK3Gi3qTlScgCtQ=;
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyljI-0007OQ-Jq for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:37:57 +0000
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c214e625259so662780566b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 00:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787643470; x=1788248270; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WlBHiwQY7E11t28xIzCQK45yHnNCdWaX9L6AQVCyiFY=;
 b=UQStcLYjpeakMPNqgsOsNbWa5BztYPPHbBtXIdQ03oL/ATuR4JjAPukz0EQxc7E7+M
 HAMrhkU6OU/vDB+avnQqNlB7scxJeGtd0++ybmZQV2fJJ8h+yN21pPioFZm4/Tm2usNH
 EsZQpRirAOXTXP6BYIrl0SpNBLtzLDNIZQQ/YpPGs8QnGq9KGn7zjlKyKhQgtwM3aPj3
 cVvvmVwniztACVDYjdh0HzMefQKX6ZzcK/vsJLnG2h1IR691si6qX/Ad6rbRASYbPoVv
 SozUrG2xMoVOKR8RO0NJjTPvY0mhu/hR2GXU75JyvXTvDoo3WqeFgSHVHPuv9K/QYrlJ
 t+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787643470; x=1788248270;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WlBHiwQY7E11t28xIzCQK45yHnNCdWaX9L6AQVCyiFY=;
 b=ZyegU3rf5gPS8tLJblDFsrLoVEjhO/7goNfahdXn21MdRqPJSfpq8yqsvVstT7Hd8W
 WnrEayjbymJRj6ovIVQa+pBs2UM2tkH3iD7qo8/KXheTYgONUb+H+yMRJwyMxdBZ8Q8E
 I6L2erD6BSj4WbOUT5C4jz2GDYi3sbTJd3puqvn7Res/LWvRXGaJpBmdR/QJwtAdSbUa
 86orJh7LYknxHB7F0pkdFWVDIWn4I5vU8EZyfy01lha1+e4e0b1g0HsGCTWnM1f84Nlt
 o4bTJKLZO0fFG3tq6pb0kYg2CC7d4zxNW/dDdrEfPQl8ywdSgSo8hbIDUSBEV3L2ENtT
 M4GQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTQKS5LvXZfWQTQCiZFjty/fAKd1UiBELMn4uQyKGLvTeixFsgR/AyLU1qEYmUk8Uhj+Ld7OiPkJMVCzaW@lists.sourceforge.net
X-Gm-Message-State: AFuF++mLXdJj70vLIE20p32zU+6FaJDGy54UKGoHSqfiE4yp0FMXJGZ8
 1+D5Q7zb4W8HvgNpWQ/AarW/2JTxNEM00DG4nMSfI1CNYL7aF3//qzjmXFF4IF4IIjyxa8YrG3f
 QSMIuuZB2hgbwE2TxjiZ/pK+gZLURaqNg9/t9MvjomPe2zjowXBMM4YDU78per6gvJfdM
X-Gm-Gg: AR+sD101MR2dVTahnCTMdJ8HEi7ZY6H/p9/cCl5w/UG7KQVOGenjM0/WjxFphYafvA3
 ImzsP/MuvW0q6pCMSR/3gvB4dXZhP9MjXn7juEfyfzDih/2/4VctHoIl3+RubAMgGuGbGvpDWJl
 SCX1R9QJCjtzAcPp7sYFFnTTKCCWglS1jrrhw3rgonFBdUPwWMMqGFa1pUD+x4NQHAEd6g6aKON
 lNa8sjRZmIUX5/wiFuYQ5RgAZkdrhtoNaJFuYDG/tD8947QHimgGq12QE2td0cASq0+snZTTYze
 Yc+Aom9gtBAe/oo3R4+QHHd+KP+xerhi+QMmZm5DnFaQZjYlPxyC8m4FKU36RfCAlA+GS08i7Dr
 a3k7/HA3g6pwIlPJd80By3TUPD6br9HoBEdfS5/VkAsJftoT+NEepmcqBTfQquAcNMAy0yCxdEM
 uBqwMSq4BtwiOoeKEKBq2uX8TaeClTzk1OkGDY99nSutvbhKQxfZVM3SFcPpuUqOR42eR2h61gW
 OTgiVrKE4wEAB/Y2i3bTiFnn41O+vOP8AkqgiS3j/76uOWd2MJNCRfpkaLTPHALvlQXDoV+H4Cf
 D+Bw299hs2+HIY6WIhXQkRcDT/i0+YAJaMk2r3QRTn1V4Q7Eqyg=
X-Received: by 2002:a17:907:8e15:b0:c24:d6f0:a53 with SMTP id
 a640c23a62f3a-c24e5c0290dmr525995166b.23.1787643469937; 
 Tue, 25 Aug 2026 00:37:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b4f1sm1659091166b.3.2026.08.25.00.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:37:49 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 07:37:48 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54
X-Gerrit-Change-Number: 1867
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1867?usp=email>
X-Gerrit-Commit: 3da1b9ba93f568d4ca498cc3ab9febe55d679fd3
In-Reply-To: <gerrit.1787570563000.I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54@gerrit.openvpn.net>
References: <gerrit.1787570563000.I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkkyY2Y1ZGEyYWE2ZmJiNjgxMTZjN2I2ZWY1ODdhNjQ5NGFjYWUwYjU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <10a898f218c36841f35463cdd6a229ce1b097190-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyljI-0007OQ-Jq
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: event: Remove
 unused function event_set_return_init
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
Content-Type: multipart/mixed; boundary="===============0009201786406113616=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0009201786406113616==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aeONmWoV9Gs="; charset=UTF-8

--aeONmWoV9Gs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1867?usp=3Demail )

Change subject: event: Remove unused function event=
_set_return_init
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

event: Remove unused function event_set_return_init

This has never be=
en used in the git history=2E
It is also equivalent to just using CLEAR()=
=2E

Identified by cppcheck=2E

Change-Id: I2cf5da2aa6fbb68116c7b6ef587a649=
4acae0b54
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-=
by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1867
Message-Id: <20260824161558=2E1869-1-gert@green=
ie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg38641=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/event=2Eh
1 file changed, 0 insertions(+), 7=
 deletions(-)




diff --git a/src/openvpn/event=2Eh b/src/openvpn/event=2E=
h
index 40ed161=2E=2Eb784dfe 100644
--- a/src/openvpn/event=2Eh
+++ b/src/o=
penvpn/event=2Eh
@@ -190,13 +190,6 @@
     return ret;
 }
 
-static inline =
void
-event_set_return_init(struct event_set_return *esr)
-{
-    esr->rwfl=
ags =3D 0;
-    esr->arg =3D NULL;
-}
-
 #ifdef _WIN32
 
 static inline voi=
d

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1867?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2cf5da2aa6fbb68116c=
7b6ef587a6494acae0b54
Gerrit-Change-Number: 1867
Gerrit-PatchSet: 2
Gerrit-=
Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@=
greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--aeONmWoV9Gs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1867?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">event: Remove unused function event_set_re=
turn_init<br><br>This has never been used in the git history=2E<br>It is al=
so equivalent to just using CLEAR()=2E<br><br>Identified by cppcheck=2E<br>=
<br>Change-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering=
 &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1867<br>Message-Id: &lt;20260824161558=2E1869-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg38641=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/event=2Eh<br>1 file chan=
ged, 0 insertions(+), 7 deletions(-)<br><br></pre>
<pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/event=2Eh b/src/openvpn/event=2Eh</span><br><span>index 40ed161=2E=2Eb7=
84dfe 100644</span><br><span>--- a/src/openvpn/event=2Eh</span><br><span>++=
+ b/src/openvpn/event=2Eh</span><br><span>@@ -190,13 +190,6 @@</span><br><s=
pan>     return ret;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-event_set_return_init(struct event_set_ret=
urn *esr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    esr-&gt;rwflags =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    esr-&gt;arg =3D NULL;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32</span><br><=
span> </span><br><span> static inline void</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/186=
7?usp=3Demail">change 1867</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1867?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1867 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--aeONmWoV9Gs=--


--===============0009201786406113616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0009201786406113616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0009201786406113616==--

