Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3F606A32E
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SrV1qhkH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HmLbuA9z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AOYdrI9z;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SGVHwolW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=0L4FMFaiT6t0ncJ051QIDoTu3FxLSAeyDFkA4XaL3jU=; b=SrV1qhkHOmKhuvjAdBMCnRCQal
	bYDDcKAhz9xrobkGwjii5XaKQUgNZNY5S1iWWmzEix8WZyQSHSsexHXLMc429BiledMHzYyVUWTNi
	fYvb/58/dLshqfIX/OBT9NGXoi2EGwqM1DkljzqpNajVn3MbEfnzya3q0pjIU+fpMzaU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPkjr-000000004QX-24CU;
	Sat, 07 Nov 2026 18:02:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPkjp-000000004QJ-45C9
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 18:02:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pdGUr4gw3aFrR4e8GznD1cnMv8o9bRy94CXo9+1iBHg=; b=HmLbuA9z3vSFXxfWVEi4cxhOMQ
 b62zhOSTod/kn6raeprgjRRZVLoRV3e/pctaalU5XFt6jYP75SdUxaUk1iU3cKFsokB96+SZKJqSx
 h1WlTmf8/Nm8Cc8dSwWC8RybJoOVQkhhqCX8HGaa6dXnKKhjKdd9qyjS2srXrLPUM3PM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pdGUr4gw3aFrR4e8GznD1cnMv8o9bRy94CXo9+1iBHg=; b=AOYdrI9zhYWSV1m+goH3jk+eXo
 o/+2B+Niuhc6whVGN5ub+zvXleY95rj7Hk7wI/M/SR8wXW23RlIbExY5Bpf3MNgwvAdYRIB9RNu9w
 9eP+tuplqQA/QndaBx2pcbjxRQNCmC1/umj+fgKfuLF0IQ6+7K3Vp5PVlkH5r8bVWWJw=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPkjo-000000007k1-3S8G for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 18:02:01 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so829734f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 10:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794074514; x=1794679314; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pdGUr4gw3aFrR4e8GznD1cnMv8o9bRy94CXo9+1iBHg=;
 b=SGVHwolWVBFS7g0zKWKsw1XkfdRct9LM0TKHn+ARyHYFvhPgT+7EdtfRhOj5iu/dLj
 el14I/tf4mtgtx8GWRHz4B0+8QTNKJLOi4q0fFSQZVvkZKo6Es49DflbGED13sxpmtQy
 EDrS0PPzH4rp055gymBieoSllTFheeDOuf7CXileEBfHUrvIGuaMPsO0GYe4E7xZEjvv
 +Zfpap7oNDynKqw17Nza5eg/6Wn4/5q38Lc/9dkusr1helBNgZwt1ZRXKyB+kmywR5+3
 QueS7YIiM3ZCjpOWNDhQYAJT6z4iwg/EfV4yG4Lu3CgWweKtKq0RSOpWk0VtEuXsayrm
 8z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794074514; x=1794679314;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pdGUr4gw3aFrR4e8GznD1cnMv8o9bRy94CXo9+1iBHg=;
 b=25Qbs6O5DBHqJCxgNbV7iMV30PNe3ma88Y8eJ/x41iCIYp3cX7D/PLNXUXtJDs2Vqy
 rIh9l8CYf0N6+WWYD7m5gmByJwuMfkjc6LUBS3nY66ces7MIbn5f1j2GFKmx4jmQeR1v
 64rTW/IE5et3Yb4fcfi9baD3EEqN4vkCMJl+J4qgY+RviRxM5Rl73xVz8TshujNqGXiK
 PtwYeZgfWfSakug5AxdN5zSihUT4kP4p+IO1e8f5/oLf3XFYRECPB/wRlcO0WBN3oTny
 A5kqmi5UN5HCcCXHFzDjHY5i6uf2Hky41roX/2qtMX0LIj9hBxvVmZ5tAkoKnUW4eZbp
 y3og==
X-Gm-Message-State: APuU4Z+IL5VfuUs78I9erWpXYwyhIUNumYyycbY0kCsP43vE98Em8gFL
 rVm9ZpLEJrEuSxjNq/AzHfuxGCwmyGU3ziJL+RtIQt5dsh0ZOBfI4Gd+4lx2ZmdlirVgR60Bh+N
 mXRh5DpPvuughqDxpwgzsPSejQqrf9E6uy8IkpH0lXbRXZ03tRBSDDJYZSLLuBFAkNoBu8G2tsJ
 S6eOiDWw==
X-Gm-Gg: AYBFou1FVZhDfw/tLNLH6yB+FNoCPnqn1pitzHDKsSbWCh6o/v3dhzMj4Qyw/G/c4j6
 hO0xVMFHgZ/zWSp6zfnaAGpPvZD+UPGqqMQ7AWtKTISyxgMBlQMmB6hMI0wNAJcyIdiiJglz44T
 Qd5JImsPUAxmgKoC8CArcxw7eFB6KSFnZSgiwNGIMa/68sWFgl6GUZj384ViJUkG4tUMK/cRrhq
 uRA1aF57Va5dUIOzmk+OBJm9kPD+NxxaGdECuD/UvvZGkBGmVuJj9qWCAGIZRDL1R29SYrU9ThU
 xyC4bgxgBUPrUzzYI9TUvoNXKkTcJGkgYCjMmLERPTvSF2D33sbvyVqvYE+Hz0dCk+wGQSyLSmB
 Vd8APsrtgWmVI2Mn9Uaa184ywgLclZJLbBOQeXE5RHsgZ2vqfYxBGn1ydqia1MT0rOkUJod0/Es
 lpyK9DnMyJMUynzRY76asY2IIVq3fw0GJSTdFIOR4ASvcd+fN9c72719dFzaHnt/XVCUQIsBHDo
 imYxBNgZW1dY2nIS4KCUIJ2UoM43ugz261AAPWILHLNnteRoiblvamwMNk/d1Gbqc4gFGshSelF
 sssTsb3lonwOmAifD3a0xjVp2mS9Wvlk4zV5Fq4E0Hddn++twGsOawCAQt5hwNf2V4vu3IoUlOG
 a+cg+9KDT+naBZYzyC3iGvrk5GQ0PLtJW6WM7WUnzvwpRqBDdznfiF8D3/V46iNBeNKxMDKs/hP
 Ji3QBWTYpSrpRUVR5M0r6rRhr+KN9pQBQoJDc=
X-Received: by 2002:a5d:5c84:0:b0:48e:353b:9f28 with SMTP id
 ffacd0b85a97d-4927b092b96mr11668738f8f.1.1794074514082; 
 Sat, 07 Nov 2026 10:01:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d3d6085asm15037888f8f.3.2026.11.07.10.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 10:01:53 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 18:01:53 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64
X-Gerrit-Change-Number: 2153
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2153?usp=email>
X-Gerrit-Commit: 34de7dba8d0c951b8b3602f26020d0d321101d96
References: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkkzZTYwNDMxNzg5MzVmZGQwNWU2ZWE3OGM0MTFkYWM1ZGVjYjdhYzY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <371d956a060da004ba6ada6b80c0e36c19f6b67a-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPkjo-000000007k1-3S8G
Subject: [Openvpn-devel] [S] Change in openvpn[master]: networking_freebsd:
 fix route command and return value details
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
Content-Type: multipart/mixed; boundary="===============9053876033665500164=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9053876033665500164==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1koCGK4Uofs="; charset=UTF-8

--1koCGK4Uofs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2153?usp=3Demail

to review the following change=2E
=


Change subject: networking_freebsd: fix route command and return value de=
tails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

network=
ing_freebsd: fix route command and return value details

- Return -1 on fai=
lure, as networking=2Eh documents, instead of 1=2E
- Pass -fib only for a n=
on-zero table=2E Without it, route(8) uses the
  FIB of the process, like t=
he route commands in route=2Ec=2E
- Add the interface as scope to link-loca=
l IPv6 gateways=2E
- Use "delete" and "-inet6", as route=2Ec does=2E

All c=
urrent callers (DCO iroutes) ignore the return value=2E

Change-Id: I3e6043=
178935fdd05e6ea78c411dac5decb7ac64
Signed-off-by: Razvan Cojocaru <razvanc@=
mailbox=2Eorg>
---
M src/openvpn/networking_freebsd=2Ec
1 file changed, 27 =
insertions(+), 18 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/53/2153/1

diff --git a/src/openvpn/networking_fr=
eebsd=2Ec b/src/openvpn/networking_freebsd=2Ec
index 88fd5c0=2E=2Ee3697d4 1=
00644
--- a/src/openvpn/networking_freebsd=2Ec
+++ b/src/openvpn/networking=
_freebsd=2Ec
@@ -24,18 +24,21 @@
      * if not, install "connected" route =
to interface
      * (needed to make 'ifconfig-push IPs outside server subn=
et' work)
      */
+    argv_printf(&argv, "%s %s -net %s/%d", ROUTE_PATH, =
op,
+                inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixl=
en);
     if (gw)
     {
         _gw =3D ntohl(*gw);
-        argv_printf(=
&argv, "%s %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
-                    =
inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-                =
    inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)), table);
+        argv_pri=
ntf_cat(&argv, "%s", inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)));
     }
=
     else
     {
-        argv_printf(&argv, "%s %s -net %s/%d -iface %s -f=
ib %d", ROUTE_PATH, op,
-                    inet_ntop(AF_INET, &_dst, buf1=
, sizeof(buf1)), prefixlen,
-                    iface, table);
+        ar=
gv_printf_cat(&argv, "-iface %s", iface);
+    }
+    /* without -fib, rout=
e(8) uses the FIB of the process */
+    if (table)
+    {
+        argv_pr=
intf_cat(&argv, "-fib %u", table);
     }
 
     argv_msg(M_INFO, &argv);
@=
@ -43,7 +46,7 @@
 
     argv_free(&argv);
 
-    return (!status);
+    ret=
urn status ? 0 : -1;
 }
 
 static int
@@ -59,26 +62,32 @@
      * if not, i=
nstall "connected" route to interface
      * (needed to make 'ifconfig-pus=
h IPs outside server subnet' work)
      */
-    if (gw)
+    argv_printf(&=
argv, "%s %s -inet6 %s/%d", ROUTE_PATH, op,
+                inet_ntop(AF_I=
NET6, dst, buf1, sizeof(buf1)), prefixlen);
+    if (gw && iface && IN6_IS_=
ADDR_LINKLOCAL(gw))
     {
-        argv_printf(&argv, "%s -6 %s -net %s/%d=
 %s -fib %d", ROUTE_PATH, op,
-                    inet_ntop(AF_INET6, dst,=
 buf1, sizeof(buf1)), prefixlen,
-                    inet_ntop(AF_INET6, g=
w, buf2, sizeof(buf2)), table);
+        /* a link-local gateway needs the =
interface as scope */
+        argv_printf_cat(&argv, "%s%%%s", inet_ntop(A=
F_INET6, gw, buf2, sizeof(buf2)), iface);
+    }
+    else if (gw)
+    {
+=
        argv_printf_cat(&argv, "%s", inet_ntop(AF_INET6, gw, buf2, sizeof(b=
uf2)));
     }
     else
     {
-        argv_printf(&argv, "%s -6 %s -net =
%s/%d -iface %s -fib %d", ROUTE_PATH, op,
-                    inet_ntop(AF=
_INET6, dst, buf1, sizeof(buf1)), prefixlen,
-                    iface, ta=
ble);
+        argv_printf_cat(&argv, "-iface %s", iface);
     }
-
+    if=
 (table)
+    {
+        argv_printf_cat(&argv, "-fib %u", table);
+    }
 =

     argv_msg(M_INFO, &argv);
     bool status =3D openvpn_execve_check(&a=
rgv, NULL, 0, "ERROR: FreeBSD route command failed");
 
     argv_free(&arg=
v);
 
-    return (!status);
+    return status ? 0 : -1;
 }
 
 int
@@ -99,=
14 +108,14 @@
 net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr=
_t *dst, int prefixlen, const in_addr_t *gw,
                  const char *=
iface, uint32_t table, int metric)
 {
-    return net_route_v4("del", dst, =
prefixlen, gw, iface, table, metric);
+    return net_route_v4("delete", ds=
t, prefixlen, gw, iface, table, metric);
 }
 
 int
 net_route_v6_del(const =
openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
        =
          const struct in6_addr *gw, const char *iface, uint32_t table, int=
 metric)
 {
-    return net_route_v6("del", dst, prefixlen, gw, iface, tabl=
e, metric);
+    return net_route_v6("delete", dst, prefixlen, gw, iface, t=
able, metric);
 }
 
 #endif /* if defined(TARGET_FREEBSD) */

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac=
5decb7ac64
Gerrit-Change-Number: 2153
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>

--1koCGK4Uofs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">networking_freebsd: fix route command and return value =
details<br><br>- Return -1 on failure, as networking=2Eh documents, instead=
 of 1=2E<br>- Pass -fib only for a non-zero table=2E Without it, route(8) u=
ses the<br>  FIB of the process, like the route commands in route=2Ec=2E<br=
>- Add the interface as scope to link-local IPv6 gateways=2E<br>- Use &quot=
;delete&quot; and &quot;-inet6&quot;, as route=2Ec does=2E<br><br>All curre=
nt callers (DCO iroutes) ignore the return value=2E<br><br>Change-Id: I3e60=
43178935fdd05e6ea78c411dac5decb7ac64<br>Signed-off-by: Razvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/networking_freebsd=2Ec<br=
>1 file changed, 27 insertions(+), 18 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/53/215=
3/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/networking_freebsd=2Ec b/src/openvpn/n=
etworking_freebsd=2Ec</span><br><span>index 88fd5c0=2E=2Ee3697d4 100644</sp=
an><br><span>--- a/src/openvpn/networking_freebsd=2Ec</span><br><span>+++ b=
/src/openvpn/networking_freebsd=2Ec</span><br><span>@@ -24,18 +24,21 @@</sp=
an><br><span>      * if not, install &quot;connected&quot; route to interfa=
ce</span><br><span>      * (needed to make &#39;ifconfig-push IPs outside s=
erver subnet&#39; work)</span><br><span>      */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s %s -net %s=
/%d&quot;, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                inet_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)), p=
refixlen);</span><br><span>     if (gw)</span><br><span>     {</span><br><s=
pan>         _gw =3D ntohl(*gw);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        argv_printf(&amp;argv, &quot;%s %s -net %s/%d %s -fib %d=
&quot;, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    inet_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)), pr=
efixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       inet_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)), table);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;a=
rgv, &quot;%s&quot;, inet_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)));</sp=
an><br><span>     }</span><br><span>     else</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_printf(&amp;arg=
v, &quot;%s %s -net %s/%d -iface %s -fib %d&quot;, ROUTE_PATH, op,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    inet_ntop(=
AF_INET, &amp;_dst, buf1, sizeof(buf1)), prefixlen,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    iface, table);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp=
;argv, &quot;-iface %s&quot;, iface);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* without -fib, route(8) uses the FIB of the process */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (table)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-fib %u&=
quot;, table);</span><br><span>     }</span><br><span> </span><br><span>   =
  argv_msg(M_INFO, &amp;argv);</span><br><span>@@ -43,7 +46,7 @@</span><br>=
<span> </span><br><span>     argv_free(&amp;argv);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return (!status);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return status ? 0 : -1=
;</span><br><span> }</span><br><span> </span><br><span> static int</span><b=
r><span>@@ -59,26 +62,32 @@</span><br><span>      * if not, install &quot;c=
onnected&quot; route to interface</span><br><span>      * (needed to make &=
#39;ifconfig-push IPs outside server subnet&#39; work)</span><br><span>    =
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (gw)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv=
, &quot;%s %s -inet6 %s/%d&quot;, ROUTE_PATH, op,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                inet_ntop(AF_INET6, dst, buf1=
, sizeof(buf1)), prefixlen);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (gw &amp;&amp; iface &amp;&amp; IN6_IS_ADDR_LINKLOCAL(gw))<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d %s -fib %d&quot;,=
 ROUTE_PATH, op,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    inet_=
ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* a link-local gateway needs the inter=
face as scope */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     argv_printf_cat(&amp;argv, &quot;%s%%%s&quot;, inet_ntop(AF_INET6, gw,=
 buf2, sizeof(buf2)), iface);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (gw)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_c=
at(&amp;argv, &quot;%s&quot;, inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)));=
</span><br><span>     }</span><br><span>     else</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_printf(&amp=
;argv, &quot;%s -6 %s -net %s/%d -iface %s -fib %d&quot;, ROUTE_PATH, op,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    ine=
t_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    iface, table);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp=
;argv, &quot;-iface %s&quot;, iface);</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (table)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        argv_printf_cat(&amp;argv, &quot;-fib %u&quot;, table);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span>=
<br><span>     argv_msg(M_INFO, &amp;argv);</span><br><span>     bool statu=
s =3D openvpn_execve_check(&amp;argv, NULL, 0, &quot;ERROR: FreeBSD route c=
ommand failed&quot;);</span><br><span> </span><br><span>     argv_free(&amp=
;argv);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return (!status);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return status ? 0 : -1;</span><br><span> }</span><br><span> </spa=
n><br><span> int</span><br><span>@@ -99,14 +108,14 @@</span><br><span> net_=
route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefix=
len, const in_addr_t *gw,</span><br><span>                  const char *ifa=
ce, uint32_t table, int metric)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return net_route_v4(&quot;del&quot;, dst, =
prefixlen, gw, iface, table, metric);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return net_route_v4(&quot;delete&quot;, dst, prefixle=
n, gw, iface, table, metric);</span><br><span> }</span><br><span> </span><b=
r><span> int</span><br><span> net_route_v6_del(const openvpn_net_ctx_t *ctx=
, const struct in6_addr *dst, int prefixlen,</span><br><span>              =
    const struct in6_addr *gw, const char *iface, uint32_t table, int metri=
c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return net_route_v6(&quot;del&quot;, dst, prefixlen, gw, iface, table, =
metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
net_route_v6(&quot;delete&quot;, dst, prefixlen, gw, iface, table, metric);=
</span><br><span> }</span><br><span> </span><br><span> #endif /* if defined=
(TARGET_FREEBSD) */</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail">change 2153</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e6043178935f=
dd05e6ea78c411dac5decb7ac64 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2153 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--1koCGK4Uofs=--


--===============9053876033665500164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9053876033665500164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9053876033665500164==--

