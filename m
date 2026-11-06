Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D82606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ObywkBLx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KTIDj+DU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KLazuSg5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OXwSssfV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3junoLTtb9FRml4ZD59sfCYRIohF8m2NvWF2WX13cEo=; b=ObywkBLxSJWm+C5Ko9/5d5Sgdf
	DN7kpwyJekMmESYsNCnywXDgzBdNDIj+ZLhgbhH3OaYV8Qeogc6nRLORoHbY6MDxx6/8vmRpUQufl
	1v6Ai47Da9WEK7CP7YOIDG/TbFBRU/fXpqKHcPWki4AVlrT0/XUrmvZhEWsuh0vHKH9I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPRut-000000002vP-0YUE;
	Fri, 06 Nov 2026 21:56:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPRup-000000002vH-2LCp
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 21:56:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9DyQw+eNJMwQ66G6Dxbl2dtjolcX+aFRslb6lPGuaX4=; b=KTIDj+DUbczC3QaHoAfUu+vG73
 1pSnKD/KQGEnmM0zGeKW0YXqQDtc+IngDRt2hZsouXy9Z9MOaU9NIHf6T2qrsMt9HiWsCjGxESqh8
 nz1hom4oW3uJXa3qrOSkE0JyL0LJPBIDrBjyY0BZx/egOP98TKpRrV3t5S42MET/U6oY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9DyQw+eNJMwQ66G6Dxbl2dtjolcX+aFRslb6lPGuaX4=; b=KLazuSg5pVeE7LCL04Jv0ehZVq
 DSe8M9uDLcWxlcifP6H3vuqBGBMnp3NfSKMEn83KmkBQ0znQZdVDny+bFJG2AFJV+BQY4fTKqF4/K
 vIKZ/FNHkuAT3oRX+qV6GqqA4w9Sp442YilgdAqhDye1vTYnaVAs3dJaXj9z8gTL4qTU=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPRul-000000003EU-0ir8 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 21:56:07 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso678031f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 13:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794002156; x=1794606956; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9DyQw+eNJMwQ66G6Dxbl2dtjolcX+aFRslb6lPGuaX4=;
 b=OXwSssfVMVP3nxlYQkrfzxn1gBjPrhoGC5AQ1fDU0uAsQicD1QHSAUPA2hFKqSKUio
 84zqZ66n/+56F5v/bTMyk11D9Df+3cxKUV4QeXlYgYeWkgGte1Y2TGdHCh4PdRZDb5M5
 Iejaxyshh5kySXlGcsD0j50/w0XRB9ov+8i5DAcjvNP35Xu8mE88T1qI8ADaEQdkE9lr
 avKqVBt8Xu2tluuPHVnw5dnBEJ/JGLHu9ePxxopP2+M5fTui7HTpnhC8h2rI2jyLfuEy
 RBrrj5FatHH6A+cgiypk41FZ4YmvZjkR7GvfSUIKzrQhRZqdW4d5jVtGTwxhWHwQf86D
 tAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002156; x=1794606956;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9DyQw+eNJMwQ66G6Dxbl2dtjolcX+aFRslb6lPGuaX4=;
 b=ECzqLTSDNQ19Tgx/W6fZDms/db+W7/o/QPvZ1ESzobPeSKjLU7K53YzB9wZlYyh0VQ
 Fr/yaG02G/nDU1xX7Vr/90l5Wt/UfcU1jSolFikGxwWBoTgf0cjpTnMzt9BVekKtXD1m
 s+EcruWIe7nHJ3A5BO5YHTP3tsm7AaSBsK5GoC54gyQzmdg15fKQiznAKLnhIqxpTCsj
 x8/i/SUU3H5IOHUtL/hYZzHFj9Hk74PArB8VKJUbJ31/yGMVIwLroXWn06UIZt6LWXQU
 PHZFE9bmzzbdeXnDtjzkHQEBUPHW9Gkq6dzbyeKbyvCxwweoANqTbhb94GiFq9kkSouz
 JEhw==
X-Gm-Message-State: APuU4Z/5FLVX3QI7DMOOhpmsC5NohvLl3Zv1Ri9P/cZXSrlI3edHdD2m
 DuXQkT7UHkeju3YvkfLXYBKry9F53CfIxr6k1H8EjzHNjEZ7ZMfDDpzTOXBxm6JLXjAjVy6kTVj
 DqfjD86kqf/0wpdMy9Ru8frg1q8Fg2wgyzmi6DJwl7atvZgJjtMa4TBLBQFhk4utK0ftf
X-Gm-Gg: AYBFou0c/5AnFjMB+n6ASejG0acGpKnOdAFGkRdhFGN/QeIdsP8UkYTnNAxtR6WHe/W
 vVfakwilg+cnOP3pV8StxNtTEpiox7h9bEgrzJLfNwsTbe5DEsJkyJ4u68SJs1o/bRYIjmfaGx7
 DSlijurYk90Gj8vdXiSdkBIt2iMnG/GtrmLqz1bg2kCKCi6HluNZKJ6gIoJVx3BGwhHy2i5GRjZ
 yU20l2ydRa9Sd/wGgQeYxfTVowHv3+aTypVyjE8r6dIrN5uggXyhZKSrZrK1diD2KX4X3yeTvsZ
 2t8qaXCiZ8sSGRaX8nHoqMrfDzW2nu3HgoJ7sLs5kj2whKYCDJ9QdB+aehk1xtC4TcLOmDsLZC3
 tO2kA3cjw9QfCHAuASA8EfaXq8XiBQSA66SXjWcZbq2AszjSbdKMup8adMnenEEUfks+9GnD4mW
 m4VOrAudMZLMAFXl/NdgU7Fg3QpnrnxDS2jD4Vz84Y2y21YT6Dch3A0w2Voodz2wW3mo7UVaw0v
 kr131tWHp5/k2wMipK6J1fbgGfHKdWOqrtXEjIt2I07aaN7/3o86uxVIkHGJ5OoIuLYhCX4ye05
 4EPR78Rw7eoLZpl8M2VDuKi5U6EdDT1fRQtRkswZpSkWN+H/O/VS9i7Dt4EnFkQg7WxCE5oGrSA
 9fYRrHsMDgCSsX4HXEVhTH49HKvoWHZwZx5QW9O0IHZ646sxov4Y5TUEkjY2afTpXAe0XpCz2Mo
 BtCAdGJTmAheaSqA==
X-Received: by 2002:a05:6000:230b:b0:492:dddc:64c3 with SMTP id
 ffacd0b85a97d-492ddeba90cmr6224796f8f.41.1794002156039; 
 Fri, 06 Nov 2026 13:55:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7233297sm5986982f8f.27.2026.11.06.13.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:55:55 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 21:55:54 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d
X-Gerrit-Change-Number: 2106
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2106?usp=email>
X-Gerrit-Commit: 5b08a76c1a3215c9c927909e695ccd8e83eb6895
In-Reply-To: <gerrit.1793709839000.Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d@gerrit.openvpn.net>
References: <gerrit.1793709839000.Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkllZTNmZjFmNWYzZWM5MzMxZjYxYjBhN2YxZjNiOWNhNTE1NzU1MzNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <85e2c00cdcd34dd0ed50aa678f20aad623c52be3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPRul-000000003EU-0ir8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make parameter
 openvpn_net_ctx_t const where possible
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6215444564029438065=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6215444564029438065==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VsD1tnFFW38="; charset=UTF-8

--VsD1tnFFW38=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by Antonio Quartulli, Code-Review+2 by R=C4=83zvan Cojocaru


Chang=
e subject: Make parameter openvpn_net_ctx_t const where possible
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make parameter openvpn=
_net_ctx_t const where possible

After move the gc_arena inside the various=
 iproute2 related
function most of the openvpn_net_ctx_t parameters can be =
made const=2E

This does not make net_ctx_free and net_ctx_reset const as t=
hose
functions are intended to modify the net ctx even though none of
them =
do anymore=2E

Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d
Signed-=
off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/210=
6
Message-Id: <20261103193058=2E14082-1-gert@greenie=2Emuc=2Ede>
URL: https=
://lore=2Ekernel=2Eorg/openvpn-devel/20261103193058=2E14082-1-gert@greenie=
=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src=
/openvpn/lladdr=2Ec
M src/openvpn/lladdr=2Eh
M src/openvpn/networking=2Eh
M=
 src/openvpn/networking_freebsd=2Ec
M src/openvpn/networking_iproute2=2Ec
M=
 src/openvpn/networking_sitnl=2Ec
6 files changed, 55 insertions(+), 55 del=
etions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/06/2106/2

diff --git a/src/openvpn/lladdr=2Ec b/src/openvpn/lladdr=2Ec=

index 554975c=2E=2E8bd572a 100644
--- a/src/openvpn/lladdr=2Ec
+++ b/src/o=
penvpn/lladdr=2Ec
@@ -15,7 +15,7 @@
 
 #ifdef TARGET_LINUX
 static int
-set=
_lladdr_linux(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladd=
r)
+set_lladdr_linux(const openvpn_net_ctx_t *ctx, const char *ifname, cons=
t char *lladdr)
 {
     uint8_t addr[OPENVPN_ETH_ALEN];
 
@@ -48,7 +48,7 @@=

 #endif /* TARGET_LINUX */
 
 int
-set_lladdr(openvpn_net_ctx_t *ctx, cons=
t char *ifname, const char *lladdr, const struct env_set *es)
+set_lladdr(c=
onst openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr, const =
struct env_set *es)
 {
     if (!ifname || !lladdr)
     {
diff --git a/src=
/openvpn/lladdr=2Eh b/src/openvpn/lladdr=2Eh
index 0c8b416=2E=2E9ab6578 100=
644
--- a/src/openvpn/lladdr=2Eh
+++ b/src/openvpn/lladdr=2Eh
@@ -5,5 +5,5 =
@@
 #include "misc=2Eh"
 #include "networking=2Eh"
 
-int set_lladdr(openvp=
n_net_ctx_t *ctx, const char *ifname, const char *lladdr,
+int set_lladdr(c=
onst openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr,
      =
          const struct env_set *es);
diff --git a/src/openvpn/networking=2E=
h b/src/openvpn/networking=2Eh
index 25233c8=2E=2E7ad6e2e 100644
--- a/src/=
openvpn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@@ -101,7 +101,7 @@=

  *
  * @return          0 on success, negative error code on error
  */
-=
int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,=
 const char *type,
+int net_iface_new(const openvpn_net_ctx_t *ctx, const o=
penvpn_net_iface_t *iface, const char *type,
                   const void =
*arg);
 
 /**
@@ -113,7 +113,7 @@
  *
  * @return          0 on success, a =
negative error code otherwise
  */
-int net_iface_type(openvpn_net_ctx_t *c=
tx, const char *iface, char type[IFACE_TYPE_LEN_MAX]);
+int net_iface_type(=
const openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_M=
AX]);
 
 /**
  * Remove an interface
@@ -122,7 +122,7 @@
  * @param iface  =
   interface to delete
  * @return int 0 on success, negative error code on=
 error
  */
-int net_iface_del(openvpn_net_ctx_t *ctx, const openvpn_net_if=
ace_t *iface);
+int net_iface_del(const openvpn_net_ctx_t *ctx, const openv=
pn_net_iface_t *iface);
 
 /**
  * Bring interface up or down=2E
@@ -133,7 =
+133,7 @@
  *
  * @return          0 on success, a negative error code othe=
rwise
  */
-int net_iface_up(openvpn_net_ctx_t *ctx, const openvpn_net_ifac=
e_t *iface, bool up);
+int net_iface_up(const openvpn_net_ctx_t *ctx, const=
 openvpn_net_iface_t *iface, bool up);
 
 /**
  * Set the MTU for an interf=
ace
@@ -144,7 +144,7 @@
  *
  * @return          0 on success, a negative e=
rror code otherwise
  */
-int net_iface_mtu_set(openvpn_net_ctx_t *ctx, con=
st openvpn_net_iface_t *iface, uint32_t mtu);
+int net_iface_mtu_set(const =
openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint32_t mtu);
 
=
 /**
  * Set the Link Layer (Ethernet) address of the TAP interface
@@ -155=
,7 +155,7 @@
  *
  * @return          0 on success, a negative error code o=
therwise
  */
-int net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_ne=
t_iface_t *iface, uint8_t *addr);
+int net_addr_ll_set(const openvpn_net_ct=
x_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr);
 
 /**
  * Add =
an IPv4 address to an interface
@@ -167,7 +167,7 @@
  *
  * @return        =
  0 on success, a negative error code otherwise
  */
-int net_addr_v4_add(o=
penvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const in_addr_t *a=
ddr,
+int net_addr_v4_add(const openvpn_net_ctx_t *ctx, const openvpn_net_i=
face_t *iface, const in_addr_t *addr,
                     int prefixlen);
=
 
 /**
@@ -181,7 +181,7 @@
  * @return          0 on success, a negative er=
ror code otherwise
  */
 
-int net_addr_v6_add(openvpn_net_ctx_t *ctx, cons=
t openvpn_net_iface_t *iface,
+int net_addr_v6_add(const openvpn_net_ctx_t =
*ctx, const openvpn_net_iface_t *iface,
                     const struct i=
n6_addr *addr, int prefixlen);
 
 /**
@@ -193,7 +193,7 @@
  *
  * @return  =
        0 on success, a negative error code otherwise
  */
-int net_addr_v4=
_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const in_add=
r_t *addr,
+int net_addr_v4_del(const openvpn_net_ctx_t *ctx, const openvpn=
_net_iface_t *iface, const in_addr_t *addr,
                     int prefix=
len);
 
 /**
@@ -205,7 +205,7 @@
  *
  * @return          0 on success, a n=
egative error code otherwise
  */
-int net_addr_v6_del(openvpn_net_ctx_t *c=
tx, const openvpn_net_iface_t *iface,
+int net_addr_v6_del(const openvpn_ne=
t_ctx_t *ctx, const openvpn_net_iface_t *iface,
                     const =
struct in6_addr *addr, int prefixlen);
 
 /**
@@ -218,7 +218,7 @@
  *
  * @=
return          0 on success, a negative error code otherwise
  */
-int net=
_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
=
+int net_addr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const openvpn_net_if=
ace_t *iface,
                         const in_addr_t *local, const in_add=
r_t *remote);
 
 /**
@@ -231,7 +231,7 @@
  *
  * @return          0 on succ=
ess, a negative error code otherwise
  */
-int net_addr_ptp_v4_del(openvpn_=
net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+int net_addr_ptp_v4_del(=
const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
           =
              const in_addr_t *local, const in_addr_t *remote);
 
 #endif /=
* ENABLE_SITNL || ENABLE_IPROUTE */
@@ -251,7 +251,7 @@
  *
  * @return    =
      0 on success, a negative error code otherwise
  */
-int net_route_v4_=
add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
+int net_r=
oute_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixl=
en,
                      const in_addr_t *gw, const openvpn_net_iface_t *i=
face, uint32_t table,
                      int metric);
 
@@ -269,7 +269,7=
 @@
  *
  * @return          0 on success, a negative error code otherwise
=
  */
-int net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *d=
st, int prefixlen,
+int net_route_v6_add(const openvpn_net_ctx_t *ctx, cons=
t struct in6_addr *dst, int prefixlen,
                      const struct i=
n6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,
            =
          int metric);
 
@@ -287,7 +287,7 @@
  *
  * @return          0 on =
success, a negative error code otherwise
  */
-int net_route_v4_del(openvpn=
_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
+int net_route_v4_del=
(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
       =
               const in_addr_t *gw, const openvpn_net_iface_t *iface, uint3=
2_t table,
                      int metric);
 
@@ -305,7 +305,7 @@
  *
  *=
 @return          0 on success, a negative error code otherwise
  */
-int n=
et_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int pre=
fixlen,
+int net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in=
6_addr *dst, int prefixlen,
                      const struct in6_addr *gw=
, const openvpn_net_iface_t *iface, uint32_t table,
                      i=
nt metric);
 
diff --git a/src/openvpn/networking_freebsd=2Ec b/src/openvpn=
/networking_freebsd=2Ec
index 04051a6=2E=2E88fd5c0 100644
--- a/src/openvpn=
/networking_freebsd=2Ec
+++ b/src/openvpn/networking_freebsd=2Ec
@@ -82,28 =
+82,28 @@
 }
 
 int
-net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr=
_t *dst, int prefixlen, const in_addr_t *gw,
+net_route_v4_add(const openvp=
n_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,=

                  const char *iface, uint32_t table, int metric)
 {
     r=
eturn net_route_v4("add", dst, prefixlen, gw, iface, table, metric);
 }
 
 =
int
-net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, i=
nt prefixlen,
+net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct =
in6_addr *dst, int prefixlen,
                  const struct in6_addr *gw, =
const char *iface, uint32_t table, int metric)
 {
     return net_route_v6(=
"add", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
-net_route_v4_d=
el(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_ad=
dr_t *gw,
+net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *=
dst, int prefixlen, const in_addr_t *gw,
                  const char *ifac=
e, uint32_t table, int metric)
 {
     return net_route_v4("del", dst, pref=
ixlen, gw, iface, table, metric);
 }
 
 int
-net_route_v6_del(openvpn_net_c=
tx_t *ctx, const struct in6_addr *dst, int prefixlen,
+net_route_v6_del(con=
st openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
     =
             const struct in6_addr *gw, const char *iface, uint32_t table, =
int metric)
 {
     return net_route_v6("del", dst, prefixlen, gw, iface, t=
able, metric);
diff --git a/src/openvpn/networking_iproute2=2Ec b/src/openv=
pn/networking_iproute2=2Ec
index 7a0f4f7=2E=2Ed987478 100644
--- a/src/open=
vpn/networking_iproute2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -5=
9,7 +59,7 @@
 }
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *i=
face, const char *type, const void *arg)
+net_iface_new(const openvpn_net_c=
tx_t *ctx, const char *iface, const char *type, const void *arg)
 {
     st=
ruct argv argv =3D argv_new();
 
@@ -73,7 +73,7 @@
 }
 
 int
-net_iface_typ=
e(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])=

+net_iface_type(const openvpn_net_ctx_t *ctx, const char *iface, char type=
[IFACE_TYPE_LEN_MAX])
 {
     /* not supported by iproute2 */
     msg(M_WA=
RN, "%s: operation not supported by iproute2 backend", __func__);
@@ -81,7 =
+81,7 @@
 }
 
 int
-net_iface_del(openvpn_net_ctx_t *ctx, const char *iface=
)
+net_iface_del(const openvpn_net_ctx_t *ctx, const char *iface)
 {
     s=
truct argv argv =3D argv_new();
 
@@ -94,7 +94,7 @@
 }
 
 int
-net_iface_up=
(openvpn_net_ctx_t *ctx, const char *iface, bool up)
+net_iface_up(const op=
envpn_net_ctx_t *ctx, const char *iface, bool up)
 {
     struct argv argv =
=3D argv_new();
 
@@ -108,7 +108,7 @@
 }
 
 int
-net_iface_mtu_set(openvpn_=
net_ctx_t *ctx, const char *iface, uint32_t mtu)
+net_iface_mtu_set(const o=
penvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
     struct argv=
 argv =3D argv_new();
 
@@ -122,7 +122,7 @@
 }
 
 int
-net_addr_ll_set(open=
vpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)
+net_a=
ddr_ll_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, =
uint8_t *addr)
 {
     struct argv argv =3D argv_new();
     int ret =3D 0;=

@@ -142,7 +142,7 @@
 }
 
 int
-net_addr_v4_add(openvpn_net_ctx_t *ctx, con=
st char *iface, const in_addr_t *addr, int prefixlen)
+net_addr_v4_add(cons=
t openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int pre=
fixlen)
 {
     struct argv argv =3D argv_new();
 
@@ -158,7 +158,7 @@
 }
 =

 int
-net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface, const str=
uct in6_addr *addr,
+net_addr_v6_add(const openvpn_net_ctx_t *ctx, const ch=
ar *iface, const struct in6_addr *addr,
                 int prefixlen)
 {
=
     struct argv argv =3D argv_new();
@@ -174,7 +174,7 @@
 }
 
 int
-net_ad=
dr_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr,=
 int prefixlen)
+net_addr_v4_del(const openvpn_net_ctx_t *ctx, const char *=
iface, const in_addr_t *addr, int prefixlen)
 {
     struct argv argv =3D a=
rgv_new();
     const char *addr_str =3D print_in_addr_t(*addr, 0, &argv=2E=
gc);
@@ -190,7 +190,7 @@
 }
 
 int
-net_addr_v6_del(openvpn_net_ctx_t *ctx,=
 const char *iface, const struct in6_addr *addr,
+net_addr_v6_del(const ope=
nvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
      =
           int prefixlen)
 {
     struct argv argv =3D argv_new();
@@ -206,=
7 +206,7 @@
 }
 
 int
-net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const ch=
ar *iface, const in_addr_t *local,
+net_addr_ptp_v4_add(const openvpn_net_c=
tx_t *ctx, const char *iface, const in_addr_t *local,
                     =
const in_addr_t *remote)
 {
     struct argv argv =3D argv_new();
@@ -224,7=
 +224,7 @@
 }
 
 int
-net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const cha=
r *iface, const in_addr_t *local,
+net_addr_ptp_v4_del(const openvpn_net_ct=
x_t *ctx, const char *iface, const in_addr_t *local,
                     c=
onst in_addr_t *remote)
 {
     struct argv argv =3D argv_new();
@@ -242,7 =
+242,7 @@
 }
 
 int
-net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr=
_t *dst, int prefixlen, const in_addr_t *gw,
+net_route_v4_add(const openvp=
n_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,=

                  const char *iface, uint32_t table, int metric)
 {
     s=
truct argv argv =3D argv_new();
@@ -280,7 +280,7 @@
 }
 
 int
-net_route_v6=
_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+ne=
t_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, in=
t prefixlen,
                  const struct in6_addr *gw, const char *iface=
, uint32_t table, int metric)
 {
     struct argv argv =3D argv_new();
@@ -=
313,7 +313,7 @@
 }
 
 int
-net_route_v4_del(openvpn_net_ctx_t *ctx, const i=
n_addr_t *dst, int prefixlen, const in_addr_t *gw,
+net_route_v4_del(const =
openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_=
t *gw,
                  const char *iface, uint32_t table, int metric)
 {
=
     struct argv argv =3D argv_new();
@@ -339,7 +339,7 @@
 }
 
 int
-net_ro=
ute_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixle=
n,
+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *d=
st, int prefixlen,
                  const struct in6_addr *gw, const char =
*iface, uint32_t table, int metric)
 {
     struct argv argv =3D argv_new()=
;
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_si=
tnl=2Ec
index 0c99d38=2E=2E97ff7bd 100644
--- a/src/openvpn/networking_sitn=
l=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -669,7 +669,7 @@
 #ifdef EN=
ABLE_SITNL
 
 int
-net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, =
bool up)
+net_iface_up(const openvpn_net_ctx_t *ctx, const char *iface, boo=
l up)
 {
     struct sitnl_link_req req;
     int ifindex;
@@ -711,7 +711,7=
 @@
 }
 
 int
-net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface,=
 uint32_t mtu)
+net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char =
*iface, uint32_t mtu)
 {
     struct sitnl_link_req req;
     int ifindex, =
ret =3D -1;
@@ -742,7 +742,7 @@
 }
 
 int
-net_addr_ll_set(openvpn_net_ctx_=
t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)
+net_addr_ll_set(c=
onst openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *add=
r)
 {
     struct sitnl_link_req req;
     int ifindex, ret =3D -1;
@@ -103=
8,7 +1038,7 @@
 }
 
 int
-net_addr_v4_add(openvpn_net_ctx_t *ctx, const cha=
r *iface, const in_addr_t *addr, int prefixlen)
+net_addr_v4_add(const open=
vpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen=
)
 {
     inet_address_t addr_v4 =3D { 0 };
     char buf[INET_ADDRSTRLEN];=

@@ -1057,7 +1057,7 @@
 }
 
 int
-net_addr_v6_add(openvpn_net_ctx_t *ctx, c=
onst char *iface, const struct in6_addr *addr,
+net_addr_v6_add(const openv=
pn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
        =
         int prefixlen)
 {
     inet_address_t addr_v6 =3D { 0 };
@@ -1077,=
7 +1077,7 @@
 }
 
 int
-net_addr_v4_del(openvpn_net_ctx_t *ctx, const char =
*iface, const in_addr_t *addr, int prefixlen)
+net_addr_v4_del(const openvp=
n_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
=
 {
     inet_address_t addr_v4 =3D { 0 };
     char buf[INET_ADDRSTRLEN];
@=
@ -1096,7 +1096,7 @@
 }
 
 int
-net_addr_v6_del(openvpn_net_ctx_t *ctx, con=
st char *iface, const struct in6_addr *addr,
+net_addr_v6_del(const openvpn=
_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
          =
       int prefixlen)
 {
     inet_address_t addr_v6 =3D { 0 };
@@ -1116,7 =
+1116,7 @@
 }
 
 int
-net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const cha=
r *iface, const in_addr_t *local,
+net_addr_ptp_v4_add(const openvpn_net_ct=
x_t *ctx, const char *iface, const in_addr_t *local,
                     c=
onst in_addr_t *remote)
 {
     inet_address_t local_v4 =3D { 0 };
@@ -1144=
,7 +1144,7 @@
 }
 
 int
-net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const =
char *iface, const in_addr_t *local,
+net_addr_ptp_v4_del(const openvpn_net=
_ctx_t *ctx, const char *iface, const in_addr_t *local,
                   =
  const in_addr_t *remote)
 {
     inet_address_t local_v4 =3D { 0 };
@@ -1=
196,7 +1196,7 @@
 }
 
 int
-net_route_v4_add(openvpn_net_ctx_t *ctx, const =
in_addr_t *dst, int prefixlen, const in_addr_t *gw,
+net_route_v4_add(const=
 openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr=
_t *gw,
                  const char *iface, uint32_t table, int metric)
 {=

     const in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;
@@ -1224,7 +1224=
,7 @@
 }
 
 int
-net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_=
addr *dst, int prefixlen,
+net_route_v6_add(const openvpn_net_ctx_t *ctx, c=
onst struct in6_addr *dst, int prefixlen,
                  const struct in=
6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     inet_add=
ress_t dst_v6 =3D { 0 };
@@ -1275,7 +1275,7 @@
 }
 
 int
-net_route_v4_del(=
openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_=
t *gw,
+net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst=
, int prefixlen, const in_addr_t *gw,
                  const char *iface, =
uint32_t table, int metric)
 {
     inet_address_t dst_v4 =3D { 0 };
@@ -13=
01,7 +1301,7 @@
 }
 
 int
-net_route_v6_del(openvpn_net_ctx_t *ctx, const s=
truct in6_addr *dst, int prefixlen,
+net_route_v6_del(const openvpn_net_ctx=
_t *ctx, const struct in6_addr *dst, int prefixlen,
                  const=
 struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
   =
  inet_address_t dst_v6 =3D { 0 };
@@ -1328,7 +1328,7 @@
 
 
 int
-net_ifac=
e_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const vo=
id *arg)
+net_iface_new(const openvpn_net_ctx_t *ctx, const char *iface, co=
nst char *type, const void *arg)
 {
     struct sitnl_link_req req =3D {};
=
     int ret =3D -1;
@@ -1431,7 +1431,7 @@
 }
 
 int
-net_iface_type(openvp=
n_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
+net_if=
ace_type(const openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_T=
YPE_LEN_MAX])
 {
     struct sitnl_link_req req =3D {};
     int ifindex =
=3D if_nametoindex(iface);
@@ -1463,7 +1463,7 @@
 }
 
 int
-net_iface_del(o=
penvpn_net_ctx_t *ctx, const char *iface)
+net_iface_del(const openvpn_net_=
ctx_t *ctx, const char *iface)
 {
     struct sitnl_link_req req =3D {};
  =
   int ifindex =3D if_nametoindex(iface);

-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d
Gerrit=
-Change-Number: 2106
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--VsD1tnFFW38=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/210=
6?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by Antonio Quartulli, Code-Review+2 by R=C4=
=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">Make parameter openvpn_net_ctx_t const wh=
ere possible<br><br>After move the gc_arena inside the various iproute2 rel=
ated<br>function most of the openvpn_net_ctx_t parameters can be made const=
=2E<br><br>This does not make net_ctx_free and net_ctx_reset const as those=
<br>functions are intended to modify the net ctx even though none of<br>the=
m do anymore=2E<br><br>Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d=
<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Raz=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2106<br>Message-Id: &lt;20261103193058=2E14082-1-=
gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-dev=
el/20261103193058=2E14082-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/lladdr=2Ec<=
br>M src/openvpn/lladdr=2Eh<br>M src/openvpn/networking=2Eh<br>M src/openvp=
n/networking_freebsd=2Ec<br>M src/openvpn/networking_iproute2=2Ec<br>M src/=
openvpn/networking_sitnl=2Ec<br>6 files changed, 55 insertions(+), 55 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/06/2106/2</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/lladdr=
=2Ec b/src/openvpn/lladdr=2Ec</span><br><span>index 554975c=2E=2E8bd572a 10=
0644</span><br><span>--- a/src/openvpn/lladdr=2Ec</span><br><span>+++ b/src=
/openvpn/lladdr=2Ec</span><br><span>@@ -15,7 +15,7 @@</span><br><span> </sp=
an><br><span> #ifdef TARGET_LINUX</span><br><span> static int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-set_lladdr_linux(openvpn_net_ctx_t =
*ctx, const char *ifname, const char *lladdr)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+set_lladdr_linux(const openvpn_net_ctx_t *ctx, co=
nst char *ifname, const char *lladdr)</span><br><span> {</span><br><span>  =
   uint8_t addr[OPENVPN_ETH_ALEN];</span><br><span> </span><br><span>@@ -48=
,7 +48,7 @@</span><br><span> #endif /* TARGET_LINUX */</span><br><span> </s=
pan><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set=
_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr, con=
st struct env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+set_lladdr(const openvpn_net_ctx_t *ctx, const char *ifname, const char =
*lladdr, const struct env_set *es)</span><br><span> {</span><br><span>     =
if (!ifname || !lladdr)</span><br><span>     {</span><br><span>diff --git a=
/src/openvpn/lladdr=2Eh b/src/openvpn/lladdr=2Eh</span><br><span>index 0c8b=
416=2E=2E9ab6578 100644</span><br><span>--- a/src/openvpn/lladdr=2Eh</span>=
<br><span>+++ b/src/openvpn/lladdr=2Eh</span><br><span>@@ -5,5 +5,5 @@</spa=
n><br><span> #include &quot;misc=2Eh&quot;</span><br><span> #include &quot;=
networking=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-int set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname,=
 const char *lladdr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+int set_lladdr(const openvpn_net_ctx_t *ctx, const char *ifname, const cha=
r *lladdr,</span><br><span>                const struct env_set *es);</span=
><br><span>diff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=
=2Eh</span><br><span>index 25233c8=2E=2E7ad6e2e 100644</span><br><span>--- =
a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/openvpn/networking=
=2Eh</span><br><span>@@ -101,7 +101,7 @@</span><br><span>  *</span><br><spa=
n>  * @return          0 on success, negative error code on error</span><br=
><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_if=
ace_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const cha=
r *type,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int net_ifa=
ce_new(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, cons=
t char *type,</span><br><span>                   const void *arg);</span><b=
r><span> </span><br><span> /**</span><br><span>@@ -113,7 +113,7 @@</span><b=
r><span>  *</span><br><span>  * @return          0 on success, a negative e=
rror code otherwise</span><br><span>  */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-int net_iface_type(openvpn_net_ctx_t *ctx, const char *i=
face, char type[IFACE_TYPE_LEN_MAX]);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+int net_iface_type(const openvpn_net_ctx_t *ctx, const ch=
ar *iface, char type[IFACE_TYPE_LEN_MAX]);</span><br><span> </span><br><spa=
n> /**</span><br><span>  * Remove an interface</span><br><span>@@ -122,7 +1=
22,7 @@</span><br><span>  * @param iface     interface to delete</span><br>=
<span>  * @return int 0 on success, negative error code on error</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_ifa=
ce_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+int net_iface_del(const openv=
pn_net_ctx_t *ctx, const openvpn_net_iface_t *iface);</span><br><span> </sp=
an><br><span> /**</span><br><span>  * Bring interface up or down=2E</span><=
br><span>@@ -133,7 +133,7 @@</span><br><span>  *</span><br><span>  * @retur=
n          0 on success, a negative error code otherwise</span><br><span>  =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_iface_up(op=
envpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, bool up);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+int net_iface_up(const openvp=
n_net_ctx_t *ctx, const openvpn_net_iface_t *iface, bool up);</span><br><sp=
an> </span><br><span> /**</span><br><span>  * Set the MTU for an interface<=
/span><br><span>@@ -144,7 +144,7 @@</span><br><span>  *</span><br><span>  *=
 @return          0 on success, a negative error code otherwise</span><br><=
span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_ifac=
e_mtu_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint32_=
t mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int net_ifac=
e_mtu_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, u=
int32_t mtu);</span><br><span> </span><br><span> /**</span><br><span>  * Se=
t the Link Layer (Ethernet) address of the TAP interface</span><br><span>@@=
 -155,7 +155,7 @@</span><br><span>  *</span><br><span>  * @return          =
0 on success, a negative error code otherwise</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-int net_addr_ll_set(openvpn_ne=
t_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int net_addr_ll_set(const openv=
pn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr);</span>=
<br><span> </span><br><span> /**</span><br><span>  * Add an IPv4 address to=
 an interface</span><br><span>@@ -167,7 +167,7 @@</span><br><span>  *</span=
><br><span>  * @return          0 on success, a negative error code otherwi=
se</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-int net_addr_v4_add(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *if=
ace, const in_addr_t *addr,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+int net_addr_v4_add(const openvpn_net_ctx_t *ctx, const openvpn_net=
_iface_t *iface, const in_addr_t *addr,</span><br><span>                   =
  int prefixlen);</span><br><span> </span><br><span> /**</span><br><span>@@=
 -181,7 +181,7 @@</span><br><span>  * @return          0 on success, a nega=
tive error code otherwise</span><br><span>  */</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-int net_addr_v6_add(openvpn_net_=
ctx_t *ctx, const openvpn_net_iface_t *iface,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+int net_addr_v6_add(const openvpn_net_ctx_t *ctx,=
 const openvpn_net_iface_t *iface,</span><br><span>                     con=
st struct in6_addr *addr, int prefixlen);</span><br><span> </span><br><span=
> /**</span><br><span>@@ -193,7 +193,7 @@</span><br><span>  *</span><br><sp=
an>  * @return          0 on success, a negative error code otherwise</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int ne=
t_addr_v4_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, con=
st in_addr_t *addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int net_addr_v4_del(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t=
 *iface, const in_addr_t *addr,</span><br><span>                     int pr=
efixlen);</span><br><span> </span><br><span> /**</span><br><span>@@ -205,7 =
+205,7 @@</span><br><span>  *</span><br><span>  * @return          0 on suc=
cess, a negative error code otherwise</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-int net_addr_v6_del(openvpn_net_ctx_t =
*ctx, const openvpn_net_iface_t *iface,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+int net_addr_v6_del(const openvpn_net_ctx_t *ctx, const=
 openvpn_net_iface_t *iface,</span><br><span>                     const str=
uct in6_addr *addr, int prefixlen);</span><br><span> </span><br><span> /**<=
/span><br><span>@@ -218,7 +218,7 @@</span><br><span>  *</span><br><span>  *=
 @return          0 on success, a negative error code otherwise</span><br><=
span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_addr=
_ptp_v4_add(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+int net_addr_ptp_v4_add(c=
onst openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,</span><br><s=
pan>                         const in_addr_t *local, const in_addr_t *remot=
e);</span><br><span> </span><br><span> /**</span><br><span>@@ -231,7 +231,7=
 @@</span><br><span>  *</span><br><span>  * @return          0 on success, =
a negative error code otherwise</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int net_addr_ptp_v4_del(openvpn_net_ctx_t *=
ctx, const openvpn_net_iface_t *iface,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+int net_addr_ptp_v4_del(const openvpn_net_ctx_t *ctx, co=
nst openvpn_net_iface_t *iface,</span><br><span>                         co=
nst in_addr_t *local, const in_addr_t *remote);</span><br><span> </span><br=
><span> #endif /* ENABLE_SITNL || ENABLE_IPROUTE */</span><br><span>@@ -251=
,7 +251,7 @@</span><br><span>  *</span><br><span>  * @return          0 on =
success, a negative error code otherwise</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-int net_route_v4_add(openvpn_net_ct=
x_t *ctx, const in_addr_t *dst, int prefixlen,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+int net_route_v4_add(const openvpn_net_ctx_t *ct=
x, const in_addr_t *dst, int prefixlen,</span><br><span>                   =
   const in_addr_t *gw, const openvpn_net_iface_t *iface, uint32_t table,</=
span><br><span>                      int metric);</span><br><span> </span><=
br><span>@@ -269,7 +269,7 @@</span><br><span>  *</span><br><span>  * @retur=
n          0 on success, a negative error code otherwise</span><br><span>  =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int net_route_v6_ad=
d(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+int net_route_v6_add(const=
 openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><=
br><span>                      const struct in6_addr *gw, const openvpn_net=
_iface_t *iface, uint32_t table,</span><br><span>                      int =
metric);</span><br><span> </span><br><span>@@ -287,7 +287,7 @@</span><br><s=
pan>  *</span><br><span>  * @return          0 on success, a negative error=
 code otherwise</span><br><span>  */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-int net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t=
 *dst, int prefixlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, =
int prefixlen,</span><br><span>                      const in_addr_t *gw, c=
onst openvpn_net_iface_t *iface, uint32_t table,</span><br><span>          =
            int metric);</span><br><span> </span><br><span>@@ -305,7 +305,7=
 @@</span><br><span>  *</span><br><span>  * @return          0 on success, =
a negative error code otherwise</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int net_route_v6_del(openvpn_net_ctx_t *ctx=
, const struct in6_addr *dst, int prefixlen,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+int net_route_v6_del(const openvpn_net_ctx_t *ctx,=
 const struct in6_addr *dst, int prefixlen,</span><br><span>               =
       const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_=
t table,</span><br><span>                      int metric);</span><br><span=
> </span><br><span>diff --git a/src/openvpn/networking_freebsd=2Ec b/src/op=
envpn/networking_freebsd=2Ec</span><br><span>index 04051a6=2E=2E88fd5c0 100=
644</span><br><span>--- a/src/openvpn/networking_freebsd=2Ec</span><br><spa=
n>+++ b/src/openvpn/networking_freebsd=2Ec</span><br><span>@@ -82,28 +82,28=
 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-net_route_v4_add(openvpn_net_ctx_t =
*ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+net_route_v4_add(const openvpn_=
net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</=
span><br><span>                  const char *iface, uint32_t table, int met=
ric)</span><br><span> {</span><br><span>     return net_route_v4(&quot;add&=
quot;, dst, prefixlen, gw, iface, table, metric);</span><br><span> }</span>=
<br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *=
dst, int prefixlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, =
int prefixlen,</span><br><span>                  const struct in6_addr *gw,=
 const char *iface, uint32_t table, int metric)</span><br><span> {</span><b=
r><span>     return net_route_v6(&quot;add&quot;, dst, prefixlen, gw, iface=
, table, metric);</span><br><span> }</span><br><span> </span><br><span> int=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_route_v4_del(open=
vpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *g=
w,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_v4_del(=
const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in=
_addr_t *gw,</span><br><span>                  const char *iface, uint32_t =
table, int metric)</span><br><span> {</span><br><span>     return net_route=
_v4(&quot;del&quot;, dst, prefixlen, gw, iface, table, metric);</span><br><=
span> }</span><br><span> </span><br><span> int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-net_route_v6_del(openvpn_net_ctx_t *ctx, const str=
uct in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct i=
n6_addr *dst, int prefixlen,</span><br><span>                  const struct=
 in6_addr *gw, const char *iface, uint32_t table, int metric)</span><br><sp=
an> {</span><br><span>     return net_route_v6(&quot;del&quot;, dst, prefix=
len, gw, iface, table, metric);</span><br><span>diff --git a/src/openvpn/ne=
tworking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span=
>index 7a0f4f7=2E=2Ed987478 100644</span><br><span>--- a/src/openvpn/networ=
king_iproute2=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec=
</span><br><span>@@ -59,7 +59,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_=
iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, cons=
t void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ifa=
ce_new(const openvpn_net_ctx_t *ctx, const char *iface, const char *type, c=
onst void *arg)</span><br><span> {</span><br><span>     struct argv argv =
=3D argv_new();</span><br><span> </span><br><span>@@ -73,7 +73,7 @@</span><=
br><span> }</span><br><span> </span><br><span> int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-net_iface_type(openvpn_net_ctx_t *ctx, const c=
har *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+net_iface_type(const openvpn_net_ctx_t *ctx, const c=
har *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span> {</span><br><sp=
an>     /* not supported by iproute2 */</span><br><span>     msg(M_WARN, &q=
uot;%s: operation not supported by iproute2 backend&quot;, __func__);</span=
><br><span>@@ -81,7 +81,7 @@</span><br><span> }</span><br><span> </span><br=
><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_=
del(openvpn_net_ctx_t *ctx, const char *iface)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+net_iface_del(const openvpn_net_ctx_t *ctx, cons=
t char *iface)</span><br><span> {</span><br><span>     struct argv argv =3D=
 argv_new();</span><br><span> </span><br><span>@@ -94,7 +94,7 @@</span><br>=
<span> }</span><br><span> </span><br><span> int</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-net_iface_up(openvpn_net_ctx_t *ctx, const char *=
iface, bool up)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_=
iface_up(const openvpn_net_ctx_t *ctx, const char *iface, bool up)</span><b=
r><span> {</span><br><span>     struct argv argv =3D argv_new();</span><br>=
<span> </span><br><span>@@ -108,7 +108,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t =
mtu)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_mtu_s=
et(const openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)</span><br=
><span> {</span><br><span>     struct argv argv =3D argv_new();</span><br><=
span> </span><br><span>@@ -122,7 +122,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *ifac=
e, uint8_t *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ne=
t_addr_ll_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *ifac=
e, uint8_t *addr)</span><br><span> {</span><br><span>     struct argv argv =
=3D argv_new();</span><br><span>     int ret =3D 0;</span><br><span>@@ -142=
,7 +142,7 @@</span><br><span> }</span><br><span> </span><br><span> int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-net_addr_v4_add(openvpn_ne=
t_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+net_addr_v4_add(const op=
envpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixl=
en)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new()=
;</span><br><span> </span><br><span>@@ -158,7 +158,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface,=
 const struct in6_addr *addr,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *iface, =
const struct in6_addr *addr,</span><br><span>                 int prefixlen=
)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new();<=
/span><br><span>@@ -174,7 +174,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net=
_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *ad=
dr, int prefixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+n=
et_addr_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_ad=
dr_t *addr, int prefixlen)</span><br><span> {</span><br><span>     struct a=
rgv argv =3D argv_new();</span><br><span>     const char *addr_str =3D prin=
t_in_addr_t(*addr, 0, &amp;argv=2Egc);</span><br><span>@@ -190,7 +190,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-net_addr_v6_del(openvpn_net_ctx_t *ctx,=
 const char *iface, const struct in6_addr *addr,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+net_addr_v6_del(const openvpn_net_ctx_t *ctx, =
const char *iface, const struct in6_addr *addr,</span><br><span>           =
      int prefixlen)</span><br><span> {</span><br><span>     struct argv ar=
gv =3D argv_new();</span><br><span>@@ -206,7 +206,7 @@</span><br><span> }</=
span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const char *ifa=
ce, const in_addr_t *local,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+net_addr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const char *iface=
, const in_addr_t *local,</span><br><span>                     const in_add=
r_t *remote)</span><br><span> {</span><br><span>     struct argv argv =3D a=
rgv_new();</span><br><span>@@ -224,7 +224,7 @@</span><br><span> }</span><br=
><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const char *iface, cons=
t in_addr_t *local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
net_addr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const =
in_addr_t *local,</span><br><span>                     const in_addr_t *rem=
ote)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new(=
);</span><br><span>@@ -242,7 +242,7 @@</span><br><span> }</span><br><span> =
</span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixle=
n, const in_addr_t *gw,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, in=
t prefixlen, const in_addr_t *gw,</span><br><span>                  const c=
har *iface, uint32_t table, int metric)</span><br><span> {</span><br><span>=
     struct argv argv =3D argv_new();</span><br><span>@@ -280,7 +280,7 @@</=
span><br><span> }</span><br><span> </span><br><span> int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-net_route_v6_add(openvpn_net_ctx_t *ctx,=
 const struct in6_addr *dst, int prefixlen,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+net_route_v6_add(const openvpn_net_ctx_t *ctx, cons=
t struct in6_addr *dst, int prefixlen,</span><br><span>                  co=
nst struct in6_addr *gw, const char *iface, uint32_t table, int metric)</sp=
an><br><span> {</span><br><span>     struct argv argv =3D argv_new();</span=
><br><span>@@ -313,7 +313,7 @@</span><br><span> }</span><br><span> </span><=
br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_rout=
e_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const=
 in_addr_t *gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_=
route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefix=
len, const in_addr_t *gw,</span><br><span>                  const char *ifa=
ce, uint32_t table, int metric)</span><br><span> {</span><br><span>     str=
uct argv argv =3D argv_new();</span><br><span>@@ -339,7 +339,7 @@</span><br=
><span> }</span><br><span> </span><br><span> int</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-net_route_v6_del(openvpn_net_ctx_t *ctx, const s=
truct in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct=
 in6_addr *dst, int prefixlen,</span><br><span>                  const stru=
ct in6_addr *gw, const char *iface, uint32_t table, int metric)</span><br><=
span> {</span><br><span>     struct argv argv =3D argv_new();</span><br><sp=
an>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_s=
itnl=2Ec</span><br><span>index 0c99d38=2E=2E97ff7bd 100644</span><br><span>=
--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/ne=
tworking_sitnl=2Ec</span><br><span>@@ -669,7 +669,7 @@</span><br><span> #if=
def ENABLE_SITNL</span><br><span> </span><br><span> int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-net_iface_up(openvpn_net_ctx_t *ctx, cons=
t char *iface, bool up)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+net_iface_up(const openvpn_net_ctx_t *ctx, const char *iface, bool up)<=
/span><br><span> {</span><br><span>     struct sitnl_link_req req;</span><b=
r><span>     int ifindex;</span><br><span>@@ -711,7 +711,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char=
 *iface, uint32_t mtu)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uint3=
2_t mtu)</span><br><span> {</span><br><span>     struct sitnl_link_req req;=
</span><br><span>     int ifindex, ret =3D -1;</span><br><span>@@ -742,7 +7=
42,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-net_addr_ll_set(openvpn_net_ctx=
_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+net_addr_ll_set(const openvpn_net_ctx=
_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)</span><br><span> =
{</span><br><span>     struct sitnl_link_req req;</span><br><span>     int =
ifindex, ret =3D -1;</span><br><span>@@ -1038,7 +1038,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *ifa=
ce, const in_addr_t *addr, int prefixlen)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+net_addr_v4_add(const openvpn_net_ctx_t *ctx, const c=
har *iface, const in_addr_t *addr, int prefixlen)</span><br><span> {</span>=
<br><span>     inet_address_t addr_v4 =3D { 0 };</span><br><span>     char =
buf[INET_ADDRSTRLEN];</span><br><span>@@ -1057,7 +1057,7 @@</span><br><span=
> }</span><br><span> </span><br><span> int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *if=
ace, const struct in6_addr *addr,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *ifa=
ce, const struct in6_addr *addr,</span><br><span>                 int prefi=
xlen)</span><br><span> {</span><br><span>     inet_address_t addr_v6 =3D { =
0 };</span><br><span>@@ -1077,7 +1077,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_add=
r_t *addr, int prefixlen)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+net_addr_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, cons=
t in_addr_t *addr, int prefixlen)</span><br><span> {</span><br><span>     i=
net_address_t addr_v4 =3D { 0 };</span><br><span>     char buf[INET_ADDRSTR=
LEN];</span><br><span>@@ -1096,7 +1096,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-net_addr_v6_del(openvpn_net_ctx_t *ctx, const char *iface, const struc=
t in6_addr *addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ne=
t_addr_v6_del(const openvpn_net_ctx_t *ctx, const char *iface, const struct=
 in6_addr *addr,</span><br><span>                 int prefixlen)</span><br>=
<span> {</span><br><span>     inet_address_t addr_v6 =3D { 0 };</span><br><=
span>@@ -1116,7 +1116,7 @@</span><br><span> }</span><br><span> </span><br><=
span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_addr_ptp=
_v4_add(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_addr_ptp_v4_add(=
const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,</s=
pan><br><span>                     const in_addr_t *remote)</span><br><span=
> {</span><br><span>     inet_address_t local_v4 =3D { 0 };</span><br><span=
>@@ -1144,7 +1144,7 @@</span><br><span> }</span><br><span> </span><br><span=
> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_addr_ptp_v4_=
del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+net_addr_ptp_v4_del(cons=
t openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,</span>=
<br><span>                     const in_addr_t *remote)</span><br><span> {<=
/span><br><span>     inet_address_t local_v4 =3D { 0 };</span><br><span>@@ =
-1196,7 +1196,7 @@</span><br><span> }</span><br><span> </span><br><span> in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_route_v4_add(ope=
nvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *=
gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_v4_add=
(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const i=
n_addr_t *gw,</span><br><span>                  const char *iface, uint32_t=
 table, int metric)</span><br><span> {</span><br><span>     const in_addr_t=
 *dst_ptr =3D NULL, *gw_ptr =3D NULL;</span><br><span>@@ -1224,7 +1224,7 @@=
</span><br><span> }</span><br><span> </span><br><span> int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-net_route_v6_add(openvpn_net_ctx_t *ct=
x, const struct in6_addr *dst, int prefixlen,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+net_route_v6_add(const openvpn_net_ctx_t *ctx, co=
nst struct in6_addr *dst, int prefixlen,</span><br><span>                  =
const struct in6_addr *gw, const char *iface, uint32_t table, int metric)</=
span><br><span> {</span><br><span>     inet_address_t dst_v6 =3D { 0 };</sp=
an><br><span>@@ -1275,7 +1275,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_=
route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, c=
onst in_addr_t *gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int pr=
efixlen, const in_addr_t *gw,</span><br><span>                  const char =
*iface, uint32_t table, int metric)</span><br><span> {</span><br><span>    =
 inet_address_t dst_v4 =3D { 0 };</span><br><span>@@ -1301,7 +1301,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-net_route_v6_del(openvpn_net_ctx_t *ctx, c=
onst struct in6_addr *dst, int prefixlen,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+net_route_v6_del(const openvpn_net_ctx_t *ctx, const =
struct in6_addr *dst, int prefixlen,</span><br><span>                  cons=
t struct in6_addr *gw, const char *iface, uint32_t table, int metric)</span=
><br><span> {</span><br><span>     inet_address_t dst_v6 =3D { 0 };</span><=
br><span>@@ -1328,7 +1328,7 @@</span><br><span> </span><br><span> </span><b=
r><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface=
_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const voi=
d *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_ne=
w(const openvpn_net_ctx_t *ctx, const char *iface, const char *type, const =
void *arg)</span><br><span> {</span><br><span>     struct sitnl_link_req re=
q =3D {};</span><br><span>     int ret =3D -1;</span><br><span>@@ -1431,7 +=
1431,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_type(openvpn_net_ct=
x_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+net_iface_type(const openvpn_net_ct=
x_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span=
> {</span><br><span>     struct sitnl_link_req req =3D {};</span><br><span>=
     int ifindex =3D if_nametoindex(iface);</span><br><span>@@ -1463,7 +146=
3,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-net_iface_del(openvpn_net_ctx_t =
*ctx, const char *iface)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+net_iface_del(const openvpn_net_ctx_t *ctx, const char *iface)</span><=
br><span> {</span><br><span>     struct sitnl_link_req req =3D {};</span><b=
r><span>     int ifindex =3D if_nametoindex(iface);</span><br></pre><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=
=3Demail">change 2106</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2106?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2106 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>

</body></html>
--VsD1tnFFW38=--


--===============6215444564029438065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6215444564029438065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6215444564029438065==--

