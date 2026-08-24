Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A3EC5DF94
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ietaebX+nxuGa1jsYCnhLz39E2Vl6UkqZR1WXgQ9H7c=; b=A2cL6RWq4GhREa
	8ZrmbS8DELxxj89M3AWF0xe2mbVQ7sS91KqEQu/ewNFxhuZeVb8cIOOp6UXrWq56v1FJ6V8GUTEHL
	N/2LXdyL/zGaLXWcmBvvqsFkoCCyyqV0IOZhTfjJMA76cs2hiImy6KtYO1wtwLc3rGFBCcKlt2KSH
	dFk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wySlz-0001Ln-DN;
	Mon, 24 Aug 2026 11:23:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wySly-0001Lb-I0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DlT848NJ2eP8ACsIivcG9tyOFbCftleUJ3UNbsdyP1M=; b=Qi3Uvs126Ib2VZrpxvtnfDba2j
 QU3fRy5tH6Y6BTWiLbsFl7IU3FZHT2UcIST25M22tes4U7xIltj2v0UezVBKg+wDBfKXm1nBGsoQS
 X9Fo1Ml+dYpq1Mdp2nVBSyBsuBz5cKjiskdyt7CIEG9dVwwz51962MgJNB4hWlB+wuvU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DlT848NJ2eP8ACsIivcG9tyOFbCftleUJ3UNbsdyP1M=; b=B
 Ov0ZXQrssHCDA6eNxAztHvfn2dT08vb2wjhKdAd9AjdnkVx4BG3eZdWmkcd7lHqKP2MlNvrU9xryb
 3cwFQKrG3am3/HO00SkqRSuTU9BVKwj3nrEJ0nx2Ol7wj2tOm3PxJo5s0K+P4bYhtQV8e+JzQXrK9
 f7x2RdGI4+Msh3tc=;
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySlx-0006z0-Uj for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:27 +0000
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso5351923a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 04:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787570599; x=1788175399; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DlT848NJ2eP8ACsIivcG9tyOFbCftleUJ3UNbsdyP1M=;
 b=I4oyY7pGF8f7h4C9P/6SolTiZOAaFDrxz3he7g0oakpi0wK1y0XDgxUgmrUONOdcxp
 6LXUq4WsgNFz1mI25EWeTWlOq+9uFhW8zcIslEchw/SFHn5qNMuvpm4ueES/6hjqRhV6
 9oOfmV1G4m+SM5zKOQmtXtO3JO58XaD7intoybeJzm4tktug9EVc4FvSfaiZGcFWereE
 wlenzCv3AJOrF3Gv7y6grkUDkmYGUrGmjdFbNLewywhqZTVC9Wr3vTsTKijBW9gz5FC/
 kJybTfR958wiIPQ1amrbpxYGDBUW6iAQP7ZcBWUxt53rkPx9enfwGSQ2M25RGAK4Ot8G
 Uaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570599; x=1788175399;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DlT848NJ2eP8ACsIivcG9tyOFbCftleUJ3UNbsdyP1M=;
 b=IvhBdE0Vnh0RyF2tLmbJIvvQFh66OvIUJIZxpwictlw4CR7v8O1TtHIyB09Tlx1tQf
 Qsg//QQ+up9uwydPly3yqSOJlSH5eYLh+96+K55Phte/5RMHV2IOGX70RcfKuDW+J41Y
 1uM9xcbILL0iHBupiknckAvlq20/RIYxhD4ML2hYMY0NB0kLUlgW25b9MaTkVkbIzE3Q
 XS+PKsRk7KcAHghZBTVvYmXMndS9CjH2YBXlFKYeoH3MRryL3ZVKVQrjQF+3MbKFeL3b
 hGWw2JSciULKMb6CEOe96nwDRY60+OC4EUs3pVK8JEuBgYXpEeYl9Kn54Avb75RfKsAt
 cAEw==
X-Gm-Message-State: AFuF++kc1Z8SQojAcr8t9cDfxEoXNdL48XotLamRzDMOfV81mbbEVtoy
 KCDABp1nRxH6VteOrp7atSQLhojD8JrclwQbZ9Jl41XowdeSom03+jC8S6gECesAcxu8z4I2GXF
 ok2yw+/JQCw2FPIbaVtKSmf5FkpTdXkRsez+KwkRXVKdJsoDoNC2HP31mrpCuZiXvLNYpOBnyJG
 DNi68Liw==
X-Gm-Gg: AR+sD10Gzy18+0+D4ARk22DTV2wrK2AClOUOXfwVgDhbcbVSUr3jlgGw2yGGrHJ+vKD
 G9yeYfkQzysPnhgzWPpSSPgGV8QN/LUPe7ZcOiZINpSh/rGA43BKQy3MnSQpudq+i1iAhCDu5Tz
 WhXR+5nyX7tQjyItNU/15GoKos0GZd8ByHVK4oZZPX2i+DBpAgOxkATHLXGqAtTGS5kySp0PRml
 zrv0x2ReHMyUEAkw0OsWmXOQ0nQYVy0jfWeFHMJsjBJ5KlJDNH9J2edB7T0d7vjvWn8AKym1reU
 1j1dMHazBor6cfeiRoyw4MUXrBkhgIOn42P5lpI4LeqDW44XDhUL8pjFy40fRTDRHGQj8LZfqDD
 /gTipoQNN3WGByaRQasaeIhuIud62dvLNzeT8azU05qjpRAIWBveSLWpQhkAeXlLpXpbtZskUnA
 6juPVCjrciHNDwBUXtOgG8a1obk8xm6ktbfKQNR2o6wrnixUAY0mx3gl2W/jnfkbUHQSsaeQfpF
 LYqGKBDb6ysVk6DWeXSgzovkEkVDih9AnNoZ/s3ifuSkYnEmDaN2vFqY/DnV+9R4kpuugavSWBA
 rr1POdOOGH/Z6sybygYa3BbhyVPT81Jd9ZIdT+aZT9v7ONmI5YE=
X-Received: by 2002:a05:6402:21d4:b0:69a:928:9405 with SMTP id
 4fb4d7f45d1cf-6a582af8853mr17835299a12.1.1787570599215; 
 Mon, 24 Aug 2026 04:23:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e199ad5sm8211545a12.18.2026.08.24.04.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:23:18 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 11:23:17 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7217d87a0f133e0bbee7896984e668cd28db73bd
X-Gerrit-Change-Number: 1864
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1864?usp=email>
X-Gerrit-Commit: 125bc44b89748f0b83699712eab699e5858257e2
References: <gerrit.1787570563000.I7217d87a0f133e0bbee7896984e668cd28db73bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkk3MjE3ZDg3YTBmMTMzZTBiYmVlNzg5Njk4NGU2NjhjZDI4ZGI3M2JkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <21db88f22b29ec07558e3af5a9cca55b8a90bfc7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wySlx-0006z0-Uj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: Remove unused
 function route_list_vpn_gateway_needed
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
Content-Type: multipart/mixed; boundary="===============1724945713253138172=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1724945713253138172==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k925kS9rayE="; charset=UTF-8

--k925kS9rayE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1864?usp=3Demail

to review the following change=2E


Chang=
e subject: route: Remove unused function route_list_vpn_gateway_needed
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: Remove un=
used function route_list_vpn_gateway_needed

This function has not been use=
d since commit
840799182c0769c8ac9d014d09a497563516fc0d from 2011=2E
So it =
is probably safe to assume it is not useful=2E

Identified by cppcheck=2E

=
Change-Id: I7217d87a0f133e0bbee7896984e668cd28db73bd
Signed-off-by: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/route=2Eh
1 file cha=
nged, 0 insertions(+), 13 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/64/1864/1

diff --git a/src/openvpn/route=
=2Eh b/src/openvpn/route=2Eh
index 88107e9=2E=2E473df87 100644
--- a/src/op=
envpn/route=2Eh
+++ b/src/openvpn/route=2Eh
@@ -409,19 +409,6 @@
     retur=
n mask;
 }
 
-static inline bool
-route_list_vpn_gateway_needed(const struc=
t route_list *rl)
-{
-    if (!rl)
-    {
-        return false;
-    }
-  =
  else
-    {
-        return !(rl->spec=2Eflags & RTSA_REMOTE_ENDPOINT);
-=
    }
-}
-
 static inline int
 route_did_redirect_default_gateway(const str=
uct route_list *rl)
 {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1864?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I7217d87a0f133e0bbee7896984e668cd28db73bd
Gerrit-Change-Number: 1864
Ge=
rrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>

--k925kS9rayE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1864?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">route: Remove unused function route_list_vpn_gateway_needed<br><br>Thi=
s function has not been used since commit<br>840799182c0769c8ac9d014d09a497=
563516fc0d from 2011=2E<br>So it is probably safe to assume it is not usefu=
l=2E<br><br>Identified by cppcheck=2E<br><br>Change-Id: I7217d87a0f133e0bbe=
e7896984e668cd28db73bd<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt;<br>---<br>M src/openvpn/route=2Eh<br>1 file changed, 0 inse=
rtions(+), 13 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/64/1864/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/route=2Eh b/src/openvpn/route=2Eh</span><br><span>index 88107e9=
=2E=2E473df87 100644</span><br><span>--- a/src/openvpn/route=2Eh</span><br>=
<span>+++ b/src/openvpn/route=2Eh</span><br><span>@@ -409,19 +409,6 @@</spa=
n><br><span>     return mask;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-route_list_vpn_gateway_needed(con=
st struct route_list *rl)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!rl)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn !(rl-&gt;spec=2Eflags &amp; RTSA_REMOTE_ENDPOINT);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> static inline int</span><br><span> route_did_redirect_defaul=
t_gateway(const struct route_list *rl)</span><br><span> {</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1864?usp=3Demail">change 1864</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1864?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I7217d87a0f133e0bbee7896984e668cd28db=
73bd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1864 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>

</body></html>
--k925kS9rayE=--


--===============1724945713253138172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1724945713253138172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1724945713253138172==--

