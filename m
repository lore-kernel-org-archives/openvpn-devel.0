Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CECC61DB9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yZdmHri6dqhxDg/ayuoJopFRDcq89NuMmk90KKQRZwA=; b=SC1I7puB2r36TzJi/hd+edwnE+
	NgR4adLxdRCrxjASEPevESH1kQcHoPcznAQDevU90bA2E9ftFojbM+j4iiO41m905NbuyVuqDjuWg
	DnfoqZDIk6kCfw89R3gy8A0obPt191W3TgybBmVfGHetvxuM6CL5GVbJK0Sew5lLsIJs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztkU-0005pv-Bp;
	Fri, 28 Aug 2026 10:23:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wztkT-0005po-5O
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:23:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=v5uklxhlKIoS94eGuglmLCSfenqUwUB9F62vYVWNX84=; b=UtCai9TIyQpnWmLRL3CpkOj3Id
 ZTp4YDMhlWi0cBOLga9m/Ob07RALwHcuWYrbaZ2wFVyH/m79N1032vA/zJboSz0H96Mn2UoA4AT3S
 jQoP6LSk2KUc79QVKqmKV+b1ApgP9ZhSnUb6q9x/SYQdwvfpr0AU+mm1SjRoqnoDLW88=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=v5uklxhlKIoS94eGuglmLCSfenqUwUB9F62vYVWNX84=; b=M
 aOvvLRODCuiRB/1bgnGRdOs5E/4c80H50OibMPaJHD90nLxJt9/a6Xb8Q5nYZssUEMlTorMru9C9D
 ikCgTCB76HNx1jYI4SUQ08Si+yCeZnxoh44+8JQpXetTDRsVHmGsm3iX9OD4o82CWD+FcN0AjBDSo
 sSuJ972QocZF/ycI=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wztkR-0007lL-0A for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:23:49 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so5447165e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787912620; x=1788517420; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v5uklxhlKIoS94eGuglmLCSfenqUwUB9F62vYVWNX84=;
 b=fpGGSWLO3ZdniPtwaB82ZKwkIhJWrvejhcO8d0hJkjUY+zJdPnlH+te5nupZus09Kz
 sSeFvs9oUlKw1iNyWxvCD3J2NsyYkLtW6Z/76tPGmNFXTW9HjltSn8oYcMxnooOvLEcX
 dJFXvebuQVCfgq22Nft784JexR467SnaJzjeQcRcORxvMVMQG9sRq7sPSQH7niMvSZNU
 FsJ1dvpr5yBKHKvyrCUL4DwHZoRmx9v3NOwWPKMM2tr4xIJQh1khMrrwoVc8osTLy6Kt
 gswlnIh0bE7uTuBdwz7n2c0tZYvfYov+Uhp1NacDl5SPcd1pd/kukk4Mtr/gVhOqGHFW
 Wl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787912620; x=1788517420;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=v5uklxhlKIoS94eGuglmLCSfenqUwUB9F62vYVWNX84=;
 b=tP9GVYBDK1xsqOgqEzszu+aiHRQfnnaVjic0fsYvR9CxvLLjxQG+aQNSpm9FkLYV6G
 KcujYxe6iyrnujqIF1w2iWhEYHdVY1zm19Gsi6PkdFR2khEarB6asoC6NyF8+aBZv+fV
 SDJP1Otxf3sIAfIK+joKUD4t99OVR/jdVRwTH8aFJ9xs4G8X2itky+AAmoRYlhLjixan
 M10xSIFhRh6ymVgnSL4T+r6zmI09noVFnSp52GndDbxTyXxcGgc9uB3lUJE3decXbVwI
 LwkySwLvuN6ZZ7saDKVya0ikSwFbdDlZJL3hd7QWxUxEjHBV+dm05XhXhMUf2pbs+qUF
 Ss6g==
X-Gm-Message-State: AFuF++kva0evHlDnwCWlDRsi1FwK4BMRPtZ8Hd/SYn+/cF8RiMTeMANT
 1LNORYXsavxUBsuMCfsI7vWV+FXHzL1Ps0mlt5zVJ3j6Cvv21Qi2OJBMPrxtAEr1LABjta1UkzY
 g+oFZKbrV/qFzVD8OcXxHIpX1PyBMAaRVbgZxV8cQ9s9544rsGt7iV07OoVGo80QD7vAa
X-Gm-Gg: AR+sD12eGmN/RiNJnktRQoV0WljqP2WXYEuwaeVJaPfgtm8VtZBlEkjRNpHs6AovLtQ
 f3B6EP1IU2n3W8TqasDnyup05a92cIFPcovXG+55hysit0wP1FgwAndt8a1TYpvNPXbx2L5Tb0+
 y0bNl2BWhUnat1ZtCTxanXKkej2bv/ugo55u7f+UD13JGHJ3paOrJ2NBhh1Ak103zq5b/w6K/bC
 VGwe9djoJqndLJ24QZT+a5SrYj2vOOS6upq/6K2k0KRcK51oCtQEm6H3p7hXNG+b3ZGrHUOqSIv
 ueF70uX1bz8l/rm5l7FtU36IsHlvLSXLAf6AZkTZBtFN1dKy8+4dfB5NiW9rRHilJ7c3E1aM9ZI
 RnfBTYomf5XBEEx6gc8Y0npyibrImqWQOxhVR/3jZF9Q3F3pzf5qDVU7FXYkO06lvE4sOrDQGdf
 I19F6IkB1l+ma95tyBTT40qwrHxuD7NZhPEo437wRETualv0ewguBku4eTaw/m2baUat5usVMn3
 kHPmlSUrfFXXhdieks3cnsf52MiMw+NuA93Am6l7zwPLcsjJKPBDuDCe9NrYAi5QktpUurSJdFM
 FzJ9acpSHxUn2BdjESuwZu63gsD8BrU2LyB/61bJ2kMV/cU94Io=
X-Received: by 2002:a7b:c30a:0:b0:49b:8c63:dfdf with SMTP id
 5b1f17b1804b1-49b91c5749fmr67338995e9.15.1787912619203; 
 Fri, 28 Aug 2026 03:23:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95013ce4sm36647855e9.14.2026.08.28.03.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:23:38 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 10:23:37 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7217d87a0f133e0bbee7896984e668cd28db73bd
X-Gerrit-Change-Number: 1864
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1864?usp=email>
X-Gerrit-Commit: 5aa5a11d395b9b18b9d814724eddb564e28d7e9d
In-Reply-To: <gerrit.1787570563000.I7217d87a0f133e0bbee7896984e668cd28db73bd@gerrit.openvpn.net>
References: <gerrit.1787570563000.I7217d87a0f133e0bbee7896984e668cd28db73bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkk3MjE3ZDg3YTBmMTMzZTBiYmVlNzg5Njk4NGU2NjhjZDI4ZGI3M2JkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f70c222d7851eb716bc49a6c3edea916f2619c4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wztkR-0007lL-0A
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5010626300120332268=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5010626300120332268==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="onUG9DNAB2s="; charset=UTF-8

--onUG9DNAB2s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1864?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: route: Remove unused function route_list_vpn_g=
ateway_needed
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


route: Remove unused function route_list_vpn_gateway_needed

This functio=
n has not been used since commit
840799182c0769c8ac9d014d09a497563516fc0d f=
rom 2011=2E
So it is probably safe to assume it is not useful=2E

Identifie=
d by cppcheck=2E

Change-Id: I7217d87a0f133e0bbee7896984e668cd28db73bd
Sign=
ed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1864
Message-Id: <20260826204139=2E28986-1-gert@greenie=2Emuc=2Ed=
e>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38743=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/route=2Eh
1 file changed, 0 insertions(+), 13 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/64=
/1864/3

diff --git a/src/openvpn/route=2Eh b/src/openvpn/route=2Eh
index b=
ae8659=2E=2E0d33d36 100644
--- a/src/openvpn/route=2Eh
+++ b/src/openvpn/ro=
ute=2Eh
@@ -407,19 +407,6 @@
     return mask;
 }
 
-static inline bool
-ro=
ute_list_vpn_gateway_needed(const struct route_list *rl)
-{
-    if (!rl)
-=
    {
-        return false;
-    }
-    else
-    {
-        return !(rl->=
spec=2Eflags & RTSA_REMOTE_ENDPOINT);
-    }
-}
-
 static inline int
 route=
_did_redirect_default_gateway(const struct route_list *rl)
 {

-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1864?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7217d87a0f133e0bbee7896984e66=
8cd28db73bd
Gerrit-Change-Number: 1864
Gerrit-PatchSet: 3
Gerrit-Owner: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--onUG9DNAB2s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1864?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">route: Remove unused fun=
ction route_list_vpn_gateway_needed<br><br>This function has not been used =
since commit<br>840799182c0769c8ac9d014d09a497563516fc0d from 2011=2E<br>So=
 it is probably safe to assume it is not useful=2E<br><br>Identified by cpp=
check=2E<br><br>Change-Id: I7217d87a0f133e0bbee7896984e668cd28db73bd<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1864<br>Message-Id: &lt;20260826204139=2E28986=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg38743=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Eh<=
br>1 file changed, 0 insertions(+), 13 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/64/186=
4/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/route=2Eh b/src/openvpn/route=2Eh</spa=
n><br><span>index bae8659=2E=2E0d33d36 100644</span><br><span>--- a/src/ope=
nvpn/route=2Eh</span><br><span>+++ b/src/openvpn/route=2Eh</span><br><span>=
@@ -407,19 +407,6 @@</span><br><span>     return mask;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-route_li=
st_vpn_gateway_needed(const struct route_list *rl)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (!rl)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return f=
alse;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return !(rl-&gt;spec=2Eflags &amp; RTSA_REMOTE_ENDP=
OINT);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> static inline int</span><br><span=
> route_did_redirect_default_gateway(const struct route_list *rl)</span><br=
><span> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1864?usp=3Demail">change 1864</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1864?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7217d=
87a0f133e0bbee7896984e668cd28db73bd </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1864 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>

</body></html>
--onUG9DNAB2s=--


--===============5010626300120332268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5010626300120332268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5010626300120332268==--

