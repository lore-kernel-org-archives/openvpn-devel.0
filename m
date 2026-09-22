Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF313C982FF
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oh0GYEeGJwHYY0H2vzOps+8RdeY69tQ8mdH7NyuYPaM=; b=DTwqNCY3db++OEuJSjRDH2xddU
	+VESRjq1cKBRgpgFDmjyJEDRA30r0uXUjB246AAQB3BP5ANNSQlgePflOj0XBGLQ6AmgLf+1OLf59
	y97RrYmX3SDQuyhHc3aHc0HaybfCpf2LPJhvszI1jFUJ+lbTpDFJ4cPPPbdZE4ahq/DY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8zls-0000IE-Rb;
	Tue, 22 Sep 2026 12:38:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8zlf-0000Hs-Kq
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:38:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Y171aCW0/5RriOR4hq4s8olDkL/IC0BlMBUMV2BRnO4=; b=iYVGYt/ZTPEFMEMD/lrq1PfUj6
 /HBFmZwLOI/67rUzepQ5W16+jMkLbbg/GgOX0qhJ8LcLja0PYsFa6tMEnvCt+nWVFg3heYas1oeXX
 vcnDfLnpCN2IvYraUPhEhc5HQbDMG9+6hQO46u/mGgcuhpo38av9Sk4AwbiGVX0shljA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Y171aCW0/5RriOR4hq4s8olDkL/IC0BlMBUMV2BRnO4=; b=X
 Tl3jrC+DbCzX97q7var6DV2/KsjMefVMX4Pl3U+pFVGXsOcAoLX0Fq48ulpQL9KBiwXFWHDVeurRC
 QLHfph7Iw1IQ0YJkyLWpt0ZtrL3GxKiqoqMGNbf3yNpJXu1ok1oD7Fq92S+vTRekcvKkS8iZCx67w
 OubG1ayIAlDJRapQ=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8zld-0008HN-Be for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:38:39 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so22599735e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 05:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790080711; x=1790685511; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y171aCW0/5RriOR4hq4s8olDkL/IC0BlMBUMV2BRnO4=;
 b=NOBtG+tAxUo7z4h9yDBJdicX4EDvw9cfHXRbBTzxBHx0ASEwWh9ZVMN22WDppXdkQU
 z3/UTNiFz9871iNmPEmUWx+tyGzGmyZ3gWZeEGES524aNZAAREQ7rxqr9WwJgI4LB305
 XzF60w/Kn82Tn0zsbrntnPimqyrS55LkuOBVT7LGTLyJafDDjDAI5If7x5TitZGfPaNM
 q/aE8DonE/7QxMUWA9S/RQ0wTYuOsTUUeR2Jr6GvEweTSw3J2wEjWLVcMvRiJjTW5g/0
 yyEmi7FQwxbvGk02fNc5jqIJW8CPn39wt4gF9GmaTcy1e12xZsGrVrPdaftiEewAjmMD
 XWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080711; x=1790685511;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y171aCW0/5RriOR4hq4s8olDkL/IC0BlMBUMV2BRnO4=;
 b=MGWtgjDXlwvGR9cbcFFiqiwussYuFVITvA0JsAkUqhIZDOswNPrIknqeErFzBV28TJ
 kz8trxRSFuZ8Mc9SzDAs1Mdctn9PViskke79A+nK2PaE6LCA+bEq4vWu5i99rm9BcBQR
 TcLiJ/9TYxDYVZvHWeGGbNGyJ5SI4yAgQOFXRuF8zPrjgnox0JWRdlbhB7cbtCyZ0Gwr
 Dkyoq8S+J0sFcn8yPASHr1doVuZMffXVNUShCTyfe6Mp+UOJJX4IeaoI4CttzMr1DayU
 +BNsvy7TU/1KoXPVYVeATTVHdM9HJjtp33HpVK0ya+v8hYlqgyIbdtktGN3gVIDurdam
 t5dg==
X-Gm-Message-State: AFuF++manyH0wNLaHNpNO8f7o2HrtngLASdb77nnvmyA9PZrsyZR0ZzG
 zHIxLubVs6RIQjSs9cJERwXsIt42VKlW4+WqOKzj5Z0hpM7Tmt6jvAfJs1n/snoi6TtJ03Ay6nk
 G2D/c/JpdN/r1B3UKu047KlCQf/Ntq3f75i2JMfJX/KDaokxybfzcniFGMAOdVqv7DBOl
X-Gm-Gg: AYBFou25Bt8oXuGuXQO4r00RNwcqxxD7+GWfQ9OEhRcK+97kVXOGeRdGQY6wjKp10qX
 cV/fkrbUHIeZhmTznU9OgNm1KmrDIBhuXbRS+rDJg1uBpB19o/1c+aFMLMiFqhyXggNiNqKVXWy
 ef4f1SvJkvrGgx5obdMkDOZW6Rugis3dSOktC10nFhmAAWlceCYPBXMz48MCcuJCTqW1a5i1PIV
 zhLuJ0zYn3g5KRB33cwHN5vw2E1HDX0aVr8fBqjqBAekwORQjmjVDUIXmQoRXeHua7N1p1FmCPz
 q4jAqYw+NpEh1shXYBOkHQweLgiMnqt2z31j0rDkDnxdWYuZ79FGONaqDWlyyzl1t59x72O4fnU
 WfLODGw26SuOeEkr9TDvbHZ7EoBhXnjffMVvY38HuNzgdgG/9pd2/iAVzt6c1UXeG2y1dOWvG/e
 DoticsgEel5Ftz5ldZnD7nodiDYrJIPEAaB5XhrzDD0uC5zAVpj/ngeCYg+5bMTb6v7uWYrKDUT
 +ByOwhHD48GJK1oxomFYykQPLWJZM6/YTndRHZ1+SiZmZLwRm7vJiCPgZvsIAV7p9hVwu+jGH0f
 SpN0Te9leuROrrZv+8L/NayD9nsKVtSSzDG9XT/3XanNGSGH6fz+1zXCf27x
X-Received: by 2002:a05:600c:4712:b0:49f:dd10:3c71 with SMTP id
 5b1f17b1804b1-49fdd103ccfmr12340325e9.11.1790080710532; 
 Tue, 22 Sep 2026 05:38:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8ccc053sm84090605e9.7.2026.09.22.05.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:38:29 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 12:38:27 +0000
To: razvanc <razvanc@mailbox.org>,
	flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
X-Gerrit-Change-Number: 890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/890?usp=email>
X-Gerrit-Commit: e064870a823d64266e703fb724cb088f366f593f
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzM5MzYxMjA0MDAwLkkyMmU0YjczZTc0NGM3NjVhNDNiZGIyOWY2ZTE4ODEzZDEwM2VhNzU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <568b11a08417570a1ae0ce66b8a4ddd9a65e374d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x8zld-0008HN-Be
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Always use a
 0.0.0.0/0 default on Android instead of def1
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1973865304337471177=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1973865304337471177==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6Y6ImBKgTRs="; charset=UTF-8

--6Y6ImBKgTRs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, razva=
nc=2E

Hello cron2, flichtenheld, razvanc, 

I'd like you to reexamine a ch=
ange=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=
=3Demail

to look at the new patch set (#3)=2E

The following approvals got=
 outdated and were removed:
Code-Review-1 by razvanc


Change subject: Alwa=
ys use a 0=2E0=2E0=2E0/0 default on Android instead of def1
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Always use a 0=2E0=2E0=2E0/0=
 default on Android instead of def1

Certain handset manufacturers (like Sa=
msung iirc)  are handling
0=2E0=2E0=2E0/0 different from the split /1 route=
s, so push the 0=2E0=2E0=2E0/0
route to the OS=2E

Change-Id: I22e4b73e744c=
765a43bdb29f6e18813d103ea757
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eor=
g>
---
M src/openvpn/options=2Ec
1 file changed, 7 insertions(+), 0 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
90/890/3

diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
in=
dex e3cd527=2E=2Ecbada6f 100644
--- a/src/openvpn/options=2Ec
+++ b/src/ope=
nvpn/options=2Ec
@@ -5615,7 +5615,14 @@
             }
             else if=
 (streq(p[j], "def1"))
             {
+#ifndef TARGET_ANDROID
+            =
    /* The hack that def1 uses to split 0=2E0=2E0=2E0 into 0=2E0=2E0=2E0/1 =
and
+                 * 128=2E0=2E0=2E0/1 is not needed on Android and will=
 even
+                 * make some Android implementations (e=2Eg=2E Samsu=
ng)
+                 * misbehave, so silently ignore the flag and always u=
se
+                 * 0=2E0=2E0=2E0/0 instead */
                 options-=
>routes->flags |=3D RG_DEF1;
+#endif
             }
             else if (s=
treq(p[j], "bypass-dhcp"))
             {

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail
To unsubscribe, or for help wr=
iting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
Gerrit-Ch=
ange-Number: 890
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Revie=
wer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attentio=
n: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@gre=
enie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--6Y6ImBKgTRs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos, razvanc=2E </p>
<p>pl=
aisthos <strong>uploaded patch set #3</strong> to this change=2E</p><p><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view-1 by razvanc</p><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">Always use a 0=2E0=2E0=2E0/0 default on =
Android instead of def1<br><br>Certain handset manufacturers (like Samsung =
iirc)  are handling<br>0=2E0=2E0=2E0/0 different from the split /1 routes, =
so push the 0=2E0=2E0=2E0/0<br>route to the OS=2E<br><br>Change-Id: I22e4b7=
3e744c765a43bdb29f6e18813d103ea757<br>Signed-off-by: Arne Schwabe &lt;arne@=
rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file changed, 7 =
insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/90/890/3</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index e=
3cd527=2E=2Ecbada6f 100644</span><br><span>--- a/src/openvpn/options=2Ec</s=
pan><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -5615,7 +561=
5,14 @@</span><br><span>             }</span><br><span>             else if=
 (streq(p[j], &quot;def1&quot;))</span><br><span>             {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TARGET_ANDROID</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                /* The hack =
that def1 uses to split 0=2E0=2E0=2E0 into 0=2E0=2E0=2E0/1 and</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                 * 128=2E0=2E0=
=2E0/1 is not needed on Android and will even</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                 * make some Android implementati=
ons (e=2Eg=2E Samsung)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 * misbehave, so silently ignore the flag and always use=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 * =
0=2E0=2E0=2E0/0 instead */</span><br><span>                 options-&gt;rou=
tes-&gt;flags |=3D RG_DEF1;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span>             }</span><br><span>             =
else if (streq(p[j], &quot;bypass-dhcp&quot;))</span><br><span>            =
 {</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/890?usp=3Demail">change 890</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/890?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d10=
3ea757 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 890 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>

</body></html>
--6Y6ImBKgTRs=--


--===============1973865304337471177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1973865304337471177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1973865304337471177==--

