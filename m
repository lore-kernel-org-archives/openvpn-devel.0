Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8A4C44507
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c2BG7o4BnH+sopkdMwh9lmQxmzTVZxSRt48VQvJ6314=; b=ZErCGOrTKMgbSCGLdwKuiLq9IK
	k5Xg5/+1GSgOG0z9Kx/qesf1wf+7G+4AOyHiPJtntT4OetWEXzddygWXPtJBTizPcHj/nEPiM1MsU
	vPEQz5yNMwS7pUf6Ot02rqbLySkOR4tn3nIzqSVGbj+jLnF9cFgsI0B8AOSiNLYUEbKU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjZZq-0001em-EC;
	Tue, 14 Jul 2026 09:37:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjZZm-0001do-89
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 09:37:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vxupif3goJnzZzrhuMZklNWZhAMYb3FRu0LBG4pLSi8=; b=VFln5u9/SVsXM7rE6oJfQyVLM1
 XCXMPnefJ0YcRBi8ddVmaQq9upDKewGwV0lt5lSk5HLLnKE9GfexdT/Ug//+KJhZc2Dl4ibS39HpT
 LesqcDHCsWZEDqXuqopbbxKvXNmQ6iuNql/MEk24HWTdXZTzTSDx7ehYke0wZvkDaUQk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vxupif3goJnzZzrhuMZklNWZhAMYb3FRu0LBG4pLSi8=; b=m
 x0T45EZGQ0sP5S2+N4EQHf7wmUCUzfCe2LvPxjIWXMsMuFfX8uE5z4hu2wsyTgk0NEgXXWGTsd9K3
 f1TG60R7wKd8g50B0SS9ZaSL5OdLmPR3Mls4gYFo7zyb7PxQX52VA2cV8KvHDT7caElqrrcL+BMqi
 DUDIUY/GFLZy/DYw=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjZZW-0004CV-Hw for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 09:37:03 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47f3e6cc44aso1792306f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 02:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784021811; x=1784626611; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vxupif3goJnzZzrhuMZklNWZhAMYb3FRu0LBG4pLSi8=;
 b=FI1U6qKUcnnDl37pwVmCfkQdHX1ILuFmzWkKl9meNSD6VczbFkDOdNX9S+IjiJ+gpy
 5vVOKAfHk31KEzNVD/RroVMxEQm4o8EBff/MlkH6a6o7WhN4W3sIuwmaKaTZ9x1Y3s4L
 pliRfVuqJFaHOCiOsxUcBEsur3+e39QQ/N2HR3E7dBKAbgLwyJN9KlfuixbRQSNpTEl6
 N58ZpUELZAtb5q7Vx9kmVBvmz0dUrq8jyO9ZxgRxSAlJWBmn/4pEaaaosyx8r3K8QwS8
 uM6MOfdNlAN52PS96K9bcOl4WsP1M/zd1oBtuyhSHMg5Erm47iHizsR1bfJVumxP45Qy
 QSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784021811; x=1784626611;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vxupif3goJnzZzrhuMZklNWZhAMYb3FRu0LBG4pLSi8=;
 b=B6bHdw+hN8EPYz+6SBRuCFc6mM/7ALCDCiDDiUDM9F1OMniK4kGGdYJsE3xq+5IuCT
 iMKFxWZsOukC/nJ/Cz5SqVvYOVBqal488y869UI9vLeUnjosGz5dLjJJstZrPN91jKhT
 gBC2ndf3PY1OTGb5yrNW4is/9ZCGgAqM14XNKtcysDieeY9W7os+cDXsdNbH/Y6ZXVRM
 7mrU7Q1MY5heSM3k3Ni27Oo6zwXA1kRciMzvEQDv3UnH7QkQI9NpVXSIedY+KPAI1KDu
 4Mgp+nhLiKOIUcXlf/m3a+J3LQL6C/BTicyKwVXCXN81k6POjF1jBRB1ZojhfI0GQUSq
 rfHA==
X-Gm-Message-State: AOJu0YwpEKe05EIs7gINfb5q0Kvg/ar4RyNKj4/4qWrBVQJEYocEBBFt
 1ml8JX/DeLGgT57aZCHEmHDsteNP1hFvQydKW59GbxrUkEp50d51YY6+I2NDlF60oC1LHPbuKu0
 bh3YFR0QVTSIObdaeK8kQCJHoFIjMxGcaBqNK00ipyZiuK50itTPLhrFv2Hcwy33BSE6qdXop4b
 UYAWyxqg==
X-Gm-Gg: AfdE7ck15K6oLfrsDsmyoOKkC92ITfpvhosWbhw30Dy0stAwbuFJSwLL72XCs4RuGJu
 uyLaU8yC8xNkxr1Wfy17vOezS1/tLl4eaEchgd2BIxEPLlY7WbhAeyoCaqX6qkaQOjMgUmyUERQ
 d+F83es3yd3bEdEJeFlrcPYugEXr7W3WlbX1gsj1cJ4NUNJHF7urPkpsMuNU4AwrjYlNg478NdK
 MLeYVHGzr5g/I91Gi6Wbk6UYXvBYSLTfUq2mPzyOekTYNAReSoGDYvlFBfnO6ZAEfzlCD0sFlI0
 rrULBtxhPn9lAqUlp0MfzhUZiW846aE5Oi5Kz5wsraLlPEGK+yi1kbDi9+YN6O0c38Z6J7MTQ3W
 RYMLsTTLXW5V70i+MLtu3Au2rAFtyVfmrn/1zg1lkcSzK9x1Fax7oWM3V+bKahBUig1PYiumSAt
 76VPbUsUP2k+kgolVqgG0BKf56EEbSdpIqL8tN8VyMMZ78xoTxn9DMeZnxJKXynYTOPgh29nLVe
 AiEfRm4TxJBOTNNsrMTheMu6IX/B5nJj/CBiikIagiaKanC2eUXKRbdMgIbDsQAts613tVrKrq5
 hNM=
X-Received: by 2002:a05:6000:4709:b0:472:ec66:274a with SMTP id
 ffacd0b85a97d-47f48848729mr2080601f8f.7.1784021810856; 
 Tue, 14 Jul 2026 02:36:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4829896asm5042372f8f.23.2026.07.14.02.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:36:50 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 09:36:48 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I677d3206c24aad997889ed76fb8eca2e6f4b1259
X-Gerrit-Change-Number: 1778
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1778?usp=email>
X-Gerrit-Commit: 162f19112702d1c8045efd17c5b09022fe1e04fb
In-Reply-To: <gerrit.1783945377000.I677d3206c24aad997889ed76fb8eca2e6f4b1259@gerrit.openvpn.net>
References: <gerrit.1783945377000.I677d3206c24aad997889ed76fb8eca2e6f4b1259@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk2NzdkMzIwNmMyNGFhZDk5Nzg4OWVkNzZmYjhlY2EyZTZmNGIxMjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36cbe9c24c470f3786446de646085db3e59fac72-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjZZW-0004CV-Hw
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.sh.in: Do
 not run resolvectl if systemd is not running
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
Content-Type: multipart/mixed; boundary="===============2692839100286194758=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2692839100286194758==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PQsrAqgavW4="; charset=UTF-8

--PQsrAqgavW4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1778?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: t_client=2Esh=2Ein: Do not run resolvectl if sys=
temd is not running
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

t_client=2Esh=2Ein: Do not run resolvectl if systemd is not running=


In some cases we will have resolvectl installed but no
running systemd=2E=
 E=2Eg=2E on old Ubuntu distros resolvectl
is part of the main systemd pack=
age which we have installed
as a build-dependency=2E

Supress the warnings =
from resolvectl in this case=2E

Change-Id: I677d3206c24aad997889ed76fb8eca=
2e6f4b1259
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked=
-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1778
Message-Id: <20260713151816=2E22005-1-gert@gre=
enie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg37566=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M tests/t_client=2Esh=2Ein
1 file changed, 1 insertion(=
+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/78/1778/2

diff --git a/tests/t_client=2Esh=2Ein b/tests/t_clie=
nt=2Esh=2Ein
index 48e2446=2E=2E7233187 100755
--- a/tests/t_client=2Esh=2E=
in
+++ b/tests/t_client=2Esh=2Ein
@@ -209,7 +209,7 @@
     # except Linux a=
nd MacOS
     case $UNAME in
 	Linux)
-            if [ -x /usr/bin/resolve=
ctl ] ; then
+            if [ -x /usr/bin/resolvectl -a -d /run/systemd/sy=
stem ] ; then
                 echo "-- linux resolvectl --"
              =
   resolvectl status
             else

-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1778?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I677d3206c24aad997889ed76fb8eca2e6f4b1259
Gerrit-Chan=
ge-Number: 1778
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Review=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--PQsrAqgavW4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1778?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Do not=
 run resolvectl if systemd is not running<br><br>In some cases we will have=
 resolvectl installed but no<br>running systemd=2E E=2Eg=2E on old Ubuntu d=
istros resolvectl<br>is part of the main systemd package which we have inst=
alled<br>as a build-dependency=2E<br><br>Supress the warnings from resolvec=
tl in this case=2E<br><br>Change-Id: I677d3206c24aad997889ed76fb8eca2e6f4b1=
259<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>=
Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1778<br>Message-Id: &lt;2026071315181=
6=2E22005-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37566=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/t_clie=
nt=2Esh=2Ein<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/78/1778/2</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_clien=
t=2Esh=2Ein</span><br><span>index 48e2446=2E=2E7233187 100755</span><br><sp=
an>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=
=2Ein</span><br><span>@@ -209,7 +209,7 @@</span><br><span>     # except Lin=
ux and MacOS</span><br><span>     case $UNAME in</span><br><span> 	Linux)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if [ -x /us=
r/bin/resolvectl ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ] ;=
 then</span><br><span>                 echo &quot;-- linux resolvectl --&qu=
ot;</span><br><span>                 resolvectl status</span><br><span>    =
         else</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1778?usp=3Demail">change 1778</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1778?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6=
77d3206c24aad997889ed76fb8eca2e6f4b1259 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1778 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--PQsrAqgavW4=--


--===============2692839100286194758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2692839100286194758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2692839100286194758==--

