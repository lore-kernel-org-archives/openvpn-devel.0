Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E32CC5AD5A
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 23:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f4qO+jgj7z4x56XwnAuCTapdZAgaWiF1wbw+rAzHDuE=; b=h7Z0k/cd6z2tbIsl4Nzd71BGQJ
	D9KPgJi/IM8LAeZM2eFDx/J60xqJBf1d/cxbsum4SqwSEITbv2kEvGA7+C5lpWitt43iYqeYtolTJ
	t2obxDIorcQ//vABiNnuIe7m191EIpswZXi2an2Gpu0+quD0QrkADd1XuqCvSSGuHsrQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtCau-0001BO-1u;
	Sun, 09 Aug 2026 23:06:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtCat-0001BI-9D
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 23:06:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jrUOMRZ8MvOTliPJNDqHzERPnBQS+o//cjWkX/XPUxU=; b=QabnxojxUVe53ATjCHL/KUvFB7
 0BUJpa79Th8yUnTL3BLD2aMfgDmJN4uzSmH4rBzrruhzU2nR8hbe5dGQpgF1Bs400dPAU3WKu0fzU
 axwXskah9WSuczIOXAcUCXt3i8aa9dPgVQQJboVgtQFddpqwgl6SGxstdybrahdP+dV4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jrUOMRZ8MvOTliPJNDqHzERPnBQS+o//cjWkX/XPUxU=; b=m
 TtIlgX90zpA/tTmaI9YSH30O/P8InuSnx/xsIbae6SWGgssZOxy5LeWcuuaE5pmX/R3fr/oq0jS7E
 IssGaVcMHrFKMfvp7YVP1HQLD/El/souOgEMuXgL8V7Ya5o8a/MqBsSZcMXjyJyOgAUKoPMZyPDxd
 5bgjgnRjvdQSkE84=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtCat-0006BI-5K for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 23:06:15 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso8284765e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 09 Aug 2026 16:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786316769; x=1786921569; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jrUOMRZ8MvOTliPJNDqHzERPnBQS+o//cjWkX/XPUxU=;
 b=fIC3LqcRV0m+UQTi9ijYg7GFAmWotAnsV8tFLLb+rpeENvnyuk3dbqs0UhKiynQzhd
 x0Y8Jt5HqzY5lNAhCZLqMbG1QEyAv8zhCTnv5ChlAm+ueiAPJksdBLjGGGqKo+vU0wA0
 hCBQcO4HDp/AV5T7sH/+4E45Nl+xPOblmmI01yMeZVe6hQrWc4FPmrgRBKx61jZli+J2
 KcWBU7RsEYyZ01DS4AX3EKliFC0YFjUxfbuAFPU5MrJECHJ6G5r1f+qlY3EIzP188o9F
 ajo8QsFKyNzviPnBG1bQlOlDL1np5w7diPHdC5bnqAZ6XjduaGgfnvqZ499tUK8lnm9+
 T80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786316769; x=1786921569;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jrUOMRZ8MvOTliPJNDqHzERPnBQS+o//cjWkX/XPUxU=;
 b=pF63ypgY5fE5XYLzEYhLms3KZLAjyTaCTSTcEAOoTaxPCXBCX10udKH8eF/cjjwMWB
 Kn5Ac8wlv61PdzgiVYN/3LM9RmDFOuHv98Oz4X9/fzSPYX0O524UIAYJq+tTUt5jQi2+
 jm9Bv0aYnA8E1P5b2ejzmcdGMhUXpZrm17omzO+ZHyWdeMfVjQtk1RlwMHG3GKoiW3pS
 1/4SrmKAbZaJLDqdUebCVNUtzkl4GZmE+whCyaSw8sPQIbpgSUHUsyJXjMOTqZes/GAO
 LmDmktnRBVgL42k6yfXQk0A3bDEIEUVc1DeMw6ljgiZlBGt/LMFaK3dZUZpJLDOl7/Wa
 A6HA==
X-Gm-Message-State: AOJu0Yy+c0Pp3i6pj8EmlUs9BC3yy8GhXX9dj+2b11EvN904tN3ndggs
 BpGhdYlYErrM2XRsZCraIkYnTsjo23woR6itiQx8k7X/X6OIN3DFxnlvp/NNUdpS3GCHk+Q5fPf
 Uf/C2++7cFkU7UsHl3M1UuB/UmZ0XGWOllmUCYDCovQmsr2VadgVyX8+m8IF8bQCnr26bFnhy2o
 xLtA+EXQ==
X-Gm-Gg: AR+sD132MybTGtu9Z70bVqTKebmV/CDz3XYgvxq+OtgCmGpXqwAmA/XCk2cnDbx0vQr
 iFmFlZpEeTbqtwzdVMoYyq3XFOdwHs6LAD4h9f9JR4zNqfUUDlXSFWyMAQEGpAtfxu1HhJ/twbb
 Pg3K0Y0X+qiQ5U5v/5b2ZbcdGAbRrbxvUcL0YtBfHonsduiasgJBUIO9cBwNmsBc51FwgoXeZfy
 r/uom5nFrx4RHoKZod9opjjhl93ILFXPHZsywsine+ao+ikAgQvP5pMM2FWJorpJamm8Qt9YqKt
 wLTlNRzSZ39++QIsGCw5DJ37uDYFou+b5L4CgJGN7rLKJNXrzsBfVpRQbcSr9ay3tO2IMt3ikMO
 +A4DmA6sZzBseyfucpDsdE070XfJusesi3GQ997mjys9Z5x0QhtWipeBBTuN3g8BEQ0bxMnU973
 WyIrhNc/3ley3MzpHORgaVHDId1vzkEhYmHK0oUVr1MPbIi9nCCu8cRNyvN8GgSor5ncQukEbAP
 1yiiL/iXljBs4O1C0m/tScCYFcQz7loxI8OPOA+0Lrg5YHIyl5FvH7FnBUfC88hbL/I9HsYzK75
 bwlvxeUwE+MGsjJfTsDO4WuNTd52T4rkvmASfQ2A5KrrrGrjhXY=
X-Received: by 2002:a7b:cd19:0:b0:495:4bf3:2150 with SMTP id
 5b1f17b1804b1-4994e7af664mr394385335e9.8.1786316768544; 
 Sun, 09 Aug 2026 16:06:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9e7164sm293769335e9.2.2026.08.09.16.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 16:06:08 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 9 Aug 2026 23:06:06 +0000
To: flichtenheld <frank@lichtenheld.com>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
X-Gerrit-Change-Number: 1837
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1837?usp=email>
X-Gerrit-Commit: dbd79e213684a510530c1e9bcd57afad5a654523
In-Reply-To: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
References: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1OTMxNzkzMDAwLkk3MjgwNjdlZjA4NDgxYzg3YzdiNjkxOGM4OGViY2FlZWVjNDY2NTM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1aed16e5f427f1b54df5850a933afe7b7d85ed7d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtCat-0006BI-5K
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Reenable xmit_hold
 when using p2p tcp-server and tls-server
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, max@max-fillinger.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3004962264362670085=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3004962264362670085==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8xIVNRSZ02Y="; charset=UTF-8

--8xIVNRSZ02Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld=2E

Hello MaxF, fl=
ichtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail

to look at the new p=
atch set (#3)=2E

The following approvals got outdated and were removed:
Co=
de-Review-1 by MaxF


Change subject: Reenable xmit_hold when using p2p tcp=
-server and tls-server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Reenable xmit_hold when using p2p tcp-server and tls-server

Com=
mit 619c3e9 changed the logic to enable xmit_hold only
when c->mode is CM_C=
HILD_TOP=2E This works for --mode server and
was probably done to allow to =
properly work when the server
is listening on multiple sockets and options-=
>ce=2Eproto cannot be used
to determine if this socket is tcp or udp=2E

Re=
store the logic for p2p to avoid both sides starting sending
resets at the =
same time=2E

Closes: openvpn/openvpn#1089
Change-Id: I728067ef08481c87c7b6=
918c88ebcaeeec466534
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M=
 src/openvpn/init=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)


  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/1837/3

di=
ff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 69d226d=2E=2E0=
8278fc2 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -33=
32,7 +3332,7 @@
 
     /* should we not xmit any packets until we get an in=
itial
      * response from client? */
-    if (to=2Eserver && c->mode =3D=
=3D CM_CHILD_TCP)
+    if (to=2Eserver && (c->mode =3D=3D CM_CHILD_TCP || (=
c->mode =3D=3D CM_P2P && options->ce=2Eproto =3D=3D PROTO_TCP_SERVER)))
   =
  {
         to=2Exmit_hold =3D true;
     }

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
Gerri=
t-Change-Number: 1837
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: MaxF <max@max-fillinger=2Enet>
Gerrit-R=
eviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>

--8xIVNRSZ02Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, flichtenheld=2E </p>
<p>plaisthos <strong>uploa=
ded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail">View Change</a></p><p>The fo=
llowing approvals got outdated and were removed:
Code-Review-1 by MaxF</p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Reenable xmit_hold when using p2p tcp-server and tls-server<br=
><br>Commit 619c3e9 changed the logic to enable xmit_hold only<br>when c-&g=
t;mode is CM_CHILD_TOP=2E This works for --mode server and<br>was probably =
done to allow to properly work when the server<br>is listening on multiple =
sockets and options-&gt;ce=2Eproto cannot be used<br>to determine if this s=
ocket is tcp or udp=2E<br><br>Restore the logic for p2p to avoid both sides=
 starting sending<br>resets at the same time=2E<br><br>Closes: openvpn/open=
vpn#1089<br>Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534<br>Signed-=
off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/ini=
t=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/=
1837/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</sp=
an><br><span>index 69d226d=2E=2E08278fc2 100644</span><br><span>--- a/src/o=
penvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>=
@@ -3332,7 +3332,7 @@</span><br><span> </span><br><span>     /* should we n=
ot xmit any packets until we get an initial</span><br><span>      * respons=
e from client? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (to=2Eserver &amp;&amp; c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (to=2Eserver &amp;&amp; (c-&g=
t;mode =3D=3D CM_CHILD_TCP || (c-&gt;mode =3D=3D CM_P2P &amp;&amp; options-=
&gt;ce=2Eproto =3D=3D PROTO_TCP_SERVER)))</span><br><span>     {</span><br>=
<span>         to=2Exmit_hold =3D true;</span><br><span>     }</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1837?usp=3Demail">change 1837</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I728067ef08481c87c7b6918c8=
8ebcaeeec466534 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
837 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@max-f=
illinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: MaxF &lt;max@max-fillinger=2Enet&gt; </div>

</body></html>
--8xIVNRSZ02Y=--


--===============3004962264362670085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3004962264362670085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3004962264362670085==--

