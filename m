Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D689606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZG4X99oX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Eq/lZUUk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cPr1Oby5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Vncs3bol
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PxWesm2vczkKJ6JRtbqVIUtjwAEIJFkIZiuX7+hKq+U=; b=ZG4X99oX2U+o9IUiJp1J0OrS6O
	0kZAM5Kni2zCvpYNWH4DyNm6GUDP/5Fpfge7BJQCG/D2p+HkI1G+4/ho/20pac54SKtCNTzyYVpxq
	zZ8EqzCpQcygl+EjKo8LEC7g3tBqCxSLAXatWmv4Cn59Io6EZQqGOvj5lSi76sRz0QNU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPIww-000000003Kh-3kNP;
	Fri, 06 Nov 2026 12:21:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPIwv-000000003KT-02Cq
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 12:21:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JuvT3s296UAv6VnFrmoFJdHzCcNKE8rlcHWNRnoWXWM=; b=Eq/lZUUkX+oxHBqxaYTt3aZkaG
 yCppd28Von6BbTcIbkJITwHyWJZmDV7uOk77gAZyv/Iz0dqVdJRjMdmJ8HY4AKF6MakD7dpgjHz67
 i+G6agkX7b16JvGLeZJQK4krznS9+ne31Vj4KnbzrVhaAdUBAkVc8MVBX5hfnEQWg3vI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JuvT3s296UAv6VnFrmoFJdHzCcNKE8rlcHWNRnoWXWM=; b=cPr1Oby5n7HlZUrn1rgDV1rsVW
 Wha/ThHypTcFitOW9h2RJJLgugxjyEvuFinmRNF4B3H4f65SLUiBhOtwjCv3NvIPE7JLWkcc2sLW+
 LzAJev9dmx9hBs6FS2bcpM+k8SJ232ESTx888KvrAYnaPRf+7U3/hXzq5hKjlBzECYM8=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPIwr-000000001wD-2h27 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 12:21:40 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so4707915e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 04:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793967691; x=1794572491; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JuvT3s296UAv6VnFrmoFJdHzCcNKE8rlcHWNRnoWXWM=;
 b=Vncs3bolkpgl5L1zIM04m8gQKgbpco6YHT3Mgz48R3a1vwOgAgUUSdpJei3si8p9Eh
 GXzIiz075SLCtgjU+dQ++NJV6ZkTwENH9tM3VJgineUy15xcG7ykGgJEDELe3saLkiXX
 b0YR399r3pOcMfWRQ2d+CyWFzgeqELJ54HdWAR3LsB0cKFgZnMS82v7iPiZ5v9vR6Pi5
 EdNovCMcE/mANoD7b+rdL1RDiUM2Orz5Fm8bDh4JboSOxz8ACaulWwqm2xyjXoAToWhc
 2JC/XodlhVh1mNX42hhZsAC2OdoIeZ6xqRq2CzR3hJuwnkD25/eMO3z3xpObyukqMStT
 Orrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793967691; x=1794572491;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JuvT3s296UAv6VnFrmoFJdHzCcNKE8rlcHWNRnoWXWM=;
 b=htPmrxHltGMJSFeC6hurFPhlFZrXyYmvUJ8jqvyhlXKncHWdYu47Uqy5xb97AHrtGM
 7sEwyfhJSYETTt7X1hXUp9SzDJjoqv67DDhe4ZK+4tHV+p09WTsJcOyp8VwlDYN2wNIy
 u9tQ5CumHMrmHx23N5pFNbiQ6Cmk6gtJHmHlf8ksp8Rpp5lNbWXa//PokQzrQEj3OBQ+
 +JcdLi24v33L2jrRESnc46qLGUeeAaK/5Ub7VjZ+hVMTdi1mjOV2FRT5YlZUfF9zSncg
 y9hYh+hGg4NFcC8OjRAzfErxLjiYeI0gnCGH5mOskaAch3whs05cx2ltfWUfindOVV+p
 AoAA==
X-Gm-Message-State: APuU4Z+wWVuju6c40Iq6iAYdE5olACWv1Mx2saYtBMqTMS3W4GQqqtMU
 KuEX/83J4cFfIg6oznYLSE6tlfK6ZxdQqCOiSFNzsAK8cz+3NW+5YU29pZe9upRW+TYw3Fkqcm7
 6cVy4hiKwqO41AAgDVTHblyiLAigoabPBlaJebEsmxreYmvjn48GSkzst28IfxvfBM4L5
X-Gm-Gg: AYBFou30WdONBCqe2fVOHLbIrDe1BeKM6kB3xBb+RiKlYD9jPaVzEKV9xQfgoW8E33Q
 0IAw/MJzonf4BKOx0oTrqlunr+l4ChI+GGUYis0CWs43Pq13bD8XzTvziVB9VUKsfksXjrw+YKQ
 Kx0mZfupsvgqDl1TuVuoMEFG0TNWV+LLOP7gPrc8b88r8Zw0W6yjKhRD2Q077RNRX30RnPho7VM
 NWmFu4EhPjD5qiuzmq27S9s5YMD5rkT54BhQ4Bgh+kzbIlOSXle/XSnsah42bZNhbzvkX3mC5ar
 w/wbGf0CR6sjGzPpY5Zqah8t7amG+JiaDnRtAhXi+m7Ea3kN/tJLeAYNizX5aFRvcsH5+s4HMw6
 udvj8JdDCAdHNlzQ+ASMF4CxKm4eBHH4hfC4KtT5Hj3rAgC+kVVyWCJZ4690hgfvH6uowItOGnf
 uqseMmNdSBdy7iyiI6HI/jzLkkikXkWQRMPl4+Vnj3pFzwF394VfHFai5R2WkKzePq7MPSVvSxS
 vO8/t23i/ycAgEjp1XIYC7eU1D/2MygIjtm7wEzE7XMOiHUQVgdAShKaqi4LTa3hCCM5RxONMk3
 gzZ5S6yI4T1E5XzyNKN0ptP6v58Sl8MSVXGSKlubrthHlxI3J2+SMr77ZPBJcneArJEwY2SsviR
 5c75X9GZ4X3o7HBA9ZfJKCPgVJK/J5C3bGIt/qxilwUJ9IHCtcM4gywFES6G0Vz/1KDYqXVzV+i
 4ppP8epSNXPaEKcQ==
X-Received: by 2002:a05:600c:1c08:b0:4a5:5fb9:5d35 with SMTP id
 5b1f17b1804b1-4b6df5eac1amr44191365e9.21.1793967690754; 
 Fri, 06 Nov 2026 04:21:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e58fcb8sm131590915e9.1.2026.11.06.04.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 04:21:30 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 12:21:28 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
X-Gerrit-Change-Number: 2105
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2105?usp=email>
X-Gerrit-Commit: 4079ffb801003e9bb3f66c653d62b32836fece4c
In-Reply-To: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
References: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk0OTRhNDI3OTI0ZWE1MDEzODIyNzVlYTk2ZWY4NWE2YWJjZDc4MGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <14cc9fdcb016b7c510ece06cdefebf8a87a95664-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPIwr-000000001wD-2h27
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Move gc from
 openvpn_net_ctx_t to local variables
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com,
 gert@greenie.muc.de
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8628784475119684584=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8628784475119684584==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HfKVJyRFOOk="; charset=UTF-8

--HfKVJyRFOOk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Gert=
 Doering, R=C4=83zvan Cojocaru=2E

Hello Antonio Quartulli, Gert Doering, R=
=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Please visit

=
    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail

to look at=
 the new patch set (#2)=2E

The following approvals got outdated and were r=
emoved:
Code-Review+2 by Antonio Quartulli, Code-Review+2 by R=C4=83zvan Co=
jocaru, Code-Review-1 by Gert Doering


Change subject: Move gc from openvp=
n_net_ctx_t to local variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Move gc from openvpn_net_ctx_t to local variables

All =
the iproute2 functions use the gc only to create local variables
and string=
s to ultimately pass to openvpn_execve_check=2E These do not
need to live l=
onger than the function that calls openvpn_execve_check=2E

Since argv alre=
ady has a gc and the variables are used for the
command construction with t=
hat argv, just use the gc of that local
argv=2E

Change-Id: I494a427924ea50=
1382275ea96ef85a6abcd780e5
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>=

---
M src/openvpn/networking_iproute2=2Ec
M src/openvpn/networking_iproute=
2=2Eh
2 files changed, 17 insertions(+), 20 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/05/2105/2

diff --git a/=
src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec
i=
ndex f091fb3=2E=2E7a0f4f7 100644
--- a/src/openvpn/networking_iproute2=2Ec
=
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -43,21 +43,19 @@
     {
      =
   ctx->es =3D c->es;
     }
-    ctx->gc =3D gc_new();
-
     return 0;
 }=

 
 void
 net_ctx_reset(openvpn_net_ctx_t *ctx)
 {
-    gc_reset(&ctx->gc);=

+    (void)ctx;
 }
 
 void
 net_ctx_free(openvpn_net_ctx_t *ctx)
 {
-    g=
c_free(&ctx->gc);
+    (void)ctx;
 }
 
 int
@@ -148,7 +146,7 @@
 {
     str=
uct argv argv =3D argv_new();
 
-    const char *addr_str =3D print_in_addr=
_t(*addr, 0, &ctx->gc);
+    const char *addr_str =3D print_in_addr_t(*addr=
, 0, &argv=2Egc);
 
     argv_printf(&argv, "%s addr add dev %s %s/%d broad=
cast +", iproute_path, iface, addr_str, prefixlen);
     argv_msg(M_INFO, &=
argv);
@@ -164,7 +162,7 @@
                 int prefixlen)
 {
     struct a=
rgv argv =3D argv_new();
-    char *addr_str =3D (char *)print_in6_addr(*ad=
dr, 0, &ctx->gc);
+    char *addr_str =3D (char *)print_in6_addr(*addr, 0, =
&argv=2Egc);
 
     argv_printf(&argv, "%s -6 addr add %s/%d dev %s", iprou=
te_path, addr_str, prefixlen, iface);
     argv_msg(M_INFO, &argv);
@@ -179=
,7 +177,7 @@
 net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface, co=
nst in_addr_t *addr, int prefixlen)
 {
     struct argv argv =3D argv_new()=
;
-    const char *addr_str =3D print_in_addr_t(*addr, 0, &ctx->gc);
+    c=
onst char *addr_str =3D print_in_addr_t(*addr, 0, &argv=2Egc);
 
     argv_=
printf(&argv, "%s addr del dev %s %s/%d", iproute_path, iface, addr_str, pr=
efixlen);
 
@@ -196,7 +194,7 @@
                 int prefixlen)
 {
     str=
uct argv argv =3D argv_new();
-    char *addr_str =3D (char *)print_in6_add=
r(*addr, 0, &ctx->gc);
+    char *addr_str =3D (char *)print_in6_addr(*addr=
, 0, &argv=2Egc);
 
     argv_printf(&argv, "%s -6 addr del %s/%d dev %s", =
iproute_path, addr_str, prefixlen, iface);
     argv_msg(M_INFO, &argv);
@@=
 -212,8 +210,8 @@
                     const in_addr_t *remote)
 {
     str=
uct argv argv =3D argv_new();
-    const char *local_str =3D print_in_addr_=
t(*local, 0, &ctx->gc);
-    const char *remote_str =3D print_in_addr_t(*re=
mote, 0, &ctx->gc);
+    const char *local_str =3D print_in_addr_t(*local, =
0, &argv=2Egc);
+    const char *remote_str =3D print_in_addr_t(*remote, 0,=
 &argv=2Egc);
 
     argv_printf(&argv, "%s addr add dev %s local %s peer %=
s", iproute_path, iface, local_str,
                 remote_str);
@@ -230,8=
 +228,8 @@
                     const in_addr_t *remote)
 {
     struct arg=
v argv =3D argv_new();
-    const char *local_str =3D print_in_addr_t(*loca=
l, 0, &ctx->gc);
-    const char *remote_str =3D print_in_addr_t(*remote, 0=
, &ctx->gc);
+    const char *local_str =3D print_in_addr_t(*local, 0, &arg=
v=2Egc);
+    const char *remote_str =3D print_in_addr_t(*remote, 0, &argv=
=2Egc);
 
     argv_printf(&argv, "%s addr del dev %s local %s peer %s", ip=
route_path, iface, local_str,
                 remote_str);
@@ -248,7 +246,=
7 @@
                  const char *iface, uint32_t table, int metric)
 {
  =
   struct argv argv =3D argv_new();
-    const char *dst_str =3D print_in_a=
ddr_t(*dst, 0, &ctx->gc);
+    const char *dst_str =3D print_in_addr_t(*dst=
, 0, &argv=2Egc);
     int ret =3D 0;
 
     argv_printf(&argv, "%s route a=
dd %s/%d", iproute_path, dst_str, prefixlen);
@@ -265,7 +263,7 @@
 
     if=
 (gw)
     {
-        const char *gw_str =3D print_in_addr_t(*gw, 0, &ctx->=
gc);
+        const char *gw_str =3D print_in_addr_t(*gw, 0, &argv=2Egc);
 =

         argv_printf_cat(&argv, "via %s", gw_str);
     }
@@ -286,14 +284,=
14 @@
                  const struct in6_addr *gw, const char *iface, uint3=
2_t table, int metric)
 {
     struct argv argv =3D argv_new();
-    char *=
dst_str =3D (char *)print_in6_addr(*dst, 0, &ctx->gc);
+    char *dst_str =
=3D (char *)print_in6_addr(*dst, 0, &argv=2Egc);
     int ret =3D 0;
 
    =
 argv_printf(&argv, "%s -6 route add %s/%d dev %s", iproute_path, dst_str, =
prefixlen, iface);
 
     if (gw)
     {
-        char *gw_str =3D (char *)=
print_in6_addr(*gw, 0, &ctx->gc);
+        char *gw_str =3D (char *)print_i=
n6_addr(*gw, 0, &argv=2Egc);
 
         argv_printf_cat(&argv, "via %s", gw=
_str);
     }
@@ -319,7 +317,7 @@
                  const char *iface, uint=
32_t table, int metric)
 {
     struct argv argv =3D argv_new();
-    const=
 char *dst_str =3D print_in_addr_t(*dst, 0, &ctx->gc);
+    const char *dst=
_str =3D print_in_addr_t(*dst, 0, &argv=2Egc);
     int ret =3D 0;
 
     a=
rgv_printf(&argv, "%s route del %s/%d", iproute_path, dst_str, prefixlen);
=
@@ -345,14 +343,14 @@
                  const struct in6_addr *gw, const ch=
ar *iface, uint32_t table, int metric)
 {
     struct argv argv =3D argv_ne=
w();
-    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &ctx->gc);
+   =
 char *dst_str =3D (char *)print_in6_addr(*dst, 0, &argv=2Egc);
     int re=
t =3D 0;
 
     argv_printf(&argv, "%s -6 route del %s/%d dev %s", iproute_=
path, dst_str, prefixlen, iface);
 
     if (gw)
     {
-        char *gw_s=
tr =3D (char *)print_in6_addr(*gw, 0, &ctx->gc);
+        char *gw_str =3D =
(char *)print_in6_addr(*gw, 0, &argv=2Egc);
 
         argv_printf_cat(&arg=
v, "via %s", gw_str);
     }
diff --git a/src/openvpn/networking_iproute2=
=2Eh b/src/openvpn/networking_iproute2=2Eh
index dd7d8b3=2E=2Edac5f0d 10064=
4
--- a/src/openvpn/networking_iproute2=2Eh
+++ b/src/openvpn/networking_ip=
route2=2Eh
@@ -28,7 +28,6 @@
 struct openvpn_net_ctx
 {
     struct env_set=
 *es;
-    struct gc_arena gc;
 };
 
 typedef struct openvpn_net_ctx openvp=
n_net_ctx_t;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2105?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4=
94a427924ea501382275ea96ef85a6abcd780e5
Gerrit-Change-Number: 2105
Gerrit-P=
atchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>

--HfKVJyRFOOk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Gert Doering, R=C4=
=83zvan Cojocaru=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #2</str=
ong> to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2105?usp=3Demail">View Change</a></p><p>The following approvals got=
 outdated and were removed:
Code-Review+2 by Antonio Quartulli, Code-Review=
+2 by R=C4=83zvan Cojocaru, Code-Review-1 by Gert Doering</p><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
Move gc from openvpn_net_ctx_t to local variables<br><br>All the iproute2 f=
unctions use the gc only to create local variables<br>and strings to ultima=
tely pass to openvpn_execve_check=2E These do not<br>need to live longer th=
an the function that calls openvpn_execve_check=2E<br><br>Since argv alread=
y has a gc and the variables are used for the<br>command construction with =
that argv, just use the gc of that local<br>argv=2E<br><br>Change-Id: I494a=
427924ea501382275ea96ef85a6abcd780e5<br>Signed-off-by: Arne Schwabe &lt;arn=
e@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/networking_iproute2=2Ec<br>M sr=
c/openvpn/networking_iproute2=2Eh<br>2 files changed, 17 insertions(+), 20 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/05/2105/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ne=
tworking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span=
>index f091fb3=2E=2E7a0f4f7 100644</span><br><span>--- a/src/openvpn/networ=
king_iproute2=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec=
</span><br><span>@@ -43,21 +43,19 @@</span><br><span>     {</span><br><span=
>         ctx-&gt;es =3D c-&gt;es;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     return 0;<=
/span><br><span> }</span><br><span> </span><br><span> void</span><br><span>=
 net_ctx_reset(openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    gc_reset(&amp;ctx-&gt;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    (void)ctx;</span><br><sp=
an> }</span><br><span> </span><br><span> void</span><br><span> net_ctx_free=
(openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    gc_free(&amp;ctx-&gt;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    (void)ctx;</span><br><span> }</span><=
br><span> </span><br><span> int</span><br><span>@@ -148,7 +146,7 @@</span><=
br><span> {</span><br><span>     struct argv argv =3D argv_new();</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const cha=
r *addr_str =3D print_in_addr_t(*addr, 0, &amp;ctx-&gt;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const char *addr_str =3D print_=
in_addr_t(*addr, 0, &amp;argv=2Egc);</span><br><span> </span><br><span>    =
 argv_printf(&amp;argv, &quot;%s addr add dev %s %s/%d broadcast +&quot;, i=
proute_path, iface, addr_str, prefixlen);</span><br><span>     argv_msg(M_I=
NFO, &amp;argv);</span><br><span>@@ -164,7 +162,7 @@</span><br><span>      =
           int prefixlen)</span><br><span> {</span><br><span>     struct ar=
gv argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    char *addr_str =3D (char *)print_in6_addr(*addr, 0, &amp;ctx-&gt;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *addr_str =
=3D (char *)print_in6_addr(*addr, 0, &amp;argv=2Egc);</span><br><span> </sp=
an><br><span>     argv_printf(&amp;argv, &quot;%s -6 addr add %s/%d dev %s&=
quot;, iproute_path, addr_str, prefixlen, iface);</span><br><span>     argv=
_msg(M_INFO, &amp;argv);</span><br><span>@@ -179,7 +177,7 @@</span><br><spa=
n> net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr=
_t *addr, int prefixlen)</span><br><span> {</span><br><span>     struct arg=
v argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    const char *addr_str =3D print_in_addr_t(*addr, 0, &amp;ctx-&gt;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *addr_=
str =3D print_in_addr_t(*addr, 0, &amp;argv=2Egc);</span><br><span> </span>=
<br><span>     argv_printf(&amp;argv, &quot;%s addr del dev %s %s/%d&quot;,=
 iproute_path, iface, addr_str, prefixlen);</span><br><span> </span><br><sp=
an>@@ -196,7 +194,7 @@</span><br><span>                 int prefixlen)</spa=
n><br><span> {</span><br><span>     struct argv argv =3D argv_new();</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    char *addr_str =3D (char=
 *)print_in6_addr(*addr, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    char *addr_str =3D (char *)print_in6_addr(*ad=
dr, 0, &amp;argv=2Egc);</span><br><span> </span><br><span>     argv_printf(=
&amp;argv, &quot;%s -6 addr del %s/%d dev %s&quot;, iproute_path, addr_str,=
 prefixlen, iface);</span><br><span>     argv_msg(M_INFO, &amp;argv);</span=
><br><span>@@ -212,8 +210,8 @@</span><br><span>                     const i=
n_addr_t *remote)</span><br><span> {</span><br><span>     struct argv argv =
=3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co=
nst char *local_str =3D print_in_addr_t(*local, 0, &amp;ctx-&gt;gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *remote_str =
=3D print_in_addr_t(*remote, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const char *local_str =3D print_in_addr_t=
(*local, 0, &amp;argv=2Egc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *remote_str =3D print_in_addr_t(*remote, 0, &amp;ar=
gv=2Egc);</span><br><span> </span><br><span>     argv_printf(&amp;argv, &qu=
ot;%s addr add dev %s local %s peer %s&quot;, iproute_path, iface, local_st=
r,</span><br><span>                 remote_str);</span><br><span>@@ -230,8 =
+228,8 @@</span><br><span>                     const in_addr_t *remote)</sp=
an><br><span> {</span><br><span>     struct argv argv =3D argv_new();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *local_str =
=3D print_in_addr_t(*local, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const char *remote_str =3D print_in_addr_t(*=
remote, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *local_str =3D print_in_addr_t(*local, 0, &amp;argv=
=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ch=
ar *remote_str =3D print_in_addr_t(*remote, 0, &amp;argv=2Egc);</span><br><=
span> </span><br><span>     argv_printf(&amp;argv, &quot;%s addr del dev %s=
 local %s peer %s&quot;, iproute_path, iface, local_str,</span><br><span>  =
               remote_str);</span><br><span>@@ -248,7 +246,7 @@</span><br><=
span>                  const char *iface, uint32_t table, int metric)</span=
><br><span> {</span><br><span>     struct argv argv =3D argv_new();</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *dst_str =3D p=
rint_in_addr_t(*dst, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *dst_str =3D print_in_addr_t(*dst, 0, =
&amp;argv=2Egc);</span><br><span>     int ret =3D 0;</span><br><span> </spa=
n><br><span>     argv_printf(&amp;argv, &quot;%s route add %s/%d&quot;, ipr=
oute_path, dst_str, prefixlen);</span><br><span>@@ -265,7 +263,7 @@</span><=
br><span> </span><br><span>     if (gw)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        const char *gw_str =3D pri=
nt_in_addr_t(*gw, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        const char *gw_str =3D print_in_addr_t(*gw, 0, &=
amp;argv=2Egc);</span><br><span> </span><br><span>         argv_printf_cat(=
&amp;argv, &quot;via %s&quot;, gw_str);</span><br><span>     }</span><br><s=
pan>@@ -286,14 +284,14 @@</span><br><span>                  const struct in=
6_addr *gw, const char *iface, uint32_t table, int metric)</span><br><span>=
 {</span><br><span>     struct argv argv =3D argv_new();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    char *dst_str =3D (char *)print_in6_=
addr(*dst, 0, &amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &amp;argv=
=2Egc);</span><br><span>     int ret =3D 0;</span><br><span> </span><br><sp=
an>     argv_printf(&amp;argv, &quot;%s -6 route add %s/%d dev %s&quot;, ip=
route_path, dst_str, prefixlen, iface);</span><br><span> </span><br><span> =
    if (gw)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        char *gw_str =3D (char *)print_in6_addr(*gw, 0, &amp;c=
tx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
char *gw_str =3D (char *)print_in6_addr(*gw, 0, &amp;argv=2Egc);</span><br>=
<span> </span><br><span>         argv_printf_cat(&amp;argv, &quot;via %s&qu=
ot;, gw_str);</span><br><span>     }</span><br><span>@@ -319,7 +317,7 @@</s=
pan><br><span>                  const char *iface, uint32_t table, int metr=
ic)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new()=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *dst_=
str =3D print_in_addr_t(*dst, 0, &amp;ctx-&gt;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *dst_str =3D print_in_addr_t(=
*dst, 0, &amp;argv=2Egc);</span><br><span>     int ret =3D 0;</span><br><sp=
an> </span><br><span>     argv_printf(&amp;argv, &quot;%s route del %s/%d&q=
uot;, iproute_path, dst_str, prefixlen);</span><br><span>@@ -345,14 +343,14=
 @@</span><br><span>                  const struct in6_addr *gw, const char=
 *iface, uint32_t table, int metric)</span><br><span> {</span><br><span>   =
  struct argv argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    char *dst_str =3D (char *)print_in6_addr(*dst, 0, &amp;ctx=
-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *=
dst_str =3D (char *)print_in6_addr(*dst, 0, &amp;argv=2Egc);</span><br><spa=
n>     int ret =3D 0;</span><br><span> </span><br><span>     argv_printf(&a=
mp;argv, &quot;%s -6 route del %s/%d dev %s&quot;, iproute_path, dst_str, p=
refixlen, iface);</span><br><span> </span><br><span>     if (gw)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
har *gw_str =3D (char *)print_in6_addr(*gw, 0, &amp;ctx-&gt;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        char *gw_str =3D (char=
 *)print_in6_addr(*gw, 0, &amp;argv=2Egc);</span><br><span> </span><br><spa=
n>         argv_printf_cat(&amp;argv, &quot;via %s&quot;, gw_str);</span><b=
r><span>     }</span><br><span>diff --git a/src/openvpn/networking_iproute2=
=2Eh b/src/openvpn/networking_iproute2=2Eh</span><br><span>index dd7d8b3=2E=
=2Edac5f0d 100644</span><br><span>--- a/src/openvpn/networking_iproute2=2Eh=
</span><br><span>+++ b/src/openvpn/networking_iproute2=2Eh</span><br><span>=
@@ -28,7 +28,6 @@</span><br><span> struct openvpn_net_ctx</span><br><span> =
{</span><br><span>     struct env_set *es;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct gc_arena gc;</span><br><span> };</span><br>=
<span> </span><br><span> typedef struct openvpn_net_ctx openvpn_net_ctx_t;<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2105?usp=3Demail">change 2105</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I494a427924ea501382275ea96ef85a=
6abcd780e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2105 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"=
display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &l=
t;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>

</body></html>
--HfKVJyRFOOk=--


--===============8628784475119684584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8628784475119684584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8628784475119684584==--

