Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F11C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cjTfOQWuqWPzvG5zrdp4jKTwLPRx9fkkBKKLRGaARRM=; b=QeZQzzdDeL+YPhDE8Ptt+RxLMz
	wq33lMntWV9v1vyHAy643pLbWMHWXf6+ka2uHPPQGC34IRlQxByjFwFqpxpsbSZNuUZEEZOs1nDDJ
	GXIwqprzxPDieuIlbwiNBTuXKYeWrm+jsBRxEgpNgYzoOVLqEvlUNsvAnix3m47mBdy4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfEmJ-0002nP-OY;
	Thu, 02 Jul 2026 10:36:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfEmI-0002n3-4y
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 10:36:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CML1j5nF6ijlZb5VNX6jiubusMUfRFblZNRuQLdrFVk=; b=j7uLZhd9YCIeftgANmwAX/EwMC
 C0BXJc05GMUyctq3zNVpfj7FQDsurTootZqcbqWZ/gQ0WXb73d1Nhuj/6oVrxLvIIR644VKJ4Laoo
 Q4yn62J7Ww2K6njFJj3Pzqe7/AIODbywIwFRkPk5y88RxfUYYQ2fu6b5UM31I+fgTUfs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CML1j5nF6ijlZb5VNX6jiubusMUfRFblZNRuQLdrFVk=; b=k
 A8rPIEPzRdwoaSlY8cNBuVtCPojUVvEvL1jJEGiMwxXXphsrjcOGxXuE9R7ztCNp1jKvcCujERzrh
 S3oFmwFPOnIrLmjDh+5tSFU8hhaOaeQkbKAmOH5cNF0UB/wSw4dof8k6aUVC1ovl2/41ejXs6GSyj
 gkkT3kuXTjiCj0ag=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfEmG-0000UN-4g for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 10:36:18 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493bf73ec2aso9254245e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782988570; x=1783593370; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CML1j5nF6ijlZb5VNX6jiubusMUfRFblZNRuQLdrFVk=;
 b=QpDQ+seK1rzyD2EPbuDKGI0v1nimIYfeoi8V8iEZ33TOQt55wlnWOpb9U0RBZ3vibt
 7JTh0USoXUZl4HGiZmYbaEMJuSidM+R4I/LzbF4z72I9+ahpJyt35J3mA6vqKz/uA/yZ
 v/R/CRbLyRgIO6ZPSFSPlBoxCN5OxaiIN1P75RW78Oxg/PWUALICIVwEHOHJNt/05rYI
 smkheZEK2pwIcyd4aVoexaZPCHlcvtBQ6cjeLZP22c6FIqhEjFhdxRl7oHFvaCpxFVKi
 w+Qo5yjhrtZx7FiY5IrDK88KXOYCr6h9p0EXKQ5ccTiTxBdrEhV5chfcOK6zCisIDGMk
 kKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988570; x=1783593370;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CML1j5nF6ijlZb5VNX6jiubusMUfRFblZNRuQLdrFVk=;
 b=bw/x/IBS19ai19L/tq/MIFqcKYz8s+Of4B7KrPdZOMiDSZ1Y49/KjjHjqk5ds9gw2K
 tS8xbOsh8xOdg7b9G8hDkNOYVHsvOCKkLNmLIgW/yyYblewp57gT/cxhDs7KsPHrshkS
 cFihE+IxDk0KVGPohp7lPgvBYFoJfPCa7b7Vc+VKbnvd2vL4QCDIGpmSL1ULfhIrvNyZ
 0wIss81k6c9N0pqa8SMS81FvK9Mcucu6N4yT4xiNPnImCvOyGk401Dn95Gd/dcjzUc/1
 TYyNchPyPnKU6qh9GsmpJNUbmy62W9x+NDRr7JsIXK1tBay2uEzXiNTn2/B9aGLHBQ9F
 kpkQ==
X-Gm-Message-State: AOJu0Yy+1jIQzVY7ZQXKSMBe9UKA8k2RTGxVTKw0ainP7X3SH2vNxZs0
 IysJFzDtW0WY5D6wJtUjzCJGFl9+ZLMOnLO0jAgFBqbAP+IqIoinzj2BuwzuN3+xqwTnEwg+iBg
 Y6sv8is4XNtlgtWFZBo0aoehi6U/gsbR4af2MziFXnbx2pHGtReQAMpEJZfgIccFcBLoXqw+OKu
 E4YC7GbQ==
X-Gm-Gg: AfdE7cliGGKNW0F55fgkBP8dj/bWvrkyPQaFbnVPhW7+Wy5bH2aq4uJdqDWVZnjONws
 NQTeo3OQSu1r3jbYWWvthvIX7Dmv+2ds+NidrSB7Su0RZ5VW4ZK+OShdm0UJhiw4jzho/h/pGA1
 ReZBTLKJB66DTNTygM1keCdlL1vkJ+EM/fcLHBHeRT2vAttO/g1u6AvufzJWDw4sAvoLMonn1PH
 RlCoHm3WVXAZoaaaH9C5yiz7VqTzQYQGWUjkte/Bxb3HP7F40SCrpuT5I+5r++lBl619C9vsDPY
 wMRMo8Q4160uKv5l/McvxGfn26GBkTtW2US96uvt0QC1yyxw5Z73I8RjqqkXR8yIje6L4K1Sxvv
 EFnvQOwlyA2pov8DE+e7qnDokh/Y22/8/JdqmHNqrxA5cTbRGtdILx5DxPXIaEDXJF4G4+/EPTs
 vbWe1q1iIIlXi63cdS1AmEvKQIn0Vcb1DCb9Df/BpkD4UcqFZy2xCdAzvcUNI/Ji42yt8KxBzcO
 UtYEubPRnHfhiBU5CEtj3gwkPZd/JfYnAvCMUE2d5XICn3iWhzz87lWInkvSSj3e4/05+DPsEDv
 m6Q=
X-Received: by 2002:a05:600c:5307:b0:493:c3e0:c4 with SMTP id
 5b1f17b1804b1-493c3e00358mr61750735e9.22.1782988569944; 
 Thu, 02 Jul 2026 03:36:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477ddf0f27bsm7558834f8f.30.2026.07.02.03.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 03:36:09 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 2 Jul 2026 10:36:08 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I20cc89a546b69aceadcd1630828de407d530d7c7
X-Gerrit-Change-Number: 1765
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1765?usp=email>
X-Gerrit-Commit: d41472de0144f3c483a8397dea3bb55f00dc57e4
In-Reply-To: <gerrit.1782986182000.I20cc89a546b69aceadcd1630828de407d530d7c7@gerrit.openvpn.net>
References: <gerrit.1782986182000.I20cc89a546b69aceadcd1630828de407d530d7c7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTg2MTgyMDAwLkkyMGNjODlhNTQ2YjY5YWNlYWRjZDE2MzA4MjhkZTQwN2Q1MzBkN2M3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f9062f8c184b407daeb33ed4e087048a00aa4fc6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfEmG-0000UN-4g
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_pkt: Fix
 doxygen warning about read_control_auth
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3333239376868781379=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3333239376868781379==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tKP+R5PZ/q4="; charset=UTF-8

--tKP+R5PZ/q4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1765?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: ssl_pkt: Fix doxygen warning about read_control_=
auth
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_pkt=
: Fix doxygen warning about read_control_auth

Commit 01ee1693f960a696a613e=
7b83f9960002264a379
("Ensure tls-crypt keys are not setup twice") removed
t=
he argument but did not delete it from the doxygen
documentation, leading t=
o warnings=2E

Change-Id: I20cc89a546b69aceadcd1630828de407d530d7c7
Signed-=
off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1765
Message-Id: <20260702100704=2E24692-1-gert@greenie=2Emuc=2Ede>
U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg37459=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---=

M src/openvpn/ssl_pkt=2Eh
1 file changed, 0 insertions(+), 1 deletion(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/1765=
/2

diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 64=
0885e=2E=2E82cb5b1 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/s=
sl_pkt=2Eh
@@ -207,7 +207,6 @@
  * @param ctx               control channel=
 security context
  * @param from              incoming link socket address=

  * @param opt               tls options struct for the session
- * @param=
 initial_packet    whether this is the initial packet for the connection
  =
* @return                  if the packet was successfully processed
  */
 b=
ool read_control_auth(struct buffer *buf, struct tls_wrap_ctx *ctx,

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1765?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I20cc89a546b69aceadcd163=
0828de407d530d7c7
Gerrit-Change-Number: 1765
Gerrit-PatchSet: 2
Gerrit-Owne=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@gree=
nie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--tKP+R5PZ/q4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1765?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">ssl_pkt: Fix doxygen warni=
ng about read_control_auth<br><br>Commit 01ee1693f960a696a613e7b83f99600022=
64a379<br>(&quot;Ensure tls-crypt keys are not setup twice&quot;) removed<b=
r>the argument but did not delete it from the doxygen<br>documentation, lea=
ding to warnings=2E<br><br>Change-Id: I20cc89a546b69aceadcd1630828de407d530=
d7c7<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br=
>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1765<br>Message-Id: &lt;202607021007=
04=2E24692-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37459=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
ssl_pkt=2Eh<br>1 file changed, 0 insertions(+), 1 deletion(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/65/1765/2</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ss=
l_pkt=2Eh</span><br><span>index 640885e=2E=2E82cb5b1 100644</span><br><span=
>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2E=
h</span><br><span>@@ -207,7 +207,6 @@</span><br><span>  * @param ctx       =
        control channel security context</span><br><span>  * @param from   =
           incoming link socket address</span><br><span>  * @param opt     =
          tls options struct for the session</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * @param initial_packet    whether this is the init=
ial packet for the connection</span><br><span>  * @return                  =
if the packet was successfully processed</span><br><span>  */</span><br><sp=
an> bool read_control_auth(struct buffer *buf, struct tls_wrap_ctx *ctx,</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1765?usp=3Demail">change 1765</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1765?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I20cc89a546b69acea=
dcd1630828de407d530d7c7 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1765 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--tKP+R5PZ/q4=--


--===============3333239376868781379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3333239376868781379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3333239376868781379==--

