Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01766C44501
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 22:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=BPBZ7mIm+/QWWDFYRI8OqjHhhWD4ZACjK426RT/JArM=; b=EGguoJbbBnsw3b
	HLobwRjnadgNO65yc3XqODi8RuOLyQEyMRcZoCrHB3aK3HAqWBlKcRLGxD11EXrZSbSjq1zekgLSQ
	Pc6gJl1NZhlUtBQdbo7IxjN1t24mv+3JvSrABQGdgm4haB7SatbI0UKAf5Z0OvQ8HcGVV87Rh/yYt
	mNs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjlRy-0003a6-3X;
	Tue, 14 Jul 2026 22:17:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjlRs-0003Zm-Ib
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:17:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NTBO78EPFqmQiSu7G6GL01O+Ca13RF7OYfqJjj8Yvpg=; b=ZHCcs9xrZ+bWFtpfVrVWNQVMJi
 mvA+0Ow7z4mKdck3FwoVy+5KlOvCypi+BTuC0osYEuMoe0+7KHraQKYxMQDrEpSAgT81px4AqlVDh
 /6A6V/e+bEep72/b5y6xM2GFozB3Ae7sm9FXU0RrdgqIwMq/eMQ24b0DAivxSFkkGh3Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NTBO78EPFqmQiSu7G6GL01O+Ca13RF7OYfqJjj8Yvpg=; b=F
 gPtJoZ8pg9xfDR8N4Kwk4hwyPbeVJrEsuXgvL98MQud8xSqBFRGqIDQs8uqZiA0ecDX5/fXp8WVTn
 MN7VrzhaCeJ/4esNs7UnDFayKbsSXA8XgWms0eVT5PlOw/LuIMrPl7CvrGsfg3RHoNo39hBw3I9IP
 NfE5/h2wOBR8JdFA=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjlRo-0002eR-LF for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:17:54 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47640541585so2316326f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 15:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784067461; x=1784672261; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NTBO78EPFqmQiSu7G6GL01O+Ca13RF7OYfqJjj8Yvpg=;
 b=c65Clnt0qsL9vTrt2fce/IlR9rSKNF99x8l0yfmrj0NY0AVHT6nfQTkBkOw8vvBrf4
 ZpMbv0ycQSBQ8CCsH5wFrYyaFDIrm1BDSiZUiGIpU6R+guYFsh0+VeDkBmFsukWAJ9zw
 +7/R9wzadcARk2aqiQHc44o37CaUf7278cByMotAyMkSZx30GbPJrwCsPQR9gSSBUeWw
 csrm4MnwQDtlxroJpgZz1BsdBDTE3nPV4W17tirSi+l7o0yLC5mPPD9QIUtKF2q0iwWi
 O6zT+Cpj3kvRYdrkJ8sAcCfPLkq/QCiFbOQUFOYVIhIs1ImymV+LZ5FBuXIUKKZjJMDh
 SHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784067461; x=1784672261;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NTBO78EPFqmQiSu7G6GL01O+Ca13RF7OYfqJjj8Yvpg=;
 b=kvkSnrCBmtQmw9wq2Bjn5h1e+lQxHcEB1Jc1sjp/24kVibpnsdBDe1f37zVuym+Qu3
 oHiRoj9TNQlXAXEaFA/W5zMQGDCuJ48k1Nu2R6dG6uzrU5UWtnvWqGCJZmAIj/BFSAfo
 Bf6G27mq31ngIFg4oaKXLf8kFqfy4JA+nNHC7gvVpMRD+kvHDZxjVVrYMFfugwSL7vMW
 HPwG12sIc6/xYlbKB0nCgYgtyUCgq3E6TLM3QzIYXdnL1QWTkq/L7eu2UXMhl7a+5ee5
 xue3D0gKCsaZXNBUpxhAVgRKlNQF7Q3nV1q8L07YuIyTiEvw5yr/hyA5IUsx0LjYwA8i
 4JRw==
X-Gm-Message-State: AOJu0YxW6ReGwxPzttRU3HU9mfHpmdzHwQBNk+eT28ZEZDojDIvVgmJd
 nYq9BIW7wkbAZ8IsewABRNqE151AZJ30EmmkCyrgtBoQorXsQM/dvQ/k4SyaIhL3D1+hpOn6oS+
 /1yTFF8/nS+Pl9Yt/79q6WtWHmZb4Sx2+8Il0G8fbXV1nDZ2+PFxJpeHOkHu6q0ZVn9A8
X-Gm-Gg: AfdE7cnN4abyRLYIJeaKPZhYVh8jtEFbM1PfWJrbVMj8bjpH0ZNHf9fjryqWo/iOyK6
 ypLY3Wi4+3yIv0D2BMVi2/WeuS6lP7USdsC/Fu29g7oTD8mJJ7WAvk1QYdcdsxFytE+lAp3GS26
 YuvDldn8fTiasQbodGzbpTCBPEPkxTS4yyB2CXQbTPGWy9ya0ufTyQFB+LiNo2HN30KFNSsWBSB
 GtrwixoYNck8N/5cx2qNrFsNBzNi4BZP0oIBuYSq9MyWGdXozyTJGmM2dB17Kd9Zq5qecxso8zj
 2wd3kPykXKFTh6WDhCEggLcZThoV9dE4E/1WJKXyOSBIkz9qngDucsTx+lrJGwvH+OQwtarrcXq
 8BxLzW7VMf/421lpm/PlFHwxDfi+T619pKarAVdwL1rRqYDtz5HhsMw9b55NYo6Y7CXLuTEb5wz
 BrG1ri/W1EQ5UlvWeOeiyW9xxedp7dgvz14LZQrwjhiphC/tIZ3sUK0FRbNC4ZWfDmXFw+iXslq
 EkNl48utF2Sy6hfduDqO9zDMuajteiwWwqIesyDzrUzi+hCshzNnLUoUhoP3q7EeMznaOg0BODd
 rko=
X-Received: by 2002:a05:6000:3104:b0:475:f0f0:9f05 with SMTP id
 ffacd0b85a97d-47f4fcfe902mr236070f8f.60.1784067460934; 
 Tue, 14 Jul 2026 15:17:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a96fdsm11994137f8f.24.2026.07.14.15.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:17:40 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 22:17:40 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
X-Gerrit-Change-Number: 1787
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1787?usp=email>
X-Gerrit-Commit: e67cbb49c4a262fdf4f7af4eff5495f0146eacd3
References: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk3YzBmZjQ4ZmIwMTlhYzdjMmQxZDk4MWI3YjdlNDU3OGZmNWRjZTQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <326c63c06aba4d7244484b8d2059778600f9597b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjlRo-0002eR-LF
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: push
 route-gateway(s) and server route(s) for subnet-pool clients
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7429325948033196405=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7429325948033196405==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xBk90H/TdLk="; charset=UTF-8

--xBk90H/TdLk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1787?usp=3Demail

to review the following change=2E


Chang=
e subject: push: push route-gateway(s) and server route(s) for subnet-pool =
clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

push=
: push route-gateway(s) and server route(s) for subnet-pool clients

A subn=
et-pool client sits outside the --server / --server-ipv6 network,
so the gl=
obal route-gateway (the server's own VPN IP) is off-link for
it=2E Push a r=
oute-gateway, and for IPv6 a route-ipv6-gateway, inside the
client's own su=
bnet, plus a host route back to the server's VPN IPv4 and
IPv6, so the clie=
nt's pushed routes install and the server stays
reachable=2E

Change-Id: I7=
c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
GitHub: closes openvpn/OpenVPN#987
=
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/openvp=
n/push=2Ec
1 file changed, 30 insertions(+), 0 deletions(-)



  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/1787/1

diff --gi=
t a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index e391147=2E=2E7e26c79 =
100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -645,6 +645=
,20 @@
                         print_in6_addr(c->c2=2Epush_ifconfig_ipv6_l=
ocal, 0, gc),
                         c->c2=2Epush_ifconfig_ipv6_netbits,
=
                         print_in6_addr(c->c2=2Epush_ifconfig_ipv6_remote, =
0, gc));
+
+        /* subnet-pool-ipv6 counterpart of the IPv4 push below:=
 a route-ipv6-
+         * gateway inside the client's own subnet and a hos=
t route back to the
+         * server's VPN IPv6, so pushed routes install=
 and it stays reachable=2E */
+        if (o->subnet_pool_ipv6_defined && c=
->c1=2Etuntap)
+        {
+            /* drop any global route-ipv6-gatewa=
y: it is off-link for this
+             * client, so replace rather than m=
erely override it */
+            push_remove_option(o, "route-ipv6-gateway=
");
+            push_option_fmt(gc, push_list, M_USAGE, "route-ipv6-gatewa=
y %s",
+                            print_in6_addr(o->subnet_pool_ipv6_gate=
way, 0, gc));
+            push_option_fmt(gc, push_list, M_USAGE, "route-i=
pv6 %s/128",
+                            print_in6_addr(c->c1=2Etuntap->lo=
cal_ipv6, 0, gc));
+        }
     }
 
     /* ipv4 */
@@ -659,6 +673,22 @@=

         push_option_fmt(gc, push_list, M_USAGE, "ifconfig %s %s",
       =
                  print_in_addr_t(ifconfig_local, 0, gc),
                 =
        print_in_addr_t(c->c2=2Epush_ifconfig_remote_netmask, 0, gc));
+
+ =
       /* A subnet-pool client sits outside the --server network: push a
+ =
        * route-gateway inside its own subnet and a host route back to the
=
+         * server's VPN IP, so pushed routes install on-link and the serve=
r
+         * stays reachable=2E */
+        if (o->subnet_pool_defined && =
c->c1=2Etuntap)
+        {
+            /* drop the global route-gateway (t=
he server's own VPN IP): it is
+             * off-link for this client, so=
 replace rather than merely override
+             * it in the push string =
*/
+            push_remove_option(o, "route-gateway");
+            push_o=
ption_fmt(gc, push_list, M_USAGE, "route-gateway %s",
+                    =
        print_in_addr_t(o->subnet_pool_gateway, 0, gc));
+            push_=
option_fmt(gc, push_list, M_USAGE, "route %s 255=2E255=2E255=2E255",
+     =
                       print_in_addr_t(c->c1=2Etuntap->local, 0, gc));
+   =
     }
     }
 
     if (tls_multi->use_peer_id)

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
Ger=
rit-Change-Number: 1787
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@man=
delbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--xBk90H/TdLk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1787?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">pu=
sh: push route-gateway(s) and server route(s) for subnet-pool clients<br><b=
r>A subnet-pool client sits outside the --server / --server-ipv6 network,<b=
r>so the global route-gateway (the server&#39;s own VPN IP) is off-link for=
<br>it=2E Push a route-gateway, and for IPv6 a route-ipv6-gateway, inside t=
he<br>client&#39;s own subnet, plus a host route back to the server&#39;s V=
PN IPv4 and<br>IPv6, so the client&#39;s pushed routes install and the serv=
er stays<br>reachable=2E<br><br>Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e457=
8ff5dce48<br>GitHub: closes openvpn/OpenVPN#987<br>Signed-off-by: Antonio Q=
uartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/push=2Ec<b=
r>1 file changed, 30 insertions(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/178=
7/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span>=
<br><span>index e391147=2E=2E7e26c79 100644</span><br><span>--- a/src/openv=
pn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -=
645,6 +645,20 @@</span><br><span>                         print_in6_addr(c-=
&gt;c2=2Epush_ifconfig_ipv6_local, 0, gc),</span><br><span>                =
         c-&gt;c2=2Epush_ifconfig_ipv6_netbits,</span><br><span>           =
              print_in6_addr(c-&gt;c2=2Epush_ifconfig_ipv6_remote, 0, gc));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* subnet-pool-ipv6 counterpar=
t of the IPv4 push below: a route-ipv6-</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * gateway inside the client&#39;s own subnet a=
nd a host route back to the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * server&#39;s VPN IPv6, so pushed routes install and it s=
tays reachable=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (o-&gt;subnet_pool_ipv6_defined &amp;&amp; c-&gt;c1=2Etuntap)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            /* drop any global =
route-ipv6-gateway: it is off-link for this</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             * client, so replace rather than merel=
y override it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         push_remove_option(o, &quot;route-ipv6-gateway&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            push_option_fmt(gc,=
 push_list, M_USAGE, &quot;route-ipv6-gateway %s&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                            print_in6_a=
ddr(o-&gt;subnet_pool_ipv6_gateway, 0, gc));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            push_option_fmt(gc, push_list, M_USAGE=
, &quot;route-ipv6 %s/128&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                            print_in6_addr(c-&gt;c1=2Etuntap-&=
gt;local_ipv6, 0, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span>     }</span><br><span> </span><br><span>    =
 /* ipv4 */</span><br><span>@@ -659,6 +673,22 @@</span><br><span>         p=
ush_option_fmt(gc, push_list, M_USAGE, &quot;ifconfig %s %s&quot;,</span><b=
r><span>                         print_in_addr_t(ifconfig_local, 0, gc),</s=
pan><br><span>                         print_in_addr_t(c-&gt;c2=2Epush_ifco=
nfig_remote_netmask, 0, gc));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* A subnet-pool client sits outside the --server network: push a</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * route-gateway insid=
e its own subnet and a host route back to the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * server&#39;s VPN IP, so pushed routes =
install on-link and the server</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * stays reachable=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (o-&gt;subnet_pool_defined &amp;&amp; c-=
&gt;c1=2Etuntap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /=
* drop the global route-gateway (the server&#39;s own VPN IP): it is</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+             * off-link fo=
r this client, so replace rather than merely override</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             * it in the push string */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            push_remo=
ve_option(o, &quot;route-gateway&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            push_option_fmt(gc, push_list, M_USAGE, &q=
uot;route-gateway %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                            print_in_addr_t(o-&gt;subnet_pool_gatew=
ay, 0, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     push_option_fmt(gc, push_list, M_USAGE, &quot;route %s 255=2E255=2E255=
=2E255&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                      print_in_addr_t(c-&gt;c1=2Etuntap-&gt;local, 0, gc));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span>     }</span><br><span> </span><br><span>     if (tls_multi-&gt;use_=
peer_id)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail">change 1787</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c0ff48fb0=
19ac7c2d1d981b7b7e4578ff5dce48 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1787 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>

</body></html>
--xBk90H/TdLk=--


--===============7429325948033196405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7429325948033196405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7429325948033196405==--

