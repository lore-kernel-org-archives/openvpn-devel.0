Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B38ACCF2C7
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 22:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qjseKReA3Xsb9Otc06amC6jk5ccA97YYV/v5npfyOiw=; b=GGQsGZgB5K/iWxvQvhntB9Ghgs
	LnpH4I05rzZRh2y3uHYC4jvUq4OegAIWimaXTcHwwPZad1IKseAPqMuugQF8NRoycF1btlTj2xLhZ
	Ykg0TNO/obeET4LyklV3WeL7pfAlf+1gm8rPyCFEz0cgBRJemqpZdFGnKWqNtzTcddCc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIDGX-00015X-GF;
	Sat, 17 Oct 2026 22:52:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIDGW-00015L-DL
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 22:52:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=m8dizSDmfxVaq9SNPIogGY1ymSNMhwM+kE4j3EAg7yo=; b=fhKVkiOgMdDmCZNC2dAlhSpVoe
 OK3XCzieWDFjwqtFLMUKsMh/B3liBcuvMSpyUKG9LYirkZeTgF1bMDDYNaiNCp1LZp0eYSU1oAsCt
 tANqJBnpJv83h3zobnWlngj5mWGrqO4G0uA1IL8cppnJy3qHm7+FJ1Jxo8I+5pNDbkis=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=m8dizSDmfxVaq9SNPIogGY1ymSNMhwM+kE4j3EAg7yo=; b=h
 5D68+9MFl73UPxz9w7heDp/nyspZ9XXLjTZkIYbFDcVel9WKB1DZPHIShUZX8iwRgPTylLM27zaQU
 GBJGBLfVONrVoBjUo1mGBuRoWOKDLX3ruQQN7J1YJxXdPCU6sijt2AdNqO3XO75hLnst0N19NbPpp
 wOnoWHcTk7eIRA6M=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIDGV-0005km-4T for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 22:52:37 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49e73611928so12251965e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792277548; x=1792882348; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m8dizSDmfxVaq9SNPIogGY1ymSNMhwM+kE4j3EAg7yo=;
 b=UpEPIckqjI8yMeMvRRPG29SmRY/9K2/kxT0J8g/+i1eVoOUctWF8RDEzCICrzKGQmq
 hZHJ/nXTRDorHIDG62y01e7xOXodyIUj05qjFJkxbO+pK0x3d0ZVgHOcc5m5c+Rdl0n9
 MNMDPXIVmQ04HSDiUxrFTEtp/dRzefaF+1KNFIqqzAsHviC7YMcFnG3fRcJ4Zio2WTIt
 BL3gnVAew1y2Z/IRIO4rEnRCb46aeM+jnAAnIrF4r1Q+RvoIivoQ4axXJc4C0yoqIWf9
 rJL94fFSs4CwLLejzr7L9XLBC9+uDMx4OJrrlC/MhHl7WlAD9jnadza6y3OOhsVpkVfG
 Dm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792277548; x=1792882348;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m8dizSDmfxVaq9SNPIogGY1ymSNMhwM+kE4j3EAg7yo=;
 b=PG5238zZpPYmjHi1SLflaZE8aPjDsdm0hbsdRDBLDJS1VdINDtAx7S0CHOoA8De5zP
 hABxUV6UAdD/AaLo7oM3Y/D5q+cAs8NCo998REK0MQC1if2eUS2jpa9RtvYSsFKQTeUt
 cTDfvd3G7TskX1BfwM/UqFLIzngAWL1R8dbKMB5c+g6SyrVfHEsCv3sihcxXKdWjSv/9
 DKfvgZreXSfwr81gJM2Fl1dnMYS7lI/ae+9XFwf4WQ/mpy9F9XmItT5Hdt6ccXW503MG
 B+nZniah3O9Kpl+nKJoKjQR+awKaW/eaZPxj4OLKWSov1MYBCvWsIN1PAE/S635Iw1eG
 hh5Q==
X-Gm-Message-State: AFq9FYL1eI9gQ+Rgn+xVtj7FrUGFlDXtO11NdvAit4MkQNJs3SUby8ky
 eLRYnD3t0SWq+5OSB/Obsdxt8wC6SdHHmJ9LOltCDav0fDT8Ot9XN+jG1IG2JaH33nAHG60x3Pc
 3xFDNvZYlzvzjghGlxqPNH0oIabET9ohLeT4rV4fhOLcbqXxY8aszbxlgRK1+6NH8MzeSy2FPpD
 aSr3ff0Q==
X-Gm-Gg: AYBFou0o9tytaFe2OnwY+4xioG0YDBeGbKxs12+m8jcvUrta/KNIHDWQMhFFjrfxMpa
 WigddqI9yPCoAY5v6i29RrQGGRWNeNTPF565m3UFpQnyiieiDCz6bLX5RMUFD9EdRpgFWH7+h43
 9AoH8d1ewU1AV/qSDuKASQPWGO2rjhlYOeDnObu1tLbyuAjBUsfz7Vzf9w0tN78aN3BxO/tSTuI
 QRR9J8yZomoNlXbZxMLESm68DlWxYE+zJKQTFRlDzTuJ7AHcUS8ZCGI8YlFZqCoB7iZKVHtgtsp
 yONYJk0vb6uj0VIBkKMKdcNtaR1mLQzq2q6o/gp0HTE1cQKJSTfRkXr49t1EEjVVqN8kxcxXV/d
 kloK276J5+gzTM5pwtbdH/0DuA2R3fCIL3yyMR7E16rKwHNiBBq9dIuKyLXDkhtLXzt9apUK/hm
 XcJmhHivI+wZhMOZCXDUMt50XweomIDZgLu7iIOzk5kOKLCaJI1X/UBHcZss/dA3pGe8ZbKlgwj
 xweIUNVc/OxRp3BA94e5w9DnNEZvIEgTEJWszWcb6OTLCkbhJv3/n38Hyp4KjnuYNU1c3WHVZML
 yYrGrEXIuZDB/05cnutj7suFt28jfkbuI3uWcfCb5+ZPjyEl89BAkC7MhHC1
X-Received: by 2002:a05:600c:1d04:b0:4a1:7f96:9b42 with SMTP id
 5b1f17b1804b1-4a1d76121a2mr84530555e9.15.1792277548531; 
 Sat, 17 Oct 2026 15:52:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d30d778bsm141747165e9.9.2026.10.17.15.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 15:52:27 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 22:52:22 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
X-Gerrit-Change-Number: 1787
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1787?usp=email>
X-Gerrit-Commit: 771431a6c2c031ffb72b1a25d111187a0429f687
In-Reply-To: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
References: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk3YzBmZjQ4ZmIwMTlhYzdjMmQxZDk4MWI3YjdlNDU3OGZmNWRjZTQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c9995de6cb69364fcc3e2b415e775ca07d95c854-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIDGV-0005km-4T
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8817335377466390523=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8817335377466390523==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EFP1CFKvh24="; charset=UTF-8

--EFP1CFKvh24=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

H=
ello Arne Schwabe, Gert Doering, 

I'd like you to reexamine a change=2E Pl=
ease visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail=


to look at the new patch set (#4)=2E


Change subject: push: push route-g=
ateway(s) for subnet-pool clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

push: push route-gateway(s) for subnet-pool clients
=

A subnet-pool client sits outside the --server / --server-ipv6 network,
so=
 the global route-gateway (the server's own VPN IP) is off-link for
it=2E R=
eplace it with a route-gateway, and for IPv6 a route-ipv6-gateway,
inside t=
he client's own subnet, so the client's pushed routes install
on-link=2E

A=
 host route to the server's own VPN IP is deliberately not pushed: it
is no=
t needed to reach the networks behind the server=2E An admin whose
clients =
must reach the server's VPN address itself can add an explicit
push "route =
=2E=2E=2E" to the server config=2E

Change-Id: I7c0ff48fb019ac7c2d1d981b7b7=
e4578ff5dce48
GitHub: closes openvpn/OpenVPN#987
Signed-off-by: Antonio Qua=
rtulli <antonio@mandelbit=2Ecom>
---
M doc/man-sections/server-options=2Ers=
t
M src/openvpn/push=2Ec
2 files changed, 33 insertions(+), 0 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/178=
7/4

diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/=
server-options=2Erst
index 1e98ff9=2E=2Eeb07d06 100644
--- a/doc/man-sectio=
ns/server-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -356=
,6 +356,16 @@
   The server routes each pool's subnet into the tun device, =
as it does for
   the ``--server`` network; no ``--route`` needs to be adde=
d for it=2E
 
+  A client assigned to a pool is pushed a ``--route-gateway`=
` (and, with
+  ``--subnet-pool-ipv6``, a ``--route-ipv6-gateway``) inside =
its own subnet
+  in place of the global one, so that its pushed routes ins=
tall on-link=2E
+
+  A host route to the server's own VPN IP is not pushed,=
 as it is not needed
+  to reach the networks behind the server=2E If your =
clients need to reach the
+  server's VPN address itself, add an explicit
+=
  ``push "route <server-VPN-IP> 255=2E255=2E255=2E255"`` (or the ``route-ip=
v6``
+  equivalent) to the server config=2E
+
 --subnet-pool-ipv6 args
   T=
he IPv6 counterpart of ``--subnet-pool``=2E Repeatable main-config directiv=
e=2E
 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 8dfe0=
d5=2E=2Efef56d9 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2E=
c
@@ -645,6 +645,16 @@
                         print_in6_addr(c->c2=2Epush=
_ifconfig_ipv6_local, 0, gc),
                         c->c2=2Epush_ifconfi=
g_ipv6_netbits,
                         print_in6_addr(c->c2=2Epush_ifconf=
ig_ipv6_remote, 0, gc));
+
+        /* subnet-pool-ipv6 counterpart of the =
IPv4 push below: replace the
+         * global route-ipv6-gateway (the ser=
ver's VPN IP, off-link for this
+         * client) with one inside the cli=
ent's own subnet=2E */
+        if (o->subnet_pool_ipv6_defined)
+        {=

+            push_remove_option(o, "route-ipv6-gateway");
+            pus=
h_option_fmt(gc, push_list, M_USAGE, "route-ipv6-gateway %s",
+            =
                print_in6_addr(o->subnet_pool_ipv6_gateway, 0, gc));
+     =
   }
     }
 
     /* ipv4 */
@@ -659,6 +669,19 @@
         push_option_fmt=
(gc, push_list, M_USAGE, "ifconfig %s %s",
                         print_i=
n_addr_t(ifconfig_local, 0, gc),
                         print_in_addr_t(c=
->c2=2Epush_ifconfig_remote_netmask, 0, gc));
+
+        /* A subnet-pool c=
lient sits outside the --server network, so the
+         * global route-ga=
teway (the server's own VPN IP) is off-link for it:
+         * replace it =
with one inside the client's own subnet so that its
+         * pushed rout=
es install on-link=2E  A host route to the server's VPN IP
+         * is d=
eliberately not pushed (not needed to reach the networks behind
+         *=
 the server); an admin who needs it adds an explicit push "route"=2E */
+  =
      if (o->subnet_pool_defined)
+        {
+            push_remove_optio=
n(o, "route-gateway");
+            push_option_fmt(gc, push_list, M_USAGE,=
 "route-gateway %s",
+                            print_in_addr_t(o->subnet=
_pool_gateway, 0, gc));
+        }
     }
 
     if (tls_multi->use_peer_id=
 && !tls_multi->use_asymmetric_peer_id)

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
Gerrit-=
Change-Number: 1787
Gerrit-PatchSet: 4
Gerrit-Owner: Antonio Quartulli <ant=
onio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: A=
ntonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>

--EFP1CFKvh24=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Antonio Qu=
artulli <strong>uploaded patch set #4</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail">View Ch=
ange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">push: push route-gateway(s) for subnet-pool clien=
ts<br><br>A subnet-pool client sits outside the --server / --server-ipv6 ne=
twork,<br>so the global route-gateway (the server&#39;s own VPN IP) is off-=
link for<br>it=2E Replace it with a route-gateway, and for IPv6 a route-ipv=
6-gateway,<br>inside the client&#39;s own subnet, so the client&#39;s pushe=
d routes install<br>on-link=2E<br><br>A host route to the server&#39;s own =
VPN IP is deliberately not pushed: it<br>is not needed to reach the network=
s behind the server=2E An admin whose<br>clients must reach the server&#39;=
s VPN address itself can add an explicit<br>push &quot;route =2E=2E=2E&quot=
; to the server config=2E<br><br>Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e45=
78ff5dce48<br>GitHub: closes openvpn/OpenVPN#987<br>Signed-off-by: Antonio =
Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M doc/man-sections/serv=
er-options=2Erst<br>M src/openvpn/push=2Ec<br>2 files changed, 33 insertion=
s(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/87/1787/4</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/ma=
n-sections/server-options=2Erst b/doc/man-sections/server-options=2Erst</sp=
an><br><span>index 1e98ff9=2E=2Eeb07d06 100644</span><br><span>--- a/doc/ma=
n-sections/server-options=2Erst</span><br><span>+++ b/doc/man-sections/serv=
er-options=2Erst</span><br><span>@@ -356,6 +356,16 @@</span><br><span>   Th=
e server routes each pool&#39;s subnet into the tun device, as it does for<=
/span><br><span>   the ``--server`` network; no ``--route`` needs to be add=
ed for it=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  A client assigned to a pool is pushed a ``--route-gateway`` (a=
nd, with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--subne=
t-pool-ipv6``, a ``--route-ipv6-gateway``) inside its own subnet</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  in place of the global one, =
so that its pushed routes install on-link=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  A host route to the server&#39;s own VPN IP is not pushed, as it is=
 not needed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to rea=
ch the networks behind the server=2E If your clients need to reach the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  server&#39;s VPN addre=
ss itself, add an explicit</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  ``push &quot;route &lt;server-VPN-IP&gt; 255=2E255=2E255=2E255&quo=
t;`` (or the ``route-ipv6``</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  equivalent) to the server config=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> --subnet-pool-ipv6 args</span><=
br><span>   The IPv6 counterpart of ``--subnet-pool``=2E Repeatable main-co=
nfig directive=2E</span><br><span> </span><br><span>diff --git a/src/openvp=
n/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 8dfe0d5=2E=2Efef56d=
9 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/s=
rc/openvpn/push=2Ec</span><br><span>@@ -645,6 +645,16 @@</span><br><span>  =
                       print_in6_addr(c-&gt;c2=2Epush_ifconfig_ipv6_local, =
0, gc),</span><br><span>                         c-&gt;c2=2Epush_ifconfig_i=
pv6_netbits,</span><br><span>                         print_in6_addr(c-&gt;=
c2=2Epush_ifconfig_ipv6_remote, 0, gc));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* subnet-pool-ipv6 counterpart of the IPv4 push below: replace t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * global=
 route-ipv6-gateway (the server&#39;s VPN IP, off-link for this</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         * client) with one ins=
ide the client&#39;s own subnet=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (o-&gt;subnet_pool_ipv6_defined)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            push_remove_option(o, &quot;r=
oute-ipv6-gateway&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            push_option_fmt(gc, push_list, M_USAGE, &quot;route-ipv6-=
gateway %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                          print_in6_addr(o-&gt;subnet_pool_ipv6_gateway, 0,=
 gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span>     }</span><br><span> </span><br><span>     /* ipv4 */</span=
><br><span>@@ -659,6 +669,19 @@</span><br><span>         push_option_fmt(gc=
, push_list, M_USAGE, &quot;ifconfig %s %s&quot;,</span><br><span>         =
                print_in_addr_t(ifconfig_local, 0, gc),</span><br><span>   =
                      print_in_addr_t(c-&gt;c2=2Epush_ifconfig_remote_netma=
sk, 0, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* A subnet-pool c=
lient sits outside the --server network, so the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * global route-gateway (the server&#39=
;s own VPN IP) is off-link for it:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * replace it with one inside the client&#39;s own s=
ubnet so that its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * pushed routes install on-link=2E  A host route to the server&#39;s=
 VPN IP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * i=
s deliberately not pushed (not needed to reach the networks behind</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         * the server); an a=
dmin who needs it adds an explicit push &quot;route&quot;=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;subnet_pool_d=
efined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            push_remov=
e_option(o, &quot;route-gateway&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            push_option_fmt(gc, push_list, M_USAGE, &qu=
ot;route-gateway %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                            print_in_addr_t(o-&gt;subnet_pool_gatewa=
y, 0, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span>     }</span><br><span> </span><br><span>     if (tls_mul=
ti-&gt;use_peer_id &amp;&amp; !tls_multi-&gt;use_asymmetric_peer_id)</span>=
<br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1787?usp=3Demail">change 1787</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1787?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff=
5dce48 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1787 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quart=
ulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--EFP1CFKvh24=--


--===============8817335377466390523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8817335377466390523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8817335377466390523==--

