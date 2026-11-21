Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C74606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JWrLsHZR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KNlfUHeR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SW9DXFEZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V5xn51NU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zTrKtUlSkdzmv9sI53cJ2DspLpFZtyORa0/6UC6fG2Q=; b=JWrLsHZRn4eZhGnWJE9jZv954q
	veZiITb1vS1G5LN1EXmalktzx307dJQRKI5+AlrOHihNQ8CKp9yngJeBOdzcG4sEc+mfmVTJWqnLj
	2z8I3eBkqLddMHynRWKUIJMmjUQEa7UV20dsvaXK+tpDZDZ5fBVEqqQRg8WH65on+aCI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUnby-000000005Zd-1KIO;
	Sat, 21 Nov 2026 16:06:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUnbx-000000005ZX-0k3H
 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 16:06:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IFOmFw3ud24KkL09wnuOR/fc5HXgs90Gcg92AYB7rM8=; b=KNlfUHeRpXxHEdp514OWZQvQJJ
 MO3Y8XTabMDoJzBnX4AJiJsF5k6lQOIfI/qzho9UKdvTrAeoBD8T0AL6Hb1xEkr4w2ex8Zqre91WT
 oZpIjBGgjKTiMkpxSVRrWrDAnnVt1e7gysD4FLDog8cyvXy8uJZhn7WZtn3P6o2wPEV8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IFOmFw3ud24KkL09wnuOR/fc5HXgs90Gcg92AYB7rM8=; b=SW9DXFEZgDfZBmxws+aK/bYg8d
 p5zjWY5mxf1dZTHzQ5wf/kGC1nfXmg1vMsdU7ABPdUL/j+LgNKaWnT7g5Od57cgYfX+/pq8Ee/1jB
 vj2B6gUvFOJr1h/rXrIi/Dh4wIuk97UeQLnRuMl3fPZ1i7r7hXlFHyJp/XMeSFggy0R0=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUnbv-000000005sG-2kv8 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 16:06:45 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so22243935e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 08:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795277197; x=1795881997; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IFOmFw3ud24KkL09wnuOR/fc5HXgs90Gcg92AYB7rM8=;
 b=V5xn51NUjUXnhBsfhN7QI4PW3ZrK8cZdWP3vJSpoG8yAm6f/gZEnPBvWQSdKQkEJ3J
 dtPQwF/XVEQjpP1QTby+WVkYcfwlL3aiMhkw6hBsoPBoZVj2PgRv+GJPym85o3DaiLDr
 XdZO70uLYDmP2Ug2nxCdBCrXGKTtQ7bZNXwedLamE1BC5onZysuLldZWVkwiFHM3nIiE
 FoXpK6VBVk+LTKuxAkSiumH/43yQP5Abqw0tcNIWHYnLLnjdNjlVF16ccL/Lfy15wPeW
 rGgI7g9RuSDCxJPwem24OJsf/8fYfIKJ/iu4aAUsVw+PRhyZqDLsNFuW9elAaUyRQpxa
 3vKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795277197; x=1795881997;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IFOmFw3ud24KkL09wnuOR/fc5HXgs90Gcg92AYB7rM8=;
 b=oIXRFSEhf6z3JKBUl4FFFusdJQJPnldiajfBPsZ7+wpyOpT542A4it3BFZjit597K8
 rLBeujC4ER7iqtyO9LrPbaxukZt0piPSErHs4L50rNJzrHuDKK2MwpHgLGwxnI3JP8H5
 3IBOUJEhsOaHZtCPUXhRLvUkI7BaAl1tG8SWBjjdSlT1bdEsdrtGISXf4jLbvt2H0Bb3
 yudpfRD8x45QptPjx5bs+zc/nSknRezgwbr5baJsrpIFsyImPBZKe1FyMai7jmBGI3nF
 tH13u489x4lew4fkoD2qIcifgphXoIfnm0Jp3V68dsSvG45kjJDSDtMDw3Br/pfpBSDA
 b5yg==
X-Gm-Message-State: APuU4Z+/0+0ZVzgnDkbENEBYpJKvLh5v+7xWaazLnd+yY4Ya/5gxZa+g
 5CcFhGYSW8uhuD1Er/sqH3V32aUaZlpeIouxZVDTEIPz3Pi4Z9Vf8xSwHk5Db20KsNZQh/KKl/e
 hTYQdERxP8uD30nm9UWjWRQm0LBYg4WzXRlPoEtVMk5jDUmsx1XdU4KcPJeTSd9h9/ac+
X-Gm-Gg: AZFdTZfOjAQhDcBg7DbMZGIWJDxlDCLgq5AtFhIeor9Cds43wFF+eaEtxU4lQnR91W3
 tHJQuuEikiLcIfRX1uugb1OW9uKaJ3Pmanxrm3iKwdNfQEDeCtou3dbZdNiBWeWkMZWYPu1Ez8v
 156Zm5xlhDZo//xkMUc4C591OQMF4ReA41nSa1Wu0wpG5lWSC2IsDAwA7WMsY3IkO29Si86DhBh
 7ztEvFMHfp2x50mgRtb8QyqZpkKf2AKD+ZH2uoyttfwK0/j8wX0J5dmbJb1q70PmPAtPz4A9XUu
 6Txv/omznl8YpiCIqjxw3uFacOGFFh5T/lYxUJmtiU2SKb4LCaE3xFfBQLvGjRYdaTavTl1s+y8
 QAm+BNPU6fDXRsJgmXag7OBNZx4BKARnhU9ojnSymy17uGyyvhfwNFT0WGnJccsYz3+RUHjs9/y
 nvd+gZOuuT2UlGryHT2UWNNfufJr8Uh+eBC4Eet8WD8VZeknz99YfRD06uUOCiN4xc3l/FSKtpu
 Pj6318yUqBqJubmu7vR5UAVOdlZZeKcElq+cUn4yxz6H+MFGdvkASFaH0VvnWbqkTSH7GdTRk2X
 i15YCbiSQ0gQXxTZZoXsHJvW6f+WYti39CScqVms27gIZJUwRb2X/MKXhAX3k/Epv//iJAohuEI
 XGlGPkZ2NQUeE7O5XnPm18TyNB7EE629iAtVWz39xBxWT8EQuP+tCymOim6ahfdEBXheKOPa92E
 3k5mWUf4+l2N0yb+Y=
X-Received: by 2002:a05:600c:4585:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4bb8881b8e4mr146777535e9.17.1795277196287; 
 Sat, 21 Nov 2026 08:06:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm293053785e9.14.2026.11.21.08.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 08:06:35 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 21 Nov 2026 16:06:34 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64
X-Gerrit-Change-Number: 2153
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2153?usp=email>
X-Gerrit-Commit: a6afe9fa971af9b8e46794cca4f95cfee44e6fa8
In-Reply-To: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
References: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkkzZTYwNDMxNzg5MzVmZGQwNWU2ZWE3OGM0MTFkYWM1ZGVjYjdhYzY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ad5e4cf30fd6845c82ce1904e5ad9c3a59f17039-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUnbv-000000005sG-2kv8
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4110228248312447511=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4110228248312447511==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E/ic2JwW/L0="; charset=UTF-8

--E/ic2JwW/L0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, R=C4=83zv=
an Cojocaru=2E

Hello Arne Schwabe, Gert Doering, 

I'd like you to reexami=
ne a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2153?usp=3Demail

to look at the new patch set (#6)=2E

The following appr=
ovals got outdated and were removed:
Code-Review-1 by Gert Doering


Change=
 subject: networking_freebsd: fix route command and return value details
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

networking_fr=
eebsd: fix route command and return value details

- Return -1 on failure, =
as networking=2Eh documents, instead of 1=2E
- Add the interface as scope t=
o link-local IPv6 gateways=2E
- Use "delete" and "-inet6", as route=2Ec doe=
s=2E DragonFly's route(8)
  has no "del" or "-6"=2E

All current callers (D=
CO iroutes) ignore the return value=2E

Change-Id: I3e6043178935fdd05e6ea78=
c411dac5decb7ac64
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
--=
-
M src/openvpn/networking_freebsd=2Ec
1 file changed, 22 insertions(+), 24=
 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/53/2153/6

diff --git a/src/openvpn/networking_freebsd=2Ec b/src/op=
envpn/networking_freebsd=2Ec
index 8ba6326=2E=2Eabcc026 100644
--- a/src/op=
envpn/networking_freebsd=2Ec
+++ b/src/openvpn/networking_freebsd=2Ec
@@ -1=
2,30 +12,26 @@
 net_route_v4(const char *op, const in_addr_t *dst, int pref=
ixlen, const in_addr_t *gw,
              const char *iface, int table, int=
 metric)
 {
-    char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];
-    in=
_addr_t _dst, _gw;
+    char buf[INET_ADDRSTRLEN];
+    in_addr_t _dst =3D =
ntohl(*dst);
     struct argv argv =3D argv_new();
 
     ASSERT(gw || ifac=
e);
 
-    _dst =3D ntohl(*dst);
-
     /* if we have a gateway (GW !=3D NU=
LL) install route to gateway IP
      * if not, install "connected" route t=
o interface
      * (needed to make 'ifconfig-push IPs outside server subne=
t' work)
      */
+    argv_printf(&argv, "%s %s -net %s/%d", ROUTE_PATH, o=
p,
+                inet_ntop(AF_INET, &_dst, buf, sizeof(buf)), prefixlen)=
;
     if (gw)
     {
-        _gw =3D ntohl(*gw);
-        argv_printf(&ar=
gv, "%s %s -net %s/%d %s", ROUTE_PATH, op,
-                    inet_ntop(A=
F_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-                    inet_nt=
op(AF_INET, &_gw, buf2, sizeof(buf2)));
+        in_addr_t _gw =3D ntohl(*g=
w);
+        argv_printf_cat(&argv, "%s", inet_ntop(AF_INET, &_gw, buf, siz=
eof(buf)));
     }
     else
     {
-        argv_printf(&argv, "%s %s -net=
 %s/%d -iface %s", ROUTE_PATH, op,
-                    inet_ntop(AF_INET, =
&_dst, buf1, sizeof(buf1)), prefixlen,
-                    iface);
+      =
  argv_printf_cat(&argv, "-iface %s", iface);
     }
     /* without -fib, =
route(8) uses the FIB of the process */
     if (table >=3D 0)
@@ -48,14 +4=
4,14 @@
 
     argv_free(&argv);
 
-    return (!status);
+    return statu=
s ? 0 : -1;
 }
 
 static int
 net_route_v6(const char *op, const struct in6=
_addr *dst, int prefixlen, const struct in6_addr *gw,
              const c=
har *iface, int table, int metric)
 {
-    char buf1[INET6_ADDRSTRLEN], buf=
2[INET6_ADDRSTRLEN];
+    char buf[INET6_ADDRSTRLEN];
     struct argv argv=
 =3D argv_new();
 
     ASSERT(gw || iface);
@@ -64,30 +60,32 @@
      * if=
 not, install "connected" route to interface
      * (needed to make 'ifcon=
fig-push IPs outside server subnet' work)
      */
-    if (gw)
+    argv_p=
rintf(&argv, "%s %s -inet6 %s/%d", ROUTE_PATH, op,
+                inet_nt=
op(AF_INET6, dst, buf, sizeof(buf)), prefixlen);
+    if (gw && iface && IN=
6_IS_ADDR_LINKLOCAL(gw))
     {
-        argv_printf(&argv, "%s -6 %s -net =
%s/%d %s", ROUTE_PATH, op,
-                    inet_ntop(AF_INET6, dst, bu=
f1, sizeof(buf1)), prefixlen,
-                    inet_ntop(AF_INET6, gw, =
buf2, sizeof(buf2)));
+        /* a link-local gateway needs the interface =
as scope */
+        argv_printf_cat(&argv, "%s%%%s", inet_ntop(AF_INET6, g=
w, buf, sizeof(buf)), iface);
+    }
+    else if (gw)
+    {
+        argv=
_printf_cat(&argv, "%s", inet_ntop(AF_INET6, gw, buf, sizeof(buf)));
     }=

     else
     {
-        argv_printf(&argv, "%s -6 %s -net %s/%d -iface %=
s", ROUTE_PATH, op,
-                    inet_ntop(AF_INET6, dst, buf1, siz=
eof(buf1)), prefixlen,
-                    iface);
+        argv_printf_ca=
t(&argv, "-iface %s", iface);
     }
     if (table >=3D 0)
     {
        =
 argv_printf_cat(&argv, "-fib %d", table);
     }
 
-
     argv_msg(M_INFO,=
 &argv);
     bool status =3D openvpn_execve_check(&argv, NULL, 0, "ERROR: =
FreeBSD route command failed");
 
     argv_free(&argv);
 
-    return (!st=
atus);
+    return status ? 0 : -1;
 }
 
 int
@@ -108,14 +106,14 @@
 net_ro=
ute_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixle=
n, const in_addr_t *gw,
                  const char *iface, int table, int=
 metric)
 {
-    return net_route_v4("del", dst, prefixlen, gw, iface, tabl=
e, metric);
+    return net_route_v4("delete", dst, prefixlen, gw, iface, t=
able, metric);
 }
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, co=
nst struct in6_addr *dst, int prefixlen,
                  const struct in6=
_addr *gw, const char *iface, int table, int metric)
 {
-    return net_rou=
te_v6("del", dst, prefixlen, gw, iface, table, metric);
+    return net_rou=
te_v6("delete", dst, prefixlen, gw, iface, table, metric);
 }
 
 #endif /* =
if defined(TARGET_FREEBSD) */

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2153?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64
Gerrit-Change-Num=
ber: 2153
Gerrit-PatchSet: 6
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>

--E/ic2JwW/L0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, R=C4=83zvan Cojocaru=2E <=
/p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #6</strong> to this =
change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review-1 by Gert Doering</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">networking_fr=
eebsd: fix route command and return value details<br><br>- Return -1 on fai=
lure, as networking=2Eh documents, instead of 1=2E<br>- Add the interface a=
s scope to link-local IPv6 gateways=2E<br>- Use &quot;delete&quot; and &quo=
t;-inet6&quot;, as route=2Ec does=2E DragonFly&#39;s route(8)<br>  has no &=
quot;del&quot; or &quot;-6&quot;=2E<br><br>All current callers (DCO iroutes=
) ignore the return value=2E<br><br>Change-Id: I3e6043178935fdd05e6ea78c411=
dac5decb7ac64<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t;<br>---<br>M src/openvpn/networking_freebsd=2Ec<br>1 file changed, 22 ins=
ertions(+), 24 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/53/2153/6</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/networking_freebsd=2Ec b/src/openvpn/networking_freebsd=2Ec</s=
pan><br><span>index 8ba6326=2E=2Eabcc026 100644</span><br><span>--- a/src/o=
penvpn/networking_freebsd=2Ec</span><br><span>+++ b/src/openvpn/networking_=
freebsd=2Ec</span><br><span>@@ -12,30 +12,26 @@</span><br><span> net_route_=
v4(const char *op, const in_addr_t *dst, int prefixlen, const in_addr_t *gw=
,</span><br><span>              const char *iface, int table, int metric)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    in_addr_t _dst, _gw;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char buf[INET_ADDRSTRLEN];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t _dst =3D ntohl(*=
dst);</span><br><span>     struct argv argv =3D argv_new();</span><br><span=
> </span><br><span>     ASSERT(gw || iface);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    _dst =3D ntohl(*dst);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* if we=
 have a gateway (GW !=3D NULL) install route to gateway IP</span><br><span>=
      * if not, install &quot;connected&quot; route to interface</span><br>=
<span>      * (needed to make &#39;ifconfig-push IPs outside server subnet&=
#39; work)</span><br><span>      */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s %s -net %s/%d&quot;, RO=
UTE_PATH, op,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          inet_ntop(AF_INET, &amp;_dst, buf, sizeof(buf)), prefixlen);</spa=
n><br><span>     if (gw)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        _gw =3D ntohl(*gw);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;%s %s =
-net %s/%d %s&quot;, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    inet_ntop(AF_INET, &amp;_dst, buf1, size=
of(buf1)), prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    inet_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        in_addr_t _gw =
=3D ntohl(*gw);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    argv_printf_cat(&amp;argv, &quot;%s&quot;, inet_ntop(AF_INET, &amp;_gw,=
 buf, sizeof(buf)));</span><br><span>     }</span><br><span>     else</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    argv_printf(&amp;argv, &quot;%s %s -net %s/%d -iface %s&quot;, ROUTE_PA=
TH, op,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      inet_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)), prefixlen,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    iface);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_c=
at(&amp;argv, &quot;-iface %s&quot;, iface);</span><br><span>     }</span><=
br><span>     /* without -fib, route(8) uses the FIB of the process */</spa=
n><br><span>     if (table &gt;=3D 0)</span><br><span>@@ -48,14 +44,14 @@</=
span><br><span> </span><br><span>     argv_free(&amp;argv);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (!status=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return status=
 ? 0 : -1;</span><br><span> }</span><br><span> </span><br><span> static int=
</span><br><span> net_route_v6(const char *op, const struct in6_addr *dst, =
int prefixlen, const struct in6_addr *gw,</span><br><span>              con=
st char *iface, int table, int metric)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    char buf1[INET6_ADDRSTRLEN], buf2[I=
NET6_ADDRSTRLEN];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  char buf[INET6_ADDRSTRLEN];</span><br><span>     struct argv argv =3D arg=
v_new();</span><br><span> </span><br><span>     ASSERT(gw || iface);</span>=
<br><span>@@ -64,30 +60,32 @@</span><br><span>      * if not, install &quot=
;connected&quot; route to interface</span><br><span>      * (needed to make=
 &#39;ifconfig-push IPs outside server subnet&#39; work)</span><br><span>  =
    */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (gw)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;ar=
gv, &quot;%s %s -inet6 %s/%d&quot;, ROUTE_PATH, op,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                inet_ntop(AF_INET6, dst, =
buf, sizeof(buf)), prefixlen);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (gw &amp;&amp; iface &amp;&amp; IN6_IS_ADDR_LINKLOCAL(gw)=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d %s&quot;, ROUTE=
_PATH, op,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    inet_ntop(A=
F_INET6, gw, buf2, sizeof(buf2)));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* a link-local gateway needs the interface as scope=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_pri=
ntf_cat(&amp;argv, &quot;%s%%%s&quot;, inet_ntop(AF_INET6, gw, buf, sizeof(=
buf)), iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (gw)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &=
quot;%s&quot;, inet_ntop(AF_INET6, gw, buf, sizeof(buf)));</span><br><span>=
     }</span><br><span>     else</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;%s -=
6 %s -net %s/%d -iface %s&quot;, ROUTE_PATH, op,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    inet_ntop(AF_INET6, dst, buf=
1, sizeof(buf1)), prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    iface);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-iface %s&quot;, if=
ace);</span><br><span>     }</span><br><span>     if (table &gt;=3D 0)</spa=
n><br><span>     {</span><br><span>         argv_printf_cat(&amp;argv, &quo=
t;-fib %d&quot;, table);</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     argv_msg(=
M_INFO, &amp;argv);</span><br><span>     bool status =3D openvpn_execve_che=
ck(&amp;argv, NULL, 0, &quot;ERROR: FreeBSD route command failed&quot;);</s=
pan><br><span> </span><br><span>     argv_free(&amp;argv);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (!status)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return status =
? 0 : -1;</span><br><span> }</span><br><span> </span><br><span> int</span><=
br><span>@@ -108,14 +106,14 @@</span><br><span> net_route_v4_del(const open=
vpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *g=
w,</span><br><span>                  const char *iface, int table, int metr=
ic)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return net_route_v4(&quot;del&quot;, dst, prefixlen, gw, iface, table,=
 metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 net_route_v4(&quot;delete&quot;, dst, prefixlen, gw, iface, table, metric)=
;</span><br><span> }</span><br><span> </span><br><span> int</span><br><span=
> net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst=
, int prefixlen,</span><br><span>                  const struct in6_addr *g=
w, const char *iface, int table, int metric)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return net_route_v6(&quot;del=
&quot;, dst, prefixlen, gw, iface, table, metric);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return net_route_v6(&quot;delete&quot;, =
dst, prefixlen, gw, iface, table, metric);</span><br><span> }</span><br><sp=
an> </span><br><span> #endif /* if defined(TARGET_FREEBSD) */</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2153?usp=3Demail">change 2153</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2153?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newp=
atchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2153 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none">=
 Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt; </div>

</body></html>
--E/ic2JwW/L0=--


--===============4110228248312447511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4110228248312447511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4110228248312447511==--

