Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2A6C61DBC
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zjAcNELndJwwvtRW+EXV4hhoJlWc24kUqZLTNDKFB6Q=; b=BCvFhEpbRrL7J5neOiCVb8YLk1
	q/44am6PxYdmah09YLllqkWcRC0jj02cEqtgNGRSEf65jvW3/0UMqU0i2I4g4EoypSHZ5iv5X/LBQ
	wBMg8Aj5zddMDkROAhkWdOa1pZ8H2d7UeTQ1jkpbtfZctvyr+JQU5+TxPAVsf990p50s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wymB9-0004ta-Dn;
	Tue, 25 Aug 2026 08:06:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wymB7-0004tS-MU
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:06:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+eJJEgulcqRmZpENIaYQl9oliwfElHBjcQIMMIkj1fY=; b=e7CHrVfBJXG30PkM7OfaLxHIq9
 OJiUAhQ8yTMzYTeIMDQwYAPT3c2zy3jVWuGzpFOhXMxw0bo5tFlu9wXszOpiP9jynIYjv10tb2ry/
 9rfrMncjf4U09j5ZyOVxwqKg95eukKHdcNTWZIMIs3QBw79/oB3heA4vLMOtkJ0u5rF4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+eJJEgulcqRmZpENIaYQl9oliwfElHBjcQIMMIkj1fY=; b=N
 mdRzS2Wsp5kbxIe+t7W1B02GexDqfFREJUH88scHdFGXygpQSSVh1y2CZGAcoHgDOQyzn4HzaZISi
 6IipvVAMRV/qkYcYvMVtYMBGPS95DebeItpLl8wVwWVkN1sJFIZFNFVbbDvU16MHSRPdmUbFJ4vp3
 Z1o2tnrqNadmKRoI=;
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wymB7-0001la-0A for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:06:41 +0000
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so7470517a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 01:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787645194; x=1788249994; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+eJJEgulcqRmZpENIaYQl9oliwfElHBjcQIMMIkj1fY=;
 b=BNDyZVnJ0BSKlEQY4DmY2hQ2v63uKQqxm1Q9an3DHSl9uFrXml5jcyyXcUFUvwfE3Y
 z+If68ZEJOjc9OpVMK9IsCRH1EjOtg1j0HUwGyz2oSYBafvDG/8SH4yBQCL7x15JPcMv
 iBoFEU4VRZEFTSWMt25xlt2qZti6QM0zlcD9WrT1/ErPxiIe21flFa1R2/hmQopc0s/f
 NYazvMNSjMAOnWShHOTbhQubMTXVWr28H5mhcE9oj5H6tLQa6V57aDj0DylOHaPr25bA
 X9tbT5K6XIsryVF4+zQ5PpIL+T5GSwgzEZAp1+l5KSaTWMgUqq4nv6+Kzfo97YoDWgqo
 5ZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787645194; x=1788249994;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+eJJEgulcqRmZpENIaYQl9oliwfElHBjcQIMMIkj1fY=;
 b=DisHjLlJ5p64RfEMRF3dbtwz76WI+30jynNRRnpFjcUr3fsZxHrzjsArfSUtKKVHT9
 chjCkEA7t6RERoNac7/FmpvdftPzJ5wsAQie/3goTfS+7GodOTN1ih6zfWuG0HW+HeWt
 ZrNBSkHQp3CZz2Gg/rkM82wcNw1xtcLoySdhOWcfCvMGn1iZBOCCOnvk5W+BKibRjnoE
 WcqRZqutM6CsyNXyL87YIriVwzB+EHKqcEUr20dM/tmTvqaSE9Y2uurlMs7JMP1VtoMu
 OYFJXlbwsyKf3hfJeF25O2tEOcSFwv9i2XrBRhnX6HRQGOhJX728mTAgK10/kQ2xUz+A
 PXzg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrg7SQHZ0SCOiXKLyg6ODsfICoVIJOQSZ8ExpAkWmCBt+s7O5xXKIf+m4Lzj3qqmQw7EfpldiYc0ls4Gvz9@lists.sourceforge.net
X-Gm-Message-State: AFuF++mvmQmXx37QMm9RYNelZXY0T1X2z199BQNBXQhq1qgRsyik6PEK
 epL+KLKnZU4BwkjBnhkWSt1+snG3xEJoO7IJYl57FU9du6SYA6/U9gQRX6SjBPPGYU/oxdR76sA
 v7HzANudr7ocPQtg13z1XN/tm1Xui2J7BMYth546d0JmXhBe/XMXtBRM/ADJQt/0tP7ONoYy+ek
 FhLgoUGw==
X-Gm-Gg: AR+sD12QmPlU9dXZlih2Q7zAxk7yTGd/oERcxCEZzr2Ty+OTmxZwMPtS22ZULmAA+v4
 hw5b8s6dxYWHM++64CSgvloh2XEZtINvcNtfpeSljtN5rM6Ifu7V/6CSCmurfHKmoGYOeeem0tf
 Sq6Scw9QOvur2feD90HQdRB+tTGcvZFB9/cY0TMibBTuq6LllV5f2T+gUVS7FqyT91qBvBiNUoF
 OoJZvA7AxI/Jd/YYhFOoTUQ8rfAH3xZZG3JRfgzZT2GEPyTmatirxQKqFm910QJgMAjSChDP0yT
 NAoWkYnF1nH63rAi4cEbbZwHOE+29FPfh3soVP0ZPPerncodsNCWyJm4q89IICdx76BBoMh0rKk
 FsJPhK8t/ROvNoknDIEzVx74FmSKjyXE7PzAB5J/edV6PFyNgPH4/TtYUro7HWBa8HRTgZuOv3G
 Z06hKdJu6xmdlEWZ4a3fEt9ZYThiKE5e4cFg0GbCCfbESS/3kBoiPO2PQepD6IhM2sGFGzXbzO0
 AeKoQCtK3QGU61v/iLhLedNrP605onvQTlPMO7wg2anIl/pmAep1GZhwg/6p279riuheVPUhh7w
 vCgfplTGXLSaeX4oVIZQDylM46MaxSyBAhRfukksa8Ot16WB7BU=
X-Received: by 2002:a05:6402:321a:b0:69a:a4cb:2882 with SMTP id
 4fb4d7f45d1cf-6a42f216beamr39421676a12.9.1787645194310; 
 Tue, 25 Aug 2026 01:06:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5d6499c0csm253741a12.25.2026.08.25.01.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 01:06:33 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 08:06:32 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I450568c0307a6372506d115cb389d172472140d4
X-Gerrit-Change-Number: 1845
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1845?usp=email>
X-Gerrit-Commit: 1d818506d565af43c394ce0f5ba2420806401642
In-Reply-To: <gerrit.1786968495000.I450568c0307a6372506d115cb389d172472140d4@gerrit.openvpn.net>
References: <gerrit.1786968495000.I450568c0307a6372506d115cb389d172472140d4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTY4NDk1MDAwLkk0NTA1NjhjMDMwN2E2MzcyNTA2ZDExNWNiMzg5ZDE3MjQ3MjE0MGQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b782ef1f9de50543ef1102fde0f85828737dd460-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wymB7-0001la-0A
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: buffer: Remove some
 useless casts on BLAST returns
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6448286225459662862=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6448286225459662862==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c0GpA+/ngoI="; charset=UTF-8

--c0GpA+/ngoI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1845?usp=3Demail )

Change subject: buffer: Remove some useless casts o=
n BLAST returns
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

buffer: Remove some useless casts on BLAST returns

We can compare to =
'\0' without having to do casting=2E

Change-Id: I450568c0307a6372506d115cb=
389d172472140d4
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1845
Message-Id: <20260818142252=2E27227-1-ge=
rt@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@=
lists=2Esourceforge=2Enet/msg38485=2Ehtml
Signed-off-by: Gert Doering <gert=
@greenie=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
1 file changed, 3 inserti=
ons(+), 3 deletions(-)




diff --git a/src/openvpn/buffer=2Ec b/src/openvp=
n/buffer=2Ec
index 2b4d05d=2E=2E046e231 100644
--- a/src/openvpn/buffer=2Ec=

+++ b/src/openvpn/buffer=2Ec
@@ -500,7 +500,7 @@
 void
 buf_null_terminate=
(struct buffer *buf)
 {
-    const char *last =3D (char *)BLAST(buf);
+    =
const uint8_t *last =3D BLAST(buf);
     if (last && *last =3D=3D '\0') /* =
already terminated? */
     {
         return;
@@ -523,12 +523,12 @@
 {
   =
  while (true)
     {
-        const char *last =3D (char *)BLAST(buf);
+  =
      const uint8_t *last =3D BLAST(buf);
         if (!last)
         {
  =
           break;
         }
-        if (char_class((unsigned char)*last, =
CC_CRLF | CC_NULL))
+        if (char_class(*last, CC_CRLF | CC_NULL))
    =
     {
             if (!buf_inc_len(buf, -1))
             {

-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1845?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I450568c0307a6372506d115cb389d17247=
2140d4
Gerrit-Change-Number: 1845
Gerrit-PatchSet: 2
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--c0GpA+/ngoI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1845?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">buffer: Remove some useless casts on BLAST=
 returns<br><br>We can compare to &#39;\0&#39; without having to do casting=
=2E<br><br>Change-Id: I450568c0307a6372506d115cb389d172472140d4<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1845<br>Message-Id: &lt;20260818142252=2E27227-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg38485=2Ehtml<br>Signed-off-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>1=
 file changed, 3 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 2b4=
d05d=2E=2E046e231 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span=
><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -500,7 +500,7 @@=
</span><br><span> void</span><br><span> buf_null_terminate(struct buffer *b=
uf)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    const char *last =3D (char *)BLAST(buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const uint8_t *last =3D BLAST(buf);</span><br=
><span>     if (last &amp;&amp; *last =3D=3D &#39;\0&#39;) /* already termi=
nated? */</span><br><span>     {</span><br><span>         return;</span><br=
><span>@@ -523,12 +523,12 @@</span><br><span> {</span><br><span>     while =
(true)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        const char *last =3D (char *)BLAST(buf);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        const uint8_t *last =3D BLAST(=
buf);</span><br><span>         if (!last)</span><br><span>         {</span>=
<br><span>             break;</span><br><span>         }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (char_class((unsigned char)*l=
ast, CC_CRLF | CC_NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (char_class(*last, CC_CRLF | CC_NULL))</span><br><span>    =
     {</span><br><span>             if (!buf_inc_len(buf, -1))</span><br><s=
pan>             {</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1845?usp=3Demail">change 18=
45</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1845?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4=
50568c0307a6372506d115cb389d172472140d4 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1845 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--c0GpA+/ngoI=--


--===============6448286225459662862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6448286225459662862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6448286225459662862==--

