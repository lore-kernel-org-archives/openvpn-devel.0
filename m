Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B64606A31D
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cA16pvT2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TbFKNBcO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MVB24mfN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cGcdM8UC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nDQkj24wrh4f0Z0FlLuhWOttU4ba07nuKVKiZSKsRto=; b=cA16pvT2Rir9NMv2wEGY8ODW1L
	iLgHywDv1oJiUQd0Gc195vThaQWPmUxb/Uib748uRLQg4i1pcUj+moKvnGTeaotnz+48AmoxA0d9v
	6yhH6zPaHueQogwPP8v/9t2paZ4TMp2FOcZovCWSqU6/wxVYI1R8DR72nW4HVEZbYqMc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSctG-000000000Pg-2wl5;
	Sun, 15 Nov 2026 16:15:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSctF-000000000PY-20DF
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 16:15:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VYS6FRNJZH/5tGkocxHCESo7XpRLkGauuxv13joQQJw=; b=TbFKNBcOXBAQWMtW0RBulUDv9u
 +bwyqVXD2V1JCAujwRBuk+h5BiLM+2hTq1QyUaVz1xCI+GTnPRvRqDcZnU10C7rqQhBLB1yZXExgw
 joksJMXzYhGqmWUBydvVcPZ9kVlCniS0WZ1ia0iMHi/X1gi8raIr0liNwHq/WVK1kU6o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VYS6FRNJZH/5tGkocxHCESo7XpRLkGauuxv13joQQJw=; b=MVB24mfNOAA9vNQtNqz2Fl+HBE
 lgakGfmQml9pOwgu6SlCHCAUWTBrcr6XfHPFZ7ikpiDCE3oFpNsk3Xqr1iA8DUy0aDhYSVfLeFpkB
 +E2hm3eN+tm/PeJFAxNPoUU+oWFKU6199k/MLSzBPP//jl0u/J9OLM/X1TnJR9d/0gVA=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSctD-00000000485-2Xrk for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 16:15:37 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so1806645e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 08:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794759329; x=1795364129; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VYS6FRNJZH/5tGkocxHCESo7XpRLkGauuxv13joQQJw=;
 b=cGcdM8UCMo4ejGUxsjRsEcLcoq3rGUae8u/qT40UytumiK1s9NQ2c8U9zBaYcW9qZB
 rBQHklADmhnJyV7hJWopaUZUzXrJKZoh9CxBvKjhC5XsrggXHUnQWDLTNfW0Hj76dpsS
 FdK76bsTuZeSgxqKg4MU8KQGtd4JO0kNJ9/5qYfjpLQAI/bA2wPvQZ+TEZRkZcxVWkoP
 sM+CadTAbbYxEH5AfermCdT7RUT5wlcG7ftv4nxerd0+I8ctoh7txVbi+c4ghBpCpxA9
 WrNQocjdAyaS4M9YS1SpxhEwt7F1Dasio1JvVqkSshWvcICodCyJobHj15QXU6n18bjv
 KT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794759329; x=1795364129;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VYS6FRNJZH/5tGkocxHCESo7XpRLkGauuxv13joQQJw=;
 b=h9BA/WZC/3eIO4ZoVHIsX2ZX89+AyM1JCY8wFNfTrWjNwaLG5CqmI5mP32w3ozentn
 FzDuncHPRbunEeWYzqyn4D8OdX7xKH1vcM+5QID34Txcs69nc/DN8bVtwdww2nNX148W
 MCtAq9lSXh8HqS0A/LZkHRTxdi26/aPw/dpPMG7IQh/vzjq6CzNwDmjrMRVQ5XpSc4oV
 TDl+iCzIP3mq7ID+DMJhjXJTFAYPLGr005i0vMRXXtrIlWcJCXcMDeIHebCWmljg67ng
 VXETFLKYHIdP0gfrjzlZtP7NT9t88TLOMBiyDEdzNeQsCF91DTZ8pWOfI2y3cH2gGpAN
 Ifvw==
X-Gm-Message-State: APuU4Z+DaMXFbM/fXstj9lk5L5M5CVzDVU6N4GOBh6a2z/XsDgnochKW
 kpHMgmk1xstEi8ZOWXMF87NpIQwrBlPbmdv28jOavcItWY5ASPQjTKHSXPdqUxSQKseX7njUehB
 52XVD9s3SIl8fKq9b7IWVQp81ib088CkxKNkIFaMPXBmfUB/szPEfaDFvgaISyyXs+Ml+0iRQWH
 7Tk8jaYw==
X-Gm-Gg: AYBFou2sCYi4owrM2kqFHtO/0wNZBL9+G/aJRQzPgLSylheIltoDcVU8dEhC5gTd4wE
 wRXaIxhmP1b3C5+Domq2U5Ww5iFKgrtiamtt7jL6Qrv/5suZuhvYCJbZZx4ZO0qfKu8Tn/GfDCo
 Qp4ONdM6i1edUK1aDgoDVdO9sOfGpCckg5xCZSC8GWRRk91m7Yq/1zxcpDi02r44kFfC2xO1QXw
 mB3JlUHuvJuhj/HdL74MlAbsTlIiOkq3GPc6uSJ/KXzyE3OdB5sqZYcPH44V39sW+tTKAxnwKww
 akpI84/KkbwZmURmGWl0g+tT2p14+8BQXYz/EcjK+OVOE9IQ/1NIsDcN9eT2r5qau9S/EEBBPnK
 7ohWelrCQHnqguIqbe+V3/FrVXfOrBugd6cfMl6SDwednwH4agaDGyBiwNlCIKIXYAkGqlMnhTk
 WIGrdhBnWo+46KZECpjTOZlrsRoQamz6rdTfGpe9kTiAxwwI/2V6CHmg1VUzjyhG7x4xCyHujCN
 VZEC6cgA4vEEX6AdYwOLRlbmzZBIkXa0wikYOju73aI9LsAhkKzlt4OwXl/D1IpVTiD0xGKJN9J
 tLCOMpY+N2Bf/rf2NWqVEkkKQjO0h8abBtzoVWOregg1RrzqCsBCPe78HeXQwUKg5/DswbsWhIV
 e1a9QVUYjSHkA5z5nfbTTLR/uAnETnEpdTZ50kL5niGTHBNPFrZwGu2cwANSCp4kUyJML8qIpjZ
 wGbalLE/vKsGKJLrAA
X-Received: by 2002:a05:600c:4e8e:b0:4a3:59c9:a743 with SMTP id
 5b1f17b1804b1-4bb55a8faffmr180074885e9.27.1794759328628; 
 Sun, 15 Nov 2026 08:15:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae501bsm240518795e9.10.2026.11.15.08.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 08:15:27 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 16:15:26 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
X-Gerrit-Change-Number: 2170
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2170?usp=email>
X-Gerrit-Commit: 80498a0e488bf9004d03d2b3192107a8fe66b391
In-Reply-To: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
References: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzQwMzgwMDAwLkk1YWI5NTllNzEwMWNmODAxYWM5M2U1MTg1ODU1ZTc1ZGIwZmI2MjI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0465752b79bfa095320345512ef51f02d7066d2a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSctD-00000000485-2Xrk
Subject: [Openvpn-devel] [M] Change in openvpn[master]: DragonFly: bring
 things back into a working state
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8608126809830317515=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8608126809830317515==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RlrPG5/+6u0="; charset=UTF-8

--RlrPG5/+6u0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?=
usp=3Demail

to look at the new patch set (#2)=2E

The following approvals =
got outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru


Chan=
ge subject: DragonFly: bring things back into a working state
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

DragonFly: bring things b=
ack into a working state

- t_client=2Esh(=2Ein): add "DragonFly" to the OS=
 versions "like FreeBSD"

- tun=2Ec open_tun()
   - add DragonFly specific =
handling of dynamic tun/tap devices
     (open /dev/{tun,tap}, assigns firs=
t-free node, fdevname(fd) returns
      true device name)
     --dev tunN (=
and tapN) works "the old way", by opening /dev/tunN - but
     only for dev=
ices pre-created with "ifconfig tun3 create"
   - set ioctl(TUNSIFMODE, IFF=
_BROADCAST=3D1) for "topology subnet" tun ifs
     -> this is sufficient to=
 make FreeBSD "ifconfig ipv4" code work
     (DragonFly was broken by FreeB=
SD commit 94db3261659)

- tun=2Ec do_ifconfig_ipv4()
   - use TARGET_FREEBS=
D code path for DragonFly too, just amend the
     error message ("FreeBSD/=
DragonFly ifconfig failed")

- tun=2Ec do_ifconfig_ipv6()
   - needs "add_r=
oute_connected_v6_net()" for tun and tap(!) devices,
     otherwise the on-=
link /64 is not routed to the tun device

- tun=2Ec undo_ifconfig_ipv4(), u=
ndo_ifconfig_ipv6()
   - share FreeBSD code to undo IPv4/IPv6 ifconfig on p=
recreated interfaces
   - add delete_route_connected_v6_net() call for Drag=
onFly only
     (this is not removing fe80:: addresses from the tun if, whi=
ch upsets
      t_client test, but for normal usage is considered "reasonab=
ly fine")

- lladdr=2Ec: add TARGET_DRAGONFLY to TARGET_FREEBSD format

v1 =
-> v2:
 - fix clang-format issues
 - introduce TUNSIFMODE setting
 - revert=
 do_ifconfig_ipv4 change from v1 (use FREEBSD code path)
 - use M_ERR inste=
ad of M_FATAL
 - gate --dev tun/tap check on --dev-node being unset

Change=
-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M src/openvpn/lladdr=2Ec
M src/openvpn/tun=2E=
c
M tests/t_client=2Esh=2Ein
3 files changed, 75 insertions(+), 15 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/7=
0/2170/2

diff --git a/src/openvpn/lladdr=2Ec b/src/openvpn/lladdr=2Ec
inde=
x 8bd572a=2E=2Ec70e282 100644
--- a/src/openvpn/lladdr=2Ec
+++ b/src/openvp=
n/lladdr=2Ec
@@ -24,7 +24,8 @@
 }
 #else /* TARGET_LINUX */
 
-#if defined(=
TARGET_OPENBSD) || defined(TARGET_FREEBSD) || defined(TARGET_DARWIN)
+#if d=
efined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || \
+    defined(TARGET_=
DARWIN)  || defined(TARGET_DRAGONFLY)
 #define IFCONFIG_LLADDR_FMT "%s %s l=
laddr %s"
 #elif defined(TARGET_NETBSD)
 #define IFCONFIG_LLADDR_FMT "%s %s=
 link %s active"
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
ind=
ex 70fdd7e=2E=2Ec1c5548 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/=
tun=2Ec
@@ -979,7 +979,7 @@
 #endif /* ifdef _WIN32 */
 }
 
-#if defined(_W=
IN32)
+#if defined(_WIN32) || defined(TARGET_DRAGONFLY)
 
 /* some of the p=
latforms will auto-add a "network route" pointing
  * to the interface on "=
ifconfig tunX 2001:db8::1/64", others need
@@ -1160,6 +1160,10 @@
     open=
vpn_execve_check(&argv, es, S_FATAL, "FreeBSD BSD 'ifconfig inet6 -ifdisabl=
ed' failed");
 #endif
 
+#ifdef TARGET_DRAGONFLY
+    add_route_connected_v=
6_net(tt, es);
+#endif
+
 #elif defined(TARGET_AIX)
     argv_printf(&argv,=
 "%s %s inet6 %s/%d mtu %d up", IFCONFIG_PATH, ifname, ifconfig_ipv6_local,=

                 tt->netbits_ipv6, tun_mtu);
@@ -1490,7 +1494,7 @@
     }
=
 
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, es, S_FATA=
L, "FreeBSD ifconfig failed");
+    openvpn_execve_check(&argv, es, S_FATAL=
, "FreeBSD/DragonFly ifconfig failed");
 
 #elif defined(TARGET_AIX)
     {=

@@ -1623,14 +1627,14 @@
             msg(M_WARN, "Linux can't del IP from =
iface %s", tt->actual_name);
         }
     }
-#elif defined(TARGET_FREEBS=
D)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
     struct =
gc_arena gc =3D gc_new();
     const char *ifconfig_local =3D print_in_addr=
_t(tt->local, 0, &gc);
     struct argv argv =3D argv_new();
 
     argv_pr=
intf(&argv, "%s %s %s -alias", IFCONFIG_PATH, tt->actual_name, ifconfig_loc=
al);
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, NULL, 0=
, "FreeBSD ip addr del failed");
+    openvpn_execve_check(&argv, NULL, 0, =
"FreeBSD/DragonFly ip addr del failed");
 
     argv_free(&argv);
     gc_f=
ree(&gc);
@@ -1646,7 +1650,12 @@
     {
         msg(M_WARN, "Linux can't d=
el IPv6 from iface %s", tt->actual_name);
     }
-#elif defined(TARGET_FREE=
BSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
+
+#ifdef =
TARGET_DRAGONFLY
+    delete_route_connected_v6_net(tt);
+#endif
+
     str=
uct gc_arena gc =3D gc_new();
     const char *ifconfig_ipv6_local =3D prin=
t_in6_addr(tt->local_ipv6, 0, &gc);
     struct argv argv =3D argv_new();
@=
@ -1655,7 +1664,7 @@
                 ifconfig_ipv6_local, tt->netbits_ipv6=
);
 
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, NULL, 0=
, "FreeBSD ip -6 addr del failed");
+    openvpn_execve_check(&argv, NULL, =
0, "FreeBSD/DragonFly ip -6 addr del failed");
 
     argv_free(&argv);
   =
  gc_free(&gc);
@@ -2897,20 +2906,70 @@
 
 #elif defined(TARGET_DRAGONFLY)
=
 
+/* DragonFly tun/tap devices are similar to NetBSD
+ *  - for a dynamic =
tun/tap, open /dev/tun or /dev/tap, get assigned
+ *    the first free devi=
ce, ask with (f)devname(3) what you got, and
+ *    the interface will auto=
-destruct on close
+ *  - for a pre-created tun/tap, open "/dev/tun3"
+ *  =
- using "--dev tun3" and have it dynamically created needs a call
+ *    to=
 "ifconfig tun3 create" which we don't currently do
+ */
+
 void
 open_tun(=
const char *dev, const char *dev_type, const char *dev_node, struct tuntap =
*tt,
          openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_ty=
pe, dev_node, tt);
-
-    if (tt->fd >=3D 0)
+    if (!dev_node && (strcmp(=
dev, "tap") =3D=3D 0 || strcmp(dev, "tun") =3D=3D 0))
     {
-        int i=
 =3D 0;
+        char tunname[256];
+        snprintf(tunname, sizeof(tunna=
me), "/dev/%s", dev);
 
-        /* Disable extended modes */
+        if (=
(tt->fd =3D open(tunname, O_RDWR)) < 0)
+        {
+            msg(M_ERR, =
"Cannot allocate DragonFly TUN/TAP %s dynamically", tunname);
+        }
+
=
+        char *devname =3D fdevname(tt->fd);
+        if (devname =3D=3D NU=
LL)
+        {
+            msg(M_ERR, "Cannot query DragonFly TUN/TAP devi=
ce name");
+        }
+        set_nonblock(tt->fd);
+        set_cloexec(t=
t->fd); /* don't pass fd to scripts */
+        msg(M_INFO, "TUN/TAP device=
 %s opened", devname);
+
+        tt->actual_name =3D string_alloc(devname,=
 NULL);
+    }
+    else
+    {
+        open_tun_generic(dev, dev_type, de=
v_node, tt);
+    }
+
+    if (tt->fd >=3D 0 && tt->type =3D=3D DEV_TYPE_TU=
N)
+    {
+        /* see "Interface Flags" in ifnet(9) */
+        int i =
=3D IFF_POINTOPOINT | IFF_MULTICAST;
+        if (tt->topology =3D=3D TOP_S=
UBNET)
+        {
+            i =3D IFF_BROADCAST | IFF_MULTICAST;
+      =
  }
+
+        if (ioctl(tt->fd, TUNSIFMODE, &i) < 0)
+        {
+         =
   msg(M_WARN | M_ERRNO, "ioctl(TUNSIFMODE)");
+        }
+
+        /* Dis=
able "link layer" mode (would prepend route-nexthop address
+         * on =
read, but is incompatible with TUNSIFHEAD multi-af mode) */
+        i =3D =
0;
         ioctl(tt->fd, TUNSLMODE, &i);
+
+        /* multi_af mode for v=
4+v6, see "tun(4)" */
         i =3D 1;
-        ioctl(tt->fd, TUNSIFHEAD, =
&i);
+        if (ioctl(tt->fd, TUNSIFHEAD, &i) < 0)
+        {
+          =
  msg(M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD)");
+        }
     }
 }
 
diff -=
-git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 5e924bb=2E=
=2E7488d4b 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=
=2Ein
@@ -212,8 +212,8 @@
                 LANG=3DC @NETSTAT@ -rn -4 -6
   =
          fi
             ;;
-        FreeBSD | NetBSD | Darwin)
-         =
   echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
+        FreeBSD | DragonFl=
y | NetBSD | Darwin )
+            echo "-- FreeBSD/DragonFly/NetBSD/Darwin=
 [MacOS X] --"
             @IFCONFIG@ -a | egrep "(flags=3D|inet)"
       =
      @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
           =
  ;;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ab959e71=
01cf801ac93e5185855e75db0fb6225
Gerrit-Change-Number: 2170
Gerrit-PatchSet:=
 2
Gerrit-Owner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--RlrPG5/+6u0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering <strong>uploaded patch set #2</strong> to this change=2E</p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">DragonFly: bring things bac=
k into a working state<br><br>- t_client=2Esh(=2Ein): add &quot;DragonFly&q=
uot; to the OS versions &quot;like FreeBSD&quot;<br><br>- tun=2Ec open_tun(=
)<br>   - add DragonFly specific handling of dynamic tun/tap devices<br>   =
  (open /dev/{tun,tap}, assigns first-free node, fdevname(fd) returns<br>  =
    true device name)<br>     --dev tunN (and tapN) works &quot;the old way=
&quot;, by opening /dev/tunN - but<br>     only for devices pre-created wit=
h &quot;ifconfig tun3 create&quot;<br>   - set ioctl(TUNSIFMODE, IFF_BROADC=
AST=3D1) for &quot;topology subnet&quot; tun ifs<br>     -&gt; this is suff=
icient to make FreeBSD &quot;ifconfig ipv4&quot; code work<br>     (DragonF=
ly was broken by FreeBSD commit 94db3261659)<br><br>- tun=2Ec do_ifconfig_i=
pv4()<br>   - use TARGET_FREEBSD code path for DragonFly too, just amend th=
e<br>     error message (&quot;FreeBSD/DragonFly ifconfig failed&quot;)<br>=
<br>- tun=2Ec do_ifconfig_ipv6()<br>   - needs &quot;add_route_connected_v6=
_net()&quot; for tun and tap(!) devices,<br>     otherwise the on-link /64 =
is not routed to the tun device<br><br>- tun=2Ec undo_ifconfig_ipv4(), undo=
_ifconfig_ipv6()<br>   - share FreeBSD code to undo IPv4/IPv6 ifconfig on p=
recreated interfaces<br>   - add delete_route_connected_v6_net() call for D=
ragonFly only<br>     (this is not removing fe80:: addresses from the tun i=
f, which upsets<br>      t_client test, but for normal usage is considered =
&quot;reasonably fine&quot;)<br><br>- lladdr=2Ec: add TARGET_DRAGONFLY to T=
ARGET_FREEBSD format<br><br>v1 -&gt; v2:<br> - fix clang-format issues<br> =
- introduce TUNSIFMODE setting<br> - revert do_ifconfig_ipv4 change from v1=
 (use FREEBSD code path)<br> - use M_ERR instead of M_FATAL<br> - gate --de=
v tun/tap check on --dev-node being unset<br><br>Change-Id: I5ab959e7101cf8=
01ac93e5185855e75db0fb6225<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/lladdr=2Ec<br>M src/openvpn/tun=2Ec=
<br>M tests/t_client=2Esh=2Ein<br>3 files changed, 75 insertions(+), 15 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/70/2170/2</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/lladd=
r=2Ec b/src/openvpn/lladdr=2Ec</span><br><span>index 8bd572a=2E=2Ec70e282 1=
00644</span><br><span>--- a/src/openvpn/lladdr=2Ec</span><br><span>+++ b/sr=
c/openvpn/lladdr=2Ec</span><br><span>@@ -24,7 +24,8 @@</span><br><span> }</=
span><br><span> #else /* TARGET_LINUX */</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_OPENBSD) || defined=
(TARGET_FREEBSD) || defined(TARGET_DARWIN)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(TARGET_OPENBSD) || defined(TARGET_FREEBS=
D) || \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    defined(=
TARGET_DARWIN)  || defined(TARGET_DRAGONFLY)</span><br><span> #define IFCON=
FIG_LLADDR_FMT &quot;%s %s lladdr %s&quot;</span><br><span> #elif defined(T=
ARGET_NETBSD)</span><br><span> #define IFCONFIG_LLADDR_FMT &quot;%s %s link=
 %s active&quot;</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/ope=
nvpn/tun=2Ec</span><br><span>index 70fdd7e=2E=2Ec1c5548 100644</span><br><s=
pan>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</sp=
an><br><span>@@ -979,7 +979,7 @@</span><br><span> #endif /* ifdef _WIN32 */=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(_WIN32)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(_WIN32) || defined(TARGET_DRAGONFLY)</span><br>=
<span> </span><br><span> /* some of the platforms will auto-add a &quot;net=
work route&quot; pointing</span><br><span>  * to the interface on &quot;ifc=
onfig tunX 2001:db8::1/64&quot;, others need</span><br><span>@@ -1160,6 +11=
60,10 @@</span><br><span>     openvpn_execve_check(&amp;argv, es, S_FATAL, =
&quot;FreeBSD BSD &#39;ifconfig inet6 -ifdisabled&#39; failed&quot;);</span=
><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef TARGET_DRAGONFLY</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    add_route_connected_v6_net(tt, es);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> #elif defined(TARGET_AIX)</sp=
an><br><span>     argv_printf(&amp;argv, &quot;%s %s inet6 %s/%d mtu %d up&=
quot;, IFCONFIG_PATH, ifname, ifconfig_ipv6_local,</span><br><span>        =
         tt-&gt;netbits_ipv6, tun_mtu);</span><br><span>@@ -1490,7 +1494,7 =
@@</span><br><span>     }</span><br><span> </span><br><span>     argv_msg(M=
_INFO, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 openvpn_execve_check(&amp;argv, es, S_FATAL, &quot;FreeBSD ifconfig failed=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn=
_execve_check(&amp;argv, es, S_FATAL, &quot;FreeBSD/DragonFly ifconfig fail=
ed&quot;);</span><br><span> </span><br><span> #elif defined(TARGET_AIX)</sp=
an><br><span>     {</span><br><span>@@ -1623,14 +1627,14 @@</span><br><span=
>             msg(M_WARN, &quot;Linux can&#39;t del IP from iface %s&quot;,=
 tt-&gt;actual_name);</span><br><span>         }</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREE=
BSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(T=
ARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span>     const char *ifconfig_local =3D =
print_in_addr_t(tt-&gt;local, 0, &amp;gc);</span><br><span>     struct argv=
 argv =3D argv_new();</span><br><span> </span><br><span>     argv_printf(&a=
mp;argv, &quot;%s %s %s -alias&quot;, IFCONFIG_PATH, tt-&gt;actual_name, if=
config_local);</span><br><span>     argv_msg(M_INFO, &amp;argv);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;ar=
gv, NULL, 0, &quot;FreeBSD ip addr del failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openvpn_execve_check(&amp;argv, NULL,=
 0, &quot;FreeBSD/DragonFly ip addr del failed&quot;);</span><br><span> </s=
pan><br><span>     argv_free(&amp;argv);</span><br><span>     gc_free(&amp;=
gc);</span><br><span>@@ -1646,7 +1650,12 @@</span><br><span>     {</span><b=
r><span>         msg(M_WARN, &quot;Linux can&#39;t del IPv6 from iface %s&q=
uot;, tt-&gt;actual_name);</span><br><span>     }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_FREEBSD) || defi=
ned(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_DRA=
GONFLY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    delete_ro=
ute_connected_v6_net(tt);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     const =
char *ifconfig_ipv6_local =3D print_in6_addr(tt-&gt;local_ipv6, 0, &amp;gc)=
;</span><br><span>     struct argv argv =3D argv_new();</span><br><span>@@ =
-1655,7 +1664,7 @@</span><br><span>                 ifconfig_ipv6_local, tt=
-&gt;netbits_ipv6);</span><br><span> </span><br><span>     argv_msg(M_INFO,=
 &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openv=
pn_execve_check(&amp;argv, NULL, 0, &quot;FreeBSD ip -6 addr del failed&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_exe=
cve_check(&amp;argv, NULL, 0, &quot;FreeBSD/DragonFly ip -6 addr del failed=
&quot;);</span><br><span> </span><br><span>     argv_free(&amp;argv);</span=
><br><span>     gc_free(&amp;gc);</span><br><span>@@ -2897,20 +2906,70 @@</=
span><br><span> </span><br><span> #elif defined(TARGET_DRAGONFLY)</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* DragonFl=
y tun/tap devices are similar to NetBSD</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  - for a dynamic tun/tap, open /dev/tun or /dev/tap,=
 get assigned</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
the first free device, ask with (f)devname(3) what you got, and</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *    the interface will auto-d=
estruct on close</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 - for a pre-created tun/tap, open &quot;/dev/tun3&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  - using &quot;--dev tun3&quot; and=
 have it dynamically created needs a call</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *    to &quot;ifconfig tun3 create&quot; which we do=
n&#39;t currently do</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> void</span><br><span> open_tun(const char *dev, const char *dev_type, co=
nst char *dev_node, struct tuntap *tt,</span><br><span>          openvpn_ne=
t_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    open_tun_generic(dev, dev_type, dev_node, tt);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (tt-&gt;fd &gt;=3D 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!dev_node &amp;&amp; (strcmp(dev, &quot=
;tap&quot;) =3D=3D 0 || strcmp(dev, &quot;tun&quot;) =3D=3D 0))</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in=
t i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
har tunname[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      snprintf(tunname, sizeof(tunname), &quot;/dev/%s&quot;, dev);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* =
Disable extended modes */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if ((tt-&gt;fd =3D open(tunname, O_RDWR)) &lt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &quot;Cannot alloc=
ate DragonFly TUN/TAP %s dynamically&quot;, tunname);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        char *devname =3D fdevname(tt-&gt;fd);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (devname =3D=3D NULL)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &quot;Cannot qu=
ery DragonFly TUN/TAP device name&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        set_nonblock(tt-&gt;fd);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        set_cloexec(tt-&gt;fd); /* don&#39;t pass =
fd to scripts */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_INFO, &quot;TUN/TAP device %s opened&quot;, devname);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        tt-&gt;actual_name =3D string_alloc(devna=
me, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        open_tun_generic(dev, dev_type, dev_node=
, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (tt-&gt;fd &gt;=3D 0 &amp;&amp; tt-&gt;=
type =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* see &quot;Interface Flags&quot; in ifnet(9) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        int i =3D IFF_POINTOPOINT | IFF_MULTI=
CAST;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tt=
-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            i =3D IFF_BROADCAST | IFF_MULTICAST;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (ioctl(tt-&gt;fd, TUNSIFMODE, &amp;i) &lt; 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN | M_ERRNO, &quot;i=
octl(TUNSIFMODE)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Disable &quot=
;link layer&quot; mode (would prepend route-nexthop address</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * on read, but is incompat=
ible with TUNSIFHEAD multi-af mode) */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        i =3D 0;</span><br><span>         ioctl(tt-&gt;f=
d, TUNSLMODE, &amp;i);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* multi=
_af mode for v4+v6, see &quot;tun(4)&quot; */</span><br><span>         i =
=3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ioctl(t=
t-&gt;fd, TUNSIFHEAD, &amp;i);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (ioctl(tt-&gt;fd, TUNSIFHEAD, &amp;i) &lt; 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN | M_ERRNO, &qu=
ot;ioctl(TUNSIFHEAD)&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=
=2Esh=2Ein</span><br><span>index 5e924bb=2E=2E7488d4b 100755</span><br><spa=
n>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=
=2Ein</span><br><span>@@ -212,8 +212,8 @@</span><br><span>                 =
LANG=3DC @NETSTAT@ -rn -4 -6</span><br><span>             fi</span><br><spa=
n>             ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    FreeBSD | NetBSD | Darwin)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            echo &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        FreeBSD | D=
ragonFly | NetBSD | Darwin )</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            echo &quot;-- FreeBSD/DragonFly/NetBSD/Darwin [MacOS X=
] --&quot;</span><br><span>             @IFCONFIG@ -a | egrep &quot;(flags=
=3D|inet)&quot;</span><br><span>             @NETSTAT@ -rn | awk &#39;$3 !~=
 /^UHL/ { print $1,$2,$3,$NF }&#39;</span><br><span>             ;;</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2170?usp=3Demail">change 2170</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2170?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6=
225 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2170 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</bo=
dy></html>
--RlrPG5/+6u0=--


--===============8608126809830317515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8608126809830317515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8608126809830317515==--

