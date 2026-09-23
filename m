Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDBDC9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=UGbuDGpueiF2PYVATjBvg3r8IFaKgEBWK5XIygUvIP4=; b=GlHbQ11003r+WC
	woeutoRGlOB9v5O6krzp3PBp/vsJ4wWqu5q/IPTFgrKzVREtvE2+PKmv8UPsjTwMrMdp0URCMZ2WG
	CsHdZQxREveobVNfd6y84uGtPBjVy3LRjO7BQI8d0IQCDyZJkloRABN9yQ2/1HO/q8cVHoFYdKxm8
	XUI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9MHv-0005Z6-5u;
	Wed, 23 Sep 2026 12:41:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9MHt-0005Z0-P5
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 12:41:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F3+1zJCEJDoXuBFD11fWApwacaL+wr0VYd6zWHwYTNY=; b=CDSLBmzCv06D2lvZmZbZgwFwc+
 NyKgVHAcJ+hoFFreh+a8c6el+7ib/V+4WOEqKsjka3SfTRE8AaD8lzByCU4M9j9dCExmvvd63yzZa
 uqF9B2s9LmW2J4WTWcKg5227MzwiJWY4Uo2ak3C60LCA5siVlPtgOOUXpXNPdcK9ukxQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F3+1zJCEJDoXuBFD11fWApwacaL+wr0VYd6zWHwYTNY=; b=F
 jiEcS0c4e655etd/BG5MqbdiCDiAh9JJ3Yj2Vy4a6PnGZm7z+Du9fHPJqR7xvQWt8l7PFiOertaku
 LGIM6kjotcU2xu9uiQ+qDOWIQ+L2K4JBdjSFOZMiKMtxMMNcg5EaGUNJsqYwuuKlI0B+exs2wZY0G
 VJgWRnRCaLpT+I8U=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9MHs-0007zs-Qu for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 12:41:26 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so4693925e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790167278; x=1790772078; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F3+1zJCEJDoXuBFD11fWApwacaL+wr0VYd6zWHwYTNY=;
 b=epw2TkyDWy+FcGlB/Xxq4tn+tdmqT4uiDmrMQ+D46BZB8bmssKbOM+g+fP2Judy2le
 vTQraXNOTUKDc0+rLMVT37SQp4CyEeKNhlBC9ITJjtzZVyHVPOFxFwLkywMUVKEIOQd3
 OOb8G+WFaNWMzVqDQC+Rc00P098PSI4buykEAD8I3JTw7KbwZaOmG1sv5HGdT63ai7aQ
 jNHctBkBk7w1v1shGNyeeKs3JR6r9d8twCiGnZJuXPj4oRLVIX3seyYljGtR+ODGIu8D
 XaQeottR3EfhXNcwuP1ZbNffmXXC0oDgH+smFjFjQcJ+VrT7rGqlm9I+Frp0R/IYoODr
 HavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790167278; x=1790772078;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F3+1zJCEJDoXuBFD11fWApwacaL+wr0VYd6zWHwYTNY=;
 b=ZE369IdU4IuQ8JA6Q+XewydpC4YAsM3TKoOWr3Hx0qDFFa7qs22updzfO9AddviuAp
 wOkOKf27t2xrFfXq10ktzwb2S9GMuVxBIiG9+Aez7ajmTu6eF+nkEey5l6hIyMRBlzQm
 QZ6CJ6UNSqWrfLV4Uf0NiDpVdxVHd/bxRhAUJitpk6o22RUa2sTeEEKhiv/6XXO7dKie
 bU9QROGv0+nL4yUp5FnHLHFQD5W+9AZVgXJXJSdbk3DodAk3XWmtTr3R2Uxmo8WOukRn
 Y13iIxptDEhoafAagUV5UgPy7OrskNLAHiPE619xU+hbE30/MKo1yD3RiJE2t2RBg5cK
 VA0Q==
X-Gm-Message-State: AFuF++mUEhrRQktT+o0U6GeVFJslhC9BGRnxAQqIxBuj41z18dgwXmdu
 wIBrEOst772uKcca8SHZPO1rhL0/voUBukY7fDNz9ZVml4r3dRbey4CP9I54etjw1Ua4djmngGJ
 RB4sPK0eMXMN/g4HW4g/6i58KM9dHxGY1mOYY43sHSKx5PJ5lt2Vg9ovz6KmQ8JYwLAh24/HMNw
 FvTM6V9w==
X-Gm-Gg: AYBFou3MeQ0EypFRhavd4zh06EbXFN0hePsqxwRBB9KxqodIvWMhwbUL5ax48V2va2V
 6e6t56F7U3xp2A4KFeqSVhqA7odowgqTmoTU0jX9+xNvtyF32CemmN99dKmU/Qt25OWEHZZAdNt
 cc/pusZhmqPOINAtkHmA+ogUSymbOzgqKHjSFjFqqHuYl/p3hf2VjAuVOlo0izo4blbbEaQZtgJ
 4GoVEA+RH71Dk1+8qsr6I7UTKGB2xt3b01CPaiSrt68zO0hd8i5/DVEloX+ot1VsE5UMskQ+XAJ
 4F65p4xkYZW3uRDdzIQSGcyPSb/UOU01nh9NJcfdd2K7IukiHckZVCc93mHqaqdeq0azYsXuHUV
 mgXU+xnIHk7Q9RDbVRaWw/v2gmJsPiXBwC9tua+Yj+oOf9FH0Uzd2djZc7Uh2dCEH0CLoH52LJ5
 hPX61UZyhdJRsnKNW0y62repeE2laujOnhcS5wbU2VIM0uJjcaI8ASsYYVX4RT9iQbdAJ/KvoMw
 XOWaUnINlOWf1R0JtMdgAf6xCE0Uhn1UOE1pACUQ4i36qtDpQ7m97tKmHnbyeC2gka/oyHQcnNw
 h+6wKuY+oQVF4WpOOtxi9y5V3atzaUyEEIlhsTMaiOZqHyrO0lES2gDCv1ww
X-Received: by 2002:a05:600c:4455:b0:49f:c18a:61c8 with SMTP id
 5b1f17b1804b1-49fdf15100bmr33318575e9.29.1790167278038; 
 Wed, 23 Sep 2026 05:41:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe3d7916asm18463895e9.15.2026.09.23.05.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:41:17 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 12:41:17 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If276bd4c5d07fcd26f6749f514f0257eab73249f
X-Gerrit-Change-Number: 1945
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1945?usp=email>
X-Gerrit-Commit: dad238d7807324a3ff14a3a53cee24db17e986d2
References: <gerrit.1790167275000.If276bd4c5d07fcd26f6749f514f0257eab73249f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMTY3Mjc1MDAwLklmMjc2YmQ0YzVkMDdmY2QyNmY2NzQ5ZjUxNGYwMjU3ZWFiNzMyNDlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d748927ee5a8c6aa866012a1809c122b938ed23-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9MHs-0007zs-Qu
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: proxy:
 Work-around spurious warning on mingw builds
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1446906705788670480=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1446906705788670480==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7/2di70BKmk="; charset=UTF-8

--7/2di70BKmk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1945?usp=3Demail

to review the following change=2E


Chang=
e subject: proxy: Work-around spurious warning on mingw builds
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

proxy: Work-around spurio=
us warning on mingw builds

mingw in Ubuntu 26=2E04 has issues with checkin=
g snprintf
format strings against original MS implementation even
though it=
 uses the GCC implementation=2E

Apply work-around that is good enough for =
code that is
already gone in master=2E

Change-Id: If276bd4c5d07fcd26f6749f=
514f0257eab73249f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
---
M src/openvpn/proxy=2Ec
1 file changed, 3 insertions(+), 1 deletion(-=
)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/=
1945/1

diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index 71=
01d9f=2E=2E857bf03 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/pro=
xy=2Ec
@@ -767,7 +767,9 @@
 
                 char get[80];
               =
  CLEAR(buf2);
-                snprintf(get, sizeof(get), "%%*s NTLM %%%zu=
s", sizeof(buf2) - 1);
+                /* mingw checks calls to the builti=
n snprintf() with the
+                 * ms_printf archetype, which does n=
ot know the 'z' modifier */
+                snprintf(get, sizeof(get), "%%=
*s NTLM %%%us", (unsigned int)(sizeof(buf2) - 1));
                 nparms =
=3D sscanf(buf, get, buf2);
 
                 /* check for "Proxy-Authenti=
cate: NTLM TlRM=2E=2E=2E" */

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1945?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
G=
errit-Change-Id: If276bd4c5d07fcd26f6749f514f0257eab73249f
Gerrit-Change-Nu=
mber: 1945
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--7/2di70BKmk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1945?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">proxy: Work-around spurious warning on mingw builds<br><br>mingw in Ub=
untu 26=2E04 has issues with checking snprintf<br>format strings against or=
iginal MS implementation even<br>though it uses the GCC implementation=2E<b=
r><br>Apply work-around that is good enough for code that is<br>already gon=
e in master=2E<br><br>Change-Id: If276bd4c5d07fcd26f6749f514f0257eab73249f<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<=
br>M src/openvpn/proxy=2Ec<br>1 file changed, 3 insertions(+), 1 deletion(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/45/1945/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/proxy=2Ec b/s=
rc/openvpn/proxy=2Ec</span><br><span>index 7101d9f=2E=2E857bf03 100644</spa=
n><br><span>--- a/src/openvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/p=
roxy=2Ec</span><br><span>@@ -767,7 +767,9 @@</span><br><span> </span><br><s=
pan>                 char get[80];</span><br><span>                 CLEAR(b=
uf2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
snprintf(get, sizeof(get), &quot;%%*s NTLM %%%zus&quot;, sizeof(buf2) - 1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* =
mingw checks calls to the builtin snprintf() with the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 * ms_printf archetype, w=
hich does not know the &#39;z&#39; modifier */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                snprintf(get, sizeof(get), &quot=
;%%*s NTLM %%%us&quot;, (unsigned int)(sizeof(buf2) - 1));</span><br><span>=
                 nparms =3D sscanf(buf, get, buf2);</span><br><span> </span=
><br><span>                 /* check for &quot;Proxy-Authenticate: NTLM TlR=
M=2E=2E=2E&quot; */</span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1945?usp=3Demail">change 1945</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1945?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: re=
lease/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: If276bd4c=
5d07fcd26f6749f514f0257eab73249f </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1945 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--7/2di70BKmk=--


--===============1446906705788670480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1446906705788670480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1446906705788670480==--

