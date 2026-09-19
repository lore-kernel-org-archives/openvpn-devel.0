Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2015EC982D8
	for <openvpn-devel@archiver.kernel.org>; Sat, 19 Sep 2026 19:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=08t0QPG8snaPYgzE31gMHBMwMiVEIktXvGx7tEtemDY=; b=Xpa88J99Or51Dgn+oCR8v+Kqfc
	MySax39HtJfJhltOlMc5iOxI+F3lDkUcGGlS/corEsO8V4aPFdlvQqehZNMtGG3JP0KlDchIsHIuW
	swG/T2lk+1fW9ICR7wsRY30DyGxjwmjD9XEcYBmqL/XgPbXcOIJU8PQ9upZFTLutngk0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x80VH-0000r4-LG;
	Sat, 19 Sep 2026 19:13:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x80VF-0000qj-U0
 for openvpn-devel@lists.sourceforge.net;
 Sat, 19 Sep 2026 19:13:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DMBvlgGr1k3sXsKGPf5LfAICk0nVSAcjgqxrA0MqvAg=; b=a/oF1xV+yNIEfl5gBevjVPCQIy
 MP9JBJeBz0/ASEmuay9REsVOJypVI2oQh8qQ9vdVoFaU/77B3ef4vraRP3PaWiK3Ab4rhKg72HsDM
 WKK+ysh7wc/UgUertEJfxZSg+R9IVvNk2/Xwd+BBNRbti85SDrUdmpalqkxEhdh4gqnw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DMBvlgGr1k3sXsKGPf5LfAICk0nVSAcjgqxrA0MqvAg=; b=F
 wCE4KZTTgACXj6F50vNs9f+EnLCypJz/whQaaC4QS9Z7Y4tjVpiM8qqg/Ta738Ti9pqEQDt53xZpC
 4T+I3tU51EvjDGdh3GIR6CWLuhqoV5zStrTtQsueAG8q1TlOYJKg1kPd/m2wR5IuNun1MUoa5ca5X
 sxa4jd/dx5/Irot4=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x80VE-0002u6-Lw for openvpn-devel@lists.sourceforge.net;
 Sat, 19 Sep 2026 19:13:38 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so1248498f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 19 Sep 2026 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789845210; x=1790450010; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DMBvlgGr1k3sXsKGPf5LfAICk0nVSAcjgqxrA0MqvAg=;
 b=Rwzu73+iynf6EEFCBPVQiVrZ4yTonD80f0Orp5YMUEujaBM+PM4ESgEvFWRwrwcCZe
 YI9kTYFZ+jiue0kiPzHlsN/Q5VWEjw709m4iL1Mpwj2MqGgP9Zc0byxG1lXNYJV4oviM
 /E3riNaxumw/ZtnXVFKp86WLICpKyEjD5W2XxqJcaAUO3+0gAMix+EniczcgS7d68+65
 lWp/ZsLIZZOPsv+r2A1yQIrCsqOslivVpoWj0Dinv0NEyKe50xIlzXPRKNS1dcgIuzZW
 mFxsGJZry17ozghKZzrFa0HiD1B9fOhzwhcFI607/WXosyQ4cY/hjUWAwPLwp0xJ52e1
 gBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789845210; x=1790450010;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DMBvlgGr1k3sXsKGPf5LfAICk0nVSAcjgqxrA0MqvAg=;
 b=u5ju2un079qPpdlEYIvKWCloP3T8dz2+QqkqPriWHEtaGRW3gzwGCINauxyW3X7BLL
 sL5i15SO+45oo8jrCrrEMhteA3VwtcTryok6bVyTpTZumxATy4ekceA4/Z+OfPPfJ0nO
 rtY/0UYxmNyvjDDPHRtTr3NxG8HKeQSKCrs21pMyGzxlyTPAFAdsyDzhFoRL+6Ii5XDT
 8HyyRxfBAmez46HKiYz2r4MwmZRNU8tItHyXHAYtsQLjj4F3ny+f6FO9flLLl423CL9i
 snSCK4YvEss/kRUcYlMIF0owUblZmJVcyB1kSIkquZ9YXRbpaMv/iGJEThN1AiTWfNmf
 Bu1w==
X-Gm-Message-State: AFuF++mXn/5vIhvwB++ydpaQPlwohVKA6+14vgc02x5ItusMPYFfhUmd
 FgGJ78Yqyi1hMUZLhnADdrmYVo817sjao3tFreSBMNLeuwmMiXtix7ggK/FZHmxhAVl3r23eL3l
 9/P6gLrU98yzMtlJU1HeMI7APrFdOguYp3hA9B3lyVFf3HVHM4nRGb4lOROwq67LT9A+/
X-Gm-Gg: AYBFou2ctrEcfwiVzD6bTfqp8Jzl9fS120buJ7D1Set/D+j7ce9iHNiFw8MB88PB/Lq
 JTVgu04oqtA+OXWeeKl4C4mvC3Y93T0O56RPT4NC0VXFDZ/yEYSnNQWoN+uR3sdgAQDHhu+qm0W
 53dTnaNvkC1N6Uhzw3OwMQichSBerUciEIs5vewSm4Z/ipZzHtbSoV3VxVgjMXvJJ9EKVHzYqP/
 p6tR6cebuq5+MzT58/WBQ5hvt5lrd0bXxJCYujetxAgmC3T8KlDNcPZyHtVhwgX4uXZkwGmxnit
 E1DZB+tKJW5/gNkd84TQiTJprgFsfj5XoIwwj2vp64EuNdkIZVdEDJKQbS7odcRhSBw5ZtG9KO9
 UE2TSVLA4oXsm44UDkRX/yVFzJN01PAs2LBpEtKOW2g4ALfo1szfCHw+8jSd1WEoFAbMXG84igA
 nTtYzcEGfIDSWo2x6wil5XUW1W77XIbzwvnusOdGkgk6yPXXs+sjCbntHKB5AYs85SS7az5N6Gd
 rm8ZdrY3DBVBTefh1XanZrJT6I4nkcoPxSN+FD60hJrqtrK272YB5bZ97RAM277P9J8aHTPHeaA
 YO3PmTG2yKC/voc/4jz8sum5sfeFWJMwxQT/wR/1tTjwgXRKY8/PuraX/HLe
X-Received: by 2002:a5d:584c:0:b0:486:f45a:57a7 with SMTP id
 ffacd0b85a97d-4871e264829mr12878419f8f.16.1789845209437; 
 Sat, 19 Sep 2026 12:13:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724591eaasm8955162f8f.26.2026.09.19.12.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 12:13:28 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 19 Sep 2026 19:13:26 +0000
To: stipa <lstipakov@gmail.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie46934c0a8f04908cc277114ae491c100d368cb2
X-Gerrit-Change-Number: 1920
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1920?usp=email>
X-Gerrit-Commit: 11a37e7733ab8b98add5fe168ae25497f89b3873
In-Reply-To: <gerrit.1789715744000.Ie46934c0a8f04908cc277114ae491c100d368cb2@gerrit.openvpn.net>
References: <gerrit.1789715744000.Ie46934c0a8f04908cc277114ae491c100d368cb2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NzE1NzQ0MDAwLkllNDY5MzRjMGE4ZjA0OTA4Y2MyNzcxMTRhZTQ5MWMxMDBkMzY4Y2IyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ee29134f3b028d53502fc15dad8e1da27e350a67-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x80VE-0002u6-Lw
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_win: report
 per-peer ioctl failures instead of exiting
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4097571149554314169=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4097571149554314169==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aEGmG7YYfsE="; charset=UTF-8

--aEGmG7YYfsE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1920?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by cron=
2


Change subject: dco_win: report per-peer ioctl failures instead of exit=
ing
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_win=
: report per-peer ioctl failures instead of exiting

Three per-peer operati=
ons end the process when their ioctl fails:
MP_NEW_PEER, NEW_KEY and SWAP_K=
EYS all report with M_ERR, which is
M_FATAL=2E On a server that means one c=
lient's failure disconnects
every other client=2E

The shared code above th=
em already recovers per instance: a failed
MP_NEW_PEER drops that client in=
 multi=2Ec, a failed SWAP_KEYS raises
SIGUSR1 for that instance in forward=
=2Ec, and change 1835 restarts
the instance on a failed NEW_KEY=2E None of =
it runs on Windows, because
the process is gone before the error can be ret=
urned=2E

Report and return, which is what DEL_PEER, MP_SET_PEER and the
ir=
oute calls in this same file already do=2E The remaining M_ERR uses
here ar=
e interface-wide setup, where failing hard is still right=2E

NEW_KEY faili=
ng is not hypothetical: the driver owns the keepalive
timer and expires pee=
rs itself, so a key install can arrive for a
peer it has just removed=2E Me=
asured on a Windows DCO server under
peer churn: 15 refused installs across=
 four runs, no process exit=2E

Signed-off-by: Lev Stipakov <lev@openvpn=2E=
net>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1920
Change-Id: Ie46934c0a8f04908cc277114=
ae491c100d368cb2
Message-Id: <20260918180507=2E26425-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg39349=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/dco_win=2Ec
1 file changed, 4 insertions(+), 3 del=
etions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/20/1920/2

diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=
=2Ec
index b3268bc=2E=2E90cff8c 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/=
src/openvpn/dco_win=2Ec
@@ -460,7 +460,8 @@
     if (!DeviceIoControl(dco->=
tt->hand, OVPN_IOCTL_MP_NEW_PEER, &newPeer, sizeof(newPeer), NULL, 0,
     =
                     &bytesReturned, NULL))
     {
-        msg(M_ERR, "Dev=
iceIoControl(OVPN_IOCTL_MP_NEW_PEER) failed");
+        msg(M_WARN | M_ERRN=
O, "DeviceIoControl(OVPN_IOCTL_MP_NEW_PEER) failed");
+        return -1;
 =
    }
 
     return 0;
@@ -575,7 +576,7 @@
 
     if (!DeviceIoControl(dco-=
>tt->hand, ioctl, buf, bufSize, NULL, 0, &bytes_returned, NULL))
     {
-  =
      msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed");
+        ms=
g(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed");
        =
 return -1;
     }
     return 0;
@@ -609,7 +610,7 @@
     DWORD bytes_retu=
rned =3D 0;
     if (!DeviceIoControl(dco->tt->hand, ioctl, buf, len, NULL,=
 0, &bytes_returned, NULL))
     {
-        msg(M_ERR, "DeviceIoControl(OVP=
N_IOCTL_SWAP_KEYS) failed");
+        msg(M_WARN | M_ERRNO, "DeviceIoContro=
l(OVPN_IOCTL_SWAP_KEYS) failed");
         return -1;
     }
     return 0;=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1920?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie46934c0a8f049=
08cc277114ae491c100d368cb2
Gerrit-Change-Number: 1920
Gerrit-PatchSet: 2
Ge=
rrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: cron2 <gert@gree=
nie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--aEGmG7YYfsE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by stipa=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1920?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">dco_win: report per-peer ioctl fa=
ilures instead of exiting<br><br>Three per-peer operations end the process =
when their ioctl fails:<br>MP_NEW_PEER, NEW_KEY and SWAP_KEYS all report wi=
th M_ERR, which is<br>M_FATAL=2E On a server that means one client&#39;s fa=
ilure disconnects<br>every other client=2E<br><br>The shared code above the=
m already recovers per instance: a failed<br>MP_NEW_PEER drops that client =
in multi=2Ec, a failed SWAP_KEYS raises<br>SIGUSR1 for that instance in for=
ward=2Ec, and change 1835 restarts<br>the instance on a failed NEW_KEY=2E N=
one of it runs on Windows, because<br>the process is gone before the error =
can be returned=2E<br><br>Report and return, which is what DEL_PEER, MP_SET=
_PEER and the<br>iroute calls in this same file already do=2E The remaining=
 M_ERR uses<br>here are interface-wide setup, where failing hard is still r=
ight=2E<br><br>NEW_KEY failing is not hypothetical: the driver owns the kee=
palive<br>timer and expires peers itself, so a key install can arrive for a=
<br>peer it has just removed=2E Measured on a Windows DCO server under<br>p=
eer churn: 15 refused installs across four runs, no process exit=2E<br><br>=
Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1920<br>Change-Id: Ie46934c0a8f04908cc277114ae491c100d3=
68cb2<br>Message-Id: &lt;20260918180507=2E26425-1-gert@greenie=2Emuc=2Ede&g=
t;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefor=
ge=2Enet/msg39349=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt;<br>---<br>M src/openvpn/dco_win=2Ec<br>1 file changed, 4 inser=
tions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/20/1920/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index b32=
68bc=2E=2E90cff8c 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</spa=
n><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -460,7 +460,8 =
@@</span><br><span>     if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCT=
L_MP_NEW_PEER, &amp;newPeer, sizeof(newPeer), NULL, 0,</span><br><span>    =
                      &amp;bytesReturned, NULL))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;=
DeviceIoControl(OVPN_IOCTL_MP_NEW_PEER) failed&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;Devi=
ceIoControl(OVPN_IOCTL_MP_NEW_PEER) failed&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span>     }</s=
pan><br><span> </span><br><span>     return 0;</span><br><span>@@ -575,7 +5=
76,7 @@</span><br><span> </span><br><span>     if (!DeviceIoControl(dco-&gt=
;tt-&gt;hand, ioctl, buf, bufSize, NULL, 0, &amp;bytes_returned, NULL))</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | =
M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed&quot;);</span><br=
><span>         return -1;</span><br><span>     }</span><br><span>     retu=
rn 0;</span><br><span>@@ -609,7 +610,7 @@</span><br><span>     DWORD bytes_=
returned =3D 0;</span><br><span>     if (!DeviceIoControl(dco-&gt;tt-&gt;ha=
nd, ioctl, buf, len, NULL, 0, &amp;bytes_returned, NULL))</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ER=
R, &quot;DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &qu=
ot;DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed&quot;);</span><br><span>   =
      return -1;</span><br><span>     }</span><br><span>     return 0;</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1920?usp=3Demail">change 1920</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1920?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie46934c0a8f04908c=
c277114ae491c100d368cb2 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1920 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>

</body></html>
--aEGmG7YYfsE=--


--===============4097571149554314169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4097571149554314169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4097571149554314169==--

