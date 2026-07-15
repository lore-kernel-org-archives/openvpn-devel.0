Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BCBC44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=on7zJ/tto+XImsq85zNtMObZfdVEuG6JJJN6ETvwzVE=; b=RTWoAypqhE4dAuFCxoTsbUNEZr
	hVK/x+Ef7IDH88ddR9ne69IHcs8jMcuDln+FVr81GT6KOalKkoxLYxPKpwPfZEKiiccczNyuJvzAU
	bHbMGWMHNf1U2SHKEHDfmhMcuflJnHFafKZ/QEsPbd5NKJVb9ZvNFtvGiQVrzz2N1waQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1Gk-0004Ft-3D;
	Wed, 15 Jul 2026 15:11:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1Gi-0004Fj-Rk
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:11:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cMKBTsA8Nqo/y8Mw/gFeo1jitmsbehu7XFmRyPzQDug=; b=dXG5LE9JRgu0jMNvoxbnLvMd6v
 iHx6o+K5crs2D5VXS6EN/lziZoQ3aZ5JSSf4N7TCmyfUyHXEUuyyQbLMml2iEk33jY283SOgMsGBt
 YlX20GbipKi5d/VdvSKPsJbyERX3jIEX8PWLphQcFRud5MkjtnLmIjAU1XGC4pUc4C0A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cMKBTsA8Nqo/y8Mw/gFeo1jitmsbehu7XFmRyPzQDug=; b=h
 RT6prhVlZlk8mDKB5hOGi1ct/LuSenEYbYDLHoJezPhOuzySQFZwb3XEFbdKpMWFN9IptZiOqnOfw
 kk0TL4yS5I8Zkcfl0vqZRcpu8McT555N/31ybWJafsw/D/PljHuTjnFdKTrR9MEytQDeJHN2+ZJ3r
 UnOeTNB+a+et2f4M=;
Received: from mail-lj1-f171.google.com ([209.85.208.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1Ge-0007Pg-R1 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:11:26 +0000
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-39c9107baa7so56613331fa.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784128273; x=1784733073; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cMKBTsA8Nqo/y8Mw/gFeo1jitmsbehu7XFmRyPzQDug=;
 b=Ys5bWEGvLy+U1GPDRhGYLCWv4nik1X+NhF4iGgiAUnAx+r36idk3KWQ5rxja7P7bip
 3cqKygWOa1bP5EXFRAnP0yCLRY80CTs+FG7Er1U7qdtbVfwmCNbf02B5Yb4nJtKW7mrp
 yCCuk4KWcKvLSKApAUi8xn7/ZmRQsx/SaYNDa17miHf3geswueVmWPoj1SRzAmw/VEhV
 WO0ScardEA8c3MPqkojlef7QOCPwawZzqJHqDjye874qbIpYwMY0QgcWByTwd8avrFgJ
 +xrT0FG//tyf7eqK8JDKeSDYXSGHdatXoaTKdTPBvZmISrTF8lZe9k8RgX7gvarfhuDp
 1akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128273; x=1784733073;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cMKBTsA8Nqo/y8Mw/gFeo1jitmsbehu7XFmRyPzQDug=;
 b=VEooOgci9jZJuhg+zUHmNac3pN+ynM53ABiR9bvbINuCsHnsP/i+dg/Yqmaf1TPfq9
 ddU3RjeMz7j2ol3OH6kG4Ed16Lh6a8Xj5azZTpVQ/dP6LxxyvHbzKH6Ae/CY20Gs6NCS
 DAlYSUUJjmsopLB75gNkOgMaiMFV4QiHPYnUb0AyawULXDV79WESvpVg7yM3P0J+BDVl
 w6AKQ3MZJt+v5z+FMVA7hzv9P8Ac/ZUbr13BAh7a26zgsvA/0EQIVCU/8709YfbV+5vg
 4sWbqjH8SK4Av72+fJpgvbLqnPPLTPRe/IvdMrCs4ZM+ovvBO2A4C/Em4rD4UAnUDj16
 b7Ag==
X-Gm-Message-State: AOJu0YzZExCdymxPNtiT4xjbTBozODIbjBLLkIqUOiCOM6u6BH4+oKYZ
 2dGZGqWHAzz2wQv7hURQGdRdBJ3yFs00g2iuoWReCGELZ/Ut8gTyRUnRGiRxfcOVLy/f3xv5RT2
 Zr6mnq2+vXVSmt88ODfQUrAfPUw8Nwi4nCrQ4/xkKpJy8v8j2aHuwmGdPVBEuKz47lGJw2hKRBz
 fngb1F1w==
X-Gm-Gg: AfdE7cl4+Sjo6tn+ZzjLy/+MVB96lXi0JvHf/HCQ4BJYThVhQlj5qnJqdcmuICXogxH
 Wx3A5L2ecqAlzKjjMAGefgSnoXoR0LeAH5ItbgSetlKjRtp27shS4s21P47F1Sil9I1E1nN9EJ0
 pQbK7roTnDehIxO476VZUp+tDhDm6iyp/9bpc0yE8tMa8pNqB4ZsY3riP3ucVot+rOi401UbuBq
 kZPbQPxBklIpJ/6jgxlxCMMRHaxEjG+ixDFrlGO5QkD9K6/w7BavmVDJGPwMSna37cqLamuOYgB
 uYSHjUvqOLakXD54Fpm7yfDB73n7+O+SO5PeHZytDHclYgSfmsaBTmVmYETT9GVJFfjd2Boc4d4
 +G0l4C2jxu3ADU0B5Hr9lXDIq5j3ARXfQRqriVuioAYzZpG8NBNsQ3Pxhr1BxycnhuWP8v9NUSx
 pBwE8nafRRnJQHmtIWrqLKsRhBDoZEoeDGx3BQdHiwz3+PZJxMgJfP/aYVvu6v54XSOrFsKumN1
 Ogu1MwKbR0mQxpu1J0aXYOyVilKrwG70Vaw+WAEmutmeX65l9hQdgaTQgdqi+PvzecrmKetKFtL
 vFk=
X-Received: by 2002:a05:6000:4284:b0:475:f0f0:9f04 with SMTP id
 ffacd0b85a97d-47f4fcfd425mr3114674f8f.59.1784121842615; 
 Wed, 15 Jul 2026 06:24:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634debesm16565613f8f.8.2026.07.15.06.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:24:00 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 13:23:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
X-Gerrit-Change-Number: 1787
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1787?usp=email>
X-Gerrit-Commit: eff09c2e10f41845757f14d537c4153319af6284
In-Reply-To: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
References: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk3YzBmZjQ4ZmIwMTlhYzdjMmQxZDk4MWI3YjdlNDU3OGZmNWRjZTQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <067ff42380ca3b2d825fdb79491495ae3785edc8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1Ge-0007Pg-R1
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: push
 route-gateway(s) for subnet-pool clients
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5461087200157068227=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5461087200157068227==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VCzLt2XE3DA="; charset=UTF-8

--VCzLt2XE3DA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

Hello cron2, pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail

to look at the new patch=
 set (#3)=2E


Change subject: push: push route-gateway(s) for subnet-pool =
clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

push=
: push route-gateway(s) for subnet-pool clients

A subnet-pool client sits =
outside the --server / --server-ipv6 network,
so the global route-gateway (=
the server's own VPN IP) is off-link for
it=2E Replace it with a route-gate=
way, and for IPv6 a route-ipv6-gateway,
inside the client's own subnet, so =
the client's pushed routes install
on-link=2E

A host route to the server's=
 own VPN IP is deliberately not pushed: it
is not needed to reach the netwo=
rks behind the server=2E An admin whose
clients must reach the server's VPN=
 address itself can add an explicit
push "route =2E=2E=2E" to the server co=
nfig=2E

Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
GitHub: close=
s openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
---
M src/openvpn/push=2Ec
1 file changed, 23 insertions(+), 0 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/87/1787/3

diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
inde=
x e391147=2E=2E9057710 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/=
push=2Ec
@@ -645,6 +645,16 @@
                         print_in6_addr(c->c2=
=2Epush_ifconfig_ipv6_local, 0, gc),
                         c->c2=2Epush_=
ifconfig_ipv6_netbits,
                         print_in6_addr(c->c2=2Epush=
_ifconfig_ipv6_remote, 0, gc));
+
+        /* subnet-pool-ipv6 counterpart =
of the IPv4 push below: replace the
+         * global route-ipv6-gateway (=
the server's VPN IP, off-link for this
+         * client) with one inside =
the client's own subnet=2E */
+        if (o->subnet_pool_ipv6_defined)
+  =
      {
+            push_remove_option(o, "route-ipv6-gateway");
+        =
    push_option_fmt(gc, push_list, M_USAGE, "route-ipv6-gateway %s",
+     =
                       print_in6_addr(o->subnet_pool_ipv6_gateway, 0, gc));=

+        }
     }
 
     /* ipv4 */
@@ -659,6 +669,19 @@
         push_opt=
ion_fmt(gc, push_list, M_USAGE, "ifconfig %s %s",
                         =
print_in_addr_t(ifconfig_local, 0, gc),
                         print_in_a=
ddr_t(c->c2=2Epush_ifconfig_remote_netmask, 0, gc));
+
+        /* A subnet=
-pool client sits outside the --server network, so the
+         * global r=
oute-gateway (the server's own VPN IP) is off-link for it:
+         * repl=
ace it with one inside the client's own subnet so that its
+         * push=
ed routes install on-link=2E  A host route to the server's VPN IP
+        =
 * is deliberately not pushed (not needed to reach the networks behind
+   =
      * the server); an admin who needs it adds an explicit push "route"=2E=
 */
+        if (o->subnet_pool_defined)
+        {
+            push_remov=
e_option(o, "route-gateway");
+            push_option_fmt(gc, push_list, M=
_USAGE, "route-gateway %s",
+                            print_in_addr_t(o-=
>subnet_pool_gateway, 0, gc));
+        }
     }
 
     if (tls_multi->use_=
peer_id)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7c0ff48=
fb019ac7c2d1d981b7b7e4578ff5dce48
Gerrit-Change-Number: 1787
Gerrit-PatchSe=
t: 3
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <=
gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
ordex <antonio@mandelbit=2Ecom>

--VCzLt2XE3DA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>ordex <strong>uploaded pa=
tch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1787?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">pu=
sh: push route-gateway(s) for subnet-pool clients<br><br>A subnet-pool clie=
nt sits outside the --server / --server-ipv6 network,<br>so the global rout=
e-gateway (the server&#39;s own VPN IP) is off-link for<br>it=2E Replace it=
 with a route-gateway, and for IPv6 a route-ipv6-gateway,<br>inside the cli=
ent&#39;s own subnet, so the client&#39;s pushed routes install<br>on-link=
=2E<br><br>A host route to the server&#39;s own VPN IP is deliberately not =
pushed: it<br>is not needed to reach the networks behind the server=2E An a=
dmin whose<br>clients must reach the server&#39;s VPN address itself can ad=
d an explicit<br>push &quot;route =2E=2E=2E&quot; to the server config=2E<b=
r><br>Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48<br>GitHub: close=
s openvpn/OpenVPN#987<br>Signed-off-by: Antonio Quartulli &lt;antonio@mande=
lbit=2Ecom&gt;<br>---<br>M src/openvpn/push=2Ec<br>1 file changed, 23 inser=
tions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/1787/3</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index e391147=
=2E=2E9057710 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><=
span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -645,6 +645,16 @@</span>=
<br><span>                         print_in6_addr(c-&gt;c2=2Epush_ifconfig_=
ipv6_local, 0, gc),</span><br><span>                         c-&gt;c2=2Epus=
h_ifconfig_ipv6_netbits,</span><br><span>                         print_in6=
_addr(c-&gt;c2=2Epush_ifconfig_ipv6_remote, 0, gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* subnet-pool-ipv6 counterpart of the IPv4 push bel=
ow: replace the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * global route-ipv6-gateway (the server&#39;s VPN IP, off-link for thi=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * client)=
 with one inside the client&#39;s own subnet=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (o-&gt;subnet_pool_ipv6_defined)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            push_remove_option=
(o, &quot;route-ipv6-gateway&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            push_option_fmt(gc, push_list, M_USAGE, &quot;=
route-ipv6-gateway %s&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                            print_in6_addr(o-&gt;subnet_pool_ipv6_=
gateway, 0, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span>     }</span><br><span> </span><br><span>     /* ip=
v4 */</span><br><span>@@ -659,6 +669,19 @@</span><br><span>         push_op=
tion_fmt(gc, push_list, M_USAGE, &quot;ifconfig %s %s&quot;,</span><br><spa=
n>                         print_in_addr_t(ifconfig_local, 0, gc),</span><b=
r><span>                         print_in_addr_t(c-&gt;c2=2Epush_ifconfig_r=
emote_netmask, 0, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* A su=
bnet-pool client sits outside the --server network, so the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * global route-gateway (the=
 server&#39;s own VPN IP) is off-link for it:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * replace it with one inside the client&=
#39;s own subnet so that its</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * pushed routes install on-link=2E  A host route to the s=
erver&#39;s VPN IP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * is deliberately not pushed (not needed to reach the networks behi=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * the se=
rver); an admin who needs it adds an explicit push &quot;route&quot;=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;su=
bnet_pool_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 push_remove_option(o, &quot;route-gateway&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            push_option_fmt(gc, push_list, M=
_USAGE, &quot;route-gateway %s&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                            print_in_addr_t(o-&gt;subnet_=
pool_gateway, 0, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span>     }</span><br><span> </span><br><span>     =
if (tls_multi-&gt;use_peer_id)</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demai=
l">change 1787</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
87?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1787 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: or=
dex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; =
</div>

</body></html>
--VCzLt2XE3DA=--


--===============5461087200157068227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5461087200157068227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5461087200157068227==--

