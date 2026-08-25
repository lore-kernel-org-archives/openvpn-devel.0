Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E064C5DF94
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xtWwP2aUtH4ysOWRvOYQRXCe3LO3r18l93KomdXuxso=; b=eeVgz1KAWUOPqcoLLSkjk9I19y
	TNoQ/seQ9m7AQ4YqGkAgoiZ55ckfpegTJzSgbtgJdMsA6EiRh7BtsV+VzxERflaN1zkA7f0gfW74Z
	G7FP+XzyoZvTOqpRCDTMjMPRe13uYI05Kpi+Wdug2sW44LGoTl8m14h52iWhn4hYw8OA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyljK-0004J1-Ng;
	Tue, 25 Aug 2026 07:37:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyljJ-0004Iv-2t
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:37:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UCdvUdvf1p+Y7/BNibilE881QN78uHmE9/Xc5Rb3pTY=; b=YVLRsLCl6VPNbDVtgjK3d7Trq5
 CFIqRa/ZVTtnJG+JqNxZvbhQsy296Ssjws6FCvITsZFn0PI4jMrg9VzYR4Mji0qxQ7FRGa4Dp58W8
 NiAymgmKXatMwikBBFAq3EiTfylW6ACRWr7Qu6YZB4k7R2UXrpuobmKpE+Z/t/ikOCF4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UCdvUdvf1p+Y7/BNibilE881QN78uHmE9/Xc5Rb3pTY=; b=e
 r3syZT7H3aIDV8aqHIno959z+C6eQriGC1Ol2LmFCvKsZEDR8+/RG/HP9Qt10MHmlXHuYiTp03+sp
 Uv7sG4PcEJT0UxBV5lrB0z4M0nJFq3iJS3Ef8P2n6O6gqiF8ysX/D/NdJufP4Q9QuREGX8589ZVBi
 H2B4pzJAMsMgvixw=;
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyljH-0000a1-LJ for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:37:57 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so506180466b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 00:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787643469; x=1788248269; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UCdvUdvf1p+Y7/BNibilE881QN78uHmE9/Xc5Rb3pTY=;
 b=WkPu+PtmdFpodvtoJf7ougNouWDZuE76beHCLAKN44VxahBjl5CwDZSs3k7/xtK2M2
 aeGcV31RuKad2/IEa6xcrZaf16Ki50d8574DcviCul+AeekLmaqkHwNuURCLy8cF1OqK
 sum35BkInoHNyKsIP0RGSHWNfv8F2BQv+UkuapYubqv96ELtZ/vDOklXjcAvkG9UyIYj
 XRnbm2tzYmA/az0YSgDVtC2TafQo74WL+Y7j4I6pPYXQPe58LFHZ2E314Bx8R3Bx/ViV
 eu1x5GmZM0pWl8bynn/92ZbDfWCdFIuBxsXETteePhLi/PYuos2uUPmU2Dy1mgaKlbjG
 NwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787643469; x=1788248269;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UCdvUdvf1p+Y7/BNibilE881QN78uHmE9/Xc5Rb3pTY=;
 b=gIUVBmC+BnkbZG3qG1BeEWuSu5bSovP49nuotJmtZSP0apGrACMM1FkHXe9GRpRzaQ
 UqXXZO2+ERUYSV+oOnUtvsfWvrh2kuXXjdLFDW0G8jaN2lSHRho+GQ3YDOfRn6BPYMhj
 8r3eVRvYpSgitSO5UfjKX1Lm0euAjKwC3Ua162vEvEFq4jfQ3J+u/AFmjQbK4/0vhGuJ
 QOdmZbwN7ggFYkotUmankElEazqxoNPJIgnv4KrHHjBLpIm+0qap1j8xgki6ByaNU2Me
 LEMUew44xvqNzex8/nZiMohfqotrfnspZWg15t+XWFxo3WSf+kTewp7H4m3o5bmznmNN
 VHyQ==
X-Gm-Message-State: AFuF++nqBL2cI+uttIqoEzY54KARl4Dee7ZEXq5iyy+8WIw3T4BxjML+
 qj6Oo1r8Hu1rxXUatWPgCqNiQkfJMHcVMxalrDY5ZG/W2I4L2wPlYuAtAo64H3qp5NFenoTymH7
 7mv3w/xGJl7AtvB+XR494Nq6KPp4XtrMTZVteKXCFrIvI0g2a3KlQMgv4o9ESSgAxPAeY
X-Gm-Gg: AR+sD10Rv2bkJvovNEP9cd9nvmUwWe7N33Jf0Ff8yjf+hU9TNf8eDbvJLHPnzRIaw3f
 qoQLCg7xPYdoYFgwTcQqXdkOLOcPyAHjyflI4DgMiYdecXdjIScXUg+5A3F8oE+11DyXo9uhgcT
 CesIgVZqm59wy7QG9a0TxV6gZu7kOni9SJgXZBrxVP1MLLoFq1aTtyUD04CSwzZ9GxVi3dVxylm
 wLGzSmpF1WrJjNU4FW8CbGfGDq584AncpuE3R3ikVjddh2wJPEAFwFlbiud13X5JuttNeOPGuYV
 3yB/FuXuNihr3awiaA2fhjHhdWx+mk1Ubj74EVzoep7UTLiM7bUGFTFyXkQLhabJ98GGanIPGYW
 RU9EKpi42mGsZ27LKI0AOuzkxrwYWC437AuiUR+araezMkm5j/iOvp3g9qBiqFxtqop++ZebngG
 8yKS3G1qM/ZWSQz0hzcmqiCjk+D4LgYYUcPXCtRJfBRKp9m+VfxLrwpZtOelVF1X0XQQs5AhWQm
 QJsCmUVtZNnkfcjDE0vLwFdwm5ayEmdgznYoLLHSO0z3STQwfbD8kNPfPHX6/6Ptpu2X7pJWJId
 r0zx4NUE9jYEvSSEp6mIoHxqASrcL+z/LRg8i5OMmdoSRdAy++8Q
X-Received: by 2002:a17:907:d041:b0:c20:3733:a8c5 with SMTP id
 a640c23a62f3a-c24e5a17210mr468991666b.8.1787643468843; 
 Tue, 25 Aug 2026 00:37:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e2e2826sm12288698a12.31.2026.08.25.00.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:37:48 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 07:37:46 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54
X-Gerrit-Change-Number: 1867
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1867?usp=email>
X-Gerrit-Commit: 3da1b9ba93f568d4ca498cc3ab9febe55d679fd3
In-Reply-To: <gerrit.1787570563000.I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54@gerrit.openvpn.net>
References: <gerrit.1787570563000.I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkkyY2Y1ZGEyYWE2ZmJiNjgxMTZjN2I2ZWY1ODdhNjQ5NGFjYWUwYjU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <10a898f218c36841f35463cdd6a229ce1b097190-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyljH-0000a1-LJ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: event: Remove
 unused function event_set_return_init
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
Content-Type: multipart/mixed; boundary="===============9084112634250224382=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9084112634250224382==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hSZz63XlDEI="; charset=UTF-8

--hSZz63XlDEI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1867?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: event: Remove unused function event_set_return_i=
nit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

event: =
Remove unused function event_set_return_init

This has never been used in t=
he git history=2E
It is also equivalent to just using CLEAR()=2E

Identifie=
d by cppcheck=2E

Change-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54
Sign=
ed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1867
Message-Id: <20260824161558=2E1869-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg38641=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpn/event=2Eh
1 file changed, 0 insertions(+), 7 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/67/186=
7/2

diff --git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh
index 40ed1=
61=2E=2Eb784dfe 100644
--- a/src/openvpn/event=2Eh
+++ b/src/openvpn/event=
=2Eh
@@ -190,13 +190,6 @@
     return ret;
 }
 
-static inline void
-event_=
set_return_init(struct event_set_return *esr)
-{
-    esr->rwflags =3D 0;
-=
    esr->arg =3D NULL;
-}
-
 #ifdef _WIN32
 
 static inline void

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1867?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2cf5da2aa6fbb68116c7b6ef=
587a6494acae0b54
Gerrit-Change-Number: 1867
Gerrit-PatchSet: 2
Gerrit-Owner=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@green=
ie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--hSZz63XlDEI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1867?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">event: Remove unused funct=
ion event_set_return_init<br><br>This has never been used in the git histor=
y=2E<br>It is also equivalent to just using CLEAR()=2E<br><br>Identified by=
 cppcheck=2E<br><br>Change-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-=
by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1867<br>Message-Id: &lt;20260824161558=2E18=
69-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg38641=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/event=2E=
h<br>1 file changed, 0 insertions(+), 7 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/67/18=
67/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh</sp=
an><br><span>index 40ed161=2E=2Eb784dfe 100644</span><br><span>--- a/src/op=
envpn/event=2Eh</span><br><span>+++ b/src/openvpn/event=2Eh</span><br><span=
>@@ -190,13 +190,6 @@</span><br><span>     return ret;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-event_se=
t_return_init(struct event_set_return *esr)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    esr-&gt;rwflags =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    esr-&gt;arg =3D NULL;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> #ifdef _WIN32</span><br><span> </span><br><span> static inline voi=
d</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1867?usp=3Demail">change 1867</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1867?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2cf5da2aa6fbb=
68116c7b6ef587a6494acae0b54 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1867 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 =
&lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--hSZz63XlDEI=--


--===============9084112634250224382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9084112634250224382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9084112634250224382==--

