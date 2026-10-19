Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DF0CCF2DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=25qkLni0Sv1oQiXFkuUj7EBWtN1nKtqaUDAwyRFgrJ4=; b=MQXGd5AAhZ2akB39Gq/kl3JoXR
	+OfU7yZtp0uSiqJb4zCtAAXveQWIXZ11yAIbSCSTnm1xXFSkAf8ui6bi4s5yOKbppKEQuSSoRbgaz
	6N9WF6igBKLCgr+Wa+9EY0/udTBjRyrbKfzm04Ajty7ABVE6nQPgQGoYQBs6ghziO9n8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIn1G-0003em-Te;
	Mon, 19 Oct 2026 13:03:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIn1E-0003eV-KU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:03:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6Ox/2ULWgbe4UWrDn2ue2u6DJNS3u1/3ru5c35zQttA=; b=fIt4aliZMU5+jS8XPfTaVy/fGn
 /kMSbEJ9ApuUty9WyWPZQKXsjnQoip0ZN8rAfx2imcDiLdkbii6WtU4GXZF1U6yGhg1Lxu+8eeCdz
 NWeTaWouzBVLAn/953cZAtHY1XlbnpZniHHg7T8Dcp01oPFXB9ByozvZy9dpGjAUN0L8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6Ox/2ULWgbe4UWrDn2ue2u6DJNS3u1/3ru5c35zQttA=; b=F
 TLJYLrt0goYuu74889oAIj/n5si5hh4nhbIImA2QwAh90WoOu6J/fidR/8tOj6igBnAVJ3qkOPbcR
 HS29typY/lYIpO6p7r5T1G+dMx2173SNv25T9+nx4dv414N2G3myBZjprPW5OE4c7UAROYfnE3Dmd
 XB7G5vt4IuVdg698=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIn1E-0002CO-Fx for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:03:13 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1115195f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 06:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792414986; x=1793019786; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6Ox/2ULWgbe4UWrDn2ue2u6DJNS3u1/3ru5c35zQttA=;
 b=ahtAShUdR4p293UX1eBhgGIiWHIW4T7hMd1lfTZVXP2dH/Xb3GY7W+4d2lSkLaQ+6e
 ZGh827fv0m/0lyuLouS/T96ZlTNt8E13nAE4FG5iAeDn4rHTHw61dVEudC7hNV1SxmJP
 +3b4+f97frnet/9Wqpj5D7c64CMw+O2lVGkfcG02n9NPg3I2hYMo7nEYs3mFseTQYFYk
 2u4PFzokrU0wpQjEEhGKQG8ksziToFShygKB5tiwH/9zrkc0i9VAeGdu9NkjhcevUEkF
 ciKWPVL2fdf9M5KK3vcNCvgqx0nb5m4N/jz+nQpvWFdv39GRvgao5YRXmGDUGwGP2qtF
 Sl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792414986; x=1793019786;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6Ox/2ULWgbe4UWrDn2ue2u6DJNS3u1/3ru5c35zQttA=;
 b=kAC0INZ/Ub1jq04WIrfHo6M+WXYug3YumbF/fUje2HyEbwdMOY7Vt/vEq+w+ILGHNt
 YAHlk9WYcnmxn7uEnkj0Ea1Sr8C4B4gihUVKff3AAZ0cAGkyTaCJHcbJHfeJQgZ3MPmm
 JeDUhG+V6hYBmaBT4b4UmdSLE8nHY4wcdXxpQHGMxi6BbDwIfvcapq4Ju+0My0/CnKPo
 x3h0+htOT4eqippxVzFkfgIxlDITclDqfGZtcgTzBvjhzyza9RV8MckqskUskXLDt2Be
 XCcssNLcCZVYlDpo2QZeHMnFbbJytXMB2vYMjviYVrEwYVFYk/RDAS+QJo2kHJtfTycK
 vxeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByovZ1FmLx/2WeNcpYwgOb6yKpGCNKtyJ+oHac/l1/PI2Fre+UPfbIiTCCpgXItOxQqYV2DCy4DVCByvJGK@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJuJ0NZNeti1gKfxKnj3CldMnTDbJsS7R8O3k4gaBpDSv5lKm9B
 lHhgXjuSfJw3CJhYkYQUbPuS4ADmPPQW41518xBAy+3SL3HEMnYvNZVOTe7QagGBFc+33rNJyR0
 Sjq1DRpbR3ByDRC8pc/YiqryC2q/o3M1O99cUAGM6cTxlP2+Cw4mNiK6YqYAR8sg1YobARaY6TO
 B8H5mmWg==
X-Gm-Gg: AYBFou1QrczGsQEEIoib8cqirRYQN/zhoMez3IlWU4OsEXvtktnLnC9aUIrYNFHeRgS
 RcF7VXTcSIUjecD4wBzqOazSY7r6S5V4zv4ZaZdQajDUUYFbpRt9ePcs2xEIuqaLWXZ6K+G2fPB
 sbjPhikPD+PoCEiYnXxbpAuoQCRuCzQB8AfuQZbnzV9XzqiOzot8hzEuclNlCYSnrcJMquHstOx
 FodSao4lnlG4A++MxEZTqNl5o3N/ULzbz3lbjtJZCewVTQF8KVsHGV64zO8KXb/zpcNYWNPUh+w
 w1fJU3tFL49801nauD0GCmFXyWa3cgbBZYEBtxIk6eyb5UjuUPqV8UWTS1eo6jrCi+8Kb2H1lJl
 lZzkSOEG2eqEbgctotMV9oUFVf4YbURy3Og2PWrgbFf116SwvdUUG+95G+XGlLCj7Wb+g89RAI2
 K84aNHCeC3bmS0CfD6TYjP7syzMius3Rhd28t1qRh6jA5OHAl3VB5jy7cdE+rmzsDMnQF1SaJAW
 gm4mopjmudqA5VZEad+xPjt3262AZWirbZy2dRxXDxw36ND+TZMBBOAQNxvknsDsTvcIgiiQp9J
 bCNjeFq8JGMTeNvB5RYlJ07436h0nIzZTVWMRbXXO365fgRa4+rLTIA++OFL
X-Received: by 2002:a05:600c:3f0c:b0:4a1:e383:6811 with SMTP id
 5b1f17b1804b1-4a1e3836c4amr85631385e9.29.1792414982761; 
 Mon, 19 Oct 2026 06:03:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cca31234sm190373685e9.4.2026.10.19.06.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:03:00 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 13:03:00 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0245175f2884d56838990f53cee6381b981b79c1
X-Gerrit-Change-Number: 2004
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2004?usp=email>
X-Gerrit-Commit: c005931524986bdab3e4f82b8b41756d49c24950
In-Reply-To: <gerrit.1792255622000.I0245175f2884d56838990f53cee6381b981b79c1@gerrit.openvpn.net>
References: <gerrit.1792255622000.I0245175f2884d56838990f53cee6381b981b79c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkkwMjQ1MTc1ZjI4ODRkNTY4Mzg5OTBmNTNjZWU2MzgxYjk4MWI3OWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cd89f5e0f90372f40e8f54d524f8f88e0f750ee9-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIn1E-0002CO-Fx
Subject: [Openvpn-devel] [S] Change in openvpn[master]: misc: Avoid
 conversion warnings in parse_auth_challenge
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4467404608175703875=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4467404608175703875==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vcWcy/F3sNc="; charset=UTF-8

--vcWcy/F3sNc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2004?usp=3Demail )

Change subject: misc: Avoid conversion warn=
ings in parse_auth_challenge
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

misc: Avoid conversion warnings in parse_auth_challenge

M=
ake sure we have a sane length and convert it int=2E

Change-Id: I0245175f2=
884d56838990f53cee6381b981b79c1
Signed-off-by: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by:=
 Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2004
Message-Id: <20261018153738=2E23274-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40030=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/misc=2Ec
1 file changed, 13 insertions(+), 1=
8 deletions(-)




diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec=

index b9cc6a2=2E=2E304a87e 100644
--- a/src/openvpn/misc=2Ec
+++ b/src/ope=
nvpn/misc=2Ec
@@ -72,11 +72,6 @@
 #endif
 }
 
-#if defined(__GNUC__) || def=
ined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignore=
d "-Wconversion"
-#endif
-
 #ifdef ENABLE_MANAGEMENT
 /* Get username/passw=
ord from the management interface */
 static bool
@@ -127,19 +122,23 @@
 pa=
rse_auth_challenge(const char *auth_challenge, struct gc_arena *gc)
 {
    =
 ASSERT(auth_challenge);
+    const size_t len =3D strlen(auth_challenge);
=
+    if (!buf_size_valid(len))
+    {
+        return NULL;
+    }
 
-    s=
truct auth_challenge_info *ac;
-    const int len =3D strlen(auth_challenge=
);
-    char *work =3D (char *)gc_malloc(len + 1, false, gc);
-    const ch=
ar *cp;
+    const int work_len =3D (int)len + 1;
+    char *work =3D (char=
 *)gc_malloc(work_len, false, gc);
 
     struct buffer b;
     buf_set_rea=
d(&b, (const uint8_t *)auth_challenge, len);
 
+    struct auth_challenge_i=
nfo *ac;
     ALLOC_OBJ_CLEAR_GC(ac, struct auth_challenge_info, gc);
 
   =
  /* parse prefix */
-    if (!buf_parse(&b, ':', work, len))
+    if (!buf=
_parse(&b, ':', work, work_len))
     {
         return NULL;
     }
@@ -14=
9,11 +148,11 @@
     }
 
     /* parse flags */
-    if (!buf_parse(&b, ':'=
, work, len))
+    if (!buf_parse(&b, ':', work, work_len))
     {
        =
 return NULL;
     }
-    for (cp =3D work; *cp !=3D '\0'; ++cp)
+    for (=
const char *cp =3D work; *cp !=3D '\0'; ++cp)
     {
         const char c =
=3D *cp;
         if (c =3D=3D 'E')
@@ -167,14 +166,14 @@
     }
 
     /* =
parse state ID */
-    if (!buf_parse(&b, ':', work, len))
+    if (!buf_pa=
rse(&b, ':', work, work_len))
     {
         return NULL;
     }
     ac->=
state_id =3D string_alloc(work, gc);
 
     /* parse user name */
-    if (=
!buf_parse(&b, ':', work, len))
+    if (!buf_parse(&b, ':', work, work_len=
))
     {
         return NULL;
     }
@@ -189,10 +188,6 @@
 
 #endif /* if=
def ENABLE_MANAGEMENT */
 
-#if defined(__GNUC__) || defined(__clang__)
-#p=
ragma GCC diagnostic pop
-#endif
-
 /*
  * Get and store a username/passwor=
d
  */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0245175f2884=
d56838990f53cee6381b981b79c1
Gerrit-Change-Number: 2004
Gerrit-PatchSet: 2
=
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--vcWcy/F3sNc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2004?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">misc: Avoid conversion warnings in=
 parse_auth_challenge<br><br>Make sure we have a sane length and convert it=
 int=2E<br><br>Change-Id: I0245175f2884d56838990f53cee6381b981b79c1<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: R=
azvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2004<br>Message-Id: &lt;20261018153738=2E23274-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg40030=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/misc=2Ec<br>1 file changed=
, 13 insertions(+), 18 deletions(-)<br><br></pre>
<pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><span>index b9cc6a2=2E=2E304a8=
7e 100644</span><br><span>--- a/src/openvpn/misc=2Ec</span><br><span>+++ b/=
src/openvpn/misc=2Ec</span><br><span>@@ -72,11 +72,6 @@</span><br><span> #e=
ndif</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic igno=
red &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> /* Get username/passwor=
d from the management interface */</span><br><span> static bool</span><br><=
span>@@ -127,19 +122,23 @@</span><br><span> parse_auth_challenge(const char=
 *auth_challenge, struct gc_arena *gc)</span><br><span> {</span><br><span> =
    ASSERT(auth_challenge);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const size_t len =3D strlen(auth_challenge);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!buf_size_valid(len))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct auth_challenge_info *ac;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int len =3D st=
rlen(auth_challenge);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    char *work =3D (char *)gc_malloc(len + 1, false, gc);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const char *cp;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const int work_len =3D (int)len + 1=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *work =3D=
 (char *)gc_malloc(work_len, false, gc);</span><br><span> </span><br><span>=
     struct buffer b;</span><br><span>     buf_set_read(&amp;b, (const uint=
8_t *)auth_challenge, len);</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct auth_challenge_info *ac;</span><br><sp=
an>     ALLOC_OBJ_CLEAR_GC(ac, struct auth_challenge_info, gc);</span><br><=
span> </span><br><span>     /* parse prefix */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!buf_parse(&amp;b, &#39;:&#39;, work, len)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_parse=
(&amp;b, &#39;:&#39;, work, work_len))</span><br><span>     {</span><br><sp=
an>         return NULL;</span><br><span>     }</span><br><span>@@ -149,11 =
+148,11 @@</span><br><span>     }</span><br><span> </span><br><span>     /*=
 parse flags */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (!buf_parse(&amp;b, &#39;:&#39;, work, len))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!buf_parse(&amp;b, &#39;:&#39;, work, wor=
k_len))</span><br><span>     {</span><br><span>         return NULL;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    f=
or (cp =3D work; *cp !=3D &#39;\0&#39;; ++cp)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (const char *cp =3D work; *cp !=3D &#39;\=
0&#39;; ++cp)</span><br><span>     {</span><br><span>         const char c =
=3D *cp;</span><br><span>         if (c =3D=3D &#39;E&#39;)</span><br><span=
>@@ -167,14 +166,14 @@</span><br><span>     }</span><br><span> </span><br><=
span>     /* parse state ID */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (!buf_parse(&amp;b, &#39;:&#39;, work, len))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_parse(&amp;b, &#39;:&=
#39;, work, work_len))</span><br><span>     {</span><br><span>         retu=
rn NULL;</span><br><span>     }</span><br><span>     ac-&gt;state_id =3D st=
ring_alloc(work, gc);</span><br><span> </span><br><span>     /* parse user =
name */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_p=
arse(&amp;b, &#39;:&#39;, work, len))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!buf_parse(&amp;b, &#39;:&#39;, work, work_len))<=
/span><br><span>     {</span><br><span>         return NULL;</span><br><spa=
n>     }</span><br><span>@@ -189,10 +188,6 @@</span><br><span> </span><br><=
span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC di=
agnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</sp=
an><br><span>  * Get and store a username/password</span><br><span>  */</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2004?usp=3Demail">change 2004</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2004?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I0245175f2884d56838990f53cee6381b981b7=
9c1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2004 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--vcWcy/F3sNc=--


--===============4467404608175703875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4467404608175703875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4467404608175703875==--

