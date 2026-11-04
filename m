Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC931606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HcblnC/g;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Uupf9oHo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=armS3e5M;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IM0v+/vf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AG97agVdnMRRHxgFZSBJ4v/nUaFZ7CclXQAurv+h7DU=; b=HcblnC/guxp4/TgRnct3Rpvfxr
	dsUkWXFWcB+niaeYFY52kWe4nOnHixq8Xc43BJDl8aDrfoCRaag1htVkYhTb5PrnmPH2ijTnKJUFc
	xh/ik3KZJ48ymyoanTy+L9UNTQmfeCUhmSD3QtpQbXTpOwAC3WrAUqVtsMpU18ZZlQq4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdqJ-000000005CV-2oJI;
	Wed, 04 Nov 2026 16:28:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdqH-000000005CM-1i7K
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:28:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=afWKRZstFOy4vSDTcNxhqBHGRlayzl5iPfZzjMeSb+U=; b=Uupf9oHoLe7F4HTXl6ny81jMCe
 dMAFXfg88HzCuhzCtoXXcIW6ZwRtbY/JDrZug0yEmPvGs93MQcFTIRTQu1B9Vo59+x6FleFFZ31U1
 q5+rzXWt+FK9FCVaO7lQPl5y6FWpOVEUT7pTAyY0Gv8kpvNxaPgp7LSuMRbmzzE3FiIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=afWKRZstFOy4vSDTcNxhqBHGRlayzl5iPfZzjMeSb+U=; b=armS3e5M5V73zliSNN3UN79tTC
 s02p8QaC636SCAgBL/kEp+S/65B9N+R9x7uqEJr8xfftEASXzXLYvY0e7hV1jZ1DcdP1UawDj66RH
 +hF5SPf6gtvn5muFB0bI+CIgflRn7Q+mB+vdFir0dps+QIj2gcc/D/poxoczx0ja3r4Q=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdqF-000000006Nl-3yUk for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:28:05 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso628562f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793809677; x=1794414477; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=afWKRZstFOy4vSDTcNxhqBHGRlayzl5iPfZzjMeSb+U=;
 b=IM0v+/vfjA9Q120Ye/VekdJ70JcRUCCmRU7bXrBXYfB1qSypmbh0gKksr/rFbIxLgH
 Jhf+TSLc/58CX5SgDwDYvkZeR9Cld7zU/oJnRbncBJ7ZaKzm08mwQFxnquAO+7bJI4Pz
 Z9YsgQC1GwxB/jNi9GRopyYATA0glUFHXCI/cphGliGekY+ePvsBPezT8MgV/iN5Kfy/
 I7i+1dfq+zfiDlonj+KP+Ix25t/6P5twNyG9u4VEnPnPiYINhrfju1w7izsTMoRI/8dS
 LZou+3R8VrqN/HlCbCMBJ6RBoDVyLr+W7nyFBCu/49CR8PufuqMWkJZ/JrNxcCdM4kjB
 LQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809677; x=1794414477;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=afWKRZstFOy4vSDTcNxhqBHGRlayzl5iPfZzjMeSb+U=;
 b=FGYcghZLbMJxM0xTfb3mmJgL5veuYVvyRVVIwodrj8qjAN5GPTRA2V3JDGWPQOaY+A
 MGonuUmM2f3aAIXkHDSV6srsgyc6BYBRAgHr5FmaUKVJOkp4zjvqwkYmD7HVnqFTQQQ6
 KbEAn+jekthw+antjwpYmXFMdjYR4Fa6yuA486IEbUYMU00fw48Bw7jRiXh83ApWA5Ck
 IpzNEF3o7hKd6tF4zDU/GKKMh/f0+RX5gubiW03oMIAVfO+ldvrBtBFqE83Nlv/eYUHf
 e5yTkWoo1OTTSTMEhbben05JjYuBQ3uy1OwZLC7yS7WBxNwuBsNj6/newCMMHpgx9rAl
 1CqA==
X-Gm-Message-State: APuU4Z/wf1zd+5jA7p3Hq3zupqfSsP7UEzkPqyecw6wZFDLIgzLG7pJN
 fbPQGBETIPctaMX5oGZZU/pvdY5IPSDF0xw8SQP692zKxzpn85mKr2Wwv1bHa5cle2kZFLbiWDT
 MxAkvPsYA3Zg9GwndRP87JM/d8xo0hGCIMtbiFG7H6dPPgEU+9r3NuOes5ogFsFqIP6qD
X-Gm-Gg: AYBFou29CP5tudaKeucEoeCjAnFUhkcgGtfXEoyXiZEBPHLhpKrsjf7IajTD9yPrOFF
 AF7nlMQyVDBgI+ycF5lj+YCWixKizfPRwAdfB0iCdlx7vLu0BnKiMQMkhxMaLo/Ad0/sSoNCyhl
 BDlYwuK9Q80k17bpbC17OvgUE43XM/4HmX6AK1iFlcrIBhTR5TX9niTXk/wu/o0rpfDFtpL7CpL
 rnAFxL8ek5zXo+UYttF2EXv7vWekFHd+Ky8vT5JX43zDHtMrk3Ric5FKZgylgp1w+8BbS8YpMw3
 GOxUE8k4GQGBmXdHrgDwoJezDoNC4SXcHyBeVsGDDyvix9KBHtII/uZFU+fijXM4lbSEtFv/MtY
 S9OJ1XRslSwNXTXauB/s8IigX47tE/AG6+8ZmtvkdM79hWR/cxu66Gcq+x17/JCefBAUtzty7Qs
 xXDlYnTvroMlvgwJemMkxioR6TSg4B3xE6dvArjPBHLGQNA5mLSR0S1wJ+QYr4HMNg/Fnociien
 Xt2/BjC1isS2QIKayvznBJDsDAZ/7cAb8pkMUUivqOvc2lNzY0fCPkZWIkauJZEBAc9L0KS14uA
 a0R8LMdj+j1/AeZ4YhWctHuitgZu6dYRgWL2sRkspW/6pGI5I4mDjEwOWRe1gXPR5MDc3oRdlfk
 EgIB9HfbCKUFGtYSGFqyZvnrE2Uc4WPCIXhB9zDjAFHNA2Rgcl+7WzDVIvTpRcWxJ78u8lqttvX
 P/xCaR3ScJGIwiuw==
X-Received: by 2002:a05:600d:84ca:10b0:4b4:49d7:bc25 with SMTP id
 5b1f17b1804b1-4b449d7be7fmr30153795e9.21.1793809677257; 
 Wed, 04 Nov 2026 08:27:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab00ff3dsm275088175e9.14.2026.11.04.08.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:27:56 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:27:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582
X-Gerrit-Change-Number: 2062
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2062?usp=email>
X-Gerrit-Commit: 0f9aee8b28e108ec3bcd9fc3d9bff32ba2e8684c
In-Reply-To: <gerrit.1793194671000.I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582@gerrit.openvpn.net>
References: <gerrit.1793194671000.I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkkxMzNlOTM2OGY5ZGZhOWYxMGI0ZGY4ZTUwM2MzY2Y0MmYzYTZkNTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <11bd18ea8af51056c168ebc06867ce74aa430f9b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOdqF-000000006Nl-3yUk
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
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1574782686885693128=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1574782686885693128==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5k8T2hx9RUo="; charset=UTF-8

--5k8T2hx9RUo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

Hello A=
rne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E =
Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062?usp=3Dema=
il

to look at the new patch set (#2)=2E

The change is no longer submittab=
le: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: dco: ad=
d an API to update peer virtual addresses on Linux
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: add an API to update peer virtua=
l addresses on Linux

Add a context wrapper and a Linux OVPN_CMD_PEER_SET i=
mplementation that
updates or clears only the requested address families=2E=
 Supply no-op stubs
for non-DCO builds, FreeBSD and Windows=2E

Change-Id: =
I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582
Signed-off-by: Marco Baffo <marco=
@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/ope=
nvpn/dco_freebsd=2Ec
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
=
5 files changed, 129 insertions(+), 0 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/62/2062/2

diff --git a/src/op=
envpn/dco=2Ec b/src/openvpn/dco=2Ec
index f807002=2E=2Eaaf074b 100644
--- a=
/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -676,6 +676,40 @@
     re=
turn 0;
 }
 
+int
+dco_multi_update_peer_addr(struct context *c, int flags)=

+{
+    if (!flags || c->c2=2Etls_multi->dco_peer_id =3D=3D -1)
+    {
+  =
      return 0;
+    }
+
+    int peer_id =3D c->c2=2Etls_multi->dco_peer_i=
d;
+
+    /* In server mode we need to fetch the remote addresses from the =
push config */
+    struct in_addr vpn_ip4 =3D { 0 };
+    const struct in_=
addr *vpn_addr4 =3D NULL;
+    if (c->c2=2Epush_ifconfig_defined)
+    {
+ =
       vpn_ip4=2Es_addr =3D htonl(c->c2=2Epush_ifconfig_local);
+        vp=
n_addr4 =3D &vpn_ip4;
+    }
+
+    const struct in6_addr *vpn_addr6 =3D NU=
LL;
+    if (c->c2=2Epush_ifconfig_ipv6_defined)
+    {
+        vpn_addr6 =
=3D &c->c2=2Epush_ifconfig_ipv6_local;
+    }
+
+    int ret =3D dco_update=
_peer_addr(&c->c1=2Etuntap->dco, peer_id, vpn_addr4, vpn_addr6, flags);
+  =
  if (ret < 0)
+    {
+        return ret;
+    }
+
+    return 0;
+}
+
 vo=
id
 dco_install_iroute(struct multi_context *m, struct multi_instance *mi, =
const struct mroute_addr *addr)
 {
diff --git a/src/openvpn/dco=2Eh b/src/o=
penvpn/dco=2Eh
index ce44331=2E=2E7005bd2 100644
--- a/src/openvpn/dco=2Eh
=
+++ b/src/openvpn/dco=2Eh
@@ -191,6 +191,31 @@
                  int keepal=
ive_timeout, int mss);
 
 /**
+ * Update the peer's virtual address(es) in =
the DCO to the current value(s)
+ *
+ * @param dco       DCO device context=

+ * @param peerid    the ID of the peer to be modified
+ * @param vpn_ipv4=
  new IPv4 or NULL to remove the outdated one, only used when `(1 << AF_INE=
T)` flag is present
+ * @param vpn_ipv6  new IPv6 or NULL to remove the out=
dated one, only used when `(1 << AF_INET6)` flag is present
+ * @param flag=
s     `(1 << AF_INET)`, `(1 << AF_INET6)` or `(1 << AF_INET) | (1 << AF_INE=
T6)` depending on which address has changed
+ * @return int      the DCO me=
ssage status on success or a negative error code otherwise
+ */
+int
+dco_u=
pdate_peer_addr(dco_context_t *dco, unsigned int peerid,
+                 =
    const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6,
+     =
                int flags);
+
+/**
+ * Update the peer's virtual address(es=
) in the DCO to the current value(s)
+ *
+ * @param c         peer context
=
+ * @param flags     `(1 << AF_INET)`, `(1 << AF_INET6)` or `(1 << AF_INET)=
 | (1 << AF_INET6)` depending on which address has changed
+ * @return int =
     0 on success or a negative error code otherwise
+ */
+int
+dco_multi_u=
pdate_peer_addr(struct context *c, int flags);
+
+/**
  * Remove a peer fro=
m DCO
  *
  * @param c         the main instance context of the peer to rem=
ove
@@ -352,6 +377,20 @@
     return 0;
 }
 
+static inline int
+dco_update=
_peer_addr(dco_context_t *dco, unsigned int peerid,
+                     c=
onst struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6,
+          =
           int flags)
+{
+    return 0;
+}
+
+static inline int
+dco_multi_=
update_peer_addr(struct context *c, int flags)
+{
+    return 0;
+}
+
 stat=
ic inline void
 dco_remove_peer(struct context *c)
 {
diff --git a/src/open=
vpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index 3148f10=2E=2Ed85104=
a 100644
--- a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2E=
c
@@ -559,6 +559,12 @@
     return ret;
 }
 
+int
+dco_update_peer_addr(dco=
_context_t *dco, unsigned int peerid, const struct in_addr *vpn_ipv4, const=
 struct in6_addr *vpn_ipv6, int flags)
+{
+    return 0;
+}
+
 static void
=
 dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlis=
t_t *nvl)
 {
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=
=2Ec
index 4412ad0=2E=2E744d687 100644
--- a/src/openvpn/dco_linux=2Ec
+++ =
b/src/openvpn/dco_linux=2Ec
@@ -724,6 +724,50 @@
     return ret;
 }
 
+int=

+dco_update_peer_addr(dco_context_t *dco, unsigned int peerid, const struc=
t in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6, int flags)
+{
+    ms=
g(D_DCO_DEBUG, "%s: peer-id %u", __func__, peerid);
+
+    if (!flags)
+   =
 {
+        return 0;
+    }
+
+    struct nl_msg *nl_msg =3D ovpn_dco_nlms=
g_create(dco, OVPN_CMD_PEER_SET);
+    if (!nl_msg)
+    {
+        return =
-ENOMEM;
+    }
+
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_=
A_PEER);
+    int ret =3D -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_I=
D, peerid);
+
+    if (flags & (1 << AF_INET))
+    {
+        NLA_PUT_U32(=
nl_msg, OVPN_A_PEER_VPN_IPV4, vpn_ipv4 ? vpn_ipv4->s_addr : 0);
+    }
+
+ =
   if (flags & (1 << AF_INET6))
+    {
+        struct in6_addr addr6;
+   =
     if (!vpn_ipv6)
+        {
+            CLEAR(addr6);
+            vpn_=
ipv6 =3D &addr6;
+        }
+        NLA_PUT(nl_msg, OVPN_A_PEER_VPN_IPV6, =
sizeof(struct in6_addr), vpn_ipv6);
+    }
+
+    nla_nest_end(nl_msg, attr=
);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
+
+nla_put_failure=
:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
 /* This function parses t=
he reply provided by the kernel to the CTRL_CMD_GETFAMILY
  * message=2E We=
 parse the reply and we retrieve the multicast group ID associated
  * with=
 the "ovpn-dco" netlink family=2E
diff --git a/src/openvpn/dco_win=2Ec b/sr=
c/openvpn/dco_win=2Ec
index 68ae7c5=2E=2E8f7c8f62 100644
--- a/src/openvpn/=
dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -519,6 +519,12 @@
 }
 
 int
+d=
co_update_peer_addr(dco_context_t *dco, unsigned int peerid, const struct i=
n_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6, int flags)
+{
+    retur=
n 0;
+}
+
+int
 dco_new_key(dco_context_t *dco, unsigned int peerid, int ke=
yid, dco_key_slot_t slot,
             const uint8_t *encrypt_key, const ui=
nt8_t *encrypt_iv, const uint8_t *decrypt_key,
             const uint8_t *=
decrypt_iv, const char *ciphername, bool epoch)

-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582
=
Gerrit-Change-Number: 2062
Gerrit-PatchSet: 2
Gerrit-Owner: Marco Baffo <ma=
rco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>

--5k8T2hx9RUo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>Marco Baffo <str=
ong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062?usp=3Demail">View Change</a></p>=
<p>The change is no longer submittable: checks~ChecksSubmitRule is unsatisf=
ied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">dco: add an API to update peer virtual addresse=
s on Linux<br><br>Add a context wrapper and a Linux OVPN_CMD_PEER_SET imple=
mentation that<br>updates or clears only the requested address families=2E =
Supply no-op stubs<br>for non-DCO builds, FreeBSD and Windows=2E<br><br>Cha=
nge-Id: I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582<br>Signed-off-by: Marco B=
affo &lt;marco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src=
/openvpn/dco=2Eh<br>M src/openvpn/dco_freebsd=2Ec<br>M src/openvpn/dco_linu=
x=2Ec<br>M src/openvpn/dco_win=2Ec<br>5 files changed, 129 insertions(+), 0=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/62/2062/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/d=
co=2Ec b/src/openvpn/dco=2Ec</span><br><span>index f807002=2E=2Eaaf074b 100=
644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/ope=
nvpn/dco=2Ec</span><br><span>@@ -676,6 +676,40 @@</span><br><span>     retu=
rn 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+dco_multi_update_peer_addr(struct context *c, int flags)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!flags || c-&gt;c2=2Etls_multi-&gt;dco_pe=
er_id =3D=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int peer_id =3D c-&gt;c2=2Etls_multi-&gt;dco_pee=
r_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we need to =
fetch the remote addresses from the push config */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct in_addr vpn_ip4 =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct in_addr *=
vpn_addr4 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (c-&gt;c2=2Epush_ifconfig_defined)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        vpn_ip4=2Es_addr =3D htonl(c-&gt;c2=2Epush_ifconfig_local);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        vpn_addr4 =
=3D &amp;vpn_ip4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const struct in6_addr *vpn_addr=
6 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
c-&gt;c2=2Epush_ifconfig_ipv6_defined)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        vpn_addr6 =3D &amp;c-&gt;c2=2Epush_ifconfig_ipv6_local;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int ret =3D dco_update_peer_addr(&amp;c-&gt;c1=2Etuntap=
-&gt;dco, peer_id, vpn_addr4, vpn_addr6, flags);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return ret;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> d=
co_install_iroute(struct multi_context *m, struct multi_instance *mi, const=
 struct mroute_addr *addr)</span><br><span> {</span><br><span>diff --git a/=
src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh</span><br><span>index ce44331=2E=
=2E7005bd2 100644</span><br><span>--- a/src/openvpn/dco=2Eh</span><br><span=
>+++ b/src/openvpn/dco=2Eh</span><br><span>@@ -191,6 +191,31 @@</span><br><=
span>                  int keepalive_timeout, int mss);</span><br><span> </=
span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Update the peer&#39;s virtual address(es) in the DCO to the current valu=
e(s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param dco       DCO device c=
ontext</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pee=
rid    the ID of the peer to be modified</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param vpn_ipv4  new IPv4 or NULL to remove the out=
dated one, only used when `(1 &lt;&lt; AF_INET)` flag is present</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param vpn_ipv6  new IPv6 o=
r NULL to remove the outdated one, only used when `(1 &lt;&lt; AF_INET6)` f=
lag is present</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram flags     `(1 &lt;&lt; AF_INET)`, `(1 &lt;&lt; AF_INET6)` or `(1 &lt;&=
lt; AF_INET) | (1 &lt;&lt; AF_INET6)` depending on which address has change=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return int    =
  the DCO message status on success or a negative error code otherwise</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+dco_update_peer_addr(dco_context_t *dco, unsigned int pe=
erid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
       const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                     in=
t flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Update the peer&#39;s virtual address(es) =
in the DCO to the current value(s)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param c         peer context</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param flags     `(1 &lt;&lt; AF_INET)`, `(1 &lt;&lt; AF_INET=
6)` or `(1 &lt;&lt; AF_INET) | (1 &lt;&lt; AF_INET6)` depending on which ad=
dress has changed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return int      0 on success or a negative error code otherwise</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+dco_multi_update_peer_addr(struct context *c, int flags);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Remove a peer fro=
m DCO</span><br><span>  *</span><br><span>  * @param c         the main ins=
tance context of the peer to remove</span><br><span>@@ -352,6 +377,20 @@</s=
pan><br><span>     return 0;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static inline int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+dco_update_peer_addr(dco_contex=
t_t *dco, unsigned int peerid,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                     const struct in_addr *vpn_ipv4, const struc=
t in6_addr *vpn_ipv6,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                     int flags)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static inline int</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+dco_multi_update_peer_addr(struct context *c, int=
 flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static inline void</span><br><span> =
dco_remove_peer(struct context *c)</span><br><span> {</span><br><span>diff =
--git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br=
><span>index 3148f10=2E=2Ed85104a 100644</span><br><span>--- a/src/openvpn/=
dco_freebsd=2Ec</span><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br=
><span>@@ -559,6 +559,12 @@</span><br><span>     return ret;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_update_pe=
er_addr(dco_context_t *dco, unsigned int peerid, const struct in_addr *vpn_=
ipv4, const struct in6_addr *vpn_ipv6, int flags)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> static void</span><br><span> dco_update_peer_stat(struct multi_contex=
t *m, uint32_t peerid, const nvlist_t *nvl)</span><br><span> {</span><br><s=
pan>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</spa=
n><br><span>index 4412ad0=2E=2E744d687 100644</span><br><span>--- a/src/ope=
nvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><b=
r><span>@@ -724,6 +724,50 @@</span><br><span>     return ret;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_update_p=
eer_addr(dco_context_t *dco, unsigned int peerid, const struct in_addr *vpn=
_ipv4, const struct in6_addr *vpn_ipv6, int flags)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__, pee=
rid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_SET);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl_msg)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return -ENOMEM;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -EMSGSIZE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg=
, OVPN_A_PEER_ID, peerid);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flag=
s &amp; (1 &lt;&lt; AF_INET))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    NLA_PUT_U32(nl_msg, OVPN_A_PEER_VPN_IPV4, vpn_ipv4 ? vpn_ipv4-&gt;s_add=
r : 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (flags &amp; (1 &lt;&lt; AF_INET6))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        struct in6_addr addr6;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!vpn_ipv6)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            CLEAR(addr6);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            vpn_ipv6 =3D &=
amp;addr6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        NLA_PUT(nl_=
msg, OVPN_A_PEER_VPN_IPV6, sizeof(struct in6_addr), vpn_ipv6);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    nla_nest_end(nl_msg, attr);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+nla_put_failure:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    nlmsg_free(nl_msg);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /* This function parses the reply provide=
d by the kernel to the CTRL_CMD_GETFAMILY</span><br><span>  * message=2E We=
 parse the reply and we retrieve the multicast group ID associated</span><b=
r><span>  * with the &quot;ovpn-dco&quot; netlink family=2E</span><br><span=
>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><=
span>index 68ae7c5=2E=2E8f7c8f62 100644</span><br><span>--- a/src/openvpn/d=
co_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@=
 -519,6 +519,12 @@</span><br><span> }</span><br><span> </span><br><span> in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_update_peer_ad=
dr(dco_context_t *dco, unsigned int peerid, const struct in_addr *vpn_ipv4,=
 const struct in6_addr *vpn_ipv6, int flags)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span> dco_new_key(dco=
_context_t *dco, unsigned int peerid, int keyid, dco_key_slot_t slot,</span=
><br><span>             const uint8_t *encrypt_key, const uint8_t *encrypt_=
iv, const uint8_t *decrypt_key,</span><br><span>             const uint8_t =
*decrypt_iv, const char *ciphername, bool epoch)</span><br></pre><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2062?usp=3Dem=
ail">change 2062</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2062?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: I133e9368f9dfa9f10b4df8e503c3cf42f3a6d582 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 2062 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Marco Baffo &lt;marco@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--5k8T2hx9RUo=--


--===============1574782686885693128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1574782686885693128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1574782686885693128==--

