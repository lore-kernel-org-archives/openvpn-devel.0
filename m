Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB92F606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=h0MimfV6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G0wlDIDt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PqaW/KEu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Vo/C+mJG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UkpkAKwxg5QOjsWFtV1hSI0yWtrawv7VByP+xwwFV9c=; b=h0MimfV6kkRop/XdkVy6fpYfDz
	7BpkP6nvgArtZqkMwNU3GWStrZOXC/cver2/wetVL3BNLpVIZSquBUFCrlEr8ZNobPVKNqHN+A4Xy
	p6gJWIakN5N1nvix/Mda30E240I56AXV7BJN32e8h4NpzYkqqYJ8COSGr6DePB+xBvLk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUIAA-000000000Ca-2FjH;
	Fri, 20 Nov 2026 06:31:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUIA7-000000000CO-29Jt
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:31:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I0T1LLb8k3D5pkLVi7//Jiy/d39wBuZStrfVlFVSQcI=; b=G0wlDIDtzvxdAzuPdqNyEND5t9
 4T5J7BqA2ePtmVPwJ9cx6coov5jTeOwZOPBIgRXYyxnx2rV7pLRv9MiOK/QMMPJovTcC6fKHr8B2D
 +1wI3KN34NnhlAjl27xA4dlj58chQF6h3tS+o3lodTqMIoh74tDBPZFqAYrOO2XbHnIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I0T1LLb8k3D5pkLVi7//Jiy/d39wBuZStrfVlFVSQcI=; b=PqaW/KEuloZFcLh+A7pTtuj8Ua
 ZHjNvDSKnlKa1RmxdyDTKLUkA/jRKmvWLuc23f+YI7BG7x7hUaaZPpJdxrvATY+0GVwEY3CL+aqCB
 dX8GpRXsWbWPNI2D2OJjEj5DAcnTudaThXRzXvK31KAkJIcC2QIs/f/2SwYibhqjUQls=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUIA4-0000000047l-2XO6 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:31:55 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so3991855e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 22:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795156306; x=1795761106; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I0T1LLb8k3D5pkLVi7//Jiy/d39wBuZStrfVlFVSQcI=;
 b=Vo/C+mJGAXmu70mRVYLqrs6CoGIjVG/nEgNpJqR883gAHkwQmrcCEMdwEwiYmTU+3b
 0EaF6V1dDN4eBSeTsA5QQ5I0O3n1IY+ZfJsVEoiMld3GJjDabT9tCRyLYzp2Dkqi2v3y
 EpvjAn92RURGFlJkrVBJdZobbFbkEj0hGyCXMgDz4FCvZYOJ17f6Jk+99M0xiAUvHCur
 F9AtnTReHX5lSOxh7wb5xXmE694B+//nNUiQxHQKJCwl+QwCeuJmDjyZg+wMCyCWaMTF
 y3xQpM1Otfde8cLXHiWTjU85vM8tXGOs1Lvtcrj+6lqkx3MyNEqE6hO6HkjYQd98GLTN
 nkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795156306; x=1795761106;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I0T1LLb8k3D5pkLVi7//Jiy/d39wBuZStrfVlFVSQcI=;
 b=BqQlSPtIcAOmGBIo9oYb5sXkFEFCjo3GCx9kQNSgrwPIYjoJLXEhtgvFuHyLtUJRp3
 G2cRTRlM3DJg1HqixlXLdRC/hX7sag+Xf1IOWJCL4u+iqSLgoTUwLaCQVMCghzaLDw8j
 liCjkHP4SZi7bNk3ncJwvtDQTPDV+mNpKVzIjVrSRcBGDB5mBHoQTd3IrjqrhLKq2yEO
 mdyQbsJr12xhPXy0SDPcKw3BciuNhEC3NP4gz6Lk3Q3VxLKf2zfylC48A9vbjw+5zXuw
 bc0nC76oLZdkLk4dBiF2gG+rsC3CTr8DVYUfHIQdSy2IlTTIiRk7+U8ANGgkVkrz4Hwv
 frpw==
X-Gm-Message-State: APuU4Z8jBSMbhjLQrZfTzfFkktmQR7pTtZsu3F84CET3tHZKRJHznsw/
 EoCiZy91Ya+t5giT/KyY1PtwcJYgURX8E+SLuZLLR0sO0BinNKvrdVuEOW3SHspUwgTZncTOZt3
 eEO9eaCjCQRMzEbyPqWXXNcJrI9Vfh9Id8gGtFGXQ6rFRbvcFHj1JZSc+7+wvSg4irRZe
X-Gm-Gg: AYBFou1HSjPmOZogCYcslLJGY2HuW+3CcMYDMqUa2HJfQdWTpRrmWmTFSTAYFeIOGnq
 h/cZ62c9WVKeRmvz5Nfc8XMUlaC+f16h2atU++m4qRcVuDkhv7D7+caZdPNy58k3RoRSJWIc7b7
 vx6r17IyK9SaETkgH9P24yNqV0sCEfGJveL2P2eAhmjlGOGkGGuax5uPDc/mufaJ3wMNSNuw+Rd
 6PVMRVTEX5GQoXwhVfeS84qMOoCzkj4Bkwo8E6z5oxQ7WcN7BXvNpxgqH+soyTD6t691P+mD2mG
 yHyxDGXwKptvFXwUk2pJgJNJ4RlS6jeqJYyseZyHmymaxvtLE4RBKV8o9yi5LCO5AAM5WrWKKHn
 Rb/tZmhUBnasSOrRnMoVRgruizfcEMD8gegZQBImeeoJrWfkVIVBuK4CjPW9Z/llG/fKXLGwZP7
 zheNINqdsJw8XFGLNm9hADfHXP2xgXhKdryYYDL8bBQYA8ydBrsS3hrlRodzSlnkolXKg3Y68JZ
 uE7ekIsTTefZP0KparGr6rJKsWxP0/0wh9AJG0ajs7ye6do4DN3vHD0UWi9dlKOIsz7Z2PSZzu8
 q06vM2XNfaOCsXFvDPAA94BFbGtM2WrkFxOZ6JNPRN3i1h4M7rHR/LKVlqzjuQIPQfFFjao5XXF
 DY0vhh92alX5GHWPXpkpMnE7ndb3Ti2PwcDlBy2YyjxnQ80nhroHbeVMSq5YFxe+/IKvRGZRt8V
 +awv00rxgKYdWv+Qk=
X-Received: by 2002:a05:600c:820d:b0:4bb:5de1:e912 with SMTP id
 5b1f17b1804b1-4bb887c3ae7mr41535825e9.1.1795156305642; 
 Thu, 19 Nov 2026 22:31:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895faa2csm29040785e9.1.2026.11.19.22.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 22:31:45 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 06:31:41 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885
X-Gerrit-Change-Number: 2154
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2154?usp=email>
X-Gerrit-Commit: 217bf69bddb093c8126a65d3da5fceb48177a3a1
In-Reply-To: <gerrit.1794074511000.I601454a511c9aac4f37d8629b1692266cdbd6885@gerrit.openvpn.net>
References: <gerrit.1794074511000.I601454a511c9aac4f37d8629b1692266cdbd6885@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkk2MDE0NTRhNTExYzlhYWM0ZjM3ZDg2MjliMTY5MjI2NmNkYmQ2ODg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b57c10b167258a4dba1d14602f3339045b7d90e7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUIA4-0000000047l-2XO6
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: use the net_
 API for routes on FreeBSD and DragonFly
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5740011810627937795=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5740011810627937795==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q0MisFcB1wg="; charset=UTF-8

--Q0MisFcB1wg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, R=C4=83zv=
an Cojocaru=2E

Hello Arne Schwabe, Gert Doering, 

I'd like you to reexami=
ne a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2154?usp=3Demail

to look at the new patch set (#5)=2E

The following appr=
ovals got outdated and were removed:
Code-Review-1 by Gert Doering


Change=
 subject: route: use the net_ API for routes on FreeBSD and DragonFly
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: use the n=
et_ API for routes on FreeBSD and DragonFly

Add and delete IPv4 and IPv6 r=
outes through net_route_v4/v6_add/del()
on FreeBSD and DragonFly, as on Lin=
ux, instead of running route(8)
from route=2Ec=2E Build networking_freebsd=
=2Ec for DragonFly as well; -fib
is only passed on FreeBSD, where --route-t=
able is now supported=2E

A non-contiguous IPv4 netmask now gets an error i=
nstead of an invalid
prefix length=2E networking_freebsd=2Ec logs route com=
mands at D_ROUTE, as
route=2Ec did=2E The shared error messages lose their =
"Linux" prefix=2E

Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885
Sig=
ned-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M doc/man-sections/=
vpn-network-options=2Erst
M src/openvpn/networking=2Eh
M src/openvpn/networ=
king_freebsd=2Ec
M src/openvpn/options=2Ec
M src/openvpn/route=2Ec
5 files =
changed, 71 insertions(+), 136 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/54/2154/5

diff --git a/doc/man-secti=
ons/vpn-network-options=2Erst b/doc/man-sections/vpn-network-options=2Erst
=
index 960c6ad=2E=2Ef282982 100644
--- a/doc/man-sections/vpn-network-option=
s=2Erst
+++ b/doc/man-sections/vpn-network-options=2Erst
@@ -399,7 +399,10 =
@@
   table of the operating system, but with this option,
   a user define=
d routing table can be used instead=2E
 
-  (Supported on Linux only, on ot=
her platforms this is a no-op)=2E
+  On FreeBSD, the table id is the FIB nu=
mber=2E Without this option, routes
+  go to the FIB OpenVPN runs in (see :=
code:`setfib(1)`)=2E
+
+  (Supported on Linux and FreeBSD only, on other pl=
atforms this is a no-op)=2E
 
 --route args
   Add route to routing table a=
fter connection is established=2E Multiple
diff --git a/src/openvpn/network=
ing=2Eh b/src/openvpn/networking=2Eh
index 1763e64=2E=2Ecbb10ed 100644
--- =
a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@@ -30,7 +30,=
7 @@
 #include "networking_sitnl=2Eh"
 #elif ENABLE_IPROUTE
 #include "netw=
orking_iproute2=2Eh"
-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_F=
REEBSD) || defined(TARGET_DRAGONFLY)
 typedef void *openvpn_net_ctx_t;
 typ=
edef char openvpn_net_iface_t;
 #else  /* ifdef ENABLE_SITNL */
@@ -236,7 +=
236,8 @@
 
 #endif /* ENABLE_SITNL || ENABLE_IPROUTE */
 
-#if defined(ENAB=
LE_SITNL) || defined(ENABLE_IPROUTE) || defined(TARGET_FREEBSD)
+#if define=
d(ENABLE_SITNL) || defined(ENABLE_IPROUTE) || defined(TARGET_FREEBSD) \
+  =
  || defined(TARGET_DRAGONFLY)
 /**
  * Add a route for an IPv4 address/net=
work
  *
@@ -305,7 +306,7 @@
                      const struct in6_addr *g=
w, const openvpn_net_iface_t *iface, int table,
                      int m=
etric);
 
-#endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD */
+#=
endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD || TARGET_DRAGONF=
LY */
 
 #if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)
 
diff --git =
a/src/openvpn/networking_freebsd=2Ec b/src/openvpn/networking_freebsd=2Ec
i=
ndex 141f4bd=2E=2E1f5ff3a 100644
--- a/src/openvpn/networking_freebsd=2Ec
+=
++ b/src/openvpn/networking_freebsd=2Ec
@@ -6,7 +6,7 @@
 #include "run_comm=
and=2Eh"
 #include "networking=2Eh"
 
-#if defined(TARGET_FREEBSD)
+#if def=
ined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 
 static int
 net_route_=
v4(const char *op, const in_addr_t *dst, int prefixlen, const in_addr_t *gw=
,
@@ -35,14 +35,16 @@
     {
         argv_printf_cat(&argv, "-iface %s", i=
face);
     }
+#if defined(TARGET_FREEBSD) /* DragonFly has no multiple FIB=
 support */
     /* without -fib, route(8) uses the FIB of the process */
 =
    if (table >=3D 0)
     {
         argv_printf_cat(&argv, "-fib %d", tab=
le);
     }
+#endif
 
-    argv_msg(M_INFO, &argv);
-    bool status =3D op=
envpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD route command failed");
=
+    argv_msg(D_ROUTE, &argv);
+    bool status =3D openvpn_execve_check(&a=
rgv, NULL, 0, "ERROR: route command failed");
 
     argv_free(&argv);
 
@@=
 -77,13 +79,15 @@
     {
         argv_printf_cat(&argv, "-iface %s", iface=
);
     }
+#if defined(TARGET_FREEBSD) /* DragonFly has no multiple FIB sup=
port */
     if (table >=3D 0)
     {
         argv_printf_cat(&argv, "-fib=
 %d", table);
     }
+#endif
 
-    argv_msg(M_INFO, &argv);
-    bool stat=
us =3D openvpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD route command f=
ailed");
+    argv_msg(D_ROUTE, &argv);
+    bool status =3D openvpn_execve=
_check(&argv, NULL, 0, "ERROR: route command failed");
 
     argv_free(&ar=
gv);
 
@@ -118,4 +122,4 @@
     return net_route_v6("delete", dst, prefixle=
n, gw, iface, table, metric);
 }
 
-#endif /* if defined(TARGET_FREEBSD) */=

+#endif /* if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) */
diff=
 --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 01d5edb=2E=
=2E388d38c5 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -226,7 +226,7 @@
     "                    pass --ifconfig parms by=
 environment to scripts=2E\n"
     "--ifconfig-nowarn : Don't warn if the -=
-ifconfig option on this side of the\n"
     "                    connectio=
n doesn't match the remote side=2E\n"
-#ifdef TARGET_LINUX
+#if defined(TAR=
GET_LINUX) || defined(TARGET_FREEBSD)
     "--route-table table_id : Specif=
y a custom routing table for use with --route(-ipv6)=2E\n"
     "          =
                 If not specified, the id of the default routing table will=
 be used=2E\n"
 #endif
@@ -5293,8 +5293,8 @@
     }
     else if (streq(p[0=
], "route-table") && p[1] && !p[2])
     {
-#ifndef ENABLE_SITNL
-        m=
sg(M_WARN, "NOTE: --route-table is supported only on Linux when SITNL is bu=
ilt-in");
+#if !defined(ENABLE_SITNL) && !defined(TARGET_FREEBSD)
+        =
msg(M_WARN, "NOTE: --route-table is supported only on FreeBSD, and on Linux=
 when SITNL is built-in");
 #endif
         VERIFY_PERMISSION(OPT_P_ROUTE_T=
ABLE);
         options->route_default_table_id =3D positive_atoi(p[1], msg=
level);
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 8c=
493ee=2E=2E83c7ebf 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/rou=
te=2Ec
@@ -103,6 +103,11 @@
 #define RTA_SUCCESS 1 /* route addition succee=
ded */
 #define RTA_EEXIST  2 /* route not added as it already exists */
 
=
+/* Platforms that add and delete routes through the net_ API (networking=
=2Eh) */
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(T=
ARGET_DRAGONFLY)
+#define ROUTE_NET_API
+#endif
+
 #ifndef TARGET_ANDROID
 =
static bool
 add_bypass_address(struct route_bypass *rb, const in_addr_t a)=

@@ -1433,7 +1438,7 @@
 
 /* Return true if the "on-link" form of the route=
 should be used=2E  This is when the gateway for
  * a route is specified a=
s an interface rather than an address=2E */
-#if defined(TARGET_LINUX) || d=
efined(_WIN32) || defined(TARGET_DARWIN)
+#if defined(ROUTE_NET_API) || def=
ined(_WIN32) || defined(TARGET_DARWIN)
 static inline bool
 is_on_link(cons=
t struct route_ipv4 *r, const unsigned int flags,
            const struct =
route_gateway_info *rgi)
@@ -1459,7 +1464,7 @@
     struct argv argv =3D ar=
gv_new();
     struct gc_arena gc =3D gc_new();
 
-#if !defined(TARGET_LINU=
X)
+#if !defined(ROUTE_NET_API)
     const char *network =3D print_in_addr_=
t(r->network, 0, &gc);
 #if !defined(TARGET_AIX)
     const char *netmask =
=3D print_in_addr_t(r->netmask, 0, &gc);
@@ -1468,7 +1473,7 @@
 #endif
 
 
=
-#if defined(TARGET_LINUX)
+#if defined(ROUTE_NET_API)
     const char *ifa=
ce =3D NULL;
     int metric =3D -1;
 
@@ -1482,20 +1487,29 @@
         met=
ric =3D r->metric;
     }
 
-
-    status =3D RTA_SUCCESS;
-    int ret =3D=
 net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->netmask), &r->ga=
teway,
-                               iface, r->table_id, metric);
-    if=
 (ret =3D=3D -EEXIST)
+    const int netbits =3D netmask_to_netbits2(r->net=
mask);
+    if (netbits < 0)
     {
-        msg(D_ROUTE, "NOTE: Linux rout=
e add command failed because route exists");
-        status =3D RTA_EEXIST=
;
-    }
-    else if (ret < 0)
-    {
-        msg(M_WARN, "ERROR: Linux r=
oute add command failed");
+        msg(M_WARN, "ERROR: cannot add route wi=
th non-contiguous netmask %s",
+            print_in_addr_t(r->netmask, 0, =
&gc));
         status =3D RTA_ERROR;
     }
+    else
+    {
+        stat=
us =3D RTA_SUCCESS;
+        int ret =3D net_route_v4_add(ctx, &r->network,=
 netbits, &r->gateway, iface,
+                                   r->table_=
id, metric);
+        if (ret =3D=3D -EEXIST)
+        {
+            msg(D=
_ROUTE, "NOTE: route add command failed because route exists");
+          =
  status =3D RTA_EEXIST;
+        }
+        else if (ret < 0)
+        {
+=
            msg(M_WARN, "ERROR: route add command failed");
+            st=
atus =3D RTA_ERROR;
+        }
+    }
 
 #elif defined(TARGET_ANDROID)
    =
 char out[128];
@@ -1597,44 +1611,6 @@
     bool ret =3D openvpn_execve_che=
ck(&argv, es, 0, "ERROR: Solaris route add command failed");
     status =
=3D ret ? RTA_SUCCESS : RTA_ERROR;
 
-#elif defined(TARGET_FREEBSD)
-
-    =
argv_printf(&argv, "%s add", ROUTE_PATH);
-
-#if 0
-    if (r->flags & RT_M=
ETRIC_DEFINED)
-    {
-        argv_printf_cat(&argv, "-rtt %d", r->metric)=
;
-    }
-#endif
-
-    argv_printf_cat(&argv, "-net %s %s %s", network, ga=
teway, netmask);
-
-    /* FIXME -- add on-link support for FreeBSD */
-
- =
   argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&argv, =
es, 0, "ERROR: FreeBSD route add command failed");
-    status =3D ret ? RT=
A_SUCCESS : RTA_ERROR;
-
-#elif defined(TARGET_DRAGONFLY)
-
-    argv_print=
f(&argv, "%s add", ROUTE_PATH);
-
-#if 0
-    if (r->flags & RT_METRIC_DEFI=
NED)
-    {
-        argv_printf_cat(&argv, "-rtt %d", r->metric);
-    }
-=
#endif
-
-    argv_printf_cat(&argv, "-net %s %s %s", network, gateway, net=
mask);
-
-    /* FIXME -- add on-link support for Dragonfly */
-
-    argv_=
msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&argv, es, 0, "=
ERROR: DragonFly route add command failed");
-    status =3D ret ? RTA_SUCC=
ESS : RTA_ERROR;
-
 #elif defined(TARGET_DARWIN)
 
     argv_printf(&argv, =
"%s add", ROUTE_PATH);
@@ -1700,10 +1676,10 @@
     bool ret =3D openvpn_ex=
ecve_check(&argv, es, 0, "ERROR: Haiku inet route add command failed");
   =
  status =3D ret ? RTA_SUCCESS : RTA_ERROR;
 
-#else  /* if defined(TARGET_=
LINUX) */
+#else  /* if defined(ROUTE_NET_API) */
     msg(M_FATAL,
       =
  "Sorry, but I don't know how to do 'route' commands on this operating sys=
tem=2E  Try putting your routes in a --route-up script");
-#endif /* if def=
ined(TARGET_LINUX) */
+#endif /* if defined(ROUTE_NET_API) */
 
     if (st=
atus =3D=3D RTA_SUCCESS)
     {
@@ -1777,8 +1753,7 @@
     const char *netw=
ork =3D print_in6_addr(r6->network, 0, &gc);
     const char *gateway =3D p=
rint_in6_addr(r6->gateway, 0, &gc);
 
-#if defined(TARGET_DARWIN) || define=
d(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) \
-    || defined(TARGET_OPE=
NBSD) || defined(TARGET_NETBSD)
+#if defined(TARGET_DARWIN) || defined(TARG=
ET_OPENBSD) || defined(TARGET_NETBSD)
 
     /* the BSD platforms cannot sp=
ecify gateway and interface independently,
      * but for link-local desti=
nations, we MUST specify the interface, so
@@ -1830,7 +1805,7 @@
         g=
oto done;
     }
 
-#if defined(TARGET_LINUX)
+#if defined(ROUTE_NET_API)
 =
    int metric =3D -1;
     if ((r6->flags & RT_METRIC_DEFINED) && (r6->met=
ric > 0))
     {
@@ -1842,12 +1817,12 @@
                                de=
vice, r6->table_id, metric);
     if (ret =3D=3D -EEXIST)
     {
-        m=
sg(D_ROUTE, "NOTE: Linux route add command failed because route exists");
+=
        msg(D_ROUTE, "NOTE: route add command failed because route exists")=
;
         status =3D RTA_EEXIST;
     }
     else if (ret < 0)
     {
-   =
     msg(M_WARN, "ERROR: Linux route add command failed");
+        msg(M_W=
ARN, "ERROR: route add command failed");
         status =3D RTA_ERROR;
   =
  }
 
@@ -1893,23 +1868,6 @@
     bool ret =3D openvpn_execve_check(&argv, =
es, 0, "ERROR: Solaris route add -inet6 command failed");
     status =3D r=
et ? RTA_SUCCESS : RTA_ERROR;
 
-#elif defined(TARGET_FREEBSD) || defined(T=
ARGET_DRAGONFLY)
-
-    argv_printf(&argv, "%s add -inet6 %s/%d", ROUTE_PAT=
H, network, r6->netbits);
-
-    if (gateway_needed)
-    {
-        argv_p=
rintf_cat(&argv, "%s", gateway);
-    }
-    else
-    {
-        argv_prin=
tf_cat(&argv, "-iface %s", device);
-    }
-
-    argv_msg(D_ROUTE, &argv);=

-    bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: *BSD route ad=
d -inet6 command failed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
-=

 #elif defined(TARGET_DARWIN)
 
     argv_printf(&argv, "%s add -inet6 %s =
-prefixlen %d", ROUTE_PATH, network, r6->netbits);
@@ -1960,10 +1918,10 @@
=
     bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet6 ro=
ute add command failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;
 
=
-#else  /* if defined(TARGET_LINUX) */
+#else  /* if defined(ROUTE_NET_API)=
 */
     msg(M_FATAL,
         "Sorry, but I don't know how to do 'route ip=
v6' commands on this operating system=2E  Try putting your routes in a --ro=
ute-up script");
-#endif /* if defined(TARGET_LINUX) */
+#endif /* if defin=
ed(ROUTE_NET_API) */
 
 done:
     if (status =3D=3D RTA_SUCCESS)
@@ -1986,=
13 +1944,13 @@
 delete_route(struct route_ipv4 *r, const struct tuntap *tt,=
 unsigned int flags,
              const struct route_gateway_info *rgi, co=
nst struct env_set *es, openvpn_net_ctx_t *ctx)
 {
-#if !defined(TARGET_LIN=
UX)
+#if !defined(ROUTE_NET_API)
     const char *network;
 #if !defined(TA=
RGET_AIX)
     const char *netmask;
 #endif
     const char *gateway;
-#els=
e /* if !defined(TARGET_LINUX) */
+#else /* if !defined(ROUTE_NET_API) */
 =
    int metric;
 #endif
 
@@ -2004,7 +1962,7 @@
     struct gc_arena gc =3D=
 gc_new();
     struct argv argv =3D argv_new();
 
-#if !defined(TARGET_LIN=
UX)
+#if !defined(ROUTE_NET_API)
     network =3D print_in_addr_t(r->networ=
k, 0, &gc);
 #if !defined(TARGET_AIX)
     netmask =3D print_in_addr_t(r->n=
etmask, 0, &gc);
@@ -2013,7 +1971,7 @@
 #endif
 
 
-#if defined(TARGET_LINU=
X)
+#if defined(ROUTE_NET_API)
     metric =3D -1;
     if (r->flags & RT_M=
ETRIC_DEFINED)
     {
@@ -2024,7 +1982,7 @@
                          r->ta=
ble_id, metric)
         < 0)
     {
-        msg(M_WARN, "ERROR: Linux rou=
te delete command failed");
+        msg(M_WARN, "ERROR: route delete comma=
nd failed");
     }
 #elif defined(_WIN32)
 
@@ -2074,20 +2032,6 @@
     ar=
gv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: Sol=
aris route delete command failed");
 
-#elif defined(TARGET_FREEBSD)
-
-   =
 argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network, gateway=
, netmask);
-
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&arg=
v, es, 0, "ERROR: FreeBSD route delete command failed");
-
-#elif defined(T=
ARGET_DRAGONFLY)
-
-    argv_printf(&argv, "%s delete -net %s %s %s", ROUTE=
_PATH, network, gateway, netmask);
-
-    argv_msg(D_ROUTE, &argv);
-    op=
envpn_execve_check(&argv, es, 0, "ERROR: DragonFly route delete command fai=
led");
-
 #elif defined(TARGET_DARWIN)
 
     if (is_on_link(r, flags, rgi)=
)
@@ -2135,10 +2079,10 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execv=
e_check(&argv, es, 0, "ERROR: Haiku inet route delete command failed");
 
-=
#else  /* if defined(TARGET_LINUX) */
+#else  /* if defined(ROUTE_NET_API) =
*/
     msg(M_FATAL,
         "Sorry, but I don't know how to do 'route' co=
mmands on this operating system=2E  Try putting your routes in a --route-up=
 script");
-#endif /* if defined(TARGET_LINUX) */
+#endif /* if defined(ROU=
TE_NET_API) */
 
     r->flags &=3D ~RT_ADDED;
     argv_free(&argv);
@@ -2=
159,7 +2103,7 @@
     }
 
 #if !defined(_WIN32)
-#if !defined(TARGET_LINUX)=

+#if !defined(ROUTE_NET_API)
     const char *gateway;
 #endif
 #if !defin=
ed(TARGET_SOLARIS)
@@ -2186,12 +2130,11 @@
     struct argv argv =3D argv_n=
ew();
 
     network =3D print_in6_addr(r6->network, 0, &gc);
-#if !defined=
(TARGET_LINUX) && !defined(_WIN32)
+#if !defined(ROUTE_NET_API) && !defined=
(_WIN32)
     gateway =3D print_in6_addr(r6->gateway, 0, &gc);
 #endif
 
-#=
if defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) || defined(TARGET_DRAG=
ONFLY) \
-    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+#if def=
ined(TARGET_DARWIN) || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
=
     /* the BSD platforms cannot specify gateway and interface independentl=
y,
      * but for link-local destinations, we MUST specify the interface, =
so
@@ -2209,7 +2152,7 @@
 
     msg(D_ROUTE, "delete_route_ipv6(%s/%u)", ne=
twork, r6->netbits);
 
-#if defined(TARGET_LINUX)
+#if defined(ROUTE_NET_AP=
I)
     int metric =3D -1;
     if ((r6->flags & RT_METRIC_DEFINED) && (r6-=
>metric > 0))
     {
@@ -2220,7 +2163,7 @@
                          device=
, r6->table_id, metric)
         < 0)
     {
-        msg(M_WARN, "ERROR: L=
inux route v6 delete command failed");
+        msg(M_WARN, "ERROR: route v=
6 delete command failed");
     }
 
 #elif defined(_WIN32)
@@ -2242,22 +218=
5,6 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, =
0, "ERROR: Solaris route delete -inet6 command failed");
 
-#elif defined(T=
ARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
-
-    argv_printf(&argv, "%s d=
elete -inet6 %s/%d", ROUTE_PATH, network, r6->netbits);
-
-    if (gateway_=
needed)
-    {
-        argv_printf_cat(&argv, "%s", gateway);
-    }
-    =
else
-    {
-        argv_printf_cat(&argv, "-iface %s", device);
-    }
-
=
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERR=
OR: *BSD route delete -inet6 command failed");
-
 #elif defined(TARGET_DARW=
IN)
 
     argv_printf(&argv, "%s delete -inet6 %s -prefixlen %d", ROUTE_PA=
TH, network, r6->netbits);
@@ -2310,10 +2237,10 @@
     argv_msg(D_ROUTE, &=
argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet6 route de=
lete command failed");
 
-#else  /* if defined(TARGET_LINUX) */
+#else  /* =
if defined(ROUTE_NET_API) */
     msg(M_FATAL,
         "Sorry, but I don't=
 know how to do 'route ipv6' commands on this operating system=2E  Try putt=
ing your routes in a --route-down script");
-#endif /* if defined(TARGET_LI=
NUX) */
+#endif /* if defined(ROUTE_NET_API) */
 
     argv_free(&argv);
  =
   gc_free(&gc);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2154?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I601454a511c9aac4f37d8629b1692266cdbd6885
Gerrit-Change-Number: 2154
Gerr=
it-PatchSet: 5
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>

--Q0MisFcB1wg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, R=C4=83zvan Cojocaru=2E <=
/p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #5</strong> to this =
change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review-1 by Gert Doering</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">route: use th=
e net_ API for routes on FreeBSD and DragonFly<br><br>Add and delete IPv4 a=
nd IPv6 routes through net_route_v4/v6_add/del()<br>on FreeBSD and DragonFl=
y, as on Linux, instead of running route(8)<br>from route=2Ec=2E Build netw=
orking_freebsd=2Ec for DragonFly as well; -fib<br>is only passed on FreeBSD=
, where --route-table is now supported=2E<br><br>A non-contiguous IPv4 netm=
ask now gets an error instead of an invalid<br>prefix length=2E networking_=
freebsd=2Ec logs route commands at D_ROUTE, as<br>route=2Ec did=2E The shar=
ed error messages lose their &quot;Linux&quot; prefix=2E<br><br>Change-Id: =
I601454a511c9aac4f37d8629b1692266cdbd6885<br>Signed-off-by: Razvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M doc/man-sections/vpn-network-opt=
ions=2Erst<br>M src/openvpn/networking=2Eh<br>M src/openvpn/networking_free=
bsd=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/route=2Ec<br>5 files =
changed, 71 insertions(+), 136 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/54/2154/5</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/doc/man-sections/vpn-network-options=2Erst b/doc/man-secti=
ons/vpn-network-options=2Erst</span><br><span>index 960c6ad=2E=2Ef282982 10=
0644</span><br><span>--- a/doc/man-sections/vpn-network-options=2Erst</span=
><br><span>+++ b/doc/man-sections/vpn-network-options=2Erst</span><br><span=
>@@ -399,7 +399,10 @@</span><br><span>   table of the operating system, but=
 with this option,</span><br><span>   a user defined routing table can be u=
sed instead=2E</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  (Supported on Linux only, on other platforms this is a no-op)=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  On FreeBSD, th=
e table id is the FIB number=2E Without this option, routes</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  go to the FIB OpenVPN runs in (se=
e :code:`setfib(1)`)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (Supported on=
 Linux and FreeBSD only, on other platforms this is a no-op)=2E</span><br><=
span> </span><br><span> --route args</span><br><span>   Add route to routin=
g table after connection is established=2E Multiple</span><br><span>diff --=
git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh</span><br><sp=
an>index 1763e64=2E=2Ecbb10ed 100644</span><br><span>--- a/src/openvpn/netw=
orking=2Eh</span><br><span>+++ b/src/openvpn/networking=2Eh</span><br><span=
>@@ -30,7 +30,7 @@</span><br><span> #include &quot;networking_sitnl=2Eh&quo=
t;</span><br><span> #elif ENABLE_IPROUTE</span><br><span> #include &quot;ne=
tworking_iproute2=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#elif defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)<=
/span><br><span> typedef void *openvpn_net_ctx_t;</span><br><span> typedef =
char openvpn_net_iface_t;</span><br><span> #else  /* ifdef ENABLE_SITNL */<=
/span><br><span>@@ -236,7 +236,8 @@</span><br><span> </span><br><span> #end=
if /* ENABLE_SITNL || ENABLE_IPROUTE */</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_SITNL) || defined(EN=
ABLE_IPROUTE) || defined(TARGET_FREEBSD)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE) |=
| defined(TARGET_FREEBSD) \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    || defined(TARGET_DRAGONFLY)</span><br><span> /**</span><br><sp=
an>  * Add a route for an IPv4 address/network</span><br><span>  *</span><b=
r><span>@@ -305,7 +306,7 @@</span><br><span>                      const str=
uct in6_addr *gw, const openvpn_net_iface_t *iface, int table,</span><br><s=
pan>                      int metric);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_SITNL || ENABLE_IPROUTE=
 || TARGET_FREEBSD */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD || TARGET_DRAG=
ONFLY */</span><br><span> </span><br><span> #if defined(ENABLE_SITNL) || de=
fined(ENABLE_IPROUTE)</span><br><span> </span><br><span>diff --git a/src/op=
envpn/networking_freebsd=2Ec b/src/openvpn/networking_freebsd=2Ec</span><br=
><span>index 141f4bd=2E=2E1f5ff3a 100644</span><br><span>--- a/src/openvpn/=
networking_freebsd=2Ec</span><br><span>+++ b/src/openvpn/networking_freebsd=
=2Ec</span><br><span>@@ -6,7 +6,7 @@</span><br><span> #include &quot;run_co=
mmand=2Eh&quot;</span><br><span> #include &quot;networking=2Eh&quot;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><span> </s=
pan><br><span> static int</span><br><span> net_route_v4(const char *op, con=
st in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span>@@ -=
35,14 +35,16 @@</span><br><span>     {</span><br><span>         argv_printf=
_cat(&amp;argv, &quot;-iface %s&quot;, iface);</span><br><span>     }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_FREEBS=
D) /* DragonFly has no multiple FIB support */</span><br><span>     /* with=
out -fib, route(8) uses the FIB of the process */</span><br><span>     if (=
table &gt;=3D 0)</span><br><span>     {</span><br><span>         argv_print=
f_cat(&amp;argv, &quot;-fib %d&quot;, table);</span><br><span>     }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(M_INFO, &a=
mp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool sta=
tus =3D openvpn_execve_check(&amp;argv, NULL, 0, &quot;ERROR: FreeBSD route=
 command failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool status =3D openvpn_execve_check(&amp;argv, NULL,=
 0, &quot;ERROR: route command failed&quot;);</span><br><span> </span><br><=
span>     argv_free(&amp;argv);</span><br><span> </span><br><span>@@ -77,13=
 +79,15 @@</span><br><span>     {</span><br><span>         argv_printf_cat(=
&amp;argv, &quot;-iface %s&quot;, iface);</span><br><span>     }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_FREEBSD) /*=
 DragonFly has no multiple FIB support */</span><br><span>     if (table &g=
t;=3D 0)</span><br><span>     {</span><br><span>         argv_printf_cat(&a=
mp;argv, &quot;-fib %d&quot;, table);</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(M_INFO, &amp;argv)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool status =3D =
openvpn_execve_check(&amp;argv, NULL, 0, &quot;ERROR: FreeBSD route command=
 failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    bool status =3D openvpn_execve_check(&amp;argv, NULL, 0, &quo=
t;ERROR: route command failed&quot;);</span><br><span> </span><br><span>   =
  argv_free(&amp;argv);</span><br><span> </span><br><span>@@ -118,4 +122,4 =
@@</span><br><span>     return net_route_v6(&quot;delete&quot;, dst, prefix=
len, gw, iface, table, metric);</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(TARGET_=
FREEBSD) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /=
* if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) */</span><br><spa=
n>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br>=
<span>index 01d5edb=2E=2E388d38c5 100644</span><br><span>--- a/src/openvpn/=
options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@=
@ -226,7 +226,7 @@</span><br><span>     &quot;                    pass --if=
config parms by environment to scripts=2E\n&quot;</span><br><span>     &quo=
t;--ifconfig-nowarn : Don&#39;t warn if the --ifconfig option on this side =
of the\n&quot;</span><br><span>     &quot;                    connection do=
esn&#39;t match the remote side=2E\n&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#ifdef TARGET_LINUX</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</=
span><br><span>     &quot;--route-table table_id : Specify a custom routing=
 table for use with --route(-ipv6)=2E\n&quot;</span><br><span>     &quot;  =
                         If not specified, the id of the default routing ta=
ble will be used=2E\n&quot;</span><br><span> #endif</span><br><span>@@ -529=
3,8 +5293,8 @@</span><br><span>     }</span><br><span>     else if (streq(p=
[0], &quot;route-table&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef EN=
ABLE_SITNL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(M_WARN, &quot;NOTE: --route-table is supported only on Linux when SITNL is=
 built-in&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f !defined(ENABLE_SITNL) &amp;&amp; !defined(TARGET_FREEBSD)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;NOTE: --=
route-table is supported only on FreeBSD, and on Linux when SITNL is built-=
in&quot;);</span><br><span> #endif</span><br><span>         VERIFY_PERMISSI=
ON(OPT_P_ROUTE_TABLE);</span><br><span>         options-&gt;route_default_t=
able_id =3D positive_atoi(p[1], msglevel);</span><br><span>diff --git a/src=
/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 8c493ee=2E=
=2E83c7ebf 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><sp=
an>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -103,6 +103,11 @@</span><=
br><span> #define RTA_SUCCESS 1 /* route addition succeeded */</span><br><s=
pan> #define RTA_EEXIST  2 /* route not added as it already exists */</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Plat=
forms that add and delete routes through the net_ API (networking=2Eh) */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LI=
NUX) || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define ROUTE_NET_API</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> #ifndef TARGET_ANDROID</spa=
n><br><span> static bool</span><br><span> add_bypass_address(struct route_b=
ypass *rb, const in_addr_t a)</span><br><span>@@ -1433,7 +1438,7 @@</span><=
br><span> </span><br><span> /* Return true if the &quot;on-link&quot; form =
of the route should be used=2E  This is when the gateway for</span><br><spa=
n>  * a route is specified as an interface rather than an address=2E */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)=
 || defined(_WIN32) || defined(TARGET_DARWIN)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(ROUTE_NET_API) || defined(_WIN32) || =
defined(TARGET_DARWIN)</span><br><span> static inline bool</span><br><span>=
 is_on_link(const struct route_ipv4 *r, const unsigned int flags,</span><br=
><span>            const struct route_gateway_info *rgi)</span><br><span>@@=
 -1459,7 +1464,7 @@</span><br><span>     struct argv argv =3D argv_new();</=
span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ROUTE_=
NET_API)</span><br><span>     const char *network =3D print_in_addr_t(r-&gt=
;network, 0, &amp;gc);</span><br><span> #if !defined(TARGET_AIX)</span><br>=
<span>     const char *netmask =3D print_in_addr_t(r-&gt;netmask, 0, &amp;g=
c);</span><br><span>@@ -1468,7 +1473,7 @@</span><br><span> #endif</span><br=
><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(ROUTE_NET_API)</span><br><span>     const char *ifac=
e =3D NULL;</span><br><span>     int metric =3D -1;</span><br><span> </span=
><br><span>@@ -1482,20 +1487,29 @@</span><br><span>         metric =3D r-&g=
t;metric;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    status =3D RTA_SUCCESS;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int ret =3D net_route_v4_add(ctx, &amp;r-&gt;network, net=
mask_to_netbits2(r-&gt;netmask), &amp;r-&gt;gateway,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                               iface, r-&gt=
;table_id, metric);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (ret =3D=3D -EEXIST)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const int netbits =3D netmask_to_netbits2(r-&gt;netmask);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (netbits &lt; 0)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      msg(D_ROUTE, &quot;NOTE: Linux route add command failed because route=
 exists&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  status =3D RTA_EEXIST;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (=
ret &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;=
ERROR: Linux route add command failed&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;ERROR: cannot add route=
 with non-contiguous netmask %s&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            print_in_addr_t(r-&gt;netmask, 0, &amp;gc));=
</span><br><span>         status =3D RTA_ERROR;</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        status =3D RTA_SUCCESS;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        int ret =3D net_route_v4_add(=
ctx, &amp;r-&gt;network, netbits, &amp;r-&gt;gateway, iface,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
 r-&gt;table_id, metric);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (ret =3D=3D -EEXIST)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(D_ROUTE, &quot;NOTE: route add command failed becau=
se route exists&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            status =3D RTA_EEXIST;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else if (ret &lt; 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_WARN, &quot;ERROR: route add command failed&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            statu=
s =3D RTA_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span> </span><br><span> #elif defined(TARGET_ANDROID)</span><br><span> =
    char out[128];</span><br><span>@@ -1597,44 +1611,6 @@</span><br><span> =
    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Solari=
s route add command failed&quot;);</span><br><span>     status =3D ret ? RT=
A_SUCCESS : RTA_ERROR;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    argv_printf(&amp;argv, &quot;%s add&quot;, ROUTE_PATH);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;-rtt %d&quot;, r-&=
gt;metric);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, netw=
ork, gateway, netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- add=
 on-link support for FreeBSD */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_ms=
g(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: FreeB=
SD route add command failed&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#elif defined(TARGET_DRAGONFLY)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    argv_printf(&amp;argv, &quot;%s add&quot;, ROUTE_PATH);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;-rtt %d&quot;, r-&=
gt;metric);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, netw=
ork, gateway, netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- add=
 on-link support for Dragonfly */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_=
msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Dra=
gonFly route add command failed&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif defined(T=
ARGET_DARWIN)</span><br><span> </span><br><span>     argv_printf(&amp;argv,=
 &quot;%s add&quot;, ROUTE_PATH);</span><br><span>@@ -1700,10 +1676,10 @@</=
span><br><span>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &qu=
ot;ERROR: Haiku inet route add command failed&quot;);</span><br><span>     =
status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(TARGET_LINUX) */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if define=
d(ROUTE_NET_API) */</span><br><span>     msg(M_FATAL,</span><br><span>     =
    &quot;Sorry, but I don&#39;t know how to do &#39;route&#39; commands on=
 this operating system=2E  Try putting your routes in a --route-up script&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if de=
fined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif /* if defined(ROUTE_NET_API) */</span><br><span> </span><br><span=
>     if (status =3D=3D RTA_SUCCESS)</span><br><span>     {</span><br><span=
>@@ -1777,8 +1753,7 @@</span><br><span>     const char *network =3D print_i=
n6_addr(r6-&gt;network, 0, &amp;gc);</span><br><span>     const char *gatew=
ay =3D print_in6_addr(r6-&gt;gateway, 0, &amp;gc);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_DARWIN) |=
| defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) \</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    || defined(TARGET_OPENBSD) || define=
d(TARGET_NETBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(TARGET_DARWIN) || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD=
)</span><br><span> </span><br><span>     /* the BSD platforms cannot specif=
y gateway and interface independently,</span><br><span>      * but for link=
-local destinations, we MUST specify the interface, so</span><br><span>@@ -=
1830,7 +1805,7 @@</span><br><span>         goto done;</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
f defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(ROUTE_NET_API)</span><br><span>     int metric =3D -1;</spa=
n><br><span>     if ((r6-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp; (r6-=
&gt;metric &gt; 0))</span><br><span>     {</span><br><span>@@ -1842,12 +181=
7,12 @@</span><br><span>                                device, r6-&gt;tabl=
e_id, metric);</span><br><span>     if (ret =3D=3D -EEXIST)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_=
ROUTE, &quot;NOTE: Linux route add command failed because route exists&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_RO=
UTE, &quot;NOTE: route add command failed because route exists&quot;);</spa=
n><br><span>         status =3D RTA_EEXIST;</span><br><span>     }</span><b=
r><span>     else if (ret &lt; 0)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;ERROR: Linux r=
oute add command failed&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_WARN, &quot;ERROR: route add command failed&quot;=
);</span><br><span>         status =3D RTA_ERROR;</span><br><span>     }</s=
pan><br><span> </span><br><span>@@ -1893,23 +1868,6 @@</span><br><span>    =
 bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Solaris r=
oute add -inet6 command failed&quot;);</span><br><span>     status =3D ret =
? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAG=
ONFLY)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s =
add -inet6 %s/%d&quot;, ROUTE_PATH, network, r6-&gt;netbits);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (gateway_needed)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        argv_printf_cat(&amp;argv, &quot;%s&quot;, gateway);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       argv_printf_cat(&amp;argv, &quot;-iface %s&quot;, device);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, =
&quot;ERROR: *BSD route add -inet6 command failed&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_=
ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> #elif defined(TARGET_DARWIN)</span><br><span> </span><br><span>     argv=
_printf(&amp;argv, &quot;%s add -inet6 %s -prefixlen %d&quot;, ROUTE_PATH, =
network, r6-&gt;netbits);</span><br><span>@@ -1960,10 +1918,10 @@</span><br=
><span>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR=
: Haiku inet6 route add command failed&quot;);</span><br><span>     status =
=3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(TARGET_LINUX) */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if defined(ROUT=
E_NET_API) */</span><br><span>     msg(M_FATAL,</span><br><span>         &q=
uot;Sorry, but I don&#39;t know how to do &#39;route ipv6&#39; commands on =
this operating system=2E  Try putting your routes in a --route-up script&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if def=
ined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif /* if defined(ROUTE_NET_API) */</span><br><span> </span><br><span>=
 done:</span><br><span>     if (status =3D=3D RTA_SUCCESS)</span><br><span>=
@@ -1986,13 +1944,13 @@</span><br><span> delete_route(struct route_ipv4 *r,=
 const struct tuntap *tt, unsigned int flags,</span><br><span>             =
 const struct route_gateway_info *rgi, const struct env_set *es, openvpn_ne=
t_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if !defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if !defined(ROUTE_NET_API)</span><br><span>     const ch=
ar *network;</span><br><span> #if !defined(TARGET_AIX)</span><br><span>    =
 const char *netmask;</span><br><span> #endif</span><br><span>     const ch=
ar *gateway;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* =
if !defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#else /* if !defined(ROUTE_NET_API) */</span><br><span>     int me=
tric;</span><br><span> #endif</span><br><span> </span><br><span>@@ -2004,7 =
+1962,7 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><br>=
<span>     struct argv argv =3D argv_new();</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ROUTE_NET_API)<=
/span><br><span>     network =3D print_in_addr_t(r-&gt;network, 0, &amp;gc)=
;</span><br><span> #if !defined(TARGET_AIX)</span><br><span>     netmask =
=3D print_in_addr_t(r-&gt;netmask, 0, &amp;gc);</span><br><span>@@ -2013,7 =
+1971,7 @@</span><br><span> #endif</span><br><span> </span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ROUTE_NE=
T_API)</span><br><span>     metric =3D -1;</span><br><span>     if (r-&gt;f=
lags &amp; RT_METRIC_DEFINED)</span><br><span>     {</span><br><span>@@ -20=
24,7 +1982,7 @@</span><br><span>                          r-&gt;table_id, m=
etric)</span><br><span>         &lt; 0)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;ERROR: L=
inux route delete command failed&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(M_WARN, &quot;ERROR: route delete command =
failed&quot;);</span><br><span>     }</span><br><span> #elif defined(_WIN32=
)</span><br><span> </span><br><span>@@ -2074,20 +2032,6 @@</span><br><span>=
     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_chec=
k(&amp;argv, es, 0, &quot;ERROR: Solaris route delete command failed&quot;)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
lif defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf=
(&amp;argv, &quot;%s delete -net %s %s %s&quot;, ROUTE_PATH, network, gatew=
ay, netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;ar=
gv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execv=
e_check(&amp;argv, es, 0, &quot;ERROR: FreeBSD route delete command failed&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_DRAGONFLY)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s delete -ne=
t %s %s %s&quot;, ROUTE_PATH, network, gateway, netmask);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, es, 0, &quot=
;ERROR: DragonFly route delete command failed&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif defined(TARGET_DARW=
IN)</span><br><span> </span><br><span>     if (is_on_link(r, flags, rgi))</=
span><br><span>@@ -2135,10 +2079,10 @@</span><br><span>     argv_msg(D_ROUT=
E, &amp;argv);</span><br><span>     openvpn_execve_check(&amp;argv, es, 0, =
&quot;ERROR: Haiku inet route delete command failed&quot;);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if define=
d(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
else  /* if defined(ROUTE_NET_API) */</span><br><span>     msg(M_FATAL,</sp=
an><br><span>         &quot;Sorry, but I don&#39;t know how to do &#39;rout=
e&#39; commands on this operating system=2E  Try putting your routes in a -=
-route-up script&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif /* if defined(TARGET_LINUX) */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif /* if defined(ROUTE_NET_API) */</span><br><span=
> </span><br><span>     r-&gt;flags &amp;=3D ~RT_ADDED;</span><br><span>   =
  argv_free(&amp;argv);</span><br><span>@@ -2159,7 +2103,7 @@</span><br><sp=
an>     }</span><br><span> </span><br><span> #if !defined(_WIN32)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ROUTE_NET_A=
PI)</span><br><span>     const char *gateway;</span><br><span> #endif</span=
><br><span> #if !defined(TARGET_SOLARIS)</span><br><span>@@ -2186,12 +2130,=
11 @@</span><br><span>     struct argv argv =3D argv_new();</span><br><span=
> </span><br><span>     network =3D print_in6_addr(r6-&gt;network, 0, &amp;=
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARG=
ET_LINUX) &amp;&amp; !defined(_WIN32)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if !defined(ROUTE_NET_API) &amp;&amp; !defined(_WIN32)</=
span><br><span>     gateway =3D print_in6_addr(r6-&gt;gateway, 0, &amp;gc);=
</span><br><span> #endif</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) =
|| defined(TARGET_DRAGONFLY) \</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_DARWIN) ||=
 defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> </span>=
<br><span>     /* the BSD platforms cannot specify gateway and interface in=
dependently,</span><br><span>      * but for link-local destinations, we MU=
ST specify the interface, so</span><br><span>@@ -2209,7 +2152,7 @@</span><b=
r><span> </span><br><span>     msg(D_ROUTE, &quot;delete_route_ipv6(%s/%u)&=
quot;, network, r6-&gt;netbits);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(ROUTE_NET_API)</span><br><sp=
an>     int metric =3D -1;</span><br><span>     if ((r6-&gt;flags &amp; RT_=
METRIC_DEFINED) &amp;&amp; (r6-&gt;metric &gt; 0))</span><br><span>     {</=
span><br><span>@@ -2220,7 +2163,7 @@</span><br><span>                      =
    device, r6-&gt;table_id, metric)</span><br><span>         &lt; 0)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(M_WARN, &quot;ERROR: Linux route v6 delete command failed&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &=
quot;ERROR: route v6 delete command failed&quot;);</span><br><span>     }</=
span><br><span> </span><br><span> #elif defined(_WIN32)</span><br><span>@@ =
-2242,22 +2185,6 @@</span><br><span>     argv_msg(D_ROUTE, &amp;argv);</spa=
n><br><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Solari=
s route delete -inet6 command failed&quot;);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD) || d=
efined(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&a=
mp;argv, &quot;%s delete -inet6 %s/%d&quot;, ROUTE_PATH, network, r6-&gt;ne=
tbits);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (gateway_needed)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;%s&quot;=
, gateway);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;-iface %s&quot=
;, device);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv,=
 es, 0, &quot;ERROR: *BSD route delete -inet6 command failed&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif defi=
ned(TARGET_DARWIN)</span><br><span> </span><br><span>     argv_printf(&amp;=
argv, &quot;%s delete -inet6 %s -prefixlen %d&quot;, ROUTE_PATH, network, r=
6-&gt;netbits);</span><br><span>@@ -2310,10 +2237,10 @@</span><br><span>   =
  argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_check(&=
amp;argv, es, 0, &quot;ERROR: Haiku inet6 route delete command failed&quot;=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
else  /* if defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#else  /* if defined(ROUTE_NET_API) */</span><br><span>   =
  msg(M_FATAL,</span><br><span>         &quot;Sorry, but I don&#39;t know h=
ow to do &#39;route ipv6&#39; commands on this operating system=2E  Try put=
ting your routes in a --route-down script&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif /* if defined(TARGET_LINUX) */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(ROUTE_NE=
T_API) */</span><br><span> </span><br><span>     argv_free(&amp;argv);</spa=
n><br><span>     gc_free(&amp;gc);</span><br></pre><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail">change 21=
54</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I601454a511c9aac4f37d8629b1692266cdbd6885 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2154 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></h=
tml>
--Q0MisFcB1wg=--


--===============5740011810627937795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5740011810627937795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5740011810627937795==--

