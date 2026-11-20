Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50C606A326
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VJYMnp8n;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S+gYTuQr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JbDSrrsF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eivED0W4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DdVM3LkfpyskEs4aXlW5sFwjE5RtjEnZgrM0PH34dSA=; b=VJYMnp8nOz/bbhwEQP2xnLcB1o
	qg4pgB0iHY2akSOaJAQ0QhIyq8pZAMWOgh0n5F6cljL5bH8LCgJAE719fRdac9WoXsj6X1e4DEdA7
	nUW0gu6JsqN/7obWpX8dU1Ar9ieTcHDlyIkHdqW92x2HB3+wFPmcvKewzZ5vzteL79o0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUINz-000000004aC-103P;
	Fri, 20 Nov 2026 06:46:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUINy-000000004a4-0FkE
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:46:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c3+cKy3PGzcfZ8aNUfovss/Ux7pqQrShJJ+3fbAyqkg=; b=S+gYTuQrxt6uebWqbk0PgzPKsv
 8c6VvCG7UPHKJO2KAXyC7gnDAHxNzt4BD+Ri4MEjOvC5vv3lZx+/JBC1xXD2zBuQjDHJCwpD5hBM7
 nR69LYoXP/Q+zjwsAsVKaarD5EbGUktlzZAShpoQP+qQJIEkPwmvKeCznyYfKAZYgdhw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c3+cKy3PGzcfZ8aNUfovss/Ux7pqQrShJJ+3fbAyqkg=; b=JbDSrrsF9kEIG+WXAtrmLmSlXq
 6kAWu9pa4j5ubfeD17EDQ0TUISxIuS3Owm7lnKovSra0EwS6xbUxtfTixbb0WxWIqYQNdIjFz6uFI
 98bBFjQ1UJ+W87pISZcs8gzDIKHBjgmNURUNLjQfyoDfI2JrNIaGkQEtAVwwchpn8hww=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUINu-000000005h4-24Zl for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:46:13 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso217785f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 22:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795157164; x=1795761964; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c3+cKy3PGzcfZ8aNUfovss/Ux7pqQrShJJ+3fbAyqkg=;
 b=eivED0W48D+lf2j1fENQ+zXo30DewgFmP9bwYowhof7MPV/lZ0C0ela52PD9YDg9LR
 frOmFF0lPAbOiZIgZQYeNI1icE5l3L/j3UJd9WXHY23NQcjZSSgJMbdfu50XAe0nGWIW
 zfUWgfCQisK9w9HMHkii1wd9cFfmN9HN2GT/odyp6ncM1Kt/03zwrikGHy3k6g1pwoDx
 iB9AMvKn6obbZpgL2qKvLw1uBliYgK7JnqidziAiFms8L83dwr8vanWvhg06/R8sytgF
 lOSh1OhZpemc631AgEHTXGvQj9Znf/J7VKBouoSbhmI8FKUOI2D8Tr8w1oe0z5JwyxkD
 hBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795157164; x=1795761964;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=c3+cKy3PGzcfZ8aNUfovss/Ux7pqQrShJJ+3fbAyqkg=;
 b=jEB/HO1FVqweoSYFlD6LOM3DU0/tgYtdWbFcCOmFRUDD9aiygYNNaDa+ijVwiJdfqU
 eWpwDGe7AzeP3LnMBMVm7w5WyRvCIwxT53gsorn6c7Ky+du+b/cES1NhuYGY/3nJjtRG
 8ZbqdqfqHczEbIoKD3haAusEUNjXvlJYrHldMgWUSNEkJlaqljk7FQwah3YaAccAr2mH
 5m4EMoWGvWfs4842zWUWKOu/Qn/SdRq/kSQ3FHc8CQ0FF7b32h1t4yDnRgSbu+Ipc+a4
 LgkPa/fQozr2Laz8Wqh31lxVWC3k+62fslge5aOf+tmgAZPiNofoMFoi4dQKl3LgLFxJ
 VToQ==
X-Gm-Message-State: APuU4Z/ktCu3qXmCHPgOF6Nj5ZGGubnoe538Su1pukxjvKisRYKBbY3l
 T/675tNgAZH0PPkl/NNpQVHFxgTZToS+FlKJ3TaJYaBDafE0EX/wIwPZTyW1OiMv8e/eq3RjivO
 2rIW0prl1Hce7RRjZGmD8vfiXSG7q3OnfLTsKWvYqokheegFkFFlE/DUkR84JhUayf25EALn63r
 jCh9q2Gw==
X-Gm-Gg: AZFdTZcL2V1Y13uIdkBmJ+ZdY909QjLqpWrpyz5rlZ0uBnTj1NEDov3Nt0RaULxaZwg
 lX7/9SLGqGnDbMbiLMZ3Pqonw7QXcpchISEdXReeVW+ofHxDFKtoWF1LBDnL/f8I+puNfoBPctZ
 So0JaiLkoSC6QwsSp4lDD03iLgyZ6VGEv8MUosnR5QosmPnAHSepRwABCVWvP+PoFo04XA9MGEN
 70AHlLGdSSPUBfHR6KYY2MI0QFEuBJZmnH2Yst1dzKxPzwHm7ktYrg+3kWGliYmDzkBrbmLvXng
 N3h+wjICSARl63DkKFqo+DIOyKgP5VRFmgn0865YPg/OCHdxKs0/4foO0t0Ll8pwJfOTTdA3daW
 7TSRFj9Rs9zRVbGM3gbUyF7tNtGdUM2fUg5i/+wJO/s3oG235IGwNK2qUhA4xrXe+VD42SR9qjd
 HlTWq0wqg2/zKKoYfQk6mppAFVOYW6XRKhWcrM1M7GHI5OopQ6gwxYUIJNEI8syZpHzFV1aw/Cy
 GT2RD+LOCKuU72WQ+Q1fYCAzs/pZbqEET/H8YeP0I8StKxhhC57rvovpe82kGxXMt7qU402j+RM
 uIZpnPym39JgrYkVKxbuorwXoPiylnncp4CLxx3pYbbPK/+9N2RyNjbBuH5bubsn10HEsaXVnAY
 nejvPQBI8SdIumwC80LNAd07Cb6A8dlRUs2nwVitLvtrIq2OPiA3YRHTkCpOh8aUggiEd6YpqnU
 HTwET1+Bk/yU/4uTk=
X-Received: by 2002:a05:6000:454f:b0:4a6:d298:832a with SMTP id
 ffacd0b85a97d-4abb31ade9cmr1986879f8f.30.1795157163452; 
 Thu, 19 Nov 2026 22:46:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c3csm3865143f8f.36.2026.11.19.22.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 22:46:03 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 06:45:58 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885
X-Gerrit-Change-Number: 2154
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2154?usp=email>
X-Gerrit-Commit: 0d5a336d5efcb3a220bc2338f4a4dd69aca12302
In-Reply-To: <gerrit.1794074511000.I601454a511c9aac4f37d8629b1692266cdbd6885@gerrit.openvpn.net>
References: <gerrit.1794074511000.I601454a511c9aac4f37d8629b1692266cdbd6885@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkk2MDE0NTRhNTExYzlhYWM0ZjM3ZDg2MjliMTY5MjI2NmNkYmQ2ODg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <60ce8855daf7c53c7bca74cc217d6751711f9aa0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUINu-000000005h4-24Zl
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
Content-Type: multipart/mixed; boundary="===============3980322086333207287=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3980322086333207287==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KUmbqs+S9TY="; charset=UTF-8

--KUmbqs+S9TY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

Hello =
Arne Schwabe, Gert Doering, 

I'd like you to reexamine a change=2E Please =
visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail

to =
look at the new patch set (#6)=2E


Change subject: route: use the net_ API=
 for routes on FreeBSD and DragonFly
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

route: use the net_ API for routes on FreeBSD and=
 DragonFly

Add and delete IPv4 and IPv6 routes through net_route_v4/v6_add=
/del()
on FreeBSD and DragonFly, as on Linux, instead of running route(8)
f=
rom route=2Ec=2E Build networking_freebsd=2Ec for DragonFly as well; -fib
i=
s only passed on FreeBSD, where --route-table is now supported=2E

A non-co=
ntiguous IPv4 netmask now gets an error instead of an invalid
prefix length=
=2E networking_freebsd=2Ec logs route commands at D_ROUTE, as
route=2Ec did=
=2E The shared error messages lose their "Linux" prefix=2E

Change-Id: I601=
454a511c9aac4f37d8629b1692266cdbd6885
Signed-off-by: Razvan Cojocaru <razva=
nc@mailbox=2Eorg>
---
M doc/man-sections/vpn-network-options=2Erst
M src/op=
envpn/networking=2Eh
M src/openvpn/networking_freebsd=2Ec
M src/openvpn/opt=
ions=2Ec
M src/openvpn/route=2Ec
5 files changed, 71 insertions(+), 136 del=
etions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/54/2154/6

diff --git a/doc/man-sections/vpn-network-options=2Erst b/do=
c/man-sections/vpn-network-options=2Erst
index 960c6ad=2E=2Ef282982 100644
=
--- a/doc/man-sections/vpn-network-options=2Erst
+++ b/doc/man-sections/vpn=
-network-options=2Erst
@@ -399,7 +399,10 @@
   table of the operating syste=
m, but with this option,
   a user defined routing table can be used instea=
d=2E
 
-  (Supported on Linux only, on other platforms this is a no-op)=2E
=
+  On FreeBSD, the table id is the FIB number=2E Without this option, route=
s
+  go to the FIB OpenVPN runs in (see :code:`setfib(1)`)=2E
+
+  (Support=
ed on Linux and FreeBSD only, on other platforms this is a no-op)=2E
 
 --r=
oute args
   Add route to routing table after connection is established=2E =
Multiple
diff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=
=2Eh
index 1763e64=2E=2Ecbb10ed 100644
--- a/src/openvpn/networking=2Eh
+++=
 b/src/openvpn/networking=2Eh
@@ -30,7 +30,7 @@
 #include "networking_sitnl=
=2Eh"
 #elif ENABLE_IPROUTE
 #include "networking_iproute2=2Eh"
-#elif defi=
ned(TARGET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGON=
FLY)
 typedef void *openvpn_net_ctx_t;
 typedef char openvpn_net_iface_t;
 =
#else  /* ifdef ENABLE_SITNL */
@@ -236,7 +236,8 @@
 
 #endif /* ENABLE_SIT=
NL || ENABLE_IPROUTE */
 
-#if defined(ENABLE_SITNL) || defined(ENABLE_IPRO=
UTE) || defined(TARGET_FREEBSD)
+#if defined(ENABLE_SITNL) || defined(ENABL=
E_IPROUTE) || defined(TARGET_FREEBSD) \
+    || defined(TARGET_DRAGONFLY)
 =
/**
  * Add a route for an IPv4 address/network
  *
@@ -305,7 +306,7 @@
   =
                   const struct in6_addr *gw, const openvpn_net_iface_t *if=
ace, int table,
                      int metric);
 
-#endif /* ENABLE_SITN=
L || ENABLE_IPROUTE || TARGET_FREEBSD */
+#endif /* ENABLE_SITNL || ENABLE_=
IPROUTE || TARGET_FREEBSD || TARGET_DRAGONFLY */
 
 #if defined(ENABLE_SITN=
L) || defined(ENABLE_IPROUTE)
 
diff --git a/src/openvpn/networking_freebsd=
=2Ec b/src/openvpn/networking_freebsd=2Ec
index 141f4bd=2E=2Eeba8866 100644=

--- a/src/openvpn/networking_freebsd=2Ec
+++ b/src/openvpn/networking_free=
bsd=2Ec
@@ -6,7 +6,7 @@
 #include "run_command=2Eh"
 #include "networking=
=2Eh"
 
-#if defined(TARGET_FREEBSD)
+#if defined(TARGET_FREEBSD) || define=
d(TARGET_DRAGONFLY)
 
 static int
 net_route_v4(const char *op, const in_ad=
dr_t *dst, int prefixlen, const in_addr_t *gw,
@@ -35,14 +35,16 @@
     {
 =
        argv_printf_cat(&argv, "-iface %s", iface);
     }
+#if defined(TAR=
GET_FREEBSD) /* DragonFly has no multiple FIB support */
     /* without -f=
ib, route(8) uses the FIB of the process */
     if (table >=3D 0)
     {
 =
        argv_printf_cat(&argv, "-fib %d", table);
     }
+#endif
 
-    arg=
v_msg(M_INFO, &argv);
-    bool status =3D openvpn_execve_check(&argv, NULL=
, 0, "ERROR: FreeBSD route command failed");
+    argv_msg(D_ROUTE, &argv);=

+    const bool status =3D openvpn_execve_check(&argv, NULL, 0, "ERROR: ro=
ute command failed");
 
     argv_free(&argv);
 
@@ -77,13 +79,15 @@
     {=

         argv_printf_cat(&argv, "-iface %s", iface);
     }
+#if defined(T=
ARGET_FREEBSD) /* DragonFly has no multiple FIB support */
     if (table >=
=3D 0)
     {
         argv_printf_cat(&argv, "-fib %d", table);
     }
+#e=
ndif
 
-    argv_msg(M_INFO, &argv);
-    bool status =3D openvpn_execve_ch=
eck(&argv, NULL, 0, "ERROR: FreeBSD route command failed");
+    argv_msg(D=
_ROUTE, &argv);
+    const bool status =3D openvpn_execve_check(&argv, NULL=
, 0, "ERROR: route command failed");
 
     argv_free(&argv);
 
@@ -118,4 +=
122,4 @@
     return net_route_v6("delete", dst, prefixlen, gw, iface, tabl=
e, metric);
 }
 
-#endif /* if defined(TARGET_FREEBSD) */
+#endif /* if def=
ined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) */
diff --git a/src/openv=
pn/options=2Ec b/src/openvpn/options=2Ec
index 35fbe39=2E=2E8150a16 100644
=
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -226,7 +226,=
7 @@
     "                    pass --ifconfig parms by environment to scri=
pts=2E\n"
     "--ifconfig-nowarn : Don't warn if the --ifconfig option on =
this side of the\n"
     "                    connection doesn't match the =
remote side=2E\n"
-#ifdef TARGET_LINUX
+#if defined(TARGET_LINUX) || define=
d(TARGET_FREEBSD)
     "--route-table table_id : Specify a custom routing t=
able for use with --route(-ipv6)=2E\n"
     "                           If =
not specified, the id of the default routing table will be used=2E\n"
 #end=
if
@@ -5293,8 +5293,8 @@
     }
     else if (streq(p[0], "route-table") &&=
 p[1] && !p[2])
     {
-#ifndef ENABLE_SITNL
-        msg(M_WARN, "NOTE: --=
route-table is supported only on Linux when SITNL is built-in");
+#if !defi=
ned(ENABLE_SITNL) && !defined(TARGET_FREEBSD)
+        msg(M_WARN, "NOTE: -=
-route-table is supported only on FreeBSD, and on Linux when SITNL is built=
-in");
 #endif
         VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);
         if (=
!atoi_constrained(p[1], &options->route_default_table_id, p[0], 0, INT_MAX,=

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 8c493ee=
=2E=2E0149bb5 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2E=
c
@@ -103,6 +103,11 @@
 #define RTA_SUCCESS 1 /* route addition succeeded *=
/
 #define RTA_EEXIST  2 /* route not added as it already exists */
 
+/* P=
latforms that add and delete routes through the net_ API (networking=2Eh) *=
/
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_D=
RAGONFLY)
+#define ROUTE_NET_API
+#endif
+
 #ifndef TARGET_ANDROID
 static =
bool
 add_bypass_address(struct route_bypass *rb, const in_addr_t a)
@@ -14=
33,7 +1438,7 @@
 
 /* Return true if the "on-link" form of the route should=
 be used=2E  This is when the gateway for
  * a route is specified as an in=
terface rather than an address=2E */
-#if defined(TARGET_LINUX) || defined(=
_WIN32) || defined(TARGET_DARWIN)
+#if defined(ROUTE_NET_API) || defined(_W=
IN32) || defined(TARGET_DARWIN)
 static inline bool
 is_on_link(const struc=
t route_ipv4 *r, const unsigned int flags,
            const struct route_g=
ateway_info *rgi)
@@ -1459,7 +1464,7 @@
     struct argv argv =3D argv_new(=
);
     struct gc_arena gc =3D gc_new();
 
-#if !defined(TARGET_LINUX)
+#if=
 !defined(ROUTE_NET_API)
     const char *network =3D print_in_addr_t(r->ne=
twork, 0, &gc);
 #if !defined(TARGET_AIX)
     const char *netmask =3D prin=
t_in_addr_t(r->netmask, 0, &gc);
@@ -1468,7 +1473,7 @@
 #endif
 
 
-#if def=
ined(TARGET_LINUX)
+#if defined(ROUTE_NET_API)
     const char *iface =3D N=
ULL;
     int metric =3D -1;
 
@@ -1482,20 +1487,29 @@
         metric =3D =
r->metric;
     }
 
-
-    status =3D RTA_SUCCESS;
-    int ret =3D net_rou=
te_v4_add(ctx, &r->network, netmask_to_netbits2(r->netmask), &r->gateway,
-=
                               iface, r->table_id, metric);
-    if (ret =
=3D=3D -EEXIST)
+    const int netbits =3D netmask_to_netbits2(r->netmask);=

+    if (netbits < 0)
     {
-        msg(D_ROUTE, "NOTE: Linux route add =
command failed because route exists");
-        status =3D RTA_EEXIST;
-   =
 }
-    else if (ret < 0)
-    {
-        msg(M_WARN, "ERROR: Linux route a=
dd command failed");
+        msg(M_WARN, "ERROR: cannot add route with non=
-contiguous netmask %s",
+            print_in_addr_t(r->netmask, 0, &gc));=

         status =3D RTA_ERROR;
     }
+    else
+    {
+        status =3D=
 RTA_SUCCESS;
+        const int ret =3D net_route_v4_add(ctx, &r->network,=
 netbits, &r->gateway, iface,
+                                         r->=
table_id, metric);
+        if (ret =3D=3D -EEXIST)
+        {
+           =
 msg(D_ROUTE, "NOTE: route add command failed because route exists");
+    =
        status =3D RTA_EEXIST;
+        }
+        else if (ret < 0)
+     =
   {
+            msg(M_WARN, "ERROR: route add command failed");
+        =
    status =3D RTA_ERROR;
+        }
+    }
 
 #elif defined(TARGET_ANDROID=
)
     char out[128];
@@ -1597,44 +1611,6 @@
     bool ret =3D openvpn_exec=
ve_check(&argv, es, 0, "ERROR: Solaris route add command failed");
     sta=
tus =3D ret ? RTA_SUCCESS : RTA_ERROR;
 
-#elif defined(TARGET_FREEBSD)
-
-=
    argv_printf(&argv, "%s add", ROUTE_PATH);
-
-#if 0
-    if (r->flags & =
RT_METRIC_DEFINED)
-    {
-        argv_printf_cat(&argv, "-rtt %d", r->met=
ric);
-    }
-#endif
-
-    argv_printf_cat(&argv, "-net %s %s %s", network=
, gateway, netmask);
-
-    /* FIXME -- add on-link support for FreeBSD */
=
-
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&ar=
gv, es, 0, "ERROR: FreeBSD route add command failed");
-    status =3D ret =
? RTA_SUCCESS : RTA_ERROR;
-
-#elif defined(TARGET_DRAGONFLY)
-
-    argv_p=
rintf(&argv, "%s add", ROUTE_PATH);
-
-#if 0
-    if (r->flags & RT_METRIC_=
DEFINED)
-    {
-        argv_printf_cat(&argv, "-rtt %d", r->metric);
-   =
 }
-#endif
-
-    argv_printf_cat(&argv, "-net %s %s %s", network, gateway,=
 netmask);
-
-    /* FIXME -- add on-link support for Dragonfly */
-
-    a=
rgv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&argv, es, =
0, "ERROR: DragonFly route add command failed");
-    status =3D ret ? RTA_=
SUCCESS : RTA_ERROR;
-
 #elif defined(TARGET_DARWIN)
 
     argv_printf(&ar=
gv, "%s add", ROUTE_PATH);
@@ -1700,10 +1676,10 @@
     bool ret =3D openvp=
n_execve_check(&argv, es, 0, "ERROR: Haiku inet route add command failed");=

     status =3D ret ? RTA_SUCCESS : RTA_ERROR;
 
-#else  /* if defined(TAR=
GET_LINUX) */
+#else  /* if defined(ROUTE_NET_API) */
     msg(M_FATAL,
   =
      "Sorry, but I don't know how to do 'route' commands on this operating=
 system=2E  Try putting your routes in a --route-up script");
-#endif /* if=
 defined(TARGET_LINUX) */
+#endif /* if defined(ROUTE_NET_API) */
 
     if=
 (status =3D=3D RTA_SUCCESS)
     {
@@ -1777,8 +1753,7 @@
     const char *=
network =3D print_in6_addr(r6->network, 0, &gc);
     const char *gateway =
=3D print_in6_addr(r6->gateway, 0, &gc);
 
-#if defined(TARGET_DARWIN) || d=
efined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) \
-    || defined(TARGE=
T_OPENBSD) || defined(TARGET_NETBSD)
+#if defined(TARGET_DARWIN) || defined=
(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
     /* the BSD platforms cann=
ot specify gateway and interface independently,
      * but for link-local =
destinations, we MUST specify the interface, so
@@ -1830,7 +1805,7 @@
     =
    goto done;
     }
 
-#if defined(TARGET_LINUX)
+#if defined(ROUTE_NET_A=
PI)
     int metric =3D -1;
     if ((r6->flags & RT_METRIC_DEFINED) && (r6=
->metric > 0))
     {
@@ -1842,12 +1817,12 @@
                             =
   device, r6->table_id, metric);
     if (ret =3D=3D -EEXIST)
     {
-    =
    msg(D_ROUTE, "NOTE: Linux route add command failed because route exists=
");
+        msg(D_ROUTE, "NOTE: route add command failed because route exi=
sts");
         status =3D RTA_EEXIST;
     }
     else if (ret < 0)
     {=

-        msg(M_WARN, "ERROR: Linux route add command failed");
+        ms=
g(M_WARN, "ERROR: route add command failed");
         status =3D RTA_ERROR=
;
     }
 
@@ -1893,23 +1868,6 @@
     bool ret =3D openvpn_execve_check(&a=
rgv, es, 0, "ERROR: Solaris route add -inet6 command failed");
     status =
=3D ret ? RTA_SUCCESS : RTA_ERROR;
 
-#elif defined(TARGET_FREEBSD) || defi=
ned(TARGET_DRAGONFLY)
-
-    argv_printf(&argv, "%s add -inet6 %s/%d", ROUT=
E_PATH, network, r6->netbits);
-
-    if (gateway_needed)
-    {
-        a=
rgv_printf_cat(&argv, "%s", gateway);
-    }
-    else
-    {
-        argv=
_printf_cat(&argv, "-iface %s", device);
-    }
-
-    argv_msg(D_ROUTE, &a=
rgv);
-    bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: *BSD rou=
te add -inet6 command failed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERR=
OR;
-
 #elif defined(TARGET_DARWIN)
 
     argv_printf(&argv, "%s add -inet=
6 %s -prefixlen %d", ROUTE_PATH, network, r6->netbits);
@@ -1960,10 +1918,1=
0 @@
     bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: Haiku ine=
t6 route add command failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERRO=
R;
 
-#else  /* if defined(TARGET_LINUX) */
+#else  /* if defined(ROUTE_NET=
_API) */
     msg(M_FATAL,
         "Sorry, but I don't know how to do 'rou=
te ipv6' commands on this operating system=2E  Try putting your routes in a=
 --route-up script");
-#endif /* if defined(TARGET_LINUX) */
+#endif /* if =
defined(ROUTE_NET_API) */
 
 done:
     if (status =3D=3D RTA_SUCCESS)
@@ -=
1986,13 +1944,13 @@
 delete_route(struct route_ipv4 *r, const struct tuntap=
 *tt, unsigned int flags,
              const struct route_gateway_info *rg=
i, const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
-#if !defined(TARGE=
T_LINUX)
+#if !defined(ROUTE_NET_API)
     const char *network;
 #if !defin=
ed(TARGET_AIX)
     const char *netmask;
 #endif
     const char *gateway;
=
-#else /* if !defined(TARGET_LINUX) */
+#else /* if !defined(ROUTE_NET_API)=
 */
     int metric;
 #endif
 
@@ -2004,7 +1962,7 @@
     struct gc_arena g=
c =3D gc_new();
     struct argv argv =3D argv_new();
 
-#if !defined(TARGE=
T_LINUX)
+#if !defined(ROUTE_NET_API)
     network =3D print_in_addr_t(r->n=
etwork, 0, &gc);
 #if !defined(TARGET_AIX)
     netmask =3D print_in_addr_t=
(r->netmask, 0, &gc);
@@ -2013,7 +1971,7 @@
 #endif
 
 
-#if defined(TARGET=
_LINUX)
+#if defined(ROUTE_NET_API)
     metric =3D -1;
     if (r->flags &=
 RT_METRIC_DEFINED)
     {
@@ -2024,7 +1982,7 @@
                          =
r->table_id, metric)
         < 0)
     {
-        msg(M_WARN, "ERROR: Linu=
x route delete command failed");
+        msg(M_WARN, "ERROR: route delete =
command failed");
     }
 #elif defined(_WIN32)
 
@@ -2074,20 +2032,6 @@
  =
   argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR=
: Solaris route delete command failed");
 
-#elif defined(TARGET_FREEBSD)
-=

-    argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network, ga=
teway, netmask);
-
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check=
(&argv, es, 0, "ERROR: FreeBSD route delete command failed");
-
-#elif defi=
ned(TARGET_DRAGONFLY)
-
-    argv_printf(&argv, "%s delete -net %s %s %s", =
ROUTE_PATH, network, gateway, netmask);
-
-    argv_msg(D_ROUTE, &argv);
- =
   openvpn_execve_check(&argv, es, 0, "ERROR: DragonFly route delete comman=
d failed");
-
 #elif defined(TARGET_DARWIN)
 
     if (is_on_link(r, flags,=
 rgi))
@@ -2135,10 +2079,10 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_=
execve_check(&argv, es, 0, "ERROR: Haiku inet route delete command failed")=
;
 
-#else  /* if defined(TARGET_LINUX) */
+#else  /* if defined(ROUTE_NET_=
API) */
     msg(M_FATAL,
         "Sorry, but I don't know how to do 'rout=
e' commands on this operating system=2E  Try putting your routes in a --rou=
te-up script");
-#endif /* if defined(TARGET_LINUX) */
+#endif /* if define=
d(ROUTE_NET_API) */
 
     r->flags &=3D ~RT_ADDED;
     argv_free(&argv);
=
@@ -2159,7 +2103,7 @@
     }
 
 #if !defined(_WIN32)
-#if !defined(TARGET_L=
INUX)
+#if !defined(ROUTE_NET_API)
     const char *gateway;
 #endif
 #if !=
defined(TARGET_SOLARIS)
@@ -2186,12 +2130,11 @@
     struct argv argv =3D a=
rgv_new();
 
     network =3D print_in6_addr(r6->network, 0, &gc);
-#if !de=
fined(TARGET_LINUX) && !defined(_WIN32)
+#if !defined(ROUTE_NET_API) && !de=
fined(_WIN32)
     gateway =3D print_in6_addr(r6->gateway, 0, &gc);
 #endif=

 
-#if defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) || defined(TARGET=
_DRAGONFLY) \
-    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+#i=
f defined(TARGET_DARWIN) || defined(TARGET_OPENBSD) || defined(TARGET_NETBS=
D)
 
     /* the BSD platforms cannot specify gateway and interface indepen=
dently,
      * but for link-local destinations, we MUST specify the interf=
ace, so
@@ -2209,7 +2152,7 @@
 
     msg(D_ROUTE, "delete_route_ipv6(%s/%u)=
", network, r6->netbits);
 
-#if defined(TARGET_LINUX)
+#if defined(ROUTE_N=
ET_API)
     int metric =3D -1;
     if ((r6->flags & RT_METRIC_DEFINED) &&=
 (r6->metric > 0))
     {
@@ -2220,7 +2163,7 @@
                          d=
evice, r6->table_id, metric)
         < 0)
     {
-        msg(M_WARN, "ERR=
OR: Linux route v6 delete command failed");
+        msg(M_WARN, "ERROR: ro=
ute v6 delete command failed");
     }
 
 #elif defined(_WIN32)
@@ -2242,22=
 +2185,6 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv,=
 es, 0, "ERROR: Solaris route delete -inet6 command failed");
 
-#elif defi=
ned(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
-
-    argv_printf(&argv, =
"%s delete -inet6 %s/%d", ROUTE_PATH, network, r6->netbits);
-
-    if (gat=
eway_needed)
-    {
-        argv_printf_cat(&argv, "%s", gateway);
-    }
=
-    else
-    {
-        argv_printf_cat(&argv, "-iface %s", device);
-   =
 }
-
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0,=
 "ERROR: *BSD route delete -inet6 command failed");
-
 #elif defined(TARGET=
_DARWIN)
 
     argv_printf(&argv, "%s delete -inet6 %s -prefixlen %d", ROU=
TE_PATH, network, r6->netbits);
@@ -2310,10 +2237,10 @@
     argv_msg(D_ROU=
TE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet6 rou=
te delete command failed");
 
-#else  /* if defined(TARGET_LINUX) */
+#else=
  /* if defined(ROUTE_NET_API) */
     msg(M_FATAL,
         "Sorry, but I =
don't know how to do 'route ipv6' commands on this operating system=2E  Try=
 putting your routes in a --route-down script");
-#endif /* if defined(TARG=
ET_LINUX) */
+#endif /* if defined(ROUTE_NET_API) */
 
     argv_free(&argv=
);
     gc_free(&gc);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2154?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I601454a511c9aac4f37d8629b1692266cdbd6885
Gerrit-Change-Number: 2154=

Gerrit-PatchSet: 6
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ed=
e>

--KUmbqs+S9TY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>R=C4=83zvan Coj=
ocaru <strong>uploaded patch set #6</strong> to this change=2E</p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">route: use the net_ API for routes on FreeBSD and D=
ragonFly<br><br>Add and delete IPv4 and IPv6 routes through net_route_v4/v6=
_add/del()<br>on FreeBSD and DragonFly, as on Linux, instead of running rou=
te(8)<br>from route=2Ec=2E Build networking_freebsd=2Ec for DragonFly as we=
ll; -fib<br>is only passed on FreeBSD, where --route-table is now supported=
=2E<br><br>A non-contiguous IPv4 netmask now gets an error instead of an in=
valid<br>prefix length=2E networking_freebsd=2Ec logs route commands at D_R=
OUTE, as<br>route=2Ec did=2E The shared error messages lose their &quot;Lin=
ux&quot; prefix=2E<br><br>Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6=
885<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<=
br>M doc/man-sections/vpn-network-options=2Erst<br>M src/openvpn/networking=
=2Eh<br>M src/openvpn/networking_freebsd=2Ec<br>M src/openvpn/options=2Ec<b=
r>M src/openvpn/route=2Ec<br>5 files changed, 71 insertions(+), 136 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/54/2154/6</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/vpn-=
network-options=2Erst b/doc/man-sections/vpn-network-options=2Erst</span><b=
r><span>index 960c6ad=2E=2Ef282982 100644</span><br><span>--- a/doc/man-sec=
tions/vpn-network-options=2Erst</span><br><span>+++ b/doc/man-sections/vpn-=
network-options=2Erst</span><br><span>@@ -399,7 +399,10 @@</span><br><span>=
   table of the operating system, but with this option,</span><br><span>   =
a user defined routing table can be used instead=2E</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  (Supported on Linux only,=
 on other platforms this is a no-op)=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  On FreeBSD, the table id is the FIB number=2E Without=
 this option, routes</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  go to the FIB OpenVPN runs in (see :code:`setfib(1)`)=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  (Supported on Linux and FreeBSD only, on other platf=
orms this is a no-op)=2E</span><br><span> </span><br><span> --route args</s=
pan><br><span>   Add route to routing table after connection is established=
=2E Multiple</span><br><span>diff --git a/src/openvpn/networking=2Eh b/src/=
openvpn/networking=2Eh</span><br><span>index 1763e64=2E=2Ecbb10ed 100644</s=
pan><br><span>--- a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/op=
envpn/networking=2Eh</span><br><span>@@ -30,7 +30,7 @@</span><br><span> #in=
clude &quot;networking_sitnl=2Eh&quot;</span><br><span> #elif ENABLE_IPROUT=
E</span><br><span> #include &quot;networking_iproute2=2Eh&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_FR=
EEBSD) || defined(TARGET_DRAGONFLY)</span><br><span> typedef void *openvpn_=
net_ctx_t;</span><br><span> typedef char openvpn_net_iface_t;</span><br><sp=
an> #else  /* ifdef ENABLE_SITNL */</span><br><span>@@ -236,7 +236,8 @@</sp=
an><br><span> </span><br><span> #endif /* ENABLE_SITNL || ENABLE_IPROUTE */=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE) || defined(TARGET_FREEBSD=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE=
_SITNL) || defined(ENABLE_IPROUTE) || defined(TARGET_FREEBSD) \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    || defined(TARGET_DRAGONFLY=
)</span><br><span> /**</span><br><span>  * Add a route for an IPv4 address/=
network</span><br><span>  *</span><br><span>@@ -305,7 +306,7 @@</span><br><=
span>                      const struct in6_addr *gw, const openvpn_net_ifa=
ce_t *iface, int table,</span><br><span>                      int metric);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_SITNL || ENABLE_IPRO=
UTE || TARGET_FREEBSD || TARGET_DRAGONFLY */</span><br><span> </span><br><s=
pan> #if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)</span><br><span> =
</span><br><span>diff --git a/src/openvpn/networking_freebsd=2Ec b/src/open=
vpn/networking_freebsd=2Ec</span><br><span>index 141f4bd=2E=2Eeba8866 10064=
4</span><br><span>--- a/src/openvpn/networking_freebsd=2Ec</span><br><span>=
+++ b/src/openvpn/networking_freebsd=2Ec</span><br><span>@@ -6,7 +6,7 @@</s=
pan><br><span> #include &quot;run_command=2Eh&quot;</span><br><span> #inclu=
de &quot;networking=2Eh&quot;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(TARGET_FREEBSD)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_FREEBSD) || defined(TA=
RGET_DRAGONFLY)</span><br><span> </span><br><span> static int</span><br><sp=
an> net_route_v4(const char *op, const in_addr_t *dst, int prefixlen, const=
 in_addr_t *gw,</span><br><span>@@ -35,14 +35,16 @@</span><br><span>     {<=
/span><br><span>         argv_printf_cat(&amp;argv, &quot;-iface %s&quot;, =
iface);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(TARGET_FREEBSD) /* DragonFly has no multiple FIB sup=
port */</span><br><span>     /* without -fib, route(8) uses the FIB of the =
process */</span><br><span>     if (table &gt;=3D 0)</span><br><span>     {=
</span><br><span>         argv_printf_cat(&amp;argv, &quot;-fib %d&quot;, t=
able);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    bool status =3D openvpn_execve_check(&amp;argv,=
 NULL, 0, &quot;ERROR: FreeBSD route command failed&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    argv_msg(D_ROUTE, &amp;argv);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const bool status=
 =3D openvpn_execve_check(&amp;argv, NULL, 0, &quot;ERROR: route command fa=
iled&quot;);</span><br><span> </span><br><span>     argv_free(&amp;argv);</=
span><br><span> </span><br><span>@@ -77,13 +79,15 @@</span><br><span>     {=
</span><br><span>         argv_printf_cat(&amp;argv, &quot;-iface %s&quot;,=
 iface);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(TARGET_FREEBSD) /* DragonFly has no multiple FIB su=
pport */</span><br><span>     if (table &gt;=3D 0)</span><br><span>     {</=
span><br><span>         argv_printf_cat(&amp;argv, &quot;-fib %d&quot;, tab=
le);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    bool status =3D openvpn_execve_check(&amp;argv, N=
ULL, 0, &quot;ERROR: FreeBSD route command failed&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    argv_msg(D_ROUTE, &amp;argv);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const bool status =
=3D openvpn_execve_check(&amp;argv, NULL, 0, &quot;ERROR: route command fai=
led&quot;);</span><br><span> </span><br><span>     argv_free(&amp;argv);</s=
pan><br><span> </span><br><span>@@ -118,4 +122,4 @@</span><br><span>     re=
turn net_route_v6(&quot;delete&quot;, dst, prefixlen, gw, iface, table, met=
ric);</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif /* if defined(TARGET_FREEBSD) */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET_FREEBS=
D) || defined(TARGET_DRAGONFLY) */</span><br><span>diff --git a/src/openvpn=
/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 35fbe39=2E=2E8=
150a16 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span=
>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -226,7 +226,7 @@</span><b=
r><span>     &quot;                    pass --ifconfig parms by environment=
 to scripts=2E\n&quot;</span><br><span>     &quot;--ifconfig-nowarn : Don&#=
39;t warn if the --ifconfig option on this side of the\n&quot;</span><br><s=
pan>     &quot;                    connection doesn&#39;t match the remote =
side=2E\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 TARGET_LINUX</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span>     &quot;-=
-route-table table_id : Specify a custom routing table for use with --route=
(-ipv6)=2E\n&quot;</span><br><span>     &quot;                           If=
 not specified, the id of the default routing table will be used=2E\n&quot;=
</span><br><span> #endif</span><br><span>@@ -5293,8 +5293,8 @@</span><br><s=
pan>     }</span><br><span>     else if (streq(p[0], &quot;route-table&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SITNL</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;NOTE: --rout=
e-table is supported only on Linux when SITNL is built-in&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ENABLE_SITNL) &a=
mp;&amp; !defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(M_WARN, &quot;NOTE: --route-table is supported on=
ly on FreeBSD, and on Linux when SITNL is built-in&quot;);</span><br><span>=
 #endif</span><br><span>         VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);</spa=
n><br><span>         if (!atoi_constrained(p[1], &amp;options-&gt;route_def=
ault_table_id, p[0], 0, INT_MAX,</span><br><span>diff --git a/src/openvpn/r=
oute=2Ec b/src/openvpn/route=2Ec</span><br><span>index 8c493ee=2E=2E0149bb5=
 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/s=
rc/openvpn/route=2Ec</span><br><span>@@ -103,6 +103,11 @@</span><br><span> =
#define RTA_SUCCESS 1 /* route addition succeeded */</span><br><span> #defi=
ne RTA_EEXIST  2 /* route not added as it already exists */</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Platforms that=
 add and delete routes through the net_ API (networking=2Eh) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || de=
fined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define ROUTE_NET_API</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> #ifndef TARGET_ANDROID</span><br><sp=
an> static bool</span><br><span> add_bypass_address(struct route_bypass *rb=
, const in_addr_t a)</span><br><span>@@ -1433,7 +1438,7 @@</span><br><span>=
 </span><br><span> /* Return true if the &quot;on-link&quot; form of the ro=
ute should be used=2E  This is when the gateway for</span><br><span>  * a r=
oute is specified as an interface rather than an address=2E */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) || defin=
ed(_WIN32) || defined(TARGET_DARWIN)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if defined(ROUTE_NET_API) || defined(_WIN32) || defined(T=
ARGET_DARWIN)</span><br><span> static inline bool</span><br><span> is_on_li=
nk(const struct route_ipv4 *r, const unsigned int flags,</span><br><span>  =
          const struct route_gateway_info *rgi)</span><br><span>@@ -1459,7 =
+1464,7 @@</span><br><span>     struct argv argv =3D argv_new();</span><br>=
<span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ROUTE_NET_API)<=
/span><br><span>     const char *network =3D print_in_addr_t(r-&gt;network,=
 0, &amp;gc);</span><br><span> #if !defined(TARGET_AIX)</span><br><span>   =
  const char *netmask =3D print_in_addr_t(r-&gt;netmask, 0, &amp;gc);</span=
><br><span>@@ -1468,7 +1473,7 @@</span><br><span> #endif</span><br><span> <=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(ROUTE_NET_API)</span><br><span>     const char *iface =3D NUL=
L;</span><br><span>     int metric =3D -1;</span><br><span> </span><br><spa=
n>@@ -1482,20 +1487,29 @@</span><br><span>         metric =3D r-&gt;metric;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   status =3D RTA_SUCCESS;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int ret =3D net_route_v4_add(ctx, &amp;r-&gt;network, netmask_to_n=
etbits2(r-&gt;netmask), &amp;r-&gt;gateway,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                               iface, r-&gt;table_id,=
 metric);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ret =
=3D=3D -EEXIST)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const int netbits =3D netmask_to_netbits2(r-&gt;netmask);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (netbits &lt; 0)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
D_ROUTE, &quot;NOTE: Linux route add command failed because route exists&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =
=3D RTA_EEXIST;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (ret &lt; =
0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;ERROR: Li=
nux route add command failed&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(M_WARN, &quot;ERROR: cannot add route with non=
-contiguous netmask %s&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            print_in_addr_t(r-&gt;netmask, 0, &amp;gc));</span><b=
r><span>         status =3D RTA_ERROR;</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        status =3D RTA_SUCCESS;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        const int ret =3D net_route_v4_add(ctx=
, &amp;r-&gt;network, netbits, &amp;r-&gt;gateway, iface,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
    r-&gt;table_id, metric);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (ret =3D=3D -EEXIST)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(D_ROUTE, &quot;NOTE: route add command failed be=
cause route exists&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            status =3D RTA_EEXIST;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else if (ret &lt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(M_WARN, &quot;ERROR: route add command failed&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            st=
atus =3D RTA_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span> </span><br><span> #elif defined(TARGET_ANDROID)</span><br><spa=
n>     char out[128];</span><br><span>@@ -1597,44 +1611,6 @@</span><br><spa=
n>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Sol=
aris route add command failed&quot;);</span><br><span>     status =3D ret ?=
 RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    argv_printf(&amp;argv, &quot;%s add&quot;, ROUTE_PATH);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;-rtt %d&quot;, =
r-&gt;metric);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, n=
etwork, gateway, netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- =
add on-link support for FreeBSD */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv=
_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Fr=
eeBSD route add command failed&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#elif defined(TARGET_DRAGONFLY)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    argv_printf(&amp;argv, &quot;%s add&quot;, ROUTE_PATH);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;-rtt %d&quot;, =
r-&gt;metric);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, n=
etwork, gateway, netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- =
add on-link support for Dragonfly */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ar=
gv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: =
DragonFly route add command failed&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif define=
d(TARGET_DARWIN)</span><br><span> </span><br><span>     argv_printf(&amp;ar=
gv, &quot;%s add&quot;, ROUTE_PATH);</span><br><span>@@ -1700,10 +1676,10 @=
@</span><br><span>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0, =
&quot;ERROR: Haiku inet route add command failed&quot;);</span><br><span>  =
   status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(TARGET_LINUX)=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if def=
ined(ROUTE_NET_API) */</span><br><span>     msg(M_FATAL,</span><br><span>  =
       &quot;Sorry, but I don&#39;t know how to do &#39;route&#39; commands=
 on this operating system=2E  Try putting your routes in a --route-up scrip=
t&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if=
 defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif /* if defined(ROUTE_NET_API) */</span><br><span> </span><br><s=
pan>     if (status =3D=3D RTA_SUCCESS)</span><br><span>     {</span><br><s=
pan>@@ -1777,8 +1753,7 @@</span><br><span>     const char *network =3D prin=
t_in6_addr(r6-&gt;network, 0, &amp;gc);</span><br><span>     const char *ga=
teway =3D print_in6_addr(r6-&gt;gateway, 0, &amp;gc);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_DARWIN=
) || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    || defined(TARGET_OPENBSD) || def=
ined(TARGET_NETBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(TARGET_DARWIN) || defined(TARGET_OPENBSD) || defined(TARGET_NET=
BSD)</span><br><span> </span><br><span>     /* the BSD platforms cannot spe=
cify gateway and interface independently,</span><br><span>      * but for l=
ink-local destinations, we MUST specify the interface, so</span><br><span>@=
@ -1830,7 +1805,7 @@</span><br><span>         goto done;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(ROUTE_NET_API)</span><br><span>     int metric =3D -1;</=
span><br><span>     if ((r6-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp; (=
r6-&gt;metric &gt; 0))</span><br><span>     {</span><br><span>@@ -1842,12 +=
1817,12 @@</span><br><span>                                device, r6-&gt;t=
able_id, metric);</span><br><span>     if (ret =3D=3D -EEXIST)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(D_ROUTE, &quot;NOTE: Linux route add command failed because route exists&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D=
_ROUTE, &quot;NOTE: route add command failed because route exists&quot;);</=
span><br><span>         status =3D RTA_EEXIST;</span><br><span>     }</span=
><br><span>     else if (ret &lt; 0)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;ERROR: Linu=
x route add command failed&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(M_WARN, &quot;ERROR: route add command failed&qu=
ot;);</span><br><span>         status =3D RTA_ERROR;</span><br><span>     }=
</span><br><span> </span><br><span>@@ -1893,23 +1868,6 @@</span><br><span> =
    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Solari=
s route add -inet6 command failed&quot;);</span><br><span>     status =3D r=
et ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD) || defined(TARGET_D=
RAGONFLY)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;=
%s add -inet6 %s/%d&quot;, ROUTE_PATH, network, r6-&gt;netbits);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (gateway_needed)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        argv_printf_cat(&amp;argv, &quot;%s&quot;, gateway);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        argv_printf_cat(&amp;argv, &quot;-iface %s&quot;, device);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    bool ret =3D openvpn_execve_check(&amp;argv, es,=
 0, &quot;ERROR: *BSD route add -inet6 command failed&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : =
RTA_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> #elif defined(TARGET_DARWIN)</span><br><span> </span><br><span>     =
argv_printf(&amp;argv, &quot;%s add -inet6 %s -prefixlen %d&quot;, ROUTE_PA=
TH, network, r6-&gt;netbits);</span><br><span>@@ -1960,10 +1918,10 @@</span=
><br><span>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;E=
RROR: Haiku inet6 route add command failed&quot;);</span><br><span>     sta=
tus =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(TARGET_LINUX) */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if defined(R=
OUTE_NET_API) */</span><br><span>     msg(M_FATAL,</span><br><span>        =
 &quot;Sorry, but I don&#39;t know how to do &#39;route ipv6&#39; commands =
on this operating system=2E  Try putting your routes in a --route-up script=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if =
defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif /* if defined(ROUTE_NET_API) */</span><br><span> </span><br><sp=
an> done:</span><br><span>     if (status =3D=3D RTA_SUCCESS)</span><br><sp=
an>@@ -1986,13 +1944,13 @@</span><br><span> delete_route(struct route_ipv4 =
*r, const struct tuntap *tt, unsigned int flags,</span><br><span>          =
    const struct route_gateway_info *rgi, const struct env_set *es, openvpn=
_net_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if !defined(TARGET_LINUX)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if !defined(ROUTE_NET_API)</span><br><span>     const=
 char *network;</span><br><span> #if !defined(TARGET_AIX)</span><br><span> =
    const char *netmask;</span><br><span> #endif</span><br><span>     const=
 char *gateway;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else =
/* if !defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#else /* if !defined(ROUTE_NET_API) */</span><br><span>     int=
 metric;</span><br><span> #endif</span><br><span> </span><br><span>@@ -2004=
,7 +1962,7 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><=
br><span>     struct argv argv =3D argv_new();</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ROUTE_NET_AP=
I)</span><br><span>     network =3D print_in_addr_t(r-&gt;network, 0, &amp;=
gc);</span><br><span> #if !defined(TARGET_AIX)</span><br><span>     netmask=
 =3D print_in_addr_t(r-&gt;netmask, 0, &amp;gc);</span><br><span>@@ -2013,7=
 +1971,7 @@</span><br><span> #endif</span><br><span> </span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ROUTE_N=
ET_API)</span><br><span>     metric =3D -1;</span><br><span>     if (r-&gt;=
flags &amp; RT_METRIC_DEFINED)</span><br><span>     {</span><br><span>@@ -2=
024,7 +1982,7 @@</span><br><span>                          r-&gt;table_id, =
metric)</span><br><span>         &lt; 0)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;ERROR: =
Linux route delete command failed&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(M_WARN, &quot;ERROR: route delete command=
 failed&quot;);</span><br><span>     }</span><br><span> #elif defined(_WIN3=
2)</span><br><span> </span><br><span>@@ -2074,20 +2032,6 @@</span><br><span=
>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_che=
ck(&amp;argv, es, 0, &quot;ERROR: Solaris route delete command failed&quot;=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
elif defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_print=
f(&amp;argv, &quot;%s delete -net %s %s %s&quot;, ROUTE_PATH, network, gate=
way, netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;a=
rgv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_exec=
ve_check(&amp;argv, es, 0, &quot;ERROR: FreeBSD route delete command failed=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_DRAGONFLY)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s delete =
-net %s %s %s&quot;, ROUTE_PATH, network, gateway, netmask);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, es, 0, =
&quot;ERROR: DragonFly route delete command failed&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif defined(TARGET=
_DARWIN)</span><br><span> </span><br><span>     if (is_on_link(r, flags, rg=
i))</span><br><span>@@ -2135,10 +2079,10 @@</span><br><span>     argv_msg(D=
_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_check(&amp;argv, es=
, 0, &quot;ERROR: Haiku inet route delete command failed&quot;);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if d=
efined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#else  /* if defined(ROUTE_NET_API) */</span><br><span>     msg(M_FATAL=
,</span><br><span>         &quot;Sorry, but I don&#39;t know how to do &#39=
;route&#39; commands on this operating system=2E  Try putting your routes i=
n a --route-up script&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif /* if defined(TARGET_LINUX) */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif /* if defined(ROUTE_NET_API) */</span><br>=
<span> </span><br><span>     r-&gt;flags &amp;=3D ~RT_ADDED;</span><br><spa=
n>     argv_free(&amp;argv);</span><br><span>@@ -2159,7 +2103,7 @@</span><b=
r><span>     }</span><br><span> </span><br><span> #if !defined(_WIN32)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ROUTE_=
NET_API)</span><br><span>     const char *gateway;</span><br><span> #endif<=
/span><br><span> #if !defined(TARGET_SOLARIS)</span><br><span>@@ -2186,12 +=
2130,11 @@</span><br><span>     struct argv argv =3D argv_new();</span><br>=
<span> </span><br><span>     network =3D print_in6_addr(r6-&gt;network, 0, =
&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined=
(TARGET_LINUX) &amp;&amp; !defined(_WIN32)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if !defined(ROUTE_NET_API) &amp;&amp; !defined(_WIN=
32)</span><br><span>     gateway =3D print_in6_addr(r6-&gt;gateway, 0, &amp=
;gc);</span><br><span> #endif</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(TARGET_DARWIN) || defined(TARGET_FREE=
BSD) || defined(TARGET_DRAGONFLY) \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_DARWI=
N) || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> </=
span><br><span>     /* the BSD platforms cannot specify gateway and interfa=
ce independently,</span><br><span>      * but for link-local destinations, =
we MUST specify the interface, so</span><br><span>@@ -2209,7 +2152,7 @@</sp=
an><br><span> </span><br><span>     msg(D_ROUTE, &quot;delete_route_ipv6(%s=
/%u)&quot;, network, r6-&gt;netbits);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if defined(ROUTE_NET_API)</span><b=
r><span>     int metric =3D -1;</span><br><span>     if ((r6-&gt;flags &amp=
; RT_METRIC_DEFINED) &amp;&amp; (r6-&gt;metric &gt; 0))</span><br><span>   =
  {</span><br><span>@@ -2220,7 +2163,7 @@</span><br><span>                 =
         device, r6-&gt;table_id, metric)</span><br><span>         &lt; 0)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        msg(M_WARN, &quot;ERROR: Linux route v6 delete command failed&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WA=
RN, &quot;ERROR: route v6 delete command failed&quot;);</span><br><span>   =
  }</span><br><span> </span><br><span> #elif defined(_WIN32)</span><br><spa=
n>@@ -2242,22 +2185,6 @@</span><br><span>     argv_msg(D_ROUTE, &amp;argv);=
</span><br><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: S=
olaris route delete -inet6 command failed&quot;);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)=
 || defined(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_prin=
tf(&amp;argv, &quot;%s delete -inet6 %s/%d&quot;, ROUTE_PATH, network, r6-&=
gt;netbits);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (gateway_needed)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;%s=
&quot;, gateway);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;-iface %=
s&quot;, device);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp=
;argv, es, 0, &quot;ERROR: *BSD route delete -inet6 command failed&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #eli=
f defined(TARGET_DARWIN)</span><br><span> </span><br><span>     argv_printf=
(&amp;argv, &quot;%s delete -inet6 %s -prefixlen %d&quot;, ROUTE_PATH, netw=
ork, r6-&gt;netbits);</span><br><span>@@ -2310,10 +2237,10 @@</span><br><sp=
an>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_c=
heck(&amp;argv, es, 0, &quot;ERROR: Haiku inet6 route delete command failed=
&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#else  /* if defined(TARGET_LINUX) */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#else  /* if defined(ROUTE_NET_API) */</span><br><sp=
an>     msg(M_FATAL,</span><br><span>         &quot;Sorry, but I don&#39;t =
know how to do &#39;route ipv6&#39; commands on this operating system=2E  T=
ry putting your routes in a --route-down script&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(TARGET_LINUX) */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(RO=
UTE_NET_API) */</span><br><span> </span><br><span>     argv_free(&amp;argv)=
;</span><br><span>     gc_free(&amp;gc);</span><br></pre><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154?usp=3Demail">cha=
nge 2154</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2154=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I601454a511c9aac4f37d8629b1692266cdbd6885 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2154 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--KUmbqs+S9TY=--


--===============3980322086333207287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3980322086333207287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3980322086333207287==--

