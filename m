Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96A6083603
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QwcqfhSF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TNGBPAKS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TdXvAdRM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UvhpD67m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=9TU6RqYiKxw3mcyrmkLADcbdToUXeajZ2yOhbfhl41o=; b=QwcqfhSFGjs8oRTzHsn+1cWHMq
	34+71YorpPd5rJ1jn4KOdRcqYhKJeOcPullmUR4RDVyMbiTG9k7UPTNx5t3/bKTyYSqEibUnQEo+G
	9n3vaunOJTSD0GON+aGK7okPe6ScvfcuO/c9RotThajN5nN/Ec/f9uWmLxduCET5hLbI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPi7W-000000006W7-06mW;
	Sat, 07 Nov 2026 15:14:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPi7T-000000006Vx-2JjK
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 15:14:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0FyC/lJg3QyPfrLupExlbKQX0AwDH1q0YVz+V96d3iU=; b=TNGBPAKSXFDD3/aSxU9dP07srl
 Olc5KEpF5urGgUDiQMG85f2zql8m7CsTVb/Bw6bzSkPlTxagyMnBPaCDnRdebs8mNdO4YMtarZNVU
 keOzWAarplpZOMI7p5E6jLDlEhsgRnNfnYlD6pPrM/u0BXJPcRT20Z+nUlRAJdrls2eE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0FyC/lJg3QyPfrLupExlbKQX0AwDH1q0YVz+V96d3iU=; b=TdXvAdRMfp2DudGOB2USDQlPge
 b+N3ujYKW4uc18oPlRzh7ecJhSFTJrGVN4+VUwDcca+9NayXrquvjzKKbkUX8FkjzjGIoYBHFFira
 0ywL3hcuHvjf0QyoJsNYBFkmG/BGEp36IUxKKXsWhQOXLzvTRENipT3cMPPsZFvfpbKg=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPi7M-0000000005f-1e4y for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 15:14:11 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so14589655e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 07:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794064442; x=1794669242; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0FyC/lJg3QyPfrLupExlbKQX0AwDH1q0YVz+V96d3iU=;
 b=UvhpD67m1onTiACSGzCVXz3hN+U088kFa/lyAg/nAybPf3ZSFlfsrgkPsWVviNMa8e
 klirKKwVhTn+2ocUMCDR4LhO8OLpsBCIHUqWey/uTDStBBigdQcEoe+54zaTPnLb186w
 C8vGGcqGxoGVNKun3HO1iNn3XqWWgMH3Ei1+ZtXlcvIrcil3KOOrwHEkDhi93G/Q2YOO
 WFBPrxKJEMxQU2fBzkR+l+NxDg7yyr7mkeMtBGCts41ehX7/XQR5LdgmgHMrH/+gpn3C
 s6UHtnQ1GpZS2V0BVgfn/HbG1o0sq/2SttxabAsX6sdpRjkurznWugDVCuNnD0pMXFYI
 3Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794064442; x=1794669242;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0FyC/lJg3QyPfrLupExlbKQX0AwDH1q0YVz+V96d3iU=;
 b=K5QfUYb/6/cpp2EbWHIx7C2bNvNKVpHGcpNOI3VW96ziHhzYAQOaizTb1Yk+LXx6Re
 4BJK67T6uz/tRrXj3AgguuviX3nGSfSo8u3D8cKcz7RHgiboD8akMBfoZq00mrtKp+t4
 QXmJ/mOI+JA17XBjzhNY3cWSxmIJPIFNNRHcccw7MTtQuhiHMKeIT9yBo7GlQBxhUA/L
 j7CPKdspjOqSe+/0Y6OtX4povHx98XGf+zO7A0BDfayRLFXGNq/j2BD9VA7TgJ5IEseb
 j9PuPcRXkKkvtOsHFQDJq6jGpPcwWM5cM8PMz4fHvhzbRQb3rfE+cWIWPqnzVn40w4A/
 q34w==
X-Gm-Message-State: APuU4Z+Wo0KCU/TpQcjgyhvcqPrZYatYHY5F43foN4Dbuc3mc9NscuqB
 ZatyJIKVhtXHaO57KW2E3CNV77zOHoDYkqKm+onpB8n2QpgRrpa1/ANtZCjpOwEQGIh+t6X/lFL
 g/f3KhXH/ju8EmkUpdiuKM9mAySzS9XCJ4+VhYvpT1FuYywdyiD97oYhlgDTRVTHgvWyJCO75Mr
 8UYfdUoQ==
X-Gm-Gg: AYBFou1LhfFQd9VQUWrcN7lu1Md1ik20fbnRjRbg+v4w5unqcU+zWgbdwZLhC4yMIm/
 PTIjI6xaaB0z0N7Whv0kue54ow6Rmpzs8JJIPcGrrwGjsj7u1+nChsqQeCfjqdPfgbsqTeTMdN2
 i2yI8dEFBHPPRnm3slgmER4C+XhfB2h5qZu6u8jmjSFPxgA3TNYRVF6De1RhoNOqvRuv0URG9Xg
 ZWNZN9qkD38/kpC8+76MevvXeJ7TRsxjjQBWwQjsScvMjAlZHZqnvXLPkJkTEvGr60+HJBmiDbC
 t34QbNcCoIHsjcMV2GCKqKxfCgXD5jmNgJ6e38BTesRE3Uu4H8Hvpr643+sCPOOa9RRJBahZnfY
 FnD/ifwNv1JXb+rBDn1JSN5iAiosTAyfVAvqlTLLWkodHI+rF5EM5S+LW/j2jpl5/NqdGLWh0Rh
 fz3pjr4Jg983jEooirgCTeMrrNNDV0Nie+cFW9NPi7rE1hGhKH7ASI2zUUzcsOSKlOXBIiHXIBs
 ITJ+4joQhWe5iuHVu2SqXDn/SyQ4YOraDf96iRggg+ZDoW7T3L97XfznzWRa/xZMP0uA4jWJkVR
 6+f6OrBQmZvXv0dwi0mP146wv+onWMfc3v4wW4XXAwkw49Uc2TTPSrmyjd66PVUaTE6cElXBL9L
 A61XNpvkKHjUxp7kGt7s8gYhKpi2s4qKzBTE3z7lxzwqlHv3n9oSTUojJJGkBaqzdCur5rgwZ96
 Vnw1guqRdrIMCZ2w==
X-Received: by 2002:a05:600c:4fc9:b0:4a1:fcfa:2a07 with SMTP id
 5b1f17b1804b1-4b6e007beefmr105350705e9.30.1794064441442; 
 Sat, 07 Nov 2026 07:14:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7e327a652sm69833675e9.7.2026.11.07.07.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 07:14:01 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 15:14:00 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie9b2723486214232aad33991b267dc0ff4d1c535
X-Gerrit-Change-Number: 2150
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2150?usp=email>
X-Gerrit-Commit: b84bdc3874918f404db839989973dffa373a0859
References: <gerrit.1794064436000.Ie9b2723486214232aad33991b267dc0ff4d1c535@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY0NDM2MDAwLkllOWIyNzIzNDg2MjE0MjMyYWFkMzM5OTFiMjY3ZGMwZmY0ZDFjNTM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <82cd6b81ecdb60ab68ba60eb9997241870e11ef9-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPi7M-0000000005f-1e4y
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: add
 route_exec() for the per-OS route commands
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1795386300066029304=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1795386300066029304==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IzFC6J6oWgM="; charset=UTF-8

--IzFC6J6oWgM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2150?usp=3Demail

to review the following change=2E
=


Change subject: route: add route_exec() for the per-OS route commands
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: add route=
_exec() for the per-OS route commands

The non-Linux, non-Windows add and d=
elete paths all log the route
command, run it with openvpn_execve_check() a=
nd turn the result into
RTA_SUCCESS or RTA_ERROR=2E Do that in one helper=
=2E

Change-Id: Ie9b2723486214232aad33991b267dc0ff4d1c535
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/route=2Ec
1 file ch=
anged, 38 insertions(+), 70 deletions(-)



  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/50/2150/1

diff --git a/src/openvpn/rou=
te=2Ec b/src/openvpn/route=2Ec
index 53550c4=2E=2Ed483c5f 100644
--- a/src/=
openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -1446,6 +1446,16 @@
 }
 #e=
ndif
 
+#if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID) && !defined(=
_WIN32)
+/* Log and run a route command, returning RTA_SUCCESS or RTA_ERROR=
 */
+static int
+route_exec(const struct argv *argv, const struct env_set *=
es, const char *error_message)
+{
+    argv_msg(D_ROUTE, argv);
+    return=
 openvpn_execve_check(argv, es, 0, error_message) ? RTA_SUCCESS : RTA_ERROR=
;
+}
+#endif
+
 bool
 add_route(struct route_ipv4 *r, const struct tuntap *=
tt, unsigned int flags,
           const struct route_gateway_info *rgi, /*=
 may be NULL */
@@ -1601,9 +1611,7 @@
         argv_printf_cat(&argv, "%d",=
 r->metric);
     }
 
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D open=
vpn_execve_check(&argv, es, 0, "ERROR: Solaris route add command failed");
=
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+    status =3D route_exec(&=
argv, es, "ERROR: Solaris route add command failed");
 
 #elif defined(TARG=
ET_FREEBSD)
 
@@ -1620,9 +1628,7 @@
 
     /* FIXME -- add on-link support =
for FreeBSD */
 
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_e=
xecve_check(&argv, es, 0, "ERROR: FreeBSD route add command failed");
-    =
status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+    status =3D route_exec(&argv,=
 es, "ERROR: FreeBSD route add command failed");
 
 #elif defined(TARGET_DR=
AGONFLY)
 
@@ -1639,9 +1645,7 @@
 
     /* FIXME -- add on-link support for=
 Dragonfly */
 
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_ex=
ecve_check(&argv, es, 0, "ERROR: DragonFly route add command failed");
-   =
 status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+    status =3D route_exec(&argv=
, es, "ERROR: DragonFly route add command failed");
 
 #elif defined(TARGET=
_DARWIN)
 
@@ -1666,9 +1670,7 @@
         argv_printf_cat(&argv, "-net %s %=
s %s", network, gateway, netmask);
     }
 
-    argv_msg(D_ROUTE, &argv);
=
-    bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: OS X route add=
 command failed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+    stat=
us =3D route_exec(&argv, es, "ERROR: OS X route add command failed");
 
 #e=
lif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
@@ -1685,18 +1687,1=
4 @@
 
     /* FIXME -- add on-link support for OpenBSD/NetBSD */
 
-    ar=
gv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&argv, es, 0=
, "ERROR: OpenBSD/NetBSD route add command failed");
-    status =3D ret ? =
RTA_SUCCESS : RTA_ERROR;
+    status =3D route_exec(&argv, es, "ERROR: Open=
BSD/NetBSD route add command failed");
 
 #elif defined(TARGET_AIX)
 
     =
{
         int netbits =3D netmask_to_netbits2(r->netmask);
         argv_p=
rintf(&argv, "%s add -net %s/%d %s", ROUTE_PATH, network, netbits, gateway)=
;
-        argv_msg(D_ROUTE, &argv);
-        bool ret =3D openvpn_execve_c=
heck(&argv, es, 0, "ERROR: AIX route add command failed");
-        status =
=3D ret ? RTA_SUCCESS : RTA_ERROR;
+        status =3D route_exec(&argv, es=
, "ERROR: AIX route add command failed");
     }
 
 #elif defined(TARGET_HA=
IKU)
@@ -1704,9 +1702,7 @@
     /* ex: route add /dev/net/ipro1000/0 0=2E0=
=2E0=2E0 gw 192=2E168=2E1=2E1 netmask 128=2E0=2E0=2E0 */
     argv_printf(&=
argv, "%s add %s inet %s gw %s netmask %s", ROUTE_PATH, rgi->iface, network=
,
                 gateway, netmask);
-    argv_msg(D_ROUTE, &argv);
-    b=
ool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet route add=
 command failed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+    stat=
us =3D route_exec(&argv, es, "ERROR: Haiku inet route add command failed");=

 
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL,
@@ -1898,9 +189=
4,7 @@
         argv_printf_cat(&argv, "0");
     }
 
-    argv_msg(D_ROUTE=
, &argv);
-    bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: Sola=
ris route add -inet6 command failed");
-    status =3D ret ? RTA_SUCCESS : =
RTA_ERROR;
+    status =3D route_exec(&argv, es, "ERROR: Solaris route add =
-inet6 command failed");
 
 #elif defined(TARGET_FREEBSD) || defined(TARGET=
_DRAGONFLY)
 
@@ -1915,9 +1909,7 @@
         argv_printf_cat(&argv, "-iface=
 %s", device);
     }
 
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D op=
envpn_execve_check(&argv, es, 0, "ERROR: *BSD route add -inet6 command fail=
ed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+    status =3D route_=
exec(&argv, es, "ERROR: *BSD route add -inet6 command failed");
 
 #elif de=
fined(TARGET_DARWIN)
 
@@ -1932,42 +1924,32 @@
         argv_printf_cat(&ar=
gv, "-iface %s", device);
     }
 
-    argv_msg(D_ROUTE, &argv);
-    bool=
 ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: MacOS X route add -inet=
6 command failed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+    sta=
tus =3D route_exec(&argv, es, "ERROR: MacOS X route add -inet6 command fail=
ed");
 
 #elif defined(TARGET_OPENBSD)
 
     argv_printf(&argv, "%s add -i=
net6 %s -prefixlen %d %s", ROUTE_PATH, network, r6->netbits,
              =
   gateway);
 
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_exe=
cve_check(&argv, es, 0, "ERROR: OpenBSD route add -inet6 command failed");
=
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+    status =3D route_exec(&=
argv, es, "ERROR: OpenBSD route add -inet6 command failed");
 
 #elif defin=
ed(TARGET_NETBSD)
 
     argv_printf(&argv, "%s add -inet6 %s/%d %s", ROUTE=
_PATH, network, r6->netbits, gateway);
 
-    argv_msg(D_ROUTE, &argv);
-  =
  bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: NetBSD route add =
-inet6 command failed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+  =
  status =3D route_exec(&argv, es, "ERROR: NetBSD route add -inet6 command =
failed");
 
 #elif defined(TARGET_AIX)
 
     argv_printf(&argv, "%s add -i=
net6 %s/%d %s", ROUTE_PATH, network, r6->netbits, gateway);
-    argv_msg(D=
_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR=
: AIX route add command failed");
-    status =3D ret ? RTA_SUCCESS : RTA_E=
RROR;
+    status =3D route_exec(&argv, es, "ERROR: AIX route add command f=
ailed");
 
 #elif defined(TARGET_HAIKU)
 
     /* ex: route add /dev/net/ip=
ro1000/0 inet6 :: gw beef::cafe prefixlen 64 */
     argv_printf(&argv, "%s=
 add %s inet6 %s gw %s prefixlen %d", ROUTE_PATH, r6->iface, network,
     =
            gateway, r6->netbits);
-    argv_msg(D_ROUTE, &argv);
-    bool=
 ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet6 route add c=
ommand failed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+    status=
 =3D route_exec(&argv, es, "ERROR: Haiku inet6 route add command failed");
=
 
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL,
@@ -2086,22 +206=
8,19 @@
 
     argv_printf(&argv, "%s delete %s -netmask %s %s", ROUTE_PATH=
, network, netmask, gateway);
 
-    argv_msg(D_ROUTE, &argv);
-    openvpn=
_execve_check(&argv, es, 0, "ERROR: Solaris route delete command failed");
=
+    route_exec(&argv, es, "ERROR: Solaris route delete command failed");
 =

 #elif defined(TARGET_FREEBSD)
 
     argv_printf(&argv, "%s delete -net %=
s %s %s", ROUTE_PATH, network, gateway, netmask);
 
-    argv_msg(D_ROUTE, =
&argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: FreeBSD route delet=
e command failed");
+    route_exec(&argv, es, "ERROR: FreeBSD route delete=
 command failed");
 
 #elif defined(TARGET_DRAGONFLY)
 
     argv_printf(&a=
rgv, "%s delete -net %s %s %s", ROUTE_PATH, network, gateway, netmask);
 
-=
    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERRO=
R: DragonFly route delete command failed");
+    route_exec(&argv, es, "ERR=
OR: DragonFly route delete command failed");
 
 #elif defined(TARGET_DARWIN=
)
 
@@ -2115,15 +2094,13 @@
         argv_printf(&argv, "%s delete -net %s =
%s %s", ROUTE_PATH, network, gateway, netmask);
     }
 
-    argv_msg(D_RO=
UTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: OS X route del=
ete command failed");
+    route_exec(&argv, es, "ERROR: OS X route delete =
command failed");
 
 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD=
)
 
     argv_printf(&argv, "%s delete -net %s %s -netmask %s", ROUTE_PATH,=
 network, gateway, netmask);
 
-    argv_msg(D_ROUTE, &argv);
-    openvpn_=
execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete command fail=
ed");
+    route_exec(&argv, es, "ERROR: OpenBSD/NetBSD route delete comman=
d failed");
 
 #elif defined(TARGET_ANDROID)
     /* Avoids the unused vari=
ables warnings that all other platforms use
@@ -2138,8 +2115,7 @@
     {
  =
       int netbits =3D netmask_to_netbits2(r->netmask);
         argv_print=
f(&argv, "%s delete -net %s/%d %s", ROUTE_PATH, network, netbits, gateway);=

-        argv_msg(D_ROUTE, &argv);
-        openvpn_execve_check(&argv, es=
, 0, "ERROR: AIX route delete command failed");
+        route_exec(&argv, =
es, "ERROR: AIX route delete command failed");
     }
 
 #elif defined(TARG=
ET_HAIKU)
@@ -2147,8 +2123,7 @@
     /* ex: route delete /dev/net/ipro1000/=
0 inet 192=2E168=2E0=2E0 gw 192=2E168=2E1=2E1 netmask 255=2E255=2E0=2E0 */
=
     argv_printf(&argv, "%s delete %s inet %s gw %s netmask %s", ROUTE_PATH=
, rgi->iface, network,
                 gateway, netmask);
-    argv_msg(D_=
ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet r=
oute delete command failed");
+    route_exec(&argv, es, "ERROR: Haiku inet=
 route delete command failed");
 
 #else  /* if defined(TARGET_LINUX) */
  =
   msg(M_FATAL,
@@ -2255,8 +2230,7 @@
 
     argv_printf(&argv, "%s delete =
-inet6 %s/%d %s", ROUTE_PATH, network, r6->netbits, gateway);
 
-    argv_m=
sg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: Solaris=
 route delete -inet6 command failed");
+    route_exec(&argv, es, "ERROR: S=
olaris route delete -inet6 command failed");
 
 #elif defined(TARGET_FREEBS=
D) || defined(TARGET_DRAGONFLY)
 
@@ -2271,8 +2245,7 @@
         argv_print=
f_cat(&argv, "-iface %s", device);
     }
 
-    argv_msg(D_ROUTE, &argv);
=
-    openvpn_execve_check(&argv, es, 0, "ERROR: *BSD route delete -inet6 co=
mmand failed");
+    route_exec(&argv, es, "ERROR: *BSD route delete -inet6=
 command failed");
 
 #elif defined(TARGET_DARWIN)
 
@@ -2287,29 +2260,25 @=
@
         argv_printf_cat(&argv, "-iface %s", device);
     }
 
-    argv_=
msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: MacOS =
X route delete -inet6 command failed");
+    route_exec(&argv, es, "ERROR: =
MacOS X route delete -inet6 command failed");
 
 #elif defined(TARGET_OPENB=
SD)
 
     argv_printf(&argv, "%s delete -inet6 %s -prefixlen %d %s", ROUTE=
_PATH, network, r6->netbits,
                 gateway);
 
-    argv_msg(D_R=
OUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD route=
 delete -inet6 command failed");
+    route_exec(&argv, es, "ERROR: OpenBSD=
 route delete -inet6 command failed");
 
 #elif defined(TARGET_NETBSD)
 
  =
   argv_printf(&argv, "%s delete -inet6 %s/%d %s", ROUTE_PATH, network, r6-=
>netbits, gateway);
 
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_ch=
eck(&argv, es, 0, "ERROR: NetBSD route delete -inet6 command failed");
+   =
 route_exec(&argv, es, "ERROR: NetBSD route delete -inet6 command failed");=

 
 #elif defined(TARGET_AIX)
 
     argv_printf(&argv, "%s delete -inet6 %=
s/%d %s", ROUTE_PATH, network, r6->netbits, gateway);
-    argv_msg(D_ROUTE=
, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: AIX route delete =
command failed");
+    route_exec(&argv, es, "ERROR: AIX route delete comma=
nd failed");
 
 #elif defined(TARGET_ANDROID)
     msg(D_ROUTE_DEBUG, "Dele=
ting routes on Android is not possible/not "
@@ -2323,8 +2292,7 @@
     /* =
ex: route delete /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixlen 64 */=

     argv_printf(&argv, "%s delete %s inet6 %s gw %s prefixlen %d", ROUTE_=
PATH, r6->iface, network,
                 gateway, r6->netbits);
-    argv=
_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: Haiku=
 inet6 route delete command failed");
+    route_exec(&argv, es, "ERROR: Ha=
iku inet6 route delete command failed");
 
 #else  /* if defined(TARGET_LIN=
UX) */
     msg(M_FATAL,

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2150?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Ie9b2723486214232aad33991b267dc0ff4d1c535
Gerrit-Change-Number: 215=
0
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>

--IzFC6J6oWgM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2150?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">route: add route_exec() for the per-OS route commands<b=
r><br>The non-Linux, non-Windows add and delete paths all log the route<br>=
command, run it with openvpn_execve_check() and turn the result into<br>RTA=
_SUCCESS or RTA_ERROR=2E Do that in one helper=2E<br><br>Change-Id: Ie9b272=
3486214232aad33991b267dc0ff4d1c535<br>Signed-off-by: Razvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file changed=
, 38 insertions(+), 70 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/50/2150/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>inde=
x 53550c4=2E=2Ed483c5f 100644</span><br><span>--- a/src/openvpn/route=2Ec</=
span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -1446,6 +1446=
,16 @@</span><br><span> }</span><br><span> #endif</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_LINUX) =
&amp;&amp; !defined(TARGET_ANDROID) &amp;&amp; !defined(_WIN32)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Log and run a route command,=
 returning RTA_SUCCESS or RTA_ERROR */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+route_exec(const struct argv *argv, const struct env_set *es, con=
st char *error_message)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_msg(D=
_ROUTE, argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn openvpn_execve_check(argv, es, 0, error_message) ? RTA_SUCCESS : RTA_=
ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> add_=
route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,</s=
pan><br><span>           const struct route_gateway_info *rgi, /* may be NU=
LL */</span><br><span>@@ -1601,9 +1611,7 @@</span><br><span>         argv_p=
rintf_cat(&amp;argv, &quot;%d&quot;, r-&gt;metric);</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR=
: Solaris route add command failed&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D route_exec(&a=
mp;argv, es, &quot;ERROR: Solaris route add command failed&quot;);</span><b=
r><span> </span><br><span> #elif defined(TARGET_FREEBSD)</span><br><span> <=
/span><br><span>@@ -1620,9 +1628,7 @@</span><br><span> </span><br><span>   =
  /* FIXME -- add on-link support for FreeBSD */</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;arg=
v);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D o=
penvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: FreeBSD route add comman=
d failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
tatus =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    status =3D route_exec(&amp;argv, es, &quot;ERROR: =
FreeBSD route add command failed&quot;);</span><br><span> </span><br><span>=
 #elif defined(TARGET_DRAGONFLY)</span><br><span> </span><br><span>@@ -1639=
,9 +1645,7 @@</span><br><span> </span><br><span>     /* FIXME -- add on-lin=
k support for Dragonfly */</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D openvpn_execve_check(&a=
mp;argv, es, 0, &quot;ERROR: DragonFly route add command failed&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D ret ? RTA_=
SUCCESS : RTA_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    status =3D route_exec(&amp;argv, es, &quot;ERROR: DragonFly route add =
command failed&quot;);</span><br><span> </span><br><span> #elif defined(TAR=
GET_DARWIN)</span><br><span> </span><br><span>@@ -1666,9 +1670,7 @@</span><=
br><span>         argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, net=
work, gateway, netmask);</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D op=
envpn_execve_check(&amp;argv, es, 0, &quot;ERROR: OS X route add command fa=
iled&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    statu=
s =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    status =3D route_exec(&amp;argv, es, &quot;ERROR: OS X=
 route add command failed&quot;);</span><br><span> </span><br><span> #elif =
defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> </span><=
br><span>@@ -1685,18 +1687,14 @@</span><br><span> </span><br><span>     /* =
FIXME -- add on-link support for OpenBSD/NetBSD */</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;a=
rgv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D=
 openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: OpenBSD/NetBSD route a=
dd command failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    status =3D route_exec(&amp;argv, es, &quo=
t;ERROR: OpenBSD/NetBSD route add command failed&quot;);</span><br><span> <=
/span><br><span> #elif defined(TARGET_AIX)</span><br><span> </span><br><spa=
n>     {</span><br><span>         int netbits =3D netmask_to_netbits2(r-&gt=
;netmask);</span><br><span>         argv_printf(&amp;argv, &quot;%s add -ne=
t %s/%d %s&quot;, ROUTE_PATH, network, netbits, gateway);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        argv_msg(D_ROUTE, &amp;argv);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bool ret =3D op=
envpn_execve_check(&amp;argv, es, 0, &quot;ERROR: AIX route add command fai=
led&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        st=
atus =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        status =3D route_exec(&amp;argv, es, &quot;ERRO=
R: AIX route add command failed&quot;);</span><br><span>     }</span><br><s=
pan> </span><br><span> #elif defined(TARGET_HAIKU)</span><br><span>@@ -1704=
,9 +1702,7 @@</span><br><span>     /* ex: route add /dev/net/ipro1000/0 0=
=2E0=2E0=2E0 gw 192=2E168=2E1=2E1 netmask 128=2E0=2E0=2E0 */</span><br><spa=
n>     argv_printf(&amp;argv, &quot;%s add %s inet %s gw %s netmask %s&quot=
;, ROUTE_PATH, rgi-&gt;iface, network,</span><br><span>                 gat=
eway, netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ar=
gv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: =
Haiku inet route add command failed&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D route_exec(&=
amp;argv, es, &quot;ERROR: Haiku inet route add command failed&quot;);</spa=
n><br><span> </span><br><span> #else  /* if defined(TARGET_LINUX) */</span>=
<br><span>     msg(M_FATAL,</span><br><span>@@ -1898,9 +1894,7 @@</span><br=
><span>         argv_printf_cat(&amp;argv, &quot;0&quot;);</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quo=
t;ERROR: Solaris route add -inet6 command failed&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_E=
RROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D=
 route_exec(&amp;argv, es, &quot;ERROR: Solaris route add -inet6 command fa=
iled&quot;);</span><br><span> </span><br><span> #elif defined(TARGET_FREEBS=
D) || defined(TARGET_DRAGONFLY)</span><br><span> </span><br><span>@@ -1915,=
9 +1909,7 @@</span><br><span>         argv_printf_cat(&amp;argv, &quot;-ifa=
ce %s&quot;, device);</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D openv=
pn_execve_check(&amp;argv, es, 0, &quot;ERROR: *BSD route add -inet6 comman=
d failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
tatus =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    status =3D route_exec(&amp;argv, es, &quot;ERROR: =
*BSD route add -inet6 command failed&quot;);</span><br><span> </span><br><s=
pan> #elif defined(TARGET_DARWIN)</span><br><span> </span><br><span>@@ -193=
2,42 +1924,32 @@</span><br><span>         argv_printf_cat(&amp;argv, &quot;=
-iface %s&quot;, device);</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;arg=
v);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D o=
penvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: MacOS X route add -inet6=
 command failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    status =3D route_exec(&amp;argv, es, &quot;=
ERROR: MacOS X route add -inet6 command failed&quot;);</span><br><span> </s=
pan><br><span> #elif defined(TARGET_OPENBSD)</span><br><span> </span><br><s=
pan>     argv_printf(&amp;argv, &quot;%s add -inet6 %s -prefixlen %d %s&quo=
t;, ROUTE_PATH, network, r6-&gt;netbits,</span><br><span>                 g=
ateway);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &q=
uot;ERROR: OpenBSD route add -inet6 command failed&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA=
_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =
=3D route_exec(&amp;argv, es, &quot;ERROR: OpenBSD route add -inet6 command=
 failed&quot;);</span><br><span> </span><br><span> #elif defined(TARGET_NET=
BSD)</span><br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s=
 add -inet6 %s/%d %s&quot;, ROUTE_PATH, network, r6-&gt;netbits, gateway);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR=
: NetBSD route add -inet6 command failed&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D route_e=
xec(&amp;argv, es, &quot;ERROR: NetBSD route add -inet6 command failed&quot=
;);</span><br><span> </span><br><span> #elif defined(TARGET_AIX)</span><br>=
<span> </span><br><span>     argv_printf(&amp;argv, &quot;%s add -inet6 %s/=
%d %s&quot;, ROUTE_PATH, network, r6-&gt;netbits, gateway);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D openvpn_=
execve_check(&amp;argv, es, 0, &quot;ERROR: AIX route add command failed&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D r=
et ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    status =3D route_exec(&amp;argv, es, &quot;ERROR: AIX route a=
dd command failed&quot;);</span><br><span> </span><br><span> #elif defined(=
TARGET_HAIKU)</span><br><span> </span><br><span>     /* ex: route add /dev/=
net/ipro1000/0 inet6 :: gw beef::cafe prefixlen 64 */</span><br><span>     =
argv_printf(&amp;argv, &quot;%s add %s inet6 %s gw %s prefixlen %d&quot;, R=
OUTE_PATH, r6-&gt;iface, network,</span><br><span>                 gateway,=
 r6-&gt;netbits);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR=
: Haiku inet6 route add command failed&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D route_exe=
c(&amp;argv, es, &quot;ERROR: Haiku inet6 route add command failed&quot;);<=
/span><br><span> </span><br><span> #else  /* if defined(TARGET_LINUX) */</s=
pan><br><span>     msg(M_FATAL,</span><br><span>@@ -2086,22 +2068,19 @@</sp=
an><br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s delete =
%s -netmask %s %s&quot;, ROUTE_PATH, network, netmask, gateway);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D=
_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Solaris route delete =
command failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    route_exec(&amp;argv, es, &quot;ERROR: Solaris route delete command =
failed&quot;);</span><br><span> </span><br><span> #elif defined(TARGET_FREE=
BSD)</span><br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s=
 delete -net %s %s %s&quot;, ROUTE_PATH, network, gateway, netmask);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_m=
sg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: FreeBSD route del=
ete command failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    route_exec(&amp;argv, es, &quot;ERROR: FreeBSD route delete comm=
and failed&quot;);</span><br><span> </span><br><span> #elif defined(TARGET_=
DRAGONFLY)</span><br><span> </span><br><span>     argv_printf(&amp;argv, &q=
uot;%s delete -net %s %s %s&quot;, ROUTE_PATH, network, gateway, netmask);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: DragonFly r=
oute delete command failed&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    route_exec(&amp;argv, es, &quot;ERROR: DragonFly route d=
elete command failed&quot;);</span><br><span> </span><br><span> #elif defin=
ed(TARGET_DARWIN)</span><br><span> </span><br><span>@@ -2115,15 +2094,13 @@=
</span><br><span>         argv_printf(&amp;argv, &quot;%s delete -net %s %s=
 %s&quot;, ROUTE_PATH, network, gateway, netmask);</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a=
rgv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: OS X route d=
elete command failed&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    route_exec(&amp;argv, es, &quot;ERROR: OS X route delete comma=
nd failed&quot;);</span><br><span> </span><br><span> #elif defined(TARGET_O=
PENBSD) || defined(TARGET_NETBSD)</span><br><span> </span><br><span>     ar=
gv_printf(&amp;argv, &quot;%s delete -net %s %s -netmask %s&quot;, ROUTE_PA=
TH, network, gateway, netmask);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv,=
 es, 0, &quot;ERROR: OpenBSD/NetBSD route delete command failed&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    route_exec(&amp;arg=
v, es, &quot;ERROR: OpenBSD/NetBSD route delete command failed&quot;);</spa=
n><br><span> </span><br><span> #elif defined(TARGET_ANDROID)</span><br><spa=
n>     /* Avoids the unused variables warnings that all other platforms use=
</span><br><span>@@ -2138,8 +2115,7 @@</span><br><span>     {</span><br><sp=
an>         int netbits =3D netmask_to_netbits2(r-&gt;netmask);</span><br><=
span>         argv_printf(&amp;argv, &quot;%s delete -net %s/%d %s&quot;, R=
OUTE_PATH, network, netbits, gateway);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        argv_msg(D_ROUTE, &amp;argv);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        openvpn_execve_check(&amp;argv, es=
, 0, &quot;ERROR: AIX route delete command failed&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        route_exec(&amp;argv, es, &qu=
ot;ERROR: AIX route delete command failed&quot;);</span><br><span>     }</s=
pan><br><span> </span><br><span> #elif defined(TARGET_HAIKU)</span><br><spa=
n>@@ -2147,8 +2123,7 @@</span><br><span>     /* ex: route delete /dev/net/i=
pro1000/0 inet 192=2E168=2E0=2E0 gw 192=2E168=2E1=2E1 netmask 255=2E255=2E0=
=2E0 */</span><br><span>     argv_printf(&amp;argv, &quot;%s delete %s inet=
 %s gw %s netmask %s&quot;, ROUTE_PATH, rgi-&gt;iface, network,</span><br><=
span>                 gateway, netmask);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, es, 0, =
&quot;ERROR: Haiku inet route delete command failed&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    route_exec(&amp;argv, es, &quot=
;ERROR: Haiku inet route delete command failed&quot;);</span><br><span> </s=
pan><br><span> #else  /* if defined(TARGET_LINUX) */</span><br><span>     m=
sg(M_FATAL,</span><br><span>@@ -2255,8 +2230,7 @@</span><br><span> </span><=
br><span>     argv_printf(&amp;argv, &quot;%s delete -inet6 %s/%d %s&quot;,=
 ROUTE_PATH, network, r6-&gt;netbits, gateway);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_=
check(&amp;argv, es, 0, &quot;ERROR: Solaris route delete -inet6 command fa=
iled&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rou=
te_exec(&amp;argv, es, &quot;ERROR: Solaris route delete -inet6 command fai=
led&quot;);</span><br><span> </span><br><span> #elif defined(TARGET_FREEBSD=
) || defined(TARGET_DRAGONFLY)</span><br><span> </span><br><span>@@ -2271,8=
 +2245,7 @@</span><br><span>         argv_printf_cat(&amp;argv, &quot;-ifac=
e %s&quot;, device);</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_chec=
k(&amp;argv, es, 0, &quot;ERROR: *BSD route delete -inet6 command failed&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    route_exec=
(&amp;argv, es, &quot;ERROR: *BSD route delete -inet6 command failed&quot;)=
;</span><br><span> </span><br><span> #elif defined(TARGET_DARWIN)</span><br=
><span> </span><br><span>@@ -2287,29 +2260,25 @@</span><br><span>         a=
rgv_printf_cat(&amp;argv, &quot;-iface %s&quot;, device);</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: MacOS=
 X route delete -inet6 command failed&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    route_exec(&amp;argv, es, &quot;ERROR: MacOS =
X route delete -inet6 command failed&quot;);</span><br><span> </span><br><s=
pan> #elif defined(TARGET_OPENBSD)</span><br><span> </span><br><span>     a=
rgv_printf(&amp;argv, &quot;%s delete -inet6 %s -prefixlen %d %s&quot;, ROU=
TE_PATH, network, r6-&gt;netbits,</span><br><span>                 gateway)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: OpenBSD r=
oute delete -inet6 command failed&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    route_exec(&amp;argv, es, &quot;ERROR: OpenBSD ro=
ute delete -inet6 command failed&quot;);</span><br><span> </span><br><span>=
 #elif defined(TARGET_NETBSD)</span><br><span> </span><br><span>     argv_p=
rintf(&amp;argv, &quot;%s delete -inet6 %s/%d %s&quot;, ROUTE_PATH, network=
, r6-&gt;netbits, gateway);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, es,=
 0, &quot;ERROR: NetBSD route delete -inet6 command failed&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    route_exec(&amp;argv, es=
, &quot;ERROR: NetBSD route delete -inet6 command failed&quot;);</span><br>=
<span> </span><br><span> #elif defined(TARGET_AIX)</span><br><span> </span>=
<br><span>     argv_printf(&amp;argv, &quot;%s delete -inet6 %s/%d %s&quot;=
, ROUTE_PATH, network, r6-&gt;netbits, gateway);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, =
es, 0, &quot;ERROR: AIX route delete command failed&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    route_exec(&amp;argv, es, &quot=
;ERROR: AIX route delete command failed&quot;);</span><br><span> </span><br=
><span> #elif defined(TARGET_ANDROID)</span><br><span>     msg(D_ROUTE_DEBU=
G, &quot;Deleting routes on Android is not possible/not &quot;</span><br><s=
pan>@@ -2323,8 +2292,7 @@</span><br><span>     /* ex: route delete /dev/net=
/ipro1000/0 inet6 :: gw beef::cafe prefixlen 64 */</span><br><span>     arg=
v_printf(&amp;argv, &quot;%s delete %s inet6 %s gw %s prefixlen %d&quot;, R=
OUTE_PATH, r6-&gt;iface, network,</span><br><span>                 gateway,=
 r6-&gt;netbits);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Haiku inet6=
 route delete command failed&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    route_exec(&amp;argv, es, &quot;ERROR: Haiku inet6 rou=
te delete command failed&quot;);</span><br><span> </span><br><span> #else  =
/* if defined(TARGET_LINUX) */</span><br><span>     msg(M_FATAL,</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2150?usp=3Demail">change 2150</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2150?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: Ie9b2723486214232aad33991b267dc0ff4d1c535 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2150 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>

</body></html>
--IzFC6J6oWgM=--


--===============1795386300066029304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1795386300066029304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1795386300066029304==--

