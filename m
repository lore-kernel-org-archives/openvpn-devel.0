Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E6E606A32A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JBNwD1nA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=h8oy07Up;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TD6kLiN/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K59tYy/T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=A1C9dNu/Ua7iChEOpXkhvBZAitDJIea87PEiH8QdNoY=; b=JBNwD1nAGzcKw6t+80B/kWX1uv
	rm6dMNy+Qgw6nqqW7ktutZRsTFy4X8HEeG0GFZ38qInv84qpB8h1p2tSjDsOcz0gBZSfkq8o8S6R2
	V1J5fDTdwN8Extk2iuLOY7kYD05KJNCRFa98wG/54gAavjCUJ0BNYbBkmw+e2C2o4/a8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM3ri-0000000006s-0Ens;
	Wed, 28 Oct 2026 13:38:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM3r3-000000008WA-2kMB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:38:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OKwBZVT1Hcq5HuKII4AemHPZj0O+EkfIgjinvmSayVI=; b=h8oy07UplKvDyHInqBOzLIsi7m
 02HmUpPjZ/83w5oNlILt/HfQ+1cVqN0VM1D3aVZd9ByUl/rN4Vf6+lDH8f+RPqcuR8Q2+Af72cmPC
 ZqEiua6mLZNtGACfalPF6uR+psUj/SKCxh+65C1rfqrNAczfgVJMDZf+E55Q7w1osx5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OKwBZVT1Hcq5HuKII4AemHPZj0O+EkfIgjinvmSayVI=; b=TD6kLiN/syb/7kqKhyL7ghtNBK
 rEo6ehp5iPaQtl7LVT5UjbzPMDACKQvzysBB6TWReVZG/u/jRlvRzCH3iB51vtDW/SJFlKLt66Af5
 2XNf29PEh8DEi5ZFLIuM9cQZRJTN6qdOGlA3soYJPjlNsD4px2utot7SzH4tRPcZ/UEo=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM3qx-00000000742-4AIb for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:38:12 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so8707395e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793194681; x=1793799481; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OKwBZVT1Hcq5HuKII4AemHPZj0O+EkfIgjinvmSayVI=;
 b=K59tYy/Tm1Ljho4disihPddVP5HS3cIxZ1/MtAt05zlGadUOoCAreVnmymQu9XEQin
 dUVFj78IPzixgacrlffTe8/F8PD3RscSXWYURrV/WxwpvYqTlmOGEQ4paaeciu29o2ni
 YzWxZ1HaHBBnzmaJ45XI9+BUyU0eXWC8D/YR5dfTVRq4apac/2uW1iNyQaT2mZDA1Iq9
 e5gy18A/gwQ6vJggQj/b2/L0dTsenmxoibKZbuy1xTP1qCwLeZIWn5MkJRgkQOVtMIyB
 bJIsMXC+4V/eff/T17gWTsUH3ZQz0QkID6PvQ75cebiiVCJKsaZt7iUOYDWvc+q9Sr7d
 sKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793194681; x=1793799481;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OKwBZVT1Hcq5HuKII4AemHPZj0O+EkfIgjinvmSayVI=;
 b=24XTcAt7bHlNZnxYhURHV/ww/qblkndN/5Rqj7I7NXfVVJuQU72/v+iioaI3jYYwya
 6wMThrkAOwID+qut6uXXfB9SWwXzVeZody6ThVfRj7QV34mBBlIalp5Iyd2HmLaeVB7w
 zDudVEbenXG2j08Aqk1Z1aq9Qpij8oGDud75vtI0cdRmRkMpklB8Xe45KWlcNdvkdp/S
 u02IxB7xMRi3dV2TO5enAUM2n0pexn4oUp26PmjcBiyxhMxbNOT48qEZLvHV6wj4XSyI
 DZPz7wlvTEQIZaKNIEkxS+I5nFcL8AHExu+KdYQItWb/O0UV0Ihtiv4XNzp034mrjkyD
 CEcw==
X-Gm-Message-State: AFq9FYJ3a8IWuMNB1AmpUrJPsa06Vnsdqny1dRmQZaSCVVk1Lw5j965P
 8blvCfVLq7+2aXsAMfDM9DhBQf6aCSyIEMmkjyx97emUK7AYelukXfbT8IoPN5ZJc7nHxcW4b4F
 fyiZB0WS4fmHzrUIWONnG+FoAFLNscTDLhJgcZGMd5ZkVGg+pO6S6McnI1C0HamuLu39qZqt9fw
 knp1hlwg==
X-Gm-Gg: AYBFou3HBH8TkblbO6wSMt+1bj+UzU3dSK0EwGeDogSqpT17i2DO7C5A2yPzg41zfJM
 2EPIWCYhecjDT9msJFeSOj5891ZTwGl2hPlHdPQCO/PV4IUyBN7DmLF9T+t2MXl8SCpplMF4et6
 fkZVuhA8Cr9lwKIhvfxkKSWCWO+wfPUG4DIEanvIfYvG4/dp9Xfy2sXK4NL7yrYpK/HFzdS+wxE
 8i8acipSlFmXOX3XneB44IeCNCFs+nv1lijq9YzE+7sK8pZSarpZmAt617QlZqjGvtrEqx5axos
 Z53JKzTjdmT6m/mbHMvyZHga0+dAkaKAiv1fcd/DLh2Zh3X1owdq/4vu2xSYZZNhnX/CE9wQAJU
 5ePo4hq4Sh4CiC1Fx812JqKu/C+6btcmf50nC7/5ONzdmzD1jrLDF1Haq6ekbh8AT/1Z2OL7NZo
 gRQTUYDmfEHDMHeicUsPcfSDcKXvXfQ4LrCcEgLJbNQDZaQsr4O6w3wfkF7Pzw5Ka8Xusg2B5Op
 UfuvG0GNRoECtx5Ah5d2cjfNJwbS5OF83zvUMdlMDerazsScM7cREb7Iv4Mz/mq1eHpPGod6psZ
 mkPPBjN8/+6dnQg/SisuHAvPSsx3n3o+uAAOSUZMlMfA+IiMZ4kHMpAst/g5rOngcUYfhBWgrP6
 NMZmVZ7qYOuPACVeYnCggQfKtANhu7bRlMJlaFUWXls3StjTlil8mDLMz1yIyR2HY0uRIENYaCK
 09D4czUrTSP5OA9iA=
X-Received: by 2002:a05:600c:6211:b0:4a1:f7f4:7cf1 with SMTP id
 5b1f17b1804b1-4a965ec94ffmr44105585e9.11.1793194681086; 
 Wed, 28 Oct 2026 06:38:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92e104d8csm30929785e9.0.2026.10.28.06.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:38:00 -0700 (PDT)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 13:38:00 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582
X-Gerrit-Change-Number: 2062
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2062?usp=email>
X-Gerrit-Commit: bf43addf953ddd0b8a22c69683114cf2e6ea5386
References: <gerrit.1793194671000.I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkkxMzNlOTM2OGY5ZGZhOWYxMGI0ZGY4ZTUwM2MzY2Y0MmYzYTZkNTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <640313cbfa1810bba939e8649065969584e73018-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM3qx-00000000742-4AIb
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: add an API to
 update peer virtual addresses on Linux
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0927473135993997284=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0927473135993997284==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NhYCbnJtFhk="; charset=UTF-8

--NhYCbnJtFhk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2062?usp=3Demail

to review the following change=2E
=


Change subject: dco: add an API to update peer virtual addresses on Linux=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: add a=
n API to update peer virtual addresses on Linux

Add a context wrapper and =
a Linux OVPN_CMD_PEER_SET implementation that
updates or clears only the re=
quested address families=2E Supply no-op stubs
for non-DCO builds, FreeBSD =
and Windows=2E

Change-Id: I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582
Signed=
-off-by: Marco Baffo <marco@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
M sr=
c/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/dco_linux=2Ec=

M src/openvpn/dco_win=2Ec
5 files changed, 129 insertions(+), 0 deletions(=
-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/62=
/2062/1

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index 535b1=
c7=2E=2E401ffea 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
=
@@ -676,6 +676,40 @@
     return 0;
 }
 
+int
+dco_multi_update_peer_addr(s=
truct context *c, int flags)
+{
+    if (!flags || c->c2=2Etls_multi->dco_p=
eer_id =3D=3D -1)
+    {
+        return 0;
+    }
+
+    int peer_id =3D c=
->c2=2Etls_multi->dco_peer_id;
+
+    /* In server mode we need to fetch th=
e remote addresses from the push config */
+    struct in_addr vpn_ip4 =3D =
{ 0 };
+    const struct in_addr *vpn_addr4 =3D NULL;
+    if (c->c2=2Epush=
_ifconfig_defined)
+    {
+        vpn_ip4=2Es_addr =3D htonl(c->c2=2Epush_=
ifconfig_local);
+        vpn_addr4 =3D &vpn_ip4;
+    }
+
+    const struc=
t in6_addr *vpn_addr6 =3D NULL;
+    if (c->c2=2Epush_ifconfig_ipv6_defined=
)
+    {
+        vpn_addr6 =3D &c->c2=2Epush_ifconfig_ipv6_local;
+    }
+=

+    int ret =3D dco_update_peer_addr(&c->c1=2Etuntap->dco, peer_id, vpn_a=
ddr4, vpn_addr6, flags);
+    if (ret < 0)
+    {
+        return ret;
+   =
 }
+
+    return 0;
+}
+
 void
 dco_install_iroute(struct multi_context *m,=
 struct multi_instance *mi, const struct mroute_addr *addr)
 {
diff --git a=
/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index daedb96=2E=2E3093ff5 10064=
4
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -191,6 +191,31 @@
=
                  int keepalive_timeout, int mss);
 
 /**
+ * Update the pe=
er's virtual address(es) in the DCO to the current value(s)
+ *
+ * @param =
dco       DCO device context
+ * @param peerid    the ID of the peer to be =
modified
+ * @param vpn_ipv4  new IPv4 or NULL to remove the outdated one, =
only used when `(1 << AF_INET)` flag is present
+ * @param vpn_ipv6  new IP=
v6 or NULL to remove the outdated one, only used when `(1 << AF_INET6)` fla=
g is present
+ * @param flags     `(1 << AF_INET)`, `(1 << AF_INET6)` or `(=
1 << AF_INET) | (1 << AF_INET6)` depending on which address has changed
+ *=
 @return int      the DCO message status on success or a negative error cod=
e otherwise
+ */
+int
+dco_update_peer_addr(dco_context_t *dco, unsigned in=
t peerid,
+                     const struct in_addr *vpn_ipv4, const struc=
t in6_addr *vpn_ipv6,
+                     int flags);
+
+/**
+ * Update t=
he peer's virtual address(es) in the DCO to the current value(s)
+ *
+ * @p=
aram c         peer context
+ * @param flags     `(1 << AF_INET)`, `(1 << A=
F_INET6)` or `(1 << AF_INET) | (1 << AF_INET6)` depending on which address =
has changed
+ * @return int      0 on success or a negative error code othe=
rwise
+ */
+int
+dco_multi_update_peer_addr(struct context *c, int flags);
=
+
+/**
  * Remove a peer from DCO
  *
  * @param c         the main instanc=
e context of the peer to remove
@@ -360,6 +385,20 @@
     return 0;
 }
 
+s=
tatic inline int
+dco_update_peer_addr(dco_context_t *dco, unsigned int pee=
rid,
+                     const struct in_addr *vpn_ipv4, const struct in6=
_addr *vpn_ipv6,
+                     int flags)
+{
+    return 0;
+}
+
+s=
tatic inline int
+dco_multi_update_peer_addr(struct context *c, int flags)
=
+{
+    return 0;
+}
+
 static inline void
 dco_remove_peer(struct context =
*c)
 {
diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=
=2Ec
index 3148f10=2E=2Ed85104a 100644
--- a/src/openvpn/dco_freebsd=2Ec
++=
+ b/src/openvpn/dco_freebsd=2Ec
@@ -559,6 +559,12 @@
     return ret;
 }
 
=
+int
+dco_update_peer_addr(dco_context_t *dco, unsigned int peerid, const s=
truct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6, int flags)
+{
+  =
  return 0;
+}
+
 static void
 dco_update_peer_stat(struct multi_context *m=
, uint32_t peerid, const nvlist_t *nvl)
 {
diff --git a/src/openvpn/dco_lin=
ux=2Ec b/src/openvpn/dco_linux=2Ec
index 4412ad0=2E=2E744d687 100644
--- a/=
src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -724,6 +724,50=
 @@
     return ret;
 }
 
+int
+dco_update_peer_addr(dco_context_t *dco, un=
signed int peerid, const struct in_addr *vpn_ipv4, const struct in6_addr *v=
pn_ipv6, int flags)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, pe=
erid);
+
+    if (!flags)
+    {
+        return 0;
+    }
+
+    struct nl=
_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_SET);
+    if (!n=
l_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr =
=3D nla_nest_start(nl_msg, OVPN_A_PEER);
+    int ret =3D -EMSGSIZE;
+    N=
LA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
+
+    if (flags & (1 << AF_INE=
T))
+    {
+        NLA_PUT_U32(nl_msg, OVPN_A_PEER_VPN_IPV4, vpn_ipv4 ? vp=
n_ipv4->s_addr : 0);
+    }
+
+    if (flags & (1 << AF_INET6))
+    {
+   =
     struct in6_addr addr6;
+        if (!vpn_ipv6)
+        {
+           =
 CLEAR(addr6);
+            vpn_ipv6 =3D &addr6;
+        }
+        NLA_PU=
T(nl_msg, OVPN_A_PEER_VPN_IPV6, sizeof(struct in6_addr), vpn_ipv6);
+    }
=
+
+    nla_nest_end(nl_msg, attr);
+    ret =3D ovpn_nl_msg_send(dco, nl_ms=
g, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;=

+}
+
 /* This function parses the reply provided by the kernel to the CTRL=
_CMD_GETFAMILY
  * message=2E We parse the reply and we retrieve the multic=
ast group ID associated
  * with the "ovpn-dco" netlink family=2E
diff --gi=
t a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index 68ae7c5=2E=2E8f=
7c8f62 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@=
@ -519,6 +519,12 @@
 }
 
 int
+dco_update_peer_addr(dco_context_t *dco, uns=
igned int peerid, const struct in_addr *vpn_ipv4, const struct in6_addr *vp=
n_ipv6, int flags)
+{
+    return 0;
+}
+
+int
 dco_new_key(dco_context_t *=
dco, unsigned int peerid, int keyid, dco_key_slot_t slot,
             cons=
t uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_k=
ey,
             const uint8_t *decrypt_iv, const char *ciphername, bool ep=
och)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I133e9368f9d=
fa9f10b4df8e503c3cf42f3a6d582
Gerrit-Change-Number: 2062
Gerrit-PatchSet: 1=

Gerrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>

--NhYCbnJtFhk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Marco Baffo would like Arne S=
chwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062?usp=3Demail">View Change</a></p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">dco: add an API to update peer virtual addresses on Linux<br><br=
>Add a context wrapper and a Linux OVPN_CMD_PEER_SET implementation that<br=
>updates or clears only the requested address families=2E Supply no-op stub=
s<br>for non-DCO builds, FreeBSD and Windows=2E<br><br>Change-Id: I133e9368=
f9dfa9f10b4df8e503c3cf42f3a6d582<br>Signed-off-by: Marco Baffo &lt;marco@ma=
ndelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<=
br>M src/openvpn/dco_freebsd=2Ec<br>M src/openvpn/dco_linux=2Ec<br>M src/op=
envpn/dco_win=2Ec<br>5 files changed, 129 insertions(+), 0 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/62/2062/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/open=
vpn/dco=2Ec</span><br><span>index 535b1c7=2E=2E401ffea 100644</span><br><sp=
an>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</spa=
n><br><span>@@ -676,6 +676,40 @@</span><br><span>     return 0;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_=
update_peer_addr(struct context *c, int flags)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!flags || c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D=3D -1)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int peer_id =3D c-&gt;c2=2Etls_multi-&gt;dco_peer_id;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* In server mode we need to fetch the remote =
addresses from the push config */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct in_addr vpn_ip4 =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct in_addr *vpn_addr4 =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c=
2=2Epush_ifconfig_defined)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 vpn_ip4=2Es_addr =3D htonl(c-&gt;c2=2Epush_ifconfig_local);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        vpn_addr4 =3D &amp;vpn_ip4=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const struct in6_addr *vpn_addr6 =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Epush_=
ifconfig_ipv6_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        vpn=
_addr6 =3D &amp;c-&gt;c2=2Epush_ifconfig_ipv6_local;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int ret =3D dco_update_peer_addr(&amp;c-&gt;c1=2Etuntap-&gt;dco, peer_=
id, vpn_addr4, vpn_addr6, flags);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> void</span><br><span> dco_install_irout=
e(struct multi_context *m, struct multi_instance *mi, const struct mroute_a=
ddr *addr)</span><br><span> {</span><br><span>diff --git a/src/openvpn/dco=
=2Eh b/src/openvpn/dco=2Eh</span><br><span>index daedb96=2E=2E3093ff5 10064=
4</span><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openv=
pn/dco=2Eh</span><br><span>@@ -191,6 +191,31 @@</span><br><span>           =
       int keepalive_timeout, int mss);</span><br><span> </span><br><span> =
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Update the pe=
er&#39;s virtual address(es) in the DCO to the current value(s)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param dco       DCO device context</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param peerid    the ID of=
 the peer to be modified</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param vpn_ipv4  new IPv4 or NULL to remove the outdated one, only =
used when `(1 &lt;&lt; AF_INET)` flag is present</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param vpn_ipv6  new IPv6 or NULL to remove=
 the outdated one, only used when `(1 &lt;&lt; AF_INET6)` flag is present</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param flags     `=
(1 &lt;&lt; AF_INET)`, `(1 &lt;&lt; AF_INET6)` or `(1 &lt;&lt; AF_INET) | (=
1 &lt;&lt; AF_INET6)` depending on which address has changed</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @return int      the DCO messag=
e status on success or a negative error code otherwise</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+dco_update_peer_addr(dco_context_t *dco, unsigned int peerid,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                     const str=
uct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                     int flags);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Update the peer&#39;s virtual address(es) in the DCO to th=
e current value(s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c       =
  peer context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram flags     `(1 &lt;&lt; AF_INET)`, `(1 &lt;&lt; AF_INET6)` or `(1 &lt;&=
lt; AF_INET) | (1 &lt;&lt; AF_INET6)` depending on which address has change=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return int    =
  0 on success or a negative error code otherwise</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dc=
o_multi_update_peer_addr(struct context *c, int flags);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span>  * Remove a peer from DCO</span><br><=
span>  *</span><br><span>  * @param c         the main instance context of =
the peer to remove</span><br><span>@@ -360,6 +385,20 @@</span><br><span>   =
  return 0;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static inline int</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dco_update_peer_addr(dco_context_t *dco, unsigne=
d int peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
               const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_i=
pv6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
      int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static inline int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+dco_multi_update_peer_addr(struct context *c, int flags)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> static inline void</span><br><span> dco_remove_peer(s=
truct context *c)</span><br><span> {</span><br><span>diff --git a/src/openv=
pn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br><span>index 3148=
f10=2E=2Ed85104a 100644</span><br><span>--- a/src/openvpn/dco_freebsd=2Ec</=
span><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -559,6 =
+559,12 @@</span><br><span>     return ret;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dco_update_peer_addr(dco_conte=
xt_t *dco, unsigned int peerid, const struct in_addr *vpn_ipv4, const struc=
t in6_addr *vpn_ipv6, int flags)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void=
</span><br><span> dco_update_peer_stat(struct multi_context *m, uint32_t pe=
erid, const nvlist_t *nvl)</span><br><span> {</span><br><span>diff --git a/=
src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index=
 4412ad0=2E=2E744d687 100644</span><br><span>--- a/src/openvpn/dco_linux=2E=
c</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -724,6=
 +724,50 @@</span><br><span>     return ret;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+dco_update_peer_addr(dco_cont=
ext_t *dco, unsigned int peerid, const struct in_addr *vpn_ipv4, const stru=
ct in6_addr *vpn_ipv6, int flags)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
msg(D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__, peerid);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!flags)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl_msg *nl_msg =
=3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_SET);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!nl_msg)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return -ENOMEM;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nlat=
tr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int ret =3D -EMSGSIZE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID=
, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; (1 &lt;&=
lt; AF_INET))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        NLA_PUT_U32(=
nl_msg, OVPN_A_PEER_VPN_IPV4, vpn_ipv4 ? vpn_ipv4-&gt;s_addr : 0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (flags &amp; (1 &lt;&lt; AF_INET6))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct in6_addr addr6;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (!vpn_ipv6)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            CLEAR(addr6);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            vpn_ipv6 =3D &amp;addr6;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        NLA_PUT(nl_msg, OVPN_A_PEE=
R_VPN_IPV6, sizeof(struct in6_addr), vpn_ipv6);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    n=
la_nest_end(nl_msg, attr);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+nla_put_failure:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    nlmsg_free(nl_msg);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /* This function parses the reply provided by the kernel =
to the CTRL_CMD_GETFAMILY</span><br><span>  * message=2E We parse the reply=
 and we retrieve the multicast group ID associated</span><br><span>  * with=
 the &quot;ovpn-dco&quot; netlink family=2E</span><br><span>diff --git a/sr=
c/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index 68ae7=
c5=2E=2E8f7c8f62 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</span=
><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -519,6 +519,12 =
@@</span><br><span> }</span><br><span> </span><br><span> int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+dco_update_peer_addr(dco_context_t=
 *dco, unsigned int peerid, const struct in_addr *vpn_ipv4, const struct in=
6_addr *vpn_ipv6, int flags)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+int</span><br><span> dco_new_key(dco_context_t *dco,=
 unsigned int peerid, int keyid, dco_key_slot_t slot,</span><br><span>     =
        const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_=
t *decrypt_key,</span><br><span>             const uint8_t *decrypt_iv, con=
st char *ciphername, bool epoch)</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062?usp=3Demail">change 206=
2</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2062 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Baffo &lt=
;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--NhYCbnJtFhk=--


--===============0927473135993997284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0927473135993997284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0927473135993997284==--

