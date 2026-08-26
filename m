Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BBEC61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0piQXiv1ZuYY0iOU7FwL0HOxK+XUQ1/dUky0oZR7z+A=; b=do7MQgJdJg/LW5gJFWNGsnKCgZ
	EwUE7qQ+zsHLQeHRX+jU27nEyW5xTNywXCPtmb40ZvpuVCtucpAWv3NQRSJKcpNQ4e/YlLRJHT61p
	2dune0/71epig/eQUwKhPIZJ2ISo1zcQ8zrT1nh+aW8qiLUTILvK0Fds/thKNiapthYI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz7ZT-0000vm-Mn;
	Wed, 26 Aug 2026 06:57:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz7ZS-0000tU-9s
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:57:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MrWhcJeH+V/EyxhQd7pWnNj5u8v4Ey3wouvMs8vAV+Y=; b=GT/l194pkemjGlmL7bvEs4DlwE
 1vbyrGsCgAoCIl4VumXgS1nZg75m+I68JuNN2AIqxJx6q+IYRzrFbZSXhLnMAlzMJyLns3fC22+VT
 7m5BYjI7vOqlctwP12DOSzbr4AaBqcKqDs+d78GZImtkFjmKBX4KgJvrwh4MX5Id21rk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MrWhcJeH+V/EyxhQd7pWnNj5u8v4Ey3wouvMs8vAV+Y=; b=W
 96QgU1xdSo2wwkJgDwImCqDfflXAnzezeisHSrRMEoENcSK3xXCIbao4Jln1ou33i33PMJBp7No7N
 Q2QmpS8ZdLan9WgXepduqEnFG3Y0JFLOFuhlaESx3sLqL7TgBVJa4ExBMhbrs94NPX/kJ/42IyhBb
 mJZ4kXSjq19Xs9/8=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz7Yz-0007mm-CM for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:56:47 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c16794450aeso53898666b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 23:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787727399; x=1788332199; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MrWhcJeH+V/EyxhQd7pWnNj5u8v4Ey3wouvMs8vAV+Y=;
 b=TgigiDWM2ybBAfU/3dETDGMOQVF4m6PkXueLqKvb5sQtXLEbyr6ZzaAfz1i6+VrLfN
 nuh3JDgK3snN+hCKYwD+jbYRr3MoqTCb1wSKL3TF8O85rcIO/nHGLoMvpdY2KLmYoXiN
 95KTjwiLxW2uR7VKcfoBJai/3huimSk2fBB9p6WG4ug0XKczqY7kzIvyaSmjMcscjk1f
 0mRRdLO1eiMTBNeWSDUUVwEdwbD+pXdw9r1HWjnAPVLApm+2tTYduDn71tk2Wflf31za
 EtferqR+Lm8tmI66Ip27PJF4Y5cmjdm29HpWDIhcC1Uu95O4bnXEn18lYtH7k84vIYac
 Ir7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787727399; x=1788332199;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MrWhcJeH+V/EyxhQd7pWnNj5u8v4Ey3wouvMs8vAV+Y=;
 b=ieg6YBTYvpFbGeQZMZreAk9s5L7aU00MU6ouBQu8tLwmGex2ZEclyxtvaGErUVPS2C
 sIKVtawP2WCDQpDtGneOGfYjgc/vmrIlja8AoEYZimu+n2vQPbBNEROtA5t1IXUALFj3
 LwvYOf1onddbiIkQloUbXArg5tHnf0I3AI56ZqUKCARvUcmRhXbKsfUOKMJjP8KHFTE2
 uOIFm4tpMcvpNU6/lbh2zvWRe4vuj4WABEA0yrH1/PaOiYzMppk/Uh285px7UcIfSpWf
 VhxvxlDADsaRIoj+NSGjXvzxnXLAC5mtBL5Cq1MZBs8sVqliQle57f0FB6LKrteNLMTh
 PJiQ==
X-Gm-Message-State: AFuF++kAY85TN1zG2icKJwERzIK95D5pWLeeRnQ1VbcsAN4cMQxIJmyP
 ocDZ7487klb68C6sqrvx60UUkPW2Z87W7wAwwQu4x7TUDW/IFh9o1VsHjjdkxF4hj336hIg3B7x
 /9wKVz2svxbjaNrJdNbArJLvguRN3qOEYA7ro06OhVwvfca+QIrp2vc+hqjPdB0vugszW
X-Gm-Gg: AR+sD10WFVwUWQrgG0CxBA8vRPSivA08XPHsJbCcqKf+diWo0KnNp9SCq2+F39zm0w5
 5yLukf5eA/p1oN6HqfTAxRwppa7HkgCKBM4i1hqtavVfI/imqRD6hq33hhDZDxQRSTWengTG64W
 MFzR4CytAJJTmJrD196+EUf46UV8oOrMwsFsyZCtzwMlrt8TxFBfp2votvibOC7rqIyisS64XEX
 uCIOhGxRfJSp7MZ09UHE/2KIO6Po/brA94vBxRGiA5txPH5I7Xk5Mc1G0V/eBARaZLVwHWfm7Tj
 TJ7obdQvKSUKq5p5/7Wh/jj2NzEkPPPQXAz3qSE3SJQ9yvxKlGabKZ3XXJpce8N0c/pL2fRPMZz
 OdTRNvoWTjAd6J0v5vhKXnnfWOXSkQwkvr0yZO5vPTcayy3xkXX+yPa4UQTkdYLMD/UANLv58R7
 HLeBHERT2wq78odteDjnji480QTs98gw4VxpOY12FFmCkNkiFJtrny8dgOb6quu1zqhVRmgKLCZ
 Ae/wVs0smf50pI5BOb9EORZWmoZlr33uSyF2eCMHzxDp2VrA4kg0PROj7wZGYKhygWqDEMrrc+Z
 zcavUD4H8EM+4YDLnH+K8fn5nwBves9q+szeqn2QjPR/JMBPWlY=
X-Received: by 2002:a17:906:7311:b0:c16:3074:657f with SMTP id
 a640c23a62f3a-c250baffea5mr538687266b.9.1787727398588; 
 Tue, 25 Aug 2026 23:56:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9ef382sm277114166b.58.2026.08.25.23.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 23:56:38 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 06:56:35 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880
X-Gerrit-Change-Number: 1861
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1861?usp=email>
X-Gerrit-Commit: 4f4b0771574e85787b15dd45a85a889ce66c16f9
In-Reply-To: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
References: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NDM4OTEzMDAwLkllYzM5MmE0NzEyM2Q2MThjMGRiYzNhNTI0MWMzOWRhNGFjODNkODgwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <891775096d14c7484e13cea5e8ffd430b13ce84c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz7Yz-0007mm-CM
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: fix log
 lines format string
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8263092286185172153=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8263092286185172153==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/BPOQImz+gQ="; charset=UTF-8

--/BPOQImz+gQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 d12fk=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1861?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by razv=
anc


Change subject: openvpnserv: fix log lines format string
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: fix log line=
s format string

The interface name is UTF-8 encoded=2E In order to log it =
correctly,
it needs to be converted to UTF-16 first=2E

Change-Id: Iec392a4=
7123d618c0dbc3a5241c39da4ac83d880
Signed-off-by: Heiko Hund <heiko@ist=2Eei=
gentlich=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1861
Message-Id: <20260824180=
454=2E12181-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg38650=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
=
1 file changed, 9 insertions(+), 3 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/61/1861/2

diff --git a/src/ope=
nvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index a9e9665=2E=
=2E36dfb8e 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnse=
rv/interactive=2Ec
@@ -1224,19 +1224,25 @@
     err =3D InterfaceLuid(itf_n=
ame, &luid);
     if (err)
     {
-        MsgToEventLog(M_ERR, L"%S: faile=
d to convert itf alias '%s'", __func__, itf_name);
+        PWSTR wide_name=
 =3D utf8to16(itf_name);
+        MsgToEventLog(M_ERR, L"%S: failed to conv=
ert itf alias '%s'", __func__, wide_name);
+        free(wide_name);
      =
   goto out;
     }
     err =3D ConvertInterfaceLuidToGuid(&luid, &guid);
=
     if (err)
     {
-        MsgToEventLog(M_ERR, L"%S: Failed to convert =
itf '%s' LUID", __func__, itf_name);
+        PWSTR wide_name =3D utf8to16(=
itf_name);
+        MsgToEventLog(M_ERR, L"%S: Failed to convert itf '%s' L=
UID", __func__, wide_name);
+        free(wide_name);
         goto out;
  =
   }
 
     if (StringFromIID(&guid, &iid_str) !=3D S_OK)
     {
-        M=
sgToEventLog(M_ERR, L"%S: Failed to convert itf '%s' IID", __func__, itf_na=
me);
+        PWSTR wide_name =3D utf8to16(itf_name);
+        MsgToEventLo=
g(M_ERR, L"%S: Failed to convert itf '%s' IID", __func__, wide_name);
+    =
    free(wide_name);
         err =3D ERROR_OUTOFMEMORY;
         goto out;=

     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1861?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iec392a47=
123d618c0dbc3a5241c39da4ac83d880
Gerrit-Change-Number: 1861
Gerrit-PatchSet=
: 2
Gerrit-Owner: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--/BPOQImz+gQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by d12fk=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1861?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">openvpnserv: fix log lines form=
at string<br><br>The interface name is UTF-8 encoded=2E In order to log it =
correctly,<br>it needs to be converted to UTF-16 first=2E<br><br>Change-Id:=
 Iec392a47123d618c0dbc3a5241c39da4ac83d880<br>Signed-off-by: Heiko Hund &lt=
;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1861<br>Message-Id: &lt;20260824180454=2E12181-1-gert@greenie=2Emuc=2Ede&g=
t;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefor=
ge=2Enet/msg38650=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed,=
 9 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/61/1861/2</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</=
span><br><span>index a9e9665=2E=2E36dfb8e 100644</span><br><span>--- a/src/=
openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interacti=
ve=2Ec</span><br><span>@@ -1224,19 +1224,25 @@</span><br><span>     err =3D=
 InterfaceLuid(itf_name, &amp;luid);</span><br><span>     if (err)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 MsgToEventLog(M_ERR, L&quot;%S: failed to convert itf alias &#39;%s&#39;&q=
uot;, __func__, itf_name);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        PWSTR wide_name =3D utf8to16(itf_name);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot;%S: =
failed to convert itf alias &#39;%s&#39;&quot;, __func__, wide_name);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(wide_name);<=
/span><br><span>         goto out;</span><br><span>     }</span><br><span> =
    err =3D ConvertInterfaceLuidToGuid(&amp;luid, &amp;guid);</span><br><sp=
an>     if (err)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        MsgToEventLog(M_ERR, L&quot;%S: Failed to convert=
 itf &#39;%s&#39; LUID&quot;, __func__, itf_name);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        PWSTR wide_name =3D utf8to16(itf_nam=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEve=
ntLog(M_ERR, L&quot;%S: Failed to convert itf &#39;%s&#39; LUID&quot;, __fu=
nc__, wide_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      free(wide_name);</span><br><span>         goto out;</span><br><span> =
    }</span><br><span> </span><br><span>     if (StringFromIID(&amp;guid, &=
amp;iid_str) !=3D S_OK)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, L&quot;%S: Failed to =
convert itf &#39;%s&#39; IID&quot;, __func__, itf_name);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        PWSTR wide_name =3D utf8to16(i=
tf_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Ms=
gToEventLog(M_ERR, L&quot;%S: Failed to convert itf &#39;%s&#39; IID&quot;,=
 __func__, wide_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        free(wide_name);</span><br><span>         err =3D ERROR_OUTOFMEM=
ORY;</span><br><span>         goto out;</span><br><span>     }</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1861?usp=3Demail">change 1861</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1861?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Iec392a47123d618c0dbc3a524=
1c39da4ac83d880 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
861 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvan=
c &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

<=
/body></html>
--/BPOQImz+gQ=--


--===============8263092286185172153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8263092286185172153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8263092286185172153==--

