Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E3FC53219
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=81WD8Rs99wVs5gt1nzO+f/oJ9NOHgv06jipuNqW7yeU=; b=UcjpWSPGfEL2lAKBIAGT+AoJFM
	ot8htNcZmWgo28BR/8PtRk7giQriRUGERMuLi9F0X9lfOivg33dcTNlRS063zBW2svnXIPMgcpnwY
	AmewFZ6jTfQR8HK5ZkMREo3UcMAxPv+zGUJ6jIP9ROAjqqL+MY+GH33DIhZ1AZ/Kjpmc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wozMr-0001Gs-NE;
	Wed, 29 Jul 2026 08:10:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wozMq-0001Gm-JM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 08:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ry5n6O1lnv+e7BXHuX7c5WbfcfVXbPhElknatpEBp5k=; b=er6f3y1zm6+zlqsvOptKwVDpAT
 CmheOfVWSII8tzeV7D+ewObDreLvzEU39NIt0Fb3KoRlOmTAblijoQVjAHmEuWGY+1cFqi1Eoc+f8
 NTX/V9EvZ+VVj0vMN0iriCUNjW+9vWjlq4V6zidbmWcuj56Ent69ipxTGiaZdyA8IgnE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ry5n6O1lnv+e7BXHuX7c5WbfcfVXbPhElknatpEBp5k=; b=E
 qma1SQNELDiz9kwF+4rDq9aSsTlZZOYwOOVWARWlpOQa55S0Oord7JLCKMH+NpFBQQrm+YyHYDiNJ
 Q5Pl4EVgIUTBD41E+dFh86Ocmll6uUT1WIjw1WmVADZNAVWOhgrXFEq2whbmWmJ4VxlbUHfMGtvSz
 QV2RAmXpzoRWMygI=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wozMn-0006uS-W8 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 08:10:20 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4956242332dso5419125e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 01:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785312611; x=1785917411; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ry5n6O1lnv+e7BXHuX7c5WbfcfVXbPhElknatpEBp5k=;
 b=RYoh+m4FuvSw+OcZr0Y2o7DTCOzoS13ITVldOpZRofFMElK3P+Wu2OU9JD70XJukCe
 hKGDhUWBj0hzF7o05vJ2rtMJtm8heGSVEuuVfiLYYDag6U6a49HwqQwXaJzxA63A3xMN
 VyBAmlr1asJYotmu4+GigVdFoFFq63APSwQG9dsOCWBzRWIqZ+PCW8f+jD5izrgqh2S+
 Js2Pe8UrRIG/TOuarAA9ODqubCcoF4iKTHshDpOf8wUlRJq7u/jqm9IbhLtX/SV774cC
 8ZTBXri80uzVkltET5J4dOmiNSur8p8uidWqS/70qRMlXTr0lesU9Iolr5uNNNjTfL6A
 1vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785312611; x=1785917411;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ry5n6O1lnv+e7BXHuX7c5WbfcfVXbPhElknatpEBp5k=;
 b=ooBh1QcD2uugIDHBjYL5BT5FFjcSj19rwUk/03CiuXfVBmR1Bf9QYA5nGI+UGjrBbu
 6umZXhkrNhGZb4A9kTteSxpAz1yC9HeYq2YAynXO8c6lFkzZ/CitnHGDqE5YyxXK53A6
 Az/E37Xh9P5UXiwzdlc7Gsbc9i11iWyZVTxO7afm3QnmIDacYSmAKknwu/NmIRsyQF07
 O1T9tNy1PB1gFSkoO7wuXkjLYmEWmoJ8XJw+rdGLvnp1rxb18dg/70nNrtmCDM+OFLgG
 ogCHPwh53nDq/Lznd3EXSZxtm5y7/JmlDRLVi/4TrS99LI6h2DqSq76aL+AJBRuUQKXt
 EkhA==
X-Gm-Message-State: AOJu0YwlWEoXLzn7YM5/SQVVqM6rRBE2byVoyNjw8olzuayb/AZXmOlV
 rH1FCyMBZ7yOvjM/sWLwRc29QQxTCDiQGm0X/niU14lXU52Ay4bNUejA+WBwNZFT66CkCfHnl97
 RhpvAT+s34z6G/4tVvWcAgdde2sYebDAqGxrAGLzeXsrCeI7NBSjlYV03FORZCETjdah8VOjalX
 egrw7k6A==
X-Gm-Gg: AR+sD12nIq0nRF9D3lybmVAqxN+CmNDsbJ+kmW6qXAReoEHE0KbFAX0MoA/le/WdD32
 eUh17GFi8DLTha0TyZP4GKmJd3mxA8SgLJE6fYUHODQnRicgyCBeDZtQmnR1COhibhJJhsW89OB
 8YQLvlfrwvEvBPCkI84ITgIQOBIYfhBfTblCouWbb7YPbogHWb2Lik5qEreOZ01Z3cSPDaC/DJF
 IUbL+ib1mCrgxHJMk5OoXg4tjlDPT6vvej99whp1f0S1HWWVi9NsC2AyN/+Pv21s/9kOk04Xhli
 MQlcYm7V3R2RItsZNc+hFbO9bGuDKZYDR28nXSBMhXRy8h0XrBQ2t2A/Mz91glDBjNAiHCG078R
 bfA1QXD9Ey1JYYzMNnuDQV7gaI6EvKOKBqzxdFVFgsxB0zDg9Rj0a+S6WzGTzmAeREaHoExoy+H
 1b8DEnaa2BgZQMUlypXNtQvVj9TTj9JsTPm2bG5xGwlcfm1fKyuoINx8TkyVbyaVhbrCexkeib6
 I3485KC6LZv5PokmCOpZrZKhjKU303e2vDSh7iw/NzF6qQ5NOB84hgmAO27mMS8VG5+ZlsTbSss
 s1nQMedMzyRj+D40K/XNK9TW2xwaJj9bLQbacHzNaQg2Mxr+jVE=
X-Received: by 2002:a05:600c:354e:b0:495:4e89:3f30 with SMTP id
 5b1f17b1804b1-496c6558c02mr65549275e9.15.1785312611310; 
 Wed, 29 Jul 2026 01:10:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0ef48sm5499127f8f.21.2026.07.29.01.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 01:10:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 08:10:08 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I96b5ea3542df77b1be17079874fb9e4970b539ed
X-Gerrit-Change-Number: 1830
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1830?usp=email>
X-Gerrit-Commit: 86bac756964e392febc55fb025cba9a203b8befa
In-Reply-To: <gerrit.1785312487000.I96b5ea3542df77b1be17079874fb9e4970b539ed@gerrit.openvpn.net>
References: <gerrit.1785312487000.I96b5ea3542df77b1be17079874fb9e4970b539ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MzEyNDg3MDAwLkk5NmI1ZWEzNTQyZGY3N2IxYmUxNzA3OTg3NGZiOWU0OTcwYjUzOWVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bf6cffcf8b5facb11f47b7eb50b22a5126d7278e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wozMn-0006uS-W8
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
Content-Type: multipart/mixed; boundary="===============2584602457005961860=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2584602457005961860==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t3WaG6FjmwY="; charset=UTF-8

--t3WaG6FjmwY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1830?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: SIGHUP-restart instance on UDP write error EADDRNOTAVAIL
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

SIGHUP-restar=
t instance on UDP write error EADDRNOTAVAIL

If a client device roams to a =
new network attachment point (LAN to WiFi,
WiFi A to WiFi B, =2E=2E=2E) whi=
le openvpn is active and a "VPN server host
route" is installed (--redirect=
-gateway, or just overlapping routes with
the VPN server IP), this host rou=
te is no longer active and the VPN is
generally no longer working=2E

On ma=
cOS at least, sendto() will return EADDRNOTAVAIL in many of these
cases, be=
cause the route is still active but the "egress interface" is
not - so we c=
an notice, and restart the instance=2E  A full SIGHUP restart
is needed bec=
ause we need to remove all overlapping routes first, before
a reconnect can=
 work=2E

Github: OpenVPN/openvpn#1086

Change-Id: I96b5ea3542df77b1be17079=
874fb9e4970b539ed
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---=

M src/openvpn/forward=2Ec
1 file changed, 11 insertions(+), 0 deletions(-)=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/18=
30/2

diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index =
46e1a53=2E=2E225ba6b 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn=
/forward=2Ec
@@ -1856,6 +1856,17 @@
             msg(M_INFO, "Network unrea=
chable, restarting");
             register_signal(c->sig, SIGUSR1, "networ=
k-unreachable");
         }
+
+        /* on some platforms when the client=
 changes to a new network
+         * segment (LAN -> WiFi, etc) and there =
is a host redirect route
+         * around, we get "cannot assign requeste=
d address" as a fairly
+         * reliable (and quick!) indicator for "thi=
s connection is dead"
+         */
+        if (size < 0 && errno =3D=3D EA=
DDRNOTAVAIL)
+        {
+            msg(M_INFO, "UDP socket broken, assumi=
ng client-link change, restarting");
+            register_signal(c->sig, S=
IGHUP, "link-changed");
+        }
     }
     else
     {

-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I96b5ea3542df77b1be17079874fb9e49=
70b539ed
Gerrit-Change-Number: 1830
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 =
<gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--t3WaG6FjmwY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 <strong>uploaded patch set=
 #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1830?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">SIGHUP-re=
start instance on UDP write error EADDRNOTAVAIL<br><br>If a client device r=
oams to a new network attachment point (LAN to WiFi,<br>WiFi A to WiFi B, =
=2E=2E=2E) while openvpn is active and a &quot;VPN server host<br>route&quo=
t; is installed (--redirect-gateway, or just overlapping routes with<br>the=
 VPN server IP), this host route is no longer active and the VPN is<br>gene=
rally no longer working=2E<br><br>On macOS at least, sendto() will return E=
ADDRNOTAVAIL in many of these<br>cases, because the route is still active b=
ut the &quot;egress interface&quot; is<br>not - so we can notice, and resta=
rt the instance=2E  A full SIGHUP restart<br>is needed because we need to r=
emove all overlapping routes first, before<br>a reconnect can work=2E<br><b=
r>Github: OpenVPN/openvpn#1086<br><br>Change-Id: I96b5ea3542df77b1be1707987=
4fb9e4970b539ed<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&=
gt;<br>---<br>M src/openvpn/forward=2Ec<br>1 file changed, 11 insertions(+)=
, 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/30/1830/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 46e1a53=2E=2E=
225ba6b 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><spa=
n>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -1856,6 +1856,17 @@</spa=
n><br><span>             msg(M_INFO, &quot;Network unreachable, restarting&=
quot;);</span><br><span>             register_signal(c-&gt;sig, SIGUSR1, &q=
uot;network-unreachable&quot;);</span><br><span>         }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* on some platforms when the client changes to=
 a new network</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * segment (LAN -&gt; WiFi, etc) and there is a host redirect route</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         * around, we ge=
t &quot;cannot assign requested address&quot; as a fairly</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * reliable (and quick!) indi=
cator for &quot;this connection is dead&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (size &lt; 0 &amp;&amp; errno =3D=3D EADDRNOTA=
VAIL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO, =
&quot;UDP socket broken, assuming client-link change, restarting&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            register_s=
ignal(c-&gt;sig, SIGHUP, &quot;link-changed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><b=
r><span>     else</span><br><span>     {</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830?=
usp=3Demail">change 1830</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1830?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I96b5ea3542df77b1be17079874fb9e4970b539ed </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1830 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit=
-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--t3WaG6FjmwY=--


--===============2584602457005961860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2584602457005961860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2584602457005961860==--

