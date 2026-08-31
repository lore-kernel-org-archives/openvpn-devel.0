Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63E9C624D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=dVnacYwFDNc/rzvBHDFEUMK5sllLZ4pCk0zXRSCZDTA=; b=OxtulHcKMYEubY
	pjlyO97iRjSV0lkg6z9AkCeqD57mKd90zQQDQ++zl38mKHwkNyMLLM7Fb5yp61kHTTVpdbI/6Mke1
	aC43iFMc0g8MdkKa3LD4KG7Ls+/4oKyOzfKsMjwcK6RspabbgtKhJzsv1rczlKurQfMKZnQbjivAt
	yhs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x14Tc-0000Lm-MP;
	Mon, 31 Aug 2026 16:03:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x14Tb-0000Jk-8S
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 16:03:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1mOHTZ5EOt1D+O+q8LX4oh9eEEP9nN/FYcS+NMkZPSI=; b=RB78zYMFiF55v8fVE0jc+r3Kvw
 vWFp0q0hL3aPcjtXGDUzHwNw9m/LJs5VcqjQ1Z+Q9istjjDOx6y0mrMB19LYEWF8NQ6FN8M93KsbE
 Xm1hghAGRsR/lM1WvTDMRNu/kYE3E0dn+bjem8SPKwT5TPb9idx45MhP5xj66ka12OK4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1mOHTZ5EOt1D+O+q8LX4oh9eEEP9nN/FYcS+NMkZPSI=; b=J
 PnWGoc7yQ1MXDv7b1dnvJMdVnUMN5zoSeByFY3PXf754hF6NWtE4BTmHzlT1nl1XuKy5DDWpEfNnz
 Wxrp5PNrytAv0vOzuypxVorD48IlU2QqUFI3WiXP+U5rDINlMlD8JLvZ3eoHigEwODwouTnBTHJS8
 ESMs13+Z0A1FV7gw=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x14Ta-0008D6-Cd for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 16:03:15 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4956869750eso24015465e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788192188; x=1788796988; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1mOHTZ5EOt1D+O+q8LX4oh9eEEP9nN/FYcS+NMkZPSI=;
 b=S6yigVyNqTMK9RRPzOYygxWrlVOP241YXoSsjS68lCPRdaBCqIM7dbWLkJmIqOYhpX
 JS4yK1/LZFEsRotIqj8jfqGokD0aXh+QKbFa3L9FIUrWB6Z/Qp4QhHP/pyjTapdnT/zP
 Dtey+PxI2aj0kSx1KMm3pSf+hWSh3ID6KCcst3xPADY0VMOfQbZYfDrB1LD7ElMrYERr
 cieU1F/lObC7wdbZ6VcmxZYxGj5iUPOwTMMqXNqHFt5V+tzSvY/x6VyjP3qulahAqQld
 JskQvwv3t1UeEYEa8mYC8jO57dEl5gl0DY5441B5r2hqMhejGVODeS9vM3puFU2V0ZWq
 qzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192188; x=1788796988;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1mOHTZ5EOt1D+O+q8LX4oh9eEEP9nN/FYcS+NMkZPSI=;
 b=kXEanb9MFnlubxDmdGufyK2NFdPa8/RY/MJs9VM1/ygTzjgu6cHWRsQvv3cSTohTq/
 dfr3Am5Jh/lHmZNzS6c7A+Xg0MpwnIku3ZLnzaVoYvH3SLOWWJXp1CfSBV/MFySa0YT7
 eb7DKps4XwNeo1sEkbGjBAaXfaAuqVP08pbp6dB6CPO8B1lKbblsPzl0Is/uZgX8sCIm
 +5GtZyXX6S2DEY7a5zRmgIH663yykG+KqhfLeF4MJC+/KOKWew1Wz/oMj4xpR2uAhXdt
 BgBDwB49DX8h4UI0k9APKbxeB98G0a5F+pU1wOOuHuQeaP5zpYeDYIit7VVRe2XUCucJ
 6fIw==
X-Gm-Message-State: AFuF++lKuLmgeLfBIMlTL05+TZz1b6QCVoBNT3ni6HnGi6NqR0dxLIZ6
 rKgpwA8Ob9oFmrwaZ4bwRhAP/vK+PhsNHws4ZqbupPj775JUOSGY/SI08PShGz+QwstO5aHEizN
 7mJhKg+b+tQRx8Nrr1gIK73TTPpSmQKBNUU/+3+bcBgAZdwd9Vbwh3J20S+/JuXsrWg9wuUz4Yz
 DdeKezag==
X-Gm-Gg: AR+sD10sClHnhzcXb7X/X7LjPkV3QhyYg5utWXR1XEUdxx1ACUDjFE7IGSylyVmCmTC
 zfGpJNp3uAJdpeMbh8SvZoX9XZnliq90STa8qHZQqft4fQCgzLFe38cIDmY9v3rfQVWOhAW9Cmy
 zjOxNfsxy+N6Vi5XV8+VfO0keSpVbU6kZ5a4jGUP1VhO4Vnx2/PnnUwWel8SjfrcBh42VokrYUL
 ilC7WqwiZcGcjL43N03FByKXTB6pTOQ18J4d3GCDXbJ/XXzvwRJl/fdZCw+dpInO/AR45ktWzAv
 Y5Itvu4fX/t5wlTWemy4m5WCqD2deILMfZ4j5dDv84OPiyT/BlynrCHkY7bEh2bAgDTq9tbRxKz
 eZTPShC3pELh2ns3G2YQGBee9BqagG/jZTQqxfT3lN1YFokqubKCpU4i2jfHi82LwB26rkLyXO1
 Rih2q+a2b1u6O7lA+LLvjb8Y03sGm3lCnDcv3B60BkA1p0cGLW8bJNvj5hIbjH1yWIS3EQubNNx
 95mkm723IGJ1BIozJW2n2K5ZZTb+p/x5Yln8zY0f/dHFLqnHzQSOdSSFKjxKk9n9tGWRe3aYEZ4
 GDcP2VwjZ7uJ1wNa9rfTYUDlH3Fucg9Zhmsj02UuW8UzJVutYGQ=
X-Received: by 2002:a05:600c:609a:b0:49b:9032:9c94 with SMTP id
 5b1f17b1804b1-49b91bd41eemr444271285e9.0.1788192187624; 
 Mon, 31 Aug 2026 09:03:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1025asm1992615e9.6.2026.08.31.09.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:03:07 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 16:03:06 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
X-Gerrit-Change-Number: 1885
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1885?usp=email>
X-Gerrit-Commit: c2db629bb5909a15c7408b3bca7971dbc3c8b1d1
References: <gerrit.1788192180000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkkzNzFhYWZiYTE4ZDMzNmJjZmQzOTEyZTkyYzE4MzAxZTM5YmY2MDg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f106e9c550e5db4316bc94bce0ecd0d48f68d429-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x14Ta-0008D6-Cd
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 allow '/' in config paths
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7733716096707012477=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7733716096707012477==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o2DCEhKvgP4="; charset=UTF-8

--o2DCEhKvgP4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos=2E

Hello plaisthos,=


I'd like you to do a code review=2E
Please visit

    http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1885?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: don't allow '/' in config paths
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: don't allow =
'/' in config paths

Do not allow forward slashes in user provided config p=
aths=2E The PathCch*
functions do not treat them as path separators, leadin=
g to "/=2E=2E/" not
being canonicalized=2E That, and the fact that Windows =
file APIs accept
forward slashes leads to possible directory traversal=2E

=
Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E=

Contributing Researcher: Vivek Parikh=2E

Reported-by: Vivek Parikh <vivek=
=2Eparikh@breachx=2Eai>
CVE: 2026-78043
Github: OpenVPN/openvpn-private-iss=
ues#162
Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
Signed-off-by:=
 Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M src/openvpnserv/validate=
=2Ec
1 file changed, 5 insertions(+), 0 deletions(-)



  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/85/1885/1

diff --git a/src=
/openvpnserv/validate=2Ec b/src/openvpnserv/validate=2Ec
index 7c0a87b=2E=
=2Ee3ef8b6 100644
--- a/src/openvpnserv/validate=2Ec
+++ b/src/openvpnserv/=
validate=2Ec
@@ -68,6 +68,11 @@
     {
         return FALSE;
     }
+    /=
* do not accept forward slashes in paths, as PathCch* functions do not hand=
le these */
+    if (wcschr(workdir, L'/') || wcschr(fname, L'/'))
+    {
+=
        return FALSE;
+    }
     /* convert fname to full canonical path *=
/
     if (PathIsRelativeW(fname))
     {

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
Gerrit-Cha=
nge-Number: 1885
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: d12fk <heiko@openvpn=2Enet>

--o2DCEhKvgP4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos=2E </p>
<p>cron2 would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">openvpnserv: don&#39;t allow &#39;/&#39; in config paths<br><br>Do not=
 allow forward slashes in user provided config paths=2E The PathCch*<br>fun=
ctions do not treat them as path separators, leading to &quot;/=2E=2E/&quot=
; not<br>being canonicalized=2E That, and the fact that Windows file APIs a=
ccept<br>forward slashes leads to possible directory traversal=2E<br><br>Di=
scovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E<b=
r>Contributing Researcher: Vivek Parikh=2E<br><br>Reported-by: Vivek Parikh=
 &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-78043<br>Github: OpenVPN/=
openvpn-private-issues#162<br>Change-Id: I371aafba18d336bcfd3912e92c18301e3=
9bf6087<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<b=
r>---<br>M src/openvpnserv/validate=2Ec<br>1 file changed, 5 insertions(+),=
 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/85/1885/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
nserv/validate=2Ec b/src/openvpnserv/validate=2Ec</span><br><span>index 7c0=
a87b=2E=2Ee3ef8b6 100644</span><br><span>--- a/src/openvpnserv/validate=2Ec=
</span><br><span>+++ b/src/openvpnserv/validate=2Ec</span><br><span>@@ -68,=
6 +68,11 @@</span><br><span>     {</span><br><span>         return FALSE;</=
span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* do not accept forward slashes in paths, as PathCch* functions do n=
ot handle these */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (wcschr(workdir, L&#39;/&#39;) || wcschr(fname, L&#39;/&#39;))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     /* convert =
fname to full canonical path */</span><br><span>     if (PathIsRelativeW(fn=
ame))</span><br><span>     {</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail"=
>change 1885</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I371aafba18d336bcfd3912e92c18301e39bf6087 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1885 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 =
&lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: d12fk &lt;heiko@openvpn=2Enet&gt; </div>

</bo=
dy></html>
--o2DCEhKvgP4=--


--===============7733716096707012477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7733716096707012477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7733716096707012477==--

