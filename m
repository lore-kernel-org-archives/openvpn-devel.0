Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220E0C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tk4B6ACU6Fb/Df2RJz/ELyhb7vmfrUAO4O3yK3/ZLqk=; b=lFvRUtYrr/ms0x2S2IvOKFYDiC
	WiRnylyMPfT5dBgscqnA2H4zxMz7G2Ok5N6Ll9xsyqwQZGEH/X6pHyyteCFit77HndILdogfn7Isi
	C4eN8EbXZPT8TYEHX7aLR5ZGwvGGEW7iszvIf9s9aS+c7U5cKP3bUJVujql0houGLWtQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjZZn-0005SP-3D;
	Tue, 14 Jul 2026 09:37:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjZZV-0005RX-KZ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 09:37:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QsXY8GSAprK1RGIz0Ez0oMiN1TmA8DzO49BBXpTkLvc=; b=VQ2B1F/HsAUYvs0ymtPNrFzzmH
 4iUBqDjjRFV6FmdMfVz56Db3lNCtDrxJ5r7v4UERmgSEHDC15/Hfb9nIYwAq9h02vh3nBnjU2cCjz
 CXnQdZVGF06LvNNURhciau+ogV1jiMoSP0WCeaMkup/RD3DQbiLAmjs4hU87yi6jBZSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QsXY8GSAprK1RGIz0Ez0oMiN1TmA8DzO49BBXpTkLvc=; b=C
 MqPvjolPAmI0v+fCVYLxzMOqugh0/fxeM/rCzAv0VeHUMbBUrJES5wVcxWh/aRq3ojvGCmStap7Wi
 UY+P05XgOYtAiox0VgraH+9uynUFFWtNkX3cYkKxh3vZMX7cfml1cZu7HUi0EpQRdpdPKKebcyxV/
 3nq9zRwS+rkZ+Q68=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjZZS-0004C2-LR for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 09:37:01 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so517778f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784021812; x=1784626612; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QsXY8GSAprK1RGIz0Ez0oMiN1TmA8DzO49BBXpTkLvc=;
 b=Q1eUgu6lEFQVRBnRdd5aTamB39ii1cfbpOdBbFMuM8CMJnWTIRWbjj9lENzxHvP12S
 lVuuCKzvi/ag1KMJaMsXHIDy3ZNqDIu6NbHC0o/AOAgfYOfiVIP1BKo5eaE1QsV/1CLO
 nq7H/gACfZe0M1FjQB/8gUdbsYnJ/we2gGVMaaKfW+TYsB9pwHS+L5X0L1TeWBwQK80q
 8ayt97XfAIj1csE3MxKsf0juAmYZtAB1BXcHEiYVID4FBRpFpcAy20EDA98X4aVBFJU/
 nZowQ/m6/ypXoNVvSZzvxLkuDbnuB22edk2Sag2m6ITosAuZxQb/T4efGmT7cyfI/Fc8
 HUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784021812; x=1784626612;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QsXY8GSAprK1RGIz0Ez0oMiN1TmA8DzO49BBXpTkLvc=;
 b=eZXNc7WLsy+w3l5OXjXFK7ylc8mYRb+iZePFZ4Iv2PDlPOgOl/4BZoLyssKdVp8uLS
 jtF61QUjCHhBO78nHRLWIqnrpW67eZPnU5gDiXabNSHJKJXaFSj6IIdJbiHgu3YVsqyE
 ZnIYPA3kwVX+RNgDMeSGc9Go6sYX2lckpfaqXUSvyqK2TWi4lS9skY3c7Mg4GPM3rRtI
 rjwAJ5Hhz6inIixxJbtX/ZduUhj8FQ2p8usUyhgnm4rxbpwylT4cnwPNsSiyIorPiOof
 pqkIrwRcPB1vJNh0V6zzKNfLOrUUli3qede71rGz5qvxQEoPukK3td2v5DcMztf7ZODl
 eqnA==
X-Forwarded-Encrypted: i=1;
 AHgh+RonKEqE3wrSeIzz9XbhpEm1t21BRzKQf4R6uXHS71XtMiIhe3JdKK0q0UcJXwlEYOSWQMEalW5f7oC/7vxH@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyB44QJGRDBEmke0NY0N0gNs1f8XNsLAX8MWSHFEkB7BpP0Zb+e
 tayirnQwPytEMaVppFZz4EETxluMdWoXB5IdZnibYraFk5YLHE884+Dt9txiLqvM8II++UCYyHO
 vOLZxZ701DZ55Qn8D7SGD8ugL2UlVFZlHT4chlMjCYOPDFE/8CsY2Z5JWJe7uV5gcROq8DcC17M
 IByx/LzA==
X-Gm-Gg: AfdE7cneVUnNRT5JuYyVxoyIACV2l7XDTun4we0w1UXcK/yR8MYprvrpYKpJWkn8wRA
 vonqnCrk7HpaMtGXKqYjXZV453tqY9K4+eZTcKVU7JRCUUTNP0o7Bs8jiqUVVUXx4H1zgcxw6kM
 HlEmcclUDyoe/iB5oxBe50UQPv7DQjKw3F9ScvQ/+GXFnvBDCiHL+ZD4K1dHjSaOpIZAxnMWQ19
 tWYDqX3CO4vJVA3npVyPHebEiZncmz3ECn/oftuFlhnhyC9guEP26zb+4tTe+9+aH8CeHUgo9Ru
 cOJ1eG1DXK7Aex8A2/IKgWI4nu+9AJX130WeYOnf9HpPMNkOmwTPoDH0W6F7FBCi4zKktkFSb2d
 XoSBIAhnvBQta+YAnX9t82sdYBFdrKCCpphr5Rp13bNwKAs9tif82Yla/ebjoppyArLNFLEJwda
 LIRgdKdkEB7ENa30jAQW+9ZO+yjW2KcjKLrAuoyKU+19iweXevXR+uj6j5gHDvO2i0WQkgB8Lu8
 vAzKEq0p86ayKhFW+m1XheTlw64dUlwn3i7Zfc2nVAysP1W6vR7Q2edJmQ8GxY5eN6aIotVZtkV
 GIQ=
X-Received: by 2002:a05:6000:400a:b0:47f:2942:d49d with SMTP id
 ffacd0b85a97d-47f2dcb599amr14400033f8f.9.1784021811954; 
 Tue, 14 Jul 2026 02:36:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634debesm7164548f8f.8.2026.07.14.02.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:36:51 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 09:36:51 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I677d3206c24aad997889ed76fb8eca2e6f4b1259
X-Gerrit-Change-Number: 1778
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1778?usp=email>
X-Gerrit-Commit: 162f19112702d1c8045efd17c5b09022fe1e04fb
In-Reply-To: <gerrit.1783945377000.I677d3206c24aad997889ed76fb8eca2e6f4b1259@gerrit.openvpn.net>
References: <gerrit.1783945377000.I677d3206c24aad997889ed76fb8eca2e6f4b1259@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk2NzdkMzIwNmMyNGFhZDk5Nzg4OWVkNzZmYjhlY2EyZTZmNGIxMjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36cbe9c24c470f3786446de646085db3e59fac72-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjZZS-0004C2-LR
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5071446059834686129=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5071446059834686129==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MWECBDEbnps="; charset=UTF-8

--MWECBDEbnps=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1778?usp=3Demail )

Change subject: t_client=2Esh=2Ein: Do not run reso=
lvectl if systemd is not running
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

t_client=2Esh=2Ein: Do not run resolvectl if systemd is=
 not running

In some cases we will have resolvectl installed but no
runnin=
g systemd=2E E=2Eg=2E on old Ubuntu distros resolvectl
is part of the main =
systemd package which we have installed
as a build-dependency=2E

Supress t=
he warnings from resolvectl in this case=2E

Change-Id: I677d3206c24aad9978=
89ed76fb8eca2e6f4b1259
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1778
Message-Id: <20260713151816=2E220=
05-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg37566=2Ehtml
Signed-off-by: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
---
M tests/t_client=2Esh=2Ein
1 file changed, =
1 insertion(+), 1 deletion(-)




diff --git a/tests/t_client=2Esh=2Ein b/t=
ests/t_client=2Esh=2Ein
index 48e2446=2E=2E7233187 100755
--- a/tests/t_cli=
ent=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -209,7 +209,7 @@
     # exc=
ept Linux and MacOS
     case $UNAME in
 	Linux)
-            if [ -x /usr/=
bin/resolvectl ] ; then
+            if [ -x /usr/bin/resolvectl -a -d /run=
/systemd/system ] ; then
                 echo "-- linux resolvectl --"
   =
              resolvectl status
             else

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1778?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I677d3206c24aad997889ed76fb8eca2e6f4b1259
Gerri=
t-Change-Number: 1778
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>

--MWECBDEbnps=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1778?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Do not run resolvectl =
if systemd is not running<br><br>In some cases we will have resolvectl inst=
alled but no<br>running systemd=2E E=2Eg=2E on old Ubuntu distros resolvect=
l<br>is part of the main systemd package which we have installed<br>as a bu=
ild-dependency=2E<br><br>Supress the warnings from resolvectl in this case=
=2E<br><br>Change-Id: I677d3206c24aad997889ed76fb8eca2e6f4b1259<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1778<br>Message-Id: &lt;20260713151816=2E22005-1-ger=
t@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg37566=2Ehtml<br>Signed-off-by: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/t_client=2Esh=2Ein<br>=
1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>index =
48e2446=2E=2E7233187 100755</span><br><span>--- a/tests/t_client=2Esh=2Ein<=
/span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -209,7 +2=
09,7 @@</span><br><span>     # except Linux and MacOS</span><br><span>     =
case $UNAME in</span><br><span> 	Linux)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if [ -x /usr/bin/resolvectl ] ; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if [ -x /usr/bin=
/resolvectl -a -d /run/systemd/system ] ; then</span><br><span>            =
     echo &quot;-- linux resolvectl --&quot;</span><br><span>              =
   resolvectl status</span><br><span>             else</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1778?usp=3Demail">change 1778</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1778?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I677d3206c24aad997889ed76fb8eca2e6f4b1=
259 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1778 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

=
</body></html>
--MWECBDEbnps=--


--===============5071446059834686129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5071446059834686129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5071446059834686129==--

