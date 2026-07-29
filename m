Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CEBC54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=w6v0OjQbCVYFd0Lp12PH8hrq7CaiXb7aTaiCsSDO7xY=; b=Jpqwx+NLSINOae
	DXedTKNKbk9ZNhVWWLq+dKGhvXpMxD2VjKV52oJid1VoZD+rwZqdW0bk0BJCCSjt8yljJV7q4NaIt
	JwXlX7sDlKsUa985/OfbNe8P8e3k6G7oCq8OfYz0jQY6q5+6iFu41uKTkRdtaum1Z1BCINhxIiBAQ
	qXc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wozKw-00051o-M8;
	Wed, 29 Jul 2026 08:08:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wozKv-00051h-7E
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 08:08:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qml5L4i4WX18Aw7CCHPr14rKj6Go16/gWOgeiFPCby0=; b=lxtrUKKhfX0/Aok922xmXL9Fkn
 kRdyI/c9BW/fSsXkSECaOCyU3UfiurB38HLdFM+T21iJa/NgGu/8uQsDEE+Xh6EjGTCql2Dh63Zg9
 MU1fK3WFuscqjmMDdEbK9d5YGfrYhBzFSKmjP3kcCf06JleQ3LN0QCeS2pVSM9dwdV4Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qml5L4i4WX18Aw7CCHPr14rKj6Go16/gWOgeiFPCby0=; b=d
 O8+ZNQjHvqqXx4dtCK5e4bPg1GWTSg+NJjCMi0BAHphHqiowlv6E3dwECv5tdNBsk63RvplXo2vXX
 Ktfb18DZQMti7/JjmEsnCTfsB9/JO91Ref8x0SFAq5jxD7LkEKic6RS2OEFlDj/G0R/syCOnJzthc
 cOfq2wwh5tir91iM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wozKw-000635-EH for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 08:08:21 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so3836365e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 01:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785312492; x=1785917292; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qml5L4i4WX18Aw7CCHPr14rKj6Go16/gWOgeiFPCby0=;
 b=PPVR5DRRIu4oBW3Wud6AiVyA3FJY5/pI+rhc7kk5amMX7hs/7k1qcJMpTJ1L9Atrir
 Mh64zlTtPeiZm1VTDje/jOpFRxlr+6JczBy2yE6liMGg9wjYAm0AsGq3w0eKePfyyWQy
 UcqB35wLcATAr/M5gLbhWFcS0Ocmsc3cAiP5C0bR3hdef+UhbJv4HaOdpWJxTRYhWqUR
 3HGbXkEkGISOWq10YeT2do1Rj+rI/pFxFpkESr+EyUHjmngteeDIAT1XziHgGHeYRRLq
 zpmsS/FW4Xo0g5awGAdk022j9bH7WnZ9cespLinbDzRowQ5NxOuFlXots+Vq1S8W9pEP
 6g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785312492; x=1785917292;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qml5L4i4WX18Aw7CCHPr14rKj6Go16/gWOgeiFPCby0=;
 b=b5RE6mB0f1imjdkeh4S1mIY2sMr2Svd/RqTHcWkdEMldAenYdnZNpNi/x6V5DBchG5
 NHYgLRfdslssUhIlPZ/ZDBH6x8LoWPs477wzEFmrr7Vkh+bSg3I3cIvsHpnZzPd10kCb
 m42VOH9zwztuLwZfWRhLHrlf4NHzuwna6xSkdiZHqqPDULRFynw1d3HVuAkJZNcPEBrz
 eQEPXVRjBcVPHjcnjzSto43nezxWJMaKg/3N23z4H+H4Jd1Iwose8hOCgjOJlIO6Ea9t
 XhwnsxL3uCSut5wUGfjpC5veqxpckPoDHA52UuBkW+KFcASLN1IoXTSkn35vhSKKnO7M
 trLw==
X-Gm-Message-State: AOJu0Yx4PSnWHRu/ceOQTmdZBmOrxM0azx+vZyIz1pb+dPQeGXCymF/H
 21127xVkte/0SP1YbRLC/uFpAcDmLSa0pFZHdrvzLZpWMi+X7H/nbnbVyf5FsATvnTmQQNBQ/qb
 nFQbpHr8/RPCFb49ZpTpR6oM34lnGuSDwmbN24itDLgR56/RPz3ZSEPna8oRcexXW4T4vKzO0TD
 uDAAwJGg==
X-Gm-Gg: AR+sD13zomNsUlg35WnXhq1pFxyVb4Yx80Q0189iytfqiChlWzpeTH5BzzTMWF4asKY
 H+ofl4toOGBNGMOhga81254MwdvarcEyyHY+nwGe7W6t958wAqr0nd0BYWPYYDaJmCRDUmu1a0o
 sSFzvgpb8ris5dBFKZm4B+GqEpPWbPXEVThzJWgJ8VhnxVM2P7SCMi6Y0A09BjQsm3grN/jwfmB
 rrEPOxG1nam7quQJzJBsxDYJs1w7FUg48mcc+UwCYFmniSo67Wa5cD4if3IEm9C/wslEorZfV51
 1GqvCu5ikjMrPrw6U3eFbeDasEQ8GvR/lVk9J9tWWGsCi3gc4CF3LI3J1SYeFolrInso537oxBQ
 8QblvZ7kjNyZszkivz4zhnTW3g/9bXS3pqRQqmVlFxi+IgRs5BeGvC3dHfgj2dh12TtTdelPUqo
 Bm2IxizbLqUFAMC4ooSUcoWthyT9ZZn6MCgDzQST1w5SCVg6c+gF5bmNEK/BsivyYuOB6T6T3c3
 cRkwyxapEKTC/zMR6stu7x4+j4LZG+aCPvpfNUlXPRr12VWi7Sl5xq3CET7PvRI44svDWbF4jyI
 Yvc+BWKCMjvyb6urJa68+W4zv9bTfvxApF9LWV+LJ3a+Vg8lJOs=
X-Received: by 2002:a05:600c:1d1b:b0:493:c845:bc20 with SMTP id
 5b1f17b1804b1-496c64261a7mr64048465e9.4.1785312492094; 
 Wed, 29 Jul 2026 01:08:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4975abdca42sm36498965e9.0.2026.07.29.01.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 01:08:11 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 08:08:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I96b5ea3542df77b1be17079874fb9e4970b539ed
X-Gerrit-Change-Number: 1830
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1830?usp=email>
X-Gerrit-Commit: 3cfce25d4cdcbc171eacaf5ef38bdd63722a2dd4
References: <gerrit.1785312487000.I96b5ea3542df77b1be17079874fb9e4970b539ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MzEyNDg3MDAwLkk5NmI1ZWEzNTQyZGY3N2IxYmUxNzA3OTg3NGZiOWU0OTcwYjUzOWVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e2fdd1e43f4c76a579cc974c767e83261868b993-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wozKw-000635-EH
Subject: [Openvpn-devel] [S] Change in openvpn[master]: SIGHUP-restart
 instance on UDP write error EADDRNOTAVAIL
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3688971397897032517=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3688971397897032517==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XTt6wfftGPo="; charset=UTF-8

--XTt6wfftGPo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1830?usp=3Demail

to review the following change=2E


Chang=
e subject: SIGHUP-restart instance on UDP write error EADDRNOTAVAIL
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

SIGHUP-restart inst=
ance on UDP write error EADDRNOTAVAIL

If a client device roams to a new ne=
twork attachment point (LAN to WiFi,
WiFi A to WiFi B, =2E=2E=2E) while ope=
nvpn is active and a "VPN server host
route" is installed (--redirect-gatew=
ay, or just overlapping routes with
the VPN server IP), this host route is =
no longer active and the VPN is
generally no longer working=2E

On macOS at=
 least, sendto() will return EADDRNOTAVAIL in many of these
cases, because =
the route is still active but the "egress interface" is
not - so we can not=
ice, and restart the instance=2E  A full SIGHUP restart
is needed because w=
e need to remove all overlapping routes first, before
a reconnect can work=
=2E

Change-Id: I96b5ea3542df77b1be17079874fb9e4970b539ed
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/forward=2Ec
1 file c=
hanged, 11 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/30/1830/1

diff --git a/src/openvpn/for=
ward=2Ec b/src/openvpn/forward=2Ec
index 46e1a53=2E=2E225ba6b 100644
--- a/=
src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -1856,6 +1856,17 @=
@
             msg(M_INFO, "Network unreachable, restarting");
            =
 register_signal(c->sig, SIGUSR1, "network-unreachable");
         }
+
+   =
     /* on some platforms when the client changes to a new network
+       =
  * segment (LAN -> WiFi, etc) and there is a host redirect route
+        =
 * around, we get "cannot assign requested address" as a fairly
+         *=
 reliable (and quick!) indicator for "this connection is dead"
+         */=

+        if (size < 0 && errno =3D=3D EADDRNOTAVAIL)
+        {
+         =
   msg(M_INFO, "UDP socket broken, assuming client-link change, restarting"=
);
+            register_signal(c->sig, SIGHUP, "link-changed");
+        }=

     }
     else
     {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1830?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I96b5ea3542df77b1be17079874fb9e4970b539ed
Gerrit-Change-Number: 1830
=
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>

--XTt6wfftGPo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1830?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">SI=
GHUP-restart instance on UDP write error EADDRNOTAVAIL<br><br>If a client d=
evice roams to a new network attachment point (LAN to WiFi,<br>WiFi A to Wi=
Fi B, =2E=2E=2E) while openvpn is active and a &quot;VPN server host<br>rou=
te&quot; is installed (--redirect-gateway, or just overlapping routes with<=
br>the VPN server IP), this host route is no longer active and the VPN is<b=
r>generally no longer working=2E<br><br>On macOS at least, sendto() will re=
turn EADDRNOTAVAIL in many of these<br>cases, because the route is still ac=
tive but the &quot;egress interface&quot; is<br>not - so we can notice, and=
 restart the instance=2E  A full SIGHUP restart<br>is needed because we nee=
d to remove all overlapping routes first, before<br>a reconnect can work=2E=
<br><br>Change-Id: I96b5ea3542df77b1be17079874fb9e4970b539ed<br>Signed-off-=
by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/fo=
rward=2Ec<br>1 file changed, 11 insertions(+), 0 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/30/1830/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/fo=
rward=2Ec</span><br><span>index 46e1a53=2E=2E225ba6b 100644</span><br><span=
>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2E=
c</span><br><span>@@ -1856,6 +1856,17 @@</span><br><span>             msg(M=
_INFO, &quot;Network unreachable, restarting&quot;);</span><br><span>      =
       register_signal(c-&gt;sig, SIGUSR1, &quot;network-unreachable&quot;)=
;</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 on some platforms when the client changes to a new network</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * segment (LAN -&gt; WiFi,=
 etc) and there is a host redirect route</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         * around, we get &quot;cannot assign requeste=
d address&quot; as a fairly</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * reliable (and quick!) indicator for &quot;this connectio=
n is dead&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
size &lt; 0 &amp;&amp; errno =3D=3D EADDRNOTAVAIL)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(M_INFO, &quot;UDP socket broken, assum=
ing client-link change, restarting&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            register_signal(c-&gt;sig, SIGHUP, &quot=
;link-changed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span>     }</span><br><span>     else</span><br><spa=
n>     {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830?usp=3Demail">change 1830</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I96b5ea3542=
df77b1be17079874fb9e4970b539ed </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1830 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>

</body></html>
--XTt6wfftGPo=--


--===============3688971397897032517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3688971397897032517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3688971397897032517==--

