Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3C9C61DD6
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ehkznMw+J/3C7nuDhh7hFpv9oUOceRkNesLa1+u6xmo=; b=lQ9pjl0kyyP8EL549NMyPONXeg
	O7CiVSVW+kjjb9IiL/7/I2hUPw9dsr5C5IfzUJAIsdUbCB9t8DnuBsrChqLU2lSVl0QPHugwyywY6
	tqdRXn0GqLKzlpY4aXdeHgoqirLMKYeYR+eCgm64nZyip2VZ41rs4Rqk1b3qyGOxjPmo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztkW-0000Tg-9w;
	Fri, 28 Aug 2026 10:23:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wztkT-0000TM-Ng
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:23:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=E9WzsvS0zORscRyfJY4W17M4a/qEbVt5BanauvmrhVg=; b=Ny+u8Fi7dyI7PP+fKPBZFpTKIe
 NfK95sfRh0gx+yr/JKG3DXZggvDZnx5KAANsoW3rHMc06XRcea7U2OPXgcRkeXibYVSCUxuzR8H/C
 0MyuqKg+UETqTFsJ1PHr37PBW2YSb1Cm8vr/zzcowQsgJ+1EBUTAjF1TXork1WPH7eFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=E9WzsvS0zORscRyfJY4W17M4a/qEbVt5BanauvmrhVg=; b=Y
 in9eFdpVVhJwK2AQUUTP2bl91+R9MzsUi/0/3x+66fW6jcBzG+yYdzkKFmHIC5ET2BoL7zvly6M/v
 l6i6GY9e6/o5xgCTqR66gjwd48AQsHfAIMMCFbnVpyPcy6XwO2ggN+o9NX/+oEO/5hjrI97aXXbvo
 P0jsj2nCFkDtCgYw=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wztkQ-00019E-Vi for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:23:50 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47fecbb7000so248472f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787912620; x=1788517420; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E9WzsvS0zORscRyfJY4W17M4a/qEbVt5BanauvmrhVg=;
 b=MISU67bk9CH5qdcay0cVQo24bSdSrM4Vo6iFkcvJHBhGceqJwXIpsAX9H5dhluLmUz
 SVMyK4T6HcPj5kB2h/XBdKe0HZKS3xF2AdzEYgmaMpe3gd4O2AlwXLax83Yq83lv/ZJT
 vOldqdLLlgVqhCxtjjm9wVytC+3c4YVZ269wTMhTdTRf7eEw2sHc1wdGl2H/egHkyYrq
 yYgtpLuHrXNsHX29nAd7+D+H2RtDkxl9jIJqqztI4gW5eHv73BcffaM5ZOtm6J6fyNVw
 0aZsgO51HreHhAh/D4IoXlHI3lRf3kElbPS6+LMdmwUdo/0QfFnRtcY1TtLjz7ihRoOV
 THgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787912620; x=1788517420;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=E9WzsvS0zORscRyfJY4W17M4a/qEbVt5BanauvmrhVg=;
 b=o6y/wcsJXKvfW11Eh+7gVG2rts5l2/iqDuGA3hIRlGGLrNkeUMYbIjeLVHwAECoIu3
 4cI3wr3A45G5Zat2eQo7EjHut5wq4vorsuPLNnd12J2WDsfkEojSUMO8R26MNkx8AMjy
 SImq9Y+EqBW20UxMHxcRW5dMY79sXG7y95EIGmKpx2IVnLbpYW21+7348QDzVqeEnD5O
 uzzBVD+MMlHqy4KUENzzqTzAHgekIl9gb9VGYnckaJ/lkh5dEGliVjQmIapXVvsDJGRs
 BtfDLvI9dZR613WOowV54XABSLwr9ApFyIucNUZF4jD5Zp1LvHNWNekG1c4i4zcXErQB
 KtXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWj0f+PssTyjPudXeLIQauJBnOPehiJilrkBRtmK5AwxNCTNVO581xh1O61nBePoyXP/Dt5aliUCPwtfgP@lists.sourceforge.net
X-Gm-Message-State: AFuF++kKMA1ObsUHjHoVVMpIMbjsfrUr829q4RVic+T2BjyfMCLsZMf3
 x2u+XNEw7BjCx/5uLRbNvDtyqOOoZ7DVmxAYZaiXGPfK/CJ/5T+4paQbZ/6K9BLcgxPEvXdraBV
 Zov8/OeDMBf3RMhAgL9cRLw6o/ysGCLzmMxiUy6IV9VWyY9l2+GiJIy+wUUJ9SUmcvqmU
X-Gm-Gg: AR+sD13GKfEcaU/uppNSY+sHZelVwD3AYxGRLWgY5xcjRMoHM8ioxFWOax4IvwKjNCH
 69DB+uBCij1HIjw3/MrA4unYGbHkgTnNka19dbO8/i44P6+F9ZOtAHGTc1Mvl0ru4GKZMOnPFyS
 FkcBWgYPABGKxeyh1BOL4JvPqBWe2/+2c1lOS2GnP84xqZWemtliHYgJ6ko1gwtajqT3cjvNbJG
 gblZN2NLknUlxgFCGtaYfSEKaccpxN9IuoaQQn7Lpbfy8Nm9t0unKEmZ8A1aTLyame8U6MXkgxf
 BvEugRYoJM68tJ8+4+8OaD+pSTGWfiWjyGAoVuOabGBD0JUa/uymdMfrI+gCs2/GBeQyuTg0dGM
 FkwWsCyhPxz+q/q56xmbPJM2F1GnysjzdtJ1L1+m9vRnfETd8NgLZsUhSirA2J2/3DXLROEDvug
 g7WBlLK3TwJzDRnvEkPCsvx6WwhrtFBVNWjZGfIuf5/22Hm4jhk/K7BoBsz+QI+BVyWg5Ybw4eA
 owLCgPXvOGQcZtHDsJSeoLYaHR4NaRZT8uNLHl7Ss08JbQe3Ens1WpgSqmcfyOI4sMFwADU65Jf
 M8Z598osw5JlWA3KFhV11wxUHNHGnTYZashQMIeZtrY/0cVKivk=
X-Received: by 2002:a05:6000:18af:b0:482:9dc6:16c4 with SMTP id
 ffacd0b85a97d-482f798ba02mr9803290f8f.1.1787912620258; 
 Fri, 28 Aug 2026 03:23:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbac4d0asm3107547f8f.10.2026.08.28.03.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:23:39 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 10:23:39 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7217d87a0f133e0bbee7896984e668cd28db73bd
X-Gerrit-Change-Number: 1864
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1864?usp=email>
X-Gerrit-Commit: 5aa5a11d395b9b18b9d814724eddb564e28d7e9d
In-Reply-To: <gerrit.1787570563000.I7217d87a0f133e0bbee7896984e668cd28db73bd@gerrit.openvpn.net>
References: <gerrit.1787570563000.I7217d87a0f133e0bbee7896984e668cd28db73bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkk3MjE3ZDg3YTBmMTMzZTBiYmVlNzg5Njk4NGU2NjhjZDI4ZGI3M2JkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f70c222d7851eb716bc49a6c3edea916f2619c4-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wztkQ-00019E-Vi
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2346469397203319790=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2346469397203319790==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uLvQgy9lGB0="; charset=UTF-8

--uLvQgy9lGB0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1864?usp=3Demail )

Change subject: route: Remove unused function route=
_list_vpn_gateway_needed
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

route: Remove unused function route_list_vpn_gateway_needed

=
This function has not been used since commit
840799182c0769c8ac9d014d09a497=
563516fc0d from 2011=2E
So it is probably safe to assume it is not useful=
=2E

Identified by cppcheck=2E

Change-Id: I7217d87a0f133e0bbee7896984e668c=
d28db73bd
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-=
by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1864
Message-Id: <20260826204139=2E28986-1-gert@gre=
enie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg38743=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/route=2Eh
1 file changed, 0 insertions(+)=
, 13 deletions(-)




diff --git a/src/openvpn/route=2Eh b/src/openvpn/rout=
e=2Eh
index bae8659=2E=2E0d33d36 100644
--- a/src/openvpn/route=2Eh
+++ b/s=
rc/openvpn/route=2Eh
@@ -407,19 +407,6 @@
     return mask;
 }
 
-static in=
line bool
-route_list_vpn_gateway_needed(const struct route_list *rl)
-{
- =
   if (!rl)
-    {
-        return false;
-    }
-    else
-    {
-        =
return !(rl->spec=2Eflags & RTSA_REMOTE_ENDPOINT);
-    }
-}
-
 static inli=
ne int
 route_did_redirect_default_gateway(const struct route_list *rl)
 {
=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1864?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7217d87a0f133e0bbee=
7896984e668cd28db73bd
Gerrit-Change-Number: 1864
Gerrit-PatchSet: 3
Gerrit-=
Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--uLvQgy9lGB0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1864?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">route: Remove unused function route_list_v=
pn_gateway_needed<br><br>This function has not been used since commit<br>84=
0799182c0769c8ac9d014d09a497563516fc0d from 2011=2E<br>So it is probably sa=
fe to assume it is not useful=2E<br><br>Identified by cppcheck=2E<br><br>Ch=
ange-Id: I7217d87a0f133e0bbee7896984e668cd28db73bd<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1864<br>Message-Id: &lt;20260826204139=2E28986-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg38743=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Eh<br>1 file change=
d, 0 insertions(+), 13 deletions(-)<br><br></pre>
<pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/route=2Eh b/src/openvpn/route=2Eh</span><br><span>index bae8659=2E=2E0d3=
3d36 100644</span><br><span>--- a/src/openvpn/route=2Eh</span><br><span>+++=
 b/src/openvpn/route=2Eh</span><br><span>@@ -407,19 +407,6 @@</span><br><sp=
an>     return mask;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-route_list_vpn_gateway_needed(const struct=
 route_list *rl)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!rl)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return !(rl-=
&gt;spec=2Eflags &amp; RTSA_REMOTE_ENDPOINT);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> static inline int</span><br><span> route_did_redirect_default_gateway=
(const struct route_list *rl)</span><br><span> {</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1864?usp=3Demail">change 1864</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1864?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I7217d87a0f133e0bbee7896984e668cd28db73bd </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1864 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> =
Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--uLvQgy9lGB0=--


--===============2346469397203319790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2346469397203319790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2346469397203319790==--

