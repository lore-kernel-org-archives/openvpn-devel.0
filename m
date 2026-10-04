Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F025CCA5FCE
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h1jvjIQiXkP2sZ0uhxGXTmz8rXW15t8vqX0jr9drxVk=; b=LafBAOdo2r5og3LCF5xkA0dNM7
	beStK3f+zAFviLUry4vtVXSaj4Hn5jmtjs57Z2m5g5pS3nVCUqDM0NbS7JqhmdgVBOCparoG1QR10
	g3cZx7ve/uVMcDRT6KMeNpLV0cIZRXUbFFfEUV+NHjp2jGAwzc3susaqAZdjZ9TF4mOU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDJPM-0003pk-CF;
	Sun, 04 Oct 2026 10:25:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDJPK-0003pd-70
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 10:25:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=G3rlCwIgFFdIlTfxAmfir8T+egli+hleeK7eI0m4eIA=; b=IDfxcAsjHYlsqnFuJfvYQIA3hJ
 RpMchsIUtchJYemSPhU20cxYhLSRbbi7dp4F/fN1gvSlJpsRN6TLCwhiplIoXw05rc0g4s1We6lSg
 brPWswsaJfQyCihEVXI7jaz7euxtjUM9vUdYGeMu0/oiAF1dSYKYLGoceNrgW9afEudg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=G3rlCwIgFFdIlTfxAmfir8T+egli+hleeK7eI0m4eIA=; b=Y
 Mmt4dPKyOPb0q3uNnBFY/N5aRaTznafOlH6Uqr3ZM3ITptLRU5FcOKdBEhEXDmMtWrKY3ulPPgFlG
 QaeXOJ/Rb33CDmOIT3E5nMY2QQNdhf1bryiUrMTFs9AVseNTMb7LYDkjPiMjmh3qCp3oysnNqfNOi
 bXxq3s4yQOsbPlJ8=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDJPK-0006Vj-7y for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 10:25:26 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48b03eb33b2so308481f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791109520; x=1791714320; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G3rlCwIgFFdIlTfxAmfir8T+egli+hleeK7eI0m4eIA=;
 b=KuzLOsTUpaHsNQpQLE0T13eT+ONqIVgNvEsocB6YU2Uv2iHm/yrjf1XkdoNbhuA8JC
 4jVbbDCmITBjiC8v58oCepbbhwMSZfkxa3mAV4GQnT28Uh0eFYVM6aKk3B/y9uCyqy6V
 24LHvbYYxLngkJBF2WjcfIw7j9Hw86Qlp8PEwhYa1go6GIRAYojTR1X96hZM5IZbdCS7
 d85M8e+Q46bSL8uRnQ9m3cbHOsd7NCqJAXh5++dSIAYPN0DJAwEbSmpDONkE/kRh4KWh
 BMLPf8HPocTI74ViPzDdYchy50Oaya3gr+pT5LWlkunIPAVj0o8U3uhI8tVK2gIrJwh4
 bg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791109520; x=1791714320;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=G3rlCwIgFFdIlTfxAmfir8T+egli+hleeK7eI0m4eIA=;
 b=Nl0EcuUIfFfSLaxSnC9xdt6Y4tY207ZKchX03PFIbGM/M5ymRA/494n3RS0pi5TM6p
 ldInlpoR9aLyjvg6plFfJgKDNUoiWcdXuUax3FdGX9kTQ60NT21N1UwBFMDn9Lgn/7Jt
 kkburDn/H2WpOEosQe9Hgo6q7uDbhHQD4QglRRrE4xAOhvjdv1PmFR9U3Go3eLhzC+QH
 NYZ5NcOv9lfVcE7Vpgvg/gsq0lPfjlWwZ2e/CZ+VamZ6P171ye77V7zgfdlc13Y/EBl2
 CTz0w5wAhaZziSYkYYRyf/0i5SqkcZI0+AORZvqtM2MbKngb/yu26W85/S8zGI9Mrao4
 zlGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgOY+qOQTNx9pSrughsEZDZIDQfU0PahRjaZiGCPamtxG9FM4Lv0eO7DINx0tKzBzC7Acs7Sq/A50z+UIS@lists.sourceforge.net
X-Gm-Message-State: AFuF++lIlKUff84Bi7ahtwRCTPtW9sQn63e2xvXGi9uNHIRiyGGKyqWc
 GPr91yY7ZQ+dVCkhSIeZbaDocwKBHmLr5X9CT8tZvOwjVqZ1vSpS4VLMidO0fCufILAGeUBm6Lw
 U3b32+FkmreFnSV3LT1yJvcX2cvn6NzxEGruv5PnYieBMRjDqurXKynSTLovrBakXT1xM
X-Gm-Gg: AYBFou1WeODgD0dMMHrLW7Cgu3wj4b7n50aNGoBSFg7oy3y9Oe1Jpgq5IOF+oQvDi3v
 4xzksGDUXtxTk4QXGZnBohRxIHASb8hPhLNVXpgv6l6hOQxuQrQSllxb96ud/0iYXEHO1MNXewh
 mGjZiwCsTeAoLwzvqwWTjLT2618w/pl24KODliwffqHZqJfWNr5I18UKAt1nAqXlnfwxdQQY4Pc
 w6Wluaux2sth3YwifUs2jbM7fX9aaz5ilhsOBvDSKLVjQhMK3Cs5mLycVOKO7sFHs7dny/+cM2K
 pjWOWalsRsrLQbqTrJGiJGr+MseOsFWFDD8H39q0nEYpST26jqAhstcJ/hVmqHAca1nHuYp8cg/
 wua4NHrNnTLY+alguClB4lujWEW4WXokiSHqdESW+fOpDnwHo+7ZaER2OU+Js23bUfbCx7LcUfo
 grQW6LJq/uztmAnJqIjCk8RXFxH0k6qWjL63HsUzFeC4skT70DoOOUj6N0j0bQay3rZoCpncXmb
 kPYhrlljFA/6YVYA+7QsMgzLaTv5BvMrC8V2jErI3jrFVUQjhZqFz7aTTDaskfM0xFbs2O/M5X0
 uQusetzupvPgGOiRFTzP/f6hWk6H+ZLcTA4I+g9F64xLLiBHE/b1G4XZ3DtE
X-Received: by 2002:a05:600c:3103:b0:4a0:1b14:d009 with SMTP id
 5b1f17b1804b1-4a0274bcaa6mr131898675e9.1.1791109519543; 
 Sun, 04 Oct 2026 03:25:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280c8bb0sm270670475e9.11.2026.10.04.03.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 03:25:19 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 4 Oct 2026 10:25:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
X-Gerrit-Change-Number: 890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/890?usp=email>
X-Gerrit-Commit: cb0aa9691012e936da7a1099e6e3e746500e531e
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzM5MzYxMjA0MDAwLkkyMmU0YjczZTc0NGM3NjVhNDNiZGIyOWY2ZTE4ODEzZDEwM2VhNzU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <901550c27065eff4155970243ad8d64516db6e12-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDJPK-0006Vj-7y
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6015710306429988114=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6015710306429988114==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T+eiEO3VVTs="; charset=UTF-8

--T+eiEO3VVTs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/890?usp=3Demail )

Change subject: Always use a 0=2E0=2E0=2E0/0=
 default on Android instead of def1
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Always use a 0=2E0=2E0=2E0/0 default on Android inst=
ead of def1

Certain handset manufacturers (like Samsung iirc)  are handlin=
g
0=2E0=2E0=2E0/0 different from the split /1 routes, so push the 0=2E0=2E0=
=2E0/0
route to the OS=2E

Change-Id: I22e4b73e744c765a43bdb29f6e18813d103e=
a757
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/890
Message-Id: <20261004100035=2E860-1-gert@greenie=2Emuc=2Ede>
UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg39688=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
=
M src/openvpn/options=2Ec
1 file changed, 7 insertions(+), 0 deletions(-)

=



diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 331=
6053=2E=2E5d10390 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/op=
tions=2Ec
@@ -5625,7 +5625,14 @@
             }
             else if (streq=
(p[j], "def1"))
             {
+#ifndef TARGET_ANDROID
+                /* =
The hack that def1 uses to split 0=2E0=2E0=2E0 into 0=2E0=2E0=2E0/1 and
+  =
               * 128=2E0=2E0=2E0/1 is not needed on Android and will even
+=
                 * make some Android implementations (e=2Eg=2E Samsung)
+  =
               * misbehave, so silently ignore the flag and always use
+   =
              * 0=2E0=2E0=2E0/0 instead */
                 options->routes=
->flags |=3D RG_DEF1;
+#endif
             }
             else if (streq(p[=
j], "bypass-dhcp"))
             {

-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/890?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
Gerrit-Change-Numbe=
r: 890
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--T+eiEO3VVTs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/890?usp=3Demail">View Change</a></p><div style=3D"wh=
ite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Always use a 0=2E0=2E0=2E0/0 defaul=
t on Android instead of def1<br><br>Certain handset manufacturers (like Sam=
sung iirc)  are handling<br>0=2E0=2E0=2E0/0 different from the split /1 rou=
tes, so push the 0=2E0=2E0=2E0/0<br>route to the OS=2E<br><br>Change-Id: I2=
2e4b73e744c765a43bdb29f6e18813d103ea757<br>Signed-off-by: Arne Schwabe &lt;=
arne@rfc2549=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890<br>Mess=
age-Id: &lt;20261004100035=2E860-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg396=
88=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M src/openvpn/options=2Ec<br>1 file changed, 7 insertions(+), 0 del=
etions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openv=
pn/options=2Ec</span><br><span>index 3316053=2E=2E5d10390 100644</span><br>=
<span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/optio=
ns=2Ec</span><br><span>@@ -5625,7 +5625,14 @@</span><br><span>             =
}</span><br><span>             else if (streq(p[j], &quot;def1&quot;))</spa=
n><br><span>             {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifndef TARGET_ANDROID</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                /* The hack that def1 uses to split 0=2E0=2E0=2E0=
 into 0=2E0=2E0=2E0/1 and</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                 * 128=2E0=2E0=2E0/1 is not needed on Android and wil=
l even</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
    * make some Android implementations (e=2Eg=2E Samsung)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                 * misbehave, so sil=
ently ignore the flag and always use</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                 * 0=2E0=2E0=2E0/0 instead */</span><br><s=
pan>                 options-&gt;routes-&gt;flags |=3D RG_DEF1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>        =
     }</span><br><span>             else if (streq(p[j], &quot;bypass-dhcp&=
quot;))</span><br><span>             {</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail">change=
 890</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
22e4b73e744c765a43bdb29f6e18813d103ea757 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 890 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--T+eiEO3VVTs=--


--===============6015710306429988114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6015710306429988114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6015710306429988114==--

