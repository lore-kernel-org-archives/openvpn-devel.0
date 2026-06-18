Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFC9CD98E2
	for <openvpn-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fWlaKXdLqs0OLCZuIuSi1I4VqmJnSjt0/iqVwfxNWSE=; b=eOcpu2XksNFHkfj6mDS6jC2xfT
	LAV7HfrBCmZFwI0GZ1p5HN3CZCV2cKxX8+/il2JlpYYHk0931HzAEOmG8GAZ+qB8vUD8Wr3q9nGHv
	3dgiXEn5Aj7+YDSOXr4zehTHitiWFfrnCLJWsBItz5ZB8r2O2o80RTjRlfDD5QbAh734=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wa8Ug-0001Zj-2X;
	Thu, 18 Jun 2026 08:52:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wa8Ub-0001X7-3H
 for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 08:52:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mABcNxEslfkZ/VdJybCNOWoYyzaiawI3vq3B+6ByBqw=; b=i16Uxux0I6jILUS1sobO72LkLZ
 JmqnvsQUoFviX/rgpgLdVAQi1j/SrE0uCNYa8C263QG5Kt/AEZkqcXgW29FOL25n2qk9/LLEj76R0
 xOT6Iwao+bkmwE03q5QEwvg/40j/T5nVpJNhl+/7GtNGp8zZ4hwHlgtXJXtgfk3qBP3g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mABcNxEslfkZ/VdJybCNOWoYyzaiawI3vq3B+6ByBqw=; b=B
 c6IJgr+eVABXCguhBb5sPzD0YYaZM9SKFEKgys0jilsSqBSbdirKpFEiP7pyB7AEwPVCA+QB7GEP/
 it+1ZX8mUDoaXcqiqJ5kixnnyvoc6nHXfCuecNNXQ+1qpZoAQy8FltSu/ARh9rX4LLZNUaLroBncp
 8dIzAtvOctxl9SyE=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wa8UX-0007Hj-BA for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 08:52:54 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4629d80fa08so690634f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 18 Jun 2026 01:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781772767; x=1782377567; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mABcNxEslfkZ/VdJybCNOWoYyzaiawI3vq3B+6ByBqw=;
 b=dYHX+Qe0W/byJ3+KlLqj/+BnCJzoktr9dm/LxmJEviMjTEqWGFLrM/IkiOtx6zjQC9
 YvpjDavUJ4lEf7W80Fjq5k/+1LByh/woZpsij1cMZ+8AZneT5NxQME6945F5+6Y5fD6X
 Wzi0PLLPqkKov2azUUFr6b44+oJLWFlTiat8t1kwCfOW5FNxf4FTreLnZP0DfXjUKmgf
 hno/9CSE5EIAeqqwclXygapr/iteMdRceW84NtLlwZlaMHNlFO93S6AK1R3o57c0he1X
 kmJZMXklR7xSsIJSZKhwvrbMKtCZjXYy2LrBk3hREJqqn3JJQdL5ymgXH5SghCXGJS27
 YBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781772767; x=1782377567;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mABcNxEslfkZ/VdJybCNOWoYyzaiawI3vq3B+6ByBqw=;
 b=nN1H5i/Gcfof/DCaorqp4Xh+lYibreBWlpojuBynQGlsH33WQDjs9a8evcxYeQm4fI
 rh1H7y+jOGrQoITAIYFBwkmsIo79xC8DyzXgaF4734wxY5XcducfYJ9sqX/zm0Na+h5s
 BFw5ksE63z8/x7Pi8F57SC60Sv2PYBhiMs0DcElO/9ti7yULpdN9XC8xDLsuEO9t8ELm
 dsJBrlmOpGMOkNLeBYi/3lBIZoWevoDDQtD5ubtLNU3QTV42vYJHNTzNpfVLgWUuZn3Y
 0OSv+M37v2CHp2poSKqm6D2hojwWagh7oR4bmYOXnI/3rGfu5EUlgEduDiKecA0SHPAA
 eVnQ==
X-Gm-Message-State: AOJu0YyybpssCeWgXFj0MUbMD2qhTbNBD7sp5QCH7IevkLVjuWKWn2Mh
 MOHTh+ox7zi+ijdf8MWnFK7LpIMrRbvq3kdyJJMDUEk7U7cKadSmFPb/5JpyFbqhhazpjmUohjI
 RplNt2u0aD7jLipVpk09CwcayLlZbezePcEPluQKNlbbAJnynK2nAKnXCy2CFeNV80ItRBed2Ww
 mPHfAI4Q==
X-Gm-Gg: AfdE7cmXNPhOzArDS55f7/am+J1t2djy0vlw/9Uj79wBJCNM9ImuAcEaSOy4vs7OgqT
 PqXKP46yMT5YBkNsmHkZ+/rU2feZjEG6zDZ2r1gJExuMevb3h29wzZ6znVAmMv0eUOYf4h1i18a
 pQD+a4w2VwF11P1nL/vy5zIg7PbfaMPEyrWT5ON5jiWh5xjWnflOQ2vih9SxwfYRqMkyrvctvud
 jBLBJS9TPcV4q8Z/LiPnsV0KRu2/6kIN8X2MV+Zd5cW/b75nJ97edEe4izLRNHXD+ckUs/2Ctdf
 IaH/XSLBs+QAgSvvdWn6YTh+zWsggYegELMpsDYhN0dxIqCCb4neyfEqYnqSSrgzuMlP6hQVl6W
 NQbYGyeWQNH0y4nhf0hd9Ax4jIzlLy5mTiVoFFTFnhZjPryQhNxnS5TG7YDvDN6f8uQ0Lx4gWJI
 SLyURLNk2T7LY4gZnNe8O8xBQ4F7IyMHf/BC8XkOQoqt/NfvTJCh2u4z383nKiC5QcB7rWawPC0
 gLZ0NWLED6XLekJsdOqQbVYgA/5iwX1wD8RogFchO/YAw7vtM2YvV0wA6Q7lsOhYUWTbzW5ZhMx
 x4s=
X-Received: by 2002:a05:6000:10c3:b0:45e:b215:12e9 with SMTP id
 ffacd0b85a97d-46236275edfmr10401144f8f.6.1781772765799; 
 Thu, 18 Jun 2026 01:52:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619b9b7750sm33326757f8f.6.2026.06.18.01.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 01:52:45 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 18 Jun 2026 08:52:43 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316
X-Gerrit-Change-Number: 1155
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1155?usp=email>
X-Gerrit-Commit: 4e4236ded8ce8e7e191a5091d55c286c0071f341
In-Reply-To: <gerrit.1755879913000.Ic9ac18f730e6035126ccf1cf19799548e5fd9316@gerrit.openvpn.net>
References: <gerrit.1755879913000.Ic9ac18f730e6035126ccf1cf19799548e5fd9316@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU1ODc5OTEzMDAwLkljOWFjMThmNzMwZTYwMzUxMjZjY2YxY2YxOTc5OTU0OGU1ZmQ5MzE2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f0b19f2db280659c4c312d6751112b743311ce1f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wa8UX-0007Hj-BA
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: Move <= 0
 check for keepalive settings earlier
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
Content-Type: multipart/mixed; boundary="===============6825010929800499199=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6825010929800499199==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="chNdoSRbRZ8="; charset=UTF-8

--chNdoSRbRZ8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1155?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: options: Move <=3D 0 check for keepalive setting=
s earlier
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
ptions: Move <=3D 0 check for keepalive settings earlier

Use the atoi_cons=
trained function=2E

Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316
S=
igned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Do=
ering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1155
Message-Id: <20260514192727=2E31903-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg36939=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/helper=2Ec
M src/openvpn/options=2Ec
2 files chang=
ed, 3 insertions(+), 7 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/55/1155/9

diff --git a/src/openvpn/helper=2E=
c b/src/openvpn/helper=2Ec
index 9e7ad93=2E=2E4c540a6 100644
--- a/src/open=
vpn/helper=2Ec
+++ b/src/openvpn/helper=2Ec
@@ -552,14 +552,10 @@
         =
/*
          * Sanity checks=2E
          */
-        if (o->keepalive_ping=
 <=3D 0 || o->keepalive_timeout <=3D 0)
-        {
-            msg(M_USAGE=
, "--keepalive parameters must be > 0");
-        }
         if (o->keepali=
ve_ping * 2 > o->keepalive_timeout)
         {
             msg(M_USAGE,
- =
               "the second parameter to --keepalive (restart timeout=3D%d) =
must be at least twice the value of the first parameter (ping interval=3D%d=
)=2E  A ratio of 1:5 or 1:6 would be even better=2E  Recommended setting is=
 --keepalive 10 60=2E",
+                "The second parameter to --keepali=
ve (restart timeout=3D%d) must be at least twice the value of the first par=
ameter (ping interval=3D%d)=2E  A ratio of 1:5 or 1:6 would be even better=
=2E  Recommended setting is --keepalive 10 60=2E",
                 o->keep=
alive_timeout, o->keepalive_ping);
         }
         if (o->ping_send_tim=
eout || o->ping_rec_timeout)
diff --git a/src/openvpn/options=2Ec b/src/ope=
nvpn/options=2Ec
index 62c0bbb=2E=2E8012192 100644
--- a/src/openvpn/option=
s=2Ec
+++ b/src/openvpn/options=2Ec
@@ -6777,8 +6777,8 @@
     else if (str=
eq(p[0], "keepalive") && p[1] && p[2] && !p[3])
     {
         VERIFY_PERM=
ISSION(OPT_P_GENERAL);
-        options->keepalive_ping =3D atoi_warn(p[1],=
 msglevel);
-        options->keepalive_timeout =3D atoi_warn(p[2], msgleve=
l);
+        atoi_constrained(p[1], &options->keepalive_ping, "keepalive pi=
ng", 1, INT_MAX, msglevel);
+        atoi_constrained(p[2], &options->keepa=
live_timeout, "keepalive timeout", 1, INT_MAX, msglevel);
     }
     else =
if (streq(p[0], "ping") && p[1] && !p[2])
     {

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1155?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316
G=
errit-Change-Number: 1155
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--chNdoSRbRZ8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #9</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1155?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">options: Move &lt;=3D 0 ch=
eck for keepalive settings earlier<br><br>Use the atoi_constrained function=
=2E<br><br>Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1155<br>Message-Id: &lt;20260514192727=2E31903-1-ger=
t@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg36939=2Ehtml<br>Signed-off-by: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/helper=2Ec<br>M =
src/openvpn/options=2Ec<br>2 files changed, 3 insertions(+), 7 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/55/1155/9</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/helper=2Ec b/s=
rc/openvpn/helper=2Ec</span><br><span>index 9e7ad93=2E=2E4c540a6 100644</sp=
an><br><span>--- a/src/openvpn/helper=2Ec</span><br><span>+++ b/src/openvpn=
/helper=2Ec</span><br><span>@@ -552,14 +552,10 @@</span><br><span>         =
/*</span><br><span>          * Sanity checks=2E</span><br><span>          *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;ke=
epalive_ping &lt;=3D 0 || o-&gt;keepalive_timeout &lt;=3D 0)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--keepalive param=
eters must be &gt; 0&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span>         if (o-&gt;keepalive_ping * 2 &gt;=
 o-&gt;keepalive_timeout)</span><br><span>         {</span><br><span>      =
       msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              &quot;the second parameter to --keepalive (restart timeout=3D=
%d) must be at least twice the value of the first parameter (ping interval=
=3D%d)=2E  A ratio of 1:5 or 1:6 would be even better=2E  Recommended setti=
ng is --keepalive 10 60=2E&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                &quot;The second parameter to --keepalive (re=
start timeout=3D%d) must be at least twice the value of the first parameter=
 (ping interval=3D%d)=2E  A ratio of 1:5 or 1:6 would be even better=2E  Re=
commended setting is --keepalive 10 60=2E&quot;,</span><br><span>          =
       o-&gt;keepalive_timeout, o-&gt;keepalive_ping);</span><br><span>    =
     }</span><br><span>         if (o-&gt;ping_send_timeout || o-&gt;ping_r=
ec_timeout)</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/open=
vpn/options=2Ec</span><br><span>index 62c0bbb=2E=2E8012192 100644</span><br=
><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/opti=
ons=2Ec</span><br><span>@@ -6777,8 +6777,8 @@</span><br><span>     else if =
(streq(p[0], &quot;keepalive&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&a=
mp; !p[3])</span><br><span>     {</span><br><span>         VERIFY_PERMISSIO=
N(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    options-&gt;keepalive_ping =3D atoi_warn(p[1], msglevel);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;keepalive_timeo=
ut =3D atoi_warn(p[2], msglevel);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        atoi_constrained(p[1], &amp;options-&gt;keepalive_pin=
g, &quot;keepalive ping&quot;, 1, INT_MAX, msglevel);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        atoi_constrained(p[2], &amp;optio=
ns-&gt;keepalive_timeout, &quot;keepalive timeout&quot;, 1, INT_MAX, msglev=
el);</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot=
;ping&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1155?usp=3Demail">change 1155</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1155?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9ac18f730e6035126ccf1=
cf19799548e5fd9316 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1155 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@=
greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>

</body></html>
--chNdoSRbRZ8=--


--===============6825010929800499199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6825010929800499199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6825010929800499199==--

